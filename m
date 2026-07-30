Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB1FC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 401E740B5F;
	Thu, 30 Jul 2026 14:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lP-qTraFBLC9; Thu, 30 Jul 2026 14:13:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6054540B5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420814;
	bh=emooShF2kaK/i/yiLfaPFqMFNINKejn59FZKteeoxUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sg5MPkxxaFxMJdiQLNXUZcv3q5j+kn5mx+7QG1uC+8sfjib60nkX2DfEjFwAo7Len
	 oFf6PXUcpKHzTOdp+/kOhdMeXpc8bG/3ztanPUJ0Oi4RVlnjrTrjQ2GjttZCF6StOn
	 zQriJBgloolqbQ6ZFUizENSJh7V47fH+AixqUc8SMmvHN7xTCV4AZChaqXR1+KjbMl
	 bUSM3IjRghtJTGx/INhj+pb/4SXM9srg1hMl1AM2n5m5xVQbHe+1FB6BfhB3vt4d2r
	 tdxuHh1YhGC1QzgM4qrdG4d5cvNKyF/SRpKpR+8CF4JpyHwG/CBJ+073m3lRiSzSmP
	 /9K2rKugucHcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6054540B5A;
	Thu, 30 Jul 2026 14:13:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2BBA69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A300280C73
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qO0xG9LDBLd for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A296D8109C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A296D8109C
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A296D8109C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:27 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c02a254ae338c0916fb
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
Subject: [PATCH 04/15] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 rk3588/rk3576 plls
Date: Thu, 30 Jul 2026 14:12:53 +0000
Message-ID: <20260730141308.1218014-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420806; bh=emooShF2kaK/i/yiLfaPFqMFNINKejn59FZKteeoxUk=;
 b=IgIpaDPMucHg1JXkAagKc3OlVwCx2bU9bcuPm300bKJTyMlkjbZoxfmCYZQYy8x2Ur25T/K0n
 woKodnYkM0/W8Bjny0AALlGiMuagddlTZ89r6ZKEDPMFMZQnSMx2k3U8wBWoi7jbz8eDMHn6gZC
 jKtwvwArsCcpncz8coAmF3uEw7Kn/ofoRu63Xuna+EZfrCMpV6cLM5ruL9JAmnsVaDe0e/53BSi
 ZfBLW6uAYpBV7A87m6yLMFbX1qseRaNJZIlhlMOgOwNQABSNnqoxqfuBW3Oouz8V+OzOdMtrgtD
 itMx05neorJyg++E+wDyuQgYFApR5o/+np4pfJZyrlEg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=IgIpaDPM
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

The PPLL of RK3588 and RK3576 does not have a pll mode reg to switch
between slow, deep slow or normal mode.

Extend support for use of the PLL_FIXED_MODE flag to the rk3588_pll type
and update the PPLL to use this flag to signal that it does not need to
switch to slow mode before the rate is changed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_pll.c    | 21 +++++++++++++--------
 drivers/clk/rockchip/clk_rk3576.c |  3 ++-
 drivers/clk/rockchip/clk_rk3588.c |  3 ++-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 7dbe77d74b8a..5f035eb98adc 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -456,9 +456,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	if (pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
-	rk_clrsetreg(base + pll->mode_offset,
-		     pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	}
 	if (pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -498,8 +500,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		debug("%s: wait pll lock, pll_id=%ld\n", __func__, pll_id);
 	}
 
-	rk_clrsetreg(base + pll->mode_offset, pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	}
 	if (pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -559,10 +564,10 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
 	con = readl(base + pll->mode_offset);
 	shift = pll->mode_shift;
-	if (pll_id == 8)
-		mode = RKCLK_PLL_MODE_NORMAL;
-	else
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE))
 		mode = (con & (pll->mode_mask << shift)) >> shift;
+	else
+		mode = RKCLK_PLL_MODE_NORMAL;
 	switch (mode) {
 	case RKCLK_PLL_MODE_SLOW:
 		return OSC_HZ;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index db8ce25852fd..92bde425b0ee 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -57,7 +57,8 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
-		     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3576_24m_pll_rates),
 };
 
 #ifdef CONFIG_SPL_BUILD
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index be401a9faeec..b9fd4bec311b 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -62,7 +62,8 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
-		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
+		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
-- 
2.54.0

