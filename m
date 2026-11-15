Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5569606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q9Vy/6o+;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Q+RMutg8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE00880DB9;
	Sun, 15 Nov 2026 19:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhy-8uVtmGqD; Sun, 15 Nov 2026 19:56:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 220C780DD2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772585;
	b=P0cYJrN/L8+xcESHM1MdFEHt8YYj1wGvKTc8kd64Hy8FL5d9T/n/rJdFkdnBES2avgQv
	 dbDJ9WRUOrdPYQQjFc9HzSdEA6rnNXPG2P7sFzGebS559YhjWPsdDyG3R6uv7mhTdV23K
	 8Hk4pmcWklGmu4XRLnJpP/i22vsK+N6tQZyCLudICWSBTafWl+MfcczSWEHkUTN2gNEv+
	 EcM4O0e9TaGqeft7riy4b2yxUPgsOdRVbTrOLunV7U6NH+gKssp8iyGOyXWc7T37iICUv
	 43xPujG9WUXos2N31pCfN94+v5Qkt8SJRI71v6z8K2IiartAx+6ptEzKCw7zR+qvnQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772585;
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
	bh=K3oREQUMojPwc1ggBjDWjZi2RMkYpEnu39Gf+zaIrZc=;
	b=EsFkljhJrq8EZUhHDHOVS8CazITPmixqfq/64rQmvElSCWRVAgpCJUp1WtEPTBSCe9v0
	 MQ34+YBE/ea9YBLPZaGB1aE7u+cC2q4WblbNK9jDr2coGFPwMJn16Xwvqr00y47FXMtHu
	 U0MhoMONYPPuLnedor7ZfCDUaf4r1FmGz+3YaoAap+9n/jE6v/RG23kJQ6wm9xg7VS8UP
	 qyEDYTLFoDXCpheakZVzTijVxEWMksitEt9jvifApN0gH4Mi3v144aWgb/r0og20Z2p7t
	 ok5ThuPZ7Q12JGPCroy24iKde6JF4W9r8POUF9MjVvN5udEQlpcGQghWWr0zEQGR2uA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772585;
	bh=K3oREQUMojPwc1ggBjDWjZi2RMkYpEnu39Gf+zaIrZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9Vy/6o+KDCjfQlXA2kZYNlljueIO9cc2vj5z9IgCdp0+9uPAf4GyJQv/yZCN9rzE
	 /VDsELPlc6IkwXZkBhLxXtxr91oGaK4AF7hxtmn9xSAGFgc/GDYE5/7pPuxqqEdCUQ
	 rHzx4QTY9z9jlrW0e3S3DuRFynmqDdGuZLu/t/HCmdErELsG9ZpdmXcQ5tQvok6L88
	 EyaKWMJ67zCqu22f5ysh2vGiDZodu3QbrIsDue/09vQQ4EYdJvmIiJ9rOEg0Yf0qnY
	 QtQ/HKhOSP6ckztiWXm6LCbYeeZMptYerTfl5XiqGDrmjHOfBQ3qAE20OHbBeVY7cB
	 TOSZWkvdIB7eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 220C780DD2;
	Sun, 15 Nov 2026 19:56:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF9C51A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 963A66069C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayiBhaTfTP0x for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FA5B6061A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Q+RMutg8
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FA5B6061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772581; bh=K3oREQUMojPwc1ggBjDWjZi2RMkYpEnu39Gf+zaIrZc=;
 b=Q+RMutg8OL3t+3mbcfL08i4ss7ETZ7v+yjw7MfLNGiL0t/AJpthc7tRo9gnf9EwYp5yoPbcJA
 Z8VKZOgt12hjfY07n2DgLl9xCp6freRjJG5wNebGg32/sCvuOMZLoenbGv0BE1D2GI66dcPfadP
 cF8nCuNJYl9hWRZxAiJ7AtJOadZByAJHipYVSoae5xdruoJ2Hz55yT7flHT8xMd2sD75qw2xEA/
 HZ84fNlt2QUD2BZGlzeQh6lD3FI5f5ifTT4YmqUCQaOXCHX1UFpMrj97zWtxvhrpIj70RCNFk7G
 6rP7VVcl7o78BUOyFMBLo7WgW2NktDh9oiVv4jSscCiA==
X-Forward-Email-ID: 6afa0e632aaf531b6d74051b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v4 4/6] clk: rockchip: pll: Always write the k parameter
Date: Sun, 15 Nov 2026 19:55:56 +0000
Message-ID: <20261115195600.119868-5-jonas@kwiboo.se>
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
Changes in v4:
- No change
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
index 1256396aa24e..b18b2ad342e3 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -488,11 +488,9 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
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

