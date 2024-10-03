Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC150CF34A3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 12:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2874D88C8F;
	Thu,  3 Oct 2024 14:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKZS0r/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AE788CBD; Thu,  3 Oct 2024 14:42:45 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EC188B89
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 14:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so11792835e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727959362; x=1728564162;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4LPtWXGds18JOEz3tiXNxR2r/aIYBAVjICBfp0WguFw=;
 b=LKZS0r/9HgryVrCCw5Adj7W/iLrVf8wsjX5sbbO+DREoO/tgDznzQOkhpa6JayT348
 scywufKJMUHn03HvxeWeekfVV5gmcw/A98MHI6eJdO8v0m2FoV/DYLG2iQI+9PPE5IOk
 BRC9RenTazIoM3DG7NrpTzAa2E8t+CQq24n/NgvROd+0IYrJyig3fznlYEOduE88jrwf
 pLJO3lQwxLAO2t39PRzfE76A6KMg2xpqo5XyCWc3POu3zzGVINzUl7fHGHYXdlKEvwwW
 enKHorHBN7vHBfzVrnDG4kJ+NC6pJyKMpiRu2LFokCc8sQ2edaPRdmMSPspVLSAw0Lp5
 2h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727959362; x=1728564162;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LPtWXGds18JOEz3tiXNxR2r/aIYBAVjICBfp0WguFw=;
 b=vkX/jBoxIAT7JJK21Oq4M/tvkfT4xM9ctHCVJbvdH5PM6063hn9fpXNaJFFGvu50Xa
 1ABWKQQ1EW8eJcP/yTNRUGwmAyGT+meqvAxK+bQ+y7YxSaaLE+1v4b1DQCYpstmOvGZg
 OsaAgslcqD/BPQbqKvFuMkXipgUHpNvZTsg0BSwRXCXMKsBko+P/1YAaaUNRGoBVB13x
 ScmJ55rgQdvCVUC0C9TYGaOYN5hwxoEXnNaE9jauRA4u9KwpkknUaj415oB5zB6oyPBl
 9EHlmZP1Hib38T1MC+bNqGtCdBRNdck3iA7EM5XfrMlHX0YzPtRqoZZfpZGyrndLxUY/
 Y2cA==
X-Gm-Message-State: AOJu0Yyn0eBFVQFX6agnj8OYbK+MTN2MRwO9fRnm8kIjZdEqG+KEjh3W
 cf6jSHuEVn/T57ndR9VVLVuMX+kqBpfHnuP0smVsAVNLnuqZFzsYx+Y8iqdf9Fw=
X-Google-Smtp-Source: AGHT+IHiahhudqIs1o4LdfOfLTeYBuJ3Y4cnUcR9Lpcf7grXHCfD7pSu839JAI98f4IXU1myisK+2Q==
X-Received: by 2002:a05:600c:3b2a:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-42f777ba2dcmr62247495e9.12.1727959362349; 
 Thu, 03 Oct 2024 05:42:42 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082a6c2fsm1202430f8f.72.2024.10.03.05.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 05:42:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 03 Oct 2024 14:42:39 +0200
Subject: [PATCH] boot: android: Fix ramdisk loading for v2 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-android-fix-boot-v2-v1-1-13e8e44af4b7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD6R/mYC/x2MSQqAMAwAvyI5G+iiIn5FPLQmai6ttFIE8e8Wj
 8Mw80DmJJxhah5IXCRLDBV028B6uLAzClUGo0ynlbLoAqUohJvc6GO8sBh05EajB+tJ9VDLM3H
 V/3Ve3vcDwk84t2UAAAA=
To: Tom Rini <trini@konsulko.com>, Roman Stratiienko <r.stratiienko@gmail.com>
Cc: u-boot@lists.denx.de, Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
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

Before
commit da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+"),
the ramdisk was loaded from img_data.ramdisk_ptr, ignoring offset
provided via mkbootimg.

commit da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+")
rightfully fixes this by switching to use img_data.ramdisk_addr instead.

However, it does not copy the ramdisk content to img_data.ramdisk_addr
in case we use boot image v2.

Because of this, we can no longer boot Android on Khadas vim3 board:

[    3.940361] RAMDISK: Couldn't find valid RAM disk image starting at 0.

Add the missing memcpy() to fix the issue.

Fixes: da3447d09fa0 ("android: Fix ramdisk loading for bootimage v3+")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Note that on default AOSP boot images, there is another bug: the
ramdisk offset is wronly configured:

$ file boot.img
boot.img: Android bootimg, kernel (0x11080000), ramdisk (0x11000000),
page size: 2048

With this, we have a maximum ramdisk size of 0x80000 bytes (512KiB)
which is not enough. The kernel would overlap on the ramdisk address.

This can be fixed by repacking the boot image:
$ unpack_bootimg --boot_img boot.img --out out --format=mkbootimg | \
  tee mkbootimg_args

$ vim mkbootimg_args # change --ramdisk_offset to 0x20000000

$ sh -c "mkbootimg $(cat mkbootimg_args) -o boot_repacked.img"
---
 boot/image-android.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 774565fd1fea..8934491c35f2 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -409,6 +409,10 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
 			       img_data.bootconfig_size);
 		}
+	} else {
+		ramdisk_ptr = img_data.ramdisk_addr;
+		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
+		       img_data.ramdisk_size);
 	}
 
 	printf("RAM disk load addr 0x%08lx size %u KiB\n",

---
base-commit: 9cfe0cab3bf135a505e1e163ca442a4e4064d58e
change-id: 20241003-android-fix-boot-v2-ada82163bd05

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

