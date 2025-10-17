Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326EBCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F159E838D7;
	Fri, 17 Oct 2025 15:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uhn8NHHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F253D83873; Fri, 17 Oct 2025 15:19:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7FA83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so17889625e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707165; x=1761311965;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6QpKbfr9IxdFwg2srKr85BzEUHl/CV6l6OIca+EzFhk=;
 b=uhn8NHHR+9B0FEiPyGJsT3HmRlxP4VTnTIh8P5fw9nwJDspiOrUA8BX7sUx0IoTn3M
 NxPv4ZcHVCfP/n/1Iqxiv6+olUI114M9eto7p1YEXdyBnwg0G7g8nc7uJlx6YuyFbmS8
 DYrU6ciMUYQC7hSlkYca0zZsJnAoG52RrBGaHi7890itaZ4ra22oDIJOrYu15N4Gb5QK
 8A92LIYHjN1ZE2bHl/sicUsgVEtQzIpNqHtfKPIbxErSNzwmyqtfz58jmmLIkY1XCXke
 u+3HdkEBS3vMHt5j7yUFnPE4IMLrvORCTbcn9vd9uWJFhz5OPWbClFpo9sXgklGRi7di
 1ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707165; x=1761311965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QpKbfr9IxdFwg2srKr85BzEUHl/CV6l6OIca+EzFhk=;
 b=SEVLNcVfO8NlPSQN+PYZHifk5+d+reifoeB1yPZt0GrZvCYCIgpoC/tHDERfu0pRW0
 GoJS4i9VSzxFCUky6Q+77OWdi2O6j5pv8TEfRS6PBkyfDos7Nwf8mAnq2+q890F0GA3V
 uC7Pt1JfGGOOdaKjy3XE76zoa5Gdz1IV5GhD3RRz+myPK8yPG0XvoQf9QZZ7AUYM5H4K
 nSSvTtsxCO3AfU0HHiToQjwYB6UTYh+u7fm0TOP+TisDjY3ZdggXASyxIZi3maBgfsgq
 MjKBPLbi/47p9630isn4mvgDMPU+0XRhjEwyEoH0dDu/+8bb5kQjCIIACm2yod3QAOyY
 IcDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDXO4UoGhZhfzOKMs+My1En4UmdWdi+Nn3RNqDoh4Pg7RsDhzmVstS8EikvFVWdmJNUsIQm2o=@lists.denx.de
X-Gm-Message-State: AOJu0YzOIhWNfyk31wYuSNqU+Ji3zrP70C/V+7LPo4RYJtzRfsVLOH6w
 2qtMA6bErWhAD2KTHl+m7mlupEZ6lmEIe7RVB1cGu3pRlkW7tYPdSfnbnoOwuROKp+Y=
X-Gm-Gg: ASbGncuBYhDOmyanxqKyTC180oUuHar9pvqXxQ4MXCyUzWIu0OLytAm0PagQ+u88AmD
 XPvrfXS5MpVvEJAEhxQYC26QreUzv7puHOd+dmk2qZm7ehqP926nLc3xslfvQtspiB2JOPL4WSh
 QRTzvtJpf90LR3Bb477bvdskrZewTzDY6pooah56ptQJ5svdMBCr3DTRFwxWQ0cpMquSo6PUanO
 2YX8pfREgrE0+282vp4Cn59JNOOSPg9V/bTaTJAncelDLjvm/SXw3oPWgn6gswvLgJRiqr8BIjM
 UNP+z9BvRLKL3Ypo1ZyclrjZw8fnwjDYZ3qxU5E94Occ0n6r/Qwb3x5VN7K6AkG7id4XbVxOign
 J7fK3/qz/BO5YXtC0+qPDOsp/qr130VvL9kFZFXvMChBpDus3gnnlID/KuctrmWXrEF5GTk7Npb
 7ckZhXudyHdb6Daw==
X-Google-Smtp-Source: AGHT+IHKhYq8RUaod497JT8BWwL03E8bsXwiKhpj9EkE/PrEHALDB7pFRxM1cGJeiI030zWbneVo9g==
X-Received: by 2002:a05:600c:8b0c:b0:471:15df:9fcd with SMTP id
 5b1f17b1804b1-47117911c51mr27467775e9.25.1760707164797; 
 Fri, 17 Oct 2025 06:19:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:24 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 15:19:19 +0200
Subject: [PATCH v2 3/5] boot: android: Add bootconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-bootconfig-v2-3-8c7c2f2e5474@baylibre.com>
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

For android vendor boot image version 4 bootconfig is mandatory.[1]

In the android_image_get_ramdisk function, after copying both vendor and
boot ramdisks, we extract all androidboot.* entries from the kernel
command line. These entries are added to the bootconfig section.
We then update the sizes of the ramdisk and bootconfig.
Finally, all androidboot.* entries are removed from the kernel command
line.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 8 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 613f2aa4b9e..cf038a4a62f 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -534,17 +534,102 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			ramdisk_ptr = img_data.ramdisk_addr;
 		}
 		*rd_data = ramdisk_ptr;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
+
+		/* Extract androidboot.* parameters from bootargs */
+		const char *bootargs = env_get("bootargs");
+		char *androidboot_params = NULL;
+		char *new_bootargs = NULL;
+		size_t androidboot_params_len = 0;
+
+		if (bootargs && img_data.bootconfig_size) {
+			size_t len = strlen(bootargs);
+
+			androidboot_params = malloc(len + 1);
+			new_bootargs = malloc(len + 1);
+			if (!androidboot_params || !new_bootargs) {
+				free(androidboot_params);
+				free(new_bootargs);
+				printf("Error: malloc failed\n");
+				return -ENOMEM;
+			}
+
+			/* Extract androidboot.* and build new bootargs in one pass */
+			const char *src = bootargs;
+			char *bc_dst = androidboot_params;
+			char *args_dst = new_bootargs;
+
+			while (*src) {
+				/* Skip leading spaces */
+				while (*src == ' ')
+					src++;
+				if (!*src)
+					break;
+
+				/* Check if this param starts with androidboot. */
+				if (strncmp(src, "androidboot.", 12) == 0) {
+					/* Copy to bootconfig (add newline if not first) */
+					if (bc_dst != androidboot_params)
+						*bc_dst++ = '\n';
+					while (*src && *src != ' ')
+						*bc_dst++ = *src++;
+				} else {
+					/* Copy to new bootargs (add space if not first) */
+					if (args_dst != new_bootargs)
+						*args_dst++ = ' ';
+					while (*src && *src != ' ')
+						*args_dst++ = *src++;
+				}
+			}
+
+			*bc_dst++ = '\n';  /* Final newline for bootconfig */
+			*bc_dst = '\0';
+			*args_dst = '\0';
+			androidboot_params_len = bc_dst - androidboot_params;
+
+			/* Update bootargs if we extracted any androidboot params */
+			if (androidboot_params_len > 1)
+				env_set("bootargs", new_bootargs);
+		}
+
+		/* Map addresses for memcpy operations */
+		void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
+		void *vendor_ramdisk_src = map_sysmem(img_data.vendor_ramdisk_ptr,
+						      img_data.vendor_ramdisk_size);
+		void *boot_ramdisk_src = map_sysmem(img_data.ramdisk_ptr,
+						    img_data.boot_ramdisk_size);
+
+		memcpy(ramdisk_dest, vendor_ramdisk_src,
 		       img_data.vendor_ramdisk_size);
-		ramdisk_ptr += img_data.vendor_ramdisk_size;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
-		       img_data.boot_ramdisk_size);
-		ramdisk_ptr += img_data.boot_ramdisk_size;
+		memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size,
+		       boot_ramdisk_src, img_data.boot_ramdisk_size);
+
 		if (img_data.bootconfig_size) {
-			memcpy((void *)
-			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
-			       img_data.bootconfig_size);
+			void *bootconfig_src = map_sysmem(img_data.bootconfig_addr,
+							  img_data.bootconfig_size);
+			memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
+			       img_data.boot_ramdisk_size,
+			       bootconfig_src, img_data.bootconfig_size);
+			unmap_sysmem(bootconfig_src);
+
+			/* Add androidboot.* parameters to bootconfig */
+			if (androidboot_params && androidboot_params_len > 1) {
+				ulong bootconfig_ptr = (ulong)ramdisk_dest +
+						       img_data.vendor_ramdisk_size +
+						       img_data.boot_ramdisk_size;
+				img_data.ramdisk_size +=
+					add_bootconfig_parameters(androidboot_params,
+								  androidboot_params_len,
+								  bootconfig_ptr,
+								  img_data.bootconfig_size);
+			}
 		}
+
+		free(androidboot_params);
+		free(new_bootargs);
+
+		unmap_sysmem(boot_ramdisk_src);
+		unmap_sysmem(vendor_ramdisk_src);
+		unmap_sysmem(ramdisk_dest);
 	} else {
 		/* Ramdisk can be used in-place, use current ptr */
 		if (img_data.ramdisk_addr == 0 ||

-- 
2.34.1

