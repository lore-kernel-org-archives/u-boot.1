Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B274C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893C588370;
	Thu, 27 Jun 2024 13:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aalw/Pha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A4A8852A; Thu, 27 Jun 2024 10:37:27 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E218852D
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b501a4344bso29968316d6.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477443; x=1720082243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMc4ljFg7l2S+adb42/qqkZ0lAiGcoiXen99I9SZOAg=;
 b=Aalw/PhaAUu226tH72+1xsF0Mr0rIPRc3XOGpq+YOvefpMdMQy9/fkXVIBxon5oEHq
 WWrSUId/kBQ0M/rCfOZPEWBLg9VmF9J6R7VgHu+22YpjK5wfVq/ot5l2FqulfWI8Lobp
 mIAtxkFacoEoaTspKBsbNvbkrutmqDtr6+kpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477443; x=1720082243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMc4ljFg7l2S+adb42/qqkZ0lAiGcoiXen99I9SZOAg=;
 b=hSLcO9dQ+PRzT7tOb5lUMvg8v1BTgWgpvqGIPjd0rRSHXhxnRLN08PgJTsF1jNFyK3
 lmOQ22xnDPraSm6TasYmBe3QddewHOgnIq1zl+fQCKNvXD1uYWFS42nIKESG3qoKs8LK
 tXT/I67xiiPwuC/HN2jGC6NVbgtKxdPDH1Mj2e6y3rMZ4v4QvOJPmWnaeBdL1ibGpRmN
 ePrWlsj9Q1yg+CnOgUNiUhB3PXZmBWtNDr8ujHVgNCu0CRQWLTbAszDEQxhJpfp7YI4v
 jFnWnQ8kiT6C6IB+SPSRjt9LgOWz0nrhsqbyHItzhTaImMFj+/ej4UyIymzt6UDA+YuN
 Y6WA==
X-Gm-Message-State: AOJu0Yy2oM81L3NIt7EerHNbz6GD7eEdpfgrRBy8uGlIqHZKbGZpZPlj
 j9OFfsu3rJxFJPN98RFtNGc2HjaJ6jcNrygecmlkImGXKW0UPNxvQLRhJqZ1eH1iMw5tGtTElEO
 GpKZmEA1nD6K3y6y9WhK6kx0s/ev5ci6yQMpe
X-Google-Smtp-Source: AGHT+IFhGtaZsYu+JsYbMdjHkL2dtU5fQIErE4zdPS5c616U3P2RmZjS4NhZe2IDSecjFCkeWrNkXlWWgx+G8U2nAF0=
X-Received: by 2002:a0c:cb87:0:b0:6b4:fc60:a835 with SMTP id
 6a1803df08f44-6b540cedfb6mr137771266d6.56.1719477442975; Thu, 27 Jun 2024
 01:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <20240626235717.272219-2-marex@denx.de>
In-Reply-To: <20240626235717.272219-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:12 +0100
Message-ID: <CAFLszTjb7=x78V7-75Ch11wdJy2CBnuYE1_+11b+mivokCFm=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] power: regulator: Convert
 regulators_enable_boot_on/off() to regulator_post_probe
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
> Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
> empty functions. Implement matching functionality in regulator_post_probe()
> instead. The regulator_post_probe() is called for all regulators after they
> probe, and regulators that have regulator-always-on or regulator-boot-on DT
> properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
> such regulators in regulator_post_bind().
>
> Finally, fold regulator_unset() functionality into regulator_autoset().
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
>  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
>  1 file changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index ccc4ef33d83..d52f273042f 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -308,6 +308,11 @@ int regulator_autoset(struct udevice *dev)
>                         return ret;
>         }
>
> +       if (uc_pdata->force_off) {
> +               ret = regulator_set_enable(dev, false);
> +               goto out;
> +       }
> +
>         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
>                 ret = -EMEDIUMTYPE;
>                 goto out;
> @@ -512,56 +517,28 @@ static int regulator_pre_probe(struct udevice *dev)
>         return 0;
>  }
>
> -int regulators_enable_boot_on(bool verbose)
> +static int regulator_post_probe(struct udevice *dev)
>  {
> -       struct udevice *dev;
> -       struct uclass *uc;
>         int ret;
>
> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> -       if (ret)
> +       ret = regulator_autoset(dev);
> +       if (ret && ret != -EMEDIUMTYPE && ret != ENOSYS)
>                 return ret;
> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> -            dev;
> -            uclass_next_device(&dev)) {
> -               ret = regulator_autoset(dev);
> -               if (ret == -EMEDIUMTYPE) {
> -                       ret = 0;
> -                       continue;
> -               }
> -               if (verbose)
> -                       regulator_show(dev, ret);
> -               if (ret == -ENOSYS)
> -                       ret = 0;
> -       }
>
> -       return ret;
> +       if (_DEBUG)
> +               regulator_show(dev, ret);
> +
> +       return 0;
>  }
>
> -int regulators_enable_boot_off(bool verbose)
> +int regulators_enable_boot_on(bool verbose)
>  {
> -       struct udevice *dev;
> -       struct uclass *uc;
> -       int ret;
> -
> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> -       if (ret)
> -               return ret;
> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> -            dev;
> -            uclass_next_device(&dev)) {
> -               ret = regulator_unset(dev);
> -               if (ret == -EMEDIUMTYPE) {
> -                       ret = 0;
> -                       continue;
> -               }
> -               if (verbose)
> -                       regulator_show(dev, ret);
> -               if (ret == -ENOSYS)
> -                       ret = 0;
> -       }
> +       return 0;
> +}
>
> -       return ret;
> +int regulators_enable_boot_off(bool verbose)
> +{
> +       return 0;
>  }
>
>  UCLASS_DRIVER(regulator) = {
> @@ -569,5 +546,6 @@ UCLASS_DRIVER(regulator) = {
>         .name           = "regulator",
>         .post_bind      = regulator_post_bind,
>         .pre_probe      = regulator_pre_probe,
> +       .post_probe     = regulator_post_probe,
>         .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
>  };
> --
> 2.43.0
>
