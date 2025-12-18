Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B2BD6E2B8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B46188391B;
	Thu, 18 Dec 2025 18:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7Sl1yeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7B836A3; Thu, 18 Dec 2025 18:18:12 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B500B800AB
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65cf597a717so360492eaf.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078288; x=1766683088;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PJIEtUrzYPdTVro0VChXJhARniz5iWReiuBTRxJGLqw=;
 b=v7Sl1yeSgWNgedl6z6qbAfPO4n8npRwmIz+hP6jPeIRNbfl2YIb5EP4cRfyvHHUDfO
 xjrdzfUuNWbk2g1fIMq3/o6ndIijjx4Pbr7yvTrQ5ytgQ3TKnqQjRbUng3fRTbzSsAHr
 IH/zTxTAMUz+xzO13LZFUPrHJ1h2q4fVk9dD3nWUHZigh1lZE0eQ4nbKq74juLlWf5Wf
 H+1PKbrj1HvkT9T22gnow6ZyyaX9AZ5UM3sOzkMb/psKmpDtugAMjHnAFuyW8qOWq6Sx
 AyvAYcorbtgkoOYUtwtIxsKWtxzF2KT7F4aFw4llrHRioItjfrMSdaOXwCAUaNBxI6Mn
 XO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078288; x=1766683088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PJIEtUrzYPdTVro0VChXJhARniz5iWReiuBTRxJGLqw=;
 b=MfPyoOtdvZMIsjt1OTwPHnXWUtDbzWhy0MM9StINdXNDajiYjjLIcRu9HKFpbwXfI4
 2oEUeUkZ7KDkIKybbu4BVoh8j86PicN5SJMxDzyoagU5wP+xoWLKiUoJsdIKt9nfnIhr
 zoBqwt7uiVXbwJaDI46L6wQklvzDGOj69liOYwEVMCuT7iLvtzRp3GruX0a13T2uaIpB
 LS81cDSNfmmyuobP3ZdU6P8XuT8ycrNeiWzl8tGPEkDIsUVafNJl6JquG1fcI0NRfD1v
 d4vi4XtrftdyK9yHo5fwq2hyhdQJ4aGeK45J0bFw8McXh7O7IRD4LO9SeS8rp8cTEzeO
 nvIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa2doVBAbAkuigMQGBQwJ4LFYSoMhqNX8ZsfgxTJ0lFdwifsH56GcyyKx3OsRbBE/8hbs6mxg=@lists.denx.de
X-Gm-Message-State: AOJu0YzrdhgVZKpXbyrPO9fGCcWmiM4IcO/kx+/Ts9i6hX7kP3g54N02
 R5cBdiF7tBN32siLhnGXb2nxwz0UP0B28YO5kQdpgYQmZnF+r+ZmvtzXdmD4fr735OM=
X-Gm-Gg: AY/fxX7qFy8B73VKy2Nn0xWw/HkRPdjcpTwUKT+Zt1AVgyzrrR0soDvPTBOpUBr6EM1
 9A+wF1rQm8wdmUKuxqiW7gUR2dQl6FBIwc61pMz9AnOILwfWo+EdgOzCfpyMb6HpZVLUt4AScYi
 CAaku9OslSN+rlCY9QcOmXPSbaZLCDEjz5fXYv72LcUpJscCj1KZFPw1IAd8q7sUWr/vPb6mcWn
 tyDKAeL66D9uj83GfksBDItVNyeJUmHEs5EqM4ss6d/jwATfALUTjubcBXfaUbhzoIvw2xZGBp5
 q9k0ccTw1AsNKunSvhsWUFx5Znd2CLBYVfbcNxSz8n70t9DK1C6XXOARO9NFYwkaoY+ZjUtL0kR
 VXrE+7QfkVn8s5lyjH0Xd2l6EKQ6S6MnjpOue9hGOvQFauHYWHsDpOhAggs1j5igvtjAIoiKuId
 0eSZ1bew+MSWop76o=
X-Google-Smtp-Source: AGHT+IEio9A9rsE5JsFAtyV5DSVHMYYBBRHSmawxnR+Sljh5Io3QQdqJbKFINsoC0GYEOjbRw6dEOg==
X-Received: by 2002:a05:6820:626:b0:65c:fff1:bcf6 with SMTP id
 006d021491bc7-65d0ea9d861mr88932eaf.35.1766078288374; 
 Thu, 18 Dec 2025 09:18:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:03 -0600
Subject: [PATCH 5/8] clk: mediatek: add of_xlate ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-5-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDcwPP7udZkHYlN/C7x5wyverKmvqmH1bBOsO
 cHdOqaSy6aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3MBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A97kH/1Meud61GaxMIxB5Z5w08edp4OrzAajtt7ggfGf
 NvFBZ8oXeABgwZb8CZvFScbmKCfVgMa/Q6Ky7Qlds2iP2W+egx38UUH9EopGPdi8xb4zQJBDS/9
 1oVlsZOkEmI/ucTG37Kqbe8fEoC7m2Xa+4t8uB9gieO1dRNCO5xcde/y0FmkV0Da0HjIChsdl5+
 tU+/63/W49FTWOJsu5U+IYGIpRo60BXQ7yaOCylJR560Olypdbur4gqMaH3R6GA3VpV5d1nvJgx
 J/+TbQ5OSgd65VjkJGVsDTZijvOk5kOmb9JNEhn2DaHzn5xiJrPyws9hLTkF0Ni14uz0etN00/w
 X09A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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

