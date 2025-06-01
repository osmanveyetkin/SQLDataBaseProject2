-- ===============================================
-- Veri Tabanı 2 Ek Ödevi
-- ===============================================

--BU Ödev veritabanı 2 dersinin sınva ek puan ödevidir. Ödev detayları ve sistem raporda ayrıca açıklanmıştır.

CREATE DATABASE flightcontrol1 TEMPLATE template0; --Manuel arayüzden yaratmada hata aldığımdan kullandım.
-- ===============================================
--  TABLO OLUŞTURMA
-- ===============================================

-- Yolcular (Passengers)
CREATE TABLE passengers (
    passenger_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    gender CHAR(1),
    birth_date DATE
);

-- Uçuşlar (Flights)
CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    departure_airport VARCHAR(100),
    arrival_airport VARCHAR(100),
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP,
    price NUMERIC(10,2)
);

-- Rezervasyonlar (Bookings)
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    flight_id INT REFERENCES flights(flight_id),
    passenger_id INT REFERENCES passengers(passenger_id),
    seat_no VARCHAR(5),
    travel_class VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active',
    booking_date TIMESTAMP DEFAULT NOW()
);

-- Log Tablosu (Trigger için)
CREATE TABLE booking_log (
    log_id SERIAL PRIMARY KEY,
    booking_id INT,
    log_time TIMESTAMP DEFAULT NOW(),
    action TEXT
);

-- ===============================================
-- VERİ EKLEME (INSERT
-- ===============================================

-- Yolcular
INSERT INTO passengers (first_name, last_name, email, phone, gender, birth_date) VALUES
('Ahmet', 'Yılmaz', 'ahmet@example.com', '05301111111', 'M', '1990-01-15'),
('Ayşe', 'Demir', 'ayse@example.com', '05302222222', 'F', '1988-03-20'),
('Mehmet', 'Kaya', 'mehmet@example.com', '05303333333', 'M', '1995-05-05'),
('Zeynep', 'Şahin', 'zeynep@example.com', '05304444444', 'F', '2000-10-10'),
('Ali', 'Çelik', 'ali@example.com', '05305555555', 'M', '1992-12-12'),
('Elif', 'Aydın', 'elif@example.com', '05306666666', 'F', '1996-07-07'),
('Burak', 'Koç', 'burak@example.com', '05307777777', 'M', '1985-09-09'),
('Fatma', 'Bulut', 'fatma@example.com', '05308888888', 'F', '1991-11-11');

-- Uçuşlar
INSERT INTO flights (departure_airport, arrival_airport, departure_time, arrival_time, price) VALUES
('IST', 'ANK', '2025-06-01 08:00', '2025-06-01 09:15', 799.99),
('IST', 'ESB', '2025-06-01 15:00', '2025-06-01 16:30', 859.50),
('SAW', 'ADB', '2025-06-02 12:00', '2025-06-02 13:15', 599.90),
('ADB', 'IST', '2025-06-03 17:00', '2025-06-03 18:15', 650.00),
('ESB', 'SAW', '2025-06-04 20:00', '2025-06-04 21:15', 700.00),
('IST', 'AYT', '2025-06-05 09:00', '2025-06-05 10:30', 725.00);

-- Rezervasyonlar
INSERT INTO bookings (flight_id, passenger_id, seat_no, travel_class) VALUES
(1, 1, '12A', 'Economy'),
(2, 2, '5B', 'Business'),
(3, 3, '8C', 'Economy'),
(4, 4, '7D', 'Economy'),
(5, 5, '1A', 'Business'),
(6, 6, '9E', 'Economy'),
(1, 7, '10F', 'Economy'),
(2, 8, '2B', 'Business'),
(3, 1, '6A', 'Economy'),
(4, 2, '3C', 'Economy');

-- ===============================================
-- SELECT & WHERE
-- ===============================================

-- 1. Tüm yolcuları listele
SELECT * FROM passengers;

-- 2. İstanbul'dan kalkan uçuşları getir
SELECT * FROM flights WHERE departure_airport = 'IST';

-- 3. Kadın yolcuların rezervasyonlarını getir
SELECT first_name, last_name FROM passengers WHERE gender = 'F';

-- 4. 1990 sonrası doğan yolcular
SELECT * FROM passengers WHERE birth_date > '1990-01-01';

-- 5. Fiyatı 700’den fazla olan uçuşlar
SELECT * FROM flights WHERE price > 700;

-- ===============================================
-- SELECT & JOIN
-- ===============================================

-- 6. Tüm rezervasyonları yolcu ve uçuş bilgileriyle birlikte getir
SELECT b.booking_id, p.first_name || ' ' || p.last_name AS passenger,
       f.departure_airport || ' → ' || f.arrival_airport AS route,
       f.departure_time, b.seat_no, b.travel_class
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id;

-- 7. Business sınıfındaki yolcuları getir
SELECT p.first_name, p.last_name, b.travel_class
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
WHERE b.travel_class = 'Business';

-- 8. Her uçuşun toplam rezervasyon sayısı
SELECT f.flight_id, COUNT(b.booking_id) AS total_bookings
FROM flights f
LEFT JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id;

-- 9. Her uçuşun toplam gelirini hesapla
SELECT f.flight_id, SUM(f.price) AS total_revenue
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
GROUP BY f.flight_id;

-- 10. Her yolcunun yaptığı rezervasyon sayısı
SELECT p.first_name, p.last_name, COUNT(b.booking_id) AS reservation_count
FROM passengers p
LEFT JOIN bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.first_name, p.last_name;

-- ===============================================
-- ORDER BY, LIMIT
-- ===============================================

-- 11. Fiyatı en yüksek 3 uçuş
SELECT * FROM flights ORDER BY price DESC LIMIT 3;

-- 12. En eski rezervasyonlar
SELECT * FROM bookings ORDER BY booking_date ASC;

-- ===============================================
-- UPDATE / DELETE
-- ===============================================

-- 13. Belirli bir rezervasyonun durumunu değiştir
UPDATE bookings SET status = 'Cancelled' WHERE booking_id = 2;

-- 14. Ayşe'nin rezervasyonunu sil
DELETE FROM bookings WHERE passenger_id = 2;

-- 15. Ayşe’yi yolcu listesinden sil
DELETE FROM passengers WHERE passenger_id = 2;

-- ===============================================
-- VIEW
-- ===============================================

-- 16. Yolcu bazlı rezervasyon özeti görünümü
CREATE VIEW passenger_booking_summary AS
SELECT p.first_name, p.last_name, b.seat_no, b.travel_class, f.departure_airport, f.arrival_airport
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
JOIN flights f ON b.flight_id = f.flight_id;

-- ===============================================
-- FUNCTION
-- ===============================================

-- 17. Uçuş süresi hesaplayan fonksiyon
CREATE OR REPLACE FUNCTION flight_duration(f_id INT)
RETURNS INTERVAL AS $$
DECLARE
    duration INTERVAL;
BEGIN
    SELECT arrival_time - departure_time INTO duration
    FROM flights WHERE flight_id = f_id;
    RETURN duration;
END;
$$ LANGUAGE plpgsql;

-- SELECT flight_duration(1);

-- ===============================================
-- 10. PROCEDURE
-- ===============================================

-- 18. Rezervasyon durumunu değiştiren prosedür
CREATE OR REPLACE PROCEDURE update_booking_status(b_id INT, new_status VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE bookings SET status = new_status WHERE booking_id = b_id;
END;
$$;

-- CALL update_booking_status(1, 'Completed');

-- ===============================================
-- TRIGGER & LOG
-- ===============================================

-- 19. Trigger fonksiyonu: Rezervasyon oluşturulunca log at
CREATE OR REPLACE FUNCTION log_new_booking()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO booking_log (booking_id, action)
    VALUES (NEW.booking_id, 'Yeni rezervasyon eklendi');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 20. Trigger tanımı
CREATE TRIGGER trg_booking_insert
AFTER INSERT ON bookings
FOR EACH ROW
EXECUTE FUNCTION log_new_booking();

-- ===============================================
-- TRANSACTION
-- ===============================================

-- 21. Toplu işlem örneği (başarıyla tamamlanmazsa rollback)
BEGIN;

INSERT INTO bookings (flight_id, passenger_id, seat_no, travel_class) VALUES
(5, 3, '6F', 'Economy');

INSERT INTO bookings (flight_id, passenger_id, seat_no, travel_class) VALUES
(6, 4, '9D', 'Economy');

COMMIT;

-- ===============================================
-- SECURITY (GRANT)
-- ===============================================

-- 22. Salt-okuma yetkili kullanıcı oluştur
CREATE ROLE readonly_user LOGIN PASSWORD 'readonly123';
GRANT CONNECT ON DATABASE airline_reservation TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public FROM readonly_user;

-- ===============================================
-- BONUS SORGU ÖRNEKLERİ
-- ===============================================

-- 23. Yolcunun adı "A" harfiyle başlayanlar
SELECT * FROM passengers WHERE first_name LIKE 'A%';

-- 24. 600 ile 800 TL arası uçuşlar
SELECT * FROM flights WHERE price BETWEEN 600 AND 800;

-- 25. Belirli ID’li yolcuları getir
SELECT * FROM passengers WHERE passenger_id IN (1, 3, 5);

-- 26. Rezervasyon tarihlerini yalnızca tarih olarak getir (CAST)
SELECT booking_id, CAST(booking_date AS DATE) FROM bookings;

-- 27. Sadece 2 veya daha fazla rezervasyon yapan yolcular
SELECT passenger_id, COUNT(*) AS toplam
FROM bookings
GROUP BY passenger_id
HAVING COUNT(*) >= 2;


-- ========================================
-- VIEW KULLANIM ÖRNEKLERİ
-- ========================================

-- 28. View üzerinden tüm rezervasyon özetlerini çek
SELECT * FROM passenger_booking_summary;

-- 29. Sadece “Business” sınıfında seyahat eden yolcular
SELECT * 
FROM passenger_booking_summary
WHERE travel_class = 'Business';

-- 30. "IST → ANK" güzergahındaki rezervasyonlar
SELECT * 
FROM passenger_booking_summary
WHERE departure_airport = 'IST' AND arrival_airport = 'ANK';


-- ========================================
-- TRIGGER KULLANIM ÖRNEKLERİ
-- ========================================

-- 31. Yeni rezervasyon ekleniyor (trigger tetiklenir)
INSERT INTO bookings (flight_id, passenger_id, seat_no, travel_class)
VALUES (3, 4, '11C', 'Economy');

-- 32. Log tablosunu kontrol et (trigger etkisi)
SELECT * FROM booking_log
ORDER BY log_time DESC;

-- 33. Belirli bir yolcunun yaptığı tüm rezervasyonların loglarını görüntüle
SELECT 
    p.first_name, 
    p.last_name, 
    b.booking_id, 
    l.log_time, 
    l.action
FROM booking_log l
JOIN bookings b ON l.booking_id = b.booking_id
JOIN passengers p ON b.passenger_id = p.passenger_id
ORDER BY l.log_time DESC;

