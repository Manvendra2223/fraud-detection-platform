-- 1. Overall fraud rate
SELECT COUNT(*) AS total, SUM(is_fraud) AS frauds,
       ROUND(100.0 * SUM(is_fraud) / COUNT(*), 3) AS fraud_pct
FROM transactions;

-- 2. Category-wise fraud rate
SELECT category, COUNT(*) AS total, SUM(is_fraud) AS frauds,
       ROUND(100.0 * SUM(is_fraud) / COUNT(*), 2) AS fraud_pct
FROM transactions GROUP BY category ORDER BY fraud_pct DESC;

-- 3. Hour-wise fraud rate
SELECT hour, COUNT(*) AS total, ROUND(100.0 * AVG(is_fraud), 2) AS fraud_pct
FROM transactions GROUP BY hour ORDER BY hour;

-- 4. Amount: fraud vs genuine
SELECT is_fraud, ROUND(AVG(amt), 2) AS avg_amt,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amt) AS median_amt
FROM transactions GROUP BY is_fraud;

-- 5. Risky states (bade volume wale)
SELECT state, COUNT(*) AS total, ROUND(100.0 * AVG(is_fraud), 2) AS fraud_pct
FROM transactions GROUP BY state HAVING COUNT(*) >= 5000
ORDER BY fraud_pct DESC LIMIT 10;