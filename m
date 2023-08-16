Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0EBC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0409F869F1;
	Wed, 16 Aug 2023 19:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aO8/LmCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C75A86A07; Wed, 16 Aug 2023 19:34:32 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30EFD869BF
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso46229205ad.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692207267; x=1692812067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ShPDLJY8uSXeaV47yOPewTpAyM2R7f/rgl/FYTjfnw=;
 b=aO8/LmCGd3xLSKKUSM8KRtWTtgdqaCDQ+kRmt866xXq9B/BLRXEkLMvxuqbahuczPf
 pvdNhrku9Qb80xOXjJ3mpXnc1WUrQjCOuXRlf/nigYdFLPs/NnOFPW3t1bWS9oE8pGFq
 niI8WPNnpjzCtsvpO7tqroUTlHo1kAasy9YTKnUQbtTBeMX7Xnazeyifk0kG6asJRrzt
 WQgs2Ok/VL/cFuoQwiUhDzwFiYFrV88YXYJ2uSuSwCbEBYXNag1+iIWIc1ydW+wrpXIj
 MDcZP0oLEeRY8qWJm/W0NjGTEVfTMPsj+DN3n4hXVWKFtPt77J/5frmRt/BV9QLiR8MA
 rilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692207267; x=1692812067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ShPDLJY8uSXeaV47yOPewTpAyM2R7f/rgl/FYTjfnw=;
 b=Gzgk3Bbk/cez9S62HMd1OYXTQZ9aSwVx3dFCP8h1o6Q4VxjFIECBoiXsVblfgCs7RO
 jZhhB7llJ1+iIfE54qEmnBJw+DichN2jjUupZIIqSCWbFLZN4NLC5ZGW8zWFcgSQ1Wnc
 Opm8Wtzv+bt5AKZOZ7p6cmhCS+G1O3N2+71BZcogGe6pxoMPdbDkmVOv7WjY4Vt6nyu7
 6uYtNRUiV2oT71vbwpMrkJhqkhIh2w24ANwibMF59K5Be5QxZKEyTFwUO5CoDSv7ML2I
 83Yjb8EJFNDaEB/EaCX4WrHVCctiztz0M6dJdGlcfZ2eZIqohMhmkkIzJr0jd+BArklo
 3X2g==
X-Gm-Message-State: AOJu0YzJbkX6+LH0unoEOplVofeU4Y7jCmCKGOvsUeX9gvXb7+C6A1vx
 Vxzzfi6iWA61HWSjQkVF3YL8fG3HffWurA==
X-Google-Smtp-Source: AGHT+IHLvJAyIQDzTuSTViI+glCnlmRryeNNVykeWdvmI4yHkwI2+8hIMvyGl4C+OUcMCVXpz114pw==
X-Received: by 2002:a17:902:f7c9:b0:1bc:9c49:f8bc with SMTP id
 h9-20020a170902f7c900b001bc9c49f8bcmr2423091plw.8.1692207267104; 
 Wed, 16 Aug 2023 10:34:27 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1709028f8500b001b8a7e1b116sm13338631plo.191.2023.08.16.10.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 10:34:26 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 1/5] sunxi: psci: clean away preprocessor macros
Date: Wed, 16 Aug 2023 10:34:16 -0700
Message-ID: <20230816173420.83232-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816173420.83232-1-CFSworks@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
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

This patch restructures psci.c to get away from the "many different
function definitions switched by #ifdef" paradigm to the preferred style
of having a single function definition with `if (IS_ENABLED(...))` to
make the optimizer include only the appropriate function bodies instead.

There are no functional changes here.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 102 +++++++++++++-------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index e1d3638b5c..7804e0933b 100644
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
@@ -88,83 +85,68 @@ static void __secure clamp_release(u32 __maybe_unused *clamp)
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
2.41.0

