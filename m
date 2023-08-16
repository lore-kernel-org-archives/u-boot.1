Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70DAC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4874086A1A;
	Wed, 16 Aug 2023 19:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JTchlCTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A87686A0E; Wed, 16 Aug 2023 19:34:33 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52712869E6
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68871bbfe33so1391983b3a.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692207268; x=1692812068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WwJX6gHE6G8AF+ESBU0uY4aaheTLK66oiPU1Pznnjs=;
 b=JTchlCTqF/fFKoo4RYp0MihewTT1l7qRDfEN7BH+LkgyZ0+w+wTsOWypptH6XoR7CL
 GHKzCMRMOS971qVKhzjyU++HBYGTShRxP0UncMZcyfqG6PfHz0gutK8Bn+F+246vn6lb
 brZbLI8q6zDJchu+qSGvxbF3Uso+ufSulTNbTBd4ng0jCx4lcNQJJCAYerDobF/KNy0E
 fU2itnDYLP+/WV9EHVGsv4ZL8BXbYoymmzhgOYlxRi5Mmj45jYYjcMnIhE/I/3jCMkhU
 fEI7SNnp6WlVKeZlqz2nLrKDZlZhWu1xeYb3dYeEKkjsJH00iKRebs2uFX3PGRFr6Psi
 sf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692207268; x=1692812068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WwJX6gHE6G8AF+ESBU0uY4aaheTLK66oiPU1Pznnjs=;
 b=FyE80OOf1DAXkvL5mFjme1oQOZKDrUOM6eWp2v97QQcsVjX5kxvBxjQSQ1rUBCZhN4
 rfJzaW6ExA4guHWlDGZQlUhvPoSotqcLP1GpaPjSukY+ee/DK7cNZjA1Ch2Yxx7COme8
 ZWdDT2JdD5nHfNdOQpTpwW+swzF2CDqIQs/wJg12dABhS90KBpD3IFoeslHIjphRvMF6
 7CbVDKq7VdQwmxK5StyPfiar44T5YRVZ5mOKX/sBXB7/nJXXoc6j53GQ5fjGQ2i7HXAL
 HzMDC4UxpmX3PFPP+rbVJzucaxWgr+aeEN2T9hNv88if+1OUwoVPDM098zaTSMTtV3Tw
 hRiA==
X-Gm-Message-State: AOJu0YxLaGiiLpQILiQwUnfT8C1kYkGm5T99PkbQJ/0+8SkyvEmKcAgu
 nu9ibcM2ZRbcyv/wg0RYmlpNPVY4vUP98g==
X-Google-Smtp-Source: AGHT+IHE5pyukGwf3+bUY89AjoshN0VCMDIGoLtLvbfxriCJrotBaVfTmmNqF7QK+KUAz4wtRjGzmg==
X-Received: by 2002:a05:6a20:7f8a:b0:140:694:cd99 with SMTP id
 d10-20020a056a207f8a00b001400694cd99mr3361102pzj.44.1692207268280; 
 Wed, 16 Aug 2023 10:34:28 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1709028f8500b001b8a7e1b116sm13338631plo.191.2023.08.16.10.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 10:34:27 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 2/5] sunxi: psci: refactor register access to separate
 functions
Date: Wed, 16 Aug 2023 10:34:17 -0700
Message-ID: <20230816173420.83232-3-CFSworks@gmail.com>
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

This is to prepare for R528, which does not have the typical
"CPUCFG" block; it has a "CPUX" block which provides these
same functions but is organized differently.

Moving the hardware-access bits to their own functions separates the
logic from the hardware so we can reuse the same logic.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 66 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 7804e0933b..e2845f21ab 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -92,7 +92,7 @@ static void __secure clamp_set(u32 *clamp)
 	writel(0xff, clamp);
 }
 
-static void __secure sunxi_set_entry_address(void *entry)
+static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
 {
 	/* secondary core entry address is programmed differently on R40 */
 	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
@@ -148,30 +148,60 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 	}
 }
 
-void __secure sunxi_cpu_power_off(u32 cpuid)
+static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
+{
+	struct sunxi_cpucfg_reg *cpucfg =
+		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+
+	writel(reset ? 0b00 : 0b11, &cpucfg->cpu[cpu].rst);
+}
+
+static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
 {
 	struct sunxi_cpucfg_reg *cpucfg =
 		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+
+	if (lock)
+		clrbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+	else
+		setbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+}
+
+static bool __secure sunxi_cpu_poll_wfi(int cpu)
+{
+	struct sunxi_cpucfg_reg *cpucfg =
+		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+
+	return !!(readl(&cpucfg->cpu[cpu].status) & BIT(2));
+}
+
+static void __secure sunxi_cpu_invalidate_cache(int cpu)
+{
+	struct sunxi_cpucfg_reg *cpucfg =
+		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+
+	clrbits_le32(&cpucfg->gen_ctrl, BIT(cpu));
+}
+
+void __secure sunxi_cpu_power_off(u32 cpuid)
+{
 	u32 cpu = cpuid & 0x3;
 
 	/* Wait for the core to enter WFI */
-	while (1) {
-		if (readl(&cpucfg->cpu[cpu].status) & BIT(2))
-			break;
+	while (!sunxi_cpu_poll_wfi(cpu))
 		__mdelay(1);
-	}
 
 	/* Assert reset on target CPU */
-	writel(0, &cpucfg->cpu[cpu].rst);
+	sunxi_cpu_set_reset(cpu, true);
 
 	/* Lock CPU (Disable external debug access) */
-	clrbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+	sunxi_cpu_set_locking(cpu, true);
 
 	/* Power down CPU */
 	sunxi_cpu_set_power(cpuid, false);
 
-	/* Unlock CPU (Disable external debug access) */
-	setbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+	/* Unlock CPU (Reenable external debug access) */
+	sunxi_cpu_set_locking(cpu, false);
 }
 
 static u32 __secure cp15_read_scr(void)
@@ -228,33 +258,31 @@ out:
 int __secure psci_cpu_on(u32 __always_unused unused, u32 mpidr, u32 pc,
 			 u32 context_id)
 {
-	struct sunxi_cpucfg_reg *cpucfg =
-		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
 	u32 cpu = (mpidr & 0x3);
 
 	/* store target PC and context id */
 	psci_save(cpu, pc, context_id);
 
 	/* Set secondary core power on PC */
-	sunxi_set_entry_address(&psci_cpu_entry);
+	sunxi_cpu_set_entry(cpu, &psci_cpu_entry);
 
 	/* Assert reset on target CPU */
-	writel(0, &cpucfg->cpu[cpu].rst);
+	sunxi_cpu_set_reset(cpu, true);
 
 	/* Invalidate L1 cache */
-	clrbits_le32(&cpucfg->gen_ctrl, BIT(cpu));
+	sunxi_cpu_invalidate_cache(cpu);
 
 	/* Lock CPU (Disable external debug access) */
-	clrbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+	sunxi_cpu_set_locking(cpu, true);
 
 	/* Power up target CPU */
 	sunxi_cpu_set_power(cpu, true);
 
 	/* De-assert reset on target CPU */
-	writel(BIT(1) | BIT(0), &cpucfg->cpu[cpu].rst);
+	sunxi_cpu_set_reset(cpu, false);
 
-	/* Unlock CPU (Disable external debug access) */
-	setbits_le32(&cpucfg->dbg_ctrl1, BIT(cpu));
+	/* Unlock CPU (Reenable external debug access) */
+	sunxi_cpu_set_locking(cpu, false);
 
 	return ARM_PSCI_RET_SUCCESS;
 }
-- 
2.41.0

