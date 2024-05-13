Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0123C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1728837C;
	Mon, 13 May 2024 20:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CIkpQmJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE60888370; Mon, 13 May 2024 20:18:05 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20CD88353
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e576057c56so26169561fa.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715624283; x=1716229083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b2H8OH/a3hQGtSGwlmM0eKHhO0/ZkIALGCrgP1MJtsE=;
 b=CIkpQmJgqUAEDrp/tyxcoQKj8x81KrbwKN3eVkJ+PmdL7zA4LCbcCpNliOrUoDhG9p
 lKAbsMLhvUpF7rNA0J5Fii+/3Vg5FmP3NL1Kok3rxqJOqKy1VtvbnIJANCcyqQkAu+hF
 p06PxEFSSuMBcxq6rnCp8Uce+xpg1pS7UsgC7YZWDrKwvqJzQkvbDmYAWhtlkW3un9m6
 s4ykJw1XA4ZwxygIxh5JUm9kq/7gH5E5tncGBmC0VotpIa9B3CsrNNnqD730rRVESMWF
 gXbiyTg7YF6C7EyZbxYnCLiY4nYWwPpIBzFuwBGI6NOqF+SDm59Uan+02y3AL3ppxiCl
 okfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715624283; x=1716229083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2H8OH/a3hQGtSGwlmM0eKHhO0/ZkIALGCrgP1MJtsE=;
 b=k0TkaWkXpJsIa72jNUUoDNMqmuRzbjSiiiEo/4Zb0RgPk0IYQ8MaPjDLXVyq9FTFD2
 xMER9NM7hOxrO+vaiSYN059PhSD8a4px1Y9kJ0XvwJKv+px43pUYiIa0BiQrEzfEcGpg
 UD51V13hei7wpAyCIm7pksFoWhUekqDsHh2j/cQT1nXIwVGlA/3uWud4lFUNRbF4GkuJ
 Is3vi1VpapueurFM4XEk3p/tA953fA1tiVexjHQL71NTUeEZNGTBbF9YkujB3wqLtH0y
 cP8cO0S288MeSsXnUstkjTvMVWw3fV8dIfIcQnYC8KbISoSlb32EMviAuPBPXINKzqP6
 jtcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpWlsCCPnjy3c5h19l7dXFH4GUJaMj8xzth9bGoxfDbwxW5lIRQ/9WhY/0b8eAx3RSvE4O0I+vwbcxAJOHox3v3piP6Q==
X-Gm-Message-State: AOJu0YyFUfkitDamlKOij54B2aryC3Z97j9V4iPS+Xao0xOo+/79AXaI
 Fmu2Bn7NDKrzQbHfgrX9HruyZist4bbRoMtXOdojQ6gnhUbRjDtU
X-Google-Smtp-Source: AGHT+IEARnAW5Jk5UuqWOqE+0aZJmnP0O0krm33hhi/MuDt2RRTm+5bEbXF7GqcblXnWVdKWmC2BTA==
X-Received: by 2002:a05:6512:459:b0:516:d0e3:9275 with SMTP id
 2adb3069b0e04-5220fc735e5mr6244447e87.11.1715624282621; 
 Mon, 13 May 2024 11:18:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-12-58.nat.spd-mgts.ru.
 [109.252.12.58]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f39d2be2sm1831409e87.254.2024.05.13.11.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 11:18:02 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: quentin.schulz@theobroma-systems.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH v2] cmd: move ELF load and boot to lib/elf.c
Date: Mon, 13 May 2024 21:17:57 +0300
Message-Id: <20240513181757.84898-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

From: Maxim Moskalets <maximmosk4@gmail.com>

Loading and running the ELF image is the responsibility of the
library and should not be associated with the command line interface.

It is also required to run ELF images from FIT with the bootm command
so as not to depend on the command line interface.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 cmd/elf.c     | 49 +++++++++++++++++--------------------------------
 include/elf.h | 10 ++++++++++
 lib/elf.c     | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index a02361f9f5..1fb955ae41 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -19,21 +19,6 @@
 #include <linux/linkage.h>
 #endif
 
-/* Allow ports to override the default behavior */
-static unsigned long do_bootelf_exec(ulong (*entry)(int, char * const[]),
-				     int argc, char *const argv[])
-{
-	unsigned long ret;
-
-	/*
-	 * pass address parameter as argv[0] (aka command name),
-	 * and all remaining args
-	 */
-	ret = entry(argc, argv);
-
-	return ret;
-}
-
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
@@ -43,8 +28,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 #endif
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
-	char *sload = NULL;
 	int rcode = 0;
+	Bootelf_flags flags = {0};
 
 	/* Consume 'bootelf' */
 	argc--; argv++;
@@ -52,7 +37,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	/* Check for [-p|-s] flag. */
 	if (argc >= 1 && (argv[0][0] == '-' && \
 				(argv[0][1] == 'p' || argv[0][1] == 's'))) {
-		sload = argv[0];
+		if (argv[0][1] == 'p')
+			flags.phdr = 1;
+		printf("## Try to elf hdr format %s\n",
+				flags.phdr ? "phdr" : "shdr");
 		/* Consume flag. */
 		argc--; argv++;
 	}
@@ -75,14 +63,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else
 		addr = image_load_addr;
 
-	if (!valid_elf_image(addr))
-		return 1;
-
-	if (sload && sload[1] == 'p')
-		addr = load_elf_image_phdr(addr);
-	else
-		addr = load_elf_image_shdr(addr);
-
 #if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
 	if (fdt_addr) {
 		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
@@ -93,21 +73,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	if (!env_get_autostart())
-		return rcode;
-
-	printf("## Starting application at 0x%08lx ...\n", addr);
-	flush();
+	if (env_get_autostart()) {
+		flags.autostart = 1;
+		printf("## Starting application at 0x%08lx ...\n", addr);
+		flush();
+	}
 
 	/*
 	 * pass address parameter as argv[0] (aka command name),
 	 * and all remaining args
 	 */
-	rc = do_bootelf_exec((void *)addr, argc, argv);
+	rc = bootelf(addr, flags, argc, argv);
 	if (rc != 0)
 		rcode = 1;
 
-	printf("## Application terminated, rc = 0x%lx\n", rc);
+	if (flags.autostart) {
+		if (ENOEXEC == errno)
+			printf("## Invalid ELF image\n");
+		else
+			printf("## Application terminated, rc = 0x%lx\n", rc);
+	}
 
 	return rcode;
 }
diff --git a/include/elf.h b/include/elf.h
index a4ba74d8ab..b88e6cf403 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -12,6 +12,12 @@
 #ifndef __ASSEMBLY__
 #include "compiler.h"
 
+/* Flag param bits for bootelf() function */
+typedef struct {
+	unsigned phdr      : 1; /* load via program (not section) headers */
+	unsigned autostart : 1; /* Start ELF after loading */
+} Bootelf_flags;
+
 /* This version doesn't work for 64-bit ABIs - Erik */
 
 /* These typedefs need to be handled better */
@@ -700,6 +706,10 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_RELATIVE	3
 
 #ifndef __ASSEMBLY__
+unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
+			   int argc, char *const argv[]);
+unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
+		      int argc, char *const argv[]);
 int valid_elf_image(unsigned long addr);
 unsigned long load_elf64_image_phdr(unsigned long addr);
 unsigned long load_elf64_image_shdr(unsigned long addr);
diff --git a/lib/elf.c b/lib/elf.c
index 9a794f9cba..f8eeceef3d 100644
--- a/lib/elf.c
+++ b/lib/elf.c
@@ -7,6 +7,7 @@
 #include <cpu_func.h>
 #include <elf.h>
 #include <env.h>
+#include <errno.h>
 #include <net.h>
 #include <vxworks.h>
 #ifdef CONFIG_X86
@@ -15,6 +16,43 @@
 #include <linux/linkage.h>
 #endif
 
+/* Allow ports to override the default behavior */
+unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
+			   int argc, char *const argv[])
+{
+	return entry(argc, argv);
+}
+
+/*
+ * @brief Boot ELF from memory
+ *
+ * @param addr       Loading address of ELF in memory
+ * @param flags      Bits like ELF_PHDR to control boot details
+ * @param argc, argv May be used to pass command line arguments (maybe unused)
+ *		     Necessary for backward compatibility with the CLI command
+ * @retuen Number returned by ELF application
+ *
+ * Sets errno = ENOEXEC if ELF image is not valid
+ */
+unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
+		      int argc, char *const argv[])
+{
+	unsigned long entry_addr;
+
+	if (!valid_elf_image(addr)) {
+		errno = ENOEXEC;
+		return 1;
+	}
+
+	entry_addr = flags.phdr ? load_elf_image_phdr(addr)
+					    : load_elf_image_shdr(addr);
+
+	if (!flags.autostart)
+		return 0;
+
+	return bootelf_exec((void *)entry_addr, argc, argv);;
+}
+
 /*
  * A very simple ELF64 loader, assumes the image is valid, returns the
  * entry point address.
-- 
2.39.2

