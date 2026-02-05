Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20E8ECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193C383AEE;
	Thu,  5 Feb 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GxGBmCKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FB883693; Thu,  5 Feb 2026 22:13:41 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7578382A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d195166b2cso1061171a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326017; x=1770930817;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=GxGBmCKyC1+9BfjNgL8N/qmiorVFo+G6njpGrDer7Gotr8LnheG6p818oAxolKQ9YA
 dEdASxxVz2p8Z0cPXNczyQvnSVXlKCHdWwVuytjg+7FquI00129rRAEOjwepoEzPALdz
 MaP8zQONEguiP827JyOzhb8kiY1fQippFl03zqkKcbONufHtZ7w5zfBqYXav6URlkPQP
 qz8auplwjp3QSJI6fhWUXCq49y1Ue0bymTDf/EDDzEhM5BHn6bZIwZnBEB2QaiA4tKyb
 SLViD3KhjsfrXY9IgCLh+Y0t/7LJ+t/EZfIgc5PDjf4Vjx2s8+baCW3t75XjWrl0ENm7
 vFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326017; x=1770930817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=ArMvE/HqaSVIgvLLKpvXkoiFkHr0JOvmdfWw/ALPP+6UgVkdJnvjunhPSK8mozpprU
 jqriBk29osdmr2G0e3YpbMsczqNNud6p05QRZsV+2FuFHLNZRCtcIbTYKvxHzXtDw5YN
 fVtqtyjIc77Kfa48HJJZuiwWfebSmn7DohZGw/ZkVW9VWwCmV1urdA144Bo7126TLncD
 KuL2j+UlFxPW9Kmkh6tfmfvySYjq8Hz5//M5U1hE0Mvph0iU2en+tvAdMbLCOpO+ahY+
 M6od4a3LsDX9Jizx0Th/q/w9W8kbWCsT1uHx90OvDazKfhIdGKqzD+miP84+gBvnkF2T
 Ueaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbEWMIEw2LkWxYvNGE4ddXO8KwSOerFlIInBrbJsx3KLsbL2FQjfU82deqeibxi9v1un19f5A=@lists.denx.de
X-Gm-Message-State: AOJu0YwvnpDPon2dzfzqGVwcUzJwHFJJ6kR90Vm2m5k7z5lyvgS5cHWu
 PjnsqCi2K2XlT4drQw/Iy9uABQVt9OydWih7wQaXHKY8OvNwoRa9bMGYKvQybYBHuV0=
X-Gm-Gg: AZuq6aIx7GC6fgQxpmEeMFTrgZQnn4CDs14NA9YWONWwnL51hJ73d1gizpMRe/HvvI3
 IfQegAEAns6y3OIxMTn2mZ37ClHpNpg1l3+PR3BqFPy711DdTsbXaZBP5sAC1YdSNzwkwpnL3nv
 GHsc4bu4VgZ+nbctoQNimPGZjWc7HXP8EGumM2Y+r+c2n7XvIfK2z8ln9BMrRscvPYJ7J09B3ZV
 FNK6IR90ekeUjLx4ZY9dDMBsHlMwn8jITtfhJ6vnEPx7bmTEqIXlBgkVn1BDOcpz6gS8c0jkQJ6
 ryGNxODKsM/VY9b6EXQ9QGev6g2AtZQ7FJqg/KthRs1VGjm8QagnLtLa2q9yB8ktE/qmaoVL6BQ
 ZPjZwLU8GMnYJFp8QizNA4k01LE2+vivh6z/wnx2JDUE/V56eNGqp8dDaPW2ryPKsxTHAWdKvAf
 HgL9E7uAWm7MYzUbg=
X-Received: by 2002:a05:6830:6188:b0:7cf:d1eb:f37a with SMTP id
 46e09a7af769-7d4644892e1mr194321a34.18.1770326017483; 
 Thu, 05 Feb 2026 13:13:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:37 -0600
Subject: [PATCH 2/7] clk: mediatek: refactor parent rate lookup functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-2-bbac40932c2a@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5541; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8YFbB2CqM29lMFcwxaeZ41UGNY6AER3aHdzGWe9GU0k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfXfEnyRsWx/gF6xEdf6g341rWc22pW09Q3Y
 a/Bv8w2ameJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUH1xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALhsH/i14f7GFawIPoqsNdlhds01Mt1lYDKsmb0GWGbB
 uuUbcE4lizm4wixpNTyoaIDQbWJccxsEAezNBHWMRRrkujbXyxHsh50IS3jgzbU41d+iMnveged
 j2I77Q6TMG9JswKrPipP77Q36zCtQQVLhnsv4MFoe+hyLhV63HLdu98Wd2fehCA6diYV6m4DeGV
 xHEfaPWlmgJeSdz5+4Fa1jHtvSlnCXWNVIZvYXMDGo8zO3NOD0bkbD9SpDCJf8F1CT5BAa3HgSL
 amdDksENu0GZ1abmJ0UMMqbqCqJKpjj1hPS++QTC9LfA2OGIVpw9ilgd9O6bBsCwqoRGNLmDgHz
 VnWs=
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

Refactor duplicate parent rate lookup code into a common function.

Instead of relying on rules like X is always the parent of Y, we use
the driver ops pointer to make sure we are actually getting the correct
parent clock device. This allows the same function to be called from
different clock types and will allow future chip-specific clock drivers
to not have to follow the rules as strictly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 111 +++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b3f05bf5a21..0123b0ce7b1 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -168,6 +168,53 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 	return clk_get_rate(&parent);
 }
 
+const struct clk_ops mtk_clk_apmixedsys_ops;
+const struct clk_ops mtk_clk_topckgen_ops;
+const struct clk_ops mtk_clk_infrasys_ops;
+
+static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
+				  const int parent, u16 flags)
+{
+	struct udevice *parent_dev;
+
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_APMIXED:
+		/* APMIXEDSYS can be parent or grandparent. */
+		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops)
+			parent_dev = clk->dev;
+		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops)
+			parent_dev = priv->parent;
+		else if (dev_get_driver_ops(dev_get_parent(priv->parent)) == &mtk_clk_apmixedsys_ops)
+			parent_dev = dev_get_parent(priv->parent);
+		else
+			return -EINVAL;
+
+		break;
+	case CLK_PARENT_TOPCKGEN:
+		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)
+			parent_dev = clk->dev;
+		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_topckgen_ops)
+			parent_dev = priv->parent;
+		else
+			return -EINVAL;
+
+		break;
+	case CLK_PARENT_INFRASYS:
+		if (dev_get_driver_ops(clk->dev) != &mtk_clk_infrasys_ops)
+			return -EINVAL;
+
+		parent_dev = clk->dev;
+		break;
+	case CLK_PARENT_XTAL:
+		return priv->tree->xtal_rate;
+	default:
+		parent_dev = NULL;
+		break;
+	}
+
+	return mtk_clk_find_parent_rate(clk, parent, parent_dev);
+}
+
 static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 				  u32 parent_type,
 				  const struct mtk_composite *mux)
@@ -637,39 +684,13 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
 	ulong rate;
 
-	switch (fdiv->flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_APMIXED:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent,
-						priv->parent);
-		break;
-	case CLK_PARENT_TOPCKGEN:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
-		break;
-
-	case CLK_PARENT_XTAL:
-	default:
-		rate = priv->tree->xtal_rate;
-	}
-
+	rate = mtk_find_parent_rate(priv, clk, fdiv->parent, fdiv->flags);
 	if (IS_ERR_VALUE(rate))
 		return rate;
 
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_topckgen_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
-					   const int parent, u16 flags)
-{
-	switch (flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_XTAL:
-		return priv->tree->xtal_rate;
-	case CLK_PARENT_APMIXED:
-		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
-	default:
-		return mtk_clk_find_parent_rate(clk, parent, NULL);
-	}
-}
-
 static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -687,33 +708,14 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 	if (mux->flags & CLK_PARENT_MIXED) {
 		const struct mtk_parent *parent = &mux->parent_flags[index];
 
-		return mtk_topckgen_find_parent_rate(priv, clk, parent->id,
-						     parent->flags);
+		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
 	if (mux->parent[index] == CLK_XTAL &&
 	    !(priv->tree->flags & CLK_BYPASS_XTAL))
 		return priv->tree->xtal_rate;
 
-	return mtk_topckgen_find_parent_rate(priv, clk, mux->parent[index],
-					     mux->flags);
-}
-
-static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
-				  const int parent, u16 flags)
-{
-	switch (flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_XTAL:
-		return priv->tree->xtal_rate;
-	/* Assume the second level parent is always APMIXED */
-	case CLK_PARENT_APMIXED:
-		priv = dev_get_priv(priv->parent);
-		fallthrough;
-	case CLK_PARENT_TOPCKGEN:
-		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
-	default:
-		return mtk_clk_find_parent_rate(clk, parent, NULL);
-	}
+	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
 static ulong mtk_topckgen_get_rate(struct clk *clk)
@@ -963,18 +965,7 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
 	ulong rate;
 
-	switch (fdiv->flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_TOPCKGEN:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent,
-						priv->parent);
-		break;
-	case CLK_PARENT_XTAL:
-		rate = priv->tree->xtal_rate;
-		break;
-	default:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
-	}
-
+	rate = mtk_find_parent_rate(priv, clk, fdiv->parent, fdiv->flags);
 	if (IS_ERR_VALUE(rate))
 		return rate;
 

-- 
2.43.0

