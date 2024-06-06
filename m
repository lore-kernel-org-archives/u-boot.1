Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE73EC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B871788414;
	Thu,  6 Jun 2024 14:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ED+x5881";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330E988444; Thu,  6 Jun 2024 14:24:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426548840E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42148c0cb1aso10037005e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717676658; x=1718281458;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oF0CFi2zHOWpiAGAyHFRrTrYg5OTNNsEVqs8E0WmVjQ=;
 b=ED+x5881cdzkda/f12Bt1yDWM56ZcUG6MRmgfOkqkxJP7pdnyMl2cFh4CPVULErV8g
 Sb2aaj+pWigrOhjfovcjk2O4KwykoBbfAHXhEyk8+CcVsnbeht9GNsES0CO9WudeaDxt
 fTyRp0wJQDr+yQFrlEqW5BfqBiJStbaw9cEZoqnCH7Q7dvO0gJ75pgs5eVtAlRh1diob
 k9oPQafA162TEboMBzmRFH2Z0BBaz70/ZoaimxRipehpBKg5kVV81kMYMvn7pcRpDH6E
 sN074tsENT826ErZ75rT3RniuqAvcw/iof6MICEegQnRcJVy4Vlok05IHKxZK2MkB0Vv
 FkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676658; x=1718281458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF0CFi2zHOWpiAGAyHFRrTrYg5OTNNsEVqs8E0WmVjQ=;
 b=i3paAzaa61c+d31a5iu3vmbKI2oNrZnVywKIekhc2G6JQz5OkCvsw03IirmE/chryO
 Sn9d+WyNw5MHYoUKKvDHK4TjHwKdPPOWTUwkdLWMc974wK/3UfxW58nqRh32uwtyIoch
 cOE2XSMmW3QIlvtsg4rC2ove9I+bgWVjYncSr9wscr/5kxN3d/AFZHwc0KDjdf4/ub7t
 6qAdWm4HzJHq9GbztAEPb1jxfnvjICt+po7Mf6NTbHKBPzOoZ97FukVJkznG4vMZcnB5
 hUOk+6C+a5HZ3w7kZPRZi1W4MTrDRbs7EdanJTuYrmnn7IkkJT6fAKvchAnv5RdNk2rw
 p0jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8rOwYMxicA6kC2umLukMgMrQKcuHHHWzkpDxeyzb66Bzc75sspNWpNl9SaAgdNL00XIhltWfPwWjrDiDBXSyARM9XPQ==
X-Gm-Message-State: AOJu0YzV8I52Dko3QhrxGKsiO4GalauZoaUXRnO+9ZvI4mfZpe7P3qzx
 8QaePJkfJhHGtlnyfC0FS21/hWjqQcwddAxSJ3bWVuYlOgcW0FNHZ2h7HtChSc4=
X-Google-Smtp-Source: AGHT+IFhA4otmwqbrAqL33XZmiqxAUkbyaSas/mXdRvbYjgxOyusZaKl+2Lx5+ULkafF4WqZRuxETw==
X-Received: by 2002:a05:600c:44d4:b0:41f:ed4b:93f9 with SMTP id
 5b1f17b1804b1-421562dc3abmr39161395e9.19.1717676657670; 
 Thu, 06 Jun 2024 05:24:17 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm1432828f8f.50.2024.06.06.05.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 06 Jun 2024 14:23:54 +0200
Subject: [PATCH 2/6] boot: android: Add image_android_get_version()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-bootmeth-android-v1-2-0c69d4457cc5@baylibre.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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

When reading a boot image header, we may need to retrieve the header
version.

Add a helper function for it.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/image-android.c | 7 ++++++-
 include/image.h      | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index ddd8ffd5e540..4f8fb51585eb 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -185,7 +185,7 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 		return false;
 	}
 
-	if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2) {
+	if (android_image_get_version(boot_hdr) > 2) {
 		if (!vendor_boot_hdr) {
 			printf("For boot header v3+ vendor boot image has to be provided\n");
 			return false;
@@ -203,6 +203,11 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 	return true;
 }
 
+u32 android_image_get_version(const void *hdr)
+{
+	return ((struct andr_boot_img_hdr_v0 *)hdr)->header_version;
+}
+
 static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
 {
 	/*
diff --git a/include/image.h b/include/image.h
index acffd17e0dfd..18e5ced5ab42 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1963,6 +1963,13 @@ bool is_android_boot_image_header(const void *hdr);
  */
 bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
 
+/**
+ * android_image_get_version() - Retrieve the boot.img version
+ *
+ * Return: Android boot image header version.
+ */
+u32 android_image_get_version(const void *hdr);
+
 /**
  * get_abootimg_addr() - Get Android boot image address
  *

-- 
2.45.0

