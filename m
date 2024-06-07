Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC05C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FBA8850A;
	Fri,  7 Jun 2024 20:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3504C88470; Fri,  7 Jun 2024 20:54:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 46F328851A
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075F71480;
 Fri,  7 Jun 2024 11:54:52 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15F33F792;
 Fri,  7 Jun 2024 11:54:24 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 17/31] lmb: remove call to efi_lmb_reserve()
Date: Sat,  8 Jun 2024 00:22:26 +0530
Message-Id: <20240607185240.1892031-18-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

The changes in the EFI memory map are now notified to the LMB
module. There is therefore no need to explicitly get the efi memory
map and set aside the EFI allocated memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/lmb.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 3059609aea..c9f6ca692e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -204,38 +204,6 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
 	}
 }
 
-/**
- * efi_lmb_reserve() - add reservations for EFI memory
- *
- * Add reservations for all EFI memory areas that are not
- * EFI_CONVENTIONAL_MEMORY.
- *
- * Return:	0 on success, 1 on failure
- */
-static __maybe_unused int efi_lmb_reserve(void)
-{
-	struct efi_mem_desc *memmap = NULL, *map;
-	efi_uintn_t i, map_size = 0;
-	efi_status_t ret;
-
-	ret = efi_get_memory_map_alloc(&map_size, &memmap);
-	if (ret != EFI_SUCCESS)
-		return 1;
-
-	for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
-		if (map->type != EFI_CONVENTIONAL_MEMORY) {
-			lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
-							map->physical_start),
-					  map->num_pages * EFI_PAGE_SIZE,
-					  map->type == EFI_RESERVED_MEMORY_TYPE
-					      ? LMB_NOMAP : LMB_NONE);
-		}
-	}
-	efi_free_pool(memmap);
-
-	return 0;
-}
-
 /**
  * lmb_reserve_common() - Reserve memory region occupied by U-Boot image
  * @fdt_blob: pointer to the FDT blob
@@ -255,9 +223,6 @@ void lmb_reserve_common(void *fdt_blob)
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
 		boot_fdt_add_mem_rsv_regions(fdt_blob);
-
-	if (CONFIG_IS_ENABLED(EFI_LOADER))
-		efi_lmb_reserve();
 }
 
 /**
-- 
2.34.1

