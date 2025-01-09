Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2881EC02188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A42806FE;
	Thu,  9 Jan 2025 16:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a5OgU1rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B882806FE; Thu,  9 Jan 2025 16:03:15 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AE4806DC
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844eb33827eso30703039f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434987; x=1737039787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpkx/TkeEtPlTIlMdwSF6ErijNV5amko0sZEUd8dV+4=;
 b=a5OgU1rgwBMPsIFwI+BS18Dr3btTccfMglt/qwRRfdDwnLhe9AwEm1EDo36a5zoogo
 7XDgcKMcfkRViVAOcmvjBfo6DTdRfidYw1nDd4ZD03/dHH4vgml3V7hgFpOemFP/s4AU
 serZE++W7Y6XhBJ6v85JdpWeRRh9xVuGeJMXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434987; x=1737039787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpkx/TkeEtPlTIlMdwSF6ErijNV5amko0sZEUd8dV+4=;
 b=UUxBHI6OCHRie3M/Vb3g+LE1BQqSvZEFCi1hm9BBIi2oUbP7+vZqx/ulva4CNCOAyw
 gw5CUHeoR+70Em2C+b3Vu6vgnMAk7sAQCLwiQ7ZTVjnyANfnthGD7b4J7wDcGhmYfSFD
 Og6F3h+QG+CY6CBnhv1BhqlTHd6Ulhr0MhLeOPTKKS4bkXbeG38WmNbq2DtoiXFBrqpq
 57v0/rjLBq0yqqucHiF28Yf6n/fIPEIelQ8juT1YuB2BbHLb3lHaka7Q6iPYI+tybf3q
 NI7XPCEfSa8Nr0xRcycSX/rJokLqmTvOOAzY0CuYun9202vnE6PPOwQarTnE9tOefKUo
 VDhw==
X-Gm-Message-State: AOJu0YzGW/qiC4YV+397Ppeh9l4Y8jnUl/V4QfxiwRLWdSxgaHyF7rlP
 ZbUnWHRb5dwHo7PYqr86M2J8E7CDqAAEIbUg9BwGZrIsrzXfdnzpi0S+tzUUB4fDRByvesIj4ck
 =
X-Gm-Gg: ASbGnct5Vijw4/6y6ED+jGA8ZJTj5etpYa6cHbJy3RQOL5MfHisE/uwd/wTm2n0VjVg
 NDn0xVZXxju7AspXUzC4mIEcifp56AA7FN3O1BHibgXLk5uIAo9a37fd1HnE1XagAyV7e5H7hG6
 u3adGL0u8HCDRVmcENIu9ERCWvNRzRE8hhq+9NY4IUuRjsZz3JTKsiQg0XFq+9N49wNzg6YDTxY
 AGlJcyMEd551XuLRGj0RaXb3D44iHhgCNaJ/u4+9JPUVLcG6XvfVJ2HWM2kqG5hkRfluB77LMp5
 8OeL8slkyWaQ+ikzQQ==
X-Google-Smtp-Source: AGHT+IH/VZK4ukmAhVUAA9DvdjjYRWY3kc3McC3y3lsYfE694jkgaZuytjyYJVae+Rl0bqCZmk7VUw==
X-Received: by 2002:a05:6e02:214f:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3ce3a888287mr54541005ab.13.1736434987330; 
 Thu, 09 Jan 2025 07:03:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:03:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v4 5/7] efi_loader: Move the fallback code from efi_run_image()
Date: Thu,  9 Jan 2025 08:02:42 -0700
Message-Id: <20250109150244.141173-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109150244.141173-1-sjg@chromium.org>
References: <20250109150244.141173-1-sjg@chromium.org>
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

 lib/efi_loader/efi_bootbin.c | 90 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 6cbc5fa050c..7c6a88c79fd 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -165,37 +165,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
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
 
@@ -214,15 +190,6 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
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
@@ -241,9 +208,9 @@ out:
  *
  * Return:	status code
  */
-efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
-			     struct efi_device_path *device,
-			     struct efi_device_path *image)
+static efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
+				    struct efi_device_path *device,
+				    struct efi_device_path *image)
 {
 	efi_status_t ret;
 
@@ -276,6 +243,45 @@ efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
  */
 efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 {
-	return _efi_binary_run(image, size, fdt, bootefi_device_path,
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
+	ret = _efi_binary_run(image, size, fdt, bootefi_device_path,
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

