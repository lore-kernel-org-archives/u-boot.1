Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED8CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3DA846E7;
	Sun, 17 May 2026 21:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="BG0ueDvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EF284659; Sun, 17 May 2026 21:25:08 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C57584690
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id DCF3E80D09;
 Sun, 17 May 2026 22:25:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-you6iWJq; 
 Sun, 17 May 2026 22:25:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045905; bh=6oPmBrmggaCc+Vz/89EtRo4wzF1Um/b9hf1pn8RPJY0=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=BG0ueDvrsDf9G/FKYw7APiyK5Twjne4yDm3m5II3i4GhXw8m2uij8vTz9yRWdT7+0
 FaVorTVVQ1QQOF0WBsbqT7DjfO/lE4T57r0S1e46fpIQmkz1zP72ZFrCPkCSqZoa+W
 lblZTdYvg3jSnuTrWELRGm/P0T9Jg71QppsZgAt0=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:38 +0300
Subject: [PATCH RFC 12/18] clk: rockchip: rk3568: Reduce code size for TPL
 build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-12-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

RK3568 has only 59.5Kb usable SRAM for TPL stage. Disable all clock
related functionality for TPL build. Clock driver can still be used to
get GRF syscon reference from it.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 drivers/clk/rockchip/clk_rk3568.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 199bb51fa6f..384d0c750d5 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -28,6 +28,7 @@ struct rk3568_pmuclk_plat {
 };
 #endif
 
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 #define RK3568_CPUCLK_RATE(_rate, _aclk_div, _pclk_div)		\
 {								\
 	.rate	= _rate##U,					\
@@ -2315,6 +2316,7 @@ static ulong rk3568_uart_set_rate(struct rk3568_clk_priv *priv,
 
 	return rk3568_uart_get_rate(priv, clk_id);
 }
+#endif
 
 static ulong rk3568_clk_get_rate(struct clk *clk)
 {
@@ -2327,6 +2329,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 	}
 
 	switch (clk->id) {
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 	case PLL_APLL:
 	case ARMCLK:
 		rate = rockchip_pll_get_rate(&rk3568_pll_clks[APLL], priv->cru,
@@ -2486,6 +2489,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 	case CPLL_25M:
 		rate = rk3568_cpll_div_get_rate(priv, clk->id);
 		break;
+#endif
 	default:
 		return -ENOENT;
 	}
@@ -2504,6 +2508,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	}
 
 	switch (clk->id) {
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 	case PLL_APLL:
 	case ARMCLK:
 		if (priv->armclk_hz)
@@ -2673,6 +2678,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	case CPLL_25M:
 		ret = rk3568_cpll_div_set_rate(priv, clk->id, rate);
 		break;
+#endif
 	default:
 		return -ENOENT;
 	}
@@ -2681,6 +2687,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 };
 
 #if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 static int rk3568_gmac0_src_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
@@ -2823,10 +2830,12 @@ static int rk3568_rkvdec_set_parent(struct clk *clk, struct clk *parent)
 
 	return 0;
 }
+#endif
 
 static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	switch (clk->id) {
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 	case SCLK_GMAC0:
 		return rk3568_gmac0_src_set_parent(clk, parent);
 	case SCLK_GMAC1:
@@ -2848,6 +2857,7 @@ static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
 	case SCLK_GMAC1_RGMII_SPEED:
 	case SCLK_GMAC1_RMII_SPEED:
 		break;
+#endif
 	default:
 		return -ENOENT;
 	}
@@ -2864,6 +2874,7 @@ static struct clk_ops rk3568_clk_ops = {
 #endif
 };
 
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 {
 	int ret;
@@ -2903,18 +2914,14 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 	priv->ppll_hz = rk3568_pmu_pll_get_rate(priv, PPLL);
 	priv->hpll_hz = rk3568_pmu_pll_get_rate(priv, HPLL);
 }
+#endif
 
 static int rk3568_clk_probe(struct udevice *dev)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(dev);
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-	struct rk3568_clk_plat *plat = dev_get_plat(dev);
-#endif
+#if !IS_ENABLED(CONFIG_TPL_BUILD)
 	int ret;
 
-#if CONFIG_IS_ENABLED(OF_PLATDATA)
-	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
-#endif
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
 		return PTR_ERR(priv->grf);
@@ -2927,7 +2934,12 @@ static int rk3568_clk_probe(struct udevice *dev)
 		debug("%s clk_set_defaults failed %d\n", __func__, ret);
 	else
 		priv->sync_kernel = true;
+#endif
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+	struct rk3568_clk_plat *plat = dev_get_plat(dev);
 
+	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
+#endif
 	return 0;
 }
 

-- 
2.25.1

