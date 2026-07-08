Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215B3C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126B984A90;
	Thu,  9 Jul 2026 00:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HCQ7BRhY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CD884AB3; Thu,  9 Jul 2026 00:05:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D88084A3A
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548355; bh=hqRoCyRjk47itzl6ricrOQ+KT66jD+IAnfiYWuTOGoU=;
 b=HCQ7BRhYbG99IKqQQUxocnrDEcwCY0KPvN9pGUZ+qwsm7snj1Oq5BSvXtwB0jZ320fJYNnVL0
 /cetCma92W0RqGFLlBlH17rIUFqrgMkhtz3HrbKADpApRRiJcAbXZFrFL3n84y0E3kQQmNjQcaT
 bHXy5tebzs6QR76hwTPEEBt1M+CpjkKGY4clqmXY6LwCEM9u0I6pPV23uqJgk/3LbQIuJsf/tFt
 gCgwAYbMhUJK5u1u40Dq3pz51KmOznZyoYmMjmMkp9NUpszlJ8TcOLnBiIXtD6NgRjiye7HQMB6
 8TK4mrpVXSbeWgC7JQVq2ExLCqR6MDp7b0EPpPZZivyQ==
X-Forward-Email-ID: 6a4ec9c12402b3ca75f90438
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/11] rockchip: clk: rk3368: Drop redundant CONFIG_TPL_BUILD
 checks
Date: Wed,  8 Jul 2026 22:05:29 +0000
Message-ID: <20260708220540.3368825-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
are therefore redundant.

Drop the redundant TPL_BUILD symbol check from conditional guards that
also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
symbol rename.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3368.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1df..5ba19bce7b24 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -50,7 +50,7 @@ struct pll_div {
 		       (_nr * _no) == hz, #hz "Hz cannot be hit with PLL " \
 		       "divisors on line " __stringify(__LINE__));
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static const struct pll_div apll_l_init_cfg = PLL_DIVISORS(APLL_L_HZ, 12, 2);
 static const struct pll_div apll_b_init_cfg = PLL_DIVISORS(APLL_B_HZ, 1, 2);
 #if !defined(CONFIG_TPL_BUILD)
@@ -88,7 +88,7 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 	}
 }
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 			 const struct pll_div *div)
 {
@@ -130,7 +130,7 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 static void rkclk_init(struct rk3368_cru *cru)
 {
 	u32 apllb, aplll, dpll, cpll, gpll;
@@ -586,7 +586,7 @@ static int rk3368_clk_probe(struct udevice *dev)
 
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
-#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 	rkclk_init(priv->cru);
 #endif
 
-- 
2.54.0

