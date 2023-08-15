Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C956C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 22:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6305F869A4;
	Wed, 16 Aug 2023 00:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583898697B; Wed, 16 Aug 2023 00:01:26 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D30A8699C
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 00:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qW26I-0085bD-1X; Tue, 15 Aug 2023 22:01:18 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/6] board: gateworks: venice: add imx8mp-gw72xx-2x support
Date: Tue, 15 Aug 2023 15:01:12 -0700
Message-Id: <20230815220115.2000851-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815220115.2000851-1-tharvey@gateworks.com>
References: <20230815220115.2000851-1-tharvey@gateworks.com>
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

The Gateworks imx8mp-venice-gw72xx-2x consists of a SOM + baseboard.

The GW702x SOM contains the following:
 - i.MX8M Plus SoC
 - LPDDR4 memory
 - eMMC Boot device
 - Gateworks System Controller (GSC) with integrated EEPROM, button
   controller, and ADC's
 - PMIC
 - SOM connector providing:
  - eQoS GbE MII
  - 1x SPI
  - 2x I2C
  - 4x UART
  - 2x USB 3.0
  - 1x PCI
  - 1x SDIO (4-bit 3.3V)
  - 1x SDIO (4-bit 3.3V/1.8V)
  - GPIO

The GW72xx Baseboard contains the following:
 - 1x RJ45 GbE (eQoS from SOM)
 - 1x RJ45 GbE (PCI)
 - off-board I/O connector with MIPI-CSI (3-lane), MIPI-DSI (4-lane),
 - off-board I/O connector with RS232/RS485
 - off-board I/O connector with SPI
 - off-board I/O connector with I2C, UART, and GPIO
   I2C, I2S and GPIO
 - microSD (1.8V/3.3V)
 - GPS
 - Accelerometer
 - EERPOM
 - USB 3.0 Hub
 - Front Panel bi-color LED
 - re-chargeable battery (for RTC)
 - PCIe clock generator
 - PCIe switch
 - 1x USB Type-A host socket with USB 3.0 support
 - 1x USB OTG with USB 2.0 support
 - 1x MiniPCIe socket with PCI and USB 2.0
 - 1x MiniPCIe socket with SIM, PCI/USB 3.0 (mux), and USB 2.0
 - Wide range DC input supply

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi   |  89 +++++
 arch/arm/dts/imx8mp-venice-gw72xx-2x.dts      |  19 +
 arch/arm/dts/imx8mp-venice-gw72xx.dtsi        | 371 ++++++++++++++++++
 configs/imx8mp_venice_defconfig               |   2 +-
 5 files changed, 481 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx-2x.dts
 create mode 100644 arch/arm/dts/imx8mp-venice-gw72xx.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6a2ec7c88b88..6e8ed1255580 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1036,6 +1036,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-venice.dtb \
 	imx8mp-venice-gw71xx-2x.dtb \
+	imx8mp-venice-gw72xx-2x.dtb \
 	imx8mp-venice-gw74xx.dtb \
 	imx8mp-venice-gw7905-2x.dtb \
 	imx8mp-verdin-wifi-dev.dtb \
diff --git a/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
new file mode 100644
index 000000000000..7f2609ab5469
--- /dev/null
+++ b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Gateworks Corporation
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
+		line-name = "dio0";
+	};
+
+	pci_usb_sel {
+		gpio-hog;
+		output-low;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		line-name = "pci_usb_sel";
+	};
+
+	mipi_gpio4 {
+		gpio-hog;
+		input;
+		gpios = <17 GPIO_ACTIVE_HIGH>;
+		line-name = "mipi_gpio4";
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
+	mipi_gpio1 {
+		gpio-hog;
+		input;
+		gpios = <24 GPIO_ACTIVE_HIGH>;
+		line-name = "mipi_gpio1";
+	};
+
+	mipi_gpio3 {
+		gpio-hog;
+		input;
+		gpios = <25 GPIO_ACTIVE_HIGH>;
+		line-name = "mipi_gpio3";
+	};
+
+	mipi_gpio2 {
+		gpio-hog;
+		input;
+		gpios = <26 GPIO_ACTIVE_HIGH>;
+		line-name = "mipi_gpio2";
+	};
+
+	rs485_hd {
+		gpio-hog;
+		output-low;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		line-name = "rs485_hd";
+	};
+
+	pci_wdis {
+		gpio-hog;
+		output-high;
+		gpios = <28 GPIO_ACTIVE_HIGH>;
+		line-name = "pci_wdis#";
+	};
+};
+
+/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
diff --git a/arch/arm/dts/imx8mp-venice-gw72xx-2x.dts b/arch/arm/dts/imx8mp-venice-gw72xx-2x.dts
new file mode 100644
index 000000000000..255e36f66b00
--- /dev/null
+++ b/arch/arm/dts/imx8mp-venice-gw72xx-2x.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+#include "imx8mp-venice-gw702x.dtsi"
+#include "imx8mp-venice-gw72xx.dtsi"
+
+/ {
+	model = "Gateworks Venice GW72xx-2x i.MX8MP Development Kit";
+	compatible = "gateworks,imx8mp-gw72xx-2x", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
diff --git a/arch/arm/dts/imx8mp-venice-gw72xx.dtsi b/arch/arm/dts/imx8mp-venice-gw72xx.dtsi
new file mode 100644
index 000000000000..e05fdecdaf4f
--- /dev/null
+++ b/arch/arm/dts/imx8mp-venice-gw72xx.dtsi
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+/ {
+	led-controller {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_usb1_vbus: regulator-usb1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_vbus";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb2_vbus: regulator-usb2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb2_vbus";
+		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_SD";
+		enable-active-high;
+		gpio = <&gpio2 19 0>; /* SD2_RESET */
+		off-on-delay-us = <12000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		startup-delay-us = <100>;
+	};
+};
+
+/* off-board header */
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"dio1", "", "", "dio0",
+		"", "", "pci_usb_sel", "",
+		"", "", "", "",
+		"", "", "rs485_en", "rs485_term",
+		"", "", "", "rs485_half",
+		"pci_wdis#", "", "", "";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	accelerometer@19 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		st,drdy-int-pin = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT1";
+	};
+};
+
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* GPS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* off-board header */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+/* RS232 */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+/* USB1 - OTG */
+&usb3_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	fsl,over-current-active-low;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	/* dual role is implemented but not a full featured OTG */
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	status = "okay";
+
+	connector {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbcon1>;
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		label = "otg";
+		id-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* USB2 - USB3.0 Hub */
+&usb3_1 {
+	fsl,permanently-attached;
+	fsl,disable-port-power-control;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* microSD */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD6__GPIO4_IO08	0x40000146 /* DIO1 */
+			MX8MP_IOMUXC_SAI1_TXC__GPIO4_IO11	0x40000146 /* DIO0 */
+			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14	0x40000106 /* PCIE_USBSEL */
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27	0x40000106 /* RS485_HALF */
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x40000106 /* RS485_EN */
+			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23	0x40000106 /* RS485_TERM */
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x40000106 /* PCIE_WDIS# */
+		>;
+	};
+
+	pinctrl_accel: accelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x150	/* IRQ */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0x6	/* LEDG */
+			MX8MP_IOMUXC_SAI1_RXD3__GPIO4_IO05	0x6	/* LEDR */
+		>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x106
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x146
+		>;
+	};
+
+	pinctrl_reg_usb1_en: regusb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* USB1_EN */
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC	0x140 /* USB1_FLT# */
+		>;
+	};
+
+	pinctrl_usbcon1: usbcon1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x140 /* USB1_ID */
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD0__GPIO4_IO12	0x146 /* USBHUB_RST# */
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x140
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0x140
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0x140
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x140
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX	0x140
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+		>;
+	};
+
+	pinctrl_usdhc2_vmmc: usdhc2-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__USDHC2_RESET_B	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x1c4
+		>;
+	};
+};
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index e981bb844e10..151de3140421 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -77,7 +77,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="imx8mp-venice imx8mp-venice-gw71xx-2x imx8mp-venice-gw74xx imx8mp-venice-gw7905-2x"
+CONFIG_OF_LIST="imx8mp-venice imx8mp-venice-gw71xx-2x imx8mp-venice-gw72xx-2x imx8mp-venice-gw74xx imx8mp-venice-gw7905-2x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
-- 
2.25.1

