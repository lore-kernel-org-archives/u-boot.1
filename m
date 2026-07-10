Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A17AC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF9B84AE2;
	Fri, 10 Jul 2026 20:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZywbNue8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CED284AFF; Fri, 10 Jul 2026 20:59:22 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5482684B42
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a17e36fa79so495928eaf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709959; x=1784314759; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwAh8M+76MygHVdlxvCJGda+hrta0nKAEp2nzGZHoTo=;
 b=ZywbNue8+zgHKwsv+Uh4hKCN0zjMhpAlCUmqjUUQHNko0JhHBcNJ1Cty0L3CgO3sl6
 h6LCzAlCQ4ehX9Kzg0CwddB7T3uryWgMnkPJCjBjYXXFwGUurB7T4/XTBIupODAjKP4R
 omyxpC+oHjNqGoBUA4AIkqRCQLkTI+KdtEnjQ7rbqcipMXQZ3khBRGqKn2u3agqCadye
 whl9arWiuGuIl2MLq8+ZpHFFPgC2lwMc7RD+P33ckoxAvFWIKWPPoeltCPQ7lXBpoOQQ
 xkOS/vg1WvKOV7xgSev1+ewWmvw2QWdul/ln27ZI3YiVyYs6URwP6hZWo7UWZuwoW0zJ
 p8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709959; x=1784314759;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jwAh8M+76MygHVdlxvCJGda+hrta0nKAEp2nzGZHoTo=;
 b=n//ql7ueI9pqvLLYU/sVWMCoSeDekEHWL9AYXunCyj3ViW3xrCeaIyGjLVD1o9QgvM
 dHjE5GaX1YgvlcfbwetUBw0v6nQwIoTPYOyHgHNF2G3XHFYS5qWMg36g4ikudtWoIfEk
 45Ing7slzpeG1vvxzAFjB0ZvvA+0w5IaERHKBdEYyhKiI9IBbsSR/AYZ5u9H04Ba71b1
 Nn5xe+aT4jS02mJngILC+VttHbX+VaxyV3aWmX624cHo9iXc4CPy431EiLROLkO1kS+q
 iE7GVgkX6I7qtAlW58SooAcMhplkekJIm/zU+QtazwUt35RJormtAQqmxuP8sppPuS3k
 42gw==
X-Gm-Message-State: AOJu0YxTdKieXGKNQYhHZ836hDD8igQsS/tZqKzgpOHpBF8hEWf51hTN
 btSyzyfdF6ShBRvGXUNQX/qkBZdkLm1sVElY4bqeYO4PdOiqZW03o/8gJYwFlV4oXeowv+YArY+
 mASDh
X-Gm-Gg: AfdE7cnYFFBQv8JCDCNd/4rHjI9NJ7j+d+wsGtTuwDnZZsmdwlITKFINxHDTxczxVwP
 RvSlYFMdCHNQF9EBv+xdfv5kYWyluh0wbvmDNaJK2D0zi2pNNwcWl2pTX6cxs+w2IGzOTaIkWfY
 a2FcIlZcTTxEtAoD4nzFpdXhmoyiTeYxvLneU2MKURrCeznilpbbkYIsrSOD2LvnqjqzLvsyTRN
 JGwHVmbQvXvTsHZKfWFG938h6Nbbibpxj9O+kfWg8jOKBm1uLno6WFywjhRNNHyZm05jBVB4UER
 5Kg3PQqEX/rFhgof5RM1dQUe66R3FbP0VrO0Gb6xZJQdfSYPrR45a1TmFpxp2ZYRKFtcZ8p8i6R
 1MLAHoCzH9QyF1ixHhDNVpbrZhUzAEL8wx03jeVJvOr6vxbLiJGlp6qwyUCaWv0zQ401yZgT4yT
 57HhCMXTe53kD3jLCj
X-Received: by 2002:a05:6820:613:b0:6a3:7c8b:a6f2 with SMTP id
 006d021491bc7-6a39a6d295fmr310836eaf.45.1783709959087; 
 Fri, 10 Jul 2026 11:59:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:21 -0500
Subject: [PATCH v2 05/24] clk: mediaTek: mt7629: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-5-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9Fo4mawP08fLobBtXURoId7JaGhAcvWL7RHR276V3lY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUB5yptOnUEupH0s1V3uXEeXLrUDu/t9P5t1D
 Hi238iMcluJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAeRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAkwH/33EzFo9Y9bGPBYC6hvukoD9QBpjNtzNLSg2iW7
 Bx1NOpXWMIxAi4+N/MELSjj+RL/9qFPtDCfHfzc6rNCIUSIJxslHrh99evxmJ2dXRAvyhsDZDuR
 y1Qb872hLnNkcMbCqL3S0n4hlEGAsK0udCxpuXEaOc2xw8exHtNOkWsdxAY31jVciOg0sW127Yc
 AlmJLTpphiyLplk6oP8ojSfA85N35xmzuXLCUcPu+4HvnLqmZTou8FQELEm5gPZfTiYVQ7N3H8j
 CXlbmD3UDkQ+a7UPXy2nBPrx6B5WKulxFp+MbS9ZW7tb8z8EKsxws5l2Om0jBZynaKSjGAktrmA
 8RIw=
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

Add clock tree type flags to the mt7629 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 74510ee36a9..903e9d8ec81 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -575,20 +575,32 @@ static const struct mtk_gate ssusb_cgs[] = {
 	GATE_SSUSB(CLK_SSUSB_DMA_EN, CLK_TOP_TO_USB3_DMA, 8),
 };
 
-static const struct mtk_clk_tree mt7629_clk_tree = {
+static const struct mtk_clk_tree mt7629_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt7629_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
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
+static const struct mtk_clk_tree mt7629_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
@@ -628,7 +640,7 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7629_clk_tree);
+	ret = mtk_common_clk_init(dev, &mt7629_apmixed_clk_tree);
 	if (ret)
 		return ret;
 
@@ -642,7 +654,7 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 
 static int mt7629_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7629_clk_tree);
+	return mtk_common_clk_init(dev, &mt7629_topckgen_clk_tree);
 }
 
 static int mt7629_infracfg_probe(struct udevice *dev)
@@ -740,6 +752,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7629-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7629_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -750,6 +763,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7629-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7629_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

