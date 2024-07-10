Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CA6C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 08:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA0D88711;
	Wed, 10 Jul 2024 10:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RgJtOxiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5818801A; Wed, 10 Jul 2024 10:40:19 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77825885F5
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 10:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so3269835e9.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720600817; x=1721205617;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y+SNMf55z0k8yanEhbRiUxeFajiZ+ehUfTTdKCULZKk=;
 b=RgJtOxiydAvhzob9qwfT3vM/Kp783ZDTZtNS2KveFb+gwyzPZnzcojPhwuKHgnIfxq
 fOGLthV+Q1dJ6YAwvH4lMiYEucgOkTYYvEv899KWrL1Zlt7GQadfiylxgk37hAoXuixC
 IzvFzQXLSSwjeD7/UUKnv7wXuJTIUHKPTi267clnFk/b2BNfzmuH49Vc+gY9LJzEFRfm
 OPE5wUyACQglfmxQORZKKLxkPLUrJUsb32Pyv8amLQf+WOSjoaUbxzGL9ivF2VyIefm9
 6hZgtWDHxlcvtUBmvWO5SESZoWKBi/p/SbGignAn8rHeowbUXyf8zQjJVYpr0/IOXFQy
 39WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720600817; x=1721205617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+SNMf55z0k8yanEhbRiUxeFajiZ+ehUfTTdKCULZKk=;
 b=jVC05J0tK6QRpgMSEWi9cW4mmMTmriWBR5uFP1nIMn3zGW03utMOArgCmgmxmdCaE2
 AC2XqqjwcGIR8DfZjElgWCo595tXfIpHeEw4e2KYBKvfQlhiN6YXzUQZ1lvcJSGgvELZ
 VXT435XBzA0mafkOdEwfLFhcat46b3SUTTrHZKNrLOQPxoSHx0VZRbZjLAV/UkMjJERh
 hOtVee7NjqGb1J5n9K3Y3U4YS2YBqhdZZC3FIzkZiPWlNz9Dd8rzu1IYAqPkkeaUrHSK
 +CC7WbB/ssWkp7oHPzLhakCeKGdUkLRJg9b3bvhAWsOWhp3Tbvch3TOigLXa7qNHSQ2A
 WykQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Gvnz7I6M8r5oUs9Dy50FM27jlrJwHzihoUC3z00LxiCb7F3k1vzNJFusue9dmrCRPWytfgxjxQjrWSsQparRbGAeOA==
X-Gm-Message-State: AOJu0YyajMjcmsYqy09dnzrErVggQccW/PHp5tMueULy2vE9fKe4Is71
 0OOa/8xa3kcz1fLT/kntyYGSWsgcBXx1t+BZXZuTbO/uiL1/KiFq8d1iKyJDyWfddc2+6J17k7R
 L
X-Google-Smtp-Source: AGHT+IHfUrvYdVkfdIlWLqX+rngzSdat5mhcj7dQsDn/Hcf3VowgF01Hvo0jQCyFnKSmKADGVxLI8w==
X-Received: by 2002:a05:600c:25a:b0:426:618a:a092 with SMTP id
 5b1f17b1804b1-42672338036mr38864385e9.13.1720600816681; 
 Wed, 10 Jul 2024 01:40:16 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm39994945e9.20.2024.07.10.01.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:40:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 10 Jul 2024 10:40:02 +0200
Subject: [PATCH v3 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bootmeth-android-v3-1-b99406e22da3@baylibre.com>
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

When calling android_image_get_dtb_by_index() using boot image v3+,
we should also pass the vendor_boot ramdisk address.

Use get_avendor_bootimg_addr() to do so.

Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr()
       returns -1.
       for legacy implementations that don't have CMD_ABOOTIMG, add a weak
       implementation to avoid linking errors.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/image-android.c | 5 +++++
 boot/image-fdt.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index ee626972c114..09c7a44e058a 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -56,6 +56,11 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+__weak ulong get_avendor_bootimg_addr(void)
+{
+	return -1;
+}
+
 static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3 *hdr,
 					       struct andr_image_data *data)
 {
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 56dd7687f51c..8332792b8e80 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 * Firstly check if this android boot image has dtb field.
 		 */
 		dtb_idx = (u32)env_get_ulong("adtb_idx", 10, 0);
-		if (android_image_get_dtb_by_index((ulong)hdr, 0,
+		if (android_image_get_dtb_by_index((ulong)hdr, get_avendor_bootimg_addr(),
 						   dtb_idx, &fdt_addr, &fdt_size)) {
 			fdt_blob = (char *)map_sysmem(fdt_addr, 0);
 			if (fdt_check_header(fdt_blob))

-- 
2.45.2

