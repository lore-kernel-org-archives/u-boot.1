Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00CFC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D0D807A8;
	Thu, 23 Jan 2025 23:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EIa7aCMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00940803B5; Thu, 23 Jan 2025 23:07:39 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBE9803B5
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e2764aa46so893652a34.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670055; x=1738274855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JV+I4k+zVX6Qkg8nAZO+YxIM+sDBHjd/vvWptXHygY=;
 b=EIa7aCMFeIkfm03QXVYmBfOi1/A5cx3xi5Q8z8oS9KpE6KErJ1aqdCXjJxnbSTblpl
 wLsI1TYb1iMUW5grmPym2L15eeAgpWe9ah9HiynHEE0vuYyJ7tVy99mDiRpct70TbVvG
 hZwOJC2YoRBPykVgaPNHriGTylbuXJ2sumx4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670055; x=1738274855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JV+I4k+zVX6Qkg8nAZO+YxIM+sDBHjd/vvWptXHygY=;
 b=cih3hNhbk9irbiocGcpJL3XcDG12x+MpfPr8BBvHi6bOWD2lRiAm/04WYqbljjH37c
 7RWD7tCNMAjDfVLJsGBN0t1j9MQu9IAX9teAvWdzxvtSVdRBh/TpabUYaT8/c3dhR+d9
 nlfCsb90iNoAoXbyvme2XTdOQy+95YoonqmBh+iynXaTaIP+Cy0E138/tYrOGglT+cWp
 u8JuokXIAhrpge5N7J8SH1HBFuFzyzlmWaIcZ/zfuJMb8Scw/6HxStT7snMJL5WE2/mV
 aswBt3b4PO2i3xDKPyIF5yDdPBzbPAAetoR8zeRbIhfzgpC+lHZjbRCkcmTtT+c3/U/s
 awhw==
X-Gm-Message-State: AOJu0Yz/uhLTuDLYPknnZyPm/jk12QK18TvSsDosUPoDoVp0vkZPEwmq
 Invu0JJGvvN0tOcK1dTGMDowVtS9ce364LZfnAp0qlbwWmtNmpXumcY5aea3qoOQ+9SyV2D3qKQ
 =
X-Gm-Gg: ASbGncs8dEcux5qCRiH8RzQuQ1NDjuFMrJeXMlWe/uusIwnj/9I/8vVcIgWUd358QTU
 8m51b2xkNS995R2RIMKm2EIe6nSd2gjGx/2qDGQs+ijNS5ugxK8wXUqLdhNWWuSlqcYETyW0A3J
 B4r1yAiuN85YsoQXkFX2cfRvU0+93EY6s4k5h77DCay1jwGoZTdDcBWS4fX/HjD3BHECx7hG/yT
 s9nNAxxqfEZDUMRRONMV9nIDQaGwyG49RhJ01vU8qqwB3upapuEJ0tfj/mcieWwtTlN8UldVg5C
 fqc0VZd94AqB5d6uIWZRNxShF/uiprY+jt0gQT9Xlg==
X-Google-Smtp-Source: AGHT+IHKuRGDGALMCBl+xejhA9C3KhiphasDPNUIM5QB8Yy0aLuqBw87WhBKmLTe2NFgvno30k3pLw==
X-Received: by 2002:a05:6830:6015:b0:717:d558:ca70 with SMTP id
 46e09a7af769-7249da70faemr17473404a34.7.1737670055041; 
 Thu, 23 Jan 2025 14:07:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 1/5] efi_loader: Update efi_run_image() to accept image and
 device path
Date: Thu, 23 Jan 2025 15:07:20 -0700
Message-ID: <20250123220726.412396-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123220726.412396-1-sjg@chromium.org>
References: <20250123220726.412396-1-sjg@chromium.org>
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

Changes in v5:
- Rename the parameters
- Drop the image->image_ptr rename

Changes in v2:
- Adjust argument ordering for efi_run_image()

 lib/efi_loader/efi_bootbin.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 428991df88f..71591dd54b9 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -157,9 +157,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  *
  * @source_buffer:	memory address of the UEFI image
  * @source_size:	size of the UEFI image
+ * @dp_dev:		EFI device-path
+ * @dp_img:		EFI image-path
  * Return:		status code
  */
-static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
+				  struct efi_device_path *dp_dev,
+				  struct efi_device_path *dp_img)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
@@ -167,7 +171,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 	efi_status_t ret;
 	u16 *load_options;
 
-	if (!bootefi_device_path || !bootefi_image_path) {
+	if (!dp_img || !dp_img) {
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
+		file_path = efi_dp_concat(dp_img, dp_img, 0);
+		msg_path = dp_img;
 		log_debug("Loaded from disk\n");
 	}
 
@@ -252,5 +255,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image, size);
+	return efi_run_image(image, size, bootefi_device_path,
+			     bootefi_image_path);
 }
-- 
2.43.0

