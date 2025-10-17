Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DB6CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7A6838EC;
	Fri, 17 Oct 2025 15:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xpNjrGwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9181983804; Fri, 17 Oct 2025 15:19:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F3F838D5
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so10705835e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707166; x=1761311966;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wIicN0iMvS1cCjVG6/Wt/oabBhQm0NfQmCwQuG4IV9s=;
 b=xpNjrGwtk4PR/sIT9uQNjtRRHZgK2ZDKTTBPb94mtXtX24/8aGgVqxrNSbZoU0QMin
 inZugWS6EE6/PJlRH5AamNKm7wkvXnF0seBXFxgSIRvc0d6MDL5D6qLMirCDvlHQWvkU
 8yqdo7nG1T3ZiwCgOsX8PK/lSPJgnYCI9l6EI1hKIQz3M5UkNrfvdqECJR0t2di6pGaw
 J0xjbQ5AzhjbcQeODFynROYflvCgRYci0XakwlkwHNX1ZXf4WqCfs+K/0+CHFIi355iy
 M2oufh8nkYxBnUR1czSAq2Z+2/gcF2i7FJXZ+RGrecJOPOdZb7nAxoMSlHsYKvAEYung
 Votg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707166; x=1761311966;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIicN0iMvS1cCjVG6/Wt/oabBhQm0NfQmCwQuG4IV9s=;
 b=DMHr2PiBE/X6FbCxoqd01J5ko8L8653l5PpwrbPdoyiqgzXL+zMiGJjVUCr0gvnWao
 /M+pN/ddc9hqRf5Ykr7aPulkcBamDEKgtYt6GAnDQdl9Qva/+CO2NDbXShK8m+7n45Ge
 y/ytc72Hx1Fcwl0uevcffM3/KlgXc8OASHkgMPqYac1WsAJDt3qHd/Tor3+Ur9dEhBJV
 aqaBxjKQ+dezQ8RFGQTlI9WXiZ1w4l8Iwd2xfvIyZOKVjFDcUKVViewKZ6bOv3yYxM1Q
 ICadloxEmNJDKwN7kb3oJCEC60UDEQ1eyyQhHotKdMahVAA4pRjaHnskzixCwKoyew3v
 FMVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHEk7CokotpEMbI0PViR4mjGNQqchvQlPEaK++S6ZnEDwhr9tDaz9kyEXRCMIkhc45PMw8O4s=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr8r5n/AUFN5w+2hEJvjVgKESxv2iiU0D4udiWjXpMmQE4HkV2
 eqzF6WFB0JFE0wacmk/PL1X9lM9YvKXvh1s+WNTC54J8fTAiPh08pOz6hpyFKIVHMA4=
X-Gm-Gg: ASbGncsZJP2fcAU7eR7xEgsBWkBXSwZnqT017ajAerHNJ9j9MK5y1PeWYz/ytXUZQUk
 oB1+dGhn1GyK/4NxSS2UPCo9XV9P9T0ZNInijyDV21JRnQuIp+5Y1gkfVyp5BqLHUMAYxtdpOYD
 MsUhGzNkO8vAIPca+2FmeUV75rFvlR86lIeKNp5jKSTDrqYT6WlfilUiYuWcNDw5J9D3LRjLA3q
 JL+fxNEKz62v9Agz9Ic+ZB7Iu94/XCudw8ayvc9GSQHeMB/cRtJsaZ7lUgGuL654oGoEAWYOYyH
 l59LGZl5Ah0Ucc0OuxvCwB93D/BwRwqT1/q43Sr7hVzTW3dQgnJ54TQttiFW27AmJrDYi6Xr63T
 FImSe8oSvbbpfbdpZPhmNDE4ZhOVqndOtEzIiJDuWhD/e6Hk/ixAOAjx+/Rw8I1sfxpXgINPb9b
 6cSBxpkAknIvXJ8w==
X-Google-Smtp-Source: AGHT+IFafQKp4Kf/bvVAzliqMZZk5STDprbApitHQfNwTW6PXR/2tUrodNcox0nmu750JJK6Xr2NKQ==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr27296975e9.30.1760707165912; 
 Fri, 17 Oct 2025 06:19:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:25 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 15:19:20 +0200
Subject: [PATCH v2 4/5] cmd: abootimg: Add 'get ramdisk' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-bootconfig-v2-4-8c7c2f2e5474@baylibre.com>
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

Add support for retrieving ramdisk address and size from Android boot
images. This command allows users to extract the ramdisk information
for boot image v3+ which combines vendor ramdisk, boot ramdisk and
bootconfig sections.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 cmd/abootimg.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 6fb52153786..2a8e2c20941 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -230,6 +230,33 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int abootimg_get_ramdisk(int argc, char *const argv[])
+{
+	ulong rd_data, rd_len;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	/*
+	 * Call android_image_get_ramdisk with UNMAPPED addresses
+	 * The function will do its own mapping internally as needed
+	 */
+	if (android_image_get_ramdisk((void *)abootimg_addr(),
+				      (void *)get_avendor_bootimg_addr(),
+				      &rd_data, &rd_len))
+		return CMD_RET_FAILURE;
+
+	if (argc == 0) {
+		printf("%lx\n", rd_data);
+	} else {
+		env_set_hex(argv[0], rd_data);
+		if (argc == 2)
+			env_set_hex(argv[1], rd_len);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
@@ -249,6 +276,8 @@ static int do_abootimg_get(struct cmd_tbl *cmdtp, int flag, int argc,
 		return abootimg_get_dtb_load_addr(argc, argv);
 	else if (!strcmp(param, "dtb"))
 		return abootimg_get_dtb(argc, argv);
+	else if (!strcmp(param, "ramdisk"))
+		return abootimg_get_ramdisk(argc, argv);
 
 	return CMD_RET_USAGE;
 }
@@ -315,5 +344,9 @@ U_BOOT_CMD(
 	"    - get address and size (hex) of DT blob in the image by index\n"
 	"      <num>: index number of desired DT blob in DTB area\n"
 	"      [addr_var]: variable name to contain DT blob address\n"
-	"      [size_var]: variable name to contain DT blob size"
+	"      [size_var]: variable name to contain DT blob size\n"
+	"abootimg get ramdisk [addr_var [size_var]]\n"
+	"    - get address and size (hex) of ramdisk in the image\n"
+	"      [addr_var]: variable name to contain ramdisk address\n"
+	"      [size_var]: variable name to contain ramdisk size"
 );

-- 
2.34.1

