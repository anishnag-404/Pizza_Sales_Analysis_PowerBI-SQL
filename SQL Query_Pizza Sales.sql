SELECT * FROM pizza_sales;

/* 1.	Total Revenue */
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

/* 2.	Average Order Value */
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_value FROM pizza_sales;

/* 3.	Total Pizzas Sold */
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

/* 4.	Total Orders */
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

/* 5.	Average Pizzas Per Order */
SELECT CAST(CAST(SUM(quantity) AS decimal(10,2))/CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) AS Average_Pizzas_Per_Order FROM pizza_sales;


/* 1.	Daily Trend for Total Orders: */
SELECT DATENAME(DW,order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

/* 2.	Monthly Trend for Total Orders */
SELECT DATENAME(MONTH,order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Orders DESC;

/* 3.	Percentage of Sales by Pizza Category: */
SELECT pizza_category,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

/* 5.	Total Pizzas Sold by Pizza Category: */
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

/* 4.	Percentage of Sales by Pizza Size: */
SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;


SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date) = 1) AS decimal(10,2)) AS PCT FROM pizza_sales
WHERE DATEPART(QUARTER,order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

/* 6.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders */
--Total Revenue
SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

--Total Quantity
SELECT TOP 5 pizza_name,SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

--Total Orders
SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


/* 7.	Bottom 5 Worst Sellers by Revenue, Total Quantity and Total Orders */
--Total Revenue
SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

--Total Quantity
SELECT TOP 5 pizza_name,SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

--Total Orders
SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;