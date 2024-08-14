Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13930C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C206889FD;
	Wed, 14 Aug 2024 13:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A836889BD; Wed, 14 Aug 2024 13:01:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0102388A1B
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D9CDA7;
 Wed, 14 Aug 2024 04:01:28 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE013F58B;
 Wed, 14 Aug 2024 04:00:57 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 06/32] lmb: make LMB memory map persistent and global
Date: Wed, 14 Aug 2024 16:29:43 +0530
Message-Id: <20240814110009.45310-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The current LMB API's for allocating and reserving memory use a
per-caller based memory view. Memory allocated by a caller can then be
overwritten by another caller. Make these allocations and reservations
persistent using the alloced list data structure.

Two alloced lists are declared -- one for the available(free) memory,
and one for the used memory. Once full, the list can then be extended
at runtime.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
[sjg: Optimise the logic to add a region in lmb_add_region_flags()]
---
Changes since V1:
* Keep the alloced lists for used and free memory in a lmb structure.
* s/lmb_mem_regions_init/lmb_setup.
* Remove the special case scenario for adding region when list is
  empty(sjg).
* Optimise the logic to add a region to a sorted region list(sjg)
* Call lmb_setup() from lmb_init()

 arch/arc/lib/cache.c                 |   4 +-
 arch/arm/lib/stack.c                 |   4 +-
 arch/arm/mach-apple/board.c          |  17 +-
 arch/arm/mach-snapdragon/board.c     |  17 +-
 arch/arm/mach-stm32mp/dram_init.c    |   8 +-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
 arch/m68k/lib/bootm.c                |   7 +-
 arch/microblaze/lib/bootm.c          |   4 +-
 arch/mips/lib/bootm.c                |  11 +-
 arch/nios2/lib/bootm.c               |   4 +-
 arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
 arch/powerpc/include/asm/mp.h        |   4 +-
 arch/powerpc/lib/bootm.c             |  14 +-
 arch/riscv/lib/bootm.c               |   4 +-
 arch/sh/lib/bootm.c                  |   4 +-
 arch/x86/lib/bootm.c                 |   4 +-
 arch/xtensa/lib/bootm.c              |   4 +-
 board/xilinx/common/board.c          |   8 +-
 boot/bootm.c                         |  26 +-
 boot/bootm_os.c                      |   5 +-
 boot/image-board.c                   |  34 +--
 boot/image-fdt.c                     |  36 +--
 cmd/bdinfo.c                         |   6 +-
 cmd/booti.c                          |   2 +-
 cmd/bootz.c                          |   2 +-
 cmd/elf.c                            |   2 +-
 cmd/load.c                           |   7 +-
 drivers/iommu/apple_dart.c           |   8 +-
 drivers/iommu/sandbox_iommu.c        |  16 +-
 fs/fs.c                              |   7 +-
 include/image.h                      |  28 +-
 include/lmb.h                        | 107 +++----
 lib/efi_loader/efi_dt_fixup.c        |   2 +-
 lib/efi_loader/efi_helper.c          |   2 +-
 lib/lmb.c                            | 420 +++++++++++++++------------
 net/tftp.c                           |   5 +-
 net/wget.c                           |   5 +-
 test/cmd/bdinfo.c                    |   2 +-
 test/lib/lmb.c                       | 205 ++++++-------
 39 files changed, 498 insertions(+), 557 deletions(-)

diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
index 22e748868a..5151af917a 100644
--- a/arch/arc/lib/cache.c
+++ b/arch/arc/lib/cache.c
@@ -829,7 +829,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/arch/arm/lib/stack.c b/arch/arm/lib/stack.c
index ea1b937add..87d5c962d7 100644
--- a/arch/arm/lib/stack.c
+++ b/arch/arm/lib/stack.c
@@ -42,7 +42,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 16384);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 16384);
 }
diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 8bace3005e..213390d6e8 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -773,23 +773,22 @@ u64 get_page_table_size(void)
 
 int board_late_init(void)
 {
-	struct lmb lmb;
 	u32 status = 0;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
 	 */
-	status |= env_set_hex("loadaddr", lmb_alloc(&lmb, SZ_1G, SZ_2M));
-	status |= env_set_hex("fdt_addr_r", lmb_alloc(&lmb, SZ_2M, SZ_2M));
-	status |= env_set_hex("kernel_addr_r", lmb_alloc(&lmb, SZ_128M, SZ_2M));
-	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(&lmb, SZ_1G, SZ_2M));
+	status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
+	status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
+	status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
+	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
 	status |= env_set_hex("kernel_comp_addr_r",
-			      lmb_alloc(&lmb, KERNEL_COMP_SIZE, SZ_2M));
+			      lmb_alloc(KERNEL_COMP_SIZE, SZ_2M));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
-	status |= env_set_hex("scriptaddr", lmb_alloc(&lmb, SZ_4M, SZ_2M));
-	status |= env_set_hex("pxefile_addr_r", lmb_alloc(&lmb, SZ_4M, SZ_2M));
+	status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M, SZ_2M));
+	status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M, SZ_2M));
 
 	if (status)
 		log_warning("late_init: Failed to set run time variables\n");
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index b439a19ec7..a63c8bec45 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -275,24 +275,23 @@ void __weak qcom_late_init(void)
 
 #define KERNEL_COMP_SIZE	SZ_64M
 
-#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
+#define addr_alloc(size) lmb_alloc(size, SZ_2M)
 
 /* Stolen from arch/arm/mach-apple/board.c */
 int board_late_init(void)
 {
-	struct lmb lmb;
 	u32 status = 0;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
-	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
-	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
-	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
+	status |= env_set_hex("kernel_addr_r", addr_alloc(SZ_128M));
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
+	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(KERNEL_COMP_SIZE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
-	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
-	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
-	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+	status |= env_set_hex("scriptaddr", addr_alloc(SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", addr_alloc(SZ_4M));
+	status |= env_set_hex("fdt_addr_r", addr_alloc(SZ_2M));
 
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index 6024959b97..e8b0a38be1 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -47,7 +47,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 	phys_size_t size;
 	phys_addr_t reg;
-	struct lmb lmb;
 
 	if (!total_size)
 		return gd->ram_top;
@@ -59,12 +58,11 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_init(&lmb);
-	lmb_add(&lmb, gd->ram_base, gd->ram_top - gd->ram_base);
-	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
+	lmb_add(gd->ram_base, gd->ram_top - gd->ram_base);
+	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
 	/* add 8M for reserved memory for display, fdt, gd,... */
 	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE),
-	reg = lmb_alloc(&lmb, size, MMU_SECTION_SIZE);
+	reg = lmb_alloc(size, MMU_SECTION_SIZE);
 
 	if (!reg)
 		reg = gd->ram_top - size;
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 478c3efae7..a913737342 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -30,8 +30,6 @@
  */
 u8 early_tlb[PGTABLE_SIZE] __section(".data") __aligned(0x4000);
 
-struct lmb lmb;
-
 u32 get_bootmode(void)
 {
 	/* read bootmode from TAMP backup register */
@@ -80,7 +78,7 @@ void dram_bank_mmu_setup(int bank)
 	     i < (start >> MMU_SECTION_SHIFT) + (size >> MMU_SECTION_SHIFT);
 	     i++) {
 		option = DCACHE_DEFAULT_OPTION;
-		if (use_lmb && lmb_is_reserved_flags(&lmb, i << MMU_SECTION_SHIFT, LMB_NOMAP))
+		if (use_lmb && lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP))
 			option = 0; /* INVALID ENTRY in TLB */
 		set_section_dcache(i, option);
 	}
@@ -144,7 +142,7 @@ int mach_cpu_init(void)
 void enable_caches(void)
 {
 	/* parse device tree when data cache is still activated */
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
 	/* I-cache is already enabled in start.S: icache_enable() not needed */
 
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index f2d02e4376..eb220d178d 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -30,9 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
 static ulong get_sp (void);
 static void set_clocks_in_mhz (struct bd_info *kbd);
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 1024);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 1024);
 }
 
 int do_bootm_linux(int flag, struct bootm_info *bmi)
@@ -41,7 +41,6 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	int ret;
 	struct bd_info  *kbd;
 	void  (*kernel) (struct bd_info *, ulong, ulong, ulong, ulong);
-	struct lmb *lmb = &images->lmb;
 
 	/*
 	 * allow the PREP bootm subcommand, it is required for bootm to work
@@ -53,7 +52,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 		return 1;
 
 	/* allocate space for kernel copy of board info */
-	ret = boot_get_kbd (lmb, &kbd);
+	ret = boot_get_kbd (&kbd);
 	if (ret) {
 		puts("ERROR with allocation of kernel bd\n");
 		goto error;
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index cbe9d85aa9..ce96bca28f 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -32,9 +32,9 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
 
 static void boot_jump_linux(struct bootm_headers *images, int flag)
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index adb6b6cc22..8fb3a3923f 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -37,9 +37,9 @@ static ulong arch_get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, arch_get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(arch_get_sp(), gd->ram_top, 4096);
 }
 
 static void linux_cmdline_init(void)
@@ -225,9 +225,8 @@ static int boot_reloc_fdt(struct bootm_headers *images)
 	}
 
 #if CONFIG_IS_ENABLED(MIPS_BOOT_FDT) && CONFIG_IS_ENABLED(OF_LIBFDT)
-	boot_fdt_add_mem_rsv_regions(&images->lmb, images->ft_addr);
-	return boot_relocate_fdt(&images->lmb, &images->ft_addr,
-		&images->ft_len);
+	boot_fdt_add_mem_rsv_regions(images->ft_addr);
+	return boot_relocate_fdt(&images->ft_addr, &images->ft_len);
 #else
 	return 0;
 #endif
@@ -248,7 +247,7 @@ static int boot_setup_fdt(struct bootm_headers *images)
 	images->initrd_start = virt_to_phys((void *)images->initrd_start);
 	images->initrd_end = virt_to_phys((void *)images->initrd_end);
 
-	return image_setup_libfdt(images, images->ft_addr, &images->lmb);
+	return image_setup_libfdt(images, images->ft_addr, true);
 }
 
 static void boot_prep_linux(struct bootm_headers *images)
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index ce939ff5e1..d33d45d28f 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -73,7 +73,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index 03f801ebbb..bed465cb2c 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -408,11 +408,11 @@ static void plat_mp_up(unsigned long bootpg, unsigned int pagesize)
 }
 #endif
 
-void cpu_mp_lmb_reserve(struct lmb *lmb)
+void cpu_mp_lmb_reserve(void)
 {
 	u32 bootpg = determine_mp_bootpg(NULL);
 
-	lmb_reserve(lmb, bootpg, 4096);
+	lmb_reserve(bootpg, 4096);
 }
 
 void setup_mp(void)
diff --git a/arch/powerpc/include/asm/mp.h b/arch/powerpc/include/asm/mp.h
index 8dacd2781d..b3f59be840 100644
--- a/arch/powerpc/include/asm/mp.h
+++ b/arch/powerpc/include/asm/mp.h
@@ -6,10 +6,8 @@
 #ifndef _ASM_MP_H_
 #define _ASM_MP_H_
 
-#include <lmb.h>
-
 void setup_mp(void);
-void cpu_mp_lmb_reserve(struct lmb *lmb);
+void cpu_mp_lmb_reserve(void);
 u32 determine_mp_bootpg(unsigned int *pagesize);
 int is_core_disabled(int nr);
 
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 61e08728dd..6c35664ff3 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -116,7 +116,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 	return;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
 	phys_size_t bootm_size;
 	ulong size, bootmap_base;
@@ -139,13 +139,13 @@ void arch_lmb_reserve(struct lmb *lmb)
 		ulong base = bootmap_base + size;
 		printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
 		       size, (unsigned long long)bootm_size);
-		lmb_reserve(lmb, base, bootm_size - size);
+		lmb_reserve(base, bootm_size - size);
 	}
 
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 
 #ifdef CONFIG_MP
-	cpu_mp_lmb_reserve(lmb);
+	cpu_mp_lmb_reserve();
 #endif
 
 	return;
@@ -166,7 +166,6 @@ static void boot_prep_linux(struct bootm_headers *images)
 static int boot_cmdline_linux(struct bootm_headers *images)
 {
 	ulong of_size = images->ft_len;
-	struct lmb *lmb = &images->lmb;
 	ulong *cmd_start = &images->cmdline_start;
 	ulong *cmd_end = &images->cmdline_end;
 
@@ -174,7 +173,7 @@ static int boot_cmdline_linux(struct bootm_headers *images)
 
 	if (!of_size) {
 		/* allocate space and init command line */
-		ret = boot_get_cmdline (lmb, cmd_start, cmd_end);
+		ret = boot_get_cmdline (cmd_start, cmd_end);
 		if (ret) {
 			puts("ERROR with allocation of cmdline\n");
 			return ret;
@@ -187,14 +186,13 @@ static int boot_cmdline_linux(struct bootm_headers *images)
 static int boot_bd_t_linux(struct bootm_headers *images)
 {
 	ulong of_size = images->ft_len;
-	struct lmb *lmb = &images->lmb;
 	struct bd_info **kbd = &images->kbd;
 
 	int ret = 0;
 
 	if (!of_size) {
 		/* allocate space for kernel copy of board info */
-		ret = boot_get_kbd (lmb, kbd);
+		ret = boot_get_kbd (kbd);
 		if (ret) {
 			puts("ERROR with allocation of kernel bd\n");
 			return ret;
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 13cbaaba68..bbf62f9e05 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -142,7 +142,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index e298d766b5..44ac05988c 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -110,7 +110,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 2c889bcd33..114b31012e 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -267,7 +267,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index 1de06b7fb5..bdbd6d4692 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -206,7 +206,7 @@ static ulong get_sp(void)
 	return ret;
 }
 
-void arch_lmb_reserve(struct lmb *lmb)
+void arch_lmb_reserve(void)
 {
-	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 4096);
+	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
 }
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 0b43407b9e..4056884400 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -675,7 +675,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 	phys_size_t size;
 	phys_addr_t reg;
-	struct lmb lmb;
 
 	if (!total_size)
 		return gd->ram_top;
@@ -684,11 +683,10 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_init(&lmb);
-	lmb_add(&lmb, gd->ram_base, gd->ram_size);
-	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
+	lmb_add(gd->ram_base, gd->ram_size);
+	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
 	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
-	reg = lmb_alloc(&lmb, size, MMU_SECTION_SIZE);
+	reg = lmb_alloc(size, MMU_SECTION_SIZE);
 
 	if (!reg)
 		reg = gd->ram_top - size;
diff --git a/boot/bootm.c b/boot/bootm.c
index 480f8e6a0e..d47feddb9b 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -240,7 +240,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 }
 
 #ifdef CONFIG_LMB
-static void boot_start_lmb(struct bootm_headers *images)
+static void boot_start_lmb(void)
 {
 	phys_addr_t	mem_start;
 	phys_size_t	mem_size;
@@ -248,12 +248,11 @@ static void boot_start_lmb(struct bootm_headers *images)
 	mem_start = env_get_bootm_low();
 	mem_size = env_get_bootm_size();
 
-	lmb_init_and_reserve_range(&images->lmb, mem_start,
-				   mem_size, NULL);
+	lmb_init_and_reserve_range(mem_start, mem_size, NULL);
 }
 #else
-#define lmb_reserve(lmb, base, size)
-static inline void boot_start_lmb(struct bootm_headers *images) { }
+#define lmb_reserve(base, size)
+static inline void boot_start_lmb(void) { }
 #endif
 
 static int bootm_start(void)
@@ -261,7 +260,7 @@ static int bootm_start(void)
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
 
-	boot_start_lmb(&images);
+	boot_start_lmb();
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
 	images.state = BOOTM_STATE_START;
@@ -640,7 +639,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		ulong req_size = ALIGN(image_len * 4, SZ_1M);
 
-		load = lmb_alloc(&images->lmb, req_size, SZ_2M);
+		load = lmb_alloc(req_size, SZ_2M);
 		if (!load)
 			return 1;
 		os.load = load;
@@ -714,8 +713,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		images->os.end = relocated_addr + image_size;
 	}
 
-	lmb_reserve(&images->lmb, images->os.load, (load_end -
-						    images->os.load));
+	lmb_reserve(images->os.load, (load_end - images->os.load));
 	return 0;
 }
 
@@ -1029,8 +1027,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_RAMDISK)) {
 		ulong rd_len = images->rd_end - images->rd_start;
 
-		ret = boot_ramdisk_high(&images->lmb, images->rd_start,
-			rd_len, &images->initrd_start, &images->initrd_end);
+		ret = boot_ramdisk_high(images->rd_start, rd_len,
+					&images->initrd_start,
+					&images->initrd_end);
 		if (!ret) {
 			env_set_hex("initrd_start", images->initrd_start);
 			env_set_hex("initrd_end", images->initrd_end);
@@ -1039,9 +1038,8 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 #endif
 #if CONFIG_IS_ENABLED(OF_LIBFDT) && defined(CONFIG_LMB)
 	if (!ret && (states & BOOTM_STATE_FDT)) {
-		boot_fdt_add_mem_rsv_regions(&images->lmb, images->ft_addr);
-		ret = boot_relocate_fdt(&images->lmb, &images->ft_addr,
-					&images->ft_len);
+		boot_fdt_add_mem_rsv_regions(images->ft_addr);
+		ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
 	}
 #endif
 
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 6a6621706f..e9522cd329 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -260,12 +260,11 @@ static void do_bootvx_fdt(struct bootm_headers *images)
 	char *bootline;
 	ulong of_size = images->ft_len;
 	char **of_flat_tree = &images->ft_addr;
-	struct lmb *lmb = &images->lmb;
 
 	if (*of_flat_tree) {
-		boot_fdt_add_mem_rsv_regions(lmb, *of_flat_tree);
+		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
 
-		ret = boot_relocate_fdt(lmb, of_flat_tree, &of_size);
+		ret = boot_relocate_fdt(of_flat_tree, &of_size);
 		if (ret)
 			return;
 
diff --git a/boot/image-board.c b/boot/image-board.c
index f212401304..1f8c1ac69f 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -515,7 +515,6 @@ int boot_get_ramdisk(char const *select, struct bootm_headers *images,
 
 /**
  * boot_ramdisk_high - relocate init ramdisk
- * @lmb: pointer to lmb handle, will be used for memory mgmt
  * @rd_data: ramdisk data start address
  * @rd_len: ramdisk data length
  * @initrd_start: pointer to a ulong variable, will hold final init ramdisk
@@ -534,8 +533,8 @@ int boot_get_ramdisk(char const *select, struct bootm_headers *images,
  *      0 - success
  *     -1 - failure
  */
-int boot_ramdisk_high(struct lmb *lmb, ulong rd_data, ulong rd_len,
-		      ulong *initrd_start, ulong *initrd_end)
+int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
+		      ulong *initrd_end)
 {
 	char	*s;
 	phys_addr_t initrd_high;
@@ -561,13 +560,14 @@ int boot_ramdisk_high(struct lmb *lmb, ulong rd_data, ulong rd_len,
 			debug("   in-place initrd\n");
 			*initrd_start = rd_data;
 			*initrd_end = rd_data + rd_len;
-			lmb_reserve(lmb, rd_data, rd_len);
+			lmb_reserve(rd_data, rd_len);
 		} else {
 			if (initrd_high)
-				*initrd_start = (ulong)lmb_alloc_base(lmb,
-						rd_len, 0x1000, initrd_high);
+				*initrd_start = (ulong)lmb_alloc_base(rd_len,
+								      0x1000,
+								      initrd_high);
 			else
-				*initrd_start = (ulong)lmb_alloc(lmb, rd_len,
+				*initrd_start = (ulong)lmb_alloc(rd_len,
 								 0x1000);
 
 			if (*initrd_start == 0) {
@@ -800,7 +800,6 @@ int boot_get_loadable(struct bootm_headers *images)
 
 /**
  * boot_get_cmdline - allocate and initialize kernel cmdline
- * @lmb: pointer to lmb handle, will be used for memory mgmt
  * @cmd_start: pointer to a ulong variable, will hold cmdline start
  * @cmd_end: pointer to a ulong variable, will hold cmdline end
  *
@@ -813,7 +812,7 @@ int boot_get_loadable(struct bootm_headers *images)
  *      0 - success
  *     -1 - failure
  */
-int boot_get_cmdline(struct lmb *lmb, ulong *cmd_start, ulong *cmd_end)
+int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 {
 	int barg;
 	char *cmdline;
@@ -827,7 +826,7 @@ int boot_get_cmdline(struct lmb *lmb, ulong *cmd_start, ulong *cmd_end)
 		return 0;
 
 	barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
-	cmdline = (char *)(ulong)lmb_alloc_base(lmb, barg, 0xf,
+	cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
 				env_get_bootm_mapsize() + env_get_bootm_low());
 	if (!cmdline)
 		return -1;
@@ -848,7 +847,6 @@ int boot_get_cmdline(struct lmb *lmb, ulong *cmd_start, ulong *cmd_end)
 
 /**
  * boot_get_kbd - allocate and initialize kernel copy of board info
- * @lmb: pointer to lmb handle, will be used for memory mgmt
  * @kbd: double pointer to board info data
  *
  * boot_get_kbd() allocates space for kernel copy of board info data below
@@ -859,10 +857,9 @@ int boot_get_cmdline(struct lmb *lmb, ulong *cmd_start, ulong *cmd_end)
  *      0 - success
  *     -1 - failure
  */
-int boot_get_kbd(struct lmb *lmb, struct bd_info **kbd)
+int boot_get_kbd(struct bd_info **kbd)
 {
-	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(lmb,
-						       sizeof(struct bd_info),
+	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
 						       0xf,
 						       env_get_bootm_mapsize() +
 						       env_get_bootm_low());
@@ -883,17 +880,16 @@ int image_setup_linux(struct bootm_headers *images)
 {
 	ulong of_size = images->ft_len;
 	char **of_flat_tree = &images->ft_addr;
-	struct lmb *lmb = images_lmb(images);
 	int ret;
 
 	/* This function cannot be called without lmb support */
 	if (!IS_ENABLED(CONFIG_LMB))
 		return -EFAULT;
 	if (CONFIG_IS_ENABLED(OF_LIBFDT))
-		boot_fdt_add_mem_rsv_regions(lmb, *of_flat_tree);
+		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
 
 	if (IS_ENABLED(CONFIG_SYS_BOOT_GET_CMDLINE)) {
-		ret = boot_get_cmdline(lmb, &images->cmdline_start,
+		ret = boot_get_cmdline(&images->cmdline_start,
 				       &images->cmdline_end);
 		if (ret) {
 			puts("ERROR with allocation of cmdline\n");
@@ -902,13 +898,13 @@ int image_setup_linux(struct bootm_headers *images)
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
-		ret = boot_relocate_fdt(lmb, of_flat_tree, &of_size);
+		ret = boot_relocate_fdt(of_flat_tree, &of_size);
 		if (ret)
 			return ret;
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && of_size) {
-		ret = image_setup_libfdt(images, *of_flat_tree, lmb);
+		ret = image_setup_libfdt(images, *of_flat_tree, true);
 		if (ret)
 			return ret;
 	}
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8332792b8e..ccafadec0d 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -68,12 +68,12 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
 }
 #endif
 
-static void boot_fdt_reserve_region(struct lmb *lmb, uint64_t addr,
-				    uint64_t size, enum lmb_flags flags)
+static void boot_fdt_reserve_region(uint64_t addr, uint64_t size,
+				    enum lmb_flags flags)
 {
 	long ret;
 
-	ret = lmb_reserve_flags(lmb, addr, size, flags);
+	ret = lmb_reserve_flags(addr, size, flags);
 	if (ret >= 0) {
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
@@ -89,14 +89,13 @@ static void boot_fdt_reserve_region(struct lmb *lmb, uint64_t addr,
 /**
  * boot_fdt_add_mem_rsv_regions - Mark the memreserve and reserved-memory
  * sections as unusable
- * @lmb: pointer to lmb handle, will be used for memory mgmt
  * @fdt_blob: pointer to fdt blob base address
  *
  * Adds the and reserved-memorymemreserve regions in the dtb to the lmb block.
  * Adding the memreserve regions prevents u-boot from using them to store the
  * initrd or the fdt blob.
  */
-void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
+void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 {
 	uint64_t addr, size;
 	int i, total, ret;
@@ -112,7 +111,7 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
 	for (i = 0; i < total; i++) {
 		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
 			continue;
-		boot_fdt_reserve_region(lmb, addr, size, LMB_NONE);
+		boot_fdt_reserve_region(addr, size, LMB_NONE);
 	}
 
 	/* process reserved-memory */
@@ -130,7 +129,7 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
 					flags = LMB_NOMAP;
 				addr = res.start;
 				size = res.end - res.start + 1;
-				boot_fdt_reserve_region(lmb, addr, size, flags);
+				boot_fdt_reserve_region(addr, size, flags);
 			}
 
 			subnode = fdt_next_subnode(fdt_blob, subnode);
@@ -140,7 +139,6 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
 
 /**
  * boot_relocate_fdt - relocate flat device tree
- * @lmb: pointer to lmb handle, will be used for memory mgmt
  * @of_flat_tree: pointer to a char* variable, will hold fdt start address
  * @of_size: pointer to a ulong variable, will hold fdt length
  *
@@ -155,7 +153,7 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
  *      0 - success
  *      1 - failure
  */
-int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
+int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 {
 	u64	start, size, usable, addr, low, mapsize;
 	void	*fdt_blob = *of_flat_tree;
@@ -187,18 +185,17 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 		if (desired_addr == ~0UL) {
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
-			lmb_reserve(lmb, map_to_sysmem(of_start), of_len);
+			lmb_reserve(map_to_sysmem(of_start), of_len);
 			disable_relocation = 1;
 		} else if (desired_addr) {
-			addr = lmb_alloc_base(lmb, of_len, 0x1000,
-					      desired_addr);
+			addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
 			of_start = map_sysmem(addr, of_len);
 			if (of_start == NULL) {
 				puts("Failed using fdt_high value for Device Tree");
 				goto error;
 			}
 		} else {
-			addr = lmb_alloc(lmb, of_len, 0x1000);
+			addr = lmb_alloc(of_len, 0x1000);
 			of_start = map_sysmem(addr, of_len);
 		}
 	} else {
@@ -220,7 +217,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			 * for LMB allocation.
 			 */
 			usable = min(start + size, low + mapsize);
-			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
+			addr = lmb_alloc_base(of_len, 0x1000, usable);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
@@ -569,8 +566,7 @@ __weak int arch_fixup_fdt(void *blob)
 	return 0;
 }
 
-int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       struct lmb *lmb)
+int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
 	ulong *initrd_end = &images->initrd_end;
@@ -670,8 +666,8 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	}
 
 	/* Delete the old LMB reservation */
-	if (lmb)
-		lmb_free(lmb, map_to_sysmem(blob), fdt_totalsize(blob));
+	if (CONFIG_IS_ENABLED(LMB) && lmb)
+		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob));
 
 	ret = fdt_shrink_to_minimum(blob, 0);
 	if (ret < 0)
@@ -679,8 +675,8 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	of_size = ret;
 
 	/* Create a new LMB reservation */
-	if (lmb)
-		lmb_reserve(lmb, map_to_sysmem(blob), of_size);
+	if (CONFIG_IS_ENABLED(LMB) && lmb)
+		lmb_reserve(map_to_sysmem(blob), of_size);
 
 #if defined(CONFIG_ARCH_KEYSTONE)
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 437ac4e863..b31e0208df 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -162,10 +162,8 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
-		struct lmb lmb;
-
-		lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
-		lmb_dump_all_force(&lmb);
+		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+		lmb_dump_all_force();
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			printf("devicetree  = %s\n", fdtdec_get_srcname());
 	}
diff --git a/cmd/booti.c b/cmd/booti.c
index 62b19e8343..6018cbacf0 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -87,7 +87,7 @@ static int booti_start(struct bootm_info *bmi)
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
-	lmb_reserve(&images->lmb, images->ep, le32_to_cpu(image_size));
+	lmb_reserve(images->ep, le32_to_cpu(image_size));
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 55837a7599..787203f5bd 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -56,7 +56,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret != 0)
 		return 1;
 
-	lmb_reserve(&images->lmb, images->ep, zi_end - zi_start);
+	lmb_reserve(images->ep, zi_end - zi_start);
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/elf.c b/cmd/elf.c
index 673c6c3051..f07e344a59 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -70,7 +70,7 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 		fdt_set_totalsize((void *)fdt_addr,
 				fdt_totalsize(fdt_addr) + CONFIG_SYS_FDT_PAD);
-		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
+		if (image_setup_libfdt(&img, (void *)fdt_addr, false))
 			return 1;
 	}
 #endif
diff --git a/cmd/load.c b/cmd/load.c
index d773a25d70..56da3a4c5d 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -141,7 +141,6 @@ static int do_load_serial(struct cmd_tbl *cmdtp, int flag, int argc,
 
 static ulong load_serial(long offset)
 {
-	struct lmb lmb;
 	char	record[SREC_MAXRECLEN + 1];	/* buffer for one S-Record	*/
 	char	binbuf[SREC_MAXBINLEN];		/* buffer for binary data	*/
 	int	binlen;				/* no. of data bytes in S-Rec.	*/
@@ -154,7 +153,7 @@ static ulong load_serial(long offset)
 	int	line_count =  0;
 	long ret;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
 	while (read_record(record, SREC_MAXRECLEN + 1) >= 0) {
 		type = srec_decode(record, &binlen, &addr, binbuf);
@@ -182,7 +181,7 @@ static ulong load_serial(long offset)
 		    {
 			void *dst;
 
-			ret = lmb_reserve(&lmb, store_addr, binlen);
+			ret = lmb_reserve(store_addr, binlen);
 			if (ret) {
 				printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
 					store_addr, store_addr + binlen);
@@ -191,7 +190,7 @@ static ulong load_serial(long offset)
 			dst = map_sysmem(store_addr, binlen);
 			memcpy(dst, binbuf, binlen);
 			unmap_sysmem(dst);
-			lmb_free(&lmb, store_addr, binlen);
+			lmb_free(store_addr, binlen);
 		    }
 		    if ((store_addr) < start_addr)
 			start_addr = store_addr;
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 9327dea1e3..611ac7cd6d 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -70,7 +70,6 @@
 
 struct apple_dart_priv {
 	void *base;
-	struct lmb lmb;
 	u64 *l1, *l2;
 	int bypass, shift;
 
@@ -124,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 	off = (phys_addr_t)addr - paddr;
 	psize = ALIGN(size + off, DART_PAGE_SIZE);
 
-	dva = lmb_alloc(&priv->lmb, psize, DART_PAGE_SIZE);
+	dva = lmb_alloc(psize, DART_PAGE_SIZE);
 
 	idx = dva / DART_PAGE_SIZE;
 	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
@@ -160,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 			   (unsigned long)&priv->l2[idx + i]);
 	priv->flush_tlb(priv);
 
-	lmb_free(&priv->lmb, dva, psize);
+	lmb_free(dva, psize);
 }
 
 static struct iommu_ops apple_dart_ops = {
@@ -213,8 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
-	lmb_init(&priv->lmb);
-	lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
+	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
 
 	/* Disable translations. */
 	for (sid = 0; sid < priv->nsid; sid++)
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index e37976f86f..5b4a6a8982 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -11,14 +11,9 @@
 
 #define IOMMU_PAGE_SIZE		SZ_4K
 
-struct sandbox_iommu_priv {
-	struct lmb lmb;
-};
-
 static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 				    size_t size)
 {
-	struct sandbox_iommu_priv *priv = dev_get_priv(dev);
 	phys_addr_t paddr, dva;
 	phys_size_t psize, off;
 
@@ -26,7 +21,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 	off = virt_to_phys(addr) - paddr;
 	psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
 
-	dva = lmb_alloc(&priv->lmb, psize, IOMMU_PAGE_SIZE);
+	dva = lmb_alloc(psize, IOMMU_PAGE_SIZE);
 
 	return dva + off;
 }
@@ -34,7 +29,6 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 				size_t size)
 {
-	struct sandbox_iommu_priv *priv = dev_get_priv(dev);
 	phys_addr_t dva;
 	phys_size_t psize;
 
@@ -42,7 +36,7 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 	psize = size + (addr - dva);
 	psize = ALIGN(psize, IOMMU_PAGE_SIZE);
 
-	lmb_free(&priv->lmb, dva, psize);
+	lmb_free(dva, psize);
 }
 
 static struct iommu_ops sandbox_iommu_ops = {
@@ -52,10 +46,7 @@ static struct iommu_ops sandbox_iommu_ops = {
 
 static int sandbox_iommu_probe(struct udevice *dev)
 {
-	struct sandbox_iommu_priv *priv = dev_get_priv(dev);
-
-	lmb_init(&priv->lmb);
-	lmb_add(&priv->lmb, 0x89abc000, SZ_16K);
+	lmb_add(0x89abc000, SZ_16K);
 
 	return 0;
 }
@@ -69,7 +60,6 @@ U_BOOT_DRIVER(sandbox_iommu) = {
 	.name = "sandbox_iommu",
 	.id = UCLASS_IOMMU,
 	.of_match = sandbox_iommu_ids,
-	.priv_auto = sizeof(struct sandbox_iommu_priv),
 	.ops = &sandbox_iommu_ops,
 	.probe = sandbox_iommu_probe,
 };
diff --git a/fs/fs.c b/fs/fs.c
index 0c47943f33..2c835eef86 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -531,7 +531,6 @@ int fs_size(const char *filename, loff_t *size)
 static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 			     loff_t len, struct fstype_info *info)
 {
-	struct lmb lmb;
 	int ret;
 	loff_t size;
 	loff_t read_len;
@@ -550,10 +549,10 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 	if (len && len < read_len)
 		read_len = len;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
-	lmb_dump_all(&lmb);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
+	lmb_dump_all();
 
-	if (lmb_alloc_addr(&lmb, addr, read_len) == addr)
+	if (lmb_alloc_addr(addr, read_len) == addr)
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/image.h b/include/image.h
index dd4042d1bd..74838a2f75 100644
--- a/include/image.h
+++ b/include/image.h
@@ -20,7 +20,6 @@
 #include <stdbool.h>
 
 /* Define this to avoid #ifdefs later on */
-struct lmb;
 struct fdt_region;
 
 #ifdef USE_HOSTCC
@@ -412,18 +411,8 @@ struct bootm_headers {
 #define BOOTM_STATE_PRE_LOAD	0x00000800
 #define BOOTM_STATE_MEASURE	0x00001000
 	int		state;
-
-#if defined(CONFIG_LMB) && !defined(USE_HOSTCC)
-	struct lmb	lmb;		/* for memory mgmt */
-#endif
 };
 
-#ifdef CONFIG_LMB
-#define images_lmb(_images)	(&(_images)->lmb)
-#else
-#define images_lmb(_images)	NULL
-#endif
-
 extern struct bootm_headers images;
 
 /*
@@ -835,13 +824,13 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 struct bootm_headers *images, char **of_flat_tree,
 		 ulong *of_size);
 
-void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob);
-int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size);
+void boot_fdt_add_mem_rsv_regions(void *fdt_blob);
+int boot_relocate_fdt(char **of_flat_tree, ulong *of_size);
 
-int boot_ramdisk_high(struct lmb *lmb, ulong rd_data, ulong rd_len,
-		  ulong *initrd_start, ulong *initrd_end);
-int boot_get_cmdline(struct lmb *lmb, ulong *cmd_start, ulong *cmd_end);
-int boot_get_kbd(struct lmb *lmb, struct bd_info **kbd);
+int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
+		      ulong *initrd_end);
+int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end);
+int boot_get_kbd(struct bd_info **kbd);
 
 /*******************************************************************/
 /* Legacy format specific code (prefixed with image_) */
@@ -1029,11 +1018,10 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
  *
  * @images:	Images information
  * @blob:	FDT to update
- * @lmb:	Points to logical memory block structure
+ * @lmb:	Flag indicating use of lmb for reserving FDT memory region
  * Return: 0 if ok, <0 on failure
  */
-int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       struct lmb *lmb);
+int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb);
 
 /**
  * Set up the FDT to use for booting a kernel
diff --git a/include/lmb.h b/include/lmb.h
index a1de18c3cb..3c8b9f2d1a 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -3,6 +3,7 @@
 #define _LINUX_LMB_H
 #ifdef __KERNEL__
 
+#include <alist.h>
 #include <asm/types.h>
 #include <asm/u-boot.h>
 #include <linux/bitops.h>
@@ -24,97 +25,62 @@ enum lmb_flags {
 };
 
 /**
- * struct lmb_property - Description of one region.
+ * struct lmb_region - Description of one region.
  *
  * @base:	Base address of the region.
  * @size:	Size of the region
  * @flags:	memory region attributes
  */
-struct lmb_property {
+struct lmb_region {
 	phys_addr_t base;
 	phys_size_t size;
 	enum lmb_flags flags;
 };
 
-/*
- * For regions size management, see LMB configuration in KConfig
- * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (boolean)
- *
- * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
- *         => CONFIG_LMB_MAX_REGIONS is used to configure the region size,
- *         directly in the array lmb_region.region[], with the same
- *         configuration for memory and reserved regions.
- *
- * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
- *         region is configurated *independently* with
- *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
- *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
- *         lmb_region.region is only a pointer to the correct buffer,
- *         initialized in lmb_init(). This configuration is useful to manage
- *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
- */
-
 /**
- * struct lmb_region - Description of a set of region.
+ * struct lmb - The LMB structure
  *
- * @cnt: Number of regions.
- * @max: Size of the region array, max value of cnt.
- * @region: Array of the region properties
+ * @free_mem:	List of free memory regions
+ * @used_mem:	List of used/reserved memory regions
  */
-struct lmb_region {
-	unsigned long cnt;
-	unsigned long max;
-#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
-#else
-	struct lmb_property *region;
-#endif
+struct lmb {
+	struct alist free_mem;
+	struct alist used_mem;
 };
 
 /**
- * struct lmb - Logical memory block handle.
+ * lmb_init() - Initialise the LMB module
  *
- * Clients provide storage for Logical memory block (lmb) handles.
- * The content of the structure is managed by the lmb library.
- * A lmb struct is  initialized by lmb_init() functions.
- * The lmb struct is passed to all other lmb APIs.
+ * Initialise the LMB lists needed for keeping the memory map. There
+ * are two lists, in form of alloced list data structure. One for the
+ * available memory, and one for the used memory. Initialise the two
+ * lists as part of board init. Add memory to the available memory
+ * list and reserve common areas by adding them to the used memory
+ * list.
  *
- * @memory: Description of memory regions.
- * @reserved: Description of reserved regions.
- * @memory_regions: Array of the memory regions (statically allocated)
- * @reserved_regions: Array of the reserved regions (statically allocated)
+ * Return: 0 on success, -ve on error
  */
-struct lmb {
-	struct lmb_region memory;
-	struct lmb_region reserved;
-#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
-#endif
-};
+int lmb_init(void);
 
-void lmb_init(struct lmb *lmb);
-void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob);
-void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
-				phys_size_t size, void *fdt_blob);
-long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size);
-long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
+void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
+				void *fdt_blob);
+long lmb_add(phys_addr_t base, phys_size_t size);
+long lmb_reserve(phys_addr_t base, phys_size_t size);
 /**
  * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
  *
- * @lmb:	the logical memory block struct
  * @base:	base address of the memory region
  * @size:	size of the memory region
  * @flags:	flags for the memory region
  * Return:	0 if OK, > 0 for coalesced region or a negative error code.
  */
-long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base,
-		       phys_size_t size, enum lmb_flags flags);
-phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align);
-phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
-			   phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
-phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
+long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
+		       enum lmb_flags flags);
+phys_addr_t lmb_alloc(phys_size_t size, ulong align);
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
+phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
@@ -122,21 +88,20 @@ phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
  * The function checks if a reserved region comprising @addr exists which has
  * all flag bits set which are set in @flags.
  *
- * @lmb:	the logical memory block struct
  * @addr:	address to be tested
  * @flags:	bitmap with bits to be tested
  * Return:	1 if matching reservation exists, 0 otherwise
  */
-int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags);
+int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
-long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+long lmb_free(phys_addr_t base, phys_size_t size);
 
-void lmb_dump_all(struct lmb *lmb);
-void lmb_dump_all_force(struct lmb *lmb);
+void lmb_dump_all(void);
+void lmb_dump_all_force(void);
 
-void board_lmb_reserve(struct lmb *lmb);
-void arch_lmb_reserve(struct lmb *lmb);
-void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align);
+void board_lmb_reserve(void);
+void arch_lmb_reserve(void);
+void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
 #endif /* __KERNEL__ */
 
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 9886e6897c..9d017804ee 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -172,7 +172,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 		}
 
 		fdt_set_totalsize(dtb, *buffer_size);
-		if (image_setup_libfdt(&img, dtb, NULL)) {
+		if (image_setup_libfdt(&img, dtb, false)) {
 			log_err("failed to process device tree\n");
 			ret = EFI_INVALID_PARAMETER;
 			goto out;
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 65d2116381..9907b2b23c 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -513,7 +513,7 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
-	if (image_setup_libfdt(&img, fdt, NULL)) {
+	if (image_setup_libfdt(&img, fdt, false)) {
 		log_err("ERROR: failed to process device tree\n");
 		return EFI_LOAD_ERROR;
 	}
diff --git a/lib/lmb.c b/lib/lmb.c
index 4d39c0d1f9..14aaec5d87 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
+#include <alist.h>
 #include <efi_loader.h>
 #include <image.h>
 #include <mapmem.h>
@@ -15,41 +16,46 @@
 
 #include <asm/global_data.h>
 #include <asm/sections.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define LMB_ALLOC_ANYWHERE	0
+#define LMB_ALIST_INITIAL_SIZE	4
 
-static void lmb_dump_region(struct lmb_region *rgn, char *name)
+static struct lmb lmb;
+
+static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 	unsigned long long base, size, end;
 	enum lmb_flags flags;
 	int i;
 
-	printf(" %s.cnt = 0x%lx / max = 0x%lx\n", name, rgn->cnt, rgn->max);
+	printf(" %s.count = 0x%hx\n", name, lmb_rgn_lst->count);
 
-	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		base = rgn[i].base;
+		size = rgn[i].size;
 		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		flags = rgn[i].flags;
 
 		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
 		       name, i, base, end, size, flags);
 	}
 }
 
-void lmb_dump_all_force(struct lmb *lmb)
+void lmb_dump_all_force(void)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb->memory, "memory");
-	lmb_dump_region(&lmb->reserved, "reserved");
+	lmb_dump_region(&lmb.free_mem, "memory");
+	lmb_dump_region(&lmb.used_mem, "reserved");
 }
 
-void lmb_dump_all(struct lmb *lmb)
+void lmb_dump_all(void)
 {
 #ifdef DEBUG
-	lmb_dump_all_force(lmb);
+	lmb_dump_all_force();
 #endif
 }
 
@@ -73,79 +79,74 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
+static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
 				unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 
 	return lmb_addrs_overlap(base1, size1, base2, size2);
 }
-static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
+
+static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
-static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
+static void lmb_remove_region(struct alist *lmb_rgn_lst, unsigned long r)
 {
 	unsigned long i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	for (i = r; i < rgn->cnt - 1; i++) {
-		rgn->region[i].base = rgn->region[i + 1].base;
-		rgn->region[i].size = rgn->region[i + 1].size;
-		rgn->region[i].flags = rgn->region[i + 1].flags;
+	for (i = r; i < lmb_rgn_lst->count - 1; i++) {
+		rgn[i].base = rgn[i + 1].base;
+		rgn[i].size = rgn[i + 1].size;
+		rgn[i].flags = rgn[i + 1].flags;
 	}
-	rgn->cnt--;
+	lmb_rgn_lst->count--;
 }
 
 /* Assumption: base addr of region 1 < base addr of region 2 */
-static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
+static void lmb_coalesce_regions(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
-	rgn->region[r1].size += rgn->region[r2].size;
-	lmb_remove_region(rgn, r2);
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	rgn[r1].size += rgn[r2].size;
+	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
 /*Assumption : base addr of region 1 < base addr of region 2*/
-static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
-				     unsigned long r2)
+static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
+				     unsigned long r1, unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 
 	if (base1 + size1 > base2 + size2) {
 		printf("This will not be a case any time\n");
 		return;
 	}
-	rgn->region[r1].size = base2 + size2 - base1;
-	lmb_remove_region(rgn, r2);
+	rgn[r1].size = base2 + size2 - base1;
+	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
-void lmb_init(struct lmb *lmb)
-{
-#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	lmb->memory.max = CONFIG_LMB_MAX_REGIONS;
-	lmb->reserved.max = CONFIG_LMB_MAX_REGIONS;
-#else
-	lmb->memory.max = CONFIG_LMB_MEMORY_REGIONS;
-	lmb->reserved.max = CONFIG_LMB_RESERVED_REGIONS;
-	lmb->memory.region = lmb->memory_regions;
-	lmb->reserved.region = lmb->reserved_regions;
-#endif
-	lmb->memory.cnt = 0;
-	lmb->reserved.cnt = 0;
-}
-
-void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
+void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
 {
 	ulong bank_end;
 	int bank;
@@ -171,10 +172,10 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
 		if (bank_end > end)
 			bank_end = end - 1;
 
-		lmb_reserve(lmb, sp, bank_end - sp + 1);
+		lmb_reserve(sp, bank_end - sp + 1);
 
 		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve(lmb, (phys_addr_t)(uintptr_t)_start, gd->mon_len);
+			lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len);
 
 		break;
 	}
@@ -186,10 +187,9 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
  * Add reservations for all EFI memory areas that are not
  * EFI_CONVENTIONAL_MEMORY.
  *
- * @lmb:	lmb environment
  * Return:	0 on success, 1 on failure
  */
-static __maybe_unused int efi_lmb_reserve(struct lmb *lmb)
+static __maybe_unused int efi_lmb_reserve(void)
 {
 	struct efi_mem_desc *memmap = NULL, *map;
 	efi_uintn_t i, map_size = 0;
@@ -201,8 +201,7 @@ static __maybe_unused int efi_lmb_reserve(struct lmb *lmb)
 
 	for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
 		if (map->type != EFI_CONVENTIONAL_MEMORY) {
-			lmb_reserve_flags(lmb,
-					  map_to_sysmem((void *)(uintptr_t)
+			lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
 							map->physical_start),
 					  map->num_pages * EFI_PAGE_SIZE,
 					  map->type == EFI_RESERVED_MEMORY_TYPE
@@ -214,64 +213,69 @@ static __maybe_unused int efi_lmb_reserve(struct lmb *lmb)
 	return 0;
 }
 
-static void lmb_reserve_common(struct lmb *lmb, void *fdt_blob)
+static void lmb_reserve_common(void *fdt_blob)
 {
-	arch_lmb_reserve(lmb);
-	board_lmb_reserve(lmb);
+	arch_lmb_reserve();
+	board_lmb_reserve();
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
-		boot_fdt_add_mem_rsv_regions(lmb, fdt_blob);
+		boot_fdt_add_mem_rsv_regions(fdt_blob);
 
 	if (CONFIG_IS_ENABLED(EFI_LOADER))
-		efi_lmb_reserve(lmb);
+		efi_lmb_reserve();
 }
 
 /* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob)
+void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
 {
 	int i;
 
-	lmb_init(lmb);
-
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		if (bd->bi_dram[i].size) {
-			lmb_add(lmb, bd->bi_dram[i].start,
-				bd->bi_dram[i].size);
-		}
+		if (bd->bi_dram[i].size)
+			lmb_add(bd->bi_dram[i].start, bd->bi_dram[i].size);
 	}
 
-	lmb_reserve_common(lmb, fdt_blob);
+	lmb_reserve_common(fdt_blob);
 }
 
 /* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
-				phys_size_t size, void *fdt_blob)
+void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
+				void *fdt_blob)
 {
-	lmb_init(lmb);
-	lmb_add(lmb, base, size);
-	lmb_reserve_common(lmb, fdt_blob);
+	lmb_add(base, size);
+	lmb_reserve_common(fdt_blob);
 }
 
-/* This routine called with relocation disabled. */
-static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
+/**
+ * lmb_add_region_flags() - Add an lmb region to the given list
+ * @lmb_rgn_lst: LMB list to which region is to be added(free/used)
+ * @base: Start address of the region
+ * @size: Size of the region to be added
+ * @flags: Attributes of the LMB region
+ *
+ * Add a region of memory to the list. If the region does not exist, add
+ * it to the list. Depending on the attributes of the region to be added,
+ * the function might resize an already existing region or coalesce two
+ * adjacent regions.
+ *
+ *
+ * Returns: 0 if the region addition successful, -1 on failure
+ */
+static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
 {
 	unsigned long coalesced = 0;
 	long adjacent, i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	if (rgn->cnt == 0) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
-		rgn->cnt = 1;
-		return 0;
-	}
+	if (alist_err(lmb_rgn_lst))
+		return -1;
 
 	/* First try and coalesce this LMB with another. */
-	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
-		phys_size_t rgnflags = rgn->region[i].flags;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
+		phys_size_t rgnflags = rgn[i].flags;
 		phys_addr_t end = base + size - 1;
 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
 		if (rgnbase <= base && end <= rgnend) {
@@ -286,14 +290,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		if (adjacent > 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
+			rgn[i].base -= size;
+			rgn[i].size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].size += size;
+			rgn[i].size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
@@ -302,99 +306,98 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		}
 	}
 
-	if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
-		if (lmb_regions_adjacent(rgn, i, i + 1)) {
-			lmb_coalesce_regions(rgn, i, i + 1);
-			coalesced++;
-		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
-			/* fix overlapping area */
-			lmb_fix_over_lap_regions(rgn, i, i + 1);
-			coalesced++;
+	if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
+		rgn = lmb_rgn_lst->data;
+		if (rgn[i].flags == rgn[i + 1].flags) {
+			if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
+				lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
+				coalesced++;
+			} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
+				/* fix overlapping area */
+				lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
+				coalesced++;
+			}
 		}
 	}
 
 	if (coalesced)
 		return coalesced;
-	if (rgn->cnt >= rgn->max)
+
+	if (alist_full(lmb_rgn_lst) &&
+	    !alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc))
 		return -1;
+	rgn = lmb_rgn_lst->data;
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
-	for (i = rgn->cnt-1; i >= 0; i--) {
-		if (base < rgn->region[i].base) {
-			rgn->region[i + 1].base = rgn->region[i].base;
-			rgn->region[i + 1].size = rgn->region[i].size;
-			rgn->region[i + 1].flags = rgn->region[i].flags;
+	for (i = lmb_rgn_lst->count; i >= 0; i--) {
+		if (i && base < rgn[i - 1].base) {
+			rgn[i] = rgn[i - 1];
 		} else {
-			rgn->region[i + 1].base = base;
-			rgn->region[i + 1].size = size;
-			rgn->region[i + 1].flags = flags;
+			rgn[i].base = base;
+			rgn[i].size = size;
+			rgn[i].flags = flags;
 			break;
 		}
 	}
 
-	if (base < rgn->region[0].base) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
-	}
-
-	rgn->cnt++;
+	lmb_rgn_lst->count++;
 
 	return 0;
 }
 
-static long lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
+static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 			   phys_size_t size)
 {
-	return lmb_add_region_flags(rgn, base, size, LMB_NONE);
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
 }
 
 /* This routine may be called with relocation disabled. */
-long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+long lmb_add(phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *_rgn = &(lmb->memory);
+	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
-	return lmb_add_region(_rgn, base, size);
+	return lmb_add_region(lmb_rgn_lst, base, size);
 }
 
-long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+long lmb_free(phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *rgn = &(lmb->reserved);
+	struct lmb_region *rgn;
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
 
 	rgnbegin = rgnend = 0; /* supress gcc warnings */
-
+	rgn = lmb_rgn_lst->data;
 	/* Find the region where (base, size) belongs to */
-	for (i = 0; i < rgn->cnt; i++) {
-		rgnbegin = rgn->region[i].base;
-		rgnend = rgnbegin + rgn->region[i].size - 1;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		rgnbegin = rgn[i].base;
+		rgnend = rgnbegin + rgn[i].size - 1;
 
 		if ((rgnbegin <= base) && (end <= rgnend))
 			break;
 	}
 
 	/* Didn't find the region */
-	if (i == rgn->cnt)
+	if (i == lmb_rgn_lst->count)
 		return -1;
 
 	/* Check to see if we are removing entire region */
 	if ((rgnbegin == base) && (rgnend == end)) {
-		lmb_remove_region(rgn, i);
+		lmb_remove_region(lmb_rgn_lst, i);
 		return 0;
 	}
 
 	/* Check to see if region is matching at the front */
 	if (rgnbegin == base) {
-		rgn->region[i].base = end + 1;
-		rgn->region[i].size -= size;
+		rgn[i].base = end + 1;
+		rgn[i].size -= size;
 		return 0;
 	}
 
 	/* Check to see if the region is matching at the end */
 	if (rgnend == end) {
-		rgn->region[i].size -= size;
+		rgn[i].size -= size;
 		return 0;
 	}
 
@@ -402,37 +405,37 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	 * We need to split the entry -  adjust the current one to the
 	 * beginging of the hole and add the region after hole.
 	 */
-	rgn->region[i].size = base - rgn->region[i].base;
-	return lmb_add_region_flags(rgn, end + 1, rgnend - end,
-				    rgn->region[i].flags);
+	rgn[i].size = base - rgn[i].base;
+	return lmb_add_region_flags(lmb_rgn_lst, end + 1, rgnend - end,
+				    rgn[i].flags);
 }
 
-long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
-		       enum lmb_flags flags)
+long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
-	struct lmb_region *_rgn = &(lmb->reserved);
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
-	return lmb_add_region_flags(_rgn, base, size, flags);
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
 
-long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+long lmb_reserve(phys_addr_t base, phys_size_t size)
 {
-	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
+	return lmb_reserve_flags(base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
+static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 				phys_size_t size)
 {
 	unsigned long i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
 			break;
 	}
 
-	return (i < rgn->cnt) ? i : -1;
+	return (i < lmb_rgn_lst->count) ? i : -1;
 }
 
 static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
@@ -440,16 +443,18 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 	return addr & ~(size - 1);
 }
 
-static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
-				    ulong align, phys_addr_t max_addr)
+static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
+				    phys_addr_t max_addr)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
-	for (i = lmb->memory.cnt - 1; i >= 0; i--) {
-		phys_addr_t lmbbase = lmb->memory.region[i].base;
-		phys_size_t lmbsize = lmb->memory.region[i].size;
+	for (i = lmb.free_mem.count - 1; i >= 0; i--) {
+		phys_addr_t lmbbase = lmb_memory[i].base;
+		phys_size_t lmbsize = lmb_memory[i].size;
 
 		if (lmbsize < size)
 			continue;
@@ -465,15 +470,16 @@ static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
 			continue;
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb->reserved, base, size);
+			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region(&lmb->reserved, base,
+				if (lmb_add_region(&lmb.used_mem, base,
 						   size) < 0)
 					return 0;
 				return base;
 			}
-			res_base = lmb->reserved.region[rgn].base;
+
+			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
 			base = lmb_align_down(res_base - size, align);
@@ -482,16 +488,16 @@ static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
 	return 0;
 }
 
-phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
+phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 {
-	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
+	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
 }
 
-phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_addr_t max_addr)
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(lmb, size, align, max_addr);
+	alloc = __lmb_alloc_base(size, align, max_addr);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -504,22 +510,23 @@ phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align, phys_
  * Try to allocate a specific address range: must be in defined memory but not
  * reserved
  */
-phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 {
 	long rgn;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, base, size);
+	rgn = lmb_overlaps_region(&lmb.free_mem, base, size);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
 		 * region we found.
 		 */
-		if (lmb_addrs_overlap(lmb->memory.region[rgn].base,
-				      lmb->memory.region[rgn].size,
+		if (lmb_addrs_overlap(lmb_memory[rgn].base,
+				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (lmb_reserve(lmb, base, size) >= 0)
+			if (lmb_reserve(base, size) >= 0)
 				return base;
 		}
 	}
@@ -527,51 +534,100 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 }
 
 /* Return number of bytes from a given address that are free */
-phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
+phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
 	int i;
 	long rgn;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
+	struct lmb_region *lmb_memory = lmb.free_mem.data;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
+	rgn = lmb_overlaps_region(&lmb.free_mem, addr, 1);
 	if (rgn >= 0) {
-		for (i = 0; i < lmb->reserved.cnt; i++) {
-			if (addr < lmb->reserved.region[i].base) {
+		for (i = 0; i < lmb.used_mem.count; i++) {
+			if (addr < lmb_used[i].base) {
 				/* first reserved range > requested address */
-				return lmb->reserved.region[i].base - addr;
+				return lmb_used[i].base - addr;
 			}
-			if (lmb->reserved.region[i].base +
-			    lmb->reserved.region[i].size > addr) {
+			if (lmb_used[i].base +
+			    lmb_used[i].size > addr) {
 				/* requested addr is in this reserved range */
 				return 0;
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb->memory.region[lmb->memory.cnt - 1].base +
-		       lmb->memory.region[lmb->memory.cnt - 1].size - addr;
+		return lmb_memory[lmb.free_mem.count - 1].base +
+		       lmb_memory[lmb.free_mem.count - 1].size - addr;
 	}
 	return 0;
 }
 
-int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
+int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 {
 	int i;
+	struct lmb_region *lmb_used = lmb.used_mem.data;
 
-	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.region[i].base +
-			lmb->reserved.region[i].size - 1;
-		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
-			return (lmb->reserved.region[i].flags & flags) == flags;
+	for (i = 0; i < lmb.used_mem.count; i++) {
+		phys_addr_t upper = lmb_used[i].base +
+			lmb_used[i].size - 1;
+		if ((addr >= lmb_used[i].base) && (addr <= upper))
+			return (lmb_used[i].flags & flags) == flags;
 	}
 	return 0;
 }
 
-__weak void board_lmb_reserve(struct lmb *lmb)
+__weak void board_lmb_reserve(void)
 {
 	/* please define platform specific board_lmb_reserve() */
 }
 
-__weak void arch_lmb_reserve(struct lmb *lmb)
+__weak void arch_lmb_reserve(void)
 {
 	/* please define platform specific arch_lmb_reserve() */
 }
+
+static int lmb_setup(void)
+{
+	bool ret;
+
+	ret = alist_init(&lmb.free_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB free memory\n");
+		return -ENOMEM;
+	}
+
+	ret = alist_init(&lmb.used_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB used memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * lmb_init() - Initialise the LMB module
+ *
+ * Initialise the LMB lists needed for keeping the memory map. There
+ * are two lists, in form of alloced list data structure. One for the
+ * available memory, and one for the used memory. Initialise the two
+ * lists as part of board init. Add memory to the available memory
+ * list and reserve common areas by adding them to the used memory
+ * list.
+ *
+ * Return: 0 on success, -ve on error
+ */
+int lmb_init(void)
+{
+	int ret;
+
+	ret = lmb_setup();
+	if (ret) {
+		log_debug("Unable to init LMB\n");
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/net/tftp.c b/net/tftp.c
index 2e073183d5..c0a6210b9d 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -717,12 +717,11 @@ static void tftp_timeout_handler(void)
 static int tftp_init_load_addr(void)
 {
 #ifdef CONFIG_LMB
-	struct lmb lmb;
 	phys_size_t max_size;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
-	max_size = lmb_get_free_size(&lmb, image_load_addr);
+	max_size = lmb_get_free_size(image_load_addr);
 	if (!max_size)
 		return -1;
 
diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff..7cf809a8ef 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -73,12 +73,11 @@ static ulong wget_load_size;
  */
 static int wget_init_load_size(void)
 {
-	struct lmb lmb;
 	phys_size_t max_size;
 
-	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 
-	max_size = lmb_get_free_size(&lmb, image_load_addr);
+	max_size = lmb_get_free_size(image_load_addr);
 	if (!max_size)
 		return -1;
 
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 027848c3e2..34d2b141d8 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -200,7 +200,7 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
 		struct lmb lmb;
 
-		lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+		lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
 		ut_assertok(lmb_test_dump_all(uts, &lmb));
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 4b5b6e5e20..9f6b5633a7 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -12,6 +12,8 @@
 #include <test/test.h>
 #include <test/ut.h>
 
+extern struct lmb lmb;
+
 static inline bool lmb_is_nomap(struct lmb_property *m)
 {
 	return m->flags & LMB_NOMAP;
@@ -64,7 +66,6 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	const phys_addr_t ram_end = ram + ram_size;
 	const phys_addr_t alloc_64k_end = alloc_64k_addr + 0x10000;
 
-	struct lmb lmb;
 	long ret;
 	phys_addr_t a, a2, b, b2, c, d;
 
@@ -75,14 +76,12 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
-	lmb_init(&lmb);
-
 	if (ram0_size) {
-		ret = lmb_add(&lmb, ram0, ram0_size);
+		ret = lmb_add(ram0, ram0_size);
 		ut_asserteq(ret, 0);
 	}
 
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	if (ram0_size) {
@@ -98,67 +97,67 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	}
 
 	/* reserve 64KiB somewhere */
-	ret = lmb_reserve(&lmb, alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate somewhere, should be at the end of RAM */
-	a = lmb_alloc(&lmb, 4, 1);
+	a = lmb_alloc(4, 1);
 	ut_asserteq(a, ram_end - 4);
 	ASSERT_LMB(&lmb, 0, 0, 2, alloc_64k_addr, 0x10000,
 		   ram_end - 4, 4, 0, 0);
 	/* alloc below end of reserved region -> below reserved region */
-	b = lmb_alloc_base(&lmb, 4, 1, alloc_64k_end);
+	b = lmb_alloc_base(4, 1, alloc_64k_end);
 	ut_asserteq(b, alloc_64k_addr - 4);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0);
 
 	/* 2nd time */
-	c = lmb_alloc(&lmb, 4, 1);
+	c = lmb_alloc(4, 1);
 	ut_asserteq(c, ram_end - 8);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0);
-	d = lmb_alloc_base(&lmb, 4, 1, alloc_64k_end);
+	d = lmb_alloc_base(4, 1, alloc_64k_end);
 	ut_asserteq(d, alloc_64k_addr - 8);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
 
-	ret = lmb_free(&lmb, a, 4);
+	ret = lmb_free(a, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 	/* allocate again to ensure we get the same address */
-	a2 = lmb_alloc(&lmb, 4, 1);
+	a2 = lmb_alloc(4, 1);
 	ut_asserteq(a, a2);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
-	ret = lmb_free(&lmb, a2, 4);
+	ret = lmb_free(a2, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 
-	ret = lmb_free(&lmb, b, 4);
+	ret = lmb_free(b, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 	/* allocate again to ensure we get the same address */
-	b2 = lmb_alloc_base(&lmb, 4, 1, alloc_64k_end);
+	b2 = lmb_alloc_base(4, 1, alloc_64k_end);
 	ut_asserteq(b, b2);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
-	ret = lmb_free(&lmb, b2, 4);
+	ret = lmb_free(b2, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 
-	ret = lmb_free(&lmb, c, 4);
+	ret = lmb_free(c, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000, 0, 0);
-	ret = lmb_free(&lmb, d, 4);
+	ret = lmb_free(d, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -229,44 +228,41 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	const phys_size_t big_block_size = 0x10000000;
 	const phys_addr_t ram_end = ram + ram_size;
 	const phys_addr_t alloc_64k_addr = ram + 0x10000000;
-	struct lmb lmb;
 	long ret;
 	phys_addr_t a, b;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	/* reserve 64KiB in the middle of RAM */
-	ret = lmb_reserve(&lmb, alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate a big block, should be below reserved */
-	a = lmb_alloc(&lmb, big_block_size, 1);
+	a = lmb_alloc(big_block_size, 1);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 	/* allocate 2nd big block */
 	/* This should fail, printing an error */
-	b = lmb_alloc(&lmb, big_block_size, 1);
+	b = lmb_alloc(big_block_size, 1);
 	ut_asserteq(b, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 
-	ret = lmb_free(&lmb, a, big_block_size);
+	ret = lmb_free(a, big_block_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate too big block */
 	/* This should fail, printing an error */
-	a = lmb_alloc(&lmb, ram_size, 1);
+	a = lmb_alloc(ram_size, 1);
 	ut_asserteq(a, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -294,7 +290,6 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 {
 	const phys_size_t ram_size = 0x20000000;
 	const phys_addr_t ram_end = ram + ram_size;
-	struct lmb lmb;
 	long ret;
 	phys_addr_t a, b;
 	const phys_addr_t alloc_size_aligned = (alloc_size + align - 1) &
@@ -303,19 +298,17 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block */
-	a = lmb_alloc(&lmb, alloc_size, align);
+	a = lmb_alloc(alloc_size, align);
 	ut_assert(a != 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* allocate another block */
-	b = lmb_alloc(&lmb, alloc_size, align);
+	b = lmb_alloc(alloc_size, align);
 	ut_assert(b != 0);
 	if (alloc_size == alloc_size_aligned) {
 		ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size -
@@ -327,21 +320,21 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 			   - alloc_size_aligned, alloc_size, 0, 0);
 	}
 	/* and free them */
-	ret = lmb_free(&lmb, b, alloc_size);
+	ret = lmb_free(b, alloc_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
-	ret = lmb_free(&lmb, a, alloc_size);
+	ret = lmb_free(a, alloc_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block with base*/
-	b = lmb_alloc_base(&lmb, alloc_size, align, ram_end);
+	b = lmb_alloc_base(alloc_size, align, ram_end);
 	ut_assert(a == b);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* and free it */
-	ret = lmb_free(&lmb, b, alloc_size);
+	ret = lmb_free(b, alloc_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -385,34 +378,31 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0;
 	const phys_size_t ram_size = 0x20000000;
-	struct lmb lmb;
 	long ret;
 	phys_addr_t a, b;
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	/* allocate nearly everything */
-	a = lmb_alloc(&lmb, ram_size - 4, 1);
+	a = lmb_alloc(ram_size - 4, 1);
 	ut_asserteq(a, ram + 4);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* allocate the rest */
 	/* This should fail as the allocated address would be 0 */
-	b = lmb_alloc(&lmb, 4, 1);
+	b = lmb_alloc(4, 1);
 	ut_asserteq(b, 0);
 	/* check that this was an error by checking lmb */
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* check that this was an error by freeing b */
-	ret = lmb_free(&lmb, b, 4);
+	ret = lmb_free(b, 4);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(&lmb, a, ram_size - 4);
+	ret = lmb_free(a, ram_size - 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -425,42 +415,39 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
-	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
-	ret = lmb_reserve(&lmb, 0x40010000, 0x10000);
+	ret = lmb_reserve(0x40010000, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 	/* allocate overlapping region should fail */
-	ret = lmb_reserve(&lmb, 0x40011000, 0x10000);
+	ret = lmb_reserve(0x40011000, 0x10000);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 	/* allocate 3nd region */
-	ret = lmb_reserve(&lmb, 0x40030000, 0x10000);
+	ret = lmb_reserve(0x40030000, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40010000, 0x10000,
 		   0x40030000, 0x10000, 0, 0);
 	/* allocate 2nd region , This should coalesced all region into one */
-	ret = lmb_reserve(&lmb, 0x40020000, 0x10000);
+	ret = lmb_reserve(0x40020000, 0x10000);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x30000,
 		   0, 0, 0, 0);
 
 	/* allocate 2nd region, which should be added as first region */
-	ret = lmb_reserve(&lmb, 0x40000000, 0x8000);
+	ret = lmb_reserve(0x40000000, 0x8000);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x8000,
 		   0x40010000, 0x30000, 0, 0);
 
 	/* allocate 3rd region, coalesce with first and overlap with second */
-	ret = lmb_reserve(&lmb, 0x40008000, 0x10000);
+	ret = lmb_reserve(0x40008000, 0x10000);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
@@ -479,104 +466,101 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	const phys_size_t alloc_addr_a = ram + 0x8000000;
 	const phys_size_t alloc_addr_b = ram + 0x8000000 * 2;
 	const phys_size_t alloc_addr_c = ram + 0x8000000 * 3;
-	struct lmb lmb;
 	long ret;
 	phys_addr_t a, b, c, d, e;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(&lmb, alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(&lmb, alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(&lmb, alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
-	a = lmb_alloc_addr(&lmb, ram, alloc_addr_a - ram);
+	a = lmb_alloc_addr(ram, alloc_addr_a - ram);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
-	b = lmb_alloc_addr(&lmb, alloc_addr_a + 0x10000,
+	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
 			   alloc_addr_b - alloc_addr_a - 0x10000);
 	ut_asserteq(b, alloc_addr_a + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
-	c = lmb_alloc_addr(&lmb, alloc_addr_b + 0x10000,
+	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
 			   alloc_addr_c - alloc_addr_b - 0x10000);
 	ut_asserteq(c, alloc_addr_b + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000,
+	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
 			   ram_end - alloc_addr_c - 0x10000);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
 	/* allocating anything else should fail */
-	e = lmb_alloc(&lmb, 1, 1);
+	e = lmb_alloc(1, 1);
 	ut_asserteq(e, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(&lmb, d, ram_end - alloc_addr_c - 0x10000);
+	ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000);
 	ut_asserteq(ret, 0);
 
 	/* allocate at 3 points in free range */
 
-	d = lmb_alloc_addr(&lmb, ram_end - 4, 4);
+	d = lmb_alloc_addr(ram_end - 4, 4);
 	ut_asserteq(d, ram_end - 4);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
-	ret = lmb_free(&lmb, d, 4);
+	ret = lmb_free(d, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(&lmb, ram_end - 128, 4);
+	d = lmb_alloc_addr(ram_end - 128, 4);
 	ut_asserteq(d, ram_end - 128);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
-	ret = lmb_free(&lmb, d, 4);
+	ret = lmb_free(d, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000, 4);
+	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
-	ret = lmb_free(&lmb, d, 4);
+	ret = lmb_free(d, 4);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	/* allocate at the bottom */
-	ret = lmb_free(&lmb, a, alloc_addr_a - ram);
+	ret = lmb_free(a, alloc_addr_a - ram);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + 0x8000000, 0x10010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(&lmb, ram, 4);
+	d = lmb_alloc_addr(ram, 4);
 	ut_asserteq(d, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
-		ret = lmb_alloc_addr(&lmb, ram_end, 1);
+		ret = lmb_alloc_addr(ram_end, 1);
 		ut_asserteq(ret, 0);
 	}
 	if (ram != 0) {
-		ret = lmb_alloc_addr(&lmb, ram - 1, 1);
+		ret = lmb_alloc_addr(ram - 1, 1);
 		ut_asserteq(ret, 0);
 	}
 
@@ -606,48 +590,45 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	const phys_size_t alloc_addr_a = ram + 0x8000000;
 	const phys_size_t alloc_addr_b = ram + 0x8000000 * 2;
 	const phys_size_t alloc_addr_c = ram + 0x8000000 * 3;
-	struct lmb lmb;
 	long ret;
 	phys_size_t s;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(&lmb, alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(&lmb, alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(&lmb, alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* check addresses in between blocks */
-	s = lmb_get_free_size(&lmb, ram);
+	s = lmb_get_free_size(ram);
 	ut_asserteq(s, alloc_addr_a - ram);
-	s = lmb_get_free_size(&lmb, ram + 0x10000);
+	s = lmb_get_free_size(ram + 0x10000);
 	ut_asserteq(s, alloc_addr_a - ram - 0x10000);
-	s = lmb_get_free_size(&lmb, alloc_addr_a - 4);
+	s = lmb_get_free_size(alloc_addr_a - 4);
 	ut_asserteq(s, 4);
 
-	s = lmb_get_free_size(&lmb, alloc_addr_a + 0x10000);
+	s = lmb_get_free_size(alloc_addr_a + 0x10000);
 	ut_asserteq(s, alloc_addr_b - alloc_addr_a - 0x10000);
-	s = lmb_get_free_size(&lmb, alloc_addr_a + 0x20000);
+	s = lmb_get_free_size(alloc_addr_a + 0x20000);
 	ut_asserteq(s, alloc_addr_b - alloc_addr_a - 0x20000);
-	s = lmb_get_free_size(&lmb, alloc_addr_b - 4);
+	s = lmb_get_free_size(alloc_addr_b - 4);
 	ut_asserteq(s, 4);
 
-	s = lmb_get_free_size(&lmb, alloc_addr_c + 0x10000);
+	s = lmb_get_free_size(alloc_addr_c + 0x10000);
 	ut_asserteq(s, ram_end - alloc_addr_c - 0x10000);
-	s = lmb_get_free_size(&lmb, alloc_addr_c + 0x20000);
+	s = lmb_get_free_size(alloc_addr_c + 0x20000);
 	ut_asserteq(s, ram_end - alloc_addr_c - 0x20000);
-	s = lmb_get_free_size(&lmb, ram_end - 4);
+	s = lmb_get_free_size(ram_end - 4);
 	ut_asserteq(s, 4);
 
 	return 0;
@@ -680,11 +661,8 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 			+ 1) * CONFIG_LMB_MAX_REGIONS;
 	const phys_size_t blk_size = 0x10000;
 	phys_addr_t offset;
-	struct lmb lmb;
 	int ret, i;
 
-	lmb_init(&lmb);
-
 	ut_asserteq(lmb.memory.cnt, 0);
 	ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -693,7 +671,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 	/*  Add CONFIG_LMB_MAX_REGIONS memory regions */
 	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
 		offset = ram + 2 * i * ram_size;
-		ret = lmb_add(&lmb, offset, ram_size);
+		ret = lmb_add(offset, ram_size);
 		ut_asserteq(ret, 0);
 	}
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
@@ -701,7 +679,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	/*  error for the (CONFIG_LMB_MAX_REGIONS + 1) memory regions */
 	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * ram_size;
-	ret = lmb_add(&lmb, offset, ram_size);
+	ret = lmb_add(offset, ram_size);
 	ut_asserteq(ret, -1);
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
@@ -710,7 +688,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 	/*  reserve CONFIG_LMB_MAX_REGIONS regions */
 	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
 		offset = ram + 2 * i * blk_size;
-		ret = lmb_reserve(&lmb, offset, blk_size);
+		ret = lmb_reserve(offset, blk_size);
 		ut_asserteq(ret, 0);
 	}
 
@@ -719,7 +697,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	/*  error for the 9th reserved blocks */
 	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * blk_size;
-	ret = lmb_reserve(&lmb, offset, blk_size);
+	ret = lmb_reserve(offset, blk_size);
 	ut_asserteq(ret, -1);
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
@@ -741,28 +719,25 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
-	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
-	ret = lmb_add(&lmb, ram, ram_size);
+	ret = lmb_add(ram, ram_size);
 	ut_asserteq(ret, 0);
 
 	/* reserve, same flag */
-	ret = lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, same flag */
-	ret = lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, new flag */
-	ret = lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NONE);
+	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
@@ -770,20 +745,20 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 
 	/* merge after */
-	ret = lmb_reserve_flags(&lmb, 0x40020000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x20000,
 		   0, 0, 0, 0);
 
 	/* merge before */
-	ret = lmb_reserve_flags(&lmb, 0x40000000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40000000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 
-	ret = lmb_reserve_flags(&lmb, 0x40030000, 0x10000, LMB_NONE);
+	ret = lmb_reserve_flags(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x10000, 0, 0);
@@ -792,7 +767,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
 
 	/* test that old API use LMB_NONE */
-	ret = lmb_reserve(&lmb, 0x40040000, 0x10000);
+	ret = lmb_reserve(0x40040000, 0x10000);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
@@ -800,18 +775,18 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
 
-	ret = lmb_reserve_flags(&lmb, 0x40070000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40070000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40070000, 0x10000);
 
-	ret = lmb_reserve_flags(&lmb, 0x40050000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40050000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 4, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x10000);
 
 	/* merge with 2 adjacent regions */
-	ret = lmb_reserve_flags(&lmb, 0x40060000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve_flags(0x40060000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 2);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
-- 
2.34.1

