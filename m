Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA2C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AC487513;
	Sat, 18 Nov 2023 22:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EfV3Q5UR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E6187504; Sat, 18 Nov 2023 22:06:18 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A42387446
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a93df91813so109342439f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341566; x=1700946366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XjPMCf9eo8echRV1tadOaSH2JeeDkBzMQfNGyTIR3I=;
 b=EfV3Q5UROfb+MZKSdtkWNiQTnepo3vFmeshZmV1O5NVgmXcKNvizDkdSLOYZP9xiGd
 hzq5Nb8QROXWuZFGPysq5pymthHXngfDfTxVGB0KvFIPwKwVYvMs9GyHi2X5ai0+X84w
 fYohIrUJgnAxTl3Ig12LA7TjFHJUtoUI/PUBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341566; x=1700946366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XjPMCf9eo8echRV1tadOaSH2JeeDkBzMQfNGyTIR3I=;
 b=aHhD/2KzGvFMJjb+9ISmJUIcT7PqvNrIrsenuLmJEq97U0A551EFIXDKbb2fz2zp4q
 UX7dl5Ed5SIHKWstDPVC7RqB1hYzCJa4/q1WHeoh25nNiOkmZ7rruomi2Y4uyPO0b1/0
 PGskmuekL1iT82RI3xUHovJ6biPVG7EmIUVMTygfSA9+3Nrfz7ygkIyHmHDE5Q4cLL96
 q5ErWy+Yex9z4IE16mGzSin0u+hz6HPXEQhOQvITCN1u/Usnag57gbqGs5TeeVErZkYt
 cN0Dp/4RT5lMcrU5U10Labwa2BhjMBNVrILYjgL3F+NcBQPLLA27IL3IJX13sLHaJFku
 w93A==
X-Gm-Message-State: AOJu0YxMNeu8JIDQQdZgTll4R1RI7rSGLsElfFZx07ONd7nQRIwcr43L
 pB0277xt6664KCiZz5Vb0XSTWqmtLOOfySgzpBOjOQ==
X-Google-Smtp-Source: AGHT+IFhpR/nUWbjLkj5n1ynIXwCyHmtWc2GZFoAycCop/0U3q/gtHHpkyFb7Tk1xiERJD5SNiBajA==
X-Received: by 2002:a6b:c545:0:b0:7b0:ae77:36ed with SMTP id
 v66-20020a6bc545000000b007b0ae7736edmr939332iof.13.1700341566426; 
 Sat, 18 Nov 2023 13:06:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 12/32] bootm: Adjust boot_get_kernel() to return an error
Date: Sat, 18 Nov 2023 14:05:00 -0700
Message-ID: <20231118210547.577026-13-sjg@chromium.org>
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

This function obtains lots of error codes and then throws them away.
Update it to return the error, moving the image pointer to an
argument.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

