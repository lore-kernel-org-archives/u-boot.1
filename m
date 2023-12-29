Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C8C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D39087BE0;
	Fri, 29 Dec 2023 18:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yu0ATUJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B9987BD2; Fri, 29 Dec 2023 18:47:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AD487B92
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1K9032423;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=8qIu8e+Ujfc5AT8bO8W409RKZWZF39vz0nFw6PVgh5A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Yu0ATUJ348/j9htEtiOP+V4g0jNnqpPPnRARrkLuBwHoiXxhnUSBFi17ay4akjNeA
 w/2M6sVRP6U5RLfIJrpEuzj4UWGNOmbcXoR5QeuVwtFuDuUJxJ5aTXEw/E4NLEYCRM
 oYtg1oUc4eoixNoZ8+ov9pb7MN/07zvcgo/GUu88=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1sT024999
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0r0005047;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 03/26] arm: dts: k3-am654-r5: Merge board file and U-Boot
 overlay
Date: Fri, 29 Dec 2023 11:47:00 -0600
Message-ID: <20231229174656.634065-31-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10232; i=bb@ti.com;
 h=from:subject; bh=+2kLEiIRARAnCeOAudFlyejnhxhlbiNHqyjgfwWjFHI=;
 b=owNCWmg5MUFZJlNZyVHQmgAAa////v9r7qdvvHr929af8zvi3/d3/Pa/P8/za+nJ/9/pp02wA
 RpoIepoaDIADQDQ0AAGg9QPSPSaaMgAA0AAZNANAeoGjI0aNADJ6mm0jIbQTR5Q5NDIaaNNBhAM
 gAZDTTJpoaDTQaABoNMJoZDAmAE0aZADQZAaGhpkGgyGgcmmgyNAyMTJpoaAZGJowTIxNBoAAGj
 TCZNNGIyGBBk0NDQAAA00NNAYgAYPXCogouojcWrjJNvIhyL12hJ+i0AmoI8iXDqM/HdBsGVmRY
 B1A++wDNZnBEMsyXrmzMAI8CcTrAg7CJQxCsir3RTrMGQmBdbs22qbzYpdflsSw86052ubIojkv
 sN1KW7KDQxzcVH2R2pR3uiKb8ROBWoGMpF9QXINh46ikLg9NY5uRBFTJmXNhurOBLfoQa03raNb
 fOl/F1fMfeTwM1FEX2O/4zjVmbZmDlcGaPcsJrvBC/VSFv6SgOpYhvtu/POgSpqcM9pm6QaH6Ot
 wygS64FGVhwLFeV1gV3gwJAb2XMQ9H/bLmMpEtMJzQp9lRjIHRqN86pE45YfKNxvp0z8FbY8Hr1
 vX8PvwN7/bYe/bgNDScD90qXcKz7hhajO+AAifBybq5ROeJAEkNyj3niTo6RNEqVbkjZJJJAMEk
 zdNBWxIIf+LuSKcKEhkqOhNAA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The R5 board file for U-Boot should be the same as the board file copied
from Linux with a few alterations to work with the R5's view of the SoC.

First we need to unify the R5 board file and it's U-Boot overlay before
we can unify the Linux board file with this one.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |   1 -
 .../dts/k3-am654-r5-base-board-u-boot.dtsi    | 208 ------------------
 arch/arm/dts/k3-am654-r5-base-board.dts       | 124 ++++++++++-
 3 files changed, 119 insertions(+), 214 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 11d83927ac525..f29cecf870bcd 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -3,7 +3,6 @@
  * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-am654-r5-base-board-u-boot.dtsi"
 #include "k3-am65x-binman.dtsi"
 
 &pru0_0 {
diff --git a/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
deleted file mode 100644
index 286604576e028..0000000000000
--- a/arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
+++ /dev/null
@@ -1,208 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include <dt-bindings/pinctrl/k3.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am65x-binman.dtsi"
-
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	aliases {
-		serial2 = &main_uart0;
-		ethernet0 = &cpsw_port1;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		spi0 = &ospi0;
-		spi1 = &ospi1;
-	};
-};
-
-&cbass_main{
-	bootph-pre-ram;
-	main_navss: bus@30800000 {
-		bootph-pre-ram;
-	};
-};
-
-&cbass_mcu {
-	bootph-pre-ram;
-
-	mcu_navss: bus@28380000 {
-		bootph-pre-ram;
-
-		ringacc@2b800000 {
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>,
-				<0x0 0x28440000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			bootph-pre-ram;
-			ti,dma-ring-reset-quirk;
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
-};
-
-&cbass_wakeup {
-	bootph-pre-ram;
-
-	chipid@43000014 {
-		bootph-pre-ram;
-	};
-};
-
-&secure_proxy_main {
-	bootph-pre-ram;
-};
-
-&dmsc {
-	bootph-pre-ram;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
-};
-
-&k3_pds {
-	bootph-pre-ram;
-};
-
-&k3_clks {
-	bootph-pre-ram;
-};
-
-&k3_reset {
-	bootph-pre-ram;
-};
-
-&wkup_pmx0 {
-	bootph-pre-ram;
-
-	wkup_i2c0_pins_default {
-		bootph-pre-ram;
-	};
-};
-
-&main_pmx0 {
-	bootph-pre-ram;
-	usb0_pins_default: usb0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
-		>;
-		bootph-pre-ram;
-	};
-};
-
-&main_uart0_pins_default {
-	bootph-pre-ram;
-};
-
-&main_pmx1 {
-	bootph-pre-ram;
-};
-
-&wkup_pmx0 {
-	mcu-fss0-ospi0-pins-default {
-		bootph-pre-ram;
-	};
-};
-
-&main_uart0 {
-	bootph-pre-ram;
-};
-
-&main_mmc0_pins_default {
-	bootph-pre-ram;
-};
-
-&main_mmc1_pins_default {
-	bootph-pre-ram;
-};
-
-&sdhci0 {
-	bootph-pre-ram;
-};
-
-&sdhci1 {
-	bootph-pre-ram;
-};
-
-&davinci_mdio {
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-		/* TODO: phy reset: TCA9555RTWR(i2c:0x21)[p04].GPIO_MCU_RGMII_RSTN */
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-&mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x2>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
-
-	cpsw-phy-sel@40f04040 {
-		compatible = "ti,am654-cpsw-phy-sel";
-		reg= <0x0 0x40f04040 0x0 0x4>;
-		reg-names = "gmii-sel";
-	};
-};
-
-&wkup_i2c0 {
-	bootph-pre-ram;
-};
-
-&usb1 {
-	dr_mode = "peripheral";
-};
-
-&fss {
-	bootph-pre-ram;
-};
-
-&ospi0 {
-	bootph-pre-ram;
-
-	 flash@0{
-		bootph-pre-ram;
-	};
-};
-
-&dwc3_0 {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&usb0_phy {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_pins_default>;
-	dr_mode = "peripheral";
-	bootph-pre-ram;
-};
-
-&scm_conf {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 637a5cc85e095..d75c7bf3fe662 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -14,9 +14,16 @@
 	model = "Texas Instruments AM654 R5 Base Board";
 
 	aliases {
+		ethernet0 = &cpsw_port1;
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
 		serial0 = &wkup_uart0;
 		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
+		spi0 = &ospi0;
+		spi1 = &ospi1;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -24,11 +31,6 @@
 		tick-timer = &timer1;
 	};
 
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
 	a53_0: a53@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
@@ -56,6 +58,8 @@
 };
 
 &cbass_main {
+	bootph-pre-ram;
+
 	timer1: timer@40400000 {
 		compatible = "ti,omap5430-timer";
 		reg = <0x0 0x40400000 0x0 0x80>;
@@ -63,9 +67,15 @@
 		clock-frequency = <25000000>;
 		bootph-all;
 	};
+
+	main_navss: bus@30800000 {
+		bootph-pre-ram;
+	};
 };
 
 &cbass_mcu {
+	bootph-pre-ram;
+
 	mcu_secproxy: secproxy@28380000 {
 		compatible = "ti,am654-secure-proxy";
 		reg = <0x0 0x2a380000 0x0 0x80000>,
@@ -75,13 +85,58 @@
 		#mbox-cells = <1>;
 		bootph-pre-ram;
 	};
+
+	mcu_navss: bus@28380000 {
+		bootph-pre-ram;
+
+		ringacc@2b800000 {
+			reg =	<0x0 0x2b800000 0x0 0x400000>,
+				<0x0 0x2b000000 0x0 0x400000>,
+				<0x0 0x28590000 0x0 0x100>,
+				<0x0 0x2a500000 0x0 0x40000>,
+				<0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+			bootph-pre-ram;
+			ti,dma-ring-reset-quirk;
+		};
+
+		dma-controller@285c0000 {
+			reg =	<0x0 0x285c0000 0x0 0x100>,
+				<0x0 0x284c0000 0x0 0x4000>,
+				<0x0 0x2a800000 0x0 0x40000>,
+				<0x0 0x284a0000 0x0 0x4000>,
+				<0x0 0x2aa00000 0x0 0x40000>,
+				<0x0 0x28400000 0x0 0x2000>;
+			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+					    "tchanrt", "rflow";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&k3_pds {
+	bootph-pre-ram;
+};
+
+&k3_clks {
+	bootph-pre-ram;
+};
+
+&k3_reset {
+	bootph-pre-ram;
 };
 
 &wkup_gpio0 {
 	bootph-pre-ram;
 };
 
+&secure_proxy_main {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
+	bootph-pre-ram;
+
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
 		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
@@ -95,13 +150,24 @@
 		clock-frequency = <200000000>;
 		bootph-pre-ram;
 	};
+
+	chipid@43000014 {
+		bootph-pre-ram;
+	};
 };
 
 &dmsc {
+	bootph-pre-ram;
+
 	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
+
+	k3_sysreset: sysreset-controller {
+		compatible = "ti,sci-sysreset";
+		bootph-pre-ram;
+	};
 };
 
 &wkup_uart0 {
@@ -125,6 +191,7 @@
 	pinctrl-0 = <&main_uart0_pins_default>;
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 	status = "okay";
+	bootph-pre-ram;
 };
 
 &wkup_vtm0 {
@@ -168,6 +235,7 @@
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
+		bootph-pre-ram;
 	};
 
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
@@ -184,6 +252,7 @@
 			AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
 			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
 		>;
+		bootph-pre-ram;
 	};
 };
 
@@ -229,6 +298,17 @@
 		>;
 		bootph-pre-ram;
 	};
+
+	usb0_pins_default: usb0_pins_default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
+		>;
+		bootph-pre-ram;
+	};
+};
+
+&main_pmx1 {
+	bootph-pre-ram;
 };
 
 &memorycontroller {
@@ -243,6 +323,7 @@
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	/delete-property/ power-domains;
 	ti,driver-strength-ohm = <50>;
+	bootph-pre-ram;
 };
 
 &sdhci1 {
@@ -251,6 +332,7 @@
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	/delete-property/ power-domains;
 	ti,driver-strength-ohm = <50>;
+	bootph-pre-ram;
 };
 
 &wkup_i2c0 {
@@ -276,6 +358,7 @@
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+	bootph-pre-ram;
 
 	reg = <0x0 0x47040000 0x0 0x100>,
 	      <0x0 0x50000000 0x0 0x8000000>;
@@ -293,6 +376,7 @@
 		cdns,read-delay = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+		bootph-pre-ram;
 	};
 };
 
@@ -331,3 +415,33 @@
 &scm_conf {
 	bootph-pre-ram;
 };
+
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		/* TODO: phy reset: TCA9555RTWR(i2c:0x21)[p04].GPIO_MCU_RGMII_RSTN */
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&mcu_cpsw {
+	reg = <0x0 0x46000000 0x0 0x200000>,
+	      <0x0 0x40f00200 0x0 0x2>;
+	reg-names = "cpsw_nuss", "mac_efuse";
+	/delete-property/ ranges;
+
+	cpsw-phy-sel@40f04040 {
+		compatible = "ti,am654-cpsw-phy-sel";
+		reg= <0x0 0x40f04040 0x0 0x4>;
+		reg-names = "gmii-sel";
+	};
+};
+
+&usb1 {
+	dr_mode = "peripheral";
+};
+
+&fss {
+	bootph-pre-ram;
+};
-- 
2.43.0

