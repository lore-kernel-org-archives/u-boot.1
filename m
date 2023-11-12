Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD1DC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD17876E5;
	Sun, 12 Nov 2023 01:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHaPWaaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC1986FA6; Sun, 12 Nov 2023 01:10:18 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368C08701D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-357cf6725acso12970875ab.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747781; x=1700352581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xm2oP5vBKH83PgGyAXghAh0pjF+6GgIN8dVun7VVU6Q=;
 b=YHaPWaaWhvWwW/dqBo/67AcoWJxXhksEXhdqsWcBGgo6yFf/lih+YLwKK2zqfmQvlv
 qB3x6o4hlDaAsEbHtRx5r6pLJGhyVMMCdgcfSUnD7SOb1K4/TBAXJ/Nmc2ZaRF+QJgSh
 odPT4EuKoFyAFmDhVIBVdoQyAkV3UtEdIg8B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747781; x=1700352581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xm2oP5vBKH83PgGyAXghAh0pjF+6GgIN8dVun7VVU6Q=;
 b=t+X+kYoHRtLMr5Qeoss3On++jQ765CwADcH96+qrXXHIuXV6hV/NdZFRk6HfUkWaHp
 FCcOZ3TCx6hoPZXpbK2sD61/lbh9+3Iy0IVsl5x/22B5C1BT6U7ffr9ZgljHMIBHIGBZ
 lrN6+NyNFurs3fAh6JiICEZIdWqhe1dHXd62u/sCK3fWYuheAciT/qh0k9Dj5fJUK0jy
 o9ZS9vpar6oxcUP8V8PwSSHoW70dkC3b5F4EmgFgaZY13ood/uuskpBvm0/ZYToL6tlv
 FMe58jVBvbUj9R/1eASSmKzcpnh1pN2Gd4oXMhldvPsheicV1MIDMR8fs/Sl3et+0Gsw
 Uxgg==
X-Gm-Message-State: AOJu0YxI50CYvk/xs4HD5V+cKUo0Wy9lJjpocpBoxzqMuxoWdoyHJmys
 HxCw2fCfo7tCg+WxJFDHrM+ANna6zZvP+CuMxpbz6Q==
X-Google-Smtp-Source: AGHT+IE2Kc9zqUvPYZS7eI9QPxhdFu6kEECpqNR3ie0dAUTCnpbT9F3pjJeg3ON1bFoa9hzZJMtdxQ==
X-Received: by 2002:a05:6e02:2148:b0:35a:b337:6f58 with SMTP id
 d8-20020a056e02214800b0035ab3376f58mr1860910ilv.16.1699747781629; 
 Sat, 11 Nov 2023 16:09:41 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 12/29] bootm: Adjust boot_get_kernel() to return an error
Date: Sat, 11 Nov 2023 17:08:57 -0700
Message-ID: <20231112000923.73568-13-sjg@chromium.org>
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

This function obtains lots of error codes and then throws them away.
Update it to return the error, moving the image pointer to an
argument.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 2b986ca71b92..57eaa1ff10df 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -110,6 +110,7 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  * @os_len: pointer to a ulong variable, will hold os data length
  *     address and length, otherwise NULL
  *     pointer to image header if valid image was found, plus kernel start
+ * @kernp: image header if valid image was found, otherwise NULL
  *
  * boot_get_kernel() tries to find a kernel image, verifies its integrity
  * and locates kernel data.
@@ -118,9 +119,9 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  *     pointer to image header if valid image was found, plus kernel start
  *     address and length, otherwise NULL
  */
-static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
-				   struct bootm_headers *images,
-				   ulong *os_data, ulong *os_len)
+static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
+			   struct bootm_headers *images, ulong *os_data,
+			   ulong *os_len, const void **kernp)
 {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	struct legacy_img_hdr	*hdr;
@@ -154,7 +155,7 @@ static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
 		       img_addr);
 		hdr = image_get_kernel(img_addr, images->verify);
 		if (!hdr)
-			return NULL;
+			return -EINVAL;
 		bootstage_mark(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 
 		/* get os_data and os_len */
@@ -175,7 +176,7 @@ static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
 			printf("Wrong Image Type for %s command\n",
 			       cmd_name);
 			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
-			return NULL;
+			return -EPROTOTYPE;
 		}
 
 		/*
@@ -200,7 +201,7 @@ static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
 				BOOTSTAGE_ID_FIT_KERNEL_START,
 				FIT_LOAD_IGNORED, os_data, os_len);
 		if (os_noffset < 0)
-			return NULL;
+			return -ENOENT;
 
 		images->fit_hdr_os = map_sysmem(img_addr, 0);
 		images->fit_uname_os = fit_uname_kernel;
@@ -209,7 +210,9 @@ static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
 		break;
 #endif
 #ifdef CONFIG_ANDROID_BOOT_IMAGE
-	case IMAGE_FORMAT_ANDROID:
+	case IMAGE_FORMAT_ANDROID: {
+		int ret;
+
 		boot_img = buf;
 		vendor_boot_img = NULL;
 		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
@@ -217,25 +220,28 @@ static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
 			vendor_boot_img = map_sysmem(get_avendor_bootimg_addr(), 0);
 		}
 		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
-		if (android_image_get_kernel(boot_img, vendor_boot_img, images->verify,
-					     os_data, os_len))
-			return NULL;
+		ret = android_image_get_kernel(boot_img, vendor_boot_img,
+					       images->verify, os_data, os_len);
+		if (ret)
+			return ret;
 		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
 			unmap_sysmem(vendor_boot_img);
 			unmap_sysmem(boot_img);
 		}
 		break;
+	}
 #endif
 	default:
 		printf("Wrong Image Format for %s command\n", cmd_name);
 		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
-		return NULL;
+		return -EBADF;
 	}
 
 	debug("   kernel data at 0x%08lx, len = 0x%08lx (%ld)\n",
 	      *os_data, *os_len, *os_len);
+	*kernp = buf;
 
-	return buf;
+	return 0;
 }
 
 #ifdef CONFIG_LMB
@@ -316,8 +322,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	os_hdr = boot_get_kernel("bootm", argv[0], &images,
-				 &images.os.image_start, &images.os.image_len);
+	ret = boot_get_kernel("bootm", argv[0], &images, &images.os.image_start,
+			      &images.os.image_len, &os_hdr);
 	if (images.os.image_len == 0) {
 		puts("ERROR: can't get kernel image!\n");
 		return 1;
-- 
2.42.0.869.gea05f2083d-goog

