Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F5AC88E41
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 14:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D8184121;
	Tue, 27 Jan 2026 15:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BzrsiWWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59736840AC; Tue, 27 Jan 2026 15:53:42 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559D98405E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 15:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-4094fbd1808so123055fac.1
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 06:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769525618; x=1770130418; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EBg6WiiY07pOUPt5+mm3qsHFo9o2kM/5/TGsQhnIPz0=;
 b=BzrsiWWqKK/IP1PE3FOaSDtqVaro+qatCCzhMD86Jj8e6hSaihEi09na16RljrxmH0
 Rjocv07ogJgHqRCRI/+QFrO4eKZNJ7+6WrviTfXMWJ7uQuKX2I0djvH6Jlx3vRA1ZdiX
 KFahLZypsfI9X+sLsK1M5qq68yS0HQocOHig8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769525618; x=1770130418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBg6WiiY07pOUPt5+mm3qsHFo9o2kM/5/TGsQhnIPz0=;
 b=doUDL/+t/RSMAbyEyBZe4daOU1/bEONsPF/jB/N51uqXF7lpglVsdObzQrtcVsL4Mc
 5P2CnNPRWJY6NQNrgRUBpHM77MBekWiOvz4+0YBoC4uRDsd2L2Ej4aitzivQwhZX1gq0
 12J4PHbV+KYNkyu7R3Z9B8TNFVNVFjIsWjS+BF8vHaBjFQPkD+VVxQl44fzyd1s5sPjo
 rs8jZgiuuwyz8Zur8PWsuVLH5ziAywq1UP0idaLy/rATop8+avFGlS5GkvH2VK0RM4ad
 QF86ckkfZAzUK7QCWNgJnFfx6pTVZgnxwPrr4xW9OgF6UNjiaD+4nWwKKrU/+gI2ejlk
 EjpQ==
X-Gm-Message-State: AOJu0YzLm9iE8klYbqvc4ZPqADV4cuWtApgXptmvxtZV/xSyXtQ0sMEn
 TOEZAN3vimJ9R7O7s4hlyUOD1r/W8dn5E5UgkxcbXRhiG2jSWuuj9EWX0r0QBEsE35U=
X-Gm-Gg: AZuq6aIRuTc69nwyWzmUua5aeEkjv7rgghWmK+8aVG7wlDX5IoO0MKWEgrcgkgYWTnX
 E7RS6OCi/VTRvTAerDxcvgg5hCnyId15DQQVaaHRAvVGciOvSuJxiXAObniuMl0PjyEElHi/0xA
 o8CIDDyWjdWBqmlvM/D6BDvOgyTlJUDKcaWqPMnXsrw91KHYbjxqU1nirrFM4UpJ4JN498H3yEO
 WIA01vfjRZJXcIcBL7PrhPrlBupTdPOEgvMqV30j0SfeDb3LtbPPQNgL5Zko3BFdrV0XZfl1L2i
 ep7MyAAarSsfogHoZYnUSVYEfMV+/XgK1opIWkPBoYyFiP68EbYTTNOqjAjP39Kx3pu0TS9EvlB
 ZbMifryREPmuQuWd1st9MKyHTi1k3/URuvgK6/rfKL3WBv7ihyv22/KPi5l9X3d70e12fsMGMqg
 0Ru/I1bSgFiXhFICRQuIv2XIM5gLyRyX9r/6c13G7GAOpydVWy8cVJUkledUcDV2ynlyeFWzYiP
 LKzYlqWjuicAr5cNyeWbRMuljN4aoJwvgLfVCg=
X-Received: by 2002:a05:6870:fba8:b0:3f9:e924:3c9a with SMTP id
 586e51a60fabf-4093fd668e1mr1355848fac.26.1769525617912; 
 Tue, 27 Jan 2026 06:53:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408afba74casm9481426fac.14.2026.01.27.06.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:53:37 -0800 (PST)
Date: Tue, 27 Jan 2026 08:53:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
Message-ID: <20260127145335.GA3416603@bill-the-cat>
References: <20260126204548.GX3416603@bill-the-cat>
 <c2737282-7001-46f3-8ada-58e4007329fe@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NXL+gQZEjjd/FH/V"
Content-Disposition: inline
In-Reply-To: <c2737282-7001-46f3-8ada-58e4007329fe@cherry.de>
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


--NXL+gQZEjjd/FH/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 11:10:50AM +0100, Quentin Schulz wrote:
> Hi Tom, all,
>=20
> On 1/26/26 9:45 PM, Tom Rini wrote:
> > Hey all,
> >=20
> > So it's release day and I have tagged and pushed things out.
> >=20
> > First and foremost, this is a bit rougher than I would like but I hope
> > that doing the release will underscore the urgency of finishing some of
> > these fixes. We now require for our own use to be given a correctly (8
> > byte) aligned device tree. This is done in a lot of cases. However:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437=
-1-b-padhi@ti.com/#3640858
> > is needed to ensure that platforms that use a FIT image in the SPL phase
> > work.
> > https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2=
-jamie.gibbons@microchip.com/
> > needs to be addressed further to fix the case of platforms which apply
> > overlays in FIT images (SPL or OS). This series also shows that if your
> > platform does not boot then SPL_MALLOC_F_LEN may be too small.
> > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.c=
om/
> > contains some of the discussion around the case of SPL *not* enabling
> > SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
> > to the image.
> >=20
> > So, that's the important state of things right now. Some platforms are
> > broken. People helping to test the proposed fixes, or if needed, picking
> > up the changes and posting the next version of them, would be
> > appreciated.
> >=20
> > We're continuing with a community meeting following the release and the
> > calendar link is
> > https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMH=
YzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZ=
WMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsr=
c=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40grou=
p.calendar.google.com&scp=3DALL
> > and once again this is the same time as the previous meeting. The
> > meeting details itself are:
> > https://meet.google.com/btj-wgcg-euw
> > January 26th, 2025. 9am (GMT -06:00)
> >=20
> > To join by phone:
> > https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
> >=20
> > In terms of a rough changelog:
> > - We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
>=20
> We're on v6.18-dts already, so increment one in both versions above to ha=
ve
> the current state.

=2E.. Oh blah. I knew I got sidetracked and would forget something. I was
looking at the final linker / dtb problem (that Fabio reported) and so
forgot entirely to write a changelog.

--=20
Tom

--NXL+gQZEjjd/FH/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjRbwAKCRAr4qD1Cr/k
Cl/9AP9xUv+O5s3FpvRtDr0C4k3u7tNvuExc+q9dMEhjv1d3swD9FSL9BSGfq+eY
RFWtj6b60XjmAaZn2sgp/pCjAcWNgQA=
=cVB2
-----END PGP SIGNATURE-----

--NXL+gQZEjjd/FH/V--
