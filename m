Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F44E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFFC7801EA;
	Wed, 11 Dec 2024 23:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgF8trZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D99801DD; Wed, 11 Dec 2024 23:38:43 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDD880235
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a816cc9483so131535ab.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956719; x=1734561519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs5aNcyL8bTx2EO9e6qbmo8El0N6RQhlv6/1Dtz3DaY=;
 b=EgF8trZra+HNdUhgHJHVzjeQ4eETYHvoLiurWADOzImITy28eETqNIGkoNG7gmRTca
 DFJKsarSTrIJroNa1gtAJhu35C/4tH6tbpEYPDCXbOjwi1Dz8CqD1Wn+gJe+hVsfIZ7n
 OERN1Ikv2cBZvPsn+yM0FVMSFnWcMmLjdt+6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956719; x=1734561519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vs5aNcyL8bTx2EO9e6qbmo8El0N6RQhlv6/1Dtz3DaY=;
 b=L8/38uklP/AcbVU0miJDa7IESlgspJEIi3bIsF6yhG5A1Yg6KkXTnvxYzAHTUqHU5U
 9Gde6ltp3fuI7QeHPSc4T8QwYJR+b6HnAhNj8wsWxf/Mw27c6fKQJu/9Jq8aBm+P+/Ta
 zeA8HAAxV39GsS6IFshc8nE5ZA7dUS+X0d5hSiWYixRMR+yP5NKB5b6r2aNVDGw01v2q
 T10eU7oHkPnPzhoNARiZJXEBI+KM1CTYXD8QQ4WDHWsuGDwnkclyy7pXzWmBnSbNhQP4
 b89YZqDWtOUrKlxLfleIvPENDY7PR3K/WBhmNRUenOHOt0T/8jamMZgWXP4h+jgshA3W
 GqtA==
X-Gm-Message-State: AOJu0YxMAqnrWovzouyDMtyBhZ7BsPanAFgvOVOgYEGgnLAdZcVdjJLS
 oVCty6zwcFsxWxTjOXYVjmP4DNwnQFKNFLCvMdOC4RpWbOUGNKobrubD5qm4u3hfQ6OCvJEDhck
 =
X-Gm-Gg: ASbGncuO0HAEaxxdU3CyWmvniGEvfdlMoYyQoecc776v4Zd3yWOft68CZURYN/uPkma
 dTeMjJTBYw7yh3jJ+foEluTmIqagLv3+ue0RPETPPMz4LjLa3UTEn7/v56dS2QdV/jH4Q+gxvWW
 BJ5f246Auk5/DH8ZetRdzWlQke52r9elMln1QlMBxJ1q/V1njK6ectR90qYtBg0aGATmEvOQ0iD
 8SVBN7IQYRtC9NOKzdfzdi3afeXaPIxNzAvCHTIDPyOsN4OZQKA84dmrkxZdToRPaotN0jn7XRs
 KKB8bpxNlSrFd2o=
X-Google-Smtp-Source: AGHT+IFfHFpvSzS5RE9Vv3ljsT3a+NK+osPu/nGV+3RqnhA+ieu9kHpxxL+L09iTpC+KVjhF8iWVLQ==
X-Received: by 2002:a05:6e02:1805:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3ac48306c2dmr13460405ab.7.1733956717299; 
 Wed, 11 Dec 2024 14:38:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>
Subject: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
Date: Wed, 11 Dec 2024 15:38:19 -0700
Message-Id: <20241211223822.2446254-5-sjg@chromium.org>
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

This uses a few global variables at present. With the bootflow we have
the required parameters, so add a function which accepts these. Update
the existing function to call the new one with the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 8febd325f34..8ebd48547cb 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -209,18 +209,22 @@ out:
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
 
@@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	return efi_run_image(image_ptr, size, bootefi_device_path,
-			     bootefi_image_path);
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

