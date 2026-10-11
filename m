Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF92CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4946660612;
	Sun, 11 Oct 2026 22:31:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tP_ahaF6_hV7; Sun, 11 Oct 2026 22:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9627E606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757903;
	b=ssNo7JTIxWhm+ay8DhAQFsz7zidYLDfF+fU84zaIF/ZWGBCSE21hEDz5f1N6j34K67UG
	 viMbP+VHgrQj9WBc8cn7krzevSEB9eL2r6Q+aBrP9S/jliMmZMJOjdwbg19Peo9gsmQZs
	 24p6+GvoGoBwrlSLbl0LZZ+ph4f2CxLKKV9QyPzA8YO+PMK7rgzJo7gHmAQcLWLFcI5bQ
	 5zC+KgrG1SlVJlK0Xeof1KZdkMWjmfo/zaUtP96cVrbEHeFYKM3JV9BE3rOaLsMJZxtXT
	 HauPgv6noWW4w50JcAtBdrXIza3tGDDGB6pSOA9sN29vTluWCiAsWkKseGMeQh9JnXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757903;
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
	bh=O8XAW0J0OvLbXXqpY8Cdda4jms4d8oqHRDsN/VONcg0=;
	b=Rh3sE2GVQqZ9YPpf+yx6ZBTv27J4ZsDN44vXsWDMzmXqJaxJEALj2mvfKpuJRzMUqYKX
	 RKDKy7cWeVO3KQ2Ocitr01aROhrAyTm/W+TxVKZc2SgItaE3oNQArurPHvpIGA2VLoIR2
	 apCtPLJLSEhhYM+AYJtx7Drio3aUJlOqSZS/YkbYiCsgMHf7uKVpAIy4AH8svJ3ctxYio
	 lYpX6C/i+JIsjsOYoU77uzDuqfc+2Vn+qIrb73lyMQwuzJLbIXZku0gx7YEUEBGQ3VJtT
	 ktEbcflXcevaStpK+ipel/L1mLOt7Q/LUCiiYbux7M4RWFMuG89saSRkGNUg73IrJWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757903;
	bh=O8XAW0J0OvLbXXqpY8Cdda4jms4d8oqHRDsN/VONcg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvYVxtdz0u9Do8wf1lIlUQp9n2uS2rlzEL3N8VaeWhGdIF9Fq56+4Un+zymJV+XRS
	 YSHRk9YbCKCHLkYLD4C5RUzBD0azb1FnUxCGbVKbRrDIt/OqBhVLJNMfrsu1ADjlgt
	 k2y9j6OfsXEtdBE9AO9/P53yd+513QQxa4fL8OUMBwoBOnHG0K9kmoA+wZvLZV6fDg
	 8oRbvdkVpXRdqbShkk1CpbN9oKRQNziDIdLVgFRPkq6xmmdSfaatPaAoocuynNM3ze
	 CA9j2fD8WrEk/0p+WWyvt8IKIebi38jJms612rpWWbB3VtxwDBF0/0dreM1n91ROvY
	 cfpME9nwZZugQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9627E606BD;
	Sun, 11 Oct 2026 22:31:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 260611DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09BC880DFC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uA6-JAXnP0mF for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EFCC880DF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757901;
 b=Jesdip8gLPm+KRwbuo3KTWb1rSFsP1PAOz4n3EAwdyyVaj+ygN5BLH0PpuDOaHt0OUpP
 4eUrYuH/YybsZ9duEhxuUQhbdn6dS/+re2gBgzGtaRmpgLcG8ztKxYVXmeoTOzd1XWl4D
 QAPBycOD1sC52o8fxx9RHudw3ijXST5cgaKj4D1nmk3p4WbJiXTFPeNGfymrHSNI3uOj7
 c09OHqXbn7aWzRb/UMEeus5gCQnR7HvkVzzVzZ7vttaSltjjEavHriqDJ+rosUmIoA70+
 biHKnM7l/n/F+R3+3YrgsH5unotSeZCHYwJgwuOmHYurO6VcDPpT4ISrdXJurds66QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757901;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=O8XAW0J0OvLbXXqpY8Cdda4jms4d8oqHRDsN/VONcg0=;
 b=IpwS2yVXWx4ZNEYyljrcjgUjuvLllOOHi2+3DvmR6pFykmTLlixL2XwQ24wxC5c7x11y
 pczPjMoAIaUJU4ZOsWvC3FltsnsQRHzm1dsszyqct0JWvmbbxzo7IQPg8aoZf7nDG+vW1
 j0F7iL1dxoRLqbYnWZ2EzJnYXLRDwmocExHOWARA3I6JCx/c2r6cS0gfistlavDIpkF3T
 tp5aLLnezxkLcG2fmLGVYLg1w/33GkQcKpgugUBeMp/cr6mCq+6QVuZGJdFTfKMDM3JM1
 +PT97shoXQkQpizYtpEH54JNPBIjjluET+6k5Su8PHC79ZhFQKRkcyC8Y8PwjibGd9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=RaZZv44x; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RaZZv44x
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFCC880DF4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757900; bh=O8XAW0J0OvLbXXqpY8Cdda4jms4d8oqHRDsN/VONcg0=;
 b=RaZZv44xKkMCpJiebI+NDmY+BHV4lQuGXGXIr1i208GXuKi2bbEr64zXJ/HLmU56xDbZsSYMS
 0XcGuk5OUQZlW6m8WYJS1M3zc4roZ3iUSDBAZ7h5n4kQ95X296/0kMfufeLP4ZogXpLY9PKw7VY
 R5GpMObHX4exOdQpmnPkD2dJN8GDq77bFXpyu1nHvP66+SjMFXhnkysIeRKXCsofiQBWjDOavUZ
 PDOjIcs4jsjKCC5S8zJsfm6dxG4G/SOtsfbouy8B2EKPF1vVxqMeXwC4rH5WLEwS4khqARLdM4H
 4aYTombRDP/qOYfJlKCqCfxwgVloseoDvWWyb8Eu4kiQ==
X-Forward-Email-ID: 6acc0e484548822a24c17643
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 34/37] clk: rockchip: rk3506: Return correct rate for
 CLK_I2C0 and CLK_I2C1
Date: Sun, 11 Oct 2026 22:29:09 +0000
Message-ID: <20261011222930.1085075-35-jonas@kwiboo.se>
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

The getter for CLK_I2C0 and CLK_I2C1 both fall through and instead
return the rate for CLK_I2C2.

Add the missing breaks so correct rate is returned for affected clocks.

Fixes: fbf72dce915a ("clk: rockchip: Add support for RK3506")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Update commit subject and message
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3506.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index 38066c5c3e3c..457082eea87b 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -537,10 +537,12 @@ static ulong rk3506_i2c_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
 		con = readl(RK3506_CLKSEL_CON(32));
 		sel = FIELD_GET(CLK_I2C0_SEL_MASK, con);
 		div = FIELD_GET(CLK_I2C0_DIV_MASK, con);
+		break;
 	case CLK_I2C1:
 		con = readl(RK3506_CLKSEL_CON(32));
 		sel = FIELD_GET(CLK_I2C1_SEL_MASK, con);
 		div = FIELD_GET(CLK_I2C1_DIV_MASK, con);
+		break;
 	case CLK_I2C2:
 		con = readl(RK3506_CLKSEL_CON(33));
 		sel = FIELD_GET(CLK_I2C2_SEL_MASK, con);
-- 
2.55.0

