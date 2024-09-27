Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC98ACEBF8D
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 09:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A71589094;
	Fri, 27 Sep 2024 11:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9800A890AC; Fri, 27 Sep 2024 11:54:14 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD78908D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 11:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 02B9C1F0004D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:54:05 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 9B54AA603FF; Fri, 27 Sep 2024 09:53:59 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id DD453A603F5;
 Fri, 27 Sep 2024 09:53:57 +0000 (UTC)
Date: Fri, 27 Sep 2024 11:53:55 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 1/4] rockchip: rk3399-roc-pc: Hook sysreset gpio to
 enable full reset
Message-ID: <ZvaAsxlL3GIGyyVL@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <4304848f-9af5-4991-bfc8-836ccf2abb43@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iUlHLVSaNmgr6bRp"
Content-Disposition: inline
In-Reply-To: <4304848f-9af5-4991-bfc8-836ccf2abb43@cherry.de>
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


--iUlHLVSaNmgr6bRp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

Thanks for looking into this!

Le Fri 27 Sep 24, 11:25, Quentin Schulz a =C3=A9crit :
> I'm not entirely sure on whose side the issue is, but I didn't receive yo=
ur
> mails, either from the U-Boot mailing list or directly from the Cc field.=
 I
> however could find the patch on lore.kernel.org... and I also received yo=
urs
> and Dragan's exchange on patch 4 (but not the patch itself). Any chance y=
ou
> received something from my mail server? Does anyone in Cc of this mail
> actually received the mail?

No automatic reply from your mail server and the logs look good on my side,
with a 250 result on all sent patches. Strange indeed...

> > diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk33=
99-roc-pc-u-boot.dtsi
> > index aecf7dbe383c..883d399a06a3 100644
> > --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> > @@ -7,6 +7,10 @@
> >   #include "rk3399-sdram-lpddr4-100.dtsi"
> >   / {
> > +	config {
> > +		sysreset-gpio =3D <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
>=20
> I think this is the wrong pin to use.
>=20
> The routing of GPIO1_A6 is similar on RK3399 Puma and Pine64 RockPro64, b=
ut
> it differs massively for the Firefly Roc PC.
>=20
> However, a similar routing is done for GPIO1_A5 on the Firefly, I believe
> that one is more appropriate. What do you think?

I just double-checked the schematics (ROC_3399_PC), looking at signal OTP_O=
UT_H
which is definitely connected to GPIO1_A6 (P26).

Also it clearly resets the board when toggled and solves the MMC reset issue
I was having on this exact board, so I'm rather confident that it's the rig=
ht
one to use :)

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--iUlHLVSaNmgr6bRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmb2gLMACgkQhP3B6o/u
lQzKkQ//SmtYIN1s6tarrzre/BDAp+gQur5rm8kCh1tiz7q+/ziWJyRzOnVLeYOz
WfqMUreWAqPIDJE739WZbPcri+cxlCrNcIZyysDbF3WhBdlX78WOLBzQS2tRL9Ra
gS2rVL5WHH/hCRg+JmEgb3PXrIygtioqYb3VQoNZkNxM/jwJOhcNNTOjFMPeGXJh
U6RBej8tEWaBsOaTliqMKl6fVKF7cbj4naLdpskxuElilfH1n7WGeQFZ30EVFoBG
FfhRIiVuyH9jSa4k7WhKAXhnj/JO0duTxXR9Au0jI7iKDTZS+lK5pPPbEsNwZ7hc
kiHbXhMV0z67uFnNPgkpVzSpGFqEjib9NyVwDQ4M1PeGu03yaVafqWonF0iLBsFn
md3smP9Q6bHS/iLysCT+i97UtR70zs5apIws9i7pV5Xh0Y6EqsoqDosdKxZZ6u1k
R8YmF55a2i1rJaBvWSwHJD0HvRtZPFkXGDqIerpS5SdQ9xyekVf+Jz+OqzoemX6h
vSsnRmeJsPGZSXvZY7MSGX3+EJUyaqHCpMK45IYdOEAhVDSefSvhVQTvWm3JPnWk
aICyNC/TzlY/o1BdbhOxJg9TfP4zMXTd7h5em3ezFo+cHl8HA54+Wo+Q5qqnmSQp
Vu7B04c78WmnQNRgwZd9cLFJ4By7wxaYTTkH8t6nQi4nMD/aTDk=
=ueWF
-----END PGP SIGNATURE-----

--iUlHLVSaNmgr6bRp--
