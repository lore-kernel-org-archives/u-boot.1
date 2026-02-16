Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58648E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD8E83C72;
	Mon, 16 Feb 2026 22:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE3883C6C; Mon, 16 Feb 2026 22:21:58 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58A28063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs624-000000002bn-3GXG; Mon, 16 Feb 2026 21:21:28 +0000
Date: Mon, 16 Feb 2026 21:21:25 +0000
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
Subject: [RFC PATCH 01/20] boot: add image_loader on-demand loading abstraction
Message-ID: <3cb8b55fd4f96dc612b6a3453acecc0d37ca24a5.1771275704.git.daniel@makrotopia.org>
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

Introduce struct image_loader, a small generic layer that lets callers
read arbitrary byte ranges from a storage device and keeps a translation
table of the regions that have already been loaded into RAM.

The API consists of four functions:

  image_loader_lookup()   - check whether a range is already mapped
  image_loader_map()      - return a mapped pointer, reading on demand
  image_loader_map_to()   - read into a caller-supplied address
  image_loader_cleanup()  - release all backend resources

A read-callback (image_loader_read_fn) plus an opaque *priv pointer
abstract the actual I/O so that block, MTD, and UBI back-ends can be
added in follow-up patches without touching the core.

Each backend provides a .cleanup callback which is invoked by
image_loader_cleanup() to release held device references and free
allocated memory. This ensures safe resource teardown between
consecutive boot attempts.

The translation table (struct image_loader_region[]) avoids redundant
reads when the same region is requested more than once, and allows
extending an existing mapping when a larger size is needed at the same
offset. The table size is controlled by CONFIG_IMAGE_LOADER_MAX_REGIONS
(default 16).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig           |  20 +++++
 boot/Makefile          |   2 +
 boot/image-loader.c    | 163 +++++++++++++++++++++++++++++++++++++++++
 include/image-loader.h | 141 +++++++++++++++++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 boot/image-loader.c
 create mode 100644 include/image-loader.h

diff --git a/boot/Kconfig b/boot/Kconfig
index e5db165424a..f6908e04a51 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1167,6 +1167,26 @@ config SYS_BOOT_RAMDISK_HIGH
 
 endmenu		# Boot images
 
+config IMAGE_LOADER
+	bool "On-demand image loading from storage"
+	help
+	  Provides a generic abstraction for reading image data from
+	  storage on demand. A translation table maps already-loaded
+	  regions to their RAM addresses, avoiding redundant reads.
+
+	  Used by bootm when a storage device is specified instead of a
+	  RAM address.
+
+config IMAGE_LOADER_MAX_REGIONS
+	int "Maximum number of mapped regions in image loader"
+	default 16 if IMAGE_LOADER
+	default 0
+	help
+	  Maximum number of distinct image regions that can be mapped
+	  into RAM simultaneously. 16 is sufficient for typical FIT
+	  images (FDT structure + kernel + device tree + ramdisk +
+	  a few loadable sub-images).
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..1dbc285dad8 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -73,6 +73,8 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 
+obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
+
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_OS) += vbe_abrec_os.o
diff --git a/boot/image-loader.c b/boot/image-loader.c
new file mode 100644
index 00000000000..77f5b8c69a1
--- /dev/null
+++ b/boot/image-loader.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * On-demand image loading from storage
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <image-loader.h>
+#include <mapmem.h>
+#include <asm/cache.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <log.h>
+
+void *image_loader_lookup(struct image_loader *ldr, ulong img_offset,
+			  ulong size)
+{
+	int i;
+
+	for (i = 0; i < ldr->nr_regions; i++) {
+		struct image_loader_region *r = &ldr->regions[i];
+
+		if (img_offset >= r->img_offset &&
+		    img_offset + size <= r->img_offset + r->size)
+			return (char *)r->ram + (img_offset - r->img_offset);
+	}
+
+	return NULL;
+}
+
+void image_loader_cleanup(struct image_loader *ldr)
+{
+	if (ldr->cleanup)
+		ldr->cleanup(ldr);
+
+	ldr->read = NULL;
+	ldr->cleanup = NULL;
+	ldr->priv = NULL;
+	ldr->nr_regions = 0;
+}
+
+/**
+ * image_loader_record() - Record a region in the translation table
+ *
+ * If an entry with the same img_offset already exists and the new size
+ * is larger, update the existing entry. Otherwise add a new entry.
+ *
+ * @ldr:	The image loader
+ * @img_offset:	Byte offset within the source image
+ * @size:	Region size
+ * @ram:	RAM pointer where the region was loaded
+ * Return: pointer to the region entry, or NULL if the table is full
+ */
+static struct image_loader_region *
+image_loader_record(struct image_loader *ldr, ulong img_offset, ulong size,
+		    void *ram)
+{
+	struct image_loader_region *r;
+	int i;
+
+	/* Check for an existing entry at the same base that we can extend */
+	for (i = 0; i < ldr->nr_regions; i++) {
+		r = &ldr->regions[i];
+		if (r->img_offset == img_offset) {
+			r->size = size;
+			r->ram = ram;
+			return r;
+		}
+	}
+
+	if (ldr->nr_regions >= CONFIG_IMAGE_LOADER_MAX_REGIONS) {
+		log_err("image_loader: translation table full (%d regions)\n",
+			ldr->nr_regions);
+		return NULL;
+	}
+
+	r = &ldr->regions[ldr->nr_regions++];
+	r->img_offset = img_offset;
+	r->size = size;
+	r->ram = ram;
+
+	return r;
+}
+
+void *image_loader_map(struct image_loader *ldr, ulong img_offset, ulong size)
+{
+	struct image_loader_region *r;
+	void *p;
+	int ret;
+
+	/* Return existing mapping if the range is already covered */
+	p = image_loader_lookup(ldr, img_offset, size);
+	if (p)
+		return p;
+
+	/*
+	 * Check if we have an entry at the same base offset but smaller.
+	 * If so, re-read the full range to the same RAM address.
+	 */
+	for (int i = 0; i < ldr->nr_regions; i++) {
+		r = &ldr->regions[i];
+		if (r->img_offset == img_offset && r->size < size) {
+			ulong region_end;
+
+			ret = ldr->read(ldr, img_offset, size, r->ram);
+			if (ret) {
+				log_err("image_loader: read failed at offset 0x%lx (size 0x%lx): %d\n",
+					img_offset, size, ret);
+				return NULL;
+			}
+			r->size = size;
+
+			/* Keep alloc_ptr past the extended region */
+			region_end = ALIGN(map_to_sysmem(r->ram) + size,
+					   ARCH_DMA_MINALIGN);
+			if (region_end > ldr->alloc_ptr)
+				ldr->alloc_ptr = region_end;
+
+			return r->ram;
+		}
+	}
+
+	/* New region — allocate from scratch area */
+	p = map_sysmem(ldr->alloc_ptr, size);
+
+	ret = ldr->read(ldr, img_offset, size, p);
+	if (ret) {
+		log_err("image_loader: read failed at offset 0x%lx (size 0x%lx): %d\n",
+			img_offset, size, ret);
+		return NULL;
+	}
+
+	if (!image_loader_record(ldr, img_offset, size, p))
+		return NULL;
+
+	ldr->alloc_ptr = ALIGN(ldr->alloc_ptr + size, ARCH_DMA_MINALIGN);
+
+	return p;
+}
+
+void *image_loader_map_to(struct image_loader *ldr, ulong img_offset,
+			  ulong size, void *dst)
+{
+	int ret;
+
+	/* If already mapped to this exact destination, return it */
+	void *p = image_loader_lookup(ldr, img_offset, size);
+
+	if (p && p == dst)
+		return p;
+
+	ret = ldr->read(ldr, img_offset, size, dst);
+	if (ret) {
+		log_err("image_loader: read failed at offset 0x%lx (size 0x%lx): %d\n",
+			img_offset, size, ret);
+		return NULL;
+	}
+
+	if (!image_loader_record(ldr, img_offset, size, dst))
+		return NULL;
+
+	return dst;
+}
diff --git a/include/image-loader.h b/include/image-loader.h
new file mode 100644
index 00000000000..e273b1ca50f
--- /dev/null
+++ b/include/image-loader.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * On-demand image loading from storage
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#ifndef __IMAGE_LOADER_H
+#define __IMAGE_LOADER_H
+
+#include <linux/types.h>
+
+/**
+ * struct image_loader_region - One mapped region of the image
+ *
+ * Records the fact that image bytes [img_offset, img_offset + size)
+ * have been loaded into RAM at address @ram.
+ *
+ * @img_offset:	Start offset within the source image (bytes)
+ * @size:	Region size (bytes)
+ * @ram:	RAM pointer where this region was loaded
+ */
+struct image_loader_region {
+	ulong img_offset;
+	ulong size;
+	void *ram;
+};
+
+struct image_loader;
+
+/**
+ * image_loader_read_fn - Read data from a storage device
+ *
+ * @ldr:	The image loader instance
+ * @src:	Byte offset within the source image
+ * @size:	Number of bytes to read
+ * @dst:	Destination buffer in RAM
+ * Return: 0 on success, negative errno on failure
+ */
+typedef int (*image_loader_read_fn)(struct image_loader *ldr, ulong src,
+				    ulong size, void *dst);
+
+/**
+ * image_loader_cleanup_fn - Release backend resources
+ *
+ * Called by image_loader_cleanup() to free any backend-specific state
+ * such as allocated priv structs or held device references.
+ *
+ * @ldr:	The image loader instance
+ */
+typedef void (*image_loader_cleanup_fn)(struct image_loader *ldr);
+
+/**
+ * struct image_loader - On-demand image loading from storage
+ *
+ * Provides a generic abstraction for reading image data from a storage
+ * device on demand. A translation table maps regions of the source
+ * image that have already been loaded to their RAM addresses, avoiding
+ * redundant reads.
+ *
+ * @read:	Backend read callback
+ * @cleanup:	Optional backend cleanup callback
+ * @priv:	Opaque backend-specific context
+ * @regions:	Translation table of loaded regions
+ * @nr_regions:	Number of entries currently used in @regions
+ * @alloc_ptr:	Next free RAM address for scratch allocations
+ */
+struct image_loader {
+	image_loader_read_fn read;
+	image_loader_cleanup_fn cleanup;
+	void *priv;
+	struct image_loader_region regions[CONFIG_IMAGE_LOADER_MAX_REGIONS];
+	int nr_regions;
+	ulong alloc_ptr;
+};
+
+/**
+ * image_loader_lookup() - Look up an already-mapped region
+ *
+ * Checks the translation table to see if the requested range
+ * [img_offset, img_offset + size) is fully contained within a
+ * previously loaded region.
+ *
+ * @ldr:	The image loader
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes needed
+ * Return: RAM pointer on hit, NULL on miss (does not trigger a read)
+ */
+void *image_loader_lookup(struct image_loader *ldr, ulong img_offset,
+			  ulong size);
+
+/**
+ * image_loader_cleanup() - Release all backend resources
+ *
+ * Calls the backend cleanup callback (if set) and resets the loader
+ * state so it can be safely re-initialised or discarded. Should be
+ * called when the boot attempt is finished, whether it succeeded or
+ * not.
+ *
+ * @ldr:	The image loader to clean up
+ */
+void image_loader_cleanup(struct image_loader *ldr);
+
+/**
+ * image_loader_map() - Ensure an image region is accessible in RAM
+ *
+ * If the region is already in the translation table, returns the
+ * existing RAM pointer. Otherwise allocates RAM at @ldr->alloc_ptr,
+ * reads the data from storage, records the mapping, advances the
+ * allocation pointer (aligned to ARCH_DMA_MINALIGN), and returns the
+ * new pointer.
+ *
+ * If the requested range starts at the same offset as an existing
+ * region but is larger, the existing region is extended in place
+ * (re-read to the same RAM base, size updated).
+ *
+ * @ldr:	The image loader
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes needed
+ * Return: RAM pointer on success, NULL on failure
+ */
+void *image_loader_map(struct image_loader *ldr, ulong img_offset,
+		       ulong size);
+
+/**
+ * image_loader_map_to() - Load an image region to a specific RAM address
+ *
+ * Like image_loader_map() but reads into a caller-specified address
+ * instead of allocating from the scratch area. Used when the sub-image
+ * has a known load address for a zero-copy path.
+ *
+ * @ldr:	The image loader
+ * @img_offset:	Byte offset within the source image
+ * @size:	Number of bytes to load
+ * @dst:	Destination address in RAM
+ * Return: @dst on success, NULL on failure
+ */
+void *image_loader_map_to(struct image_loader *ldr, ulong img_offset,
+			  ulong size, void *dst);
+
+#endif /* __IMAGE_LOADER_H */
-- 
2.53.0
