Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAA9CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 13:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A12A88B0B;
	Thu,  3 Oct 2024 15:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c39c+3ML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C05188DB2; Thu,  3 Oct 2024 15:51:01 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A03D885B3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 15:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9acc6f22dso98372485a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727963457; x=1728568257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wRxV7099VlVV4RWU9tLwhVcJdMqu26Xnc0FCifhsEb4=;
 b=c39c+3MLJFqJQGeNzyltEdYhAgPCXdKfBkZVtW4Plr7FV1Q5j26tRIbdKzJnPE+Bf5
 pVx1y1+/mBkwmoYAvprQrVNIdy8guZJRXuMC0pnXh3PWHlOB6LIE7CAmPm83nN7liOyc
 4OEDGeNnkkiBXgdH1FaxGifjVqOK/KHZOfqEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727963457; x=1728568257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRxV7099VlVV4RWU9tLwhVcJdMqu26Xnc0FCifhsEb4=;
 b=YdiBZrt7BSWmlPESyF2Dv1HsOGfgPThZjZVPV83mmKTieunVcvMiqog2rs5tLioXZr
 Els3e2Lhi881sw4XGYN+LLsGpgGnntvDAYIzwRTkqf+DU4Kma9CbpJrlbMTdm28G0svd
 YyZleSlK4DCFcR9gXq7GNsmvLwabxL9QkNfLuII6uvRt15LGMvlA3h2WcEG+x2ni1rd5
 Ho4FpdoGdn5AUzQcJ8rsPu9KkVYDG56DobM6eynCTzMop8KnnUuQLFmHI2k4lCVzAlTr
 i1+E1zhci2Zkv1gHcHRnsUQwhCSKU4X5RIVDcfeeqJWsdS1+ZY2uNZcKAEWjO51I7/lM
 Db6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK1Us9LDvu16kHblTfyIg9kZCbyVhVYIEpP+z6q37UjU78LwJjf9Dr0aZr5MjtBTcT25IoUY0=@lists.denx.de
X-Gm-Message-State: AOJu0YxflTxGThBsco+vaUgZgW05IPBOuPAQXeR3mGVmcZzQyXPQmgCq
 6v57TBO5mjn6grhymM+XM9cjargpiFXfn18RgvOxjc52aYqiatZHr+nHbMqsfLMssSNY7LxSviW
 lpR7oVpnMf0S+SbPs5ofzHAxrpSNncUTMP3rbWJ0CFwyCrng=
X-Google-Smtp-Source: AGHT+IFnV9n+CbMQvl+28zn2NCxftKQsmWt+nWohElrJWdE0r08QtFGqJL+xReHxb0QzciecH7X3iRMqm8e2SwlHuJ4=
X-Received: by 2002:a05:6214:398f:b0:6cb:2fa7:48cd with SMTP id
 6a1803df08f44-6cb81a48e95mr87714616d6.36.1727963455877; Thu, 03 Oct 2024
 06:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
In-Reply-To: <20241003013516.GR4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 07:50:45 -0600
Message-ID: <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
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

On Wed, 2 Oct 2024 at 19:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 02, 2024 at 04:55:34PM -0600, Simon Glass wrote:
> > Hi Patrick,
> >
> > On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > >
> > > Unlike other Arm based platforms the machine only provides a minimal
> > > FDT that contains number of CPUs, ammount of memory and machine-version.
> > > The boot firmware has to provide ACPI tables to the OS.
> > > Due to this design a full DTB is added here as well that allows U-Boot's
> > > driver to properly function. The DTB is appended at the end of the U-Boot
> > > image and will be merged with the QEMU provided DTB.
> > >
> > > In addition provide documentation how to use, enable binman to fabricate both
> > > ROMs that are required to boot and add ACPI tables to make it full compatible
> > > to the EDK2 reference implementation.
> > >
> > > The board was tested using Fedora 40 Aarch64 Workstation. It's able
> > > to boot from USB and AHCI or network.
> > >
> > > Tested and found working:
> > > - serial
> > > - PCI
> > > - xHCI
> > > - Bochs display
> > > - AHCI
> > > - network using e1000e
> > > - CPU init
> > > - Booting Fedora 40
> > >
> > > 1: Server Base System Architecture (SBSA)
> > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changelog v3:
> > > - Add GIC and GIC-ITS to devicetree
> > > - Select GICv3 driver
> > > - Drop acpi_fill_madt and use driver model instead
> > > Changelog v4:
> > > - Drop CPU platform code
> > > - Enhance the DT to allow MADT generation from DT
> > > Changelog v5:
> > > - Add full DT and place it at the end of U-Boot
> > > - Merge DT with QEMU's DT
> > > - Drop DT generation code
> > > - Fix flash region length
> > > - Drop enable_caches()
> > > - Support platforms that do not pass FDT in x0
> > > Changelog v6:
> > > - Update header order
> > > - Drop pad-byte from DT
> > > - select BINMAN_FDT
> > > - select E1000_NO_NVM
> > > - drop config.h include
> > > - drop a few CFG_ defines that were used for SPL
> > >
> > > ---
> > >  arch/arm/Kconfig                            |   3 +-
> > >  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
> > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > >  board/emulation/qemu-sbsa/Kconfig           |  57 +++
> > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > >  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
> > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
> > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > >  board/emulation/qemu-sbsa/smc.c             |  71 +++
> > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > >  doc/board/emulation/index.rst               |   1 +
> > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > >  doc/develop/driver-model/virtio.rst         |   1 +
> > >  include/configs/qemu-sbsa.h                 |  95 ++++
> > >  19 files changed, 1605 insertions(+), 7 deletions(-)
> > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > >  create mode 100644 include/configs/qemu-sbsa.h
> >
> > With the tweaks below:
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > [..]
> >
> > > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
> > > new file mode 100644
> > > index 0000000000..f743ea3863
> > > --- /dev/null
> > > +++ b/arch/arm/dts/qemu-sbsa.dts
> > > @@ -0,0 +1,136 @@
> > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > +/*
> > > + * Devicetree with onboard devices for qemu_sbsa-ref for internal use only!
> > > + * DO NOT PASS TO THE OS!
> > > + *
> > > + * As QEMU provides only a minimal devicetree this one is merged with
> > > + * it and then fixed at runtime.
> > > + *
> > > + * Copyright 2024 9elements GmbH
> > > + */
> > > +#include "configs/qemu-sbsa.h"
> > > +
> > > +/dts-v1/;
> > > +
> > > +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> > > +
> > > +/ {
> > > +       #address-cells = <2>;
> > > +       #size-cells = <2>;
> > > +       interrupt-parent = <&intc>;
> > > +       compatible = "linux,sbsa-ref";
> > > +
> > > +       binman: binman {
> > > +               multiple-images;
> > > +       };
> > > +
> > > +       cpus {
> > > +               /* Filled by fdtdec_board_setup() */
> > > +       };
> > > +
> > > +       memory {
> > > +               /* Filled by fdtdec_board_setup() */
> > > +       };
> > > +
> > > +       soc {
> > > +               compatible = "simple-bus";
> > > +               #address-cells = <2>;
> > > +               #size-cells = <2>;
> > > +               ranges;
> > > +
> > > +               uart0 {
> > > +                       compatible = "arm,pl011";
> > > +                       status = "okay";
> > > +                       reg = <MAKE_PROP(SBSA_UART_BASE_ADDR)
> >
> > Can you use
> >
> > reg = /bits 64/ <0x60000000>
> >
> > instead?
> >
> > Same for those below.
>
> Isn't that less readable ?

Which bit of it is less readable?

But I very much doubt upstream would accept it with a macro. Other
64-bit boards seem to use '/bits/ 64'.

Regards,
SImon
