Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A266E71D55
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 18:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E1387070;
	Sat, 30 Sep 2023 20:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e16EOZpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6D387082; Sat, 30 Sep 2023 20:34:35 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7798887078
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 20:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-351232a46b3so44232225ab.1
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696098872; x=1696703672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx5L91tagj9Q07euRqEwOq8+34Hqk1nLqSDt48KMUA0=;
 b=e16EOZpA8KKYRavwLe/ZCgMgm4eBYUCCbW/HLdOpnomVrvpEvjTA6nWhGpdkUmLIWN
 IHJCzvaZZVEAIZThzt8tcJ5+i4keFdo5paZ0/RJMEP8yRTUjCKEa2SJVx/Ypb/TR94JL
 zeMoPKD1viv2QZQGgJQIucM3uiH1YcPbpmnfgbf0qawivZMusJOseZ9dzIYeF/119W47
 9w50gRx6bO1b4eZelgn3oq/PVkmIV2nrz8pUgH3FOnfj1kxwDG1MGCOiwGmi/1f0uK1s
 wWZK2rcrBLWnaBu06kA+gLBYeGIObHbr2w46hJjoXq6lb3lyxxwa9tlAmZhMnyWT9ZSZ
 upZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696098872; x=1696703672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx5L91tagj9Q07euRqEwOq8+34Hqk1nLqSDt48KMUA0=;
 b=Yr99bJmbCz/W3QrOJWa1imGb14IOa3BnDBhnwPoAWZamNXrS4F42949YCarz+t7YrW
 GOuMfVkBmhi204vD/wSo/7v/M1nB3UFJGx4IF4q2bNwAqATZDsfIeYtwXaTNRrsdRs3C
 r3zdkn4vmIp7MTAxvNFqNnQ+dpn2kSRKutnDFg8C0N1u9lcelkhCfqEnvx6P9+TraDEf
 HDusCkHo8Pfn81gItHxQQTR0n6Iu2zpXinlfEhWOBUFsZNBfJtolcx3jKIo0wQxzB2K3
 UjDNAr568bnsTROjiMpt+N668GTSZXSt8/ZWXlZULuPz42LoJh+0FgSumFkiJMrElP55
 OoYw==
X-Gm-Message-State: AOJu0Yxm4wE+EPvmC2L8geWWd89MJkKKZ747rI53yWUmzmBbDgH2xxly
 oSAuLu7KE/WWL2QhyrDN6UkLyfvPMZGdbA==
X-Google-Smtp-Source: AGHT+IHD+rfVr3k6xihd/2PxT2x5vCLqO9P1r3NhSca3/1nCWvSFq8RfOZh3fdJEDVRGogfC0L1q+A==
X-Received: by 2002:a05:6e02:1ca8:b0:34f:75eb:f81 with SMTP id
 x8-20020a056e021ca800b0034f75eb0f81mr9785261ill.5.1696098871694; 
 Sat, 30 Sep 2023 11:34:31 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:adc8:be74:9e0d:a666])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a056638030500b0043a1fe337b9sm5999140jap.170.2023.09.30.11.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:34:31 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 1/4] sunxi: psci: clean away preprocessor macros
Date: Sat, 30 Sep 2023 12:34:21 -0600
Message-ID: <20230930183424.806520-2-CFSworks@gmail.com>
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

