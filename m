Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEE8C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CC88141E;
	Mon, 17 Mar 2025 09:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1F081A0E; Mon, 17 Mar 2025 09:34:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9DD54817EC
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64C113D5;
 Mon, 17 Mar 2025 01:34:50 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0882D3F673;
 Mon, 17 Mar 2025 01:34:38 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 5/8] efi_loader: remove memory occupied by a ramdisk from
 EFI memory map
Date: Mon, 17 Mar 2025 14:03:59 +0530
Message-Id: <20250317083402.412310-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317083402.412310-1-sughosh.ganu@linaro.org>
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

ACPI has NFIT and NVDIMM support to provide ramdisks to the OS. Linux
and device trees have support for persistent memory(pmem) devices. The
firmware can then add a pmem node for the region of memory occupied by
the ramdisk when passing the device-tree to the OS.

It's worth noting that for linux to instantiate the /dev/pmemX device,
the memory described in the pmem node has to be omitted from the EFI
memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
enabled. With those enabled the pmem driver ends up calling
devm_memremap_pages() instead of devm_memremap(). The latter works
whether the memory is omitted or marked as reserved, but mapping pages
only works if the memory is omitted.

On top of that, depending on how the kernel is configured, that memory
area must be page aligned or 2MiB aligned. PowerPC is an exception here
and requires 16MiB alignment, but since we don't have EFI support for
it, limit the alignment to 2MiB.

Ensure that the ISO image is 2MiB aligned and remove the region
occupied by the image from the EFI memory map.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
* Re-word the commit message to indicate that the ramdisk region is
  being removed from the EFI memory map
* Fix the comment in prepare_loaded_image() on similar lines as above
* s/pmem memory area/pmem memory areas/
* s/MB/MiB/g

 lib/efi_loader/efi_bootmgr.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c6124c590d9..f9534ef85ed 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -18,6 +18,8 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
 
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
@@ -348,6 +350,7 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 					 struct efi_device_path **dp,
 					 struct udevice **blk)
 {
+	u64 pages;
 	efi_status_t ret;
 	struct udevice *ramdisk_blk;
 
@@ -362,13 +365,18 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	}
 
 	/*
-	 * TODO: expose the ramdisk to OS.
-	 * Need to pass the ramdisk information by the architecture-specific
-	 * methods such as 'pmem' device-tree node.
+	 * Linux supports 'pmem' which allows OS installers to find, reclaim
+	 * the mounted images and continue the installation since the contents
+	 * of the pmem region are treated as local media.
+	 *
+	 * The memory regions used for it needs to be carved out of the EFI
+	 * memory map.
 	 */
-	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	ret = efi_update_memory_map(addr, pages, EFI_CONVENTIONAL_MEMORY,
+				    false, true);
 	if (ret != EFI_SUCCESS) {
-		log_err("Memory reservation failed\n");
+		log_err("Failed to reserve memory\n");
 		goto err;
 	}
 
@@ -490,6 +498,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		ret = EFI_INVALID_PARAMETER;
 		goto err;
 	}
+	/*
+	 * Depending on the kernel configuration, pmem memory areas must be
+	 * page aligned or 2MiB aligned. PowerPC is an exception here and
+	 * requires 16MiB alignment, but since we don't have EFI support for
+	 * it, limit the alignment to 2MiB.
+	 */
+	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
 	 * If the file extension is ".iso" or ".img", mount it and try to load
-- 
2.34.1

