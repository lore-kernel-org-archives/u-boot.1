Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EC1C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 12:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B5C8759F;
	Sat,  9 Dec 2023 13:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E1B8763D; Sat,  9 Dec 2023 12:46:15 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F1287630
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 12:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=m.othacehe@gmail.com
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.othacehe@gmail.com>)
 id 1rBvmc-0007gx-AM; Sat, 09 Dec 2023 06:46:10 -0500
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: u-boot@lists.denx.de
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH] Add imx93-var-som support
Date: Sat,  9 Dec 2023 12:45:55 +0100
Message-ID: <20231209114555.16951-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Dec 2023 13:57:13 +0100
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

Add support for the Variscite VAR-SOM-IMX93 evaluation kit. The SoM
consists of an NXP iMX93 dual A55 CPU. The SoM is mounted on a Variscite
Symphony SBC.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 arch/arm/dts/Makefile                         |    3 +-
 .../dts/imx93-var-som-symphony-u-boot.dtsi    |  152 ++
 arch/arm/dts/imx93-var-som-symphony.dts       |  223 +++
 arch/arm/dts/imx93-var-som.dtsi               |  205 +++
 arch/arm/include/asm/arch-imx9/clock.h        |    1 +
 arch/arm/mach-imx/imx9/Kconfig                |    6 +
 board/variscite/common/Kconfig                |    6 +
 board/variscite/common/eth.c                  |   59 +
 board/variscite/common/eth.h                  |   12 +
 board/variscite/common/extcon-ptn5150.c       |  137 ++
 board/variscite/common/extcon-ptn5150.h       |   40 +
 board/variscite/common/imx9_eeprom.c          |  188 +++
 board/variscite/common/imx9_eeprom.h          |   83 +
 board/variscite/common/mmc.c                  |   47 +
 board/variscite/imx93_var_som/Kconfig         |   14 +
 board/variscite/imx93_var_som/Makefile        |   18 +
 board/variscite/imx93_var_som/imx93_var_som.c |  147 ++
 .../variscite/imx93_var_som/lpddr4x_timing.c  | 1489 +++++++++++++++++
 board/variscite/imx93_var_som/spl.c           |  146 ++
 configs/imx93_var_som_defconfig               |  161 ++
 include/configs/imx93_var_som.h               |  175 ++
 21 files changed, 3311 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
 create mode 100644 arch/arm/dts/imx93-var-som.dtsi
 create mode 100644 board/variscite/common/Kconfig
 create mode 100644 board/variscite/common/eth.c
 create mode 100644 board/variscite/common/eth.h
 create mode 100644 board/variscite/common/extcon-ptn5150.c
 create mode 100644 board/variscite/common/extcon-ptn5150.h
 create mode 100644 board/variscite/common/imx9_eeprom.c
 create mode 100644 board/variscite/common/imx9_eeprom.h
 create mode 100644 board/variscite/common/mmc.c
 create mode 100644 board/variscite/imx93_var_som/Kconfig
 create mode 100644 board/variscite/imx93_var_som/Makefile
 create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
 create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
 create mode 100644 board/variscite/imx93_var_som/spl.c
 create mode 100644 configs/imx93_var_som_defconfig
 create mode 100644 include/configs/imx93_var_som.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 85fd5b1157b..e6b604a2232 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1057,7 +1057,8 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-librem5-r4.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-11x11-evk.dtb
+	imx93-11x11-evk.dtb \
+	imx93-var-som-symphony.dtb
 
 dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
 	imxrt1020-evk.dtb \
diff --git a/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi b/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
new file mode 100644
index 00000000000..829aba89ebc
--- /dev/null
+++ b/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 NXP
+ * Copyright 2023 Variscite Ltd.
+ */
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog3>;
+		bootph-pre-ram;
+	};
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+
+&{/soc@0} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-pre-ram;
+	bootph-all;
+};
+
+&aips2 {
+	bootph-pre-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&iomuxc {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	u-boot,off-on-delay-us = <20000>;
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
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
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&lpi2c3 {
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@42000000/i2c@42530000/pmic@25} {
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@42000000/i2c@42530000/pmic@25/regulators} {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+};
+
+&eqos {
+	compatible = "fsl,imx-eqos";
+};
+
+&ethphy0 {
+	reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+	reset-assert-us = <15000>;
+	reset-deassert-us = <100000>;
+};
+
+&ethphy1 {
+	reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
+	reset-assert-us = <15000>;
+	reset-deassert-us = <100000>;
+};
+
+&s4muap {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&clk {
+	bootph-all;
+	bootph-pre-ram;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+};
+
+&osc_32k {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&osc_24m {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx93-var-som-symphony.dts b/arch/arm/dts/imx93-var-som-symphony.dts
new file mode 100644
index 00000000000..57be1b50c8f
--- /dev/null
+++ b/arch/arm/dts/imx93-var-som-symphony.dts
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 NXP
+ * Copyright 2023 Variscite Ltd.
+ */
+
+/dts-v1/;
+
+#include "imx93-var-som.dtsi"
+
+/{
+	model = "Variscite VAR-SOM-MX93 on Symphony-Board";
+	compatible = "variscite,imx93-var-som", "fsl,imx93";
+
+	aliases {
+		ethernet1 = &fec;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		audio: audio@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <10000>;
+		enable-active-high;
+	};
+};
+
+&eqos {
+	mdio {
+		ethphy1: ethernet-phy@5 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			device_type = "ethernet-phy";
+			reg = <5>;
+			at803x,eee-disabled;
+			eee-broken-1000t;
+			reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <15000>;
+			reset-deassert-us = <100000>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	status = "okay";
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
+			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
+			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
+			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
+			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
+			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_lpi2c1_gpio: lpi2c1grp-gpio {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__GPIO1_IO00			0x31e
+			MX93_PAD_I2C1_SDA__GPIO1_IO01			0x31e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
+			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c5_gpio: lpi2c5grp-gpio {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO23__GPIO2_IO23			0x31e
+			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO18__GPIO2_IO18		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x15fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x13fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+};
+
+&lpi2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-1 = <&pinctrl_lpi2c1_gpio>;
+	pinctrl-2 = <&pinctrl_lpi2c1_gpio>;
+	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&lpi2c5 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
+	pinctrl-2 = <&pinctrl_lpi2c5_gpio>;
+	scl-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pca9534: gpio@20 {
+		status = "okay";
+		compatible = "nxp,pca9534";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		eth1_phy_vsel_hog {
+			gpio-hog;
+			gpio-hog-optional;
+			gpios = <6 0>;
+			output-high;
+			line-name = "eth1_phy_vsel";
+		};
+
+		eth1_phy_pwr_hog {
+			gpio-hog;
+			gpio-hog-optional;
+			gpios = <7 0>;
+			output-high;
+			line-name = "eth1_phy_pwr";
+		};
+	};
+
+	ptn5150: ptn5150@3d {
+		compatible = "nxp,ptn5150";
+		pinctrl-names = "default";
+		reg = <0x3d>;
+		i2c-bus = <0x4>;
+		status = "okay";
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	clocks = <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_GATE>;
+	clock-names = "ipg", "per";
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2>;
+	pinctrl-2 = <&pinctrl_usdhc2>;
+	non-removable;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
diff --git a/arch/arm/dts/imx93-var-som.dtsi b/arch/arm/dts/imx93-var-som.dtsi
new file mode 100644
index 00000000000..452ffa1f973
--- /dev/null
+++ b/arch/arm/dts/imx93-var-som.dtsi
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 NXP
+ * Copyright 2022 Variscite Ltd.
+ */
+
+/dts-v1/;
+
+#include "imx93.dtsi"
+
+/{
+	compatible = "variscite,imx93-var-som", "fsl,imx93";
+
+	aliases {
+		ethernet0 = &eqos;
+	};
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <1000000>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			device_type = "ethernet-phy";
+			at803x,eee-disabled;
+			eee-broken-1000t;
+			reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <15000>;
+			reset-deassert-us = <100000>;
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	status = "okay";
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC				0x57e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO				0x57e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+			MX93_PAD_UART2_TXD__GPIO1_IO07				0x31e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK			0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD			0x13fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
+		>;
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		pinctrl-names = "default";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 1169ffd74d3..1ce6ac4c3a8 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -222,6 +222,7 @@ u32 mxc_get_clock(enum mxc_clock clk);
 void dram_pll_init(ulong pll_val);
 void dram_enable_bypass(ulong clk_val);
 void dram_disable_bypass(void);
+void set_arm_core_max_clk(void);
 
 int configure_intpll(enum ccm_clk_src pll, u32 freq);
 
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c51f80f311a..f532d98bd41 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -31,9 +31,15 @@ config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
 	select IMX93
 
+config TARGET_IMX93_VAR_SOM
+	bool "imx93_var_som"
+	select IMX93
+	select IMX9_LPDDR4X
+
 endchoice
 
 source "board/freescale/imx93_evk/Kconfig"
+source "board/variscite/imx93_var_som/Kconfig"
 
 endif
 
diff --git a/board/variscite/common/Kconfig b/board/variscite/common/Kconfig
new file mode 100644
index 00000000000..fffa3a5c530
--- /dev/null
+++ b/board/variscite/common/Kconfig
@@ -0,0 +1,6 @@
+config EXTCON_PTN5150
+	bool "NXP PTN5150 CC LOGIC USB EXTCON support"
+	default n
+	help
+	  Say Y here to enable support for USB peripheral and USB host
+	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
diff --git a/board/variscite/common/eth.c b/board/variscite/common/eth.c
new file mode 100644
index 00000000000..3361f92942d
--- /dev/null
+++ b/board/variscite/common/eth.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Variscite Ltd.
+ */
+#include <common.h>
+#include <net.h>
+#include <miiphy.h>
+#include <env.h>
+#include "../common/imx9_eeprom.h"
+
+#define CHAR_BIT 8
+
+static u64 mac2int(const u8 hwaddr[])
+{
+	s8 i;
+	u64 ret = 0;
+	const u8 *p = hwaddr;
+
+	for (i = 5; i >= 0; i--)
+		ret |= (u64)*p++ << (CHAR_BIT * i);
+
+	return ret;
+}
+
+static void int2mac(const u64 mac, u8 *hwaddr)
+{
+	s8 i;
+	u8 *p = hwaddr;
+
+	for (i = 5; i >= 0; i--)
+		*p++ = mac >> (CHAR_BIT * i);
+}
+
+int var_setup_mac(struct var_eeprom *eeprom)
+{
+	int ret;
+	unsigned char enetaddr[6];
+	u64 addr;
+	unsigned char enet1addr[6];
+
+	ret = eth_env_get_enetaddr("ethaddr", enetaddr);
+	if (ret)
+		return 0;
+
+	ret = var_eeprom_get_mac(eeprom, enetaddr);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ethaddr(enetaddr))
+		return -1;
+
+	eth_env_set_enetaddr("ethaddr", enetaddr);
+
+	addr = mac2int(enetaddr);
+	int2mac(addr + 1, enet1addr);
+	eth_env_set_enetaddr("eth1addr", enet1addr);
+
+	return 0;
+}
diff --git a/board/variscite/common/eth.h b/board/variscite/common/eth.h
new file mode 100644
index 00000000000..a335c08b8ce
--- /dev/null
+++ b/board/variscite/common/eth.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Variscite Ltd.
+ *
+ */
+
+#ifndef _MX9_ETH_H_
+#define _MX9_ETH_H_
+
+int var_setup_mac(struct var_eeprom *eeprom);
+
+#endif /* _MX9_ETH_H_ */
diff --git a/board/variscite/common/extcon-ptn5150.c b/board/variscite/common/extcon-ptn5150.c
new file mode 100644
index 00000000000..d7b3a7c54ee
--- /dev/null
+++ b/board/variscite/common/extcon-ptn5150.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for NXP PTN5150 CC LOGIC USB EXTCON support
+ *
+ * Copyright 2022 Variscite Ltd.
+ * Author: Nate Drude <nate.d@variscite.com>
+ */
+#include <dm.h>
+#include <i2c.h>
+#include <linux/bitfield.h>
+#include "extcon-ptn5150.h"
+
+int extcon_ptn5150_setup(struct extcon_ptn5150 *port)
+{
+	int ret = extcon_ptn5150_parse_fdt(port);
+
+	if (ret) {
+		printf("%s: Failed to parse device tree\n", __func__);
+		return ret;
+	}
+
+	ret = extcon_ptn5150_init(port);
+	if (ret) {
+		printf("%s: port init failed, err=%d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* TODO: Support multiple ptn5150s by iterating nxp,ptn5150 compatible nodes */
+int extcon_ptn5150_parse_fdt(struct extcon_ptn5150 *port)
+{
+	int ptn5150_node;
+
+	memset(port, 0, sizeof(struct extcon_ptn5150));
+
+	ptn5150_node = fdt_node_offset_by_compatible(gd->fdt_blob, 0, "nxp,ptn5150");
+	if (ptn5150_node < 0) {
+		printf("%s: failed to find node, err=%d\n", __func__, ptn5150_node);
+		return -ENODEV;
+	}
+
+	port->i2c_cfg.addr = dev_read_u32_default(gd->fdt_blob, "reg", -1);
+	if (port->i2c_cfg.addr < 0) {
+		printf("%s: failed to find reg, err=%d\n", __func__, port->i2c_cfg.addr);
+		return -ENODEV;
+	}
+
+	port->i2c_cfg.bus = dev_read_u32_default(gd->fdt_blob, "i2c-bus", -1);
+	if (port->i2c_cfg.bus < 0) {
+		printf("%s: failed to find i2c-bus, err=%d\n", __func__, port->i2c_cfg.bus);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+int extcon_ptn5150_phy_mode(struct extcon_ptn5150 *port)
+{
+	int cc_status = extcon_ptn5150_cc_status(port);
+	int usb_phy_mode;
+
+	switch (cc_status) {
+	case PTN5150_CC_STATUS_DFP:
+		printf("%s: phy mode is device\n", __func__);
+		usb_phy_mode = USB_INIT_DEVICE;
+		break;
+	case PTN5150_CC_STATUS_UFP:
+		printf("%s: phy mode is host\n", __func__);
+		usb_phy_mode = USB_INIT_HOST;
+		break;
+	default:
+		usb_phy_mode = -ENODEV;
+		break;
+	}
+
+	return usb_phy_mode;
+}
+
+int extcon_ptn5150_cc_status(struct extcon_ptn5150 *port)
+{
+	u8 cc_status_reg;
+	int ret;
+
+	if (!port->i2c_dev)
+		return -ENODEV;
+
+	/* Read Control Register */
+	ret = dm_i2c_read(port->i2c_dev, PTN5150_CC_STATUS_REG, (u8 *)&cc_status_reg, 1);
+	if (ret) {
+		printf("%s dm_i2c_read failed, err %d\n", __func__, ret);
+		return -EIO;
+	}
+
+	return FIELD_GET(PTN5150_CC_STATUS_ATTACH_MASK, cc_status_reg);
+}
+
+int extcon_ptn5150_init(struct extcon_ptn5150 *port)
+{
+	int ret;
+	u8 vendor_reg;
+	struct udevice *bus;
+	struct udevice *i2c_dev = NULL;
+
+	if (!port)
+		return -EINVAL;
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, port->i2c_cfg.bus, &bus);
+	if (ret) {
+		printf("%s: Can't find bus\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = dm_i2c_probe(bus, port->i2c_cfg.addr, 0, &i2c_dev);
+	if (ret) {
+		printf("%s: Can't find device id=0x%x\n",
+		       __func__, port->i2c_cfg.addr);
+		return -ENODEV;
+	}
+
+	port->i2c_dev = i2c_dev;
+
+	/* Read Vendor ID and Version ID */
+	ret = dm_i2c_read(port->i2c_dev, PTN5150_ID_REG, (u8 *)&vendor_reg, 1);
+	if (ret) {
+		printf("%s dm_i2c_read failed, err %d\n", __func__, ret);
+		return -EIO;
+	}
+
+	printf("PTN5150: Vendor ID [0x%lx], Version ID [0x%lx], Addr [I2C%u 0x%x]\n",
+	       FIELD_GET(PTN5150_ID_VENDOR_MASK, vendor_reg),
+	       FIELD_GET(PTN5150_ID_VERSION_MASK, vendor_reg),
+	       port->i2c_cfg.bus, port->i2c_cfg.addr);
+
+	return 0;
+}
diff --git a/board/variscite/common/extcon-ptn5150.h b/board/variscite/common/extcon-ptn5150.h
new file mode 100644
index 00000000000..69917747c7a
--- /dev/null
+++ b/board/variscite/common/extcon-ptn5150.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Driver for NXP PTN5150 CC LOGIC USB EXTCON support
+ *
+ * Copyright 2022 Variscite Ltd.
+ * Author: Nate Drude <nate.d@variscite.com>
+ */
+#ifndef __EXTCON_PTN5150_H
+#define __EXTCON_PTN5150_H
+
+#include <linux/bitfield.h>
+#include <usb.h>
+
+#define PTN5150_ID_REG				0x1
+#define   PTN5150_ID_VENDOR_MASK		GENMASK(2, 0)
+#define   PTN5150_ID_VERSION_MASK		GENMASK(7, 3)
+
+#define PTN5150_CC_STATUS_REG			0x4
+#define   PTN5150_CC_STATUS_ATTACH_MASK		GENMASK(4, 2)
+#define   PTN5150_CC_STATUS_NOT_CONNECTED	0x0
+#define   PTN5150_CC_STATUS_DFP			0x1
+#define   PTN5150_CC_STATUS_UFP			0x2
+
+struct extcon_ptn5150_i2c_cfg {
+	int bus;
+	int addr;
+};
+
+struct extcon_ptn5150 {
+	struct extcon_ptn5150_i2c_cfg i2c_cfg;
+	struct udevice *i2c_dev;
+};
+
+int extcon_ptn5150_setup(struct extcon_ptn5150 *port);
+int extcon_ptn5150_parse_fdt(struct extcon_ptn5150 *port);
+int extcon_ptn5150_phy_mode(struct extcon_ptn5150 *port);
+int extcon_ptn5150_cc_status(struct extcon_ptn5150 *port);
+int extcon_ptn5150_init(struct extcon_ptn5150 *port);
+
+#endif /* __EXTCON_PTN5150_H */
diff --git a/board/variscite/common/imx9_eeprom.c b/board/variscite/common/imx9_eeprom.c
new file mode 100644
index 00000000000..4700cff5796
--- /dev/null
+++ b/board/variscite/common/imx9_eeprom.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Variscite Ltd.
+ *
+ */
+#include <common.h>
+#include <command.h>
+#include <dm.h>
+#include <i2c.h>
+#include <asm/io.h>
+#include <cpu_func.h>
+#include <u-boot/crc.h>
+#include <asm/arch-imx9/ddr.h>
+
+#include "imx9_eeprom.h"
+
+static int var_eeprom_get_dev(struct udevice **devp)
+{
+	int ret;
+	struct udevice *bus;
+
+	ret = uclass_get_device_by_name(UCLASS_I2C, VAR_SOM_EEPROM_I2C_NAME, &bus);
+	if (ret) {
+		debug("%s: No EEPROM I2C bus '%s'\n", __func__, VAR_SOM_EEPROM_I2C_NAME);
+		return ret;
+	}
+
+	ret = dm_i2c_probe(bus, VAR_SOM_EEPROM_I2C_ADDR, 0, devp);
+	if (ret) {
+		debug("%s: I2C EEPROM probe failed\n", __func__);
+		return ret;
+	}
+
+	i2c_set_chip_offset_len(*devp, 1);
+	i2c_set_chip_addr_offset_mask(*devp, 1);
+
+	return 0;
+}
+
+int var_eeprom_read_header(struct var_eeprom *e)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = var_eeprom_get_dev(&dev);
+	if (ret) {
+		debug("%s: Failed to detect I2C EEPROM\n", __func__);
+		return ret;
+	}
+
+	/* Read EEPROM header to memory */
+	ret = dm_i2c_read(dev, 0, (void *)e, sizeof(*e));
+	if (ret) {
+		debug("%s: EEPROM read failed, ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int var_eeprom_get_mac(struct var_eeprom *ep, u8 *mac)
+{
+	flush_dcache_all();
+	if (!var_eeprom_is_valid(ep))
+		return -1;
+
+	memcpy(mac, ep->mac, sizeof(ep->mac));
+
+	return 0;
+}
+
+int var_eeprom_get_dram_size(struct var_eeprom *ep, phys_size_t *size)
+{
+	/* No data in EEPROM - return default DRAM size */
+	if (!var_eeprom_is_valid(ep)) {
+		*size = DEFAULT_SDRAM_SIZE;
+		return 0;
+	}
+
+	*size = (ep->dramsize * 128UL) << 20;
+	return 0;
+}
+
+void var_eeprom_print_prod_info(struct var_eeprom *ep)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		return;
+
+	flush_dcache_all();
+
+	if (!var_eeprom_is_valid(ep))
+		return;
+
+	if (IS_ENABLED(CONFIG_TARGET_IMX93_VAR_SOM))
+		printf("\nPart number: VSM-MX93-%.*s\n",
+		       (int)sizeof(ep->partnum), ep->partnum);
+
+	printf("Assembly: AS%.*s\n", (int)sizeof(ep->assembly), (char *)ep->assembly);
+
+	printf("Production date: %.*s %.*s %.*s\n",
+	       4, /* YYYY */
+	       (char *)ep->date,
+	       3, /* MMM */
+	       ((char *)ep->date) + 4,
+	       2, /* DD */
+	       ((char *)ep->date) + 4 + 3);
+
+	printf("Serial Number: %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       ep->mac[0], ep->mac[1], ep->mac[2], ep->mac[3], ep->mac[4], ep->mac[5]);
+
+	debug("EEPROM version: 0x%x\n", ep->version);
+	debug("SOM features: 0x%x\n", ep->features);
+	printf("SOM revision: 0x%x\n", ep->somrev);
+	printf("DRAM PN: VIC-%04d\n", ep->ddr_vic);
+	debug("DRAM size: %d GiB\n\n", (ep->dramsize * 128) / 1024);
+}
+
+int var_carrier_eeprom_read(const char *bus_name, int addr, struct var_carrier_eeprom *ep)
+{
+	int ret;
+	struct udevice *bus;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_I2C, bus_name, &bus);
+	if (ret) {
+		debug("%s: No bus '%s'\n", __func__, bus_name);
+		return ret;
+	}
+
+	ret = dm_i2c_probe(bus, addr, 0, &dev);
+	if (ret) {
+		debug("%s: Carrier EEPROM I2C probe failed\n", __func__);
+		return ret;
+	}
+
+	/* Read EEPROM to memory */
+	ret = dm_i2c_read(dev, 0, (void *)ep, sizeof(*ep));
+	if (ret) {
+		debug("%s: Carrier EEPROM read failed, ret=%d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int var_carrier_eeprom_is_valid(struct var_carrier_eeprom *ep)
+{
+	u32 crc, crc_offset = offsetof(struct var_carrier_eeprom, crc);
+
+	if (htons(ep->magic) != VAR_CARRIER_EEPROM_MAGIC) {
+		debug("Invalid carrier EEPROM magic 0x%x, expected 0x%x\n",
+		      htons(ep->magic), VAR_CARRIER_EEPROM_MAGIC);
+		return 0;
+	}
+
+	if (ep->struct_ver < 1) {
+		printf("Invalid carrier EEPROM version 0x%x\n", ep->struct_ver);
+		return 0;
+	}
+
+	if (ep->struct_ver == 1)
+		return 1;
+
+	/* Only EEPROM structure above version 1 has CRC field */
+	crc = crc32(0, (void *)ep, crc_offset);
+
+	if (crc != ep->crc) {
+		printf("Carrier EEPROM CRC mismatch (%08x != %08x)\n",
+		       crc, be32_to_cpu(ep->crc));
+		return 0;
+	}
+
+	return 1;
+}
+
+/* Returns carrier board revision string via 'rev' argument.
+ * For legacy carrier board revisions the "legacy" string is returned.
+ * For new carrier board revisions the actual carrier revision is returned.
+ * Symphony-Board 1.4 and below are legacy, 1.4a and above are new.
+ * DT8MCustomBoard 1.4 and below are legacy, 2.0 and above are new.
+ */
+void var_carrier_eeprom_get_revision(struct var_carrier_eeprom *ep, char *rev, size_t size)
+{
+	if (var_carrier_eeprom_is_valid(ep))
+		strlcpy(rev, (const char *)ep->carrier_rev, size);
+	else
+		strlcpy(rev, "legacy", size);
+}
diff --git a/board/variscite/common/imx9_eeprom.h b/board/variscite/common/imx9_eeprom.h
new file mode 100644
index 00000000000..ed33368d486
--- /dev/null
+++ b/board/variscite/common/imx9_eeprom.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Variscite Ltd.
+ *
+ */
+
+#ifndef _MX9_VAR_EEPROM_H_
+#define _MX9_VAR_EEPROM_H_
+
+#ifdef CONFIG_ARCH_IMX9
+#include <asm/arch-imx9/ddr.h>
+#endif
+
+#define VAR_SOM_EEPROM_MAGIC	0x4D58 /* == HEX("MX") */
+
+#define VAR_SOM_EEPROM_I2C_ADDR	0x52
+
+/* Optional SOM features */
+#define VAR_EEPROM_F_WIFI		BIT(0)
+#define VAR_EEPROM_F_ETH		BIT(1)
+#define VAR_EEPROM_F_AUDIO		BIT(2)
+
+/* SOM storage types */
+enum som_storage {
+	SOM_STORAGE_EMMC,
+	SOM_STORAGE_NAND,
+	SOM_STORAGE_UNDEFINED,
+};
+
+/* Number of DRAM adjustment tables */
+#define DRAM_TABLE_NUM 7
+
+struct __packed var_eeprom
+{
+	u16 magic;			/* 00-0x00 - magic number       */
+	u8 partnum[8];			/* 02-0x02 - part number        */
+	u8 assembly[10];		/* 10-0x0a - assembly number    */
+	u8 date[9];			/* 20-0x14 - build date         */
+	u8 mac[6];			/* 29-0x1d - MAC address        */
+	u8 somrev;			/* 35-0x23 - SOM revision       */
+	u8 version;			/* 36-0x24 - EEPROM version     */
+	u8 features;			/* 37-0x25 - SOM features       */
+	u8 dramsize;			/* 38-0x26 - DRAM size          */
+	u8 reserved[5];			/* 39 0x27 - reserved           */
+	u32 ddr_crc32;			/* 44-0x2c - CRC32 of DDR DATAi */
+	u16 ddr_vic;			/* 48-0x30 - DDR VIC PN         */
+	u16 off[DRAM_TABLE_NUM + 1];	/* 50-0x32 - DRAM table offsets */
+};
+
+#define VAR_EEPROM_DATA ((struct var_eeprom *)VAR_EEPROM_DRAM_START)
+
+#define VAR_CARRIER_EEPROM_MAGIC	0x5643 /* == HEX("VC") */
+
+#define CARRIER_REV_LEN 16
+struct __packed var_carrier_eeprom
+{
+	u16 magic;                          /* 00-0x00 - magic number		*/
+	u8 struct_ver;                      /* 01-0x01 - EEPROM structure version	*/
+	u8 carrier_rev[CARRIER_REV_LEN];    /* 02-0x02 - carrier board revision	*/
+	u32 crc;                            /* 10-0x0a - checksum			*/
+};
+
+static inline int var_eeprom_is_valid(struct var_eeprom *ep)
+{
+	if (htons(ep->magic) != VAR_SOM_EEPROM_MAGIC) {
+		debug("Invalid EEPROM magic 0x%x, expected 0x%x\n",
+		      htons(ep->magic), VAR_SOM_EEPROM_MAGIC);
+		return 0;
+	}
+
+	return 1;
+}
+
+int var_eeprom_read_header(struct var_eeprom *e);
+int var_eeprom_get_dram_size(struct var_eeprom *e, phys_size_t *size);
+int var_eeprom_get_mac(struct var_eeprom *e, u8 *mac);
+void var_eeprom_print_prod_info(struct var_eeprom *e);
+
+int var_carrier_eeprom_read(const char *bus_name, int addr, struct var_carrier_eeprom *ep);
+int var_carrier_eeprom_is_valid(struct var_carrier_eeprom *ep);
+void var_carrier_eeprom_get_revision(struct var_carrier_eeprom *ep, char *rev, size_t size);
+
+#endif /* _MX9_VAR_EEPROM_H_ */
diff --git a/board/variscite/common/mmc.c b/board/variscite/common/mmc.c
new file mode 100644
index 00000000000..b24b4c98f3f
--- /dev/null
+++ b/board/variscite/common/mmc.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ *
+ */
+#include <common.h>
+#include <command.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/errno.h>
+#include <asm/io.h>
+#include <stdbool.h>
+#include <mmc.h>
+#include <env.h>
+
+static int check_mmc_autodetect(void)
+{
+	char *autodetect_str = env_get("mmcautodetect");
+
+	if (autodetect_str && (strcmp(autodetect_str, "yes") == 0))
+		return 1;
+
+	return 0;
+}
+
+/* This should be defined for each board */
+__weak int mmc_map_to_kernel_blk(int dev_no)
+{
+	return dev_no;
+}
+
+void board_late_mmc_env_init(void)
+{
+	char cmd[32];
+	u32 dev_no = mmc_get_env_dev();
+
+	if (!check_mmc_autodetect())
+		return;
+
+	env_set_ulong("mmcdev", dev_no);
+
+	/* Set mmcblk env */
+	env_set_ulong("mmcblk", mmc_map_to_kernel_blk(dev_no));
+
+	sprintf(cmd, "mmc dev %d", dev_no);
+	run_command(cmd, 0);
+}
diff --git a/board/variscite/imx93_var_som/Kconfig b/board/variscite/imx93_var_som/Kconfig
new file mode 100644
index 00000000000..34e9bf23a83
--- /dev/null
+++ b/board/variscite/imx93_var_som/Kconfig
@@ -0,0 +1,14 @@
+if TARGET_IMX93_VAR_SOM
+
+config SYS_BOARD
+	default "imx93_var_som"
+
+config SYS_VENDOR
+	default "variscite"
+
+config SYS_CONFIG_NAME
+	default "imx93_var_som"
+
+source "board/variscite/common/Kconfig"
+
+endif
diff --git a/board/variscite/imx93_var_som/Makefile b/board/variscite/imx93_var_som/Makefile
new file mode 100644
index 00000000000..bb2383c18da
--- /dev/null
+++ b/board/variscite/imx93_var_som/Makefile
@@ -0,0 +1,18 @@
+#
+# Copyright 2022 NXP
+# Copyright 2023 Variscite Ltd.
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx93_var_som.o
+obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += ../common/imx9_eeprom.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+obj-$(CONFIG_TARGET_IMX93_VAR_SOM) += lpddr4x_timing.o
+else
+obj-y += ../common/eth.o
+obj-y += ../common/mmc.o
+obj-$(CONFIG_EXTCON_PTN5150) += ../common/extcon-ptn5150.o
+endif
diff --git a/board/variscite/imx93_var_som/imx93_var_som.c b/board/variscite/imx93_var_som/imx93_var_som.c
new file mode 100644
index 00000000000..2d0f5d14c56
--- /dev/null
+++ b/board/variscite/imx93_var_som/imx93_var_som.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 NXP
+ * Copyright 2023 Variscite Ltd.
+ */
+
+#include <common.h>
+#include <env.h>
+#include <init.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/global_data.h>
+#include <asm/arch-imx9/ccm_regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch-imx9/imx93_pins.h>
+#include <asm/arch/clock.h>
+#include <power/pmic.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <usb.h>
+#include <dwc3-uboot.h>
+
+#include "../common/imx9_eeprom.h"
+#include "../common/eth.h"
+#include "../common/extcon-ptn5150.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define CARRIER_EEPROM_ADDR 0x54
+
+#define UART_PAD_CTRL	(PAD_CTL_DSE(6) | PAD_CTL_FSEL2)
+#define WDOG_PAD_CTRL	(PAD_CTL_DSE(6) | PAD_CTL_ODE | PAD_CTL_PUE | PAD_CTL_PE)
+
+static const iomux_v3_cfg_t uart_pads[] = {
+	MX93_PAD_UART1_RXD__LPUART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
+	MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
+};
+
+int board_early_init_f(void)
+{
+	imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));
+
+	init_uart_clk(LPUART1_CLK_ROOT);
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	struct var_eeprom *ep = VAR_EEPROM_DATA;
+
+	var_eeprom_get_dram_size(ep, size);
+	return 0;
+}
+
+int board_phy_config(struct phy_device *phydev)
+{
+	if (phydev->drv->config)
+		phydev->drv->config(phydev);
+
+	return 0;
+}
+
+static int setup_eqos(void)
+{
+	struct blk_ctrl_wakeupmix_regs *bctrl =
+		(struct blk_ctrl_wakeupmix_regs *)BLK_CTRL_WAKEUPMIX_BASE_ADDR;
+
+	/* set INTF as RGMII, enable RGMII TXC clock */
+	clrsetbits_le32(&bctrl->eqos_gpr,
+			BCTRL_GPR_ENET_QOS_INTF_MODE_MASK,
+			BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII | BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
+
+	return set_clk_eqos(ENET_125MHZ);
+}
+
+static struct extcon_ptn5150 usb_ptn5150;
+int board_ehci_usb_phy_mode(struct udevice *dev)
+{
+	int usb_phy_mode = extcon_ptn5150_phy_mode(&usb_ptn5150);
+
+	if (!IS_ENABLED(CONFIG_EXTCON_PTN5150))
+		return 0;
+
+	/* Default to host mode if not connected */
+	if (usb_phy_mode < 0) {
+		printf("Defaulting to USB Host");
+		usb_phy_mode = USB_INIT_HOST;
+	}
+
+	return usb_phy_mode;
+}
+
+int board_init(void)
+{
+	set_clk_enet(ENET_125MHZ);
+
+	if (CONFIG_IS_ENABLED(DWC_ETH_QOS))
+		setup_eqos();
+
+	return 0;
+}
+
+#define SDRAM_SIZE_STR_LEN 5
+
+int board_late_init(void)
+{
+	struct var_eeprom *ep = VAR_EEPROM_DATA;
+	char sdram_size_str[SDRAM_SIZE_STR_LEN];
+	struct var_carrier_eeprom carrier_eeprom;
+	char carrier_rev[CARRIER_REV_LEN] = {0};
+	char som_rev[CARRIER_REV_LEN] = {0};
+
+	if (IS_ENABLED(CONFIG_EXTCON_PTN5150))
+		extcon_ptn5150_setup(&usb_ptn5150);
+
+	var_setup_mac(ep);
+	var_eeprom_print_prod_info(ep);
+
+	/* ENV Variables */
+
+	/* SDRAM ENV */
+	snprintf(sdram_size_str, SDRAM_SIZE_STR_LEN, "%d",
+		 (int)(gd->ram_size / 1024 / 1024));
+	env_set("sdram_size", sdram_size_str);
+
+	/* Carrier Board ENV */
+	var_carrier_eeprom_read(VAR_CARRIER_EEPROM_I2C_NAME, CARRIER_EEPROM_ADDR, &carrier_eeprom);
+	var_carrier_eeprom_get_revision(&carrier_eeprom, carrier_rev, sizeof(carrier_rev));
+	env_set("carrier_rev", carrier_rev);
+
+	/* SoM Rev ENV */
+	snprintf(som_rev, CARRIER_REV_LEN, "som_rev1%d", ep->somrev);
+	env_set("som_rev", som_rev);
+
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	env_set("sec_boot", "no");
+	if (IS_ENABLED(CONFIG_AHAB_BOOT))
+		env_set("sec_boot", "yes");
+
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		env_set("board_name", "VAR-SOM-MX93");
+
+	return 0;
+}
diff --git a/board/variscite/imx93_var_som/lpddr4x_timing.c b/board/variscite/imx93_var_som/lpddr4x_timing.c
new file mode 100644
index 00000000000..a64b9045e24
--- /dev/null
+++ b/board/variscite/imx93_var_som/lpddr4x_timing.c
@@ -0,0 +1,1489 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ *
+ * Code generated with DDR Tool.
+ */
+
+#include <linux/kernel.h>
+#include <asm/arch/ddr.h>
+
+struct dram_cfg_param ddr_ddrc_cfg[] = {
+	/** Initialize DDRC registers **/
+	{ 0x4e300110, 0x44100001 },
+	{ 0x4e300000, 0x8000ff },
+	{ 0x4e300008, 0x0 },
+	{ 0x4e300080, 0x80000512 },
+	{ 0x4e300084, 0x0 },
+	{ 0x4e300100, 0x24ab321b },
+	{ 0x4e300104, 0xa8ee001b },
+	{ 0x4e300108, 0x2f2ee233 },
+	{ 0x4e30010c, 0x5e18b },
+	{ 0x4e300114, 0x1002 },
+	{ 0x4e300124, 0x1c770000 },
+	{ 0x4e300160, 0x5402 },
+	{ 0x4e30016c, 0x35f00000 },
+	{ 0x4e300170, 0x8b0b0608 },
+	{ 0x4e300250, 0x28 },
+	{ 0x4e300254, 0x0 },
+	{ 0x4e30025c, 0x400 },
+	{ 0x4e300260, 0x800 },
+	{ 0x4e300300, 0x14281114 },
+	{ 0x4e300304, 0x163110a },
+	{ 0x4e300308, 0xa200e3c },
+	{ 0x4e300f04, 0x80 },
+	{ 0x4e300800, 0x43b30002 },
+	{ 0x4e300804, 0x1f1f1f1f },
+	{ 0x4e301000, 0x0 },
+
+};
+
+/* PHY Initialize Configuration */
+struct dram_cfg_param ddr_ddrphy_cfg[] = {
+	{ 0x100a0, 0x4 },
+	{ 0x100a1, 0x5 },
+	{ 0x100a2, 0x6 },
+	{ 0x100a3, 0x7 },
+	{ 0x100a4, 0x0 },
+	{ 0x100a5, 0x1 },
+	{ 0x100a6, 0x2 },
+	{ 0x100a7, 0x3 },
+	{ 0x110a0, 0x3 },
+	{ 0x110a1, 0x2 },
+	{ 0x110a2, 0x0 },
+	{ 0x110a3, 0x1 },
+	{ 0x110a4, 0x7 },
+	{ 0x110a5, 0x6 },
+	{ 0x110a6, 0x4 },
+	{ 0x110a7, 0x5 },
+	{ 0x1005f, 0x5ff },
+	{ 0x1015f, 0x5ff },
+	{ 0x1105f, 0x5ff },
+	{ 0x1115f, 0x5ff },
+	{ 0x55, 0x1ff },
+	{ 0x1055, 0x1ff },
+	{ 0x2055, 0x1ff },
+	{ 0x200c5, 0x19 },
+	{ 0x2002e, 0x2 },
+	{ 0x90204, 0x0 },
+	{ 0x20024, 0x1e3 },
+	{ 0x2003a, 0x2 },
+	{ 0x2007d, 0x212 },
+	{ 0x2007c, 0x61 },
+	{ 0x20056, 0x3 },
+	{ 0x1004d, 0xe00 },
+	{ 0x1014d, 0xe00 },
+	{ 0x1104d, 0xe00 },
+	{ 0x1114d, 0xe00 },
+	{ 0x10049, 0xe00 },
+	{ 0x10149, 0xe00 },
+	{ 0x11049, 0xe00 },
+	{ 0x11149, 0xe00 },
+	{ 0x43, 0x60 },
+	{ 0x1043, 0x60 },
+	{ 0x2043, 0x60 },
+	{ 0x20018, 0x1 },
+	{ 0x20075, 0x4 },
+	{ 0x20050, 0x0 },
+	{ 0x2009b, 0x2 },
+	{ 0x20008, 0x3a5 },
+	{ 0x20088, 0x9 },
+	{ 0x200b2, 0x10c },
+	{ 0x10043, 0x5a1 },
+	{ 0x10143, 0x5a1 },
+	{ 0x11043, 0x5a1 },
+	{ 0x11143, 0x5a1 },
+	{ 0x200fa, 0x2 },
+	{ 0x20019, 0x1 },
+	{ 0x200f0, 0x0 },
+	{ 0x200f1, 0x0 },
+	{ 0x200f2, 0x4444 },
+	{ 0x200f3, 0x8888 },
+	{ 0x200f4, 0x5555 },
+	{ 0x200f5, 0x0 },
+	{ 0x200f6, 0x0 },
+	{ 0x200f7, 0xf000 },
+	{ 0x1004a, 0x500 },
+	{ 0x1104a, 0x500 },
+	{ 0x20025, 0x0 },
+	{ 0x2002d, 0x0 },
+	{ 0x2002c, 0x0 },
+
+};
+
+/* ddr phy trained csr */
+struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
+	{ 0x200b2, 0x0 },
+	{ 0x1200b2, 0x0 },
+	{ 0x2200b2, 0x0 },
+	{ 0x200cb, 0x0 },
+	{ 0x10043, 0x0 },
+	{ 0x110043, 0x0 },
+	{ 0x210043, 0x0 },
+	{ 0x10143, 0x0 },
+	{ 0x110143, 0x0 },
+	{ 0x210143, 0x0 },
+	{ 0x11043, 0x0 },
+	{ 0x111043, 0x0 },
+	{ 0x211043, 0x0 },
+	{ 0x11143, 0x0 },
+	{ 0x111143, 0x0 },
+	{ 0x211143, 0x0 },
+	{ 0x12043, 0x0 },
+	{ 0x112043, 0x0 },
+	{ 0x212043, 0x0 },
+	{ 0x12143, 0x0 },
+	{ 0x112143, 0x0 },
+	{ 0x212143, 0x0 },
+	{ 0x13043, 0x0 },
+	{ 0x113043, 0x0 },
+	{ 0x213043, 0x0 },
+	{ 0x13143, 0x0 },
+	{ 0x113143, 0x0 },
+	{ 0x213143, 0x0 },
+	{ 0x80, 0x0 },
+	{ 0x100080, 0x0 },
+	{ 0x200080, 0x0 },
+	{ 0x1080, 0x0 },
+	{ 0x101080, 0x0 },
+	{ 0x201080, 0x0 },
+	{ 0x2080, 0x0 },
+	{ 0x102080, 0x0 },
+	{ 0x202080, 0x0 },
+	{ 0x3080, 0x0 },
+	{ 0x103080, 0x0 },
+	{ 0x203080, 0x0 },
+	{ 0x4080, 0x0 },
+	{ 0x104080, 0x0 },
+	{ 0x204080, 0x0 },
+	{ 0x5080, 0x0 },
+	{ 0x105080, 0x0 },
+	{ 0x205080, 0x0 },
+	{ 0x6080, 0x0 },
+	{ 0x106080, 0x0 },
+	{ 0x206080, 0x0 },
+	{ 0x7080, 0x0 },
+	{ 0x107080, 0x0 },
+	{ 0x207080, 0x0 },
+	{ 0x8080, 0x0 },
+	{ 0x108080, 0x0 },
+	{ 0x208080, 0x0 },
+	{ 0x9080, 0x0 },
+	{ 0x109080, 0x0 },
+	{ 0x209080, 0x0 },
+	{ 0x10080, 0x0 },
+	{ 0x110080, 0x0 },
+	{ 0x210080, 0x0 },
+	{ 0x10180, 0x0 },
+	{ 0x110180, 0x0 },
+	{ 0x210180, 0x0 },
+	{ 0x11080, 0x0 },
+	{ 0x111080, 0x0 },
+	{ 0x211080, 0x0 },
+	{ 0x11180, 0x0 },
+	{ 0x111180, 0x0 },
+	{ 0x211180, 0x0 },
+	{ 0x12080, 0x0 },
+	{ 0x112080, 0x0 },
+	{ 0x212080, 0x0 },
+	{ 0x12180, 0x0 },
+	{ 0x112180, 0x0 },
+	{ 0x212180, 0x0 },
+	{ 0x13080, 0x0 },
+	{ 0x113080, 0x0 },
+	{ 0x213080, 0x0 },
+	{ 0x13180, 0x0 },
+	{ 0x113180, 0x0 },
+	{ 0x213180, 0x0 },
+	{ 0x10081, 0x0 },
+	{ 0x110081, 0x0 },
+	{ 0x210081, 0x0 },
+	{ 0x10181, 0x0 },
+	{ 0x110181, 0x0 },
+	{ 0x210181, 0x0 },
+	{ 0x11081, 0x0 },
+	{ 0x111081, 0x0 },
+	{ 0x211081, 0x0 },
+	{ 0x11181, 0x0 },
+	{ 0x111181, 0x0 },
+	{ 0x211181, 0x0 },
+	{ 0x12081, 0x0 },
+	{ 0x112081, 0x0 },
+	{ 0x212081, 0x0 },
+	{ 0x12181, 0x0 },
+	{ 0x112181, 0x0 },
+	{ 0x212181, 0x0 },
+	{ 0x13081, 0x0 },
+	{ 0x113081, 0x0 },
+	{ 0x213081, 0x0 },
+	{ 0x13181, 0x0 },
+	{ 0x113181, 0x0 },
+	{ 0x213181, 0x0 },
+	{ 0x100d0, 0x0 },
+	{ 0x1100d0, 0x0 },
+	{ 0x2100d0, 0x0 },
+	{ 0x101d0, 0x0 },
+	{ 0x1101d0, 0x0 },
+	{ 0x2101d0, 0x0 },
+	{ 0x110d0, 0x0 },
+	{ 0x1110d0, 0x0 },
+	{ 0x2110d0, 0x0 },
+	{ 0x111d0, 0x0 },
+	{ 0x1111d0, 0x0 },
+	{ 0x2111d0, 0x0 },
+	{ 0x120d0, 0x0 },
+	{ 0x1120d0, 0x0 },
+	{ 0x2120d0, 0x0 },
+	{ 0x121d0, 0x0 },
+	{ 0x1121d0, 0x0 },
+	{ 0x2121d0, 0x0 },
+	{ 0x130d0, 0x0 },
+	{ 0x1130d0, 0x0 },
+	{ 0x2130d0, 0x0 },
+	{ 0x131d0, 0x0 },
+	{ 0x1131d0, 0x0 },
+	{ 0x2131d0, 0x0 },
+	{ 0x100d1, 0x0 },
+	{ 0x1100d1, 0x0 },
+	{ 0x2100d1, 0x0 },
+	{ 0x101d1, 0x0 },
+	{ 0x1101d1, 0x0 },
+	{ 0x2101d1, 0x0 },
+	{ 0x110d1, 0x0 },
+	{ 0x1110d1, 0x0 },
+	{ 0x2110d1, 0x0 },
+	{ 0x111d1, 0x0 },
+	{ 0x1111d1, 0x0 },
+	{ 0x2111d1, 0x0 },
+	{ 0x120d1, 0x0 },
+	{ 0x1120d1, 0x0 },
+	{ 0x2120d1, 0x0 },
+	{ 0x121d1, 0x0 },
+	{ 0x1121d1, 0x0 },
+	{ 0x2121d1, 0x0 },
+	{ 0x130d1, 0x0 },
+	{ 0x1130d1, 0x0 },
+	{ 0x2130d1, 0x0 },
+	{ 0x131d1, 0x0 },
+	{ 0x1131d1, 0x0 },
+	{ 0x2131d1, 0x0 },
+	{ 0x10068, 0x0 },
+	{ 0x10168, 0x0 },
+	{ 0x10268, 0x0 },
+	{ 0x10368, 0x0 },
+	{ 0x10468, 0x0 },
+	{ 0x10568, 0x0 },
+	{ 0x10668, 0x0 },
+	{ 0x10768, 0x0 },
+	{ 0x10868, 0x0 },
+	{ 0x11068, 0x0 },
+	{ 0x11168, 0x0 },
+	{ 0x11268, 0x0 },
+	{ 0x11368, 0x0 },
+	{ 0x11468, 0x0 },
+	{ 0x11568, 0x0 },
+	{ 0x11668, 0x0 },
+	{ 0x11768, 0x0 },
+	{ 0x11868, 0x0 },
+	{ 0x12068, 0x0 },
+	{ 0x12168, 0x0 },
+	{ 0x12268, 0x0 },
+	{ 0x12368, 0x0 },
+	{ 0x12468, 0x0 },
+	{ 0x12568, 0x0 },
+	{ 0x12668, 0x0 },
+	{ 0x12768, 0x0 },
+	{ 0x12868, 0x0 },
+	{ 0x13068, 0x0 },
+	{ 0x13168, 0x0 },
+	{ 0x13268, 0x0 },
+	{ 0x13368, 0x0 },
+	{ 0x13468, 0x0 },
+	{ 0x13568, 0x0 },
+	{ 0x13668, 0x0 },
+	{ 0x13768, 0x0 },
+	{ 0x13868, 0x0 },
+	{ 0x10069, 0x0 },
+	{ 0x10169, 0x0 },
+	{ 0x10269, 0x0 },
+	{ 0x10369, 0x0 },
+	{ 0x10469, 0x0 },
+	{ 0x10569, 0x0 },
+	{ 0x10669, 0x0 },
+	{ 0x10769, 0x0 },
+	{ 0x10869, 0x0 },
+	{ 0x11069, 0x0 },
+	{ 0x11169, 0x0 },
+	{ 0x11269, 0x0 },
+	{ 0x11369, 0x0 },
+	{ 0x11469, 0x0 },
+	{ 0x11569, 0x0 },
+	{ 0x11669, 0x0 },
+	{ 0x11769, 0x0 },
+	{ 0x11869, 0x0 },
+	{ 0x12069, 0x0 },
+	{ 0x12169, 0x0 },
+	{ 0x12269, 0x0 },
+	{ 0x12369, 0x0 },
+	{ 0x12469, 0x0 },
+	{ 0x12569, 0x0 },
+	{ 0x12669, 0x0 },
+	{ 0x12769, 0x0 },
+	{ 0x12869, 0x0 },
+	{ 0x13069, 0x0 },
+	{ 0x13169, 0x0 },
+	{ 0x13269, 0x0 },
+	{ 0x13369, 0x0 },
+	{ 0x13469, 0x0 },
+	{ 0x13569, 0x0 },
+	{ 0x13669, 0x0 },
+	{ 0x13769, 0x0 },
+	{ 0x13869, 0x0 },
+	{ 0x1008c, 0x0 },
+	{ 0x11008c, 0x0 },
+	{ 0x21008c, 0x0 },
+	{ 0x1018c, 0x0 },
+	{ 0x11018c, 0x0 },
+	{ 0x21018c, 0x0 },
+	{ 0x1108c, 0x0 },
+	{ 0x11108c, 0x0 },
+	{ 0x21108c, 0x0 },
+	{ 0x1118c, 0x0 },
+	{ 0x11118c, 0x0 },
+	{ 0x21118c, 0x0 },
+	{ 0x1208c, 0x0 },
+	{ 0x11208c, 0x0 },
+	{ 0x21208c, 0x0 },
+	{ 0x1218c, 0x0 },
+	{ 0x11218c, 0x0 },
+	{ 0x21218c, 0x0 },
+	{ 0x1308c, 0x0 },
+	{ 0x11308c, 0x0 },
+	{ 0x21308c, 0x0 },
+	{ 0x1318c, 0x0 },
+	{ 0x11318c, 0x0 },
+	{ 0x21318c, 0x0 },
+	{ 0x1008d, 0x0 },
+	{ 0x11008d, 0x0 },
+	{ 0x21008d, 0x0 },
+	{ 0x1018d, 0x0 },
+	{ 0x11018d, 0x0 },
+	{ 0x21018d, 0x0 },
+	{ 0x1108d, 0x0 },
+	{ 0x11108d, 0x0 },
+	{ 0x21108d, 0x0 },
+	{ 0x1118d, 0x0 },
+	{ 0x11118d, 0x0 },
+	{ 0x21118d, 0x0 },
+	{ 0x1208d, 0x0 },
+	{ 0x11208d, 0x0 },
+	{ 0x21208d, 0x0 },
+	{ 0x1218d, 0x0 },
+	{ 0x11218d, 0x0 },
+	{ 0x21218d, 0x0 },
+	{ 0x1308d, 0x0 },
+	{ 0x11308d, 0x0 },
+	{ 0x21308d, 0x0 },
+	{ 0x1318d, 0x0 },
+	{ 0x11318d, 0x0 },
+	{ 0x21318d, 0x0 },
+	{ 0x100c0, 0x0 },
+	{ 0x1100c0, 0x0 },
+	{ 0x2100c0, 0x0 },
+	{ 0x101c0, 0x0 },
+	{ 0x1101c0, 0x0 },
+	{ 0x2101c0, 0x0 },
+	{ 0x102c0, 0x0 },
+	{ 0x1102c0, 0x0 },
+	{ 0x2102c0, 0x0 },
+	{ 0x103c0, 0x0 },
+	{ 0x1103c0, 0x0 },
+	{ 0x2103c0, 0x0 },
+	{ 0x104c0, 0x0 },
+	{ 0x1104c0, 0x0 },
+	{ 0x2104c0, 0x0 },
+	{ 0x105c0, 0x0 },
+	{ 0x1105c0, 0x0 },
+	{ 0x2105c0, 0x0 },
+	{ 0x106c0, 0x0 },
+	{ 0x1106c0, 0x0 },
+	{ 0x2106c0, 0x0 },
+	{ 0x107c0, 0x0 },
+	{ 0x1107c0, 0x0 },
+	{ 0x2107c0, 0x0 },
+	{ 0x108c0, 0x0 },
+	{ 0x1108c0, 0x0 },
+	{ 0x2108c0, 0x0 },
+	{ 0x110c0, 0x0 },
+	{ 0x1110c0, 0x0 },
+	{ 0x2110c0, 0x0 },
+	{ 0x111c0, 0x0 },
+	{ 0x1111c0, 0x0 },
+	{ 0x2111c0, 0x0 },
+	{ 0x112c0, 0x0 },
+	{ 0x1112c0, 0x0 },
+	{ 0x2112c0, 0x0 },
+	{ 0x113c0, 0x0 },
+	{ 0x1113c0, 0x0 },
+	{ 0x2113c0, 0x0 },
+	{ 0x114c0, 0x0 },
+	{ 0x1114c0, 0x0 },
+	{ 0x2114c0, 0x0 },
+	{ 0x115c0, 0x0 },
+	{ 0x1115c0, 0x0 },
+	{ 0x2115c0, 0x0 },
+	{ 0x116c0, 0x0 },
+	{ 0x1116c0, 0x0 },
+	{ 0x2116c0, 0x0 },
+	{ 0x117c0, 0x0 },
+	{ 0x1117c0, 0x0 },
+	{ 0x2117c0, 0x0 },
+	{ 0x118c0, 0x0 },
+	{ 0x1118c0, 0x0 },
+	{ 0x2118c0, 0x0 },
+	{ 0x120c0, 0x0 },
+	{ 0x1120c0, 0x0 },
+	{ 0x2120c0, 0x0 },
+	{ 0x121c0, 0x0 },
+	{ 0x1121c0, 0x0 },
+	{ 0x2121c0, 0x0 },
+	{ 0x122c0, 0x0 },
+	{ 0x1122c0, 0x0 },
+	{ 0x2122c0, 0x0 },
+	{ 0x123c0, 0x0 },
+	{ 0x1123c0, 0x0 },
+	{ 0x2123c0, 0x0 },
+	{ 0x124c0, 0x0 },
+	{ 0x1124c0, 0x0 },
+	{ 0x2124c0, 0x0 },
+	{ 0x125c0, 0x0 },
+	{ 0x1125c0, 0x0 },
+	{ 0x2125c0, 0x0 },
+	{ 0x126c0, 0x0 },
+	{ 0x1126c0, 0x0 },
+	{ 0x2126c0, 0x0 },
+	{ 0x127c0, 0x0 },
+	{ 0x1127c0, 0x0 },
+	{ 0x2127c0, 0x0 },
+	{ 0x128c0, 0x0 },
+	{ 0x1128c0, 0x0 },
+	{ 0x2128c0, 0x0 },
+	{ 0x130c0, 0x0 },
+	{ 0x1130c0, 0x0 },
+	{ 0x2130c0, 0x0 },
+	{ 0x131c0, 0x0 },
+	{ 0x1131c0, 0x0 },
+	{ 0x2131c0, 0x0 },
+	{ 0x132c0, 0x0 },
+	{ 0x1132c0, 0x0 },
+	{ 0x2132c0, 0x0 },
+	{ 0x133c0, 0x0 },
+	{ 0x1133c0, 0x0 },
+	{ 0x2133c0, 0x0 },
+	{ 0x134c0, 0x0 },
+	{ 0x1134c0, 0x0 },
+	{ 0x2134c0, 0x0 },
+	{ 0x135c0, 0x0 },
+	{ 0x1135c0, 0x0 },
+	{ 0x2135c0, 0x0 },
+	{ 0x136c0, 0x0 },
+	{ 0x1136c0, 0x0 },
+	{ 0x2136c0, 0x0 },
+	{ 0x137c0, 0x0 },
+	{ 0x1137c0, 0x0 },
+	{ 0x2137c0, 0x0 },
+	{ 0x138c0, 0x0 },
+	{ 0x1138c0, 0x0 },
+	{ 0x2138c0, 0x0 },
+	{ 0x100c1, 0x0 },
+	{ 0x1100c1, 0x0 },
+	{ 0x2100c1, 0x0 },
+	{ 0x101c1, 0x0 },
+	{ 0x1101c1, 0x0 },
+	{ 0x2101c1, 0x0 },
+	{ 0x102c1, 0x0 },
+	{ 0x1102c1, 0x0 },
+	{ 0x2102c1, 0x0 },
+	{ 0x103c1, 0x0 },
+	{ 0x1103c1, 0x0 },
+	{ 0x2103c1, 0x0 },
+	{ 0x104c1, 0x0 },
+	{ 0x1104c1, 0x0 },
+	{ 0x2104c1, 0x0 },
+	{ 0x105c1, 0x0 },
+	{ 0x1105c1, 0x0 },
+	{ 0x2105c1, 0x0 },
+	{ 0x106c1, 0x0 },
+	{ 0x1106c1, 0x0 },
+	{ 0x2106c1, 0x0 },
+	{ 0x107c1, 0x0 },
+	{ 0x1107c1, 0x0 },
+	{ 0x2107c1, 0x0 },
+	{ 0x108c1, 0x0 },
+	{ 0x1108c1, 0x0 },
+	{ 0x2108c1, 0x0 },
+	{ 0x110c1, 0x0 },
+	{ 0x1110c1, 0x0 },
+	{ 0x2110c1, 0x0 },
+	{ 0x111c1, 0x0 },
+	{ 0x1111c1, 0x0 },
+	{ 0x2111c1, 0x0 },
+	{ 0x112c1, 0x0 },
+	{ 0x1112c1, 0x0 },
+	{ 0x2112c1, 0x0 },
+	{ 0x113c1, 0x0 },
+	{ 0x1113c1, 0x0 },
+	{ 0x2113c1, 0x0 },
+	{ 0x114c1, 0x0 },
+	{ 0x1114c1, 0x0 },
+	{ 0x2114c1, 0x0 },
+	{ 0x115c1, 0x0 },
+	{ 0x1115c1, 0x0 },
+	{ 0x2115c1, 0x0 },
+	{ 0x116c1, 0x0 },
+	{ 0x1116c1, 0x0 },
+	{ 0x2116c1, 0x0 },
+	{ 0x117c1, 0x0 },
+	{ 0x1117c1, 0x0 },
+	{ 0x2117c1, 0x0 },
+	{ 0x118c1, 0x0 },
+	{ 0x1118c1, 0x0 },
+	{ 0x2118c1, 0x0 },
+	{ 0x120c1, 0x0 },
+	{ 0x1120c1, 0x0 },
+	{ 0x2120c1, 0x0 },
+	{ 0x121c1, 0x0 },
+	{ 0x1121c1, 0x0 },
+	{ 0x2121c1, 0x0 },
+	{ 0x122c1, 0x0 },
+	{ 0x1122c1, 0x0 },
+	{ 0x2122c1, 0x0 },
+	{ 0x123c1, 0x0 },
+	{ 0x1123c1, 0x0 },
+	{ 0x2123c1, 0x0 },
+	{ 0x124c1, 0x0 },
+	{ 0x1124c1, 0x0 },
+	{ 0x2124c1, 0x0 },
+	{ 0x125c1, 0x0 },
+	{ 0x1125c1, 0x0 },
+	{ 0x2125c1, 0x0 },
+	{ 0x126c1, 0x0 },
+	{ 0x1126c1, 0x0 },
+	{ 0x2126c1, 0x0 },
+	{ 0x127c1, 0x0 },
+	{ 0x1127c1, 0x0 },
+	{ 0x2127c1, 0x0 },
+	{ 0x128c1, 0x0 },
+	{ 0x1128c1, 0x0 },
+	{ 0x2128c1, 0x0 },
+	{ 0x130c1, 0x0 },
+	{ 0x1130c1, 0x0 },
+	{ 0x2130c1, 0x0 },
+	{ 0x131c1, 0x0 },
+	{ 0x1131c1, 0x0 },
+	{ 0x2131c1, 0x0 },
+	{ 0x132c1, 0x0 },
+	{ 0x1132c1, 0x0 },
+	{ 0x2132c1, 0x0 },
+	{ 0x133c1, 0x0 },
+	{ 0x1133c1, 0x0 },
+	{ 0x2133c1, 0x0 },
+	{ 0x134c1, 0x0 },
+	{ 0x1134c1, 0x0 },
+	{ 0x2134c1, 0x0 },
+	{ 0x135c1, 0x0 },
+	{ 0x1135c1, 0x0 },
+	{ 0x2135c1, 0x0 },
+	{ 0x136c1, 0x0 },
+	{ 0x1136c1, 0x0 },
+	{ 0x2136c1, 0x0 },
+	{ 0x137c1, 0x0 },
+	{ 0x1137c1, 0x0 },
+	{ 0x2137c1, 0x0 },
+	{ 0x138c1, 0x0 },
+	{ 0x1138c1, 0x0 },
+	{ 0x2138c1, 0x0 },
+	{ 0x10020, 0x0 },
+	{ 0x110020, 0x0 },
+	{ 0x210020, 0x0 },
+	{ 0x11020, 0x0 },
+	{ 0x111020, 0x0 },
+	{ 0x211020, 0x0 },
+	{ 0x12020, 0x0 },
+	{ 0x112020, 0x0 },
+	{ 0x212020, 0x0 },
+	{ 0x13020, 0x0 },
+	{ 0x113020, 0x0 },
+	{ 0x213020, 0x0 },
+	{ 0x20072, 0x0 },
+	{ 0x20073, 0x0 },
+	{ 0x20074, 0x0 },
+	{ 0x100aa, 0x0 },
+	{ 0x110aa, 0x0 },
+	{ 0x120aa, 0x0 },
+	{ 0x130aa, 0x0 },
+	{ 0x20010, 0x0 },
+	{ 0x120010, 0x0 },
+	{ 0x220010, 0x0 },
+	{ 0x20011, 0x0 },
+	{ 0x120011, 0x0 },
+	{ 0x220011, 0x0 },
+	{ 0x100ae, 0x0 },
+	{ 0x1100ae, 0x0 },
+	{ 0x2100ae, 0x0 },
+	{ 0x100af, 0x0 },
+	{ 0x1100af, 0x0 },
+	{ 0x2100af, 0x0 },
+	{ 0x110ae, 0x0 },
+	{ 0x1110ae, 0x0 },
+	{ 0x2110ae, 0x0 },
+	{ 0x110af, 0x0 },
+	{ 0x1110af, 0x0 },
+	{ 0x2110af, 0x0 },
+	{ 0x120ae, 0x0 },
+	{ 0x1120ae, 0x0 },
+	{ 0x2120ae, 0x0 },
+	{ 0x120af, 0x0 },
+	{ 0x1120af, 0x0 },
+	{ 0x2120af, 0x0 },
+	{ 0x130ae, 0x0 },
+	{ 0x1130ae, 0x0 },
+	{ 0x2130ae, 0x0 },
+	{ 0x130af, 0x0 },
+	{ 0x1130af, 0x0 },
+	{ 0x2130af, 0x0 },
+	{ 0x20020, 0x0 },
+	{ 0x120020, 0x0 },
+	{ 0x220020, 0x0 },
+	{ 0x100a0, 0x0 },
+	{ 0x100a1, 0x0 },
+	{ 0x100a2, 0x0 },
+	{ 0x100a3, 0x0 },
+	{ 0x100a4, 0x0 },
+	{ 0x100a5, 0x0 },
+	{ 0x100a6, 0x0 },
+	{ 0x100a7, 0x0 },
+	{ 0x110a0, 0x0 },
+	{ 0x110a1, 0x0 },
+	{ 0x110a2, 0x0 },
+	{ 0x110a3, 0x0 },
+	{ 0x110a4, 0x0 },
+	{ 0x110a5, 0x0 },
+	{ 0x110a6, 0x0 },
+	{ 0x110a7, 0x0 },
+	{ 0x120a0, 0x0 },
+	{ 0x120a1, 0x0 },
+	{ 0x120a2, 0x0 },
+	{ 0x120a3, 0x0 },
+	{ 0x120a4, 0x0 },
+	{ 0x120a5, 0x0 },
+	{ 0x120a6, 0x0 },
+	{ 0x120a7, 0x0 },
+	{ 0x130a0, 0x0 },
+	{ 0x130a1, 0x0 },
+	{ 0x130a2, 0x0 },
+	{ 0x130a3, 0x0 },
+	{ 0x130a4, 0x0 },
+	{ 0x130a5, 0x0 },
+	{ 0x130a6, 0x0 },
+	{ 0x130a7, 0x0 },
+	{ 0x2007c, 0x0 },
+	{ 0x12007c, 0x0 },
+	{ 0x22007c, 0x0 },
+	{ 0x2007d, 0x0 },
+	{ 0x12007d, 0x0 },
+	{ 0x22007d, 0x0 },
+	{ 0x400fd, 0x0 },
+	{ 0x400c0, 0x0 },
+	{ 0x90201, 0x0 },
+	{ 0x190201, 0x0 },
+	{ 0x290201, 0x0 },
+	{ 0x90202, 0x0 },
+	{ 0x190202, 0x0 },
+	{ 0x290202, 0x0 },
+	{ 0x90203, 0x0 },
+	{ 0x190203, 0x0 },
+	{ 0x290203, 0x0 },
+	{ 0x90204, 0x0 },
+	{ 0x190204, 0x0 },
+	{ 0x290204, 0x0 },
+	{ 0x90205, 0x0 },
+	{ 0x190205, 0x0 },
+	{ 0x290205, 0x0 },
+	{ 0x90206, 0x0 },
+	{ 0x190206, 0x0 },
+	{ 0x290206, 0x0 },
+	{ 0x90207, 0x0 },
+	{ 0x190207, 0x0 },
+	{ 0x290207, 0x0 },
+	{ 0x90208, 0x0 },
+	{ 0x190208, 0x0 },
+	{ 0x290208, 0x0 },
+	{ 0x10062, 0x0 },
+	{ 0x10162, 0x0 },
+	{ 0x10262, 0x0 },
+	{ 0x10362, 0x0 },
+	{ 0x10462, 0x0 },
+	{ 0x10562, 0x0 },
+	{ 0x10662, 0x0 },
+	{ 0x10762, 0x0 },
+	{ 0x10862, 0x0 },
+	{ 0x11062, 0x0 },
+	{ 0x11162, 0x0 },
+	{ 0x11262, 0x0 },
+	{ 0x11362, 0x0 },
+	{ 0x11462, 0x0 },
+	{ 0x11562, 0x0 },
+	{ 0x11662, 0x0 },
+	{ 0x11762, 0x0 },
+	{ 0x11862, 0x0 },
+	{ 0x12062, 0x0 },
+	{ 0x12162, 0x0 },
+	{ 0x12262, 0x0 },
+	{ 0x12362, 0x0 },
+	{ 0x12462, 0x0 },
+	{ 0x12562, 0x0 },
+	{ 0x12662, 0x0 },
+	{ 0x12762, 0x0 },
+	{ 0x12862, 0x0 },
+	{ 0x13062, 0x0 },
+	{ 0x13162, 0x0 },
+	{ 0x13262, 0x0 },
+	{ 0x13362, 0x0 },
+	{ 0x13462, 0x0 },
+	{ 0x13562, 0x0 },
+	{ 0x13662, 0x0 },
+	{ 0x13762, 0x0 },
+	{ 0x13862, 0x0 },
+	{ 0x20077, 0x0 },
+	{ 0x10001, 0x0 },
+	{ 0x11001, 0x0 },
+	{ 0x12001, 0x0 },
+	{ 0x13001, 0x0 },
+	{ 0x10040, 0x0 },
+	{ 0x10140, 0x0 },
+	{ 0x10240, 0x0 },
+	{ 0x10340, 0x0 },
+	{ 0x10440, 0x0 },
+	{ 0x10540, 0x0 },
+	{ 0x10640, 0x0 },
+	{ 0x10740, 0x0 },
+	{ 0x10840, 0x0 },
+	{ 0x10030, 0x0 },
+	{ 0x10130, 0x0 },
+	{ 0x10230, 0x0 },
+	{ 0x10330, 0x0 },
+	{ 0x10430, 0x0 },
+	{ 0x10530, 0x0 },
+	{ 0x10630, 0x0 },
+	{ 0x10730, 0x0 },
+	{ 0x10830, 0x0 },
+	{ 0x11040, 0x0 },
+	{ 0x11140, 0x0 },
+	{ 0x11240, 0x0 },
+	{ 0x11340, 0x0 },
+	{ 0x11440, 0x0 },
+	{ 0x11540, 0x0 },
+	{ 0x11640, 0x0 },
+	{ 0x11740, 0x0 },
+	{ 0x11840, 0x0 },
+	{ 0x11030, 0x0 },
+	{ 0x11130, 0x0 },
+	{ 0x11230, 0x0 },
+	{ 0x11330, 0x0 },
+	{ 0x11430, 0x0 },
+	{ 0x11530, 0x0 },
+	{ 0x11630, 0x0 },
+	{ 0x11730, 0x0 },
+	{ 0x11830, 0x0 },
+	{ 0x12040, 0x0 },
+	{ 0x12140, 0x0 },
+	{ 0x12240, 0x0 },
+	{ 0x12340, 0x0 },
+	{ 0x12440, 0x0 },
+	{ 0x12540, 0x0 },
+	{ 0x12640, 0x0 },
+	{ 0x12740, 0x0 },
+	{ 0x12840, 0x0 },
+	{ 0x12030, 0x0 },
+	{ 0x12130, 0x0 },
+	{ 0x12230, 0x0 },
+	{ 0x12330, 0x0 },
+	{ 0x12430, 0x0 },
+	{ 0x12530, 0x0 },
+	{ 0x12630, 0x0 },
+	{ 0x12730, 0x0 },
+	{ 0x12830, 0x0 },
+	{ 0x13040, 0x0 },
+	{ 0x13140, 0x0 },
+	{ 0x13240, 0x0 },
+	{ 0x13340, 0x0 },
+	{ 0x13440, 0x0 },
+	{ 0x13540, 0x0 },
+	{ 0x13640, 0x0 },
+	{ 0x13740, 0x0 },
+	{ 0x13840, 0x0 },
+	{ 0x13030, 0x0 },
+	{ 0x13130, 0x0 },
+	{ 0x13230, 0x0 },
+	{ 0x13330, 0x0 },
+	{ 0x13430, 0x0 },
+	{ 0x13530, 0x0 },
+	{ 0x13630, 0x0 },
+	{ 0x13730, 0x0 },
+	{ 0x13830, 0x0 },
+
+};
+
+/* P0 message block parameter for training firmware */
+struct dram_cfg_param ddr_fsp0_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54003, 0xe94 },
+	{ 0x54004, 0x4 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x15 },
+	{ 0x54008, 0x131f },
+	{ 0x54009, 0xff },
+	{ 0x5400b, 0x4 },
+	{ 0x5400c, 0x1 },
+	{ 0x5400d, 0x100 },
+	{ 0x5400f, 0x100 },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x36e4 },
+	{ 0x5401a, 0x32 },
+	{ 0x5401b, 0x1146 },
+	{ 0x5401c, 0x1108 },
+	{ 0x5401e, 0x6 },
+	{ 0x5401f, 0x36e4 },
+	{ 0x54020, 0x32 },
+	{ 0x54021, 0x1146 },
+	{ 0x54022, 0x1108 },
+	{ 0x54024, 0x6 },
+	{ 0x54032, 0xe400 },
+	{ 0x54033, 0x3236 },
+	{ 0x54034, 0x4600 },
+	{ 0x54035, 0x811 },
+	{ 0x54036, 0x11 },
+	{ 0x54037, 0x600 },
+	{ 0x54038, 0xe400 },
+	{ 0x54039, 0x3236 },
+	{ 0x5403a, 0x4600 },
+	{ 0x5403b, 0x811 },
+	{ 0x5403c, 0x11 },
+	{ 0x5403d, 0x600 },
+	{ 0xd0000, 0x1}
+};
+
+/* P0 2D message block parameter for training firmware */
+struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54003, 0xe94 },
+	{ 0x54004, 0x4 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x15 },
+	{ 0x54008, 0x61 },
+	{ 0x54009, 0xff },
+	{ 0x5400b, 0x4 },
+	{ 0x5400c, 0x1 },
+	{ 0x5400d, 0x100 },
+	{ 0x5400f, 0x100 },
+	{ 0x54010, 0x2080 },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x36e4 },
+	{ 0x5401a, 0x32 },
+	{ 0x5401b, 0x1146 },
+	{ 0x5401c, 0x1108 },
+	{ 0x5401e, 0x6 },
+	{ 0x5401f, 0x36e4 },
+	{ 0x54020, 0x32 },
+	{ 0x54021, 0x1146 },
+	{ 0x54022, 0x1108 },
+	{ 0x54024, 0x6 },
+	{ 0x54032, 0xe400 },
+	{ 0x54033, 0x3236 },
+	{ 0x54034, 0x4600 },
+	{ 0x54035, 0x811 },
+	{ 0x54036, 0x11 },
+	{ 0x54037, 0x600 },
+	{ 0x54038, 0xe400 },
+	{ 0x54039, 0x3236 },
+	{ 0x5403a, 0x4600 },
+	{ 0x5403b, 0x811 },
+	{ 0x5403c, 0x11 },
+	{ 0x5403d, 0x600 },
+	{ 0xd0000, 0x1}
+};
+
+/* DRAM PHY init engine image */
+struct dram_cfg_param ddr_phy_pie[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x90000, 0x10 },
+	{ 0x90001, 0x400 },
+	{ 0x90002, 0x10e },
+	{ 0x90003, 0x0 },
+	{ 0x90004, 0x0 },
+	{ 0x90005, 0x8 },
+	{ 0x90029, 0xb },
+	{ 0x9002a, 0x480 },
+	{ 0x9002b, 0x109 },
+	{ 0x9002c, 0x8 },
+	{ 0x9002d, 0x448 },
+	{ 0x9002e, 0x139 },
+	{ 0x9002f, 0x8 },
+	{ 0x90030, 0x478 },
+	{ 0x90031, 0x109 },
+	{ 0x90032, 0x0 },
+	{ 0x90033, 0xe8 },
+	{ 0x90034, 0x109 },
+	{ 0x90035, 0x2 },
+	{ 0x90036, 0x10 },
+	{ 0x90037, 0x139 },
+	{ 0x90038, 0xb },
+	{ 0x90039, 0x7c0 },
+	{ 0x9003a, 0x139 },
+	{ 0x9003b, 0x44 },
+	{ 0x9003c, 0x633 },
+	{ 0x9003d, 0x159 },
+	{ 0x9003e, 0x14f },
+	{ 0x9003f, 0x630 },
+	{ 0x90040, 0x159 },
+	{ 0x90041, 0x47 },
+	{ 0x90042, 0x633 },
+	{ 0x90043, 0x149 },
+	{ 0x90044, 0x4f },
+	{ 0x90045, 0x633 },
+	{ 0x90046, 0x179 },
+	{ 0x90047, 0x8 },
+	{ 0x90048, 0xe0 },
+	{ 0x90049, 0x109 },
+	{ 0x9004a, 0x0 },
+	{ 0x9004b, 0x7c8 },
+	{ 0x9004c, 0x109 },
+	{ 0x9004d, 0x0 },
+	{ 0x9004e, 0x1 },
+	{ 0x9004f, 0x8 },
+	{ 0x90050, 0x30 },
+	{ 0x90051, 0x65a },
+	{ 0x90052, 0x9 },
+	{ 0x90053, 0x0 },
+	{ 0x90054, 0x45a },
+	{ 0x90055, 0x9 },
+	{ 0x90056, 0x0 },
+	{ 0x90057, 0x448 },
+	{ 0x90058, 0x109 },
+	{ 0x90059, 0x40 },
+	{ 0x9005a, 0x633 },
+	{ 0x9005b, 0x179 },
+	{ 0x9005c, 0x1 },
+	{ 0x9005d, 0x618 },
+	{ 0x9005e, 0x109 },
+	{ 0x9005f, 0x40c0 },
+	{ 0x90060, 0x633 },
+	{ 0x90061, 0x149 },
+	{ 0x90062, 0x8 },
+	{ 0x90063, 0x4 },
+	{ 0x90064, 0x48 },
+	{ 0x90065, 0x4040 },
+	{ 0x90066, 0x633 },
+	{ 0x90067, 0x149 },
+	{ 0x90068, 0x0 },
+	{ 0x90069, 0x4 },
+	{ 0x9006a, 0x48 },
+	{ 0x9006b, 0x40 },
+	{ 0x9006c, 0x633 },
+	{ 0x9006d, 0x149 },
+	{ 0x9006e, 0x0 },
+	{ 0x9006f, 0x658 },
+	{ 0x90070, 0x109 },
+	{ 0x90071, 0x10 },
+	{ 0x90072, 0x4 },
+	{ 0x90073, 0x18 },
+	{ 0x90074, 0x0 },
+	{ 0x90075, 0x4 },
+	{ 0x90076, 0x78 },
+	{ 0x90077, 0x549 },
+	{ 0x90078, 0x633 },
+	{ 0x90079, 0x159 },
+	{ 0x9007a, 0xd49 },
+	{ 0x9007b, 0x633 },
+	{ 0x9007c, 0x159 },
+	{ 0x9007d, 0x94a },
+	{ 0x9007e, 0x633 },
+	{ 0x9007f, 0x159 },
+	{ 0x90080, 0x441 },
+	{ 0x90081, 0x633 },
+	{ 0x90082, 0x149 },
+	{ 0x90083, 0x42 },
+	{ 0x90084, 0x633 },
+	{ 0x90085, 0x149 },
+	{ 0x90086, 0x1 },
+	{ 0x90087, 0x633 },
+	{ 0x90088, 0x149 },
+	{ 0x90089, 0x0 },
+	{ 0x9008a, 0xe0 },
+	{ 0x9008b, 0x109 },
+	{ 0x9008c, 0xa },
+	{ 0x9008d, 0x10 },
+	{ 0x9008e, 0x109 },
+	{ 0x9008f, 0x9 },
+	{ 0x90090, 0x3c0 },
+	{ 0x90091, 0x149 },
+	{ 0x90092, 0x9 },
+	{ 0x90093, 0x3c0 },
+	{ 0x90094, 0x159 },
+	{ 0x90095, 0x18 },
+	{ 0x90096, 0x10 },
+	{ 0x90097, 0x109 },
+	{ 0x90098, 0x0 },
+	{ 0x90099, 0x3c0 },
+	{ 0x9009a, 0x109 },
+	{ 0x9009b, 0x18 },
+	{ 0x9009c, 0x4 },
+	{ 0x9009d, 0x48 },
+	{ 0x9009e, 0x18 },
+	{ 0x9009f, 0x4 },
+	{ 0x900a0, 0x58 },
+	{ 0x900a1, 0xb },
+	{ 0x900a2, 0x10 },
+	{ 0x900a3, 0x109 },
+	{ 0x900a4, 0x1 },
+	{ 0x900a5, 0x10 },
+	{ 0x900a6, 0x109 },
+	{ 0x900a7, 0x5 },
+	{ 0x900a8, 0x7c0 },
+	{ 0x900a9, 0x109 },
+	{ 0x40000, 0x811 },
+	{ 0x40020, 0x880 },
+	{ 0x40040, 0x0 },
+	{ 0x40060, 0x0 },
+	{ 0x40001, 0x4008 },
+	{ 0x40021, 0x83 },
+	{ 0x40041, 0x4f },
+	{ 0x40061, 0x0 },
+	{ 0x40002, 0x4040 },
+	{ 0x40022, 0x83 },
+	{ 0x40042, 0x51 },
+	{ 0x40062, 0x0 },
+	{ 0x40003, 0x811 },
+	{ 0x40023, 0x880 },
+	{ 0x40043, 0x0 },
+	{ 0x40063, 0x0 },
+	{ 0x40004, 0x720 },
+	{ 0x40024, 0xf },
+	{ 0x40044, 0x1740 },
+	{ 0x40064, 0x0 },
+	{ 0x40005, 0x16 },
+	{ 0x40025, 0x83 },
+	{ 0x40045, 0x4b },
+	{ 0x40065, 0x0 },
+	{ 0x40006, 0x716 },
+	{ 0x40026, 0xf },
+	{ 0x40046, 0x2001 },
+	{ 0x40066, 0x0 },
+	{ 0x40007, 0x716 },
+	{ 0x40027, 0xf },
+	{ 0x40047, 0x2800 },
+	{ 0x40067, 0x0 },
+	{ 0x40008, 0x716 },
+	{ 0x40028, 0xf },
+	{ 0x40048, 0xf00 },
+	{ 0x40068, 0x0 },
+	{ 0x40009, 0x720 },
+	{ 0x40029, 0xf },
+	{ 0x40049, 0x1400 },
+	{ 0x40069, 0x0 },
+	{ 0x4000a, 0xe08 },
+	{ 0x4002a, 0xc15 },
+	{ 0x4004a, 0x0 },
+	{ 0x4006a, 0x0 },
+	{ 0x4000b, 0x625 },
+	{ 0x4002b, 0x15 },
+	{ 0x4004b, 0x0 },
+	{ 0x4006b, 0x0 },
+	{ 0x4000c, 0x4028 },
+	{ 0x4002c, 0x80 },
+	{ 0x4004c, 0x0 },
+	{ 0x4006c, 0x0 },
+	{ 0x4000d, 0xe08 },
+	{ 0x4002d, 0xc1a },
+	{ 0x4004d, 0x0 },
+	{ 0x4006d, 0x0 },
+	{ 0x4000e, 0x625 },
+	{ 0x4002e, 0x1a },
+	{ 0x4004e, 0x0 },
+	{ 0x4006e, 0x0 },
+	{ 0x4000f, 0x4040 },
+	{ 0x4002f, 0x80 },
+	{ 0x4004f, 0x0 },
+	{ 0x4006f, 0x0 },
+	{ 0x40010, 0x2604 },
+	{ 0x40030, 0x15 },
+	{ 0x40050, 0x0 },
+	{ 0x40070, 0x0 },
+	{ 0x40011, 0x708 },
+	{ 0x40031, 0x5 },
+	{ 0x40051, 0x0 },
+	{ 0x40071, 0x2002 },
+	{ 0x40012, 0x8 },
+	{ 0x40032, 0x80 },
+	{ 0x40052, 0x0 },
+	{ 0x40072, 0x0 },
+	{ 0x40013, 0x2604 },
+	{ 0x40033, 0x1a },
+	{ 0x40053, 0x0 },
+	{ 0x40073, 0x0 },
+	{ 0x40014, 0x708 },
+	{ 0x40034, 0xa },
+	{ 0x40054, 0x0 },
+	{ 0x40074, 0x2002 },
+	{ 0x40015, 0x4040 },
+	{ 0x40035, 0x80 },
+	{ 0x40055, 0x0 },
+	{ 0x40075, 0x0 },
+	{ 0x40016, 0x60a },
+	{ 0x40036, 0x15 },
+	{ 0x40056, 0x1200 },
+	{ 0x40076, 0x0 },
+	{ 0x40017, 0x61a },
+	{ 0x40037, 0x15 },
+	{ 0x40057, 0x1300 },
+	{ 0x40077, 0x0 },
+	{ 0x40018, 0x60a },
+	{ 0x40038, 0x1a },
+	{ 0x40058, 0x1200 },
+	{ 0x40078, 0x0 },
+	{ 0x40019, 0x642 },
+	{ 0x40039, 0x1a },
+	{ 0x40059, 0x1300 },
+	{ 0x40079, 0x0 },
+	{ 0x4001a, 0x4808 },
+	{ 0x4003a, 0x880 },
+	{ 0x4005a, 0x0 },
+	{ 0x4007a, 0x0 },
+	{ 0x900aa, 0x0 },
+	{ 0x900ab, 0x790 },
+	{ 0x900ac, 0x11a },
+	{ 0x900ad, 0x8 },
+	{ 0x900ae, 0x7aa },
+	{ 0x900af, 0x2a },
+	{ 0x900b0, 0x10 },
+	{ 0x900b1, 0x7b2 },
+	{ 0x900b2, 0x2a },
+	{ 0x900b3, 0x0 },
+	{ 0x900b4, 0x7c8 },
+	{ 0x900b5, 0x109 },
+	{ 0x900b6, 0x10 },
+	{ 0x900b7, 0x10 },
+	{ 0x900b8, 0x109 },
+	{ 0x900b9, 0x10 },
+	{ 0x900ba, 0x2a8 },
+	{ 0x900bb, 0x129 },
+	{ 0x900bc, 0x8 },
+	{ 0x900bd, 0x370 },
+	{ 0x900be, 0x129 },
+	{ 0x900bf, 0xa },
+	{ 0x900c0, 0x3c8 },
+	{ 0x900c1, 0x1a9 },
+	{ 0x900c2, 0xc },
+	{ 0x900c3, 0x408 },
+	{ 0x900c4, 0x199 },
+	{ 0x900c5, 0x14 },
+	{ 0x900c6, 0x790 },
+	{ 0x900c7, 0x11a },
+	{ 0x900c8, 0x8 },
+	{ 0x900c9, 0x4 },
+	{ 0x900ca, 0x18 },
+	{ 0x900cb, 0xe },
+	{ 0x900cc, 0x408 },
+	{ 0x900cd, 0x199 },
+	{ 0x900ce, 0x8 },
+	{ 0x900cf, 0x8568 },
+	{ 0x900d0, 0x108 },
+	{ 0x900d1, 0x18 },
+	{ 0x900d2, 0x790 },
+	{ 0x900d3, 0x16a },
+	{ 0x900d4, 0x8 },
+	{ 0x900d5, 0x1d8 },
+	{ 0x900d6, 0x169 },
+	{ 0x900d7, 0x10 },
+	{ 0x900d8, 0x8558 },
+	{ 0x900d9, 0x168 },
+	{ 0x900da, 0x1ff8 },
+	{ 0x900db, 0x85a8 },
+	{ 0x900dc, 0x1e8 },
+	{ 0x900dd, 0x50 },
+	{ 0x900de, 0x798 },
+	{ 0x900df, 0x16a },
+	{ 0x900e0, 0x60 },
+	{ 0x900e1, 0x7a0 },
+	{ 0x900e2, 0x16a },
+	{ 0x900e3, 0x8 },
+	{ 0x900e4, 0x8310 },
+	{ 0x900e5, 0x168 },
+	{ 0x900e6, 0x8 },
+	{ 0x900e7, 0xa310 },
+	{ 0x900e8, 0x168 },
+	{ 0x900e9, 0xa },
+	{ 0x900ea, 0x408 },
+	{ 0x900eb, 0x169 },
+	{ 0x900ec, 0x6e },
+	{ 0x900ed, 0x0 },
+	{ 0x900ee, 0x68 },
+	{ 0x900ef, 0x0 },
+	{ 0x900f0, 0x408 },
+	{ 0x900f1, 0x169 },
+	{ 0x900f2, 0x0 },
+	{ 0x900f3, 0x8310 },
+	{ 0x900f4, 0x168 },
+	{ 0x900f5, 0x0 },
+	{ 0x900f6, 0xa310 },
+	{ 0x900f7, 0x168 },
+	{ 0x900f8, 0x1ff8 },
+	{ 0x900f9, 0x85a8 },
+	{ 0x900fa, 0x1e8 },
+	{ 0x900fb, 0x68 },
+	{ 0x900fc, 0x798 },
+	{ 0x900fd, 0x16a },
+	{ 0x900fe, 0x78 },
+	{ 0x900ff, 0x7a0 },
+	{ 0x90100, 0x16a },
+	{ 0x90101, 0x68 },
+	{ 0x90102, 0x790 },
+	{ 0x90103, 0x16a },
+	{ 0x90104, 0x8 },
+	{ 0x90105, 0x8b10 },
+	{ 0x90106, 0x168 },
+	{ 0x90107, 0x8 },
+	{ 0x90108, 0xab10 },
+	{ 0x90109, 0x168 },
+	{ 0x9010a, 0xa },
+	{ 0x9010b, 0x408 },
+	{ 0x9010c, 0x169 },
+	{ 0x9010d, 0x58 },
+	{ 0x9010e, 0x0 },
+	{ 0x9010f, 0x68 },
+	{ 0x90110, 0x0 },
+	{ 0x90111, 0x408 },
+	{ 0x90112, 0x169 },
+	{ 0x90113, 0x0 },
+	{ 0x90114, 0x8b10 },
+	{ 0x90115, 0x168 },
+	{ 0x90116, 0x1 },
+	{ 0x90117, 0xab10 },
+	{ 0x90118, 0x168 },
+	{ 0x90119, 0x0 },
+	{ 0x9011a, 0x1d8 },
+	{ 0x9011b, 0x169 },
+	{ 0x9011c, 0x80 },
+	{ 0x9011d, 0x790 },
+	{ 0x9011e, 0x16a },
+	{ 0x9011f, 0x18 },
+	{ 0x90120, 0x7aa },
+	{ 0x90121, 0x6a },
+	{ 0x90122, 0xa },
+	{ 0x90123, 0x0 },
+	{ 0x90124, 0x1e9 },
+	{ 0x90125, 0x8 },
+	{ 0x90126, 0x8080 },
+	{ 0x90127, 0x108 },
+	{ 0x90128, 0xf },
+	{ 0x90129, 0x408 },
+	{ 0x9012a, 0x169 },
+	{ 0x9012b, 0xc },
+	{ 0x9012c, 0x0 },
+	{ 0x9012d, 0x68 },
+	{ 0x9012e, 0x9 },
+	{ 0x9012f, 0x0 },
+	{ 0x90130, 0x1a9 },
+	{ 0x90131, 0x0 },
+	{ 0x90132, 0x408 },
+	{ 0x90133, 0x169 },
+	{ 0x90134, 0x0 },
+	{ 0x90135, 0x8080 },
+	{ 0x90136, 0x108 },
+	{ 0x90137, 0x8 },
+	{ 0x90138, 0x7aa },
+	{ 0x90139, 0x6a },
+	{ 0x9013a, 0x0 },
+	{ 0x9013b, 0x8568 },
+	{ 0x9013c, 0x108 },
+	{ 0x9013d, 0xb7 },
+	{ 0x9013e, 0x790 },
+	{ 0x9013f, 0x16a },
+	{ 0x90140, 0x1f },
+	{ 0x90141, 0x0 },
+	{ 0x90142, 0x68 },
+	{ 0x90143, 0x8 },
+	{ 0x90144, 0x8558 },
+	{ 0x90145, 0x168 },
+	{ 0x90146, 0xf },
+	{ 0x90147, 0x408 },
+	{ 0x90148, 0x169 },
+	{ 0x90149, 0xd },
+	{ 0x9014a, 0x0 },
+	{ 0x9014b, 0x68 },
+	{ 0x9014c, 0x0 },
+	{ 0x9014d, 0x408 },
+	{ 0x9014e, 0x169 },
+	{ 0x9014f, 0x0 },
+	{ 0x90150, 0x8558 },
+	{ 0x90151, 0x168 },
+	{ 0x90152, 0x8 },
+	{ 0x90153, 0x3c8 },
+	{ 0x90154, 0x1a9 },
+	{ 0x90155, 0x3 },
+	{ 0x90156, 0x370 },
+	{ 0x90157, 0x129 },
+	{ 0x90158, 0x20 },
+	{ 0x90159, 0x2aa },
+	{ 0x9015a, 0x9 },
+	{ 0x9015b, 0x8 },
+	{ 0x9015c, 0xe8 },
+	{ 0x9015d, 0x109 },
+	{ 0x9015e, 0x0 },
+	{ 0x9015f, 0x8140 },
+	{ 0x90160, 0x10c },
+	{ 0x90161, 0x10 },
+	{ 0x90162, 0x8138 },
+	{ 0x90163, 0x104 },
+	{ 0x90164, 0x8 },
+	{ 0x90165, 0x448 },
+	{ 0x90166, 0x109 },
+	{ 0x90167, 0xf },
+	{ 0x90168, 0x7c0 },
+	{ 0x90169, 0x109 },
+	{ 0x9016a, 0x0 },
+	{ 0x9016b, 0xe8 },
+	{ 0x9016c, 0x109 },
+	{ 0x9016d, 0x47 },
+	{ 0x9016e, 0x630 },
+	{ 0x9016f, 0x109 },
+	{ 0x90170, 0x8 },
+	{ 0x90171, 0x618 },
+	{ 0x90172, 0x109 },
+	{ 0x90173, 0x8 },
+	{ 0x90174, 0xe0 },
+	{ 0x90175, 0x109 },
+	{ 0x90176, 0x0 },
+	{ 0x90177, 0x7c8 },
+	{ 0x90178, 0x109 },
+	{ 0x90179, 0x8 },
+	{ 0x9017a, 0x8140 },
+	{ 0x9017b, 0x10c },
+	{ 0x9017c, 0x0 },
+	{ 0x9017d, 0x478 },
+	{ 0x9017e, 0x109 },
+	{ 0x9017f, 0x0 },
+	{ 0x90180, 0x1 },
+	{ 0x90181, 0x8 },
+	{ 0x90182, 0x8 },
+	{ 0x90183, 0x4 },
+	{ 0x90184, 0x0 },
+	{ 0x90006, 0x8 },
+	{ 0x90007, 0x7c8 },
+	{ 0x90008, 0x109 },
+	{ 0x90009, 0x0 },
+	{ 0x9000a, 0x400 },
+	{ 0x9000b, 0x106 },
+	{ 0xd00e7, 0x400 },
+	{ 0x90017, 0x0 },
+	{ 0x9001f, 0x2b },
+	{ 0x90026, 0x69 },
+	{ 0x400d0, 0x0 },
+	{ 0x400d1, 0x101 },
+	{ 0x400d2, 0x105 },
+	{ 0x400d3, 0x107 },
+	{ 0x400d4, 0x10f },
+	{ 0x400d5, 0x202 },
+	{ 0x400d6, 0x20a },
+	{ 0x400d7, 0x20b },
+	{ 0x2003a, 0x2 },
+	{ 0x200be, 0x3 },
+	{ 0x2000b, 0x75 },
+	{ 0x2000c, 0xe9 },
+	{ 0x2000d, 0x91c },
+	{ 0x2000e, 0x2c },
+	{ 0x9000c, 0x0 },
+	{ 0x9000d, 0x173 },
+	{ 0x9000e, 0x60 },
+	{ 0x9000f, 0x6110 },
+	{ 0x90010, 0x2152 },
+	{ 0x90011, 0xdfbd },
+	{ 0x90012, 0x2060 },
+	{ 0x90013, 0x6152 },
+	{ 0x20010, 0x5a },
+	{ 0x20011, 0x3 },
+	{ 0x40080, 0xe0 },
+	{ 0x40081, 0x12 },
+	{ 0x40082, 0xe0 },
+	{ 0x40083, 0x12 },
+	{ 0x40084, 0xe0 },
+	{ 0x40085, 0x12 },
+	{ 0x400fd, 0xf },
+	{ 0x400f1, 0xe },
+	{ 0x10011, 0x1 },
+	{ 0x10012, 0x1 },
+	{ 0x10013, 0x180 },
+	{ 0x10018, 0x1 },
+	{ 0x10002, 0x6209 },
+	{ 0x100b2, 0x1 },
+	{ 0x101b4, 0x1 },
+	{ 0x102b4, 0x1 },
+	{ 0x103b4, 0x1 },
+	{ 0x104b4, 0x1 },
+	{ 0x105b4, 0x1 },
+	{ 0x106b4, 0x1 },
+	{ 0x107b4, 0x1 },
+	{ 0x108b4, 0x1 },
+	{ 0x11011, 0x1 },
+	{ 0x11012, 0x1 },
+	{ 0x11013, 0x180 },
+	{ 0x11018, 0x1 },
+	{ 0x11002, 0x6209 },
+	{ 0x110b2, 0x1 },
+	{ 0x111b4, 0x1 },
+	{ 0x112b4, 0x1 },
+	{ 0x113b4, 0x1 },
+	{ 0x114b4, 0x1 },
+	{ 0x115b4, 0x1 },
+	{ 0x116b4, 0x1 },
+	{ 0x117b4, 0x1 },
+	{ 0x118b4, 0x1 },
+	{ 0x20089, 0x1 },
+	{ 0x20088, 0x19 },
+	{ 0xc0080, 0x0 },
+	{ 0xd0000, 0x1 },
+};
+
+struct dram_fsp_msg ddr_dram_fsp_msg[] = {
+	{
+		/* P0 3733mts 1D */
+		.drate = 3733,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
+	},
+	{
+		/* P0 3733mts 2D */
+		.drate = 3733,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = ddr_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
+	},
+};
+
+/* ddr timing config params */
+struct dram_timing_info dram_timing = {
+	.ddrc_cfg = ddr_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
+	.ddrphy_cfg = ddr_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
+	.fsp_msg = ddr_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
+	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
+	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
+	.ddrphy_pie = ddr_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
+	.fsp_table = { 3733, },
+};
+
diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
new file mode 100644
index 00000000000..85f56652ffa
--- /dev/null
+++ b/board/variscite/imx93_var_som/spl.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 NXP
+ * Copyright 2023 Variscite Ltd.
+ */
+
+#include <common.h>
+#include <command.h>
+#include <cpu_func.h>
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/imx93_pins.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/mxc_i2c.h>
+#include <asm/arch-mx7ulp/gpio.h>
+#include <asm/mach-imx/syscounter.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <linux/delay.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ccm_regs.h>
+#include <asm/arch/ddr.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
+#include <asm/arch/trdc.h>
+
+#include "../common/imx9_eeprom.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct var_eeprom eeprom = {0};
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	return BOOT_DEVICE_BOOTROM;
+}
+
+void spl_board_init(void)
+{
+	struct var_eeprom *ep = VAR_EEPROM_DATA;
+
+	puts("Normal Boot\n");
+
+	/* Copy EEPROM contents to DRAM */
+	memcpy(ep, &eeprom, sizeof(*ep));
+}
+
+void spl_dram_init(void)
+{
+	/* EEPROM initialization */
+	var_eeprom_read_header(&eeprom);
+
+	ddr_init(&dram_timing);
+}
+
+int power_init_board(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_PMIC_PCA9450)) {
+		ret = pmic_get("pmic@25", &dev);
+		if (ret == -ENODEV) {
+			puts("No pca9450@25\n");
+			return 0;
+		}
+		if (ret != 0)
+			return ret;
+
+		/* BUCKxOUT_DVS0/1 control BUCK123 output */
+		pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
+
+		/* enable DVS control through PMIC_STBY_REQ */
+		pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
+
+		/* 0.9v
+		 */
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
+
+		/* set standby voltage to 0.65v */
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
+
+		/* I2C_LT_EN*/
+		pmic_reg_write(dev, 0xa, 0x3);
+
+		/* set WDOG_B_CFG to cold reset */
+		pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
+	}
+
+	return 0;
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	timer_init();
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	spl_early_init();
+
+	preloader_console_init();
+
+	ret = arch_cpu_init();
+	if (ret) {
+		printf("Fail to init Sentinel API\n");
+	} else {
+		printf("SOC: 0x%x\n", gd->arch.soc_rev);
+		printf("LC: 0x%x\n", gd->arch.lifecycle);
+	}
+	power_init_board();
+
+	set_arm_core_max_clk();
+
+	/* Init power of mix */
+	soc_power_init();
+
+	/* Setup TRDC for DDR access */
+	trdc_init();
+
+	/* DDR initialization */
+	spl_dram_init();
+
+	/* Put M33 into CPUWAIT for following kick */
+	ret = m33_prepare();
+	if (!ret)
+		printf("M33 prepare ok\n");
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
new file mode 100644
index 00000000000..55cb2fc43aa
--- /dev/null
+++ b/configs/imx93_var_som_defconfig
@@ -0,0 +1,161 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG=""
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx93-var-som-symphony"
+CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_USB_TCPC=y
+CONFIG_TARGET_IMX93_VAR_SOM=y
+CONFIG_EXTCON_PTN5150=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL=y
+CONFIG_CMD_DEKBLOB=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx93-var-som-symphony.dtb"
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_NET=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=3
+CONFIG_SYS_EEPROM_SIZE=512
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=100
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
+CONFIG_BOOTP_PREFER_SERVERIP=y
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
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_SPL_DM=y
+CONFIG_SYSCON=y
+CONFIG_SPL_CLK_IMX93=y
+CONFIG_CLK_IMX93=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=1
+CONFIG_GPIO_HOG=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY_ADIN=y
+CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
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
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_USB_PORT_AUTO=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_SYS_I2C_SPEED=100000
+CONFIG_IMX_BOOTAUX=y
+CONFIG_SYS_BARGSIZE=2048
+CONFIG_CMD_READ=y
+CONFIG_SERIAL_TAG=y
+CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL_BSS_START_ADDR=0x2051a000
+CONFIG_SYS_SPL_MALLOC_START=0x83200000
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
new file mode 100644
index 00000000000..ee487d201b8
--- /dev/null
+++ b/include/configs/imx93_var_som.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2022 NXP
+ * Copyright 2023 Variscite Ltd.
+ */
+
+#ifndef __IMX93_VAR_SOM_H
+#define __IMX93_VAR_SOM_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_SDRAM_BASE           0x80000000
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#ifdef CONFIG_AHAB_BOOT
+#define AHAB_ENV "sec_boot=yes\0"
+#else
+#define AHAB_ENV "sec_boot=no\0"
+#endif
+
+#ifdef CONFIG_DISTRO_DEFAULTS
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0) \
+	func(MMC, mmc, 1) \
+	func(USB, usb, 0)
+
+#include <config_distro_bootcmd.h>
+#else
+#define BOOTENV
+#endif
+
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS		\
+	BOOTENV \
+	AHAB_ENV \
+	"initrd_addr=0x83800000\0" \
+	"emmc_dev=0\0"\
+	"sd_dev=1\0" \
+	"scriptaddr=0x83500000\0" \
+	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"image=Image.gz\0" \
+	"img_addr=0x82000000\0" \
+	"splashimage=0x90000000\0" \
+	"console=ttyLP0,115200 earlycon\0" \
+	"fdt_addr_r=0x83000000\0"			\
+	"fdt_addr=0x83000000\0"			\
+	"cntr_addr=0x98000000\0"			\
+	"cntr_file=os_cntr_signed.bin\0" \
+	"boot_fit=no\0" \
+	"bootdir=/boot\0" \
+	"fdt_file=undefined\0" \
+	"bootm_size=0x10000000\0" \
+	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
+	"mmcpart=1\0" \
+	"mmcautodetect=yes\0" \
+	"optargs=setenv bootargs ${bootargs} ${kernelargs};\0" \
+	"mmcroot=root=/dev/mmcblk${mmcblk}p${mmcpart}\0" \
+	"mmcargs=setenv bootargs ${jh_clk} console=${console} ${mmcroot} rootwait rw\0 " \
+	"loadbootscript=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootdir}/${script};\0" \
+	"bootscript=echo Running bootscript from mmc ...; " \
+		"source\0" \
+	"loadimage=load mmc ${mmcdev}:${mmcpart} ${img_addr} ${bootdir}/${image};" \
+		"unzip ${img_addr} ${loadaddr}\0" \
+	"findfdt=" \
+		"if test $fdt_file = undefined; then " \
+			"setenv fdt_file " CONFIG_DEFAULT_FDT_FILE "; " \
+		"fi; " \
+		"echo fdt_file=${fdt_file};\0" \
+	"loadfdt=run findfdt;load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${bootdir}/${fdt_file}\0" \
+	"loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}\0" \
+	"auth_os=auth_cntr ${cntr_addr}\0" \
+	"boot_os=booti ${loadaddr} - ${fdt_addr_r};\0" \
+	"mmcboot=echo Booting from mmc ...; " \
+		"run mmcargs; " \
+		"run optargs; " \
+		"if test ${sec_boot} = yes; then " \
+			"if run auth_os; then " \
+				"run boot_os; " \
+			"else " \
+				"echo ERR: failed to authenticate; " \
+			"fi; " \
+		"else " \
+			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
+				"bootm ${loadaddr}; " \
+			"else " \
+				"if run loadfdt; then " \
+					"run boot_os; " \
+				"else " \
+					"echo WARN: Cannot load the DT; " \
+				"fi; " \
+			"fi;" \
+		"fi;\0" \
+	"netargs=setenv bootargs ${jh_clk} console=${console} " \
+		"root=/dev/nfs " \
+		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
+	"netboot=echo Booting from net ...; " \
+		"run netargs;  " \
+		"run optargs; " \
+		"if test ${ip_dyn} = yes; then " \
+			"setenv get_cmd dhcp; " \
+		"else " \
+			"setenv get_cmd tftp; " \
+		"fi; " \
+		"if test ${sec_boot} = yes; then " \
+			"${get_cmd} ${cntr_addr} ${cntr_file}; " \
+			"if run auth_os; then " \
+				"run boot_os; " \
+			"else " \
+				"echo ERR: failed to authenticate; " \
+			"fi; " \
+		"else " \
+			"${get_cmd} ${img_addr} ${image}; unzip ${img_addr} ${loadaddr}; " \
+			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
+				"bootm ${loadaddr}; " \
+			"else " \
+				"run findfdt; " \
+				"if ${get_cmd} ${fdt_addr_r} ${fdt_file}; then " \
+					"run boot_os; " \
+				"else " \
+					"echo WARN: Cannot load the DT; " \
+				"fi; " \
+			"fi;" \
+		"fi;\0" \
+	"bsp_bootcmd=echo Running BSP bootcmd ...; " \
+		"mmc dev ${mmcdev}; if mmc rescan; then " \
+		   "if run loadbootscript; then " \
+			   "run bootscript; " \
+		   "else " \
+			   "if test ${sec_boot} = yes; then " \
+				   "if run loadcntr; then " \
+					   "run mmcboot; " \
+				   "else run netboot; " \
+				   "fi; " \
+			    "else " \
+				   "if run loadimage; then " \
+					   "run mmcboot; " \
+				   "else run netboot; " \
+				   "fi; " \
+				"fi; " \
+		   "fi; " \
+	   "fi;"
+
+/* Link Definitions */
+
+#define CFG_SYS_INIT_RAM_ADDR        0x80000000
+#define CFG_SYS_INIT_RAM_SIZE        0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x80000000
+#define PHYS_SDRAM                      0x80000000
+#define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
+
+#define DEFAULT_SDRAM_SIZE		(512 * SZ_1M) /* 512MB Minimum DDR4, see get_dram_size */
+#define VAR_EEPROM_DRAM_START           (PHYS_SDRAM + (DEFAULT_SDRAM_SIZE >> 1))
+#define VAR_SOM_EEPROM_I2C_NAME "i2c@42530000"
+#define VAR_CARRIER_EEPROM_I2C_NAME "i2c@44340000"
+
+#define CFG_SYS_FSL_USDHC_NUM	2
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+#if defined(CONFIG_CMD_NET)
+#define CFG_FEC_XCV_TYPE             RGMII
+#define CFG_FEC_MXC_PHYADDR          5
+
+#define DWC_NET_PHYADDR			0
+
+#define PHY_ANEG_TIMEOUT 20000
+
+#endif
+
+#endif
-- 
2.25.1

