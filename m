Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10766C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FEC877B2;
	Sun, 12 Nov 2023 01:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MjABVdhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45F486F84; Sun, 12 Nov 2023 01:10:33 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C46887116
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-359045af665so13196265ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747788; x=1700352588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7rZ3EMdmcIVnWOKT1KM/ibPR8KydyIP1g+KW1Ro8D8=;
 b=MjABVdhl0xp1rKRuAFDoSL4HiOQyTtVkNUOXQcVYVvr3q8p3YWYpSuJZEEuDcv4xeA
 p0oK1XkUhmAqszHbEUzPSus6ENVGK1+RUTQHNHY0N6OL29xzkN6VFTq+4EAnChqR1667
 /mKLxpGlGOHszIcUOJi9NhLJq17VJo49EgoXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747788; x=1700352588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7rZ3EMdmcIVnWOKT1KM/ibPR8KydyIP1g+KW1Ro8D8=;
 b=FzovAJ8MM6X79ngXIAOv5cW8e0ErsqjjjUgamLzSlypYkhNievtEB88FRjG9i802Ty
 uYpBGjP5gRN37g1Rq2J4qPBexX38jHusV5A/cHq7j+SyqvUhaKsBJ5UfPR54tEtTrfeQ
 a21UwPNI7l2jRjaLzb+PEPZ3CrW6y2u8OWhxIs9Cv4e+C2LhDSFK5BvyODuQlLTZa3CS
 bToQ30Jh/IltERCHUZ4xrVQi5YVvIi8SC5gW5asI3kc1daAcgOWj/05xhR93y9MdASH4
 lUn4vVkoNdea6yAgJu9fRuXdv7oy8Dxb38szTrNfnhTeHbcvol536CY4uvhmggkJFOWc
 lSJA==
X-Gm-Message-State: AOJu0YzD0qKr+dlaCA5xV9CLyn5hacc1D2rzNOg1sgdJqWECfWfyJ3Zo
 jjlYKokUchWahUQFDx1I7Wgf61bo5uHXq/7eAolZAA==
X-Google-Smtp-Source: AGHT+IF/TPuctF7PLAiYj93hevhKbD7uIDVBsaqux3Ha6LC8viZCGMwN0Btiwyt+LUb0iiQoV3q88Q==
X-Received: by 2002:a05:6e02:1b02:b0:359:cc15:b0b3 with SMTP id
 i2-20020a056e021b0200b00359cc15b0b3mr4940736ilv.25.1699747788656; 
 Sat, 11 Nov 2023 16:09:48 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 20/29] bootm: Pass image buffer to boot_get_fdt()
Date: Sat, 11 Nov 2023 17:09:05 -0700
Message-ID: <20231112000923.73568-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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
---

 boot/bootm.c     | 11 +++++++----
 boot/image-fdt.c | 32 +++-----------------------------
 include/image.h  | 31 ++++++++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 0de49a9d1fa1..4959fcd91533 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -489,11 +489,11 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
@@ -524,9 +524,12 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.42.0.869.gea05f2083d-goog

