Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB352CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5513587022;
	Thu, 19 Oct 2023 14:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JFynJnjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC1B86FF6; Thu, 19 Oct 2023 14:07:13 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7C186FC0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so1201883b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697717225; x=1698322025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4pieOcv3Rmvog/D+wRYe0vB7TBiq9DzUOsI0jOhjNE=;
 b=JFynJnjOvpG640vyEtDVOy4dAjfrJd/k3YpZR3JoqkwziHl4u+tuR3pa9zcrlnHbBj
 7CJcDJzQgHQN60mdKwSb/DlSOmXmpidMyN1UgWHjwNeP8B52k75ALT4aWGY9rRTEBhDg
 OTfxzMnYUxtJ+DPKvv1WsF81LgjaIReKWXjOi1QdPSvY+WgOS1ghUAagdbjt+47sUl5v
 zniHg/EZRogXWoVNNfPwQHcJyfVSXtrH/GqqojdHOqyHJ4auA8hAgHpvI5qbN1HrsmpC
 ls43EYvRW48RXN5AArh87Ph1DBlRqZHGpvytap1U7OJgPNQwq87B/mzZJwoJXpYmGnjQ
 QBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717225; x=1698322025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4pieOcv3Rmvog/D+wRYe0vB7TBiq9DzUOsI0jOhjNE=;
 b=P3JYTgOaqygHnYeyc5/pDi1kT7czRfx/efQVo/aDFtW32Wskyl1SqBD9DGRKt5A1N/
 sCRssBCazo0EAEJofWMunbwzf2PqAxPOmx3l8HUUZIU/dML1EwGc/LqMfJwvvHwWyIhG
 zIEhlmA4UMyu7EFqTdhJ36KiumEj7B2hWG96292nWYApyTyym6AXHw8cFu501m00Xcz4
 yWB//Bo7e0cMcV51FiQoAlmEfhSBJPRezMPKWp2PUvz+3qu8wVglipH2Bw2kswhdj8OT
 Umi8X3adTZIIOcB/D21Rb3oOK/WncUGk+irgos/o++tYVrqKaBEdudhsSPQOkDWnLtbM
 gS/A==
X-Gm-Message-State: AOJu0Yw1X6R9wWlx+dP7JDqh1nk8J4R8VaDc1y3DCvR8yGau4lUnY8pd
 cfvwTvPX2i+D1KOzq/gb+yw=
X-Google-Smtp-Source: AGHT+IF9ghhE4OjGOpwIhkev5dC2SZfLedjW+y9bAafliQgZb9vp3VMXQJFgH58CE01kq9/66mWXrA==
X-Received: by 2002:a05:6a00:2b87:b0:68f:c8b3:3077 with SMTP id
 dv7-20020a056a002b8700b0068fc8b33077mr1747703pfb.1.1697717225281; 
 Thu, 19 Oct 2023 05:07:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a056a00134b00b0068620bee456sm4975154pfu.209.2023.10.19.05.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:07:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/3] arm: dts: imx8mp: Sync with linux-next 20231019
Date: Thu, 19 Oct 2023 09:06:23 -0300
Message-Id: <20231019120623.1476421-3-festevam@gmail.com>
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

Sync imx8mp.dtsi and imx8mp-clock.h with linux-next 20231019.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Rebased against latest U-Boot and synced with linux-next 20231019

 arch/arm/dts/imx8mp.dtsi                 | 542 ++++++++++++++++++++++-
 include/dt-bindings/clock/imx8mp-clock.h |   3 +-
 2 files changed, 526 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/imx8mp.dtsi b/arch/arm/dts/imx8mp.dtsi
index 428c60462e3d..c9a610ba4836 100644
--- a/arch/arm/dts/imx8mp.dtsi
+++ b/arch/arm/dts/imx8mp.dtsi
@@ -202,6 +202,60 @@
 		clock-output-names = "clk_ext4";
 	};
 
+	funnel {
+		/*
+		 * non-configurable funnel don't show up on the AMBA
+		 * bus.  As such no need to add "arm,primecell".
+		 */
+		compatible = "arm,coresight-static-funnel";
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				ca_funnel_in_port0: endpoint {
+					remote-endpoint = <&etm0_out_port>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				ca_funnel_in_port1: endpoint {
+					remote-endpoint = <&etm1_out_port>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				ca_funnel_in_port2: endpoint {
+					remote-endpoint = <&etm2_out_port>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+
+					ca_funnel_in_port3: endpoint {
+					remote-endpoint = <&etm3_out_port>;
+				};
+			};
+		};
+
+		out-ports {
+			port {
+
+				ca_funnel_out_port0: endpoint {
+					remote-endpoint = <&hugo_funnel_in_port0>;
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -304,6 +358,153 @@
 		nvmem-cells = <&imx8mp_uid>;
 		nvmem-cell-names = "soc_unique_id";
 
+		etm0: etm@28440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28440000 0x1000>;
+			cpu = <&A53_0>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		etm1: etm@28540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28540000 0x1000>;
+			cpu = <&A53_1>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm1_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port1>;
+					};
+				};
+			};
+		};
+
+		etm2: etm@28640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28640000 0x1000>;
+			cpu = <&A53_2>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm2_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port2>;
+					};
+				};
+			};
+		};
+
+		etm3: etm@28740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x28740000 0x1000>;
+			cpu = <&A53_3>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm3_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port3>;
+					};
+				};
+			};
+		};
+
+		funnel@28c03000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x28c03000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					hugo_funnel_in_port0: endpoint {
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					hugo_funnel_in_port1: endpoint {
+					/* M7 input */
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					hugo_funnel_in_port2: endpoint {
+					/* DSP input */
+					};
+				};
+				/* the other input ports are not connect to anything */
+			};
+
+			out-ports {
+				port {
+					hugo_funnel_out_port0: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
+				};
+			};
+		};
+
+		etf@28c04000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x28c04000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etf_in_port: endpoint {
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out_port: endpoint {
+						remote-endpoint = <&etr_in_port>;
+					};
+				};
+			};
+		};
+
+		etr@28c06000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x28c06000 0x1000>;
+			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&etf_out_port>;
+					};
+				};
+			};
+		};
+
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x30000000 0x400000>;
@@ -497,7 +698,7 @@
 
 				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					regmap =<&snvs>;
+					regmap = <&snvs>;
 					offset = <0x34>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -534,26 +735,16 @@
 						  <&clk IMX8MP_CLK_A53_CORE>,
 						  <&clk IMX8MP_CLK_NOC>,
 						  <&clk IMX8MP_CLK_NOC_IO>,
-						  <&clk IMX8MP_CLK_GIC>,
-						  <&clk IMX8MP_CLK_AUDIO_AHB>,
-						  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>,
-						  <&clk IMX8MP_AUDIO_PLL1>,
-						  <&clk IMX8MP_AUDIO_PLL2>;
+						  <&clk IMX8MP_CLK_GIC>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
 							 <&clk IMX8MP_ARM_PLL_OUT>,
 							 <&clk IMX8MP_SYS_PLL2_1000M>,
 							 <&clk IMX8MP_SYS_PLL1_800M>,
-							 <&clk IMX8MP_SYS_PLL2_500M>,
-							 <&clk IMX8MP_SYS_PLL1_800M>,
-							 <&clk IMX8MP_SYS_PLL1_800M>;
+							 <&clk IMX8MP_SYS_PLL2_500M>;
 				assigned-clock-rates = <0>, <0>,
 						       <1000000000>,
 						       <800000000>,
-						       <500000000>,
-						       <400000000>,
-						       <800000000>,
-						       <393216000>,
-						       <361267200>;
+						       <500000000>;
 			};
 
 			src: reset-controller@30390000 {
@@ -595,6 +786,19 @@
 						reg = <IMX8MP_POWER_DOMAIN_USB2_PHY>;
 					};
 
+					pgc_audio: power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
+						clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
+							 <&clk IMX8MP_CLK_AUDIO_AXI>;
+						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
+								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
+						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
+									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <400000000>,
+								       <600000000>;
+					};
+
 					pgc_gpu2d: power-domain@6 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_GPU2D>;
@@ -653,7 +857,7 @@
 					pgc_vpumix: power-domain@19 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
-						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
 					};
 
 					pgc_vpu_g1: power-domain@20 {
@@ -1147,6 +1351,198 @@
 			};
 		};
 
+		aips5: bus@30c00000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x30c00000 0x400000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			spba-bus@30c00000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				reg = <0x30c00000 0x100000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				sai1: sai@30c10000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c10000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				sai2: sai@30c20000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c20000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				sai3: sai@30c30000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c30000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				sai5: sai@30c50000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c50000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI5_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI5_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				sai6: sai@30c60000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c60000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI6_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI6_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				sai7: sai@30c80000 {
+					compatible = "fsl,imx8mp-sai", "fsl,imx8mq-sai";
+					reg = <0x30c80000 0x10000>;
+					#sound-dai-cells = <0>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI7_IPG>,
+						 <&clk IMX8MP_CLK_DUMMY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI7_MCLK3>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 12 2 0>, <&sdma2 13 2 0>;
+					dma-names = "rx", "tx";
+					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
+				easrc: easrc@30c90000 {
+					compatible = "fsl,imx8mp-easrc", "fsl,imx8mn-easrc";
+					reg = <0x30c90000 0x10000>;
+					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_ASRC_IPG>;
+					clock-names = "mem";
+					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+					dma-names = "ctx0_rx", "ctx0_tx",
+						    "ctx1_rx", "ctx1_tx",
+						    "ctx2_rx", "ctx2_tx",
+						    "ctx3_rx", "ctx3_tx";
+					firmware-name = "imx/easrc/easrc-imx8mn.bin";
+					fsl,asrc-rate = <8000>;
+					fsl,asrc-format = <2>;
+					status = "disabled";
+				};
+
+				micfil: audio-controller@30ca0000 {
+					compatible = "fsl,imx8mp-micfil";
+					reg = <0x30ca0000 0x10000>;
+					#sound-dai-cells = <0>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_SEL>,
+						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MP_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
+			};
+
+			sdma3: dma-controller@30e00000 {
+				compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
+				reg = <0x30e00000 0x10000>;
+				#dma-cells = <3>;
+				clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT>,
+					 <&clk IMX8MP_CLK_AUDIO_ROOT>;
+				clock-names = "ipg", "ahb";
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
+			sdma2: dma-controller@30e10000 {
+				compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
+				reg = <0x30e10000 0x10000>;
+				#dma-cells = <3>;
+				clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SDMA2_ROOT>,
+					 <&clk IMX8MP_CLK_AUDIO_ROOT>;
+				clock-names = "ipg", "ahb";
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
+			audio_blk_ctrl: clock-controller@30e20000 {
+				compatible = "fsl,imx8mp-audio-blk-ctrl";
+				reg = <0x30e20000 0x10000>;
+				#clock-cells = <1>;
+				clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
+					 <&clk IMX8MP_CLK_SAI1>,
+					 <&clk IMX8MP_CLK_SAI2>,
+					 <&clk IMX8MP_CLK_SAI3>,
+					 <&clk IMX8MP_CLK_SAI5>,
+					 <&clk IMX8MP_CLK_SAI6>,
+					 <&clk IMX8MP_CLK_SAI7>;
+				clock-names = "ahb",
+					      "sai1", "sai2", "sai3",
+					      "sai5", "sai6", "sai7";
+				power-domains = <&pgc_audio>;
+			};
+		};
+
 		noc: interconnect@32700000 {
 			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc";
 			reg = <0x32700000 0x100000>;
@@ -1174,6 +1570,118 @@
 			#size-cells = <1>;
 			ranges;
 
+			isi_0: isi@32e00000 {
+				compatible = "fsl,imx8mp-isi";
+				reg = <0x32e00000 0x4000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+				clock-names = "axi", "apb";
+				fsl,blk-ctrl = <&media_blk_ctrl>;
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						isi_in_0: endpoint {
+							remote-endpoint = <&mipi_csi_0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						isi_in_1: endpoint {
+							remote-endpoint = <&mipi_csi_1_out>;
+						};
+					};
+				};
+			};
+
+			dewarp: dwe@32e30000 {
+				compatible = "nxp,imx8mp-dw100";
+				reg = <0x32e30000 0x10000>;
+				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
+				clock-names = "axi", "ahb";
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_DWE>;
+			};
+
+			mipi_csi_0: csi@32e40000 {
+				compatible = "fsl,imx8mp-mipi-csi2", "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e40000 0x10000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <500000000>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
+				clock-names = "pclk", "wrap", "phy", "axi";
+				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM1_PIX>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
+				assigned-clock-rates = <500000000>;
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_CSI2_1>;
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
+						mipi_csi_0_out: endpoint {
+							remote-endpoint = <&isi_in_0>;
+						};
+					};
+				};
+			};
+
+			mipi_csi_1: csi@32e50000 {
+				compatible = "fsl,imx8mp-mipi-csi2", "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e50000 0x10000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <266000000>;
+				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT>,
+					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>;
+				clock-names = "pclk", "wrap", "phy", "axi";
+				assigned-clocks = <&clk IMX8MP_CLK_MEDIA_CAM2_PIX>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_1000M>;
+				assigned-clock-rates = <266000000>;
+				power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_MIPI_CSI2_2>;
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
+						mipi_csi_1_out: endpoint {
+							remote-endpoint = <&isi_in_1>;
+						};
+					};
+				};
+			};
+
 			mipi_dsi: dsi@32e60000 {
 				compatible = "fsl,imx8mp-mipi-dsim";
 				reg = <0x32e60000 0x400>;
@@ -1382,8 +1890,8 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges =  <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
-				  <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 3f28ce685f41..7da4243984b2 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -130,7 +130,7 @@
 #define IMX8MP_CLK_SAI1				123
 #define IMX8MP_CLK_SAI2				124
 #define IMX8MP_CLK_SAI3				125
-#define IMX8MP_CLK_SAI4				126
+/* #define IMX8MP_CLK_SAI4				126 */
 #define IMX8MP_CLK_SAI5				127
 #define IMX8MP_CLK_SAI6				128
 #define IMX8MP_CLK_ENET_QOS			129
@@ -376,7 +376,6 @@
 #define IMX8MP_CLK_AUDIOMIX_MU2_ROOT		36
 #define IMX8MP_CLK_AUDIOMIX_MU3_ROOT		37
 #define IMX8MP_CLK_AUDIOMIX_EARC_PHY		38
-#define IMX8MP_CLK_AUDIOMIX_PDM_ROOT		39
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1_SEL	40
 #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2_SEL	41
 #define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1_SEL	42
-- 
2.34.1

