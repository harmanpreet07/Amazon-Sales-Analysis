use diwalisales

select * 
from amazon_sales

select count(order_id) as total_orders
from amazon_sales 

select sum(total_sales_inr) as total_sales
from amazon_sales



select top 5 product_category, sum(total_sales_inr) as total_sales
from amazon_sales
group by Product_Category
order by total_sales desc



select product_category, avg(review_rating) as avg_rating
from amazon_sales
group by Product_Category
order by avg_rating desc


select state, count(order_id) as orders
from amazon_sales
group by state
order by orders desc

select product_name, sum(quantity) as total_quantity_sold
from amazon_sales
group by product_name
order by total_quantity_sold desc



select top 5 Customer_ID, sum(Total_Sales_INR) as total_spent
from amazon_sales
group by Customer_ID
order by total_spent desc



SELECT
    Payment_Method,
    COUNT(*) AS total_orders,
    ROUND((COUNT(*) * 100 / (SELECT COUNT(*) FROM Amazon_Sales)), 2)
        AS percentage_of_orders
FROM Amazon_Sales
GROUP BY Payment_Method
ORDER BY percentage_of_orders DESC;


select Order_ID 
from amazon_sales
where Delivery_Status = 'Returned';



select Product_Category, round(count(*) * 100.0 / 
(select count(Order_ID) from amazon_sales),2) as total_percent
from amazon_sales
where Delivery_Status = 'returned'
group by Product_Category
order by total_percent desc;



WITH category_sales AS (
    SELECT
        Product_Category,
        Product_Name,
        SUM(Total_Sales_INR) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY Product_Category
            ORDER BY SUM(Total_Sales_INR) DESC
        ) AS sales_rank
    FROM amazon_sales
    GROUP BY Product_Category, Product_Name
)
SELECT *
FROM category_sales
WHERE sales_rank <= 3
ORDER BY Product_Category, sales_rank;



with customer_total as (
select customer_id, sum(total_sales_inr) as total_spent
from amazon_sales
group by Customer_ID),
avg_total as(
select avg(total_spent) avg_totals from customer_total)
select c.customer_id,
 c.total_spent
 from customer_total c
 cross join avg_total a
 where c.total_spent > a.avg_totals
 order by c.total_spent desc;



 select state, avg(Review_Rating) as avg_rating , 
                   rank() over(order by avg(review_rating) desc) as ranking
 from amazon_sales
 group by state
 order by ranking ;





 
 