-- NIVELL 1--
 SHOW COLUMNS FROM credit_card;
-- Ejercicio 1--

CREATE TABLE IF NOT EXISTS credit_card(
id VARCHAR(255) NOT NULL ,
iban VARCHAR(255) NULL,
pan varchar(255),
pin INT,
cvv INT,
expiring_date VARCHAR(20),
PRIMARY KEY (id)) ;

ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card_id
FOREIGN KEY (credit_card_id) 
REFERENCES credit_card(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

SELECT *
FROM credit_card ;

desc credit_card;

-- Ejercicio 2 --
SELECT *
FROM credit_card
WHERE id = 'CcU-2938';

UPDATE credit_card
SET iban ='TR323456312213576817699999' 
WHERE id = 'CcU-2938';
-- Ejercicio 3 --
INSERT INTO credit_card (id)
VALUES('CcU-9999');
INSERT INTO company (id)
 VALUES ('b-9999');


INSERT INTO transaction (id,credit_card_id,company_id,user_id,lat,longitude,amount,declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999','b-9999',9999,'829.999','-117.999','111.11',0);

SELECT *
FROM transaction 
WHERE id='108B1D1D-5B23-A76C-55EF-C568E49A99DD';
-- Ejercicio 4--


ALTER TABLE credit_card DROP COLUMN pan;
 SHOW COLUMNS FROM credit_card;
-- NIVELL 2 --

-- Ejercicio 1 --


SELECT *
FROM transaction 
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';

DELETE FROM transaction
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';

-- Ejercicio 2 --

CREATE VIEW VistaMarketing AS
SELECT c.company_name,c.phone,c.country,AVG(t.amount) AS 'Media de compras'
FROM company c
JOIN transaction t
ON c.id = t.company_id
GROUP BY t.company_id
 ;

SELECT *
FROM VistaMarketing;
-- Ejercicio 3 --

SELECT *
FROM VistaMarketing
WHERE country = 'Germany';





-- NIVELL 3 --

-- Ejercicio 1-- 

DESC data_user ;
ALTER TABLE transaction 
DROP CONSTRAINT fk_credit_card_id;
ALTER TABLE credit_card CHANGE id id VARCHAR(20);
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card_id
FOREIGN KEY (credit_card_id) 
REFERENCES credit_card(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE transaction CHANGE credit_card_id credit_card_id VARCHAR(20);

RENAME TABLE user TO data_user;

ALTER TABLE data_user CHANGE id id INT NOT NULL;

INSERT INTO data_user (id) VALUES ('9999');
ALTER TABLE transaction
ADD CONSTRAINT user_id_fk
FOREIGN KEY (user_id) 
REFERENCES data_user(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE  ;

UPDATE credit_card
SET fecha_actual = CURRENT_DATE
WHERE fecha_actual IS NULL;

ALTER TABLE credit_card CHANGE iban iban VARCHAR(50);

ALTER TABLE credit_card CHANGE pin pin VARCHAR(4);

ALTER TABLE credit_card CHANGE expiring_date expiring_date VARCHAR(20);

ALTER TABLE company DROP website;

ALTER TABLE data_user CHANGE email personal_email VARCHAR(150)
;

DROP VIEW VistaMarketing;
-- Ejercio 2--



CREATE VIEW InformeTecnico AS 
SELECT t.id,d.name,d.surname,c.iban,c2.company_name
FROM transaction t
JOIN data_user d
ON t.user_id = d.id
JOIN credit_card c
ON t.credit_card_id = c.id
JOIN company c2
ON t.company_id = c2.id
GROUP BY t.id

;


SELECT *
FROM InformeTecnico;














