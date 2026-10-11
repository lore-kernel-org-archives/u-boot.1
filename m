Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696DACA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 353146062A;
	Sun, 11 Oct 2026 22:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hR9SpvT9o61g; Sun, 11 Oct 2026 22:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79F78606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757857;
	b=P+uyzn/IqBTxA1DrliBRjzhaWlBCiLO88RSm8EZNci3Dij44YCop75Mc5tUfdnw8JkeV
	 xDczWJhpkZC07M/CQAO633k7gj0IMF173YuOgINCuYNMm1DzAz4WHfp1dtayHtBqVEbJe
	 0KHmDRGEIa4RpoO5bQf6o1nNxBH/GM8zVp0Zv+JSyG+S9qCganbYGsRhMgJ4EqQalHZ9y
	 gNPdiK4GJgbwSq7TF5Da4C9T37D0PnOOpfAYt3e2u21COptLmOwxPhKUgRWI0caqiANv5
	 IhQdDINkDYG2jcpOeRxIyKBwFdsbJNSSUMrhyTWb3teTuRkiCCk08aTyhcBpTmZULOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3toJ3JzkENxBOn2Q5WmvKH491dX1Ralj6TS8HC7OrVc=;
	b=p4mG1BgI4yle4twSKKkjLH9IZfKv+5dfSZVLEMQra+D1p5tr7JkP+UVjR2Ib8YErqvg/
	 eQei4gis8TKN0PSAwwMrvYi3ukm0pHvQOmlDOphQv7YKd1uVFzK0CaiSu6zo8cgceRyup
	 PUh31o4xBM2VNyjr+AiYYaAmaXbi5qOLuhgxZXAq4w91ipJgDUvEjjn5L0N80cOLonFx+
	 5ZfH8F3efXj6qkblaMrat4ymuyXH7H7ts1X7gId7m8POfHRRnADWgpb7V8O3QF1pPPL2z
	 bc34s0PlaI2lVIATDHA65VpX4AYPWPYHmhXOWATsqYOG2tpRlAEHNXvx+grbWw3pfbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757857;
	bh=3toJ3JzkENxBOn2Q5WmvKH491dX1Ralj6TS8HC7OrVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZeYm0nFC7nm9y091sbJYYT9IKr1BRQn2ih8uys2PMUDXd9cZjaWpWe+/rn677/1Z
	 QrtyuUgnfkUiWqn2T2DuizfWkuIKYStYY80Vpv+mwElYtBJDfvU9BSD/34jDbN54uX
	 b5WthpApsSHch6pgb2QSWCO28cmInRii5YD4+voFa6RxtXy+KDFRFQdybrXhxfmDxW
	 4KFGdJU3NHzVsbXPqaCrEJ9riW+yRR9Na1t90X/3j05QjBF61P2DfLJ6N3/BSY7cSa
	 dZxz6oFSPgXvPAVqect/TZfIq2iSZjQ97kFLeFBOrOSvRB5nV0ONgjQfBkNEqz5N6l
	 gmzs1eA9/PT5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79F78606BD;
	Sun, 11 Oct 2026 22:30:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 067ED75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E933B80D05
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJ-sZdBef_NE for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C1BF80CEB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757855;
 b=CWJVUI3EwaiEUOBGs2mlJtg8x2iwijPWz+WaWaGRq1LcaPH84uO8sP45Ckr9ldLhRIum
 apAjYaxBWK9ENA1QhKj2sszDwBcgd4mi48j6RsSVNtNcbwuHM2ZlfubNTZ2Xnfv49ini7
 um6A/1NtbDsyH533E+LZGtoxMkCm49+1+nFgG1kV2cJF+mGI02asf2DMJ1t6cstllR89R
 6IWClIhnXK7VJ64d+YcjAD4uw70MIvowiHpKBOj10WoZSV4USKm2p0o72VzBtQOsEr0bQ
 6LJBIB2xvr8qol7Ho7fe9Fhxw3vrvCGKwoOFQNmgj3Ypd43lBUwUBMRmyk5WTo1TDJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757855;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=3toJ3JzkENxBOn2Q5WmvKH491dX1Ralj6TS8HC7OrVc=;
 b=qsPXemRp53xefjjoHsyuYFelViCsbdgSIg2Jvip7egVO+Idx2GhyYOC/5Q5qI/mL9CEE
 N/bfqSwxC37ZAPYxZWvoL+OE3xKoVUHXixeDjqdwk86A2GzKly8N6tEPDXuyObIPdS/g+
 BxqjXxhkMxNt0yLEvW3K1J4o5R4HRFFM+3pVs7j0cZ6WBqTEas/vpxczKohYKQgV/Cpfa
 RhYat+uxJra34WxZjkK5QaBnRhmb8Qz+X42bVuOy+hT+fPyq23fLR03Tv5I6ZCQjVmq3M
 w5CxG/qEDsg+8RUs9zXEHgvQxN00WIKSXS7EghbWveQ9knErXAok6/ngVXRHpOe7Zfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Po8fjIb1; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Po8fjIb1
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C1BF80CEB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757854; bh=3toJ3JzkENxBOn2Q5WmvKH491dX1Ralj6TS8HC7OrVc=;
 b=Po8fjIb1lvDMuuX/amAeZapSfrnhe/pUVj9+/GZ25ipOq7r6wAcEvWLoSlweFebIPb8rdYWyI
 lBFAwfUglLtG+WG/duVnLUy57UONmdZzdI/7IV6IuZHTfH58oLxV8D6DAPZ8WoiejbSokoWMWtC
 riYoPIOYcE7t1vCe5U12G2x99zeu3J1V6dcUy1TLpewOfCymJVHZmtL6RhgGUr0uWmFdtQq1zvI
 KIbu75vK5xThkLVroenkKL3VIeqhRbKABAGd4FeB86lHlO/us3FUKDrJT8WD5UCJVsaZo7O96SB
 U7Hym9748yt0BJn97E7Nb8NNkgan1F1IJkDIFzDQ2Izg==
X-Forward-Email-ID: 6acc0e144548822a24c1749e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 19/37] clk: rockchip: rk3576: Use correct mode register for
 VPLL
Date: Sun, 11 Oct 2026 22:28:54 +0000
Message-ID: <20261011222930.1085075-20-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change to use correct PLL mode register when VPLL rate is changed.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 92bde425b0ee..abfd57e2447e 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -49,7 +49,7 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
 		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
 	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
-		      RK3576_LPLL_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
 	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_PLL_CON(96),
 		      RK3576_MODE_CON0, 6, 15, 0, rk3576_24m_pll_rates),
 	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_PLL_CON(104),
-- 
2.55.0

