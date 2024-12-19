Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BFCE77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141918021D;
	Thu, 19 Dec 2024 03:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bFYnpie1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA4180312; Thu, 19 Dec 2024 03:39:14 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1859A8022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso1087315ab.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575948; x=1735180748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwtot19V7z7rw3WlbShYMrzXXD+1n9CSAaDLiquXk50=;
 b=bFYnpie19oe/nbD0sqQpARKQ8Ph812ZhPH1iGHs8QwSscouuAit/RdPlMxYn5TAzYm
 IvsDvIgj6XonhGze4SvQdxWVGRgSqTUtvzHpYIGH6OWA8rXFP8UHUN1cNAM9TnpeGJ0r
 J5xNYPYZhrdVxBejoptKkjz0GLwBsjqmNGXYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575948; x=1735180748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwtot19V7z7rw3WlbShYMrzXXD+1n9CSAaDLiquXk50=;
 b=FZM0V4aq5rmK1j3HmF/L6hgTwkQ+3n4rXFC5oUX+oh4TP8MlXeW2ZdMI0aNY1kYt5P
 9Xrk1ukxC3eABvPf1TY0JCb5FfBc5XKLv/8UDbnwNgKBxmJ3Q1MnVl3OHq06kgSfZbxf
 rXGMJPy5jA2HoJKZ0PTZT9KLWd1mqJHdW8XCsGRzcuqetxLnPOvt8H/Ql7H7Zw8Ax4R9
 edltKgMYgIdF/n3zDEZ99iZRWD2ywRVLkHejyqg4lz09iVfP4FcWhKZ1eT1lgc2Ki75Q
 NgzrbPGHU5uRL8/rLGmUJsJwQ8PufIw6sOybgynVYemvb/c/PWfWt82inDRK1N8LNwqw
 MeDA==
X-Gm-Message-State: AOJu0YwPADoeJ7KE+dU2WG91wjboYzeWfHIz1jC9rviAonLRd4SxBab1
 T3Z6ovTN/g8CvQzZd78z23CbtkF06OetAuXAgLsRa1kpn/VlmZbXa3oR8MNxww3F6oxrVq/FbEA
 =
X-Gm-Gg: ASbGncsfFMUj0zUbGKzcm3tPzntTgKWEY0K9xog5S1EE7mdknjNiOs5erNexCoCRuYp
 odlYT5TvxgYgXaIv4kJzzHHO4W0NvudjeJNvfZu1VdOSw8+eoiGMDU9pO5K05W8rub5stizTrTO
 aEgJxD4lqbuoyfPbo8F1fgKh4+Tvk1J/v9QXUOvOp+dQG7Leuoirt2VO+Ezwp+lpq9vDUe2ohSq
 Hy2j4oVuS9RzmCXRcHtSsNqmbyGK0OV6Fxaxq1//5iSjBsiAzXrqr5yOm3qkOKicnCw67A1QbEP
 X/sdgCzKFEe+spRcyw==
X-Google-Smtp-Source: AGHT+IHms0OGi2m31beW7TNIw/uYt1qf7yrLRYMZpJNzbJyxoJuN0lbmX0u+2Hndn673gDVreVpf2A==
X-Received: by 2002:a05:6e02:3cc5:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3c010629a88mr20938085ab.1.1734575948317; 
 Wed, 18 Dec 2024 18:39:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v3 3/7] efi_loader: Update efi_run_image() to accept image and
 device path
Date: Wed, 18 Dec 2024 19:38:28 -0700
Message-Id: <20241219023832.1098689-4-sjg@chromium.org>
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

Provide these globals as parameters to this function, on the way to
making it possible to start an image without relying on the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Adjust argument ordering for efi_run_image()

 lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 051d86ef993..b42ff3cb4e0 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -157,9 +157,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  *
  * @source_buffer:	memory address of the UEFI image
  * @source_size:	size of the UEFI image
+ * @device:		EFI device-path
+ * @image:		EFI image-path
  * Return:		status code
  */
-static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
+				  struct efi_device_path *device,
+				  struct efi_device_path *image)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
@@ -167,7 +171,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 	efi_status_t ret;
 	u16 *load_options;
 
-	if (!bootefi_device_path || !bootefi_image_path) {
+	if (!device || !image) {
 		log_debug("Not loaded from disk\n");
 		/*
 		 * Special case for efi payload not loaded from disk,
@@ -188,9 +192,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 			goto out;
 		msg_path = file_path;
 	} else {
-		file_path = efi_dp_concat(bootefi_device_path,
-					  bootefi_image_path, 0);
-		msg_path = bootefi_image_path;
+		file_path = efi_dp_concat(device, image, 0);
+		msg_path = image;
 		log_debug("Loaded from disk\n");
 	}
 
@@ -227,7 +230,7 @@ out:
 /**
  * efi_binary_run() - run loaded UEFI image
  *
- * @image:	memory address of the UEFI image
+ * @image_ptr:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
  *
@@ -236,7 +239,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
 {
 	efi_status_t ret;
 
@@ -252,5 +255,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image, size);
+	return efi_run_image(image_ptr, size, bootefi_device_path,
+			     bootefi_image_path);
 }
-- 
2.34.1

