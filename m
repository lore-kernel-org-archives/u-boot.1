Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB4606A329
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jhDFbemX;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=iNIvS/EV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8751380DC2;
	Sun, 15 Nov 2026 19:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTc7zyIJHNf2; Sun, 15 Nov 2026 19:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BEF8180EAD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772591;
	b=Wt0e+vjjOmu8YrcrV+7h/8mf+J5TQJHRkyZLYxefxM9jxtQFfCpGiKTjrkxwwQqQZsBm
	 jf59FGY4g+oMVLUtz2QLDj9Az+CWWWE8J/neQS9ImYlsPtzYxgnQkvxXWhJbVTlBEWFSR
	 oli0U97MIYAUux9Wiebzo7Z128BJIRn5TAnjbc4DaUKi5PjujeZtsqoyMuqi3sMD1d6F1
	 r4XHMPx55sxYaS5PEdQwLABOFBSsgsPpztul+rXXp0TQv2zkcaLCqyfxv1kT4Iu6UKXsk
	 wVd3DFQPirnI1K2UufnwqkU2fqpd/GCk/6Z/ELxsRAuiJTfqvccRy7PYyusT/B+UjHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772591;
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
	bh=b6XN+vbgw3ear/GM1sjohOBMpeeEvrK7bSymGAorgas=;
	b=K6xtrHJ5XFAY1DINS+/gF04BpyFQODl0s9uqUTociLI5oxbaVg3jZ4/YBLDBECc/0GDq
	 QlyiCTs7xXgt9dVZIzVfh1GHcxbefJyXg+BKi2ZKiY5NIJGEKb9VOXztLIJjnuRWi9xpI
	 EKggJDM5ydQ8TRV2adiuk4WtrA9MR3Rplw5tnHHFabwIZoZHR0rqh1/9WYqCIuKAkKEkw
	 D0QnSLfT5BDCFnzXspIILOKInlJEgOmNPw440+HtQn/P1C54d/wWQhQgM5kI/uX9SaC17
	 DT65+2UPtzIjj0/CMkt6xW2yUj4W3mWLWz6GuFvkTshAeb1EloxdcyACvT/+TZaHGiA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772591;
	bh=b6XN+vbgw3ear/GM1sjohOBMpeeEvrK7bSymGAorgas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jhDFbemXreJWPicqyxxoIVoUnVhe/7NcOtlta5sWKGM7HyW4Ng62McCBnE74XmPub
	 4NFLjC6xvtu/SLq2yA7yP6oMmROgJ2dblrwlsAw3chjmjXIAmoKNDWitctjl9Pf5vn
	 5RvG62+Q5eyv0JVl9NGQ9iRvmPmFJtFCfmaf3NuCgxCU+0zwDDfxTqJnZJhTdyKYqI
	 EhocrPUFwUnWWbrTWSlkT0ehcr7XzMDHQDQhkLkfhaQKRIVCyxNXVH2vnezDO+TjCC
	 2pbUV1vqD+k+L87JCjMhceYkNxH9RPyX2WLKMcDoZrvnzSKWPc1u8A+Esm6onfXz2/
	 XQt9QbKynO0Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEF8180EAD;
	Sun, 15 Nov 2026 19:56:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B13181E7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A342460672
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSTNlcI_7o-M for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B26E6061A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=iNIvS/EV
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B26E6061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772588; bh=b6XN+vbgw3ear/GM1sjohOBMpeeEvrK7bSymGAorgas=;
 b=iNIvS/EVoaBK2owAHPTM1F5VPT9/hAdt0H4qB0TgVx37M+AprdymEM0F27u6kmXdafI9RDGys
 7AY/b7pxrn4VmI04JmNrqpP3pGN8V4eW8RdluMGYmdz5bdXSAswN7RR8u67bxEaPvCdsfq33vvU
 WG64zoUGaxbzdEX1/fPjfOqBPcENuT1iiGeQO9xMx6lB/PCVsFJ2p1F0li9h7sBXHwAf2Du4T2J
 ODeKiAbr9yhS6kyTxMKfk0HMssFCZbymOBw21sR8IugRbPE3S3QK+eZzgf2gnLZLpT8vP7dX395
 y6UYjk+1aWBdCoD2UboPuYjeCrV7zZHFAQLRIxHe5caw==
X-Forward-Email-ID: 6afa0e692aaf531b6d740551
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 6/6] clk: rockchip: pll: Limit special rk3588_pll handling
 to RK3588
Date: Sun, 15 Nov 2026 19:55:58 +0000
Message-ID: <20261115195600.119868-7-jonas@kwiboo.se>
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

The rk3588_pll_set_rate() function contains special handling intended
only for PLLs on RK3588 that are also applied to PLLs on RK3576.

This special handling should ideally be moved from the common pll funcs
into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
to limit this special handling to PLLs on RK3588 targets.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
- No change
Changes in v3:
- No change
Changes in v2:
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 43fad9d5956f..dba191abc44d 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -457,7 +457,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	 * When power on or changing PLL setting,
 	 * we must force PLL into slow mode to ensure output stable clock.
 	 */
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
 	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
@@ -465,15 +465,15 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
 	}
-	if (pll_id == 0)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 1)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1)
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     RKCLK_PLL_MODE_SLOW << 6);
-	else if (pll_id == 2)
+	else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2)
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     RKCLK_PLL_MODE_SLOW << 14);
@@ -509,7 +509,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
 	}
-	if (pll_id == 0) {
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -519,7 +519,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 1) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1) {
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -529,7 +529,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 2) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2) {
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     2 << 14);
@@ -547,7 +547,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     0 << RK3588_CORE_L02_DIV_SHIFT);
 	}
 
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0);
 
 	debug("PLL at %p: con0=%x con1= %x con2= %x mode= %x\n",
-- 
2.56.1

