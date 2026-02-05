Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7BECD9AA
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A68A83B64;
	Thu,  5 Feb 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pe5ZejnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371518382A; Thu,  5 Feb 2026 22:13:42 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D8383B0B
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f04f1348cso12406b6e.1
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326018; x=1770930818;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=Pe5ZejnDvvdzqdggmJ8yKJFr6F5V0jQqGGUBQZSEMF1+ikBhoaZDNj0nIGOk7HCspt
 BmdSBUT5sMENNACmtVubzvLaorSrwVGnVy+Ya3/wQWegsriaUThyrTXXGZ44EojMz5hH
 38IdJqdd7WR8G6/DvxjNqozqNQFP+8TNsfIpW6cVsxeQrclAFA83YWHNgz5J7VqKTudi
 PhOva1FWBt2LbhunKRa56Mg2bAZdf2yuTCKhtPghfIy4wKbuftYIh19WSrRweA2nL7i7
 xtJWtfG2naRDWkhco5lwdUS6WyfjZx1KtHD95moqC4bFlxkg2MVjYTYU3cudPil6L9Py
 npSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326018; x=1770930818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=qN0I8FQuY+jwLzQokYcWqXjWEDnOYaw0qEJgwMlTpc8JheFUYeB15NOvOY5ReMfZPE
 i35TVBwsfiWyz658x7AHpnAqYqN5meRbSh54Gt7vv5eBXzYfPusYKXrApCxTVJpA9c5R
 kRHm5em5BvEkXnw7KGyPfJJctOIBv7r2CXiK+c4ZtbrPsXWj05OpgFVqME7oRvCWuXPC
 Vdw0jEsemcPFqKf09d8HHH+601CNKSNc3kfviIp+27N8kM9eK3KNATeHOXtuEhdGu0l8
 JXQ69vVsCVkQ+NXI9hFc0hZRkxpXFEsV8SZUQqoYdM5A/caU88qLzGkWI/oezz00A+So
 Cbmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkNWAOSRS4lMXxymPvR2ABaM3A5PC00XH39dsKTGpxnkksqtcAhj+scLeQlYfWKqsPH87/D4=@lists.denx.de
X-Gm-Message-State: AOJu0YwuZTF51ATsq1rzgiq3yCnSq4/ZwZNhzeLxS8CvDb4QIWU8vFiu
 IGCTs9F08r8o71Lrub6+Weyd4ZvV1Ar3GXIO1q8PdswCmsRD1VZVCtxz86iXOMTXseg=
X-Gm-Gg: AZuq6aIva8g7CDzDQ3+S9w33yHwFU9TQmFhRapuhzlxjuUa7RwxP+BrUwpt3hifPLFx
 dClHpgAKHAQYFSrYvaXSUz4Q2MQbmUGeXNFhzmLiz6omthAhTF9o4zSvpfBfUBxXJHlxnjbB+k3
 Y3HAHQIArm7NPlAeI+9lPqO1UoT40xqVkRCql2Zs1/ad7/562klZggWnYw0wkUx3ozQhklbvnL9
 sM66/mDRfMZ/l9BoeMwZ2FrUGHiGgi0BoVvI8RBD8+xTgeFq+tjJLsfFBq7ZQFLkXyINKN/fTsI
 yGi5WyNSj60zhYb9JTfLVxJxH1nHsSMfq40HN0frOyY4uBmmlel6Vo0OnsS1iRiusIM3oxjFrvT
 Z8Qzk9q7wagWsRJ6gOOcI7IZw5JOQDy0q1w9hUrswp/ZZk6/B0Usu6ItEtsJIJ4litKSM0yvDWA
 pig3NWVCSVBVu7u9+pEvSosAtJZw==
X-Received: by 2002:a05:6808:1190:b0:45f:154f:d44b with SMTP id
 5614622812f47-462fcb8a6e6mr334627b6e.46.1770326018436; 
 Thu, 05 Feb 2026 13:13:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:38 -0600
Subject: [PATCH 3/7] clk: mediatek: add mtk_clk_id_is_* helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-3-bbac40932c2a@baylibre.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfegLEdusBrCRgo9d3lULffEf0tB4iBm1pa8
 Q7pPxfcj3CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUH3hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AXO0H/Aq93MJAbh+/vmVUvoyc2EpBw6ZfCdGLFZ+80Qo
 02c7tiq71h1UPmpbkrLIHSveU4nX4GJhm0ISNadansHWEG+BVH1BaZ1N4ZZhbKb+SLhhjzSGdc/
 yx6l9X3GuCWqlVDK89h9kis+OHax03iBK1wXfwL92/zjNp4lf0R/nzZU89O0iqdiEWlLjpn5nvQ
 8yVbPe76CNcfxNZ2Li4/+3PMaMsXH1lhGrNUdEL1qexfPxDyquD+FxvRbzoCzMRCdxNrdxId8xG
 0ndIjL5ByrxGASJg+I+klpIp5yAqUggwj+nMEMDMcXQg29RnVkBXo5gqXQhgsQUa153YK58VP73
 dn6c=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

