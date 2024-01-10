Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3BEC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487FD87A99;
	Wed, 10 Jan 2024 13:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="g+f1DyE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524BF878A5; Wed, 10 Jan 2024 13:58:09 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC4787906
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704891486; x=1707483486;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9daKHC5Ey4x2IECcHAFtGd5gI6fdA+DO14x+hTJAK4=;
 b=g+f1DyE5STq5SmttN9tKCbbedTKibmYNmiODHit8q+UDeJmd3RXIB0iULltUl8Gn
 CGfXxfHZHjNvJoC5iqR3Oe9HNebjleablfWF54HxP2Zmyn9el3m0RNObCCRFg6O1
 m8S2zMnHWwr5XM14pY4hoVqlgT5aAi+iTlcQdArikek=;
X-AuditID: ac14000a-fbefe7000000290d-b8-659e945e559b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 89.45.10509.E549E956;
 Wed, 10 Jan 2024 13:58:06 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jan
 2024 13:58:06 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 10 Jan 2024 13:57:41 +0100
Subject: [PATCH 1/2] Add support for phyGATE-Tauri-L-iMX8MM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-1-1ba2d9220da6@phytec.de>
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-0-1ba2d9220da6@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-0-1ba2d9220da6@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRpKBRzduyrxUg6bDJhYPr/pbvN3byW4x
 5fF6dovud+oOLB47Z91l9zh7ZwejR393C6vHxnc7mAJYorhsUlJzMstSi/TtErgyVt1qZSq4
 OYGx4tPdA4wNjJMquhg5OSQETCRmnzjI0sXIxSEksJhJ4tj526wgCSGBh4wSh84rgdhsAioS
 j1/cA4uzCKhKHLzXAWRzcAgLWEu8avABCfMKCEqcnPmEBSTMLKApsX6XPkiYWUBeYvvbOcwQ
 JRESrf8vskFMj5A4dvoYmM0pECmx7PQtFhBbRKBMYltvP9SYCIk5j8wgrhSWaF90iwmiVVbi
 xfledoi4vMS0c6+ZIexQia1ftjNNYBSaheSgWQgHzUJy0AJG5lWMQrmZydmpRZnZegUZlSWp
 yXopqZsYQeEtwsC1g7FvjschRiYOxkOMEhzMSiK8Cp/npArxpiRWVqUW5ccXleakFh9ilOZg
 URLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpg7D4h1skensW3Wr7Rsc//XPOiM22S0inin//W
 sr0QvXxjItfX+ur8CyszJlnv+7JU24N72kmRkkuKRd7V5suMme6E7krhFV+j7e50ulDz7NQ9
 ByXTZh5t+JD2UEDcYV51V+l5GY7cQ7xfHphc3bD6/53kA/kvXnJJsp3f4FEQqqhX2VRY3DVf
 iaU4I9FQi7moOBEAqvr6Dl0CAAA=
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

phyGATE-Tauri-L-iMX8MM is a Gateway based on the phycore-imx8mm SoM.
As a result, all the board code of the phycore-imx8mm is used.
Device tree synced with kernel v6.7.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/Makefile                           |   1 +
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi |  70 ++++
 arch/arm/dts/imx8mm-phygate-tauri-l.dts         | 489 ++++++++++++++++++++++++
 board/phytec/phycore_imx8mm/MAINTAINERS         |   3 +
 configs/imx8mm-phygate-tauri-l_defconfig        | 117 ++++++
 5 files changed, 680 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 773c2546131..d456a524b36 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1076,6 +1076,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mm-phyboard-polis-rdk.dtb \
+	imx8mm-phygate-tauri-l.dtb \
 	imx8mm-venice.dtb \
 	imx8mm-venice-gw71xx-0x.dtb \
 	imx8mm-venice-gw72xx-0x.dtb \
diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
new file mode 100644
index 00000000000..f59f119374f
--- /dev/null
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ */
+
+#include "imx8mm-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
+&pinctrl_uart3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_wdog {
+	bootph-pre-ram;
+};
+
+&gpio1 {
+	bootph-pre-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+};
+
+&uart3 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&usdhc3 {
+	bootph-pre-ram;
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l.dts b/arch/arm/dts/imx8mm-phygate-tauri-l.dts
new file mode 100644
index 00000000000..968f475b9a9
--- /dev/null
+++ b/arch/arm/dts/imx8mm-phygate-tauri-l.dts
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
+#include "imx8mm-phycore-som.dtsi"
+
+/ {
+	model = "PHYTEC phyGATE-Tauri-L-iMX8MM";
+	compatible = "phytec,imx8mm-phygate-tauri-l",
+		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	can_osc_40m: clock-can {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		clock-output-names = "can_osc_40m";
+		#clock-cells = <0>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		key {
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			label = "KEY-A";
+			linux,code = <KEY_A>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-1 {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+	};
+
+	usdhc1_pwrseq: pwr-seq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <60>;
+		reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_usb_hub_vbus: regulator-hub-otg1 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhubpwr>;
+		regulator-name = "usb_hub_vbus";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1pwr>;
+		regulator-name = "usb_otg1_vbus";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <20000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+	};
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>,
+		   <&gpio5 13 GPIO_ACTIVE_LOW>,
+		   <&gpio5 2 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	/* CAN MCP251XFD */
+	can0: can@0 {
+		compatible = "microchip,mcp251xfd";
+		reg = <0>;
+		clocks = <&can_osc_40m>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can_int>;
+		spi-max-frequency = <10000000>;
+	};
+
+	tpm: tpm@1 {
+		compatible = "tcg,tpm_tis-spi";
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm>;
+		reg = <1>;
+		spi-max-frequency = <38000000>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	temp_sense0: temperature-sensor@49 {
+		compatible = "ti,tmp102";
+		reg = <0x49>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tempsense>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* PCIe */
+&pcie0 {
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_PHY>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_100M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	assigned-clock-rates = <10000000>, <100000000>, <250000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+/* RTC */
+&rv3028 {
+	trickle-resistor-ohms = <3000>;
+};
+
+&uart1 {
+	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* UART2 - RS232 */
+&uart2 {
+	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* UART - console */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+/* USB */
+&usbotg1 {
+	adp-disable;
+	dr_mode = "otg";
+	over-current-active-low;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	srp-disable;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	vbus-supply = <&reg_usb_hub_vbus>;
+	status = "okay";
+};
+
+/* SD-Card */
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_nvcc_sd2>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_can_int: can-intgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x00
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x82
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x82
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x82
+		>;
+	};
+
+	pinctrl_ecspi1_cs: ecspi1csgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x00
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x00
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x00
+		>;
+	};
+
+	pinctrl_gpiokeys: keygrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x00
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x1e0
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x1e0
+		>;
+	};
+
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x1e0
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x1e0
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x1e0
+			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x1e0
+		>;
+	};
+
+	pinctrl_leds: leds1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30	0x00
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x00
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			/* COEX2 */
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x00
+			/* COEX1 */
+			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12	0x12
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x40
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT		0x40
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_PWM4_OUT	0x40
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19     0x40
+		>;
+	};
+
+	pinctrl_tempsense: tempsensegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x00
+		>;
+	};
+
+	pinctrl_tpm: tpmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11	0x140
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x00
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x00
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x00
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x00
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usbhubpwr: usbhubpwrgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x00
+		>;
+	};
+
+	pinctrl_usbotg1pwr: usbotg1pwrgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x80
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x182
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0xc6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0xc6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0xc6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0xc6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0xc6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x40
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x192
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d2
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d2
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d2
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d2
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d2
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+		>;
+	};
+};
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index acffda61c04..05d48ba2472 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -5,6 +5,9 @@ S:      Maintained
 F:      arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
 F:      arch/arm/dts/imx8mm-phycore-som.dtsi
 F:      arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+F:	arch/arm/dts/imx8mm-phygate-tauri-l.dts
+F:	arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
 F:      board/phytec/phycore_imx8mm/
+F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:      include/configs/phycore_imx8mm.h
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
new file mode 100644
index 00000000000..f1ca99fab0a
--- /dev/null
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -0,0 +1,117 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x3C0000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8mm-phygate-tauri-l"
+CONFIG_SPL_TEXT_BASE=0x7E1000
+CONFIG_TARGET_PHYCORE_IMX8MM=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x920000
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x3E0000
+CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_LTO=y
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
+CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x910000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SYS_MAXARGS=64
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=4096
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x51
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_SF_DEFAULT_BUS=3
+CONFIG_PHYLIB=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

