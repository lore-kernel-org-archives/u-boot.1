Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED145C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FED88889;
	Sat, 13 Jul 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vom6R2Db";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZdZcpu20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7522D888A2; Sat, 13 Jul 2024 15:21:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFE488872
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyM2sLjz9scZ;
 Sat, 13 Jul 2024 15:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsoXBFaOuuGj11pWRPFIhsTwQWX+KWbTC2QhGaXwTBI=;
 b=vom6R2DbnhcVSXyq0sMYPDI7mMC18ATjOw89eFH0UnlKHyb1HTTdGqujAI8vxDAXMIoesa
 BcLUs2weQcMgDbkunxwTViiKZ6en5MieUIER0Pq862SDbfJzpGzEeNuMXWDcKXRHuThLiy
 6M7wDTV04iEBVWYl07F2ivye1axub0Mtt2qim/79JxYXepCdhY5bu2kHt1bsoa3tZ7bRN5
 x7MP4rMPqKb0+MSrAhf0Jkp3NZ5KwUdODVhK6b3ISMOSpqZTjP70xBQES4Y+X+Mt4Gqp2w
 5YRB3ET2zYbi5HrFlfUVx8dEAFu2lgpwNSqXtseg3N/7EY7TQKwHaMz/LzD9sg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsoXBFaOuuGj11pWRPFIhsTwQWX+KWbTC2QhGaXwTBI=;
 b=ZdZcpu20TvBrCXSaCxQvqQPqX4nJVHeGsCZlbJAKJ6GWtAYWSdhcPV/v2b69lbHp6PZUab
 X601DLk6m2Uj9EuLN1nD1b9YfaNAy0rwv+kEW/kyjVlNTNxTkI8OBpvOI7bimy3qiAq3yK
 6zqCDwmFF/TKxErhLOEv+GPSqs1bo5bX/6DmDPrOLUHA+53hQGnVDRakkA+8u9PymRIxoY
 gekBCNVfy0ST4uRbRFiKNrmtE1OyrfrmYlRhU7/4h+jDKuNZet3EiCTC0HhWykdaXrytJS
 BZWYghC9sExdqOrwX5srNccHQXb+s7H/DOOjK/GGH/y7Xq8iT54EF0EiVmCTOA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/45] arm: mach: sunxi: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:14 +0200
Message-ID: <20240713132021.57650-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cf502510bc635ef676e
X-MBO-RS-META: gpkghiddnmztjg4i68qk8zh1myen8wy4
X-Rspamd-Queue-Id: 4WLpyM2sLjz9scZ
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
 arch/arm/mach-sunxi/clock_sun8i_a83t.c | 1 -
 arch/arm/mach-sunxi/clock_sun9i.c      | 2 --
 arch/arm/mach-sunxi/dram_sun8i_a83t.c  | 1 -
 arch/arm/mach-sunxi/dram_sun9i.c       | 1 -
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 1 -
 5 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-sunxi/clock_sun8i_a83t.c b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
index 9eeba084f95..c00d16a918d 100644
--- a/arch/arm/mach-sunxi/clock_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
@@ -118,7 +118,6 @@ void clock_set_pll5(unsigned int clk)
 	udelay(5500);
 }
 
-
 unsigned int clock_get_pll6(void)
 {
 	struct sunxi_ccm_reg *const ccm =
diff --git a/arch/arm/mach-sunxi/clock_sun9i.c b/arch/arm/mach-sunxi/clock_sun9i.c
index 5913e40cb65..abdab405445 100644
--- a/arch/arm/mach-sunxi/clock_sun9i.c
+++ b/arch/arm/mach-sunxi/clock_sun9i.c
@@ -14,7 +14,6 @@
 #include <asm/arch/prcm.h>
 #include <asm/arch/sys_proto.h>
 
-
 #ifdef CONFIG_SPL_BUILD
 
 static void clock_set_pll2(unsigned int clk)
@@ -166,7 +165,6 @@ void clock_set_pll6(unsigned int clk)
 	sdelay(2000);
 }
 
-
 int clock_twi_onoff(int port, int state)
 {
 	struct sunxi_ccm_reg *const ccm =
diff --git a/arch/arm/mach-sunxi/dram_sun8i_a83t.c b/arch/arm/mach-sunxi/dram_sun8i_a83t.c
index ef833321e37..dd0fc37b763 100644
--- a/arch/arm/mach-sunxi/dram_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/dram_sun8i_a83t.c
@@ -284,7 +284,6 @@ static int mctl_channel_init(struct dram_para *para)
 	writel(0x0, MCTL_PROTECT);
 	udelay(100);
 
-
 	/* Set ODT */
 	if (IS_ENABLED(CONFIG_DRAM_ODT_EN))
 		rval = 0x0;
diff --git a/arch/arm/mach-sunxi/dram_sun9i.c b/arch/arm/mach-sunxi/dram_sun9i.c
index 002b6df39d5..58ecbb98356 100644
--- a/arch/arm/mach-sunxi/dram_sun9i.c
+++ b/arch/arm/mach-sunxi/dram_sun9i.c
@@ -262,7 +262,6 @@ static void mctl_sys_init(void)
 		reg_val |= ((0x1<<24)|(0x1<<30));
 		mctl_write_w(CCM_PLL6_DDR_REG, reg_val);
 
-
 		while(mctl_read_w(CCM_PLL6_DDR_REG) & (0x1<<30));
 	}
 
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index e064ef329e6..4ed295909ce 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -650,7 +650,6 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 	return 0;
 }
 
-
 static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)
 {
 	/* detect row address bits */
-- 
2.43.0

