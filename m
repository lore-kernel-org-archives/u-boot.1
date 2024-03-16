Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF201C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA1A8809A;
	Sat, 16 Mar 2024 23:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="csMfpwPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D1888091; Sat, 16 Mar 2024 23:57:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786818809D
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629845; bh=FX3CTnH5AmlHvGoCs7688ef4VhBx8vs7eaGSz/4ODwM=;
 b=csMfpwPWk66sEJ+SeF2BsqmUGns6NHDkiGZwhmg8Xx6BheoCevRFWeGhHMOJdgG3R/QqoA1CG
 OR7Zxe9Xw/+fYJTd2295y+DNowbCWYfIezoqf5CTgtYwm0+oRTEkpXzFOQa3kYBbEUEGE8xgQbD
 xjDn0x9Nvyf9JB7XoJC8cRONFr8pgXncK0gUY140bczoLsIWVcji8j8IYkY9Bvry6YQUxkHSvW/
 labpFIKAYT4ZJWZ+kESh9d4Dphzkaw82JqlQY7Jb3IR8A10El5JXbVzR/9S5j3w+TEIOt82nf+n
 IdDYFgq3K62Gwj0RrhW63gtp4tw0BO+9csLqxNKbT5OQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH 07/13] clk: rockchip: rk3308: Add support for SCLK_RTC32K clock
Date: Sat, 16 Mar 2024 22:56:33 +0000
Message-ID: <20240316225655.3244348-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f623d40957eaab7babfcf9
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

From: Finley Xiao <finley.xiao@rock-chips.com>

Add support to get and set the SCLK_RTC32K clock rate.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[jonas@kwiboo.se: Update commit message]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rk3308/cru_rk3308.h | 14 +++
 drivers/clk/rockchip/clk_rk3308.c             | 95 +++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm/include/asm/arch-rk3308/cru_rk3308.h b/arch/arm/include/asm/arch-rk3308/cru_rk3308.h
index 84b63e4d5682..091ae82d7cc1 100644
--- a/arch/arm/include/asm/arch-rk3308/cru_rk3308.h
+++ b/arch/arm/include/asm/arch-rk3308/cru_rk3308.h
@@ -147,6 +147,20 @@ enum {
 	CORE_DIV_CON_SHIFT	= 0,
 	CORE_DIV_CON_MASK	= 0x0f << CORE_DIV_CON_SHIFT,
 
+	/* CRU_CLK_SEL2_CON */
+	CLK_RTC32K_SEL_SHIFT	= 8,
+	CLK_RTC32K_SEL_MASK	= 3 << CLK_RTC32K_SEL_SHIFT,
+	CLK_RTC32K_IO		= 0,
+	CLK_RTC32K_PVTM,
+	CLK_RTC32K_FRAC_DIV,
+	CLK_RTC32K_DIV,
+
+	/* CRU_CLK_SEL3_CON */
+	CLK_RTC32K_FRAC_NUMERATOR_SHIFT		= 16,
+	CLK_RTC32K_FRAC_NUMERATOR_MASK		= 0xffff << 16,
+	CLK_RTC32K_FRAC_DENOMINATOR_SHIFT	= 0,
+	CLK_RTC32K_FRAC_DENOMINATOR_MASK	= 0xffff,
+
 	/* CRU_CLK_SEL5_CON */
 	BUS_PLL_SEL_SHIFT	= 6,
 	BUS_PLL_SEL_MASK	= 0x3 << BUS_PLL_SEL_SHIFT,
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 7755b0161118..7515fc8bb244 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -65,6 +65,57 @@ static struct rockchip_pll_clock rk3308_pll_clks[] = {
 		      RK3308_MODE_CON, 6, 10, 0, NULL),
 };
 
+/*
+ *
+ * rational_best_approximation(31415, 10000,
+ *		(1 << 8) - 1, (1 << 5) - 1, &n, &d);
+ *
+ * you may look at given_numerator as a fixed point number,
+ * with the fractional part size described in given_denominator.
+ *
+ * for theoretical background, see:
+ * http://en.wikipedia.org/wiki/Continued_fraction
+ */
+static void rational_best_approximation(unsigned long given_numerator,
+					unsigned long given_denominator,
+					unsigned long max_numerator,
+					unsigned long max_denominator,
+					unsigned long *best_numerator,
+					unsigned long *best_denominator)
+{
+	unsigned long n, d, n0, d0, n1, d1;
+
+	n = given_numerator;
+	d = given_denominator;
+	n0 = 0;
+	d1 = 0;
+	n1 = 1;
+	d0 = 1;
+	for (;;) {
+		unsigned long t, a;
+
+		if (n1 > max_numerator || d1 > max_denominator) {
+			n1 = n0;
+			d1 = d0;
+			break;
+		}
+		if (d == 0)
+			break;
+		t = d;
+		a = n / d;
+		d = n % d;
+		n = t;
+		t = n0 + a * n1;
+		n0 = n1;
+		n1 = t;
+		t = d0 + a * d1;
+		d0 = d1;
+		d1 = t;
+	}
+	*best_numerator = n1;
+	*best_denominator = d1;
+}
+
 static ulong rk3308_armclk_set_clk(struct rk3308_clk_priv *priv, ulong hz)
 {
 	struct rk3308_cru *cru = priv->cru;
@@ -832,6 +883,44 @@ static ulong rk3308_crypto_set_clk(struct rk3308_clk_priv *priv, ulong clk_id,
 	return rk3308_crypto_get_clk(priv, clk_id);
 }
 
+static ulong rk3308_rtc32k_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
+{
+	struct rk3308_cru *cru = priv->cru;
+	unsigned long m, n;
+	u32 con, fracdiv;
+
+	con = readl(&cru->clksel_con[2]);
+	if ((con & CLK_RTC32K_SEL_MASK) >> CLK_RTC32K_SEL_SHIFT !=
+	    CLK_RTC32K_FRAC_DIV)
+		return -EINVAL;
+
+	fracdiv = readl(&cru->clksel_con[3]);
+	m = fracdiv & CLK_RTC32K_FRAC_NUMERATOR_MASK;
+	m >>= CLK_RTC32K_FRAC_NUMERATOR_SHIFT;
+	n = fracdiv & CLK_RTC32K_FRAC_DENOMINATOR_MASK;
+	n >>= CLK_RTC32K_FRAC_DENOMINATOR_SHIFT;
+
+	return OSC_HZ * m / n;
+}
+
+static ulong rk3308_rtc32k_set_clk(struct rk3308_clk_priv *priv, ulong clk_id,
+				   ulong hz)
+{
+	struct rk3308_cru *cru = priv->cru;
+	unsigned long m, n, val;
+
+	rational_best_approximation(hz, OSC_HZ,
+				    GENMASK(16 - 1, 0),
+				    GENMASK(16 - 1, 0),
+				    &m, &n);
+	val = m << CLK_RTC32K_FRAC_NUMERATOR_SHIFT | n;
+	writel(val, &cru->clksel_con[3]);
+	rk_clrsetreg(&cru->clksel_con[2], CLK_RTC32K_SEL_MASK,
+		     CLK_RTC32K_FRAC_DIV << CLK_RTC32K_SEL_SHIFT);
+
+	return rk3308_rtc32k_get_clk(priv, clk_id);
+}
+
 static ulong rk3308_clk_get_rate(struct clk *clk)
 {
 	struct rk3308_clk_priv *priv = dev_get_priv(clk->dev);
@@ -912,6 +1001,9 @@ static ulong rk3308_clk_get_rate(struct clk *clk)
 	case SCLK_CRYPTO_APK:
 		rate = rk3308_crypto_get_clk(priv, clk->id);
 		break;
+	case SCLK_RTC32K:
+		rate = rk3308_rtc32k_get_clk(priv, clk->id);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -990,6 +1082,9 @@ static ulong rk3308_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_CRYPTO_APK:
 		ret = rk3308_crypto_set_clk(priv, clk->id, rate);
 		break;
+	case SCLK_RTC32K:
+		ret = rk3308_rtc32k_set_clk(priv, clk->id, rate);
+		break;
 	default:
 		return -ENOENT;
 	}
-- 
2.43.2

