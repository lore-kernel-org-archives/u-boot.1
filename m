Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CDAE8305A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF0883FD6;
	Tue,  3 Feb 2026 07:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FNhbC9WC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD9B83FDC; Tue,  3 Feb 2026 07:36:15 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0B783FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5F1l7qQfyFV/JBXCii3jr4s0gjbNK6u/Xc9NO6sy4w+GhPBfTB+yDlwVL1UbbrybLdwl3TJRuQblNMYGBmN+CIn8iEG7O26PatdNLJ1CODKcV0s95ZzutYqmXr+JwSRqNxRxqjZgEHP3donNhA0hKJIJ7rJc17QwpATKf/MLMtOabSzZedt2gu8J5S6U57DpYYOrJvrzVTj+tUxIusQ/6wubCHYE7I9tUCLeCTwuViV1iVf37HGCKusFKqsy1Cppz3nf+/4w9KkFipbuI/HAF/1AwhVvoaaescf+xK9K85MNjFI7/VqheGQUdrzZA4+1oWsdkqYNl6w9VGPKmqMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVEOOEMDkL+blquSVdoxyF2pIsKxvQelKgSuzGCnZbU=;
 b=FgJvPV8nHgvuskLvNp8qWHTfP3B4Hq+mffxrzOsplB/c/1otCxQmlIAb6VTvRLqiNfIud6TIlDiOEWjRbkqI6ddwobM/SxfIqZgJsbbF4eNn3LvEHMGkmdyr4IGNxiFuIasSaUPBngvcPrSaHXbsVG/xBEYUsJVwF/kJR1SExUkgKYBit7lz1uILAUtB8CI7Xbc0Q6isAk0kGUWedvRIdgfnPGClvrNjdZIeMIGkpX/MQYSX/K5rGGyr7B2R7034RIW5C93bWlKGnZM2lDKn+TleSZvPz/7qTE9V4GhqukmRf1HL53v2WCMUPsoseWdo9kpwDXxbFbGb2naT3DFtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVEOOEMDkL+blquSVdoxyF2pIsKxvQelKgSuzGCnZbU=;
 b=FNhbC9WCMcz0VEQtiKcJLJ3KY6hWSDokZy8q8iWvKXp98gwcDb5cIuGr4K8RzmiZQMzobu2Y4WIB2qTld/idiNk5zz+rD4DL2lwxuxzCSwmqYwxQnhaBE93YdOaRnQSOSknNh4bBga2pwEdDrIJBaPBn2oRZGVpahK4RcBf/EZA=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:36:05 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::16) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.12 via Frontend Transport; Tue,
 3 Feb 2026 06:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 06:36:04 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:36:03 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:36:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:36:03 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7Y3483536;
 Tue, 3 Feb 2026 00:36:01 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 5/5] arm: dts: k3-am62p: Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:29 +0530
Message-ID: <20260203063529.1551907-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5dad9-0cd0-4b8d-fe8d-08de62ee812e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r8zbId+SHPm87w46YnIIS6287QjYGeeX6QnAiStvpz1x2CnJx/9ze95ExQUJ?=
 =?us-ascii?Q?VGMx6Bt7Iwv6gPMwLdzwtSo1jH9OLruln/MbZwl0MBn6/jhKvDXd4shPqgEd?=
 =?us-ascii?Q?lRVQFF74SPWqBd+lto0Mq8dWD/1jl4Qll2K9kA5dd3QJ4k2NVc1Sk14oaFxj?=
 =?us-ascii?Q?0wokGehUoQFXgctkNLR6kyAEolH7Hq+cxl8XDV4o1XbbAJy0Qj7/BJGj11nB?=
 =?us-ascii?Q?t0XLQn4C8UqzpAZZ2cSym/68u4eKuwZpKJpgIhBuz8CbK2eRo3CZ/dOFaf6i?=
 =?us-ascii?Q?li/E3gsvG5YJAYcbB6AO1YfgCE84EmzdCcutAG0PiT2Z9lHwH/6hSf8YprMn?=
 =?us-ascii?Q?C0XzMYTXfp8oY1CGd9TNQw0BELsZtjgpI2Fu7qTaSzt4NQOXG5VpTD+SP1nb?=
 =?us-ascii?Q?BcPMOaAxV93kg8sWt8qPkqi8EkoA8kPUkba4LmYnezpXdvrS/vrRk5gDfPHN?=
 =?us-ascii?Q?/y4vd6wbpRYTD8swCOfylpzD/7nnHKzmtbG/6XIObT9NfbwXb3G2T5iC+zEF?=
 =?us-ascii?Q?IyeuxCnodkGFP+qygMoD8Ng2ajo3UMOdZ12B2Nmuj43f1sEiCKlt/f/J88Cp?=
 =?us-ascii?Q?cjtTcry8gc/lObRRGesCh3HSDKV60BVuNFW6tWt5p+QQU3uiCZGYYW0+G2aI?=
 =?us-ascii?Q?eYTKFRq55KXZ2kL2lsb8W12fvGzbzY080G+cmJHtVLGhT2lffx2IrZCT5pBS?=
 =?us-ascii?Q?HXy9NFN1Y9DmhC1bUS6PvC3JU5ssNfqcNO3PxkHu8HCCNFYk97Z9VpA0Vn1Y?=
 =?us-ascii?Q?JLCgT6ZDwvNcgXMsSGwvOlKV/YOxZPe8AANOasiGsTUzTTNR0WcS3spF6YXM?=
 =?us-ascii?Q?Vu8O9tcWi3B97lmOAmftIrYk7ov92RiYEupL7pKnHgHwP6nB//tIH6RFvszn?=
 =?us-ascii?Q?DTz/J8HBaVm4TFHCD0VIQXjc8X8KDOthkVAQfC4CXAnjzXu5X3hes1BexjAy?=
 =?us-ascii?Q?v52OZsT5aINmbhN1djSsCIc38aIgbcdmWHSV4rMz9hJLGlmISIRmQA5WpY1q?=
 =?us-ascii?Q?f3IvN5a4wXZaXN40X6MPi/yTmveHWDV8pTHEfWcfZKCKMYeFtLW7dwJ4AMP5?=
 =?us-ascii?Q?OotoJ/i2/sS8fF9/wP/vVRWzeEN2L3VEZO1Q2IhFQWATGelNVFZ0BZ6Da7Yi?=
 =?us-ascii?Q?q2h/GX0y7WWZNCfXHuSIMEdVV52sErVV2yVyYUqifzc4O16m6wRm4oJsGH7D?=
 =?us-ascii?Q?W42sQeWaWx76U25ioFr/ctXZM9lKTpiVYvbLfa9/aFOaCU2abI2wLhItct0x?=
 =?us-ascii?Q?cWIgd+wyea7vPmZH3mffXHqUd34UJkAJtgYatZpHRlLZJ5zTLr33SL3hcnHx?=
 =?us-ascii?Q?AzUkof17yReTCRpjMVu1GJm099G0AZHE1O0CRF12ePU5mb/CGwjDIOahmkKV?=
 =?us-ascii?Q?UowTsrAfi7+Wh0R1je+Ijy6TfBRbrvAW2DCa2F+uZd47B+KlULsNbX2xtrxL?=
 =?us-ascii?Q?wEws6A44VyLRoPtcjzg/gATiCvfXs331Q3Vu1begnzhWEq+n6+t1a8J9v7qg?=
 =?us-ascii?Q?UDsIvXHHRywKj/Ixx2bYyiFOhqBrhpCV2tkeQug7EYtVGl5yTNlCElvNkXsm?=
 =?us-ascii?Q?ItvXP9C6/B9dnvfl4KP+nWDdmuMFSiuAecWFD+b/WocfADAOnl+/ElMWj7oh?=
 =?us-ascii?Q?hiNoXjJYZIMlfgEjXZTswZxWsEHDJM4CvVQyro8VVe4Hh0PqSyHSfr7/HUqY?=
 =?us-ascii?Q?t4iz3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vD4W44g21MUP/WoTGVUjYVfyTMEy9IU2SWwUNGJW+A5TTygDNBnrOXPrvMbaAssBfpTQVRJCAF2J6Hy1+2NOGL+YfXOD/nxcRk7T7P7Wh0UUijFvUFUi+W/CggCMKZ6od/R4dODsBiRc+0ywBn71CW6zRh57do7Zd5FeTOVczGVtWuewNOFAc2Wm2Q1AlpBdXw7h6Lo37lLDmwo9UgSQBvj+pgt6aWrjSC12yFtx4ID230s6GEPXeVdZBDNoQTGeXv5ilapP4n+CbBba/ljLebr//kF7NFx+JVJqXi9lHHa6RacE6sKIyFATnta5qjxZoBFCjUsWDapi139Z0iYi/YnO7TmDhoOhjhQTimyBa7XGzk08996b04k61llpp5xHg064cx7g3cuimF8alYEeAnlfomfB6zH7o9MQ4V1GFRiomly5W4n/EwAqGIgkyeLy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:36:04.0998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5dad9-0cd0-4b8d-fe8d-08de62ee812e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
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

Update the DDR Configurations for AM62Px SK according to the SysConfig
DDR Configuration tool v0.10.32. [1]

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi | 25 +++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
index c7e33ba50b99..763498df937b 100644
--- a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
+++ b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62Px SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
- * Tue Sep 17 2024 11:03:07 GMT+0530 (India Standard Time)
+ * AM62Px SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
+ * Fri Jan 30 2026 13:50:37 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 1600MHz
  * Density (per channel): 16Gb
  * Number of Ranks: 2
- */
+*/
 
 #define DDRSS_PLL_FHS_CNT 5
 #define DDRSS_PLL_FREQUENCY_1 800000000
 #define DDRSS_PLL_FREQUENCY_2 800000000
 #define DDRSS_SDRAM_IDX 17
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
 #define DDRSS_PI_216_DATA 0x01910100
 #define DDRSS_PI_217_DATA 0x01000191
 #define DDRSS_PI_218_DATA 0x01910191
-#define DDRSS_PI_219_DATA 0x32103200
-#define DDRSS_PI_220_DATA 0x01013210
+#define DDRSS_PI_219_DATA 0x301B3200
+#define DDRSS_PI_220_DATA 0x0101301B
 #define DDRSS_PI_221_DATA 0x0A070601
 #define DDRSS_PI_222_DATA 0x180F090D
 #define DDRSS_PI_223_DATA 0x180F0911
-- 
2.34.1

