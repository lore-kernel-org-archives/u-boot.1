Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A692CE8D44
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC5B84150;
	Fri, 14 Nov 2025 16:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b0QQU3pM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA74D84164; Fri, 14 Nov 2025 16:28:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F69083700
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47755de027eso15948835e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763134125; x=1763738925;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zT1gz9UFFKzrz3Jkz8t31NdyQaSWUmFx4HUTwila9jU=;
 b=b0QQU3pMKdCnMxl7dyDAbiXLwBdL9D1KB7w1b8uDHMJhY0WiZK+trJU5MNSqNxvaEo
 BWMQ4E4YdRyufD4HDPm57xrtx4zCDYZp8DS431Lr3EwcNvaW09ZzP5YecM41btcmdlEn
 ExJfU1quOvs1Uc87RJO3nizSTMwi/scAoGcLMvNjDiysBOozLpKg53ZlqSYiEIEFN06n
 6B3wMgkv/2fm3OnOt0Wj7uvgazxBR9PX2TwfHM5cc82Qu0dgBCK6nHXdBoDBAmbP8A0O
 EAUTBJu/mmG489oAjkewjs0zXxCB8elmoPAG80MJ+PGWEBdUBNEH5F8BRJyOQhpDWzF+
 93Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134125; x=1763738925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zT1gz9UFFKzrz3Jkz8t31NdyQaSWUmFx4HUTwila9jU=;
 b=mlFCTDGbfioCu4Gza64B3mV4vchszUqaNjCtMiIrIS/bHgsLZf6xy/oWj1UCJZFveT
 yBIPYwH8dHEPodNtXME0c8wyWFN1DkZWJJTILOrbDvClSmHi30HADUMiSmIJor2WJBeH
 Jm5wz6qAVe2ckcNlqbUKCn0jP9OZQxtbiMChj934J9wse0Rq83IqIo6ZVnx0CA/fjkl2
 zki6UjsFek5aBJS3AureQfWfcZ4R4I+8RD/UEf9sP1lzfzDgDC6I0zFEFfnkE0IQWiLX
 ACby9IlG3NP8tBE0fdaVHILOEqigm1uGVC3L5xLtbdxIr1XNrbUkoBXdg4bkC/7rfmbY
 ySYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkprB0ZZww8uw7DzRPMybXGdBvgfBEI6KEQxVG7XIqYy3EfRHqDh5i/XNtyAM1BvftKI+7X7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxDncun9iUTaodGHpjnntBU/beTZEIXBg0eF7EOljh2WB1KZJWo
 IQiExYojzejzeA02bGNMrzfLZRtP0dsDpTeDdhobPBeMxyFupIoxJdrBvEbntUQyluA=
X-Gm-Gg: ASbGncsP7+bqS2IarbqEQjnMka3zmRyjFZ4Bc+qz4A7pQNbkHEbHlh9XwVo2Ro+DfEe
 tz1mtfV2Zwkgf1430CxmE8kfjW3FZku45nGiwpcQ9DGkbmogACvXovDUnpauoMaV830Gkj7xQtm
 DXU7KIUHt0qpnxQT/xRmc+nRSzedYm3QqzVVVbpVv0I87CEE89dhGOvfh64rKVjrzymlgoGUfQd
 tAPZ/wNFY32LjKlbeCvKaJRmViImAVg4G3PSqvHVETVIZRp+M6B7J6gIKcrhJTKufawZ3Sm6qXD
 ni518NnaPZPz8pm4OqWoTDrumZUIiLJfXgBhcdt4D/LC5yxi7S3eM9V6EGyG+gm1zlhalbdY5Fu
 YhoYMqQq1OZopG919PbsU2+TlzmL7AQFBTl4bTAzACMeGpJGla7IY6O8aaVHzyT6PL4sbncXLEH
 Es/g==
X-Google-Smtp-Source: AGHT+IE8hklFjzy73+JkT/8qIk/bP6NA4jQsDIGFkOJWaq2b2TnJLQZOxTFUQB1Ev9oIBq7DRRxByQ==
X-Received: by 2002:a05:600c:1d12:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-4778fe797a2mr31102495e9.25.1763134124832; 
 Fri, 14 Nov 2025 07:28:44 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:1ab:5fd8:dd9b:8e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779524d2ffsm15741035e9.3.2025.11.14.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:28:44 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 14 Nov 2025 16:28:41 +0100
Subject: [PATCH v3 2/5] boot: android: Add sandbox memory mapping support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bootconfig-v3-2-a28b813dba90@baylibre.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
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

