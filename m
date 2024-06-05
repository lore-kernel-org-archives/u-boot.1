Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED59AC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 18:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545648825E;
	Wed,  5 Jun 2024 20:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDWN4VO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1B9882E8; Wed,  5 Jun 2024 20:43:42 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7511F87842
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b950aa47bso272832e87.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717613020; x=1718217820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oQSfouEfhX7wzpgRRSAk/tjFaHg+NE6ZA6/rzgbF54k=;
 b=iDWN4VO/6IIluuh0MH7A+Sq5BJwv5/eD8r+cit0eoYftCUlIBzU8YYfh3Gfxo4iPHa
 ESV9ysm4D9ZXShVhNpLGW3A3J9Kzmin2UlHTfW4022mQT+nAaJK+0y57M1N4q3hXu6Vx
 apvZXCZMi9mHV23vAYCo6CDu8IJNUDuzE6qvabnH0MvWZwTtdkzozmMEYxUb42AsFNCF
 yQ2U4EZ+qgPvPqSh9J+RxS1J8bqSiBp52f3+h61XSwHKb0ZBHEA8o+NwT0jxtZuLH/rV
 xgkA+Z3WnupppNE34kbQpofWcax1Oc+C7u1sixwXZ3YbA/CQL77gYUZmwj+Sv5JBrtD6
 VbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613020; x=1718217820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQSfouEfhX7wzpgRRSAk/tjFaHg+NE6ZA6/rzgbF54k=;
 b=pK09TJ82t5EAePcr2wiqwq+cwcKC270Pfbeb8v4eHr8AfNWUwAxyMeMI+PIDe6ZkvV
 RxpD3jKxYH0kgE5h0JgknEXRuC8mWcTiBU8jM3s6PCTGhwRIn121NyUC/1Njmojz21Nt
 0ZQo6vgmRYl6bXv/Dwk80CdgSK//vKNyjC/5uPOlfcG/rejs1+Dyr//dIQYd//ptf7tG
 AVXEXETwBgTc66F8jTZbUCFyfMJ3s9Jblajj3EZ8xApShHgLzjtamJkpCmbu1AOFbezz
 8mSWxBgYo8gwmeImycjZ4l/7iIn1Aqpsxz6DOzm4v0clKYcMVAs3UiQ3NenVHbAXKzSI
 hZSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF0R90Im7sbCpb0uwwmnMQcGv4StL+c6NRH38Ib43epJZ/dpviKWLxN9GET1+HS9M05EZl4DbKz328OedQ4YMp7jdPyQ==
X-Gm-Message-State: AOJu0YxvoWuW3A5G0RfY+v/Rk/PvlOAmhp2QPfFI3+PMumpfbH2EFmsB
 3lbNDyqDK7dUxOvNIc+ThH7Qo73MWchrjABfKSAYDky/2Nhv/d8l
X-Google-Smtp-Source: AGHT+IGVTgmv2zEIwqPXxo1YhnYLJNMIiQNwoswruP2k3WrNFdrDIqKPtL4UhY12yaU0HK6cdqe4DA==
X-Received: by 2002:ac2:4d8c:0:b0:52b:b327:9c1c with SMTP id
 2adb3069b0e04-52bb327ac67mr45340e87.62.1717613019523; 
 Wed, 05 Jun 2024 11:43:39 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b84d7f214sm1899138e87.197.2024.06.05.11.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 11:43:39 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: quentin.schulz@theobroma-systems.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: Maxim.Moskalets@kaspersky.com,
	Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v5] cmd: move ELF load and boot to lib/elf.c
Date: Wed,  5 Jun 2024 21:43:34 +0300
Message-Id: <20240605184334.13973-1-Maxim.Moskalets@kaspersky.com>
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
 cmd/elf.c     | 58 +++++++++++++++++++--------------------------------
 include/elf.h | 10 +++++++++
 lib/elf.c     | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index a02361f9f5..32b7462f92 100644
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
-	int rcode = 0;
+	int rcode = CMD_RET_SUCCESS;
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
+		log_debug("Using ELF header format %s\n",
+				flags.phdr ? "phdr" : "shdr");
 		/* Consume flag. */
 		argc--; argv++;
 	}
@@ -75,17 +63,9 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
-		printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
+		log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
 		flush();
 
 		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
@@ -93,21 +73,27 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	if (!env_get_autostart())
-		return rcode;
-
-	printf("## Starting application at 0x%08lx ...\n", addr);
-	flush();
+	if (env_get_autostart()) {
+		flags.autostart = 1;
+		log_debug("Starting application at 0x%08lx ...\n", addr);
+		flush();
+	}
 
 	/*
 	 * pass address parameter as argv[0] (aka command name),
-	 * and all remaining args
+	 * and all remaining arguments
 	 */
-	rc = do_bootelf_exec((void *)addr, argc, argv);
+	rc = bootelf(addr, flags, argc, argv);
 	if (rc != 0)
-		rcode = 1;
+		rcode = CMD_RET_FAILURE;
 
-	printf("## Application terminated, rc = 0x%lx\n", rc);
+	if (flags.autostart)
+	{
+		if (ENOEXEC == errno)
+			log_err("Invalid ELF image\n");
+		else
+			log_debug("## Application terminated, rc = 0x%lx\n", rc);
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
index 9a794f9cba..dc13935e10 100644
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
@@ -15,6 +16,59 @@
 #include <linux/linkage.h>
 #endif
 
+/**
+ * bootelf_exec() - start the ELF image execution.
+ *
+ * @entry: address of entry point of ELF.
+ *
+ * May by used to allow ports to override the default behavior.
+ */
+unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
+			   int argc, char *const argv[])
+{
+	return entry(argc, argv);
+}
+
+/**
+ * bootelf() - Boot ELF from memory.
+ *
+ * @addr:  Loading address of ELF in memory.
+ * @flags: Bits like ELF_PHDR to control boot details.
+ * @argc: May be used to pass command line arguments (maybe unused).
+ *	  Necessary for backward compatibility with the CLI command.
+ *	  If unused, must be 0.
+ * @argv: see @argc. If unused, must be NULL.
+ * Return: Number returned by ELF application.
+ *
+ * Sets errno = ENOEXEC if the ELF image is not valid.
+ */
+unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
+		      int argc, char *const argv[])
+{
+	unsigned long entry_addr;
+	char *args[] = {"", NULL};
+
+	errno = 0;
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
+	if (!argc && !argv) {
+		argc = 1;
+		argv = args;
+	}
+
+	return bootelf_exec((void *)entry_addr, argc, argv);
+}
+
 /*
  * A very simple ELF64 loader, assumes the image is valid, returns the
  * entry point address.
-- 
2.39.2

