Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E287C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B34187853;
	Tue, 19 Dec 2023 17:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fwg6JTsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2634877D9; Tue, 19 Dec 2023 17:04:39 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1036B87536
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so24190105e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001870; x=1703606670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wkLA3ho3ZiB/PrA4fT8t97MDWgiOYb+QZx2Dy0nQSBA=;
 b=fwg6JTsWCFsN0Gr8Gm7j7crLP22qigAwvNpO7L5/jcOrvtA4D1HkA4UZsPuxpxEQ21
 /6/dX2vlD/6igKRV3McPMcsvUJHqBdKYCjgAekj43KTEruBC635POkdWSsDm1GxHejC9
 qndL+s70vVlo9TmuQD0yWkFWBclA4noKzuDVHnQDTa/eb3N/KYIGGkPqfefs/ueMMB7F
 66rZnrxTIT/RKhygKj0Mo5mqvcT6NOI27ylcphOhO+g+b/d2whK8ZFjVzPuCEKJ+JNoQ
 nvt5E4aaoqZOLmD6NiEWA8gcjIVawfmJ1Y/nJC3/HHjwYrnM9MgxmnYACJTQ4o/1z/TV
 g+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001870; x=1703606670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkLA3ho3ZiB/PrA4fT8t97MDWgiOYb+QZx2Dy0nQSBA=;
 b=idMBVAg8FXPpHceHMNpdjpv8bfX4/gq3gYUq+9dj1iEO4N7vtktJqo8J00lVeG0kPz
 HkwgpOR6/5IpkrUaGbBfTyy0ipV77KNogImLIMsVTW+GR+XG74vWcoCQKmFa9V3ahV7D
 Zpxd4+8vqs1YSb6eNOsIRIgl0HVoh7540tDQc94UOizYYhGW2PFAQRHOcS7RmmkeLmb8
 AkToOWSRch4FYQT13Bkt0Fs3Q1IacziYYfFlTryXyZqve63b1VjA7GOQHu+/B4cPXABZ
 JmX8dQUHWXhM05/WAlSSFRrLn46b/4f/OmZnAdgX9R3k9mCfFVmjCdPNUZUsHDYrWKzh
 edDg==
X-Gm-Message-State: AOJu0YzAhtwYpUrCYBheWxnBurnzCTA3yNfS7NK0iu67x4tzWGKOqMGY
 EnRT3zqIWvyd5yYbwmNZ/LFIiA==
X-Google-Smtp-Source: AGHT+IErqVJPYOS/ZhlubOvOMzrkFOZvnCmp9glZFsMJMU526szBdX8KuMb6ae9noHR+VCSMNYtufA==
X-Received: by 2002:a05:600c:281:b0:40c:46c0:b6f6 with SMTP id
 1-20020a05600c028100b0040c46c0b6f6mr841056wmk.185.1703001870601; 
 Tue, 19 Dec 2023 08:04:30 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:09 +0000
Subject: [PATCH v2 08/32] gpio: qcom_pmic: 1-based GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-8-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GvAjrZ/Uf2N2sVruWVDuDSkRXKMBWWsBLOEXcDnB5gs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Uxitnll4bNXmDTbr/GW0zpytizFYlnO/JCTEWFvz
 1+v6DvUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbiv5jhf33R9qWKl/g3LDnW
 Er9LWafoh0r3ul9ZTi0/j0r/S1RU2gJUseDO1bn5X00dnE+Ul+67eO65SMfv5C1zG6O2v5tr4dc
 xBQA=
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

Qualcomm PMICs number their GPIOs starting from 1, implement a custom
.xlate method to handle this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 6167c8411678..2a4fef8d28cb 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -209,12 +209,34 @@ static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
 				       REG_CTL_OUTPUT_MASK, !!value);
 }
 
+static int qcom_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
+			   struct ofnode_phandle_args *args)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (args->args_count < 1)
+		return -EINVAL;
+
+	/* GPIOs in DT are 1-based */
+	desc->offset = args->args[0] - 1;
+	if (desc->offset >= uc_priv->gpio_count)
+		return -EINVAL;
+
+	if (args->args_count < 2)
+		return 0;
+
+	desc->flags = gpio_flags_xlate(args->args[1]);
+
+	return 0;
+}
+
 static const struct dm_gpio_ops qcom_gpio_ops = {
 	.direction_input	= qcom_gpio_direction_input,
 	.direction_output	= qcom_gpio_direction_output,
 	.get_value		= qcom_gpio_get_value,
 	.set_value		= qcom_gpio_set_value,
 	.get_function		= qcom_gpio_get_function,
+	.xlate			= qcom_gpio_xlate,
 };
 
 static int qcom_gpio_probe(struct udevice *dev)

-- 
2.42.1

