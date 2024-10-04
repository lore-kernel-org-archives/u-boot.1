Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2BDCFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 07:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591DC89061;
	Fri,  4 Oct 2024 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="N5FkbB4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE04C89049; Fri,  4 Oct 2024 09:20:14 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C835B89061
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso1585523276.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728026410; x=1728631210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvLS6yB3JVSVnVsDHFDvCoOafuqO8x8CL0+4VXeZqno=;
 b=N5FkbB4ABoSYSHBn1yC7HDvLdknJjkMyDPP4Lby37qbkTDQE9FQL4L6eqppV3ovhYU
 a2FMw1PSzy1fFgwfBnP6CfHYXoNiBKC8PwgQDWdMRCCr+tOdupa9FqVt3l8pOjBSYycA
 BCzrO2DMiERU8nDZVsh/8aX5bwJa56rfTMDqNWptZgezBiBaeAVts/2VS/kqMIWNs7HM
 W4TLwZ4v+1FS++QiQ/OeQdRz/h+GvamEuq1vE0ZRfdI0RgwHOHhu8MPTr1WAh4bj8N5w
 t9hBpYWWP4oRkWRCYqEBvhpZKgwiZxcDrcTppG58r/bfMbqCVBSJk1W1JBKSC343vSi9
 e/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728026410; x=1728631210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvLS6yB3JVSVnVsDHFDvCoOafuqO8x8CL0+4VXeZqno=;
 b=A8hjLCX3g/X5hxnAvyOPsWD3DyNfehBJDO6uV1J3iU5bB7M4optjOj5s3fxLnln99Z
 eBch704ntfCpo97gYH25zNbavmIlAovHvUgC7aqbzV1GRRFFnN23QXVJxsMKCSacdpmS
 gfGpSBeeWONsnq4TFpv0mm5DcflqxJjA6tFXdzauRwZG3P7tvLtBCbxx3YK+I2OCTfqw
 4OfYyKOPxPSk/sNknxxe9eDsBYVoM70JrF/69CgSP1yGdaIP1C32pTznys5lf+/LEP7B
 dxuyoimn4GgvwFva6bW3rzyp8oy0IJ08v/UPcx6iw/DsD1XtKmWHbh+OyOLeNYkmdtd2
 Eh3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcu8z5pT2hX6xhUoSsi/tmpVqI30iACrnagBEa/6Ki/S7D3VJCohJYgjsSyfKWDcwBeGvzzjk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl2y+4Zm+kYgrJ4Diw1djd3Bs7kfm+Uu0xNoi1kL6IqF1U4kNh
 Hil78dWyIDDBkPRhzvdftge/d8DxtTiLIoB2T2QQlh49jNJ/hHFrb6CiaYoS6OstOsrbYSPBHup
 DgQ8po/xJpGG374M93wIF6f60xa1Elu9UcTX/PA==
X-Google-Smtp-Source: AGHT+IEk5mpfDSxxyOJxGCi/D+zlFPgR3yiF/iC/xcD6pzeIkqjPE4TuzqcdYpbxuTMfEph2K2qep4w2uo9kAsOOScY=
X-Received: by 2002:a05:6902:100e:b0:e1d:12aa:cf7c with SMTP id
 3f1490d57ef6-e2893a67908mr1202666276.43.1728026410596; Fri, 04 Oct 2024
 00:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
In-Reply-To: <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Fri, 4 Oct 2024 09:19:59 +0200
Message-ID: <CALNFmy0omkVm427057LMeazuyeBBkx980q5_ejWv1+6ZQDLKqg@mail.gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Simon,
On Thu, Oct 3, 2024 at 3:50=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Tom,
>
> On Wed, 2 Oct 2024 at 19:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 02, 2024 at 04:55:34PM -0600, Simon Glass wrote:
> > > Hi Patrick,
> > >
> > > On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > > >
> > > > Unlike other Arm based platforms the machine only provides a minima=
l
> > > > FDT that contains number of CPUs, ammount of memory and machine-ver=
sion.
> > > > The boot firmware has to provide ACPI tables to the OS.
> > > > Due to this design a full DTB is added here as well that allows U-B=
oot's
> > > > driver to properly function. The DTB is appended at the end of the =
U-Boot
> > > > image and will be merged with the QEMU provided DTB.
> > > >
> > > > In addition provide documentation how to use, enable binman to fabr=
icate both
> > > > ROMs that are required to boot and add ACPI tables to make it full =
compatible
> > > > to the EDK2 reference implementation.
> > > >
> > > > The board was tested using Fedora 40 Aarch64 Workstation. It's able
> > > > to boot from USB and AHCI or network.
> > > >
> > > > Tested and found working:
> > > > - serial
> > > > - PCI
> > > > - xHCI
> > > > - Bochs display
> > > > - AHCI
> > > > - network using e1000e
> > > > - CPU init
> > > > - Booting Fedora 40
> > > >
> > > > 1: Server Base System Architecture (SBSA)
> > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changelog v3:
> > > > - Add GIC and GIC-ITS to devicetree
> > > > - Select GICv3 driver
> > > > - Drop acpi_fill_madt and use driver model instead
> > > > Changelog v4:
> > > > - Drop CPU platform code
> > > > - Enhance the DT to allow MADT generation from DT
> > > > Changelog v5:
> > > > - Add full DT and place it at the end of U-Boot
> > > > - Merge DT with QEMU's DT
> > > > - Drop DT generation code
> > > > - Fix flash region length
> > > > - Drop enable_caches()
> > > > - Support platforms that do not pass FDT in x0
> > > > Changelog v6:
> > > > - Update header order
> > > > - Drop pad-byte from DT
> > > > - select BINMAN_FDT
> > > > - select E1000_NO_NVM
> > > > - drop config.h include
> > > > - drop a few CFG_ defines that were used for SPL
> > > >
> > > > ---
> > > >  arch/arm/Kconfig                            |   3 +-
> > > >  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
> > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > >  board/emulation/qemu-sbsa/Kconfig           |  57 +++
> > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > >  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
> > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++=
++++
> > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > >  board/emulation/qemu-sbsa/smc.c             |  71 +++
> > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > >  doc/board/emulation/index.rst               |   1 +
> > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > >  include/configs/qemu-sbsa.h                 |  95 ++++
> > > >  19 files changed, 1605 insertions(+), 7 deletions(-)
> > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > >  create mode 100644 include/configs/qemu-sbsa.h
> > >
> > > With the tweaks below:
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > [..]
> > >
> > > > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dt=
s
> > > > new file mode 100644
> > > > index 0000000000..f743ea3863
> > > > --- /dev/null
> > > > +++ b/arch/arm/dts/qemu-sbsa.dts
> > > > @@ -0,0 +1,136 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > > +/*
> > > > + * Devicetree with onboard devices for qemu_sbsa-ref for internal =
use only!
> > > > + * DO NOT PASS TO THE OS!
> > > > + *
> > > > + * As QEMU provides only a minimal devicetree this one is merged w=
ith
> > > > + * it and then fixed at runtime.
> > > > + *
> > > > + * Copyright 2024 9elements GmbH
> > > > + */
> > > > +#include "configs/qemu-sbsa.h"
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> > > > +
> > > > +/ {
> > > > +       #address-cells =3D <2>;
> > > > +       #size-cells =3D <2>;
> > > > +       interrupt-parent =3D <&intc>;
> > > > +       compatible =3D "linux,sbsa-ref";
> > > > +
> > > > +       binman: binman {
> > > > +               multiple-images;
> > > > +       };
> > > > +
> > > > +       cpus {
> > > > +               /* Filled by fdtdec_board_setup() */
> > > > +       };
> > > > +
> > > > +       memory {
> > > > +               /* Filled by fdtdec_board_setup() */
> > > > +       };
> > > > +
> > > > +       soc {
> > > > +               compatible =3D "simple-bus";
> > > > +               #address-cells =3D <2>;
> > > > +               #size-cells =3D <2>;
> > > > +               ranges;
> > > > +
> > > > +               uart0 {
> > > > +                       compatible =3D "arm,pl011";
> > > > +                       status =3D "okay";
> > > > +                       reg =3D <MAKE_PROP(SBSA_UART_BASE_ADDR)
> > >
> > > Can you use
> > >
> > > reg =3D /bits 64/ <0x60000000>
> > >
> > > instead?
> > >
> > > Same for those below.
> >
> > Isn't that less readable ?
>
> Which bit of it is less readable?
>
> But I very much doubt upstream would accept it with a macro. Other
> 64-bit boards seem to use '/bits/ 64'.
I wasn't aware of that. Thanks will use it instead.


>
> Regards,
> SImon
