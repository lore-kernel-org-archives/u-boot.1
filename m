Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E6C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2A088B84;
	Thu, 29 Aug 2024 10:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W7NnFztt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487908891E; Thu, 29 Aug 2024 10:44:15 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E099588B70
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso3207495e9.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724921052; x=1725525852;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tKSmnPfQt5CfjBkWbYl37QK/cnIexEstUEBT3PinNq4=;
 b=W7NnFzttGw6Z9QBEnAsse5jhg1LFX4kQQfwdFcxrdqAX5giE9wkdOdV8QdpQtEuItB
 yvVL4WvPJFDbz32gQv65MXznTrUgxK4D9kLIh+mJX8EU/weSZPNKdCnCWDNU6ZZhoM0C
 VLHyehyHrOYctgy8cjEe2zUWclOXNS0md5RmPI2GfGTkks0WF7269YoSXG3jJ/H3Z3yM
 QSr0i5i3h453OtnyGhc51zLdEaqjObs4a+yRtF4xIxRkrGJ8x5Gi+sE2YDfPQXALL+h8
 qimcXGLK8c/6xAA4v6E+YMougfV0yMzSvuDPeu0IwJvDq+J1MhvJTDoGjsrVH9eL+Kd2
 cvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724921052; x=1725525852;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKSmnPfQt5CfjBkWbYl37QK/cnIexEstUEBT3PinNq4=;
 b=iP0MBnw37hyxsL4ugyNaN0kvz93IElHGcnuuCueCl6Kw6WINMzgr8PHe0GkoCbx0k1
 tVh9U0kjlh07TZ9rLZl8Ja2WAsR2zGHi3db8/yzy7L+8/wjnB3kVIc+0gnpTWkHL653j
 /czy57b5Hu/hpfz9/b8/XKxndkwJaDPh1hMWFEmjFXrzktBmtKB8taMr941k5JPS4DIj
 InDdPAmNoLxJvCjT7+oawq5fQ5uOnfcyUAMzstJNvRuq49wdm7cDdamXvLLGPYcbKlma
 dkktdvklkdZWSROJ1jTd7yaqxWtAkvfzeh5vRr0GwqfJ8x7GlsRk0lFQnIM9mZjUoCne
 /LPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+sCk1nHy8IeEQzwHEMwNS2NnOrza9W/z5/JcDMAbYUjbVv0L30IfU0Kn7CynyA5in1d0l2xE=@lists.denx.de
X-Gm-Message-State: AOJu0YygaiTIvYCFPWsdwCkEgKuiRpHETTiu5aVhbjh3x9+XAxnoWEQ0
 0q+7MJ6DBsMfZgc34+A7KxSVhJcINswwVr68V4+IN2Lvifwme+t3/Qoqzomhtzw=
X-Google-Smtp-Source: AGHT+IFGEhiyhJSTJf8I9K+4nvUpaG5eZmPY0lpyO1uRTvH9G4vreeMCx1cMqUfek3h/ctYDAJ1Qcw==
X-Received: by 2002:a05:600c:1c83:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-42bb02c10a4mr14640975e9.8.1724921051474; 
 Thu, 29 Aug 2024 01:44:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a4dsm10144585e9.12.2024.08.29.01.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 01:44:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 6/6] usb: gadget: Pass struct udevice to
 usb_add_gadget_udc()
In-Reply-To: <20240826143851.8020-6-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-6-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 10:44:08 +0200
Message-ID: <87ttf3ra5j.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On lun., ao=C3=BBt 26, 2024 at 16:38, Marek Vasut <marek.vasut+renesas@mail=
box.org> wrote:

> Almost every UDC driver already passes casted pointer to struct udevice
> usb_add_gadget_udc(), even if the behavior is not exactly correct. That
> struct udevice is at risk of being corrupted in case something modified
> it in the UDC core, which does not happen right now. Switch UDC core to
> use struct udevice outright and drop the casts.
>
> UX500 has to be updated slightly, as that is the last place which does
> correctly use private struct device instance.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/usb/cdns3/gadget.c        |  2 +-
>  drivers/usb/dwc3/gadget.c         |  2 +-
>  drivers/usb/gadget/dwc2_udc_otg.c |  2 +-
>  drivers/usb/gadget/max3420_udc.c  |  2 +-
>  drivers/usb/gadget/udc/udc-core.c | 19 +++++++++----------
>  drivers/usb/mtu3/mtu3_gadget.c    |  2 +-
>  drivers/usb/musb-new/omap2430.c   |  2 +-
>  drivers/usb/musb-new/ti-musb.c    |  2 +-
>  drivers/usb/musb-new/ux500.c      |  2 +-
>  include/linux/usb/gadget.h        |  4 ++--
>  10 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 32b2c412068..b3513cc9bdc 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2660,7 +2660,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
>  	}
>=20=20
>  	/* add USB gadget device */
> -	ret =3D usb_add_gadget_udc((struct device *)priv_dev->dev,
> +	ret =3D usb_add_gadget_udc(priv_dev->dev,
>  				 &priv_dev->gadget);
>  	if (ret < 0) {
>  		dev_err(priv_dev->dev,
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fe33e307d3e..a3c3437aa3e 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2688,7 +2688,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>  	if (ret)
>  		goto err4;
>=20=20
> -	ret =3D usb_add_gadget_udc((struct device *)dwc->dev, &dwc->gadget);
> +	ret =3D usb_add_gadget_udc(dwc->dev, &dwc->gadget);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to register udc\n");
>  		goto err4;
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_=
udc_otg.c
> index fbd6c9600fc..4b6327d86d1 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -1135,7 +1135,7 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
>=20=20
>  	the_controller->driver =3D 0;
>=20=20
> -	ret =3D usb_add_gadget_udc((struct device *)dev, &the_controller->gadge=
t);
> +	ret =3D usb_add_gadget_udc(dev, &the_controller->gadget);
>=20=20
>  	return ret;
>  }
> diff --git a/drivers/usb/gadget/max3420_udc.c b/drivers/usb/gadget/max342=
0_udc.c
> index 557a1f0644e..7df73cd3625 100644
> --- a/drivers/usb/gadget/max3420_udc.c
> +++ b/drivers/usb/gadget/max3420_udc.c
> @@ -836,7 +836,7 @@ static int max3420_udc_probe(struct udevice *dev)
>  	max3420_setup_eps(udc);
>  	max3420_setup_spi(udc);
>=20=20
> -	usb_add_gadget_udc((struct device *)dev, &udc->gadget);
> +	usb_add_gadget_udc(dev, &udc->gadget);
>=20=20
>  	return 0;
>  }
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/u=
dc-core.c
> index 275d6fe7be8..102d74ec02a 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -37,7 +37,7 @@
>  struct usb_udc {
>  	struct usb_gadget_driver	*driver;
>  	struct usb_gadget		*gadget;
> -	struct device			dev;
> +	struct udevice			*dev;
>  	struct list_head		list;
>  };
>=20=20
> @@ -157,7 +157,7 @@ static inline void usb_gadget_udc_stop(struct usb_udc=
 *udc)
>   *
>   * Returns zero on success, negative errno otherwise.
>   */
> -int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
> +int usb_add_gadget_udc(struct udevice *parent, struct usb_gadget *gadget)
>  {
>  	struct usb_udc		*udc;
>  	int			ret =3D -ENOMEM;
> @@ -166,10 +166,9 @@ int usb_add_gadget_udc(struct device *parent, struct=
 usb_gadget *gadget)
>  	if (!udc)
>  		goto err1;
>=20=20
> -	dev_set_name(&gadget->dev, "gadget");
> -	gadget->dev.parent =3D parent;
> +	gadget->dev =3D parent;
>=20=20
> -	udc->dev.parent =3D parent;
> +	udc->dev =3D parent;
>=20=20
>  	udc->gadget =3D gadget;
>=20=20
> @@ -189,7 +188,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
>=20=20
>  static void usb_gadget_remove_driver(struct usb_udc *udc)
>  {
> -	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
> +	dev_dbg(udc->dev, "unregistering UDC driver [%s]\n",
>  			udc->driver->function);
>=20=20
>  	usb_gadget_disconnect(udc->gadget);
> @@ -216,13 +215,13 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
>  		if (udc->gadget =3D=3D gadget)
>  			goto found;
>=20=20
> -	dev_err(gadget->dev.parent, "gadget not registered.\n");
> +	dev_err(gadget->dev, "gadget not registered.\n");
>  	mutex_unlock(&udc_lock);
>=20=20
>  	return;
>=20=20
>  found:
> -	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
> +	dev_vdbg(gadget->dev, "unregistering gadget\n");
>=20=20
>  	list_del(&udc->list);
>  	mutex_unlock(&udc_lock);
> @@ -260,7 +259,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, st=
ruct usb_gadget_driver *dri
>  {
>  	int ret;
>=20=20
> -	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
> +	dev_dbg(udc->dev, "registering UDC driver [%s]\n",
>  			driver->function);
>=20=20
>  	udc->driver =3D driver;
> @@ -280,7 +279,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, st=
ruct usb_gadget_driver *dri
>  	return 0;
>  err1:
>  	if (ret !=3D -EISNAM)
> -		dev_err(&udc->dev, "failed to start %s: %d\n",
> +		dev_err(udc->dev, "failed to start %s: %d\n",
>  			udc->driver->function, ret);
>  	udc->driver =3D NULL;
>  	return ret;
> diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadge=
t.c
> index 027b7e61113..949b22f41c7 100644
> --- a/drivers/usb/mtu3/mtu3_gadget.c
> +++ b/drivers/usb/mtu3/mtu3_gadget.c
> @@ -631,7 +631,7 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
>=20=20
>  	mtu3_gadget_init_eps(mtu);
>=20=20
> -	return usb_add_gadget_udc((struct device *)mtu->dev, &mtu->g);
> +	return usb_add_gadget_udc(mtu->dev, &mtu->g);
>  }
>=20=20
>  void mtu3_gadget_cleanup(struct mtu3 *mtu)
> diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2=
430.c
> index ba600d01102..54dff01db71 100644
> --- a/drivers/usb/musb-new/omap2430.c
> +++ b/drivers/usb/musb-new/omap2430.c
> @@ -231,7 +231,7 @@ static int omap2430_musb_probe(struct udevice *dev)
>  		if (!host->host)
>  			return -EIO;
>=20=20
> -		return usb_add_gadget_udc((struct device *)otg_board_data, &host->host=
->g);
> +		return usb_add_gadget_udc(dev, &host->host->g);
>  	}
>=20=20
>  	musbp =3D musb_register(&plat->plat, (struct device *)otg_board_data,
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-mus=
b.c
> index ec1baa9337d..9e3f793af06 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -247,7 +247,7 @@ static int ti_musb_peripheral_probe(struct udevice *d=
ev)
>=20=20
>  	ti_musb_set_phy_power(dev, 1);
>  	musb_gadget_setup(priv->periph);
> -	return usb_add_gadget_udc((struct device *)dev, &priv->periph->g);
> +	return usb_add_gadget_udc(dev, &priv->periph->g);
>  }
>=20=20
>  static int ti_musb_peripheral_remove(struct udevice *dev)
> diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
> index be0085f403d..c994dc2f04d 100644
> --- a/drivers/usb/musb-new/ux500.c
> +++ b/drivers/usb/musb-new/ux500.c
> @@ -130,7 +130,7 @@ static int ux500_musb_probe(struct udevice *dev)
>  	if (!host->host)
>  		return -EIO;
>=20=20
> -	return usb_add_gadget_udc(&glue->dev, &host->host->g);
> +	return usb_add_gadget_udc(dev, &host->host->g);
>  #endif
>  }
>=20=20
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 194025ebd12..e631f71eab8 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -543,7 +543,7 @@ struct usb_gadget {
>  	unsigned			a_hnp_support:1;
>  	unsigned			a_alt_hnp_support:1;
>  	const char			*name;
> -	struct device			dev;
> +	struct udevice			*dev;
>  	void				*driver_data;
>  	unsigned			quirk_ep_out_aligned_size:1;
>  };
> @@ -886,7 +886,7 @@ int usb_gadget_register_driver(struct usb_gadget_driv=
er *driver);
>   */
>  int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
>=20=20
> -int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
> +int usb_add_gadget_udc(struct udevice *parent, struct usb_gadget *gadget=
);
>  void usb_del_gadget_udc(struct usb_gadget *gadget);
>  /*----------------------------------------------------------------------=
---*/
>=20=20
> --=20
> 2.45.2
