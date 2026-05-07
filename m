Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71553CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 14:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BE984A93;
	Thu,  7 May 2026 16:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DWu/D+QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BE484A9E; Thu,  7 May 2026 16:06:07 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CE684A7D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 16:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcdca9aa0bso1453534a34.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778162763; x=1778767563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GaK/RWS87eDd2ZFZ27AuWUG7teWp98QPsgcDvXdZjfs=;
 b=DWu/D+QG6vQGWk6sxyhist/eZS7Ncuwt0rFJx6xMyCJtbTCD5cmvOPHGMplf5RlBG2
 spXr1BKD/QJCfNeaH8wkZARw/GMz6CwCZO2B2pylYMTfy8YO2BLhIGcD6bpLLVjd6unv
 a5RWDFgI3xGpA8dL7maxqXK91y1XC9ax93z3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162763; x=1778767563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GaK/RWS87eDd2ZFZ27AuWUG7teWp98QPsgcDvXdZjfs=;
 b=agu7nkE5f5Uagn8UyceHvogBip5Yka2AmK1wc0zA+JyY7QX2hDmSzppw3WwpBu3vFa
 AuZRmXvkzoWLvM7Dka1VzUYpn4zthROBXTxkNyGBFZWI8gR3SSSbXCjXBk+2GtEyt5Ar
 vDhTNETQrucgKa9wGjH6IT2GWmbcBtEiA8p6oFT8YxLvdoWqa79vRKFqt3MGZ6n10pmG
 Lb1yXn666x7pMUEgaLfOtI2j71xx6+aIiV9mx29RQ9eRFrLCKldEsHpyW0kNk53tcEMQ
 tCHNZdOdNmPiGraSMNMdIVrNa/PjQuhU1X4kuQrggzVYWbRtYOpMAcrWy8BIHSv7SlBl
 tpsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ86KlmKLYOauQgmbwXHnaPPcGj6iSVne8bZtEZmJM/TWzxdGHrWJheZ1ZXpKWGXdPkDpX3LpeE=@lists.denx.de
X-Gm-Message-State: AOJu0YxmmINJbUHmLVpTelPYIEu34Dxhg6Xbb6bQYlfZQh+buHwtoOSo
 3fPdlih3YfIqQF+PvA8moOTm3JwaDqdCmHCoCYl6in42I8GruDe5ai20vvWTNbAo+I4=
X-Gm-Gg: AeBDievmNdGrui+XuvTD/KYig7olvGIeP4ktFuKMlRQiSBGp43YI3hcLv5BNhqYYDXv
 5YtHpCmelt3pRkZTg0geXYfj2qNCODH+PyZimobzIXxP1DgmTcdLdskd7gx11Uz+5K3UiMA+3sV
 2v1MJPFbkXBavBKtLSFa5un2Q3MRe6LgAOg9XJha2dBTh+S81SOPT+IuV9qMjooZCzz7ZnGTTha
 S2JrtUQZg7i0LFqHJpZg0AMIhcPK/6bn1jsPainDnHZ9uTwF0qTW4ZZbO+643LWY3sM8CYLS2rN
 yvTVfic99BqGKCvlc9WBZLQx6oq5/8e1ST0BNvUQuqYkdVGpWpPfvrrh5P8zg5w0B2pOqoT6jw/
 UtAaTmcspIkuOrEbUMUwRDIYXTHHpCgxG/IAZF2c8yxb98uGLLwOEiwUya9NTvHyTOpB1ROpIbS
 +DgnO+yJLa5Fhq9GrfMHNoRiByF5Azx+POOV511N5EdJNmgpoQsVHOlpx/v33nuiSjvj0ZaTXUn
 u9RIHIeXsgK8oTo5CuMirtWzf+c8wX26VUWITkHxGkQsa4ad9IYsaA6fFj4wQ==
X-Received: by 2002:a05:6808:3509:b0:463:a42c:503a with SMTP id
 5614622812f47-48061be33bamr1685452b6e.14.1778162762965; 
 Thu, 07 May 2026 07:06:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763ffe6csm12581677b6e.6.2026.05.07.07.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:06:01 -0700 (PDT)
Date: Thu, 7 May 2026 08:05:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Guodong Xu <guodong@riscstar.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor@kernel.org>,
 Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream
 folder
Message-ID: <20260507140558.GU1614990@bill-the-cat>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
 <20260429-glare-anybody-16c98d01184e@spud> <afKvzj0yoJ85-5VI@pie>
 <6562F314-D379-42C4-8371-0184E48B8592@gmx.de>
 <20260430143326.GA1614990@bill-the-cat>
 <CAH1PCMaUEmuAEK-aiaScV4OAup=kKmN0A09GDGQnjt=so2dg6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LQ0NQUZzXp6vnhtH"
Content-Disposition: inline
In-Reply-To: <CAH1PCMaUEmuAEK-aiaScV4OAup=kKmN0A09GDGQnjt=so2dg6w@mail.gmail.com>
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


--LQ0NQUZzXp6vnhtH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 07:59:41PM +0800, Guodong Xu wrote:
> Hi Tom, Conor, Heinrich, Yao Zi,
>=20
>=20
> On Thu, Apr 30, 2026 at 10:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Apr 30, 2026 at 07:21:58AM +0200, Heinrich Schuchardt wrote:
> > > Am 30. April 2026 03:26:38 MESZ schrieb Yao Zi <me@ziyao.cc>:
> > > >On Wed, Apr 29, 2026 at 08:48:39PM +0100, Conor Dooley wrote:
> > > >> On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
> > > >> > From: Raymond Mao <raymond.mao@riscstar.com>
> > > >> >
> > > >> > Import k1-pinctrl.dtsi from upstream folder.
> > > >>
> > > >> Why doesn't the platform just use the upstream dts directly?
> > > >
> > > >AFAIK, U-Boot's reset driver for SpacemiT K1 predates land of the
> > > >kernel side driver, and follows a complete different (and to me,
> > > >broken since it combines completely unrelated MMIO regions) ABI.
> > >
> > > Shouldn't we first correct the reset drivers and switch to the upstre=
am kernel device-tree before adding anything new? - This would reduce futur=
e rework.
> >
> > Exactly. That's a condition of bringing stuff in to U-Boot before it's
> > accepted to the kernel. It *must* be updated once the kernel folks have
> > provided feedback, we do not diverge.
> >
>=20
> Chiming in as one of the K1 platform contributors.
>=20
> Yao Zi is right about the reset driver. U-Boot's spacemit,k1-reset driver
> predates the current kernel binding. The kernel K1 reset driver was rewor=
ked
> to use the auxiliary-device mechanism during upstream review. At that
> point the kernel DTS (arch/riscv/boot/dts/spacemit/k1.dtsi) dropped its
> reset-controller node. And it is from there, the K1 uboot and kernel dts/=
dtsi
> files starting to diverge with each other.
>=20
> To pull them back together, with the goal to reuse the kernel dts,
> we plan to:
>=20
> 1. Refactor U-Boot's K1 reset driver to be spawned from each per-syscon
> clock driver via device_bind_driver_to_node(), called from the .bind
> hook in drivers/clk/spacemit/clk-k1.c. More study is requried but for
> now we think this is the correct way. After the refactor, the K1
> build should be able to switch dts/upstream/src/riscv/spacemit/, with
> a simple U-Boot specifics layered as <board>-u-boot.dtsi overlays.
>=20
> 2. After the refactor, we'll rebase the still in-flight K1 SPL bring-up
> work [1] and the PIN/SPI series [2] (this one) on top, dropping
> the patches that imported the forked DT, and resend.
>=20
> Could you confirm this matches your direction? If so, we'll send the
> K1 reset driver refactor as a standalone series first.
>=20
> Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoc=
a@gmail.com/
> [1]
> [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
>=20
> Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoc=
a@gmail.com/
> [2]
> [PATCH 00/16] Add PIN and SPI support for Spacemit K1

=46rom my point of view, yes, whatever is needed such that we can use the
upstream bindings again makes sense and I'll defer to you about how is
best given the SoC design. Thanks!

--=20
Tom

--LQ0NQUZzXp6vnhtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafycQwAKCRAr4qD1Cr/k
CnUrAQDmvTyx3PUNfl7hsjQ6zKu8MWVIraUd4+Va1M6r2Mqm0QEA3c1ml2AnaDne
BtGZ69d3xKqQeUHwYtRCSz/kuhmcmg4=
=yYuQ
-----END PGP SIGNATURE-----

--LQ0NQUZzXp6vnhtH--
