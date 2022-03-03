
USE superstores;
/*1. Write a query to display the Customer_Name and Customer Segment using alias 
name “Customer Name", "Customer Segment" from table Cust_dimen. */

SELECT Customer_Name "Customer Name",  Customer_Segment "Customer Segment" 
	FROM  Cust_dimen;
    
    /*2. Write a query to find all the details of the customer from the table cust_dimen 
order by desc*/

select * from cust_dimen 
order by customer_name desc;

/*3. Write a query to get the Order ID, Order date from table orders_dimen where 
‘Order Priority’ is high.*/

select Order_ID, order_DATE
From orders_dimen
where order_priority like 'high';

/*4. Find the total and the average sales (display total_sales and avg_sales) */

select sum(sales), avg(sales)
from market_fact;

/*5. Write a query to get the maximum and minimum sales from maket_fact table.*/

select max(sales), min(sales)
from market_fact;

/*6. Display the number of customers in each region in decreasing order of 
no_of_customers. The result should contain columns Region, no_of_customers.*/


select Region, count(Cust_id) as "No. of Customers"
from cust_dimen
group by Region
order by count(Cust_id);

/*7. Find the region having maximum customers (display the region name and 
max(no_of_customers)*/

select Region, count(Cust_id) as "No. of Customers"
from cust_dimen
group by Region
order by count(Cust_id)desc
limit 1;

/*8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
and the number of tables purchased (display the customer name, no_of_tables 
purchased)*/

select c.Region as "Region", c.Customer_Name as "Customer Name", 
p.Product_Sub_Category as "Product Sub Category", 
        sum(m.Order_Quantity) as "Order Quantity"
from market_fact m 
join cust_dimen c on m.Cust_id = c.Cust_id
join prod_dimen p on m.Prod_id = p.Prod_id
where c.Region = "ATLANTIC" and p.Product_Sub_Category = "TABLES"
group by c.Customer_Name
Order by sum(m.Order_Quantity) DESC;

/*9. Find all the customers from Ontario province who own Small Business. (display 
the customer name, no of small business owners)*/

select Customer_Name,count(Customer_Name) 
as 'number_of_small_business' from cust_dimen 
where Province='Ontario' and Customer_Segment='SMALL BUSINESS'
group by Customer_Name;


/*10. Find the number and id of products sold in decreasing order of products sold 
(display product id, no_of_products sold) */

select Prod_id, count(prod_id)as "No. of of product sold"
from market_fact
group by prod_id
order by sales desc
;

/*11. Display product Id and product sub category whose produt category belongs to 
Furniture and Technlogy. The result should contain columns product id, product 
sub category*/

select Prod_id, Product_sub_category
from prod_dimen
where product_category ='furniture'
or
product_category='technology';


/*12. Display the product categories in descending order of profits (display the product 
category wise profits i.e. product_category, profits)?*/

select product_category, profit from superstores.prod_dimen as a
inner join 
superstores.market_fact as b
on a.Prod_id=b.Prod_id
group by Product_Category order by Profit desc;

/*13. Display the product category, product sub-category and the profit within each 
subcategory in three columns. */

select p.Product_Category as "Product Category", p.Product_Sub_Category as "Product Sub Category",
		round(sum(m.Profit), 2) as "Total Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Sub_Category
Order by p.Product_Category;


/*14. Display the order date, order quantity and the sales for the order.*/
SELECT orders_dimen.Order_Date, market_fact.Order_Quantity, market_fact.Sales
FROM orders_dimen
INNER JOIN market_fact ON orders_dimen.ord_id = market_fact.ord_id;


/*15. Display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’*/
 
 SELECT Customer_name FROM cust_dimen
WHERE Customer_Name LIKE '_R_D%';


/*16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and 
their region where sales are between 1000 and 5000.
*/

SELECT cust_dimen.Cust_id , 
cust_dimen.Customer_Name, 
cust_dimen.Region, 
market_fact.Sales FROM cust_dimen,market_fact
WHERE market_fact.Sales BETWEEN 1000 AND 5000;


/*17. Write a SQL query to find the 3rd highest sales*/

SELECT sales, ord_id
FROM `market_fact` ORDER BY `sales` DESC LIMIT 1 OFFSET 3;

/*18. Where is the least profitable product subcategory shipped the most? For the least 
profitable product sub-category, display the region-wise no_of_shipments and the */

select r.Region as "Region",count(m.Ship_id) as "Number of Shipments", 
round(sum(m.Profit),2) as "Profit in each region"
from market_fact m 
join cust_dimen r on m.Cust_id = r.Cust_id
join prod_dimen p on m.Prod_id = p.Prod_id
Where Product_Sub_Category = (
Select p.Product_Sub_Category from market_fact m 
join prod_dimen p on m.Prod_id = p.Prod_id
	group by Product_Sub_Category
	order by sum(m.Profit)
LIMIT 1) 
group by r.Region
order by sum(m.Profit);


