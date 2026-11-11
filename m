Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DD606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P9g/c2XY;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TQAEFCTT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C2340B81;
	Wed, 11 Nov 2026 22:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOotOMP3NZmF; Wed, 11 Nov 2026 22:28:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B7DE40B25
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436137;
	b=i52t4cL80XIlNFBVFoJAX7rcCqYUR1TWT1tkoSkHerlTbMyXn7tzxMWH2m8t/lMVfMah
	 Wz/ogCa6qiMI1OK9HCaRA4KYmU2zC4GGVMsTqHNuRnACoj0+m5+2dZWw3jmXz6rf11jFh
	 tDrXXuMscPyftmnqeakpM93Ikn4m5HnaWbw6xkrwLkme7XhznrYBNd1bq9ewfZc3pRjWT
	 s2WbxkgN9S9cbJ2NY7OFITFqFHN7/HxuDUEVbDmOgny4QnQ7miMq5WS2RIYQpfe3oDByR
	 PG4OSQEQopUewwq0ZI/HKSagpV/+72z9MotIg+24ZcMLTULvOJGzDOeVz0m7JPHCcfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436137;
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
	bh=74MBjTlCG3Iep7+YaYcYY6Y4HGwbwKSU9p11LymReNs=;
	b=SHAWyh85ugHTmr80ItBRaxPd/ZoeP9IFb7C+6iAAFpoS0rM26YJG84A+r3erPTugaxl7
	 Jj4+ACkPcNwq2whaALpRdNdT2RQ025cxBmmE59TS7pZRGB88QFzs3jOHr+h5+NbK9Ds5g
	 NYuWa9biTmNBwPYAqtDqRzRj52zOt0zQa/A54/xrcZfQN5zS5rrw9zC4GpYDTdYcVJSo8
	 YajkP/RMR95q5MfPcHp7powSu/VdNc4JVOobZWeHZWcFcizbgTgC6Q3A/lRuPZiwFMNCp
	 8cxLgb0pmlmhZF69QaEFV7yEOf2G9ksxHlHrcLmdvTRGbIVCNga3rdv0k/OHlz0HrFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TQAEFCTT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436137;
	bh=74MBjTlCG3Iep7+YaYcYY6Y4HGwbwKSU9p11LymReNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P9g/c2XYvvQjBkC7zQff/LYPkllCWkw5r37ByiCIV40c7+yHS/qnFz0cLqCQrt2Dc
	 YUcGloh7j8E5IpFZ+5wg03bdG1dX4R3iNsg2+4nvvk3SUlsC1oSemlIgIQBZTkI1lL
	 k9vYWQ9PNZiAoGLLsOs2fkwsK3MYhc4c7J2sDquf9EcNWiVy1BaPL0x81aLKFZr7zO
	 mR1qThSIH+rA28EqYfUbkd3ZgLNL2JqfgAA9iFoS2hmmJkBMv4R3rloEN+JyXfDayK
	 omfdhx7MfT7P5z70oO3Uihg9EIEB3SqXyGkoPoVaEhOm/UEjL5NIEIU+0b56/JdSSC
	 jvbjBuSNOzkcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B7DE40B25;
	Wed, 11 Nov 2026 22:28:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C8BCEC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C7FB40B13
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glXzKq4NzY8z for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B564E40AE6
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
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TQAEFCTT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B564E40AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436133; bh=74MBjTlCG3Iep7+YaYcYY6Y4HGwbwKSU9p11LymReNs=;
 b=TQAEFCTTO3J3gF2rOlGl9sxeJ9kVY4wuxPoyJfGroWJUutlb/Z8alqr8GYFrpRlfAYr9DXTxo
 nYQeDt1OlpPyZ/sp/D+sQrl6W645fI4+yridAJdAs/VEJNx5Irmu5qovjkotbGwaA8QLrIgqWLo
 vnYnnunrsHuzFie+8BiuAuyMyaKphmWdWUg2MAHX+q0/Bi8F2Hiz6UJru6XOsSJnbBGl7vrFZFD
 BaJqDEQ+EFE1fNXxJ35nsB5kjmNc6UTCj6NkXm0s9Ip6XJlxl23QjgBRA6ufjyPqds2GGcafSe0
 ukJZMI/j73GT7r8Oym04CGOTo2wdadv0CU8hEVGnkoxg==
X-Forward-Email-ID: 6af4ec1e6e1792a74d36a4b0
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
Subject: [PATCH v3 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
Date: Wed, 11 Nov 2026 22:28:28 +0000
Message-ID: <20261111222834.157842-3-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use 64-bit arithmetic for f_frac << 24 to prevent truncation before
division when automatically configuring fractional PLLs.

This closely matches the vendor kernel implementation.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- New patch
---
 drivers/clk/rockchip/clk_pll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 74b7ff5faa03..5cb0e954ba4a 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -114,7 +114,7 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
 	/* FIXME set postdiv1/2 always 1*/
 	u32 foutvco = fout_hz;
-	ulong fin_64, frac_64;
+	u64 fin_64, frac_64;
 	u32 f_frac, postdiv1, postdiv2;
 	ulong clk_gcd = 0;
 
@@ -156,10 +156,10 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 
 		f_frac = (foutvco % MHZ);
 		fin_64 = fin_hz;
-		fin_64 = fin_64 / rate_table->refdiv;
-		frac_64 = f_frac << 24;
-		frac_64 = frac_64 / fin_64;
-		rate_table->frac = frac_64;
+		do_div(fin_64, (u64)rate_table->refdiv);
+		frac_64 = (u64)f_frac << 24;
+		do_div(frac_64, fin_64);
+		rate_table->frac = (u32)frac_64;
 		if (rate_table->frac > 0)
 			rate_table->dsmpd = 0;
 		debug("frac = %x\n", rate_table->frac);
-- 
2.56.1

