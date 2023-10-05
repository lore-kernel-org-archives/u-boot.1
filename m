Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DCDE7AD44
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 16:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6607086C59;
	Thu,  5 Oct 2023 18:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gDODBp9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37F186C5E; Thu,  5 Oct 2023 18:36:51 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AD486BDB
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 18:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59f55c276c3so13737257b3.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696523808; x=1697128608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tKa3k0VZ4WwDSky8ROyTurZajKc5oECzzjha8AXTDu8=;
 b=gDODBp9G3Xq8m0EdythQFvTQxZX6nrzFSEaAaS2onpTA53Au7NB2TJ52bj8yn8H3Xg
 jbF+bfAD3EKSqaMnf1TICgBDtXOM+AyAcA8na7w5yx211R00SMLJOkbsRtjwVUDKsMjj
 YThtEbMtphoN1bOlphQTbybHr2bcjUmm4g6qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523808; x=1697128608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKa3k0VZ4WwDSky8ROyTurZajKc5oECzzjha8AXTDu8=;
 b=BoJD/Lw/UXyuQRow0i7AZEh3O0vdOSovC6Wvts1i4ogHE5LJL7cl3gM3xu9VGm4/ue
 qaMlVIgm6SXGyGIxPolnM9uhYX/WSk6HfNSyo8bhLWfbva96bc8OUYYWhpgvuaPq3bQP
 hPNS+1F9K5Sqn4fyVUGEr3xK6pTPaRc5oNJ43Rwxyjr/Mp9Oej0zp59+y/lAZC5KWePh
 RuBaCowXKLK+/JRxsyUTntXBAwXSNBPugNQV3/NPEqmLgIP1uqEBE3hTNqlZQ2/fTok+
 iqAzlBtsP5s34VXNOnMWyuo7euRQLazEki7/MbbymTmZY6yZea+wtiX5zmH8Tc2YouVk
 9k4w==
X-Gm-Message-State: AOJu0YxyVn3+PMdDGWZa1E+wLLaro/a9ZYFgx+Shg6Vrk91xf8E0r1bj
 FM2AR2o7cKqv98lUPp72KNjvaw==
X-Google-Smtp-Source: AGHT+IGMRXlvc7N98RyQxVVyi3tiwEgH5wHn0jJMXlclEJKBW9LF2Gm4EsWy9kDmfaL2a1lpw5AOhg==
X-Received: by 2002:a81:6d8c:0:b0:59b:c805:de5d with SMTP id
 i134-20020a816d8c000000b0059bc805de5dmr5847079ywc.16.1696523808158; 
 Thu, 05 Oct 2023 09:36:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 z204-20020a0dd7d5000000b0058c8b1ddcc1sm620415ywd.15.2023.10.05.09.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:36:47 -0700 (PDT)
Date: Thu, 5 Oct 2023 12:36:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231005163645.GS8465@bill-the-cat>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8U98MO/x+k8Xc4a"
Content-Disposition: inline
In-Reply-To: <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
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


--B8U98MO/x+k8Xc4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > On 08:48-20231004, Andrew Davis wrote:
> > > On 10/4/23 8:23 AM, Roger Quadros wrote:
> > > > ti_mmc is not a valid boot_target for standard boot flow so
> > >=20
> > > Is there some way to make it into a valid boot_target? Otherwise
> > > how do we use uEnv.txt files, or boot from FIT images with overlays?
> >=20
> > envboot takes care of uEnv.txt file (see
> > https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> >=20
> > Early remote proc loading and FIT image is a question for stdboot itsel=
f.
> >=20
>=20
> If stdboot is missing these features then we shouldn't switch until it
> has them. I'm all for switching to this, but only if it is complete.

Depends on what you mean?  Did you mean an option to run scripts
(exists) or an option to do what TI needs done, via
boot/bootmeth_something.c ?  If the latter, someone from TI needs to
figure out what that should be and do (but plumbing-wise everything it
needs should exist).

--=20
Tom

--B8U98MO/x+k8Xc4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUe5h0ACgkQFHw5/5Y0
tyxz7gv/S80y0PyiCDbnH/pthM4ZAEeE0XF4JxUG4uBuBqe5A14Rh523P2d6v4F3
5ruoOy6kPoBzF7HywNJaY8rSK0Zyrphp831oO9gSKlCBne7kFbQi/3WtuzvQMnEi
XmyycrUH4J9RR2KzCaUlHXUcaD8acT6Ikbele2E4rYw+kIob7iNEHR4PYi6fli0t
mUcvIoBM6I+Wf49CA/qS/TUBJtw+wAupGAWKpmwP1ntqfNHdJw666mLaeeNeEpea
22M9Jk315zk0PTBU2K0zlwfNNs1N0NzOl/lDrLmtePQgl/oFSGWABIiaVpjTjKX2
4UsGbYVqtZoyb5wtqc1sQRViGWUeU7u4G1M1T9wh8fuatNYcLYvfGQhDfzicG6Bg
3c56oDXclwmK9jFBWvcnPdhVUvkb+j1vuMz+QmXS+K3e6k3cfy+pNyMmM1EMvBfI
TbQEd2dpmOGzSxUaU2/+Xb+bifX474Ws4opWvOiEQysQnOk4sqWJg322XHRpy0AC
nVt6YObI
=LgMe
-----END PGP SIGNATURE-----

--B8U98MO/x+k8Xc4a--
