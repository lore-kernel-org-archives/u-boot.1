Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8CE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F0D80326;
	Thu, 19 Dec 2024 03:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HmRAex9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39768021A; Thu, 19 Dec 2024 03:39:18 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAF680312
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso50506539f.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575954; x=1735180754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tc+XjBByUzJGLtlzkgFhkFe9nFiU4YCumr5zdvB4yKg=;
 b=HmRAex9lPz7+v7tc4qZLjIX+kDHH5VmF/Z0LQ+Xn2BSM6qyGbouDw1eWsGdcdRuIuE
 McdjUJ7o8VXCZPEYbTSOI4OtTBeP+uoLEL/1xTLIrtgo9Ld+ha0mnZVaJgLoqtBa6AVb
 U5MCcznY9rkkFy0Kjl8nHI4b/eW8ZpM8ScO2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575954; x=1735180754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tc+XjBByUzJGLtlzkgFhkFe9nFiU4YCumr5zdvB4yKg=;
 b=LIkNy8ylfUZYtVMfiWvbGpWOEjCibQhClWDBTSY7tpp9ZLNUvaef17ERj+eVMQw7hQ
 mGjEVpHBwN4k0McbruWoIkexNnK7U3OW9uX+m58pAo3zkpERgAPrFRaRVLEWSMckDQ5t
 7venu7cx+28a9G0FNLuwZtrioy34xqte+SxDwAO6m5WCcgDTCLAJtbHOQiPlKsXOYTF/
 OuLMdu3XxqRcF7qdBqHuKCm5V1YVBskFHaIm22NHdudlG3Cmu3ak2rMVJyS8P4K4l+rf
 YsUMCemoD7GjxvIl1TDFpGgmryJHKF9L29HTFjYQv1EaAP2VfvqNQVPPlWTsZdgblbSh
 IUDg==
X-Gm-Message-State: AOJu0YzApfvAsHqyufJIunm9BMqtUBP6mjDo54u/F3sKTWJjuKOKy84w
 VwlLdryX22wWZnvj7Oa63hQi0fq/GcPhTMcWOVcKPb510V0yyEfRVv1ZAkQf9pavZHOOPMJSvUU
 =
X-Gm-Gg: ASbGncsZhkqP84MTgJu0V/HAKVbYfkDmDTCoiy+U15Td92Z1PUZEY50Pf+h5FMbGenz
 6PHm4hYjiwu716tAdfCFjZT5okcha+Fi5160V/Mc78CruL63P9U496ryhWaW4B6Aj/O3lc4G7M6
 8royPg0r5Ld+AxnEXO62UUNryWERyo7qA6lwlUQmyGQPmVvd/fwsC0T7buYnIEuWU6y8yimrbHC
 kiToH70lv/Rdg2ZJHhyRE4khk+/Ycc2liG7jza7nxORSBX1GcUvl8zofQOSoU6X9t8DZlYNMmJf
 XKmQH/dsSTIpfZamPQ==
X-Google-Smtp-Source: AGHT+IFgx1o/b1iYT8xcYSwEMhooIq8d938HQFPjmlVgz0Qx9FKJZ6LtBjOfUs3010pcyo10Y7fYKg==
X-Received: by 2002:a05:6e02:3b89:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3c02d65eb05mr16919255ab.4.1734575954381; 
 Wed, 18 Dec 2024 18:39:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v3 5/7] efi_loader: Move the fallback code from efi_run_image()
Date: Wed, 18 Dec 2024 19:38:30 -0700
Message-Id: <20241219023832.1098689-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219023832.1098689-1-sjg@chromium.org>
References: <20241219023832.1098689-1-sjg@chromium.org>
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
index f7aedeaab8a..8332993f421 100644
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

