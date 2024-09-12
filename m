Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAE0EE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C55C88DC7;
	Thu, 12 Sep 2024 08:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Vbe7fPJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E8C88DC7; Thu, 12 Sep 2024 08:23:54 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE7388DD7
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e1cf1a4865aso519705276.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726122231; x=1726727031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XnyW2LqhAjxC3L6e3RXZg81/5pS/zHv2GGCn5ECfdA=;
 b=Vbe7fPJYOPBD6gMGeslap5IaTEoF9YhsxT1IBbGqtMxCCHjd1ljzB9Jiyg3myPoYOd
 0IST1eefMyPk2fWWaxmU6ZtnC1SonjQ9vBS9mIHKhPEiD92qO3RxJ+mrL9VzaOmCqo9u
 NVDjFDTUL4iponrNBJeAu/54Qq6y/9j95gxyby0QzqRQ+sH3sLEWvM9k/oSQawrjUNet
 Qt3C6ZL6gucwNJ58xgxPdRzhh4KYVdRBNpMLLKUqtH6tV5PP2iMpkKt+0a9q5KUa5SVB
 dmbddesPnOyEIwfvUPQ0uRaLGb0Nz4duqVzSQNCM095PzafHaKJ6PUU4HDHCsQJAcsJF
 wiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726122231; x=1726727031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XnyW2LqhAjxC3L6e3RXZg81/5pS/zHv2GGCn5ECfdA=;
 b=WK6ORWkxSEaCRBjTPeeeYLf22ZzBSUnsJQ8DoHkyrvsFGHuqytng3edfbq3ExAS6Tr
 ly0hP4RtDO7Csf2xGx2JL4pcN4UKJnM8xFKGC02cuC0NgzKkB7RHDliTMiX3s4s7p+so
 nNkcZjF3TLlXbqIEo0hVPAbzQEuc6JZpKqTgNwU3l+hXFuKAqblik97IlQLF1mdNXHZU
 gnm8D54OTJlOX4RAHAYz/5xrA8eXb3H/YmyyB7bAZHNZr3MVjT4ke07d+UZ5dHVC85FY
 DJAq2CTt6G01uq91Kb8cuKnE/OtcLDQ7CO4uHIVG4cOKMfbyTqPWfyu7WkP9IhNmEh57
 omdA==
X-Gm-Message-State: AOJu0YyJYkep2U59AahzRpNnBACDGoMoTX0gdrd/KRwBxVrNAi2l3+E6
 gPGbZe2OaS4anU06hfLXnqP7bMvkTP0nWslDLqhNDeTkR5q6UPci2EZgwtBXw83Zqyn58J3ah2S
 Uh1Fxp8PpbgjdEkfxZck1P5NKRffUvGQYEHxNNcDoD4t8X4R7
X-Google-Smtp-Source: AGHT+IHMxdHNGt1V/z4tFrLWUpL6BH3WW0knU1Aid0Dwo7G+FVcvw3fvWmNrROEmNs/RLDf5b5KAO11VA5hY8V5xlWc=
X-Received: by 2002:a05:6902:e0a:b0:e1a:a580:e1dc with SMTP id
 3f1490d57ef6-e1d9dc787d8mr1359264276.57.1726122231116; Wed, 11 Sep 2024
 23:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
In-Reply-To: <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:23:40 +0200
Message-ID: <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Simon Glass <sjg@chromium.org>
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

On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> >
> > Unlike other Arm based platforms the machine only provides a minimal
> > FDT that contains number of CPUs, ammount of memory and machine-version=
.
> > The boot firmware has to provide ACPI tables to the OS.
> >
> > Add a minimal amount of devicetree nodes to make the board useable with=
in
> > U-Boot, provide documentation how to use, enable binman to fabricate bo=
th
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
> >
> > ---
> >  arch/arm/Kconfig                            |   1 +
> >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> >  board/emulation/qemu-sbsa/Makefile          |   8 +
> >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++++++
> >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 +++++++++++++++++++
> >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> >  configs/qemu-arm-sbsa_defconfig             |  10 +
> >  doc/board/emulation/index.rst               |   1 +
> >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> >  doc/develop/driver-model/virtio.rst         |   1 +
> >  include/configs/qemu-sbsa.h                 |  98 ++++
> >  19 files changed, 1734 insertions(+), 6 deletions(-)
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
>
> Wow there is a lot in this patch!
>
> I don't think this should be in a separate subdir, just using
> board/emulation/qemu-arm should be OK?
Why would it share the code base with qemu-arm, as it's a completely
different board?

>
> I see you are setting plat data in the board file...is there not a CPU
> driver which can read it from the devicetree or set it based on the
> compatible string?
The CPU driver could read the data from devicetree, but that would require =
a new
DT binding. Is that the preferred method over using plat data?

>
> For FDT fixup, can you please use the event and the ofnode interface?
> See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.
>
> Regards,
> Simon
