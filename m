Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96E8C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B43B885EB;
	Fri, 28 Jun 2024 19:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2bovuqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C744C885D7; Fri, 28 Jun 2024 19:41:40 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A4F885B3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec10324791so9035731fa.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596497; x=1720201297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sh14+y1AYNTyWBkMP+RqMP1y2lhpeWtp7+ltaSrwwDM=;
 b=O2bovuqbqEzs7aT9GcGD7Dyb4jyETimIpc0F1zcTHToFPT6gEmtTTBarfutHhoOZTu
 Slzned4c6gJYwaLVx7GXPGoZV3hdxjRjiDFy4wKWFlH31iH9l9gmGfLlPI3tn2tvrXlP
 TIlv11VfA7tTVOKpJUJWI6zhaHQb34EbiJm4KJWqDsNoNlhk8b3cmse9ENkSZFJausrl
 dgrgOxFkN0tDobr9MwA9htt1ifVIurm4lSLxHKm06u3WXZMSPtdHSPOlDRd9M92cKOXL
 3BCSfcs6iJBzdXWoOdR+LCypTmowj+UssC96VXvGW4j2Np2F5H6bItURHQWB1C0DJCmC
 FWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596497; x=1720201297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sh14+y1AYNTyWBkMP+RqMP1y2lhpeWtp7+ltaSrwwDM=;
 b=BmT24nzGDsNAvZNvG4ME7x3IpJ+EnECBjB3MBoKgyaKf38XEnGAh66qaA1yu34cDyT
 5gyF/V3Tv+SM0NlwfPBFY0LI2ZH5pSg9tgTyNwewRAMlVEslPrnRv1IYnMSl/ng71a2S
 eQTsgiGIRIETlVPmyjA/BK1k7qknO9cTaCqTZOlC+1K03F9w67YuamActxjzTMca44+r
 UPigHf4xC0aG5b3EbBEltyjPHsPtNeooksa0ygPDiiooYQ68FwH8bv15Zawp4DJyLhbS
 fToV8IvqFNNuK+LUZZJUWl1FSX55iM0GT7TI+yp5ovctNzoRDcbSydwTquhwjD+i73aM
 jO5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXDSkS+Nagj3sarZf1oza0dGYOBuSm2+kpFVru+n0ufFMphHDE//snKWNphHIduSGtiCmp1nZw9d7sOVuL4aVl4zDXMg==
X-Gm-Message-State: AOJu0Yx/nRBWHou/53yP5u6FZnz0MRGREq8ZNkJ3r7/41ucye1FpuZ23
 GGgj5o1z5x3Al3C/GEC+Xdbn50SP4fJX54AXQXVkwxlAJGsPqjpd
X-Google-Smtp-Source: AGHT+IHG+zIx069gGN3+2Mp+PNjTcbmWeDmK49jTZPuRgGTkzVIyB6d+4N/1aURbIYvq2Sn/ZodCjA==
X-Received: by 2002:a2e:780a:0:b0:2eb:df39:232b with SMTP id
 38308e7fff4ca-2ec5b27ed94mr107647671fa.20.1719596497566; 
 Fri, 28 Jun 2024 10:41:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 03/12] clk: mediatek: add support for gates in clk_tree for
 infrasys
Date: Fri, 28 Jun 2024 19:40:48 +0200
Message-ID: <20240628174114.8675-4-ansuelsmth@gmail.com>
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

Add support for gates in clk_tree for infrasys ops.

Infracfg clks can have a sum of gates and muxes, and current solution
handle this by duplicating the driver and split clks for mux and clks
for gates. Upstream linux kernel handle this differently and doesn't
have this distinction.

To be closer to the upstream kernel clock definition, implement
additional logic to have gates defined in the clk_tree and implement
variant for the infrasys ops to handle gates defined in the tree.

Similar to how it's done with factor and mux, we introduce gates_offs.
Upstream kernel follow the similar logic with all the ID defined as
FDIVS, MUXES and finally GATES.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 85 ++++++++++++++++++++++++++++------
 drivers/clk/mediatek/clk-mtk.h |  2 +
 2 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 555e2220748..c3c50f4c14b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -404,9 +404,26 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 	} else if (clk->id < priv->tree->muxes_offs) {
 		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
-	} else {
+	/* No gates defined or ID is a MUX */
+	} else if (!priv->tree->gates || clk->id < priv->tree->gates_offs) {
 		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
 						 priv->tree->muxes_offs);
+	/* Only valid with muxes + gates implementation */
+	} else {
+		struct udevice *parent = NULL;
+		const struct mtk_gate *gate;
+
+		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
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
 	}
 
 	return rate;
@@ -484,24 +501,22 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 
 /* CG functions */
 
-static int mtk_clk_gate_enable(struct clk *clk)
+static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
 {
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate = &priv->gates[clk->id];
 	u32 bit = BIT(gate->shift);
 
 	switch (gate->flags & CLK_GATE_MASK) {
 	case CLK_GATE_SETCLR:
-		writel(bit, priv->base + gate->regs->clr_ofs);
+		writel(bit, base + gate->regs->clr_ofs);
 		break;
 	case CLK_GATE_SETCLR_INV:
-		writel(bit, priv->base + gate->regs->set_ofs);
+		writel(bit, base + gate->regs->set_ofs);
 		break;
 	case CLK_GATE_NO_SETCLR:
-		clrsetbits_le32(priv->base + gate->regs->sta_ofs, bit, 0);
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
 		break;
 	case CLK_GATE_NO_SETCLR_INV:
-		clrsetbits_le32(priv->base + gate->regs->sta_ofs, bit, bit);
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
 		break;
 
 	default:
@@ -511,24 +526,43 @@ static int mtk_clk_gate_enable(struct clk *clk)
 	return 0;
 }
 
-static int mtk_clk_gate_disable(struct clk *clk)
+static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate = &priv->gates[clk->id];
+
+	return mtk_gate_enable(priv->base, gate);
+}
+
+static int mtk_clk_infrasys_enable(struct clk *clk)
+{
+	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_gate *gate;
+
+	/* MUX handling */
+	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+		return mtk_clk_mux_enable(clk);
+
+	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
+	return mtk_gate_enable(priv->base, gate);
+}
+
+static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
+{
 	u32 bit = BIT(gate->shift);
 
 	switch (gate->flags & CLK_GATE_MASK) {
 	case CLK_GATE_SETCLR:
-		writel(bit, priv->base + gate->regs->set_ofs);
+		writel(bit, base + gate->regs->set_ofs);
 		break;
 	case CLK_GATE_SETCLR_INV:
-		writel(bit, priv->base + gate->regs->clr_ofs);
+		writel(bit, base + gate->regs->clr_ofs);
 		break;
 	case CLK_GATE_NO_SETCLR:
-		clrsetbits_le32(priv->base + gate->regs->sta_ofs, bit, bit);
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
 		break;
 	case CLK_GATE_NO_SETCLR_INV:
-		clrsetbits_le32(priv->base + gate->regs->sta_ofs, bit, 0);
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
 		break;
 
 	default:
@@ -538,6 +572,27 @@ static int mtk_clk_gate_disable(struct clk *clk)
 	return 0;
 }
 
+static int mtk_clk_gate_disable(struct clk *clk)
+{
+	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_gate *gate = &priv->gates[clk->id];
+
+	return mtk_gate_disable(priv->base, gate);
+}
+
+static int mtk_clk_infrasys_disable(struct clk *clk)
+{
+	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_gate *gate;
+
+	/* MUX handling */
+	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+		return mtk_clk_mux_disable(clk);
+
+	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
+	return mtk_gate_disable(priv->base, gate);
+}
+
 static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
@@ -568,8 +623,8 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 };
 
 const struct clk_ops mtk_clk_infrasys_ops = {
-	.enable = mtk_clk_mux_enable,
-	.disable = mtk_clk_mux_disable,
+	.enable = mtk_clk_infrasys_enable,
+	.disable = mtk_clk_infrasys_disable,
 	.get_rate = mtk_infrasys_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 };
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 48ce16484ec..8dde9e56e81 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -200,10 +200,12 @@ struct mtk_clk_tree {
 	unsigned long xtal2_rate;
 	const int fdivs_offs;
 	const int muxes_offs;
+	const int gates_offs;
 	const struct mtk_pll_data *plls;
 	const struct mtk_fixed_clk *fclks;
 	const struct mtk_fixed_factor *fdivs;
 	const struct mtk_composite *muxes;
+	const struct mtk_gate *gates;
 	u32 flags;
 };
 
-- 
2.45.1

