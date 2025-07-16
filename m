Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2503C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FEC831E0;
	Wed, 16 Jul 2025 11:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBPjPNO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF63831AC; Wed, 16 Jul 2025 11:58:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356F6831D3
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-454ac069223so4940105e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752659919; x=1753264719; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EQrHPL/PEiZisgVdvYeS+g1xXYyUxlwznf6dFmGY+/k=;
 b=GBPjPNO5OG6Z/i0qj/0lo/Z5fGTiwthZCSe+oTektAH6LlAFHs48Ux+tteJ1af2ksn
 lG/0gj49uRh+bMvm3D5prEE7+lcdqSTTj5k0A1TS6HHfU348xc8/NQg/px+o67SnfseQ
 sXFCZ69Ofy++jkPlK4yTxNv21sja62tKA0dZLWW1DYhvYkQwYaOXd3elpNYULwndUnYB
 4zlrqX+J9vYucPuksZFhWbL11N/ycy0Q8H8JN636PA5TOQ8OrjkcOBZlFYd0zFCYhRoo
 r6714MnVw7Acyc/DLk2QU0kX6+vyVncbMZThEMY748c1NdVB29hmheXe9nrTz2YhZybz
 +JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752659919; x=1753264719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQrHPL/PEiZisgVdvYeS+g1xXYyUxlwznf6dFmGY+/k=;
 b=aKabnyeD74x3EvYISUmp0SPmfecNXejlhslj28Hojvmq4kFfjE8Aw0AXXW19u4Z1ht
 /8S50d0+srdZ/p/+1f3p9Vl8LF73iYzBHPZBYLiucjFWWC76vmfPj+ecks8dJTP4pAz+
 wY80KuWQjAUI494uzr887mRrp5GSzkZE0AsdNRl65zm93PQz3y5cpNhlQWOvNHCqjL2o
 EvhlDDMNJDCtD39AyCOeusNujo/BpUzXE2xnQZG0UvKYMyHwdGufDVDgy3JcdgEdA57y
 9VMl6w3L+zCimRWjjpUyq6bQ+67GqR+Tp+36xKHsC0pB++jbnh/HsFbiYYU8e2AoGs3k
 nv9A==
X-Gm-Message-State: AOJu0Yw8O8L303/hyRUAXiV/5m+wPk3uvVmoTI6gH37pYyCORLYZlZqf
 E81wjgRtRtp6NWdeN4B3kNaH7dTB7tb/ta+mQKlgZZpH45mvhdyBT5fHGLcnKpc9sP4=
X-Gm-Gg: ASbGncvtwJJ6yWVru+mq++vypXG783hFhAZ9XZ26JjZA+tIRhX8GRhCwhKZpDUmzqRL
 LuYeJ3VHGQBTqDdUP0eFAqhQurL1RCFcH35ZeFEZO1I5uf313ABBD5RHK71hREWl3+JTsUiD+WI
 lnmdcHg2mwmlDRnkEmAYjk3wD1L5x499aXS77r16U0mNhtWchrlZjONBQjEdilecAKuuo8Z7ueS
 nyz4owDRiv45Tldjk3lxdW07XJzKFPpzhph4QQc5Mz28GTXhHOUtcZ7p6P5TgPjUDK6jp2sR0oG
 wSLhsG6Y8g5a2FQ03UnuOIDAotozdzem9EVZQFlHsQfVfPW8JpnI2qp/JNv+5Ju4YKYZw6OoMsU
 /ACyPSauc849ilMC0fUN1gvjuxhrQHXwN+TeH7/wfPUrqdFYFtQ==
X-Google-Smtp-Source: AGHT+IE57hE7Y0d5eoXMaKP1uwuRgz+tWdjXGFbeFu59EZNW5srAcYMLEmDoMat+tzkActrHE/Qo4g==
X-Received: by 2002:a05:6000:18ab:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3b60dd7a8f9mr1863762f8f.27.1752659919536; 
 Wed, 16 Jul 2025 02:58:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:d584:3606:6325:3ecd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm17395270f8f.36.2025.07.16.02.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 02:58:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 16 Jul 2025 10:58:38 +0100
Subject: [PATCH v3 1/2] block: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-blk-uclass-v3-1-1fc761606df6@linaro.org>
References: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
In-Reply-To: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
To: Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The two functions blk_find_first and blk_find_next use a for loop with
the content being a 'return 0' which means that the 'increment' code is
unreachable so remove it and also remove the variable ret which is
assigned to but its value is never used.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/block/blk-uclass.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f3ac8db9464..b38c21ffbe2 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
 
 int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_first_device(UCLASS_BLK, devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;
@@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 
 int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_next_device(devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_next_device(devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;

-- 
2.39.5

