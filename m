Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F934D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB3389110;
	Fri, 18 Oct 2024 16:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FKeLbbv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51D588D5B; Fri, 18 Oct 2024 16:52:09 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EF988B9E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so53115639f.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263126; x=1729867926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5Nz1VzHUAN542GqYg1OJ1eWGNegX1bxQlo7lI67Zpg=;
 b=FKeLbbv7adWk+ulI2yg4XLd0BUSPAqxYLW5BL+h/4eke0ijrsv/yP3ZqfUYpX4/cJU
 EuV25z2CDaOJ1GZzaScVmV3CTJ6bZf9lXeUER7fjBukZv19vuems0P542fmrI9zNhz8C
 40r6+uZE3UEx24P8tIMrV6gSxwdUQTkwfQCrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263126; x=1729867926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5Nz1VzHUAN542GqYg1OJ1eWGNegX1bxQlo7lI67Zpg=;
 b=NUuXWdS1+3Lk6ZYE+TL9ChBw8LWBwuXleWpt5oVdOFnD7Qfc7uVxpo1zDGQ/z+xpFW
 jL8NcsrZVaoe/0LjHMPd1crSeWsRVP/uoQBKfR7/BEYwFC0y4nWkmi1LszUadgh5oWo9
 GNjHrIIu2zxz4ax0pIX04ISlIiqpoClHjDs9EW5QftGVohzSAoylKiONaHVCzBOJeEOe
 SeAEGO8SKiai9QDO4FvYMn1GscrawL5xEqw5C7bmVzIV+MQC8yu5HwNTlvNoFnBIJaDx
 EYrZHCHxJqZVSvnNpg6DengDTH0hFG4lhZ5XNQy3HQGrst8+yyMGmJHiwx02IMd7VxwE
 9iHw==
X-Gm-Message-State: AOJu0YxRZQ2MOEDnw0RbHcF0WL1/Uar7N/l6Zs1ob1wh5HRfa9Ztnejk
 te2t3O7r74TGXTjFUBmMVdU7iNi7Nxnw6gh2+KR8MTlpMH00XV8STccXnIE5UP+eRf09iQ4rW7Q
 =
X-Google-Smtp-Source: AGHT+IFCWNbHVD/RL+lTizd5QY0WukxIGs12aZfXN+KeEiU2O/BdgQWHdY7AnR7kaoHbF5W946dytg==
X-Received: by 2002:a05:6602:1549:b0:83a:b235:2d74 with SMTP id
 ca18e2360f4ac-83aba5e7d34mr230360139f.7.1729263126191; 
 Fri, 18 Oct 2024 07:52:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH 4/6] efi: Add a version of efi_binary_run() with more
 parameters
Date: Fri, 18 Oct 2024 08:51:55 -0600
Message-Id: <20241018145157.3918429-5-sjg@chromium.org>
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

This uses a few global variables at present. With the bootflow we have
the required parameters, so add a function which accepts these. Update
the existing function to call the new one with the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 8881d648ed6..920a4dfc74a 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -210,18 +210,22 @@ out:
 }
 
 /**
- * efi_binary_run() - run loaded UEFI image
+ * efi_binary_run_() - run loaded UEFI image
  *
  * @image_ptr:	memory address of the UEFI image
  * @size:	size of the UEFI image
  * @fdt:	device-tree
+ * @device:	EFI device-path
+ * @image:	EFI image-path
  *
  * Execute an EFI binary image loaded at @image.
  * @size may be zero if the binary is loaded with U-Boot load command.
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
+efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
+			     struct efi_device_path *device,
+			     struct efi_device_path *image)
 {
 	efi_status_t ret;
 
@@ -237,6 +241,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image_ptr, size, bootefi_image_path,
-			     bootefi_device_path);
+	return efi_run_image(image_ptr, size, device, image);
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
+	return efi_binary_run_(image, size, fdt, bootefi_device_path,
+			       bootefi_image_path);
 }
-- 
2.34.1

