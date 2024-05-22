Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A87C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989588847C;
	Wed, 22 May 2024 16:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKmtxZb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06968871D; Wed, 22 May 2024 16:10:56 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA43187E0B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c74b27179dso3766274b6e.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716387053; x=1716991853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fC1ijvXrKBXVJPlT+NHHbgFSmiWkus7Bs/k3wkrtV5c=;
 b=ZKmtxZb1xlrUgZYEOr0WPtwmCbAB8vw2hh8VrkuAnr9uCVzFCJ6O2qZNoFtnm7fe1r
 WsVd985MyDlXKadfiIJ4l6tre4vPCRZok5m/XPKB2bzO3kwdGtKvsDZTYZpzQGf3pBod
 rwZd00E/g5yO7A4iA71auZFzHPKiAWQk7tKMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387053; x=1716991853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fC1ijvXrKBXVJPlT+NHHbgFSmiWkus7Bs/k3wkrtV5c=;
 b=bRGaY4ztXYSBhPT4HlT/d5WqI+Kc22j8SU1LvN3MVYF9uomVaFaIv2YeDj2D5xBoRw
 CzlkH9Y2uyIUxpcC3Ad9VHoUZGmdddnqlFN5k3tlwmCgM5GWWegx+PeEcbGCzCX1Zvj1
 dSr/MJhp4UJSR1bWId4wtOU5UoGvSrMVKY8hfCSgpIuntckL104iqH5lUmqDftUR+0qn
 DfYK7tuCiKAbFAMaCvhH74wiOfWjUP4GDrNbInt1aKJZx0VmKtGS2TgkYkt7P2iKwS45
 1kLLr8uyE/5gyVUlRIK4KM6INb2Gzvp2stknyQ9b0Lne2Kw/woqHH9ZLqn2XRixwxi1C
 +jVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOF3ddfXeANNmobuFOmY4PwcZgK+WQyihYfaBc4NdybstPoIRb+1YJA5+2PJWN+zf3Tydf4iv7DoQ7au45RuSYnxipQg==
X-Gm-Message-State: AOJu0YynaF6JYntIaL2WJpi+IvlVTjE6nvrjwBvv6Gf/DlH9qVf+Zns+
 Pz2liEQst0OD5wxYM+Md09vFDjy/5VY2W+C5LjMvU67fJYSkbudjugmcC0ybRls=
X-Google-Smtp-Source: AGHT+IGq4s4Trd55NNL6ldvqpzDx26JSYaSfYC1TznVGlYzHmGdTxSPLhMr4iefUnZa9UjdSO78udw==
X-Received: by 2002:a05:6808:f02:b0:3c9:63d1:6fce with SMTP id
 5614622812f47-3cdba016eaamr2434970b6e.40.1716387053402; 
 Wed, 22 May 2024 07:10:53 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-793003beff1sm726225585a.95.2024.05.22.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:10:52 -0700 (PDT)
Date: Wed, 22 May 2024 08:10:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jon Humphreys <j-humphreys@ti.com>, Neha Malcom Francis <n-francis@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/7] dts: beagleplay: binman: Include firmware
 capsules binman nodes
Message-ID: <20240522141048.GG2568172@bill-the-cat>
References: <20240419212819.170033-1-j-humphreys@ti.com>
 <20240419212819.170033-5-j-humphreys@ti.com>
 <20240510173200.GV2568172@bill-the-cat>
 <86o78yd1ud.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tJuio3RYH97FrlMv"
Content-Disposition: inline
In-Reply-To: <86o78yd1ud.fsf@udb0321960.dhcp.ti.com>
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


--tJuio3RYH97FrlMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 09:20:26PM -0500, Jon Humphreys wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> > On Fri, Apr 19, 2024 at 04:28:16PM -0500, Jonathan Humphreys wrote:
> >
> >> Fill in the BeaglePlay's capsule GUID properties of the base binman ca=
psule
> >> nodes.
> >>=20
> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> ---
> >>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 27 ++++++++++++++++++++
> >>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 15 +++++++++++
> >>  2 files changed, 42 insertions(+)
> >
> > This series introduces failure to build in CI, and it's a little tricky
> > to replicate locally, depending on your environment. You first need to
> > NOT have BINMAN_INDIRS set and instead be using fake binaries. Second,
> > it seems python version dependent perhaps? I don't see this on my host,
> > but by:
> > - Using the CI container
> > - Setting up a virtualenv inside of it
> > - pip install -r tools/buildman/requirements.txt
> > I get:
> > $ ./tools/buildman/buildman --keep-outputs --reproducible-builds -dvel =
--force-build -PEWM --output /tmp/am62x_beagleplay_r5 --board am62x_beaglep=
lay_r5
> > Building current source for 1 boards (1 thread, 12 jobs per thread)
> >        arm:  +   am62x_beagleplay_r5
> > +(am62x_beagleplay_r5) Image 'tiboot3-am62x-gp-evm.bin' is missing opti=
onal external blobs but is still functional: ti-fs-gp.bin
> > +(am62x_beagleplay_r5)
> > +(am62x_beagleplay_r5) /binman/tiboot3-am62x-gp-evm.bin/ti-fs-gp.bin (t=
i-sysfw/ti-fs-firmware-am62x-gp.bin):
> > +(am62x_beagleplay_r5)    Missing blob
> > +(am62x_beagleplay_r5) binman: object of type 'NoneType' has no len()
> > +(am62x_beagleplay_r5) make[1]: *** [Makefile:1126: .binman_stamp] Erro=
r 1
> > +(am62x_beagleplay_r5) make: *** [Makefile:177: sub-make] Error 2
> >     0    0    1 /1              am62x_beagleplay_r5
>=20
> Tom, this is failing in the CI container because the container is missing
> the mkeficapsule tool.
>=20
> To solve this, we just need to add it to the CI container.
>=20
> My understanding of binman's handling of missing bintools is that it shou=
ld
> gracefully continue with fake data, so that buildman can successfully test
> out builds for boards even when you don't have all the required bintools.
> If I have that correct, I can also create a patch to properly handle this
> when using mkeficapsule. But I want to verify this is the desired behavio=
r,
> since mkeficapsule isn't a unique or vendor specific tool, so shouldn't we
> require it as part of the U-Boot build environment and err out if it is
> missing?

Perhaps it's a binman issue since we build mkeficapsule or at least
should be? Neha?

--=20
Tom

--tJuio3RYH97FrlMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZN/N0ACgkQFHw5/5Y0
tyzJfAwAiYdVxHWOyC8DO7ktHHZtwYqtNKLMnRpmy/uKvUNuGtPeTHQ837PxK2Ms
CVHDXRCDSaGAVl2ZaaMHk5rK26NVg1z9624O8iXHfiFx1mN8cN8wGN6BhNPhIX6i
GgZ7jCaQcwRSFoaK/qKRaQTAFn03uVkohS+MVkEmy5rlyHnA9KG+OhqOhU4CI5jZ
6XOR38ZRkTe608DqPBfd2VKvdyuZy8aT8paaKI9UdcGP0UEXx4ZM0QUkLz0zcC6Y
qNCG+EYD9rT7mN4jDm+iE9HtdXFKOGaMHnEC8cH+OeJwnHrKv8gOvGCMP/OUj3LD
12gALJ3fKpgdTPCtpoS2oplAtQpYr5CnGXhLUcaHfPkGshYJ7jUsPwjT9LDvrbbe
+hilua7v4eI+rZD0P425xZpkGS7YyN1s0iFwIL8mOKW62IKKblnFIXh7itVSSoXR
lBNaZ6ELNmu2JZiuLGJ+qYpUZg3HmgSYYiiQs/JPY/F36D0zCIp8Jwd8lDYXYjye
brPltDUQ
=sO2F
-----END PGP SIGNATURE-----

--tJuio3RYH97FrlMv--
