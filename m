Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A9FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 09:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6F986D04;
	Thu, 12 Oct 2023 11:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2776086D1F; Thu, 12 Oct 2023 11:12:00 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 471F986CC9
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 11:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,218,1694703600"; 
 d="asc'?scan'208";a="182820789"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2023 18:11:49 +0900
Received: from unknown (unknown [10.226.93.100])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id 7A7D441CF031;
 Thu, 12 Oct 2023 18:11:47 +0900 (JST)
Date: Thu, 12 Oct 2023 10:11:46 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PATCH v2 11/19] serial: sh: Fix error handling
Message-ID: <20231012091146.qjlplxxhcz2ti3lm@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
 <TYCPR01MB1126966A9B8444133495FB75186CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kajvw7ijqtpabw7c"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1126966A9B8444133495FB75186CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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


--kajvw7ijqtpabw7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 07:08:42AM +0000, Biju Das wrote:
> Hi Paul,
>=20
> Thanks for the patch.
>=20
> > Subject: [PATCH v2 11/19] serial: sh: Fix error handling
> >=20
> > The current SCIF error handling is broken for the RZ/G2L. After a break
> > condition has been triggered, the current code is unable to clear the e=
rror
> > and serial port output never resumes.
> >=20
> > The RZ/G2L datasheet says that most error conditions are cleared by
> > resetting the relevant error bits in the FSR & LSR registers to zero.
> > To clear framing errors, the invalid data also needs to be read out of =
the
> > receive FIFO.
> >=20
> > After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3 a=
nd
> > even SH7751 SoCs, it's clear that this is the way to clear errors for a=
ll
> > of these SoCs.
> >=20
> > While we're here, annotate the handle_error() function with a couple of
> > comments as the reads and writes themselves don't immediately make it c=
lear
> > what we're doing.
> >=20
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > ---
> > v1->v2:
> >   * New patch after discussion with Marek & further investigation.
> >=20
> > I'm not going to put a `Fixes` tag on this, the error handling has been
> > writing ones to clear errors since at least 2007 so maybe it was origin=
ally
> > right for some board. It doesn't seem to apply to any of the current us=
ers
> > of the SCIF driver though.
> >=20
> >  drivers/serial/serial_sh.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c in=
dex
> > 5e543dbf3d58..2b650d458e71 100644
> > --- a/drivers/serial/serial_sh.c
> > +++ b/drivers/serial/serial_sh.c
> > @@ -79,10 +79,22 @@ sh_serial_setbrg_generic(struct uart_port *port, int
> > clk, int baudrate)
> >=20
> >  static void handle_error(struct uart_port *port)  {
> > -	sci_in(port, SCxSR);
> > -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
> > +	/*
> > +	 * Most errors are cleared by resetting the relevant error bits to
> > zero
> > +	 * in the FSR & LSR registers. For each register, a read followed by
> > a
> > +	 * write is needed according to the relevant datasheets.
> > +	 */
> > +	unsigned short status =3D sci_in(port, SCxSR);
> > +	sci_out(port, SCxSR, status & ~SCIF_ERRORS);
> >  	sci_in(port, SCLSR);
> >  	sci_out(port, SCLSR, 0x00);
> > +
> > +	/*
> > +	 * To clear framing errors, we also need to read and discard a
> > +	 * character.
> > +	 */
> > +	if (status & SCIF_FER)
> > +		sci_in(port, SCxRDR);
>=20
> Do we need to read status again to make sure framing error
> is cleared?

I've not seen anything to suggest that we need to do that and this
implementation is clearing the framing errors successfully.

Thanks,
Paul

--kajvw7ijqtpabw7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZSe4QAAKCRDbaV4Vf/JG
vXuoAP9PFDPVQtj1rH5Rie1CcjJmVSEdjaJZQQ/d1DVB1OqkIQD+Pit4+K3VHgVV
GrEb3gRSWFL/m6T/KhnJiCtfrBTr3gI=
=ePCG
-----END PGP SIGNATURE-----

--kajvw7ijqtpabw7c--
