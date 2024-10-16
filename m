Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B90D2A52D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14D588D97;
	Wed, 16 Oct 2024 17:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XfVIRp5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3317A88D90; Wed, 16 Oct 2024 17:47:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329A088D56
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4311ae6426aso47132825e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729093623; x=1729698423; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nwo7viARzicMn+IrB8qzSCQQbI9c8PHhgymd0JXOgLY=;
 b=XfVIRp5YJuUN3B8BXch+ied1bUcTAIMxZGXxwNf0BcDqE6SVQYX4B8w5d/wotdUrVm
 veGhcsXlcHmThvGIqaoapjHBAUIy3LIon56Er4nX+A+J+zR3xtk9k8/fEacZ4qqhh2IK
 C00F29pHuA0S2d8P4Ji4bjCY149gdwyNBn+GNdar08BmlmMcE0YLmMbxseyl4624bDmR
 xNmNRUHIJJbGg3kGVy8PhUCYj+FuqfDIBZeOKiGo3VdsQIZIaSyM6q14t6vCbLT0kIGU
 YpuRze96DWyF6xIj5cRdgS1AIk3RUOMtwVc0HOGoEphCMsKZTs+Wp8WM977eAMPI0IY2
 /zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093623; x=1729698423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwo7viARzicMn+IrB8qzSCQQbI9c8PHhgymd0JXOgLY=;
 b=Gdhg96LZOEbyaq8xu0PkdLG4/rCoVqIOknkCbJiOgOKYrFoqA6F5HMwNTp3vx1L+Aq
 +fvyXVERIndJdSXTxxP72OnCS4nQcWPCTZmId/ArMZybouxOH9POPc07dzYUz+9XKhFz
 Ou5JJHEAR2ifVmd9iaNviZD+9ZnQKfmthTCB7p6UHQbQSrPsxo+k0sR+siASy5ZdThcC
 DaQ7+SHpbOWg2RAxIEgy1LSwqY/DTK9I+J/oIdpUs+VygLv96gEf/FK07Z666Wik5CKm
 Au3ULeMjUgfL1X7EnQ4UaySHm3JnjqggqKQZ0DPiEMZ2XXyQUfetHNpLtfm+Kx0+E0PG
 RD/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7fmsIu2YAv/gaB2M8Z3grOsGG/sh+lnjl+rNPk5BQhgz+LxUR9oX1z2wXDaQO/yJC9rXJU4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzG/agnDfQRSbaYAuWiYgWEAshdaBFe8i2clGh6vwq7nHufAM0e
 HsM0t59N9i85pNp998cf0zYiDbUxQWrgwa2wTLWoRHQTvmeNLh2Id9K53qhPVJg=
X-Google-Smtp-Source: AGHT+IF4gImqmLzFzXYI1mKQqaAjOxuDzdAalnEzXEhyQQyIk/xdUlbX+Vqk1ukHSm+bBe4zfxEj/A==
X-Received: by 2002:a05:600c:2282:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-4314e2601cfmr29977995e9.32.1729093622673; 
 Wed, 16 Oct 2024 08:47:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314a6fbb77sm37767315e9.14.2024.10.16.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:47:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 17:46:50 +0200
Subject: [PATCH 3/3] image: android: handle ramdisk default address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-fastboot-fixes-mkbootimg-v1-3-94fd9340722b@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
In-Reply-To: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4jEtvjOceqPeMpdDY/AHbF4hP8lHsb0o/0CpEIS5dTU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD9/x5GY+w/TI4MlIVDiF/g+w3NQbLXeG8jE9pMM1
 1/Xa5+aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw/f8QAKCRB33NvayMhJ0VRfEA
 CGYL7vlpEenaqORALCWTfueXnkMhJtNvVIWdmV8WJ34S496EpTR1WrhgbksAxq2ncSRyV98/EjLvUd
 JtsQmWWtBLooILVSuy7euA58NCsGCMkYfhPNU+Yx0aM2k9TJ5QkyBkQVv4nyVOd0LBOB0h1hO+TmI+
 IwjrQD1gSVaazICnQwdZTgvG2OTMiBc4TY192F3KR+2RBogzEsabBTMVhKnrX8dC0nRoYU5FOZRxF+
 tpzSh3SAYBtO/aLj9aMmnTof/G3FV47dsESKivUJApqw/faOdAMsvP9kX+L96RVKVQTKNsZ7oeuwwB
 gUE9DOf4Udqb+pHjzWtA31m1+Ml//VmAi33THtpDalRKb1B6iAM4yTGSClN/3Y2AjqeeLuUeFPc0co
 qY6zage7fHGVoBZVWSMiynL3y/3Q9zfPe/piM3Nu+0kG1TQNa4HhvVrpKv2LoCVg4GTn2n7ynOmibe
 i9T3mMEOxADXOX8iQKkqmW7+eo/Hxny5aToBOfmA/GRSRAoPFe+KN9kv+32OiaRKEy6a2sSZo5187V
 PK/bb8JXNotWbHO4A/XOnS0rzEPByVtvwNFOYXJbgnktZAyzdK+nGgTIKoMGs3Y/xH3Yqx5zRQXu81
 9El5W+sE8Nb83/89+lM2T8Lpd3OOc/Qdr60A6LTDeOd/64emHs6r+UER1rbg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The two tools that create android boot images, mkbootimg and the fastboot
client, set the kernel address by default to 0x11008000.

U-boot always honors this field, and will try to copy the ramdisk to
whatever value is set in the header, which won't be mapped to the actual RAM on
most platforms, resulting in the kernel obviously not booting.

All the targets in U-Boot right now will download the android boot image to
CONFIG_SYS_LOAD_ADDR, which means that it will already have been downloaded to
some location that is suitable to use the ramdisk in-place for header
version 0 to 2. For header version 3 and later, the ramdisk can't be
used in-place to use ramdisk_addr_r in this case.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 boot/image-android.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 3adcc69a392..a261bb63999 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -14,6 +14,7 @@
 #include <linux/libfdt.h>
 
 #define ANDROID_IMAGE_DEFAULT_KERNEL_ADDR	0x10008000
+#define ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR	0x11000000
 
 static char andr_tmp_str[ANDR_BOOT_ARGS_SIZE + 1];
 
@@ -405,9 +406,24 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 
 	if (!img_data.ramdisk_size)
 		return -ENOENT;
-
+	/*
+	 * Android tools can generate a boot.img with default load address
+	 * or 0, even though it doesn't really make a lot of sense, and it
+	 * might be valid on some platforms, we treat that address as
+	 * the default value for this field, and try to pass ramdisk
+	 * in place if possible.
+	 */
 	if (img_data.header_version > 2) {
-		ramdisk_ptr = img_data.ramdisk_addr;
+		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
+		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
+			if (!ramdisk_ptr) {
+				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
+				return -EINVAL;
+			}
+		} else {
+			ramdisk_ptr = img_data.ramdisk_addr;
+		}
 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
 		       img_data.vendor_ramdisk_size);
 		ramdisk_ptr += img_data.vendor_ramdisk_size;
@@ -420,15 +436,21 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			       img_data.bootconfig_size);
 		}
 	} else {
-		ramdisk_ptr = img_data.ramdisk_addr;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
-		       img_data.ramdisk_size);
+		/* Ramdisk can be used in-place, use current ptr */
+		if (img_data.ramdisk_addr == 0 ||
+		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+			ramdisk_ptr = img_data.ramdisk_ptr;
+		} else {
+			ramdisk_ptr = img_data.ramdisk_addr;
+			memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
+			       img_data.ramdisk_size);
+		}
 	}
 
 	printf("RAM disk load addr 0x%08lx size %u KiB\n",
-	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
+	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
 
-	*rd_data = img_data.ramdisk_addr;
+	*rd_data = ramdisk_ptr;
 
 	*rd_len = img_data.ramdisk_size;
 	return 0;

-- 
2.34.1

