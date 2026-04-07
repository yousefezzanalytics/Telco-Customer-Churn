-- تحويل المسافات الفارغة لـ 0 عشان ميحصلش خطأ في التحويل
UPDATE Raw_Churn_Data
SET TotalCharges = '0'
WHERE TotalCharges = ' ' OR TotalCharges IS NULL;

-- تغيير نوع العمود لرقم عشري (Decimal)
ALTER TABLE Raw_Churn_Data
ALTER COLUMN TotalCharges DECIMAL(10, 2);

CREATE VIEW vw_Churn_Analysis AS
SELECT 
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    -- تقسيم مدة الاشتراك لمجموعات (Tenure Buckets)
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE 'Over 4 Years'
    END AS Tenure_Group,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    -- تحويل الـ Churn لرقم (1 للي مشي، 0 للي لسه موجود)
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS Churn_Status,
    Churn
FROM Raw_Churn_Data;

SELECT TOP 10 * FROM Raw_Churn_Data;
