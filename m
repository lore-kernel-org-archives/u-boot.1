Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36485CF34BB
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 16:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A3D88E4A;
	Thu,  3 Oct 2024 18:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dpAqWllw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB7D88E5F; Thu,  3 Oct 2024 18:59:55 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECDF88B5F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 18:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4582c4aa2c2so7788081cf.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727974791; x=1728579591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KJ8nDo2iaBpQLlDl0lmqFvcH574c6J6Tz1lYQ+56mOs=;
 b=dpAqWllwWZSAOoSC1OVw/+YIY0IpMqxD4i4wUP2KEShPVvmllSY9xS3OUpu2RbP9ZJ
 +lJpKcf+bdAsslrHUvQr7iUumKcHCmxRWtEys5+SPGy834bCYjk0XnF5v/6Or2jxvrKE
 dbt98wh0/DHIf7Jj4xABsAXeSk3CB74zymdWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727974791; x=1728579591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJ8nDo2iaBpQLlDl0lmqFvcH574c6J6Tz1lYQ+56mOs=;
 b=FzIignaOp9PQb6Egztm1GqtGRCtiWynA5fVxSAnrajS5KkuaHaYqWyQ1HNRlGxKcVg
 kATLmqgb+B3ewM+kBka9ms0eg5DC4pp1cQyf0C9E3n28VABrJMhPxagiSIqntLf7WtX6
 uQZ9hmj2KFBNjUrNLqc37Tt5q3gxqnhZDXhw83I7JMEfZnyolq6f7tPmSkL58e4yn32I
 Qf3+lveApVxKd7kVUWlGt+IdsQBeR4yWLdzo02SBnxJbrGGPeoLNJ4Aq53HDUNpssNdQ
 kk9LAcOfYMQeAAvBjWAQBq/bqDztYyR/PwdhSnwBRkDN+585n3rFo2+QiBVi+RDXBdJt
 BWXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7au0A15H1SP0IQ6Ksb9/5FREwc+0Ovjylp6famHwdswMiVuMfyz071/bIfNHB1KL78TAM+8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywmx4XJMErvMc+dgQijc1g8jIpK7FT9HiL6CZnmY0/MOh6MXjOg
 xpxcyl6UfhnFg6C3MBcfitZWlbUJ1i7aB0PoBfNmGukSJKdRkz1lvGna0l/3dguSh0eA+tmyilT
 WpjTZQIF/SogdNgsA3bfTxijEEXlbk3XdDf/t
X-Google-Smtp-Source: AGHT+IHafG6qLsqDsYeF8Xdz7irVpEq20UMaPA++1rD+wabOlGn5eKwmAxbL9LeUtXyu5QP3M5EYOswlUWjUWyuIbfw=
X-Received: by 2002:a05:6214:490a:b0:6cb:6187:7c93 with SMTP id
 6a1803df08f44-6cb819af788mr80070556d6.8.1727974791403; Thu, 03 Oct 2024
 09:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
 <20241003144351.GU4737@bill-the-cat>
In-Reply-To: <20241003144351.GU4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 10:59:40 -0600
Message-ID: <CAFLszThJ8ZUpq9_VVTxw6YwCmKqx1gghwinPx-=Srqc5k02UCw@mail.gmail.com>
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

On Thu, 3 Oct 2024 at 08:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 03, 2024 at 07:50:45AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 2 Oct 2024 at 19:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 04:55:34PM -0600, Simon Glass wrote:
> > > > Hi Patrick,
> > > >
> > > > On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > > > >
> > > > > Unlike other Arm based platforms the machine only provides a minimal
> > > > > FDT that contains number of CPUs, ammount of memory and machine-version.
> > > > > The boot firmware has to provide ACPI tables to the OS.
> > > > > Due to this design a full DTB is added here as well that allows U-Boot's
> > > > > driver to properly function. The DTB is appended at the end of the U-Boot
> > > > > image and will be merged with the QEMU provided DTB.
> > > > >
> > > > > In addition provide documentation how to use, enable binman to fabricate both
> > > > > ROMs that are required to boot and add ACPI tables to make it full compatible
> > > > > to the EDK2 reference implementation.
> > > > >
> > > > > The board was tested using Fedora 40 Aarch64 Workstation. It's able
> > > > > to boot from USB and AHCI or network.
> > > > >
> > > > > Tested and found working:
> > > > > - serial
> > > > > - PCI
> > > > > - xHCI
> > > > > - Bochs display
> > > > > - AHCI
> > > > > - network using e1000e
> > > > > - CPU init
> > > > > - Booting Fedora 40
> > > > >
> > > > > 1: Server Base System Architecture (SBSA)
> > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> > > > >
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Changelog v3:
> > > > > - Add GIC and GIC-ITS to devicetree
> > > > > - Select GICv3 driver
> > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > Changelog v4:
> > > > > - Drop CPU platform code
> > > > > - Enhance the DT to allow MADT generation from DT
> > > > > Changelog v5:
> > > > > - Add full DT and place it at the end of U-Boot
> > > > > - Merge DT with QEMU's DT
> > > > > - Drop DT generation code
> > > > > - Fix flash region length
> > > > > - Drop enable_caches()
> > > > > - Support platforms that do not pass FDT in x0
> > > > > Changelog v6:
> > > > > - Update header order
> > > > > - Drop pad-byte from DT
> > > > > - select BINMAN_FDT
> > > > > - select E1000_NO_NVM
> > > > > - drop config.h include
> > > > > - drop a few CFG_ defines that were used for SPL
> > > > >
> > > > > ---
> > > > >  arch/arm/Kconfig                            |   3 +-
> > > > >  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
> > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > >  board/emulation/qemu-sbsa/Kconfig           |  57 +++
> > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > >  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
> > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > >  board/emulation/qemu-sbsa/smc.c             |  71 +++
> > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > >  doc/board/emulation/index.rst               |   1 +
> > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > >  include/configs/qemu-sbsa.h                 |  95 ++++
> > > > >  19 files changed, 1605 insertions(+), 7 deletions(-)
> > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > >
> > > > With the tweaks below:
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > [..]
> > > >
> > > > > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
> > > > > new file mode 100644
> > > > > index 0000000000..f743ea3863
> > > > > --- /dev/null
> > > > > +++ b/arch/arm/dts/qemu-sbsa.dts
> > > > > @@ -0,0 +1,136 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > > > +/*
> > > > > + * Devicetree with onboard devices for qemu_sbsa-ref for internal use only!
> > > > > + * DO NOT PASS TO THE OS!
> > > > > + *
> > > > > + * As QEMU provides only a minimal devicetree this one is merged with
> > > > > + * it and then fixed at runtime.
> > > > > + *
> > > > > + * Copyright 2024 9elements GmbH
> > > > > + */
> > > > > +#include "configs/qemu-sbsa.h"
> > > > > +
> > > > > +/dts-v1/;
> > > > > +
> > > > > +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> > > > > +
> > > > > +/ {
> > > > > +       #address-cells = <2>;
> > > > > +       #size-cells = <2>;
> > > > > +       interrupt-parent = <&intc>;
> > > > > +       compatible = "linux,sbsa-ref";
> > > > > +
> > > > > +       binman: binman {
> > > > > +               multiple-images;
> > > > > +       };
> > > > > +
> > > > > +       cpus {
> > > > > +               /* Filled by fdtdec_board_setup() */
> > > > > +       };
> > > > > +
> > > > > +       memory {
> > > > > +               /* Filled by fdtdec_board_setup() */
> > > > > +       };
> > > > > +
> > > > > +       soc {
> > > > > +               compatible = "simple-bus";
> > > > > +               #address-cells = <2>;
> > > > > +               #size-cells = <2>;
> > > > > +               ranges;
> > > > > +
> > > > > +               uart0 {
> > > > > +                       compatible = "arm,pl011";
> > > > > +                       status = "okay";
> > > > > +                       reg = <MAKE_PROP(SBSA_UART_BASE_ADDR)
> > > >
> > > > Can you use
> > > >
> > > > reg = /bits 64/ <0x60000000>
> > > >
> > > > instead?
> > > >
> > > > Same for those below.
> > >
> > > Isn't that less readable ?
> >
> > Which bit of it is less readable?
>
> Having hex spelled out rather than a macro that's clear what's being
> generated.

To my eye it seems odd to define a base address in a macro only to
have it used once in a devicetree. We don't do that elsewhere.

Breaking down the SBSA_UART_BASE_ADDR:

- this is in the uart0 node so obviously relates to the UART
- it is a reg property, so BASE_ADDR is obvious
- SBSA is the board name, which is in the filename, so don't really add anything

Normally where the devicetree needs a value defined, we put it in the
dt-bindings directory. But even then, we don't typically put addresses
there. It is just for cases where we need the code and the devicetree
to be in sync about a property value. With addresses, the code reads
them from the devicetree, so doesn't need to have a #define to access
them...in fact that would defeat the purpose.

If we did this sort of thing with other boards, we would have a heap
of binding files containing addresses that are only used in one place.
I just don't see the point.

However for SBSA_PCIE_MMIO_BASE_ADDR I see that it is used in the .asl
and the memory map, so it seems fair enough to define that, at least
unless/until we can refer to devicetree addresses in the .asl file.
Even with this one though, I would expect something like:

ranges = <0x02000000>, /bits/ 64 <SBSA_PCIE_MMIO_BASE_ADDR

SBSA_PCIE_MMIO_BASE_ADDR>;

But in this case I can see how a macro might be more convenient and
I'm not sure I have a strong opinion here.

>
> > But I very much doubt upstream would accept it with a macro. Other
> > 64-bit boards seem to use '/bits/ 64'.
>
> What upstream are you referring to here? I'm not sure what other project
> will want a device tree for the "no device tree only acpi" virtual
> reference platform.

It depends if they want to run U-Boot or not. U-Boot always needs a
devicetree, as you know. It cannot use ACPI tables to configure itself
and I would rather it doesn't start.

I don't actually see any reason why this devicetree could not be
upstreamed, except that QEMU actually creates a Linux devicetree right
now (on the ARM side) and takes no notice of what U-Boot needs... I
don't see any U-Boot patches from the maintainers, for example,
although I may have missed some. It seems very focussed on UEFI. I
would love that to change, as QEMU is widely used in U-Boot on ARM...

Regards,
Simon
