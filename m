Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF08C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C6F82B97;
	Mon, 28 Apr 2025 16:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnT/mGMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70FCE82B4A; Mon, 28 Apr 2025 16:53:21 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECB582B33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so4979027b3a.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745851998; x=1746456798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UX4AMwM/U6aAgvjv+rJJQ6DwXbhVM2OuZE4HfGEcz1E=;
 b=lnT/mGMAsKPkMepf922miIBj2ukwMGeRi0DI5c6eZtYFYmhHW32UEs+hL8Id3HceHi
 7Vrw9O9QmaCXJKzYq/T4TC7uDfFCboZN77iTMCuqm6Py0H/jxOFwJ3gSXb1QOFi+Yqg4
 DZpnLbxVRz5whPkTG+NgVp+v90iED5KO35YSIm34ydNzzXIVUWyACiW1AWCM2jn7yteP
 EzMt8cv4ZbY1f9j8zcLqlmuEZ2GNTuDW+klXYeT1znRxVXfVW/nDp+9v0TYzapqo4dXE
 cIOVGkbp4nH6iQpdnDF/PXq5nSKJII3juFPIghutSf4rFGmB0MaPkyBu3UzQ2Y4WXVK4
 np6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851998; x=1746456798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UX4AMwM/U6aAgvjv+rJJQ6DwXbhVM2OuZE4HfGEcz1E=;
 b=vzQFEXIqdlYiS3moO6ZM0zhHZ6kCWNuFELYcwN876l4pdAdVojgmKWk+IRNzV9fXXp
 6RgiuhfYbbWu7xBSOLHc4Qv032OuQJUiRyJlNgzosKemzZHZpVJGADvIj0aY7zF4PfTD
 3UrxRwplfg6ru/ZQIyhG8WN4GJObQfqBiuRMrk3TGnToD/3H07Zh62wPZGbdAHmE2tAD
 ekXaRI+N+VAGQUDbBchGlGaNxumsFRk6TKfzQn4KJN1+ns5wCe1nevEW1mUuVgqUPKEJ
 8EAYzGcOafgAqnrZfqSYqkpuFLq1YL+3nYX30OJ99RjsM9oo/KyVeIFqSe3MFZ4+h+Zu
 yZfw==
X-Gm-Message-State: AOJu0Yy+S7FPkUnMNOjchfc2of/yjnMjSCLd+W4xJYjyH7hEBAJVemwV
 JUXHR47/FP9t5FKYPDWdjfqwiZScE6yT5lXyuVMdIPqkppqTd50ps9/CGHpc
X-Gm-Gg: ASbGncssA8A6wrGk81lWwTeYlofPNRDOVk9MWsf0g2ID6K/4LoMQc8pZlwyg9tEnKcJ
 L3x5vhr6U0yVNZjid8CgsUod60j4a9rTbESO66D5jUyS8jL8+WiXuqlevIW8xnZsHMhehYUxXu7
 WZqJ0CFiHHADggVyTjIqqtMWxqUxJkgcjXRtH9ZmI5P2Py2cTdtY6k/XzxBIXV0wHyO2oIa2WlT
 cRgLqrT3lezWuQ2kI/hKTfy4aWhKB7FFx/LlDMyjUAg6EC/+bz6umRhzSABGVj8qeU3WrAwVfsn
 xcav6pZhWlMzN2JACjmgvX/xze7ECxDNxNFwTeoD/6Xok/pv4hBw
X-Google-Smtp-Source: AGHT+IG4U10SiBiwbp9fOCX4nag9hQRYHvrshgYtfclhRDCnDD1MqF5LlTWyoQnP9GmJigZKsIolsA==
X-Received: by 2002:a05:6a00:1809:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-7402710a56emr172055b3a.4.1745851997557; 
 Mon, 28 Apr 2025 07:53:17 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:1104:675d:ec62:4e96])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a58bsm8317367b3a.143.2025.04.28.07.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 07:53:17 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 2/2] efi_loader: fix typo initd_sz to initrd_sz
Date: Mon, 28 Apr 2025 10:53:40 -0400
Message-ID: <20250428145341.2091400-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250428145341.2091400-1-adriano.cordova@canonical.com>
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_bootbin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 6a189c31ffa..94ba7c5589b 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -215,7 +215,7 @@ out:
  * Return:	status code
  */
 static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
-				      void *initrd, size_t initd_sz,
+				      void *initrd, size_t initrd_sz,
 				      struct efi_device_path *dp_dev,
 				      struct efi_device_path *dp_img)
 {
@@ -233,7 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = efi_install_initrd(initrd, initd_sz);
+	ret = efi_install_initrd(initrd, initrd_sz);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-- 
2.48.1

