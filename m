Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B187AC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88C380977;
	Tue, 25 Feb 2025 17:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LBotmgxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6AE80EC0; Tue, 25 Feb 2025 17:13:43 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A2C80805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4be7f663b50so1925003137.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740500019; x=1741104819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y38F6mAH44N23CGT4zcqi97oar7/eTjRjmS43OF/qDA=;
 b=LBotmgxeDcns/4zjZ8sww2PtNG2WLuJnV/ieImBBT1eGZbDcozksqP5fPiMs6Nn3RO
 YT+dVVYKeI/DlyRHqzruXve6eerOWW7jULQSJZfN9KQP13vXiiqMPW5WlLhWY1/eVB/b
 35stSfdDLTgEY7EcPp6BatWEv0Jm44Nco6ouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740500019; x=1741104819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y38F6mAH44N23CGT4zcqi97oar7/eTjRjmS43OF/qDA=;
 b=IROM0BchP8Z5MFb8EZUztqPKw9Tz6316WTCvrIn9ofc+lLGo/8TWtdvWsOQ3OeK24y
 RxOaM5s7FiqF0mt4C8JJVX3eI++VqIBaHsztjVi2FrJ0tbgxxcvLGtdt3KCQpBf+E6Jj
 mxFzt3AXqarYP/IUFVo/sQK2KtzXyDzGPZ/luG+WqLxw/zMHUlS+aJScLSv/sUYbJxCg
 e45exRVYEG0seuShMThDg/7lPO1buHuv72sjr6T+7IUw3YoN2a2oEhGcI1cPsQOkOeFb
 PLUi+4TlXZEh52ZzK2/Y4hTH3MBkLllqv6ajMbojgjfOdwk0jv2I92QHVGKNKqau8ylx
 v8IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+xTV4Zvc3AVj6EEpTfl29f8MaVZPXp8y6ctqwy94wTocZ5Z8swfG6XxubxICTC5/FGVbjN6k=@lists.denx.de
X-Gm-Message-State: AOJu0YyDGebz3mpoA00cUzX8vViRp7Jl1DZO4Z4Gdzi1wTKUx/4/a/oY
 lgib2JexRitdsd1l73WaHHHvmJcHE3vyEl5clmGwroaBeJlPWJ8yApBNjf65uf8=
X-Gm-Gg: ASbGnctAn+VSTKMR3K0bUe0s8ImLdSotpKS19TFiGOJwV1vIT+Jh9/u04/9//TvAh48
 XMHco6Oj6WPSk9EpaYkkVLuoz8vzpZMl5sANVG+QOxA+YPF+/X/qz9zTbpff3q8EUzGhPfHdMQZ
 90JIqVLCS76+62j/MMvo/LlZZJqemBzmzT736Asubhr+v1kPlNH4ENZhOabwXJEpEB7DPhuBUlD
 PYCiTRfxkbDR0SL86WedOu47Sxg2rS8iEJQ3iH1G6r3mcR5pRfvZzR6ldJfPHPGRlKfn4KMxNvS
 89sZkUHqKFbiOI0ARd9or3Ie
X-Google-Smtp-Source: AGHT+IGFeGoxqQ6kYi5NhZF0r+txC5EpTkK+9pWYtmtgiIPgT1pKD9YFN1XtRHAUhwpnk3bGqVyxVw==
X-Received: by 2002:a05:6102:3a10:b0:4bb:cf34:374d with SMTP id
 ada2fe7eead31-4bfc016552fmr10312679137.20.1740500018707; 
 Tue, 25 Feb 2025 08:13:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ef052a6sm366884241.27.2025.02.25.08.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:13:37 -0800 (PST)
Date: Tue, 25 Feb 2025 10:13:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v1] led: fix next coverity scan error
Message-ID: <20250225161334.GO1233568@bill-the-cat>
References: <20250225094923.71364-1-hs@denx.de>
 <308422ff-3036-48ed-9d78-305b6904fc87@cherry.de>
 <ace167e3-1535-7184-6583-0e9654a8c7d2@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uwZMQeqr8edMoWP1"
Content-Disposition: inline
In-Reply-To: <ace167e3-1535-7184-6583-0e9654a8c7d2@denx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--uwZMQeqr8edMoWP1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:29:29PM +0100, Heiko Schocher wrote:
> Hello Quentin,
>=20
> On 25.02.25 12:13, Quentin Schulz wrote:
> > Hi Heiko,
> >=20
> > On 2/25/25 10:49 AM, Heiko Schocher wrote:
> > > Tom reported the following covervity scan error:
> > >=20
> > > *** CID 542488:=A0 Control flow issues=A0 (NO_EFFECT)
> > > /drivers/led/led-uclass.c: 277 in led_get_function_name()
> > > 271=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n uc_plat->label;
> > > 272
> > > 273=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Now try to detect function=
 label name */
> > > 274=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 func =3D dev_read_string(dev,=
 "function");
> > > 275=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cp =3D dev_read_u32(dev, "col=
or", &color);
> > > 276=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // prevent coverity scan erro=
r CID 541279: (TAINTED_SCALAR)
> > > > > > =A0=A0=A0=A0 CID 542488:=A0 Control flow issues=A0 (NO_EFFECT)
> > > > > > =A0=A0=A0=A0 This less-than-zero comparison of an unsigned valu=
e is never true.
> > > "color < 0U".
> > > 277=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (color < LED_COLOR_ID_WHIT=
E || color >=3D LED_COLOR_ID_MAX)
> > > 278=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cp =
=3D -EINVAL;
> > > 279
> > >=20
> > > see:
> > > https://lists.denx.de/pipermail/u-boot/2025-February/581567.html
> > >=20
> > > Fix it.
> > >=20
> > > Signed-off-by: Heiko Schocher <hs@denx.de>
> > >=20
> > > ---
> > > Azure build:
> > > https://dev.azure.com/hs0298/hs/_build/results?buildId=3D171&view=3Dr=
esults
> > >=20
> > > =A0 drivers/led/led-uclass.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
> > > =A0 dts/upstream/include/dt-bindings/leds/common.h | 5 ++++-
> >=20
> > NACK. We don't modify files in dts/upstream as they are directly
> > imported from devicetree-rebasing tree and would either be replaced
> > during next update or induce a merge conflict.
>=20
> Ah, yes, indeed!
>=20
> > > =A0 2 files changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> > > index 22f61d12d38..e2edcc43f30 100644
> > > --- a/drivers/led/led-uclass.c
> > > +++ b/drivers/led/led-uclass.c
> > > @@ -274,7 +274,7 @@ static const char *led_get_function_name(struct u=
device *dev)
> > > =A0=A0=A0=A0=A0 func =3D dev_read_string(dev, "function");
> > > =A0=A0=A0=A0=A0 cp =3D dev_read_u32(dev, "color", &color);
> > > =A0=A0=A0=A0=A0 // prevent coverity scan error CID 541279: (TAINTED_S=
CALAR)
> > > -=A0=A0=A0 if (color < LED_COLOR_ID_WHITE || color >=3D LED_COLOR_ID_=
MAX)
> > > +=A0=A0=A0 if (color >=3D LED_COLOR_ID_MAX)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 cp =3D -EINVAL;
> > > =A0=A0=A0=A0=A0 if (cp =3D=3D 0 || func) {
> > > diff --git a/dts/upstream/include/dt-bindings/leds/common.h
> > > b/dts/upstream/include/dt-bindings/leds/common.h
> > > index 4f017bea012..9e5ac5196e2 100644
> > > --- a/dts/upstream/include/dt-bindings/leds/common.h
> > > +++ b/dts/upstream/include/dt-bindings/leds/common.h
> > > @@ -21,7 +21,10 @@
> > > =A0 #define LEDS_BOOST_ADAPTIVE=A0=A0=A0 1
> > > =A0 #define LEDS_BOOST_FIXED=A0=A0=A0 2
> > > -/* Standard LED colors */
> > > +/*
> > > + * Standard LED colors, LED_COLOR_ID_WHITE must be the
> > > + * first one and start with value 0
> > > + */
> >=20
> > Can you explain why white needs to be the first AND be 0?
> >=20
> > I don't know enough about the C standard or compilers in general to know
> > what happens if the indices in led_colors aren't in order but I guess
> > that's where your limitation comes from?
> >=20
> > e.g.
> >=20
> >  =A0 static const char * const led_colors[LED_COLOR_ID_MAX] =3D {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_WHITE] =3D "white",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_RED] =3D "red",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_GREEN] =3D "green",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_BLUE] =3D "blue",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_AMBER] =3D "amber",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_VIOLET] =3D "violet",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_YELLOW] =3D "yellow",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_IR] =3D "ir",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_MULTI] =3D "multicolor",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_RGB] =3D "rgb",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_PURPLE] =3D "purple",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_ORANGE] =3D "orange",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_PINK] =3D "pink",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_CYAN] =3D "cyan",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_LIME] =3D "lime",
> >  =A0 };
> >=20
> > is ordered, but what happens if you have e.g.:
> >=20
> >  =A0 static const char * const led_colors[LED_COLOR_ID_MAX] =3D {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_RED] =3D "red",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_WHITE] =3D "white",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_GREEN] =3D "green",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_BLUE] =3D "blue",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_AMBER] =3D "amber",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_VIOLET] =3D "violet",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_YELLOW] =3D "yellow",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_IR] =3D "ir",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_MULTI] =3D "multicolor",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_RGB] =3D "rgb",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_PURPLE] =3D "purple",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_ORANGE] =3D "orange",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_PINK] =3D "pink",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_CYAN] =3D "cyan",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 [LED_COLOR_ID_LIME] =3D "lime",
> >  =A0 };
> >=20
> > ? I think it should be just fine?
>=20
> Yep, fully fine, so I drop simply this comment.
>=20
> > Reading the code, it seems there's an assumption that led_colors has a
> > contiguous and full list of indices from LED_COLOR_ID "enum". What
> > happens when the dt-binding gets extended with new colors and the DT
> > makes use of it without updating led_colors in led-uclass.c? Aren't we
> > going to try to print a NULL string?
> >=20
> > If that's the case, I see two solutions:
> > - ignore LED colors when they aren't in led_colors,
> > - decouple LED_COLOR_ID_MAX from the binding with UBOOT_LED_COLOR_ID_MAX
> > which is the currently supported max based on led_colors last index
> > (+1). We could even do a #warn or #error so that UBOOT_LED_COLOR_ID_MAX
> > and LED_COLOR_ID_MAX are the same value so that we're forced to keep
> > them in sync, but that'll make Tom's life harder when merging newer
> > releases of devicetree-rebasing tree.
>=20
> Yep... may Tom can comment here, what he prefers, thanks for the review!

We should just expand the comment in the uclass when checking to note
that we don't need to check the lower bound, only upper bound due to
typing.

--=20
Tom

--uwZMQeqr8edMoWP1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme97CsACgkQFHw5/5Y0
tyzSEgwAlmbBZiLOGouB7gf/Kl5FAlElrtuBmYTkZTypqHLy11oIpiqBD4DCLiX0
y/T7S+y/ym6nDfPVtSCcsf33IVF6KXn96U4dTQnykvi6Az4YjUbA3fUvfFU+D8yF
70p4GFtrE6CYmwZ/1qaz1+cUOswREtLw5ibQfgIQ96FnDklgepESQ5R+Jk+Iah+P
AuCXHeGI5qAy+gHDBtUXnViOFGVjZkoChmhxV/naO3bU/HxDVvG7MkcqJhr7tfzW
DPirGtXu/8UJEEx8EnM0exR5KDwIQrk/Xq5kvioT2joyatvtnPY1KiCtXDHq0C2a
+j9VtkY6v3k5Cs/D/bYcBpGSYW14Bw/BaD4+3wbzI3HNcjYMEJt88MAjJVA8z5Y7
eVg/3tXYVpb0syiUroCZ/UyWkJgcQAo5T5Ths/yVDuoeeK5a+ledDhXH82LlIVOo
rSDOGWbDbNIYT7bpmutYaNQ/RadOCF8V2xQHHj6Mr2Ntfr3Z5JkEa4IxeHQyO8iK
i+TknMhD
=8Rgv
-----END PGP SIGNATURE-----

--uwZMQeqr8edMoWP1--
