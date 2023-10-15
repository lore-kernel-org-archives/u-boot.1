Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA61CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 18:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9796A86524;
	Sun, 15 Oct 2023 20:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E8F86529; Sun, 15 Oct 2023 20:00:23 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id E9CB0863C9
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 20:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,226,1694703600"; 
 d="asc'?scan'208";a="179316029"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 03:00:06 +0900
Received: from unknown (unknown [10.226.92.23])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id 8EB8A40525C2;
 Mon, 16 Oct 2023 03:00:03 +0900 (JST)
Date: Sun, 15 Oct 2023 18:59:38 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 12/19] serial: sh: Add RZ/G2L SCIF support
Message-ID: <20231015175938.rf2wnvpgpyrn56cz@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
 <4beeef07-6cdc-4f34-8ed1-5ba31c36f04c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gdteez7kcn3vgmsq"
Content-Disposition: inline
In-Reply-To: <4beeef07-6cdc-4f34-8ed1-5ba31c36f04c@mailbox.org>
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


--gdteez7kcn3vgmsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 09:53:53PM +0200, Marek Vasut wrote:
> On 10/9/23 18:46, Paul Barker wrote:
> > Extend the existing driver to support the SCIF serial ports on the
> > Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
> > relevant reset signal is de-asserted before we try to talk to the SCIF
> > module.
> >=20
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> >    * Moved handle_error() changes out to a separate patch earlier in the
> >      series.
> >    * Unconditionally de-assert the module reset during probe.
> >=20
> >   arch/arm/mach-rmobile/Kconfig |  1 +
> >   drivers/serial/serial_sh.c    | 17 +++++++++++++++++
> >   drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
> >   3 files changed, 36 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kcon=
fig
> > index c30ff2caad17..c421181c89cf 100644
> > --- a/arch/arm/mach-rmobile/Kconfig
> > +++ b/arch/arm/mach-rmobile/Kconfig
> > @@ -77,6 +77,7 @@ config RZG2L
> >   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
> >   	imply PINCTRL_RZG2L
> >   	imply RENESAS_SDHI
> > +	imply SCIF_CONSOLE
> >   	imply SYS_MALLOC_F
> >   	help
> >   	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
> > diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> > index 2b650d458e71..6ea8da34d434 100644
> > --- a/drivers/serial/serial_sh.c
> > +++ b/drivers/serial/serial_sh.c
> > @@ -17,6 +17,8 @@
> >   #include <linux/compiler.h>
> >   #include <dm/platform_data/serial_sh.h>
> >   #include <linux/delay.h>
> > +#include <dm/device_compat.h>
> > +#include <reset.h>
>=20
> Please keep the list sorted.

The existing include list isn't sorted, so in v3 I'll add a patch to
sort the list first. Then these two can be added in the right places.

Thanks,
Paul

--gdteez7kcn3vgmsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZSwofAAKCRDbaV4Vf/JG
vUfsAQDlOhMa8+0MQuFu7q8vC7d/PHSPHL/Gr92DgbWcqOMSWQD+MbOfwjDcRoD5
wrOfXZlphzd7aDG2/tuNRey/s4oJvgc=
=4cjb
-----END PGP SIGNATURE-----

--gdteez7kcn3vgmsq--
