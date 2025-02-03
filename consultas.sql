/*
crime_scene_report
drivers_license
facebook_event_checkin
interview
get_fit_now_member
get_fit_now_check_in
solution
income
person
*/
SELECT *
FROM crime_scene_report
WHERE date = '20180115'
AND city = 'SQL City'
AND type = 'murder'
--testigos
--The first witness lives at the last house on "Northwestern Dr"    
--The second witness, named Annabel, lives somewhere on "Franklin Ave"
SELECT id, name, address_street_name, MAX(address_number) address_number
FROM person
WHERE address_street_name = 'Northwestern Dr'
--Primer testigo: 14887	Morty Schapiro	Northwestern Dr	4919
SELECT id, name, address_street_name, address_number
FROM person
WHERE address_street_name = 'Franklin Ave'
AND name LIKE '%Annabel%'
--Segundo testigo: 16371	Annabel Miller	Franklin Ave	103
SELECT *
FROM interview
WHERE person_id IN (14887, 16371)
/*Testimonios de los dos testigos: 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.*/
SELECT *
FROM get_fit_now_member G
INNER JOIN get_fit_now_check_in C ON G.id = C.membership_id
INNER JOIN person P ON P.id = G.person_id
INNER JOIN drivers_license L ON L.id = P.license_id
WHERE C.check_in_date = '20180109'
AND G.membership_status = 'gold'
AND G.id LIKE '48Z%'
AND L.gender = 'male'
AND L.plate_number LIKE '%H42W%'
/*48Z55	67318	Jeremy Bowers	20160101	gold	48Z55	20180109	1530	1700	67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279	423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS */
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;
/*Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.*/
SELECT *
FROM interview
WHERE person_id = 67318
/* EL ASESINO FUE CONTRAtado: I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.*/
 SELECT P.id, P.name, I.annual_income, F.event_name, F.date, L.*
 FROM person P
 INNER JOIN drivers_license L ON L.id = P.license_id
 INNER JOIN income I ON I.ssn = P.ssn
 INNER JOIN facebook_event_checkin F ON F.person_id = P.id
 WHERE gender = 'female'
 AND L.car_make = 'Tesla'
 AND L.car_model = 'Model S'
 AND L.height >= 65
 AND L.height <= 67
 AND L.hair_color = 'red'
 /* 99716	Miranda Priestly	310000	SQL Symphony Concert	20171206	202298	68	66	green	red	female	500123	Tesla	Model S */
 INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;
/*Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne! */