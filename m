Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898FC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D9F8891C;
	Wed, 24 Jul 2024 08:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256C58891B; Wed, 24 Jul 2024 08:04:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 89B4D88906
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AE961476;
 Tue, 23 Jul 2024 23:05:07 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 641EB3F766;
 Tue, 23 Jul 2024 23:04:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 23/40] lmb: add a flags parameter to the API's
Date: Wed, 24 Jul 2024 11:32:07 +0530
Message-Id: <20240724060224.3071065-24-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

Add a flags parameter to the LMB API functions. The parameter can then
be used to pass any other type of reservations or allocations needed
by the callers. These will be used in a subsequent set of changes for
allocation requests coming from the EFI subsystem.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc: New patch

 arch/arm/mach-apple/board.c       |  17 ++--
 arch/arm/mach-snapdragon/board.c  |   2 +-
 arch/arm/mach-stm32mp/dram_init.c |   4 +-
 arch/powerpc/cpu/mpc85xx/mp.c     |   2 +-
 arch/powerpc/lib/bootm.c          |   2 +-
 board/xilinx/common/board.c       |   4 +-
 boot/bootm.c                      |   5 +-
 boot/image-board.c                |  15 ++-
 boot/image-fdt.c                  |  15 +--
 cmd/booti.c                       |   2 +-
 cmd/bootz.c                       |   2 +-
 cmd/load.c                        |   4 +-
 drivers/iommu/apple_dart.c        |   6 +-
 drivers/iommu/sandbox_iommu.c     |   6 +-
 fs/fs.c                           |   2 +-
 include/lmb.h                     |  23 ++---
 lib/lmb.c                         |  48 ++++------
 test/lib/lmb.c                    | 150 +++++++++++++++---------------
 18 files changed, 150 insertions(+), 159 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 0b6d290b8a..72b1ab9053 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -778,15 +778,18 @@ int board_late_init(void)
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
 	 */
-	status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
-	status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
-	status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
-	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
+	status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M, LMB_NONE));
+	status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M, LMB_NONE));
+	status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M,
+							 LMB_NONE));
+	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M,
+							  LMB_NONE));
 	status |= env_set_hex("kernel_comp_addr_r",
-			      lmb_alloc(KERNEL_COMP_SIZE, SZ_2M));
+			      lmb_alloc(KERNEL_COMP_SIZE, SZ_2M, LMB_NONE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
-	status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M, SZ_2M));
-	status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M, SZ_2M));
+	status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M, SZ_2M, LMB_NONE));
+	status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M, SZ_2M,
+							  LMB_NONE));
 
 	if (status)
 		log_warning("late_init: Failed to set run time variables\n");
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 22a7d2a637..151d36d7eb 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -275,7 +275,7 @@ void __weak qcom_late_init(void)
 
 #define KERNEL_COMP_SIZE	SZ_64M
 
-#define addr_alloc(size) lmb_alloc(size, SZ_2M)
+#define addr_alloc(size) lmb_alloc(size, SZ_2M, LMB_NONE)
 
 /* Stolen from arch/arm/mach-apple/board.c */
 int board_late_init(void)
diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index e8b0a38be1..97d894d05f 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -58,11 +58,11 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_add(gd->ram_base, gd->ram_top - gd->ram_base);
+	lmb_add(gd->ram_base, gd->ram_top - gd->ram_base, LMB_NONE);
 	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
 	/* add 8M for reserved memory for display, fdt, gd,... */
 	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE),
-	reg = lmb_alloc(size, MMU_SECTION_SIZE);
+	reg = lmb_alloc(size, MMU_SECTION_SIZE, LMB_NONE);
 
 	if (!reg)
 		reg = gd->ram_top - size;
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index bed465cb2c..8918a401fa 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -412,7 +412,7 @@ void cpu_mp_lmb_reserve(void)
 {
 	u32 bootpg = determine_mp_bootpg(NULL);
 
-	lmb_reserve(bootpg, 4096);
+	lmb_reserve(bootpg, 4096, LMB_NONE);
 }
 
 void setup_mp(void)
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 6c35664ff3..350cddf1dd 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -139,7 +139,7 @@ void arch_lmb_reserve(void)
 		ulong base = bootmap_base + size;
 		printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
 		       size, (unsigned long long)bootm_size);
-		lmb_reserve(base, bootm_size - size);
+		lmb_reserve(base, bootm_size - size, LMB_NONE);
 	}
 
 	arch_lmb_reserve_generic(get_sp(), gd->ram_top, 4096);
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f04c92a70f..1fcf7c3d8f 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -683,10 +683,10 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_add(gd->ram_base, gd->ram_size);
+	lmb_add(gd->ram_base, gd->ram_size, LMB_NONE);
 	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
 	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
-	reg = lmb_alloc(size, MMU_SECTION_SIZE);
+	reg = lmb_alloc(size, MMU_SECTION_SIZE, LMB_NONE);
 
 	if (!reg)
 		reg = gd->ram_top - size;
diff --git a/boot/bootm.c b/boot/bootm.c
index 2689f36977..9feedd72da 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -621,7 +621,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		ulong req_size = ALIGN(image_len * 4, SZ_1M);
 
-		load = lmb_alloc(req_size, SZ_2M);
+		load = lmb_alloc(req_size, SZ_2M, LMB_NONE);
 		if (!load)
 			return 1;
 		os.load = load;
@@ -696,7 +696,8 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	}
 
 	if (CONFIG_IS_ENABLED(LMB))
-		lmb_reserve(images->os.load, (load_end - images->os.load));
+		lmb_reserve(images->os.load, (load_end - images->os.load),
+			    LMB_NONE);
 
 	return 0;
 }
diff --git a/boot/image-board.c b/boot/image-board.c
index 99ee7968ba..b3281d66a4 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -560,15 +560,17 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 			debug("   in-place initrd\n");
 			*initrd_start = rd_data;
 			*initrd_end = rd_data + rd_len;
-			lmb_reserve(rd_data, rd_len);
+			lmb_reserve(rd_data, rd_len, LMB_NONE);
 		} else {
 			if (initrd_high)
 				*initrd_start = (ulong)lmb_alloc_base(rd_len,
 								      0x1000,
-								      initrd_high);
+								      initrd_high,
+								      LMB_NONE);
 			else
 				*initrd_start = (ulong)lmb_alloc(rd_len,
-								 0x1000);
+								 0x1000,
+								 LMB_NONE);
 
 			if (*initrd_start == 0) {
 				puts("ramdisk - allocation error\n");
@@ -827,7 +829,9 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 
 	barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
 	cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
-				env_get_bootm_mapsize() + env_get_bootm_low());
+						env_get_bootm_mapsize() +
+						env_get_bootm_low(),
+						LMB_NONE);
 	if (!cmdline)
 		return -1;
 
@@ -862,7 +866,8 @@ int boot_get_kbd(struct bd_info **kbd)
 	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
 						       0xf,
 						       env_get_bootm_mapsize() +
-						       env_get_bootm_low());
+						       env_get_bootm_low(),
+						       LMB_NONE);
 	if (!*kbd)
 		return -1;
 
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index ccafadec0d..589e84c950 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -73,7 +73,7 @@ static void boot_fdt_reserve_region(uint64_t addr, uint64_t size,
 {
 	long ret;
 
-	ret = lmb_reserve_flags(addr, size, flags);
+	ret = lmb_reserve(addr, size, flags);
 	if (ret >= 0) {
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
@@ -185,17 +185,18 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 		if (desired_addr == ~0UL) {
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
-			lmb_reserve(map_to_sysmem(of_start), of_len);
+			lmb_reserve(map_to_sysmem(of_start), of_len, LMB_NONE);
 			disable_relocation = 1;
 		} else if (desired_addr) {
-			addr = lmb_alloc_base(of_len, 0x1000, desired_addr);
+			addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
+					      LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			if (of_start == NULL) {
 				puts("Failed using fdt_high value for Device Tree");
 				goto error;
 			}
 		} else {
-			addr = lmb_alloc(of_len, 0x1000);
+			addr = lmb_alloc(of_len, 0x1000, LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 		}
 	} else {
@@ -217,7 +218,7 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			 * for LMB allocation.
 			 */
 			usable = min(start + size, low + mapsize);
-			addr = lmb_alloc_base(of_len, 0x1000, usable);
+			addr = lmb_alloc_base(of_len, 0x1000, usable, LMB_NONE);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
@@ -667,7 +668,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 
 	/* Delete the old LMB reservation */
 	if (CONFIG_IS_ENABLED(LMB) && lmb)
-		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob));
+		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob), LMB_NONE);
 
 	ret = fdt_shrink_to_minimum(blob, 0);
 	if (ret < 0)
@@ -676,7 +677,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 
 	/* Create a new LMB reservation */
 	if (CONFIG_IS_ENABLED(LMB) && lmb)
-		lmb_reserve(map_to_sysmem(blob), of_size);
+		lmb_reserve(map_to_sysmem(blob), of_size, LMB_NONE);
 
 #if defined(CONFIG_ARCH_KEYSTONE)
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
diff --git a/cmd/booti.c b/cmd/booti.c
index 6018cbacf0..b26ad1c6a4 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -87,7 +87,7 @@ static int booti_start(struct bootm_info *bmi)
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
-	lmb_reserve(images->ep, le32_to_cpu(image_size));
+	lmb_reserve(images->ep, le32_to_cpu(image_size), LMB_NONE);
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 787203f5bd..99318ff213 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -56,7 +56,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret != 0)
 		return 1;
 
-	lmb_reserve(images->ep, zi_end - zi_start);
+	lmb_reserve(images->ep, zi_end - zi_start, LMB_NONE);
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/load.c b/cmd/load.c
index 20d802502a..489c13dde0 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -179,7 +179,7 @@ static ulong load_serial(long offset)
 		    {
 			void *dst;
 
-			ret = lmb_reserve(store_addr, binlen);
+			ret = lmb_reserve(store_addr, binlen, LMB_NONE);
 			if (ret) {
 				printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
 					store_addr, store_addr + binlen);
@@ -188,7 +188,7 @@ static ulong load_serial(long offset)
 			dst = map_sysmem(store_addr, binlen);
 			memcpy(dst, binbuf, binlen);
 			unmap_sysmem(dst);
-			lmb_free(store_addr, binlen);
+			lmb_free(store_addr, binlen, LMB_NONE);
 		    }
 		    if ((store_addr) < start_addr)
 			start_addr = store_addr;
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6d..b575cd44d4 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -123,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
 	off = (phys_addr_t)addr - paddr;
 	psize = ALIGN(size + off, DART_PAGE_SIZE);
 
-	dva = lmb_alloc(psize, DART_PAGE_SIZE);
+	dva = lmb_alloc(psize, DART_PAGE_SIZE, LMB_NONE);
 
 	idx = dva / DART_PAGE_SIZE;
 	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
@@ -159,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 			   (unsigned long)&priv->l2[idx + i]);
 	priv->flush_tlb(priv);
 
-	lmb_free(dva, psize);
+	lmb_free(dva, psize, LMB_NONE);
 }
 
 static struct iommu_ops apple_dart_ops = {
@@ -212,7 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
-	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
+	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase, LMB_NONE);
 
 	/* Disable translations. */
 	for (sid = 0; sid < priv->nsid; sid++)
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index 5b4a6a8982..505f2c3250 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -21,7 +21,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 	off = virt_to_phys(addr) - paddr;
 	psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
 
-	dva = lmb_alloc(psize, IOMMU_PAGE_SIZE);
+	dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
 
 	return dva + off;
 }
@@ -36,7 +36,7 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 	psize = size + (addr - dva);
 	psize = ALIGN(psize, IOMMU_PAGE_SIZE);
 
-	lmb_free(dva, psize);
+	lmb_free(dva, psize, LMB_NONE);
 }
 
 static struct iommu_ops sandbox_iommu_ops = {
@@ -46,7 +46,7 @@ static struct iommu_ops sandbox_iommu_ops = {
 
 static int sandbox_iommu_probe(struct udevice *dev)
 {
-	lmb_add(0x89abc000, SZ_16K);
+	lmb_add(0x89abc000, SZ_16K, LMB_NONE);
 
 	return 0;
 }
diff --git a/fs/fs.c b/fs/fs.c
index 4bc28d1dff..4d7af46fc7 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -551,7 +551,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 
 	lmb_dump_all();
 
-	if (lmb_alloc_addr(addr, read_len) == addr)
+	if (lmb_alloc_addr(addr, read_len, LMB_NONE) == addr)
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/lmb.h b/include/lmb.h
index cc4cf9f3c8..c90f167eec 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -59,21 +59,12 @@ int initr_lmb(void);
  */
 void lmb_add_memory(void);
 
-long lmb_add(phys_addr_t base, phys_size_t size);
-long lmb_reserve(phys_addr_t base, phys_size_t size);
-/**
- * lmb_reserve_flags - Reserve one region with a specific flags bitfield.
- *
- * @base:	base address of the memory region
- * @size:	size of the memory region
- * @flags:	flags for the memory region
- * Return:	0 if OK, > 0 for coalesced region or a negative error code.
- */
-long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
-		       enum lmb_flags flags);
-phys_addr_t lmb_alloc(phys_size_t size, ulong align);
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
+long lmb_add(phys_addr_t base, phys_size_t size, uint flags);
+long lmb_reserve(phys_addr_t base, phys_size_t size, uint flags);
+phys_addr_t lmb_alloc(phys_size_t size, ulong align, uint flags);
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
+			   uint flags);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 /**
@@ -88,7 +79,7 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
  */
 int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
-long lmb_free(phys_addr_t base, phys_size_t size);
+long lmb_free(phys_addr_t base, phys_size_t size, uint flags);
 
 void lmb_dump_all(void);
 void lmb_dump_all_force(void);
diff --git a/lib/lmb.c b/lib/lmb.c
index 5baa5c4c52..ed5988bb1b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -174,11 +174,11 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
 		if (bank_end > end)
 			bank_end = end - 1;
 
-		lmb_reserve_flags(sp, bank_end - sp + 1, LMB_NOOVERWRITE);
+		lmb_reserve(sp, bank_end - sp + 1, LMB_NOOVERWRITE);
 
 		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
-				    gd->mon_len, LMB_NOOVERWRITE);
+			lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
+				    LMB_NOOVERWRITE);
 
 		break;
 	}
@@ -204,7 +204,7 @@ static __maybe_unused int efi_lmb_reserve(void)
 
 	for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
 		if (map->type != EFI_CONVENTIONAL_MEMORY) {
-			lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
+			lmb_reserve(map_to_sysmem((void *)(uintptr_t)
 							map->physical_start),
 					  map->num_pages * EFI_PAGE_SIZE,
 					  map->type == EFI_RESERVED_MEMORY_TYPE
@@ -240,7 +240,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	if (IS_ENABLED(CONFIG_SPL_STACK_R_ADDR)) {
 		rsv_start = gd->start_addr_sp - 16384;
 		rsv_size = 16384;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, rsv_size, LMB_NOOVERWRITE);
 	}
 
 	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)) {
@@ -248,7 +248,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 		rsv_start = (phys_addr_t)(uintptr_t)__bss_start;
 		rsv_size = (phys_addr_t)(uintptr_t)__bss_end -
 			(phys_addr_t)(uintptr_t)__bss_start;
-		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+		lmb_reserve(rsv_start, rsv_size, LMB_NOOVERWRITE);
 	}
 }
 
@@ -287,7 +287,7 @@ __weak void lmb_add_memory(void)
 			if (rgn_top > ram_top)
 				size -= rgn_top - ram_top;
 
-			lmb_add(bd->bi_dram[i].start, size);
+			lmb_add(bd->bi_dram[i].start, size, LMB_NONE);
 		}
 	}
 }
@@ -496,21 +496,15 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	return 0;
 }
 
-static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
-			   phys_size_t size)
-{
-	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
-}
-
 /* This routine may be called with relocation disabled. */
-long lmb_add(phys_addr_t base, phys_size_t size)
+long lmb_add(phys_addr_t base, phys_size_t size, uint flags)
 {
 	struct alist *lmb_rgn_lst = &lmb_free_mem;
 
-	return lmb_add_region(lmb_rgn_lst, base, size);
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
+long lmb_free(phys_addr_t base, phys_size_t size, uint flags)
 {
 	struct lmb_region *rgn;
 	struct alist *lmb_rgn_lst = &lmb_used_mem;
@@ -561,18 +555,13 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn[i].flags);
 }
 
-long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
+long lmb_reserve(phys_addr_t base, phys_size_t size, uint flags)
 {
 	struct alist *lmb_rgn_lst = &lmb_used_mem;
 
 	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
 
-long lmb_reserve(phys_addr_t base, phys_size_t size)
-{
-	return lmb_reserve_flags(base, size, LMB_NONE);
-}
-
 static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 				phys_size_t size)
 {
@@ -639,16 +628,17 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 	return 0;
 }
 
-phys_addr_t lmb_alloc(phys_size_t size, ulong align)
+phys_addr_t lmb_alloc(phys_size_t size, ulong align, uint flags)
 {
-	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
+	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, flags);
 }
 
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
+phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
+			   uint flags)
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
+	alloc = __lmb_alloc_base(size, align, max_addr, flags);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -674,7 +664,7 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (lmb_reserve_flags(base, size, flags) >= 0)
+			if (lmb_reserve(base, size, flags) >= 0)
 				return base;
 		}
 	}
@@ -686,9 +676,9 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
  * Try to allocate a specific address range: must be in defined memory but not
  * reserved
  */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags)
 {
-	return __lmb_alloc_addr(base, size, LMB_NONE);
+	return __lmb_alloc_addr(base, size, flags);
 }
 
 /* Return number of bytes from a given address that are free */
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index a3a7ad904c..3f99156cf3 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -77,11 +77,11 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
 	if (ram0_size) {
-		ret = lmb_add(ram0, ram0_size);
+		ret = lmb_add(ram0, ram0_size, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	if (ram0_size) {
@@ -97,67 +97,67 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	}
 
 	/* reserve 64KiB somewhere */
-	ret = lmb_reserve(alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate somewhere, should be at the end of RAM */
-	a = lmb_alloc(4, 1);
+	a = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(a, ram_end - 4);
 	ASSERT_LMB(&lmb, 0, 0, 2, alloc_64k_addr, 0x10000,
 		   ram_end - 4, 4, 0, 0);
 	/* alloc below end of reserved region -> below reserved region */
-	b = lmb_alloc_base(4, 1, alloc_64k_end);
+	b = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, alloc_64k_addr - 4);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0);
 
 	/* 2nd time */
-	c = lmb_alloc(4, 1);
+	c = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(c, ram_end - 8);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0);
-	d = lmb_alloc_base(4, 1, alloc_64k_end);
+	d = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(d, alloc_64k_addr - 8);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
 
-	ret = lmb_free(a, 4);
+	ret = lmb_free(a, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 	/* allocate again to ensure we get the same address */
-	a2 = lmb_alloc(4, 1);
+	a2 = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(a, a2);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
-	ret = lmb_free(a2, 4);
+	ret = lmb_free(a2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 
-	ret = lmb_free(b, 4);
+	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 	/* allocate again to ensure we get the same address */
-	b2 = lmb_alloc_base(4, 1, alloc_64k_end);
+	b2 = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, b2);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
-	ret = lmb_free(b2, 4);
+	ret = lmb_free(b2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 
-	ret = lmb_free(c, 4);
+	ret = lmb_free(c, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 2,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -234,35 +234,35 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* reserve 64KiB in the middle of RAM */
-	ret = lmb_reserve(alloc_64k_addr, 0x10000);
+	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate a big block, should be below reserved */
-	a = lmb_alloc(big_block_size, 1);
+	a = lmb_alloc(big_block_size, 1, LMB_NONE);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 	/* allocate 2nd big block */
 	/* This should fail, printing an error */
-	b = lmb_alloc(big_block_size, 1);
+	b = lmb_alloc(big_block_size, 1, LMB_NONE);
 	ut_asserteq(b, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 
-	ret = lmb_free(a, big_block_size);
+	ret = lmb_free(a, big_block_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate too big block */
 	/* This should fail, printing an error */
-	a = lmb_alloc(ram_size, 1);
+	a = lmb_alloc(ram_size, 1, LMB_NONE);
 	ut_asserteq(a, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -298,17 +298,17 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block */
-	a = lmb_alloc(alloc_size, align);
+	a = lmb_alloc(alloc_size, align, LMB_NONE);
 	ut_assert(a != 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* allocate another block */
-	b = lmb_alloc(alloc_size, align);
+	b = lmb_alloc(alloc_size, align, LMB_NONE);
 	ut_assert(b != 0);
 	if (alloc_size == alloc_size_aligned) {
 		ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size -
@@ -320,21 +320,21 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 			   - alloc_size_aligned, alloc_size, 0, 0);
 	}
 	/* and free them */
-	ret = lmb_free(b, alloc_size);
+	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
-	ret = lmb_free(a, alloc_size);
+	ret = lmb_free(a, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block with base*/
-	b = lmb_alloc_base(alloc_size, align, ram_end);
+	b = lmb_alloc_base(alloc_size, align, ram_end, LMB_NONE);
 	ut_assert(a == b);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* and free it */
-	ret = lmb_free(b, alloc_size);
+	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -381,28 +381,28 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	long ret;
 	phys_addr_t a, b;
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* allocate nearly everything */
-	a = lmb_alloc(ram_size - 4, 1);
+	a = lmb_alloc(ram_size - 4, 1, LMB_NONE);
 	ut_asserteq(a, ram + 4);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* allocate the rest */
 	/* This should fail as the allocated address would be 0 */
-	b = lmb_alloc(4, 1);
+	b = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(b, 0);
 	/* check that this was an error by checking lmb */
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* check that this was an error by freeing b */
-	ret = lmb_free(b, 4);
+	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(a, ram_size - 4);
+	ret = lmb_free(a, ram_size - 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -417,37 +417,37 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	const phys_size_t ram_size = 0x20000000;
 	long ret;
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
-	ret = lmb_reserve(0x40010000, 0x10000);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 	/* allocate overlapping region should fail */
-	ret = lmb_reserve(0x40011000, 0x10000);
+	ret = lmb_reserve(0x40011000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 	/* allocate 3nd region */
-	ret = lmb_reserve(0x40030000, 0x10000);
+	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40010000, 0x10000,
 		   0x40030000, 0x10000, 0, 0);
 	/* allocate 2nd region , This should coalesced all region into one */
-	ret = lmb_reserve(0x40020000, 0x10000);
+	ret = lmb_reserve(0x40020000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x30000,
 		   0, 0, 0, 0);
 
 	/* allocate 2nd region, which should be added as first region */
-	ret = lmb_reserve(0x40000000, 0x8000);
+	ret = lmb_reserve(0x40000000, 0x8000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x8000,
 		   0x40010000, 0x30000, 0, 0);
 
 	/* allocate 3rd region, coalesce with first and overlap with second */
-	ret = lmb_reserve(0x40008000, 0x10000);
+	ret = lmb_reserve(0x40008000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
@@ -472,95 +472,95 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
-	a = lmb_alloc_addr(ram, alloc_addr_a - ram);
+	a = lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
-			   alloc_addr_b - alloc_addr_a - 0x10000);
+			   alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
 	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
-			   alloc_addr_c - alloc_addr_b - 0x10000);
+			   alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
 	ut_asserteq(c, alloc_addr_b + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
-			   ram_end - alloc_addr_c - 0x10000);
+			   ram_end - alloc_addr_c - 0x10000, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
 	/* allocating anything else should fail */
-	e = lmb_alloc(1, 1);
+	e = lmb_alloc(1, 1, LMB_NONE);
 	ut_asserteq(e, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000);
+	ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* allocate at 3 points in free range */
 
-	d = lmb_alloc_addr(ram_end - 4, 4);
+	d = lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 4);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(ram_end - 128, 4);
+	d = lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 128);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4);
+	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	/* allocate at the bottom */
-	ret = lmb_free(a, alloc_addr_a - ram);
+	ret = lmb_free(a, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + 0x8000000, 0x10010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(ram, 4);
+	d = lmb_alloc_addr(ram, 4, LMB_NONE);
 	ut_asserteq(d, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
-		ret = lmb_alloc_addr(ram_end, 1);
+		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 	if (ram != 0) {
-		ret = lmb_alloc_addr(ram - 1, 1);
+		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 
@@ -596,15 +596,15 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-	ret = lmb_reserve(alloc_addr_a, 0x10000);
+	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_b, 0x10000);
+	ret = lmb_reserve(alloc_addr_b, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_reserve(alloc_addr_c, 0x10000);
+	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
@@ -654,23 +654,23 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	const phys_size_t ram_size = 0x20000000;
 	long ret;
 
-	ret = lmb_add(ram, ram_size);
+	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* reserve, same flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, same flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, new flag */
-	ret = lmb_reserve_flags(0x40010000, 0x10000, LMB_NONE);
+	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
@@ -678,20 +678,20 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 
 	/* merge after */
-	ret = lmb_reserve_flags(0x40020000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40020000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x20000,
 		   0, 0, 0, 0);
 
 	/* merge before */
-	ret = lmb_reserve_flags(0x40000000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40000000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 
-	ret = lmb_reserve_flags(0x40030000, 0x10000, LMB_NONE);
+	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x10000, 0, 0);
@@ -700,7 +700,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
 
 	/* test that old API use LMB_NONE */
-	ret = lmb_reserve(0x40040000, 0x10000);
+	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 1);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
@@ -708,18 +708,18 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
 	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
 
-	ret = lmb_reserve_flags(0x40070000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40070000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40070000, 0x10000);
 
-	ret = lmb_reserve_flags(0x40050000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40050000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 4, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x10000);
 
 	/* merge with 2 adjacent regions */
-	ret = lmb_reserve_flags(0x40060000, 0x10000, LMB_NOMAP);
+	ret = lmb_reserve(0x40060000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 2);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
-- 
2.34.1

