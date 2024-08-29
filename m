Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746ECC7EE2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69C38862E;
	Thu, 29 Aug 2024 09:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z243D5fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C3488967; Thu, 29 Aug 2024 09:42:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AD288360
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428e3129851so2984815e9.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724917337; x=1725522137;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SLlvDF4RMp2Y8ZIkugQxNoqaCF11HLiM/SZz9yM6EDs=;
 b=z243D5fb8B6rPrn5sz5Ep+KtGoixUTUuVtK4XJehgz6TnoJgwNC6uiXUPuc3enLf0O
 Yf7CIXwGcCBWmqpfQT+H9DqxqlD3ha4pJ2Idbxt1mzuQeB7t1TUD2/c2K0QfA/X9pLZW
 lB7WH0UfaaDiFhUXifA54aLsAee117eNjPtP18jWSlhco8/nKZqUtrI/KUgDVZ3ZaJhy
 WvpC/G/0wYgT3k8CI269LoBHe21R0IlpyEduwlTrWxlSGEuG8wSd7HT/rHiSQSSYGVRR
 bM1SthZvS8Lvgpb24KeVQvg7HPaX++fs6vPO0PrVnRfcY7VX1zoRx0VG3RuxjtE9Ce6P
 PQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724917337; x=1725522137;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLlvDF4RMp2Y8ZIkugQxNoqaCF11HLiM/SZz9yM6EDs=;
 b=YUQjJzrN3HhJUJ40t6KQIyW1zh7mh8QnB6Icw6cUtqLtqMc98POKHVC98OmE8R+Veg
 vfm9TF/clgQVoXk7Rhm/rf23OCd2UkRXyxztoOUwViTV2g14YtDQ3nXYLQlUi0s74T9e
 rh1JtkVK8dWxiasx0zWn1Uy5zn2VoMDcQ1lPPiwIpZw0sMdFJE6lpx0QBXUunJ0sh+Dw
 bx5k70lDoJUn9xQ6xn8XT0HS5FrDyWK5qQYe1rK+XzbqXKTrWpiC7C/cG0inR2UqdR6/
 RNeAF/62uawX4pcny+f2MT8BCcZ2Bga0jMcPCbRxAYD7hUZxMAmFL9iGeMasw6nrXASb
 wEjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+lBU8IocnagjukJzXspjBf5BGPwW9aHg3OlYedFp3CggmBCmhqLKNz5JEXpAmhWvKTNjROiw=@lists.denx.de
X-Gm-Message-State: AOJu0YwB+Ow07gpPlOA9CKwar5BdrGc4yLHP4y9rGPbVLTG3TwU5s0M1
 MSZ6V9F43zGPYSKlN2y9wW4UUtdQuaB49JIRPXDACiyzPlPNsflErzFrEG3z0R/IzMGTfQjBwPn
 G
X-Google-Smtp-Source: AGHT+IFVnqFLvPrn/F2rit3Bnbq+9rZBRBBK04zJtp6yfsJAhYyCawmRR7oLkQaLWkRiyRVhWv0qlg==
X-Received: by 2002:a05:600c:1383:b0:428:640:c1b1 with SMTP id
 5b1f17b1804b1-42bb01c1b7bmr16836565e9.17.1724917336708; 
 Thu, 29 Aug 2024 00:42:16 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb2dcsm8923535e9.1.2024.08.29.00.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:42:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Linus Walleij
 <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nishanth Menon <nm@ti.com>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 3/6] usb: gadget: Track driver data as part of struct
 usb_gadget
In-Reply-To: <20240826143851.8020-3-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-3-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Aug 2024 09:42:13 +0200
Message-ID: <8734mnsrl6.fsf@baylibre.com>
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

> Move driver data directly into struct usb_gadget {} in preparation for
> conversion of struct device to struct udevice * in struct usb_gadget.
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
>  include/linux/usb/gadget.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index d62fba0ca02..a2b8520bc99 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -544,17 +544,18 @@ struct usb_gadget {
>  	unsigned			a_alt_hnp_support:1;
>  	const char			*name;
>  	struct device			dev;
> +	void				*driver_data;
>  	unsigned			quirk_ep_out_aligned_size:1;
>  };
>=20=20
>  static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
>  {
> -	gadget->dev.driver_data =3D data;
> +	gadget->driver_data =3D data;
>  }
>=20=20
>  static inline void *get_gadget_data(struct usb_gadget *gadget)
>  {
> -	return gadget->dev.driver_data;
> +	return gadget->driver_data;
>  }
>=20=20
>  static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
> --=20
> 2.45.2
