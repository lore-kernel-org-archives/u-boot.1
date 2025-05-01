Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58693C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875C980EFB;
	Thu,  1 May 2025 14:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F2180EFB; Thu,  1 May 2025 14:03:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 352518056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E80168F;
 Thu,  1 May 2025 05:02:54 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586E43F673;
 Thu,  1 May 2025 05:02:58 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/5] lmb: replace lmb_reserve() and lmb_alloc_addr() API's
Date: Thu,  1 May 2025 17:32:35 +0530
Message-Id: <20250501120239.199829-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501120239.199829-1-sughosh.ganu@linaro.org>
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
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

There currently are multiple allocation API's in the LMB module. There
are a couple of API's for allocating memory(lmb_alloc() and
lmb_alloc_base()), and then there are two for requesting a reservation
for a particular memory region (lmb_reserve() and
lmb_alloc_addr()). Introduce a single API lmb_allocate_mem() which
will cater to all types of allocation requests and replace
lmb_reserve() and lmb_alloc_addr() with the new API.

Moreover, the lmb_reserve() API is pretty similar to the
lmb_alloc_addr() API, with the one difference being that the
lmb_reserve() API allows for reserving any address passed to it --
the address need not be part of the LMB memory map. The
lmb_alloc_addr() does check that the address being requested is
actually part of the LMB memory map.

There is no need to support reserving memory regions which are outside
the LMB memory map. Remove the lmb_reserve() API functionality and use
the functionality provided by lmb_alloc_addr() instead. The
lmb_alloc_addr() will check if the requested address is part of the
LMB memory map and return an error if not.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 arch/arm/mach-mediatek/tzcfg.c |   8 +-
 arch/powerpc/cpu/mpc85xx/mp.c  |   4 +-
 arch/powerpc/lib/misc.c        |   5 +-
 boot/bootm.c                   |   5 +-
 boot/image-board.c             |   4 +-
 boot/image-fdt.c               |  33 +++++++--
 cmd/booti.c                    |   8 +-
 cmd/bootz.c                    |   8 +-
 cmd/load.c                     |   4 +-
 fs/fs.c                        |   3 +-
 include/lmb.h                  |  65 ++++++++--------
 lib/efi_loader/efi_memory.c    |   2 +-
 lib/lmb.c                      | 131 +++++++++++++++++++--------------
 test/lib/lmb.c                 |  27 +++++--
 14 files changed, 196 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-mediatek/tzcfg.c b/arch/arm/mach-mediatek/tzcfg.c
index 71982ba4d20..4dbefd2488d 100644
--- a/arch/arm/mach-mediatek/tzcfg.c
+++ b/arch/arm/mach-mediatek/tzcfg.c
@@ -173,6 +173,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 int arch_misc_init(void)
 {
+	phys_addr_t addr;
 	struct arm_smccc_res res;
 
 	/*
@@ -180,11 +181,14 @@ int arch_misc_init(void)
 	 * there's no need to check the result
 	 */
 	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
-	lmb_reserve(res.a1, res.a2, LMB_NOMAP);
+	addr = (phys_addr_t)res.a1;
+	lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, res.a2, LMB_NOMAP);
 
 	arm_smccc_smc(MTK_SIP_GET_BL32_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	addr = (phys_addr_t)res.a1;
 	if (!res.a0 && res.a1 && res.a2)
-		lmb_reserve(res.a1, res.a2, LMB_NOMAP);
+		lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, res.a2,
+				 LMB_NOMAP);
 
 #if IS_ENABLED(CONFIG_CMD_PSTORE)
 	char cmd[64];
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index 8918a401fac..f26583e1d5d 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -410,9 +410,9 @@ static void plat_mp_up(unsigned long bootpg, unsigned int pagesize)
 
 void cpu_mp_lmb_reserve(void)
 {
-	u32 bootpg = determine_mp_bootpg(NULL);
+	phys_addr_t bootpg = determine_mp_bootpg(NULL);
 
-	lmb_reserve(bootpg, 4096, LMB_NONE);
+	lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &bootpg, 4096, LMB_NONE);
 }
 
 void setup_mp(void)
diff --git a/arch/powerpc/lib/misc.c b/arch/powerpc/lib/misc.c
index 7e303419624..fd5546a6af9 100644
--- a/arch/powerpc/lib/misc.c
+++ b/arch/powerpc/lib/misc.c
@@ -36,11 +36,12 @@ int arch_misc_init(void)
 		size = min(size, (ulong)CFG_SYS_LINUX_LOWMEM_MAX_SIZE);
 
 		if (size < bootm_size) {
-			ulong base = bootmap_base + size;
+			phys_addr_t base = bootmap_base + size;
 
 			printf("WARNING: adjusting available memory from 0x%lx to 0x%llx\n",
 			       size, (unsigned long long)bootm_size);
-			lmb_reserve(base, bootm_size - size, LMB_NONE);
+			lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &base,
+					 bootm_size - size, LMB_NONE);
 		}
 
 #ifdef CONFIG_MP
diff --git a/boot/bootm.c b/boot/bootm.c
index f5cbb10f0d1..b771fa6d965 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -697,8 +697,9 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	}
 
 	if (CONFIG_IS_ENABLED(LMB))
-		lmb_reserve(images->os.load, (load_end - images->os.load),
-			    LMB_NONE);
+		lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0,
+				 (void *)&images->os.load,
+				 (load_end - images->os.load), LMB_NONE);
 
 	return 0;
 }
diff --git a/boot/image-board.c b/boot/image-board.c
index 514f8e63f9c..aa93371d9a7 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -562,7 +562,9 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 			debug("   in-place initrd\n");
 			*initrd_start = rd_data;
 			*initrd_end = rd_data + rd_len;
-			lmb_reserve(rd_data, rd_len, LMB_NONE);
+			lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0,
+					 (void *)&rd_data,
+					 rd_len, LMB_NONE);
 		} else {
 			if (initrd_high)
 				*initrd_start =
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8f718ad29f6..6585813de00 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -73,12 +73,13 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
 {
 	long ret;
 
-	ret = lmb_reserve(addr, size, flags);
+	ret = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, (void *)&addr, size,
+			       flags);
 	if (!ret) {
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else if (ret != -EEXIST) {
+	} else if (ret != -EEXIST && ret != -EINVAL) {
 		puts("ERROR: reserving fdt memory region failed ");
 		printf("(addr=%llx size=%llx flags=%x)\n",
 		       (unsigned long long)addr,
@@ -155,7 +156,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
  */
 int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 {
-	u64	start, size, usable, addr, low, mapsize;
+	u64	start, size, usable, low, mapsize;
 	void	*fdt_blob = *of_flat_tree;
 	void	*of_start = NULL;
 	char	*fdt_high;
@@ -163,6 +164,7 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 	int	bank;
 	int	err;
 	int	disable_relocation = 0;
+	phys_addr_t addr;
 
 	/* nothing to do */
 	if (*of_size == 0)
@@ -184,8 +186,16 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 
 		if (desired_addr == ~0UL) {
 			/* All ones means use fdt in place */
-			of_start = fdt_blob;
-			lmb_reserve(map_to_sysmem(of_start), of_len, LMB_NONE);
+			addr = map_to_sysmem(fdt_blob);
+			err = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
+					       of_len, LMB_NONE);
+			if (err) {
+				printf("Failed to reserve memory for fdt at %#llx\n",
+				       (u64)addr);
+				goto error;
+			}
+
+			of_start = (void *)(uintptr_t)addr;
 			disable_relocation = 1;
 		} else if (desired_addr) {
 			addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
@@ -682,8 +692,17 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	of_size = ret;
 
 	/* Create a new LMB reservation */
-	if (CONFIG_IS_ENABLED(LMB) && lmb)
-		lmb_reserve(map_to_sysmem(blob), of_size, LMB_NONE);
+	if (CONFIG_IS_ENABLED(LMB) && lmb) {
+		phys_addr_t fdt_addr;
+
+		fdt_addr = map_to_sysmem(blob);
+		ret = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &fdt_addr,
+				       of_size, LMB_NONE);
+		if (ret) {
+			printf("Failed to reserve memory for the fdt at %#llx\n",
+			       (u64)fdt_addr);
+		}
+	}
 
 #if defined(CONFIG_ARCH_KEYSTONE)
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
diff --git a/cmd/booti.c b/cmd/booti.c
index 1a57fe91397..0dd397d85db 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -87,7 +87,13 @@ static int booti_start(struct bootm_info *bmi)
 	images->os.start = relocated_addr;
 	images->os.end = relocated_addr + image_size;
 
-	lmb_reserve(images->ep, le32_to_cpu(image_size), LMB_NONE);
+	ret = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, (void *)&images->ep,
+			       le32_to_cpu(image_size), LMB_NONE);
+	if (ret) {
+		printf("Failed to allocate memory for the image at %#llx\n",
+		       (unsigned long long)images->ep);
+		return 1;
+	}
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 99318ff213f..b768047c7a9 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -56,7 +56,13 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret != 0)
 		return 1;
 
-	lmb_reserve(images->ep, zi_end - zi_start, LMB_NONE);
+	ret = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, (void *)&images->ep,
+			       zi_end - zi_start, LMB_NONE);
+	if (ret) {
+		printf("Failed to allocate memory for the image at %#llx\n",
+		       (unsigned long long)images->ep);
+		return 1;
+	}
 
 	/*
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
diff --git a/cmd/load.c b/cmd/load.c
index 899bb4f598e..3a4d52ef522 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -179,7 +179,9 @@ static ulong load_serial(long offset)
 		    {
 			void *dst;
 
-			ret = lmb_reserve(store_addr, binlen, LMB_NONE);
+			ret = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0,
+					       (void *)&store_addr, binlen,
+					       LMB_NONE);
 			if (ret) {
 				printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
 					store_addr, store_addr + binlen);
diff --git a/fs/fs.c b/fs/fs.c
index 1f36872fb9a..c815bea2394 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -597,7 +597,8 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 
 	lmb_dump_all();
 
-	if (!lmb_alloc_addr(addr, read_len, LMB_NONE))
+	if (!lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, (void *)&addr, read_len,
+			      LMB_NONE))
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/lmb.h b/include/lmb.h
index 606a92cca48..a9722e1910b 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -31,6 +31,14 @@
 #define LMB_NOOVERWRITE BIT(2)
 #define LMB_NONOTIFY BIT(3)
 
+/**
+ * enum lmb_mem_type - type of memory allocation request
+ * @LMB_MEM_ALLOC_ADDR:	request for a particular region of memory
+ */
+enum lmb_mem_type {
+	LMB_MEM_ALLOC_ADDR = 1,
+};
+
 /**
  * enum lmb_map_op - memory map operation
  */
@@ -67,6 +75,33 @@ struct lmb {
 	bool test;
 };
 
+/**
+ * lmb_allocate_mem() - Request LMB memory
+ * @type:		Type of memory allocation request
+ * @align:		Alignment of the memory region requested(0 for none)
+ * @addr:		Base address of the allocated memory region
+ * @size:		Size in bytes of the allocation request
+ * @flags:		Memory region attributes to be set
+ *
+ * Allocate a region of memory where the allocation is based on the parameters
+ * that have been passed to the function.The first parameter specifies the
+ * type of allocation that is being requested. The align parameter is used
+ * to specify if the allocation is to be made with a particular alignment.
+ * It is 0 if there is no alignment requirement. The addr parameter is used
+ * to return the base address of the allocated region. Depending on the type
+ * of allocation request, it might also contain a particular address being
+ * requested, or the maximum address of the requested allocation. The flags
+ * parameter is used to specify the memory attributes of the requested region.
+ *
+ * Return: 0 on success, -ve value on failure
+ *
+ * When the allocation is of type LMB_MEM_ALLOC_ADDR, the return value can
+ * be -EINVAL if the requested memory region is not part of the LMB memory
+ * map, and -EEXIST if the requested region is already allocated.
+ */
+int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
+		     phys_size_t size, u32 flags);
+
 /**
  * lmb_init() - Initialise the LMB module.
  *
@@ -91,19 +126,6 @@ void lmb_add_memory(void);
 
 long lmb_add(phys_addr_t base, phys_size_t size);
 
-/**
- * lmb_reserve() - Reserve one region with a specific flags bitfield
- * @base: Base address of the memory region
- * @size: Size of the memory region
- * @flags: Flags for the memory region
- *
- * Return:
- * * %0		- Added successfully, or it's already added (only if LMB_NONE)
- * * %-EEXIST	- The region is already added, and flags != LMB_NONE
- * * %-1	- Failure
- */
-long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags);
-
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
@@ -124,21 +146,6 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 			   uint flags);
 
-/**
- * lmb_alloc_addr() - Allocate specified memory address with specified attributes
- *
- * @base: Base Address requested
- * @size: Size of the region requested
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The base parameter is used to specify the base address
- * of the requested region.
- *
- * Return: 0 on success -1 on error
- */
-int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
-
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
  *			     bits set
@@ -175,7 +182,7 @@ void lmb_pop(struct lmb *store);
 
 static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 {
-	return lmb_alloc_addr(addr, len, LMB_NONE);
+	return lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, len, LMB_NONE);
 }
 
 /**
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 0abb1f6159a..12a7fd1f3bf 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -493,7 +493,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 			return EFI_NOT_FOUND;
 
 		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		if (lmb_alloc_addr(addr, len, flags))
+		if (lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, len, flags))
 			return EFI_NOT_FOUND;
 		break;
 	default:
diff --git a/lib/lmb.c b/lib/lmb.c
index bb6f232f6bc..c536465a501 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -488,6 +488,54 @@ void lmb_dump_all(void)
 #endif
 }
 
+/**
+ * lmb_can_reserve_region() - check if the region can be reserved
+ * @base: base address of region to be reserved
+ * @size: size of region to be reserved
+ * @flags: flag of the region to be reserved
+ *
+ * Go through all the reserved regions and ensure that the requested
+ * region does not overlap with any existing regions. An overlap is
+ * allowed only when the flag of the request region and the existing
+ * region is LMB_NONE.
+ *
+ * Return: true if region can be reserved, false otherwise
+ */
+static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
+				   u32 flags)
+{
+	uint i;
+	struct lmb_region *lmb_reserved = lmb.used_mem.data;
+
+	for (i = 0; i < lmb.used_mem.count; i++) {
+		u32 rgnflags = lmb_reserved[i].flags;
+		phys_addr_t rgnbase = lmb_reserved[i].base;
+		phys_size_t rgnsize = lmb_reserved[i].size;
+
+		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
+			if (flags != LMB_NONE || flags != rgnflags)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
+{
+	long ret = 0;
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
+
+	if (!lmb_can_reserve_region(base, size, flags))
+		return -EEXIST;
+
+	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
+	if (ret)
+		return ret;
+
+	return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
+}
+
 static void lmb_reserve_uboot_region(void)
 {
 	int bank;
@@ -557,39 +605,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	}
 }
 
-/**
- * lmb_can_reserve_region() - check if the region can be reserved
- * @base: base address of region to be reserved
- * @size: size of region to be reserved
- * @flags: flag of the region to be reserved
- *
- * Go through all the reserved regions and ensure that the requested
- * region does not overlap with any existing regions. An overlap is
- * allowed only when the flag of the request region and the existing
- * region is LMB_NONE.
- *
- * Return: true if region can be reserved, false otherwise
- */
-static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
-				   u32 flags)
-{
-	uint i;
-	struct lmb_region *lmb_reserved = lmb.used_mem.data;
-
-	for (i = 0; i < lmb.used_mem.count; i++) {
-		u32 rgnflags = lmb_reserved[i].flags;
-		phys_addr_t rgnbase = lmb_reserved[i].base;
-		phys_size_t rgnsize = lmb_reserved[i].size;
-
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			if (flags != LMB_NONE || flags != rgnflags)
-				return false;
-		}
-	}
-
-	return true;
-}
-
 void lmb_add_memory(void)
 {
 	int i;
@@ -657,21 +672,6 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 	return lmb_free_flags(base, size, LMB_NONE);
 }
 
-long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
-{
-	long ret = 0;
-	struct alist *lmb_rgn_lst = &lmb.used_mem;
-
-	if (!lmb_can_reserve_region(base, size, flags))
-		return -EEXIST;
-
-	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
-	if (ret)
-		return ret;
-
-	return lmb_map_update_notify(base, size, LMB_MAP_OP_RESERVE, flags);
-}
-
 static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 				   phys_addr_t max_addr, u32 flags)
 {
@@ -742,7 +742,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 	return _lmb_alloc_base(size, align, max_addr, flags);
 }
 
-int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
+static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -756,14 +756,37 @@ int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 		 */
 		if (lmb_addrs_overlap(lmb_memory[rgn].base,
 				      lmb_memory[rgn].size,
-				      base + size - 1, 1)) {
+				      base + size - 1, 1))
 			/* ok, reserve the memory */
-			if (!lmb_reserve(base, size, flags))
-				return 0;
-		}
+			return lmb_reserve(base, size, flags);
+		else
+			return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
+		     phys_size_t size, u32 flags)
+{
+	int ret = -1;
+
+	if (!size)
+		return 0;
+
+	if (!addr)
+		return -EINVAL;
+
+	switch (type) {
+	case LMB_MEM_ALLOC_ADDR:
+		ret = _lmb_alloc_addr(*addr, size, flags);
+		break;
+	default:
+		log_debug("%s: Invalid memory allocation type requested %d\n",
+			  __func__, type);
 	}
 
-	return -1;
+	return ret;
 }
 
 /* Return number of bytes from a given address that are free */
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 3bf558f7f4f..f80115570e7 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -71,6 +71,19 @@ static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
 	return 0;
 }
 
+static int lmb_reserve(phys_addr_t addr, phys_size_t size, u32 flags)
+{
+	int err;
+
+	err = lmb_allocate_mem(LMB_MEM_ALLOC_ADDR, 0, &addr, size, flags);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+#define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
+
 static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 			    const phys_size_t ram_size, const phys_addr_t ram0,
 			    const phys_size_t ram0_size,
@@ -568,7 +581,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, -1);
+	ut_asserteq(b, -EEXIST);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(b, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
@@ -578,9 +591,9 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
-	ut_asserteq(b, -1);
+	ut_asserteq(b, -EEXIST);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, -1);
+	ut_asserteq(b, -EEXIST);
 	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
 
@@ -599,7 +612,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
 	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
-	ut_asserteq(c, -1);
+	ut_asserteq(c, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
@@ -646,7 +659,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
 	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NOOVERWRITE);
-	ut_asserteq(c, -1);
+	ut_asserteq(c, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
@@ -739,11 +752,11 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
 		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
-		ut_asserteq(ret, -1);
+		ut_asserteq(ret, -EINVAL);
 	}
 	if (ram != 0) {
 		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
-		ut_asserteq(ret, -1);
+		ut_asserteq(ret, -EINVAL);
 	}
 
 	lmb_pop(&store);
-- 
2.34.1

