Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750DDC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0101488349;
	Wed, 29 May 2024 08:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+P8kigH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84CB883BA; Wed, 29 May 2024 08:46:14 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DBE882B4
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-48ba7c1f26cso18305137.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716965171; x=1717569971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iu5i5d96F/zUIE8OvOsAaiHk3wmIA5oDVyjk7DPP4Y4=;
 b=y+P8kigHF08j8nRtNDSF68zg4POIQMh0RT9qYXlpX3w8OwZxTNLnCPVtLyOQMlTD5k
 QfVbN3pF6DTGCvaKkOFHXx+iG9MPvV36Ez8XHZj55OnYXU8yeXhCTmTGwNS6+5GJ1nlT
 QPxMBZJARCmo4QWWRSfu+SLIO4/FdzUFjwqFdxyhAu8RG0A3TryErGQDXmhwqrl+LtR+
 O2zKZBBPBoWShKtR+dqiTdhrTkPL/C/2n66VJ24LOEK0A0WYxvQxaoOPEDHBre7UNCMv
 Z3QZlX7/R4yFHfinvlVVEVFrqL/Ow/Dn5MWQG/o8Fe8ScHdthZB9bxXrrxn0V3AuO3fF
 aVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965171; x=1717569971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iu5i5d96F/zUIE8OvOsAaiHk3wmIA5oDVyjk7DPP4Y4=;
 b=Cj3qP3pA1BDqWqJaU+jWl6nGuXKzNwbfJ0IbuzbVryahKtX9DGeeQwKwvIVF+qVVob
 EAhYavd5gMhosPm/gmDV+j/5igvaH++vKWsbWQD1Uh7U5L/a0GTijRTUA9BQ9YovryLI
 HxfuFiQKkCNKwiekYyUkjR4VoNVKFfl8I8xf/mVFrN/rxr7rV65jzZ6v0eFNMXq9ZHGa
 2i4NC0ahAm4DBcIeSrV3UTSSAxWMaetJEdimP1bFXx5q+JYlHzdrpVQkvp6gEIVbrkyL
 4YzUnvTmVPe1o4eJSfhaWwgLZhXd5j6K5TJ28+vT5z+I92GtFYkYIAKtYvlh0l/XSvgB
 qvuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXvMYSmhQqAx8h1CZFvKcKSCmAL4ZlFXHX7yeNWM7KLuajE5OVWkkLIoVOSAuxwx/vrj+SPe3S5N538pNMv2c8SqXnMg==
X-Gm-Message-State: AOJu0Yzyo8YKLho625dCtNiHUqCCaovfL+z2NUElAs5CgT3na1SBjRHV
 ITekzeGktuFPgZ9ZLTv5Ds58ZUjTR47eC0VTAXOPbmwRFJmmKhokeTA0E+mhUu5PgJhY9hx/E8B
 zRc9ihEi1EYeq3RT62zB8d5L5pZkI74m+CDWOaQ==
X-Google-Smtp-Source: AGHT+IFUDyHIkLJSstdsH7+nvYaOU+6yQc8YKOD0ICdJOtzOm3i6hLEnONx6/xn5WHgN26tpsL9SvAHMwtoLpe2Gkug=
X-Received: by 2002:a05:6102:2369:b0:48b:9e58:df87 with SMTP id
 ada2fe7eead31-48b9e58dfe4mr805158137.27.1716965171558; Tue, 28 May 2024
 23:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-4-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-4-54d1e9ad7dfa@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 12:16:00 +0530
Message-ID: <CAFA6WYMHLaz+Lf_e8CyKC1nSJVZhnjGrox33FS2vxS+c6TDDGQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: qcom: sm8550: add special pins pins
 configuration data
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 14:02, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add the special pins configuration data to allow setup the bias
> of the UFS and SDCard pins on the SM8550 SoC.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm8550.c | 42 ++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> index 7265cb73404..c65dfe0435e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> @@ -18,6 +18,37 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>         {"gpio", 0},
>  };
>
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)     \
> +       {                                               \
> +               .name = pg_name,                        \
> +               .ctl_reg = ctl,                         \
> +               .io_reg = 0,                            \
> +               .pull_bit = pull,                       \
> +               .drv_bit = drv,                         \
> +               .oe_bit = -1,                           \
> +               .in_bit = -1,                           \
> +               .out_bit = -1,                          \
> +       }
> +
> +#define UFS_RESET(pg_name, ctl, io)                    \
> +       {                                               \
> +               .name = pg_name,                        \
> +               .ctl_reg = ctl,                         \
> +               .io_reg = io,                           \
> +               .pull_bit = 3,                          \
> +               .drv_bit = 0,                           \
> +               .oe_bit = -1,                           \
> +               .in_bit = -1,                           \
> +               .out_bit = 0,                           \
> +       }
> +
> +static const struct msm_special_pin_data msm_special_pins_data[] = {
> +       [0] = UFS_RESET("ufs_reset", 0xde000, 0xde004),
> +       [1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xd6000, 14, 6),
> +       [2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xd6000, 11, 3),
> +       [3] = SDC_QDSD_PINGROUP("sdc2_data", 0xd6000, 9, 0),
> +};
> +
>  static const char *sm8550_get_function_name(struct udevice *dev,
>                                                  unsigned int selector)
>  {
> @@ -27,15 +58,9 @@ static const char *sm8550_get_function_name(struct udevice *dev,
>  static const char *sm8550_get_pin_name(struct udevice *dev,
>                                         unsigned int selector)
>  {
> -       static const char *special_pins_names[] = {
> -               "ufs_reset",
> -               "sdc2_clk",
> -               "sdc2_cmd",
> -               "sdc2_data",
> -       };
> -
>         if (selector >= 210 && selector <= 213)
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 210]);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN,
> +                        msm_special_pins_data[selector - 210].name);
>         else
>                 snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>
> @@ -52,6 +77,7 @@ static struct msm_pinctrl_data sm8550_data = {
>         .pin_data = {
>                 .pin_count = 214,
>                 .special_pins_start = 210,
> +               .special_pins_data = msm_special_pins_data,
>         },
>         .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>         .get_function_name = sm8550_get_function_name,
>
> --
> 2.34.1
>
