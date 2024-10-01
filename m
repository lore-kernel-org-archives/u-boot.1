Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51939CEACD5
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73DC88906;
	Tue,  1 Oct 2024 17:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dwWhU7V6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE05388906; Tue,  1 Oct 2024 17:17:20 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDF588001
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 17:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e25cb262769so5009507276.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727795835; x=1728400635; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AK6HE9QG0J1v8ESiqc6/z5y+Xnf8rQ+voLotFjMx0YM=;
 b=dwWhU7V6l1yzc6cImTxbIrPADvNMpmNM/hSjbuURuLSUPznv+2MWEYP5zmzq2lEfe1
 Mur44RKTGdEMCn8sQcN2Rb3N8ZViC9xHIU44BwQAvjO801NtH/Xn8OXB+pMl554IlBxL
 1u7LPaL/GgRbrksxKOBV5L7PLMYIAoizNk+RUkp/SV1TAmPE+SqXqCwy1C7crGdDlCqt
 uwUcOjZNj7HIT0WH4QeGgwULudKsUPhN2Jc17qBUMPi6TfKIkhF6FjYqJ4A4lrH8v9ZG
 Ut8rxb36FBfO/2eGv9rVJp/q2nOsGlmQy+nuYQRs7HY3xTpyr7RwzFmBrsJy5frGca84
 BezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795835; x=1728400635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AK6HE9QG0J1v8ESiqc6/z5y+Xnf8rQ+voLotFjMx0YM=;
 b=hi15YE5AI55fw0tjKEbqzLwC1uMNeKKaxhBWTmHAjjZsHu2HKRbODF8TZ8r22Mu03L
 BLNoxiaY7lwnFgUkuO7DLYyQtByqz7bjRwawz6eoruZdDCbEikFL+1GvGciBLKwX++kK
 E0FKFGc+K8bRPbdXYFBZlfD6HGncifnX0MLvI586cWnt1t+Q0mK+gUy+VMIjrEzEBB+t
 Nz0PiMz5NIkUpLxMV2VkMGEl3uZms7K4uvL4gbC+qHnU5X5Q2Ac8rxruPMeI8lIf4+5w
 oNWa2mdUjrpzmOtYeZbolyZahDy/zXuiomSCfl1GE128axF73RkwjsEktWMcE/5MGSkH
 1odA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnbnNoaXKeNdrwi7cFJvMOXu+IyMDwURxAa+VihTkSW/BKOx/pPKJVIQYT3MKPM6CHp9yM0nI=@lists.denx.de
X-Gm-Message-State: AOJu0YwE73D/b4tLxusz3n9we/pkt41lijOu1in4PawIYuOdRe704cOT
 n1a3YbmXRS+17mj32WylS/xRM2c36sDKpW37ZWWCpUu9LjYBb/Becys6DwDwR75p5q9o3jHFsRi
 gLLpf/DGVAVKIWSKBTfCkoR8AbIVaL49d/077sg==
X-Google-Smtp-Source: AGHT+IEIbyG+y0qBMs2FZQgy6VfXs342pJ+I9FM2kfEYF7gz4bQFPBl2Yjql5fqCvFwLT8um6uFB6H3hgMkr6q0tX2A=
X-Received: by 2002:a05:6902:100b:b0:e25:ce5f:42cc with SMTP id
 3f1490d57ef6-e2604b51542mr14125137276.32.1727795835379; Tue, 01 Oct 2024
 08:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-26-patrick.rudolph@9elements.com>
 <CAFLszTgTJAVKb87HEaSCgNqBeC8ThrWS4F9=Q9CzanRAeCHHTw@mail.gmail.com>
 <CALNFmy3EGfWFuR7sR0CgdqTqa0OYyhgQVBJS1-TpWJWUnLW6zQ@mail.gmail.com>
 <20241001150522.GF4737@bill-the-cat>
In-Reply-To: <20241001150522.GF4737@bill-the-cat>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 1 Oct 2024 17:17:04 +0200
Message-ID: <CALNFmy0vDK0G+_jkpJqpg9qdYncN1WFQeSiUmYiuq+hOeaMcaw@mail.gmail.com>
Subject: Re: [PATCH v5 25/36] board: emulation: Add QEMU sbsa support
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

Hi Tom,
On Tue, Oct 1, 2024 at 5:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 01, 2024 at 12:49:41PM +0200, Patrick Rudolph wrote:
> > On Thu, Sep 26, 2024 at 11:28=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Patrick,
> > >
> > > On Thu, 26 Sept 2024 at 10:03, Patrick Rudolph
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
> > > > ---
> > > >  arch/arm/Kconfig                            |   3 +-
> > > >  arch/arm/dts/qemu-sbsa.dts                  | 138 ++++++
> > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > >  board/emulation/qemu-sbsa/Kconfig           |  59 +++
> > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > >  board/emulation/qemu-sbsa/acpi.c            | 193 ++++++++
> > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++=
++++
> > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 312 +++++++++++++
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > >  doc/board/emulation/index.rst               |   1 +
> > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > >  include/configs/qemu-sbsa.h                 | 104 +++++
> > > >  19 files changed, 1621 insertions(+), 7 deletions(-)
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
> > > Please check the header order throughout
> > > E.g. board/emulation/qemu-sbsa/qemu-sbsa.c is still incorrect
> > >
> > > You should not need to include 'config.h' as kconfig is included by d=
efault?
> > >
> > > Do you need to add all the CFG items? Are they present in the devicet=
ree?
> > What are CFG items?
>
> He means literally "#define CFG_FOO     0xdeadbeef" type statements.
>
Oh. In that case: All defines are used within the code or the DT. I
found that other
platforms open code magic numbers in the DT, but I thought it's a good idea=
 to
use defines for everything. The defines are also used for the MMU setup and
for the DSDT generation.

> --
> Tom
