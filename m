Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE34E74AC2
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A6B89588;
	Tue,  3 Dec 2024 17:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B966893A9; Tue,  3 Dec 2024 17:36:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B729389538
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B183FEC;
 Tue,  3 Dec 2024 08:36:53 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35AD3F71E;
 Tue,  3 Dec 2024 08:36:22 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 3/4] efi_loader: preserve installer images in pmem
Date: Tue,  3 Dec 2024 22:06:04 +0530
Message-Id: <20241203163605.1482152-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
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

One of the problems OS installers face, when running in EFI, is that
the mounted ISO after calling ExitBootServices goes away. For some
distros this is a problem since they rely on finding some core packages
before continuing the installation. Distros have works around this --
e.g Fedora has a special kernel command line parameter called
inst.stage2 [0].

ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
don't have anything in place for DTs. Linux and device trees have support
for persistent memory devices.

It's worth noting that for linux to instantiate the /dev/pmemX device,
the memory described in the pmem node has to be omitted from the EFI
memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
enabled. With those enabled the pmem driver ends up calling
devm_memremap_pages() instead of devm_memremap(). The latter works
whether the memory is omitted or marked as reserved, but mapping pages
only works if the memory is omitted.

On top of that, depending on how the kernel is configured, that memory
area must be page aligned or 2MB aligned. PowerPC is an exception here
and requires 16MB alignment, but since we don't have EFI support for
it, limit the alignment to 2MB.

Ensure that the ISO image is 2MB aligned and remove the region
occupied by the image from the EFI memory map.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes since V1: None

 lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c51a6ef2ed..b906e53e26e 100644
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
@@ -362,13 +364,16 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
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
+	ret = efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
 	if (ret != EFI_SUCCESS) {
-		log_err("Memory reservation failed\n");
+		log_err("Failed to reserve memory\n");
 		goto err;
 	}
 
@@ -490,6 +495,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		ret = EFI_INVALID_PARAMETER;
 		goto err;
 	}
+	/*
+	 * Depending on the kernel configuration, pmem memory area must be page
+	 * aligned or 2MB aligned. PowerPC is an exception here and requires
+	 * 16MB alignment, but since we don't have EFI support for it, limit
+	 * the alignment to 2MB.
+	 */
+	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
 	 * If the file extension is ".iso" or ".img", mount it and try to load
-- 
2.34.1

