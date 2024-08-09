Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D0C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CD488702;
	Fri,  9 Aug 2024 11:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723197120;
	bh=O7Tc8ec540hkdMaQptH6vdCZaMnikgHIbHnQ6JaU+hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JU0OXFa/RP4wtrDxc2GEHoxbqDKh/ERoywilazuOzq5oUrHWTHleG3HxgxVdLKK2J
	 oDZvpEkt881EJe4JOlLGuozR5V4p6SqO9rDAoruvrZcfw0LYcixUJmME3OGd3Zbumu
	 gLU5p5xG7yI/KViugJBeP/bj5sR3HlQDt0DE1maLryAnbvrYSqI238UCzh06mla043
	 XDCC7K7MAJpgXO+Zp2Eb5ZR/uQXPOU4gpVtsrwchWKfwU9CjmuChqh7ZlIVVcbiGd/
	 KQ7roO+jcWeC9QnkmbzjKRKy4zcx8ieOGVh58hvw/9KjiA9lGBg2aKFpjQkYCl7iRh
	 XbZkZw7sWNRXQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 44FCB88027;
 Fri,  9 Aug 2024 11:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723197119;
 bh=O7Tc8ec540hkdMaQptH6vdCZaMnikgHIbHnQ6JaU+hc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eS8bektHXnFAwG9XFMBSYcCNnXSZBEqDw10II648nELhogPt2hl06y0EuciM1NhNA
 VXaXMo3MCBzgIi5baRCtGIL9sYh+HtLYnMg/qYjSHhawM/lr0NVdLS9W9DAiwLYC1L
 Z+jEUROrOuzmrGSKaj6XcvsvuWhQkfPknMHR1QR1Fq+VaJV/Eeb+n4hI8mBBBwiHUu
 2oRVj0NMblPLqXo+Pr0GlYHrulG6X8nHAvOJFKBBBYDZTL0C5iZLqDxGVANwF71RlE
 cdualH0cMOEPu8sFeQC9TIDh0q2DxUVvMu82dRtsWkfw9WXKJtpTc6pBvd5lsACaaF
 BnbdNo3p3XbFg==
Date: Fri, 9 Aug 2024 11:51:58 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20240809115158.537051d5@wsk>
In-Reply-To: <CAFLszThwMEoiXTQnogYd19j82vAeqFao=c2ZnWuUr-BiAPcadQ@mail.gmail.com>
References: <20240808110654.4215b129@wsk>
 <CAFLszThwMEoiXTQnogYd19j82vAeqFao=c2ZnWuUr-BiAPcadQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z0+eG6uo6A26X+0a6/DDDww";
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

--Sig_/z0+eG6uo6A26X+0a6/DDDww
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> Hi Lukasz,
>=20
> On Thu, 8 Aug 2024 at 03:06, Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Dear Community
> >
> > I'd like to ask about one issue with generation of symbol offsets in
> > binman [1].
> >
> > In my case the CONFIG_FSPI_CONF_HEADER is defined.
> >
> > Problem is with generated symbols [2] to point into
> > ddr-1d-imem-fw/ddr-1d-dmem-fw/ddr-2d-imem-fw/ddr-2d-dmem-fw.
> >
> > It looks like only symbols have extra offset of 0x1000 (the same as
> > the first section introduces) - binaries for training memory are
> > placed without this extra offset.
> >
> > On the other hand - before this change:
> > SHA1: 37e50627efacd8dae18b564e9d8886a033e181bc
> >
> > The u-boot-spl-ddr.bin was a separate binman "entry" (i.e. not
> > section)
> > - so e.g. ddr-1d-dmem-fw {} had proper offsets (as this binary was
> > also mangled into spl.bin with mkimage invocation).
> >
> >
> > Now the question - how to properly fix this issue?
> >
> > I've tried to add pad-before =3D <0x1000>; to ddr-1d-imem-fw property
> > hoping to "move" this binary itself by 0x1000. However with it the
> > symbol of ddr-1d-dmem-fw is moved up as well.
> >
> > Another option was to try alignment 'align-size' set to 0x1000 -
> > effect is the same as described above.
> >
> > In the documentation [3] - I've found that I could use
> > "ProcessEntryContents()" for tweaking, but this seems to be not
> > eligible (as all imx8mX boards, which are going to boot from fspi)
> > are affected.
> >
> > Maybe falling-back to 'multiple-images' [4] and generate the
> > u-boot-spl-ddr.bin in that way is a proper solution?
> >
> >
> > Last but not least - this problem is not present when one boots from
> > SD/eMMC as in this case the "fspi_conf_block" property is not
> > present and everything starts with 0x0 offset.
> >
> > Thanks in advance for your help. =20
>=20
> BTW we are waiting for tests for this etype...when those are in place
> it should provide a way to test the behaviour.
>=20
> I see that Entry_nxp_imx8mimage.SetImagePos() adjusts the image-pos.
> Is that the symbol you are writing? Are you saying that the image_pos
> symbol that is written is incorrect?
>=20

Yes, it is up by +0x1000 when compared to the real place where binaries
(like ddr_1d_imem_fw) are placed.

> Or are you using u-boot-spl-mkimage.signed.bin (i.e. without the 4KB
> header) in the first section.

No, HAB (signing) is disabled.

Instead I'm using the CONFIG_FSPI_CONF_HEADER from [1]. It adds FSPI
(QSPI) specific header with 0x1000 size.

>=20
> The image_pos is an absolute image position, so it doesn't matter what
> sections are written out as files. The image_pos will be the same
> regardless.

To have the board booting again - I do need to perform:

 imem_start -=3D 0x1000;
 dmem_start -=3D 0x1000;

added at [5].

>=20
> Why are u-boot-spl-mkimage.signed.bin and u-boot-fit.signed.bin
> written out? Aren't they just intermediate images, not useful for
> flashing to the board? If not, why is the FSPI conf block before them?
>=20

As stated above - I'm not using HAB so those are not created.

The FSPI block is required to boot the device with QSPI - it holds meta
data to configure the memory itself.

> There is a 'skip-at-start' property which might be useful here, so
> long as I understand the above correctly.

Ok - I will try it.

Thanks for your help :-)

>=20
> Regards,
> Simon
>=20
>=20
> >
> >
> > Links:
> >
> > [1] -
> >  https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8mm=
-u-boot.dtsi?ref_type=3Dheads#L49
> >
> > [2] -
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/ddr/imx/phy/=
helper.c#L27
> >
> > [3] -
> > https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#=
L526
> >
> > [4] -
> > https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#=
L371
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

Links:

[5] -
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/ddr/imx/phy/help=
er.c#L87


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/z0+eG6uo6A26X+0a6/DDDww
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma15r4ACgkQAR8vZIA0
zr2y1AgAm58SrzN0cX2/JQhJWTAyiS58SGEhi9ly5uFtrRB5VLzbjdDKAbemzE5Z
mbBawAxg1PwKYrewC+hbHDGaSnS8YMUah0ViO0e1kXw7y4+vvGYzHhCdcLW5Fkx8
8s4AgQFXdp4ejOZhpm8h89DXJquC8EiQGUolffiWnH6qXX50Cx61IwOKFQSM3Nnx
BA/Oo+EHPdi2ckGFgqTlPuRnUAtA6OgmFvz8QNpueANnpHnBeX4T1PGU8wvvWaty
hqM19fBAS5JdI1CmpZ71RSmCR4unVPLcyq0tJvyea/sPSRrevEqkeC2U4dHROnnK
mpxYJnXuTOaK1oSUd5ijLHZJC9HF2g==
=Ad8Y
-----END PGP SIGNATURE-----

--Sig_/z0+eG6uo6A26X+0a6/DDDww--
