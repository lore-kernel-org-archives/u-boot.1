Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F4C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D0B87507;
	Sat, 18 Nov 2023 22:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Je5lEGti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634FF8713D; Sat, 18 Nov 2023 22:06:16 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF268711D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a6907e9aa8so116321639f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341564; x=1700946364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bLG8AEQfHJDDRGsM0j9bWlYOV+6OU41BKU3cmrRMlc=;
 b=Je5lEGtixp4tB9kiGXZwjJCE3VvXKN5q1L4k+Rkc8okO5yIaOpiCKoygyIUvWFX98K
 2gx7yF8p3gwZP4wNFtck3S2cowxHRN3W0TOtwC8LaUiE0CylzCbbBdHC07eoRcl0atSB
 7PCFNbreV9X5MPyuE5PmEtxkcU2li+3feApVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341564; x=1700946364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bLG8AEQfHJDDRGsM0j9bWlYOV+6OU41BKU3cmrRMlc=;
 b=tk8bqkEHW01K8ud9hS8mSUtFWuA/N3Lolld4Bhvb+L5fUszmHFKJJvmHKi8C62XCmj
 d1fxza7TVYqROigPeBf4x0HltBrNwLH2haCnTw0v/HnijC8uVfXMoCMFkciEgDTyUe0y
 e1/dRdBBIMC3oL3Alqj73Zu33tQ71BKuz8LZpX+v7hOMXV0j0P55N7njdOlr7IuwHg/w
 HstmWfNSNrvctdwexn9XfKj3Ln5Uh+TxggzSHffaEUx44LlG5D2WoJfZsvLdQjwTOoOb
 JmPWVv42flm18Kw6hynbzkTLXGc4xZ1dVF9mwvky2dGB0Hp6NU8bsvE1+sj4yOwqRNEz
 EX+A==
X-Gm-Message-State: AOJu0Yx7thRdkyNwDu6vWaI99NzbW50Xgh81NRVc26uN9pyJ031vx06o
 zi/7HAbirKtFS2orfFAiIncDIvi7kgd6JuvtnW/Upw==
X-Google-Smtp-Source: AGHT+IFF/DPa5kMDNR08ylbLJEpxVOY2br9xiDvg0rNA4q8z4ghPQCR0DXzkcdo6YVe68Yx1J7ExlQ==
X-Received: by 2002:a5d:8246:0:b0:787:1472:3181 with SMTP id
 n6-20020a5d8246000000b0078714723181mr3974919ioo.3.1700341564564; 
 Sat, 18 Nov 2023 13:06:04 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 10/32] bootm: Reduce arguments to boot_get_kernel()
Date: Sat, 18 Nov 2023 14:04:58 -0700
Message-ID: <20231118210547.577026-11-sjg@chromium.org>
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

This function only uses one argument and just needs to know the name of
the command which called it. Adjust the function to use only what it
needs. This will make it easier to call from a non-command context.

Tidy up the function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

