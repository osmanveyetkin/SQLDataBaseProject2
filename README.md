# ✈️ FlightControl1 — Airline Ticket Reservation System

This project was developed as a **bonus assignment** for the _Database II_ course. It implements a simplified **Airline Ticket Reservation System** using **PostgreSQL**, and includes database design, SQL queries, triggers, functions, procedures, views, security configurations, and more.

> ✅ This SQL-based project demonstrates both beginner and advanced database techniques aligned with real-world use cases.

---

## 📁 Project Overview

- **Database Name:** `flightcontrol1`
- **Platform:** PostgreSQL (tested with pgAdmin 4)
- **Author:** Osman Yetkin 
- **Date:** May 2025



## 🎯 Purpose

The purpose of this project is to:
- Apply all the concepts learned in the Database II course,
- Build a fully functional reservation system for flights,
- Practice using SELECT, JOIN, TRIGGER, PROCEDURE, FUNCTION, TRANSACTION, and SECURITY in real-life scenarios,
- Demonstrate modular SQL usage with reusable views and advanced filtering.



## 🧱 Entity Structure

| Table Name      | Description                              |
|-----------------|------------------------------------------|
| `passengers`    | Stores passenger information             |
| `flights`       | Stores flight details                    |
| `bookings`      | Associates passengers with flights       |
| `booking_log`   | Trigger-based logging of new bookings    |



## 📌 Features and Components

### 🔎 SQL Queries (33+ examples)
- Basic `SELECT` with filtering
- Advanced `JOIN` operations
- `ORDER BY`, `LIMIT`, `GROUP BY`, and `HAVING`
- `UPDATE` and `DELETE` operations

### 📊 Views
- `passenger_booking_summary` view summarizes bookings
- Filters business-class passengers and routes

### 🔁 Functions & Procedures
- `flight_duration(f_id)` — returns duration of a flight
- `update_booking_status()` — updates booking status

### 🔔 Triggers
- `log_new_booking()` + `trg_booking_insert` trigger to log every new booking into `booking_log`

### 🔐 Security
- Role `readonly_user` created with only `SELECT` privileges

### 🎁 Bonus Features
- Advanced filtering using `LIKE`, `BETWEEN`, `IN`, `CAST`
- Sample ER Diagram and usage documentation
- Full SQL script ready to execute


## 🚀 How to Deploy Locally

1. **Install PostgreSQL / pgAdmin**
   - Make sure pgAdmin 4 or any PostgreSQL GUI is installed.

2. **Create a new database:**
   ```sql
   CREATE DATABASE flightcontrol1 TEMPLATE template0;

	3.	Open Query Tool and paste the SQL script
	•	Execute the full SQL block (provided in .sql file or PDF).
	4.	Explore your system
	•	Test triggers, views, procedures, and run your own queries!


📝 Notes
	•	All table and column names are in English.
	•	Passenger and flight data are in Turkish for realism.
	•	The project can be extended with airline companies, terminals, gates, and baggage tracking.


🧠 Learning Outcomes

This project is a complete hands-on implementation of theoretical concepts from the Database II course. It enhances skills in:
	•	Relational modeling
	•	SQL scripting
	•	Data integrity
	•	Logging and reporting
	•	Real-world application design


📄 License & Sharing

This SQL query structure and database were created as an assignment for the Database II course and have been publicly shared along with the report and queries for educational purposes.


🧑‍🎓 Prepared by: Osman Yetkin
📘 Course: Veritabanı 2
📆 Term: Spring 2025

