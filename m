Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B8E728E1
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 18:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF868708B;
	Sat, 30 Sep 2023 20:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BnCMe/8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95798707D; Sat, 30 Sep 2023 20:34:36 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335E687080
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 20:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fbbb2bed0so40486339f.1
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696098872; x=1696703672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UA+UmFofC76SDVXUmWpXuJrisssdjGmLWrn9JJqq/EY=;
 b=BnCMe/8FvnXUyV0Qdi9J9rEDMEM1vHCqSjDVEs8h+7qSya406tl7qc0sYtY9pO/b/8
 RNTGH+7BEHvraPJR1BYDnqAVYpX2GxMQW8Zzd+2uZkGBEYeADG3cE7xiSdUTJnfUGu5N
 Q3z4CT3wVpuxPGruD37z6f4wMmvWE7PSM6q2/Fc5aprtc6hYa6kU+cNDeyFYfPWi8qJw
 BHLKdwZhTVpKkr/jXvRGL99m9C3eHrUjF3BgjhCVawT5OPQRObMmvQZ2bAlrkFbWY/3j
 7cQn/8EDpVJk8SokFRniCVmIbaSkczpnLB6IpqUjE30P3gZwT2VeAefsXQqw9YzpqwjG
 kzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696098872; x=1696703672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UA+UmFofC76SDVXUmWpXuJrisssdjGmLWrn9JJqq/EY=;
 b=LpeVjiGH3yD1Fv+TcQkjaZOiu2KG8e0cD4f1+8PaFSlCuiawc59wByHQleRpSiJsP/
 8b5TLIdA5AtyXBoD+HGpvsQWyX1S0RwKGYvn5zcJYv/RSnViDD5uXB9AUTHc3xVwx6fs
 RwufKSKdvOWW+erLPWJ4wHf84vQ71GbfOdnhI5cI5djHeXYB5Ob1t0j/MYawerbawzar
 UXWq1rug194TBClIbI9nxj4wVRf1zN8j/nckfA5SMEqRHZTMyD6l2Dm0Zr5cE5nMF7j1
 7f5/hemMr8txmcD/+9s3yxxRyGsL9mglB+VrnXSJKObBOcmkbfBfVU/iTs7h/8I0ykTX
 sn2A==
X-Gm-Message-State: AOJu0YxDdW0zFu6+csL8yNiIcFGc3q3gvAOOCpSajAAZMYZBt/uif9Kv
 TboCqbEUHp6r6dH17b4CPK2X9wT9URSGXQ==
X-Google-Smtp-Source: AGHT+IEgQXALF98nY5AmgphEqmb4ND5hZw1A8Bp/zyvlV5nVvS6VUOmViQD1MmOOze7MVCuiU+NA8Q==
X-Received: by 2002:a05:6e02:20ea:b0:349:4053:4778 with SMTP id
 q10-20020a056e0220ea00b0034940534778mr6216359ilv.0.1696098872536; 
 Sat, 30 Sep 2023 11:34:32 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:adc8:be74:9e0d:a666])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a056638030500b0043a1fe337b9sm5999140jap.170.2023.09.30.11.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 11:34:32 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 2/4] sunxi: psci: refactor register access to separate
 functions
Date: Sat, 30 Sep 2023 12:34:22 -0600
Message-ID: <20230930183424.806520-3-CFSworks@gmail.com>
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

This is to prepare for R528, which does not have the typical
"CPUCFG" block; it has a "CPUX" block which provides these
same functions but is organized differently.

Moving the hardware-access bits to their own functions separates the
logic from the hardware so we can reuse the same logic.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c | 66 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 69fa3f3c2e..27ca9c39e1 100644
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
@@ -149,30 +149,60 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 	}
 }
 
-void __secure sunxi_cpu_power_off(u32 cpuid)
+static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
 {
 	struct sunxi_cpucfg_reg *cpucfg =
 		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
+
+	writel(reset ? 0b00 : 0b11, &cpucfg->cpu[cpu].rst);
+}
+
+static void __secure sunxi_cpu_set_locking(int cpu, bool lock)
+{
+	struct sunxi_cpucfg_reg *cpucfg =
+		(struct sunxi_cpucfg_reg *)SUNXI_CPUCFG_BASE;
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
+static void __secure sunxi_cpu_power_off(u32 cpuid)
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
@@ -229,33 +259,31 @@ out:
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

