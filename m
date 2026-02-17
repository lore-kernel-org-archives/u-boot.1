Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B480E9A03B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA0D83E13;
	Wed, 18 Feb 2026 00:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GGNrkQAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADEF83D17; Wed, 18 Feb 2026 00:31:18 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C6583D17
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so1846639a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371074; x=1771975874;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=GGNrkQAjtRX2plM2IybC4gP9jNx+bayRQiKs+WnybTttDXNBQWrX7KwcuXEtw6T4yx
 10GL2CWzmZIDN+bnWEJ+Q9nRjcGGK51r0T1tb+fa6SewCGz5Oc1AaefVHW6dJRbwTerg
 qEaEmN1nOS5es/b1p2h1ypL1L7c+B7ibmk8aNiurSUxoc3vFNW/VMpmuUUbxS2Usni9Q
 wacg3yhWhImhxyvlWMjxx2ACKbpfC0ZZWpo0NNUWa4WJRV92orq+2oQIJTv/PwmUlz1R
 2BkswVgJm5qAf8QHElqkQmjCxC86DRIxCTiIrICKk6Xxtp0ySUV176Dln3xmXmojE90R
 e0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371074; x=1771975874;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=Ttu47MnTIKxrvduD+5hhmUdEDaqelmZ7FCnPYfH8IDPI3NiPQbN0uB7VoueR/DsYqE
 4lqHyFezcOrz4GjpinxDu7/o8MwQDs4ugXVjTXwg+pkFrgwUOUN/O7hVv0Fw8+0+bC6B
 4dblswnwLhxpZnsntYOpuIrtYq+M6/iY+d9TI6yoWCdsmvJkTT0tZZ+l4Ko/j841Zs/L
 tqLxdmQkVyl0JIDtrQDvuXAMEN4g7p9hjf++1rwj1Axfwe5Eoc23NCFGtOn6u0Rycwe0
 vX62sh+hXj86Q/AGpdKsPk/Rdt7fcPOig1+3+h7TSSOmy5x33gPZ9MZAlQlu8TLMnInm
 aT8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWBnyJ2j+zVsYtCmgQfaTIT7MnB96tN6zwzrZrirFRYdR0QSdCdo33Qp4xd3/kimL0lH0yb3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YykrQMC+Wn3Pkgy3KYmgay8vfjBGDimFik6zin3o1edLpAynfP/
 Tg0b7Bx2sI7o87qedEaFsKvUJs1wqaMFC09ZjG88Ocd2djpSAWN7IsAtD0n+mvzjkGk=
X-Gm-Gg: AZuq6aITanLYf5xSoGYzgeGGB6C+PMfRf0RncqSX0N+Bd0MbKWAXVer+u12vfXQCmeQ
 pYNgw7UokbO2yLxa0xOpfM3H3wfbbSW3nqH696jOxFbf8z53q6QG7NQ69baScHLNWLkbEzIYlIc
 ugkvXOTGy6DZYGcVTznwEe6KkmQDjv8Ph9n5EpcH+irB+44+rhsavOCvHE8IPWx3dzk9BOWnggy
 22JrDmwbg+e0g38bl6px1pvXkmb+NjilgI0xdB8X+jUMtHyvku6m68ByT9dJS624hB+YE7q4P5w
 ETlU8+yXQkBkLy6WD6564YOaoBHskThEAxTsNdrp55e/D3aPnJON+xRDUNH+2IkEylzyY6CjeAA
 qji3isw/H7FfpDjLewf77DQG9gNarRkC5rp9LA1s1c1hz1TReKEzAeaJZkIgz/aIudiH9eogPEg
 IXBOO5xrAdKOzzmZPNb9/hK9AoVg==
X-Received: by 2002:a05:6830:8554:10b0:7d4:ee07:e1b1 with SMTP id
 46e09a7af769-7d4ee07e2d2mr2713273a34.0.1771371074144; 
 Tue, 17 Feb 2026 15:31:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Feb 2026 17:30:10 -0600
Subject: [PATCH v2 3/7] clk: mediatek: add mtk_clk_id_is_* helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-mtk-mt8189-clocks-v2-3-cd381cd05251@baylibre.com>
References: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
In-Reply-To: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9958; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rQtZzGMOm61RptZkKnMBsoG1ARBDiNoGJZyL1uCk2Gs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPodvV3UPgpxexZbKOTpIbqQc47zWXRZm1ab/
 IoHAAX10guJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6HRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABFEH/3hNp+xolEhmrZUzW5iDUO0hU+DoQIxtu8Txp4A
 mklKjwwuxQnVBjNqAXAXW3AQqmWPIG1meWxJYzCopLFVwr/UrT9brMVwtULwuP8kuk/tK236IJb
 qBpE+8nK1DqsAZidnsuze1mnAE4+YHNY+Q68XerGDnaqlrfBigu/qY+vrt0zO1JuCkZl7dm+9P3
 fiZdRrqApdcWV/EL02Jjisu4Qzu+JnYvjkVXftOTXwxAcKjZ9n2B8tOuyT01L5MDlB8lsbYQP0Z
 LVrd6lYAUq5y0r+ThNGntcctNkbJSGia/petjReJRaa/R1Jo2rbLRF+L5KhgZKzNNzEFu9fFAYU
 x4QI=
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

Add helper functions to check if a clock ID corresponds to a particular
clock type (mux, gate, fdiv). This simplifies the code and makes it more
readable.

Additionally, it removes the restriction that fdivs_offs < muxes_offs <
gates_offs by making the checking more strict in some places. This will
allow future drivers to not have to define a mapping to meet this
requirement.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 128 ++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0123b0ce7b1..3bd9021b9cf 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -85,6 +85,34 @@ static int mtk_common_clk_get_unmapped_id(struct clk *clk)
 	return -ENOENT;
 }
 
+static bool mtk_clk_id_is_pll(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->plls && mapped_id < tree->num_plls;
+}
+
+static bool mtk_clk_id_is_fclk(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->fclks && mapped_id < tree->num_fclks;
+}
+
+static bool mtk_clk_id_is_fdiv(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->fdivs && mapped_id >= tree->fdivs_offs &&
+	       mapped_id < tree->fdivs_offs + tree->num_fdivs;
+}
+
+static bool mtk_clk_id_is_mux(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->muxes && mapped_id >= tree->muxes_offs &&
+	       mapped_id < tree->muxes_offs + tree->num_muxes;
+}
+
+static bool mtk_clk_id_is_gate(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->gates && mapped_id >= tree->gates_offs &&
+	       mapped_id < tree->gates_offs + tree->num_gates;
+}
+
 static int mtk_dummy_enable(struct clk *clk)
 {
 	return 0;
@@ -375,15 +403,10 @@ static const int mtk_apmixedsys_of_xlate(struct clk *clk,
 		return ret;
 
 	/* apmixedsys only uses plls and gates. */
+	if (!mtk_clk_id_is_pll(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->plls && clk->id < tree->num_plls)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
@@ -497,7 +520,7 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 	u32 pcw = 0;
 	u32 postdiv;
 
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs)
+	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
 		return -EINVAL;
 
 	mtk_pll_calc_values(priv, clk->id, &pcw, &postdiv, rate);
@@ -515,7 +538,7 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	u32 pcw;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
 	}
@@ -541,7 +564,7 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_enable(priv->base, gate);
 	}
@@ -579,7 +602,7 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_disable(priv->base, gate);
 	}
@@ -649,23 +672,11 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 		return ret;
 
 	/* topckgen only uses fclks, fdivs, muxes and gates. */
+	if (!mtk_clk_id_is_fclk(tree, clk->id) && !mtk_clk_id_is_fdiv(tree, clk->id) &&
+	    !mtk_clk_id_is_mux(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->fclks && clk->id < tree->num_fclks)
-		return 0;
-
-	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
-	    clk->id < tree->fdivs_offs + tree->num_fdivs)
-		return 0;
-
-	if (tree->muxes && clk->id >= tree->muxes_offs &&
-	    clk->id < tree->muxes_offs + tree->num_muxes)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
@@ -723,21 +734,22 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_fclk(tree, clk->id))
+		return tree->fclks[clk->id].rate;
+
+	if (mtk_clk_id_is_fdiv(tree, clk->id))
+		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
+
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_topckgen_get_mux_rate(clk, clk->id - tree->muxes_offs);
+
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
 	}
 
-	if (clk->id < priv->tree->fdivs_offs)
-		return priv->tree->fclks[clk->id].rate;
-	else if (clk->id < priv->tree->muxes_offs)
-		return mtk_topckgen_get_factor_rate(clk, clk->id -
-						    priv->tree->fdivs_offs);
-	else
-		return mtk_topckgen_get_mux_rate(clk, clk->id -
-						 priv->tree->muxes_offs);
+	return -ENOENT;
 }
 
 static int mtk_clk_mux_enable(struct clk *clk)
@@ -746,7 +758,7 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
@@ -778,8 +790,7 @@ static int mtk_topckgen_enable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_gate_enable(priv->base, gate);
@@ -794,7 +805,7 @@ static int mtk_clk_mux_disable(struct clk *clk)
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
@@ -819,8 +830,7 @@ static int mtk_topckgen_disable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_gate_disable(priv->base, gate);
@@ -836,8 +846,7 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 	int parent_unmapped_id;
 	u32 parent_type;
 
-	if (!priv->tree->muxes || clk->id < priv->tree->muxes_offs ||
-	    clk->id >= priv->tree->muxes_offs + priv->tree->num_muxes)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	if (!parent_priv)
@@ -917,20 +926,11 @@ static const int mtk_infrasys_of_xlate(struct clk *clk,
 		return ret;
 
 	/* ifrasys only uses fdivs, muxes and gates. */
+	if (!mtk_clk_id_is_fdiv(tree, clk->id) && !mtk_clk_id_is_mux(tree, clk->id) &&
+	    !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
-	    clk->id < tree->fdivs_offs + tree->num_fdivs)
-		return 0;
-
-	if (tree->muxes && clk->id >= tree->muxes_offs &&
-	    clk->id < tree->muxes_offs + tree->num_muxes)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static int mtk_clk_infrasys_enable(struct clk *clk)
@@ -939,7 +939,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
 		return mtk_clk_mux_enable(clk);
 
 	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
@@ -952,7 +952,7 @@ static int mtk_clk_infrasys_disable(struct clk *clk)
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
 		return mtk_clk_mux_disable(clk);
 
 	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
@@ -1004,13 +1004,13 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong rate;
 
-	if (clk->id < priv->tree->fdivs_offs) {
+	if (mtk_clk_id_is_fclk(priv->tree, clk->id)) {
 		rate = priv->tree->fclks[clk->id].rate;
-	} else if (clk->id < priv->tree->muxes_offs) {
+	} else if (mtk_clk_id_is_fdiv(priv->tree, clk->id)) {
 		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
-	} else if (!priv->tree->gates || clk->id < priv->tree->gates_offs) {
+	} else if (!mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
 						 priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */

-- 
2.43.0

