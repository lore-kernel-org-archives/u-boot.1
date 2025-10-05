Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4ECCAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 16:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9478C809A5;
	Sun,  5 Oct 2025 18:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792B9831D6; Sun,  5 Oct 2025 18:30:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A9CD4808AF
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 18:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F099D1C14;
 Sun,  5 Oct 2025 09:30:18 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EB393F59E;
 Sun,  5 Oct 2025 09:30:26 -0700 (PDT)
Date: Sun, 5 Oct 2025 17:30:07 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Rudi Horn <dyn-git@rudi-horn.de>, u-boot@lists.denx.de, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] Fix detection of odd memory configurations on sunxi
Message-ID: <20251005173007.726271ac@minigeek.lan>
In-Reply-To: <10731113.nUPlyArG6x@jernej-laptop>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
 <20251005014021.4b1b035a@minigeek.lan>
 <13857032.uLZWGnKmhe@jernej-laptop>
 <10731113.nUPlyArG6x@jernej-laptop>
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

On Sun, 05 Oct 2025 08:38:32 +0200
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne nedelja, 5. oktober 2025 ob 08:10:27 Srednjeevropski poletni =C4=8Das=
 je Jernej =C5=A0krabec napisal(a):
> > Hi Andre!
> >=20
> > Dne nedelja, 5. oktober 2025 ob 02:40:21 Srednjeevropski poletni =C4=8D=
as je Andre Przywara napisal(a): =20
> > > On Mon, 11 Aug 2025 09:35:19 +0200
> > > Rudi Horn <dyn-git@rudi-horn.de> wrote:
> > >=20
> > > Hi Rudi,
> > >=20
> > > thanks for sending a patch to address this long-standing issue!
> > >=20
> > > But ... ;-)
> > >  =20
> > > > I encountered a bug where u-boot detects that my OrangePI zero 3 (w=
ith=20
> > > > 1.5GB) has 2GB and crashes. =20
> > >=20
> > > As Jernej already said, this is a known limitation: we simply don't
> > > support not-power-of-2 DRAM sizes at the moment.
> > >  =20
> > > > The orangepi u-boot source code contains an additional
> > > > modification in the `mctl_calc_size` which removes a quarter of the=
=20
> > > > memory the
> > > > calculated last address cannot be written to:
> > > >=20
> > > > https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/a=
rch/arm/mach-sunxi/dram_sun50i_h616.c#L1365-L1368
> > > >=20
> > > > I'm not entirely sure if there is some specific logic that applies =
to this
> > > > modifier, but it does fix the issue on my system. =20
> > >=20
> > > So can someone shed some light on how this is supposed to work? If I
> > > understand the code correctly, it checks for *aliasing* between the
> > > first and the last word of DRAM, which doesn't make much sense to me:=
 I
> > > would expect a simple write/verify to see if the last quarter of DRAM
> > > is for real, or to check for a known aliasing pattern with this "odd"
> > > setup (as in: last quarter is aliased to first or third quarter or
> > > something), but checking those two words for aliasing seems wrong. =20
> >=20
> > Hm... I've never tested this patch on HW, so you might have a point. St=
ill,
> > I think testing for aliasing makes sense. Just writing and reading might
> > not be enough due to possible caching (not necessarily in CPU). =20
>=20
> I see where the confusion comes from. Rudi tried to replicate OrangePi co=
de
> but inadvertently used function for aliasing check instead of write/verify
> as noticed by Andre.

Right, I found this as well shortly after hitting Send ...

> While probably using OrangePi approach [1] would work fine, I learned to

Well, their algorithm is rubbish. For a start, they don't save the
original value, so may corrupt some other location. But more
importantly they don't try to write something surely different.
We could read the value at said location, invert it, write it, and
then read it back, to verify we read the inverted value. Then we restore
the original value. That should be pretty safe and reliable, I think,
also easy to do, given that writing to non-existing DRAM cells doesn't
hang the bus or DRAM controller.

> distrust simple write/verify checks, especially when size is only 1 word.
> I would be still more confortable to use current aliasing check, which us=
es
> 16 words check.

Well, when we have something, we could of course do multiple rounds of
it, if that proves more reliable.

Cheers,
Andre

> Best regards,
> Jernej
>=20
> [1] https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arc=
h/arm/mach-sunxi/dram_helpers.c#L48-L63
>=20
> >=20
> > I should have some board with non-power-of-2 RAM size somewhere. I'll t=
ry
> > to find it and test this.
> >  =20
> > >=20
> > > And indeed the code also fires on a board with 512MB and 4GB, capping
> > > the memory there as well (resulting in 384 MB and 3GB, respectively).
> > > This is somewhat expected, as we never would expect aliasing between
> > > those two particular words, I'd say.
> > >=20
> > > So since I don't have a board with an "uneven" DRAM size, can you
> > > please test some ideas to detect this RAM setup?
> > > - Read the content of the first word to not exist (@1.5GB), then write
> > >   something else there, and see if you can read this back? Don't forg=
et
> > >   a write barrier (dsb();) when doing so.
> > > - Write some test pattern to some known good DRAM locations, like the
> > >   beginning of DRAM, @512MB, @1GB, and see if any of those values pop
> > >   up @1.5GB, to see if there is an aliasing pattern?
> > > - Can you post the exact label on that DRAM chip, so that we can see =
if
> > >   we find a datasheet? I'd be curious about the actual organisation of
> > >   the DRAM array.
> > >=20
> > > Jernej, do you happen to know how those DRAM chips are organised? Do
> > > they just feature a non-power-of-2 number of rows or columns? =20
> >=20
> > I don't know details how such chips are organized internally. However,
> > number of rows and columns was never power-of-2.
> >=20
> > Btw, I think I saw 3 GB DRAM boards too somewhere, but not sure where.
> > Quick search confirms that 24 Gb DRAM chips also exists, so I would lea=
ve
> > this check as general 3/4 size fixup, not limited to any capacity.
> >  =20
> > >=20
> > > Oh, and also this patch was heavily malformed - line breaks and spaces
> > > instead of tabs. Please try to fix this. Simplest is probably "git
> > > format-patch", then sending this via "git send-email". Your email
> > > server seems to be postfix, so you could just give the SMTP details a=
nd
> > > credentials to git.
> > >=20
> > > Cheers,
> > > Andre
> > >=20
> > >  =20
> > > >=20
> > > > I propose the following patch, but am open to any further suggestio=
ns.
> > > >=20
> > > > Thanks,
> > > > Rudi Horn
> > > >=20
> > > > Note: Submitted in my personal capacity and is not affiliated with =
my=20
> > > > employer.
> > > >=20
> > > >=20
> > > >  From 2199f3b28e5fc853ed1921586358c33f3f1502d3 Mon Sep 17 00:00:00 =
2001
> > > > From: Rudi Horn <dyn-git@rudi-horn.de>
> > > > Date: Mon, 11 Aug 2025 08:58:34 +0200
> > > > Subject: [PATCH] arch: arm: mach-sonxi: Fix detection of odd memory
> > > >   configurations
> > > >=20
> > > > Fix detection of odd memory configurations. Previously 1.5GB device=
s were
> > > > incorrectly detected as 2GB devices, causing u-boot to crash.
> > > >=20
> > > > Signed-off-by: Rudi Horn <dyn-git@rudi-horn.de>
> > > > ---
> > > >   arch/arm/include/asm/arch-sunxi/dram.h |  1 +
> > > >   arch/arm/mach-sunxi/dram_dw_helpers.c  | 10 +++++++++-
> > > >   arch/arm/mach-sunxi/dram_helpers.c     |  8 ++++++++
> > > >   3 files changed, 18 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/include/asm/arch-sunxi/dram.h=20
> > > > b/arch/arm/include/asm/arch-sunxi/dram.h
> > > > index 0eccb1e6c28..7580421ca77 100644
> > > > --- a/arch/arm/include/asm/arch-sunxi/dram.h
> > > > +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> > > > @@ -44,6 +44,7 @@
> > > >   unsigned long sunxi_dram_init(void);
> > > >   void mctl_await_completion(u32 *reg, u32 mask, u32 val);
> > > >   bool mctl_mem_matches(u32 offset);
> > > > +bool mctl_mem_matches_upto(u32 offset);
> > > >   bool mctl_mem_matches_base(u32 offset, ulong base);
> > > >=20
> > > >   #endif /* _SUNXI_DRAM_H */
> > > > diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c=20
> > > > b/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > > index 24767354935..5bcd2672465 100644
> > > > --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > > +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > > @@ -146,5 +146,13 @@ unsigned long mctl_calc_size(const struct=20
> > > > dram_config *config)
> > > >          u8 width =3D config->bus_full_width ? 4 : 2;
> > > >=20
> > > >          /* 8 banks */
> > > > -       return (1ULL << (config->cols + config->rows + 3)) * width =
*=20
> > > > config->ranks;
> > > > +       unsigned long size =3D (1ULL << (config->cols + config->row=
s + 3))=20
> > > > * width * config->ranks;
> > > > +
> > > > +       /* some memory configurations such as 1.5GB rely on this to=
=20
> > > > compute the correct size */
> > > > +       if (!mctl_mem_matches_upto(size)) {
> > > > +               size =3D (size * 3) / 4;
> > > > +               debug("capping memory at 0x%lx\n", size);
> > > > +       }
> > > > +
> > > > +  return size;
> > > >   }
> > > > diff --git a/arch/arm/mach-sunxi/dram_helpers.c=20
> > > > b/arch/arm/mach-sunxi/dram_helpers.c
> > > > index 83dbe4ca98f..68c75fa07a6 100644
> > > > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > > > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > > > @@ -61,4 +61,12 @@ bool mctl_mem_matches(u32 offset)
> > > >   {
> > > >          return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
> > > >   }
> > > > +
> > > > +/*
> > > > + * Test if memory at offset matches memory at end of DRAM
> > > > + */
> > > > +bool mctl_mem_matches_upto(u32 offset)
> > > > +{
> > > > +       return mctl_mem_matches_base(offset - sizeof(u32),=20
> > > > CFG_SYS_SDRAM_BASE);
> > > > +}
> > > >   #endif
> > > > --
> > > > 2.43.0
> > > >  =20
> > >=20
> > >  =20
> >=20
> >=20
> >=20
> >=20
> >  =20
>=20
>=20
>=20
>=20

