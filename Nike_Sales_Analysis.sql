CREATE DATABASE Nike_db;
USE Nike_db; 
DROP TABLE IF EXISTS nike_sales;

CREATE TABLE nike_sales
(
    sale_date DATE,	
	Product VARCHAR(35),
    Region VARCHAR(35),
    Retailer VARCHAR(35),	
    Sales_method VARCHAR(45),
    State VARCHAR(45),
    Price_per_unit FLOAT,	
    Total_sales FLOAT,
	Units_sold INT
);
SELECT * FROM nike_sales;

#-----------------------------------------------Total sales revenue per month---------------------------------------------------------------------

SELECT DATE_FORMAT(sale_date, '%Y-%m') AS Month, SUM(Total_sales) AS Total_Revenue
FROM nike_sales
GROUP BY Month
ORDER BY Month;

#-----------------------------------------------Product line with highest total sales-------------------------------------------------------------

SELECT Product, SUM(Total_sales) AS Total_Revenue
FROM nike_sales
GROUP BY Product
ORDER BY Total_Revenue  DESC
LIMIT 1;

#-----------------------------------------------Region with the highest total revenue---------------------------------------------------------------
SELECT Region, SUM(Total_sales) AS Total_Revenue
FROM nike_sales
GROUP BY Region
ORDER BY Total_Revenue DESC;

#------------------------------------------------Top 5 best-selling products by units sold------------------------------------------------------------

SELECT Product, SUM(Units_sold) AS Total_Units
FROM nike_sales
GROUP BY Product
ORDER BY Total_Units DESC
LIMIT 5;

#---------------------------------------------State contributing most to total sales------------------------------------------------------------------

SELECT State, SUM(Total_sales) AS Total_Revenue
FROM nike_sales
GROUP BY State
ORDER BY Total_Revenue DESC;

#-----------------------------------------Retailer with highest average revenue per transaction-------------------------------------------------------

SELECT Retailer, ROUND(AVG(Total_sales), 2) AS Avg_Revenue_Per_Transaction
FROM nike_sales
GROUP BY Retailer
ORDER BY Avg_Revenue_Per_Transaction DESC;

#------------------------------------------Compare total sales between in-store and online per region-------------------------------------------------

SELECT Region, Sales_method, SUM(Total_sales) AS Total_Revenue
FROM nike_sales
GROUP BY Region, Sales_method
ORDER BY Region, Total_Revenue DESC;

#---------------------------------------------------Peak month for sales and units sold---------------------------------------------------------------

SELECT DATE_FORMAT(sale_date, '%Y-%m') AS Month, 
       SUM(Total_sales) AS Total_Revenue, 
       SUM(Units_sold) AS Total_Units
FROM nike_sales
GROUP BY Month
ORDER BY Total_Revenue DESC
LIMIT 1;

#---------------------------------------------------------Region with most units sold for Women’s Athletic Footwear------------------------------------
SELECT Region, SUM(Units_sold) AS Total_Units
FROM nike_sales
WHERE Product = 'Women''s Athletic Footwear'
GROUP BY Region
ORDER BY Total_Units DESC;

#--------------------------------------------------State-wise average price per unit-------------------------------------------------------------------
SELECT State, AVG(Price_per_unit) AS Avg_Unit_Price
FROM nike_sales
GROUP BY State
ORDER BY Avg_Unit_Price DESC;

#--------------------------------------------------Monthly unit sales trend for Men's Apparel----------------------------------------------------------

SELECT DATE_FORMAT(sale_date, '%Y-%m') AS Month, 
       SUM(Units_sold) AS Total_Units
FROM nike_sales
WHERE Product = 'Men''s Apparel'
GROUP BY Month
ORDER BY Month;

#-------------------------------------------------Total sales and units sold per sales method----------------------------------------------------------
SELECT Sales_method, 
       SUM(Total_sales) AS Total_Revenue,
       SUM(Units_sold) AS Total_Units
FROM nike_sales
GROUP BY Sales_method;

#------------------------------------------------Retailers selling mostly online vs. in-store---------------------------------------------------------

SELECT Retailer, Sales_method, COUNT(*) AS Transactions
FROM nike_sales
GROUP BY Retailer, Sales_method
ORDER BY Retailer,Transactions DESC ;