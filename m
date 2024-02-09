Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BF4C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FFE87E6F;
	Fri,  9 Feb 2024 10:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="FTy8Njw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC7087E5D; Fri,  9 Feb 2024 10:48:22 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92AA87E52
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1707472098; x=1739008098;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GHjRPItyAHMdnl5S/Cui5uAvX4BkvfU4S9wCFss34I4=;
 b=FTy8Njw0rkw10QNbnV8cTQgWtCWssoIZb1RFtNoAlxtf3fXtbqLhY2+z
 AVTE6LOw1z81ApbRwhNSXMbcPSEMm91Fj+esgOOeA0hYRw9KVYiP8TRKT
 jxEyJf4s8/WQPgZem5/lixEXzyrWlSGrm+vjVu8N73ZM5b55PLdmJvj2G
 wMtSoCmIOxYrYuYz9ADYe8ElIhETMMVPVx9+X6DqBwC72RuaRHO8OnN9G
 1z+9f0Sweje/7MFfXEdb1ZbWVF1WVRsQshtvmpK941FBQzbFpWP/EQNkc
 ynqcno3lB1vR9MncoIoBYWBLUwvH1uCcAhlxdXVVBfB7en8MUHrl6NRYX w==;
X-CSE-ConnectionGUID: IXquNyB4THOovAdpdmyrFw==
X-CSE-MsgGUID: iuOUj6/5Q5Gud/DnNdx2eQ==
X-IronPort-AV: E=Sophos;i="6.05,256,1701154800"; d="scan'208";a="16015703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2024 02:48:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 02:47:50 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 02:47:49 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/4] ARM: dts: at91: sama7g54_curiosity: Add initial device
 tree of the board
Date: Fri, 9 Feb 2024 11:47:35 +0200
Message-ID: <20240209094737.38347-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209094737.38347-1-mihai.sain@microchip.com>
References: <20240209094737.38347-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add initial device tree of the SAMA7G54 Curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/dts/Makefile                         |   3 +
 .../dts/at91-sama7g54_curiosity-u-boot.dtsi   |  59 +++++
 arch/arm/dts/at91-sama7g54_curiosity.dts      | 246 ++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
 create mode 100644 arch/arm/dts/at91-sama7g54_curiosity.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3beb8f1b9d..65b955280a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1263,6 +1263,9 @@ dtb-$(CONFIG_TARGET_OMAP4_SDP4430) += \
 dtb-$(CONFIG_TARGET_SAMA7G5EK) += \
 	at91-sama7g5ek.dtb
 
+dtb-$(CONFIG_TARGET_SAMA7G54_CURIOSITY) += \
+	at91-sama7g54_curiosity.dtb
+
 dtb-$(CONFIG_TARGET_SAMA5D2_PTC_EK) += \
 	at91-sama5d2_ptc_ek.dtb
 
diff --git a/arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
new file mode 100644
index 0000000000..04d7d9e522
--- /dev/null
+++ b/arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * at91-sama7g54_curiosity-u-boot.dtsi - Device Tree file for SAMA7G5 SoC u-boot properties.
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Mihai Sain <mihai.sain@microchip.com>
+ *
+ */
+
+/ {
+	chosen {
+		bootph-all;
+	};
+};
+
+&main_rc {
+	bootph-all;
+};
+
+&main_xtal {
+	bootph-all;
+};
+
+&pioA {
+	bootph-all;
+};
+
+&pinctrl_flx3_default {
+	bootph-all;
+};
+
+&pinctrl_sdmmc1_default {
+	bootph-all;
+};
+
+&pit64b0 {
+	bootph-all;
+};
+
+&pmc {
+	bootph-all;
+};
+
+&sdmmc1 {
+	bootph-all;
+};
+
+&slow_rc_osc {
+	bootph-all;
+};
+
+&slow_xtal {
+	bootph-all;
+};
+
+&uart3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/at91-sama7g54_curiosity.dts b/arch/arm/dts/at91-sama7g54_curiosity.dts
new file mode 100644
index 0000000000..dfe06bd1f9
--- /dev/null
+++ b/arch/arm/dts/at91-sama7g54_curiosity.dts
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sama7g54_curiosity.dts - Device Tree file for SAMA7G54 CURIOSITY board
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Mihai Sain <mihai.sain@microchip.com>
+ *
+ */
+/dts-v1/;
+#include "sama7g5-pinfunc.h"
+#include "sama7g5.dtsi"
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/at91.h>
+
+/ {
+	model = "Microchip SAMA7G54 Curiosity";
+	compatible = "microchip,sama7g54_curiosity", "microchip,sama7g5", "microchip,sama7";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mmcblk1p2 rw rootwait";
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart3;
+		i2c0 = &i2c10;
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+		status = "okay";
+
+		led-red {
+			label = "red";
+			gpios = <&pioA PIN_PD13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pioA PIN_PD14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-blue {
+			label = "blue";
+			gpios = <&pioA PIN_PB15 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x10000000>; // 256MB DDR3L-1066 16-bit
+	};
+};
+
+&ebi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand_default>;
+	status = "okay";
+
+	nand_controller: nand-controller {
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			atmel,rb = <0>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			status = "okay";
+		};
+	};
+};
+
+&qspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_default>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+		status = "okay";
+	};
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	uart3: serial@200 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx3_default>;
+		status = "okay";
+	};
+};
+
+&flx10 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c10: i2c@600 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx10_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "okay";
+
+		adc@1f {
+			compatible = "microchip,pac1934";
+			reg = <0x1f>;
+		};
+
+		eeprom@51 {
+			compatible = "atmel,24c02";
+			reg = <0x51>;
+			pagesize = <16>;
+			size = <256>;
+			status = "okay";
+		};
+
+		pmic@5b {
+			compatible = "microchip,mcp16502";
+			reg = <0x5b>;
+		};
+	};
+};
+
+&pioA {
+	pinctrl_flx3_default: flx3-default {
+		pinmux = <PIN_PD16__FLEXCOM3_IO0>,
+			 <PIN_PD17__FLEXCOM3_IO1>;
+		bias-pull-up;
+	};
+
+	pinctrl_flx10_default: flx10-default {
+		pinmux = <PIN_PC30__FLEXCOM10_IO0>,
+			 <PIN_PC31__FLEXCOM10_IO1>;
+		bias-pull-up;
+	};
+
+	pinctrl_led_gpio_default: led_gpio-default {
+		pinmux = <PIN_PD13__GPIO>,
+			 <PIN_PD14__GPIO>,
+			 <PIN_PB15__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_nand_default: nand-default {
+		pinmux = <PIN_PD9__D0>,
+			 <PIN_PD10__D1>,
+			 <PIN_PD11__D2>,
+			 <PIN_PC21__D3>,
+			 <PIN_PC22__D4>,
+			 <PIN_PC23__D5>,
+			 <PIN_PC24__D6>,
+			 <PIN_PD2__D7>,
+			 <PIN_PD3__NANDRDY>,
+			 <PIN_PD4__NCS3_NANDCS>,
+			 <PIN_PD5__NWE_NWR0_NANDWE>,
+			 <PIN_PD6__NRD_NANDOE>,
+			 <PIN_PD7__A21_NANDALE>,
+			 <PIN_PD8__A22_NANDCLE>;
+		bias-disable;
+		slew-rate = <0>;
+	};
+
+	pinctrl_qspi1_default: qspi1-default {
+		pinmux = <PIN_PB22__QSPI1_IO3>,
+			 <PIN_PB23__QSPI1_IO2>,
+			 <PIN_PB24__QSPI1_IO1>,
+			 <PIN_PB25__QSPI1_IO0>,
+			 <PIN_PB26__QSPI1_CS>,
+			 <PIN_PB27__QSPI1_SCK>;
+		bias-pull-up;
+		slew-rate = <0>;
+	};
+
+	pinctrl_sdmmc0_default: sdmmc0-default {
+		pinmux = <PIN_PA0__SDMMC0_CK>,
+			 <PIN_PA1__SDMMC0_CMD>,
+			 <PIN_PA2__SDMMC0_RSTN>,
+			 <PIN_PA3__SDMMC0_DAT0>,
+			 <PIN_PA4__SDMMC0_DAT1>,
+			 <PIN_PA5__SDMMC0_DAT2>,
+			 <PIN_PA6__SDMMC0_DAT3>;
+		bias-pull-up;
+		slew-rate = <0>;
+	};
+
+	pinctrl_sdmmc1_default: sdmmc1-default {
+		pinmux = <PIN_PB29__SDMMC1_CMD>,
+			 <PIN_PB30__SDMMC1_CK>,
+			 <PIN_PB31__SDMMC1_DAT0>,
+			 <PIN_PC0__SDMMC1_DAT1>,
+			 <PIN_PC1__SDMMC1_DAT2>,
+			 <PIN_PC2__SDMMC1_DAT3>,
+			 <PIN_PC4__SDMMC1_CD>;
+		bias-pull-up;
+		slew-rate = <0>;
+	};
+};
+
+// M.2 slot for wireless card
+&sdmmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <50000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	status = "okay";
+};
+
+// micro SD socket
+&sdmmc1 {
+	bus-width = <4>;
+	disable-wp;
+	max-frequency = <50000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	status = "okay";
+};
-- 
2.43.0

