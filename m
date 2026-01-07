Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F4FCFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8377D8407E;
	Wed,  7 Jan 2026 17:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NJ6qPzId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39E384064; Wed,  7 Jan 2026 16:51:32 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EAD83A47
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-459a258561cso660966b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801088; x=1768405888;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PJIEtUrzYPdTVro0VChXJhARniz5iWReiuBTRxJGLqw=;
 b=NJ6qPzIdIK0LVYo8T/LnrA3XibzdCRoTwnnrUOZ7uIi7tLsRP3SLEGMoZ3YPPHLWyS
 Q7+KrMjAJMoJexTI1gkSHO8bbe1iD8548WTtXo3haxkuTux+xlZ4q+dKldg42f9mQSPx
 HyDB7mczVJb4f9G2CbeFqBet67grQDPwKGMwv7C//QJ0Im2LcFwocAQiq0cMtH4NLHoQ
 9QV8wa7v5UoLCtUGe7ZWmCT91DH4wbeThxLOk7FcVmbzWyP13iG5xCJCtGEDUmCF7xkV
 tglKhc3Rsi+oOROvQyM3vkvIv9+r7toHY64Iuz+VoP1CGGcM5x2Vm0MaaLoz0ONLaP84
 I1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801088; x=1768405888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PJIEtUrzYPdTVro0VChXJhARniz5iWReiuBTRxJGLqw=;
 b=DJfHlEjchO6s+9rDnnLtVo3/ds8poYcFghsTf0vQEWwGwq498yZ1T7dByXUiMnnvaV
 5+H3CmO92YDCr2Zn6Z9YSiRm1h8UOKB2x99zt+7+LCyTmK12hy24B8aD4BC5bG258oHv
 tFHn99i6vD0roFRZISCfAccsbhMd9VPLc9fEjboy68iigDXDU5jdBbosq2LblF8P/uto
 VAUGI3GDj10r9/XZJdrxp9TP4qazxCKy7pMf6k/82WxZ3i7vGupn9u26lca/U2mxcla6
 7rzoZvWFpxyZgy0lBpkjHn2Wn2O8vVAQoanykQh1IypC1WBuZ06/2RD2eN0NHFpVvjMt
 eR+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ2V6TmASR/d2xsw6WdAuzZFUN37KlgbcFsRcsNMV7zkB4Fv4VdjfOqtYwvYIKNdW3IfJVt6w=@lists.denx.de
X-Gm-Message-State: AOJu0YwHI/iEuEastK0sBTWcLKTpkZ9/pBDu+nbGN41XUZ5Ul3AUCuYX
 ehpnR5zc8XiNBXffNqZ1gWnfo/o52lcLNZAJ4+Zrs+UYrabhOmerWyQ7ErtjUFgvi+Q=
X-Gm-Gg: AY/fxX4nWcLLZ5VkqLNrZPv+9XxZ8DQApHtcWxHYVquMG7aBPu9GywMWcty+Q/Gy69O
 ZnWrf6SVS0uU2GF+4aBVIrAjrJldUG3qMKN0VJtXTGF3gpoYvUfn6eOlNVSWJsiKOKIiFuoxCxj
 ggZqw6pL5mBkX9144h7ECREuj+PoHXBeRSaGfp2eZNRaRS85fn+vVzWargzYWCJAvYyhw19EiE0
 vdz6sUvYe8xtzGjcJVzcM9KeDrUBoyNULAOZkgIu9Lrm8PfyKDvzJUeHriGWkEBKtzuvnTqGuo8
 xJq8oDpwyKOCB+G4jVJjiVok1u10ZLK1imfyYewgSmDyE5EsmTsE2EfBJKgVdTsilomohPCyquF
 ScFSPwZCfCHwUlt2LhF2e0Hi9c2xFvKC9eeaeobNB1snLKzSca8pKYve3E1DnBA8K+Y583tbZge
 NQZdPMw7q+kHd+jsE=
X-Google-Smtp-Source: AGHT+IHPYNy1m8ZhVdWz4WUtrZEndDrwo8vw6KzwvjWLPuiaL/2yAy+odsvNbZJ1V4cPZ86/rk5qzw==
X-Received: by 2002:a05:6808:4fe7:b0:450:d32c:72d9 with SMTP id
 5614622812f47-45a5cacc906mr3558831b6e.30.1767801088381; 
 Wed, 07 Jan 2026 07:51:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:15 -0600
Subject: [PATCH v2 5/8] clk: mediatek: add of_xlate ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-5-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16947;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=IvUTpNs5/CRdXgTJXChrdLOrx+ltCJbvW41tHxJ0hYo=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDZvzOG7rpOs0O491a+xnIBVmKX+K1lp9TBp
 z/bG78QQoSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6A2RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhxsH/i/jv0GJWT5afoqcr7e0mWLhFMgX59GBxTVG0ni
 177n5pUmPr9akPiA99aYJz1ozmDYm6F+9tsnnqpHvF2EZD5V6r1LxfUXdyJsLXlpa2fuEOjJ6qf
 eJ5cgZsmfBYFGaNcZYxhswQDaAOcno0xMZch/x8r5beA8oSwKghy6LxZWROA0/7sd8OWJ0Q0OKv
 OK0g1nhnzH1CfiwfGDj6d9aswHuJqDpO5t3WrHk2ho23cs1tIityAJqm5RTjFpZRIrnID7z+pMC
 FKZHSMAy2WQJ/muT4+b3qGrKtP6jXKOVUudlVntM/GtaJbnkk+hFOX4UvdrRZeT+7kdxet13vkL
 Iwq0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

Add driver-specific of_xlate ops for MediaTek clocks. This provides
better checking of the args passed from the devicetree. Compared to
the default of_xlate implementation, this will return -EINVAL if there
are zero args (id is always required) and -ENOENT if the id is out of
range for the clock type. This will protect against out of bounds array
accesses later on when the clk->id is used to index into the clock
data arrays.

If there is a id_offs_map, then we have to do that translation first
before checking the id to see if it is in range. There is no sense in
doing the mapping multiple times, so we save the mapped ID in clk->id
and remove mtk_clk_get_id().

mtk_clk_find_parent_rate() also had to be updated since it creates a
temporary struct clk to represent the parent clock. It now has do the
translation in case the parent clock also uses an id_offs_map.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 244 ++++++++++++++++++++++++++++++-----------
 1 file changed, 183 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 6ed0f23f685..1539dc6cbcc 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -35,16 +35,35 @@
 
 /* shared functions */
 
-static int mtk_clk_get_id(struct clk *clk)
+static const int mtk_common_clk_of_xlate(struct clk *clk,
+					 struct ofnode_phandle_args *args,
+					 const struct mtk_clk_tree *tree)
 {
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = clk->id;
+	int id;
+
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	id = args->args[0];
 
 	/* Remap the clk ID to the one expected by driver */
-	if (priv->tree->id_offs_map)
-		id = priv->tree->id_offs_map[id];
+	if (tree->id_offs_map) {
+		if (id >= tree->id_offs_map_size)
+			return -ENOENT;
+
+		id = tree->id_offs_map[id];
+	}
 
-	return id;
+	/* Some IDs in the map may not be valid. */
+	if (id < 0)
+		return -ENOENT;
+
+	clk->id = id;
+	clk->data = 0;
+
+	return 0;
 }
 
 static int mtk_dummy_enable(struct clk *clk)
@@ -110,13 +129,23 @@ static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
 static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 				      struct udevice *pdev)
 {
-	struct clk parent = { .id = id, };
+	struct ofnode_phandle_args args = {
+		.args_count = 1,
+		.args = { id },
+	};
+	struct clk parent = { };
+	int ret;
 
 	if (pdev)
 		parent.dev = pdev;
 	else
 		parent.dev = clk->dev;
 
+	args.node = dev_ofnode(parent.dev);
+	ret = ((struct clk_ops *)parent.dev->driver->ops)->of_xlate(&parent, &args);
+	if (ret)
+		return ret;
+
 	return clk_get_rate(&parent);
 }
 
@@ -166,6 +195,29 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 
 /* apmixedsys functions */
 
+static const int mtk_apmixedsys_of_xlate(struct clk *clk,
+					 struct ofnode_phandle_args *args)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int ret;
+
+	ret = mtk_common_clk_of_xlate(clk, args, tree);
+	if (ret)
+		return ret;
+
+	/* apmixedsys only uses plls and gates. */
+
+	if (tree->plls && clk->id < tree->num_plls)
+		return 0;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates)
+		return 0;
+
+	return -ENOENT;
+}
+
 static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
 					   u32 fin, u32 pcw, int postdiv)
 {
@@ -274,15 +326,14 @@ static void mtk_pll_calc_values(struct mtk_clk_priv *priv, u32 id,
 static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	u32 pcw = 0;
 	u32 postdiv;
 
-	if (priv->tree->gates && id >= priv->tree->gates_offs)
+	if (priv->tree->gates && clk->id >= priv->tree->gates_offs)
 		return -EINVAL;
 
-	mtk_pll_calc_values(priv, id, &pcw, &postdiv, rate);
-	mtk_pll_set_rate_regs(priv, id, pcw, postdiv);
+	mtk_pll_calc_values(priv, clk->id, &pcw, &postdiv, rate);
+	mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
 
 	return 0;
 }
@@ -291,18 +342,17 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 	u32 postdiv;
 	u32 pcw;
 
 	/* GATE handling */
-	if (priv->tree->gates && id >= priv->tree->gates_offs) {
-		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
 	}
 
-	pll = &priv->tree->plls[id];
+	pll = &priv->tree->plls[clk->id];
 
 	postdiv = (readl(priv->base + pll->pd_reg) >> pll->pd_shift) &
 		   POSTDIV_MASK;
@@ -319,17 +369,16 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && id >= priv->tree->gates_offs) {
-		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_enable(priv->base, gate);
 	}
 
-	pll = &priv->tree->plls[id];
+	pll = &priv->tree->plls[clk->id];
 
 	r = readl(priv->base + pll->pwr_reg) | CON0_PWR_ON;
 	writel(r, priv->base + pll->pwr_reg);
@@ -358,17 +407,16 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && id >= priv->tree->gates_offs) {
-		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_disable(priv->base, gate);
 	}
 
-	pll = &priv->tree->plls[id];
+	pll = &priv->tree->plls[clk->id];
 
 	if (pll->flags & HAVE_RST_BAR) {
 		r = readl(priv->base + pll->reg + REG_CON0);
@@ -391,6 +439,33 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 
 /* topckgen functions */
 
+static const int mtk_topckgen_of_xlate(struct clk *clk,
+				       struct ofnode_phandle_args *args)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int ret;
+
+	ret = mtk_common_clk_of_xlate(clk, args, tree);
+	if (ret)
+		return ret;
+
+	/* topckgen only uses fclks, fdivs and muxes. */
+
+	if (tree->fclks && clk->id < tree->num_fclks)
+		return 0;
+
+	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
+	    clk->id < tree->fdivs_offs + tree->num_fdivs)
+		return 0;
+
+	if (tree->muxes && clk->id >= tree->muxes_offs &&
+	    clk->id < tree->muxes_offs + tree->num_muxes)
+		return 0;
+
+	return -ENOENT;
+}
+
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
 				    ulong parent_rate)
 {
@@ -421,6 +496,9 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 		rate = priv->tree->xtal_rate;
 	}
 
+	if (((long)rate) < 0)
+		return rate;
+
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
@@ -486,15 +564,14 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 
-	if (id < priv->tree->fdivs_offs)
-		return priv->tree->fclks[id].rate;
-	else if (id < priv->tree->muxes_offs)
-		return mtk_topckgen_get_factor_rate(clk, id -
+	if (clk->id < priv->tree->fdivs_offs)
+		return priv->tree->fclks[clk->id].rate;
+	else if (clk->id < priv->tree->muxes_offs)
+		return mtk_topckgen_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
 	else
-		return mtk_topckgen_get_mux_rate(clk, id -
+		return mtk_topckgen_get_mux_rate(clk, clk->id -
 						 priv->tree->muxes_offs);
 }
 
@@ -502,13 +579,12 @@ static int mtk_clk_mux_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux;
-	int id = mtk_clk_get_id(clk);
 	u32 val;
 
-	if (id < priv->tree->muxes_offs)
+	if (clk->id < priv->tree->muxes_offs)
 		return 0;
 
-	mux = &priv->tree->muxes[id - priv->tree->muxes_offs];
+	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
 
@@ -536,13 +612,12 @@ static int mtk_clk_mux_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux;
-	int id = mtk_clk_get_id(clk);
 	u32 val;
 
-	if (id < priv->tree->muxes_offs)
+	if (clk->id < priv->tree->muxes_offs)
 		return 0;
 
-	mux = &priv->tree->muxes[id - priv->tree->muxes_offs];
+	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
 	if (mux->gate_shift < 0)
 		return 0;
 
@@ -563,10 +638,9 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	u32 parent_type;
 
-	if (id < priv->tree->muxes_offs)
+	if (clk->id < priv->tree->muxes_offs)
 		return 0;
 
 	if (!parent_priv)
@@ -574,36 +648,62 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 
 	parent_type = parent_priv->tree->flags & CLK_PARENT_MASK;
 	return mtk_clk_mux_set_parent(priv->base, parent->id, parent_type,
-			&priv->tree->muxes[id - priv->tree->muxes_offs]);
+			&priv->tree->muxes[clk->id - priv->tree->muxes_offs]);
 }
 
 /* infrasys functions */
 
+static const int mtk_infrasys_of_xlate(struct clk *clk,
+				       struct ofnode_phandle_args *args)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int ret;
+
+	ret = mtk_common_clk_of_xlate(clk, args, tree);
+	if (ret)
+		return ret;
+
+	/* ifrasys only uses fdivs, muxes and gates. */
+
+	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
+	    clk->id < tree->fdivs_offs + tree->num_fdivs)
+		return 0;
+
+	if (tree->muxes && clk->id >= tree->muxes_offs &&
+	    clk->id < tree->muxes_offs + tree->num_muxes)
+		return 0;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates)
+		return 0;
+
+	return -ENOENT;
+}
+
 static int mtk_clk_infrasys_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || id < priv->tree->gates_offs)
+	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
 		return mtk_clk_mux_enable(clk);
 
-	gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
 static int mtk_clk_infrasys_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || id < priv->tree->gates_offs)
+	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
 		return mtk_clk_mux_disable(clk);
 
-	gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
@@ -625,6 +725,9 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
 	}
 
+	if (((long)rate) < 0)
+		return rate;
+
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
@@ -658,24 +761,23 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 static ulong mtk_infrasys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	ulong rate;
 
-	if (id < priv->tree->fdivs_offs) {
-		rate = priv->tree->fclks[id].rate;
-	} else if (id < priv->tree->muxes_offs) {
-		rate = mtk_infrasys_get_factor_rate(clk, id -
+	if (clk->id < priv->tree->fdivs_offs) {
+		rate = priv->tree->fclks[clk->id].rate;
+	} else if (clk->id < priv->tree->muxes_offs) {
+		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
-	} else if (!priv->tree->gates || id < priv->tree->gates_offs) {
-		rate = mtk_infrasys_get_mux_rate(clk, id -
+	} else if (!priv->tree->gates || clk->id < priv->tree->gates_offs) {
+		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
 						 priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */
 	} else {
 		struct udevice *parent = NULL;
 		const struct mtk_gate *gate;
 
-		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		if (gate->flags & CLK_PARENT_TOPCKGEN)
 			parent = priv->parent;
 		/*
@@ -693,29 +795,45 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 
 /* CG functions */
 
+static const int mtk_clk_gate_of_xlate(struct clk *clk,
+				       struct ofnode_phandle_args *args)
+{
+	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	int ret;
+
+	ret = mtk_common_clk_of_xlate(clk, args, tree);
+	if (ret)
+		return ret;
+
+	if (clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + priv->num_gates)
+		return 0;
+
+	return -ENOENT;
+}
+
 static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (id < priv->tree->gates_offs)
+	if (clk->id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
 static int mtk_clk_gate_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (id < priv->tree->gates_offs)
+	if (clk->id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
@@ -723,13 +841,12 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	struct udevice *parent = priv->parent;
-	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (id < priv->tree->gates_offs)
+	if (clk->id < priv->tree->gates_offs)
 		return -EINVAL;
 
-	gate = &priv->gates[id - priv->tree->gates_offs];
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	/*
 	 * With requesting a TOPCKGEN parent, make sure the dev parent
 	 * is actually topckgen. This might not be the case for an
@@ -753,6 +870,7 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 }
 
 const struct clk_ops mtk_clk_apmixedsys_ops = {
+	.of_xlate = mtk_apmixedsys_of_xlate,
 	.enable = mtk_apmixedsys_enable,
 	.disable = mtk_apmixedsys_disable,
 	.set_rate = mtk_apmixedsys_set_rate,
@@ -760,12 +878,14 @@ const struct clk_ops mtk_clk_apmixedsys_ops = {
 };
 
 const struct clk_ops mtk_clk_fixed_pll_ops = {
+	.of_xlate = mtk_topckgen_of_xlate,
 	.enable = mtk_dummy_enable,
 	.disable = mtk_dummy_enable,
 	.get_rate = mtk_topckgen_get_rate,
 };
 
 const struct clk_ops mtk_clk_topckgen_ops = {
+	.of_xlate = mtk_topckgen_of_xlate,
 	.enable = mtk_clk_mux_enable,
 	.disable = mtk_clk_mux_disable,
 	.get_rate = mtk_topckgen_get_rate,
@@ -773,6 +893,7 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 };
 
 const struct clk_ops mtk_clk_infrasys_ops = {
+	.of_xlate = mtk_infrasys_of_xlate,
 	.enable = mtk_clk_infrasys_enable,
 	.disable = mtk_clk_infrasys_disable,
 	.get_rate = mtk_infrasys_get_rate,
@@ -780,6 +901,7 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 };
 
 const struct clk_ops mtk_clk_gate_ops = {
+	.of_xlate = mtk_clk_gate_of_xlate,
 	.enable = mtk_clk_gate_enable,
 	.disable = mtk_clk_gate_disable,
 	.get_rate = mtk_clk_gate_get_rate,

-- 
2.43.0

