Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7FFE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3064780269;
	Tue, 17 Dec 2024 14:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JkeavnQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0365680243; Tue, 17 Dec 2024 14:29:17 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F468020C
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd730so38076025e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734442154; x=1735046954;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zz6tmx2YZVdPfiBhCTpM3JAhSy4v2O+1yIvO8xhugc8=;
 b=JkeavnQKlpFdgYGeYetKaC6G6S42FjGA0WJmNnyMSo6REsQ1RL0HOahKv1mKfMTYa2
 dXdzeDnr8/HrTenmDBN3XuN+TavtD7Rs6zv+6HEMVGFnPoNu8+8uw9p5Abal8CHwbA8Z
 VSNAo0rEKkcle7oIgf3cyJA017magGssQXmim5qUPsq8N4RMY06P8IbrBI3PoFyoH4cW
 O+HNOA4jH8Ul1j33lJO8aQJieteSnxdJ1uMfHns/qUBt/gfrARqkTFGfuewg/2kujmdM
 FIp7qLupFwbljeispJCRIjGxcqpLRijk5IsaDvUUb7D3yvGzW1F7R/pscIPDe2cRtH74
 YfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442154; x=1735046954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zz6tmx2YZVdPfiBhCTpM3JAhSy4v2O+1yIvO8xhugc8=;
 b=Z/uBE363dXz8bsYBYZjdninzHJ+KVrVSFz93kd4F/8OI2X+Tn++6Ys6vO3bRha/YZh
 jJrMayB43UHHIv5Aqb7HpsLeH/B6NBw/BnEDT9J9SNzvfvKW3vNB+XAIvsZikaE9/WGl
 OPNVVdVwpBOBUWyOZzj0UM1YCWsf3bwM5QCO5XMTrkTdiFeImV2DRaa+nPEI9Y0PwWdH
 2ixqD9GUAADEIZfs2k4qdEJKmn9BrhaOy6mBHvg10U6ePRXVHRIvC1AqCUt18Rywk9Tl
 SJEqrOSwRMuWFxR7AzG+yoC2mzsBh9GcVFoSItBoBbhvTmKOptLvkUNmfiJsAmoCEOX+
 0HcQ==
X-Gm-Message-State: AOJu0YyPvdndKstUeDSLXsti084Nn7Bl9XfoZrEtoCSjNI8R2yTLIytQ
 FZk6mIBVtCQ0PbB2dfYmsiIH8w8Gmkuh5Wj0IBowNOhZOvZiNvuridwiqjj5fLnixPgGY6SdmY+
 h
X-Gm-Gg: ASbGncvKo7T7AeGr1uTDgSy30V9sRQSCpccEyYHYOp8jsk/dY0RuJOe1GrYq6q+9a6a
 eq+3HN6jW7PmvqWg+Oh0tDDrtA6KpfxoWswFlHLzDgbGO9ocvrfjH+8ohjRkVeEep95vefxYqOn
 H56uW6BHqbTJamf0FRPBqcCgnvIi2AH/NlvHv6UxlV2LJrPf//lyNnW8GRFxAx8TfzTHJzZQfBm
 fC7f5lm6CQAUmvWI6NMTAO1/UZokjQKn25S3XF8ZKcAysGwgR1sMLmL
X-Google-Smtp-Source: AGHT+IHl78pDDQ0T/6aV+q3ItMKUvoPs8xU9IEkT3anaxUKBvRyanr+KxEPWHNle1o5wYVtZO5QbiA==
X-Received: by 2002:a05:600c:1e19:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-4362aa42505mr136951785e9.8.1734442154481; 
 Tue, 17 Dec 2024 05:29:14 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:6fb0:d0f1:bd21:f6c6:25a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec08sm173605115e9.22.2024.12.17.05.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:29:13 -0800 (PST)
From: Nicolas Belin <nbelin@baylibre.com>
Date: Tue, 17 Dec 2024 14:29:08 +0100
Subject: [PATCH v2 1/3] boot: android: fix extra command line support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-fix-bootargs-concatenation-v2-1-b2fd7cf4e130@baylibre.com>
References: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
In-Reply-To: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ahmad Draidi <ar2000jp@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734442151; l=1254;
 i=nbelin@baylibre.com; s=20241211; h=from:subject:message-id;
 bh=e8OqBFasJp/TzB6ajQbwjo+3i7LG87QS5zh/Qw4kK6U=;
 b=9dLT1d+/MR03XT9OO+uv5P5VPEKMxwnAmUgVOmE/UkBuiPPxRMjEAGuwuvUqVvKlRK8sNdLFy
 zKTHsGmAbF5DpdO4lJOy8DJyo8Rh9DYikudxvdYsYqqECPwQhOhfFas
X-Developer-Key: i=nbelin@baylibre.com; a=ed25519;
 pk=w8SrWXgXuIaN/RB7JHkKa2EKDC5nVxqVHI8XawK2M7I=
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

