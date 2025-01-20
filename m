Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B644C0218B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 10:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FFE801CF;
	Mon, 20 Jan 2025 11:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCAC801CF; Mon, 20 Jan 2025 11:51:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 22349807C0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D12D1063;
 Mon, 20 Jan 2025 02:51:52 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640023F740;
 Mon, 20 Jan 2025 02:51:20 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 5/5] blkmap: add pmem nodes for blkmap mem mapping devices
Date: Mon, 20 Jan 2025 16:20:45 +0530
Message-Id: <20250120105045.1281262-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
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

In U-Boot, this ISO image gets mounted as a memory mapped blkmap
device. Add a helper function which iterates through all such memory
mapped blkmap devices, and calls the FDT fixup function to add the
pmem node. Invoke this helper function as part of the DT fixup which
happens before booting the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: New patch

 boot/image-fdt.c              |  9 ++++
 drivers/block/blkmap.c        | 80 ------------------------------
 drivers/block/blkmap_helper.c | 45 +++++++++++++++++
 include/blkmap.h              | 91 +++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 80 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9d1598b1a93..9af00f406bb 100644
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
 
+	if (CONFIG_IS_ENABLED(BLKMAP)) {
+		fdt_ret = blkmap_fdt_pmem_setup(blob);
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
index a817345b6bc..f4a89277173 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -14,57 +14,6 @@
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
- */
-struct blkmap_slice {
-	struct list_head node;
-
-	lbaint_t blknr;
-	lbaint_t blkcnt;
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
@@ -114,20 +63,6 @@ static int blkmap_slice_add(struct blkmap *bm, struct blkmap_slice *new)
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
@@ -188,21 +123,6 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
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
diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
index 56cbe57d4aa..c91a4410d9c 100644
--- a/drivers/block/blkmap_helper.c
+++ b/drivers/block/blkmap_helper.c
@@ -7,8 +7,11 @@
 
 #include <blk.h>
 #include <blkmap.h>
+#include <fdt_support.h>
 #include <dm/device.h>
 #include <dm/device-internal.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
 
 int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
 			  struct udevice **devp)
@@ -51,3 +54,45 @@ err:
 
 	return ret;
 }
+
+static int blkmap_add_pmem_node(void *fdt, struct blkmap *bm)
+{
+	int ret;
+	u32 size;
+	ulong addr;
+	struct blkmap_mem *bmm;
+	struct blkmap_slice *bms;
+	struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
+
+	list_for_each_entry(bms, &bm->slices, node) {
+		bmm = container_of(bms, struct blkmap_mem, slice);
+
+		addr = (ulong)(uintptr_t)bmm->addr;
+		size = (u32)bms->blkcnt << bd->log2blksz;
+
+		ret = fdt_fixup_pmem_region(fdt, addr, size);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int blkmap_fdt_pmem_setup(void *fdt)
+{
+	int ret;
+	struct udevice *dev;
+	struct uclass *uc;
+	struct blkmap *bm;
+
+	uclass_id_foreach_dev(UCLASS_BLKMAP, dev, uc) {
+		bm = dev_get_plat(dev);
+		if (bm->type == BLKMAP_MEM) {
+			ret = blkmap_add_pmem_node(fdt, bm);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/include/blkmap.h b/include/blkmap.h
index 21169c30af1..4fe8ec2767c 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -7,6 +7,7 @@
 #ifndef _BLKMAP_H
 #define _BLKMAP_H
 
+#include <blk.h>
 #include <dm/lists.h>
 
 /* Type of blkmap device, Linear or Memory */
@@ -32,6 +33,84 @@ struct blkmap {
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
+ */
+struct blkmap_slice {
+	struct list_head node;
+
+	lbaint_t blknr;
+	lbaint_t blkcnt;
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
@@ -112,4 +191,16 @@ int blkmap_destroy(struct udevice *dev);
 int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
 			  struct udevice **devp);
 
+/**
+ * blkmap_fdt_pmem_setup() - Add pmem nodes to the devicetree
+ * @fdt: Devicetree to add the pmem nodes to
+ *
+ * Iterate through all the blkmap devices, look for BLKMAP_MEM devices,
+ * and add pmem nodes corresponding to the blkmap slice to the
+ * devicetree.
+ *
+ * Returns: 0 on success, negative error on failure
+ */
+int blkmap_fdt_pmem_setup(void *fdt);
+
 #endif	/* _BLKMAP_H */
-- 
2.34.1

