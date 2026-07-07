# Marketplace Revenue Leakage & Gap Analysis using SQL

## Problem Statement
Online marketplace sales were growing, but profits were declining. Hidden costs like discounts, returns, logistics, and payment fees were silently reducing revenue. This project identifies where and how much revenue is being lost.

## Objective
- Design a marketplace database
- Analyze data using SQL
- Find revenue leakage points across the business
- Support better business decisions with data backed recommendations

## Tools Used
- MySQL Workbench
- SQL: JOIN, GROUP BY, HAVING, Window Functions, CTE, Subqueries

## Key SQL Concepts Applied
- JOIN and LEFT JOIN for connecting orders, products, returns, logistics and payment tables
- GROUP BY and HAVING for category and product level analysis
- RANK Window Function for product profit ranking
- CTE (WITH clause) for organizing complex leakage calculations
- COALESCE and NULLIF for handling NULL values and divide by zero errors

## Key Insights
- Total Revenue Leakage is Rs 2.19 Crore
- Highest leakage factor is Excessive Discounts
- 145 products identified as loss making
- COD has the highest payment gateway fee at 3.5 percent compared to UPI at 1.2 percent

## Recommendations
- Reduce returns to save Rs 1.28 Crore
- Optimize discounts with targeted offers instead of blanket discounts to save Rs 64 Lakhs
- Promote UPI and discourage COD to save Rs 26 Lakhs
- Reprice or remove loss making products

## Files in this Repository
- Full project presentation PDF

**Presented by:** Vidhya M
