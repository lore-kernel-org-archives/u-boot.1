Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA35E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D48874A9;
	Wed,  4 Oct 2023 18:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0F0874A9; Wed,  4 Oct 2023 18:41:28 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 0033187493
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="178178193"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2023 01:41:22 +0900
Received: from unknown (unknown [10.226.92.49])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id 2358A403676D;
 Thu,  5 Oct 2023 01:41:19 +0900 (JST)
Date: Wed, 4 Oct 2023 17:41:18 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 12/16] arm: rmobile: Include <asm/types.h> in header
Message-ID: <20231004164118.pxyfpt43odqgbohh@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-13-paul.barker.ct@bp.renesas.com>
 <c163f447-ae15-2a85-a120-d821848e3e24@mailbox.org>
 <fe6c6582-6155-81d4-0c7f-19c545a4acf7@bp.renesas.com>
 <c2d3799b-634e-4279-a762-8d0d5bd29d23@mailbox.org>
 <20231004134819.4ajesdoiktyejnt6@GBR-5CG2373LKG.adwin.renesas.com>
 <e0e13fe4-8bf9-4f26-8758-773dd0f9f40e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a2z7it4ynsfa3hki"
Content-Disposition: inline
In-Reply-To: <e0e13fe4-8bf9-4f26-8758-773dd0f9f40e@mailbox.org>
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


--a2z7it4ynsfa3hki
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 05:19:43PM +0200, Marek Vasut wrote:
> On 10/4/23 15:48, Paul Barker wrote:
> > On Wed, Oct 04, 2023 at 02:27:50PM +0200, Marek Vasut wrote:
> > > On 10/4/23 10:57, Paul Barker wrote:
> > > > On 03/10/2023 14:27, Marek Vasut wrote:
> > > > > On 9/20/23 14:42, Paul Barker wrote:
> > > > > > We don't want to rely on source files including <asm/types.h> b=
efore
> > > > > > <asm/arch/rmobile.h>.
> > > > >=20
> > > > > What kind of error does this solve ?
> > > >=20
> > > > Without this, <asm/types.h> must be included before
> > > > <asm/arch/rmobile.h>, for example in include/configs/rzg2l-smarc.h =
added
> > > > in patch 16, to avoid the following error:
> > > >=20
> > > >     CC      arch/arm/lib/asm-offsets.s
> > > > In file included from include/configs/rzg2l-smarc.h:9,
> > > >                    from include/config.h:3,
> > > >                    from include/common.h:16,
> > > >                    from lib/asm-offsets.c:14:
> > > > ./arch/arm/include/asm/arch/rmobile.h:49:7: error: unknown type nam=
e =E2=80=98u8=E2=80=99
> > > >      49 | const u8 *rzg_get_cpu_name(void);
> > >=20
> > > Hmmm, that's weird, why am I not hitting it with the rcar CPU name fu=
nction
> > > too ?
> >=20
> > arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h includes
> > <asm/types.h> as it uses the `u32` type.
> >=20
> > However, arch/arm/mach-rmobile/include/mach/rzg2l.h doesn't use anything
> > from <asm/types.h> so doesn't include it.
>=20
> Shouldn't arch/arm/mach-rmobile/include/mach/rmobile.h include the types.h
> then ?

That's what this patch adds.

Thanks,
Paul

--a2z7it4ynsfa3hki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR2VrgAKCRDbaV4Vf/JG
vat+AQD7wwmOFOBH97w7ftKerT6U4bd9L4b4vTh7PQu630gyAAEA2i/4egKfrCQc
cmummN0teneLaHnP3PIQHHXjW2kBhQg=
=qyb0
-----END PGP SIGNATURE-----

--a2z7it4ynsfa3hki--
