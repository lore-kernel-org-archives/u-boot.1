Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487A5C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F02288C9C;
	Sat,  3 Aug 2024 13:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+xnQyiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323F688C9F; Sat,  3 Aug 2024 13:10:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8198488C9E
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so50527f8f.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683453; x=1723288253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dpgcve2O81E2guPda7mh8YQvzad/bM/Bw7a2C/Wbf8c=;
 b=j+xnQyivwMYz7HalwXpZhxYVyZGJtcOgfUYbKpxhGcudP+1ts3TGYzMk/29D+c4B73
 9uzbaP8bD10mNAqqdywvbz3ui93Yl+4dHJq1lOEgCihZr5WVg7ZkeJAftxxC/aqDDfm6
 n+DBwvRzFOhUthBfGzXJIyxlIqz+ZpkzBgIUw3+8lp9HqPIuMx840NMW9jcN9Tiy8cDh
 jCTjf/Qjm7Ff2qUF8z4UETQqtQ3a6GRLO1n8kAjD0SKD+7LjiCuQGVWrP/gTbL2Mvsdx
 dtlQECr3gp6103h3mur54ytTsaZphMr/zWvIBgFLyClbJxdsqJAzR4FUsF52N9whwErU
 bPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683453; x=1723288253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpgcve2O81E2guPda7mh8YQvzad/bM/Bw7a2C/Wbf8c=;
 b=WXcsjgy3RENudPJvVXFPB7KJDJfrvVx1WxLIAZVnRBMKyDxnl2flCyJgKwoWhj6/f6
 lRbO3FC61b35Ma+SJeZrjWn0LUF3MYyN59bRPBcKr4ymmtToQ0XdN2dW99ZEdeOfJAhj
 FENsGm4uNlh1+VNfnSN47WPbHTZZt12l1hwiG19qJwfJYMLJsNDF+rzzjieG34xKw7Q9
 xg2I1D9t5BiThf8m5Biaged03a4cyS4KKMod6nxD4nkI0szvbT9/TzHq+GTUp97yA4KB
 RsAxNG6xd/ssydiaQHXVUoz9qQ9nEIzl5dlzJBmeH1wQzezGPfz90fnOUdiTX2ABSt2P
 zpxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj270KgfblZEMJJCM/hwmu7gcj+68npA4QVj2waLLe7JC2kdMI2iFb6sHKdu4LKfR3TAtg5iFtxNtiQYuN+dKzXe0atw==
X-Gm-Message-State: AOJu0Ywek4bvjD9vEVwRCfQYNvAcUMxNFgM/jIyWJP9LLq3kk1ZTbwv2
 1rc9BAyDUuL1t7f1rqFuOkL8KJYRXjr6zE/bp5DZa5WuFnUzKv1Jc0QkEA==
X-Google-Smtp-Source: AGHT+IFNMZMzG5Ehr3ng/w8LgLl/+urwHkXghpEtKd5r+r/kfOLD6AK0PaChl4VzQkNbqP2wt5qrEw==
X-Received: by 2002:adf:f14b:0:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-36bbc0a77cdmr4060712f8f.6.1722683452768; 
 Sat, 03 Aug 2024 04:10:52 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 14/15] clk: mediatek: mt7986: convert to unified infracfg
 gates + muxes
Date: Sat,  3 Aug 2024 10:40:47 +0200
Message-ID: <20240803084050.449-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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
 arch/arm/dts/mt7986.dtsi          | 31 ++++++++++++-------------------
 drivers/clk/mediatek/clk-mt7986.c | 26 +++-----------------------
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index 187e1298fae..a44f5386390 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -115,13 +115,6 @@
 		#clock-cells = <1>;
 	};
 
-	infracfg_ao: infracfg_ao@10001000 {
-		compatible = "mediatek,mt7986-infracfg_ao";
-		reg = <0x10001000 0x68>;
-		clock-parent = <&infracfg>;
-		#clock-cells = <1>;
-	};
-
 	infracfg: infracfg@10001040 {
 		compatible = "mediatek,mt7986-infracfg";
 		reg = <0x10001000 0x1000>;
@@ -155,9 +148,9 @@
 		#pwm-cells = <2>;
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&topckgen CK_TOP_PWM_SEL>,
-			 <&infracfg_ao CK_INFRA_PWM_BSEL>,
-			 <&infracfg_ao CK_INFRA_PWM1_CK>,
-			 <&infracfg_ao CK_INFRA_PWM2_CK>;
+			 <&infracfg CK_INFRA_PWM_BSEL>,
+			 <&infracfg CK_INFRA_PWM1_CK>,
+			 <&infracfg CK_INFRA_PWM2_CK>;
 		assigned-clocks = <&topckgen CK_TOP_PWM_SEL>,
 				  <&infracfg CK_INFRA_PWM_BSEL>,
 				  <&infracfg CK_INFRA_PWM1_SEL>,
@@ -175,9 +168,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11002000 0x400>;
 		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART0_CK>;
+		clocks = <&infracfg CK_INFRA_UART0_CK>;
 		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg_ao CK_INFRA_UART0_SEL>;
+				  <&infracfg CK_INFRA_UART0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
 					 <&topckgen CK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
@@ -189,7 +182,7 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11003000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART1_CK>;
+		clocks = <&infracfg CK_INFRA_UART1_CK>;
 		assigned-clocks = <&infracfg CK_INFRA_UART1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
@@ -200,7 +193,7 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11004000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg_ao CK_INFRA_UART2_CK>;
+		clocks = <&infracfg CK_INFRA_UART2_CK>;
 		assigned-clocks = <&infracfg CK_INFRA_UART2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
@@ -212,9 +205,9 @@
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
@@ -258,7 +251,7 @@
 	spi0: spi@1100a000 {
 		compatible = "mediatek,ipm-spi";
 		reg = <0x1100a000 0x100>;
-		clocks = <&infracfg_ao CK_INFRA_SPI0_CK>,
+		clocks = <&infracfg CK_INFRA_SPI0_CK>,
 			 <&topckgen CK_TOP_SPI_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI0_SEL>;
@@ -283,7 +276,7 @@
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
 			<&topckgen CK_TOP_EMMC_250M_SEL>,
-			<&infracfg_ao CK_INFRA_MSDC_CK>;
+			<&infracfg CK_INFRA_MSDC_CK>;
 		assigned-clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
 				  <&topckgen CK_TOP_EMMC_250M_SEL>;
 		assigned-clock-parents = <&fixed_plls CK_APMIXED_MPLL>,
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 59b82ca7de1..b163ffc9f1a 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -448,7 +448,7 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
 
 /* INFRA GATE */
 
-static const struct mtk_gate infracfg_ao_gates[] = {
+static const struct mtk_gate infracfg_gates[] = {
 	/* INFRA0 */
 	GATE_INFRA0_INFRA(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_SYSAXI_D2, 0),
 	GATE_INFRA0_INFRA(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_SYSAXI_D2, 1),
@@ -536,6 +536,7 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.gates_offs = CK_INFRA_GPT_STA,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
+	.gates = infracfg_gates,
 	.flags = CLK_INFRASYS,
 };
 
@@ -590,20 +591,9 @@ static const struct udevice_id mt7986_infracfg_compat[] = {
 	{}
 };
 
-static const struct udevice_id mt7986_infracfg_ao_compat[] = {
-	{ .compatible = "mediatek,mt7986-infracfg_ao" },
-	{}
-};
-
 static int mt7986_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7986_infracfg_clk_tree);
-}
-
-static int mt7986_infracfg_ao_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7986_infracfg_clk_tree,
-					infracfg_ao_gates);
+	return mtk_common_clk_infrasys_init(dev, &mt7986_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
@@ -616,16 +606,6 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
-	.name = "mt7986-clock-infracfg-ao",
-	.id = UCLASS_CLK,
-	.of_match = mt7986_infracfg_ao_compat,
-	.probe = mt7986_infracfg_ao_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 /* ethsys */
 static const struct mtk_gate_regs eth_cg_regs = {
 	.sta_ofs = 0x30,
-- 
2.45.2

