Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF1CC5472C
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2017388BA0;
	Mon, 26 Aug 2024 14:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C35288B78; Mon, 26 Aug 2024 14:01:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F374988B5A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F6211FB;
 Mon, 26 Aug 2024 05:01:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19D13F762;
 Mon, 26 Aug 2024 05:01:14 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 17/27] lmb: do away with arch_lmb_reserve()
Date: Mon, 26 Aug 2024 17:29:30 +0530
Message-Id: <20240826115940.3233167-18-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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

All of the current definitions of arch_lmb_reserve() are doing the
same thing -- reserve the region of memory occupied by U-Boot,
starting from the current stack address to the ram_top. Introduce a
function lmb_reserve_uboot_region() which does this, and do away with
the arch_lmb_reserve() function.

Instead of using the current value of stack pointer for starting the
reserved region, have a fixed value, considering the stack size config
value.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3:
* s/16384/SZ_16K in lmb_reserve_uboot_region().
* Fix the corresponding comment for the above change.
* Fixed the alignment in lmb_reserve_uboot_region() as suggested by
  checkpatch.

 arch/arc/lib/cache.c        | 14 -------
 arch/arm/lib/stack.c        | 14 -------
 arch/m68k/lib/bootm.c       | 17 --------
 arch/microblaze/lib/bootm.c | 14 -------
 arch/mips/lib/bootm.c       | 15 -------
 arch/nios2/lib/bootm.c      | 13 ------
 arch/powerpc/lib/bootm.c    |  9 ----
 arch/riscv/lib/bootm.c      | 13 ------
 arch/sh/lib/bootm.c         | 13 ------
 arch/x86/lib/bootm.c        | 18 --------
 arch/xtensa/lib/bootm.c     | 13 ------
 include/lmb.h               |  2 -
 lib/lmb.c                   | 84 ++++++++++++++++++-------------------
 13 files changed, 42 insertions(+), 197 deletions(-)

diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
index 5151af917a..5169fc627f 100644
--- a/arch/arc/lib/cache.c
+++ b/arch/arc/lib/cache.c
@@ -10,7 +10,6 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
-#include <lmb.h>
 #include <asm/arcregs.h>
 #include <asm/arc-bcr.h>
 #include <asm/cache.h>
@@ -820,16 +819,3 @@ void sync_n_cleanup_cache_all(void)
 
 	__ic_entire_invalidate();
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mov %0, sp" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/arch/arm/lib/stack.c b/arch/arm/lib/stack.c
index 87d5c962d7..2b21ec0734 100644
--- a/arch/arm/lib/stack.c
+++ b/arch/arm/lib/stack.c
@@ -11,7 +11,6 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 #include <init.h>
-#include <lmb.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -33,16 +32,3 @@ int arch_reserve_stacks(void)
 
 	return 0;
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mov %0, sp" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 16384);
-}
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index aee95f1e18..3dcff8076e 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -9,7 +9,6 @@
 #include <command.h>
 #include <env.h>
 #include <image.h>
-#include <lmb.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <u-boot/zlib.h>
@@ -27,14 +26,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define LINUX_MAX_ENVS		256
 #define LINUX_MAX_ARGS		256
 
-static ulong get_sp (void);
 static void set_clocks_in_mhz (struct bd_info *kbd);
 
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 1024);
-}
-
 int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
 	struct bootm_headers *images = bmi->images;
@@ -88,16 +81,6 @@ error:
 	return 1;
 }
 
-static ulong get_sp (void)
-{
-	ulong sp;
-
-	asm("movel %%a7, %%d0\n"
-	    "movel %%d0, %0\n": "=d"(sp): :"%d0");
-
-	return sp;
-}
-
 static void set_clocks_in_mhz (struct bd_info *kbd)
 {
 	char *s;
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index ce96bca28f..4879a41aab 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -15,7 +15,6 @@
 #include <fdt_support.h>
 #include <hang.h>
 #include <image.h>
-#include <lmb.h>
 #include <log.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -24,19 +23,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("addik %0, r1, 0" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
-
 static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	void (*thekernel)(char *cmdline, ulong rd, ulong dt);
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 8fb3a3923f..8719510002 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -9,7 +9,6 @@
 #include <env.h>
 #include <image.h>
 #include <fdt_support.h>
-#include <lmb.h>
 #include <log.h>
 #include <asm/addrspace.h>
 #include <asm/global_data.h>
@@ -28,20 +27,6 @@ static char **linux_env;
 static char *linux_env_p;
 static int linux_env_idx;
 
-static ulong arch_get_sp(void)
-{
-	ulong ret;
-
-	__asm__ __volatile__("move %0, $sp" : "=r"(ret) : );
-
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(arch_get_sp(), gd->ram_top, 4096);
-}
-
 static void linux_cmdline_init(void)
 {
 	linux_argc = 1;
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index d33d45d28f..71319839ba 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -64,16 +64,3 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return 1;
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mov %0, sp" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 8f21cdb0a5..dc44bf3ab3 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -36,7 +36,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static ulong get_sp (void);
 extern void ft_fixup_num_cores(void *blob);
 static void set_clocks_in_mhz (struct bd_info *kbd);
 
@@ -210,14 +209,6 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	return 0;
 }
 
-static ulong get_sp (void)
-{
-	ulong sp;
-
-	asm( "mr %0,1": "=r"(sp) : );
-	return sp;
-}
-
 static void set_clocks_in_mhz (struct bd_info *kbd)
 {
 	char	*s;
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index bbf62f9e05..82502972ee 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -133,16 +133,3 @@ int do_bootm_vxworks(int flag, struct bootm_info *bmi)
 {
 	return do_bootm_linux(flag, bmi);
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mv %0, sp" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index 44ac05988c..bb0f59e0aa 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -101,16 +101,3 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	/* does not return */
 	return 1;
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mov r15, %0" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 114b31012e..55f581836d 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -253,21 +253,3 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return boot_jump_linux(images);
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-#if CONFIG_IS_ENABLED(X86_64)
-	asm("mov %%rsp, %0" : "=r"(ret) : );
-#else
-	asm("mov %%esp, %0" : "=r"(ret) : );
-#endif
-
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index bdbd6d4692..2958f20739 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -197,16 +197,3 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return 1;
 }
-
-static ulong get_sp(void)
-{
-	ulong ret;
-
-	asm("mov %0, a1" : "=r"(ret) : );
-	return ret;
-}
-
-void arch_lmb_reserve(void)
-{
-	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
-}
diff --git a/include/lmb.h b/include/lmb.h
index 2f155d706e..fb1a6db8e2 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -108,8 +108,6 @@ void lmb_dump_all(void);
 void lmb_dump_all_force(void);
 
 void board_lmb_reserve(void);
-void arch_lmb_reserve(void);
-void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
 struct lmb *lmb_get(void);
 int lmb_push(struct lmb *store);
diff --git a/lib/lmb.c b/lib/lmb.c
index 686988e34f..dbbc19ede9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <asm/sections.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -147,42 +148,6 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
 	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
-void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
-{
-	ulong bank_end;
-	int bank;
-
-	/*
-	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of U-Boot area using LMB to prevent U-Boot from overwriting
-	 * that memory.
-	 */
-	debug("## Current stack ends at 0x%08lx ", sp);
-
-	/* adjust sp by 4K to be safe */
-	sp -= align;
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    sp < gd->bd->bi_dram[bank].start)
-			continue;
-		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
-		if (sp > bank_end)
-			continue;
-		if (bank_end > end)
-			bank_end = end - 1;
-
-		lmb_reserve_flags(sp, bank_end - sp + 1, LMB_NOOVERWRITE);
-
-		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
-					  gd->mon_len, LMB_NOOVERWRITE);
-
-		break;
-	}
-}
-
 /**
  * efi_lmb_reserve() - add reservations for EFI memory
  *
@@ -215,10 +180,50 @@ static __maybe_unused int efi_lmb_reserve(void)
 	return 0;
 }
 
+static void lmb_reserve_uboot_region(void)
+{
+	int bank;
+	ulong end, bank_end;
+	phys_addr_t rsv_start;
+
+	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
+	end = gd->ram_top;
+
+	/*
+	 * Reserve memory from aligned address below the bottom of U-Boot stack
+	 * until end of RAM area to prevent LMB from overwriting that memory.
+	 */
+	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
+
+	/* adjust sp by 16K to be safe */
+	rsv_start -= SZ_16K;
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		if (!gd->bd->bi_dram[bank].size ||
+		    rsv_start < gd->bd->bi_dram[bank].start)
+			continue;
+		/* Watch out for RAM at end of address space! */
+		bank_end = gd->bd->bi_dram[bank].start +
+			gd->bd->bi_dram[bank].size - 1;
+		if (rsv_start > bank_end)
+			continue;
+		if (bank_end > end)
+			bank_end = end - 1;
+
+		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
+				  LMB_NOOVERWRITE);
+
+		if (gd->flags & GD_FLG_SKIP_RELOC)
+			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
+					  gd->mon_len, LMB_NOOVERWRITE);
+
+		break;
+	}
+}
+
 static void lmb_reserve_common(void *fdt_blob)
 {
-	arch_lmb_reserve();
 	board_lmb_reserve();
+	lmb_reserve_uboot_region();
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
 		boot_fdt_add_mem_rsv_regions(fdt_blob);
@@ -690,11 +695,6 @@ __weak void board_lmb_reserve(void)
 	/* please define platform specific board_lmb_reserve() */
 }
 
-__weak void arch_lmb_reserve(void)
-{
-	/* please define platform specific arch_lmb_reserve() */
-}
-
 static int lmb_setup(void)
 {
 	bool ret;
-- 
2.34.1

