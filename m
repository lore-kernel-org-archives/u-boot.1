Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E9CF34C1
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB10F88FAF;
	Thu,  3 Oct 2024 22:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i/0/Jjea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF4488FA9; Thu,  3 Oct 2024 22:46:18 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AAE88DB2
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 22:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb2f344dbbso11095556d6.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727988375; x=1728593175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RikpjMMBIlAhewFujnUxUSJRolbnFWgY0c44FoCYaIo=;
 b=i/0/Jjea2q8wMv8WZGSPH5VGH9AoCktCqG2HxcJANHBpJsvCHggfnmT1q7gF2Auc7W
 hv9DsJhmfFHZl0thifncoOootIny/ehTQPvLWutMmJLsAQnS4OthGLdsaTa9LBzIoH5T
 9QV7cO15CkJUlMJv1A37b302eX0+P3gW1Q+vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727988375; x=1728593175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RikpjMMBIlAhewFujnUxUSJRolbnFWgY0c44FoCYaIo=;
 b=tqPw6HG33GuBudsFt9fJFdKRQxMXnmEZaNW0+QLPMuU44X0WJwuboS8xePkBZSC754
 hY4xzSZAjkgtNyY9otwOc/rcolpTZ9TksFOPWY3BYCVKXK02HbQzoZqUArwmIPHiAkIe
 3pgm7SnoHB7HqFFtAF4tkl9GVxahyBRIiT04L5MxeiNKX4ul1argQYm2zNzCLv47vvoV
 WKcjZcHoHP3RRPIVsujIVyekTWaihwF5p7nzJcufMV80w8HRVwaPzeZHUKVGFBlON4a6
 0upNCkrbaQxMgvMeWOmLD1EHdXiHVExUyafc/hcoBKgVeCKVy2tOCBMnAN4S/3OFyNah
 XdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy+T0HUDu7g81DyYlDtGnRqt5R5pHfWHbhrhyiaQCG6dTeZkLFBYa439XgXAG1p7faSDpKejo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVWqD2qT0uzPfYFfMrrxj8BOJPFIM0872myWAVbKpknkjbkg4z
 p8j8kHxqm5Z5FuAKrbHMNlatqilbj0yIo0P/8vn558rYz3flhHdJE8oNNvDVa9oP7bC/JN2i9GE
 FHKEVZwf3Kel5pFJ8ZU1fLhYrlNvoSMGHnMp/
X-Google-Smtp-Source: AGHT+IFvthxAwX6glNNi+1ZUcsw7hRow4dCVdy8HmdZ2tsrrWlN2/AhLB6rEO4R/0+XlYyzrV71md+hG11PVb+xF9+0=
X-Received: by 2002:a05:6214:4b0d:b0:6cb:2e94:3e24 with SMTP id
 6a1803df08f44-6cb9a306c99mr8389636d6.11.1727988374860; Thu, 03 Oct 2024
 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
 <20241003144351.GU4737@bill-the-cat>
 <CAFLszThJ8ZUpq9_VVTxw6YwCmKqx1gghwinPx-=Srqc5k02UCw@mail.gmail.com>
 <20241003191751.GV4737@bill-the-cat>
In-Reply-To: <20241003191751.GV4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 14:46:03 -0600
Message-ID: <CAFLszTi5nj-tXuO+UGJSPbJxqFtwQXkN8UsjT2hi1LF6zGLFHg@mail.gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 3 Oct 2024 at 13:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 03, 2024 at 10:59:40AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 3 Oct 2024 at 08:43, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 03, 2024 at 07:50:45AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 2 Oct 2024 at 19:35, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 02, 2024 at 04:55:34PM -0600, Simon Glass wrote:
> > > > > > Hi Patrick,
> > > > > >
> > > > > > On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
> > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > >
> > > > > > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > > > > > >
> > > > > > > Unlike other Arm based platforms the machine only provides a minimal
> > > > > > > FDT that contains number of CPUs, ammount of memory and machine-version.
> > > > > > > The boot firmware has to provide ACPI tables to the OS.
> > > > > > > Due to this design a full DTB is added here as well that allows U-Boot's
> > > > > > > driver to properly function. The DTB is appended at the end of the U-Boot
> > > > > > > image and will be merged with the QEMU provided DTB.
> > > > > > >
> > > > > > > In addition provide documentation how to use, enable binman to fabricate both
> > > > > > > ROMs that are required to boot and add ACPI tables to make it full compatible
> > > > > > > to the EDK2 reference implementation.
> > > > > > >
> > > > > > > The board was tested using Fedora 40 Aarch64 Workstation. It's able
> > > > > > > to boot from USB and AHCI or network.
> > > > > > >
> > > > > > > Tested and found working:
> > > > > > > - serial
> > > > > > > - PCI
> > > > > > > - xHCI
> > > > > > > - Bochs display
> > > > > > > - AHCI
> > > > > > > - network using e1000e
> > > > > > > - CPU init
> > > > > > > - Booting Fedora 40
> > > > > > >
> > > > > > > 1: Server Base System Architecture (SBSA)
> > > > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> > > > > > >
> > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > ---
> > > > > > > Changelog v3:
> > > > > > > - Add GIC and GIC-ITS to devicetree
> > > > > > > - Select GICv3 driver
> > > > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > > > Changelog v4:
> > > > > > > - Drop CPU platform code
> > > > > > > - Enhance the DT to allow MADT generation from DT
> > > > > > > Changelog v5:
> > > > > > > - Add full DT and place it at the end of U-Boot
> > > > > > > - Merge DT with QEMU's DT
> > > > > > > - Drop DT generation code
> > > > > > > - Fix flash region length
> > > > > > > - Drop enable_caches()
> > > > > > > - Support platforms that do not pass FDT in x0
> > > > > > > Changelog v6:
> > > > > > > - Update header order
> > > > > > > - Drop pad-byte from DT
> > > > > > > - select BINMAN_FDT
> > > > > > > - select E1000_NO_NVM
> > > > > > > - drop config.h include
> > > > > > > - drop a few CFG_ defines that were used for SPL
> > > > > > >
> > > > > > > ---
> > > > > > >  arch/arm/Kconfig                            |   3 +-
> > > > > > >  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
> > > > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > > > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > > > >  board/emulation/qemu-sbsa/Kconfig           |  57 +++
> > > > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > > > >  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
> > > > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> > > > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
> > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > > > >  board/emulation/qemu-sbsa/smc.c             |  71 +++
> > > > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > > > >  doc/board/emulation/index.rst               |   1 +
> > > > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > > > >  include/configs/qemu-sbsa.h                 |  95 ++++
> > > > > > >  19 files changed, 1605 insertions(+), 7 deletions(-)
> > > > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> > > > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > > > >
> > > > > > With the tweaks below:
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
> > > > > > > new file mode 100644
> > > > > > > index 0000000000..f743ea3863
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/arm/dts/qemu-sbsa.dts
> > > > > > > @@ -0,0 +1,136 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > > > > > +/*
> > > > > > > + * Devicetree with onboard devices for qemu_sbsa-ref for internal use only!
> > > > > > > + * DO NOT PASS TO THE OS!
> > > > > > > + *
> > > > > > > + * As QEMU provides only a minimal devicetree this one is merged with
> > > > > > > + * it and then fixed at runtime.
> > > > > > > + *
> > > > > > > + * Copyright 2024 9elements GmbH
> > > > > > > + */
> > > > > > > +#include "configs/qemu-sbsa.h"
> > > > > > > +
> > > > > > > +/dts-v1/;
> > > > > > > +
> > > > > > > +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> > > > > > > +
> > > > > > > +/ {
> > > > > > > +       #address-cells = <2>;
> > > > > > > +       #size-cells = <2>;
> > > > > > > +       interrupt-parent = <&intc>;
> > > > > > > +       compatible = "linux,sbsa-ref";
> > > > > > > +
> > > > > > > +       binman: binman {
> > > > > > > +               multiple-images;
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       cpus {
> > > > > > > +               /* Filled by fdtdec_board_setup() */
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       memory {
> > > > > > > +               /* Filled by fdtdec_board_setup() */
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       soc {
> > > > > > > +               compatible = "simple-bus";
> > > > > > > +               #address-cells = <2>;
> > > > > > > +               #size-cells = <2>;
> > > > > > > +               ranges;
> > > > > > > +
> > > > > > > +               uart0 {
> > > > > > > +                       compatible = "arm,pl011";
> > > > > > > +                       status = "okay";
> > > > > > > +                       reg = <MAKE_PROP(SBSA_UART_BASE_ADDR)
> > > > > >
> > > > > > Can you use
> > > > > >
> > > > > > reg = /bits 64/ <0x60000000>
> > > > > >
> > > > > > instead?
> > > > > >
> > > > > > Same for those below.
> > > > >
> > > > > Isn't that less readable ?
> > > >
> > > > Which bit of it is less readable?
> > >
> > > Having hex spelled out rather than a macro that's clear what's being
> > > generated.
> >
> > To my eye it seems odd to define a base address in a macro only to
> > have it used once in a devicetree. We don't do that elsewhere.
>
> We don't, but this isn't quite a normal board?

Don't be surprised if this becomes more common. For better or worse,
ARM has decided on ACPI for its servers and RISC-V is following. We
also have the EFI app, which has a devicetree, although of course no
actual addresses.

>
> > Breaking down the SBSA_UART_BASE_ADDR:
> >
> > - this is in the uart0 node so obviously relates to the UART
> > - it is a reg property, so BASE_ADDR is obvious
> > - SBSA is the board name, which is in the filename, so don't really add anything
> >
> > Normally where the devicetree needs a value defined, we put it in the
> > dt-bindings directory. But even then, we don't typically put addresses
> > there. It is just for cases where we need the code and the devicetree
> > to be in sync about a property value. With addresses, the code reads
> > them from the devicetree, so doesn't need to have a #define to access
> > them...in fact that would defeat the purpose.
> >
> > If we did this sort of thing with other boards, we would have a heap
> > of binding files containing addresses that are only used in one place.
> > I just don't see the point.
> >
> > However for SBSA_PCIE_MMIO_BASE_ADDR I see that it is used in the .asl
> > and the memory map, so it seems fair enough to define that, at least
> > unless/until we can refer to devicetree addresses in the .asl file.
> > Even with this one though, I would expect something like:
> >
> > ranges = <0x02000000>, /bits/ 64 <SBSA_PCIE_MMIO_BASE_ADDR
> >
> > SBSA_PCIE_MMIO_BASE_ADDR>;
> >
> > But in this case I can see how a macro might be more convenient and
> > I'm not sure I have a strong opinion here.
>
> If you're strongly against using the macros here, OK, fine. But since
> this tree is only going to be read by humans in U-Boot, and consumed by
> U-Boot, I think it makes sense to deviate from the norms a little, in
> favour of human readability.

How about only using them when there is code that need the same address?

There are two lots of macros so just to check we are talking about the
same thing:

- xxx_BASE_ADDR - IMO they should be open-coded into the devicetree if
it is the only user
- MAKE_PROP - IMO we should use /bit/ 64 instead

>
> > > > But I very much doubt upstream would accept it with a macro. Other
> > > > 64-bit boards seem to use '/bits/ 64'.
> > >
> > > What upstream are you referring to here? I'm not sure what other project
> > > will want a device tree for the "no device tree only acpi" virtual
> > > reference platform.
> >
> > It depends if they want to run U-Boot or not. U-Boot always needs a
> > devicetree, as you know. It cannot use ACPI tables to configure itself
> > and I would rather it doesn't start.
> >
> > I don't actually see any reason why this devicetree could not be
> > upstreamed, except that QEMU actually creates a Linux devicetree right
> > now (on the ARM side) and takes no notice of what U-Boot needs... I
> > don't see any U-Boot patches from the maintainers, for example,
> > although I may have missed some. It seems very focussed on UEFI. I
> > would love that to change, as QEMU is widely used in U-Boot on ARM...
>
> I feel like we're lost the point here. This platform in question is the
> "never use device tree, only use ACPI" reference platform.

never use device tree for Linux

(U-Boot always uses it)

> This is not
> the regular "virt" platform, even. U-Boot needs a device tree because
> internally we use it for configuration. I do not see the QEMU project
> agreeing to have this platform generate a device tree for us to consume
> in this case, declaring instead that it's a U-Boot internal need and
> that no, it's fine if U-Boot can't use it. _We_ want it because it makes
> testing of the aarch64 + ACPI use case easy because it provides us with
> the ability to use the reference platform too and make sure that we
> aren't breaking the OS in unexpected ways.

OK, well as you say this is not really the main issue, so that's fine.
I agree (and was lamenting) that QEMU seems unwilling at present to do
anything to assist U-Boot.

Regards,
SImon
