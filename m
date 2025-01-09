Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4105C0218F
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3011C80601;
	Thu,  9 Jan 2025 16:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsfqQDWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2408B806E8; Thu,  9 Jan 2025 16:03:12 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 014C780601
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844ce213af6so27891039f.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434984; x=1737039784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/StK+Rd8cXBpb5n5m8P17DKpYxZEqr2Zst635y4eFOE=;
 b=hsfqQDWCwQqLkymSkDtrHCauzfOs/luQkohZjTQbNpit08GOMBJLoIutPss8LgiFvr
 Nm4B0ELZpCiyaMuTK+W/f2i01VT0FdD6v2OHBQD2tqVxMJqgvCi9jekaKpNV10mrrpW/
 A+UruF0DqRbIvH3uH5oqv8H1Mh1uFi8UdqE/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434984; x=1737039784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/StK+Rd8cXBpb5n5m8P17DKpYxZEqr2Zst635y4eFOE=;
 b=Rj1kYDV19ROrb/CAalkMGxnr7+IZvCqogCZNUCJ1CyeZNwsTJjyRtbBVuUwMhjrQSo
 hnlxoTChoWuVvUcVFc0lYOqlfHB5mt2g9xaK3MpVoG+A+GAqxIofB+zqWmicjfSg4SUb
 u9UEbptv+3E0m+ZAryBV93munLKbB4AJFxm4hnlfoXRKjLYS7PmXiVDbbfkk+HdyGkpy
 G063jfUEToF5dxjsM2xWc42ryrqpEX+NvtBH7CYyiEgEdgAFfz4nWeVTpmFwTckOhRJz
 Sch5lgZTemJ2Kw+kp9Y2zjWhBO0PW7Q/B78vV2/6E0p4YX2R08flneqoTmPizlczhe1L
 hvjA==
X-Gm-Message-State: AOJu0Yzv4ULq+z3hA1qJBfysmPa8Y40I99a85SSvfjosTxVCtfV9p68/
 r31csRXVS4IFEDg3dVKiFPkbvzvFngwb3YVh2yfmBgs02bevUEmPm55zpT/1GyJLRPfawfCSNkQ
 =
X-Gm-Gg: ASbGncslYXp5egd8qPAU3l6s1f48SUHAncqjODAYICYOpZjubdo/36e/QHwDBLY2s6R
 EV4X+Rff5UtwmPnlNKJ6uJvtFwqlwANLxVr0CFZQbOeUDWCl62oqvLc4/Kher+Wi3kd5u8Zfxkg
 U4yPXxIOUlXGfaAL5frYO+49aw9AnN0pJDdpHsJTTi2woeIvRe03Zy0vI5xTwgf6PodfjD0OqQy
 NjCFClK0jugWiZ0Lm3VmoiqqUZbLzGIwIxSDBcT78253ZzELtAaDQMr2BA/oS9utKJmWKwJTi+b
 ZcYnXOX/jfSRrVfrmw==
X-Google-Smtp-Source: AGHT+IES5AscYObQzdp7ITeUT8GtBc/+alt3fAB6IdlomKTeU84cXvyKmsfXSJdjmuTy9VPV360W/w==
X-Received: by 2002:a05:6602:750d:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-84ce0095c70mr680800339f.6.1736434984120; 
 Thu, 09 Jan 2025 07:03:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b7463d0sm350530173.123.2025.01.09.07.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:03:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>
Subject: [PATCH v4 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
Date: Thu,  9 Jan 2025 08:02:41 -0700
Message-Id: <20250109150244.141173-5-sjg@chromium.org>
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

This uses a few global variables at present. With the bootflow we have
the required parameters, so add a function which accepts these. Update
the existing function to call the new one with the globals.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v3)

Changes in v3:
- Rename efi_binary_run_() to _efi_binary_run()

 lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index e3ac27b03fa..6cbc5fa050c 100644
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

