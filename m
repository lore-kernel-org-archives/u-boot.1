Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB8606A32A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fdkc0YYz;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RZ6NT1Kr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 214DF40AEF;
	Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhyxAsRzIDjY; Wed, 11 Nov 2026 22:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 534A740A71
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436313;
	b=ObMPUffoGITcexN8e/bZ4OELkZv8T+1TXpHFLfmMd0d9OZfrR7h34em4FsiX9QKSYwyb
	 bL+vwnbt8LZ199XgaxpgTYTmSi656Z0iWqFeN0SQO9kvtPFGlUe4lJaCmHh2+EM+I3Dby
	 HfB34UZilPHiE2VY/TOcFVaxzxSdgfnWBFLL3J4KFkXfmt3CaMbNdf6GH9r7OTc7haPDL
	 4xVbLp0XXmXOxxgeaLKkIEk1KjJ6cx8whLA1FR4h28nNvKuPXUj6nN3QtSPdgkKVia/j2
	 EGiF6mLLuDUdyDVAERBIxa6TEhHYILkzollgri394MXb9Pd5BNH6Vb/R/caSxDQ/glw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436313;
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
	bh=E15bdiz8Aalvj2ZGv6s9umdu+rSzTMicBkf8Yun73v0=;
	b=jvkOXSysF508YzOuZQcZ6PeWWdpG3GGnzOTqAzQnvbIohGofbyfsjRoYIybusPoPMtkI
	 cTP2C21I5pEjikb6YwfuYAYD7F6IbDjDUp9ghZn7yYSBpGrCFsg7p77aHRZ71X00JCnzt
	 umD2X+Sr166aDjaWC1H3iK5dOvkXlvPaOoIN301XuSHWfdA5TQTeVsZgUFQb0TZITaikT
	 lIlnUX/b2WOq2XHQyGW/Lq6fnZh5Gz7pTJHrFTsI26WwGVzu5v5bhHZUHf1+mraGJprTn
	 DdSWCE990hohsHSfBO9eIlNsZ1W4ytGt+Mc4DH0l3aax6Ihy0+aCGGQr60ak80Ycf7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RZ6NT1Kr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436313;
	bh=E15bdiz8Aalvj2ZGv6s9umdu+rSzTMicBkf8Yun73v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fdkc0YYzTCkjGPArYlzXC4Xuzjr2XLpTdVUqL7hop17B6d1B7RljgrXMdDj8TTUTI
	 j/har+pejfm+swXUxd4UitcKTZhXWpZ2sWdtvguZzQW/Vp2xvhq/WqvY7l0uszzspx
	 0ZE9mVgh2ziUnujMwpN9rKKDATvRlQjADqy+YuirFnhx+SNp+GD88xNiQKTT6AxQm3
	 ThynKmlgtEbyGDYhn+eZMFG47fhZ+KY8vUq43wCfyDIPxw3+oNjYIykbVg6GZeEXl8
	 YDdLJoACn4u1i4C/i18R51UqfzePbFWKYGeo+8RgmbjgY9kU4VqfGOb5Ovg8kpUNMj
	 +KrCLkumOg5xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 534A740A71;
	Wed, 11 Nov 2026 22:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59EC2EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 408BF40A71
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbIb4mF1JSK7 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9C9440990
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RZ6NT1Kr
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9C9440990
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436310; bh=E15bdiz8Aalvj2ZGv6s9umdu+rSzTMicBkf8Yun73v0=;
 b=RZ6NT1Kr1K2Lbkd8qzJ13u8Oho/CCIIwTcdOi3SEw2KrgSpL0x689IMk8icN6zdfCt3ViclHZ
 J3qhWMTyseQUNXxz5s9Mk/HG07pOLxM0myr+dV/rlZ42+xiJSitgQNs5LMU6V0eQgez9lGRq+vs
 sEvchcoNtVlMPI9oLlsWMAl1Ptgg4YTIipetIKoU8mHfIjaEH25/bZakuUn6uC0137BWtBe0h4w
 cRRnOIQvkMbUQs7qgzzH1n8BbywfTTpuJvaA7XbQ29o8QTFQodw6NRPdLySJhHXcFcOBsY4gxmx
 fToHaKwoDOYIJkOZ3xfRZhoBweG5SWE56kux/oJaZ57w==
X-Forward-Email-ID: 6af4ecd5eab6e8cc0ce8c064
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 1/3] clk: rockchip: rk3528: Return correct rate for CLK_PWMx
Date: Wed, 11 Nov 2026 22:31:39 +0000
Message-ID: <20261111223142.158361-2-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PWM clock getter overwrites the 100 MHz rate with the oscillator
rate because the 50 MHz parent test starts a separate if-else statement.

Change to use else-if so the getter returns 100 MHz when the 100 MHz
parent is selected.

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
index fd99b8ba5ce2..0ac6fc68cd61 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -770,7 +770,7 @@ static ulong rk3528_pwm_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 	sel = (con & mask) >> shift;
 	if (sel == CLK_PWM0_SEL_CLK_MATRIX_100M_SRC)
 		rate = 100 * MHz;
-	if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
+	else if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
 		rate = 50 * MHz;
 	else
 		rate = OSC_HZ;
-- 
2.56.1

