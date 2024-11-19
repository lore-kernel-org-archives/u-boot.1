Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB1D591A5
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A810A895CA;
	Tue, 19 Nov 2024 17:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="GOkQCzXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD6D895C5; Tue, 19 Nov 2024 17:29:38 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E6D895AD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSiji3PFIkZdFLLDNgjb8u+MQ4/bg6zj7WZEqCH/Dir+ZC+f+oFDwt5l1EMFWtQv/osP6Z6oXEzHjzKcqC1ZZHnTX1FgGB3qTQq3t75X00NJr5nv0zoGmJNyBHF/88/u94NtsE4TcKUcvdDCjjtI0r666OC4B6XADm5CS3UuWLMV/v8Afn0F4n4Jksl5tKXp7G9oW1e7nrmXGmM8S2HDYABu6C9HD/xIZVxOv7BDBlp36f56Hl6bim5eYP7bXZAO0bx/5ivj/7TBstUZxp6O4U8Ve+OvHRIh5R6OEVBb3tT4bdhvNxvy+CBAtc8N8VLjeWxyWzX8H0K77Qe1iEWSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tWdV1FWKcedHduyXe0Og/A3kxXwHbKZblrUL8mUBMI=;
 b=nPcpPVv6kaPC8WXsSYvM7IW17A7BnCQ0MWJ6AoYX0awyoUrTFqmXwWImPrcqvqge/E5vc/7YqIpxEIMOJWmOuCWX5WR/EWrKf/T32iBJAUCxNyLrbiVUDdTf263sMWDBZbzoecs8guF+dzk6xcBlnbsfi7eKxcun2y2JyXknWbZh39YDpoqupS2ql41/dVtNvewa/3t0gmLKRN7b3aJ3nbfaMFGETC1LJt4hLw+PLeOkET1uACJZOhzckw0alopI1IldLFmmT/AGggL8Cjdrj9m7aJBt62OPq2XJcOcc1RibbJT/8zLlqQQNRxM9Fz7/O0I4rZs1gyGVHA91zLSaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tWdV1FWKcedHduyXe0Og/A3kxXwHbKZblrUL8mUBMI=;
 b=GOkQCzXyNZVmhMRy5uoo8Bm2EmhMYpOyubMGuistwlJfUM5eihTy2128W8vfAGyM9KJMn+Mdj9IJfYJXbNL+xJ2nrKJlVX/GhTcFOmkqa8q4TpwQl/RcJ4sRSlOL2HYIjW1UKCw7o2VcS8hF4+x2XmYpJPOBpeMXCU0FygULOuk=
Received: from AS9PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::32) by PAWP195MB2470.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:362::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:29:29 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::13) by AS9PR0301CA0011.outlook.office365.com
 (2603:10a6:20b:468::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 16:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 16:29:29 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:24 +0100
Received: from llp-stoidner.phytec.de (172.25.50.218) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:24 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej
 <andrej.picej@norik.com>
Subject: [PATCH v3 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Date: Tue, 19 Nov 2024 17:29:06 +0100
Message-ID: <20241119162907.17934-3-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119162907.17934-1-c.stoidner@phytec.de>
References: <20241119162907.17934-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.50.218]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|PAWP195MB2470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8078db5a-2d44-4198-bc0e-08dd08b75766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3yXfkkoupQOGT4j+OLhCThlPzE1m2XbgFCR+Rkz96Yfp6G864ru4RIV5oIk?=
 =?us-ascii?Q?pziwa1FLik6UIO7CsRy21siVPirz0Sleq97D6ZpSpaJui084T0HvxIYRlMi8?=
 =?us-ascii?Q?NBcpwifG+kbnGGnBctVy2l/D9P28gSSJOcMCSEZCVDgg7mF3bGC7rv7BkNPv?=
 =?us-ascii?Q?BU71rWStFY6ne/S2SOHu48NRJh/5vaHoTlicsEz3eqwvrRFCAa/3vVu/tF+5?=
 =?us-ascii?Q?xf+OOOzETFvxwryA8UWOHk+753WP1OnNZrphddQaIvac4tMwZZf7b2yqUO22?=
 =?us-ascii?Q?O3LyTFdnMAKPEsX0rxgZIUrfT4PoDUejmnn78usTjYh/jL2pkDBiBncAobWc?=
 =?us-ascii?Q?B20zVj7fMP+sA4Fi6friNLMs79jBrbF3CuyRX0yZTHaDZ5SF9qvos9k0B9Fv?=
 =?us-ascii?Q?EJTL6DNftWvsNkZR4CMzA1/ZL49Kdp1IH+fNd3xApg+dhZFxiqzCE6LZMrxO?=
 =?us-ascii?Q?K0qcNhUOdt/REZlm1iRwiY12RI+bKEsNey/ENH1XwJMdCzTb6l59Ivmfez6R?=
 =?us-ascii?Q?buTrZuhQvROgleGMsKHLqY6gw6z2UkWZtemTlpTmxjRhD03nX4fl8KgiAibX?=
 =?us-ascii?Q?yxFb34TCZqJOrtvTMG+PAhci77JbHqrbye47rcGkiJM8pfaBPUDAnp7ZwPzv?=
 =?us-ascii?Q?67BjWNmJt81B0bD+f1hBn6oyNhCxOJrj1wCdcRsdH2Oc6lKgbs/T5VVkzP6t?=
 =?us-ascii?Q?K2YZkuYZv/iaAl6A6gtc1N97fXSlcZugWCxwZphM9/oy5TzT2wh6DMZ+jnDy?=
 =?us-ascii?Q?fJWQGe7nERcDR9QyKR/7in0VHZU8Z3DT6sM/ljJY8m8zfhKO6WYLOTk+m2rP?=
 =?us-ascii?Q?nKaH2ugGKgmo3UC9MD1grCGzXl5NoSYtjFVXIsQibCnechu1x9j0WIaApend?=
 =?us-ascii?Q?F7pppL2nT4yJdsHUQvjS5TEZhqDt2oK/btuvTlh1UuHxMAU4nCIfw0TOsnVL?=
 =?us-ascii?Q?Ff6aE/at4ymzFSf9vtKzlhnmtcEfMa1c5TzJr0S3TErpBbQrxdeisBdyoBNr?=
 =?us-ascii?Q?QlDq+cktNc33jVHSZjtwrYvBxwNfs/FDLLKylp8aq1ww33a9HzXpYDi9g9pv?=
 =?us-ascii?Q?DJkHTs/8WZm9ar1uZ0gu2DlUzo/Bj9Enh5S0bgbrPEsvO8ekwHTrYGU9BLmE?=
 =?us-ascii?Q?MIZZ3Kfo0gjQSTHcrPvAS9PRIG2cnaZF2ysr9vQWkaJE4pI7lewMljLx2iTF?=
 =?us-ascii?Q?teu/hRuYjVwjo6qE47JNB+h+smoM7U8nKzIOe+o1NwxbXOi3mi/z9RH4X3iq?=
 =?us-ascii?Q?fuTpQtieyu4/tQdMjNc03CYorWrS4fHWXa2nz9QDUWaAaBAijrMwt/hZ2P2i?=
 =?us-ascii?Q?9Sfrl8rh0Z6ym9ytGK+U/FqHRBf7DDsG22W5DdrIDb27I/opWKUnwN8Ttogi?=
 =?us-ascii?Q?OmI/dy0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:29:29.4397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078db5a-2d44-4198-bc0e-08dd08b75766
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2470
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

The phyCORE-i.MX 93 is available in various variants. Relevant variant
options for the spl/u-boot are:
- with or without HS400 support for the eMMC
- with 1GB ram chip, or 2GB ram chip

The phyCORE's eeprom contains all information about the existing variant
options. Add evaluation of the eeprom data to the spl/u-boot to
enable/disable HS400 and to select the appropriate ram configuration at
startup.

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
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
Changes in v3:
- remove unwanted dts node eepromid
- correct typo in doc (PHYTEC_IMX93_VOLTAGE_3V3)
- improve enum code-style (phytec_imx93_option_index)

Changes in v2:
- encapsulate handling of feature flag VOLTAGE into own function
- move definition of enum phytec_imx93_ddr_eeprom_code into header file

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |   9 ++
 arch/arm/mach-imx/imx9/Kconfig                |   2 +
 arch/arm/mach-imx/imx9/soc.c                  |   2 +-
 board/phytec/common/Kconfig                   |   8 ++
 board/phytec/common/Makefile                  |   1 +
 board/phytec/common/imx93_som_detection.c     | 111 ++++++++++++++++++
 board/phytec/common/imx93_som_detection.h     |  51 ++++++++
 board/phytec/phycore_imx93/Kconfig            |  28 +++++
 board/phytec/phycore_imx93/MAINTAINERS        |   5 +-
 board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++++++++
 board/phytec/phycore_imx93/spl.c              |  48 ++++++++
 11 files changed, 314 insertions(+), 2 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 6897c91f4d..e001ee3288 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -305,4 +305,13 @@
 			};
 		};
 	};
+
+	eeprom@50 {
+		bootph-pre-ram;
+		bootph-some-ram;
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&buck4>;
+	};
 };
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 5c1054138f..2465e31d73 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -45,6 +45,8 @@ config TARGET_PHYCORE_IMX93
 	bool "phycore_imx93"
 	select IMX93
 	select IMX9_LPDDR4X
+	select OF_BOARD_FIXUP
+	select OF_BOARD_SETUP
 
 endchoice
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 21e0e7dd1e..6837ac82b0 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -634,7 +634,7 @@ static int low_drive_freq_update(void *blob)
 	return 0;
 }
 
-#ifdef CONFIG_OF_BOARD_FIXUP
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_TARGET_PHYCORE_IMX93)
 #ifndef CONFIG_XPL_BUILD
 int board_fix_fdt(void *fdt)
 {
diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index f394ace786..bc5511707a 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -19,6 +19,14 @@ config PHYTEC_IMX8M_SOM_DETECTION
 	  Support of I2C EEPROM based SoM detection. Supported
 	  for PHYTEC i.MX8MM/i.MX8MP boards
 
+config PHYTEC_IMX93_SOM_DETECTION
+	bool "Support SoM detection for i.MX93 PHYTEC platforms"
+	depends on ARCH_IMX9 && PHYTEC_SOM_DETECTION
+	default y
+	help
+	  Support of I2C EEPROM based SoM detection. Supported
+	  for PHYTEC i.MX93 based boards
+
 config PHYTEC_AM62_SOM_DETECTION
 	bool "Support SoM detection for AM62x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index cd78f7686f..8126f7356e 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -10,3 +10,4 @@ endif
 obj-y += phytec_som_detection.o phytec_som_detection_blocks.o
 obj-$(CONFIG_ARCH_K3) += am6_som_detection.o k3/
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
+obj-$(CONFIG_ARCH_IMX9) += imx93_som_detection.o
diff --git a/board/phytec/common/imx93_som_detection.c b/board/phytec/common/imx93_som_detection.c
new file mode 100644
index 0000000000..eb9574d43b
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <i2c.h>
+#include <u-boot/crc.h>
+
+#include "imx93_som_detection.h"
+
+extern struct phytec_eeprom_data eeprom_data;
+
+#if IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION)
+
+/* Check if the SoM is actually one of the following products:
+ * - i.MX93
+ *
+ * Returns 0 in case it's a known SoM. Otherwise, returns 1.
+ */
+u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+{
+	u8 som;
+
+	if (!data)
+		data = &eeprom_data;
+
+	/* Early API revisions are not supported */
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return 1;
+
+	som = data->payload.data.data_api2.som_no;
+	debug("%s: som id: %u\n", __func__, som);
+
+	if (som == PHYTEC_IMX93_SOM && is_imx93())
+		return 0;
+
+	pr_err("%s: SoM ID does not match. Wrong EEPROM data?\n", __func__);
+	return 1;
+}
+
+/*
+ * Filter PHYTEC i.MX93 SoM options by option index
+ *
+ * Returns:
+ *  - option value
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid
+ *
+ */
+u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+				       enum phytec_imx93_option_index idx)
+{
+	char *opt;
+	u8 opt_id;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	opt = phytec_get_opt(data);
+	if (opt)
+		opt_id = PHYTEC_GET_OPTION(opt[idx]);
+	else
+		opt_id = PHYTEC_EEPROM_INVAL;
+
+	debug("%s: opt[%d] id: %u\n", __func__, idx, opt_id);
+	return opt_id;
+}
+
+/*
+ * Filter PHYTEC i.MX93 SoM voltage
+ *
+ * Returns:
+ *  - PHYTEC_IMX93_VOLTAGE_1V8 or PHYTEC_IMX93_VOLTAGE_3V3
+ *  - PHYTEC_EEPROM_INVAL when the data is invalid
+ *
+ */
+enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage(struct phytec_eeprom_data *data)
+{
+	u8 option = phytec_imx93_get_opt(data, PHYTEC_IMX93_OPT_FEAT);
+
+	if (option == PHYTEC_EEPROM_INVAL)
+		return PHYTEC_IMX93_VOLTAGE_INVALID;
+	return (option & 0x01) ? PHYTEC_IMX93_VOLTAGE_1V8 : PHYTEC_IMX93_VOLTAGE_3V3;
+}
+
+#else
+
+inline u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+{
+	return 1;
+}
+
+inline u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+					      enum phytec_imx93_option_index idx)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+inline enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
+	(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION) */
diff --git a/board/phytec/common/imx93_som_detection.h b/board/phytec/common/imx93_som_detection.h
new file mode 100644
index 0000000000..a0803b47cb
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#ifndef _PHYTEC_IMX93_SOM_DETECTION_H
+#define _PHYTEC_IMX93_SOM_DETECTION_H
+
+#include "phytec_som_detection.h"
+
+#define PHYTEC_IMX93_SOM	77
+
+enum phytec_imx93_option_index {
+	PHYTEC_IMX93_OPT_DDR = 0,
+	PHYTEC_IMX93_OPT_EMMC = 1,
+	PHYTEC_IMX93_OPT_CPU = 2,
+	PHYTEC_IMX93_OPT_FREQ = 3,
+	PHYTEC_IMX93_OPT_NPU = 4,
+	PHYTEC_IMX93_OPT_DISP = 5,
+	PHYTEC_IMX93_OPT_ETH = 6,
+	PHYTEC_IMX93_OPT_FEAT = 7,
+	PHYTEC_IMX93_OPT_TEMP = 8,
+	PHYTEC_IMX93_OPT_BOOT = 9,
+	PHYTEC_IMX93_OPT_LED = 10,
+	PHYTEC_IMX93_OPT_EEPROM = 11,
+};
+
+enum phytec_imx93_voltage {
+	PHYTEC_IMX93_VOLTAGE_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX93_VOLTAGE_3V3 = 0,
+	PHYTEC_IMX93_VOLTAGE_1V8 = 1,
+};
+
+enum phytec_imx93_ddr_eeprom_code {
+	PHYTEC_IMX93_DDR_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX93_LPDDR4X_512MB = 0,
+	PHYTEC_IMX93_LPDDR4X_1GB = 1,
+	PHYTEC_IMX93_LPDDR4X_2GB = 2,
+	PHYTEC_IMX93_LPDDR4_512MB = 3,
+	PHYTEC_IMX93_LPDDR4_1GB = 4,
+	PHYTEC_IMX93_LPDDR4_2GB = 5,
+};
+
+u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+				       enum phytec_imx93_option_index idx);
+enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
+	(struct phytec_eeprom_data *data);
+
+#endif /* _PHYTEC_IMX93_SOM_DETECTION_H */
diff --git a/board/phytec/phycore_imx93/Kconfig b/board/phytec/phycore_imx93/Kconfig
index a70104cb79..09f26e89e3 100644
--- a/board/phytec/phycore_imx93/Kconfig
+++ b/board/phytec/phycore_imx93/Kconfig
@@ -10,4 +10,32 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "phycore_imx93"
 
+config PHYCORE_IMX93_RAM_TYPE_FIX
+	bool "Set phyCORE-i.MX93 RAM type and size fix instead of detecting"
+	default false
+	help
+	  RAM type and size is being automatically detected with the help
+	  of the PHYTEC EEPROM introspection data.
+	  Set RAM type to a fix value instead.
+
+choice
+	prompt "phyCORE-i.MX93 RAM type"
+	depends on PHYCORE_IMX93_RAM_TYPE_FIX
+	default PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
+
+config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
+	bool "LPDDR4X 1GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 1GB
+	  for phyCORE-i.MX93.
+
+config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB
+	bool "LPDDR4X 2GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 2GB
+	  for phyCORE-i.MX93.
+
+endchoice
+
+source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index 9e91a29dc3..cea817ffdc 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -1,10 +1,13 @@
 phyCORE-i.MX93
-M:	Mathieu Othacehe <m.othacehe@gmail.com>
+M:      Mathieu Othacehe <m.othacehe@gmail.com>
+R:      Christoph Stoidner <c.stoidner@phytec.de>
 W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
 S:      Maintained
 F:      arch/arm/dts/imx93-phyboard-segin.dts
 F:      arch/arm/dts/imx93-phycore-som.dtsi
 F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 F:      board/phytec/phycore_imx93/
+F:      board/phytec/common/imx93_som_detection.c
+F:      board/phytec/common/imx93_som_detection.h
 F:      configs/imx93-phyboard-segin_defconfig
 F:      include/configs/phycore_imx93.h
diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index 085c8e195a..a55795e060 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Author: Christoph Stoidner <c.stoidner@phytec.de>
  * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  */
 
 #include <asm/arch-imx9/ccm_regs.h>
@@ -12,11 +13,21 @@
 #include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
+#include <fdt_support.h>
+
+#include "../common/imx93_som_detection.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define EEPROM_ADDR            0x50
+
 int board_init(void)
 {
+	int ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
+
+	if (ret)
+		printf("%s: EEPROM data init failed\n", __func__);
+
 	return 0;
 }
 
@@ -40,3 +51,43 @@ int board_late_init(void)
 
 	return 0;
 }
+
+static void emmc_fixup(void *blob, struct phytec_eeprom_data *data)
+{
+	enum phytec_imx93_voltage voltage = phytec_imx93_get_voltage(data);
+	int offset;
+
+	if (voltage == PHYTEC_IMX93_VOLTAGE_INVALID)
+		goto err;
+
+	if (voltage == PHYTEC_IMX93_VOLTAGE_1V8) {
+		offset = fdt_node_offset_by_compat_reg(blob, "fsl,imx93-usdhc",
+						       0x42850000);
+		if (offset)
+			fdt_delprop(blob, offset, "no-1-8-v");
+		else
+			goto err;
+	}
+
+	return;
+err:
+	printf("Could not detect eMMC VDD-IO. Fall back to default.\n");
+}
+
+int board_fix_fdt(void *blob)
+{
+	struct phytec_eeprom_data data;
+
+	phytec_eeprom_data_setup(&data, 2, EEPROM_ADDR);
+
+	emmc_fixup(blob, &data);
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	emmc_fixup(blob, NULL);
+
+	return 0;
+}
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 17a8736c73..a4d2aaac32 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 PHYTEC Messtechnik GmbH
  * Author: Christoph Stoidner <c.stoidner@phytec.de>
  * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  */
 
 #include <asm/arch/clock.h>
@@ -20,6 +21,8 @@
 #include <power/pca9450.h>
 #include <spl.h>
 
+#include "../common/imx93_som_detection.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 /*
@@ -27,6 +30,13 @@ DECLARE_GLOBAL_DATA_PTR;
  * when pca9451a support is added.
  */
 #define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
+#define EEPROM_ADDR            0x50
+
+/*
+ * Prototypes of automatically generated ram config file
+ */
+void set_dram_timings_2gb_lpddr4x(void);
+void set_dram_timings_1gb_lpddr4x_900mhz(void);
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
@@ -46,6 +56,44 @@ void spl_board_init(void)
 
 void spl_dram_init(void)
 {
+	int ret;
+	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
+
+	/* NOTE: In SPL lpi2c3 is mapped to bus 0 */
+	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
+	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
+		goto out;
+
+	ret = phytec_imx93_detect(NULL);
+	if (!ret)
+		phytec_print_som_info(NULL);
+
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB))
+			ddr_opt = PHYTEC_IMX93_LPDDR4X_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB))
+			ddr_opt = PHYTEC_IMX93_LPDDR4X_2GB;
+	} else {
+		ddr_opt = phytec_imx93_get_opt(NULL, PHYTEC_IMX93_OPT_DDR);
+	}
+
+	switch (ddr_opt) {
+	case PHYTEC_IMX93_LPDDR4X_1GB:
+		if (is_voltage_mode(VOLT_LOW_DRIVE))
+			set_dram_timings_1gb_lpddr4x_900mhz();
+		break;
+	case PHYTEC_IMX93_LPDDR4X_2GB:
+		set_dram_timings_2gb_lpddr4x();
+		break;
+	default:
+		goto out;
+	}
+	ddr_init(&dram_timing);
+	return;
+out:
+	puts("Could not detect correct RAM type and size. Fall back to default.\n");
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		set_dram_timings_1gb_lpddr4x_900mhz();
 	ddr_init(&dram_timing);
 }
 
-- 
2.34.1

