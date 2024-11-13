Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236CAD462D3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9707C895A8;
	Wed, 13 Nov 2024 17:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="MsNxHU97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CF9895A8; Wed, 13 Nov 2024 17:16:07 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978E3895B7
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwDsgYPNAQ2hAR8v4An3oe1EJwUkQ3YA/sAl1dPTcT2k9fT+gd0S4JH60OGTUcFxWNG/2NDiNvUT498Ilbm0aG5Kb6I1hTG4ocB219939Mkl5ZNgA3b3nyhhdtYJQnQ7GHDpyBPONU4VxtLE+tASpzOl1fyJCcFGCK9n1uGb1wUP8Lexpqkgb9k3rvHDQ5Twx/gLIxnnEBF5qbwjAtD5qA3ltHLHzPCckyOF6WXE0bfgIXVLB2vjRVEXw0mAlVpPgKdNq+0EcxBRi0NrZg865GntgjxDQvtuFj29AVIWlaqXo0KxAXPfcn0ISu4kZLjUQBh8UFcjUndfFaOkYxHECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQGiOY+gEX8hwmnnG9Kp4yFU3f29DDlh7+48cAzTlCM=;
 b=ZQ8sbk25RiDR6LOINYMQ5CukDMTeYb9s1geBpugNB3QtT+kzTT+BYcFSGQwkvED3iqG5E+GlV1W4ORu2lQzgKQt55XMBhs8uzJCU7R2bGdIffREwh84Ln+FB684edwTLRV1RFp0iT5YX2tY1RsQRsVy0YCFsxvmXQRebOFjJPQ4aWfHUTHkMTdqCT1t32/zZ9BMr1mpKrp9ktVEKC50guy6o1zsCRlQl3vxFy3qF/jLgJHoGxDI63nfB+ATxa7+jgwCYpFTN/WqTphjhOK2lIemSkp/UWp3fXbO/WQ7IfE7nHbc7+zhc+cGJKyDU+CjKz5cSxbNyRW0RjF8SiURMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQGiOY+gEX8hwmnnG9Kp4yFU3f29DDlh7+48cAzTlCM=;
 b=MsNxHU970q/xEv0mOwVP0NOuDHtKx5krnigUWn/NtDi4VStG7xzIpNOf0NY9yUHTp515PbTRzLoIkTM48DzUTTw6b5Jw/vo9S+9beqTVj4AqNiVb6qjCKNkLBLJyuVuLBY1TxWt3Mxnb7Z2TPQFqn2o26YtLtw4r9QDmUge6VNs=
Received: from DU7PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::16) by GV1P195MB2053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:89::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 16:16:00 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::42) by DU7PR01CA0001.outlook.office365.com
 (2603:10a6:10:50f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 16:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 16:16:00 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 17:00:56 +0100
Received: from llp-stoidner.phytec.de (172.25.50.218) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 17:00:56 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support for
 all SOM variants
Date: Wed, 13 Nov 2024 17:00:37 +0100
Message-ID: <20241113160037.65679-4-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113160037.65679-1-c.stoidner@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.50.218]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|GV1P195MB2053:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ddd7f6-42d4-42f5-9012-08dd03fe7686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ir5x7kbn2AVzpX1igk/IRjNh5ocf4kPj5okFPuHvh/GeVwcDREApodNWEVOu?=
 =?us-ascii?Q?kQitfd4e7Y8HBq3QQjf5dc0RtErT8edJjD6GSca2vmwsC35NE9wC8mgLfzC4?=
 =?us-ascii?Q?i+aMNSRGoHKaw6SEHph3yGczmoukguEcewxDFPUxbSROX6QZngJ5iNUaiCPb?=
 =?us-ascii?Q?Z1ucX5+zpFS3LaVgEHea4g4j6gy0zPIBQLWMsN5cQgexaDEDLYdSrO1GH6Fb?=
 =?us-ascii?Q?JvgYSYQaT5qEy8Pg0yb2HrRbvK40Nkzm9/1kO7IPk50GeL74/YcAXJnzUurr?=
 =?us-ascii?Q?Z4AGkH+kmXt+SHcHoA7Pv/KX+g8uqrwxJk72jgB+HWhfAfxPFAlWt4fTL9W2?=
 =?us-ascii?Q?CDdbf1HUd9WyLKrlFcQpNYpHTHP6RIjb9dMa03l9Kbi1Jus85Hq0zy2Tywy2?=
 =?us-ascii?Q?vQXPlog0I1vA6rIj9/2JOwg90X2eNzdXtL1kAucKZqCV8Wn2+vhMJUQI3EOr?=
 =?us-ascii?Q?xjfqtJR7hKEOBHBmrLxMIannBfSM7+VVCATW/wfM8D6gmJQH8ZzMwQVZX/Sx?=
 =?us-ascii?Q?jS22S2taNcPWmE2Jyb46eVmAbKIQGcFNOH07QTZ9jiTgN3cE0H8uSE6maay+?=
 =?us-ascii?Q?frAsYPiuYvJxcbpdBh9yrNzJX/NCPDcUcMXyP3nIGnmMfL7+RDuhEfM0yhcu?=
 =?us-ascii?Q?m0ke8pVP8U4RFCsyndeuTQJJYVUmwcErQX92rQ8biLMsX2hCD0qMKpwORAES?=
 =?us-ascii?Q?yN8GDJfZiZ5NBc03XVXASdGHLv1Bck3Flg22vMB34pzCD+YvRs1z9nkTZbFz?=
 =?us-ascii?Q?JYvkCOkQ8Ke0lczoYQ1qQl7aKCUEVkusDDftDSgpGMz4TGnCgQBsdt0UZLKB?=
 =?us-ascii?Q?Dcc7REPA4EEMUtxE5WVRGO2uxgQ5BDmIWGOmDTW6f7VUtxEfmNGo8zpiPouD?=
 =?us-ascii?Q?yFbDNPrWGDdRf3KeVi5FH+8He0oEHyt5UQ7RYVoJiyqaPEhfZClFUMSGGch6?=
 =?us-ascii?Q?yW8bzCdIlNF6gNW+14WYZrI7FuxbM/eie+z4r6R98l2Imvjoswk8FDOYzROQ?=
 =?us-ascii?Q?TvfILdY4LuAPwR41Nf7nENMUHqVNHlM03j6ljBopU39mPaJD4tFAqHVqNWD7?=
 =?us-ascii?Q?w8ML4QglkvBztLPOXWX3mNoTEZfpS/VS49qOYBMlpDA1ciVCzpLAY+AfBriY?=
 =?us-ascii?Q?9BBYg2IVganTk+2IbEynngvNjq8oDvtckhCI6LWNivf+bEXiJT19vD55mQ5H?=
 =?us-ascii?Q?NJkfWEYGBj2If/lAxSL3q4pPBW8DcH+6efZHNtkC0J3IZirwSEsR8hQhR8qq?=
 =?us-ascii?Q?c3/oeTqcHemfPYPvL9cJGIzYiQ1oQ26SWHzfR2cetdSNq6mOEmSEFM+8eTpc?=
 =?us-ascii?Q?WM7IfOArwRxEigLWCvaCG7Bv1c/vjnf4VfltPk1/OEpiQH7Uo8oHC6nKymlP?=
 =?us-ascii?Q?i6ooQEY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:16:00.0803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ddd7f6-42d4-42f5-9012-08dd03fe7686
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2053
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

The phyCORE-i.MX 93 is available in various variants (e.g. different ram
sizes, eMMC HS400 yes/no). Enable hardware introspection for the
imx93-phyboard-segin_defconfig, so that during startup the SOM module
variant can be detected, and the hardware can be configured accordingly.
The resulting SPL and u-boot binary shall able to boot each
phyCORE-i.MX 93 module variant on each carrier board. Finally rename
imx93-phyboard-segin_defconfig to imx93-phycore_defconfig, to highlight
its SOM scope.

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
---
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: Primoz Fiser <primoz.fiser@norik.com>
Cc: Andrej Picej <andrej.picej@norik.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
---
Changes in v2:
- just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
  instead of creating an entirely new second defconfig
- remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
- improve commit message

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi               | 6 ++++--
 board/phytec/phycore_imx93/MAINTAINERS                      | 2 +-
 ...x93-phyboard-segin_defconfig => imx93-phycore_defconfig} | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 25c778bb07..2245461032 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -2,15 +2,17 @@
 /*
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Christoph Stoidner <c.stoidner@phytec.de>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  *
  * Product homepage:
- * phyBOARD-Segin carrier board is reused for the i.MX93 design.
- * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
+   https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
  */
 
 #include "imx93-u-boot.dtsi"
 
 / {
+	model = "PHYTEC phyCORE-i.MX93";
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog3>;
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index cea817ffdc..718f89a084 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -9,5 +9,5 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 F:      board/phytec/phycore_imx93/
 F:      board/phytec/common/imx93_som_detection.c
 F:      board/phytec/common/imx93_som_detection.h
-F:      configs/imx93-phyboard-segin_defconfig
+F:      configs/imx93-phycore_defconfig
 F:      include/configs/phycore_imx93.h
diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phycore_defconfig
similarity index 98%
rename from configs/imx93-phyboard-segin_defconfig
rename to configs/imx93-phycore_defconfig
index 18a4087e4b..cf9800118a 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -6,13 +6,13 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
-CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_PHYCORE_IMX93=y
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x2051a000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
@@ -31,6 +32,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
-- 
2.34.1

