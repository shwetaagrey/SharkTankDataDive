create database shark;

use shark;

select * from shark_data;

-- total episodes

select max(ep_no) from shark_data;
select count(distinct ep_no) from shark_data;

-- pitches 

select count(distinct brand) from shark_data;

-- pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select amount_invested_lakhs , case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from shark_data) a;

-- total male

select sum(male) from shark_data;

-- total female

select sum(female) from shark_data;

-- gender ratio

select sum(female)/sum(male) from shark_data;

-- total invested amount

select sum(amount_invested_lakhs) from shark_data;

-- avg equity taken

select avg(a.equity_taken) from
(select * from shark_data where equity_taken>0) a

-- highest deal taken

select max(amount_invested_lakhs) from shark_data;


-- higheest equity taken

select max(equity_taken) from shark_data;

-- startups having at least women

SELECT SUM(a.female_count) AS startups_with_women
FROM (
    SELECT 
        female,
        CASE WHEN female > 0 THEN 1 ELSE 0 END AS female_count 
    FROM 
        shark_data
) a
HAVING SUM(a.female_count) > 0;

-- pitches converted having atleast ne women

select sum(b.female_count) 
from(
     select case when a.female>0 then 1 else 0 end as female_count ,a.*
from (
        (select * from shark_data where deal!='No Deal')) a)b

-- avg team members

select avg(team_members) from shark_data;

-- amount invested per deal

select avg(a.amount_invested_lakhs) amount_invested_per_deal from
(select * from shark_data where deal!='No Deal') a

-- avg age group of contestants

select avg_age,count(avg_age) cnt from shark_data group by avg_age order by cnt desc

-- location group of contestants

select location,count(location) cnt from shark_data group by location order by cnt desc

-- sector group of contestants

select sector,count(sector) cnt from shark_data group by sector order by cnt desc


-- partner deals

select partners,count(partners) cnt from shark_data where partners!='-' group by partners order by cnt desc

-- making the matrix


select * from shark_data

select 'Ashnner' as keyy,count(ashneer_amount_invested) from shark_data where ashneer_amount_invested is not null


select 'Ashnner' as keyy,count(ashneer_amount_invested) from shark_data where ashneer_amount_invested is not null AND ashneer_amount_invested!=0

SELECT 'Ashneer' as keyy,SUM(C.ASHNEER_AMOUNT_INVESTED),AVG(C.ASHNEER_EQUITY_TAKEN) 
FROM (SELECT * FROM shark_data WHERE ASHNEER_EQUITY_TAKEN !=0 AND ASHNEER_EQUITY_TAKEN IS NOT NULL) C


SELECT 
    'Ashneer' AS keyy,
    COUNT(CASE WHEN ashneer_amount_invested IS NOT NULL THEN 1 END) AS total_deals_present,
    COUNT(CASE WHEN ashneer_amount_invested != 0 THEN 1 END) AS total_deals,
    SUM(ASHNEER_AMOUNT_INVESTED) AS total_amount_invested,
    AVG(CASE WHEN ASHNEER_EQUITY_TAKEN != 0 AND ASHNEER_EQUITY_TAKEN IS NOT NULL THEN ASHNEER_EQUITY_TAKEN END) AS avg_equity_taken
FROM 
    shark_data
WHERE 
    ashneer_amount_invested IS NOT NULL;


-- which is the startup in which the highest amount has been invested in each domain/sector

select c.* from 
(select brand,sector,amount_invested_lakhs,rank() over(partition by sector order by amount_invested_lakhs desc) rnk 

from shark_data) c

where c.rnk= 1