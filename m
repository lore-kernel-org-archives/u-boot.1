Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8C4D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C89189169;
	Fri, 18 Oct 2024 16:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E0JcufvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D856088E90; Fri, 18 Oct 2024 16:52:10 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999A788C4D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3f8b5fc45so167805ab.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263127; x=1729867927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajUTa3LwxnwJRDK9nxpbWZgvs6UFZZ/UDdW2t3DXsig=;
 b=E0JcufvV/lnNOvfIA8VK4tle+8w2aU0zzq7HETPWQQBNN5ebL+DY0cbMhnVWThC5Lg
 2YZWihtvlh+ZOnsjEkInmdhMhuIvBEc1hfEj9KAAR2NLT/vF9p1wEVaSMVoNOo0qMGH9
 w4VdN9WncQKwnBQx+gO56XzW4afAU3Rkm2kOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263127; x=1729867927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajUTa3LwxnwJRDK9nxpbWZgvs6UFZZ/UDdW2t3DXsig=;
 b=Z7GECCkeTJzuRMMRYIHgXSdwHpzFvJlonhBEzYhISiCGGR+fp2/Q1ayhZjxO+66ifq
 eR8QMrgB7tKGPQ8LiR00BST+FX0uB21pIy4uJsL+pjh5N28nWRanXJGC6tU5gP6YBwpQ
 HfWFokSlokAP0w+6rJrY9RNOxLUs6tjeZHpQy5DvnLNx1m3GFjZfRSr0sy5b80OKJXFc
 7XfBZ55mSToK50weG8k08PhI/1KVskNZv7rGJ85nCTe0ghh+f9/kHdAkGSE2Y4bWFTzG
 HEZlshWKtEW8UV7bpYEzKbhvRH4oQCvdNqdjV5ZQdm7lj2A20xkwZf8aqS7q9Ys2YC3p
 B9nA==
X-Gm-Message-State: AOJu0Yz6tOV2BdC+MBykZmvEXlwSQoRc5UGv9Zx6m1bfz7QRjXGpo+pN
 EDR1BxbfZtpt1M55aGhzcHn79UdAuia7qzUqvk6CfwE4iIaW16g++itp7rW4mGyoEMq/k2wGrxw
 =
X-Google-Smtp-Source: AGHT+IGlqqoeSe64jbKdZRwjj6UgF6ldrwTn3MT8PH5KbLDx7ub4d22o5ieyVcswypNk2M5jkz2hig==
X-Received: by 2002:a05:6e02:1789:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a3e52a7815mr44836845ab.5.1729263127124; 
 Fri, 18 Oct 2024 07:52:07 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 5/6] efi: Move the fallback code from efi_run_image()
Date: Fri, 18 Oct 2024 08:51:56 -0600
Message-Id: <20241018145157.3918429-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018145157.3918429-1-sjg@chromium.org>
References: <20241018145157.3918429-1-sjg@chromium.org>
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

This code is only needed if an invalid image/device path is passed in.
Move the code out to a caller where this can be dealt with. The normal
flow will provide these parameters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 104 ++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 920a4dfc74a..3646c706dd3 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -147,37 +147,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 				  struct efi_device_path *device,
 				  struct efi_device_path *image)
 {
-	efi_handle_t mem_handle = NULL, handle;
-	struct efi_device_path *file_path = NULL;
-	struct efi_device_path *msg_path;
+	efi_handle_t handle;
+	struct efi_device_path *msg_path, *file_path;
 	efi_status_t ret;
 	u16 *load_options;
 
-	if (!device || !image) {
-		log_debug("Not loaded from disk\n");
-		/*
-		 * Special case for efi payload not loaded from disk,
-		 * such as 'bootefi hello' or for example payload
-		 * loaded directly into memory via JTAG, etc:
-		 */
-		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)source_buffer,
-					    source_size);
-		/*
-		 * Make sure that device for device_path exist
-		 * in load_image(). Otherwise, shell and grub will fail.
-		 */
-		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
-							       &efi_guid_device_path,
-							       file_path, NULL);
-		if (ret != EFI_SUCCESS)
-			goto out;
-		msg_path = file_path;
-	} else {
-		file_path = efi_dp_concat(device, image, 0);
-		msg_path = image;
-		log_debug("Loaded from disk\n");
-	}
+	file_path = efi_dp_concat(device, image, 0);
+	msg_path = image;
 
 	log_info("Booting %pD\n", msg_path);
 
@@ -196,36 +172,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 	ret = do_bootefi_exec(handle, load_options);
 
 out:
-	if (mem_handle) {
-		efi_status_t r;
-
-		r = efi_uninstall_multiple_protocol_interfaces(
-			mem_handle, &efi_guid_device_path, file_path, NULL);
-		if (r != EFI_SUCCESS)
-			log_err("Uninstalling protocol interfaces failed\n");
-	}
-	efi_free_pool(file_path);
 
 	return ret;
 }
 
-/**
- * efi_binary_run_() - run loaded UEFI image
- *
- * @image_ptr:	memory address of the UEFI image
- * @size:	size of the UEFI image
- * @fdt:	device-tree
- * @device:	EFI device-path
- * @image:	EFI image-path
- *
- * Execute an EFI binary image loaded at @image.
- * @size may be zero if the binary is loaded with U-Boot load command.
- *
- * Return:	status code
- */
-efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
-			     struct efi_device_path *device,
-			     struct efi_device_path *image)
+static efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
+				    struct efi_device_path *device,
+				    struct efi_device_path *image)
 {
 	efi_status_t ret;
 
@@ -258,6 +211,45 @@ efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
  */
 efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 {
-	return efi_binary_run_(image, size, fdt, bootefi_device_path,
-			       bootefi_image_path);
+	efi_handle_t mem_handle = NULL;
+	struct efi_device_path *file_path = NULL;
+	efi_status_t ret;
+
+	if (!bootefi_device_path || !bootefi_image_path) {
+		log_debug("Not loaded from disk\n");
+		/*
+		 * Special case for efi payload not loaded from disk,
+		 * such as 'bootefi hello' or for example payload
+		 * loaded directly into memory via JTAG, etc:
+		 */
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image, size);
+		/*
+		 * Make sure that device for device_path exist
+		 * in load_image(). Otherwise, shell and grub will fail.
+		 */
+		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
+							       &efi_guid_device_path,
+							       file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			goto out;
+	} else {
+		log_debug("Loaded from disk\n");
+	}
+
+	ret = efi_binary_run_(image, size, fdt, bootefi_device_path,
+			      bootefi_image_path);
+out:
+	if (mem_handle) {
+		efi_status_t r;
+
+		r = efi_uninstall_multiple_protocol_interfaces(mem_handle,
+					&efi_guid_device_path, file_path, NULL);
+		if (r != EFI_SUCCESS)
+			log_err("Uninstalling protocol interfaces failed\n");
+	}
+	efi_free_pool(file_path);
+
+	return ret;
 }
+
-- 
2.34.1

