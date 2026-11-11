Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F36606A33C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qOPBgg55;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=wM4chIdL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1205F40A71;
	Wed, 11 Nov 2026 22:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nj3pqKVA8qP4; Wed, 11 Nov 2026 22:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51BFC40AE6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436316;
	b=ku1Yo7oIKBRFKzzySdiYRZih+I0a3Kih3SQbrrsqbnq49vPWtGR7vmQSw5AvG7K4LJQJ
	 XCWqPDVnZ0X2UDXx05pCVe7lMjM6XANCx1Q8Rdi0IN6lzHz/B2Ysd+WpHZnyn3Q0IM4zw
	 z25SPK6HnLkpzyjsUxwnPb2BOnevDenGN+/Kz+d0V4fc25Jd7WcHVs48Hi8Thxupm2I8V
	 cc4qJVV9h17MxzjAzQgm6noXNjD8AXYT4KihztFg5IdO9DEG6uSVZaeA6IvpqQfqGG9s9
	 BsCkkiK/Yt0UR/rFpV4NfuV4VoB0b+LYsKI+fE0QrkewGBbRqrP2Vis6tU6QxK69f9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436316;
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
	bh=tN8qCC7fdMA0jJIYAPpkIA6/c4W8hMNWP8HTkokUnVI=;
	b=XnUajeAcZFAJdXiBzxdu3fcJWVToQB6YNV7FRysTqoWGd1V4ACxkvxr5AvTkTWJSY39D
	 SBP/fgP+LGUUIRNmWEswCpcQpDY/BQaDmQ1N4fUm3ozyhywP5bRY1LN/BgHPYyW8bAYIW
	 nDShwDBeRzqhIo8UrSZA40aOiP/yPHRgfEPpz2t6ZqnT86YNXtF6EhcqLemnVxPaClZH4
	 phrNDQagZOKfNqRt6deEVX2RHDlK1nWa8B3oEJHQuFLf/Iql5D080MW2vL17leVjXd7Us
	 h2RdDnpF9bQe2I7yg3KHv5h3ZsRrvvEWfw6byG1dUAqEFlefjHIMVkSROXBVeQWfSvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=wM4chIdL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436316;
	bh=tN8qCC7fdMA0jJIYAPpkIA6/c4W8hMNWP8HTkokUnVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qOPBgg55nNvwB8Gs8e13ZqSv4PHv+n4DkEcVga4TWxPCI9nB/2gRk9mMixW5gkOOH
	 w5dyCAzEbiKFnrsB8a5Xi/MI+JwuxXPvDeUVKG+GYlVu0ErrYT1+eU+AJvTrgyNBEm
	 rlDr5nFT/R3UU6ShDsFbz7jqYrDvpleE/B0cm5PSJWe2iWOQKK/N35uSv5le7natvB
	 bSaBD/izhayHMtmb5FEPRhe0gDQ5+6x+WyXIkwOwtqeP5G1odDdYOC0PtQL1P8RVPR
	 JK/d31ujN2So98HFPfb70QHUjmHeDVBv/EqhpZfDUYYAh1GLkC8SNU6+R7RMa8BFyj
	 OW3iO2BY4nIIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51BFC40AE6;
	Wed, 11 Nov 2026 22:31:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B953C31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAF9D40AF3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQ0w1M8VcCgW for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EEA9640990
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=wM4chIdL
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEA9640990
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436312; bh=tN8qCC7fdMA0jJIYAPpkIA6/c4W8hMNWP8HTkokUnVI=;
 b=wM4chIdLg4Oh6qfNk9Qmk/RjAQenSifMbYHtY86dBOO39jVv5p/Tewr963dLdIFGymVFa4bCV
 g+EpZEDBk0P5OQlv/k4AMtDrvmpi2S7Oe4d+5rhUwD/vKb0TFe4Hr7LqLvIDser+Xw6p8sKc7Yh
 je86FcrA1iygSCEUO3CHxdBO0vXAQF5OxFZcu1Pr4gAiuTMLPbAuy5cqXeO0ZyUZzmmBYqgoNrR
 2VtdcuDET/M+FjoqevgB9YlX+Uasr3lJHGbSjaG111j+vLZCAx5aG8KwsoTqnKeVxqQfhrGD1BF
 njvUUBKAZLYMJf1H3XE+7NDuqFlO+fFlxwviSO7VKRAg==
X-Forward-Email-ID: 6af4ecd7eab6e8cc0ce8c07d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v3 2/3] clk: rockchip: rk3528: Fix VOP clock configuration
Date: Wed, 11 Nov 2026 22:31:40 +0000
Message-ID: <20261111223142.158361-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223142.158361-1-jonas@kwiboo.se>
References: <20261111223142.158361-1-jonas@kwiboo.se>
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

Setting rate of the VOP clocks never changes the clock parent and the
old divisor value is OR with new divisor value due to incorrect args
being passed to rk_clrsetreg() call.

Use selector and divisor masks and values correctly in rk_clrsetreg()
call to ensure VOP clocks are configured as expected.

Video is not supported for this SoC, so nothing is likely going to try
to change rate of VOP clocks until video support have been implemented.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3528: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3528.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 0ac6fc68cd61..f7e85bf26731 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1097,7 +1097,7 @@ static ulong rk3528_dclk_vop_set_clk(struct rk3528_clk_priv *priv,
 	}
 
 	div = ((DIV_ROUND_UP(prate, rate) - 1) << div_shift) & div_mask;
-	rk_clrsetreg(&cru->clksel_con[id], sel, div);
+	rk_clrsetreg(&cru->clksel_con[id], sel_mask | div_mask, sel | div);
 
 	return rk3528_dclk_vop_get_clk(priv, clk_id);
 }
-- 
2.56.1

