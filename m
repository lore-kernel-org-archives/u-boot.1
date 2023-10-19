Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30184CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4564887003;
	Thu, 19 Oct 2023 14:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSvbG4dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ABF86FF8; Thu, 19 Oct 2023 14:07:03 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2D686FC0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c61dd1c229so1324514a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697717219; x=1698322019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1OcogkD4xWbQkrzPGCMCC482jrSEZH6umF49EcoUJFo=;
 b=cSvbG4dcdfqgl9SIwxF2oyfnXWu9n7PNa7BKEi/of6USMvWReSN6+7TSHgjR+zMSbq
 VcPNXDfUKnli/yUgr69L4/585CExqCUbE/TShsgY1nLGnMA5iLBLuvYvdLO2oipds1On
 v9sjjIPbqdv6MGsYoY17K986Ad4szRLAFZY5jlL2Etyd6OPEBMV0laFyvlU6qkCy7CwO
 BIM0117RsipWw10oB5HkNcnNWWrvZ8QkG7xhln8rTupYuDbLMlO7dO1wiO529mY+VpuJ
 yXoygBFY7hiuutkf1AIlWXuXKm8TAlkl3Vj3G348f9zat5rNT7NJww4RRUgCm4vMiX9I
 v94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717219; x=1698322019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OcogkD4xWbQkrzPGCMCC482jrSEZH6umF49EcoUJFo=;
 b=mge+dOQq9wzEITHE4RbIV4FViXGInWt1qxBsPH0Q4y5hBqNmmF0DiIQK1fUYIp1PgS
 bOaHXli+lMFUqcr0kz1q3BeMjjqHsukxilr0RmguyeRD8PbIPtmsTpwPiM2cmaNumy8B
 leBGuQvhmVLnO1bwqDCM1MCGVR5+Z9aWfzqbLCvahEjkyQr6FqLWi+RvNT+XQd2xTs1o
 lMBUZ5mhWclNaBJKD7TNGpJU0rz5G7+NLdJRXQrM2FTrPh4Oa9laZhN4AWEKzLfNBMO+
 KC19roNJOptJBtASc1xi/nXDTpf1FlJAWS3qcjItpo5s4SqHR+YdXa2CaQOQCTHoBABO
 r8iw==
X-Gm-Message-State: AOJu0YwzDlUgY1YdN+DG0TaQLGXbvk460X1KpbsmKISJTdWcrmDJzbSq
 pci3jvnnwcU/TCYLtvxvbmw=
X-Google-Smtp-Source: AGHT+IEWfmMPk6GH+jmlRv2tyXwYVZj7EzVC/t+u5f8HPmeHYjVOlNqATipeLLBu5eD85Dpqzlk9CA==
X-Received: by 2002:a05:6358:c610:b0:168:a3ad:b172 with SMTP id
 fd16-20020a056358c61000b00168a3adb172mr1147675rwb.2.1697717219350; 
 Thu, 19 Oct 2023 05:06:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a056a00134b00b0068620bee456sm4975154pfu.209.2023.10.19.05.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:06:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/3] arm: dts: imx8mm: Sync with linux-next 20231019
Date: Thu, 19 Oct 2023 09:06:21 -0300
Message-Id: <20231019120623.1476421-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Sync imx8mm.dtsi with linux-next 20231019.

The motivation for doing this sync was a bug when doing "ums 0 mmc 1"
on imx8mm-evk. It worked well for the first time, but after doing 
a CTRL+C and launching the ums again, the command did not work.

Adam Ford suggested to sync imx8mm.dtsi with the Linux dts, as there was
a recent USB power domain reorganization there.

After syncing the imx8mm.dtsi with Linux, the ums command works without
problem after a CTRL+C.

Suggested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Rebased against latest U-Boot and synced with linux-next 20231019.

 arch/arm/dts/imx8mm.dtsi | 153 +++++++++++++++++++++++++++++++++------
 1 file changed, 129 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/imx8mm.dtsi b/arch/arm/dts/imx8mm.dtsi
index afb90f59c83c..738024baaa57 100644
--- a/arch/arm/dts/imx8mm.dtsi
+++ b/arch/arm/dts/imx8mm.dtsi
@@ -139,6 +139,7 @@
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
@@ -276,6 +277,7 @@
 		assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
 		assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
 		clock-names = "main_clk";
+		power-domains = <&pgc_otg1>;
 	};
 
 	usbphynop2: usbphynop2 {
@@ -285,6 +287,7 @@
 		assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
 		assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
 		clock-names = "main_clk";
+		power-domains = <&pgc_otg2>;
 	};
 
 	soc: soc@0 {
@@ -396,6 +399,7 @@
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
@@ -493,6 +497,8 @@
 				compatible = "fsl,imx8mm-tmu";
 				reg = <0x30260000 0x10000>;
 				clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
+				nvmem-cells = <&tmu_calib>;
+				nvmem-cell-names = "calib";
 				#thermal-sensor-cells = <0>;
 			};
 
@@ -547,8 +553,8 @@
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
-				compatible = "fsl,imx8mm-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
+			gpr: syscon@30340000 {
+				compatible = "fsl,imx8mm-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
@@ -560,22 +566,40 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				imx8mm_uid: unique-id@410 {
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
+				imx8mm_uid: unique-id@4 { /* 0x410-0x420 */
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
-				compatible = "fsl,imx8mm-anatop", "syscon";
+			anatop: clock-controller@30360000 {
+				compatible = "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
+				#clock-cells = <1>;
 			};
 
 			snvs: snvs@30370000 {
@@ -674,13 +698,11 @@
 					pgc_otg1: power-domain@2 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_OTG1>;
-						power-domains = <&pgc_hsiomix>;
 					};
 
 					pgc_otg2: power-domain@3 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_OTG2>;
-						power-domains = <&pgc_hsiomix>;
 					};
 
 					pgc_gpumix: power-domain@4 {
@@ -1098,6 +1120,61 @@
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			lcdif: lcdif@32e00000 {
+				compatible = "fsl,imx8mm-lcdif", "fsl,imx6sx-lcdif";
+				reg = <0x32e00000 0x10000>;
+				clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
+					 <&clk IMX8MM_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				assigned-clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
+						  <&clk IMX8MM_CLK_DISP_AXI>,
+						  <&clk IMX8MM_CLK_DISP_APB>;
+				assigned-clock-parents = <&clk IMX8MM_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MM_SYS_PLL2_1000M>,
+							 <&clk IMX8MM_SYS_PLL1_800M>;
+				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_LCDIF>;
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
+				compatible = "fsl,imx8mm-mipi-dsim";
+				reg = <0x32e10000 0x400>;
+				clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+					 <&clk IMX8MM_CLK_DSI_PHY_REF>;
+				clock-names = "bus_clk", "sclk_mipi";
+				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+						  <&clk IMX8MM_CLK_DSI_PHY_REF>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+							 <&clk IMX8MM_CLK_24M>;
+				assigned-clock-rates = <266000000>, <24000000>;
+				samsung,pll-clock-frequency = <24000000>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_DSI>;
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
 			csi: csi@32e20000 {
 				compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";
 				reg = <0x32e20000 0x1000>;
@@ -1145,10 +1222,9 @@
 				compatible = "fsl,imx8mm-mipi-csi2";
 				reg = <0x32e30000 0x1000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>,
-						  <&clk IMX8MM_CLK_CSI1_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
-							  <&clk IMX8MM_SYS_PLL2_1000M>;
+				assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>;
+
 				clock-frequency = <333000000>;
 				clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
 					 <&clk IMX8MM_CLK_CSI1_ROOT>,
@@ -1177,7 +1253,7 @@
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1186,18 +1262,19 @@
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
-				power-domains = <&pgc_otg1>;
+				power-domains = <&pgc_hsiomix>;
 				status = "disabled";
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
 
 			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1206,12 +1283,13 @@
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop2>;
 				fsl,usbmisc = <&usbmisc2 0>;
-				power-domains = <&pgc_otg2>;
+				power-domains = <&pgc_hsiomix>;
 				status = "disabled";
 			};
 
 			usbmisc2: usbmisc@32e50200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e50200 0x200>;
 			};
@@ -1238,16 +1316,15 @@
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			clocks = <&clk IMX8MM_CLK_NAND_USDHC_BUS_RAWNAND_CLK>;
 		};
 
-		gpmi: nand-controller@33002000{
+		gpmi: nand-controller@33002000 {
 			compatible = "fsl,imx8mm-gpmi-nand", "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -1268,8 +1345,8 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges =  <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
-				   0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
@@ -1282,12 +1359,40 @@
 					<0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,max-link-speed = <2>;
 			linux,pci-domain = <0>;
+			clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
+				 <&clk IMX8MM_CLK_PCIE1_PHY>,
+				 <&clk IMX8MM_CLK_PCIE1_AUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_aux";
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "apps", "turnoff";
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@33800000 {
+			compatible = "fsl,imx8mm-pcie-ep";
+			reg = <0x33800000 0x400000>,
+			      <0x18000000 0x8000000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			fsl,max-link-speed = <2>;
+			clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
+				 <&clk IMX8MM_CLK_PCIE1_PHY>,
+				 <&clk IMX8MM_CLK_PCIE1_AUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_aux";
 			power-domains = <&pgc_pcie>;
 			resets = <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
 				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
 			reset-names = "apps", "turnoff";
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
 			status = "disabled";
 		};
 
-- 
2.34.1

