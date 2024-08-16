Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F889C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 17:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699B088B75;
	Fri, 16 Aug 2024 19:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lrqRIZRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5FC88B83; Fri, 16 Aug 2024 19:22:53 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951BF88AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 19:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70968db52d0so2385751a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723828960; x=1724433760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YUZvtWpnXu66NmMK/mC9Xqt0u9I8pEjcH/d7kHcnPkg=;
 b=lrqRIZRe7dnzKHDn2KQhcaV4WJZ4CAYL4dKHIgEVxg/AbOp5dHdR/0govvsC4rd42P
 /J/YMCUfsaAMPrOlga4PgloHKLE2BJ+/ojGFTfhm2Ic1fmSw9vfPZKeLuPIdCeFiB7Ey
 X/inTwWHdAMjn29y01UegB3ngFh63ZlSxyJWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828960; x=1724433760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUZvtWpnXu66NmMK/mC9Xqt0u9I8pEjcH/d7kHcnPkg=;
 b=Bj8ofHEv8GFkVnFLk4XdE8elQG2RXVbME0e6vjEfFMfufY32T7Umx9ttvceQ+dYP+0
 wwDwUnrB215sLktLnMVtKIQxRkhjTvlKSWL0CH+WggMvspvf1/99zmHTFt7GaWYtmuDd
 rZkXIiNsVMASjglMXRK0ru7jwkoRTENg9gyQCTmYPfjMs4UOXWkDpGp/CY91VTQ16NPR
 ddhnaCsibhapw1l7yyHZCShYTqbxmm5I4AN5ToUsLIYAwFKvj2VawF7V7ZD6gMq89SVO
 VDM0Vk+1yKf64zWKZ+La4OERgdaejJ6dgNMcvgsqo5zqd/WEsFfS4jPnoQwyBKFbz6wd
 9Lmg==
X-Gm-Message-State: AOJu0YxeQSKdub8Mc68LcdPU4KF21tEYuhb8LtyushFjp1m1vOhAQQSx
 vnPPBBWhL5+sdCLfvbAWNRjx02RMUsy4i8rYQqC3oRikGtbqSMI+BQ9Ud+SVRQM=
X-Google-Smtp-Source: AGHT+IFL+KIZPjbeOu8gDYBC7lrxRufN61V0TVAQg4RJ9sHWSaK5Hg2JMlWp8KZYvGaH4BKGGT803Q==
X-Received: by 2002:a05:6830:7110:b0:70c:a98c:4ed with SMTP id
 46e09a7af769-70cac878379mr3790071a34.20.1723828960080; 
 Fri, 16 Aug 2024 10:22:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca639f414sm768531a34.23.2024.08.16.10.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:22:39 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:22:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240816172237.GA1626301@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oNLlbl8kcA72rsWE"
Content-Disposition: inline
In-Reply-To: <20240815195746.749042-3-sjg@chromium.org>
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


--oNLlbl8kcA72rsWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:

> For most boards, the device-tree compiler is built in-tree, ignoring the
> system version. Add a special option to skip this build. This can be
> useful when the system dtc is up-to-date, as it speeds up the build.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
>  tools/buildman/builderthread.py |  4 ++--
>  tools/buildman/buildman.rst     |  3 +++
>  tools/buildman/cmdline.py       |  2 ++
>  tools/buildman/control.py       |  3 ++-
>  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 66 insertions(+), 4 deletions(-)

We should probably do this more generically, outside of buildman. We
have scripts/dtc-version.sh and if the system version isn't new enough
(and we just need to define whatever the minimum version is), then we
build our (not currently that new anymore) dtc instead.

--=20
Tom

--oNLlbl8kcA72rsWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/itMACgkQFHw5/5Y0
tyxLBwv/X4u4fs8TZTZF90SXipOM36CqRJPemqC0odLZhxwZ6gtJ0SWsK5tWaGUQ
uMcPUQrcisAgAD+LO4whaLZRt0uLb6TD67U3qg0KOhGuXwl86eryoZ/10n2aqXcf
4zMgdrNnJAP2wQKoeOYFKQhCoayPfVV62q9nvzYfmUkkd0+Cvl2xf++EJuFlr1ya
0sFDroguwtOCDOwpskp8H6s5vTfNJVVEx4ceaGjvzvYpVFAd5xPA+x7dwFg4c+Gj
d5pyz54VXcGjr6hFX9x9KyN214x/K7jfgER/pNCfMz0xL4+bUVI9z8jtdKPMbOjK
/37Uqs054xLqsBCwNArSMoT2GdRKe+HWcYk/x+pRt4lAeQ+oY092KMQvKq/FTxKi
0MpOHGE6JD/8viKsFFMeuhXPNeJXSy/onDAjV9ydW+n5Tr7vNx4dW5mLCe3GLIO8
YuW4CCQEvEAmaqnZl0OwEo54eHxrPOd6oI1F43DQHtKNI8vd5SX0lwDKm4kmUmLR
/l6Z/zWz
=SM8B
-----END PGP SIGNATURE-----

--oNLlbl8kcA72rsWE--
