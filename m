Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15657EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C92686E1B;
	Mon, 11 Sep 2023 16:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D4aB/Za/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C1986E27; Mon, 11 Sep 2023 16:03:06 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04CC86E1B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2wxd001251;
 Mon, 11 Sep 2023 09:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694440978;
 bh=RmreKjWjSzQHd3wnr2nQBgdUXezWwveEk9kgagj2QyM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=D4aB/Za/t4D+84/w2Hd4BlfXCcDTzAYrqSPVabPPeHEuW8NVIuYxmUrYVC4eN8F8h
 40YRi5NKto3aRCNzWiKixIbdCjIkM+SPMZDNkg7iSG+JhDkhtoo1IDRI4Jyjht+uiP
 vvhS9SZarmnMrBCsED42KWd8omjL/2DM/CLjrLGg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE2v2t052638
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:02:58 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:02:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:02:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2vau031005;
 Mon, 11 Sep 2023 09:02:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-am625: Sync with kernel v6.6-rc1
Date: Mon, 11 Sep 2023 09:02:56 -0500
Message-ID: <20230911140256.945074-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911140256.945074-1-nm@ti.com>
References: <20230911140256.945074-1-nm@ti.com>
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

Sync device tree with v6.6-rc1

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am62-main.dtsi       |  52 ++++++++-
 arch/arm/dts/k3-am62-mcu.dtsi        |  24 +++++
 arch/arm/dts/k3-am62-verdin-dev.dtsi |  50 +++++++++
 arch/arm/dts/k3-am62-verdin.dtsi     |  45 +++++++-
 arch/arm/dts/k3-am62.dtsi            |   8 ++
 arch/arm/dts/k3-am625-beagleplay.dts | 154 ++++++++++++++++++++++++++-
 arch/arm/dts/k3-am625-sk.dts         |   2 +-
 7 files changed, 325 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/k3-am62-main.dtsi b/arch/arm/dts/k3-am62-main.dtsi
index 2488e3a537fe..284b90c94da8 100644
--- a/arch/arm/dts/k3-am62-main.dtsi
+++ b/arch/arm/dts/k3-am62-main.dtsi
@@ -55,11 +55,29 @@
 			#phy-cells = <1>;
 		};
 
-		epwm_tbclk: clock@4130 {
-			compatible = "ti,am62-epwm-tbclk", "syscon";
+		epwm_tbclk: clock-controller@4130 {
+			compatible = "ti,am62-epwm-tbclk";
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk0: clock-controller@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock-controller@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 10>;
+			assigned-clocks = <&k3_clks 157 10>;
+			assigned-clock-parents = <&k3_clks 157 18>;
+			#clock-cells = <0>;
+		};
 	};
 
 	dmss: bus@48000000 {
@@ -174,7 +192,6 @@
 	crypto: crypto@40900000 {
 		compatible = "ti,am62-sa3ul";
 		reg = <0x00 0x40900000 0x00 0x1200>;
-		power-domains = <&k3_pds 70 TI_SCI_PD_SHARED>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
@@ -590,7 +607,7 @@
 
 		usb0: usb@31000000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31000000 0x00 0x50000>;
+			reg = <0x00 0x31000000 0x00 0x50000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
@@ -613,7 +630,7 @@
 
 		usb1: usb@31100000 {
 			compatible = "snps,dwc3";
-			reg =<0x00 0x31100000 0x00 0x50000>;
+			reg = <0x00 0x31100000 0x00 0x50000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
 				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
 			interrupt-names = "host", "peripheral";
@@ -718,6 +735,31 @@
 		};
 	};
 
+	dss: dss@30200000 {
+		compatible = "ti,am625-dss";
+		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30206000 0x00 0x1000>, /* vid */
+		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
+		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		reg-names = "common", "vidl1", "vid",
+			    "ovr1", "ovr2", "vp1", "vp2";
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 186 6>,
+			 <&dss_vp1_clk>,
+			 <&k3_clks 186 2>;
+		clock-names = "fck", "vp1", "vp2";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		dss_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	hwspinlock: spinlock@2a000000 {
 		compatible = "ti,am64-hwspinlock";
 		reg = <0x00 0x2a000000 0x00 0x1000>;
diff --git a/arch/arm/dts/k3-am62-mcu.dtsi b/arch/arm/dts/k3-am62-mcu.dtsi
index 19fc38157d94..80a3e1db26a9 100644
--- a/arch/arm/dts/k3-am62-mcu.dtsi
+++ b/arch/arm/dts/k3-am62-mcu.dtsi
@@ -147,4 +147,28 @@
 		/* Tightly coupled to M4F */
 		status = "reserved";
 	};
+
+	mcu_mcan0: can@4e08000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x4e08000 0x00 0x200>,
+		      <0x00 0x4e00000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
+		clock-names = "hclk", "cclk";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@4e18000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x4e18000 0x00 0x200>,
+		      <0x00 0x4e10000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
+		clock-names = "hclk", "cclk";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/dts/k3-am62-verdin-dev.dtsi b/arch/arm/dts/k3-am62-verdin-dev.dtsi
index 846caee7dfa4..6701cb8974bb 100644
--- a/arch/arm/dts/k3-am62-verdin-dev.dtsi
+++ b/arch/arm/dts/k3-am62-verdin-dev.dtsi
@@ -8,6 +8,42 @@
  * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
  */
 
+/ {
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "verdin-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&audio_refclk1>;
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+		};
+	};
+};
+
 /* Verdin ETHs */
 &cpsw3g {
 	pinctrl-names = "default";
@@ -65,6 +101,15 @@
 &main_i2c1 {
 	status = "okay";
 
+	/* Audio Codec */
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s1_mclk>;
+		#sound-dai-cells = <0>;
+	};
+
 	/* IO Expander */
 	gpio_expander_21: gpio@21 {
 		compatible = "nxp,pcal6416";
@@ -144,6 +189,11 @@
 	status = "okay";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
 /* Verdin UART_4 */
 &mcu_uart0 {
 	status = "okay";
diff --git a/arch/arm/dts/k3-am62-verdin.dtsi b/arch/arm/dts/k3-am62-verdin.dtsi
index 57dd061911ab..40992e7e4c30 100644
--- a/arch/arm/dts/k3-am62-verdin.dtsi
+++ b/arch/arm/dts/k3-am62-verdin.dtsi
@@ -19,6 +19,8 @@
 	};
 
 	aliases {
+		can0 = &main_mcan0;
+		can1 = &mcu_mcan0;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
 		i2c0 = &main_i2c0;
@@ -732,6 +734,14 @@
 		>;
 	};
 
+	/* Verdin CAN_2 */
+	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
+			AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */
+		>;
+	};
+
 	/* Verdin UART_4 - Reserved to Cortex-M4 */
 	pinctrl_mcu_uart0: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
@@ -758,6 +768,11 @@
 	};
 };
 
+/* VERDIN I2S_1_MCLK */
+&audio_refclk1 {
+	assigned-clock-rates = <25000000>;
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1>;
@@ -800,6 +815,26 @@
 	};
 };
 
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_parallel_rgb>;
+	status = "disabled";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi_out: endpoint {
+			remote-endpoint = <&rgb_in>;
+		};
+	};
+};
+
 /* Verdin PWM_1, PWM_2 */
 &epwm0 {
 	pinctrl-names = "default";
@@ -1036,6 +1071,7 @@
 
 				rgb_in: endpoint {
 					data-lines = <18>;
+					remote-endpoint = <&dpi_out>;
 				};
 			};
 
@@ -1238,8 +1274,6 @@
 	status = "disabled";
 };
 
-/* Verdin CAN_2 - Reserved to Cortex-M4 */
-
 /* Verdin SPI_1 */
 &main_spi1 {
 	pinctrl-names = "default";
@@ -1333,6 +1367,13 @@
 		"";
 };
 
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_mcan0>;
+	status = "disabled";
+};
+
 /* Verdin UART_4 - Cortex-M4 UART */
 &mcu_uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/k3-am62.dtsi b/arch/arm/dts/k3-am62.dtsi
index 5e72c445f37a..11f14eef2d44 100644
--- a/arch/arm/dts/k3-am62.dtsi
+++ b/arch/arm/dts/k3-am62.dtsi
@@ -102,6 +102,14 @@
 		};
 	};
 
+	dss_vp1_clk: clock-divider-oldi {
+		compatible = "fixed-factor-clock";
+		clocks = <&k3_clks 186 0>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+	};
+
 	#include "k3-am62-thermal.dtsi"
 };
 
diff --git a/arch/arm/dts/k3-am625-beagleplay.dts b/arch/arm/dts/k3-am625-beagleplay.dts
index 589bf998bc52..7cfdf562b53b 100644
--- a/arch/arm/dts/k3-am625-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-beagleplay.dts
@@ -14,7 +14,7 @@
 #include "k3-am625.dtsi"
 
 / {
-	compatible =  "beagle,am625-beagleplay", "ti,am625";
+	compatible = "beagle,am625-beagleplay", "ti,am625";
 	model = "BeagleBoard.org BeaglePlay";
 
 	aliases {
@@ -192,6 +192,34 @@
 
 	};
 
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it66121_out>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "it66121 HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&hdmi_dailink_master>;
+		simple-audio-card,frame-master = <&hdmi_dailink_master>;
+
+		hdmi_dailink_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&it66121>;
+		};
+	};
+
 	/* Workaround for errata i2329 - just use mdio bitbang */
 	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
@@ -422,6 +450,57 @@
 			AM62X_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (D16) EXTINTn */
 		>;
 	};
+
+	hdmi_gpio_pins_default: hdmi-gpio-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0094, PIN_INPUT_PULLUP | PIN_DEBOUNCE_CONF6, 7) /* (N20) GPMC0_BE1n.GPIO0_36 */
+			AM62X_IOPAD(0x0054, PIN_OUTPUT_PULLUP, 7) /* (P21) GPMC0_AD6.GPIO0_21 */
+		>;
+	};
+
+	mcasp_hdmi_pins_default: mcasp-hdmi-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62X_IOPAD(0x0088, PIN_INPUT, 2) /* (L24) GPMC0_OEn_REn.MCASP1_AXR1 */
+			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+			AM62X_IOPAD(0x007c, PIN_INPUT, 2) /* (P25) GPMC0_CLK.MCASP1_AXR3 */
+		>;
+	};
+
+	dss0_pins_default: dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+			AM62X_IOPAD(0x00f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x0104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x00fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x00b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x00bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x00c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x00c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x00c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x00cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x00d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x00d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x00d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x00dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x00e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x005c, PIN_OUTPUT, 1) /* (R24) GPMC0_AD8.VOUT0_DATA16 */
+			AM62X_IOPAD(0x0060, PIN_OUTPUT, 1) /* (R25) GPMC0_AD9.VOUT0_DATA17 */
+			AM62X_IOPAD(0x0064, PIN_OUTPUT, 1) /* (T25) GPMC0_AD10.VOUT0_DATA18 */
+			AM62X_IOPAD(0x0068, PIN_OUTPUT, 1) /* (R21) GPMC0_AD11.VOUT0_DATA19 */
+			AM62X_IOPAD(0x006c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
+			AM62X_IOPAD(0x0070, PIN_OUTPUT, 1) /* (T24) GPMC0_AD13.VOUT0_DATA21 */
+			AM62X_IOPAD(0x0074, PIN_OUTPUT, 1) /* (U25) GPMC0_AD14.VOUT0_DATA22 */
+			AM62X_IOPAD(0x0078, PIN_OUTPUT, 1) /* (U24) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -432,7 +511,7 @@
 		>;
 	};
 
-	gbe_pmx_obsclk: gbe-pmx-clk-default {
+	gbe_pmx_obsclk: gbe-pmx-obsclk-default-pins {
 		pinctrl-single,pins = <
 			AM62X_MCU_IOPAD(0x0004, PIN_OUTPUT, 1) /* (B8) MCU_SPI0_CS1.MCU_OBSCLK0 */
 		>;
@@ -670,6 +749,42 @@
 	pinctrl-0 = <&i2c2_1v8_pins_default>;
 	clock-frequency = <100000>;
 	status = "okay";
+
+	it66121: bridge-hdmi@4c {
+		compatible = "ite,it66121";
+		reg = <0x4c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_gpio_pins_default>;
+		vcn33-supply = <&vdd_3v3>;
+		vcn18-supply = <&buck2_reg>;
+		vrf12-supply = <&buck3_reg>;
+		reset-gpios = <&main_gpio0 21 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <36 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it66121_in: endpoint {
+					bus-width = <24>;
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				it66121_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c3 {
@@ -756,3 +871,38 @@
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
 };
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss0_pins_default>;
+};
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp_hdmi_pins_default>;
+	auxclk-fs-ratio = <2177>;
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
diff --git a/arch/arm/dts/k3-am625-sk.dts b/arch/arm/dts/k3-am625-sk.dts
index 3f9ef4053aa6..7c98c1b855d1 100644
--- a/arch/arm/dts/k3-am625-sk.dts
+++ b/arch/arm/dts/k3-am625-sk.dts
@@ -212,7 +212,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
-- 
2.40.0

