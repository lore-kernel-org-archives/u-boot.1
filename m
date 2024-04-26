Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE4CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 09:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72DC88F35;
	Fri, 26 Apr 2024 11:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRDSVDuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDECC88F35; Fri, 26 Apr 2024 11:11:14 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BD588BEE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 11:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2df848f9325so289481fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714122671; x=1714727471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1/NxGQX06+vC4hJIom+D24zcFY/1/tzvIOc+861b8C8=;
 b=FRDSVDuJgPgcCbLozamRAEDkszF15Eq1YywO4e+qy5QRBr6TCf9ZBys1JAyXpX0mrp
 D3HDvSIoackCDVOcJu7CV8F0GHQupzkADxtPhPlCLii9bp+92AQepODGb2QgLwhZ7YN2
 RJuSE67KNLI1+Yl7uicdVXL1DHw7b3HcrQ3BH/jS89YabNAAui7UK1MZSkFmgB/oTMwD
 DkHyn7qEOhz2Cbdj/5wi9sL1u57npyqGAilotJNe5l1IfddKWVziTB222CU5KovT7fqW
 FaaJZ5VgYhbjCXmThHdQlh201tS9DicwqwbLjISYy1mu8vO5M4WDotWIebjPR9mWO0QK
 gNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714122671; x=1714727471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/NxGQX06+vC4hJIom+D24zcFY/1/tzvIOc+861b8C8=;
 b=jXTp9YnmaZiC9S77uVP6TDq8GsHwYtpJIY1y9VZUbKP6+VZ5Rad1V+JJVr9MqBmxhZ
 lFAOyZnpv/myRDv8gvlm7y1DB8A0JQMbc8FMJPju8F/6DiwLs0ZvHzT/P1yrfeCTieHL
 W2e+l20d+FF5Jnhmc5kz8U1ieJTMZYWCcXK3SpdVQw2w7dwssMvgwmYD1zY2WdUrjuFA
 Se73KluW1a/CvYaM2xcj08QriiKx93xD3DnJFg48etDC+suuuhn3C2wHX3JkfUDB5uZx
 BaZBKJeTQYjbnhgDJR+tCP0HV236TwQtD2UBiIbHKdeLibMwcs+XH6v1By43yA9KgGdM
 0O9g==
X-Gm-Message-State: AOJu0YzwVz5QTh9Jh07F/GQ5WEuhmEeg0B+sLUF4f57TCDGlxd6B60aK
 2A4BllPBd9ECTEFaa0vOTp/Gc35hJ8qQpoLxapkSsn0v9MyTcpouCYOMUg==
X-Google-Smtp-Source: AGHT+IET9GAe3fFJpDbFS2s4pvMQGnAAPFBfYhHaudZQa0k5Ak3NZjkLuYsNoAYpAFr2mN+j8yvK8w==
X-Received: by 2002:a2e:8348:0:b0:2df:49b:27f1 with SMTP id
 l8-20020a2e8348000000b002df049b27f1mr1288832ljh.4.1714122671212; 
 Fri, 26 Apr 2024 02:11:11 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:28a:c024:f9e9:89d9:4998:675d])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a2e9b09000000b002dcdeb98653sm2187842lji.8.2024.04.26.02.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 02:11:10 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, quentin.schulz@theobroma-systems.com
Cc: Maxim.Moskalets@kaspersky.com,
	Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] cmd: move ELF load and boot to lib/elf.c
Date: Fri, 26 Apr 2024 12:11:02 +0300
Message-Id: <20240426091102.50350-1-Maxim.Moskalets@kaspersky.com>
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

Loading and running the ELF image is the responsibility of the
library and should not be associated with the command line interface.

It is also required to run ELF images from FIT with the bootm command
so as not to depend on the command line interface.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 cmd/elf.c     | 49 +++++++++++++++++--------------------------------
 include/elf.h | 10 ++++++++++
 lib/elf.c     | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index df4354d374..8bbdc67db7 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -20,21 +20,6 @@
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
@@ -44,8 +29,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 #endif
 	unsigned long addr; /* Address of the ELF image */
 	unsigned long rc; /* Return value from user code */
-	char *sload = NULL;
 	int rcode = 0;
+	Bootelf_flags flags = {0};
 
 	/* Consume 'bootelf' */
 	argc--; argv++;
@@ -53,7 +38,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
@@ -76,14 +64,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
@@ -94,21 +74,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
index 9a794f9cba..0f3d752758 100644
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
@@ -15,6 +16,41 @@
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
+ * Boot ELF from memory
+ *
+ * addr       - loading address of ELF in memory
+ * flags      - bits like ELF_PHDR to control boot details
+ * argc, argv - may be used to pass command line arguments (maybe unused)
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

