Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE847CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B508C80DA6;
	Sun, 11 Oct 2026 22:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLPtcj8tE6GW; Sun, 11 Oct 2026 22:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11E3C80D98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757916;
	b=g+J05eYUw8dZ+ZemN6XOtobunfGVd4emKPGmZ5S4Mf8+wyENtJCcT1wTTK+37QRxwpp9
	 +HyAGbq+nTYy/aLQ97yE+zabHhzaF2s2CMSLCUQ1lUkQQQXYUTlqcWazbp/Ai/5AMvP18
	 Mr5DZ+0TNzXXTbaZNFlyOU6vqzuuYIJPAyysE4v3H/HqrMFhrYMT2IA51lWxWfYPm3r66
	 Gkuf61EWSmNv1mUaNCopEofIVw5F+usUbjRfNvnLLjx9ZD6FPhFxEHtRkUqMmQ8UwkEhJ
	 7virR47/dOpBz2TeLZSt4nPtewFjZVphLgRKQdEaVSMjELujDJQc5S4BmLK8ofMevUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757916;
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
	bh=TXYh6nQLpR3zyxQzpUAvJga8PXh/RBVOt6p0STZmCso=;
	b=Rs1B5Y/u9DYaIyxLQKMtgcS9aI1lbCreByXafkc7JBbbcTSAx2pmSg9vQSFVyDOnt3fC
	 0gF1+fjskNJNgjCCv2f7FdbEmw+e4sZn/l8PYkeqfuxb1sr50OV/b97v/OEsdVb4erCIj
	 sdL2wkvkljqKwkjltnYKFIae+f/CS/L2129l8QpjqTvEfmcpiU90R/3YQyeeS+1/MDrEm
	 pY5QvXDF6JgRq4WqglgVNr17YcAhOim9tZsYwawF+OeBCwpB1AKcggcH4F+pBUFdfBh4Z
	 ZKo5IZe2L+fsNPx5sa+Q1KQRoQVrz9rHz2uoqSfi+/3m0R1m0mdWJdTnPErSVf8XTFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Tnygqbyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757916;
	bh=TXYh6nQLpR3zyxQzpUAvJga8PXh/RBVOt6p0STZmCso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5gCjpBTLTfq3BXH8hJubBVDf/cxJNdZsbEeIxaG2t97HN5Xym8EPHuydz9Kt8DH7
	 6xLcPpj2kq0PkDGCpY5/5EBgaECvhFVbcdNTFSVdXf5MqgQyaq4elkgeWXbZzVA9gx
	 m+3iRZQDCAye31Ky6YViUNlWaMZQaUEtJJzggJmef7G5Ugrau4i5Xi7XZTR7n4qa9r
	 fl+MhmHkJaZnrvzNJMz2ECnLj1EI0+yGN5h9WenIj9IDixM2Twy3G7kTeOHXphY3Bt
	 XFnAD0Ho4Z4Eg3T4eb4xCGwPSztcQ4IWXIwwDx8oY79bsUqYI0C/4vsWlUBYz851EO
	 b+hAzsusUy/Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11E3C80D98;
	Sun, 11 Oct 2026 22:31:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B5961DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21E1A80E19
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-rvyt362f-a for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A1F380D8C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757913;
 b=FrY0vpswpRtrFdw8OKOMhIoX0vJIQIU/C9s8G58PdEoaMpeyKNVE4pE/+eoEoYjtJV+i
 1rqZOLSsWF4n3aJO7ry1Zhgiirudsgr/YWchmASJzo7yhFR5/0XgTGD3vWyvpqgTjbfrZ
 1dhGd90PXjmCrPBEYMVuk19GDOOyPqOhglWLxdLhOIXjcbPBUN6E2dFQ0zI/yirvpNM6i
 awlQNJnCrXg543uXidaaKOJIwuZmtRoNS1C0JMvj/VonRGRErFjdaKAztY/5CfpLdZBcL
 dPAbO/Ue09aSQ42DgtFHxE2dEOOzLUmDsP8fpA4TQ6EBglMmFlxtOjFjdC3QBDtiLrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757913;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=TXYh6nQLpR3zyxQzpUAvJga8PXh/RBVOt6p0STZmCso=;
 b=G1v9tjY6ZWWjtN3MYRcEOmVeY4Etp55bVj/Vgl0dz23DlQn0W6FZ2W0ILkzh+G0I257f
 Jcelyw89epcKjx8IVsSFmMLc6R+lTl1Wy8bGR2QI4xdG6iio0kG5Lzzl4W7wUSP7Oueoc
 B1jZpv30MQiXqDGJI4OvHvYPVjut3Jvy/BYwgZ/Hmv04zzyyAp11XDrcUFF0Sc+j6fO8C
 DDYY8X5LdFKnjn/UFJfpcNvMdIgwqFUXYfglx56RoUzcFN5KCR828DHjbp9G6JyGM1XAb
 iyjxglex8TX6QVRXD+Cbza2X4XTF4XEFQxrABPmpmriFWU+uGwMZ1Pxfk06cMXYl6+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Tnygqbyt; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Tnygqbyt
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A1F380D8C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757912; bh=TXYh6nQLpR3zyxQzpUAvJga8PXh/RBVOt6p0STZmCso=;
 b=TnygqbytwsxzQpxRjz/ZagIQ6TFHE+aAeZ7lpCY7q1GdVLtiwWr3nOCe3+mmHV9G8CWllxMOy
 Pe7QMXnQ9v8Mn5dsa3YrrmxJz7Dw2WV2OgutU01xQmwc8MvLRKpS6JJCAN/wcokroe5QEbgTUaA
 IJbYE2zitdvfpbvQAPXXMCVBdSnG7AJCxKLVWF2JWwJc4bHFP8CBB2ICgGYhGX42qrZgjc5kera
 XEZdIsBlELs5OKqwMkbbo3stOJB6W1qp4TO95eYhoP1csRLROvcvduUpKssrZn6vc6ffCq/twFj
 8+c6gM7+1gBB7T1ejP3sCqxfP824FESBymyOTFMYdGhQ==
X-Forward-Email-ID: 6acc0e064548822a24c17431
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 15/37] clk: rockchip: rk3588: Remove redundant PLL register
 macros
Date: Sun, 11 Oct 2026 22:28:50 +0000
Message-ID: <20261011222930.1085075-16-jonas@kwiboo.se>
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

Remove the duplicate RK3588_PLL_CON definition and the unused
RK3588_MODE_CON definition. RK3588_MODE_CON0 is used by the driver.

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index afce8a44af3b..c83010e518ee 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -105,9 +105,6 @@ struct pll_rate_table {
 	unsigned int k;
 };
 
-#define RK3588_PLL_CON(x)		((x) * 0x4)
-#define RK3588_MODE_CON			0x280
-
 #define RK3588_PHP_CRU_BASE		0x8000
 #define RK3588_PMU_CRU_BASE		0x30000
 #define RK3588_BIGCORE0_CRU_BASE	0x50000
-- 
2.55.0

