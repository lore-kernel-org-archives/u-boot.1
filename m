Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10935606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TnOXbUTU;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=u5wkQLB9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E1240632;
	Sun, 15 Nov 2026 19:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YkQEIV-kyEnI; Sun, 15 Nov 2026 19:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E8974061F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772581;
	b=QKWwD/oAdcLpZKOh5mjspnvqv246zyUnXvztK9Ndv/uy4pVZO8gER2ZjQc1++R5xjiRt
	 ZZ0nL+fS9LWW+59KReOzyrfRLxH5OY0kENQqHPZVIhXGqMsWyMgubpemIrvSBDLXLbT/T
	 z1BI4iUrKrHRaVNfKuyGaiPWG0+yiYhgmDjnjJ9dKs0cm0+LDtpb+k/vgsR4f03aQLRf8
	 jJiwRPCESt3q+5j09g3mkJMPXHkfW2Xy3oi8ZhcCGUu6VuIzKiWx5qqwztwcPC7poRG9/
	 hOCNhoB/7oA39hd2LtYH5ulwkK/Q6gEJtgXpQICaot8I37kUa0uIuzHG3d8hB0n4czg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772581;
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
	bh=osWfFaJWMzA1zcibownN42fBV8WNi/a02T/2+QU5iI0=;
	b=A55JmSlUPbBhODvy84M3RCmzLYWWcf4Z7nridRZThnQqxUAYXo44UtAbTVX1K6BKF86K
	 DUNjUQnuOuHeDZZIbC4gOYnmBHj7okG6zYlic6vLkYoiCYLGeghKwbo1nfuQLwsU9PHl9
	 oTCKUrSFjihmcOymkNRJDRAAB3jb2JOO75BlD0HsVG09L4fWSzz5j0I6AYTE8nGcXGiJB
	 gHJwk/jB3VMPFUzO13JTcCd/9BVcgbOFuA5TqTfNYPej8METTmyty+7Iw0yNi9gdhUhiG
	 PY1oRqOZAogxplrczYvjTtDXLZ7D4i2DKmYLT0LPdoLuE9L8kW3jLgcDXOmA83Mag3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772581;
	bh=osWfFaJWMzA1zcibownN42fBV8WNi/a02T/2+QU5iI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnOXbUTUJ4MZFhltXP1k1zeAnOGBwwkuD/H/sjD2l/wZ2hmY0pXfQfO6qF7Ep+I7Y
	 L43L+fX0hfQl19kvAphPk4UXmUdrjh/VKe4ismozSffGL1FFF4PK2BPJHyF6VjQECE
	 JAAJIsHebqDDxZm0GZ1zQkglY8nmhdF2s85L+6gHYakoO44ZNZbO/fJB0NYHICuNzZ
	 3cYDYbrAj5Ci5S3FAEi3IFtNxi80mUFXFRIuMQklBQZZWbzxyzenhftwojGCmA1EUp
	 7BIeriLB5HmJ4iSAIClr6OqZ2WTMzLYBrCVtzH4IBhuOTfKdKmSJQGfo/jOd1e3RD4
	 Rx0qv09DZxwmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E8974061F;
	Sun, 15 Nov 2026 19:56:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7849CD7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E6F76067A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94A-tUDERIQE for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7F5C6061A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=u5wkQLB9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7F5C6061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772577; bh=osWfFaJWMzA1zcibownN42fBV8WNi/a02T/2+QU5iI0=;
 b=u5wkQLB9JRQL3qxytVypwuWddOSnxXCk4RMrJfto/2CLYmIOQ4fEzIdzSBJGi5UANRyJd5icR
 N6qWEALmUnYRiCW7ri1z5fZn10Wh8G1R2+1x961mgdV2/lkrRlFE5zw4hNdVuSn5O5h8AaVSjha
 5i8yelF8ouLBdaV/GK95urMJdETqRfJVzMC35P36O6PEtphZgoM0lYnlFvpi7R0/cPRuC93Rp/v
 Akd8OA1rmO56eNNFwj56AoUlY37UPhICW3yFWCp4tYsHoECdn+lo9mI6YGotSsC9xREOoXkr9Gx
 3CM4N4yA7obXRs08iLlaQPLCM5/tazTRGg9yVbH7KTGA==
X-Forward-Email-ID: 6afa0e5d2aaf531b6d7404e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
Date: Sun, 15 Nov 2026 19:55:54 +0000
Message-ID: <20261115195600.119868-3-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Requesting a PLL fractional rate missing from the pll table, e.g.
786432000 hz, may result in use of wrong fractional parameter.

With extra debug logging something like following could be printed:

  frac div,fin_hz = 24000000,fout_hz = 786432000
  frac get postdiv1 = 1,  postdiv2 = 2, foutvco = 1572864000
  frac get refdiv = 2,  fbdiv = 131
  f_frac = d2f00
  fin_64 = b71b00
  frac_64 = 0
  frac = 0

Use u64 arithmetic for fractional parameter calculation to prevent
truncation when automatically configuring fractional PLLs. With the
typical use of a 24 MHz oscillator, u32 arithmetic is enough for the
denominator value.

After this following values would be used for the 786432000 hz rate:

  f_frac = d2f00
  frac_64 = d2f00000000 (before do_div)
  frac_64 = 126e97 (after do_div)
  frac = 126e97

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Drop uneccacery type casting
- Update commit message
Changes in v3:
- No change
Changes in v2:
- New patch
---
 drivers/clk/rockchip/clk_pll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 74b7ff5faa03..ed825ac19c52 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -114,7 +114,7 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
 	/* FIXME set postdiv1/2 always 1*/
 	u32 foutvco = fout_hz;
-	ulong fin_64, frac_64;
+	u64 frac_64;
 	u32 f_frac, postdiv1, postdiv2;
 	ulong clk_gcd = 0;
 
@@ -155,10 +155,8 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 		rate_table->frac = 0;
 
 		f_frac = (foutvco % MHZ);
-		fin_64 = fin_hz;
-		fin_64 = fin_64 / rate_table->refdiv;
-		frac_64 = f_frac << 24;
-		frac_64 = frac_64 / fin_64;
+		frac_64 = (u64)f_frac << 24;
+		do_div(frac_64, fin_hz / rate_table->refdiv);
 		rate_table->frac = frac_64;
 		if (rate_table->frac > 0)
 			rate_table->dsmpd = 0;
-- 
2.56.1

