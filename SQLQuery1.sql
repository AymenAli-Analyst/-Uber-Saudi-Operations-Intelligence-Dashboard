








SELECT 
    City,
    COUNT(Trip_ID) AS Total_Completed_Trips,
    SUM(Final_Fare_SAR) AS Total_Revenue_SAR,
    AVG(Final_Fare_SAR) AS Avg_Fare_Per_Trip_SAR,
    SUM(Distance_KM) AS Total_Distance_Covered_KM
FROM 
    dbo.Uber_KSA_Trips
WHERE 
    Status = 'Completed' -- استبعاد الرحلات الملغاة
GROUP BY 
    City
ORDER BY 
    Total_Revenue_SAR DESC;


SELECT TOP 10
    D.Full_Name,
    D.City,
    SUM(E.Net_Earnings_SAR) AS Total_Net_Earnings,
    SUM(E.Total_Trips) AS Total_Trips_Made,
    AVG(E.Average_Rating) AS Avg_Driver_Rating
FROM 
    dbo.Uber_KSA_Driver_Earnings E
JOIN 
    dbo.Uber_KSA_Drivers D ON E.Driver_ID = D.Driver_ID
GROUP BY 
    D.Full_Name, 
    D.City
ORDER BY 
    Total_Net_Earnings DESC;


SELECT 
    Is_Peak_Hour,
    COUNT(Trip_ID) AS Number_Of_Trips,
    AVG(Surge_Multiplier) AS Average_Surge_Multiplier,
    SUM(Final_Fare_SAR) AS Total_Fares_SAR,
    AVG(Final_Fare_SAR) AS Avg_Fare_SAR,
    AVG(Duration_Minutes) AS Avg_Trip_Duration_Min
FROM 
    dbo.Uber_KSA_Trips
GROUP BY 
    Is_Peak_Hour
ORDER BY 
    Is_Peak_Hour DESC;




SELECT 
    Account_Tier,
    Preferred_Payment_Method,
    COUNT(Rider_ID) AS Total_Riders,
    SUM(Total_Spent_SAR) AS Total_Revenue_From_Tier,
    AVG(Average_Rating_Given) AS Avg_Rating_Provided
FROM 
    dbo.Uber_KSA_Riders
GROUP BY 
    Account_Tier, 
    Preferred_Payment_Method
ORDER BY 
    Total_Revenue_From_Tier DESC;



SELECT 
    Service_Type,
    Cancellation_Reason,
    COUNT(Trip_ID) AS Cancelled_Trips_Count
FROM 
    dbo.Uber_KSA_Trips
WHERE 
    Status = 'Cancelled'
GROUP BY 
    Service_Type, 
    Cancellation_Reason
ORDER BY 
    Cancelled_Trips_Count DESC;




    SELECT 
    D.City,
    D.Full_Name,
    SUM(E.Hours_Online) AS Total_Hours_Online,
    SUM(E.Net_Earnings_SAR) AS Total_Net_Earnings,
    CASE 
        WHEN SUM(E.Hours_Online) > 0 THEN ROUND(SUM(E.Net_Earnings_SAR) / SUM(E.Hours_Online), 2)
        ELSE 0 
    END AS Earnings_Per_Hour_SAR
FROM 
    dbo.Uber_KSA_Driver_Earnings E
JOIN 
    dbo.Uber_KSA_Drivers D ON E.Driver_ID = D.Driver_ID
GROUP BY 
    D.City, D.Full_Name
ORDER BY 
    Earnings_Per_Hour_SAR DESC;




SELECT 
    Vehicle_Category,
    Vehicle_Model,
    COUNT(Driver_ID) AS Total_Drivers,
    ROUND(AVG(Driver_Rating), 2) AS Avg_Driver_Rating,
    ROUND(AVG(Acceptance_Rate), 2) AS Avg_Acceptance_Rate
FROM 
    dbo.Uber_KSA_Drivers
GROUP BY 
    Vehicle_Category, 
    Vehicle_Model
ORDER BY 
    Total_Drivers DESC;



SELECT 
    Gender,
    Women_Preferred_Enabled,
    COUNT(Driver_ID) AS Total_Drivers,
    ROUND(AVG(Acceptance_Rate), 2) AS Avg_Acceptance_Rate,
    ROUND(AVG(Completion_Rate), 2) AS Avg_Completion_Rate
FROM 
    dbo.Uber_KSA_Drivers
GROUP BY 
    Gender, 
    Women_Preferred_Enabled;




SELECT 
    Year,
    Month_Name,
    SUM(Total_Trips) AS Total_Trips_Count,
    ROUND(SUM(Trip_Earnings_SAR), 2) AS Gross_Earnings,
    ROUND(SUM(Uber_Commission_SAR), 2) AS Total_Uber_Commission,
    ROUND(SUM(VAT_SAR), 2) AS Total_VAT,
    ROUND(SUM(Net_Earnings_SAR), 2) AS Total_Net_Earnings
FROM 
    dbo.Uber_KSA_Driver_Earnings
GROUP BY 
    Year, 
    Month, -- الترتيب تصاعدياً بناءً على رقم الشهر
    Month_Name
ORDER BY 
    Year DESC, 
    Month ASC;


SELECT 
    Account_Tier,
    COUNT(Rider_ID) AS Total_Riders,
    ROUND(SUM(Total_Spent_SAR), 2) AS Total_Spent_SAR,
    ROUND(AVG(Total_Rides), 1) AS Avg_Rides_Per_Rider
FROM 
    dbo.Uber_KSA_Riders
GROUP BY 
    Account_Tier
ORDER BY 
    Total_Spent_SAR DESC;





    SELECT TOP 10
    City,
    Pickup_Location,
    Dropoff_Location,
    COUNT(Trip_ID) AS Total_Trips,
    ROUND(SUM(Final_Fare_SAR), 2) AS Total_Revenue_SAR,
    ROUND(AVG(Duration_Minutes), 1) AS Avg_Duration_Minutes
FROM 
    dbo.Uber_KSA_Trips
WHERE 
    Status = 'Completed'
GROUP BY 
    City, Pickup_Location, Dropoff_Location
ORDER BY 
    Total_Trips DESC;




SELECT 
    Deactivation_Reason,
    COUNT(Driver_ID) AS Deactivated_Drivers_Count,
    ROUND(AVG(Driver_Rating), 2) AS Avg_Rating_Before_Deactivation,
    ROUND(AVG(Total_Completed_Trips), 0) AS Avg_Trips_Before_Deactivation,
    ROUND(AVG(Acceptance_Rate), 2) AS Avg_Acceptance_Rate
FROM 
    dbo.Uber_KSA_Drivers
WHERE 
    Status = 'Deactivated' OR Deactivation_Reason IS NOT NULL
GROUP BY 
    Deactivation_Reason
ORDER BY 
    Deactivated_Drivers_Count DESC;




    SELECT 
    City,
    Service_Type,
    COUNT(Trip_ID) AS Total_Trips,
    ROUND(AVG(Driver_Rating), 2) AS Avg_Driver_Rating,
    ROUND(AVG(Rider_Rating), 2) AS Avg_Rider_Rating,
    ROUND(AVG(ABS(Driver_Rating - Rider_Rating)), 2) AS Avg_Rating_Gap
FROM 
    dbo.Uber_KSA_Trips
WHERE 
    Status = 'Completed' 
    AND Driver_Rating IS NOT NULL 
    AND Rider_Rating IS NOT NULL
GROUP BY 
    City, Service_Type
ORDER BY 
    Avg_Rating_Gap DESC;




SELECT 
    Background_Check_Status,
    Documents_Verified,
    COUNT(Driver_ID) AS Drivers_Count,
    ROUND(AVG(Driver_Rating), 2) AS Avg_Driver_Rating,
    ROUND(AVG(Completion_Rate), 2) AS Avg_Completion_Rate
FROM 
    dbo.Uber_KSA_Drivers
GROUP BY 
    Background_Check_Status, 
    Documents_Verified;








    SELECT 
    YEAR(Registration_Date) AS Registration_Year,
    Status,
    COUNT(Driver_ID) AS Total_Drivers,
    SUM(Total_Completed_Trips) AS Grand_Total_Trips,
    ROUND(AVG(Total_Completed_Trips), 0) AS Avg_Trips_Per_Driver
FROM 
    dbo.Uber_KSA_Drivers
GROUP BY 
    YEAR(Registration_Date), 
    Status
ORDER BY 
    Registration_Year DESC, 
    Total_Drivers DESC;



    CREATE VIEW View_City_Performance AS
SELECT 
    City,
    COUNT(Trip_ID) AS Total_Completed_Trips,
    SUM(Final_Fare_SAR) AS Total_Revenue_SAR,
    AVG(Final_Fare_SAR) AS Avg_Fare_Per_Trip_SAR,
    SUM(Distance_KM) AS Total_Distance_Covered_KM
FROM 
    dbo.Uber_KSA_Trips
WHERE 
    Status = 'Completed'
GROUP BY 
    City







