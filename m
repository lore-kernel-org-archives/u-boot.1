Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E497D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B50D8918B;
	Mon, 28 Oct 2024 13:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQI9/aeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B2F89181; Mon, 28 Oct 2024 13:48:47 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0591F88C53
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so6685673a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119724; x=1730724524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxBBHnwZylABdnD5NH/D7wXfjMz8hOjx+JChzGdsCLk=;
 b=IQI9/aeVSoP6TctjF5sK3NNZKm75RX+atF4SIU2Mkp6JdXW82CNI3jtUD7QHeoHzup
 UGQ9WCFHDtO1+teuBxWdy0jQ0TMMcNPIie1LdE34c+e1+VDSPdAwVbosS78ZU+D0nCrF
 6l70KiOVGU1ubThwYHG6taVljOECqsdata3PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119724; x=1730724524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxBBHnwZylABdnD5NH/D7wXfjMz8hOjx+JChzGdsCLk=;
 b=NNzMgTjGq3TxqHS23Bacf+Ppmes6rUexjEc5mSSFODYTmg00mJLzh1stZ7WfDq5amW
 d8qIXal7rVeQAog3nhQSAvcuw7BehxeqC6cgZadPZ63pxpQl1TAgzIEuFoM8j3VgiUYG
 wACceX8nLOJa4I3RaG1a2x0dvaQkqN4EqyUQ5i6VFrE9wYbx6kIAqF0Wz8cLu1NFvBOh
 kpDVO8rpuwgutsZUwAeprM74xuM76AVFpmtVEJ73g0Kxqhyd6AxcctH4ojfDCrfZ6B11
 ix0J9eiZ5YqC6I6D4vfrLPVUp4O6gXRsgv1CU1wOApqo0wuNNrDTVwbB3VoMoB0ojFNB
 4RsQ==
X-Gm-Message-State: AOJu0YzUrbS9sEubh/3dhGivJsBw9sr44m1VKPLsxuF82MuT4oxQnwRv
 LVJ/jmRHCUgI65y2KcITG8617m/KgUg9XhHcH+AGjiy2fdhzjl90+7ZG+Fga6eUqMtEWCTQq5dq
 dYg==
X-Google-Smtp-Source: AGHT+IGhJiqduY7umbXL1PxQK0mjb0jZnkvsSSipbG9c9wAShruXY2eY9sf8EFZ1jSWQ3qan/DUW9g==
X-Received: by 2002:a17:907:e8b:b0:a9a:714:4399 with SMTP id
 a640c23a62f3a-a9de6167a45mr661131566b.51.1730119723926; 
 Mon, 28 Oct 2024 05:48:43 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 12/15] efi_loader: Add a command to show the EFI log
Date: Mon, 28 Oct 2024 13:48:03 +0100
Message-ID: <20241028124815.47262-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

 cmd/efidebug.c             |  53 +++++++++++++++---
 doc/usage/cmd/efidebug.rst | 109 +++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst        |   1 +
 3 files changed, 155 insertions(+), 8 deletions(-)
 create mode 100644 doc/usage/cmd/efidebug.rst

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e040fe75fa1..bba984b2b75 100644
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
@@ -511,6 +512,33 @@ static int do_efi_show_images(struct cmd_tbl *cmdtp, int flag,
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
@@ -1563,6 +1591,7 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
 			 "", ""),
+	U_BOOT_CMD_MKENT(log, CONFIG_SYS_MAXARGS, 1, do_efi_show_log, "", ""),
 	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
 			 "", ""),
 	U_BOOT_CMD_MKENT(tables, CONFIG_SYS_MAXARGS, 1, do_efi_show_tables,
@@ -1597,19 +1626,25 @@ static int do_efidebug(struct cmd_tbl *cmdtp, int flag,
 
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
 
@@ -1655,6 +1690,8 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI handles\n"
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
index 24b2d2637b1..a2340d9a7e0 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -59,6 +59,7 @@ Shell commands
    cmd/echo
    cmd/efi
    cmd/eficonfig
+   cmd/efidebug
    cmd/env
    cmd/event
    cmd/exception
-- 
2.43.0

