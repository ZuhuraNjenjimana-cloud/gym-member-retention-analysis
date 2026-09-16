```sql
-- ============================================================
-- WILL THEY STAY OR WILL THEY CHURN?
-- Gym Member Engagement & Retention Analysis
-- ============================================================
-- Dataset: 50,000 gym membership records
-- Database: SQLite
-- Churn outcome: churned_by_febru
-- 1 = Churned | 0 = Retained
-- ============================================================


-- ============================================================
-- 1. DATA QUALITY & VALIDATION
-- ============================================================

-- Review table structure
PRAGMA table_info(users);

-- Check for NULL member IDs
SELECT *
FROM users
WHERE member_id IS NULL;

-- Check total rows and unique member IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT member_id) AS unique_member_ids
FROM users;

-- Check for duplicate member IDs
SELECT
    member_id,
    COUNT(*) AS occurrence_count
FROM users
GROUP BY member_id
HAVING COUNT(*) > 1;

-- Check categorical values
SELECT DISTINCT sex FROM users;

SELECT DISTINCT contract_type FROM users;

SELECT DISTINCT primary_goal FROM users;

-- Check age range
SELECT
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age
FROM users;


-- ============================================================
-- 2. OVERALL MEMBER & CHURN METRICS
-- ============================================================

SELECT
    COUNT(*) AS total_members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users;

SELECT
    ROUND(AVG(age), 2) AS avg_age,
    ROUND(AVG(monthly_fee_usd), 2) AS avg_monthly_fee,
    ROUND(AVG(avg_session_minu), 2) AS avg_session_length,
    ROUND(AVG(avg_weekly_class), 2) AS avg_weekly_classes
FROM users;


-- ============================================================
-- 3. MEMBER CHARACTERISTICS
-- ============================================================

-- Churn by age group
SELECT
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY age_group
ORDER BY age_group;

-- Churn by sex
SELECT
    sex,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY sex
ORDER BY churn_rate DESC;

-- Churn by contract type
SELECT
    contract_type,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY contract_type
ORDER BY churn_rate DESC;

-- Churn by primary fitness goal
SELECT
    primary_goal,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY primary_goal
ORDER BY churn_rate DESC;

-- Churn by distance from gym
SELECT
    CASE
        WHEN distance_km < 5 THEN 'Under 5 km'
        WHEN distance_km BETWEEN 5 AND 9.99 THEN '5-9.99 km'
        WHEN distance_km BETWEEN 10 AND 19.99 THEN '10-19.99 km'
        ELSE '20+ km'
    END AS distance_group,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY distance_group
ORDER BY churn_rate DESC;


-- ============================================================
-- 4. ENGAGEMENT ANALYSIS
-- ============================================================

-- Churn by Week 1 visits
SELECT
    week1_visits,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY week1_visits
ORDER BY week1_visits;

-- Churn by Week 2 visits
SELECT
    week2_visits,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY week2_visits
ORDER BY week2_visits;

-- Churn by Week 3 visits
SELECT
    week3_visits,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY week3_visits
ORDER BY week3_visits;

-- Churn by Week 4 visits
SELECT
    week4_visits,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY week4_visits
ORDER BY week4_visits;

-- Churn by average weekly classes
SELECT
    avg_weekly_class,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY avg_weekly_class
ORDER BY avg_weekly_class;

-- Churn by app installation
SELECT
    app_installed,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY app_installed
ORDER BY app_installed;

-- Churn by personal trainer
SELECT
    personal_trainer,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY personal_trainer
ORDER BY personal_trainer;

-- Churn by induction
SELECT
    booked_induction,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY booked_induction
ORDER BY booked_induction;

-- Churn by guest passes used
SELECT
    guest_passes_use,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY guest_passes_use
ORDER BY guest_passes_use;

-- Churn by joining with a friend
SELECT
    joined_with_frie,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY joined_with_frie
ORDER BY joined_with_frie;

-- Churn by average session length
SELECT
    CASE
        WHEN avg_session_minu < 30 THEN 'Under 30 min'
        WHEN avg_session_minu BETWEEN 30 AND 44 THEN '30-44 min'
        WHEN avg_session_minu BETWEEN 45 AND 59 THEN '45-59 min'
        ELSE '60+ min'
    END AS session_group,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY session_group
ORDER BY churn_rate DESC;

-- Churn by locker rental
SELECT
    locker_rented,
    COUNT(*) AS members,
    SUM(churned_by_febru) AS churned_members,
    ROUND(
        100.0 * SUM(churned_by_febru) / COUNT(*),
        2
    ) AS churn_rate
FROM users
GROUP BY locker_rented
ORDER BY locker_rented;


-- ============================================================
-- 5. DATA EXPORT FOR EXCEL STATISTICAL TESTING
-- ============================================================

SELECT
    member_id,
    distance_km,
    contract_type,
    avg_weekly_class,
    app_installed,
    personal_trainer,
    booked_induction,
    guest_passes_use,
    joined_with_frie,
    avg_session_minu,
    locker_rented,
    churned_by_febru
FROM users;

-- App user group labels
SELECT
    member_id,
    app_installed,
    churned_by_febru,
    CASE
        WHEN app_installed = 1 THEN 'App Users'
        WHEN app_installed = 0 THEN 'Non-App Users'
    END AS app_group
FROM users;

-- Prepare separate churn columns for Excel comparison
SELECT
    CASE
        WHEN app_installed = 1 THEN churned_by_febru
    END AS app_users_churn,

    CASE
        WHEN app_installed = 0 THEN churned_by_febru
    END AS non_app_users_churn
FROM users;
```
