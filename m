Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A2EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536748647F;
	Tue, 22 Aug 2023 18:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="wnOZVuDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770AC8647D; Tue, 22 Aug 2023 18:07:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A37C8647F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe12baec61so46749315e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692720471; x=1693325271; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k7j3zG0IX1PaMsqQ0ktJz3PFCh53YLXFY4oPNaNTGho=;
 b=wnOZVuDBNtlMOlfW4oB51KH3ttQ7zN5tq0sXPPtfkL4dkHYBeUVy30CgBg5kdtWrc8
 TUFRBlLsKjsPLeDYHZ3/IvlFgj6bKNVmg4iBlu3KyEhtpoHXf+MO/s4epMgqFvkaSRSc
 YRlCW1+JfSrsAPYoMIq+qv9S/0TwBDUdRj0YULjjQUdrDzH7q/aDCdKjVTAv/S1/UzQ7
 nTvb4douCv2BrSKeUH/AW9os8m1+r71QuP27+5fH2m//QVc/cp684+VaHxmqks3jTn53
 4yq3ujMCt+ZNMKOI/Ivn+0/SP1qrgUql8GWYJYqoVq6tmQYyjOIk3MVhyFUun4e4Ybit
 abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720471; x=1693325271;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7j3zG0IX1PaMsqQ0ktJz3PFCh53YLXFY4oPNaNTGho=;
 b=TAhqR+9wgg+j4NUU++Vpj+9kORObz9h7QWFysNQrvF3JE9Cb8fq9Y6SqAYxTi7cX9R
 ulok+LVXu6VJOKAqEdiHH9l0Qi0vXXz8kcaCRgjiodr0/8sskJ1K57tOiF3ylp4gvXI6
 0tGaQTM0LZpnedD/B5o9nTpbJrFVlL+B+ZagpGCbskVAqcg58lB8TP7JsHOFlwtp+XsW
 INu6hAf/XvVq4aAAgNZFK6OKL2F3TTSoAEigQdqiQkVYyal11W+U5nLzxS0CLCRKSJRG
 95qSZ5JuLsy56I4j/M4v7UziV3ohkDmwSCmH0HO6EDxzosjiIkdOVrdLOqBMWyb3Ykyc
 Rgog==
X-Gm-Message-State: AOJu0Yzth26StcGb2N4Txf4KdqXlfdqbPTm2fBU2vvkwuilLJQYbdUkg
 hT3wae1TPkMGetXbUP5n0mP+Eg==
X-Google-Smtp-Source: AGHT+IHMl2nnjP7ltiuYWIQgCffUAx4pTcBjSBqTysn9WNMDRKIfs0hhAjck7Z/UmX7f4L9yMsw76Q==
X-Received: by 2002:a1c:6a16:0:b0:3fa:98c3:7dbd with SMTP id
 f22-20020a1c6a16000000b003fa98c37dbdmr7712901wmc.41.1692720471246; 
 Tue, 22 Aug 2023 09:07:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feef9a6cb2sm8181264wmi.28.2023.08.22.09.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:07:50 -0700 (PDT)
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
Subject: Re: [PATCH 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
Date: Tue, 22 Aug 2023 18:07:49 +0200
Message-ID: <87msyjrrfu.fsf@baylibre.com>
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

On sam., ao=C3=BBt 19, 2023 at 16:23, Marek Vasut <marex@denx.de> wrote:

> Pull the functionality of UDC uclass that operates on plain udevice
> and does not use this dev_array array into separate functions and
> expose those functions, so that as much code as possible can be
> switched over to these functions and the dev_array can be dropped.
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>  drivers/usb/gadget/udc/Makefile     |  2 +-
>  drivers/usb/gadget/udc/udc-uclass.c | 57 +++++++++++++++++++++++++----
>  include/linux/usb/gadget.h          | 17 +++++++++
>  3 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Mak=
efile
> index 95dbf0c82ee..467c566f6d3 100644
> --- a/drivers/usb/gadget/udc/Makefile
> +++ b/drivers/usb/gadget/udc/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_USB_DWC3_GADGET)	+=3D udc-core.o
>  endif
>=20=20
>  obj-$(CONFIG_$(SPL_)DM_USB_GADGET)	+=3D udc-core.o
> -obj-$(CONFIG_$(SPL_)DM) +=3D udc-uclass.o
> +obj-y +=3D udc-uclass.o
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc=
/udc-uclass.c
> index de8861829c7..b4271b4be9f 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -14,6 +14,37 @@
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
>  #define MAX_UDC_DEVICES 4
>  static struct udevice *dev_array[MAX_UDC_DEVICES];
> +
> +int udc_device_get_by_index(int index, struct udevice **udev)
> +{
> +	struct udevice *dev =3D NULL;
> +	int ret;
> +
> +	ret =3D uclass_get_device_by_seq(UCLASS_USB_GADGET_GENERIC, index, &dev=
);
> +	if (!ret && dev) {
> +		*udev =3D dev;
> +		return 0;
> +	}
> +
> +	ret =3D uclass_get_device(UCLASS_USB_GADGET_GENERIC, index, &dev);
> +	if (!ret && dev) {
> +		*udev =3D dev;
> +		return 0;
> +	}
> +
> +	pr_err("No USB device found\n");
> +	return -ENODEV;
> +}
> +
> +int udc_device_put(struct udevice *udev)
> +{
> +#if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
> +	return device_remove(udev, DM_REMOVE_NORMAL);
> +#else
> +	return -ENOSYS;
> +#endif
> +}
> +
>  int usb_gadget_initialize(int index)
>  {
>  	int ret;
> @@ -23,13 +54,10 @@ int usb_gadget_initialize(int index)
>  		return -EINVAL;
>  	if (dev_array[index])
>  		return 0;
> -	ret =3D uclass_get_device_by_seq(UCLASS_USB_GADGET_GENERIC, index, &dev=
);
> +	ret =3D udc_device_get_by_index(index, &dev);
>  	if (!dev || ret) {
> -		ret =3D uclass_get_device(UCLASS_USB_GADGET_GENERIC, index, &dev);
> -		if (!dev || ret) {
> -			pr_err("No USB device found\n");
> -			return -ENODEV;
> -		}
> +		pr_err("No USB device found\n");
> +		return -ENODEV;
>  	}
>  	dev_array[index] =3D dev;
>  	return 0;
> @@ -42,7 +70,7 @@ int usb_gadget_release(int index)
>  	if (index < 0 || index >=3D ARRAY_SIZE(dev_array))
>  		return -EINVAL;
>=20=20
> -	ret =3D device_remove(dev_array[index], DM_REMOVE_NORMAL);
> +	ret =3D device_remove(dev_array[index]);
>  	if (!ret)
>  		dev_array[index] =3D NULL;
>  	return ret;
> @@ -57,10 +85,25 @@ int usb_gadget_handle_interrupts(int index)
>  		return -EINVAL;
>  	return dm_usb_gadget_handle_interrupts(dev_array[index]);
>  }
> +#else
> +/* Backwards hardware compatibility -- switch to DM_USB_GADGET */
> +static int legacy_index;
> +int udc_device_get_by_index(int index, struct udevice **udev)
> +{
> +	legacy_index =3D index;
> +	return board_usb_init(index, USB_INIT_DEVICE);
> +}
> +
> +int udc_device_put(struct udevice *udev)
> +{
> +	return board_usb_cleanup(legacy_index, USB_INIT_DEVICE);
> +}
>  #endif
>=20=20
> +#if CONFIG_IS_ENABLED(DM)
>  UCLASS_DRIVER(usb_gadget_generic) =3D {
>  	.id		=3D UCLASS_USB_GADGET_GENERIC,
>  	.name		=3D "usb",
>  	.flags		=3D DM_UC_FLAG_SEQ_ALIAS,
>  };
> +#endif
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 2f694fc25c1..5e9a6513d5b 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -1006,6 +1006,23 @@ extern void usb_ep_autoconfig_reset(struct usb_gad=
get *);
>=20=20
>  extern int usb_gadget_handle_interrupts(int index);
>=20=20
> +/**
> + * udc_device_get_by_index() - Get UDC udevice by index
> + * @index: UDC device index
> + * @udev: UDC udevice matching the index (if found)
> + *
> + * Return: 0 if Ok, -ve on error
> + */
> +int udc_device_get_by_index(int index, struct udevice **udev);
> +
> +/**
> + * udc_device_put() - Put UDC udevice
> + * @udev: UDC udevice
> + *
> + * Return: 0 if Ok, -ve on error
> + */
> +int udc_device_put(struct udevice *udev);
> +
>  #if CONFIG_IS_ENABLED(DM_USB_GADGET)
>  int usb_gadget_initialize(int index);
>  int usb_gadget_release(int index);
> --=20
> 2.40.1
