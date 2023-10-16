Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC3BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7344786EF6;
	Tue, 17 Oct 2023 00:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1cH+guV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B642786ED1; Tue, 17 Oct 2023 00:29:41 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD2D86E16
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d9a4c0d89f7so5916518276.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495360; x=1698100160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KLNYxgDHvNhxWsFCoxIrToPcvNEB3p3YFD0+Ut+pMg=;
 b=d1cH+guVLW0GIg8N/bujOQsePl0vOPcxEijdU05Vo/puhnCv1Ruu3xVy1bSbwJsFj3
 9F18kPveXAgOAD3vNK8cETVf0LoTQcLoD+jMJwfbnq+NTk8PCD70WCGOKt7UGKpM7UjA
 SAA3pVLmrWLGpF4C4qTuG+2us08agx1xfSh1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495360; x=1698100160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KLNYxgDHvNhxWsFCoxIrToPcvNEB3p3YFD0+Ut+pMg=;
 b=U/M/BxuDPFAnuzYLXI9CRAxYS8np+Psd27Y+Nl4vpMe++mXj9zCjHWhQ/HViRAYQTV
 1D3dksXF32s299/T1H2PED/Q3f/3uEiSI9ah20D+SU4kxALP+hUX+Y6Vf5NsvoSU5mBv
 bkDdbMr9wMDuX3JIL0R6yhhyG1PaYcir59XCKDm4r2ee5oUWY7cOZ+KDC9KfSpNCM/x3
 w89HKGn5OzvGE/w16crA9ljh6bnZCClWzvtyV8CzKRC3LW99Tm2cP0ZEX7JxMg81TdeD
 AJGC494m6PW9JC5nlB1sbNpbKoIwAE2M3LZG6N2xQKizEmrFrMPdafCza195V8hJ2NHq
 LLzg==
X-Gm-Message-State: AOJu0YzR78sgcwkWjO5JQK8/J25Hn+68AKUkdaWZrS1NH6hU+rz/W2lk
 cpVv0HSPFIAeONC4Dx/i/mWyj/yQCF5Sxu0Z1+dwTA==
X-Google-Smtp-Source: AGHT+IHpnk6XOjQL7i6CM/YCz4V5RNfAbJFGvWqFYeyToWAyLXUkobq6ne2evZJdBuO1aXvT5CSJRw==
X-Received: by 2002:a25:cf8d:0:b0:d9a:e6d6:42f8 with SMTP id
 f135-20020a25cf8d000000b00d9ae6d642f8mr416054ybg.29.1697495360712; 
 Mon, 16 Oct 2023 15:29:20 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:29:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
Date: Mon, 16 Oct 2023 16:27:53 -0600
Message-ID: <20231016222835.596572-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

With recent changes over the last few years in boot/Kconfig it is
no-longer possible to disable CMDLINE. It results in various link
errors because some options which require CMDLINE are enabled
regardless of whether it is available.

Add the necessary conditions to fix this.

Note that it would be better to have all commands depend on CMDLINE,
but that is extremely difficult at present, since some functions use
CMD_xxx to enable feature xxx. For example networking and environment
have a number of problems to tease apart.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Reword commit message slightly

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
2.42.0.655.g421f12c284-goog

