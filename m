Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FD3FCA18D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E32883F6D;
	Mon,  9 Mar 2026 22:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="otPjESXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A1D83A8C; Mon,  9 Mar 2026 22:29:39 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4267E84010
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-466f00535cfso1604933b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091774; x=1773696574;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aDOXd3aqTa9gLIgFrSgH4ZQv65SnLKQGQcjpY3d03aE=;
 b=otPjESXhi8LoUjj8xe3GvLFzxGqgU9KOLz+QMyDmNw9egcp/OE56K4xaKzY/+XvtZB
 8IX+jeN3xuepFTnw+m2nQVWUn0ANvKr9l/xHv8TejP2vOuKkIGwuX1zzH0qwpY5RMz34
 UHPguwQVMUVCTprDSjIMS7Tbc5yzf7iH3kkJ3R5RzsoV1h8uOXU7+SFU3/YeTx+uReym
 Q4yX0VtX700XeqmFoWHVXmtFjz9K/kEOv9fZtoNs7+oKCi8TGhlCsqJ9IXdX4k0Zo9Ue
 DhrJe0r8KWoUbotWxqn6Lc+nmUkDM12p3Ajm6HyKInrwvrxS+QgrcYp08DajzHcn1yW1
 cJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091774; x=1773696574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aDOXd3aqTa9gLIgFrSgH4ZQv65SnLKQGQcjpY3d03aE=;
 b=Xjm6McrN5w85ZnkaETFhLTwqVagsJ0qHLcuUraLET6NBAmXLFB7bfrYWSx7WQjd0/u
 Ahda6BACQuJ6NjKAltd4tJh4fWx9FbD8Z7pe3kv/1XdnLqzRLmYPaUfXLwJUOfLvuau0
 1FeThRklG1elCJZH0djK5hQqmvKyD5vPouVeK9r5xxL32EqL95sNfCD78mdasBCc1g2R
 zTd4AcjwHOvEjvagh5egjL4fgVPYkGahUj60XIWdCMBF6gukJL70myq4N/XIlNOXPOKQ
 UHD2YRvBTyILlJ8GQA4/78Rv+loa1NCrQDQIzBlqSvPy4l4ynQzlPa9IDF+jjsdXtmzH
 1KhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEvakGw1gd840rLFWY8G5YC2GqIc4JiFi45IvowihsEyC0i/X22Mf5W70RmUsM9M925ETsHyc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9pJ45m1liyBt9aBKNMhzKo41yi5HS0GlXJFnCqC7hXnfboY2l
 ZDU1Mt0vJSml08LtPftP6eh9LS5AKerkSK2mnvGuZufh26XZBfPLjs7Kd6ex8IoSddQ=
X-Gm-Gg: ATEYQzy+KYOlHDyZt8pje2ovRIu8hnGw4707eRmFpgnomnDV51+tjWc9l6qAZDBB0OD
 eRY0DfX7hbd2nJz+VssfBUhCSZ4HLBuAWwobYgu97Kdh97eTjzr3eZYXCj+5LzzrJQvJDVxOWWy
 Z8nrpKrOhoWeNIcUB74ve6Sf3fy+KcHcgV900Q8VgrHS3eP9pEx0q5GZu0Htuqd3/gXq8+xrTYs
 mbTTv8Gtpno8Bhbk1MN7JB06FeQCnXPhxNJ6GHmYFLG9gfxr3x24CFK7qym/PtRXUXRhPU4QebW
 rx0uyJ8TtAUtWeycFdhZeGn4m41v3n/X69Lx6uQ3OsugeKOqi8RnWt9xpBETBkwMqiNq6Hq0+hJ
 o8qHYZdAbWzDP0MwEYPSD4dvWAAJvYQ8pJ9Plq3cgiO5xcRJm52LjtiHtFyde5nuGJT406aHLBb
 dy2y0uMHkJYROpB9HlPcNd6TN2pg==
X-Received: by 2002:a05:6808:13d1:b0:45f:59e:1e06 with SMTP id
 5614622812f47-466dc9eeaa3mr6732987b6e.4.1773091773858; 
 Mon, 09 Mar 2026 14:29:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:48 -0500
Subject: [PATCH v2 13/13] clk: mediatek: refactor duplicate
 *_mux_get_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-13-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Wv9pvZfyj5TjdiyrjNBrrzTK5USFzlhH2ryAb/pF+f0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprzujKlfa1w+n/2l4Rkh73jOlaCH+AZHYqAC8U
 9NXWe35A8uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87oxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsDAH/1AEtGWOoMk6BIULs+q1G2A9wxanejIqr9iF4Ww
 PiI95JPmgzgxIiUgVfMsAIeHwY2wgisdalbK+MWIR2QCZIoXvHV6TWgXXXocjsFJ1z/gFJJE1XU
 nZf4fuElhiZK8RTWBaQJEErTb1JUn77ZA4ks7aBF/VN2sYgH6JXH3wp8KGq0wwJcK9MBFL769Wd
 1P3FG7tz8GPKb0yO6TGPyIib9O7syHZT+3QQ/yW7IukvAlCMhXI+ngurwJ8B4cyVRBg4/tkvrp1
 6xkjnHqn58szhWlyblAvhiyvBY1aUwjLtUwJqn6hzKsKVoV3HYdyvrGGPwl1/22G8T0hSsx7e63
 Pm1A=
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

