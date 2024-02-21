Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E163C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 09:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E6787903;
	Wed, 21 Feb 2024 10:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JRBvzhe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F4F87903; Wed, 21 Feb 2024 10:37:04 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB238792C
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 10:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47047e7b068so379969137.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 01:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708508215; x=1709113015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZ/bAF3LPTRThuuy5o/KWmN5C/6FTwD83fPrCfhZF+g=;
 b=JRBvzhe9tsA3zRjUreN/VKNMVUq1IY1zRXaIOoNEhGVC4swaHKYxCD4N2x07NBfnu/
 SnLbkBrYC56a9h9jXs1oNO0lNx/+qFzP+kPaIYZT53N5Yd3Rb2GC7cebbbA9OobidgND
 FiRSYqXI1ozhC2f8D9E7YhC+wm3fEq7HTjZdI5XiJ45WmdhcowxLnnwNU6GLwEjUHtKf
 QyX1MQNOzGWPxTvYY22UvrLBhN8fuKm9+D2AF5kMrK8svuOGm9hXCACvmDRDVlTHGBY8
 WxVHkMdWRhf5zeWCG/dXrr8GrspK1eUgsPSMoMZIz1aYUBSAtBnrDAplGedkuo9GXWqg
 AJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708508215; x=1709113015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZ/bAF3LPTRThuuy5o/KWmN5C/6FTwD83fPrCfhZF+g=;
 b=RnOUuSPdNLEGPcEEYQ351KxNyQBkuO+cO2sa3pvjse9Y4/zJ84Biv/Iz5r5uuAPD/p
 bOsMmetsxvhqemftcXdPX+GEjO1A0C9kzjO7tktsPtLgkRUJ72xE3grwDNFV/FxG33aS
 Hz0D9Wbz7jbGEK0e40+PxTOylIN5YmzbZPVOLqddOZnxr76/zBe6pqoyT8mqKzrjx5jr
 N5NxLrPKoXBXuvtOLnusvuhdqOC/BJaXzfv7e5xpworXeSgXDOIazuiQOI+li/NgdBYG
 Qxs0dxqhkFyKk9dNTXhwhlUjm8mmS9HZJxtAqNeau0/oVmo6Zmc8yrGh6iBhV+cUveN2
 eOUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYxjNeAN7iyfBBqXsfXKGdL9G5X7gszA+S+pUxmPTHVyBacIg6YT2LlSF+61TuKPvoONHLQb3w9w0Fmb0mmpXyqrqKbQ==
X-Gm-Message-State: AOJu0YzwzplDIZfk24rjg35jqryoxj3MC6d2twGbcZr1FsnVcEqr925Z
 K1DFdN65pmJQxM/Y/Byc2F+Fi7me22B0eB0oEgQ2qrMf7STbXhDZmb+s2Bstu9+k+BFdsZBOPSm
 nGr5nCDAgMEaK2z09n5HdS9VoTbI8A+Si3rt5fA==
X-Google-Smtp-Source: AGHT+IEX+CfZwBns2GIKUVAorD2qecyp1ZOrGWjDojsuNJZzdPmdnY9vfNf4h4JBuu6ZTgOwlC/CzMH43J5cBtD4Oq4=
X-Received: by 2002:a05:6102:3586:b0:470:735d:4605 with SMTP id
 h6-20020a056102358600b00470735d4605mr3888350vsu.23.1708508214983; Wed, 21 Feb
 2024 01:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-10-ed06355c634a@linaro.org>
 <CAFA6WYN9JZPO6OjfMOVj6qHRK7fp+5aVCth3ppAMv1L8xNypXA@mail.gmail.com>
 <3e808365-e994-4f55-82b8-c13f1a8e99b8@linaro.org>
In-Reply-To: <3e808365-e994-4f55-82b8-c13f1a8e99b8@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 15:06:43 +0530
Message-ID: <CAFA6WYMWq3Lc-XGiCCq_C=ttTcO=YWEyGPDM+ocNfHf43jPKpA@mail.gmail.com>
Subject: Re: [PATCH v4 10/39] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
To: neil.armstrong@linaro.org
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
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

On Wed, 21 Feb 2024 at 14:19, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 20/02/2024 06:56, Sumit Garg wrote:
> > On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Some platforms hard reset when attempting to configure PMIC GPIOs. Add
> >> support for quirks specified in match data with a single quirk to skip
> >> this configuration. We rely on the GPIO already be configured correctly,
> >> which is always the case for volume up (the only current user of these
> >> GPIOs).
> >
> > I can't find a similar quirk in the counterpart Linux driver
> > (drivers/pinctrl/qcom/pinctrl-spmi-gpio.c). Is there anything we are
> > missing in the U-Boot driver?
>
> It's not ideal, it's fine to have it at first but at some point a proper
> solution should be found.

Then at least let's add code comments to say that it is just a
workaround for the time being until a proper solution is found.

-Sumit

>
> Neil
>
> >
> > -Sumit
> >
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
> >>   1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> >> index 2a4fef8d28cb..198cd84bc31e 100644
> >> --- a/drivers/gpio/qcom_pmic_gpio.c
> >> +++ b/drivers/gpio/qcom_pmic_gpio.c
> >> @@ -64,6 +64,15 @@
> >>   #define REG_EN_CTL             0x46
> >>   #define REG_EN_CTL_ENABLE      (1 << 7)
> >>
> >> +/**
> >> + * pmic_gpio_match_data - platform specific configuration
> >> + *
> >> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them
> >> + */
> >> +enum pmic_gpio_quirks {
> >> +       QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> >> +};
> >> +
> >>   struct qcom_gpio_bank {
> >>          uint32_t pid; /* Peripheral ID on SPMI bus */
> >>          bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> >> @@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
> >>          struct qcom_gpio_bank *priv = dev_get_priv(dev);
> >>          uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
> >>          uint32_t reg_ctl_val;
> >> -       int ret;
> >> +       ulong quirks = dev_get_driver_data(dev);
> >> +       int ret = 0;
> >> +
> >> +       /* Some PMICs don't like their GPIOs being configured */
> >> +       if (quirks & QCOM_PMIC_QUIRK_READONLY)
> >> +               return 0;
> >>
> >>          /* Disable the GPIO */
> >>          ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
> >> @@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
> >>   static const struct udevice_id qcom_gpio_ids[] = {
> >>          { .compatible = "qcom,pm8916-gpio" },
> >>          { .compatible = "qcom,pm8994-gpio" },   /* 22 GPIO's */
> >> -       { .compatible = "qcom,pm8998-gpio" },
> >> +       { .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
> >>          { .compatible = "qcom,pms405-gpio" },
> >>          { }
> >>   };
> >>
> >> --
> >> 2.43.1
> >>
