Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9B3C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D0D87622;
	Thu,  2 Nov 2023 23:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kSAW4V4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A305874B7; Thu,  2 Nov 2023 23:35:35 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E5887452
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507b96095abso1757412e87.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698964530; x=1699569330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6VNHhizotoH1NYopnhMF1vC3lw/gjM2WRiE1pG56oGk=;
 b=kSAW4V4iDQ+X+pe/J3jgm9a46HmXGkcdWqrIc2f8Qm4DOo+XKSZEtjrFhQMuGJgygQ
 YSMASwhbQT1Ht4MM5B52xNBn9L8jIU63rgBmEGP/Wc6gOXdGiIsBX/puSDgQ3imRmjEj
 /TG7WgXyxKyizfQKwdY4F9zogZqPUBWgn50o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698964530; x=1699569330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6VNHhizotoH1NYopnhMF1vC3lw/gjM2WRiE1pG56oGk=;
 b=A3xvEi/l2NDHuSzqTYM8OToWZ+UVMJ3EWbIFbTIB9vff07baziD+7DRf8Py/tpTlnz
 nMn10KQQ6tdgrgS33ijmDo9OmAmx1bwA5C3C8VLH3LUctGUpy1qZOYMjBKnIMnQyJiwM
 TGrid9ddcTI4+ox6Erb4/0cTXsKXD0Gn2tjc3pGQXHGK+9/64eSzZmVaNod7RHsMI4oz
 BMPNof5DtzW0VEApwsRTJETgk+LHDzllvGX/MuiqrcsSk8AFZjuKdy/dBoV8g83QOne7
 AV5t27avORJIA+K5AwovYFLXiKl/WKy8ZeLbRAh+fS9vG2hM1bwI4ieRCYfGexLzJuRK
 I/cw==
X-Gm-Message-State: AOJu0YyBTfx5Zv8h/s39lZkcGlKrDkO10aK60vw3TU/FeGJ5KE9LgY1f
 wzDIYbankv5cjxAqIq8TuJ6l4slkZA/rk6bMSeQhOA==
X-Google-Smtp-Source: AGHT+IGu5YNdRznXh/BgKruVD2KMPeJi8HGN3CJbWKKHsUTCDjhIliPWuoK17BwvCU5ObuvTNsYM/23j9X50g2FbPk0=
X-Received: by 2002:ac2:598e:0:b0:509:467a:5e36 with SMTP id
 w14-20020ac2598e000000b00509467a5e36mr3234816lfn.20.1698964529234; Thu, 02
 Nov 2023 15:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231102091648.40520-1-avromanov@salutedevices.com>
 <20231102091648.40520-2-avromanov@salutedevices.com>
In-Reply-To: <20231102091648.40520-2-avromanov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:35:12 +0000
Message-ID: <CAPnjgZ1Uv3AWZE9L0+coaoEx0cHNJq=oHNutPZFBSN0s=uL+GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rng: move platform_get_rng_device() to rng-uclass.c
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.denx.de, kernel@sberdevices.ru
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

Hi Alexey,

On Thu, 2 Nov 2023 at 12:58, Alexey Romanov <avromanov@salutedevices.com> wrote:
>
> The correct declaration place for platform_get_rng_device()
> function is here. Also, this function is re-implemented to provide
> the first successfully probed RNG device.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/rng/rng-uclass.c | 16 ++++++++++++++++
>  include/efi_rng.h        |  2 --
>  include/rng.h            | 11 +++++++++++
>  lib/efi_loader/efi_rng.c | 27 ---------------------------
>  4 files changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
> index 53108e1b31..d7236b9335 100644
> --- a/drivers/rng/rng-uclass.c
> +++ b/drivers/rng/rng-uclass.c
> @@ -9,6 +9,22 @@
>  #include <dm.h>
>  #include <rng.h>
>
> +int platform_get_rng_device(struct udevice **dev)
> +{
> +       int ret;
> +       struct udevice *devp;
> +
> +       ret = uclass_first_device_check(UCLASS_RNG, &devp);
> +       if (ret) {
> +               pr_err("Unable to get RNG device (%d)\n", ret);
> +               return -ENODEV;
> +       }
> +
> +       *dev = devp;
> +
> +       return 0;
> +}

Why not delete this function? It doesn't seem to do anything useful
except return the wrong error code if something goes wrong :-)

I worry that people might add other logic to it.

Also you might consider using rng0, rng1 aliases so people can
actually choose the device to use? If you want that you could
uclass_get_device_by_seq()

> +
>  int dm_rng_read(struct udevice *dev, void *buffer, size_t size)
>  {
>         const struct dm_rng_ops *ops = device_get_ops(dev);
> diff --git a/include/efi_rng.h b/include/efi_rng.h
> index 3c622381cb..f22e54adb0 100644
> --- a/include/efi_rng.h
> +++ b/include/efi_rng.h
> @@ -23,6 +23,4 @@ struct efi_rng_protocol {
>                                        efi_uintn_t rng_value_length, uint8_t *rng_value);
>  };
>
> -efi_status_t platform_get_rng_device(struct udevice **dev);
> -
>  #endif /* _EFI_RNG_H_ */
> diff --git a/include/rng.h b/include/rng.h
> index 37af554363..255c85d3e8 100644
> --- a/include/rng.h
> +++ b/include/rng.h
> @@ -20,6 +20,17 @@ struct udevice;
>   */
>  int dm_rng_read(struct udevice *dev, void *buffer, size_t size);
>
> +/**
> + * platform_get_rng_device() - retrieve random number generator
> + *
> + * This function retrieves the first udevice implementing a hardware
> + * random number generator. Device is already probed.
> + *
> + * @dev:       udevice
> + * Return:     status code
> + */
> +int platform_get_rng_device(struct udevice **dev);

Better naming (if you do keep this) is rng_get_first()

There is no such thing as a 'platform' in U-Boot.

> +
>  /**
>   * struct dm_rng_ops - operations for the hwrng uclass
>   *
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index bb11d8d0e0..0d8bf770f5 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -17,33 +17,6 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
>
> -/**
> - * platform_get_rng_device() - retrieve random number generator
> - *
> - * This function retrieves the udevice implementing a hardware random
> - * number generator.
> - *
> - * This function may be overridden if special initialization is needed.
> - *
> - * @dev:       udevice
> - * Return:     status code
> - */
> -__weak efi_status_t platform_get_rng_device(struct udevice **dev)
> -{
> -       int ret;
> -       struct udevice *devp;
> -
> -       ret = uclass_get_device(UCLASS_RNG, 0, &devp);
> -       if (ret) {
> -               debug("Unable to get rng device\n");
> -               return EFI_DEVICE_ERROR;
> -       }
> -
> -       *dev = devp;
> -
> -       return EFI_SUCCESS;
> -}
> -
>  /**
>   * rng_getinfo() - get information about random number generation
>   *
> --
> 2.30.1
>

Regards,
Simon
