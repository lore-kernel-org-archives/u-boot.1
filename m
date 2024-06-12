Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28176C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AB3887BB;
	Wed, 12 Jun 2024 11:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="GSYyWeKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6E18834B; Wed, 12 Jun 2024 11:09:24 +0200 (CEST)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12A8887BB
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vu6JSZ7MXAsRjZwJz0oG7pDCe+Cj5doNnUvuuxnsJos=; b=GSYyWeKW+LtgiM/v2yxaDmeL1L
 8BO0mxAI3G8qhGlb+Vqd1kLrPFbXhvv5P8ro2RUC51Tq6zhcZ6lMpYEuJAQzWEto5p617WK8YuS07
 Y0UeKTNMBltczvq1zk2trXiD3I+qDY1dhHDevHv+lQGhvQkusmygBB2lIe3AK60tXGX3zwpIl+I9O
 7Pp+RcwrUrOtorQDhic72KF2f5pJqGGiR0vrYadTmBOwU/BPZr9yyhODldZOGLJE/Cx7fDpYogIJs
 YXmWSGLsouaFphRz470cUWUxqUi2CYWniAo4YJgEOgRkOslaTdhWaj5w/JUVqV1pQbsbLcY50X3H/
 yFczvbHg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1sHJyp-000000000pX-3es6;
 Wed, 12 Jun 2024 11:09:19 +0200
Date: Wed, 12 Jun 2024 11:09:19 +0200
From: Phil Sutter <phil@nwl.cc>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
Message-ID: <Zmllv6xiOREEO4TW@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240606234437.24549-1-mibodhi@gmail.com>
 <ZmMO-yODr9n2X7yD@orbyte.nwl.cc>
 <CAJaLiFwDHkkDKv3DY8Edk7_LE8gVHujx=d=nMfF3vu2zGmLWgA@mail.gmail.com>
 <ZmTqJwGDQlILtlnx@orbyte.nwl.cc>
 <CAJaLiFyrONZnDW_D50BwiJdCBF5neXs73AGkgcpwwfGqBWJ9Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaLiFyrONZnDW_D50BwiJdCBF5neXs73AGkgcpwwfGqBWJ9Lw@mail.gmail.com>
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

Hi,

On Sun, Jun 09, 2024 at 01:51:34PM -0700, Tony Dinh wrote:
> On Sat, Jun 8, 2024 at 4:32 PM Phil Sutter <phil@nwl.cc> wrote:
> > On Fri, Jun 07, 2024 at 04:14:26PM -0700, Tony Dinh wrote:
> > > On Fri, Jun 7, 2024 at 6:45 AM Phil Sutter <phil@nwl.cc> wrote:
> > > > On Thu, Jun 06, 2024 at 04:44:36PM -0700, Tony Dinh wrote:
> > > > > - Switch to standard boot (in include/configs/ds414.h and
> > > > > configs/ds414_defconfig)
> > > > > - Implement board_late_init() to ensure successful enumeration
> > > > > of USB3 devices
> > > >
> > > > Oh, this makes the rear USB3 ports usable? I had failed to get there
> > > > when working on DS414 support.
> > >
> > > Yes! There have been a lot of updates in the PCIe MVEBU area. So it
> > > could have been a different reason why it did not work when you added
> > > support for this board.
> >
> > Nice!
> >
> > > Still, without this board_late_init(), we would need to run "pci enum"
> > > and then "usb start" or "usb reset" to bring up the USB3 ports. The
> > > USB3 controller is on the PCIe bus, and MVEBU PCIe drivers don't
> > > initialize everything when it comes up.
> >
> > Yeah, at some point I still had
> > | CONFIG_PREBOOT="usb start; sf probe"
> > in ds414_defconfig. Looking at my initial DS414 support patch from 2015,
> > at least 'usb start' seemed to be necessary for USB to work in Linux.
> > This might have changed later as I dropped the config symbol six years
> > later in e471ddf0f3472 ("arm: mvebu: board/Synology: Unify legacy kernel
> > support").
> >
> > > > > - Remove unnecessary misc_init_r(), since NET_RANDOM_ETHADDR is now
> > > > > configured in
> > > >
> > > > So u-boot will assign random MAC addresses to the NICs instead of the
> > > > real ones? Won't this potentially break PXE boot setups?
> > >
> > > I did not see any problem using a random MAC address in my test using
> > > bootstd. Is there a setup where this board MAC address must be known
> > > when we boot with PXE? my impression is that only ipaddr and serverip
> > > are needed, and the MAC address could be whatever we define for the
> > > board.
> >
> > I haven't played with PXE for a long time, but I assumed the DHCP daemon
> > might send different options to different hosts identified by their MAC
> > address. The latter being random obviously defeats such setups.
> >
> > Does the random MAC persist in Linux, BTW? I don't recall Linux
> > extracting data from the vendor-specific flash storage. Unless I'm
> > mistaken, it should be u-boot's responsibility to setup MAC addresses in
> > the NICs (to the vendor-assigned ones).
> 
> Yes, it persists. Whatever was assigned to ethaddr and eth1addr are
> passed to the Linux kernel. So the random local MAC address is
> recognized as the hardware MAC address.

Thanks for confirming. I'll try board_eth_init() in one of the next
evenings - my DS414 needs a revamp anyway, the rootfs on that bloody
USB stick I boot from keeps disintegrating and the box is FUBAR ATM.

> As an aside, there is a bug in bootstd that "bootflow scan -l" will go
> into a seemingly infinite loop during PXE hunting if eth1addr is not
> defined. I've not figured out how to fix this error recovery. I might
> just give up and send the bug report to Simon :)

Fixing the bug as well as making sure eth1addr is properly set should
not hurt. :)

> > > > > - Remove unnecessary checkboard()
> > > > > - Updated IDENT_STRING to indicate this u-boot supports both Synology
> > > > > DS414 and DS214+ boards
> > > > > - Add SYS_THUMB_BUILD to reduce binary size
> > > > > - Add NET_RANDOM_ETHADDR
> > > > > - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> > > > >
> > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > ---
> > > > >
> > > > >  board/Synology/ds414/ds414.c | 15 +++--------
> > > > >  configs/ds414_defconfig      | 20 ++++++--------
> > > > >  include/configs/ds414.h      | 51 ++++++++++++++++++++++--------------
> > > > >  3 files changed, 42 insertions(+), 44 deletions(-)
> > > > >
> > > > > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
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
> > > > > -             puts("Incomplete environment, populating from SPI flash\n");
> > > > > -             do_syno_populate(0, NULL);
> > > > > -     }
> > > > > -     return 0;
> > > > > -}
> > > >
> > > > This is useful for first boot of flashed vanilla u-boot. Can this be
> > > > retained somehow?
> > >
> > > We could, but with NET_RANDOM_ETHADDR configured in, this routine will
> > > do nothing. Perhaps the fact that the envs will show CRC errors in the
> > > 1st boot should be an indicator that it needs to be populated?
> >
> > Maybe this env population approach is not the right one to begin with.
> > Reading doc/README.enetaddr, it seems we want something like step 1 in
> > "Correct flow of setting up the MAC address", though I'm not sure which
> > initialize() function this is about (board_eth_init() maybe?). Also we
> > need a working spi flash driver at that point.
> >
> > > With standard boot enabled in this patch, the default envs can be
> > > scripted in /boot/boot.scr or /boot.scr on the rootfs disk storage, or
> > > on some flash location, or on the network . So we don't even need the
> > > full envs on SPI flash like we used to. It might still be useful but
> > > not necessary.
> >
> > Maybe one could implement a translator which presents the 'vendor'
> > partition contents as such default boot env.
> 
> Are you still using the stock Linux kernel at all?

No, but I still have it on flash. When working on vanilla u-boot, being
able to boot into stock OS and having it appear to work fine was a
criteria for me. Also it is nice if other users are able to replace the
crappy Synology u-boot without being forced to also boot a custom OS.

> > > > [...]
> > > > > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > > > > index 9446acba79..bbefe632e0 100644
> > > > > --- a/include/configs/ds414.h
> > > > > +++ b/include/configs/ds414.h
> > > > [...]
> > > > > @@ -38,23 +34,38 @@
> > > > >   * L2 cache thus cannot be used.
> > > > >   */
> > > > >
> > > > > -/* SPL */
> > > > > -/* Defines for SPL */
> > > > > +/* Keep device tree and initrd in lower memory so the kernel can access them */
> > > > > +#define RELOCATION_LIMITS_ENV_SETTINGS  \
> > > > > +     "fdt_high=0x10000000\0"         \
> > > > > +     "initrd_high=0x10000000\0"
> > > > > +
> > > > > +/*
> > > > > + * mv-common.h should be defined after CMD configs since it used them
> > > > > + * to enable certain macros
> > > > > + */
> > > > > +#include "mv-common.h"
> > > > > +
> > > > > +#ifndef CONFIG_SPL_BUILD
> > > > >
> > > > > -/* Default Environment */
> > > > > +#define KERNEL_ADDR_R        __stringify(0x1000000)
> > > > > +#define FDT_ADDR_R   __stringify(0x2000000)
> > > > > +#define RAMDISK_ADDR_R       __stringify(0x2200000)
> > > > > +#define SCRIPT_ADDR_R        __stringify(0x1800000)
> > > > > +#define PXEFILE_ADDR_R       __stringify(0x1900000)
> > > > >
> > > > > -#define CFG_EXTRA_ENV_SETTINGS                               \
> > > > > -     "initrd_high=0xffffffff\0"                              \
> > > > > -     "ramdisk_addr_r=0x8000000\0"                            \
> > > > > -     "usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"       \
> > > > > -     "ethmtu=1500\0eth1mtu=1500\0"                           \
> > > > > -     "update_uboot=sf probe; dhcp; "                         \
> > > > > -             "mw.b ${loadaddr} 0x0 0xd0000; "                \
> > > > > -             "tftpboot ${loadaddr} u-boot-with-spl.kwb; "    \
> > > > > -             "sf update ${loadaddr} 0x0 0xd0000\0"
> > > >
> > > > Are these dropped or am I missing a generic spot which adds them? IIRC,
> > > > the usb*mode and eth*mtu settings are required, is that wrong? Lastly,
> > >
> > > MTU is default to 1500 in mvneta.c. So the eth*mtu env is no longer necessary.
> > >
> > > Also, I believe usb*mode is no longer necessary with the USB driver
> > > model. I have not come across their usage anywhere for a long time.
> > > The USB driver model seems to handle everything pretty well.
> >
> > I think both are required for stock Synology Linux, see
> > setup_board_tags() in board/Synology/common/legacy.c. One could just
> > hard-code sane fallback values into that routine though.
> 
> I see. Now I realized it's my bad that I did not consider stock OS at
> all! The purpose of this patch is to get u-boot to use bootstd to boot
> modern distros using a distro boot script. Should I put back these
> envs "usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"
> "ethmtu=1500\0eth1mtu=1500\0"  so we can support stock FW?

Yes, please. It's the simplest way to retain that functionality. If
CONFIG_NET_RANDOM_ETHADDR populates eth*addr env vars, we may even keep
that (and fetching "the real" addresses becomes merely a bonus).

Cheers, Phil
