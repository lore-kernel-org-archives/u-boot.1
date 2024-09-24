Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6970FCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 13:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEFE88363;
	Tue, 24 Sep 2024 15:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="VyDnBRCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DD9886DF; Tue, 24 Sep 2024 15:17:30 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8EF88814D
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 15:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6e129c01b04so17899667b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727183846; x=1727788646; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SRPARI6SD6nDqhDRBxL/eVJqeldXzJZwfv6V1HLRT4=;
 b=VyDnBRCAIW0CwUFNScOPsKX/v+LScAiVxNMLa6UU34nFb8afJhVzwypuSjx47Wr30g
 naU7cCl51jPVT038iDt9YGmlSg4n2D299BWEXJXTbr/wTBMFXT+5+K2KZh+WzYQqGaEa
 Hspv+UZbm7gmneTxOypWaYKG+zPS+fCQjqTm15+Qdj3zPw35/dQmPe7lRiCdtmrTOFa/
 L9jm687vjMxPWgVPsq1chs1ig7r+pjdfrq4vJ2FAlQcmsNA23coKednxzaW/3ijRqgOs
 Q0BZna7oTq+c+dQxeXL/sRHsavlFxfSrG16qEFmyzPEoWg2aCDH5NGSx4czBLffJyTNt
 E7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727183846; x=1727788646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SRPARI6SD6nDqhDRBxL/eVJqeldXzJZwfv6V1HLRT4=;
 b=HxW9StSTcYRTYqup8sq8KtZWXaLc8p2PS2ak3NTSf23gMUPc7ZqTAzDwiqmzD1cpZk
 UVaAHmjvrNDUkGFLCNh2L5BLieIPSZ7zle9KOytmXHQz9I/LY0saMF3Ivz6i75vzRf+n
 nl2pG/n8iLPYb6ghYJFTYs+J+qyptFdJ64KlWr/MAtEZRw2U9DYe4nXqHoCg6H3Uw5TB
 KOAOf7Ji2o5ouerhIZZIFniqHZyeVUTJRzmLaFqaq2DpMWHXIA+3m+SNHTgMjrYdBvH4
 taEZuulm5zowYkNNwV+uR94n+mNCKLSdzeCSmGMCbQ/d79HEM5P2bd0bwWUKZZNZeFjW
 TrBQ==
X-Gm-Message-State: AOJu0YzGBOz9CHHrK8+ZfDuZqZeKoE2UAPRHdtRx2z2kwjAMuFcvm6JM
 qOmU/SSEDe2x+P8ngZzMauHvZ3v5QpOd6OygOBRd+ACObTOWRKgSBjmwNDCRsm6CQB/YQEsXbjw
 bdhD56n1BSxchvuL7YjhInRETGbTWNC6YN/h+vQ==
X-Google-Smtp-Source: AGHT+IFdCZC1VrY3Lh9VJLXTrcairbWk1Q/zxcCwUhlEe3KndY2nGKbkcWxvenPyWKJnI6sobMpjeAgqRhgmaYOpj8U=
X-Received: by 2002:a05:690c:680f:b0:6e2:145e:7733 with SMTP id
 00721157ae682-6e2145e7849mr9174777b3.18.1727183846575; Tue, 24 Sep 2024
 06:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
 <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
 <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
 <CAFLszTi4Jf2QZZqWd2pA35J1HPEZay=tkbbs94_eyFLJMuYOdA@mail.gmail.com>
 <CALNFmy3fyS2+Xw4OUv92jfbP_hCBwY6Fi_79fKV+aJOqSm7jVA@mail.gmail.com>
 <CAFLszThay6_ZixyHXW=1yhKkK_N4Q2QbmF+i=__p26t+LmiddA@mail.gmail.com>
 <CALNFmy1mMFp8JP7ZoRdD2jhPQcDyhCM7023dopQ7VLkoSHVnWg@mail.gmail.com>
 <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
In-Reply-To: <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 24 Sep 2024 15:17:15 +0200
Message-ID: <CALNFmy1O+1fvdfwWSxhPK80vB6fc998hEECH9hbbdfCO1ZKw-A@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
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

On Fri, Sep 20, 2024 at 5:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > +Peter Maydell for comment on the below
> > >
> > > Hi Patrick,
> > >
> > > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Patrick,
> > > > >
> > > > > On Wed, 18 Sept 2024 at 08:29, Patrick Rudolph
> > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Patrick,
> > > > > > >
> > > > > > > On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Patrick,
> > > > > > > > >
> > > > > > > > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Add support for Arm sbsa [1] v0.3+ that is supported by=
 QEMU [2].
> > > > > > > > > >
> > > > > > > > > > Unlike other Arm based platforms the machine only provi=
des a minimal
> > > > > > > > > > FDT that contains number of CPUs, ammount of memory and=
 machine-version.
> > > > > > > > > > The boot firmware has to provide ACPI tables to the OS.
> > > > > > > > > >
> > > > > > > > > > Add a minimal amount of devicetree nodes to make the bo=
ard useable within
> > > > > > > > > > U-Boot, provide documentation how to use, enable binman=
 to fabricate both
> > > > > > > > > > ROMs that are required to boot and add ACPI tables to m=
ake it full compatible
> > > > > > > > > > to the EDK2 reference implementation.
> > > > > > > > > >
> > > > > > > > > > The board was tested using Fedora 40 Aarch64 Workstatio=
n. It's able
> > > > > > > > > > to boot from USB and AHCI or network.
> > > > > > > > > >
> > > > > > > > > > Tested and found working:
> > > > > > > > > > - serial
> > > > > > > > > > - PCI
> > > > > > > > > > - xHCI
> > > > > > > > > > - Bochs display
> > > > > > > > > > - AHCI
> > > > > > > > > > - network using e1000e
> > > > > > > > > > - CPU init
> > > > > > > > > > - Booting Fedora 40
> > > > > > > > > >
> > > > > > > > > > 1: Server Base System Architecture (SBSA)
> > > > > > > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.htm=
l
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elemen=
ts.com>
> > > > > > > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > > ---
> > > > > > > > > > Changelog v3:
> > > > > > > > > > - Add GIC and GIC-ITS to devicetree
> > > > > > > > > > - Select GICv3 driver
> > > > > > > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  arch/arm/Kconfig                            |   1 +
> > > > > > > > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > > > > > > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > > > > > > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > > > > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > > > > > > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > > > > > > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > > > > > > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++=
++++++
> > > > > > > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++=
++++++++++++++++
> > > > > > > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++++=
+++++++++++++++
> > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > > > > > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > > > > > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > > > > > > >  doc/board/emulation/index.rst               |   1 +
> > > > > > > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > > > > > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > > > > > > >  include/configs/qemu-sbsa.h                 |  98 ++++
> > > > > > > > > >  19 files changed, 1734 insertions(+), 6 deletions(-)
> > > > > > > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > > > > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa=
/boot0.h
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_=
init.S
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa=
.c
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa=
.env
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa=
.h
> > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > > > > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > > > > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > > > > > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > > > > > > >
> > > > > > > > > Wow there is a lot in this patch!
> > > > > > > > >
> > > > > > > > > I don't think this should be in a separate subdir, just u=
sing
> > > > > > > > > board/emulation/qemu-arm should be OK?
> > > > > > > > Why would it share the code base with qemu-arm, as it's a c=
ompletely
> > > > > > > > different board?
> > > > > > >
> > > > > > > Perhaps I misunderstand this...what kind of board is it? How =
do you
> > > > > > > run qemu for this board?
> > > > > > >
> > > > > > For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm you u=
se -machine virt.
> > > > > >
> > > > > > Both can use a cortex-a57 as CPU, but that's all those boards s=
hare. They have a
> > > > > > different memory layout, virt provides a complete FDT, while sb=
sa-ref doesn't.
> > > > > > sbsa-ref needs an Arm-TF and nonsecure boot firmware, while vir=
t works
> > > > > > without a firmware.
> > > > >
> > > > > OK I see
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I see you are setting plat data in the board file...is th=
ere not a CPU
> > > > > > > > > driver which can read it from the devicetree or set it ba=
sed on the
> > > > > > > > > compatible string?
> > > > > > > > The CPU driver could read the data from devicetree, but tha=
t would require a new
> > > > > > > > DT binding. Is that the preferred method over using plat da=
ta?
> > > > > > >
> > > > > > > It is fine to use plat data...but it should be set up in the =
driver
> > > > > > > where possible. In this case if you don't have a binding you =
can check
> > > > > > > the compatible string of the device (or even the root
> > > > > > > compatible-string) and add your plat data if it matches.
> > > > > >
> > > > > > I was able to parse everything from the DT, except for PMU IRQs=
. Those
> > > > > > aren't needed to
> > > > > > boot the platform and can be added later on.
> > > > > > Will send out a new revision soon.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > For FDT fixup, can you please use the event and the ofnod=
e interface?
> > > > > > > > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an exampl=
e.
> > > > > >
> > > > > > It looks like EVT_FT_FIXUP is run rather late in the bootflow, =
used to
> > > > > > updated the FDT for OS usage,
> > > > > > but it must be run early to update the minimal FDT passed by QE=
MU and
> > > > > > add the missing nodes
> > > > > > for U-Boot drivers.
> > > > >
> > > > > If the QEMU FDT is not suitable, shouldn't we use the U-Boot/Linu=
x
> > > > > one? Do we have to use the one passed in by QEMU?
> > > > >
> > > > There's no U-Boot/Linux FDT, since this is an "ACPI only" platform.
> > > > In EDK2 firmware there's everything hard-coded as well to generate
> > > > proper ACPI code, but since
> > > > U-Boot relies on FDT, I decided to "fix" it and add the required
> > > > missing nodes. This allows to make
> > > > use of U-Boot existing infrastructure around FDT.
> > > >
> > >
> > > So wouldn't it be better to pass in a u-boot.bin with the DT attached=
?
> > > Adding the thing in code seems pretty ugly.
> > >
> > Would that make use of CONFIG_OF_EMBED?
> > I decided against this option as it "is not recommended for production =
devices."
> > However I agree that it's possible and would be much cleaner and less c=
ode.
> > Will look into this.
>
> Well, indeed, it would be better not to use that. Does QEMU support a
> flat binary or does it require an ELF? Given the choice between
> OF_EMBED and your DT-building code I would go with the latter.
The first executed instruction is at the start of the flash, thus it's
not possible to use anything that
has a header. Since this is an emulated platform that will never
provide a full DT it might be
OK to use OF_EMBED here. It would be much less C code and might be
easier to maintain.

>
> >
> > > > The QEMU generated FDT contains a bare minimum of nodes and isn't
> > > > suitable to boot an OS.
> > >
> > > Yes, I am not very pleased about that, particularly as my patch to
> > > allow passing a proper FDT to QEMU[1] has still not been accepted.
> > >
> > The SBSA ref machine was designed that way, to make sure that only ACPI=
 is used
> > to boot the OS.
>
> Er, but doesn't firmware run before the OS? It seems like a strange
> design decision.
I guess it was designed with EDK2 in mind as UEFI is mandatory to pass
the ACPI table pointer.

>
>
> Regards,
> Simon
>
> > >
> > > [1] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183=
410.256484-1-sjg@chromium.org/#24481799
