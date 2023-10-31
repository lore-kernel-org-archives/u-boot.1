Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E32EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3310587CDA;
	Tue, 31 Oct 2023 15:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSJ/sOf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03B387CE8; Tue, 31 Oct 2023 15:22:31 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3CFA87CE0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so3641491f8f.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762148; x=1699366948; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XSVO4sgdYl+x8pJZ214whfLvPOHlW+yGmHoHraAK74I=;
 b=jSJ/sOf1rgHwfqpB1kbXCT+jJ9PUqG1+0ubmaj2SOSouyrrBYxPm01LmJKEiQyrp5W
 skJz7aIoB8rPvCyfabkdpSPx93qdMI6kOXKqZ5mOnb6XRAMiB9auqd71YqO8cSCKLYry
 AzPqMHZtx0MyZP2V9D2op1uOmaO1vRMUOD7HxxmssmJatJ3QrFz0JSdWbcVFv8Mn+Sm5
 43/C0yRQcKvQr7Wp7V3W2PNHuDtWHoKtT80dRW4qYd9nY0l9iYi2NYEzgRuU2HLK231z
 dIVTWs7ZFusQmkcE/G2raq/kME9rFWtGv4ujkmzDYxE4/hWiV1OPyVu+GIjzN+j4rUOo
 ZMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762148; x=1699366948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSVO4sgdYl+x8pJZ214whfLvPOHlW+yGmHoHraAK74I=;
 b=HnFTTNae0wTEgR2nUUiIiMpKstHWkSl5U7C8zyfbUSK9G7lYpIzYMSaZ4vOsAiC2pX
 olwQQFUCjH+/g125M1z+HEK3s01Oo+Vu71XxyWKmnwX71i47SdR7q5ac5TsOh9/koUEi
 2kzkSLbk9cJNJxVSqo8PYPKhW+xM6kr5aOk7CPsrA8mQCfRUaFW8mWfC5koAzm6mJDg+
 6dq/I22iAd28vUCU3gnTcJT+6DVhT3Na2a+oopRO2rMmJ0zkMzGrBFZ4VKU3JxDVXjnR
 orZxPUdmwuHvWBRVPqkdy/DOIyEFVOOqCxkPNledLLPwcVhuw0gZA1+GHoXpvHGn/4uf
 +XvQ==
X-Gm-Message-State: AOJu0YxDMAqyO8R7cD7WKaa3vfgsIyNqACKbfIrsdkkbPjRhzdaIj355
 Vrer93we1cR6yebzl5IINmiBXA==
X-Google-Smtp-Source: AGHT+IH/ZSrGK5UBC/9quX7d+kTr9ReOr+tc3vI/MR/8OnjALJd1hYqY0NNwgnU73KzF2xlgWJaEhw==
X-Received: by 2002:adf:eacf:0:b0:32d:a2c3:19f3 with SMTP id
 o15-20020adfeacf000000b0032da2c319f3mr8566708wrn.41.1698762148495; 
 Tue, 31 Oct 2023 07:22:28 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 i8-20020a05600011c800b0032179c4a46dsm1606372wrx.100.2023.10.31.07.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:22:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 31 Oct 2023 14:22:23 +0000
Subject: [PATCH 4/6] msm_qcom: use unsigned int
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-b4-qcom-pinctrl-v1-4-9123d6a217eb@linaro.org>
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=laGwLFWmOYwYMdfhRKLjhUz9Wsyx8bfPIGbW+nHyTkA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRH3nmhVV03kn7fM+pP9uy91PLK6Dh7sNo7vyXv0zc+X
 LA/Ra+lo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzklxXDP52flk4Nj9vOHKnR
 NlaemqVnHbD6j5WKnbzDoeL1usWLzzP8Uzt24sW63/z7t6385XrkQfv5Day/Yr9vFdCduPqo3Iz
 Gc5kA
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

Replaces the uses of "unsigned" with "unsigned int".

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7a09abdafb2e..7d01fecf46f2 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -49,7 +49,7 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 	return 0;
 }
 
-static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
+static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -63,7 +63,7 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
 	return 0;
 }
 
-static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
+static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
@@ -81,7 +81,7 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
 	return 0;
 }
 
-static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -91,7 +91,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
-static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 

-- 
2.42.0

