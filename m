Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A0606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pzft1O9a;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=r7MaR1CX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493F481461;
	Wed, 11 Nov 2026 22:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiNFkP-lRXBj; Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B7CF811DA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436142;
	b=b+AJVPO/7uk7o4In4XkC3TaysyrqSx6JMZP2Grdc+SCeWOflihF8fYlmbx8zuFsHkQWL
	 n9p5oQ18F/+RLbmH8CVZvonS7+uJZhyyXVGbmvhvmT3tOIIgawHUDeI97SkJ0zXAP/DWY
	 MIcSKOgcZsIPBJnYGeChxerao3QN4GAXQS+VZH74ZK135slfEHvr3hqmErK2IuCe6kfOA
	 uiTATv/p/hU0qm+OsJRCw7T34SNu7TqcfwHuF4+9Hek/qPFMgqcQvCFb5HJT19Ucm7Uwq
	 /qhraVJ9IYygm2YtT4eTcDZ91MtML789irr385S/oKqC7iTqyGmz3iGBQ/3Lmf5PFSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436142;
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
	bh=/lhcjs2V7QdpG43eTNYBucBYo0u7w2mJhdChKladnNw=;
	b=QaUx2HEE9y25R4qBTpMFXz/sASQtt93320c0Vg3dy3hnsasmTOU8qw5A8tjYXB57reK0
	 +HLZkxNXXgm0tj/ZFH04vKSfaI+IygsO+SW6TH4UFWtrEIiuE3tj+gjqYVJpScXXItGmD
	 Zxm/qsd7xPq9GidNkJlyA7oCgwJPVBF1M5kC8d8k7557rzMsowtldDjJ0UbZhx2fx/DpB
	 mFIG/2PR/LnpkrJUIgLUIv1PSs7A3x+g+5J6R8FKnD5m1w3IyRC7mxs7dt0EpP/1itZVf
	 Up5M45VzVB8zqjQVAbtG91aICIYKyvQR2rok5m0xULj52yQvDqYun82A/Lbm9MdsZkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436142;
	bh=/lhcjs2V7QdpG43eTNYBucBYo0u7w2mJhdChKladnNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pzft1O9ayPQB2M28dHwuh36Nxweel/jKB1GDM9wrscbjpMG1MhoI6zPt64EkxWQul
	 kfvNUvI4vmO0SX3XdRbWPrNSyZ7KsDL2S+ZeuLYf0eo/RNYseKFhfF6fGlsY7CloRZ
	 26Nrg7YAcP41wMMHSdqhD2xb3RLaZQs2Sz+VttEkEacBFFpI1x4rpupfFVEqG5awNG
	 SbhLRyLT8QT0KaIlg4IC/C0zMC3homgRAyAwgGRS3EVQHQrbwRgo7pspNVyUQKwZNb
	 7F64kX1Iv5FU50azyBUod8h6l9mqoqeIvKqhOpd/kx+RdjoHIh8GpVW5Ww/rjnKfGs
	 BnsJERV2AHEeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B7CF811DA;
	Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CEDF2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20E5240B25
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HW2JiB9eG-7E for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:28:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66D9E40C78
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
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=r7MaR1CX
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66D9E40C78
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436138; bh=/lhcjs2V7QdpG43eTNYBucBYo0u7w2mJhdChKladnNw=;
 b=r7MaR1CXHevGF+ykocXBFGOtKNrVCCq5aU/2XUAEDO3M3qS2gulvVrbDiXPxHNX5l97nZ0S/5
 96rHHaSIK4Vi146bx9IBFs2y5OV2zdeSb8K2ri9CvGbmJHC6T0EscUynPbSChXcl2KGY/QvRIck
 slHVltVsWhO1ZECmNCYfhkNLWgJ/PZIvZ90NLv9q6gYVNlzA4vS4AEcjUoouFqcUF5kHEcBFbEX
 Bm7LDgo1WDXX7uc5jb/8kCk8hn8PleiySUqwV1bnPwwF5qCq6xFTGygiKQzL+J2LgXdsarDFhbU
 jwK0f092wMUpJdM1J1fshS6BWKm89UGVUWQpM0uMjzeg==
X-Forward-Email-ID: 6af4ec256e1792a74d36a505
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 4/6] clk: rockchip: pll: Always write the k parameter
Date: Wed, 11 Nov 2026 22:28:30 +0000
Message-ID: <20261111222834.157842-5-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The k parameter supplies the fractional part of an rk3588-style PLL
rate. When changing from a fractional rate to an integer rate, the
k value is left unchanged, leaving the old fractional part active.

Always write k to the register, including zero, so integer rates clear
any prior fractional part. This also matches how Linux configures these
PLLs.

Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Update commit message
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 5de930e41dce..6664fe3921b8 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -490,11 +490,9 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		     RK3588_PLLCON1_S_MASK),
 		     (rate->p << RK3588_PLLCON1_P_SHIFT |
 		     rate->s << RK3588_PLLCON1_S_SHIFT));
-	if (rate->k) {
-		rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
-			     RK3588_PLLCON2_K_MASK,
-			     rate->k << RK3588_PLLCON2_K_SHIFT);
-	}
+	rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
+		     RK3588_PLLCON2_K_MASK,
+		     rate->k << RK3588_PLLCON2_K_SHIFT);
 	/* Power up */
 	rk_clrreg(base + pll->con_offset + RK3588_PLLCON(1),
 		  RK3588_PLLCON1_PWRDOWN);
-- 
2.56.1

