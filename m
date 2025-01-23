Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703E2C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620E2807F9;
	Thu, 23 Jan 2025 23:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CRpHPzz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D051807D9; Thu, 23 Jan 2025 23:07:41 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DB680087
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f33ad7d6faso1029180eaf.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670057; x=1738274857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5OMf55tIYxtJFUA0rm2UdlkYbRgI3+svNeFq5buYIU=;
 b=CRpHPzz/WG4G5xbmiSpfOxCno2rmmax6J36V6TN+HIckqVcM2l5OyNLHZnvAj2z1oL
 5Z8yWvP3KCY9o6XVsXVEWCHj9hmLwISltRj6FMS6B3AUB25mxbRqDCWUWVACjpgKct1r
 otmc6HcV6Ds94XKHrhe3vOpC90FDIvZKR4GDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670057; x=1738274857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5OMf55tIYxtJFUA0rm2UdlkYbRgI3+svNeFq5buYIU=;
 b=VV78MokwNMspEoyMvHxcTr2u3Fy/gPqBqmwNsSTNwr7VXrPq4WqpnVLHnK4F5YAgba
 sy8AYg0I9fnhEUILObx3vFb8mFXNYSda9qcsi7nYuYcAwgL2qheVTkt6G2j3S0WmtmT+
 4qsENBXSAAUSz8yu9i9OxU+V7WMc/+fNBNESKHQ4mqhdMg4+2GzWy6foev94uMWd3MkB
 Wu19xSXETC3Jj8IaVewJIFsn20rpa8SNwlCj7DJV91AMEEhF8VUSEZr8E/OUWlGtcOwH
 CWsWeyduiQT30uIG3KN44ETVlTIgrpdfiTEnOXBpaMGVzSLwjYfEjaBnwKVGrJ1VLoTz
 m5Hg==
X-Gm-Message-State: AOJu0YymttgUB6f+ZKZHtT15XAnVKClQW6gLruA3HHI4k7sFffDX3hgf
 AKbuirBQBjJvpS1ib4ottcSyYT2EM72KYE58jx9I+THPasFvQZimow2tRGVZQh3cmsylTi5CBEI
 =
X-Gm-Gg: ASbGncv4ZjxKFGDuU4HatdAhnik3SxkVUnehCg2MeNYNl7qxhGTwqoNQlqBeUXLG6hi
 4PPKSfoWnENa5ekEQl5zNaNewCwcHTw3+ERAc7Z8qLNdev4bDLsgc3/toUakL8dSz6d77tNT8S+
 QeXiqv/YzbUgh6DPs9atrbLkQVKsLBNDeDl532lEJwtPI+8N0iTET01VhVZwrBPk9VKMpynroV0
 IxzTPUEuaXpWbbxFGWq1KeOtZkORUvvTIeVRQSIVkjBgQTjXbAK2sA7RL4dre5KK2i3vXCq/0J/
 itWtq8763y9bGzEhFbyuCazeQqv9y4+aZ8rqMv1zTg==
X-Google-Smtp-Source: AGHT+IEv09BYUZo42kMO+IOqbpzSNAqn1pYp9oAfI6uo9Z+C2C876Dw+aoCMKzoVKcjw8ouEZRR3Rw==
X-Received: by 2002:a4a:ee82:0:b0:5f6:2e9b:bb0a with SMTP id
 006d021491bc7-5fa3876489dmr16635783eaf.2.1737670057217; 
 Thu, 23 Jan 2025 14:07:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 2/5] efi_loader: Add a version of efi_binary_run() with
 more parameters
Date: Thu, 23 Jan 2025 15:07:21 -0700
Message-ID: <20250123220726.412396-3-sjg@chromium.org>
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

This uses a few global variables at present. With the bootflow we have
the required parameters, so add a function which accepts these. Update
the existing function to call the new one with the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v5:
- Rename _efi_binary_run() to efi_binary_run_dp()

Changes in v3:
- Rename efi_binary_run_() to _efi_binary_run()

 lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 71591dd54b9..789da8bcda0 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -228,18 +228,22 @@ out:
 }
 
 /**
- * efi_binary_run() - run loaded UEFI image
+ * efi_binary_run_dp() - run loaded UEFI image
  *
  * @image:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
+ * @dp_dev:	EFI device-path
+ * @dp_img:	EFI image-path
  *
  * Execute an EFI binary image loaded at @image.
  * @size may be zero if the binary is loaded with U-Boot load command.
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
+			       struct efi_device_path *dp_dev,
+			       struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
 
@@ -255,6 +259,23 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image, size, bootefi_device_path,
-			     bootefi_image_path);
+	return efi_run_image(image, size, dp_dev, dp_img);
+}
+
+/**
+ * efi_binary_run() - run loaded UEFI image
+ *
+ * @image:	memory address of the UEFI image
+ * @size:	size of the UEFI image
+ * @fdt:	device-tree
+ *
+ * Execute an EFI binary image loaded at @image.
+ * @size may be zero if the binary is loaded with U-Boot load command.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+{
+	return efi_binary_run_dp(image, size, fdt, bootefi_device_path,
+				 bootefi_image_path);
 }
-- 
2.43.0

