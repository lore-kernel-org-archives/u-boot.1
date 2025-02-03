Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E933FC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 11:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DC380107;
	Mon,  3 Feb 2025 11:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED1980568; Mon,  3 Feb 2025 11:59:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C95080711
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C81711FB;
 Mon,  3 Feb 2025 03:00:14 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507F83F5A1;
 Mon,  3 Feb 2025 02:59:46 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 5/5] blkmap: add pmem nodes for blkmap memory mapped slices
Date: Mon,  3 Feb 2025 16:29:12 +0530
Message-Id: <20250203105912.196654-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203105912.196654-1-sughosh.ganu@linaro.org>
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
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
memory which needs to be added to the devicetree as persistent
memory (pmem) node. The OS installer then gets information about the
presence of this ISO image through the pmem node and proceeds with the
installation.

In U-Boot, this ISO image gets mounted as a blkmap device, with a
memory mapped slice. Add a helper function which iterates through all
such memory mapped blkmap slices, and calls the FDT fixup function to
add the pmem node. Invoke this helper function as part of the DT fixup
which happens before booting the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V3:
* Move the definition of the helper function to the efi_helper.c
* Remove the region of the blkmap mem map device from the EFI memory
  map along with adding the pmem node

 boot/image-fdt.c            |  9 ++++
 drivers/block/blkmap.c      | 82 -------------------------------------
 include/blkmap.h            | 81 ++++++++++++++++++++++++++++++++++++
 include/efi.h               | 13 ++++++
 lib/efi_loader/efi_helper.c | 52 +++++++++++++++++++++++
 5 files changed, 155 insertions(+), 82 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9d1598b1a93..e64243af88e 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -8,6 +8,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <blkmap.h>
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
@@ -649,6 +650,14 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	if (!ft_verify_fdt(blob))
 		goto err;
 
+	if (CONFIG_IS_ENABLED(BLKMAP) && CONFIG_IS_ENABLED(EFI_LOADER)) {
+		fdt_ret = fdt_efi_pmem_setup(blob);
+		if (fdt_ret) {
+			log_err("pmem node fixup failed\n");
+			goto err;
+		}
+	}
+
 	/* after here we are using a livetree */
 	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
 		struct event_ft_fixup fixup;
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 4c71ec784e0..2c7f4966ae9 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -14,59 +14,6 @@
 #include <dm/lists.h>
 #include <dm/root.h>
 
-struct blkmap;
-
-/**
- * struct blkmap_slice - Region mapped to a blkmap
- *
- * Common data for a region mapped to a blkmap, specialized by each
- * map type.
- *
- * @node: List node used to associate this slice with a blkmap
- * @blknr: Start block number of the mapping
- * @blkcnt: Number of blocks covered by this mapping
- * @type: Type of blkmap slice
- */
-struct blkmap_slice {
-	struct list_head node;
-
-	lbaint_t blknr;
-	lbaint_t blkcnt;
-	enum blkmap_slice_type type;
-
-	/**
-	 * @read: - Read from slice
-	 *
-	 * @read.bm: Blkmap to which this slice belongs
-	 * @read.bms: This slice
-	 * @read.blknr: Start block number to read from
-	 * @read.blkcnt: Number of blocks to read
-	 * @read.buffer: Buffer to store read data to
-	 */
-	ulong (*read)(struct blkmap *bm, struct blkmap_slice *bms,
-		      lbaint_t blknr, lbaint_t blkcnt, void *buffer);
-
-	/**
-	 * @write: - Write to slice
-	 *
-	 * @write.bm: Blkmap to which this slice belongs
-	 * @write.bms: This slice
-	 * @write.blknr: Start block number to write to
-	 * @write.blkcnt: Number of blocks to write
-	 * @write.buffer: Data to be written
-	 */
-	ulong (*write)(struct blkmap *bm, struct blkmap_slice *bms,
-		       lbaint_t blknr, lbaint_t blkcnt, const void *buffer);
-
-	/**
-	 * @destroy: - Tear down slice
-	 *
-	 * @read.bm: Blkmap to which this slice belongs
-	 * @read.bms: This slice
-	 */
-	void (*destroy)(struct blkmap *bm, struct blkmap_slice *bms);
-};
-
 static bool blkmap_slice_contains(struct blkmap_slice *bms, lbaint_t blknr)
 {
 	return (blknr >= bms->blknr) && (blknr < (bms->blknr + bms->blkcnt));
@@ -116,20 +63,6 @@ static int blkmap_slice_add(struct blkmap *bm, struct blkmap_slice *new)
 	return 0;
 }
 
-/**
- * struct blkmap_linear - Linear mapping to other block device
- *
- * @slice: Common map data
- * @blk: Target block device of this mapping
- * @blknr: Start block number of the target device
- */
-struct blkmap_linear {
-	struct blkmap_slice slice;
-
-	struct udevice *blk;
-	lbaint_t blknr;
-};
-
 static ulong blkmap_linear_read(struct blkmap *bm, struct blkmap_slice *bms,
 				lbaint_t blknr, lbaint_t blkcnt, void *buffer)
 {
@@ -188,21 +121,6 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	return err;
 }
 
-/**
- * struct blkmap_mem - Memory mapping
- *
- * @slice: Common map data
- * @addr: Target memory region of this mapping
- * @remapped: True if @addr is backed by a physical to virtual memory
- * mapping that must be torn down at the end of this mapping's
- * lifetime.
- */
-struct blkmap_mem {
-	struct blkmap_slice slice;
-	void *addr;
-	bool remapped;
-};
-
 static ulong blkmap_mem_read(struct blkmap *bm, struct blkmap_slice *bms,
 			     lbaint_t blknr, lbaint_t blkcnt, void *buffer)
 {
diff --git a/include/blkmap.h b/include/blkmap.h
index c7b4bf13c4e..e5e2d971548 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -7,6 +7,7 @@
 #ifndef _BLKMAP_H
 #define _BLKMAP_H
 
+#include <blk.h>
 #include <dm/lists.h>
 
 /* Type of blkmap slice, Linear or Memory */
@@ -30,6 +31,86 @@ struct blkmap {
 	struct list_head slices;
 };
 
+/**
+ * struct blkmap_slice - Region mapped to a blkmap
+ *
+ * Common data for a region mapped to a blkmap, specialized by each
+ * map type.
+ *
+ * @node: List node used to associate this slice with a blkmap
+ * @blknr: Start block number of the mapping
+ * @blkcnt: Number of blocks covered by this mapping
+ * @type: Type of blkmap slice
+ */
+struct blkmap_slice {
+	struct list_head node;
+
+	lbaint_t blknr;
+	lbaint_t blkcnt;
+	enum blkmap_slice_type type;
+
+	/**
+	 * @read: - Read from slice
+	 *
+	 * @read.bm: Blkmap to which this slice belongs
+	 * @read.bms: This slice
+	 * @read.blknr: Start block number to read from
+	 * @read.blkcnt: Number of blocks to read
+	 * @read.buffer: Buffer to store read data to
+	 */
+	ulong (*read)(struct blkmap *bm, struct blkmap_slice *bms,
+		      lbaint_t blknr, lbaint_t blkcnt, void *buffer);
+
+	/**
+	 * @write: - Write to slice
+	 *
+	 * @write.bm: Blkmap to which this slice belongs
+	 * @write.bms: This slice
+	 * @write.blknr: Start block number to write to
+	 * @write.blkcnt: Number of blocks to write
+	 * @write.buffer: Data to be written
+	 */
+	ulong (*write)(struct blkmap *bm, struct blkmap_slice *bms,
+		       lbaint_t blknr, lbaint_t blkcnt, const void *buffer);
+
+	/**
+	 * @destroy: - Tear down slice
+	 *
+	 * @read.bm: Blkmap to which this slice belongs
+	 * @read.bms: This slice
+	 */
+	void (*destroy)(struct blkmap *bm, struct blkmap_slice *bms);
+};
+
+/**
+ * struct blkmap_mem - Memory mapping
+ *
+ * @slice: Common map data
+ * @addr: Target memory region of this mapping
+ * @remapped: True if @addr is backed by a physical to virtual memory
+ * mapping that must be torn down at the end of this mapping's
+ * lifetime.
+ */
+struct blkmap_mem {
+	struct blkmap_slice slice;
+	void *addr;
+	bool remapped;
+};
+
+/**
+ * struct blkmap_linear - Linear mapping to other block device
+ *
+ * @slice: Common map data
+ * @blk: Target block device of this mapping
+ * @blknr: Start block number of the target device
+ */
+struct blkmap_linear {
+	struct blkmap_slice slice;
+
+	struct udevice *blk;
+	lbaint_t blknr;
+};
+
 /**
  * blkmap_map_linear() - Map region of other block device
  *
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
index 04b2efc4a3b..1050ed1f952 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blkmap.h>
 #include <bootm.h>
 #include <env.h>
 #include <image.h>
@@ -19,6 +20,8 @@
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <host_arch.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 
@@ -680,3 +683,52 @@ out:
 
 	return ret;
 }
+
+static int add_blkmap_pmem_nodes(void *fdt, struct blkmap *bm)
+{
+	int ret;
+	u32 size;
+	ulong addr;
+	efi_status_t status;
+	struct blkmap_mem *bmm;
+	struct blkmap_slice *bms;
+	struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
+
+	list_for_each_entry(bms, &bm->slices, node) {
+		if (bms->type != BLKMAP_SLICE_MEM)
+			continue;
+
+		bmm = container_of(bms, struct blkmap_mem, slice);
+
+		addr = (ulong)(uintptr_t)bmm->addr;
+		size = (u32)bms->blkcnt << bd->log2blksz;
+
+		ret = fdt_fixup_pmem_region(fdt, addr, size);
+		if (ret)
+			return ret;
+
+		status = efi_remove_memory_map(addr, size,
+					       EFI_CONVENTIONAL_MEMORY);
+		if (status != EFI_SUCCESS)
+			return -1;
+	}
+
+	return 0;
+}
+
+int fdt_efi_pmem_setup(void *fdt)
+{
+	int ret;
+	struct udevice *dev;
+	struct uclass *uc;
+	struct blkmap *bm;
+
+	uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
+		bm = dev_get_plat(dev);
+		ret = add_blkmap_pmem_nodes(fdt, bm);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
-- 
2.34.1

