Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83823D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968F3895C9;
	Thu, 14 Nov 2024 18:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CV6+mAUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A6A089607; Thu, 14 Nov 2024 18:19:04 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008A68954C
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso144015466b.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604741; x=1732209541; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2WHYEmNstdYnJM/E8T5xjR4XgTwwfo8qEhdIKFE+4zk=;
 b=CV6+mAUc/oKYLo+UvnMhl3IWkxNlSI8oFHN4rU2EPPH4B9209MqHzG1C658XwMRDHD
 0/sDkaqt5Eo0DxmdS0iJ/NrH7zuNsILDdFfxSB+qmdd15AWp1F8qOC/2nVLVP/O09/8S
 VJIwCrKKRuD9LN/H/Y2+/AvVFRBBFuzFgw1xU3zjsAvr0udFzPF1qv+BnTPfy4/3OYpb
 oQ0RDI3aTDireDkw8LHRMtLlf4JTYkn1UUtkxzMX7zEoaBtCCZFo4S0N3dq5qNbs+8Eg
 B+Cjt+aGwN2BwBh+tOcK5w9MqoKtjXI9JWZ0dDhLDxt6WTbJ1q/oR6l4TT/GwQTr5Vwz
 U+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604741; x=1732209541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2WHYEmNstdYnJM/E8T5xjR4XgTwwfo8qEhdIKFE+4zk=;
 b=kQ1sYjkdXuSmSEnCyW9ZvKUsoX+1okH4QI4TEAL/26KFDEX9Cud/Ta6p4kX70pB2oN
 69QPpgIC7HoKLBogXHkdO05JRJeJxf/rdfS1vz4exNnEgAXXVsowet47Wej9ZNtY7Mz9
 Bz658MTFJ2HPo5I2CyhjXNhEPaUNwmPIdbAzm6b8t/2Mv43qPpV1sbA1bsKj3SVcyWG6
 J2okzgAi8Wq2vzk3EcmzuiT9A5QP8XAVCVR4RINKw7B6Y8TDjeRuwJcr1iYmeU+7w53n
 DFJeJAJNADRqwPApyxFgL7jKTiikdF+TZ40lXeTGtpe8zGonk/f4gdIZ5ZBGvwoO5h43
 A5LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRgbFBvbtTZahck5IqNeOzhMFTCxQwVtEBV52QV918chNMU1hPQlK5s0RzVvUcGs0pFfRA+AM=@lists.denx.de
X-Gm-Message-State: AOJu0YxAFih325S6Ini3Ek+zHqeMMJvcMNUlun5SUx2/d7vLVqe5CoXy
 VlHq+Y9QhCWCs2urOH64UTSUG9W/2tmNaNqfsTk2wOO0tpqhHcbrJ91u5qBqtn5pXI1uRyP4r6K
 t
X-Google-Smtp-Source: AGHT+IFWxCTKxxH651rgwcVTK78vpyvf0zVqo0Vh57W8RtHVJF5yywhunCfmzqzOw0t4BqvEQxfMvw==
X-Received: by 2002:a17:906:eec3:b0:a99:f71a:4305 with SMTP id
 a640c23a62f3a-a9eeff0da96mr2631379866b.18.1731604741509; 
 Thu, 14 Nov 2024 09:19:01 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffd798sm84593966b.93.2024.11.14.09.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:19:00 -0800 (PST)
Message-ID: <192ea3ec-dc55-464c-9643-048f8e4a988c@linaro.org>
Date: Thu, 14 Nov 2024 18:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: qcom_pmic: add again the quirk to skip GPIO
 configuration on PM8550
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 16/10/2024 11:16, Neil Armstrong wrote:
> The qcom_pmic code is broken for new PMICs and should be fixed,
> without the QUIRK the code is broken and the GPIOs don't work
> anymore on SM8550 and SM8650 platforms.
> 
> Partially revert the revert and only add the quirk on the PM8550
> PMIC, making the buttons and MMC detect gpio work again.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

sorry, this slipped by somehow.
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index f2ef4e5ce14..cd9f3926ac4 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -69,6 +69,17 @@
>  #define REG_EN_CTL             0x46
>  #define REG_EN_CTL_ENABLE      (1 << 7)
>  
> +/**
> + * pmic_gpio_match_data - platform specific configuration
> + *
> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them.
> + * This is a workaround for an unknown bug on some platforms where trying to write the
> + * GPIO configuration registers causes the board to hang.
> + */
> +enum pmic_gpio_quirks {
> +	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> +};
> +
>  struct qcom_pmic_gpio_data {
>  	uint32_t pid; /* Peripheral ID on SPMI bus */
>  	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> @@ -117,8 +128,13 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
>  {
>  	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
>  	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
> +	ulong quirks = dev_get_driver_data(dev);
>  	int ret = 0;
>  
> +	/* Some PMICs don't like their GPIOs being configured */
> +	if (quirks & QCOM_PMIC_QUIRK_READONLY)
> +		return 0;
> +
>  	/* Disable the GPIO */
>  	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>  			      REG_EN_CTL_ENABLE, 0);
> @@ -262,6 +278,7 @@ static int qcom_gpio_bind(struct udevice *dev)
>  {
>  
>  	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	ulong quirks = dev_get_driver_data(dev);
>  	struct udevice *child;
>  	struct driver *drv;
>  	int ret;
> @@ -275,7 +292,7 @@ static int qcom_gpio_bind(struct udevice *dev)
>  	/* Bind the GPIO driver as a child of the PMIC. */
>  	ret = device_bind_with_driver_data(dev, drv,
>  					   dev->name,
> -					   0, dev_ofnode(dev), &child);
> +					   quirks, dev_ofnode(dev), &child);
>  	if (ret)
>  		return log_msg_ret("bind", ret);
>  
> @@ -348,7 +365,7 @@ static const struct udevice_id qcom_gpio_ids[] = {
>  	{ .compatible = "qcom,pms405-gpio" },
>  	{ .compatible = "qcom,pm6125-gpio" },
>  	{ .compatible = "qcom,pm8150-gpio" },
> -	{ .compatible = "qcom,pm8550-gpio" },
> +	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
>  	{ }
>  };
>  
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-qcom-pmic-re-add-quirk-75b24dd86849
> 
> Best regards,

-- 
// Caleb (they/them)

