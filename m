Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40263C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D41D8844E;
	Wed, 29 May 2024 08:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VsxXNUyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F71E885DB; Wed, 29 May 2024 08:45:19 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964138844E
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48a3995c90fso494596137.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716965115; x=1717569915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bbKt6OKpPwg6KPAdDNwcILWNfW2p//lZetpqWVu8urQ=;
 b=VsxXNUyRoZgIKkdL3/MCiHv3cfJ51zm/MjFLWty1IAe4erkBnTFXzb3muD4ynWVpmH
 GRGkd410IeUQmQFOeenpz83/ZfUbmDkw5Sz9AQQlXp0NvvcdK+/m8EpyyYGdy8lOQHYE
 8WB8aMI14aO0iZDBxF/PhXH7Z7IeNnF5bdN4yv4a/7bojrgw2gguUtpqXszfxP3vUGyi
 wskixXZQD5+tYBh+gu9aY7AoXwRRJNN+0JLZhCZ0XhOlG8EFZxFoIucTpJfaAIpLcoLA
 dkXsToMW4ekDq+9WuW9ilsNp6RngqDRSPJKTCNjYqGMAUZEmPXvRPrlkQX5wfjY1lfpC
 peOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965115; x=1717569915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bbKt6OKpPwg6KPAdDNwcILWNfW2p//lZetpqWVu8urQ=;
 b=JryVRaaFCh55VtLaNOI0sssZ+zG24hnGoqFSMKMhvi/7lvOz38YjJ6ItiEdLxvLoH9
 xjJCZvh02TsXV4h8EkHObsM4tHMpswoLs8QvvL61AI7tQHo9sAm7VX6rRDZjKBhleccJ
 Dnx2I+cIpf1ngbJbZ4YirbBPlC9NIS9n/a0uIGJg6MpjQ/X+7Cezb6haOXNwsqFATq+q
 U7KT9RaqKFXqNTJWBeea3i4chzTCPiGi7WqMd1uoiNsiTnx1FnpzN5H36mTMOFvdWhq2
 4LnUBeXL/AFWD5e5XHWMjwKuZH7mvVxFxoqWb+odkSJQ9J8/7uTvN7XRQucku3UIFEc4
 F5Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtkuTnZKhVOLeRuN66F3Jew5uwrlOfu0p24fBf3oDijHCgCTocWZcdGjn4ZfJ2T25xhRV6t9oZpRtFx+rU8VyIKx9s1w==
X-Gm-Message-State: AOJu0YwUxHwlG2wJIzX4SW88Z3vCDBOp58oo0QsfaOFefeyr4jYfQIoA
 px1ap1+yb6b4JU24C0KoMEF6pYtPcazwGp9Hwvw91d6Ug4TEwQJpnqejyFA6HscX0+RIVIXghZV
 HiPFhnXEnyrYx9a4e+OIhOU1Qql+Tihk11ie2EQ==
X-Google-Smtp-Source: AGHT+IEX/1/hpk5aYm2HQOCeWYZX3cUvr7DITZT6jw3CKt5GWIopRGTKKWBTzwmfgL6VSBPoS0otbzSqOmjOlRAvv8I=
X-Received: by 2002:a05:6102:2a54:b0:485:a004:37f0 with SMTP id
 ada2fe7eead31-48a386dc1camr14993269137.30.1716965113714; Tue, 28 May 2024
 23:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-3-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-3-54d1e9ad7dfa@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 12:15:02 +0530
Message-ID: <CAFA6WYPYxKB_AtVtSNuYyiu6++K5Jej6sR52OwFTWBoNB8Zkug@mail.gmail.com>
Subject: Re: [PATCH 3/5] pinctrl: qcom: add support setting pin configuration
 for special pins
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
> Use the previously introduced msm_special_pin_data to setup the special
> pins configuration if the SoC driver have them specified.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qcom.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index 4f4e9a83949..26a3fba194a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -103,14 +103,47 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
>         return 0;
>  }
>
> +static int msm_pinconf_set_special(struct msm_pinctrl_priv *priv, unsigned int pin_selector,
> +                                  unsigned int param, unsigned int argument)
> +{
> +       unsigned int offset = pin_selector - priv->data->pin_data.special_pins_start;
> +       const struct msm_special_pin_data *data;
> +
> +       if (!priv->data->pin_data.special_pins_data)
> +               return 0;
> +
> +       data = &priv->data->pin_data.special_pins_data[offset];
> +
> +       switch (param) {
> +       case PIN_CONFIG_DRIVE_STRENGTH:
> +               argument = (argument / 2) - 1;
> +               clrsetbits_le32(priv->base + data->ctl_reg,
> +                               GENMASK(2, 0) << data->drv_bit,
> +                               argument << data->drv_bit);
> +               break;
> +       case PIN_CONFIG_BIAS_DISABLE:
> +               clrbits_le32(priv->base + data->ctl_reg,
> +                            TLMM_GPIO_PULL_MASK << data->pull_bit);
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +               clrsetbits_le32(priv->base + data->ctl_reg,
> +                               TLMM_GPIO_PULL_MASK << data->pull_bit,
> +                               argument << data->pull_bit);
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       return 0;
> +}
> +
>  static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>                            unsigned int param, unsigned int argument)
>  {
>         struct msm_pinctrl_priv *priv = dev_get_priv(dev);
>
> -       /* Always NOP for special pins */
>         if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
> -               return 0;
> +               return msm_pinconf_set_special(priv, pin_selector, param, argument);
>
>         switch (param) {
>         case PIN_CONFIG_DRIVE_STRENGTH:
>
> --
> 2.34.1
>
