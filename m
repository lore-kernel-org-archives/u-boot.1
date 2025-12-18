Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB592D68BEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB1383D00;
	Thu, 18 Dec 2025 09:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="D3re2DY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCE083D0F; Thu, 18 Dec 2025 09:26:11 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1DF283CF3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6wEJZOKArnGSG/3r31g3VZ5Rg4Hjycecfj1kTPzkoPC2ltzt3ww/h/UJpVKKs7VNC+jDfANuIRK0ooaO83oa3waC+qlbedwOxYCUvGVVQkcoW6GS9Ej/mXQ+q2gHJlpyN/pps2yN3sdDseRHX/BkXqtdjcfuwaPiy+gdmlK++v6WXkCuoizOAEidtQTHYAlXJcrTcoTwhrNuQHfboKn3eW2RsgExaRm2sY2rQXIZDgo3YokKP/8OIW31dwTjq3bB9T/tpWA+QWQj1u1yZVcKx/hFMTymBuzxwOY15nLpmAHYKXYb6b/mnbBpjdx/hnsIrgmjbX7lYBiOMFn7OW95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGa9jzNtYzYlyrhr+T+FcrW9kmMCSX/qu0hIb5ly6N4=;
 b=bay8NrcqnbbgEf3FXXUH0rlDqo85ofMKGIZNSNrZpTROxWRxpVUKmrMo6X3ElAXWaMF+pesLWAQkRBhVv1onvy7wDRIlK8KOD77pOeCgW6Ke/Tpcaa8ut+gX+BEQYCHrdllE622afUysydoAUeJ7BXqryV8FEv/tQv7DeripUhDV0iLU9jJynWjcfvIO6jy59lkSG7n2417H62Xny4elrfdN8MsYmzQp0xnRTJgmg+4UdQSQW2+JU8JvextXO+atk9psj8KD3CLlyXic7z3UQqp5VbtrNKVnWzS6SL7E1Y23pHeRWtbT/m4Nnaho+09beBHEXm/Up2Oz+fsVmUF9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGa9jzNtYzYlyrhr+T+FcrW9kmMCSX/qu0hIb5ly6N4=;
 b=D3re2DY6ytXK1ZtAAJcY7Rc3ZDgvVc547RgBzJd8HMGKPK7uSVSOwKYz7TyzXwbVBWfqwgU69DSk0w6c6FuinjrOO4FKFHEfKZG0/1MKt9El8hP3dwc1ZwMq0VC7/aQ6ovoUSkFp7rOz9a3xXbVHYiLD5Y7EbjQmfwW6EYMgRANqjowSXRYiNtGXxT6VNd8LbKSc7lsyE0b0MxGc/y/LfgMNrv6/V/ZE893yzx4K3T1TFZuDeUCjyP4bc6urCg/r0W2K3HvPmawQD3MX+MifGA7qXTNqrrX/MxcKs/hU2TMpqOEs45QZVAhVqHawOMlUxcLQSIebkO3YdyFVzVG1Rg==
Received: from DUZPR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::6) by VI1PR10MB3598.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:139::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 08:26:05 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::7f) by DUZPR01CA0057.outlook.office365.com
 (2603:10a6:10:469::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 08:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:26:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:53 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:04 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 09:26:00 +0100
Subject: [PATCH v4 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v4-2-ff95bf2062ab@foss.st.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
In-Reply-To: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|VI1PR10MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: 5debb166-9c90-4a38-50a1-08de3e0f1635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alBiQlg0Sy9lRUZRRzNqemdTUEoxTTFyZmZNMEpLYVBkNmYzQ2xwK0cwNFow?=
 =?utf-8?B?eHdScW5qOFRNS1VWWlhwSkFTQTFGM2NvWWpHTHIyejhURGFTLzlNUTUyU1Y2?=
 =?utf-8?B?cnlWc0hPdlRRckJuRUQwaHY0V1Nsd1AwWXVGL0x6QTgrSjYxbGFNQnBNSE40?=
 =?utf-8?B?UmhVSFA5bjdnUExWU1N2a2crWU5DbzhXQzh3bnRNUldhMFhXWjBCcllZZDM5?=
 =?utf-8?B?Um9vcUpXSEtRaHA0eCtNcXJab0N5a0ZKK1VzcVg5cWt5K2VEeTdGVndDS1Y3?=
 =?utf-8?B?VldXdk9McFNVeU9WVEw3dzlJRjhzV2I1ckZaME02eUpoOUFndzR6UUQ3c2hY?=
 =?utf-8?B?Z1E4SlozamJMSUxmdUp0RW9tQnZURzZJbEZoNVFjNm1XaDhUUy9ZZEtzWlRJ?=
 =?utf-8?B?RnlkWFBRb2haMithQ1ltUU0ydkdBWkxhdUJzNHpLTk1kTWE2NjVMOU1PeVYz?=
 =?utf-8?B?Ti9IT1Y1eHQvY2hYQmYvU09WSE5WcVJ2WTNCd0hwc29OS0ozRWhHM2VLNUJ4?=
 =?utf-8?B?WmJ3ekJhdDA4RzRpbUxCYkhCOXI3clkrVVlISnp3UFpwbHdVUWQ0d1hrWXg2?=
 =?utf-8?B?bHZBY2VKQzJTc2lIMWhGWDlkckI0OFExME1DN0dIcUR2dTMzZE9EczgzVlRj?=
 =?utf-8?B?SjErNXBWS1dHbTNDSjNOd0cxSzVtR1JSQVcxUG5nVWVDL2REOU92WUx0MGVO?=
 =?utf-8?B?OGVSVXZaWUpTYnpDVjEyNFozTXo2OE11MHRzd3dyRUhGS0tyQWxWNTFZVngy?=
 =?utf-8?B?U3J3MjNBRnQ1ek1zaTAyMGd5L01HUjl2MlZYTERyNS96R0JyazByWjVEQTNq?=
 =?utf-8?B?RFMxdDMxaGtSQUNCRVVJZktNeVhsWmZBeUhmc3g2azB1Rm56QWZITUc5K0N1?=
 =?utf-8?B?QldYNzNVRk01Z0hiQVhPekpOeDhnRzR3YjJyc2tUZFRaT1VxU2NaVkQvZnVn?=
 =?utf-8?B?V1dRWTdoWDhNdURqenRHQWpjeXVCRVdFWHZOTDZuNnA3SVJPWkdMaUY0SWRI?=
 =?utf-8?B?UWxoTlRWbjV5L3BYVVBPU2tjZ05iMHpNVi9PZUhvVDUzZ0pwWmh6WHk1OWdY?=
 =?utf-8?B?cUt6eFJVYUhIcXQ5cmJ0ZlVmT1lIS01KeElMVmd2RzhZbGQ3am1NR2tnMEhY?=
 =?utf-8?B?UEU4Z1ZvQUdFOFIyN0FaR2NsWE5IeEVxRTNnMEFFVXRTUk9jSkd4N1IxVkhK?=
 =?utf-8?B?QWQ0bTc5V0RRcE9uVVRLTVFGRVZQMWNCRXUvNDNzTHA3WW1keXdoS01EUkhu?=
 =?utf-8?B?MHVEeThRYktkcU1mOXJlU3ZSN3NaQ0sxbmZvNk50R25NZXd2N1UzQ20zTmxK?=
 =?utf-8?B?ZFFRRW9xaXpHVEo5NVg5VytUcnlFWHc1aEQyU2ptYTFNWHJSUTdVSHY5Y2d5?=
 =?utf-8?B?OTB4T3RqQjlkWkdVanhidlBTVk9CdGF5QkRLUE9qSllrTjMrTHR3NVNXbEdY?=
 =?utf-8?B?aGJySERHWjBGVkYzNHlsZmRrR09meHZIbjRZeHNuVDU2YlRpcnBiNXFnSGs5?=
 =?utf-8?B?NG5hUjBVNitHT245dU1kd2VOZTNzdGZWc05zM0kwUDMwWUdGaEZORUNRd0Jq?=
 =?utf-8?B?R0NBZjN5bkZVeW43Vnd5OHk4ODA1RTFBa1ZFNk1EM0ZxYU1BWE1JNm1pNUNy?=
 =?utf-8?B?NjgyaVdUZ1ByRDB6YW9NSUM1Tkh6RmpqbW4wbENVZk0vR2dFTjM3ODB5Vy8w?=
 =?utf-8?B?QkZHOFM0em5wQ2FHSitzd1Bpd0FTb3RqTDBJMGVrWnpUVi8zSHh4dElHbEla?=
 =?utf-8?B?L1ZJRTF4NVJyNThZSGhCd0JXcHhpdlp2cGFhYStKdzNHSTJkVDZDbWtFTWds?=
 =?utf-8?B?SzJGcW9Eeko0Y3BjYTRBRC9uUHFRNDBxM3NoQTQ3ZXpDWmZ4SDlzRDFFLzVH?=
 =?utf-8?B?cUpPbFhtdUswNVdxdFU0K0d6QmhiK0xIT2N2bWt3MTFkNmRhbm43RUdIZGdL?=
 =?utf-8?B?MnpLcmtaekRYSnR4SFZpTmh1ZXFNY3VqNUM5TzBreVptYWF0ZzNpU1BubzRV?=
 =?utf-8?B?R1pFMXNyR01qN1QxU0d6THBPVVdTUXk5bjREazR2cVIzNjhQMUNLVW1GM2Fx?=
 =?utf-8?B?U3VyL2JGcVpLNDVQUVl5b1VwamtubXdib2hURDBlTXA4cTYxaGVMaUdMdnQr?=
 =?utf-8?Q?aPgU=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nQnYACY5IYsmBwQlS8dSalPzT0MZ8O5phR9aRhk+12Cx0DSXthDtR7+d23MjXFqFl1pAHdUeYUrP7ceFFLezTpANmLrpCOBPZv13O6l2OEs79S9Sfj5quvDX+rxgBeFHa1QsX2ClcMBmuLHgTdf2vu988zURFYpmaoCNxi/Du+erHtU9rQbOK0FZ2tA8JwRdcgIf1B0sRBl2IoJcx0/A1KBvPdU0DMhtig1hNKpIcssUCBapG7X86BlWEH0O0R0lKR+PcZbR8iVzity45ueDx2hBx11sd5sbReGZAD8fg2tToSKou5AoQnHJwnZNRES39jJXPyVQOaxT6OAypuf2hc61LQvVfaZO14NfoA1faUDeWMMoI5bpSzUsd7KwxGUbL5ttuuQO4WYu1/RE2u+oJcQZUnjuadhwEoLDdcBJXOEYMgb0pRT+hocjzHi+SlKzPjt+BxWeF/oPsvbSgfdhrxSf2qYhNpG+nAsp455FzIAlpLmppwGPFcQw0wR5dO2NKBmdaKxMcHAt2fcE2U2Lmu5Bjhn2hQqk7GGi9N+hD5RdQyOjcZkxgbDsRMt+RT6B0FKTPOVDwAC3yV+XP/9hH5WqCmY8lQ/0mjIunYjr9M4DhVtUXnUVHfCTDE4MvP2hmI4qdIPuaKkVsmG4stYeA8TF7fHjgw6WsEf/U7bt4+Rc9x5gIwHbYkK3y7wEDocNBdEooAYriUcXVl9WPJGq0g==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:26:05.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5debb166-9c90-4a38-50a1-08de3e0f1635
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3598
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

In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
retrieved.

SCMI request is performed either using scmi_clk_state_in_v1 or
scmi_clk_state_in_v2 struct depending of the unpredictable value of
priv->version which leads to error during SCMI clock enable.

Issue detected on STM32MP157C-DK2 board using the SCMI device tree
stm32mp157c-dk2-scmi.dts.

Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_scmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f6132178205..a4fc4f8da89 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
+	struct scmi_clock_priv *priv;
 	struct scmi_clk_state_in_v1 in_v1 = {
 		.clock_id = clk_get_id(clk),
 		.attributes = enable,
@@ -156,6 +156,16 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					     in_v2, out);
 	int ret;
 
+	/*
+	 * In scmi_clk_probe(), in case of CLK_CCF is set, SCMI clock
+	 * version is set in dev's parent priv struct. Otherwise
+	 * SCMI clock version is set in dev priv struct.
+	 */
+	if (CONFIG_IS_ENABLED(CLK_CCF))
+		priv = dev_get_parent_priv(clk->dev);
+	else
+		priv = dev_get_priv(clk->dev);
+
 	ret = devm_scmi_process_msg(clk->dev,
 				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
 				    &msg_v1 : &msg_v2);

-- 
2.43.0

