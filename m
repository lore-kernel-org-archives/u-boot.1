Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC3D132AA
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 10:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6015E88CA0;
	Mon,  4 Nov 2024 11:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="jTY5KPiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5595288CBA; Mon,  4 Nov 2024 11:42:53 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3DA87F3B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 11:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtlNDz1F8nRbvNwfXQKs3On5h7Edi+bTHAMO9CsT46uemrThlgKEqlCqWxgRsmLvTBWd4F9/kNWHu2843ReMVXGxz8+6tuTyreTbn9AoPHNmE+R6OTICPZifcKR8pf7+CC1EzbgSls0TnPUodHmefgHk5dGmeGWRFiqezkE8mIZLjnQR83J4H3JtPgs2j+P5dzDGWKHf69euoFa9dhNAaVl9d6vnZzKAlgDPZ/rsEtsd1XgSKbPQTMPPy/4tY+nSPm6nBPlQjuXR1cQwMUEstkMdc97XMDrHOj5y2sJwHZuZSUGzFMC37FsBeu9pWSvqDAzPz0c1Xb7WRczJHBt+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCe8Q/wFcwGJKGwmBoF0BswMW/3jFLMWwHBLcGOSCmo=;
 b=i5XFhhrAZ4tJdt8QB0EclEbW3953j32Mi7q7uWotXIJbZ8Y4KK1e3VyXmsDo7XZ9TyYT0mPGOFy/iZ/7tomIKhVplz9TTWjWEEyhZ08lIumyiKhWcc70IfvS4kjaePYl3yELODfWfSEF+tcFRvp+um/zQSS4F0giLKEH8sbO4K6ATVVDyHitGSOABevCkniY9mjBTx09Z2vo7kNnFXuBjpvmnD0IYUiWeBHlFbJlBDFSsuh1B9HGIz/nxxD7/RWjdd2hCcvtsugI5rTBy3RrqJuZon8dEQI/6260VmM3mX+44gJQp9kINCPFwOIaM8W4BpIqNek7R2ty9f3CSMytyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCe8Q/wFcwGJKGwmBoF0BswMW/3jFLMWwHBLcGOSCmo=;
 b=jTY5KPiUp7gRnKGET1hFkiU5+/Ho3jRgLzoeCjK/PveHpj5vVt0mLSbGR/viXg7YVFz8hcPIGLCbqPZS224dfhVx8rM6IUavQA0l+CmoMEYdedYCsFCi7Ho5eL2vhW8lcbz1lq7bcaPe+00oq6rNNNy8Z6XrPyJiY9dd/fjD+Ic=
Received: from DUZPR01CA0279.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::28) by GV1P195MB2479.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:42:45 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9d) by DUZPR01CA0279.outlook.office365.com
 (2603:10a6:10:4b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 10:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 10:42:45 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 11:42:45 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 11:42:44 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>
Subject: [PATCH 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Date: Mon, 4 Nov 2024 11:41:48 +0100
Message-ID: <20241104104148.748331-3-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104104148.748331-1-c.stoidner@phytec.de>
References: <20241104104148.748331-1-c.stoidner@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|GV1P195MB2479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1e2898-9e79-4e46-4606-08dcfcbd6b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?os8cVcn4v7PikxBZ0+VFAwW2bqc7AXEYU9edZf95YU7yKSODDHZ+Slclw9eP?=
 =?us-ascii?Q?xV/Z/RzF8Xs6rPHsQS/Z76sOkBUh3Zf9C9OUPBMOFbcz3Cgv9zTl76MrdEiZ?=
 =?us-ascii?Q?Lvkq+oJFStboICPmCnx5X27aKeRont6ZnYapVtCVN/NZMCcL5EX6aroVOwKP?=
 =?us-ascii?Q?ZGxqZQ6rS3U9jE4DLpVZekApa1Lk0UausXxdRiCUGdS+RbEhYvpfr/bQpEhv?=
 =?us-ascii?Q?dcM9eM9FEQ3/6woAFW0y1+50FnlJJ6pz12SAlxFNqMkVmKOL0W4YNjNqRNex?=
 =?us-ascii?Q?VFd6Zv5A5vmty+HYRZI72btWjBeUFvM/ouRPs/7i5rB4jYovUmb49lCCYBmZ?=
 =?us-ascii?Q?uRH5Y6e8ehE5MV9G/ORgNFYQ7oQNHKzJuOyxrP9LTp4hrnQrZICPCZ4rDjkL?=
 =?us-ascii?Q?G04YKt0aPYB1kfFOMRWPcnxzhjuZ/cJGbsvoTyNf9AogJgcJZE1HP/Rds/W1?=
 =?us-ascii?Q?OZR7n/a2sAQ+B9/nP3F+3YL8ZudlLWlYmi5FHSt1ppjFCFQzNfliFCv1Cmfd?=
 =?us-ascii?Q?3elJsaeq0FtiYBaybM24lPhQsiLglNCkWzlMHxRYRu3cMFnLUoC+pk09PYjb?=
 =?us-ascii?Q?3joBTC7LVQAJJ+Xhu4y4oR723ar8l2KhusZkptatWX/n8zzE/5ms/ZoSBvYe?=
 =?us-ascii?Q?MeE+oJR+NbkzNVGhnHr3V37ZaSW0XnoSuNB1+SD+rTRP4K5b91fBM+ASlslX?=
 =?us-ascii?Q?T5+F9QrFA/Qy+GQLRtQIhosE4/ygzPbiNDIvMUNfsZxbz9ZsX7YhTpulE/Vo?=
 =?us-ascii?Q?IgIzgYcIylQRN8c4Rr7ooMPlzDC/WZdbsSJg4RpBC1N1GGW+UPBlf4X2WCgI?=
 =?us-ascii?Q?HbszpPQIG0SKRrtnXqj99vUmiFBvJ2QZCBMVnZNpjCJxSQyaWVbp0QWJmgJa?=
 =?us-ascii?Q?UsO0cTqTkTfAGuxJH79qWSYwB02MAlu42JemZrK9B4Eaq0Z9ynlDdMNw0ekr?=
 =?us-ascii?Q?RqKuOeREG1nhsMoSpgeuNHLSprWAVLYSK3k3Uxo54wK8o7w4weWb4PBQS0ID?=
 =?us-ascii?Q?BmWCPXCc7/xrekH6a1PVVwXP2DqwvAMSPoHgVkNsF0F2adIzKQyKmTIoaHpG?=
 =?us-ascii?Q?oQvKg2rUFiQ31ZSTZcsLbDRwfOnZp7xI00CAXlV0ha6wjkFGLlxGS3G2b+xy?=
 =?us-ascii?Q?99GhImv8aXH5FpL3YHUQRibNLZpzW0ks2M+lcgaMRSZunhfbkvJ8uOTByvXW?=
 =?us-ascii?Q?pE5zd+K6Vxvys6ysNT5dRclAFuHgxjSScQa49o3iUETU5ljt7k9nRVptzIay?=
 =?us-ascii?Q?vmzbSZCd/qBI89yDSWkQ1a/66G5ypRzbe96QYbbZ0B6NzUy1ha1uoBKsceTU?=
 =?us-ascii?Q?38nfeUoB504w8/T7EKoyUkDVjdri2uSaS1BBfY+iHPUb4Ft3hd717IQk83HO?=
 =?us-ascii?Q?Jq7nL7k=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:42:45.4757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1e2898-9e79-4e46-4606-08dcfcbd6b18
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2479
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
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>, Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi | 19 ++++
 arch/arm/mach-imx/imx9/Kconfig                |  2 +
 arch/arm/mach-imx/imx9/soc.c                  |  2 +-
 board/phytec/common/Kconfig                   |  8 ++
 board/phytec/common/Makefile                  |  1 +
 board/phytec/common/imx93_som_detection.c     | 88 +++++++++++++++++++
 board/phytec/common/imx93_som_detection.h     | 33 +++++++
 board/phytec/phycore_imx93/Kconfig            | 28 ++++++
 board/phytec/phycore_imx93/MAINTAINERS        |  5 +-
 board/phytec/phycore_imx93/phycore-imx93.c    | 52 +++++++++++
 board/phytec/phycore_imx93/spl.c              | 58 ++++++++++++
 11 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 6897c91f4d..25c778bb07 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -305,4 +305,23 @@
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
+
+	eepromid@58 {
+		bootph-pre-ram;
+		bootph-some-ram;
+		compatible = "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x58>;
+		size = <32>;
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
index 7c28fa39e1..237354f507 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -628,7 +628,7 @@ static int low_drive_freq_update(void *blob)
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
index 0000000000..b7b237768f
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.c
@@ -0,0 +1,88 @@
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
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION) */
diff --git a/board/phytec/common/imx93_som_detection.h b/board/phytec/common/imx93_som_detection.h
new file mode 100644
index 0000000000..bb170bafff
--- /dev/null
+++ b/board/phytec/common/imx93_som_detection.h
@@ -0,0 +1,33 @@
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
+	PHYTEC_IMX93_OPT_EMMC,
+	PHYTEC_IMX93_OPT_CPU,
+	PHYTEC_IMX93_OPT_FREQ,
+	PHYTEC_IMX93_OPT_NPU,
+	PHYTEC_IMX93_OPT_DISP,
+	PHYTEC_IMX93_OPT_ETH,
+	PHYTEC_IMX93_OPT_FEAT,
+	PHYTEC_IMX93_OPT_TEMP,
+	PHYTEC_IMX93_OPT_BOOT,
+	PHYTEC_IMX93_OPT_LED,
+	PHYTEC_IMX93_OPT_EEPROM,
+};
+
+u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
+		enum phytec_imx93_option_index idx);
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
index 085c8e195a..bb7938604d 100644
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
 
@@ -40,3 +51,44 @@ int board_late_init(void)
 
 	return 0;
 }
+
+static void emmc_fixup(void *blob, struct phytec_eeprom_data *data)
+{
+	u8 option = phytec_imx93_get_opt(data, PHYTEC_IMX93_OPT_FEAT);
+	int offset;
+
+	if (option == PHYTEC_EEPROM_INVAL)
+		goto err;
+
+	/* Check "IO Voltage 1v8" flag is set */
+	if (option & 0x01) {
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
index 17a8736c73..cf9c94eb45 100644
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
@@ -44,8 +54,56 @@ void spl_board_init(void)
 	puts("Normal Boot\n");
 }
 
+enum phytec_imx93_ddr_eeprom_code {
+	INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX93_LPDDR4X_512MB = 0,
+	PHYTEC_IMX93_LPDDR4X_1GB = 1,
+	PHYTEC_IMX93_LPDDR4X_2GB = 2,
+	PHYTEC_IMX93_LPDDR4_512MB = 3,
+	PHYTEC_IMX93_LPDDR4_1GB = 4,
+	PHYTEC_IMX93_LPDDR4_2GB = 5,
+};
+
 void spl_dram_init(void)
 {
+	int ret;
+	enum phytec_imx93_ddr_eeprom_code ddr_opt = INVALID;
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

