Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E52CEBF70
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 02:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9101388FDA;
	Fri, 27 Sep 2024 04:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bbdsvfdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C5C88F28; Fri, 27 Sep 2024 04:52:07 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B7088F9B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 04:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dff1ccdc17bso1806771276.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 19:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727405524; x=1728010324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sNLRgvleWObyhVy50EBElu/ds4f1Sf7Q/RumtaZ6E5A=;
 b=BbdsvfdpzfV+ZuE4gdDDCChDmfj22lN8GcbpRxephZ7oEgehBmukgjV3R1qcN1nMja
 JPETqCd5j3bVqjwXLLOe/j4+zavmHR5gCpKkY4xrAYU/R3afTCdTerqeIoBFHZmGR4Bu
 aR5ZX8QDJ9blmO5Ma3XUgchlgMtFIvvB0cSEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727405524; x=1728010324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNLRgvleWObyhVy50EBElu/ds4f1Sf7Q/RumtaZ6E5A=;
 b=uANrxZ1+5PVaTcIv0qdoX5KdV6D4aZ01Kw8alA0ANJMjugf+wbcY4dMixDEc0kLTEN
 qJV3NAgzUnqvEAGnFS2Ucrkj3NK5c/BEa9KZwpJV+B8PlUYeOa0F7t9nldy3qUmFIT+8
 VbCfyAcVmDLP1NmBF834S26Y/ix+ngBtil1H24VTR/WVMPMvbbVSzwXjHPtUzAsfXM81
 zlPuGTt6biv4A8QMqcfALy4ZIcGlx+AN7t4ETVDjiUasNvzpMptKCFd/cs4sS2JDe6SK
 qpQhfdabS+9CQa1JKesTlomaaOdFL/r68s/kjA57XjmB5lDgGuKOOlZNhW3MbbIbmz5D
 hzsg==
X-Gm-Message-State: AOJu0YwtVbx8wkGNevVWUBPXcjNB7+tIdcG/e9RMHwg6xQvyn42wfN9B
 yVSKzKxla+jWpMjqSAGoHTBgbsJTovsWlQ9Y6Zfi618dzNOBjLczJlDeZbPMgdRyLPEqCnynpOR
 8bD0=
X-Google-Smtp-Source: AGHT+IGnr+ETT353qwYRPoA+0VevVz1rgqchyWTSBrdMTvdKY3DhXZczxrwhNXSRcCvNcV9MKxkLfQ==
X-Received: by 2002:a05:6902:1b92:b0:e25:de81:12ec with SMTP id
 3f1490d57ef6-e2604cf943fmr1409291276.51.1727405523829; 
 Thu, 26 Sep 2024 19:52:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f2bb69bsm4181711cf.30.2024.09.26.19.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 19:52:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:51:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20240927025159.GR4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
 <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n+cndVSg6uEcsGaP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
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


--n+cndVSg6uEcsGaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:36:00PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > > >
> > > >
> > > > > When Labgrid is used, it can get U-Boot ready for running tests. =
It
> > > > > prints a message when it has done so.
> > > > >
> > > > > Add logic to detect this message and accept it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > What happens is that labgrid can also be told to look for and then
> > > > interrupt autoboot, just like our pytests can do, and the system is=
 at
> > > > the prompt. But this is also what it's like for a system with autob=
oot
> > > > disabled. Do we actually need this patch to achieve the functionali=
ty
> > > > you want? Doesn't that already just happen?
> > >
> > > The point of this patch is actually to remove code in pytest, by
> > > allowing it to skip all the banner-detection stuff. It does not affect
> > > things in Labgrid, since it still needs to watch for banners, etc.
> >
> > But you can't remove code from pytest, people can and will run the suite
> > outside of labgrid.
>=20
> Yes, that's right. I meant that with Labgrid the code is not used.

OK. I still think this (and I assume the related flag to tell whichever
helper that was that the platform is ready to go) are too implementation
specific.

> > > Without this patch, we have to tell Labgrid's U-Boot driver to do
> > > nothing, so that pytest does it. But that is not a good idea, since
> > > Labgrid has a lot more info about the board than pytest has. For
> > > example, look at all the SPL-banner-count stuff.
> >
> > Why do you have to tell it to do nothing? The pytest suite works fine,
> > today, if the board stops at the prompt automatically. To be clear, the
> > labgrid yaml file I'm using with my scripts has the information to stop
> > autoboot in it and it's not causing a problem.
>=20
> But if it wasn't causing a problem I would not have invented this
> annoying scheme.

Well, I honestly thought it might be a remnant from development that
wasn't needed once everything else was done. I do that from time to time
myself.

> For several boards, by the time pytest gets to see
> the output it is too late to press a key and stop.

Why / how? Do we perhaps need to adjust the timeout upwards, slightly?
Especially in light of the changes you also did to detect a "dead" board
and so we don't wait 30 minutes for a test run to fail.

> Also, some boards
> have a different prompt which is not detected by pytest.
>=20
> For example:
> configs/am62x_beagleplay_a53_defconfig:CONFIG_AUTOBOOT_PROMPT=3D"Press
> SPACE to abort autoboot in %d seconds\n"

Yeah, I had forgotten that as I turn that off along with turning on
other tests via config fragment, on that platform. That really is a
deficiency in our pytest version of this.

> > > Basically, without this patch we cannot use '-s uboot' to tell the
> > > Labgrid strategy to take us to a U-Boot prompt. We must just use a raw
> > > console with no strategy, relying on pytest to do all the work.
> > >
> > > I hope that helps explain the problem?
> >
> > I think I see what you're saying, and it's based on the assumption that
> > we'll make everyone either use labgrid?
>=20
> Not at all. I tested this version of the series again with my
> pre-Labgrid lab and it works fine. But I do believe that the hooks
> that pytest has are not ideal for use with Labgrid.

OK. But, why can't you make use of the labgrid functionality to pause
the board? It's the state flag for labgrid-client yes? Dropping that in
with my labgrid support would be just a tweak to the console script to
check if the board set labgrid_strategy or something, and I think you
could adapt yours to that too?

--=20
Tom

--n+cndVSg6uEcsGaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb2HcgACgkQFHw5/5Y0
tyxMlQwAjEGRLZ8ajVJ+aRY2o2S6DuvTnkydaWEKepMVwhYCVDyf2GVTmVRdjV4j
8Jpq+9kQ/MeyH2v9B/FuhrMmbD1OLVtp1Zx8XoI2VfxtyZU72FG0ixk97QmqE7KP
8cMzKoUY2B+yGPQRadcYwnsV0dZFKBYPoc7HiaFLlvu3MvI41DPhfHzRYTNdy8FV
MfI/SfOHHExRXbRzEp0YCNWh6WJmUOMtLIGe6OnmoJ551ctytxRHCkVkxQZIM2Ch
IQ64EnkVsDhMLZjBI2dNFAX1R4VckW8PSYDCHzLBXwh7XeEcgl5pf3W/0U0fFg6F
BcxgyusT8co8tkHDJbMotq1relDRIwHrz7eeyHZhWcg1tTVoGc0LHSR3zYx+t+N+
uXqC39wWXxnw6lbk+oo9P7XunZ7OAqRozDhF/+0kg+xigbmcH2MI+4xpT02HY1nB
KH9cP4fba1ivwcTwU8OtwUenDnTJhk9ujhu2wlw2dUs/lGBPny3pBjTlULBkxrMt
azxFiXj0
=3ly9
-----END PGP SIGNATURE-----

--n+cndVSg6uEcsGaP--
