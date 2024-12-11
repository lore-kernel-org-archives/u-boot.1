Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27E4E77183
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC6D80423;
	Wed, 11 Dec 2024 19:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OSNzKLAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 157848021C; Wed, 11 Dec 2024 14:53:47 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B65F80209
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2440845f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733925224; x=1734530024;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqgvpd3qJyK7aIBe5h/EodFHhY74i/dG8rn3KVIUtSY=;
 b=OSNzKLAE3ULIM1mY/7LYR8SzpT2eHd5WeTOUOBs6K7Ir1Z00WAYmjvwLaxMvdr1JrY
 pPoVTCAq5GbqlKrgt/gK3/fZV+9fP0aFq64TzmcinW0EqLE0Unw7M1O1Le+21Vig6Ewe
 yGr5pO1UAQdwfpOFpRpn+nu989YRjq/b4+BFlo7wapE8kkgW7aZdH28DinZ2zDjNmcW7
 y6M3762TUDEXaZljtvCl1p230WN4+tKC/NnbG1mPjWLfsEAv88W6pgxml1sLpq3V9qHt
 z+4O/fy8RyaDMezbsdsaHvkjkDi8gBU7T/1OTGoaaQHpmsOEAj0O+yZhDTO46tXt+3SN
 aBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925224; x=1734530024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqgvpd3qJyK7aIBe5h/EodFHhY74i/dG8rn3KVIUtSY=;
 b=SbI5q1oLquCnSN2F3XHOvGz+gKVlBVMqWVzJ7+4QkIcI3azGfk+ncWxaT505IEygXs
 KrVT//NKTnGwSgTF42ADThc4OI+pu9aj/wkyxR9cpXWdnEF+rPD0VmaWC0x8jlDXxR46
 Hc23mmAD9sQMLZpIkgkK0JZ83/1IGzNLZGVWwOpYARKZFmx62DiLgXSHhJIEnVgGIm7+
 WWcyk7nwlwDK+OtlqSp1pKPa3CPx5e7ydaY9OS3htx94Y2RIcMUC7faNytM8eTKjQC5D
 MaO10s8nAsZVD4F9IaAMainy3GXzIB5vFtRQ/b0Ao+0NMygjVcHX7RpQaWo5tipqHfH1
 dgig==
X-Gm-Message-State: AOJu0YwS1Q7G3ymDeKV8u8lUdQZWSgyi4rLeMkUgOa7AQvRao1wdqtV1
 IVVODgWL8AL8Vb5iKQtNZMSaC3gE0pgY7MzVALcyuY/kqlrBXDFP5pkfjA+HfUE=
X-Gm-Gg: ASbGncszHjRgsIB+EdjzRf/X+1zSKue8bo9b4HUvyuVh4ZQ2UIZTLeVcfVDWNairktM
 mAGJGg4PgyJ+IA4EkIhFWDUC4OgSOVjdqxGytVYbGXbk4hlMdrauBAtlo5g5XB2ubdAQLQ2JTK4
 UG3bktoD1nVwSNLfCzy8zYmqV20ydFEMsJLbadwDhZmRyE8aH7WMkZk71octxnm6IHpLVrNK/7P
 ryrmBepvIXU1UZ1aKqnLqiWbe/P0mN9tBaLK47L/7nNWUsBEu/AlFw=
X-Google-Smtp-Source: AGHT+IFAx7zR2rzJO6NzpVdpEfSADAjtMhyMRuscbbl/D6HCmb+caShb1kYTKpqKhh7j2nuQkO7nxA==
X-Received: by 2002:adf:e192:0:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-3864ce559camr2586257f8f.20.1733925224441; 
 Wed, 11 Dec 2024 05:53:44 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:1b92:49fd:8154:d517])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm1316013f8f.106.2024.12.11.05.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:53:43 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Wed, 11 Dec 2024 14:53:27 +0100
Subject: [PATCH 4/4] boot: android: reorder the length calculation order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-bootargs-concatenation-v1-4-c6752bcb9dde@baylibre.com>
References: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
In-Reply-To: <20241211-fix-bootargs-concatenation-v1-0-c6752bcb9dde@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733925217; l=1359;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=UvzwViUIFZQCNBwvBmizUKFMl5TpJmwUz0fGESF7Bnc=;
 b=FcSzQ8/5GzCt2W7bctKpUBjH674tYev5jePmYrL538MIbQWs7eF7pkv2y8UyhUXH2ScpUibny
 3V2w6QeGj8kDox4Pnpvc3GyKl+jGjd1E5+JigMgd9sPSrKLV2sXY+Bx
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

Keep the same order (bootargs then kcmdline then kcmdline_extra)
for both the length calculation and the string concatenation steps.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 boot/image-android.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index ed72a5c30424a453c1800bc61edbe8f33b31b341..a76f028090d0470842bbf559b638175949c527f0 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -287,6 +287,11 @@ int android_image_get_kernel(const void *hdr,
 	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
 
 	int len = 0;
+	char *bootargs = env_get("bootargs");
+
+	if (bootargs)
+		len += strlen(bootargs) + 1; /* Extra space character needed */
+
 	if (*img_data.kcmdline) {
 		printf("Kernel command line: %s\n", img_data.kcmdline);
 		len += strlen(img_data.kcmdline) + 1; /* Extra space character needed */
@@ -297,10 +302,6 @@ int android_image_get_kernel(const void *hdr,
 		len += strlen(img_data.kcmdline_extra);
 	}
 
-	char *bootargs = env_get("bootargs");
-	if (bootargs)
-		len += strlen(bootargs) + 1; /* Extra space character needed */
-
 	char *newbootargs = malloc(len + 1); /* +1 for the '\0' */
 	if (!newbootargs) {
 		puts("Error: malloc in android_image_get_kernel failed!\n");

-- 
2.34.1

