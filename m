Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255AF364BA
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 21:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F8683DC9;
	Thu,  9 Apr 2026 23:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mnEytYdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF05684099; Thu,  9 Apr 2026 23:34:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D2B4983CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 23:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D26A1D15;
 Thu,  9 Apr 2026 14:34:29 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A09FB3FAF5;
 Thu,  9 Apr 2026 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775770474; bh=fNeQFRf73ClgeLffX+lgCZaD4sRPukBTpr67hbUdRqo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mnEytYdVmFYrXDWObJ6RfUj131coLVZphkcohV/fqb0ItHZGye8zcie9eal2ujdRC
 trCCaW2jS1YJN/ETzavy7BAAveA5W1b5r/oZPAOhzAIAT9j/Uo0Mb+Z9cCfu/HUFHJ
 qk4hXT/GNpq++k2Q/o6XtheyzZUAc4W7Ny+DAvQw=
Date: Thu, 9 Apr 2026 23:34:16 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Philippe Simons
 <simons.philippe@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Tom
 Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Kory
 Maincent (TI.com)" <kory.maincent@bootlin.com>, Cody Eksal
 <masterr3c0rd@epochal.quest>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] sunxi: H616: dram: fix LPDDR3 TRP6 parsing
Message-ID: <20260409233304.2eeaa3fc@ryzen.lan>
In-Reply-To: <adfBW5aKiDm6TRzZ@shepard>
References: <20260407164717.7356-1-simons.philippe@gmail.com>
 <f78d23da-0e61-4a06-ae48-22cadd7ac24d@gmail.com>
 <adfBW5aKiDm6TRzZ@shepard>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Apr 2026 17:10:19 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

Hi Paul, Mikhail,

thanks for the reply!

> Hi,
>=20
> On Thu 09 Apr 26, 13:48, Mikhail Kalashnikov wrote:
> > On 4/8/26 00:47, Philippe Simons wrote: =20
> > > From: Jernej Skrabec <jernej.skrabec@gmail.com>
> > >=20
> > > Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
> > > some "Vref" parameter, to encode the values for *all* four supported =
DRAM
> > > types. The code selects one byte based on the DRAM type used at runti=
me.
> > > To allow copying DRAM parameters from vendor firmware, we used this v=
alue
> > > and its encoding, but wrongly: the proper order of bytes is DDR3, DDR=
4,
> > > LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.
> > >=20
> > > Correct the masking for LPDDR3 to fix DRAM operation on some boards
> > > using this DRAM type.
> > >=20
> > > With LPDDR3 TRP6 parsing fixed, adapt default DRAM_SUNXI_TPR6 value.
> > > Also change LPDDR4 default value to 0x38 used by A523 boards.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > [adjusted commit message, update default value]
> > > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> > > ---
> > >   arch/arm/mach-sunxi/Kconfig            | 2 +-
> > >   arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > > index e979ee4a2cc..a1ddc6a1fc8 100644
> > > --- a/arch/arm/mach-sunxi/Kconfig
> > > +++ b/arch/arm/mach-sunxi/Kconfig
> > > @@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
> > >   config DRAM_SUNXI_TPR6
> > >   	hex "DRAM TPR6 parameter"
> > > -	default 0x3300c080
> > > +	default 0x38c00080 =20
> > I don't think this will be a good solution. The changes in this series
> > were originally made to improve compatibility with the vendor driver,
> > but now you are introducing an additional inconsistency by closing the
> > previous one. The default values are not just arbitrary values =E2=80=
=94 they
> > are part of the vendor code that was obtained through binary analysis.
> > https://lore.kernel.org/all/20231018172109.085cce24@donnerap.manchester=
.arm.com/
>
> I tend to agree with you, it feels like the default value was taken from =
the
> reference code while the field parsing was just an issue that was introdu=
ced
> with the h616 code. So it should not affect the defaut value, which was l=
ikely
> mistakenly parsed before.

Yes, that Tanix TX1 uses a wrong value because of this, but that's
about the only effect, I'd say.

It seems like at this point the "default" value is just a convenience
value we introduced to avoid naming the same repeated TPR6 value in
every defconfig, as per my email. But it's a pure mainline U-Boot
technicality at this point, and we could easily just provide an
explicit value in each defconfig. I came up with this table, for the
currently mainline supported boards:

board name		SoC	TPR6 value	type	Vref value
------------------------------------------------------------------
liontron-h-a133l	A133	0x48000000	LPDDR4  48xxxxxx
anbernic_rg35xx_h700	H616	0x40808080      LPDDR4  40xxxxxx
orangepi_zero2		H616	0x3300c080 d	DDR3    xxxxxx80
orangepi_zero2w		H616	0x48808080	LPDDR4  48xxxxxx
orangepi_zero3		H616	0x44000000	LPDDR4  44xxxxxx
tanix_tx1		H616	0x2fb08080	LPDDR3  xxb0xxxx
transpeed-8k618-t	H616	0x3300c080 d	DDR3    xxxxxx80
x96_mate		H616	0x3300c080 d	DDR3    xxxxxx80
x96q			H616	0x3300c080 d	DDR3    xxxxxx80
yuzukihd-chameleon	H616	0x33808080	DDR3    xxxxxx80
avaota-a1		A523	0x38000000	LPDDR4  38xxxxxx
orangepi_4a		A523	0x38000000	LPDDR4  38xxxxxx
radxa-cubie-a5e		A523	0x38000000	LPDDR4  38xxxxxx
x96q_pro_plus		A523	0x3380807e	DDR3    xxxxxx7e

So the default value is just used for the old H616 DDR3 boards, where
only the LSB matters.

So what about dropping the default completely, since now it spans three
SoCs already, and finding some reasonable default for all of them will
become more complicated?

And maybe you can confirm: this should not affect compatibility with
vendor parameters at all, I think they always contain an explicit TPR6
value, and "no TPR6 value provided" is not a thing?

> > There are several options here:
> > 1. If our goal is to improve compatibility, then we should not change
> > the default values for LPDDR4, and only keep the changes for LPDDR3.

Fair, I don't really care about the MSB, the new value I suggested
seemed just like the most common value (see the table above). But it's
pointless, since those boards provide an explicit value, and don't use
the default.

> > 2. Add the changes from option 2, and additionally introduce the default
> > values for the A523 platform that I made during the initial binary
> > analysis but for some reason did not get merged into mainline.
> > (https://github.com/iuncuim/u-boot/blob/b17c5c8911a4fce328b01e6332632a9=
ccd88ebc6/arch/arm/mach-sunxi/Kconfig#L102)

Sorry, but this value doesn't seem right: The LPDDR4 boards use 0x38,
not 0x33, and the DDR3 board uses 0x7e, not 0x80. I don't know about
other boards, but this value don't seem to help - and it's unneeded
anyway, as the A523 board already provide an explicit TPR6 - and new
boards could do as well.

> It would be good to have different defaults for different platforms yes.
> Note that the a133 code has some fallback with defaults when the extracted
> field in tpr6 is zero. Maybe they should be used as default value for a13=
3.
> We probably still need to keep these fallbacks in the code in case some
> board-specific tpr6 value does have zeroes and relies on this behavior.
>=20
> > 3. If we accept the incompatibility between the vendor driver and
> > the mainline driver, then this patch series is unnecessary because
> > they introduce additional inconsistency with the vendor driver. =20
>=20
> We definitely want to be able to take the dram parameter values straight =
from
> the BSP and put them directly into our Kconfig. Changing the order of fie=
lds
> would make porting new boards very painful so it should be avoided.

Yes, I agree, we should take the DRAM parameters values verbatim. But
as explained above, I think the Kconfig default is a different matter.
For simplicity, I'd say we drop it and add TPR6 values into the
affected defconfigs. Providing separate defaults for different SoC just
makes things more complicated - for no reason.

>=20
> > I think option two is the most correct, but option one is also suitable,
> > since the DRAM driver for the A523 only supports DDR3 and LPDDR4,
> > and the default values in this case are the same as for the H616
> > (A523 is 0x33808080, H616 is 0x33c00080). =20
>=20
> I suggest we keep the current default (without moving the lpddr3 bits) fo=
r h616
> and add new defaults in Kconfig for a523 and a133.
>=20
> > >   	help
> > >   	  TPR6 value from vendor DRAM settings.
> > > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-s=
unxi/dram_sun50i_h616.c
> > > index 3345c9b8e82..42a0550e015 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > @@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para =
*para,
> > >   		val =3D para->tpr6 & 0xff;
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_LPDDR3:
> > > -		val =3D para->tpr6 >> 8 & 0xff;
> > > +		val =3D para->tpr6 >> 16 & 0xff; =20
>=20
> This change is definitely necessary though.

Yes, absolutely.


Cheers,
Andre

>=20
> > >   		break;
> > >   	case SUNXI_DRAM_TYPE_LPDDR4:
> > >   		val =3D para->tpr6 >> 24 & 0xff; =20
>=20
> All the best,
>=20
> Paul
>=20

