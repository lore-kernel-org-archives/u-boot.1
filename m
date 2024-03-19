Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF55C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9A888065;
	Tue, 19 Mar 2024 13:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uy4AZYtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029B687F46; Tue, 19 Mar 2024 13:22:52 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150BD8807F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e1d327595so3506896f8f.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850964; x=1711455764; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JOoPnE7/Qw4KSbwZg45xCKwsyTMmqgOFvlWbdDPRFE=;
 b=uy4AZYtSSv8dkzIhyqNATrukWxWu1p+4V8VUC11gqJm0GGloP93OKHd+ejLyrQSzbQ
 zkcOq0RUgFxf8vaprH1LnV8WQsyDRFuIyr7P5y/+hII3m6PgdSKsSr6nr72VXyeMeyIo
 /YNOMyFq2dzW1tRmZa9+qM7GHw7/1X5/6q0soqMmMFp+QYDHsHvfJZk5ePmyJlU524MI
 RfwVz2lxp/AcCD++D/SSJpSQApMnwFRRv+otI8Cxy3ccxvujGV0cvbFFNzEZQw/MnZBe
 3h5UfOjGeT5NWfRrnuSuMk8/j7f/32UD+OEsJVrX4iADi7KFaqbfr/tVvsZmju3XAjl0
 KGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850964; x=1711455764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JOoPnE7/Qw4KSbwZg45xCKwsyTMmqgOFvlWbdDPRFE=;
 b=uKAXtbABSVJga/Ww97DApP+UTUDa7OaROf3X/4gwizqODJTPgV1L5Fd/Bo5pQDolVI
 2F1JhlypkP+zONCn1FgXYjg+ceSdKSIoBx+JmxWxHfrMBujK+oiD/M237YvswqcJP2YN
 nPlDP9oWCJ5Wbc9ILpy7rKvSbLV/xKGIp/KneSLfew/DS9Qe+iv04u78m9X3JZCzGt0I
 4ysn4ixDIJmaKK4Jtm2sAkTsikdHZHaTEn8VrA7puSOWA17Plb5rDJgpqfiMJUjpi7yW
 ctX4akeJRMerj7B7RdLLinOz2YXpv2UOWZavJ41Kc09n5l2rbbMasNx6mJ16kHJ3e89t
 vf1w==
X-Gm-Message-State: AOJu0Yyc+tJOkRptcrO/AcQFDs4i8zYK4x5zFHevmZq6gSN69BqySXOU
 WO+1NLdg34HomlBoEAiXvNC31lkNkEKnPdT5756hfEKBahxqFcBO1e3GNKMgcSt8h1RiVdC3ESE
 1
X-Google-Smtp-Source: AGHT+IEepXB3Y2ogjRCQHisf4PoTZDHUojYeHNyAWVQKMEBMXVvq/RviwvCRLy31Wz/KE6mXSK1Avg==
X-Received: by 2002:adf:ec90:0:b0:33e:777c:3899 with SMTP id
 z16-20020adfec90000000b0033e777c3899mr7520391wrn.38.1710850964034; 
 Tue, 19 Mar 2024 05:22:44 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:07 +0000
Subject: [PATCH v3 08/14] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-8-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BqhIvZ0D1m2EoNdcJwYk4o3G6xvhwsOurBZjgFCw3S0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV1V19/vDwz+EpPY5XxJJd5SeteMQxcOCPklCET97
 bMU/6jTUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbyTpThn8L6pbMKN3WoPQro
 EJ286F5c1SvhVFmVh+tsFBZdE/jXw8Hwv/b6mymle6zZ58sWW8yf+mb/xtDF8z9/3yW59k/1Sjv
 mSzcB
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

The .direction_input and .direction_output ops are deprecated, and don't
seem to behave properly for us. Implement our own .set_flags op to
handle this correctly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/msm_gpio.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 5e57b0cbde75..f5d9ab54e817 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -34,21 +34,21 @@ struct msm_gpio_bank {
 
 #define GPIO_IN_OUT_REG(dev, x) \
 	(GPIO_CONFIG_REG(dev, x) + 0x4)
 
-static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
+static void msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return;
 
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
 			GPIO_OE_MASK, GPIO_OE_DISABLE);
 
-	return 0;
+	return;
 }
 
 static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
@@ -83,8 +83,25 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 
 	return 0;
 }
 
+static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
+{
+	if (flags & GPIOD_IS_OUT_ACTIVE) {
+		return msm_gpio_direction_output(dev, gpio, 1);
+	} else if (flags & GPIOD_IS_OUT) {
+		return msm_gpio_direction_output(dev, gpio, 0);
+	} else if (flags & GPIOD_IS_IN) {
+		msm_gpio_direction_input(dev, gpio);
+		if (flags & GPIOD_PULL_UP)
+			return msm_gpio_set_value(dev, gpio, 1);
+		else if (flags & GPIOD_PULL_DOWN)
+			return msm_gpio_set_value(dev, gpio, 0);
+	}
+
+	return 0;
+}
+
 static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
@@ -109,12 +126,10 @@ static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 	return GPIOF_INPUT;
 }
 
 static const struct dm_gpio_ops gpio_msm_ops = {
-	.direction_input	= msm_gpio_direction_input,
-	.direction_output	= msm_gpio_direction_output,
+	.set_flags		= msm_gpio_set_flags,
 	.get_value		= msm_gpio_get_value,
-	.set_value		= msm_gpio_set_value,
 	.get_function		= msm_gpio_get_function,
 };
 
 static int msm_gpio_probe(struct udevice *dev)

-- 
2.44.0

