Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC74AD2A52D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EAA88CC5;
	Wed, 16 Oct 2024 17:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bbGa4UvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C01C88D7E; Wed, 16 Oct 2024 17:47:04 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9284188C05
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d47eff9acso4056528f8f.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729093622; x=1729698422; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GmI94IIHjO0NgEyeaiuqYocEyawHuuNMNsUoUYEXbPA=;
 b=bbGa4UvZmk+jcsLPL/c8uF8DG2nS3m9g8TtChslTDXrlf4s4rsWgIDvbVanUCplzkg
 k7+5Y0cHJ385/IlWmJdABZuxBFBzh4gaHE+ifoBFzM7g0zZsh0aBYAGe9ULzCo6e3qnF
 +oAhQL/ld70T2txwe1dfhCghOlQUYvhYknLl9AnKKffDsCg/1yfz04KQdfphHJqyFg/j
 AK8AClVKjheFqci6iouWRSUgPjiG6Lr6X/ibvAvGmTYwBqeJ/c+uOPq8DMWi5pDJXISP
 ydCHgFbKRYBSMTEgJDusESkdp9wrJac/pSy2q+UgtsWADKDU2Ii2OPzK6qMW0KLS+ase
 4iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093622; x=1729698422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmI94IIHjO0NgEyeaiuqYocEyawHuuNMNsUoUYEXbPA=;
 b=JahwRxUqQ0riil87oeCND2ztJ5EGr9fSJSaBfnXbYbk2wYadeSY1HYJfT5pkOR362j
 PzmWtEdQro9M+UsKBhrwyOpIZlVfx+FiX9sU1F9SQyxweeBNvxEjCS63r+Oi+2TGH5FT
 o2ds5Sq8qw0HUIWYjGwgrQ510YHLFXhvkX7qanXLtm/Mth1cqFO57BF1MhQ1N6p6caby
 fwL/GmlbpUdDB+VHS6HZUkytTj0f2v0y0d0Wn41x/Ljv6WWOA+fQajMGPtG7KdWf9AQl
 oC6DhG5RK8lMRpNxkQeBMZsDTxM/hvH2Wz/sexaaA2G/SujRTBEVcI6/7M8XBjd348eg
 JBHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOfTVevtAek4BqkuNY0a1ZKnYyviGOQEEtBAA2ruAapVD24Jk6QmLrNFd4477cjHN5n1Ix7IU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7VMLi48tZNook3h/Y7t35w6LmCnmWGufKCESXlStOKNd9ZNRq
 cxp6dMH8Hp6RKuhCfosyc3LxzM54HlR6RAzrpn/qqnSiM3Q0Pjo343yBydxg7EA=
X-Google-Smtp-Source: AGHT+IFa/mkUXZDYt4ekYSkYIrpzuROORRhHi6LZm6ZaYtcp3aw7xcfEe2O21KAiZ5O4fg0vi0cPRA==
X-Received: by 2002:adf:f70c:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-37d5fe96419mr11955559f8f.5.1729093620521; 
 Wed, 16 Oct 2024 08:47:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314a6fbb77sm37767315e9.14.2024.10.16.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:47:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 17:46:49 +0200
Subject: [PATCH 2/3] boot: image-android: do not boot XIP when kernel is
 compressed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-fastboot-fixes-mkbootimg-v1-2-94fd9340722b@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
In-Reply-To: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=C2asPNVvCkaRMBf1k9LqeJ3IegU/Gwasa5aSQDtR3qc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD9/xdcY2hFgWyE3UISPLsFVa/qOn3aJtFY4j6MyI
 woqkrHCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw/f8QAKCRB33NvayMhJ0QNaD/
 9Q6QGmwPn/1tzXJcyyQwr1NqXSwIICHnRx3AP4aWCxqGVdUK4KV2wLARaQKmlUP8WJp1QtE3yAgv/3
 mHh78cOGDbz73XSTqHeEVt48JtsGPA2M7kWJlzEZ5p5Dj461ib57Mbf0/riwylPvJmRfouLukTwrLO
 X6pXUON3GQA8g+UUdtPDoBNNVgKI3RSLN+yc86iJgjmft0UIovcL/qR5+TwGsuYoQyPA1p/+v9bQTw
 LwSobhUZMXN5K0JU9wM5qkvPpi498s+5o2+ij1P85wzwL8ngXoKqYlRtjVYoElo//s9V59Vk5cjddl
 eWPf7BHG0Y8yPbtKqaI/qeo2Hq9cep5IKTaKYWR6Dmynb9g5VbsIWgugLJDjT7fViJ7csMceVs6aE8
 TCzEmpE927/d/Sg0YWFG4Ctdz0MOjVGiQ5If8raiRgclDbRfXSNCfgnzlJMFxK3d2U2VDEa3hqD1T8
 fsGGUkIHpazBKZP4tC7WcBSHKinqMjTNrrDlEYAzy1UxO7GFRHKkUhaAOQvnE3ruc8D+Sakp0B2AO3
 3DVAESvwmdQzmrnCgjFdavFK3vzYEBCz+ma1LjFtUkd2qqec3feDJ92TiEwCy/B1J9SAAhgvgqFsza
 oSsiZ2IUhM3u70GnZXVeMRQrsYV6RKKOuf5pcbKgrl+Qk7USaTl5duBxd1Gw==
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

When trying to boot an android boot image with a compressed
kernel, if the kernel is used in-place because it was created
with mkbootimg, the space will be too small to properly
uncompress.

Take in account the compressed state, and if compressed
use the kernel_addr_r which should be big enough.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 boot/image-android.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index bb5f4f84487..3adcc69a392 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -208,7 +208,8 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 	return true;
 }
 
-static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
+static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
+					   ulong comp)
 {
 	/*
 	 * All the Android tools that generate a boot.img use this
@@ -221,8 +222,11 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
 	 *
 	 * Otherwise, we will return the actual value set by the user.
 	 */
-	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR)
-		return img_data->kernel_ptr;
+	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR) {
+		if (comp == IH_COMP_NONE)
+			return img_data->kernel_ptr;
+		return env_get_ulong("kernel_addr_r", 16, 0);
+	}
 
 	/*
 	 * abootimg creates images where all load addresses are 0
@@ -258,11 +262,14 @@ int android_image_get_kernel(const void *hdr,
 	struct andr_image_data img_data = {0};
 	ulong kernel_addr;
 	const struct legacy_img_hdr *ihdr;
+	ulong comp;
 
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
 		return -EINVAL;
 
-	kernel_addr = android_image_get_kernel_addr(&img_data);
+	comp = android_image_get_kcomp(hdr, vendor_boot_img);
+
+	kernel_addr = android_image_get_kernel_addr(&img_data, comp);
 	ihdr = (const struct legacy_img_hdr *)img_data.kernel_ptr;
 
 	/*
@@ -359,11 +366,14 @@ ulong android_image_get_kload(const void *hdr,
 			      const void *vendor_boot_img)
 {
 	struct andr_image_data img_data;
+	ulong comp;
 
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
 		return -EINVAL;
 
-	return android_image_get_kernel_addr(&img_data);
+	comp = android_image_get_kcomp(hdr, vendor_boot_img);
+
+	return android_image_get_kernel_addr(&img_data, comp);
 }
 
 ulong android_image_get_kcomp(const void *hdr,

-- 
2.34.1

