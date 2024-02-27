Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF26C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 05:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D466E83333;
	Tue, 27 Feb 2024 06:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t3TVrdYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E5B807EC; Tue, 27 Feb 2024 06:29:34 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1935187EFB
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 06:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57b9so1718721241.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 21:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709011768; x=1709616568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+2eTdZaVR1r41WXYpj32vXIEDMGj9etPTTQGhK6fps=;
 b=t3TVrdYe1mZGmh+c8f6+rZboGpqkw6A7fAeXAC4V2phAJB4eIKZQ8joBQaJpNlsp10
 LF1Ha+nHUGWTYO57zar+HU+v0vYK+uyKLGE4tOTMBrHMxB65YAbfIxfyzFrlHIxh+iQ3
 cbfuusSFlFW1NPD9T5E5L7zcialYut+sEwDTDowFmVHhDPTiDPpmKGWH7UE9gFMBak1S
 UZxo9V9L/fnrP4y1QVQIkmvLb3CuFORQF7hEH2VsQMcK2qNKoNSOYU6WySVk4rEVnYgv
 Xd94Be436FFBR0VG0jpt0BaQKbDij0D/DhHYJSwFkmYW3aGns6/3E8cBejppRmntYe5c
 QUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709011768; x=1709616568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+2eTdZaVR1r41WXYpj32vXIEDMGj9etPTTQGhK6fps=;
 b=ZBfhVgBEIx7AlJReNL0/+4nxWMzdMHnfDSzyEXBReMqba36Vr1AUh0gK3mhsJGZFMy
 MTpHoelOjuNM3Nj0wE3YTA9NYCCIRv3Q9DF7pCf9mK4/rEe6CMdW03ozEISwgi3isuHa
 xW0DOVHhQeXveVw7fHb2Wanxkvl4odwE7eWcP98n2fcj3EB9FyfjasxF4laSu2uI05KP
 +jPbgWQgrtSZUMdrDvTD9379o5vQFyCYWsCMQDtsDy8LJV9/v1HKPLwgPG4fiVHIDhYw
 mssuHvm28v1QoFsEQRw7MJujRD3WKgdI4uyq/w/XeiM5lrDoimdHvmAkzXVm2M+zw2V6
 2Rvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNrbbYqkOCo98QmwC5NBy5inL+0j7RuuJI1MAHds6yeSlEypjMoLoXRft7CMf89YTgrOy/D2poAy+aSjL3DbsY5xwr0w==
X-Gm-Message-State: AOJu0YwtJhYfrS+qBHmHOeLpoWIxZAMkizHJvYZWBU46/4+NR01fW3Yp
 BU7EmNH+EmZwl94FnljPCxlrZr8crf+hJgXy3wLCG5Gn75gs0wYQB6sq4K2lNRxGwoqYzRTwKOl
 eLMpEWRYszi5sVl2TgTr9jXzPaVtcjszV0L+ksw==
X-Google-Smtp-Source: AGHT+IFPBTkoKdP6kaDECKb78QEwnBUwkzgLjl1Wsi7Mg4RTz3sDBGSUeWZRtVQprTTe7nlKtpVpCqjuC4hyA0g/iq8=
X-Received: by 2002:a05:6102:3a46:b0:470:4c32:1522 with SMTP id
 c6-20020a0561023a4600b004704c321522mr4787229vsu.11.1709011768624; Mon, 26 Feb
 2024 21:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
 <20240226-b4-qcom-common-target-v5-10-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-10-10c8e078befb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Feb 2024 10:59:17 +0530
Message-ID: <CAFA6WYMGJ4jK+EUfJ1cFjro7rX=4Kgia+86tqfStCd+66BDbog@mail.gmail.com>
Subject: Re: [PATCH v5 10/39] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Mon, 26 Feb 2024 at 22:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Some platforms hard reset when attempting to configure PMIC GPIOs. Add
> support for quirks specified in match data with a single quirk to skip
> this configuration. We rely on the GPIO already be configured correctly,
> which is always the case for volume up (the only current user of these
> GPIOs).
>
> This is not expected behaviour but appears to be due to a U-Boot
> specific bug. This quirk at least allows for the volume buttons to be
> used on platforms where this bug is apparent.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 2a4fef8d28cb..63b512725ad9 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -63,8 +63,19 @@
>
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
> +       QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> +};
> +
>  struct qcom_gpio_bank {
>         uint32_t pid; /* Peripheral ID on SPMI bus */
>         bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
>  };
> @@ -74,9 +85,14 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
>  {
>         struct qcom_gpio_bank *priv = dev_get_priv(dev);
>         uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
>         uint32_t reg_ctl_val;
> -       int ret;
> +       ulong quirks = dev_get_driver_data(dev);
> +       int ret = 0;
> +
> +       /* Some PMICs don't like their GPIOs being configured */
> +       if (quirks & QCOM_PMIC_QUIRK_READONLY)
> +               return 0;
>
>         /* Disable the GPIO */
>         ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>                               REG_EN_CTL_ENABLE, 0);
> @@ -303,9 +319,9 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
>
>  static const struct udevice_id qcom_gpio_ids[] = {
>         { .compatible = "qcom,pm8916-gpio" },
>         { .compatible = "qcom,pm8994-gpio" },   /* 22 GPIO's */
> -       { .compatible = "qcom,pm8998-gpio" },
> +       { .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
>         { .compatible = "qcom,pms405-gpio" },
>         { }
>  };
>
>
> --
> 2.43.1
>
