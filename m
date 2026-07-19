Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350EAC44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 02:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694BC80517;
	Sun, 19 Jul 2026 04:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F01848A1; Sun, 19 Jul 2026 04:02:36 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91E480398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGoS-000000001q6-1QZh; Sun, 19 Jul 2026 01:59:28 +0000
Date: Sun, 19 Jul 2026 02:59:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dang Huynh <dang.huynh@mainlining.org>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH 4/9] clk: rockchip: rk3568: Use assigned VPLL clock when
 possible
Message-ID: <9867265ec3ac6caff5ca959cd13cdf1d75bf8081.1784424101.git.daniel@makrotopia.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784424101.git.daniel@makrotopia.org>
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

From: Dang Huynh <dang.huynh@mainlining.org>

This matches how VPLL is configured under Linux and avoid weird
behaviors when VPLL is reconfigured under Linux.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/clk/rockchip/clk_rk3568.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index bb49af358e6..c8e8e1d4f7d 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1818,7 +1818,11 @@ static ulong rk3568_dclk_vop_set_clk(struct rk3568_clk_priv *priv,
 			     ((div - 1) << DCLK0_VOP_DIV_SHIFT));
 		rk3568_pmu_pll_set_rate(priv, HPLL, div * rate);
 	} else if (sel == DCLK_VOP_SEL_VPLL) {
-		div = DIV_ROUND_UP(RK3568_VOP_PLL_LIMIT_FREQ, rate);
+		if (priv->vpll_hz)
+			div = DIV_ROUND_UP(priv->vpll_hz, rate);
+		else
+			div = DIV_ROUND_UP(RK3568_VOP_PLL_LIMIT_FREQ, rate);
+
 		rk_clrsetreg(&cru->clksel_con[conid],
 			     DCLK0_VOP_DIV_MASK | DCLK0_VOP_SEL_MASK,
 			     (DCLK_VOP_SEL_VPLL << DCLK0_VOP_SEL_SHIFT) |
-- 
2.55.0
