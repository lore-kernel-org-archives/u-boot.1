Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF3DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C342885C5;
	Fri,  2 Aug 2024 21:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EhhZZYeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BCE88297; Fri,  2 Aug 2024 21:56:56 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D7D88C8C
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so58414545e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628609; x=1723233409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8ChadpWpNI9G49XboBm4SnRXcDW/YBMT7KAm4CWq3Y=;
 b=EhhZZYeByLz5QpL+DG3yxRocddNIqt9L71cC1Y9Xh+yao29zRTg8iBrRhGjYmhTqfN
 eXRVCBXlegQfV/7vTio7L1q5nGbg7PJGnb2UVZWDi21IUXyxF9Su+ClFkEbUOy3Ok/wN
 smLf0hU+u9T200l8L3eIkDgznEqbwE3jCSNjyLtpUm1uehXvSq2DK+Sy5cP8DxOF9qsW
 U55yQ1dJ2TMb74MGQjd1k+CGv7dycCuSVQz0YFq0/UbvpbzE4XMx2kAXR+sbuu5MOP5U
 kBS2LtVR4iPzjN/rJFy6GfMkrlUmGoNS3XG828vv8p3DCMRICawAjyMrf/ojklUnHarD
 TRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628609; x=1723233409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8ChadpWpNI9G49XboBm4SnRXcDW/YBMT7KAm4CWq3Y=;
 b=eDn8lauHaFAR558ptR8whsa55tbmbL0ClWJ0HxlUkB7hby/KvWA1CgnRn/lR6Kt8xu
 wR2nKbZURFIL67WAwc7CzYl9d1OJ8cem8vK6FRnihGvAn59O/nol74n9zFt/hcGSxuU9
 rWZCuuqXTuY+ZEX+ug2nPq9eiiI0NV0mXkay8+Il51uQ+6LjCGTjkhwDfZfaKa7Phd+3
 znk+8SMCjcVFgVfsiMP9mddQVrX1wt1qZ0M08K5/fLI0YKM4M9FEMT2gst4dMzlTXmXk
 /44nunOD5iKdh9hG80K8ZwDVNPcGaRTDm6E4fQNBcajEPPu0YD+e9GCtBnt9cFS10RKJ
 MAJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ6KchsYnabF0eze25jYOxgtyZ9tFclmILXU5Ar7y50GBS/4GX4T17fstYmfX6fSopOtUEw12BccIGQGA6lEaDx9LCTw==
X-Gm-Message-State: AOJu0YyYEk2NkfqV94Hmo+RVIhCULxjS3UsCuQkZorr8wWQ+ncPb609N
 pVD8HWuChU2ldcJWSg5HPDT+i9lMU5J5Or8jvRrM/ae8w0p9kldM54C6qQ==
X-Google-Smtp-Source: AGHT+IGyIuj8qe+Il8qlq640/TtnY09YAh/VwxkpHU/81rKBRGLy27sKJ9VJgRp5veDnl+yaeZMsYA==
X-Received: by 2002:a05:600c:4752:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-428e6af0f33mr29475805e9.13.1722628608622; 
 Fri, 02 Aug 2024 12:56:48 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 13/14] clk: mediatek: mt7981: convert to unified infracfg
 gates + muxes
Date: Fri,  2 Aug 2024 15:53:14 +0200
Message-ID: <20240802135326.25303-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Convert to infracfg gates + muxes implementation now that it's
supported.

Drop infracfg-ao nodes and rename all infracfg-ao clocks to infracfg.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi          | 46 +++++++++++++------------------
 drivers/clk/mediatek/clk-mt7981.c | 26 ++---------------
 2 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index b3f8a50cd10..1c54fce7520 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -98,14 +98,6 @@
 		bootph-all;
 	};
 
-	infracfg_ao: infracfg_ao@10001000 {
-		compatible = "mediatek,mt7981-infracfg_ao";
-		reg = <0x10001000 0x80>;
-		clock-parent = <&infracfg>;
-		#clock-cells = <1>;
-		bootph-all;
-	};
-
 	infracfg: infracfg@10001000 {
 		compatible = "mediatek,mt7981-infracfg";
 		reg = <0x10001000 0x30>;
@@ -141,10 +133,10 @@
 		#pwm-cells = <2>;
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&topckgen CK_TOP_PWM_SEL>,
-			 <&infracfg_ao CK_INFRA_PWM_BSEL>,
-			 <&infracfg_ao CK_INFRA_PWM1_CK>,
-			 <&infracfg_ao CK_INFRA_PWM2_CK>,
-			 <&infracfg_ao CK_INFRA_PWM3_CK>;
+			 <&infracfg CK_INFRA_PWM_BSEL>,
+			 <&infracfg CK_INFRA_PWM1_CK>,
+			 <&infracfg CK_INFRA_PWM2_CK>,
+			 <&infracfg CK_INFRA_PWM3_CK>;
 		assigned-clocks = <&topckgen CK_TOP_PWM_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>;
 		clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
@@ -157,8 +149,8 @@
 		      <0x10217080 0x80>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		clock-div = <1>;
-		clocks = <&infracfg_ao CK_INFRA_I2C0_CK>,
-			 <&infracfg_ao CK_INFRA_AP_DMA_CK>;
+		clocks = <&infracfg CK_INFRA_I2C0_CK>,
+			 <&infracfg CK_INFRA_AP_DMA_CK>;
 		clock-names = "main", "dma";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -169,9 +161,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11002000 0x400>;
 		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART0_CK>;
+		clocks = <&infracfg CK_INFRA_UART0_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_UART0_SEL>;
+				  <&infracfg CK_INFRA_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
@@ -183,9 +175,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11003000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART1_CK>;
+		clocks = <&infracfg CK_INFRA_UART1_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_UART1_SEL>;
+				  <&infracfg CK_INFRA_UART1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
@@ -196,9 +188,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11004000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART2_CK>;
+		clocks = <&infracfg CK_INFRA_UART2_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_UART2_SEL>;
+				  <&infracfg CK_INFRA_UART2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
@@ -210,9 +202,9 @@
 		reg = <0x11005000 0x1000>,
 		      <0x11006000 0x1000>;
 		reg-names = "nfi", "ecc";
-		clocks = <&infracfg_ao CK_INFRA_SPINFI1_CK>,
-			 <&infracfg_ao CK_INFRA_NFI1_CK>,
-			 <&infracfg_ao CK_INFRA_NFI_HCK_CK>;
+		clocks = <&infracfg CK_INFRA_SPINFI1_CK>,
+			 <&infracfg CK_INFRA_NFI1_CK>,
+			 <&infracfg CK_INFRA_NFI_HCK_CK>;
 		clock-names = "pad_clk", "nfi_clk", "nfi_hclk";
 		assigned-clocks = <&topckgen CK_TOP_SPINFI_SEL>,
 				  <&topckgen CK_TOP_NFI1X_SEL>;
@@ -264,7 +256,7 @@
 	spi0: spi@1100a000 {
 		compatible = "mediatek,ipm-spi";
 		reg = <0x1100a000 0x100>;
-		clocks = <&infracfg_ao CK_INFRA_SPI0_CK>,
+		clocks = <&infracfg CK_INFRA_SPI0_CK>,
 			 <&topckgen CK_TOP_SPI_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI0_SEL>;
@@ -279,7 +271,7 @@
 		compatible = "mediatek,ipm-spi";
 		reg = <0x1100b000 0x100>;
 		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_SPI1_CK>,
+		clocks = <&infracfg CK_INFRA_SPI1_CK>,
 			 <&topckgen CK_TOP_SPIM_MST_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPIM_MST_SEL>,
 				  <&infracfg CK_INFRA_SPI1_SEL>;
@@ -292,7 +284,7 @@
 	spi2: spi@11009000 {
 		compatible = "mediatek,ipm-spi";
 		reg = <0x11009000 0x100>;
-		clocks = <&infracfg_ao CK_INFRA_SPI2_CK>,
+		clocks = <&infracfg CK_INFRA_SPI2_CK>,
 			 <&topckgen CK_TOP_SPI_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI2_SEL>;
@@ -310,7 +302,7 @@
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&topckgen CK_TOP_EMMC_400M>,
 			 <&topckgen CK_TOP_EMMC_208M>,
-			 <&infracfg_ao CK_INFRA_MSDC_CK>;
+			 <&infracfg CK_INFRA_MSDC_CK>;
 		assigned-clocks = <&topckgen CK_TOP_EMMC_400M_SEL>,
 				  <&topckgen CK_TOP_EMMC_208M_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_NET2_D2>,
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7b692186dc1..2c10e36dfec 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -441,7 +441,7 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
 	GATE_INFRA2(_id, _name, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
 
 /* INFRA GATE */
-static const struct mtk_gate infracfg_ao_gates[] = {
+static const struct mtk_gate infracfg_gates[] = {
 	GATE_INFRA0_INFRA(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_66M_MCK, 0),
 	GATE_INFRA0_INFRA(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_66M_MCK, 1),
 	GATE_INFRA0_INFRA(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BSEL, 2),
@@ -529,6 +529,7 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 	.gates_offs = CK_INFRA_GPT_STA,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
+	.gates = infracfg_gates,
 	.flags = CLK_INFRASYS,
 };
 
@@ -583,20 +584,9 @@ static const struct udevice_id mt7981_infracfg_compat[] = {
 	{}
 };
 
-static const struct udevice_id mt7981_infracfg_ao_compat[] = {
-	{ .compatible = "mediatek,mt7981-infracfg_ao" },
-	{}
-};
-
 static int mt7981_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7981_infracfg_clk_tree);
-}
-
-static int mt7981_infracfg_ao_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7981_infracfg_clk_tree,
-					infracfg_ao_gates);
+	return mtk_common_clk_infrasys_init(dev, &mt7981_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
@@ -609,16 +599,6 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
-	.name = "mt7981-clock-infracfg-ao",
-	.id = UCLASS_CLK,
-	.of_match = mt7981_infracfg_ao_compat,
-	.probe = mt7981_infracfg_ao_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 /* sgmiisys */
 static const struct mtk_gate_regs sgmii_cg_regs = {
 	.set_ofs = 0xe4,
-- 
2.45.2

