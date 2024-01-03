Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F89BC46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC01879E6;
	Wed,  3 Jan 2024 01:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F827879C5; Wed,  3 Jan 2024 01:13:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 18A34879D9
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC931516;
 Tue,  2 Jan 2024 16:14:29 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C31683F5A1;
 Tue,  2 Jan 2024 16:13:42 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 13/19] sunxi: sun8i_a83t: make more clock functions SPL only
Date: Wed,  3 Jan 2024 00:12:33 +0000
Message-Id: <20240103001239.17482-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

In clock_sun8i_a83t.c, responsible for (mostly early) clock setup on the
Allwinner A83T SoC, many functions are only needed by the SPL, and are
thus already guarded by CONFIG_SPL_BUILD.

Over the years drivers like for the UART or I2C were converted to DM,
so they care about clock setup themselves now, by using a proper DM clock
driver.

This means those devices need the clock setup functions here for the SPL
only. Include those functions into the existing CONFIG_SPL_BUILD guards,
so they are compiled for the SPL only.

This avoids unnecessary code in U-Boot proper and helps further
refactoring. Add some comments on the way to help understanding of the
file.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/clock_sun8i_a83t.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/clock_sun8i_a83t.c b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
index 198fe9dbd73..9eeba084f95 100644
--- a/arch/arm/mach-sunxi/clock_sun8i_a83t.c
+++ b/arch/arm/mach-sunxi/clock_sun8i_a83t.c
@@ -46,7 +46,6 @@ void clock_init_safe(void)
 	/* timestamp */
 	writel(1, 0x01720000);
 }
-#endif
 
 void clock_init_uart(void)
 {
@@ -70,7 +69,6 @@ void clock_init_uart(void)
 			   CONFIG_CONS_INDEX - 1));
 }
 
-#ifdef CONFIG_SPL_BUILD
 void clock_set_pll1(unsigned int clk)
 {
 	struct sunxi_ccm_reg * const ccm =
@@ -102,8 +100,9 @@ void clock_set_pll1(unsigned int clk)
 		CPU_CLK_SRC_PLL1 << C1_CPUX_CLK_SRC_SHIFT,
 	       &ccm->cpu_axi_cfg);
 }
-#endif
+#endif /* CONFIG_SPL_BUILD */
 
+/* DRAM and PLL_PERIPH0 clock (used by the MMC driver) */
 void clock_set_pll5(unsigned int clk)
 {
 	struct sunxi_ccm_reg * const ccm =
-- 
2.35.8

