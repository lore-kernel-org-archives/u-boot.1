Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F13CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F3F780D05;
	Sun, 11 Oct 2026 22:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoJP1i5CZW26; Sun, 11 Oct 2026 22:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B349380C75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757862;
	b=N9pRpB4XuEpI0nS+6kds2BYLzv08UMsvwAAvt/gheSvI600JJaxwu/MCJTr4XAQ+wPel
	 Wrnp0rSkZFi1MWNBxdQfxfjjFIkwsmpkQ90nqvaDruU7sw8L61EJ427INhhy5CbmnbdVN
	 fxY+hCmgDbWJ5FJn6i3iMXFu3EbHuqR+fb/ayDt+T6h3IzNhtOxNg3iOeZeSzOKY63VQO
	 V7uBtG5myPrjxXNiMEjYBEsr2l8konzCeKq2zKsND8lq0tgAehWmTGDFdaEbckMj6/DAt
	 XOdzNkDFzbsrtWb2kW7Ut2m2CeH6fLwY59CgrGcN2P8qcx2aOXsM+aG1q9Mw0Aa5zqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757862;
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
	bh=xxixuPkJne+ScG1wTXYXcD7EoBpr2X4m1xVV9ZDXZV0=;
	b=L99zR/nCKQ3onCg5Lxzs6S/ounTI1HixC8UmIc0RArt6Rc6vUwym6aQIjnYExNHMD3IP
	 gTRpxHwgPVAWoFe/43uimL+6yEdpdcsGDUGt3jMy6tCrMzrBe/4PUA6J2X7N6hJYjJli6
	 N2kRmu8Y9pwsQOWOA1g9gaD7YIA2WATR6pKLBf0Gm8zcvDxaaTegkb7xVixuwnbw2AN/d
	 auGd7apMmqHaWP5lhZiC2wthnqoOLV28KmIQHquxV2nsS5UiFYzwanREYyuex1JlNcQhr
	 QvT9JecoY/KAR7jZEN1Ar8GQMYwDx5AIoqi6tej6D/iR8FKUI8ZZ2f1Z1VjxpQkoNhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=QkZ7qkUl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757862;
	bh=xxixuPkJne+ScG1wTXYXcD7EoBpr2X4m1xVV9ZDXZV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TczoXAbho9DGmy2eQYng/ZOm8Qtm3HaBW8fd1yz5L3Xnp2vrVAxO6ZDykqoPXZpSY
	 kec/44Oj4IZgNFMsuR7+5n2FLXaYKFlyWvLXQMyWYDrxVeNETxtzZ4BLgRKISOvqE9
	 QNWbIkSkVyib/uNmvFtvZHL9hWYW5r+xXeDhZ8P8avb3iHO4omMIg9mlBcaN+0vJ9t
	 KHBbOa0WKHHZMDPx1esbuR2NGnhJl3WFtoMg0czSIOs/ytyj8s+z4sOyi7hp11MA3G
	 DXAYMuTX8UyFGfw2zYh+vbF7Yl10LBGj016DWKCZ0VxqiuPA9fKbtZFEr2ZWGRFEtR
	 IR9PXYwmoqn/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B349380C75;
	Sun, 11 Oct 2026 22:31:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 357F8D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B2CE80D29
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXfueXgGlumy for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 371EA80C9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757860;
 b=k0O0g7xjJcOWdGe2tF59RGon93m46n41sqeU+k0buKykO+cmrKFRdxbDcIn0yrvgWSQi
 On8wsxi5XJiKH8GAnWLw90ZOcg5TQQeczA9yIex6pSTsGukP0r9avV5wui/sGxGc2RW96
 ztASeei8rSSY1o+AdDGGKcaTazU3ydihOMmHOUp3IK5abv1r/Kn7q0t/pQ1AIIuyrpFk4
 zJ0cRh5hP9xASttF0cTvIg7aBtXvFKpGcccsVNgIorV5EDajO+U1FlWulU2DXnd1lAxJQ
 FTqeZDvTcxfmxqEct2lbq3oITfy9jLHBoIzdpx+sO1u7jTL4FYcX9436QhGMkyeWVDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757860;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xxixuPkJne+ScG1wTXYXcD7EoBpr2X4m1xVV9ZDXZV0=;
 b=Gfoi3pQPZnZ6joV66p3iyneS6HpbQBaVK0++dIMCHWzaxh/y5dK6QZfWZ4sLuX20hsOh
 ip0KLh6hsm05Ra3grTt1GXDOxZhp4vkSucbxYEGPUdrJjZlmO4V9GCDUKtQin1j8qx+ka
 IcNUYSaTFR2EH72gKCEbPkDQZZE1fzgu9Q9YPGsuYLy5Jqb9WPk+rlKEQGva0sdoLheYM
 Rl2/9AsHjCRPhxMU9mVK2e9O70O6qPL41UxaQhNGNYSQuo6oqLvhxd63DBTkTSA4LO85K
 QpDnbzBEE8jBVKxc4GupVQteHbXJeDURbPeHoXJaZYqwWrTE5gUh2WAj8YMxXZ6UTQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=QkZ7qkUl; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=QkZ7qkUl
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 371EA80C9C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757859; bh=xxixuPkJne+ScG1wTXYXcD7EoBpr2X4m1xVV9ZDXZV0=;
 b=QkZ7qkUlGHhz9RiOVX3s5o+yM3Iu7w1wFZFazmTf/PHD60kG5ooAwJso2VgrC+Ga+4k/qyOO8
 8cSxdw2rDxjz88hc2NRXm2cuGMAp7Kw2vLjQL2Dx2YP9bjRbiSljCy0tyWuNN7jo+BUk8Hc/5Da
 k9FzrAdEtjOlJRittp9tWwU2yC+ri33/mxR9tFQ/OisDRWsWu3ZNxHSzhZk2WE37d6SMQ2msD7A
 BB4vSzw+xbdrhZQFZUY4M+hBg5vAc/H2qF/EsIh62T+byHZUiOe3JT6dqstQbv4sIebS024rgZf
 /W0BjGnfhWXVom+wTCMaosFJbM4Bx4UvuFOS+wF6xqhQ==
X-Forward-Email-ID: 6acc0e1b4548822a24c174d8
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
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 21/37] clk: rockchip: rk3576: Fix I2C rate selection
Date: Sun, 11 Oct 2026 22:28:56 +0000
Message-ID: <20261011222930.1085075-22-jonas@kwiboo.se>
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

The I2C clocks supports use of source clocks with 200, 100, 50 or 24 MHz
rates. However, the driver fails to select any source other than the 50
or 24 MHz source clocks.

Fix code logic to allow selection of all four supported source clocks.

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
index b4a5a145bab0..314a543895a3 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -428,7 +428,7 @@ static ulong rk3576_i2c_set_clk(struct rk3576_clk_priv *priv, ulong clk_id,
 		src_clk = CLK_I2C_SEL_200M;
 	else if (rate >= 99 * MHz)
 		src_clk = CLK_I2C_SEL_100M;
-	if (rate >= 50 * MHz)
+	else if (rate >= 50 * MHz)
 		src_clk = CLK_I2C_SEL_50M;
 	else
 		src_clk = CLK_I2C_SEL_OSC;
-- 
2.55.0

