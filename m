Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D77E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227098021F;
	Wed, 11 Dec 2024 23:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kYfeFuDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A748801B6; Wed, 11 Dec 2024 23:38:44 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D45801EA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a815ed5acfso132895ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956719; x=1734561519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9jM+qrm3PnakGZAY9HDCrWs8Wy6qQI5L04VjO1D3D8=;
 b=kYfeFuDvv4SXTDuI8ZJplnuTsr+17aFI9W7u11xyV5HebKodE5QBdXVhS+hALmF/gd
 koPG+G5o4E52PGfimOvwpeSjSEidbfXOu2K/TQPIJMO+h4/NQS4L4w2Y03EpCyjDuLII
 iBNfd6UzsCwkIOPl6z/BshHfxwIqwCxkmaVdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956719; x=1734561519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9jM+qrm3PnakGZAY9HDCrWs8Wy6qQI5L04VjO1D3D8=;
 b=XJx2hPgmB+vF1Kzr2BMjJxCLBsG+whcj3dxDFF+8IFg3kTyx/c41V9g4zi7gXhtzzU
 8Vj5Udg+Bv42/XTWAqmBmYQrENO8G7gSueyqYh8l0+yWAhQ9VKZkaPdGsxmY/vYhTMXw
 o9uw9pvof1FCFd23l0dyhglfOiX85iJbGZzab4FNZV9I2aSyOOW8xrEA7JOM6uBFw6CT
 sHTdhYukJ3IWrIGJrtSUsv6L5oIDr7ctEbdHv7pOPFVPnY5ifCwNhkKYYnR0yIsCJyzj
 UXQPoDPOS4V8G2GJJSFPbBXU7MxjQuwLWVM7oWuLMARNPU3SuJS4fiVwLn9FhYX0kUCP
 Ds5Q==
X-Gm-Message-State: AOJu0Yw3neeqZQa3mqKiwStOb5sTETyNa4dDq2C73x3GvKWBRXUwHY5q
 YTjEo0nA5LfGpsMU5Sbpcs2W6/7PiQ0HMpQVRTMw1D37Cf/uTVIGyCK/zZGj1gw6jZ2Fxhw+ZfE
 =
X-Gm-Gg: ASbGncvjXrii4LkBXG3mZw6d7viGhNI7a1/JYIacaMF7thh2InccQJ5CDXEYt+CBuKd
 7foWKRXiWaMUcl8BosZJvvVEmXOTlWRz5/A8q7rpGtDeQ8PVvlXrt4lPmJDufdW/7mWfwGxKLyu
 tE0PT8tI+XA/P6DB7flb8C1+SpUXPL68bzbvgELMjtgPPRV+SUdvlKVDj8XKrHxLuHI3Dxhpmtq
 hodcC6dRgTllvXATuiNAuplcSt0LxvF7h947dH/I+Krpm5kmXhFZ7hQZnNC8EBuVtWhaWvzHcZJ
 uBDbdwDgxkA6avA=
X-Google-Smtp-Source: AGHT+IEmowzhrIRiDJn6sEVz+HcUyduLkZWyzExJBok9dfL3dJ1ObVHyQ8CwBVgLeAhwGrVj3IIP0w==
X-Received: by 2002:a05:6e02:1c01:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3ac4b434e57mr15142615ab.12.1733956719456; 
 Wed, 11 Dec 2024 14:38:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v2 5/7] efi_loader: Move the fallback code from efi_run_image()
Date: Wed, 11 Dec 2024 15:38:20 -0700
Message-Id: <20241211223822.2446254-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211223822.2446254-1-sjg@chromium.org>
References: <20241211223822.2446254-1-sjg@chromium.org>
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

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 103 ++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 55 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 8ebd48547cb..582b2745ced 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -147,36 +147,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
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
-					    source_buffer, source_size);
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
 
@@ -195,36 +172,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
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
 
@@ -257,6 +211,45 @@ efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
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
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image,
+					    size);
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

