Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7E1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3058781C;
	Sun, 12 Nov 2023 01:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FEvk9++e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFFB86F84; Sun, 12 Nov 2023 01:10:48 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B38874D3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35749078a59so12198445ab.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747795; x=1700352595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYhWm80PS9FhH6O4R080oBB98g75yj/6zLzl2HICKfA=;
 b=FEvk9++ef8ocdglvCblIZn8fyUOR3P19ZPg/9beY4SOcxOXW3j75pk++iiL4CDB1D/
 PS5G97dBfMj7Ag53HYQYAF4KTmtKQdp3LdvESnqneTzwXMMAe7or+nEPvkl5TIZ5hfrw
 BPCOmJ1LPIUU+opOsOaT/HfebkEOT25mVfkC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747795; x=1700352595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYhWm80PS9FhH6O4R080oBB98g75yj/6zLzl2HICKfA=;
 b=t6Gj5Ob72bTsg9XCFuC5hJsK2U9CTS6pxeqZU2khE93onZDj/cng5WHuIfPzwFCKX4
 jTCjn5NlMILMHzEaWmc4G8/ahQ3t3bUzFM459JWJeBfyDrO2UuZqusHcaBrQSK6anaEL
 RISBFiFQm2kuvoyDxuzJ5InCssS2VQ8Yu7s1pb+/eTOFIAibb7TU74MvOFKSi3UtKhKQ
 0DGKWFWmIcRRgxxm3Y6dhkqT6U3p5MqcHmaZ9z4wiVNFL1I98fzUES9/PN+ssFIR2HtO
 4KNmE45uK81UFj1NZclrs0p7Ckf+Qkh//b5Bn2UfBH0eL4pAf19KOHMNO1P1NAFICHhv
 xMaw==
X-Gm-Message-State: AOJu0YxMafEiGA4rCPnMTbtleUap/RqmP4uzlcOZ7n0uTvDAL1R6VKbA
 cLoNhWvzl+yPSTtvF6uiILsBRdBh1YnGllvz00FlBg==
X-Google-Smtp-Source: AGHT+IH9B6MYqLgYGwL4KPZl+4CS5CC6TGSPQVH+lX8MQKu8WFBoxJyvmN1N0I1LR8GJHiq8cNmZnw==
X-Received: by 2002:a05:6e02:170d:b0:359:4223:572f with SMTP id
 u13-20020a056e02170d00b003594223572fmr5332745ill.31.1699747795073; 
 Sat, 11 Nov 2023 16:09:55 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
Date: Sat, 11 Nov 2023 17:09:12 -0700
Message-ID: <20231112000923.73568-28-sjg@chromium.org>
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

Rather than passing it all the command-line args, pass in the pieces
that it needs. These are the image address, the ramdisk address/name
and the FDT address/name.

Ultimately this will allow usage of this function without being called
from the command line.

Move the function comment to the header file and tidy it a little.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 45 ++++++++++++++-------------------------------
 cmd/booti.c     |  4 +++-
 cmd/bootz.c     |  4 +++-
 include/bootm.h | 26 +++++++++++++++++++++++---
 4 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 62b6ca957f5b..54e4b48e907c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -467,35 +467,14 @@ static int bootm_find_os(const char *addr_fit)
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
@@ -505,8 +484,8 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		}
 	}
 
-	if (argc >= 2)
-		select = argv[1];
+	if (conf_ramdisk)
+		select = conf_ramdisk;
 
 	/* find ramdisk */
 	ret = boot_get_ramdisk(select, &images, IH_INITRD_ARCH,
@@ -532,9 +511,8 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
@@ -583,8 +561,13 @@ static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
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
2.42.0.869.gea05f2083d-goog

