Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E6DCD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D4D881FD;
	Thu, 28 Mar 2024 18:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="USr++w93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111A687A0E; Thu, 28 Mar 2024 18:59:55 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3776F881E3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34005b5927eso859697f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648790; x=1712253590; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=USr++w93Kkl7EB6RN+PzNmZGpkT4ELxer90TwltysL29VgSBVLhTwnW9MzJN/wodas
 2yE6yDjr6YYGuNgwzL1gRgYxxOq6nDuz9X0kU7SXddM3uSux6ZmGy+wfLIibtHZb+aZb
 cRdS2PgEnTRVIEZ63GzDl9MMVd6OH/quKpB5qYNMRhOAL5er+ACjbQC2FO6jEIgn9j9C
 7ho49Zt+IopNzMmbTWEcYY9z5Nf7/GiDDgUxWrp34vYu+5eaBL2fQx9NIgW1ryp08Rlo
 nitVLbmuXi2JSV8DMum1tDFyJOyOrkKv2ll6YjqlOpUgTAop9YXl4E2BeFoI7iA/sSG8
 6W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648790; x=1712253590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7r7yaX5GC6A7b+YWiB29a1fIsl80G8kHqu1xhDh7Zc=;
 b=VL7Q9SRYd/nooExXfRh0gRYZR29pie4rHKSZYW+wiVGbAQuZ/NlFH9vOWXnVDUFi/1
 NHYFeRvuEH33ybsXR8jpfNHPbKU/6KDAFB4s7a1+DG/nzbPiNsGfAbosu+Li2oT5hF78
 39PNmQlTqGi0+ub0ZAVUb75VW7dyiN/LUv5kxcFgtdwin9oyZa+cVX9GZnbMw8qAmub+
 1z4yl5/PcBVdMm8WUNWe4NL3ueBCaxdrHpOywMEOQtyHVQ0vmFFsdmuaDGTPZ3T2cJUu
 nSvQ23A/J3i5OV5HBXpOHF+dwHCkVNpG6tjdQ5Nk8lAVp21InkDcGE1UFrMrtPL2vJZZ
 jUew==
X-Gm-Message-State: AOJu0Yy/YnMCOs5vUjiLTetpxZH9ddMLlloR99iLohTw6ka+RhOOtpfn
 uvKGhX1KEEEEwLkis910InVRq5mOW3iweEBtg5TcgMPWw8GcqWewUR9sjZmrwiQ=
X-Google-Smtp-Source: AGHT+IGKXGeLcK7bnkkBuswDCwpldFogOruIoFcKvVSI28CcMa3yX0u3y6sHxJHa/phmdgtkc8rayQ==
X-Received: by 2002:a5d:47cd:0:b0:33d:c217:e8a4 with SMTP id
 o13-20020a5d47cd000000b0033dc217e8a4mr3449654wrc.14.1711648789843; 
 Thu, 28 Mar 2024 10:59:49 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:14 +0000
Subject: [PATCH v5 08/16] gpio: msm_gpio: add .set_flags op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-8-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O61GGp35CPRo6Gs3ecjo0wdiQX5EtInYxOC3wND9vEE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZxbTOueWl1rE2PcHNss5LnBjF07RPhpaX6Yf/PC6
 uSmhNUdpSwMghwMsmKKLOInllk2rb1sr7F9wQWYOaxMIEMYuDgFYCJ3pjH899lkevvTim2J7Hbz
 mIVe/NrR9P7h7+VNlffym/vCMpU++jMybJpYv/dr9vzsF8ue+M79eMk+mje8RnpJyku9junTA3M
 /1wAA
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

