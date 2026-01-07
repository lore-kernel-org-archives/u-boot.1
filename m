Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0619CFD658
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F5884071;
	Wed,  7 Jan 2026 17:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vTtVxckY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58C28405C; Wed,  7 Jan 2026 16:51:30 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C401584073
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65d132240acso1285227eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801086; x=1768405886;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1g7Mf1akq7KTGjVZGl8MgTI8h2J5H+hHLZsBMzPd4s0=;
 b=vTtVxckYV4ZfFhCpgnpapvrsAvFzmL+1LIwAIGEJ0n3nOgXYK5IVLSTaZaB2LOrRmZ
 9hl2MTdqJc+6UP05bwTUMfsYTJHYARolGUwwZmyttCAmdH2qi+NcYh9FDPIkMyWKxFR/
 XvXpYUc4GP8hjPT11Kvbi8/gVN3VOX4NqRX2MsKeIvACCIiX0wwIitIMdCkfnd3TufuA
 ALqG6UPJOWxUh/Q7D6meFRHm1K23Q0NgA5GlKCvpMd3cU9gwu4wIh5UULlARARfNvVEi
 kaEAewLltTSYffFK7U1EYCJT95S+hVwuZxjVc63GocDPsCsIMEzShe9LQ12Q9SQtn8d0
 g3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801086; x=1768405886;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1g7Mf1akq7KTGjVZGl8MgTI8h2J5H+hHLZsBMzPd4s0=;
 b=uRdmYtXNvXouVN6ZqiwjMD+nIIY6bJO8QeOkLs4fX0WlswJQd2RABjD0T1fq4WZP+p
 rePsSiKhweXrOX5/WOgpnkjXdY0+ngNK1NKi8aglGOOASDXPp2Owfj00c+jbVLGdwxIi
 FUzre8q8APKBoR9aZLvsPRDWsobC9ChYuQiJtNiZVA5ima7WUHB6N/ddtUQvuGlq2mgK
 4yhEqEBaxB+quU3ogavMqKxXT1CXBy5G3CDoZP8uF0KODXQSjrPAj96sHpghGOV/yhgg
 C/T5BrFB8ltPLd5JZJu8i6zFfMIKn8bVdZlJZNkdatzp8Wvg02wJV8pAbMipav7sOgSs
 PG+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3+p0YI2UE57k/fufJLwYq5pPwn/rPd6AWXFb37jtl/nLeIHXh/S7AcAS+IxjEFjTTOK5+70Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9XcqZcT8iS6Xax8xTWlwqdHFUgCbq5T7NCHCCblzE4cfyF1iS
 FXtnyzVDwlM/aqYs0BR02P5p6uCKgg9NYbuozJ5uNLmUmz2+oZbR/jnp06Z1TFQUIAI=
X-Gm-Gg: AY/fxX6fDmAHut6AlbAL7TUdP1SLxNhM/cr8vxmMEFi5Wtbxsqzz5Xq47BSP0gSCnXS
 SPqqlM0e2zGwY4fcK4uiiDp0wbWy2GsrToJpw2pr8ziIdyoJ9Wkn5UPqjHjEuZRR9nSqwQIMb/b
 GuMEnqmKYlSMSu7veSiYBIGitqUj6ygI6Hvq1LLYbKziBL/jx0+ovTJlBpMH308RxxdSRlnVOHx
 k6xbBrasYJ64no655g/yQXAjp6A3b/gzy3oH9KUda7fix5cFY8WRX7yFVTr6ZSae7e3hHbUE9py
 HwmThP2aasshrU/SilrgtPnbTNWyhX8R+cUiGDs/+XxlJXxm/78aXWRDDSugS3QWi+y33Vm9b6L
 YOIVvYPNQCb7S1ESb1DQj9bYfmmWz7NXZvFJ5IVLbjEUv9xYv0d6KTmS/d3Z3w3C+zAPE6vjutf
 xWpvgymgdim3JMXzY=
X-Google-Smtp-Source: AGHT+IE9LkA0g/e0eLqtAPdNXYyqS5IxmZ8N1ikXvEjiWsEKAgfjoXig7Sb4bwhyX181s0BsFma6oA==
X-Received: by 2002:a05:6820:1501:b0:659:9a49:907d with SMTP id
 006d021491bc7-65f550799afmr1144855eaf.72.1767801086472; 
 Wed, 07 Jan 2026 07:51:26 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:14 -0600
Subject: [PATCH v2 4/8] clk: mediatek: organize infrasys functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-4-7d4338e520a1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9172; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TYRtyRMhClQZdqEY+bMNXpL6cr8A1jJOedj+qplCJ40=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDSQFRYRnclYFemRgQvix0dVi7ZbXFKi/ubi
 pXx+PUa7kWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6A0hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3RwH/joJqF5wtT6AYOIcniaG8Pb8ygW6+uDVM+QmgqR
 QGV1LH/CANQJxy5hkKY4Kn0QZD9W37GtI/xA1A235bZyVgvZumz9JmsMFDeC0MkzYIGIRMeshQZ
 smm5PxdpmO4cXuChgrTQh/P+Rj5JjqdlfLRUBji6Ndubf3cd+fgp1UjTPyUpMs4van9IBnSGIin
 FnZCTyxbbfkvAbKM4l2jQN+7PbtVNSj2Qr9IADV8n/GpLLt8ydQhCGJyTiySVtB7BRVmkV63fL1
 1STYpp5GP81bsXfDcnQBq/rCWBRBuCP50KVQ8lMRPFCI83HZ9ip/564WP28f18w3jRkw9cBFOiW
 EH/M=
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

