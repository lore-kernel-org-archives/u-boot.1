Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F6EC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A151A819FC;
	Wed, 12 Mar 2025 09:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8729D8197F; Wed, 12 Mar 2025 09:55:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3B583805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C718152B;
 Wed, 12 Mar 2025 01:55:22 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2566C3F5A1;
 Wed, 12 Mar 2025 01:55:08 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v8 8/8] blkmap: pass information on ISO image to the OS
Date: Wed, 12 Mar 2025 14:24:24 +0530
Message-Id: <20250312085424.1201148-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
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
Changes since V7:
* Fix checkpatch errors in blkmap.c and efi_helper.c

 boot/image-fdt.c            |  7 ++++++
 drivers/block/blkmap.c      | 44 +++++++++++++++++++++++++++++++++++++
 include/blkmap.h            | 17 ++++++++++++++
 include/efi.h               | 13 +++++++++++
 lib/efi_loader/efi_helper.c | 39 ++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)

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
index eefed615998..5f7602d0405 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -498,6 +498,50 @@ err:
 	return err;
 }
 
+static bool blkmap_mem_preserve_slice(struct blkmap_slice *bms)
+{
+	return (bms->attr & (BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE)) ==
+		(BLKMAP_SLICE_MEM | BLKMAP_SLICE_PRESERVE);
+}
+
+int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
+					      u32 size), void *ctx)
+{
+	int ret;
+	u32 size;
+	ulong addr;
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
+			addr = (ulong)(uintptr_t)bmm->addr;
+			size = (u32)bms->blkcnt << bd->log2blksz;
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
index 754d8671b01..30ce80c0ad1 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -7,6 +7,7 @@
 #ifndef _BLKMAP_H
 #define _BLKMAP_H
 
+#include <blk.h>
 #include <dm/lists.h>
 
 /**
@@ -104,4 +105,20 @@ int blkmap_destroy(struct udevice *dev);
 int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
 			  struct udevice **devp);
 
+/**
+ * blkmap_get_preserved_pmem_slice() - Look for memory mapped preserved slice
+ * @cb: Callback function to call for the blkmap slice
+ * @ctx: Argument to be passed to the callback function
+ *
+ * The function is used to iterate through all the blkmap slices, looking
+ * specifically for memory mapped blkmap mapping which has been
+ * created with the preserve attribute. The function looks for such slices
+ * with the relevant attributes and then calls the callback function which
+ * then does additional configuration as needed.
+ *
+ * Return: 0 on success, negative error on failure
+ */
+int blkmap_get_preserved_pmem_slice(int (*cb)(void *ctx, ulong addr,
+					      u32 size), void *ctx);
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
index 37e5859741f..62772a0d747 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blkmap.h>
 #include <bootm.h>
 #include <env.h>
 #include <image.h>
@@ -680,3 +681,41 @@ out:
 
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
+static int pmem_node_efi_memmap_setup(void *fdt, ulong addr, u32 size)
+{
+	int ret;
+	efi_status_t status;
+
+	ret = fdt_fixup_pmem_region(fdt, addr, size);
+	if (ret) {
+		log_err("Failed to setup pmem node for addr %#lx, size %#x, err %d\n",
+			addr, size, ret);
+		return ret;
+	}
+
+	status = efi_remove_memory_map(addr, size,
+				       EFI_CONVENTIONAL_MEMORY);
+	if (status != EFI_SUCCESS)
+		return -1;
+
+	return 0;
+}
+
+int fdt_efi_pmem_setup(void *fdt)
+{
+	return blkmap_get_preserved_pmem_slice(pmem_node_efi_memmap_setup,
+					       fdt);
+}
-- 
2.34.1

