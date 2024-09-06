Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD74CE7AE6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1826A88D06;
	Fri,  6 Sep 2024 09:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725609301;
	bh=PYUPOEhqb24JDnGyrxmDaSRUym7823aAthoOj8OfRJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVDS/sOQjcOhxIRa2tvw96/xqvoT0LTqzFIciS4OLL/NkpYBgaq0iihMdlO0guhpv
	 ZvlJt+P0YXF/2S7354bRPLX5hWE69YJ6ElpYhUsYyYHJgY3JAp5RpysKmrMnNWnLuO
	 0ydNRPC92stjV7grN17wKkn+HV6hON2Fmtkpoo704i6cztTWUhdfTFEJJgcBU08MbQ
	 RIoxn3l4hZopZ3ccgEiU9JnwfCPdPCMTVrGlblQZL8/VrNpN8CESpbu96Pmd7YTByZ
	 XF3fNAFvuJpbM/4Fahl2kJyMVAfZ2VW9sT2rRRYPaE1MFs/ecxfry1IJKtLpp4SADz
	 wWbVm7gO13c9w==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0E45A88D17;
 Fri,  6 Sep 2024 09:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725609300;
 bh=PYUPOEhqb24JDnGyrxmDaSRUym7823aAthoOj8OfRJY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dKexT5TOXm4LLBBRDsTPCzdEinINmeDnytOZo72axKFZgh6nzB51eqVpojsqZRvwa
 J+ZsCVaqbPAUGFuZ5CdE2ulZpt+TIII3WRNRwFkXpS38azgDR6+azouBdhmYQQ4H6v
 +oN0ISnAF91QsjoN3v+XrvIRayxJDsJLE1daBlDGIZnToT23Fm3pvzUeaI1Hp2YvTV
 E5WTj85cdLTGWvIXoCjueraMwlmxCiqSYTSQG5g8q5tNADyRfrjIqtQghLA19YeCSU
 K8gjDfiPAqMjNoDWrOYtT7YMR7YuBKBm/gn3WPvcwSLOwzhIsABnqpiGmLGADxtgm3
 nyavZKAW1NJ1w==
Date: Fri, 6 Sep 2024 09:54:59 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20240906095459.5565fe29@wsk>
In-Reply-To: <CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-mCw-w@mail.gmail.com>
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-mCw-w@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oQDDaNhmB/zxOVq.erEe3.K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/oQDDaNhmB/zxOVq.erEe3.K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> Hi Lukasz,
>=20
> On Thu, 5 Sept 2024 at 07:54, Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Hi Adam,
> > =20
> > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx.d=
e>
> > > wrote: =20
> > > >
> > > > Hi Simon,
> > > > =20
> > > > > Hi,
> > > > >
> > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > <festevam@gmail.com> wrote: =20
> > > > > >
> > > > > > Hi Lukasz,
> > > > > >
> > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > <lukma@denx.de> wrote: =20
> > > > > > > Unfortunately not - this change is only for properly
> > > > > > > setting start address of the u-boot.
> > > > > > >
> > > > > > > The _real_ problem here is the symbol placement generated
> > > > > > > by binman when we try to define the image as a single one.
> > > > > > >
> > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > specific.
> > > > > > >
> > > > > > > The "fix" (for which I'd been now probably opt) for this
> > > > > > > issue would be to generate two images with binman - one
> > > > > > > for u-boot-spl-ddr.bin and the final flash.bin with the
> > > > > > > former one included (as it was before SHA1:
> > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc) =20
> > > > > >
> > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > >
> > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > imx8mm_beacon and imx8mm_evk, respectively. =20
> > > > >
> > > > > Note also that I sent a series[1] which allows the
> > > > > symbols-base to be adjusted, if that helps. =20
> > > >
> > > > I've seen them - but not yet tested.
> > > >
> > > > Thanks Simon for the patch series. =20
> > >
> > > Is it still broken with this patch series?  I have been traveling
> > > and haven't had much time to test. =20
> >
> > Yes, I can confirm that it is still broken.
> >
> > I've applied:
> > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426387-=
1-sjg@chromium.org/
> >
> > on top of mainline:
> > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> >
> > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help. =20
>=20
> Can you please point me to the tree?

https://github.com/lmajewski/u-boot/commits/imx8mm-test-qspi-boot-binman-pa=
tches

> I suspect that the symbols-base
> is already 0, so setting it to 0 has no effect. I'm not sure though,
>=20

Ach... I see.

Please correct me if I'm wrong, but isn't the "symbols-base" an
absolute address?

This is my impression from the descripion.

However, in my case - I would need the "relative" modification - please
see the required "hack":
https://github.com/lmajewski/u-boot/commit/07c0057fcfd242fa791767aaf0ac752d=
3d0545f7


> Regards,
> Simon


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/oQDDaNhmB/zxOVq.erEe3.K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbatVMACgkQAR8vZIA0
zr2QQgf+Ir+ZfGWgP867II0mfhJEBVl69p/6/mr1yWTFpeZkoR9Lvvbbt0Lm5LHV
5h94to7Mj8Ld+H5pAaZdl/Cs8CCTaDSFgJPOqpt9FKIFdnII55Wk18SWJ7VCJUpU
QJiaXkGSFjG3Ezrtn4JSTBeU0LdKY3BT0C+8PIeAT2s4LRiGccytCS8VBKHuq/F7
3cFQBbB3yZJaXR7gYdu0Y7Po9GITe0bmEzxMHjNh8vA9HydsDUYyu41TRDyqlDau
7vMCamr1st2CP6Q8uYMWwBis4CiFV0XIfgM5Kz4i/x5dX0R731BTJn/ksNfsx0KP
cHOXKMpkrDw4Ryea3/nMw3G+Avrp+g==
=N9Gk
-----END PGP SIGNATURE-----

--Sig_/oQDDaNhmB/zxOVq.erEe3.K--
