Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99591C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3C587FA1;
	Tue, 26 Mar 2024 21:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOvpXd6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9EE88047; Tue, 26 Mar 2024 21:25:40 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DD288063
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso50409966d6.3
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711484734; x=1712089534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvBW1MbLtVZZqSMlwV0SRyBe0GQj02u+AgsMmlALNqY=;
 b=LOvpXd6r8F3CFCxw2JbOU9cUN2Sv6wNYPIL908XibfX0kooazU6/bBl/bWkHZsEYby
 NzwQzI9AaierltOvfciIgB2vGSQSPa6gRg7Q9vk1KYiQBq7vTRlJIqhtWMt31fOnfdzQ
 nRA/WSPbISDfVTyTPW+7fVN5gTRgiJMKycMK+tw1nrbQy3kvwivuHb5lo0YWjy3RsYGF
 lwhNIRzmOIOK3WRWs2U4NU20VGJYVaL5hhOq0hjnIvnrrA0886U1AI+1xhkwHqmsDF4d
 5yrd15PY4hqYZXPpMt4WqYpMEkujQGUc7PwbJUV8p9vKQ71vtmJxNYQWkbiAWkTHe2Uc
 xNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711484734; x=1712089534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvBW1MbLtVZZqSMlwV0SRyBe0GQj02u+AgsMmlALNqY=;
 b=kbqEE8UC7cq3gHpluPvxp3OZbpUTNuM3XRM8liOv1WIEkBz4p8vFMd3T47plnrTCfn
 cNuSE0HQhdzxobk13WpOiW8r1WGiyhrf04dPYeQ6yV8JngCblMMxqSUCpf3z7pnpwj6W
 Sz+DP77MtAOLVZFFTUJsudo0Cc9eN2nTNFz5UKMqMKYLgyp+/5emIkTY4b/V3AnUzTn7
 WKyDRdjYZeDGsneAYrfP2PFwGq/VDS4SYTtOdvFjJ7x2au1bBYGRzKAT29F57EJ0cqoQ
 LZ6SvPEnQfsUyMI4kDLAluiyF612kx2lI4cagaSvFBxAfJ9nDZSSvqeOjDNcgjJMHTlC
 XlEw==
X-Gm-Message-State: AOJu0YwWL5BzD8Wy+s5jYIFwbZIzhonYWxEsND9Zo9IRixmqEto9xBCS
 ywnlADwwXBVp3rW41k0o3ZkEJk4JkJg2O9EE/QDyksS+TW5IKnLfePtAIGZnf2M=
X-Google-Smtp-Source: AGHT+IHqAhdcPQ/lAGgkzKcW0aOrnV68IVcD7JSwDknjn0m5VCH3Jzsl1ItDWwQdH3oLro2JEf8KVg==
X-Received: by 2002:a05:6214:acc:b0:696:3705:fe5a with SMTP id
 g12-20020a0562140acc00b006963705fe5amr13805857qvi.7.1711484734220; 
 Tue, 26 Mar 2024 13:25:34 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:6f52:cf6f:a4b1:c71f])
 by smtp.gmail.com with ESMTPSA id
 fq9-20020a056214258900b00690d5310c55sm5530674qvb.114.2024.03.26.13.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:25:33 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>,
 Andrew Davis <afd@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Gilles Talis <gilles.talis@gmail.com>, Patrick Wildt <patrick@blueri.se>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 6/7] arm64: imx: imx8mn-beacon: Migrate to OF_UPSTREAM
Date: Tue, 26 Mar 2024 15:23:44 -0500
Message-ID: <20240326202439.46707-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326202439.46707-1-aford173@gmail.com>
References: <20240326202439.46707-1-aford173@gmail.com>
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

The imx8mn-beacon boards can migrate to OF_UPSTREAM which also
allows for the removal the device tree files.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 443d651827..6ddd6e311e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1091,7 +1091,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mn-evk.dtb \
 	imx8mn-var-som-symphony.dtb \
 	imx8mq-evk.dtb \
-	imx8mn-beacon-kit.dtb \
 	imx8mq-mnt-reform2.dtb \
 	imx8mq-phanbell.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
diff --git a/arch/arm/dts/imx8mn-beacon-kit.dts b/arch/arm/dts/imx8mn-beacon-kit.dts
deleted file mode 100644
index 1392ce0258..0000000000
--- a/arch/arm/dts/imx8mn-beacon-kit.dts
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-/dts-v1/;
-
-#include "imx8mn.dtsi"
-#include "imx8mn-beacon-som.dtsi"
-#include "imx8mn-beacon-baseboard.dtsi"
-
-/ {
-	model = "Beacon EmbeddedWorks i.MX8M Nano Development Kit";
-	compatible = "beacon,imx8mn-beacon-kit", "fsl,imx8mn";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-beacon-som.dtsi b/arch/arm/dts/imx8mn-beacon-som.dtsi
deleted file mode 100644
index 1133cded9b..0000000000
--- a/arch/arm/dts/imx8mn-beacon-som.dtsi
+++ /dev/null
@@ -1,472 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-/ {
-	aliases {
-		rtc0 = &rtc;
-		rtc1 = &snvs_rtc;
-		spi0 = &flexspi;
-	};
-
-	usdhc1_pwrseq: usdhc1_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
-		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
-		clocks = <&osc_32k>;
-		clock-names = "ext_clock";
-		post-power-on-delay-ms = <80>;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
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
-/* DDR controller is running LPDDR at 800MHz which requires 0.95V */
-&a53_opp_table {
-	opp-1200000000 {
-		opp-microvolt = <950000>;
-	};
-};
-
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-800M {
-			opp-hz = /bits/ 64 <800000000>;
-		};
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	phy-supply = <&buck6_reg>;
-	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
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
-		};
-	};
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-		#clock-cells = <0>;
-		clocks = <&osc_32k 0>;
-		clock-output-names = "clk-32k-out";
-
-		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3_reg: BUCK3 {
-				// BUCK5 in datasheet
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck4_reg: BUCK4 {
-				// BUCK6 in datasheet
-				regulator-name = "buck4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5_reg: BUCK5 {
-				// BUCK7 in datasheet
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				// BUCK8 in datasheet
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
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
-
-	eeprom@50 {
-		compatible = "microchip,24c64", "atmel,24c64";
-		pagesize = <32>;
-		read-only;	/* Manufacturing EEPROM programmed at factory */
-		reg = <0x50>;
-	};
-
-	rtc: rtc@51 {
-		compatible = "nxp,pcf85263";
-		reg = <0x51>;
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
-	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		shutdown-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
-		clocks = <&osc_32k>;
-		max-speed = <4000000>;
-		clock-names = "extclk";
-	};
-};
-
-&usdhc1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vmmc-supply = <&buck4_reg>;
-	vqmmc-supply = <&buck5_reg>;
-	bus-width = <4>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	mmc-pwrseq = <&usdhc1_pwrseq>;
-	status = "okay";
-
-	brcmf: bcrmf@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_wlan>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-	};
-};
-
-&usdhc3 {
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
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x3
-			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
-			MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
-			MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
-			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
-			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
-			MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
-			MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
-			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
-			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
-			MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
-			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
-			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_flexspi: flexspigrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
-			MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
-			MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
-			MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
-			MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
-			MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
-			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
-			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
-			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
-			MX8MN_IOMUXC_SD1_DATA4_GPIO2_IO6	0x19
-			MX8MN_IOMUXC_SD1_DATA5_GPIO2_IO7	0x19
-			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x19
-			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
-		>;
-	};
-
-	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
-		>;
-	};
-
-	pinctrl_wlan: wlangrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x111
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 3592f6736b..0bd40bce3b 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -282,6 +282,7 @@ config TARGET_IMX8MN_BEACON
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	imply OF_UPSTREAM
 
 config TARGET_PHYCORE_IMX8MM
 	bool "PHYTEC PHYCORE i.MX8MM"
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index 2d4cd1fd97..e8009c410a 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -11,7 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-beacon-kit"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-beacon-kit"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_BEACON=y
 CONFIG_IMX8MN_BEACON_2GB_LPDDR=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index ec933019aa..ed671cf4a7 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -11,7 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-beacon-kit"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-beacon-kit"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_BEACON=y
 CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index 458afba441..11c257a756 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -11,7 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-beacon-kit"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-beacon-kit"
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_TARGET_IMX8MN_BEACON=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.43.0

