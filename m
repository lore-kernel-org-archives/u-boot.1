Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24973C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE73940BA2;
	Thu, 30 Jul 2026 14:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pcS8HDRZvJn; Thu, 30 Jul 2026 14:13:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C0DC40B3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420830;
	bh=JDlU1NJ98xZ4DXHswCa/DRUGSvHLN098Fsh/3OJlASY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FpQKbOIRLF7Lw19xZIb3iIhLPnVuj0oF+fRnHypxlCza3RsiPw7hlHOGnGodVMFc+
	 bEXE09ueM6oyQ8miNKNYoBXiFKehLOJC7qmU61ceHfb8P3QiHpjlsg62/ou+8EDlSy
	 +dwEvFnpeIlRCymQZojKNM0mWf+qJWpLZZiRG1Qbb8E5YfJFuUVBOxGEFqjWTshlvf
	 mT/j+7LB75M327W3CrIUpFqVk/s58ZJ/8oB6Z3brKSkLRWYhEax7NjCAkHaffC08us
	 UXtIsGwbjVvswh3MmbpkAmHNqhbfXpKn2HRrQglcGo16g8vBnh+r4BmhT1UIwt27dm
	 0XV6aXe8mjjiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C0DC40B3B;
	Thu, 30 Jul 2026 14:13:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D7A5197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9ACB5810C6
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9v8NOMaNFBnH for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 82A84810C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82A84810C7
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82A84810C7
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c11a254ae338c09184e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH 12/15] clk: rockchip: rk3528: Fix trivial clock configuration
 errors
Date: Thu, 30 Jul 2026 14:13:01 +0000
Message-ID: <20260730141308.1218014-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420822; bh=JDlU1NJ98xZ4DXHswCa/DRUGSvHLN098Fsh/3OJlASY=;
 b=K1IkP/9muz1bQvwOKS88ev8lY65Zq3QWIUCnUklKq2auFJp7eEmtKSjBn8MLHFIpuXZoTff8U
 Bz6B/FfGc2O9SXC4BoqL7agRhTXRORmClf6CA3d08FsgbMW7avBwkJHhjxNMgEn5jIYIMzth+Tj
 qvCsmDDVmyww8LGkJ+0GQmk5zxiI6pPJDwDATDUHQeZbeBKB2mO5d04xDupfSXle1KLVO4XzG2/
 BJC5W13wAg0ZTCGhUL575YlPdGa7Y4AvanxwMgXhuQGnLp8W2c3HbCmq8AvEMQ+/Y3zmKlPPIJ+
 +kBTpR6dIzZWA7rNH6HDQNHxWLILGm8k2hQlnKV0rxDw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=K1IkP/9m
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

The RK3528 clock driver has a few trivial copy-paste mistakes in its
clock handling.

Fix the trivial clock configuration errors:
- avoid reporting incorrect PWM clock rate
- use correct mask and value for VOP clocks
- align PPLL configuration to match other PLLs

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3528.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index cf8c3a623495..83e302dbc3c4 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -72,7 +72,8 @@ static struct rockchip_pll_clock rk3528_pll_clks[] = {
 		     RK3528_MODE_CON, 4, 10, 0, rk3528_pll_rates),
 
 	[PPLL] = PLL(pll_rk3328, PLL_PPLL, RK3528_PCIE_PLL_CON(32),
-		     RK3528_MODE_CON, 6, 10, ROCKCHIP_PLL_FIXED_MODE, rk3528_pll_rates),
+		     RK3528_MODE_CON, 6, 10, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3528_pll_rates),
 
 	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3528_DDRPHY_PLL_CON(16),
 		     RK3528_DDRPHY_MODE_CON, 0, 10, 0, rk3528_pll_rates),
@@ -770,7 +771,7 @@ static ulong rk3528_pwm_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 	sel = (con & mask) >> shift;
 	if (sel == CLK_PWM0_SEL_CLK_MATRIX_100M_SRC)
 		rate = 100 * MHz;
-	if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
+	else if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
 		rate = 50 * MHz;
 	else
 		rate = OSC_HZ;
@@ -1097,7 +1098,7 @@ static ulong rk3528_dclk_vop_set_clk(struct rk3528_clk_priv *priv,
 	}
 
 	div = ((DIV_ROUND_UP(prate, rate) - 1) << div_shift) & div_mask;
-	rk_clrsetreg(&cru->clksel_con[id], sel, div);
+	rk_clrsetreg(&cru->clksel_con[id], sel_mask | div_mask, sel | div);
 
 	return rk3528_dclk_vop_get_clk(priv, clk_id);
 }
-- 
2.54.0

