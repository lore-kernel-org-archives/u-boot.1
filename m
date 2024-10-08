Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E236BCEFC38
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFCC88F04;
	Tue,  8 Oct 2024 20:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A757988F3D; Tue,  8 Oct 2024 20:15:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6366688F23
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D72DA7;
 Tue,  8 Oct 2024 11:15:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0DB33F64C;
 Tue,  8 Oct 2024 11:15:03 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 06/14] lmb: notify of any changes to the LMB memory map
Date: Tue,  8 Oct 2024 23:44:27 +0530
Message-Id: <20241008181435.1753814-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
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

In U-Boot, LMB and EFI are two primary modules who provide memory
allocation and reservation API's. Both these modules operate with the
same regions of memory for allocations. Use the LMB memory map update
event to notify other interested listeners about a change in it's
memory map. This can then be used by the other module to keep track of
available and used memory.

There is no need to send these notifications when the LMB module is
being unit-tested. Add a flag to the lmb structure to indicate if the
memory map is being used for tests, and suppress sending any
notifications when running these unit tests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Call the efi_add_memory_map_pg() function directly from the
  lmb_map_update_notify() instead of doing it through the event
  framework.
* Call the efi_add_memory_map_pg() with overlap_only_ram argument set
  to false, to allow for overlapping allocation design of LMB.
* Use the return value of lmb_map_update_notify() at it's call sites

 include/efi_loader.h        |  14 +++++
 include/lmb.h               |   2 +
 lib/efi_loader/Kconfig      |   1 +
 lib/efi_loader/efi_memory.c |   2 +-
 lib/lmb.c                   | 109 ++++++++++++++++++++++++++++++++----
 5 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f84852e384f..081cb65d3f7 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -784,6 +784,20 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 				uint32_t *descriptor_version);
 /* Adds a range into the EFI memory map */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
+
+/**
+ * efi_add_memory_map_pg() - add pages to the memory map
+ *
+ * @start:		start address, must be a multiple of EFI_PAGE_SIZE
+ * @pages:		number of pages to add
+ * @memory_type:	type of memory added
+ * @overlap_only_ram:	region may only overlap RAM
+ * Return:		status code
+ */
+efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
+					  int memory_type,
+					  bool overlap_only_ram);
+
 /* Adds a conventional range into the EFI memory map */
 efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
 					     u64 ram_top);
diff --git a/include/lmb.h b/include/lmb.h
index a76262d520d..92e9aead764 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -44,10 +44,12 @@ struct lmb_region {
  *
  * @free_mem:	List of free memory regions
  * @used_mem:	List of used/reserved memory regions
+ * @test:	Is structure being used for LMB tests
  */
 struct lmb {
 	struct alist free_mem;
 	struct alist used_mem;
+	bool test;
 };
 
 /**
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 5a576720606..f395bebbf68 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -21,6 +21,7 @@ config EFI_LOADER
 	select EVENT_DYNAMIC
 	select LIB_UUID
 	select LMB
+	select MEM_MAP_UPDATE_NOTIFY
 	imply PARTITION_UUIDS
 	select REGEX
 	imply FAT
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 90e07ed6a2d..974ecc51113 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -264,7 +264,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
  * @overlap_only_ram:	region may only overlap RAM
  * Return:		status code
  */
-static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
+efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 					  int memory_type,
 					  bool overlap_only_ram)
 {
diff --git a/lib/lmb.c b/lib/lmb.c
index a4886db4c45..a41e8c4ce03 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -8,6 +8,7 @@
 
 #include <alist.h>
 #include <efi_loader.h>
+#include <event.h>
 #include <image.h>
 #include <mapmem.h>
 #include <lmb.h>
@@ -22,10 +23,55 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define MAP_OP_RESERVE		(u8)0x1
+#define MAP_OP_FREE		(u8)0x2
+#define MAP_OP_ADD		(u8)0x3
+
 #define LMB_ALLOC_ANYWHERE	0
 #define LMB_ALIST_INITIAL_SIZE	4
 
 static struct lmb lmb;
+extern bool is_addr_in_ram(uintptr_t addr);
+
+static bool lmb_notify(enum lmb_flags flags)
+{
+	return !lmb.test && !(flags & LMB_NONOTIFY);
+}
+
+static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
+						phys_size_t size,
+						u8 op)
+{
+	u64 efi_addr;
+	u64 pages;
+	efi_status_t status;
+
+	if (!is_addr_in_ram((uintptr_t)addr))
+		return 0;
+
+	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
+		log_debug("Invalid map update op received (%d)\n", op);
+		return -1;
+	}
+
+	efi_addr = (uintptr_t)map_sysmem(addr, 0);
+	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
+	efi_addr &= ~EFI_PAGE_MASK;
+
+	status = efi_add_memory_map_pg(efi_addr, pages,
+				       op == MAP_OP_RESERVE ?
+				       EFI_BOOT_SERVICES_DATA :
+				       EFI_CONVENTIONAL_MEMORY,
+				       false);
+
+	if (status != EFI_SUCCESS) {
+		log_err("%s: LMB Map notify failure %lu\n", __func__,
+			status & ~EFI_ERROR_MASK);
+		return -1;
+	} else {
+		return 0;
+	}
+}
 
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
@@ -474,9 +520,17 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 /* This routine may be called with relocation disabled. */
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
+	long ret;
 	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
-	return lmb_add_region(lmb_rgn_lst, base, size);
+	ret = lmb_add_region(lmb_rgn_lst, base, size);
+	if (ret)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+		return lmb_map_update_notify(base, size, MAP_OP_ADD);
+
+	return 0;
 }
 
 static long __lmb_free(phys_addr_t base, phys_size_t size)
@@ -530,11 +584,6 @@ static long __lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn[i].flags);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
-{
-	return __lmb_free(base, size);
-}
-
 /**
  * lmb_free_flags() - Free up a region of memory
  * @base: Base Address of region to be freed
@@ -546,16 +595,38 @@ long lmb_free(phys_addr_t base, phys_size_t size)
  * Return: 0 if successful, -1 on failure
  */
 long lmb_free_flags(phys_addr_t base, phys_size_t size,
-		    __always_unused uint flags)
+		    uint flags)
 {
-	return __lmb_free(base, size);
+	long ret;
+
+	ret = __lmb_free(base, size);
+	if (ret < 0)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
+		return lmb_map_update_notify(base, size, MAP_OP_FREE);
+
+	return ret;
+}
+
+long lmb_free(phys_addr_t base, phys_size_t size)
+{
+	return lmb_free_flags(base, size, LMB_NONE);
 }
 
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
+	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
-	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
+	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
+	if (ret < 0)
+		return -1;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
+		return lmb_map_update_notify(base, size, MAP_OP_RESERVE);
+
+	return ret;
 }
 
 long lmb_reserve(phys_addr_t base, phys_size_t size)
@@ -587,6 +658,8 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 				    phys_addr_t max_addr, enum lmb_flags flags)
 {
+	u8 op;
+	int ret;
 	long i, rgn;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
@@ -617,6 +690,16 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 				if (lmb_add_region_flags(&lmb.used_mem, base,
 							 size, flags) < 0)
 					return 0;
+
+				if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) &&
+				    lmb_notify(flags)) {
+					op = MAP_OP_RESERVE;
+					ret = lmb_map_update_notify(base, size,
+								    op);
+					if (ret)
+						return ret;
+				}
+
 				return base;
 			}
 
@@ -786,7 +869,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 	return 0;
 }
 
-static int lmb_setup(void)
+static int lmb_setup(bool test)
 {
 	bool ret;
 
@@ -804,6 +887,8 @@ static int lmb_setup(void)
 		return -ENOMEM;
 	}
 
+	lmb.test = test;
+
 	return 0;
 }
 
@@ -823,7 +908,7 @@ int lmb_init(void)
 {
 	int ret;
 
-	ret = lmb_setup();
+	ret = lmb_setup(false);
 	if (ret) {
 		log_info("Unable to init LMB\n");
 		return ret;
@@ -851,7 +936,7 @@ int lmb_push(struct lmb *store)
 	int ret;
 
 	*store = lmb;
-	ret = lmb_setup();
+	ret = lmb_setup(true);
 	if (ret)
 		return ret;
 
-- 
2.34.1

