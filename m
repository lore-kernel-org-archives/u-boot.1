Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E1AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 17:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62960801B0;
	Thu, 12 Dec 2024 18:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cXR67WNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21F4801BF; Thu, 12 Dec 2024 18:27:51 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACBF8012C
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 18:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so83632785a.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734024468; x=1734629268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJQupbDLuFU8y9wRncui4Pup8x4d9WaSxyWYtoAHIx0=;
 b=cXR67WNZI9fN+vmVh/lldBGxGt1GkN53jyC14JjvKm76LOLYY4Hu/Vt5KHFMQPqg44
 pEVghtO+5uDhuuAn2csOcHpuKdx3NaAdcf/x/mOqJQ1gngp4FLx+FyZAJ+kuZqxEF/aq
 OJ1bkh7Iy+NBd3rctQDsjwygYNMRDs512NqSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024468; x=1734629268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJQupbDLuFU8y9wRncui4Pup8x4d9WaSxyWYtoAHIx0=;
 b=kqHhuSbaArAHpKy4kwdntXCflHDP3S+e6OhQDiMWuTHDWSzxT/IL3CoTn874m2Sknh
 NRzbj1zqZ6rA7+LRmjd2qSHRLcimNfH5qzoDByqoX0PmuO226S+i9908bXzr9b0iv4ot
 zq9vqEh/WneNqAnre43DqKdkIiE3boOxNzcrNsL9sX3oZdlgUXXt24Qmwuy+5dW/eQ4j
 zQ/Z7LqYeT3DLhh2QSKf+6mbQCvdmSAvGUM7fP67Z2m27vavipX0AjTvIsJ+b8o1t2F5
 v4wHGK2sCkvugwKTx8hOJ65k8UkUd0ge+sNkBl5XrzS6YoB3WqTJEGibxHhGCSntEE7m
 KI2w==
X-Gm-Message-State: AOJu0YxCyha5oFepitJpaInJrWzzxohSYzudAfJRIvbF+uKmuLR7Y/ni
 L/qhZnB5GopN+4fdXuUrhYLRh0sQ524Q7vMK9XItvrhrhFyMPyWAFaQ98KHtwT0=
X-Gm-Gg: ASbGncumOPGDq90WM6izwfl6YKWHvIeyBb/h4XaHCD10GQxibwhjmzPvxY2KdRye82R
 YDkbJ1lkvTg415lTFstAiY2mMhKJwMgIVi617eJ6gIHUL3WvDRXn1H2iwk0VWfY9Q8RLVyVoH27
 UvmgZGZJ3AZpTO7eNLI+gnjiq7h3WBCoQOujk9U4DFOkNJl8GuYBic8rXrUUTaWMzWCuKEZswAi
 d9nzPzbYpEAjrnNiERtXNPHGt1Og1dGrWc4F2qGUwaRqOmL54WLPdct
X-Google-Smtp-Source: AGHT+IEJVN6u2Nstu84peDvKgINA4p6Hy26+Tf/mEaHm5PL5YjpBuD9YtXIKUzfkgtBfGjnmWB7HjQ==
X-Received: by 2002:a05:620a:27d2:b0:7b6:da21:752e with SMTP id
 af79cd13be357-7b6f88d3c64mr193111885a.8.1734024468164; 
 Thu, 12 Dec 2024 09:27:48 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a5c746sm758072385a.49.2024.12.12.09.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:27:47 -0800 (PST)
Date: Thu, 12 Dec 2024 11:27:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241212172745.GH1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera> <20241212170210.GG1505244@bill-the-cat>
 <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MReTV9UTNriKd4RR"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
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


--MReTV9UTNriKd4RR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 07:08:34PM +0200, Ilias Apalodimas wrote:
> On Thu, 12 Dec 2024 at 19:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wrote:
> > > Hi Tom,
> > >
> > > On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > > > Introduce an option to control if we expect that a prior stage has
> > > > created a bloblist already and thus it is safe to scan the address.=
 We
> > > > need to have this be configurable because we do not (and cannot) kn=
ow if
> > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some spec=
ial
> > > > on-chip memory and so it may or may not be safe to read from this
> > > > address this early.
> > >
> > > Yes this patch makes instead of making the OF_SEPARATE implicitly take
> > > priority
> > >
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > >  lib/fdtdec.c   | 11 +++--------
> > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > index e8d89bf6eb9d..e8febad0f212 100644
> > > > --- a/common/Kconfig
> > > > +++ b/common/Kconfig
> > > > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> > > >       is set up in the first part of U-Boot to run (TPL, SPL or U-B=
oot
> > > >       proper), and this sane bloblist is used for subsequent phases.
> > > >
> > > > +config BLOBLIST_PRIOR_STAGE
> > > > +   bool "Bloblist was created in a stage prior to U-Boot"
> > > > +   default y
> > > > +   depends on BLOBLIST_FIXED
> > > > +   help
> > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was creat=
ed
> > > > +     before U-Boot is started.
> > > > +
> > > >  config BLOBLIST_SIZE_RELOC
> > > >     hex "Size of bloblist after relocation"
> > > >     default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > > > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> > > >
> > > >  endchoice
> > > >
> > > > +config SPL_BLOBLIST_PRIOR_STAGE
> > > > +   bool "Bloblist was created in a stage prior to SPL"
> > > > +   default y
> > > > +   depends on SPL_BLOBLIST_FIXED
> > > > +   help
> > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was creat=
ed before
> > > > +     U-Boot SPL is started.
> > > > +
> > > >  endif # SPL_BLOBLIST
> > > >
> > > >  if TPL_BLOBLIST
> > > > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> > > >
> > > >  endchoice
> > > >
> > > > +config TPL_BLOBLIST_PRIOR_STAGE
> > > > +   bool "Bloblist was created in a stage prior to TPL"
> > > > +   default y
> > > > +   depends on TPL_BLOBLIST_FIXED
> > > > +   help
> > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was creat=
ed before
> > > > +     U-Boot TPL is started.
> > > > +
> > > >  endif # TPL_BLOBLIST
> > > >
> > > >  if VPL_BLOBLIST
> > > > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> > > >
> > > >  endchoice
> > > >
> > > > +config VPL_BLOBLIST_PRIOR_STAGE
> > > > +   bool "Bloblist was created in a stage prior to VPL"
> > > > +   default y
> > > > +   depends on VPL_BLOBLIST_FIXED
> > > > +   help
> > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was creat=
ed before
> > > > +     U-Boot VPL is started.
> > > > +
> > > >  endif # VPL_BLOBLIST
> > > >
> > > >  endmenu
> > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > index b06559880296..29bddab4150c 100644
> > > > --- a/lib/fdtdec.c
> > > > +++ b/lib/fdtdec.c
> > > > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> > > >     int ret =3D -ENOENT;
> > > >
> > > >     /*
> > > > -    * If allowing a bloblist, check that first. There was discussi=
on about
> > > > -    * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > > -    *
> > > > -    * The necessary test is whether the previous phase passed a bl=
oblist,
> > > > -    * not whether this phase creates one.
> > > > +    * Only scan for a bloblist and then if that bloblist contains =
a device
> > > > +    * tree if we have been configured to expect one.
> > > >      */
> > > > -   if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > -       (xpl_prev_phase() !=3D PHASE_TPL ||
> > > > -        !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > +   if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
> > >
> > > Without wider context I am not sure but if that check can fold in
> > > bloblist_maybe_init() and return -X if the config isn't enabled, it's=
 going
> > > to be easier to read
> >
> > Hmm. We'd have:
> >         if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> >             !(ret =3D bloblist_maybe_init()) {
> >                 /* We have a bloblist, see if it has FDT */
>=20
> I mean move the check inside bloblist_maybe_init()

As we talked about on IRC, no, because the "maybe" in that function
means "find or create". So the expected usage here is that we have
platforms that create the bloblist in SPL (post DRAM init) and use that
with the HANDOFF mechanism to pass information to full U-Boot.

--=20
Tom

--MReTV9UTNriKd4RR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbHQkACgkQFHw5/5Y0
tyyJwQwAteEphyLxtzKlHhgmZUtRnFLHGwSWG6aznibQPVUuQO25c6OsXHxBquUc
u7/90+KezcNpWPb9I0VAxc/OCI8iGFxHv3IeKlxdTZd6O9Bhzx1JRo1TzYOT2kG7
toZkCWcJVbXAeZBZtehdQJAT3mYaBAQgELoIV+2hMfdpvQRrtjfsoCNaITwBfzEo
4u6VK6juzvrdFKxIwdsLM5DC24O3OYvUfxdBuoQWzShN7+N+IheMZyG3FWvlAK5O
GIt5TQsl24AE4NrqwBVZZsSSPbEEpToMgfJ7fh3HddDorFS5Pz3SD+YZfQOmqeGB
5Fs327qwwTzSpNcaJVQS1D7obdO26v+iXS+qMRW4HGVKQMdp0ubxul+z/GMMtcKr
b2wpKxqLhh19gXX/+1y0S3FgI9YG7dM+MTevcD0WC/fXopFPQRKL/ORUuIXBUH8Z
JpEM3Qj8PXzV8QmO1IqwBOVx3vCjLTVOSNG3BhdGKUISOtKByKbtATRK0OF0qx6s
HCFlCAV6
=haoK
-----END PGP SIGNATURE-----

--MReTV9UTNriKd4RR--
