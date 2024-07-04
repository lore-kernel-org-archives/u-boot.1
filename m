Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4582DC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2407A8897B;
	Thu,  4 Jul 2024 09:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9FE888E7; Thu,  4 Jul 2024 09:38:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A9DF38897B
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3773FDA7;
 Thu,  4 Jul 2024 00:39:19 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E483F762;
 Thu,  4 Jul 2024 00:38:50 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 46/48] lmb: mark the EFI runtime memory regions as
 reserved
Date: Thu,  4 Jul 2024 13:05:42 +0530
Message-Id: <20240704073544.670249-47-sughosh.ganu@linaro.org>
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

Mark the EFI runtime memory region as reserved memory during board
init so that it does not get allocated by the LMB module on subsequent
memory requests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 lib/lmb.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 387ec2ac65..6018f1de31 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <asm/sections.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -212,33 +213,31 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
 /**
  * efi_lmb_reserve() - add reservations for EFI memory
  *
- * Add reservations for all EFI memory areas that are not
- * EFI_CONVENTIONAL_MEMORY.
+ * Add reservations for EFI runtime services memory
  *
- * Return:	0 on success, 1 on failure
+ * Return: None
  */
-static __maybe_unused int efi_lmb_reserve(void)
+static __maybe_unused void efi_lmb_reserve(void)
 {
-	struct efi_mem_desc *memmap = NULL, *map;
-	efi_uintn_t i, map_size = 0;
-	efi_status_t ret;
+	phys_addr_t runtime_start, runtime_end;
+	unsigned long runtime_mask = EFI_PAGE_MASK;
 
-	ret = efi_get_memory_map_alloc(&map_size, &memmap);
-	if (ret != EFI_SUCCESS)
-		return 1;
+#if defined(__aarch64__)
+	/*
+	 * Runtime Services must be 64KiB aligned according to the
+	 * "AArch64 Platforms" section in the UEFI spec (2.7+).
+	 */
 
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
+	runtime_mask = SZ_64K - 1;
+#endif
 
-	return 0;
+	/* Reserve the EFI runtime services memory */
+	runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
+	runtime_end = (uintptr_t)__efi_runtime_stop;
+	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
+
+	lmb_reserve_flags(runtime_start, runtime_end - runtime_start,
+			  LMB_NOOVERWRITE | LMB_NONOTIFY);
 }
 
 static void lmb_reserve_common(void *fdt_blob)
-- 
2.34.1

