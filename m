Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4EBD33A28
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470EF891CF;
	Tue,  5 Nov 2024 19:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6BE891D0; Tue,  5 Nov 2024 19:46:44 +0100 (CET)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0375B891C7
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 19:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 17FB21F0004F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:46:39 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 3417AA44AFD; Tue,  5 Nov 2024 18:46:38 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 748A1A44AED;
 Tue,  5 Nov 2024 18:46:36 +0000 (UTC)
Date: Tue, 5 Nov 2024 19:46:34 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 2/4] rockchip: rk3399-rockpro64: Hook sysreset gpio to
 enable full reset
Message-ID: <ZypoCrRCX3G8X326@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-2-paulk@sys-base.io>
 <9c472107-7b05-4d77-8cb7-b5971b441e50@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S6RLHuzCV1SRVz0s"
Content-Disposition: inline
In-Reply-To: <9c472107-7b05-4d77-8cb7-b5971b441e50@cherry.de>
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


--S6RLHuzCV1SRVz0s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 05 Nov 24, 16:38, Quentin Schulz a =C3=A9crit :
> Hi Paul,
>=20
> On 9/26/24 8:31 PM, Paul Kocialkowski wrote:
> > From: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > The reset mechanism used by Linux to reset the SoC is known to only
> > partially reset the logic. A mechanism is implemented in
> > rk3399_force_power_on_reset to use a GPIO connected to the PMIC's
> > over-temperature (OTP) reset pin, which fully resets all logic.
> >=20
> > Hook the associated GPIO where the function expects it to enable this
> > reset mechanism and avoid any possible side-effect of partially-reset
> > units.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> Since patches 3 and 4 seems to be a bit controversial, maybe send patches=
 1
> and 2 in a different patch series so those can be merged separately?
>=20
> You may want to have a look at https://lore.kernel.org/u-boot/20241105-rk=
3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de/T/#t

Sounds like a good idea. I should probably wait for your series to get-in
and respin a version of just the sysreset patches with the right bootph fla=
gs.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--S6RLHuzCV1SRVz0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcqaAoACgkQhP3B6o/u
lQzXgA/+MIak/ejhLJcga3tfubyPbjrl1ZRpfsST4bbEBOlhG8noAOAFW+9C1sxb
y6mQcz/23/QU6BBLp6s25dhN8ixYT1B2xSBL9Ho7McwEKk7swLoiREvL1633V1H2
rBR7LRvO+dImHMwJViI8WoDpI+wd+DdE62F5UFZr3B49pD2PQbV6iyyjNhMxZlwY
gf1TkWqiU7rN0xOHumi/VRmRhjwS0VFVo3rIMxQJig+s1n8BLZS6MCAzXlH81c+p
eKkH5xTHB/EETy8EORc28Hwt4U3B4Avn46E5tyfEiGN3ZnxpJEXjeV6YHsnHarYq
HRepG+j8aydgWGDTYsp50KJKqFdn3mLweqesKqplZubi3yYR7ouWfCRYondlpxMP
6H/8rbmCE1gtMVJqAokaJvuGioxT43/8wLMxfPfqDjufiERMWizJGKl3QEpwW0bl
AvUPOHCIpdK7utq3fVMv/69h7R02qa4DdEeRTMJB8kKkFVHIfz2dTrC5oJ6/bUkg
eO4Cp0kXo6qxFTZ45aXBaji0viNPHOecSKr53QnaCjkvrfgUO8dTdF1pvgoErIZT
2lgl3wCFV2gko4C61CI6g3oM0gc9PW7KqRgdtPPxE6zJlwEyTyN9HyDEUSw7sAvm
4AgsBsS5g+2XXQzL1LZY4ygTifIjsB17pzza7yVgyftvOjwcRfM=
=ZvC4
-----END PGP SIGNATURE-----

--S6RLHuzCV1SRVz0s--
