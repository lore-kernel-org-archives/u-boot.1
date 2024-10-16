Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C6AD2A52C
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227E488D7E;
	Wed, 16 Oct 2024 17:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhkZQGh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3736988C05; Wed, 16 Oct 2024 17:47:02 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C1188D14
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so3981270f8f.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729093620; x=1729698420; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PMW3yg5/p4yI0H1hypV4NS4mBNeYrwpqtQgL+0Ly950=;
 b=PhkZQGh5F0SMy3WKHADdS9BxkgPhhR48ulzejIVRvMUxM1NqlEP/BIZvS9vqVhdT1W
 wG2ARljgpifOulm4yejySdUdWJ96MifiioIAaE8Q+RFVqpvxSMrhMRw6QTXIPBAOP00Y
 YON2+PJ8IP60ouMU1fJ8qsDwtCuG6LAX0HsgSLxHfY2MrkVPkwmspdX0mj5I71UMENM0
 2l7tsySh7FxRGYDUyf/XKMccB6xNlw7LuA11E/6LV8PBmg2LBESm4DRGWC98FXq+2/nr
 qzcygYPxqUsvHdBO1PiiO5n5OeoL+vvDJrSHOstIARTDZ/YP4uDnSd+aIW8cK5wROSMc
 Mbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093620; x=1729698420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMW3yg5/p4yI0H1hypV4NS4mBNeYrwpqtQgL+0Ly950=;
 b=qV38rBwU057L/Z+4mmZb/402Oj6UN4PsH5BWYob69L2vimQxdn2y3ytvGZMHUkCZJP
 kEG7Tgc2RVOkiWEzM5Fzn3iNsp5aKFpiDm/fpn3dm3MtBoQXprw/hGhWBa9OWty3GEYa
 G4ZnY9GqbadGdDGxXOGn/aa3Met/93ejc6cMELy+uOEkjUGfigCzM9ubFoYhNFoQ3va/
 Uq5ZLZpHFc983y9xrc14ZQmx030+82jAjSR/dx1qOUiaJsTuEJ7uMNe0JtAdIOxEK8LH
 wGs0fziLwM56o82mbJa2G5nOkUMT71Mbl7rSVl5qvF7JzkeZcgH1+Mn6BznuQ5Gom9E4
 8QKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEL1dykp9Y9cscIXp0AnCkKqd8FK2PZMoGEVbVnMVTZbKF07QfPrYNmkluaG1UnUZe2nWVm0=@lists.denx.de
X-Gm-Message-State: AOJu0YyzHmsHSss6s/8HYWAAJ5yCwoXP2wiZhJn7Ts5Xo6Zs0iTsq+Lh
 D4oJV3vWbHSJRzWogfWntYaGhQboyi8zKOEei3M0Up3htvyxQl1VTmQ4BNg6Zoo=
X-Google-Smtp-Source: AGHT+IHyBaRJymQ+jD8qYvaBMuuOiskVvT5ixE8OMMGCdHSRZ3nICcR46gExWfBfEcfKoISWn5GJKg==
X-Received: by 2002:a5d:6e43:0:b0:37d:4d80:34ae with SMTP id
 ffacd0b85a97d-37d5519873emr13218544f8f.4.1729093619684; 
 Wed, 16 Oct 2024 08:46:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314a6fbb77sm37767315e9.14.2024.10.16.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:46:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 17:46:48 +0200
Subject: [PATCH 1/3] image: android: use ulong for kernel address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-fastboot-fixes-mkbootimg-v1-1-94fd9340722b@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
In-Reply-To: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MwJtIiuhsW2BMluGpsaSc56K536Ikm+rTmqQvN50x28=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD9/wQTxZlfZj5BQHNIKBEgFYSL7K6Kr4NNGZAu9j
 /J8/y9iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw/f8AAKCRB33NvayMhJ0Q+WEA
 C7g4KTERIHDqa3Fhu6ZIk0ywKJJD0/igBeZK0y7HsblovM8cYYokkBBVLObfj06MFfxcQYrtzeXuoZ
 gdDG9opw1yFhPjhWUWkuzjUNHwg3jfPkdbNdE+YSqZOi/bfKughB2n+yf3N9zoUpxFk6Xau2WK1Dpg
 gY03+DFfdcZteyBqMKLDgWxGMmQGwDxAMA18C0kzNWU1Ed39fWjwTVB1a7EgetBgdpZkO5nk1e/MTA
 +dMmEMFHboI3VMH24Qr1b3kyDKUfS6r1Ki/2aJnAJRCPELVNOA01OfORFLF1iGUhbmG00tWWUWpa8o
 rYt2kHXk1TK8GlNmwr8MS+0W/A9dtIB8o5UA4ALH2ZFHsXKCwmifKftv6fqM9BP9QQYPYTBd+biPr1
 pcFLTkNgEcJ7VvAwIa0sPDQlLuku72IsTJuvjuNqENB7+VEZSlcS/h0lQLkVNOZ6w2ySiPDAk1vbzl
 oKYFdktfV85HbQxOiDNGx0Pse58EmUhx8W3Alc6PqxcTSh2FnpnrkoWpjDAdF5X1SOeL5Po/0Gd9uf
 KDohSi8cyPd6CVq41kbsFFWhjBnjtKaQjIUj2aLOAz814oxEy+XNeXC+CUuZmgHoa4SkZs8PCG1uJ6
 C3SNaP+UDTsIkBag+qkFYMBA6h+f5qgw8wWUCE04W4WQqgetFio5oHIf0l5w==
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

When booting with platforms having > 4GiB of memory,
the kernel physical address can be more than 32bits.

Use ulong like all the other addresses, and fix the
print to show the > 32bits address numbers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 boot/image-android.c    | 4 ++--
 include/android_image.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index e74dd498a30..bb5f4f84487 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -256,7 +256,7 @@ int android_image_get_kernel(const void *hdr,
 			     ulong *os_data, ulong *os_len)
 {
 	struct andr_image_data img_data = {0};
-	u32 kernel_addr;
+	ulong kernel_addr;
 	const struct legacy_img_hdr *ihdr;
 
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
@@ -275,7 +275,7 @@ int android_image_get_kernel(const void *hdr,
 	if (strlen(andr_tmp_str))
 		printf("Android's image name: %s\n", andr_tmp_str);
 
-	printf("Kernel load addr 0x%08x size %u KiB\n",
+	printf("Kernel load addr 0x%08lx size %u KiB\n",
 	       kernel_addr, DIV_ROUND_UP(img_data.kernel_size, 1024));
 
 	int len = 0;
diff --git a/include/android_image.h b/include/android_image.h
index d503c980b23..96820709b42 100644
--- a/include/android_image.h
+++ b/include/android_image.h
@@ -348,7 +348,7 @@ struct andr_image_data {
 	ulong bootconfig_addr;  /* bootconfig image address */
 	ulong bootconfig_size;  /* bootconfig image size */
 
-	u32 kernel_addr;  /* physical load addr */
+	ulong kernel_addr;  /* physical load addr */
 	ulong ramdisk_addr;  /* physical load addr */
 	ulong ramdisk_ptr;  /* ramdisk address */
 	ulong dtb_load_addr;  /* physical load address for DTB image */

-- 
2.34.1

