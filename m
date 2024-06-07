Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF74C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 23:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1F788499;
	Sat,  8 Jun 2024 01:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JAMF4DoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273D08850A; Sat,  8 Jun 2024 01:14:41 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D28188499
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 01:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a52dfd081so3143600a12.2
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717802078; x=1718406878; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRA3JB/fhrAYNS/gtJ4AOd8mevyd1GxZ/v7HZpKyu68=;
 b=JAMF4DoHOyBPCNtn8wTZM0P+svcbp1Ics4U8uIngm+TITtCVMQQbB5Z/jhisnP9MPz
 FOvjDO/No0LS7ylrkdEQZTTbl8ppwaaNbiZ+jAeezibGVJ+vudQbrIf9cxqVzcBwgHL1
 sp8xYLG4d6HuV299evZWHqLD6BhzpgLMtH1JLYHFc/+8SLBFM/U8EPW8mo7e0tC4qcBK
 Sh7n40Gm5n4TcW0vc587/I410sDvtHh0pakOd1K+pt+7yX6ydjgHyoXzwCqeqnB/HFLN
 Jlggr4ROeQnbT3IyY+My+KvB4DyO5xQssMNsnNWs+H1Xjl3Z+oMu/iEsSlM1xf8JeXgD
 5wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717802078; x=1718406878;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRA3JB/fhrAYNS/gtJ4AOd8mevyd1GxZ/v7HZpKyu68=;
 b=rH7kExRKwDfEWjncxF0FVypWYQAYZTh+i2MMwbhxUkuUSVYaCPiNrGTfOEQzB0TKQS
 NNQaRjqw+XumTGz0mDxX4bIN6TCoCj5j8WLAj3BJ80OBCTk4YgRH/HwQihMhLrBSXA6U
 G9+WotvMgBGr2N7EEYS89vbT9JS/MRaKIh697/Y5AABXrUusO1o9WKAIMbc3nLFB7Bmt
 2TC4deSQhSOkL+5HEqNUZTmWJH9TV3wFW8aJhJeBO8pqQNig2WYKKTY+IaLfkmBiHgYl
 Ap9BDtCUv65An3eTPKfkL8OkwR+N9LR1KPdzUjQPPRYQHyknMVwmmjXxFsnT1KQ20akX
 4w3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWryJd75mo2NO+RZ7R01F8Yh4ubdoaPJeuMiiQfh57STIIgoNNtiwB2AWmOGTI4i5b3As9cedENexhK1+9TNlIBm0uzg==
X-Gm-Message-State: AOJu0YwUxc6DEWSXjEKbYk8XRz30MhiMJmstqePk82sa0ZKJgB8CuseH
 ehfL7nhAUJdUbbkO7VEqL2GmDxle47pFBZFCBa2tt0516bVoEVn1ziX9P9m3dcrQq21dmZV46cQ
 CQ9pBBYM+5+12R6B4rRN45GZvMRY=
X-Google-Smtp-Source: AGHT+IHBoJkRNKinvUAt3GKYTEzgswFOR1tfgIRhllm7F9JzDtWX4mhPi6Eycf8oAG6sEnP6UfZHfnp2IRIR1aMy+Cw=
X-Received: by 2002:a50:aa95:0:b0:578:5242:a22c with SMTP id
 4fb4d7f45d1cf-57c50941d47mr2265959a12.25.1717802077999; Fri, 07 Jun 2024
 16:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240606234437.24549-1-mibodhi@gmail.com>
 <ZmMO-yODr9n2X7yD@orbyte.nwl.cc>
In-Reply-To: <ZmMO-yODr9n2X7yD@orbyte.nwl.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 7 Jun 2024 16:14:26 -0700
Message-ID: <CAJaLiFwDHkkDKv3DY8Edk7_LE8gVHujx=d=nMfF3vu2zGmLWgA@mail.gmail.com>
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

On Fri, Jun 7, 2024 at 6:45=E2=80=AFAM Phil Sutter <phil@nwl.cc> wrote:
>
> Hi Tony,
>
> On Thu, Jun 06, 2024 at 04:44:36PM -0700, Tony Dinh wrote:
> > - Switch to standard boot (in include/configs/ds414.h and
> > configs/ds414_defconfig)
> > - Implement board_late_init() to ensure successful enumeration
> > of USB3 devices
>
> Oh, this makes the rear USB3 ports usable? I had failed to get there
> when working on DS414 support.

Yes! There have been a lot of updates in the PCIe MVEBU area. So it
could have been a different reason why it did not work when you added
support for this board.

Still, without this board_late_init(), we would need to run "pci enum"
and then "usb start" or "usb reset" to bring up the USB3 ports. The
USB3 controller is on the PCIe bus, and MVEBU PCIe drivers don't
initialize everything when it comes up.

>
> > - Remove unnecessary misc_init_r(), since NET_RANDOM_ETHADDR is now
> > configured in
>
> So u-boot will assign random MAC addresses to the NICs instead of the
> real ones? Won't this potentially break PXE boot setups?

I did not see any problem using a random MAC address in my test using
bootstd. Is there a setup where this board MAC address must be known
when we boot with PXE? my impression is that only ipaddr and serverip
are needed, and the MAC address could be whatever we define for the
board.

>
> > - Remove unnecessary checkboard()
> > - Updated IDENT_STRING to indicate this u-boot supports both Synology
> > DS414 and DS214+ boards
> > - Add SYS_THUMB_BUILD to reduce binary size
> > - Add NET_RANDOM_ETHADDR
> > - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  board/Synology/ds414/ds414.c | 15 +++--------
> >  configs/ds414_defconfig      | 20 ++++++--------
> >  include/configs/ds414.h      | 51 ++++++++++++++++++++++--------------
> >  3 files changed, 42 insertions(+), 44 deletions(-)
> >
> > diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.=
c
> > index abe6f9eb5e..f0b55fa095 100644
> > --- a/board/Synology/ds414/ds414.c
> > +++ b/board/Synology/ds414/ds414.c
> > @@ -181,18 +181,9 @@ int board_init(void)
> >       return 0;
> >  }
> >
> > -int misc_init_r(void)
> > +int board_late_init(void)
> >  {
> > -     if (!env_get("ethaddr")) {
> > -             puts("Incomplete environment, populating from SPI flash\n=
");
> > -             do_syno_populate(0, NULL);
> > -     }
> > -     return 0;
> > -}
>
> This is useful for first boot of flashed vanilla u-boot. Can this be
> retained somehow?

We could, but with NET_RANDOM_ETHADDR configured in, this routine will
do nothing. Perhaps the fact that the envs will show CRC errors in the
1st boot should be an indicator that it needs to be populated?

With standard boot enabled in this patch, the default envs can be
scripted in /boot/boot.scr or /boot.scr on the rootfs disk storage, or
on some flash location, or on the network . So we don't even need the
full envs on SPI flash like we used to. It might still be useful but
not necessary.

>
> [...]
> > diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> > index 9446acba79..bbefe632e0 100644
> > --- a/include/configs/ds414.h
> > +++ b/include/configs/ds414.h
> [...]
> > @@ -38,23 +34,38 @@
> >   * L2 cache thus cannot be used.
> >   */
> >
> > -/* SPL */
> > -/* Defines for SPL */
> > +/* Keep device tree and initrd in lower memory so the kernel can acces=
s them */
> > +#define RELOCATION_LIMITS_ENV_SETTINGS  \
> > +     "fdt_high=3D0x10000000\0"         \
> > +     "initrd_high=3D0x10000000\0"
> > +
> > +/*
> > + * mv-common.h should be defined after CMD configs since it used them
> > + * to enable certain macros
> > + */
> > +#include "mv-common.h"
> > +
> > +#ifndef CONFIG_SPL_BUILD
> >
> > -/* Default Environment */
> > +#define KERNEL_ADDR_R        __stringify(0x1000000)
> > +#define FDT_ADDR_R   __stringify(0x2000000)
> > +#define RAMDISK_ADDR_R       __stringify(0x2200000)
> > +#define SCRIPT_ADDR_R        __stringify(0x1800000)
> > +#define PXEFILE_ADDR_R       __stringify(0x1900000)
> >
> > -#define CFG_EXTRA_ENV_SETTINGS                               \
> > -     "initrd_high=3D0xffffffff\0"                              \
> > -     "ramdisk_addr_r=3D0x8000000\0"                            \
> > -     "usb0Mode=3Dhost\0usb1Mode=3Dhost\0usb2Mode=3Ddevice\0"       \
> > -     "ethmtu=3D1500\0eth1mtu=3D1500\0"                           \
> > -     "update_uboot=3Dsf probe; dhcp; "                         \
> > -             "mw.b ${loadaddr} 0x0 0xd0000; "                \
> > -             "tftpboot ${loadaddr} u-boot-with-spl.kwb; "    \
> > -             "sf update ${loadaddr} 0x0 0xd0000\0"
>
> Are these dropped or am I missing a generic spot which adds them? IIRC,
> the usb*mode and eth*mtu settings are required, is that wrong? Lastly,

MTU is default to 1500 in mvneta.c. So the eth*mtu env is no longer necessa=
ry.

Also, I believe usb*mode is no longer necessary with the USB driver
model. I have not come across their usage anywhere for a long time.
The USB driver model seems to handle everything pretty well.

> that update_uboot macro at least helps preventing people from writing
> into wrong spots. What's the cause for dropping it?

I think we usually use mtdparts to define where u-boot is. So users
know where the right place to flash is. But you are right, it only
helps to describe exactly how to flash a new u-boot. So I'll put that
back in the V2 patch.

Thanks for taking time to review the patch. And I'm glad to see you
are still active with the u-boot community!

All the best,
Tony

>
> Thanks, Phil
