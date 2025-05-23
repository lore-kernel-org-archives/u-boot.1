Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690EC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0878B8340A;
	Fri, 23 May 2025 19:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3919983285; Fri, 23 May 2025 19:20:34 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A032833E8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4M-0076pt-7U;
 Fri, 23 May 2025 17:20:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 09/13] board: venice: add imx8mp-gw82xx support
Date: Fri, 23 May 2025 10:20:14 -0700
Message-Id: <20250523172018.4164647-9-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Gateworks GW82XX-2X is an ARM based single board computer (SBC)
comprised of the i.MX8M Plus based gw702x SoM and the gw82xx
baseboard featuring:
 - i.MX8M Plus SoC
 - LPDDR4 DRAM
 - eMMC FLASH
 - Gateworks System Controller (GSC)
 - microSD (1.8V/3.3V Capable)
 - panel status bi-color LED
 - pushbutton switch
 - fan controller with tachometer
 - USB Type-C connector
 - PCIe switch
 - 2x GbE RJ45 connectors
 - multi-protocol RS232/RS485/RS422 Serial ports
 - 2x Flexible Socket Adapters with SDIO/UART/USB/PCIe
   (for M.2 and miniPCIe expansion)
 - 2x isolated CAN
 - GPS
 - accelerometer
 - magnetometer
 - off-board connectors for: SPI, GPIO, I2C, ADC
 - Wide range DC power input
 - support for 802.3at PoE (via adapter)

Add support for it by providing its device-tree.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi   | 49 +++++++++++++++++++
 configs/imx8mp_venice_defconfig               |  2 +-
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi

diff --git a/arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi
new file mode 100644
index 000000000000..2d58b3b8ab71
--- /dev/null
+++ b/arch/arm/dts/imx8mp-venice-gw82xx-2x-u-boot.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Gateworks Corporation
+ */
+#include "imx8mp-venice-gw702x-u-boot.dtsi"
+
+&gpio4 {
+	dio_1 {
+		gpio-hog;
+		input;
+		gpios = <8 GPIO_ACTIVE_HIGH>;
+		line-name = "dio1";
+	};
+
+	dio_0 {
+		gpio-hog;
+		input;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		line-name = "dio0#";
+	};
+
+	usb1mux {
+		gpio-hog;
+		output-high;
+		gpios = <17 GPIO_ACTIVE_HIGH>;
+		line-name = "usb1_mux";
+	};
+
+	rs485_en {
+		gpio-hog;
+		output-low;
+		gpios = <22 GPIO_ACTIVE_HIGH>;
+		line-name = "rs485_en";
+	};
+
+	rs485_term {
+		gpio-hog;
+		output-low;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		line-name = "rs485_term";
+	};
+
+	rs485_half {
+		gpio-hog;
+		output-low;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		line-name = "rs485_hd";
+	};
+};
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 8f591f4c7dce..10eac0a0c785 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -88,7 +88,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x"
+CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x freescale/imx8mp-venice-gw82xx-2x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
-- 
2.25.1

