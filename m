Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE27E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347A78033A;
	Thu, 19 Dec 2024 03:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q/0c9eLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C334E80328; Thu, 19 Dec 2024 03:39:07 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507F18021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso13140039f.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575942; x=1735180742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKJMtf2rih79rhi7/6xzICSLBDCXrvPf7olEc9U9xzQ=;
 b=Q/0c9eLczbM/44S+RtlwDdvvWq3B2aBs26Y0hR+aJo8a8+BrFxcPNw9UBn/F8FDycm
 9V0Fcm4xPmQyNNfZ24cYM6+zf2DdCGPJv2didNNVXIyKdLadFqwN8TeukVByJdsip1hy
 3UFyfdS5Ko/3sI4moWepNr+5ZPayo68FnBI68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575942; x=1735180742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKJMtf2rih79rhi7/6xzICSLBDCXrvPf7olEc9U9xzQ=;
 b=HLXRVlJaHzyyr/8dZVSzCUFsL8SwoTghOGpYvM4axcsIPk5U45EUeUsnVkAB1kBQBp
 ipZszd6wRpsMmK/v+GOvoeBEe1RKVAUYS7kmFVDNe27oHDr/oJ/VyvDMuG8E96zzDRR8
 XHs6imIKXkF0w45KEHGK0FGe5VfhfrBRQjc2R7WqCNpktamNDks/sBSPAE52eg2BZo1X
 CJJbkG+KVgV0B3gfhNjKraoJ48DYyuKeNK543GvvcRQAndvAXULf+CF5I1ECv++b8EUH
 u4NVOmDHv7eHOD9R1ZYMGkn0biNFeiPPWJPn1E/KvnpfyhucICfUmjThEK8hWYZw2YDa
 a9eA==
X-Gm-Message-State: AOJu0Ywo/5sW0f577MhZ3sQhorm8DlLnMgBGJDppj9ceKO/WLAOAVS1Q
 oocusrnXXs57kd7G/pLZrxSXNvuAfV4ni0OcViHsDlYxSF2nwHU15Zv1YL3Ubf7hEgx5iIxC9LQ
 =
X-Gm-Gg: ASbGncstf4duOGDyTPiANEpYi3G6SixUE/fBrXZ5XBlyYCndonjjLoDhjJy6yacT1bk
 C5xNwbz29D6t/GBSEDWkZ1o3zrLW23iLJN+bZje7CJAbxfHZRUtKDs6bz6AiM+3s2cDTaN4H+t3
 c0lsxBjP8Ikqq+gNNmEDb1KpyEkOsM9qBGRNSNNLAL9dP1kDSCTXhOTx/cpWWyL+v2eZ/p4VwvE
 AaHORexHJlxy+ZwPqr7+DREN9pUf4GDkhD+LS0gPO/41RJvtm2hUCYQB8r+qmZ8GZg7/LUwrDw9
 g1swxWHHbvXAzdHTyg==
X-Google-Smtp-Source: AGHT+IG6kLkMzdKcvJRj7LV2p3KIuUryNJEevQrzBOhAGjWH3yDIhYw2BztuwmLsRy0+N5+rYLShbQ==
X-Received: by 2002:a05:6e02:1a8e:b0:3a7:c2ea:1095 with SMTP id
 e9e14a558f8ab-3bdc031d9d0mr45465195ab.1.1734575942348; 
 Wed, 18 Dec 2024 18:39:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v3 1/7] efi_loader: Refactor device and image paths into a
 function
Date: Wed, 18 Dec 2024 19:38:26 -0700
Message-Id: <20241219023832.1098689-2-sjg@chromium.org>
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

Move this code into a function so it can be called from elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Make calculate_paths() static and add a comment

 lib/efi_loader/efi_bootbin.c | 85 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b677bbc3124..5016ba7e225 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -44,12 +44,64 @@ void efi_clear_bootdev(void)
 	image_size = 0;
 }
 
+/**
+ * calculate_paths() - Calculate the device and image patch given a device
+ *
+ * @dev:		device, e.g. "MMC"
+ * @devnr:		number of the device, e.g. "1:2"
+ * @path:		path to file loaded
+ * @device_pathp:	returns EFI device path
+ * @image_pathp:	returns EFI image path
+ * Return EFI_SUCCESS on success, else error code
+ */
+static efi_status_t calculate_paths(const char *dev, const char *devnr,
+				    const char *path,
+				    struct efi_device_path **device_pathp,
+				    struct efi_device_path **image_pathp)
+{
+	struct efi_device_path *image, *device;
+	efi_status_t ret;
+
+#if IS_ENABLED(CONFIG_NETDEVICES)
+	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
+		ret = efi_net_set_dp(dev, devnr);
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
+#endif
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
@@ -59,7 +111,6 @@ void efi_clear_bootdev(void)
 void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 		     void *buffer, size_t buffer_size)
 {
-	struct efi_device_path *device, *image;
 	efi_status_t ret;
 
 	log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
@@ -93,34 +144,12 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 	image_addr = buffer;
 	image_size = buffer_size;
 
-#if IS_ENABLED(CONFIG_NETDEVICES)
-	if (!strcmp(dev, "Net") || !strcmp(dev, "Http")) {
-		ret = efi_net_set_dp(dev, devnr);
-		if (ret != EFI_SUCCESS)
-			goto error;
-	}
-#endif
-
-	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
-	if (ret != EFI_SUCCESS)
-		goto error;
-
-	bootefi_device_path = device;
-	if (image) {
-		/* FIXME: image should not contain device */
-		struct efi_device_path *image_tmp = image;
-
-		efi_dp_split_file_path(image, &device, &image);
-		efi_free_pool(image_tmp);
+	ret = calculate_paths(dev, devnr, path, &bootefi_device_path,
+			      &bootefi_image_path);
+	if (ret) {
+		log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
+		efi_clear_bootdev();
 	}
-	bootefi_image_path = image;
-	log_debug("- boot device %pD\n", device);
-	if (image)
-		log_debug("- image %pD\n", image);
-	return;
-error:
-	log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
-	efi_clear_bootdev();
 }
 
 /**
-- 
2.34.1

