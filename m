Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C137DEA3F38
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05AA83D71;
	Tue, 10 Feb 2026 11:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FZm7K4I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ACCE83D71; Tue, 10 Feb 2026 11:26:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F2383D17
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ9Ifsb7DTcqjP5ymK1Yf1UrJsWfy2pe8P5/WEuZzbvH2nqSlERgMhWPWwHBX6uPbvygKDFDTrKhgH976NeoY4NAaAYS/6EMV6KojJ/dvu2LG4VTO+yMrwjmcaGim6a3TZT42adhu21Gk/7LKXut5YL+4s+g0td9uIgjJtEgcfDlz/U9Th/jUEG4UQmQp4B44rcwZyQA4VV0ji6DphgUpwBXn63GCsMUFER/BXzZEQirY6yZMbQhZ4WFNSZLSJTuYXLt1TAMmppjsTttIGiGcEnyFkZOTpWeFvtxl+sqCroBg2Fonok9KHY7IYa59JEDnd/OEhH20hI5a1TkVIqCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3d6wfoQyMIzuP3WTgv6Xf7mz9dTlfPR/NXQi5w2vfU=;
 b=iFDwUDifRMIRLWL6JAlsT3qRglp0bjWO1h3811IY67EQxq1H3Wa2vlwC001BNrZU3EFumWbBWlmDu5Pr/IF6t9ppGn0yvK/P7AZ3gU0hlaBKl8w7LfW3C2SvgN8fAwB6ReH7k+N86FNvPiUuuIdjaZccnfRMYu66uwas+xPy3OpjB0fgxucHtE9XdjETGry4FBgxXrU7LC6C8AFFQtAeJ55/LlZan725wAkSFerk++nk5YcFIcjLpgzZp720jx73Q9+vpZq3TS4YSF+CJMGXbCsFGGmRGW1U0qRHB3+giyXeoIXXETdPkWnblE2JhPz7/pCQYwtwseRJLxGn/dqQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3d6wfoQyMIzuP3WTgv6Xf7mz9dTlfPR/NXQi5w2vfU=;
 b=FZm7K4I7i27/LL7juab5p0yhql2KBw6stqxcklbCrmFaD9suvgQSWtXJnA6nSnoq3MXgzlVi8W+UKJY5DKtrp1k6Njo6GqfakxIgy6OQOey7REw6qR8K6r3O3AD09VDJWQ++DqgtGDZ+GkrtiGCf0phkfjRovcTlQjnEMm5eXa+sIdClC6X0xjjMy8DlSyMWzItfEhmUL/PLKtwD3doT1y3QRYTU13YiQFABYOVTjnSxapZ8wIDEzi8SXBQLKpX1hoIfM2X915KKfIsFDnSMCBqi1KsYVdAB4AgJi2f4jJU5wfIR6zhu5hd6B3cb1TNewGkCr023svQua5606aTbsg==
Received: from DU7P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::13)
 by VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 10:26:13 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::43) by DU7P195CA0010.outlook.office365.com
 (2603:10a6:10:54d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 10:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 10:26:13 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:28:03 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 10 Feb
 2026 11:26:12 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 10 Feb 2026 11:26:05 +0100
Subject: [PATCH 4/4] ARM: stm32mp: Check secure state first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260210-upstream_rifsc_update-v1-4-74c813fa4862@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|VI1PR10MB3309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc3be76-dedd-4042-41c0-08de688ed0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG5OS2dPMTBSeXowQ2w4dnhYeURWM0tnWFZKTDE1bThBbFFsRW5XZ3pjY0Nr?=
 =?utf-8?B?N2dTczg1Rnd5YU1HYlQycjk0dWVCeHA1MEE3aUdBeWJRWDhWdmtMRXhudTJJ?=
 =?utf-8?B?UHRjVzN4N3EvYmk1a2N5aFBOZ1p3cisvRVk4N1FnMEt0SnZOZU9yeUpReURt?=
 =?utf-8?B?eVRyQkRwMUZsWk83RlJmQitoSzV3TnVOODV2RnUzQ1VkMUp3NU84bU0zWk11?=
 =?utf-8?B?RzJiK2pzQi81dnhrSG1tTWtqWHBFRERNdjFmWWNhdTN1MEIwQkNERjdRdUhz?=
 =?utf-8?B?Z05BWm4xMlVDY0VKenNNTGhCZlM1WndlZ3krU0h0dHowbXZ5b3p0T1FIMEhC?=
 =?utf-8?B?cEZtUHBIVC9SbGorZnVGL3BQR3FxeTFTTTVHT01MWk04TURRNVRkWSs2eEdQ?=
 =?utf-8?B?Z0xCbEtnczdMeDRodld3b3UrYWFpRnVBczJ6RnpqdkxhamFYNzNGZFRBRm5v?=
 =?utf-8?B?OTdWclYrMWJYMHlhaWtCMFNsQW45Yml2bHdzdk5TU3VkOWM2OVNhL2J4amZH?=
 =?utf-8?B?aVVFZzgvOW9nUFVEbC9PTHNsTTNLbE9GbTdOL1RIa0FKR3BINXNEaHQ2UGU3?=
 =?utf-8?B?a1NDZ1VncXNzelZTS2NEcG1sZEk0bHcrNUNOUHViL2dEZEozNVNYdFpaQUpJ?=
 =?utf-8?B?MEdNdmFBVHZFWXZ0eVQxRFp5c1BLS3pINUxiNGh2ZDNobVBOa1BNcEtjVml5?=
 =?utf-8?B?ekRLeUx1Zy9veWFhYWRXSkU2V01pMS9QSVVjaHcxT0VwNnhhbmFLcHBYakxz?=
 =?utf-8?B?Y1pHa0t5aithN0QrekxTRzNNSVlmVHIreHJucUo4KzFLSndiNmRNblEzam1D?=
 =?utf-8?B?MEh6djhRbWtZd3p4M01QcGExaTBwdGI2VTAwcUplMGx2d3ZJQm92S1NSdndF?=
 =?utf-8?B?dDlrVWg2NUpQK1R4blpVY3ZieFNpbm8rcEVnUXF6NCswSjZ5cnp0OE1iSm9r?=
 =?utf-8?B?MFZEQ3RvZFlQZHNyZjEvTnpzbjFCMzZUZ1dreGlHOG41dzl3eWhvaHFlN0RH?=
 =?utf-8?B?QXZ4Vk85VG9qNzJEbm5kY2Y0L3hWS0tHTDFLQnA5RHJBVklWcFoyUHpkN2NN?=
 =?utf-8?B?d0p5RDcwYXFCNHQ2Tm9jMTZIb1pDTXJlNytKSWZKWHJLNlRMS2ozM0JEMVRN?=
 =?utf-8?B?YXROMldGNTV2SVNlajRWNkQzK01TV016Qit4YzFSRlhIZ05rZ3h5SzFqNk9n?=
 =?utf-8?B?NksyRi9XM0NzeTd0WkIweUxidWRUVC9nU2JPL1IySktnZzBFT3JsaHZHWHJa?=
 =?utf-8?B?YnA0V1FCdktBZXlUQUttTVAxTTJIYmhmYmNDV0d2UWpNRDhPOFl0bnJNMDYy?=
 =?utf-8?B?ZUNKNjNNWjVON20wWGtxbGwxbWRMYWJPNGJtMmJmaTFQTmNaZTJUeVV4SmNs?=
 =?utf-8?B?UmdBQWRxWEx0dTB4RHF6bFY1SEF3bW51NkJsNFZwcEkzNnNJSmpCZnEvN2R5?=
 =?utf-8?B?QlQyRDVrWXFYdVFDYSttR0dzUEU4cnQrSSt0WVduaGJrYkJ2STRXVWxDTWlu?=
 =?utf-8?B?SWZwNXAyQm9ENzBzZzNaYlVtVHhjQVdDMU9HTjhJcWJpVERxT2tLazBoaWJo?=
 =?utf-8?B?U0dIaU5lNHloZWVuQlBReWh5V00yV0pwbTFQckN2L09iZHhOb0Uxb0Rwd2Jl?=
 =?utf-8?B?S2NDRk5LRU12ZzdUZUZMMTcvYkNyNnVnYTYrcWpUTEF5WjYzVzRGcXFRUzhr?=
 =?utf-8?B?ZTFMUWN0dGFlL0NDd3JJb3FMUmhiVnR5T2hEM2JveXNsai85Q1NNOXZ4Sy9L?=
 =?utf-8?B?ZWxJNW5JT296UndHbS9RSkhvVTJwYlNHRWhJMWpCbnhHODFWRlg3MUVSa3Nx?=
 =?utf-8?B?MTBDbjN1RmF1dXZWVk1BYkVZZHcxV1QvSFE0dXpXd3dISzc0dndyQXBId1Iw?=
 =?utf-8?B?Z3kyYUhQQ0dscUhIZzNLYWMxTjZsd1BiNXdmTTl1SCtNTUxraGRWVkc3ZmFH?=
 =?utf-8?B?Uk9QeWFTbXZXcWw0d1htaFA5SjI1eG5IWUxHTkEyYnlKYzhKWDVwZGJpVzZ3?=
 =?utf-8?B?TzV1M0JNbUVOWDRRbldVWlBHSWptSUdoUDR6UHAvdER5UnZJTHhwTlZGV2k2?=
 =?utf-8?B?b205TWU5VWxFbm1vTStSRHY3S2FUTnNJTjdxdGJjdzVZSld4K0RRL2l4cFBX?=
 =?utf-8?B?bnd6dGVJa1EvdjJNaUE1bFRoT3Jpby8vZjdtVWRmamZUV0NzT1l2UXlzUENR?=
 =?utf-8?B?R1BmamxHWTdaM1NkQ3piY08xN1p3dHdySlNWRmNIWHFhQkdPZmphSlVsN0xv?=
 =?utf-8?B?ZmNpMWs3WUZUT3kyQjZuVmpLbVZnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9XsgwVlFseCsj4JQv9jeCtqBhFPLzBe11SJ+UzCq1/XrBE+d41bsmRYw3im26I+DjTip4UyeMizZUCmjnKIuS4t5hae0o0w07Jefzz6JVdL6WX5YBRPb3Z6x0m7kcsLgWNmgGUKpBGY3YbKNtkELj4DXEaB585XQA/GQVj/e6B4mjzDQ429x9HWmdSzBKru1naNoqu/zEkcBHBcnTuDE0xuMMUjl8Aeixza7Wd2sW3G9xDX2QYH4FHrCq68v45ZXY3/fy8JXm7lvvojQiw5pRYNiMmj535ep3J7Ko1jNCZ+J5XuuvKAOrfZnE8Xr2SGCeZ1iywOsECGkRa7tQO5zdJ4VnfeRxeZc7N/YjECy8ql4b6ve1nwkVAFatoXfHkjUx/36+FpRH/6Z5cm3V0qt3olWlKnJYUSJkH4JPalw51YIWKCFiCTpoKpgDNN2IMzA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:26:13.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc3be76-dedd-4042-41c0-08de688ed0e3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3309
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

Secure state must be checked before handling semaphores,
otherwise it can cause an IAC.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
index 0ef086bb956..9db8b9efc64 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
@@ -141,6 +141,12 @@ static int rifsc_check_access(void *base, u32 id)
 	cid_reg_value = readl(base + RIFSC_RISC_PER0_CIDCFGR(id));
 	sem_reg_value = readl(base + RIFSC_RISC_PER0_SEMCR(id));
 
+	/* Check security configuration */
+	if (sec_reg_value & BIT(reg_offset)) {
+		log_debug("Invalid security configuration for peripheral %d\n", id);
+		return -EACCES;
+	}
+
 	/* Skip cid check if CID filtering isn't enabled */
 	if (!(cid_reg_value & CIDCFGR_CFEN))
 		goto skip_cid_check;
@@ -162,12 +168,6 @@ static int rifsc_check_access(void *base, u32 id)
 	}
 
 skip_cid_check:
-	/* Check security configuration */
-	if (sec_reg_value & BIT(reg_offset)) {
-		log_debug("Invalid security configuration for peripheral %d\n", id);
-		return -EACCES;
-	}
-
 	return 0;
 }
 

-- 
2.43.0

