Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C5CA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EBFE405FF;
	Sun,  4 Oct 2026 21:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrt9tRj_Hx9z; Sun,  4 Oct 2026 21:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BAD45406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791148447;
	b=nVx8z5mLDJMCwL/pZzoRwisObWOM95scY7uDjQ5jC2xsNow9RsCYoCHFfvtKcSaqv78d
	 KfP+a5l4vCfIOkkwGurWzaBfdH4BfkwuT/VgmCvh2Y2/PGzdvR954m7yq4aSeXJW9OsxL
	 w/V+mtiFj/a1XqV9F9D4JZvnh8Uwd+LFAqqSB7+Uciaec3XcB4sz8rYHgjXt5TYC73tW8
	 bMGLfNLft2VhAy5B3vt7I2oq+hBV+YWAqLDhHyOr1hAF847n+/jyUkS/rQKp2kngHgsVk
	 yAA91BvkA13C4vVV1yt91FHa/Rt0uZzsrqaGFDacLM44LQhD0uPLIvBoT23tChASU9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791148447;
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
	bh=JNIFREq4WKLAYRzCydh92K4R9UrdhFbobHwwvfbvIIo=;
	b=sjjpgBdEVTvWH6Z+TqZxWuvH0LtLoWDZJ6kXca9aDFyd9PzM1evAoRwZxX3JIi1n5jkD
	 BMrQMoqPErX9GDyeLAY1DKxg4GtWyHRqP4cjkmaCcTXUQuxfrhflHvzRSUGqkgnNRLKcj
	 1BXan3HGDQBJtzeJDR/n44j1esHMgKMDFFzYo+vhfCikhHRYv6BZXMWJjHC+DXZs1kT8I
	 6ujpdWM2M8w82Nge1YnHMAzxW77FU8EC2Mr1G0MbQoFeBd49t4v0feys/XOsG6FDaTj9W
	 Wqu0bAVsYCfAVwkP+kvDZoMpRdWguX0uRMH010SBUW91PmjaY53h5unOurXvxByuaPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791148447;
	bh=JNIFREq4WKLAYRzCydh92K4R9UrdhFbobHwwvfbvIIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KD0Cd+jw3bUWaNpEhh60J/fhsGtFwyFSKcMLqqNw+BezCEGJe/LLzEzvPBy7j09wr
	 bkyqV/H5659NeS7fylQi6RvLCa7hq9uhPqePp5U63dEFzpmAQUHfSNTiz2MfI29E3e
	 vG+Wci/d/nSOVEQomu3qzL8ul4dMnTF/0f/XXTai7M8KuPoQzpyH7vc4F3hjTQO0AF
	 oeFsIgxnXBWIhvPZPNa9YbTauP6bfwXwisV1lkj8JHGi34nFhU7RRLkjwLfNrDTW1z
	 LWff5bREHPZ4Debm3+xLEARIwkh/ixZo9IeyTr0KQq04TuU2Y7WN2jl2Cx1PeNVwnf
	 t9W/ytGOXW+EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAD45406E6;
	Sun,  4 Oct 2026 21:14:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E24312E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D42FC40049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeUnNrEdbrdQ for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2ADF640004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791148445;
 b=UWmL7A8f4sdoXxdJDwGosxiw3Pye2MMZrVD6Uech0mWiI5VuU/woYYB/a+J0pA4COUHG
 G0a+ZvpOxw89QNaDqVvJbP+bIK+iCccQjkwBz5PsAExCTE/Ga8CuK4afZTuS5W68Morde
 71lzaSAqLwVAMBBNetjVWJV+CKMINheO5yBAIQVe8na/GNHc3SthSmWs4es5J+Cgk1XMe
 7kUzosPWkvQc7zvXAjmcWFJfmdc0QpOlKMogUy59UyCOlhxbvPI8Glk+8WWUdAREdVWzH
 QM2UpetMBwR2sjZUEDLoNS0AQkIqhvo9Pz5v+w6sdUpsV6OL6BKVQWIznOvrKlJrAuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791148445;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=JNIFREq4WKLAYRzCydh92K4R9UrdhFbobHwwvfbvIIo=;
 b=shzK3rSC3D25skoNyI0iguapa5UztUVVHQEPi97v0oV8pZZ4GjORPAiytrUap36PHbcQ
 WmZU0/HCXubUr64iEvyCpw64cGCeg92GgU4rz1nAuv9gEpnyGoopXnXVUH4TtXUwyE7CP
 jiddIMoErp7vKSNUBjkJVgG56OvN3ZpM1fj1yHpIyA22VO51fy0OmDoTOgRRrfwBeL0CR
 tUdMHqSOKkP4gs7gnXXlYkFsbPikHm4p5MYusWqCUyoiHm3K7IqxyKN20gNSaWqi4TDDp
 34GS5UrZsWYTWX52TsRcKja7zsjALbzQstdaBUN08lgZu0GM9RWFSyXn0WmqZe5tg2w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=0vLZefy6; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=0vLZefy6
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2ADF640004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791148443; bh=JNIFREq4WKLAYRzCydh92K4R9UrdhFbobHwwvfbvIIo=;
 b=0vLZefy6i5VtSG8c5Xh/bsM5D6hmUSolEn7NhYVDVEDY6lWPc7DM9O6udsqJ1QFSNiIGFKvrW
 HNABSLfOTVXbJIhff3wMOYV69nq42Z5qeNKLPiJFe50Iq9uISZSkMRlROAGOt54IEbPYpBFMYVN
 AvzR0xFcq+zPE59+HOjSAzsha15ReexcT5lH3RvDXuGL+uCxJCGuIYNIlOtMoT/0xKlDBZANBSd
 Ai8d5+/7Mc2usue0+kLJg2xS1kUrsNIWvSqLeOYXiy5we0c2NN0LTnrXfZlIZ3kLFCpJywsd6HS
 u4UWuATZfPhsX+lvw8amRNGIOw7SopdsXt5q0AaKHukQ==
X-Forward-Email-ID: 6ac2c194341e63db0e52ac64
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rng: rockchip_rng: Fix wrong TRNG version error message
Date: Sun,  4 Oct 2026 21:13:47 +0000
Message-ID: <20261004211349.62883-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004211349.62883-1-jonas@kwiboo.se>
References: <20261004211349.62883-1-jonas@kwiboo.se>
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

The error message for unexpected TRNG version print out the reg offset
instead of the expected reg value.

Use the TRNG_v1_VERSION_CODE constant to correct the error message, also
add the missing new line at end of the message.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/rng/rockchip_rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 8cf750e043cf..178a76c09347 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -200,8 +200,8 @@ static int rk_trngv1_init(struct udevice *dev)
 
 	version = trng_read(pdata, TRNG_V1_VERSION);
 	if (version != TRNG_v1_VERSION_CODE) {
-		printf("wrong trng version, expected = %08x, actual = %08x",
-		       TRNG_V1_VERSION, version);
+		printf("wrong trng version, expected = %08x, actual = %08x\n",
+		       TRNG_v1_VERSION_CODE, version);
 		return -EFAULT;
 	}
 
-- 
2.55.0

