Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4BBC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E3C878C2;
	Mon,  4 Dec 2023 01:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SE15ti6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DF487655; Mon,  4 Dec 2023 01:30:36 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B0F878BD
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6cbd24d9557so3121723b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649833; x=1702254633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji7TTR5kO3D/u5xiCPwhYQKs9sSkNkVzOtKKpXyLuaE=;
 b=SE15ti6eq8PeR4k4C+YELR7TAVEBna5+5clYeaHBzD8R84WSqMpQ2aGPlozxkc0QB7
 asiL0it8mvI8Q7iUI9dvTVDUcg5vt+QFGGugHxZjJjFRqeBxS9OiwTH90Ps0i7BCTiQ8
 lYr9XW3YXzKzdJOXjjUCFgUe/Ds7DvgVatxHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649833; x=1702254633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji7TTR5kO3D/u5xiCPwhYQKs9sSkNkVzOtKKpXyLuaE=;
 b=rZ+xXQrOHmINb1ARseVdaCj0BEFcY+I3FcbLJC1X6twZ7abLeVspx1GfwNi9f6iILZ
 iyahAr/VdykAcLUDjpT8Ydl9lUfe4DkYH3YRQs60gGNSg40+mRBNKMRuTOuBEODOcSjF
 cK680Y753P4UpTCM738wKI07eK6snYMXcCHpm3MqGmsEAsXa7kJWM5V3Ppy9EQdM0R3E
 XohpxOzjTS7Cg0XTss6mpMjhIxEZm7nyBABxoMEdMJJ6LLqa1dvQzP7+Z7WsxFe39eI1
 e5uiFnhqBKoLtWRSWMkh3zhYqIhewp5spPOXdZEJHQnnO9+t8m93otXWVwss13FQXSiL
 qM5Q==
X-Gm-Message-State: AOJu0YwPANyh+FN2nG9Xa6Fs9TosEcMFO/Km1/1pvVJCLWo6BZHdB69G
 jPV3O3qgVoDjLuUu90XU0q/Kz0L9Vj904ERh7L0/Ig==
X-Google-Smtp-Source: AGHT+IFNqljtpKOBFiFFXuHfhKXap7lb0QsLUzzPOQBxIJNTlAABMXJKsqW+C3qHGWOfkRyRvxCVyw==
X-Received: by 2002:a05:6a00:23c4:b0:6cb:cd66:2102 with SMTP id
 g4-20020a056a0023c400b006cbcd662102mr3672512pfc.4.1701649832880; 
 Sun, 03 Dec 2023 16:30:32 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 11/13] x86: zboot: Separate logic functions from commands
Date: Sun,  3 Dec 2023 17:29:36 -0700
Message-ID: <20231204002944.897949-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

Move zboot_start() and zboot_info() in with the other logic functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h | 25 +++++++++++++++++++++++++
 arch/x86/lib/zimage.c         | 23 +++++++++++++++++++++++
 cmd/x86/zboot.c               | 32 ++++----------------------------
 3 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index ac6683ea9ef3..8b5426051701 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -134,4 +134,29 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 		 ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
 
+/**
+ * zboot_start() - Prepare to boot a zimage
+ *
+ * Record information about a zimage so it can be booted
+ *
+ * @bzimage_addr: Address of the bzImage to boot
+ * @bzimage_size: Size of the bzImage, or 0 to detect this
+ * @initrd_addr: Address of the initial ramdisk, or 0 if none
+ * @initrd_size: Size of the initial ramdisk, or 0 if none
+ * @base_addr: If non-zero, this indicates that the boot parameters have already
+ *	been loaded by the caller to this address, so the load_zimage() call
+ *	in zboot_load() will be skipped when booting
+ * @cmdline: Environment variable containing the 'override' command line, or
+ *	NULL to use the one in the setup block
+ */
+void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
+		 ulong initrd_size, ulong base_addr, const char *cmdline);
+
+/**
+ * zboot_info() - Show simple info about a zimage
+ *
+ * Shows wherer the kernel was loaded and also the setup base
+ */
+void zboot_info(void);
+
 #endif
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index e8a1849947e6..f2d4f3b50162 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -652,3 +652,26 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 	if (get_boot_protocol(hdr, false) >= 0x215)
 		print_num("Kernel info offset", hdr->kernel_info_offset);
 }
+
+void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
+		 ulong initrd_size, ulong base_addr, const char *cmdline)
+{
+	memset(&state, '\0', sizeof(state));
+
+	state.bzimage_size = bzimage_size;
+	state.initrd_addr = initrd_addr;
+	state.initrd_size = initrd_size;
+	if (base_addr) {
+		state.base_ptr = map_sysmem(base_addr, 0);
+		state.load_address = bzimage_addr;
+	} else {
+		state.bzimage_addr = bzimage_addr;
+	}
+	state.cmdline = cmdline;
+}
+
+void zboot_info(void)
+{
+	printf("Kernel loaded at %08lx, setup_base=%p\n",
+	       state.load_address, state.base_ptr);
+}
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 572b58a5537d..addf28cb4aae 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -10,26 +10,6 @@
 #include <vsprintf.h>
 #include <asm/zimage.h>
 
-static int zboot_start(ulong bzimage_addr, ulong bzimage_size,
-		       ulong initrd_addr, ulong initrd_size, ulong base_addr,
-		       const char *cmdline)
-{
-	memset(&state, '\0', sizeof(state));
-
-	state.bzimage_size = bzimage_size;
-	state.initrd_addr = initrd_addr;
-	state.initrd_size = initrd_size;
-	if (base_addr) {
-		state.base_ptr = map_sysmem(base_addr, 0);
-		state.load_address = bzimage_addr;
-	} else {
-		state.bzimage_addr = bzimage_addr;
-	}
-	state.cmdline = cmdline;
-
-	return 0;
-}
-
 static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
@@ -47,8 +27,10 @@ static int do_zboot_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	base_addr = argc > 5 ? hextoul(argv[5], NULL) : 0;
 	cmdline = argc > 6 ? env_get(argv[6]) : NULL;
 
-	return zboot_start(bzimage_addr, bzimage_size, initrd_addr, initrd_size,
-			   base_addr, cmdline);
+	zboot_start(bzimage_addr, bzimage_size, initrd_addr, initrd_size,
+		    base_addr, cmdline);
+
+	return 0;
 }
 
 static int do_zboot_load(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -81,12 +63,6 @@ static int do_zboot_setup(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static void zboot_info(void)
-{
-	printf("Kernel loaded at %08lx, setup_base=%p\n",
-	       state.load_address, state.base_ptr);
-}
-
 static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-- 
2.43.0.rc2.451.g8631bc7472-goog

