/*
Kyle SHannon SQLZOO Code - Jan 2016
*/


#################### --------SELECT basics-------- ####################
/*
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
....
*/

/* 1.  The example uses a WHERE clause to show the population of 'France'. Note
that strings (pieces of text that are data) should be in 'single quotes'; Modify
it to show the population of Germany*/

SELECT population FROM world
  WHERE name = 'Germany'

/* 2.  The query shows the name and population density for each country where
the area is over 5,000,000 km2. Population density is not a column in the World
table, but we can calculate it as population/area. Modify it to show the name
and per capita gdp: gdp/population for each country where the area is over
5,000,000 km2*/

SELECT name, gdp/population FROM world
  WHERE area > 5000000

/* 3.  Checking a list The word IN allows us to check if an item is in a list.
The example shows the name and population for the countries 'Luxembourg',
'Mauritius' and 'Samoa'.
Show the name and the population for 'Ireland', 'Iceland' and 'Denmark'.*/

SELECT name, population FROM world
  WHERE name IN ('Ireland', 'Iceland', 'Denmark');

/* 4. Which countries are not too small and not too big? BETWEEN allows range
checking (range specified is inclusive of boundary values). The example below
shows countries with an area of 250,000-300,000 sq. km. Modify it to show the
country and the area for countries with an area between 200,000 and 250,000.*/

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

################## --------SELECT from WORLD Tutorial-------- ##################

/* 1. Read the notes about this table. Observe the result of running a simple
SQL command.*/

SELECT name, continent, population FROM world

/* 2. How to use WHERE to filter records. Show the name for the countries that
have a population of at least 200 million. 200 million is 200000000, there are
eight zeros.*/

SELECT name FROM world
WHERE population >= 200000000

/* 3. Give the name and the per capita GDP for those countries with a population
of at least 200 million.*/

SELECT name, gdp/population AS 'per capita GDP'
FROM world
WHERE population >= 200000000;

/* 4. Show the name and population in millions for the countries of the
continent 'South America'. Divide the population by 1000000 to get population in
millions.*/

SELECT name, population/1000000 AS pop_in_millions
FROM world
WHERE continent = 'South America';

/* 5. Show the name and population for France, Germany, Italy*/

SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

/* 6. Show the countries which have a name that includes the word 'United'*/

SELECT name
FROM world
WHERE name LIKE '%United%';

/* 7. Two ways to be big: A country is big if it has an area of more than 3
million sq km or it has a population of more than 250 million. Show the
countries that are big by area or big by population. Show name, population and
area.*/

SELECT name, population, area
FROM world
WHERE area > 3000000
OR population > 250000000;

/* 8. USA, India, and China are big in population and big by area. Exclude these
countries. Show the countries that are big by area or big by population but not
both. Show name, population and area*/

SELECT name, population, area
FROM world
WHERE (area > 3000000 OR population > 250000000)
AND NOT (area > 3000000 AND population > 250000000);

/* 9. Show the name and population in millions and the GDP in billions for the
countries of the continent 'South America'. Use the ROUND function to show the
values to two decimal places. For South America show population in millions and
GDP in billions to 2 decimal places.*/

SELECT 
   name, 
   ROUND(population/1000000,2) AS pop_in_millions, 
   ROUND(gdp/1000000000,2) AS gdp_in_billions
FROM world
WHERE continent = 'South America'

/* 10. Show the per-capita GDP for those countries with a GDP of at least one
trillion (1000000000000; that is 12 zeros). Round this value to the nearest
1000. Show per-capita GDP for the trillion dollar countries to the nearest
$1000.*/

SELECT
   name AS "trillion_doller_countries",
   ROUND(gdp/population,-3) AS "per_capita_gdp"
FROM world
WHERE gdp >= 1000000000000;

/* 11. The CASE statement shown is used to substitute North America for
Caribbean in the third column. Show the name - but substitute Australasia for
Oceania - for countries beginning with N.*/

SELECT name,
CASE
	WHEN continent='Oceania' THEN 'Australasia'
        ELSE continent END
FROM world
WHERE name LIKE 'N%'

/* 12. Show the name and the continent - but substitute Eurasia for Europe and
Asia; substitute America - for each country in North America or South America or
Caribbean. Show countries beginning with A or B*/

SELECT name,
CASE 
	WHEN continent in ('Europe', 'Asia') 
     	THEN 'Eurasia'
    WHEN continent in ('North America', 'South America', 'Caribbean') 
        THEN 'America'
    ELSE continent END AS continent
FROM world
WHERE
     name LIKE 'a%' OR name LIKE 'b%'

/* 13. Put the continents right... Oceania becomes Australasia Countries in
Eurasia and Turkey go to Europe/Asia Caribbean islands starting with 'B' go to
North America, other Caribbean islands go to South America Show the name, the
original continent and the new continent of all countries.*/

SELECT name, continent,
CASE 
   WHEN continent='Oceania' THEN 'Australasia'
   WHEN continent='Eurasia' OR name='Turkey' THEN 'Europe/Asia'
   WHEN continent='Caribbean' AND name LIKE 'B%' THEN 'North America'   
   WHEN continent='Caribbean' THEN 'South America'   
   ELSE continent END AS revised_continent
   
FROM world
ORDER BY name --no idea why this is needed, grader must be broken...


################## --------SELECT from Nobel Tutorial-------- ##################

/* 1. Change the query shown so that it displays Nobel prizes for 1950. */

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

/* 2. Show who won the 1962 prize for Literature. */

SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature'

/* 3. Show the year and subject that won 'Albert Einstein' his prize. */

SELECT yr AS year, subject
FROM nobel
WHERE winner = 'Albert Einstein'

/* 4. Give the name of the 'Peace' winners since the year 2000, including 
2000. */

SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

/* 5. Show all details (yr, subject, winner) of the Literature prize winners 
for 1980 to 1989 inclusive. */

SELECT *
FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

/* 6. Show all details of the presidential winners */

SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                 'Woodrow Wilson',
                 'Jimmy Carter')

/* 7. Show the winners with first name John */

SELECT winner
FROM nobel
WHERE winner LIKE 'john%'

/* 8. Show the Physics winners for 1980 together with the Chemistry winners
for 1984. */

SELECT *
FROM nobel
WHERE subject = 'Physics' AND yr = 1980
    OR subject = 'Chemistry' AND yr = 1984

/* 9. Show the winners for 1980 excluding the Chemistry and Medicine */

SELECT *
FROM nobel
WHERE yr = 1980 AND subject <> 'Chemistry' AND subject != 'Medicine'
--in SQLZOO you can use <> and != for not equal

/* 10. Show who won a 'Medicine' prize in an early year (before 1910, not 
including 1910) together with winners of a 'Literature' prize in a later 
year (after 2004, including 2004) */

SELECT *
FROM nobel
WHERE subject = 'medicine' AND yr < 1910
    OR subject = 'literature' AND yr >= 2004

/* 11. Find all details of the prize won by PETER GRÜNBERG */

SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG' -- Non-ASCII characters? still question here..

/* 12. Find all details of the prize won by EUGENE O'NEILL */

SELECT *
FROM nobel
WHERE winner = "eugene o'neill" --escape single ' inside double "

/* 13. Knights in order. List the winners, year and subject where the winner
 starts with Sir. Show the the most recent first, then by name order. */

SELECT winner, yr, subject
FROM nobel 
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner

/* 14. The expression subject IN ('Chemistry','Physics') can be used as a 
value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; 
but list Chemistry and Physics last. */

SELECT winner, subject, subject IN ('Physics','Chemistry') AS 'Phys or Chem'
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner
-- order by 0/1 first then by subject then recipient's name within subject

################ --------SELECT within SELECT Tutorial-------- ################

/*
This tutorial looks at how we can use SELECT statements within SELECT statements
to perform more complex queries.

name  continent area  population  gdp
Afghanistan Asia  652230  25500100  20343000000
Albania Europe  28748 2831741 12960000000
Algeria Africa  2381741 37100000  188681000000
Andorra Europe  468 78115 3712000000
Angola  Africa  1246700 20609294  100990000000
...
*/

/* 1. List each country name where the population is larger than that 
of 'Russia'. */ 
SELECT name 
FROM world
WHERE population >
    (SELECT population 
     FROM world
     WHERE name='russia')

/* 2. Show the countries in Europe with a per capita GDP greater than 
'United Kingdom'  */ 

SELECT name
FROM world
WHERE continent = 'europe'
AND gdp/population >
   (SELECT gdp/population FROM world WHERE  name = 'united kingdom' )

/* 3. List the name and continent of countries in the continents containing 
either Argentina or Australia. Order by name of the country.  */ 

SELECT name, continent
FROM world
WHERE continent IN 
     (SELECT continent 
      FROM world 
      WHERE name = 'argentina' OR name = 'australia')
ORDER BY name

/* 4. Which country has a population that is more than Canada but less than 
Poland? Show the name and the population. */ 

SELECT name, population
FROM world
WHERE population >
(SELECT population FROM world WHERE name = 'canada')
AND population <
(SELECT population FROM world WHERE name = 'poland')

/* 5. Germany (population 80 million) has the largest population of the 
countries in Europe. Austria (population 8.5 million) has 11% of the 
population of Germany.

Show the name and the population of each country in Europe. Show the 
population as a percentage of the population of Germany. */ 

SELECT name, 
     CONCAT(ROUND((population /
          (SELECT population 
           FROM world 
           WHERE name = 'germany') * 100), 0), '%') AS '% of Germany'
FROM world
WHERE continent = 'europe'
--possibly save the germany population as a variable to use...

/* 6. Which countries have a GDP greater than every country in Europe? [Give 
the name only.] (Some countries may have NULL gdp values)  */ 

SELECT name
FROM world
WHERE gdp > ALL (SELECT gdp
                 FROM world
                 WHERE continent = 'europe' AND gdp > 0)

/* 7. Find the largest country (by area) in each continent, show the continent,
the name and the area: */ 

SELECT continent, name, area 
FROM world x
WHERE area >= ALL
    (SELECT MAX(area)
     FROM world y
     WHERE y.continent=x.continent AND population>0)
     --comparing 1 : 1 here

/* 8. List each continent and the name of the country that comes first 
alphabetically. */ 

SELECT continent, name
FROM world x
WHERE name =
     (SELECT name
      FROM world y
      WHERE y.continent = x.continent
      ORDER BY name
      LIMIT 1)

/* 9. Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries associated with these continents. Show 
name, continent and population. */ 

SELECT name, continent, population
FROM world
WHERE continent NOT IN
      (SELECT DISTINCT continent 
       FROM world
       WHERE population >= 25000000)

/* 10. Some countries have populations more than three times that of any of 
their neighbours (in the same continent). Give the countries and continents. */ 

SELECT name, continent
FROM world x
WHERE population > ALL
      (SELECT population * 3
       FROM world y
       WHERE y.continent = x.continent AND y.name <> x.name)
      --includes <> name because if you do not have this then it will 3* its own
      --thus leaving you with no results cause each country will always battle
      --itself at 3 * its population.

################### --------SUM and COUNT Tutorial-------- #####################

/* 1. Show the total population of the world. */

SELECT SUM(population) AS 'world pop.'
FROM world

/* 2. List all the continents - just once each. */

SELECT DISTINCT continent
FROM world

/* 3. Give the total GDP of Africa */

SELECT SUM(gdp) AS gdp_total
FROM world
WHERE continent = 'africa'

/* 4. How many countries have an area of at least 1000000 */

SELECT COUNT(name)
FROM world
WHERE area >= 1000000

/* 5. What is the total population of ('France','Germany','Spain') */

SELECT SUM(population) AS pop_total
FROM world
WHERE name IN ('France','Germany','Spain')

/* 6. For each continent show the continent and number of countries */

SELECT continent, COUNT(name)
FROM world
GROUP BY continent

/* 7. For each continent show the continent and number of countries with 
populations of at least 10 million. */

SELECT continent, COUNT(continent) AS number
FROM world
WHERE population >= 10000000
GROUP BY continent

/* 8. List the continents that have a total population of at least 
100 million. */

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000

##################### --------The JOIN operation-------- #######################
/*
                      game
id  mdate stadium team1 team2
1001  8 June 2012 National Stadium, Warsaw  POL GRE
1002  8 June 2012 Stadion Miejski (Wroclaw) RUS CZE
1003  12 June 2012  Stadion Miejski (Wroclaw) GRE CZE
1004  12 June 2012  National Stadium, Warsaw  POL RUS

                      goal
matchid teamid  player  gtime
1001  POL Robert Lewandowski  17
1001  GRE Dimitris Salpingidis  51
1002  RUS Alan Dzagoev  15
1001  RUS Roman Pavlyuchenko  82

                      eteam
id  teamname  coach
POL Poland  Franciszek Smuda
RUS Russia  Dick Advocaat
CZE Czech Republic  Michal Bilek
GRE Greece  Fernando Santos
*/

/* 1. show the matchid and player name for all goals scored by Germany. To 
identify German players, check for: teamid = 'GER'  */

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'

/* 2. Show id, stadium, team1, team2 for just game 1012  */

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012

/* 3. The code below shows the player (from the goal) and stadium name (from 
the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate and for every 
German goal.  */

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'

/* 4. Show the team1, team2 and player for every goal scored by a player called
Mario player LIKE 'Mario%'  */

SELECT team1, team2, player
FROM game JOIN goal on (id=matchid)
WHERE player LIKE 'MARIO%'

/* 5. Show player, teamid, coach, gtime for all goals scored in the first 
10 minutes gtime<=10  */

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (teamid=id) 
WHERE gtime<=10

/* 6. List the the dates of the matches and the name of the team in which 
'Fernando Santos' was the team1 coach.  */

SELECT mdate, teamname
FROM eteam JOIN game ON (eteam.id=team1)
WHERE coach = 'Fernando Santos'

/* 7. List the player for every goal scored in a game where the stadium 
was 'National Stadium, Warsaw'  */

SELECT player
FROM goal JOIN game ON (matchid=id)
WHERE stadium = 'National Stadium, Warsaw'

/* 8. show the name of all players who scored a goal against Germany.  */

SELECT DISTINCT(player)
FROM game JOIN goal ON (matchid=id) 
WHERE teamid != 'GER'
  AND (team1='GER' OR team2='GER')

/* 9. Show teamname and the total number of goals scored.  */

SELECT teamname, COUNT(teamid) AS goals
FROM eteam JOIN goal ON id=teamid
GROUP BY teamid
ORDER BY goals

/* 10. Show the stadium and the number of goals scored in each stadium.  */

SELECT stadium, COUNT(matchid) AS goals
FROM game JOIN goal ON (id=matchid)
GROUP BY stadium
ORDER BY goals

/* 11. For every match involving 'POL', show the matchid, date and the number 
of goals scored.
  */

SELECT matchid, mdate, COUNT(matchid) AS goals
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid

/* 12. For every match where 'GER' scored, show matchid, match date and the 
number of goals scored by 'GER'
  */

SELECT matchid, mdate, COUNT(matchid)
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'
GROUP BY matchid

/* 13.  List every match with the goals scored by each team as shown. This 
will use "CASE WHEN" which has not been explained in any previous exercises.
 */

SELECT game.mdate AS date,
  game.team1 AS 'home team',
  SUM(CASE 
       WHEN goal.teamid = game.team1 
       THEN 1 
       ELSE 0 
      END) 'home score',
  game.team2 AS 'away team',
  SUM(CASE 
       WHEN goal.teamid = game.team2 
       THEN 1 
       ELSE 0 
      END) 'away score'
FROM game JOIN goal ON goal.matchid = game.id
GROUP BY date, 'home team', 'away team'
ORDER BY date, matchid, 'home team', 'away team'




