Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AI21prFA;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MX1Esomh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F4081697;
	Wed, 11 Nov 2026 23:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jgQjkdXua61; Wed, 11 Nov 2026 23:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 078248118F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438796;
	b=iklRaLTfm+KWX1pFAvn0OCh9qsApYmYmLjENnzrZdDybJCwds49Hr9zdu8u8CqQEl60c
	 XKT3DL+FKQ0+yuEIVSBIN62utbXx7WmZ/EWSZrDOLAd1l4iRiomhRuXOyUvOJs8osmFep
	 aRd3zT2Nhck28mQ4ojBzL7bbOxkB9V/Te1VcQH10hWygUwiEWHzEVY14ax60tr4NdJSvy
	 E66NHsJGDd5KxUADErQJHNUeuhJd1Niuek6i+1sZnwzFAdL3w7yZTc35GPBSiGcpjSwiE
	 /MDCl4crFvGYZ2NRjLujeBBGtHp3F6x/iZtmDzXgDahw80P8JL+qR4e+uO6jsGepfUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438796;
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
	bh=nBJTYoO3cyo74XeXqRu74NHl8fuFFNBvJ+3kXcHdoLE=;
	b=CxyZKFEgW6tRlcp5Bqw86doHL45ZWP++f1gbjxQ0/hYYwgUoQWlOqg91rizwm2zLo1Je
	 s6gSDHsv2H/PViv88PEW9V2f5UiyefLdNpIk8P+SiqIl/vunZnoS0N+9ho2QUpDNTlgi7
	 8OXX9ArgT07NRJVzcVBpaGy0/JpmbUmRjSk+YWqIUwmIYYgO1SfyiQUMWj3+efmF2kDdG
	 zcTa/Fd+6+Y5QqOFnHQx0S+R/4bxG4REQy+Fy3srm1WHjmHTJ41qz8XhbLE4PLPWgUuCM
	 z5SjqLDTj87QRDezPFeQKgJhrzPjRyI89LPd8be17TXJQjWVoCiFn7YMwqPkCr0OJCw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438796;
	bh=nBJTYoO3cyo74XeXqRu74NHl8fuFFNBvJ+3kXcHdoLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AI21prFAhFa4JehGYe+DA9uPwHou7s+MciJkudBppI36G3b57UhgYOb6fbeyUVdM0
	 rwfzBCfpe4n2Oqr2B//PbXtUgcQJsHpPFraBa4+q2vyC6Xs6TTLdHf34zyHJicksBi
	 KJSVmkLsCJ9sNsgzfx6Q7YoT86cpo8RGB2qWdS/PP+P/Ld5ZpK3gA+7jCska0X4Zma
	 UZ0LSCWOSfqLxbQF9FEsr6ITd4IIL0eiltsDPTDwBgkvke2yPmrz4Fdk5fJUky6eMl
	 zngc2OQ6JscpOc+FzYGq0iJdQ56wppr+CIYupsS1138IKoYemmpIqN47CTE2SmDdOQ
	 VBX1wER1nnCNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 078248118F;
	Wed, 11 Nov 2026 23:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62AEEE09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5417640CFD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kgVgd8qgiyHJ for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5DBC240C66
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MX1Esomh
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DBC240C66
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438790; bh=nBJTYoO3cyo74XeXqRu74NHl8fuFFNBvJ+3kXcHdoLE=;
 b=MX1EsomhNrukcAASp7h8zPT3zXbdzhDN0KNEXB2Tn2KByZRWy2K11ElC76yjaPcZE55XtpyeX
 yju/qGaUkiNG+EfNRSfQflcaD0SwVdELETzTchDncKyzz3vSXOku2sUYVoX8AkwEI4+Mn+kAhCc
 elO9CYJY6MhUDrRh0gokU3uZFWMmUZpOFL6O43PtEzqYCUK6/ic71GM18Sbj6tEBJxB+aKYJG7O
 TXPoJmwQ/a/zLVhD8wXUjXzKy80hhfiYel6f3Xv3gsy05Bv2Nst0GTANeM4hVAbh5/Scy2lOkqF
 W1piAkpan4b44BM+CtPa9/wqlwJbvWtktDA/6afJPMvw==
X-Forward-Email-ID: 6af4f686f53292d6859f33b8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <ehristev@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 4/8] clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
Date: Wed, 11 Nov 2026 23:12:45 +0000
Message-ID: <20261111231251.160051-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clock driver always reports ACLK_BUS_ROOT rate as 375 MHz. However,
the clock is initialized to use GPLL as parent and a target rate of
300 MHz, with GPLLs typical 1.188 GHz rate the clock ends up at 297 MHz.

Change to use CPLL as parent and request a 375 MHz rate, the same rate
that is already being reported by the driver and what the SoC DT uses in
assigned-clock-rates. With CPLLs typical 1.5 GHz rate, this matches the
parent and rate Linux typically ends up using for this clock.

Fixes: 716ed2a8c0bb ("clk: rockchip: rk3588: add hardcoded assigned clocks values")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix ACLK_BUS_ROOT rate set during probe"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 5e9b6a1e62e1..de435f7d0ec0 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1923,10 +1923,10 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 {
 	int ret, div;
 
-	div = DIV_ROUND_UP(GPLL_HZ, 300 * MHz);
+	div = DIV_ROUND_UP(CPLL_HZ, 375 * MHz);
 	rk_clrsetreg(&priv->cru->clksel_con[38],
-		     ACLK_BUS_ROOT_SEL_MASK |
-		     ACLK_BUS_ROOT_DIV_MASK,
+		     ACLK_BUS_ROOT_SEL_MASK | ACLK_BUS_ROOT_DIV_MASK,
+		     (ACLK_BUS_ROOT_SEL_CPLL << ACLK_BUS_ROOT_SEL_SHIFT) |
 		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
 
 	if (priv->cpll_hz != CPLL_HZ) {
-- 
2.56.1

