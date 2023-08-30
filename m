Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F852C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 14:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677C9863B5;
	Wed, 30 Aug 2023 16:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOSyxxe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D69863D4; Wed, 30 Aug 2023 16:22:51 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D709480771
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58d31f142eeso64789297b3.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693405366; x=1694010166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fK+fcImdcRIObM6RZu8H8cW5yC5Odg9SgI4CEw/68+o=;
 b=QOSyxxe8uD6ExIl38KkUCI3wgAUgORBW03CJRxWOzgXFF1fjIrmS7sD+g8pwTSMo4W
 x5c86L+M0svEKU8q/hDjcbIC21My1rr6g1lOrzHD0uAtCrWX2TCXPIrJXCi0+0wxgeOz
 sJ+ysJ0BePqJTAs612WFviZPlOMYp7hRwBjpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405366; x=1694010166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fK+fcImdcRIObM6RZu8H8cW5yC5Odg9SgI4CEw/68+o=;
 b=k+RIr9fdd+fHekhk7zrEF/tCwEf1LEIxrajB7HKJcFnrlbsrF8Kxp8qy0afnNfvDhD
 FGNGOqk4ny4t6KyxusWfhKQQ0MR8bJ6F37YyOGaUVI08tAirVR+qT3Q9KlnCE7+qUUrq
 QnMjPyG2gQMu6i5Gc9i3m7PmT8+Mk4U001XDlpGgPSZzCpx8OXxzCYxRJ1smiELd57WO
 aj0LYweQJZs8BIKxA/jYF9dcbo8Jx339jb8wp02xsWTpKNnHGPP1AVcdA/gSYUX7nXGl
 AE/68YQhd8OxaxN19zn8pcCFhHvMo55VPEngXpKFy3+bj8vKQS2CIlmY5ERGmeQVKtdo
 zHZw==
X-Gm-Message-State: AOJu0Yz3mkl5YonyUUA+69E7v9w3WRyw29oN0zB83e4FLQrajB6YuGRx
 ZcPJHNZp0uVug28GaM0RBQ68/Q==
X-Google-Smtp-Source: AGHT+IEae2alKC9mikhc2/7y7oBkXyFuCtKRICsg0uUXjzKHI6B0E+7kmckgTpDwQoS6a2u1FH3lRQ==
X-Received: by 2002:a0d:d341:0:b0:58c:4ec6:f21e with SMTP id
 v62-20020a0dd341000000b0058c4ec6f21emr2129467ywd.23.1693405366410; 
 Wed, 30 Aug 2023 07:22:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 l201-20020a0de2d2000000b0056974f4019esm3332793ywe.6.2023.08.30.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:22:45 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:22:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
Message-ID: <20230830142243.GA3101304@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
 <20230828183936.GN3953269@bill-the-cat>
 <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a8pMwywn+4fFhTKn"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
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


--a8pMwywn+4fFhTKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 10:24:39AM +0300, Ilias Apalodimas wrote:
> Hi Tom
>=20
> On Mon, 28 Aug 2023 at 21:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:
> > > hi Simon,
> > >
> > > On Mon, 28 Aug 2023 at 23:25, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > > > >
> > > > > Add a document explaining the need for removal of non-compliant
> > > > > devicetree nodes and properties. Also describe in brief, the macr=
os
> > > > > that can be used for this removal.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++=
++++++
> > > > >  1 file changed, 64 insertions(+)
> > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge=
=2Erst
> > > > >
> > > > > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/=
doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > new file mode 100644
> > > > > index 0000000000..c3a8feab5b
> > > > > --- /dev/null
> > > > > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > @@ -0,0 +1,64 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0+
> > > > > +
> > > > > +Removal of non-compliant nodes and properties
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +The devicetree used in U-Boot might contain nodes and properties=
 which
> > > > > +are specific only to U-Boot, and are not necessarily being used =
to
> > > > > +describe hardware but to pass information to U-Boot. An example =
of
> > > > > +such a property would be the public key being passed to U-Boot f=
or
> > > > > +verification.
> > > >
> > > > It has nothing to do with describing hardware. The DT can describe
> > > > other things too. See the /options node, for example.
> > > >
> > > > Please don't bring this highly misleading language into U-Boot.
> > >
> > > Please point out what is misleading in the above paragraph. What is
> > > being emphasised in the above paragraph is that certain nodes and
> > > properties in the devicetree are relevant only in u-boot, and not the
> > > kernel. And this is precisely what the devicetree maintainers are
> > > saying [1].
> > >
> > > >
> > > > > +
> > > > > +This devicetree can then be passed to the OS. Since certain node=
s and
> > > > > +properties are not really describing hardware, and more importan=
tly,
> > > > > +these are only relevant to U-Boot, bindings for these cannot be
> > > > > +upstreamed into the devicetree repository. There have been insta=
nces
> > > > > +of attempts being made to upstream such bindings, and these deem=
ed not
> > > > > +fit for upstreaming.
> > > >
> > > > Then either they should not be in U-Boot, or there is a problem with
> > > > the process.
> > > >
> > > > > Not having a binding for these nodes and
> > > > > +properties means that the devicetree fails the schema compliance=
 tests
> > > > > +[1]. This also means that the platform cannot get certifications=
 like
> > > > > +SystemReady [2] which, among other things require a devicetree w=
hich
> > > > > +passes the schema compliance tests.
> > > > > +
> > > > > +For such nodes and properties, it has been suggested by the devi=
cetree
> > > > > +maintainers that the right thing to do is to remove them from the
> > > > > +devicetree before it gets passed on to the OS [3].
> > > >
> > > > Hard NAK. If we go this way, then no one will ever have an incentive
> > > > to do the right thing.
> > > >
> > > > Please send bindings for Linaro's work, instead. If something is
> > > > entirely U-Boot-specific, then it can go in /options/u-boot but it
> > > > still must be in the dt-schema.
> > >
> > > Please re-read the document including the last link [1]. If you go
> > > through that entire thread, you will notice that this is precisely
> > > what Linaro was trying to do here -- upstream the binding for the
> > > fwu-mdata node. It is only based on the feedback of the devicetree
> > > maintainers that this patchset was required.
> > >
> > > -sughosh
> > >
> > > [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE=
7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
> >
> > Please note that this right here, that the explanation of why we need to
> > delete this node, not being a bright shiny visible object is one of the
> > big problems with this patchset and implementation. It cannot be
> > footnotes in email threads as to why such-and-such node/property isn't
> > upstream, it needs to be documented and visible in the code base /
> > documentation and an obvious you must do this for future cases.
>=20
> I thought we agreed that deleting nodes that won't be accepted
> upstream is the right approach since that would break the systemready
> 2.0 compatibility.
>=20
> Yes, it can't be footnotes or hidden links, but this is totally
> different than what I am reading on this thread.

An issue is that the functionality got posted without clear links as to
why the initial nodes to be deleted had been rejected, in the patchset
itself (and so not preserved long term). Being able to show that yes,
really, it was attempted to upstream the nodes, and not "delete first
upstream later (never)" is critical.

--=20
Tom

--a8pMwywn+4fFhTKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvULAACgkQFHw5/5Y0
tyxQwQv/d32om7/XIlUCNQld64dtB5hdu9kImW/dtUlqbrdssvvLEb7ChTOEn9US
PYgBNecHDa0xVX28aJ/hEkzTA+AVLVBvpLSerLd3GXNMH+RdqUn8C4EzHwqBEPta
jdez0n91m+yyluxQGkPVbPae/c+XtLtXDhviIopiTjEguD6NDOkLfnU0qRROh4C3
dGuT/1qlb+50tF1V4Zro3NylIkh/RCQoCIkHnXE3mTqVr1Hqso9yjKeJokY/VJlq
PqW/yWhwHIhhKJ0VgGkW+k45gUWfYZUaNYyx+aL24J7yChvh0fY5FkrqPl0brKTl
U6LbITMVlAwqMvtT5m3s13yLQ8EtHk6hyiHuEfIiocm6IS8hQ7YV5k3cjOWd+/fX
eh7yjxO0xghkp2tbER5uboeQJX/HL18M77q2QCZ5z/dlvbyuW8arARQTO/c3QJtp
pSvSJ5i5EvcXOKMmKArNrJ1F1ATQxQHgnKaDVCjOPsjUhJ/OeGxRCFGVEAWikwA2
woPUjUH6
=xw8L
-----END PGP SIGNATURE-----

--a8pMwywn+4fFhTKn--
