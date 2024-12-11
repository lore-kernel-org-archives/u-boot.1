Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAE9E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6844D80200;
	Wed, 11 Dec 2024 23:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hEzmYh4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A87801EA; Wed, 11 Dec 2024 23:38:39 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD81A80212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844c825ab4cso544039f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956715; x=1734561515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkXEe3fqHqUCqumqechEsGtEsqcg9f3EgytJfJbFqKU=;
 b=hEzmYh4fZLY3a1q4KkIIlXdTchd9gG/JoUVUIO35n9HmenAtTgsce/18N0pEGduYes
 3ZRKZ+86h4/6Gj326IU8hewhe4pg2kbCBDF2ZR94Qwf+GTw4ifvr6S7/yxlkKwQLKrAn
 saJRSY2k30u+Gc5hpTLSW/TZRDmfqMPnVPYVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956715; x=1734561515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkXEe3fqHqUCqumqechEsGtEsqcg9f3EgytJfJbFqKU=;
 b=EcnL0FPBRX7+gpkufdAVfXzTdsVD3aTr+7GRBKQR5g7Tk2IwQDTsfNfd2efUbojo2o
 iWKTIzLjvn6V2EdB+kPWx1qMWLLtCVT3S1PMKmWgSUb2Crdi21kaSIEdOZgcHPDO7/uI
 9IK93J/QoqjZs0mhBdDNmzhE4hZyHTlV8H10nCFyOKJlXA/ZtbMSmZsAsnhD1bukKmud
 NCtaQwzqPyLaX+WRQ1VYtCSmCya4ViQoSbPp6iUqwp7J3haRjDuLHvpqiVMLwuNjAtJB
 qSRbUB++CGbNa4M2Lk4eImKXE+oxjqp7XWvvhKAMZtS/Hjvl6kz+Kpm8qsuLpedL0ZZ3
 rxDQ==
X-Gm-Message-State: AOJu0YzJoGaoQI3PIJ/TecNVBJIA8Fd3RPrBiGW9uzm9zZ+ZfGteLVyS
 qEcmQku2SmS1lYqSpn9ccT25fafVbX2txabHj2313yNCa7iUBSX5bbN7erH2wR2OKjABhnx3IYY
 =
X-Gm-Gg: ASbGncsh05wUpYUJgLcCOukI6bhE5besGNYPskEigdEwAlSlySBqcj6dciB0O6uCinX
 NUt1hPrySb+4Q67Jx6IgcK7luf0ShByu3YPaMHyeoTG6ilW21/tpseH9vw5qlbSUboiDxwogtKv
 GuK1fXeWenU4lp/XckoA1MI2mH7ehT30Ab2OARbZ3vTHK78HjPHygbc/yBHYtHutYHwI31KmW5m
 rDLKQ6+v8s5nO3JD7faJ9c+us1U1yyNp5PXTi0rnOsoML7C12wwIh6LDCkWLypZJ3UX+HEATK/p
 q5A+4DjeCrGFY2Q=
X-Google-Smtp-Source: AGHT+IG9z/TFG6ZEtMiDt/AoyPlrdFjmYvgWXFupedZWrCzw03p8JAlpnGvb27iV4xfN/3zXfgAgIQ==
X-Received: by 2002:a05:6e02:1e01:b0:3a7:a3a4:2d4b with SMTP id
 e9e14a558f8ab-3ac49081450mr11426475ab.14.1733956715169; 
 Wed, 11 Dec 2024 14:38:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v2 3/7] efi_loader: Update efi_run_image() to accept image and
 device path
Date: Wed, 11 Dec 2024 15:38:18 -0700
Message-Id: <20241211223822.2446254-4-sjg@chromium.org>
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

Provide these globals as parameters to this function, on the way to
making it possible to start an image without relying on the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Adjust argument ordering for efi_run_image()

 lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index ec8f4e4f7f4..8febd325f34 100644
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
@@ -169,9 +173,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
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
 
@@ -208,7 +211,7 @@ out:
 /**
  * efi_binary_run() - run loaded UEFI image
  *
- * @image:	memory address of the UEFI image
+ * @image_ptr:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
  *
@@ -217,7 +220,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
 {
 	efi_status_t ret;
 
@@ -233,5 +236,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image, size);
+	return efi_run_image(image_ptr, size, bootefi_device_path,
+			     bootefi_image_path);
 }
-- 
2.34.1

