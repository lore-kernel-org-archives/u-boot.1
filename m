Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD7C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 11:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8037D88DD4;
	Wed, 21 Aug 2024 13:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CCB88DC7; Wed, 21 Aug 2024 13:00:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 71F0088DBA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 13:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F100EDA7;
 Wed, 21 Aug 2024 04:00:25 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB8B3F73B;
 Wed, 21 Aug 2024 03:59:56 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 16/27] ppc: lmb: move arch specific lmb reservations to
 arch_misc_init()
Date: Wed, 21 Aug 2024 16:28:28 +0530
Message-Id: <20240821105839.2870293-17-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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

All the current function definitions of arch_lmb_reserve() are doing
the same thing -- reserve the U-Boot memory region. The powerpc(ppc)
architecture, in addition, is making some LMB reservations for the
bootm related image loading. Move these ppc specific reservations to
the arch_misc_init() function. This allows to move the U-Boot memory
region reservation to a different function, and remove
arch_lmb_reserve() in a subsequent commit.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: New patch

 arch/powerpc/cpu/mpc85xx/cpu_init.c | 16 --------
 arch/powerpc/lib/Makefile           |  1 +
 arch/powerpc/lib/bootm.c            | 40 -------------------
 arch/powerpc/lib/misc.c             | 62 +++++++++++++++++++++++++++++
 lib/Kconfig                         |  1 +
 5 files changed, 64 insertions(+), 56 deletions(-)
 create mode 100644 arch/powerpc/lib/misc.c

diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index a7b805bc67..739d14f800 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -940,22 +940,6 @@ int cpu_init_r(void)
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_MISC_INIT
-int arch_misc_init(void)
-{
-	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
-		struct udevice *dev;
-		int ret;
-
-		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(caam_jr), &dev);
-		if (ret)
-			printf("Failed to initialize caam_jr: %d\n", ret);
-	}
-
-	return 0;
-}
-#endif
-
 void arch_preboot_os(void)
 {
 	u32 msr;
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index bb819dcbb6..ecc2aba8f3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -39,6 +39,7 @@ obj-y	+= cache.o
 obj-y	+= extable.o
 obj-y	+= interrupts.o
 obj-$(CONFIG_CMD_KGDB) += kgdb.o
+obj-y	+= misc.o
 obj-y	+= stack.o
 obj-y	+= time.o
 obj-y	+= traps.o
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 6c35664ff3..5402e0bb35 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -12,7 +12,6 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <init.h>
-#include <lmb.h>
 #include <log.h>
 #include <watchdog.h>
 #include <command.h>
@@ -41,10 +40,6 @@ static ulong get_sp (void);
 extern void ft_fixup_num_cores(void *blob);
 static void set_clocks_in_mhz (struct bd_info *kbd);
 
-#ifndef CFG_SYS_LINUX_LOWMEM_MAX_SIZE
-#define CFG_SYS_LINUX_LOWMEM_MAX_SIZE	(768*1024*1024)
-#endif
-
 static void boot_jump_linux(struct bootm_headers *images)
 {
 	void	(*kernel)(struct bd_info *, ulong r4, ulong r5, ulong r6,
@@ -116,41 +111,6 @@ static void boot_jump_linux(struct bootm_headers *images)
 	return;
 }
 
-void arch_lmb_reserve(void)
-{
-	phys_size_t bootm_size;
-	ulong size, bootmap_base;
-
-	bootmap_base = env_get_bootm_low();
-	bootm_size = env_get_bootm_size();
-
-#ifdef DEBUG
-	if (((u64)bootmap_base + bootm_size) >
-	    (CFG_SYS_SDRAM_BASE + (u64)gd->ram_size))
-		puts("WARNING: bootm_low + bootm_size exceed total memory\n");
-	if ((bootmap_base + bootm_size) > get_effective_memsize())
-		puts("WARNING: bootm_low + bootm_size exceed eff. memory\n");
-#endif
-
-	size = min(bootm_size, get_effective_memsize());
-	size = min(size, (ulong)CFG_SYS_LINUX_LOWMEM_MAX_SIZE);
-
-	if (size < bootm_size) {
-		ulong base = bootmap_base + size;
-		printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
-		       size, (unsigned long long)bootm_size);
-		lmb_reserve(base, bootm_size - size);
-	}
-
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-
-#ifdef CONFIG_MP
-	cpu_mp_lmb_reserve();
-#endif
-
-	return;
-}
-
 static void boot_prep_linux(struct bootm_headers *images)
 {
 #ifdef CONFIG_MP
diff --git a/arch/powerpc/lib/misc.c b/arch/powerpc/lib/misc.c
new file mode 100644
index 0000000000..0ea9ab1358
--- /dev/null
+++ b/arch/powerpc/lib/misc.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Linaro Ltd.
+ */
+
+#include <image.h>
+#include <init.h>
+#include <lmb.h>
+
+#include <asm/mp.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+
+
+#ifndef CFG_SYS_LINUX_LOWMEM_MAX_SIZE
+#define CFG_SYS_LINUX_LOWMEM_MAX_SIZE	(768*1024*1024)
+#endif
+
+int arch_misc_init(void)
+{
+	if (CONFIG_IS_ENABLED(CMD_BOOTM)) {
+		phys_size_t bootm_size;
+		ulong size, bootmap_base;
+
+		bootmap_base = env_get_bootm_low();
+		bootm_size = env_get_bootm_size();
+
+#ifdef DEBUG
+		if (((u64)bootmap_base + bootm_size) >
+		    (CFG_SYS_SDRAM_BASE + (u64)gd->ram_size))
+			puts("WARNING: bootm_low + bootm_size exceed total memory\n");
+		if ((bootmap_base + bootm_size) > get_effective_memsize())
+			puts("WARNING: bootm_low + bootm_size exceed eff. memory\n");
+#endif
+
+		size = min(bootm_size, get_effective_memsize());
+		size = min(size, (ulong)CFG_SYS_LINUX_LOWMEM_MAX_SIZE);
+
+		if (size < bootm_size) {
+			ulong base = bootmap_base + size;
+			printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
+			       size, (unsigned long long)bootm_size);
+			lmb_reserve(base, bootm_size - size);
+		}
+
+#ifdef CONFIG_MP
+		cpu_mp_lmb_reserve();
+#endif
+	}
+
+	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
+		struct udevice *dev;
+		int ret;
+
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(caam_jr), &dev);
+		if (ret)
+			printf("Failed to initialize caam_jr: %d\n", ret);
+	}
+
+	return 0;
+}
diff --git a/lib/Kconfig b/lib/Kconfig
index 6a9338390a..e352b5550a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1102,6 +1102,7 @@ config LMB
 	bool "Enable the logical memory blocks library (lmb)"
 	default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
 		     NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
+	select ARCH_MISC_INIT if PPC
 	help
 	  Support the library logical memory blocks. This will require
 	  a malloc() implementation for defining the data structures
-- 
2.34.1

