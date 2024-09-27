Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34ABCEBF62
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B6E890BB;
	Fri, 27 Sep 2024 14:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39EB2890BE; Fri, 27 Sep 2024 14:25:57 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD45C88F85
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 8CD741F0004F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:25:51 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id C219AA604A9; Fri, 27 Sep 2024 12:25:49 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 9F98DA604A2;
 Fri, 27 Sep 2024 12:25:47 +0000 (UTC)
Date: Fri, 27 Sep 2024 14:25:45 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 1/4] rockchip: rk3399-roc-pc: Hook sysreset gpio to
 enable full reset
Message-ID: <ZvakSVYH58S0_TBy@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <4304848f-9af5-4991-bfc8-836ccf2abb43@cherry.de>
 <ZvaAsxlL3GIGyyVL@collins>
 <d48e2192-6cb1-478a-92e0-0f0db5642822@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sep3G3zQ+LPyVaTo"
Content-Disposition: inline
In-Reply-To: <d48e2192-6cb1-478a-92e0-0f0db5642822@cherry.de>
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


--sep3G3zQ+LPyVaTo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le Fri 27 Sep 24, 12:07, Quentin Schulz a =C3=A9crit :
> > > > diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/=
rk3399-roc-pc-u-boot.dtsi
> > > > index aecf7dbe383c..883d399a06a3 100644
> > > > --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> > > > +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> > > > @@ -7,6 +7,10 @@
> > > >    #include "rk3399-sdram-lpddr4-100.dtsi"
> > > >    / {
> > > > +	config {
> > > > +		sysreset-gpio =3D <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
> > >=20
> > > I think this is the wrong pin to use.
> > >=20
> > > The routing of GPIO1_A6 is similar on RK3399 Puma and Pine64 RockPro6=
4, but
> > > it differs massively for the Firefly Roc PC.
> > >=20
> > > However, a similar routing is done for GPIO1_A5 on the Firefly, I bel=
ieve
> > > that one is more appropriate. What do you think?
> >=20
> > I just double-checked the schematics (ROC_3399_PC), looking at signal O=
TP_OUT_H
> > which is definitely connected to GPIO1_A6 (P26).
> >=20
> > Also it clearly resets the board when toggled and solves the MMC reset =
issue
> > I was having on this exact board, so I'm rather confident that it's the=
 right
> > one to use :)
>=20
> At least we're on the same page for using OTP_OUT_H, but it's routed to
> GPIO1_A5 on the schematics I found:
>=20
> https://www.t-firefly.com/download/Firefly-RK3399/hardware/Firefly-RK3399=
_V10/Firefly-RK3399_V10_SCH_(2017-2-8).pdf
>=20
> Mmmmmm seems like I was looking at the wrong schematics?

Ah yes I think the Firefly-RK3399 and ROC-RK3399-PC are two distinct design=
s.

> https://en.t-firefly.com/doc/download/page/id/51.html does route GPIO1_A6=
 to
> the OTP_OUT_H signal..
> https://en.t-firefly.com/doc/download/page/id/78.html
> https://en.t-firefly.com/doc/download/page/id/127.html
>=20
> So, the Roc PC, Roc PC Plus and Roc PC Pro all seem to have a similar
> routing for this pin, therefore:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Right, and for the record the version I have is the ROC-RK3399-PC Plus.

Thanks!

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--sep3G3zQ+LPyVaTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmb2pEkACgkQhP3B6o/u
lQzuWA/7BXiPhvDJyVMcyQG5Zn0b4HC9o0O71QlJUAyqg40mFVRnwv3U62heFKPW
lpzn4oCas0HTZV1efEohdZoImfrVwXdM4lstsCwEnpL9E9UJ6RljQXMbOiaBF1Fv
qPFk6i5m7Fedwq2WJJI6KgzZ+p4r3lXVT8Rk0nHJ7wNgHs++BzbcaOcg334sprSQ
PyfhSM+c3jFHxTY61//jz+tfa8zNOe+hA+YMFQwxSIwcJKPyhqnpwKx0Bx0uDS6e
bnf3rmexTj6EeKiFqRl9ql4Yejms1wx9Qq5qf8aJ01wj/nJQ//Xy4cSY/28rBSUy
wgGYgfwQX5ZcCxXmaqgoIXw+3qcjYSsUl+quR+U0H40lPFaL/hiDfZF5EtyrnwBX
ykiH5TPd4WrQmHE27zwjzTo2GUl9nPsvcnlR1ebrRMgqzo/6TOC6GkE+fmNmawIx
w1PsMHfQIyOXOppkp7jZFdrrf62P76qdTf59S8EkzvTIhDnIb+P/smZieeDFn1pM
i1dHBRa/5HE1jufAQf/rxdEJa44bY4t0Eb8+UX8QIGAUUaKDvaBATK3NvDPQ7wLC
EB0rXK6AT4Xkk86vlKrOPn9ntp31ti3/+aPYKvQCYXB6z3F2hoZOqKC6ha8TcLYe
Gg49vu9JBFcgjaen1SgaPQ8sZaP8ZG5Qq/7lSVfNqSXj0XtGL98=
=A5fK
-----END PGP SIGNATURE-----

--sep3G3zQ+LPyVaTo--
