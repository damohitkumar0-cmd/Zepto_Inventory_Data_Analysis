drop table if exists zepto;

create table zepto(
sku_id serial primary key,
category varchar(150),
name varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity integer,
discountSellingPrice numeric(8,2),
weightgms integer,
outofstock boolean,
quantity integer
);

-- data exploration --

-- count of rows --
select count(*) from zepto;

-- sample data --
select * from zepto limit(10);

-- null values --
select * from zepto
where name is null or mrp is null or discountpercent is null or availablequantity is null
or discountsellingprice is null or weightgms is null or outofstock is null or quantity is null;

-- different product categories --
select distinct category
from zepto order by category;

-- product in stock vs out of stock --
select outofstock, count(sku_id) from zepto
group by outofstock;

-- product bame present multiple times --
select name, count(sku_id) as "Number of SKUS"
from zepto group by name having count(sku_id)>1
order by count(sku_id) desc;

-- DATA CLEANING --

-- products with price = 0 --
select * from zepto
where mrp = 0 or discountsellingprice=0;

-- Delete from zepto (Zero mrp) --
delete from zepto
where mrp=0;

-- convert paise to rupees --
update zepto
set mrp = mrp/100.0,
discountsellingprice = discountsellingprice/100.0;

-- checking after conversion from paise to rupees --
select mrp, discountsellingprice from zepto;

-- QUESTION & ANSWER (BUSINESS INSIGHTS) --

-- Q1. Find the top 10 best-value products based on the discount percentage. --
select distinct name mrp, discountpercent from zepto
order by discountpercent desc limit 10;

-- Q2. What are the products with high mrp but out of stock. --
select distinct name, mrp from zepto
where outofstock is True and mrp>300
order by mrp desc;

-- Q3. Calculate estimated revenue for each category. --
select category,
sum(discountsellingprice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue;

-- Q4. Find all products where mrp is greater than Rs. 500 and discount is less than 10%. --
select distinct name, mrp, discountpercent from zepto
where mrp>500 and discountpercent<10
order by mrp desc, discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage. --
select category,
round(avg(discountpercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- Q6. Find the price per gram for products above 100gms and sort by best values --


-- Q7. Group the products into categories like low. medium and Bulk. --


-- Q8. What is the total inventory weight per category. --

