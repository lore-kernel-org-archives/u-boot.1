Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9567FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F93387D9B;
	Tue, 12 Mar 2024 09:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JHgHmfnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5905287DE6; Tue, 12 Mar 2024 09:12:31 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC2D87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7dad8437347so2391811241.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231146; x=1710835946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnUXwwDvpGOt04rE6lzJqFZZDjlFge8w818EREGsMBo=;
 b=JHgHmfnTUHrBrezNWlXhmaxUNcmHUSvhdR3eO5eUF/eTVF4VMRuGHSvY70iMfvGeVp
 PaoWSM4+esjWuZkLcuFGXskEzXQbOmblg7yINjVSxA2RPHrBo2ef7GawN3xPuJ+z+jBc
 gQVBLshdj8AKtJyqwWU6rC+fVOrJYbVvWaxs8oJGcIOQ/VfbBfWwnoMKaSK6UOenhy4u
 kZHkFcU80BHND0cgUUpo+t7ctPBAC9NFDv4kMMpOpS5XFNVnUiPHqu7XBBEOMIdYaJx/
 S+JUMJ+9DfGrOEW/3TsP40NT1TqW8UGE3dlYUl1B5OoFQCSvqFEO1UFVfY57F5dEe8qF
 06wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231146; x=1710835946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZnUXwwDvpGOt04rE6lzJqFZZDjlFge8w818EREGsMBo=;
 b=O0vIiOnvO+g12KQeedJbGioqLKEh1Eah+9jzYFlpD2sc0BDZFFWNMk4e9D+pRJjQAX
 IsM1RWOdmRy73nSNBwu2bzCDNlOSdSCJqZmomj8g7RYex7rIZqvOphD68wQZWl5Gr+Zr
 63WPF3/qjZTl5qEfrLhrUptSFK+zork181B8dFs6zbuAFFHP5BQBhiU5DytxBGgOPMPA
 kVMSwq6FbFaLyHSMmfY25bVMDukJTzihW5oIF6QfHu6A159XBI2vIj9Z/3QcBmZPdxE5
 tjN0Y5DVGdvknqcYnVCeRBj91G7NDEfekFmRvDR6Zq0UbxCpZtlMICUrICq9pHpneg19
 AmVg==
X-Gm-Message-State: AOJu0Yxw2JtNzb+tdKU4r4U/CtwKIpdzCB/pHj+5zZPbEzyGZBLZsTH0
 SeiKaw1j89QTqi2MCUyLguwXqQbqGJQoeRekgtMkienBoBLUSRjeWRSye8KjPMjf5k2yz8jwPj/
 HqTsp09eC/x40jPMgCq1/Y5B1Annuy5ILjwVmMA==
X-Google-Smtp-Source: AGHT+IHgqhDq3W81ShBkx54a3uBPv83EIQ4ojSoeTgqG/rGKWeChhHtCVztX0rs8UDWacuE7/CiGBTzlC9+EtPC7bVk=
X-Received: by 2002:a67:f6da:0:b0:473:3801:e113 with SMTP id
 v26-20020a67f6da000000b004733801e113mr984843vso.23.1710231145736; Tue, 12 Mar
 2024 01:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-5-sumit.garg@linaro.org>
 <6711f465-05a2-4132-866d-40962016287d@linaro.org>
In-Reply-To: <6711f465-05a2-4132-866d-40962016287d@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 13:42:14 +0530
Message-ID: <CAFA6WYP_nZ2KqRSRcuSqg0XXcmcbJa7nUYFhce1dKK1rQKNiKw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: qcom: Add support for driving GPIO pins
 output
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
 stephan@gerhold.net
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

On Mon, 11 Mar 2024 at 18:07, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 11/03/2024 11:10, Sumit Garg wrote:
> > Add support for driving the GPIO pins as output low or high.
>
> Ohh, this is why it was never working for me >,<

Yeah you only implemented it for PMIC GPIOs.

> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
> >  drivers/pinctrl/qcom/pinctrl-qcom.c    | 26 +++++++++++++++++++++-----
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > index cb0e2227079..04b501c563d 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> > @@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
> >  };
> >
> >  static const struct pinctrl_function msm_pinctrl_functions[] = {
> > +     {"gpio", 0},
> Please split this into a separate patch.

Okay I can do that.

> >       {"blsp_uart1", 2},
> >       {"blsp_uart2", 2},
> >  };
> > diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> > index ee0624df296..932be7c4840 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> > @@ -29,15 +29,25 @@ struct msm_pinctrl_priv {
> >  #define GPIO_CONFIG_REG(priv, x) \
> >       (qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
> >
> > -#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
> > -#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
> > -#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
> > -#define TLMM_GPIO_DISABLE BIT(9)
> > +#define GPIO_IN_OUT_REG(priv, x) \
> > +     (GPIO_CONFIG_REG(priv, x) + 0x4)
> > +
> > +#define TLMM_GPIO_PULL_MASK  GENMASK(1, 0)
> > +#define TLMM_FUNC_SEL_MASK   GENMASK(5, 2)
> > +#define TLMM_DRV_STRENGTH_MASK       GENMASK(8, 6)
> > +#define TLMM_GPIO_OUTPUT_MASK        BIT(1)
> > +#define TLMM_GPIO_OE_MASK    BIT(9)
> > +
> > +/* GPIO_IN_OUT register shifts. */
> > +#define GPIO_IN          0
> > +#define GPIO_OUT         1
> Are there two separate bits?

Yeah these are two separate bits. I can rename them as GPIO_IN_SHIFT
and GPIO_OUT_SHIFT if that is more clear.

> GPIO_IN is never used?

Okay I can drop it as it is very unlikely for the pinctrl driver to
read GPIO value.

> Maybe just define
> GPIO_OUT as BIT(0) instead?
> >
> >  static const struct pinconf_param msm_conf_params[] = {
> >       { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
> >       { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
> >       { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
> > +     { "output-high", PIN_CONFIG_OUTPUT, 1, },
> > +     { "output-low", PIN_CONFIG_OUTPUT, 0, },
> >  };
> >
> >  static int msm_get_functions_count(struct udevice *dev)
> > @@ -89,7 +99,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
> >               return 0;
> >
> >       clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> > -                     TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
> > +                     TLMM_FUNC_SEL_MASK | TLMM_GPIO_OE_MASK,
> >                       priv->data->get_function_mux(func_selector) << 2);
> >       return 0;
> >  }
> > @@ -117,6 +127,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> >               clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> >                               TLMM_GPIO_PULL_MASK, argument);
> >               break;
> > +     case PIN_CONFIG_OUTPUT:
> > +             writel(argument << GPIO_OUT,
> Then this can be "argument ? GPIO_OUT : GPIO_IN" which feels much
> cleaner. Or even just !!argument if it's bit 0.

No, here GPIO_OUT is rather a shift for the output bit and "argument"
is the value to be written. As above I can change it to "argument <<
GPIO_OUT_SHIFT" to be more clear.

-Sumit

> > +                    priv->base + GPIO_IN_OUT_REG(priv, pin_selector));
> > +             setbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
> > +                          TLMM_GPIO_OE_MASK);
> > +             break;
> >       default:
> >               return 0;
> >       }
>
> --
> // Caleb (they/them)
