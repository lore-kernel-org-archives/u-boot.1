Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8810C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1B72405AE;
	Sun, 23 Aug 2026 19:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zN9bMUpnehJs; Sun, 23 Aug 2026 19:14:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512455;
	bh=rbarOo1BRM/EFDevL7IKLFqnVv037bmZxbIuFdY6gUs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lsgcjR4sFUlVLu2dwk2SBatCpY0W1i3t43c/UHqawzPlxC4pqIAtWIyu7lIDjL/2j
	 nvUh1oQwVb8X6fE8BrZkD4L82IQWOusUq294nGtQXJMK/seQH7kaNGpXSqoF9+ITXR
	 RuDGjffYafoj47ALzptl4whk7eDEHEi3m33D8d1uE3yC+3wz8eMr7wDMrZgleMEnMv
	 PLY4xwjDa6NjCDR50iSFa4kxek2ZX/G2V7LYvmwAnYQRJOQ5qnjixaWk/lemrMoF6F
	 A7Dwg7rd8eHMiiJoHGe5Hn3cLn1VcMMNHQBUhhT0UZ1GkKd3/DY/WOnP/00txVk1o8
	 T6nYU3rvTz2Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C9BB40575;
	Sun, 23 Aug 2026 19:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1499A336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03B6240059
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uo3OfyLqSxHl for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:14:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50C3440057
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:14:11 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDdm-000000001mo-2TMX; Sun, 23 Aug 2026 19:13:58 +0000
Date: Sun, 23 Aug 2026 20:13:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 5/9] boot: add imagemap on-demand loading from storage
Message-ID: <0d1a6ae2867fddcefe2c224ed47af14fc41abd2e.1787272661.git.daniel@makrotopia.org>
References: <cover.1787272661.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1787272661.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Introduce imagemap, a small layer that reads image data from a storage
device on demand and keeps a translation table of the byte ranges
already loaded into RAM, instead of copying the whole image up front.

An imagemap device (UCLASS_IMAGEMAP) is created over a partition of a
block device with imagemap_create(); imagemap_map() then returns a RAM
pointer for any byte range, reading it in on first access and reusing
it on later accesses -- so a header probe, verification and the final
load of the same range share a single read. Block devices cover more
than raw disks: an MTD partition is reached through mtdblock and a UBI
volume through ubiblock, each exposed as a named block-device
partition, so imagemap needs no storage-specific code of its own.

The read path is built on the SPL struct spl_load_info abstraction and
a new spl_load_region() helper (added to spl.h): the block reader
reports the device block length and spl_load_region() performs the
native sector alignment. imagemap_map_to() keeps a payload byte-exact
at a caller's load address, reading the aligned middle straight to the
destination and bouncing only the partial head/tail block.

Regions that are not placed at a caller-supplied address are allocated
through the LMB allocator and released on cleanup; the translation
table doubles as the registry of those allocations. imagemap is gated
to the full-U-Boot phase, so SPL and TPL carry no new cost.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS            |   7 +
 boot/Kconfig           |  16 ++
 boot/Makefile          |   2 +
 boot/imagemap.c        | 451 +++++++++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h |   1 +
 include/imagemap.h     | 136 +++++++++++++
 include/spl.h          |  47 ++++-
 7 files changed, 657 insertions(+), 3 deletions(-)
 create mode 100644 boot/imagemap.c
 create mode 100644 include/imagemap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index acaba95ed03..48ee01e033d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1186,6 +1186,13 @@ S:	Maintained
 F:	drivers/timer/goldfish_timer.c
 F:	include/goldfish_timer.h
 
+IMAGEMAP
+M:	Daniel Golle <daniel@makrotopia.org>
+L:	openwrt-devel@lists.openwrt.org
+S:	Maintained
+F:	boot/imagemap.c
+F:	include/imagemap.h
+
 INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba493..0d060aa25e4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1205,6 +1205,22 @@ config SYS_BOOT_RAMDISK_HIGH
 
 endmenu		# Boot images
 
+config IMAGEMAP
+	bool "On-demand image loading from storage"
+	depends on DM && LMB && BLK && PARTITIONS
+	help
+	  Read image data from a storage device on demand instead of
+	  copying the whole image into RAM first. A translation table maps
+	  already-loaded byte ranges to their RAM addresses to avoid
+	  redundant reads, and scratch allocations are managed through the
+	  LMB allocator.
+
+	  Images are read from a partition on a block device, identified by
+	  number or name. MTD partitions (via mtdblock) and UBI volumes
+	  (via ubiblock) are reached as block-device partitions too. Used
+	  by bootm when a storage device is specified instead of a RAM
+	  address.
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..b4200ebab3d 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -73,6 +73,8 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 
+obj-$(CONFIG_$(PHASE_)IMAGEMAP) += imagemap.o
+
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_OS) += vbe_abrec_os.o
diff --git a/boot/imagemap.c b/boot/imagemap.c
new file mode 100644
index 00000000000..4bdfa6109f8
--- /dev/null
+++ b/boot/imagemap.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * On-demand image loading from storage (UCLASS_IMAGEMAP)
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#define LOG_CATEGORY UCLASS_IMAGEMAP
+
+#include <blk.h>
+#include <dm.h>
+#include <imagemap.h>
+#include <lmb.h>
+#include <mapmem.h>
+#include <memalign.h>
+#include <part.h>
+#include <spl.h>
+#include <asm/cache.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <log.h>
+
+/**
+ * struct imagemap_plat - Platform data set before probe
+ *
+ * @part_start:	Partition start LBA
+ * @part_size:	Partition size in blocks
+ * @hwpart:	Hardware partition to select before each read
+ */
+struct imagemap_plat {
+	lbaint_t part_start;
+	lbaint_t part_size;
+	int hwpart;
+};
+
+/**
+ * struct imagemap_blk - Runtime block-read state (the spl_load_info priv)
+ *
+ * @desc:	Block device descriptor
+ * @part_start:	Partition start LBA
+ * @part_size:	Partition size in blocks
+ * @hwpart:	Hardware partition to (re-)select before each read.  For a UBI
+ *		block device this selects the UBI volume (encoded in
+ *		blk_desc->hwpart by the "ubi" partition driver); for normal
+ *		media it is the hardware partition (0 for the user area).
+ */
+struct imagemap_blk {
+	struct blk_desc *desc;
+	lbaint_t part_start;
+	lbaint_t part_size;
+	int hwpart;
+};
+
+void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
+{
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+	const struct imagemap_region *r;
+
+	alist_for_each(r, &priv->regions) {
+		/*
+		 * Check whether [img_offset, img_offset + size) is fully
+		 * contained within [r->img_offset, r->img_offset + r->size).
+		 *
+		 * The three conditions are ordered to avoid unsigned
+		 * underflow in the subtraction on the third line:
+		 *
+		 *  1) img_offset >= r->img_offset
+		 *     The requested start is at or past the region start.
+		 *
+		 *  2) img_offset - r->img_offset <= r->size
+		 *     The offset into the region does not exceed the
+		 *     region size.  This guard is essential: without it,
+		 *     the subtraction in (3) wraps to a huge value on
+		 *     LP64 where ulong and loff_t have the same rank
+		 *     and the arithmetic is performed as unsigned.
+		 *
+		 *  3) size <= r->size - (img_offset - r->img_offset)
+		 *     The requested range fits in the remaining space.
+		 *     Safe because (2) guarantees the subtraction does
+		 *     not underflow.
+		 */
+		if (img_offset >= r->img_offset &&
+		    img_offset - r->img_offset <= r->size &&
+		    size <= r->size - (img_offset - r->img_offset))
+			return (char *)r->ram + (img_offset - r->img_offset);
+	}
+
+	return NULL;
+}
+
+/**
+ * imagemap_record() - Record a region in the translation table
+ *
+ * If an entry with the same img_offset already exists and the new size
+ * is larger, update the existing entry. Otherwise add a new entry.
+ *
+ * @dev:		The imagemap device
+ * @img_offset:		Byte offset within the source image
+ * @size:		Region size
+ * @ram:		RAM pointer where the region was loaded
+ * @lmb_reserved:	true if this region was allocated via LMB
+ * Return: pointer to the region entry, or NULL if the table is full
+ */
+static struct imagemap_region *
+imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
+		void *ram, bool lmb_reserved)
+{
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+	struct imagemap_region *r;
+	struct imagemap_region entry;
+
+	/* Check for an existing entry at the same base that we can extend */
+	alist_for_each(r, &priv->regions) {
+		if (r->img_offset == img_offset) {
+			r->size = size;
+			r->ram = ram;
+			r->lmb_reserved = lmb_reserved;
+			return r;
+		}
+	}
+
+	/* Append new region */
+	entry.img_offset = img_offset;
+	entry.size = size;
+	entry.ram = ram;
+	entry.lmb_reserved = lmb_reserved;
+
+	r = alist_add(&priv->regions, entry);
+	if (!r) {
+		log_err("imagemap: cannot add region (out of memory)\n");
+		return NULL;
+	}
+
+	return r;
+}
+
+/**
+ * imagemap_read_exact() - Read [off, off+size) byte-exact into @dst
+ *
+ * For byte-addressed sources (bl_len == 1) this is a straight
+ * spl_load_region().  For block sources it reads the fully-contained
+ * middle blocks straight into @dst (zero-copy) and bounces only the
+ * partial head/tail block, so the wanted bytes land exactly at @dst
+ * without over-reading the destination buffer.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int imagemap_read_exact(struct spl_load_info *info, loff_t off,
+			       ulong size, void *dst)
+{
+	ulong bl_len = spl_get_bl_len(info);
+	ulong overhead = off & (bl_len - 1);
+	u8 *out = dst;
+	loff_t cur = off;
+	ulong left = size;
+
+	if (bl_len == 1)
+		return spl_load_region(info, off, size, dst) < 0 ? -EIO : 0;
+
+	/* Partial head block: bounce and copy the wanted tail of the block */
+	if (overhead) {
+		ALLOC_CACHE_ALIGN_BUFFER(u8, blk, bl_len);
+		ulong chunk = min(left, bl_len - overhead);
+
+		if (info->read(info, cur - overhead, bl_len, blk) < bl_len)
+			return -EIO;
+		memcpy(out, blk + overhead, chunk);
+		out += chunk;
+		cur += chunk;
+		left -= chunk;
+	}
+
+	/* Aligned middle: whole blocks straight into @dst (zero-copy) */
+	if (left >= bl_len) {
+		ulong nbytes = left & ~(bl_len - 1);
+
+		if (info->read(info, cur, nbytes, out) < nbytes)
+			return -EIO;
+		out += nbytes;
+		cur += nbytes;
+		left -= nbytes;
+	}
+
+	/* Partial tail block: bounce and copy the wanted head of the block */
+	if (left) {
+		ALLOC_CACHE_ALIGN_BUFFER(u8, blk, bl_len);
+
+		if (info->read(info, cur, bl_len, blk) < bl_len)
+			return -EIO;
+		memcpy(out, blk, left);
+	}
+
+	return 0;
+}
+
+void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
+{
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+	ulong bl_len = spl_get_bl_len(&priv->info);
+	ulong overhead = img_offset & (bl_len - 1);
+	loff_t base_off = img_offset - overhead;
+	ulong read_size = ALIGN(size + overhead, bl_len);
+	phys_addr_t addr;
+	phys_size_t alloc_size;
+	void *base;
+	int ret;
+	struct imagemap_region *r;
+	void *p;
+
+	/* Return existing mapping if the range is already covered */
+	p = imagemap_lookup(dev, img_offset, size);
+	if (p)
+		return p;
+
+	alloc_size = ALIGN(read_size, ARCH_DMA_MINALIGN);
+
+	/*
+	 * Extend a block-aligned region at the same base offset to the
+	 * larger size, re-reading the full range from storage.
+	 */
+	alist_for_each(r, &priv->regions) {
+		if (r->img_offset == base_off && r->size < read_size) {
+			addr = map_to_sysmem(r->ram);
+
+			/* Free old LMB reservation if we own it */
+			if (r->lmb_reserved)
+				lmb_free(addr,
+					 ALIGN(r->size, ARCH_DMA_MINALIGN),
+					 LMB_NONE);
+
+			/* Try to re-reserve at the same address with new size */
+			if (lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
+					  alloc_size, LMB_NONE)) {
+				/* In-place extend failed, allocate elsewhere */
+				if (lmb_alloc_mem(LMB_MEM_ALLOC_ANY,
+						  ARCH_DMA_MINALIGN,
+						  &addr, alloc_size,
+						  LMB_NONE)) {
+					log_err("imagemap: LMB alloc failed (0x%lx bytes)\n",
+						(ulong)alloc_size);
+					return ERR_PTR(-ENOMEM);
+				}
+			}
+			base = map_sysmem(addr, alloc_size);
+
+			ret = spl_load_region(&priv->info, img_offset, size,
+					      base);
+			if (ret < 0) {
+				log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
+					(unsigned long long)img_offset, size, ret);
+				lmb_free(addr, alloc_size, LMB_NONE);
+				return ERR_PTR(ret);
+			}
+			r->size = read_size;
+			r->ram = base;
+			r->lmb_reserved = true;
+
+			return base + overhead;
+		}
+	}
+
+	/* New region — allocate from LMB */
+	if (lmb_alloc_mem(LMB_MEM_ALLOC_ANY, ARCH_DMA_MINALIGN,
+			  &addr, alloc_size, LMB_NONE)) {
+		log_err("imagemap: LMB alloc failed (0x%lx bytes)\n",
+			(ulong)alloc_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	base = map_sysmem(addr, alloc_size);
+
+	ret = spl_load_region(&priv->info, img_offset, size, base);
+	if (ret < 0) {
+		log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
+			(unsigned long long)img_offset, size, ret);
+		lmb_free(addr, alloc_size, LMB_NONE);
+		return ERR_PTR(ret);
+	}
+
+	if (!imagemap_record(dev, base_off, read_size, base, true)) {
+		lmb_free(addr, alloc_size, LMB_NONE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return base + overhead;
+}
+
+void *imagemap_map_to(struct udevice *dev, loff_t img_offset,
+		      ulong size, void *dst)
+{
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+	void *p;
+	int ret;
+
+	/* If already mapped to this exact destination, return it */
+	p = imagemap_lookup(dev, img_offset, size);
+	if (p && p == dst)
+		return p;
+
+	ret = imagemap_read_exact(&priv->info, img_offset, size, dst);
+	if (ret) {
+		log_err("imagemap: read failed at offset 0x%llx (size 0x%lx): %d\n",
+			(unsigned long long)img_offset, size, ret);
+		return ERR_PTR(ret);
+	}
+
+	if (!imagemap_record(dev, img_offset, size, dst, false))
+		return ERR_PTR(-ENOMEM);
+
+	return dst;
+}
+
+void imagemap_cleanup(struct udevice *dev)
+{
+	struct imagemap_priv *priv;
+	struct imagemap_region *r;
+
+	if (!dev)
+		return;
+
+	priv = dev_get_uclass_priv(dev);
+
+	alist_for_each(r, &priv->regions) {
+		if (r->lmb_reserved)
+			lmb_free(map_to_sysmem(r->ram),
+				 ALIGN(r->size, ARCH_DMA_MINALIGN),
+				 LMB_NONE);
+	}
+
+	alist_uninit(&priv->regions);
+
+	device_remove(dev, DM_REMOVE_NORMAL);
+	device_unbind(dev);
+}
+
+static int imagemap_post_probe(struct udevice *dev)
+{
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+
+	alist_init_struct(&priv->regions, struct imagemap_region);
+
+	return 0;
+}
+
+UCLASS_DRIVER(imagemap) = {
+	.id		= UCLASS_IMAGEMAP,
+	.name		= "imagemap",
+	.post_probe	= imagemap_post_probe,
+	.per_device_auto	= sizeof(struct imagemap_priv),
+};
+
+/*
+ * Block-addressed reader (bl_len == blksz): @off/@size are byte quantities
+ * pre-aligned to the block length by spl_load_region()/imagemap, so this is
+ * a plain whole-sector transfer.  Returns bytes read, 0 on failure.
+ */
+static ulong imagemap_blk_reader(struct spl_load_info *info, ulong off,
+				 ulong size, void *buf)
+{
+	struct imagemap_blk *bp = info->priv;
+	struct blk_desc *desc = bp->desc;
+	lbaint_t blk_off = off >> desc->log2blksz;
+	lbaint_t count = size >> desc->log2blksz;
+
+	if (blk_off + count > bp->part_size) {
+		log_err("imagemap: read at 0x%lx+0x%lx exceeds partition size\n",
+			off, size);
+		return 0;
+	}
+
+	/*
+	 * Re-select our hardware partition / UBI volume in case another
+	 * blk access changed it since we were created.  ubi_blk provides no
+	 * select_hwpart op, so drive blk_desc->hwpart directly as well.
+	 */
+	if (desc->hwpart != bp->hwpart) {
+		blk_dselect_hwpart(desc, bp->hwpart);
+		desc->hwpart = bp->hwpart;
+	}
+
+	return blk_dread(desc, bp->part_start + blk_off, count, buf)
+	       << desc->log2blksz;
+}
+
+static int imagemap_probe(struct udevice *dev)
+{
+	struct imagemap_plat *plat = dev_get_plat(dev);
+	struct imagemap_blk *bp = dev_get_priv(dev);
+	struct imagemap_priv *priv = dev_get_uclass_priv(dev);
+
+	bp->desc = dev_get_uclass_plat(dev_get_parent(dev));
+	bp->part_start = plat->part_start;
+	bp->part_size = plat->part_size;
+	bp->hwpart = plat->hwpart;
+
+	spl_load_init(&priv->info, imagemap_blk_reader, bp, bp->desc->blksz);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imagemap) = {
+	.name		= "imagemap",
+	.id		= UCLASS_IMAGEMAP,
+	.probe		= imagemap_probe,
+	.plat_auto	= sizeof(struct imagemap_plat),
+	.priv_auto	= sizeof(struct imagemap_blk),
+};
+
+int imagemap_create(struct udevice *dev, const char *name,
+		    int part, struct udevice **devp)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(dev);
+	struct imagemap_plat *plat;
+	struct disk_partition info;
+	struct udevice *imdev;
+	int ret;
+
+	if (name && *name)
+		ret = part_get_info_by_name(desc, name, &info);
+	else
+		ret = part_get_info(desc, part, &info);
+	if (ret < 0)
+		return ret;
+
+	ret = device_bind_driver(desc->bdev, "imagemap",
+				 name && *name ? name : "imagemap", &imdev);
+	if (ret)
+		return ret;
+
+	plat = dev_get_plat(imdev);
+	plat->part_start = info.start;
+	plat->part_size = info.size;
+	/*
+	 * part_get_info_by_name() records the target in blk_desc->hwpart for
+	 * ubi_blk (the UBI volume id); capture it so reads re-select it.
+	 */
+	plat->hwpart = desc->hwpart;
+
+	ret = device_probe(imdev);
+	if (ret) {
+		device_unbind(imdev);
+		return ret;
+	}
+
+	*devp = imdev;
+
+	return 0;
+}
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index fe0aae2720c..7de9312cde7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -75,6 +75,7 @@ enum uclass_id {
 	UCLASS_HASH,		/* Hash device */
 	UCLASS_HWSPINLOCK,	/* Hardware semaphores */
 	UCLASS_HOST,		/* Sandbox host device */
+	UCLASS_IMAGEMAP,	/* On-demand image loading from storage */
 	UCLASS_I2C,		/* I2C bus */
 	UCLASS_I2C_EEPROM,	/* I2C EEPROM device */
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
diff --git a/include/imagemap.h b/include/imagemap.h
new file mode 100644
index 00000000000..984a2fa8934
--- /dev/null
+++ b/include/imagemap.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * On-demand image loading from storage (UCLASS_IMAGEMAP)
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#ifndef __IMAGEMAP_H
+#define __IMAGEMAP_H
+
+#include <alist.h>
+#include <spl.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct udevice;
+
+/**
+ * struct imagemap_region - One mapped region of the image
+ *
+ * Records the fact that image bytes [img_offset, img_offset + size)
+ * have been loaded into RAM at address @ram.
+ *
+ * @img_offset:	Start offset within the source image (bytes)
+ * @size:	Region size (bytes)
+ * @ram:	RAM pointer where this region was loaded
+ * @lmb_reserved: true if this region was allocated via LMB and should
+ *		be freed on cleanup
+ */
+struct imagemap_region {
+	loff_t img_offset;
+	ulong size;
+	void *ram;
+	bool lmb_reserved;
+};
+
+/**
+ * struct imagemap_priv - Per-device uclass data for imagemap
+ *
+ * Managed by the UCLASS_IMAGEMAP uclass via per_device_auto.
+ *
+ * @info:	Shared load-to-mem abstraction (the same one SPL uses); the
+ *		device's probe points its spl_load_reader at the storage,
+ *		and all reads go through spl_load_region().
+ * @regions:	Translation table of already-loaded regions, used both as
+ *		the reuse cache and as the LMB allocation registry (freed on
+ *		cleanup).
+ */
+struct imagemap_priv {
+	struct spl_load_info info;
+	struct alist regions;
+};
+
+/**
+ * imagemap_lookup() - Look up an already-mapped region
+ *
+ * Checks the translation table to see if the requested range
+ * [img_offset, img_offset + size) is fully contained within a
+ * previously loaded region.
+ *
+ * @dev:	The imagemap device
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes needed
+ * Return: RAM pointer on hit, NULL on miss (does not trigger a read)
+ */
+void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size);
+
+/**
+ * imagemap_map() - Ensure an image region is accessible in RAM
+ *
+ * If the region is already in the translation table, returns the
+ * existing RAM pointer. Otherwise allocates RAM via the LMB allocator,
+ * reads the data from storage, records the mapping, and returns the
+ * new pointer.
+ *
+ * If the requested range starts at the same offset as an existing
+ * region but is larger, the existing region is extended (LMB
+ * reservation adjusted, data re-read).
+ *
+ * @dev:	The imagemap device
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes needed
+ * Return: RAM pointer on success, ERR_PTR on failure
+ */
+void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size);
+
+/**
+ * imagemap_map_to() - Load an image region to a specific RAM address
+ *
+ * Like imagemap_map() but reads into a caller-specified address
+ * instead of allocating from the scratch area. Used when the sub-image
+ * has a known load address for a zero-copy path.
+ *
+ * @dev:	The imagemap device
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes to load
+ * @dst:	Destination address in RAM
+ * Return: @dst on success, ERR_PTR on failure
+ */
+void *imagemap_map_to(struct udevice *dev, loff_t img_offset,
+		      ulong size, void *dst);
+
+/**
+ * imagemap_cleanup() - Release all resources and unbind the device
+ *
+ * Frees all LMB reservations from the translation table, removes the
+ * driver, and unbinds the device. The device pointer is invalid after
+ * this call.
+ *
+ * Safe to call with a NULL @dev pointer.
+ *
+ * @dev:	The imagemap device, or NULL
+ */
+void imagemap_cleanup(struct udevice *dev);
+
+/**
+ * imagemap_create() - Create an imagemap device over a block device
+ *
+ * Resolves a partition on @dev (by name if @name is given, otherwise by
+ * index @part), binds an imagemap device as a child of the block device
+ * and probes it, pointing its reader at that partition.
+ *
+ * MTD partitions and UBI volumes are reached the same way: with
+ * CONFIG_MTD_BLOCK / CONFIG_UBI_BLOCK they are exposed as named
+ * partitions on the mtd_blk / ubi_blk block devices.
+ *
+ * @dev:	Block device (UCLASS_BLK)
+ * @name:	Partition/volume name, or NULL to select by index
+ * @part:	Partition index (used when @name is NULL)
+ * @devp:	On success, the new imagemap device
+ * Return: 0 on success, negative errno on failure
+ */
+int imagemap_create(struct udevice *dev, const char *name,
+		    int part, struct udevice **devp);
+
+#endif /* __IMAGEMAP_H */
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..24df44d23e1 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -350,10 +350,21 @@ typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
  * @phase: Image phase to load
  * @no_fdt_update: true to update the FDT with any loadables that are loaded
  */
+/*
+ * struct spl_load_info carries a device block length for the SPL block
+ * loaders (CONFIG_SPL_LOAD_BLOCK) and, in full U-Boot, for the imagemap
+ * on-demand loader (CONFIG_IMAGEMAP); imagemap is gated out of the xpl
+ * phases so SPL and TPL carry no new cost.
+ */
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK) || \
+	(IS_ENABLED(CONFIG_IMAGEMAP) && !defined(CONFIG_XPL_BUILD))
+#define SPL_LOAD_INFO_HAS_BL_LEN
+#endif
+
 struct spl_load_info {
 	spl_load_reader read;
 	void *priv;
-#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
+#ifdef SPL_LOAD_INFO_HAS_BL_LEN
 	u16 bl_len;
 #endif
 #if CONFIG_IS_ENABLED(BOOTMETH_VBE)
@@ -364,7 +375,7 @@ struct spl_load_info {
 
 static inline int spl_get_bl_len(struct spl_load_info *info)
 {
-#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
+#ifdef SPL_LOAD_INFO_HAS_BL_LEN
 	return info->bl_len;
 #else
 	return 1;
@@ -373,7 +384,7 @@ static inline int spl_get_bl_len(struct spl_load_info *info)
 
 static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 {
-#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
+#ifdef SPL_LOAD_INFO_HAS_BL_LEN
 	info->bl_len = bl_len;
 #else
 	if (bl_len != 1)
@@ -429,6 +440,36 @@ static inline void spl_load_init(struct spl_load_info *load,
 	xpl_set_fdt_update(load, true);
 }
 
+/**
+ * spl_load_region() - Read a block-aligned region into a buffer
+ *
+ * Reads @size bytes starting at @offset from the device described by @info
+ * into @dst, rounding the read down/up to the device block length so that
+ * block media are read on their native boundaries. On byte-addressed media
+ * (bl_len == 1) every alignment folds to identity.
+ *
+ * @info:	information about the device to read from
+ * @offset:	byte offset on the device of the first wanted byte
+ * @size:	number of wanted bytes
+ * @dst:	buffer to read the block-aligned region into
+ * Return:	on success, the number of leading padding bytes in @dst that
+ *		precede the wanted data (0 on byte media); a negative error
+ *		number on failure.
+ */
+static inline long spl_load_region(struct spl_load_info *info, loff_t offset,
+				   ulong size, void *dst)
+{
+	ulong bl_len = spl_get_bl_len(info);
+	ulong overhead = offset & (bl_len - 1);
+	loff_t roff = ALIGN_DOWN(offset, bl_len);
+	ulong rsize = ALIGN(size + overhead, bl_len);
+
+	if (info->read(info, roff, rsize, dst) < rsize)
+		return -EIO;
+
+	return overhead;
+}
+
 /*
  * We need to know the position of U-Boot in memory so we can jump to it. We
  * allow any U-Boot binary to be used (u-boot.bin, u-boot-nodtb.bin,
-- 
2.55.0
