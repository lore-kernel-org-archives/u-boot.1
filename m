Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A6FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D75688F3C;
	Thu, 25 Apr 2024 14:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rYwyC7Lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43F388F38; Thu, 25 Apr 2024 14:21:16 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36C188F1D
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3BACECE194B;
 Thu, 25 Apr 2024 12:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A74C113CC;
 Thu, 25 Apr 2024 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714047668;
 bh=9ltGk0u2jSAR98wZk9hOjKty4vFwg3FiRFh3M1UzJ30=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rYwyC7Lw8h+thwqfsJdndEqlSDXKkol5ggHUsjzf0lM5/r8kqpwSQh6mkpx0uY7ZC
 7vBH26M0lgSvvt1dQZv+Go2zQyWrpCESIi3eb0SXL7JRZY1VRZhLwXMWhIAOXg++Tt
 FyH6KciSAKrMZFlM9bIGNvWx2ThL9pkNFsHrSHIW4em2irVxS02+bryuuF35/qqWBs
 bmytD2QjhdZzV0CB+Mk5F5Js1pMdC0xxjpUrX+6/pEXMMkjVByM35+75glCeaptlvI
 g3p3iJE325+GJ4wYrbKjDnaII+dBfOYhJPPNaDlVLGcjrZ64G93tteQGVWBKCQTy3l
 KIyFw9ZoSd/6g==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 25 Apr 2024 15:20:52 +0300
Subject: [PATCH 1/3] arm: dts: k3-am62*: sync with Linux v6.9-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-for-2024-07-beagleplay-eth-v1-1-6c985de1c316@kernel.org>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
In-Reply-To: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=42164; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=9ltGk0u2jSAR98wZk9hOjKty4vFwg3FiRFh3M1UzJ30=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmKkqsT4Anl4L2RCAA7j+ygXoAj1jyd4rWxX+Kw
 NDjMUR4sDCJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZipKrAAKCRDSWmvTvnYw
 k3eDEAClE3VL3kwbeCw44bQgAeH3BCI05I4osxex6126Z76H/uipn1m0E/pwBPhiz+4KhWWXwzN
 LtL/ddC+lcUvje8+6fjIoNc2PugcRHVDV9jdncWQ1bPjsx9nRIjQ+kwQurtxapNcmRUIShDQZFM
 /5hK1lt1B1Npe+ftqcL/l367i29Ow5VtvRLonFKwh+ZVd56r5YcDsRglqO740/Eht13W9Q3lGYh
 ps7lKIF20P33ZgCiRfrKQpRgnfjdmH7T47X7Iux5KbU+AbWFoHJHUPeKOycB8aIYUNmWwRTVoP6
 OxVGjH4cyZOsuIpNM9Lu9ZGgPpmQ9wmraCxERrSYX1f/kjz6XiYbmNckw14+5d8OfA+3v7JTeAo
 Mg35tb1T5E2QCvDUTREvO1W61Nps2F83WrHc8XL4JacFpzQgf2WqdDfMcV1CWAVSJsbn9zAdvNl
 vLwmHmCLZdzSY6YsMGaGqIUe8EAruEfJESVokN5Z8CzEp2NqHwDxFLz4pxti14C17FCM+fScc4f
 h0RXTrMtlcjBYI0gWEQ1qHaArccItqmBwcd04urh2anuw7uwJMdP/NLV6DFOD5+JsLq87BsXcfC
 vKbxU+Swh0M9ynwr6xjv2ox3/lsGSVbZkQw3I5e5Gog417fnpUZxhNUhLUzSdk9+5Nz8wXj6l5a
 Z3DS99BhvTZ9tog==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Update k3-am62 DT files from Linux v6.9-rc5

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am62-main.dtsi              | 126 ++++++++++++++---
 arch/arm/dts/k3-am62-mcu.dtsi               |   4 +-
 arch/arm/dts/k3-am62-phycore-som.dtsi       |   5 +-
 arch/arm/dts/k3-am62-thermal.dtsi           |   5 +-
 arch/arm/dts/k3-am62-wakeup.dtsi            |  38 ++++--
 arch/arm/dts/k3-am62.dtsi                   |   4 +-
 arch/arm/dts/k3-am625-beagleplay.dts        |  58 ++++----
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts | 104 +++++++++++++-
 arch/arm/dts/k3-am625-sk.dts                |   4 +-
 arch/arm/dts/k3-am625.dtsi                  |   4 +-
 arch/arm/dts/k3-am62a-main.dtsi             | 201 ++++++++++++++++++++++++++--
 arch/arm/dts/k3-am62a-mcu.dtsi              |   4 +-
 arch/arm/dts/k3-am62a-thermal.dtsi          |   5 +-
 arch/arm/dts/k3-am62a-wakeup.dtsi           |   4 +-
 arch/arm/dts/k3-am62a.dtsi                  |   4 +-
 arch/arm/dts/k3-am62a7-sk.dts               | 162 +++++++++++++++++++++-
 arch/arm/dts/k3-am62a7.dtsi                 |   4 +-
 arch/arm/dts/k3-am62x-sk-common.dtsi        |  24 +++-
 18 files changed, 653 insertions(+), 107 deletions(-)

diff --git a/arch/arm/dts/k3-am62-main.dtsi b/arch/arm/dts/k3-am62-main.dtsi
index e5c64c86d1d..e9cffca073e 100644
--- a/arch/arm/dts/k3-am62-main.dtsi
+++ b/arch/arm/dts/k3-am62-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family Main Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_main {
@@ -42,9 +42,8 @@
 		};
 	};
 
-	main_conf: syscon@100000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x00100000 0x00 0x20000>;
+	main_conf: bus@100000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x00100000 0x20000>;
@@ -121,8 +120,13 @@
 			      <0x00 0x4c000000 0x00 0x20000>,
 			      <0x00 0x4a820000 0x00 0x20000>,
 			      <0x00 0x4aa40000 0x00 0x20000>,
-			      <0x00 0x4bc00000 0x00 0x100000>;
-			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4bc00000 0x00 0x100000>,
+			      <0x00 0x48600000 0x00 0x8000>,
+			      <0x00 0x484a4000 0x00 0x2000>,
+			      <0x00 0x484c2000 0x00 0x2000>,
+			      <0x00 0x48420000 0x00 0x2000>;
+			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "bchan";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <3>;
 
@@ -138,8 +142,13 @@
 			reg = <0x00 0x485c0000 0x00 0x100>,
 			      <0x00 0x4a800000 0x00 0x20000>,
 			      <0x00 0x4aa00000 0x00 0x40000>,
-			      <0x00 0x4b800000 0x00 0x400000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4b800000 0x00 0x400000>,
+			      <0x00 0x485e0000 0x00 0x10000>,
+			      <0x00 0x484a0000 0x00 0x2000>,
+			      <0x00 0x484c0000 0x00 0x2000>,
+			      <0x00 0x48430000 0x00 0x1000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <2>;
 
@@ -502,6 +511,9 @@
 	main_gpio0: gpio@600000 {
 		compatible = "ti,am64-gpio", "ti,keystone-gpio";
 		reg = <0x0 0x00600000 0x0 0x100>;
+		gpio-ranges = <&main_pmx0  0  0 32>,
+			      <&main_pmx0 32 33 38>,
+			      <&main_pmx0 70 72 22>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
@@ -520,6 +532,10 @@
 		compatible = "ti,am64-gpio", "ti,keystone-gpio";
 		reg = <0x0 0x00601000 0x0 0x100>;
 		gpio-controller;
+		gpio-ranges = <&main_pmx0  0  94 41>,
+			      <&main_pmx0 41 136  6>,
+			      <&main_pmx0 47 143  3>,
+			      <&main_pmx0 50 149  2>;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
 		interrupts = <180>, <181>, <182>,
@@ -542,10 +558,9 @@
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 6>;
 		assigned-clock-parents = <&k3_clks 57 8>;
+		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		ti,trm-icp = <0x2>;
-		bus-width = <8>;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
@@ -563,7 +578,8 @@
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
@@ -575,8 +591,6 @@
 		ti,itap-del-sel-sd-hs = <0x1>;
 		ti,itap-del-sel-sdr12 = <0xa>;
 		ti,itap-del-sel-sdr25 = <0x1>;
-		ti,clkbuf-sel = <0x7>;
-		bus-width = <4>;
 		status = "disabled";
 	};
 
@@ -587,7 +601,8 @@
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x8>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0x0>;
@@ -599,7 +614,6 @@
 		ti,itap-del-sel-sd-hs = <0xa>;
 		ti,itap-del-sel-sdr12 = <0xa>;
 		ti,itap-del-sel-sdr25 = <0x1>;
-		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
 
@@ -623,6 +637,8 @@
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -646,6 +662,8 @@
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -675,6 +693,15 @@
 		};
 	};
 
+	gpu: gpu@fd00000 {
+		compatible = "ti,am62-gpu", "img,img-axe";
+		reg = <0x00 0x0fd00000 0x00 0x20000>;
+		clocks = <&k3_clks 187 0>;
+		clock-names = "core";
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	cpsw3g: ethernet@8000000 {
 		compatible = "ti,am642-cpsw-nuss";
 		#address-cells = <2>;
@@ -753,9 +780,10 @@
 		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
 		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
 		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
-		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			    "ovr1", "ovr2", "vp1", "vp2";
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
 		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 186 6>,
 			 <&dss_vp1_clk>,
@@ -965,4 +993,66 @@
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	ti_csi2rx0: ticsi2rx@30102000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma 0 0x4700 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x30102000 0x00 0x1000>;
+		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@30101000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30101000 0x00 0x1000>;
+			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
+				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy0>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi0_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi0_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi0_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi0_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi0_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@30110000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30110000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 };
diff --git a/arch/arm/dts/k3-am62-mcu.dtsi b/arch/arm/dts/k3-am62-mcu.dtsi
index 0e0b234581c..e66d486ef1f 100644
--- a/arch/arm/dts/k3-am62-mcu.dtsi
+++ b/arch/arm/dts/k3-am62-mcu.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family MCU Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu {
diff --git a/arch/arm/dts/k3-am62-phycore-som.dtsi b/arch/arm/dts/k3-am62-phycore-som.dtsi
index aa43e7407ee..43488cc8bcb 100644
--- a/arch/arm/dts/k3-am62-phycore-som.dtsi
+++ b/arch/arm/dts/k3-am62-phycore-som.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
@@ -317,7 +317,6 @@
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	non-removable;
 	status = "okay";
diff --git a/arch/arm/dts/k3-am62-thermal.dtsi b/arch/arm/dts/k3-am62-thermal.dtsi
index a358757e26f..12ba833002a 100644
--- a/arch/arm/dts/k3-am62-thermal.dtsi
+++ b/arch/arm/dts/k3-am62-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm/dts/k3-am62-wakeup.dtsi b/arch/arm/dts/k3-am62-wakeup.dtsi
index fef76f52a52..23ce1bfda8d 100644
--- a/arch/arm/dts/k3-am62-wakeup.dtsi
+++ b/arch/arm/dts/k3-am62-wakeup.dtsi
@@ -1,10 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family Wakeup Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
+
 &cbass_wakeup {
 	wkup_conf: syscon@43000000 {
 		bootph-all;
@@ -21,14 +23,34 @@
 		};
 	};
 
-	wkup_uart0: serial@2b300000 {
-		compatible = "ti,am64-uart", "ti,am654-uart";
-		reg = <0x00 0x2b300000 0x00 0x100>;
-		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+	target-module@2b300050 {
+		compatible = "ti,sysc-omap2", "ti,sysc";
+		reg = <0x00 0x2b300050 0x00 0x4>,
+		      <0x00 0x2b300054 0x00 0x4>,
+		      <0x00 0x2b300058 0x00 0x4>;
+		reg-names = "rev", "sysc", "syss";
+		ti,sysc-mask = <(SYSC_OMAP2_ENAWAKEUP |
+				 SYSC_OMAP2_SOFTRESET |
+				 SYSC_OMAP2_AUTOIDLE)>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		ti,syss-mask = <1>;
+		ti,no-reset-on-init;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
-		clock-names = "fclk";
-		status = "disabled";
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x2b300000 0x100000>;
+
+		wkup_uart0: serial@0 {
+			compatible = "ti,am64-uart", "ti,am654-uart";
+			reg = <0x0 0x100>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 
 	wkup_i2c0: i2c@2b200000 {
diff --git a/arch/arm/dts/k3-am62.dtsi b/arch/arm/dts/k3-am62.dtsi
index f1e15206e1c..f0781f2bea2 100644
--- a/arch/arm/dts/k3-am62.dtsi
+++ b/arch/arm/dts/k3-am62.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62 SoC Family
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/dts/k3-am625-beagleplay.dts b/arch/arm/dts/k3-am625-beagleplay.dts
index 9a6bd0a3c94..a34e0df2ab8 100644
--- a/arch/arm/dts/k3-am625-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-beagleplay.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * https://beagleplay.org/
  *
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Robert Nelson, BeagleBoard.org Foundation
  */
 
 /dts-v1/;
@@ -29,7 +29,6 @@
 		i2c3 = &main_i2c3;
 		i2c4 = &wkup_i2c0;
 		i2c5 = &mcu_i2c0;
-		mdio-gpio0 = &mdio0;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		mmc2 = &sdhci2;
@@ -231,27 +230,6 @@
 		};
 	};
 
-	/* Workaround for errata i2329 - just use mdio bitbang */
-	mdio0: mdio {
-		compatible = "virtual,mdio-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mdio0_pins_default>;
-		gpios = <&main_gpio0 86 GPIO_ACTIVE_HIGH>, /* MDC */
-			<&main_gpio0 85 GPIO_ACTIVE_HIGH>; /* MDIO */
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpsw3g_phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-
-		cpsw3g_phy1: ethernet-phy@1 {
-			reg = <1>;
-			reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <25>;
-			reset-deassert-us = <60000>; /* T2 */
-		};
-	};
 };
 
 &main_pmx0 {
@@ -312,8 +290,8 @@
 
 	mdio0_pins_default: mdio0-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0160, PIN_OUTPUT, 7) /* (AD24) MDIO0_MDC.GPIO0_86 */
-			AM62X_IOPAD(0x015c, PIN_INPUT, 7) /* (AB22) MDIO0_MDIO.GPIO0_85 */
+			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
+			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
 		>;
 	};
 
@@ -443,7 +421,7 @@
 		>;
 	};
 
-	console_pins_default: console-default-pins {
+	main_uart0_pins_default: main-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
@@ -573,11 +551,13 @@
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 	status = "okay";
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "peripheral";
 };
 
@@ -611,8 +591,20 @@
 };
 
 &cpsw3g_mdio {
-	/* Workaround for errata i2329 - Use mdio bitbang */
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		reset-gpios = <&main_gpio1 5 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <25>;
+		reset-deassert-us = <60000>; /* T2 */
+	};
 };
 
 &main_gpio0 {
@@ -827,7 +819,6 @@
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	status = "okay";
 };
@@ -840,7 +831,6 @@
 
 	vmmc-supply = <&vdd_3v3_sd>;
 	vqmmc-supply = <&vdd_sd_dv>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
 	cd-debounce-delay-ms = <100>;
@@ -852,12 +842,10 @@
 	vmmc-supply = <&wlan_en>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
-	bus-width = <4>;
 	non-removable;
 	ti,fails-without-test-cd;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	ti,driver-strength-ohm = <50>;
 	assigned-clocks = <&k3_clks 157 158>;
 	assigned-clock-parents = <&k3_clks 157 160>;
 	#address-cells = <1>;
@@ -877,7 +865,7 @@
 &main_uart0 {
 	bootph-all;
 	pinctrl-names = "default";
-	pinctrl-0 = <&console_pins_default>;
+	pinctrl-0 = <&main_uart0_pins_default>;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts b/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
index a438baf542c..a83a9049785 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
@@ -35,6 +35,18 @@
 		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -93,6 +105,37 @@
 		>;
 	};
 
+	hdmi_int_pins_default: hdmi-int-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
+		>;
+	};
+
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
@@ -179,15 +222,36 @@
 	cpsw3g_phy3: ethernet-phy@3 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
 		reg = <3>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 };
 
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP2: DPI/HDMI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 	status = "okay";
 
 	gpio_exp: gpio-expander@21 {
@@ -201,12 +265,43 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		gpio-line-names = "GPIO0_HDMI_RST", "GPIO1_CAN0_nEN",
+		gpio-line-names = "", "GPIO1_CAN0_nEN",
 				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
 				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
 				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
 	};
 
+	sii9022: bridge-hdmi@39 {
+		compatible = "sil,sii9022";
+		reg = <0x39>;
+
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_int_pins_default>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
 	eeprom@51 {
 		compatible = "atmel,24c02";
 		pagesize = <16>;
@@ -239,7 +334,6 @@
 	vqmmc-supply = <&vddshv5_sdio>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 	no-1-8-v;
 	status = "okay";
diff --git a/arch/arm/dts/k3-am625-sk.dts b/arch/arm/dts/k3-am625-sk.dts
index b18092497c9..ae81ebb39d0 100644
--- a/arch/arm/dts/k3-am625-sk.dts
+++ b/arch/arm/dts/k3-am625-sk.dts
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * AM625 SK: https://www.ti.com/lit/zip/sprr448
  *
- * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/k3-am625.dtsi b/arch/arm/dts/k3-am625.dtsi
index 4193c2b3eed..4014add6320 100644
--- a/arch/arm/dts/k3-am625.dtsi
+++ b/arch/arm/dts/k3-am625.dtsi
@@ -1,10 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC family in Quad core configuration
  *
  * TRM: https://www.ti.com/lit/pdf/spruiv7
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/k3-am62a-main.dtsi b/arch/arm/dts/k3-am62a-main.dtsi
index 4ae7fdc5221..aa1e057082f 100644
--- a/arch/arm/dts/k3-am62a-main.dtsi
+++ b/arch/arm/dts/k3-am62a-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62A SoC Family Main Domain peripherals
  *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_main {
@@ -42,9 +42,8 @@
 		};
 	};
 
-	main_conf: syscon@100000 {
-		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-		reg = <0x00 0x00100000 0x00 0x20000>;
+	main_conf: bus@100000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x20000>;
@@ -101,8 +100,13 @@
 			      <0x00 0x4c000000 0x00 0x20000>,
 			      <0x00 0x4a820000 0x00 0x20000>,
 			      <0x00 0x4aa40000 0x00 0x20000>,
-			      <0x00 0x4bc00000 0x00 0x100000>;
-			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4bc00000 0x00 0x100000>,
+			      <0x00 0x48600000 0x00 0x8000>,
+			      <0x00 0x484a4000 0x00 0x2000>,
+			      <0x00 0x484c2000 0x00 0x2000>,
+			      <0x00 0x48420000 0x00 0x2000>;
+			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "bchan";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <3>;
 			ti,sci = <&dmsc>;
@@ -117,8 +121,13 @@
 			reg = <0x00 0x485c0000 0x00 0x100>,
 			      <0x00 0x4a800000 0x00 0x20000>,
 			      <0x00 0x4aa00000 0x00 0x40000>,
-			      <0x00 0x4b800000 0x00 0x400000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			      <0x00 0x4b800000 0x00 0x400000>,
+			      <0x00 0x485e0000 0x00 0x10000>,
+			      <0x00 0x484a0000 0x00 0x2000>,
+			      <0x00 0x484c0000 0x00 0x2000>,
+			      <0x00 0x48430000 0x00 0x1000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+				    "ring", "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_dmss>;
 			#dma-cells = <2>;
 			ti,sci = <&dmsc>;
@@ -144,6 +153,44 @@
 		};
 	};
 
+	dmss_csi: bus@4e000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ranges = <0x00 0x4e000000 0x00 0x4e000000 0x00 0x300000>;
+
+		ti,sci-dev-id = <198>;
+
+		inta_main_dmss_csi: interrupt-controller@4e0a0000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x4e0a0000 0x00 0x8000>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			msi-controller;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <200>;
+			ti,interrupt-ranges = <0 237 8>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		};
+
+		main_bcdma_csi: dma-controller@4e230000 {
+			compatible = "ti,am62a-dmss-bcdma-csirx";
+			reg = <0x00 0x4e230000 0x00 0x100>,
+			      <0x00 0x4e180000 0x00 0x8000>,
+			      <0x00 0x4e100000 0x00 0x10000>;
+			reg-names = "gcfg", "rchanrt", "ringrt";
+			msi-parent = <&inta_main_dmss_csi>;
+			#dma-cells = <3>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <199>;
+			ti,sci-rm-range-rchan = <0x21>;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		};
+	};
+
 	dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		reg = <0x00 0x44043000 0x00 0xfe0>;
@@ -462,7 +509,7 @@
 			     <193>, <194>, <195>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <87>;
+		ti,ngpio = <92>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 77 0>;
@@ -480,7 +527,7 @@
 			     <183>, <184>, <185>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <88>;
+		ti,ngpio = <52>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 78 0>;
@@ -488,6 +535,24 @@
 		status = "disabled";
 	};
 
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 57 6>;
+		assigned-clock-parents = <&k3_clks 57 8>;
+		bus-width = <8>;
+		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-hs200 = <0x6>;
+		status = "disabled";
+	};
+
 	sdhci1: mmc@fa00000 {
 		compatible = "ti,am62-sdhci";
 		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
@@ -495,7 +560,8 @@
 		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		ti,trm-icp = <0x2>;
+		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
@@ -507,8 +573,30 @@
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
-		ti,clkbuf-sel = <0x7>;
+		no-1-8-v;
+		status = "disabled";
+	};
+
+	sdhci2: mmc@fa20000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa20000 0x00 0x260>, <0x00 0xfa28000 0x00 0x134>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
+		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <4>;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		no-1-8-v;
 		status = "disabled";
 	};
@@ -876,4 +964,91 @@
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	ti_csi2rx0: ticsi2rx@30102000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma_csi 0 0x5000 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x30102000 0x00 0x1000>;
+		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@30101000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30101000 0x00 0x1000>;
+			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
+				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy0>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi0_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi0_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi0_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi0_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi0_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@30110000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30110000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dss: dss@30200000 {
+		compatible = "ti,am62a7-dss";
+		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30206000 0x00 0x1000>, /* vid */
+		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Tied OFF in the SoC */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
+		reg-names = "common", "vidl1", "vid",
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 186 6>,
+			 <&k3_clks 186 0>,
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
 };
diff --git a/arch/arm/dts/k3-am62a-mcu.dtsi b/arch/arm/dts/k3-am62a-mcu.dtsi
index a6d16a94088..8c36e56f413 100644
--- a/arch/arm/dts/k3-am62a-mcu.dtsi
+++ b/arch/arm/dts/k3-am62a-mcu.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family MCU Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu {
diff --git a/arch/arm/dts/k3-am62a-thermal.dtsi b/arch/arm/dts/k3-am62a-thermal.dtsi
index 85ce545633e..c7486fb2a5b 100644
--- a/arch/arm/dts/k3-am62a-thermal.dtsi
+++ b/arch/arm/dts/k3-am62a-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm/dts/k3-am62a-wakeup.dtsi b/arch/arm/dts/k3-am62a-wakeup.dtsi
index 4e8279fa01e..f7bec484705 100644
--- a/arch/arm/dts/k3-am62a-wakeup.dtsi
+++ b/arch/arm/dts/k3-am62a-wakeup.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62A SoC Family Wakeup Domain peripherals
  *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_wakeup {
diff --git a/arch/arm/dts/k3-am62a.dtsi b/arch/arm/dts/k3-am62a.dtsi
index 61a210ecd5f..b1b88460029 100644
--- a/arch/arm/dts/k3-am62a.dtsi
+++ b/arch/arm/dts/k3-am62a.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62A SoC Family
  *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/dts/k3-am62a7-sk.dts b/arch/arm/dts/k3-am62a7-sk.dts
index 8f64ac2c756..f241637a564 100644
--- a/arch/arm/dts/k3-am62a7-sk.dts
+++ b/arch/arm/dts/k3-am62a7-sk.dts
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * AM62A SK: https://www.ti.com/lit/zip/sprr459
  *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
@@ -20,6 +20,7 @@
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
+		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
 
@@ -132,6 +133,18 @@
 		clock-frequency = <12288000>;
 	};
 
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+
 	codec_audio: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM62Ax-SKEVM";
@@ -181,6 +194,39 @@
 };
 
 &main_pmx0 {
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x100, PIN_OUTPUT, 0) /* (V17) VOUT0_VSYNC */
+			AM62AX_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (T18) VOUT0_HSYNC */
+			AM62AX_IOPAD(0x104, PIN_OUTPUT, 0) /* (AA22) VOUT0_PCLK */
+			AM62AX_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (U17) VOUT0_DE */
+			AM62AX_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62AX_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (U21) VOUT0_DATA1 */
+			AM62AX_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (U20) VOUT0_DATA2 */
+			AM62AX_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (U19) VOUT0_DATA3 */
+			AM62AX_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (T19) VOUT0_DATA4 */
+			AM62AX_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (U18) VOUT0_DATA5 */
+			AM62AX_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (V22) VOUT0_DATA6 */
+			AM62AX_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA7 */
+			AM62AX_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V19) VOUT0_DATA8 */
+			AM62AX_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (V18) VOUT0_DATA9 */
+			AM62AX_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (W22) VOUT0_DATA10 */
+			AM62AX_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA11 */
+			AM62AX_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (W20) VOUT0_DATA12 */
+			AM62AX_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (W19) VOUT0_DATA13 */
+			AM62AX_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y21) VOUT0_DATA14 */
+			AM62AX_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA15 */
+			AM62AX_IOPAD(0x05c, PIN_OUTPUT, 1) /* (P22) GPMC0_AD8.VOUT0_DATA16 */
+			AM62AX_IOPAD(0x060, PIN_OUTPUT, 1) /* (R19) GPMC0_AD9.VOUT0_DATA17 */
+			AM62AX_IOPAD(0x064, PIN_OUTPUT, 1) /* (R20) GPMC0_AD10.VOUT0_DATA18 */
+			AM62AX_IOPAD(0x068, PIN_OUTPUT, 1) /* (R22) GPMC0_AD11.VOUT0_DATA19 */
+			AM62AX_IOPAD(0x06c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
+			AM62AX_IOPAD(0x070, PIN_OUTPUT, 1) /* (R21) GPMC0_AD13.VOUT0_DATA21 */
+			AM62AX_IOPAD(0x074, PIN_OUTPUT, 1) /* (T20) GPMC0_AD14.VOUT0_DATA22 */
+			AM62AX_IOPAD(0x078, PIN_OUTPUT, 1) /* (T21) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
@@ -218,6 +264,22 @@
 		>;
 	};
 
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62AX_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLKLB */
+			AM62AX_IOPAD(0x21c, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62AX_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
@@ -274,6 +336,12 @@
 			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AXR2 */
 		>;
 	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -407,6 +475,12 @@
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 
 		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
 				   "BT_EN_SOC", "MMC1_SD_EN",
@@ -434,6 +508,72 @@
 		DRVDD-supply = <&vcc_3v3_sys>;
 		DVDD-supply = <&buck5>;
 	};
+
+	exp2: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "", "",
+				  "", "",
+				  "", "",
+				  "", "",
+				  "WL_LT_EN", "CSI_RSTz",
+				  "", "",
+				  "", "",
+				  "", "",
+				  "SPI0_FET_SEL", "SPI0_FET_OE",
+				  "RGMII2_BRD_CONN_DET", "CSI_SEL2",
+				  "CSI_EN", "AUTO_100M_1000M_CONFIG",
+				  "CSI_VLDO_SEL", "SoC_WLAN_SDIO_RST";
+	};
+
+	sii9022: bridge-hdmi@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+		sil,i2s-data-lanes = < 0 >;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&sdhci0 {
+	/* eMMC */
+	status = "okay";
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	disable-wp;
 };
 
 &sdhci1 {
@@ -442,7 +582,6 @@
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
@@ -544,3 +683,20 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+};
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62a7.dtsi b/arch/arm/dts/k3-am62a7.dtsi
index 58f1c43edcf..f86a23404e6 100644
--- a/arch/arm/dts/k3-am62a7.dtsi
+++ b/arch/arm/dts/k3-am62a7.dtsi
@@ -1,10 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62A7 SoC family in Quad core configuration
  *
  * TRM: https://www.ti.com/lit/zip/spruj16
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/k3-am62x-sk-common.dtsi b/arch/arm/dts/k3-am62x-sk-common.dtsi
index 19f57ead4eb..3c45782ab2b 100644
--- a/arch/arm/dts/k3-am62x-sk-common.dtsi
+++ b/arch/arm/dts/k3-am62x-sk-common.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Common dtsi for AM62x SK and derivatives
  *
- * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/leds/common.h>
@@ -399,12 +399,18 @@
 	};
 };
 
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
@@ -414,7 +420,6 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
 
@@ -453,6 +458,7 @@
 };
 
 &usbss0 {
+	bootph-all;
 	status = "okay";
 	ti,vbus-divider;
 };
@@ -463,6 +469,7 @@
 };
 
 &usb0 {
+	bootph-all;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	usb-role-switch;
@@ -517,3 +524,12 @@
 		};
 	};
 };
+
+/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
+&mcu_gpio0 {
+	status = "reserved";
+};
+
+&mcu_gpio_intr {
+	status = "reserved";
+};

-- 
2.34.1

