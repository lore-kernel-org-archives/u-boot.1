Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA2FCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3FB380C6E;
	Sun, 11 Oct 2026 22:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w98WAXXjX-Ks; Sun, 11 Oct 2026 22:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05AC580C7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757859;
	b=UGNsWfj89DDHjx1arv3ToWP6qgJEOsxHbb3pk9Z/6Q9JUeaHQv39DMPFVGvM5eJ/htcP
	 Twyv87bFFXWOALqnYKqFcBRz1XIUAs4ZuiDBRcpHdhnzr2o6Ve874pPWP3jU71f9X+cde
	 TPI2y7wXNPWz0o5hVzB1o3URCXpKNBx/wW/IUTR6pL/P2aeOjUSBWJJWTU2LN+L999K41
	 fOQVjuHvlIoMdHXlPg+fXwGajU83BA8Wv3/IzDQ9g5rkngv42cFGMEdmw6pdLxUsiDD1S
	 1DFUfdpZRfgWa8sgoV9CPDjAzhWikQRHXnbOFa9d3R7mxHlDmwPrAX0CFktkHngO01Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757859;
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
	bh=Yqe2PRXDyaFLH6/ZSuAcQMN+2hEp8MbBlVrpF4++gfk=;
	b=qhHfawgYo+akNMFmnCiaBBx+OGolwDpaXLm0kWT4aHNMAQhVCUdhhpIDkJz7HDpcC7Ko
	 81VNnyYTnor+KjAgwDibA25YBBfQHjCbm9jvUHe8StH1KVyc3JycQq85ZTjCFfu9/jGIS
	 nPkOuC2w1aunuvS1Ax2XsooC6H1E/qqRn5tzUDivhvOv7YfQN7bdljhiim1pMRZX49NzI
	 DEiZ79NQN96QJsOhG781njd7st4F0br9g+XjTmCRongDuJGeHymPkfbBrOjLIQC+EB85s
	 7SkBC9KuxXaqxfKsb3HOfadyWTwVQWqV9ZoY3/Xm30lllK/kDQI+Ys1w9a2MG6rE95w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=QOh3Ykd0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757859;
	bh=Yqe2PRXDyaFLH6/ZSuAcQMN+2hEp8MbBlVrpF4++gfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=At6nvoeNvQY0F75lBxu0W5IWfItZlz2fU6xTBixcj9mBoGyfqWUVPDIxDlx1SQCDD
	 /vY55pBA8gX2QXNsW1cL2qfx6WnVl4PHJCCPAV59wpNVd8n69KSuYFcTforASGLpi7
	 Rk9Wlmj2A5jm16n+Di0gfeW5R8FxtK6l2xEXk/e+3FGs4h3cU7EH2Tje5+kqwYYSUz
	 7YSBHz9sxyap+ki4cPdt8EJMMcg6crIEBqLff1R2QUHx7Ub0vbc4smcGYrQLyfgV30
	 v7Dw6GZXaO7H1gLQXJD3ji+m8UI6uK5W4jOQWpKKyHNWaB5UUUgP4vbEzV03h1p4AQ
	 h9zJzXvuddnqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05AC580C7A;
	Sun, 11 Oct 2026 22:30:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AEEE75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70BF080C6E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEJdZNH9u_ED for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD03A80CF2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757856;
 b=oC5iRwqEl9GA00jkrmvUBy7+1NotTYqoUDEguTJPtyH7/XXSUglLFnufnLEM1Ae6d3hY
 OpWSiZyVWzAGH8zOHc7fgaOS4eiBUj4mUdLmcMn86bswQhhCdE8l17CHrfmnH8PHvkRMB
 hzfy50SPNK8JT2lIn7yRUh7nCwGZRdnHJ9Bqu4DIaZrx6EcczxI+BFTkgAzMRoMFZJAlE
 vokqjaAQXrbdT9si8wMiB0IHY1ZXGTnz7pQtP/SwWwADfpt8SgS6Fuliit0EJhSN7nbbV
 qKhT5ASjq2yTqNgzG3zM+8Tr2nBqHD2zdQIsGs5+/2UC8Nc+lgNmWib7EDomCxLYlFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757856;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Yqe2PRXDyaFLH6/ZSuAcQMN+2hEp8MbBlVrpF4++gfk=;
 b=gVD2JaDtklV7sS/B1Py8oEvERoR76onwi6kJuNnrhVEVmIBcKnvAH6EUCSH21lfIm54s
 yDmuUFXytMhHNDeBZBwQmsyWMtzOnH48UV3XVFMxm9g8uxLDJQz4SFoUmBdkGuZXFspjB
 x5R9XxOvx54JdqBwSufH5WnT4TVlQhBFBeqwVkcmRWZL4y83C1e4ihOIoXxSxGdZIXfqP
 G6Xhih4SPb5zd96iLKsyljudQ4WGTal4pifPgFgS4o/eKlfy7OOOh28HYUaGIox0/cHSo
 ceGyOiEwm/SQJkOdnmz/uLP0LaMuNtUnM8/3OKKTtn2/WnftQmhv3wnrw9HllEkE6ag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=QOh3Ykd0; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=QOh3Ykd0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD03A80CF2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757855; bh=Yqe2PRXDyaFLH6/ZSuAcQMN+2hEp8MbBlVrpF4++gfk=;
 b=QOh3Ykd0akIDh0xXW0cDqkmh+QWMjVlgYl3og78OjeCaOOUw8VBVcqIohXw0ENO29AQGTw38k
 1FDWHYfHwbb41+UlUQmHJnNZX/AUnAK7rQtaOvBAxdj+M83eKd/qFzCDxoAIwAnP/Zda23zLb5J
 zNFWBFWiHVCPfW0/2CTAKco22qUPb6lKQZmj5vIGH0xvI2lgNUIPnTFA04zNiKuGgSoVrsHY3UT
 gwfIrSeTizHGYMhSxtoXd4ZA1qomNk6Zh1FmVBTX6PwGbGz1wHkObQy4csPcoGJbfTdhVe0snCC
 bRTZ+btZbqC+Gd43s5VaADjspYb84sfjy8X8K7EdBGEQ==
X-Forward-Email-ID: 6acc0e184548822a24c174bd
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
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 20/37] clk: rockchip: rk3576: Fix ACLK_TOP_MID parent
 selection
Date: Sun, 11 Oct 2026 22:28:55 +0000
Message-ID: <20261011222930.1085075-21-jonas@kwiboo.se>
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

Write the intended parent clock for the calculated divisor instead of
forcing it to GPLL when ACLK_TOP_MID rate is changed.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3576.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index abfd57e2447e..b4a5a145bab0 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -320,8 +320,7 @@ static ulong rk3576_top_set_clk(struct rk3576_clk_priv *priv,
 		rk_clrsetreg(&cru->clksel_con[10],
 			     ACLK_TOP_MID_DIV_MASK |
 			     ACLK_TOP_MID_SEL_MASK,
-			     (ACLK_TOP_MID_SEL_GPLL <<
-			      ACLK_TOP_MID_SEL_SHIFT) |
+			     (src_clk << ACLK_TOP_MID_SEL_SHIFT) |
 			     (src_clk_div - 1) << ACLK_TOP_MID_DIV_SHIFT);
 		break;
 	case PCLK_TOP_ROOT:
-- 
2.55.0

