Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFEDCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C3E86AC0;
	Sun, 17 Sep 2023 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WeRgz9Gs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Iiygpfxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE0A86B3A; Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BEB86308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVKL2MG7z9sm6
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nebvPkij02BF2AaZlbxcYgxee3kC8tUz0clRH4vko0k=;
 b=WeRgz9GsBeM/iocHK5mM2TzM1nCG6dXOGq498oUuRBeDlzQ+JS94OSQ3ol/IHEgZCDdWQ0
 SWVm5EH60JQ/AlyZr9Q02mbxpkn4KpTs2w8l7vqW7+Y3K5JibsvpsgH18kqLlobjroYh/1
 VjwxM/eOqvhx9TiKaDv59dOJSTImAlcO90WSCaxvCFFyRqAlrA4x8wBHKVCzisADNh5YTy
 L4ARZzm+/bJ6Gi7V0NO0mrJow6o8rHDxYTa3xNJc63vicD/q7ja3s3o79J895A5zh/WE5u
 qIx6Qr8igy5x2SmmpVEHqPT2JNiEbDBIkb6cVrXiUNil1NefpiwnVv7zuON/AQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nebvPkij02BF2AaZlbxcYgxee3kC8tUz0clRH4vko0k=;
 b=IiygpfxtaFeBUXpWH44Cj/IhRkh92/O1fw8VYqHwqsRcMRu9/TipF0juFc8bQiRl5eNsDR
 ZYO6SxBq5NZcMBvdhScrJpRgWiQbnY8L2LS48O3K9hBlnbaVdGB3Q5mBBub7KAXvneqEBp
 TMI+/o+OjRwTU2jdejhSr2JgcliDbS3FROnT8IJpL0OZZ2uklAZnBmxT7nSOuKJo8pu14Q
 mkCXDsm2MrIC1eAeWyMIin6AAdPgG3hlZgudy6HjON9XtUO7+VUxMVhoZWM/CBZfTaPMyU
 exqnVAyMFeTII9bSzNetzohM9Cy3Ca4TaHmKlkU+Z6Ki7g5TGgAiO0AGidS1Ig==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/19] ARM: dts: renesas: Synchronize R-Car R8A779A0 E3 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:11 +0200
Message-Id: <20230917141319.379939-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 69ae199a76c0db872fa
X-MBO-RS-META: btxh8zkktztwqwisft1hkgwc5m94u43o
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

Synchronize R-Car R8A779A0 E3 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi |   5 +
 arch/arm/dts/r8a779a0-falcon.dts          |  11 ++-
 arch/arm/dts/r8a779a0.dtsi                | 110 ++++++++++++++++------
 3 files changed, 95 insertions(+), 31 deletions(-)

diff --git a/arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi b/arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi
index e06b8eda85e..dbc8dcab109 100644
--- a/arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi
+++ b/arch/arm/dts/r8a779a0-falcon-csi-dsi.dtsi
@@ -5,6 +5,8 @@
  * Copyright (C) 2021 Glider bv
  */
 
+#include <dt-bindings/media/video-interfaces.h>
+
 &csi40 {
 	status = "okay";
 
@@ -105,6 +107,7 @@
 			port@4 {
 				reg = <4>;
 				max96712_out0: endpoint {
+					bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
 					clock-lanes = <0>;
 					data-lanes = <1 2 3 4>;
 					remote-endpoint = <&csi40_in>;
@@ -125,6 +128,7 @@
 			port@4 {
 				reg = <4>;
 				max96712_out1: endpoint {
+					bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
 					clock-lanes = <0>;
 					data-lanes = <1 2 3 4>;
 					lane-polarities = <0 0 0 0 1>;
@@ -146,6 +150,7 @@
 			port@4 {
 				reg = <4>;
 				max96712_out2: endpoint {
+					bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
 					clock-lanes = <0>;
 					data-lanes = <1 2 3 4>;
 					lane-polarities = <0 0 0 0 1>;
diff --git a/arch/arm/dts/r8a779a0-falcon.dts b/arch/arm/dts/r8a779a0-falcon.dts
index b2e67b82caf..63db822e5f4 100644
--- a/arch/arm/dts/r8a779a0-falcon.dts
+++ b/arch/arm/dts/r8a779a0-falcon.dts
@@ -37,8 +37,12 @@
 	};
 };
 
+&can_clk {
+	clock-frequency = <40000000>;
+};
+
 &canfd {
-	pinctrl-0 = <&canfd0_pins>, <&canfd1_pins>;
+	pinctrl-0 = <&canfd0_pins>, <&canfd1_pins>, <&can_clk_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 
@@ -80,6 +84,11 @@
 
 	};
 
+	can_clk_pins: can-clk {
+		groups = "can_clk";
+		function = "can_clk";
+	};
+
 	canfd0_pins: canfd0 {
 		groups = "canfd0_data";
 		function = "canfd0";
diff --git a/arch/arm/dts/r8a779a0.dtsi b/arch/arm/dts/r8a779a0.dtsi
index ed9400f903c..4e67a035649 100644
--- a/arch/arm/dts/r8a779a0.dtsi
+++ b/arch/arm/dts/r8a779a0.dtsi
@@ -606,7 +606,8 @@
 		};
 
 		canfd: can@e6660000 {
-			compatible = "renesas,r8a779a0-canfd";
+			compatible = "renesas,r8a779a0-canfd",
+				     "renesas,rcar-gen4-canfd";
 			reg = <0 0xe6660000 0 0x8000>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
@@ -656,7 +657,7 @@
 
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6800000 0 0x800>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
@@ -704,7 +705,7 @@
 
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6810000 0 0x800>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
@@ -752,7 +753,7 @@
 
 		avb2: ethernet@e6820000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6820000 0 0x1000>;
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
@@ -800,7 +801,7 @@
 
 		avb3: ethernet@e6830000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6830000 0 0x1000>;
 			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
@@ -848,7 +849,7 @@
 
 		avb4: ethernet@e6840000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6840000 0 0x1000>;
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
@@ -896,7 +897,7 @@
 
 		avb5: ethernet@e6850000 {
 			compatible = "renesas,etheravb-r8a779a0",
-				     "renesas,etheravb-rcar-gen3";
+				     "renesas,etheravb-rcar-gen4";
 			reg = <0 0xe6850000 0 0x1000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
@@ -942,6 +943,56 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm@e6e30000 {
+			compatible = "renesas,pwm-r8a779a0", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@e6e31000 {
+			compatible = "renesas,pwm-r8a779a0", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@e6e32000 {
+			compatible = "renesas,pwm-r8a779a0", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@e6e33000 {
+			compatible = "renesas,pwm-r8a779a0", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@e6e34000 {
+			compatible = "renesas,pwm-r8a779a0", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
 		scif0: serial@e6e60000 {
 			compatible = "renesas,scif-r8a779a0",
 				     "renesas,rcar-gen4-scif", "renesas,scif";
@@ -1019,7 +1070,7 @@
 
 		msiof0: spi@e6e90000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
 			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 618>;
@@ -1034,7 +1085,7 @@
 
 		msiof1: spi@e6ea0000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 619>;
@@ -1049,7 +1100,7 @@
 
 		msiof2: spi@e6c00000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
@@ -1064,7 +1115,7 @@
 
 		msiof3: spi@e6c10000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
 			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
@@ -1079,7 +1130,7 @@
 
 		msiof4: spi@e6c20000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
@@ -1094,7 +1145,7 @@
 
 		msiof5: spi@e6c28000 {
 			compatible = "renesas,msiof-r8a779a0",
-				     "renesas,rcar-gen3-msiof";
+				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
 			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
@@ -2097,7 +2148,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xee480000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2106,7 +2157,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xee4c0000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 19>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2115,7 +2166,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeed00000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2124,7 +2175,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeed40000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2133,7 +2184,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeed80000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_A3IR>;
 			#iommu-cells = <1>;
 		};
@@ -2142,7 +2193,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeedc0000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2151,7 +2202,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeee80000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2160,7 +2211,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeeec0000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 15>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2169,7 +2220,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeee00000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2178,7 +2229,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeef00000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 5>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2187,7 +2238,7 @@
 			compatible = "renesas,ipmmu-r8a779a0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeef40000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 11>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -2209,8 +2260,7 @@
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fcpvd0: fcp@fea10000 {
@@ -2857,9 +2907,9 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
-- 
2.40.1

