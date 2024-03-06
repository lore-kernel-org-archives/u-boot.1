Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E701C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44B9879E8;
	Wed,  6 Mar 2024 17:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="ZAvUwkpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFF987C92; Wed,  6 Mar 2024 17:19:24 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ACF5878E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 0A4B3A6D;
 Wed,  6 Mar 2024 17:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709741961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rSNY7pz+rbHLd1wg1bAZdw8UYNhUKyznjpAYhBwdgfY=;
 b=ZAvUwkpEqyPGElC/X0k7MaysR3XNxRCsKCrYTIT9+5EOHQTZssfAgpuja+MFryTWN05llC
 zlt4HzQvWbzs15k+JspYyn2b3WczaqrjfK6vXJSyyIzewZC9bkBkC0QSdSYoTMnLr/q2HD
 f/iUA51acnG/BVSqsvJkkureu+wLHxMgACHBOkAANXwnWVsxKPcK7U2TL6gDKPuSWFaFbG
 KZAOEhFurUBfdbwyajn2SsxFIhSAvauu1uQYktTwBkJdBsNEWWltLb8aN/1DTi/dvVAfsZ
 8ZE8hjDSgfDuaY6QxS2osv2pgPzz0moig5s2O1nIAWkqhj/YQXOMwM9VYgEsnQ==
From: Michael Walle <michael@walle.cc>
To: Priyanka Jain <priyanka.jain@nxp.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <michael@walle.cc>
Subject: [PATCH] board: sl28: move to OF_UPSTREAM
Date: Wed,  6 Mar 2024 17:19:11 +0100
Message-Id: <20240306161911.1598529-1-michael@walle.cc>
X-Mailer: git-send-email 2.39.2
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

Use the new device devicetree files in dts/upstream/ and delete the old
ones. Still keep the -u-boot.dtsi with all u-boot specifics around.

There is one catch and that is fsl-ls1028a-kontron-sl28-var3.dts which
is not available upstream (yet!). For now, the base dts is used for this
variant as this only differ in the compatible and the (human readable)
model name.

Signed-off-by: Michael Walle <michael@walle.cc>
---
I'll send a patch to linux to add the var3.dts, then I'll add the
correct var3 dts again.
---
 .../arm/dts/fsl-ls1028a-kontron-sl28-var1.dts |  59 ----
 .../arm/dts/fsl-ls1028a-kontron-sl28-var2.dts |  65 ----
 .../arm/dts/fsl-ls1028a-kontron-sl28-var3.dts |  15 -
 .../arm/dts/fsl-ls1028a-kontron-sl28-var4.dts |  47 ---
 arch/arm/dts/fsl-ls1028a-kontron-sl28.dts     | 308 ------------------
 board/kontron/sl28/spl.c                      |  11 +-
 configs/kontron_sl28_defconfig                |   5 +-
 7 files changed, 8 insertions(+), 502 deletions(-)
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts
 delete mode 100644 arch/arm/dts/fsl-ls1028a-kontron-sl28.dts

diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts
deleted file mode 100644
index 7cd29ab970..0000000000
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var1.dts
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree file for the Kontron SMARC-sAL28 board.
- *
- * This is for the network variant 1 which has one ethernet port. It is
- * different than the base variant, which also has one port, but here the
- * port is connected via RGMII. This port is not TSN aware.
- * None of the  four SerDes lanes are used by the module, instead they are
- * all led out to the carrier for customer use.
- *
- * Copyright (C) 2021 Michael Walle <michael@walle.cc>
- *
- */
-
-/dts-v1/;
-#include "fsl-ls1028a-kontron-sl28.dts"
-#include <dt-bindings/net/qca-ar803x.h>
-
-/ {
-	model = "Kontron SMARC-sAL28 (4 Lanes)";
-	compatible = "kontron,sl28-var1", "kontron,sl28", "fsl,ls1028a";
-};
-
-&enetc_mdio_pf3 {
-	/* Delete unused phy node */
-	/delete-node/ ethernet-phy@5;
-
-	phy0: ethernet-phy@4 {
-		reg = <0x4>;
-		eee-broken-1000t;
-		eee-broken-100tx;
-		qca,clk-out-frequency = <125000000>;
-		qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-		qca,keep-pll-enabled;
-		vddio-supply = <&vddio>;
-
-		vddio: vddio-regulator {
-			regulator-name = "VDDIO";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		vddh: vddh-regulator {
-			regulator-name = "VDDH";
-		};
-	};
-};
-
-&enetc_port0 {
-	status = "disabled";
-	/* Delete the phy-handle to the old phy0 label */
-	/delete-property/ phy-handle;
-};
-
-&enetc_port1 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts
deleted file mode 100644
index 330e34f933..0000000000
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var2.dts
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree file for the Kontron SMARC-sAL28 board.
- *
- * This is for the network variant 2 which has two ethernet ports. These
- * ports are connected to the internal switch.
- *
- * Copyright (C) 2021 Michael Walle <michael@walle.cc>
- *
- */
-
-/dts-v1/;
-#include "fsl-ls1028a-kontron-sl28.dts"
-
-/ {
-	model = "Kontron SMARC-sAL28 (TSN-on-module)";
-	compatible = "kontron,sl28-var2", "kontron,sl28", "fsl,ls1028a";
-};
-
-&enetc_mdio_pf3 {
-	phy1: ethernet-phy@4 {
-		reg = <0x4>;
-		eee-broken-1000t;
-		eee-broken-100tx;
-	};
-};
-
-&enetc_port0 {
-	status = "disabled";
-	/*
-	 * In the base device tree the PHY at address 5 was assigned for
-	 * this port. On this module this PHY is connected to a switch
-	 * port instead. Therefore, delete the phy-handle property here.
-	 */
-	/delete-property/ phy-handle;
-};
-
-&enetc_port2 {
-	status = "okay";
-};
-
-&mscc_felix {
-	status = "okay";
-};
-
-&mscc_felix_port0 {
-	label = "swp0";
-	managed = "in-band-status";
-	phy-handle = <&phy0>;
-	phy-mode = "sgmii";
-	status = "okay";
-};
-
-&mscc_felix_port1 {
-	label = "swp1";
-	managed = "in-band-status";
-	phy-handle = <&phy1>;
-	phy-mode = "sgmii";
-	status = "okay";
-};
-
-&mscc_felix_port4 {
-	ethernet = <&enetc_port2>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts b/arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts
deleted file mode 100644
index 0c8b2af41a..0000000000
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var3.dts
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree file for the Kontron SMARC-sAL28 board.
- *
- * Copyright (C) 2019 Michael Walle <michael@walle.cc>
- *
- */
-
-/dts-v1/;
-#include "fsl-ls1028a-kontron-sl28.dts"
-
-/ {
-	model = "Kontron SMARC-sAL28 (Single PHY)";
-	compatible = "kontron,sl28-var3", "kontron,sl28", "fsl,ls1028a";
-};
diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts
deleted file mode 100644
index 9b5e92fb75..0000000000
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28-var4.dts
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree file for the Kontron SMARC-sAL28 board.
- *
- * This is for the network variant 4 which has two ethernet ports. It
- * extends the base and provides one more port connected via RGMII.
- *
- * Copyright (C) 2021 Michael Walle <michael@walle.cc>
- *
- */
-
-/dts-v1/;
-#include "fsl-ls1028a-kontron-sl28.dts"
-#include <dt-bindings/net/qca-ar803x.h>
-
-/ {
-	model = "Kontron SMARC-sAL28 (Dual PHY)";
-	compatible = "kontron,sl28-var4", "kontron,sl28", "fsl,ls1028a";
-};
-
-&enetc_mdio_pf3 {
-	phy1: ethernet-phy@4 {
-		reg = <0x4>;
-		eee-broken-1000t;
-		eee-broken-100tx;
-		qca,clk-out-frequency = <125000000>;
-		qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-		qca,keep-pll-enabled;
-		vddio-supply = <&vddio>;
-
-		vddio: vddio-regulator {
-			regulator-name = "VDDIO";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		vddh: vddh-regulator {
-			regulator-name = "VDDH";
-		};
-	};
-};
-
-&enetc_port1 {
-	phy-handle = <&phy1>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
diff --git a/arch/arm/dts/fsl-ls1028a-kontron-sl28.dts b/arch/arm/dts/fsl-ls1028a-kontron-sl28.dts
deleted file mode 100644
index ab713b4949..0000000000
--- a/arch/arm/dts/fsl-ls1028a-kontron-sl28.dts
+++ /dev/null
@@ -1,308 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree file for the Kontron SMARC-sAL28 board.
- *
- * Copyright (C) 2021 Michael Walle <michael@walle.cc>
- *
- */
-
-/dts-v1/;
-#include "fsl-ls1028a.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Kontron SMARC-sAL28";
-	compatible = "kontron,sl28", "fsl,ls1028a";
-
-	aliases {
-		crypto = &crypto;
-		serial0 = &duart0;
-		serial1 = &duart1;
-		serial2 = &lpuart1;
-		spi0 = &fspi;
-		spi1 = &dspi2;
-		mmc0 = &esdhc1;
-		mmc1 = &esdhc;
-		rtc0 = &rtc;
-		rtc1 = &ftm_alarm0;
-	};
-
-	buttons0 {
-		compatible = "gpio-keys";
-
-		power-button {
-			interrupts-extended = <&sl28cpld_intc
-					       4 IRQ_TYPE_EDGE_BOTH>;
-			linux,code = <KEY_POWER>;
-			label = "Power";
-		};
-
-		sleep-button {
-			interrupts-extended = <&sl28cpld_intc
-					       5 IRQ_TYPE_EDGE_BOTH>;
-			linux,code = <KEY_SLEEP>;
-			label = "Sleep";
-		};
-	};
-
-	buttons1 {
-		compatible = "gpio-keys-polled";
-		poll-interval = <200>;
-
-		lid-switch {
-			linux,input-type = <EV_SW>;
-			linux,code = <SW_LID>;
-			gpios = <&sl28cpld_gpio3 4 GPIO_ACTIVE_LOW>;
-			label = "Lid";
-		};
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&can0 {
-	status = "okay";
-};
-
-&dspi2 {
-	status = "okay";
-};
-
-&duart0 {
-	status = "okay";
-};
-
-&duart1 {
-	status = "okay";
-};
-
-&enetc_mdio_pf3 {
-	phy0: ethernet-phy@5 {
-		reg = <0x5>;
-		eee-broken-1000t;
-		eee-broken-100tx;
-	};
-};
-
-&enetc_port0 {
-	phy-handle = <&phy0>;
-	phy-mode = "sgmii";
-	managed = "in-band-status";
-	status = "okay";
-};
-
-&esdhc {
-	sd-uhs-sdr104;
-	sd-uhs-sdr50;
-	sd-uhs-sdr25;
-	sd-uhs-sdr12;
-	status = "okay";
-};
-
-&esdhc1 {
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	bus-width = <8>;
-	status = "okay";
-};
-
-&fspi {
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		m25p,fast-read;
-		spi-max-frequency = <133000000>;
-		reg = <0>;
-		/* The following setting enables 1-1-2 (CMD-ADDR-DATA) mode */
-		spi-rx-bus-width = <2>; /* 2 SPI Rx lines */
-		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				reg = <0x000000 0x010000>;
-				label = "rcw";
-				read-only;
-			};
-
-			partition@10000 {
-				reg = <0x010000 0x1d0000>;
-				label = "failsafe bootloader";
-				read-only;
-			};
-
-			partition@200000 {
-				reg = <0x200000 0x010000>;
-				label = "configuration store";
-			};
-
-			partition@210000 {
-				reg = <0x210000 0x1d0000>;
-				label = "bootloader";
-			};
-
-			partition@3e0000 {
-				reg = <0x3e0000 0x020000>;
-				label = "bootloader environment";
-			};
-		};
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "TDO", "TCK",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "", "", "", "", "TMS", "TDI",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&i2c0 {
-	status = "okay";
-
-	rtc: rtc@32 {
-		compatible = "microcrystal,rv8803";
-		reg = <0x32>;
-	};
-
-	sl28cpld@4a {
-		compatible = "kontron,sl28cpld";
-		reg = <0x4a>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		watchdog@4 {
-			compatible = "kontron,sl28cpld-wdt";
-			reg = <0x4>;
-			kontron,assert-wdt-timeout-pin;
-		};
-
-		hwmon@b {
-			compatible = "kontron,sl28cpld-fan";
-			reg = <0xb>;
-		};
-
-		sl28cpld_pwm0: pwm@c {
-			compatible = "kontron,sl28cpld-pwm";
-			reg = <0xc>;
-			#pwm-cells = <2>;
-		};
-
-		sl28cpld_pwm1: pwm@e {
-			compatible = "kontron,sl28cpld-pwm";
-			reg = <0xe>;
-			#pwm-cells = <2>;
-		};
-
-		sl28cpld_gpio0: gpio@10 {
-			compatible = "kontron,sl28cpld-gpio";
-			reg = <0x10>;
-			interrupts-extended = <&gpio2 6
-					       IRQ_TYPE_EDGE_FALLING>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-line-names =
-				"GPIO0_CAM0_PWR_N", "GPIO1_CAM1_PWR_N",
-				"GPIO2_CAM0_RST_N", "GPIO3_CAM1_RST_N",
-				"GPIO4_HDA_RST_N", "GPIO5_PWM_OUT",
-				"GPIO6_TACHIN", "GPIO7";
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		sl28cpld_gpio1: gpio@15 {
-			compatible = "kontron,sl28cpld-gpio";
-			reg = <0x15>;
-			interrupts-extended = <&gpio2 6
-					       IRQ_TYPE_EDGE_FALLING>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-line-names =
-				"GPIO8", "GPIO9", "GPIO10", "GPIO11",
-				"", "", "", "";
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		sl28cpld_gpio2: gpio@1a {
-			compatible = "kontron,sl28cpld-gpo";
-			reg = <0x1a>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-line-names =
-				"LCD0 voltage enable",
-				"LCD0 backlight enable",
-				"eMMC reset", "LVDS bridge reset",
-				"LVDS bridge power-down",
-				"SDIO power enable",
-				"", "";
-		};
-
-		sl28cpld_gpio3: gpio@1b {
-			compatible = "kontron,sl28cpld-gpi";
-			reg = <0x1b>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-line-names =
-				"Power button", "Force recovery", "Sleep",
-				"Battery low", "Lid state", "Charging",
-				"Charger present", "";
-		};
-
-		sl28cpld_intc: interrupt-controller@1c {
-			compatible = "kontron,sl28cpld-intc";
-			reg = <0x1c>;
-			interrupts-extended = <&gpio2 6
-					       IRQ_TYPE_EDGE_FALLING>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-};
-
-&lpuart1 {
-	status = "okay";
-};
diff --git a/board/kontron/sl28/spl.c b/board/kontron/sl28/spl.c
index ffaf517a8b..80acde7495 100644
--- a/board/kontron/sl28/spl.c
+++ b/board/kontron/sl28/spl.c
@@ -47,15 +47,14 @@ int board_fit_config_name_match(const char *name)
 
 	switch (variant) {
 	case 1:
-		return strcmp(name, "fsl-ls1028a-kontron-sl28-var1");
+		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var1");
 	case 2:
-		return strcmp(name, "fsl-ls1028a-kontron-sl28-var2");
-	case 3:
-		return strcmp(name, "fsl-ls1028a-kontron-sl28-var3");
+		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var2");
 	case 4:
-		return strcmp(name, "fsl-ls1028a-kontron-sl28-var4");
+		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var4");
+	case 3:
 	default:
-		return strcmp(name, "fsl-ls1028a-kontron-sl28");
+		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28");
 	}
 }
 
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index 639c5c6ce1..adc1d501ba 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -11,7 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1800eff0
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x3e0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1028a-kontron-sl28"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/fsl-ls1028a-kontron-sl28"
 CONFIG_SPL_TEXT_BASE=0x18010000
 CONFIG_SYS_FSL_SDHC_CLK_DIV=1
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -73,7 +73,8 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RNG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="fsl-ls1028a-kontron-sl28 fsl-ls1028a-kontron-sl28-var1 fsl-ls1028a-kontron-sl28-var2 fsl-ls1028a-kontron-sl28-var3 fsl-ls1028a-kontron-sl28-var4"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var4"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.39.2

