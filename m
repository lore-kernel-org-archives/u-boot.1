Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB57C41513
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 11:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D0088476;
	Thu,  4 Jul 2024 13:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="TNvKJJgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FDFE88363; Thu,  4 Jul 2024 13:27:40 +0200 (CEST)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2282588476
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 13:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DiLazdoQZw4yzwkoshhntsfexF3AD6AdsudZG9Ug77I=; b=TNvKJJgqR5/RBMSqj6TpBDQazD
 UGsK2xnT32zcpk6L8FSEHMsLg9TyImd/J1T4lgqCSXkNmtaBelj4HlAvk+DFrZUforJl2Hh9Zy81z
 yJ2h3BSpG4NiXzM5pz2t74EvzbXDgpPtWGmS8F4sUAV86s0kyDVRHJgTTmA6GATMh6MTMRYQqRkSE
 x/G11gnqquWg3dyxrp/OK+345sdE2FnrRX5nqpPnRNZZxNQJddqLybOe81WqL6nRtCO7Eje7qzwMW
 dY2EZH2PFo/NkSGHIgLMXWnmkxwbPtL7dgMRmZvr5kPVFZi/D6HCY1ycDnshyvpIrJaY/ok9iqJuc
 KnSf/HiQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1sPKcj-000000007g4-0Bg9;
 Thu, 04 Jul 2024 13:27:37 +0200
Date: Thu, 4 Jul 2024 13:27:36 +0200
From: Phil Sutter <phil@nwl.cc>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: mvebu: Enable bootstd and other modernization
 for Synology DS414 (Armada XP) board
Message-ID: <ZoaHKCfd0zB7gzFK@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240615220654.10648-1-mibodhi@gmail.com>
 <Znvt9_7xbdccZkFd@orbyte.nwl.cc>
 <CAJaLiFyTWfmsAVT4NO_Nvq1eHC73dNhxmF7KtYCR4VwOUg8Z3w@mail.gmail.com>
 <CAJaLiFz0GW1-TWmZ_gGWGEri1vJH9uHtehr7fXmB36vPAV-0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaLiFz0GW1-TWmZ_gGWGEri1vJH9uHtehr7fXmB36vPAV-0aQ@mail.gmail.com>
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

Hi Tony,

On Fri, Jun 28, 2024 at 03:44:01PM -0700, Tony Dinh wrote:
> On Fri, Jun 28, 2024 at 3:04 PM Tony Dinh <mibodhi@gmail.com> wrote:
> > On Wed, Jun 26, 2024 at 3:31 AM Phil Sutter <phil@nwl.cc> wrote:
> > > On Sat, Jun 15, 2024 at 03:06:54PM -0700, Tony Dinh wrote:
> > > [...]
> > > > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> > > > index abe6f9eb5e..f0b55fa095 100644
> > > > --- a/board/Synology/ds414/ds414.c
> > > > +++ b/board/Synology/ds414/ds414.c
> > > > @@ -181,18 +181,9 @@ int board_init(void)
> > > >       return 0;
> > > >  }
> > > >
> > > > -int misc_init_r(void)
> > > > +int board_late_init(void)
> > > >  {
> > > > -     if (!env_get("ethaddr")) {
> > > > -             puts("Incomplete environment, populating from SPI flash\n");
> > > > -             do_syno_populate(0, NULL);
> > > > -     }
> > > > -     return 0;
> > > > -}
> > >
> > > Could you please leave misc_init_r() in place (along with MISC_INIT_R in
> > > defconfig)? A closer look at doc/README.enetaddr suggests that
> > > implementing this board-specific function which acts if the environment
> > > does not have ethaddr defined already is exactly the right thing to do.
> > > Also, it doesn't conflict with NET_RANDOM_ETHADDR: If do_syno_populate()
> > > succeeds, no random MAC addresses are generated. If I manually remove
> > > the call, random MACs come into play. So having this option enabled
> > > serves as a fallback for boxes which lack the data in flash.
> >
> > Sure I will do that. I was mistaken in assuming that network random
> > addresses were already generated before misc_init_r(). Thanks!

It's nice that we may keep both so there's a fallback if data extraction
from flash fails.

> > > > -int checkboard(void)
> > > > -{
> > > > -     puts("Board: DS414\n");
> > > > -
> > > > +     /* Do late init to ensure successful enumeration of XHCI devices */
> > > > +     pci_init();
> > > >       return 0;
> > > >  }
> > >
> > > FWIW, booting from rear USB port worked fine for me!
> >
> > Cool! That was the main thing I was interested in for sending in this
> > patch. One thing led to another... :)

Which is a bit odd TBH: Scrolling through git history, I found commit
c57f920504297 ("arm: mvebu: configs: ds414: Enable XHCI_PCI by default")
in which I claimed the rear USB ports to be functional after enabling
XHCI_PCI. Took me only three years to forget all the details. :(

> > > > diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> > > > index ecf9501ba5..501ed51129 100644
> > > > --- a/configs/ds414_defconfig
> > > > +++ b/configs/ds414_defconfig
> > > [...]
> > > > @@ -25,44 +26,40 @@ CONFIG_SPL_BSS_MAX_SIZE=0x4000
> > > >  CONFIG_SPL=y
> > > >  CONFIG_DEBUG_UART_BASE=0xf1012000
> > > >  CONFIG_DEBUG_UART_CLOCK=250000000
> > > > +CONFIG_IDENT_STRING="\nSynology DS214+/DS414 2/4-Bay Diskstation"
> > > >  CONFIG_SYS_LOAD_ADDR=0x800000
> > > >  CONFIG_PCI=y
> > > >  CONFIG_DEBUG_UART=y
> > > > +CONFIG_BOOTSTD_FULL=y
> > > >  CONFIG_BOOTDELAY=3
> > > >  CONFIG_USE_BOOTARGS=y
> > > > -CONFIG_BOOTARGS="console=ttyS0,115200 ip=off initrd=0x8000040,8M root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 flash_size=8 SataLedSpecial=1 HddHotplug=1"
> > > > -CONFIG_USE_BOOTCOMMAND=y
> > > > -CONFIG_BOOTCOMMAND="sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramdisk_addr_r}"
> > >
> > > So these should not be necessary anymore with BOOTSTD. I wonder if it is
> > > possible to provide a static bootmeth (or bootflow?) with low priority
> > > which boots the legacy OS from flash. It could hold all the details
> > > instead of the *_legacy env vars introduced below.
> >
> > I recall from bootstd documentation that it is possible to have a
> > bootflow on flash. But it seems a bit too much for this patch. I think
> > we'll have to repartition or find some space on the flash to store
> > that bootflow script.
> >
> 
> Sorry I've misread your comment "it is possible to provide a static
> bootmeth (or bootflow?) ". I think by "static bootflow" you must have
> meant we would define it in the board code, and convince bootstd to
> use it as the last boot method (without hunting for it on flash). I'm
> not sure. Perhaps "global bootflow" is something that can be defined
> and used here. I'll have to dig into bootstd documentation a bit more.

Yes, that would be great. Booting legacy should be fairly simple by
calling 'run bootcmd_legacy', though automatically falling back to it is
even better.

BTW: $bootcmd_legacy contains 'run bootargs_legacy' instruction. Are you
sure this is going to work? Shouldn't this be 'setenv bootargs
$bootargs_legacy' instead?

> > > A pending issue for me is inability to 'saveenv' - the flash seems
> > > read-only in that spot. Does it work for you?
> >
> > Yes it does work for me. With the latest u-boot SPI flash driver, as I
> > recall, the entire flash is automatically unprotected at
> > initialization. But we need to be careful using saveenv running stock
> > FW, because it could overwrite the rootfs on flash. It is common for
> > Synology NAS that the envs location is at the same place as the stock
> > rootfs. Since I don't care about stock FW, I saved the envs and used
> > the location for u-boot envs in Linux /etc/fw_env.config. I'm not sure
> > if my DS214+ box can boot stock FW anymore :)

The saveenv problem exists only with stock u-boot as Synology apparently
didn't care to adjust CONFIG_ENV_OFFSET (or they failed). If I got that
right, it should be set to 0x100000 and thus points into "zImage" area.

Upstream we have ENV_OFFSET at 0x7E0000, i.e. the start of "RedBoot
config" (which is unused by stock firmware).

What's odd though, is that I fail to write to SPI flash using u-boot
built from current HEAD. Trying legacy boot had failed with "Ramdisk
image is corrupt or invalid" message, so I tried flashing a dump of
rd.gz and ended with "flash area is locked" error message. Despite
calling 'sf protect unlock ...' in beforehand. I wonder why you don't
have these issues. What does 'sf probe' print on your box?

> > > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > > >  CONFIG_DISPLAY_BOARDINFO_LATE=y
> > > > -CONFIG_MISC_INIT_R=y
> > > > +CONFIG_BOARD_LATE_INIT=y
> > > >  CONFIG_SPL_MAX_SIZE=0x1bfd0
> > > >  CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> > > >  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > > >  CONFIG_SPL_I2C=y
> > > > +CONFIG_SYS_PROMPT="DS414> "
> > >
> > > Can we detect whether it is 414 or 214, BTW? bootargs_legacy contains
> > > 414-specific info as well.
> >
> > It's a bit hard to do without creating another defconfig. AFAICT, the
> > only difference between DS414 and DS214+ is the number of SATA bays.
> > But currently u-boot SATA does not work for this box. U-Boot sata_mv
> > driver is a subset of Linux sata_mv, and we don't have support for the
> > right PCIe SATA chip in u-boot sata_mv.

Back in 2015, u-boot's sata_mv didn't have PCI support to begin with. I
see you spent much more time with sata_mv than I did. What's missing to
support the Marvell 88SX7042 in u-boot?

> > > [...]
> > > > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > > > index 9446acba79..89e55bf0d4 100644
> > > > --- a/include/configs/ds414.h
> > > > +++ b/include/configs/ds414.h
> > > [...]
> > > > @@ -16,14 +17,9 @@
> > > >   * U-Boot into it.
> > > >   */
> > > >
> > > > -/* I2C */
> > > >  #define CFG_I2C_MVTWSI_BASE0         MVEBU_TWSI_BASE
> > > >
> > > > -/*
> > > > - * mv-common.h should be defined after CMD configs since it used them
> > > > - * to enable certain macros
> > > > - */
> > > > -#include "mv-common.h"
> > > > +#define PHY_ANEG_TIMEOUT     16000   /* PHY needs a longer aneg time */
> > >
> > > AIUI, this is a limitation of my local NIC, not the DS414 one. It just
> > > took too long for link detection and autoneg when directly connected. A
> > > switch should have helped. Or do you have more details?
> >
> > Ah! The typical PHY_ANEG_TIMEOUT on other Armada 38x boards is 8000. I
> > thought the 16000 was for Armada XP when I saw that code. I think it's
> > OK to use a larger timeout. It really does not hurt?

It does not - this change merely makes u-boot wait for longer until
giving up waiting for link. My setup involves a direct link between the
DS414 and a Realtek NIC, so it is rather surprising 16s timeout is
sufficient. ;)

Ah, one more thing: You mentioned mtdparts to define a flash map which
should simplify flashing u-boot into the right spot. I haven't had any
luck doing so for SPI flash, do you?

Cheers, Phil
