Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC18CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD02486B2D;
	Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MxwGpwmC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oqWmMisL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321F186B1B; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F54C86AF4
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVKH2vSxz9sm6
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJec5Pveu6RT6NJShuENM6aZEZlIrv1JtFfN9v/Fv6I=;
 b=MxwGpwmCTHgE1rQZmkklVV81rMbn270UCvo6z9hcIBTI4kOiQWAlaKbtGATne5dZUixob5
 7yCnxSey+Yw4aDkHOABNGiSiXZiPGZjRVXKHy7xGbB7hAbIGfGgUXG1ro6hZ2VALrM0iqy
 YhWifCN1fLOvJ/mteU2apCNn24uW5vgWAwDRAa4f2flQn67pO3cZGGXVcIaNGDJAaLsygF
 BoTQbJZr42glN4qIwW5pnlhAFYqupUHOQV7ptWZ8aTgeKH9+xKW9uq2w4jLGqyI5nKBmZC
 naQ2EkKRdcRJS3UI1gp5rgjE/DzUqAV97oprwNLxNPvDMLP9ftoj3QdsEBC9+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJec5Pveu6RT6NJShuENM6aZEZlIrv1JtFfN9v/Fv6I=;
 b=oqWmMisLZxzedz3ajKTzIoHYmJmj34+M7Q8biM6snPiw2LM1x+D/H+4qkmgQqBR9gsVRos
 acfLbxlADJaKr3NRcT0c+VjCyc8os+i2+kfpLnlc8p1g9ih8dba3/ozK+GBEuAan0PyGrq
 MAF8d1erRhvP+suHSI2YuosKtsHymG3pN63zqpMDn4IgKZVeQxPl2ZHmzWfHfDG35iOZvr
 AYxKXXtPhQnOnJSySE5tBplelqIT9A19Iu38Rsl7/L6IMqQUTRnBEo4+l+GWmy7GCe0fiT
 Kqzeiw/zEUmXh4By1yZfWVUURPHhuiwxuBSfUblvcDaLbiREIKaggO8kitDcxw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/19] ARM: dts: renesas: Synchronize R-Car R8A77951 H3 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:04 +0200
Message-Id: <20230917141319.379939-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b61ab9b069e4bee5ba9
X-MBO-RS-META: 91ke6dcto7jfy64qohbyrw4w7h9o9cno
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

Synchronize R-Car R8A77951 H3 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77951.dtsi               |  15 +-
 arch/arm/dts/salvator-common.dtsi        | 253 +++++++++++++++++++----
 arch/arm/dts/salvator-xs.dtsi            |  56 +++++
 arch/arm/dts/ulcb-audio-graph-card.dtsi  |  85 ++++++++
 arch/arm/dts/ulcb-audio-graph-card2.dtsi |  26 +++
 arch/arm/dts/ulcb.dtsi                   |  74 ++-----
 6 files changed, 408 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm/dts/ulcb-audio-graph-card.dtsi
 create mode 100644 arch/arm/dts/ulcb-audio-graph-card2.dtsi

diff --git a/arch/arm/dts/r8a77951.dtsi b/arch/arm/dts/r8a77951.dtsi
index 07c8763c1e7..6d15229d25a 100644
--- a/arch/arm/dts/r8a77951.dtsi
+++ b/arch/arm/dts/r8a77951.dtsi
@@ -75,7 +75,6 @@
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <300000>;
-			turbo-mode;
 		};
 		opp-1700000000 {
 			opp-hz = /bits/ 64 <1700000000>;
@@ -1998,7 +1997,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -2779,8 +2778,8 @@
 				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
 				 <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
 				 <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
@@ -2791,6 +2790,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
@@ -2806,8 +2807,8 @@
 				 <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
 				 <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
 				 <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
@@ -2818,6 +2819,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 318>;
+			iommu-map = <0 &ipmmu_hc 1 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/dts/salvator-common.dtsi b/arch/arm/dts/salvator-common.dtsi
index 23fdd1115b2..4a3d5037821 100644
--- a/arch/arm/dts/salvator-common.dtsi
+++ b/arch/arm/dts/salvator-common.dtsi
@@ -33,9 +33,20 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c_dvfs;
 		serial0 = &scif2;
 		serial1 = &hscif1;
 		ethernet0 = &avb;
+		mmc0 = &sdhi2;
+		mmc1 = &sdhi0;
+		mmc2 = &sdhi3;
 	};
 
 	chosen {
@@ -94,6 +105,7 @@
 
 		port {
 			hdmi0_con: endpoint {
+				remote-endpoint = <&rcar_dw_hdmi0_out>;
 			};
 		};
 	};
@@ -166,7 +178,7 @@
 		};
 	};
 
-	reg_1p8v: regulator0 {
+	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -175,7 +187,7 @@
 		regulator-always-on;
 	};
 
-	reg_3p3v: regulator1 {
+	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -184,7 +196,7 @@
 		regulator-always-on;
 	};
 
-	reg_12v: regulator2 {
+	reg_12v: regulator-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-12V";
 		regulator-min-microvolt = <12000000>;
@@ -198,7 +210,12 @@
 
 		label = "rcar-sound";
 
-		dais = <&rsnd_port0>;
+		dais = <&rsnd_port0	/* ak4613 */
+			&rsnd_port1	/* HDMI0  */
+#ifdef SOC_HAS_HDMI1
+			&rsnd_port2	/* HDMI1  */
+#endif
+			>;
 	};
 
 	vbus0_usb2: regulator-vbus0-usb2 {
@@ -316,6 +333,10 @@
 	};
 };
 
+&a57_0 {
+	cpu-supply = <&dvfs>;
+};
+
 &audio_clk_a {
 	clock-frequency = <22579200>;
 };
@@ -324,7 +345,7 @@
 	pinctrl-0 = <&avb_pins>;
 	pinctrl-names = "default";
 	phy-handle = <&phy0>;
-	phy-mode = "rgmii-txid";
+	tx-internal-delay-ps = <2000>;
 	status = "okay";
 
 	phy0: ethernet-phy@0 {
@@ -343,7 +364,6 @@
 
 	ports {
 		port@0 {
-			reg = <0>;
 			csi20_in: endpoint {
 				clock-lanes = <0>;
 				data-lanes = <1>;
@@ -358,8 +378,6 @@
 
 	ports {
 		port@0 {
-			reg = <0>;
-
 			csi40_in: endpoint {
 				clock-lanes = <0>;
 				data-lanes = <1 2 3 4>;
@@ -376,7 +394,7 @@
 
 	ports {
 		port@0 {
-			endpoint {
+			du_out_rgb: endpoint {
 				remote-endpoint = <&adv7123_in>;
 			};
 		};
@@ -396,6 +414,50 @@
 	clock-frequency = <32768>;
 };
 
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+		port@2 {
+			reg = <2>;
+			dw_hdmi0_snd_in: endpoint {
+				remote-endpoint = <&rsnd_endpoint1>;
+			};
+		};
+	};
+};
+
+#ifdef SOC_HAS_HDMI1
+&hdmi1 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			rcar_dw_hdmi1_out: endpoint {
+				remote-endpoint = <&hdmi1_con>;
+			};
+		};
+		port@2 {
+			reg = <2>;
+			dw_hdmi1_snd_in: endpoint {
+				remote-endpoint = <&rsnd_endpoint2>;
+			};
+		};
+	};
+};
+
+&hdmi1_con {
+	remote-endpoint = <&rcar_dw_hdmi1_out>;
+};
+#endif /* SOC_HAS_HDMI1 */
+
 &hscif1 {
 	pinctrl-0 = <&hscif1_pins>;
 	pinctrl-names = "default";
@@ -469,47 +531,49 @@
 		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
 			    "infoframe", "cbus", "cec", "sdp", "txa", "txb" ;
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		interrupt-parent = <&gpio6>;
 		interrupt-names = "intrq1", "intrq2";
 		interrupts = <30 IRQ_TYPE_LEVEL_LOW>,
 			     <31 IRQ_TYPE_LEVEL_LOW>;
 
-		port@7 {
-			reg = <7>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
 
-			adv7482_ain7: endpoint {
-				remote-endpoint = <&cvbs_con>;
+				adv7482_ain7: endpoint {
+					remote-endpoint = <&cvbs_con>;
+				};
 			};
-		};
 
-		port@8 {
-			reg = <8>;
+			port@8 {
+				reg = <8>;
 
-			adv7482_hdmi: endpoint {
-				remote-endpoint = <&hdmi_in_con>;
+				adv7482_hdmi: endpoint {
+					remote-endpoint = <&hdmi_in_con>;
+				};
 			};
-		};
 
-		port@a {
-			reg = <10>;
+			port@a {
+				reg = <10>;
 
-			adv7482_txa: endpoint {
-				clock-lanes = <0>;
-				data-lanes = <1 2 3 4>;
-				remote-endpoint = <&csi40_in>;
+				adv7482_txa: endpoint {
+					clock-lanes = <0>;
+					data-lanes = <1 2 3 4>;
+					remote-endpoint = <&csi40_in>;
+				};
 			};
-		};
 
-		port@b {
-			reg = <11>;
+			port@b {
+				reg = <11>;
 
-			adv7482_txb: endpoint {
-				clock-lanes = <0>;
-				data-lanes = <1>;
-				remote-endpoint = <&csi20_in>;
+				adv7482_txb: endpoint {
+					clock-lanes = <0>;
+					data-lanes = <1>;
+					remote-endpoint = <&csi20_in>;
+				};
 			};
 		};
 	};
@@ -732,12 +796,9 @@
 };
 
 &rcar_sound {
-	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-0 = <&sound_pins>, <&sound_clk_pins>;
 	pinctrl-names = "default";
 
-	/* Single DAI */
-	#sound-dai-cells = <0>;
-
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
 	clock-frequency = <12288000 11289600>;
@@ -775,8 +836,85 @@
 				bitclock-master = <&rsnd_endpoint0>;
 				frame-master = <&rsnd_endpoint0>;
 
-				playback = <&ssi0 &src0 &dvc0>;
-				capture  = <&ssi1 &src1 &dvc1>;
+				playback = <&ssi0>, <&src0>, <&dvc0>;
+				capture = <&ssi1>, <&src1>, <&dvc1>;
+			};
+		};
+
+		rsnd_port1: port@1 {
+			reg = <1>;
+			rsnd_endpoint1: endpoint {
+				remote-endpoint = <&dw_hdmi0_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint1>;
+				frame-master = <&rsnd_endpoint1>;
+
+				playback = <&ssi2>;
+			};
+		};
+
+#ifdef SOC_HAS_HDMI1
+		rsnd_port2: port@2 {
+			reg = <2>;
+			rsnd_endpoint2: endpoint {
+				remote-endpoint = <&dw_hdmi1_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint2>;
+				frame-master = <&rsnd_endpoint2>;
+
+				playback = <&ssi3>;
+			};
+		};
+#endif /* SOC_HAS_HDMI1 */
+	};
+};
+
+&rpc {
+	/* Left disabled.  To be enabled by firmware when unlocked. */
+
+	flash@0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootparam@0 {
+				reg = <0x00000000 0x040000>;
+				read-only;
+			};
+			bl2@40000 {
+				reg = <0x00040000 0x140000>;
+				read-only;
+			};
+			cert_header_sa6@180000 {
+				reg = <0x00180000 0x040000>;
+				read-only;
+			};
+			bl31@1c0000 {
+				reg = <0x001c0000 0x040000>;
+				read-only;
+			};
+			tee@200000 {
+				reg = <0x00200000 0x440000>;
+				read-only;
+			};
+			uboot@640000 {
+				reg = <0x00640000 0x100000>;
+				read-only;
+			};
+			dtb@740000 {
+				reg = <0x00740000 0x080000>;
+			};
+			kernel@7c0000 {
+				reg = <0x007c0000 0x1400000>;
+			};
+			user@1bc0000 {
+				reg = <0x01bc0000 0x2440000>;
 			};
 		};
 	};
@@ -787,6 +925,12 @@
 	status = "okay";
 };
 
+#ifdef SOC_HAS_SATA
+&sata {
+	status = "okay";
+};
+#endif /* SOC_HAS_SATA */
+
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
@@ -833,8 +977,11 @@
 	bus-width = <8>;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
 	non-removable;
 	fixed-emmc-driver-type = <1>;
+	full-pwr-cycle-in-suspend;
 	status = "okay";
 };
 
@@ -931,3 +1078,27 @@
 
 	status = "okay";
 };
+
+#ifdef SOC_HAS_USB2_CH2
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&pfc {
+	usb2_pins: usb2 {
+		groups = "usb2";
+		function = "usb2";
+	};
+};
+
+&usb2_phy2 {
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif /* SOC_HAS_USB2_CH2 */
diff --git a/arch/arm/dts/salvator-xs.dtsi b/arch/arm/dts/salvator-xs.dtsi
index 717d42758cb..08b925624e1 100644
--- a/arch/arm/dts/salvator-xs.dtsi
+++ b/arch/arm/dts/salvator-xs.dtsi
@@ -27,3 +27,59 @@
 		clock-names = "xin";
 	};
 };
+
+#ifdef SOC_HAS_SATA
+&pca9654 {
+	pcie-sata-switch-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-low; /* enable SATA by default */
+		line-name = "PCIE/SATA switch";
+	};
+};
+
+/* SW12-7 must be set 'Off' (MD12 set to 1) which is not the default! */
+#endif /* SOC_HAS_SATA */
+
+#ifdef SOC_HAS_USB2_CH3
+&ehci3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&hsusb3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ohci3 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&pfc {
+	/*
+	 * - On Salvator-X[S], GP6_3[01] are connected to ADV7482 as irq pins
+	 *   (when SW31 is the default setting on Salvator-XS).
+	 * - If SW31 is the default setting, you cannot use USB2.0 ch3 on
+	 *   r8a77951 with Salvator-XS.
+	 *   Hence the SW31 setting must be changed like 2) below.
+	 *   1) Default setting of SW31: ON-ON-OFF-OFF-OFF-OFF:
+	 *	- Connect GP6_3[01] to ADV7842.
+	 *   2) Changed setting of SW31: OFF-OFF-ON-ON-ON-ON:
+	 *	- Connect GP6_3[01] to BD082065 (USB2.0 ch3's host power).
+	 *	- Connect GP6_{04,21} to ADV7842.
+	 */
+	usb2_ch3_pins: usb2_ch3 {
+		groups = "usb2_ch3";
+		function = "usb2_ch3";
+	};
+};
+
+&usb2_phy3 {
+	pinctrl-0 = <&usb2_ch3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif /* SOC_HAS_USB2_CH3 */
diff --git a/arch/arm/dts/ulcb-audio-graph-card.dtsi b/arch/arm/dts/ulcb-audio-graph-card.dtsi
new file mode 100644
index 00000000000..3be54df645e
--- /dev/null
+++ b/arch/arm/dts/ulcb-audio-graph-card.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree for ULCB + Audio Graph Card
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/*
+ *	(A) CPU0 <-----> ak4613
+ *	(B) CPU1  -----> HDMI
+ *
+ *	(A) aplay   -D plughw:0,0 xxx.wav
+ *	(B) aplay   -D plughw:0,1 xxx.wav
+ *
+ *	(A) arecord -D plughw:0,0 xxx.wav
+ */
+
+/ {
+	sound_card: sound {
+		compatible = "audio-graph-card";
+		label = "rcar-sound";
+
+		dais = <&rsnd_port0 /* (A) CPU0 <-> ak4613 */
+			&rsnd_port1 /* (B) CPU1  -> HDMI   */
+		>;
+	};
+};
+
+&ak4613 {
+	#sound-dai-cells = <0>;
+
+	port {
+		/*
+		 * (A) CPU0 <-> ak4613
+		 */
+		ak4613_endpoint: endpoint {
+			remote-endpoint = <&rsnd_for_ak4613>;
+		};
+	};
+};
+
+&hdmi0 {
+	ports {
+		port@2 {
+			/*
+			 * (B) CPU1 -> HDMI
+			 */
+			dw_hdmi0_snd_in: endpoint {
+				remote-endpoint = <&rsnd_for_hdmi>;
+			};
+		};
+	};
+};
+
+&rcar_sound {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		rsnd_port0: port@0 {
+			/*
+			 * (A) CPU0 <-> ak4613
+			 */
+			reg = <0>;
+			rsnd_for_ak4613: endpoint {
+				remote-endpoint = <&ak4613_endpoint>;
+				bitclock-master;
+				frame-master;
+				playback = <&ssi0>, <&src0>, <&dvc0>;
+				capture  = <&ssi1>, <&src1>, <&dvc1>;
+			};
+		};
+		rsnd_port1: port@1 {
+			/*
+			 * (B) CPU1 -> HDMI
+			 */
+			reg = <1>;
+			rsnd_for_hdmi: endpoint {
+				remote-endpoint = <&dw_hdmi0_snd_in>;
+				bitclock-master;
+				frame-master;
+				playback = <&ssi2>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/ulcb-audio-graph-card2.dtsi b/arch/arm/dts/ulcb-audio-graph-card2.dtsi
new file mode 100644
index 00000000000..5ebec123584
--- /dev/null
+++ b/arch/arm/dts/ulcb-audio-graph-card2.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree for ULCB + Audio Graph Card2
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/*
+ *	(A) CPU0 <----> ak4613
+ *	(B) CPU1  ----> HDMI
+ *
+ *	(A) aplay   -D plughw:0,0 xxx.wav
+ *	(B) aplay   -D plughw:0,1 xxx.wav
+ *
+ *	(A) arecord -D plughw:0,0 xxx.wav
+ */
+#include "ulcb-audio-graph-card.dtsi"
+
+&sound_card {
+	compatible = "audio-graph-card2";
+
+	/delete-property/ dais;
+	links = <&rsnd_port0	/* (A) CPU0 <-> ak4613 */
+		 &rsnd_port1	/* (B) CPU1  -> HDMI   */
+		>;
+};
diff --git a/arch/arm/dts/ulcb.dtsi b/arch/arm/dts/ulcb.dtsi
index 29cedf4dc1a..0be2716659e 100644
--- a/arch/arm/dts/ulcb.dtsi
+++ b/arch/arm/dts/ulcb.dtsi
@@ -6,14 +6,6 @@
  * Copyright (C) 2016 Cogent Embedded, Inc.
  */
 
-/*
- * SSI-AK4613
- *	aplay   -D plughw:0,0 xxx.wav
- *	arecord -D plughw:0,0 xxx.wav
- * SSI-HDMI
- *	aplay   -D plughw:0,1 xxx.wav
- */
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
@@ -102,15 +94,6 @@
 		regulator-always-on;
 	};
 
-	sound_card: sound {
-		compatible = "audio-graph-card2";
-		label = "rcar-sound";
-
-		links = <&rsnd_port0	/* ak4613 */
-			 &rsnd_port1	/* HDMI0  */
-			>;
-	};
-
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -201,9 +184,6 @@
 		};
 		port@2 {
 			reg = <2>;
-			dw_hdmi0_snd_in: endpoint {
-				remote-endpoint = <&rsnd_for_hdmi>;
-			};
 		};
 	};
 };
@@ -218,7 +198,6 @@
 
 	ak4613: codec@10 {
 		compatible = "asahi-kasei,ak4613";
-		#sound-dai-cells = <0>;
 		reg = <0x10>;
 		clocks = <&rcar_sound 3>;
 
@@ -230,12 +209,6 @@
 		asahi-kasei,out4-single-end;
 		asahi-kasei,out5-single-end;
 		asahi-kasei,out6-single-end;
-
-		port {
-			ak4613_endpoint: endpoint {
-				remote-endpoint = <&rsnd_for_ak4613>;
-			};
-		};
 	};
 
 	cs2000: clk-multiplier@4f {
@@ -294,6 +267,12 @@
 			};
 		};
 	};
+
+	eeprom@50 {
+		compatible = "rohm,br24t01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
 };
 
 &ohci1 {
@@ -381,9 +360,6 @@
 	pinctrl-0 = <&sound_pins>, <&sound_clk_pins>;
 	pinctrl-names = "default";
 
-	/* Single DAI */
-	#sound-dai-cells = <0>;
-
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
 	clock-frequency = <12288000 11289600>;
@@ -408,30 +384,6 @@
 		 <&audio_clk_a>, <&cs2000>,
 		 <&audio_clk_c>,
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		rsnd_port0: port@0 {
-			reg = <0>;
-			rsnd_for_ak4613: endpoint {
-				remote-endpoint = <&ak4613_endpoint>;
-				bitclock-master;
-				frame-master;
-				playback = <&ssi0>, <&src0>, <&dvc0>;
-				capture = <&ssi1>, <&src1>, <&dvc1>;
-			};
-		};
-		rsnd_port1: port@1 {
-			reg = <1>;
-			rsnd_for_hdmi: endpoint {
-				remote-endpoint = <&dw_hdmi0_snd_in>;
-				bitclock-master;
-				frame-master;
-				playback = <&ssi2>;
-			};
-		};
-	};
 };
 
 &rpc {
@@ -541,3 +493,17 @@
 
 	status = "okay";
 };
+
+
+/*
+ * For sound-test.
+ *
+ * We can switch Audio Card for testing
+ *
+ * #include "ulcb-simple-audio-card.dtsi"
+ * #include "ulcb-simple-audio-card-mix+split.dtsi"
+ * #include "ulcb-audio-graph-card.dtsi"
+ * #include "ulcb-audio-graph-card-mix+split.dtsi"
+ * #include "ulcb-audio-graph-card2-mix+split.dtsi"
+ */
+#include "ulcb-audio-graph-card2.dtsi"
-- 
2.40.1

