Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657B4E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76678952B;
	Thu,  5 Dec 2024 18:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lAUJI5h2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73CB1894F6; Thu,  5 Dec 2024 18:57:01 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694F48950A
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f367f97so1674043a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421417; x=1734026217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zxmhYUM70P9rEacRMzeyB/HWfFogRN/gJbe9EOQDHcw=;
 b=lAUJI5h2+9fgMVvX4BpVXpFrghBpvrIyz/b1xU563XlkBO00lNncVqdpHRHsEMr0Ug
 Nqtpig9qd2bx/Jn4j5zdFJHWBKWMFwTyhNOgZLtWQY8JWW3Q+FSKd4ftuiRlef4PCYei
 trTZR2hIpt1zeuuMxSUqfggul/gaLhgMWRGZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421417; x=1734026217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxmhYUM70P9rEacRMzeyB/HWfFogRN/gJbe9EOQDHcw=;
 b=YVYD8qnmdh28q5RyWoVLTaPAyOXxtSNxvjDJWDWB/3gxPj0pdb3YmQcs/md65ke008
 v116Q2jqyxI8EKo5GDrxAnjv81Aoz2yNYW9Z8XZ2VATtzOCJFkRgal1DdgNNOnI1xO5V
 9aPwQx7ywzNtpg6b+1meWm9Kk9Fu9aWCdmDSePd7XkYT2Ym+LqCY6+2tNs8sCOkF79GX
 j5l+tH9tfJjbHTtaN/3bvG99lHZeXBtODh7wPto5g5P/IiYTy7rsp/DTj18UpGdgVCim
 MoEHjhjljo19WzAneVdr96/sWy3QiBPtZgEOlkisZbroL9c+yPSIV9YnFMHLcCqQds2l
 RtBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnz/VRIVqANMVYcbq4uhIjlULU+1kzHvoJvAK7xHaDjzHtfqVRobLTC3Ce3Y2jCVrWFcIVHMs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3p2qwKUbmv49tchFZ6bLFfH8NRkQ0QL1zkgG0naR2sruT2Z86
 xJtzc55vgUAbtn7U2yt5RWo1Fhkp+e0FAw0yKLwJL02wO6HFs+TTlwHWEoqyx9MM5bCSK1Aaw7K
 j2wUH/j2Cths28yiCwhPPWspVOswqgwHHFH5y
X-Gm-Gg: ASbGncvTQBKSHPWsE1M7eBRBpqP/uuXtPc/btrqUy1tGKsSO73McJM5t9WsgSQSmyAm
 t2VAyG3Cp4Fqk33J9xBUJOGiE6axn3Fci0FpR
X-Google-Smtp-Source: AGHT+IHfRANj8vTJ7ysxstdkD93b+zVyYTs08p9QHqW6ZxQilltq6YMBdbr1GZEWa6DVKynrdW8nTXfVUxRwJKlpUEY=
X-Received: by 2002:a17:906:3ca2:b0:aa5:2237:67af with SMTP id
 a640c23a62f3a-aa5f7ccee6amr921943966b.9.1733421416893; Thu, 05 Dec 2024
 09:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-5-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-5-4683bb4388dc@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:56:44 -0700
Message-ID: <CAFLszTjaqOYJnoJ+DZh+BrREKsyenAT-mwkp=+9k4wyc6zHYUw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
>
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in a recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/power/domain/power-domain-uclass.c | 37 ++++++++++++++++++++++++++++--
>  include/power-domain.h                     |  4 ++--
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..55a3d95d83c5aaac31acbd877199c87f8f6fb880 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -12,6 +12,10 @@
>  #include <power-domain-uclass.h>
>  #include <dm/device-internal.h>
>
> +struct power_domain_priv {
> +       int on_count;
> +};
> +
>  static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
>  {
>         return (struct power_domain_ops *)dev->driver->ops;
> @@ -110,19 +114,47 @@ int power_domain_free(struct power_domain *power_domain)
>  int power_domain_on(struct power_domain *power_domain)
>  {
>         struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +       struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
> +       int ret;
>
>         debug("%s(power_domain=%p)\n", __func__, power_domain);
>
> -       return ops->on ? ops->on(power_domain) : 0;
> +       if (priv->on_count++ > 0)
> +               return 0;

-EALREADY - see drivers/power/regulator/regulator-uclass.c

> +
> +       ret = ops->on ? ops->on(power_domain) : 0;
> +       if (ret) {
> +               priv->on_count--;
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  int power_domain_off(struct power_domain *power_domain)
>  {
>         struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +       struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
> +       int ret;
>
>         debug("%s(power_domain=%p)\n", __func__, power_domain);
>
> -       return ops->off ? ops->off(power_domain) : 0;
> +       if (priv->on_count <= 0) {
> +               debug("Power domain %s already off.\n", power_domain->dev->name);
> +               priv->on_count--;
> +               return 0;
> +       }
> +
> +       if (priv->on_count-- > 1)
> +               return 0;

-EBUSY otherwise no one knows whether it actually happened

You could add a helper to silently ignore -EBUSY ?

> +
> +       ret = ops->off ? ops->off(power_domain) : 0;
> +       if (ret) {
> +               priv->on_count++;
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  #if CONFIG_IS_ENABLED(OF_REAL)
> @@ -180,4 +212,5 @@ int dev_power_domain_off(struct udevice *dev)
>  UCLASS_DRIVER(power_domain) = {
>         .id             = UCLASS_POWER_DOMAIN,
>         .name           = "power_domain",
> +       .per_device_auto = sizeof(struct power_domain_priv),
>  };
> diff --git a/include/power-domain.h b/include/power-domain.h
> index 18525073e5e3534fcbac6fae4e18462f29a4dc49..0266fc2f864ef3645d2a8b3c6fa66fdbd868799c 100644
> --- a/include/power-domain.h
> +++ b/include/power-domain.h
> @@ -147,7 +147,7 @@ static inline int power_domain_free(struct power_domain *power_domain)
>  #endif
>
>  /**
> - * power_domain_on - Enable power to a power domain.
> + * power_domain_on - Enable power to a power domain (with refcounting)
>   *
>   * @power_domain:      A power domain struct that was previously successfully
>   *             requested by power_domain_get().
> @@ -163,7 +163,7 @@ static inline int power_domain_on(struct power_domain *power_domain)
>  #endif
>
>  /**
> - * power_domain_off - Disable power to a power domain.
> + * power_domain_off - Disable power to a power domain (with refcounting)
>   *
>   * @power_domain:      A power domain struct that was previously successfully
>   *             requested by power_domain_get().
>
> --
> 2.47.0
>

Regards,
Simon
