Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D80DC35FF8
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C905381B42;
	Mon, 17 Mar 2025 09:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E73E8058A; Mon, 17 Mar 2025 09:34:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 28FD780107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EFDC13D5;
 Mon, 17 Mar 2025 01:34:59 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEA0A3F673;
 Mon, 17 Mar 2025 01:34:47 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 8/8] blkmap: pass information on ISO image to the OS
Date: Mon, 17 Mar 2025 14:04:02 +0530
Message-Id: <20250317083402.412310-9-sughosh.ganu@linaro.org>
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

The EFI HTTP boot puts the ISO installer image at some location in
memory. Information about this image has to be passed on to the OS
kernel, which is done by adding a persistent memory(pmem) node to the
devicetree(DT) that is passed to the OS. The OS kernel then gets
information about the presence of this ISO image and proceeds with the
installation.

In U-Boot, this ISO image gets mounted as a memory mapped blkmap
device slice, with the 'preserve' attribute. Add a helper function
which iterates through all such slices, and invokes a callback. The
callback adds the pmem node to the DT and removes the corresponding
memory region from the EFI memory map. Invoke this helper function as
part of the DT fixup which happens before booting the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
---
Changes since V8:
* s/blkmap_get_preserved_pmem_slice/blkmap_get_preserved_pmem_slices/g
  to highlight that more than one slice is being looked for
* Add information on the parameters being passed to the callback
  function in blkmap_get_preserved_pmem_slices() description
* Highlight the fact that the callback gets called for every slice
  found in blkmap_get_preserved_pmem_slices() description
* Highlight the fact that invoking the callback stops when an error is
  returned by the callback in blkmap_get_preserved_pmem_slices()
  description
* Put some description of a typical use-case of the callback function
  in blkmap_get_preserved_pmem_slices() description

 boot/image-fdt.c            |  7 ++++++
 drivers/block/blkmap.c      | 43 +++++++++++++++++++++++++++++++++++++
 include/blkmap.h            | 29 +++++++++++++++++++++++++
 include/efi.h               | 13 +++++++++++
 lib/efi_loader/efi_helper.c | 42 ++++++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9d1598b1a93..8f718ad29f6 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
+#include <efi.h>
 #include <env.h>
 #include <errno.h>
 #include <image.h>
@@ -649,6 +650,12 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	if (!ft_verify_fdt(blob))
 		goto err;
 
+	if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
+		fdt_ret = fdt_efi_pmem_setup(blob);
+		if (fdt_ret)
+			goto err;
+	}
+
 	/* after here we are using a livetree */
 	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
 		struct event_ft_fixup fixup;
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 1b161bd90be..473c65b5911 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -517,6 +517,49 @@ err:
 	return err;
 }
 
+static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
+{
+	return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
+		(BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
+}
+
+int blkmap_get_preserved_pmem_slices(int (*cb)(void *ctx, u64 addr,
+					       u64 size), void *ctx)
+{
+	int ret;
+	u64 addr, size;
+	struct udevice *dev;
+	struct uclass *uc;
+	struct blkmap *bm;
+	struct blkmap_mem *bmm;
+	struct blkmap_slice *bms;
+	struct blk_desc *bd;
+
+	if (!cb) {
+		log_debug("%s: No callback passed to the function\n", __func__);
+		return 0;
+	}
+
+	uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
+		bm = dev_get_plat(dev);
+		bd = dev_get_uclass_plat(bm->blk);
+
+		list_for_each_entry(bms, &bm->slices, node) {
+			if (!blkmap_mem_preserve_slice(bms))
+				continue;
+
+			bmm = container_of(bms, struct blkmap_mem, slice);
+			addr = (u64)(uintptr_t)bmm->addr;
+			size = (u64)bms->blkcnt << bd->log2blksz;
+			ret = cb(ctx, addr, size);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int blkmap_destroy(struct udevice *dev)
 {
 	int err;
diff --git a/include/blkmap.h b/include/blkmap.h
index 754d8671b01..57555fda4fb 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -7,6 +7,7 @@
 #ifndef _BLKMAP_H
 #define _BLKMAP_H
 
+#include <blk.h>
 #include <dm/lists.h>
 
 /**
@@ -104,4 +105,32 @@ int blkmap_destroy(struct udevice *dev);
 int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
 			  struct udevice **devp);
 
+/**
+ * blkmap_get_preserved_pmem_slices() - Look for memory mapped preserved slices
+ * @cb: Callback function to call for the blkmap slice
+ * @ctx: Argument to be passed to the callback function
+ *
+ * The function is used to iterate through all the blkmap slices, looking
+ * specifically for memory mapped blkmap mapping which has been
+ * created with the preserve attribute. The function looks for such slices
+ * with the relevant attributes and then calls the callback function which
+ * then does additional configuration as needed. The callback function is
+ * invoked for all the discovered slices, unless there is an error returned
+ * by the callback, in which case the function returns that error.
+ *
+ * The callback function has the following arguments
+ * @ctx:	Argument to be passed to the callback function
+ * @addr:	Start address of the memory mapped slice
+ * @size:	Size of the memory mapped slice
+ *
+ * Typically, the callback will perform some configuration needed for the
+ * information passed on to it. An example of this would be setting up the
+ * pmem node in a device-tree(passed through the ctx argument) with the
+ * parameters passed on to the callback.
+ *
+ * Return: 0 on success, negative error on failure
+ */
+int blkmap_get_preserved_pmem_slices(int (*cb)(void *ctx, u64 addr,
+					       u64 size), void *ctx);
+
 #endif	/* _BLKMAP_H */
diff --git a/include/efi.h b/include/efi.h
index d005cb6181e..f9bbb175c3a 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -705,4 +705,17 @@ static inline bool efi_use_host_arch(void)
  */
 int efi_get_pxe_arch(void);
 
+/**
+ * fdt_efi_pmem_setup() - Pmem setup in DT and EFI memory map
+ * @fdt: Devicetree to add the pmem nodes to
+ *
+ * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
+ * and add pmem nodes corresponding to the blkmap slice to the
+ * devicetree along with removing the corresponding region from the
+ * EFI memory map.
+ *
+ * Returns: 0 on success, negative error on failure
+ */
+int fdt_efi_pmem_setup(void *fdt);
+
 #endif /* _LINUX_EFI_H */
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index f6fbcdffe82..8c32059edda 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blkmap.h>
 #include <bootm.h>
 #include <env.h>
 #include <image.h>
@@ -687,3 +688,44 @@ out:
 
 	return ret;
 }
+
+/**
+ * pmem_node_efi_memmap_setup() - Add pmem node and tweak EFI memmap
+ * @fdt: The devicetree to which pmem node is added
+ * @addr: start address of the pmem node
+ * @size: size of the memory of the pmem node
+ *
+ * The function adds the pmem node to the device-tree along with removing
+ * the corresponding region from the EFI memory map. Used primarily to
+ * pass the information of a RAM based ISO image to the OS.
+ *
+ * Return: 0 on success, -ve value on error
+ */
+static int pmem_node_efi_memmap_setup(void *fdt, u64 addr, u64 size)
+{
+	int ret;
+	u64 pages;
+	efi_status_t status;
+
+	ret = fdt_fixup_pmem_region(fdt, addr, size);
+	if (ret) {
+		log_err("Failed to setup pmem node for addr %#llx, size %#llx, err %d\n",
+			addr, size, ret);
+		return ret;
+	}
+
+	/* Remove the pmem region from the EFI memory map */
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	status = efi_update_memory_map(addr, pages, EFI_CONVENTIONAL_MEMORY,
+				       false, true);
+	if (status != EFI_SUCCESS)
+		return -1;
+
+	return 0;
+}
+
+int fdt_efi_pmem_setup(void *fdt)
+{
+	return blkmap_get_preserved_pmem_slices(pmem_node_efi_memmap_setup,
+						fdt);
+}
-- 
2.34.1

