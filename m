Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC35DC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4F4876F1;
	Thu, 30 Nov 2023 21:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AWicY+bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4E6876F1; Thu, 30 Nov 2023 21:22:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C2A876B0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40838915cecso13046095e9.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375768; x=1701980568; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZD3xWJFTddk3OTmdBUhNqHlWq/BUIyH8Xi/jMrAbFW8=;
 b=AWicY+bQHNxxzWPUF8jZ8gALpupdVkUYIsWz82zEbuj0ZFEjY9W+APvhc/X+6E6tY2
 oI+BO+cE/J66DJoofUaDOZZze739uoE7KN79rZ99NNR2KptYBxX/5jvZOan25WDg0rya
 amSl9mUrOd1dRhRB1O/ITVrDEm9HkPEQBbKSSt6pzheMGipgnJySMi2d1CZ7JrC3lt3F
 JbeKPqHDOb2xQujEPtzAaokk3a/ZUzuwrrUbJsQRWMZpFKNJBTldubVrLt51OU3HYRrd
 cVz0NUz//LZ+i+pcVEJaWbXoE0+7zwBOU5yQLARX6+ftySPWO98wZzWUCLObZHOtQK58
 zPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375768; x=1701980568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD3xWJFTddk3OTmdBUhNqHlWq/BUIyH8Xi/jMrAbFW8=;
 b=pnkRs6LLI6j90G+bgRSti1X0cykhXnapOxH/ocPRRQa97Nf9CzLjSVvw0RRZPof/x1
 d6IUkFf0VWrG1PyKtwJW+2YCq8ByW/+PbsKMpNWXOablWGBVEBBE0+p/6ek25qjiGbO2
 Kj7rtXH6ENetra77bGpYxAZhUT3ztVu4tXxhFZ+z0ezJpoiiluzUFJvwfQnBmfjUSQ/g
 9itAOzaSsnL2h34qFqhsB1wEwVuIfyEXbUpuqg57e+cTzKZqLaaepTKiKc9XPSU4Eldl
 NCeds4um7PGutxO7EXClUn5XZmYM6aAWNlujDNDFeN1R6EzTXJl6z+6Cr5X2teyRB/e0
 gBZw==
X-Gm-Message-State: AOJu0YzrKngqZgTEmtT4on6RSIlHQAY0gHOM930VoPjLtmgjs8HAHWSZ
 eEHz3EpIJXJAIITEvWA2UdiduQ==
X-Google-Smtp-Source: AGHT+IEU4oHtGAwNfWGhjHqSGk8Uj5gb3pRY6wpDC4HD0l3injY3P/2APlktiN70FbKNr6EwHHg7iw==
X-Received: by 2002:a7b:ce90:0:b0:40b:5e59:da7e with SMTP id
 q16-20020a7bce90000000b0040b5e59da7emr32233wmj.145.1701375768312; 
 Thu, 30 Nov 2023 12:22:48 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:25 +0000
Subject: [PATCH v5 1/9] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-1-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Ow6e+BYI9LfPmrbAV1SHSrFbCMy8//JMJxsRN55OU2Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM96I7Il6oJIRYW8yyjbxm571qqdiKlym9+V/33T2tH
 zDJcKl7RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIWjIjw9Rf688+miActOxT
 7tejDUejriw/PnGb8NntCTzlmiZVX2Yx/K+9c79zrsdpuVmKLE4bQ0LlHhbFy35/+16Mf+OLnMQ
 SjSAA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
with the upper bits being used for error codes. Do error checking before
downcasting to u32 to prevent errors being silently ignored.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 65feb453ebc3..e5841f502953 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -221,11 +221,14 @@ static int qcom_gpio_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != REG_TYPE_VAL)
@@ -328,11 +331,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != 0x1)

-- 
2.42.1

