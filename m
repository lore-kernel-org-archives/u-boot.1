Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E69C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E8787505;
	Sat, 18 Nov 2023 22:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAZUQT92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7267E874B1; Sat, 18 Nov 2023 22:06:30 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6214D874B1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so124023539f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341572; x=1700946372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpckdidkh4bEEYg7Aagzeuuxs6pA/s9pnlgUf5T0nR4=;
 b=JAZUQT929Aj3jUaRl/yx/RL9CMZh8HzlZWqQT0vyFFUavp5RwZWhN3KwgdwNkqYyIi
 QDGEEFOgLQ4yLzym9l++PXARVnIAS2LNqxVCB7ZNFBlWjuk8r+Pg7lpErcwz3aeO5L8o
 bNEi7UMM99X73nl0I4WLLYTlP5hcJfgUaVnas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341572; x=1700946372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mpckdidkh4bEEYg7Aagzeuuxs6pA/s9pnlgUf5T0nR4=;
 b=jYo/QO9XcQ3cRdSKSotv89jhXJEKzil1IFUnjIHY23SAPyt3QfoVl/rbEuIYtEkt9N
 yvIVzBszBQ5orFhDVXf+0+O7Zvcs59xI7nq5ucZtgwpiOt/RXDuVNxPHbFqfmjIYCrj9
 pew0OZiKkDJIl1qVZG87X5X6z1pkJbydeiG+az4KCSkgv5MXWENL82SLMvyzVlWDVvyT
 tkvuxhlDifIB+7uRjpqs8RyvRJyCneGCI649pGDCEdzBqlUfdwtoaGkcukbLGVOX0XHX
 G6EHFMUf0URFaq/wIIHU9yXftlCdREClLEk1iKGE+s1M5Vu4f4f3QAk4GtjfzBIm3+ZV
 /DBA==
X-Gm-Message-State: AOJu0YxwNLcv5V9cJAtuLWI8dcjC0f0d/RDx6XnJXatjw4S6PEhL+eAo
 K3Rfa/PINtK2qUb+fPxbQf60zVmh4Qp6redqdHynmA==
X-Google-Smtp-Source: AGHT+IFuue4TWtUCNCQ98U8rLJU6JOMedlhrvlQFuswfWOn0uTCbKUf2j3D2fUqjQUVPvEi5DXIOOg==
X-Received: by 2002:a6b:c701:0:b0:786:25a3:ef30 with SMTP id
 x1-20020a6bc701000000b0078625a3ef30mr4725925iof.7.1700341571949; 
 Sat, 18 Nov 2023 13:06:11 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3 18/32] bootm: Reduce arguments to boot_get_ramdisk()
Date: Sat, 18 Nov 2023 14:05:06 -0700
Message-ID: <20231118210547.577026-19-sjg@chromium.org>
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

This function normally only uses one argument so pass it in directly.
Move comments to the header file so could one day include these
functions in API docs. Fix up the u8 argument while here, since it
avoids the compiler having to mask the value on some machines.

The Android case here is bit strange, since it can use argv[0], so deal
with that in the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c       | 15 ++++++++++++++-
 boot/image-board.c | 39 ++-------------------------------------
 include/image.h    | 27 +++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 922989b9cfcf..d5893e82d128 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -489,10 +489,23 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size)
 {
+	const char *select = NULL;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
+		char *buf;
+
+		/* Look for an Android boot image */
+		buf = map_sysmem(images.os.start, 0);
+		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID)
+			select = argc ? argv[0] : env_get("loadaddr");
+	}
+
+	if (argc >= 2)
+		select = argv[1];
+
 	/* find ramdisk */
-	ret = boot_get_ramdisk(argc, argv, &images, IH_INITRD_ARCH,
+	ret = boot_get_ramdisk(select, &images, IH_INITRD_ARCH,
 			       &images.rd_start, &images.rd_end);
 	if (ret) {
 		puts("Ramdisk image is corrupt or invalid\n");
diff --git a/boot/image-board.c b/boot/image-board.c
index 062c76badecc..60e514fc150e 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -456,49 +456,14 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 	return 0;
 }
 
-/**
- * boot_get_ramdisk - main ramdisk handling routine
- * @argc: command argument count
- * @argv: command argument list
- * @images: pointer to the bootm images structure
- * @arch: expected ramdisk architecture
- * @rd_start: pointer to a ulong variable, will hold ramdisk start address
- * @rd_end: pointer to a ulong variable, will hold ramdisk end
- *
- * boot_get_ramdisk() is responsible for finding a valid ramdisk image.
- * Currently supported are the following ramdisk sources:
- *      - multicomponent kernel/ramdisk image,
- *      - commandline provided address of decicated ramdisk image.
- *
- * returns:
- *     0, if ramdisk image was found and valid, or skiped
- *     rd_start and rd_end are set to ramdisk start/end addresses if
- *     ramdisk image is found and valid
- *
- *     1, if ramdisk image is found but corrupted, or invalid
- *     rd_start and rd_end are set to 0 if no ramdisk exists
- */
-int boot_get_ramdisk(int argc, char *const argv[], struct bootm_headers *images,
-		     u8 arch, ulong *rd_start, ulong *rd_end)
+int boot_get_ramdisk(char const *select, struct bootm_headers *images,
+		     uint arch, ulong *rd_start, ulong *rd_end)
 {
 	ulong rd_data, rd_len;
-	const char *select = NULL;
 
 	*rd_start = 0;
 	*rd_end = 0;
 
-	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
-		char *buf;
-
-		/* Look for an Android boot image */
-		buf = map_sysmem(images->os.start, 0);
-		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID)
-			select = (argc == 0) ? env_get("loadaddr") : argv[0];
-	}
-
-	if (argc >= 2)
-		select = argv[1];
-
 	/*
 	 * Look for a '-' which indicates to ignore the
 	 * ramdisk argument
diff --git a/include/image.h b/include/image.h
index d37e44721672..3e48ad5b303e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -644,8 +644,31 @@ int genimg_has_config(struct bootm_headers *images);
 
 int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
 		  uint8_t arch, const ulong *ld_start, ulong * const ld_len);
-int boot_get_ramdisk(int argc, char *const argv[], struct bootm_headers *images,
-		     uint8_t arch, ulong *rd_start, ulong *rd_end);
+
+/**
+ * boot_get_ramdisk() - Locate the ramdisk
+ *
+ * @select: address or name of ramdisk to use, or NULL for default
+ * @images: pointer to the bootm images structure
+ * @arch: expected ramdisk architecture
+ * @rd_start: pointer to a ulong variable, will hold ramdisk start address
+ * @rd_end: pointer to a ulong variable, will hold ramdisk end
+ *
+ * boot_get_ramdisk() is responsible for finding a valid ramdisk image.
+ * Currently supported are the following ramdisk sources:
+ *      - multicomponent kernel/ramdisk image,
+ *      - commandline provided address of decicated ramdisk image.
+ *
+ * returns:
+ *     0, if ramdisk image was found and valid, or skiped
+ *     rd_start and rd_end are set to ramdisk start/end addresses if
+ *     ramdisk image is found and valid
+ *
+ *     1, if ramdisk image is found but corrupted, or invalid
+ *     rd_start and rd_end are set to 0 if no ramdisk exists
+ */
+int boot_get_ramdisk(char const *select, struct bootm_headers *images,
+		     uint arch, ulong *rd_start, ulong *rd_end);
 
 /**
  * boot_get_loadable - routine to load a list of binaries to memory
-- 
2.43.0.rc0.421.g78406f8d94-goog

