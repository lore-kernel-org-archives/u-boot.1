Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6CAC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6331874DA;
	Thu, 16 Nov 2023 05:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LhTh1mGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E644F874D0; Thu, 16 Nov 2023 05:11:37 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3AA874AD
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35aa6107e9fso1645375ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107894; x=1700712694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xSzDUm6GUNqFwMBrj+wt6nLmbypNX4vy00IgbboPxA=;
 b=LhTh1mGEdrQKpjPNOK3jnAZHZLcafU0UMCK7RySmLVnZZsRkg547/fe09Zd/foYLRn
 Eckx0BnRRzjb+1G5FAmL2HmnNFCLmnXWqdrIdoDa1It6M+EqIHDDdhjFBVC1L+9ix+/p
 qahRAqR+qONXlod/e6jmnzaJr3mg5xeK99ILw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107894; x=1700712694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xSzDUm6GUNqFwMBrj+wt6nLmbypNX4vy00IgbboPxA=;
 b=HgCi/cR3EsvFZh2zYf9L6g6vfV8rRSoZDpVVuzRIKqAML3WLYfuL70kuBfVoWdZuJy
 z+lEfAQWJdPchhnOka+7zK1QSWin1uTN59MhcdHKwGcUvez1pIiV8o0BY/nbznC+4jaG
 7kaYks0jfFK7Q+qb8EHH1+Way33+IjobOIGZkF6Sfz6zDYWUn2W817m8cdl2EkmVuC8b
 k+u1pnmPvndQpTP2th1vvM3gBy1JC5YcEURPMxd6inCROVNvDWlgQZ1caNWrjh1CRNiP
 XIBZtHH/vDvt9gszpD8GGt+zMfB5dvMSNLb6FNsPMOKjcZ3d0B1r3XcTecr7eP2us6hL
 mTBw==
X-Gm-Message-State: AOJu0Yymd3GNFz5l7qxkHoJpLzSarWXtfFU5+xQXZXe9KBgRcvWDNBq+
 aNBfPrwu2p5OCZMM/rm+HkoLVsbIcCLUhytgzBVGzg==
X-Google-Smtp-Source: AGHT+IF3EsYO0LkDr3B3069DLfCAvmFLi6/U8pIeq0/RHAcgDvl8lUJxu9ee9kAU0kpWlENChfiwjQ==
X-Received: by 2002:a05:6e02:1d09:b0:357:8d71:347f with SMTP id
 i9-20020a056e021d0900b003578d71347fmr20557539ila.8.1700107894353; 
 Wed, 15 Nov 2023 20:11:34 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 17/32] bootm: Move error printing out of boot_get_kernel()
Date: Wed, 15 Nov 2023 21:10:17 -0700
Message-ID: <20231116041043.362055-18-sjg@chromium.org>
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

The same error message is printed in two places. Move it out to the
caller so we can avoid passing in the command name. Leave the bootstage
handling where it is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the command table to provide the command name, instead of "bootm"

 boot/bootm.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 9bd93f5dee7a..7aca2bf8146c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -104,7 +104,6 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
 /**
  * boot_get_kernel() - find kernel image
  *
- * @cmd_name: Name of the command calling this function, e.g. "bootm"
  * @addr_fit: first argument to bootm: address, fit configuration, etc.
  * @os_data: pointer to a ulong variable, will hold os data start address
  * @os_len: pointer to a ulong variable, will hold os data length
@@ -115,13 +114,11 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  * boot_get_kernel() tries to find a kernel image, verifies its integrity
  * and locates kernel data.
  *
- * returns:
- *     pointer to image header if valid image was found, plus kernel start
- *     address and length, otherwise NULL
+ * Return: 0 on success, -ve on error. -EPROTOTYPE means that the image is in
+ * a wrong or unsupported format
  */
-static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
-			   struct bootm_headers *images, ulong *os_data,
-			   ulong *os_len, const void **kernp)
+static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
+			   ulong *os_data, ulong *os_len, const void **kernp)
 {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	struct legacy_img_hdr	*hdr;
@@ -173,8 +170,6 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 			*os_len = image_get_data_size(hdr);
 			break;
 		default:
-			printf("Wrong Image Type for %s command\n",
-			       cmd_name);
 			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 			return -EPROTOTYPE;
 		}
@@ -232,9 +227,8 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 	}
 #endif
 	default:
-		printf("Wrong Image Format for %s command\n", cmd_name);
 		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
-		return -EBADF;
+		return -EPROTOTYPE;
 	}
 
 	debug("   kernel data at 0x%08lx, len = 0x%08lx (%ld)\n",
@@ -322,10 +316,13 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	ret = boot_get_kernel(cmdtp->name, argv[0], &images,
-			      &images.os.image_start, &images.os.image_len,
-			      &os_hdr);
+	ret = boot_get_kernel(argv[0], &images, &images.os.image_start,
+			      &images.os.image_len, &os_hdr);
 	if (ret) {
+		if (ret == -EPROTOTYPE)
+			printf("Wrong Image Type for %s command\n",
+			       cmdtp->name);
+
 		printf("ERROR %dE: can't get kernel image!\n", ret);
 		return 1;
 	}
-- 
2.43.0.rc0.421.g78406f8d94-goog

