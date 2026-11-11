Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AB606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=geQd5FwT;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=JoVL6A3j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F62140D22;
	Wed, 11 Nov 2026 22:29:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLUWUcYlp-bD; Wed, 11 Nov 2026 22:29:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5F9040D0A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436146;
	b=tY4spmHoMu/erkAO4AwqDRUoYFWpOVwW0Z4xBwCaNoOzWgyHG7UfeRNXvjdaU52CYaRZ
	 Q9H0cGB+LBZginlOYV7ecP4bdOTbgJOkYv5+pAq4dKufS1GndoG7R3d+nSDZNtOe3LTad
	 zjhpk9LtDn3rKPzruca0+27EmPvBs6g19g2jkK9nMhuUVGXcbllKDSp1tWBy+yZPYX7PR
	 cCTm89J57SfEheG6bxL64FBOxcVjsFda2uyvX39a/18zUsm1utouNGjK+657y35/VtIKR
	 y4sdhgroYCH5Ytr1PiGTBwCwHADxszvbeGpso50Efa0IpBPV0dxn8BSMdWClF7vf80A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436146;
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
	bh=tONdxrk+3yBdUzkx2KTsQlwPeD5y13A1L4ouFvYNz3Q=;
	b=SJu9EW8Czt7JCwknm9vccg360mH2JKqWmc/rIyfayC4AmPTH6yhDpEq+UEWydFtUlrBV
	 dCGey/nequP4UHeFoIR0wu5LHZBad1l5HICjlAhcMySTRTSoavRj8i/qNNdnimNu708zU
	 0GyLV1CMI+JOta0GWopOUoxBEzUoXBHOra/zrQBlzrcxCaWulLrpYxRtBaMES46dynzDb
	 oWqXXg3T9lSTA77HP58v+kssu6BPgoVLfd3vbsT/3OkFZuRcrCP3+3o7Shwz860cjTqcP
	 5GT6mgq0TSXkFuD20DdGUFeDxZsSaXhX4LaHw0zCC5nHaMwT3fcUPVRH5bCwchnc7HQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=JoVL6A3j;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436146;
	bh=tONdxrk+3yBdUzkx2KTsQlwPeD5y13A1L4ouFvYNz3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=geQd5FwTsXh9fEX1HZkJbaeLvtzHL4kPXxlftLOyQL9k1pR/EVZdkkeKmTZJb16rj
	 5d6pyNtQoYk1auZs3mdD7NeYiNKeMy8KpuVFf/L3nGQewy70gTs4yKGp+4WYWye3kS
	 CQU/Qweqq//7HNCKJZSi9bgD5zyxpll4yFybON+I5O6N1Djn8PKuBtUDiWVbyUF3dI
	 lwQIn5T8rpdgTykhPtdtHvZsEtGvcStn3XulRBdao7DV2EnK85Ublp/i2df8qeqAiV
	 SugUM1lnqVaWYMrSi4m0Ecm8HYaZF6ftB6OZu+m6llqXBvbAKfSaPIWMWLroWtIQ7E
	 mCqfxbAw/ST2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5F9040D0A;
	Wed, 11 Nov 2026 22:29:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A672335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BF4D40D08
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lTwTgJIORazt for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3B0A40B22
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=JoVL6A3j
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3B0A40B22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436142; bh=tONdxrk+3yBdUzkx2KTsQlwPeD5y13A1L4ouFvYNz3Q=;
 b=JoVL6A3jZjNU3F0D+0j2OVHQ5ljhuHy3GK5OE+h1072lrtLnkZIXcuLlFdRVHhNLmsiQ5b8ak
 ixhWJU+zr7Hx699XDDVSPIpVYkWxEW4fV29s2j2Yui/avKTUhUaF4meOJbWjb2HeMG4R88uaPoL
 /zIqaejRj7o39r8mvbWxg6y7d21x6ImqaswoX6mxN7nZuBQfFf9ys+t6BIqd+9tu/1JRG57oMfs
 gtGoQH7q6mL644RrzThp+mjrsGuG/eOXKlU66ly+ay4+sJ8XeEE9xY+vBBn9oUV9c+BW+DYg5yp
 Ex1DOnovE/IrZQKORJWDVoTUp0pIuXs01yXC1Q02wrTg==
X-Forward-Email-ID: 6af4ec2c6e1792a74d36a53c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 6/6] clk: rockchip: pll: Limit special rk3588_pll handling
 to RK3588
Date: Wed, 11 Nov 2026 22:28:32 +0000
Message-ID: <20261111222834.157842-7-jonas@kwiboo.se>
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

The rk3588_pll_set_rate() function contains special handling intended
only for PLLs on RK3588 that are also applied to PLLs on RK3576.

This special handling should ideally be moved from the common pll funcs
into the clk_rk3588 driver. Add IS_ENABLED() guards as an initial step
to limit this special handling to PLLs on RK3588 targets.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index a2b16543e811..e00975565a0c 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -459,7 +459,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	 * When power on or changing PLL setting,
 	 * we must force PLL into slow mode to ensure output stable clock.
 	 */
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
 	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
@@ -467,15 +467,15 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
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
@@ -511,7 +511,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     pll->mode_mask << pll->mode_shift,
 			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
 	}
-	if (pll_id == 0) {
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -521,7 +521,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 1) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 1) {
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
 			     2 << 6);
@@ -531,7 +531,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		rk_clrsetreg(base + RK3588_B1PLL_CLKSEL_CON(1),
 			     RK3588_CORE_DIV_MASK << RK3588_CORE_B13_DIV_SHIFT,
 			     0 << RK3588_CORE_B13_DIV_SHIFT);
-	} else if (pll_id == 2) {
+	} else if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 2) {
 		rk_clrsetreg(base + RK3588_LPLL_CLKSEL_CON(5),
 			     pll->mode_mask << 14,
 			     2 << 14);
@@ -549,7 +549,7 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 			     0 << RK3588_CORE_L02_DIV_SHIFT);
 	}
 
-	if (pll_id == 3)
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588) && pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0);
 
 	debug("PLL at %p: con0=%x con1= %x con2= %x mode= %x\n",
-- 
2.56.1

