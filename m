Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2279CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0A783826;
	Fri, 17 Oct 2025 15:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OP8WGyHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345E2838E3; Fri, 17 Oct 2025 15:19:27 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADCD8386B
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso16888075e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707164; x=1761311964;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zlQMASokGwgx0Tv2zfKvNuWKVgq1a+ndh0aLlsipOpo=;
 b=OP8WGyHepqYcVR60xYJp2wZGMxTb1wAJx6PFnAGyQ0YteOr0tBIMV1edf+RNRtvsyu
 f+w5CMx4nnJQoxkNwLRNRKzz2V4SEdMkUNZsCwd9pSQGN3DlFK7qhLAP8zOpe0AQ2Gvg
 leJmunOz2I7tbJ1pY8N/vY80ltjuX+6gv0xN9KfpzOWqrY6asWlo31IUVh1zRr0UEGva
 b4nsm5WN5TwDcy5gxF0tG+iuLf2yAjlM3eQuLlKiCDHFAV2cUi8mOQW5+ZYa07lIuHJ9
 Ue36XUCDwvt12R03hV4brffg9PQ+WoAgMDB2QiPYAbnn5ke9s75biazhFr9K3z2JITNR
 XEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707164; x=1761311964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlQMASokGwgx0Tv2zfKvNuWKVgq1a+ndh0aLlsipOpo=;
 b=KZygUPvMTbn3UMSTby9zm6bEV9LraiZF+CPuAXbjwEZfQ9HmgD2po++9WHXCyoSuPj
 8BLJ9OsS+20Iap19GxBDOTl31MG6qsjn7FjhnU35BkCO1hNkXGe3OQaXlY99L1JniF9X
 3qPgcK4FltTS287Ugd06ByOOg6X9uwmYNSXbhoSbnE5nxoYEA47efp2ym0GZxedKGehP
 tMW4FfVWnFzcJNsAO0SZWANWD107G0ih/PUNaTC2laHwVYSlr2PzXu7zl6BVuCH0fzOf
 JJgrAd1fLDMO1ySX4VlWYJ0F/z9AALEqIqktegZeBjZkdtFddBLgQ8Wq5dIueEMwZsnl
 vWtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUoaDh+nEuXMv/yxxGIf7G4ko09XgPZP6zk0ykwE2LKZKBPOq1gb9+WROY68w5L8dxYTFYrA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7uoHex6qHoVivUQurNlLYsc8jo1u111tFwK864U6y7uEHPXTI
 bDjyGtqjtwLcKuy56vpJkoE3z/8g8J1OJTa4Fpcrqe0leMpunle+09S6KPLmOpr+g2E=
X-Gm-Gg: ASbGnctTAAj5ANMy4p13jdWkpfO+5LHW9F7uW9fiEYN6K9mDxcGbgdAke2l/O0OZekX
 LfDbXAX5Txbt6kIkoFU7rVu86f7Qs4kamD/f2ieEGhuXCzPARqc4hm2Wgn4faDyc9NuUAG8dG2o
 g1Mcv5HK1HYLDzLeY7YORmOieuoGaKeBRDg+WcxCWTLDdKRCDluXwEambLTWBXtufByQsqeYcU1
 hiJuZ5/QKw+UqlSkHyA/Y2RgnQxT3N/7xy4GWU2nNwxzMnlYHVg+Q7+7NielEmvppR0Q3lI0nDS
 x2ueMldpsuQdLPekHDyQuzPUFIVpJ0tH/Zks+eg31iLVZtKUliT9h3SOlurzv2dAasB96vhydbL
 j52XmXAcg1bbjy8nrkP/Bvr4rtaz1JZayGd8zF3yX/wZr/qAIAJPQGUMxdzev0OgKDMbaNGTHp3
 DUjJA=
X-Google-Smtp-Source: AGHT+IEB3DWQT2a+EiBhdVPpv46vg2t4AFYZX1DEAqfPYMDd2yXMsw69PKOg8bZBlVXGY4iNzHaJVg==
X-Received: by 2002:a05:600c:3150:b0:46e:27f7:80ce with SMTP id
 5b1f17b1804b1-471179036e7mr26664515e9.23.1760707163728; 
 Fri, 17 Oct 2025 06:19:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:23 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 15:19:18 +0200
Subject: [PATCH v2 2/5] boot: android: Add sandbox memory mapping support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-bootconfig-v2-2-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
In-Reply-To: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
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

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 3a0a934acc7..613f2aa4b9e 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -112,7 +112,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	 * The header takes a full page, the remaining components are aligned
 	 * on page boundary.
 	 */
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 	end += ANDR_GKI_PAGE_SIZE;
 	data->kernel_ptr = end;
 	data->kernel_size = hdr->kernel_size;
@@ -125,7 +125,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	if (hdr->header_version > 3)
 		end += ALIGN(hdr->signature_size, ANDR_GKI_PAGE_SIZE);
 
-	data->boot_img_total_size = end - (ulong)hdr;
+	data->boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
 static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot_img_hdr
@@ -144,7 +144,7 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
 	data->ramdisk_addr = hdr->ramdisk_addr;
 	data->dtb_load_addr = hdr->dtb_addr;
 	data->bootconfig_size = hdr->bootconfig_size;
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 
 	if (hdr->header_version > 3)
 		end += ALIGN(ANDR_VENDOR_BOOT_V4_SIZE, hdr->page_size);
@@ -165,12 +165,16 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
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
@@ -185,7 +189,7 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
 	data->header_version = hdr->header_version;
 	data->dtb_load_addr = hdr->dtb_addr;
 
-	end = (ulong)hdr;
+	end = map_to_sysmem(hdr);
 
 	/*
 	 * The header takes a full page, the remaining components are aligned
@@ -218,7 +222,7 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
 		end += ALIGN(hdr->dtb_size, hdr->page_size);
 	}
 
-	data->boot_img_total_size = end - (ulong)hdr;
+	data->boot_img_total_size = end - map_to_sysmem(hdr);
 }
 
 bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size)
@@ -269,31 +273,42 @@ bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img
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

