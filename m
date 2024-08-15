Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315F1C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8112788A76;
	Thu, 15 Aug 2024 22:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723752863;
	bh=4ZW0BDMg9SG4RlkDbWa3/MvV6f6G0DpOlwFlk16HyC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IrHoOx+fjT2eJIOnFfiJkKtSnWktZCdc954BBADTq8+3umQ/EtFqvN4WDmXJQlROr
	 1KKDtazBXUa6ohFichRUbHBjqY21itgizgD/pyKejI59CZHqDotnjbqY+2xH2me19l
	 IZb8M5Kre+n8jXvrActPjr+mdP2HshsWHXokdchIfV209v5BirsHVTPBT4vpAt+6zo
	 uLfXQBtmitgdEfcHhaE8KQWZr3XcTJLHCwMWbTD8erHpa/Wbb2XbVTx2LXjheD/Pj2
	 OSDOXA55ZLG4l/kvt0ckPN59bjM25EvevX/u4MBELbpdUmzDdxtE3RtaMFqZQKzGoU
	 AyK6zOBY0llXA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 55E3D8863B;
 Thu, 15 Aug 2024 22:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723752862;
 bh=4ZW0BDMg9SG4RlkDbWa3/MvV6f6G0DpOlwFlk16HyC8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cC6Q9nYzQhKgpY9PxvdlZqgeTwZK6vz/KuIJF0W8nNJi5NlTag+UN2iFPmyFwHtqI
 osvK6mevCVIY3QJ5Q0iizPEQw3aICmW4dY0ae1oHYtrWoWMsxpzYSq5VpC9+pXrJZI
 qlQUA7dEibYc6UBaOImcPFx588JvwbbDN7Djcrta1hLxQxf2aS+i91WcXFTMaLY3BJ
 HN/RhGDo71Rfl8jQbFpbRgsOnbEy01Pz1s0UrCyiD3kGnkMyKz2CCGM/1lOpweQtlf
 9w90LhAYjtTai0a36jYZhnuZu/g45GWvMklLzFGTaaiI67cAttcXWxX7tPUNwrdpXF
 4h8+MVgqdGRbg==
Date: Thu, 15 Aug 2024 22:14:21 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20240815221421.61f64a17@wsk>
In-Reply-To: <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/txxZ.9CNeEwj.X+m_r6IuTP";
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

--Sig_/txxZ.9CNeEwj.X+m_r6IuTP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Aug 8, 2024 at 6:07=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
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
> > Now the question - how to properly fix this issue? =20
>=20
> I assume you fixed the problem with this change:
> https://patchwork.ozlabs.org/project/uboot/patch/20240815080948.457524-1-=
lukma@denx.de/

Unfortunately not - this change is only for properly setting start
address of the u-boot.

The _real_ problem here is the symbol placement generated by binman
when we try to define the image as a single one.

Moreover, this change follows other boards with imx8mm processor -
./configs/imx8mm_beacon_fspi_defconfig to be specific.

The "fix" (for which I'd been now probably opt) for this issue would be
to generate two images with binman - one for u-boot-spl-ddr.bin and the
final flash.bin with the former one included (as it was before SHA1:
37e50627efacd8dae18b564e9d8886a033e181bc)


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/txxZ.9CNeEwj.X+m_r6IuTP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma+YZ0ACgkQAR8vZIA0
zr00pQf+IrLJvcLW3E9NFWjGd4zR5DGe2P5ZAQTSXOSTammpJQZ7l1zps85WdGmk
miS7bcXCnWAYwUku3sL0tnuwLcivT6zC4N1Cf2gd3oVcUWLdCEBCIkyEmjUtEYxA
XERR0lUk8jHz40Kgoe7JNfypVUxl70DorwI0pVvvbuajBiY955YxdyxOKXq00c2B
ep9m1xi2AdobHOU/jmh5pxvE63ZiZvF/jY5UBTvSJE6oo/BV0bpA1A/e0Qwqv73Q
GXF2eV2pseAiJwHcf8h2flVCmobJBEMTNvqgJlh8CLBigA01cxUIYgQ4Q+RuJyjy
BL7NvLB5tPE0ViJhWSXqLPIGOZvbIg==
=UqCd
-----END PGP SIGNATURE-----

--Sig_/txxZ.9CNeEwj.X+m_r6IuTP--
