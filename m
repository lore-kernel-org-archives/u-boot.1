Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475C6C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D991A87E3F;
	Tue, 30 Jan 2024 15:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bgA9c47I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCBA87E30; Tue, 30 Jan 2024 15:05:25 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D794587DCF
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5111ef545bfso826506e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623519; x=1707228319; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qKR8YxB6uXda+sUnTr7LYGgrSBzhxyEw3hRg6oJNg6Y=;
 b=bgA9c47IhiTO8+n26lQ5JDN0icUaXv4rP0WRKjv+KTt/eqihiRj1XcM/qKZJ2NAEku
 IAxgaSrqNpp9EFYorYf+1WDSpKqN1a0uyRlSCBteze6i8CPxi4YZ3Vyl2f12YLSXYm9c
 F9+fvKy3hVJjYnixTnGYT2gqfzW8v1VcH8we/GJSok+X+B8TJsU3HvkmEraGVvrmB/5f
 fiobLEOvV1em8drT0GEJBLkk42wbGnBmaVNGPs6p4boffZ3J8NZEtp7zDmLqHu3/6Z6z
 nw0sLSD4wNqGCia0qVJn52ZHjKXdpTRrEdZhjwhgcSo4v0DuJ56kB69iU7sdU6EYp4pZ
 AsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623519; x=1707228319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKR8YxB6uXda+sUnTr7LYGgrSBzhxyEw3hRg6oJNg6Y=;
 b=GOzj/RYHkvP2ZyLY7sJT3M4NPdp7WqmOSVfSebSG/HhUqNEsOMn5cMf1imqWlRf+Rm
 iFIT5xUBhLyw+dKcpNfFxAI2/2MC/IgcqLK+p5Qh4631PsQNz5MmSZwb9M+YpSsdFvze
 8FxPsgffTaGkDOtXGB5jAXJNiy1iINQcH80D/AJaHyOMBJPSkWpHakimgXtAoo++7qz5
 l5Nju/p5QkjF+bQIr265sJtQq+ZjY7WBGFkpn4x5FW4AYnYYjRwxzzVoOxh9R21VT+OS
 CsNdi2BJMq3zTaJua4viQVcBhGRS+HoJJLASWgyKfptKuz7WajpEtLRsC69DKF64BtmM
 zoMg==
X-Gm-Message-State: AOJu0YzR0Gp9REvfqUSak5J6L4pV90a4rDhkrrmfgkumqRs4+LCaX1T/
 NXdzV26HOfEhKYP3f9Z9Ae5UhXHqSRv9p8FQHtVshvZVkoGp7O0YoaoGOIiEgEU=
X-Google-Smtp-Source: AGHT+IHgut0gl90G+5/OrOW29UIqHrQyq6i8igjuThoxc8uFjur9QhfIv0DBc9PaN+w0zjmTNygt7w==
X-Received: by 2002:a05:6512:550:b0:511:20e3:e456 with SMTP id
 h16-20020a056512055000b0051120e3e456mr274691lfl.49.1706623519317; 
 Tue, 30 Jan 2024 06:05:19 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:18 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:58 +0000
Subject: [PATCH v3 10/36] gpio: qcom_pmic: 1-based GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-10-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PTYGGsesPNEUSn9mdotJjj9IvPSphi8HF0gXMeC1zhw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAIOu/jl0wqNI9pkgy9enRCx4UltvvWr5ZGbom0mZ
 U5I2Lylo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExkYxAjQ8uJG6VHNG/s2fIu
 4fWhZe9ncOho7PZT/sN5WPaUr3+P6waGfwa3Uup3aS7KY9B8OpOZ9ebTDVF9MmFzNKPOFyc2t2n
 /PwoA
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
2.43.0

