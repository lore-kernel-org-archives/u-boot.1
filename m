Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F8FCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83FF86B35;
	Sun, 17 Sep 2023 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TT27pgW8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MMqqa0uS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7385686B05; Sun, 17 Sep 2023 16:14:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E03286B29
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVKM2Q2Sz9sWQ
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PI+uBc5lX5BVKKyWokrFKzjtO8dBHH/UsatNhOwbSY=;
 b=TT27pgW8d0xugdKKeRl9qUmqyKfLhhJU2iLTW4MWTMlS9nl6/naRPc6QNzvNTEgzMLusAQ
 QLinY/+2rErJCnUI3d6WF7dfRnZH+JtcCLhoblbfaEXZgKu5QbbKK7LTQd7SUuv/GCZK6w
 5NhtXTX8bhFDgr4kLlwZCqm9dywPJBLOagQ9y9CtC22YO7B0apgxOKg2z5pIEtVqrBfR1U
 nblaSYPIjySGNTjR2OdjwQK0+7Fl0tw6KS2VeX1QCDGHEG+WPtBBJVDbgBGeQT6C7E5nKM
 g4ecgdl+t+hHbPa8y/+b3WE6oUKTtwNB8DtQrAxfrjZF/TagITh3Xn6107RNBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PI+uBc5lX5BVKKyWokrFKzjtO8dBHH/UsatNhOwbSY=;
 b=MMqqa0uSwuV5qczXYjNfgRL1QF4mCCKIhIfaOmVWQPUbPAmvORkZmYeHZiSwX4xWFpUbCD
 owajECy/b5Vjxy8ZzK5dMooN0a9fRTxjbu/y4dvk10nsW9Qb1IpMh72ZRzH4MP39hnV6Q2
 LGSXxPvQt/b9frrY2WxYDpcV+8/VNMgrUrnu3qRTa4BBaD7RZH4o1I0MVt1zGamiPCRMaP
 WhOdqsB7HMTVL71eoxDl3oL77ENwvRZuPu/CikfXf6J+Bng0OmNKSABUOU97ExSf0Ptb9g
 FYWYu0fiREvpkCLVJYHsceaOoXULWm4b704CjdYjuCR1FIuvKviBIdfoSk01TQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/19] ARM: dts: renesas: Synchronize R-Car R8A779G0 V4H DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:13 +0200
Message-Id: <20230917141319.379939-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4536ec3d8ee68ef0ea2
X-MBO-RS-META: r7ecf47de5ay84wrpkbnyxptmg5xm7bw
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

Synchronize R-Car R8A779G0 V4H DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi |  172 +++
 arch/arm/dts/r8a779g0-white-hawk.dts          |   44 +
 arch/arm/dts/r8a779g0.dtsi                    | 1006 ++++++++++++++++-
 3 files changed, 1216 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi b/arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi
index ae7522b60e5..f8537f7ea4d 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-csi-dsi.dtsi
@@ -5,7 +5,63 @@
  * Copyright (C) 2022 Glider bv
  */
 
+#include <dt-bindings/media/video-interfaces.h>
+
+&csi40 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			csi40_in: endpoint {
+				bus-type = <MEDIA_BUS_TYPE_CSI2_CPHY>;
+				clock-lanes = <0>;
+				data-lanes = <1 2 3>;
+				remote-endpoint = <&max96712_out0>;
+			};
+		};
+	};
+};
+
+&csi41 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			csi41_in: endpoint {
+				bus-type = <MEDIA_BUS_TYPE_CSI2_CPHY>;
+				clock-lanes = <0>;
+				data-lanes = <1 2 3>;
+				remote-endpoint = <&max96712_out1>;
+			};
+		};
+	};
+};
+
 &i2c0 {
+	pca9654_a: gpio@21 {
+		compatible = "onnn,pca9654";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9654_b: gpio@22 {
+		compatible = "onnn,pca9654";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	eeprom@52 {
 		compatible = "rohm,br24g01", "atmel,24c01";
 		label = "csi-dsi-sub-board-id";
@@ -13,3 +69,119 @@
 		pagesize = <8>;
 	};
 };
+
+&i2c1 {
+	gmsl0: gmsl-deserializer@49 {
+		compatible = "maxim,max96712";
+		reg = <0x49>;
+		enable-gpios = <&pca9654_a 0 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@4 {
+				reg = <4>;
+				max96712_out0: endpoint {
+					bus-type = <MEDIA_BUS_TYPE_CSI2_CPHY>;
+					clock-lanes = <0>;
+					data-lanes = <1 2 3>;
+					remote-endpoint = <&csi40_in>;
+				};
+			};
+		};
+	};
+
+	gmsl1: gmsl-deserializer@4b {
+		compatible = "maxim,max96712";
+		reg = <0x4b>;
+		enable-gpios = <&pca9654_b 0 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@4 {
+				reg = <4>;
+				max96712_out1: endpoint {
+					bus-type = <MEDIA_BUS_TYPE_CSI2_CPHY>;
+					clock-lanes = <0>;
+					data-lanes = <1 2 3>;
+					remote-endpoint = <&csi41_in>;
+				};
+			};
+		};
+	};
+};
+
+&isp0 {
+	status = "okay";
+};
+
+&isp1 {
+	status = "okay";
+};
+
+&vin00 {
+	status = "okay";
+};
+
+&vin01 {
+	status = "okay";
+};
+
+&vin02 {
+	status = "okay";
+};
+
+&vin03 {
+	status = "okay";
+};
+
+&vin04 {
+	status = "okay";
+};
+
+&vin05 {
+	status = "okay";
+};
+
+&vin06 {
+	status = "okay";
+};
+
+&vin07 {
+	status = "okay";
+};
+
+&vin08 {
+	status = "okay";
+};
+
+&vin09 {
+	status = "okay";
+};
+
+&vin10 {
+	status = "okay";
+};
+
+&vin11 {
+	status = "okay";
+};
+
+&vin12 {
+	status = "okay";
+};
+
+&vin13 {
+	status = "okay";
+};
+
+&vin14 {
+	status = "okay";
+};
+
+&vin15 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/r8a779g0-white-hawk.dts b/arch/arm/dts/r8a779g0-white-hawk.dts
index 04a2b6b83e7..eff1ef6e2cc 100644
--- a/arch/arm/dts/r8a779g0-white-hawk.dts
+++ b/arch/arm/dts/r8a779g0-white-hawk.dts
@@ -13,6 +13,33 @@
 / {
 	model = "Renesas White Hawk CPU and Breakout boards based on r8a779g0";
 	compatible = "renesas,white-hawk-breakout", "renesas,white-hawk-cpu", "renesas,r8a779g0";
+
+	can_transceiver0: can-phy0 {
+		compatible = "nxp,tjr1443";
+		#phy-cells = <0>;
+		enable-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		max-bitrate = <5000000>;
+	};
+};
+
+&can_clk {
+	clock-frequency = <40000000>;
+};
+
+&canfd {
+	pinctrl-0 = <&canfd0_pins>, <&canfd1_pins>, <&can_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	channel0 {
+		status = "okay";
+		phys = <&can_transceiver0>;
+	};
+
+	channel1 {
+		status = "okay";
+	};
 };
 
 &i2c0 {
@@ -23,3 +50,20 @@
 		pagesize = <8>;
 	};
 };
+
+&pfc {
+	can_clk_pins: can-clk {
+		groups = "can_clk";
+		function = "can_clk";
+	};
+
+	canfd0_pins: canfd0 {
+		groups = "canfd0_data";
+		function = "canfd0";
+	};
+
+	canfd1_pins: canfd1 {
+		groups = "canfd1_data";
+		function = "canfd1";
+	};
+};
diff --git a/arch/arm/dts/r8a779g0.dtsi b/arch/arm/dts/r8a779g0.dtsi
index 7a87a5dc1b6..d3d25e077c5 100644
--- a/arch/arm/dts/r8a779g0.dtsi
+++ b/arch/arm/dts/r8a779g0.dtsi
@@ -14,6 +14,20 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	/* External Audio clock - to be overridden by boards that provide it */
+	audio_clkin: audio_clkin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -431,6 +445,18 @@
 			#power-domain-cells = <1>;
 		};
 
+		tsc: thermal@e6198000 {
+			compatible = "renesas,r8a779g0-thermal";
+			reg = <0 0xe6198000 0 0x200>,
+			      <0 0xe61a0000 0 0x200>,
+			      <0 0xe61a8000 0 0x200>,
+			      <0 0xe61b0000 0 0x200>;
+			clocks = <&cpg CPG_MOD 919>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		intc_ex: interrupt-controller@e61c0000 {
 			compatible = "renesas,intc-ex-r8a779g0", "renesas,irqc";
 			#interrupt-cells = <2>;
@@ -682,6 +708,56 @@
 			status = "disabled";
 		};
 
+		canfd: can@e6660000 {
+			compatible = "renesas,r8a779g0-canfd",
+				     "renesas,rcar-gen4-canfd";
+			reg = <0 0xe6660000 0 0x8500>;
+			interrupts = <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch_int", "g_int";
+			clocks = <&cpg CPG_MOD 328>,
+				 <&cpg CPG_CORE R8A779G0_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A779G0_CLK_CANFD>;
+			assigned-clock-rates = <80000000>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+
+			channel2 {
+				status = "disabled";
+			};
+
+			channel3 {
+				status = "disabled";
+			};
+
+			channel4 {
+				status = "disabled";
+			};
+
+			channel5 {
+				status = "disabled";
+			};
+
+			channel6 {
+				status = "disabled";
+			};
+
+			channel7 {
+				status = "disabled";
+			};
+		};
+
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
@@ -1098,6 +1174,454 @@
 			status = "disabled";
 		};
 
+		vin00: video@e6ef0000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 730>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 730>;
+			renesas,id = <0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin00isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin00>;
+					};
+				};
+			};
+		};
+
+		vin01: video@e6ef1000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 731>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 731>;
+			renesas,id = <1>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin01isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin01>;
+					};
+				};
+			};
+		};
+
+		vin02: video@e6ef2000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 800>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 800>;
+			renesas,id = <2>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin02isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin02>;
+					};
+				};
+			};
+		};
+
+		vin03: video@e6ef3000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 801>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 801>;
+			renesas,id = <3>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin03isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin03>;
+					};
+				};
+			};
+		};
+
+		vin04: video@e6ef4000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			renesas,id = <4>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin04isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin04>;
+					};
+				};
+			};
+		};
+
+		vin05: video@e6ef5000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 803>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 803>;
+			renesas,id = <5>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin05isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin05>;
+					};
+				};
+			};
+		};
+
+		vin06: video@e6ef6000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef6000 0 0x1000>;
+			interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 804>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 804>;
+			renesas,id = <6>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin06isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin06>;
+					};
+				};
+			};
+		};
+
+		vin07: video@e6ef7000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef7000 0 0x1000>;
+			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 805>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 805>;
+			renesas,id = <7>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin07isp0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&isp0vin07>;
+					};
+				};
+			};
+		};
+
+		vin08: video@e6ef8000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef8000 0 0x1000>;
+			interrupts = <GIC_SPI 537 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 806>;
+			renesas,id = <8>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin08isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin08>;
+					};
+				};
+			};
+		};
+
+		vin09: video@e6ef9000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6ef9000 0 0x1000>;
+			interrupts = <GIC_SPI 538 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <9>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin09isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin09>;
+					};
+				};
+			};
+		};
+
+		vin10: video@e6efa000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6efa000 0 0x1000>;
+			interrupts = <GIC_SPI 539 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 808>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 808>;
+			renesas,id = <10>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin10isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin10>;
+					};
+				};
+			};
+		};
+
+		vin11: video@e6efb000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6efb000 0 0x1000>;
+			interrupts = <GIC_SPI 540 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			renesas,id = <11>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin11isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin11>;
+					};
+				};
+			};
+		};
+
+		vin12: video@e6efc000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6efc000 0 0x1000>;
+			interrupts = <GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			renesas,id = <12>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin12isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin12>;
+					};
+				};
+			};
+		};
+
+		vin13: video@e6efd000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6efd000 0 0x1000>;
+			interrupts = <GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			renesas,id = <13>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin13isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin13>;
+					};
+				};
+			};
+		};
+
+		vin14: video@e6efe000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6efe000 0 0x1000>;
+			interrupts = <GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			renesas,id = <14>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin14isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin14>;
+					};
+				};
+			};
+		};
+
+		vin15: video@e6eff000 {
+			compatible = "renesas,vin-r8a779g0";
+			reg = <0 0xe6eff000 0 0x1000>;
+			interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 813>;
+			renesas,id = <15>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <2>;
+
+					vin15isp1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&isp1vin15>;
+					};
+				};
+			};
+		};
+
 		dmac0: dma-controller@e7350000 {
 			compatible = "renesas,dmac-r8a779g0",
 				     "renesas,rcar-gen4-dmac";
@@ -1131,6 +1655,14 @@
 			resets = <&cpg 709>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_ds0 0>, <&ipmmu_ds0 1>,
+				 <&ipmmu_ds0 2>, <&ipmmu_ds0 3>,
+				 <&ipmmu_ds0 4>, <&ipmmu_ds0 5>,
+				 <&ipmmu_ds0 6>, <&ipmmu_ds0 7>,
+				 <&ipmmu_ds0 8>, <&ipmmu_ds0 9>,
+				 <&ipmmu_ds0 10>, <&ipmmu_ds0 11>,
+				 <&ipmmu_ds0 12>, <&ipmmu_ds0 13>,
+				 <&ipmmu_ds0 14>, <&ipmmu_ds0 15>;
 		};
 
 		dmac1: dma-controller@e7351000 {
@@ -1166,6 +1698,192 @@
 			resets = <&cpg 710>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_ds0 16>, <&ipmmu_ds0 17>,
+				 <&ipmmu_ds0 18>, <&ipmmu_ds0 19>,
+				 <&ipmmu_ds0 20>, <&ipmmu_ds0 21>,
+				 <&ipmmu_ds0 22>, <&ipmmu_ds0 23>,
+				 <&ipmmu_ds0 24>, <&ipmmu_ds0 25>,
+				 <&ipmmu_ds0 26>, <&ipmmu_ds0 27>,
+				 <&ipmmu_ds0 28>, <&ipmmu_ds0 29>,
+				 <&ipmmu_ds0 30>, <&ipmmu_ds0 31>;
+		};
+
+		rcar_sound: sound@ec5a0000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
+			 */
+			/*
+			 * #clock-cells is required
+			 *
+			 * clkout		: #clock-cells = <0>;	<&rcar_sound>;
+			 * audio_clkout0/1/2/3	: #clock-cells = <1>;	<&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a779g0", "renesas,rcar_sound-gen4";
+			reg = <0 0xec5a0000 0 0x020>,
+			      <0 0xec540000 0 0x1000>,
+			      <0 0xec541000 0 0x050>,
+			      <0 0xec400000 0 0x40000>;
+			reg-names = "adg", "ssiu", "ssi", "sdmc";
+
+			clocks = <&cpg CPG_MOD 2926>, <&cpg CPG_MOD 2927>, <&audio_clkin>;
+			clock-names = "ssiu.0", "ssi.0", "clkin";
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2926>, <&cpg 2927>;
+			reset-names = "ssiu.0", "ssi.0";
+			status = "disabled";
+
+			rcar_sound,ssiu {
+				ssiu00: ssiu-0 {
+					dmas = <&dmac0 0x6e>, <&dmac0 0x6f>;
+					dma-names = "tx", "rx";
+				};
+				ssiu01: ssiu-1 {
+					dmas = <&dmac0 0x6c>, <&dmac0 0x6d>;
+					dma-names = "tx", "rx";
+				};
+				ssiu02: ssiu-2 {
+					dmas = <&dmac0 0x6a>, <&dmac0 0x6b>;
+					dma-names = "tx", "rx";
+				};
+				ssiu03: ssiu-3 {
+					dmas = <&dmac0 0x68>, <&dmac0 0x69>;
+					dma-names = "tx", "rx";
+				};
+				ssiu04: ssiu-4 {
+					dmas = <&dmac0 0x66>, <&dmac0 0x67>;
+					dma-names = "tx", "rx";
+				};
+				ssiu05: ssiu-5 {
+					dmas = <&dmac0 0x64>, <&dmac0 0x65>;
+					dma-names = "tx", "rx";
+				};
+				ssiu06: ssiu-6 {
+					dmas = <&dmac0 0x62>, <&dmac0 0x63>;
+					dma-names = "tx", "rx";
+				};
+				ssiu07: ssiu-7 {
+					dmas = <&dmac0 0x60>, <&dmac0 0x61>;
+					dma-names = "tx", "rx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
+
+		ipmmu_rt0: iommu@ee480000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xee480000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_rt1: iommu@ee4c0000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xee4c0000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ds0: iommu@eed00000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeed00000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_hc: iommu@eed40000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeed40000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ir: iommu@eed80000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeed80000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_A3IR>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc: iommu@eedc0000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeedc0000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_3dg: iommu@eee00000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeee00000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: iommu@eee80000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeee80000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi1: iommu@eeec0000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeeec0000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vip0: iommu@eef00000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeef00000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vip1: iommu@eef40000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeef40000 0 0x20000>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: iommu@eefc0000 {
+			compatible = "renesas,ipmmu-r8a779g0",
+				     "renesas,rcar-gen4-ipmmu-vmsa";
+			reg = <0 0xeefc0000 0 0x20000>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
 		};
 
 		mmc0: mmc@ee140000 {
@@ -1179,6 +1897,7 @@
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
 			resets = <&cpg 706>;
 			max-frequency = <200000000>;
+			iommus = <&ipmmu_ds0 32>;
 			status = "disabled";
 		};
 
@@ -1205,8 +1924,59 @@
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		csi40: csi2@fe500000 {
+			compatible = "renesas,r8a779g0-csi2";
+			reg = <0 0xfe500000 0 0x40000>;
+			interrupts = <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+					csi40isp0: endpoint {
+						remote-endpoint = <&isp0csi40>;
+					};
+				};
+			};
+		};
+
+		csi41: csi2@fe540000 {
+			compatible = "renesas,r8a779g0-csi2";
+			reg = <0 0xfe540000 0 0x40000>;
+			interrupts = <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 400>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 400>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+					csi41isp1: endpoint {
+						remote-endpoint = <&isp1csi41>;
+					};
+				};
+			};
 		};
 
 		fcpvd0: fcp@fea10000 {
@@ -1281,6 +2051,172 @@
 			};
 		};
 
+		isp0: isp@fed00000 {
+			compatible = "renesas,r8a779g0-isp";
+			reg = <0 0xfed00000 0 0x10000>;
+			interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&cpg CPG_MOD 612>;
+			power-domains = <&sysc R8A779G0_PD_A3ISP0>;
+			resets = <&cpg 612>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <0>;
+
+					isp0csi40: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi40isp0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					isp0vin00: endpoint {
+						remote-endpoint = <&vin00isp0>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					isp0vin01: endpoint {
+						remote-endpoint = <&vin01isp0>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					isp0vin02: endpoint {
+						remote-endpoint = <&vin02isp0>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					isp0vin03: endpoint {
+						remote-endpoint = <&vin03isp0>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					isp0vin04: endpoint {
+						remote-endpoint = <&vin04isp0>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					isp0vin05: endpoint {
+						remote-endpoint = <&vin05isp0>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					isp0vin06: endpoint {
+						remote-endpoint = <&vin06isp0>;
+					};
+				};
+
+				port@8 {
+					reg = <8>;
+					isp0vin07: endpoint {
+						remote-endpoint = <&vin07isp0>;
+					};
+				};
+			};
+		};
+
+		isp1: isp@fed20000 {
+			compatible = "renesas,r8a779g0-isp";
+			reg = <0 0xfed20000 0 0x10000>;
+			interrupts = <GIC_SPI 474 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&cpg CPG_MOD 613>;
+			power-domains = <&sysc R8A779G0_PD_A3ISP1>;
+			resets = <&cpg 613>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <0>;
+
+					isp1csi41: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&csi41isp1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					isp1vin08: endpoint {
+						remote-endpoint = <&vin08isp1>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					isp1vin09: endpoint {
+						remote-endpoint = <&vin09isp1>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					isp1vin10: endpoint {
+						remote-endpoint = <&vin10isp1>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					isp1vin11: endpoint {
+						remote-endpoint = <&vin11isp1>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					isp1vin12: endpoint {
+						remote-endpoint = <&vin12isp1>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					isp1vin13: endpoint {
+						remote-endpoint = <&vin13isp1>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					isp1vin14: endpoint {
+						remote-endpoint = <&vin14isp1>;
+					};
+				};
+
+				port@8 {
+					reg = <8>;
+					isp1vin15: endpoint {
+						remote-endpoint = <&vin15isp1>;
+					};
+				};
+			};
+		};
+
 		dsi0: dsi-encoder@fed80000 {
 			compatible = "renesas,r8a779g0-dsi-csi2-tx";
 			reg = <0 0xfed80000 0 0x10000>;
@@ -1345,11 +2281,69 @@
 		};
 	};
 
+	thermal-zones {
+		sensor_thermal_cr52: sensor1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal_cnn: sensor2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 1>;
+
+			trips {
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal_ca76: sensor3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 2>;
+
+			trips {
+				sensor3_crit: sensor3-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal_ddr1: sensor4-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 3>;
+
+			trips {
+				sensor4_crit: sensor4-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
-- 
2.40.1

