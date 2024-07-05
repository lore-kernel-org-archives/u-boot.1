Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257BCC30653
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 01:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF5588476;
	Fri,  5 Jul 2024 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dsYk/gqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D0F88476; Fri,  5 Jul 2024 03:05:57 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729E58896F
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 03:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6b3so451345a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720141555; x=1720746355; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx4AlxGpfYDBfw0h4wnPOZSHOEXBp8nErt1z3vf7A4w=;
 b=dsYk/gqrDOYdwJoSgvPi7NIXKp8ThSwwyybGQJLrp68+HbTZALv6N5C6vQgmDiSILV
 zd17We4F/QOR0wDYMuXf/Z0eUB+6smAC1msxSDHZFRSu0d2z1bxpnO0NrfrJNRGRSzlc
 RiJiOah4fS0cc3MLs6nbdImqLIvW1VgPN1O0QjRmuJPmhUCOyA7pkJAmxT1V5ZztmBF2
 mXJ1fpkdY4mvJwNviXlQtBI65fpV8ieShwZIhFbhpF35ySoM7l6HIUtr5D4YeghoXgya
 EPlLv3qvhxp/sS6ydgPX0s1UpgpaB7GveqmlIsdHNlYrn8LeEgf+ECtZJ/DN5VZnQcjm
 x+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720141555; x=1720746355;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jx4AlxGpfYDBfw0h4wnPOZSHOEXBp8nErt1z3vf7A4w=;
 b=Q0TUzwzyvSJA7Cg6Qr0PgtLjipt0HNLswqCZJQaO63VogKCz4gE7rwUFIytv/AfiaV
 eASYF/olnQ0bLDOeahXRPOSRDMcJcB8RnMqi7WMnUSbRb5wIw5DgN1yDy5iwrrCX8v6/
 8t9UZ0nEvbxUQaC4LwLiJi0zHJWvGP4RZ16ulcqje16TYRGf20Q3/Q3aPkXqsYGINcC8
 9GSznACIz4tPPRHfdnyUQ7chSw678VvVolSU3Oxo1ELzhyQK1oqUWxK/rZnHKxk22uQe
 +hu2HfoU+USVjVKnQ/f2fJbPYLUAVDzz+nxXPTWGW5Xl6b8vZv40JOlngymMBSVYvK8n
 S5dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoTy75+/vYyuT2pjQ9mmtOn84KIpxabODSMLrbsiOhHpqBZZbo3ocv6iU78pL9yxOgiQcjpzp1v0mY1U60ctRkmyQAtg==
X-Gm-Message-State: AOJu0YzsH7aIEWSESNSf8ruoDMMvlpWXc4IxY44KJS95N2WzRa13INet
 0kYEgIaDOqKY0TXKBO5/xBLCCKOe77Ve1LVtPtvUV0UfK8gf13l0PcGp73DTSlvirI6L11UOKZB
 d9cqFzo870QozIfSIPpH1yPb/zlU=
X-Google-Smtp-Source: AGHT+IGJEM3t8C4/YpOB4ufZLiFXT0ewSQHzzWplPi6cBoM4PQ4KgQzFb4SpiO9Zohk983MfrV1V4L7xMto36FmvmXY=
X-Received: by 2002:a05:6402:13c8:b0:57d:4f47:d9f7 with SMTP id
 4fb4d7f45d1cf-58e56997566mr3086649a12.0.1720141554506; Thu, 04 Jul 2024
 18:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240615220654.10648-1-mibodhi@gmail.com>
 <Znvt9_7xbdccZkFd@orbyte.nwl.cc>
 <CAJaLiFyTWfmsAVT4NO_Nvq1eHC73dNhxmF7KtYCR4VwOUg8Z3w@mail.gmail.com>
 <CAJaLiFz0GW1-TWmZ_gGWGEri1vJH9uHtehr7fXmB36vPAV-0aQ@mail.gmail.com>
 <ZoaHKCfd0zB7gzFK@orbyte.nwl.cc>
In-Reply-To: <ZoaHKCfd0zB7gzFK@orbyte.nwl.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 4 Jul 2024 18:05:43 -0700
Message-ID: <CAJaLiFybGadjO8Xk5xwLBZUCE9eARV=ftkZR=UGjwRtEEojqrA@mail.gmail.com>
Subject: Re: [PATCH v2] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Phil,

On Thu, Jul 4, 2024 at 4:27=E2=80=AFAM Phil Sutter <phil@nwl.cc> wrote:
>
> Hi Tony,
>
> On Fri, Jun 28, 2024 at 03:44:01PM -0700, Tony Dinh wrote:
> > On Fri, Jun 28, 2024 at 3:04=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> w=
rote:
> > > On Wed, Jun 26, 2024 at 3:31=E2=80=AFAM Phil Sutter <phil@nwl.cc> wro=
te:
> > > > On Sat, Jun 15, 2024 at 03:06:54PM -0700, Tony Dinh wrote:
> > > > [...]
> > > > > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/=
ds414.c
> > > > > index abe6f9eb5e..f0b55fa095 100644
> > > > > --- a/board/Synology/ds414/ds414.c
> > > > > +++ b/board/Synology/ds414/ds414.c
> > > > > @@ -181,18 +181,9 @@ int board_init(void)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -int misc_init_r(void)
> > > > > +int board_late_init(void)
> > > > >  {
> > > > > -     if (!env_get("ethaddr")) {
> > > > > -             puts("Incomplete environment, populating from SPI f=
lash\n");
> > > > > -             do_syno_populate(0, NULL);
> > > > > -     }
> > > > > -     return 0;
> > > > > -}
> > > >
> > > > Could you please leave misc_init_r() in place (along with MISC_INIT=
_R in
> > > > defconfig)? A closer look at doc/README.enetaddr suggests that
> > > > implementing this board-specific function which acts if the environ=
ment
> > > > does not have ethaddr defined already is exactly the right thing to=
 do.
> > > > Also, it doesn't conflict with NET_RANDOM_ETHADDR: If do_syno_popul=
ate()
> > > > succeeds, no random MAC addresses are generated. If I manually remo=
ve
> > > > the call, random MACs come into play. So having this option enabled
> > > > serves as a fallback for boxes which lack the data in flash.
> > >
> > > Sure I will do that. I was mistaken in assuming that network random
> > > addresses were already generated before misc_init_r(). Thanks!
>
> It's nice that we may keep both so there's a fallback if data extraction
> from flash fails.
>
> > > > > -int checkboard(void)
> > > > > -{
> > > > > -     puts("Board: DS414\n");
> > > > > -
> > > > > +     /* Do late init to ensure successful enumeration of XHCI de=
vices */
> > > > > +     pci_init();
> > > > >       return 0;
> > > > >  }
> > > >
> > > > FWIW, booting from rear USB port worked fine for me!
> > >
> > > Cool! That was the main thing I was interested in for sending in this
> > > patch. One thing led to another... :)
>
> Which is a bit odd TBH: Scrolling through git history, I found commit
> c57f920504297 ("arm: mvebu: configs: ds414: Enable XHCI_PCI by default")
> in which I claimed the rear USB ports to be functional after enabling
> XHCI_PCI. Took me only three years to forget all the details. :(
>

Happens to me quite often, our old memories need to be filed away in
some brain cabinet  :)

... Perhaps the switch to Driver Model was when it started behaving
like it's not working, but actually not broken. The "pci init" is
needed to enumerate the XHCI controller first, before "usb start" can
work normally as before.

> > > > > diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> > > > > index ecf9501ba5..501ed51129 100644
> > > > > --- a/configs/ds414_defconfig
> > > > > +++ b/configs/ds414_defconfig
> > > > [...]
> > > > > @@ -25,44 +26,40 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> > > > >  CONFIG_SPL=3Dy
> > > > >  CONFIG_DEBUG_UART_BASE=3D0xf1012000
> > > > >  CONFIG_DEBUG_UART_CLOCK=3D250000000
> > > > > +CONFIG_IDENT_STRING=3D"\nSynology DS214+/DS414 2/4-Bay Diskstati=
on"
> > > > >  CONFIG_SYS_LOAD_ADDR=3D0x800000
> > > > >  CONFIG_PCI=3Dy
> > > > >  CONFIG_DEBUG_UART=3Dy
> > > > > +CONFIG_BOOTSTD_FULL=3Dy
> > > > >  CONFIG_BOOTDELAY=3D3
> > > > >  CONFIG_USE_BOOTARGS=3Dy
> > > > > -CONFIG_BOOTARGS=3D"console=3DttyS0,115200 ip=3Doff initrd=3D0x80=
00040,8M root=3D/dev/md0 rw syno_hw_version=3DDS414r1 ihd_num=3D4 netif_num=
=3D2 flash_size=3D8 SataLedSpecial=3D1 HddHotplug=3D1"
> > > > > -CONFIG_USE_BOOTCOMMAND=3Dy
> > > > > -CONFIG_BOOTCOMMAND=3D"sf probe; sf read ${loadaddr} 0xd0000 0x2d=
0000; sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramd=
isk_addr_r}"
> > > >
> > > > So these should not be necessary anymore with BOOTSTD. I wonder if =
it is
> > > > possible to provide a static bootmeth (or bootflow?) with low prior=
ity
> > > > which boots the legacy OS from flash. It could hold all the details
> > > > instead of the *_legacy env vars introduced below.
> > >
> > > I recall from bootstd documentation that it is possible to have a
> > > bootflow on flash. But it seems a bit too much for this patch. I thin=
k
> > > we'll have to repartition or find some space on the flash to store
> > > that bootflow script.
> > >
> >
> > Sorry I've misread your comment "it is possible to provide a static
> > bootmeth (or bootflow?) ". I think by "static bootflow" you must have
> > meant we would define it in the board code, and convince bootstd to
> > use it as the last boot method (without hunting for it on flash). I'm
> > not sure. Perhaps "global bootflow" is something that can be defined
> > and used here. I'll have to dig into bootstd documentation a bit more.
>
> Yes, that would be great. Booting legacy should be fairly simple by
> calling 'run bootcmd_legacy', though automatically falling back to it is
> even better.
>
> BTW: $bootcmd_legacy contains 'run bootargs_legacy' instruction. Are you
> sure this is going to work? Shouldn't this be 'setenv bootargs
> $bootargs_legacy' instead?

Yes, my bad. Should be 'setenv bootargs $bootargs_legacy'. Thanks!

> > > > A pending issue for me is inability to 'saveenv' - the flash seems
> > > > read-only in that spot. Does it work for you?
> > >
> > > Yes it does work for me. With the latest u-boot SPI flash driver, as =
I
> > > recall, the entire flash is automatically unprotected at
> > > initialization. But we need to be careful using saveenv running stock
> > > FW, because it could overwrite the rootfs on flash. It is common for
> > > Synology NAS that the envs location is at the same place as the stock
> > > rootfs. Since I don't care about stock FW, I saved the envs and used
> > > the location for u-boot envs in Linux /etc/fw_env.config. I'm not sur=
e
> > > if my DS214+ box can boot stock FW anymore :)
>
> The saveenv problem exists only with stock u-boot as Synology apparently
> didn't care to adjust CONFIG_ENV_OFFSET (or they failed). If I got that
> right, it should be set to 0x100000 and thus points into "zImage" area.

I think they did not care. Their u-boot only uses internal envs.

>
> Upstream we have ENV_OFFSET at 0x7E0000, i.e. the start of "RedBoot
> config" (which is unused by stock firmware).
>
> What's odd though, is that I fail to write to SPI flash using u-boot
> built from current HEAD. Trying legacy boot had failed with "Ramdisk
> image is corrupt or invalid" message, so I tried flashing a dump of
> rd.gz and ended with "flash area is locked" error message. Despite
> calling 'sf protect unlock ...' in beforehand. I wonder why you don't
> have these issues. What does 'sf probe' print on your box?

DS414> sf probe
SF: Detected n25q064 with page size 256 Bytes, erase size 4 KiB, total 8 Mi=
B

I have some stashed SPI flash patches that I need to look at again. I
vaguely recall that some SPI flash chips were not automatically
unlocked, even u-boot intention is to unlock all SPI flash like Linux
kernel has been doing.

>
> > > > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > > > >  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> > > > > -CONFIG_MISC_INIT_R=3Dy
> > > > > +CONFIG_BOARD_LATE_INIT=3Dy
> > > > >  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
> > > > >  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> > > > >  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > > > >  CONFIG_SPL_I2C=3Dy
> > > > > +CONFIG_SYS_PROMPT=3D"DS414> "
> > > >
> > > > Can we detect whether it is 414 or 214, BTW? bootargs_legacy contai=
ns
> > > > 414-specific info as well.
> > >
> > > It's a bit hard to do without creating another defconfig. AFAICT, the
> > > only difference between DS414 and DS214+ is the number of SATA bays.
> > > But currently u-boot SATA does not work for this box. U-Boot sata_mv
> > > driver is a subset of Linux sata_mv, and we don't have support for th=
e
> > > right PCIe SATA chip in u-boot sata_mv.
>
> Back in 2015, u-boot's sata_mv didn't have PCI support to begin with. I
> see you spent much more time with sata_mv than I did. What's missing to
> support the Marvell 88SX7042 in u-boot?

Linux sata_mv driver (123K code) has a chip type for 88SX7042 and
parameters associated with it. U-Boot sata_mv (29K code) does not have
any chip type specifically called out. Apparently, it was ported from
Linux too long ago.

I did not try very hard to get it working after I saw the difference,
though. I'll make another attempt when I have some free time.

>
> > > > [...]
> > > > > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > > > > index 9446acba79..89e55bf0d4 100644
> > > > > --- a/include/configs/ds414.h
> > > > > +++ b/include/configs/ds414.h
> > > > [...]
> > > > > @@ -16,14 +17,9 @@
> > > > >   * U-Boot into it.
> > > > >   */
> > > > >
> > > > > -/* I2C */
> > > > >  #define CFG_I2C_MVTWSI_BASE0         MVEBU_TWSI_BASE
> > > > >
> > > > > -/*
> > > > > - * mv-common.h should be defined after CMD configs since it used=
 them
> > > > > - * to enable certain macros
> > > > > - */
> > > > > -#include "mv-common.h"
> > > > > +#define PHY_ANEG_TIMEOUT     16000   /* PHY needs a longer aneg =
time */
> > > >
> > > > AIUI, this is a limitation of my local NIC, not the DS414 one. It j=
ust
> > > > took too long for link detection and autoneg when directly connecte=
d. A
> > > > switch should have helped. Or do you have more details?
> > >
> > > Ah! The typical PHY_ANEG_TIMEOUT on other Armada 38x boards is 8000. =
I
> > > thought the 16000 was for Armada XP when I saw that code. I think it'=
s
> > > OK to use a larger timeout. It really does not hurt?
>
> It does not - this change merely makes u-boot wait for longer until
> giving up waiting for link. My setup involves a direct link between the
> DS414 and a Realtek NIC, so it is rather surprising 16s timeout is
> sufficient. ;)
>
> Ah, one more thing: You mentioned mtdparts to define a flash map which
> should simplify flashing u-boot into the right spot. I haven't had any
> luck doing so for SPI flash, do you?

I used this definition for booting with modern distro only. U-boot
takes the 1st MB, and u-boot envs at 0x7E0000. So I can flash u-boot
and u-boot envs images in Linux.

mtdparts=3Dspi0.0:1m(u-boot),7040k(kernel),64k(u-boot-env),-(data)

All the best,
Tony

>
> Cheers, Phil
