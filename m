Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE61E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E558750F;
	Wed,  4 Oct 2023 18:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09F887493; Wed,  4 Oct 2023 18:39:17 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 64D0F8750F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181923170"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 05 Oct 2023 01:39:02 +0900
Received: from unknown (unknown [10.226.92.49])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 10E39400C441;
 Thu,  5 Oct 2023 01:38:59 +0900 (JST)
Date: Wed, 4 Oct 2023 17:38:58 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Message-ID: <20231004163858.zeuxy64olun5iini@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <20231004134308.oaeqeolblr4ex2l5@GBR-5CG2373LKG.adwin.renesas.com>
 <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nl7dtuh4ul4q3oj6"
Content-Disposition: inline
In-Reply-To: <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
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


--nl7dtuh4ul4q3oj6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 05:17:55PM +0200, Marek Vasut wrote:
> On 10/4/23 15:43, Paul Barker wrote:
> > On Wed, Oct 04, 2023 at 02:26:49PM +0200, Marek Vasut wrote:
> > > On 10/4/23 10:48, Paul Barker wrote:
> > > > On 03/10/2023 14:23, Marek Vasut wrote:
> > > > > On 9/20/23 14:42, Paul Barker wrote:
> > > > > > Extend the existing driver to support the SCIF serial ports on =
the
> > > > > > Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure=
 that the
> > > > > > relevant reset signal is de-asserted before we try to talk to t=
he SCIF
> > > > > > module.
> > > > > >=20
> > > > > > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > > > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas=
=2Ecom>
> > > > > > ---
> > > > > >     arch/arm/mach-rmobile/Kconfig |  1 +
> > > > > >     drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++=
++++++--
> > > > > >     drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
> > > > > >     3 files changed, 49 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmob=
ile/Kconfig
> > > > > > index 973e84fcf7ba..0ab22356aee5 100644
> > > > > > --- a/arch/arm/mach-rmobile/Kconfig
> > > > > > +++ b/arch/arm/mach-rmobile/Kconfig
> > > > > > @@ -77,6 +77,7 @@ config RZG2L
> > > > > >     	imply RENESAS_SDHI
> > > > > >     	imply CLK_RZG2L
> > > > > >     	imply PINCTRL_RZG2L
> > > > > > +	imply SCIF_CONSOLE
> > > > > >     	help
> > > > > >     	  Enable support for the Renesas RZ/G2L family of SoCs, in=
cluding the
> > > > > >     	  the RZ/G2L itself (based on the R9A07G044 SoC).
> > > > > > diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial=
_sh.c
> > > > > > index 5e543dbf3d58..a2e9a57137a6 100644
> > > > > > --- a/drivers/serial/serial_sh.c
> > > > > > +++ b/drivers/serial/serial_sh.c
> > > > > > @@ -17,6 +17,8 @@
> > > > > >     #include <linux/compiler.h>
> > > > > >     #include <dm/platform_data/serial_sh.h>
> > > > > >     #include <linux/delay.h>
> > > > > > +#include <dm/device_compat.h>
> > > > > > +#include <reset.h>
> > > > > >     #include "serial_sh.h"
> > > > > >     DECLARE_GLOBAL_DATA_PTR;
> > > > > > @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *p=
ort, int clk, int baudrate)
> > > > > >     static void handle_error(struct uart_port *port)
> > > > > >     {
> > > > > > -	sci_in(port, SCxSR);
> > > > > > -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
> > > > > > +	/* The RZ/G2L datasheet says that error conditions are cleare=
d by
> > > > > > +	 * resetting the error bits in the FSR register to zero.
> > > > >=20
> > > > > Can you be more specific here ?
> > > > >=20
> > > > > It doesn't seem Linux sh-sci.c driver does anything special for G=
2L, so
> > > > > is this special case really needed ?
> > > >=20
> > > > On page 1268 of the datasheet (R01UH0914EJ0130 Rev.1.30):
> > > >=20
> > > > "DR is cleared to 0 when DR =3D 1 is read and then 0 is written to =
the DR
> > > > flag."
> > > >=20
> > > > On page 1270:
> > > >=20
> > > > "[Clearing condition]
> > > > =E2=97=8F When 0 is written to ER after it has been read as 1"
> > > >=20
> > > > So zeros must be written to clear these errors, not ones.
> > > >=20
> > > > We have an open task to investigate the issue in the Linux driver a=
nd
> > > > fix it.
> > >=20
> > > Is the G2L UART broken in Linux ?
> >=20
> > Likely yes, but we need to reproduce the issue.
> >=20
> > > Does it misbehave in U-Boot ?
> >=20
> > Yes, before I changed this, if a framing error occurred it could never
> > be cleared and the serial port stopped sending/receiving data.
> >=20
> > The framing error was triggered by accident by unnecessarily re-doing
> > pinmuxing for the serial port after TrustedFirmware had already set it
> > up correctly. Since SCIF0 is wired to an FTDI USB/serial adaptor chip on
> > the SMARC carrier board, it seems very difficult to trigger a framing
> > error in any other way, the FTDI chip is too well behaved.
>=20
> Is it possible to trigger this on RZ/G2<non-L> with SCIF on those platfor=
ms
> as well ?

It's not been seen or reported to my knowledge, but it's on our list to
look into further.

Thanks,
Paul

--nl7dtuh4ul4q3oj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR2VEwAKCRDbaV4Vf/JG
veUBAP0QqAu/oUIhqeKQOzy2dJsMc8nGoUp4I5lbKygdW60MlQD2MsDd9jlgOhXH
nfWDdZCbZtJ6yN1CxYkBbZdaD8oHBw==
=ftDo
-----END PGP SIGNATURE-----

--nl7dtuh4ul4q3oj6--
