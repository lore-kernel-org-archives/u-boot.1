Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD77D6E2B1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83242839A8;
	Thu, 18 Dec 2025 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MDSI696y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1258367F; Thu, 18 Dec 2025 18:18:16 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D7180077
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-659848c994bso439879eaf.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078287; x=1766683087;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1g7Mf1akq7KTGjVZGl8MgTI8h2J5H+hHLZsBMzPd4s0=;
 b=MDSI696ykKHIZQh4vIuLkWzrYXVHN1Sy0T882gADE51Cj3OPi9gP3/PUnMXLp80bnN
 VmIxAmPCeL+SUcc3LZf3S6SCaoYJUKmDrcsUFC2BhwEbMflvpylEVMaOnsSf9BOwwgnx
 7XIxH7G+pdap67FwyuuCuLsuzq7eCRyYxsC3WClYaqNVJz2MMlaOx9DKm39AsbTlvc4A
 oU2rk8iEZj0uwg0snzCH0s0citY14UgAuqFynzAZ+iZdzR+XBajIk5qHBN3ENxwRDcyZ
 Z/2youbHVw2X0oasRVC+qCJd/oqiCi7ADp8UNZMm8x93poDNGZk28rqPf9eQp61WDJNY
 kobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078287; x=1766683087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1g7Mf1akq7KTGjVZGl8MgTI8h2J5H+hHLZsBMzPd4s0=;
 b=W67zJiyu1npkUkVKUTtmjo0tjgiPdBrkENeEYOaD/jDfSPYcpnVd2hfQ+q0nxYc6s0
 d9s9WmqAZECzxNEpb6PsWwF9kvF/UWYq4PdHuj3Fxtq10F88ZDQWN9YABYDlCCJEmGO+
 dB6tJjKPoG41exTp+mjnsDgHkA7p69jAVqKLDPOmNktxWem1JeHDYB3CzRt7OOLElzL9
 QKTVwXuooNHP1NV4593oWlZjvtR+lUL79p3+Hm2TXhvODApQEH98l3lla8CXiKUSIgfi
 7geA8wAnnclSjDaO+baHOzfFtb+DP112cnUM3xEFYAPqsSro5XJidkiWMxUbEfcJqh1G
 Zwog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH2d3MZQfMK19Wm6L6oXD9jV0K6TxMWynoP76nIp/+rw/fNdhKizsndFRjz/nmhh56QSsFevA=@lists.denx.de
X-Gm-Message-State: AOJu0YwQIZSeY5wzvIj7mhFR/Up5aWvz8ggKM2Uy3S8rVwzdpLoYO3b5
 c9LDqbaalyOMWZczQGmJMR9PbUw+cE6NHnt9tvUmViGVTWKRsexdBZblcOs8/4DgUBQ=
X-Gm-Gg: AY/fxX77TpY+r5tytCTKf31f6ZWZ7BfKuU5yLB4EELZxALGAOwDUbYGKP4cM3XAHqZX
 mwKsLnCtZoouMEeXfGdfnDbG2WQSBQ/lEVU3sk8W35UjZjufmCshf0XTvGdFFIZtHeRtXwMzY6T
 maOcDOSELaZFnS++PCYEf6lQ0Pa8k0Ic1EPpSYAuW8+4oTz42Z1kZlnQm0t7LQS+q5iHxKNzKZA
 +LM3oUVmxa8PImb9KQBrugz1G0cq3DGUqAY/0l21mZL5lDctY8hTYr73Yy2BrKzG1Ph4arJp3oN
 9y0cktHm55qQLqQKN+qGlqPffZbiWSVd4or9LQjWUouhSaiGsuUTs3yiRm6rvgMNRLuP026MvJJ
 gypcjMSWrRXL/eB6NvqMLhkY6wU8vn0VIOk1YYfp21bMtFefXeGuBWYwRCFyYvJv17zXLTiiqu5
 Fo0BAcgJacrsQCK6g=
X-Google-Smtp-Source: AGHT+IEExEek4qo+w2Xrzm9Rtr+u5cyB0Sp8bhbMHtWNMU8dKmxeuzYW4XdHTlIlP1d0STIdm4yGzA==
X-Received: by 2002:a05:6820:178:b0:659:9a49:8fe8 with SMTP id
 006d021491bc7-65d0e9620c8mr88889eaf.21.1766078287438; 
 Thu, 18 Dec 2025 09:18:07 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:02 -0600
Subject: [PATCH 4/8] clk: mediatek: organize infrasys functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-4-72db131ba148@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9172; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TYRtyRMhClQZdqEY+bMNXpL6cr8A1jJOedj+qplCJ40=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDcpLyqCg62VGWD0Qiq5lY9uvaHYy341900/G
 fuKDZ3gwxqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3KRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACaUH/i3t73n2Nj27jot8Q0f82Rh+L54CI3ifZ7BVgpt
 e8AX+MD8PqPYcIdFhMI0BxstgzI9JEanauUjXWBSy5HQtttiXliot71nIV9L+LaqqvFGuoKJlvE
 LJ7eTpEykNXhYBOW1OYCWSdhWhxawoIzhT3kqNT/kLpY5hrRaTlUbK3ALxW1ypvQAGhAZzbshl6
 xJjEjjl+aOploGvwlOwRESSiqORzfUhUiz50ej/rzq3u/R/taZNpqlGzofK+S71+A8P4MFHKbST
 IJmOMaZ1YZGOZzSsDmvP3GGkcDwCdIeByuGCfB6D0TahdbzeAswFgmfo9wD7Yh49ZHR0R58DdIk
 DxY8=
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

Move all infrasys ops and related functions next to each other in the
file for better organization.

Generally all ops functions are grouped together like this for the other
ops types (apmixedsys, topckgen, etc). However the infrasys functions
were mixed in with the other sections making them harder to find. This
will also give a logical place to add any future infrasys-specific
functions.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Note: the diff looks a bit strange because some functions were quite
similar, but this is just cut and paste reordering of 5 functions
without changing any code.
---
 drivers/clk/mediatek/clk-mtk.c | 200 +++++++++++++++++++++--------------------
 1 file changed, 101 insertions(+), 99 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index ffaecbfd306..6ed0f23f685 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -424,27 +424,6 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
-	ulong rate;
-
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
-	return mtk_factor_recalc_rate(fdiv, rate);
-}
-
 static ulong mtk_topckgen_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 					   const int parent, u16 flags)
 {
@@ -504,33 +483,6 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 	}
 }
 
-static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_composite *mux = &priv->tree->muxes[off];
-	u32 index;
-
-	index = readl(priv->base + mux->mux_reg);
-	index &= mux->mux_mask << mux->mux_shift;
-	index = index >> mux->mux_shift;
-
-	/*
-	 * Parents can be either from TOPCKGEN or INFRACFG,
-	 * inspect the mtk_parent struct to check the source
-	 */
-	if (mux->flags & CLK_PARENT_MIXED) {
-		const struct mtk_parent *parent = &mux->parent_flags[index];
-
-		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-	}
-
-	if (mux->parent[index] == CLK_XTAL &&
-	    !(priv->tree->flags & CLK_BYPASS_XTAL))
-		return priv->tree->xtal_rate;
-
-	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
-}
-
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -546,42 +498,6 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 						 priv->tree->muxes_offs);
 }
 
-static ulong mtk_infrasys_get_rate(struct clk *clk)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	int id = mtk_clk_get_id(clk);
-	ulong rate;
-
-	if (id < priv->tree->fdivs_offs) {
-		rate = priv->tree->fclks[id].rate;
-	} else if (id < priv->tree->muxes_offs) {
-		rate = mtk_infrasys_get_factor_rate(clk, id -
-						    priv->tree->fdivs_offs);
-	/* No gates defined or ID is a MUX */
-	} else if (!priv->tree->gates || id < priv->tree->gates_offs) {
-		rate = mtk_infrasys_get_mux_rate(clk, id -
-						 priv->tree->muxes_offs);
-	/* Only valid with muxes + gates implementation */
-	} else {
-		struct udevice *parent = NULL;
-		const struct mtk_gate *gate;
-
-		gate = &priv->tree->gates[id - priv->tree->gates_offs];
-		if (gate->flags & CLK_PARENT_TOPCKGEN)
-			parent = priv->parent;
-		/*
-		 * Assume xtal_rate to be declared if some gates have
-		 * XTAL as parent
-		 */
-		else if (gate->flags & CLK_PARENT_XTAL)
-			return priv->tree->xtal_rate;
-
-		rate = mtk_clk_find_parent_rate(clk, gate->parent, parent);
-	}
-
-	return rate;
-}
-
 static int mtk_clk_mux_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -661,22 +577,23 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 			&priv->tree->muxes[id - priv->tree->muxes_offs]);
 }
 
-/* CG functions */
+/* infrasys functions */
 
-static int mtk_clk_gate_enable(struct clk *clk)
+static int mtk_clk_infrasys_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	if (id < priv->tree->gates_offs)
-		return -EINVAL;
+	/* MUX handling */
+	if (!priv->tree->gates || id < priv->tree->gates_offs)
+		return mtk_clk_mux_enable(clk);
 
-	gate = &priv->gates[id - priv->tree->gates_offs];
+	gate = &priv->tree->gates[id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
-static int mtk_clk_infrasys_enable(struct clk *clk)
+static int mtk_clk_infrasys_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	int id = mtk_clk_get_id(clk);
@@ -684,13 +601,99 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 
 	/* MUX handling */
 	if (!priv->tree->gates || id < priv->tree->gates_offs)
-		return mtk_clk_mux_enable(clk);
+		return mtk_clk_mux_disable(clk);
 
 	gate = &priv->tree->gates[id - priv->tree->gates_offs];
-	return mtk_gate_enable(priv->base, gate);
+	return mtk_gate_disable(priv->base, gate);
 }
 
-static int mtk_clk_gate_disable(struct clk *clk)
+static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
+	ulong rate;
+
+	switch (fdiv->flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_TOPCKGEN:
+		rate = mtk_clk_find_parent_rate(clk, fdiv->parent,
+						priv->parent);
+		break;
+	case CLK_PARENT_XTAL:
+		rate = priv->tree->xtal_rate;
+		break;
+	default:
+		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
+	}
+
+	return mtk_factor_recalc_rate(fdiv, rate);
+}
+
+static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_composite *mux = &priv->tree->muxes[off];
+	u32 index;
+
+	index = readl(priv->base + mux->mux_reg);
+	index &= mux->mux_mask << mux->mux_shift;
+	index = index >> mux->mux_shift;
+
+	/*
+	 * Parents can be either from TOPCKGEN or INFRACFG,
+	 * inspect the mtk_parent struct to check the source
+	 */
+	if (mux->flags & CLK_PARENT_MIXED) {
+		const struct mtk_parent *parent = &mux->parent_flags[index];
+
+		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	}
+
+	if (mux->parent[index] == CLK_XTAL &&
+	    !(priv->tree->flags & CLK_BYPASS_XTAL))
+		return priv->tree->xtal_rate;
+
+	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
+}
+
+static ulong mtk_infrasys_get_rate(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
+	ulong rate;
+
+	if (id < priv->tree->fdivs_offs) {
+		rate = priv->tree->fclks[id].rate;
+	} else if (id < priv->tree->muxes_offs) {
+		rate = mtk_infrasys_get_factor_rate(clk, id -
+						    priv->tree->fdivs_offs);
+	/* No gates defined or ID is a MUX */
+	} else if (!priv->tree->gates || id < priv->tree->gates_offs) {
+		rate = mtk_infrasys_get_mux_rate(clk, id -
+						 priv->tree->muxes_offs);
+	/* Only valid with muxes + gates implementation */
+	} else {
+		struct udevice *parent = NULL;
+		const struct mtk_gate *gate;
+
+		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+		if (gate->flags & CLK_PARENT_TOPCKGEN)
+			parent = priv->parent;
+		/*
+		 * Assume xtal_rate to be declared if some gates have
+		 * XTAL as parent
+		 */
+		else if (gate->flags & CLK_PARENT_XTAL)
+			return priv->tree->xtal_rate;
+
+		rate = mtk_clk_find_parent_rate(clk, gate->parent, parent);
+	}
+
+	return rate;
+}
+
+/* CG functions */
+
+static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	int id = mtk_clk_get_id(clk);
@@ -700,20 +703,19 @@ static int mtk_clk_gate_disable(struct clk *clk)
 		return -EINVAL;
 
 	gate = &priv->gates[id - priv->tree->gates_offs];
-	return mtk_gate_disable(priv->base, gate);
+	return mtk_gate_enable(priv->base, gate);
 }
 
-static int mtk_clk_infrasys_disable(struct clk *clk)
+static int mtk_clk_gate_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	int id = mtk_clk_get_id(clk);
 	const struct mtk_gate *gate;
 
-	/* MUX handling */
-	if (!priv->tree->gates || id < priv->tree->gates_offs)
-		return mtk_clk_mux_disable(clk);
+	if (id < priv->tree->gates_offs)
+		return -EINVAL;
 
-	gate = &priv->tree->gates[id - priv->tree->gates_offs];
+	gate = &priv->gates[id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 

-- 
2.43.0

