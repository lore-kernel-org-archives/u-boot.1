Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF83CED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9D888E74;
	Thu, 10 Oct 2024 02:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtisdhpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0C388E2D; Thu, 10 Oct 2024 02:43:59 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E547588AE4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84f9e39fc60so93139241.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728521036; x=1729125836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rnL2dorOn1Q9/Uct9kXDuHy07ILVRr+avkFemhPBRVE=;
 b=jtisdhpmNUQtvBdZewEzNSW4yTZab9vGQ/MGdaTq6ZBsolPIk14D9dTS0sQlUu1RvK
 phrvVfyOEZ9AVJ3dao87a9cPkIOV2nhVtU5ZANX5KhnSOrEiR4vKC7FhlGamq4pCnXdK
 FNvYEDW/i2brCddPxtB9guVqZWohS38cHbesm8LxRXmHcbLzwUZGU3AqUtiOLHUDkQgX
 47nUbloYH7CdMA3fQG0JSlwY62Plea6WWaj6gUZzwR5SSICh935JMQVM6EGuuTRtWtws
 R9lPxF+7Ow0lu8uKHpgwPY4tZ5mo2NJRW1nPx7WBaJFWFWy1gxz8AlRKo3XxXwtMuvOs
 Vm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728521036; x=1729125836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnL2dorOn1Q9/Uct9kXDuHy07ILVRr+avkFemhPBRVE=;
 b=SHKrKxuvdLGnvf/BOykSrN+/4D/Pdms3Gt2++9HgP5NtRnTgikCRpabBfmFM9BrFYA
 216whnJVqAGHB8IfqBBwA9HeaeJTNGzMVsGd+HfnzB+sWMSxxvxFpAvH/mSV9H9EPNqh
 Gdi+IxgeVhIBxM7MG06OSxZ9BXN4KutkrojHIArcbhxWjLlUFZMik7i+Mjs9gZkCug+z
 OKsuJWHFri2kYryYZuUKFaL2s2xVqsK+dtQ149CVWP9qaPmfcIBnkWLIygrwVdI8eBvu
 Kj7yPolIQl0AF04g2G2yhLu/oJlFnADN2LR9z2+RlzDBLnIOMTOg3D7jKBkQJbQ23Pp5
 KOQQ==
X-Gm-Message-State: AOJu0YzWhTvU37Sn+x9SDMdx+aZ3ERIXEVRmjvXQsGxRO3uf6XUnRvEu
 89nyCpqpcDSXr78AwrQ0pJYCFY8kP0SWl1hV+SQTCg6OkPCrXynh
X-Google-Smtp-Source: AGHT+IFVrB9/a09yil/LjA74UqUdq98wJaKNmdlCknvDMIJvDb9mpDMKYX/RVMaj8gSKUYe3MEnvag==
X-Received: by 2002:a05:6122:16a2:b0:507:9165:209 with SMTP id
 71dfb90a1353d-50cf0c01ab8mr3593434e0c.7.1728521035553; 
 Wed, 09 Oct 2024 17:43:55 -0700 (PDT)
Received: from gilles-Precision-3571.lan
 ([2605:59c0:14b7:4a10:93fb:8b1f:41fb:81eb])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-50d0886c25bsm21602e0c.55.2024.10.09.17.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:43:54 -0700 (PDT)
From: Gilles Talis <gilles.talis@gmail.com>
To: festevam@gmail.com,
	peng.fan@nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com,
 Gilles Talis <gilles.talis@gmail.com>
Subject: [PATCH] arm64: imx: imx8mp-debix-model-a: Migrate to OF_UPSTREAM
Date: Wed,  9 Oct 2024 20:42:42 -0400
Message-ID: <20241010004242.149787-1-gilles.talis@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Device tree for this board can be deleted. Device tree location
now points to the freescale/ directory.

Use absolute path to PMIC node entry and its regulators as
device tree in kernel does not provide corresponding labels

Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi |  16 +-
 arch/arm/dts/imx8mp-debix-model-a.dts         | 507 ------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 configs/imx8mp_debix_model_a_defconfig        |   2 +-
 5 files changed, 10 insertions(+), 517 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-debix-model-a.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 65176c8fb8..73efdcf975 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -967,7 +967,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
 	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
-	imx8mp-debix-model-a.dtb \
 	imx8mp-dhcom-drc02.dtb \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
diff --git a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
index 33bd89a843..d5bd9f591e 100644
--- a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
@@ -20,6 +20,14 @@
 	};
 };
 
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-pre-ram;
+};
+
 &crypto {
 	bootph-pre-ram;
 };
@@ -88,14 +96,6 @@
 	bootph-pre-ram;
 };
 
-&pmic {
-	bootph-pre-ram;
-
-	regulators {
-		bootph-pre-ram;
-	};
-};
-
 &reg_usdhc2_vmmc {
 	u-boot,off-on-delay-us = <20000>;
 };
diff --git a/arch/arm/dts/imx8mp-debix-model-a.dts b/arch/arm/dts/imx8mp-debix-model-a.dts
deleted file mode 100644
index 58dae612b4..0000000000
--- a/arch/arm/dts/imx8mp-debix-model-a.dts
+++ /dev/null
@@ -1,507 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- * Copyright 2022 Ideas on Board Oy
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/usb/pd.h>
-
-#include "imx8mp.dtsi"
-
-/ {
-	model = "Polyhex Debix Model A i.MX8MPlus board";
-	compatible = "polyhex,imx8mp-debix-model-a", "polyhex,imx8mp-debix", "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		led-0 {
-			function = LED_FUNCTION_POWER;
-			color = <LED_COLOR_ID_RED>;
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-connection-type = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 { /* RTL8211E */
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <20>;
-			reset-deassert-us = <200000>;
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
-	pmic: pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2: LDO2 {
-				regulator-name = "LDO2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3: LDO3 {
-				regulator-name = "LDO3";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
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
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-
-	rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc_int>;
-	};
-};
-
-&i2c6 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c6>;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 {
-	/* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-/* SD Card */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
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
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
-			MX8MP_IOMUXC_SAI1_RXFS__ENET1_1588_EVENT0_IN			0x1f
-			MX8MP_IOMUXC_SAI1_RXC__ENET1_1588_EVENT0_OUT			0x1f
-			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18				0x19
-		>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC				0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO				0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0				0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1				0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2				0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3				0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC				0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL			0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0				0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1				0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2				0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3				0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL			0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC				0x1f
-			MX8MP_IOMUXC_SAI1_RXD1__ENET1_1588_EVENT1_OUT			0x1f
-			MX8MP_IOMUXC_SAI1_RXD0__ENET1_1588_EVENT1_IN			0x1f
-			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19				0x19
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL					0x400001c2
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA					0x400001c2
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL					0x400001c2
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA					0x400001c2
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL					0x400001c2
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA					0x400001c2
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL					0x400001c3
-			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA					0x400001c3
-		>;
-	};
-
-	pinctrl_i2c6: i2c6grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL				0x400001c3
-			MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA					0x400001c3
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03				0x41
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19				0x41
-		>;
-	};
-
-	pinctrl_rtc_int: rtcintgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11				0x140
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX				0x14f
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX				0x14f
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX				0x49
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX				0x49
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX				0x49
-			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX				0x49
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK				0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD				0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0				0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1				0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2				0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3				0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK				0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD				0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0				0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1				0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2				0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3				0x1d4
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK				0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD				0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0				0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1				0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2				0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3				0x1d6
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12				0x1c4
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B				0xc6
-		>;
-	};
-};
-
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index d1fdaec704..9d1fabe91c 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -197,6 +197,7 @@ config TARGET_IMX8MP_DEBIX_MODEL_A
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MP_DH_DHCOM_PDK2
 	bool "DH electronics DHCOM Premium Developer Kit (2) i.MX8M Plus"
diff --git a/configs/imx8mp_debix_model_a_defconfig b/configs/imx8mp_debix_model_a_defconfig
index dcc529f9fc..9f75ab1477 100644
--- a/configs/imx8mp_debix_model_a_defconfig
+++ b/configs/imx8mp_debix_model_a_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-debix-model-a"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-debix-model-a"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_DEBIX_MODEL_A=y
 CONFIG_SYS_MONITOR_LEN=524288

base-commit: 93b9cd792089e536f2bfa85d9903fd4798209f76
-- 
2.43.0

