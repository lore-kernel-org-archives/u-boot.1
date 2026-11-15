Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546B606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GE/gP1Wk;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=UUKnEGtE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0A0C80DB1;
	Sun, 15 Nov 2026 19:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NrBQEhruJO9G; Sun, 15 Nov 2026 19:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E781C80DE4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772576;
	b=gbHiGELR5vtL5mtfrJ7hGKu9uwfEhvZzhnPrkI86YVaz9Xwivgd05KoFD8xr0Ie6+iSr
	 IV8/BzlKShHQ3R1a9NSe1SfP8/HGdzReQo0RmtX9sQAuQB51ZYn8iCPFxakcmTBwtblhF
	 gkKlNOoIMKElmL3G31Sj94SHqwPk9E8eh3tnZRf0MF0vTcAIU9wpjtpdiKr/QjiSs4u11
	 uyunksfHay0dgjR20eIiawp3J71Oyhk5ZDrR8cRupJ+m48iiBCqOBJ606OL9U7R7diWFA
	 UBupWnGFXeHpStC4IlwphKvbqwjUbMqKQin4kK7NqzC+6bXnnkebRixkvU5OLoouMLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772576;
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
	bh=HC02pI7geMtcQFuqSaTI+w6CnZP7JvS68LaCE3vFYb8=;
	b=tha7/ZgBuAvk0+NBN2bT2peCQUbDwC0+OnOwEg4w9kkZXncmrU/LmXCDFaGwLwRP91Yv
	 xDPRH6QtkOkXLcMc+zMPSefgClkRHeTxSrBJmzxZPcfvKNbgSG9ZCkBvdGK+WXwSp6YiM
	 zrhTbBYGePWj4M+0TZb15/oM/xpmK+m1dRQMRebQmHntyKd9tyncqoPT0hmTsCohMteao
	 DzsXdBHNARS4oRKgyR+Ie+Rsia9T792PBOOrkaCZx+7M9wW+PzKIZVVPVTbQKz5p/HhHj
	 6QfFR7U1ynsmmMZ3UNfen9AX4ueFB3Bbg9r73ZC5Ao8i4pItNy6jn27EPGOltXeAPKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772576;
	bh=HC02pI7geMtcQFuqSaTI+w6CnZP7JvS68LaCE3vFYb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GE/gP1WkeAs9IWkzWXIP7Polrmbs5+D3R/X+4HZvSPjJksuetD8NYyKhXzoG04CKP
	 LAGZC2Z1lk8UlhG3+S8Wkbr7Al+Z8eDQ3jMsc4Le+fxQO7DznHWFiNHg6WFONZnRs4
	 ONCUoOK4xOidtW+Zbt43zK226JCHjIuILat/S0VStkSqf6zWLC7LgR2z//dItcNc1v
	 l40YWI16e076JADRSnqtZmDR7a8k2uMtU8tezKq8otvh2r9XjyNtbRuemB5gPoS65a
	 8q7IH4dxUyeBLBb35coJo/QPt/GymF3zN7KmT23ka2tLd1RMOzK01OK37HAXI1/z9L
	 8xzxxanMEFlHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E781C80DE4;
	Sun, 15 Nov 2026 19:56:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 343701A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AA586061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPY6Es-Sbh-R for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63AFA60672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=UUKnEGtE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63AFA60672
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772571; bh=HC02pI7geMtcQFuqSaTI+w6CnZP7JvS68LaCE3vFYb8=;
 b=UUKnEGtE9+llmTxq2UKWKvuSklMflvMof6vlmOGWiFCCyzCpluCyoG2yYBJEfOOaXO/TA1Ozn
 z2PRT8/yI7t4wvJyiCRJE7ZzRMPAMyju3VCr4yHJJfmrI+JC/ydUWwLXHBARHBYKKzyhZ28r7QJ
 eESc/u12DlkyLyn279m6r2Kbj+jlmIWFoi9kL1VDzRGPBkFDkpj7KrV5Q/c3mKapRUpaNmgl3Cj
 WZyXnvHANUK6PkaPEma7vdgJklworEM1yHFDv6X0naoMFxUbhr2kMgf3tGzRJEEnOn1apuwV/qO
 W3MLRUxeRsI0ioDDtM/8aq1VSy0UNR0q21ZuLrSu9eCQ==
X-Forward-Email-ID: 6afa0e5a2aaf531b6d7404d0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 1/6] clk: rockchip: pll: Fix fractional PLL rate calculation
Date: Sun, 15 Nov 2026 19:55:53 +0000
Message-ID: <20261115195600.119868-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115195600.119868-1-jonas@kwiboo.se>
References: <20261115195600.119868-1-jonas@kwiboo.se>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
- Collect r-b tag
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

