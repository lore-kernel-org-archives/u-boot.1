Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A505D65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA0783BC8;
	Wed, 17 Dec 2025 17:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="L6BDjHOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C6683B32; Wed, 17 Dec 2025 17:45:39 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E57283B55
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuzFC4vnxMi+CY+0dCpsQy8nyEYpBxNv50FyNR+osAGKmKfwUv134Yc17fWKMqEqRFZMV8fy7WVNFgIj0a0fA6PoVXYTA5AZEipeG9vb38JZerbf5Tv5VVEaVGmx7bCtNUtW94l0/HTCx+kKFeie/c+0afoumCZNWy04D1WoQmx9/uxxTETgFIHmAbmr062KJDeEnlDwjbJGHfNbXZrpJwuuCzT6RL7+MQHmiq6zgZ+Y5LLxq1z5XnGhor3cqhoTW0S8wJFIeRkjE3q4wT7Wtbg0E0oa5ly7fm2+ydf/gOxK2MSeO6NGUaE/4O7iZQ++LS1fZS8/cKe/fbxunVEpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCIAYI3AUhbAWxslB9wx9u7N9XEy9dWSHCs1H4+Eaes=;
 b=F6h/5My52gj0lfEMawK7JeEiWhhIGo9JApbQQYxiPquel/XjuK035vClMNPK1UdupRo460sDkyhZEP3p75pJfRvIFmx/QRKrD+f53R7aqNcSI2ha/H4SzKRxQ1Mx7uKDsLMUQs4VzdpGn6WiyxQ0l43P6C3V5JRitBIWypIhXuBbr2GV3rrSwYxlkHJWziuxs5UNV7Mpu5iBv0Xy2XafcnrEskpFXjfUKLWgMeq51mt9wN1hxBaLQikAzhYrrYlojGt3eXLF8wInOJgrLR+eXdhe8OcZspxShaHRQQNCVKLxDES8sdJhRckIts6fhQ7HaJhCsds67FedK14P8bbE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCIAYI3AUhbAWxslB9wx9u7N9XEy9dWSHCs1H4+Eaes=;
 b=L6BDjHOUof2wOxN6ptgM9ho/7TXq7ru42Bq31RjXeuEO+vXbRbtRUJYEi4J08vIK0YJKluxvz7c3x6IgFIe+ISaVvs2AKj/55xGvSARWQ1b7UMkM50a7IedR2tZx0tl5Au38tp7TtSsy3ILr7hfle2+WuYj8mA82kZhNXjMRKWZNeQ49FuoljHgq0v/APQCxhhEhyGRZssoNd/zue6N31OPIvsdayjAnySU1/th7HMsBQibPC4knEH0vxQ5dO4s244X9Gwy7Fu2oWAAz1dgJwmv5midmr0tsC0actuaHlLgatBjJ7sLQzad2igYrATImpKvAduqkxEVlfysxuwhKYw==
Received: from DB9PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:10:1da::29)
 by PA2PR10MB8697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:45:35 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::32) by DB9PR05CA0024.outlook.office365.com
 (2603:10a6:10:1da::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 16:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 16:45:34 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:46:21 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:45:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 17 Dec 2025 17:45:30 +0100
Subject: [PATCH v3 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-sqqs-v3-1-f3405fb2ad1f@foss.st.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
In-Reply-To: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|PA2PR10MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6aea7f-6c02-4a44-dabf-08de3d8bb31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWZEenBZaDhnM0dhMjRZSFRYcGpPU2NuSEtsdDZGeUdYYXZQdU56Zk04VjRv?=
 =?utf-8?B?U1I0Slg5L3ZJRHM0ZVBaYlF3eE5NMmFmRDN3aENwRCtoQnRJcEFvRWFhdVo2?=
 =?utf-8?B?TDQvQndyd2dUTEVFZzBNNHNJV2hnSnhyaGNIV01COHF4RGN6ZUNDaFJSeUVS?=
 =?utf-8?B?TlVybWQ4WnVQZGJnY1B3bHFLU3hLNzlzRndMUTk3UUdNdVJNL0pPQW9GQzQ5?=
 =?utf-8?B?MHZtVGl5d2htSVAzbWRSRW1YeEhYemhBNExEcDZIS2FYbHM0MGlpL1UxNkcy?=
 =?utf-8?B?dmtHS3lKbjVuT2VYYlJoSUsyMktMb3hzOCtzR3FlSVZZUjgzaU45WnJCUnhO?=
 =?utf-8?B?ZHNUZTlrOHBpTDlISUhPS1pjMHlIUjVjTlZKRk14dy9mTzFpbVk2WVNVV3pH?=
 =?utf-8?B?MlZhZmpjNitnbnhqTkxyVUtNSFZhdHFwdldCUzg2MzVYb3dWaWl5N2tiSmRZ?=
 =?utf-8?B?WjAyQ0VMRjhZNkdGNWsxNzkrdlNtLzJIR1dYRHZkWWtyL2RYZHM3RDlzSnFG?=
 =?utf-8?B?VVNTbzRmYjlPa0RrcFRZUUI1Y216TUR5Q1BuMy9MUDlrL1crU2dJdWZWS1JS?=
 =?utf-8?B?QmthVjV6NFpjR0tSRWt1alE2RlNjWmxZdXdUOCtpZXdoZ1BHTVQ1T2dNQlhn?=
 =?utf-8?B?RW9VanhueWYyc2FYaXRydjFEY1VZbnZXZDc2UE1jR1hlS1lGbWM2T1hTZ0RN?=
 =?utf-8?B?TU9KYjIvNHBhSHQzdzRvY29sMHFMWjN0dzQ4WTc1aHIxRi9weG13dGc2czl0?=
 =?utf-8?B?OWxFQnRzNnczaDR4NHRCbzdocmdhWjROU2RBamJ3cDhsSEpzVkllUnB6cEJG?=
 =?utf-8?B?R09Eb1RKbmYwaWU5NGtPdGx3bVpPMHhhRElXbDRZVlRxdjNoSUFMNk10Qml5?=
 =?utf-8?B?b3crT3BUbS9QU1VZRFc1dWtYeEpsT3V5QzcwQStOWGMrQzdFL0poUnY4R0xk?=
 =?utf-8?B?SFp5TTllV1ljQ1VzOVVUenBybytTNlVwTUk4WlMzRGVjNGZKMEcrb29PYkNm?=
 =?utf-8?B?eDB0QmFjWHQ3QXNZV2F2SHRqZnlEenJWd3l6dVUzVjVGdVhLZVV6dy9WM1N3?=
 =?utf-8?B?a3JFRHBybUlWYUs4YkRrWE5QWjVsWVdSUU1nREdsTGs3TW1zWVRTNk9icmRE?=
 =?utf-8?B?bmhHRWJRMy8xOGU0RXRLRnVYQVI3VHhTRVJGcm15VzhlaTB0MmYvbWtsLytP?=
 =?utf-8?B?a0pPV0M0UnRnTWlzRGl6T2JxZUV0YkhnTzdDVXVjN0tuWnNVUlh3TWFyelNE?=
 =?utf-8?B?L1Q3aTJjUkZsWSsrWmgzeDlHZyt3RHBKWTRnS1NrelVFblA4aVQ4VmFHbXRZ?=
 =?utf-8?B?RkNZZld1T1ZaeHE3dGI1RjVsMUdCc1kwNjRZdlRVR1dXRGJRdzJmTFUxT01P?=
 =?utf-8?B?N3lhb3NpcGo4RmtuUXB4RUwyWnNKd2dYSGlyNlJFUXVHaTJUQTVULzFxYnVL?=
 =?utf-8?B?aUhSSUhLcldzT3c1WWh2R0ZqMnpGZkhMN015U3FJTWxUVzBRVnk2OUUrcUFQ?=
 =?utf-8?B?VDY0L3gxR0NVMXdRZ2VIR0hPSjY3NVpTa1B3RlYrT3lXQ2crWWNwT0lrcTFH?=
 =?utf-8?B?K0E3dXBFZCsxam10MmQxNjhwaG5DSDhCeVFhM2IzWnY4U0FzNmY4VjRiNmtU?=
 =?utf-8?B?K3UyK0JiendMeDlHTm1WOXNPaFRvdzFWb2RZZWJDVm9QZHptSkRLRHlvTzNP?=
 =?utf-8?B?N0xiWUxEVXVDVS9SZ1ZiS0I1MTFoUDVaVDNaOHFkZEl3QXFwTklPRlNBaDNz?=
 =?utf-8?B?TERBRGVzVkdDbzV0aXJKaHozSjFNQ1VmOW0rTUFZWTZDSlUrK1ZKQ3hKaGNs?=
 =?utf-8?B?czBMdG8rbHY0a1hmeGNjZkZGaUsvVk9EMThCdkVhN3g1UVlUMnlKa2JjeS82?=
 =?utf-8?B?UVBLU1hkNU13eVMzV2xjNFlmWmliNVVScXNrYVRtaVQvcktacTIrcVdDMzRC?=
 =?utf-8?B?UHJ1SlByZXFoTUxmYW93Q1VuQU9uVVJPTFV1M2Iyd0NKMGYwVkZ4NjhObmVW?=
 =?utf-8?B?VkxiZHUvY1ZLTDdlbUQ1ZVMwYjRreXlTNkFVUHZFZmFpb0pFZDBtMzhXWUMr?=
 =?utf-8?B?UXRyNXVCdVVoQklNZ2NIdUpUOGVleGM5bHlSbEM4N2UwcFdrRXpvcFc3V2dK?=
 =?utf-8?Q?Yh0U=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jNvANCqP3rVJ58pdlcGx2A+nv6/GTQwe1RsOCyomdLzdpiIThR6V5nvQ/hlreL7PbXQ1fKXSm/jWg1xnGcWRiQHjZ+xdl4ritj7vyS6oG/YkK4iOMeZp9Of0UNg7gPaSvz07b3n5hM2JAkXx1pAKzUnqOOLpsolMTH+RDUXOLMDdiFlUENZzxVBD7pPGPOCwwfVlqBVhBoE3Br3/hOXxBATslxQY/IluNnV19bo6jAov72c7uZltGUazhqaihPWYHivFAaAFqtZnecRzgJbOxiYCbtYsUe+OvXij6R4sLCnlf30QCV97GQErW/JNQt5kdJuZOPgeyvK5fpCMTvdIBDUZEvEAhddAM1e+mxIACjr5yN+JuONzFeHO1B4Zg3hgZiMzA9cf+MWJYWm+NZtaJMe/ZDs4vrAct4uQ4/Pb5PeWRtBylpTGz8+4tG8ZL/WyHiNui1IF4AOqV22hMWlRzMXIEw9fw/8ofb5Xqt8QhF+vsXccR4CgQRcTIoP4AXLEElSVrsBkb/hx7T094cG+AMm6KbGkXCNqabDtoGb4hnbbap4QAjqPCJeIhBwVVMIjzL6HTA8JYFNMmDWEpttSbBBc5ZPF7wknJGniD0Dq8b2oH9upSQ6cmf4J6H+oFgZG14i72p0ynkkNq2TBbHCLRyvsr7VqPxrYG59rQcHoGaaGOI7vXueiMpSXuWyveGvcWtYzfmnwV7D1vvF8G67c7Q==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:45:34.6887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6aea7f-6c02-4a44-dabf-08de3d8bb31d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8697
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

%s/scmi_clk_get_attibute/scmi_clk_get_attribute/

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 683ac822a01..f6132178205 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
-				 u32 *attr)
+static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
+				  u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
-					    name, &attributes);
+		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+					     name, &attributes);
 		if (ret)
 			return ret;
 

-- 
2.43.0

