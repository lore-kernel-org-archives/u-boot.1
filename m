Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F4EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00A48789F;
	Mon,  4 Dec 2023 01:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P7a5rE01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AAB87655; Mon,  4 Dec 2023 01:30:15 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C9687896
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ce477b6298so58034b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649802; x=1702254602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//ZVYjMFFHgkoRWp1GxW2uwGAG3eXtm0eOVULezfixU=;
 b=P7a5rE01UrLBwaJM5CFP7bcBVdRmZHkrZ5dN4OiSHKn+uozxiku/R6JqCZFTtMSsMS
 Mv+9j0FUhBv6myCqcBaJsP6h1h+jXit/UryR0QVDN4JAHb5RWIcvoLFL0KXdduT5KnPx
 QZTrKr3qNEnwk9E1J14fRrj1bRe8/J84+nm6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649802; x=1702254602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//ZVYjMFFHgkoRWp1GxW2uwGAG3eXtm0eOVULezfixU=;
 b=IruVAxOaMKoO3awKk1xLe2774USYzWaSRLIV+f9NLw1eyR7VlbKErhQ+3efxETfREc
 6zlI44jFIjDRd5UmbxPoo+vyRFLH7zF07wGJayows2InpTnMlNnZwnjteGiUaOjt9EAk
 4laSIX3zAz0t5S0c81zXYe8gPNrugdAaPt+hldt611Q1iL7UGu6k5Mn3P3NDxZBquA5A
 /LeztLleoZNp9oefREZicUAeOU0MGdrcnHObD+IiyWEA9oFuoCFgEncx6aO0pVJUFss3
 Hat6PY+rjfqKc4narbj3HZfL+8RCF4FZm72iCveaHV7uF0BIQ5wlj7tmsmZwU3D6mlQc
 Az0A==
X-Gm-Message-State: AOJu0YwZlQ554Q41WTX6q2/bgZrFkg/FOkjUpRt+pY25jkKA27VTwHIS
 RHi/974gaasuXPBaZu3FCg7AoTKI3YpQ9IQHUx36PQ==
X-Google-Smtp-Source: AGHT+IGxuAzeT28voXgbzmVDeUdosIlhJpLMMuYgZP0u1I7FLsqnOuGOQhJT2zm9uzI+sREbiC1F7A==
X-Received: by 2002:aa7:9f0e:0:b0:6ce:4ebe:704b with SMTP id
 g14-20020aa79f0e000000b006ce4ebe704bmr386448pfr.33.1701649802068; 
 Sun, 03 Dec 2023 16:30:02 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 02/13] x86: zboot: Move command code into its own file
Date: Sun,  3 Dec 2023 17:29:27 -0700
Message-ID: <20231204002944.897949-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Much of the code in zimage.c deals with the zboot command. Move it into
a sepatate zboot.c file within the cmd/ directory. This will eventually
allow use of the zimage logic without the command being enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h |  31 ++++++
 arch/x86/lib/zimage.c         | 199 +--------------------------------
 cmd/x86/Makefile              |   1 +
 cmd/x86/zboot.c               | 203 ++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+), 195 deletions(-)
 create mode 100644 cmd/x86/zboot.c

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index a91cfb2b8dd0..ac6683ea9ef3 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -71,6 +71,37 @@ struct zboot_state {
 
 extern struct zboot_state state;
 
+/**
+ * zimage_dump() - Dump information about a zimage
+ *
+ * @base_ptr: Pointer to the boot parameters
+ * @show_cmdline: true to show the kernel command line
+ */
+void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
+
+/**
+ * zboot_load() - Load a zimage
+ *
+ * Load the zimage into the correct place
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int zboot_load(void);
+
+/**
+ * zboot_setup() - Set up the zboot image reeady for booting
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int zboot_setup(void);
+
+/**
+ * zboot_go() - Start the image
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int zboot_go(void);
+
 /**
  * load_zimage() - Load a zImage or bzImage
  *
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index b04d39b36dd4..1d1249fc25ac 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,6 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define COMMAND_LINE_SIZE	2048
 
+/* Current state of the boot */
 struct zboot_state state;
 
 static void build_command_line(char *command_line, int auto_boot)
@@ -366,54 +367,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 	return 0;
 }
 
-static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
-{
-	const char *s;
-
-	memset(&state, '\0', sizeof(state));
-	if (argc >= 2) {
-		/* argv[1] holds the address of the bzImage */
-		s = argv[1];
-	} else {
-		s = env_get("fileaddr");
-	}
-
-	if (s)
-		state.bzimage_addr = hextoul(s, NULL);
-
-	if (argc >= 3) {
-		/* argv[2] holds the size of the bzImage */
-		state.bzimage_size = hextoul(argv[2], NULL);
-	}
-
-	if (argc >= 4)
-		state.initrd_addr = hextoul(argv[3], NULL);
-	if (argc >= 5)
-		state.initrd_size = hextoul(argv[4], NULL);
-	if (argc >= 6) {
-		/*
-		 * When the base_ptr is passed in, we assume that the image is
-		 * already loaded at the address given by argv[1] and therefore
-		 * the original bzImage is somewhere else, or not accessible.
-		 * In any case, we don't need access to the bzImage since all
-		 * the processing is assumed to be done.
-		 *
-		 * So set the base_ptr to the given address, use this arg as the
-		 * load address and set bzimage_addr to 0 so we know that it
-		 * cannot be proceesed (or processed again).
-		 */
-		state.base_ptr = (void *)hextoul(argv[5], NULL);
-		state.load_address = state.bzimage_addr;
-		state.bzimage_addr = 0;
-	}
-	if (argc >= 7)
-		state.cmdline = env_get(argv[6]);
-
-	return 0;
-}
-
-static int zboot_load(void)
+int zboot_load(void)
 {
 	struct boot_params *base_ptr;
 
@@ -438,20 +392,7 @@ static int zboot_load(void)
 	return 0;
 }
 
-static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
-{
-	if (zboot_load())
-		return CMD_RET_FAILURE;
-
-	if (env_set_hex("zbootbase", map_to_sysmem(state.base_ptr)) ||
-	    env_set_hex("zbootaddr", state.load_address))
-		return CMD_RET_FAILURE;
-
-	return 0;
-}
-
-static int zboot_setup(void)
+int zboot_setup(void)
 {
 	struct boot_params *base_ptr = state.base_ptr;
 	int ret;
@@ -465,33 +406,7 @@ static int zboot_setup(void)
 	return 0;
 }
 
-static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
-			  char *const argv[])
-{
-	struct boot_params *base_ptr = state.base_ptr;
-
-	if (!base_ptr) {
-		printf("base is not set: use 'zboot load' first\n");
-		return CMD_RET_FAILURE;
-	}
-	if (zboot_setup()) {
-		puts("Setting up boot parameters failed ...\n");
-		return CMD_RET_FAILURE;
-	}
-
-	return 0;
-}
-
-static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
-{
-	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       state.load_address, state.base_ptr);
-
-	return 0;
-}
-
-static int zboot_go(void)
+int zboot_go(void)
 {
 	struct boot_params *params = state.base_ptr;
 	struct setup_header *hdr = &params->hdr;
@@ -515,17 +430,6 @@ static int zboot_go(void)
 	return ret;
 }
 
-static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
-{
-	int ret;
-
-	ret = zboot_go();
-	printf("Kernel returned! (err=%d)\n", ret);
-
-	return CMD_RET_FAILURE;
-}
-
 int zboot_start(ulong addr, ulong size, ulong initrd, ulong initrd_size,
 		ulong base, char *cmdline)
 {
@@ -741,98 +645,3 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	if (get_boot_protocol(hdr, false) >= 0x215)
 		print_num("Kernel info offset", hdr->kernel_info_offset);
 }
-
-static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
-{
-	struct boot_params *base_ptr = state.base_ptr;
-
-	if (argc > 1)
-		base_ptr = (void *)hextoul(argv[1], NULL);
-	if (!base_ptr) {
-		printf("No zboot setup_base\n");
-		return CMD_RET_FAILURE;
-	}
-	zimage_dump(base_ptr, true);
-
-	return 0;
-}
-
-/* Note: This defines the complete_zboot() function */
-U_BOOT_SUBCMDS(zboot,
-	U_BOOT_CMD_MKENT(start, 8, 1, do_zboot_start, "", ""),
-	U_BOOT_CMD_MKENT(load, 1, 1, do_zboot_load, "", ""),
-	U_BOOT_CMD_MKENT(setup, 1, 1, do_zboot_setup, "", ""),
-	U_BOOT_CMD_MKENT(info, 1, 1, do_zboot_info, "", ""),
-	U_BOOT_CMD_MKENT(go, 1, 1, do_zboot_go, "", ""),
-	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
-)
-
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
-{
-	int i;
-
-	for (i = 0; i < ZBOOT_STATE_COUNT; i++) {
-		struct cmd_tbl *cmd = &zboot_subcmds[i];
-		int mask = 1 << i;
-		int ret;
-
-		if (mask & state_mask) {
-			ret = cmd->cmd(cmd, flag, argc, argv);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-int do_zboot_parent(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int *repeatable)
-{
-	/* determine if we have a sub command */
-	if (argc > 1) {
-		char *endp;
-
-		hextoul(argv[1], &endp);
-		/*
-		 * endp pointing to nul means that argv[1] was just a valid
-		 * number, so pass it along to the normal processing
-		 */
-		if (*endp)
-			return do_zboot(cmdtp, flag, argc, argv, repeatable);
-	}
-
-	do_zboot_states(cmdtp, flag, argc, argv, ZBOOT_STATE_START |
-			ZBOOT_STATE_LOAD | ZBOOT_STATE_SETUP |
-			ZBOOT_STATE_INFO | ZBOOT_STATE_GO);
-
-	return CMD_RET_FAILURE;
-}
-
-U_BOOT_CMDREP_COMPLETE(
-	zboot, 8, do_zboot_parent, "Boot bzImage",
-	"[addr] [size] [initrd addr] [initrd size] [setup] [cmdline]\n"
-	"      addr -        The optional starting address of the bzimage.\n"
-	"                    If not set it defaults to the environment\n"
-	"                    variable \"fileaddr\".\n"
-	"      size -        The optional size of the bzimage. Defaults to\n"
-	"                    zero.\n"
-	"      initrd addr - The address of the initrd image to use, if any.\n"
-	"      initrd size - The size of the initrd image to use, if any.\n"
-	"      setup -       The address of the kernel setup region, if this\n"
-	"                    is not at addr\n"
-	"      cmdline -     Environment variable containing the kernel\n"
-	"                    command line, to override U-Boot's normal\n"
-	"                    cmdline generation\n"
-	"\n"
-	"Sub-commands to do part of the zboot sequence:\n"
-	"\tstart [addr [arg ...]] - specify arguments\n"
-	"\tload   - load OS image\n"
-	"\tsetup  - set up table\n"
-	"\tinfo   - show summary info\n"
-	"\tgo     - start OS\n"
-	"\tdump [addr]    - dump info (optional address of boot params)",
-	complete_zboot
-);
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f82204c87e6..b1f39d3bfde5 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -5,3 +5,4 @@ obj-y += mtrr.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_USE_HOB) += hob.o
 obj-$(CONFIG_HAVE_FSP) += fsp.o
+obj-$(CONFIG_CMD_ZBOOT) += zboot.o
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
new file mode 100644
index 000000000000..c9375fb417c1
--- /dev/null
+++ b/cmd/x86/zboot.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2011 The Chromium OS Authors.
+ * (C) Copyright 2002
+ * Daniel Engström, Omicron Ceti AB, <daniel@omicron.se>
+ */
+
+#include <command.h>
+#include <mapmem.h>
+#include <vsprintf.h>
+#include <asm/zimage.h>
+
+static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	const char *s;
+
+	memset(&state, '\0', sizeof(state));
+	if (argc >= 2) {
+		/* argv[1] holds the address of the bzImage */
+		s = argv[1];
+	} else {
+		s = env_get("fileaddr");
+	}
+
+	if (s)
+		state.bzimage_addr = hextoul(s, NULL);
+
+	if (argc >= 3) {
+		/* argv[2] holds the size of the bzImage */
+		state.bzimage_size = hextoul(argv[2], NULL);
+	}
+
+	if (argc >= 4)
+		state.initrd_addr = hextoul(argv[3], NULL);
+	if (argc >= 5)
+		state.initrd_size = hextoul(argv[4], NULL);
+	if (argc >= 6) {
+		/*
+		 * When the base_ptr is passed in, we assume that the image is
+		 * already loaded at the address given by argv[1] and therefore
+		 * the original bzImage is somewhere else, or not accessible.
+		 * In any case, we don't need access to the bzImage since all
+		 * the processing is assumed to be done.
+		 *
+		 * So set the base_ptr to the given address, use this arg as the
+		 * load address and set bzimage_addr to 0 so we know that it
+		 * cannot be proceesed (or processed again).
+		 */
+		state.base_ptr = (void *)hextoul(argv[5], NULL);
+		state.load_address = state.bzimage_addr;
+		state.bzimage_addr = 0;
+	}
+	if (argc >= 7)
+		state.cmdline = env_get(argv[6]);
+
+	return 0;
+}
+
+static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	if (zboot_load())
+		return CMD_RET_FAILURE;
+
+	if (env_set_hex("zbootbase", map_to_sysmem(state.base_ptr)) ||
+	    env_set_hex("zbootaddr", state.load_address))
+		return CMD_RET_FAILURE;
+
+	return 0;
+}
+
+static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct boot_params *base_ptr = state.base_ptr;
+
+	if (!base_ptr) {
+		printf("base is not set: use 'zboot load' first\n");
+		return CMD_RET_FAILURE;
+	}
+	if (zboot_setup()) {
+		puts("Setting up boot parameters failed ...\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	printf("Kernel loaded at %08lx, setup_base=%p\n",
+	       state.load_address, state.base_ptr);
+
+	return 0;
+}
+
+static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	int ret;
+
+	ret = zboot_go();
+	printf("Kernel returned! (err=%d)\n", ret);
+
+	return CMD_RET_FAILURE;
+}
+
+static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	struct boot_params *base_ptr = state.base_ptr;
+
+	if (argc > 1)
+		base_ptr = (void *)hextoul(argv[1], NULL);
+	if (!base_ptr) {
+		printf("No zboot setup_base\n");
+		return CMD_RET_FAILURE;
+	}
+	zimage_dump(base_ptr, true);
+
+	return 0;
+}
+
+/* Note: This defines the complete_zboot() function */
+U_BOOT_SUBCMDS(zboot,
+	U_BOOT_CMD_MKENT(start, 8, 1, do_zboot_start, "", ""),
+	U_BOOT_CMD_MKENT(load, 1, 1, do_zboot_load, "", ""),
+	U_BOOT_CMD_MKENT(setup, 1, 1, do_zboot_setup, "", ""),
+	U_BOOT_CMD_MKENT(info, 1, 1, do_zboot_info, "", ""),
+	U_BOOT_CMD_MKENT(go, 1, 1, do_zboot_go, "", ""),
+	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
+)
+
+int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[], int state_mask)
+{
+	int i;
+
+	for (i = 0; i < ZBOOT_STATE_COUNT; i++) {
+		struct cmd_tbl *cmd = &zboot_subcmds[i];
+		int mask = 1 << i;
+		int ret;
+
+		if (mask & state_mask) {
+			ret = cmd->cmd(cmd, flag, argc, argv);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+int do_zboot_parent(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[], int *repeatable)
+{
+	/* determine if we have a sub command */
+	if (argc > 1) {
+		char *endp;
+
+		hextoul(argv[1], &endp);
+		/*
+		 * endp pointing to nul means that argv[1] was just a valid
+		 * number, so pass it along to the normal processing
+		 */
+		if (*endp)
+			return do_zboot(cmdtp, flag, argc, argv, repeatable);
+	}
+
+	do_zboot_states(cmdtp, flag, argc, argv, ZBOOT_STATE_START |
+			ZBOOT_STATE_LOAD | ZBOOT_STATE_SETUP |
+			ZBOOT_STATE_INFO | ZBOOT_STATE_GO);
+
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMDREP_COMPLETE(
+	zboot, 8, do_zboot_parent, "Boot bzImage",
+	"[addr] [size] [initrd addr] [initrd size] [setup] [cmdline]\n"
+	"      addr -        The optional starting address of the bzimage.\n"
+	"                    If not set it defaults to the environment\n"
+	"                    variable \"fileaddr\".\n"
+	"      size -        The optional size of the bzimage. Defaults to\n"
+	"                    zero.\n"
+	"      initrd addr - The address of the initrd image to use, if any.\n"
+	"      initrd size - The size of the initrd image to use, if any.\n"
+	"      setup -       The address of the kernel setup region, if this\n"
+	"                    is not at addr\n"
+	"      cmdline -     Environment variable containing the kernel\n"
+	"                    command line, to override U-Boot's normal\n"
+	"                    cmdline generation\n"
+	"\n"
+	"Sub-commands to do part of the zboot sequence:\n"
+	"\tstart [addr [arg ...]] - specify arguments\n"
+	"\tload   - load OS image\n"
+	"\tsetup  - set up table\n"
+	"\tinfo   - show summary info\n"
+	"\tgo     - start OS\n"
+	"\tdump [addr]    - dump info (optional address of boot params)",
+	complete_zboot
+);
-- 
2.43.0.rc2.451.g8631bc7472-goog

