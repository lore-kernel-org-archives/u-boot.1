Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348FC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E877A874C7;
	Thu, 16 Nov 2023 05:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xh4JAgRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3580287478; Thu, 16 Nov 2023 05:11:34 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0918F874A0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so13860839f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107890; x=1700712690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4WuxUrA/2qwSnXlkO4LHME9ukTfofjlAU2HX8INFK0=;
 b=Xh4JAgRaxnLJbdSEVLiil6erFXXI3luehLMLKnXt9GsVpv9/QgRZz1lfwOijQ5G5uZ
 giP5xtEqx9O6AGQ1DqvD8ZFKenOT3Zg7YiodDMn/cX1EfzmFzzu4BQQS9ltKV/lyrA/D
 aWgniriVHN9dUVseRgvC2x/o9QXq9dgu/vLbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107890; x=1700712690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4WuxUrA/2qwSnXlkO4LHME9ukTfofjlAU2HX8INFK0=;
 b=m2/Wi8O808jk3+ZD/hGnOGiHYf5kaoQ75EGTu3FBL8n2jrovZMJT3I8ggvriw9v6Ap
 I+L1IiACK3lYShpOgFzAN+jsXYIey/VRVrEVN9yvwToFUmLyxKvaYwM4Zn1b7tzFLyW4
 kppXji4LwujX/QUdKQ5S9QMtzJABwoWJPAU98u5SrBWfpEMBufXDzgDnciepcIbOQ0qM
 qWhh8ZEytiAcgF7upobNLRW/aJpND6TRjEBBOSsATvtpKC9RdY6DLNOuR6wskipqLLx+
 AscYxIz1xtLg+c9wC2LZqftZHePRe/hZZUAK/TJ+v3Vo8CAeBkMXHVRIo/IM5SqbJjWc
 ZrvA==
X-Gm-Message-State: AOJu0YzylOMs6k4GjJNb739lo2AhquFfHEYNEoww+hBz45M4E6dFdy9w
 pCZGLLPpqHL1yGgPsr0HzZP7FhL0pKhG9dcBNtFH/g==
X-Google-Smtp-Source: AGHT+IHiUoP7wJ7u6QzjUuTImKny7r9459i0amiuPfZ7tkaWftFvEwUzTDV0mWHG8h94jT5fbz+F5Q==
X-Received: by 2002:a05:6e02:17cd:b0:35a:b184:74fb with SMTP id
 z13-20020a056e0217cd00b0035ab18474fbmr18574317ilu.9.1700107890603; 
 Wed, 15 Nov 2023 20:11:30 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 13/32] bootm: Adjust boot_get_kernel() to return an error
Date: Wed, 15 Nov 2023 21:10:13 -0700
Message-ID: <20231116041043.362055-14-sjg@chromium.org>
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

This function obtains lots of error codes and then throws them away.
Update it to return the error, moving the image pointer to an
argument.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Use the command table to provide the command name, instead of "bootm"

 boot/bootm.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index ea1575bd07eb..1f3a01994cbe 100644
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
@@ -316,8 +322,9 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	os_hdr = boot_get_kernel(cmdtp->name, argv[0], &images,
-				 &images.os.image_start, &images.os.image_len);
+	ret = boot_get_kernel(cmdtp->name, argv[0], &images,
+			      &images.os.image_start, &images.os.image_len,
+		       &os_hdr);
 	if (images.os.image_len == 0) {
 		puts("ERROR: can't get kernel image!\n");
 		return 1;
-- 
2.43.0.rc0.421.g78406f8d94-goog

