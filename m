Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CDFD132B1
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 11:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F09288CC7;
	Mon,  4 Nov 2024 12:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="dHQHa4+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A7388CC7; Mon,  4 Nov 2024 12:25:57 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DC388CA2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 12:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNc8gFnI+CwuQZ7mdJcZJtlHA2AXsnIOQy9gJGy6zT0PHFy4ls6wUTwQifRTtakAuxfGxB/OlGP4x0OZTPSQzOn1mIw+ORINMmN4qpDeLVtgO2MdyFareEixGuI4cfBrzr/nz0jSZ4X6SMUuu1mwDyG3Inc6sbINGqG2ehHnbEvqb/vphBIHKXHinUuJk56qLg84GGkaumDmHcNCI9F2UfUKPARSYvNTbEKt6gzRe0BZCEq7N/DL6DeUzfD2YAZaAAS8QMHC7DR8JqWodkrWlqIPcHWtCOTbQqUktIw3p4J4WQTNGWPHavf0Z1VUfmE7dnM7Fu1Wy3WMMiDQqNcMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If39m0A1rfSaxj61R9EoQkwofZy7knc3ONi0cvlnGGs=;
 b=nGw5WRaABDY486IfrAniuNe/AaRVpMh/uMAXG3JUfHWL6L1sbMdV4FCZR8qfKGIdYAM4TouqWCLIEyFClznLe8Rr7lH08p4hG4KJycxvnpfKFS2MLDh5PuOAtg5AD9rHsWWaS0ijLK9uy9L7MX3YbVcRavH8uFxDejFA4WS9NZup5tFKwLRAi4EZz3fXPEEJGhbSw2lIyfyk0h87+fcuFTmXsGIzvNePU30txvgtzcl9ASiCv9Q4PrDIcH1FNTmiKQAyi5C8mfgp4+gS9DQS+uVTH6h2Pw7spoZtPXJNnQ42wWrCcymxqfUkZlmfUB3PlYkXkBD4Me5L2GjYXcVbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If39m0A1rfSaxj61R9EoQkwofZy7knc3ONi0cvlnGGs=;
 b=dHQHa4+Y7nZNRFbXtYfmWtikhSANAFI4ZS1qZHyxqM/MGi3MFdqcKYC1vgItTIEHHdSJ94MXBlh01sAxCSBCTBCmi+aWpPWS6Lxp2Z22Oe9b6YMNV/+Hs0Imkrc9gNaPhprD28AZjkesWDDUBPD493hemGkeFhoSu2fDNKTeI8k=
Received: from AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::18)
 by PR3P195MB0553.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 11:25:51 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:150:cafe::c1) by AM0PR10CA0038.outlook.office365.com
 (2603:10a6:20b:150::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 11:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 11:25:50 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 12:25:49 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 12:25:49 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>
Subject: [PATCH 3/3] board: phytec: imx93: Add phyCORE-i.MX93 support all SOM
 variants
Date: Mon, 4 Nov 2024 12:25:37 +0100
Message-ID: <20241104112537.752027-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PR3P195MB0553:EE_
X-MS-Office365-Filtering-Correlation-Id: 512583e2-ac37-4c90-d05b-08dcfcc36fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQzwoqfRQBkmcK2edKDzbVp9X9tfpbTTttJ0qEfHn8D5k6DhDTBSH5X/Cb7O?=
 =?us-ascii?Q?Dl5VG/7TCUBE4pv/1anEU3OxzeunBR/E2ltfZ/9M4xfeHEsYws9CcPa2Uh+4?=
 =?us-ascii?Q?nyGTEAYLVUw/kUnxMp1D30lYqX77ZUASs/m54vOERIsPresKWfnY2h6tTZQt?=
 =?us-ascii?Q?IkDVltFgpA+HSAyJQ7Uq+/KBTLbUf15BR8WHA+0Eu+KfqSc1mY46kXZCJ8VT?=
 =?us-ascii?Q?tbRB1a+YAMT+A7NuyuSGvZg3ZKHmknNSJOVrjnbiinH/0L6qIXSNJ48eqj9z?=
 =?us-ascii?Q?Rzlh8LZ4NzWqTmRCL58dHvadeaUUqmDmPqnzfsybMaelg7voZ97j1sfzE2N0?=
 =?us-ascii?Q?DCjBoicR2wZegNggOVefHV1hM3n30IbLgL01CAWg7xkhY+VZK15pucY2ywih?=
 =?us-ascii?Q?5gKF4Ci4QqxRu8/rq6ltOWpPR+6v97WZsB88jEE/70IPiccJCDma24SbFOIV?=
 =?us-ascii?Q?f8uddaCshHGsXQirtU7DAr6fY+lNknPZreRgfC2khtx9eOSrRb8bWd76koaw?=
 =?us-ascii?Q?c69111mS45LD5RySA+AvmENPnOij7zO+DvvtUCyC9s+S3/V6dHH9GanfWYBT?=
 =?us-ascii?Q?E9mZZ73Mahdu4Zf9Em3O9j9BWo0srabTZkPQqdhqPwFbMtWsEvTofvsoLdVN?=
 =?us-ascii?Q?/flvhnb+J2IovSy0ynPic2NvY97JHlILbRiu+hrxVGHn+6x60f3gpEUuF5mw?=
 =?us-ascii?Q?QHmm1kT3Ojkc+eMXfeNbEAhz7p8j90q47XciTin77Xf89WvMENu4bz8gNs+C?=
 =?us-ascii?Q?T0VJoLdeXMqzxmjbD9KXNO3qfmus3xyQgIZKKFdvHNBqB51n7zmnU+VVGQNJ?=
 =?us-ascii?Q?8zA8+2Eo41GxagkjO/t9F7N23rzbv9dJn9hf4DWZo5CPP2AFEP6CMSjJ8lEU?=
 =?us-ascii?Q?vjTXDpkvCEw8nhjJw8xGMCJTmC4+RjmoO3Lqh8yhsx6YxN9pEe17G0IeRlWk?=
 =?us-ascii?Q?BsW2vyIWe2GkWHJBkDlAg2YG/PxioCaHzEbBTF6OsTlQ3WTAZNBFHllFktH/?=
 =?us-ascii?Q?Uw/W6uVZqA1AVt334HG/IO4NH/ZOqlYmzb7FztqnKwpwX92tXO7wyughS+x6?=
 =?us-ascii?Q?srhi/C4ZIVj2QuBw9kfozPpX5OquqldoYOn2S540UZaja1czPubhiYR0DiAA?=
 =?us-ascii?Q?UxTjsuQ488dRFVtoF7QYKOzQf+QRf2GQz8VYEdlQFUV5+e4TXBjjHskR8+cp?=
 =?us-ascii?Q?3tlCaL5kmJq0zVBNkRqKdeAwM3LmNJw38eDniVIvbQ7Cho47beHJD0/Pkj+3?=
 =?us-ascii?Q?6mzsa8g2K9qjiIzmMg6eE+KsM2iI38dFOnMGkNUIWnepCfxXuVtS7hNiyaqv?=
 =?us-ascii?Q?ijUKEhjDOjubr38qGxLa6loBwUSeew+bEDWi+7nLreQ+wg+JMJz/o8YHIfCq?=
 =?us-ascii?Q?5W6v16M=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 11:25:50.3749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512583e2-ac37-4c90-d05b-08dcfcc36fcb
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0553
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
sizes, eMMC HS400 yes/no). Add a new SOM-scoped defconfig that makes use
of the hardware introspection of the phycore-imx93 board-code, to detect
the SOM module variant, and to configure the hardware accordingly. The
resulting SPL and u-boot binary shall able to boot each phyCORE-i.MX93
module variant on each carrier board.

Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>, Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  14 +-
 board/phytec/phycore_imx93/MAINTAINERS        |   1 +
 configs/imx93-phycore_defconfig               | 156 ++++++++++++++++++
 3 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 configs/imx93-phycore_defconfig

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 25c778bb07..e84476c38a 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -2,15 +2,25 @@
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
+
+	/*
+	 * If the u-boot build uses the device tree of a phyCORE-i.MX93 carrier
+	 * board (i.E. imx93-phyboard-segin.dts), then this u-boot.dtsi
+	 * deactivates all carrier board-specific peripherals. This means that
+	 * the resulting SPL and u-boot binary can boot the phyCORE-i.MX 93 module
+	 * on each carrier board.
+	 */
+	model = "PHYTEC phyCORE-i.MX93";
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog3>;
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index cea817ffdc..d6eb5eb287 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -9,5 +9,6 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
 F:      board/phytec/phycore_imx93/
 F:      board/phytec/common/imx93_som_detection.c
 F:      board/phytec/common/imx93_som_detection.h
+F:      configs/imx93-phycore_defconfig
 F:      configs/imx93-phyboard-segin_defconfig
 F:      include/configs/phycore_imx93.h
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
new file mode 100644
index 0000000000..2c818d01b7
--- /dev/null
+++ b/configs/imx93-phycore_defconfig
@@ -0,0 +1,156 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="phycore_imx93"
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
+CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_TARGET_PHYCORE_IMX93=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x720000
+CONFIG_CMD_DEKBLOB=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if test ${doraucboot} = 1; then run raucinit; fi; if run loadimage; then run mmcboot; else run netboot; fi; fi;"
+CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x2051a000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=2
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=4096
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth1"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SYSCON=y
+CONFIG_SPL_CLK_IMX93=y
+CONFIG_CLK_IMX93=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY_TI_GENERIC=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_MIPI_DPHY_HELPERS=y
+CONFIG_PHY_IMX93_MIPI_DPHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX93=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX93_BLK_CTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_USB_PORT_AUTO=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
-- 
2.34.1

