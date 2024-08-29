Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A6C7EE2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB1088B59;
	Thu, 29 Aug 2024 09:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wJfTQE6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4573D88B63; Thu, 29 Aug 2024 09:41:11 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4204788B59
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ab880b73eso3171895e9.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724917269; x=1725522069;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xIZ789hPjy4vtiVPvHAzjr9MXxmDU3EGVqPHvhXpbLo=;
 b=wJfTQE6naM2EYIN7yOfxBjuChMX5jwbYJcN31oVxSqofo41ZdXwAwityGo0PMGNVJm
 IEF8nKGxeEKM71iR1YMKctNtaRSaz2eRTtfoVae9XlYJiv+HDsiux/IaTRqS0jisJ/CQ
 6+R3MneaqPY70LDVskWh9euxEO1rh+MmmfGa/noVlG5jfDXj797zeqQETR3P/cTLWcr3
 EJBa6O4K+xjFz9Tp+I6nkonJtu5z+e+O1tptNUWsQ7zU0CkbwHHi5P7gMuYy+n0vRCXb
 t4uARpYhdmokdCEgOi5rlWvwjOKhFrQhksGIDgq/QEjh5g80FDMW5Loz57gcbp5kAvrQ
 mngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724917269; x=1725522069;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIZ789hPjy4vtiVPvHAzjr9MXxmDU3EGVqPHvhXpbLo=;
 b=rreffH/jnn7enzEliv1urLAp6RV9yUcDC8LTAgyBQSDR/10EgnodFJtX807ukUBuGr
 gWEYp0C2NeY39LNWCOYeGH0uVoNBR71cvpT7EcXghCl8Zo2l0m2rxfc5dGaRZ2qjc+//
 TpqUdkfQTLSwLY9EiCql81B/zUdTaMdhanLUoH0OVlRV5IsRzt1ChujiqStlGeOh6XM7
 eZ+tv8BsQH8xa7PynGXkZ0RnmVSH/7wsiyW3vtoSgsLp4RgNfwrRcHWh9vAWRrHlOIr9
 vLN+zlyHPa8a0a6Cj3hE9iot5UNPxzDo1WbcviW5Bq1EQgDjdvDQoSJCo0EaY1a+JBD3
 vbcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXecoSRD3nRBk/kdJWZk8U+XmdaEJXl2y5yNHemWRiwDKMJyGJaPsgmacj3McFfj95XGsQvgHs=@lists.denx.de
X-Gm-Message-State: AOJu0YxzOGWVnVejZWASZzy6ln3UrtAXeSS1sAl+nLUhKdTSIMhH1LUL
 +MjGkkWtJFn8p4WJ+Dt5YejW+UJaSkRCEJJNPwFLZCzdn6xs5sI/mSlNmA0HdQU=
X-Google-Smtp-Source: AGHT+IFiuw5dOteSr8mZglHuHBjg35ms3Se3DaFlXynCv3WzKJoD6wG4ONxN1jV+vI0QIdpsyhTfkA==
X-Received: by 2002:adf:f4ce:0:b0:371:8f16:1ccc with SMTP id
 ffacd0b85a97d-3749b5867a0mr1140447f8f.56.1724917268127; 
 Thu, 29 Aug 2024 00:41:08 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb14bfsm693260f8f.104.2024.08.29.00.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:41:07 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 2/6] usb: gadget: Drop usb_udc_release()
In-Reply-To: <20240826143851.8020-2-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-2-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 09:41:05 +0200
Message-ID: <875xrjsrn2.fsf@baylibre.com>
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

> This callback is never called, drop it. Instead, call kfree(udc)
> in usb_del_gadget_udc() to free the struct usb_udc data.
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
>  drivers/usb/gadget/udc/udc-core.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/u=
dc-core.c
> index 37c0ee43c52..275d6fe7be8 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -41,7 +41,6 @@ struct usb_udc {
>  	struct list_head		list;
>  };
>=20=20
> -static struct class *udc_class;
>  static LIST_HEAD(udc_list);
>  DEFINE_MUTEX(udc_lock);
>=20=20
> @@ -150,21 +149,6 @@ static inline void usb_gadget_udc_stop(struct usb_ud=
c *udc)
>  	udc->gadget->ops->udc_stop(udc->gadget);
>  }
>=20=20
> -/**
> - * usb_udc_release - release the usb_udc struct
> - * @dev: the dev member within usb_udc
> - *
> - * This is called by driver's core in order to free memory once the last
> - * reference is released.
> - */
> -static void usb_udc_release(struct device *dev)
> -{
> -	struct usb_udc *udc;
> -
> -	udc =3D container_of(dev, struct usb_udc, dev);
> -	kfree(udc);
> -}
> -
>  /**
>   * usb_add_gadget_udc - adds a new gadget to the udc class driver list
>   * @parent: the parent device to this udc. Usually the controller driver=
's
> @@ -185,8 +169,6 @@ int usb_add_gadget_udc(struct device *parent, struct =
usb_gadget *gadget)
>  	dev_set_name(&gadget->dev, "gadget");
>  	gadget->dev.parent =3D parent;
>=20=20
> -	udc->dev.release =3D usb_udc_release;
> -	udc->dev.class =3D udc_class;
>  	udc->dev.parent =3D parent;
>=20=20
>  	udc->gadget =3D gadget;
> @@ -247,6 +229,7 @@ found:
>=20=20
>  	if (udc->driver)
>  		usb_gadget_remove_driver(udc);
> +	kfree(udc);
>  }
>  EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
>=20=20
> --=20
> 2.45.2
