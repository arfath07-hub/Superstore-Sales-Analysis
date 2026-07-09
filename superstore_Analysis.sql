CREATE DATABASE superstore_db;
use superstore_db;
CREATE TABLE superstore (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(30),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
	Order_Year INT,
    Order_Month VARCHAR(20),
    Order_Quarter INT,
    Shipping_Days INT
);

select * from superstore;

-- Total sales
select sum(sales) as Total_Sales
from superstore;
-- Total profit
select sum(profit) as Total_Profit
from superstore;
-- Total Orders
select count(order_id) as Total_orders
from superstore;
-- Average Sales
select avg(sales) as Average_Sales
from superstore;
-- Average Profit
select avg(profit) as Average_profit
from superstore;
-- Category-wise sales
select category,sum(sales) as Total_sales
from superstore
group by category
order by Total_sales desc;
-- Category_wise profit
select category,sum(profit) as Total_profit
from superstore
group by category
order by Total_profit desc;
-- sub-category wise sales
select sub_category,sum(sales) as Total_sales
from superstore
group by sub_category
order by Total_sales desc;
-- sub-category wise profit
select sub_category,sum(profit) as Total_profit
from superstore
group by sub_category
order by Total_profit desc;
-- region wise sales
select region,sum(sales) as Total_sales
from superstore
group by region
order by Total_sales desc;
-- state-wise sales
select state,sum(sales) as Total_sales
from superstore
group by state
order by Total_sales desc;
-- segment wise profit
select segment,sum(profit) as Total_profit
from superstore
group by segment
order by Total_profit desc;
-- ship mode_ wise sales
select ship_mode ,sum(sales) as Total_sales
from superstore
group by ship_mode
order by Total_sales desc;
-- Top 10 products by sales
select product_name,sum(sales) as Total_sales
from superstore
group by product_name
order by Total_sales desc
limit 10;
-- Top 10 loss making products
select product_name,sum(sales) as Total_sales
from superstore
group by product_name
order by Total_sales 
limit 10;
-- monthly sales
select order_month,sum(sales) as Total_sales
from superstore
group by order_month
order by Total_sales ;
-- quarterly sales
select order_Quarter,sum(sales) as Total_sales
from superstore
group by order_Quarter
order by Total_sales; 
-- Yearly sales
select Order_Year,sum(sales) as Total_sales
from superstore
group by Order_Year
order by Total_sales; 
select * from superstore;
-- Average shipping Days
select avg(shipping_Days) as Avg_shipping_Days
from superstore;
-- sales greater than average
select * from superstore
where sales>(select avg(sales) from superstore);
-- Profit Greater than average
select * from superstore
where profit>(select avg(profit) from superstore);
-- Having clause
select category ,sum(sales) as Total_sales
from superstore
group by category
having sum(sales)>500000;
-- Case statement
select product_name,profit,case
when profit>500 then 'High profit'
when profit>100 then 'Medium profit'
else 'Low profit'
end as Profit_Category
from superstore;
-- Row number()
select product_name,sales,row_number() over(order by sales desc) as row_no
from superstore;
-- rank()
select product_name,sales ,rank() over(order by sales desc) as prod_rank
from superstore;
-- Dense_rank()
select product_name,sales ,dense_rank() over(order by sales desc) as prod_rank
from superstore;
-- common table expression
with categorysales as 
( select category ,sum(sales) as total_sales
from superstore
group by category 
)
select * from categorysales;
-- view 
create view sales_sumary as
select category,sum(sales) as sales,sum(profit) as profit
from superstore
group by category;
select * from sales_sumary;
-- Highest selling product in each category
select * from (
select category,product_name,sales,rank() over(partition by category order by sales desc) as rnk
from superstore) t
where rnk=1;














