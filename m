Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94060CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6B882A9E;
	Tue,  4 Nov 2025 17:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkNQ2clB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4045C835B3; Tue,  4 Nov 2025 17:21:28 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31CD808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65043e595a8so2779052eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762273284; x=1762878084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XPGQR6/GshY0bEVmFkGgKky3vbGIjMpaa8LpSAM7ILI=;
 b=kkNQ2clBEFt0xAavXRWd8Qe+AsyYNanKky4jDX2QdByTuGmKo4vTWzwbqxrfhjwr0V
 H925cColK4svcT2YlJv+WVnmOMhfs7M5xPyjDuD4dRdwPAb/osIaLDs6M3X/+FBDUzi4
 zEp6KAbmYYWne3VOVpIJ55ZVM9YxUhAyHZiik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273284; x=1762878084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPGQR6/GshY0bEVmFkGgKky3vbGIjMpaa8LpSAM7ILI=;
 b=aLCJTKOyd6R8fXNTCJHBY3s8eenHqGuub+XjuhwTa0y4F4ySjzrrX5w9MbNAs6EOcZ
 nO++ZWLIhIALeO8YQGnFfGylHz1a42Ae3B3nKr2HI6pj0hvya5VTtcY6faZNTxpb8E6i
 0yArLyWPbB/WZC5VfoyY7oY3F3024OrrfeJwGPpBTtP1cFvF/EKzZPBDI77Y3GJNylT7
 wkLDkOLa+c1C5eHES2HF3oz0r2cvjp7WQhmGhb+MCZqslf2hJeWhvSXO5YTwbkWbI4x9
 DuzzOzch5XNR1C3mw7o8yCOnCuvxfEcQR7GEPpgDflmx9k4xD+qy7t1vD70S6qfpERlC
 IUig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4QD+h5OO7HDv+ybDihCEzG5KfzFLEWN0j/8wDDod1bhd2kseS3ZrkitJcF8uTXYVlJS4+LKE=@lists.denx.de
X-Gm-Message-State: AOJu0YwWL5KHk0RjHzNiDgX88C9tLwhJHCLr4qQCOJCuAo9OLUH8fZJz
 vhQAuyP/htQskBKe8RwZ1f0YGpEHLPvBD4FItroe+fAXLv2yAjli420tHmPqD3fN9t8=
X-Gm-Gg: ASbGncuVdR49EbtF2oxSqHxeFEbg+0o0Gi6crGXSh+ptayxde9y4Sn/SCvaOmJaLUsF
 a45D7Hef/qUU/ILF/lgCXtRUPRkqG2DaINRt7cwipAwhgKNK6BsoLM1G08KJcd2Lhnwpty3hZS5
 17OQZiFbGoP0wARmEu8rAF3jUv+2V4vod0JeI36Ug9nFjy8+Yf5XTLc/af6sui1lYVWhxwwz9/I
 4WMR29k7Y1gHqfKSv1pYXI0MTYoNQg/6/s9YHe4uRohugPjUi3wuPywbRTR3m6uSHgzvzW9T1eX
 cx8OBO63gqF3GoON2j0Y6Nfa7jHGfmA4aHRwAWSZaWKsGS99Dvg2DBVqkFcGfgvEgAHziFrl0uy
 +4DoueRFiJmErDhZeezTIJ2BaQy0WGXq6552Hi4grL/wrK0fWKsP0EpxPbfHeFSW7zNgVwj3C3H
 9UO5Yqd+dHFKhBsLGyOmALNnWh+UDtPIlYEa848FsAHKQSl4Q7xQ==
X-Google-Smtp-Source: AGHT+IEG5m+6Cwrolq1Pd1WnLVIBaQRVx1r4VJ3+mMmkPowteA/ZtrluGaBCnV+tsI58PvG1oNnuig==
X-Received: by 2002:a05:6820:1613:b0:656:b62a:e554 with SMTP id
 006d021491bc7-656b62aef73mr605933eaf.2.1762273284486; 
 Tue, 04 Nov 2025 08:21:24 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656b6f61a93sm216083eaf.9.2025.11.04.08.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:21:23 -0800 (PST)
Date: Tue, 4 Nov 2025 10:21:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min <dillon.minfei@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [Uboot-stm32] [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
Message-ID: <20251104162121.GA6688@bill-the-cat>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
 <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
 <aQavXq6jVagkIa53@thinkstation>
 <CAFLszThdV7cZ-uBXzqRYWv-HsGbNJV9BVKVOC4FQUD1yjZDNkg@mail.gmail.com>
 <20251103141726.GJ6688@bill-the-cat>
 <bcd23bda-23f5-4e65-b09f-93ec4eb60414@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NMiOv1mOKgz4MCMu"
Content-Disposition: inline
In-Reply-To: <bcd23bda-23f5-4e65-b09f-93ec4eb60414@foss.st.com>
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


--NMiOv1mOKgz4MCMu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 03:01:31PM +0100, Raphael Gallais-Pou wrote:
>=20
>=20
> On 11/3/25 15:17, Tom Rini wrote:
> > On Sun, Nov 02, 2025 at 08:53:43PM +0100, Simon Glass wrote:
> >> Hi Raphael,
> >>
> >> On Sun, 2 Nov 2025 at 02:10, Rapha=EBl Gallais-Pou <rgallaispou@gmail.=
com>
> >> wrote:
> >>> Le Sat, Nov 01, 2025 at 10:03:59AM +0100, Simon Glass a =E9crit :
> >>>> Hi Raphael,
> >>>>
> >>>> On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
> >>>> <raphael.gallais-pou@foss.st.com> wrote:
> ...
> >>>> Please add a test for this in test/dm/ofnode.c
> >>> Hi Simon,
> >>>
> >>> I'll gladly do that, but I haven't write and use any test in U-Boot. =
 So
> >>> it is a bit foggy how to implement it.
> >> There is some info here:
> >>
> >> https://docs.u-boot.org/en/latest/develop/testing.html
> >>
> >>> Do we want to create a fake device-tree and test each configuration or
> >>> do we want to test in the _current_ device-tree if timings are correc=
tly
> >>> set according to the index value ?
> >> It looks like there is a 'display-timings' node in test.dts, with three
> >> subnodes, so you should just be able to get an ofnode for that and then
> >> read out one of them and check it.
> > OK, but what is the utility in doing that? We don't, and aren't, going
> > to have tests for every valid possible DT node, and this isn't
> > introducing new library parsing functionality (the most recent patch to
> > test/dm/ofnode.c was for ofnode_graph and that is important to test). We
> > don't have display-timing tests to start with, so we're fine not adding
> > something more here.
> >
>=20
> (Adding back Patrice, whom had been removed from CC.)
>=20
> Got it, so nothing to do on my side.

For this specific part of the series, yes, this seems fine.

--=20
Tom

--NMiOv1mOKgz4MCMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQooAQAKCRAr4qD1Cr/k
CmXDAP9uzpcOa+uoGXZCOygBJwFcy2WMNjfUnbVPd7puotZ9tgEAgYlK2ApJRB47
EL3dF2lm3gnwbuaFSnvSPzmbiV4kiAc=
=ODew
-----END PGP SIGNATURE-----

--NMiOv1mOKgz4MCMu--
