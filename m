Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B318C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB7681E6C;
	Wed,  2 Apr 2025 21:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVyKibC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D41981F0B; Wed,  2 Apr 2025 21:50:39 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4918035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3feaedb4d2cso85969b6e.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743623436; x=1744228236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yYocmyU4lkQM2ctYjKoSeZs+GM8Bi7wx6agv+MWt+U4=;
 b=GVyKibC43L+7TrulCerD3nJf4xl4Gd+LKP6W9SI02Ic+XQVDzPj276/7g4WDi4GhIK
 3OOlZwLTWrpAhcVmGhOom9LTZBaSTfpOdUf5Dve3yCe314MCu1saj7VgrGuU21HG8zhf
 22N7R2hgVR0ppUM/+GaSnblqpQKJ14tiT/eV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743623436; x=1744228236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYocmyU4lkQM2ctYjKoSeZs+GM8Bi7wx6agv+MWt+U4=;
 b=ex6oxQNV+5KbMD6k4TefDhOoJLqmXa5l4qNBv2oANg11PliHhOrt6YOMia/AkXnNIU
 qPzFRrm3k97fdjVVN9oJ3H4KUtOoTYRfJDCDAzqulYmc6XIbYm+9dwaEH+b+leowRXSd
 tZpWzbh6VIBD8NjCwpKGxkvvOd3FQJSyBkwLqT5baTOeCKSnydrHvcx3w+A5/yDxUbiz
 F2nk1nZQSoFf4lOalkPri+/SLVZAag99C4pn7KYNBENaXcFIPwkCe7lb6nQr5/sItbB/
 9csgfeTY0g9Xnf3jPNF+Sl+mMjPr4pSjPj3zdtCOthkKuKWDBl/Bq6AXhTOMOdLZ8iTA
 tG5A==
X-Gm-Message-State: AOJu0YwZF4bsNwB0eRssvc5DWl5k26HsTMaLxQCBK3mv9yKBop73pcor
 S4ixCB/pBlIv0Tkc/cVq5Hk+rSzGgiMn5LcAxRl7Pt/HLCYrwmER+vi4uWQa3tQ=
X-Gm-Gg: ASbGncswc8Dxg5n0trKy2QNij80M9vrZk72fGUbHCj0yNv1sfi2wpXIiUo9tBUplndn
 yX+pN/lxGDYjb9sagNN3aObSlqg6MFM4tUmKTyi3K0Gg00Cg2x1cab6RX+pyfJqFWT4I6ZJYHKO
 sKfyuvQfsFD43BolltFYIixhTxfiU4yPVdbNTTi++eFaRbYsW78ZWiJA4PW+fJGGp9Run2ABIZo
 DqWeC9gy9tppoJzsESZ9Pw6Ti6UZedfqVMUeH/Plx6GUG00/1dfo18Iyni1V1eci6VpOzdYClP5
 6ifUbn9UDpMHiTvO6FRj74W78VQXVBoj0vos2W4w1DVyWPugdBMFOleVJhua7njVa4pxi6Y/8CQ
 rVPgHIA==
X-Google-Smtp-Source: AGHT+IE9q4SRa6x/aY2Iki+RbZr1EP4BDVAK26jVYzM4tKbCIYQTud9csOw8WyalVZY7Im4Tf8ysVQ==
X-Received: by 2002:a05:6808:3008:b0:3fc:1f7b:c3b3 with SMTP id
 5614622812f47-4003e9a3fe7mr73202b6e.33.1743623436017; 
 Wed, 02 Apr 2025 12:50:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff051aa4f4sm2467418b6e.24.2025.04.02.12.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 12:50:35 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:50:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
Message-ID: <20250402195033.GB5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
 <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fdfekKcNQB1hF9od"
Content-Disposition: inline
In-Reply-To: <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
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


--fdfekKcNQB1hF9od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 08:22:44AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > > Update the string to take account of UARTs which are connected on I/O
> > > ports, as on x86.
> > >
> > > Fix a typo in an error message in the same command, while we are here.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > > - Add new patch to support IO UARTs for earlycon and console
> > >
> > >  boot/bootflow.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > index 58a1afa7a75..4054a966af8 100644
> > > --- a/boot/bootflow.c
> > > +++ b/boot/bootflow.c
> > > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow,=
 const char *arg)
> > >       *buf =3D '\0';
> > >       if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CHIP_16=
550_COMPATIBLE) {
> > >               snprintf(buf, sizeof(buf),
> > > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > > -                      info.baudrate);
> > > +                      "uart8250,%s,%#lx,%dn8",
> > > +                      info.addr_space =3D=3D SERIAL_ADDRESS_SPACE_IO=
 ? "io" :
> > > +                      "mmio", info.addr, info.baudrate);
> > >       } else if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_=
CHIP_PL01X) {
> > >               snprintf(buf, sizeof(buf),
> > >                        "pl011,mmio32,%#lx,%dn8", info.addr,
> >
> > I suppose we're well past the point where we can delete
> > bootflow_cmdline_auto() itself because that's just going to lead us to
> > trouble down the line (5 years from now when the kernel adopts a new
> > preferred way to pass this info) and grows every platform by some amount
> > of space every time we add something new here.
>=20
> Well firstly, why would you want to delete this command? It is very
> useful to be able to change the cmdline.
>=20
> This command is only available with BOOTSTD_FULL, which is less than
> 10% of boards.

Because it's automatic non-obvious stuff. We should not be modifying the
command line at all. Is it even documented that we're doing this?

--=20
Tom

--fdfekKcNQB1hF9od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftlQkACgkQFHw5/5Y0
tyzj3Qv9HuebtzhOG8tACeAOIG4ZdPXEdb5avGApEjz+6ZGG/QNGjIaOu9KSdhZc
g/m3fEgQsGmA9Ws+2HzVPbYMqSOeFNJ61QpAxI02MJWwtb+xPAzCt3HuWDPsYQ4q
+BwBFJYXA3v3u1bw3AAxVg88YWypv2JaF2zE0xqCx41gyTj/i1W0jMHCm8YGLw7W
kJ6job7JOAxdohZ7DGTl0FHiTz30g8R3892p3kWlG9H5oqZOABTc0Bgyb3Ej4G3h
PE3ewKyNwUEvJERPgmmdlGbWJfOBbyl96sbrLosQMXDtmzqS1DsdLDIWb5ELBEc3
XkKGMXAwtY+Avjl5Utk2hLZ6AaZf6uFHBvdRl+puu0HYdI6Is/u7ojg8mc/whTFW
fiwJHH6E/3WoK0G61l4fcAMOKI+d6rHN9FAcS7h9nuWz8cejHWd53mCoKbdWuvC4
YNJCjdwFy1HiYnqRmHqAXvsWSNxgAmZVv9g7R4PK5B4I27GYfNh2GFIFdB16vXxc
fMuk78Q7
=uTx1
-----END PGP SIGNATURE-----

--fdfekKcNQB1hF9od--
