Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B67DD1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738D788753;
	Tue, 15 Oct 2024 17:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F3788730; Tue, 15 Oct 2024 17:38:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3B0D388753
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A4C7175A;
 Tue, 15 Oct 2024 08:38:52 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E3D3F528;
 Tue, 15 Oct 2024 08:38:19 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 13/15] lmb: remove call to efi_lmb_reserve()
Date: Tue, 15 Oct 2024 21:07:15 +0530
Message-Id: <20241015153717.401371-14-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015153717.401371-1-sughosh.ganu@linaro.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
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

The EFI memory allocations are now being done through the LMB
module. With this change, there is no need to get the EFI memory map
and set aside EFI allocated memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 lib/lmb.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ae69201d5b7..f3a1d8ca256 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -204,38 +204,6 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
 	lmb_remove_region(lmb_rgn_lst, r2);
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
 static void lmb_reserve_uboot_region(void)
 {
 	int bank;
@@ -282,9 +250,6 @@ static void lmb_reserve_common(void *fdt_blob)
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
 		boot_fdt_add_mem_rsv_regions(fdt_blob);
-
-	if (CONFIG_IS_ENABLED(EFI_LOADER))
-		efi_lmb_reserve();
 }
 
 static __maybe_unused void lmb_reserve_common_spl(void)
-- 
2.34.1

