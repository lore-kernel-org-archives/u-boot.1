Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86DC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5779F88846;
	Sat, 13 Jul 2024 15:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MB1TE7M6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dy/be0WP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B29388868; Sat, 13 Jul 2024 15:21:21 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3948884F
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLpy722VZz9sq7;
 Sat, 13 Jul 2024 15:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60Pgtm0sbTCVUfiItHfK2ZOTaoYiOaNn/g7Tq3xw718=;
 b=MB1TE7M63vDbeJMXB1SBep94Ua8uGD6z+nZLi95X1GahbmsQ1chAxNHLcckqQ6P39e+DyD
 +sTeL8zA6/9/fw7CI3ZeiD67U8cnUU6kAg/Tp3EFnieFAY8YIO60doIfFlYdFGwZ7dPMDK
 gzEyqggKn6AlmnvZ46de2ztYnrrul2A6+p0ra6Yco9bhcOqK8mYNncl927z4yVv9r3TSjr
 Pm4pR/BaMwLPEMXPaBPNIZoz/o9QGlkcviFbVS4ZzXJ8XZZnmlf9mWkKhiGI5M1PXeMt4Y
 wb7gVF5Y2Z05ik9MwfzqQQs+tQruQfI5zT0Jnl7BclRLbcaR9b0qKHIfRRdOng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60Pgtm0sbTCVUfiItHfK2ZOTaoYiOaNn/g7Tq3xw718=;
 b=Dy/be0WPCkyRQcsS1fnif9tIn2iTLL7FToJvkH8YbprIyfEqcZXXNNEmAmFtnf6LhzXW17
 UxxOx2kGJhUofChquXj8OdNCkyf/w/acFcbOZ5J8SS250Pz4GItpz9P5ISLZsJm95bf7Y7
 zYk/WqGtHYxVDz/BBaZfhCFTZjM1RysvfcTdc7szNQYuGd/6ZsPstCa371AZcRf+LQzcTs
 42HiQg7Cv4Vbn8MKHh83u3lznIs1vpSfvxSEqdLFMXNdBIo81orBmRyza5OkJcc1C5PIsq
 EpI3uuHaXI0ETVosvbmbSejqtsxLd5sasgoXuu4zCHybkyprM/FaRyO221ytYA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/45] arm: include: sunxi: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:03 +0200
Message-ID: <20240713132021.57650-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fa484bbf862b51786b2
X-MBO-RS-META: 7us7y77zbsjzfsaf1j7rxfdpx6m14131
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
 arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h | 2 --
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h      | 1 -
 arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h   | 1 -
 arch/arm/include/asm/arch-sunxi/dram_sun8i_a83t.h  | 1 -
 arch/arm/include/asm/arch-sunxi/dram_sun9i.h       | 2 --
 5 files changed, 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
index 14df3cc8f46..35ca0491ac9 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
@@ -262,7 +262,6 @@ struct sunxi_ccm_reg {
 #define CCM_DRAM_GATE_OFFSET_DE_BE0	26
 #define CCM_DRAM_GATE_OFFSET_DE_BE1	27
 
-
 #define MBUS_CLK_DEFAULT		0x81000002 /* PLL6 / 2 */
 
 #define MBUS_CLK_GATE			(0x1 << 31)
@@ -295,7 +294,6 @@ struct sunxi_ccm_reg {
 #define APB2_RESET_TWI_SHIFT		(0)
 #define APB2_RESET_TWI_MASK		(0xf << APB2_RESET_TWI_SHIFT)
 
-
 #ifndef __ASSEMBLY__
 void clock_set_pll1(unsigned int hz);
 void clock_set_pll5(unsigned int clk);
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
index 0264bfe1c50..006f7761fc6 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
@@ -217,7 +217,6 @@ struct sunxi_ccm_reg {
 #define APB1_RESET_TWI_SHIFT		0
 #define APB1_RESET_TWI_MASK		(0xf << APB1_RESET_TWI_SHIFT)
 
-
 #ifndef __ASSEMBLY__
 void clock_set_pll1(unsigned int clk);
 void clock_set_pll6(unsigned int clk);
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
index be02655cdd5..f0caecc807d 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
@@ -323,7 +323,6 @@ struct dram_para {
 	const u8 dx_write_delays[NR_OF_BYTE_LANES][WR_LINES_PER_BYTE_LANE];
 };
 
-
 static inline int ns_to_t(int nanoseconds)
 {
 	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun8i_a83t.h b/arch/arm/include/asm/arch-sunxi/dram_sun8i_a83t.h
index 2a879963547..28b6560ff5b 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun8i_a83t.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun8i_a83t.h
@@ -146,7 +146,6 @@ struct sunxi_mctl_ctl_reg {
 	u32 perfwr1;		/* 0x1d8 */
 };
 
-
 #define ZQnPR(x)	(SUNXI_DRAM_CTL0_BASE + 0x00000144 + 0x10 * x)
 #define ZQnDR(x)	(SUNXI_DRAM_CTL0_BASE + 0x00000148 + 0x10 * x)
 #define ZQnSR(x)	(SUNXI_DRAM_CTL0_BASE + 0x0000014c + 0x10 * x)
diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun9i.h b/arch/arm/include/asm/arch-sunxi/dram_sun9i.h
index 41df5fe5b6f..a77daecb107 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun9i.h
@@ -40,7 +40,6 @@ struct sunxi_mctl_com_reg {
 	u32 mdfstcr;		/* 0x14c */
 };
 
-
 struct sunxi_mctl_ctl_reg {
 	u32 mstr;		/* 0x00 master register */
 	u32 stat;		/* 0x04 operating mode status register */
@@ -92,7 +91,6 @@ struct sunxi_mctl_ctl_reg {
 	u32 perfwr1;		/* 0x26c write CAM register 1 */
 };
 
-
 struct sunxi_mctl_phy_reg {
 	u8 res0[0x04];		/* 0x00 revision id ??? */
 	u32 pir;		/* 0x04 PHY initialisation register */
-- 
2.43.0

