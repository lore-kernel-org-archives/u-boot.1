Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57692E70714
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 10:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A1386B33;
	Thu, 21 Sep 2023 12:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GIGI93F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F5086AF7; Thu, 21 Sep 2023 12:51:24 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF5A86B09
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LApHBA101589;
 Thu, 21 Sep 2023 05:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695293477;
 bh=8CGVMDlgHakkI8dwl/xm9oey8qjW6VRwqGzDvJc1aKk=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=GIGI93F3aDgUFelTrym1I9VuktwnVyuV1IRn3uMiOplFK7nz/LKiW8Rz3JyISwOVP
 TRPY8tOpSdb+5+AWLbUxhIIx8SsNSBSxZOKFPwus1jSxTshgJ/QnVLCcHTyHjaPsdl
 Xq2e/PuAxxbSSuYqTv5PjJauA+ZGmdC8mFGH/0Us=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LApHep022132
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 05:51:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 05:51:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 05:51:17 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LAp06u020650;
 Thu, 21 Sep 2023 05:51:14 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Sep 2023 16:21:03 +0530
Subject: [PATCH v6 4/7] arm: dts: k3-j721s2: Sync from Linux tag v6.6-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230921-b4-upstream-j721s2-r5-pinmux-v6-4-ca9639c1ac67@ti.com>
References: <20230921-b4-upstream-j721s2-r5-pinmux-v6-0-ca9639c1ac67@ti.com>
In-Reply-To: <20230921-b4-upstream-j721s2-r5-pinmux-v6-0-ca9639c1ac67@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695293461; l=97253;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=YTq5iKOnDLVeiHB1ezPXcr6A0sVeeXXQG++FjK7kpB4=;
 b=6qF1i3CZnwJB1i4Q0mqDmbdP307bGX8TTtvD1dworvhoM2khNEhrBNe8KFYnpaDyX8Me/wBZf
 BxIklmTjAi4Dhg4/WfL5pp/uEi2LvGgdSLqEItAEm+EfhKc9064P9d+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The following commit syncs the device tree from Linux tag
v6.6-rc1 to U-boot and fixes the following to be compatible with
the future syncs -

- Include k3-j721s2-common-proc-board.dts file

    Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
    include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
    to U-boot.

- Fixing the mcu_timer0

    Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi

- Fixing secure proxy nodes

    Linux DT now have these nodes defined so remove them and rename to
    use the Linux DT ones.

- Remove cpsw node

    The compatible is now fixed and the node is not required in
    -u-boot specifically

- Remove aliases and chosen node

    Use these from Linux and don't override when not required.

- Remove /delete-property/ from sdhci nodes

    We have the necessary clock and dev data so remove these.

- Remove dummy_clocks and fs_loader0

    These weren't being used anywhere so remove it.

- Remove mcu_ringacc override

All these have been put in a single commit to not break the
bisectability.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  66 +-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 376 ++++++----
 arch/arm/dts/k3-j721s2-main.dtsi                   | 777 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 374 +++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 158 +----
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 172 ++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 +++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/dts/k3-serdes.h                           | 204 ++++++
 9 files changed, 1794 insertions(+), 446 deletions(-)

diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index f940ffee8787..a49561bc364b 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -1,28 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-j721s2-binman.dtsi"
 
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart8;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &mcu_i2c1;
-		i2c3 = &main_i2c0;
-		ethernet0 = &cpsw_port1;
-	};
-};
-
 &wkup_i2c0 {
 	bootph-pre-ram;
 };
@@ -38,14 +20,6 @@
 &cbass_mcu_wakeup {
 	bootph-pre-ram;
 
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <250000000>;
-		bootph-pre-ram;
-	};
-
 	chipid@43000014 {
 		bootph-pre-ram;
 	};
@@ -56,12 +30,6 @@
 };
 
 &mcu_ringacc {
-	reg =   <0x0 0x2b800000 0x0 0x400000>,
-		<0x0 0x2b000000 0x0 0x400000>,
-		<0x0 0x28590000 0x0 0x100>,
-		<0x0 0x2a500000 0x0 0x40000>,
-		<0x0 0x28440000 0x0 0x40000>;
-	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 	bootph-pre-ram;
 };
 
@@ -101,6 +69,10 @@
 	bootph-pre-ram;
 };
 
+&main_usbss0_pins_default {
+	bootph-pre-ram;
+};
+
 &wkup_pmx0 {
 	bootph-pre-ram;
 };
@@ -129,23 +101,27 @@
 	bootph-pre-ram;
 };
 
-&mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x8>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
+&main_sdhci0 {
+	bootph-pre-ram;
+};
 
-	cpsw-phy-sel@40f04040 {
-		compatible = "ti,am654-cpsw-phy-sel";
-		reg= <0x0 0x40f04040 0x0 0x4>;
-		reg-names = "gmii-sel";
-	};
+&main_sdhci1 {
+	bootph-pre-ram;
 };
 
-&main_sdhci0 {
+&ospi0 {
+	status = "disabled";
+};
+
+&ospi1 {
+	status = "disabled";
+};
+
+&usbss0 {
 	bootph-pre-ram;
 };
 
-&main_sdhci1 {
+&usb0 {
+	dr_mode = "peripheral";
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-j721s2-common-proc-board.dts b/arch/arm/dts/k3-j721s2-common-proc-board.dts
index 3bba6473a3b6..c6b85bbf9a17 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-common-proc-board.dts
@@ -2,13 +2,17 @@
 /*
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *
- * Link to Common Processor Board: https://www.ti.com/lit/zip/sprr439
+ * Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM
  */
 
 /dts-v1/;
 
 #include "k3-j721s2-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,j721s2-evm", "ti,j721s2";
@@ -16,16 +20,18 @@
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
 	};
 
 	aliases {
+		serial1 = &mcu_uart0;
 		serial2 = &main_uart8;
 		mmc0 = &main_sdhci0;
 		mmc1 = &main_sdhci1;
 		can0 = &main_mcan16;
 		can1 = &mcu_mcan0;
 		can2 = &mcu_mcan1;
+		can3 = &main_mcan3;
+		can4 = &main_mcan5;
 	};
 
 	evm_12v0: fixedregulator-evm12v0 {
@@ -106,10 +112,26 @@
 		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
 	};
 
+	transceiver3: can-phy3 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux0 1>;
+	};
+
+	transceiver4: can-phy4 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux1 1>;
+	};
 };
 
 &main_pmx0 {
-	main_uart8_pins_default: main-uart8-pins-default {
+	main_uart8_pins_default: main-uart8-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x040, PIN_INPUT, 14) /* (AC28) MCASP0_AXR0.UART8_CTSn */
 			J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
@@ -118,14 +140,14 @@
 		>;
 	};
 
-	main_i2c3_pins_default: main-i2c3-pins-default {
+	main_i2c3_pins_default: main-i2c3-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x064, PIN_INPUT_PULLUP, 13) /* (W28) MCAN0_TX.I2C3_SCL */
 			J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
 			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
@@ -138,129 +160,173 @@
 		>;
 	};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
 		>;
 	};
-};
 
-&wkup_pmx0 {
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
-			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
-			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
-			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
-			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
-			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
-			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
-			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
-			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
-			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
-			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio-pins-default {
+	main_mcan3_pins_default: main-mcan3-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
-			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+			J721S2_IOPAD(0x080, PIN_INPUT, 0) /* (U26) MCASP0_AXR4.MCAN3_RX */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 0) /* (T27) MCASP0_AXR3.MCAN3_TX */
 		>;
 	};
 
-	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
+	main_mcan5_pins_default: main-mcan5-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
-			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+			J721S2_IOPAD(0x03c, PIN_INPUT, 0) /* (U27) MCASP0_AFSX.MCAN5_RX */
+			J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
 		>;
 	};
+};
 
-	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
+&wkup_pmx2 {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
-			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX */
+			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
 	};
 
-	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) WKUP_GPIO0_0 */
-			J721S2_WKUP_IOPAD(0x0a8, PIN_INPUT, 7) /* (B25) MCU_SPI0_D1.WKUP_GPIO0_69 */
+			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B24) WKUP_GPIO0_14.MCU_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (D25) WKUP_GPIO0_15.MCU_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
 	};
 
-	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
+			J721S2_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
 		>;
 	};
-};
 
-&main_gpio2 {
-	status = "disabled";
-};
-
-&main_gpio4 {
-	status = "disabled";
-};
+	mcu_mdio_pins_default: mcu-mdio-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+		>;
+	};
 
-&main_gpio6 {
-	status = "disabled";
-};
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+		>;
+	};
 
-&wkup_gpio1 {
-	status = "disabled";
-};
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /*(C23) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
 
-&wkup_uart0 {
-	status = "reserved";
-};
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 7) /* (D26) WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (B25) MCU_SPI0_D1.WKUP_GPIO0_69 */
+		>;
+	};
 
-&main_uart0 {
-	status = "disabled";
-};
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
+		>;
+	};
 
-&main_uart1 {
-	status = "disabled";
-};
+	mcu_adc0_pins_default: mcu-adc0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0cc, PIN_INPUT, 0) /* (L25) MCU_ADC0_AIN0 */
+			J721S2_WKUP_IOPAD(0x0d0, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN1 */
+			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (M24) MCU_ADC0_AIN2 */
+			J721S2_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (L24) MCU_ADC0_AIN3 */
+			J721S2_WKUP_IOPAD(0x0dc, PIN_INPUT, 0) /* (L27) MCU_ADC0_AIN4 */
+			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN5 */
+			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (M27) MCU_ADC0_AIN6 */
+			J721S2_WKUP_IOPAD(0x0e8, PIN_INPUT, 0) /* (M26) MCU_ADC0_AIN7 */
+		>;
+	};
 
-&main_uart2 {
-	status = "disabled";
+	mcu_adc1_pins_default: mcu-adc1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0ec, PIN_INPUT, 0) /* (P25) MCU_ADC1_AIN0 */
+			J721S2_WKUP_IOPAD(0x0f0, PIN_INPUT, 0) /* (R25) MCU_ADC1_AIN1 */
+			J721S2_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (P28) MCU_ADC1_AIN2 */
+			J721S2_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (P27) MCU_ADC1_AIN3 */
+			J721S2_WKUP_IOPAD(0x0fc, PIN_INPUT, 0) /* (N25) MCU_ADC1_AIN4 */
+			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (P26) MCU_ADC1_AIN5 */
+			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (N26) MCU_ADC1_AIN6 */
+			J721S2_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (N27) MCU_ADC1_AIN7 */
+		>;
+	};
 };
 
-&main_uart3 {
-	status = "disabled";
+&wkup_pmx1 {
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
+			J721S2_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
+			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
+			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
+			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
+			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
+		>;
+	};
 };
 
-&main_uart4 {
-	status = "disabled";
+&main_gpio0 {
+	status = "okay";
 };
 
-&main_uart5 {
-	status = "disabled";
+&wkup_gpio0 {
+	status = "okay";
 };
 
-&main_uart6 {
-	status = "disabled";
+&wkup_uart0 {
+	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
-&main_uart7 {
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart8 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
 };
 
-&main_uart9 {
-	status = "disabled";
-};
-
 &main_i2c0 {
 	clock-frequency = <400000>;
 
@@ -290,32 +356,9 @@
 	};
 };
 
-&main_i2c1 {
-	status = "disabled";
-};
-
-&main_i2c2 {
-	status = "disabled";
-};
-
-&main_i2c3 {
-	status = "disabled";
-};
-
-&main_i2c4 {
-	status = "disabled";
-};
-
-&main_i2c5 {
-	status = "disabled";
-};
-
-&main_i2c6 {
-	status = "disabled";
-};
-
 &main_sdhci0 {
 	/* eMMC */
+	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -323,6 +366,7 @@
 
 &main_sdhci1 {
 	/* SD card */
+	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	disable-wp;
@@ -332,7 +376,7 @@
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
@@ -349,82 +393,112 @@
 	phy-handle = <&phy0>;
 };
 
-&mcu_mcan0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_mcan0_pins_default>;
-	phys = <&transceiver1>;
-};
-
-&mcu_mcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_mcan1_pins_default>;
-	phys = <&transceiver2>;
+&serdes_ln_ctrl {
+	idle-states = <J721S2_SERDES0_LANE0_PCIE1_LANE0>, <J721S2_SERDES0_LANE1_USB>,
+		      <J721S2_SERDES0_LANE2_EDP_LANE2>, <J721S2_SERDES0_LANE3_EDP_LANE3>;
 };
 
-&main_mcan0 {
-	status = "disabled";
+&serdes_refclk {
+	clock-frequency = <100000000>;
 };
 
-&main_mcan1 {
-	status = "disabled";
-};
-
-&main_mcan2 {
-	status = "disabled";
-};
-
-&main_mcan3 {
-	status = "disabled";
-};
-
-&main_mcan4 {
-	status = "disabled";
-};
-
-&main_mcan5 {
-	status = "disabled";
+&serdes0 {
+	status = "okay";
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
 };
 
-&main_mcan6 {
-	status = "disabled";
+&usb_serdes_mux {
+	idle-states = <1>; /* USB0 to SERDES lane 1 */
 };
 
-&main_mcan7 {
-	status = "disabled";
+&usbss0 {
+	status = "okay";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	pinctrl-names = "default";
+	ti,vbus-divider;
+	ti,usb2-only;
 };
 
-&main_mcan8 {
-	status = "disabled";
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
 };
 
-&main_mcan9 {
-	status = "disabled";
+&ospi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <40000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+	};
 };
 
-&main_mcan10 {
-	status = "disabled";
+&pcie1_rc {
+	status = "okay";
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
 };
 
-&main_mcan11 {
-	status = "disabled";
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
 };
 
-&main_mcan12 {
-	status = "disabled";
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
 };
 
-&main_mcan13 {
-	status = "disabled";
+&tscadc0 {
+	pinctrl-0 = <&mcu_adc0_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
 };
 
-&main_mcan14 {
-	status = "disabled";
+&tscadc1 {
+	pinctrl-0 = <&mcu_adc1_pins_default>;
+	pinctrl-names = "default";
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
 };
 
-&main_mcan15 {
-	status = "disabled";
+&main_mcan3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan3_pins_default>;
+	phys = <&transceiver3>;
 };
 
-&main_mcan17 {
-	status = "disabled";
+&main_mcan5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan5_pins_default>;
+	phys = <&transceiver4>;
 };
diff --git a/arch/arm/dts/k3-j721s2-main.dtsi b/arch/arm/dts/k3-j721s2-main.dtsi
index 976ba1e95aba..084f8f5b6699 100644
--- a/arch/arm/dts/k3-j721s2-main.dtsi
+++ b/arch/arm/dts/k3-j721s2-main.dtsi
@@ -5,6 +5,17 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: clock-cmnrefclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -26,6 +37,101 @@
 		};
 	};
 
+	scm_conf: syscon@104000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x00104000 0x00 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00104000 0x18000>;
+
+		usb_serdes_mux: mux-controller@0 {
+			compatible = "mmio-mux";
+			reg = <0x0 0x4>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+		};
+
+		phy_gmii_sel_cpsw: phy@34 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x34 0x4>;
+			#phy-cells = <1>;
+		};
+
+		serdes_ln_ctrl: mux-controller@80 {
+			compatible = "mmio-mux";
+			reg = <0x80 0x10>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
+					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
+		};
+
+		ehrpwm_tbclk: clock-controller@140 {
+			compatible = "ti,am654-ehrpwm-tbclk";
+			reg = <0x140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 160 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 161 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 162 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 163 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 164 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 165 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
@@ -33,8 +139,11 @@
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
-		      <0x00 0x01900000 0x00 0x100000>; /* GICR */
+		reg = <0x00 0x01800000 0x00 0x100000>, /* GICD */
+		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;   /* GICV */
 
 		/* vcpumntirq: virtual CPU interface maintenance interrupt */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -57,7 +166,7 @@
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <148>;
-		ti,interrupt-ranges = <8 360 56>;
+		ti,interrupt-ranges = <8 392 56>;
 	};
 
 	main_pmx0: pinctrl@11c000 {
@@ -69,6 +178,283 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104200 0x00 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000007>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104280 0x00 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
+	main_crypto: crypto@4e00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x04e00000 0x00 0x1200>;
+		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
+
+		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
+		       <&main_udmap 0x4a41>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x04e10000 0x00 0x7d>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 63 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 63 1>;
+		assigned-clock-parents = <&k3_clks 63 2>;
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 64 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 64 1>;
+		assigned-clock-parents = <&k3_clks 64 2>;
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 65 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 65 1>;
+		assigned-clock-parents = <&k3_clks 65 2>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 66 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 66 1>;
+		assigned-clock-parents = <&k3_clks 66 2>;
+		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 67 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 67 1>;
+		assigned-clock-parents = <&k3_clks 67 2>;
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 68 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 68 1>;
+		assigned-clock-parents = <&k3_clks 68 2>;
+		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 69 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 69 1>;
+		assigned-clock-parents = <&k3_clks 69 2>;
+		power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 70 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 70 1>;
+		assigned-clock-parents = <&k3_clks 70 2>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 71 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 71 1>;
+		assigned-clock-parents = <&k3_clks 71 2>;
+		power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 72 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 72 1>;
+		assigned-clock-parents = <&k3_clks 72 2>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 73 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 73 1>;
+		assigned-clock-parents = <&k3_clks 73 2>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 74 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 74 1>;
+		assigned-clock-parents = <&k3_clks 74 2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 75 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 75 1>;
+		assigned-clock-parents = <&k3_clks 75 2>;
+		power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 76 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 76 1>;
+		assigned-clock-parents = <&k3_clks 76 2>;
+		power-domains = <&k3_pds 76 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 77 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 77 1>;
+		assigned-clock-parents = <&k3_clks 77 2>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 78 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 78 1>;
+		assigned-clock-parents = <&k3_clks 78 2>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 79 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 79 1>;
+		assigned-clock-parents = <&k3_clks 79 2>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 80 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 80 1>;
+		assigned-clock-parents = <&k3_clks 80 2>;
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 81 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 81 1>;
+		assigned-clock-parents = <&k3_clks 81 2>;
+		power-domains = <&k3_pds 81 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 82 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 82 1>;
+		assigned-clock-parents = <&k3_clks 82 2>;
+		power-domains = <&k3_pds 82 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
@@ -77,6 +463,7 @@
 		clocks = <&k3_clks 146 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -87,6 +474,7 @@
 		clocks = <&k3_clks 350 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -97,6 +485,7 @@
 		clocks = <&k3_clks 351 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -107,6 +496,7 @@
 		clocks = <&k3_clks 352 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -117,6 +507,7 @@
 		clocks = <&k3_clks 353 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -127,6 +518,7 @@
 		clocks = <&k3_clks 354 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -137,6 +529,7 @@
 		clocks = <&k3_clks 355 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -147,6 +540,7 @@
 		clocks = <&k3_clks 356 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -157,6 +551,7 @@
 		clocks = <&k3_clks 357 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -167,6 +562,7 @@
 		clocks = <&k3_clks 358 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_gpio0: gpio@600000 {
@@ -183,6 +579,7 @@
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 111 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio2: gpio@610000 {
@@ -199,6 +596,7 @@
 		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 112 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio4: gpio@620000 {
@@ -215,6 +613,7 @@
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 113 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio6: gpio@630000 {
@@ -231,6 +630,7 @@
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_i2c0: i2c@2000000 {
@@ -253,6 +653,7 @@
 		clocks = <&k3_clks 215 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 215 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -264,6 +665,7 @@
 		clocks = <&k3_clks 216 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 216 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -275,6 +677,7 @@
 		clocks = <&k3_clks 217 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c4: i2c@2040000 {
@@ -286,6 +689,7 @@
 		clocks = <&k3_clks 218 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c5: i2c@2050000 {
@@ -297,6 +701,7 @@
 		clocks = <&k3_clks 219 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c6: i2c@2060000 {
@@ -308,6 +713,7 @@
 		clocks = <&k3_clks 220 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_sdhci0: mmc@4f80000 {
@@ -317,7 +723,7 @@
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 98 7>, <&k3_clks 98 1>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 98 1>;
 		assigned-clock-parents = <&k3_clks 98 2>;
 		bus-width = <8>;
@@ -335,6 +741,7 @@
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
 		dma-coherent;
+		status = "disabled";
 	};
 
 	main_sdhci1: mmc@4fb0000 {
@@ -344,7 +751,7 @@
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 99 8>, <&k3_clks 99 1>;
-		clock-names =  "clk_ahb", "clk_xin";
+		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 99 1>;
 		assigned-clock-parents = <&k3_clks 99 2>;
 		bus-width = <4>;
@@ -363,7 +770,8 @@
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 		/* Masking support for SDR104 capability */
-	//	sdhci-caps-mask = <0x00000003 0x00000000>;
+		sdhci-caps-mask = <0x00000003 0x00000000>;
+		status = "disabled";
 	};
 
 	main_navss: bus@30000000 {
@@ -425,6 +833,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -434,6 +843,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -443,6 +853,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -452,6 +863,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -461,6 +873,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -470,6 +883,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -479,6 +893,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -488,6 +903,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -497,6 +913,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -506,6 +923,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -515,6 +933,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -524,6 +943,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster0: mailbox@31f90000 {
@@ -533,6 +953,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster1: mailbox@31f91000 {
@@ -542,6 +963,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster2: mailbox@31f92000 {
@@ -551,6 +973,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster3: mailbox@31f93000 {
@@ -560,6 +983,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster4: mailbox@31f94000 {
@@ -569,6 +993,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster5: mailbox@31f95000 {
@@ -578,6 +1003,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster6: mailbox@31f96000 {
@@ -587,6 +1013,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster7: mailbox@31f97000 {
@@ -596,6 +1023,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster8: mailbox@31f98000 {
@@ -605,6 +1033,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster9: mailbox@31f99000 {
@@ -614,6 +1043,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster10: mailbox@31f9a000 {
@@ -623,6 +1053,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster11: mailbox@31f9b000 {
@@ -632,6 +1063,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
@@ -639,8 +1071,9 @@
 			reg = <0x0 0x3c000000 0x0 0x400000>,
 			      <0x0 0x38000000 0x0 0x400000>,
 			      <0x0 0x31120000 0x0 0x100>,
-			      <0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x33000000 0x0 0x40000>,
+			      <0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
@@ -676,6 +1109,8 @@
 			reg-names = "cpts";
 			clocks = <&k3_clks 226 5>;
 			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 226 5>; /* NAVSS0_CPTS_0_RCLK */
+			assigned-clock-parents = <&k3_clks 226 7>; /* MAIN_0_HSDIVOUT6_CLK */
 			interrupts-extended = <&main_navss_intr 391>;
 			interrupt-names = "cpts";
 			ti,cpts-periodic-outputs = <6>;
@@ -683,6 +1118,180 @@
 		};
 	};
 
+	main_cpsw: ethernet@c200000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0xc200000 0x0 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 28 28>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 28 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xc640>,
+		       <&main_udmap 0xc641>,
+		       <&main_udmap 0xc642>,
+		       <&main_udmap 0xc643>,
+		       <&main_udmap 0xc644>,
+		       <&main_udmap 0xc645>,
+		       <&main_udmap 0xc646>,
+		       <&main_udmap 0xc647>,
+		       <&main_udmap 0x4640>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				phys = <&phy_gmii_sel_cpsw 1>;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 28 28>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 28 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	usbss0: cdns-usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x04104000 0x00 0x100>;
+		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 360 17>;
+		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-coherent;
+
+		status = "disabled"; /* Needs pinmux */
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x06000000 0x00 0x10000>,
+			      <0x00 0x06010000 0x00 0x10000>,
+			      <0x00 0x06020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
+
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j721s2-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x5060000 0x0 0x5060000 0x10000>;
+
+		assigned-clocks = <&k3_clks 365 3>;
+		assigned-clock-parents = <&k3_clks 365 7>;
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 365 3>,
+						 <&k3_clks 365 3>,
+						 <&k3_clks 365 3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled"; /* Needs lane config */
+		};
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x800000>,
+		      <0x00 0x18000000 0x00 0x1000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 41>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb013>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
+				<0 0 0 2 &pcie1_intc 0>, /* INT B */
+				<0 0 0 3 &pcie1_intc 0>, /* INT C */
+				<0 0 0 4 &pcie1_intc 0>; /* INT D */
+
+		status = "disabled"; /* Needs gpio and serdes info */
+
+		pcie1_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
@@ -695,6 +1304,7 @@
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan1: can@2711000 {
@@ -709,6 +1319,7 @@
 			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan2: can@2721000 {
@@ -723,6 +1334,7 @@
 			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan3: can@2731000 {
@@ -737,6 +1349,7 @@
 			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan4: can@2741000 {
@@ -751,6 +1364,7 @@
 			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan5: can@2751000 {
@@ -765,6 +1379,7 @@
 			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan6: can@2761000 {
@@ -779,6 +1394,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan7: can@2771000 {
@@ -793,6 +1409,7 @@
 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan8: can@2781000 {
@@ -807,6 +1424,7 @@
 			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan9: can@2791000 {
@@ -821,6 +1439,7 @@
 			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan10: can@27a1000 {
@@ -835,6 +1454,7 @@
 			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan11: can@27b1000 {
@@ -849,6 +1469,7 @@
 			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan12: can@27c1000 {
@@ -863,6 +1484,7 @@
 			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan13: can@27d1000 {
@@ -877,6 +1499,7 @@
 			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan14: can@2681000 {
@@ -891,6 +1514,7 @@
 			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan15: can@2691000 {
@@ -905,6 +1529,7 @@
 			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan16: can@26a1000 {
@@ -919,6 +1544,7 @@
 			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan17: can@26b1000 {
@@ -933,5 +1559,140 @@
 			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 339 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 339 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 340 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 340 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 341 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 341 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 342 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 342 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 343 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 343 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 344 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 344 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 345 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 346 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 346 1>;
+		status = "disabled";
+	};
+
+	dss: dss@4a00000 {
+		compatible = "ti,j721e-dss";
+		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
+		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
+		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
+		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
+		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
+		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
+		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
+		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
+		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
+		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
+		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
+		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
+		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
+		      <0x00 0x04aa0000 0x00 0x10000>, /* vp2 */
+		      <0x00 0x04ac0000 0x00 0x10000>, /* vp3 */
+		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
+		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
+		reg-names = "common_m", "common_s0",
+			    "common_s1", "common_s2",
+			    "vidl1", "vidl2","vid1","vid2",
+			    "ovr1", "ovr2", "ovr3", "ovr4",
+			    "vp1", "vp2", "vp3", "vp4",
+			    "wb";
+		clocks = <&k3_clks 158 0>,
+			 <&k3_clks 158 2>,
+			 <&k3_clks 158 5>,
+			 <&k3_clks 158 14>,
+			 <&k3_clks 158 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+		status = "disabled";
+
+		dss_ports: ports {
+		};
 	};
 };
diff --git a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
index 7521963719ff..2ddad9318554 100644
--- a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x00 0x1000>;
@@ -39,6 +39,21 @@
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
 
+	secure_proxy_sa3: mailbox@43600000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x43600000 0x00 0x10000>,
+		      <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_ram: sram@41c00000 {
 		compatible = "mmio-sram";
 		reg = <0x00 0x41c00000 0x00 0x100000>;
@@ -50,12 +65,61 @@
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x034>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02C>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04200 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04280 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
 	wkup_gpio_intr: interrupt-controller@42200000 {
 		compatible = "ti,sci-intr";
 		reg = <0x00 0x42200000 0x00 0x400>;
@@ -65,7 +129,7 @@
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <125>;
-		ti,interrupt-ranges = <16 928 16>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	mcu_conf: syscon@40f00000 {
@@ -83,6 +147,146 @@
 
 	};
 
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 1>;
+		assigned-clock-parents = <&k3_clks 35 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 83 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 83 1>;
+		assigned-clock-parents = <&k3_clks 83 2>;
+		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 84 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 84 1>;
+		assigned-clock-parents = <&k3_clks 84 2>;
+		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 85 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 85 1>;
+		assigned-clock-parents = <&k3_clks 85 2>;
+		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 86 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 86 1>;
+		assigned-clock-parents = <&k3_clks 86 2>;
+		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 87 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 87 1>;
+		assigned-clock-parents = <&k3_clks 87 2>;
+		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 88 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 88 1>;
+		assigned-clock-parents = <&k3_clks 88 2>;
+		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 89 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 89 1>;
+		assigned-clock-parents = <&k3_clks 89 2>;
+		power-domains = <&k3_pds 89 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 90 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 90 1>;
+		assigned-clock-parents = <&k3_clks 90 2>;
+		power-domains = <&k3_pds 90 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 91 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 91 1>;
+		assigned-clock-parents = <&k3_clks 91 2>;
+		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x200>;
@@ -91,6 +295,7 @@
 		clocks = <&k3_clks 359 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -101,6 +306,7 @@
 		clocks = <&k3_clks 149 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_gpio0: gpio@42110000 {
@@ -108,7 +314,7 @@
 		reg = <0x00 0x42110000 0x00 0x100>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
+		interrupt-parent = <&wkup_gpio_intr>;
 		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -117,6 +323,7 @@
 		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 115 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	wkup_gpio1: gpio@42100000 {
@@ -124,7 +331,7 @@
 		reg = <0x00 0x42100000 0x00 0x100>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
+		interrupt-parent = <&wkup_gpio_intr>;
 		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -133,6 +340,7 @@
 		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 116 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
@@ -144,6 +352,7 @@
 		clocks = <&k3_clks 223 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c0: i2c@40b00000 {
@@ -155,6 +364,7 @@
 		clocks = <&k3_clks 221 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@40b10000 {
@@ -166,6 +376,7 @@
 		clocks = <&k3_clks 222 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_mcan0: can@40528000 {
@@ -180,6 +391,7 @@
 			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	mcu_mcan1: can@40568000 {
@@ -194,9 +406,43 @@
 			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 347 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 347 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 348 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 349 0>;
+		status = "disabled";
 	};
 
-	mcu_navss: bus@28380000{
+	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -211,8 +457,9 @@
 			reg = <0x0 0x2b800000 0x0 0x400000>,
 			      <0x0 0x2b000000 0x0 0x400000>,
 			      <0x0 0x28590000 0x0 0x100>,
-			      <0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			      <0x0 0x2a500000 0x0 0x40000>,
+			      <0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>;
 			ti,sci = <&sms>;
@@ -240,6 +487,21 @@
 		};
 	};
 
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x2a480000 0x00 0x80000>,
+		      <0x00 0x2a380000 0x00 0x80000>,
+		      <0x00 0x2a400000 0x00 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_cpsw: ethernet@46000000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		#address-cells = <2>;
@@ -293,10 +555,104 @@
 			reg = <0x0 0x3d000 0x0 0x400>;
 			clocks = <&k3_clks 29 3>;
 			clock-names = "cpts";
+			assigned-clocks = <&k3_clks 29 3>; /* CPTS_RFT_CLK */
+			assigned-clock-parents = <&k3_clks 29 5>; /* MAIN_0_HSDIVOUT6_CLK */
 			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cpts";
 			ti,cpts-ext-ts-inputs = <4>;
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40200000 0x00 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x00 0x40210000 0x00 0x1000>;
+		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 1 0>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 109 5>;
+			assigned-clocks = <&k3_clks 109 5>;
+			assigned-clock-parents = <&k3_clks 109 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled"; /* Needs pinmux */
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x07 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 110 5>;
+			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled"; /* Needs pinmux */
+		};
+	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x0 0x350>,
+		      <0x00 0x42050000 0x0 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index c74e8e58ae81..03bd680f4421 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -1,20 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
 
-#include "k3-j721s2-som-p0.dtsi"
+#include "k3-j721s2-common-proc-board.dts"
 #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
 #include "k3-j721s2-ddr.dtsi"
-#include "k3-j721s2-binman.dtsi"
+#include "k3-j721s2-common-proc-board-u-boot.dtsi"
 
 / {
 	chosen {
-		firmware-loader = &fs_loader0;
-		stdout-path = &main_uart8;
-		tick-timer = &timer1;
+		tick-timer = &mcu_timer0;
 	};
 
 	aliases {
@@ -22,11 +20,6 @@
 		remoteproc1 = &a72_0;
 	};
 
-	fs_loader0: fs_loader@0 {
-		compatible = "u-boot,fs-loader";
-		bootph-all;
-	};
-
 	a72_0: a72@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
@@ -44,149 +37,46 @@
 		bootph-pre-ram;
 	};
 
-	clk_200mhz: dummy_clock_200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-
-	clk_19_2mhz: dummy_clock_19_2mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <19200000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_mcu_wakeup {
-	sa3_secproxy: secproxy@44880000 {
-		bootph-pre-ram;
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x44880000 0x0 0x20000>,
-		      <0x0 0x44860000 0x0 0x20000>,
-		      <0x0 0x43600000 0x0 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-	};
-
-	mcu_secproxy: secproxy@2a380000 {
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-		bootph-pre-ram;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>, <&sa3_secproxy 5>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-
 	dm_tifs: dm-tifs {
 		compatible = "ti,j721e-dm-sci";
 		ti,host-id = <3>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&mcu_secproxy 21>,
-			<&mcu_secproxy 23>;
+		mboxes= <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
 		bootph-pre-ram;
 	};
 };
 
-&main_pmx0 {
-	main_uart8_pins_default: main-uart8-pins-default {
-		pinctrl-single,pins = <
-			J721S2_IOPAD(0x040, PIN_INPUT, 14) /* (AC28) MCASP0_AXR0.UART8_CTSn */
-			J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
-			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
-			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
-		>;
-	};
+&mcu_timer0 {
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
+};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
-		pinctrl-single,pins = <
-			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
-			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
-			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
-			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
-			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
-			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
-			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
-			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
-		>;
-	};
+&secure_proxy_sa3 {
+	bootph-pre-ram;
+	status = "okay";
 };
 
-&wkup_pmx0 {
-	mcu_uart0_pins_default: mcu-uart0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (B24) WKUP_GPIO0_14.MCU_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (D25) WKUP_GPIO0_15.MCU_UART0_RTSn */
-			J721S2_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
-		>;
-	};
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	status = "okay";
+};
 
-	wkup_uart0_pins_default: wkup-uart0-pins-default {
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
+		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
-			J721S2_WKUP_IOPAD(0x0b0, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x0b4, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
-		>;
 	};
 };
 
 &sms {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
+	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
-	bootph-pre-ram;
-};
-
-&wkup_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
-};
-
-&mcu_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
-};
-
-&main_uart8 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart8_pins_default>;
-};
-
-&main_sdhci0 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
-	non-removable;
-	bus-width = <8>;
-};
-
-&main_sdhci1 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	pinctrl-names = "default";
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
 };
 
 &mcu_ringacc {
@@ -196,5 +86,3 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
-
-#include "k3-j721s2-common-proc-board-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-j721s2-som-p0.dtsi b/arch/arm/dts/k3-j721s2-som-p0.dtsi
index c0687fece017..a4006f328027 100644
--- a/arch/arm/dts/k3-j721s2-som-p0.dtsi
+++ b/arch/arm/dts/k3-j721s2-som-p0.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * SoM: https://www.ti.com/lit/zip/sprr439
+ *
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
@@ -16,6 +18,7 @@
 		      <0x08 0x80000000 0x03 0x80000000>;
 	};
 
+	/* Reserving memory regions still pending */
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -26,7 +29,18 @@
 			alignment = <0x1000>;
 			no-map;
 		};
+	};
+
+	mux0: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
+	};
 
+	mux1: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
 	};
 
 	transceiver0: can-phy0 {
@@ -37,15 +51,43 @@
 	};
 };
 
+&wkup_pmx0 {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
+			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
+			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
+			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
+			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (F18) MCU_OSPI0_D3 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (E19) MCU_OSPI0_D4 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D5 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (F19) MCU_OSPI0_D6 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
+			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
+		>;
+	};
+};
+
+&wkup_pmx2 {
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
 &main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AH25) I2C0_SCL */
 			J721S2_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AE24) I2C0_SDA */
 		>;
 	};
 
-	main_mcan16_pins_default: main-mcan16-pins-default {
+	main_mcan16_pins_default: main-mcan16-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x028, PIN_INPUT, 0) /* (AB24) MCAN16_RX */
 			J721S2_IOPAD(0x024, PIN_OUTPUT, 0) /* (Y28) MCAN16_TX */
@@ -53,7 +95,21 @@
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -71,103 +127,27 @@
 };
 
 &main_mcan16 {
+	status = "okay";
 	pinctrl-0 = <&main_mcan16_pins_default>;
 	pinctrl-names = "default";
 	phys = <&transceiver0>;
 };
 
-&mailbox0_cluster0 {
-	status = "disabled";
-};
-
-&mailbox0_cluster1 {
-	status = "disabled";
-};
-
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
-};
-
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
-&mailbox1_cluster0 {
-	status = "disabled";
-};
-
-&mailbox1_cluster1 {
-	status = "disabled";
-};
-
-&mailbox1_cluster2 {
-	status = "disabled";
-};
-
-&mailbox1_cluster3 {
-	status = "disabled";
-};
-
-&mailbox1_cluster4 {
-	status = "disabled";
-};
-
-&mailbox1_cluster5 {
-	status = "disabled";
-};
-
-&mailbox1_cluster6 {
-	status = "disabled";
-};
-
-&mailbox1_cluster7 {
-	status = "disabled";
-};
-
-&mailbox1_cluster8 {
-	status = "disabled";
-};
-
-&mailbox1_cluster9 {
-	status = "disabled";
-};
-
-&mailbox1_cluster10 {
-	status = "disabled";
-};
-
-&mailbox1_cluster11 {
-	status = "disabled";
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+	};
 };
diff --git a/arch/arm/dts/k3-j721s2-thermal.dtsi b/arch/arm/dts/k3-j721s2-thermal.dtsi
new file mode 100644
index 000000000000..f7b1a15b8fa0
--- /dev/null
+++ b/arch/arm/dts/k3-j721s2-thermal.dtsi
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+wkup0_thermal: wkup0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 0>;
+
+	trips {
+		wkup0_crit: wkup0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+wkup1_thermal: wkup1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 1>;
+
+	trips {
+		wkup1_crit: wkup1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main0_thermal: main0-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 2>;
+
+	trips {
+		main0_crit: main0-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main1_thermal: main1-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 3>;
+
+	trips {
+		main1_crit: main1-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main2_thermal: main2-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 4>;
+
+	trips {
+		main2_crit: main2-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main3_thermal: main3-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 5>;
+
+	trips {
+		main3_crit: main3-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+main4_thermal: main4-thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 6>;
+
+	trips {
+		main4_crit: main4-crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j721s2.dtsi b/arch/arm/dts/k3-j721s2.dtsi
index fe5234c40f6c..1f636acd4eee 100644
--- a/arch/arm/dts/k3-j721s2.dtsi
+++ b/arch/arm/dts/k3-j721s2.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J721S2 SoC Family
  *
- * TRM (SPRUJ28 – NOVEMBER 2021) : http://www.ti.com/lit/pdf/spruj28
+ * TRM (SPRUJ28 NOVEMBER 2021): https://www.ti.com/lit/pdf/spruj28
  *
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *
@@ -10,9 +10,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/k3.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
+#include "k3-pinctrl.h"
+
 / {
 
 	model = "Texas Instruments K3 J721S2 SoC";
@@ -69,6 +70,7 @@
 
 	L2_0: l2-cache0 {
 		compatible = "cache";
+		cache-unified;
 		cache-level = <2>;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
@@ -79,6 +81,7 @@
 	msmc_l3: l3-cache0 {
 		compatible = "cache";
 		cache-level = <3>;
+		cache-unified;
 	};
 
 	firmware {
@@ -119,6 +122,7 @@
 			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
 			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
 			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
@@ -160,6 +164,10 @@
 		};
 
 	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j721s2-thermal.dtsi"
+	};
 };
 
 /* Now include peripherals from each bus segment */
diff --git a/arch/arm/dts/k3-serdes.h b/arch/arm/dts/k3-serdes.h
new file mode 100644
index 000000000000..29167f85c1f6
--- /dev/null
+++ b/arch/arm/dts/k3-serdes.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for SERDES MUX for TI SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef DTS_ARM64_TI_K3_SERDES_H
+#define DTS_ARM64_TI_K3_SERDES_H
+
+/* J721E */
+
+#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
+#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
+#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
+#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
+#define J721E_SERDES0_LANE1_USB3_0		0x2
+#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
+#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
+#define J721E_SERDES1_LANE1_USB3_1		0x2
+#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
+#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
+#define J721E_SERDES2_LANE1_USB3_1		0x2
+#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
+#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
+#define J721E_SERDES3_LANE1_USB3_0		0x2
+#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
+#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
+#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
+#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
+#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
+#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
+#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
+#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
+#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
+
+/* J7200 */
+
+#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
+#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
+#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
+#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
+#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
+#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
+#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
+#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
+#define J7200_SERDES0_LANE3_USB			0x2
+#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* AM64 */
+
+#define AM64_SERDES0_LANE0_PCIE0		0x0
+#define AM64_SERDES0_LANE0_USB			0x1
+
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* J784S4 */
+
+#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
+#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
+#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J784S4_SERDES0_LANE3_USB		0x2
+#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
+#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
+#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
+#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
+#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
+#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
+#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
+#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
+#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
+#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
+#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
+#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
+#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
+#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
+#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE0_EDP_LANE0		0x0
+#define J784S4_SERDES4_LANE0_QSGMII_LANE5	0x1
+#define J784S4_SERDES4_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE1_EDP_LANE1		0x0
+#define J784S4_SERDES4_LANE1_QSGMII_LANE6	0x1
+#define J784S4_SERDES4_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE2_EDP_LANE2		0x0
+#define J784S4_SERDES4_LANE2_QSGMII_LANE7	0x1
+#define J784S4_SERDES4_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE3_EDP_LANE3		0x0
+#define J784S4_SERDES4_LANE3_QSGMII_LANE8	0x1
+#define J784S4_SERDES4_LANE3_USB		0x2
+#define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
+
+#endif /* DTS_ARM64_TI_K3_SERDES_H */

-- 
2.41.0

