Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B9DC02194
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D5280608;
	Thu,  9 Jan 2025 16:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fb4HmEf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B90E80690; Thu,  9 Jan 2025 16:03:08 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2149800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so32063339f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434981; x=1737039781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wxanq/AZBm2CpkXnHCcujkoU7Y1GgSypMrQ2rD5xj78=;
 b=fb4HmEf7P/eyK0etjLiitOtL+azXqm5z3I/VVsk25tztbGfBZ6wd5liDrNaJvJ4CRS
 8MDwfX756bJanlyu7zSBjhIfspM6oZ2Es7epRQStbM1PDOtt34sf9EHYjJHAi4AseRO4
 +WtQnFn4diWrDM0EkdlkjRifXuDOnKd6Efpss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434981; x=1737039781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wxanq/AZBm2CpkXnHCcujkoU7Y1GgSypMrQ2rD5xj78=;
 b=Fd624WC878WRNwBNf0tnnmaT51m9D4k42karLghI9ddC85ulUxEdZ2HKqjbvbOm31V
 re94C5N87es0FKVaKdu2Jhx/uGELJ68rKDeeDrJQOe5ElULt1wV5ZrCJvQvMGWHC2r1Q
 hv8+++etVCaW2yj8F8uQZ5b5OrSGSRapjbxpinil8motOjSPNA/mOpvAAfC/tfDTcfTx
 M4HKBf7Lwsfy/YWQ+DyXTmrQaxqjW92jFihVpUzyRRbWy/WCKGWCsai65wjaEKXJqZT9
 8qgweOojkglWx/tq0XlTUUBf7KVyiNo0L0RdJYsoJu9CIdB19WOM846kvgldKDGJEYD2
 sWbA==
X-Gm-Message-State: AOJu0YxyIlVNdNRVDv3z5WIB4IHLCBPzDUuK6kjDBASWNuekmTfg0TaF
 DTDA1m0Rb7L9tkEcz5CpCPFwafeqMcgXRoFm5wew9ivHpr+TSD9DGb/MmaYCuVjrZ490FNs+VbI
 =
X-Gm-Gg: ASbGncs5SWOpnIMmMMqxEeFrllbfeJpZ+mgQ79uVWZfxGpdvTjF3eZzFYjSSSMClp5v
 wmg1dijzHn8XW32mNDPEX076NI8Iuu50u5HT3vzSDOsmyTpALVYBvVAiThCL5MwLHs1r3GNII6e
 yFTs/Pwc4T8FARSHKnszCwkcPugU4I3+zkY4Nsq2MdpmotNAlsW2uBmo5AkFC3XYFYNiIzZljYY
 wlqsCAmSJBG3Ifb/NSgipoIWmlv+MmYNcAQzeGfjO4nGJsXzjzfY9UBbUlMSuArYw02vNTJvcnC
 7PX5uJ80jq3+A3Wd1Q==
X-Google-Smtp-Source: AGHT+IE/FbuQIXGVm/YpcayxHJRMSqOPewOenAa+F8SBBhcbSM03wbL+vrpbzZruWWI05sV7TPimAg==
X-Received: by 2002:a05:6e02:525:b0:3ce:3c8a:b7e0 with SMTP id
 e9e14a558f8ab-3ce3c8ab948mr38098775ab.5.1736434981508; 
 Thu, 09 Jan 2025 07:03:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:02:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v4 3/7] efi_loader: Update efi_run_image() to accept image and
 device path
Date: Thu,  9 Jan 2025 08:02:40 -0700
Message-Id: <20250109150244.141173-4-sjg@chromium.org>
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

Provide these globals as parameters to this function, on the way to
making it possible to start an image without relying on the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Adjust argument ordering for efi_run_image()

 lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 428991df88f..e3ac27b03fa 100644
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

