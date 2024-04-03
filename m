Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B09CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5B4883A0;
	Wed,  3 Apr 2024 14:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P13VzyKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E51883B6; Wed,  3 Apr 2024 14:08:03 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F1388391
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so7438920a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146077; x=1712750877; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=P13VzyKFtDlmWRCAMx3ebtXdckxM7J/ef9rnYTnX5utc08oPpnjWICdTQ/jALj1LXh
 ZzxfnieuKLDmNP18x5GzpBjQzuGv70y385li3k2hGcc6Gbagcjuhrqlb/FCsUgZmM9sf
 DlDHId8z5Ysdm0m4YcQ/qNA3upYjJiOAeBhf+dWwGvTmBAHmUFJ+2hZayq6WI3LvvfWe
 7GcSQuvyWfz/MSaSINSSCqRNM1odj/lVL+NVLFmlBIamfaI3hExVo1iMh0gqWQNpdbF9
 n4H6n/xfyQy8b3BXTbu73gw5tTWgM1/pdvP2bmrrVHIOqLtFIQMyKTnTMQdbV3hlKpWC
 HL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146077; x=1712750877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=loBkZhPfjz+2lZbJ2ZEm8qFanFor/y0g9I/t3384MEq6M1UCwlYtroPR7naWoKwmu+
 x0p+G81Lfk49WNCWC7hSq82UuNFeUQVarm5KbmSU8W7ELfsFpNXOTa3TPraN/nFlKEwU
 +qOSZoCeYkxbpOGIUzhpPUwxEJcVBrNbxuEWBijvRK3XWkwAthBgeZ+57AcheDF0YZe8
 kukMGWfm4nVQfbbwbsaGH/tBqklUojKxBAa0j5DObQjP9L4qbmW7bfPBMP71DwNy70VG
 px+rEfnjOMFPCndsPdPKqaD0I+R6XNtLR8xKQ0ng6R1k6vgpxj0irW8pWA4qMcfCyjeC
 xPAw==
X-Gm-Message-State: AOJu0YzmobeBaHdS4gUAfwuW7j6Y0Yw27ZDaGSYtIR5MejfGIzfseRQL
 yGR3auZzn4lYGpnc01rmYGZknOdQQgFB2N4F4p66XaBYQOeStKRtAIoceWzYNdU=
X-Google-Smtp-Source: AGHT+IHzU1n8FCdNfB+/85R0srwpnDSEHExDtr11OShpPxgjvS+9Yx2C+lN4nzph7K5e0OSwcd2bBw==
X-Received: by 2002:a17:906:1c4a:b0:a4e:42f3:3c87 with SMTP id
 l10-20020a1709061c4a00b00a4e42f33c87mr9820017ejg.60.1712146077493; 
 Wed, 03 Apr 2024 05:07:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:43 +0200
Subject: [PATCH v6 08/16] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-8-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O61GGp35CPRo6Gs3ecjo0wdiQX5EtInYxOC3wND9vEE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRI+s2edccwZXKeIJz7QHuJSjYYg0RrDtwb
 x0ivGFAF4mJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tjD1D/0eBRXRly5Xacetqhfl+bYHm/I4+1ecokY0ZruWArO2y4oSD4CMqNPzMg0ckPsl6xeXIZf
 T6L6lRv6UznCzk2OXkKJyBg1relZesNwq9MIL4wFnnFV8id7x3Ks6RZ2mpalgZoLpGCmd261tK0
 yTVOvKQLt0aHpf7Fhl1CT45EPpXi44NQOsLaSNkjtHwhUr4s0+dEZEeNx8rqWXDsm9+nkrfkdrq
 tJQE6t1qOPNIVeibKsMI86bdzPJcXCdpO1lt94msM90QJ2UzR8ljeEbb0aORNafAY6Ix5abOcWs
 tJ837Nb/RltsCAGSVOkRkqoLvLiXZrIXqpZ6qzW+bQnWPV0FAJ1jkvfpGxYFb1mlp0pJ4RztjhR
 Nt4Fx3ST9UK0qgproknOhlaO7csxvmt1yuajsjQ3JG8ICsyhlhZ7Ox/ZuPP1gVtSz2aqEsJTxpY
 Mjs84g+uqo1B7ZdSesb9/OZpeUcy1zBAS6/yLSNbd92Z+rz2jsDUJCdE1jPpzRQDxfFSH0lqp8Z
 9Kr+zF82m9TSHF24llo25i1GJjlOs0BNXP8gCk0gePQJEruIHSeIYbzH2tzBz1RVAU9ilF0f1CQ
 VAJLKRUELcAjCNKVM6QmGWjtaAggQ0uehdvCyHmRwSzBumkhRsHvY3ObxvFutXTiQbeIjLDnVvI
 S1mAaTr0nQV4zcg==
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

