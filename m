Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B4C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B92885FD;
	Fri, 28 Jun 2024 19:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9HwCxgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A45388612; Fri, 28 Jun 2024 19:41:50 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F09885E7
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-425624255f3so5780905e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596506; x=1720201306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgYcyxjroxaeoCrUNXEhQsZpraNIQLHEIcmRzP9MhFk=;
 b=T9HwCxgVMqldjp0Nc5jpi1LU+pHT8zHuOo7JB+7czB8kyD67p7a4adP9BaDVeeMHIC
 zvKKh/b3BayeF/l4NfujEOmPD1YAbqiZ4g2P/eAb1HJ5NRZhlxnkOSy/XWXJCMuxpKAx
 CHLLs3bZbPyF5Lr6cNOcnUp4Qi9YEQMl0BtZhvY3GjbOw7cSY/xMGgRIqEZtBIW2EzPc
 0MBwnPdMjC9lzKpWNW191NKEovV05lJDpnvH+mp7g78CH3fZAMBArhwxwhtdG6mNwpUZ
 m0wgL8lCb0JXrjwTGXsZ3VKl0CR2ed8Mu/7jVpmj7dqOBv9BJG7lKDB8DvOchZmhx1ts
 9N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596506; x=1720201306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgYcyxjroxaeoCrUNXEhQsZpraNIQLHEIcmRzP9MhFk=;
 b=hDPaOKnmL74QO2fhHs0qKQ2fJTvDKSGQcd4DZ9/RUAJPTFSDOyC/D/ql2tywcmH/Uf
 0vUvjyKWsM+oGhpwq+DQop3vPBeaEN2XIncT0r65VF0trpCZQl9erd51LYlzaywlrlOv
 bjGJVtNRiGJUIb97vjED5GHueNgIZGEekSQuTGGmNgwAa+iLTLAuRMP22naCYnbCgVDM
 fFyoSHvJqjwdPJLBg/O4FjecsTFxt6Z95Oo5fLpaRsbudhkl/wf7I241QJEvilLw2UJ3
 MGb3MkaNc4HP0kPwg1gpOSGOoebpxfF5EfFbHyaysJa3l0iGElgNW4wph1pCy7RsspQ6
 dV3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlo42gkFJ76sHebsoAudvAtBXmUPBybZcMaJeQ3bCsbpOl9o6Eb3TyVe4XVqOiyzXzaZFCF5whwEkKP9Z3Evm/BLLbuQ==
X-Gm-Message-State: AOJu0YxMqgISf36g7q90Ae0JVoUvKYuOQnI8j8y32Ayvz5mFa+SnoO81
 qFo9bu+W3/BEKHa5yXB6aCstq9iC0ACZ/s8yLPRmcMVh9yE7SdRP
X-Google-Smtp-Source: AGHT+IEOHpqsyg2JG1pZ/D6lgxqMgWRyZusAU1G5oBLbMijy8maA0K1qXfa8UYCVlxgAL1Xcnxjv0w==
X-Received: by 2002:a05:600c:1c96:b0:421:811b:b83e with SMTP id
 5b1f17b1804b1-4256d56407amr24222395e9.13.1719596505719; 
 Fri, 28 Jun 2024 10:41:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 11/12] clk: mediatek: add support for GATEs for APMIXED OPs
Date: Fri, 28 Jun 2024 19:40:56 +0200
Message-ID: <20240628174114.8675-12-ansuelsmth@gmail.com>
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

Add support for GATEs for APMIXED OPs. It's possible that some APMIXED
have also gates on top of PLL. This is the case for mt7622. Add support
for this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 144 +++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 096f593fc5c..c1d171624b9 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -47,6 +47,56 @@ static int mtk_clk_get_id(struct clk *clk)
 	return id;
 }
 
+static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
+{
+	u32 bit = BIT(gate->shift);
+
+	switch (gate->flags & CLK_GATE_MASK) {
+	case CLK_GATE_SETCLR:
+		writel(bit, base + gate->regs->clr_ofs);
+		break;
+	case CLK_GATE_SETCLR_INV:
+		writel(bit, base + gate->regs->set_ofs);
+		break;
+	case CLK_GATE_NO_SETCLR:
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
+		break;
+	case CLK_GATE_NO_SETCLR_INV:
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
+{
+	u32 bit = BIT(gate->shift);
+
+	switch (gate->flags & CLK_GATE_MASK) {
+	case CLK_GATE_SETCLR:
+		writel(bit, base + gate->regs->set_ofs);
+		break;
+	case CLK_GATE_SETCLR_INV:
+		writel(bit, base + gate->regs->clr_ofs);
+		break;
+	case CLK_GATE_NO_SETCLR:
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
+		break;
+	case CLK_GATE_NO_SETCLR_INV:
+		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * In case the rate change propagation to parent clocks is undesirable,
  * this function is recursively called to find the parent to calculate
@@ -143,11 +193,10 @@ static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
  * for the integer part and the remaining bits (if present) for the
  * fractional part. Also they have a 3 bit power-of-two post divider.
  */
-static void mtk_pll_set_rate_regs(struct clk *clk, u32 pcw, int postdiv)
+static void mtk_pll_set_rate_regs(struct mtk_clk_priv *priv, u32 id,
+				  u32 pcw, int postdiv)
 {
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
-	int id = mtk_clk_get_id(clk);
 	u32 val, chg;
 
 	pll = &priv->tree->plls[id];
@@ -182,17 +231,16 @@ static void mtk_pll_set_rate_regs(struct clk *clk, u32 pcw, int postdiv)
 
 /**
  * mtk_pll_calc_values - calculate good values for a given input frequency.
- * @clk:	The clk
+ * @priv:	The mtk priv struct
+ * @id:		The clk id
  * @pcw:	The pcw value (output)
  * @postdiv:	The post divider (output)
  * @freq:	The desired target frequency
  */
-static void mtk_pll_calc_values(struct clk *clk, u32 *pcw, u32 *postdiv,
-				u32 freq)
+static void mtk_pll_calc_values(struct mtk_clk_priv *priv, u32 id,
+				u32 *pcw, u32 *postdiv, u32 freq)
 {
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
-	int id = mtk_clk_get_id(clk);
 	unsigned long fmin;
 	u64 _pcw;
 	int ibits;
@@ -220,11 +268,16 @@ static void mtk_pll_calc_values(struct clk *clk, u32 *pcw, u32 *postdiv,
 
 static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 {
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	int id = mtk_clk_get_id(clk);
 	u32 pcw = 0;
 	u32 postdiv;
 
-	mtk_pll_calc_values(clk, &pcw, &postdiv, rate);
-	mtk_pll_set_rate_regs(clk, pcw, postdiv);
+	if (priv->tree->gates && id >= priv->tree->gates_offs)
+		return -EINVAL;
+
+	mtk_pll_calc_values(priv, id, &pcw, &postdiv, rate);
+	mtk_pll_set_rate_regs(priv, id, pcw, postdiv);
 
 	return 0;
 }
@@ -234,9 +287,16 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
 	int id = mtk_clk_get_id(clk);
+	const struct mtk_gate *gate;
 	u32 postdiv;
 	u32 pcw;
 
+	/* GATE handling */
+	if (priv->tree->gates && id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
+	}
+
 	pll = &priv->tree->plls[id];
 
 	postdiv = (readl(priv->base + pll->pd_reg) >> pll->pd_shift) &
@@ -255,8 +315,15 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
 	int id = mtk_clk_get_id(clk);
+	const struct mtk_gate *gate;
 	u32 r;
 
+	/* GATE handling */
+	if (priv->tree->gates && id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+		return mtk_gate_enable(priv->base, gate);
+	}
+
 	pll = &priv->tree->plls[id];
 
 	r = readl(priv->base + pll->pwr_reg) | CON0_PWR_ON;
@@ -287,8 +354,15 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_pll_data *pll;
 	int id = mtk_clk_get_id(clk);
+	const struct mtk_gate *gate;
 	u32 r;
 
+	/* GATE handling */
+	if (priv->tree->gates && id >= priv->tree->gates_offs) {
+		gate = &priv->tree->gates[id - priv->tree->gates_offs];
+		return mtk_gate_disable(priv->base, gate);
+	}
+
 	pll = &priv->tree->plls[id];
 
 	if (pll->flags & HAVE_RST_BAR) {
@@ -580,31 +654,6 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 
 /* CG functions */
 
-static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
-{
-	u32 bit = BIT(gate->shift);
-
-	switch (gate->flags & CLK_GATE_MASK) {
-	case CLK_GATE_SETCLR:
-		writel(bit, base + gate->regs->clr_ofs);
-		break;
-	case CLK_GATE_SETCLR_INV:
-		writel(bit, base + gate->regs->set_ofs);
-		break;
-	case CLK_GATE_NO_SETCLR:
-		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
-		break;
-	case CLK_GATE_NO_SETCLR_INV:
-		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
@@ -632,31 +681,6 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 	return mtk_gate_enable(priv->base, gate);
 }
 
-static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
-{
-	u32 bit = BIT(gate->shift);
-
-	switch (gate->flags & CLK_GATE_MASK) {
-	case CLK_GATE_SETCLR:
-		writel(bit, base + gate->regs->set_ofs);
-		break;
-	case CLK_GATE_SETCLR_INV:
-		writel(bit, base + gate->regs->clr_ofs);
-		break;
-	case CLK_GATE_NO_SETCLR:
-		clrsetbits_le32(base + gate->regs->sta_ofs, bit, bit);
-		break;
-	case CLK_GATE_NO_SETCLR_INV:
-		clrsetbits_le32(base + gate->regs->sta_ofs, bit, 0);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int mtk_clk_gate_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-- 
2.45.1

