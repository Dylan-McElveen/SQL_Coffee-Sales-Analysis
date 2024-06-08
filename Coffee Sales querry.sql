--[VISUALIZATION IN TABLEAU]
SELECT *
FROM [dbo].[customers$],[dbo].[orders$],[dbo].[products$]

--**SWOT ANALYSIS**
--[STRENGTHS]
-- Which coffee sold the most
SELECT Top 3 [Product ID], count(Quantity) AS Coffee_Sold
FROM [dbo].[orders$]
GROUP BY [Product ID]
ORDER BY [Coffee_Sold] Desc  --[A-M-0.5][A-M-1][A-D-0.2] Most Sold Globaly

-- Which coffee yielded the highest profit
SELECT Top 3 o.[Product ID], ceiling(sum(p.Profit)) AS Total_Profit
FROM [dbo].[products$] p
JOIN [dbo].[orders$] o
ON p.[Product ID] = o.[Product ID]
GROUP BY o.[Product ID]
ORDER BY Total_Profit DESC --[L-L-2.5][L-D-2.5][E-M-2.5] Most Profitable

--[WEAKNESSES]
-- Which coffee sold the least
SELECT Top 3 [Product ID], count(Quantity) AS Coffee_Sold
FROM [dbo].[orders$]
GROUP BY [Product ID]
ORDER BY [Coffee_Sold] Asc  --[R-D-1][A-M-0.2][L-M-2.5] Least Sold Globaly

-- Which coffee yielded the lowest profit
SELECT Top 3 o.[Product ID], ceiling(sum(p.Profit)) AS Total_Profit
FROM [dbo].[products$] p
JOIN [dbo].[orders$] o
ON p.[Product ID] = o.[Product ID]
GROUP BY o.[Product ID]
ORDER BY Total_Profit ASC --[R-M-0.2][A-M-0.2][R-D-0.2] Least Profitable

--**CUSTOMER SEGEMENTATION**
SELECT * 
FROM [dbo].[customers$]

-- Each Country's Popular Choice
SELECT c.Country, Max(o.[Product ID])
FROM [dbo].[customers$] c
JOIN [dbo].[orders$] o ON c.[Customer ID] = o.[Customer ID]
GROUP BY Country          --[R-M-2.5] Most Popular By All Country's

-- What percentage of customers have a Loyalty Card
SELECT [Loyalty Card], (Cast(count(*) AS float) /1000) * 100
FROM [dbo].[customers$]
WHERE [Loyalty Card] = 'yes'
GROUP BY [Loyalty Card]             --48.7% of customers own a Loyalty Card

-- What percentage of customers don't have a Loyalty Card
SELECT [Loyalty Card], (Cast(count(*) AS float) /1000) * 100
FROM [dbo].[customers$]
WHERE [Loyalty Card] = 'no'
GROUP BY [Loyalty Card]             --51.3% of customers do not own a Loyalty Card

-- How many customers are in each country
SELECT Country, count(Country) AS Number_of_Sales_By_Country
FROM [dbo].[customers$]
GROUP BY Country
ORDER BY Number_of_Sales_By_Country DESC