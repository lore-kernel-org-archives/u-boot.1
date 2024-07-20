Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26BCC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B48887FD;
	Sat, 20 Jul 2024 19:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mQ+YX3FA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF33887FE; Sat, 20 Jul 2024 19:13:27 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E33E6884BC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5ce739c2650so1545965eaf.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495603; x=1722100403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w8Ry5g77zHkZGZ3RbuSlLyg6RaSMab3/fv7cFAcrEcM=;
 b=mQ+YX3FAsf6/9Pb+GVwvf9RTKbAjRj3sZ7NSwMiZLk91Ox7d7andMBlOQmvSnTWjk4
 bqHQeMP06wGYPyqbrd2QCip6ZmzkaEY1Ea5MuIM6AOII03zB0zI9NBpG9cGQ4OI1K/HG
 wVdcjDtZX0nI2tnOkcHnpMUGaAWqlK+8vzOMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495603; x=1722100403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8Ry5g77zHkZGZ3RbuSlLyg6RaSMab3/fv7cFAcrEcM=;
 b=ROlnpEpSyg6Z7IUjz+Bfjv1VBUSiZ1qci3jAVAX4F57v1xpVAFz4tf/DMX2p6+vlD8
 oBCf4fYHkV7bDqRJrUzLMbhHyXZ9uAjhM5c7znXulBKofW6ue7p2bYh3nfp2Mc4Cdjha
 ZsLv4/YhGLoDZVimNLbLprHiqrFYjXkuoy5tLMwy1TO460uiJka2HrC+kCSaSRfgJFYc
 k94+YMIGuZfOxQMZcJOimwymOE6lZy0pizKOyhmB0mf1tCNPqXpEPL0jLml8HuOGE5uc
 iqnqcFd62Og5WFdIqkjeSUj8Fi3o0fGIYZUQ9JNvHHhwHND5QT8zfUGc0I4PYEIN3JRs
 lvfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa2WiCbjc3DZ6MvQD3yBpeTsp5Vl63wpYa24d5X9M8Af+yynrcykYaYT6KHwbfCmNnxNsySsJ+oUBqV2WJGjUTe5q2cg==
X-Gm-Message-State: AOJu0YyMrfW+9Pd7sFeWVVDdDzpOK4cPzHOd0Y5vM/ur2Dagz84aApSA
 sTnsUpYedgLe+eyYfmtvKuF8aRfCGBT6JIT2m1m/HOAGut2xiV9q356Ce1dMJbI=
X-Google-Smtp-Source: AGHT+IEryILDPFxDg9NP8stnsdkJzvU/UpMeaLsMtsqL1TMa7d1/SgrZFqcquhbHruJvRraDyBsBuQ==
X-Received: by 2002:a4a:ee83:0:b0:5c4:5cbc:b1b5 with SMTP id
 006d021491bc7-5d564cfc26dmr3581344eaf.0.1721495603664; 
 Sat, 20 Jul 2024 10:13:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d55aafb0e5sm653530eaf.48.2024.07.20.10.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:13:23 -0700 (PDT)
Date: Sat, 20 Jul 2024 11:13:14 -0600
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
Message-ID: <20240720171314.GF561963@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
 <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
 <20240719152540.GB561963@bill-the-cat>
 <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tfnj8oShqNDEgVto"
Content-Disposition: inline
In-Reply-To: <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
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


--tfnj8oShqNDEgVto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 01:36:02PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 19 Jul 2024 at 16:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jul 19, 2024 at 04:05:09PM +0100, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wr=
ote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@lina=
ro.org> wrote:
> > > >> >
> > > >> > Hi Raymond
> > > >> >
> > > >> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org=
> wrote:
> > > >> > >
> > > >> > > Integrate common/hash.c on the hash shim layer so that hash AP=
Is
> > > >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > >> > >
> > > >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > >> > > ---
> > > >> > > Changes in v2
> > > >> > > - Use the original head files instead of creating new ones.
> > > >> > > Changes in v3
> > > >> > > - Add handle checkers for malloc.
> > > >> > > Changes in v4
> > > >> > > - None.
> > > >> > >
> > > >> > >  common/hash.c | 143 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
> > > >> > >  1 file changed, 143 insertions(+)
> > > >> > >
> > > >> > > diff --git a/common/hash.c b/common/hash.c
> > > >> > > index ac63803fed9..96caf074374 100644
> > > >> > > --- a/common/hash.c
> > > >> > > +++ b/common/hash.c
> > > >> > > @@ -35,6 +35,141 @@
> > > >> > >  #include <u-boot/sha512.h>
> > > >> > >  #include <u-boot/md5.h>
> > > >> > >
> > > >> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > > >> > > +
> > > >> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > > >> > > +{
> > > >> > > +       int ret;
> > > >> > > +       mbedtls_sha1_context *ctx =3D malloc(sizeof(mbedtls_sh=
a1_context));
> > > >>
> > > >>
> > > >> Why do we need allocation here? We should avoid it where possible.
> > > >>
> > > > The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is pa=
ssing a pointer
> > > > address and expecting to get the context from the pointer, it is re=
asonable to do the
> > > > allocation.
> > > > On top of that, this patch doesn't make changes on this API itself,=
 but just adapted
> > > > it to MbedTLS stacks, thus you can see the allocation is needed by =
the original API
> > > > as well.
> > >
> > > Oh dear., I see Now I am looking at the code. It is full of #ifdefs
> > > for different cases.
> > >
> > > The whole thing needs a bit of a rationalisation before adding anothe=
r case.
> >
> > If you're referring too the hash_algo struct, I'm not sure we can do
> > something different that doesn't in turn increase size globally. And
> > long term some of this may be able to go away if we can remove
> > non-mbedTLS options.
>=20
> Well, at least using the existing functions rather than writing
> entirely new ones would help.
>=20
> The real culprit here is the hardware-acceleration stuff, but making
> the software side messy too is not nice. Hashing should move to a
> linker-list approach for the implementation, and probably driver model
> for the hardware acceleration.

I'm fine with looking at that, after mbedtls is merged and we're looking
at what can be removed / cleaned up. Perhaps we'll be able to shift
most/all of the hardware assisted algorithms to being handled within
mbedtls, I don't know.

--=20
Tom

--tfnj8oShqNDEgVto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmab8CoACgkQFHw5/5Y0
tyyN0wv+PIR5g0oVGgBQBB9EWF8zpBiNJTRzVjRZdSKUj/eVFZdXvSy4ORegaLfM
qsqeAJlu/wSIb4sTbm4UJr90yFCedpmB6Jh1jrnU35BcVo50oWfikCvdtm596WaP
c58t2FJyIiHEYno2bEiTsdZLpMgI0vYIrw5mihb9Sf0GhOUrcIkjh+BSEDBB8Jd5
ARUAqKCSo9YSHy2RJD1rJJH+vM3VONgxwgPyIdvdzh04OhG1OalzLG2dw2F2w89j
MMtAwaNVZnUEmB4nDrXKGwGZP9KMZ01daPiPB+QmwJAx5IHbEmKfw7UAWYiUQ0R+
bYfn13kyz8mlpezP4X7OEUIr28q62uTvmRZW1IrdbTN2Ochc1IAZVQ0yBAhkCF/Q
wFZHs/wWwcQJ7Z4TLQmjys/X/lAnzKfse0u/ntGybmXCRNZ+qYYQKcDyzkHO2GKe
E3BCysm8GGd3rR/fNuehTqeSxjs7oQ5wwhArijD871D6BxTW2V6KLiU+nMzrxGTN
o/R7dGcX
=DVoZ
-----END PGP SIGNATURE-----

--tfnj8oShqNDEgVto--
