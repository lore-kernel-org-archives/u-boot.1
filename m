Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332E7E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C95B87540;
	Wed,  4 Oct 2023 15:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C5F87540; Wed,  4 Oct 2023 15:48:30 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 4331087500
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181912243"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 22:48:23 +0900
Received: from unknown (unknown [10.226.92.199])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id B35C8400618A;
 Wed,  4 Oct 2023 22:48:20 +0900 (JST)
Date: Wed, 4 Oct 2023 14:48:19 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 12/16] arm: rmobile: Include <asm/types.h> in header
Message-ID: <20231004134819.4ajesdoiktyejnt6@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-13-paul.barker.ct@bp.renesas.com>
 <c163f447-ae15-2a85-a120-d821848e3e24@mailbox.org>
 <fe6c6582-6155-81d4-0c7f-19c545a4acf7@bp.renesas.com>
 <c2d3799b-634e-4279-a762-8d0d5bd29d23@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="arzbwegngxatstbj"
Content-Disposition: inline
In-Reply-To: <c2d3799b-634e-4279-a762-8d0d5bd29d23@mailbox.org>
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


--arzbwegngxatstbj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:27:50PM +0200, Marek Vasut wrote:
> On 10/4/23 10:57, Paul Barker wrote:
> > On 03/10/2023 14:27, Marek Vasut wrote:
> > > On 9/20/23 14:42, Paul Barker wrote:
> > > > We don't want to rely on source files including <asm/types.h> before
> > > > <asm/arch/rmobile.h>.
> > >=20
> > > What kind of error does this solve ?
> >=20
> > Without this, <asm/types.h> must be included before
> > <asm/arch/rmobile.h>, for example in include/configs/rzg2l-smarc.h added
> > in patch 16, to avoid the following error:
> >=20
> >    CC      arch/arm/lib/asm-offsets.s
> > In file included from include/configs/rzg2l-smarc.h:9,
> >                   from include/config.h:3,
> >                   from include/common.h:16,
> >                   from lib/asm-offsets.c:14:
> > ./arch/arm/include/asm/arch/rmobile.h:49:7: error: unknown type name =
=E2=80=98u8=E2=80=99
> >     49 | const u8 *rzg_get_cpu_name(void);
>=20
> Hmmm, that's weird, why am I not hitting it with the rcar CPU name functi=
on
> too ?

arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h includes
<asm/types.h> as it uses the `u32` type.

However, arch/arm/mach-rmobile/include/mach/rzg2l.h doesn't use anything
=66rom <asm/types.h> so doesn't include it.

Thanks,
Paul

--arzbwegngxatstbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR1tIwAKCRDbaV4Vf/JG
vZsJAQDFfDeyipXPT1GNTLlIc5PSxV7vbW7lAnVOVF7SRYYsnQEAzYzMKvhgNhnA
ewt6Ur/UZwlJFqrMZOBypj2o2O6Ltw8=
=WCNN
-----END PGP SIGNATURE-----

--arzbwegngxatstbj--
