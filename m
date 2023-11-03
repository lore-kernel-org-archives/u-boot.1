Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336FBC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 07:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C2287665;
	Fri,  3 Nov 2023 08:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dAWe1oKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ECC686F69; Fri,  3 Nov 2023 08:19:01 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7C087666
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 08:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-457e5dec94dso825435137.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698995933; x=1699600733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v6QzS+ve0MrP/SRODnXECfIVeZjhaYdRCyoNJTIuf7U=;
 b=dAWe1oKaJ3FLxKD7KgIn+QGW+h2fM1a0WybZlJxiyUdQ5UP6D9PkxOxVvA/eRu6r9F
 fBuLkvHQc1p0KmG3o3oaUP9yCx3Quy600NVWuFidzzQCjrjfTsNUa42Fv4gPAP0zMq/+
 8Q3Ue7jHM1T7seC4t6F/P5rdIUDPMl9xAFKmu6dWNhCjm9G4xMc+hdw5X3uIy9pFc8fO
 ItQ5HtshDJ8g66kyKKEgpa2sAELDCRmS890RAOPMmpkYkwMFlrgTZY4Gqqs+8visN3sS
 iU0oDPM7Ipg/3WwhnWxDi1+vHgYKE71kMxwGdH4BAd+mPsQyzemU7Ul3tYs31gJoe2Is
 50ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698995933; x=1699600733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v6QzS+ve0MrP/SRODnXECfIVeZjhaYdRCyoNJTIuf7U=;
 b=QCkyj+uMUEO7BCIcla5f1p43qSumya2kt79iQiGq1uVQOOV+7YKtAMqORSbj1lHsrq
 Fe/p6RAN1tBVyYVW03a+hHCjaxSMQSon5m3jQejZklahpnjrNCTt9/2pnc0osKw/AtMJ
 HO7xOihaNkcaaV+D+iR18c06h4PScNGjxY6TM4sGBTIV78e1Y89x7d8HxqqmjXotYUyE
 5LpyRDXs3FCfW40b/erkC0FwUHqeoRcAyocl5uRQ7+O3nYrDE5MDbfdJPFpINppbfhq0
 RFXmKydd4ZmfkjeqW76UsJo++nKStsY4mT/xgeHf2On54K+RcUWXAQRbv60ZvdIV4QNQ
 3KLg==
X-Gm-Message-State: AOJu0Ywn/GEfQn42yfLj1AMgCsXffr/Uzn72s4Zxq9o4T22dCUSEFMYX
 d7FR860nIFYeZt1OGXZmR5iJMewtcvVZPRMPbWKgOQ==
X-Google-Smtp-Source: AGHT+IG00jCkog+V6FbS7pl4SNZSSksPToAet1LWqOnAPKZh/oYEKk2MQkAjvcmQXQVZamhMVb1dk/Udb4bg6wzBS8U=
X-Received: by 2002:a67:a64a:0:b0:44d:4d5f:79a4 with SMTP id
 r10-20020a67a64a000000b0044d4d5f79a4mr19804584vsh.20.1698995933615; Fri, 03
 Nov 2023 00:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-b4-qcom-pinctrl-v1-0-9123d6a217eb@linaro.org>
 <20231025-b4-qcom-pinctrl-v1-4-9123d6a217eb@linaro.org>
In-Reply-To: <20231025-b4-qcom-pinctrl-v1-4-9123d6a217eb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 3 Nov 2023 12:48:42 +0530
Message-ID: <CAFA6WYNWzsoOP6Av1q_+X0gxMFPa9E8S84BqWyynwVV30_9ehQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] msm_qcom: use unsigned int
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 31 Oct 2023 at 19:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Replaces the uses of "unsigned" with "unsigned int".
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/msm_gpio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 7a09abdafb2e..7d01fecf46f2 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -49,7 +49,7 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
>         return 0;
>  }
>
> -static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
> +static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> @@ -63,7 +63,7 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
>         return 0;
>  }
>
> -static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
> +static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
>                                      int value)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
> @@ -81,7 +81,7 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
>         return 0;
>  }
>
> -static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
> +static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
> @@ -91,7 +91,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
>         return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
>  }
>
> -static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
> +static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
>  {
>         struct msm_gpio_bank *priv = dev_get_priv(dev);
>
>
> --
> 2.42.0
>
