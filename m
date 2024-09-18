Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEB8C3ABCD
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482B488BB6;
	Wed, 18 Sep 2024 08:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QZ9rmUVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874D088E22; Wed, 18 Sep 2024 08:29:43 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F227580245
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e1f139b9767so3106189276.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726640980; x=1727245780; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dwgh0KpvcCdPlTo9dLZypNRfFoby6/tq9vTeoiH/CcU=;
 b=QZ9rmUVa2sGoC+R/1GKjkmVj7Rz66vzr7rBk9BXBsabgaCi5Mt3bA69BgzMrNtaG78
 U6jEp2ijNUaglqOBOiXD3O9xEG2Cpo23F6ejZSu+C2KdvqaIZxvLO4iy9eHe4qQ+89Jc
 kpqPwbI+5Ck4UPliW0l24DUIzcnTPN3+V40m2VwlXalL8/Wq+CycbJos6n9w5qfRDzhm
 eyLJJZyKOQ8qifpL0YKPfkERpv5ChdupD12eL9RqPgMjbwUIhAbGwvn3PCyICODYIei5
 DDVk5ACfnhfdUyCOzmi76sdui4Ng6DiE5WnJs1mTW8l93Zn/zV5DqR5tyKPUGLXn9bR3
 eVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726640980; x=1727245780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dwgh0KpvcCdPlTo9dLZypNRfFoby6/tq9vTeoiH/CcU=;
 b=sAv8nom0tj+NLNSPhvLlGhUKRTsNEYSE8OXn+Buol1PI6MA0tYmJfMTYw9YIMjU8Hq
 tElb+GU4vngVfhSfY1z95zPTmTjF6Q47UP5No9CPnUra0minBwQXn8cHYp6mm1BqQs+4
 t/Xiq1NggG9FuG7ZMXQAwOq54rcvscbefoOZv8QaPsGkepW3LlQ8ln7XQvqJ32l9fU6g
 o8JYet9OtCssd5Lb6OiUdp+2o8oX1PE7WWAc5YzV15KsDo6I+Dht0NMx0CiA+2lYUoOx
 syeVJBmVzVo8tFoWekTyVugdrj2MopiG1mpJWPGemiMvnEjQ0dHcE68YUnQcMeVg5bW7
 CM6g==
X-Gm-Message-State: AOJu0YzY7Gu+m1p8EOvSwFZ1fg+sn9RQg5/Vdpo7A0V0tNKhTfjyj0LL
 bB+weil8ibR7Nsa8Cp/BVdejA7EEeN45HjI8nP7W9hiGXcegn2YQFmeqyuJGwhb0AnkuUSJj2YG
 KqUdY3bETUx/C72K9s4CYkcPtB4uIsvBEtLvHnaj1Lfv1rbLQ
X-Google-Smtp-Source: AGHT+IH1f2wh0d9G4SLnscy49JZ7sW1btfeRabZg14osBFJgPdvoBT9KsLaSke1ItKJDBbCaE4bUZtIfeJ5pZldur/M=
X-Received: by 2002:a05:6902:1b05:b0:e1f:ee79:26ae with SMTP id
 3f1490d57ef6-e1fee79280cmr9014196276.51.1726640979783; Tue, 17 Sep 2024
 23:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
 <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
In-Reply-To: <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Wed, 18 Sep 2024 08:29:28 +0200
Message-ID: <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
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

On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Patrick,
> > >
> > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > > >
> > > > Unlike other Arm based platforms the machine only provides a minima=
l
> > > > FDT that contains number of CPUs, ammount of memory and machine-ver=
sion.
> > > > The boot firmware has to provide ACPI tables to the OS.
> > > >
> > > > Add a minimal amount of devicetree nodes to make the board useable =
within
> > > > U-Boot, provide documentation how to use, enable binman to fabricat=
e both
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
> > > >
> > > > ---
> > > >  arch/arm/Kconfig                            |   1 +
> > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++++++
> > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++=
++++
> > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++++++++++++++++=
+++
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > >  doc/board/emulation/index.rst               |   1 +
> > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > >  include/configs/qemu-sbsa.h                 |  98 ++++
> > > >  19 files changed, 1734 insertions(+), 6 deletions(-)
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
> > > Wow there is a lot in this patch!
> > >
> > > I don't think this should be in a separate subdir, just using
> > > board/emulation/qemu-arm should be OK?
> > Why would it share the code base with qemu-arm, as it's a completely
> > different board?
>
> Perhaps I misunderstand this...what kind of board is it? How do you
> run qemu for this board?
>
For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm you use -machine =
virt.

Both can use a cortex-a57 as CPU, but that's all those boards share. They h=
ave a
different memory layout, virt provides a complete FDT, while sbsa-ref doesn=
't.
sbsa-ref needs an Arm-TF and nonsecure boot firmware, while virt works
without a firmware.

> >
> > >
> > > I see you are setting plat data in the board file...is there not a CP=
U
> > > driver which can read it from the devicetree or set it based on the
> > > compatible string?
> > The CPU driver could read the data from devicetree, but that would requ=
ire a new
> > DT binding. Is that the preferred method over using plat data?
>
> It is fine to use plat data...but it should be set up in the driver
> where possible. In this case if you don't have a binding you can check
> the compatible string of the device (or even the root
> compatible-string) and add your plat data if it matches.

I was able to parse everything from the DT, except for PMU IRQs. Those
aren't needed to
boot the platform and can be added later on.
Will send out a new revision soon.

>
>
> >
> > >
> > > For FDT fixup, can you please use the event and the ofnode interface?
> > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.

It looks like EVT_FT_FIXUP is run rather late in the bootflow, used to
updated the FDT for OS usage,
but it must be run early to update the minimal FDT passed by QEMU and
add the missing nodes
for U-Boot drivers.

> Regards,
> Simon
