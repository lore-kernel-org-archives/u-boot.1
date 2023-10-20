Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933AAC001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 23:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BD387536;
	Sat, 21 Oct 2023 01:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC54C87536; Sat, 21 Oct 2023 01:39:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8BADC87523
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 01:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1D9143D;
 Fri, 20 Oct 2023 16:40:25 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032AC3F64C;
 Fri, 20 Oct 2023 16:39:43 -0700 (PDT)
Date: Sat, 21 Oct 2023 00:38:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de, Ondrej Jirman
 <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
Message-ID: <20231021003839.1fcf08c8@slackpad.lan>
In-Reply-To: <4834802.GXAFRqVoOG@jernej-laptop>
References: <20231001161336.31140-1-viraniac@gmail.com>
 <20231002122626.047b4043@donnerap.manchester.arm.com>
 <CAJAzxbVw_TZ+eJ6uh63nCp5ggZR76k5bup49TkUtZV426M3R+Q@mail.gmail.com>
 <4834802.GXAFRqVoOG@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Mon, 02 Oct 2023 20:59:34 +0200
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> Dne ponedeljek, 02. oktober 2023 ob 14:42:40 CEST je Gunjan Gupta napisal=
(a):
> > > >  bool mctl_mem_matches(u32 offset)
> > > >  {
> > > > +     dsb(); =20
> > > This looks a bit odd, do you have an explanation for that? And are you
> > > sure that is really needed?
> > > I understand why we need the DSB after the writel's below, but before=
 that? =20
> >=20
> > I started with Ondrej Jirman's patch from LibreELEC's tree that had a
> > dsb call added
> > after the first writel call. That reduced the frequency of the errors
> > but didn't removed
> > it completely. My reason for moving it before the writel was to make
> > sure any memory
> > access is completed before starting the actual logic for the test.
> > That reduced the
> > frequency even further, but didn't resolve the issue. I did try
> > removing it leaving only
> > udelay added to the code, but that brings back the issue.
> >  =20
> > > The only thing I could think of is that we are missing a barrier in
> > > mctl_core_init() - which is the function called before mctl_mem_match=
es().
> > > Can you move that dsb(); into mctl_auto_detect_dram_size(), right aft=
er
> > > the mctl_core_init() call (where you add the udelay() below)? And I w=
onder
> > > if a dmb() would already be sufficient? =20
> >=20
> > Sure, I will try experimenting with it.
> >  =20
> > > I noticed recently that the clr/setbit_le32() functions don't have a =
barrier at all, maybe
> > > that should be fixed instead? =20
> >=20
> > I haven't done much of the low level programming myself. Mostly have
> > done user space
> > programming along with fixing minor kernel module compilation issues
> > due to kernel api
> > changes. So I wasn't sure what all places to debug. But if you point
> > me to places with
> > things to try, I surely can give time playing around testing the propos=
ed fixes.
> >  =20
> > > > @@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct d=
ram_para *para)
> > > >       para->cols =3D 11;
> > > >       mctl_core_init(para);
> > > >
> > > > +     udelay(50); =20
> > > The location of that udelay() looks a bit odd, any chance that belong=
s at
> > > the end of mctl_channel_init() instead? And how did you come up with =
that
> > > and the value of 50? Just pure experimentation? =20
> >=20
> > Before adding the udelay, I added 7 print statements to print all the
> > members of the para
> > struct. That itself solved the issue along with the dsb added to the
> > top of the mctl_mem_matches
> > function. This is what gave me the clue that a delay is needed there.
> > The value of 50 is
> > indeed from pure experimentation =20
>=20
> Oh, I found one major difference between BSP and mainline driver. Please =
test
> patch attached below. I don't know if this path is always taken when wrong
> configuration is tested or not.
>
> Best regards,
> Jernej
>=20
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -420,6 +420,7 @@ static bool mctl_channel_init(struct dram_para *para)
>                         (struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
>         struct sunxi_mctl_phy_reg * const mctl_phy =3D
>                         (struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
> +       bool ret =3D true;
>         int i;
>         u32 val;
> =20
> @@ -537,7 +538,7 @@ static bool mctl_channel_init(struct dram_para *para)
>                         debug("DRAM PHY DX%dRSR0 =3D %x\n", i, readl(&mct=
l_phy->dx[i].rsr[0]));
>                 debug("Error while initializing DRAM PHY!\n");

So those error messages (and the ones before them, not shown here) look
odd: if I follow the code correctly, this here is the only place which
makes mctl_core_init() return false. And we rely on it doing so up to
three times, to detect the proper rank and bus width, in
mctl_auto_detect_rank_width(). So we should not have dramatic error
messages (even for debug), as they would occur during normal, eventually
successful setup as well.
So shall we tone those messages down? I'd suggest to change the
"Oops!..." comment into something saying that we detected a wrong
rank/bus-width setup. Also removing the pointless PLL debug print
(since the failure is not DRAM clock related), and also the final error
message (the last line shown here). I will make patch for that.

But regardless I doubt that this patch is doing anything: when this
function returns false, we set new rank/width parameters, and call
mctl_core_init() again, which starts with mctl_sys_init() resetting all
DRAM controller registers, which I actually wonder is really necessary.
But surely any register setup after that point above is useless, with
the current code.

Does that make sense?

Cheers,
Andre

> -               return false;
> +               ret =3D false;
>         }
> =20
>         if (sunxi_dram_is_lpddr(para->type))
> @@ -553,7 +554,7 @@ static bool mctl_channel_init(struct dram_para *para)
>         writel(0x7ff, &mctl_com->maer1);
>         writel(0xffff, &mctl_com->maer2);
> =20
> -       return true;
> +       return ret;
>  }
> =20
>  static void mctl_auto_detect_rank_width(struct dram_para *para)
