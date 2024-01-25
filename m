Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC24C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F2587B8C;
	Thu, 25 Jan 2024 17:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3OaFRgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAD787BAD; Thu, 25 Jan 2024 17:14:32 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B0487A2A
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbedb1ee3e4so6516233276.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199267; x=1706804067; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n35D2Ea/WyYTwSNrtM3gf3lM/lVT9J6EnF3bTB3xlew=;
 b=f3OaFRgjar+h60tE/UDu+BePi9oZit+jCmer7v8OZKotkwbLmOa5oKrGAtFrvxWHBj
 gLJmB5ZzHrnNXXporDMKwmum61EGPfMtnbdxn3YN5p/kVEu9P9+yV6EuMLDatlrwGaDv
 4CmOFVcMeVOju3ztmF1A9OzRMLhsfPn5TrUt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199267; x=1706804067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n35D2Ea/WyYTwSNrtM3gf3lM/lVT9J6EnF3bTB3xlew=;
 b=XfYckaWrwnw/7l0i7bTfBwty2JADN98BNzQHEZD3REiGhUV6r88AlULAY5DS1QPqu3
 //g/ERxWf8O/AThmB7C792ZE7RtifMi/DuIIb4dajc/+z4e/++yOUnVxp7uEmbxEoeGc
 y0WNuL6yxBdYHnun9PX0HgHXrY0Tu5M2sjzdLvr4q++2qZ1tu+QWf7LM0Q14lBQGEt3h
 E3BTvbb0Tshd7Wwr/rtipxMkAr+NYSI3WzWpH3cKmVg8ryvmORASE1aAFg1xSiV1uh2T
 EaHcKevoZpBU/oe0vQbzFQf4F70FKmmkePk2KEEUSItGSmhQ8kQiFAD24MEdHzGr+/Wf
 ZKlg==
X-Gm-Message-State: AOJu0YzoR9Mm+qHZuYFDDYXo9myzIhkngv4bOG00lAn8ZAVVCWYVfnxn
 6e7YB333MyCvBjAjdZSXpgT3OQFCqrv1ahNFUCQfqnWdM6BUVGVI488lZqAhrmI=
X-Google-Smtp-Source: AGHT+IG0o7SMFzVuQrYBOJH+FQfBgEFz9QWUrjYvQJtT4qIzvcHiJsLevUFAAfLFGHftr3/yyYPssg==
X-Received: by 2002:a25:804e:0:b0:dc2:1d63:ca31 with SMTP id
 a14-20020a25804e000000b00dc21d63ca31mr38351ybn.8.1706199267279; 
 Thu, 25 Jan 2024 08:14:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 h20-20020a25b194000000b00dc22fa579c5sm3570516ybj.45.2024.01.25.08.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:26 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:24 -0500
From: Tom Rini <trini@konsulko.com>
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Josua Mayer <josua@solid-run.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] headers: don't depend on errno.h being available
Message-ID: <20240125161424.GP3652023@bill-the-cat>
References: <20240118181106.4133924-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RKcC9c5YMkwmiNx1"
Content-Disposition: inline
In-Reply-To: <20240118181106.4133924-1-max.oss.09@gmail.com>
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


--RKcC9c5YMkwmiNx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 07:10:47PM +0100, max.oss.09@gmail.com wrote:

> From: Max Krummenacher <max.krummenacher@toradex.com>
>=20
> These headers follow the pattern:
>=20
> | #if CONFIG_IS_ENABLED(FANCY_FEATURE)
> |   void foo(void);
> | #else
> |   static inline void foo(void) { return -ENOSYS; }
> | #endif
>=20
> In the #else path ENOSYS is used, however linux/errno.h is not included.
> If errno.h has not been included already the compiler errors out even
> if the inline function is not referenced.
>=20
> Make those headers self contained.
>=20
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--RKcC9c5YMkwmiNx1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiOAACgkQFHw5/5Y0
tywvlQwAlJeebfVMwtWayUlAjovsodqOErrPnAzF4X69yN4IZq9194BzMgoMo8HV
ptosMKhMqdpjaVo1kKHvXgRXCrlFLf5KvTTwjixuV/lAyM8ICdZxiDMjlW8yarlU
fNLiSjMTGA6IM4RbtdKfxWwvvo4Enjb3/NivCnMyDFbd5Jhq6OOAeCBYxMJNzgI0
mLimVioc3TllKTZLB7LAlarH5+jhlXOqtJ2oOhL2WIOg1lvXzf5dE0mUs5McmG15
h2LIKtOm3BhnTf658xKb9Ns9nDuxNbDmdox4gxLYmovSsHlsc+ng7Bwj6Yz8SsEZ
4SnPMTp21Yh9tMWCzbk+CHJMaosFFEsVdy8V43Yod/MwLOnnziJ4M7WFv9+kffKL
et1BcmIVlUXCxDgErt2nYCUfydAB0LtPN7Ndrdzch0aOauV/6GgfUFmGnch5eTAK
WQH+eljgVyv9ENr9+ofeQHbVwW5/m/VZWltx0721/5OzbCqu1gmOOpExHZzKSbiQ
2mYuukXk
=GhKX
-----END PGP SIGNATURE-----

--RKcC9c5YMkwmiNx1--
