Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44CFEDEBEB
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C42883F2D;
	Tue,  3 Mar 2026 20:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eab2TrUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3295C83F61; Tue,  3 Mar 2026 20:55:55 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B381383F75
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4638fe85a7eso2582546b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567751; x=1773172551;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2U4yFrETj7YOZZfTFlxwRTXo/V+HG+/VSRfCwhGywMw=;
 b=eab2TrUk/RASnWYXDp0qghP07nWKV+Yd8Hav3zRlMWB59Miz2d9eMLFU80Cs7vfvlP
 udoP/kCz08VEhxCfOimKxn+AYkNtnrg3Sl5lEgqb2QrdhwcpmlHm/aoZPZLWQUyQTVqI
 5FYfja2p24bXWnBYieLCsoTrz/EWbhqUnKny6aNUX3TPNnwX/s2FUksdDWb5JG9UH+Y6
 9pQc5pr5Cl5riNwesa6cRPb6Tfx7ki+FdrZzx90uxYM7gji/YNDb54LDRcOKMCvYlXTC
 DFi/8n3PcnsQF9OanKbJs74wwu5IDe1ahghk9A6caHG4W6uElZ9SIwAJeV6kwAPdoUgT
 +8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567751; x=1773172551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2U4yFrETj7YOZZfTFlxwRTXo/V+HG+/VSRfCwhGywMw=;
 b=s51tCvb10LVP6O2yAO1AWiDpn0Yy7WpGpHqx8kpg9iLE4RIbBbwuPphfYJTfcn/pN8
 NKySjqvIr/OQ/ZaEeYn3o58pOyMgtUrCPKWZGOh+UqUYP/olOMizM1LkZpDZ5Hcacw4o
 Vz21y0MpRuO9DNBFVqEsiYX7O8V9UdUahsg4JZs/hc31n+AIIYCcoL3JatChXkuG0zwf
 5Rzu+oOs4iqLwVlIjEPZqQHUpONh5SkjZqc2fnrkEzdIuJgRizHJ9C4NlBe4VEYfS1w+
 3ZSh/JVLDX8eNJWxNRyW7yerUgdvZ8i6yJDBrJy3TLvHKYAlmiRWFBk58vtJJfENWHtD
 JIRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCvJkxqtwn49BA9MeRrZdZRDJJo7S1C474PTzyNuYOuay4ZdVe9UPk7LRIheO/ZKfgDDjOhFs=@lists.denx.de
X-Gm-Message-State: AOJu0Yywx9/EkwR23Gkjc3zXBeon9nBHuGceSFF9NS+yfV2DQDdwUfd5
 P2hs54SrrBo1SZ+DweOcduKwel7pqDiVYykEbZIH3GbPz7TQETjzgaz5mkzYSCSgVcw=
X-Gm-Gg: ATEYQzyHqMR4lsn63Ph7TZK2Nj1f335Il6HHzhEc67Hl62KIoriJPZEggatMSMHczMH
 iJnhPJM3ncP8iMY6dUFwIPJp/BH3NNfUCAYxzTbv4Mj5lYg/5n0fX3pQEc6vm8iCoTgF0OfKJr+
 uu1h/JEDTNbfOmpr7D8xjQCUOkkPEympO19uYqoyuMrEEBJ3QcUVxjhc92oAJbYxblBTIZwYsR0
 +XO+pj21n+mAEisTpQEV0H8t67+R/JXtIG2IWV9FnhN0837xYNbtwNsaZtHbkBjvVLM2iWCMaFE
 ql279MBFcyKQHgvoQyrVOh4An1idBxu1yVfZGM9gcov6zrXUBtbTFgcpmrCOpdR7r8tuRLOlmvG
 dIUoaD0zJZUsD6s7JKc6IrdP2opj54xBNj9kEN6yCKlsSrd0ozYmJQ1FUHdsZsd2WUK4Srl4bMl
 Ap7fzjGoDvJca/6BrfsXhLXifAoee2
X-Received: by 2002:a05:6808:518e:b0:45e:6697:b7cd with SMTP id
 5614622812f47-464bea288a5mr8852712b6e.20.1772567751266; 
 Tue, 03 Mar 2026 11:55:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:51 -0600
Subject: [PATCH v4 3/7] clk: mediatek: add mtk_clk_id_is_* helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-3-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9976; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xnN7P6lF0HuTj3gyX4uOwNpmZooaaZFaGBrKaDqxBwE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzyjzndqbm6id3LmYtvao9GGcLMtPfTUE81dH
 jJB8hE6UgKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8oxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2JQH/RVNCl7K/RMtwtrO6rR/1PbcUy2JQA+ukmBUD+N
 KAtlQKC7Om30P//6vZe9e16ed8irJKQVkx05kTtgR7LEW+o1IpOnxNxJ0kEbhBOtXOrhRR8VgWT
 pDLN7Q9icM6QfbMraFBaXPenseK+CF9p9LBNGF0ofFc8Sy+6qxrwl4Pkhc67nQewidTsZHAaHw6
 WY7hHR5900KbPDxJIjIGq5aharZtJH50YciT49LDV4AXeq2/q6Dtv/uhXEH/WERI/u5h2pFA0rD
 keiOC4sHi+1CbcdLNy/CU1hiG3VwrkIEkAm9Ck1P+W9pN+3efu83z2qhcP/BBJHKypXTSCO9RA9
 sHGI=
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
index 921c3c0ff6a..7fbd10b8666 100644
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
 		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
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
 
 		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
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

