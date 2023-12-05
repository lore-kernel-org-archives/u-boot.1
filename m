Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7224C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84CF8757E;
	Tue,  5 Dec 2023 14:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LFFiD3V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA70F8772E; Tue,  5 Dec 2023 14:47:00 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66B58753E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f413d6b2so36217981fa.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784017; x=1702388817; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cJvrPaAaFSzZAMsWc01sNx5dzJpVx3P9bhLC6r+6rtw=;
 b=LFFiD3V1O+RecvQIllLf46lyugPuMBRPoVbODZKV0s5jWnDkUaL5MfsmIVkJGFJxn9
 WCCh3sxpFricqfuxjbY5ioJ3IjTdWUzSbWrWkAxTtKwRU8fJmF8wovSPCDQYgMQNjoSN
 W23We152iJc1Z43bTQc7SGNb83DgLTZePtMpyZl0YNZzyXeu5H8H6ZkOvxu/GmIIaHW+
 Wg12ektKDH4LHHhHwKg0vvAN707/e8d9F7PrCEtOtRSwWNdkjj/YohBNa8ae9QaVqrPG
 gL5XGboU1n4gg7Qox+iK9RmvoFqOs4wI8NLXzt0n3hynpLzYIh949jxBfjo65Yy5LP9l
 XdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784017; x=1702388817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJvrPaAaFSzZAMsWc01sNx5dzJpVx3P9bhLC6r+6rtw=;
 b=YfRGioxhCAWbk1bJYdFj842Cin9d7Pt+KOowzTLZ7sfHUleqoDqI5suZUvzFxXO1Px
 OduI0tjkIkrQR2mwhNdAHHOpvZNTgI6CppxLDPpqBh2dAhI2NbLS0O7T3SxOcR6K/Uc1
 g7iljGHFxTQ6LpDZt1sfA4IwRSBqsn98vgOZMs0s9T+e/jUR5HPxsFEQfinEiK5/6f9T
 Wk6wdSVgS/33DlreuyrWjnCCiv9o2oKuvjQMOsiN8lqjPUPJpzLbJQDE58rMoNp/zGW4
 CJ+8mEpkoIPK/5xgL0+zcS9gGC4YWqWrYA2wCMWDQOcYj1hGny5uG6H24YZUEvRm9hK7
 OUFw==
X-Gm-Message-State: AOJu0YwWr8yfi3fyTqbc4BR3/Q1A1sC2NcxbTVFu0oLqf+EvMcKiSLZe
 UmyP4U2j1k7Eg0IhKS+kBMSq+w==
X-Google-Smtp-Source: AGHT+IHbU3BuwUibEt2omfswJKWGIx753+74FDfBQhKjYXV3f8AOVPVnFi8mwveLf0uf8tpo4OqWnw==
X-Received: by 2002:a2e:8341:0:b0:2ca:5d4:c16d with SMTP id
 l1-20020a2e8341000000b002ca05d4c16dmr925143ljh.54.1701784017628; 
 Tue, 05 Dec 2023 05:46:57 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:46:57 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:46 +0000
Subject: [PATCH v6 1/9] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-1-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=mkl4qdGXiwrGXE9Al51l5zCtDJYGuwmoU6dNcPnevbE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zbMRvUlftyqs18vbLLhJ8tGVs1n7sqYyFXALHnYOS
 T6Suqqro5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExE9TnDP6NJXE5yh13Yow2+
 XDBosd35Z9ebD7e/vH34+t3ax+de31Bh+Gc80fHz+bJw3Uv/jqd2JbOesrA4u3eNSF/YtrOn9n2
 LMdkAAA==
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
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

