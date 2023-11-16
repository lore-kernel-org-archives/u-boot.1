Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43163C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB5F874B1;
	Thu, 16 Nov 2023 05:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QCIt9bcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96804874A8; Thu, 16 Nov 2023 05:11:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B9F8747E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a6acc8e222so13598239f.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107888; x=1700712688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcDWD2wC0MAfX89sgqb8mN4RF2DW6ADQ8oxRYXrL1cQ=;
 b=QCIt9bcdNkkGhtsW50SjRv2YCXP3+OYHp6shpfIsJbggxfDnpXN0o/mpt1cPno9MmP
 JxnyJHBv9bHZNK1dvAq0A7ILjI0TSLcIrRNKbL2WBA6Hz03riPblopKzRiNl0uCR65E3
 BuGn9nUQcDVmxgS8QglUMbcZ9QdIDjMECodXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107888; x=1700712688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcDWD2wC0MAfX89sgqb8mN4RF2DW6ADQ8oxRYXrL1cQ=;
 b=lu4NFL+vcjqdNg5Le5ngGYEbVGnBR9d3ZVmkpA20g6cHHP9ttBKIcYuWLpTD5349lz
 izXZUGd35HPkqYpRFktwWL3CvZ7+Te6qVS75eLI10Jeb+c880rw1sDzpYacRk/KXr7Gt
 9vcwK9UbVQ2GObQBYrvZOKS1xgxBq2LdkVDj+p/5s+NlFDsmmBBOhXNmaz4cSAGorrYC
 wBaNvMN99C0cduu/IffRVnmhh+Woq+7eyu9xt+C1XMgabh4uCn+IGhCNdwd4CJE+/NvH
 aATkyz8GneOtkuuiadjJR98PPaccWb5R21LDE6troyM34mRCn4X88bWcSzBzCZUlGRyj
 2L2Q==
X-Gm-Message-State: AOJu0Yy9rpbyV/SrLZMHwq5oNLOhwJb/g90TgHkex0UpVla4uraMhaKR
 Pf7jlC4j1/5wIGvGmkBm95u4eW9KTzZZzHRyKXD3Jw==
X-Google-Smtp-Source: AGHT+IGNZwhB+SyYP87KDvTpTS4G6611KhqaNsfNh5Owu0jmb7a69ghae0Z/PiRuKuJezoX2o1FOgA==
X-Received: by 2002:a05:6e02:1542:b0:35a:b283:d14c with SMTP id
 j2-20020a056e02154200b0035ab283d14cmr16591172ilu.3.1700107888648; 
 Wed, 15 Nov 2023 20:11:28 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 11/32] bootm: Reduce arguments to boot_get_kernel()
Date: Wed, 15 Nov 2023 21:10:11 -0700
Message-ID: <20231116041043.362055-12-sjg@chromium.org>
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

This function only uses one argument and just needs to know the name of
the command which called it. Adjust the function to use only what it
needs. This will make it easier to call from a non-command context.

Tidy up the function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the command table to provide the command name, instead of "bootm"

 boot/bootm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index e323c8b758e9..ea1575bd07eb 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -102,9 +102,14 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
 #endif
 
 /**
- * boot_get_kernel - find kernel image
+ * boot_get_kernel() - find kernel image
+ *
+ * @cmd_name: Name of the command calling this function, e.g. "bootm"
+ * @addr_fit: first argument to bootm: address, fit configuration, etc.
  * @os_data: pointer to a ulong variable, will hold os data start address
  * @os_len: pointer to a ulong variable, will hold os data length
+ *     address and length, otherwise NULL
+ *     pointer to image header if valid image was found, plus kernel start
  *
  * boot_get_kernel() tries to find a kernel image, verifies its integrity
  * and locates kernel data.
@@ -113,8 +118,8 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  *     pointer to image header if valid image was found, plus kernel start
  *     address and length, otherwise NULL
  */
-static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
-				   char *const argv[], struct bootm_headers *images,
+static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
+				   struct bootm_headers *images,
 				   ulong *os_data, ulong *os_len)
 {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
@@ -131,8 +136,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 	const void *boot_img;
 	const void *vendor_boot_img;
 #endif
-	img_addr = genimg_get_kernel_addr_fit(argc < 1 ? NULL : argv[0],
-					      &fit_uname_config,
+	img_addr = genimg_get_kernel_addr_fit(addr_fit, &fit_uname_config,
 					      &fit_uname_kernel);
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
@@ -169,7 +173,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		default:
 			printf("Wrong Image Type for %s command\n",
-			       cmdtp->name);
+			       cmd_name);
 			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 			return NULL;
 		}
@@ -223,7 +227,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 		break;
 #endif
 	default:
-		printf("Wrong Image Format for %s command\n", cmdtp->name);
+		printf("Wrong Image Format for %s command\n", cmd_name);
 		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
 		return NULL;
 	}
@@ -312,8 +316,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	os_hdr = boot_get_kernel(cmdtp, flag, argc, argv,
-			&images, &images.os.image_start, &images.os.image_len);
+	os_hdr = boot_get_kernel(cmdtp->name, argv[0], &images,
+				 &images.os.image_start, &images.os.image_len);
 	if (images.os.image_len == 0) {
 		puts("ERROR: can't get kernel image!\n");
 		return 1;
-- 
2.43.0.rc0.421.g78406f8d94-goog

