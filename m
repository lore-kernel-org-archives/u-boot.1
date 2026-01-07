Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A903CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7544E840CC;
	Wed,  7 Jan 2026 17:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P6BUVWs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE52A83A2D; Wed,  7 Jan 2026 17:22:38 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C497E83AB0
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4503ee5c160so1422355b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802955; x=1768407755;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FYMNgVIOAr8aG7k6mxqnrjxI4rA2NYq6oiu648NtnMw=;
 b=P6BUVWs0E8l8pbLkEsqLtyHOKOu1SxKcUhdY2+PzpKxzjT6wOjqVJSO9Ftvk6E230a
 oANMAmEXI3Lm0Pz4Cu5Gxo6G+9M59BqYqm8nEqNw3B5vzxjtNIaTllVIPl51A1cWVJ6A
 A6X3etbVJhwiyd72CMslE1lRfljdbmrjSEF9rujcp3nM90CQRtVpqVEgbdmDXYvVUyHh
 ij7qIgi/MY2OC/8v/UQRIGd9c8W1CCDVY2KQ6UTcv5jJAdu4nz+MORrDgFW2LPbbk9LL
 AOX7wgZdw+D0EZo27VMXSGyOqEWETPlbou0SUySuzN4+UDp1qsYorZlFh73veANJ4lWk
 mCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802955; x=1768407755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FYMNgVIOAr8aG7k6mxqnrjxI4rA2NYq6oiu648NtnMw=;
 b=RK/ifSjGrBMWeuuqIv7WXExSqdwYfe1p3kJANPyumEmIncQHlYgKevscIdGvI8ArKE
 HTH8ELP3loslxuDrATBSEAQ9MxQ2/Xx6ewKoK+LBMIyyqE0ZQpuyQfgNgh4h32pyfJHP
 UYMi/vg6a8+4aJLwCzTtRtC7MKvuA0XlKQmdDMqmRqTEVROcx6mQxbdyY/srzUB6bUWe
 all2UzyuVmgJZtvEMv17JFnW/naSDl8JK5v440bpgwKpKNn6A3vB1G/1OIIQqPE498Fp
 nVFsfMYFNcUm05Pgi8D9pFJIG+y9yh5YanZMFT5LsEaG5T8TmxLHJyQZ+OKejSC+LMBu
 ZUCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8P3RLpDbgHFdyTaZPq6Mg+JqtWfsSdAXPYMWtBisuE5Inme/kOOf7z+SUsuO1KilcCkRKah0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2XqF8rX2kxBg+ntz3dm8/ZXDBkcU+Z1tME0//zNSD5Ph6ZFOB
 o7p1PHhVOIzDWkSJ5LK/9nNbOM8Ga0ls0Ce54gDSg406udCzzDbCKet8qPmT5mrMXdw=
X-Gm-Gg: AY/fxX6xk0UcBePYBxHnOy2/undZhkX71aMhjlrXwekHAmWbXaWKgiIZsHwgzMW4f/m
 Rhr+7M7sYOEaZJ9joJpfY/b8sSQ5EfWvlKg32ltZD7mYKxwinvrsyDW2lIxBZsUrtNVHuhPVPVX
 nknoG4oQUm5dpM8J1iZkkMCxnFhLMDbM4Pa41DIo/KWieAGJm8HcckAa3qwz1U4RluyHweg2iNK
 K5rumNqbR9qXQvfn1A3UIPc8/f0VesjKywzc8vWUS+byOpPdHjjBUbuNQg8zA2GLf32iPTn+e50
 bNIoAkjlQjipR3DS1rLQdNKQ079vLR6/MCMwF0DhHWQ14ffnkLUjIeB0WUmYHcDQYFriWdEjPbD
 Jj0UJUltJtEz3IkJ/X+CICUwKSqaDm21t6bbqPVz+bJI3m1+AURlj90aAq0b1Z5oEvSD8oNSQVW
 qqUQGSXKBUX3E5yRQ=
X-Google-Smtp-Source: AGHT+IF41gs3RuJt0yZMwPZcyFrtf3vHHIlSxrv9d1Es1Y5MsrNQYKymzNwvmKANNpLW2JiP8azh0g==
X-Received: by 2002:a05:6808:f0f:b0:43f:5c19:cabe with SMTP id
 5614622812f47-45a6bd3a1cbmr1248259b6e.24.1767802955459; 
 Wed, 07 Jan 2026 08:22:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:14 -0600
Subject: [PATCH v2 8/9] clk: mediatek: mt8365: remove separate topckgen-cg
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-8-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IE6nOUmJFckdMnAVgGL/Y1mwp3YR+wbmpxjJNXsYiZs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXog2DoeI4QPaB2ADRG5tAdEG9qHXn165AttZ2
 QlXjUKrRT+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6INhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Al8kH/1eD3YvmiVVN8a4ce5Sj5dsMuVhDBGpxPEOHQex
 ALTucYRdENorXQ2AlxELqt/oH+rdf6PoRu0MellDI6bXUyS0GFSJI+rqlzL/Wcq0s6jABGmnH+9
 KpAYskPjwLlqq9xZ4UP7fSd5YvPVehheexZTB2qsVOGz7QZYw4OequOvsGdi0Hh9UKnTNsYLyxl
 82xUiSnPzkjztHn6+J1rRlzw+An3l2gVlzgRQ0TKgt7uE2MJlfgHxIiHgWs5DNIliV8POPXNaiX
 NEsi4vZgSkS/aS2EXe8MvNFrocPmTmbW4l2NpFChAEdl8d7PV2qpKuwg1pgQWxHLrw7DpHUQZwp
 oeQo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

Remove the separate topckgen-cg driver for handling clock gates in the
topckgen address space. The devicetree bindings for this were not
acceptable upstream because it was creating a separate clock controller
using the same address space as the main topckgen clock controller. The
gates are moved to the topckgen tree instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 49 ++++++++++++---------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index eaa5c2cf0dc..a28547a0cf8 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -500,18 +500,6 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
 };
 
-static const struct mtk_clk_tree mt8365_topckgen_tree = {
-	.xtal_rate = 26 * MHZ,
-	.fdivs_offs = CLK_TOP_MFGPLL,
-	.muxes_offs = CLK_TOP_AXI_SEL,
-	.fclks = top_fixed_clks,
-	.fdivs = top_divs,
-	.muxes = top_muxes,
-	.num_fclks = ARRAY_SIZE(top_fixed_clks),
-	.num_fdivs = ARRAY_SIZE(top_divs),
-	.num_muxes = ARRAY_SIZE(top_muxes),
-};
-
 /* topckgen cg */
 static const struct mtk_gate_regs top0_cg_regs = {
 	.set_ofs = 0,
@@ -577,6 +565,21 @@ static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
 };
 
+static const struct mtk_clk_tree mt8365_topckgen_tree = {
+	.xtal_rate = 26 * MHZ,
+	.fdivs_offs = CLK_TOP_MFGPLL,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.gates_offs = CLK_TOP_AUD_I2S0_M,
+	.fclks = top_fixed_clks,
+	.fdivs = top_divs,
+	.muxes = top_muxes,
+	.gates = top_clk_gates,
+	.num_fclks = ARRAY_SIZE(top_fixed_clks),
+	.num_fdivs = ARRAY_SIZE(top_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
+	.num_gates = ARRAY_SIZE(top_clk_gates),
+};
+
 /* infracfg */
 static const struct mtk_gate_regs ifr2_cg_regs = {
 	.set_ofs = 0x80,
@@ -725,13 +728,6 @@ static int mt8365_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8365_topckgen_tree);
 }
 
-static int mt8365_topckgen_cg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8365_topckgen_tree, top_clk_gates,
-					ARRAY_SIZE(top_clk_gates),
-					CLK_TOP_AUD_I2S0_M);
-}
-
 static int mt8365_infracfg_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8365_infracfg_tree, ifr_clks,
@@ -748,11 +744,6 @@ static const struct udevice_id mt8365_topckgen_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt8365_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8365-topckgen-cg", },
-	{ }
-};
-
 static const struct udevice_id mt8365_infracfg_compat[] = {
 	{ .compatible = "mediatek,mt8365-infracfg", },
 	{ }
@@ -778,16 +769,6 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
-	.name = "mt8365-topckgen-cg",
-	.id = UCLASS_CLK,
-	.of_match = mt8365_topckgen_cg_compat,
-	.probe = mt8365_topckgen_cg_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt8365-infracfg",
 	.id = UCLASS_CLK,

-- 
2.43.0

