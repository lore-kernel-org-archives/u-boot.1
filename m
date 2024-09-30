Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B2CCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 19:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F4489003;
	Mon, 30 Sep 2024 21:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAF189016; Mon, 30 Sep 2024 21:07:47 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 446CE88FDA
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 21:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 34B1A1F00050
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 19:07:41 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id E9A8DA60DC0; Mon, 30 Sep 2024 19:07:38 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 2874FA60DB8;
 Mon, 30 Sep 2024 19:07:37 +0000 (UTC)
Date: Mon, 30 Sep 2024 21:07:34 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 3/4] rockchip: rk3399-rockpro64: Disable bootstage
 instrumentation config
Message-ID: <Zvr29j1cyTNmq-RN@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-3-paulk@sys-base.io>
 <CALeDE9NkpxES=SRKxH6=xk_94rRK9Y0gwuj=C-d+eddjOd_gkg@mail.gmail.com>
 <CAFLszTgqGGMm3Hxa2FmT9Z6-BFAR8J6cgb2PNBE8FR=S-X8c8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PCCGejnIGNoG7agE"
Content-Disposition: inline
In-Reply-To: <CAFLszTgqGGMm3Hxa2FmT9Z6-BFAR8J6cgb2PNBE8FR=S-X8c8A@mail.gmail.com>
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


--PCCGejnIGNoG7agE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 30 Sep 24, 12:52, Simon Glass a =C3=A9crit :
> On Mon, 30 Sept 2024 at 03:03, Peter Robinson <pbrobinson@gmail.com> wrot=
e:
> > On Thu, 26 Sept 2024 at 19:32, Paul Kocialkowski <paulk@sys-base.io> wr=
ote:
> > > The boot timing and reporting (bootstage) infrastructure is useful for
> > > performance analysis and debug but adds overhead and console noise wh=
en
> > > using the device normally. Remove it from the device config.
> > >
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> >
> > This makes sense, for those that want this information will know how
> > to build it for testing.
>=20
> Can you just disable the report? There should be no need to disable
> bootstage itself.

I see bootstage as a debug/development feature, so I don't really see why it
should be enabled on default builds.

Besides the console noise aspect, my intent here is also to tidy up this co=
nfig.

Cheers,

Paul

> Regards,
> Simon
>=20
>=20
> > > ---
> > >  configs/rockpro64-rk3399_defconfig | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-r=
k3399_defconfig
> > > index fc0804a0b80d..095d27ffaa04 100644
> > > --- a/configs/rockpro64-rk3399_defconfig
> > > +++ b/configs/rockpro64-rk3399_defconfig
> > > @@ -19,8 +19,6 @@ CONFIG_SPL_SPI=3Dy
> > >  CONFIG_SYS_LOAD_ADDR=3D0x800800
> > >  CONFIG_PCI=3Dy
> > >  CONFIG_DEBUG_UART=3Dy
> > > -CONFIG_BOOTSTAGE=3Dy
> > > -CONFIG_BOOTSTAGE_REPORT=3Dy
> > >  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3399-rockpro64.dtb"
> > >  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > >  CONFIG_SPL_MAX_SIZE=3D0x40000
> > > @@ -38,7 +36,6 @@ CONFIG_CMD_POWEROFF=3Dy
> > >  CONFIG_CMD_USB=3Dy
> > >  # CONFIG_CMD_SETEXPR is not set
> > >  CONFIG_CMD_TIME=3Dy
> > > -CONFIG_CMD_BOOTSTAGE=3Dy
> > >  CONFIG_SPL_OF_CONTROL=3Dy
> > >  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-=
clocks assigned-clock-rates assigned-clock-parents"
> > >  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> > > --
> > > 2.46.2
> > >

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--PCCGejnIGNoG7agE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmb69vYACgkQhP3B6o/u
lQzEOQ/9FmJgyG9rtOfxFExvllbAZ+y+BC8n4IWLbab6Wtwt/8ImJGFGdXxjJx+v
PleCas3pBi+7XINjRmS+Uofl1Oa+zWgizewZAQaZTUXfih6YG7MZXT7cZwpK9EWl
/oMLT/XG3ojixWFx9Bqdlg8a0yPiPhcTxZD2kNGbREo8exkvNduFhpM5HfMmn6Xj
Xd7O7JY9KUbII09OEzFD0WolarUFaXdvDGzav+BTD+SjTU7FFZFBRDcASeH8XCi/
kboawPPZfdYSs4anhQXodbJpBkCFCaY5cUVr830iH4RQBZE451tLaPm18ZPzr2hq
Phgj8yPsPt3AGQqHPe0N8YHyAcwbR44aN9ptZj0XGVWuoVO0NN5UZvj7plRwyp3r
eA9jUWGGDuJ/2g6d+omLKmjqxSW+QJ0QqpS2RfrDkawAU3I4tGZ2IjkwmumCdvNp
tst5FVU+hb9DrNts/oUmV4tbwrQiwBOOqAyCvrkHQSqCvyNDNgrrWcxbVSukORph
qT6eRw2kxNUnARQ7QYLZ4Mg3qpyL3FigNlSP1llEcJqq84tYEUb4ReTS4k0M/F6/
F2wcUChNHQeuKCEhNQCO9B1VK9Aa4nutd4XtYg0A4Ts97hHYoNVOlshDYJ/NlnJ2
VbdGFmeD2q90ycIceOoPra/UBS60GCBoZkg/Bu3/qCcwLKF9MIU=
=m+zY
-----END PGP SIGNATURE-----

--PCCGejnIGNoG7agE--
