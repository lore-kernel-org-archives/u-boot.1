Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDBBD6ACE4
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A9783D00;
	Thu, 18 Dec 2025 12:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FFl2ZiP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFE983D77; Thu, 18 Dec 2025 12:17:11 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA8883D77
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso2078675e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766056629; x=1766661429;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CBwiaKkvO5eXDRopF8AQNlDioUaSlMXOzj94JLV1Qtw=;
 b=FFl2ZiP15/aRmFy6RKaK6chYHWEA1HBweN7rMwrnTV4X3R1LAkHDmMdyEWc0iYghXj
 2Rj57p1Vs64si0feN3upahtxbLANJrg6rSGAntjF4O0pDBg3NjddcizfKzhJ3J9MopE8
 JhG0RZD6tjACN0tGju4KJUzW6m5Rc7ra3s/zhqBlKnvhw/LJy/7/+eVjMm78gv4vwHjQ
 VMJNz0z/fSuZPoa9n2OtjbNSt9RQdoQkKOj/vENWiW41AqULNuvbViFupL4c5+Zr509h
 2CqwPH3cj9c81zXQwtHXdR+iWHoj2dw2XH/+Zu1mceVdqwxtmipRV2+c3ehsJUM/JRUg
 xpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766056629; x=1766661429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CBwiaKkvO5eXDRopF8AQNlDioUaSlMXOzj94JLV1Qtw=;
 b=HFGaeiuF1DBhkbZD5/AQNol6dqbJsf5VtgBeYz7lWnQJS0oh4MN8/iatHajF71ftay
 2we/VY/gh6uzEpIGPQIpKAZyzAin0qDT9GHFPt5JXSIEwyCLXMV4PBqMhnsr6IJ2lY+1
 U3sYhn8gv1oF0Dy0RsY7X8un5hB6pnt4bzHHZcJ0eqawfSJSmrhTYB3qNErBg3O0gcC7
 DiSyc/aBiZLbuJVtf96rJx6abOwsXFGmWRx4u0pXXWlMO31aDE1WbMAWa5yS+ZFXhpkp
 t0XOKli7xjbElIlEX3ypNLc3S7X23OUVNCIA/G9TpyJPgQwGh5iZNoY2gOFAJwCtnYiY
 +50w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjElTZcORzBwKW4p8iNwdkJi7m9fiDBgZpcAW5Vq4Gue8j5IIr4Ojdef7mTfn8kIm00CgG1fk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0jQxP9Krd4X7n5T7ExdXGUy+sjXYG0KTWtvqnfbDnFTOeRdLP
 Gfc6rqh3IbXBfYD8MquU4LrXqPPsivlt8x2tB8pBtjHuixVU4QRDvFxaTCYja+zbOu0=
X-Gm-Gg: AY/fxX4v4GOzoKAiRksq7nD8ruRu1LgzYyCZt5xpAoeHfG92Ft+YCWni0resfGLSRxb
 YfJB9iEfx1Q0SjvxugsPVqKrSCqaC//V5qZjRozfSxDkVheAEE8a7ppR8PQxShe0lnEkhyxTel+
 xcamaErv9dXpf+smW1EGKSZc6B4M/Iu0WN4f1bMPaCV2KXHK02OIQgdnssQab5AjWZ55UAnoQPl
 Deba9HNXSz7GGZt1hiBf4WwvfLKl6bFR6/5MY/XkG7MnsXH0yObCTjIHe2w3GJ19QYCMtY89Ymq
 vuL27mqoWF8DUrdbhPRTOONmYs4Upzfe/DeWz0IIvJF1YWN5IPEdjo2Bp60r4keOuZs3NPwu5UL
 eLPHfOH45VFqhwKE6DVmnRuZxuetjKKu/Vwxi0WzI1eYgAMvksoXKRUYrMYvGIg0RFKLNzbX3TJ
 67BcaaHFm4FsUKJQ==
X-Google-Smtp-Source: AGHT+IEG+jrk2MDLw48Yb+qde1p3ZkHbFumfcMUuS+a88umRyUHRFj/Wn27zfZW67IcW4Cq33Te29A==
X-Received: by 2002:a05:600c:46cb:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47a8f8a7f0fmr227346215e9.8.1766056628927; 
 Thu, 18 Dec 2025 03:17:08 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:3734:1277:36b8:3f57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm38070965e9.7.2025.12.18.03.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 03:17:08 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 18 Dec 2025 12:16:57 +0100
Subject: [PATCH v4 2/5] boot: android: Add sandbox memory mapping support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-bootconfig-v4-2-5bbbdb0be1dc@baylibre.com>
References: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
In-Reply-To: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.3
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

Use map_to_sysmem() to convert header pointers to physical addresses
in parse_hdr functions, and add proper map_sysmem()/unmap_sysmem()
calls in android_image_get_data() for sandbox compatibility.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 877cd39fbef..48886f39e4c 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -114,7 +114,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	 * The header takes a full page, the remaining components are aligned
 	 * on page boundary.
 	 */
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 	end += ANDR_GKI_PAGE_SIZE;
 	data->kernel_ptr = end;
 	data->kernel_size = hdr->kernel_size;
@@ -127,7 +127,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	if (hdr->header_version > 3)
 		end += ALIGN(hdr->signature_size, ANDR_GKI_PAGE_SIZE);
 
-	data->boot_img_total_size = end - (ulong)hdr;
+	data->boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
 static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot_img_hdr
@@ -146,7 +146,7 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
 	data->ramdisk_addr = hdr->ramdisk_addr;
 	data->dtb_load_addr = hdr->dtb_addr;
 	data->bootconfig_size = hdr->bootconfig_size;
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 
 	if (hdr->header_version > 3)
 		end += ALIGN(ANDR_VENDOR_BOOT_V4_SIZE, hdr->page_size);
@@ -167,12 +167,16 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
 	end += ALIGN(hdr->vendor_ramdisk_table_size, hdr->page_size);
 	data->bootconfig_addr = end;
 	if (hdr->bootconfig_size) {
-		data->bootconfig_size += add_trailer(data->bootconfig_addr,
+		void *bootconfig_ptr = map_sysmem(data->bootconfig_addr,
+						  data->bootconfig_size +
+						  BOOTCONFIG_TRAILER_SIZE);
+		data->bootconfig_size += add_trailer((ulong)bootconfig_ptr,
 						     data->bootconfig_size);
+		unmap_sysmem(bootconfig_ptr);
 		data->ramdisk_size += data->bootconfig_size;
 	}
 	end += ALIGN(data->bootconfig_size, hdr->page_size);
-	data->vendor_boot_img_total_size = end - (ulong)hdr;
+	data->vendor_boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
 static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr_v0 *hdr,
@@ -187,7 +191,7 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
 	data->header_version = hdr->header_version;
 	data->dtb_load_addr = hdr->dtb_addr;
 
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 
 	/*
 	 * The header takes a full page, the remaining components are aligned
@@ -220,7 +224,7 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
 		end += ALIGN(hdr->dtb_size, hdr->page_size);
 	}
 
-	data->boot_img_total_size = end - (ulong)hdr;
+	data->boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
 bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size)
@@ -271,31 +275,42 @@ bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img
 bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 			    struct andr_image_data *data)
 {
+	const struct andr_boot_img_hdr_v0 *bhdr;
+	const struct andr_vnd_boot_img_hdr *vhdr;
+
 	if (!boot_hdr || !data) {
 		printf("boot_hdr or data params can't be NULL\n");
 		return false;
 	}
 
-	if (!is_android_boot_image_header(boot_hdr)) {
+	bhdr = map_sysmem((ulong)boot_hdr, sizeof(*bhdr));
+	if (!is_android_boot_image_header(bhdr)) {
 		printf("Incorrect boot image header\n");
+		unmap_sysmem(bhdr);
 		return false;
 	}
 
-	if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2) {
+	if (bhdr->header_version > 2) {
 		if (!vendor_boot_hdr) {
 			printf("For boot header v3+ vendor boot image has to be provided\n");
+			unmap_sysmem(bhdr);
 			return false;
 		}
-		if (!is_android_vendor_boot_image_header(vendor_boot_hdr)) {
+		vhdr = map_sysmem((ulong)vendor_boot_hdr, sizeof(*vhdr));
+		if (!is_android_vendor_boot_image_header(vhdr)) {
 			printf("Incorrect vendor boot image header\n");
+			unmap_sysmem(vhdr);
+			unmap_sysmem(bhdr);
 			return false;
 		}
-		android_boot_image_v3_v4_parse_hdr(boot_hdr, data);
-		android_vendor_boot_image_v3_v4_parse_hdr(vendor_boot_hdr, data);
+		android_boot_image_v3_v4_parse_hdr((const struct andr_boot_img_hdr_v3 *)bhdr, data);
+		android_vendor_boot_image_v3_v4_parse_hdr(vhdr, data);
+		unmap_sysmem(vhdr);
 	} else {
-		android_boot_image_v0_v1_v2_parse_hdr(boot_hdr, data);
+		android_boot_image_v0_v1_v2_parse_hdr(bhdr, data);
 	}
 
+	unmap_sysmem(bhdr);
 	return true;
 }
 

-- 
2.34.1

