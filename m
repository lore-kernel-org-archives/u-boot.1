Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2772A87790;
	Sun, 12 Nov 2023 01:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D9zEDJSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E5986F83; Sun, 12 Nov 2023 01:10:26 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFAA870E1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ac7b2b1e99so129093239f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747786; x=1700352586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puL5Z00FbpcLZJRf0AT2N8HiJl5QyNf8Qgjiabse69Y=;
 b=D9zEDJSQTmNUKypq5KP0hyAfn7GDrvKhCUPNGnhAUqVxSW7YhPSmnP0Vi+5k4+dwiY
 M6gY707fHs7k42YIpOcUh3ifVP3yk4AuU/P/6SW/4TIhpBMhl4Dm9/G17mR2Fzocb1ra
 +uEA86mnHUKKcfVSHYJguFNu1VMAldx34ATag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747786; x=1700352586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puL5Z00FbpcLZJRf0AT2N8HiJl5QyNf8Qgjiabse69Y=;
 b=WD4+L4jPAxuXrQKF+ROSFJabeUWjRriI1hcAWH5zxnpdCgOT6KK1ntNkm76Qe5lJ3a
 gG1+u3o2u3EuSkpNyF/0pBbjvCnD80tGGQM5nqNS+hi5/p13ElekfPsvlbUuk5HcU3AB
 7BNO/gxqoL1d9u0/deLX9VxQJ7yR+IRWPCpiE/tBFdv4C8V/CdbmABli5QTfEdFsY5a/
 y2RFo5NOsddLV9yYCb7IJvB0rbrLZOkHmaOT9Ky4VG3fMCKzPKOeclbYsPdIMzQj+vFg
 PNEeQyqebaiJVdLNiupPXzgg0Vt3/UiDoPUSxenliz43AEKTTqeVcz8aqc82faNCIj0L
 SzVg==
X-Gm-Message-State: AOJu0Yw/o7r8KQfx0Q3u7eftCDLszY9mIUg+6cwrPdJy9zCWch1nhT1x
 oBEJcQcU35hujf/Lx0nbKzfGbzBZFUfmtrxoDwV0Yg==
X-Google-Smtp-Source: AGHT+IHR3kbfVLuUoojXc1lPe2ZbhtkyzV0PirF0yDcEWg7SLDd2qMJKoex7zj0mDAMUAREOWkbInw==
X-Received: by 2002:a05:6e02:20e5:b0:359:311b:490e with SMTP id
 q5-20020a056e0220e500b00359311b490emr4495379ilv.2.1699747785930; 
 Sat, 11 Nov 2023 16:09:45 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 17/29] bootm: Reduce arguments to boot_get_ramdisk()
Date: Sat, 11 Nov 2023 17:09:02 -0700
Message-ID: <20231112000923.73568-18-sjg@chromium.org>
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

This function normally only uses one argument so pass it in directly.
Move comments to the header file so could one day include these
functions in API docs. Fix up the u8 argument while here, since it
avoids the compiler having to mask the value on some machines.

The Android case here is bit strange, since it can use argv[0], so deal
with that in the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c       | 15 ++++++++++++++-
 boot/image-board.c | 39 ++-------------------------------------
 include/image.h    | 27 +++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 2358d68c2861..5782a1e2a57b 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -488,10 +488,23 @@ static int bootm_find_os(const char *addr_fit)
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
2.42.0.869.gea05f2083d-goog

