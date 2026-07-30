Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA0C5516C
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEDBB40B59;
	Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJurdwy8j1Ve; Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A0CE40B47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420820;
	bh=+5YBZrakQtezuH+DEPY5FXjg93W91vVPgz22GVsOq0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6/eKxC5r7NCDX+g2H/Fi15pG8GIhTdzpSON2g+YqMQPqu/wqQ4N/5tRpWwIBF3MQ
	 NQgjcgRm7W4HyM9rDW+9ZahzI55qwZCmhrRQbwEC7aEHho9VaEYBW5Mq4b600Kfvt0
	 0LLyhlokDM5Vfj3AmkhCtehwGMC+tJssYtfWPZDblFdLFAHBOGVV7S8DNL1hwUKZk9
	 xBPDZRSkeJDUr+NS3AQXA1wCkQUP0dgRo5XJ5dFP2Tt5mHqHyiOszrneSSEoxWOMvd
	 9FCQyQB81Yz6ZDGYgE2s36oDKsB3csOHXRB/Q1R1X46cnMtV2wsYiOK7iTTMtpwzCE
	 hi7XtRFequ++g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A0CE40B47;
	Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 947D0197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77350810B8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eFdmUoGujgHr for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 61CC4810BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61CC4810BE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61CC4810BE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:32 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c08a254ae338c09175b
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
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/15] clk: rockchip: rk3588: Fix trivial clock configuration
 errors
Date: Thu, 30 Jul 2026 14:12:56 +0000
Message-ID: <20260730141308.1218014-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420811; bh=+5YBZrakQtezuH+DEPY5FXjg93W91vVPgz22GVsOq0o=;
 b=aPnzEZgw5hwCaBAWcCeMbowirgh36nIoxgMxwEX8es+9frEqiD4k/XKc2aQS4KrOtSmmrzgTT
 zuS+bhMCF8YOrHj/EA4oSAZoy12Y4JX4PiVl/xhg1UlbsKNsmAE2G9VNnQ5yYHqOOssyNIgePwP
 opEPYDlhCkjEbXn+bzlgNFaY3ST0bF+jDrTFBJVUDjjjDmNIgq7PGnZ4mSkX3HprA9ly2/cORJU
 //q5/3pHMfRY7LYopItiPcK/V0Hc4AmeMc+UsBBzVLbCi6x0fIbZm7vZD2QCca+CEA/CVzF0ASR
 YYB7FA5NhPWCWjayxDIsHk1IdnxFvftJfBJ2tnsqM5mw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=aPnzEZgw
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

The RK3588 clock driver has a few trivial copy-paste mistakes in its
clock handling.

Fix the trivial clock configuration errors:
- remove duplicate PLL_CON/MODE_CON defines
- rename and use PHP_PLL_CON macro
- use correct parent rate for TSADC clock
- use correct parent rate for UART clocks
- align BxPLL configuration to match other PLLs

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  5 +----
 drivers/clk/rockchip/clk_rk3588.c               | 12 +++++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index afce8a44af3b..39295adeb38a 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -105,9 +105,6 @@ struct pll_rate_table {
 	unsigned int k;
 };
 
-#define RK3588_PLL_CON(x)		((x) * 0x4)
-#define RK3588_MODE_CON			0x280
-
 #define RK3588_PHP_CRU_BASE		0x8000
 #define RK3588_PMU_CRU_BASE		0x30000
 #define RK3588_BIGCORE0_CRU_BASE	0x50000
@@ -129,10 +126,10 @@ struct pll_rate_table {
 #define RK3588_SDMMC_CON0		0xC30
 #define RK3588_SDMMC_CON1		0xC34
 
+#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
 #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
 
-#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
 #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
 #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index b9fd4bec311b..157a02e011a5 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -44,11 +44,9 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 
 static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[B0PLL] = PLL(pll_rk3588, PLL_B0PLL, RK3588_B0_PLL_CON(0),
-		      RK3588_B0_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B0_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(8),
-		      RK3588_B1_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B1_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(16),
 		     RK3588_LPLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_PLL_CON(88),
@@ -61,7 +59,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
@@ -655,7 +653,7 @@ static ulong rk3588_adc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		if (sel == CLK_TSADC_SEL_24M)
 			prate = OSC_HZ;
 		else
-			prate = 100 * MHz;
+			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
 	default:
 		return -ENOENT;
@@ -1343,7 +1341,7 @@ static ulong rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
 	} else if (priv->cpll_hz % rate == 0) {
 		clk_src = CLK_UART_SRC_SEL_CPLL;
 		uart_src = CLK_UART_SEL_SRC;
-		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
 	} else if (rate == OSC_HZ) {
 		clk_src = CLK_UART_SRC_SEL_GPLL;
 		uart_src = CLK_UART_SEL_XIN24M;
-- 
2.54.0

