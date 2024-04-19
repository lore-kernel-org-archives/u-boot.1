Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D364C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6F988629;
	Fri, 19 Apr 2024 08:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lehuU4Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AAE88684; Fri, 19 Apr 2024 08:51:32 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501B18860F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713509489; x=1716101489;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KsNhs0INo1/sBwdRN8E5td3RbSnwA+Lg8+O8+dh54os=;
 b=lehuU4QiTc+WA/XXC9brYjF4uQmZjsF3M8AWJJEisJyQOQRuMpDYuyr2YcS0s+qr
 nbcxWbHtaAoaKupufsHe4zL+WQoCo5vHPfNHEW67177hGr318ghBneZupk8KYmrD
 NUyKSpdeJ/c/xnCGMZNEVoJ5U6/p/hbb8rZVEhcFhqU=;
X-AuditID: ac14000a-fadff7000000290d-76-6622147038e5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5B.95.10509.07412266;
 Fri, 19 Apr 2024 08:51:28 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 08:51:28 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 1/3] phycore-am62x: Migrate to OF_UPSTREAM
Date: Fri, 19 Apr 2024 08:51:15 +0200
Message-ID: <20240419065117.2305346-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419065117.2305346-1-w.egorov@phytec.de>
References: <20240419065117.2305346-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRpKBR7dARCnNoOenjcXbvZ3sFt3v1B2Y
 PM7e2cHo0d/dwhrAFMVlk5Kak1mWWqRvl8CVsWL6JvaC9vmMFYtmLGFqYLzTyNjFyMkhIWAi
 cXbHM9YuRi4OIYElTBKrp/xig3AeM0q8a3jNAlLFJqAucWfDN1YQW0RASuJl50bmLkYODmYB
 OYll/UUgYWEBK4nbl++ygoRZBFQl5m9PAwnzClhKrP96mAlil7zEzEvf2UFsTqDyty+XMYPY
 QkA102dA3MMrIChxcuYTsK3MQPXNW2czQ9gSEgdfvICql5d4cWk5C8zMaedeM0PYoRJbv2xn
 msAoNAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKAAFmHg2sHYN8fjECMT
 B+MhRgkOZiURXjMOxTQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotg
 skwcnFINjDM5E2ZvN51hfTAnOOLgPcVKa7OKZ80xb79fWr7PY8b+Mj0FgYn3uIyX22ydeqkj
 g61tfc7R046dd37+dZne+V8srejWz/7mlYxNe/ODlkwS5Miq0DH78aOdP1ji4D4324rYTbUS
 G+f7RD99vDxl4m7XB1Hcx/X/nqqtKPEo501ztJjLu+7cCSWW4oxEQy3mouJEAJ3OoxtOAgAA
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

The phycore-am62x can be migrated to OF_UPSTREAM.
Drop redundant device tree files, update MAINTAINERS and
defconfig's DEFAULT_DEVICE_TREE for ti vendor prefix accordingly.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/k3-am62-phycore-som.dtsi         | 324 ------------------
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   | 266 --------------
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |   2 +-
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 board/phytec/phycore_am62x/MAINTAINERS        |   2 -
 configs/phycore_am62x_a53_defconfig           |   2 +-
 7 files changed, 3 insertions(+), 595 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
 delete mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b1c9c6222e..3646c64d05 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1354,7 +1354,6 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
 			      k3-am625-beagleplay.dtb \
 			      k3-am625-r5-beagleplay.dtb \
 			      k3-am625-verdin-r5.dtb \
-			      k3-am625-phyboard-lyra-rdk.dtb \
 			      k3-am625-r5-phycore-som-2gb.dtb
 
 dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-sk.dtb \
diff --git a/arch/arm/dts/k3-am62-phycore-som.dtsi b/arch/arm/dts/k3-am62-phycore-som.dtsi
deleted file mode 100644
index aa43e7407e..0000000000
--- a/arch/arm/dts/k3-am62-phycore-som.dtsi
+++ /dev/null
@@ -1,324 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
- *
- * Product homepage:
- * https://www.phytec.com/product/phycore-am62x
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	model = "PHYTEC phyCORE-AM62x";
-	compatible = "phytec,am62-phycore-som", "ti,am625";
-
-	aliases {
-		ethernet0 = &cpsw_port1;
-		gpio0 = &main_gpio0;
-		gpio1 = &main_gpio1;
-		i2c0 = &main_i2c0;
-		mmc0 = &sdhci0;
-		rtc0 = &i2c_som_rtc;
-		rtc1 = &wkup_rtc0;
-		spi0 = &ospi0;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-
-	reserved_memory: reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		ramoops@9ca00000 {
-			compatible = "ramoops";
-			reg = <0x00 0x9ca00000 0x00 0x00100000>;
-			record-size = <0x8000>;
-			console-size = <0x8000>;
-			ftrace-size = <0x00>;
-			pmsg-size = <0x8000>;
-		};
-
-		secure_tfa_ddr: tfa@9e780000 {
-			reg = <0x00 0x9e780000 0x00 0x80000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9db00000 0x00 0x00c00000>;
-			no-map;
-		};
-	};
-
-	vcc_5v0_som: regulator-vcc-5v0-som {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_5V0_SOM";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vdd_1v8: regulator-vdd-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_5v0_som>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>;
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			function = LED_FUNCTION_HEARTBEAT;
-		};
-	};
-};
-
-&main_pmx0 {
-	leds_pins_default: leds-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x034, PIN_OUTPUT, 7) /* (H21) OSPI0_CSN2.GPIO0_13 */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
-			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
-		>;
-	};
-
-	main_mdio1_pins_default: main-mdio1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
-			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
-		>;
-	};
-
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT_PULLDOWN, 0) /* (AB1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT_PULLUP, 0) /* (AA2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
-		>;
-	};
-
-	main_rgmii1_pins_default: main-rgmii1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17) RGMII1_RD0 */
-			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17) RGMII1_RD1 */
-			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16) RGMII1_RD2 */
-			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15) RGMII1_RD3 */
-			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17) RGMII1_RXC */
-			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17) RGMII1_RX_CTL */
-			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0 */
-			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1 */
-			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2 */
-			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
-			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
-			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
-		>;
-	};
-
-	ospi0_pins_default: ospi0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
-			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
-			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
-			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
-			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
-			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
-			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
-			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
-			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
-			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
-			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
-		>;
-	};
-
-	pmic_irq_pins_default: pmic-irq-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
-		>;
-	};
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_rgmii1_pins_default>;
-};
-
-&cpsw_port1 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy1>;
-};
-
-&cpsw3g_mdio {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mdio1_pins_default>;
-	status = "okay";
-
-	cpsw3g_phy1: ethernet-phy@1 {
-		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-&main_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	pmic@30 {
-		compatible = "ti,tps65219";
-		reg = <0x30>;
-		buck1-supply = <&vcc_5v0_som>;
-		buck2-supply = <&vcc_5v0_som>;
-		buck3-supply = <&vcc_5v0_som>;
-		ldo1-supply = <&vdd_3v3>;
-		ldo2-supply = <&vdd_1v8>;
-		ldo3-supply = <&vcc_5v0_som>;
-		ldo4-supply = <&vcc_5v0_som>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_irq_pins_default>;
-		interrupt-parent = <&gic500>;
-		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		ti,power-button;
-		system-power-controller;
-
-		regulators {
-			vdd_core: buck1 {
-				regulator-name = "VDD_CORE";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vdd_3v3: buck2 {
-				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vdd_ddr4: buck3 {
-				regulator-name = "VDD_DDR4";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vddshv5_sdio: ldo1 {
-				regulator-name = "VDDSHV5_SDIO";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-allow-bypass;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vddr_core: ldo2 {
-				regulator-name = "VDDR_CORE";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vdda_1v8: ldo3 {
-				regulator-name = "VDDA_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vdd_2v5: ldo4 {
-				regulator-name = "VDD_2V5";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	eeprom@50 {
-		compatible = "atmel,24c32";
-		pagesize = <32>;
-		reg = <0x50>;
-	};
-
-	i2c_som_rtc: rtc@52 {
-		compatible = "microcrystal,rv3028";
-		reg = <0x52>;
-	};
-};
-
-&ospi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ospi0_pins_default>;
-	status = "okay";
-
-	serial_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <8>;
-		spi-rx-bus-width = <8>;
-		spi-max-frequency = <25000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <0>;
-	};
-};
-
-&sdhci0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	non-removable;
-	status = "okay";
-};
diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts b/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
deleted file mode 100644
index a438baf542..0000000000
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
+++ /dev/null
@@ -1,266 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
- *
- * Product homepage:
- * https://www.phytec.com/product/phyboard-am62x
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
-#include "k3-am62-phycore-som.dtsi"
-
-/ {
-	compatible = "phytec,am625-phyboard-lyra-rdk",
-		     "phytec,am62-phycore-som", "ti,am625";
-	model = "PHYTEC phyBOARD-Lyra AM625";
-
-	aliases {
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		mmc1 = &sdhci1;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		ethernet1 = &cpsw_port2;
-	};
-
-	can_tc1: can-phy0 {
-		compatible = "ti,tcan1042";
-		#phy-cells = <0>;
-		max-bitrate = <5000000>;
-		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
-	};
-
-	keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pins_default>;
-
-		key-home {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
-		};
-
-		key-menu {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
-
-		led-1 {
-			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-		};
-
-		led-2 {
-			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-		};
-	};
-
-	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_MMC";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&main_pmx0 {
-	gpio_keys_pins_default: gpio-keys-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
-		>;
-	};
-
-	gpio_exp_int_pins_default: gpio-exp-int-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
-			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
-		>;
-	};
-
-	main_mcan0_pins_default: main-mcan0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
-			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
-			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
-			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
-			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
-			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
-			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
-		>;
-	};
-
-	main_rgmii2_pins_default: main-rgmii2-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
-			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
-			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
-			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
-			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
-			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
-			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
-			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
-			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
-			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
-			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
-			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
-		>;
-	};
-
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
-			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
-			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
-			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
-		>;
-	};
-
-	main_usb1_pins_default: main-usb1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
-		>;
-	};
-
-	user_leds_pins_default: user-leds-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
-		>;
-	};
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
-};
-
-&cpsw_port2 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy3>;
-};
-
-&cpsw3g_mdio {
-	cpsw3g_phy3: ethernet-phy@3 {
-		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
-		reg = <3>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-&main_i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	gpio_exp: gpio-expander@21 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_exp_int_pins_default>;
-		compatible = "nxp,pcf8574";
-		reg = <0x21>;
-		interrupt-parent = <&main_gpio1>;
-		interrupts = <49 0>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-line-names = "GPIO0_HDMI_RST", "GPIO1_CAN0_nEN",
-				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
-				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
-				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c02";
-		pagesize = <16>;
-		reg = <0x51>;
-	};
-};
-
-&main_mcan0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcan0_pins_default>;
-	phys = <&can_tc1>;
-	status = "okay";
-};
-
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-	/* Main UART1 may be used by TIFS firmware */
-	status = "okay";
-};
-
-&sdhci1 {
-	vmmc-supply = <&vcc_3v3_mmc>;
-	vqmmc-supply = <&vddshv5_sdio>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	no-1-8-v;
-	status = "okay";
-};
-
-&usbss0 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usbss1 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "peripheral";
-};
-
-&usb1 {
-	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb1_pins_default>;
-};
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index ed50bfeb03..dbee4aa8d8 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -140,7 +140,7 @@
 #endif /* CONFIG_TARGET_PHYCORE_AM62X_R5 */
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_A53
-#define SPL_AM625_PHYBOARD_LYRA_DTB "spl/dts/k3-am625-phyboard-lyra-rdk.dtb"
+#define SPL_AM625_PHYBOARD_LYRA_DTB "spl/dts/ti/k3-am625-phyboard-lyra-rdk.dtb"
 #define AM625_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 9786751874..8b0cdd74f4 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -31,6 +31,7 @@ config TARGET_PHYCORE_AM62X_A53
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply OF_UPSTREAM
 
 config TARGET_PHYCORE_AM62X_R5
 	bool "PHYTEC phyCORE-AM62x running on R5"
diff --git a/board/phytec/phycore_am62x/MAINTAINERS b/board/phytec/phycore_am62x/MAINTAINERS
index 884e9c6776..02ac88e58a 100644
--- a/board/phytec/phycore_am62x/MAINTAINERS
+++ b/board/phytec/phycore_am62x/MAINTAINERS
@@ -3,9 +3,7 @@ M:	Wadim Egorov <w.egorov@phytec.de>
 W:	https://www.phytec.com/product/phycore-am62x
 S:	Maintained
 F:	arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
-F:	arch/arm/dts/k3-am62-phycore-som.dtsi
 F:	arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
-F:	arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
 F:	arch/arm/dts/k3-am625-phycore-som-binman.dtsi
 F:	arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62x/
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 08a2532d39..792e122f3f 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -12,7 +12,7 @@ CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="k3-am625-phyboard-lyra-rdk"
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
 CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.25.1

