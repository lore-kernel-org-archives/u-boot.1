Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD3DC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 22:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE8E80840;
	Sat,  8 Feb 2025 23:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="POCQQDmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B15B8091A; Sat,  8 Feb 2025 23:50:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D12680A0A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1739055002; bh=Oq9wq6QUkUSU31H4Ho1i/bFo4v9cZ8Ml3B+1zFwIzVk=;
 b=POCQQDmGjApqqZFjXr3XATNDCcI7/GFI1rDWWGC8iO//5pzk1WKCRC6jZYdqP1f7suI9ArUzj
 nalsAs1m1R0Gk9l3/lrAFdhtWQIlHnphhyPJUG8sQ7Uu4EsAdLQ5F6ftC1n6C4KUs9utZeazjMt
 mku/eADgJ861lCW75mVh2xXbHxdlUZh8Hir5nZrV/HljoVPhnWzF+fdKBpIJ7wHMYWrBGx/RiCQ
 hlMh57SsZBje/Q4qmw/f5JUW8sObhetm1vClhfh2xSca6cf19oBtIxOEgIcwgn/tobbRm9LSaE1
 uNDwewbAhDzQ5uyAOsz4PWgD6Y94YjDSG5fBFQZJLHaA==
X-Forward-Email-ID: 67a7df97771e645baa15e2c6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
Date: Sat,  8 Feb 2025 22:49:40 +0000
Message-ID: <20250208224945.2641933-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250208224945.2641933-1-jonas@kwiboo.se>
References: <20250208224945.2641933-1-jonas@kwiboo.se>
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

These power rails must be on very early for the U-Boos TPL banner to be
show over debug UART.

This reverts commit 4576e65a5d6b10fd207c3a44061676ce0220d794.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index ba89079b1e73..0c28241c603e 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -136,7 +136,7 @@ void board_debug_uart_init(void)
 	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
 	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
 	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
 		rk_setreg(&grf->io_vsel, 1 << 0);
-- 
2.48.1

