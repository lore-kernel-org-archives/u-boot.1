Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C518C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348DF8754F;
	Sat, 18 Nov 2023 22:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h6CgL8yU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86A2870F9; Sat, 18 Nov 2023 22:06:32 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D051187103
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so133601139f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341574; x=1700946374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SYssJFjHtupbaMjtm7cj/H8lKy9yf5GwYleaDBMxbc=;
 b=h6CgL8yUySEyp7EG8z9DRCmoZhYffQXNN/rMpNRKgPeLu3OvA0+evHKz+nMLuobbOi
 gMPKXdZff+cFK54uc02U2XllmiXSwGSj5ILdF43ULjWhPjY6uyPj23+6SZ/U5vguIzm8
 lNF57kFNMM41X8350A/pZRqRRA+Uc9c49cBEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341574; x=1700946374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SYssJFjHtupbaMjtm7cj/H8lKy9yf5GwYleaDBMxbc=;
 b=Yww59DqwV4NIhs0vqw2wTQNeU3yaTc6VGoSOXW0U+t/zw+KeJ+l5PX5WkqR+4rZO/N
 c4KuoG/pvcpKtNz7kk/Hy712BaP6zxYX945rygd0hPDiw/v9gEkT+AD7TzxWoE4Y9HeG
 iHALzEiAgti+r4HR0FO5t6Zem8DZWR4oruz0oukNcXwmbBoJkNcYYJcH0QkqbaXF125T
 NMz/JaczokW4sn81DijEQAnnnQFXqt9ExaskRzRguTpk0DSrAifS2T7BiAGc4u5GVMab
 DxaiQAS+rYyt1Lcs/gs0M+E+L3lOOT/orl7vnpa7XgWSordWEJoGKYwA9/W0k870t2zi
 8gSg==
X-Gm-Message-State: AOJu0Yyj/PAAjaNeV1mFcoZgkiL+JGb4kP/CGBDsMkDBSGsqvSRfSof2
 0fW6LCO4AKL0GiwuIejYLk4NpSMZ1oDYriePIGpQLA==
X-Google-Smtp-Source: AGHT+IF4zahF615tn2gnEz3dDC2WVBCHUEe2na4oT4F5GCsyEh2TI1WZscQcKr82FfAnIwDFGevmrQ==
X-Received: by 2002:a92:ce11:0:b0:35a:fad1:73cd with SMTP id
 b17-20020a92ce11000000b0035afad173cdmr1331057ilo.11.1700341574430; 
 Sat, 18 Nov 2023 13:06:14 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 21/32] bootm: Pass image buffer to boot_get_fdt()
Date: Sat, 18 Nov 2023 14:05:09 -0700
Message-ID: <20231118210547.577026-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Rather than having boot_get_fdt() calculate this, move the calculation
into the caller. This removes the access to argv[0] in this function,
so we can later refactor it to just accept argv[2] instead of the whole
argv[].

Move the function comment to the header file and fix the u8 argument,
while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c     | 11 +++++++----
 boot/image-fdt.c | 32 +++-----------------------------
 include/image.h  | 31 ++++++++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d9c62d730f7f..cd11994e21ce 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -490,11 +490,11 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size)
 {
 	const char *select = NULL;
+	ulong img_addr;
+	void *buf;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
-		char *buf;
-
 		/* Look for an Android boot image */
 		buf = map_sysmem(images.os.start, 0);
 		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID)
@@ -525,9 +525,12 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
+		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+		buf = map_sysmem(img_addr, 0);
+
 		/* find flattened device tree */
-		ret = boot_get_fdt(flag, argc, argv, IH_ARCH_DEFAULT, &images,
-				   &images.ft_addr, &images.ft_len);
+		ret = boot_get_fdt(buf, flag, argc, argv, IH_ARCH_DEFAULT,
+				   &images, &images.ft_addr, &images.ft_len);
 		if (ret) {
 			puts("Could not find a valid device tree\n");
 			return 1;
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f10200f64743..6ff2d52d6c70 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -447,43 +447,17 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 	return 0;
 }
 
-/**
- * boot_get_fdt - main fdt handling routine
- * @argc: command argument count
- * @argv: command argument list
- * @arch: architecture (IH_ARCH_...)
- * @images: pointer to the bootm images structure
- * @of_flat_tree: pointer to a char* variable, will hold fdt start address
- * @of_size: pointer to a ulong variable, will hold fdt length
- *
- * boot_get_fdt() is responsible for finding a valid flat device tree image.
- * Currently supported are the following ramdisk sources:
- *      - multicomponent kernel/ramdisk image,
- *      - commandline provided address of decicated ramdisk image.
- *
- * returns:
- *     0, if fdt image was found and valid, or skipped
- *     of_flat_tree and of_size are set to fdt start address and length if
- *     fdt image is found and valid
- *
- *     1, if fdt image is found but corrupted
- *     of_flat_tree and of_size are set to 0 if no fdt exists
- */
-int boot_get_fdt(int flag, int argc, char *const argv[], uint8_t arch,
-		 struct bootm_headers *images, char **of_flat_tree, ulong *of_size)
+int boot_get_fdt(void *buf, int flag, int argc, char *const argv[], uint arch,
+		 struct bootm_headers *images, char **of_flat_tree,
+		 ulong *of_size)
 {
-	ulong		img_addr;
 	ulong		fdt_addr;
 	char		*fdt_blob = NULL;
-	void		*buf;
 	const char *select = NULL;
 
 	*of_flat_tree = NULL;
 	*of_size = 0;
 
-	img_addr = (argc == 0) ? image_load_addr : hextoul(argv[0], NULL);
-	buf = map_sysmem(img_addr, 0);
-
 	if (argc > 2)
 		select = argv[2];
 	if (select || genimg_has_config(images)) {
diff --git a/include/image.h b/include/image.h
index 3e48ad5b303e..a4555f25fb56 100644
--- a/include/image.h
+++ b/include/image.h
@@ -808,9 +808,34 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
 int fit_get_node_from_config(struct bootm_headers *images,
 			     const char *prop_name, ulong addr);
 
-int boot_get_fdt(int flag, int argc, char *const argv[], uint8_t arch,
-		 struct bootm_headers *images,
-		 char **of_flat_tree, ulong *of_size);
+/**
+ * boot_get_fdt() - locate FDT devicetree to use for booting
+ *
+ * @buf: Pointer to image
+ * @argc: command argument count
+ * @argv: command argument list
+ * @arch: architecture (IH_ARCH_...)
+ * @images: pointer to the bootm images structure
+ * @of_flat_tree: pointer to a char* variable, will hold fdt start address
+ * @of_size: pointer to a ulong variable, will hold fdt length
+ *
+ * boot_get_fdt() is responsible for finding a valid flat device tree image.
+ * Currently supported are the following FDT sources:
+ *      - multicomponent kernel/ramdisk/FDT image,
+ *      - commandline provided address of decicated FDT image.
+ *
+ * Return:
+ *     0, if fdt image was found and valid, or skipped
+ *     of_flat_tree and of_size are set to fdt start address and length if
+ *     fdt image is found and valid
+ *
+ *     1, if fdt image is found but corrupted
+ *     of_flat_tree and of_size are set to 0 if no fdt exists
+ */
+int boot_get_fdt(void *buf, int flag, int argc, char *const argv[], uint arch,
+		 struct bootm_headers *images, char **of_flat_tree,
+		 ulong *of_size);
+
 void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob);
 int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size);
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

