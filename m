Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CDDC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9408898E;
	Thu,  4 Jul 2024 09:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F036888E6; Thu,  4 Jul 2024 09:38:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E66E08897A
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C72DA7;
 Thu,  4 Jul 2024 00:39:15 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 395523F762;
 Thu,  4 Jul 2024 00:38:46 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 45/48] efi_memory: do not add RAM memory to the memory
 map
Date: Thu,  4 Jul 2024 13:05:41 +0530
Message-Id: <20240704073544.670249-46-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

The EFI_CONVENTIONAL_MEMORY type, which is the usable RAM memory is
now being managed by the LMB module. Remove the addition of this
memory type to the EFI memory map. This memory now gets added to the
EFI memory map as part of the LMB memory map update event handler.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 include/efi_loader.h        | 12 +++---
 lib/efi_loader/efi_memory.c | 75 +++----------------------------------
 2 files changed, 12 insertions(+), 75 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6c993e1a69..e5090afe2a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -795,9 +795,6 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 				uint32_t *descriptor_version);
 /* Adds a range into the EFI memory map */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
-/* Adds a conventional range into the EFI memory map */
-efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
-					     u64 ram_top);
 
 /* Called by board init to initialize the EFI drivers */
 efi_status_t efi_driver_init(void);
@@ -1183,9 +1180,14 @@ efi_status_t efi_console_get_u16_string
 efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int size);
 
 /**
- * efi_add_known_memory() - add memory banks to EFI memory map
+ * efi_add_known_memory() - add memory types to the EFI memory map
  *
- * This weak function may be overridden for specific architectures.
+ * This function is to be used to adding different memory types other
+ * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
+ * memory is handled by the LMB module, and gets added to the memory
+ * map through the LMB module.
+ *
+ * This function may be overridden for specific architectures.
  */
 void efi_add_known_memory(void);
 
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index bd12504f72..3ceb670e79 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -793,82 +793,17 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
 }
 
 /**
- * efi_add_conventional_memory_map() - add a RAM memory area to the map
+ * efi_add_known_memory() - add memory types to the EFI memory map
  *
- * @ram_start:		start address of a RAM memory area
- * @ram_end:		end address of a RAM memory area
- * @ram_top:		max address to be used as conventional memory
- * Return:		status code
- */
-efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
-					     u64 ram_top)
-{
-	u64 pages;
-
-	/* Remove partial pages */
-	ram_end &= ~EFI_PAGE_MASK;
-	ram_start = (ram_start + EFI_PAGE_MASK) & ~EFI_PAGE_MASK;
-
-	if (ram_end <= ram_start) {
-		/* Invalid mapping */
-		return EFI_INVALID_PARAMETER;
-	}
-
-	pages = (ram_end - ram_start) >> EFI_PAGE_SHIFT;
-
-	efi_add_memory_map_pg(ram_start, pages,
-			      EFI_CONVENTIONAL_MEMORY, false);
-
-	/*
-	 * Boards may indicate to the U-Boot memory core that they
-	 * can not support memory above ram_top. Let's honor this
-	 * in the efi_loader subsystem too by declaring any memory
-	 * above ram_top as "already occupied by firmware".
-	 */
-	if (ram_top < ram_start) {
-		/* ram_top is before this region, reserve all */
-		efi_add_memory_map_pg(ram_start, pages,
-				      EFI_BOOT_SERVICES_DATA, true);
-	} else if (ram_top < ram_end) {
-		/* ram_top is inside this region, reserve parts */
-		pages = (ram_end - ram_top) >> EFI_PAGE_SHIFT;
-
-		efi_add_memory_map_pg(ram_top, pages,
-				      EFI_BOOT_SERVICES_DATA, true);
-	}
-
-	return EFI_SUCCESS;
-}
-
-/**
- * efi_add_known_memory() - add memory banks to map
+ * This function is to be used to adding different memory types other
+ * than EFI_CONVENTIONAL_MEMORY to the EFI memory map. The conventional
+ * memory is handled by the LMB module, and gets added to the memory
+ * map through the LMB module.
  *
  * This function may be overridden for specific architectures.
  */
 __weak void efi_add_known_memory(void)
 {
-	u64 ram_top = gd->ram_top & ~EFI_PAGE_MASK;
-	int i;
-
-	/*
-	 * ram_top is just outside mapped memory. So use an offset of one for
-	 * mapping the sandbox address.
-	 */
-	ram_top = (uintptr_t)map_sysmem(ram_top - 1, 0) + 1;
-
-	/* Fix for 32bit targets with ram_top at 4G */
-	if (!ram_top)
-		ram_top = 0x100000000ULL;
-
-	/* Add RAM */
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		u64 ram_end, ram_start;
-
-		ram_start = (uintptr_t)map_sysmem(gd->bd->bi_dram[i].start, 0);
-		ram_end = ram_start + gd->bd->bi_dram[i].size;
-
-		efi_add_conventional_memory_map(ram_start, ram_end, ram_top);
-	}
 }
 
 /**
-- 
2.34.1

