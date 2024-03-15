Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E33C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A54988041;
	Fri, 15 Mar 2024 16:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bvf+/O57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB3987FC6; Fri, 15 Mar 2024 16:10:43 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48B588007
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-414037f37cfso3788615e9.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515437; x=1711120237; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JOoPnE7/Qw4KSbwZg45xCKwsyTMmqgOFvlWbdDPRFE=;
 b=bvf+/O57DaFItCBlz6Yp6MlkADz/NN/XCH3//at0davQMyPgm09x7rELSMxziZLVvF
 1U9bnPWOGIoGcFizcxFdpK3vfkFq0gVVCh2BMT6ls2vBKiUKEC/Mw3WNlq6+26PDVPtg
 NMd/87Nf1vWvc9TKAy+7IP83fZDOuxZ7Mlpak0YILv2xbQhgEFxptgxUjLrRnKZvl6j4
 D6CfVA2bMb9S1pu3Go8T/KxglEsDT9fSeNlOwXRhqQm+dOso2qHk9ok8V548yPPhi0dv
 YG70n3wPrwntU5G/52Bb9+kQHmq6rCxZchfywTR7FjqkVUszBWgEiLhAFGYdOV4hNfm9
 jdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515437; x=1711120237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JOoPnE7/Qw4KSbwZg45xCKwsyTMmqgOFvlWbdDPRFE=;
 b=bu+1RbffdKYgsNinNupFB72umeYPLjKn0ChLnNMeeUEDIBumRkPSM4aOCsnA6rN/Cr
 4uRdjIJtW3CIiIu9sX9bbHsLd0/QQ5Cr4RrkVBi3b6GfOqSOXqNPavpUXRu9wOYCRN+U
 6PjEPuaGvAco/8Klq3I6a24PJE+IgtJRoO9NZbImXLVxdALlrqfyelzsV4K+Ohf347CM
 pR15kKiGCFf5ghQxEWTis323pu2Pno7nAnoblJkK7wmgh+BdfwirIw+rDlze3+d4TG5C
 WVXaHa4G75/H1uXOa8rd8gxnTnelLY+7rCpiKVKrpzmOZmTRmLaFOgdQ/qV/k4jrMlAM
 1oeQ==
X-Gm-Message-State: AOJu0YyjJKpF8tgftNcxhJYCY8otdWJbXkCP0dgvUNB5MhI4AdE1aLJo
 FSlKYcx8tApQeN8ke4sKmf3QExvjimKwrZA1Ji6OtAHOF0+cvFdqhOxX64VOc2SYhP/0NUBATeb
 C
X-Google-Smtp-Source: AGHT+IFHSv73hZfnNVGABaRRXqpaxxDBwcHq6RaftLUnLBWnsuMbBIq7qJ6tJLlHmzuCJOo8kDEPGw==
X-Received: by 2002:a05:6000:1805:b0:33e:c7e3:b2e7 with SMTP id
 m5-20020a056000180500b0033ec7e3b2e7mr3554917wrh.11.1710515437305; 
 Fri, 15 Mar 2024 08:10:37 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:17 +0000
Subject: [PATCH v2 08/14] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-8-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY+DAjS6ZmRx3ZzLsHm3crtIk6zfAz2/CesO9znrH
 fh//WtuRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIpReMDEu9A9/lPY7j4tz4
 7/pVZbNYnQP31x+/39xtv/D0tas86lWMDG1G+nuUO1TVz2iyJ+hyCat8ddqvffup2Tmz2+/1X/W
 xxQAA
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

