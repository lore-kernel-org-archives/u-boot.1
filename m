Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7006EE6456
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1C188D7E;
	Thu, 12 Sep 2024 09:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726124773;
	bh=Uf7V9I9SkZOKShpijQIEuofKE5mgr+tbVop+5dfYSsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iFNA32xBjJZOYVHXiS6Nxc+CLokUUKCurvpIkFxFjUs3gk8tTI9D1CqY97o1tHL9W
	 jWm8PufFFv81ILlzjY+1fvDB1/MaCOvWChaODgrCNlNq/ddNVvPoo7G6Nntd2xIg8g
	 6eOU00apU2sb9Dgz+qQBFvgwFxipUZD2QMmOsfQ9Fh7D2b91SffchTVM53eu6d9LQP
	 IoV7CXsIVjFJLUpBbrSP1LIoC4XIlyeX4eq8i5McCfS+w6vqHoJ6q3pR0bopV9C+7C
	 2b5Po4lnmyJjPdNzF9N+x1ir8FeX0wRist3PgVPbQrGnU/TTs8j4/VIyM+p3pIbqNA
	 GSduLqndUMAtQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A981888D09;
 Thu, 12 Sep 2024 09:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726124772;
 bh=Uf7V9I9SkZOKShpijQIEuofKE5mgr+tbVop+5dfYSsc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XRqC/HC0Q1hzVaVe6bV2eJBXgXkJgdD+iI6B/fQehm5ZN8Snx/mTIRm1GHGE8DX+8
 SJ7qigezAmbQScxSv0wo0OTrzbFfvvCBS/RfF5FbnAm1RHWnAzea6/YpC48TAp2lKv
 jpCK1jKz3WnkZpMD1XPtVMfpmmvQP2X9sKTa3QwQohR+TkcbgtRj94IAfAiMby67mH
 O0HTPrJZWaoXrcVF+sQoQr/qrsDvyEMFyIGSjrnif4/SpumcFgPfDjXXvpIuR0pJ/H
 9p6g70Pz52CkB3xz2M1eiQndynX7TE7e6wavPAy0wKxcvZRbqk/OPQGyTYv7qUsS/r
 SHjbqV3l3qHfw==
Date: Thu, 12 Sep 2024 09:06:10 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20240912090610.28dc8d00@wsk>
In-Reply-To: <CAFLszTi4pC9TrkB6hNcC1Vn493MkmC_PCn7m+Ajg=0Mrw_Ga9A@mail.gmail.com>
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAFLszTh65OkyXnG3L7XTJFK69EYdj4DZwYGxizu4877n-mCw-w@mail.gmail.com>
 <20240906095459.5565fe29@wsk>
 <CAFLszTi4pC9TrkB6hNcC1Vn493MkmC_PCn7m+Ajg=0Mrw_Ga9A@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D8WOX.jFxNkig3dsg_.hIWO";
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

--Sig_/D8WOX.jFxNkig3dsg_.hIWO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> Hi ,
>=20
> On Fri, 6 Sept 2024 at 01:55, Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Hi Simon,
> > =20
> > > Hi Lukasz,
> > >
> > > On Thu, 5 Sept 2024 at 07:54, Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
> > > >
> > > > Hi Adam,
> > > > =20
> > > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski
> > > > > <lukma@denx.de> wrote: =20
> > > > > >
> > > > > > Hi Simon,
> > > > > > =20
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > > > <festevam@gmail.com> wrote: =20
> > > > > > > >
> > > > > > > > Hi Lukasz,
> > > > > > > >
> > > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > > > <lukma@denx.de> wrote: =20
> > > > > > > > > Unfortunately not - this change is only for properly
> > > > > > > > > setting start address of the u-boot.
> > > > > > > > >
> > > > > > > > > The _real_ problem here is the symbol placement
> > > > > > > > > generated by binman when we try to define the image
> > > > > > > > > as a single one.
> > > > > > > > >
> > > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to
> > > > > > > > > be specific.
> > > > > > > > >
> > > > > > > > > The "fix" (for which I'd been now probably opt) for
> > > > > > > > > this issue would be to generate two images with
> > > > > > > > > binman - one for u-boot-spl-ddr.bin and the final
> > > > > > > > > flash.bin with the former one included (as it was
> > > > > > > > > before SHA1:
> > > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc) =20
> > > > > > > >
> > > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > > >
> > > > > > > > I am adding Adam and Mamta who have tested QSPI booting
> > > > > > > > on imx8mm_beacon and imx8mm_evk, respectively. =20
> > > > > > >
> > > > > > > Note also that I sent a series[1] which allows the
> > > > > > > symbols-base to be adjusted, if that helps. =20
> > > > > >
> > > > > > I've seen them - but not yet tested.
> > > > > >
> > > > > > Thanks Simon for the patch series. =20
> > > > >
> > > > > Is it still broken with this patch series?  I have been
> > > > > traveling and haven't had much time to test. =20
> > > >
> > > > Yes, I can confirm that it is still broken.
> > > >
> > > > I've applied:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.426=
387-1-sjg@chromium.org/
> > > >
> > > > on top of mainline:
> > > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > > >
> > > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help. =20
> > >
> > > Can you please point me to the tree? =20
> >
> > https://github.com/lmajewski/u-boot/commits/imx8mm-test-qspi-boot-binma=
n-patches
> > =20
> > > I suspect that the symbols-base
> > > is already 0, so setting it to 0 has no effect. I'm not sure
> > > though,=20
> >
> > Ach... I see.
> >
> > Please correct me if I'm wrong, but isn't the "symbols-base" an
> > absolute address?
> >
> > This is my impression from the descripion.
> >
> > However, in my case - I would need the "relative" modification -
> > please see the required "hack":
> > https://github.com/lmajewski/u-boot/commit/07c0057fcfd242fa791767aaf0ac=
752d3d0545f7
> > =20
>=20
> From the mailing list it seems you found a solution?

Nope, the "hack" is not for upstreaming...=20

It just shows that some symbols were misplaced and shall be _properly_
fixed by altering either imx8mm-u-boot.dtsi or binman itself.

>=20
> >
> > =20
> > > Regards,
> > > Simon =20
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20
> Regards,
> Simon




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/D8WOX.jFxNkig3dsg_.hIWO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbikuIACgkQAR8vZIA0
zr25dggAg7BxhfJMOdIA5lCHxK3AesDhHYaGG2ydV1+pX2QUdd4v0n1DFLdI3Kod
oONHKEUf2SiPji2u+YKmKJ5W8tUiyZdue3yg5l9bxQk1qrdULxmDhMVP1HWYKSgd
Ihh5trlrpIjlL21GqOGzaIMKCMog2UM1tir76HDPJvfIAbeucKlOcUjBzDY4J5DF
87x0h/iwSIKwQdZ17uEu6+JDQIW6fTIX9UwGMerH6yQQFPCFMJtLH2qH2saZi10b
lOPx+/PToAv/j4IiMEfrbqC6kXC5hfkS+FRIukEfd24Dbmn5zFz0jOBXy+NSauc0
1K5tLmVRewhfKHTT1o8J5SIE4+KJFQ==
=CYYN
-----END PGP SIGNATURE-----

--Sig_/D8WOX.jFxNkig3dsg_.hIWO--
