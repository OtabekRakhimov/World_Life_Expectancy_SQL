# Data Exploratory Analysis

SELECT * FROM worldlifexpectancy;

# Life Expectancy Change per Country
SELECT Country, MIN(Lifeexpectancy),  MAX(Lifeexpectancy),
ROUND(MAX(Lifeexpectancy) - MIN(Lifeexpectancy), 1) AS Life_Increase_15_Years
FROM worldlifexpectancy
GROUP BY Country
HAVING  MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY Life_Increase_15_Years ASC
;

# AVG Life Expectancy Over Time
SELECT Year, ROUND(AVG(Lifeexpectancy),2)
FROM worldlifexpectancy
WHERE  Lifeexpectancy <> 0
AND Lifeexpectancy <> 0
GROUP BY Year
ORDER BY Year
;

# AVG Life Expectancy and GDP by Country 
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM worldlifexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;


# Life Expectancy Comparison by GDP Level
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) HIGH_GDP_COUNT,
AVG(CASE WHEN GDP >= 1500 THEN Lifeexpectancy ELSE NULL END) HIGH_GDP_LIFE_EXPECTANCY,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) LOW_GDP_COUNT,
AVG(CASE WHEN GDP <= 1500 THEN Lifeexpectancy ELSE NULL END) LOW_GDP_LIFE_EXPECTANCY
FROM worldlifexpectancy
;


# Life Expectancy by Status
SELECT Status, ROUND(AVG(Lifeexpectancy),1)
FROM worldlifexpectancy
GROUP BY Status
;


# Country Count by Status
SELECT Status, COUNT(DISTINCT Country)
FROM worldlifexpectancy
GROUP BY Status
;


# AVG Life Expectancy and BMI by Country
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM worldlifexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;


# Adult Mortality for Countries with "United"
SELECT Country, 
Year, 
Lifeexpectancy, 
AdultMortality, 
SUM(AdultMortality) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM worldlifexpectancy
WHERE Country LIKE '%United%'
;

