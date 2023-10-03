Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D554BE7543D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 09:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E5686E01;
	Tue,  3 Oct 2023 11:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6593886E01; Tue,  3 Oct 2023 11:48:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B296C86406
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 11:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74679C15;
 Tue,  3 Oct 2023 02:49:20 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367073F5A1;
 Tue,  3 Oct 2023 02:48:41 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:48:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de, Ondrej Jirman
 <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Message-ID: <20231003104838.3add39a2@donnerap.manchester.arm.com>
In-Reply-To: <4862495.31r3eYUQgx@jernej-laptop>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231001161336.31140-2-viraniac@gmail.com>
 <20231002122626.047b4043@donnerap.manchester.arm.com>
 <4862495.31r3eYUQgx@jernej-laptop>
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

On Mon, 02 Oct 2023 20:50:49 +0200
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne ponedeljek, 02. oktober 2023 ob 13:26:26 CEST je Andre Przywara napis=
al(a):
> > On Sun,  1 Oct 2023 21:43:32 +0530
> > Gunjan Gupta <viraniac@gmail.com> wrote:
> >=20
> > (fixing Jernej's email)=20
> >=20
> > Hi Gunjan,
> >=20
> > thanks for sending a patch!
> >   =20
> > > On some H6 boards like Orange Pi 3 LTS, some times U-Boot fails to de=
tect
> > > ram size correctly. Instead of 2GB thats available, it detects 4GB of=
 ram
> > > and then SPL just hangs there making board not to boot further.
> > >=20
> > > On debugging, I found that the rows value were being determined corre=
ctly,
> > > but columns were sometimes off by one value. I found that adding some
> > > delay after the mctl_core_init call along with making use of dsb in t=
he
> > > start of the mctl_mem_matches solves the issue.
> > >=20
> > > Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
> > > ---
> > >=20
> > >  arch/arm/mach-sunxi/dram_helpers.c   | 1 +
> > >  arch/arm/mach-sunxi/dram_sun50i_h6.c | 2 ++
> > >  2 files changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi=
/dram_helpers.c
> > > index cdf2750f1c..5758c58e07 100644
> > > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > > @@ -32,6 +32,7 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 =
val)
> > >  #ifndef CONFIG_MACH_SUNIV
> > >  bool mctl_mem_matches(u32 offset)
> > >  {
> > > +	dsb(); =20
> >=20
> > This looks a bit odd, do you have an explanation for that? And are you
> > sure that is really needed?
> > I understand why we need the DSB after the writel's below, but before t=
hat?
> > The only thing I could think of is that we are missing a barrier in
> > mctl_core_init() - which is the function called before mctl_mem_matches=
().
> > Can you move that dsb(); into mctl_auto_detect_dram_size(), right after
> > the mctl_core_init() call (where you add the udelay() below)? And I won=
der
> > if a dmb() would already be sufficient? I noticed recently that the
> > clr/setbit_le32() functions don't have a barrier at all, maybe that sho=
uld
> > be fixed instead? =20
>=20
> Looking at original BSP DRAM code, there is no data barriers that I can f=
ind.
> Cache shouldn't be a thing before DRAM is initialized, right?

With the *MMU off* every memory access is "device nGnRnE", so
definitely not cached. But a Cortex-A53 still has a store buffer which
is in effect even for device accesses.

> Conversely,
> I suggest adding memory barriers before each udelay(), as it is there for=
 a
> reason.

Talking to a colleague and looking at the ARM ARM and other
documentation, including [1]:
A DMB memory barrier (__iowmb() in U-Boot and Linux), as used in
readl/writel, just ensures ordering, it does not force completion.
For just programming the DRAM controller, this is what we want.
A DSB does everything that a DMB does, plus ensures "completion" of
memory accesses (plus other things like TLBs and CMOs, which we
don't care about in this case). In a Cortex-A53, this seems to include
flushing the store buffer, which is probably the culprit here.

So I don't know if the delays in the BSP DRAM driver are really
pauses that the DRAM controller needs. In this case we would need at
least a DSB before the udelay(), if not a device-read-back, though I
just assume that the DRAM controller registers do not have another
buffer on the hardware side. Check 27:47 onward of [1].

Another possibility is that the delays are just crude measures to paper
over missing barriers, hoping that the buffer is drained after the
time. But since the delays don't really hurt here, we should just assume
they are meaningful and keep them.

Also we pretty surely need a DSB after we setup the DRAM controller,
but before we use the DRAM array: the controller registers and the array
are separate devices, on different AXI buses. So that aspect of this patch
seems actually to be alright, and the fact that Gunjan needed the DSB
supports that.=20

I will try to come up with a patch that implements these ideas.

Cheers,
Andre

P.S. Please note that above statements are an application of the
architecture rules to the A53 and the MMU-off/single core situation in the
SPL. The situation is more complex when running Linux, especially on more
modern cores that do speculation and out-of-order execution.

[1] https://www.youtube.com/watch?v=3Di6DayghhA8Q

>=20
> >  =20
> > >  	/* Try to write different values to RAM at two addresses */
> > >  	writel(0, CFG_SYS_SDRAM_BASE);
> > >  	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
> > > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sun=
xi/dram_sun50i_h6.c
> > > index bff2e42513..a031a845f5 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> > > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dra=
m_para *para)
> > >  	para->cols =3D 11;
> > >  	mctl_core_init(para);
> > > =20
> > > +	udelay(50); =20
> >=20
> > The location of that udelay() looks a bit odd, any chance that belongs =
at
> > the end of mctl_channel_init() instead? And how did you come up with th=
at
> > and the value of 50? Just pure experimentation? I think the original BSP
> > DRAM code has plenty of delay calls, so we might have missed this one
> > here, but I would love to see some explanation here. =20
>=20
> I checked original driver and we have *almost* all delays. There are two
> missing. Both in mctl_phy_pir_init(). One before mctl_await_completion() =
and
> another after it. Both are 1 us long.
>=20
> Maybe that solves it (in combination with data barriers)?
>=20
> Best regards,
> Jernej
>=20
> >=20
> > Cheers,
> > Andre
> >  =20
> > >  	for (para->cols =3D 8; para->cols < 11; para->cols++) {
> > >  		/* 8 bits per byte and 16/32 bit width */
> > >  		if (mctl_mem_matches(1 << (para->cols + 1 + =20
> >=20
> >  =20
>=20
>=20
>=20
>=20

