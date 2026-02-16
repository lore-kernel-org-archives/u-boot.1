Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB76E83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DBB83CD3;
	Mon, 16 Feb 2026 22:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDCA83AA9; Mon, 16 Feb 2026 22:21:59 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3B483B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs62C-000000002cS-3u9J; Mon, 16 Feb 2026 21:21:37 +0000
Date: Mon, 16 Feb 2026 21:21:33 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 02/20] boot: image-loader: add block device backend
Message-ID: <9b0880ae234d8244f032eac6cee32a1031de26a3.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:22:55 +0100
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

Add a block device storage backend for the image_loader framework.

image_loader_init_blk() takes a device and partition specification
string, resolves the partition, and installs a .read() callback that
translates byte-offset reads into blk_dread() calls with proper
sector alignment.

Partitions can be identified by number or by name, following the
syntax of part_get_info_by_dev_and_name_or_num():
  "0:4"        partition 4 on device 0
  "0#kernel"   partition named "kernel" on device 0

This is important for systems where partition numbers are not stable
across firmware updates.

Sub-sector reads (offset or size not aligned to blk_desc->blksz) use
a single-sector bounce buffer to avoid overreading into adjacent RAM.

The .cleanup callback frees the allocated private context.

Gated by CONFIG_IMAGE_LOADER_BLK (depends on BLK && PARTITIONS &&
IMAGE_LOADER).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig            |   8 +++
 boot/Makefile           |   1 +
 boot/image-loader-blk.c | 133 ++++++++++++++++++++++++++++++++++++++++
 include/image-loader.h  |  20 ++++++
 4 files changed, 162 insertions(+)
 create mode 100644 boot/image-loader-blk.c

diff --git a/boot/Kconfig b/boot/Kconfig
index f6908e04a51..e94b52288a3 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1187,6 +1187,14 @@ config IMAGE_LOADER_MAX_REGIONS
 	  images (FDT structure + kernel + device tree + ramdisk +
 	  a few loadable sub-images).
 
+config IMAGE_LOADER_BLK
+	bool "Block device backend for image loader"
+	depends on IMAGE_LOADER && BLK && PARTITIONS
+	help
+	  Allows loading images from block device partitions (MMC, SATA,
+	  USB, etc.) using the image_loader framework. Partitions can
+	  be identified by number or name.
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index 1dbc285dad8..ac006bbaa82 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 
 obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
+obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
diff --git a/boot/image-loader-blk.c b/boot/image-loader-blk.c
new file mode 100644
index 00000000000..3f9a309a60c
--- /dev/null
+++ b/boot/image-loader-blk.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Block device backend for image_loader
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <blk.h>
+#include <image-loader.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <log.h>
+
+struct image_loader_blk_priv {
+	struct blk_desc *desc;
+	lbaint_t part_start;
+	lbaint_t part_size;
+};
+
+/**
+ * blk_read_partial() - Read a partial sector via bounce buffer
+ *
+ * Reads one full sector into a stack-allocated bounce buffer, then
+ * copies @len bytes starting at byte offset @skip within that sector
+ * into @dst.
+ *
+ * @desc:	Block device descriptor
+ * @lba:	Absolute LBA of the sector to read
+ * @skip:	Byte offset within the sector
+ * @len:	Number of bytes to copy
+ * @dst:	Destination buffer
+ * Return: 0 on success, -EIO on read failure
+ */
+static int blk_read_partial(struct blk_desc *desc, lbaint_t lba,
+			    ulong skip, ulong len, void *dst)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, sec, desc->blksz);
+
+	if (blk_dread(desc, lba, 1, sec) != 1)
+		return -EIO;
+
+	memcpy(dst, sec + skip, len);
+
+	return 0;
+}
+
+static int image_loader_blk_read(struct image_loader *ldr, ulong src,
+				 ulong size, void *dst)
+{
+	struct image_loader_blk_priv *priv = ldr->priv;
+	struct blk_desc *desc = priv->desc;
+	unsigned long blksz = desc->blksz;
+	lbaint_t lba = priv->part_start + src / blksz;
+	ulong head = src % blksz;
+	u8 *out = dst;
+	lbaint_t n;
+	int ret;
+
+	/* Bounds check */
+	if (src + size > (ulong)priv->part_size * blksz) {
+		log_err("image_loader_blk: read at 0x%lx+0x%lx exceeds partition size\n",
+			src, size);
+		return -EINVAL;
+	}
+
+	/* Handle unaligned head */
+	if (head) {
+		ulong chunk = min(size, blksz - head);
+
+		ret = blk_read_partial(desc, lba, head, chunk, out);
+		if (ret)
+			return ret;
+
+		out += chunk;
+		size -= chunk;
+		lba++;
+	}
+
+	/* Aligned middle — read whole sectors directly into dst */
+	if (size >= blksz) {
+		n = size / blksz;
+
+		if (blk_dread(desc, lba, n, out) != n)
+			return -EIO;
+
+		out += n * blksz;
+		size -= n * blksz;
+		lba += n;
+	}
+
+	/* Handle unaligned tail */
+	if (size) {
+		ret = blk_read_partial(desc, lba, 0, size, out);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void image_loader_blk_cleanup(struct image_loader *ldr)
+{
+	free(ldr->priv);
+}
+
+int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
+			  const char *dev_part_str)
+{
+	struct image_loader_blk_priv *priv;
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int ret;
+
+	ret = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str,
+						   &desc, &info, 0);
+	if (ret < 0)
+		return ret;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+
+	priv->desc = desc;
+	priv->part_start = info.start;
+	priv->part_size = info.size;
+
+	ldr->read = image_loader_blk_read;
+	ldr->cleanup = image_loader_blk_cleanup;
+	ldr->priv = priv;
+
+	return 0;
+}
diff --git a/include/image-loader.h b/include/image-loader.h
index e273b1ca50f..1a9048ba482 100644
--- a/include/image-loader.h
+++ b/include/image-loader.h
@@ -138,4 +138,24 @@ void *image_loader_map(struct image_loader *ldr, ulong img_offset,
 void *image_loader_map_to(struct image_loader *ldr, ulong img_offset,
 			  ulong size, void *dst);
 
+/**
+ * image_loader_init_blk() - Initialise loader for a block device partition
+ *
+ * Resolves the partition using @ifname and @dev_part_str, then installs
+ * a .read() callback that translates byte-offset reads into blk_dread()
+ * calls. The dev_part_str accepts the same formats as
+ * part_get_info_by_dev_and_name_or_num():
+ *
+ *   "0:4"        partition 4 on device 0
+ *   "0#kernel"   partition named "kernel" on device 0
+ *   "0:1"        partition 1 on device 0
+ *
+ * @ldr:		The image loader to initialise
+ * @ifname:		Block interface name (e.g. "mmc", "scsi")
+ * @dev_part_str:	Device and partition specification
+ * Return: 0 on success, negative errno on failure
+ */
+int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
+			  const char *dev_part_str);
+
 #endif /* __IMAGE_LOADER_H */
-- 
2.53.0
