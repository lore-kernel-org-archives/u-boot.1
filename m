Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5D8EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 17:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFC086E93;
	Mon, 11 Sep 2023 19:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DyrAnorM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E93986E88; Mon, 11 Sep 2023 19:33:38 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7413F86E62
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 19:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHXVH1115739;
 Mon, 11 Sep 2023 12:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694453611;
 bh=hEAYMkKToP3oUOkYScy3GO7cjH0yYKshbPkzdok2Uq0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DyrAnorMwOyDJa61HE5Gh4hitTqd/J6RQTByUaCH8UEQs9K7cpDfNnao/snBXyH1d
 BpJOWVtzei0KDLYH2grxRgSEuF/f9AUJz1GuFF6+qzVQkY4wXyLKI3Wzisnvrksm17
 kCn2xMoFMtm9rK8+e35cOxVdDlT2z2geUtBLJWtg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHXVfw013199
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 12:33:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:33:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:33:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHXVhD038846;
 Mon, 11 Sep 2023 12:33:31 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>
Subject: [PATCH v3 2/2] arm: dts: j7200: dts sync with Linux 6.6-rc1
Date: Mon, 11 Sep 2023 12:32:46 -0500
Message-ID: <20230911173246.97988-3-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911173246.97988-1-reidt@ti.com>
References: <20230911173246.97988-1-reidt@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Sync j7200 dts with Linux 6.6-rc1

- k3-j7200-r5-common-proc-board.dts now inherits from
  k3-j7200-common-proc-board.dts instead of k3-j7200-som-p0.dtsi. This
  allows us to trim down the r5 file considerably by using existing
  properties

- remove pimux nodes from r5 file

- remove duplicate nodes & node properties from r5/u-boot files

- mcu_timer0 now used instead of timer1

  mcu_timer0 device id added to dev-data.c file in order to work

- remove cpsw node

  This node is no longer required since the compatible is now fixed

- remove dummy_clock_19_2_mhz

  This node wasn't being used anyhere, so it was removed

- remove dummy_clock_200mhz

  main_sdhci0 & main_sdhci1 no longer need dummy clock for eMMC/SD

- fix secure proxy node

  mcu_secproxy changed to used secure_prxy_mcu which is already
  defined in k3-j7200-mcu-wakeup.dtsi

- removed &mcu_ringacc property override since they're present in
  v6.6-rc1

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Reid Tonking <reidt@ti.com>
---
 .../k3-j7200-common-proc-board-u-boot.dtsi    | 150 ++---
 arch/arm/dts/k3-j7200-common-proc-board.dts   | 188 +++---
 arch/arm/dts/k3-j7200-main.dtsi               | 535 +++++++++++++++++-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 286 +++++++++-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 301 +---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             | 154 +++--
 arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
 arch/arm/dts/k3-j7200.dtsi                    |  30 +-
 arch/arm/dts/k3-serdes.h                      | 204 +++++++
 9 files changed, 1382 insertions(+), 513 deletions(-)
 create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-serdes.h

diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
index f25c7136c9..41f94ae891 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
@@ -1,22 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-j7200-binman.dtsi"
 
 / {
 	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
-	aliases {
-		ethernet0 = &cpsw_port1;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &mcu_i2c1;
-		i2c3 = &main_i2c0;
+		tick-timer = &mcu_timer0;
 	};
 };
 
@@ -28,48 +19,36 @@
 	bootph-pre-ram;
 };
 
-&cbass_mcu_wakeup {
+&main_esm {
 	bootph-pre-ram;
+};
 
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <250000000>;
-		bootph-pre-ram;
-	};
+&cbass_mcu_wakeup {
+	bootph-pre-ram;
 
 	chipid@43000014 {
 		bootph-pre-ram;
 	};
+};
 
-	mcu_navss: bus@28380000 {
-		bootph-pre-ram;
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		ringacc@2b800000 {
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>,
-				<0x0 0x28440000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			bootph-pre-ram;
-		};
-
-		dma-controller@285c0000 {
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x284c0000 0x0 0x4000>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x284a0000 0x0 0x4000>,
-				<0x0 0x2aa00000 0x0 0x40000>,
-				<0x0 0x28400000 0x0 0x2000>;
-			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-					    "tchanrt", "rflow";
-			bootph-pre-ram;
-		};
-	};
+&mcu_navss {
+	bootph-pre-ram;
+};
+
+&mcu_ringacc {
+	bootph-pre-ram;
+};
+
+&mcu_udmap {
+	reg = <0x0 0x285c0000 0x0 0x100>,
+		<0x0 0x284c0000 0x0 0x4000>,
+		<0x0 0x2a800000 0x0 0x40000>,
+		<0x0 0x284a0000 0x0 0x4000>,
+		<0x0 0x2aa00000 0x0 0x40000>,
+		<0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+			    "tchanrt", "rflow";
+	bootph-pre-ram;
 };
 
 &secure_proxy_main {
@@ -100,6 +79,10 @@
 	bootph-pre-ram;
 };
 
+&wkup_pmx2 {
+	bootph-pre-ram;
+};
+
 &main_pmx0 {
 	bootph-pre-ram;
 };
@@ -108,6 +91,10 @@
 	bootph-pre-ram;
 };
 
+&main_uart2 {
+	bootph-pre-ram;
+};
+
 &mcu_uart0 {
 	bootph-pre-ram;
 };
@@ -128,7 +115,7 @@
 	bootph-pre-ram;
 };
 
-&main_i2c0_pins_default {
+&exp1 {
 	bootph-pre-ram;
 };
 
@@ -137,37 +124,50 @@
 };
 
 &mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x8>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
-
-	cpsw-phy-sel@40f04040 {
-		compatible = "ti,am654-cpsw-phy-sel";
-		reg= <0x0 0x40f04040 0x0 0x4>;
-		reg-names = "gmii-sel";
-	};
+	bootph-pre-ram;
 };
 
-&main_usbss0_pins_default {
+&mcu_uart0 {
 	bootph-pre-ram;
 };
 
-&usbss0 {
+&wkup_i2c0 {
 	bootph-pre-ram;
-	ti,usb2-only;
 };
 
-&usb0 {
-	dr_mode = "peripheral";
+&wkup_uart0 {
 	bootph-pre-ram;
 };
 
-&mcu_fss0_hpb0_pins_default {
+&fss {
 	bootph-pre-ram;
 };
 
-&fss {
+&main_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_mmc1_pins_default {
+	bootph-pre-ram;
+};
+
+&main_i2c0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_i2c0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_gpio_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_gpio0 {
 	bootph-pre-ram;
 };
 
@@ -183,18 +183,28 @@
 	bootph-pre-ram;
 };
 
+&usbss0 {
+	bootph-pre-ram;
+	ti,usb2-only;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	bootph-pre-ram;
+};
+
+&ospi0 {
+	bootph-pre-ram;
+};
+
 &serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
+	bootph-pre-ram;
 };
 
 &usb_serdes_mux {
-	u-boot,mux-autoprobe;
+	bootph-pre-ram;
 };
 
 &serdes0 {
 	bootph-pre-ram;
 };
-
-&main_r5fss0 {
-	ti,cluster-mode = <0>;
-};
diff --git a/arch/arm/dts/k3-j7200-common-proc-board.dts b/arch/arm/dts/k3-j7200-common-proc-board.dts
index d14f3c18b6..cee2b4b0eb 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-common-proc-board.dts
@@ -8,13 +8,26 @@
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "k3-serdes.h"
+
 / {
+	compatible = "ti,j7200-evm", "ti,j7200";
+	model = "Texas Instruments J7200 EVM";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial5 = &main_uart3;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	evm_12v0: fixedregulator-evm12v0 {
@@ -78,47 +91,87 @@
 };
 
 &wkup_pmx0 {
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
+			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+		>;
+	};
+
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
+		>;
+	};
+};
+
+&wkup_pmx2 {
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+		>;
+	};
+
+	wkup_gpio_pins_default: wkup-gpio-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
-			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
-			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
-			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
-			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
-			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
-			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
-			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
-			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
-			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
-			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
-			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+			J721E_WKUP_IOPAD(0x70, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+	mcu_mdio_pins_default: mcu-mdio1-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
-			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
 };
 
 &main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
-			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
+			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
+			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
+			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
+			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xb8, PIN_INPUT, 0) /* (T18) UART1_RXD */
+			J721E_IOPAD(0xbc, PIN_INPUT, 0) /* (T20) UART1_TXD */
+		>;
+	};
+
+	main_uart3_pins_default: main-uart3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x60, PIN_INPUT, 11) /* (T15) MCAN8_TX.UART3_CTSn */
+			J721E_IOPAD(0x30, PIN_INPUT, 11) /* (Y18) MCAN2_TX.UART3_RXD */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
 			J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
 			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
@@ -131,15 +184,17 @@
 		>;
 	};
 
-	main_usbss0_pins_default: main-usbss0-pins-default {
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
+			J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
 		>;
 	};
+};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+&main_pmx1 {
+	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
+			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
 		>;
 	};
 };
@@ -147,11 +202,30 @@
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
+	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
+	status = "okay";
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+&main_uart1 {
+	status = "okay";
+	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_uart2 {
@@ -160,59 +234,25 @@
 };
 
 &main_uart3 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart4 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart5 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart6 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart7 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart8 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart9 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_gpio2 {
-	status = "disabled";
-};
-
-&main_gpio4 {
-	status = "disabled";
+	/* Shared with MCAN Interface */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart3_pins_default>;
 };
 
-&main_gpio6 {
-	status = "disabled";
+&main_gpio0 {
+	status = "okay";
 };
 
-&wkup_gpio1 {
-	status = "disabled";
+&wkup_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_gpio_pins_default>;
 };
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
@@ -229,6 +269,7 @@
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -256,6 +297,7 @@
  * The i2c1 of the CPB (as it is labeled) is not connected to j7200.
  */
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
@@ -273,6 +315,7 @@
 
 &main_sdhci0 {
 	/* eMMC */
+	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -280,6 +323,7 @@
 
 &main_sdhci1 {
 	/* SD card */
+	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	vmmc-supply = <&vdd_mmc1>;
diff --git a/arch/arm/dts/k3-j7200-main.dtsi b/arch/arm/dts/k3-j7200-main.dtsi
index e8a41d09b4..cdb1d6b2a9 100644
--- a/arch/arm/dts/k3-j7200-main.dtsi
+++ b/arch/arm/dts/k3-j7200-main.dtsi
@@ -32,13 +32,20 @@
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
-		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
 					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j7200-cpsw5g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <1>;
+			reg = <0x4044 0x10>;
+			#phy-cells = <1>;
+		};
+
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -54,7 +61,10 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
-		      <0x00 0x01900000 0x00 0x100000>;	/* GICR */
+		      <0x00 0x01900000 0x00 0x100000>,	/* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,	/* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,	/* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;	/* GICV */
 
 		/* vcpumntirq: virtual CPU interface maintenance interrupt */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -139,6 +149,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -148,6 +159,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -157,6 +169,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -166,6 +179,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -175,6 +189,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -184,6 +199,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -193,6 +209,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -202,6 +219,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -211,6 +229,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -220,6 +239,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -229,6 +249,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -238,15 +259,17 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x00 0x3c000000 0x00 0x400000>,
-				<0x00 0x38000000 0x00 0x400000>,
-				<0x00 0x31120000 0x00 0x100>,
-				<0x00 0x33000000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			reg = <0x00 0x3c000000 0x00 0x400000>,
+			      <0x00 0x38000000 0x00 0x400000>,
+			      <0x00 0x31120000 0x00 0x100>,
+			      <0x00 0x33000000 0x00 0x40000>,
+			      <0x00 0x31080000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <1024>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -256,9 +279,9 @@
 
 		main_udmap: dma-controller@31150000 {
 			compatible = "ti,j721e-navss-main-udmap";
-			reg =	<0x00 0x31150000 0x00 0x100>,
-				<0x00 0x34000000 0x00 0x100000>,
-				<0x00 0x35000000 0x00 0x100000>;
+			reg = <0x00 0x31150000 0x00 0x100>,
+			      <0x00 0x34000000 0x00 0x100000>,
+			      <0x00 0x35000000 0x00 0x100000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
@@ -289,10 +312,118 @@
 		};
 	};
 
+	cpsw0: ethernet@c000000 {
+		compatible = "ti,j7200-cpswxg-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		clocks = <&k3_clks 19 33>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 19 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cpsw0_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				status = "disabled";
+			};
+
+			cpsw0_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+				status = "disabled";
+			};
+
+			cpsw0_port3: port@3 {
+				reg = <3>;
+				ti,mac-only;
+				label = "port3";
+				status = "disabled";
+			};
+
+			cpsw0_port4: port@4 {
+				reg = <4>;
+				ti,mac-only;
+				label = "port4";
+				status = "disabled";
+			};
+		};
+
+		cpsw5g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 19 33>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 19 16>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104200 0x0 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x000001ff>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x104280 0x0 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x11c000 0x00 0x2b4>;
+		reg = <0x00 0x11c000 0x00 0x10c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx1: pinctrl@11c11c {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c11c 0x00 0xc>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
@@ -307,6 +438,7 @@
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -318,6 +450,7 @@
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -329,6 +462,7 @@
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -340,6 +474,7 @@
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -351,6 +486,7 @@
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -362,6 +498,7 @@
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -373,6 +510,7 @@
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -384,6 +522,7 @@
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -395,6 +534,7 @@
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -406,6 +546,7 @@
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_i2c0: i2c@2000000 {
@@ -417,6 +558,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 187 1>;
 		power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@2010000 {
@@ -428,6 +570,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 188 1>;
 		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -439,6 +582,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 189 1>;
 		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -450,6 +594,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 190 1>;
 		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c4: i2c@2040000 {
@@ -461,6 +606,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 191 1>;
 		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c5: i2c@2050000 {
@@ -472,6 +618,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 192 1>;
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c6: i2c@2060000 {
@@ -483,6 +630,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 193 1>;
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_sdhci0: mmc@4f80000 {
@@ -507,6 +655,7 @@
 		mmc-hs200-1_8v;
 		mmc-hs400-1_8v;
 		dma-coherent;
+		status = "disabled";
 	};
 
 	main_sdhci1: mmc@4fb0000 {
@@ -530,6 +679,7 @@
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
+		status = "disabled";
 	};
 
 	serdes_wiz0: wiz@5060000 {
@@ -606,10 +756,10 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		cdns,no-bar-match-nbits = <64>;
-		vendor-id = /bits/ 16 <0x104c>;
-		device-id = /bits/ 16 <0xb00f>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00f>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
 		dma-coherent;
 		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
@@ -633,6 +783,7 @@
 		clocks = <&k3_clks 240 6>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
 		dma-coherent;
 	};
 
@@ -682,6 +833,7 @@
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 105 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio2: gpio@610000 {
@@ -699,6 +851,7 @@
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 107 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio4: gpio@620000 {
@@ -716,6 +869,7 @@
 		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 109 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	main_gpio6: gpio@630000 {
@@ -733,6 +887,353 @@
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 111 0>;
 		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 266 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 267 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 268 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 269 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 270 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 271 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 272 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 273 1>;
+		status = "disabled";
+	};
+
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2200000 0x0 0x100>;
+		clocks = <&k3_clks 252 1>;
+		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 252 1>;
+		assigned-clock-parents = <&k3_clks 252 5>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2210000 0x0 0x100>;
+		clocks = <&k3_clks 253 1>;
+		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 253 1>;
+		assigned-clock-parents = <&k3_clks 253 5>;
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 49 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 49 1>;
+		assigned-clock-parents = <&k3_clks 49 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 50 1>, <&k3_clks 313 0>;
+		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 313 1>;
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 51 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 51 1>;
+		assigned-clock-parents = <&k3_clks 51 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 52 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 52 1>, <&k3_clks 314 0>;
+		assigned-clock-parents = <&k3_clks 52 2>, <&k3_clks 314 1>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 53 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 53 1>;
+		assigned-clock-parents = <&k3_clks 53 2>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 54 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 54 1>, <&k3_clks 315 0>;
+		assigned-clock-parents = <&k3_clks 54 2>, <&k3_clks 315 1>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 55 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 55 1>;
+		assigned-clock-parents = <&k3_clks 55 2>;
+		power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 57 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 57 1>, <&k3_clks 316 0>;
+		assigned-clock-parents = <&k3_clks 57 2>, <&k3_clks 316 1>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 58 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 58 1>;
+		assigned-clock-parents = <&k3_clks 58 2>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 59 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 59 1>, <&k3_clks 317 0>;
+		assigned-clock-parents = <&k3_clks 59 2>, <&k3_clks 317 1>;
+		power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 60 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 60 1>;
+		assigned-clock-parents = <&k3_clks 60 2>;
+		power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 62 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 62 1>, <&k3_clks 318 0>;
+		assigned-clock-parents = <&k3_clks 62 2>, <&k3_clks 318 1>;
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 63 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 63 1>;
+		assigned-clock-parents = <&k3_clks 63 2>;
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 64 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 64 1>, <&k3_clks 319 0>;
+		assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 319 1>;
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 65 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 65 1>;
+		assigned-clock-parents = <&k3_clks 65 2>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 66 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 66 1>, <&k3_clks 320 0>;
+		assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 320 1>;
+		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 67 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 67 1>;
+		assigned-clock-parents = <&k3_clks 67 2>;
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 68 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 68 1>, <&k3_clks 321 0>;
+		assigned-clock-parents = <&k3_clks 68 2>, <&k3_clks 321 1>;
+		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 69 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 69 1>;
+		assigned-clock-parents = <&k3_clks 69 2>;
+		power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 70 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 70 1>, <&k3_clks 322 0>;
+		assigned-clock-parents = <&k3_clks 70 2>, <&k3_clks 322 1>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
 	};
 
 	main_r5fss0: r5fss@5c00000 {
@@ -774,4 +1275,10 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x700000 0x0 0x1000>;
+		ti,esm-pins = <656>, <657>;
+	};
 };
diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b..6ffaf85fa6 100644
--- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x00 0x1000>;
@@ -34,6 +34,136 @@
 		};
 	};
 
+	mcu_timer0: timer@40400000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 1>;
+		assigned-clock-parents = <&k3_clks 35 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer1: timer@40410000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 71 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 71 1>, <&k3_clks 308 0>;
+		assigned-clock-parents = <&k3_clks 71 2>, <&k3_clks 308 1>;
+		power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer2: timer@40420000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 72 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 72 1>;
+		assigned-clock-parents = <&k3_clks 72 2>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer3: timer@40430000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 73 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 73 1>, <&k3_clks 309 0>;
+		assigned-clock-parents = <&k3_clks 73 2>, <&k3_clks 309 1>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer4: timer@40440000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 74 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 74 1>;
+		assigned-clock-parents = <&k3_clks 74 2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer5: timer@40450000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 75 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 75 1>, <&k3_clks 310 0>;
+		assigned-clock-parents = <&k3_clks 75 2>, <&k3_clks 310 1>;
+		power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer6: timer@40460000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 76 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 76 1>;
+		assigned-clock-parents = <&k3_clks 76 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer7: timer@40470000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 77 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 77 1>, <&k3_clks 311 0>;
+		assigned-clock-parents = <&k3_clks 77 2>, <&k3_clks 311 1>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer8: timer@40480000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 78 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 78 1>;
+		assigned-clock-parents = <&k3_clks 78 2>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer9: timer@40490000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 79 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 79 1>, <&k3_clks 312 0>;
+		assigned-clock-parents = <&k3_clks 79 2>, <&k3_clks 312 1>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	mcu_conf: syscon@40f00000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x40f00000 0x00 0x20000>;
@@ -53,10 +183,57 @@
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
 
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04200 0x0 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000F>;
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x40f04280 0x0 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000F>;
+		status = "reserved";
+	};
+
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x34>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x8>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0xec>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c174 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c174 0x00 0x20>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
@@ -79,6 +256,7 @@
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -90,6 +268,7 @@
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	wkup_gpio_intr: interrupt-controller@42200000 {
@@ -118,6 +297,7 @@
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 113 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	wkup_gpio1: gpio@42100000 {
@@ -134,6 +314,7 @@
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
 		clock-names = "gpio";
+		status = "disabled";
 	};
 
 	mcu_navss: bus@28380000 {
@@ -147,11 +328,13 @@
 
 		mcu_ringacc: ringacc@2b800000 {
 			compatible = "ti,am654-navss-ringacc";
-			reg =	<0x00 0x2b800000 0x00 0x400000>,
-				<0x00 0x2b000000 0x00 0x400000>,
-				<0x00 0x28590000 0x00 0x100>,
-				<0x00 0x2a500000 0x00 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			reg = <0x00 0x2b800000 0x00 0x400000>,
+			      <0x00 0x2b000000 0x00 0x400000>,
+			      <0x00 0x28590000 0x00 0x100>,
+			      <0x00 0x2a500000 0x00 0x40000>,
+			      <0x00 0x28440000 0x00 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg",
+				    "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
@@ -161,9 +344,9 @@
 
 		mcu_udmap: dma-controller@285c0000 {
 			compatible = "ti,j721e-navss-mcu-udmap";
-			reg =	<0x00 0x285c0000 0x00 0x100>,
-				<0x00 0x2a800000 0x00 0x40000>,
-				<0x00 0x2aa00000 0x00 0x40000>;
+			reg = <0x00 0x285c0000 0x00 0x100>,
+			      <0x00 0x2a800000 0x00 0x40000>,
+			      <0x00 0x2aa00000 0x00 0x40000>;
 			reg-names = "gcfg", "rchanrt", "tchanrt";
 			msi-parent = <&main_udmass_inta>;
 			#dma-cells = <1>;
@@ -180,6 +363,21 @@
 		};
 	};
 
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x2a480000 0x0 0x80000>,
+		      <0x0 0x2a380000 0x0 0x80000>,
+		      <0x0 0x2a400000 0x0 0x80000>;
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
@@ -249,6 +447,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 194 1>;
 		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@40b10000 {
@@ -260,6 +459,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 195 1>;
 		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
@@ -271,6 +471,40 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 197 1>;
 		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
+		status = "disabled";
+	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 274 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 275 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 0>;
+		status = "disabled";
 	};
 
 	fss: syscon@47000000 {
@@ -314,6 +548,7 @@
 			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 	};
 
@@ -325,7 +560,7 @@
 		clocks = <&k3_clks 0 1>;
 		assigned-clocks = <&k3_clks 0 3>;
 		assigned-clock-rates = <60000000>;
-		clock-names = "adc_tsc_fck";
+		clock-names = "fck";
 		dmas = <&main_udmap 0x7400>,
 			<&main_udmap 0x7401>;
 		dma-names = "fifo0", "fifo1";
@@ -375,4 +610,31 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	mcu_crypto: crypto@40900000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+		dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
+		       <&mcu_udmap 0x7503>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@40910000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x40910000 0x00 0x7d>;
+			interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled"; /* Used by OP-TEE */
+		};
+	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index e62f9218e8..f0a7360502 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
 
-#include "k3-j7200-som-p0.dtsi"
+#include "k3-j7200-common-proc-board.dts"
 #include "k3-j7200-ddr-evm-lp4-2666.dtsi"
 #include "k3-j721e-ddr.dtsi"
+#include "k3-j7200-common-proc-board-u-boot.dtsi"
 
 / {
 	aliases {
@@ -15,17 +16,6 @@
 		remoteproc1 = &a72_0;
 	};
 
-	chosen {
-		stdout-path = &main_uart0;
-		tick-timer = &timer1;
-		firmware-loader = &fs_loader0;
-	};
-
-	fs_loader0: fs_loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-	};
-
 	a72_0: a72@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
@@ -42,17 +32,13 @@
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
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <3>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes = <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
 		bootph-pre-ram;
 	};
 };
@@ -61,275 +47,38 @@
 	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
 			<&k3_pds 90 TI_SCI_PD_SHARED>;
 	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
+	bootph-pre-ram;
 };
 
-&cbass_mcu_wakeup {
-	mcu_secproxy: secproxy@2a380000 {
-		bootph-pre-ram;
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-	};
+&mcu_timer0 {
+	clock-frequency = <25000000>;
+	bootph-pre-ram;
+};
 
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&cbass_mcu_wakeup {
 	sysctrler: sysctrler {
-		bootph-pre-ram;
 		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
+		mboxes= <&secure_proxy_mcu 4>,
+			<&secure_proxy_mcu 5>;
 		mbox-names = "tx", "rx";
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <3>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&mcu_secproxy 21>,
-			<&mcu_secproxy 23>;
 		bootph-pre-ram;
 	};
-
-	wkup_vtm0: vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
 };
 
 &dmsc {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
+	mboxes = <&secure_proxy_mcu 8>,
+		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
-};
-
-&wkup_pmx0 {
-	bootph-pre-ram;
-	wkup_uart0_pins_default: wkup_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
-			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
-		>;
-	};
-
-	mcu_uart0_pins_default: mcu_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) WKUP_GPIO0_13.MCU_UART0_RXD */
-			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) WKUP_GPIO0_12.MCU_UART0_TXD */
-			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) WKUP_GPIO0_14.MCU_UART0_CTSn */
-			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) WKUP_GPIO0_15.MCU_UART0_RTSn */
-		>;
-	};
-
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x100, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
-			J721E_WKUP_IOPAD(0x104, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
-		>;
-	};
-
-	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (E20) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
-			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C21) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
-			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (F19) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
-			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* (E22) MCU_OSPI1_CSn1.MCU_HYPERBUS0_CSn1 */
-			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (E19) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
-			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (D21) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
-			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D20) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
-			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (G19) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
-			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (G20) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
-			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (F20) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
-			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (F21) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
-			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (E21) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
-			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (B22) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
-			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (G21) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
-		>;
-	};
-
-	wkup_gpio_pins_default: wkup-gpio-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xd8, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
-		>;
-	};
-};
-
-&main_pmx0 {
-	bootph-pre-ram;
-
-	main_uart0_pins_default: main_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
-			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
-			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
-			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
-			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
-		>;
-	};
-
-	main_mmc1_pins_default: main_mmc1_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
-			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
-			J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
-			J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
-			J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
-			J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
-			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
-			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
-		>;
-	};
-
-	main_usbss0_pins_default: main_usbss0_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
-		>;
-	};
-};
-
-&wkup_uart0 {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
-	status = "okay";
-};
-
-&mcu_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
-	status = "okay";
-	clock-frequency = <96000000>;
-};
-
-&main_uart0 {
-	status = "okay";
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_sdhci0 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	pinctrl-names = "default";
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
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
-};
-
-&wkup_i2c0 {
-	bootph-pre-ram;
-	lp876441: lp876441@4c {
-		compatible = "ti,lp876441";
-		reg = <0x4c>;
-		bootph-pre-ram;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wkup_i2c0_pins_default>;
-		clock-frequency = <400000>;
-
-		regulators: regulators {
-			bootph-pre-ram;
-			buck1_reg: buck1 {
-				/*VDD_CPU_AVS_REG*/
-				regulator-name = "buck1";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-always-on;
-				regulator-boot-on;
-				bootph-pre-ram;
-			};
-		};
-	};
-
 };
 
 &wkup_vtm0 {
-	vdd-supply-2 = <&buck1_reg>;
 	bootph-pre-ram;
 };
-
-&main_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	exp1: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	exp2: gpio@22 {
-		compatible = "ti,tca6424";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&usbss0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss0_pins_default>;
-	ti,vbus-divider;
-	ti,usb2-only;
-};
-
-&usb0 {
-	dr_mode = "otg";
-	maximum-speed = "high-speed";
-};
-
-&hbmc {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
-	reg = <0x0 0x47040000 0x0 0x100>,
-	      <0x0 0x50000000 0x0 0x8000000>;
-	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>, /* 64MB Flash on CS0 */
-		 <0x1 0x0 0x0 0x54000000 0x800000>; /* 8MB flash on CS1 */
-
-	flash@0,0 {
-		compatible = "cypress,hyperflash", "cfi-flash";
-		reg = <0x0 0x0 0x4000000>;
-	};
-};
-
-&mcu_ringacc {
-	ti,sci = <&dm_tifs>;
-};
-
-&mcu_udmap {
-	ti,sci = <&dm_tifs>;
-};
-#include "k3-j7200-common-proc-board-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-j7200-som-p0.dtsi b/arch/arm/dts/k3-j7200-som-p0.dtsi
index 3472444017..5a300d4c8b 100644
--- a/arch/arm/dts/k3-j7200-som-p0.dtsi
+++ b/arch/arm/dts/k3-j7200-som-p0.dtsi
@@ -83,7 +83,7 @@
 };
 
 &wkup_pmx0 {
-	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
+	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (B6) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
 			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C8) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
@@ -101,7 +101,7 @@
 		>;
 	};
 
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
 			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
@@ -118,8 +118,17 @@
 	};
 };
 
+&wkup_pmx2 {
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+			pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
+			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
 &main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
 			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
@@ -140,10 +149,42 @@
 	flash@0,0 {
 		compatible = "cypress,hyperflash", "cfi-flash";
 		reg = <0x00 0x00 0x4000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "hbmc.tiboot3";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "hbmc.tispl";
+				reg = <0x100000 0x200000>;
+			};
+
+			partition@300000 {
+				label = "hbmc.u-boot";
+				reg = <0x300000 0x400000>;
+			};
+
+			partition@700000 {
+				label = "hbmc.env";
+				reg = <0x700000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "hbmc.rootfs";
+				reg = <0x800000 0x3800000>;
+			};
+		};
 	};
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -158,6 +199,7 @@
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
@@ -171,66 +213,26 @@
 	};
 };
 
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
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
@@ -252,11 +254,24 @@
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -267,7 +282,46 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "ospi.tispl";
+				reg = <0x100000 0x200000>;
+			};
+
+			partition@300000 {
+				label = "ospi.u-boot";
+				reg = <0x300000 0x400000>;
+			};
+
+			partition@700000 {
+				label = "ospi.env";
+				reg = <0x700000 0x40000>;
+			};
+
+			partition@740000 {
+				label = "ospi.env.backup";
+				reg = <0x740000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/dts/k3-j7200-thermal.dtsi b/arch/arm/dts/k3-j7200-thermal.dtsi
new file mode 100644
index 0000000000..e7e3a643a6
--- /dev/null
+++ b/arch/arm/dts/k3-j7200-thermal.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	mcu_thermal: mcu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main_thermal: main-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j7200.dtsi b/arch/arm/dts/k3-j7200.dtsi
index b7005b8031..ef73e6d7e8 100644
--- a/arch/arm/dts/k3-j7200.dtsi
+++ b/arch/arm/dts/k3-j7200.dtsi
@@ -7,9 +7,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/k3.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
+#include "k3-pinctrl.h"
+
 / {
 	model = "Texas Instruments K3 J7200 SoC";
 	compatible = "ti,j7200";
@@ -17,21 +18,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		serial9 = &main_uart7;
-		serial10 = &main_uart8;
-		serial11 = &main_uart9;
-	};
-
 	chosen { };
 
 	cpus {
@@ -60,7 +46,7 @@
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -74,7 +60,7 @@
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 	};
@@ -82,15 +68,17 @@
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
-		cache-sets = <2048>;
+		cache-sets = <1024>;
 		next-level-cache = <&msmc_l3>;
 	};
 
 	msmc_l3: l3-cache0 {
 		compatible = "cache";
 		cache-level = <3>;
+		cache-unified;
 	};
 
 	firmware {
@@ -124,9 +112,11 @@
 		#size-cells = <2>;
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00800000>, /* MSMC RAM */
 			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
 			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
@@ -165,6 +155,8 @@
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
+
+	#include "k3-j7200-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
diff --git a/arch/arm/dts/k3-serdes.h b/arch/arm/dts/k3-serdes.h
new file mode 100644
index 0000000000..29167f85c1
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
2.34.1

