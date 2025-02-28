Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C5DC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7133D80FE1;
	Fri, 28 Feb 2025 14:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CQXjTP2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D85A810F5; Fri, 28 Feb 2025 14:28:32 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4DA800B6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6fbaf4cf2b5so14502767b3.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740749309; x=1741354109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2c78RENEwQaznWTDyPQ1JEpsGfbrPcZwcP7jl0buhIQ=;
 b=CQXjTP2pGKr9DhvBV+bFMreR9zmT3oiUTm/AYK0uRCdoZkIT+qiyBEHZ/2u6QT5WQ4
 dqNXk2PB0BQKmRV24zz0uYpyYTDEzkKpQCVxSEJhAbtcFc69A3NRVUAViXm2FiiCrCXl
 CH7btCd+ltPAyDdsJw1tpkYx9uNuizG87KTmXOP/Wxb4RM+h8l/z2KkR4BAX0mEz3f4p
 JJwWL3zlrs8yCQRF+B99fCl9tC/eWLf4PkPnMsh2cy4J3DMCvn6qyqz1DeDkXOLEAOu2
 7ns5Up7UYexiimzSYHqdhroh52mnhDbAMVXc/821MEs8GKPkcRVlTBg69HphArrU1SAM
 9pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749309; x=1741354109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2c78RENEwQaznWTDyPQ1JEpsGfbrPcZwcP7jl0buhIQ=;
 b=sPsFkPknGeyLC/jC4JgBBOjglFHfcrYFzlhKi2LyKE4/OqKc6erpvKioGZRJOpkdtA
 Qwo8b/57BBaiHecJJCVLoDPgM9JkCcfVWP+jELe18eS/4x4WrzY4Cw6EsIBr6ipTyg9U
 DuY7aR72cGUn7u19ABh3E+IQKXPdDo9VLPucr27k9pyyRxTCgDQaoJmGUq4rJpBsaULN
 1gZgFIRL9kuf1wqLVNJIfwUWtPC6PSqPAoG7edcx7z0M/hHSVvOMBiPqmu7GeCCKpkdh
 OFZzSjahjOKH/KzoSJdftHXFaXxeCJZ4Dg6uXeVnF2QjchN2wLYLUImzLEQsacRy+oWg
 r8vw==
X-Gm-Message-State: AOJu0Yx3Z4eyV7R5qw5lbU1SBOKQLoa+1QCd2HLqNQ7O3I6qBanNczlV
 UqIpvYNWNNi1qPpU2G5Vj7wdqnJgC3DzIyfyxmcLhyj98Xcy+Iw2U370qBn2nPhDeRbIaHTVJt/
 494lPWUzcORLCRZE+IvsTETNjjP3OjTCm2HHQYg==
X-Gm-Gg: ASbGncvzHbMWtc4pEvT9XasqPoCY6eBFccrKxlPbkJbIQxu91NtaQkC03+jgIFmIt05
 4LzxsZkpeKJxehKHff9k09kKdLMovdo395FoNF30kJaEWow0+oauzQnQag02Wt5klfg87PEyfBh
 pirI2Lu3AeJ3aCjohPZ2JfrSQOcEQ/uO9OaY8lHfo=
X-Google-Smtp-Source: AGHT+IH+g+Y40CepSUYvYR/2M+Lg8f2LGaD7HuZLuTPIiTSGQ3j0zqtu9jOwwv2mNe+zPfPT1vOOiDD0QblZhH1Ou1E=
X-Received: by 2002:a05:690c:9c05:b0:6ef:7d51:ebb3 with SMTP id
 00721157ae682-6fd4a100813mr43044607b3.34.1740749308678; Fri, 28 Feb 2025
 05:28:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <251fb41d13189f475f606a6fdffc764997ee8d61.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <251fb41d13189f475f606a6fdffc764997ee8d61.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 15:27:51 +0200
X-Gm-Features: AQ5f1JrFX1BbTe6Isi8n0rNK0o4vg7wLKt63TmObf-wD9X7RZ9IyGFhNXAKtgec
Message-ID: <CAC_iWj+XEZ-Gn-MTj7sUqC90JJTtARFrccY_dnaNiMtGASJCKw@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Dragan Simic <dsimic@manjaro.org>
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

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> To prepare for the introduction of coroutines in the USB initialization
> sequence, move code out of usb_init() into a new helper function:
> usb_init_bus(). No functional change.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/usb/host/usb-uclass.c | 88 +++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> index bfec303e7af..cc803241461 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -287,9 +287,55 @@ static int usb_probe_companion(struct udevice *bus)
>         return 0;
>  }
>
> +static int controllers_initialized;
> +
> +static void usb_init_bus(struct udevice *bus)
> +{
> +       int ret;
> +
> +       /* init low_level USB */
> +       printf("Bus %s: ", bus->name);
> +
> +       /*
> +        * For Sandbox, we need scan the device tree each time when we
> +        * start the USB stack, in order to re-create the emulated USB
> +        * devices and bind drivers for them before we actually do the
> +        * driver probe.
> +        *
> +        * For USB onboard HUB, we need to do some non-trivial init
> +        * like enabling a power regulator, before enumeration.
> +        */
> +       if (IS_ENABLED(CONFIG_SANDBOX) ||
> +           IS_ENABLED(CONFIG_USB_ONBOARD_HUB)) {
> +               ret = dm_scan_fdt_dev(bus);
> +               if (ret) {
> +                       printf("USB device scan from fdt failed (%d)", ret);
> +                       return;
> +               }
> +       }
> +
> +       ret = device_probe(bus);
> +       if (ret == -ENODEV) {   /* No such device. */
> +               puts("Port not available.\n");
> +               controllers_initialized++;
> +               return;
> +       }
> +
> +       if (ret) {              /* Other error. */
> +               printf("probe failed, error %d\n", ret);
> +               return;
> +       }
> +
> +       ret = usb_probe_companion(bus);
> +       if (ret)
> +               return;
> +
> +       controllers_initialized++;
> +       usb_started = true;
> +}
> +
>  int usb_init(void)
>  {
> -       int controllers_initialized = 0;
>         struct usb_uclass_priv *uc_priv;
>         struct usb_bus_priv *priv;
>         struct udevice *bus;
> @@ -305,45 +351,7 @@ int usb_init(void)
>         uc_priv = uclass_get_priv(uc);
>
>         uclass_foreach_dev(bus, uc) {
> -               /* init low_level USB */
> -               printf("Bus %s: ", bus->name);
> -
> -               /*
> -                * For Sandbox, we need scan the device tree each time when we
> -                * start the USB stack, in order to re-create the emulated USB
> -                * devices and bind drivers for them before we actually do the
> -                * driver probe.
> -                *
> -                * For USB onboard HUB, we need to do some non-trivial init
> -                * like enabling a power regulator, before enumeration.
> -                */
> -               if (IS_ENABLED(CONFIG_SANDBOX) ||
> -                   IS_ENABLED(CONFIG_USB_ONBOARD_HUB)) {
> -                       ret = dm_scan_fdt_dev(bus);
> -                       if (ret) {
> -                               printf("USB device scan from fdt failed (%d)", ret);
> -                               continue;
> -                       }
> -               }
> -
> -               ret = device_probe(bus);
> -               if (ret == -ENODEV) {   /* No such device. */
> -                       puts("Port not available.\n");
> -                       controllers_initialized++;
> -                       continue;
> -               }
> -
> -               if (ret) {              /* Other error. */
> -                       printf("probe failed, error %d\n", ret);
> -                       continue;
> -               }
> -
> -               ret = usb_probe_companion(bus);
> -               if (ret)
> -                       continue;
> -
> -               controllers_initialized++;
> -               usb_started = true;
> +               usb_init_bus(bus);
>         }
>
>         /*
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
