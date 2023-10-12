Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF65CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 01:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2533986CC9;
	Thu, 12 Oct 2023 03:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g0xJXZl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E1F86D0A; Thu, 12 Oct 2023 03:48:20 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E47D86B9E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso22267139f.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075290; x=1697680090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx5L91tagj9Q07euRqEwOq8+34Hqk1nLqSDt48KMUA0=;
 b=g0xJXZl4RzQZihvsf5tMZlX66ma3NQ/Ua3dg/b5RZxhAKbFKo77k/KVRy1o3Ge7epC
 3fVWG7v3Oflym9JuYHbTCmikmrldWJ2bV1aWepjTWGwLoZP29BgfC5ZjCAS19qlWGE+6
 RCVNOXdzGcOkMQVHo5xpSQTzpkxXBEvs8dcPqH7P9ob07Ax12TRN0/YAMN8IOy52U3or
 W9V6+9LfdojAthWDilvG4e5PMGFkAQi149on59yRyb/2BqIk5Ii1avQTCZtgWkrhMf6O
 oVZ3iX4+MRbKZSMSQdrihTmfRSsid2sqjNuoNiO0s+8CXhGxF69X8Daj+PoTiLSP9DS1
 kepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075290; x=1697680090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx5L91tagj9Q07euRqEwOq8+34Hqk1nLqSDt48KMUA0=;
 b=WREp3AW6HcqewNu858ZrpuX6KDGHD228ZDEeLAqVpC56l5o3XjOYY7Jxa3De+OKMQa
 y+MGZaOlGiHDk/z7Mq53QKPv+V4svHchHp7JkHHoWJX9i0csyZLfCFOua/wfkYJjBr6o
 0JpOA3kUmtXzdzqejnEMn4l890idiWTzywLXWMMZIAx1rmfVaNHFgVpG23wxmpsX/570
 ciFqzPh38Y+CRcRYUHWlV9GY3mtrZ0iPXTJYLUahDRgEZ+PKUabBx1bpfHRSJ450YQ1x
 HHK02eUETcRIi+rx5KAvclLTonRIOgSVkCP2kBDOQ0zvAvxrrXtxoFJuQkeMCbrM0wjz
 5Oqw==
X-Gm-Message-State: AOJu0Yz3qAl694MGYpIQefAeDgfjRZgeAdbRzg6NbbH35Dut/UhVxpBY
 AADjh/n7QmnwCDm4NBaFmAd2T7Jr+kvkGw==
X-Google-Smtp-Source: AGHT+IFJQtNWPAXsJ770YOYSvxxgX52qHOku2vnOmY9gI1uxp+Rt5gV7V99MuUby7k1yUbdnbBpCMA==
X-Received: by 2002:a05:6602:228a:b0:79f:a25b:51c with SMTP id
 d10-20020a056602228a00b0079fa25b051cmr24461901iod.11.1697075290445; 
 Wed, 11 Oct 2023 18:48:10 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9691:dae3:83ae:38dd])
 by smtp.gmail.com with ESMTPSA id
 gn6-20020a0566382c0600b0043a1fe337b9sm3676422jab.170.2023.10.11.18.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 18:48:09 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v4 1/4] sunxi: psci: clean away preprocessor macros
Date: Wed, 11 Oct 2023 19:47:53 -0600
Message-ID: <20231012014756.2573473-2-CFSworks@gmail.com>
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
index e1d3638b5c..69fa3f3c2e 100644
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
2.41.0

