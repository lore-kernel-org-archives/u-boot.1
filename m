Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14129C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246E84062D;
	Sun, 23 Aug 2026 19:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K7vz_FQv7c1E; Sun, 23 Aug 2026 19:16:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512601;
	bh=Er5sj90tEjWjYOqOeLPyNMufUp3DL1lC9fOR4M/0ePg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GbbDmGq7LnOVd0AEpzwldL5Rk9mKJvI57QgGWmaAESbQZW388cnM7VL0h8gkOXXaO
	 WvtXs6R0BXfX5zty7NC6bmeiF2hwO7Kqvut/3LG99L8iFlMsLGhDRJ9LHcaaqvwN96
	 +DNg1B8OudTRkjMvHsUmjTdKS8qfQoglV8BAskdsPfot5tFRpOFnuTVOGcHDxEeHqR
	 4N192q82zFdMJs7t2kUuDY8jiH1QwLpuT8YYJCluCIAy8/7K4ORFVb7QkEuuqznQMy
	 bxbjFzA/4AfKmL6vq1BB1j2PD3Ab9BmzCZu4fKXiLU8ulFSxDFNS3aWNquNqX6cTGA
	 QzGWhUAwfArxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90470405D8;
	Sun, 23 Aug 2026 19:16:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47E0041A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45A6C60746
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OBmZ_6zSCra for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:16:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4535D60732
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:16:38 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDgB-000000001qT-0a6A; Sun, 23 Aug 2026 19:16:27 +0000
Date: Sun, 23 Aug 2026 20:16:23 +0100
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
Subject: [PATCH 9/9] doc: imagemap: document on-demand loading framework
Message-ID: <bcdef6b8f84ca16bbfa79cfce7e9deecd3f9b24d.1787272661.git.daniel@makrotopia.org>
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

Describe the imagemap framework architecture: the translation table
that tracks mapped regions and its phase-determined caching, reading
from a block-device partition (including MTD via mtdblock and UBI via
ubiblock), the integration with bootm for on-demand FIT sub-image
loading, and the SPL build.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS              |   1 +
 doc/develop/imagemap.rst | 100 +++++++++++++++++++++++++++++++++++++++
 doc/develop/index.rst    |   1 +
 3 files changed, 102 insertions(+)
 create mode 100644 doc/develop/imagemap.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e8f0e94597f..f874443d87c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1191,6 +1191,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	openwrt-devel@lists.openwrt.org
 S:	Maintained
 F:	boot/imagemap.c
+F:	doc/develop/imagemap.rst
 F:	include/imagemap.h
 F:	test/boot/imagemap.c
 
diff --git a/doc/develop/imagemap.rst b/doc/develop/imagemap.rst
new file mode 100644
index 00000000000..7e461c6c955
--- /dev/null
+++ b/doc/develop/imagemap.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+On-Demand Image Loading from Storage (imagemap)
+================================================
+
+This document describes the ``imagemap`` framework that enables
+loading FIT images directly from storage devices without first
+copying the entire image into RAM.
+
+Architecture Overview
+---------------------
+
+The framework is built around the ``UCLASS_IMAGEMAP`` device class
+(``include/imagemap.h``), which provides:
+
+``imagemap_create(dev, name, part)``
+   Create an imagemap device over a partition of block device *dev*,
+   selected by *name* or by index *part*.
+
+``imagemap_map(dev, offset, size)``
+   Return a pointer to a buffer holding the requested region.
+   Consecutive calls that fall within the same region reuse the
+   existing mapping, so sub-image header look-ups are essentially
+   free.
+
+``imagemap_map_to(dev, offset, size, dst_addr)``
+   Like ``imagemap_map()`` but place the data at a specific physical
+   address (``dst_addr``).  This is used by ``fit_image_load()`` to
+   stream sub-images directly into their final load addresses.
+
+Translation Table
+~~~~~~~~~~~~~~~~~
+
+Every ``imagemap`` device maintains an internal translation
+table that records which byte ranges of the storage image have been
+read into memory and where they reside.  When ``imagemap_map()`` is
+called:
+
+1. The table is checked for an existing mapping that covers the
+   requested range.
+2. If found, the existing buffer pointer (adjusted for the offset
+   within the region) is returned immediately.
+3. If not found, a buffer is allocated via the LMB allocator, the
+   data is read from storage, and a new entry is added to the table.
+
+Reuse of already-loaded regions (steps 1 and 2) is what lets a header
+probe, signature verification and the final load of the same range share
+a single read; the FIT flow relies on it to hand already-read data back
+through ``fit_image_get_data()``.  The table also serves as the registry
+of LMB allocations that ``imagemap_cleanup()`` frees.
+
+``imagemap_cleanup()`` frees all allocated buffers and resets
+the table.
+
+Storage Access
+--------------
+
+``imagemap_create()`` reads from a partition on a block device (MMC,
+SCSI, NVMe, …), selected by name or by index.  Reads go through the
+same ``struct spl_load_info`` load-to-mem abstraction that SPL uses, so
+a byte range is fetched with native sector alignment via
+``spl_load_region()``.
+
+MTD partitions and UBI volumes are read the same way, by way of the
+existing block layers that expose them:
+
+- with ``CONFIG_MTD_BLOCK`` a non-NAND MTD (parallel NOR, SPI-NOR, ...)
+  is automatically given a ``mtd_blk`` block device, and each of its
+  partitions appears as a partition on it;
+- with ``CONFIG_UBI_BLOCK`` a UBI volume appears as a partition on the
+  ``ubi_blk`` block device (the block descriptor's ``hwpart`` selects
+  the volume).
+
+NAND bad-block handling and wear-levelling therefore stay with UBI, as
+they do for the rest of U-Boot; on NOR a partition is read linearly and
+end-to-end integrity is provided by the FIT hash or signature, so no
+MTD-specific read path is needed in imagemap.
+
+Boot Integration
+----------------
+
+The ``imagemap`` framework integrates with the boot pipeline through
+``bootm_run_states()`` in ``boot/bootm.c``:
+
+1. The imagemap device pointer is stored in ``struct bootm_info``
+   and propagated to the global ``images`` structure.
+
+2. ``boot_get_kernel()`` uses ``imagemap_map()`` to read the image
+   header and FIT metadata without loading the full image into RAM.
+
+3. ``fit_image_load()`` uses the on-demand storage path via
+   ``images->imagemap`` to stream individual sub-images directly to
+   their final load addresses.
+
+4. Before jumping to the OS, ``imagemap_cleanup()`` releases all
+   allocated resources.
+
+The ``bootmeth_openwrt`` boot method is the primary consumer of this
+framework, using it to boot OpenWrt-style FIT firmware images stored
+directly on raw storage.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0b757e8601e..3b4cc2e28a7 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -31,6 +31,7 @@ Implementation
 
    directories
    bloblist
+   imagemap
    bootstd/index
    ci_testing
    commands
-- 
2.55.0
