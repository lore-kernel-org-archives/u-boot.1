Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2332C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 20:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BB882CFA;
	Wed, 25 Jun 2025 22:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750883589;
	bh=rjVcPjNuSoJUCsyigkSlM5xbRWHncPWGVSGfN0VLTtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDbiTlUNZRSQL3HZkr9UETymplpOpgE3V4zBOc5CUVU0zV6HMB1+PPXmkHobc+ezM
	 yiEDLNcm51a6zonArSKoACLHr+VZ8zcH0tcZ7ENeTW8WLpW1YdJ3W+Ymvibgs+uwpf
	 /PZ+B3x8zWNTfDHnAoobfgLS0HuC4yXslLkXsnTEdJh5jkuQrXKWGUVPXvNu6A54eJ
	 IGsR6NSo2onVgllhhWklKr+yVzV8DkV3y3l46lsEPJD/hLvlZldu2BQV22DoSZfdGC
	 dS1qUAvBF8D8L4gscx1dV8PeUlvVVbPp+CR5SkZFfwtfk6DAcuRvKZBnzo5X+3a4Ly
	 2KQoguefDxVig==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CF182D21; Wed, 25 Jun 2025 22:33:07 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE96282C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 22:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NgSN+Bvb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 25C041039BD02; 
 Wed, 25 Jun 2025 22:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750883574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=rjVcPjNuSoJUCsyigkSlM5xbRWHncPWGVSGfN0VLTtY=;
 b=NgSN+BvbfDKMsH4UC2GR+A8FEpEEt6WxqkzoGdelr+Iip8vJybNRPXOX+G/74PUWyQkg2e
 FzvpetuKkHggDTYAZ3wYv2Z3Rj6/H3wmCUo0hd4k1ejRPmLqji7b23T4CAXnWr7JOH9QZ/
 9J5mV8Y+m1DNEzz69xd0R4xtXjVcpUC7mFVzpuKyJXFGvluxUMQ2qoaEptYxLJusQJ9YDU
 Nyc+K0/EHZeQAGJ/WUiin8SSOALXfUnn/tM0MWCNah8qy9xBLlz66ye3rptT2EKDK7m+fy
 0qHvCLZhW4CqBJ1Egjk4y2JrKWKfJuI3L0CmAUqz87Qqhv0EmcuReduSbZ6JnA==
Date: Wed, 25 Jun 2025 22:32:50 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625223250.43470703@wsk>
In-Reply-To: <20250625163742.GR4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
 <20250625141424.GN4003484@bill-the-cat>
 <20250625-stylishly-expiring-c37b5a0a52fb@spud>
 <20250625163742.GR4003484@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1YjI1c1BOJ.Olnx+a0AAdey";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/1YjI1c1BOJ.Olnx+a0AAdey
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Wed, Jun 25, 2025 at 05:28:56PM +0100, Conor Dooley wrote:
> > On Wed, Jun 25, 2025 at 08:14:24AM -0600, Tom Rini wrote: =20
> > > On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski wrote: =20
> > > > Hi Tom,
> > > >  =20
> > > > > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski
> > > > > wrote:=20
> > > > > > The commit e8a9521e649f
> > > > > > ("vf500/vf610: synchronise device trees with linux")
> > > > > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > > > > It turned out that in Linux's upstream iomuxc node
> > > > > > description the fsl,mux_mask' was missing, so the U-Boot's
> > > > > > pinctrl driver for NXP's Vybrid SoC was not working
> > > > > > properly.
> > > > > >=20
> > > > > > As by default the mux mask was set to 0, the vf610 based
> > > > > > boards (like BK4) were bricked, due to misconfiguration of
> > > > > > gpio at early boot stage.
> > > > > >=20
> > > > > > The fix for all vf610 based boards is to introduce
> > > > > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property
> > > > > > provided and include it in boards' specific U-Boot
> > > > > > adjustment files (like vf610-bk4r1-u-boot.dtsi).
> > > > > >=20
> > > > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > > > ---
> > > > > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > > > > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > > > > >  2 files changed, 11 insertions(+)
> > > > > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi   =20
> > > > >=20
> > > > > It looks like this is still missing upstream, so what's the
> > > > > status on that?  =20
> > > >=20
> > > > It looks like in Linux the mux_mask is hardcoded (for Vybrid
> > > > vf610):
> > > > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/f=
reescale/pinctrl-vf610.c#L321
> > > >=20
> > > > In u-boot other SoCs use it as well, but with different values:
> > > > - arch/arm/dts/imxrt1050.dtsi -> 0x7
> > > > - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
> > > >=20
> > > > In the imx8ulp case above - it is already set in *-u-boot.dtsi
> > > > specific file, so I've followed this approach. =20
> > >=20
> > > Someone should unify upstream to one approach or another I would
> > > think. Or find a good explanation as to why it's not unified, and
> > > then we should follow. =20
> >=20
> > If these values are per-SoC, which they appear to be given these
> > look like 3 different devices, I don't see a reason for these to be
> > accepted "upstream". =20
>=20
> OK, yes. But it should either be "hard code a thing" or "get the
> property" not maybe-one-maybe-the-other? That was what I was trying to
> make as my point.
>=20

Agreed.

Then some decision shall be made if:

1. We keep the fsl,mux-mask as *-u-boot.dtsi specific

2. Modify the pinctrl driver for Vybrid
(drivers/pinctrl/nxp/pinctrl-imx-mmio.c) and maybe add mux_mask field
to:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pinc=
trl-imx.h?ref_type=3Dheads#L26

3. Try to upstream (to Linux) the property. That would require rewriting
kernel pinctrl driver for vf610 to parse "fsl,mux_mask" property.

As Conor pointed out - the approach from 3. is not feasible.

Then we shall decide if 1. or 2. shall be implemented.

Approach from 1. doesn't require any driver's modification. Approach
from 2. would introduce the extra field and some code modification to:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pinc=
trl-imx.c?ref_type=3Dheads
and
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pinc=
trl-imx-mmio.c?ref_type=3Dheads

I would personally opt for 1.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/1YjI1c1BOJ.Olnx+a0AAdey
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhcXPIACgkQAR8vZIA0
zr3bcgf+NdDxI42cFNJNbQiu0E6cbYvmxwmfUvGIA+/xNhSmUlOdmMGxhR8u+e4X
rZBF4nNNvnnuevCxNuODROdW823fZ9rewIKVnL+F/pYLqsEG3mI6GgRtZ89o5Jc/
OIAb3W6ksbLJ1GbxBY+0CaXoDLBXtxvW9Q1DBuIk9wDHNXpnHXTRpUjjyZXhA8Ww
iX+Ee+ZcO/cbIofHE6mRGEzZTEi9NQzHZ21JM45pyNlat9V//Y34xMtbUYz2wyoV
OLBh3fmBSV7I+XPR+VE2hcPnocoLMU/XcDBzt6z8Usu5yKOln9npLwBsD2afavYk
R5AMkMz5OylRV/Ec5UrJ/bFpX0g5Wg==
=h+uf
-----END PGP SIGNATURE-----

--Sig_/1YjI1c1BOJ.Olnx+a0AAdey--
