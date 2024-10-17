Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4EBD374A2
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63D58904C;
	Thu, 17 Oct 2024 16:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NaBIW69j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27651889EB; Thu, 17 Oct 2024 16:44:55 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD94689011
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43115887867so7484865e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176288; x=1729781088; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EzhLcA6piBi9Lp1lE8chhJOw/6UMV1aVb8+MOmQmkew=;
 b=NaBIW69j7/VrXATjdME9Fxl7CuAsSuzWXGxsKYWzxi4devJabx3rTBMaMPvDvKPRUj
 1iFcZii1AmHpvlrcXvZfuvjD+B6PblAMVruLVhbuQNqdT0rXkOBXXVtmBzDdyrPQTR+J
 mDsJKuDqzEuCMxp9vpPnHyb7lPj0CHfnIGs8iN0zVWzKJWB9nnzlKJw0lszpFKEFI34p
 LVDDxnMx5EzMbL1a31Ho+BYYjVqqAkPFthrbjqwCBDc5R5g2uCeUyf4RPMwvTseKPvGD
 14SgT13ABJmC0GduVLxquE15yfoYIJGq3gEYFO6vJBUpGfa7Z8Jbw+m3qHkx0l9pOZ/V
 nsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176288; x=1729781088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzhLcA6piBi9Lp1lE8chhJOw/6UMV1aVb8+MOmQmkew=;
 b=WzdmxmTLoCoQMlyYKI1PVLyA0dMgHeY7RXHEgVmRFLcjF5HDgi0W9dP0RtaZzAptVI
 JZIS9WaXxRtVWtXPkL5x0R4b0lbJVeuz1z81/FYWSVZiVcX5VzYUwqzDC0Jwepc7AqK6
 Uico/WV+1hklTywyndwZWJEjoQZBjHH4Bued7wpA0/hevdLDGCc3KUmj3yE7INomiOJd
 MgV8qR91T6XOu6I0Qv2w4LVpSSsY6fw3ZYgkqKnrHTVFvRAGlIfA7+DblzGs0Tp1a92I
 iFYvo1cGMPJyAfn7wAbohrOuylI0gShHYiSP/7QHhv6gSh/j5GPaSFHTyc8SxHe9aG0f
 sFbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Y9bYSc3URIGtL0NI11VwhFZxRH9fXtbbtnAgFwIbExcnmrKUEkbtmNAkN6vud3uSLdXmtSs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7Gaz4GeCUkI16hb05XiCcuoTylTm81v/bYCSsuLw42z0F3pm7
 IEOmlDdHJMn2kPewC9vt4kTAo9DryabKDgK+eFu2Juia6p9hWTNg68fBMM+lOMU=
X-Google-Smtp-Source: AGHT+IGmfJQiqFnskozkyiv1u+H0iCxSJxbuYG7T86D9lJZ/0H/Emv91fSHJrTkDQ44Tzwckf1iStA==
X-Received: by 2002:a05:600c:1da5:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-43158707646mr22222235e9.4.1729176288132; 
 Thu, 17 Oct 2024 07:44:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c37fbesm28923195e9.8.2024.10.17.07.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:44:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 17 Oct 2024 16:44:44 +0200
Subject: [PATCH v2 3/3] image: android: handle ramdisk default address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-topic-fastboot-fixes-mkbootimg-v2-3-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+7r25kqF87iWFDDQSqezyyYMHwj1QP4sW1JXrq28SWg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnESLcKDLmeRw9+qeBWcTTMvlahUGzDXDNhJFU9aqW
 9uXdXC6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxEi3AAKCRB33NvayMhJ0d6kD/
 9doRDusLvheNonie+55bDa7AOcFj1pYkcrBAHRpp3a9U0+j3rJRLkQKni/44+W6f8F3sa/O1RdD56m
 2umE8hbqC3mhGZTZMlyoejO+XaS+2bCZCUhuvK8w/51pTVEwHHxmkDlB5GCG7lNm14Ui8GSVSV+0j3
 ySEAnO1t8zqGULP7e81kJoeYJovGQI4jQTMckecezgeP6QnWAhoPmzOiFneZWPamACcpi8xakjI3Bi
 NCUdUR/qcefsms89jkkHDRA7kP3pJFn9FF1Q+ynVYHPrxP5bnK6RVKLvc7sSIC7QS6VxtnLQJ9Ese9
 w79gAjXtw7u066/8iMkhFdpgi4qaweWEPF3VHRxYDDKaFuJz+Jt3FECVIC9GVv1o2BAymbsBp2Mccl
 OyxRDJP12lJ2pfKKFaYS3PZgSP/EyS9nWGqJyqmqWN/N3FLMLZoRO44nKFNeM5EdpD2fovlkoHsjfe
 b/ApFYq6jAyo12LmpLcpOtW2G1jczGalF0ECRQsjQKJlpOnNhY6viRmRPaq3oX5Tj1DWO1z35RjHn6
 FyllUzmRL1QQ9D/5HepkZgQo1hgOJAiy9oggT6ORYj4zrxs+zoYrEq/hVlm8sbmbyM7PGrWQLTIpaS
 OvORRtKpk4e3LRAc46OMMm/jKls4zoVJBwG0uR1JPo/A4/ZY7gb0m/3myAfw==
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
whatever value is set in the header, which won't be mapped to the actual
RAM on most platforms, resulting in the kernel obviously not booting.

All the targets in U-Boot right now will download the android boot image
to CONFIG_SYS_LOAD_ADDR, which means that it will already have been
downloaded to some location that is suitable to use the ramdisk in-place
for header version 0 to 2. For header version 3 and later, the ramdisk
can't be used in-place to use ramdisk_addr_r in this case.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 boot/image-android.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 3adcc69a392f74ae64f3fbcf1b85204f60ac9aff..cd01278f211d63262f2bdad7aa1176e2c1bbfedd 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -14,6 +14,7 @@
 #include <linux/libfdt.h>
 
 #define ANDROID_IMAGE_DEFAULT_KERNEL_ADDR	0x10008000
+#define ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR	0x11000000
 
 static char andr_tmp_str[ANDR_BOOT_ARGS_SIZE + 1];
 
@@ -405,9 +406,25 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 
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
+		*rd_data = ramdisk_ptr;
 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
 		       img_data.vendor_ramdisk_size);
 		ramdisk_ptr += img_data.vendor_ramdisk_size;
@@ -420,15 +437,20 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			       img_data.bootconfig_size);
 		}
 	} else {
-		ramdisk_ptr = img_data.ramdisk_addr;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
-		       img_data.ramdisk_size);
+		/* Ramdisk can be used in-place, use current ptr */
+		if (img_data.ramdisk_addr == 0 ||
+		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+			*rd_data = img_data.ramdisk_ptr;
+		} else {
+			ramdisk_ptr = img_data.ramdisk_addr;
+			*rd_data = ramdisk_ptr;
+			memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
+			       img_data.ramdisk_size);
+		}
 	}
 
 	printf("RAM disk load addr 0x%08lx size %u KiB\n",
-	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
-
-	*rd_data = img_data.ramdisk_addr;
+	       *rd_data, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
 
 	*rd_len = img_data.ramdisk_size;
 	return 0;

-- 
2.34.1

