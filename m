Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59185D4978F
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09272893D1;
	Mon,  2 Dec 2024 01:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e2cLilKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4665893C2; Mon,  2 Dec 2024 01:13:06 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424C189287
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29e579b9e9aso417350fac.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098382; x=1733703182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNFYBLMMFtd+kDaZu/Ddn0FHK964vmgYubl++Id4OlQ=;
 b=e2cLilKcrK14/g1Lg1hE4oXyZ4nRz6CVJvRUK8KFtTiWlqrLi3aDNEvp0c9sTA0+9y
 pwszF3VUhOxI2XptGLozYIkUaNpW76L6vQGQqL61CwFqwTX5GD34V3Tpj7KtY46nTFFQ
 nCm53iPIr2kSjfnsEBiqWNm3+ksAjuJb9qiVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098382; x=1733703182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNFYBLMMFtd+kDaZu/Ddn0FHK964vmgYubl++Id4OlQ=;
 b=xEfzxMF3fUpAXVmtflgbtG2mAALHatV8dMPi31bt/Y2EiSuAaqcXhePGNaUHe9w3oo
 bnm4RDI6lFyPtTjJ44J7eRBsCLFnCuRwcKrw53GknfWK3EfzLMLW5T+bQK1dKbcLAR0t
 ufMDx8gglSIVGVwrj6gYd9pn5op9aFefWbz0i2OrBPzTr8licLye8zbyOyyPxxyq2M+I
 HBnRHLlz8HQrL1cfnXfavbL7yh9iornwSNTmnz62q+g/kduDFpzYozaRzBtt8oxdAG3+
 rjiz4X538DiqrzzvRm+iBpyTpKuqNGyJoHN94jefvK9cSBHBIgSpAp4/gTAQ4xgyk/Uf
 ZBNQ==
X-Gm-Message-State: AOJu0YypYDC2lQHj/wbxYT1QG+iP0aIvh0+alXd0hdTPgxx2MGzn6Swg
 IHRRzxhLofGmEPL+GaVnhorexR174Vv/H5gbzx7Fn+JUzR+aKaPe33BWMg2/vnUsYl4r6ofvvWA
 =
X-Gm-Gg: ASbGncu8b4iEyZ5/F6bjvgNX8WC1K6vSorL++lkMQBc0VYJvpi5Hvxt9fSM03fYlrZK
 0Khk7ae4+npJfjP1klARBoPuNOFQ1YztoBfgRmVAwG59S7kcmq/ZjhG7Y0PGqpswCc6SuPQXTCg
 c60tHGhXo/cnXKMcyo6iUQ5K9Lb2G9pUqL5n6cj8fUxkrClRoGysUZPlzhe0AK4ysyi8cpjsvVr
 Lg7K0pvPgaKVvT/G6cwA2XMrRmytJpidr8MZkOC9xq2xQ==
X-Google-Smtp-Source: AGHT+IE8KKGZPR833J6wU6+yp3ybxt2OZrK/ZxRf1hpzpmQZN5OkuaZq3CGRlL3dcm0cL8/lLRanRg==
X-Received: by 2002:a05:6870:a7a1:b0:296:7b65:2fac with SMTP id
 586e51a60fabf-29dc3fa25b4mr15238089fac.3.1733098382046; 
 Sun, 01 Dec 2024 16:13:02 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:13:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/7] efi_loader: Add a command to show the EFI log
Date: Sun,  1 Dec 2024 17:12:40 -0700
Message-Id: <20241202001243.1283274-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
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

Add a simple command which lists the log. Avoid creating any new records
when this command is invoked.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/efidebug.c             |  53 +++++++++++++++---
 doc/usage/cmd/efidebug.rst | 109 +++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst        |   1 +
 3 files changed, 155 insertions(+), 8 deletions(-)
 create mode 100644 doc/usage/cmd/efidebug.rst

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 02f1e080e88..89bef0c9c1d 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -10,6 +10,7 @@
 #include <dm/device.h>
 #include <efi_dt_fixup.h>
 #include <efi_load_initrd.h>
+#include <efi_log.h>
 #include <efi_loader.h>
 #include <efi_rng.h>
 #include <efi_variable.h>
@@ -532,6 +533,33 @@ static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+/**
+ * do_efi_show_log() - show UEFI log of boot-services calls
+ *
+ * @cmdtp:	Command table
+ * @flag:	Command flag
+ * @argc:	Number of arguments
+ * @argv:	Argument array
+ * Return:	CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on failure
+ *
+ * Implement efidebug "log" sub-command.
+ * Show UEFI log records.
+ */
+static int do_efi_show_log(struct cmd_tbl *cmdtp, int flag,
+			   int argc, char *const argv[])
+{
+	if (!IS_ENABLED(CONFIG_EFI_LOG)) {
+		printf("Please enable CONFIG_EFI_LOG to use the log\n");
+		return CMD_RET_FAILURE;
+	}
+	if (efi_log_show()) {
+		printf("Failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static const char * const efi_mem_type_string[] = {
 	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
 	[EFI_LOADER_CODE] = "LOADER CODE",
@@ -1586,6 +1614,7 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
+	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_efi_show_log, "", ""),
 	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
 			 "", ""),
 	U_BOOT_CMD_MKENT(tables, CONFIG_SYS_MAXARGS, 1, do_efi_show_tables,
@@ -1620,19 +1649,25 @@ static int do_efidebug(struct cmd_tbl *cmdtp, int flag,
 
 	argc--; argv++;
 
-	/* Initialize UEFI drivers */
-	r = efi_init_obj_list();
-	if (r != EFI_SUCCESS) {
-		printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-		       r & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
-	}
-
 	cp = find_cmd_tbl(argv[0], cmd_efidebug_sub,
 			  ARRAY_SIZE(cmd_efidebug_sub));
 	if (!cp)
 		return CMD_RET_USAGE;
 
+	/*
+	 * Calling efi_init_obj_list() can add log records, so avoid it if just
+	 * showing the log
+	 */
+	if (cp->cmd != do_efi_show_log) {
+		/* Initialize UEFI drivers */
+		r = efi_init_obj_list();
+		if (r != EFI_SUCCESS) {
+			printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			       r & ~EFI_ERROR_MASK);
+			return CMD_RET_FAILURE;
+		}
+	}
+
 	return cp->cmd(cmdtp, flag, argc, argv);
 }
 
@@ -1680,6 +1715,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show default EFI filename and PXE architecture\n"
 	"efidebug images\n"
 	"  - show loaded images\n"
+	"efidebug log\n"
+	"  - show UEFI log\n"
 	"efidebug memmap\n"
 	"  - show UEFI memory map\n"
 	"efidebug tables\n"
diff --git a/doc/usage/cmd/efidebug.rst b/doc/usage/cmd/efidebug.rst
new file mode 100644
index 00000000000..5eca4079f82
--- /dev/null
+++ b/doc/usage/cmd/efidebug.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2024 Google LLC
+.. Written by Simon Glass <sjg@chromium.org>
+
+.. index::
+   single: efidebug (command)
+
+efidebug command
+================
+
+Synopsis
+--------
+
+::
+
+    efidebug log
+
+Description
+-----------
+
+The *efidebug* command provides access to debugging features for the EFI-loader
+subsystem.
+
+Only one of the subcommands are documented at present.
+
+efidebug log
+~~~~~~~~~~~~
+
+This shows a log of EFI boot-services calls which have been handled since U-Boot
+started. This can be useful to see what the app is doing, or even what U-Boot
+itself has called.
+
+
+Example
+-------
+
+This shows checking the log, then using 'efidebug tables' to fully set up the
+EFI-loader subsystem, then checking the log again::
+
+    => efidebug log
+    EFI log (size 158)
+    0   alloc_pool bt-data size 33/51 buf 7fffd8448ad0 *buf 7c20010 ret OK
+    1  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a80 *mem 7c20000 ret OK
+    2   alloc_pool bt-data size 60/96 buf 7fffd8448ac0 *buf 7c1f010 ret OK
+    3  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a60 *mem 7c1f000 ret OK
+    4   alloc_pool bt-data size 60/96 buf 7fffd8448ac0 *buf 7c1e010 ret OK
+    5  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a60 *mem 7c1e000 ret OK
+    6 records
+    => efidebug tables
+    efi_var_to_file() Cannot persist EFI variables without system partition
+    0000000017bfc010  36122546-f7ef-4c8f-bd9b-eb8525b50c0b  EFI Conformance Profiles Table
+    0000000017bd4010  b122a263-3661-4f68-9929-78f8b0d62180  EFI System Resource Table
+    0000000017bd8010  1e2ed096-30e2-4254-bd89-863bbef82325  TCG2 Final Events Table
+    0000000017bd6010  eb66918a-7eef-402a-842e-931d21c38ae9  Runtime properties
+    0000000008c49000  8868e871-e4f1-11d3-bc22-0080c73c8881  ACPI table
+    0000000018c5b000  f2fd1544-9794-4a2c-992e-e5bbcf20e394  SMBIOS3 table
+    => efidebug log
+    EFI log (size a20)
+    0   alloc_pool bt-data size 33/51 buf 7fffd8448ad0 *buf 7c20010 ret OK
+    1  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a80 *mem 7c20000 ret OK
+    2   alloc_pool bt-data size 60/96 buf 7fffd8448ac0 *buf 7c1f010 ret OK
+    3  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a60 *mem 7c1f000 ret OK
+    4   alloc_pool bt-data size 60/96 buf 7fffd8448ac0 *buf 7c1e010 ret OK
+    5  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448a60 *mem 7c1e000 ret OK
+    6  alloc_pages any-pages rt-data pgs 20/32 mem 7fffd8448838 *mem 7bfe000 ret OK
+    7   alloc_pool rt-data size 60/96 buf 7fffd84487e0 *buf 7bfd010 ret OK
+    8  alloc_pages any-pages rt-data pgs 1 mem 7fffd8448780 *mem 7bfd000 ret OK
+    9   alloc_pool rt-data size 180/384 buf 56f190ffd890 *buf 7bfc010 ret OK
+    10  alloc_pages any-pages rt-data pgs 1 mem 7fffd8448800 *mem 7bfc000 ret OK
+    11   alloc_pool bt-data size 4 buf 7fffd8448840 *buf 7bfb010 ret OK
+    12  alloc_pages any-pages bt-data pgs 1 mem 7fffd84487f0 *mem 7bfb000 ret OK
+    13   alloc_pool bt-data size 10/16 buf 7fffd8448728 *buf 7bfa010 ret OK
+    14  alloc_pages any-pages bt-data pgs 1 mem 7fffd84486d0 *mem 7bfa000 ret OK
+    15   alloc_pool bt-data size 60/96 buf 7fffd84487e0 *buf 7bf9010 ret OK
+    16  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448780 *mem 7bf9000 ret OK
+    17   alloc_pool bt-data size 10000/65536 buf 56f19100fae0 *buf 7be8010 ret OK
+    18  alloc_pages any-pages bt-data pgs 11/17 mem 7fffd84487d0 *mem 7be8000 ret OK
+    19   alloc_pool acpi-nvs size 10000/65536 buf 56f19100fae8 *buf 7bd7010 ret OK
+    20  alloc_pages any-pages acpi-nvs pgs 11/17 mem 7fffd84487d0 *mem 7bd7000 ret OK
+    21   alloc_pool bt-data size 60/96 buf 7fffd84487d0 *buf 7bd6010 ret OK
+    22  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448770 *mem 7bd6000 ret OK
+    23   alloc_pool rt-data size 8 buf 7fffd8448818 *buf 7bd5010 ret OK
+    24  alloc_pages any-pages rt-data pgs 1 mem 7fffd84487c0 *mem 7bd5000 ret OK
+    25   alloc_pool bt-data size 8 buf 7fffd8448360 *buf 7bd4010 ret OK
+    26  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448160 *mem 7bd4000 ret OK
+    27   alloc_pool bt-data size f0/240 buf 7fffd8448378 *buf 7bd3010 ret OK
+    28  alloc_pages any-pages bt-data pgs 1 mem 7fffd84482d0 *mem 7bd3000 ret OK
+    29    free_pool buf 7bd3010 ret OK
+    30   free_pages mem 7bd3000 pag 1 ret OK
+    31   alloc_pool bt-data size 60/96 buf 7fffd84482d8 *buf 7bd3010 ret OK
+    32  alloc_pages any-pages bt-data pgs 1 mem 7fffd8448280 *mem 7bd3000 ret OK
+    33    free_pool buf 7bfa010 ret OK
+    34   free_pages mem 7bfa000 pag 1 ret OK
+    35   alloc_pool bt-data size f0/240 buf 7fffd8448380 *buf 7bfa010 ret OK
+    36  alloc_pages any-pages bt-data pgs 1 mem 7fffd84482d0 *mem 7bfa000 ret OK
+    37    free_pool buf 7bfa010 ret OK
+    38   free_pages mem 7bfa000 pag 1 ret OK
+    39    free_pool buf 7bd4010 ret OK
+    40   free_pages mem 7bd4000 pag 1 ret OK
+    41   alloc_pool bt-data size 61/97 buf 7fffd8448810 *buf 7bfa010 ret OK
+    42  alloc_pages any-pages bt-data pgs 1 mem 7fffd84487c0 *mem 7bfa000 ret OK
+    43   alloc_pool bt-data size 60/96 buf 7fffd8448800 *buf 7bd4010 ret OK
+    44  alloc_pages any-pages bt-data pgs 1 mem 7fffd84487a0 *mem 7bd4000 ret OK
+    45   alloc_pool bt-data size 60/96 buf 7fffd8448800 *buf 7bd2010 ret OK
+    46  alloc_pages any-pages bt-data pgs 1 mem 7fffd84487a0 *mem 7bd2000 ret OK
+    47   alloc_pool bt-data size 60/96 buf 7fffd8448810 *buf 7bd1010 ret OK
+    48  alloc_pages any-pages bt-data pgs 1 mem 7fffd84487b0 *mem 7bd1000 ret OK
+    49 records
+    =>
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index cb7a23f1170..d070b9fba1f 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -60,6 +60,7 @@ Shell commands
    cmd/echo
    cmd/efi
    cmd/eficonfig
+   cmd/efidebug
    cmd/env
    cmd/event
    cmd/exception
-- 
2.34.1

