Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8021CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D6788DB8;
	Thu,  3 Oct 2024 16:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFXPSbzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D4A88DCF; Thu,  3 Oct 2024 16:44:03 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE7388CD9
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso95482585a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727966634; x=1728571434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SM6bhybhlUos1oUayuZxd/b/lkkpuL4HcrOm7XRUMTo=;
 b=RFXPSbzWx08bBmSzKqI319n/DObeh++zydogxt7qwX68L9dCyzVXz/W+39Tr2+DcJm
 ZvFHN7O7jgOFlavK4p9eJXvuzYDqhVkaArVJkhus/8E46IPugMe7zwZQcExJ3jc6duxP
 xrcgG0/vS9jyOQHzZIQ5HrSqMoPH9aSPdZ9Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727966634; x=1728571434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM6bhybhlUos1oUayuZxd/b/lkkpuL4HcrOm7XRUMTo=;
 b=BUpYkNX1lAwlQvTlDzTaokQNGZRBjLNfT4XQ2WKnjFPfRR00dgYyGOR0b6aZ1Oc/Ol
 E9wbK8wRY+zneic1Sc1nIjOpkIau9EUFkqY1e3bXN3CQ6nlt6WEorFAgWWzsxl7oPpjD
 avqT+xOeYenNp7h1n7aQpEY4fwsQ/QwrtEKmmy15ak4xrw3CBpzCY5q2SaoFz+XfTFhR
 3m2Ic+bY2Kb+Ql/q5nDwqrNAvq1wkMfxZTc7DQMQeWnuJdG8Jid/YFr66No3lLfwAa2l
 suyXFQv69GbSlPMdcgq+rpLw4Sd4wJsu/8zPskNqUSGEkJlsiu0+OI17M7jhio5zydkt
 BgZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqSff+YTeViO0isDaOL5VKOCTASWdt342qowg5WpAomp3aUgnjHZ95DmOPy46HZAYIHEn/1iI=@lists.denx.de
X-Gm-Message-State: AOJu0YzgxgccxshePrUFsSDNABajOApRow+mPOsm9Q48/P7zVlswP5GA
 RFabceJO0Qhs39EQ0PPbcyZgNli2rQrZNL0tUrITE+fdaqyjRr32z1fOUe7MI/I=
X-Google-Smtp-Source: AGHT+IFxYCT8k7Es8p9ohYJN+Z4JaaoJ9XjijGivI29UZUnzaPghJrcu5Nb/3iCwoRRsbnYRHrSk1A==
X-Received: by 2002:a05:620a:17a1:b0:7a9:b80b:81e with SMTP id
 af79cd13be357-7ae67e3435bmr559102785a.10.1727966634335; 
 Thu, 03 Oct 2024 07:43:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b29f068sm56270285a.23.2024.10.03.07.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:43:53 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:43:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
Message-ID: <20241003144351.GU4737@bill-the-cat>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MSDw9Zuew2jQu3rD"
Content-Disposition: inline
In-Reply-To: <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--MSDw9Zuew2jQu3rD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 07:50:45AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
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
> > > > Unlike other Arm based platforms the machine only provides a minimal
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
> > > > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
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
>=20
> Which bit of it is less readable?

Having hex spelled out rather than a macro that's clear what's being
generated.

> But I very much doubt upstream would accept it with a macro. Other
> 64-bit boards seem to use '/bits/ 64'.

What upstream are you referring to here? I'm not sure what other project
will want a device tree for the "no device tree only acpi" virtual
reference platform.

--=20
Tom

--MSDw9Zuew2jQu3rD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb+racACgkQFHw5/5Y0
tywgkQv/acK3vL2EWbcwrJN4VJ32gxTZvhu22RoTp1Mg4lugtoIRuyl8/TpUk+Ox
X6MpAjbWqUaDqSl8mOZicHvPLg5N5OJrC6zDpdPPLcNn5wXBB2t5rRQKjqRSTbAF
qq/M0rDChaXAWin2piQ3C5ZZQZ61eXyLSWWHJVGceIIpjGd0MsqAMcJBGP2A+9Wq
iYmMKCcx9ERYQPtU/APXeoGyxagviY2g7FphSgWctCf93M9UTO0YMXRnSAFUNQkr
EhVeTDfJbiQYs0u2bG4bFTf0GD7aXQOXFdocNtg8Fn2QS/qOmeKIajYbxYG0Oyjg
zvitzr13hHR1Zs5LH9bh11xPJGveBwt4kCRfEXCiZKrX1CqjEYw6ewC7xc0Ug7E+
X3AnsjUDPRZxiM/IQxGT2wMlvfB5FrAvzv1gWJ8j4PhYxzU46Ru0E3L0kYZvIbS1
+XbW2XyE9EOWtc8Re4tA9uaXREpC9w+EWR+kw4z7G6yQSNGOtrnan+5BDWL546gJ
TAe8Jh/X
=UXuX
-----END PGP SIGNATURE-----

--MSDw9Zuew2jQu3rD--
