Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA9C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64ED78755A;
	Sat, 18 Nov 2023 22:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IufFvt6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396D186FC9; Sat, 18 Nov 2023 22:06:38 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68E986F95
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7b063a6420dso81852739f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341581; x=1700946381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DK1vRDL3fIxrh/9oQHdQ4Or8TuX0aJ6e+eIa9BPHwXI=;
 b=IufFvt6TGbdqS2aHxwsIU1VOzqfA++Bm87us4kc98Fw/bXqRXS84zFzDAuP/Pn8KbF
 bOFjwKTRgTHXl+uhspCZ0tzBxUwNq/+DrIeOrEiuLjAiqdjwtJCkZgU4iqgPHziJtg1w
 dlOpoHnxj8nHrq/BrS2LauticzLKbHj3/09JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341581; x=1700946381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DK1vRDL3fIxrh/9oQHdQ4Or8TuX0aJ6e+eIa9BPHwXI=;
 b=QXITkmFfJFMWu4yh9/lz1BQ2jSsJScZsqqO+JrT7gvls9aqVcbmQaFwijgkpj2J+2y
 OISzQWq/gYxWPwaQZyQXgPRV1Am24uWmKyErOFUobKq+FXy2gFbwDxuqyGIj0G+37TGF
 R9rKegEaPPjhqNY6PFee0ZXzn6aYjvnC5K0ejOxxJNj0DZZSwzi8FX6QSCnUYHuV62l+
 1Xbcv5LLVnEj/NnC1bUc6owPwoaEi1LxHwgsEjOIHyOAl+XzR7+3/zjeSW9CmlT4ggkD
 en34VH2KtWpcHGcmzquTuSgBsz2ZNj5/EtPOFEidAXzc/k+4lxrYAwzqNUX2RziaCD8T
 aHPQ==
X-Gm-Message-State: AOJu0YxInYjkRj1vdTqR0vUmo1hEVKbfBg4wMwqS0YLng3SM4p8pUkSI
 FRpIlGldupunAar7PxoZq5iw5NEXSyQtw8pQlHVNuQ==
X-Google-Smtp-Source: AGHT+IHEtrEumb7JuJaXCACI5DGT56Znqfj2BWIN5MeeWS10Sm2jPTQrNuxPBePGc97J9O/29KQxIQ==
X-Received: by 2002:a5e:aa17:0:b0:7a6:7b18:dbf3 with SMTP id
 s23-20020a5eaa17000000b007a67b18dbf3mr7639567ioe.7.1700341581431; 
 Sat, 18 Nov 2023 13:06:21 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 28/32] bootm: Adjust the parameters of bootm_find_images()
Date: Sat, 18 Nov 2023 14:05:16 -0700
Message-ID: <20231118210547.577026-29-sjg@chromium.org>
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

Rather than passing it all the command-line args, pass in the pieces
that it needs. These are the image address, the ramdisk address/name
and the FDT address/name.

Ultimately this will allow usage of this function without being called
from the command line.

Move the function comment to the header file and tidy it a little.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 45 ++++++++++++++-------------------------------
 cmd/booti.c     |  4 +++-
 cmd/bootz.c     |  4 +++-
 include/bootm.h | 26 +++++++++++++++++++++++---
 4 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 45491e3f30aa..fe6e84601f58 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -468,35 +468,14 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 	return 0;
 }
 
-/**
- * bootm_find_images - wrapper to find and locate various images
- * @flag: Ignored Argument
- * @argc: command argument count
- * @argv: command argument list
- * @start: OS image start address
- * @size: OS image size
- *
- * boot_find_images() will attempt to load an available ramdisk,
- * flattened device tree, as well as specifically marked
- * "loadable" images (loadables are FIT only)
- *
- * Note: bootm_find_images will skip an image if it is not found
- *
- * @return:
- *     0, if all existing images were loaded correctly
- *     1, if an image is found but corrupted, or invalid
- */
-int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
-		      ulong size)
+int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
+		      const char *conf_fdt, ulong start, ulong size)
 {
-	const char *select = NULL;
+	const char *select = conf_ramdisk;
 	char addr_str[17];
-	ulong img_addr;
 	void *buf;
 	int ret;
 
-	img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
-
 	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
 		/* Look for an Android boot image */
 		buf = map_sysmem(images.os.start, 0);
@@ -506,8 +485,8 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		}
 	}
 
-	if (argc >= 2)
-		select = argv[1];
+	if (conf_ramdisk)
+		select = conf_ramdisk;
 
 	/* find ramdisk */
 	ret = boot_get_ramdisk(select, &images, IH_INITRD_ARCH,
@@ -533,9 +512,8 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		buf = map_sysmem(img_addr, 0);
 
 		/* find flattened device tree */
-		ret = boot_get_fdt(buf, argc > 2 ? argv[2] : NULL,
-				   IH_ARCH_DEFAULT, &images, &images.ft_addr,
-				   &images.ft_len);
+		ret = boot_get_fdt(buf, conf_fdt, IH_ARCH_DEFAULT, &images,
+				   &images.ft_addr, &images.ft_len);
 		if (ret) {
 			puts("Could not find a valid device tree\n");
 			return 1;
@@ -584,8 +562,13 @@ static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
 	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
-	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE))
-		return bootm_find_images(flag, argc, argv, 0, 0);
+	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE)) {
+		ulong img_addr;
+
+		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+		return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
+					 argc > 2 ? argv[2] : NULL, 0, 0);
+	}
 
 	return 0;
 }
diff --git a/cmd/booti.c b/cmd/booti.c
index a6c7db272c57..dc73c83f0db0 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -95,7 +95,9 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
-	if (bootm_find_images(flag, argc, argv, relocated_addr, image_size))
+	if (bootm_find_images(image_load_addr, argc > 1 ? argv[1] : NULL,
+			      argc > 2 ? argv[2] : NULL, relocated_addr,
+			      image_size))
 		return 1;
 
 	return 0;
diff --git a/cmd/bootz.c b/cmd/bootz.c
index dd6fe4904b02..bcf232b4f305 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -54,7 +54,9 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
 	 * have a header that provide this informaiton.
 	 */
-	if (bootm_find_images(flag, argc, argv, images->ep, zi_end - zi_start))
+	if (bootm_find_images(image_load_addr, argc > 1 ? argv[1] : NULL,
+			      argc > 2 ? argv[2] : NULL, images->ep,
+			      zi_end - zi_start))
 		return 1;
 
 	return 0;
diff --git a/include/bootm.h b/include/bootm.h
index 10a1bd65a754..f5229ea90b33 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -52,9 +52,29 @@ int boot_selected_os(int argc, char *const argv[], int state,
 
 ulong bootm_disable_interrupts(void);
 
-/* This is a special function used by booti/bootz */
-int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
-		      ulong size);
+/**
+ * bootm_find_images() - find and locate various images
+ *
+ * @img_addr: Address of image being loaded
+ * @conf_ramdisk: Indicates the ramdisk to use (typically second arg of bootm)
+ * @conf_fdt: Indicates the FDT to use (typically third arg of bootm)
+ * @start: OS image start address
+ * @size: OS image size
+ *
+ * boot_find_images() will attempt to load an available ramdisk,
+ * flattened device tree, as well as specifically marked
+ * "loadable" images (loadables are FIT only)
+ *
+ * Note: bootm_find_images will skip an image if it is not found
+ *
+ * This is a special function used by booti/bootz
+ *
+ * Return:
+ *     0, if all existing images were loaded correctly
+ *     1, if an image is found but corrupted, or invalid
+ */
+int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
+		      const char *conf_fdt, ulong start, ulong size);
 
 /*
  * Measure the boot images. Measurement is the process of hashing some binary
-- 
2.43.0.rc0.421.g78406f8d94-goog

