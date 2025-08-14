Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF6CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B0483946;
	Thu, 14 Aug 2025 15:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yd9hlWE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331C483957; Thu, 14 Aug 2025 15:13:32 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736C8838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2e8e2d2dso555444b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177207; x=1755782007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8KixXSOrvKlx7rakUUG8HgGtQ69VB2uq4aX2Q7z1is=;
 b=Yd9hlWE5BzdN0gmtZSamz9IU7LPXfYpf5NeWWfYdW4+j0X1AwUsxdLQQ365VNZDXSC
 G7Dz6eYnqEjG1FrM0uNsiYcfKOWIiS9Obp8eegJ+FhC8onv2XPnbwEdinuYajXOC7Z3F
 fGajR+MuUXxkXebrqf8YFDiTlJ/JeNSh9EqCxQ1UCzCxyAAd4TkmVZHNvP7py9OpZymj
 mExyP57pQG3deaWIFi9s8ub9dVaG7SmlTvS/PAXB1qL47iRsmFbvQS/RGkIFOps/epUa
 ABeB5L+kTV3B6EMi2Wt/UAkm1gIuQ6xVIu+B8/R0nyLAp1SvnBmpn94yy58UkAMaWa/T
 osRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177207; x=1755782007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8KixXSOrvKlx7rakUUG8HgGtQ69VB2uq4aX2Q7z1is=;
 b=WUMo0NZYsU4vy0qeGSuhdzDJZP/r9JTkxkYcEh7lZoZ5Bi2aP+VSalu5wEwNEpjkbF
 zDdK0Ge42vkubBmxrKu7wjzSwuMhCDCuxePIGyvDBPt3+0sgkhRMQ3n0uzlH+AwbfyBf
 wjffdOHFLkFlDvZ+hp7nbl8qK0J2BiDCCk2W6QA39eVJLibqVG+HfyGQaDEy268ZP+Tn
 oNfDRcHsAfv+RY4sZU5sltzfoJs1DLsggdQcwDIlrH8wSs7fX4GtWMwjhIDJMalibCTm
 Cq+zLUECD9Jyw5xl2nXiH574Xq/WrVWs0AhshnwnEFs+GSWnxK8ug2K9wltTUTiGx0bB
 mELw==
X-Gm-Message-State: AOJu0YwJX4DOQUlFIIIzbxpL5vYOwHfO4eNfvlGJtNPOj7OX7YgeWGIT
 7m7rq77ga8L588vgQcBID7G5WWjd9uTF7VRNY+qd/jQRis9ZRVIEiYk62sgxO3BMcZkfPAmg
X-Gm-Gg: ASbGnctpomLoFxdxX0nrPurgAhFW6eRKKa7MTdD1iO77beUpCATYRSO31Q+msnifKz0
 gXvABmUdURnYnYrQ7ndSJV7YDb4wFd/1fSVlPzA/U+13+EM7iCBh7z9ekNAXud9+Y/vAfrfN0Ui
 cmfMeJjGEtYzA4n70icXef5xLn7Aq5BYvxKUUzGQXBBhD0EmeUPBWxfbN3RlcoSDh4kiSIhlRpP
 I5EyG6q1MAPV4MVbIQJlR9IAV4tiYnETEPP8xCsYmZpD0ba/c/NdNquyoCcB14O6eOzmG00loCm
 SSIDtbZPPs/FB+JKxlzP0IKmrL31v4RbTx0lQHsAocveJGCt208nAbopwd4AhWuy6qJu5If6x1m
 eIgiD+VQ32L4b4sc3t57nNuE+Un59xWkzACtNlA==
X-Google-Smtp-Source: AGHT+IGtspftymplxhUh/mhUCYrAyu0RlsvWZs2S5pEQgz5MG8jkFKlf5O4Ytqov7tiH+ivFo9gNWQ==
X-Received: by 2002:a17:902:e790:b0:240:770f:72d1 with SMTP id
 d9443c01a7336-244584f5674mr45282955ad.24.1755177207430; 
 Thu, 14 Aug 2025 06:13:27 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:13:26 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 3/5] clk: rockchip: rk3368: Add VOP clock get/set
Date: Thu, 14 Aug 2025 21:12:35 +0800
Message-Id: <20250814131237.8135-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131237.8135-1-cn.liweihao@gmail.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
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

Clock driver need provide VOP related clocks support if we need display
support, this patch add VOP clock support for rk3368.

This patch get form Rockchip downstream uboot repository.

Link: https://github.com/rockchip-linux/u-boot

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../include/asm/arch-rockchip/cru_rk3368.h    |  22 ++
 drivers/clk/rockchip/clk_rk3368.c             | 240 +++++++++++++++++-
 2 files changed, 257 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
index 845113f13..4e2def4dd 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
@@ -102,6 +102,28 @@ enum {
 	MCU_CLK_DIV_SHIFT		= 0,
 	MCU_CLK_DIV_MASK		= GENMASK(4, 0),
 
+	/* CLKSEL19_CON */
+	ACLK_VOP_PLL_SEL_SHIFT		= 6,
+	ACLK_VOP_PLL_SEL_MASK		= GENMASK(7, 6),
+	ACLK_VOP_PLL_SEL_CPLL		= 0,
+	ACLK_VOP_PLL_SEL_GPLL		= 1,
+	ACLK_VOP_DIV_SHIFT		= 0,
+	ACLK_VOP_DIV_MASK		= GENMASK(4, 0),
+
+	/* CLKSEL20_CON */
+	DCLK_VOP_PLL_SEL_SHIFT		= 8,
+	DCLK_VOP_PLL_SEL_MASK		= GENMASK(9, 8),
+	DCLK_VOP_PLL_SEL_CPLL		= 0,
+	DCLK_VOP_PLL_SEL_GPLL		= 1,
+	DCLK_VOP_PLL_SEL_NPLL		= 2,
+	DCLK_VOP_DIV_SHIFT		= 0,
+	DCLK_VOP_DIV_MASK		= GENMASK(7, 0),
+
+	/* CLKSEL21_CON */
+	HCLK_VOP_DIV_SHIFT		= 0,
+	HCLK_VOP_DIV_MASK		= GENMASK(5, 0),
+	HCLK_VOP_DIV_WIDTH		= 5,
+
 	/* CLKSEL_CON25 */
 	CLK_SARADC_DIV_CON_SHIFT	= 8,
 	CLK_SARADC_DIV_CON_MASK		= GENMASK(15, 8),
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index f9936fb40..b260391ad 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -31,9 +31,27 @@ struct rk3368_clk_plat {
 #endif
 
 struct pll_div {
+	ulong rate;
 	u32 nr;
 	u32 nf;
 	u32 no;
+	u32 nb;
+};
+
+#define RK3368_PLL_RATE(_rate, _nr, _nf, _no, _nb)	\
+{							\
+	.rate	= _rate##U,				\
+	.nr = _nr,					\
+	.nf = _nf,					\
+	.no = _no,					\
+	.nb = _nb,					\
+}
+
+static struct pll_div rk3368_pll_rates[] = {
+	/* _mhz,  _nr, _nf, _no, _nb */
+	RK3368_PLL_RATE(594000000, 1, 99, 4, 16),
+	RK3368_PLL_RATE(424200000, 5, 707, 8, 0),
+	RK3368_PLL_RATE(410000000, 3, 205, 4, 16),
 };
 
 #define OSC_HZ		(24 * 1000 * 1000)
@@ -41,6 +59,7 @@ struct pll_div {
 #define APLL_B_HZ	(816 * 1000 * 1000)
 #define GPLL_HZ		(576 * 1000 * 1000)
 #define CPLL_HZ		(400 * 1000 * 1000)
+#define NPLL_HZ		(594 * 1000 * 1000)
 
 #define DIV_TO_RATE(input_rate, div)    ((input_rate) / ((div) + 1))
 
@@ -61,6 +80,105 @@ static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 6);
 
 static ulong rk3368_clk_get_rate(struct clk *clk);
 
+#define VCO_MAX_KHZ	2200000
+#define VCO_MIN_KHZ	440000
+#define FREF_MAX_KHZ	2200000
+#define FREF_MIN_KHZ	269
+#define PLL_LIMIT_FREQ	400000000
+
+struct pll_div *rkclk_get_pll_config(ulong freq_hz)
+{
+	unsigned int rate_count = ARRAY_SIZE(rk3368_pll_rates);
+	int i;
+
+	for (i = 0; i < rate_count; i++) {
+		if (freq_hz == rk3368_pll_rates[i].rate)
+			return &rk3368_pll_rates[i];
+	}
+	return NULL;
+}
+
+static int pll_para_config(ulong freq_hz, struct pll_div *div, uint *ext_div)
+{
+	struct pll_div *best_div = NULL;
+	uint ref_khz = OSC_HZ / 1000, nr, nf = 0;
+	uint fref_khz;
+	uint diff_khz, best_diff_khz;
+	const uint max_nr = 1 << 6, max_nf = 1 << 12, max_no = 1 << 4;
+	uint vco_khz;
+	uint no = 1;
+	uint freq_khz = freq_hz / 1000;
+
+	if (!freq_hz) {
+		printf("%s: the frequency can not be 0 Hz\n", __func__);
+		return -EINVAL;
+	}
+
+	no = DIV_ROUND_UP(VCO_MIN_KHZ, freq_khz);
+	if (ext_div) {
+		*ext_div = DIV_ROUND_UP(PLL_LIMIT_FREQ, freq_hz);
+		no = DIV_ROUND_UP(no, *ext_div);
+	}
+
+	best_div = rkclk_get_pll_config(freq_hz * (*ext_div));
+	if (best_div) {
+		div->nr = best_div->nr;
+		div->nf = best_div->nf;
+		div->no = best_div->no;
+		div->nb = best_div->nb;
+		return 0;
+	}
+
+	/* only even divisors (and 1) are supported */
+	if (no > 1)
+		no = DIV_ROUND_UP(no, 2) * 2;
+
+	vco_khz = freq_khz * no;
+	if (ext_div)
+		vco_khz *= *ext_div;
+
+	if (vco_khz < VCO_MIN_KHZ || vco_khz > VCO_MAX_KHZ || no > max_no) {
+		printf("%s: Cannot find out VCO for Frequency (%luHz).\n",
+		       __func__, freq_hz);
+		return -1;
+	}
+
+	div->no = no;
+
+	best_diff_khz = vco_khz;
+	for (nr = 1; nr < max_nr && best_diff_khz; nr++) {
+		fref_khz = ref_khz / nr;
+		if (fref_khz < FREF_MIN_KHZ)
+			break;
+		if (fref_khz > FREF_MAX_KHZ)
+			continue;
+
+		nf = vco_khz / fref_khz;
+		if (nf >= max_nf)
+			continue;
+		diff_khz = vco_khz - nf * fref_khz;
+		if (nf + 1 < max_nf && diff_khz > fref_khz / 2) {
+			nf++;
+			diff_khz = fref_khz - diff_khz;
+		}
+
+		if (diff_khz >= best_diff_khz)
+			continue;
+
+		best_diff_khz = diff_khz;
+		div->nr = nr;
+		div->nf = nf;
+	}
+
+	if (best_diff_khz > 4 * 1000) {
+		printf("%s:Fail to match output freq %lu,best_is %u Hz\n",
+		       __func__, freq_hz, best_diff_khz * 1000);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Get pll rate by id */
 static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 				   enum rk3368_pll_id pll_id)
@@ -88,7 +206,6 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 	}
 }
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 			 const struct pll_div *div)
 {
@@ -128,7 +245,6 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 
 	return 0;
 }
-#endif
 
 #if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static void rkclk_init(struct rk3368_cru *cru)
@@ -531,6 +647,104 @@ static ulong rk3368_bus_set_clk(struct rk3368_cru *cru,
 	}
 	return rk3368_bus_get_clk(cru, clk_id);
 }
+
+static ulong rk3368_vop_get_clk(struct rk3368_cru *cru,  int clk_id)
+{
+	u32 div, con, parent, sel;
+
+	switch (clk_id) {
+	case DCLK_VOP:
+		con = readl(&cru->clksel_con[20]);
+		div = con & DCLK_VOP_DIV_MASK;
+		parent = rkclk_pll_get_rate(cru, NPLL);
+		break;
+	case ACLK_VOP:
+		con = readl(&cru->clksel_con[19]);
+		div = con & ACLK_VOP_DIV_MASK;
+		sel =  (con & (ACLK_VOP_PLL_SEL_MASK <<
+			ACLK_VOP_PLL_SEL_SHIFT)) >>
+			ACLK_VOP_PLL_SEL_SHIFT;
+		if (sel == ACLK_VOP_PLL_SEL_CPLL)
+			parent = rkclk_pll_get_rate(cru, CPLL);
+		else if (ACLK_VOP_PLL_SEL_GPLL)
+			parent = rkclk_pll_get_rate(cru, GPLL);
+		else
+			parent = 480000000;
+		break;
+	case HCLK_VOP:
+		parent = rk3368_vop_get_clk(cru, ACLK_VOP);
+		con = readl(&cru->clksel_con[21]);
+		div = con & HCLK_VOP_DIV_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3368_vop_set_clk(struct rk3368_cru *cru, int clk_id, uint hz)
+{
+	struct pll_div npll_config = {0};
+	u32 lcdc_div;
+	int ret;
+
+	switch (clk_id) {
+	case DCLK_VOP:
+		if (!(NPLL_HZ % hz)) {
+			rkclk_set_pll(cru, NPLL, rkclk_get_pll_config(NPLL_HZ));
+			lcdc_div = NPLL_HZ / hz;
+		} else {
+			ret = pll_para_config(hz, &npll_config, &lcdc_div);
+			if (ret)
+				return ret;
+
+			rkclk_set_pll(cru, NPLL, &npll_config);
+		}
+		/* vop dclk source clk: npll,dclk_div: 1 */
+		rk_clrsetreg(&cru->clksel_con[20],
+			     (DCLK_VOP_PLL_SEL_MASK << DCLK_VOP_PLL_SEL_SHIFT) |
+			     (DCLK_VOP_DIV_MASK << DCLK_VOP_DIV_SHIFT),
+			     (DCLK_VOP_PLL_SEL_NPLL << DCLK_VOP_PLL_SEL_SHIFT) |
+			     (lcdc_div - 1) << DCLK_VOP_DIV_SHIFT);
+		break;
+	case ACLK_VOP:
+		if ((rkclk_pll_get_rate(cru, CPLL) % hz) == 0) {
+			lcdc_div = rkclk_pll_get_rate(cru, CPLL) / hz;
+			rk_clrsetreg(&cru->clksel_con[19],
+				     (ACLK_VOP_PLL_SEL_MASK <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (ACLK_VOP_DIV_MASK <<
+				     ACLK_VOP_DIV_SHIFT),
+				     (ACLK_VOP_PLL_SEL_CPLL <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (lcdc_div - 1) <<
+				     ACLK_VOP_DIV_SHIFT);
+		} else {
+			lcdc_div = rkclk_pll_get_rate(cru, GPLL) / hz;
+			rk_clrsetreg(&cru->clksel_con[19],
+				     (ACLK_VOP_PLL_SEL_MASK <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (ACLK_VOP_DIV_MASK <<
+				     ACLK_VOP_DIV_SHIFT),
+				     (ACLK_VOP_PLL_SEL_GPLL <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (lcdc_div - 1) <<
+				     ACLK_VOP_DIV_SHIFT);
+		}
+		break;
+	case HCLK_VOP:
+		lcdc_div = rk3368_vop_get_clk(cru, ACLK_VOP) / hz;
+		rk_clrsetreg(&cru->clksel_con[21],
+			     HCLK_VOP_DIV_MASK,
+			     (lcdc_div - 1) << HCLK_VOP_DIV_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rk3368_vop_get_clk(cru, clk_id);
+}
 #endif
 
 static ulong rk3368_clk_get_rate(struct clk *clk)
@@ -540,11 +754,13 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 
 	debug("%s: id %ld\n", __func__, clk->id);
 	switch (clk->id) {
+	case PLL_APLLB:
+	case PLL_APLLL:
+	case PLL_DPLL:
 	case PLL_CPLL:
-		rate = rkclk_pll_get_rate(priv->cru, CPLL);
-		break;
 	case PLL_GPLL:
-		rate = rkclk_pll_get_rate(priv->cru, GPLL);
+	case PLL_NPLL:
+		rate = rkclk_pll_get_rate(priv->cru, clk->id - 1);
 		break;
 	case SCLK_SPI0 ... SCLK_SPI2:
 		rate = rk3368_spi_get_clk(priv->cru, clk->id);
@@ -571,6 +787,13 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 	case SCLK_SARADC:
 		rate = rk3368_saradc_get_clk(priv->cru);
 		break;
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	case ACLK_VOP:
+	case DCLK_VOP:
+	case HCLK_VOP:
+		rate = rk3368_vop_get_clk(priv->cru, clk->id);
+		break;
+#endif
 	default:
 		return -ENOENT;
 	}
@@ -617,6 +840,13 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SARADC:
 		ret =  rk3368_saradc_set_clk(priv->cru, rate);
 		break;
+#if !defined(CONFIG_XPL_BUILD)
+	case ACLK_VOP:
+	case DCLK_VOP:
+	case HCLK_VOP:
+		ret = rk3368_vop_set_clk(priv->cru, clk->id, rate);
+		break;
+#endif
 	default:
 		return -ENOENT;
 	}
-- 
2.39.5

