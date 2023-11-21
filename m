Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF1C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A23C875F5;
	Tue, 21 Nov 2023 19:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RnEo4rA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4425287605; Tue, 21 Nov 2023 19:19:47 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8900A875F5
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77d58a21a0dso58113785a.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700590783; x=1701195583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dFR914ufj+plIDdIGJxaTk8tHIvXm84/ffGr4cfdm28=;
 b=RnEo4rA1r9vlX93Vc/dIYIm1O15a2S8M0agE+0VtrB8g2KRbehYMFPEMAUs6tcmDsQ
 3cf0uE/4YkY6DGzHBCB9vnpU/WsaoWtjWrBVXz3+4GLDQuAZQdWy2PYwG2J0jz8nvDQ9
 ChM0ybUVDdy8Snc0ayCFBtCjO3SpunzcToX7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700590783; x=1701195583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFR914ufj+plIDdIGJxaTk8tHIvXm84/ffGr4cfdm28=;
 b=czklz0C/91XAuuE+lmnCUr2QQQ1SMdLIf3dN1lymnTz+16TfK1TbjPnC2RFABhHHzE
 Gk8UVkWih7f+XXj/KOzdl9JRrgIoljrrQKHYPTuUIz1ZpeJJWaHIweLEyOsGCCrCakcY
 bZe//cRTb0Ju2Kz2mH0Kj/eo6Za3Zth0/DdHpxRDjp7GJgQ7mBsZpkYEif3Q3amcuCX5
 B+QRQv385gex6DxE8rPGigFgQP6wxUxAp8ERbjYWOmy4hQ6afuUYvBpNl/RMfUlNHvvZ
 75d7nMMirIqZC++SmEMViwFYBY/Syt4hx3wPJt0KatrfxqIOL9EchLbFcGYWU0egB3Dr
 JfkA==
X-Gm-Message-State: AOJu0YzKiM78lBuD8O2yYDLNd6NODjUsjNMcXqKarj84H/CJr05bhHfW
 SB4Cj8wfgk5tweLDKXfKAq2vuQBSQtW0+XEd0xmG9g==
X-Google-Smtp-Source: AGHT+IGNhQ1RCHKjJP5oRNKhcn8pLnwnf7UV7EGv8o1+ypD8oHt7KMjZL9lugZfcdBQuZRq6BtBHZQ==
X-Received: by 2002:a05:620a:11ab:b0:77a:29a:2758 with SMTP id
 c11-20020a05620a11ab00b0077a029a2758mr12997939qkk.73.1700590783336; 
 Tue, 21 Nov 2023 10:19:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 s26-20020a05620a16ba00b0077a029b7bf1sm3805032qkj.28.2023.11.21.10.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:19:42 -0800 (PST)
Date: Tue, 21 Nov 2023 13:19:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Message-ID: <20231121181940.GZ2513409@bill-the-cat>
References: <20231121020932.733405-1-sjg@chromium.org>
 <20231121020932.733405-2-sjg@chromium.org>
 <20231121130630.GM2513409@bill-the-cat>
 <CAPnjgZ02NZp6fcx+o=HJ0maGxSJQTkSzAoEtSCdgP4oqHdy3KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s3IxnwLop564Gui7"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ02NZp6fcx+o=HJ0maGxSJQTkSzAoEtSCdgP4oqHdy3KA@mail.gmail.com>
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


--s3IxnwLop564Gui7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 09:20:39AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 21 Nov 2023 at 06:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 20, 2023 at 07:09:25PM -0700, Simon Glass wrote:
> >
> > > The cyclic subsystem is currently enabled either in all build phases
> > > or none. For tools this should not be enabled, but since lib/shc256.c
> > > and other files include watchdog.h in the host build, we must make
> > > sure that it is not enabled there.
> > >
> > > Add an SPL symbol so that there is more control of this.
> > >
> > > Add an include into cyclic.h so that tools can include this file.
> > >
> > > Also add the kconfig.h header so that CONFIG_IS_ENABLED() works. We
> > > could avoid this for now by moving the location of the watchdog.h
> > > inclusion to outside the USE_HOSTCC area. But at some point the #ifde=
fs
> > > from these files will likely be removed, so there is no benefit in
> > > going that way.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > --- a/include/cyclic.h
> > > +++ b/include/cyclic.h
> > > @@ -11,6 +11,7 @@
> > >  #ifndef __cyclic_h
> > >  #define __cyclic_h
> > >
> > > +#include <linux/kconfig.h>
> > >  #include <linux/list.h>
> > >  #include <asm/types.h>
> >
> > As I said, we just need to fix lib/sha*.c so NAK. The only thing that
> > stopped me from posting that patch last night was that I went and
> > removed <common.h> from everything in lib/ as a follow-up and that's
> > taken a few more iterations.
> >
>=20
> Yes I had the same thought the first time and mentioned it
> specifically in this version.
>=20
> If you are a doing a clean-up, perhaps you could drop the #idefs in
> the sha files?

Nope, they specifically need <cyclic.h> outside of tools builds for
schedule().

--=20
Tom

--s3IxnwLop564Gui7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc9LwACgkQFHw5/5Y0
tyzqcAwAk67Mu4VcfT+dEjOaTZ4zOpEugyjvlhYoIBZpNOoZHIMkAMNSFWvV7W/T
fW8+/ojp4Xd1Lr0WgAaZ10jleED/xb616ZtWc9Ywq5814KIqgfP1uJlYkRL18xD6
ZksikXg3NlqGquqyepUsi0aqtmDkTHTA1pDDcjJ5lZK7y2wkhcQtWbdNBWAj91uk
LGM0bL9eY07xkNfmUeeOz9Z/CR/Tdd0NXAa5+eP3nTD/HOPNWjYj8u2wd67VNWtf
S/D0mfdkqLhwOrm8NDRgZjKL1y9izQJeNlkeOJA+Brpq4DgJaEASflLp8kUj27Hj
et/88q2xIwMH91pC3ZMMG4+Z2qgeq8qXA8XVoHdFQRmJjBwO2wimWUYTGBv+wk/f
hUreswWPuAfe9hegmQifIb8V/e0TDaDNfMJT9Si/e1A1kJ2HzbBrfAezm+eVMa5m
Y5O0Ob9R3THQxFhBFAcGjDyNtEIu1h3o+PFBBG5VrQFt5RxI+hRFO5VLD6kaKfRR
x/v+Ebdm
=UcoU
-----END PGP SIGNATURE-----

--s3IxnwLop564Gui7--
