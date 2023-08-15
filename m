Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD656C001DF
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 22:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63BA86901;
	Wed, 16 Aug 2023 00:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DD0869AB; Wed, 16 Aug 2023 00:01:28 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1529869A9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 00:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qW26J-0085bD-0x; Tue, 15 Aug 2023 22:01:19 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 5/6] board: gateworks: venice: add imx8mm-gw7905-0x support
Date: Tue, 15 Aug 2023 15:01:14 -0700
Message-Id: <20230815220115.2000851-5-tharvey@gateworks.com>
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

The Gateworks imx8mm-venice-gw7905-0x consists of a SOM + baseboard.

The GW700x SOM contains the following:
 - i.MX8M Mini SoC
 - LPDDR4 memory
 - eMMC Boot device
 - Gateworks System Controller (GSC) with integrated EEPROM, button
   controller, and ADC's
 - RGMII PHY
 - PMIC
 - SOM connector providing:
  - FEC GbE MII
  - 1x SPI
  - 2x I2C
  - 4x UART
  - 2x USB 2.0
  - 1x PCI
  - 1x SDIO (4-bit 3.3V)
  - 1x SDIO (4-bit 3.3V/1.8V)
  - GPIO

The GW7905 Baseboard contains the following:
 - GPS
 - microSD
 - off-board I/O connector with I2C, SPI, GPIO
 - EERPOM
 - PCIe clock generator
 - 1x full-length miniPCIe socket with PCI/USB3 (via mux) and USB2.0
 - 1x half-length miniPCIe socket with USB2.0 and USB3.0
 - USB 3.0 HUB
 - USB Type-C with USB PD Sink capability and peripheral support
 - USB Type-C with USB 3.0 host support

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/imx8mm-venice-gw7905-0x-u-boot.dtsi   |  58 ++++
 arch/arm/dts/imx8mm-venice-gw7905-0x.dts      |  28 ++
 arch/arm/dts/imx8mm-venice-gw7905.dtsi        | 303 ++++++++++++++++++
 configs/imx8mm_venice_defconfig               |   2 +-
 5 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mm-venice-gw7905-0x.dts
 create mode 100644 arch/arm/dts/imx8mm-venice-gw7905.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 9b29c809dfd7..7d5f3efa04cc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1011,6 +1011,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-venice-gw7902.dtb \
 	imx8mm-venice-gw7903.dtb \
 	imx8mm-venice-gw7904.dtb \
+	imx8mm-venice-gw7905-0x.dtb \
 	imx8mm-verdin-wifi-dev.dtb \
 	phycore-imx8mm.dtb \
 	imx8mn-bsh-smm-s2.dtb \
diff --git a/arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi
new file mode 100644
index 000000000000..c259026d1a8f
--- /dev/null
+++ b/arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+#include "imx8mm-venice-gw700x-u-boot.dtsi"
+
+&gpio1 {
+	app_gpioa {
+		gpio-hog;
+		input;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		line-name = "gpioa";
+	};
+
+	app_gpiob {
+		gpio-hog;
+		input;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		line-name = "gpiob";
+	};
+};
+
+&gpio4 {
+	pci_usb_sel {
+		gpio-hog;
+		output-low;
+		gpios = <3 GPIO_ACTIVE_HIGH>;
+		line-name = "pci_usb_sel";
+	};
+
+	pci_wdis {
+		gpio-hog;
+		output-high;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		line-name = "pci_wdis#";
+	};
+};
+
+&gpio5 {
+	app_gpioc {
+		gpio-hog;
+		input;
+		gpios = <4 GPIO_ACTIVE_HIGH>;
+		line-name = "gpioc";
+	};
+
+	app_gpiod {
+		gpio-hog;
+		input;
+		gpios = <5 GPIO_ACTIVE_HIGH>;
+		line-name = "gpiod";
+	};
+};
+
+/* Disable SOM interfaces not used on baseboard */
+&fec1 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx8mm-venice-gw7905-0x.dts b/arch/arm/dts/imx8mm-venice-gw7905-0x.dts
new file mode 100644
index 000000000000..914753f062cd
--- /dev/null
+++ b/arch/arm/dts/imx8mm-venice-gw7905-0x.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mm.dtsi"
+#include "imx8mm-venice-gw700x.dtsi"
+#include "imx8mm-venice-gw7905.dtsi"
+
+/ {
+	model = "Gateworks Venice GW7905-0x i.MX8MM Development Kit";
+	compatible = "gateworks,imx8mm-gw7905-0x", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
+/* Disable SOM interfaces not used on baseboard */
+&fec1 {
+	status = "disabled";
+};
+
+&usdhc1 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx8mm-venice-gw7905.dtsi b/arch/arm/dts/imx8mm-venice-gw7905.dtsi
new file mode 100644
index 000000000000..9646eb9e4928
--- /dev/null
+++ b/arch/arm/dts/imx8mm-venice-gw7905.dtsi
@@ -0,0 +1,303 @@
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
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio4 2 GPIO_ACTIVE_HIGH>;
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
+		gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb2_vbus";
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		compatible = "regulator-fixed";
+		regulator-name = "SD2_3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
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
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "gpioa", "gpiob", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "pci_usb_sel",
+		"", "", "", "pci_wdis#",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "", "",
+		"gpioc", "gpiod", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+};
+
+/* off-board header */
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
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
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
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
+/* USB1 - Type C front panel SINK port J14 */
+&usbotg1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+/* USB2 4-port USB3.0 HUB:
+ *  P1 - USBC connector (host only)
+ *  P2 - USB2 test connector
+ *  P3 - miniPCIe full card
+ *  P4 - miniPCIe half card
+ */
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb2_vbus>;
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
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000040 /* GPIOA */
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x40000040 /* GPIOB */
+			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3	0x40000106 /* PCI_USBSEL */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000106 /* PCIE_WDIS# */
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x40000040 /* GPIOD */
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x40000040 /* GPIOC */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0	0x6	/* LEDG */
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2	0x6	/* LEDR */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c2
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c2
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_pcie0: pciegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x106
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x106
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x6	/* USBHUB_RST# (ext p/u) */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x40
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x140
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x140
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x140
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x140
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
+		>;
+	};
+};
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 4fba8eb2438b..a702f58c88c0 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -75,7 +75,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="imx8mm-venice imx8mm-venice-gw71xx-0x imx8mm-venice-gw72xx-0x imx8mm-venice-gw73xx-0x imx8mm-venice-gw7901 imx8mm-venice-gw7902 imx8mm-venice-gw7903 imx8mm-venice-gw7904"
+CONFIG_OF_LIST="imx8mm-venice imx8mm-venice-gw71xx-0x imx8mm-venice-gw72xx-0x imx8mm-venice-gw73xx-0x imx8mm-venice-gw7901 imx8mm-venice-gw7902 imx8mm-venice-gw7903 imx8mm-venice-gw7904 imx8mm-venice-gw7905-0x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
-- 
2.25.1

