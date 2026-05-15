Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9A9CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C805848FD;
	Sat, 16 May 2026 03:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A433984885; Sat, 16 May 2026 01:39:09 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D293084884
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO26m-000000004jC-3L6E; Fri, 15 May 2026 23:38:20 +0000
Date: Sat, 16 May 2026 00:38:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 5/8] doc: fit: add dm-verity boot parameter documentation
Message-ID: <66ca4eaba31bca97d80ad6de789f025146923d35.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

Add documentation for CONFIG_FIT_VERITY which allows U-Boot to
construct dm-mod.create= and dm-mod.waitfor= kernel command-line
parameters from dm-verity metadata embedded in FIT filesystem
sub-images.

The new document covers the relationship between FIT loadable indices
and the /dev/fitN block devices that the Linux uImage.FIT block driver
creates, provides a complete .its example with a dm-verity-protected
SquashFS root filesystem, describes all required and optional dm-verity
subnode properties and explains how mkimage generates the verity
metadata automatically.

dm-verity is only supported for external-data FIT images (mkimage -E);
mkimage aborts with an error if the flag is omitted.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: document that the fitblk driver requires each filesystem
    sub-image to be aligned to the underlying block-device block
    size, and that 'mkimage -B <align>' (typically -B 0x1000)
    achieves this; clarify that this is independent of the dm-verity
    data-block-size / hash-block-size properties; reflect the v4
    refactor that dropped the verity-data-file property by updating
    the step that previously talked about a temporary file
v4: no changes
v3: clarify that hash-start-block only equals num-data-blocks when
    data-block-size == hash-block-size; in the general case it is
    data_size / hash-block-size
v2: trim minimal .its example to user-provided properties only and
    remove stale references to a verity superblock
---
 doc/usage/fit/dm-verity.rst | 304 ++++++++++++++++++++++++++++++++++++
 doc/usage/fit/index.rst     |   1 +
 2 files changed, 305 insertions(+)
 create mode 100644 doc/usage/fit/dm-verity.rst

diff --git a/doc/usage/fit/dm-verity.rst b/doc/usage/fit/dm-verity.rst
new file mode 100644
index 00000000000..7aad7739435
--- /dev/null
+++ b/doc/usage/fit/dm-verity.rst
@@ -0,0 +1,304 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+FIT dm-verity Boot Parameters
+=============================
+
+Introduction
+------------
+
+Linux's dm-verity device-mapper target provides transparent integrity
+checking of block devices using a Merkle tree. It is commonly used to
+protect read-only root filesystems such as SquashFS images.
+
+When a FIT image packages the root filesystem as a loadable sub-image of
+type ``filesystem`` (``IH_TYPE_FILESYSTEM``), the verity metadata can be
+stored alongside the image data in a ``dm-verity`` subnode. U-Boot reads
+this metadata at boot time and generates the kernel command-line parameters
+that Linux needs to activate the verity target, eliminating the need for
+an initramfs or userspace helper to set up dm-verity.
+
+This feature is enabled by ``CONFIG_FIT_VERITY`` (see ``boot/Kconfig``).
+
+Prerequisites
+-------------
+
+* **Linux uImage.FIT block driver** – the kernel must include the FIT block
+  driver that exposes loadable sub-images as ``/dev/fit0``, ``/dev/fit1``,
+  etc. The driver assigns device numbers in the order loadables appear in
+  the FIT configuration.
+
+* **dm-verity support in the kernel** – ``CONFIG_DM_VERITY`` must be
+  enabled so the kernel can process the ``dm-mod.create=`` parameter.
+
+* **CONFIG_FIT_VERITY** enabled in U-Boot.
+
+How it works
+------------
+
+The implementation is split into a **build** phase and an **apply** phase,
+both of which run automatically within the ``bootm`` state machine. No boot
+method needs to call verity functions explicitly.
+
+**Build phase** (``BOOTM_STATE_FINDOTHER`` → ``boot_get_loadable()``)
+
+1. After all loadable sub-images have been loaded,
+   ``fit_verity_build_cmdline()`` iterates the configuration's
+   ``loadables`` list.
+
+2. For each loadable that is an ``IH_TYPE_FILESYSTEM`` image **and**
+   contains a ``dm-verity`` child node, a dm-verity target specification is
+   built by the helper ``fit_verity_build_target()``.
+
+3. The dm-verity target references ``/dev/fitN``, where *N* is the
+   zero-based index of the loadable in the configuration. This matches the
+   numbering used by the Linux FIT block driver.
+
+4. The resulting fragments are stored in ``struct bootm_headers``:
+
+   ``images->dm_mod_create``
+     The full dm-verity target table. Multiple targets are separated by ``;``.
+
+   ``images->dm_mod_waitfor``
+     Comma-separated list of ``/dev/fitN`` devices so the kernel waits for
+     the underlying FIT block devices to appear before activating
+     device-mapper.
+
+**Apply phase** (``BOOTM_STATE_OS_PREP``)
+
+5. Just before ``bootm_process_cmdline_env()`` processes the ``bootargs``
+   environment variable, ``fit_verity_apply_bootargs()`` appends the
+   ``dm-mod.create=`` and ``dm-mod.waitfor=`` parameters.
+
+**Bootmeth integration**
+
+  Because the fragments are stored in ``struct bootm_headers``, a boot
+  method can check ``fit_verity_active(images)`` between bootm state
+  invocations. A typical pattern splits ``bootm_run_states()`` into two
+  calls -- one for ``START|FINDOS|FINDOTHER|LOADOS`` and one for
+  ``OS_PREP|OS_GO`` -- and inspects ``fit_verity_active()`` in
+  between to decide whether to add a ``root=`` parameter pointing at the
+  dm-verity device.
+
+FIT image source (.its) example
+-------------------------------
+
+Below is a minimal ``.its`` file showing a kernel and a dm-verity-protected
+root filesystem packaged as a FIT. Only the three user-provided properties
+(``algo``, ``data-block-size``, ``hash-block-size``) are included; ``mkimage``
+computes and fills in ``digest``, ``salt``, ``num-data-blocks``, and
+``hash-start-block`` automatically (see `Generating verity metadata`_ below)::
+
+    /dts-v1/;
+
+    / {
+        description = "Kernel + dm-verity rootfs";
+        #address-cells = <1>;
+
+        images {
+            kernel {
+                description = "Linux kernel";
+                data = /incbin/("./Image.gz");
+                type = "kernel";
+                arch = "arm64";
+                os = "linux";
+                compression = "gzip";
+                load = <0x44000000>;
+                entry = <0x44000000>;
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+
+            fdt {
+                description = "Device tree blob";
+                data = /incbin/("./board.dtb");
+                type = "flat_dt";
+                arch = "arm64";
+                compression = "none";
+                hash-1 {
+                    algo = "sha256";
+                };
+            };
+
+            rootfs {
+                description = "SquashFS root filesystem";
+                data = /incbin/("./rootfs.squashfs");
+                type = "filesystem";
+                arch = "arm64";
+                compression = "none";
+                hash-1 {
+                    algo = "sha256";
+                };
+
+                dm-verity {
+                    algo = "sha256";
+                    data-block-size = <4096>;
+                    hash-block-size = <4096>;
+                };
+            };
+        };
+
+        configurations {
+            default = "config-1";
+            config-1 {
+                description = "Boot with dm-verity rootfs";
+                kernel = "kernel";
+                fdt = "fdt";
+                loadables = "rootfs";
+            };
+        };
+    };
+
+With this configuration U-Boot produces a kernel command line similar to::
+
+    dm-mod.create="rootfs,,, ro,0 <data_sectors> verity 1 \
+        /dev/fit0 /dev/fit0 4096 4096 3762 3762 sha256 \
+        8e6791637f93cbb81fc45299e203cbe85ca2e47a38f5051bddeece92d7b1c9f9 \
+        aa7b11f8db8fe2e5bfd4eca1d18a22b5de7ea39d2e1b93bb7272ce0c6ca3cc8e" \
+    dm-mod.waitfor=/dev/fit0
+
+dm-verity subnode properties
+----------------------------
+
+User-provided properties (required in the ``.its``):
+
+.. list-table::
+   :header-rows: 1
+   :widths: 20 15 65
+
+   * - Property
+     - Type
+     - Description
+   * - ``algo``
+     - string
+     - Hash algorithm name, e.g. ``"sha256"``.
+   * - ``data-block-size``
+     - u32
+     - Data block size in bytes (>= 512, typically 4096).
+   * - ``hash-block-size``
+     - u32
+     - Hash block size in bytes (>= 512, typically 4096).
+
+Computed properties (filled in by ``mkimage``):
+
+.. list-table::
+   :header-rows: 1
+   :widths: 20 15 65
+
+   * - Property
+     - Type
+     - Description
+   * - ``num-data-blocks``
+     - u32
+     - Number of data blocks in the filesystem image (computed from the
+       image size and ``data-block-size``).
+   * - ``hash-start-block``
+     - u32
+     - Offset in ``hash-block-size``-sized blocks from the start of the
+       sub-image to the root block of the hash tree.
+   * - ``digest``
+     - byte array
+     - Root hash of the Merkle tree, stored as raw bytes. Length must match
+       the output size of ``algo``.
+   * - ``salt``
+     - byte array
+     - Salt used when computing the Merkle tree, stored as raw bytes.
+
+These values are the same ones produced by ``veritysetup format`` and can
+typically be obtained from its output.
+The ``digest`` and ``salt`` byte arrays correspond to the hex-encoded
+``Root hash`` and ``Salt`` printed by ``veritysetup format``.
+
+Optional boolean properties (when present, they are collected and appended
+as dm-verity optional parameters with hyphens converted to underscores):
+
+.. list-table::
+   :header-rows: 1
+   :widths: 30 70
+
+   * - Property
+     - Description
+   * - ``restart-on-corruption``
+     - Restart the system on data corruption.
+   * - ``panic-on-corruption``
+     - Panic the system on data corruption.
+   * - ``restart-on-error``
+     - Restart the system on I/O error.
+   * - ``panic-on-error``
+     - Panic the system on I/O error.
+   * - ``check-at-most-once``
+     - Verify data blocks only on first read.
+
+
+Generating verity metadata
+--------------------------
+
+``mkimage`` automates the entire process. When it encounters a
+``dm-verity`` subnode, it:
+
+1. Writes the embedded image data to a temporary file.
+2. Runs ``veritysetup format`` with the user-supplied algorithm and
+   block sizes.
+3. Parses ``Root hash`` and ``Salt`` from ``veritysetup`` stdout.
+4. Reads the expanded content (original data + Merkle hash tree) back
+   into an in-memory buffer and removes the temporary file.  The
+   external-data section written to the .itb file uses this buffer in
+   place of the original ``data`` property.
+5. Writes the computed ``digest``, ``salt``, ``num-data-blocks``, and
+   ``hash-start-block`` properties into the ``dm-verity`` subnode.
+
+Images with ``dm-verity`` subnodes **must** use external data layout
+(``mkimage -E``). ``mkimage`` will abort with an error if ``-E`` is
+not specified.
+
+Usage::
+
+    # Create the filesystem image
+    mksquashfs rootfs/ rootfs.squashfs -comp xz
+
+    # Build the FIT (dm-verity is computed automatically); align each
+    # external-data section to the block size of the underlying storage
+    # (see the alignment note below).
+    mkimage -E -B 0x1000 -f image.its image.itb
+
+``veritysetup`` (from the cryptsetup_ package) must be installed on
+the build host.
+
+.. _cryptsetup: https://gitlab.com/cryptsetup/cryptsetup
+
+.. note::
+
+   ``veritysetup format`` is invoked with ``--no-superblock``, so no
+   on-disk superblock is written between the data and hash regions.
+   The Merkle hash tree is appended directly to the image data within
+   the FIT external data section. ``hash-start-block`` is therefore
+   computed as ``data_size / hash-block-size`` (the offset of the hash
+   region in units of ``hash-block-size``). When ``data-block-size``
+   equals ``hash-block-size`` this happens to equal ``num-data-blocks``.
+
+.. note::
+
+   The Linux ``fitblk`` driver currently requires each ``filesystem``
+   sub-image to start and end on block boundaries of the underlying
+   block device (typically 512 bytes, sometimes 4 KiB for eMMC or NVMe
+   with 4 KiB native sectors). Use ``mkimage -B <align>`` to pad
+   external-data sections to that boundary; ``-B 0x1000`` is a safe
+   default for the storage in common use.
+
+   This alignment requirement comes from the kernel-side ``fitblk``
+   driver to avoid unaligned-access fix-up overhead in block I/O, and
+   is **independent** of the dm-verity ``data-block-size`` and
+   ``hash-block-size`` properties -- those describe the block sizes
+   used by the device-mapper verity target itself, not storage
+   alignment.
+
+Kconfig
+-------
+
+``CONFIG_FIT_VERITY``
+  Depends on ``CONFIG_FIT`` and ``CONFIG_OF_LIBFDT``.
+  When enabled, ``fit_verity_build_cmdline()`` and
+  ``fit_verity_apply_bootargs()`` are compiled into the boot path.
+  When disabled, the functions are static inlines returning 0, so there
+  is no code-size impact. Works with both the ``bootm`` command and
+  BOOTSTD boot methods.
diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index 6c78d8584ed..d17582b1d64 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -11,6 +11,7 @@ images that it reads and boots. Documentation about FIT is available in
     :maxdepth: 1
 
     beaglebone_vboot
+    dm-verity
     howto
     kernel_fdt
     kernel_fdts_compressed
-- 
2.54.0
