Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2204EC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6A918816A;
	Mon,  4 Mar 2024 16:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cgMQ9V0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC62880AD; Mon,  4 Mar 2024 16:29:02 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E228802B
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-220ee7342ddso745070fac.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566139; x=1710170939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pZHwg/srnTM7aGtM3v0+qaQhhU96eKlVB+Kuu/m7wm8=;
 b=cgMQ9V0pI6qUUlXML+RnT7bRdYAC3vbXdbvioM88TMA9aKIFlZjZnt9mH7ltzWLEBj
 onwJ9KQCxMVn5bwsTQDBSVRsqjBbzxTFnIvUbFNxVmbkkU05AGrw7Uvfg8ft2oWODCkn
 N+NVMyqaNOuFemdVe4y0PHdLuYenyk3Npco20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566139; x=1710170939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZHwg/srnTM7aGtM3v0+qaQhhU96eKlVB+Kuu/m7wm8=;
 b=YzFDzhON/ag4kHbq/Z1zLXJHeXDlDtISJUbhP1NvsGkFx7X98FSUq5SvBQh/O1k2p1
 x+0IS528b+iZYdfgjELIwrMQa4bj88QymbSwO8GvYw9UP/rVPVtSLX/GsLZ4K9LmNrfM
 XWt8S+CvOWeMSeUYRvAQCVb9wHhsJHcGLopFjhfkct142mgRZyV4fYttINe1lMd4oy4E
 mSCMJEgAdS1zTsDr1G/T3EE+c5zYvpbcLe1zbrByQvnY0ou+LhKZRVH/yqj9o41eaIOC
 VyKO1K4OtwQaaRrzkz7sxZlV3VAYekLP129WrBsEIcNS5Ti5hC8hdBiaqkZ/lDyaGNhc
 qh8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5XoAnimxuqZ/96F2rTbetSjo6E/ot3UyFwbkZMiTVHra1jzKX8gAVVY0JkuZruHA1eozQPZT6yvlIXOvDrBq7b/xcA==
X-Gm-Message-State: AOJu0YzKjTjM64MBZzKb55JsT5Zuhrwm85/8QszFxzWAu+sT80D6a0j1
 cyd/j+9WnRZ6gKoLaLr/FKMbpqQD96wp+Zx9SlBnlKONsKy8Ao5+REtiKPXFicOtc4/SFbe5t0m
 n
X-Google-Smtp-Source: AGHT+IFJyB7YkJ9mXRwYW4bRYGsJZh6HR4zg8A9Kxqlq5WGXIY7pJ1HCXxRj5vg+Az1iitR6Fz8fkQ==
X-Received: by 2002:a05:6871:3a07:b0:220:be4a:1df1 with SMTP id
 pu7-20020a0568713a0700b00220be4a1df1mr8135737oac.24.1709566139231; 
 Mon, 04 Mar 2024 07:28:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 h24-20020ae9ec18000000b00787d6a14d0bsm4455975qkg.10.2024.03.04.07.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:58 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] dm: core: Fix address translation in
 devfdt_get_addr_index()
Message-ID: <20240304152856.GI1523872@bill-the-cat>
References: <20240217131943.2472659-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z8G/dajzuzHc+qpA"
Content-Disposition: inline
In-Reply-To: <20240217131943.2472659-1-jonas@kwiboo.se>
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


--z8G/dajzuzHc+qpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 01:19:41PM +0000, Jonas Karlman wrote:

> During address translation #address/size-cells props are expected to
> apply to child nodes. However, devfdt_get_addr_index() incorrectly use
> the parent offset of the udevice parent instead of getting the offset of
> the node parent. This will work in most cases when there is only one
> udevice tied to a node.
>=20
> On e.g. an Orange Pi R1 Plus TLS board the dwc3-generic (parent) and
> dwc3-generic-host (child) udevice is tied to the same node.
>=20
> In that case both the offset and parent values end up being the same.
> As a result, the #address/size-cells props intended for child nodes
> incorrectly gets applied to the node itself resulting in wrong addr
> being returned, 0x0 instead of 0xff600000.
>=20
> The following can be seen on console:
>=20
>   dwc3-generic-host usb@ff600000: this is not a DesignWare USB3 DRD Core
>   dwc3-generic-host usb@ff600000: failed to initialize core
>=20
> Fix this by using the offset of the parent node and not the offset to
> the node the parent udevice is tied to.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/next, thanks!

--=20
Tom

--z8G/dajzuzHc+qpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6LgACgkQFHw5/5Y0
tyxvUwwApK7u/dh9P5Gs0EPu/2pp/Vf0tP6+T5ItXjQ9ACsSDLRDXZBUbsmJsoJZ
cXAeDuN5RxczXOAA6QDdkT7AvzT8NeL/6+6qkM9vQ0/PLk4lqXnmVR+MLVDWyVTI
HOo2fPb1YIpFT+wWuKSLkSNGQcXeV3SgQksiNewYUzVW3vVJjvMnWi51DP6lECRV
qyxusjY+8SgdGsCNLWenzae/G7n6WRMKkRoVkrX0BEeYIeD/4NQ8g8kGtquItsQG
/NBskbfg2cpAjwpq4RM5vX9baOv8s+mYZYHSmgQVeRAs1Fu2pTOvI5suEb7s689r
6909dd+VvW5Fm/mF9YIZwOaDMR64xrkbk89dWWVkr+UkbAG5owF5LDSkonHNjv3A
SOTVWVyCmArnbESbprBTDxlFYR+SMakJU/RKGcsfjehPSkuHF3QPYinJ+QnurYGR
Cw5LlRDuqOnuKjt7wcxkh70bYDC9deTDDNdZhC8+6RfFPqKqgjsYpKeakY4zHhxw
lwbPqCvH
=yr8y
-----END PGP SIGNATURE-----

--z8G/dajzuzHc+qpA--
