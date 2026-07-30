Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BECC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B982E810E6;
	Thu, 30 Jul 2026 14:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KT79AOMNNVye; Thu, 30 Jul 2026 14:13:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B662780FFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420815;
	bh=iuvQ04+I1h5xzkYG72E9COxnAP59rkEHl45vVbXCevs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xygFGT72O7AbdEFSy1uIlObB1c3a0O8tDJV2+UdLcSICbA2Mns1iZ6THl+CC59Dwx
	 SdNzezhJAKYf6iiQ7jtQpKD2T8DjQtuuWpINDRSid5LCfTdDz3u8rSkF2w6iN1fj9m
	 Yz6rGQ4vZmFqZDbPP7S3LxiRaBNd21F4k3+9JqZVCwCCjzbBBqjalDZtRRfiEGysg7
	 HiY+kS0nQVAbjPJ0MAbgFTNCkRUWeWsNB0Jcd7z6q0KQ+n8f6SOhP+V3YdSHIrScjr
	 Pe8/pPajZLA/QsCY2T1UTqboOUcDan3espxC2RFjqvoWNfh0UOv3xMwYcOPDvq5sIs
	 G5V7hmPcIGamw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B662780FFD;
	Thu, 30 Jul 2026 14:13:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8707352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C332080FF2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plngo7Yf7ACD for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3E9EB81083
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E9EB81083
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E9EB81083
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c04a254ae338c091716
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
Subject: [PATCH 05/15] clk: rockchip: pll: Limit special rk3588_pll handling
 to RK3588
Date: Thu, 30 Jul 2026 14:12:54 +0000
Message-ID: <20260730141308.1218014-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420806; bh=iuvQ04+I1h5xzkYG72E9COxnAP59rkEHl45vVbXCevs=;
 b=xuQYwVc/lTYhFyQjvQT4LHDjvoI9eETzMxyZKICrIER9B2HkrE1BwHOJN1IPVKWawxpVbmkbR
 FHqPPO3amntmoGLA/BDeh5DGwxkRxWPLd9eSjRIWhU4/wUZ1akjoTkbeNvtPXvSJulr6chG4hlC
 gcABDd1pQ//nXyha26CZQQMGdK29vKHB1zn8o1wSkifZXhRpbUos9/Ql2VHHna65R1jOUz6Oz9T
 fzlySeXIVCb4DBeelTsd992HlAkeOFgWkaNWU6Z90e/n7Dre5NGvCcJWQljJBvyg7iafj7pK+Cg
 nJ/fNh49A3aCrSkAVJUAhYGlgZxy0NEmotCBpjCPE+WA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=xuQYwVc/
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

The rk3588_pll_set_rate() function contains special handling intended
only for PLLs on RK3588 that are also applied to PLLs on RK3576.

This special handling should ideally be moved from the common pll funcs
into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
to limit this special handling to PLLs on RK3588 targets.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_pll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 5f035eb98adc..76276e1ac1f2 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -453,7 +453,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	 * When power on or changing PLL setting,
 	 * we must force PLL into slow mode to ensure output stable clock.
 	 */
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
 	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
@@ -461,15 +461,15 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
 	}
-	if (pll_id == 0)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 1)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1)
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 2)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2)
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     RKCLK_PLL_MODE_SLOW << 14);
@@ -505,7 +505,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
 	}
-	if (pll_id == 0) {
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -515,7 +515,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 1) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1) {
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -525,7 +525,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 2) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2) {
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     2 << 14);
@@ -543,7 +543,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     0 << RK3588_CORE_L02_DIV_SHIFT);
 	}
 
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0);
 
 	debug("PLL at %p: con0=%x con1= %x con2= %x mode= %x\n",
-- 
2.54.0

