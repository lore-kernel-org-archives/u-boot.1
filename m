Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0A6E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7766A86661;
	Mon,  9 Oct 2023 09:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA6E864CD; Mon,  9 Oct 2023 09:30:09 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 45F4B864CD
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 09:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,209,1694703600"; 
 d="asc'?scan'208";a="182404230"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 09 Oct 2023 16:30:01 +0900
Received: from unknown (unknown [10.226.92.156])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 9E8084006DC9;
 Mon,  9 Oct 2023 16:29:59 +0900 (JST)
Date: Mon, 9 Oct 2023 08:29:58 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Message-ID: <20231009072958.g3zpoyp7ih2c4hvm@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <20231004134308.oaeqeolblr4ex2l5@GBR-5CG2373LKG.adwin.renesas.com>
 <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
 <20231004163858.zeuxy64olun5iini@GBR-5CG2373LKG.adwin.renesas.com>
 <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>
 <6514beaa-6584-84de-883a-69933e0f54db@bp.renesas.com>
 <8e04236c-a262-41e3-b891-5b22afcbd86f@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2wezfiqihfetkbff"
Content-Disposition: inline
In-Reply-To: <8e04236c-a262-41e3-b891-5b22afcbd86f@mailbox.org>
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


--2wezfiqihfetkbff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 11:14:06PM +0200, Marek Vasut wrote:
> On 10/5/23 14:08, Paul Barker wrote:
> > The case we're interested in here is the Receive Error (ER) & Break
> > Detect (BRK) conditions. I've done some further datasheet digging...
> >=20
> > RZ/G2L datasheet says these are cleared by writing zero to the
> > appropriate bits of the FSR register.
> >=20
> > RZ/G2{H,M,N,E} datasheet says the same (pages 50-18 & 50-19 of
> > R01UH0808EJ0111 Rev.1.11).
> >=20
> > The R-Car Gen3 Hardware Manual says the same (pages 55-18 & 55-19 of
> > R19UH0105EJ0230 Rev.2.30).
> >=20
> > For R-Car S4, there is an Excel spreadsheet attached to page 105-5 of
> > the datasheet (R19UH0161EJ0100 Rev.1.00) which again says the same.
> >=20
> > For R-Car V4H, the relevant info is on pages 105-16 & 105-18 of the
> > datasheet (R19UH0172EJ0081 Rev.0.81) and says the same.
> >=20
> > On the RZ/G2L I was able to reproduce a break condition by changing
> > pinmux settings after the SCIF interface has been configured. You could
> > try this out on an R-Car system, but I don't think it's guaranteed to
> > cause a break condition, it may depend on how the port input is
> > implemented in those SoCs. From my reading, the only guaranteed way to
> > cause a break condition is to hold the Rx signal low, and you might need
> > to solder on some extra wires on to a board to be able to do that.
>=20
> Can't you simply send a BREAK from terminal program ?
> In minicom, I think that's meta-F B .
>=20
> > We should still fix the error handling here, even if the boards we have
> > don't easily cause Receive Errors or Break conditions, other folks may
> > have their own boards based on these SoCs.
> >=20
> > If you're happy I'll go ahead and check IS_ENABLED(CONFIG_RCAR_64) here
> > instead of IS_ENABLED(CONFIG_RZG2L).
>=20
> Based on the input I am getting from you here, it seems to me we should j=
ust
> use the G2L case as the common case for all systems, without any special
> casing, right ?

I assumed that the code that's in place here was correct for some older
SoC when it was added to u-boot. But I've just looked at the SH7751
datasheet this morning and guess what? It requires writing zeros to
clear the errors.

As long as SCIF_ERRORS is correctly defined for each SoC, then yes, it
looks like we can drop the conditional.

I'll include this in v2.

Thanks,
Paul

--2wezfiqihfetkbff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZSOr6AAKCRDbaV4Vf/JG
vY3kAP9l39OCb475sJ2tnEVgYFRfS5KUdkGsz1pL0CFUVQHyYgEAkYM35qk9+WrX
0aSboQ4ZJHzNnKOhdgoKzsOwiUY8pg8=
=wLVR
-----END PGP SIGNATURE-----

--2wezfiqihfetkbff--
