Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64257CF8869
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 01:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252DB88F73;
	Sat,  5 Oct 2024 03:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728090819;
	bh=8+lSAmFg/NX7mWKB7caCOB+fOVTsVAD/scWRf+ddkkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQRU74wBhJOlkoh+uJ+TpsTVxHhmI8mt4nUe0x+lH/WcZWeRX+7/tGOHXGjCY309K
	 8MbIH7fppm2B9pkobTRBQXKymIO2uF7Z9hZIGn8DYqUybttXYGRJMPb/m4lbQ7JMxh
	 X38Ghr7efRllVLFuJ9tMIxYbZhWJc+oB85j+7KyeqlzXzD7fvHwE4aMkKcYGwRMi1G
	 hXOhKWydzM0Sql6yDrJ5HRSUvFdWcL5dyjwR2DHwGTUaDC43EN2yb1jPjJIqP13WOD
	 5VhOj3QzlHweAIfjs/qw7Dj63KPTHek3nQL8oeg8ZrgU6DsFCpO8e/Krc8OQ/CdTLY
	 5ww8TRe5SUYhQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6033888B89;
 Sat,  5 Oct 2024 03:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728090817;
 bh=8+lSAmFg/NX7mWKB7caCOB+fOVTsVAD/scWRf+ddkkk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FYOcmr32QMboLtwTNk8JwgosjkzWpdjurkGQWrw+q0uqBNbpM20GC645GsTHT8+R7
 uCFkQrVvIjVycMkUoz60mfzlcWeT3gXeLCWMXIDoXEA13+qjUxsc18sx0rNH6YUKiN
 I19sIU7LlaOf77aXc5BKTGOedd/GD8fJ5r8kialUVxgSsamYdv+IhWLnLje1BEe+WS
 lM8U1z0ZrDfgDDaLt2iQyGS+X6OYCn5y/n0Q70T0pdpiN+FpRnSDKHeY3kNw3npHbu
 e+kNXgDyD3gkq3Ui+jEFild2JS+9QihPaDTaZr3IE4IJngBPy3zEOHg0d4E2FGDZqF
 AYjshib5owo+w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 2/2] arm64: dts: imx: Switch to using upstream DT on DH
 i.MX8MP DHCOM PDK2/PDK3
Date: Sat,  5 Oct 2024 03:12:47 +0200
Message-ID: <20241005011315.436233-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241005011315.436233-1-marex@denx.de>
References: <20241005011315.436233-1-marex@denx.de>
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

Enable OF_UPSTREAM to use upstream DT and add freescale/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi and DTBOs from arch/$(ARCH)/dts/ directory.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: Enable CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
---
 arch/arm/dts/Makefile               |   2 -
 arch/arm/dts/imx8mp-dhcom-pdk2.dts  | 158 --------------
 arch/arm/dts/imx8mp-dhcom-pdk3.dts  | 317 ----------------------------
 configs/imx8mp_dhcom_pdk2_defconfig |   6 +-
 configs/imx8mp_dhcom_pdk3_defconfig |   6 +-
 5 files changed, 8 insertions(+), 481 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk3.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 83e38f0352a..ed97e1c26de 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -969,8 +969,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
 	imx8mp-debix-model-a.dtb \
 	imx8mp-dhcom-drc02.dtb \
-	imx8mp-dhcom-pdk2.dtb \
-	imx8mp-dhcom-pdk3.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
 	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk2.dts b/arch/arm/dts/imx8mp-dhcom-pdk2.dts
deleted file mode 100644
index 8f4eff37c40..00000000000
--- a/arch/arm/dts/imx8mp-dhcom-pdk2.dts
+++ /dev/null
@@ -1,158 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2022 Marek Vasut <marex@denx.de>
- *
- * DHCOM iMX8MP variant:
- * DHCM-iMX8ML8-C160-R409-F1638-SPI16-GE-CAN2-SD-RTC-WBTA-ADC-T-RGB-CSI2-HS-I-01D2
- * DHCOM PCB number: 660-100 or newer
- * PDK2 PCB number: 516-400 or newer
- */
-
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mp-dhcom-som.dtsi"
-
-/ {
-	model = "DH electronics i.MX8M Plus DHCOM Premium Developer Kit (2)";
-	compatible = "dh,imx8mp-dhcom-pdk2", "dh,imx8mp-dhcom-som",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		button-0 {
-			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>; /* GPIO A */
-			label = "TA1-GPIO-A";
-			linux,code = <KEY_A>;
-			pinctrl-0 = <&pinctrl_dhcom_a>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-1 {
-			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>; /* GPIO B */
-			label = "TA2-GPIO-B";
-			linux,code = <KEY_B>;
-			pinctrl-0 = <&pinctrl_dhcom_b>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-2 {
-			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>; /* GPIO C */
-			label = "TA3-GPIO-C";
-			linux,code = <KEY_C>;
-			pinctrl-0 = <&pinctrl_dhcom_c>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-3 {
-			gpios = <&gpio4 27 GPIO_ACTIVE_LOW>; /* GPIO D */
-			label = "TA4-GPIO-D";
-			linux,code = <KEY_D>;
-			pinctrl-0 = <&pinctrl_dhcom_d>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-	};
-
-	led {
-		compatible = "gpio-leds";
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* GPIO E */
-			pinctrl-0 = <&pinctrl_dhcom_e>;
-			pinctrl-names = "default";
-		};
-
-		led-1 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* GPIO F */
-			pinctrl-0 = <&pinctrl_dhcom_f>;
-			pinctrl-names = "default";
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>; /* GPIO H */
-			pinctrl-0 = <&pinctrl_dhcom_h>;
-			pinctrl-names = "default";
-		};
-
-		led-3 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
-			pinctrl-0 = <&pinctrl_dhcom_i>;
-			pinctrl-names = "default";
-		};
-	};
-};
-
-&fec {	/* Second ethernet */
-	pinctrl-0 = <&pinctrl_fec_rgmii>;
-	phy-handle = <&ethphypdk>;
-	phy-mode = "rgmii";
-
-	mdio {
-		ethphypdk: ethernet-phy@7 { /* KSZ 9021 */
-			compatible = "ethernet-phy-ieee802.3-c22";
-			pinctrl-0 = <&pinctrl_ethphy1>;
-			pinctrl-names = "default";
-			interrupt-parent = <&gpio4>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-			max-speed = <100>;
-			reg = <7>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-			rxc-skew-ps = <3000>;
-			rxd0-skew-ps = <0>;
-			rxd1-skew-ps = <0>;
-			rxd2-skew-ps = <0>;
-			rxd3-skew-ps = <0>;
-			rxdv-skew-ps = <0>;
-			txc-skew-ps = <3000>;
-			txd0-skew-ps = <0>;
-			txd1-skew-ps = <0>;
-			txd2-skew-ps = <0>;
-			txd3-skew-ps = <0>;
-			txen-skew-ps = <0>;
-		};
-	};
-};
-
-&flexcan1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	fsl,over-current-active-low;
-};
-
-&iomuxc {
-	/*
-	 * GPIO_A,B,C,D are connected to buttons.
-	 * GPIO_E,F,H,I are connected to LEDs.
-	 * GPIO_M is connected to CLKOUT2.
-	 */
-	pinctrl-0 = <&pinctrl_hog_base
-		     &pinctrl_dhcom_g &pinctrl_dhcom_j
-		     &pinctrl_dhcom_k &pinctrl_dhcom_l
-		     &pinctrl_dhcom_int>;
-};
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3.dts b/arch/arm/dts/imx8mp-dhcom-pdk3.dts
deleted file mode 100644
index 867d238f2b5..00000000000
--- a/arch/arm/dts/imx8mp-dhcom-pdk3.dts
+++ /dev/null
@@ -1,317 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2023 Marek Vasut <marex@denx.de>
- *
- * DHCOM iMX8MP variant:
- * DHCM-iMX8ML8-C160-R409-F1638-SPI16-GE-CAN2-SD-RTC-WBTA-ADC-T-RGB-CSI2-HS-I-01D2
- * DHCOM PCB number: 660-100 or newer
- * PDK3 PCB number: 669-100 or newer
- */
-
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mp-dhcom-som.dtsi"
-
-/ {
-	model = "DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3)";
-	compatible = "dh,imx8mp-dhcom-pdk3", "dh,imx8mp-dhcom-som",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	clk_ext_audio_codec: clock-codec {
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		compatible = "fixed-clock";
-	};
-
-	clk_xtal25: clk-xtal25 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-		data-role = "dual";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				usb_c_0_hs_ep: endpoint {
-					remote-endpoint = <&dwc3_0_hs_ep>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				usb_c_0_ss_ep: endpoint {
-					remote-endpoint = <&ptn5150_in_ep>;
-				};
-			};
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		button-0 {
-			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>; /* GPIO A */
-			label = "TA1-GPIO-A";
-			linux,code = <KEY_A>;
-			pinctrl-0 = <&pinctrl_dhcom_a>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-1 {
-			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>; /* GPIO B */
-			label = "TA2-GPIO-B";
-			linux,code = <KEY_B>;
-			pinctrl-0 = <&pinctrl_dhcom_b>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-2 {
-			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>; /* GPIO C */
-			label = "TA3-GPIO-C";
-			linux,code = <KEY_C>;
-			pinctrl-0 = <&pinctrl_dhcom_c>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-
-		button-3 {
-			gpios = <&gpio5 22 GPIO_ACTIVE_LOW>; /* GPIO E */
-			label = "TA4-GPIO-E";
-			linux,code = <KEY_E>;
-			pinctrl-0 = <&pinctrl_dhcom_e>;
-			pinctrl-names = "default";
-			wakeup-source;
-		};
-	};
-
-	led {
-		compatible = "gpio-leds";
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			function-enumerator = <0>;
-			gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>; /* GPIO D */
-			pinctrl-0 = <&pinctrl_dhcom_d>;
-			pinctrl-names = "default";
-		};
-
-		led-1 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			function-enumerator = <1>;
-			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* GPIO F */
-			pinctrl-0 = <&pinctrl_dhcom_f>;
-			pinctrl-names = "default";
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			function-enumerator = <2>;
-			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>; /* GPIO G */
-			pinctrl-0 = <&pinctrl_dhcom_g>;
-			pinctrl-names = "default";
-		};
-
-		led-3 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "off";
-			function = LED_FUNCTION_INDICATOR;
-			function-enumerator = <3>;
-			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
-			pinctrl-0 = <&pinctrl_dhcom_i>;
-			pinctrl-names = "default";
-		};
-	};
-
-	reg_avdd: regulator-avdd {	/* AUDIO_VDD */
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "AUDIO_VDD";
-	};
-};
-
-&i2c5 {
-	i2cmux@70 {
-		compatible = "nxp,pca9540";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		i2cmuxed0: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			typec@3d {
-				compatible = "nxp,ptn5150";
-				reg = <0x3d>;
-				interrupt-parent = <&gpio4>;
-				interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_ptn5150>;
-				status = "okay";
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-
-						ptn5150_in_ep: endpoint {
-							remote-endpoint = <&usb_c_0_ss_ep>;
-						};
-					};
-
-					port@1 {
-						reg = <1>;
-
-						ptn5150_out_ep: endpoint {
-							remote-endpoint = <&dwc3_0_ss_ep>;
-						};
-					};
-				};
-			};
-
-			power-sensor@40 {
-			    compatible = "ti,ina238";
-			    reg = <0x40>;
-			    shunt-resistor = <20000>;	/* 0.02 R */
-			    ti,shunt-gain = <1>;	/* Drop cca. 40mV */
-			};
-
-			eeprom_board: eeprom@54 {
-				compatible = "atmel,24c04";
-				pagesize = <16>;
-				reg = <0x54>;
-			};
-
-			pcieclk: clk@6b {
-				compatible = "skyworks,si52144";
-				reg = <0x6b>;
-				clocks = <&clk_xtal25>;
-				#clock-cells = <1>;
-			};
-		};
-
-		i2cmuxed1: i2c@1 {	/* HDMI DDC I2C */
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-	};
-};
-
-&fec {	/* Second ethernet */
-	pinctrl-0 = <&pinctrl_fec_rgmii>;
-	phy-handle = <&ethphypdk>;
-	phy-mode = "rgmii-id";
-
-	mdio {
-		ethphypdk: ethernet-phy@7 { /* Micrel KSZ9131RNXI */
-			compatible = "ethernet-phy-id0022.1642",
-				     "ethernet-phy-ieee802.3-c22";
-			interrupt-parent = <&gpio4>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-0 = <&pinctrl_ethphy1>;
-			pinctrl-names = "default";
-			reg = <7>;
-			reset-assert-us = <1000>;
-			/* RESET_N signal rise time ~100ms */
-			reset-deassert-us = <120000>;
-			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-			status = "okay";
-		};
-	};
-};
-
-&flexcan1 {
-	status = "okay";
-};
-
-&pcie_phy {
-	clocks = <&pcieclk 1>;
-	clock-names = "ref";
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	status = "okay";
-};
-
-&pcie {
-	fsl,max-link-speed = <3>;
-	reset-gpio = <&gpio1 6 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	usb-role-switch;
-
-	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dwc3_0_hs_ep: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&usb_c_0_hs_ep>;
-		};
-
-		dwc3_0_ss_ep: endpoint@1 {
-			reg = <1>;
-			remote-endpoint = <&ptn5150_out_ep>;
-		};
-	};
-};
-
-&usb3_1 {
-	fsl,disable-port-power-control;
-	fsl,permanently-attached;
-};
-
-&usb_dwc3_1 {
-	/* This port has USB5734 Hub connected to it, PWR/OC pins are unused */
-	/delete-property/ pinctrl-names;
-	/delete-property/ pinctrl-0;
-};
-
-&iomuxc {
-	/*
-	 * GPIO_A,B,C,E are connected to buttons.
-	 * GPIO_D,F,G,I are connected to LEDs.
-	 * GPIO_H is connected to USB Hub RESET_N.
-	 * GPIO_M is connected to CLKOUT2.
-	 */
-	pinctrl-0 = <&pinctrl_hog_base
-		     &pinctrl_dhcom_h &pinctrl_dhcom_j &pinctrl_dhcom_k
-		     &pinctrl_dhcom_l
-		     &pinctrl_dhcom_int>;
-
-	pinctrl_ptn5150: ptn5150grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25		0x40000000
-		>;
-	};
-};
diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index f807b0cfc37..d527ca92c83 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFE0000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-pdk2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-dhcom-pdk2"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_DH_DHCOM_PDK2=y
 CONFIG_DM_RESET=y
@@ -48,7 +48,7 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run dh_update_env distro_bootcmd ; reset"
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-pdk2.dtb"
+CONFIG_DEFAULT_FDT_FILE="freescale/imx8mp-dhcom-pdk2.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_CONSOLE_MUX=y
@@ -144,6 +144,8 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 05895d6dd6f..5a41f140bb5 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFE0000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-pdk3"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-dhcom-pdk3"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_DH_DHCOM_PDK2=y
 CONFIG_DM_RESET=y
@@ -50,7 +50,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run dh_update_env distro_bootcmd ; reset"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gpio clear GPIO1_11 ; sleep 0.1 ; gpio set GPIO1_11 ; sleep 0.1 ; i2c dev 4 && i2c mw 0x70 0 4 && i2c probe 0x2d && i2c mw 0x2d 0xaa55.2 0"
-CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-pdk3.dtb"
+CONFIG_DEFAULT_FDT_FILE="freescale/imx8mp-dhcom-pdk3.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_CONSOLE_MUX=y
@@ -147,6 +147,8 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.45.2

