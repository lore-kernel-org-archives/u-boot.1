Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD250C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05AE8860B;
	Fri, 28 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ME8g0z1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9584B88214; Fri, 28 Jun 2024 19:41:48 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8CB8859A
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso10303431fa.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596504; x=1720201304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uST6yldPeHiVBwo5UeRkWuj9Qoj5pqkgfkio+1QApxs=;
 b=ME8g0z1Cn+mYnqjtX4vVZWpoIvss+7BqwYBAE1FsgbvFYfHAOeycsjt3kWpZKzyPv0
 jkR/eukil1jBLWoLMHOAfChVOxQ4TKdEDuOoY/ATIuDBcC5oTZY6vBOs8HmmXShhsuv1
 j1BJ8LC22K18qNUKoft+m+GMfMDlQkBn/rR4X8G6gvhBc+N2PcQ4bPF50SpuRhFqAg3m
 MzA+vwLGqH4E46eDP5pjw/55BKuzgTLZmhi0KJFNgBN8zb706g+mnm5FZyijMoP7kHM8
 Tdo6kSUg4Rz22v/pjl7BWVW4ao+LL5o4BtzbVMzaIXzCfV6hsrjfidESXmQppVT9hsx3
 ZkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596504; x=1720201304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uST6yldPeHiVBwo5UeRkWuj9Qoj5pqkgfkio+1QApxs=;
 b=tcl7yX6qKhtxh/H0xDyLwpxJlXgvjvO1WI3wlsuDQt0l2EjG3e4IwLfP9uRXmSSqve
 28tcFIsIoUfCPPRKDGfqTwSSkJ80gSe99Ua+GwVxFxSIopCvowkb7OF7zQqgtOiew71f
 n5lsGgkVsN0B74z8c8QT6gZNm681qhv+vqUMwKDf4vC0779mQqBIU/Zs5q59ekiFoFuv
 8X/eelkmHQs5U67gYEzmBXyJwbHz6gba7yTNSlqW07B9uUEYCesuklP4Nxw8vvoLA7Ih
 u4F7WJBevXV2gBZrUO49bduwryewPrlUb6BNuf6PD/3VjZZ6pqCBM+fwBtRER1heJpCY
 58Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpzl19eOl7KO030boKprxgtg6fma78jInnBp1TnNWAKp3KD4CwU4t/fU9ZAR4O0opLOfz3zcsOmMDd/Fa0hcWYSaCTA==
X-Gm-Message-State: AOJu0YxHPLu+plaZHMZ06AuK6RJo0vUOBwoCIaMrXVD6qmj0LCJV/+I1
 ZGoA1J/0eKx1v1odU3O4YcbmJAFrjSA4Xhq3cx4LLx95aaMgLTg7
X-Google-Smtp-Source: AGHT+IHpFayZqs4Z5zWyKJhNQ3pz2Bu5MF7A/bJfdATmjSEzbxBJ/R+BLu/5dvSPRGBOT1jCq+VNkA==
X-Received: by 2002:a2e:a902:0:b0:2ee:594d:f54b with SMTP id
 38308e7fff4ca-2ee594df8f6mr6993451fa.47.1719596503744; 
 Fri, 28 Jun 2024 10:41:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 09/12] clk: mediatek: add support for remapping clock ID
Date: Fri, 28 Jun 2024 19:40:54 +0200
Message-ID: <20240628174114.8675-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

Upstream kernel linux might have a different clock ID order in their
<soc>-clk.h header. This is the case of some clock ID for mt7623 that
upstream use the shared header clk-mt7601.h

This header doesn't have a well distincted order and have factor or mux
in the middle of the CLK ID list. This is problematic with the mtk clock
driver that expect everything well organized in block and apply offset
to reference the clk in the different array.

To solve this problem, implement in the mtk_clk_tree an additional
option .id_offs_map, an array where each CLK ID can be remapped to what
the driver expect permitting to reorganize the clock following the
expected logic of fixed, factor, mux and gates.

Each clock function is updated to tranparently handle this by first
converting the clk ID to the remapped one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 107 ++++++++++++++++++++++-----------
 drivers/clk/mediatek/clk-mtk.h |   8 +++
 2 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8a7a61d6740..096f593fc5c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -35,6 +35,18 @@
 
 /* shared functions */
 
+static int mtk_clk_get_id(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int id = clk->id;
+
+	/* Remap the clk ID to the one expected by driver */
+	if (priv->tree->id_offs_map)
+		id = priv->tree->id_offs_map[id];
+
+	return id;
+}
+
 /*
  * In case the rate change propagation to parent clocks is undesirable,
  * this function is recursively called to find the parent to calculate
@@ -134,9 +146,12 @@ static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
 static void mtk_pll_set_rate_regs(struct clk *clk, u32 pcw, int postdiv)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
+	const struct mtk_pll_data *pll;
+	int id = mtk_clk_get_id(clk);
 	u32 val, chg;
 
+	pll = &priv->tree->plls[id];
+
 	/* set postdiv */
 	val = readl(priv->base + pll->pd_reg);
 	val &= ~(POSTDIV_MASK << pll->pd_shift);
@@ -176,12 +191,16 @@ static void mtk_pll_calc_values(struct clk *clk, u32 *pcw, u32 *postdiv,
 				u32 freq)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
-	unsigned long fmin = pll->fmin ? pll->fmin : 1000 * MHZ;
+	const struct mtk_pll_data *pll;
+	int id = mtk_clk_get_id(clk);
+	unsigned long fmin;
 	u64 _pcw;
 	int ibits;
 	u32 val;
 
+	pll = &priv->tree->plls[id];
+	fmin = pll->fmin ? pll->fmin : 1000 * MHZ;
+
 	if (freq > pll->fmax)
 		freq = pll->fmax;
 
@@ -213,10 +232,13 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
+	const struct mtk_pll_data *pll;
+	int id = mtk_clk_get_id(clk);
 	u32 postdiv;
 	u32 pcw;
 
+	pll = &priv->tree->plls[id];
+
 	postdiv = (readl(priv->base + pll->pd_reg) >> pll->pd_shift) &
 		   POSTDIV_MASK;
 	postdiv = 1 << postdiv;
@@ -231,9 +253,12 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 static int mtk_apmixedsys_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
+	const struct mtk_pll_data *pll;
+	int id = mtk_clk_get_id(clk);
 	u32 r;
 
+	pll = &priv->tree->plls[id];
+
 	r = readl(priv->base + pll->pwr_reg) | CON0_PWR_ON;
 	writel(r, priv->base + pll->pwr_reg);
 	udelay(1);
@@ -260,9 +285,12 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 static int mtk_apmixedsys_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_pll_data *pll = &priv->tree->plls[clk->id];
+	const struct mtk_pll_data *pll;
+	int id = mtk_clk_get_id(clk);
 	u32 r;
 
+	pll = &priv->tree->plls[id];
+
 	if (pll->flags & HAVE_RST_BAR) {
 		r = readl(priv->base + pll->reg + REG_CON0);
 		r &= ~pll->rst_bar_mask;
@@ -423,38 +451,39 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 
-	if (clk->id < priv->tree->fdivs_offs)
-		return priv->tree->fclks[clk->id].rate;
-	else if (clk->id < priv->tree->muxes_offs)
-		return mtk_topckgen_get_factor_rate(clk, clk->id -
+	if (id < priv->tree->fdivs_offs)
+		return priv->tree->fclks[id].rate;
+	else if (id < priv->tree->muxes_offs)
+		return mtk_topckgen_get_factor_rate(clk, id -
 						    priv->tree->fdivs_offs);
 	else
-		return mtk_topckgen_get_mux_rate(clk, clk->id -
+		return mtk_topckgen_get_mux_rate(clk, id -
 						 priv->tree->muxes_offs);
 }
 
 static ulong mtk_infrasys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-
+	int id = mtk_clk_get_id(clk);
 	ulong rate;
 
-	if (clk->id < priv->tree->fdivs_offs) {
-		rate = priv->tree->fclks[clk->id].rate;
-	} else if (clk->id < priv->tree->muxes_offs) {
-		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
+	if (id < priv->tree->fdivs_offs) {
+		rate = priv->tree->fclks[id].rate;
+	} else if (id < priv->tree->muxes_offs) {
+		rate = mtk_infrasys_get_factor_rate(clk, id -
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
-	} else if (!priv->tree->gates || clk->id < priv->tree->gates_offs) {
-		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
+	} else if (!priv->tree->gates || id < priv->tree->gates_offs) {
+		rate = mtk_infrasys_get_mux_rate(clk, id -
 						 priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */
 	} else {
 		struct udevice *parent = NULL;
 		const struct mtk_gate *gate;
 
-		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
+		gate = &priv->tree->gates[id - priv->tree->gates_offs];
 		if (gate->flags & CLK_PARENT_TOPCKGEN)
 			parent = priv->parent;
 		/*
@@ -474,12 +503,13 @@ static int mtk_clk_mux_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux;
+	int id = mtk_clk_get_id(clk);
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (id < priv->tree->muxes_offs)
 		return 0;
 
-	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
+	mux = &priv->tree->muxes[id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
 
@@ -507,12 +537,13 @@ static int mtk_clk_mux_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux;
+	int id = mtk_clk_get_id(clk);
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (id < priv->tree->muxes_offs)
 		return 0;
 
-	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
+	mux = &priv->tree->muxes[id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
 
@@ -533,9 +564,10 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	u32 parent_type;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (id < priv->tree->muxes_offs)
 		return 0;
 
 	if (!parent_priv)
@@ -543,7 +575,7 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 
 	parent_type = parent_priv->tree->flags & CLK_PARENT_MASK;
 	return mtk_clk_mux_set_parent(priv->base, parent->id, parent_type,
-			&priv->tree->muxes[clk->id - priv->tree->muxes_offs]);
+			&priv->tree->muxes[id - priv->tree->muxes_offs]);
 }
 
 /* CG functions */
@@ -576,25 +608,27 @@ static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
 static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
 static int mtk_clk_infrasys_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!priv->tree->gates || id < priv->tree->gates_offs)
 		return mtk_clk_mux_enable(clk);
 
-	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->tree->gates[id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
@@ -626,25 +660,27 @@ static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
 static int mtk_clk_gate_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
 static int mtk_clk_infrasys_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!priv->tree->gates || id < priv->tree->gates_offs)
 		return mtk_clk_mux_disable(clk);
 
-	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->tree->gates[id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
@@ -652,12 +688,13 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	struct udevice *parent = priv->parent;
+	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (clk->id < priv->tree->gates_offs)
+	if (id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	gate = &priv->gates[id - priv->tree->gates_offs];
 	/*
 	 * With requesting a TOPCKGEN parent, make sure the dev parent
 	 * is actually topckgen. This might not be the case for an
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e9c8a52ce8f..c448ed024aa 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -235,6 +235,14 @@ struct mtk_gate {
 struct mtk_clk_tree {
 	unsigned long xtal_rate;
 	unsigned long xtal2_rate;
+	/*
+	 * Clock ID offset are remapped with an auxiliary table.
+	 * Enable this by defining .id_offs_map.
+	 * This is needed for upstream linux kernel <soc>-clk.h that
+	 * have mixed clk ID and doesn't have clear distinction between
+	 * ID for factor, mux and gates.
+	 */
+	const int *id_offs_map; /* optional, table clk.h to driver ID */
 	const int fdivs_offs;
 	const int muxes_offs;
 	const int gates_offs;
-- 
2.45.1

