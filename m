Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D291BE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D7F801FE;
	Wed, 11 Dec 2024 23:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NTv3r0Nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E521F801FE; Wed, 11 Dec 2024 23:38:34 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A76801DD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844c5f31d48so2273039f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956711; x=1734561511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAMYFjTL5K3czbsODMZyPtP1iVbuUyvT0dKA7P3jlv0=;
 b=NTv3r0Nc5+axbUmz0SJ3p0k3kUx2PSSt6ZcK26azTphoFkmPUbCkES59E0WChpuADL
 THGKSl9oDAqO4JHUASClGuju4uIBD0XJf+ZIp/anzGdDDvJhND9d4/FtWKXrwK4PEHPO
 Xoj4e6NlKjzbeUPz2qXDImlWC8wdhwMu5TQ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956711; x=1734561511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAMYFjTL5K3czbsODMZyPtP1iVbuUyvT0dKA7P3jlv0=;
 b=iLfKT1QRiG54eJEUONwMA5CljLD0zVpFBgTOwMOrhwiFAFb7MginVfMuaRCKM9mR3C
 VhnE4WtAJi0rMFlssbp1B9FwMXhtb2Fvq3Gp6QpKxR8Pd/fMn12VlI4UMyT+kOnzAuMx
 2zT75JRWkWUUPB1IdoWhkNQmrX06BFnR1+Z6h9K2kRETCTDoz8KvoXMCyH9S/Dc3PzTR
 jvSEFFkP+1suy6wApZPTcNOA941r9jMRQ+hsxGZjbO3tUO1uyrp36Ri3ZIMVIiX6IxbM
 mzp1sAs9t+OegCLzlfKjvNvvfJo06DW24lIYsqKDP8QdnsalujOycrOx8Ax8A64Nu2yK
 jfJw==
X-Gm-Message-State: AOJu0YxRgi/7L7QxWEVjl2OTXyCdKVJE8pI9qYtbyIlycSqa9DLmoMG/
 kYZF+Dy5CHd1H85Vgyt+WvNi1Wy3oI93r4pvMBVgehTlvQLYX2gVXd1JAcrUHIuG+StRmbksOhw
 =
X-Gm-Gg: ASbGncv+lwSTK/0byz5mDFadcSEIJirlMCYHLhGOKNU3cflTJaY62d9I9dNj8u1UYnI
 Uj2zF5IBMlSHSeS56pup2pKWxTu/r8UzD8TVBi99zf01KrXPdTiC1iWqGhWLkM5yDiwoVkRp7OL
 PVXzn0E2cA/oVqvmS3H6bogp0tcRPLWu77I7qlGPjwDqAXKBX2j3C9C2dSICRFIsOFRAymSbX5H
 7eRsnMl2AJc3vW2VD3m06hlcDFXCzJVWaHPELp0ioFc3QNoIalVOLZjeJWK9yc8Hb91KLWc9S1l
 aKbcVh5cH/peqa8=
X-Google-Smtp-Source: AGHT+IFRGe7H6s33PJRGHZTImjqSdjBGaiAHYDkS5a0nBUcdx3Abww7gC1jRu2XTceEf1aYzXwNMhg==
X-Received: by 2002:a05:6e02:1563:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3ac4baf73c6mr14570175ab.20.1733956710907; 
 Wed, 11 Dec 2024 14:38:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v2 1/7] efi_loader: Refactor device and image paths into a
 function
Date: Wed, 11 Dec 2024 15:38:16 -0700
Message-Id: <20241211223822.2446254-2-sjg@chromium.org>
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

Move this code into a function so it can be called from elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 53 +++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 7e7a6bf31aa..afb13a008c2 100644
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

