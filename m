Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C166CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D3386B35;
	Sun, 24 Sep 2023 22:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fuze0jGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F8186AF7; Sun, 24 Sep 2023 22:40:26 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E05833F5
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79fa87d8f7aso116392739f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588022; x=1696192822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYhEnJt7P2zVZAzmP8dDGgcessMeilKjtZ1VYUfSuwg=;
 b=Fuze0jGaEsjaeOx0ELaeVIGlBi1keLgAI+tUXQzU4CI9UXnzPFB60f6wp3UqYB8/iV
 WbN36adC2fsH1YPRJpYnLOZaAIGhw/pNF6fOYNSNmsPrXBxuepXCK6TJHiQbME2gGOyC
 MOdpO0saRKRj5GkLU4AMuFXb1cXEfQ3pFo9jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588022; x=1696192822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYhEnJt7P2zVZAzmP8dDGgcessMeilKjtZ1VYUfSuwg=;
 b=CDg9FsD9WniR8YzFF6RxjryMuoXLy4ASMD9kmILSg35HPgidgBXca464yJGgaODjEs
 oqYI8UW49aRDRLqd925uOnl/0kUDwe327afffr5E+7XHJ4iMLYa32LTeSDaLPFJLDQYY
 /7bwydGQFpbrHzJ6Bt5SVwH0rCMZEWtx0TbJnEYcZPABLKP6Ik1L4uhenbiwFEiBmP+D
 EU8Jv+yOjPx2/HkgcSX9CPppZJQRmqFhdyyERyW2c1A8gO1BpScCGkRrdxHAthO4BRK+
 v0SV17pCxFVpAr/w1Fp+iQj+RcWJa7ZVCyamVuEaFBqje0QFW+Ibk0i3fj1icqAQ6LXS
 TmNA==
X-Gm-Message-State: AOJu0YxW+pdWQHQAZK6wiGujlAugY46srOaWg5od0Kg59t8OS9hAiH9a
 ftalpGaP3fNPq53DtJcYgiOIAiSE2jKeXyLViBQ=
X-Google-Smtp-Source: AGHT+IG5ivxXGQo2w4gGk7GrBmcY7C86QnxRsrgISUoUOc/G2IvSMswgB3UhFSXAZxukDJv0H2C8cQ==
X-Received: by 2002:a05:6602:185:b0:780:d76c:b640 with SMTP id
 m5-20020a056602018500b00780d76cb640mr5613010ioo.9.1695588022343; 
 Sun, 24 Sep 2023 13:40:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 02/25] bootstd: Correct dependencies on CMDLINE
Date: Sun, 24 Sep 2023 14:39:20 -0600
Message-ID: <20230924203953.1829820-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

With recent changes in boot/Kconfig it is no-longer possible to disable
CMDLINE. It results in various link errors because some options which
require CMDLINE are enabled regardless of whether it is available.

Add the necessary conditions to fix this.

Note that it would be better to have all commands depend on CMDLINE,
but that is extremely difficult at present, since some functions use
CMD_xxx to enable feature xxx. For example networking and environment
have a number of problems to tease apart.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig           | 19 ++++++++++++-------
 lib/efi_loader/Kconfig |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a01e6cb8aafe..f74ac7e9cc72 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -342,6 +342,7 @@ endif # FIT
 
 config PXE_UTILS
 	bool
+	depends on CMDLINE
 	select MENU
 	help
 	  Utilities for parsing PXE file formats.
@@ -357,7 +358,7 @@ config BOOT_DEFAULTS
 	select CMD_PART if PARTITIONS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
-	select CMD_PXE if CMD_NET
+	select CMD_PXE if CMDLINE && CMD_NET
 	select SUPPORT_RAW_INITRD
 	select ENV_VARS_UBOOT_CONFIG
 	select CMD_BOOTI if ARM64
@@ -461,6 +462,7 @@ config BOOTMETH_GLOBAL
 
 config BOOTMETH_CROS
 	bool "Bootdev support for Chromium OS"
+	depends on CMDLINE
 	depends on X86 || ARM || SANDBOX
 	default y if !ARM
 	select EFI_PARTITION
@@ -475,6 +477,7 @@ config BOOTMETH_CROS
 
 config BOOTMETH_EXTLINUX
 	bool "Bootdev support for extlinux boot"
+	depends on CMDLINE
 	select PXE_UTILS
 	default y
 	help
@@ -490,7 +493,7 @@ config BOOTMETH_EXTLINUX
 
 config BOOTMETH_EXTLINUX_PXE
 	bool "Bootdev support for extlinux boot over network"
-	depends on CMD_PXE && CMD_NET && DM_ETH
+	depends on CMDLINE && CMD_PXE && CMD_NET && DM_ETH
 	default y
 	help
 	  Enables support for extlinux boot using bootdevs. This makes the
@@ -504,7 +507,7 @@ config BOOTMETH_EXTLINUX_PXE
 
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
-	depends on EFI_LOADER
+	depends on EFI_LOADER && CMDLINE
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
@@ -536,10 +539,10 @@ config BOOTMETH_VBE
 
 config BOOTMETH_DISTRO
 	bool  # Options needed to boot any distro
-	select BOOTMETH_SCRIPT  # E.g. Armbian uses scripts
-	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
-	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
-	select BOOTMETH_EFILOADER if EFI_LOADER # E.g. Ubuntu uses this
+	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
+	select BOOTMETH_EXTLINUX if CMDLINE # E.g. Debian uses these
+	select BOOTMETH_EXTLINUX_PXE if CMDLINE && CMD_PXE && CMD_NET && DM_ETH
+	select BOOTMETH_EFILOADER if CMDLINE && EFI_LOADER # E.g. Ubuntu uses this
 
 config SPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (SPL)"
@@ -663,6 +666,7 @@ config BOOTMETH_SANDBOX
 
 config BOOTMETH_SCRIPT
 	bool "Bootdev support for U-Boot scripts"
+	depends on CMDLINE
 	default y if BOOTSTD_FULL
 	select HUSH_PARSER
 	help
@@ -777,6 +781,7 @@ endmenu		# Boot images
 
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
+	depends on CMDLINE
 	select BOOT_DEFAULTS
 	select AUTO_COMPLETE
 	select CMDLINE_EDITING
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6dba4..621ed5e5b0fb 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -34,6 +34,7 @@ if EFI_LOADER
 
 config CMD_BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager"
+	depends on CMDLINE
 	default y
 	select BOOTMETH_GLOBAL if BOOTSTD
 	help
-- 
2.42.0.515.g380fc7ccd1-goog

