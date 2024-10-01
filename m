Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB611CE7D0D
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B9189062;
	Tue,  1 Oct 2024 12:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="TV7pqSJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C092589141; Tue,  1 Oct 2024 12:50:03 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B0289042
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e25d380b464so4630594276.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727779793; x=1728384593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G20DfNhm3c2npNWCQOIkjKsv8hd/HbqHxKn1+xEPkWw=;
 b=TV7pqSJbnuTvGAoQ9xNY5X+j6BIBc+7NUB+6SWZTrwIfZRGkxLQO9zD4FU0nTESEsG
 J6NYtEFyIrICJDYu6SI5HCfUAIa6vTDYwjMTZISMAhECHU12co9QpGeAHQhtG0Uzs8Gu
 4CGDJby+Z6loqGxZrVdmjtxH8ERerrmFzQt9WE5snl6XdbN1T8y0r8d5kbKNjNXeYzuK
 /0fzR6harAmrh41SX0DECLUI4Pym/p8QxoYlzWv4Mfk4A5017mxC9y4dmhh925Sfrb4J
 WGZ7p6XwLj/k65OCtJe5ungGerxHoP/8bks2q5efw+wBAraR6ImYziPwKvgQBtP3RErk
 1M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727779793; x=1728384593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G20DfNhm3c2npNWCQOIkjKsv8hd/HbqHxKn1+xEPkWw=;
 b=VgUura06K8/i7Q3iyBRH1ozWQ9GzNlLmJ94iz4gMXwC0VH8wEzFMz3t6HsflrETM8q
 f+tjpGUhTkLv3xGZB63GGuC7tjfgISXS4e9jcT5LpCaWKUMlQgErKHwi3QRiqBXXsOUB
 EWrPDR7+PhvunOCNE8zkgs6bVd6HVQWj4/EZpsWaZ2MDk4AzDMc64aG22YSvuQltNseW
 U3u8iXNZk2AYcEauwRBp8ms9aH/5k/4UgrN/nmCgl4x8FG+1zcG5vEDIcfK3liVtQ2J7
 n+8U4901Fp/+ur9VWLTX4GUvWE1mhhpaCb/aHFoLeqaHuFLP2089k3DwA9iY6XvIIDp3
 /j+A==
X-Gm-Message-State: AOJu0Yw5n51QZAR/TCFdm6GhYtSP7h9VbHTitcpjmioAhMXSgVpTdk+F
 nAzHPzPFdf6MjsbP8Zi4PvBsCqgqKRb+WOAyaa8u5IXRQZM3RJ/1eMhD/MIJs+rVrnvSyLHDHyy
 WwB6iFxrAD3FixRp4u1/HYCUk7Go+ljtg6dXfTQ==
X-Google-Smtp-Source: AGHT+IH8h1DKjkO/XvB+7Cq+CyYIb/IMzyCn0keol0ZRWMT4tHiwHBIjpCTqpWHi6OM9OnfayJ1MSxGPNeijEn+Mdl8=
X-Received: by 2002:a05:6902:2289:b0:e1d:1d64:2b5e with SMTP id
 3f1490d57ef6-e2604b75a72mr10815389276.46.1727779793275; Tue, 01 Oct 2024
 03:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-26-patrick.rudolph@9elements.com>
 <CAFLszTgTJAVKb87HEaSCgNqBeC8ThrWS4F9=Q9CzanRAeCHHTw@mail.gmail.com>
In-Reply-To: <CAFLszTgTJAVKb87HEaSCgNqBeC8ThrWS4F9=Q9CzanRAeCHHTw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 1 Oct 2024 12:49:41 +0200
Message-ID: <CALNFmy3EGfWFuR7sR0CgdqTqa0OYyhgQVBJS1-TpWJWUnLW6zQ@mail.gmail.com>
Subject: Re: [PATCH v5 25/36] board: emulation: Add QEMU sbsa support
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

On Thu, Sep 26, 2024 at 11:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Patrick,
>
> On Thu, 26 Sept 2024 at 10:03, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
> >
> > Unlike other Arm based platforms the machine only provides a minimal
> > FDT that contains number of CPUs, ammount of memory and machine-version=
.
> > The boot firmware has to provide ACPI tables to the OS.
> > Due to this design a full DTB is added here as well that allows U-Boot'=
s
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
> > ---
> >  arch/arm/Kconfig                            |   3 +-
> >  arch/arm/dts/qemu-sbsa.dts                  | 138 ++++++
> >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
> >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> >  board/emulation/qemu-sbsa/Kconfig           |  59 +++
> >  board/emulation/qemu-sbsa/Makefile          |   8 +
> >  board/emulation/qemu-sbsa/acpi.c            | 193 ++++++++
> >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
> >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 312 +++++++++++++
> >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> >  configs/qemu-arm-sbsa_defconfig             |  10 +
> >  doc/board/emulation/index.rst               |   1 +
> >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> >  doc/develop/driver-model/virtio.rst         |   1 +
> >  include/configs/qemu-sbsa.h                 | 104 +++++
> >  19 files changed, 1621 insertions(+), 7 deletions(-)
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
> Please check the header order throughout
> E.g. board/emulation/qemu-sbsa/qemu-sbsa.c is still incorrect
>
> You should not need to include 'config.h' as kconfig is included by defau=
lt?
>
> Do you need to add all the CFG items? Are they present in the devicetree?
What are CFG items? Do you refer to Kconfig options being selected or modif=
ied?
The Kconfig options selected allow to use all of the devices present in the=
 DT.

It looks like on some U-Boot boards most Kconfigs are not selected,
leaving you with a
non booting default configuration. Only the *_defconfig found in
configs will generate a
"usable" image, which I find kind of strange.

>
> For Binman the default pad-byte is 0, so you can drop those lines.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon
