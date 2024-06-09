Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B497DC27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 20:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BD08838B;
	Sun,  9 Jun 2024 22:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgRvBMBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEAEE883A7; Sun,  9 Jun 2024 22:51:49 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992A58838B
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 22:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebdfe26226so7429401fa.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717966307; x=1718571107; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssS0Hxeeqa1Ups0IFhYhb4/+YwOvtzgeiiSrUAkLp98=;
 b=OgRvBMBNYYv0Tk712Z7zcWZl2eBqUrab8eihGIkQ63vOXGaE68duWlrzWhhfK1yWwK
 yrm9DFvyahZ+04Rpmc6+v4XBirmv18hTUHPlzbXQFEtXFSP8Hzjdp2qHW+tyNnIJGdvS
 UcuVoWPeFuxEAZfsnhhPZzU0TMM9/2erZrxmJ9TjOLAU1o6Bcxr9GpRrDGe/1WLWs7Yn
 rC3dpFrP4NXG6hT71K1XQZsFYDc12eqQ/TtXcovCt6rxZVEE2aGly2fPUrANFj++I9FD
 EJDAwU9jQ599UQakqNq88VGs7BFZtR9z4uqOuaH2NyfYx5xGSXKK1NsHIs4Wii3Mi7/j
 uakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717966307; x=1718571107;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssS0Hxeeqa1Ups0IFhYhb4/+YwOvtzgeiiSrUAkLp98=;
 b=bU6ZXGBYwrO3HJIWngnK0drO86FX1yGC6sD7QeeGB55vKFcBBdygUd4EycdSD0k1cW
 JcpV/j0BLcefC1UDgglVF0QhaTvJn8lD33WGZoKU3Cq/WZMzEIaeavmENGEPinykLZbu
 zV8YZXgayt/pN4TidG/v/fHVEAcKCRp7u0bT8A6XvJViEtS0iiMZzY59AB9Xo8WQCP4R
 rEg7CyV+oxdC4xoj7+xueguE2e9ybh2LRLxtM0EcoVpN5+17D7XEj69MGJuBpv2Vf1hB
 OWPrgBTY4731oGY8whpWHAOnMJJNnFNVgVodquo/ksw9IDsXpBYjUexkQha9ScfBMJbH
 LzBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBDUWFOmuM7pPvxHBBuA6A6ByP/GSp4kK+SpDRiZiN6P88dNagqiECdLetfID5a0UlnSydVmgOrHbGmj4bqf+G73aO8g==
X-Gm-Message-State: AOJu0Yygl9kAJbXOi5jBbmZpJzyqpiZRT89/VhiktCWA/AeOtamNFZXD
 riVMMOWcVq31dBOAxiVRdFFd5De014iOmm8LNCgun72/tZRq3iHDBq+66FoWnpS8dKKFGpKfyWi
 Eyl+9UcLUfXzjw61cOKHmWGzxzDw=
X-Google-Smtp-Source: AGHT+IFKzqnWYJ0+3pLCCOC9WxUzWqiIoiyW3QrtcDlN5KVLYK2p+XndJOfFtNJewsLpRj/UK1ZIsIxiRAaH8QXhIlU=
X-Received: by 2002:a2e:3801:0:b0:2ea:e98e:4396 with SMTP id
 38308e7fff4ca-2eae98e479dmr43979651fa.37.1717966306512; Sun, 09 Jun 2024
 13:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240606234437.24549-1-mibodhi@gmail.com>
 <ZmMO-yODr9n2X7yD@orbyte.nwl.cc>
 <CAJaLiFwDHkkDKv3DY8Edk7_LE8gVHujx=d=nMfF3vu2zGmLWgA@mail.gmail.com>
 <ZmTqJwGDQlILtlnx@orbyte.nwl.cc>
In-Reply-To: <ZmTqJwGDQlILtlnx@orbyte.nwl.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 9 Jun 2024 13:51:34 -0700
Message-ID: <CAJaLiFyrONZnDW_D50BwiJdCBF5neXs73AGkgcpwwfGqBWJ9Lw@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: Enable bootstd and other modernization for
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

On Sat, Jun 8, 2024 at 4:32=E2=80=AFPM Phil Sutter <phil@nwl.cc> wrote:
>
> On Fri, Jun 07, 2024 at 04:14:26PM -0700, Tony Dinh wrote:
> > On Fri, Jun 7, 2024 at 6:45=E2=80=AFAM Phil Sutter <phil@nwl.cc> wrote:
> > > On Thu, Jun 06, 2024 at 04:44:36PM -0700, Tony Dinh wrote:
> > > > - Switch to standard boot (in include/configs/ds414.h and
> > > > configs/ds414_defconfig)
> > > > - Implement board_late_init() to ensure successful enumeration
> > > > of USB3 devices
> > >
> > > Oh, this makes the rear USB3 ports usable? I had failed to get there
> > > when working on DS414 support.
> >
> > Yes! There have been a lot of updates in the PCIe MVEBU area. So it
> > could have been a different reason why it did not work when you added
> > support for this board.
>
> Nice!
>
> > Still, without this board_late_init(), we would need to run "pci enum"
> > and then "usb start" or "usb reset" to bring up the USB3 ports. The
> > USB3 controller is on the PCIe bus, and MVEBU PCIe drivers don't
> > initialize everything when it comes up.
>
> Yeah, at some point I still had
> | CONFIG_PREBOOT=3D"usb start; sf probe"
> in ds414_defconfig. Looking at my initial DS414 support patch from 2015,
> at least 'usb start' seemed to be necessary for USB to work in Linux.
> This might have changed later as I dropped the config symbol six years
> later in e471ddf0f3472 ("arm: mvebu: board/Synology: Unify legacy kernel
> support").
>
> > > > - Remove unnecessary misc_init_r(), since NET_RANDOM_ETHADDR is now
> > > > configured in
> > >
> > > So u-boot will assign random MAC addresses to the NICs instead of the
> > > real ones? Won't this potentially break PXE boot setups?
> >
> > I did not see any problem using a random MAC address in my test using
> > bootstd. Is there a setup where this board MAC address must be known
> > when we boot with PXE? my impression is that only ipaddr and serverip
> > are needed, and the MAC address could be whatever we define for the
> > board.
>
> I haven't played with PXE for a long time, but I assumed the DHCP daemon
> might send different options to different hosts identified by their MAC
> address. The latter being random obviously defeats such setups.
>
> Does the random MAC persist in Linux, BTW? I don't recall Linux
> extracting data from the vendor-specific flash storage. Unless I'm
> mistaken, it should be u-boot's responsibility to setup MAC addresses in
> the NICs (to the vendor-assigned ones).

Yes, it persists. Whatever was assigned to ethaddr and eth1addr are
passed to the Linux kernel. So the random local MAC address is
recognized as the hardware MAC address.

As an aside, there is a bug in bootstd that "bootflow scan -l" will go
into a seemingly infinite loop during PXE hunting if eth1addr is not
defined. I've not figured out how to fix this error recovery. I might
just give up and send the bug report to Simon :)

>
> > > > - Remove unnecessary checkboard()
> > > > - Updated IDENT_STRING to indicate this u-boot supports both Synolo=
gy
> > > > DS414 and DS214+ boards
> > > > - Add SYS_THUMB_BUILD to reduce binary size
> > > > - Add NET_RANDOM_ETHADDR
> > > > - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> > > >
> > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > ---
> > > >
> > > >  board/Synology/ds414/ds414.c | 15 +++--------
> > > >  configs/ds414_defconfig      | 20 ++++++--------
> > > >  include/configs/ds414.h      | 51 ++++++++++++++++++++++----------=
----
> > > >  3 files changed, 42 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds=
414.c
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
> > > > -             puts("Incomplete environment, populating from SPI fla=
sh\n");
> > > > -             do_syno_populate(0, NULL);
> > > > -     }
> > > > -     return 0;
> > > > -}
> > >
> > > This is useful for first boot of flashed vanilla u-boot. Can this be
> > > retained somehow?
> >
> > We could, but with NET_RANDOM_ETHADDR configured in, this routine will
> > do nothing. Perhaps the fact that the envs will show CRC errors in the
> > 1st boot should be an indicator that it needs to be populated?
>
> Maybe this env population approach is not the right one to begin with.
> Reading doc/README.enetaddr, it seems we want something like step 1 in
> "Correct flow of setting up the MAC address", though I'm not sure which
> initialize() function this is about (board_eth_init() maybe?). Also we
> need a working spi flash driver at that point.
>
> > With standard boot enabled in this patch, the default envs can be
> > scripted in /boot/boot.scr or /boot.scr on the rootfs disk storage, or
> > on some flash location, or on the network . So we don't even need the
> > full envs on SPI flash like we used to. It might still be useful but
> > not necessary.
>
> Maybe one could implement a translator which presents the 'vendor'
> partition contents as such default boot env.

Are you still using the stock Linux kernel at all?

>
> > > [...]
> > > > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > > > index 9446acba79..bbefe632e0 100644
> > > > --- a/include/configs/ds414.h
> > > > +++ b/include/configs/ds414.h
> > > [...]
> > > > @@ -38,23 +34,38 @@
> > > >   * L2 cache thus cannot be used.
> > > >   */
> > > >
> > > > -/* SPL */
> > > > -/* Defines for SPL */
> > > > +/* Keep device tree and initrd in lower memory so the kernel can a=
ccess them */
> > > > +#define RELOCATION_LIMITS_ENV_SETTINGS  \
> > > > +     "fdt_high=3D0x10000000\0"         \
> > > > +     "initrd_high=3D0x10000000\0"
> > > > +
> > > > +/*
> > > > + * mv-common.h should be defined after CMD configs since it used t=
hem
> > > > + * to enable certain macros
> > > > + */
> > > > +#include "mv-common.h"
> > > > +
> > > > +#ifndef CONFIG_SPL_BUILD
> > > >
> > > > -/* Default Environment */
> > > > +#define KERNEL_ADDR_R        __stringify(0x1000000)
> > > > +#define FDT_ADDR_R   __stringify(0x2000000)
> > > > +#define RAMDISK_ADDR_R       __stringify(0x2200000)
> > > > +#define SCRIPT_ADDR_R        __stringify(0x1800000)
> > > > +#define PXEFILE_ADDR_R       __stringify(0x1900000)
> > > >
> > > > -#define CFG_EXTRA_ENV_SETTINGS                               \
> > > > -     "initrd_high=3D0xffffffff\0"                              \
> > > > -     "ramdisk_addr_r=3D0x8000000\0"                            \
> > > > -     "usb0Mode=3Dhost\0usb1Mode=3Dhost\0usb2Mode=3Ddevice\0"      =
 \
> > > > -     "ethmtu=3D1500\0eth1mtu=3D1500\0"                           \
> > > > -     "update_uboot=3Dsf probe; dhcp; "                         \
> > > > -             "mw.b ${loadaddr} 0x0 0xd0000; "                \
> > > > -             "tftpboot ${loadaddr} u-boot-with-spl.kwb; "    \
> > > > -             "sf update ${loadaddr} 0x0 0xd0000\0"
> > >
> > > Are these dropped or am I missing a generic spot which adds them? IIR=
C,
> > > the usb*mode and eth*mtu settings are required, is that wrong? Lastly=
,
> >
> > MTU is default to 1500 in mvneta.c. So the eth*mtu env is no longer nec=
essary.
> >
> > Also, I believe usb*mode is no longer necessary with the USB driver
> > model. I have not come across their usage anywhere for a long time.
> > The USB driver model seems to handle everything pretty well.
>
> I think both are required for stock Synology Linux, see
> setup_board_tags() in board/Synology/common/legacy.c. One could just
> hard-code sane fallback values into that routine though.

I see. Now I realized it's my bad that I did not consider stock OS at
all! The purpose of this patch is to get u-boot to use bootstd to boot
modern distros using a distro boot script. Should I put back these
envs "usb0Mode=3Dhost\0usb1Mode=3Dhost\0usb2Mode=3Ddevice\0"
"ethmtu=3D1500\0eth1mtu=3D1500\0"  so we can support stock FW?

>
> > > that update_uboot macro at least helps preventing people from writing
> > > into wrong spots. What's the cause for dropping it?
> >
> > I think we usually use mtdparts to define where u-boot is. So users
> > know where the right place to flash is. But you are right, it only
> > helps to describe exactly how to flash a new u-boot. So I'll put that
> > back in the V2 patch.
>
> Cool, thanks!
>
> > Thanks for taking time to review the patch. And I'm glad to see you
> > are still active with the u-boot community!
>
> My DS414 is still alive (and running in production most of the time), so
> I benefit from improved u-boot support as well! :)

Cool!

All the best,
Tony

>
> Cheers, Phil
