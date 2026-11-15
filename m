Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F0606A329
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDwvr8aK;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=nKZXtepw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA24940652;
	Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0FEfLpry8GF; Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DD7D40669
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772589;
	b=T8nbfPR+kTivFYLClpHWrZH4P1rUNITI8BPiX2ZArKEWpWEWPfVBTXbi2qabO+wqvJZJ
	 c/VSxif9yf8lZn68YRpBSOEVWd09Yxh/6iJAMqGj602b+BQWYwl9k0ity2fOS8Hq6RuDz
	 mEF7b6kahSDQfBW4/UUPWQECWMl3Whvlep+6BdiJZLVGJidezlYRv5aIdXBkV4YX4iBqf
	 qw4e0y1JowgGNneKexeiLhRx0yV3Qy17iOgxH3ySas4FJAJweZZBRW3FMeIcMKFl1j2Nv
	 Wprm2ITAfxYj+uA+VbKP/0kd0pIH2Fa1K7XIlERUUee7Quuo1miJhH/35U4O9qzab/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772589;
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
	bh=qinIV69YcLomLMjayRC6BwkLtJZcEk8xfPPK5mrOAxc=;
	b=SF3/MfcW9xwBKIsTn3h/1UePdpDn4EhPGG9ZC/Y0u61j2FFgXNZNlrKe1PgEyQF4UJeb
	 2IHQk+vIkrN7CJ/6WP9xP4U/oCyw/cjIAUWirAQGQTBca5Qpy8sy9Y/oWcaYUWXphbs6K
	 XKD9SFdFLYSPp5IqPjro8t19WOxmT/KKXDrHhKmksSVH2Bs5LLRpIJYdjXUU2MlP7DJeO
	 IwAAbloNJFfG1hzzzBaxxpEq6aWMacBf5pkrhMgnSzpDTW34QE/jqM3lYK0tZ+hYEJ+Dl
	 YJSErl86UQr8+2Nw9QA9+MH8W18PdlvN5TNcWwsLUGOlEuKlFAxZSeZ3zCF2HSEheNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772589;
	bh=qinIV69YcLomLMjayRC6BwkLtJZcEk8xfPPK5mrOAxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDwvr8aKR2xoXMvrCA4Mg/ysaGld1JozVaIdoQAtPJFeP5VwqfK9RVsB5xSPAX6mF
	 5jmwUfZ5089hI/eU5ue77+MwSMuBmah58ZWwRKzFDTx4l8PnH3pCfucw42CdkQGemc
	 qPN1+Wv1G3+5DJHcNcPTp1nc2u4AfAWFgiJLlKAqca2e0Jkz0fIC0teK/LpTOU6k1B
	 MSnfrOQGp2hBKkEVGQA6qJxiPThZH4AD7NkM07NWtGd6ZyVZHaFz5uroAw9t6nIZcG
	 YJ5QqBVF5D/x5sefL1grVl2fSPpmHEqYNuafSdE+HIyTz+VML4naQLv5l+SGTo1Mou
	 iZN/8rqL8UYFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DD7D40669;
	Sun, 15 Nov 2026 19:56:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9A1B1E7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE2A160672
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzM21OBFydbO for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 261FB6061A
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
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=nKZXtepw
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 261FB6061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772585; bh=qinIV69YcLomLMjayRC6BwkLtJZcEk8xfPPK5mrOAxc=;
 b=nKZXtepwbCseqBCGKV3ZNMHhlbQulE8zoZEkKgKm2KkvOXtrmzIvG8gKl5xt3IH4WDMLYLa4R
 9XJqYyfrYzgeouo/wgaxXUYdD124Irf/vabmNF2eHCb8QLOwD204FtTgnrv+wcVRc//BfJC6uEO
 chVOHcKU843adLtd+Fdyu7ymzzCQu447mWxESXWlhcclN9HmoSrnDwelXW62omRGONeonqWeZdP
 N2RVYQLsXJ4MWcLDPhboxLP6BKYycGMWUqHeNFOCxsDwtFp66yPJTkCn+zosG74EXu2rTy8v5Ry
 hrS7XeGzDkaIiaHPtdtgKWsSL19S/om6BUInGMgoIMBA==
X-Forward-Email-ID: 6afa0e662aaf531b6d740538
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 5/6] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 RK3588/RK3576 PPLL
Date: Sun, 15 Nov 2026 19:55:57 +0000
Message-ID: <20261115195600.119868-6-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PPLL on RK3588 and RK3576 has no PLL mode register and cannot switch
between slow, deep slow or normal mode.

Extend ROCKCHIP_PLL_FIXED_MODE support to the pll_rk3588 type and mark
both PPLLs with this flag. Skip mode register writes when changing rates
and treat the PLLs as operating in normal mode when reading rates.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
- Rebase on top of u-boot-rockchip/WIP/20261110
Changes in v3:
- No change
Changes in v2:
- Update comment in clock.h header
- Update commit message
- Collect r-b tag
---
 arch/arm/include/asm/arch-rockchip/clock.h |  2 +-
 drivers/clk/rockchip/clk_pll.c             | 21 +++++++++++++--------
 drivers/clk/rockchip/clk_rk3576.c          |  3 ++-
 drivers/clk/rockchip/clk_rk3588.c          |  3 ++-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 8d3819778eb1..43b63f72703d 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -19,7 +19,7 @@ struct udevice;
  * PLL flags
  */
 #define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
-/* normal mode only. now only for pll_rk3036, pll_rk3328 type */
+/* normal mode only. */
 #define ROCKCHIP_PLL_FIXED_MODE		BIT(1)
 
 enum {
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index b18b2ad342e3..43fad9d5956f 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -460,9 +460,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	if (pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
-	rk_clrsetreg(base + pll->mode_offset,
-		     pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	}
 	if (pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -502,8 +504,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		debug("%s: wait pll lock, pll_id=%ld\n", __func__, pll_id);
 	}
 
-	rk_clrsetreg(base + pll->mode_offset, pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	}
 	if (pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -564,10 +569,10 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
 	con = readl(base + pll->mode_offset);
 	shift = pll->mode_shift;
-	if (pll_id == 8)
-		mode = RKCLK_PLL_MODE_NORMAL;
-	else
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE))
 		mode = (con & (pll->mode_mask << shift)) >> shift;
+	else
+		mode = RKCLK_PLL_MODE_NORMAL;
 	switch (mode) {
 	case RKCLK_PLL_MODE_SLOW:
 		return OSC_HZ;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 0e316068a45b..1a2ac14b63a5 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -56,7 +56,8 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
-		     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3576_24m_pll_rates),
 };
 
 #ifdef CONFIG_SPL_BUILD
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 302ea393a1f3..f6144d1f96b8 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -60,7 +60,8 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
-		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
+		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
-- 
2.56.1

