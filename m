Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4AFC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E8C87C26;
	Wed, 31 Jan 2024 16:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D54587C38; Wed, 31 Jan 2024 16:07:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8C4EC87C13
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F66DDA7;
 Wed, 31 Jan 2024 07:07:59 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034AD3F762;
 Wed, 31 Jan 2024 07:07:14 -0800 (PST)
Date: Wed, 31 Jan 2024 15:07:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 1/1] sunxi: sun4i: Reduce cpu clock at SPL
 initialization to 144 MHz
Message-ID: <20240131150712.750a6907@donnerap.manchester.arm.com>
In-Reply-To: <b1aecf07-8bf5-41dc-3574-257c8e8ac9c6@ict42.de>
References: <20240131104943.196256-1-ludwig.kormann@ict42.de>
 <20240131123622.078f5629@donnerap.manchester.arm.com>
 <b1aecf07-8bf5-41dc-3574-257c8e8ac9c6@ict42.de>
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

On Wed, 31 Jan 2024 14:26:02 +0100
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi,

> thanks for your feedback!

thanks for the quick reply!

> Am 31.01.24 um 13:36 schrieb Andre Przywara:
> > On Wed, 31 Jan 2024 11:49:43 +0100
> > Ludwig Kormann <ludwig.kormann@ict42.de> wrote:
> >
> > Hi Ludwig,
> >
> > thanks for taking care and sending a patch, though I scratch my head ab=
out
> > this a bit. My main concern is why this would be an issue *now*, 11 yea=
rs
> > after the A20's release, and with tons of boards out there in operation.
> > Also 144 MHz seem a somewhat drastic reduction?
> > =20
> We began seeing this issue beginning in early 2023 and it seems to affect
> only a very small percentage of the units. We had to introduce this=20
> patch for
> our customers and wanted to also share it with the community.

Thanks for that, much appreciated.

> >> Up until now cpu clock gets initialized at 384 MHz, which is
> >> the highest supported cpu clock. =20
> > What do you mean with "highest supported"? Surely the A20 goes up to
> > 960 MHz? =20
> You're right, I must have mixed something up there.
>=20
> > Also please note that 384 MHz is the PLL1 reset configuration, so it's =
not
> > something we came up with, but probably some safe value that Allwinner
> > burned into their chips.
> > =20
> >> Recent A20 batches show an increased percentage of modules
> >> reacting very sensitive to operating conditions outside the
> >> specifications. =20
> > What are those specifications, exactly? Do you have any more reliable
> > data? The datasheet is very quiet on those conditions, it seems.
> > In particular, I couldn't find any official frequency/voltage
> > combinations, it seems like the values in the DTs are just passed on fr=
om
> > some BSP drop? =20
> Yes, it's hard/impossible to find any reliable information on this.
> Our main reference have been the values in the DTs.
>=20
> > =20
> >> The cpu dies very shortly after PLLs, core frequency or cpu
> >> voltage are missconfigured. E.g.:
> >> - uboot SPL selects 384 MHz as cpu clock which requires a cpu
> >>    voltage of at least 1.1 V.
> >> - Linux CPU Frequency scaling with most sun7i dts will reduce
> >>    cpu voltage down to 1.0 V. =20
> > How so? The mainline DT suggests 1.1V for anything above 312 MHz, and
> > even above 144 MHz for the BananaPi. Are you using any OPs that differ
> > from that?
> > =20
> >> - When intiating a reboot or reset from linux the cpu voltage
> >>    may keep the 1.0 V configuration and the cpu dies during SPL
> >>    initialization. =20
> > Ah, so you mean we run (in Linux) on a 1.0V OP, probably at a very low =
CPU
> > frequency, and then the CPU cores reset, leaving the PMIC at 1.0V? And
> > then the SPL programs 384 MHz, which is too high, even for the brief pe=
riod
> > until we program DCDC2 to 1.4V? =20
> Yes, the CPU dies before the voltage gets updated.
> > If you have evidence (those "newer batches"? A20 batches in 2024?) for
> > that, what about 312 MHz? Does that work? =20
> The batches are actually from 2022+. We went for 144MHz as it's the lowest
> of the "default" speeds, that also ensures we're "low enough" to (hopeful=
ly)
> never trigger the issue again.
> It seems like there's some variation in A20 production that triggers the=
=20
> issue
> and as we don't know any "official" voltage/frequency limits it's better=
=20
> to have
> some safety margin.
>=20
> > =20
> >> Therefore reduce cpu clock at uboot SPL initialization down
> >> to 144 MHz from 384 MHz. =20
> > I am bit concerned about slowing down the initial SPL phase that much, =
for
> > *all* A20 users. We run the DRAM init with that initial clock, even tho=
ugh
> > the voltage is already up at this point. =20
> In my opinion the impact / additional delay for the initial SPL phase=20
> should not
> be in a very relevant range actually, as it usually only takes a few=20
> hundred milliseconds.

Well, I heard in the past about users that care a lot about boot times,
and were looking for ways to shave of a few dozen milliseconds from the
boot. So a "few hundred ms" would probably upset them. And while I
personally don't really care about this range either, there are a lot of
A20 users out there, so I want to keep the disturbance as low as possible.

> But you're right of course, this would force the lower value onto all=20
> A20 users.
>=20
> >
> > So if you see issues with those "newer batches" only(?), and since I
> > haven't heard about any issues about that before, can we make this a
> > Kconfig choice? We could make it simple, forcing K to 1, so we just need
> > to divide the frequency by 24 and shift by 8 to get to the register val=
ue? =20
> I will try to look into this and provide an update.
> >> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
> >> ---
> >>   arch/arm/include/asm/arch-sunxi/clock_sun4i.h | 2 +-
> >>   arch/arm/mach-sunxi/clock_sun4i.c             | 2 ++
> >>   2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/=
include/asm/arch-sunxi/clock_sun4i.h
> >> index 2cec91cb20..252c4c693e 100644
> >> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> >> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> >> @@ -141,7 +141,7 @@ struct sunxi_ccm_reg {
> >>   #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
> >>   #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
> >>  =20
> >> -#define PLL1_CFG_DEFAULT	0xa1005000
> >> +#define PLL1_CFG_DEFAULT	0xa1004c01
> >>  =20
> >>   #if defined CONFIG_OLD_SUNXI_KERNEL_COMPAT && defined CONFIG_MACH_SU=
N5I
> >>   /*
> >> diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/c=
lock_sun4i.c
> >> index 8f1d1b65f0..ac3b7a801f 100644
> >> --- a/arch/arm/mach-sunxi/clock_sun4i.c
> >> +++ b/arch/arm/mach-sunxi/clock_sun4i.c
> >> @@ -25,6 +25,7 @@ void clock_init_safe(void)
> >>   	       APB0_DIV_1 << APB0_DIV_SHIFT |
> >>   	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
> >>   	       &ccm->cpu_ahb_apb0_cfg);
> >> +	sdelay(20); =20
> > Where does that come from? Can you mention that in the commit message? =
=20
>=20
> This delay is required after switching the clock source.
>=20
> See "A20 Reference manual v1.4" Page 50 / section "1.5.4.16.=20
> CPU/AHB/APB0 CLOCK RATIO(DEFAULT: 0X00010010)":
> "If the clock source is changed, at most to wait for 8 present running=20
> clock cycles."
>=20
> Also these delays are already correctly beeing used later on in the same=
=20
> file e.g. within clock_set_pll1(...) on line 153:

Ah, very good, thanks for digging that out. Can you make this a separate
patch, then? I am happy to merge this ASAP, and this wouldn't need to be
held up on this discussion here.

Cheers,
Andre.

> > =C2=A0=C2=A0 =C2=A0/* Switch to 24MHz clock while changing PLL1 */
> > =C2=A0=C2=A0 =C2=A0writel(AXI_DIV_1 << AXI_DIV_SHIFT |
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AHB_DIV_2 << AH=
B_DIV_SHIFT |
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 APB0_DIV_1 << A=
PB0_DIV_SHIFT |
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_CLK_SRC_OSC=
24M << CPU_CLK_SRC_SHIFT,
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ccm->cpu_ahb_a=
pb0_cfg);
> > =C2=A0=C2=A0 =C2=A0sdelay(20); =20
>=20
>=20
> kind regards
>=20
> Ludwig
>=20
> > Cheers,
> > Andre
> > =20
> >>   	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
> >>   	sdelay(200);
> >>   	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
> >> @@ -32,6 +33,7 @@ void clock_init_safe(void)
> >>   	       APB0_DIV_1 << APB0_DIV_SHIFT |
> >>   	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
> >>   	       &ccm->cpu_ahb_apb0_cfg);
> >> +	sdelay(20);
> >>   #ifdef CONFIG_MACH_SUN7I
> >>   	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
> >>   #endif =20
>=20

