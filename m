Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA270CEFC38
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C617288EE3;
	Tue,  8 Oct 2024 20:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E99E88F01; Tue,  8 Oct 2024 20:15:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 25B6688EFA
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300F1DA7;
 Tue,  8 Oct 2024 11:15:26 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1133F64C;
 Tue,  8 Oct 2024 11:14:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 03/14] efi: memory: use the lmb API's for allocating and
 freeing memory
Date: Tue,  8 Oct 2024 23:44:24 +0530
Message-Id: <20241008181435.1753814-4-sughosh.ganu@linaro.org>
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

Use the LMB API's for allocating and freeing up memory. With this, the
LMB module becomes the common backend for managing non U-Boot image
memory that might be requested by other modules.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 lib/efi_loader/Kconfig      |  1 +
 lib/efi_loader/efi_memory.c | 74 ++++++++++---------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index e58b8825605..5a576720606 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -20,6 +20,7 @@ config EFI_LOADER
 	select DM_EVENT
 	select EVENT_DYNAMIC
 	select LIB_UUID
+	select LMB
 	imply PARTITION_UUIDS
 	select REGEX
 	imply FAT
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index c6f1dd09456..90e07ed6a2d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -9,6 +9,7 @@
 
 #include <efi_loader.h>
 #include <init.h>
+#include <lmb.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -432,53 +433,6 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	return EFI_NOT_FOUND;
 }
 
-/**
- * efi_find_free_memory() - find free memory pages
- *
- * @len:	size of memory area needed
- * @max_addr:	highest address to allocate
- * Return:	pointer to free memory area or 0
- */
-static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
-{
-	struct efi_mem_list *lmem;
-
-	/*
-	 * Prealign input max address, so we simplify our matching
-	 * logic below and can just reuse it as return pointer.
-	 */
-	max_addr &= ~EFI_PAGE_MASK;
-
-	list_for_each_entry(lmem, &efi_mem, link) {
-		struct efi_mem_desc *desc = &lmem->desc;
-		uint64_t desc_len = desc->num_pages << EFI_PAGE_SHIFT;
-		uint64_t desc_end = desc->physical_start + desc_len;
-		uint64_t curmax = min(max_addr, desc_end);
-		uint64_t ret = curmax - len;
-
-		/* We only take memory from free RAM */
-		if (desc->type != EFI_CONVENTIONAL_MEMORY)
-			continue;
-
-		/* Out of bounds for max_addr */
-		if ((ret + len) > max_addr)
-			continue;
-
-		/* Out of bounds for upper map limit */
-		if ((ret + len) > desc_end)
-			continue;
-
-		/* Out of bounds for lower map limit */
-		if (ret < desc->physical_start)
-			continue;
-
-		/* Return the highest address in this map within bounds */
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * efi_allocate_pages - allocate memory pages
  *
@@ -493,6 +447,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				efi_uintn_t pages, uint64_t *memory)
 {
 	u64 len;
+	uint flags;
 	efi_status_t ret;
 	uint64_t addr;
 
@@ -508,33 +463,35 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	    (len >> EFI_PAGE_SHIFT) != (u64)pages)
 		return EFI_OUT_OF_RESOURCES;
 
+	flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
 	switch (type) {
 	case EFI_ALLOCATE_ANY_PAGES:
 		/* Any page */
-		addr = efi_find_free_memory(len, -1ULL);
+		addr = (u64)lmb_alloc_flags(len, EFI_PAGE_SIZE, flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_MAX_ADDRESS:
 		/* Max address */
-		addr = efi_find_free_memory(len, *memory);
+		addr = (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, *memory,
+						 flags);
 		if (!addr)
 			return EFI_OUT_OF_RESOURCES;
 		break;
 	case EFI_ALLOCATE_ADDRESS:
 		if (*memory & EFI_PAGE_MASK)
 			return EFI_NOT_FOUND;
-		/* Exact address, reserve it. The addr is already in *memory. */
-		ret = efi_check_allocated(*memory, false);
-		if (ret != EFI_SUCCESS)
-			return EFI_NOT_FOUND;
-		addr = *memory;
+
+		addr = (u64)lmb_alloc_addr_flags(*memory, len, flags);
+		if (!addr)
+			return EFI_OUT_OF_RESOURCES;
 		break;
 	default:
 		/* UEFI doesn't specify other allocation types */
 		return EFI_INVALID_PARAMETER;
 	}
 
+	addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
 	ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
 	if (ret != EFI_SUCCESS)
@@ -555,6 +512,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
  */
 efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 {
+	u64 len;
+	uint flags;
+	long status;
 	efi_status_t ret;
 
 	ret = efi_check_allocated(memory, true);
@@ -568,6 +528,12 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 		return EFI_INVALID_PARAMETER;
 	}
 
+	flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
+	len = (u64)pages << EFI_PAGE_SHIFT;
+	status = lmb_free_flags(memory, len, flags);
+	if (status)
+		return EFI_NOT_FOUND;
+
 	ret = efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
 				    false);
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

