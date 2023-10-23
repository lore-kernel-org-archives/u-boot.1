Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E513CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD368796E;
	Mon, 23 Oct 2023 15:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1754387966; Mon, 23 Oct 2023 15:25:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D2D5687936
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407D82F4;
 Mon, 23 Oct 2023 06:26:16 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8DA63F762;
 Mon, 23 Oct 2023 06:25:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 21/24] sunxi: psci: refactor register access to separate
 functions
Date: Mon, 23 Oct 2023 14:24:46 +0100
Message-Id: <20231023132449.813863-22-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
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

From: Sam Edwards <cfsworks@gmail.com>

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
index 69fa3f3c2eb..27ca9c39e18 100644
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
2.25.1

