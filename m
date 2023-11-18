Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7C7C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88565870F9;
	Sat, 18 Nov 2023 22:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EkKptBfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3DD874A5; Sat, 18 Nov 2023 22:06:27 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D19870C3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a6907e9aa8so116323039f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341570; x=1700946370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+cjR4R2Xxc+MUcZsL2OJEHBHSoW73+5ZuGdon6uadc=;
 b=EkKptBfHXV8qkhZbDsQ+IBkC6Y7jgGTKexBMfMXzDrQV22nYb17F+tLrvLqf86AzTG
 g6wobos3Fa98MMGA55TuY9g4zPczSs/jQJW9IsvgNJzTSE7K3zenxQmZlAvXjy4J3s7P
 CNfpW5b9iFnDxSivPwl4auYGKspSsWZc7kx/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341570; x=1700946370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+cjR4R2Xxc+MUcZsL2OJEHBHSoW73+5ZuGdon6uadc=;
 b=e6u2smzOZX9l5qPG1hqzCl51S0ZsRg05Op1ezWGY/G3Ru7mDa9ZEZfARjoikXHah6c
 OHHmUDV3RlNmwgKwaOx5/iZye0npelNDeWlPR8+dj7aygoQNV3NGITrSw4GCiFzsD/hq
 8mA68s+VbbjailQlub7XX1dCwkVhUAS2TnvGvVFU8v7/jjsdMrcjJUSjL+TfhThyl5BT
 pGTNKyJE0HbNZ5FjYz3GNwtlrVGo2Kn6Y0UjPTnx0ZZyaotibLWE5je3EdAEH4va0tkT
 tu1OMv/KZO324k/z2CRfgmRh8sgTwqwsPDlZbVVMOEVeARPnUPhEhE928gr7MDSP78po
 P19Q==
X-Gm-Message-State: AOJu0YxUKlm0NIwkXONs9qyKzbeLie08waGZQVC+dUZ9gjUh3tU/tWe0
 pC3N2BdQC0LA0uLWnGTRroycOSq7hwCc9lVng5FOBQ==
X-Google-Smtp-Source: AGHT+IERq3YZ2WkL2I3ecOjtBhfs6sNLkomt38XXqstEA4B8MWSHL2pRQgZPIUw8wV4QrNBhf8GnVQ==
X-Received: by 2002:a5e:c305:0:b0:792:9a1a:228b with SMTP id
 a5-20020a5ec305000000b007929a1a228bmr4135192iok.2.1700341569912; 
 Sat, 18 Nov 2023 13:06:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 16/32] bootm: Move error printing out of boot_get_kernel()
Date: Sat, 18 Nov 2023 14:05:04 -0700
Message-ID: <20231118210547.577026-17-sjg@chromium.org>
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

The same error message is printed in two places. Move it out to the
caller so we can avoid passing in the command name. Leave the bootstage
handling where it is.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

