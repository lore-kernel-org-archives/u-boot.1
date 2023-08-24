Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEC3C88CB2
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA26583F7B;
	Thu, 24 Aug 2023 18:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bT9OP389";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6494086532; Thu, 24 Aug 2023 18:29:25 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BC48082A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso39145276.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692894561; x=1693499361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+7bwIpEY8rPEYKHx1X3kchXt6DMIZJ2BggWCswMzUL4=;
 b=bT9OP389TLZkLQ0MUpr6fuXx+So+UyENjLLAFpx61/kHn/QRjeNEBpS6U9RnERezu6
 d+cw3dF3miWl+OMRFQXRAhSLEgpOqaB0z/LHeRG2dI7sNzgxoiaYG/3up7vwAVU2K8Za
 L0yhskMIh+nMoB9QYtQSYHV+E1qPirAhQiCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692894561; x=1693499361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7bwIpEY8rPEYKHx1X3kchXt6DMIZJ2BggWCswMzUL4=;
 b=f+q7kyp8MvUJJHvbOG86SALibSHKCjaWvgDLLosCQAQ5gD9CYZJyOp0nff05P5oTvA
 5aFqTff2I979aHFs3uiOx0vYbFrl7vpE2KLuQoVCKfZqjKqroWDSSomJ8716Mqr61fQe
 N+0h37ImW/yrJNgWAEKgDm0rk+neiQCK3N7hJ0Sys0RaF7gy4rUOxYP+i9dsr6xmsphR
 2at5+Fc9ys/BmnnHT9XTYqRA603tTqamNsiMYpDWAw7FOZF9g4nfkUWXh4ZnXusB1hDD
 uJgezrjc/BOz1B4KDvBHAHUQl8hai6VNFaQqJ5s4L5oc56FY0ihLCEg0CNrVW8sDzm0Z
 5wMA==
X-Gm-Message-State: AOJu0YxREpijoYBCw5iWUyRYgE9l7yRXSikjkz87/WeS5J4I/2YndD5X
 3ujn7YK/od4LQ0SswFCIn/1BUQ==
X-Google-Smtp-Source: AGHT+IG1vIyVtJ0XP87MTcZohSBOrFM6KfS9DT8WJ14iedw5DG7aaRRBVaA3xG1nvr3AeTLmfBOlQQ==
X-Received: by 2002:a25:d704:0:b0:d4b:f4e4:62f4 with SMTP id
 o4-20020a25d704000000b00d4bf4e462f4mr14431672ybg.10.1692894561291; 
 Thu, 24 Aug 2023 09:29:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 y127-20020a253285000000b00d74c43dad49sm2023286yby.48.2023.08.24.09.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:29:20 -0700 (PDT)
Date: Thu, 24 Aug 2023 12:29:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 08/17] include: env: ti: ti_common: Add a generic
 findfdt
Message-ID: <20230824162918.GB3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-9-nm@ti.com>
 <20230824151439.GY3953269@bill-the-cat>
 <20230824162247.oeqooi3454skobnc@connected>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="37cD+Z6xaD0wY1k0"
Content-Disposition: inline
In-Reply-To: <20230824162247.oeqooi3454skobnc@connected>
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


--37cD+Z6xaD0wY1k0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 11:22:47AM -0500, Nishanth Menon wrote:
> On 11:14-20230824, Tom Rini wrote:
> > On Wed, Aug 23, 2023 at 10:10:52PM -0500, Nishanth Menon wrote:
> > > ti_mmc bootmethod uses a findfdt routine that is expected to be
> > > implemented by all platforms.
> > >=20
> > > Define a default findfdt based on configured DEFAULT_DEVICE_TREE opti=
on
> > > for u-boot. This saves duplication across multiple boards and handles
> > > architecture folder location changes centrally.
> > >=20
> > > TI ARMV7 platforms will need to override default_device_tree_subarch
> > > in the env file to point to the appropriate platform. Note: default
> > > "omap" is used to cater to "most common" default.
> > >=20
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > > New patch (part of bootstd transition)
> > >=20
> > >  include/env/ti/ti_common.env | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.=
env
> > > index e87a41a6590b..322f849a5560 100644
> > > --- a/include/env/ti/ti_common.env
> > > +++ b/include/env/ti/ti_common.env
> > > @@ -32,3 +32,15 @@ bootcmd_ti_mmc=3D
> > >  	else;
> > >  		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}=
; run run_kern;
> > >  	fi;
> > > +default_device_tree=3DCONFIG_DEFAULT_DEVICE_TREE
> > > +default_device_tree_arch=3Dti
> > > +#ifdef CONFIG_ARM64
> > > +findfdt=3D
> > > +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.=
dtb;
> > > +	setenv fdtfile ${name_fdt}
> > > +#else
> > > +default_device_tree_subarch=3Domap
> > > +findfdt=3D
> > > +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_s=
ubarch}/${default_device_tree}.dtb;
> > > +	setenv fdtfile ${name_fdt}
> > > +#endif
> >=20
> > How does this override work in practice?  I fear that it's relying on
> > the (not exactly documented) mechanic of "last one set generally work".
>=20
> I was depending on that -> since we work with #includes anyways - I had
> assumed it implicitly.

It "works" in that the generated environment will be something like:
foo=3Da
foo=3Db

But when we import the at run time we set "foo" to "a" and then override
"foo" to be "b".  Which works, but isn't super clear at the outset, so
it's best to not do that.

> > So perhaps we don't want this in ti_common.env but instead
> > include/env/ti/default_findfdt.env and then #include that, and then
> > platforms that need different just don't #include this.
>=20
> Sure, I can do that in the next spin. Will wait a couple of days for any
> further feedback to fixup (without broadening scope unless mandatory).

OK, thanks.

--=20
Tom

--37cD+Z6xaD0wY1k0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnhVsACgkQFHw5/5Y0
tyxUaQv/aCt6MFdBuVH4wzNNV0/dpXF7JReJSjjF4QcChsNZvJHmFh2zCwrLv0ts
118ZMFgwVQFI8WPCvlChxzLHJP9ODxTCkGApORNlHp91uNDIUGQZcRV+NsxaYXv7
LCl8hBU/xhxbgyARF+D7MWNb9S4vS/2U3RmdjfbHvhzkKnSihZd9jJdIdw2UG0ka
QLrmYWMKgGDZdKmIewSseeQINaw6d5X/9xJQQF1ORYFNdjuf9RBaJeUmezDl8pHv
YbgjdrbJPFhGPBDYsWcL+C5X3kFeq7EHU6AW5Xov5BpaYU/amb25wz2q0VuIje0u
B8XwA/eMgKqm/WPSMnRP8dsfW/gamPxrFxpC/ytapW7DlC4O2AqoFlj1Hzq8nqGP
vlIV7Bg+scx0xbvfNYlH30Gk5gcNrn0jW6u8GjdIdAJKsntxZ46hOydU/wFCOutc
SXGbFnLHIVVrwQ3IQHRizBSacKSrbAq2mQRiPmwDKqDwhocFagQQlRF4mSG2ZY+h
moQhQRX5
=h7VF
-----END PGP SIGNATURE-----

--37cD+Z6xaD0wY1k0--
