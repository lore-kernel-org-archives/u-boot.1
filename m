Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3546DC48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 07:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2D8879B5;
	Wed, 31 Jan 2024 08:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TxQkCVFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BEA879F0; Wed, 31 Jan 2024 08:09:21 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C616F8780A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ae4eb360aso2851053f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 23:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706684959; x=1707289759; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HIj7n3eX+mYVWMQ6iMRCcoQNj+RTN7tO4TQbJ+zWDs=;
 b=TxQkCVFE2AzaVq0o4lVPwj93pNg6G5zZssboK1uI/7fI9Cfjp9HMKOfz9g25iC1TBx
 gdXf2DPxY5vCIRmrolQSXAchObI8oHcfIUymrST1AU0PC6n0kQQLoDdSIxU0S29fXnFa
 WGZ5nce+tWds8kzVZ0bvMdaZwwTUIVju1JyDapAcv1yfIc95hLfdsUVpMcuut4HwGyEz
 1UTWLiOgxdH4sz9tJmG0tUUGvdwiGzXadi/q4NlsSgh/JWfepVL2/OhoCq/5E9rXCFBT
 uBGn+P+Kp6sQ3e1VqKc1qlLkppeNxKpWxe49Yc4fmIlFSvKItxDF7VyHTEDdKw9TdGci
 xTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684959; x=1707289759;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HIj7n3eX+mYVWMQ6iMRCcoQNj+RTN7tO4TQbJ+zWDs=;
 b=tcM3hdoehHjunlAUbkmi0/Z9zV/5LsN3DqzLSUBeVBHUI0wEgVBy0ypK7SFUzxaEh9
 Vss01L3Ee81N2DgqnoGXOLeKJt1fi+8tpUNS/JDbqp+c1RSK4YpBOUjJUjRCIU1VcAWD
 OXJ8xZp/nBbK0zkgZfXu23r2VgG/NLMfSd4ZtO6CU8XJiI31uHkSseODtAQwRV457bi6
 HuNmrFKV6ezsdKCymElsAQ35zFvCx7vVMHl3l05oLVCU0h/0n6tA7+HCwZ5jBvB7ngv9
 DOwvJZXlENzukAQo5OpjttNG1fLFTUV4YUfmr7bqElGfdGP+79eHaglDY7LDTNWdrthF
 ICWw==
X-Gm-Message-State: AOJu0YywdAlC5YDMmhSYqJ9eTCWIMOqdsgbAXScr5kLGueqx1n9sahZP
 MBS7QuQIbTF61gQ8VuGUFmWVOXLWv1zGjGAVK8NiI2LqMLMHZc9lbL4O9VclU7c=
X-Google-Smtp-Source: AGHT+IFUP1k0wmW5hzbXlA/5aPqS3culnkL1tX5NG8wpZXy0L5Hj1E6PGwuqdxtRFQKoDm3zF4o39A==
X-Received: by 2002:adf:ef12:0:b0:33a:ed59:c137 with SMTP id
 e18-20020adfef12000000b0033aed59c137mr533709wro.40.1706684959150; 
 Tue, 30 Jan 2024 23:09:19 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b00337d4eed87asm12640621wrb.115.2024.01.30.23.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 23:09:18 -0800 (PST)
Date: Wed, 31 Jan 2024 10:09:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] button: qcom-pmic: fix some error checking
Message-ID: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The pmic_reg_read() function can return errors.  Add a check for that.

Fixes: 4e8aa0065d4b ("button: qcom-pmic: introduce Qualcomm PMIC button driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This patch is mostly to make static checkers happy but it's obvious and
harmless.

 drivers/button/button-qcom-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index 34a976d1e6c6..e778e51a4f36 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -86,7 +86,7 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 	}
 
 	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
-	if ((ret & 0x7) == 0) {
+	if (ret < 0 || (ret & 0x7) == 0) {
 		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
 		return -ENXIO;
 	}
-- 
2.43.0

