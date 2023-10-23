Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F0C00A8F
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F73B87923;
	Mon, 23 Oct 2023 15:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE83287968; Mon, 23 Oct 2023 15:25:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 828BF87964
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAB69C15;
 Mon, 23 Oct 2023 06:26:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0473F762;
 Mon, 23 Oct 2023 06:25:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 22/24] sunxi: psci: stop modeling register layout with C
 structs
Date: Mon, 23 Oct 2023 14:24:47 +0100
Message-Id: <20231023132449.813863-23-andre.przywara@arm.com>
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

Since the sunxi support nowadays generally prefers #defined register
offsets instead of modeling register layouts using C structs, now is a
good time to do this for PSCI as well. This patch moves away from using
the structs `sunxi_cpucfg_reg` and `sunxi_prcm_reg` in psci.c.

The former struct and its associated header file existed only to support
PSCI code, so also delete them altogether.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c          | 57 ++++++++------------
 arch/arm/include/asm/arch-sunxi/cpucfg.h | 67 ------------------------
 2 files changed, 23 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 27ca9c39e18..207aa6bc4bf 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -11,8 +11,6 @@
 #include <asm/cache.h>
 
 #include <asm/arch/cpu.h>
-#include <asm/arch/cpucfg.h>
-#include <asm/arch/prcm.h>
 #include <asm/armv7.h>
 #include <asm/gic.h>
 #include <asm/io.h>
@@ -27,6 +25,17 @@
 #define	GICD_BASE	(SUNXI_GIC400_BASE + GIC_DIST_OFFSET)
 #define	GICC_BASE	(SUNXI_GIC400_BASE + GIC_CPU_OFFSET_A15)
 
+/*
+ * Offsets into the CPUCFG block applicable to most SUNXIs.
+ */
+#define SUNXI_CPU_RST(cpu)			(0x40 + (cpu) * 0x40 + 0x0)
+#define SUNXI_CPU_STATUS(cpu)			(0x40 + (cpu) * 0x40 + 0x8)
+#define SUNXI_GEN_CTRL				(0x184)
+#define SUNXI_PRIV0				(0x1a4)
+#define SUN7I_CPU1_PWR_CLAMP			(0x1b0)
+#define SUN7I_CPU1_PWROFF			(0x1b4)
+#define SUNXI_DBG_CTRL1				(0x1e4)
+
 /*
  * R40 is different from other single cluster SoCs.
  *
@@ -99,10 +108,7 @@ static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
 		writel((u32)entry,
 		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
 	} else {
-		struct sunxi_cpucfg_reg *cpucfg =
-			(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
-
-		writel((u32)entry, &cpucfg->priv0);
+		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
 	}
 }
 
@@ -110,26 +116,21 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 {
 	u32 *clamp = NULL;
 	u32 *pwroff;
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
 
 	/* sun7i (A20) is different from other single cluster SoCs */
 	if (IS_ENABLED(CONFIG_MACH_SUN7I)) {
-		clamp = &cpucfg->cpu1_pwr_clamp;
-		pwroff = &cpucfg->cpu1_pwroff;
+		clamp = (void *)SUNXI_CPUCFG_BASE + SUN7I_CPU1_PWR_CLAMP;
+		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN7I_CPU1_PWROFF;
 		cpu = 0;
 	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
-		clamp = (void *)cpucfg + SUN8I_R40_PWR_CLAMP(cpu);
-		pwroff = (void *)cpucfg + SUN8I_R40_PWROFF;
+		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
+		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
 	} else {
-		struct sunxi_prcm_reg *prcm =
-			(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
-
 		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
 		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
-			clamp = &prcm->cpu_pwr_clamp[cpu];
+			clamp = (void *)SUNXI_PRCM_BASE + 0x140 + cpu * 0x4;
 
-		pwroff = &prcm->cpu_pwroff;
+		pwroff = (void *)SUNXI_PRCM_BASE + 0x100;
 	}
 
 	if (on) {
@@ -151,37 +152,25 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 
 static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
 {
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
-
-	writel(reset ? 0b00 : 0b11, &cpucfg->cpu[cpu].rst);
+	writel(reset ? 0b00 : 0b11, SUNXI_CPUCFG_BASE + SUNXI_CPU_RST(cpu));
 }
 
 static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
 {
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
-
 	if (lock)
-		clrbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+		clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_DBG_CTRL1, BIT(cpu));
 	else
-		setbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+		setbits_le32(SUNXI_CPUCFG_BASE + SUNXI_DBG_CTRL1, BIT(cpu));
 }
 
 static bool __secure sunxi_cpu_poll_wfi(int cpu)
 {
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
-
-	return !!(readl(&cpucfg->cpu[cpu].status) & BIT(2));
+	return !!(readl(SUNXI_CPUCFG_BASE + SUNXI_CPU_STATUS(cpu)) & BIT(2));
 }
 
 static void __secure sunxi_cpu_invalidate_cache(int cpu)
 {
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
-
-	clrbits_le32(&cpucfg->gen_ctrl, BIT(cpu));
+	clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_GEN_CTRL, BIT(cpu));
 }
 
 static void __secure sunxi_cpu_power_off(u32 cpuid)
diff --git a/arch/arm/include/asm/arch-sunxi/cpucfg.h b/arch/arm/include/asm/arch-sunxi/cpucfg.h
deleted file mode 100644
index 4aaebe0a976..00000000000
--- a/arch/arm/include/asm/arch-sunxi/cpucfg.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Sunxi A31 CPUCFG register definition.
- *
- * (C) Copyright 2014 Hans de Goede <hdegoede@redhat.com
- */
-
-#ifndef _SUNXI_CPUCFG_H
-#define _SUNXI_CPUCFG_H
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-
-#ifndef __ASSEMBLY__
-
-struct __packed sunxi_cpucfg_cpu {
-	u32 rst;		/* base + 0x0 */
-	u32 ctrl;		/* base + 0x4 */
-	u32 status;		/* base + 0x8 */
-	u8 res[0x34];		/* base + 0xc */
-};
-
-struct __packed sunxi_cpucfg_reg {
-	u8 res0[0x40];		/* 0x000 */
-	struct sunxi_cpucfg_cpu cpu[4];		/* 0x040 */
-	u8 res1[0x44];		/* 0x140 */
-	u32 gen_ctrl;		/* 0x184 */
-	u32 l2_status;		/* 0x188 */
-	u8 res2[0x4];		/* 0x18c */
-	u32 event_in;		/* 0x190 */
-	u8 res3[0xc];		/* 0x194 */
-	u32 super_standy_flag;	/* 0x1a0 */
-	u32 priv0;		/* 0x1a4 */
-	u32 priv1;		/* 0x1a8 */
-	u8 res4[0x4];		/* 0x1ac */
-	u32 cpu1_pwr_clamp;	/* 0x1b0 sun7i only */
-	u32 cpu1_pwroff;	/* 0x1b4 sun7i only */
-	u8 res5[0x2c];		/* 0x1b8 */
-	u32 dbg_ctrl1;		/* 0x1e4 */
-	u8 res6[0x18];		/* 0x1e8 */
-	u32 idle_cnt0_low;	/* 0x200 */
-	u32 idle_cnt0_high;	/* 0x204 */
-	u32 idle_cnt0_ctrl;	/* 0x208 */
-	u8 res8[0x4];		/* 0x20c */
-	u32 idle_cnt1_low;	/* 0x210 */
-	u32 idle_cnt1_high;	/* 0x214 */
-	u32 idle_cnt1_ctrl;	/* 0x218 */
-	u8 res9[0x4];		/* 0x21c */
-	u32 idle_cnt2_low;	/* 0x220 */
-	u32 idle_cnt2_high;	/* 0x224 */
-	u32 idle_cnt2_ctrl;	/* 0x228 */
-	u8 res10[0x4];		/* 0x22c */
-	u32 idle_cnt3_low;	/* 0x230 */
-	u32 idle_cnt3_high;	/* 0x234 */
-	u32 idle_cnt3_ctrl;	/* 0x238 */
-	u8 res11[0x4];		/* 0x23c */
-	u32 idle_cnt4_low;	/* 0x240 */
-	u32 idle_cnt4_high;	/* 0x244 */
-	u32 idle_cnt4_ctrl;	/* 0x248 */
-	u8 res12[0x34];		/* 0x24c */
-	u32 cnt64_ctrl;		/* 0x280 */
-	u32 cnt64_low;		/* 0x284 */
-	u32 cnt64_high;		/* 0x288 */
-};
-
-#endif /* __ASSEMBLY__ */
-#endif /* _SUNXI_CPUCFG_H */
-- 
2.25.1

