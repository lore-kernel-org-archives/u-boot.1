Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AB5C00A8F
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AED587965;
	Mon, 23 Oct 2023 15:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5079387960; Mon, 23 Oct 2023 15:25:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2636D87942
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7C1C15;
 Mon, 23 Oct 2023 06:26:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5B73F762;
 Mon, 23 Oct 2023 06:25:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 20/24] sunxi: psci: clean away preprocessor macros
Date: Mon, 23 Oct 2023 14:24:45 +0100
Message-Id: <20231023132449.813863-21-andre.przywara@arm.com>
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

From: Sam Edwards <cfsworks@gmail.com>

This patch restructures psci.c to get away from the "many different
function definitions switched by #ifdef" paradigm to the preferred style
of having a single function definition with `if (IS_ENABLED(...))` to
make the optimizer include only the appropriate function bodies instead.

There are no functional changes here.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 103 +++++++++++++-------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index e1d3638b5ca..69fa3f3c2eb 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -76,11 +76,8 @@ static void __secure __mdelay(u32 ms)
 	isb();
 }
 
-static void __secure clamp_release(u32 __maybe_unused *clamp)
+static void __secure clamp_release(u32 *clamp)
 {
-#if defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN7I) || \
-	defined(CONFIG_MACH_SUN8I_H3) || \
-	defined(CONFIG_MACH_SUN8I_R40)
 	u32 tmp = 0x1ff;
 	do {
 		tmp >>= 1;
@@ -88,83 +85,69 @@ static void __secure clamp_release(u32 __maybe_unused *clamp)
 	} while (tmp);
 
 	__mdelay(10);
-#endif
 }
 
-static void __secure clamp_set(u32 __maybe_unused *clamp)
+static void __secure clamp_set(u32 *clamp)
 {
-#if defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN7I) || \
-	defined(CONFIG_MACH_SUN8I_H3) || \
-	defined(CONFIG_MACH_SUN8I_R40)
 	writel(0xff, clamp);
-#endif
 }
 
-static void __secure sunxi_power_switch(u32 *clamp, u32 *pwroff, bool on,
-					int cpu)
+static void __secure sunxi_set_entry_address(void *entry)
 {
-	if (on) {
-		/* Release power clamp */
-		clamp_release(clamp);
-
-		/* Clear power gating */
-		clrbits_le32(pwroff, BIT(cpu));
+	/* secondary core entry address is programmed differently on R40 */
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+		writel((u32)entry,
+		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
 	} else {
-		/* Set power gating */
-		setbits_le32(pwroff, BIT(cpu));
+		struct sunxi_cpucfg_reg *cpucfg =
+			(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
 
-		/* Activate power clamp */
-		clamp_set(clamp);
+		writel((u32)entry, &cpucfg->priv0);
 	}
 }
 
-#ifdef CONFIG_MACH_SUN8I_R40
-/* secondary core entry address is programmed differently on R40 */
-static void __secure sunxi_set_entry_address(void *entry)
-{
-	writel((u32)entry,
-	       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
-}
-#else
-static void __secure sunxi_set_entry_address(void *entry)
+static void __secure sunxi_cpu_set_power(int cpu, bool on)
 {
+	u32 *clamp = NULL;
+	u32 *pwroff;
 	struct sunxi_cpucfg_reg *cpucfg =
 		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
 
-	writel((u32)entry, &cpucfg->priv0);
-}
-#endif
+	/* sun7i (A20) is different from other single cluster SoCs */
+	if (IS_ENABLED(CONFIG_MACH_SUN7I)) {
+		clamp = &cpucfg->cpu1_pwr_clamp;
+		pwroff = &cpucfg->cpu1_pwroff;
+		cpu = 0;
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
+		clamp = (void *)cpucfg + SUN8I_R40_PWR_CLAMP(cpu);
+		pwroff = (void *)cpucfg + SUN8I_R40_PWROFF;
+	} else {
+		struct sunxi_prcm_reg *prcm =
+			(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
 
-#ifdef CONFIG_MACH_SUN7I
-/* sun7i (A20) is different from other single cluster SoCs */
-static void __secure sunxi_cpu_set_power(int __always_unused cpu, bool on)
-{
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
+		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
+			clamp = &prcm->cpu_pwr_clamp[cpu];
 
-	sunxi_power_switch(&cpucfg->cpu1_pwr_clamp, &cpucfg->cpu1_pwroff,
-			   on, 0);
-}
-#elif defined CONFIG_MACH_SUN8I_R40
-static void __secure sunxi_cpu_set_power(int cpu, bool on)
-{
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+		pwroff = &prcm->cpu_pwroff;
+	}
 
-	sunxi_power_switch((void *)cpucfg + SUN8I_R40_PWR_CLAMP(cpu),
-			   (void *)cpucfg + SUN8I_R40_PWROFF,
-			   on, cpu);
-}
-#else /* ! CONFIG_MACH_SUN7I && ! CONFIG_MACH_SUN8I_R40 */
-static void __secure sunxi_cpu_set_power(int cpu, bool on)
-{
-	struct sunxi_prcm_reg *prcm =
-		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
+	if (on) {
+		/* Release power clamp */
+		if (clamp)
+			clamp_release(clamp);
 
-	sunxi_power_switch(&prcm->cpu_pwr_clamp[cpu], &prcm->cpu_pwroff,
-			   on, cpu);
+		/* Clear power gating */
+		clrbits_le32(pwroff, BIT(cpu));
+	} else {
+		/* Set power gating */
+		setbits_le32(pwroff, BIT(cpu));
+
+		/* Activate power clamp */
+		if (clamp)
+			clamp_set(clamp);
+	}
 }
-#endif /* CONFIG_MACH_SUN7I */
 
 void __secure sunxi_cpu_power_off(u32 cpuid)
 {
-- 
2.25.1

