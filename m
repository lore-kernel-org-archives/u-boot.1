Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C513D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD082839DF;
	Fri, 19 Dec 2025 00:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HhxqxYC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6209838A5; Fri, 19 Dec 2025 00:24:47 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FE0835B3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4510974a6bbso438483b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100284; x=1766705084;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VNnsYUzluZah7JCthe9zOSPNJoqqZGPX0lsyTM7RmkI=;
 b=HhxqxYC6bDoOu+Y+A6F0kzg4Ve6WY3yBZoWgVZqVOlGCCZR+z7+w6w2XJk8jVfFnXt
 9j2QMyGfV1eUst7ec0LjGqib83DYMsC1cB1vct7pXmuUk04L76lBOfBsZPg7DWaaAF9H
 8RI6FeEUw6mJUzRtwWzofRfoGaOO/ERnfuPFFDIlkU1hOKXGQgTl3OkkglcO6Di0SB0T
 Yej40LhE5PfZ7FlCCfgPb7jnSZymMtPw/BE0Z04vWYCPFyI/dMds0wV0yowek3lHQ4Vj
 JbXxsJxsu/n/LDesOWHp33yeLeMlKdKlWyA4KTdLZyvP8Wc9MxRDz15OhxzZ+KH54uMJ
 RfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100284; x=1766705084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VNnsYUzluZah7JCthe9zOSPNJoqqZGPX0lsyTM7RmkI=;
 b=W865MT86mUqO1Yy3fiZrjBbc+08xgk8GAZsNFTOkKF6Trw0ZGAL/fGr530EilXfQWz
 DE8veOevlqM0P6QBvHtiS5qAZOSslglA1rmHgt96110RXI9iKWC7xa16NbnBHU7Ogd0b
 679fgQW2wD8NqP1Fvd56jffs3W0oafNEqEnZMkSUXAsY/z6MdMj0h4QLDSB4MJH0b8A5
 BG7f1jTaD9Sp4Yf0BiH9yuNYWWshlvXsklcqQmkwjcnVkCu5fKSaPyjPaDpNQgPax+vv
 oyKlyjlAUMJ38YIm+yG0OwT7UY/nYy91ye79oTlxXQmb5dF7OdmuEntGIEiHj6Xveu/i
 06Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4QTTlJo2UeiNv6sGKLTOzmqUnuLAao2lRAIOQi+uXnLXOgN9k/wcSGLi0pbVEG3Ayqqzv7X4=@lists.denx.de
X-Gm-Message-State: AOJu0YxacBj+oS+pEjPz+BvULSHn2y/21KAOB1ppsKyYGuwXHAR8rZCl
 xRzLybJex6+71PI03bnnvnl2eWDJv70y2cI4yeVp8CwF5Bv/oXIPIBns78xbh6lZT9s=
X-Gm-Gg: AY/fxX4XcxxBDtZ1s4EoEaus0FbFmsJ4/8z3WzSTJ+fS3CwPL22XovZxjKOMq7k8sxX
 +ptLvKova2X4XVfCkga/tL3pEwNUk0gvlCniUnfrVlQWpgpxktpEAcQBLduO5YIyeeDo3s+eA11
 DAP6SwMNt3BzBP3SyybH1Z3prmJY/0f8GfYFzn3Zb9YIM1Uuv9FMCswcN4RKfi682A6SXVYvAg3
 D13/fwiuuDsPqshm/QEF55v7FFkb30zumuUqv50u4QLXzzLCIFnOjEpspDiPbot0FXRlMVwHncx
 v65tMae4XFqHCvERaHr0UP6ZQDb5u+0o4UEWml13cUlrUnaVyT7lDDKTSGgnZ9M2etdsAsIRvIJ
 CSvS0nDx3yjUCUjfixWcq/2+Sk77jWNOI89aHTSzRdPNLe7wXqDgMkeaOQrHl5+qIRj+FFO21K/
 QYT8ukpZQ4cSxQvxA=
X-Google-Smtp-Source: AGHT+IEWahqvjVO97F5Lxd24hKoAqX18NcgdmEcZzxQxt9ZW6mw2F5KpMg3vJRVckSH2DM2hf/+TGw==
X-Received: by 2002:a05:6808:159a:b0:450:125d:d9e with SMTP id
 5614622812f47-457b20b0d14mr706132b6e.21.1766100284370; 
 Thu, 18 Dec 2025 15:24:44 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:27 -0600
Subject: [PATCH 7/9] clk: mediatek: allow gates in topckgen drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-7-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VTQb0wPygvFq7lX9ZsvswsYreIjNQQ8htn6irAWc6W8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0cHLUQv2PL/m0/1SE+eqn9uPSi/nNIV4vHt
 O7w4ha2AreJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNHBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2nsH/jE6SysRU8PxFSIe1j1XCk1KIfnQszNlw0nQgDe
 uSvnuPaJtK7qIy6iESq38OMrOw/CHEn/mGL27HKOVrQrYbgaz0UGBBTFDHLznaLCBYJD5Vyspmh
 /ZRdTdCJmjNiY3OY8ULFGS/xXunXi0fVvd13evdq75tN30QrQ9S9p40Py1iLT6POPf6Ly+6e8NQ
 3JsyLfJ0idhJvhfSRqqE6eJrYFok+i95ILEZaT3rgVxfrbxftTVxCdZvRmUr1OS1gwuBdf9z/Kd
 aJ1ciZ86b3BVkMwnHP9K11jKeGDbxyb47lTZwObT72ILXVf8ArpEUPMTwtr2geNhieUFD5SCHD3
 oAlQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Add handling for gates in the topckgen clk drivers. This avoids the need
to have separate topckgen-cg drivers and devicetree nodes for the same
address space and clock ID range.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 61 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e370d304c03..82306ae285c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -582,7 +582,7 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 	if (ret)
 		return ret;
 
-	/* topckgen only uses fclks, fdivs and muxes. */
+	/* topckgen only uses fclks, fdivs, muxes and gates. */
 
 	if (tree->fclks && clk->id < tree->num_fclks)
 		return 0;
@@ -595,6 +595,10 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 	    clk->id < tree->muxes_offs + tree->num_muxes)
 		return 0;
 
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates)
+		return 0;
+
 	return -ENOENT;
 }
 
@@ -696,6 +700,14 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
+	}
 
 	if (clk->id < priv->tree->fdivs_offs)
 		return priv->tree->fclks[clk->id].rate;
@@ -740,6 +752,21 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	return 0;
 }
 
+static int mtk_topckgen_enable(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_gate_enable(priv->base, gate);
+	}
+
+	return mtk_clk_mux_enable(clk);
+}
+
 static int mtk_clk_mux_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -766,13 +793,29 @@ static int mtk_clk_mux_disable(struct clk *clk)
 	return 0;
 }
 
+static int mtk_topckgen_disable(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_gate_disable(priv->base, gate);
+	}
+
+	return mtk_clk_mux_disable(clk);
+}
+
 static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 parent_type;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!priv->tree->muxes || clk->id < priv->tree->muxes_offs ||
+	    clk->id >= priv->tree->muxes_offs + priv->tree->num_muxes)
 		return 0;
 
 	if (!parent_priv)
@@ -821,6 +864,16 @@ static void mtk_topckgen_dump(struct udevice *dev)
 		mtk_clk_print_mux_parents(priv, mux);
 		printf("\n");
 	}
+
+	for (i = 0; i < tree->num_gates; i++) {
+		const struct mtk_gate *gate = &tree->gates[i];
+
+		printf("[GATE%u] DT: %u", i, gate->id);
+		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->gates_offs);
+		mtk_clk_print_single_parent(gate->parent, gate->flags);
+		printf("\n");
+	}
 }
 #endif
 
@@ -1124,8 +1177,8 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 
 const struct clk_ops mtk_clk_topckgen_ops = {
 	.of_xlate = mtk_topckgen_of_xlate,
-	.enable = mtk_clk_mux_enable,
-	.disable = mtk_clk_mux_disable,
+	.enable = mtk_topckgen_enable,
+	.disable = mtk_topckgen_disable,
 	.get_rate = mtk_topckgen_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.43.0

