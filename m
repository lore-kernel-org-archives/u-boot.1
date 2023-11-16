Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F7C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FAD9874E5;
	Thu, 16 Nov 2023 05:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ic0AuUTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6A5874C4; Thu, 16 Nov 2023 05:11:39 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1D087251
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7ad1236c419so12830639f.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107896; x=1700712696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpckdidkh4bEEYg7Aagzeuuxs6pA/s9pnlgUf5T0nR4=;
 b=ic0AuUTdmtGqCsiRNrp5zMW1yjMbbxBiTaMyvF5DbUNRAAMcu1VnhzlN7oB9eyGlI8
 rLlk0O8ZnaTXFjESaxv0qV4O+YKZ8ksBtZdJv16MeqAOgNfZtUwc4Hh6S5kPmP//DFtH
 MavoH5RhGipnA2Kzo0dkX+JnITj/KKIB0AmZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107896; x=1700712696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mpckdidkh4bEEYg7Aagzeuuxs6pA/s9pnlgUf5T0nR4=;
 b=w4hs+VEXMe9wjPb86I5fel1GLWhP2Kul231cFELoLfhwHUdd2FbB5NMP9C1Uq3/jFS
 oA53m03hj1eTz3sZMPktxqWTHMgvf088EvP7Jmuz2fQz9kgG9wkpCPDoTZFoGtCzMc3K
 J7r2XhNuu7544Ek29hb7Eroe6QhBDIvr/BJGr7fuLn3bS9roee6TmKgDR7KMBWZBxYW2
 GqF2ubYwSOz8SIYywJMoChefSq9rwBTKCYSVbFGKD3AgpTBbEjNxRAp/GQs8BN+AV17q
 345EjAz3gT3XiwrDLZmqFtIWKpne72dKaN2vgHJyzl8lh7ayayRbBt20rT+HzZFS5Gwr
 Gu5w==
X-Gm-Message-State: AOJu0YxWm/nOjAMxLnanrjxvv4tmwE8Y0tpy9xVdKKaFh62QDql/Hvvz
 8zItEEAoaKSfvccWrWRwQVPERGnJSvLjoCsJjcv96w==
X-Google-Smtp-Source: AGHT+IFc94uJIE1XOQqSaoo8foXuv6Qw6K4ymI6LBzb5zqnpvQkbob7tPZzaC0mC12934Y2bPSubaA==
X-Received: by 2002:a5e:8809:0:b0:7a2:dee5:84b6 with SMTP id
 l9-20020a5e8809000000b007a2dee584b6mr15456247ioj.21.1700107896074; 
 Wed, 15 Nov 2023 20:11:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 19/32] bootm: Reduce arguments to boot_get_ramdisk()
Date: Wed, 15 Nov 2023 21:10:19 -0700
Message-ID: <20231116041043.362055-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

