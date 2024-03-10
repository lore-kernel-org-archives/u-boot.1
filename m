Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB4C54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 16:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2410787DD3;
	Sun, 10 Mar 2024 17:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKt3nUSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610D0877FB; Sun, 10 Mar 2024 17:59:15 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08531878E2
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 17:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3662feb90a8so14311925ab.3
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710089951; x=1710694751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vw0NLTn8Ke2ogu1WFHqkHHQD3CYpzfv8pgJasqn/ydo=;
 b=NKt3nUSpzOSfInqZOtO893xYYFIck3sS+X9xi/3vRcSrUF5fuMykzzqLq7Rz8KtzHn
 hTgUg+l4eQcabduGXNrApLB9vfg/17XYwTSATAmVmZRCNtj+1itLQ8Ym6uAZzk5Dmc62
 oZJBBvpRL/X6mZcj0k4X5HpiP3hx25gVdJLzhDCjPAcNf26vPWJQEDynsOFiBTY1eD3V
 HIogTbEsrZnIDcNAZeWXtYDapLE6HuIQy/Rg6io67toK0FM6XER6xylNvgYydZta+gGR
 85vaPTPan3VJa8ZWufAseq27HzhOio/vuIuj4vhL4qzHXMIiHEFoOiVKnPSBeL1OoyQ9
 6E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710089951; x=1710694751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vw0NLTn8Ke2ogu1WFHqkHHQD3CYpzfv8pgJasqn/ydo=;
 b=TZb5k/IU09qTKhSphX4pfkAmszduCJo0V1Tad3eG7Hzhw7hBKFgKQmiBUN7psuSQVK
 jcE4CpE8OUnMyy7fpQJL+JMx+SfL0HT+q/AeR2OMXBZKn820YLIx6yx01ryxyRO2bPAn
 tsIPG6jj3FlNMm+EvL+8XTA5wu/JTX6Mb2SExqiQKR1GoLu6OxwBBffc1n2BSwK/CHd2
 IudyzXI5aBJijbrihk3GvgyFOfIrUngLiTwtUc6/04Rgn6slpZQ++WTBffN6pjfTCeKB
 3PBk30Jl7OUNdoMOYLJ5jZJCJOsG7z32HoB9ignMmvs3RJiUzCaf7ymtKHmwSSkeXS1Y
 j0iQ==
X-Gm-Message-State: AOJu0Yx0of2jI6jMEQHXhddkntsk7A9TfA4lSa/Brqzgw07vvs7r8ovD
 RpUKhPgw8wUNQT0NHuGrjZvjFiVpuwzJErlToseYbaAExowlP+JiIXnqO8KUQN1loQ==
X-Google-Smtp-Source: AGHT+IGwsFr1WDO/Xbvhk+Sz8LN8ZtZy4Hj7jBblECVHEAHqvNmkOeQIYYkXBLGnoTiuIuSfX992SQ==
X-Received: by 2002:a05:6e02:b24:b0:365:c5c:dfa7 with SMTP id
 e4-20020a056e020b2400b003650c5cdfa7mr6069907ilu.1.1710089951090; 
 Sun, 10 Mar 2024 09:59:11 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:54cb:3195:1984:ea90])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a92c147000000b0036528f00c44sm673438ilh.61.2024.03.10.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 09:59:10 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH] arm: dts: imx8mp-beacon-kit:  Resync DTS with Linux 6.8
Date: Sun, 10 Mar 2024 11:59:01 -0500
Message-ID: <20240310165903.69275-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The device tree has evolved over time, so re-sync.  This also
partial reverts one change on the PCIe, because U-Boot doesn't
have a proper driver.  However, since the clock is configured
to generate a 100MHz reference clock by default, a proper driver
isn't really necessary.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
index 393fd8ec2e..ed183f83a7 100644
--- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
@@ -6,6 +6,13 @@
 #include "imx8mp-u-boot.dtsi"
 
 / {
+	/* U-Boot does not yet have a proper PCIe clk driver */
+	pcie0_refclk: clock-pcie {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog1>;
@@ -13,6 +20,10 @@
 	};
 };
 
+&pcie_phy {
+	clocks = <&pcie0_refclk>;
+};
+
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-beacon-kit.dts b/arch/arm/dts/imx8mp-beacon-kit.dts
index cdae45a48c..a08057410b 100644
--- a/arch/arm/dts/imx8mp-beacon-kit.dts
+++ b/arch/arm/dts/imx8mp-beacon-kit.dts
@@ -23,6 +23,12 @@
 		stdout-path = &uart2;
 	};
 
+	clk_xtal25: clock-xtal25 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
 	connector {
 		compatible = "usb-c-connector";
 		label = "USB-C";
@@ -49,6 +55,12 @@
 		};
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -82,6 +94,17 @@
 		};
 	};
 
+	bridge-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -112,10 +135,13 @@
 		};
 	};
 
-	pcie0_refclk: clock-pcie {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
+	reg_audio: regulator-wm8962 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_aud";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	reg_usdhc2_vmmc: regulator-usdhc2 {
@@ -137,6 +163,68 @@
 		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	sound-adv7535 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-adv7535";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai5>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&adv_bridge>;
+		};
+	};
+
+	sound-dmic {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-pdm";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+
+		dailink_master: simple-audio-card,cpu {
+			sound-dai = <&micfil>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&dmic_codec>;
+		};
+	};
+
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+			frame-master;
+			bitclock-master;
+		};
+	};
+};
+
+&audio_blk_ctrl {
+	assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>, <&clk IMX8MP_AUDIO_PLL2>;
+	assigned-clock-rates = <393216000>, <135475200>;
 };
 
 &ecspi2 {
@@ -146,7 +234,7 @@
 	status = "okay";
 
 	tpm: tpm@0 {
-		compatible = "infineon,slb9670";
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		reg = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tpm>;
@@ -211,6 +299,42 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	adv_bridge: hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
+		reg-names = "main", "cec", "edid", "packet";
+		adi,dsi-lanes = <4>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
+	pcieclk: clock-generator@68 {
+		compatible = "renesas,9fgv0241";
+		reg = <0x68>;
+		clocks = <&clk_xtal25>;
+		#clock-cells = <1>;
+	};
 };
 
 &i2c3 {
@@ -239,6 +363,34 @@
 	clock-frequency = <384000>;
 	status = "okay";
 
+	wm8962: audio-codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wm8962>;
+		clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+		assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+		assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
+		assigned-clock-rates = <22576000>;
+		DCVDD-supply = <&reg_audio>;
+		DBVDD-supply = <&reg_audio>;
+		AVDD-supply = <&reg_audio>;
+		CPVDD-supply = <&reg_audio>;
+		MICVDD-supply = <&reg_audio>;
+		PLLVDD-supply = <&reg_audio>;
+		SPKVDD1-supply = <&reg_audio>;
+		SPKVDD2-supply = <&reg_audio>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+		#sound-dai-cells = <0>;
+	};
+
 	pca6416: gpio@20 {
 		compatible = "nxp,pcal6416";
 		reg = <0x20>;
@@ -301,6 +453,34 @@
 	};
 };
 
+&lcdif1 {
+	status = "okay";
+};
+
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MP_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			dsi_out: endpoint {
+				remote-endpoint = <&adv7535_in>;
+			};
+		};
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
@@ -309,12 +489,34 @@
 };
 
 &pcie_phy {
+	fsl,clkreq-unsupported;
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
+	clocks = <&pcieclk 1>;
 	clock-names = "ref";
 	status = "okay";
 };
 
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
+			  <&clk IMX8MP_AUDIO_PLL2> ;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	assigned-clock-rates = <12288000>, <361267200>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai5>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI5>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -471,12 +673,37 @@
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK		0xd6
+			MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00	0xd6
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+		>;
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI5_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC	0xd6
+		>;
+	};
+
 	pinctrl_tpm: tpmgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19 /* Reset */
@@ -547,4 +774,10 @@
 			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
 		>;
 	};
+
+	pinctrl_wm8962: wm8962grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1	0x59
+		>;
+	};
 };
diff --git a/arch/arm/dts/imx8mp-beacon-som.dtsi b/arch/arm/dts/imx8mp-beacon-som.dtsi
index e5da908047..8be251b693 100644
--- a/arch/arm/dts/imx8mp-beacon-som.dtsi
+++ b/arch/arm/dts/imx8mp-beacon-som.dtsi
@@ -50,6 +50,8 @@
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	snps,force_thresh_dma_mode;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
 	status = "okay";
 
 	mdio {
@@ -66,6 +68,71 @@
 			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+			snps,map-to-dma-channel = <0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+			snps,map-to-dma-channel = <1>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+			snps,map-to-dma-channel = <2>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+			snps,map-to-dma-channel = <3>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+			snps,map-to-dma-channel = <4>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
 };
 
 &flexspi {
@@ -206,6 +273,10 @@
 	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
 	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8997-bt";
+	};
 };
 
 &usdhc1 {
-- 
2.43.0

