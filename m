Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9946DCF854E
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 01:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48D488E18;
	Thu,  3 Oct 2024 03:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAYfB7+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BC488E88; Thu,  3 Oct 2024 03:35:25 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F3988DB7
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 03:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2a6d3144so2422716d6.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727919322; x=1728524122; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g0Nyvjpxo3FJBcVAJtR/Gw3cWC4t1luSndB4/lAzod4=;
 b=FAYfB7+ZjgeYySQLDZgyJCfISbdew90julb8Z8CnooVdV4OSzXFHvtecLdQaoD/E+V
 ItJP5LeI6h1tkzSODCnKj5kHjxUD8SLt+nLj6OU6BKwzxBV1pwgzF2kmGkgWNPLthy5s
 fyLHM9qKTWHb8GiGbGzkp2oF+jZM9BZ1icdyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727919322; x=1728524122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0Nyvjpxo3FJBcVAJtR/Gw3cWC4t1luSndB4/lAzod4=;
 b=xR0yhvZH9wVQZWBp3vUiY1/D0F8f1mqCGcy1Ya7BQCMK482MlnCjTIxG3C04l9OZx1
 i25GRnTmx7sUSfjTb7xFIhdYAWObz0IDCyOTywYvMopvbD8/p6M0hPqgYxXrDv6oxShL
 j24iA4Wj531PAiM8eQfSccjIuqSaPDNAigHVB9uxUeRDPxkBiVd3BEBuOCSq7WqeFIVc
 UbZnr51lqrckLo6rk1S2/Zsrq8h14gv3NENeUHfJIYbIpn7A1pfIRGih9nnsG3CPgSYY
 dYTvMLNIDXyK6x8nqv8KvWM9I/YxJWRor4orb9/Lwr4WxWqK0pK+i+QoG6ihMD4ZMbhz
 jTRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYglsbhyJwqzYFOiFVS75xCfnC3+PXFORzfYlx+0+jczE92izvxS+hyJHl935DYC/bFjydWc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8Zoed6+UTWk5A/zxOiN1PTj4p9qayyR7LuCc5PLTTmOK8ywbQ
 rZ0VSGuRs+tRZZaVGUC3jQYhmbQx3PSLzAdBDQx/bJ28vzXc8Qpz7un6LeFBz8Q=
X-Google-Smtp-Source: AGHT+IG+yfNcDvPh5txv01p+r+kl/LnBh/G8Ac/JIRXBzMk3JcX8Uv4pDK2F7Nw4MaOLtuAdQcXQ0A==
X-Received: by 2002:a05:6214:2c08:b0:6cb:7107:a3e6 with SMTP id
 6a1803df08f44-6cb81a4414emr75785456d6.34.1727919321939; 
 Wed, 02 Oct 2024 18:35:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb9381f2a8sm1085936d6.138.2024.10.02.18.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 18:35:20 -0700 (PDT)
Date: Wed, 2 Oct 2024 19:35:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
Message-ID: <20241003013516.GR4737@bill-the-cat>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWNqZVJ7+CYguupf"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
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


--TWNqZVJ7+CYguupf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 04:55:34PM -0600, Simon Glass wrote:
> Hi Patrick,
>=20
> On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> >
> > Unlike other Arm based platforms the machine only provides a minimal
> > FDT that contains number of CPUs, ammount of memory and machine-version.
> > The boot firmware has to provide ACPI tables to the OS.
> > Due to this design a full DTB is added here as well that allows U-Boot's
> > driver to properly function. The DTB is appended at the end of the U-Bo=
ot
> > image and will be merged with the QEMU provided DTB.
> >
> > In addition provide documentation how to use, enable binman to fabricat=
e both
> > ROMs that are required to boot and add ACPI tables to make it full comp=
atible
> > to the EDK2 reference implementation.
> >
> > The board was tested using Fedora 40 Aarch64 Workstation. It's able
> > to boot from USB and AHCI or network.
> >
> > Tested and found working:
> > - serial
> > - PCI
> > - xHCI
> > - Bochs display
> > - AHCI
> > - network using e1000e
> > - CPU init
> > - Booting Fedora 40
> >
> > 1: Server Base System Architecture (SBSA)
> > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v3:
> > - Add GIC and GIC-ITS to devicetree
> > - Select GICv3 driver
> > - Drop acpi_fill_madt and use driver model instead
> > Changelog v4:
> > - Drop CPU platform code
> > - Enhance the DT to allow MADT generation from DT
> > Changelog v5:
> > - Add full DT and place it at the end of U-Boot
> > - Merge DT with QEMU's DT
> > - Drop DT generation code
> > - Fix flash region length
> > - Drop enable_caches()
> > - Support platforms that do not pass FDT in x0
> > Changelog v6:
> > - Update header order
> > - Drop pad-byte from DT
> > - select BINMAN_FDT
> > - select E1000_NO_NVM
> > - drop config.h include
> > - drop a few CFG_ defines that were used for SPL
> >
> > ---
> >  arch/arm/Kconfig                            |   3 +-
> >  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
> >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> >  board/emulation/qemu-sbsa/Kconfig           |  57 +++
> >  board/emulation/qemu-sbsa/Makefile          |   8 +
> >  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
> >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
> >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> >  board/emulation/qemu-sbsa/smc.c             |  71 +++
> >  configs/qemu-arm-sbsa_defconfig             |  10 +
> >  doc/board/emulation/index.rst               |   1 +
> >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> >  doc/develop/driver-model/virtio.rst         |   1 +
> >  include/configs/qemu-sbsa.h                 |  95 ++++
> >  19 files changed, 1605 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> >  create mode 100644 include/configs/qemu-sbsa.h
>=20
> With the tweaks below:
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> [..]
>=20
> > diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
> > new file mode 100644
> > index 0000000000..f743ea3863
> > --- /dev/null
> > +++ b/arch/arm/dts/qemu-sbsa.dts
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Devicetree with onboard devices for qemu_sbsa-ref for internal use =
only!
> > + * DO NOT PASS TO THE OS!
> > + *
> > + * As QEMU provides only a minimal devicetree this one is merged with
> > + * it and then fixed at runtime.
> > + *
> > + * Copyright 2024 9elements GmbH
> > + */
> > +#include "configs/qemu-sbsa.h"
> > +
> > +/dts-v1/;
> > +
> > +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> > +
> > +/ {
> > +       #address-cells =3D <2>;
> > +       #size-cells =3D <2>;
> > +       interrupt-parent =3D <&intc>;
> > +       compatible =3D "linux,sbsa-ref";
> > +
> > +       binman: binman {
> > +               multiple-images;
> > +       };
> > +
> > +       cpus {
> > +               /* Filled by fdtdec_board_setup() */
> > +       };
> > +
> > +       memory {
> > +               /* Filled by fdtdec_board_setup() */
> > +       };
> > +
> > +       soc {
> > +               compatible =3D "simple-bus";
> > +               #address-cells =3D <2>;
> > +               #size-cells =3D <2>;
> > +               ranges;
> > +
> > +               uart0 {
> > +                       compatible =3D "arm,pl011";
> > +                       status =3D "okay";
> > +                       reg =3D <MAKE_PROP(SBSA_UART_BASE_ADDR)
>=20
> Can you use
>=20
> reg =3D /bits 64/ <0x60000000>
>=20
> instead?
>=20
> Same for those below.

Isn't that less readable ?

--=20
Tom

--TWNqZVJ7+CYguupf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb99NAACgkQFHw5/5Y0
tyywmAv+IVpiW/f3pFwoaSuMQExjkvuMxX91AfBvNm7Q4fPFxbcycod8TCvNlWLG
8WnGLTYcI3Fxh/9GeV+/W620CkdZYcjcaCWzsGzK4/pUjppHuRbU5pA12i4o80O9
wv5K1DknWPKgveoa1LmVhNl5Pnwj8nPUfOZ8P879/bsJMe7Z+0qSq+7c0U95ItkF
VnN+QyRvkG+PwEzf1elLA+kZMJ7FhCkN9oKHfGGkpFdv3V9k1MKFRJNwD4pDvNSA
3eEWGAdEXfAvdA9Tt5YPLjjUi29cgxBRd7y5kntpnrSAmGXySKLOLc7iqA6bPrvK
KLIrSACIJCRiztPBsE6JFGukAN5ewPW8OTkDy8ANQse1qV1dkJHS4cGSvt8nIxIW
R3WG0iOGAHzvG1te6CzwYDqKQO0R6WHalrupBrFI5PQ5gz1nDwCgfmlvH0kt1x7W
VSmgDW0uPB9O014DpRNNglduKEfaV9RVB3txF0vzYDUf5ulPcBHcrH2OL9FWChJa
MzvBjRfO
=+xL3
-----END PGP SIGNATURE-----

--TWNqZVJ7+CYguupf--
