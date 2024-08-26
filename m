Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E1C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9C68857C;
	Mon, 26 Aug 2024 17:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gWCBD2E3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74511882EF; Mon, 26 Aug 2024 17:01:54 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C8EC86DBD
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a1d42da3f7so281091585a.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724684511; x=1725289311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwn9R3nEpqeJewBOqlIcEaN5Mosj94pDghVPFn5aNkk=;
 b=gWCBD2E3ZMlOR+t8nVzvbA+JkYEcFWiYwRdmUUuUPKcpeTaT4A6rkTHhYxhNhFm3XG
 vYWH2OvUrLeToyMRuEwSAh23D5Ci4KzARqsdG9P0DBQUSPCgDtvQpuAggifolUZO1Z5C
 BaV+4okpo8IjC+MWE7irXPi7d9PRnMLtNqKus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724684511; x=1725289311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwn9R3nEpqeJewBOqlIcEaN5Mosj94pDghVPFn5aNkk=;
 b=Oq38KW/N29sUK0e+xrVRo3NFHhhzL2JH9MwjodHvk1UcIPTkM/epdObNN8JxGcAr40
 Z2TUMZfQkEWLn2fp4EM4N6uubcHVR0LhanUJZxueCwz+W9l212yMuncPXJkubFN81y+v
 XOA3E5+yHQEO8py01sLyer/A+sQ8TD5bwmwih78sr+fDF4qRN3Zy5J80TKRwmikzPZ3s
 takX6YO3e4MymbydyBYX+Ws3kzcHMii4d43JozcmMTB4GmWqELk8w0dUJQ5GjDD3CxxX
 m5IXSm+l7qZMz1QlMT1nOxh8MhgXVtUb+XM17JscEUD63U+3Y0DH4xa7fccO28JlJ7Yk
 AVIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEW0Nn9rXsSW8T9Nrq/wnoevoVbhPOWwkSgo2kI0jR8H41D80eLygX4R4U4RBGbD2HmaH6x4=@lists.denx.de
X-Gm-Message-State: AOJu0YwN3wJsx2hJH1d1BZBKfGDxENDzFLiUIJLLovAcPJya8o3GLp1n
 Im+wfkfA5aTODvUbtguRKJ3Xc2dndmRTlTLPPETyPzYbIzA69jrHJcI99oGJ+lM=
X-Google-Smtp-Source: AGHT+IF5YSIdYVf3zEAQE+rRFrUVS7LcEbdJpcS8jm0Nt0b8L1dMYir26Myiaiq1FpFpVk4cshoHUg==
X-Received: by 2002:a05:620a:1a0e:b0:7a1:da5e:c501 with SMTP id
 af79cd13be357-7a6897c676fmr1208230985a.60.1724684510476; 
 Mon, 26 Aug 2024 08:01:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3bb381sm462705785a.85.2024.08.26.08.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:01:49 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:01:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: E Shattow <lucent@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
Message-ID: <20240826150146.GG2479150@bill-the-cat>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
 <7a25850c-6082-4490-867b-126b480ba757@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lYD9jK+B7g0vt+bI"
Content-Disposition: inline
In-Reply-To: <7a25850c-6082-4490-867b-126b480ba757@linaro.org>
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


--lYD9jK+B7g0vt+bI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 02:26:10PM +0100, Caleb Connolly wrote:
>=20
>=20
> On 25/08/2024 19:36, E Shattow wrote:
> > On Sun, Aug 25, 2024 at 5:26=E2=80=AFAM Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >=20
> > > All three addresses printed are in hexadecimal format, but only the
> > > first two have the "0x" prefix. The patch aligns the format of the
> > > "end" address with the other two by adding the "0x" prefix.
> > >=20
> > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > ---
> > >=20
> > >   boot/bootm.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/boot/bootm.c b/boot/bootm.c
> > > index 480f8e6a0e6e..951e549f19ff 100644
> > > --- a/boot/bootm.c
> > > +++ b/boot/bootm.c
> > > @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *im=
ages, int boot_progress)
> > >=20
> > >                  /* Handle BOOTM_STATE_LOADOS */
> > >                  if (relocated_addr !=3D load) {
> > > -                       printf("Moving Image from 0x%lx to 0x%lx, end=
=3D%lx\n",
> > > +                       printf("Moving Image from 0x%lx to 0x%lx, end=
=3D0x%lx\n",
> > >                                 load, relocated_addr,
> > >                                 relocated_addr + image_size);
> > >                          memmove((void *)relocated_addr, load_buf, im=
age_size);
> > > --
> > > 2.43.0
> > >=20
> >=20
> >  From U-Boot documentation, alpha-numeric input is assumed to be
> > hexadecimal except when it is not, and generally does not accept "0x"
> > prefix on input. So the correct action would be to make this

While there was some point in history where I'm sure we got confused by
"0x" input I don't think that's true anymore (and everything should be
using some strto function that works as expected, not a custom parser).
So the docs should be updated there.

> > consistent over the whole U-Boot code base, or remove the "0x"
> > prefixes (not add more of them) ?
>=20
> Most(?) U-Boot commands accept the 0x prefix. I don't think stripping it =
is
> sensible, I myself have gotten confused many times over hex values that l=
ack
> the leading 0x in U-Boot output.
>=20
> Maybe unavailable in SPL (not sure) but I prefer the "%#lx" format which
> prepends the 0x automatically.

That we assume input is hex is just what it is these days. Output really
ought to be prefixed with 0x because that's just common convention (and
whatever we assumed people would Just Know 25+ years ago may not be true
today). Since updating this output really shouldn't change our ABI, it's
conceptually fine with me but we don't use "%#lx" a lot and so I don't
know if tiny-printf handles it and so that might not be the right call
for SPL code and so lets not change this patch.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--lYD9jK+B7g0vt+bI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMmNcACgkQFHw5/5Y0
tyzkEAv/S4K8+YbUa2c27z7Zw5QsUuDne0/+ACePn04Rzc/VgTsDMorlZu2x3J+z
OrihTW6S87jaO8PGiOk7YnnZKr/kPZkpDmo7JjJv4cV6TEF1hPXGAQQKpKs/Wi8t
0B+4eAfwj0UilQXliwhglxpzXl0JgBPbAB512SC+RsFHtrN/Ux3MF59s+ekqsvXO
NAhmvoslav8LQ2TT8RKtZ+/nBHmJrGLKg1vCeZHHaiwgjcYqMF0R8LHRlc/x7TjI
hHTZ1gmAjDENT/hJ8exDWc9AYCEIQIF8NAEBFeCyfQRnqRs4vysaKce4Tr89f9Rp
gIq/eVF3TFZRIZSbxR9YXUHz3W2Ya78zraDRbQgsiH9s05EYVxz84mywfUv1emrm
BtxM6lW54+Rqy0Uu8SYclroBoIieoxJd34tXDgS9oLtvX8eeou5njIc4yz0XyIBy
uJNJlfcQAiwVD6TXCtVpNGJDJ7QLje0ZFvfN7sVZMjq0CFsMvp9DgK0oI/q4IUvC
Kpu8I7Tp
=7YSe
-----END PGP SIGNATURE-----

--lYD9jK+B7g0vt+bI--
