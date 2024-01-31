Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2021C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8088745E;
	Wed, 31 Jan 2024 16:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IDFAI4oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAFF8745E; Wed, 31 Jan 2024 16:35:16 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD7D87441
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40faff092a2so12664215e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706715313; x=1707320113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=varB8Z9vwyNZpbOjnc+DhRTHW54W52QkS/b2zAVDtC8=;
 b=IDFAI4oarZCVgDxhH5SuspYes3Bc+GBzTiDIuxsT5TEJOmNK8yELgqLpGguFn4+3J/
 7Qlrz2Ni0kODiJ3lPEzYxMyhTNgmTVe3ryc1zOkrnq64TPXB+WSnZKbDp87ao56OS+cr
 hyLveiwfMLZvwO9V+vKcJcR3F2tW5IdQIBFcnY9kT+Zq/Xe/CvHGOcmBeyBDbSbxdtgB
 BhEmQ5Y6FDmzskuvSNAyqi14xq39Cv7qoqcgmIlwhTQaljzCZUOdHhV+FqIdpKgiRZGU
 diM9lqfSjUZ0N4Pw4JgkI8p+/DHT1uEmioOclblJSxUc+0hO0gYLXWNBWeOq2MT0b1Cl
 uyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706715313; x=1707320113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=varB8Z9vwyNZpbOjnc+DhRTHW54W52QkS/b2zAVDtC8=;
 b=FYqtSGvTpFJDIgmxp/+nRA+2HFPYE29Ox9yARPSWDAb5K4NdLUGx1/SE9iRvDbi3vX
 +NSbyrDmikpnYV6eVKS0Uk2mcnNTY5fNhHQ57+bst73qhNxtp3CUlDZOvIfmfRab7Ro7
 /H4cQvMpOMqh5WPWy0d91WMsZulOZHaHux9IbFpp2iBCkzeU+LM8FV0oys/Du9Mn6uUY
 NTVpmBO8cHnRJDRAbckE3/wsELvEfbIJ3jROtNWIF2SzlORmct3po5+RwdocH+3joHkW
 uI364fl6zs/l9pED5y89981jydzzdJn18bC2eI6muFD1x3H1KgEyu7GCXOttATYbxsmW
 oosg==
X-Gm-Message-State: AOJu0YwEww++kzLZln0U55LiJD1F9heh7LmDzyMlBPZx94OAf8IXHeU4
 O6Bw4kXaP4bJ99nTAVsNHxdWoEpNtONwISOerwgLnmVVXFtTnMCFb6MEedgYgEo=
X-Google-Smtp-Source: AGHT+IHrey19PY2HbVKfWrCKFHbFIAtazmOccki1mqLSgAeVIkWOotBqD9BtEf0aCkonppsIZoSKcA==
X-Received: by 2002:a05:600c:1912:b0:40e:b4a0:277b with SMTP id
 j18-20020a05600c191200b0040eb4a0277bmr1506376wmq.39.1706715312933; 
 Wed, 31 Jan 2024 07:35:12 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c4fc700b0040fb44a9288sm1922885wmq.48.2024.01.31.07.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:35:12 -0800 (PST)
Date: Wed, 31 Jan 2024 18:35:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 07/13] gpio: msm_gpio: add .set_flags op
Message-ID: <db08ffb8-fb64-4e19-ab0d-4f5603d51ca6@moroto.mountain>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
 <20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org>
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

On Wed, Jan 31, 2024 at 03:16:59PM +0000, Caleb Connolly wrote:
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 80cd28bb231f..0230305af299 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -72,6 +72,23 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>  	return 0;
>  }
>  
> +static int msm_gpio_set_flags(struct udevice *dev, unsigned int gpio, ulong flags)
> +{
> +	if (flags & GPIOD_IS_OUT_ACTIVE) {
> +		return msm_gpio_direction_output(dev, gpio, 1);
> +	} else if (flags & GPIOD_IS_OUT) {
> +		return msm_gpio_direction_output(dev, gpio, 0);
> +	} else if (flags & GPIOD_IS_IN) {
> +		return msm_gpio_direction_input(dev, gpio);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> +		if (flags & GPIOD_PULL_UP)
> +			return msm_gpio_set_value(dev, gpio, 1);
> +		else if (flags & GPIOD_PULL_DOWN)
> +			return msm_gpio_set_value(dev, gpio, 0);

These lines are unreachable code.

> +	}
> +
> +	return 0;
> +}

regards,
dan carpenter

