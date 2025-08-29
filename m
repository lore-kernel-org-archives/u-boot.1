Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1DCA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 00:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498418340A;
	Fri, 29 Aug 2025 02:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2771783423; Fri, 29 Aug 2025 02:34:24 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D502F83403
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 02:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1C92BB22040B;
 Fri, 29 Aug 2025 02:34:19 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchart <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH] doc: Update mentions of README.fdt-control
Date: Thu, 28 Aug 2025 17:33:22 -0700
Message-ID: <20250829003330.489627-1-e@freeshell.de>
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

Fixes: 3e9fddfc4f14 "doc: Move devicetree control doc to rST"
Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/arch/nios2.rst | 2 +-
 dts/Makefile       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
index 34a75e7fb00..2fabea7bb11 100644
--- a/doc/arch/nios2.rst
+++ b/doc/arch/nios2.rst
@@ -13,7 +13,7 @@ Please refer to the link for Linux port and toolchains:
 http://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
 
 The Nios II port of u-boot is controlled by device tree. Please check
-out doc/README.fdt-control.
+out doc/develop/devicetree/control.rst.
 
 To add a new board/configuration (eg, mysystem) to u-boot, you will need
 three files.
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

base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
-- 
2.50.0

