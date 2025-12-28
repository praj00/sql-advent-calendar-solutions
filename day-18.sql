-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH mini AS (
    SELECT subject, min(quiz_date) as mindate
    FROM daily_quiz_scores
    GROUP BY subject
), 
maxi AS (
    SELECT subject, max(quiz_date) as maxdate
    FROM daily_quiz_scores
    GROUP BY subject
)
SELECT m1.subject, m1.mindate, d1.score as min_score, 
       m2.maxdate, d2.score as max_score
FROM mini m1
JOIN maxi m2 ON m1.subject = m2.subject
JOIN daily_quiz_scores d1 ON m1.subject = d1.subject AND m1.mindate = d1.quiz_date
JOIN daily_quiz_scores d2 ON m2.subject = d2.subject AND m2.maxdate = d2.quiz_date
