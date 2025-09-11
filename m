Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E265DCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 16:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B718C833F9;
	Thu, 11 Sep 2025 18:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0pi9hzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459DB833E1; Thu, 11 Sep 2025 15:50:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544A7833C6
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so7043825e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757598629; x=1758203429; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dDBA3p3WQtoxNWvmRcEt7pGIHBqocIGbYVGfy40z5+I=;
 b=F0pi9hzIG0AqBlAY1vKIuuVUSatKK3QfB3O6o3UEzKTBZTt0wrxzlVw+JrRb+km/7p
 bYktmrOQp0FvF9e39ZJW2u/5u7eGi4ZrbZYuPwkxg7JmOGlFyXz/qESnOpLava55ulNs
 grgL8uH110Cj+UzWKd6sbM5fZDCrlEmaQSv5/0J5xeaNuOa++J1QHKlamSkIgrYMLgV3
 f4MX17anwKQghG/zWIlhMD8Zb/900RXL4dpY/mkK5qhERo9/2w7H8QH7rRudeayY3Low
 JE7K7mXCElKM4iPKE4WZxhJGfszpL6tAKlaEc0gZC3bOdZSZqZE3k7GLpBkqA76P4S7N
 hvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757598629; x=1758203429;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dDBA3p3WQtoxNWvmRcEt7pGIHBqocIGbYVGfy40z5+I=;
 b=PLqnSYFWbyWbv2rbxMopqkFKfZoCVAqLo1VBC92o10I3mOAID59RIFOqO18NelOJj6
 sadioExk1mjo0Wsjj0+LF5Jxug5MkzQBrjEwE4BEGGlYy4Dj/qfB6efgM24YvDpwYsBQ
 0NuaAJsV65W+oeiUvoTOzZvR5yqBSCy/nND84mE95iNGaiT1Vt18WTwsgdhSAvOHPgfm
 mCGPRnuhLqJ7jjCPtr6nOPC6Q3nBwb5ToSK+UHD1mA1mP61dLbRLcwnjjEeofslyqBQA
 3U+bAVFD/lA1e6oCepUyKKCwBMC8A19U6UHDizMobHUbkLImU0mTH7iAcPF3ibsk758X
 RHbQ==
X-Gm-Message-State: AOJu0YyuuemKIBns9hQ+CsxZSvBq4XBxSdaobkDTNAVKwKnzl92BcM+r
 HvOAZk+eKs+L5wI8gMzGqCJ9BrFl6UNRNQ21J4TqqUeU9cFrJBISCwwj
X-Gm-Gg: ASbGncupZ5qQjD4n7TjWF0A+BbndcxhTGoboA1CCrj/BXq5JcyGcqWeE93netgxc6v1
 ccz2v/j/rFCxx/8LeD0iCi4pI746/ImJPabpg46dySCtCapYrsaag/khlA3n63i3vdXmTl6V8Uc
 THDNw4YE/KxOcN2m2sKMoErqXh5ld+fUjYjLOCc3TodK3NALON5l38d8z+OuvwlOyCrWBP2vuxi
 axEWVCjp6ZA3J6TYK0zmgaw3YJJ9ipYDP9m7IjqDVRS3t36tUkExTGQJ4trd4CP9RE/O7KFmmAE
 ip9dEf03Yv+clKbuwYaEHnyhStMXm2eVto8+XxVMOpGpQkNkGkgKL1ZbPHtEHZs+2wYxG2neHMU
 VT7zvyvwXKtG3tXZe2FK3zdxDk7ZKkmVB//Zvx+sqLkQsBW8VmNreACeW2WaP0UtbsVHNYJ5mNs
 As3nKERbkHWx7E8sxPaFYm
X-Google-Smtp-Source: AGHT+IGA+Y2sIKd1IIhczzyk4FPPNZ0yxAKIjR2JL+hTwArljBsCCjCcdPU95ne1MMaurFWgHnLzlg==
X-Received: by 2002:a05:600c:458d:b0:45d:d50e:20be with SMTP id
 5b1f17b1804b1-45ddded8157mr170016215e9.26.1757598628446; 
 Thu, 11 Sep 2025 06:50:28 -0700 (PDT)
Received: from [127.0.0.1] (lfbn-tou-1-1277-64.w90-76.abo.wanadoo.fr.
 [90.76.96.64]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607cd4cdsm2540750f8f.37.2025.09.11.06.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 06:50:27 -0700 (PDT)
From: Guillaume Ranquet <ranquet.guillaume@gmail.com>
Date: Thu, 11 Sep 2025 15:50:26 +0200
Subject: [PATCH] android: boot: fix wrong end of header in v3/v4 parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-android_header_fix-v1-1-af036221d3f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKHTwmgC/x2MWwqAIBAArxL7neCDIrtKRGhuuT8aK0Qg3T3pc
 wZmKhRkwgJzV4HxpkI5NVB9B3t06URBoTFoqQdplRIuBc4UtoguIG8HPWKyXk5m90biCC28GJv
 +p8v6vh+KJs7IZAAAAA==
X-Change-ID: 20250911-android_header_fix-89b083cb30e6
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Safae Ouajih <souajih@baylibre.com>
Cc: u-boot@lists.denx.de, Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 11 Sep 2025 18:10:40 +0200
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

The android boot header is page aligned but the current code made the
assumption that the header was always smaller than the current header
format.

When the page_size is defined as 2048, as this is the case with the
cuttlefish target, the current code sets the end of the header in the
middle of it as the v3 and v4 headers are respectively 2112 and 2128
bytes long.

Fix that by aligning to page_size

Fixes: 1115027d2f75 ("android: boot: update android_image_get_data to support v3, v4")
Signed-off-by: Guillaume Ranquet <ranquet.guillaume@gmail.com>
---
 boot/image-android.c    | 7 ++++++-
 include/android_image.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 1cd2060bb3fdc85ff5f1dd81111ddc7663bf3b57..e46dee0d9b36a9a81dc2dc2999bf20be6a36846d 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -107,7 +107,12 @@ static void android_vendor_boot_image_v3_v4_parse_hdr(const struct andr_vnd_boot
 	data->dtb_load_addr = hdr->dtb_addr;
 	data->bootconfig_size = hdr->bootconfig_size;
 	end = (ulong)hdr;
-	end += hdr->page_size;
+
+	if (hdr->header_version > 3)
+		end += ALIGN(ANDR_VENDOR_BOOT_V4_SIZE, hdr->page_size);
+	else
+		end += ALIGN(ANDR_VENDOR_BOOT_V3_SIZE, hdr->page_size);
+
 	if (hdr->vendor_ramdisk_size) {
 		data->vendor_ramdisk_ptr = end;
 		data->vendor_ramdisk_size = hdr->vendor_ramdisk_size;
diff --git a/include/android_image.h b/include/android_image.h
index 96820709b42830c7ce4cb753687da373936253a7..a2d80499ba313589484dea17185703ac3866aa4d 100644
--- a/include/android_image.h
+++ b/include/android_image.h
@@ -21,6 +21,8 @@
 #define ANDR_BOOT_ARGS_SIZE 512
 #define ANDR_BOOT_EXTRA_ARGS_SIZE 1024
 #define VENDOR_BOOT_MAGIC "VNDRBOOT"
+#define ANDR_VENDOR_BOOT_V3_SIZE 2112 /* sz(andr_vnd_boot_img_hdr) - sz(vendor_ramdisk_table*) */
+#define ANDR_VENDOR_BOOT_V4_SIZE 2128 /* sz(andr_vnd_boot_img_hdr) */
 #define ANDR_VENDOR_BOOT_MAGIC_SIZE 8
 #define ANDR_VENDOR_BOOT_ARGS_SIZE 2048
 #define ANDR_VENDOR_BOOT_NAME_SIZE 16

---
base-commit: c85b8071e7d3fd333f8a2fdd28083cb5ec3a0645
change-id: 20250911-android_header_fix-89b083cb30e6

Best regards,
-- 
Guillaume Ranquet <ranquet.guillaume@gmail.com>

