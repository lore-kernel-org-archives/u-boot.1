Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BDDD5D688
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C9788B4B;
	Thu,  7 Nov 2024 22:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d+fBmrWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598D988730; Thu,  7 Nov 2024 22:32:12 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06ADB891BC
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aac75fcceso49970239f.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015128; x=1731619928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Fo78y6DPUayqBnRFaxfcKJUVdRfdTYhKuQuH9qRXOY=;
 b=d+fBmrWU00WX/MqVgxWzDDuz2WSCpFOWLHuNcvJPMCaGMpCPPOAvsRMS5V+HPrOz1B
 vaMDd2vPqK9nJgCAeFdJosUynGwU42bTmiuEO5fnDweZETushKR3htWuw9ybF/Z0N33s
 +QXkE6kqkaPIxwk4p1SdFBnZJl7IRyqt9Ntlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015128; x=1731619928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Fo78y6DPUayqBnRFaxfcKJUVdRfdTYhKuQuH9qRXOY=;
 b=nUx+gKYHiuKPPW86HtI9GqVFIO6zWEQeYY5jX6ODdxd2W/c6dI4+r1gj7rZynG+5VY
 hNkjC0roZdVUqf4daaPW6U6pqDN8xb7blKJBCd3AZdOFBZr7Dax5cVnArCC6pHfoWxiw
 Owtrj+7j31fpTUlH0stxicrFmDxEetNuJvnPXplLSdPpqzCxlS3iNkFht1RdMjxk/M1F
 bUCLfwAT+wFy1jaqJmJZ0oba5cK62nzFxbX4jD27Bg8aLyuddt3nl91dzJwH8jex+921
 SK1vBkuvqhAoyXBV20L2eEc+pHILrpQseCHr8sZL55/tb4PIscZjhSJMG8zlxmTxBLjz
 JFGg==
X-Gm-Message-State: AOJu0YwU6gn9OglN/zCdK13Wh7frgBU5xBZ9JbFem781SZb1rnyM+pZ8
 Ap2fvHQxANxRq2o0OykGg3SfjlSaHtc3VSibLN18WGoVZcySFxIlnjdthafDynMfSky35GoFOKk
 =
X-Google-Smtp-Source: AGHT+IHexym2oYbgCGaLd3paUiB5I99sPo2KwyQzjAUMk3SFIEOjkxLBm2toit4FOVHdhLHOaTEeSA==
X-Received: by 2002:a05:6e02:178b:b0:3a6:ac98:2c7b with SMTP id
 e9e14a558f8ab-3a6f1a62066mr6803355ab.24.1731015128064; 
 Thu, 07 Nov 2024 13:32:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v10 03/10] efi: Move default filename to a function
Date: Thu,  7 Nov 2024 14:31:43 -0700
Message-Id: <20241107213150.1711962-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

(no changes since v9)

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
index 84640cf7b25..ecdf7210750 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -669,4 +669,13 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
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
index f9b5988a06e..8c51a6ef2ed 100644
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
index 2f859c40adb..372bbab6b8d 100644
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
2.34.1

