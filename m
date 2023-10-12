Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF355CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 01:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8671E86B9E;
	Thu, 12 Oct 2023 03:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m38MqV0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C7486CA4; Thu, 12 Oct 2023 03:48:28 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D086886CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3528bc102adso1510805ab.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075292; x=1697680092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jMAjZHhtH/r+ntm3YDcGrtTvFeO6dL2cv8EQOTmEA0=;
 b=m38MqV0FKra+LgnPsnSog2O13OhqgVFzz5NADeMM11wkmRyPL9XRuLHRepBw7FsyVp
 B/bnCpNKMJsMlHPjG//+raa0OeCivvDXOYkfR93jp38Vvuord221Js87ok/6+2egYA9C
 VSUCzd2wvg7aMUZ+mddCsCv+Yn+MKSs054LqziX2m/IHJh5eUYLQxmRNERfysmgtDAU0
 qKsTPIZrfrxsdbx6DLQmxedHihrSlVR4T/JrPN9di0t6LQkIzQfy88V6MdS5/nz5G+sr
 fSut6nDqkpH8c5rsu0u13xg0LaAcfg3nCdASR0sNEjMcrABpAUa5rxbT/IWEBuG+6usJ
 srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075292; x=1697680092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jMAjZHhtH/r+ntm3YDcGrtTvFeO6dL2cv8EQOTmEA0=;
 b=SJWlIZUrZfoIddrUk8B87YTmToIjT5rpYIauB9q2ze7qVbco2EadAXdjqLGC9/hXi4
 HuNSRUpt5mHo8njfnUWNJxguJKFJYjvzKHbgI73u2+mSHMZfa9CXsOo5DxE6aVAHi+WW
 cfzEnFPvBEPu6dXRoWRs+0g6aj1gk1R6WA1oehacWXFWR25MRRs1zs51WOtBtxFd9As4
 BeA0yquLTnE2UD8Ny3pecFL5nLAA5TruIOn0h/pP9gWQDPsX8jQJGzIdlGA82sqBN4Jg
 nb769EzcAM8GQFj+ePua7kx7N5ZDTp0BUF0CjRFdnbqvZo8LfY9uXTcsy8e8EoyS18FU
 1JEw==
X-Gm-Message-State: AOJu0YzEWWZqQ5+r5qMTkieEPNT7FoCtdTX8NbAkumFQTK+JzlxQ4kdJ
 v4cgx9DnK5tmjJYkgGSGik3qDZbh4pt7og==
X-Google-Smtp-Source: AGHT+IGYRvdnmG83Q8qOrzNZYn31rbZvMu1i+3hJsPes9OJpwNemfWYj/4rxiH9yTSOzOXGB5AmEHg==
X-Received: by 2002:a05:6e02:216c:b0:352:a73a:16f1 with SMTP id
 s12-20020a056e02216c00b00352a73a16f1mr26731133ilv.14.1697075292094; 
 Wed, 11 Oct 2023 18:48:12 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9691:dae3:83ae:38dd])
 by smtp.gmail.com with ESMTPSA id
 gn6-20020a0566382c0600b0043a1fe337b9sm3676422jab.170.2023.10.11.18.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 18:48:11 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v4 3/4] sunxi: psci: stop modeling register layout with C
 structs
Date: Wed, 11 Oct 2023 19:47:55 -0600
Message-ID: <20231012014756.2573473-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012014756.2573473-1-CFSworks@gmail.com>
References: <20231012014756.2573473-1-CFSworks@gmail.com>
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

Since the sunxi support nowadays generally prefers #defined register
offsets instead of modeling register layouts using C structs, now is a
good time to do this for PSCI as well. This patch moves away from using
the structs `sunxi_cpucfg_reg` and `sunxi_prcm_reg` in psci.c.

The former struct and its associated header file existed only to support
PSCI code, so also delete them altogether.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c          | 57 ++++++++------------
 arch/arm/include/asm/arch-sunxi/cpucfg.h | 67 ------------------------
 2 files changed, 23 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-sunxi/cpucfg.h

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 27ca9c39e1..207aa6bc4b 100644
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
index 4aaebe0a97..0000000000
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
2.41.0

