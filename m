Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A1E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B4883E70;
	Mon, 16 Feb 2026 22:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EA583D3D; Mon, 16 Feb 2026 22:23:31 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385CA83E60
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs63k-000000002lq-3lOo; Mon, 16 Feb 2026 21:23:13 +0000
Date: Mon, 16 Feb 2026 21:23:09 +0000
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
Subject: [RFC PATCH 12/20] doc: bootm: document direct storage boot
Message-ID: <afd86ec997b452bfe8fd03fb6d090f666244f6be.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:23:42 +0100
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

Add user and developer documentation for the bootm storage loading
feature.

doc/usage/fit/storage-boot.rst:
  User-facing documentation with syntax reference, examples for MMC,
  MTD, and UBI, description of how the on-demand loading works, how
  filesystem sub-images are skipped, and the relevant Kconfig options.

doc/develop/bootm-storage.rst:
  Developer documentation covering the image_loader architecture,
  translation table design, API reference (map, map_to, lookup,
  cleanup), storage backend interface with step-by-step guide for
  adding new backends, FIT integration points in boot_get_kernel()
  and fit_image_load(), and testing instructions.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 doc/develop/bootm-storage.rst  | 210 +++++++++++++++++++++++++++++++++
 doc/develop/index.rst          |   1 +
 doc/usage/fit/index.rst        |   1 +
 doc/usage/fit/storage-boot.rst | 201 +++++++++++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 doc/develop/bootm-storage.rst
 create mode 100644 doc/usage/fit/storage-boot.rst

diff --git a/doc/develop/bootm-storage.rst b/doc/develop/bootm-storage.rst
new file mode 100644
index 00000000000..d779049388a
--- /dev/null
+++ b/doc/develop/bootm-storage.rst
@@ -0,0 +1,210 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+On-Demand Image Loading from Storage
+=====================================
+
+This document describes the ``image_loader`` framework that enables
+``bootm`` to load FIT images directly from storage devices without first
+copying the entire image into RAM.
+
+Architecture Overview
+---------------------
+
+The framework is built around ``struct image_loader``
+(``include/image-loader.h``), which provides:
+
+``read(ldr, src, size, dst)``
+    Backend callback that reads ``size`` bytes starting at byte offset
+    ``src`` within the source image into the RAM buffer at ``dst``.
+
+``cleanup(ldr)``
+    Optional callback to release device references, free private state,
+    etc. Called at the end of the boot attempt.
+
+``priv``
+    Opaque pointer to backend-specific context (block device descriptor,
+    MTD device, UBI volume info, etc.).
+
+``regions[]``
+    Translation table of ``struct image_loader_region`` entries. Each
+    entry records that bytes ``[img_offset, img_offset + size)`` of the
+    source image have been loaded into RAM at address ``ram``.
+
+``nr_regions``
+    Number of entries currently used in the translation table.
+
+``alloc_ptr``
+    Next free RAM address for scratch allocations. Advanced (aligned to
+    ``ARCH_DMA_MINALIGN``) after each new mapping.
+
+API Reference
+-------------
+
+``image_loader_map(ldr, img_offset, size)``
+    Ensure that image bytes ``[img_offset, img_offset + size)`` are
+    accessible in RAM. Returns a pointer to the data.
+
+    - If the range is fully covered by an existing translation table
+      entry, returns the cached pointer (no I/O).
+    - If an entry exists at the same base offset but is smaller, the
+      entry is extended in place (re-read to the same RAM base).
+    - Otherwise, allocates from ``alloc_ptr``, reads from storage,
+      records the new mapping, and advances ``alloc_ptr``.
+
+``image_loader_map_to(ldr, img_offset, size, dst)``
+    Like ``map()`` but reads into a caller-specified RAM address instead
+    of allocating from the scratch area. Used when the sub-image has a
+    known load address (zero-copy path).
+
+``image_loader_lookup(ldr, img_offset, size)``
+    Check the translation table for an existing mapping. Returns the
+    RAM pointer on hit, ``NULL`` on miss. Does not trigger any I/O.
+
+``image_loader_cleanup(ldr)``
+    Call the backend ``cleanup`` callback (if set) and reset all loader
+    state. Safe to call multiple times.
+
+Storage Backends
+----------------
+
+Each backend implements an ``image_loader_init_*()`` function that
+resolves the device, installs ``.read()`` and ``.cleanup()`` callbacks,
+and stores backend-specific context in ``.priv``.
+
+Block (``boot/image-loader-blk.c``)
+    ``image_loader_init_blk(ldr, ifname, dev_part_str)``
+
+    Resolves the partition via ``part_get_info_by_dev_and_name_or_num()``
+    and reads via ``blk_dread()``. Handles unaligned head/tail via a
+    bounce buffer.
+
+MTD (``boot/image-loader-mtd.c``)
+    ``image_loader_init_mtd(ldr, name)``
+
+    Resolves via ``get_mtd_device_nm()`` and reads via
+    ``mtd_read_skip_bad()``. On NAND, bad blocks are transparently
+    skipped.
+
+UBI (``boot/image-loader-ubi.c``)
+    ``image_loader_init_ubi(ldr, vol_name)``
+
+    Auto-attaches a UBI device from the device tree (scanning
+    ``linux,ubi`` compatible nodes) if not already attached. Reads via
+    ``ubi_volume_read()``.
+
+Writing a New Backend
+^^^^^^^^^^^^^^^^^^^^^
+
+To add support for a new storage type:
+
+1. Create ``boot/image-loader-foo.c``.
+
+2. Define a private context struct and a read callback::
+
+       struct foo_priv { ... };
+
+       static int foo_read(struct image_loader *ldr, ulong src,
+                           ulong size, void *dst)
+       {
+           struct foo_priv *p = ldr->priv;
+           /* read 'size' bytes at offset 'src' into 'dst' */
+           return 0;  /* or negative errno */
+       }
+
+3. Optionally define a cleanup callback::
+
+       static void foo_cleanup(struct image_loader *ldr)
+       {
+           struct foo_priv *p = ldr->priv;
+           /* release resources */
+           free(p);
+       }
+
+4. Implement the init function::
+
+       int image_loader_init_foo(struct image_loader *ldr, ...)
+       {
+           struct foo_priv *p = calloc(1, sizeof(*p));
+           if (!p)
+               return -ENOMEM;
+           /* resolve device, fill p->... */
+           ldr->read = foo_read;
+           ldr->cleanup = foo_cleanup;
+           ldr->priv = p;
+           return 0;
+       }
+
+5. Add the prototype to ``include/image-loader.h``.
+
+6. Add a Kconfig symbol in ``boot/Kconfig`` and build rule in
+   ``boot/Makefile``.
+
+7. Add the keyword dispatch in ``bootm_init_loader()`` in
+   ``cmd/bootm.c``.
+
+FIT Integration
+---------------
+
+External Data vs. Embedded Data
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The selective loading optimisation is only possible with **external-data**
+FIT images (built with ``mkimage -E``). In this layout, the FDT
+structure is a compact metadata-only blob and each sub-image's payload is
+stored at a separate offset recorded via ``data-position``/``data-offset``
+and ``data-size`` properties.
+
+When ``fit_image_load()`` encounters a sub-image with external data and
+``images->loader`` is set, it reads only that sub-image's payload from
+storage — the code path is gated on ``external`` being true (i.e.
+``data-position`` or ``data-offset`` exists in the node).
+
+With **embedded-data** FIT images, all payloads live inside FDT ``data``
+properties. The entire FDT — including all payloads — is loaded when
+``boot_get_kernel()`` maps the FDT structure. The storage-backed path
+still works (the image is valid), but:
+
+- No RAM is saved because the full image is read as the "FDT structure".
+- ``IH_TYPE_FILESYSTEM`` sub-images cannot be skipped since their data
+  is embedded in the FDT blob.
+- ``fit_image_load()`` takes the normal embedded-data code path (the
+  ``data`` property points into the already-loaded FDT) and the
+  ``image_loader`` is not involved for individual sub-images.
+
+Backend developers do not need to handle this distinction — it is
+managed entirely by ``boot_get_kernel()`` and ``fit_image_load()``.
+
+Access Points
+^^^^^^^^^^^^^
+
+**Access Point 1: boot_get_kernel() (boot/bootm.c)**
+
+When ``images->loader`` is set, ``boot_get_kernel()`` uses
+``image_loader_map()`` to read the first 64 bytes for format detection,
+then extends to the full ``fdt_totalsize()`` for FIT images. For
+external-data images this is just the compact metadata; for embedded-data
+images this is the entire file. This replaces the normal
+``map_sysmem(img_addr, 0)`` path.
+
+**Access Point 2: fit_image_load() (boot/image-fit.c)**
+
+When processing a FIT sub-image with external data and
+``images->loader`` is set, ``fit_image_load()`` uses
+``image_loader_map()`` or ``image_loader_map_to()`` to load just the
+sub-image data on demand. Sub-images of type ``IH_TYPE_FILESYSTEM`` are
+skipped entirely. Verification uses ``fit_image_verify_with_data()`` to
+check hashes against the loaded data.
+
+For embedded-data sub-images, the existing in-memory code path is taken
+since the data is already present in the FDT mapping from Access Point 1.
+
+Testing
+-------
+
+Unit tests are in ``test/boot/image_loader.c`` and can be run via::
+
+    ./u-boot -T -c "ut image_loader"
+
+The tests use a mock backend that copies from a RAM buffer, exercising
+all core logic paths: mapping, caching, extending, lookup, table-full
+handling, and cleanup.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 3c044e67927..90bd6e8ac8a 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -32,6 +32,7 @@ Implementation
 
    directories
    bloblist
+   bootm-storage
    bootstd/index
    ci_testing
    commands
diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index 6c78d8584ed..d3ad4595892 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -26,6 +26,7 @@ images that it reads and boots. Documentation about FIT is available in
     sign-configs
     sign-images
     source_file_format
+    storage-boot
     uefi
     update3
     update_uboot
diff --git a/doc/usage/fit/storage-boot.rst b/doc/usage/fit/storage-boot.rst
new file mode 100644
index 00000000000..55b1d6090de
--- /dev/null
+++ b/doc/usage/fit/storage-boot.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Booting from Storage Devices
+============================
+
+Overview
+--------
+
+Traditionally, ``bootm`` expects a FIT image to already be present in RAM
+at a given address. This requires a separate ``load`` command (e.g.
+``fatload``, ``nand read``, ``ubi read``) to bring the entire image into
+memory before ``bootm`` can inspect it.
+
+With storage-backed boot, ``bootm`` can read a FIT image directly from a
+block device partition, MTD partition, or UBI volume. Only the metadata
+(FDT structure) is loaded initially; sub-images (kernel, device tree,
+ramdisk, loadables) are loaded on demand as ``bootm`` processes them.
+Filesystem sub-images (``IH_TYPE_FILESYSTEM``) are never read at all.
+
+This is particularly useful for:
+
+- Boards with limited RAM where loading the full image is impractical
+- FIT images containing large filesystem sub-images that should not be
+  loaded into RAM
+- Simplifying boot scripts by combining the load and boot steps
+
+Syntax
+------
+
+.. code-block:: none
+
+    bootm mmc <dev>:<part>[#conf[#overlay...]] [initrd [fdt]]
+    bootm mtd <name>[#conf[#overlay...]]       [initrd [fdt]]
+    bootm ubi <volume>[#conf[#overlay...]]      [initrd [fdt]]
+
+The device-type keyword (``mmc``, ``mtd``, ``ubi``) selects the storage
+backend. The device specifier identifies the source:
+
+============  ======================================
+Keyword       Device specifier
+============  ======================================
+``mmc``       ``<dev>:<part>`` or ``<dev>#<name>`` — partition by number or name
+``mtd``       MTD device or partition name
+``ubi``       UBI volume name
+============  ======================================
+
+The optional ``#conf`` suffix selects a FIT configuration by name,
+exactly as with the traditional ``bootm addr#conf`` syntax. Additional
+``#overlay`` suffixes select device-tree overlays to apply on top of the
+base configuration.
+
+Examples
+--------
+
+Boot from eMMC partition 4::
+
+    bootm mmc 0:4
+
+Boot from eMMC partition 4, selecting FIT configuration ``config-2``::
+
+    bootm mmc 0:4#config-2
+
+Boot from eMMC with a configuration and two overlays::
+
+    bootm mmc 0:4#config-1#overlay-wifi#overlay-lcd
+
+Boot from an MTD partition named ``firmware``::
+
+    bootm mtd firmware
+
+Boot from an MTD partition with a specific configuration::
+
+    bootm mtd firmware#config-1
+
+Boot from a UBI volume named ``kernel``::
+
+    bootm ubi kernel
+
+Boot from a UBI volume with a configuration::
+
+    bootm ubi kernel#config-1
+
+How It Works
+------------
+
+1. ``bootm`` detects the device-type keyword and initialises an
+   ``image_loader`` with the corresponding backend.
+
+2. The first 64 bytes of the image are read to detect the image format.
+
+3. For FIT images, the full FDT structure (metadata) is loaded so that
+   all sub-image nodes, hashes, and configuration references are
+   accessible.
+
+4. As ``bootm`` processes each sub-image (kernel, FDT, ramdisk,
+   loadables), ``fit_image_load()`` reads only the needed data from
+   storage — either to the sub-image's load address or to a scratch
+   area.
+
+5. A translation table tracks which regions have already been loaded,
+   avoiding redundant reads. Overlapping or sub-range requests are
+   served from the existing mapping.
+
+6. After the boot attempt completes (whether successful or not), the
+   loader's cleanup callback releases any held device references.
+
+Image Requirements: External Data
+---------------------------------
+
+Selective sub-image loading **requires** that the FIT image is built with
+**external data** (``mkimage -E``). In an external-data FIT, the FDT
+structure (metadata) and the sub-image payloads are stored in separate
+regions of the file:
+
+.. code-block:: none
+
+    +------------------+
+    | FDT structure    |  ← metadata: image descriptions, hashes, configs
+    | (compact)        |
+    +------------------+
+    | padding          |
+    +------------------+
+    | kernel data      |  ← loaded on demand
+    +------------------+
+    | fdt data         |  ← loaded on demand
+    +------------------+
+    | ramdisk data     |  ← loaded on demand
+    +------------------+
+    | rootfs data      |  ← skipped (IH_TYPE_FILESYSTEM)
+    +------------------+
+
+Each sub-image node in the FDT records its ``data-position`` (or
+``data-offset``) and ``data-size``, allowing the loader to seek directly
+to the needed payload without reading any other sub-image data.
+
+To create a FIT with external data::
+
+    mkimage -E -f image.its image.itb
+
+The ``-E`` flag places sub-image payloads after the FDT structure. An
+optional ``-p <pad>`` argument inserts extra padding between the FDT and
+the data area for later in-place signing or updates.
+
+With **embedded data** (the default when ``-E`` is omitted), all sub-image
+payloads are stored inline within the FDT ``data`` properties. The
+entire FDT structure — including all payloads — must be loaded to parse
+even the metadata. This means:
+
+- The ``bootm`` storage path will still work, but it loads the entire
+  FIT blob (metadata + all payloads) into RAM when it reads the FDT
+  structure. There is no selective loading benefit.
+- Filesystem sub-images embedded in the FDT cannot be skipped — they
+  are part of the FDT blob that must be read to access the metadata.
+
+In summary:
+
+================  ===============  ================  ====================
+FIT type          Selective load   Skip filesystem   RAM savings
+================  ===============  ================  ====================
+External data     Yes              Yes               Significant
+Embedded data     No               No                None (full image)
+================  ===============  ================  ====================
+
+**Recommendation:** Always use ``mkimage -E`` when building FIT images
+intended for storage-backed boot.
+
+Filesystem Sub-images
+---------------------
+
+FIT images may contain sub-images of type ``IH_TYPE_FILESYSTEM`` (e.g. a
+root filesystem squashfs). These are intended to remain on the storage
+device and be mounted at runtime — not loaded into RAM.
+
+The storage-backed boot path recognises this type and skips it entirely:
+no data is read from storage and no RAM is consumed. This is one of the
+key advantages over the traditional ``load`` + ``bootm`` flow, where the
+entire image (including any large filesystem blobs) must fit in RAM.
+
+Configuration
+-------------
+
+The feature is gated by several Kconfig options:
+
+``CONFIG_BOOTM_STORAGE``
+    Master switch. Depends on ``CMDLINE``, ``FIT``, and
+    ``IMAGE_LOADER``.
+
+``CONFIG_IMAGE_LOADER``
+    The core on-demand loading framework.
+
+``CONFIG_IMAGE_LOADER_BLK``
+    Block device backend (MMC, SATA, USB, etc.).
+
+``CONFIG_IMAGE_LOADER_MTD``
+    MTD backend (SPI-NOR, SPI-NAND, parallel NAND, etc.).
+
+``CONFIG_IMAGE_LOADER_UBI``
+    UBI volume backend.
+
+At least one backend must be enabled for ``CONFIG_BOOTM_STORAGE`` to be
+useful.
-- 
2.53.0
