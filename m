Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B6CA9ED2
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B5080D29;
	Sun, 11 Oct 2026 22:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id durMU_GnCf1U; Sun, 11 Oct 2026 22:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ADB380DA5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757876;
	b=Y8dMZm28VVvy8DJ1Nqe44upzWBEptBcXa0Fwxsnn1psJ1APM92mDEwVXcQfvoCTo3Mg8
	 0wFoLENAwjZzToOGcO15+9bJJSXs7WVXGWgiIrWayZ3697pCN1ChDmvqru5P0X55d/KTZ
	 g9sq2qk5s5dP3VsemjK49J2Cd6rqhTaTb94LYBZUfzdmFHFKMwrYMSgK5jjr96aYcFJS5
	 NW0Lix7jB6EiLAPOPI4jCNshM014OlWpoR/7vHPl2VKu6Oe/fzRVZaUrmHJ4rjhw6ZMga
	 Y8JEZcI2oa/2yhLk3aMl2amyHH/kRwaHTo8glw66dWP9at4upywztcOqtek1k7W4ItA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757876;
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
	bh=3a3yUPIr7rya3mOvEXUT2EUqel5kvPr5KhYfrBhByJc=;
	b=AYa9m5CBz8p4E0ppa3ERAxBZQmjPzBz7lgIP3EzNdmHrbH186fWxWKIJtsdZrDutf4iE
	 RNgLONXSyA4yn3u9kKvMTANqTFAc6Z2sgnCeUhW1mvt2e8ZFVa7woVabzOpqJLz1c3KKg
	 Y5iLeSLUd6lG9UzX0JSt+ttX+g0VVgjntK8qSsj1x0HLT6CHm1DIWoF2tRA7XflCYZtQJ
	 RfXhRWjZxV7d6Dsbmy1f4rupxGrDYlk8TU+cJvnn5mm6rKAuat3bYrMuGU1VTHtf3trY/
	 q/DW9T2GDbqyNv/QbtnyzMbxmyRuG1FrDx+m8ZY0Imp2GglTuHGp+x4T3kuIHQ7nx4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=p4CHSmLL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757876;
	bh=3a3yUPIr7rya3mOvEXUT2EUqel5kvPr5KhYfrBhByJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FpgGY4WfdBbT4q/hgfzTfir5XLNT7h78HpmNHJye9WTpGU5Y9cY03pDIvoqjncGEx
	 o6Vt5jVVznMKYtKyMBWnTeuOQ/LSuP8pikE3UsHAwR1eYpf+1/YEXu7KL3X3GJaabi
	 /NJvjWJdjJnxt1N31eDjtLi2Y32OYLUM560NDYdG3FCvm9cYMZDur1AxJ+yNzNl58W
	 MjChtalqG+Bfa+caOQifr8N4hQ4rgpksZxfgAARER7KvXb+plK32qUJoTTz8YL5lft
	 SF19feo6VQd5WwSULjEiiXHShTxI7LfFAvngm/v0MqNrTmkpm2H0JhXYQC8TBaMlYG
	 9kr3pm0sPfS8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ADB380DA5;
	Sun, 11 Oct 2026 22:31:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02C5875
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCC2980C88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79eUWonrkrPb for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4788A80D29
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757875;
 b=KK2EghhairQu9FJXR5VqbgVpJHJsVVvd77WYqA2norkT/nuIEdCWDXJnqfVK2hCIYSan
 L0G4SUKqb0GHDpfSWqO9bnoEA7ydHuRKF69f+D/Ot/O8Hg6IHu0D3V6liPVO2QPbPGqg0
 B+dxrK7CQfq+ZXYLmWe5UcdpZ4RmifI3T1jadfgv0viIxnJooBbqPaNFfg5X7C5fFi7dF
 sdvUFDztXsZgOsei3HMIY4alKyvsyoLrqDOyiXyJObe42W2MPBlHIJclsk3eYtI4WQY0o
 BmvFZpnQM/44jDrOZbMa8uSD1DJZRm6GYki2jcJGwnKrbDofLnNGWV3Qlss50TSQUIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757875;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=3a3yUPIr7rya3mOvEXUT2EUqel5kvPr5KhYfrBhByJc=;
 b=nbvmmUZh2WbuYrvDEhHkfIaVQV6/Es6p8dcWCFFSxg3j0HHk1ye4oIUNSZQLCXJXZJzb
 tajuiI1D4PgVKdEqH2lQIdDpxMyAaLC+BMIwT4C2IrKBRjmd4Qr9jYlMUpOzsQQNxJGi5
 wVfQcavq6Dcm9ymxDb54MbG3IdzbLUTn19fBjiiB4HAgJ6F9nu1ZP7cP/djx7ZgahxSTi
 9drm2WdiAUbB47WsOirGoYev5X0GnLfSF2UpSznDlv1UWHSn7NegFRqLlqt9VaqxF+jkw
 Q//HIdlxD7qGowtUKG+IFk43/2saWikh2x6Kq+0nwE7DBuy6MeE2SpBmqPP3UZh/qlw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=p4CHSmLL; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=p4CHSmLL
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4788A80D29
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757874; bh=3a3yUPIr7rya3mOvEXUT2EUqel5kvPr5KhYfrBhByJc=;
 b=p4CHSmLLQgY+Nmx7weV+0pBDGdTOLF+JinCQO33+fDGdN74paXC/sAJS7GcuAmLnlExhHzrnc
 Zy8vorhPWGwZitD3I3wbUztWSsHasehXNMPyu60XMURsKH73fhoM2NQXEKG17Z6QO0eKtU0nTcm
 MZJlAQeN9/7ppsAcF1Pr9Zwmn9Bzygicc8QwT5R6yXMQLOncmsweopiYXxXeYF5W7hGbNcFntMt
 jDJ2A6vKTxAZEvjfDfbPO/gwIeHOE5ARTqV8Fh4R9pJP8OWPchsp+wsB71tfGH4ym2me0Iv9wx1
 cVHRY7Lgbzfsa87Vi3I+Z48HnOstwMSJbBwf0rkQCTdQ==
X-Forward-Email-ID: 6acc0e294548822a24c17547
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
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 25/37] clk: rockchip: rk3576: Use correct PLL rate for UART
 fractional clocks
Date: Sun, 11 Oct 2026 22:29:00 +0000
Message-ID: <20261011222930.1085075-26-jonas@kwiboo.se>
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

Use the GPLL rate instead of the CPLL rate when GPLL is selected as the
UART fractional clock parent.

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
index e66368b01b5e..7908a3c95765 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1715,7 +1715,7 @@ static ulong rk3576_uart_frac_set_rate(struct rk3576_clk_priv *priv,
 		p_rate = OSC_HZ;
 	} else {
 		clk_src = CLK_UART_SRC_SEL_GPLL;
-		p_rate = priv->cpll_hz;
+		p_rate = priv->gpll_hz;
 	}
 
 	rational_best_approximation(rate, p_rate, GENMASK(16 - 1, 0),
-- 
2.55.0

