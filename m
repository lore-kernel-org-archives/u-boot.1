Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE157CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBC8881BF;
	Wed, 10 Apr 2024 15:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cERUIvv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C796D881B9; Wed, 10 Apr 2024 15:22:42 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB46E81F9A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 15:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4dad331b828so1190205e0c.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712755359; x=1713360159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z6R07w24eAM4sICHXV7y+GE32Nxi8zTDWNULqv85sHo=;
 b=cERUIvv2/tkfdiplXMgzk9zG0MWRD0SI4EaG2Ip7iU7kqyu+AvPBIvbYKzGdC4kZtq
 yxTVuL5fRxKwjN03S0wMGHKvrjEia6ghsrpArVjijESEjLTenWKP2/aa26BksB1z3848
 wobcTb1o+Kllco8bO1EchbXSUfxwVPH4XFWoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712755359; x=1713360159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6R07w24eAM4sICHXV7y+GE32Nxi8zTDWNULqv85sHo=;
 b=MLWwfoKIRNQ/3QJwegFOJZoovJz6SdgbguIHdzlI+A0NvREIlmRHw37oeT1/ItXiho
 MvND19Hb0ifd3mzh2qNQVfc38CNgpmvU0UKL1LIxyVAqEL/D1V1gQCE3PEyQR2mNMWyZ
 umMqaB7L+k374eu7jlS+g1w96gckgo433ZYhYfgHhtO7BZXqjsO7bB0cwdS9vzv/xXvM
 i2KNYIzHEEzOVi0uAm6LZGtT/5BL4zq8Z2wMpA32o5VNC5Zu86Ilcf2luyFJC/szsOpB
 Z6nCIjtkA4bfqrrYI8ZFtOQFSOGfgGw9rKwjFgSMVhOdFfrHwlnecBEmMfnwt211u9m7
 6/aA==
X-Gm-Message-State: AOJu0Yzk1Yd/yGP335tunitwZjnXJyHyz9RySak2LQIqu0qW12bzzuUp
 e6bV74/nHWvMGY/Sht4A012ONWZZqpJtRhNs+Bwsv/ePx2a8Q5qhWm+xwLIJlzTB/xBOCIh6hoR
 azee7ng==
X-Google-Smtp-Source: AGHT+IEDUZnf752sihEHHY3BIZZiooE4yXSbHsrfac4U5tg/otZSmi4sLKWeFBfXLHh7NMaCbT7fXQ==
X-Received: by 2002:a05:6122:985:b0:4d3:3adc:b639 with SMTP id
 g5-20020a056122098500b004d33adcb639mr2881200vkd.6.1712755359431; 
 Wed, 10 Apr 2024 06:22:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a0ce38e000000b00692bd4905c9sm5058534qvl.15.2024.04.10.06.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 06:22:39 -0700 (PDT)
Date: Wed, 10 Apr 2024 07:22:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] api: add missing cookie checks for network access
Message-ID: <20240410132236.GF2493117@bill-the-cat>
References: <20240409131655.59157-1-heinrich.schuchardt@canonical.com>
 <20240410004350.GD2493117@bill-the-cat>
 <dc804b91-2ba5-4f13-9e96-474eadea569c@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n6Nh3uy358bkuRDs"
Content-Disposition: inline
In-Reply-To: <dc804b91-2ba5-4f13-9e96-474eadea569c@canonical.com>
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


--n6Nh3uy358bkuRDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 07:13:21AM +0200, Heinrich Schuchardt wrote:
> On 4/10/24 02:43, Tom Rini wrote:
> > On Tue, Apr 09, 2024 at 03:16:55PM +0200, Heinrich Schuchardt wrote:
> >=20
> > > dev_write_net() and dev_read_net() should validate the provided cooki=
e.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   api/api_net.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/api/api_net.c b/api/api_net.c
> > > index 7515c26e8b4..0b931a80787 100644
> > > --- a/api/api_net.c
> > > +++ b/api/api_net.c
> > > @@ -72,14 +72,16 @@ int dev_enum_net(struct device_info *di)
> > >   int dev_write_net(void *cookie, void *buf, int len)
> > >   {
> > > -	/* XXX verify that cookie points to a valid net device??? */
> > > +	if (!dev_valid_net(cookie))
> > > +		return API_ENODEV;
> > >   	return eth_send(buf, len);
> > >   }
> > >   int dev_read_net(void *cookie, void *buf, int len)
> > >   {
> > > -	/* XXX verify that cookie points to a valid net device??? */
> > > +	if (!dev_valid_net(cookie))
> > > +		return API_ENODEV;
> > >   	return eth_receive(buf, len);
> > >   }
> >=20
> > Is this right? Probably. But what triggered looking in to this to start
> > with? I don't think anything is enabling the API support these days
> > even.
> >=20
>=20
> We should either properly test the API in our CI or or remove it.
>=20
> What once was done via the API could be done via an EFI payload in a more
> portable way today.

Yes, we should indeed likely remove it.

--=20
Tom

--n6Nh3uy358bkuRDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYWkpkACgkQFHw5/5Y0
tyymkgv/Z4kpCsYpHAog/G3zAW0v7NxW5IjxetkEzvmXBRQnOvms0BUHmRTjFNg2
nyXCsoixRvDI6CwKV0nEC9nUGGTPp4rCOCPCDCWkxyrpWz1zJpDnKqpjY1icxyFk
lliNvVhXeyK9jZyNwRuGDc5XhdI0XMLfPi0AT/fLfYTuuhTFIt35Y8/LRWN5viYh
ZgVe2uV35fNd74/nfzhIGuteaI+THq/JLOROmkcLV5lKzFP8KFv5QGyZGap4oRzl
shRE5oRtQFPYT56hZUTmCfhe0UStkTIc0kq3BQxa5E7wVtOF5sQFGSi4Gj0lrUH1
DcEB0SWkTbI8yQpTdCt0rH0F9Al25GY6CTnYQFP40jgyVw/4auyT3bZJjk5Kmmt/
LUauAaVv7mENmx8Y2R6XWdJsHdMcggKpGNuNYo5iQ0ATyLUUE5NDqzTnqCYWyTaI
oiXn3X7cbtEdM+Inyd6qWXVh1/mObRvbIvqYJ+fG1xvC8ZvllEPqftG3stSxGy9r
9hiJORyJ
=yrAo
-----END PGP SIGNATURE-----

--n6Nh3uy358bkuRDs--
