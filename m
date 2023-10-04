Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9F7E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A5887202;
	Wed,  4 Oct 2023 15:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C1B887568; Wed,  4 Oct 2023 15:56:17 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 85FB786E59
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181912560"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 22:56:09 +0900
Received: from unknown (unknown [10.226.92.199])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 229E5400618A;
 Wed,  4 Oct 2023 22:56:06 +0900 (JST)
Date: Wed, 4 Oct 2023 14:56:05 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
Message-ID: <20231004135605.57xbqpqu6a2fafoh@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
 <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
 <52c1d2c3-9b43-9519-b014-02a107a4cc28@bp.renesas.com>
 <26a440db-073b-4615-9e20-03a74cc46b23@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hmpwfsbxgq3h576e"
Content-Disposition: inline
In-Reply-To: <26a440db-073b-4615-9e20-03a74cc46b23@mailbox.org>
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


--hmpwfsbxgq3h576e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:33:07PM +0200, Marek Vasut wrote:
> On 10/4/23 11:36, Paul Barker wrote:
>=20
> [...]
>=20
> > > > +int dram_init(void)
> > > > +{
> > > > +	return fdtdec_setup_mem_size_base();
> > > > +}
> > > > +
> > > > +int dram_init_banksize(void)
> > > > +{
> > > > +	fdtdec_setup_memory_banksize();
> > >=20
> > > This and the one function above can likely go into arch/mach-rmobile/
> >=20
> > We're not able to test every supported mach-rmobile board so we've
> > preferred to keep changes to RZ/G2L specific code where possible. I'm
> > happy to merge this into mach-rmobile (along with the similar code in
> > board/renesas/rcar-common/common.c), but it will only be tested on the
> > boards we have in our team.
>=20
> Don't you already have a G2L specific file in arch/arm/mach-rmobile/ ?
>=20
> (I can test whatever changes on R-Car if needed)

We could move these into arch/arm/mach-rmobile/memmap-rzg2l.c I guess.

>=20
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void __weak reset_cpu(void)
> > > > +{
> > >=20
> > > Is this platform missing a way to reset the system ?
> > > Please fix.
> >=20
> > Adding reset support is on my todo list. I'm prioritising Ethernet
> > support above this right now, but we don't mind too much what order we
> > do things. Let me know if you'd prefer us to prioritise reset support.
>=20
> Isn't the reset like really really simple ? Enable SYSRESET config option
> and do TFA/SMC reset I guess ?

We don't have support for that in TF-A yet.

Thanks,
Paul

--hmpwfsbxgq3h576e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR1u9QAKCRDbaV4Vf/JG
vdXzAQDVWbBHFLGlJ0gjDCWs5nHW/xagboToEhL9brwaX9VFEAD/ct3x4iLdXQ5a
1en5JL4qxUVrtBghQ/Et96Lc/OM7cw4=
=Hg0P
-----END PGP SIGNATURE-----

--hmpwfsbxgq3h576e--
