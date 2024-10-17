Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAADD374BA
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6266C89074;
	Thu, 17 Oct 2024 18:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K4yTqgEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B7789048; Thu, 17 Oct 2024 18:10:50 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC308904A
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4ba20075so837764f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181445; x=1729786245;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ypEy+gyVZPJdWyy0rUEA8YAJ2c9h6fNy1ZHn+v+cvco=;
 b=K4yTqgEagO4oh/jENwtqVh34WK+NCCoo+WCObw+6kJNx5QJnrsdRWi80dPhuf4FxyB
 MQZrE/JcRt9Ly2DJ/alohxossgZ+1qXMJaNOVV9pxa9/M9xCz713Jy2/qcX3P2OaRs3N
 UrvCCC+PJ+0Qnz6LdizhDQs4SYJKWAEkAZ1N55I/SdxYqnowXtb8blOtH0v2H7low8wp
 N/LLi2hq3EINXQEb9NddGpPueHU4cuDf2qUQI5/anOvl5XUuF995wKw1A5o+HRkIQK9T
 nAtNgzMoshMIhVKa964yG3wWcYHKXtyzRI6vfDzQHb2kPr5PH02jXH9KSh6hzvF8iXug
 lgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181445; x=1729786245;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypEy+gyVZPJdWyy0rUEA8YAJ2c9h6fNy1ZHn+v+cvco=;
 b=GYHPrbPO06gWcCiBteMxK9qOzR1p5a0SOt22RNQmNcLfjZZ7q2xQKDmWzeIpVylCMJ
 CeC3k9dawozvM1DJ7HX/V3rPNGgiB6qpdGfTPGOKlv986yQGEVnWYLH1AUuNAoV/79q9
 VcLzXYJmfVameQIijMFZkhKIVu2ZuKD/S3reMlntbKso0mYJSA643gV5buIvGl+HJyO+
 9SykgB6q9EAHBdVzz3DYeG7uonwp6yA3FHd+TfkNL/q1F/cjEMzKiTpLAUlHmDnFZvJA
 b/36wvswYRA5hfT2Ffq+qTA9ydlstLzEd5BkyLurfYYGQGV4cTTZNbtRBPit4RnHf0pS
 th8A==
X-Gm-Message-State: AOJu0YzOSwCpUasYK4qo3Wmn8gq3e3C5P/8k5rtWHa2b4ewcqjHJwdYy
 nMupCjVvh8jbWeVXMSy6jGBGuEjexOxTXPrgKemQppbMNTTDmgTLcBa8whfOuFHilrJBcFcgEzD
 2
X-Google-Smtp-Source: AGHT+IGdLQEVeyz6TCaxDZbNYOA4Gm0+koijcA15cq3eyxPttmNlNE7tBONKxNO+Bi4YbItriTsx+A==
X-Received: by 2002:adf:fe86:0:b0:37d:46e3:4e88 with SMTP id
 ffacd0b85a97d-37d55198857mr14799341f8f.9.1729181445378; 
 Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:25 +0200
Subject: [PATCH 1/6] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
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

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version if version is less than 3.

1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1

