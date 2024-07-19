Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF96C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB33688204;
	Fri, 19 Jul 2024 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DwKF1zgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1710488B8B; Fri, 19 Jul 2024 17:25:48 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF33D87EDC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70445bb3811so1087440a34.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721402744; x=1722007544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vq6L43Sy1bU/MCqJMLvS6DcFtayxCV6ydhWNnJLK7nk=;
 b=DwKF1zgb3Bk9pG2J9oeX1Pe/cQP1gTCQj8HHaM2wKwNStQlXrudBm6PFb9MSncFBZ5
 MTnbDR8ikJnFkzce+fjIGcFwDxfNXCLeg55n6BMtSGDXNHBLG0Hf/73yXl81P68wPh+V
 dC77t+e4KyIJjFEiYaSnqDlsBvHtMBCA2Fp9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721402744; x=1722007544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vq6L43Sy1bU/MCqJMLvS6DcFtayxCV6ydhWNnJLK7nk=;
 b=X3m7dZ5bDB9wr34X+Mr1pnGrDYhjzYZCiojT++QI3izle9who8oTqMwA6aA5S5LUSh
 RRmN6voKN8SB07KWyJzjBhsalAEAdPxYF0fFfdpZJTIKNSBQunxvAua9QiU3aKQ2+QAB
 Cwi5iV6K32rZuCxrR+rsRww8+fYGbZBpo5nKRHag2bdxlMFzTEWJ3QXoVasB5IB4zyOU
 bOncQh4OWaDwhvbnMZUOjbpQWiiAsxB1KB+VL2lmnGUs7QlhpsDs2hS24Ab8zDUcshzo
 6J5JAkPnIJVO++Afnyrhc8zo+cgXw2cImSF49z1hoRiiPz9Pnbqp4UFsJjid9lduXY9T
 gECA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAhXxY8iq12+pwTZHk6CWZj6ht91ikuoihqWD0Nbnf7poo1WI9g7Gs+gHJqayl7r0ojF7MSXWq6rQP/GWt1qD+qNAv9g==
X-Gm-Message-State: AOJu0YzHkUldGLE5gjAKd3GN+I5djRH3D7zc5dZLFzSdmfAXVPVuiBd8
 ys/s+XIOIa58mHpndRRlbm9KljCl8tJE6HHo8wV53klH7ZZcANSY5RFJAvtWbFA=
X-Google-Smtp-Source: AGHT+IG6uete06GRLNqYnXUyhzCpVG5ItT37Tqqrq86ZdoP8dvve7DIbvhZMKEnL/Zd3KtIgdUPZJQ==
X-Received: by 2002:a05:6830:2b07:b0:703:6543:ecf3 with SMTP id
 46e09a7af769-708e37b57b3mr9580833a34.9.1721402744505; 
 Fri, 19 Jul 2024 08:25:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aaed6e3sm258974eaf.41.2024.07.19.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 08:25:44 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:25:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
Message-ID: <20240719152540.GB561963@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
 <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EMsNJRW+mv3uhNnJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
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


--EMsNJRW+mv3uhNnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 04:05:09PM +0100, Simon Glass wrote:
> Hi Raymond,
>=20
> On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi,
> >>
> >> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg> wrote:
> >> >
> >> > Hi Raymond
> >> >
> >> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wr=
ote:
> >> > >
> >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> >> > >
> >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > > ---
> >> > > Changes in v2
> >> > > - Use the original head files instead of creating new ones.
> >> > > Changes in v3
> >> > > - Add handle checkers for malloc.
> >> > > Changes in v4
> >> > > - None.
> >> > >
> >> > >  common/hash.c | 143 +++++++++++++++++++++++++++++++++++++++++++++=
+++++
> >> > >  1 file changed, 143 insertions(+)
> >> > >
> >> > > diff --git a/common/hash.c b/common/hash.c
> >> > > index ac63803fed9..96caf074374 100644
> >> > > --- a/common/hash.c
> >> > > +++ b/common/hash.c
> >> > > @@ -35,6 +35,141 @@
> >> > >  #include <u-boot/sha512.h>
> >> > >  #include <u-boot/md5.h>
> >> > >
> >> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> >> > > +
> >> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> >> > > +{
> >> > > +       int ret;
> >> > > +       mbedtls_sha1_context *ctx =3D malloc(sizeof(mbedtls_sha1_c=
ontext));
> >>
> >>
> >> Why do we need allocation here? We should avoid it where possible.
> >>
> > The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is passin=
g a pointer
> > address and expecting to get the context from the pointer, it is reason=
able to do the
> > allocation.
> > On top of that, this patch doesn't make changes on this API itself, but=
 just adapted
> > it to MbedTLS stacks, thus you can see the allocation is needed by the =
original API
> > as well.
>=20
> Oh dear., I see Now I am looking at the code. It is full of #ifdefs
> for different cases.
>=20
> The whole thing needs a bit of a rationalisation before adding another ca=
se.

If you're referring too the hash_algo struct, I'm not sure we can do
something different that doesn't in turn increase size globally. And
long term some of this may be able to go away if we can remove
non-mbedTLS options.

--=20
Tom

--EMsNJRW+mv3uhNnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaahXEACgkQFHw5/5Y0
tyyCAAv7Bjoz39V0V9nLeb4xmo8J4MrDkgt+Oao54xvCW1+5GjYgwnknRAxO0EKE
oJBljdmWl9PEEBs1HAR2kj4rSOW5wqQMuJRPENglrTmrZltdYNqFnwvVc9QB6OQj
RVxfGAN9OiDLR0kc/pFZ4vAF13T6ng+DGOx+jeOHTEywMcdoL0sCgjp6fyPh2xVi
pKnSVlP/DPjiXD6BYEeH+g/ftAOU4xhboirk3Aif9MQeHgTv+tsrZHATe3iZk43L
pMFpaIYPsLqZjM3ZuJCRrkRva7Dea5MXpqdPahic+UEuQK7YcbkvSIayrrFIZbxr
K59TqeXCF5R3CnPy2mV9xtPTQ3hMW3MPOMU5lXfdWPYSX/Yjt6sJbRP6NL6A5UU5
ZirP5ZfzomdOjDRqrgU8o/5ANFfjfyRHQsq5RWhk+c2Afge9jmnK7vEJcAjlifNh
wk+svvYQPpOCZoTwSXb2y/zgPIXUWRRqB9/7cu9V7vXZkyI4W+bESdsJJWImwsGM
QcSIS7AG
=XNCu
-----END PGP SIGNATURE-----

--EMsNJRW+mv3uhNnJ--
