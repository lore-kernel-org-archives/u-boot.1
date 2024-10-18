Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22628D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E22D88E94;
	Fri, 18 Oct 2024 16:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oJ5/Krly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F00788D5B; Fri, 18 Oct 2024 16:52:09 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F56E88E02
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8377fd760b0so93093239f.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263125; x=1729867925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYXiK/ZYYFMtd9CHOIFx0nOQZqi2RB+QpAI4iWJLl8I=;
 b=oJ5/KrlyvxX4/o0DgFp5LYKaBqUVbbONowDKF4X7/3MT681SPsNr409i0lYLwDM49i
 LQvVsyLhdC3chtSNtETLHjFPB1jj7OGxZVTtdXDSL91p/zPNsfTeBo0SsBYCo5aiFVKD
 hxchpz/UGuw5Q8PxLVRxsRCp4bWCCitB1WimI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263125; x=1729867925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYXiK/ZYYFMtd9CHOIFx0nOQZqi2RB+QpAI4iWJLl8I=;
 b=Agok4RCSceGaOgco7GBCNQ1ngbdFdt9paP0Z+fZltG/ZOH+fSUFjq1ShsA2Xs89qay
 tJ79hMHt4t5QbWOF/Zu14ZkoQrQixCCM8bHeaW+P6qb1L+70Ln7i8avcAI27KyDRotXl
 si7+FVQJV59GftbZthv0eFNAsAgmggZyAGs4U17tNHYa2Wlu0ppWMwDAkQ50CHyleLPu
 dcbI7xllZ0wfuy8Y6JgxStCp2kr5kBXXS9n7XrFpnD7xl830NsChOLMMUaArAZUtO1fg
 Xhff6a2W3qA27vxsMgc29djdxKY+fSeVIyzWcO1aTDW4E0HGJuKTR/nNwikd4Vwv+MZN
 riDA==
X-Gm-Message-State: AOJu0YwZI1sEUY1uNbkcR3DEwwyzGtWNj/sxBg+8+4VfbOvDBvjBhE2x
 C97GGYdbKs7Hy9rnWweA14HQsvMVtOc+HHd6N4tI7iXO1iUM1zeJqY56MyM6QN0JaQwvTByHcjw
 =
X-Google-Smtp-Source: AGHT+IG7WcOansrhLtuYE1CQHXUgbI/K2YFUl92xM8RE6eqNDqSE4xr3yzQv1jxT9OCAq5mX5Lqgtw==
X-Received: by 2002:a05:6602:2c01:b0:835:359b:8a07 with SMTP id
 ca18e2360f4ac-83aba67344dmr215631339f.16.1729263125088; 
 Fri, 18 Oct 2024 07:52:05 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 3/6] efi: Update efi_run_image() to accept image and device
 path
Date: Fri, 18 Oct 2024 08:51:54 -0600
Message-Id: <20241018145157.3918429-4-sjg@chromium.org>
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

Provide these globals as parameters to this function, on the way to
making it possible to start an image without relying on the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index eb9b9c4afe0..8881d648ed6 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -139,9 +139,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
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
@@ -149,7 +153,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 	efi_status_t ret;
 	u16 *load_options;
 
-	if (!bootefi_device_path || !bootefi_image_path) {
+	if (!device || !image) {
 		log_debug("Not loaded from disk\n");
 		/*
 		 * Special case for efi payload not loaded from disk,
@@ -170,9 +174,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
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
 
@@ -209,7 +212,7 @@ out:
 /**
  * efi_binary_run() - run loaded UEFI image
  *
- * @image:	memory address of the UEFI image
+ * @image_ptr:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
  *
@@ -218,7 +221,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
 {
 	efi_status_t ret;
 
@@ -234,5 +237,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image, size);
+	return efi_run_image(image_ptr, size, bootefi_image_path,
+			     bootefi_device_path);
 }
-- 
2.34.1

