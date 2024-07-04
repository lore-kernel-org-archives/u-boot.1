Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3523C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDA5888EF;
	Thu,  4 Jul 2024 09:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B983888EC; Thu,  4 Jul 2024 09:36:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2F940888FD
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE0AB367;
 Thu,  4 Jul 2024 00:37:09 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4B43F762;
 Thu,  4 Jul 2024 00:36:41 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 11/48] lmb: pass a flag to image_setup_libfdt() for lmb
 reservations
Date: Thu,  4 Jul 2024 13:05:07 +0530
Message-Id: <20240704073544.670249-12-sughosh.ganu@linaro.org>
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

The image_setup_libfdt() function optionally calls the LMB API to
reserve the region of memory occupied by the FDT blob. This was
earlier determined through the presence of the pointer to the lmb
structure, which is no longer present. Pass a flag to the
image_setup_libfdt() function to indicate if the region occupied by
the FDT blob is to be marked as reserved by the LMB module.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Use true/false identifiers for bool instead of 1/0
* Fix the argument passed to the function in arch/mips/lib/bootm.c

 arch/mips/lib/bootm.c         | 2 +-
 boot/image-board.c            | 2 +-
 boot/image-fdt.c              | 7 +++----
 cmd/elf.c                     | 2 +-
 include/image.h               | 5 ++---
 lib/efi_loader/efi_dt_fixup.c | 2 +-
 lib/efi_loader/efi_helper.c   | 2 +-
 7 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 54d89e9cca..8fb3a3923f 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -247,7 +247,7 @@ static int boot_setup_fdt(struct bootm_headers *images)
 	images->initrd_start = virt_to_phys((void *)images->initrd_start);
 	images->initrd_end = virt_to_phys((void *)images->initrd_end);
 
-	return image_setup_libfdt(images, images->ft_addr, &images->lmb);
+	return image_setup_libfdt(images, images->ft_addr, true);
 }
 
 static void boot_prep_linux(struct bootm_headers *images)
diff --git a/boot/image-board.c b/boot/image-board.c
index e3cb418e3c..1f8c1ac69f 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -904,7 +904,7 @@ int image_setup_linux(struct bootm_headers *images)
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && of_size) {
-		ret = image_setup_libfdt(images, *of_flat_tree, lmb);
+		ret = image_setup_libfdt(images, *of_flat_tree, true);
 		if (ret)
 			return ret;
 	}
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 943a3477a1..7c3d66bad7 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -566,8 +566,7 @@ __weak int arch_fixup_fdt(void *blob)
 	return 0;
 }
 
-int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       struct lmb *lmb)
+int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
 	ulong *initrd_end = &images->initrd_end;
@@ -667,7 +666,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	}
 
 	/* Delete the old LMB reservation */
-	if (lmb)
+	if (CONFIG_IS_ENABLED(LMB) && lmb)
 		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob));
 
 	ret = fdt_shrink_to_minimum(blob, 0);
@@ -676,7 +675,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	of_size = ret;
 
 	/* Create a new LMB reservation */
-	if (lmb)
+	if (CONFIG_IS_ENABLED(LMB) && lmb)
 		lmb_reserve(map_to_sysmem(blob), of_size);
 
 #if defined(CONFIG_ARCH_KEYSTONE)
diff --git a/cmd/elf.c b/cmd/elf.c
index 32b7462f92..df53c5b0cb 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -68,7 +68,7 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
 		flush();
 
-		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
+		if (image_setup_libfdt(&img, (void *)fdt_addr, false))
 			return 1;
 	}
 #endif
diff --git a/include/image.h b/include/image.h
index 8036eae15c..47fd80bef4 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1018,11 +1018,10 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
  *
  * @images:	Images information
  * @blob:	FDT to update
- * @lmb:	Points to logical memory block structure
+ * @lmb:	Flag indicating use of lmb for reserving FDT memory region
  * Return: 0 if ok, <0 on failure
  */
-int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       struct lmb *lmb);
+int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb);
 
 /**
  * Set up the FDT to use for booting a kernel
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 9886e6897c..9d017804ee 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -172,7 +172,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 		}
 
 		fdt_set_totalsize(dtb, *buffer_size);
-		if (image_setup_libfdt(&img, dtb, NULL)) {
+		if (image_setup_libfdt(&img, dtb, false)) {
 			log_err("failed to process device tree\n");
 			ret = EFI_INVALID_PARAMETER;
 			goto out;
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 348612c3da..13e97fb741 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -513,7 +513,7 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
-	if (image_setup_libfdt(&img, fdt, NULL)) {
+	if (image_setup_libfdt(&img, fdt, false)) {
 		log_err("ERROR: failed to process device tree\n");
 		return EFI_LOAD_ERROR;
 	}
-- 
2.34.1

