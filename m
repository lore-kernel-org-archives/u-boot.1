Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9691BCAC592
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 01:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB867832AD;
	Wed, 17 Sep 2025 03:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E3D803CC; Wed, 17 Sep 2025 03:18:54 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631D2832AD
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 03:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9B992B220288;
 Wed, 17 Sep 2025 03:18:50 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchart <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2] doc: Update mentions of README.fdt-control
Date: Tue, 16 Sep 2025 18:17:05 -0700
Message-ID: <20250917011720.1148189-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Update documents 'README.fdt-control' reference to replacement 'control.rst':
  doc/arch/nios2.rst
  dts/Makefile

Also convert some adjacent pathname mentions to rST links where applicable

Fixes: 3e9fddfc4f14 "doc: Move devicetree control doc to rST"
Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/arch/nios2.rst                    | 2 +-
 doc/develop/devicetree/control.rst    | 3 ++-
 doc/develop/driver-model/design.rst   | 1 +
 doc/develop/driver-model/ethernet.rst | 2 +-
 doc/develop/spl.rst                   | 2 +-
 doc/usage/fdt_overlays.rst            | 1 +
 doc/usage/fit/overlay-fdt-boot.rst    | 2 +-
 dts/Makefile                          | 2 +-
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
index 34a75e7fb00..58f63c996b6 100644
--- a/doc/arch/nios2.rst
+++ b/doc/arch/nios2.rst
@@ -13,7 +13,7 @@ Please refer to the link for Linux port and toolchains:
 http://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
 
 The Nios II port of u-boot is controlled by device tree. Please check
-out doc/README.fdt-control.
+out :ref:`devicetree_control`.
 
 To add a new board/configuration (eg, mysystem) to u-boot, you will need
 three files.
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..aa33b4b781f 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,6 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
 .. Copyright 2023-2024 Linaro Ltd.
+.. _devicetree_control:
 
 Devicetree Control in U-Boot
 ============================
@@ -282,7 +283,7 @@ U-Boot can be divided into three phases: TPL, SPL and U-Boot proper.
 
 The full devicetree is available to U-Boot proper, but normally only a subset
 (or none at all) is available to TPL and SPL. See 'Pre-Relocation Support' and
-'SPL Support' in doc/driver-model/design.rst for more details.
+'SPL Support' in :ref:`driver-model_design` for more details.
 
 
 Using several DTBs in the SPL (SPL_MULTI_DTB_FIT Kconfig option)
diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 633545944d1..005e0a00a26 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
+.. _driver-model_design:
 
 Design Details
 ==============
diff --git a/doc/develop/driver-model/ethernet.rst b/doc/develop/driver-model/ethernet.rst
index 73c3a728dbf..ca3e50af6ed 100644
--- a/doc/develop/driver-model/ethernet.rst
+++ b/doc/develop/driver-model/ethernet.rst
@@ -8,7 +8,7 @@ own ethernet device driver.  Here we will describe a new pseudo 'APE' driver.
 
 Most existing drivers do already - and new network driver MUST - use the
 U-Boot core driver model. Generic information about this can be found in
-doc/driver-model/design.rst, this document will thus focus on the network
+:ref:`driver-model_design`, this document will thus focus on the network
 specific code parts.
 Some drivers are still using the old Ethernet interface, differences between
 the two and hints about porting will be handled at the end.
diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 7f2eac50806..f76c40437b2 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -145,7 +145,7 @@ fdtgrep is also used to remove:
   'bootph-verify' (VPL))
 
 All the nodes remaining in the SPL devicetree are bound
-(see doc/driver-model/design.rst).
+(see :ref:`driver-model_design`).
 
 NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
 update to use the new bootph-* tags as described in the
diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 15ebd17ccb1..7078e3dbd4d 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. Copyright (c) 2017, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
+.. _fdt-overlays:
 
 Device Tree Overlays
 ====================
diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt-boot.rst
index 3d7296ad913..f0e283f5448 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -13,7 +13,7 @@ that matches the desired configuration.
 
 This document focuses on specifically using overlays as part of a FIT image.
 General information regarding overlays including its syntax and building it
-can be found in doc/README.fdt-overlays
+can be found in :ref:`fdt-overlays`
 
 Configuration without overlays
 ------------------------------
diff --git a/dts/Makefile b/dts/Makefile
index 86bf8dc2156..fd4ae31a533 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 
 # This Makefile builds the internal U-Boot fdt if CONFIG_OF_CONTROL is
-# enabled. See doc/README.fdt-control for more details.
+# enabled. See doc/develop/devicetree/control.rst for more details.
 
 DEVICE_TREE ?= $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%)
 ifeq ($(DEVICE_TREE),)

base-commit: b82fa9d752b025d3b5305b5b07debe6808a5d027
-- 
2.50.0

