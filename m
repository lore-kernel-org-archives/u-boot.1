Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA13C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F097C88838;
	Wed, 12 Jun 2024 16:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86D0885D0; Wed, 12 Jun 2024 16:59:01 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76729887ED
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vzpb56BY8zGq3;
 Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vzpb53VRVzCPB; Wed, 12 Jun 2024 16:58:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:58:47 +0200
Subject: [PATCH 2/4] boot: fix typos in help text of Kconfig configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-bootflow-efi-crash-v1-2-27b71b0ff08a@cherry.de>
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This fixes a handful of typos in various help texts in Kconfig configs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..de277d2ba50 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -423,7 +423,7 @@ config SPL_BOOTSTD
 	depends on SPL && SPL_DM && SPL_OF_CONTROL && SPL_BLK
 	default y if VPL
 	help
-	  This enables standard boot in SPL. This is neeeded so that VBE
+	  This enables standard boot in SPL. This is needed so that VBE
 	  (Verified Boot for Embedded) can be used, since it depends on standard
 	  boot. It is enabled by default since the main purpose of VPL is to
 	  handle the firmware part of VBE.
@@ -433,7 +433,7 @@ config VPL_BOOTSTD
 	depends on VPL && VPL_DM && VPL_OF_CONTROL && VPL_BLK
 	default y
 	help
-	  This enables standard boot in SPL. This is neeeded so that VBE
+	  This enables standard boot in SPL. This is needed so that VBE
 	  (Verified Boot for Embedded) can be used, since it depends on standard
 	  boot. It is enabled by default since the main purpose of VPL is to
 	  handle the firmware part of VBE.
@@ -449,7 +449,7 @@ config BOOTSTD_FULL
 	  - bootdev, bootmeth commands
 	  - extra features in the bootflow command
 	  - support for selecting the ordering of bootmeths ("bootmeth order")
-	  - support for selecting the ordering of bootdevs using the devicetree
+	  - support for selecting the ordering of bootdevs using the Device Tree
 	    as well as the "boot_targets" environment variable
 
 config BOOTSTD_DEFAULTS
@@ -481,7 +481,7 @@ config BOOTSTD_PROG
 	default y
 	help
 	  Enable this to provide a board_run_command() function which can boot
-	  a systen without using commands. If the boot fails, then U-Boot will
+	  a system without using commands. If the boot fails, then U-Boot will
 	  panic.
 
 	  Note: This currently has many limitations and is not a useful booting
@@ -517,7 +517,7 @@ config BOOTMETH_EXTLINUX
 	  bootdevs look for a 'extlinux/extlinux.conf' on each filesystem
 	  they scan.
 
-	  The specification for this filed is here:
+	  The specification for this file is here:
 
 	    https://uapi-group.org/specifications/specs/boot_loader_specification/
 
@@ -576,7 +576,7 @@ config BOOTMETH_VBE
 	select EVENT
 	help
 	  Enables support for VBE boot. This is a standard boot method which
-	  supports selection of various firmware components, seleciton of an OS to
+	  supports selection of various firmware components, selection of an OS to
 	  boot as well as updating these using fwupd.
 
 config BOOTMETH_DISTRO
@@ -593,7 +593,7 @@ config SPL_BOOTMETH_VBE
 	default y if VPL
 	help
 	  Enables support for VBE boot. This is a standard boot method which
-	  supports selection of various firmware components, seleciton of an OS to
+	  supports selection of various firmware components, selection of an OS to
 	  boot as well as updating these using fwupd.
 
 config VPL_BOOTMETH_VBE
@@ -603,7 +603,7 @@ config VPL_BOOTMETH_VBE
 	default y
 	help
 	  Enables support for VBE boot. This is a standard boot method which
-	  supports selection of various firmware components, seleciton of an OS to
+	  supports selection of various firmware components, selection of an OS to
 	  boot as well as updating these using fwupd.
 
 if BOOTMETH_VBE
@@ -748,7 +748,7 @@ if MEASURED_BOOT
 	bool "Measure the devicetree image"
 	default y if MEASURED_BOOT
 	help
-	  On some platforms, the devicetree is not static as it may contain
+	  On some platforms, the Device Tree is not static as it may contain
 	  random MAC addresses or other such data that changes each boot.
 	  Therefore, it should not be measured into the TPM. In that case,
 	  disable the measurement here.
@@ -1303,7 +1303,7 @@ config AUTOBOOT_PROMPT
 
 	  Note that this define is used as the (only) argument to a
 	  printf() call, so it may contain '%' format specifications,
-	  provided that it also includes, sepearated by commas exactly
+	  provided that it also includes, separated by commas exactly
 	  like in a printf statement, the required arguments. It is
 	  the responsibility of the user to select only such arguments
 	  that are valid in the given context.
@@ -1402,7 +1402,7 @@ config AUTOBOOT_STOP_STR_SHA256
 	help
 	  This option adds the feature to only stop the autobooting,
 	  and therefore boot into the U-Boot prompt, when the input
-	  string / password matches a values that is encypted via
+	  string / password matches a values that is encrypted via
 	  a SHA256 hash and saved in the environment variable
 	  "bootstopkeysha256". If the value in that variable
 	  includes a ":", the portion prior to the ":" will be treated

-- 
2.45.2

