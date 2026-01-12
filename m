Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA02C9EC6E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E34E83DAE;
	Mon, 12 Jan 2026 11:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i8j8W5rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1A183DCB; Mon, 12 Jan 2026 11:55:46 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0758383D8B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so45479585e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215343; x=1768820143;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qx0zGGPuIQ1t85iRo43l1BrOcLbzyaQR6zW09yrjE6s=;
 b=i8j8W5rsO/VPn7RDVqpLBlyY/4l4t/uC/yeeZghiEDunIeDkpi/xnLCNmOjfYwTbeA
 0nXhZLzSaVqFIVIo+4HAr6RSmkvGbS3aGRFK1X2neNfy2gJfmy+UV+hUwVhuX5G0ZMHn
 mx4ylPY2tjNnXxe88I197N7AGIn56BnF+PIre8aD6pz5ZCMsgkABVRmytiWPXb9XE/R1
 U+JDoHMsO8Gotzt8zI46xOfi3gtLLT2+b4yGEL08l8jtLG9ZXb5WImQ3tQ4+EG0elwd2
 47bpgDgvZylpfKjXzoJrvn408Jxdr4MJTLHD+WCLT7NNaDGnVPZl7BJI06wcnAa8Pff2
 ERcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215343; x=1768820143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qx0zGGPuIQ1t85iRo43l1BrOcLbzyaQR6zW09yrjE6s=;
 b=nLMM2k2HvCqyrN9sZtDbTc5by8oCpG2/1/ccdv0YRDVctddpR13gCgmwspuqgTrUDR
 lQwI/tRFWxzX22HT4/pTcawBLTWc+QEzqAzvwa+jpBtN+RgawbT/0jLpYajtsJyl1n3j
 XNUETe/pxaLZZRD+cSThQF9botkX0tm+WxH4mtEUyxoqs2eBnBVOMNq1Wd7UPjMAX4JM
 BeXmaazaXjVezBeuSe7Bi9nOTg4ovgfVNMD2iGlKnP1kGkZXpW8EDC1pKZAMUOYu4YDx
 xs3WShQM+5+ii1BfFi06RTEG0rfccWXfWG4a850IbzaX/DKJ/K3TmveYONClblz/C5vL
 pDug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfCEDyvMemaIgCswubLqE5tEXVD8ngct9TeIUWhtg2CaYSEMvkcesLLnlZ2cCD6dPMqpETWk8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv3SQIiQzATnBW5z+jndNXVTg84P5K5qADVafRl35ue+qRTFuI
 VTDkhHJLmUT2FYOGBKcZOel3fjnasUF0TUilFf7BmZuoWgZExQm8EBq0vvVY2f/b3I99AoPDaZq
 JXCFS
X-Gm-Gg: AY/fxX4IAiOM/j/KOzuY4eatlnznSbXXxWOoH+MNq4qiwuZp6OMcUPRHP2u7dTvjgYs
 dW7r1TtqbqM6220tjUlZi9nYdkDBNWsMrp0ywa2C7L+p4fJ1az7iovd6mGO+BB6GzUX59oLr7to
 Pw0dxbU+WXG/bVfo6fs3B44notKg/rc6lfJPyf7hXsZ7dTqTzjc0K64uiYbVJTQfIrVHIAtGBRf
 a9iaKyJrF2c44XQgdyYE8iglcEmFhCksOoue5QuhNOBxky+X6H9bCE6pyxZqIbmG+Fu/yZyvgIJ
 zq8cRXgfPFXss8ZmHg2XYJn6Cb+AhHNqY3fGGvhq7lh9XYA38Auor7JVoEm8bEzPk7/PuWnmVgu
 iuFWWV0cULDy+pzc9GKAM71GPa++kZ3YBsVx1ad99gxgYJEnG9SIkdksyaz2EyMd9Oy5SAfJhkc
 oorQHm3MhrIT9HMQ==
X-Google-Smtp-Source: AGHT+IGnXqnSEElsJgem9lJCpymLmdCT5QSyM/j8gn8dxPlSWNGqARfJijcze14H8bnYUb9elcOYIA==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47d84b41007mr205627775e9.36.1768215343274; 
 Mon, 12 Jan 2026 02:55:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:42 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 12 Jan 2026 11:55:38 +0100
Subject: [PATCH v5 2/5] boot: android: Add sandbox memory mapping support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-bootconfig-v5-2-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
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
 boot/image-android.c | 58 ++++++++++++++++++++++++++++++----------------------
 cmd/abootimg.c       | 20 ++++++------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 5407390ef36..b9e0b3f68b0 100644
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
 
@@ -724,21 +739,14 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
 				    u32 index, ulong *addr, u32 *size)
 {
 	struct andr_image_data img_data;
-	const struct andr_boot_img_hdr_v0 *hdr;
-	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
+	const void *vendor_boot_hdr = NULL;
 
-	hdr = map_sysmem(hdr_addr, sizeof(*hdr));
 	if (vendor_boot_img != -1)
-		vhdr = map_sysmem(vendor_boot_img, sizeof(*vhdr));
-	if (!android_image_get_data(hdr, vhdr, &img_data)) {
-		if (vendor_boot_img != -1)
-			unmap_sysmem(vhdr);
-		unmap_sysmem(hdr);
+		vendor_boot_hdr = (const void *)vendor_boot_img;
+
+	if (!android_image_get_data((const void *)hdr_addr, vendor_boot_hdr,
+				    &img_data))
 		return false;
-	}
-	if (vendor_boot_img != -1)
-		unmap_sysmem(vhdr);
-	unmap_sysmem(hdr);
 
 	ulong dtb_img_addr;	/* address of DTB part in boot image */
 	u32 dtb_img_size;	/* size of DTB payload in boot image */
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 6fb52153786..c488609a8f4 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -92,26 +92,18 @@ static int abootimg_get_recovery_dtbo(int argc, char *const argv[])
 
 static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
 {
+	struct andr_image_data img_data = {0};
+	const void *vendor_boot_hdr = NULL;
+
 	if (argc > 1)
 		return CMD_RET_USAGE;
-	struct andr_image_data img_data = {0};
-	const struct andr_boot_img_hdr_v0 *hdr;
-	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
 
-	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
 	if (get_avendor_bootimg_addr() != -1)
-		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
+		vendor_boot_hdr = (const void *)get_avendor_bootimg_addr();
 
-	if (!android_image_get_data(hdr, vhdr, &img_data)) {
-		if (get_avendor_bootimg_addr() != -1)
-			unmap_sysmem(vhdr);
-		unmap_sysmem(hdr);
+	if (!android_image_get_data((const void *)abootimg_addr(),
+				    vendor_boot_hdr, &img_data))
 		return CMD_RET_FAILURE;
-	}
-
-	if (get_avendor_bootimg_addr() != -1)
-		unmap_sysmem(vhdr);
-	unmap_sysmem(hdr);
 
 	if (img_data.header_version < 2) {
 		printf("Error: header_version must be >= 2 for this\n");

-- 
2.34.1

