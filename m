Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52437E728E1
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 18:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9367187099;
	Sat, 30 Sep 2023 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T0dAykAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604C387087; Sat, 30 Sep 2023 20:34:39 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB74D87078
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 20:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35133097583so40424925ab.1
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696098874; x=1696703674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLrVFcsj8BkqsdnHpocaQ3GfWMKRKzRGi1x6zIaQvn0=;
 b=T0dAykASgSt9i08e3S0i1ng57SCOPlELcqbcQdgn9CyYQtrT/oi1e8Taga7ZedGusx
 0OjTIKMa29gRyzktLJvfQbOf6v08aVghqEPrNsa7cwLy8Bd+Hb30DwQO1yEqvmB8ckQD
 swr8Wba5fRj7yYxPhGThAKCWsHoxlH69lVjNe0VMGmxqETxYHalqm6ziVRlaQhItAmvV
 ymjNyZEFpUqYPEfDUtvncn7m4zwPaIqptXlEQM/W/jI7dMnZGoBDH2+ZqapNNcFWP1Q0
 3NS3E+hGcwhJV7j8Htb3gx4xsKq/gFV1ghixx5tLL4sGt/MvNhNr9NRdIE1omAPlhIaR
 2qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696098874; x=1696703674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLrVFcsj8BkqsdnHpocaQ3GfWMKRKzRGi1x6zIaQvn0=;
 b=gOERK/jfaSXdxkCTHk3ncI9tqIKkHNiH89ZWLNZc9gK4isOxBNOoaP6M+V3d6crvH0
 XUnHYEG6a4G3jdpI5OHoNFjseeGjbMqrzfJeXMrRNPr/xBB8O933dKu1gMcVr/DfXrgL
 4H31GpLelrelBTg2h+9GsUKw+K2vgtXFmeT16J1NxIaqP0ycANzWWWzGPRvyW7Qfnn4u
 pa8g3vKp+Bk6dFdZKrRYwKIllgfckEPuUFWrVjHAkkF5mJH+lJEpgBEDEknJMsfGqqef
 CShP+ecmKY5cVI4O2Qoa8tSd/PVroAPGrcCD5gJBvPkwQ34ZEhJh3i9VXbFNjmgDdcv4
 Yk3g==
X-Gm-Message-State: AOJu0YxbfPyipi2qcSe7kIPqMLRHHetDUXHDGysNgLxEhqlRb+8rHqOz
 +A1g2u1Qq/M5LexU+pFNtJA3K0owTPj8Ug==
X-Google-Smtp-Source: AGHT+IG1JGqy9XLZ+92VvQ7QDjGw8UqnQhGWZ16hapaD3dSHHFe0wQv9QiIwMxZO5kH0PCx7kJPFmA==
X-Received: by 2002:a05:6e02:1a41:b0:352:6251:2364 with SMTP id
 u1-20020a056e021a4100b0035262512364mr6061791ilv.11.1696098874188; 
 Sat, 30 Sep 2023 11:34:34 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:adc8:be74:9e0d:a666])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a056638030500b0043a1fe337b9sm5999140jap.170.2023.09.30.11.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:34:33 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>,
 Kevin Amadiva <kevin.amadiva@mec.at>
Subject: [PATCH v3 4/4] sunxi: psci: implement PSCI on R528
Date: Sat, 30 Sep 2023 12:34:24 -0600
Message-ID: <20230930183424.806520-5-CFSworks@gmail.com>
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

This patch adds the necessary code to make nonsec booting and PSCI
secondary core management functional on the R528/T113.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Maksim Kiselev <bigunclemax@gmail.com>
Tested-by: Kevin Amadiva <kevin.amadiva@mec.at>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 47 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-sunxi/Kconfig     |  4 +++
 include/configs/sunxi-common.h  |  8 ++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

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

