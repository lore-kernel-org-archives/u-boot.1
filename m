Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2185C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033B783082;
	Mon,  7 Apr 2025 20:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTfCfQlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A8082E38; Mon,  7 Apr 2025 15:04:55 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF16482E38
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so38039035e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744031092; x=1744635892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QM8jZeaCnR3e1lSFu+Suv79rhBlvggx1k5RdAMedzKU=;
 b=eTfCfQltNZuF8wR3lQzBxoiii/dbviEkbWZbPQyO5Uoa3K0KLqBimUjS78W5tkFSV8
 qmQgnoGpkIse2pnJRKXxz0F6yDiLcoTMgI1D5LwxIQ/T07GItiuSIrsjWgciXnikLlS8
 onX/BeuqBfD86Isdr7bHii0WWDP4Kae1Xk5KqdJgk2/E72pJITTppUeGBf8xjzoTnuMr
 TYGZb5/EXJ+JI2J0ETyqfJ0JQxNaoVYEl7sQLHBejYViM/Z/iOd0nkGwCbXc5We5Btg+
 ekz1jDoBBT9IqG8+zZ4ltOUWD98CDmrBPjnkG1nsVr99mjAHBu063ymDKeiT25VRffu7
 MkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744031092; x=1744635892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QM8jZeaCnR3e1lSFu+Suv79rhBlvggx1k5RdAMedzKU=;
 b=sK9UIIhphHwSnYBTJ3BCkr+lcPUkj8FHufvifGg/ycPfgLNheh4TmVOAHe2pzyXRb8
 znHLwPfMTLtPzGPo3l1N8b453D+LDLG1L14eHUMZG3vonOzmcEzHfckYv7FwxIrTQN3W
 yUNX79mSF6FjoPXmxifvk8CWR0+g4v9xRIuCJAUtr/r5mx7KlKS/ORGjr2zgQtVBMLIm
 ywGc44dAtR7M0SbOZv4Famem/ZCSSr/gU9jYcKmu1ak7YBwxADW/mAZoEP5uKFSX/VOu
 YyiPnWm4d4NVMzX4iys+Bz7IR3ZEQQSg8vQJAjLTMdOq0pzj59OQgztv7x3hOgeWXFaK
 jZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLhmlUgHHXz3Iy9c1S4cHZkp4yh/Hz6FFQAJLgU713JIWlkzFbJ0XEQdxOhG2+F2IRICXU3co=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0athhf1qLOvfFwPTjBjC97efo+tovKO17dXmiKT4MkCAGCpG5
 MhJDyn9nFkq0sfCJ7J+fTsdLPQT1DRsoF+Zumz5M1O7M7CJQVscF
X-Gm-Gg: ASbGnctINDST9xmjBUB2116Fm/p+BJLfLevoUSZGaS0/zWAjx61ft9RBpMlKmgNLim/
 HQo+n/SbEEzsC5Crx6T2dS0TREUsaJG1EerxFVk92iM80Pjj+13Rs3QcP9TaQtL8tcSTd6IInOe
 mMdtG2U1vadW0uE5puTBkcNxC4zoGCevkLKVnTzrirnj5TifyRGNyRidDFrvxftzoBpd1z+RgMz
 tHcTuyBBefs+oEWgDMVHxSV7AkCHtQzQV+7HqaX5nTgb4ZNtoOhmmDK64q0/doTyRy2NOJOHcVq
 SsUuwW+bt1uQE9eitk+iJ/fNVi7lMfrt7WpYMn9FAF0AwEzmX8T1
X-Google-Smtp-Source: AGHT+IEMR6trxSRWz5d15T+wDPaVuaw7woCw+APswkRoWfqQsU7mp81cchxFtf2AEpxGkLkHvYfzYg==
X-Received: by 2002:a05:600c:5117:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-43ee076924bmr59228005e9.25.1744031091764; 
 Mon, 07 Apr 2025 06:04:51 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:96ff:4d69:f7ba:e072])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795db7sm135931445e9.25.2025.04.07.06.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 06:04:51 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1 1/3] arm: dts: imx8mp: sync with Linux v6.15-rc1
Date: Mon,  7 Apr 2025 14:04:34 +0100
Message-Id: <20250407130436.223645-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407130436.223645-1-ivitro@gmail.com>
References: <20250407130436.223645-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Sync imx8mp.dtsi with Linux v6.15-rc1.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm/dts/imx8mp.dtsi | 413 +++++++++++++++++++++++++++++++++------
 1 file changed, 355 insertions(+), 58 deletions(-)

diff --git a/arch/arm/dts/imx8mp.dtsi b/arch/arm/dts/imx8mp.dtsi
index c9a610ba4836..ce6793b2d57e 100644
--- a/arch/arm/dts/imx8mp.dtsi
+++ b/arch/arm/dts/imx8mp.dtsi
@@ -47,6 +47,20 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+				wakeup-latency-us = <1500>;
+			};
+		};
+
 		A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
@@ -65,6 +79,7 @@
 			nvmem-cell-names = "speed_grade";
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_1: cpu@1 {
@@ -83,6 +98,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_2: cpu@2 {
@@ -101,6 +117,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_3: cpu@3 {
@@ -119,6 +136,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -264,6 +282,7 @@
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
+			status = "disabled";
 		};
 	};
 
@@ -726,6 +745,8 @@
 			clk: clock-controller@30380000 {
 				compatible = "fsl,imx8mp-ccm";
 				reg = <0x30380000 0x10000>;
+				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
 					 <&clk_ext3>, <&clk_ext4>;
@@ -786,6 +807,23 @@
 						reg = <IMX8MP_POWER_DOMAIN_USB2_PHY>;
 					};
 
+					pgc_mlmix: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+						assigned-clocks = <&clk IMX8MP_CLK_ML_CORE>,
+								  <&clk IMX8MP_CLK_ML_AXI>,
+								  <&clk IMX8MP_CLK_ML_AHB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <1000000000>,
+								       <800000000>,
+								       <400000000>;
+					};
+
 					pgc_audio: power-domain@5 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
@@ -793,10 +831,10 @@
 							 <&clk IMX8MP_CLK_AUDIO_AXI>;
 						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
 								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
-						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
-									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>;
 						assigned-clock-rates = <400000000>,
-								       <600000000>;
+								       <800000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
@@ -818,6 +856,12 @@
 						assigned-clock-rates = <800000000>, <400000000>;
 					};
 
+					pgc_vpumix: power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
 					pgc_gpu3d: power-domain@9 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_GPU3D>;
@@ -833,60 +877,64 @@
 							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
 					};
 
-					pgc_mipi_phy2: power-domain@16 {
+					pgc_vpu_g1: power-domain@11 {
 						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
 					};
 
-					pgc_hsiomix: power-domain@17 {
+					pgc_vpu_g2: power-domain@12 {
 						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_HSIOMIX>;
-						clocks = <&clk IMX8MP_CLK_HSIO_AXI>,
-							 <&clk IMX8MP_CLK_HSIO_ROOT>;
-						assigned-clocks = <&clk IMX8MP_CLK_HSIO_AXI>;
-						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>;
-						assigned-clock-rates = <500000000>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+
 					};
 
-					pgc_ispdwp: power-domain@18 {
+					pgc_vpu_vc8000e: power-domain@13 {
 						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
-						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
 
-					pgc_vpumix: power-domain@19 {
+					pgc_hdmimix: power-domain@14 {
 						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
-						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMIMIX>;
+						clocks = <&clk IMX8MP_CLK_HDMI_ROOT>,
+							 <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clocks = <&clk IMX8MP_CLK_HDMI_AXI>,
+								  <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>,
+									 <&clk IMX8MP_SYS_PLL1_133M>;
+						assigned-clock-rates = <500000000>, <133000000>;
 					};
 
-					pgc_vpu_g1: power-domain@20 {
+					pgc_hdmi_phy: power-domain@15 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
-						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMI_PHY>;
 					};
 
-					pgc_vpu_g2: power-domain@21 {
+					pgc_mipi_phy2: power-domain@16 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
-						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
 					};
 
-					pgc_vpu_vc8000e: power-domain@22 {
+					pgc_hsiomix: power-domain@17 {
 						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
-						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+						reg = <IMX8MP_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MP_CLK_HSIO_AXI>,
+							 <&clk IMX8MP_CLK_HSIO_ROOT>;
+						assigned-clocks = <&clk IMX8MP_CLK_HSIO_AXI>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>;
+						assigned-clock-rates = <500000000>;
 					};
 
-					pgc_mlmix: power-domain@24 {
+					pgc_ispdwp: power-domain@18 {
 						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
-						clocks = <&clk IMX8MP_CLK_ML_AXI>,
-							 <&clk IMX8MP_CLK_ML_AHB>,
-							 <&clk IMX8MP_CLK_NPU_ROOT>;
+						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
+						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
 				};
 			};
@@ -1231,7 +1279,7 @@
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
@@ -1245,7 +1293,7 @@
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC2_ROOT>;
 				clock-names = "ipg", "ahb", "per";
@@ -1259,7 +1307,7 @@
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
@@ -1501,6 +1549,41 @@
 					status = "disabled";
 				};
 
+				aud2htx: aud2htx@30cb0000 {
+					compatible = "fsl,imx8mp-aud2htx";
+					reg = <0x30cb0000 0x10000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
+					clock-names = "bus";
+					dmas = <&sdma2 26 2 0>;
+					dma-names = "tx";
+					status = "disabled";
+				};
+
+				xcvr: xcvr@30cc0000 {
+					compatible = "fsl,imx8mp-xcvr";
+					reg = <0x30cc0000 0x800>,
+					      <0x30cc0800 0x400>,
+					      <0x30cc0c00 0x080>,
+					      <0x30cc0e00 0x080>;
+					reg-names = "ram", "regs", "rxfifo",
+						    "txfifo";
+					interrupts = /* XCVR IRQ 0 */
+						     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+						     /* XCVR IRQ 1 */
+						     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+						     /* XCVR PHY - SPDIF wakeup IRQ */
+						     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_EARC_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_EARC_PHY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT>;
+					clock-names = "ipg", "phy", "spba", "pll_ipg";
+					dmas = <&sdma2 30 2 0>, <&sdma2 31 2 0>;
+					dma-names = "rx", "tx";
+					resets = <&audio_blk_ctrl 0>;
+					status = "disabled";
+				};
 			};
 
 			sdma3: dma-controller@30e00000 {
@@ -1529,17 +1612,22 @@
 				compatible = "fsl,imx8mp-audio-blk-ctrl";
 				reg = <0x30e20000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 				clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
 					 <&clk IMX8MP_CLK_SAI1>,
 					 <&clk IMX8MP_CLK_SAI2>,
 					 <&clk IMX8MP_CLK_SAI3>,
 					 <&clk IMX8MP_CLK_SAI5>,
 					 <&clk IMX8MP_CLK_SAI6>,
-					 <&clk IMX8MP_CLK_SAI7>;
+					 <&clk IMX8MP_CLK_SAI7>,
+					 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
 				clock-names = "ahb",
 					      "sai1", "sai2", "sai3",
-					      "sai5", "sai6", "sai7";
+					      "sai5", "sai6", "sai7", "axi";
 				power-domains = <&pgc_audio>;
+				assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>,
+						  <&clk IMX8MP_AUDIO_PLL2>;
+				assigned-clock-rates = <393216000>, <361267200>;
 			};
 		};
 
@@ -1604,6 +1692,50 @@
 				};
 			};
 
+			isp_0: isp@32e10000 {
+				compatible = "fsl,imx8mp-isp";
+				reg = <0x32e10000 0x10000>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+				clock-names = "isp", "aclk", "hclk";
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISP>;
+				fsl,blk-ctrl = <&media_blk_ctrl 0>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+
+			isp_1: isp@32e20000 {
+				compatible = "fsl,imx8mp-isp";
+				reg = <0x32e20000 0x10000>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+				clock-names = "isp", "aclk", "hclk";
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISP>;
+				fsl,blk-ctrl = <&media_blk_ctrl 1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+
 			dewarp: dwe@32e30000 {
 				compatible = "nxp,imx8mp-dw100";
 				reg = <0x32e30000 0x10000>;
@@ -1618,15 +1750,16 @@
 				compatible = "fsl,imx8mp-mipi-csi2", "fsl,imx8mm-mipi-csi2";
 				reg = <0x32e40000 0x10000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency = <500000000>;
+				clock-frequency = <250000000>;
 				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
 				clock-names = "pclk", "wrap", "phy", "axi";
-				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM1_PIX>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
-				assigned-clock-rates = <500000000>;
+				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM1_PIX>,
+						  <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_250M>,
+							 <&clk IMX8MP_CLK_24M>;
 				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_CSI2_1>;
 				status = "disabled";
 
@@ -1652,15 +1785,16 @@
 				compatible = "fsl,imx8mp-mipi-csi2", "fsl,imx8mm-mipi-csi2";
 				reg = <0x32e50000 0x10000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clock-frequency = <266000000>;
+				clock-frequency = <250000000>;
 				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
 				clock-names = "pclk", "wrap", "phy", "axi";
-				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM2_PIX>;
-				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
-				assigned-clock-rates = <266000000>;
+				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM2_PIX>,
+						  <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_250M>,
+							 <&clk IMX8MP_CLK_24M>;
 				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_CSI2_2>;
 				status = "disabled";
 
@@ -1709,6 +1843,13 @@
 							remote-endpoint = <&lcdif1_to_dsim>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_dsi_out: endpoint {
+						};
+					};
 				};
 			};
 
@@ -1791,24 +1932,33 @@
 				clock-names = "apb", "axi", "cam1", "cam2",
 					      "disp1", "disp2", "isp", "phy";
 
+				/*
+				 * The ISP maximum frequency is 400MHz in normal mode
+				 * and 500MHz in overdrive mode. The 400MHz operating
+				 * point hasn't been successfully tested yet, so set
+				 * IMX8MP_CLK_MEDIA_ISP to 500MHz for the time being.
+				 */
 				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_AXI>,
 						  <&clk IMX8MP_CLK_MEDIA_APB>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP1_PIX>,
 						  <&clk IMX8MP_CLK_MEDIA_DISP2_PIX>,
+						  <&clk IMX8MP_CLK_MEDIA_ISP>,
 						  <&clk IMX8MP_VIDEO_PLL1>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
-							 <&clk IMX8MP_VIDEO_PLL1_OUT>;
+							 <&clk IMX8MP_VIDEO_PLL1_OUT>,
+							 <&clk IMX8MP_SYS_PLL2_500M>;
 				assigned-clock-rates = <500000000>, <200000000>,
-						       <0>, <0>, <1039500000>;
+						       <0>, <0>, <500000000>,
+						       <1039500000>;
 				#power-domain-cells = <1>;
 
 				lvds_bridge: bridge@5c {
 					compatible = "fsl,imx8mp-ldb";
 					reg = <0x5c 0x4>, <0x128 0x4>;
 					reg-names = "ldb", "lvds";
-					clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
+					clocks = <&clk IMX8MP_CLK_MEDIA_LDB_ROOT>;
 					clock-names = "ldb";
 					assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>;
 					assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
@@ -1873,6 +2023,136 @@
 				#power-domain-cells = <1>;
 				#clock-cells = <0>;
 			};
+
+			hdmi_blk_ctrl: blk-ctrl@32fc0000 {
+				compatible = "fsl,imx8mp-hdmi-blk-ctrl", "syscon";
+				reg = <0x32fc0000 0x1000>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_HDMI_24M>,
+					 <&clk IMX8MP_CLK_HDMI_FDCC_TST>;
+				clock-names = "apb", "axi", "ref_266m", "ref_24m", "fdcc";
+				power-domains = <&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmi_phy>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>;
+				power-domain-names = "bus", "irqsteer", "lcdif",
+						     "pai", "pvi", "trng",
+						     "hdmi-tx", "hdmi-tx-phy",
+						     "hdcp", "hrv";
+				#power-domain-cells = <1>;
+			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx8mp-irqsteer", "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x1000>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				fsl,channel = <1>;
+				fsl,num-irqs = <64>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>;
+				clock-names = "ipg";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
+			};
+
+			hdmi_pvi: display-bridge@32fc4000 {
+				compatible = "fsl,imx8mp-hdmi-pvi";
+				reg = <0x32fc4000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <12>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						pvi_from_lcdif3: endpoint {
+							remote-endpoint = <&lcdif3_to_pvi>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						pvi_to_hdmi_tx: endpoint {
+							remote-endpoint = <&hdmi_tx_from_pvi>;
+						};
+					};
+				};
+			};
+
+			lcdif3: display-controller@32fc6000 {
+				compatible = "fsl,imx8mp-lcdif";
+				reg = <0x32fc6000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <8>;
+				clocks = <&hdmi_tx_phy>,
+					 <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_LCDIF>;
+				status = "disabled";
+
+				port {
+					lcdif3_to_pvi: endpoint {
+						remote-endpoint = <&pvi_from_lcdif3>;
+					};
+				};
+			};
+
+			hdmi_tx: hdmi@32fd8000 {
+				compatible = "fsl,imx8mp-hdmi-tx";
+				reg = <0x32fd8000 0x7eff>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <0>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_32K>,
+					 <&hdmi_tx_phy>;
+				clock-names = "iahb", "isfr", "cec", "pix";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_REF_266M>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
+				reg-io-width = <1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						hdmi_tx_from_pvi: endpoint {
+							remote-endpoint = <&pvi_to_hdmi_tx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						/* Point endpoint to the HDMI connector */
+					};
+				};
+			};
+
+			hdmi_tx_phy: phy@32fdff00 {
+				compatible = "fsl,imx8mp-hdmi-phy";
+				reg = <0x32fdff00 0x100>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_24M>;
+				clock-names = "apb", "ref";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_24M>;
+				assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		pcie: pcie@33800000 {
@@ -1915,8 +2195,11 @@
 
 		pcie_ep: pcie-ep@33800000 {
 			compatible = "fsl,imx8mp-pcie-ep";
-			reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33800000 0x100000>,
+			      <0x18000000 0x8000000>,
+			      <0x33900000 0x100000>,
+			      <0x33b00000 0x100000>;
+			reg-names = "dbi", "addr_space", "dbi2", "atu";
 			clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
 				 <&clk IMX8MP_CLK_HSIO_AXI>,
 				 <&clk IMX8MP_CLK_PCIE_ROOT>;
@@ -1950,9 +2233,9 @@
 			clock-names = "core", "shader", "bus", "reg";
 			assigned-clocks = <&clk IMX8MP_CLK_GPU3D_CORE>,
 					  <&clk IMX8MP_CLK_GPU3D_SHADER_CORE>;
-			assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
-						 <&clk IMX8MP_SYS_PLL1_800M>;
-			assigned-clock-rates = <800000000>, <800000000>;
+			assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>,
+						 <&clk IMX8MP_SYS_PLL2_1000M>;
+			assigned-clock-rates = <1000000000>, <1000000000>;
 			power-domains = <&pgc_gpu3d>;
 		};
 
@@ -1965,8 +2248,8 @@
 				 <&clk IMX8MP_CLK_GPU_AHB>;
 			clock-names = "core", "bus", "reg";
 			assigned-clocks = <&clk IMX8MP_CLK_GPU2D_CORE>;
-			assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-			assigned-clock-rates = <800000000>;
+			assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
+			assigned-clock-rates = <1000000000>;
 			power-domains = <&pgc_gpu2d>;
 		};
 
@@ -2012,6 +2295,18 @@
 			interconnect-names = "g1", "g2", "vc8000e";
 		};
 
+		npu: npu@38500000 {
+			compatible = "vivante,gc";
+			reg = <0x38500000 0x200000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_NPU_ROOT>,
+				 <&clk IMX8MP_CLK_ML_AXI>,
+				 <&clk IMX8MP_CLK_ML_AHB>;
+			clock-names = "core", "shader", "bus", "reg";
+			power-domains = <&pgc_mlmix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
@@ -2072,6 +2367,7 @@
 				phys = <&usb3_phy0>, <&usb3_phy0>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 
 		};
@@ -2114,6 +2410,7 @@
 				phys = <&usb3_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
-- 
2.34.1

