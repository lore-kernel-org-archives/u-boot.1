Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E7FE8305A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AD483FCF;
	Tue,  3 Feb 2026 07:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o0N1ydY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5A883FD3; Tue,  3 Feb 2026 07:36:07 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0300483FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaqArfDo4y+TNeU2Y7oO6gvFfJNkXaK4fvt60xh+wUdigCT9SLBOH+MVe8rvDm+ZeU/6NEEHHLQ2QJL5G8S3sYjRApQdk228bSYuLe1h3lnVJSmwAk4jDvSTyhfiaSn81Hj2ETVMwmgKJIezXym/7pmwYk2w5zgLXNrZowzBkaJe+dtV9LKpAsE31LRnwXGJgAEBTDT4Un0VJDlKkhxudFoaHfiylrxHfBkd4m377nAx54GQzQXLlVR0p2a7vAGWIR9ojP3p90psn/c6v5I6lgIf4zpT/7wnzoyoFDFRKKHbb4lFhHQOtiFm+CCj/GNegtOAJ90zzpuSOsR1ndTV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWrm3M9HgfP1K/pmxygCIo5k/jWSjy3d/2txHHCuTiQ=;
 b=pHT9NRyFJpjFHz6j5zG3RgV235kTdetHxgULTveOw3vS1F61+oh0kHgsPgxAgoV8H+6NqUBZUPDBPaKyCaYERtwEQbGVjznFwnPjgnjbJc3ZH/P9+UG/18zqiO17gL8dtw68BUEQNQfyZV9LyafSQaS0WTLNlDnQxSFoumXIId+UmMPhfm9TUZY7dGra8qVj253OVfBhT1mM1qx5YKDHkMS6pmYKTHVrgsvH2fqqVx2KCZt1HivXgF9305Qaiy9aTqszNJTzOcx07kgRg7cunlPsH1+/mjyempI/FeDidFkHT1QrD+qfsJGlQ9HQ98O3grBPA2ri27rWy2QXklaYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWrm3M9HgfP1K/pmxygCIo5k/jWSjy3d/2txHHCuTiQ=;
 b=o0N1ydY5HagTeKoSXmM7lKgMt6/bWFFAGB20cXJdfh5CU23hLpaR1Yz4NSEQAuCGCodDh+4gYfTkN0ajvILyV9WlLvwtKSkH4WNKeWcJd+6SIDbJ2gNjrqbLXx4j0hrT+WaIVevW5+dew4zBxZm1lKBVclCAvV7QCmxlJjGppEE=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by PH0PR10MB5682.namprd10.prod.outlook.com (2603:10b6:510:147::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:36:02 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::25) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 06:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 06:36:01 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:36:01 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:36:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:36:00 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7X3483536;
 Tue, 3 Feb 2026 00:35:59 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 4/5] arm: dts: k3-am62a: Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:28 +0530
Message-ID: <20260203063529.1551907-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|PH0PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: f64b21f1-5807-445a-0d76-08de62ee7fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s9hliaBgX+Ov1UDjYcA906bDvzryjeUzDUDbp/a7ULpEletZdIx7GPJYcYrp?=
 =?us-ascii?Q?bVRVeNUsTYBA+83Cqa99bJTURX02mrlQ1DXUcyAMsoG+PDT+zZzVeCOZI2j8?=
 =?us-ascii?Q?ati6S4OmfylQoXrhggUcUjHEJ8qMabKIRrJldsQTy+alaaFqsCE6yNSme5rA?=
 =?us-ascii?Q?9j2mqURTTk8Qqfsd38+SdEe5hDBE04Waq0/Jj0UXCMij7Da8llrtUYO6afEo?=
 =?us-ascii?Q?+xVUZL6seCnJkWpV4lwULOo5cMaiRCpn09g7E60a21dR9bdoIH1LIEMaYhPz?=
 =?us-ascii?Q?yt5a/fxyBAJKbwLM5andGeJ/icyQyPR9q7v7XDmQ+M5nAsUaVHjWlQLpeYK1?=
 =?us-ascii?Q?XgYDAvQ3fRWZ11T68IqW3PKJSZUkUu7s0uz8e9JEBxy5jGN599Llz2RNnWlb?=
 =?us-ascii?Q?CEtnNCfSY442wY1+QA3/pOkOTHNobetwZTWMBPsPOYvkHoVW1KkFtbNq7wLg?=
 =?us-ascii?Q?wwzEpcL+wM4mT2xvL6dZhsxMTunWh4H8w/P2daKOxhAd0cuaeJ5hTVS/9cjE?=
 =?us-ascii?Q?+zHr57WNIpuhRaDtpqi7PuJ7/ugPHCKHnF7M9tEc0kIDmd6dnnXGGsOHviOq?=
 =?us-ascii?Q?c9gjAlQPvrF3a00H3NcHpZ3i6yCmEL8ydaQtj192q4jEVtZuyMvlEJsRRJ0F?=
 =?us-ascii?Q?c1LMaIocczDfJbou4s8irN6wyR1+Hv0a5aCKaR41C5PSpcRkBl8j4Bi6gwXw?=
 =?us-ascii?Q?KE4O51ZefuD8wMn1UUmk7UlaqkL2CKS3v/InsseWhTs3a+E7z5/ZPqY7lxLY?=
 =?us-ascii?Q?z+g7Z07tkUan8OJGC43aTwJFedujWBIKN0d3+jt3ZXAOFrqufhIVz7nl0CQ7?=
 =?us-ascii?Q?HppxoYkOTImR4iaRYWz/0EY+9ymkRvYbsHVJmnLWtYaboqnkwQnrn1wd5+kG?=
 =?us-ascii?Q?AF/WM/5unN4e+XoFvf4AKo8yxvnpfnBkZ4vekQlap3OgYFCrGxhCAtGSZ+E0?=
 =?us-ascii?Q?Tt+acqxBUYTlOe12Ug6UB6ZfmSsEjem11/tyBIa7CpEJ17Oo6+7IPgz1MfnY?=
 =?us-ascii?Q?3qVClt98LE8vH2ELWUn6AH3Yz+QHzr2wQPi/B8k2dETA/mai7DO6OMzAKalG?=
 =?us-ascii?Q?XLgzpLm0NR58h82T/bGceKlkceyjVLdO6/1s0GybYETahCHupL5ehIl2xc0r?=
 =?us-ascii?Q?zcI+9FUMNEJy+Rwl6Y3L6Am7A7WYuYg74FR2b+QzyXkkiRJTT57g1Q10SiME?=
 =?us-ascii?Q?rtVzLFdCxM5Xwfr+zKuAnwttaCyZe9u60kHBHmTtzLCjkoeokeiEukvLS1Hy?=
 =?us-ascii?Q?6rBewH+Q9hRBEwLwJ5kQWF8kPt042Az+WqTESDQJypwikBVZHkg2U8XMI4n7?=
 =?us-ascii?Q?s1HDCCgpnvo9jdlFFL/QwQtxf0wNpOCmmbi6y+subz/uA7OMCFACJ2EkBxgV?=
 =?us-ascii?Q?j1+XQMbLWVKmBcX5UyNgspfl4kWldoIF6bEJNDz6o/1qlW6EPxLdvR0MXFGQ?=
 =?us-ascii?Q?KkFvTbmZK2XE6YWIT6OcFZtTj5RiHBGXwIYlS/rsOGLFivQNwlF/2xmQmAsB?=
 =?us-ascii?Q?+xRd5d/CxqJh5xBKLvqt1Cv216+mSJqyaizlNWrrFVNDfqYxSNZ35t+W/wAu?=
 =?us-ascii?Q?m9G8WekdrYPdZRsb//bxJvAWwTJ7T1RJEOnMbkrbbd2ifz7vlK/vebyMM3YF?=
 =?us-ascii?Q?fjNdEqRrbhXcitfNnDl5qcdnefCHtVJassrQluM0tnSf2uXY8WgJqZpWVRlz?=
 =?us-ascii?Q?x7fpqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9Fw1whtNuCPT5Ccwz0gkFnsDS3cKVCdqlimo11S56d9ZxS44LpT9rrU0v3L954tx6KBR2Vriavw7bpJFVj4H48vA4Y4bWMBd8gqJtH1ZHVorn/WkWxXFApdX/caqmxnX0LycQQbJdGleKpjnbHb8YWjBjrSx/sJo0PfocHQLFaHnz8LG9pYVJQrC8QWTzPBB117CPVmKxuhaupx5e7XDaiZp50Q1ON+ks4k0L9ABtpoSqB8Vorm4+rLrheExq2uaD7e9cjm75H2kqut+o87I556ySraFpCIaqX4WTPRKXTmq1f1axzwP41pyiCQfXjEzLfFi5iG7hPfAIIG7MfiFKIYVaBkqEFbHyAjisS5igK2b438bUew2HsMXSgBWROzVsrEcfvw+KWT6v+5L9QiYO9RR5vcuBYWXgYq7LmKpPxk/jL8K/VngcUCqaEcY+i9/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:36:01.6327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64b21f1-5807-445a-0d76-08de62ee7fb4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5682
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

Update the DDR Configurations for AM62Ax SK according to the SysConfig
DDR Configuration tool v0.10.32. [1]

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi | 25 ++++++++++----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi b/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
index 35202651221d..f0497029d14b 100644
--- a/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
+++ b/arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62Ax SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
- * Tue Sep 17 2024 10:55:17 GMT+0530 (India Standard Time)
+ * AM62Ax SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
+ * Fri Jan 30 2026 13:49:36 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 1866MHz
  * Density (per channel): 8Gb
  * Number of Ranks: 2
- */
+*/
 
 #define DDRSS_PLL_FHS_CNT 5
 #define DDRSS_PLL_FREQUENCY_1 933000000
 #define DDRSS_PLL_FREQUENCY_2 933000000
 #define DDRSS_SDRAM_IDX 16
 #define DDRSS_REGION_IDX 17
+#define DDRSS_TOOL_VERSION "0.10.32"
 
 #define DDRSS_CTL_0_DATA 0x00000B00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -358,7 +359,7 @@
 #define DDRSS_CTL_340_DATA 0x00000000
 #define DDRSS_CTL_341_DATA 0x00000000
 #define DDRSS_CTL_342_DATA 0x00000000
-#define DDRSS_CTL_343_DATA 0x00000000
+#define DDRSS_CTL_343_DATA 0x7FFFFFFF
 #define DDRSS_CTL_344_DATA 0x00000000
 #define DDRSS_CTL_345_DATA 0x00000000
 #define DDRSS_CTL_346_DATA 0x00000000
@@ -375,14 +376,14 @@
 #define DDRSS_CTL_357_DATA 0x00000000
 #define DDRSS_CTL_358_DATA 0x00000000
 #define DDRSS_CTL_359_DATA 0x00000000
-#define DDRSS_CTL_360_DATA 0x00000000
-#define DDRSS_CTL_361_DATA 0x00000000
+#define DDRSS_CTL_360_DATA 0xFFFFFFFF
+#define DDRSS_CTL_361_DATA 0xFFFF0000
 #define DDRSS_CTL_362_DATA 0x00000000
-#define DDRSS_CTL_363_DATA 0x00000000
+#define DDRSS_CTL_363_DATA 0xFFFFFFFF
 #define DDRSS_CTL_364_DATA 0x00000000
-#define DDRSS_CTL_365_DATA 0x00000000
-#define DDRSS_CTL_366_DATA 0x00000000
-#define DDRSS_CTL_367_DATA 0x00000000
+#define DDRSS_CTL_365_DATA 0x00FFFFFF
+#define DDRSS_CTL_366_DATA 0xFFFF00FF
+#define DDRSS_CTL_367_DATA 0x0000FFFF
 #define DDRSS_CTL_368_DATA 0x00000000
 #define DDRSS_CTL_369_DATA 0x00000000
 #define DDRSS_CTL_370_DATA 0x00000000
@@ -669,8 +670,8 @@
 #define DDRSS_PI_216_DATA 0x01D40100
 #define DDRSS_PI_217_DATA 0x010001D4
 #define DDRSS_PI_218_DATA 0x01D401D4
-#define DDRSS_PI_219_DATA 0x32103200
-#define DDRSS_PI_220_DATA 0x01013210
+#define DDRSS_PI_219_DATA 0x200B3200
+#define DDRSS_PI_220_DATA 0x0101200B
 #define DDRSS_PI_221_DATA 0x0A070601
 #define DDRSS_PI_222_DATA 0x1C11090D
 #define DDRSS_PI_223_DATA 0x1C110913
-- 
2.34.1

