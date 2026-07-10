Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D1484BA1;
	Fri, 10 Jul 2026 20:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QiB0LbFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ACE84B9C; Fri, 10 Jul 2026 20:59:31 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F81184B77
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4472500e25fso669832fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709967; x=1784314767; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Nyzdy7fSae10axOGAvR71CujGmyxq2xkywhg1t+MhE=;
 b=QiB0LbFFn+orsgJDi7crbmQy7RCGOtof+ebOcAx5V+n1JVd3vFyh5temGKayriVGJ4
 9rtdRmmxa29S8i6ySf06kvZHrmj8ZaRcgjvgtFnNp30dVYAaL15/p4fWDLTSisT2djJa
 OpfS0FDTvbFIa9nZlDCYMbEOs3uZCGBR8h7g0nO1zUYv6qH2YOsQMGvW4qlveij4Wfw6
 X6M12WkyqibvStT0D/n7XYmXszAEUQPVtqGM/aaVxPvJSkq1RHTrCHDdDQneW+Cxvfj0
 vxOglUu5RvLWliKblO46G1CXcJa7LT8IbVBxbx+F9gzPwc6RFPaVWyt4FhjfZjBp+7eC
 Gg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709967; x=1784314767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Nyzdy7fSae10axOGAvR71CujGmyxq2xkywhg1t+MhE=;
 b=RRLBUUZq0MEwd91167YoyScXodwZAHH4d+/QalSX6nqVl0Eeawta0J4QOZgslgZsmM
 j7agFT8SlGmbhq2Fj0nqhJiEACm/Q8pVoathsTZc+Lm/Oz0SzzDeVqE61vhRh9pP9HDR
 RUou2GMltnTisTSJ2KFhuEdKeQdEj8p3PP3vqkmLHslIe5aLj4cnsNaxXKlrArAxMZ2f
 t1VlNp5FupOFKuqY64vLG66Uz50/A6wBVgEGYSJVs180svYm8dwhmVCD1wugjU9ZcyXg
 WXylE94vCst3K/uFl0qIBfC1B3zk/bfO4s7jRfRiNzvGrbyki+eRqKdtPCOXMOQ0aEtC
 Lr8g==
X-Gm-Message-State: AOJu0YxTxRVEaEGEcTUmEmaVfOipup/f7ixMgPLRR9z0cl1B6QuXFTTs
 H738y+p1/XAGRBUiqj/6iotxgvYfOnV2Y49a4yScBtWRIbvTK559Y2WD1fff9WIsjXSqAR7T69J
 acBFQ
X-Gm-Gg: AfdE7cny8iLX8BiunX0wfjxrVq06XBT082dNWWBUMMOa+S8mq5bBb2qnOSPreWe3cAa
 7oJpzvEDO8iiq8R5SQrcuFG8Z7fG1uX3axalbCZOk09zfEMMWavy0Hah6e0/NEF1PScWSH4iQdy
 OTIxAN37PTBHgm2AmI9WRyNeUjIbX6yIYnucj6EZBHujbD2Y5Vk/dHM8srMRFoj0DQKCA7uW4Ns
 bmgMRwg61tmjNelhYqClO+N/5pGCyVkPbpnpRm6p/sCilvrDPWpYvKlBxvml6Qj5NmroYWh3Om1
 HAj0/C2xH0CHh3koi1Xn3KP4+lAekoD50XRpHd/rFX/d8GgFg94696mM9l0DCLIwtBd/jbwX9NM
 bsLifv05TTidnaETpCpekcz+lc8B4JUWVn5Zplvte5X6/OZPNnXHb2DkNfYFCuJ66UGVtR97Lbj
 icZLwgBqfA3Vf34c1v
X-Received: by 2002:a05:6870:8449:b0:448:558c:d841 with SMTP id
 586e51a60fabf-451f142c8f8mr85093fac.38.1783709967052; 
 Fri, 10 Jul 2026 11:59:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:26 -0500
Subject: [PATCH v2 10/24] clk: mediaTek: mt8183: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-10-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ZnpS52gZqC9pdTVfBYzMCnB3ey8byroE8JoPAUYiw3I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCZXzUBfjyWlwavJWzZfiy5lZCUhOzHNCB02
 5jfvFoxXROJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAmRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZeQH/2tu7iaVO4vd78aH7XFyl8ptNENM71+LSmQ7nJO
 VaDttXHGV/lbRbtr3divF95kyTNBN+Bd3DXg0h5gd7/VCPbKhYAIjRuebnjVRSmQig839Cp+vni
 6FgWs0mTTqOQbGyewW1GVBQw4zFJbvm56Cv+bVZcmJCJwKEeaKFflFhe3LDFuHg/91PmGfUTe8L
 HigJqkNVkCwr3PkvrdTtpivord8irs/tTOxqeFG7Utd8IjSiIvoBisPXYOp4EnKz6SLg3I55q93
 taiWxKSSmtj6xFIbrtfCdeRMsFbMGZepD5p7SJ+okTWgxv6LUv8GSEzjxZoGIzADe5ugotdgtXM
 kYcg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add clock tree type flags to the mt8183 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 7b2d796bc6c..ea98b63d9f5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -604,20 +604,32 @@ static const struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
 };
 
-static const struct mtk_clk_tree mt8183_clk_tree = {
+static const struct mtk_clk_tree mt8183_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8183_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_CLK13M,
 	.muxes_offs = CLK_TOP_MUX_AXI,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt8183_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_gate_regs infra0_cg_regs = {
@@ -782,12 +794,12 @@ static const struct mtk_gate infra_clks[] = {
 
 static int mt8183_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8183_clk_tree);
+	return mtk_common_clk_init(dev, &mt8183_apmixed_clk_tree);
 }
 
 static int mt8183_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8183_clk_tree);
+	return mtk_common_clk_init(dev, &mt8183_topckgen_clk_tree);
 }
 
 static int mt8183_infracfg_probe(struct udevice *dev)
@@ -815,6 +827,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8183-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8183_apmixedsys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -825,6 +838,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8183-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8183_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

