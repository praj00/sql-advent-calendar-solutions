-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

With rankcte as(
SELECT CAST(sent_at as DATE) AS sent_at,user_name,count(message_id) as message_count,
rank() over(partition by CAST(sent_at as DATE) ORDER BY count(message_id) desc) as rn
  FROM npn_messages n
  JOIN npn_users u ON n.sender_id=u.user_id
GROUP BY sender_id,CAST(sent_at as DATE),user_name
)
select sent_at,user_name,message_count
from rankcte
WHERE rn=1
