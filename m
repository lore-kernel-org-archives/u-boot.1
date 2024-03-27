Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434EC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D38C88085;
	Wed, 27 Mar 2024 15:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ixerzk7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5B2880AE; Wed, 27 Mar 2024 15:44:20 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A7B88069
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d4979cd8c8so9958471fa.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711550657; x=1712155457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hw1hWg/oBQIjIE6tL5VWYGnhi9DUScQ0QyE4Rb/UYZI=;
 b=ixerzk7wa1TEPWX8aNhut6zBR9YFgfN9q8GBMs6NzYyrQL6tSQtMj7glCWXfLHHgVR
 c+heEaDsYT6AA8niCN4xamUR3MGsUcjw0/c4tSD5wy3ddV1VgVT/89m+n9yHaTxojUX4
 wB9C0PJnGgHUpkRcLxkag4Z9YyEohn5oernsRwRm2VhqjFp/b/tTBWuWpWB3QIs+SKrY
 qjwe5eiPwSNh9jZehWlXN/n5lTqUHdJyFFutQZpDOlstyEilw0r1DNTYa0eSEgQ+xa97
 CqDpDRnMeC6GOCz59C/vkTu8OS3IDAHm6zSMSabnpUhyT7Ia5ptw8iCJOZsmnNBz36+s
 RWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711550657; x=1712155457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hw1hWg/oBQIjIE6tL5VWYGnhi9DUScQ0QyE4Rb/UYZI=;
 b=UHDTeB2e+Uj3LfnvC3KpVT7iEDnk2MneYnFRSzhvBqy+sG44XgSYxQPx3PqhERRsCE
 hhHDSXX02MSRvFagHf5HizU2m231SiCxP8IwPhLPzi6J3cWxh7X5fKUNPK+mLABwXpIM
 CVvllcT9zgfpScRr/ngfC93maXor3tSCnsyuB0n6JlVN+zEQNRrJXBFkarupsXudN2+C
 q/APD3ExoPOs1TFoqqd5DCRZiu+5z/eDLcKlHzBqRWlbxHUyeNPMv06cgSVcitvjsxNJ
 Ect7Lv2A/IB432GJQfTm9wH3QqZq8r7pbXKJUy35r6eUXo9/nMtwQ/UB5wH0G9FncJ00
 saVg==
X-Gm-Message-State: AOJu0Yy0plk9pnGeKz+YWnviXRiy6ixDj7danxgGjfXciP8sFPSQ0LKa
 V0Jwl2EP1yyWpYa2ZnPwlUSaRj5rKbxMrqDcR+krUH0fACDmd1npkTMCTKUUmp56+J+6cq5v/w8
 H1l0yQKTE67XyoVu109lqzIcs4J2hjtoWcIgR7la7vgbiI8GK
X-Google-Smtp-Source: AGHT+IHDjIiwO9qf147xVDojMoKBsJOkz8XJM/hcuvWAvsDG0NAdlsIzQx9/iOYgbIaFQGpQabzw4LkoEYyCZM1t1mg=
X-Received: by 2002:a2e:990c:0:b0:2d4:535a:e7a with SMTP id
 v12-20020a2e990c000000b002d4535a0e7amr39796lji.24.1711550657334; Wed, 27 Mar
 2024 07:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
In-Reply-To: <20240321180219.1039622-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 16:43:41 +0200
Message-ID: <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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

Hi Tim,

On Thu, 21 Mar 2024 at 20:02, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Instead of displaying what looks like an error message if a
> gpio-reset dt prop is missing for a TPM dipslay a more
> informative message about resetting the TPM if the gpio is found:
>
> before:
> tpm_tis_spi_probe: missing reset GPIO
>
> after:
> tpm@0: performing 1ms reset on gpio@30210000:12
>
> Note that the reset dt binding prop used in this driver is not
> dt-compliant; it does not exist in the Linux dt-bindings documentation
> and the reset is not done by the Linux driver.

Probably for a good reason. You aren't supposed to be able to reset a
TPM without resetting the CPUI as well no?
That being said, printing that the TPM was reset is pointless imho.
OTOH the existing error message at least points out a potential
problem in the DT.

Thanks
/Ilias
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index de9cf8f21e07..944540f7a711 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>                         /* legacy reset */
>                         ret = gpio_request_by_name(dev, "gpio-reset", 0,
>                                                    &reset_gpio, GPIOD_IS_OUT);
> -                       if (ret) {
> -                               log(LOGC_NONE, LOGL_NOTICE,
> -                                   "%s: missing reset GPIO\n", __func__);
> +                       if (ret)
>                                 goto init;
> -                       }
>                         log(LOGC_NONE, LOGL_NOTICE,
>                             "%s: gpio-reset is deprecated\n", __func__);
>                 }
> +               log(LOGC_NONE, LOGL_NOTICE,
> +                   "%s: performing 1ms reset on %s:%d\n", dev->name,
> +                   reset_gpio.dev->name, reset_gpio.offset);
>                 dm_gpio_set_value(&reset_gpio, 1);
>                 mdelay(1);
>                 dm_gpio_set_value(&reset_gpio, 0);
> --
> 2.25.1
>
