Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD74C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F11E87C2F;
	Fri, 29 Dec 2023 18:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kauuAL+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0079787B93; Fri, 29 Dec 2023 18:47:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421A187BBD
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl10j006044;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=lrmhAK/zfPlYPvI1hpUvh1XTL7C7OPP8VElicpHJ6Uk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kauuAL+s9gsS2B7Yi4PRESzdF2n3qnIqlUaXteIorHQ2CFr0l5CpbhRj9+NVxRo7C
 QMuhji5c6ASuZvq76kWAHxXnm/g6LcIe794uV0muVC8Z5E4GklMs9nyCQ+YqC5Uz5G
 SZmOgivpFtPZyNjhZEefNEeSvAD1J7KfkUc/udhw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1hb025014
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl074005052;
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
Subject: [PATCH v2 05/26] arm: dts: k3-am654: copy bootph properties to a53 dts
Date: Fri, 29 Dec 2023 11:47:02 -0600
Message-ID: <20231229174656.634065-33-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9658; i=bb@ti.com;
 h=from:subject; bh=4tIyunQZ1oNyy/Q5b8HHQDDESiwImQf2GCcktdQh+C0=;
 b=owNCWmg5MUFZJlNZPAFE1AAAcv///7/v5+t273v+7/+++v/39z273m2KPff/dHvrx9zH312wA
 RmYHajQBoAaAADQDQANNAA0BoAGhoBoAABoA0Bo9TQGQBoaNPSGnqGjEbTNUQGgaGgDINDQMgGR
 ppgmQGgGJoaA0GgNNAND0g9E0B6jQ0BkaNGgDQ0BoNAZNByN6kA0GgyGgAAMgDIAADQPUAAAZNN
 DBMjRkGgDQNA0ZAAHkQNDJoDAAUNwQ06IUGubgRH7ZP1odNGKh0Tfh17idIuwpQH1fMV+iC81Wa
 WwylD2+YszykioH228MIJcAR7oDhTumsm9MGpOJjJggHCUnOT2JAOigHzirVsjPBriA9WAJyKx/
 uIV7VikR8mGJ4Fi+fEHtNQnvEoVxAgwBNWwWJhikNDaQ9aT+we02gLs4fqeQgEFH2AG9u9OkqlJ
 9LRQU4+jMgCKX7pB7lMvXcNkepkd+wRs1DAT/PWOeBizI3YnAd9z4h/akCxMui61XR6IVF1LEtx
 NyzWFL4iJKMRwPfknF3Ueh3dKnjMKAzRASf99cBCyHOeKMBzyZ5RphJkVnUsBXOKDYoh5L7Uqu0
 hMcVIdNrX5Ay2JQWgVqh1awWrJhVBdIEOcXXKUysWmxgtQSU/IgBYgNB4AXDnl4ZwBpfzEFQiOE
 AJ0kD/F3JFOFCQPAFE1AA==
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 160 +++++++++++++++++++
 arch/arm/dts/k3-am654-r5-base-board.dts      |  85 +---------
 2 files changed, 162 insertions(+), 83 deletions(-)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index f29cecf870bcd..4b1e8ce2c920c 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -5,6 +5,166 @@
 
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
+&wkup_i2c0_pins_default {
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
index d75c7bf3fe662..8f55dab508ee6 100644
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
@@ -150,40 +115,29 @@
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
+	bootph-pre-ram;
 };
 
 &mcu_uart0 {
-	bootph-pre-ram;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
 	clock-frequency = <48000000>;
 	/delete-property/ power-domains;
 	status = "okay";
+	bootph-pre-ram;
 };
 
 &main_uart0 {
@@ -191,18 +145,15 @@
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
@@ -210,14 +161,12 @@
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
@@ -227,7 +176,6 @@
 			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
 			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
 		>;
-		bootph-pre-ram;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
@@ -235,7 +183,6 @@
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
-		bootph-pre-ram;
 	};
 
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
@@ -252,12 +199,10 @@
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
@@ -265,7 +210,6 @@
 			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
 			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
 		>;
-		bootph-pre-ram;
 	};
 
 	main_mmc0_pins_default: main_mmc0_pins_default {
@@ -282,7 +226,6 @@
 			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0)	/* (D25) MMC0_DAT7 */
 			AM65X_IOPAD(0x01b0, PIN_INPUT, 0)		/* (C25) MMC0_DS */
 		>;
-		bootph-pre-ram;
 	};
 
 	main_mmc1_pins_default: main_mmc1_pins_default {
@@ -296,21 +239,15 @@
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
@@ -323,7 +260,6 @@
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	/delete-property/ power-domains;
 	ti,driver-strength-ohm = <50>;
-	bootph-pre-ram;
 };
 
 &sdhci1 {
@@ -332,14 +268,12 @@
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
@@ -351,7 +285,6 @@
 		regulator-boot-on;
 		ti,vsel0-state-high;
 		ti,vsel1-state-high;
-		bootph-pre-ram;
 	};
 };
 
@@ -376,23 +309,19 @@
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
@@ -401,7 +330,6 @@
 
 &usb0_phy {
 	status = "okay";
-	bootph-pre-ram;
 	/delete-property/ clocks;
 };
 
@@ -409,11 +337,6 @@
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
@@ -441,7 +364,3 @@
 &usb1 {
 	dr_mode = "peripheral";
 };
-
-&fss {
-	bootph-pre-ram;
-};
-- 
2.43.0

