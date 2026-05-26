Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A6CCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B405584886;
	Tue, 26 May 2026 15:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="luRl6pAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A429184886; Tue, 26 May 2026 15:10:14 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F64D84879
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43b57ee1480so1335866fac.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801011; x=1780405811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1AaLTFxdlY4jWkCyW2jp++HKrKa3i86/JQguwYgHPg=;
 b=luRl6pAbUF3Rr4draqmH0WC+4lExNnKFM6UbUvwW/0tgjn3f6Y+zfK9rQ423dMWEOC
 GlqTuaKjdrCA6Pf3/VnZy9U1ZLV4Zh7+nx2BUIKH+XmSWm0JCubHp4P1o3waDKC2iHj3
 gaXDavr2QExZWbUnNs5urYuGsBW07kAPK1R78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801011; x=1780405811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1AaLTFxdlY4jWkCyW2jp++HKrKa3i86/JQguwYgHPg=;
 b=Yjl7BVd/EoaEY6zIq3nTo4EJPlycAqTBx+9mNQvHqpZEYUKtNDwJVafYnOxZoAwr7D
 QiJU/kAhrRJxmVo3CGUhGiCD/WTGwfUpRGmeujT/95f4CPt/dLfsOUIA8gyK6k+SX0ew
 /JOejGdwuNYaTrsab17AQLtQQ+m+vlCdN6mfwNEAAc6fD802vvLS9iuGD46avJ1inWxK
 ++TGKnebI0/VZn1aYGdybHPkFJLQHQ8pgb5znp7e4A+T4QgTDyGKMIiwzQHSm0Ij74wR
 q9SxqxmxsM50kxQv9K9Okn3T3x65Laam3D2fS8bRkuN7MPF6gH4hjN0mZjxrLD2s4V8d
 fosA==
X-Gm-Message-State: AOJu0YzSetR9NXCHgzbmDha5kQqgfVzbjNsurIY3pr7bk81ecD3VwPWM
 uCPRS25JFPd6RpCbMAkZpD7OmODuUAoaLlZF1463Pbe3axeN983Yfhcxq0XSCjN8mU1WAz7Bfai
 5sqF67RdpSKk=
X-Gm-Gg: Acq92OH5nXkkPwXpGbm4GeeVjBVE7ay2OQdxSgs1j6aEk2UD6bMQZt9WieWLTb3Oea3
 PJdpaFxHPorf1Z+kOxKBKvHJfrO4bjS/LC+4XHa8x4HR0F8KnSB4+eRTCcwcu04eeltTJchcOE6
 Ylv0qdrAffkF8FkO0DVKGl8DVLKeEVIr7HBCo7LgpcSKkcYtoyEt7okPgBKuEK3jls+Gj3WAALv
 a4hzydFovMxZCsaxKK8S5aTsAdF65+NN5t6qpALk+ny/DNYdiZ33TsFf/XrnbjF/Xp4tKi0DQ2P
 MiMqXXacBjONAdvn0a2K4WBrvBHQ8Hp5Ab/Kd++eZ2JCblfHohtxRoaF6I7JPJ4RsPah4fIQ+4O
 sFfftVYQYkFJvvzS5TgLf2ELzF2QJ1s5zD1d9t249X3vyr72MHw4Qj4FmuGk5m7ZFoS+Tyfi72N
 AjoRpnN83yvxTrjFLwFQ==
X-Received: by 2002:a05:6820:c8e:b0:696:13e9:6855 with SMTP id
 006d021491bc7-69d7eb7ac89mr9709115eaf.15.1779801011152; 
 Tue, 26 May 2026 06:10:11 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 4/9] x86: Move x86 zboot state into struct bootm_info
Date: Tue, 26 May 2026 07:09:10 -0600
Message-ID: <20260526130931.2103552-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

This structure is supposed to handle any type of booting
programmatically, i.e. without needing a command to be executed. Move
the x86-specific members into it and use it instead of
struct zboot_state. Provide a macro so access is possible without adding
lots of #ifdefs to the code.

This will allow the struct to be used for all four types of booting
(bootm, bootz, booti and zboot).

Call bootm_init() to init the state, to match other boot methods.

Note that some rationalisation could be performed on this. But this
is tricky since addresses are stored as strings in several places. Also
some strings combine multiple arguments into one. So to keep this task
somewhat manageable, we content ourselves with just getting everything
into the same struct

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h | 29 +----------------------------
 arch/x86/lib/zimage.c         |  4 ++--
 include/bootm.h               | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 76b2a797ccf..13a08850dfb 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -42,34 +42,7 @@ enum {
 	ZBOOT_STATE_COUNT	= 5,
 };
 
-/**
- * struct zboot_state - Current state of the boot
- *
- * @bzimage_addr: Address of the bzImage to boot, or 0 if the image has already
- *	been loaded and does not exist (as a cohesive whole) in memory
- * @bzimage_size: Size of the bzImage, or 0 to detect this
- * @initrd_addr: Address of the initial ramdisk, or 0 if none
- * @initrd_size: Size of the initial ramdisk, or 0 if none
- * @load_address: Address where the bzImage is moved before booting, either
- *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
- *	This is set up when loading the zimage
- * @base_ptr: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
- *	This is set up when loading the zimage
- * @cmdline: Environment variable containing the 'override' command line, or
- *	NULL to use the one in the setup block
- */
-struct zboot_state {
-	ulong bzimage_addr;
-	ulong bzimage_size;
-	ulong initrd_addr;
-	ulong initrd_size;
-	ulong load_address;
-	struct boot_params *base_ptr;
-	const char *cmdline;
-};
-
-extern struct zboot_state state;
+extern struct bootm_info state;
 
 /**
  * zboot_load() - Load a zimage
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index b542ca2d458..cba0039f713 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -53,7 +53,7 @@
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct zboot_state state;
+struct bootm_info state;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -623,7 +623,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	memset(&state, '\0', sizeof(state));
+	bootm_init(&state);
 
 	state.bzimage_size = bzimage_size;
 	state.initrd_addr = initrd_addr;
diff --git a/include/bootm.h b/include/bootm.h
index a6262de9ce7..a829485fb57 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -44,6 +44,21 @@ struct cmd_tbl;
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
  * @argv: NULL-terminated list of arguments, or NULL if there are no arguments
+ *
+ * For zboot:
+ * @bzimage_addr: Address of the bzImage to boot, or 0 if the image has already
+ *	been loaded and does not exist (as a cohesive whole) in memory
+ * @bzimage_size: Size of the bzImage, or 0 to detect this
+ * @initrd_addr: Address of the initial ramdisk, or 0 if none
+ * @initrd_size: Size of the initial ramdisk, or 0 if none
+ * @load_address: Address where the bzImage is moved before booting, either
+ *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
+ *	This is set up when loading the zimage
+ * @base_ptr: Pointer to the boot parameters, typically at address
+ *	DEFAULT_SETUP_BASE
+ *	This is set up when loading the zimage
+ * @cmdline: Environment variable containing the 'override' command line, or
+ *	NULL to use the one in the setup block
  */
 struct bootm_info {
 	const char *addr_img;
@@ -54,8 +69,26 @@ struct bootm_info {
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
+
+	/* zboot items */
+#ifdef CONFIG_X86
+	ulong bzimage_addr;
+	ulong bzimage_size;
+	ulong initrd_addr;
+	ulong initrd_size;
+	ulong load_address;
+	struct boot_params *base_ptr;
+	const char *cmdline;
+#endif
 };
 
+/* macro to allow setting fields in generic code */
+#ifdef CONFIG_X86
+#define bootm_x86_set(_bmi, _field, _val)	(_bmi)->_field = (_val)
+#else
+#define bootm_x86_set(_bmi, _field, _val)
+#endif
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.43.0

