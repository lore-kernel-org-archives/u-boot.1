Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0744DCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2E780325;
	Tue, 16 Sep 2025 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6621803CC; Tue, 16 Sep 2025 16:09:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96DEF800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF17F12FC;
 Tue, 16 Sep 2025 07:09:10 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ECD33F673;
 Tue, 16 Sep 2025 07:09:18 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:09:15 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM
 initialisation
Message-ID: <20250916150915.0e81c311@donnerap>
In-Reply-To: <974306F8-B297-4DCD-A827-129651271935@gmail.com>
References: <20250914144411.157826-1-lukas.schmid@netcube.li>
 <20250915163637.38d05aab@donnerap>
 <974306F8-B297-4DCD-A827-129651271935@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Tue, 16 Sep 2025 15:35:42 +0200
Andr=C3=A1s Szemz=C5=91 <szemzo.andras@gmail.com> wrote:

Hi Andr=C3=A1s,

many thanks for the reply!

> > On 2025. Sep 15., at 17:36, Andre Przywara <andre.przywara@arm.com> wro=
te:
> >=20
> > On Sun, 14 Sep 2025 16:44:11 +0200
> > Lukas Schmid <lukas.schmid@netcube.li> wrote:
> >=20
> > Hi Lukas,
> >=20
> > thanks for the patch!
> >=20
> > CC:ing the sunxi list and Andr=C3=A1s, who I think has some T113-s4 dev=
ice as
> > well.
> >  =20
>=20
> Thanks, but unfortunately I don=E2=80=99t have a board with T113-S4.=20
> So awboot was not tested with this SoC, at least by me.

Ah, I see, thanks for the confirmation anyway!
I guess we will stick to the chip ID we have seen for now, and wait till
people complain.

Thanks,
Andre

> > It would be good to see some Tested-by: tags, but otherwise the patch
> > looks good, I'd say.
> >=20
> > Also I hear that awboot uses 0x6800 as the chip ID for the -s4, can
> > someone shed some light on this?
> >=20
> > Cheers,
> > Andre
> >  =20
> >> Extend the DRAM initialisation code to add support for the T113-S4 aka
> >> T113M4020DC0 by checking the SoC's CHIPID.
> >>=20
> >> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> >> ---
> >> drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> >> drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> >> 2 files changed, 19 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dr=
am_sun20i_d1.c
> >> index a1794032f3b..01d19d5feaa 100644
> >> --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> >> +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> >> @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *pa=
ra)
> >> clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> >> }
> >>=20
> >> +static u32 sid_read_soc_chipid(void)
> >> +{
> >> + return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> >> +}
> >> +
> >> static void dram_voltage_set(const dram_para_t *para)
> >> {
> >> int vol;
> >> @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_=
t *para,
> >>=20
> >> fuse =3D (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> >> debug("DDR efuse: 0x%x\n", fuse);
> >> + debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> >>=20
> >> if (para->dram_type =3D=3D SUNXI_DRAM_TYPE_DDR2) {
> >> if (fuse =3D=3D 15)
> >> @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para=
_t *para,
> >> switch (fuse) {
> >> case 8: cfg =3D ac_remapping_tables[2]; break;
> >> case 9: cfg =3D ac_remapping_tables[3]; break;
> >> - case 10: cfg =3D ac_remapping_tables[5]; break;
> >> + case 10:
> >> + if (sid_read_soc_chipid() =3D=3D SUNXI_CHIPID_T113M4020DC0)
> >> + cfg =3D ac_remapping_tables[0];
> >> + else
> >> + cfg =3D ac_remapping_tables[5];
> >> + break;
> >> case 11: cfg =3D ac_remapping_tables[4]; break;
> >> default:
> >> case 12: cfg =3D ac_remapping_tables[1]; break;
> >> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dr=
am_sun20i_d1.h
> >> index 91383f6cf10..7bd8f67a77a 100644
> >> --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> >> +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> >> @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> >> SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
> >> };
> >>=20
> >> +enum sunxi_soc_chipid {
> >> + SUNXI_CHIPID_F133A =3D 0x5C00,
> >> + SUNXI_CHIPID_D1S =3D 0x5E00,
> >> + SUNXI_CHIPID_T113S3 =3D 0x6000,
> >> + SUNXI_CHIPID_T113M4020DC0 =3D 0x7200,
> >> +};
> >> +
> >> /*
> >>  * This structure contains a mixture of fixed configuration settings,
> >>  * variables that are used at runtime to communicate settings between =
=20
> >  =20
>=20

