Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6457C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB60E87904;
	Thu, 21 Dec 2023 18:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w3XNvPa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A8A878F7; Thu, 21 Dec 2023 18:44:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B71C8785E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEj4118509;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=gBVrTwrpEIF29xo3WAwtvUfSQ9Us72r6twzmtCOqvv0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=w3XNvPa2NF6WgKZKPPq3CaQgy+AcckZnOQQmAV2huz+Ie6QRPeCsGJg56gXOV8o+0
 LGWWoDkYhmwPXj/KJov6NJtz4R+xVh6J3ebGrgN28f1K3regdpftw+UjAR/GfOLqxu
 Pkop+PTA5ci9v/ziC0wynQB7ZLFhqlTnIkgYJkek=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEQJ097298
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEDY080220;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 05/26] arm: dts: k3-am654: copy bootph properties to a53 dts
Date: Thu, 21 Dec 2023 11:43:51 -0600
Message-ID: <20231221174412.210807-6-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9581; i=bb@ti.com;
 h=from:subject; bh=qLG2Yf7jWQHqX3um6jE8OZM0mpNdpH6Ra8EU6PYGn8s=;
 b=owNCWmg5MUFZJlNZsr4QtgAAa3////95cr313/+eo6jP/3nro1/v6Sf0/3o7e11Z7jd/+v2wA
 RtjQxQDQNBkABhAAADTQaaAA0aaaNMgGIBo0aNAAGg000PUaNqHohtRk02o2jSIABo0GTIaaGmT
 IGg0YmQyGJpowTQNNDTTRoBoDINGIaNDIxNMmRhGhppoYjQBDQ9EHqNNBoAGjIBoMgyGg00aY0g
 NDJkAaGhoZAZqBkBoBoYTRppghoepo0ZAAHoCcODEqNKMjrMb+Dwaacho27+tWRUoF46HkIKJPd
 4qtdqRd40DKAEvEpH332/jSEiQ8bKCinkB2m08rmtcLg7EzzRaIdfH3ONqARN1S+dUdf9M2KDda
 lkOhtVjg/QvicbFfzgWWfEWM1sUwNfofUEGl056PTW/v0q21Sx4hZVR5oyWPwjUxsWkLqlc16mZ
 3vkFJ7cHOk8IRudXmnN+lSC79h2vwRjyAiyFnY91ezsIVQAwg43Mwm6NWTRvBTxovmXUxRXFOmY
 rR14iJATXRliH9qXtkESyrzxl1DpCQC2ZNGfsAI/dkZJ7RYyb3TBD/5sGLK0HmgG1wQL0R5Pkwp
 edrBCsZkWFIZLB8fr8jjIq+TtQSvKbamCn8tdAmXDgqkebd7gLh3PccAHKuckcstPAIEbdpQBlH
 eiCGirIUQh2QWef4u5IpwoSFlfCFsA=
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

In order to unify the R5 board dtb file with the Linux board dtb file,
we will need to copy all bootph-pre-ram properties to the *-u-boot.dtsi
overlay.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 168 +++++++++++++++++++
 arch/arm/dts/k3-am654-r5-base-board.dts      |  83 ---------
 2 files changed, 168 insertions(+), 83 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index f29cecf870bcd..0ecd7a56ebdbb 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -5,6 +5,174 @@
 
 #include "k3-am65x-binman.dtsi"
 
+&vtt_supply {
+	bootph-pre-ram;
+};
+
+&cbass_main {
+	bootph-pre-ram;
+};
+
+&main_navss {
+	bootph-pre-ram;
+};
+
+&cbass_mcu {
+	bootph-pre-ram;
+};
+
+&mcu_navss {
+	bootph-pre-ram;
+};
+
+&mcu_ringacc {
+	bootph-pre-ram;
+};
+
+&mcu_udmap {
+	bootph-pre-ram;
+};
+
+&wkup_gpio0 {
+	bootph-pre-ram;
+};
+
+&secure_proxy_main {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
+
+	chipid@43000014 {
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	bootph-pre-ram;
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
+};
+
+&wkup_uart0 {
+	bootph-pre-ram;
+};
+
+&mcu_uart0 {
+	bootph-pre-ram;
+};
+
+&main_uart0 {
+	bootph-pre-ram;
+};
+
+&wkup_vtm0 {
+	bootph-pre-ram;
+};
+
+&wkup_pmx0 {
+	bootph-pre-ram;
+};
+
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_vtt_pins_default {
+	bootph-pre-ram;
+};
+
+&mcu_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_i2c_pins_default {
+	bootph-pre-ram;
+};
+
+&mcu_fss0_ospi0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_pmx0 {
+	bootph-pre-ram;
+};
+
+&main_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_mmc0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_mmc1_pins_default {
+	bootph-pre-ram;
+};
+
+&usb0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_pmx1 {
+	bootph-pre-ram;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+};
+
+&sdhci1 {
+	bootph-pre-ram;
+};
+
+&wkup_i2c0 {
+	bootph-pre-ram;
+};
+
+&vdd_mpu {
+	bootph-pre-ram;
+};
+
+&ospi0 {
+	bootph-pre-ram;
+
+	flash@0 {
+		bootph-pre-ram;
+	};
+};
+
+&dwc3_0 {
+	bootph-pre-ram;
+};
+
+&usb0_phy {
+	bootph-pre-ram;
+};
+
+&usb0 {
+	bootph-pre-ram;
+};
+
+&scm_conf {
+	bootph-pre-ram;
+};
+
+&fss {
+	bootph-pre-ram;
+};
+
 &pru0_0 {
 	remoteproc-name = "pru0_0";
 };
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index d75c7bf3fe662..821c7dcb5e936 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -53,13 +53,10 @@
 		regulator-max-microvolt = <3300000>;
 		gpios = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
 		states = <0 0x0 3300000 0x1>;
-		bootph-pre-ram;
 	};
 };
 
 &cbass_main {
-	bootph-pre-ram;
-
 	timer1: timer@40400000 {
 		compatible = "ti,omap5430-timer";
 		reg = <0x0 0x40400000 0x0 0x80>;
@@ -67,15 +64,9 @@
 		clock-frequency = <25000000>;
 		bootph-all;
 	};
-
-	main_navss: bus@30800000 {
-		bootph-pre-ram;
-	};
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
-
 	mcu_secproxy: secproxy@28380000 {
 		compatible = "ti,am654-secure-proxy";
 		reg = <0x0 0x2a380000 0x0 0x80000>,
@@ -87,8 +78,6 @@
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-pre-ram;
-
 		ringacc@2b800000 {
 			reg =	<0x0 0x2b800000 0x0 0x400000>,
 				<0x0 0x2b000000 0x0 0x400000>,
@@ -96,7 +85,6 @@
 				<0x0 0x2a500000 0x0 0x40000>,
 				<0x0 0x28440000 0x0 0x40000>;
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			bootph-pre-ram;
 			ti,dma-ring-reset-quirk;
 		};
 
@@ -109,34 +97,11 @@
 				<0x0 0x28400000 0x0 0x2000>;
 			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
 					    "tchanrt", "rflow";
-			bootph-pre-ram;
 		};
 	};
 };
 
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
-&wkup_gpio0 {
-	bootph-pre-ram;
-};
-
-&secure_proxy_main {
-	bootph-pre-ram;
-};
-
 &cbass_wakeup {
-	bootph-pre-ram;
-
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
 		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
@@ -150,35 +115,22 @@
 		clock-frequency = <200000000>;
 		bootph-pre-ram;
 	};
-
-	chipid@43000014 {
-		bootph-pre-ram;
-	};
 };
 
 &dmsc {
-	bootph-pre-ram;
-
 	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
-
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
 };
 
 &wkup_uart0 {
-	bootph-pre-ram;
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
 	status = "okay";
 };
 
 &mcu_uart0 {
-	bootph-pre-ram;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
 	clock-frequency = <48000000>;
@@ -191,18 +143,15 @@
 	pinctrl-0 = <&main_uart0_pins_default>;
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 	status = "okay";
-	bootph-pre-ram;
 };
 
 &wkup_vtm0 {
 	compatible = "ti,am654-vtm", "ti,am654-avs";
 	vdd-supply-3 = <&vdd_mpu>;
 	vdd-supply-4 = <&vdd_mpu>;
-	bootph-pre-ram;
 };
 
 &wkup_pmx0 {
-	bootph-pre-ram;
 	wkup_uart0_pins_default: wkup_uart0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x00a0, PIN_INPUT, 0)	/* (AB1) WKUP_UART0_RXD */
@@ -210,14 +159,12 @@
 			AM65X_WKUP_IOPAD(0x00c8, PIN_INPUT, 1)	/* (AC2) WKUP_GPIO0_6.WKUP_UART0_CTSn */
 			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 		>;
-		bootph-pre-ram;
 	};
 
 	wkup_vtt_pins_default: wkup_vtt_pins_default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
 		>;
-		bootph-pre-ram;
 	};
 
 	mcu_uart0_pins_default: mcu_uart0_pins_default {
@@ -227,7 +174,6 @@
 			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
 			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
 		>;
-		bootph-pre-ram;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
@@ -235,7 +181,6 @@
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
-		bootph-pre-ram;
 	};
 
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
@@ -252,12 +197,10 @@
 			AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
 			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
 		>;
-		bootph-pre-ram;
 	};
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01e4, PIN_INPUT, 0)	/* (AF11) UART0_RXD */
@@ -265,7 +208,6 @@
 			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
 			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
 		>;
-		bootph-pre-ram;
 	};
 
 	main_mmc0_pins_default: main_mmc0_pins_default {
@@ -282,7 +224,6 @@
 			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0)	/* (D25) MMC0_DAT7 */
 			AM65X_IOPAD(0x01b0, PIN_INPUT, 0)		/* (C25) MMC0_DS */
 		>;
-		bootph-pre-ram;
 	};
 
 	main_mmc1_pins_default: main_mmc1_pins_default {
@@ -296,21 +237,15 @@
 			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0)	/* (B24) MMC1_SDCD */
 			AM65X_IOPAD(0x02e0, PIN_INPUT, 0)		/* (C24) MMC1_SDWP */
 		>;
-		bootph-pre-ram;
 	};
 
 	usb0_pins_default: usb0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
 		>;
-		bootph-pre-ram;
 	};
 };
 
-&main_pmx1 {
-	bootph-pre-ram;
-};
-
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
 	pinctrl-names = "default";
@@ -323,7 +258,6 @@
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	/delete-property/ power-domains;
 	ti,driver-strength-ohm = <50>;
-	bootph-pre-ram;
 };
 
 &sdhci1 {
@@ -332,14 +266,12 @@
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	/delete-property/ power-domains;
 	ti,driver-strength-ohm = <50>;
-	bootph-pre-ram;
 };
 
 &wkup_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
-	bootph-pre-ram;
 
 	vdd_mpu: tps62363@60 {
 		compatible = "ti,tps62363";
@@ -351,7 +283,6 @@
 		regulator-boot-on;
 		ti,vsel0-state-high;
 		ti,vsel1-state-high;
-		bootph-pre-ram;
 	};
 };
 
@@ -376,23 +307,19 @@
 		cdns,read-delay = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		bootph-pre-ram;
 	};
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
 	usb0_pins_default: usb0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
 		>;
-		bootph-pre-ram;
 	};
 };
 
 &dwc3_0 {
 	status = "okay";
-	bootph-pre-ram;
 	/delete-property/ clocks;
 	/delete-property/ power-domains;
 	/delete-property/ assigned-clocks;
@@ -401,7 +328,6 @@
 
 &usb0_phy {
 	status = "okay";
-	bootph-pre-ram;
 	/delete-property/ clocks;
 };
 
@@ -409,11 +335,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_pins_default>;
 	dr_mode = "peripheral";
-	bootph-pre-ram;
-};
-
-&scm_conf {
-	bootph-pre-ram;
 };
 
 &davinci_mdio {
@@ -441,7 +362,3 @@
 &usb1 {
 	dr_mode = "peripheral";
 };
-
-&fss {
-	bootph-pre-ram;
-};
-- 
2.43.0

