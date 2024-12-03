Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B4E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0148966C;
	Wed,  4 Dec 2024 00:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AvykeSvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EE388F55; Wed,  4 Dec 2024 00:46:28 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4827F89686
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84198253240so225984839f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269584; x=1733874384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoPhzhnTJIgh3cFnLV8Y5mcUSaG4DWjCwt+l8t03jaA=;
 b=AvykeSvIy6PUfgXcey+aWUTpqGRpJAdP6pMS5Odm+HF7dCIdxMzSUk7vqMJ4n5CA+L
 WfhnyNgHiQXvHdrknbdvgtvkrfmI4rd3R0GAdGnwjfvwdjpU8WDCzm8a4KGH9B8ZmFv4
 Kl6C9CzhKY19Ere6D3hwiL/hXB3hcrZj3My2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269584; x=1733874384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoPhzhnTJIgh3cFnLV8Y5mcUSaG4DWjCwt+l8t03jaA=;
 b=uso0Q01mpGvT9K8dE7GhIfFPZ2psqHitHWNqjI9oyizPLIpdex7CGzGVZGBD+sBVov
 7holp/H4gqwW4N7zX/kiqB+H2kAVP2pkJVHs+Fp5W4rxJPxQ9Ll8DB8qMDVFPzGrbNo4
 U0nyf77AHzZRiraDIhiHnXWMrhUQ7Ucnw0rbam8FEHwXzGAm0f4lLhtNSyzjmz0eMk91
 uXONIyAsiHh6dJThRVazxXc1mslXnrXbfAJ4cjjV4sDWt3VQM/0Xs6DNcBj4RNSlV5Od
 JeGNH9OgGdfIgno1uARoKy7xfa0E6dael5wkkBl5lbvIO6jZllOQ3LmwEGsh5PhrDJkT
 vibQ==
X-Gm-Message-State: AOJu0YyHEo9zvs3smhoKYK3JKsuyX9rGKlUi7cvQz0/rNOJh8CBlzte5
 mN+LU90eiZETTgES08rxbEyc8pvLJcRzvesxirp60BwParbOuZWnTXwRDjbAmV+u1oCZAgLe9jE
 =
X-Gm-Gg: ASbGnctqIaX0lVf/eqL7KccCkRBozjRq3inMonQKV5tC4Z/YP52D5cUuVIZFvm8cwP+
 Nno73M7rtymyg9FZtoyWsvZRB7ZA9894MTxHPtRMlC54tUu2YWfKu5kVqcxfldFZCcCZ1VY1lCz
 ZPOfwgZrT0CKRG3kO0o6TaojI7q9qu5IiFza4gTRH/jSp0oSzbyvBYNg2O0HFkf0k6cyisAjLUy
 OsCSb/PGUL4iOFUtqw2rC3O295JLYkPgXW+hLYE9Snley4yvRc0Uf2qSULreePrY6LzHmGtY/h9
 nQo5rC6FSeM=
X-Google-Smtp-Source: AGHT+IHfY9yHmp3j71qG6QrMr3l+GP/hIyepXnnqaeNs5I4v+68+qb70b69+tvxbOgu9gTqGgnMX7g==
X-Received: by 2002:a05:6602:1544:b0:843:e507:3e32 with SMTP id
 ca18e2360f4ac-8445b5e593emr616267239f.13.1733269584109; 
 Tue, 03 Dec 2024 15:46:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 05/41] x86: Rename state to bmi
Date: Tue,  3 Dec 2024 16:45:23 -0700
Message-Id: <20241203234559.2938192-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Use the common name for the struct, in preparation for passing it around
between functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/zimage.c         | 48 +++++++++++++++++------------------
 cmd/x86/zboot.c               |  4 +--
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 13a08850dfb..b592057e58b 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -42,7 +42,7 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-extern struct bootm_info state;
+extern struct bootm_info bmi;
 
 /**
  * zboot_load() - Load a zimage
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index c2cf52658e9..1afd3084144 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,7 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct bootm_info state;
+struct bootm_info bmi;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -371,8 +371,8 @@ int zboot_load(void)
 	struct boot_params *base_ptr;
 	int ret;
 
-	if (state.base_ptr) {
-		struct boot_params *from = (struct boot_params *)state.base_ptr;
+	if (bmi.base_ptr) {
+		struct boot_params *from = (struct boot_params *)bmi.base_ptr;
 
 		base_ptr = (struct boot_params *)DEFAULT_SETUP_BASE;
 		log_debug("Building boot_params at 0x%8.8lx\n",
@@ -380,18 +380,18 @@ int zboot_load(void)
 		memset(base_ptr, '\0', sizeof(*base_ptr));
 		base_ptr->hdr = from->hdr;
 	} else {
-		base_ptr = load_zimage((void *)state.bzimage_addr, state.bzimage_size,
-				       &state.load_address);
+		base_ptr = load_zimage((void *)bmi.bzimage_addr, bmi.bzimage_size,
+				       &bmi.load_address);
 		if (!base_ptr) {
 			puts("## Kernel loading failed ...\n");
 			return -EINVAL;
 		}
 	}
-	state.base_ptr = base_ptr;
+	bmi.base_ptr = base_ptr;
 
-	ret = env_set_hex("zbootbase", map_to_sysmem(state.base_ptr));
+	ret = env_set_hex("zbootbase", map_to_sysmem(bmi.base_ptr));
 	if (!ret)
-		ret = env_set_hex("zbootaddr", state.load_address);
+		ret = env_set_hex("zbootaddr", bmi.load_address);
 	if (ret)
 		return ret;
 
@@ -400,12 +400,12 @@ int zboot_load(void)
 
 int zboot_setup(void)
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 	int ret;
 
 	ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
-			   0, state.initrd_addr, state.initrd_size,
-			   (ulong)state.cmdline);
+			   0, bmi.initrd_addr, bmi.initrd_size,
+			   (ulong)bmi.cmdline);
 	if (ret)
 		return -EINVAL;
 
@@ -414,7 +414,7 @@ int zboot_setup(void)
 
 int zboot_go(void)
 {
-	struct boot_params *params = state.base_ptr;
+	struct boot_params *params = bmi.base_ptr;
 	struct setup_header *hdr = &params->hdr;
 	bool image_64bit;
 	ulong entry;
@@ -422,7 +422,7 @@ int zboot_go(void)
 
 	disable_interrupts();
 
-	entry = state.load_address;
+	entry = bmi.load_address;
 	image_64bit = false;
 	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
@@ -431,7 +431,7 @@ int zboot_go(void)
 	}
 
 	/* we assume that the kernel is in place */
-	ret = boot_linux_kernel((ulong)state.base_ptr, entry, image_64bit);
+	ret = boot_linux_kernel((ulong)bmi.base_ptr, entry, image_64bit);
 
 	return ret;
 }
@@ -597,7 +597,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
 	version = zimage_get_kernel_version(base_ptr,
-					    (void *)state.bzimage_addr);
+					    (void *)bmi.bzimage_addr);
 	if (version)
 		printf("   @%p: %s\n", version, version);
 	print_num("Type of loader", hdr->type_of_loader);
@@ -643,22 +643,22 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	bootm_init(&state);
+	bootm_init(&bmi);
 
-	state.bzimage_size = bzimage_size;
-	state.initrd_addr = initrd_addr;
-	state.initrd_size = initrd_size;
+	bmi.bzimage_size = bzimage_size;
+	bmi.initrd_addr = initrd_addr;
+	bmi.initrd_size = initrd_size;
 	if (base_addr) {
-		state.base_ptr = map_sysmem(base_addr, 0);
-		state.load_address = bzimage_addr;
+		bmi.base_ptr = map_sysmem(base_addr, 0);
+		bmi.load_address = bzimage_addr;
 	} else {
-		state.bzimage_addr = bzimage_addr;
+		bmi.bzimage_addr = bzimage_addr;
 	}
-	state.cmdline = cmdline;
+	bmi.cmdline = cmdline;
 }
 
 void zboot_info(void)
 {
 	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       state.load_address, state.base_ptr);
+	       bmi.load_address, bmi.base_ptr);
 }
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 40f67a75593..0d0a8e53172 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -57,7 +57,7 @@ static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
-	if (!state.base_ptr) {
+	if (!bmi.base_ptr) {
 		printf("base is not set: use 'zboot load' first\n");
 		return CMD_RET_FAILURE;
 	}
@@ -97,7 +97,7 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	struct boot_params *base_ptr = state.base_ptr;
+	struct boot_params *base_ptr = bmi.base_ptr;
 
 	if (argc > 1)
 		base_ptr = (void *)hextoul(argv[1], NULL);
-- 
2.34.1

