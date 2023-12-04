Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A620C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7675C8771E;
	Mon,  4 Dec 2023 01:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mOYaI2P4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AC8877E5; Mon,  4 Dec 2023 01:30:06 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2138771E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d7e56f6845so2116421a34.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649799; x=1702254599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/u2spBxhRmJRwqylzAm5V+nXV7vyHNHgRBrUGPv5gS0=;
 b=mOYaI2P4JqzT00vrngf17fGhxhNuGj4zOxZsSwaZrS24l8AMMufZe0JvRXAu3idNJZ
 tfPhveeJTJjevT4K15YxDmSuwHCGH4tv6gLwM8PBhU0BXIT5n8Mzpoep4e83SfMGsIYv
 ppc89qg9fP0641fiO7t8E6UTFLb7f7+bYbUc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649799; x=1702254599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/u2spBxhRmJRwqylzAm5V+nXV7vyHNHgRBrUGPv5gS0=;
 b=nMuThku1kHu9o4zOP6trciK8vgfYM+xM3lVQkKBH0qXOCSfq6/VRIhpRncFj+UQ7Bb
 L/qoAUSrowsvctBq2V+NT50vqrbphiJauFcawti9r2S4QA5LEetqyql/RN8HJwz2jjxi
 L3/IQ8bxbdq0MV2/Bhlyu8fWKnpZDADamBiWpq/WUPTYKytq0N4nYNREd8FdfKMeN3AW
 8tqZcGnURxkQ4+rfrBkwg9GnavfMOLWXuY+PwPgzxr08esUGO2+Xco6aSb2xnqkWNk3f
 Wm3vmUX2UmkRBUx533VSmnzAGWyh0EA0QIZ2VII4gpid87j4JU4PsFRi5ZEwPV2qxSPv
 4Z0A==
X-Gm-Message-State: AOJu0Yy2TrjCDP582os6ZJmP7virgq60blqS3I5R1iAiQ072JQFjdF27
 aLbt2ntVHw6untkODrkHIde98apQS3jlG6MhWOZynA==
X-Google-Smtp-Source: AGHT+IFQU+sEsl7GNYd33MWpPi++BXhdp/xAWkYnxRnvUcch3FkVr2GhWPR36pBWjVqNQELF6tkNuQ==
X-Received: by 2002:a05:6830:3a0f:b0:6d8:659d:a867 with SMTP id
 di15-20020a0568303a0f00b006d8659da867mr3069383otb.4.1701649798927; 
 Sun, 03 Dec 2023 16:29:58 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:29:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 01/13] x86: zboot: Move zimage definitions to the header file
Date: Sun,  3 Dec 2023 17:29:26 -0700
Message-ID: <20231204002944.897949-2-sjg@chromium.org>
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

In preparation for splitting the zboot-command code into a separate
file, move the definitions into the header file.

While we are here, mention when load_address and base_ptr are set up
and explain bzimage_addr better. Make cmdline const since it cannot be
changed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h | 41 +++++++++++++++++++++++++++++++++++
 arch/x86/lib/zimage.c         | 36 +-----------------------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 655675b66614..a91cfb2b8dd0 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -30,6 +30,47 @@
 #define BZIMAGE_LOAD_ADDR  0x100000
 #define ZIMAGE_LOAD_ADDR   0x10000
 
+enum {
+	ZBOOT_STATE_START	= BIT(0),
+	ZBOOT_STATE_LOAD	= BIT(1),
+	ZBOOT_STATE_SETUP	= BIT(2),
+	ZBOOT_STATE_INFO	= BIT(3),
+	ZBOOT_STATE_GO		= BIT(4),
+
+	/* This one doesn't execute automatically, so stop the count before 5 */
+	ZBOOT_STATE_DUMP	= BIT(5),
+	ZBOOT_STATE_COUNT	= 5,
+};
+
+/**
+ * struct zboot_state - Current state of the boot
+ *
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
+ */
+struct zboot_state {
+	ulong bzimage_addr;
+	ulong bzimage_size;
+	ulong initrd_addr;
+	ulong initrd_size;
+	ulong load_address;
+	struct boot_params *base_ptr;
+	const char *cmdline;
+};
+
+extern struct zboot_state state;
+
 /**
  * load_zimage() - Load a zImage or bzImage
  *
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a41e1ccf8a65..b04d39b36dd4 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -56,41 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define COMMAND_LINE_SIZE	2048
 
-/**
- * struct zboot_state - Current state of the boot
- *
- * @bzimage_addr: Address of the bzImage to boot
- * @bzimage_size: Size of the bzImage, or 0 to detect this
- * @initrd_addr: Address of the initial ramdisk, or 0 if none
- * @initrd_size: Size of the initial ramdisk, or 0 if none
- * @load_address: Address where the bzImage is moved before booting, either
- *	BZIMAGE_LOAD_ADDR or ZIMAGE_LOAD_ADDR
- * @base_ptr: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
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
-	char *cmdline;
-} state;
-
-enum {
-	ZBOOT_STATE_START	= BIT(0),
-	ZBOOT_STATE_LOAD	= BIT(1),
-	ZBOOT_STATE_SETUP	= BIT(2),
-	ZBOOT_STATE_INFO	= BIT(3),
-	ZBOOT_STATE_GO		= BIT(4),
-
-	/* This one doesn't execute automatically, so stop the count before 5 */
-	ZBOOT_STATE_DUMP	= BIT(5),
-	ZBOOT_STATE_COUNT	= 5,
-};
+struct zboot_state state;
 
 static void build_command_line(char *command_line, int auto_boot)
 {
-- 
2.43.0.rc2.451.g8631bc7472-goog

