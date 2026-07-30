Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B683C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DCCF810A6;
	Thu, 30 Jul 2026 14:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A0fr2GgqrwR1; Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C608810B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420812;
	bh=GeYKxaux5Pca6SG0OiuIfCw09G1sIV45tqrQ//a1wsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wNMbKKoff8VTBSUdhn/hzXTMWSrO5jTFYvceYetK3ADnbEBsPf9WaPN+kXUAOsUsM
	 lLbs2DBqpqeOWGtmt+SLeZgezt9TfiKsLLkwMai6uI6xwFFdCXC1dbyyb+HccJnH6n
	 qr4qhEl/QYtGUlNQqcf6JyO1XLdTRr7kgtgRI1P4F48YamKuOVPsWMngCcD2aOYMWk
	 TpU2Sl/5EvhalerkSEdDR2HGM7C9H9JW4CT+/+MA2weN/JIyTWjPoTEBozQUiF+zJ6
	 5fByIC8rvchGScSY0DNRSQzZR33DjcUV3i3Ok2b9/9w8MBP44b/z0ptmjEnhoSHgo8
	 tGibw0vDlr43w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C608810B7;
	Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 577B927C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CEA180C73
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROxz7ly5rIpy for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 398B780FEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 398B780FEF
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 398B780FEF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c06a254ae338c091731
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/15] clk: rockchip: rk3568: Fix trivial clock configuration
 errors
Date: Thu, 30 Jul 2026 14:12:55 +0000
Message-ID: <20260730141308.1218014-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420806; bh=GeYKxaux5Pca6SG0OiuIfCw09G1sIV45tqrQ//a1wsg=;
 b=DnI7rbfI5T/vAk5tGP2OCSVyAopdznJk56Vv1xPx2vTNvfmnflFo1jIQ6rAknPJfrYOaSqrZg
 MT3QOfdpWO3xIkaMnE/s/ILcd1iEaiL/zGYOY8tpCo0L1sxHsfsAwP/fFoLXhFRkspyQ9V9kpcv
 ylpWpBU0hrqIHsq3gKv/uylNktmj1kunE1dY6p3BOV8fSLSGX06EVZIo4mZ/SNsRYBOMK2UQsdD
 F0543J3KdNZFO/zQYnFBtSz74W4Ay/szh7qimGzd8+jZqHX2P22CP6j93oiqWUjAuMHDJkFw2x3
 60YD0LBONJIgesks6nIU1yFBs0NG399s9ZHnR7frGFJg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=DnI7rbfI
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The RK3568 clock driver has a few trivial copy-paste mistakes in its
clock handling.

Fix the trivial clock configuration errors:
- use correct pll_id for GPLL
- use correct shift macro for PWM0 div
- use correct pll rate for GMAC src clock

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3568.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index bb49af358e60..940b824103cc 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -77,7 +77,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] = {
 		     RK3568_MODE_CON, 2, 10, 0, NULL),
 	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3568_PLL_CON(24),
 		     RK3568_MODE_CON, 4, 10, 0, rk3568_pll_rates),
-	[GPLL] = PLL(pll_rk3328, PLL_HPLL, RK3568_PLL_CON(16),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3568_PLL_CON(16),
 		     RK3568_MODE_CON, 6, 10, 0, rk3568_pll_rates),
 	[NPLL] = PLL(pll_rk3328, PLL_NPLL, RK3568_PLL_CON(32),
 		     RK3568_MODE_CON, 10, 10, 0, rk3568_pll_rates),
@@ -294,12 +294,12 @@ static ulong rk3568_pwm_set_pmuclk(struct rk3568_pmuclk_priv *priv,
 				     CLK_PWM0_SEL_MASK | CLK_PWM0_DIV_MASK,
 				     (CLK_PWM0_SEL_XIN24M <<
 				      CLK_PWM0_SEL_SHIFT) |
-				     0 << CLK_PWM0_SEL_SHIFT);
+				     0 << CLK_PWM0_DIV_SHIFT);
 		} else {
 			src_clk_div = DIV_ROUND_UP(priv->ppll_hz, rate);
 			assert(src_clk_div - 1 <= 127);
 			rk_clrsetreg(&pmucru->pmu_clksel_con[6],
-				     CLK_PWM0_DIV_MASK | CLK_PWM0_DIV_MASK,
+				     CLK_PWM0_SEL_MASK | CLK_PWM0_DIV_MASK,
 				     (CLK_PWM0_SEL_PPLL << CLK_PWM0_SEL_SHIFT) |
 				     (src_clk_div - 1) << CLK_PWM0_DIV_SHIFT);
 		}
@@ -1882,7 +1882,7 @@ static ulong rk3568_gmac_src_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_MAC0_2TOP_SEL_25M:
 		return 25 * MHz;
 	case CLK_MAC0_2TOP_SEL_PPLL:
-		return rk3568_pmu_pll_get_rate(priv, HPLL);
+		return rk3568_pmu_pll_get_rate(priv, PPLL);
 	default:
 		return -ENOENT;
 	}
-- 
2.54.0

