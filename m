Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A4C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C0F88D33;
	Mon, 16 Sep 2024 17:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CwCfdqZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6D487DC7; Mon, 16 Sep 2024 17:41:32 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9AD88DDE
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf92f96f83so30200346d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501288; x=1727106088; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYulyooZWDfCbK+WWaeH+Q20XCMAlcO3BFE1xBWRWDc=;
 b=CwCfdqZ8UoHiEMdMSCUymEmjErdfL8WGZzPL7TRjpquot2MCkC6zLR6PxytXmmwMZh
 OASPVeJZANG//Lxe6BU3bHfRkV1N8yTWsWTOLcByFsGSkcgSKL/csPrBLn5p49X3ociy
 /oUg0cV/yvSmef8P+dwBuvJ8CPrSBs6uIwxlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501288; x=1727106088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYulyooZWDfCbK+WWaeH+Q20XCMAlcO3BFE1xBWRWDc=;
 b=IBE+T3EqofS3pKOGWRwmgGDtXC5wJldVowJyDKJ6Wpfqe7aQ3Cwv1MPN6LGuDYCQjO
 a3KSFdiZAYceOG8WvX2+lXJvrwCOiQpiRaz1Djd0nfmlIYPZnCAo6s8RqIPBSY2uLgqg
 DmPjsTc9P3q76HO1LjLyVVLXE54YZ6WpWZtn2IkJ5FbaBfSZH6eUJiIYVy0nJRRverQN
 LB0BFlse6RQJmY+k3dXIaWQLESF5JJI27tmK0sGsJt/pS5puAmKwZpqx6y6omjuTY0Gj
 AAMvzS0YxevtkhBivzQr/UGasXM3p5ooCWxNGJiND9v6jGRK6lqVyAmd4BFW/7bOwEfY
 GiEw==
X-Gm-Message-State: AOJu0YwpoPkLXMO16t6ZokirSXWljuD2UhC79glwW0u2oUw35uY5xKjq
 qR/9Jrqtp53WB/Q6uQ77nNOSqvbqfPCNNTkxMYjbOVYvaaz9SZDP+eFkPvRg9jEpAWcNV+ByQU9
 djInt4xiWYu0s4yzJAfglNUl6xSR4gpUU2zhf
X-Google-Smtp-Source: AGHT+IEq1G1I1ZzDz3JQl5zzO8CDbPAGy1qs77OtWplB3Dqv3utLqr6IjD3xG8W1VEwEdiU2J+aJfCBxY/RS6mYUAzg=
X-Received: by 2002:a05:6214:3a83:b0:6c3:463b:e1e1 with SMTP id
 6a1803df08f44-6c57dfbffcamr199712576d6.26.1726501288539; Mon, 16 Sep 2024
 08:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
In-Reply-To: <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:41:11 +0200
Message-ID: <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
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

On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> > >
> > > Unlike other Arm based platforms the machine only provides a minimal
> > > FDT that contains number of CPUs, ammount of memory and machine-versi=
on.
> > > The boot firmware has to provide ACPI tables to the OS.
> > >
> > > Add a minimal amount of devicetree nodes to make the board useable wi=
thin
> > > U-Boot, provide documentation how to use, enable binman to fabricate =
both
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
> > >
> > > ---
> > >  arch/arm/Kconfig                            |   1 +
> > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++++++
> > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++=
++
> > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++++++++++++++++++=
+
> > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > >  doc/board/emulation/index.rst               |   1 +
> > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > >  doc/develop/driver-model/virtio.rst         |   1 +
> > >  include/configs/qemu-sbsa.h                 |  98 ++++
> > >  19 files changed, 1734 insertions(+), 6 deletions(-)
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
> > Wow there is a lot in this patch!
> >
> > I don't think this should be in a separate subdir, just using
> > board/emulation/qemu-arm should be OK?
> Why would it share the code base with qemu-arm, as it's a completely
> different board?

Perhaps I misunderstand this...what kind of board is it? How do you
run qemu for this board?

>
> >
> > I see you are setting plat data in the board file...is there not a CPU
> > driver which can read it from the devicetree or set it based on the
> > compatible string?
> The CPU driver could read the data from devicetree, but that would requir=
e a new
> DT binding. Is that the preferred method over using plat data?

It is fine to use plat data...but it should be set up in the driver
where possible. In this case if you don't have a binding you can check
the compatible string of the device (or even the root
compatible-string) and add your plat data if it matches.


>
> >
> > For FDT fixup, can you please use the event and the ofnode interface?
> > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.
Regards,
Simon
