Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DBD374A3
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E01089010;
	Thu, 17 Oct 2024 16:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kN6VwXXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 180188902E; Thu, 17 Oct 2024 16:44:54 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0FA8900B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso7012525e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176287; x=1729781087; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E55KgvjEq6ZvKO5NADnCK5xx/g2VloRvKzw2CbvnhlU=;
 b=kN6VwXXyb0tIwSF5r6eNkhJLe1xtEKpFcShUtNhaBtuLbihg0RsHRdLGvS8l9HxfsT
 bvcd38rW+eL8AZrdprUAASP3p0+EXLpi+erI1WLyQlqtF2D0pMKXl3nEQ4VcFPZX1PTc
 JJy9EITeDD9r0hhMONoT6PWc8sVf6Au25/njto+p9RHKtR2Kzb1OOIsxVb5l2+u5rY4j
 Vb04Hftup8ogppHkTqSWeG+TFuXtuGiUAstD0o1bnosqjt0tF9n5Ma9yPQ8PbIo52EWJ
 YLL5K8qyDHHIUXAMFAa6MB/b+UG9Am20DMy4iDdD9FxNo6ulBH8WimJpi7v1AiUuaMhM
 Mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176287; x=1729781087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E55KgvjEq6ZvKO5NADnCK5xx/g2VloRvKzw2CbvnhlU=;
 b=n+7h/SrhdrXhiqDIyxFDw4NmmV7/4kOU71o0KkvRCdrenFy8wa+B7RpJIpBi9f3aK0
 qGo5K6D2JFlrXIJRRJFoB3Gdg7cndmoe2C928zu2EJW0Xy6AQVZnK2snSB9FqzHjzyVe
 vNosqqoOesvZ1nAMRDfIJV0kIhOFJ6mQ2a2tufx8pDXn/eW05acwzFLhdm0VxBVYJGlz
 f4H5+RUwu9WL4wQxdHEWewrJwxMEKlaWL1Tpw3xoEMDhPQ1rK4qCsW+frlo8wdYEi/ec
 /mep0RVFWKc9qjqq8hVa5M8ENDjC2w8r4T+aBNS+TxmG1kpweYdPPy81aiftKWi/3nAJ
 HOKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqKRD+nnI7vcXdUAu7jS1qUXBxRfcDwSoMV+2ic70DjM0Lu2NPzYm9kbhaJqwV64hZV2kRHaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwKQpfVXjSxpPLk4XhjgdG9xHSreePMQp2oII4AsF0gNeyFQ0fX
 rb4lgGpYPvKwgDciSCVw66t2USsQdQK0cwsJcM1a4wM6KxJCgdcCyz1qyNamzBQ=
X-Google-Smtp-Source: AGHT+IGVUrg50ZD26BgxpWXW7UeFP7WEfMirNK8Dbk6z5/5B7rwJgS0qtnHmRZ8zEFBV8i8eQrR0ew==
X-Received: by 2002:a05:600c:1c9c:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-431255dc851mr155656735e9.11.1729176287354; 
 Thu, 17 Oct 2024 07:44:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c37fbesm28923195e9.8.2024.10.17.07.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:44:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 17 Oct 2024 16:44:43 +0200
Subject: [PATCH v2 2/3] image: android: do not boot XIP when kernel is
 compressed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-topic-fastboot-fixes-mkbootimg-v2-2-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aF8xM9sCZGgIvtKbwtbcWSVIp3oIbPcNIUcWWyzrU40=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnESLcv50SOriFtw1GWstbBob806gcaPUdwBk2hEmf
 RRFyGkiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxEi3AAKCRB33NvayMhJ0aidEA
 C/uXTXQPGggHP9vxN0jd5BaE5Y+WNp3tPY94FcPlxIoUpjrdFY3Qe2AI3vNFZCc0qATwHSA4OQbaX/
 z9ylCCiQjNjB3T4sc4EijS0IS2jGddiviHGOVkX35+uxJitiP+ZskVTrEsVvokia/Bfv0J4agyAqBq
 aXuILcXL2o76RDpZv9XdgJTOVgezlbvbyH+y0uiGs1JFzwyN1TgeQgt7UiiAgSFK3I80C2IopVOO4d
 dCNrHynUmqnlvps+U1mY82Ickj0jXZ264crLrC86wdBWWqviqJgjeWvgyXgkkSkquBRyIrEZkBtl7Q
 nAol7aNWMGi/tDZRHbUORwKYUmzn1mUlEPTlwiKn9Q1232oTnVc/ACP0MehzOlcb9NvuRD1Pl6u/XQ
 5kYwY5AJNJix7Yi1aZQQj8QMD2FtFiY3Llz5CS4jRRDPSOs4YM7tlGvLlsurCJV2/7JYwqIx4JJdO2
 wuiNlXf0Ex5hmBz8/QIEka3HNnpz6BaZp7sFrXrshG6GSPDxpQxj25vYx1LMHL8z5LIdEnwLSOPho8
 XJK7krOzvYb8C1VEii6xNHxF8EtzRtxBtrVDr4HkQfU3Hxc+83DxqAPTMZEN+9Ld2612GVITzUFC/+
 K5K/dp0z4i249zioysFf2eJafJ7c279NEMNL808Xx+03L4kkF2YrFq3ZXbOA==
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
index bb5f4f84487d40e0cf24dc3b57042993967e66d5..3adcc69a392f74ae64f3fbcf1b85204f60ac9aff 100644
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

