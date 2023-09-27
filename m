Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B141E7F14E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D948486E09;
	Wed, 27 Sep 2023 15:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ausfxK6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD1686DF4; Wed, 27 Sep 2023 15:10:32 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED4486E13
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RDAR6a127864;
 Wed, 27 Sep 2023 08:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695820227;
 bh=5W/uFspdVQThWNz/Tpa3JAkYjB9QIbbPVuTqR2HBh9Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ausfxK6pD8anKYHzREaeppl7K3ZDkvUGRrTQBDQ/5YAYLMCC69QYdlaYRL1ZWpqQY
 BUgiggzEugqDf+g7l71417HyuInE4aD5pHxkzCEp0u2T3ckr+xIdaDnSvv1aBOINba
 4dxY7zyHrjcivbzDc6EWS+zz2Wwj15GzzVsOZAFk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RDARQE077400
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 08:10:27 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 08:10:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 08:10:26 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RD9uKf025731;
 Wed, 27 Sep 2023 08:10:22 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 5/6] arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
Date: Wed, 27 Sep 2023 18:39:55 +0530
Message-ID: <20230927130956.910988-6-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927130956.910988-1-n-francis@ti.com>
References: <20230927130956.910988-1-n-francis@ti.com>
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

Get rid of k3-j721e-r5-*-u-boot.dtsi as it is not
necessary. Change the inclusion hierarchy to be as follows:

	k3-j721e-<board>.dts---
			       -
			        -->k3-j721e-r5-<board>.dts
			       -
k3-j721e-<board>-u-boot.dtsi---

Reason for explicitly mentioning the inclusion of -u-boot.dtsi in code
although it could've been automatically done by U-Boot is to resolve
some of the dependencies that R5 file requires.

Also remove duplicate phandles while making this shift as well as remove
firmware-loader as it serves no purpose without "phandlepart" property.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../k3-j721e-r5-common-proc-board-u-boot.dtsi | 29 ------------
 .../arm/dts/k3-j721e-r5-common-proc-board.dts | 38 +++------------
 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       | 31 ------------
 arch/arm/dts/k3-j721e-r5-sk.dts               | 47 ++++---------------
 4 files changed, 16 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi

diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
deleted file mode 100644
index f9746d33ec..0000000000
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
- */
-
-#include "k3-j721e-common-proc-board-u-boot.dtsi"
-
-/ {
-	chosen {
-		firmware-loader = &fs_loader0;
-	};
-
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a72_0;
-	};
-
-	fs_loader0: fs_loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-	};
-};
-
-&tps659413a {
-	esm: esm {
-		compatible = "ti,tps659413-esm";
-		bootph-pre-ram;
-	};
-};
diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index 32f71e9b6a..7bb5ce775c 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -5,10 +5,10 @@
 
 /dts-v1/;
 
-#include "k3-j721e-som-p0.dtsi"
+#include "k3-j721e-common-proc-board.dts"
 #include "k3-j721e-ddr-evm-lp4-4266.dtsi"
 #include "k3-j721e-ddr.dtsi"
-#include "k3-j721e-binman.dtsi"
+#include "k3-j721e-common-proc-board-u-boot.dtsi"
 #include <dt-bindings/phy/phy-cadence.h>
 
 / {
@@ -198,27 +198,6 @@
 		>;
 	};
 
-	main_usbss0_pins_default: main_usbss0_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
-			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
-		>;
-	};
-
-	main_mmc1_pins_default: main_mmc1_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
-			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
-			J721E_IOPAD(0x2ac, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
-			J721E_IOPAD(0x24c, PIN_INPUT, 0) /* (R24) MMC1_DAT0 */
-			J721E_IOPAD(0x248, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
-			J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
-			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
-			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
-			J721E_IOPAD(0x25c, PIN_INPUT, 0) /* (R28) MMC1_SDWP */
-		>;
-	};
-
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
@@ -300,6 +279,11 @@
 				bootph-pre-ram;
 			};
 		};
+
+		esm: esm {
+			compatible = "ti,tps659413-esm";
+			bootph-pre-ram;
+		};
 	};
 };
 
@@ -424,14 +408,6 @@
 	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
 	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
 
-	serdes0_pcie_link: link@0 {
-		reg = <0>;
-		cdns,num-lanes = <1>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_PCIE>;
-		resets = <&serdes_wiz0 1>;
-	};
-
 	serdes0_qsgmii_link: phy@1 {
 		reg = <1>;
 		cdns,num-lanes = <1>;
diff --git a/arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
deleted file mode 100644
index 733d69cd00..0000000000
--- a/arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include "k3-j721e-sk-u-boot.dtsi"
-
-/ {
-	chosen {
-		firmware-loader = &fs_loader0;
-	};
-
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a72_0;
-		remoteproc2 = &main_r5fss0_core0;
-		remoteproc3 = &main_r5fss0_core1;
-	};
-
-	fs_loader0: fs_loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-	};
-};
-
-&tps659412 {
-	esm: esm {
-		compatible = "ti,tps659413-esm";
-		bootph-pre-ram;
-	};
-};
diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
index 6986292e37..1cc64d07f7 100644
--- a/arch/arm/dts/k3-j721e-r5-sk.dts
+++ b/arch/arm/dts/k3-j721e-r5-sk.dts
@@ -5,9 +5,10 @@
 
 /dts-v1/;
 
-#include "k3-j721e.dtsi"
+#include "k3-j721e-sk.dts"
 #include "k3-j721e-ddr-sk-lp4-4266.dtsi"
 #include "k3-j721e-ddr.dtsi"
+#include "k3-j721e-sk-u-boot.dtsi"
 
 / {
 	model = "Texas Instruments J721E SK R5";
@@ -15,6 +16,8 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &main_r5fss0_core0;
+		remoteproc3 = &main_r5fss0_core1;
 	};
 
 	chosen {
@@ -279,52 +282,15 @@
 			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 0) /* (D21) MCU_OSPI0_DQS */
 		>;
 	};
-
-	mcu_i2c0_pins_default: mcu_i2c0_pins_default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (J26) MCU_I2C0_SCL */
-			J721E_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (H25) MCU_I2C0_SDA */
-		>;
-	};
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x1f0, PIN_INPUT, 0) /* (AC2) UART0_CTSn */
-			J721E_IOPAD(0x1f4, PIN_OUTPUT, 0) /* (AB1) UART0_RTSn */
-			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
-			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
-		>;
-	};
-
-	main_usbss0_pins_default: main_usbss0_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
-			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
-		>;
-	};
-
 	main_usbss1_pins_default: main-usbss1-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
 	};
 
-	main_mmc1_pins_default: main_mmc1_pins_default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
-			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
-			J721E_IOPAD(0x2ac, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
-			J721E_IOPAD(0x24c, PIN_INPUT, 0) /* (R24) MMC1_DAT0 */
-			J721E_IOPAD(0x248, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
-			J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
-			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
-			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
-		>;
-	};
-
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
@@ -423,6 +389,11 @@
 				bootph-pre-ram;
 			};
 		};
+
+		esm: esm {
+			compatible = "ti,tps659413-esm";
+			bootph-pre-ram;
+		};
 	};
 };
 
-- 
2.34.1

