Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0509DC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5E188566;
	Thu, 27 Jun 2024 13:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqey7FvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAB888566; Thu, 27 Jun 2024 10:37:25 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377FB87C69
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b4f7541d7eso35274176d6.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477441; x=1720082241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Drsax0+dXEStDCtvGER0XXppogmnc1mTb7HjV3GTpI=;
 b=bqey7FvGCxA1+TEt7sOQrTy/Kz9DKm6B2Q512/qmv8zJ0QXeD1C98GEMjo6D0lkSld
 4qS3Z7r/iPDZ0IFLuLOSySxsFAkEr/IvzV2S224yDW7GCzethmK+pOBTJ1+d3fkzcGqq
 nWgdJW5+r6wdx5JZ34MUOVZM5L2c4RR00iVA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477441; x=1720082241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Drsax0+dXEStDCtvGER0XXppogmnc1mTb7HjV3GTpI=;
 b=TqZJTb/bKZHkX8ZfvBtQBQCaIxSDES4pxASLtI0P+gnTOT+xaxF9rBUQz5esYN++nT
 dnI0pAtnSQDqvxfR/0rFy4uRiJIqzYt76YSBuor5Q9hx5f2PFKyNZAYfKFn2M8QInSjo
 cw5OFkj7MD9apl+nqpWVAYEABjlYT4yKJjloqSndqGCfSXysGh8j+eOthLScrsIJ8Dyc
 2ur2KOy3RmsdSDxJKZC2NfWnY4CksdiC867vI7mOSAbgxq8LB7BICyzWEglUVB+khi9e
 LRZmT+sWoas+TT5LgEcVXpCmdsBIKzHOGSlhYkNFFk9LczoYIoahieSrJz7MHYai6J41
 2BKw==
X-Gm-Message-State: AOJu0YwQlCpj131WhlDO4hzpTzV0ApRtH6mG4CA0tzIrImusrhrf9MAk
 KOhNQeVyf2MSWmM49PUQ8UvQmbWwo5knj+CPexZ2oo9Cdbc+cEBs6ybIHAIBhgaiNBSuVtHPJI9
 pI4ryqiwleOfTL/Yv3/6b6DRApsnAyosD21uG
X-Google-Smtp-Source: AGHT+IGxdtL7Rroo0sFI11mpUZ72HuIEcxMYc5mTwDbHV/ylp+hOvCtvlxZ9tIns2pZk0WDsq2X5RlsVPhlwN1EehHk=
X-Received: by 2002:a0c:f94d:0:b0:6b2:b2a3:67ce with SMTP id
 6a1803df08f44-6b582745041mr35980076d6.51.1719477441110; Thu, 27 Jun 2024
 01:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
In-Reply-To: <20240626235717.272219-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:10 +0100
Message-ID: <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Jun 2024 13:09:53 +0200
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

Hi Marek,

On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
>
> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> property, make sure the regulator gets correctly configured by U-Boot on start
> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> for introduction of .regulator_post_probe() which would trigger the regulator
> configuration.
>
> Parsing of regulator-always-on and regulator-boot-on DT property has been
> moved to regulator_post_bind() as the information is required early, the
> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> slowing down the boot process.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Kostya Porotchkin <kostap@marvell.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Sam Day <me@samcday.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 66fd531da04..ccc4ef33d83 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
>         const char *property = "regulator-name";
>
>         uc_pdata = dev_get_uclass_plat(dev);
> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>
>         /* Regulator's mandatory constraint */
>         uc_pdata->name = dev_read_string(dev, property);
> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
>                         return -EINVAL;
>         }
>
> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> -               return 0;
> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> +                     property, dev->name, uc_pdata->name);
> +               return -EINVAL;
> +       }
>
> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> -             property, dev->name, uc_pdata->name);
> +       /*
> +        * In case the regulator has regulator-always-on or
> +        * regulator-boot-on DT property, trigger probe() to
> +        * configure its default state during startup.
> +        */
> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>
> -       return -EINVAL;
> +       return 0;
>  }
>
>  static int regulator_pre_probe(struct udevice *dev)
> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>                                                 -ENODATA);
>         uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
>                                                 -ENODATA);
> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>         uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
>                                                     0);
>         uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> --
> 2.43.0
>

This is reading a lot of DT stuff very early, which may be slow. It is
also reading from the DT in the bind() step which we sometimes have to
do, but try to avoid.

Also this seems to happen in SPL and again pre-reloc and again in
U-Boot post-reloc?

Should we have a step in the init sequence where we set up the
regulators, by calling regulators_enable_boot_on() ?

Regards,
Simon
