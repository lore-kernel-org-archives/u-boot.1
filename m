Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD1C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C3E8858B;
	Wed, 29 May 2024 08:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fnG0qwbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC12885E7; Wed, 29 May 2024 08:46:33 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81522882B4
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-804efaaae87so597618241.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716965190; x=1717569990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CGmZ08NOHEg5eq445lHmQBhjvNvEjWo+QasCEPpkqQg=;
 b=fnG0qwbKRcW+PvFjU37HX5dVyOqfAgwmGudicHpNAebXzyLpG8bVvXFlUOslr38bli
 MiajnQDdHBCveU9XZmLzI/CIDnmshDV+m6ufHgqDASK4OxXDPEejoLIiqCS2qVWsbNei
 5DRLpjpPclbNVGHFoRtSiDovCE1wDn9Kh1xW7Uc/fVaLAgnJh60zLqNxmZILUQyLqu02
 Ay85n00e8xrjwLCSt3yUmSPFlMX00FuxtBpgWezuepN1d33W2MoOYf9UL0ZPKoy6K1D0
 Zcxi3V7j1/xMABVMcyyo2YXysKUO8igZgJeIe91S9ikZ88D+8vuPGgOtlp4b6NNePjkX
 OEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965190; x=1717569990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGmZ08NOHEg5eq445lHmQBhjvNvEjWo+QasCEPpkqQg=;
 b=eKXax6jWZrJftS7dV0wDu2ytBsOFRnxYHo9rxUqECqZeGoiG2hfiiwiGza12+xuTZ3
 V5ysZCM5NhhrLU4JvwZSVBcsuIuIlFmZ5eL80gOob2gpTd2jncAc1QyorNGyJ1PDFAgi
 68nMBNzjYSmInS17p80Q5Y0pfIqn4a7WGjw4eMViGcIOZ3T/etHphWUDsfKy+E6ietae
 +12ednCsecsupXZr/TochIf0fb7fKNVW5zNkrruJl6vvr1AaViHPMZIcjmJQVtyAW0zE
 6cK6IlyyiH8zWyweY645ULVH+sxyJC30bocloeuN66Iv5ThVkBSBFoJbSufzfvakPMoP
 Qq/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZG5E2R5461IsfYaJQ2uwbVZ67X6SmNRPIrnY1dZRF8KP6jp0JIkGNv0N1cdYIn+BVgcoz7AsPoMTheLHAiDvgbuO1A==
X-Gm-Message-State: AOJu0YyNWDCJOYus0iCOOOXjKOWy8Nf8pcyme4C20QBRrBTtmFve8j3m
 kP5dk4yulL6c5gZ17m5LJM/YsHCruF9D5GCem8Gy8qvFDECYXyLzdfe/8qiyObsyx9Yg/Xz6o/T
 SctQBKWd4py1rTeNt4cWQfeBuh625pJ4LepW3Cg==
X-Google-Smtp-Source: AGHT+IGjvx7U3eaW4KYb5F2Lqe3V3CHY1WMjaka40fgLKIV9n8UBi9OVwYPmSWiAm0PU3oXPwms2xGGCtZLMdG2JONU=
X-Received: by 2002:a05:6102:3958:b0:48b:92ee:371d with SMTP id
 ada2fe7eead31-48b92ee38c3mr3187178137.31.1716965190253; Tue, 28 May 2024
 23:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-5-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-5-54d1e9ad7dfa@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 12:16:19 +0530
Message-ID: <CAFA6WYP5X_8TF-kkkY_GgwrGpBP_7HVetGsD7yzCCsf3q=_tLQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: qcom: sm8650: add special pins pins
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
> of the UFS and SDCard pins on the SM8650 SoC.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm8650.c | 42 ++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
> index d6cc1bbdda8..58fc94e71ac 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8650.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
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
> +       [0] = UFS_RESET("ufs_reset", 0xde004, 0xdf000),
> +       [1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xd6000, 14, 6),
> +       [2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xd6000, 11, 3),
> +       [3] = SDC_QDSD_PINGROUP("sdc2_data", 0xd6000, 9, 0),
> +};
> +
>  static const char *sm8650_get_function_name(struct udevice *dev,
>                                                  unsigned int selector)
>  {
> @@ -27,15 +58,9 @@ static const char *sm8650_get_function_name(struct udevice *dev,
>  static const char *sm8650_get_pin_name(struct udevice *dev,
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
> @@ -52,6 +77,7 @@ static struct msm_pinctrl_data sm8650_data = {
>         .pin_data = {
>                 .pin_count = 214,
>                 .special_pins_start = 210,
> +               .special_pins_data = msm_special_pins_data,
>         },
>         .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>         .get_function_name = sm8650_get_function_name,
>
> --
> 2.34.1
>
