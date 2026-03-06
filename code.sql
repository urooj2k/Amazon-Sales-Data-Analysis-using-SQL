CREATE DATABASE amazon_sales;

USE amazon_sales;

CREATE TABLE amazon_data (
    product_id VARCHAR(50),
    product_name TEXT,
    category VARCHAR(200),
    discounted_price DECIMAL(10,2),
    actual_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2),
    rating DECIMAL(3,2),
    rating_count INT,
    about_product TEXT,
    user_id VARCHAR(50),
    review_id VARCHAR(50),
    review_title TEXT,
    review_content TEXT,
    img_link TEXT,
    product_link TEXT
);

# Part1: Find products under ₹500

SELECT product_name, discounted_price FROM amazon_data WHERE discounted_price < 500;

# Part2: Show Highest rated product

SELECT product_name, rating FROM amazon_data ORDER BY rating DESC;

# Part3: Count of total products

SELECT COUNT(*) AS total_products FROM amazon_data

# Part4: Find Discount difference

SELECT product_name, actual_price - discounted_price AS discount_amount FROM amazon_data;

# Part5: Display products with negative reviews

SELECT product_name,review_content FROM amazon_data WHERE review_content LIKE '_worst_' OR review_content LIKE '_not good_'  OR review_content LIKE '_waste_' OR review_content LIKE '_poor';

# Part6: Identify top 3 highest rated products in each category

WITH RatedProducts AS (SELECT product_id,product_name,category,rating,RANK() OVER (PARTITION BY category ORDER BY rating DESC) AS rating_rank FROM amazon_data)

SELECT product_id,product_name,category,rating FROM RatedProducts WHERE rating_rank <= 3
ORDER BY category, rating DESC;

# Part7: Identify top 5 most review products in each category

WITH ReviewRanking AS (SELECT product_id,product_name,category,rating_count,RANK() OVER (PARTITION BY category ORDER BY rating_count DESC) AS review_rank FROM amazon_data)

SELECT product_id,product_name,category,rating_count FROM ReviewRanking WHERE review_rank <= 5 ORDER BY category, rating_count DESC;