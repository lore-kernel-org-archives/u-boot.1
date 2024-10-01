Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE649CEACDC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1918920C;
	Tue,  1 Oct 2024 17:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDWs+kMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694838920C; Tue,  1 Oct 2024 17:05:33 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE868891C4
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 17:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a9aec89347so364768685a.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727795127; x=1728399927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M4lkiQhUTY0kkKJVU6piIBoGvs6qYLJ0RmKHkN9VsLE=;
 b=DDWs+kMdYsiMqbgZWnFrcpyymj/Xz2NAfVIdz+YDrNI5SgLGtnVSx1/gizoLDospQQ
 /VRm088Q8wMoA2CC4k7YbUYaBRf3LnsijGW6/1gfXviZKk2LbH2t4xrOXFlaahI3nQdD
 q1DYSnR2uvrrD7VQ154zvjZl9v4jJ/IAtJZ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795127; x=1728399927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4lkiQhUTY0kkKJVU6piIBoGvs6qYLJ0RmKHkN9VsLE=;
 b=j38qPQnuVf3tHGfPayoBUoomE7JUR6AMAbq++92cPQ5SvX7mf6rMedwc19veJzyLOi
 nM5Jv6W3hiRBMqVwMbOtEcwBq/KkKaotI1eFfS6PJp4vTHYCKUqeJNIbckOHcRADkYIP
 w0ul+30U72eZxdcNAnTv8jQ5pb9aVxqgJ5unIwTqnu4WAJ4Z7I+UGhZCNwij4sX7NcHc
 0MywpnkHsb6iOZqcOttEFWdL1gw+5/N8sEbuAYaaL3FHLghNcb40NitNZDTVpSe62Hq8
 PMFGjjUgDEcfdZ/9PN/U8WmkkGd/MtbvmkPdySMa6YwbBVNqrX/dLdm/CjJRleH/RkUq
 zGVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMc2KhTPstaxtIJdNUbKhdVJ0CbckRmouDOIRrQSvVDfkazUs5WF77lnu5bu0iDAFylbBTbng=@lists.denx.de
X-Gm-Message-State: AOJu0YyGYkSn4qAZn4TB2McrPvrKFqZUlMhJ9Y2oCjQ7ixPL2y11PFLO
 CGNx19bXBOatES5RGWUsS3wNihzF5qHgfd3l0rP8PHqtwoxOBxsSuWIxx+5jgs8=
X-Google-Smtp-Source: AGHT+IEhkNfu9S/HZdJSHxHiaF4o6SosNkBTQEiMoFjRDTXsb3SLZQRcGZr9YNS0C3FiHUV27yqtsg==
X-Received: by 2002:a05:620a:1aa0:b0:7a9:c0f2:86c9 with SMTP id
 af79cd13be357-7ae626acddbmr671785a.5.1727795126345; 
 Tue, 01 Oct 2024 08:05:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bc78csm517761285a.19.2024.10.01.08.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:05:25 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:05:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 25/36] board: emulation: Add QEMU sbsa support
Message-ID: <20241001150522.GF4737@bill-the-cat>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-26-patrick.rudolph@9elements.com>
 <CAFLszTgTJAVKb87HEaSCgNqBeC8ThrWS4F9=Q9CzanRAeCHHTw@mail.gmail.com>
 <CALNFmy3EGfWFuR7sR0CgdqTqa0OYyhgQVBJS1-TpWJWUnLW6zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WbbaSETbQvrinPXP"
Content-Disposition: inline
In-Reply-To: <CALNFmy3EGfWFuR7sR0CgdqTqa0OYyhgQVBJS1-TpWJWUnLW6zQ@mail.gmail.com>
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


--WbbaSETbQvrinPXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 12:49:41PM +0200, Patrick Rudolph wrote:
> On Thu, Sep 26, 2024 at 11:28=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Patrick,
> >
> > On Thu, 26 Sept 2024 at 10:03, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > >
> > > Unlike other Arm based platforms the machine only provides a minimal
> > > FDT that contains number of CPUs, ammount of memory and machine-versi=
on.
> > > The boot firmware has to provide ACPI tables to the OS.
> > > Due to this design a full DTB is added here as well that allows U-Boo=
t's
> > > driver to properly function. The DTB is appended at the end of the U-=
Boot
> > > image and will be merged with the QEMU provided DTB.
> > >
> > > In addition provide documentation how to use, enable binman to fabric=
ate both
> > > ROMs that are required to boot and add ACPI tables to make it full co=
mpatible
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
> > > ---
> > >  arch/arm/Kconfig                            |   3 +-
> > >  arch/arm/dts/qemu-sbsa.dts                  | 138 ++++++
> > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > >  board/emulation/qemu-sbsa/Kconfig           |  59 +++
> > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > >  board/emulation/qemu-sbsa/acpi.c            | 193 ++++++++
> > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++=
++
> > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 312 +++++++++++++
> > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > >  doc/board/emulation/index.rst               |   1 +
> > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > >  doc/develop/driver-model/virtio.rst         |   1 +
> > >  include/configs/qemu-sbsa.h                 | 104 +++++
> > >  19 files changed, 1621 insertions(+), 7 deletions(-)
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
> > Please check the header order throughout
> > E.g. board/emulation/qemu-sbsa/qemu-sbsa.c is still incorrect
> >
> > You should not need to include 'config.h' as kconfig is included by def=
ault?
> >
> > Do you need to add all the CFG items? Are they present in the devicetre=
e?
> What are CFG items?

He means literally "#define CFG_FOO	0xdeadbeef" type statements.

--=20
Tom

--WbbaSETbQvrinPXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8D68ACgkQFHw5/5Y0
tyxfCwwAgdRuJcZQ2AFwPH5vBM1LDQcrkN8dTPg5jdVG6q9sR35owboEpLfJprbY
uai2qtz4eotExXBg0O0xdbmCwW/izyqcRI073x1eIGem/OYk6ciXkdI2sADlsqNc
3yVOP6HemWwWTOnAuoa5owvOpKwsPEwy9ExdmhwRV8O9xXSfXij6d/iX802HVq2e
lJXBMDgNLuXWDtMTU0MUD+PRcag+r1knG4Id2q+Ww2HdsU7MDUbfqse24SNLnQyq
n4+4QEEJ5iQ6oNjI1nusTkxZAn833Otdgpk+WRQO9VcZ5I5h4Taz96RqF5OiHxWN
BkMBvr+94+8yuzMNdfn+Pd87bhbIfSHcZ2TVE8adN7flutyKhoLS20SXuxtLvOeZ
PRWqAoih+YGyu+evxNqKRNVHUsJeqMxJV8F97/BXiIdlmfga8yKN9TMyu3tBs33X
FPvu1RK5c7A5ky3Qbsi6OuUCiwFZWTMtpke34TOapxFdaiRV9zBcc4INKujf7w50
keqRnzoB
=5KAf
-----END PGP SIGNATURE-----

--WbbaSETbQvrinPXP--
