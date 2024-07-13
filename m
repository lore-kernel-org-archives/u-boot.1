Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689D2C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAA088894;
	Sat, 13 Jul 2024 15:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bLiXJLgm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uu2fiulm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338F688888; Sat, 13 Jul 2024 15:21:28 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F96088836
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyG0lJyz9sTd;
 Sat, 13 Jul 2024 15:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHh0C0FsPO2C6Ac0kyfdsiJAuNAn4f+xnozrdyaUYR4=;
 b=bLiXJLgmIotd/oyMMv1frsmUmY8xcWSa2PK5rFVywiOl/r0P0eGWOiWZ6G8TmShCe5PkpM
 PjJjTlw23+bUII84sypaJNnFEngLLNZ6QCiyny1l/pg1MxTajZ0/nntrbP/Q+z8ti8R/1U
 GlOKjh/t+3bkaHhcSqAQkcX2JxNYNqkyk7iVEGfrDQ2E68V17vv1Qt6XMNMDFQ5XZqO5eN
 KMIa9kUCQlJXWR/9JF2Go6zIj/lSJO6AN40mw1CEJhwIc45bTUk7dkTwdbX5HfxuE4TkDq
 aLMnvclB5j0UYYtlDhwtKRUJt4InOs96yQvCbhqTTJ0dwVzH3SSjZt47oR+JIA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHh0C0FsPO2C6Ac0kyfdsiJAuNAn4f+xnozrdyaUYR4=;
 b=uu2fiulmkN1y+ui/nhVM59bKFGJRkiAIsC+Q9/AyfaUYxhMXwWoCnCUy/xHIjvvtzkhE5b
 s2nqT4HXB0D1W2ptdAqzenm/g/YCapQxfhlHnP34x4H3UV81ihkqLdGy/JMVCEYV9IfHwx
 XOGZ4k0CJkEMZFYACgQ9txiRDXHEMJVW/ZFmyiFhoqA7MHjDKR5BeTZkp6Hr7zx7uhCYZw
 OCtvE0itlzp2ZM0aJUndqAEbgxJHUTmh9GMi3cgi9qsKY/0mK3dg3WE2mgzSgNK7zTQwTR
 5t3Q7G0p3oD78OxLGqOPlT2oz+38FHywu6B4bKtv35seYn4W5p305XPJl//yNw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/45] arm: mach: imx: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:09 +0200
Message-ID: <20240713132021.57650-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d62a4652aeb53dcbce2
X-MBO-RS-META: samjumyz3ii6f3s6o4sycrzs4e6a3xmu
X-Rspamd-Queue-Id: 4WLpyG0lJyz9sTd
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/cache.c              | 1 -
 arch/arm/mach-imx/imx8/cpu.c           | 2 --
 arch/arm/mach-imx/imx8m/clock_imx8mq.c | 1 -
 arch/arm/mach-imx/mx6/litesom.c        | 1 -
 arch/arm/mach-imx/mx7ulp/scg.c         | 2 --
 5 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-imx/cache.c b/arch/arm/mach-imx/cache.c
index b368db49fce..7b3eacb43ed 100644
--- a/arch/arm/mach-imx/cache.c
+++ b/arch/arm/mach-imx/cache.c
@@ -86,7 +86,6 @@ void v7_outer_cache_enable(void)
 	struct iomuxc *iomux = (struct iomuxc *)IOMUXC_BASE_ADDR;
 	unsigned int val, cache_id;
 
-
 	/*
 	 * Must disable the L2 before changing the latency parameters
 	 * and auxiliary control register.
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 627baa1d83f..accba502e49 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -519,7 +519,6 @@ phys_size_t get_effective_memsize(void)
 	board_mem_get_layout(&phys_sdram_1_start, &phys_sdram_1_size,
 			     &phys_sdram_2_start, &phys_sdram_2_size);
 
-
 	end1 = (sc_faddr_t)phys_sdram_1_start + phys_sdram_1_size;
 	for (mr = 0; mr < 64; mr++) {
 		err = get_owned_memreg(mr, &start, &end);
@@ -699,7 +698,6 @@ static u64 get_block_size(sc_faddr_t addr_start, sc_faddr_t addr_end)
 	board_mem_get_layout(&phys_sdram_1_start, &phys_sdram_1_size,
 			     &phys_sdram_2_start, &phys_sdram_2_size);
 
-
 	end1 = (sc_faddr_t)phys_sdram_1_start + phys_sdram_1_size;
 	end2 = (sc_faddr_t)phys_sdram_2_start + phys_sdram_2_size;
 
diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mq.c b/arch/arm/mach-imx/imx8m/clock_imx8mq.c
index 7e6c3748716..43e677deae2 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mq.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mq.c
@@ -733,7 +733,6 @@ static int frac_pll_init(u32 pll, enum frac_pll_out_val val)
 	return 0;
 }
 
-
 int clock_init(void)
 {
 	u32 grade;
diff --git a/arch/arm/mach-imx/mx6/litesom.c b/arch/arm/mach-imx/mx6/litesom.c
index ab5de266577..03e1214c060 100644
--- a/arch/arm/mach-imx/mx6/litesom.c
+++ b/arch/arm/mach-imx/mx6/litesom.c
@@ -83,7 +83,6 @@ int litesom_mmc_init(struct bd_info *bis)
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
 
-
 static struct mx6ul_iomux_grp_regs mx6_grp_ioregs = {
 	.grp_addds = 0x00000030,
 	.grp_ddrmode_ctl = 0x00020000,
diff --git a/arch/arm/mach-imx/mx7ulp/scg.c b/arch/arm/mach-imx/mx7ulp/scg.c
index d4fb5389cac..59da7300dd6 100644
--- a/arch/arm/mach-imx/mx7ulp/scg.c
+++ b/arch/arm/mach-imx/mx7ulp/scg.c
@@ -428,7 +428,6 @@ static u32 scg_nic_get_rate(enum scg_clk clk)
 	return rate;
 }
 
-
 static enum scg_clk scg_scs_array[4] = {
 	SCG_SOSC_CLK, SCG_SIRC_CLK, SCG_FIRC_CLK, SCG_ROSC_CLK,
 };
@@ -807,7 +806,6 @@ int scg_enable_usb_pll(bool usb_control)
 	return 0;
 }
 
-
 /* A7 domain system clock source is SPLL */
 #define SCG1_RCCR_SCS_NUM	((SCG_SCS_SYS_PLL) << SCG_CCR_SCS_SHIFT)
 
-- 
2.43.0

