Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EEFC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F3087C87;
	Sat, 16 Dec 2023 04:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mX5XHAIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2612487B52; Sat, 16 Dec 2023 04:15:21 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9AE87C33
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35f71436397so8300095ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696516; x=1703301316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ6KpdkMvnyjMd30svqgukV1Q/Li6M8HGsCUCVgL1iY=;
 b=mX5XHAIilQuSjjw98fAk1kfEMS+tomQ6S52FfGeWrdDq9AG8gM0YSR1/DNqY0MqIp1
 ze5LoonwajBuyDtaxoZC1FIbgMHmEvN//9PzYqeGQAu2gJBThiwgf7kz1wQEqQdjLLTW
 QpxPfEI0Ffp2hrOR3esFtbSoENMIDuA/EJb1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696516; x=1703301316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ6KpdkMvnyjMd30svqgukV1Q/Li6M8HGsCUCVgL1iY=;
 b=GHR9rfVF882Fm1ldIzRJbkUiyqyIkryBnPbcu5RvvnNYN4aaq8AoclXNP9LDt+GvPl
 38fZeP9lo0THCqJO68rVs1U5fWiUnioMvVCHq4rRuGP4DG8tW1OUFMTA8Fz6ZvUFELRU
 Zbu8xmi/5yFqJUh2MTHsD6Xzgj30y6v94kdKKpkXedXuSnmk/O2V1c9Kbx1Ne+FOius+
 GV628n1eaZSS5gApbg+/G6RineGNE6k6lI/Ga2J3vmML1QmykKAoyyEBbniwio5FV9mD
 498ZDbYPfVpxvMc4Lr/TLELHyjBAcgwHzgnoR4cTL/ahO4Iml23fvfMv3IyGyIsnlsvZ
 WlwQ==
X-Gm-Message-State: AOJu0YwZ410cubkB7hZdFoIszZP8RhNf8CEzUy5pKfBeGI7rt5fS/BwL
 0cLcp8gZF/K63KMCGTPWeyL2+ot3/od50O/MX4wipQ==
X-Google-Smtp-Source: AGHT+IFGxrT7eFNSbaD1J/kddg8vR7hcrUl3XBPMoP6GHiRA2Fzglw9QSP4kwtIekSjL0iRZo9UXrw==
X-Received: by 2002:a05:6e02:1b8d:b0:35f:690b:d425 with SMTP id
 h13-20020a056e021b8d00b0035f690bd425mr8060965ili.65.1702696516004; 
 Fri, 15 Dec 2023 19:15:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Rick Chen <rick@andestech.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Thomas Chou <thomas@wytron.com.tw>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 09/22] bootm: Adjust arguments of boot_os_fn
Date: Fri, 15 Dec 2023 20:14:13 -0700
Message-ID: <20231216031446.2222362-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

Adjust boot_os_fn to use struct bootm_info instead of the separate
argc, argv and image parameters. Update the handlers accordingly. Few
of the functions make use of the arguments, so this improves code size
slightly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Split changing of boot_os_fn parameters to a separate patch

 arch/arc/lib/bootm.c        |  5 ++-
 arch/arm/lib/bootm.c        |  6 ++-
 arch/m68k/lib/bootm.c       |  5 ++-
 arch/microblaze/lib/bootm.c |  6 ++-
 arch/mips/lib/bootm.c       |  6 ++-
 arch/nios2/lib/bootm.c      | 10 +++--
 arch/powerpc/lib/bootm.c    |  5 ++-
 arch/riscv/lib/bootm.c      | 11 +++---
 arch/sandbox/lib/bootm.c    |  5 ++-
 arch/sh/lib/bootm.c         |  6 ++-
 arch/x86/lib/bootm.c        |  6 ++-
 arch/xtensa/lib/bootm.c     |  4 +-
 boot/bootm.c                | 11 ++++--
 boot/bootm_os.c             | 77 ++++++++++++++++++++-----------------
 include/bootm.h             |  9 +----
 15 files changed, 100 insertions(+), 72 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 44ec5864a1c6..b143392ee6c2 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2013-2014 Synopsys, Inc. All rights reserved.
  */
 
+#include <bootm.h>
 #include <bootstage.h>
 #include <env.h>
 #include <image.h>
@@ -78,8 +79,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 		board_jump_and_run(kernel_entry, r0, 0, r2);
 }
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* No need for those on ARC */
 	if ((flag & BOOTM_STATE_OS_BD_T) || (flag & BOOTM_STATE_OS_CMDLINE))
 		return -1;
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index c56285738a26..f30a483ed8b4 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -12,6 +12,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
@@ -378,9 +379,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
  * DIFFERENCE: Instead of calling prep and go at the end
  * they are called if subcommand is equal 0.
  */
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* No need for those on ARM */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
 		return -1;
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 79d8b34c0d56..f2d02e437658 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -4,6 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
 #include <env.h>
@@ -34,9 +35,9 @@ void arch_lmb_reserve(struct lmb *lmb)
 	arch_lmb_reserve_generic(lmb, get_sp(), gd->ram_top, 1024);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	int ret;
 	struct bd_info  *kbd;
 	void  (*kernel) (struct bd_info *, ulong, ulong, ulong, ulong);
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index f3ec4b741b88..cbe9d85aa911 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -7,6 +7,7 @@
  * Yasushi SHOJI <yashi@atmark-techno.com>
  */
 
+#include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
@@ -81,9 +82,10 @@ static void boot_prep_linux(struct bootm_headers *images)
 	}
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	images->cmdline_start = (ulong)env_get("bootargs");
 
 	/* cmdline init is the part of 'prep' and nothing to do for 'bdt' */
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index f1cff691f4fe..286dbd5c4581 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -4,6 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <bootm.h>
 #include <bootstage.h>
 #include <env.h>
 #include <image.h>
@@ -300,9 +301,10 @@ static void boot_jump_linux(struct bootm_headers *images)
 			linux_extra);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* No need for those on MIPS */
 	if (flag & BOOTM_STATE_OS_BD_T)
 		return -1;
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 06c094d0f1c7..657a17c7204f 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <image.h>
@@ -16,9 +17,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*kernel)(int, int, int, char *) = (void *)images->ep;
 	char *commandline = env_get("bootargs");
 	ulong initrd_start = images->rd_start;
@@ -29,8 +30,9 @@ int do_bootm_linux(int flag, int argc, char *const argv[],
 	if (images->ft_len)
 		of_flat_tree = images->ft_addr;
 #endif
-	if (!of_flat_tree && argc > 1)
-		of_flat_tree = (char *)hextoul(argv[1], NULL);
+	/* TODO: Clean this up - the DT should already be set up */
+	if (!of_flat_tree && bmi->argc > 1)
+		of_flat_tree = (char *)hextoul(bmi->argv[1], NULL);
 	if (of_flat_tree)
 		initrd_end = (ulong)of_flat_tree;
 
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 910121ec9c85..75c6bfd2bf81 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -8,6 +8,7 @@
 
 
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <env.h>
@@ -223,9 +224,9 @@ static int boot_body_linux(struct bootm_headers *images)
 	return 0;
 }
 
-noinline int do_bootm_linux(int flag, int argc, char *const argv[],
-			    struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	int	ret;
 
 	if (flag & BOOTM_STATE_OS_CMDLINE) {
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index f9e1e18ae026..13cbaaba6820 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -7,6 +7,7 @@
  */
 
 #include <bootstage.h>
+#include <bootm.h>
 #include <command.h>
 #include <dm.h>
 #include <fdt_support.h>
@@ -105,9 +106,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	}
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* No need for those on RISC-V */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
 		return -1;
@@ -127,10 +129,9 @@ int do_bootm_linux(int flag, int argc, char *const argv[],
 	return 0;
 }
 
-int do_bootm_vxworks(int flag, int argc, char *const argv[],
-		     struct bootm_headers *images)
+int do_bootm_vxworks(int flag, struct bootm_info *bmi)
 {
-	return do_bootm_linux(flag, argc, argv, images);
+	return do_bootm_linux(flag, bmi);
 }
 
 static ulong get_sp(void)
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index a748ba650b12..e56de90e75b8 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <image.h>
 #include <asm/io.h>
@@ -64,8 +65,10 @@ static int boot_prep_linux(struct bootm_headers *images)
 	return 0;
 }
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	if (flag & BOOTM_STATE_OS_PREP)
 		return boot_prep_linux(images);
 
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index b205e5e3db1b..05d586b1b6ce 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <command.h>
 #include <env.h>
 #include <image.h>
@@ -39,9 +40,10 @@ static unsigned long sh_check_cmd_arg(char *cmdline, char *key, int base)
 	return val;
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* Linux kernel load address */
 	void (*kernel) (void) = (void (*)(void))images->ep;
 	/* empty_zero_page */
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 3196f9ddc2c8..050c420e86b6 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
 #include <efi.h>
@@ -237,9 +238,10 @@ static int boot_jump_linux(struct bootm_headers *images)
 				 images->os.arch == IH_ARCH_X86_64);
 }
 
-int do_bootm_linux(int flag, int argc, char *const argv[],
-		   struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	/* No need for those on x86 */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
 		return -1;
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index fee339281502..9780d46e9b89 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
 #include <cpu_func.h>
@@ -134,8 +135,9 @@ static struct bp_tag *setup_fdt_tag(struct bp_tag *params, void *fdt_start)
  * Boot Linux.
  */
 
-int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *images)
+int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	struct bp_tag *params, *params_start;
 	ulong initrd_start, initrd_end;
 	char *commandline = env_get("bootargs");
diff --git a/boot/bootm.c b/boot/bootm.c
index 8a0dba5074e8..f1c45c380659 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -6,6 +6,7 @@
 
 #ifndef USE_HOSTCC
 #include <common.h>
+#include <bootm.h>
 #include <bootstage.h>
 #include <cli.h>
 #include <command.h>
@@ -1018,6 +1019,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int states, struct bootm_headers *images,
 		    int boot_progress)
 {
+	struct bootm_info bmi;
 	boot_os_fn *boot_fn;
 	ulong iflag = 0;
 	int ret = 0, need_boot_fn;
@@ -1096,12 +1098,15 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		return 1;
 	}
 
+	bmi.images = images;
+	bmi.argc = argc;
+	bmi.argv = argv;
 
 	/* Call various other states that are not generally used */
 	if (!ret && (states & BOOTM_STATE_OS_CMDLINE))
-		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_CMDLINE, &bmi);
 	if (!ret && (states & BOOTM_STATE_OS_BD_T))
-		ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_BD_T, &bmi);
 	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
 		ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
 		if (ret) {
@@ -1109,7 +1114,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = CMD_RET_FAILURE;
 			goto err;
 		}
-		ret = boot_fn(BOOTM_STATE_OS_PREP, argc, argv, images);
+		ret = boot_fn(BOOTM_STATE_OS_PREP, &bmi);
 	}
 
 #ifdef CONFIG_TRACE
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index b92422171a84..4f547b1b1148 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -23,9 +23,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static int do_bootm_standalone(int flag, int argc, char *const argv[],
-			       struct bootm_headers *images)
+static int do_bootm_standalone(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	int (*appl)(int, char *const[]);
 
 	if (!env_get_autostart()) {
@@ -33,7 +33,7 @@ static int do_bootm_standalone(int flag, int argc, char *const argv[],
 		return 0;
 	}
 	appl = (int (*)(int, char * const []))images->ep;
-	appl(argc, argv);
+	appl(bmi->argc, bmi->argv);
 	return 0;
 }
 
@@ -64,9 +64,9 @@ static void __maybe_unused fit_unsupported_reset(const char *msg)
 }
 
 #ifdef CONFIG_BOOTM_NETBSD
-static int do_bootm_netbsd(int flag, int argc, char *const argv[],
-			   struct bootm_headers *images)
+static int do_bootm_netbsd(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*loader)(struct bd_info *bd, struct legacy_img_hdr *hdr,
 		       char *console, char *cmdline);
 	struct legacy_img_hdr *os_hdr, *hdr;
@@ -102,14 +102,14 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
 			os_hdr = hdr;
 	}
 
-	if (argc > 0) {
+	if (bmi->argc > 0) {
 		ulong len;
 		int   i;
 
-		for (i = 0, len = 0; i < argc; i += 1)
-			len += strlen(argv[i]) + 1;
+		for (i = 0, len = 0; i < bmi->argc; i += 1)
+			len += strlen(bmi->argv[i]) + 1;
 		cmdline = malloc(len);
-		copy_args(cmdline, argc, argv, ' ');
+		copy_args(cmdline, bmi->argc, bmi->argv, ' ');
 	} else {
 		cmdline = env_get("bootargs");
 		if (cmdline == NULL)
@@ -137,9 +137,9 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_NETBSD*/
 
 #ifdef CONFIG_BOOTM_RTEMS
-static int do_bootm_rtems(int flag, int argc, char *const argv[],
-			  struct bootm_headers *images)
+static int do_bootm_rtems(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(struct bd_info *);
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -170,9 +170,9 @@ static int do_bootm_rtems(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_RTEMS */
 
 #if defined(CONFIG_BOOTM_OSE)
-static int do_bootm_ose(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_ose(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -203,9 +203,9 @@ static int do_bootm_ose(int flag, int argc, char *const argv[],
 #endif /* CONFIG_BOOTM_OSE */
 
 #if defined(CONFIG_BOOTM_PLAN9)
-static int do_bootm_plan9(int flag, int argc, char *const argv[],
-			  struct bootm_headers *images)
+static int do_bootm_plan9(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 	char *s;
 
@@ -224,8 +224,8 @@ static int do_bootm_plan9(int flag, int argc, char *const argv[],
 	if (s != NULL) {
 		char *confaddr = (char *)hextoul(s, NULL);
 
-		if (argc > 0) {
-			copy_args(confaddr, argc, argv, '\n');
+		if (bmi->argc) {
+			copy_args(confaddr, bmi->argc, bmi->argv, '\n');
 		} else {
 			s = env_get("bootargs");
 			if (s != NULL)
@@ -311,9 +311,10 @@ static void do_bootvx_fdt(struct bootm_headers *images)
 	puts("## vxWorks terminated\n");
 }
 
-static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
-				   struct bootm_headers *images)
+static int do_bootm_vxworks_legacy(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
+
 	if (flag != BOOTM_STATE_OS_GO)
 		return 0;
 
@@ -322,8 +323,7 @@ static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
 	return 1;
 }
 
-int do_bootm_vxworks(int flag, int argc, char *const argv[],
-		     struct bootm_headers *images)
+int do_bootm_vxworks(int flag, struct bootm_info *bmi)
 {
 	char *bootargs;
 	int pos;
@@ -348,19 +348,19 @@ int do_bootm_vxworks(int flag, int argc, char *const argv[],
 	if (std_dtb) {
 		if (flag & BOOTM_STATE_OS_PREP)
 			printf("   Using standard DTB\n");
-		return do_bootm_linux(flag, argc, argv, images);
+		return do_bootm_linux(flag, bmi);
 	} else {
 		if (flag & BOOTM_STATE_OS_PREP)
 			printf("   !!! WARNING !!! Using legacy DTB\n");
-		return do_bootm_vxworks_legacy(flag, argc, argv, images);
+		return do_bootm_vxworks_legacy(flag, bmi);
 	}
 }
 #endif
 
 #if defined(CONFIG_CMD_ELF)
-static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
-			   struct bootm_headers *images)
+static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	char *local_args[2];
 	char str[16];
 	int dcache;
@@ -376,7 +376,7 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 #endif
 
 	sprintf(str, "%lx", images->ep); /* write entry-point into string */
-	local_args[0] = argv[0];
+	local_args[0] = bmi->argv[0];
 	local_args[1] = str;	/* and provide it via the arguments */
 
 	/*
@@ -396,9 +396,9 @@ static int do_bootm_qnxelf(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_INTEGRITY
-static int do_bootm_integrity(int flag, int argc, char *const argv[],
-			      struct bootm_headers *images)
+static int do_bootm_integrity(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -429,9 +429,9 @@ static int do_bootm_integrity(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_BOOTM_OPENRTOS
-static int do_bootm_openrtos(int flag, int argc, char *const argv[],
-			     struct bootm_headers *images)
+static int do_bootm_openrtos(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	void (*entry_point)(void);
 
 	if (flag != BOOTM_STATE_OS_GO)
@@ -455,9 +455,9 @@ static int do_bootm_openrtos(int flag, int argc, char *const argv[],
 #endif
 
 #ifdef CONFIG_BOOTM_OPTEE
-static int do_bootm_tee(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_tee(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	int ret;
 
 	/* Validate OPTEE header */
@@ -468,14 +468,14 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 		return ret;
 
 	/* From here we can run the regular linux boot path */
-	return do_bootm_linux(flag, argc, argv, images);
+	return do_bootm_linux(flag, bmi);
 }
 #endif
 
 #ifdef CONFIG_BOOTM_EFI
-static int do_bootm_efi(int flag, int argc, char *const argv[],
-			struct bootm_headers *images)
+static int do_bootm_efi(int flag, struct bootm_info *bmi)
 {
+	struct bootm_headers *images = bmi->images;
 	efi_status_t efi_ret;
 	void *image_buf;
 
@@ -569,9 +569,14 @@ __weak void board_preboot_os(void)
 int boot_selected_os(int argc, char *const argv[], int state,
 		     struct bootm_headers *images, boot_os_fn *boot_fn)
 {
+	struct bootm_info bmi;
 	arch_preboot_os();
 	board_preboot_os();
-	boot_fn(state, argc, argv, images);
+
+	bmi.argc = argc;
+	bmi.argv = argv;
+	bmi.images = images;
+	boot_fn(state, &bmi);
 
 	/* Stand-alone may return when 'autostart' is 'no' */
 	if (images->os.type == IH_TYPE_STANDALONE ||
diff --git a/include/bootm.h b/include/bootm.h
index a6d5d5ceee8f..85c560d5a0ae 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -39,16 +39,11 @@ struct bootm_info {
  *  - disabled interrupts.
  *
  * @flag: Flags indicating what to do (BOOTM_STATE_...)
- * @argc: Number of arguments. Note that the arguments are shifted down
- *	 so that 0 is the first argument not processed by U-Boot, and
- *	 argc is adjusted accordingly. This avoids confusion as to how
- *	 many arguments are available for the OS.
- * @images: Pointers to os/initrd/fdt
+ * bmi: Bootm information
  * Return: 1 on error. On success the OS boots so this function does
  * not return.
  */
-typedef int boot_os_fn(int flag, int argc, char *const argv[],
-			struct bootm_headers *images);
+typedef int boot_os_fn(int flag, struct bootm_info *bmi);
 
 extern boot_os_fn do_bootm_linux;
 extern boot_os_fn do_bootm_vxworks;
-- 
2.43.0.472.g3155946c3a-goog

