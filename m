Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADE8D374A3
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18DF89023;
	Thu, 17 Oct 2024 16:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fONKu6lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDDA889EB; Thu, 17 Oct 2024 16:44:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDB188FF6
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314311959aso9442085e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729176287; x=1729781087; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gQYY5frZBxHo84ChtJ9RZ/UNM3wDdkWaFRjHDGXXJ8Y=;
 b=fONKu6lw7c73KKVSVNg8YGscuvuhw2yPXEvWwImGLIGKJXI0JIk+dNA36WrbwTq6m1
 9zpVm+xYpSigsVZnZCBkhAzlNypVxvEIus7JKFuxriQPdmq26p4Ky82vXQcDFUF4yaLg
 ipCs9h2fT4khNteHwYBLZEy6XIY5J1GCm2IPnKB65yxafExPvFK0Y4Ofs/oQiwqs8mzV
 97/1fQ8fqE2V9tIk+kYwVRZ4VWmKFmqQLF50zdJiVLGtOSAbb1d727qlOQNXfXwmLTAg
 mgRWdvV3pIUeOY5g49efkXeuE76MOKUuZy3tPKAp+lHFS7u/gPoWCZzPbzfsJ/90wjRQ
 dRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176287; x=1729781087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQYY5frZBxHo84ChtJ9RZ/UNM3wDdkWaFRjHDGXXJ8Y=;
 b=SHJWLW21RssnTyLW0Oqst6haTsQJ6CkbHkiqgFSlzZddEMy9xioK/eCobNvUdx4U6K
 nXFsn2+S7Ss1fW2loyIXj9tN2XO4G8qIKRaycQB/ux4Qn3IqglVDEw1bbjcr+VYDS3U0
 SgsHLPGQ9OuXG6kdU/hIu9uynfE87j0Dcy+PYRsivFkv80y/rd3VlYK4l2iOky7RC4z+
 Y/IDDdbfSqZedO05WpVpRzMPljFzLJi91Vv/DcVrSiEvF8a+GlUoVyv7frN88KnYcaN5
 l83HG94PNaZM5PSeqfsPJ0utrcXJVBWny1fW2ojjOeyFYOwm8H+zuM4AlW9xvqqtL0Vm
 pHzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7JmnZnrc+TO4IgJXopISi5Df+d0ne9ZjJkMfxCjmV5NQ7QqQgsOwzLQ/33xe8DzeQw0+BJzI=@lists.denx.de
X-Gm-Message-State: AOJu0YxYiKjnbpSwsgsnmS+p4bIo/8zX7t0bSjPxhJEF5qvr7Ptawmiq
 TFzVV6I1nj5DxmZY02brerpzPeJxdkh7p/Sd49RQXXPA3/lxqcGvdEXsCXbQ0OMPFDv0ERXXTRR
 EymI=
X-Google-Smtp-Source: AGHT+IFIDc2mKwCEmBQ88icj5NJHAi88+0N/2CM/jR8OK3Gd/eco6d49mLWvjsmc9f+yW7nBXJCZXA==
X-Received: by 2002:a05:600c:3d89:b0:42c:b2fa:1c15 with SMTP id
 5b1f17b1804b1-431255e2cafmr152976455e9.15.1729176286530; 
 Thu, 17 Oct 2024 07:44:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c37fbesm28923195e9.8.2024.10.17.07.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:44:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 17 Oct 2024 16:44:42 +0200
Subject: [PATCH v2 1/3] image: android: use ulong for kernel address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-topic-fastboot-fixes-mkbootimg-v2-1-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=X7ZHztPg6fZqYVFEgR25qte+6Ywvk/GfINxsOSd4KGY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnESLbOTMpjLJAf9RS2jDcXNLBhfF9kwW1uaTnt0wL
 MKs+S5qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxEi2wAKCRB33NvayMhJ0ZwoD/
 95Dmp7+PcoeNakGSpKzZlElzdlMslUiJVgZmQE6sJFscEa4ADXYETpMBChYUuykPAR1VS08UfKdkIK
 MKZBMwoIjNhmLmhDbYgUTzG0JORFcqLpj4568qBrd92F60nRPiG2Va79Zdch0UhukLs3gQ3j8/qgvh
 CT8kvhzFH+TU982o7GY55vPPfdUcwlrB7ACvmEzTyidagrYtFqiH+zg+tXigsNk/SgW4ncjsLl2Ccd
 XDxtAhHRZZB/XhnVFYozxyNewbtlbr5EHq2cqQdVXugyfQ9/GAXl2wNRcHnE+af2fKduDnmhVz2kwY
 gYz5lGoYJk7tfaWwYTQC4/v00UNbFTO6vq+pdGR2vB5NolqxsHuG22qZfjXi+Ie/qSmPzAeYw+p96R
 uHdd3vC+p0kOzGj9bk+pX7yyVXjqiPg6ubnj/DnKyAAgzUs/1KXZ5cMqRvv90DHMCXYA0M7D1aH6ex
 09RvrQVanKa1c4XpolD2FTn4yUbjPAWZMyrhwEGGW3AifgbfPuNczsX/BjMuzmYEbz9SeeXMUpQmij
 VVa1nkRDif7CjGv0rr8ciLlapNXO5xYRXBVtzHi5mqKYR89G1BRbdjP5vtOViyiKrpAQbgVQ4cjpKt
 JF675xaxuM5CTfvNNHwvGt7bK5VzyXCJ+CsZENvxltqkHlgGJaPXEEQt7x6w==
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
index e74dd498a305566e42aa235b45c22995e21ca64b..bb5f4f84487d40e0cf24dc3b57042993967e66d5 100644
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
index d503c980b233bf31cd12a246ff1570544597a1c7..96820709b42830c7ce4cb753687da373936253a7 100644
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

