Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133CBC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEB880E9A;
	Wed, 18 Jun 2025 15:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H6LHOwiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446B582D06; Wed, 18 Jun 2025 15:59:53 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D558006D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-60657f417c4so3406568eaf.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750255190; x=1750859990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kpq6jZT3pHXpDFWdVsiW7N7rGtT60aOm3iri7SKQ06w=;
 b=H6LHOwiU6zgnE1Doi4/HRiyEFkiVuIBfewsuVYyd5sTQxxMBwc8RB7ybyiS5mhLaG8
 r2uoH+6G7RQ8l9S58uoUU92ZWRXR9FGtQvnEa8G088VHlzA5Boy9d0kqlamVFpFpJy4b
 +BR6G+FA2LHsfdEqmwuVnSJC65xKOoRbmlPQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255190; x=1750859990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kpq6jZT3pHXpDFWdVsiW7N7rGtT60aOm3iri7SKQ06w=;
 b=TpWQ2TqeaC0loV7KpOcyYKj//YC9FpcGnftIm0kvo4mlytsDzPbBL6MTHsOs3cohsd
 FMRIUwQI21Cya0rbppxddS1fyvo1pQi9a1lCUUwg/GGZP0HNZ0mr5WWjwCBBNl0+hjGY
 K8nP7SEN1n4++ndDsj1XbX9vDI5XV8IHXJHJckKqEs434v56yaAPK8qJveHBhKvjYOL0
 sI9Bwv8Cdlc1lulPSKdBqRqSM15XBJ7owM8QfkrgTc7OmW5dXmKACnoikcL2EIziGIWC
 xwhjkSTiur3YPXJo7T7ltBEDiDnggwF0GoVyQC/fWwSzCV9Qya0VN2DaRbx5ofOiWIY+
 a6LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVTm9bnzAgDPuf3lp93ow5DqoFVnA5svuj5dQa10mLNMo4aI4lC4SxWExjEsd/AzO5PdJGd/o=@lists.denx.de
X-Gm-Message-State: AOJu0YzxhA/y91SDEadiWcVlBXqV46EkD2cxiK9x5aPOtaePEyRagNEJ
 Ez/8dAuri1fifYAu4f64QQjMOQnqoqH2pnjlzHuJfSssPW+bQVHKRtojBTaIcVy7CTw=
X-Gm-Gg: ASbGnct28z8l+8Z5k5HJDrad80xdvUtxlAbZQY6ZdZgJXQ7AV3vqbyVGLlwRMRm8BVe
 uPoHGovc3tmOFhMPR7RHBtalIq7Y0Zvhn7e1c65P7XymYYpyY9agFGwc9NvDMlRNEEHS2yMgcDQ
 6bnfxcpmTY6gEiI4zKSaad3NGpj1QCCpXVcqBMqmzXvVEDsiRQokH75atMPWnLQWgF2aQ6hNf5f
 E+BzhreZNjHWZ/3XPGwN63iKOsnnLSNPE+je6/V7gy7f21fpck7kkzDfw/Gx65m94f9TAd9LEq3
 fDHeN5iNqUu8Hk44/P3rV4AAait+eGm1Zr6mmdlYRo12LLQ7pFZU4z5bmpx6hcjgT2T3GptlVHq
 7y2FCfdGa8HfWq9D2yix7sjRuDXT48jaRFA==
X-Google-Smtp-Source: AGHT+IGZg1lRp3g/LP2Cep2y+Vi6OsFzw1nuk/8g1lJWuswwY2QMRuZj22+DmQjYn4As/Y+6SwCa0Q==
X-Received: by 2002:a05:6820:a07:b0:611:4d84:33ea with SMTP id
 006d021491bc7-6114d843818mr189174eaf.1.1750255189224; 
 Wed, 18 Jun 2025 06:59:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108deb19fsm1347274eaf.17.2025.06.18.06.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 06:59:48 -0700 (PDT)
Date: Wed, 18 Jun 2025 07:59:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 02/13] lwip: move net/lwip/dns.c to cmd/lwip
Message-ID: <20250618135945.GB6521@bill-the-cat>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
 <20250617100720.2544758-3-jerome.forissier@linaro.org>
 <89fdbefa-6015-43d4-a74d-c31223839cee@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IMwEEDyQJg5qf8K3"
Content-Disposition: inline
In-Reply-To: <89fdbefa-6015-43d4-a74d-c31223839cee@gmx.de>
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


--IMwEEDyQJg5qf8K3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 09:51:32AM +0200, Heinrich Schuchardt wrote:
> On 6/17/25 12:03, Jerome Forissier wrote:
> > Prepare to split the dns command from cmd/net-lwip.c by moving the
> > implementation from net/lwip/dns.c to cmd/lwip.
> >=20
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >=20
> > Changes in v3:
> > - Move this patch before "lwip: split cmd/net-lwip.c into one file per
> >    command".
> >=20
> > Changes in v2:
> > - New patch
> >=20
> >   MAINTAINERS             | 1 +
> >   cmd/Makefile            | 2 +-
> >   cmd/lwip/Makefile       | 1 +
> >   {net =3D> cmd}/lwip/dns.c | 0
> >   net/lwip/Makefile       | 1 -
> >   5 files changed, 3 insertions(+), 2 deletions(-)
> >   create mode 100644 cmd/lwip/Makefile
> >   rename {net =3D> cmd}/lwip/dns.c (100%)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d62dd35a385..e8f644fc75b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1409,6 +1409,7 @@ F:	net/
> >   NETWORK (LWIP)
> >   M:	Jerome Forissier <jerome.forissier@linaro.org>
> >   S:	Maintained
> > +F:	cmd/lwip/
> >   F:	cmd/net-lwip.c
> >   F:	configs/qemu_arm64_lwip_defconfig
> >   F:	drivers/net/sandbox-lwip.c
> > diff --git a/cmd/Makefile b/cmd/Makefile
> > index 80cf70b7fe8..102422470c2 100644
> > --- a/cmd/Makefile
> > +++ b/cmd/Makefile
> > @@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) +=3D nand.o
> >   ifdef CONFIG_NET
> >   obj-$(CONFIG_CMD_NET) +=3D net.o net-common.o
> >   else ifdef CONFIG_NET_LWIP
> > -obj-$(CONFIG_CMD_NET) +=3D net-lwip.o net-common.o
> > +obj-$(CONFIG_CMD_NET) +=3D net-lwip.o net-common.o lwip/
>=20
> Why should any command implemented in /cmd/lwip/ depend on CONFIG_CMD_NET?
> Directory lwip/ should always be traversed if CONFIG_NET_LWIP=3Dy.
>=20
> We should get rid of CONFIG_CMD_NET once all commands are well separated.

I think a further cleanup would be to get rid of CONFIG_CMD_NET as it's
not an lwIP thing but something that implementation inherited.

--=20
Tom

--IMwEEDyQJg5qf8K3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhSxlEACgkQFHw5/5Y0
tyy09Av/V1foUTNagWjgSOplRC5Y+9h5Sy9KcBjPfBOvGbGAAA+pZ98iLlNTcs48
wN1a7FoEN38HKdKO+dWRERKiQZY9dqnJDRgAfM2Z+1sFqLvRteT6UXkLNRsfVs8H
yqTbgGn6gyaHAxgnBGev+6YgBi+j4Z3ZcIQ8buY2+4KwcTXsupTUQhm9h+pgrUPk
lfBO9GhwdboZd5WZzDOcBJ0sRu00Ymke/CGijQ8ANXILGwNiOGmKRt6lwa3iduuZ
ZdrBjAZ5TreCjNPk8YTXMZZeDqOp4yB6JD1UlmNEJ93MKRgVC/ENuMfXeMYnnwZO
zET2bpAngqs0rs8MOFdHEPSOppQBTmHszWh8y7k+tPzPbLDwgI+ltyAoRiTbP5wg
n0kTz1yllklAm+wkdbTyJpxRvVZUZj/tcuGw3ITpCVuQXzG9EjQISnJooVAPmGUT
h+xFpQLwebXbksQxDKqqSqeC6aZ9vDLtGHir3mcFLYsrcECBmHSwb1dF5RJLQwDA
weRcYEYW
=3iY0
-----END PGP SIGNATURE-----

--IMwEEDyQJg5qf8K3--
