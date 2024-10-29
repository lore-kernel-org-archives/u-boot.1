Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B6D3A692
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62DA89197;
	Tue, 29 Oct 2024 20:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHSmcH3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C65B89197; Tue, 29 Oct 2024 20:22:38 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD6F891AA
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so900523266b.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229755; x=1730834555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rHSz2fsMRcdSxbd3sELN6bnU3Y/7BPLKxZ5AJpMA8s=;
 b=aHSmcH3JeiFtke0JS0599VYhH0RR0VvEhFLfvhJMTpEwCyGz1i6UDDvD5AOw1hiAIn
 l+YM2QR0MhDIZpSjSBQsMHmbQ9JReV4SpltfgbnUYTg4VUNo0J/f9CaVqEpHgxypafoz
 5n3VJkKKkkDY2Cswjr4JVlHb+qOjRgFMCHCOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229755; x=1730834555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rHSz2fsMRcdSxbd3sELN6bnU3Y/7BPLKxZ5AJpMA8s=;
 b=eVpm1PDncHFEQPvnuQbDIvuRR9pDyG79Tq7OkqW1qrx0a8R5bAzZad47yP9+voYUjF
 Eh9qLoRDIdN9ZbGVPAlAu7XpPNOsjfUjp+G4NMy3LcLWlUbeS3+YkNi4n7pzuBvRCKvZ
 DnEcD1G/k19zZSY9YRhN2P+x29T4wgwObuPQ9IMYsrY7iPp1ZksYzS2siPEH8ioUrROo
 46aLq/FPlTYrkt3Oh/B0bSkKWWfG56Yd6nmtLglaiAg9GTDdR7bpAPQEkXgr9/cNuQQ8
 BsOljBfa+EznG4zu4QuD52jyHENjwYjoSTVx8dWLdlwewErH8l+2an9Eg4TzFKmoEHv7
 2Vaw==
X-Gm-Message-State: AOJu0YyokhAGkgJ8nG8FpV2ZG6frbX2Ztp41xKrtW/8STtHcg5HtRZ0a
 YMc9Tg1DTo0bT26Q1bvsfEiqA5tyax+vHpCfD9O2YamQr+kU+GtBT81gAotNDZPzND9k400kmxI
 4bOEx
X-Google-Smtp-Source: AGHT+IGGVcSkEd7t9rT8F6VGHFgIKen1u2SMkcc07W6YHBv1Ja+TuT0Xdz/WXai+GHD5i09i1ZI3DA==
X-Received: by 2002:a17:906:c105:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-a9de62eaf3dmr1280177266b.61.1730229755144; 
 Tue, 29 Oct 2024 12:22:35 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v9 04/11] efi: Move default filename to a function
Date: Tue, 29 Oct 2024 20:22:12 +0100
Message-ID: <20241029192222.362445-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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

Use a function to obtain the device EFI filename, so that we can control
how sandbox behaves.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Move the function into efi_helper.c

Changes in v8:
- Add new patch to move default filename to a function

 boot/bootmeth_efi.c            |  4 +--
 include/efi.h                  |  9 ++++++
 include/efi_default_filename.h | 56 ----------------------------------
 lib/efi_loader/efi_bootmgr.c   | 10 ++++--
 lib/efi_loader/efi_helper.c    | 45 +++++++++++++++++++++++++++
 test/boot/bootflow.c           |  7 +++--
 6 files changed, 67 insertions(+), 64 deletions(-)
 delete mode 100644 include/efi_default_filename.h

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..371b36d550b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -13,7 +13,7 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
-#include <efi_default_filename.h>
+#include <efi.h>
 #include <efi_loader.h>
 #include <fs.h>
 #include <malloc.h>
@@ -168,7 +168,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	}
 
 	strcpy(fname, EFI_DIRNAME);
-	strcat(fname, BOOTEFI_NAME);
+	strcat(fname, efi_get_basename());
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
diff --git a/include/efi.h b/include/efi.h
index f7419b80d4d..fef88e9c5d6 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -670,4 +670,13 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
  */
 void efi_show_tables(struct efi_system_table *systab);
 
+/**
+ * efi_get_basename() - Get the default filename to use when loading
+ *
+ * E.g. this function returns BOOTAA64.EFI for an aarch target
+ *
+ * Return: Default EFI filename
+ */
+const char *efi_get_basename(void);
+
 #endif /* _LINUX_EFI_H */
diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
deleted file mode 100644
index 77932984b55..00000000000
--- a/include/efi_default_filename.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * When a boot option does not provide a file path the EFI file to be
- * booted is \EFI\BOOT\$(BOOTEFI_NAME).EFI. The architecture specific
- * file name is defined in this include.
- *
- * Copyright (c) 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
- * Copyright (c) 2022, Linaro Limited
- */
-
-#ifndef _EFI_DEFAULT_FILENAME_H
-#define _EFI_DEFAULT_FILENAME_H
-
-#include <host_arch.h>
-
-#undef BOOTEFI_NAME
-
-#ifdef CONFIG_SANDBOX
-
-#if HOST_ARCH == HOST_ARCH_X86_64
-#define BOOTEFI_NAME "BOOTX64.EFI"
-#elif HOST_ARCH == HOST_ARCH_X86
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif HOST_ARCH == HOST_ARCH_AARCH64
-#define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif HOST_ARCH == HOST_ARCH_ARM
-#define BOOTEFI_NAME "BOOTARM.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV32
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV64
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#else
-#error Unsupported UEFI architecture
-#endif
-
-#else
-
-#if defined(CONFIG_ARM64)
-#define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif defined(CONFIG_ARM)
-#define BOOTEFI_NAME "BOOTARM.EFI"
-#elif defined(CONFIG_X86_64)
-#define BOOTEFI_NAME "BOOTX64.EFI"
-#elif defined(CONFIG_X86)
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif defined(CONFIG_ARCH_RV32I)
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif defined(CONFIG_ARCH_RV64I)
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#else
-#error Unsupported UEFI architecture
-#endif
-
-#endif
-
-#endif
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 431a38704e9..2ea20909491 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -11,10 +11,10 @@
 #include <blkmap.h>
 #include <charset.h>
 #include <dm.h>
+#include <efi.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
-#include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <asm/unaligned.h>
@@ -82,8 +82,12 @@ struct efi_device_path *expand_media_path(struct efi_device_path *device_path)
 				 &efi_simple_file_system_protocol_guid, &rem);
 	if (handle) {
 		if (rem->type == DEVICE_PATH_TYPE_END) {
-			full_path = efi_dp_from_file(device_path,
-						     "/EFI/BOOT/" BOOTEFI_NAME);
+			char fname[30];
+
+			snprintf(fname, sizeof(fname), "/EFI/BOOT/%s",
+				 efi_get_basename());
+			full_path = efi_dp_from_file(device_path, fname);
+
 		} else {
 			full_path = efi_dp_dup(device_path);
 		}
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 00167bd2a10..51e0c4852c5 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -12,18 +12,63 @@
 #include <mapmem.h>
 #include <dm.h>
 #include <fs.h>
+#include <efi.h>
 #include <efi_api.h>
 #include <efi_load_initrd.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <host_arch.h>
 #include <linux/libfdt.h>
 #include <linux/list.h>
 
+#ifdef CONFIG_SANDBOX
+
+#if HOST_ARCH == HOST_ARCH_X86_64
+#define BOOTEFI_NAME "BOOTX64.EFI"
+#elif HOST_ARCH == HOST_ARCH_X86
+#define BOOTEFI_NAME "BOOTIA32.EFI"
+#elif HOST_ARCH == HOST_ARCH_AARCH64
+#define BOOTEFI_NAME "BOOTAA64.EFI"
+#elif HOST_ARCH == HOST_ARCH_ARM
+#define BOOTEFI_NAME "BOOTARM.EFI"
+#elif HOST_ARCH == HOST_ARCH_RISCV32
+#define BOOTEFI_NAME "BOOTRISCV32.EFI"
+#elif HOST_ARCH == HOST_ARCH_RISCV64
+#define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#else
+#error Unsupported UEFI architecture
+#endif
+
+#else
+
+#if defined(CONFIG_ARM64)
+#define BOOTEFI_NAME "BOOTAA64.EFI"
+#elif defined(CONFIG_ARM)
+#define BOOTEFI_NAME "BOOTARM.EFI"
+#elif defined(CONFIG_X86_64)
+#define BOOTEFI_NAME "BOOTX64.EFI"
+#elif defined(CONFIG_X86)
+#define BOOTEFI_NAME "BOOTIA32.EFI"
+#elif defined(CONFIG_ARCH_RV32I)
+#define BOOTEFI_NAME "BOOTRISCV32.EFI"
+#elif defined(CONFIG_ARCH_RV64I)
+#define BOOTEFI_NAME "BOOTRISCV64.EFI"
+#else
+#error Unsupported UEFI architecture
+#endif
+
+#endif
+
 #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_LOAD_FILE2_INITRD)
 /* GUID used by Linux to identify the LoadFile2 protocol with the initrd */
 const efi_guid_t efi_lf2_initrd_guid = EFI_INITRD_MEDIA_GUID;
 #endif
 
+const char *efi_get_basename(void)
+{
+	return BOOTEFI_NAME;
+}
+
 /**
  * efi_create_current_boot_var() - Return Boot#### name were #### is replaced by
  *			           the value of BootCurrent
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 841729bd1ac..7cfb217088e 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -12,7 +12,7 @@
 #include <bootstd.h>
 #include <cli.h>
 #include <dm.h>
-#include <efi_default_filename.h>
+#include <efi.h>
 #include <expo.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
@@ -184,8 +184,9 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
-			   BOOTEFI_NAME);
+	ut_assert_nextline(
+		"  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
+		efi_get_basename());
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_skip_to_line(
-- 
2.43.0

