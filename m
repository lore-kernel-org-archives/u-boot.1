Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18596606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i0ymYfaT;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=yNNH5k5Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E871340B39;
	Wed, 11 Nov 2026 22:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWxbJSB9oU6G; Wed, 11 Nov 2026 22:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3150F40D04
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436144;
	b=CSHsVf1NfgYrRWAigdO5/YRNpch0CCoUNzlQvpJ3f1+AJu8xgWOOiOwZvJ/MjWimaUm6
	 t+NrrE+V0LRqWCLiIL5jzg0zPBVYDSNY+35gIJjoLQns0GbhnJnvRxLEHWBsIpAYPkWnG
	 5NU5Ay8ogj/CRHifqdBVZy7Kh34LpklDV+WR4iFNiRV2BMoqyr3o0aM1DB+kEm3Q4/7lc
	 Pc/gqfPpePZ8btoTEceJpxKZPwexZmo1zwjXMisIF0IfVBLEGXswEPJE9ikb263Ouy/fw
	 PxXiTrKGfZ01IAKDFg7NDeBtcCXz7KuHI47O1HamQynweG1xg+AMluLJrvy5iO32Okg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436144;
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
	bh=L0muH3bp+ID/dQHOXZpgBYaPfAOs8UJCTBbYc6KTsBo=;
	b=nfXXKH1YR6RqUb8KaN2QJ5crxZHLoR/Ld8+U0g7p+yr16UTfqrSwOvp3NGtn6fDy87XX
	 FYpJwIB990MSb3WLXH4ktzsr9TSKc8jdFRrHEtqyGdM+Kg1FJaDL0pToFQl2fJm8o/5ga
	 gskguTJU4RawAiDJB1BMnauOx00BCvFFEX89LlrVjwpaJp5n2HUQP20eMYRNDWu31enEJ
	 /qXGhihnAPKNikQzjU5hcIm+TLhu/WBh2RYflmFpMfIufGWd1W7MqgP9Wl/0zq4E2Wn4D
	 K/3lc6z/jt+JJmE52L/WyGFJWEN07GuVUmeTyHshKT7CF1GohmejAVeu4BezRmw/0NA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=yNNH5k5Q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436144;
	bh=L0muH3bp+ID/dQHOXZpgBYaPfAOs8UJCTBbYc6KTsBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0ymYfaTk+7YIc31hnxpsCAFgHSYAqhQ8G35C3g8jIi5zKeoHniTcUDRhLTeCnrWk
	 5kNeMHhnsYLs1N6LQ363ZlssjIj9zyvC3xOq4e+grLDZml0bvDm6hpukI1W4aV3qbE
	 4VWgNehADXJaQ2MFW5/yrLU6wtvHl9S8q8jER1TCRIxXMhNl9qKNIr6ksW3gJY4C0E
	 Qb0JBCMhNvlxuJpOICada/31EI7Kb666AVbZw05IHNhGfIl6hif/QQ3VAGeTIPMB2s
	 6c981WHq0NwRtdh/JyhkDWkVpiQvFgPWY0U9+8SYz7F0yMOU2N6wk6heEVma41yJc4
	 EGKu6l75ZXk8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3150F40D04;
	Wed, 11 Nov 2026 22:29:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC175335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC8D240B39
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJB9flTqWh61 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F289E40B22
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
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=yNNH5k5Q
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F289E40B22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436141; bh=L0muH3bp+ID/dQHOXZpgBYaPfAOs8UJCTBbYc6KTsBo=;
 b=yNNH5k5QnM1c65YCs/qrwlvA8/1dckWhfv+noYq9ktWl7YzCcTvq2jAFg1J7gNqySIDdXI1oy
 bAWGrx93wefclTJhwsGAyCT3c/P1irPklwrTTUJ0CI90KPhNCVVWOUDGUALjmye5p7Oz7hE7+9k
 siTFRyEhShfnvHllWLj27dRcexOfqDed2O/GIIDaGLh3C7BOSsxaJ2MaMEBDmWMcdu1B3guJKCn
 LkTsr81YtziZbJuL5vvde2ga4w3bSbZth2P60pXmFhWykGC/ucWwduFaSVYdUuz5iFdQUgTC/iZ
 x5NAM1FMkCOmeYwX4ZNkekAJW/R8OIGtVJIJx3GQ7ssA==
X-Forward-Email-ID: 6af4ec286e1792a74d36a522
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
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
Subject: [PATCH v3 5/6] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 RK3588/RK3576 PPLL
Date: Wed, 11 Nov 2026 22:28:31 +0000
Message-ID: <20261111222834.157842-6-jonas@kwiboo.se>
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

The PPLL on RK3588 and RK3576 has no PLL mode register and cannot switch
between slow, deep slow or normal mode.

Extend ROCKCHIP_PLL_FIXED_MODE support to the pll_rk3588 type and mark
both PPLLs with this flag. Skip mode register writes when changing rates
and treat the PLLs as operating in normal mode when reading rates.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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
index 6664fe3921b8..a2b16543e811 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -462,9 +462,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
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
@@ -504,8 +506,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
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
@@ -566,10 +571,10 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
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
index 4d55229aa87e..7dccd8341020 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -57,7 +57,8 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
-		     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3576_24m_pll_rates),
 };
 
 #ifdef CONFIG_SPL_BUILD
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index a13b33e97d42..5c3b0988e6a7 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -62,7 +62,8 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
-		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
+		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
-- 
2.56.1

