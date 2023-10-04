Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A1E7B611
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2748754D;
	Wed,  4 Oct 2023 15:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E0187555; Wed,  4 Oct 2023 15:27:00 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id D129587548
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181911123"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 22:26:50 +0900
Received: from unknown (unknown [10.226.92.199])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id EEE6A400C9ED;
 Wed,  4 Oct 2023 22:26:47 +0900 (JST)
Date: Wed, 4 Oct 2023 14:26:46 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 06/16] arm: rmobile: Add basic R9A07G044L SoC support
Message-ID: <20231004132646.qj72ofp2fdt3cbrc@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-7-paul.barker.ct@bp.renesas.com>
 <f39461fe-cbfb-2bef-b012-0ca5c546520f@mailbox.org>
 <8d68fc58-6af4-8fa1-5683-f456a9ddf393@bp.renesas.com>
 <b8a2e546-e14d-4c08-b841-87e06a53104e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7dd7naek43jyotsi"
Content-Disposition: inline
In-Reply-To: <b8a2e546-e14d-4c08-b841-87e06a53104e@mailbox.org>
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


--7dd7naek43jyotsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:15:24PM +0200, Marek Vasut wrote:
> On 10/4/23 09:59, Paul Barker wrote:
> > On 03/10/2023 13:46, Marek Vasut wrote:
> > > On 9/20/23 14:42, Paul Barker wrote:
> > > > Add a config option for the R9A07G044L SoC used in the RZ/G2L so th=
at we
> > > > can make use of this in the subsequent driver patches.
> > > >=20
> > > > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >    arch/arm/mach-rmobile/Kconfig.rzg2l | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rm=
obile/Kconfig.rzg2l
> > > > index 37ff6cd34160..266f82c18085 100644
> > > > --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
> > > > +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
> > > > @@ -3,6 +3,11 @@
> > > >    if RZG2L
> > > > +config R9A07G044L
> > > > +	bool "Renesas R9A07G044L SoC"
> > > > +	help
> > > > +	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
> > >=20
> > > I was under the impression that RZ/G2L is a SoC family, so the
> > > R9A07G044L is part of that SoC family ? Maybe just reword this paragr=
aph
> > > and the commit message a bit to make it less confusing.
> >=20
> > The confusion is hard to avoid (see my reply re patch 5 of this series),
> > but I'll see if I can improve this a bit in v2.
>=20
> So uh ... RZ/G2L is both the name of R9A07G044L SoC (what's the R9... mod=
el
> number of e.g. RZ/G2LC?) and a family name ?

Yes. Definitely easy to confuse!

We have (with differences from the RZ/G2L model numbers highlighted):
 * RZ/G2L  (R9A07G044L1 or R9A07G044L2)
 * RZ/G2LC (R9A07G044*C*1 or R9A07G044*C*2)
 * RZ/G2UL (R9A07G04*3U1*)
 * RZ/V2L  (R9A07G0*5*4L1 or R9A07G0*5*4L2)
 * RZ/Five (R9A07G04*3F0*)

The last digit indicates the number of cores (1 or 2), except for on the
RZ/Five which has one core but the model number ends in a zero.

Thanks,
Paul

--7dd7naek43jyotsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR1oCAAKCRDbaV4Vf/JG
vW8cAP9aZBulNmhrhlmK2KnL9h7aaZes1T+EskmksyCj5wYiAwEAlQbDGzqr+LdS
mmXCCMi1Fw2dMtv1Vc8w42ABybqHSAI=
=Zzin
-----END PGP SIGNATURE-----

--7dd7naek43jyotsi--
