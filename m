Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB8C41513
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A163C86FF8;
	Thu, 19 Oct 2023 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8lF2Bpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CFE86FEA; Thu, 19 Oct 2023 14:07:06 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D246E86FC0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6c6591642f2so1812236a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697717222; x=1698322022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2Y5p/Ld4S8GErvEUP7UOMuTKwZP4WiZrSR8dZkLLZE=;
 b=g8lF2BpkLYr2BKOlgNPqldtx7lFNq41ECwJ9Pkq6RBgOlArz/0wcsI1DcJl2clJwyX
 ULKa0t0iwFHSEcO7Zxh6m2GPq6bJruhkKzm0TMk8sbl/IAQ5sNV+nfyzDfTEFJPZ42EF
 ORSpyqKfMxPCsyxK9OPLgKe4Hu0hNO4YqK+/6XW9uB0VvZyteIotfGJVrxUqPGP06CPZ
 pgmO9wP5LyXiXqB127xR6X1PMT66QJ6GZ2/0q8NGMKMd2BiKrSTFCTNBLtnJOKOgurLF
 eqSOWgrkoFnC8vwO7TqmFi4RMV0uRjZ0wSwUjTqJ3uxzCqHMNpEVTCMlLDb5gtcjj/x3
 26Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717222; x=1698322022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2Y5p/Ld4S8GErvEUP7UOMuTKwZP4WiZrSR8dZkLLZE=;
 b=mU3tdHNQNQuyDK2yWrPNqCygYuXzWVreEHUv1+Pu5ldoX6hqiffX+nwCcIX5bzNYBJ
 v7VouYS1EQEp1IKQbkvsBBckbyoS1E11NcdYzHgwgJG8aN5sg4bLsf/C0ULugu9i/Tl3
 e76ve5cFqZdsxH93halMLQabsJb1k3jw0NH97jERrLY+N1lKl6UpfPncQ60IeuhIIedG
 Ip0qE3KKV0EELMp6E8aX09PMBiZTak8JRTEGUhD+6WhTpm9u3RYKe78t3buONwtp5JFL
 lKXUXyuVsnNV2KpA8YaqtNh9Ngu75hxBdv4mNNmGIFurchLkQL+b6bJCY5Nlr8it0oDp
 U8Mg==
X-Gm-Message-State: AOJu0YwP5nA2X85hkLMlI5OlY2YtSFFGpbEBZEDZjXx2V7WWAxKjGkxb
 rM2augG4+M0wXx+7sn54uSU=
X-Google-Smtp-Source: AGHT+IGUCx/8GFHOtfq81OgY2Gf9sLS+9l7buOSXXqqqvXiGJLREOnanS5c0H/9vFPgu0vgas2z99w==
X-Received: by 2002:a05:6359:3902:b0:168:a332:e1f2 with SMTP id
 xa2-20020a056359390200b00168a332e1f2mr1634535rwb.1.1697717222243; 
 Thu, 19 Oct 2023 05:07:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a056a00134b00b0068620bee456sm4975154pfu.209.2023.10.19.05.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:07:01 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/3] arm: dts: imx8mn: Sync with linux-next 20231019
Date: Thu, 19 Oct 2023 09:06:22 -0300
Message-Id: <20231019120623.1476421-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120623.1476421-1-festevam@gmail.com>
References: <20231019120623.1476421-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Sync imx8mn.dtsi with linux-next 20231019.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Rebased against latest U-Boot and synced with linux-next 20231019

 arch/arm/dts/imx8mn.dtsi | 167 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 154 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/imx8mn.dtsi b/arch/arm/dts/imx8mn.dtsi
index cb2836bfbd95..1bb1d0c1bae4 100644
--- a/arch/arm/dts/imx8mn.dtsi
+++ b/arch/arm/dts/imx8mn.dtsi
@@ -139,6 +139,7 @@
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
@@ -295,6 +296,7 @@
 				sai2: sai@30020000 {
 					compatible = "fsl,imx8mn-sai", "fsl,imx8mq-sai";
 					reg = <0x30020000 0x10000>;
+					#sound-dai-cells = <0>;
 					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clk IMX8MN_CLK_SAI2_IPG>,
 						<&clk IMX8MN_CLK_DUMMY>,
@@ -309,6 +311,7 @@
 				sai3: sai@30030000 {
 					compatible = "fsl,imx8mn-sai", "fsl,imx8mq-sai";
 					reg = <0x30030000 0x10000>;
+					#sound-dai-cells = <0>;
 					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clk IMX8MN_CLK_SAI3_IPG>,
 						 <&clk IMX8MN_CLK_DUMMY>,
@@ -323,6 +326,7 @@
 				sai5: sai@30050000 {
 					compatible = "fsl,imx8mn-sai", "fsl,imx8mq-sai";
 					reg = <0x30050000 0x10000>;
+					#sound-dai-cells = <0>;
 					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clk IMX8MN_CLK_SAI5_IPG>,
 						 <&clk IMX8MN_CLK_DUMMY>,
@@ -339,6 +343,7 @@
 				sai6: sai@30060000 {
 					compatible = "fsl,imx8mn-sai", "fsl,imx8mq-sai";
 					reg = <0x30060000  0x10000>;
+					#sound-dai-cells = <0>;
 					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clk IMX8MN_CLK_SAI6_IPG>,
 						 <&clk IMX8MN_CLK_DUMMY>,
@@ -366,6 +371,7 @@
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
@@ -396,6 +402,7 @@
 				sai7: sai@300b0000 {
 					compatible = "fsl,imx8mn-sai", "fsl,imx8mq-sai";
 					reg = <0x300b0000 0x10000>;
+					#sound-dai-cells = <0>;
 					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clk IMX8MN_CLK_SAI7_IPG>,
 						 <&clk IMX8MN_CLK_DUMMY>,
@@ -497,6 +504,8 @@
 				compatible = "fsl,imx8mn-tmu", "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MN_CLK_TMU_ROOT>;
+				nvmem-cells = <&tmu_calib>;
+				nvmem-cell-names = "calib";
 				#thermal-sensor-cells = <0>;
 			};
 
@@ -551,7 +560,7 @@
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
+			gpr: syscon@30340000 {
 				compatible = "fsl,imx8mn-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
@@ -563,23 +572,40 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mn_uid: unique-id@410 {
+				/*
+				 * The register address below maps to the MX8M
+				 * Fusemap Description Table entries this way.
+				 * Assuming
+				 *   reg = <ADDR SIZE>;
+				 * then
+				 *   Fuse Address = (ADDR * 4) + 0x400
+				 * Note that if SIZE is greater than 4, then
+				 * each subsequent fuse is located at offset
+				 * +0x10 in Fusemap Description Table (e.g.
+				 * reg = <0x4 0x8> describes fuses 0x410 and
+				 * 0x420).
+				 */
+				imx8mn_uid: unique-id@4 { /* 0x410-0x420 */
 					reg = <0x4 0x8>;
 				};
 
-				cpu_speed_grade: speed-grade@10 {
+				cpu_speed_grade: speed-grade@10 { /* 0x440 */
 					reg = <0x10 4>;
 				};
 
-				fec_mac_address: mac-address@90 {
+				tmu_calib: calib@3c { /* 0x4f0 */
+					reg = <0x3c 4>;
+				};
+
+				fec_mac_address: mac-address@90 { /* 0x640 */
 					reg = <0x90 6>;
 				};
 			};
 
-			anatop: anatop@30360000 {
-				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop",
-					     "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
@@ -662,7 +688,6 @@
 					pgc_otg1: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
-						power-domains = <&pgc_hsiomix>;
 					};
 
 					pgc_gpumix: power-domain@2 {
@@ -1038,6 +1063,72 @@
 			#size-cells = <1>;
 			ranges;
 
+			lcdif: lcdif@32e00000 {
+				compatible = "fsl,imx8mn-lcdif", "fsl,imx6sx-lcdif";
+				reg = <0x32e00000 0x10000>;
+				clocks = <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_LCDIF>;
+				status = "disabled";
+
+				port {
+					lcdif_to_dsim: endpoint {
+						remote-endpoint = <&dsim_from_lcdif>;
+					};
+				};
+			};
+
+			mipi_dsi: dsi@32e10000 {
+				compatible = "fsl,imx8mn-mipi-dsim", "fsl,imx8mm-mipi-dsim";
+				reg = <0x32e10000 0x400>;
+				clocks = <&clk IMX8MN_CLK_DSI_CORE>,
+					 <&clk IMX8MN_CLK_DSI_PHY_REF>;
+				clock-names = "bus_clk", "sclk_mipi";
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_DSI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dsim_from_lcdif: endpoint {
+							remote-endpoint = <&lcdif_to_dsim>;
+						};
+					};
+				};
+			};
+
+			isi: isi@32e20000 {
+				compatible = "fsl,imx8mn-isi";
+				reg = <0x32e20000 0x8000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+				clock-names = "axi", "apb";
+				fsl,blk-ctrl = <&disp_blk_ctrl>;
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_ISI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						isi_in: endpoint {
+							remote-endpoint = <&mipi_csi_out>;
+						};
+					};
+				};
+			};
+
 			disp_blk_ctrl: blk-ctrl@32e28000 {
 				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
 				reg = <0x32e28000 0x100>;
@@ -1063,11 +1154,60 @@
 					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
 					      "dsi-pclk", "dsi-ref",
 					      "csi-aclk", "csi-pclk";
+				assigned-clocks = <&clk IMX8MN_CLK_DSI_CORE>,
+						  <&clk IMX8MN_CLK_DSI_PHY_REF>,
+						  <&clk IMX8MN_CLK_DISP_PIXEL>,
+						  <&clk IMX8MN_CLK_DISP_AXI>,
+						  <&clk IMX8MN_CLK_DISP_APB>;
+				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_266M>,
+							 <&clk IMX8MN_CLK_24M>,
+							 <&clk IMX8MN_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MN_SYS_PLL2_1000M>,
+							 <&clk IMX8MN_SYS_PLL1_800M>;
+				assigned-clock-rates = <266000000>,
+						       <24000000>,
+						       <594000000>,
+						       <500000000>,
+						       <200000000>;
 				#power-domain-cells = <1>;
 			};
 
+			mipi_csi: mipi-csi@32e30000 {
+				compatible = "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e30000 0x1000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				assigned-clocks = <&clk IMX8MN_CLK_CAMERA_PIXEL>;
+				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>;
+				assigned-clock-rates = <333000000>;
+				clock-frequency = <333000000>;
+				clocks = <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_CAMERA_PIXEL>,
+					 <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
+				clock-names = "pclk", "wrap", "phy", "axi";
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_CSI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_csi_out: endpoint {
+							remote-endpoint = <&isi_in>;
+						};
+					};
+				};
+			};
+
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
@@ -1076,12 +1216,13 @@
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
-				power-domains = <&pgc_otg1>;
+				power-domains = <&pgc_hsiomix>;
 				status = "disabled";
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
@@ -1094,7 +1235,6 @@
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			clocks = <&clk IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK>;
@@ -1103,7 +1243,7 @@
 		gpmi: nand-controller@33002000 {
 			compatible = "fsl,imx8mn-gpmi-nand", "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -1175,5 +1315,6 @@
 		assigned-clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
 		assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_100M>;
 		clock-names = "main_clk";
+		power-domains = <&pgc_otg1>;
 	};
 };
-- 
2.34.1

