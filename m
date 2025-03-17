Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF3EC35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6D5811B2;
	Mon, 17 Mar 2025 09:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3100881A04; Mon, 17 Mar 2025 09:34:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E31D1811B2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5753813D5;
 Mon, 17 Mar 2025 01:34:56 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E888D3F673;
 Mon, 17 Mar 2025 01:34:44 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 7/8] blkmap: add an attribute to preserve the mem mapping
Date: Mon, 17 Mar 2025 14:04:01 +0530
Message-Id: <20250317083402.412310-8-sughosh.ganu@linaro.org>
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

Some blkmap memory mapped devices might have to be relevant even
after U-Boot passes control to the next image as part of the platform
boot. An example of such a mapping would be an OS installer ISO image,
information for which has to be provided to the OS kernel. Use the
'preserve' attribute for such mappings. The code for adding a pmem
node to the device-tree then checks if this attribute is set, and adds
a node only for mappings which have this attribute.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V8:
* Add comments to the macro added in the patch

 cmd/blkmap.c                  |  9 +++++++--
 drivers/block/blkmap.c        | 19 +++++++++++++++----
 drivers/block/blkmap_helper.c |  2 +-
 include/blkmap.h              |  4 +++-
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index 164f80f1387..86a123b1cd3 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -62,13 +62,18 @@ static int do_blkmap_map_mem(struct map_ctx *ctx, int argc, char *const argv[])
 {
 	phys_addr_t addr;
 	int err;
+	bool preserve = false;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
 	addr = hextoul(argv[1], NULL);
 
-	err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr);
+	if (argc == 3 && !strcmp(argv[2], "preserve"))
+		preserve = true;
+
+	err = blkmap_map_pmem(ctx->dev, ctx->blknr, ctx->blkcnt, addr,
+			      preserve);
 	if (err) {
 		printf("Unable to map %#llx at block 0x" LBAF ": %d\n",
 		       (unsigned long long)addr, ctx->blknr, err);
@@ -221,7 +226,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
 	"blkmap create <label> - create device\n"
 	"blkmap destroy <label> - destroy device\n"
 	"blkmap map <label> <blk#> <cnt> linear <interface> <dev> <blk#> - device mapping\n"
-	"blkmap map <label> <blk#> <cnt> mem <addr> - memory mapping\n",
+	"blkmap map <label> <blk#> <cnt> mem <addr> [preserve] - memory mapping\n",
 	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(part, 2, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(dev, 4, 1, do_blkmap_common),
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 08f68570224..1b161bd90be 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -32,6 +32,14 @@ struct blkmap;
  */
 #define BLKMAP_SLICE_MEM	BIT(1)
 
+/**
+ * define BLKMAP_SLICE_PRESERVE - Preserved blkmap slice
+ *
+ * This blkmap slice is intended to be preserved, and it's
+ * information passed on to a later stage, like OS.
+ */
+#define BLKMAP_SLICE_PRESERVE	BIT(2)
+
 /**
  * struct blkmap_slice - Region mapped to a blkmap
  *
@@ -253,7 +261,7 @@ static void blkmap_mem_destroy(struct blkmap *bm, struct blkmap_slice *bms)
 }
 
 int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
-		     void *addr, bool remapped)
+		     void *addr, bool remapped, bool preserve)
 {
 	struct blkmap *bm = dev_get_plat(dev);
 	struct blkmap_mem *bmm;
@@ -278,6 +286,9 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		.remapped = remapped,
 	};
 
+	if (preserve)
+		bmm->slice.attr |= BLKMAP_SLICE_PRESERVE;
+
 	err = blkmap_slice_add(bm, &bmm->slice);
 	if (err)
 		free(bmm);
@@ -288,11 +299,11 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		   void *addr)
 {
-	return __blkmap_map_mem(dev, blknr, blkcnt, addr, false);
+	return __blkmap_map_mem(dev, blknr, blkcnt, addr, false, false);
 }
 
 int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
-		    phys_addr_t paddr)
+		    phys_addr_t paddr, bool preserve)
 {
 	struct blkmap *bm = dev_get_plat(dev);
 	struct blk_desc *bd = dev_get_uclass_plat(bm->blk);
@@ -303,7 +314,7 @@ int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	if (!addr)
 		return -ENOMEM;
 
-	err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true);
+	err = __blkmap_map_mem(dev, blknr, blkcnt, addr, true, preserve);
 	if (err)
 		unmap_sysmem(addr);
 
diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
index bfba14110d2..2f1bc28ee5d 100644
--- a/drivers/block/blkmap_helper.c
+++ b/drivers/block/blkmap_helper.c
@@ -28,7 +28,7 @@ int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
 	bm = dev_get_plat(bm_dev);
 	desc = dev_get_uclass_plat(bm->blk);
 	blknum = image_size >> desc->log2blksz;
-	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
+	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr, true);
 	if (ret) {
 		log_err("Unable to map %#llx at block %d : %d\n",
 			(unsigned long long)image_addr, 0, ret);
diff --git a/include/blkmap.h b/include/blkmap.h
index d53095437fa..754d8671b01 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -60,10 +60,12 @@ int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
  * @blknr: Start block number of the mapping
  * @blkcnt: Number of blocks to map
  * @paddr: The target physical memory address of the mapping
+ * @preserve: Mapping intended to be preserved for subsequent stages,
+ *		like the OS (e.g. ISO installer)
  * Returns: 0 on success, negative error code on failure
  */
 int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
-		    phys_addr_t paddr);
+		    phys_addr_t paddr, bool preserve);
 
 /**
  * blkmap_from_label() - Find blkmap from label
-- 
2.34.1

