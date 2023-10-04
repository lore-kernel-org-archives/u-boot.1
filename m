Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58803E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8330487524;
	Wed,  4 Oct 2023 15:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0084874CC; Wed,  4 Oct 2023 15:54:10 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id C9944874E8
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181912495"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 22:54:06 +0900
Received: from unknown (unknown [10.226.92.199])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id F2D59400618A;
 Wed,  4 Oct 2023 22:54:03 +0900 (JST)
Date: Wed, 4 Oct 2023 14:54:02 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
Message-ID: <20231004135402.7hnhb2li66ixyro3@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
 <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
 <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
 <f3f30fb3-65ed-4070-9f5a-2efd84acc722@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5h7azbqfrhr5tij5"
Content-Disposition: inline
In-Reply-To: <f3f30fb3-65ed-4070-9f5a-2efd84acc722@mailbox.org>
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


--5h7azbqfrhr5tij5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:30:53PM +0200, Marek Vasut wrote:
> On 10/4/23 11:18, Paul Barker wrote:
>=20
> [...]
>=20
> > > > +static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] =3D {
> > > > +	{
> > > > +		.virt =3D 0x0UL,
> > > > +		.phys =3D 0x0UL,
> > > > +		.size =3D 0x40000000UL,
> > > > +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > > > +			 PTE_BLOCK_NON_SHARE |
> > > > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > > > +	}, {
> > > > +		.virt =3D 0x40000000UL,
> > > > +		.phys =3D 0x40000000UL,
> > > > +		.size =3D 0x03F00000UL,
> > > > +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > > > +			 PTE_BLOCK_INNER_SHARE
> > > > +	}, {
> > > > +		.virt =3D 0x47E00000UL,
> > >=20
> > > What's this part about ?
> >=20
> > This is copied from the RCar Gen3 memory map.
>=20
> I suspected as much. Please recheck the memory map instead of copy-paste =
and
> make sure it is really matching the hardware.

Sorry, I wasn't specific enough there.

The addition of an entry at 0x40000000 of size 0x03F00000, followed by a
gap until 0x47E00000, is coped from R-Car as the way TrustedFirmware and
OP-TEE use the first 128MiB of system memory is the same. The mappings
here are due to the software configuration of TrustedFirmware & OP-TEE,
not due to the hardware.

The hardware itself has a pretty simple memory map which is shown in the
commit message. The memory map in this file is complete.

I have a note in the commit that says "Within the DDR area, the first
128 MiB are reserved by TrustedFirmware.", I probably just need to
expand on why we need the mappings at 0x40000000 and 0x47E00000, instead
of just using the mapping from 0x48000000 that's in the dtb.

>=20
> > > > +		.phys =3D 0x47E00000UL,
> > > > +		.size =3D 0xF8200000UL,
> > > > +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > > > +			 PTE_BLOCK_INNER_SHARE
> > > > +	}, {
> > > > +		/* List terminator */
> > > > +		0,
> > > > +	}
> > > > +};

Thanks,
Paul

--5h7azbqfrhr5tij5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR1uegAKCRDbaV4Vf/JG
vbEiAQDRya2+RIYNdi63zJX9iGlbA0Ua90fMoEUqpR4zDjnnQwEApKwi5+6SXAgD
i+k8dHP1sELYdOCO1+Pbuh5aMhAXew0=
=rKSB
-----END PGP SIGNATURE-----

--5h7azbqfrhr5tij5--
