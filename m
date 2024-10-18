Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC7D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D6288E33;
	Fri, 18 Oct 2024 16:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NHzFrP/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F14D88DF3; Fri, 18 Oct 2024 16:52:06 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF6388CC1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ab21c269eso77661939f.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263123; x=1729867923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjnmykYmqGeLOOEcJe0TWYALb2zj1jwRuqsWNDm7pHk=;
 b=NHzFrP/glQ+XH/tqdp0hq2g6SQr6kijtyrMq3/dIOZDmk50Rad8g+/UmUqpedpCdri
 prD3SlgaoxSi9mbT35Z55Su94LoIHjkGw2XycX1M6/iy4U8XNm1GzRb6KNhUYfFKBmV6
 iikOnMHNwjE/AId+Lg+tSpZMEFu2LgJuMJp70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263123; x=1729867923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjnmykYmqGeLOOEcJe0TWYALb2zj1jwRuqsWNDm7pHk=;
 b=eGBzr54/x/GLFoFCPfiIB+5eGnsJIgQ96QBnJ6/NanWbzCCDqH5yzNbZqHPF3g9zOf
 4miDX4cYgXvREPY0Me6ppo01dihQLyIaJCzZB8rBB5mn3rG4yXd0SEtUMipAZP47qxtc
 fXOQtVUYYfvO2z7QGqLFB3eZimhULFFLDRcHrENqAngOccq8377g4Hrte0A8rgVrxboE
 QOH2392S7VwTd1gBETKUx0UAAwZN/MdQ3l2iE7nhqhy5HSb0Yj6DcgME46uQ9aQVxVct
 sbsIGQZguCqaTzUdiXX1hHuq5yDPP9WqyBehvRFiSCpO0dSdlAbubM/KEL1Wq8Wd0D2t
 cJcQ==
X-Gm-Message-State: AOJu0YxxeqK6YbyZsoQLrPyJD9ibrX4E4YN366Nq0RDxMFM/u4pBKl13
 GIuxLSNroQtCyia3fMYE5R9mnvO8TC9UwalWyI12esVJs2MkkX7QPypXVlHp1B4QaQrqw6Gh7B4
 =
X-Google-Smtp-Source: AGHT+IGvCqCx7Oij7RXqAVemKBYQkA2zttk0vas1iaLsq0A66Pl+QjVTxsBs2u7CEs0gFDTW+7h9tw==
X-Received: by 2002:a05:6602:1616:b0:83a:b645:c902 with SMTP id
 ca18e2360f4ac-83aba5d9a13mr260248139f.6.1729263123015; 
 Fri, 18 Oct 2024 07:52:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 1/6] efi: Refactor device and image paths into a function
Date: Fri, 18 Oct 2024 08:51:52 -0600
Message-Id: <20241018145157.3918429-2-sjg@chromium.org>
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

Move this code into a function so it can be called from elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 53 +++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0e..a0ab677ee1a 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -44,12 +44,46 @@ void efi_clear_bootdev(void)
 	image_size = 0;
 }
 
+efi_status_t calculate_paths(const char *dev, const char *devnr, const char *path,
+			     struct efi_device_path **device_pathp,
+			     struct efi_device_path **image_pathp)
+
+{
+	struct efi_device_path *image, *device;
+	efi_status_t ret;
+
+	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	*device_pathp = device;
+	if (image) {
+		/* FIXME: image should not contain device */
+		struct efi_device_path *image_tmp = image;
+
+		efi_dp_split_file_path(image, &device, &image);
+		efi_free_pool(image_tmp);
+	}
+	*image_pathp = image;
+	log_debug("- boot device %pD\n", device);
+	if (image)
+		log_debug("- image %pD\n", image);
+
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_set_bootdev() - set boot device
  *
  * This function is called when a file is loaded, e.g. via the 'load' command.
  * We use the path to this file to inform the UEFI binary about the boot device.
  *
+ * For a valid image, it sets:
+ *    - image_addr to the provided buffer
+ *    - image_size to the provided buffer_size
+ *    - bootefi_device_path to the EFI device-path
+ *    - bootefi_image_path to the EFI image-path
+ *
  * @dev:		device, e.g. "MMC"
  * @devnr:		number of the device, e.g. "1:2"
  * @path:		path to file loaded
@@ -59,7 +93,6 @@ void efi_clear_bootdev(void)
 void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 		     void *buffer, size_t buffer_size)
 {
-	struct efi_device_path *device, *image;
 	efi_status_t ret;
 
 	log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
@@ -93,21 +126,9 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 	image_addr = buffer;
 	image_size = buffer_size;
 
-	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
-	if (ret == EFI_SUCCESS) {
-		bootefi_device_path = device;
-		if (image) {
-			/* FIXME: image should not contain device */
-			struct efi_device_path *image_tmp = image;
-
-			efi_dp_split_file_path(image, &device, &image);
-			efi_free_pool(image_tmp);
-		}
-		bootefi_image_path = image;
-		log_debug("- boot device %pD\n", device);
-		if (image)
-			log_debug("- image %pD\n", image);
-	} else {
+	ret = calculate_paths(dev, devnr, path, &bootefi_device_path,
+			      &bootefi_image_path);
+	if (ret) {
 		log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
 		efi_clear_bootdev();
 	}
-- 
2.34.1

