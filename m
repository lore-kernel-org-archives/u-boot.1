Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE58C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF1482BBF;
	Tue, 20 May 2025 14:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB7C82C30; Tue, 20 May 2025 14:06:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 952F482A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 14:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FCB11516;
 Tue, 20 May 2025 05:06:12 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03B7A3F5A1;
 Tue, 20 May 2025 05:06:22 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/5] lmb: replace the lmb_alloc() and lmb_alloc_base() API's
Date: Tue, 20 May 2025 17:36:03 +0530
Message-Id: <20250520120606.173228-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520120606.173228-1-sughosh.ganu@linaro.org>
References: <20250520120606.173228-1-sughosh.ganu@linaro.org>
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

There currently are two API's for requesting memory from the LMB
module, lmb_alloc() and lmb_alloc_base(). The function which does the
actual allocation is the same. Use the earlier introduced API
lmb_allocate_mem() for both types of allocation requests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Check the return value of the lmb API in some of the common,
  non-arch code that got missed out in the earlier version. Done where
  applicable.
* Declare a local variable of type phys_addr_t and use that while
  calling the API, instead of casting the parameter to a void *. Done
  where applicable.
* Optimize the use of the lmb API in boot_ramdisk_high().
* s/desired_addr/high_addr in boot_relocate_fdt().
* Fallthrough the LMB_MEM_ALLOC_ANY case in lmb_allocate_mem() as
  suggested by Ilias.

 arch/arm/mach-apple/board.c      | 27 ++++++++++++++-----
 arch/arm/mach-snapdragon/board.c | 13 ++++++++-
 boot/bootm.c                     | 12 ++++++---
 boot/image-board.c               | 45 +++++++++++++++++---------------
 boot/image-fdt.c                 | 35 ++++++++++++++-----------
 include/lmb.h                    | 22 +++-------------
 lib/efi_loader/efi_memory.c      | 14 +++++-----
 lib/lmb.c                        | 28 +++++++++-----------
 test/lib/lmb.c                   | 26 ++++++++++++++++++
 9 files changed, 134 insertions(+), 88 deletions(-)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 2644a04a622..f0eab5df1ef 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -772,6 +772,19 @@ u64 get_page_table_size(void)
 
 #define KERNEL_COMP_SIZE	SZ_128M
 
+static phys_addr_t lmb_alloc(phys_size_t size)
+{
+	int ret;
+	phys_addr_t addr;
+
+	/* All memory regions allocated with a 2MiB alignment */
+	ret = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
+	if (ret)
+		return 0;
+
+	return addr;
+}
+
 int board_late_init(void)
 {
 	u32 status = 0;
@@ -779,15 +792,15 @@ int board_late_init(void)
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
 	 */
-	status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G, SZ_2M));
-	status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
-	status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M, SZ_2M));
-	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G, SZ_2M));
+	status |= env_set_hex("loadaddr", lmb_alloc(SZ_1G));
+	status |= env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M));
+	status |= env_set_hex("kernel_addr_r", lmb_alloc(SZ_128M));
+	status |= env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_1G));
 	status |= env_set_hex("kernel_comp_addr_r",
-			      lmb_alloc(KERNEL_COMP_SIZE, SZ_2M));
+			      lmb_alloc(KERNEL_COMP_SIZE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
-	status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M, SZ_2M));
-	status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M, SZ_2M));
+	status |= env_set_hex("scriptaddr", lmb_alloc(SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", lmb_alloc(SZ_4M));
 
 	if (status)
 		log_warning("late_init: Failed to set run time variables\n");
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 3ab75f0fce0..141879c4104 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -483,7 +483,18 @@ void __weak qcom_late_init(void)
 #define FASTBOOT_BUF_SIZE 0
 #endif
 
-#define addr_alloc(size) lmb_alloc(size, SZ_2M)
+static phys_addr_t addr_alloc(phys_size_t size)
+{
+	int ret;
+	phys_addr_t addr;
+
+	/* All memory regions allocated with a 2MiB alignment */
+	ret = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
+	if (ret)
+		return 0;
+
+	return addr;
+}
 
 /* Stolen from arch/arm/mach-apple/board.c */
 int board_late_init(void)
diff --git a/boot/bootm.c b/boot/bootm.c
index c23b91c89d0..d77730ca431 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -623,12 +623,16 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		ulong req_size = ALIGN(image_len * 4, SZ_1M);
+		phys_addr_t addr;
 
-		load = lmb_alloc(req_size, SZ_2M);
-		if (!load)
+		err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
+				       req_size, LMB_NONE);
+		if (err)
 			return 1;
-		os.load = load;
-		images->ep = load;
+
+		load = (ulong)addr;
+		os.load = (ulong)addr;
+		images->ep = (ulong)addr;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
 		      req_size, load, image_len);
 	}
diff --git a/boot/image-board.c b/boot/image-board.c
index 8933c8d9924..26cf9f88656 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -16,6 +16,7 @@
 #include <fpga.h>
 #include <image.h>
 #include <init.h>
+#include <lmb.h>
 #include <log.h>
 #include <mapmem.h>
 #include <rtc.h>
@@ -573,20 +574,17 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 				goto error;
 			}
 		} else {
-			if (initrd_high)
-				*initrd_start =
-					(ulong)lmb_alloc_base(rd_len,
-								    0x1000,
-								    initrd_high,
-								    LMB_NONE);
-			else
-				*initrd_start = (ulong)lmb_alloc(rd_len,
-								 0x1000);
+			enum lmb_mem_type type = initrd_high ?
+				LMB_MEM_ALLOC_MAX : LMB_MEM_ALLOC_ANY;
 
-			if (*initrd_start == 0) {
+			err = lmb_allocate_mem(type, 0x1000, &initrd_high,
+					       rd_len, LMB_NONE);
+			if (err) {
 				puts("ramdisk - allocation error\n");
 				goto error;
 			}
+
+			*initrd_start = (ulong)initrd_high;
 			bootstage_mark(BOOTSTAGE_ID_COPY_RAMDISK);
 
 			*initrd_end = *initrd_start + rd_len;
@@ -837,9 +835,10 @@ int boot_get_loadable(struct bootm_headers *images)
  */
 int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 {
-	int barg;
+	int barg, err;
 	char *cmdline;
 	char *s;
+	phys_addr_t addr;
 
 	/*
 	 * Help the compiler detect that this function is only called when
@@ -849,12 +848,14 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 		return 0;
 
 	barg = IF_ENABLED_INT(CONFIG_SYS_BOOT_GET_CMDLINE, CONFIG_SYS_BARGSIZE);
-	cmdline = (char *)(ulong)lmb_alloc_base(barg, 0xf,
-				env_get_bootm_mapsize() + env_get_bootm_low(),
-				LMB_NONE);
-	if (!cmdline)
+	addr = env_get_bootm_mapsize() + env_get_bootm_low();
+
+	err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr, barg, LMB_NONE);
+	if (err)
 		return -1;
 
+	cmdline = (char *)(uintptr_t)addr;
+
 	s = env_get("bootargs");
 	if (!s)
 		s = "";
@@ -883,14 +884,16 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
  */
 int boot_get_kbd(struct bd_info **kbd)
 {
-	*kbd = (struct bd_info *)(ulong)lmb_alloc_base(sizeof(struct bd_info),
-							     0xf,
-							     env_get_bootm_mapsize() +
-							     env_get_bootm_low(),
-							     LMB_NONE);
-	if (!*kbd)
+	int err;
+	phys_addr_t addr;
+
+	addr = env_get_bootm_mapsize() + env_get_bootm_low();
+	err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr,
+			       sizeof(struct bd_info), LMB_NONE);
+	if (err)
 		return -1;
 
+	*kbd = (struct bd_info *)(uintptr_t)addr;
 	**kbd = *gd->bd;
 
 	debug("## kernel board info at 0x%08lx\n", (ulong)*kbd);
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index fef0229eb10..ff27a31ae2e 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -184,9 +184,9 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 	/* If fdt_high is set use it to select the relocation address */
 	fdt_high = env_get("fdt_high");
 	if (fdt_high) {
-		ulong desired_addr = hextoul(fdt_high, NULL);
+		ulong high_addr = hextoul(fdt_high, NULL);
 
-		if (desired_addr == ~0UL) {
+		if (high_addr == ~0UL) {
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
 			addr = map_to_sysmem(fdt_blob);
@@ -199,16 +199,17 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			}
 
 			disable_relocation = 1;
-		} else if (desired_addr) {
-			addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
-					      LMB_NONE);
-			of_start = map_sysmem(addr, of_len);
-			if (of_start == NULL) {
-				puts("Failed using fdt_high value for Device Tree");
+		} else {
+			enum lmb_mem_type type = high_addr ?
+				LMB_MEM_ALLOC_MAX : LMB_MEM_ALLOC_ANY;
+
+			addr = high_addr;
+			err = lmb_allocate_mem(type, 0x1000, &addr, of_len,
+					       LMB_NONE);
+			if (err) {
+				puts("Failed to allocate memory for Device Tree relocation\n");
 				goto error;
 			}
-		} else {
-			addr = lmb_alloc(of_len, 0x1000);
 			of_start = map_sysmem(addr, of_len);
 		}
 	} else {
@@ -230,11 +231,15 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			 * for LMB allocation.
 			 */
 			usable = min(start + size, low + mapsize);
-			addr = lmb_alloc_base(of_len, 0x1000, usable, LMB_NONE);
-			of_start = map_sysmem(addr, of_len);
-			/* Allocation succeeded, use this block. */
-			if (of_start != NULL)
-				break;
+			addr = usable;
+			err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0x1000,
+					       &addr, of_len, LMB_NONE);
+			if (!err) {
+				of_start = map_sysmem(addr, of_len);
+				/* Allocation succeeded, use this block. */
+				if (of_start)
+					break;
+			}
 
 			/*
 			 * Reduce the mapping size in the next bank
diff --git a/include/lmb.h b/include/lmb.h
index 5b9a63210b0..82f5097173f 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -34,9 +34,13 @@
 /**
  * enum lmb_mem_type - type of memory allocation request
  * @LMB_MEM_ALLOC_ADDR:	request for a particular region of memory
+ * @LMB_MEM_ALLOC_ANY:	allocate any available memory region
+ * @LMB_MEM_ALLOC_MAX:	allocate memory below a particular address
  */
 enum lmb_mem_type {
 	LMB_MEM_ALLOC_ADDR = 1,
+	LMB_MEM_ALLOC_ANY,
+	LMB_MEM_ALLOC_MAX,
 };
 
 /**
@@ -130,26 +134,8 @@ void lmb_add_memory(void);
 
 long lmb_add(phys_addr_t base, phys_size_t size);
 
-phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
-/**
- * lmb_alloc_base() - Allocate specified memory region with specified
- *			    attributes
- * @size: Size of the region requested
- * @align: Alignment of the memory region requested
- * @max_addr: Maximum address of the requested region
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The max_addr parameter is used to specify the maximum address
- * below which the requested region should be allocated.
- *
- * Return: Base address on success, 0 on error.
- */
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
-			   uint flags);
-
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
  *			     bits set
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 12a7fd1f3bf..73e1eef5011 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -454,6 +454,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type memory_type,
 				efi_uintn_t pages, uint64_t *memory)
 {
+	int err;
 	u64 efi_addr, len;
 	uint flags;
 	efi_status_t ret;
@@ -475,17 +476,18 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	switch (type) {
 	case EFI_ALLOCATE_ANY_PAGES:
 		/* Any page */
-		addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE,
-						 LMB_ALLOC_ANYWHERE, flags);
-		if (!addr)
+		err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE,
+				       &addr, len, flags);
+		if (err)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
 		addr = map_to_sysmem((void *)(uintptr_t)*memory);
-		addr = (u64)lmb_alloc_base(len, EFI_PAGE_SIZE, addr,
-						 flags);
-		if (!addr)
+
+		err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE,
+				       &addr, len, flags);
+		if (err)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_ADDRESS:
diff --git a/lib/lmb.c b/lib/lmb.c
index c536465a501..e3ec389d026 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -672,16 +672,18 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 	return lmb_free_flags(base, size, LMB_NONE);
 }
 
-static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
-				   phys_addr_t max_addr, u32 flags)
+static int _lmb_alloc_base(phys_size_t size, ulong align,
+			   phys_addr_t *addr, u32 flags)
 {
 	int ret;
 	long i, rgn;
+	phys_addr_t max_addr;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 	struct lmb_region *lmb_used = lmb.used_mem.data;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
+	max_addr = *addr;
 	for (i = lmb.available_mem.count - 1; i >= 0; i--) {
 		phys_addr_t lmbbase = lmb_memory[i].base;
 		phys_size_t lmbsize = lmb_memory[i].size;
@@ -714,8 +716,8 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 							    flags);
 				if (ret)
 					return ret;
-
-				return base;
+				*addr = base;
+				return 0;
 			}
 
 			res_base = lmb_used[rgn].base;
@@ -728,18 +730,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 	log_debug("%s: Failed to allocate 0x%lx bytes below 0x%lx\n",
 		  __func__, (ulong)size, (ulong)max_addr);
 
-	return 0;
-}
-
-phys_addr_t lmb_alloc(phys_size_t size, ulong align)
-{
-	return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
-}
-
-phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
-			   uint flags)
-{
-	return _lmb_alloc_base(size, align, max_addr, flags);
+	return -1;
 }
 
 static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
@@ -778,6 +769,11 @@ int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
 		return -EINVAL;
 
 	switch (type) {
+	case LMB_MEM_ALLOC_ANY:
+		*addr = LMB_ALLOC_ANYWHERE;
+	case LMB_MEM_ALLOC_MAX:
+		ret = _lmb_alloc_base(size, align, addr, flags);
+		break;
 	case LMB_MEM_ALLOC_ADDR:
 		ret = _lmb_alloc_addr(*addr, size, flags);
 		break;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index f80115570e7..8ce19efc854 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -82,6 +82,32 @@ static int lmb_reserve(phys_addr_t addr, phys_size_t size, u32 flags)
 	return 0;
 }
 
+static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
+{
+	int err;
+	phys_addr_t addr;
+
+	err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
+	if (err)
+		return 0;
+
+	return addr;
+}
+
+static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
+				  phys_addr_t max_addr, u32 flags)
+{
+	int err;
+	phys_addr_t addr;
+
+	addr = max_addr;
+	err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
+	if (err)
+		return 0;
+
+	return addr;
+}
+
 #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
 
 static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
-- 
2.34.1

