Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF008C7EE2C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C94487D1A;
	Thu, 29 Aug 2024 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aaNbHz/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122A7878ED; Thu, 29 Aug 2024 09:08:49 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93B587D1A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso2434545e9.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724915325; x=1725520125;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=itQNSXbvc1hsH+qgM31hSWqUlKvAIDhgsRAo9AY1ZNY=;
 b=aaNbHz/kUKhHLWoEhu764WOr00wJwH6wSWj/v56lkORZOmxtOF2JXSXfhj/nf4OGx8
 VIdiwR0woloLcacAlJQv1tjoPMU666iz+TkQsbr8pQiVCjYdXzGkgYQ+0lc8BKFN1svD
 vNJWuDQfd17nLAHeZb15fVIVwriNWKwLEHg7q1CLWrk0fPayNMt1PheRRpp9/htIHU88
 koGUwfoGkGWOMSZu3f0n0OxY3JlKZxp6F6xadzCe8QYkV32HtMCDEH31/6fEetpl3yJt
 TMp+KHEngrqgM+W05z5DCWzHgZM2j3ObXZnOg5xTu7ay9RwolpL/DKVbw5E+2qtyn2Gw
 u/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724915325; x=1725520125;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itQNSXbvc1hsH+qgM31hSWqUlKvAIDhgsRAo9AY1ZNY=;
 b=dSdcoFmhz1YcHZPFzVQwgoVctnR/KUM9d8wuq6x0xYri6RAySZgBTFmaom0oVNrAQH
 jqkLvPF1VaR4b5Tg0Ow0P6enyDGpQNe10Aw9U/w/+RGJQRmpdqxynWVJrfRviCd3gl0q
 kRBpY0Y47ZV/U65ZFNTZL7ek0+79JC2b7VVGdIAYewe1htOsFt6yD2Uosbnu4O0zhy71
 +zwGyUJYdjVLE8VnOaA7u0GKmYwr+D9STm8i91+iUz1E3P1Mh/u5SshABrmb5WBebrqB
 Mu0puACGaSdRF2DQ9i4HZ/WI94aOIwUvMZJuRbePPkLJmxZLeBEMHuE21/rVPxAt0sgn
 5iDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWfIQrcoUD28jb4i+yvi0yXBRBoT5CJibT0nkMFGov7Q7kDY2X6Ojd+bm6aanX7fTTfbQW7As=@lists.denx.de
X-Gm-Message-State: AOJu0YzaF1t2TtHkCpW0ztuaCgmuQXQNBmpvRpnPzvPXm+3v71DXKXU2
 Z8+Yq0Cug8swWF3GPaO2RB9rTA+iaf8HEAQnAcKIaQQoTOqAl0f0jRzlM04Uxq0=
X-Google-Smtp-Source: AGHT+IEJHc5v7Al12pzgZbVbJnDs1N5KK2SarATxLIufJbUbexJPI/AV2IBWuP+SqZ6pxoVZmicYzw==
X-Received: by 2002:a05:600c:1550:b0:426:6000:565a with SMTP id
 5b1f17b1804b1-42bb02f050emr12055035e9.16.1724915324519; 
 Thu, 29 Aug 2024 00:08:44 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df954asm7969665e9.26.2024.08.29.00.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:08:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 1/6] usb: gadget: Inline usb_add_gadget_udc_release
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 09:08:41 +0200
Message-ID: <878qwfst52.fsf@baylibre.com>
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

> The release parameter of usb_add_gadget_udc_release() is never used.
> The function is never called from anywhere except from a wrapper in
> udc-core.c . Inline the function into the wrapper.
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
>  drivers/usb/gadget/udc/udc-core.c | 20 ++------------------
>  include/linux/usb/gadget.h        |  2 --
>  2 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/u=
dc-core.c
> index 6bb419ae2ab..37c0ee43c52 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -166,16 +166,14 @@ static void usb_udc_release(struct device *dev)
>  }
>=20=20
>  /**
> - * usb_add_gadget_udc_release - adds a new gadget to the udc class drive=
r list
> + * usb_add_gadget_udc - adds a new gadget to the udc class driver list
>   * @parent: the parent device to this udc. Usually the controller driver=
's
>   * device.
>   * @gadget: the gadget to be added to the list.
> - * @release: a gadget release function.
>   *
>   * Returns zero on success, negative errno otherwise.
>   */
> -int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget =
*gadget,
> -		void (*release)(struct device *dev))
> +int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
>  {
>  	struct usb_udc		*udc;
>  	int			ret =3D -ENOMEM;
> @@ -205,20 +203,6 @@ int usb_add_gadget_udc_release(struct device *parent=
, struct usb_gadget *gadget,
>  err1:
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
> -
> -/**
> - * usb_add_gadget_udc - adds a new gadget to the udc class driver list
> - * @parent: the parent device to this udc. Usually the controller
> - * driver's device.
> - * @gadget: the gadget to be added to the list
> - *
> - * Returns zero on success, negative errno otherwise.
> - */
> -int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
> -{
> -	return usb_add_gadget_udc_release(parent, gadget, NULL);
> -}
>  EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
>=20=20
>  static void usb_gadget_remove_driver(struct usb_udc *udc)
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index c7927df15aa..d62fba0ca02 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -890,8 +890,6 @@ int usb_gadget_register_driver(struct usb_gadget_driv=
er *driver);
>   */
>  int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
>=20=20
> -int usb_add_gadget_udc_release(struct device *parent,
> -		struct usb_gadget *gadget, void (*release)(struct device *dev));
>  int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
>  void usb_del_gadget_udc(struct usb_gadget *gadget);
>  /*----------------------------------------------------------------------=
---*/
> --=20
> 2.45.2
