-- Audrey Ly
-- ayl448

-- Question 1
SELECT cardholder_first_name, 
       cardholder_last_name, 
       card_type, 
       expiration_date
FROM customer_payment
ORDER BY expiration_date;

-- Question 2
SELECT first_name || ' ' || last_name
FROM customer
WHERE SUBSTR(first_name, 1, 1) IN ('A', 'B', 'C')
ORDER BY last_name DESC; 

-- Question 3
SELECT customer_id, 
       confirmation_nbr, 
       date_created, 
       check_in_date, 
       number_of_guests
FROM reservation
WHERE status = 'U' 
        AND check_in_date >= '12-OCT-2021' 
        AND check_in_date <= '31-DEC-2021';

-- Question 4
-- Part 4A
SELECT customer_id, 
       confirmation_nbr, 
       date_created, 
       check_in_date, 
       number_of_guests
FROM reservation
WHERE status = 'U' 
        AND check_in_date 
        BETWEEN '12-OCT-2021' AND '31-DEC-2021';

-- Part 4B
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' AND check_in_date >= '12-OCT-2021' AND check_in_date <= '31-DEC-2021'
MINUS
SELECT customer_id, confirmation_nbr, date_created, check_in_date, number_of_guests
FROM reservation
WHERE status = 'U' AND check_in_date BETWEEN '12-OCT-2021' AND '31-DEC-2021';

-- Question 5 -- REVISE
SELECT customer_id, location_id, (check_out_date - check_in_date) as length_of_stay
FROM reservation 
WHERE status = 'C'
AND ROWNUM <= 10
ORDER BY length_of_stay DESC, customer_id ASC; -- REVISE

-- Question 6
SELECT first_name, last_name, email, (stay_credits_earned - stay_credits_used) as credits_available
FROM customer
WHERE (stay_credits_earned - stay_credits_used) >= 10
ORDER BY credits_available;

-- Question 7
SELECT cardholder_first_name, cardholder_last_name, cardholder_mid_name
FROM customer_payment
WHERE cardholder_mid_name IS NOT NULL 
ORDER BY 2, 3 ASC;

-- Question 8
SELECT SYSDATE AS today_unformatted, 
       TO_CHAR (SYSDATE, 'MM/DD/YYYY') AS today_formatted, 
       25 AS Credits_Earned,
       25/10 AS Stays_Earned,
       FLOOR(25/10) as Redeemable_stays, 
       ROUND(25/10) as Next_Stay_to_earn
FROM dual;

-- Question 9
SELECT customer_id, 
       location_id, 
       (check_out_date - check_in_date) as length_of_stay
FROM reservation
WHERE status = 'C' AND location_id = 2
ORDER BY length_of_stay DESC, customer_id ASC
FETCH FIRST 20 ROWS ONLY;

-- Question 10
SELECT c.first_name, c.last_name, r.confirmation_nbr, r.date_created, r.check_in_date, r.check_out_date
FROM customer c JOIN reservation r
     ON c.customer_id = r.customer_id
WHERE status = 'C'
ORDER BY c.customer_id ASC, check_out_date DESC;

-- Question 11
SELECT c.first_name || ' '|| c.last_name, l.location_id, r.confirmation_nbr, r.check_in_date, rm.room_number
FROM customer c JOIN reservation r 
        ON c.customer_id = r.customer_id
                JOIN location l
        ON r.location_id = l.location_id
                JOIN room rm
        ON r.location_id = rm.location_id
WHERE status = 'U' AND stay_credits_earned > 40;

-- Question 12
SELECT c.first_name, c.last_name, r.confirmation_nbr, r.date_created, r.check_in_date, r.check_out_date
FROM customer c LEFT OUTER JOIN reservation r
        ON c.customer_id = r.customer_id
WHERE confirmation_nbr IS NULL;

-- Question 13
    SELECT '1-Gold Member' AS status_level, first_name, last_name, email, stay_credits_earned
    FROM customer 
    WHERE stay_credits_earned < 10
UNION
    SELECT '2-Platinum Member' AS status_level, first_name, last_name, email, stay_credits_earned
    FROM customer
    WHERE stay_credits_earned >= 10 and stay_credits_earned < 40
UNION 
    SELECT '3-Diamond Club' AS status_level, first_name, last_name, email, stay_credits_earned
    FROM customer 
    WHERE stay_credits_earned >= 40
ORDER BY 1, 3;
