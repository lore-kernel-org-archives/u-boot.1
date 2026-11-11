Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF28606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RUgWvQUY;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=GEQwWI16
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4542811CF;
	Wed, 11 Nov 2026 22:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sinzvxFMWkyO; Wed, 11 Nov 2026 22:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BC8A81165
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436134;
	b=PQ4GTWpdQEXRqSHHPL/0uJ37S++Lbwlfc9voLZjuSaOUVcM1yKhyQ6cpDjr/rluPjdEj
	 EFcw84m2lH3PF3VVHgZt5GMXLWXA4RrfJScsl1Z3vM2tI/NlA+sGu+yJDC59QbINnFFb4
	 iQGPY6IuPPMoS3ROOXe5IyxUpedc6qDbciDVczfk6szQWN5yE6QUQXNNKRtBqYbI7wfZJ
	 Wj8z5wMUIPSehbs2O5L61nI6/5YNHEs5HQXXJZ0xsUIMPbMOo6z15gA3S8LR6I8JucKa8
	 ftZZL8YEmgk3qFxX0PG5wGf1mSmSvLoi+2WMPxgpY1wD1p/w0kOU+GdvmjOxAYIKKiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436134;
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
	bh=IE6zlIaen5/K8m92VWzggChIWjyzEHW2HKzdGj22gNE=;
	b=lG/0TAQ/NkizKd5/2iyQf6CbQ8XSZw9t8e9oWueUDHh4HxifPqAMX7L/9TdwpWUr5cTK
	 EXJsWe8N8UwDU7LaKzp27NKqXjZjMlYdyUAlZBWR9UWdNRKOeh1a3vpNasUwE85qhVb6A
	 L7AbPsb7jzLDe+fmblZuP+lyHMYIHFo1CSSPYJjiK080VcRHbD/dgBZ94exabpHtqKMG/
	 LuiJja0OL1w4S8mqIxXB1ogi4PWW2oYje55yk7eeYbfBaO6JX98kLAdzqkEn+duPscARF
	 SCiS6EH2SbAC0aBnNbMdRA+HQm8+2DUSEw5vzGTpwO5dVhG2YHqd2JEi0sIovoignkg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436134;
	bh=IE6zlIaen5/K8m92VWzggChIWjyzEHW2HKzdGj22gNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RUgWvQUYc9u7o9ZoY1J8QwGaApHPSnAAgBtAX/QKzFrFoDZvyRBbHKbhLAIiZTUW0
	 Mhj6AtxTurM0OnayNwZE8lJosfVmxZMHqtTyj/lOT1BMzZUDGjXOjYYvxBUJMoMN0c
	 8XAx3M7md3hvgdQTHGva/WFb0yv4H+Z63plvrpYPFXGnoSx/+pYNls8OI04J9SIyPD
	 NpSSN1/K2ovuQD56s18hfg+qCvvJzodJaOsXII+V9qKjQqYgC4eiN9kfvVP04LFhG5
	 mhu84G/EBdESY4VPJtqMf6P2IFfmHhrBO8BXuTGxsJ5uYnGiSsTd/9jN1rwWsmRIm8
	 GBMF535r4ClWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BC8A81165;
	Wed, 11 Nov 2026 22:28:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C372F335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1F0C40ACD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1wOx_fZYwFN for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E855940B14
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=GEQwWI16
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E855940B14
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436130; bh=IE6zlIaen5/K8m92VWzggChIWjyzEHW2HKzdGj22gNE=;
 b=GEQwWI16J7fbD0FsbCsioZbNOloxdo4Bco2KVIE6B2HreIuYAdD5sXBxSIKhuMoB3AzzEhBuW
 4DO3FXyb+Ve3JIWSphUT0KMOioS7UrRGMzG1JZy6ahuNn/jeII1QVHeK+ZK+BPdCfHMqjnTc4GT
 guHvzXhaeeYcXlqKqqKhYhe3HyI4wMNj5oQrt1U297p5mmF+nOOMi/bql3R6i2Yj6ax/zYMqJ/w
 HkTjCAjy5F//y0OqBryFrMuWxGca8K22jK/G4k0g1XkdsxbRzoF5x2SofuWn1B4e0v3tRRvmyrP
 g78XG9fSao9F2C3/szEN/H2MXVT+t6pHT3vZzZQF2X4Q==
X-Forward-Email-ID: 6af4ec1b6e1792a74d36a497
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/6] clk: rockchip: pll: Fix fractional PLL rate calculation
Date: Wed, 11 Nov 2026 22:28:27 +0000
Message-ID: <20261111222834.157842-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111222834.157842-1-jonas@kwiboo.se>
References: <20261111222834.157842-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fractional part of the rk3036-style PLL rate is divided by
postdiv1 twice instead of by both postdiv1 and postdiv2. The integer
part also loses precision by calculating in MHz before converting to Hz.

Calculate both parts in Hz using u64 arithmetic and apply post-dividers
on the combined integer and fractional parts. This also closely matches
the Linux implementation.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Change implementation to closer match Linux implementation
- Update commit message
- Add fixes tag
---
 drivers/clk/rockchip/clk_pll.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index f677525bba22..74b7ff5faa03 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -371,7 +371,7 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 {
 	u32 refdiv, fbdiv, postdiv1, postdiv2, dsmpd, frac;
 	u32 con = 0, shift, mask;
-	ulong rate;
+	u64 rate;
 	int mode;
 
 	con = readl(base + pll->mode_offset);
@@ -403,17 +403,18 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 		con = readl(base + pll->con_offset + 0x8);
 		frac = (con & RK3036_PLLCON2_FRAC_MASK) >>
 			RK3036_PLLCON2_FRAC_SHIFT;
-		rate = (24 * fbdiv / (refdiv * postdiv1 * postdiv2)) * 1000000;
+		rate = OSC_HZ * (u64)fbdiv;
+		do_div(rate, refdiv);
 		if (dsmpd == 0) {
 			u64 frac_rate = OSC_HZ * (u64)frac;
 
 			do_div(frac_rate, refdiv);
 			frac_rate >>= 24;
-			do_div(frac_rate, postdiv1);
-			do_div(frac_rate, postdiv1);
 			rate += frac_rate;
 		}
-		return rate;
+		do_div(rate, postdiv1);
+		do_div(rate, postdiv2);
+		return (ulong)rate;
 	case RKCLK_PLL_MODE_DEEP:
 	default:
 		return 32768;
-- 
2.56.1

