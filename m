Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC00C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 21:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA80B88476;
	Mon, 10 Jun 2024 23:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nBmJAZ6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3628788476; Mon, 10 Jun 2024 23:23:20 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9401883D2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 23:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=patrick.barsanti@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6f09b457fdso212812466b.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718054595; x=1718659395;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wd8TbWTcWReMKzjsAkR/mK4SHkbRi4/Ckcno/Pva90A=;
 b=nBmJAZ6lw9r/36SysxqBEc/jhPw4OJlu679GaC1dS6u3PeYCoPqK6zKWuiW+dCAoOl
 PNHwsp7GYg0HSMgwr2vkauWSf++nd6Om0yfQPuywMXtzg4l3s0xDmzMqaqujWryzA6qk
 pXUKcr6SetgvujHlBjKUCdn5+z9VsUtbeQL7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718054595; x=1718659395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wd8TbWTcWReMKzjsAkR/mK4SHkbRi4/Ckcno/Pva90A=;
 b=npL7GSgbTKDeLn6oY/FpUvaJl+nUEM3ufY0pBFmPgl69tvbHUO6yazj0dT8L/Ur1jg
 JtUWCgsp8QSqZCR8wGisvQ55yit23cqWrP+AXMDFjob8EdwJAYmRWZVjoIROHexJsqyn
 ZDQfoPkAJwtuEC72rrc1Z6OWEEPh8JuQWrnNZICbrSBl+1TWWvgkmYz11m5SxU/rnr4t
 aVh6dSOSs4tUEWa5Rh7m/Laj6WtJ+OTCPe1Zs5xTpJBmu90hGLV2lWf0yJEtr0A5ETDq
 vjyAvAcX456M0mHzXfvvrvLDTQHmKww9kGrFLJt9Pv5ZcJl+kqnVCXsXq2QFkOYD3/Nz
 nj6Q==
X-Gm-Message-State: AOJu0Yw56UjPSh7pmYnE8ubN+N16h+eV1fhELzctxSIG8CHpFMTVkzN/
 FGyHqeqtmgrfnt0qWQf5BAo1FbHWhKiZyEFzg2r/jx+1xNkiqLFxeZap89cKKr0=
X-Google-Smtp-Source: AGHT+IGJPimTaJHIez+KJt52O7nQglQIS+/o+FXPVuYZ2Uc2F0OBO+R0zoo27p/PKK6sxR76yHAhig==
X-Received: by 2002:a17:907:2da7:b0:a6f:1378:1329 with SMTP id
 a640c23a62f3a-a6f1378157bmr409228566b.4.1718054595573; 
 Mon, 10 Jun 2024 14:23:15 -0700 (PDT)
Received: from localhost.localdomain (i116103.upc-i.chello.nl.
 [62.195.116.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efe9e8c50sm387631766b.46.2024.06.10.14.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 14:23:15 -0700 (PDT)
From: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
To: sbabic@denx.de,
	festevam@gmail.com,
	uboot-imx@nxp.com
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Subject: [PATCH] arm: fsl: imx8mn_bsh_smm_s2: Migrate to OF_UPSTREAM
Date: Mon, 10 Jun 2024 23:22:09 +0200
Message-ID: <20240610212209.277486-1-patrick.barsanti@amarulasolutions.com>
X-Mailer: git-send-email 2.45.2
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

Migrate imx8mn_bsh_smm_s2 and imx8mn_bsh_smm_s2pro boards to OF_UPSTREAM.

Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Tested-by: Michael Trimarchi <michael@amarulasolutions.com>
---

Note that the patch was tested by Michael on the s2 board by applying
patch [1] before it, which fixes ddr timings.
The board otherwise doesn't boot.

Links:
- [1] https://lore.kernel.org/u-boot/20240610063842.192786-1-michael@amarulasolutions.com/

 arch/arm/dts/Makefile                      |   2 -
 arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi | 426 ---------------------
 arch/arm/dts/imx8mn-bsh-smm-s2.dts         |  48 ---
 arch/arm/dts/imx8mn-bsh-smm-s2pro.dts      | 170 --------
 arch/arm/mach-imx/imx8m/Kconfig            |   2 +
 configs/imx8mn_bsh_smm_s2_defconfig        |   2 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig     |   2 +-
 7 files changed, 4 insertions(+), 648 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2.dts
 delete mode 100644 arch/arm/dts/imx8mn-bsh-smm-s2pro.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index f77a80b7dd..1196ab040a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -925,8 +925,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-phg.dtb \
 	imx8mm-phyboard-polis-rdk.dtb \
 	imx8mm-phygate-tauri-l.dtb \
-	imx8mn-bsh-smm-s2.dtb \
-	imx8mn-bsh-smm-s2pro.dtb \
 	imx8mq-cm.dtb \
 	imx8mn-var-som-symphony.dtb \
 	imx8mq-mnt-reform2.dtb \
diff --git a/arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi
deleted file mode 100644
index c11895d9d5..0000000000
--- a/arch/arm/dts/imx8mn-bsh-smm-s2-common.dtsi
+++ /dev/null
@@ -1,426 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2021 Collabora Ltd.
- * Copyright 2021 BSH Hausgeraete GmbH
- */
-
-/dts-v1/;
-
-#include "imx8mn.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	fec_supply: fec-supply-en {
-		compatible = "regulator-fixed";
-		vin-supply = <&buck4_reg>;
-		regulator-name = "tja1101_en";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	usdhc2_pwrseq: usdhc2-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_pwrseq>;
-		reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&ecspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_espi2>;
-	status = "okay";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy0>;
-	phy-supply = <&fec_supply>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <20>;
-			reset-deassert-us = <2000>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	bd71847: pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
-		clock-output-names = "clk-32k-out";
-
-		regulators {
-			buck1_reg: BUCK1 {
-				/* PMIC_BUCK1 - VDD_SOC */
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck2_reg: BUCK2 {
-				/* PMIC_BUCK2 - VDD_ARM */
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck3_reg: BUCK3 {
-				/* PMIC_BUCK5 - VDD_DRAM_VPU_GPU */
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck4_reg: BUCK4 {
-				/* PMIC_BUCK6 - VDD_3V3 */
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5_reg: BUCK5 {
-				/* PMIC_BUCK7 - VDD_1V8 */
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				/* PMIC_BUCK8 - NVCC_DRAM */
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				/* PMIC_LDO1 - NVCC_SNVS_1V8 */
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				/* PMIC_LDO2 - VDD_SNVS_0V8 */
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				/* PMIC_LDO3 - VDDA_1V8 */
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				/* PMIC_LDO4 - VDD_MIPI_0V9 */
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
-				/* PMIC_LDO6 - VDD_MIPI_1V2 */
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
-	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bluetooth>;
-		shutdown-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-		max-speed = <3000000>;
-	};
-};
-
-/* Console */
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "peripheral";
-	disable-over-current;
-	status = "okay";
-};
-
-&usdhc2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	mmc-pwrseq = <&usdhc2_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-
-	brcmf: bcrmf@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_wlan>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-	};
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_bluetooth: bluetoothgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x044	/* BT_REG_ON */
-			MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x046	/* BT_DEV_WAKE */
-			MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x090	/* BT_HOST_WAKE */
-		>;
-	};
-
-	pinctrl_espi2: espi2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x082
-			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x082
-			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x082
-			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x002
-			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x002
-			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x090
-			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x090
-			MX8MN_IOMUXC_ENET_RXC_ENET1_RX_ER		0x090
-			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x016
-			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x016
-			MX8MN_IOMUXC_ENET_TD2_ENET1_TX_CLK		0x016
-			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x016
-			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x090
-			MX8MN_IOMUXC_ENET_TXC_ENET1_TX_ER		0x016
-			MX8MN_IOMUXC_SD2_CD_B_GPIO2_IO12		0x150	/* RMII_INT - ENET_INT */
-			MX8MN_IOMUXC_SD2_WP_GPIO2_IO20			0x150	/* RMII_EN - ENET_EN */
-			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x016	/* RMII_WAKE - GPIO_ENET_WAKE */
-			MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x016	/* RMII_RESET - GPIO_ENET_RST */
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL			0x400000c2
-			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA			0x400000c2
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL			0x400000c2
-			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA			0x400000c2
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL			0x400000c2
-			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA			0x400000c2
-		>;
-	};
-
-	pinctrl_pmic: pmicirq {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x040
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX		0x040
-			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX		0x040
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX		0x040
-			MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX		0x040
-			MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x040
-			MX8MN_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B		0x040
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART4_RXD_UART4_DCE_RX		0x040
-			MX8MN_IOMUXC_UART4_TXD_UART4_DCE_TX		0x040
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x090
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d0
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d0
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d0
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d0
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x094
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d4
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d4
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d4
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d4
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d4
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x096
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d6
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d6
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d6
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d6
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d6
-		>;
-	};
-
-	pinctrl_usdhc2_pwrseq: usdhc2pwrseqgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x040	/* WL_REG_ON */
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x046
-		>;
-	};
-
-	pinctrl_wlan: wlangrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x0d6	/* GPIO_0 - WIFI_GPIO_0 */
-			MX8MN_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x0d6	/* GPIO_1 - WIFI_GPIO_1 */
-			MX8MN_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x0d6	/* BT_GPIO_5 - WIFI_GPIO_5 */
-			MX8MN_IOMUXC_SPDIF_RX_GPIO5_IO4			0x0d6	/* I2S_CLK - WIFI_GPIO_6 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-bsh-smm-s2.dts b/arch/arm/dts/imx8mn-bsh-smm-s2.dts
deleted file mode 100644
index 33f98582ea..0000000000
--- a/arch/arm/dts/imx8mn-bsh-smm-s2.dts
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2021 Collabora Ltd.
- * Copyright 2021 BSH Hausgeraete GmbH
- */
-
-/dts-v1/;
-
-#include "imx8mn-bsh-smm-s2-common.dtsi"
-
-/ {
-	model = "BSH SMM S2";
-	compatible = "bsh,imx8mn-bsh-smm-s2", "fsl,imx8mn";
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x0 0x10000000>;
-	};
-};
-
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_ALE_RAWNAND_ALE		0x00000096
-			MX8MN_IOMUXC_NAND_CE0_B_RAWNAND_CE0_B		0x00000096
-			MX8MN_IOMUXC_NAND_CLE_RAWNAND_CLE		0x00000096
-			MX8MN_IOMUXC_NAND_DATA00_RAWNAND_DATA00		0x00000096
-			MX8MN_IOMUXC_NAND_DATA01_RAWNAND_DATA01		0x00000096
-			MX8MN_IOMUXC_NAND_DATA02_RAWNAND_DATA02		0x00000096
-			MX8MN_IOMUXC_NAND_DATA03_RAWNAND_DATA03		0x00000096
-			MX8MN_IOMUXC_NAND_DATA04_RAWNAND_DATA04		0x00000096
-			MX8MN_IOMUXC_NAND_DATA05_RAWNAND_DATA05		0x00000096
-			MX8MN_IOMUXC_NAND_DATA06_RAWNAND_DATA06		0x00000096
-			MX8MN_IOMUXC_NAND_DATA07_RAWNAND_DATA07		0x00000096
-			MX8MN_IOMUXC_NAND_RE_B_RAWNAND_RE_B		0x00000096
-			MX8MN_IOMUXC_NAND_READY_B_RAWNAND_READY_B	0x00000056
-			MX8MN_IOMUXC_NAND_WE_B_RAWNAND_WE_B		0x00000096
-			MX8MN_IOMUXC_NAND_WP_B_RAWNAND_WP_B		0x00000096
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-bsh-smm-s2pro.dts b/arch/arm/dts/imx8mn-bsh-smm-s2pro.dts
deleted file mode 100644
index fbbb336703..0000000000
--- a/arch/arm/dts/imx8mn-bsh-smm-s2pro.dts
+++ /dev/null
@@ -1,170 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2021 Collabora Ltd.
- * Copyright 2021 BSH Hausgeraete GmbH
- */
-
-/dts-v1/;
-
-#include "imx8mn-bsh-smm-s2-common.dtsi"
-#include <dt-bindings/sound/tlv320aic31xx.h>
-
-/ {
-	model = "BSH SMM S2 PRO";
-	compatible = "bsh,imx8mn-bsh-smm-s2pro", "fsl,imx8mn";
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x0 0x20000000>;
-	};
-
-	sound-tlv320aic31xx {
-		compatible = "fsl,imx-audio-tlv320aic31xx";
-		model = "tlv320aic31xx-hifi";
-		audio-cpu = <&sai3>;
-		audio-codec = <&tlv320dac3101>;
-		audio-asrc = <&easrc>;
-		audio-routing =
-			"Ext Spk", "SPL",
-			"Ext Spk", "SPR";
-		mclk-id = <PLL_CLKIN_BCLK>;
-	};
-
-	vdd_input: vdd_input {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_input";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-};
-
-&easrc {
-	fsl,asrc-rate = <48000>;
-	fsl,asrc-format = <10>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	tlv320dac3101: audio-codec@18 {
-		compatible = "ti,tlv320dac3101";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_dac_rst>;
-		reg = <0x18>;
-		#sound-dai-cells = <0>;
-		HPVDD-supply = <&buck4_reg>;
-		SPRVDD-supply = <&vdd_input>;
-		SPLVDD-supply = <&vdd_input>;
-		AVDD-supply = <&buck4_reg>;
-		IOVDD-supply = <&buck4_reg>;
-		DVDD-supply = <&buck5_reg>;
-		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-		ai31xx-micbias-vg = <MICBIAS_AVDDV>;
-		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
-	};
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	fsl,sai-mclk-direction-output;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_dac_rst: dacrstgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* DAC_RST */
-		>;
-	};
-
-	pinctrl_espi2: espi2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x082
-			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x082
-			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x082
-			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL			0x400000c3
-			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA			0x400000c3
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0xd6
-			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0xd6
-			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0xd6
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000090
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d0
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d0
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d0
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d0
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d0
-			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d0
-			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d0
-			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d0
-			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d0
-			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x090
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000094
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d4
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d4
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d4
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d4
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d4
-			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d4
-			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d4
-			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d4
-			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d4
-			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x094
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000096
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d6
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x0d6
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x0d6
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x0d6
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x0d6
-			MX8MN_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x0d6
-			MX8MN_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x0d6
-			MX8MN_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x0d6
-			MX8MN_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x0d6
-			MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x096
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 23d9217fcc..7289caf1d2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -137,12 +137,14 @@ config TARGET_IMX8MN_BSH_SMM_S2
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR3L
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MN_BSH_SMM_S2PRO
 	bool "imx8mn-bsh-smm-s2pro"
 	select IMX8MN
 	select SUPPORT_SPL
 	select IMX8M_DDR3L
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MN_EVK
 	bool "imx8mn LPDDR4 EVK board"
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 0e0a548a57..b4351a392e 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-bsh-smm-s2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-bsh-smm-s2"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_BSH_SMM_S2=y
 CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index f739569dde..0faa3376fd 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-bsh-smm-s2pro"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-bsh-smm-s2pro"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_BSH_SMM_S2PRO=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.45.1

