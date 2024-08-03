Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F1C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E480E88BF2;
	Sat,  3 Aug 2024 10:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJm9N0GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4A688C6C; Sat,  3 Aug 2024 10:33:39 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8774988C72
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52efc89dbedso11057346e87.3
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674017; x=1723278817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AKqLqgzgVXofcZZII8t6I+Ub2iIWjm7+jWCw/j0rABY=;
 b=VJm9N0GE2fZZGTUh0MSCfMC1Z+Ur8ZJVailX+hEX3b4I8HQUD01EG/l+0Qhwqg0t59
 0ccvqrZySqrHDgSTxyuLgCpqUvwUAx8roOAG4DEQAgqjGnkWHo62Dlyu1kgUI0saXoVW
 x/zD4oKCXPVtpd6fVyAv+d7TmX/54rIIfnGjt9VSdBAs9dm4AZyUAm6v9ed+UIvrlP5n
 Glv/D8KDuKpkiz3/1BPCMee3lslLPQ9Cs3tSxXFfRxT5cqYgLGQiRSSsIR+Mh22jtq4s
 uhIvoBj/IeqVDcGKs2hAp2h4U1uy4XlKckzYZ13bjcylFdRnz+vBqz506yBi+aUjDTs4
 0lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674017; x=1723278817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKqLqgzgVXofcZZII8t6I+Ub2iIWjm7+jWCw/j0rABY=;
 b=uAF8CC5nLyr1hmOuRdA1fZY2TXdB1k24Yqu5bAGtNuYNKOT761wFGkeYRdPBX+CNOV
 IUXXOGAmswoR94MccnT923LzwscpQgOJBei18I2zVmZYyapdlWNoW0wI8nSgl2iRQvk0
 z33B8FV7lWDiqtOxyjtNw4/fOyeaQfeXK7XbW7RzqzlN5X4EG7iO3TXbdlmvWqnimxCB
 7PY3Sfg4vx1eLUftZJDUeksjyLNso/5Cenoy6mYnLz5YFnRF4FDF6+FGq8D4lYlClof2
 uXfrJk7xjTLWPY2FxsZuFi+Pd+7xPS5pX0dCeUExxP0nDmZnOwBkMkDeXZoteZ4RFTWc
 JTtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx6XF5nFgoFQnoGCNIyMVlHKe+XGf+zHs/y9pZxjCTvnaiqfiGp9G7MvYTY1sBxaSvkcsL0YXxOaOoixwbn/Yl5AQZKQ==
X-Gm-Message-State: AOJu0Ywi+TTg+RJb8fkix2Zo2op6tHg0mLnDDLNIcqJmT9dZn0P2k9Xv
 eWDi4STzOdnZh4kHMb7kUU3jFoJzKQls9+u0cR3ZBFiYau+48S++
X-Google-Smtp-Source: AGHT+IGa7SQ0687iQZdkiue8n+pt1/kx8gqjUrA1LF2muQ150vzPkM9tDa8p/8Ob+isAek0J/OWFOQ==
X-Received: by 2002:a05:6512:128f:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-530bb374350mr3608939e87.20.1722674016491; 
 Sat, 03 Aug 2024 01:33:36 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 12/13] clk: mediatek: mt7988: convert to unified infracfg
 gates + muxes
Date: Sat,  3 Aug 2024 10:33:01 +0200
Message-ID: <20240803083305.30697-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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
 arch/arm/dts/mt7988.dtsi          | 67 ++++++++++++++-----------------
 drivers/clk/mediatek/clk-mt7988.c | 24 +----------
 2 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 10d5c2a33c3..4695e1db1ad 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -97,13 +97,6 @@
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	infracfg_ao_cgs: infracfg_ao_cgs@10001000 {
-		compatible = "mediatek,mt7988-infracfg_ao_cgs", "syscon";
-		reg = <0 0x10001000 0 0x1000>;
-		clock-parent = <&infracfg_ao>;
-		#clock-cells = <1>;
-	};
-
 	apmixedsys: apmixedsys@1001e000 {
 		compatible = "mediatek,mt7988-fixed-plls", "syscon";
 		reg = <0 0x1001e000 0 0x1000>;
@@ -251,7 +244,7 @@
 		#clock-cells = <1>;
 	};
 
-	infracfg_ao: infracfg@10001000 {
+	infracfg: infracfg@10001000 {
 		compatible = "mediatek,mt7988-infracfg", "syscon";
 		reg = <0 0x10001000 0 0x1000>;
 		clock-parent = <&topckgen>;
@@ -262,9 +255,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0 0x11000000 0 0x100>;
 		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART0_CK>;
+		clocks = <&infracfg CK_INFRA_52M_UART0_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_MUX_UART0_SEL>;
+				  <&infracfg CK_INFRA_MUX_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
@@ -274,9 +267,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0 0x11000100 0 0x100>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART1_CK>;
+		clocks = <&infracfg CK_INFRA_52M_UART1_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_MUX_UART1_SEL>;
+				  <&infracfg CK_INFRA_MUX_UART1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
@@ -286,9 +279,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0 0x11000200 0 0x100>;
 		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao_cgs CK_INFRA_52M_UART2_CK>;
+		clocks = <&infracfg CK_INFRA_52M_UART2_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_MUX_UART2_SEL>;
+				  <&infracfg CK_INFRA_MUX_UART2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		status = "disabled";
@@ -301,8 +294,8 @@
 		      <0 0x10217080 0 0x80>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		clock-div = <1>;
-		clocks = <&infracfg_ao CK_INFRA_I2C_BCK>,
-			 <&infracfg_ao CK_INFRA_66M_AP_DMA_BCK>;
+		clocks = <&infracfg CK_INFRA_I2C_BCK>,
+			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
 		clock-names = "main", "dma";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -316,8 +309,8 @@
 		      <0 0x10217100 0 0x80>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clock-div = <1>;
-		clocks = <&infracfg_ao CK_INFRA_I2C_BCK>,
-			 <&infracfg_ao CK_INFRA_66M_AP_DMA_BCK>;
+		clocks = <&infracfg CK_INFRA_I2C_BCK>,
+			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
 		clock-names = "main", "dma";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -331,8 +324,8 @@
 		      <0 0x10217180 0 0x80>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clock-div = <1>;
-		clocks = <&infracfg_ao CK_INFRA_I2C_BCK>,
-			 <&infracfg_ao CK_INFRA_66M_AP_DMA_BCK>;
+		clocks = <&infracfg CK_INFRA_I2C_BCK>,
+			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
 		clock-names = "main", "dma";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -343,16 +336,16 @@
 		compatible = "mediatek,mt7988-pwm";
 		reg = <0 0x10048000 0 0x1000>;
 		#pwm-cells = <2>;
-		clocks = <&infracfg_ao CK_INFRA_66M_PWM_BCK>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_HCK>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK1>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK2>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK3>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK4>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK5>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK6>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK7>,
-			 <&infracfg_ao CK_INFRA_66M_PWM_CK8>;
+		clocks = <&infracfg CK_INFRA_66M_PWM_BCK>,
+			 <&infracfg CK_INFRA_66M_PWM_HCK>,
+			 <&infracfg CK_INFRA_66M_PWM_CK1>,
+			 <&infracfg CK_INFRA_66M_PWM_CK2>,
+			 <&infracfg CK_INFRA_66M_PWM_CK3>,
+			 <&infracfg CK_INFRA_66M_PWM_CK4>,
+			 <&infracfg CK_INFRA_66M_PWM_CK5>,
+			 <&infracfg CK_INFRA_66M_PWM_CK6>,
+			 <&infracfg CK_INFRA_66M_PWM_CK7>,
+			 <&infracfg CK_INFRA_66M_PWM_CK8>;
 		clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
 			      "pwm4","pwm5","pwm6","pwm7","pwm8";
 		status = "disabled";
@@ -365,9 +358,9 @@
 		      <0 0x11002000 0 0x1000>;
 		reg-names = "nfi", "ecc";
 		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_SPINFI>,
-			 <&infracfg_ao CK_INFRA_NFI>,
-			 <&infracfg_ao CK_INFRA_66M_NFI_HCK>;
+		clocks = <&infracfg CK_INFRA_SPINFI>,
+			 <&infracfg CK_INFRA_NFI>,
+			 <&infracfg CK_INFRA_66M_NFI_HCK>;
 		clock-names = "pad_clk", "nfi_clk", "nfi_hclk";
 		assigned-clocks = <&topckgen CK_TOP_SPINFI_SEL>,
 				  <&topckgen CK_TOP_NFI1X_SEL>;
@@ -408,10 +401,10 @@
 			     "mediatek,mt7986-mmc";
 		reg = <0 0x11230000 0 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao_cgs CK_INFRA_MSDC400>,
-			 <&infracfg_ao_cgs CK_INFRA_MSDC2_HCK>,
-			 <&infracfg_ao_cgs CK_INFRA_133M_MSDC_0_HCK>,
-			 <&infracfg_ao_cgs CK_INFRA_66M_MSDC_0_HCK>;
+		clocks = <&infracfg CK_INFRA_MSDC400>,
+			 <&infracfg CK_INFRA_MSDC2_HCK>,
+			 <&infracfg CK_INFRA_133M_MSDC_0_HCK>,
+			 <&infracfg CK_INFRA_66M_MSDC_0_HCK>;
 		clock-names = "source", "hclk", "source_cg", "axi_cg";
 		status = "disabled";
 	};
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 7ef03941e24..a8d278816bb 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -790,6 +790,7 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.muxes_offs = CK_INFRA_MUX_UART0_SEL,
 	.gates_offs = CK_INFRA_PCIE_PERI_26M_CK_P0,
 	.muxes = infracfg_mtk_mux,
+	.gates = infracfg_mtk_gates,
 	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
 };
@@ -847,20 +848,9 @@ static const struct udevice_id mt7988_infracfg_compat[] = {
 	{}
 };
 
-static const struct udevice_id mt7988_infracfg_ao_cgs_compat[] = {
-	{ .compatible = "mediatek,mt7988-infracfg_ao_cgs" },
-	{}
-};
-
 static int mt7988_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7988_infracfg_clk_tree);
-}
-
-static int mt7988_infracfg_ao_cgs_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_infracfg_clk_tree,
-					infracfg_mtk_gates);
+	return mtk_common_clk_infrasys_init(dev, &mt7988_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
@@ -873,16 +863,6 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg_ao_cgs) = {
-	.name = "mt7988-clock-infracfg_ao_cgs",
-	.id = UCLASS_CLK,
-	.of_match = mt7988_infracfg_ao_cgs_compat,
-	.probe = mt7988_infracfg_ao_cgs_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 /* ETHDMA */
 
 static const struct mtk_gate_regs ethdma_cg_regs = {
-- 
2.45.2

