Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D80E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F043806EB;
	Thu,  9 Jan 2025 16:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k4bOShoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC8B806DD; Thu,  9 Jan 2025 16:03:00 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C5680601
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e61f3902so71252039f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434974; x=1737039774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1hZ+sV2XzQgALu9nvpieyV95Zz1/6Eoj0xUeddG4O0=;
 b=k4bOShoUsNDcB033r8NW9i++d1YneZWf/Rca0QIEFW+d9QzjIbUQ3qOMWbzxLFuPpG
 dNeLJmg6t4y76WNNTJFnq2scqLIXpyLHKUktJyF3TGbp3xD8xoEPRd+EIrn9xqA7uUeC
 2dxwfCjb/D4Td4eZ3b0Q7c3L9iUWiK/IsOS6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434974; x=1737039774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1hZ+sV2XzQgALu9nvpieyV95Zz1/6Eoj0xUeddG4O0=;
 b=rgTtnA1awzSCmAEey+hNf/vEw3fNmGP2ZE2xNqKze1t/EGCXEPm7UFyO2ntwOIF7Nn
 365SSt29rxE6W1eeHbMzxlWJNcvJgB8PzGx3vvzGOQFCTCgCfII8rQ0DccVSQn5jqH8D
 qa0E1Ir+9Q/Pwn8sDrhYz9iMeVAi8CO0Z2qThQtAaS8ZHmSzUANAlprRVcFI0E6vrD/j
 Gw9GdSheiL/RvjZcxm/LXzX8TORZFnT8XX64X+VB5KFya2sHJLTgOnH+va0YlGECIk/3
 tBEJvAgOqY2l5FklgSV9DuagnYaTjMZI8qVyUKs74wSHxG0hWPel6FvUhSM/pCv3UNuo
 aQig==
X-Gm-Message-State: AOJu0YylvgIQ6v9XwFNfQoNAv6gxM2Ef/Qh91lb6vfNgEeDgsVa2ny7R
 pPHtEnyWq7rnR722ubrZ6QQL3KWzSLtej/GK7fPOYNJhozWhHPND1CjdswtFIIOdt49TJm0DOhs
 =
X-Gm-Gg: ASbGncv051JnEb8F4ZzPjdA7Wv98xSPZjVpefqQyG2dSixEcnzPfR2z03egoM79+EnS
 7mMTtd8+c77/KaZGVRxG7BjBgfQA3kplh7nVXHU2wl0j9IYHWAH/niVzLLFHtwNm17xfHkXJA9L
 fFNtPJCweq2uTvPIEtABgL8C4gc4n6ZpgbENUtM4PLqQoaMxJUBg4XZFnONlUb+TkNSIT0hfnP/
 5rm7BUU4sc29waE9IW6oqw/BUgrT/q2uIrH1XdcTovlL/xz79OwI8z7Pwv4UtAal4SKkaIXyvm7
 q7GBoggLyCA4RSk3dQ==
X-Google-Smtp-Source: AGHT+IH8CaOYrYo1+wF9jlCGAnyGT+dCPHV0/9gs4pt3VZ2pe3b8O4vnq5qlBZwyNZu7Ry1mCceQng==
X-Received: by 2002:a05:6602:3817:b0:844:e06e:53c5 with SMTP id
 ca18e2360f4ac-84ce00d4878mr603483139f.8.1736434973941; 
 Thu, 09 Jan 2025 07:02:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:02:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v4 1/7] efi_loader: Refactor device and image paths into a
 function
Date: Thu,  9 Jan 2025 08:02:38 -0700
Message-Id: <20250109150244.141173-2-sjg@chromium.org>
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

Move this code into a function so it can be called from elsewhere.

Note that the recently added network code uses the same
'global variable' approach. It could use a separate clean-up.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v4:
- Update calculate_paths() comment
- Mention the NETDEVICES problem

Changes in v3:
- Make calculate_paths() static and add a comment

 lib/efi_loader/efi_bootbin.c | 85 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b677bbc3124..a97d3a025a2 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -44,12 +44,64 @@ void efi_clear_bootdev(void)
 	image_size = 0;
 }
 
+/**
+ * calculate_paths() - Calculate the device and image patch from strings
+ *
+ * @dev:		device, e.g. "MMC"
+ * @devnr:		number of the device, e.g. "1:2"
+ * @path:		path to file loaded
+ * @device_pathp:	returns EFI device path
+ * @image_pathp:	returns EFI image path
+ * Return: EFI_SUCCESS on success, else error code
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

