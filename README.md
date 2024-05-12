# SharkTankDataDive
Explore Shark Tank investments with SQL. Uncover insights, success rates, and industry preferences.
Based on the SQL script provided, here are the problem statements and their corresponding solutions:

# Problem Statement 1: 
Determine the total number of episodes in Season 1.
# Solution 1 : 
Use the `MAX` function to find the highest episode number and the `COUNT DISTINCT` function to count unique episodes.
   ```sql
   -- Total number of episodes
   SELECT MAX(ep_no) FROM shark_data;
   SELECT COUNT(DISTINCT ep_no) FROM shark_data;
   ```

# Problem Statement 2: 
Calculate the conversion rate of pitches to deals in Season 1.
# Solution 2 : 
Count the number of pitches that resulted in an investment and divide by the total number of pitches.
   ```sql
   -- Conversion rate of pitches to deals
   SELECT CAST(SUM(a.converted_not_converted) AS FLOAT) / CAST(COUNT(*) AS FLOAT) FROM (
       SELECT amount_invested_lakhs, CASE WHEN amount_invested_lakhs > 0 THEN 1 ELSE 0 END AS converted_not_converted FROM shark_data
   ) a;
   ```

# Problem Statement 3: 
Analyze the gender distribution of entrepreneurs in Season 1.
# Solution 3 : 
Sum the total number of male and female participants and calculate the gender ratio.
   ```sql
   -- Gender distribution analysis
   SELECT SUM(male) FROM shark_data;
   SELECT SUM(female) FROM shark_data;
   SELECT SUM(female) / SUM(male) FROM shark_data;
   ```

# Problem Statement 4: 
Identify the startup with the highest investment in each sector for Season 1.
# Solution 4 : 
Rank startups within each sector by the amount invested and select the top-ranked startup per sector.
   ```sql
   -- Startup with the highest investment per sector
   SELECT c.* FROM (
       SELECT brand, sector, amount_invested_lakhs, RANK() OVER (PARTITION BY sector ORDER BY amount_invested_lakhs DESC) rnk 
       FROM shark_data
   ) c
   WHERE c.rnk = 1;
   ```

