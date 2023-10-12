Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F0FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 01:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E026F86D86;
	Thu, 12 Oct 2023 03:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLs1XgrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8698071F; Thu, 12 Oct 2023 03:48:33 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A517186D12
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so18812339f.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075293; x=1697680093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SebXKM+u+3QoxThKKqsstGgxGvLDtAZBmohqghsfRU=;
 b=WLs1XgrQQu3nfrK45b3KcSQaQWAtViWz6B06wAHDBEvoRXmKmZ73nXi/yrE4V1a0q9
 euQKCnpMm9xM/exXcc9evqF1ZFiEA0ZPTkoW2ON2UHNYUcu2Oyu8xl0VsWWhnP3ym4l6
 7r8jBRyw3lEdyRKVQnvz6ITmwpa6IF8v26fDtyuEEtuw4+P7tOnX8YFzZxfumzzdk0Pb
 z4Nxy2MGpWnHEv7C7onhqn/aaGmtXzudNcd4YGn3QOIGCv8l3QLtftY46tmKceKE2ARS
 GF734wYYD1Rf1Ea/ERT5SJnA1bmT048/GUFLcybgzPRavCBzkOoLDD55jhaeHZeBGN2R
 1YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075293; x=1697680093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SebXKM+u+3QoxThKKqsstGgxGvLDtAZBmohqghsfRU=;
 b=ZTOTbc3igur4APPttth2yDKT6RBtgPnGKFUWtZGgzhBxQg6bJfODwAxExl/ZpRgNFm
 RIBgqq1HIPDZg2g31vdki8zz9AorNQDqHWEiYTNGMqcNxUuxYbUfM1XQkRAU9pFJ0qiX
 ekNY5RJQSzuWZWjq8SaBCdgmbt94HbRWmh7NSSsp8hrOzgiowiXA93r7uTUpSQeQz4Cn
 B6gsSaJeo0iUlDRnmlV92FNkfxpuRVAf04B9YOMo24fLpnWQGWLXULrkUxfEEdBMOM1F
 T0MpbszzI/632VOYItp/qNuhOl9JpYxmXljKdeBx2VtKMJKHQArBVwfXaoFzU2nmjVOK
 hWvw==
X-Gm-Message-State: AOJu0YztFyli/msWwybBrdSCysWt8sseG+MKMeFn3AhGYkSs6LMzovv4
 BjxPJ46/iXAuIShnyEr9j/X4D1ONZeNRFw==
X-Google-Smtp-Source: AGHT+IFChmkBdV2C7ZgSKW3rSZLVlR0nn9jB6FXEOEsVg17bZC60fuRSvWX3NAetwfMdDPUCcbl6Vg==
X-Received: by 2002:a92:cda2:0:b0:34d:ea35:842b with SMTP id
 g2-20020a92cda2000000b0034dea35842bmr28395802ild.27.1697075292945; 
 Wed, 11 Oct 2023 18:48:12 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9691:dae3:83ae:38dd])
 by smtp.gmail.com with ESMTPSA id
 gn6-20020a0566382c0600b0043a1fe337b9sm3676422jab.170.2023.10.11.18.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 18:48:12 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>,
 Kevin Amadiva <kevin.amadiva@mec.at>
Subject: [PATCH v4 4/4] sunxi: psci: implement PSCI on R528
Date: Wed, 11 Oct 2023 19:47:56 -0600
Message-ID: <20231012014756.2573473-5-CFSworks@gmail.com>
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

This patch adds the necessary code to make nonsec booting and PSCI
secondary core management functional on the R528/T113.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
Tested-by: Kevin Amadiva <kevin.amadiva@mec.at>
---
 arch/arm/cpu/armv7/Kconfig      |  3 ++-
 arch/arm/cpu/armv7/sunxi/psci.c | 47 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-sunxi/Kconfig     |  4 +++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index f015d133cb..4eb34b7b44 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -61,8 +61,9 @@ config ARMV7_SECURE_MAX_SIZE
 config ARM_GIC_BASE_ADDRESS
 	hex
 	depends on ARMV7_NONSEC
-	depends on ARCH_EXYNOS5
+	depends on ARCH_EXYNOS5 || MACH_SUN8I_R528
 	default 0x10480000 if ARCH_EXYNOS5
+	default 0x03020000 if MACH_SUN8I_R528
 	help
 	  Override the GIC base address if the Arm Cortex defined
 	  CBAR/PERIPHBASE system register holds the wrong value.
diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 207aa6bc4b..b03a865483 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -47,6 +47,19 @@
 #define SUN8I_R40_PWR_CLAMP(cpu)		(0x120 + (cpu) * 0x4)
 #define SUN8I_R40_SRAMC_SOFT_ENTRY_REG0		(0xbc)
 
+/*
+ * R528 is also different, as it has both cores powered up (but held in reset
+ * state) after the SoC is reset. Like the R40, it uses a "soft" entry point
+ * address register, but unlike the R40, it uses a newer "CPUX" block to manage
+ * CPU state, rather than the older CPUCFG system.
+ */
+#define SUN8I_R528_SOFT_ENTRY			(0x1c8)
+#define SUN8I_R528_C0_RST_CTRL			(0x0000)
+#define SUN8I_R528_C0_CTRL_REG0			(0x0010)
+#define SUN8I_R528_C0_CPU_STATUS		(0x0080)
+
+#define SUN8I_R528_C0_STATUS_STANDBYWFI		(16)
+
 static void __secure cp15_write_cntp_tval(u32 tval)
 {
 	asm volatile ("mcr p15, 0, %0, c14, c2, 0" : : "r" (tval));
@@ -103,10 +116,12 @@ static void __secure clamp_set(u32 *clamp)
 
 static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
 {
-	/* secondary core entry address is programmed differently on R40 */
 	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
 		writel((u32)entry,
 		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		writel((u32)entry,
+		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
 	} else {
 		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
 	}
@@ -125,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
 		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
 		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		/* R528 leaves both cores powered up, manages them via reset */
+		return;
 	} else {
 		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
 		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
@@ -152,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 
 static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		if (reset)
+			clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
+				     BIT(cpu));
+		else
+			setbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
+				     BIT(cpu));
+
+		return;
+	}
+
 	writel(reset ? 0b00 : 0b11, SUNXI_CPUCFG_BASE + SUNXI_CPU_RST(cpu));
 }
 
 static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		/* Not required on R528 */
+		return;
+	}
+
 	if (lock)
 		clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_DBG_CTRL1, BIT(cpu));
 	else
@@ -165,11 +199,22 @@ static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
 
 static bool __secure sunxi_cpu_poll_wfi(int cpu)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		return !!(readl(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_CPU_STATUS) &
+			  BIT(SUN8I_R528_C0_STATUS_STANDBYWFI + cpu));
+	}
+
 	return !!(readl(SUNXI_CPUCFG_BASE + SUNXI_CPU_STATUS(cpu)) & BIT(2));
 }
 
 static void __secure sunxi_cpu_invalidate_cache(int cpu)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_CTRL_REG0,
+			     BIT(cpu));
+		return;
+	}
+
 	clrbits_le32(SUNXI_CPUCFG_BASE + SUNXI_GEN_CTRL, BIT(cpu));
 }
 
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e891e291f1..23b5b27b97 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -355,6 +355,10 @@ config MACH_SUN8I_R40
 config MACH_SUN8I_R528
 	bool "sun8i (Allwinner R528)"
 	select CPU_V7A
+	select CPU_V7_HAS_NONSEC
+	select CPU_V7_HAS_VIRT
+	select ARCH_SUPPORT_PSCI
+	select SPL_ARMV7_SET_CORTEX_SMPEN
 	select SUNXI_GEN_NCAT2
 	select SUNXI_NEW_PINCTRL
 	select MMC_SUNXI_HAS_NEW_MODE
-- 
2.41.0

