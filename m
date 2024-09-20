Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC0CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FE18888F;
	Fri, 20 Sep 2024 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B+2noC8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A918B88883; Fri, 20 Sep 2024 17:59:54 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA15D88C2E
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c34dd6c1b4so13486596d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847991; x=1727452791; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YuLRlM3xouIKT4L819x/Z290FSnIt9Acg/HVE2N6pE=;
 b=B+2noC8wzLeSHVhJC0vthH2lzUiIEKIw6D4CTZAPEkemDQ3bzR6GnS8MpeUvzYmlc9
 x3EbRwSr+gnbz0/eTxR0Ue/gXslvK1l9xnhIayEBgx3cVZyjDKGkMrhOHjYiVWCMyo5I
 9gQh8rkwVr+ulBiyGGEmv09Z0j4w3Md0OSeXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847991; x=1727452791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YuLRlM3xouIKT4L819x/Z290FSnIt9Acg/HVE2N6pE=;
 b=SbXmIDphZl+WOXuMNHNVAmxY4LetWBTx5iUEHc21q5LHiuEU+umhbKr/AHkCXyFTls
 +UDpP886Yrv+hK1MQlB/SkRTNbhYbBjBs4QrhyjrPFikrCMhFvcXRlJbVeHOHLRxok1i
 7+/4ju+UJjchWE4sKOB+KmACmrzROGYCkNARZR+k/QpOQQFEahRlgaAGFKTl/A8TMa1o
 wCmWEdr6BchAHQN9phZfVTaaKgFas0EjyKvq49jtLkUQLillZ5IAiNKzYjS2WTudstb5
 NUxyc39GSDv0AnaIzVDmvY5bIB8ZuXiCzMcGrrVUZa6yFDd7Qvh2h+iI6cqlleWrhgx4
 7ugg==
X-Gm-Message-State: AOJu0YyPrnr7i5muEkFATviYV5lbd5VPoPSlz1q1E69xKm3vME6W9e04
 ldgDwCImSKTpZnHaDXrXyVUs6+3sad/J+2MPaMb4ZWAD5nopXZdod4aICkQqaRBHQ/K9p44z4Er
 zM0lAUk5s9UO4djSikLAYfPcdKSb+zbQhga10
X-Google-Smtp-Source: AGHT+IGyk+NgERwcFDxIWKZALuBFXlTwWFUgZA3GAf0FCkJraZPQqsOWaF6MBHaUtgeHU4GEwv90a19hLWYuTLfOj6Y=
X-Received: by 2002:a05:6214:3114:b0:6c5:ab33:3d6f with SMTP id
 6a1803df08f44-6c7bc614768mr33313576d6.8.1726847990749; Fri, 20 Sep 2024
 08:59:50 -0700 (PDT)
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
In-Reply-To: <CALNFmy1mMFp8JP7ZoRdD2jhPQcDyhCM7023dopQ7VLkoSHVnWg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:59:40 +0200
Message-ID: <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Patrick,

On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > +Peter Maydell for comment on the below
> >
> > Hi Patrick,
> >
> > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Patrick,
> > > >
> > > > On Wed, 18 Sept 2024 at 08:29, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi Patrick,
> > > > > >
> > > > > > On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Patrick,
> > > > > > > >
> > > > > > > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > >
> > > > > > > > > Add support for Arm sbsa [1] v0.3+ that is supported by Q=
EMU [2].
> > > > > > > > >
> > > > > > > > > Unlike other Arm based platforms the machine only provide=
s a minimal
> > > > > > > > > FDT that contains number of CPUs, ammount of memory and m=
achine-version.
> > > > > > > > > The boot firmware has to provide ACPI tables to the OS.
> > > > > > > > >
> > > > > > > > > Add a minimal amount of devicetree nodes to make the boar=
d useable within
> > > > > > > > > U-Boot, provide documentation how to use, enable binman t=
o fabricate both
> > > > > > > > > ROMs that are required to boot and add ACPI tables to mak=
e it full compatible
> > > > > > > > > to the EDK2 reference implementation.
> > > > > > > > >
> > > > > > > > > The board was tested using Fedora 40 Aarch64 Workstation.=
 It's able
> > > > > > > > > to boot from USB and AHCI or network.
> > > > > > > > >
> > > > > > > > > Tested and found working:
> > > > > > > > > - serial
> > > > > > > > > - PCI
> > > > > > > > > - xHCI
> > > > > > > > > - Bochs display
> > > > > > > > > - AHCI
> > > > > > > > > - network using e1000e
> > > > > > > > > - CPU init
> > > > > > > > > - Booting Fedora 40
> > > > > > > > >
> > > > > > > > > 1: Server Base System Architecture (SBSA)
> > > > > > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
> > > > > > > > >
> > > > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements=
.com>
> > > > > > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > ---
> > > > > > > > > Changelog v3:
> > > > > > > > > - Add GIC and GIC-ITS to devicetree
> > > > > > > > > - Select GICv3 driver
> > > > > > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  arch/arm/Kconfig                            |   1 +
> > > > > > > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > > > > > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > > > > > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > > > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > > > > > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > > > > > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > > > > > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++=
++++
> > > > > > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++=
++++++++++++++
> > > > > > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++++++=
+++++++++++++
> > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > > > > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > > > > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > > > > > >  doc/board/emulation/index.rst               |   1 +
> > > > > > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
> > > > > > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > > > > > >  include/configs/qemu-sbsa.h                 |  98 ++++
> > > > > > > > >  19 files changed, 1734 insertions(+), 6 deletions(-)
> > > > > > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > > > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/b=
oot0.h
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_in=
it.S
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.e=
nv
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > > > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > > > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > > > > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > > > > > >
> > > > > > > > Wow there is a lot in this patch!
> > > > > > > >
> > > > > > > > I don't think this should be in a separate subdir, just usi=
ng
> > > > > > > > board/emulation/qemu-arm should be OK?
> > > > > > > Why would it share the code base with qemu-arm, as it's a com=
pletely
> > > > > > > different board?
> > > > > >
> > > > > > Perhaps I misunderstand this...what kind of board is it? How do=
 you
> > > > > > run qemu for this board?
> > > > > >
> > > > > For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm you use=
 -machine virt.
> > > > >
> > > > > Both can use a cortex-a57 as CPU, but that's all those boards sha=
re. They have a
> > > > > different memory layout, virt provides a complete FDT, while sbsa=
-ref doesn't.
> > > > > sbsa-ref needs an Arm-TF and nonsecure boot firmware, while virt =
works
> > > > > without a firmware.
> > > >
> > > > OK I see
> > > >
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > I see you are setting plat data in the board file...is ther=
e not a CPU
> > > > > > > > driver which can read it from the devicetree or set it base=
d on the
> > > > > > > > compatible string?
> > > > > > > The CPU driver could read the data from devicetree, but that =
would require a new
> > > > > > > DT binding. Is that the preferred method over using plat data=
?
> > > > > >
> > > > > > It is fine to use plat data...but it should be set up in the dr=
iver
> > > > > > where possible. In this case if you don't have a binding you ca=
n check
> > > > > > the compatible string of the device (or even the root
> > > > > > compatible-string) and add your plat data if it matches.
> > > > >
> > > > > I was able to parse everything from the DT, except for PMU IRQs. =
Those
> > > > > aren't needed to
> > > > > boot the platform and can be added later on.
> > > > > Will send out a new revision soon.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > For FDT fixup, can you please use the event and the ofnode =
interface?
> > > > > > > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.
> > > > >
> > > > > It looks like EVT_FT_FIXUP is run rather late in the bootflow, us=
ed to
> > > > > updated the FDT for OS usage,
> > > > > but it must be run early to update the minimal FDT passed by QEMU=
 and
> > > > > add the missing nodes
> > > > > for U-Boot drivers.
> > > >
> > > > If the QEMU FDT is not suitable, shouldn't we use the U-Boot/Linux
> > > > one? Do we have to use the one passed in by QEMU?
> > > >
> > > There's no U-Boot/Linux FDT, since this is an "ACPI only" platform.
> > > In EDK2 firmware there's everything hard-coded as well to generate
> > > proper ACPI code, but since
> > > U-Boot relies on FDT, I decided to "fix" it and add the required
> > > missing nodes. This allows to make
> > > use of U-Boot existing infrastructure around FDT.
> > >
> >
> > So wouldn't it be better to pass in a u-boot.bin with the DT attached?
> > Adding the thing in code seems pretty ugly.
> >
> Would that make use of CONFIG_OF_EMBED?
> I decided against this option as it "is not recommended for production de=
vices."
> However I agree that it's possible and would be much cleaner and less cod=
e.
> Will look into this.

Well, indeed, it would be better not to use that. Does QEMU support a
flat binary or does it require an ELF? Given the choice between
OF_EMBED and your DT-building code I would go with the latter.

>
> > > The QEMU generated FDT contains a bare minimum of nodes and isn't
> > > suitable to boot an OS.
> >
> > Yes, I am not very pleased about that, particularly as my patch to
> > allow passing a proper FDT to QEMU[1] has still not been accepted.
> >
> The SBSA ref machine was designed that way, to make sure that only ACPI i=
s used
> to boot the OS.

Er, but doesn't firmware run before the OS? It seems like a strange
design decision.


Regards,
Simon

> >
> > [1] https://patchwork.kernel.org/project/qemu-devel/patch/2021092618341=
0.256484-1-sjg@chromium.org/#24481799
