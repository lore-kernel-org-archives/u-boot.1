Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4483EC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF15786A18;
	Wed, 16 Aug 2023 19:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2nw5PCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3269286A22; Wed, 16 Aug 2023 19:34:36 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B57586A0B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so1709755ad.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692207271; x=1692812071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leOX7dsWoJvcEqaNNnviq7mh1hPhMEQn4K+Fyq0rb4s=;
 b=h2nw5PCZqIgau8TLDl5nOJtOON4953bEVVslPuqBVQE3+wr1ujVP29Hx9b5goTjXwd
 FBPECRj8qSn/+tkAa/jbqfObIEALO+F10xgBeilJg3C1pfD03yHSth1VyF2geFIrbdCO
 uZ4l0X1LJ4qPIBjHC+WRfxoa/G8+CDzBEuGMGocu2OdnxEQZyx6C6nabf5cMUnnQfBb9
 IDi8A5tpBDR3emlL42vUuz0SsSidMxhiL75su/e964lYgvnpIkctzk+FaXdMHYDSaiB/
 Xonx/1KrbQXr5ZIeJazPWw3tbnjfkYQ2kZmzH32EGWsTXDwHrVSQMvdsEYGTv/kbBHTa
 pE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692207271; x=1692812071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leOX7dsWoJvcEqaNNnviq7mh1hPhMEQn4K+Fyq0rb4s=;
 b=GRxi5NLaUGbn7OMVotCvCNA2nbGSCovLOG2SOImAyb/IGN/YTEpuvxqjt3uWwQjxoy
 tNeEt0qqTfzGcGaC8MEs2KYnMa0EF6EN8NzGlV1zRTN1SzWzq0ChL8HljNg5xrzd7/m1
 1AEEB/BMR+ZHt7rG5C8Mhj4W6jmw/ygA/ZYbSNtv6X6XZG7dOUeSTF2CzrylT+CvRU/x
 9YDXNYqiSpKrzj9OEuypv1Nx/KAVpg1NPfwbvUl2b0bai3sTxQYNhOeoePXXK/BmxGd6
 N8hKer3nGBnc+W0bXZeUiEU7/e3EcxGzbVE85Cpp8mnWBOJ/4ITMDJUP0apSMHZIGtCp
 jnLg==
X-Gm-Message-State: AOJu0YwxUqD8tc2hYDMvqgV5rw8/pZ/QYMtJ+3mMb/dUEFrHIK9ZWn86
 eQ2VTdBkQXlWTCFjygNsZrVbuKQnIpYXrQ==
X-Google-Smtp-Source: AGHT+IEdSkFWhqaCo/9NasqcKkQy5xHQds78XixcjO/RcFygmhLn+tsILZ8aPEwQ4uw221Fp61dFMA==
X-Received: by 2002:a17:902:64c2:b0:1bc:2bd:852a with SMTP id
 y2-20020a17090264c200b001bc02bd852amr2753919pli.42.1692207271075; 
 Wed, 16 Aug 2023 10:34:31 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1709028f8500b001b8a7e1b116sm13338631plo.191.2023.08.16.10.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 10:34:30 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 4/5] sunxi: psci: implement PSCI on R528
Date: Wed, 16 Aug 2023 10:34:19 -0700
Message-ID: <20230816173420.83232-5-CFSworks@gmail.com>
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

This patch adds the necessary code to make nonsec booting and PSCI
secondary core management functional on the R528/T113.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 48 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-sunxi/Kconfig     |  2 ++
 include/configs/sunxi-common.h  |  8 ++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 6ecdd05250..b4ce4f6def 100644
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
@@ -103,10 +116,13 @@ static void __secure clamp_set(u32 *clamp)
 
 static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
 {
-	/* secondary core entry address is programmed differently on R40 */
+	/* secondary core entry address is programmed differently on R40/528 */
 	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
 		writel((u32)entry,
 		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		writel((u32)entry,
+		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
 	} else {
 		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
 	}
@@ -124,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
 		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
 		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		/* R528 leaves both cores powered up, manages them via reset */
+		return;
 	} else {
 		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
 		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
@@ -151,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 
 static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
+		if (reset) {
+			clrbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
+				     BIT(cpu));
+		} else {
+			setbits_le32(SUNXI_CPUCFG_BASE + SUN8I_R528_C0_RST_CTRL,
+				     BIT(cpu));
+		}
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
@@ -164,11 +199,22 @@ static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
 
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
index 0a3454a51a..d46fd8c0bc 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -355,6 +355,8 @@ config MACH_SUN8I_R40
 config MACH_SUN8I_R528
 	bool "sun8i (Allwinner R528)"
 	select CPU_V7A
+	select CPU_V7_HAS_NONSEC
+	select ARCH_SUPPORT_PSCI
 	select SUNXI_GEN_NCAT2
 	select SUNXI_NEW_PINCTRL
 	select MMC_SUNXI_HAS_NEW_MODE
diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index b8ca77d031..67eb0d25db 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -33,6 +33,14 @@
 
 /* CPU */
 
+/*
+ * Newer ARM SoCs have moved the GIC, but have not updated their ARM cores to
+ * reflect the correct address in CBAR/PERIPHBASE.
+ */
+#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
+#define CFG_ARM_GIC_BASE_ADDRESS	0x03020000
+#endif
+
 /*
  * The DRAM Base differs between some models. We cannot use macros for the
  * CONFIG_FOO defines which contain the DRAM base address since they end
-- 
2.41.0

