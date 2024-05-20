Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA3AC25B78
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 12:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90601886B2;
	Mon, 20 May 2024 14:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJj4r8Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF052886B4; Mon, 20 May 2024 14:22:33 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FF68869E
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 14:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5238b7d0494so3518918e87.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716207751; x=1716812551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oQSfouEfhX7wzpgRRSAk/tjFaHg+NE6ZA6/rzgbF54k=;
 b=ZJj4r8Z4U9rU7HR2Vkjo2JPqr+iRT4iy1TPE9GdAGPJiQT5j+2TKxPLGhcPgN7jSYt
 Dx1LJ0+2pR/8bOqON65wt5IUCN6vpJBQ6uGVa1xP+fIzmiJgVh7EIVY8GShDhTh6LL78
 csRLXk/EfU4rjmAHfoHj296wM77Q7EIDPgw5mPTzKnEVZkdHrbgvqzyb7xIQyoj4bttu
 z4CTcHNCoBJn1fuZ9Org/5ddGReE2i8O14FdW9dRG2cuqKjV6PBs+3hQ5N4gEfz9W1rX
 vZHBm46urMhQ8g/5bdRdKTdare9Zqw+vomhbjmray9srOkG8r2spT0hezh43z0oIfYRE
 YHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716207751; x=1716812551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQSfouEfhX7wzpgRRSAk/tjFaHg+NE6ZA6/rzgbF54k=;
 b=EBK8h8CP/r3IPh2Q7QaZwUZXuHLVDlJl4zt5HaXGO1tM0v94Qn1Luyz4r0L6mtzvzJ
 nTa793gSW03Jo++wCVuqBJGpvwmCS2sQFSyljSjpuuO5Al4KcYCbOeUH1y69cFQMRWfE
 cOIE41W6wFdmKCUj2mE7Fh87M6sZnpB2pP09/US7O+NBs1Mehfy40rIdSwi+jPJXejA8
 H4qH3t9T6/IdJAzCr5WciGVlUqRkFtqV1VzJPxUTpbKV0MEE30hteJ8KtxhOEQgrXTax
 gBmS026+g4bQUZ4WJyNaJd36aGxcBfAcX3lv41UNfatW0esmoWgBhC8tBo0lpIUKqv4I
 CyVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7BxnNLWSEZ/QHtFz7EHAYWT1D4DdAZhyr0iXE5vW7fwt93GAjVN/1qLImAvkm9PHJxV7y6KqEiN+np0DVSv5W4gPwrg==
X-Gm-Message-State: AOJu0Yz7lB/Jz0BU1/YwhFqaZlNYk9KKCIFmiQ+/W0TK1qKAIRF9LQ3S
 rkL0aoZDSf9MYzz0Vsx4RKciZ/aFv62Mgi/8DhePLPfrrkTAv5k3
X-Google-Smtp-Source: AGHT+IFQmfTqMO4q7GH4bCNv5vPA9WQjZv+eCQq/Dik4qBGLFA18AXSPKkMRtj5CA/lr6H3mj5bx0Q==
X-Received: by 2002:a19:4358:0:b0:521:b42f:2674 with SMTP id
 2adb3069b0e04-52210277c35mr22407309e87.63.1716207750724; 
 Mon, 20 May 2024 05:22:30 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:684:c5c:8eca:3ada:96fe:92ef])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f39d2c8fsm4238985e87.279.2024.05.20.05.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 05:22:30 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: xypron.glpk@gmx.de, quentin.schulz@theobroma-systems.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.denx.de
Cc: Maxim.Moskalets@kaspersky.com,
	maximmosk4@gmail.com
Subject: [PATCH v4] cmd: move ELF load and boot to lib/elf.c
Date: Mon, 20 May 2024 15:22:25 +0300
Message-Id: <20240520122225.43438-1-Maxim.Moskalets@kaspersky.com>
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

