Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAB3CCD1BF
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 02:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9518583906;
	Sat, 25 Oct 2025 04:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AjnqxU0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303B983869; Sat, 25 Oct 2025 04:48:45 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FBF7838EC
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 04:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P2meNa2019969;
 Fri, 24 Oct 2025 21:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761360520;
 bh=vVxuyb4LkYhZ9OrOaq7brrzu0KvA1sV9omtwF4ZNRZI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=AjnqxU0qCFvv+VzCHRQRVDMsry4mIQ8O8z0VZgfl6+AOFxznzWUDYPbU0O94RMSyR
 s6zIDn6KabCKIgC12lwgZZIWZDM5l6pEBsRDsXLFOi0yzCQfnNEodlgJC8T/T2xU/O
 veEjB4dvcu0u/h6BoIiEGyrUBQmTbj80YvhMUPgE=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P2meh94007278
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 21:48:40 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 21:48:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 21:48:40 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P2mdTC1259378;
 Fri, 24 Oct 2025 21:48:39 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Sat, 25 Oct 2025 08:18:10 +0530
Subject: [PATCH v3 4/5] arm64: dts: ti: Add support for AM6254atl SiP SK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251025-62sip_support-v3-4-b4c8314d0055@ti.com>
References: <20251025-62sip_support-v3-0-b4c8314d0055@ti.com>
In-Reply-To: <20251025-62sip_support-v3-0-b4c8314d0055@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761360511; l=19547;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=qntmsiBZO1CLBhj6fimQ5c40uYdnxGcKELXcx/LGYog=;
 b=9qzFSJO5Dz1zLsCQoAIlwLf5aXwIenY3RlPN2P+idIBp9PqbTpEyckHo0Iz+sAzmCNbIFtb7H
 AeEuWolM4U1AltLRYfWPgu7J36HV6vPulLKqNMok5Z676egSHtuPZ4O
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch adds the dt for SK-AM62-SIP, which uses the existing
SK-AM62 board design with the new AM6254atl SiP. This changes the
location of memory node from the board dts to SoC level dtsi
(k3-am6254atl in our case).

Therefore this patch introduces the new 'k3-am625-sk-common.dtsi'
which represents the common hardware used for both 'am625-sk' and
'am6254atl-sk' boards with the inheritance hierarchy modified to:

k3-am625-sk.dts:

     k3-am62    k3-am62x-sk-common
        |            |
    k3-am625    k3-am625-sk-common
        |            |
        +-----+------+
              |
         k3-am625-sk

k3-am6254atl-sk.dts:

     k3-am62
        |
     k3-am625       k3-am62x-sk-common
        |                |
    k3-am6254atl    k3-am625-sk-common
        |                |
        +-------+--------+
                |
         k3-am6254atl-sk

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://patch.msgid.link/20250814134531.2743874-5-anshuld@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 2517e476b819df986fa1fe53927c099032bb72dc ]

(cherry picked from commit 58cd89aff167661dbae0c9911282ea3f1b8212cc)
---
 dts/upstream/src/arm64/ti/k3-am625-sk-common.dtsi | 296 ++++++++++++++++++++++
 dts/upstream/src/arm64/ti/k3-am625-sk.dts         | 296 +---------------------
 dts/upstream/src/arm64/ti/k3-am6254atl-sk.dts     |  15 ++
 3 files changed, 312 insertions(+), 295 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am625-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am625-sk-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..fe0b98e1d10557a7b649b04105545f913d2d9056
--- /dev/null
+++ b/dts/upstream/src/arm64/ti/k3-am625-sk-common.dtsi
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Common dtsi for AM625 SK and derivatives
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am62x-sk-common.dtsi"
+
+/ {
+	opp-table {
+		/* Add 1.4GHz OPP for am625-sk board. Requires VDD_CORE to be at 0.85V */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vcc_5v0: regulator-1 {
+		/* Output of LM34936 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vcc_3v3_sys: regulator-2 {
+		/* output of LM61460-Q1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vdd_mmc1: regulator-3 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vcc_3v3_sys>;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_sd_dv: regulator-4 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vcc_5v0>;
+		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		bootph-all;
+	};
+
+	vcc_1v8: regulator-5 {
+		/* output of TPS6282518DMQ */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
+			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
+			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
+			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
+			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
+			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
+			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
+			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
+			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
+			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
+			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
+			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
+			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
+			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
+			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
+			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
+			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
+			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
+			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
+			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
+			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
+		>;
+		bootph-all;
+	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
+		>;
+		bootph-all;
+	};
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
+&main_i2c1 {
+	exp1: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+				   "PRU_DETECT", "MMC1_SD_EN",
+				   "VPP_LDO_EN", "EXP_PS_3V3_En",
+				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
+				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
+				   "UART1_FET_BUF_EN", "WL_LT_EN",
+				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
+				   "CSI_GPIO2", "PRU_3V3_EN",
+				   "HDMI_INTn", "PD_I2C_IRQ",
+				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
+				   "MCASP1_FET_SEL", "UART1_FET_SEL",
+				   "TSINT#", "IO_EXP_TEST_LED";
+		bootph-all;
+	};
+};
+
+&sdhci0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	disable-wp;
+};
+
+&sdhci1 {
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
+};
+
+&cpsw_port2 {
+	/* PCB provides an internal delay of 2ns */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&fss {
+	bootph-all;
+};
+
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
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
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				bootph-pre-ram;
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/ti/k3-am625-sk.dts b/dts/upstream/src/arm64/ti/k3-am625-sk.dts
index 1c6812a8ae9b5d8f274f5a3fa88738eafbc747a7..52954c77df804ad98dd16378b63d12289407f7a6 100644
--- a/dts/upstream/src/arm64/ti/k3-am625-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am625-sk.dts
@@ -8,310 +8,16 @@
 /dts-v1/;
 
 #include "k3-am625.dtsi"
-#include "k3-am62x-sk-common.dtsi"
+#include "k3-am625-sk-common.dtsi"
 
 / {
 	compatible = "ti,am625-sk", "ti,am625";
 	model = "Texas Instruments AM625 SK";
 
-	opp-table {
-		/* Add 1.4GHz OPP for am625-sk board. Requires VDD_CORE to be at 0.85V */
-		opp-1400000000 {
-			opp-hz = /bits/ 64 <1400000000>;
-			opp-supported-hw = <0x01 0x0004>;
-			clock-latency-ns = <6000000>;
-		};
-	};
-
 	memory@80000000 {
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 		device_type = "memory";
 		bootph-pre-ram;
 	};
-
-	vmain_pd: regulator-0 {
-		/* TPS65988 PD CONTROLLER OUTPUT */
-		bootph-all;
-		compatible = "regulator-fixed";
-		regulator-name = "vmain_pd";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_5v0: regulator-1 {
-		/* Output of LM34936 */
-		bootph-all;
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vmain_pd>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_3v3_sys: regulator-2 {
-		/* output of LM61460-Q1 */
-		bootph-all;
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_sys";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vmain_pd>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vdd_mmc1: regulator-3 {
-		/* TPS22918DBVR */
-		bootph-all;
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_mmc1";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		enable-active-high;
-		vin-supply = <&vcc_3v3_sys>;
-		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
-	};
-
-	vdd_sd_dv: regulator-4 {
-		/* Output of TLV71033 */
-		bootph-all;
-		compatible = "regulator-gpio";
-		regulator-name = "tlv71033";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vdd_sd_dv_pins_default>;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		vin-supply = <&vcc_5v0>;
-		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x0>,
-			 <3300000 0x1>;
-	};
-
-	vcc_1v8: regulator-5 {
-		/* output of TPS6282518DMQ */
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_3v3_sys>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&main_pmx0 {
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
-		>;
-	};
-
-	main_rgmii2_pins_default: main-rgmii2-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
-			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
-			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
-			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
-			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
-			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
-			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
-			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
-			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
-			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
-			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
-			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
-		>;
-	};
-
-	ospi0_pins_default: ospi0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
-			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
-			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
-			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
-			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
-			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
-			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
-			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
-			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
-			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
-			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
-		>;
-	};
-
-	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
-		>;
-	};
-
-	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
-		>;
-	};
-};
-
-&main_gpio0 {
-	bootph-all;
-};
-
-&main_gpio1 {
-	bootph-all;
-};
-
-&main_i2c1 {
-	bootph-all;
-	exp1: gpio@22 {
-		bootph-all;
-		compatible = "ti,tca6424";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
-				   "PRU_DETECT", "MMC1_SD_EN",
-				   "VPP_LDO_EN", "EXP_PS_3V3_En",
-				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
-				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
-				   "UART1_FET_BUF_EN", "WL_LT_EN",
-				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
-				   "CSI_GPIO2", "PRU_3V3_EN",
-				   "HDMI_INTn", "PD_I2C_IRQ",
-				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
-				   "MCASP1_FET_SEL", "UART1_FET_SEL",
-				   "TSINT#", "IO_EXP_TEST_LED";
-
-		interrupt-parent = <&main_gpio1>;
-		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
-	};
-};
-
-&sdhci0 {
-	bootph-all;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	status = "okay";
-};
-
-&sdhci1 {
-	vmmc-supply = <&vdd_mmc1>;
-	vqmmc-supply = <&vdd_sd_dv>;
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
-};
-
-&cpsw_port2 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy1>;
-};
-
-&cpsw3g_mdio {
-	cpsw3g_phy1: ethernet-phy@1 {
-		reg = <1>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		ti,min-output-impedance;
-	};
-};
-
-&fss {
-	bootph-all;
-};
-
-&ospi0 {
-	bootph-all;
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&ospi0_pins_default>;
-
-	flash@0 {
-		bootph-all;
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <8>;
-		spi-rx-bus-width = <8>;
-		spi-max-frequency = <25000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <4>;
-
-		partitions {
-			bootph-all;
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "ospi.tiboot3";
-				reg = <0x0 0x80000>;
-			};
-
-			partition@80000 {
-				label = "ospi.tispl";
-				reg = <0x80000 0x200000>;
-			};
-
-			partition@280000 {
-				label = "ospi.u-boot";
-				reg = <0x280000 0x400000>;
-			};
-
-			partition@680000 {
-				label = "ospi.env";
-				reg = <0x680000 0x40000>;
-			};
-
-			partition@6c0000 {
-				label = "ospi.env.backup";
-				reg = <0x6c0000 0x40000>;
-			};
-
-			partition@800000 {
-				label = "ospi.rootfs";
-				reg = <0x800000 0x37c0000>;
-			};
-
-			partition@3fc0000 {
-				bootph-pre-ram;
-				label = "ospi.phypattern";
-				reg = <0x3fc0000 0x40000>;
-			};
-		};
-	};
-};
-
-&tlv320aic3106 {
-	DVDD-supply = <&vcc_1v8>;
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am6254atl-sk.dts b/dts/upstream/src/arm64/ti/k3-am6254atl-sk.dts
new file mode 100644
index 0000000000000000000000000000000000000000..055e63a3fbb1ceb22bb0b66a980eac45aaceafb3
--- /dev/null
+++ b/dts/upstream/src/arm64/ti/k3-am6254atl-sk.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * AM6254atl SiP SK: https://www.ti.com/lit/df/sprr482b/sprr482b.zip
+ * Webpage: https://www.ti.com/tool/SK-AM62-SIP
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am6254atl.dtsi"
+#include "k3-am625-sk-common.dtsi"
+
+/ {
+	model = "Texas Instruments AM6254atl SK";
+	compatible = "ti,am6254atl-sk", "ti,am6254atl", "ti,am625";
+};

-- 
2.51.0

