Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FECCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3831F838CE;
	Mon,  3 Nov 2025 15:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YLAisSHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90831838DD; Mon,  3 Nov 2025 15:17:33 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8D0838CE
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d1e68f7a6cso2712716fac.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762179450; x=1762784250; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ryw1QHhCShG7ZEnRjA9RaY4JjG3v/UyzrigR96WVRjY=;
 b=YLAisSHNcYnJbZqN/hinGFS3xtWgPR0kkgIyv9t1rY+dDijq8uZQs4Js+PM9ynvn/R
 MCT2JYwDjorGTH+jGeJSpf60joHVHSQvwNefYZ1n0SmYV0sdvLysgojRuLE4PxNl3NmC
 9oVpPjg5/ESuQoLxGRUSShQ2zaXL47YuyfKLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179450; x=1762784250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryw1QHhCShG7ZEnRjA9RaY4JjG3v/UyzrigR96WVRjY=;
 b=K7gtv5gaTcoM3kvi1utvQTifH4t3jzHqRLrk7dNPLJ3gijUoGEg2i/t+TqCohNVwW1
 ed2anc4LetVY9LOOPkH6h5sh7scTOhkEN4OUI6kR1+KfsGSIYr6keUKRf35mufjQb2HG
 Mp8L/tVe0/Bskc3TZMLPo4kKAMJ/zhxYCliz8rfgXVd/S/T9TndyT4a6zQM1X0V8fMf3
 oIFUQTyC1m51pAkzRbtWFl7onP38jPTTVsV7eXw+/jsu9j4PXFLhBVxOCSkn1PZ1mNtC
 VDhzcS/nKfVZrl8HuZP0Cs0lGUa8wWsl0Cl6OWKL5PTMQElGLVO5BcP7v7YSfiso2jO1
 xPug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr3yRENPsa55d9kzfTDmq0dF0wezR/ebdTxxPfnkCpZ3vgDIWeb55dyb+bj3SqbrF3s8jw4b8=@lists.denx.de
X-Gm-Message-State: AOJu0YxA2Uf8LzxIplSL8ySRPze+xezHlP+74BNYnnRnneoTTFyqzvfr
 BLso3DTGIkxFqphqcXEUU6wQCK4U1LGllJPWP5Z1rOUpJcRh3F44jWG8R8WooPOnOSc=
X-Gm-Gg: ASbGnctHbLC23BhCkKYOlaHHkw3OyjMovi17kor4BBmgOHbff2Biw+eHm2yOWDo1WPi
 Vxu8w9CpxAjzJPTm0C1JBdzljhZh5cmxOLIhHftj5c5KD6jIHxwLzYU6eTYmEMheKHfUQgUPsCh
 HA4pC0ApVcK4RpNMgPQ1+8+kGezhySq8rn47uT6bDSw63XB7dzqGNy3q052+fscHr3mb2S51nqp
 6EYXrsuLILEpCPIINGoeJ9Y4mrrwDcB32iN+H78YeuwH4ElOO7WxPCUcQCohpxZeta09h66BDbp
 D5xdyzhf4X6f8Vv8Ae/bECwfNRwgBKWuWoYAJ6HZSuT7EGi5DgTyL2y/F7J6AyTOqt6wx7sDcqG
 ypPZYs4Y3dvbgeHhdUkTEw534R8e86wr2nRLaCvGq5YwYc94sUBQaMW99+7ja09d3vrFQdM0PHr
 kXjR7/a9Xoirpf7TN2c1XDlm1vHXN2E5ah0tEFxj4=
X-Google-Smtp-Source: AGHT+IGPwkMNxSr+dWAFHLWHwiy7iymH1PZdb9e+LV13y3wzQjPuqo2XLFWtbt11DZD75ySIBBC7SQ==
X-Received: by 2002:a05:6870:d107:b0:365:a979:553 with SMTP id
 586e51a60fabf-3dacc5ce491mr5452836fac.36.1762179449564; 
 Mon, 03 Nov 2025 06:17:29 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff6f625b7sm87258fac.15.2025.11.03.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 06:17:28 -0800 (PST)
Date: Mon, 3 Nov 2025 08:17:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
Message-ID: <20251103141726.GJ6688@bill-the-cat>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
 <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qbjBMJgEwQtVadz2"
Content-Disposition: inline
In-Reply-To: <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
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


--qbjBMJgEwQtVadz2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 08:53:43PM +0100, Simon Glass wrote:
> Hi Raphael,
>=20
> On Sun, 2 Nov 2025 at 02:10, Rapha=EBl Gallais-Pou <rgallaispou@gmail.com>
> wrote:
> >
> > Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =E9crit :
> > > Hi Raphael,
> > >
> > > On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> > > <raphael.gallais-pou@foss.st.com> wrote:
> > > >
> > > > The "Display Timings" in panel-common.yaml can be provided by 2
> properties
> > > > - panel-timing: when display panels are restricted to a single
> resolution
> > > >                 the "panel-timing" node expresses the required
> timings.
> > > > - display-timings: several resolutions with different timings are
> supported
> > > >                    with several timing subnode of "display-timings"
> node
> > > >
> > > > This patch update the parsing function to handle this 2 possibility
> > > > when index =3D 0.
> > > >
> > > > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> > > > Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> > > > ---
> > > >  drivers/core/ofnode.c | 17 ++++++++++-------
> > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > index
> e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739776362=
c2d22a3c9
> 100644
> > > > --- a/drivers/core/ofnode.c
> > > > +++ b/drivers/core/ofnode.c
> > > > @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode
> parent, int index,
> > > >         int ret =3D 0;
> > > >
> > > >         timings =3D ofnode_find_subnode(parent, "display-timings");
> > > > -       if (!ofnode_valid(timings))
> > > > -               return -EINVAL;
> > > > -
> > > > -       i =3D 0;
> > > > -       ofnode_for_each_subnode(node, timings) {
> > > > -               if (i++ =3D=3D index)
> > > > -                       break;
> > > > +       if (ofnode_valid(timings)) {
> > > > +               i =3D 0;
> > > > +               ofnode_for_each_subnode(node, timings) {
> > > > +                       if (i++ =3D=3D index)
> > > > +                               break;
> > > > +               }
> > > > +       } else {
> > > > +               if (index !=3D 0)
> > > > +                       return -EINVAL;
> > > > +               node =3D ofnode_find_subnode(parent, "panel-timing"=
);
> > > >         }
> > > >
> > > >         if (!ofnode_valid(node))
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Please add a test for this in test/dm/ofnode.c
> >
> > Hi Simon,
> >
> > I'll gladly do that, but I haven't write and use any test in U-Boot.  So
> > it is a bit foggy how to implement it.
>=20
> There is some info here:
>=20
> https://docs.u-boot.org/en/latest/develop/testing.html
>=20
> >
> > Do we want to create a fake device-tree and test each configuration or
> > do we want to test in the _current_ device-tree if timings are correctly
> > set according to the index value ?
>=20
> It looks like there is a 'display-timings' node in test.dts, with three
> subnodes, so you should just be able to get an ofnode for that and then
> read out one of them and check it.

OK, but what is the utility in doing that? We don't, and aren't, going
to have tests for every valid possible DT node, and this isn't
introducing new library parsing functionality (the most recent patch to
test/dm/ofnode.c was for ofnode_graph and that is important to test). We
don't have display-timing tests to start with, so we're fine not adding
something more here.

--=20
Tom

--qbjBMJgEwQtVadz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQi5cwAKCRAr4qD1Cr/k
Cq0NAP45uCx3S5eNa2JBm2ta5ckDnStj6Szp37Ej6bCS6MtLpQD/YZ3dDqGbeJWp
HIrPZMN5QKqTN42LbFlWHLipf5yIogA=
=zg5P
-----END PGP SIGNATURE-----

--qbjBMJgEwQtVadz2--
