Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE632FF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1115A84413;
	Wed, 18 Mar 2026 00:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LLkQYrtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A2F8440E; Wed, 18 Mar 2026 00:26:48 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF86843B9
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4171451e89aso139699fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773790003; x=1774394803;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aDOXd3aqTa9gLIgFrSgH4ZQv65SnLKQGQcjpY3d03aE=;
 b=LLkQYrtRNgWvR6dtQYOduixnWm9hTzOfCCCN9HhLf/H3vkeeGF2DfzXRnFRRR+a42x
 l2dIYSpaA8nik9M/G6Yr3HY+U+UfwsGn2cmNUJugziAJsBUEeLS8CfRoROV80UPVU8Rd
 XNsovWNrUarIMHJTT9s+JO0EKbDYlZy9ivrJnPgPHh/e/9SBHkmEgFvdSMWBZrST7HdJ
 z51qZWAtGmEQ2DYaItX4/uErAyRsfPSC5CpH/xpc0/kAv06zwjBl3vX3DHSQD25cRYlV
 H8uk2h0yfBZVdcSa0CNE+JKlsoNy47Fl9fLGbSL3ccUy4FegWQkQNR6dLb0arGr3a/s+
 wa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773790003; x=1774394803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aDOXd3aqTa9gLIgFrSgH4ZQv65SnLKQGQcjpY3d03aE=;
 b=PwEcY5BOgjrTTS5Kicmf+vxvFnpf2XN0K5oeknQxs98DpJ50W9dhB4LCyusR2YTk09
 DPeCml/IfXlNHKZOwZ4ZUeXBj004HqfAhBR3500AfQUUR/OD3KxaElFnINxJOUa64hHb
 fAsaI0o4GcjhFkFO5xG02qkGOS/EktaJjcH3JyyGlZRlLx1CxsM13ysuzm12NXA26m/q
 /JUR7iRGSki4CbROOKrvrHpy0CPr8o3raEv221eJ/5ft83bu8we7ZLjm/kmb6LBVqRLI
 bnIMVVXE+rYf9bbxQfojsjRJo3Qphrl8qUXhU69GHK3dhQhUZt0PPRlH9VWDV0OCzfJm
 3kMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGvzZmBpfYhzVsMQXTr9jpOuzq/BQeapOm8hNzzinSjasIbU0Sl8PZTIwypRvIv4LWYRovnI0=@lists.denx.de
X-Gm-Message-State: AOJu0YyhKruR5e9EiCWzGDkA05g5QPAcq4ZrzZz+Pu73t4RSI2jMxiki
 aRlOs2vZwcvuOUaepB80sDPsBqJOJgJxJigSQc1M13YQNXU4QJlZEZOQD7s3DuqBmEg=
X-Gm-Gg: ATEYQzwA9GiJXOYPNGpFfJzav8kpOEbF+yUEoCSkmsuFRTZUrf0EyxbKiExGmD6XgLz
 LSGztJnTGxCnuLYSV70BxNaESWV2LYkD0s3mtAV10HnTamTSf4BHrCiwEeibm4vuHJ2w6Nzk9nk
 6c5f480mcxZEeY/ZxrhEDc4ZWOC6wm5Dfd6BTGXYGI4wlD+N4q0beGQRVKdFDR6OAVr2qKyx3c2
 p/eDBUi6wSVZlG+IJ8RY6pQgKSgl4neRZPkGLrV3OFnDVK8IdUPeYz+KGi6I09PwAZYcX3hHbwe
 WGOelxl3XcEPozHCYsorBebVDthbODkbkw6xRoc3aA04IhJXbHnN6Xc5USWw4oXkaB517DR/pnq
 +3ulhObwh+H8vm23EcnZ82P3xEq7dePtYeP8hB9JGlCVN963D0eNdfSSrrl/Vs8PWyVbXig+tfb
 c5fHFYuPK8yRedXvKZMM6CWpYfeifNlQJM2fqw
X-Received: by 2002:a05:6870:d1cd:b0:417:3a5d:c2f1 with SMTP id
 586e51a60fabf-41bd3d03c96mr930304fac.7.1773790003144; 
 Tue, 17 Mar 2026 16:26:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:29 -0500
Subject: [PATCH v3 16/16] clk: mediatek: refactor duplicate
 *_mux_get_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-16-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Wv9pvZfyj5TjdiyrjNBrrzTK5USFzlhH2ryAb/pF+f0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueMbQ2yKg62LynMoFGjGKHh88m/X+TRQkaVAl
 KryrXWam+SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnjGxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AipAH+wXHGLsnTvOwfg7M6D0XcHUV6/DybuI3pSNVU2H
 lUT4GPVVt2Kxq8SL/HX+7ZMLwwFlI1wJ+pcNcEQXeJS6pE6gzXfBrCZBTAAveC20/KULgz4dqwd
 Kqge2JxpXpj8L0u5mLJvEfWyEMEwDZ+4VOMJ6Dx6VN6GrZ64FNKVg0fP1jSZ7ORRDuUTV8NK7AO
 vlVPNILK9aZi8nkE8BuM045QzrQ6YYeKwGewHry6cOlDeQchcVKdPCCkDrI8937zUO19SAXXpyQ
 0m18YSPdha4p7DSV7mzq2yP1RO/g4mPRWJFP6CfBx4/8nVavfo01gw9vIcRPeHmj/gz8muku5hk
 KTD4=
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

Refactor two identical functions for getting mux clock rates. The
functions are renamed and moved to the section of the code that contains
other common functions.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 50 ++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ddf4ac755bb..fa4a84bfceb 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -253,6 +253,21 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 	return mtk_clk_find_parent_rate(clk, parent, parent_dev);
 }
 
+static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_composite *mux = &priv->tree->muxes[off];
+	const struct mtk_parent *parent;
+	u32 index;
+
+	index = readl(priv->base + mux->mux_reg);
+	index &= mux->mux_mask << mux->mux_shift;
+	index = index >> mux->mux_shift;
+	parent = &mux->parent[index];
+
+	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+}
+
 static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 				  u32 parent_type,
 				  const struct mtk_composite *mux)
@@ -701,21 +716,6 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_composite *mux = &priv->tree->muxes[off];
-	const struct mtk_parent *parent;
-	u32 index;
-
-	index = readl(priv->base + mux->mux_reg);
-	index &= mux->mux_mask << mux->mux_shift;
-	index = index >> mux->mux_shift;
-	parent = &mux->parent[index];
-
-	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-}
-
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -728,7 +728,7 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
 
 	if (mtk_clk_id_is_mux(tree, clk->id))
-		return mtk_topckgen_get_mux_rate(clk, clk->id - tree->muxes_offs);
+		return mtk_clk_mux_get_rate(clk, clk->id - tree->muxes_offs);
 
 	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
@@ -959,21 +959,6 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_composite *mux = &priv->tree->muxes[off];
-	const struct mtk_parent *parent;
-	u32 index;
-
-	index = readl(priv->base + mux->mux_reg);
-	index &= mux->mux_mask << mux->mux_shift;
-	index = index >> mux->mux_shift;
-	parent = &mux->parent[index];
-
-	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-}
-
 static ulong mtk_infrasys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -986,8 +971,7 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
 	} else if (!mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
-						 priv->tree->muxes_offs);
+		rate = mtk_clk_mux_get_rate(clk, clk->id - priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */
 	} else {
 		const struct mtk_gate *gate;

-- 
2.43.0

