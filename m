Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170D6C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276D281F59;
	Tue,  1 Apr 2025 09:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xNeWE5Z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743D3801BE; Tue,  1 Apr 2025 09:45:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A8781ECD
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso33507515e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743493523; x=1744098323; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sk3+0OpXoWnb2vDMVZqj6wHHQKtu+DaC7+XXyh9QZgo=;
 b=xNeWE5Z+NfeuY+ZDbHXrvFBysi/GvdQNhcnmzPrPoh4R5neTVTiBeOhw5mu5zhBdF6
 6pag90uapQoF5DfvhnipZSQIZ3cyTYX62wFmEW5S0bvhsZJa2NJ11tMeBdVsDVvFx9XK
 n2B8jVStY37dSobXRs2/biDsCoJ6dQP5U8+8CStJ1comWzPo4XZSmYI2GqPskLuX2D61
 esago0ec1mq/+8OufKfSLTbHz3xawCIXO9e7aQ1YbdlLwNS8zECx3Vq8txRMTORT0Y/i
 vhEmKCi4kZc9b7uRGJ0B5TTKK3cCaFhiUmNDo7HuxTNs6X+cJ1UNJMK/lyzSbo45cpob
 6qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743493523; x=1744098323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sk3+0OpXoWnb2vDMVZqj6wHHQKtu+DaC7+XXyh9QZgo=;
 b=NEsTmYfW2/WMpFbHLKNF80KZfLHlH70px4ZJkKwO4iX/mJc37a52JG4PjlnOk1UV4K
 99/uC+PcKjAmGe9kHXVhs7hVyjZIC8Fi9Gq3SZuPyqqforpcuwUGJ+UFDIP8qixsa1Uy
 xr24LqLEKZLWNnnYEP2Bdo5MyfpUfEjBMD3ePhQj7n/VlBhdPR+H8wzXF6AyZPB/SQgs
 TATrxEUA3Gbw+KsB9+mMMhF8Lwi34tdyZzYCGtI+LcLIGsjAn8CVT91BDLNpC2Cd2tWt
 v0uILD3oet4maEnKT/7Yn/bvTic9hRAVGBJUiQ6WDopmSN/FtrAzirmhCl2jSRmcjV22
 2zDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHi6TaSiNCIbqUueQxH0pAk7685XfzsNCNL4MubQfH/wgG0IFHQ/w9KeNULoWQt48s4V0NIlA=@lists.denx.de
X-Gm-Message-State: AOJu0YxVNtV8vxKCbKme/ywRAHmVfGJP65nWQ/8sm4gJEi5QzNw4TDmb
 /7RQpFdUVNkff0/TOPUdyMgUkXLYPWhRaKbQhebFHziGZGOIzYKsJL+RX10sBXM=
X-Gm-Gg: ASbGncttnXqHTjGVUeKPZUxLUv05W/lWnC7iGRzP7bMN+d0NkmfILhQYz2qX8bEt4kj
 Y0np6Wq/hb2M4g09r4fDKTQe8zFlhao4XNNM4gZzMKZ/WAeMR3ERz5ks3gmi86ClYBT+Mmg97XR
 jFVVIBWjW7eexDGP6kbTfrQ9BM/pFWG78KMoktMj4iA2f+9zYVdnneAecVfGKrTu3CWGzNIIyA8
 At6bpjMOQRbcWt+8iO3q0Eb+uN2emTKNz6YI27+iApZ+NfElSD0cUx6ZtjfAD0hUkCYoyHXA0xw
 ypmCVRmYsi11WPczBGTk3R8OsbCPNHmAP4bCvGduP0rkzEV/9vHG2XP6IIoBp9kLH/oc88QUXbD
 0
X-Google-Smtp-Source: AGHT+IH+pgRcVQjO0xcSvxLL6vR9LXy241P3wIVp8SbcekXEgUAQcq8HmC6H+vjYGf6d9/N2QE00Gg==
X-Received: by 2002:a05:600c:1e0e:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-43db62bc57fmr102299915e9.22.1743493522869; 
 Tue, 01 Apr 2025 00:45:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f9csm148715295e9.26.2025.04.01.00.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:45:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Apr 2025 09:45:19 +0200
Subject: [PATCH 1/2] gpio: msm: fix get_function return for special pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-1-a1148a02bb16@linaro.org>
References: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
In-Reply-To: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ufkIG+Z9d/QK2KTEf9XPSmq9r7U9SUbvTMFbO30otkk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn65mQKHOGz5adP9s3L8vs36HJRCCtHFy5X+kKHD0V
 Z/fzYmiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+uZkAAKCRB33NvayMhJ0fwxD/
 9XiCpBQZecoE8OkKMvnwIfVL5im4ITwWH309zCgxQNPjUe8NM1b9cyCEpjFp4XO/LZjesC6yzGKm7m
 8A+0f6FpsaLMVIKhTtOWP0qLTlbBPT12Rof/QUGbf3ZWvwdzyc4jTIIri+KG6VDQOyqCqb6iuhUFXB
 nQQlSSHuUSGx1Cve9MXJ7oX7yRRSMzp//9MedCXDVUB02D/Ysed76I+MCQs6sU3KDEETmit+YwPUcF
 eVZobZALDATq4dnQBL/f6Tm/GkYfWgud/qzP8gNotlwhFVsEiyPh0qG+ykH0t0+KpVGYvOdEIoURjF
 Wao1i+RKg2QrWFcnX9ikEHguYHV7r1Ee84ZPymqk6lemDe2Oo3CR4W5owM+eKlVtdx7S0+W/XNsf6/
 JEI6YonSWkBJoaU08zUWpdSx4uPgINg+juiXnIwFnYF0JUKrpCx5nIgU9dZbpI3Ph372Un4854dJR2
 KwGRmQXwBTh/8czU2ryKIrtpZk2+1u8TXAptBdHBVMUoPYeThsp0a0gnQmX0lIez4w+D011yJcZN5j
 IZmzL+NSQ5NeVWbDJ83mBPmsZNyVxgqW/WQgZy1t7PeBR8uZW9gqVy/2q2PTDgOpP8R/6AutfQUnf7
 CHo2OGdUpgsGFeeTiVDAHBVTbFftwAVPmMqCrISBHjB+y9OA1tEt2pud2irg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The get_function callback wrongly returns 0 for special pins,
return the appropriate pin function by probing into the special
pins data fields to find if the pin is gpio capable.

Fixes: f9bb539460d ("gpio: msm: add support for special pins")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/msm_gpio.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index cea073b329777d4e03fbfa86415041a825f65aad..f208eec7e56170a9a79f8f021ceec85b7da0ed81 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -192,13 +192,41 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
+static int msm_gpio_get_function_special(struct msm_gpio_bank *priv,
+					 unsigned int gpio)
+{
+	unsigned int offset = gpio - priv->pin_data->special_pins_start;
+	const struct msm_special_pin_data *data;
+
+	if (!priv->pin_data->special_pins_data)
+		return GPIOF_UNKNOWN;
+
+	data = &priv->pin_data->special_pins_data[offset];
+
+	/* No I/O fields, cannot control/read the I/O value */
+	if (!data->io_reg || (data->out_bit >= 31 && data->in_bit >= 31))
+		return GPIOF_FUNC;
+
+	/* No Output-Enable register, cannot control I/O direction */
+	if (!data->ctl_reg || data->oe_bit >= 31) {
+		if (data->out_bit >= 31)
+			return GPIOF_INPUT;
+		else
+			return GPIOF_OUTPUT;
+	}
+
+	if (readl(priv->base + data->ctl_reg) & BIT(data->oe_bit))
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
 static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(priv->pin_data, gpio))
-		return 0;
+		return msm_gpio_get_function_special(priv, gpio);
 
 	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
 		return GPIOF_OUTPUT;

-- 
2.34.1

