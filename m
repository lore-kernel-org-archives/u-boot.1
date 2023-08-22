Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92135EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 004A7864AB;
	Tue, 22 Aug 2023 18:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="ixaeIMqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120268648E; Tue, 22 Aug 2023 18:53:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8D0864D3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c5327e5e8so1382629f8f.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692723179; x=1693327979; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SXJBNV5qZFGZS6SBJmlyb74+RnaCjkiRp0O6/XQYLqs=;
 b=ixaeIMqPBaXkRHueNPoT/MKx22wcJ45fAq5TNNeTQ2CfKTjxwQCaEfB8MZXKzCl8V5
 iWQAhJF8CMJCWcDUeeYuRvQSfz5SGhHma1JQZFiIyR/aCHA9qXnu07U6OlpC+98YIh/P
 xIYTmXi7WuBOy9jfDprt+Kr11zVqm4c+6lrdoZV8rDPS9MgOfe//FOR3AOz7yyR7BAUK
 SgBpDM85bIsNMEEi/e5PIYhHlFvuPbvWP1rogJ5IvXd09owMvZOx1niXFsbHk79XnhcO
 TLCTo/noE8nqcYVDD92D9Szgavqzez3MPxM6zRMZeMmJttIgcmwkyZQXEQkB/wU8c5Ll
 u3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723179; x=1693327979;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXJBNV5qZFGZS6SBJmlyb74+RnaCjkiRp0O6/XQYLqs=;
 b=lQneCYFj//Y3iH097SRAq6sWI64xETNxeX4fR2HN3YcSgQmu3CwkDFXJB3Lh4s327R
 wDJg7oPgjylbC5FZVF3l1M7gC0z2JX1Yvy4BbEIlUI1t+FF8FFhcYw+XdrRpqx2iVB13
 lOFOkif9lReeiGymTuN2bj+/+gk+qhAlt5aMIuCeJ2UOs9vc3SQVsCVXCNEKuLuYPuAQ
 3gG0aSJtaCAoPQEi0ujb2j5mfscz6g8NJC0uRg3DRPr/Y59iHMlAOB/rl6fLMoR+hrsg
 xZJmhFg6v2e+SqRRztybuG5XJjDzYXyTYHZHiyt+T0iRckBd71BumkGR3JcrOPC7XyVQ
 sE4Q==
X-Gm-Message-State: AOJu0YwwUF/qMdkVvNvluuqRO7aLhzPndF94MWICUNwhiqPXGoOjype+
 yol4YTK74e1Zp3dBDWLctdxUeQ==
X-Google-Smtp-Source: AGHT+IFe3W+wcpB8MD7DKWZYuDWUZ/6EeqzOVoxRjnAzIRdFb7gJHVEPm0kfYyBOQ3VP+dL9JjLd8A==
X-Received: by 2002:a5d:510f:0:b0:313:df09:acfb with SMTP id
 s15-20020a5d510f000000b00313df09acfbmr10190140wrt.11.1692723179166; 
 Tue, 22 Aug 2023 09:52:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d13-20020adff2cd000000b0031ac70b6aa7sm16415670wrp.20.2023.08.22.09.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:52:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 16/17] dm: usb: udc: Drop legacy udevice handler functions
In-Reply-To: <20230819142407.49632-16-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-16-marex@denx.de>
Date: Tue, 22 Aug 2023 18:52:57 +0200
Message-ID: <87ttsrqas6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On sam., ao=C3=BBt 19, 2023 at 16:24, Marek Vasut <marex@denx.de> wrote:

> Remove legacy functions limited by the dev_array array,
> those are no longer used anywhere, all the code uses
> plain udevice based access now.
>
> The usb_gadget_handle_interrupts() is doing udevice look up
> until all call sites use dm_usb_gadget_handle_interrupts().
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  drivers/usb/gadget/udc/udc-uclass.c | 44 ++++-------------------------
>  include/linux/usb/gadget.h          | 17 -----------
>  2 files changed, 6 insertions(+), 55 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc=
/udc-uclass.c
> index b4271b4be9f..7f54a3b00cb 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -12,9 +12,6 @@
>  #include <linux/usb/gadget.h>
>=20=20
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -#define MAX_UDC_DEVICES 4
> -static struct udevice *dev_array[MAX_UDC_DEVICES];
> -
>  int udc_device_get_by_index(int index, struct udevice **udev)
>  {
>  	struct udevice *dev =3D NULL;
> @@ -45,45 +42,16 @@ int udc_device_put(struct udevice *udev)
>  #endif
>  }
>=20=20
> -int usb_gadget_initialize(int index)
> -{
> -	int ret;
> -	struct udevice *dev =3D NULL;
> -
> -	if (index < 0 || index >=3D ARRAY_SIZE(dev_array))
> -		return -EINVAL;
> -	if (dev_array[index])
> -		return 0;
> -	ret =3D udc_device_get_by_index(index, &dev);
> -	if (!dev || ret) {
> -		pr_err("No USB device found\n");
> -		return -ENODEV;
> -	}
> -	dev_array[index] =3D dev;
> -	return 0;
> -}
> -
> -int usb_gadget_release(int index)
> +int usb_gadget_handle_interrupts(int index)
>  {
> -#if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
> +	struct udevice *udc;
>  	int ret;
> -	if (index < 0 || index >=3D ARRAY_SIZE(dev_array))
> -		return -EINVAL;
>=20=20
> -	ret =3D device_remove(dev_array[index]);
> -	if (!ret)
> -		dev_array[index] =3D NULL;
> -	return ret;
> -#else
> -	return -ENOSYS;
> -#endif
> -}
> +	ret =3D udc_device_get_by_index(index, &udc);
> +	if (ret)
> +		return ret;
>=20=20
> -int usb_gadget_handle_interrupts(int index)
> -{
> -	if (index < 0 || index >=3D ARRAY_SIZE(dev_array))
> -		return -EINVAL;
> -	return dm_usb_gadget_handle_interrupts(dev_array[index]);
> +	return dm_usb_gadget_handle_interrupts(udc);
>  }
>  #else
>  /* Backwards hardware compatibility -- switch to DM_USB_GADGET */
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 5e9a6513d5b..54875d2716e 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -1023,21 +1023,4 @@ int udc_device_get_by_index(int index, struct udev=
ice **udev);
>   */
>  int udc_device_put(struct udevice *udev);
>=20=20
> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> -int usb_gadget_initialize(int index);
> -int usb_gadget_release(int index);
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev);
> -#else
> -#include <usb.h>
> -static inline int usb_gadget_initialize(int index)
> -{
> -	return board_usb_init(index, USB_INIT_DEVICE);
> -}
> -
> -static inline int usb_gadget_release(int index)
> -{
> -	return board_usb_cleanup(index, USB_INIT_DEVICE);
> -}
> -#endif
> -
>  #endif	/* __LINUX_USB_GADGET_H */
> --=20
> 2.40.1
