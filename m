Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01716C4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB03F87455;
	Tue, 14 Nov 2023 13:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dIcOY+YN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAEA8746E; Tue, 14 Nov 2023 13:55:52 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C5D87455
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso3837339f8f.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966549; x=1700571349; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q2lR41nHEyYrh4p79N6aA5ND1RAY/v6z4jiJdgAmdyw=;
 b=dIcOY+YN5OfUpn6gf+Deiw0B9Pf/alQKvWDleL80/5LpHL0TMHO4bTALqI3fGU/Ju4
 7wYHNMrsiYntOOZeP0seqLaJmqT0t+XseGR2RPEKg//yyEf00Wy4QB/Qpf6ZBOg/nU+w
 TVu3tA4ypDZe0VP+5UyZ/yh9Cp44O8BWQ5Hy4rpk98OsocsB3Qrpvh8YIkpRJ8QpQKAh
 ZVPJzuA9eRHfHjNJfBtC8a47eKCQnLlR9JypAOF14Fos7zbU62U8SCSaR9QL2somYiDc
 BSEUZD6YEL7Dg7C50njNIYKecIqXyYtneI3AEnp+5ZPnbH16Q3bmJfM72GkZh8DDy4uU
 gutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966549; x=1700571349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2lR41nHEyYrh4p79N6aA5ND1RAY/v6z4jiJdgAmdyw=;
 b=JXmP03tl0knG4fiej7RINCp1zGDlrvV6zHriazPSn+moArLE3ctJnYCB+ktEDkrP8p
 72x9jw2OcZJL5J78/g1c41gza33D5Y9VIEI64YQ+tTf7slgjUD3iAcZmUrtnFDIoMVJx
 fqYK/TOu47LTycPG9PEootA+JZS0QN2sH4Wnc/hw+FS24tgnEPvRDwP4anzjKxsp7qwP
 SWexy+de0BmVjs0A/G3VXBJk3sscCa2AhFoAlitem/qO76pProswOKvd92Ouk6j2HBGv
 BDmxtg1WpphOkFKKgiMZd0IAPpeHEbiCMKYVc24JSIQ+EXESc/F7OVMgQ+Pa8SYPNHLP
 H53w==
X-Gm-Message-State: AOJu0YzI1/wcb7PbATbEMQIyb/m97+PH+2wtzXbw302OeQH6FgoPW3/A
 2OhzDDYyPzmcFqYN+EcxRv74kTtLdrCYF58ChE+zTA==
X-Google-Smtp-Source: AGHT+IHczhI7ubFP2eYUgdc9b8c3trIsQJxmPrwhyRieZSPStXL9L+S7CHMy69rpjrAEwAB1WIGOOw==
X-Received: by 2002:adf:f28e:0:b0:32d:9d99:94e7 with SMTP id
 k14-20020adff28e000000b0032d9d9994e7mr6927653wro.49.1699966549716; 
 Tue, 14 Nov 2023 04:55:49 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0032d9f32b96csm7748569wrj.62.2023.11.14.04.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:55:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:55:43 +0000
Subject: [PATCH v3 4/4] msm_gpio: use unsigned int
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-pinctrl-v3-4-a7121677cca4@linaro.org>
References: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
In-Reply-To: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
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
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=X6lIUl16TsZ/Cp7pUId+SdIDlOT5igTJJeA3gzpplt0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgPP8Qyx2eWZKdc8rCTgbu+6Q/LerVbCXXgNBi8ZPne
 1wVs350lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlsN2Jk2KXg6ni9fMGEkgVr
 7P6sak3oPh9SJCoyw8Hpz6lmv+bNOgz/vXlbGnXZObUmJyyYIV9rHrf3e9WB+zbz2D7prfy25r/
 ACwA=
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index d9355ed4430c..80cd28bb231f 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -46,7 +46,7 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 	return 0;
 }
 
-static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
+static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -57,7 +57,7 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
 	return 0;
 }
 
-static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
+static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
@@ -72,14 +72,14 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
 	return 0;
 }
 
-static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
-static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
+static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 

-- 
2.42.1

