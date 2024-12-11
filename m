Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC6E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0924B803B5;
	Wed, 11 Dec 2024 19:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mUwiS8h7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D846B801CE; Wed, 11 Dec 2024 14:53:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC118021F
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso4326695e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733925220; x=1734530020;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cx4Wjml6R7UqvqvYqSaz5Ezm+RbKNsCKx9qXP3CHfdg=;
 b=mUwiS8h7Cc+9sFiQtPena0IftkDeNKg5ex6hqg3SRa/skYghY7+zyGGp7N6XgiyECP
 f84IWznXLn3K1HN6vSPhnO7I1VI2u1NQjSOHeWuLgyPgt3lyeMYnpP6D/c1dutYZDBkm
 03jiIPy64F8tdSKOWoeorLj/hAzkt1MkIsLVZAswD+b1Q7sOgRUfWfZqWgnITd9h8Xr9
 FUVLhsqzP1EzIpD4+ukE8ZCtw2Bsn2yv7Y7/6hWEF+cz0fPrBlA3tpWOyYcYVzjGZcn5
 b7YG+XSXFhPPx79oBEeDC1jK4KheipeVn0TIniaAlKGzDtdaZS649tvXvWXLZEBO7Hwy
 mXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925220; x=1734530020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cx4Wjml6R7UqvqvYqSaz5Ezm+RbKNsCKx9qXP3CHfdg=;
 b=n3s5mILXjHtVN/Wi3S97Dx2xQeEZKY2KNHDN+GuwGzp7//bq8Idzy/xi4VBvqXNMb2
 z6obsW8qC8/DEoWS5KCIJAngBj6+fhpFwBES7K6gUJ4xNLOr7JynivsAjzkl4BG3pPL2
 a6LOuWdtSJdGS0gHwyIH0M/JFrir6qfRDztbUgvzSC54X41+qCYetgvku/mU2qjmW//x
 BWI+wMmfUGXmFH1A8de13eB+C4hnVlgI0PdLDgat9Iec4XtyaXk7hlGvoIo9dXAW6dsm
 Je7ozNBXidw1GQVr8kevbnRl5s5Pp0khEZ4cTvFZrH/Zxux/r+b5sOReidolKANysw/V
 b6TA==
X-Gm-Message-State: AOJu0YxCOxiij243PfXy8GnTpbUVG4k8oCPGzD8cwGtIrUTKHLv4oHdx
 W+nEW6YIIyrGLwepR+H0//0AkGDayPSyObTMsLPJwx7Zm2CUS4Fm51cvBum0Sfk=
X-Gm-Gg: ASbGncvhi0IHjif33fvRXYP8steIfveE960eXcIp5kEq1e7jJKIWGd8NdorvfNstU8U
 UdVhZAqBSkSYm8TfldvCR9sR6rLSeXSwacWZmKFZnQJIMG4ouvddghDfCoZuDioWFbYO79HDelx
 vr07qyRBg3RIYDl+xCfN1tRb87v1P+T9TYp/WMFFFrtUEMiUguSbrZ55z7gRvAKJ8u4yNxzQ1uC
 ZvaXzuwQJD2cHt7YQZAhJsr5skt09L+0UxRQT1+a+3w2jIO8DrHJx0=
X-Google-Smtp-Source: AGHT+IH9tgDHXowkBAduhUDmoq0GhggtR7398aLoc0y3i8OhoYRmh+ZQJbVcYfTGjgN9Sw3xy/K95Q==
X-Received: by 2002:a7b:ca57:0:b0:436:2155:be54 with SMTP id
 5b1f17b1804b1-4362155c09amr6284645e9.1.1733925220201; 
 Wed, 11 Dec 2024 05:53:40 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:1b92:49fd:8154:d517])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm1316013f8f.106.2024.12.11.05.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:53:39 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Wed, 11 Dec 2024 14:53:24 +0100
Subject: [PATCH 1/4] boot: android: fix extra command line support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-bootargs-concatenation-v1-1-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733925217; l=1192;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=DyesOp+C590L5T7Z2hT7liy29EvlAGa6I63Wo6XkD6A=;
 b=+AqrgT+SquWLLUCLlweoWXd5oBDSMX5lX9qOMQ26HvrSmvpap+rZOwZT6GLQ1s5C4SDi8ylfG
 7RS4ELkWBqLBYroOtVsVT9SNfpaO4l5No7N5wtafBIwa4u3jiWqSlE8
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
X-Mailman-Approved-At: Wed, 11 Dec 2024 19:54:12 +0100
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

Check that the value at the address kcmdline_extra is not 0
instead of checking the address value itself keeping it
consistent with what is done for kcmdline.

Fixes: b36b227b ("android: boot: support extra command line")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index cd01278f211d63262f2bdad7aa1176e2c1bbfedd..57158280b41c6552c82838e21384d925d5f7cde4 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -292,7 +292,7 @@ int android_image_get_kernel(const void *hdr,
 		len += strlen(img_data.kcmdline);
 	}
 
-	if (img_data.kcmdline_extra) {
+	if (*img_data.kcmdline_extra) {
 		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
 		len += strlen(img_data.kcmdline_extra);
 	}
@@ -316,7 +316,7 @@ int android_image_get_kernel(const void *hdr,
 	if (*img_data.kcmdline)
 		strcat(newbootargs, img_data.kcmdline);
 
-	if (img_data.kcmdline_extra) {
+	if (*img_data.kcmdline_extra) {
 		strcat(newbootargs, " ");
 		strcat(newbootargs, img_data.kcmdline_extra);
 	}

-- 
2.34.1

