Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03ABC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A3A884BC;
	Tue, 28 May 2024 13:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZM2LhzId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359AE8848A; Tue, 28 May 2024 13:25:09 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F38B8848A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716895503; x=1719487503;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FkF32S43Fc0Qi8zUP8GdrMflu65aJp21weqKajNbBD0=;
 b=ZM2LhzIdYDxI3ZyKi2km6uhqZ8KY/FLIoUlahkRC0mPoZjHqDpJe49scDXsqnawm
 mh/oiQ2DNVjmOJI8Hcdsy4wtuwaVd4jKlXWO9nXMVwjM1TU2G17jlrFAZ6e39fsa
 o2t7fplqnA74emciRexj03IpejiqwW/xW4LZ0AyBvdU=;
X-AuditID: ac14000a-03e52700000021bc-7e-6655bf0fc17a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 62.F7.08636.F0FB5566;
 Tue, 28 May 2024 13:25:03 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 13:25:03 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 28 May 2024 13:24:59 +0200
Subject: [PATCH 1/2] arm: imx8mm-phycore: move to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-phytec_imx8_of_upstream-v1-1-c884c1ddca5f@phytec.de>
References: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
In-Reply-To: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
To: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.13.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR5d/f2iawaJ1whYPr/pbtJ/ysXi7
 t5PdYsrj9ewW3e/UHVg95s06weKxc9Zddo+zd3YwevR3t7B6bHy3gymANYrLJiU1J7MstUjf
 LoEro+GpUsGrzUwVi/s+MzYw3vnJ2MXIySEhYCKx6PhZ1i5GLg4hgSVMEn+a17NAOA8ZJaZP
 a2UGqWITUJF4/OIeK4jNIqAqMe3QW7BuYQFbiWvXfrKB2LwCghInZz4BaubgYBbQlFi/Sx8k
 zCwgL7H97RxmiBIviWsHjoONEQKyu/cdBYtzCnhLfDn3lB1kr4jANKC9u+azQjRHSFy7uYQd
 4lJhifMLprBBNMtKvDjfCxWXl5h27jUzhB0qsfXLdqYJjEKzkJw0C+GkWUhOWsDIvIpRKDcz
 OTu1KDNbryCjsiQ1WS8ldRMjKPBFGLh2MPbN8TjEyMTBeIhRgoNZSYT3zKTQNCHelMTKqtSi
 /Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MBgvrz3wqdRVT5XxQGn5b
 sVFzuc/cF2dKl4epyH7YIPWN9dLF8w9vui1LaL7jv2vr88dy0m+3LGzYXrVCMlyWz1Dv83xl
 7fXSzSozSy27ut1UtpTHG9xoOa9qcaAi8JPARMcI/aeLnW7Mze2tsuzMCThktzCu4cWzss9T
 uN8yCgrFaNi+5JqkxFKckWioxVxUnAgA9UL7EGoCAAA=
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

The PHYCORE_IMX8MM is used by the phyBOARD-Polis and the
phyGATE-Tauri-L. Migrate both boards to OF_UPSTREAM. Linux kernel device
trees for both boards can be used as is, corresponding U-Boot device
tree files are removed. U-Boot tweaks are kept unchanged.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/Makefile                      |   2 -
 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts | 460 ---------------------------
 arch/arm/dts/imx8mm-phycore-som.dtsi       | 440 --------------------------
 arch/arm/dts/imx8mm-phygate-tauri-l.dts    | 489 -----------------------------
 arch/arm/mach-imx/imx8m/Kconfig            |   1 +
 board/phytec/phycore_imx8mm/MAINTAINERS    |   3 -
 configs/imx8mm-phygate-tauri-l_defconfig   |   2 +-
 configs/phycore-imx8mm_defconfig           |   2 +-
 8 files changed, 3 insertions(+), 1396 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index c9f1b25ad64..480f8ff569d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1016,8 +1016,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-kontron-bl-osm-s.dtb \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
-	imx8mm-phyboard-polis-rdk.dtb \
-	imx8mm-phygate-tauri-l.dtb \
 	imx8mn-bsh-smm-s2.dtb \
 	imx8mn-bsh-smm-s2pro.dtb \
 	imx8mq-cm.dtb \
diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk.dts b/arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
deleted file mode 100644
index 03e7679217b..00000000000
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
+++ /dev/null
@@ -1,460 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mm-phycore-som.dtsi"
-
-/ {
-	model = "PHYTEC phyBOARD-Polis-i.MX8MM RDK";
-	compatible = "phytec,imx8mm-phyboard-polis-rdk",
-		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	bt_osc_32k: bt-lp-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-		clock-output-names = "bt_osc_32k";
-		#clock-cells = <0>;
-	};
-
-	can_osc_40m: can-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <40000000>;
-		clock-output-names = "can_osc_40m";
-		#clock-cells = <0>;
-	};
-
-	fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <0     0
-				      13000 1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_fan>;
-		#cooling-cells = <2>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-
-		led-0 {
-			color = <LED_COLOR_ID_RED>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc2";
-		};
-
-		led-1 {
-			color = <LED_COLOR_ID_BLUE>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_CPU;
-			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	usdhc1_pwrseq: pwr-seq {
-		compatible = "mmc-pwrseq-simple";
-		post-power-on-delay-ms = <100>;
-		power-off-delay-us = <60>;
-		reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	};
-
-	reg_can_en: regulator-can-en {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_can_en>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "CAN_EN";
-		startup-delay-us = <20>;
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbotg1pwrgrp>;
-		regulator-name = "usb_otg1_vbus";
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		off-on-delay-us = <20000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-	};
-
-	reg_vcc_3v3: regulator-vcc-3v3 {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VCC_3V3";
-	};
-};
-
-/* SPI - CAN MCP251XFD */
-&ecspi1 {
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	status = "okay";
-
-	can0: can@0 {
-		compatible = "microchip,mcp251xfd";
-		clocks = <&can_osc_40m>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_can_int>;
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-		xceiver-supply = <&reg_can_en>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names = "nINT_ETHPHY", "LED_RED", "WDOG_INT", "X_RTC_INT",
-		"", "", "", "RESET_ETHPHY",
-		"CAN_nINT", "CAN_EN", "nENABLE_FLATLINK", "",
-		"USB_OTG_VBUS_EN", "", "LED_GREEN", "LED_BLUE";
-};
-
-&gpio2 {
-	gpio-line-names = "", "", "", "",
-		"", "", "BT_REG_ON", "WL_REG_ON",
-		"BT_DEV_WAKE", "BT_HOST_WAKE", "", "",
-		"X_SD2_CD_B", "", "", "",
-		"", "", "", "SD2_RESET_B";
-};
-
-&gpio4 {
-	gpio-line-names = "", "", "", "",
-		"", "", "", "",
-		"FAN", "miniPCIe_nPERST", "", "",
-		"COEX1", "COEX2";
-};
-
-&gpio5 {
-	gpio-line-names = "", "", "", "",
-		"", "", "", "",
-		"", "ECSPI1_SS0";
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-};
-
-/* PCIe */
-&pcie0 {
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	assigned-clock-rates = <10000000>, <250000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio4 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pcie_phy {
-	clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
-	fsl,clkreq-unsupported;
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
-	fsl,tx-deemph-gen1 = <0x2d>;
-	fsl,tx-deemph-gen2 = <0xf>;
-	status = "okay";
-};
-
-&rv3028 {
-	trickle-resistor-ohms = <3000>;
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-/* UART - RS232/RS485 */
-&uart1 {
-	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-/* UART - Sterling-LWB Bluetooth */
-&uart2 {
-	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
-	fsl,dte-mode;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2_bt>;
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		clocks = <&bt_osc_32k>;
-		clock-names = "lpo";
-		device-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
-		interrupt-names = "host-wakeup";
-		interrupt-parent = <&gpio2>;
-		interrupts = <9 IRQ_TYPE_EDGE_BOTH>;
-		max-speed = <2000000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bt>;
-		shutdown-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
-		vddio-supply = <&reg_vcc_3v3>;
-	};
-};
-
-/* UART - console */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-/* USB */
-&usbotg1 {
-	adp-disable;
-	dr_mode = "otg";
-	over-current-active-low;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	srp-disable;
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	status = "okay";
-};
-
-/* SDIO - Sterling-LWB Wifi */
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC1>;
-	assigned-clock-rates = <200000000>;
-	bus-width = <4>;
-	mmc-pwrseq = <&usdhc1_pwrseq>;
-	non-removable;
-	no-1-8-v;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-	};
-};
-
-/* SD-Card */
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	vqmmc-supply = <&reg_nvcc_sd2>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_bt: btgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x00
-			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x00
-			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9	0x00
-		>;
-	};
-
-	pinctrl_can_en: can-engrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x00
-		>;
-	};
-
-	pinctrl_can_int: can-intgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x00
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x80
-			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x80
-			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x80
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x00
-		>;
-	};
-
-	pinctrl_fan: fan0grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8	0x16
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c2
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_leds: leds1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x16
-			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x16
-			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x16
-		>;
-	};
-
-	pinctrl_pcie: pciegrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9	0x00
-			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12	0x12
-			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19	0x12
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x40
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX	0x00
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B	0x00
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX	0x00
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B	0x00
-		>;
-	};
-
-	pinctrl_uart2_bt: uart2btgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DTE_RTS_B	0x00
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DTE_CTS_B	0x00
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX	0x00
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DTE_TX	0x00
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x40
-			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x40
-		>;
-	};
-
-	pinctrl_usbotg1pwrgrp: usbotg1pwrgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x182
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0xc6
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0xc6
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0xc6
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0xc6
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0xc6
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x40
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x192
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d2
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d2
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d2
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d2
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d2
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-		>;
-	};
-
-	pinctrl_wlan: wlangrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_DATA5_GPIO2_IO7	0x00
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mm-phycore-som.dtsi b/arch/arm/dts/imx8mm-phycore-som.dtsi
deleted file mode 100644
index 92616bc4f71..00000000000
--- a/arch/arm/dts/imx8mm-phycore-som.dtsi
+++ /dev/null
@@ -1,440 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
- */
-
-#include "imx8mm.dtsi"
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	model = "PHYTEC phyCORE-i.MX8MM";
-	compatible = "phytec,imx8mm-phycore-som", "fsl,imx8mm";
-
-	aliases {
-		rtc0 = &rv3028;
-		rtc1 = &snvs_rtc;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
-	};
-
-	reg_vdd_3v3_s: regulator-vdd-3v3-s {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VDD_3V3_S";
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&reg_vdd_arm>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_vdd_arm>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_vdd_arm>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_vdd_arm>;
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25000000 {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-750000000 {
-			opp-hz = /bits/ 64 <750000000>;
-		};
-	};
-};
-
-/* Ethernet */
-&fec1 {
-	fsl,magic-packet;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			enet-phy-lane-no-swap;
-			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			reg = <0>;
-			reset-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-		};
-	};
-};
-
-/* SPI Flash */
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi0>;
-	status = "okay";
-
-	som_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <80000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <1>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names = "nINT_ETHPHY", "", "WDOG_INT", "X_RTC_INT",
-		"", "", "", "RESET_ETHPHY",
-		"", "", "nENABLE_FLATLINK";
-};
-
-/* I2C1 */
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default","gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	pmic@8 {
-		compatible = "nxp,pf8121a";
-		reg = <0x08>;
-
-		regulators {
-			reg_nvcc_sd1: ldo1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <3300000>;
-				regulator-name = "NVCC_SD1 (LDO1)";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_nvcc_sd2: ldo2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "NVCC_SD2 (LDO2)";
-				vselect-en;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_vcc_enet: ldo3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <2500000>;
-				regulator-min-microvolt = <1500000>;
-				regulator-name = "VCC_ENET_2V5 (LDO3)";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_vdda_1v8: ldo4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microvolt = <1500000>;
-				regulator-name = "VDDA_1V8 (LDO4)";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-min-microvolt = <1500000>;
-					regulator-suspend-max-microvolt = <1500000>;
-				};
-			};
-
-			reg_soc_vdda_phy: buck1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <900000>;
-				regulator-min-microvolt = <400000>;
-				regulator-name = "VDD_SOC_VDDA_PHY_0P8 (BUCK1)";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-min-microvolt = <400000>;
-					regulator-suspend-max-microvolt = <400000>;
-				};
-			};
-
-			reg_vdd_gpu_dram: buck2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1000000>;
-				regulator-min-microvolt = <1000000>;
-				regulator-name = "VDD_GPU_DRAM (BUCK2)";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-max-microvolt = <1000000>;
-					regulator-suspend-min-microvolt = <1000000>;
-				};
-			};
-
-			reg_vdd_gpu: buck3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1000000>;
-				regulator-min-microvolt = <400000>;
-				regulator-name = "VDD_VPU (BUCK3)";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_vdd_mipi: buck4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1050000>;
-				regulator-min-microvolt = <900000>;
-				regulator-name = "VDD_MIPI_0P9 (BUCK4)";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_vdd_arm: buck5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1050000>;
-				regulator-min-microvolt = <400000>;
-				regulator-name = "VDD_ARM (BUCK5)";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			reg_vdd_1v8: buck6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "VDD_1V8 (BUCK6)";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-max-microvolt = <1800000>;
-					regulator-suspend-min-microvolt = <1800000>;
-				};
-			};
-
-			reg_nvcc_dram: buck7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1100000>;
-				regulator-min-microvolt = <1100000>;
-				regulator-name = "NVCC_DRAM_1P1V (BUCK7)";
-			};
-
-			reg_vsnvs: vsnvs {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1800000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "NVCC_SNVS_1P8 (VSNVS)";
-			};
-		};
-	};
-
-	sn65dsi83: bridge@2d {
-		compatible = "ti,sn65dsi83";
-		enable-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sn65dsi83>;
-		reg = <0x2d>;
-		status = "disabled";
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c32";
-		pagesize = <32>;
-		reg = <0x51>;
-		vcc-supply = <&reg_vdd_3v3_s>;
-	};
-
-	rv3028: rtc@52 {
-		compatible = "microcrystal,rv3028";
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
-		reg = <0x52>;
-	};
-};
-
-/* EMMC */
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
-	assigned-clock-rates = <400000000>;
-	bus-width = <8>;
-	keep-power-in-suspend;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	non-removable;
-	status = "okay";
-};
-
-/* Watchdog */
-&wdog1 {
-	fsl,ext-reset-output;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x2
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x2
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x90
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x90
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x90
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x90
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x90
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x90
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x16
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x16
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x16
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x16
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x16
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x16
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x10
-		>;
-	};
-
-	pinctrl_flexspi0: flexspi0grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x1c2
-			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82
-			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82
-			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82
-			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82
-			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c0
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c0
-		>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x1e0
-			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x1e0
-		>;
-	};
-
-	pinctrl_rtc: rtcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x1c0
-		>;
-	};
-
-	pinctrl_sn65dsi83: sn65dsi83grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x0
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x26
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mm-phygate-tauri-l.dts b/arch/arm/dts/imx8mm-phygate-tauri-l.dts
deleted file mode 100644
index 968f475b9a9..00000000000
--- a/arch/arm/dts/imx8mm-phygate-tauri-l.dts
+++ /dev/null
@@ -1,489 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2023 PHYTEC Messtechnik GmbH
- */
-
-/dts-v1/;
-
-#include <dt-bindings/input/linux-event-codes.h>
-#include <dt-bindings/leds/common.h>
-#include "imx8mm-phycore-som.dtsi"
-
-/ {
-	model = "PHYTEC phyGATE-Tauri-L-iMX8MM";
-	compatible = "phytec,imx8mm-phygate-tauri-l",
-		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	can_osc_40m: clock-can {
-		compatible = "fixed-clock";
-		clock-frequency = <40000000>;
-		clock-output-names = "can_osc_40m";
-		#clock-cells = <0>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-
-		key {
-			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			label = "KEY-A";
-			linux,code = <KEY_A>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-
-		led-1 {
-			color = <LED_COLOR_ID_RED>;
-			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "none";
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_YELLOW>;
-			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "none";
-		};
-	};
-
-	usdhc1_pwrseq: pwr-seq {
-		compatible = "mmc-pwrseq-simple";
-		post-power-on-delay-ms = <100>;
-		power-off-delay-us = <60>;
-		reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	};
-
-	reg_usb_hub_vbus: regulator-hub-otg1 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbhubpwr>;
-		regulator-name = "usb_hub_vbus";
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbotg1pwr>;
-		regulator-name = "usb_otg1_vbus";
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		off-on-delay-us = <20000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-	};
-};
-
-&ecspi1 {
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>,
-		   <&gpio5 13 GPIO_ACTIVE_LOW>,
-		   <&gpio5 2 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	/* CAN MCP251XFD */
-	can0: can@0 {
-		compatible = "microchip,mcp251xfd";
-		reg = <0>;
-		clocks = <&can_osc_40m>;
-		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_can_int>;
-		spi-max-frequency = <10000000>;
-	};
-
-	tpm: tpm@1 {
-		compatible = "tcg,tpm_tis-spi";
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tpm>;
-		reg = <1>;
-		spi-max-frequency = <38000000>;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	temp_sense0: temperature-sensor@49 {
-		compatible = "ti,tmp102";
-		reg = <0x49>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tempsense>;
-		#thermal-sensor-cells = <1>;
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	pinctrl-1 = <&pinctrl_i2c4_gpio>;
-	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-/* PCIe */
-&pcie0 {
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_PHY>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_100M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	assigned-clock-rates = <10000000>, <100000000>, <250000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3>;
-	status = "okay";
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
-
-/* RTC */
-&rv3028 {
-	trickle-resistor-ohms = <3000>;
-};
-
-&uart1 {
-	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* UART2 - RS232 */
-&uart2 {
-	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-/* UART - console */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-/* USB */
-&usbotg1 {
-	adp-disable;
-	dr_mode = "otg";
-	over-current-active-low;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1>;
-	srp-disable;
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	disable-over-current;
-	dr_mode = "host";
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	vbus-supply = <&reg_usb_hub_vbus>;
-	status = "okay";
-};
-
-/* SD-Card */
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	vqmmc-supply = <&reg_nvcc_sd2>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_can_int: can-intgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x00
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x82
-			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x82
-			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x82
-		>;
-	};
-
-	pinctrl_ecspi1_cs: ecspi1csgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x00
-			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x00
-			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x00
-		>;
-	};
-
-	pinctrl_gpiokeys: keygrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x00
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL	0x400001c2
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA	0x400001c2
-		>;
-	};
-
-	pinctrl_i2c2_gpio: i2c2gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x1e0
-			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x1e0
-		>;
-	};
-
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL	0x400001c2
-			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA	0x400001c2
-		>;
-	};
-
-	pinctrl_i2c3_gpio: i2c3gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x1e0
-			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x1e0
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL	0x400001c2
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA	0x400001c2
-		>;
-	};
-
-	pinctrl_i2c4_gpio: i2c4gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x1e0
-			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x1e0
-		>;
-	};
-
-	pinctrl_leds: leds1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30	0x00
-			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x00
-		>;
-	};
-
-	pinctrl_pcie: pciegrp {
-		fsl,pins = <
-			/* COEX2 */
-			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x00
-			/* COEX1 */
-			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12	0x12
-		>;
-	};
-
-	pinctrl_pwm1: pwm1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x40
-		>;
-	};
-
-	pinctrl_pwm3: pwm3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT		0x40
-		>;
-	};
-
-	pinctrl_pwm4: pwm4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO15_PWM4_OUT	0x40
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19     0x40
-		>;
-	};
-
-	pinctrl_tempsense: tempsensegrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x00
-		>;
-	};
-
-	pinctrl_tpm: tpmgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11	0x140
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x00
-			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x00
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x00
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x00
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
-			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usbhubpwr: usbhubpwrgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x00
-		>;
-	};
-
-	pinctrl_usbotg1pwr: usbotg1pwrgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00
-		>;
-	};
-
-	pinctrl_usbotg1: usbotg1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x80
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x182
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0xc6
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0xc6
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0xc6
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0xc6
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0xc6
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x40
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x192
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d2
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d2
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d2
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d2
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d2
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 23d9217fcc2..f81be42d5b0 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -296,6 +296,7 @@ config TARGET_PHYCORE_IMX8MM
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_PHYCORE_IMX8MP
 	bool "PHYTEC PHYCORE i.MX8MP"
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index e46e3691bac..58c5e2d0af9 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -2,10 +2,7 @@ phyCORE-i.MX8M Mini
 M:      Teresa Remmet <t.remmet@phytec.de>
 W:      https://www.phytec.eu/product-eu/system-on-modules/phycore-imx-8m-mini-nano/
 S:      Maintained
-F:      arch/arm/dts/imx8mm-phyboard-polis-rdk.dts
-F:      arch/arm/dts/imx8mm-phycore-som.dtsi
 F:      arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
-F:	arch/arm/dts/imx8mm-phygate-tauri-l.dts
 F:	arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi
 F:      board/phytec/phycore_imx8mm/
 F:	configs/imx8mm-phygate-tauri-l_defconfig
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index cb292dde4cb..41765f1ddc5 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-phygate-tauri-l"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phygate-tauri-l"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 22d419024f6..f9fd7255df7 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-phyboard-polis-rdk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phyboard-polis-rdk"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.34.1

