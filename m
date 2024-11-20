Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C317AD711C2
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5589789555;
	Wed, 20 Nov 2024 17:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="a2gYqKQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FD889328; Wed, 20 Nov 2024 17:32:10 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E018916D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqoFnfZzh4dTnDK1AFe8KH3rFwvN+JnkKVf+IUQp12ejB6vKPERFjJxcGk74oCrheDTYO4PYxHCDnZSln3nE4t0Jil/xuJqb8a9DymNVFFhhAHpdRRYtQ4e3a+Wg5HCKAueNzloahjZDrIc6cJnIHyqpu++uXdrgvADf4u9FrqawBcITwyDXD4gTJZId+r3ccVvGSpPQVXH2jomWjYvPwUUaMqh9aWPytRp1Qv0sGBfAjUy1wiPqjBBxNl2gntVdsLqu2UMIGBo7qxYwZc8DVO5tp9DeQJyztG0H1P2NzXlDc3O1WfNJ5yG87uAv/HIdVUtUsS1MPrE7G23RT7RNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8jO/Cxu3nLpqNjoXGoPIlqtCUWHNjd/9GPhWLJ+p3o=;
 b=Tm/VLGcolMtNE0yb1jKs4WrGKhaFOuwtoKuDtrO394qhIztMweeH57D1uWyVCcrYqLDffCw82TetKdfK+qsWcdjs8JPTfOH6UoJxmBLKPPt77DXAAaZIRQ9PZB1hMkVSwPoIQSsXkOV1neORJK4hC7qH+tJjOpoXqKzGCL9tXePWYLYiAKlCztBAGN92O8Ha3MtGBAsYxMuy+P3dcZvS2dKUJ+/l1eT7cWsd3JRY5TZ1M9a8LAqS9y7Oj3I9gGGxnIICQCSQH7Yrqqm70dYlbcngVG7Ms370YszX0tiuQb8eUC9ZuuvNYJ8GrSZG99MZ+KEL5ARkqhsQiR+dsCnGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8jO/Cxu3nLpqNjoXGoPIlqtCUWHNjd/9GPhWLJ+p3o=;
 b=a2gYqKQKD3oDnuFNga+kjqdeAMp8Pa1d34lt65P9hs18WAeW9Noz5AvC8xcqWSmQTjfwgOEG3Ar8bVCvfPXIhnMDWkRP9Z3thL2vQXxmbg2pkx+pTvwVh6CUALs4GUsgLDeYDOvTSE7sNsaSzWmoVTorRHmGxrSL+3qNf9laDjA=
Received: from AS9PR06CA0348.eurprd06.prod.outlook.com (2603:10a6:20b:466::8)
 by AS2P195MB2251.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:59c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 16:32:04 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::c6) by AS9PR06CA0348.outlook.office365.com
 (2603:10a6:20b:466::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:32:04 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:32:03 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:32:03 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej
 <andrej.picej@norik.com>
Subject: [PATCH v4 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support for
 all SOM variants
Date: Wed, 20 Nov 2024 17:31:43 +0100
Message-ID: <20241120163143.127862-4-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120163143.127862-1-c.stoidner@phytec.de>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|AS2P195MB2251:EE_
X-MS-Office365-Filtering-Correlation-Id: ca22881b-c160-401c-aaf5-08dd0980de3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N6MJNqvLowKYpy4GJJ0cnwNYELdNmvmTQ+q50N6dcSbvQm1pp+naDvdH7yMI?=
 =?us-ascii?Q?WMMR8/6cbvV/soE4MRESvRTZfuXG3PUdS5ly7qS17kf3+lTR4M6nX2fUL9tS?=
 =?us-ascii?Q?av4yPbAe+5h7LU1UKkk/YSujHmWf/ILAvYCZNWzRTU2L8x6McsOHOjWTlEXB?=
 =?us-ascii?Q?wZRVl0IsrS+69ISo4U/npGVaj8Xv03H/W9uKxY/HmO0Q96b4AZ0eKeCFk4PU?=
 =?us-ascii?Q?jOYIeK0H7P3rdYR1CXu5FPUtoPXvMkncDN3Z/C9W79SBcKUT8f9SeKbgcvIT?=
 =?us-ascii?Q?F5PZ+Hk08Bg424SrYgJ2NKEmkIAElk5FeQ5ChznNz08zp5FiMs1kbRWCAttP?=
 =?us-ascii?Q?zOkzhJJGRtH6M4e6H8BqcHj1oK5DeP8TTFXaU6zfPQr/zUy4jUWfynrmjyEK?=
 =?us-ascii?Q?gVvpbk6u8//IFQjl3rtRK0Mgdp9Ls1sbmcu/r3Vc7Stumxvo5adszbC1xtZB?=
 =?us-ascii?Q?KzzANKfpT61pJq4S0K2hE/T8ImiHQoK4fwsxr7EK0YU84YLEGY0JgbnHxSWA?=
 =?us-ascii?Q?jWQTlSQw7XJCwpZBhwsGT4kYiiYCPFVFhcp+IattKcB5T5cNv86X4DlD0cga?=
 =?us-ascii?Q?FFCvQxx7+8ojTUJzpcin8ZvjCN/j8B5xT6bdtx7CZH73mFrrQL27FuDvSzVv?=
 =?us-ascii?Q?8u+P8zXox+hI3CKDrDElyaTGpxBQ7yfo6DU+m67XddeseK+y6E6Fr7GR4hZP?=
 =?us-ascii?Q?ZPJ8BjoWfsb29MVKNnULyDer8MLj4cMpiGS+R/FxKFpsIrmOh/A7XZEiBbCL?=
 =?us-ascii?Q?j58RZegiOGLxwcmRcNFEWNJnfD/f4i3ypiH+G4PCPnL2/fq9oHD5i6mA/P2V?=
 =?us-ascii?Q?Uaz3Hhij9xH83pZ32YWQ3yd+/qg8uW2nRFFigZSIV9i55FT/E/bDotTXoQ8R?=
 =?us-ascii?Q?xjzAzEWUISatdDTk3hDBKEyggd+6HJBgkjaX7Me5947QRvs+s2sXaMh+99C5?=
 =?us-ascii?Q?tYcdPcKDDcTwP+/BRxtV3NLT2NY2V/MSA0JbYM12/VdJ8k9tf8h/HeDFVSeF?=
 =?us-ascii?Q?aYI/AIVZSVrbcWkv6MEqinkZqFcpUBqQJDhIVqZa9Wqx4RYfEI/ZPVxn89AK?=
 =?us-ascii?Q?DDylbAvB2Xxl7FPpeoz16UropZKTgPI4ThiKyRTR3J5AfnsDRBGkSDujXaZ1?=
 =?us-ascii?Q?ceh+OHF88opFo2eT6i/H8MSwKfwmuCeI/QpsmvkmgnRqc57Anl7goaSC9q+L?=
 =?us-ascii?Q?dBN8gTlGmPYWWQ07IWYvtHraVgow5+3ogpsenyedvkMWsLa2wBig9YRASWRD?=
 =?us-ascii?Q?FcfFrcvNbr8G6uBAtmBZaDe9FoOrv63gzeC2Ikwfn2q3jPmKFX2Iz+1b+f2k?=
 =?us-ascii?Q?DE12jKyYXWNraEAsTieEsk9b3TQNjZP1y6ahGLm8NE2brNyGLSUlmFbW81gO?=
 =?us-ascii?Q?bT+Gcbc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:32:04.5213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca22881b-c160-401c-aaf5-08dd0980de3d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2251
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
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Yannic Moog <y.moog@phytec.de>
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
no Changes in v4

Changes in v3:
- add comment about SoM-scope to imx93-phyboard-segin-u-boot.dtsi
- rebase to the latest master
- adapt doc according to new defconfig

Changes in v2:
- just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
  instead of creating an entirely new second defconfig
- remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
- improve commit message

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi         | 11 +++++++++--
 board/phytec/phycore_imx93/MAINTAINERS                |  2 +-
 ...yboard-segin_defconfig => imx93-phycore_defconfig} |  2 ++
 .../{imx93-phyboard-segin.rst => imx93-phycore.rst}   |  8 ++++----
 doc/board/phytec/index.rst                            |  2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
 rename doc/board/phytec/{imx93-phyboard-segin.rst => imx93-phycore.rst} (91%)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 702d86f4e0..0c3ca2961c 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -2,15 +2,22 @@
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
+	/*
+	 * The phyCORE-i.MX93 u-boot uses the imx93-phyboard-segin.dts as
+	 * reference, but does only make use of its SoM (phyCORE) contained
+	 * periphery.
+	 */
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
index 309262c430..cf9800118a 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,6 +32,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phycore.rst
similarity index 91%
rename from doc/board/phytec/imx93-phyboard-segin.rst
rename to doc/board/phytec/imx93-phycore.rst
index ce17fbec78..bd110a3ebe 100644
--- a/doc/board/phytec/imx93-phyboard-segin.rst
+++ b/doc/board/phytec/imx93-phycore.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-phyBOARD-Segin-i.MX93
-=====================
+phyCORE-i.MX 93
+===============
 
-U-Boot for the phyBOARD-Segin-i.MX93.
+U-Boot for the phyCORE-i.MX 93.
 
 Quick Start
 -----------
@@ -51,7 +51,7 @@ Build U-Boot
 
 .. code-block:: bash
 
-   $ make imx93-phyboard-segin_defconfig
+   $ make imx93-phycore_defconfig
    $ make
 
 Burn the flash.bin to MicroSD card offset 32KB:
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 99848a9e95..fa30697464 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -7,7 +7,7 @@ PHYTEC
    :maxdepth: 2
 
    imx8mm-phygate-tauri-l
-   imx93-phyboard-segin
+   imx93-phycore
    phycore-am62x
    phycore-am64x
    phycore-imx8mm
-- 
2.34.1

