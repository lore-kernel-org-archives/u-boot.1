Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C969606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MWyj3Hgk;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=z6lt22Sl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF7B140C4E;
	Wed, 11 Nov 2026 23:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFQKcvPpCsAs; Wed, 11 Nov 2026 23:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42C9E40A52
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438792;
	b=pQ/iI/1aB9UN5iXB8NLorgp1cGU1H5yHsYmlMU1P5NefxEzy4dU3m60V0fJIyRyMEGOc
	 ELeyH82TNtlqAyrPXs8wismKQ9Mfbuo2xmKNaKKEj/H0x3lI+IRj5L0ZAMemKrJWo9uuU
	 it34YdoxyijrYlc2wzhIb/ZMk1NQAMfhaBBkuwwhaxubmg2bt216H3m5PjduQriDV3ncC
	 6nSu+qkadmX6YD0qxUbp4q+FsidBdo9yh0WD0KsUNB/DBrNGqffB2X1bnfXSPiOapYXQW
	 53vG/wOVe11ywgHbNS93HxyCcShmhA7C387po2uc3mZQBf3b0v56aoCusBUZaTzWsxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438792;
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
	bh=R8vGfUXS22Qp6JJ9irnECr8gY2IZV1lRDEUgCrEc564=;
	b=jMIzmHxw2INNR0yBH3N9ei8vOdi34GJZfN0eOyWAz+fJUJe0ZvOlMmfWOCAd9kLeEWQg
	 oVXx+BaqFcNMU7J4ihzUEFPqdHSpV7vvamqGvLnclN4YAiDBZTrHbjWgjiRRPEBCLGPz/
	 oYuFDm1bSUwcrVEGNKmiqViP3j9qb7b5G4wbYUpgPhH6mrHK4zXY78e9928Xd9pF9RlmB
	 OwUYrXBXX3aiE17v90LMTDF2tax/qSUlaEm9NzRNgf3w2anFtshQH1SqwM/uMvCGBvQJs
	 VSBfRfmQvgVmG85GIWp6driSGivJYBQp/VGIPN/xEXNgt8f5Xq1d1hTQ1yWlwpf77jQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=z6lt22Sl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438792;
	bh=R8vGfUXS22Qp6JJ9irnECr8gY2IZV1lRDEUgCrEc564=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MWyj3HgkOJeWvNM0ij8hdTObwP/O1IlEkoKUiNjmmhG9EfBIDd4I8oHr+qS6fwFgr
	 ojTExZT1+gYHVw42iaqpt7BoPQ4sw7sxLoEvc7YPVLJTRa4aqIRgbVDKFmkzimZbuH
	 135nwM8+r24V9n7LtldSSFIhvQdiWOqQWI7Z3WLngmskf7sPhcK6z0SfbUz+AkjKYq
	 WkGWeq1bW/pM41O1mV1fLWXMsqHd3/RjEKvB3KXwTaOWgIAFJepENiS3UyKj8n0zVy
	 IJuBEMz3D6wKV9AFtljCHyVElHpMtfn5Fxg4qvB91wgL+qc+r9S+wZ4yJ2IqLBbCVT
	 Uqa4wTUo4p7bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42C9E40A52;
	Wed, 11 Nov 2026 23:13:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F29F42FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E186E40B52
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSfXHXSNpo2o for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15D2D40B0B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=z6lt22Sl
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15D2D40B0B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438789; bh=R8vGfUXS22Qp6JJ9irnECr8gY2IZV1lRDEUgCrEc564=;
 b=z6lt22Sl82clv2PvhpWzpn+qsCVrG7QhPJgdfaX2vxHoCxqVPGYDzJOLtYlXdHto2/5rYrK2w
 Q+WUVIVuPfKr+nEMr4c4FDb6gjJKNawUm9pSA++o7B7jiVqRqd8kElRda3/1PUxX8WeG0YmwtJ/
 eXyIZETVgaMaFsnoLvb+YdbftaakZeLyC1pZIZGxAAJtPHrd9kVNEGasZN2KHf0rWeqLKmqqPkq
 rCP7/GcLj2HLqXPGjieetUnbQtuiaCL9RM+st9n1t1yiyk1dtBKrTrdM0NeL2aAFLPXaWXpQJ1x
 tWI5u8xzQYCD9XGuRoenRJdFyRhheptCganoTrEdlZUA==
X-Forward-Email-ID: 6af4f682f53292d6859f339f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 3/8] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider
 encoding
Date: Wed, 11 Nov 2026 23:12:44 +0000
Message-ID: <20261111231251.160051-4-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ACLK_BUS_ROOT divider field stores the divisor minus one. Subtract
one when writing the field so the clock uses the intended divisor.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
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
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 73bc92027649..5e9b6a1e62e1 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1927,7 +1927,7 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 	rk_clrsetreg(&priv->cru->clksel_con[38],
 		     ACLK_BUS_ROOT_SEL_MASK |
 		     ACLK_BUS_ROOT_DIV_MASK,
-		     div << ACLK_BUS_ROOT_DIV_SHIFT);
+		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
 
 	if (priv->cpll_hz != CPLL_HZ) {
 		ret = rockchip_pll_set_rate(&rk3588_pll_clks[CPLL], priv->cru,
-- 
2.56.1

