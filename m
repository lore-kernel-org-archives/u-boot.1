Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52860C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F40FE80FDE;
	Thu, 30 Jul 2026 14:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgUnJWrxSgWy; Thu, 30 Jul 2026 14:13:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98FAD80FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420804;
	bh=gisPCg4iMeesktIoBd5zSpFIJXlFcwWx0dg9ZrqStZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNlr6CPzeGp4R/UavD/icc0jDbztSzbK38gI3gxIV0/cD3Fv8UyNmiRxecfsFSgdR
	 J45MyudHYXDa+JIgKb4D+zQC1MmMAv+5d5Bjm7x57XzHocg7YvRxh2LOr3QRftHV+x
	 mEdDzcMfcQWWx3VVHaR2NMTb1WpdyGxPpJ5KbkRVudY3eXvDCh0Z1MJm/noC+D7DTi
	 Ml/rGVqRynHDz6lXbG0FeIpRxhV9F67qt75DhftRXcP/4gm2P9/zKaosvhp3YsEfLW
	 utvAuSlrtovIlWel1sxqAsyUIdQeTKHyGTdERTpaPD53+QKAQ+C4jmoL/f0aWjPUKK
	 ytVBbq5YB80sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FAD80FEF;
	Thu, 30 Jul 2026 14:13:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7493D27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A14F80FDD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsSmhrydKvPa for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6C12B80D47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C12B80D47
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C12B80D47
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:20 +0000 (UTC)
X-Forward-Email-ID: 6a6b5bffa254ae338c0916b6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH 02/15] clk: rockchip: pll: Always write the dsmpd flag
Date: Thu, 30 Jul 2026 14:12:51 +0000
Message-ID: <20260730141308.1218014-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420799; bh=gisPCg4iMeesktIoBd5zSpFIJXlFcwWx0dg9ZrqStZ8=;
 b=v6CiN6DiDjMSbA9iuLwlelz06xAZK8JQQGL9+184ZgUCDIYOfYF0ylo7+NJeGn9jSozZn0wqE
 iYprp6RKSYfQ3APMlffcJac7wskrm6fX6pMW65dwaTiEKvuUilpNccsFAQ1PXmUQ2EzTlYJjWtM
 j6MgeXh0/we6Gv5/EQ/vdB8jPCoRUsxZzalPJkYpn87IOwFuFXUuXPcbJfHufqFkwfy2wNLGZOj
 Cfuw0kniLbFsgQqZEPKUlxvgkrCFW1mb85GZT9nNi7cFtt2KBuug32f6blYNjy1nN5XYW0r7Dem
 faLkTl/+Xcint50ShYc5/ctgTSQ51NQSU1vSKXbJ3ufA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=v6CiN6Di
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

The dsmpd flag determines when a rk3036_pll fracpll should enable or
bypass use of fractal mode.

Change to always write the value of the dsmpd flag to reg to allow
fractal re-configuration and closer match how Linux behaves.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_pll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 4fe67c889376..a135fad3de0c 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -326,13 +326,12 @@ static int rk3036_pll_set_rate(struct rockchip_pll_clock *pll,
 		     rate->fbdiv);
 	rk_clrsetreg(base + pll->con_offset + 0x4,
 		     (RK3036_PLLCON1_POSTDIV2_MASK |
-		     RK3036_PLLCON1_REFDIV_MASK),
+		     RK3036_PLLCON1_REFDIV_MASK |
+		     RK3036_PLLCON1_DSMPD_MASK),
 		     (rate->postdiv2 << RK3036_PLLCON1_POSTDIV2_SHIFT |
-		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT));
+		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT |
+		     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT));
 	if (!rate->dsmpd) {
-		rk_clrsetreg(base + pll->con_offset + 0x4,
-			     RK3036_PLLCON1_DSMPD_MASK,
-			     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT);
 		writel((readl(base + pll->con_offset + 0x8) &
 			(~RK3036_PLLCON2_FRAC_MASK)) |
 			    (rate->frac << RK3036_PLLCON2_FRAC_SHIFT),
-- 
2.54.0

