Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B673FCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC98847B0;
	Thu, 11 Jun 2026 16:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NynEGTA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69AD8407D; Thu, 11 Jun 2026 15:48:08 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B04083FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso43744435e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781185682; x=1781790482; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ciHHokQKDubYEfmKg05Q9kiJzhfK5HqVQxPsKd0N4bM=;
 b=NynEGTA/EzR7nIj1K086+AQRQUtNXKj1iQaWA2P0rNpNhCtFI8HZ+l+CJvozkC6pm5
 NACmuza/Q62VUtGepIOwzA18Sczl28NSfLYvQflWXGJp95n4zKxMILIrPfqZRaZ1hDSZ
 Lko7cSWdWcjLqyC8pjPSKRL2XtcdLkVORyRqBmiishqFHQLuRRdJlHtv0LkPIrelV86g
 z0QnGCzmJkNDXXyA8Fka4x1K2hLJCjDiw5gv58gF/gIWh2Uww63O+byUG/GyWURmy1Tk
 kEyriuONgFndXXgmw9YebSgO/LK34rjOO50ZZXYMLn8dW7PU3lAMX0IK64Xa8z2KF5ot
 U+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185682; x=1781790482;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciHHokQKDubYEfmKg05Q9kiJzhfK5HqVQxPsKd0N4bM=;
 b=PnicrivM7iQv4VW3FT8RUvYrW2c5brBTNfm39Z8iB6S3Qr6ularU8sPfrFNKfwBHWR
 WCWpQIMOqABnF/BXhfXOCBZxSp6aL/IOf3wsYbmuNEmILIOHZxmO5NhIAqSiEM5TUDcO
 rwUCUlSoa7vdx/W/FAa1W7HZfTGnzrt5/9HVSvKiYfwuTYe87QvYAAeF8Bzk/tO8ePiI
 +jHiXU8aZ0o+rYWcF3tqKKsbWOJOnN/DbLROneIgXb4BxKgks3B8tmfsprjVfRdpU3oX
 q4DxnJlFycqJZdtsuWjZcdk/Yfi+kc2rTsD2btUeZWKLzOOxK6X6ZtvXLv4sLy6obOPX
 M4Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e1P3uCKxJkBOYSrRVq7wYbQjlG0oWZsg/1/aORzi9mpXl+YvUm3AmjKQ506QcGEsEETGa9AA=@lists.denx.de
X-Gm-Message-State: AOJu0YzagB7muRKldWKivCBUWWd/ubQXAbg4wUqtD29RMNi674ynSaG1
 xhVemjHVYN3fz/OiWTMZ85/zw6GI7z8XdgW2FY5AaMGWUCl4hXfmP6FO
X-Gm-Gg: Acq92OHcXumeZX5aKIX2OUTks8ts1wsN9jw48ONAEQCyn9FQmcunESFd45QKNGz8tcC
 UlSBcK9IXdqX+KHfaXQutVJLjnWal/OerLeYasaHQdgome+vc8ZctdDd3QVJJfqn+wL2d8Lt3IB
 Uqq1bFgsWV7fdIlNorOFYODV+Jiv9/2qaEsighC188idZt3spsRP/YXd8E5uTCcJkJAZWAc6XQe
 T1BxS1ZWAtV9yo8ssxXo0JgyG69hExaOtA4vS7yrPsUyLLL78Bd/pQDm2XellewPUhuZ93ESESh
 Dbnrjrag+GzDBN0c6rWKEo18jtVUM36O/hAAvIBXKmyLH7rSkHXvOtsHw/AllNwSVF2g+3w8inX
 yqbU1yS08f1AcLykhEiQAXMGTBsgIqp9ypNPjQu0phNGtAUsjwRxWlX01vabAA04z9JNJgsxhk/
 O+3CTQ2hduGFY+B0pXVpoLqA1b1PFsoX4jkeyfRlYBwlJsvtYFw0jVlwqEF1ZQRfjDUEwi9ydzM
 o7gWlMsrDAnJa5fON1p1uiiXsMw4IuQo84qdUBSc1z5pvwaWgONwq0HIlKCULPVEjGSA0DogmvW
 v7eggNd5kBqZ
X-Received: by 2002:a05:600c:c059:10b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490e55ed6a7mr30821235e9.14.1781185681436; 
 Thu, 11 Jun 2026 06:48:01 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f368e9fsm76735681f8f.37.2026.06.11.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:48:00 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Thu, 11 Jun 2026 15:47:48 +0200
Subject: [PATCH] board: toradex: add initial support for aquila imx95
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-aquila-imx95-v1-1-6a13d7190e83@toradex.com>
X-B4-Tracking: v=1; b=H4sIAIO8KmoC/yXMSw5AMBRA0a3IG2uiPhW2IgYtrzzxbVUkYu+K4
 Rnce4FFQ2ihDC4weJClZfbgYQBNL+cOGbXeEEexiATnTG6ORsloOouMqVRzoUQudZGAT1aDms5
 vV9W/rVMDNvv7gPt+AJWNME5wAAAA
X-Change-ID: 20260611-aquila-imx95-b4f16b67af93
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 11 Jun 2026 16:53:49 +0200
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

From: Franz Schnyder <franz.schnyder@toradex.com>

Add initial U-Boot support for Aquila iMX95 SoM.

Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
Device tree is being upstreamed to Linux [1]. Later, we can switch to
OF_UPSTREAM.

[1]: https://lore.kernel.org/all/20260521-add-aquila-imx95-v4-0-5a7f86c824f5@toradex.com/
---
 arch/arm/dts/imx95-aquila-dev-u-boot.dtsi   |   40 +
 arch/arm/dts/imx95-aquila-dev.dts           |  389 +++++++++
 arch/arm/dts/imx95-aquila.dtsi              | 1160 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig              |    5 +
 board/toradex/aquila-imx95/Kconfig          |   36 +
 board/toradex/aquila-imx95/MAINTAINERS      |   11 +
 board/toradex/aquila-imx95/Makefile         |    8 +
 board/toradex/aquila-imx95/aquila-imx95.c   |   23 +
 board/toradex/aquila-imx95/aquila-imx95.env |   20 +
 board/toradex/aquila-imx95/spl.c            |   75 ++
 configs/aquila-imx95_defconfig              |  186 +++++
 doc/board/toradex/aquila-imx95.rst          |  175 ++++
 doc/board/toradex/index.rst                 |    1 +
 include/configs/aquila-imx95.h              |   28 +
 14 files changed, 2157 insertions(+)

diff --git a/arch/arm/dts/imx95-aquila-dev-u-boot.dtsi b/arch/arm/dts/imx95-aquila-dev-u-boot.dtsi
new file mode 100644
index 00000000000..92ec0d3efa3
--- /dev/null
+++ b/arch/arm/dts/imx95-aquila-dev-u-boot.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/* Copyright (c) Toradex */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&usb3 {
+	bootph-pre-ram;
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+	compatible = "fsl,imx95a-dwc3", "fsl,imx8mq-dwc3", "snps,dwc3";
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
diff --git a/arch/arm/dts/imx95-aquila-dev.dts b/arch/arm/dts/imx95-aquila-dev.dts
new file mode 100644
index 00000000000..3df17700b63
--- /dev/null
+++ b/arch/arm/dts/imx95-aquila-dev.dts
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
+ * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx95-aquila.dtsi"
+
+/ {
+	model = "Aquila iMX95 on Aquila Development Board";
+	compatible = "toradex,aquila-imx95-dev",
+		     "toradex,aquila-imx95",
+		     "fsl,imx95";
+
+	aliases {
+		eeprom1 = &carrier_eeprom;
+	};
+
+	dp_1_connector: dp0-connector {
+		compatible = "dp-connector";
+		dp-pwr-supply = <&reg_dp_3p3v>;
+		type = "full-size";
+
+		port {
+			dp_1_connector_in: endpoint {
+				remote-endpoint = <&dsi2dp_out>;
+			};
+		};
+	};
+
+	reg_carrier_1p8v: regulator-carrier-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-carrier 1V8";
+	};
+
+	reg_dp_3p3v: regulator-dp-3p3v {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_21_dp>;
+		/* Aquila GPIO_21_DP */
+		gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "DP_3V3";
+		startup-delay-us = <10000>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "aquila-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack",
+			"IN1R", "Digital Mic";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Microphone", "Digital Mic",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&wm8904_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+	};
+};
+
+/* Aquila ADC_[1-4] */
+&adc1 {
+	status = "okay";
+};
+
+/* Aquila CTRL_WAKE1_MICO# */
+&aquila_key_wake {
+	status = "okay";
+};
+
+&dsi2dp_out {
+	remote-endpoint = <&dp_1_connector_in>;
+};
+
+/* Aquila ETH_1 */
+&enetc_port0 {
+	status = "okay";
+};
+
+/* Aquila CAN_1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Aquila CAN_2 */
+&flexcan2 {
+	status = "okay";
+};
+
+/* Aquila CAN_3 */
+&flexcan3 {
+	status = "okay";
+};
+
+/* Aquila CAN_4 */
+&flexcan4 {
+	status = "okay";
+};
+
+/* Aquila QSPI_1 */
+&flexspi1 {
+	pinctrl-0 = <&pinctrl_flexspi1_4bit>,
+		    <&pinctrl_qspi_cs1>;
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <66000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_8>;
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_1>,
+		    <&pinctrl_gpio_2>,
+		    <&pinctrl_gpio_3>,
+		    <&pinctrl_gpio_4>,
+		    <&pinctrl_gpio_5>,
+		    <&pinctrl_gpio_6>,
+		    <&pinctrl_gpio_7>;
+};
+
+/* Aquila I2C_1 */
+&lpi2c2 {
+	status = "okay";
+
+	fan_controller: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#pwm-cells = <2>;
+
+		fan {
+			cooling-levels = <255>;
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+
+	wm8904_1a: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai2_mclk>;
+		clocks = <&scmi_clk IMX95_CLK_SAI2>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&reg_carrier_1p8v>;
+		CPVDD-supply = <&reg_carrier_1p8v>;
+		DBVDD-supply = <&reg_carrier_1p8v>;
+		DCVDD-supply = <&reg_carrier_1p8v>;
+		MICVDD-supply = <&reg_carrier_1p8v>;
+		wlf,drc-cfg-names = "default", "peaklimiter";
+		/*
+		 * Config registers per name, respectively:
+		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
+		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
+		 */
+		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
+				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>;
+		/* GPIO1 = DMIC_CLK, don't touch others */
+		wlf,gpio-cfg = <0x0018>, <0xffff>, <0xffff>, <0xffff>;
+		wlf,in1r-as-dmicdat2;
+	};
+
+	/* Current measurement into module VCC */
+	hwmon@41 {
+		compatible = "ti,ina226";
+		reg = <0x41>;
+		shunt-resistor = <5000>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	/* USB-C OTG (TCPC USB PD PHY) */
+	tcpc@52 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x52>;
+		interrupt-parent = <&som_gpio_expander_1>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			op-sink-microwatt = <0>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 0, PDO_FIXED_USB_COMM)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_con_hs: endpoint {
+						remote-endpoint = <&usb1_con_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb1_con_ss>;
+					};
+				};
+			};
+		};
+	};
+
+	carrier_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* Aquila I2C_2 */
+&i3c2 {
+	status = "okay";
+};
+
+/* Aquila I2C_4_CSI1 */
+&lpi2c4 {
+	status = "okay";
+};
+
+/* Aquila I2C_6 */
+&lpi2c5 {
+	status = "okay";
+};
+
+/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
+&lpi2c8 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* I2C on DSI Connector Pin #4 and #6 */
+		i2c_dsi_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* I2C on DSI Connector Pin #52 and #54 */
+		i2c_dsi_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* Aquila SPI_1 */
+&lpspi6 {
+	status = "okay";
+};
+
+/* Aquila UART_3, used as the Linux Console */
+&lpuart1 {
+	status = "okay";
+};
+
+/* Aquila UART_4 */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Aquila UART_1 */
+&lpuart3 {
+	status = "okay";
+};
+
+/* Aquila UART_2 as RS485 */
+&lpuart7 {
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+
+	status = "okay";
+};
+
+/* Aquila PCIE_1 */
+&pcie0 {
+	status = "okay";
+};
+
+/* Aquila I2S_1 */
+&sai2 {
+	status = "okay";
+};
+
+/* Aquila PWM_1 */
+&tpm3 {
+	status = "okay";
+};
+
+/* Aquila PWM_2 */
+&tpm6 {
+	status = "okay";
+};
+
+/* Aquila PWM_3_DSI and PWM_4_DP */
+&tpm5 {
+	status = "okay";
+};
+
+/* Aquila USB_2, optional Bluetooth USB */
+&usb2 {
+	status = "okay";
+};
+
+/* Aquila USB_1 */
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	status = "okay";
+
+	port {
+		usb1_con_hs: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
+};
+
+&usb3_phy {
+	orientation-switch;
+
+	status = "okay";
+
+	port {
+		usb1_con_ss: endpoint {
+			remote-endpoint = <&typec_con_ss>;
+		};
+	};
+};
+
+/* Aquila SD_1 */
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx95-aquila.dtsi b/arch/arm/dts/imx95-aquila.dtsi
new file mode 100644
index 00000000000..69dc962a24a
--- /dev/null
+++ b/arch/arm/dts/imx95-aquila.dtsi
@@ -0,0 +1,1160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include "imx95.dtsi"
+
+/ {
+	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		can2 = &flexcan3;
+		can3 = &flexcan4;
+		eeprom0 = &som_eeprom;
+		ethernet0 = &enetc_port0;
+		i2c0 = &lpi2c3;
+		i2c1 = &lpi2c2;
+		i2c2 = &i3c2;
+		i2c3 = &lpi2c8;
+		i2c4 = &lpi2c4;
+		i2c6 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &rtc_i2c;
+		rtc1 = &scmi_bbm;
+		serial0 = &lpuart3;
+		serial1 = &lpuart7;
+		serial2 = &lpuart1;
+		serial3 = &lpuart2;
+		usb0 = &usb3;
+		usb1 = &usb2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aquila_key_wake: gpio-key-wakeup {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
+
+		status = "disabled";
+
+		key-wakeup {
+			/* Aquila CTRL_WAKE1_MICO# */
+			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+			label = "Wake Up";
+			wakeup-source;
+			linux,code = <KEY_WAKEUP>;
+		};
+	};
+
+	clk_dsi2dp_refclk: clock-dsi2dp-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
+	clk_dsi2dp_refclk_en: clock-dsi2dp-refclk-en {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_dp_clk_en>;
+		clocks = <&clk_dsi2dp_refclk>;
+		#clock-cells = <0>;
+		/* CTRL_DP_CLK_EN */
+		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	clk_serdes_eth_ref: clock-serdes-eth-ref {
+		compatible = "gpio-gate-clock";
+		#clock-cells = <0>;
+		/* CTRL_ETH_REF_CLK_STBY */
+		enable-gpios = <&som_gpio_expander_0 6 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-module +V1.8";
+	};
+
+	reg_dp_1p2v: regulator-dp-1p2v {
+		compatible = "regulator-fixed";
+		/* CTRL_DP_BRIDGE_EN */
+		gpios = <&som_gpio_expander_0 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "On-module +V1.2_DP";
+		vin-supply = <&reg_1p8v>;
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		/* Aquila USB_1_EN */
+		gpios = <&som_gpio_expander_0 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_1_EN";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		/* Aquila USB_2_EN */
+		gpios = <&som_gpio_expander_0 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_2_H_EN";
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sd1_pwr_en>;
+		/* Aquila SD_1_PWR_EN */
+		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "SD_1_PWR_EN";
+		startup-delay-us = <20000>;
+	};
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		/* PMIC_SD_1_VSEL */
+		gpios = <&som_gpio_expander_1 9 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "PMIC_SD_1_VSEL";
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+	};
+
+	remoteproc-cm7 {
+		compatible = "fsl,imx95-cm7";
+		mboxes = <&mu7 0 1 &mu7 1 1 &mu7 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x3c000000>;
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			linux,cma-default;
+		};
+
+		m7_reserved: memory@80000000 {
+			reg = <0 0x80000000 0 0x1000000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@88220000 {
+			reg = <0 0x88220000 0 0x1000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@88000000 {
+			reg = <0 0x88000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@88008000 {
+			reg = <0 0x88008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@88010000 {
+			reg = <0 0x88010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@88018000 {
+			reg = <0 0x88018000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@88020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x88020000 0 0x100000>;
+			no-map;
+		};
+	};
+};
+
+/* Aquila ADC_[1-4] */
+&adc1 {
+	vref-supply = <&reg_1p8v>;
+};
+
+/* Aquila ETH_1 */
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+};
+
+/* Aquila CAN_1 */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+/* Aquila CAN_2 */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+/* Aquila CAN_3 */
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+};
+
+/* Aquila CAN_4 */
+&flexcan4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan4>;
+};
+
+/* Aquila QSPI_1 */
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1_8bit>,
+		    <&pinctrl_qspi_cs1>;
+};
+
+&gpio1 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AQUILA_C24", /* 10 */
+			  "",
+			  "AQUILA_B17",
+			  "CTRL_GPIO_EXP_INT#",
+			  "AQUILA_B18";
+
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AQUILA_B42",
+			  "",
+			  "AQUILA_B43";
+};
+
+&gpio3 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AQUILA_A11",
+			  "", /* 20 */
+			  "AQUILA_B57",
+			  "AQUILA_B19";
+};
+
+&gpio4 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AQUILA_C22",
+			  "AQUILA_C21",
+			  "AQUILA_C20",
+			  "", /* 20 */
+			  "",
+			  "",
+			  "AQUILA_C23",
+			  "AQUILA_D23",
+			  "AQUILA_D24",
+			  "",
+			  "AQUILA_D25";
+};
+
+&gpio5 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "AQUILA_B44",
+			  "AQUILA_B45";
+};
+
+/* Aquila I2C_2 */
+&i3c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2>;
+	i2c-scl-hz = <100000>;
+};
+
+/* Aquila I2C_1 */
+&lpi2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* On-module I2C - I2C_SOM */
+&lpi2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>, <&pinctrl_ctrl_gpio_exp_int>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>, <&pinctrl_ctrl_gpio_exp_int>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	status = "okay";
+
+	som_gpio_expander_0: gpio@20 {
+		compatible = "nxp,pcal6408";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"AQUILA_C38", /* 0 */
+			"PCIE_2_RESET#",
+			"AQUILA_B77",
+			"USB_2_H_EN",
+			"BT_DISABLE#",
+			"WIFI_DISABLE#",
+			"CTRL_ETH_REF_CLK_STBY",
+			"CTRL_DP_BRIDGE_EN";
+	};
+
+	som_gpio_expander_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"AQUILA_C1", /* 0 */
+			"AQUILA_C2",
+			"AQUILA_C3",
+			"AQUILA_C4",
+			"AQUILA_C36",
+			"AQUILA_B74",
+			"AQUILA_B75",
+			"USB_2_H_OC#",
+			"AQUILA_B81",
+			"PMIC_SD_1_VSEL",
+			"ETH_1_INT#", /* 10 */
+			"CTRL_TPM_INT#",
+			"SPI_2_CS2_TPM",
+			"PCIE_WAKE_WIFI#",
+			"WIFI_WAKE_BT",
+			"WIFI_WAKEUP_HOST";
+	};
+
+	som_dsi2dp_bridge: bridge@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		clocks = <&clk_dsi2dp_refclk_en>;
+		clock-names = "refclk";
+		vcc-supply = <&reg_dp_1p2v>;
+		vcca-supply = <&reg_dp_1p2v>;
+		vccio-supply = <&reg_1p8v>;
+		vpll-supply = <&reg_1p8v>;
+
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dsi2dp_in: endpoint {
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				dsi2dp_out: endpoint {
+					data-lanes = <3 2 1 0>;
+				};
+			};
+		};
+	};
+
+	rtc_i2c: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+	};
+
+	som_eeprom: eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/* Aquila I2C_4_CSI1 */
+&lpi2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	pinctrl-1 = <&pinctrl_lpi2c4_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* Aquila I2C_6 */
+&lpi2c5 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
+&lpi2c8 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c8>;
+	pinctrl-1 = <&pinctrl_lpi2c8_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* Aquila SPI_2 */
+&lpspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi4>;
+	cs-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>,
+		   <&som_gpio_expander_1 12 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+
+	som_tpm: tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		interrupt-parent = <&som_gpio_expander_1>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		/*
+		 * Maximum TPM-supported speed is 18.5 MHz, limited to 12 MHz
+		 * here as lpspi4's per-clock (2x the max speed) is 24 MHz.
+		 */
+		spi-max-frequency = <12000000>;
+	};
+};
+
+/* Aquila SPI_1 */
+&lpspi6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi6>;
+	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
+/* Aquila UART_3, used as the Linux Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+/* Aquila UART_4 */
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+};
+
+/* Aquila UART_1 */
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+};
+
+/* Aquila UART_2 */
+&lpuart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	uart-has-rtscts;
+};
+
+&mu7 {
+	status = "okay";
+};
+
+/* Aquila ETH_2_XGMII_MDIO, shared between all ethernet ports */
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+
+	status = "okay";
+
+	ethphy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&som_gpio_expander_1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+};
+
+&netcmix_blk_ctrl {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_timer {
+	status = "okay";
+};
+
+/* Aquila PCIE_1 */
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpios = <&som_gpio_expander_0 0 GPIO_ACTIVE_LOW>;
+};
+
+/* On-module Wi-Fi or Aquila PCIE_2 */
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie1>;
+	reset-gpios = <&som_gpio_expander_0 1 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+/* Aquila I2S_1 */
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI2>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
+};
+
+&scmi_bbm {
+	linux,code = <KEY_POWER>;
+};
+
+&thermal_zones {
+	/* PF09 Main PMIC */
+	pf09-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 2>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_ARM PMIC */
+	pf53-arm-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 4>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_SOC PMIC */
+	pf53-soc-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 3>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
+/* Aquila PWM_1 */
+&tpm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+/* Aquila PWM_2 */
+&tpm6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+/* Aquila PWM_3_DSI and PWM_4_DP */
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3_dsi>, <&pinctrl_pwm4_dp>;
+};
+
+/* Aquila USB_2, optional Bluetooth USB */
+&usb2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb2_vbus>;
+};
+
+/* Aquila USB_1 */
+&usb3 {
+	fsl,disable-port-power-control;
+};
+
+&usb3_dwc3 {
+	dr_mode = "otg";
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+};
+
+&usb3_phy {
+	vbus-supply = <&reg_usb1_vbus>;
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};
+
+/* Aquila SD_1 */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_sd1_cd_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_sd1_cd_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_sd1_cd_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_sd1_cd_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	/* Aquila CTRL_WAKE1_MICO# */
+	pinctrl_ctrl_wake1_mico: ctrlwake1micogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x31e>; /* Aquila D6 */
+	};
+
+	pinctrl_ctrl_dp_clk_en: dpclkengrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x11e>; /* CTRL_DP_CLK_EN */
+	};
+
+	/* Aquila ETH_2_XGMII_MDIO */
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC	0x57e>, /* Aquila B90 */
+			   <IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO	0x97e>; /* Aquila B89 */
+	};
+
+	/* Aquila ETH_1 */
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>, /* ENET1_TX_CTL */
+			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>, /* ENET1_TXC    */
+			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e>, /* ENET1_TDO    */
+			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e>, /* ENET1_TD1    */
+			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e>, /* ENET1_TD2    */
+			   <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e>, /* ENET1_TD3    */
+			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>, /* ENET1_RX_CTL */
+			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>, /* ENET1_RXC    */
+			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>, /* ENET1_RD0    */
+			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>, /* ENET1_RD1    */
+			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>, /* ENET1_RD2    */
+			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>; /* ENET1_RD3    */
+	};
+
+	/* Aquila CAN_1 */
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* Aquila B48 */
+			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* Aquila B49 */
+	};
+
+	/* Aquila CAN_2 */
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* Aquila B50 */
+			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* Aquila B51 */
+	};
+
+	/* Aquila CAN_3 */
+	pinctrl_flexcan3: flexcan3grp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO3__CAN3_TX	0x39e>, /* Aquila B53 */
+			   <IMX95_PAD_CCM_CLKO4__CAN3_RX	0x39e>; /* Aquila B54 */
+	};
+
+	/* Aquila CAN_4 */
+	pinctrl_flexcan4: flexcan4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO04__CAN4_TX	0x39e>, /* Aquila B55 */
+			   <IMX95_PAD_GPIO_IO05__CAN4_RX	0x39e>; /* Aquila B56 */
+	};
+
+	/* Aquila QSPI_1 (4 bit) */
+	pinctrl_flexspi1_4bit: flexspi14bitgrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK	0x3fe>, /* Aquila B65 */
+			   <IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0	0x3fe>, /* Aquila B68 */
+			   <IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1	0x3fe>, /* Aquila B67 */
+			   <IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2	0x3fe>, /* Aquila B61 */
+			   <IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3	0x3fe>, /* Aquila B60 */
+			   <IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS		0x3fe>; /* Aquila B63 */
+	};
+
+	/* Aquila QSPI_1 (8 bit) */
+	pinctrl_flexspi1_8bit: flexspi18bitgrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK	0x3fe>, /* Aquila B65 */
+			   <IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0	0x3fe>, /* Aquila B68 */
+			   <IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1	0x3fe>, /* Aquila B67 */
+			   <IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2	0x3fe>, /* Aquila B61 */
+			   <IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3	0x3fe>, /* Aquila B60 */
+			   <IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4	0x3fe>, /* Aquila B70 */
+			   <IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5	0x3fe>, /* Aquila B71 */
+			   <IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6	0x3fe>, /* Aquila B72 */
+			   <IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7	0x3fe>, /* Aquila B73 */
+			   <IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS		0x3fe>; /* Aquila B63 */
+	};
+
+	/* Aquila GPIO_01 */
+	pinctrl_gpio_1: gpio1grp {
+		fsl,pins = <IMX95_PAD_ENET2_RD0__GPIO4_IO_BIT24	0x31e>; /* Aquila D23 */
+	};
+
+	/* Aquila GPIO_02 */
+	pinctrl_gpio_2: gpio2grp {
+		fsl,pins = <IMX95_PAD_ENET2_RD1__GPIO4_IO_BIT25	0x31e>; /* Aquila D24 */
+	};
+
+	/* Aquila GPIO_03 */
+	pinctrl_gpio_3: gpio3grp {
+		fsl,pins = <IMX95_PAD_ENET2_RD3__GPIO4_IO_BIT27	0x31e>; /* Aquila D25 */
+	};
+
+	/* Aquila GPIO_04 */
+	pinctrl_gpio_4: gpio4grp {
+		fsl,pins = <IMX95_PAD_ENET2_TD0__GPIO4_IO_BIT19	0x31e>; /* Aquila C20 */
+	};
+
+	/* Aquila GPIO_05 */
+	pinctrl_gpio_5: gpio5grp {
+		fsl,pins = <IMX95_PAD_ENET2_TD1__GPIO4_IO_BIT18	0x31e>; /* Aquila C21 */
+	};
+
+	/* Aquila GPIO_06 */
+	pinctrl_gpio_6: gpio6grp {
+		fsl,pins = <IMX95_PAD_ENET2_TD2__GPIO4_IO_BIT17	0x31e>; /* Aquila C22 */
+	};
+
+	/* Aquila GPIO_07 */
+	pinctrl_gpio_7: gpio7grp {
+		fsl,pins = <IMX95_PAD_ENET2_RXC__GPIO4_IO_BIT23	0x31e>; /* Aquila C23 */
+	};
+
+	/* Aquila GPIO_08 */
+	pinctrl_gpio_8: gpio8grp {
+		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10	0x31e>; /* Aquila C24 */
+	};
+
+	/* Aquila GPIO_09_CSI_1 */
+	pinctrl_gpio_9_csi_1: gpio9csi1grp {
+		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_BIT12	0x31e>; /* Aquila B17 */
+	};
+
+	/* Aquila GPIO_10_CSI_1 */
+	pinctrl_gpio_10_csi_1: gpio10csi1grp {
+		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14	0x31e>; /* Aquila B18 */
+	};
+
+	/* Aquila GPIO_11_CSI_1 */
+	pinctrl_gpio_11_csi_1: gpio11csi1grp {
+		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x31e>; /* Aquila A11*/
+	};
+
+	/* Aquila GPIO_12_CSI_1 */
+	pinctrl_gpio_12_csi_1: gpio12csi1grp {
+		fsl,pins = <IMX95_PAD_SD3_DATA0__GPIO3_IO_BIT22	0x31e>; /* Aquila B19 */
+	};
+
+	/* Aquila GPIO_17_DSI_1 */
+	pinctrl_gpio_17_dsi_1: gpio17dsi1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO07__GPIO2_IO_BIT7	0x31e>; /* Aquila B42 */
+	};
+
+	/* Aquila GPIO_18_DSI_1 */
+	pinctrl_gpio_18_dsi_1: gpio18dsi1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO09__GPIO2_IO_BIT9	0x31e>; /* Aquila B43 */
+	};
+
+	/* Aquila GPIO_19_DSI_1 */
+	pinctrl_gpio_19_dsi_1: gpio19dsi1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13	0x31e>; /* Aquila B44 */
+	};
+
+	/* Aquila GPIO_20_DSI_1 */
+	pinctrl_gpio_20_dsi_1: gpio20dsi1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14	0x31e>; /* Aquila B45 */
+	};
+
+	/* Aquila GPIO_21_DP */
+	pinctrl_gpio_21_dp: gpio21dpgrp {
+		fsl,pins = <IMX95_PAD_SD3_CMD__GPIO3_IO_BIT21	0x31e>; /* Aquila B57 */
+	};
+
+	pinctrl_ctrl_gpio_exp_int: gpioexpintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_BIT13	0x31e>; /* CTRL_GPIO_EXP_INT# */
+	};
+
+	/* Aquila I2C_2 */
+	pinctrl_i3c2: i3c2cgrp {
+		fsl,pins = <IMX95_PAD_ENET1_MDC__I3C2_SCL	0x40001186>, /* Aquila C17 */
+			   <IMX95_PAD_ENET1_MDIO__I3C2_SDA	0x40001186>; /* Aquila C16 */
+	};
+
+	/* Aquila I2C_1 as GPIOs */
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* Aquila D8 */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* Aquila D7 */
+	};
+
+	/* Aquila I2C_1 */
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* Aquila D8 */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* Aquila D7 */
+	};
+
+	/* On-module I2C as GPIOs */
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* I2C_SOM_SDA */
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* I2C_SOM_SCL */
+	};
+
+	/* On-module I2C */
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* I2C_SOM_SDA */
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* I2C_SOM_SCL */
+	};
+
+	/* Aquila I2C_4_CSI1 as GPIO */
+	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>, /* Aquila A12 */
+			   <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>; /* Aquila A13 */
+	};
+
+	/* Aquila I2C_4_CSI1 */
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>, /* Aquila A12 */
+			   <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>; /* Aquila A13 */
+	};
+
+	/* Aquila I2C_6 as GPIO */
+	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* Aquila C18 */
+			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* Aquila C19 */
+	};
+
+	/* Aquila I2C_6 */
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* Aquila C18 */
+			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* Aquila C19 */
+	};
+
+	/* Aquila I2C_3_DSI1/I2C_5_CSI2 as GPIO */
+	pinctrl_lpi2c8_gpio: lpi2c8gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__GPIO2_IO_BIT12	0x40001b9e>, /* Aquila C5/B40 */
+			   <IMX95_PAD_GPIO_IO13__GPIO2_IO_BIT13	0x40001b9e>; /* Aquila C6/B41 */
+	};
+
+	/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
+	pinctrl_lpi2c8: lpi2c8grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__LPI2C8_SDA	0x40001b9e>, /* Aquila C5/B40 */
+			   <IMX95_PAD_GPIO_IO13__LPI2C8_SCL	0x40001b9e>; /* Aquila C6/B41 */
+	};
+
+	/* Aquila SPI_2 */
+	pinctrl_lpspi4: lpspi4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18	0x3fe>, /* Aquila D16 */
+			   <IMX95_PAD_GPIO_IO19__LPSPI4_SIN	0x3fe>, /* Aquila D15 */
+			   <IMX95_PAD_GPIO_IO20__LPSPI4_SOUT	0x3fe>, /* Aquila D17 */
+			   <IMX95_PAD_GPIO_IO21__LPSPI4_SCK	0x3fe>; /* Aquila D14 */
+	};
+
+	/* Aquila SPI_1 */
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0	0x3fe>, /* Aquila D9 */
+			   <IMX95_PAD_GPIO_IO01__LPSPI6_SIN	0x3fe>, /* Aquila D10 */
+			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT	0x3fe>, /* Aquila D11 */
+			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK	0x3fe>; /* Aquila D12 */
+	};
+
+	/* Aquila PCIE_1 */
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B	0x40001b1e>; /* Aquila C37 */
+	};
+
+	/* Aquila PCIE_2 */
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B	0x40001b1e>; /* Aquila C34 */
+	};
+
+	/* Aquila QSPI_1_CS1# */
+	pinctrl_qspi_cs1: qspics1grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B	0x3fe>; /* Aquila B66 */
+	};
+
+	/* Aquila QSPI_1_CS2# as GPIO */
+	pinctrl_qspi_cs2_gpio: qspics2gpiogrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27	0x3fe>; /* Aquila B62 */
+	};
+
+	/* Aquila I2S_1 */
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC		0x11e>, /* Aquila B21 */
+			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK		0x11e>, /* Aquila B20 */
+			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0		0x11e>, /* Aquila B23 */
+			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0	0x11e>; /* Aquila B22 */
+	};
+
+	pinctrl_sai2_mclk: sai2mclkgrp {
+		fsl,pins = <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK	0x31e>; /* Aquila B24 */
+	};
+
+	/* Aquila SD_1_CD# as GPIO */
+	pinctrl_sd1_cd_gpio: sd1cdgpiogrp {
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* Aquila A1 */
+	};
+
+	/* Aquila SD_1_PWR_EN */
+	pinctrl_sd1_pwr_en: sd1pwrengpiogrp {
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* Aquila A6 */
+	};
+
+	/* Aquila PWM_1 */
+	pinctrl_pwm1: tpm3ch3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO24__TPM3_CH3	0x11e>; /* Aquila C25 */
+	};
+
+	/* Aquila PWM_3_DSI as GPIO */
+	pinctrl_pwm3_dsi_gpio: tpm5ch0gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__GPIO2_IO_BIT6	0x11e>; /* Aquila B46 */
+	};
+
+	/* Aquila PWM_3_DSI */
+	pinctrl_pwm3_dsi: tpm5ch0grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* Aquila B46 */
+	};
+
+	/* Aquila PWM_4_DP */
+	pinctrl_pwm4_dp: tpm5ch3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO26__TPM5_CH3	0x11e>; /* Aquila B58 */
+	};
+
+	/* Aquila PWM_2 */
+	pinctrl_pwm2: tpm6ch0grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__TPM6_CH0	0x11e>; /* Aquila C26 */
+	};
+
+	/* Aquila UART_3 */
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>, /* Aquila D20 */
+			   <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>; /* Aquila D19 */
+	};
+
+	/* Aquila UART_4 */
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX	0x31e>, /* Aquila D22 */
+			   <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX	0x31e>; /* Aquila D21 */
+	};
+
+	/* Aquila UART_1 */
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART3_TX	0x31e>, /* Aquila B37 */
+			   <IMX95_PAD_GPIO_IO15__LPUART3_RX	0x31e>, /* Aquila B35 */
+			   <IMX95_PAD_GPIO_IO16__LPUART3_CTS_B	0x31e>, /* Aquila B36 */
+			   <IMX95_PAD_GPIO_IO17__LPUART3_RTS_B	0x31e>; /* Aquila B38 */
+	};
+
+	/* Aquila UART_2 */
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO36__LPUART7_TX	0x31e>, /* Aquila B33 */
+			   <IMX95_PAD_GPIO_IO37__LPUART7_RX	0x31e>, /* Aquila B31 */
+			   <IMX95_PAD_GPIO_IO10__LPUART7_CTS_B	0x31e>, /* Aquila B32 */
+			   <IMX95_PAD_GPIO_IO11__LPUART7_RTS_B	0x31e>; /* Aquila B34 */
+	};
+
+	/* On-module eMMC */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* eMMC_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* eMMC_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* eMMC_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* eMMC_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* eMMC_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* eMMC_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* eMMC_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* eMMC_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* eMMC_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* eMMC_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* eMMC_STROBE */
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* eMMC_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* eMMC_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* eMMC_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* eMMC_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* eMMC_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* eMMC_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* eMMC_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* eMMC_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* eMMC_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* eMMC_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* eMMC_STROBE */
+	};
+
+	/* Aquila SD_1 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x158e>, /* Aquila A5  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x138e>, /* Aquila A7  */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x138e>, /* Aquila A3  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x138e>, /* Aquila A2  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x138e>, /* Aquila A10 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x138e>; /* Aquila A8  */
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x15fe>, /* Aquila A5  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x13fe>, /* Aquila A7  */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe>, /* Aquila A3  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe>, /* Aquila A2  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe>, /* Aquila A10 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe>; /* Aquila A8  */
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x400>, /* Aquila A5  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x400>, /* Aquila A7  */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x400>, /* Aquila A3  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x400>, /* Aquila A2  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x400>, /* Aquila A10 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x400>; /* Aquila A8  */
+	};
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4bb6a87ce26..f19c202a087 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -172,6 +172,10 @@ config TARGET_IMX943_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_AQUILA_IMX95
+	bool "Support Toradex Aquila iMX95"
+	select IMX95
+
 config TARGET_TORADEX_SMARC_IMX95
 	bool "Support Toradex SMARC iMX95"
 	select IMX95
@@ -205,6 +209,7 @@ source "board/phytec/phycore_imx91_93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
+source "board/toradex/aquila-imx95/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
 source "board/toradex/verdin-imx95/Kconfig"
 source "board/nxp/imx952_evk/Kconfig"
diff --git a/board/toradex/aquila-imx95/Kconfig b/board/toradex/aquila-imx95/Kconfig
new file mode 100644
index 00000000000..5936946e1af
--- /dev/null
+++ b/board/toradex/aquila-imx95/Kconfig
@@ -0,0 +1,36 @@
+if TARGET_AQUILA_IMX95
+
+config SYS_BOARD
+	default "aquila-imx95"
+
+config SYS_VENDOR
+	default "toradex"
+
+config SYS_CONFIG_NAME
+	default "aquila-imx95"
+
+config TDX_CFG_BLOCK
+	default y
+
+config TDX_CFG_BLOCK_2ND_ETHADDR
+	default y
+
+config TDX_CFG_BLOCK_DEV
+	default "0"
+
+# Toradex config block in eMMC, at the end of 1st "boot sector"
+config TDX_CFG_BLOCK_OFFSET
+	default "-512"
+
+config TDX_CFG_BLOCK_PART
+	default "1"
+
+config TDX_HAVE_EEPROM_EXTRA
+	default y
+
+config TDX_HAVE_MMC
+	default y
+
+source "board/toradex/common/Kconfig"
+
+endif
diff --git a/board/toradex/aquila-imx95/MAINTAINERS b/board/toradex/aquila-imx95/MAINTAINERS
new file mode 100644
index 00000000000..d2a74a53f5e
--- /dev/null
+++ b/board/toradex/aquila-imx95/MAINTAINERS
@@ -0,0 +1,11 @@
+Aquila iMX95
+F:	arch/arm/dts/imx95-aquila.dtsi
+F:	arch/arm/dts/imx95-aquila-dev.dts
+F:	arch/arm/dts/imx95-aquila-dev-u-boot.dtsi
+F:	board/toradex/aquila-imx95/
+F:	configs/aquila-imx95_defconfig
+F:	doc/board/toradex/aquila-imx95.rst
+F:	include/configs/aquila-imx95.h
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
+S:	Maintained
+W:	https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
diff --git a/board/toradex/aquila-imx95/Makefile b/board/toradex/aquila-imx95/Makefile
new file mode 100644
index 00000000000..caaf09465c8
--- /dev/null
+++ b/board/toradex/aquila-imx95/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Toradex
+
+obj-y += aquila-imx95.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/toradex/aquila-imx95/aquila-imx95.c b/board/toradex/aquila-imx95/aquila-imx95.c
new file mode 100644
index 00000000000..0c6473e4b3a
--- /dev/null
+++ b/board/toradex/aquila-imx95/aquila-imx95.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <fdt_support.h>
+#include <init.h>
+
+#include "../common/tdx-cfg-block.h"
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/toradex/aquila-imx95/aquila-imx95.env b/board/toradex/aquila-imx95/aquila-imx95.env
new file mode 100644
index 00000000000..5ca6cb18aaa
--- /dev/null
+++ b/board/toradex/aquila-imx95/aquila-imx95.env
@@ -0,0 +1,20 @@
+boot_scripts=boot.scr
+boot_script_dhcp=boot.scr
+boot_targets=mmc1 mmc0 dhcp
+console=ttyLP2
+fdt_board=dev
+fdt_addr=0x9c400000
+fdt_addr_r=0x9c400000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0x94400000
+kernel_comp_size=0x8000000
+ramdisk_addr_r=0x9c800000
+scriptaddr=0x9c600000
+
+update_uboot=
+		askenv confirm Did you load flash.bin (y/N)?;
+		if test "$confirm" = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt
+			${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0
+			${blkcnt};
+		fi
diff --git a/board/toradex/aquila-imx95/spl.c b/board/toradex/aquila-imx95/spl.c
new file mode 100644
index 00000000000..9f501c11c1d
--- /dev/null
+++ b/board/toradex/aquila-imx95/spl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <asm/global_data.h>
+#include <clk.h>
+#include <dm/uclass.h>
+#include <hang.h>
+#include <i2c.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	if (IS_ENABLED(CONFIG_SPL_RECOVER_DATA_SECTION))
+		spl_save_restore_data();
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls */
+	spl_early_init();
+
+	/* Need to enable SCMI drivers and ELE driver before console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* MU not probed, nothing can be outputed, hang */
+
+	arch_cpu_init();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
new file mode 100644
index 00000000000..bb3d475ef4d
--- /dev/null
+++ b/configs/aquila-imx95_defconfig
@@ -0,0 +1,186 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFDE00
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx95-aquila-dev"
+CONFIG_TARGET_AQUILA_IMX95=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -b"
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx95-aquila-${fdt_board}.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_LOG=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="Aquila iMX95 # "
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BOOTCOUNT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_UUID=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_SCMI=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_PROT_UDP=y
+CONFIG_IP_DEFRAG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x90400000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
+# CONFIG_SPL_SHA1 is not set
+CONFIG_LZO=y
diff --git a/doc/board/toradex/aquila-imx95.rst b/doc/board/toradex/aquila-imx95.rst
new file mode 100644
index 00000000000..de38217c165
--- /dev/null
+++ b/doc/board/toradex/aquila-imx95.rst
@@ -0,0 +1,175 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Toradex Aquila iMX95 Module
+==========================
+
+- SoM: https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
+- Carrier board: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
+
+Quick Start
+-----------
+
+- Setup environment
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Setup environment
+-----------------
+
+Suggested current toolchains are ARM 14.3 (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads):
+
+- https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
+- https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
+
+.. code-block:: console
+
+    $ export TOOLS=<path/to/directory/with/toolchains>
+    $ export CROSS_COMPILE_32=<path/to/arm/toolchain/bin/>arm-none-linux-gnueabihf-
+    $ export CROSS_COMPILE_64=<path/to/arm64/toolchain/bin/>aarch64-none-linux-gnu-
+
+Get ahab-container.img
+----------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+---------------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+    $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+
+Get and Build OEI Images
+------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get OEI from: https://git.toradex.com/cgit/imx-oei-toradex.git/
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://git.toradex.com/cgit/imx-oei-toradex.git/
+    $ cd imx-oei-toradex
+
+    $ make board=toradex-aquila-imx95 oei=ddr DEBUG=1 r=B0 all
+    $ cp build/toradex-aquila-imx95/ddr/oei-m33-ddr.bin $(srctree)
+
+    $ make board=toradex-aquila-imx95 oei=tcm DEBUG=1 r=B0 all
+    $ cp build/toradex-aquila-imx95/tcm/oei-m33-tcm.bin $(srctree)
+
+The Makefile will set `DDR_CONFIG` automatically based on the selected silicon
+revision.
+
+Get and Build the System Manager Image
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get System Manager from: https://git.toradex.com/cgit/imx-sm-toradex.git/
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://git.toradex.com/cgit/imx-sm-toradex.git/
+    $ cd imx-sm-toradex
+    $ make config=aquila-imx95 all
+    $ cp build/aquila-imx95/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.12
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ unset LDFLAGS
+    $ unset AS
+    $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
+    $ cd imx-atf
+    $ make PLAT=imx95 bl31
+    $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ make aquila-imx95_defconfig
+    $ make
+
+Flash to eMMC
+-------------
+
+.. code-block:: console
+
+    > tftpboot ${loadaddr} flash.bin
+    > setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200
+    > mmc dev 0 1 && mmc write ${loadaddr} 0x0 ${blkcnt}
+
+As a convenience, instead of the last two commands, one may also use the update
+U-Boot wrapper:
+
+.. code-block:: console
+
+    > run update_uboot
+
+Boot
+----
+
+Boot sequence is:
+
+* SPL ---> ATF (TF-A) ---> U-Boot proper
+
+Output:
+
+.. code-block:: console
+
+    U-Boot SPL 2026.07-rc3-00300-ge16706b72e14 (Jun 11 2026 - 13:07:49 +0200)
+    SYS Boot reason: por, origin: -1, errid: -1
+    WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
+    Trying to boot from MMC1
+    Load image from MMC/SD 0xd2800
+    NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.1-dirty
+    NOTICE:  BL31: Built : 06:40:36, Jul  7 2025
+
+
+    U-Boot 2026.07-rc3-00300-ge16706b72e14 (Jun 11 2026 - 13:07:49 +0200)
+
+    CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz - invalid sensor data
+    DRAM:  7.8 GiB
+    Core:  321 devices, 30 uclasses, devicetree: separate
+    WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
+    MMC:   FSL_SDHC: 0, FSL_SDHC: 1
+    Loading Environment from MMC... Reading from MMC(0)... OK
+    In:    serial@44380000
+    Out:   serial@44380000
+    Err:   serial@44380000
+    Model: Toradex 0098 Aquila iMX95 Hexa 8GB WB IT V1.0A
+    Serial#: 12594391
+
+    BuildInfo:
+      - ELE firmware version 2.0.2-c110ba4b
+
+    Net:   WARNING: no MAC address assigned for MAC0
+    imx_get_mac_from_fuse: fuse read err: 0
+    eth0: enetc-0 [PRIME]
+    Hit any key to stop autoboot: 0
+    Aquila iMX95 #
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 2a45bde6991..c5955ea1ad8 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -8,6 +8,7 @@ Toradex
 
    apalis-imx8
    aquila-am69
+   aquila-imx95
    colibri_imx7
    colibri-imx8x
    smarc-imx8mp
diff --git a/include/configs/aquila-imx95.h b/include/configs/aquila-imx95.h
new file mode 100644
index 00000000000..07d09d138cb
--- /dev/null
+++ b/include/configs/aquila-imx95.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Toradex */
+
+#ifndef __AQUILA_IMX95_H
+#define __AQUILA_IMX95_H
+
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+/* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above */
+#define SZ_6G	_AC(0x180000000, ULL)
+
+/* first 256MB reserved for firmware */
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	SZ_2M
+
+#define CFG_SYS_SDRAM_BASE	0x90000000
+#define PHYS_SDRAM		0x90000000
+#define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
+#define PHYS_SDRAM_2_SIZE	SZ_6G
+
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+
+#endif

---
base-commit: 953653936cfc9e12f52df1165080fa6c7cbae1bc
change-id: 20260611-aquila-imx95-b4f16b67af93

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

