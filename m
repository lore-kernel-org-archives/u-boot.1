Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047C1E71D55
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 18:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B06487090;
	Sat, 30 Sep 2023 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UkyZTH5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E5E8634D; Sat, 30 Sep 2023 20:34:38 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EA78634D
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 20:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35255c1a448so9655285ab.3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696098873; x=1696703673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jMAjZHhtH/r+ntm3YDcGrtTvFeO6dL2cv8EQOTmEA0=;
 b=UkyZTH5UeJrtcwfWt/XmiB6VJtOH4SacL9YPwv4aYHZMJKqjckAP4Kkvwz27UZib+i
 DVJyw6WYlF8f5145ob/2hSytfMmQrFW/jy1X/aWgdOTme1OZuvKjQssAmdXzFWgV73/N
 6DDnre8YyhW7576yfaoPP5eDQZiAOHYI6xOUiaf9mh92wr3ZMZnA2T8GTlvn639hgVIo
 3WFbnxFMSLeNVV9a8U7brHKenRPIZvVLgMY18ttVJVod0trvFY1zTzgEbkLwvz+mAiwk
 thToD3FPZ/lKVhstxOVsOHGaRKX8GTSWb3U94Sq0PXTgrEVK966DJxUYrq32uWGTOUGJ
 /iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696098873; x=1696703673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jMAjZHhtH/r+ntm3YDcGrtTvFeO6dL2cv8EQOTmEA0=;
 b=VfT/FZ0n1TtRJr8a0hGJoPJdjgKpWEFlNA1GSEKoSSCqFgPZGXox9nhkze4yqoRH0w
 Pu7v0tDrMu2xJUdkgznr9WbOQafHmZeAWutRPv2CyCsH7ZHUJoBD3YNWAvl+UpfVZuLg
 WvyN/z99hfQXoG9pS/21ld7iEADK4/9yAkK5rd9sp7JYoQX+6yd5rExKI4jejN9q2wMe
 i0Yj2aVaVqxZa6ZCtMQGiREiOOO0Z7G+p/n+Qr5jdKaQcohBpXk6vww/CrqHdqeoQiPZ
 /4SfOwxdZeANI5jzLq5p+8+RlnbWj1/Gc5ExvFEYXq7Voq6B5rh0/w5ENSEDE+pecLpt
 6hfQ==
X-Gm-Message-State: AOJu0YyhKkL8k7W6HEFi0WkRBPURqIU20nqQ3QwCKD/KVfhoMCa4qHEN
 eIz7CdH+3TNKKqqpd5AtEDWvtXJj3Bhs/g==
X-Google-Smtp-Source: AGHT+IGvYL6FYvNaqDuKfA5/poAWoMWpEPrCPxVOArUbIGnO1ZVM60jLIzR0CDy0VFtXg+l1XCCaAQ==
X-Received: by 2002:a05:6e02:b41:b0:34b:ae46:8040 with SMTP id
 f1-20020a056e020b4100b0034bae468040mr8948160ilu.5.1696098873331; 
 Sat, 30 Sep 2023 11:34:33 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:adc8:be74:9e0d:a666])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a056638030500b0043a1fe337b9sm5999140jap.170.2023.09.30.11.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:34:32 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 3/4] sunxi: psci: stop modeling register layout with C
 structs
Date: Sat, 30 Sep 2023 12:34:23 -0600
Message-ID: <20230930183424.806520-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930183424.806520-1-CFSworks@gmail.com>
References: <20230930183424.806520-1-CFSworks@gmail.com>
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

