Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311F8C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED45981417;
	Thu,  6 Mar 2025 01:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XNNLzqMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1CA812BF; Thu,  6 Mar 2025 01:26:38 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0B480FE2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85ae9566c08so3637539f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220793; x=1741825593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5EgrSZUawzywnl91PRuvX5WvM6xO+EFfKw0f8Ha1bo=;
 b=XNNLzqMyTWsubKq21+GF/GsbfbQZ4G7y3NEaSKRXlxblB8q4d1DmrxOFPM4cMHgq5l
 ULoVyFCjh47rwqBoRXl3dLbsLmlH7MoKqI3KZc1c6DfcjVmqs0Ng1/PKe1Tg9uAjYiA/
 01xjUQs0AUKSCNc0DQ8ise/SqMj8BAP8Wh0VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220793; x=1741825593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5EgrSZUawzywnl91PRuvX5WvM6xO+EFfKw0f8Ha1bo=;
 b=ert+bqzh/mJJy6wLZZ3YqRCwNLEFIdK9wCy9bveosgAui7JDKLZtpD8VYv/5kkEflc
 wnc1OPoe5RTb+XRipXfXYb+5mganRJ24RbrE1D0K7nKRAeipj+mCw52p80dUYYxdbTqk
 +BCKxI4OH5hp34YFbIn4L8sxJV4vxiQb9QqD8apJ9O+P+5oIGNuzAqqSTD9GSkGplhJu
 /CY+7B2IqwmC/9MuYIPE1NX2vW+ELuiDzal/3DPnP36EcyIM20I9rbasADtaGqz5qyRq
 4uAJe87ohsH1WTYPKmcwI5/9ipfz0ETVqlbRATY0Ypr1EEKlwQJDvex3FWkE7WRUvZug
 70ow==
X-Gm-Message-State: AOJu0YzL9+4XfLm6HIP1lKunT5EtZ0TZ4hxuxs3lROxcr2h++t2wg2p5
 sLGPhZsM2D2GB6QWifaaFJ2HwgjMBNQF8DQebOnOD1UqiHBM9WkKJXJC7pa5U6dJCR82dHRSYnk
 =
X-Gm-Gg: ASbGncsNyHRMue0OFakcqywqVDjERxlI8PHUsyh1d24D9Y6ouGxnTYFzFuXPYIwCs2b
 CPl4R3HJDpvQ/FF+PtIpkYHwZ2omiB8AxAFqIVMO4WifVw46JpBgcIkK4185o9bMgZuPD0fjaRk
 w8E/FWNmxgew+b9M7YLBg5MSzG9GeRpfzQGq4ipmu65ctDfS1MweKnNDoJvUg45xOmZqOBOm8Gw
 8JnZ2BQZKn33Rot4FvricJcJhHoxhynZkZ+FG+Bda0R2bcqxHSMZXAYhlWT1gSkoDIgl+XN1qkd
 0GbvFYVYT7saWWYQNenS0LQFmMEC0YrxhdoH4EwnqOnsB5uBeULNYXkENZHT6u6SZYMMVojpNKT
 Zhl/VPg==
X-Google-Smtp-Source: AGHT+IGWWn8FKHb/g+k9qS3pxqL47lfR6/kXywFz/bPYXXseQNQ3tzvSKONRmNvYjpBcCHlncNbucA==
X-Received: by 2002:a05:6602:3606:b0:85a:efae:2f14 with SMTP id
 ca18e2360f4ac-85aff9c2b19mr679501539f.5.1741220792747; 
 Wed, 05 Mar 2025 16:26:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 04/29] x86: Move x86 zboot state into struct bootm_info
Date: Wed,  5 Mar 2025 17:24:58 -0700
Message-ID: <20250306002533.2380866-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

(no changes since v1)

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
index 8d791416066..1dbebfe8afd 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,7 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define COMMAND_LINE_SIZE	2048
 
 /* Current state of the boot */
-struct zboot_state state;
+struct bootm_info state;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
@@ -642,7 +642,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline)
 void zboot_start(ulong bzimage_addr, ulong bzimage_size, ulong initrd_addr,
 		 ulong initrd_size, ulong base_addr, const char *cmdline)
 {
-	memset(&state, '\0', sizeof(state));
+	bootm_init(&state);
 
 	state.bzimage_size = bzimage_size;
 	state.initrd_addr = initrd_addr;
diff --git a/include/bootm.h b/include/bootm.h
index 154fb98cfcd..5fa9761629e 100644
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

