Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B76C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E13C87944;
	Mon, 23 Oct 2023 15:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A5187774; Mon, 23 Oct 2023 15:25:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 297C187926
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9657E2F4;
 Mon, 23 Oct 2023 06:26:03 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A4323F762;
 Mon, 23 Oct 2023 06:25:21 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 13/24] sunxi: clock: D1/R528: Enable PLL LDO during PLL1
 setup
Date: Mon, 23 Oct 2023 14:24:38 +0100
Message-Id: <20231023132449.813863-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

The D1/R528/T113s SoCs introduce a new "LDO enable" bit in the CPUX_PLL.
Just enable that when we program that PLL.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  1 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c             | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 37df4410eaa..9895c2c220e 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -228,6 +228,7 @@ struct sunxi_ccm_reg {
 
 /* pll1 bit field */
 #define CCM_PLL1_CTRL_EN		BIT(31)
+#define CCM_PLL1_LDO_EN			BIT(30)
 #define CCM_PLL1_LOCK_EN		BIT(29)
 #define CCM_PLL1_LOCK			BIT(28)
 #define CCM_PLL1_OUT_EN			BIT(27)
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 767a39fa2ab..d32e33465f5 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -89,11 +89,13 @@ void clock_set_pll1(unsigned int clk)
 	writel(val, &ccm->cpu_axi_cfg);
 
 	/* clk = 24*n/p, p is ignored if clock is >288MHz */
-	writel(CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2 |
-#ifdef CONFIG_MACH_SUN50I_H616
-	       CCM_PLL1_OUT_EN |
-#endif
-	       CCM_PLL1_CTRL_N(clk / 24000000), &ccm->pll1_cfg);
+	val = CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
+	val |= CCM_PLL1_CTRL_N(clk / 24000000);
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
+	       val |= CCM_PLL1_OUT_EN;
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
+	       val |= CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
+	writel(val, &ccm->pll1_cfg);
 	while (!(readl(&ccm->pll1_cfg) & CCM_PLL1_LOCK)) {}
 
 	/* Switch CPU to PLL1 */
-- 
2.25.1

