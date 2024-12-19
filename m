Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39915E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735B780328;
	Thu, 19 Dec 2024 03:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TYZ0Fm1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCD88021A; Thu, 19 Dec 2024 03:39:15 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A5680295
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so975995ab.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575951; x=1735180751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5pAsWu3NfBzEZ6sZD5TSKfrMGKmu3BHGYstuPyKu48=;
 b=TYZ0Fm1zkTvFp7wq56IFZdn2xDOiBA87ZiMPlaMmRPmYubBW3dRI9FfcuAofQSvGx6
 /7M0SG1l2KXOsWxoqPmILgk+4YJ+flsC0FsR1rHDP4XLh9iIpAPQJT13aj4egSCm+l9T
 r7zJn0MkPbcn3wQJIehwCWH0rT1ZCCSOLXG4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575951; x=1735180751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5pAsWu3NfBzEZ6sZD5TSKfrMGKmu3BHGYstuPyKu48=;
 b=dUrQR76cr91JSFt1hS906d0VDxNSNQSwBz7LuC3X00ul7rrnzGBmEZ94wBN4RC7qJS
 aRygvngkJv43vHWFkoa2uWS21tvWXpTbvsRAgsydXapZK+/+IpBgnitLVz09QS5nv+FB
 mG2+9zZKzbHHBRf9MN3eVB/+8QaZ4ACYVNZn4SYJf3JPiGbxQUhqzLmt8zL/wl0ip8RP
 CeFQkN7dTFIT6dudgI+zxy3k3ZGk8VgSv8UFdiw3u5IEfnwf5lIq8nADig+aJ4I9Pxgn
 Srq8BG69IMbca9F0Zww3SEBr+/sKzi3+pl65+r5g/lVl/GyA+nsXW6/rQvbSn4Vf4Xu9
 qaSA==
X-Gm-Message-State: AOJu0YyZhT24NWI6Iq1ex+IdgQuc4FCLv8TeMbvTIp//GMm5n4HLcbQv
 mG7uL9NxaKARJbTz9iUn9MmXgVwLTk0UmRwf+gtPyGO6JFnzT9n8jafBiMmUyyrJI2LpygzfL48
 =
X-Gm-Gg: ASbGnct3MAfoPHSn8AtrXyS4Vc9E4YnmyOrcssvG6m61Mzi/5czBy4WmI1kzCKZHd4S
 HKhLvoI0c83f+JrPInTNCSO0UEkHkeI92sHBOKayUncIMWLqqVn3BGS9Slm6aElh+TRxhzhnA/i
 R56YK4hGfaistkMR8VG4T5sUNUelHkahFg4BE3lkwi/ERgX8Vxg5kWflQP6PdTArjqK8RG5BIZ2
 70HiiIe7XHJ85ee/+kHQ3/UZLIbBIpUhBGG4QZqruWpmHCQqwQV/5h3YMjT1mJongekO50XT0Gp
 9dTPj7Ke4I29OvPQag==
X-Google-Smtp-Source: AGHT+IECscBcalBIp4lb2TZ0vt3HRpsCBf/RZb6bFPffjXtvTPRWZxohEksC3W7EufyZsK/By4Lmxg==
X-Received: by 2002:a05:6e02:20e5:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3c013de6b24mr15428605ab.17.1734575951381; 
 Wed, 18 Dec 2024 18:39:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
Date: Wed, 18 Dec 2024 19:38:29 -0700
Message-Id: <20241219023832.1098689-5-sjg@chromium.org>
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

This uses a few global variables at present. With the bootflow we have
the required parameters, so add a function which accepts these. Update
the existing function to call the new one with the globals.

- Rename efi_binary_run_() to _efi_binary_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b42ff3cb4e0..f7aedeaab8a 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -228,18 +228,22 @@ out:
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
+efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
+			     struct efi_device_path *device,
+			     struct efi_device_path *image)
 {
 	efi_status_t ret;
 
@@ -255,6 +259,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
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
+	return _efi_binary_run(image, size, fdt, bootefi_device_path,
+			       bootefi_image_path);
 }
-- 
2.34.1

