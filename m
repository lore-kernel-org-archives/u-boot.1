Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1478EC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 18:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4A186452;
	Mon, 28 Aug 2023 20:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tomcY3GN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9528647D; Mon, 28 Aug 2023 20:39:43 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B4D86430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 20:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fba83feb0so40770417b3.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693247979; x=1693852779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnxl64RujjDMi1qJYpufP4XvZfmavHWubQ+a4qTUpPU=;
 b=tomcY3GN0+j8BWdDqZIgKOdEwyWMbQ4dZJRZtnWZUX16c7uXmgWCB0Wrz5xlkslYu4
 s+C1Er+fu7Y0yTIJ8Xy8ATu/E5O/95s1OByYrVK6ZFVzj6p9qBM6jGDPSLKWEK5UwXgR
 bJwwIS5Y9+YJGgjDO4HU7apAPynChQU1Ey+YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693247979; x=1693852779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnxl64RujjDMi1qJYpufP4XvZfmavHWubQ+a4qTUpPU=;
 b=ElHp9UsjdMxqQaiZqrjWZh9OWINdQaHZoq/8zEy5CNHD9ze0ff9NiazrZ9akxCSoSm
 xIv/KqvYC79bmOKE9RcqqOXKPyFsn+ds6PCZsdSz+qpD8TYZcDaefsAehtyuJbIK4Dm0
 6DgvZ/sqUD4VkMyB53fPdImH+9SIIL6FQfS3AcDygzSL2qKPyVqSmXxY3rRXuKT+3Gof
 NvIa2siGG/QWgvzVZR28r31lcjXJBWWcWnBQTCBt+K5WVFHcE5v/5YnvDVU+Kg/FKNQ4
 rkRaZO4KQGBpVzmlRX4qyw1s8Zgzb70xqCwlg9OGWxfrDpp/ZgVVUY78prIWOprf5xj4
 4TqA==
X-Gm-Message-State: AOJu0YyfoRZ97cgNic2JlT0XOWS0ZFnSreJuEH/v1apSKJ4Mc9FeOs5C
 L79Lm1bIgOG9UweMdFs++Lalvw==
X-Google-Smtp-Source: AGHT+IHL/1JuJqcTVP5HxsIpGNhP7gX3WI7xA7Ul+eiMgYcVVhPlhYL5WHhnc0AYIL9ZIc1ABv290g==
X-Received: by 2002:a0d:d54a:0:b0:591:15a6:c11f with SMTP id
 x71-20020a0dd54a000000b0059115a6c11fmr21746902ywd.50.1693247978907; 
 Mon, 28 Aug 2023 11:39:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a0dd70f000000b005832ca42ba6sm2303677ywd.3.2023.08.28.11.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:39:38 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:39:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
Message-ID: <20230828183936.GN3953269@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J6zvWOmN9Hl7Tq8V"
Content-Disposition: inline
In-Reply-To: <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
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


--J6zvWOmN9Hl7Tq8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:
> hi Simon,
>=20
> On Mon, 28 Aug 2023 at 23:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > Add a document explaining the need for removal of non-compliant
> > > devicetree nodes and properties. Also describe in brief, the macros
> > > that can be used for this removal.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++=
++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > >
> > > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/=
develop/devicetree/dt_non_compliant_purge.rst
> > > new file mode 100644
> > > index 0000000000..c3a8feab5b
> > > --- /dev/null
> > > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > @@ -0,0 +1,64 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +Removal of non-compliant nodes and properties
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The devicetree used in U-Boot might contain nodes and properties whi=
ch
> > > +are specific only to U-Boot, and are not necessarily being used to
> > > +describe hardware but to pass information to U-Boot. An example of
> > > +such a property would be the public key being passed to U-Boot for
> > > +verification.
> >
> > It has nothing to do with describing hardware. The DT can describe
> > other things too. See the /options node, for example.
> >
> > Please don't bring this highly misleading language into U-Boot.
>=20
> Please point out what is misleading in the above paragraph. What is
> being emphasised in the above paragraph is that certain nodes and
> properties in the devicetree are relevant only in u-boot, and not the
> kernel. And this is precisely what the devicetree maintainers are
> saying [1].
>=20
> >
> > > +
> > > +This devicetree can then be passed to the OS. Since certain nodes and
> > > +properties are not really describing hardware, and more importantly,
> > > +these are only relevant to U-Boot, bindings for these cannot be
> > > +upstreamed into the devicetree repository. There have been instances
> > > +of attempts being made to upstream such bindings, and these deemed n=
ot
> > > +fit for upstreaming.
> >
> > Then either they should not be in U-Boot, or there is a problem with
> > the process.
> >
> > > Not having a binding for these nodes and
> > > +properties means that the devicetree fails the schema compliance tes=
ts
> > > +[1]. This also means that the platform cannot get certifications like
> > > +SystemReady [2] which, among other things require a devicetree which
> > > +passes the schema compliance tests.
> > > +
> > > +For such nodes and properties, it has been suggested by the devicetr=
ee
> > > +maintainers that the right thing to do is to remove them from the
> > > +devicetree before it gets passed on to the OS [3].
> >
> > Hard NAK. If we go this way, then no one will ever have an incentive
> > to do the right thing.
> >
> > Please send bindings for Linaro's work, instead. If something is
> > entirely U-Boot-specific, then it can go in /options/u-boot but it
> > still must be in the dt-schema.
>=20
> Please re-read the document including the last link [1]. If you go
> through that entire thread, you will notice that this is precisely
> what Linaro was trying to do here -- upstream the binding for the
> fwu-mdata node. It is only based on the feedback of the devicetree
> maintainers that this patchset was required.
>=20
> -sughosh
>=20
> [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf2=
6L_GV2oS6cg-5qg@mail.gmail.com/#t

Please note that this right here, that the explanation of why we need to
delete this node, not being a bright shiny visible object is one of the
big problems with this patchset and implementation. It cannot be
footnotes in email threads as to why such-and-such node/property isn't
upstream, it needs to be documented and visible in the code base /
documentation and an obvious you must do this for future cases.

--=20
Tom

--J6zvWOmN9Hl7Tq8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs6eUACgkQFHw5/5Y0
tyy4lAv/TEA0DnCpGqYs0BxGQYesbJSSb2AmJ5XlN5DvC89rbTsIBwfi/a3+CzK/
42MLZsSsw64Pe78TTIZAmNFsUy1+WZrmRrnDi0hPQslTGn81Kw+XNzeFTYTuZjA+
HPYUpS9OMaCWP0gRg81KFuL1we3vOwHFGemnAsUbwpMZo2MvWXx6MqfUWb++E9ZV
lUOHRUr40LSd7oL7NqxnnzvX/puLa1+c+TNbDuuiGTcrq/VW5t9n2a9QXTjlDu/y
u5aurjG02+dYk6k0h1GOtCwhc2ucXhmivoQjnF26aodD+fGHYmjSc/v4FJd0g8Js
SmkTbhdnkWh6fofeGifkMoe6xWna8tib+uGbJq1YEV2y0kEiRushDvqwaGUVp8oO
vmp9OImAwOKpkCgLhp1wLAxNyujBqq9cGsq4wmU1ocCNPEgJFgQ0tprAiSirmTYQ
HabEN981rGPtWjdytFSIhVr9834N2zpT8phEMb+oSoWjcYVd33aS2KrMlP9T8jMq
jZJsYGUy
=NgiD
-----END PGP SIGNATURE-----

--J6zvWOmN9Hl7Tq8V--
