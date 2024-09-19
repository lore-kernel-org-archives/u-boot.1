Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB9ECF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4CE891BD;
	Thu, 19 Sep 2024 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nYthKQqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5961891DC; Thu, 19 Sep 2024 16:10:30 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419F78919B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d8a744aa9bso667016a91.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755027; x=1727359827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9iC+lU558Y47tGaycAM/ORyk9CNgkL4C7wB+Vy+lTM=;
 b=nYthKQqEHaUBLOfDnTIhc8pw37prVejLX2bkivBu28/+oHmr+/ziD5l5X2Ayj6LpRl
 8Wli9BxLHKzRYDWZTCy2CggXt84eEtf5AMabrLfiiI5neLs8aR9hS1XsbtfV54Ry7giS
 bvp7m1gBN4FR7E5LMVJCmFPMEUs4SS27u3Vhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755027; x=1727359827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9iC+lU558Y47tGaycAM/ORyk9CNgkL4C7wB+Vy+lTM=;
 b=ZgmtQHxjjtbnmYltvjUlkv5WGo2o2zFbIjBO3xo9OwAsS8JT0XGgG8pSJEdxGisgkl
 mFLzhY/XMrMJrAMOAK2oNANd5pq5IsUd/Ft0RhbyhX4EwgAdCQlsUO270Aek/7Mfxo4D
 CdWXKrRn5BUABDsiUK8PPl+ZqooRlSfXj0vUEqWMy1clzP6O8dl3bS03UB14qIzhqddK
 1a7pS9Gd2tosGbISlvGfeBQglB6x311JUre4Xd3iNsZpWvvHHgU5eDf2USq9cvFHIEGg
 F8L29XEn/nXRbsJQLORHP9eUkENyoYA4lE/OG9MLzcTwg6mttJMcfm5B4SChjook25Tp
 MGbQ==
X-Gm-Message-State: AOJu0Ywz4P1QC620Gr77WLlMNudfpNgNfTt1bQXa8+me9KDrscVe3wSV
 C0rnooDz5WV5fXOY9MTKgzYqyl7KDh1J2Ga69n/eYPHhv901y2jCvf2BYeBwEwN8tS4U3NA8GXm
 zERltfZzXU3uhtsrDTRcfK7jH/ockfhDPzZqf
X-Google-Smtp-Source: AGHT+IHGJcdDRL2IDp6z0qlHZR0LSKzXepIfTd/NYRnsC2oO7H78f7w50j1FSUGEldzm60p7E1oiHCpptAZIiKswX7I=
X-Received: by 2002:a17:90a:c784:b0:2c8:e888:26a2 with SMTP id
 98e67ed59e1d1-2dbb9df174dmr26686099a91.13.1726755026750; Thu, 19 Sep 2024
 07:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
 <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
 <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
In-Reply-To: <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:10 +0200
Message-ID: <CAFLszTi4Jf2QZZqWd2pA35J1HPEZay=tkbbs94_eyFLJMuYOdA@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
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

Hi Patrick,

On Wed, 18 Sept 2024 at 08:29, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Patrick,
> > > >
> > > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > > > >
> > > > > Unlike other Arm based platforms the machine only provides a mini=
mal
> > > > > FDT that contains number of CPUs, ammount of memory and machine-v=
ersion.
> > > > > The boot firmware has to provide ACPI tables to the OS.
> > > > >
> > > > > Add a minimal amount of devicetree nodes to make the board useabl=
e within
> > > > > U-Boot, provide documentation how to use, enable binman to fabric=
ate both
> > > > > ROMs that are required to boot and add ACPI tables to make it ful=
l compatible
> > > > > to the EDK2 reference implementation.
> > > > >
> > > > > The board was tested using Fedora 40 Aarch64 Workstation. It's ab=
le
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
> > > > >
> > > > > ---
> > > > >  arch/arm/Kconfig                            |   1 +
> > > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++++++
> > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++=
++++++
> > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++++++++++++++=
+++++
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > >  doc/board/emulation/index.rst               |   1 +
> > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > >  include/configs/qemu-sbsa.h                 |  98 ++++
> > > > >  19 files changed, 1734 insertions(+), 6 deletions(-)
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
> > > > Wow there is a lot in this patch!
> > > >
> > > > I don't think this should be in a separate subdir, just using
> > > > board/emulation/qemu-arm should be OK?
> > > Why would it share the code base with qemu-arm, as it's a completely
> > > different board?
> >
> > Perhaps I misunderstand this...what kind of board is it? How do you
> > run qemu for this board?
> >
> For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm you use -machin=
e virt.
>
> Both can use a cortex-a57 as CPU, but that's all those boards share. They=
 have a
> different memory layout, virt provides a complete FDT, while sbsa-ref doe=
sn't.
> sbsa-ref needs an Arm-TF and nonsecure boot firmware, while virt works
> without a firmware.

OK I see

>
> > >
> > > >
> > > > I see you are setting plat data in the board file...is there not a =
CPU
> > > > driver which can read it from the devicetree or set it based on the
> > > > compatible string?
> > > The CPU driver could read the data from devicetree, but that would re=
quire a new
> > > DT binding. Is that the preferred method over using plat data?
> >
> > It is fine to use plat data...but it should be set up in the driver
> > where possible. In this case if you don't have a binding you can check
> > the compatible string of the device (or even the root
> > compatible-string) and add your plat data if it matches.
>
> I was able to parse everything from the DT, except for PMU IRQs. Those
> aren't needed to
> boot the platform and can be added later on.
> Will send out a new revision soon.

OK

>
> >
> >
> > >
> > > >
> > > > For FDT fixup, can you please use the event and the ofnode interfac=
e?
> > > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.
>
> It looks like EVT_FT_FIXUP is run rather late in the bootflow, used to
> updated the FDT for OS usage,
> but it must be run early to update the minimal FDT passed by QEMU and
> add the missing nodes
> for U-Boot drivers.

If the QEMU FDT is not suitable, shouldn't we use the U-Boot/Linux
one? Do we have to use the one passed in by QEMU?

Regards,
Simon
