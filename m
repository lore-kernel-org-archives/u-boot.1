Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6C3EA3F38
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179248388D;
	Tue, 10 Feb 2026 11:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fyPLLPvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC5983D6C; Tue, 10 Feb 2026 11:26:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988838341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrEL2Ub3lshKYeBB1OHiM5bJMoWDrSd/mJCeTs1D1Fz3S6HVi4NkXS7ic5LDcJu72arTduylRUHwlRWfGq0Ej634tjT8xYFJEN4p33fJUMR2EEUE0B5BiXgPddeIBjAYbh9Qttu/ptNB6xnIO1uUAb97TqWmeKgrUD3Mkq5dwT/Cwu/H/zHToCleeEiitsWzlh9AlJQFD1qAwDL8XTlAg5711LiO+5QEay6JBHOxpW4s7FhW7VUNp0+gaC4rplZKv3GtbknstIgszWlO5SsD9oR+LstM2U1691MquXDNnw2PqE5TvqlCdjRIZyRM+9IMEePpK5OVHXVXkT/YAwhb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKLUPudA9L9zLNA5eKF97KJcH9MLAG5MM+us8iX8igk=;
 b=R57Nd2YX2JyuOCl+uSfoU2k1BlxXN/RzSOSBGgT81JDcgYig3OU3MQNiwUDCrNgTQgNH3AyjeUh3g8y+w5quJXKcaINMXYMXV+2GIe3Orv4Uyi9UUa7BB6N5MYmxQhWofXud3ItdT/A0QMTQcO9w8E+eAhcSGF2vmhrQenhJvuNX86VXfx/gqBJO0l71CqVFbgRa/RRC3spB8gKrpk5H3SruHTH+DPOoCXENU2N+J198KZ3gFetG8juBqSaScMQMHnb3GDxjQGRNUBp4G4w08yHitgbgjyVibjXaaMDsnVbYaad1/jgN5bT4SloKWr5utfiwq+Go459NjyY/yXVhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKLUPudA9L9zLNA5eKF97KJcH9MLAG5MM+us8iX8igk=;
 b=fyPLLPvRm0NJlzVye2fX8PYxwzNjZZQHooHdwUN7H4EhDaaL/HesoQrBzwiYLajy9aRrT7lXgC8pCQrbYfMIlTkySgpRW94/9SwUOfBzoEfZK+glgGu6njeOTVlWY+EHUJEcJBLcPRcK9jhIUolQiGI1mrRaNYch2NqVvk36xfctfT4f1wmQ06CgV1XC0qOFebM1dCttwxHow0urQsnnNkt7aJjBxF7xdXm9y3p5/Kyjf92ijU79pr8nq8U24tRI1JT7Mzy63dZvPWk8jkgPdUP5JQg6V4EM4ovhQr+qHBNqdBEGCSc0QNxvG/U0an7xF60T61yT+uMct0Gb5nPdCA==
Received: from DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) by GV1PR10MB6394.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:26:12 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::e8) by DB9PR01CA0015.outlook.office365.com
 (2603:10a6:10:1d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 10:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 10:26:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:28:02 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:26:10 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 10 Feb 2026 11:26:03 +0100
Subject: [PATCH 2/4] ARM: stm32mp: Do not acquire RIFSC semaphore if CID
 filtering is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260210-upstream_rifsc_update-v1-2-74c813fa4862@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
In-Reply-To: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|GV1PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a13d8d2-ba17-4567-2aa8-08de688ed015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEh0OXdaS0FHekVrWk4xL1owdHp1eGhwanpOSk02VW1zVlJGTUd1ci90c2ts?=
 =?utf-8?B?dHlFVHNxRlY1UVRSdTVhTzNIUitMV3JrTlhYcjRPbFgvUWhzb29lWWMwZXRp?=
 =?utf-8?B?cENkU1JvQTkzSjlRbnlUNzJFcWpFT3VDZ2tUUDdRMHlNdnVLOFQ5RWZWdDIx?=
 =?utf-8?B?eE1IUkxWSDdnQlliNU5tdGRQU0VDRnJqUm5xN2M1QzAxMDNENHA4NVpPRXRJ?=
 =?utf-8?B?bTgvZWl5Y2V6UnNSaTVRb1l3WFdPbUZMNGNJcFJyMUxDRjJubWQ2OEV1ejUx?=
 =?utf-8?B?SkhSWXM5WDZKVWEwaGJEMVdNa2RUUVMvK3M5ZG1XcFhlenorODEzYWRER3hh?=
 =?utf-8?B?MDQ5ZHRLeExra0ZmcytiNERSdW5TSnNmZ0Q3ZmlLaUV3RjllRVJtMnYxaysw?=
 =?utf-8?B?NmlGZ1RiaDl1bkVWMDEzN3JOYXA3Zm1lRGxkTVVWRVdieUoraENNclJxcklQ?=
 =?utf-8?B?RnhlaXhmcW0zQnZxY2pla0VvR2JMcUVseUZvM244K0piTVBoNHg1QVBMWXZH?=
 =?utf-8?B?U29nems2UXNmRW1UeTlkZHNRS2VQdDZFTkpVK09BQ3VjNFdEMGhnYmVuZ0F1?=
 =?utf-8?B?cTFmVzJJdzRSaVJXV0gzVlVBMEttTTJVWDlmb1p0eVVsVU56bVhRZG5WRy84?=
 =?utf-8?B?NkdGNG9zOFNJNWV1ZUxaMytrZG84bGtPTUd3YXViQ0ZtdVc5K05oVHNHbVhS?=
 =?utf-8?B?T2xFOU5HMTVEM3NRRTAwalRmZm9HUDdTVnB4aFhPYkFka0FldGliTW43Zmoz?=
 =?utf-8?B?Ry9WcHNxa1VNWXA0OVFzSUVOb0ZHVVdrdGJMTENNRjhNQ1dEZmVacFpHQThK?=
 =?utf-8?B?TEJ3L29kQ2hzaHhyWUFFTENpMytMcHp5aHBnSGVqdGVzOUNZMWtaZjdvVGFD?=
 =?utf-8?B?eHZwOVM4NitLeVhsRXU1NmtNYkVkRWpBTldNZjhQTm5wNVh4OUpFZmYrZUZl?=
 =?utf-8?B?SG52QnZzNHlpeDBMRTZtWHFZelZHRnYxZXVEYUIvZUpsbWdsUUJVckU3SFVW?=
 =?utf-8?B?M3NMSmRWbngyTDhUKzBLc3VwQUp2QUJmUGIrMlM3K1Q2ZkZ3YVZvSlB6bFkr?=
 =?utf-8?B?YXdveVQ0TS83b1lmWjlZSWowdDc0aXNQRUFhcDFpYnRSNmQ1cXhicjVxVUZV?=
 =?utf-8?B?QXluVHduNjJiUitQUlNlQkNBZXVxRkxxbWJldjAyV2d4VnhNTE5aU0svTFRQ?=
 =?utf-8?B?QzI3MDFjMGZZN2dDbzVTV2pIbUNlOUhiaCtyb2dERWxseGFydEQ1dW54ekFY?=
 =?utf-8?B?V0pCa3I3TXB4bFdFdTZsYjRRS3B0ZnNIMHhwR0NrcEo0YWZydGVscVhuSnhh?=
 =?utf-8?B?UWI1a3hiRmxybng4ZUhlbzNZZzhEZkIrTjIwU1c0ZDNMUVBicFI3REpzb3RM?=
 =?utf-8?B?WnJpdm1XYVJ2WUp2eTVhZEM1am9RMElmOE5tNXZIa3B3MTNoMHowZjRJMHRO?=
 =?utf-8?B?dWRrQXBldlB3a0cxMm5JMmFQQzFjdVY4NjV3QmlGYXVrSzBDUWpTV0tBRjgw?=
 =?utf-8?B?MjFKcG5FcTBDSHUzODlzay9kQkkrWVMzTFJKQTdDK0QvdzhyTUx6RzF0QXRT?=
 =?utf-8?B?MDhoQ1BSeXFtQUlzbmxIMFhpS0pHTnVhY0ROcGRSV05wVGRKM1BYY0RYOUl5?=
 =?utf-8?B?VkpIT2pOVjB6UXR6ZVVSekpJQW5UV0N5ZGdObHJzd2ZobnBiZ1RudERmamE5?=
 =?utf-8?B?SVpZZVdocFlyVzRBVCs0QVlDT29qSU9tS1BBQzNnaCtsMFdOOTJtY3pZUVVi?=
 =?utf-8?B?RVJmbjlKdC9FNFh2VnVsRmx4Q3liNkU5QXhlME9wS3VFT05GMVdYbklJR1BX?=
 =?utf-8?B?dU42M1JBMmV2WVRDTVlkckFyQmpMaVdlTi9UYnRrZ2VydERTbWgydnhDZ1Uz?=
 =?utf-8?B?TElFZmtQbVIwYWlrcXRvS1JVOGtKUVRWa01wazhhVkRSSUp3WFJBdlF1ZE52?=
 =?utf-8?B?anFGRFF3dXJjVDNQbXM1NFVBWTVZc1B1YWRzc25OWGkwTVdkSkhkeW9sUEdR?=
 =?utf-8?B?MDJSdStDS2ZEQXcrNkQ1bUlvVk1OamM5TGFUNStxMkJrdXJFeUNWTVc0M0hG?=
 =?utf-8?B?ZHA4Q0xxemU1cDZaM0xBbS83ankyMzFFV01aUjlPNDZyOVlLU3JNYWdJbzJs?=
 =?utf-8?B?Wk03VWdUTitJbTgwbUlQbzBEYXQ0bmtVSXg0WElpZm1DTU1nSEV0SEJpMnpY?=
 =?utf-8?B?aCt3WXZTTlJ6RU5BVjdBdDFTYm5ERlNxWE1GWnZpNHdmdjRBSFlKMXUzWmk1?=
 =?utf-8?B?WHFIc1pWbUFocjVlRzhYVDBDbWVBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +TXvxBHHfhkBclnxMVM9aD6wpK9SPDeU/ZNrAWOtmHhE3q4rPZVaM0xhayV7DxBBDwbsgNizh8fGgfEZwxH2/MLdG1FzKrJlFKLbiYshIq65nrUD6DmJZPjwZ06ZJgXOdgymtBPrKRPQBlk3bRy/BZroGiSA3XY2ls9kRUuF98nJAvGIYpDJFseLHTtEisiphtdPQ2vfTvGDcSaEq1rf0M6DdvbEmBOVzCpmiJ44pjWJz/koNx0GDwexXkto8mv9XbveyvcxFE+DXSOVej0XPFRbMjZ/ldtwBDjYVlTahtqS00wIEmZcgCNrl+VTvdh+OLXNxBi4Wyauc9kbe+jy5nM2uwg9Fbvm7zGfMYl2KxhOxDGTT6n4FBwnIXQGPef2Tro/yZUvB+F1RXn8IbY8IVAYegrW3JOn2wx4emqheCsSMBXpjqtCqLT1lmhannHa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:26:11.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13d8d2-ba17-4567-2aa8-08de688ed015
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6394
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

If the CID filtering is enabled, the semaphore mode is disabled as well.
To avoid an incorrect behavior and error trace, add a check of CID
filtering state before acquiring the semaphore.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
index cf8026088f3..01ffc9f2798 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
@@ -208,7 +208,7 @@ int stm32_rifsc_grant_access_by_id(ofnode device_node, u32 id)
 	 * If the peripheral is in semaphore mode, take the semaphore so that
 	 * the CID1 has the ownership.
 	 */
-	if (cid_reg_value & CIDCFGR_SEMEN &&
+	if (cid_reg_value & CIDCFGR_CFEN && cid_reg_value & CIDCFGR_SEMEN &&
 	    (FIELD_GET(RIFSC_RISC_SEMWL_MASK, cid_reg_value) & BIT(RIF_CID1))) {
 		err = stm32_rifsc_acquire_semaphore(rifsc_base, id);
 		if (err) {

-- 
2.43.0

