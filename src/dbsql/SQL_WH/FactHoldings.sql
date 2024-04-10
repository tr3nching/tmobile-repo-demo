-- Databricks notebook source
INSERT INTO ${catalog}.${wh_db}.FactHoldings 
WITH Holdings as (
  SELECT * FROM ${catalog}.${wh_db}_stage.v_HoldingHistory
  UNION ALL
  SELECT * FROM ${catalog}.${wh_db}_stage.v_HoldingIncremental
)
SELECT
  hh_h_t_id tradeid,
  hh_t_id currenttradeid,
  sk_customerid,
  sk_accountid,
  sk_securityid,
  sk_companyid,
  sk_closedateid sk_dateid,
  sk_closetimeid sk_timeid,
  tradeprice currentprice,
  hh_after_qty currentholding,
  h.batchid
FROM Holdings h
  JOIN ${catalog}.${wh_db}.DimTrade dt 
    ON tradeid = hh_t_id
