Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC2C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C61688AA7;
	Wed, 25 Sep 2024 14:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PlaFVthW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C6C88AA7; Wed, 25 Sep 2024 14:48:23 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F62688216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c3561804b5so53253116d6.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268490; x=1727873290; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdprw2fM6Mz1giWv6SkSGXMPyoNHrpDN5n3i+G0Nj10=;
 b=PlaFVthWgTpcJGYHIsP/ldk8FATRfLJ7G0YzK1w9OejZeW/5pV+36568UEY826oynt
 /PhMzoWkv7y4iL2W8CFOUOcVjITe6/mZbntOMyM14KYCq3J3Gk5F+QNPT6dSW/1lOBct
 Br7vawuvJHGOeC7XZD2ePdZKjJ3DHVLODeYqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268490; x=1727873290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdprw2fM6Mz1giWv6SkSGXMPyoNHrpDN5n3i+G0Nj10=;
 b=dMi+fy566fE5Fhjf8FAkj4JKP8wFOV8GYb4N5E+45MhSqbyAu6WtFHLnHCf0BSekBx
 IfEiWZtMByGx+YycjIbHal7MqBl0hIPHxrCV6AfbteOjtXguypxz13G3okUk3KFi9JpZ
 n898XGI9xkdkN4ms76WmgMvOjag0enb/HNNyYtNV5Z2Ge7+PHDwjbyxL7jLcO/P16Xo8
 MVm6VT7Tix7kIJ4IMpiOmi0br3/InjHXR8S6KHfWBaCGOjyR94HQQixcqMvZu9THQrM9
 LENmLPhkgJ8CwPZgwqtjaLFOG8ryZUxXw4ps8wa9Ak3dB7N4eC7pKPbQRmyhn/rL4Sad
 2WTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSPdMH90llHPgCR1qHcFdksQWisssmkS5OJWK+fU/M1Dh4sxKB+DwjCNYMZSkrDv4x8LGP4Os=@lists.denx.de
X-Gm-Message-State: AOJu0YybeiUfj5B5A3xIyY9rgRMEzFP8nY0tMqzjIdcJ7lp5FlnAphlK
 tq0cJ2ZlIqbr2e4Pnta1IbFvI8VrmckCgg4g4RqPEa3xQ8WBfYF8yuB0lfDvY73gOoPkwPXhWeQ
 VvUafpF7KH+seaWnyre+pNUAP2vj8caCmvPeJ
X-Google-Smtp-Source: AGHT+IHGzTJ1CWeqtfh82FrO8xq1qzSmMusGJ+AdmZUYhbElBxayAJ7Xd9aUjRxRgwSb3Dx+Rfj4oaFFYqbrCbXrH1A=
X-Received: by 2002:a05:6214:5b8a:b0:6c3:54a4:eea1 with SMTP id
 6a1803df08f44-6cb1dd0a42emr42450136d6.9.1727268490375; Wed, 25 Sep 2024
 05:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
 <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
 <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
 <CAFLszTi4Jf2QZZqWd2pA35J1HPEZay=tkbbs94_eyFLJMuYOdA@mail.gmail.com>
 <CALNFmy3fyS2+Xw4OUv92jfbP_hCBwY6Fi_79fKV+aJOqSm7jVA@mail.gmail.com>
 <CAFLszThay6_ZixyHXW=1yhKkK_N4Q2QbmF+i=__p26t+LmiddA@mail.gmail.com>
 <CALNFmy1mMFp8JP7ZoRdD2jhPQcDyhCM7023dopQ7VLkoSHVnWg@mail.gmail.com>
 <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
 <CALNFmy1O+1fvdfwWSxhPK80vB6fc998hEECH9hbbdfCO1ZKw-A@mail.gmail.com>
 <20240924142938.GW4252@bill-the-cat>
In-Reply-To: <20240924142938.GW4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:47:56 +0200
Message-ID: <CAFLszThzhsXxi1gT3u21Px2cuzOSRQRDRyS_cGH2_Bgt16vh_A@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
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

Hi Tom,

On Tue, 24 Sept 2024 at 16:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 24, 2024 at 03:17:15PM +0200, Patrick Rudolph wrote:
> > On Fri, Sep 20, 2024 at 5:59=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Patrick,
> > >
> > > On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > +Peter Maydell for comment on the below
> > > > >
> > > > > Hi Patrick,
> > > > >
> > > > > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Patrick,
> > > > > > >
> > > > > > > On Wed, 18 Sept 2024 at 08:29, Patrick Rudolph
> > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Patrick,
> > > > > > > > >
> > > > > > > > > On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> > > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sj=
g@chromium.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Patrick,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > > > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Add support for Arm sbsa [1] v0.3+ that is supporte=
d by QEMU [2].
> > > > > > > > > > > >
> > > > > > > > > > > > Unlike other Arm based platforms the machine only p=
rovides a minimal
> > > > > > > > > > > > FDT that contains number of CPUs, ammount of memory=
 and machine-version.
> > > > > > > > > > > > The boot firmware has to provide ACPI tables to the=
 OS.
> > > > > > > > > > > >
> > > > > > > > > > > > Add a minimal amount of devicetree nodes to make th=
e board useable within
> > > > > > > > > > > > U-Boot, provide documentation how to use, enable bi=
nman to fabricate both
> > > > > > > > > > > > ROMs that are required to boot and add ACPI tables =
to make it full compatible
> > > > > > > > > > > > to the EDK2 reference implementation.
> > > > > > > > > > > >
> > > > > > > > > > > > The board was tested using Fedora 40 Aarch64 Workst=
ation. It's able
> > > > > > > > > > > > to boot from USB and AHCI or network.
> > > > > > > > > > > >
> > > > > > > > > > > > Tested and found working:
> > > > > > > > > > > > - serial
> > > > > > > > > > > > - PCI
> > > > > > > > > > > > - xHCI
> > > > > > > > > > > > - Bochs display
> > > > > > > > > > > > - AHCI
> > > > > > > > > > > > - network using e1000e
> > > > > > > > > > > > - CPU init
> > > > > > > > > > > > - Booting Fedora 40
> > > > > > > > > > > >
> > > > > > > > > > > > 1: Server Base System Architecture (SBSA)
> > > > > > > > > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa=
.html
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9el=
ements.com>
> > > > > > > > > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changelog v3:
> > > > > > > > > > > > - Add GIC and GIC-ITS to devicetree
> > > > > > > > > > > > - Select GICv3 driver
> > > > > > > > > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > >  arch/arm/Kconfig                            |   1 =
+
> > > > > > > > > > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 =
++
> > > > > > > > > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 =
++
> > > > > > > > > > > >  arch/arm/mach-qemu/Kconfig                  |  36 =
+-
> > > > > > > > > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 =
+
> > > > > > > > > > > >  board/emulation/qemu-sbsa/Kconfig           |  58 =
+++
> > > > > > > > > > > >  board/emulation/qemu-sbsa/Makefile          |   8 =
+
> > > > > > > > > > > >  board/emulation/qemu-sbsa/acpi.c            | 235 =
++++++++++
> > > > > > > > > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 =
++++++++++++++++++++
> > > > > > > > > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 =
+
> > > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 =
+++++++++++++++++++
> > > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 =
+
> > > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 =
++
> > > > > > > > > > > >  board/emulation/qemu-sbsa/smc.c             |  72 =
+++
> > > > > > > > > > > >  configs/qemu-arm-sbsa_defconfig             |  10 =
+
> > > > > > > > > > > >  doc/board/emulation/index.rst               |   1 =
+
> > > > > > > > > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 =
++++
> > > > > > > > > > > >  doc/develop/driver-model/virtio.rst         |   1 =
+
> > > > > > > > > > > >  include/configs/qemu-sbsa.h                 |  98 =
++++
> > > > > > > > > > > >  19 files changed, 1734 insertions(+), 6 deletions(=
-)
> > > > > > > > > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > > > > > > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-=
sbsa/boot0.h
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconf=
ig
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Makef=
ile
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.=
c
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.=
asl
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/lowle=
vel_init.S
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-=
sbsa.c
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-=
sbsa.env
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-=
sbsa.h
> > > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > > > > > > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > > > > > > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.r=
st
> > > > > > > > > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > > > > > > > > >
> > > > > > > > > > > Wow there is a lot in this patch!
> > > > > > > > > > >
> > > > > > > > > > > I don't think this should be in a separate subdir, ju=
st using
> > > > > > > > > > > board/emulation/qemu-arm should be OK?
> > > > > > > > > > Why would it share the code base with qemu-arm, as it's=
 a completely
> > > > > > > > > > different board?
> > > > > > > > >
> > > > > > > > > Perhaps I misunderstand this...what kind of board is it? =
How do you
> > > > > > > > > run qemu for this board?
> > > > > > > > >
> > > > > > > > For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm y=
ou use -machine virt.
> > > > > > > >
> > > > > > > > Both can use a cortex-a57 as CPU, but that's all those boar=
ds share. They have a
> > > > > > > > different memory layout, virt provides a complete FDT, whil=
e sbsa-ref doesn't.
> > > > > > > > sbsa-ref needs an Arm-TF and nonsecure boot firmware, while=
 virt works
> > > > > > > > without a firmware.
> > > > > > >
> > > > > > > OK I see
> > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I see you are setting plat data in the board file...i=
s there not a CPU
> > > > > > > > > > > driver which can read it from the devicetree or set i=
t based on the
> > > > > > > > > > > compatible string?
> > > > > > > > > > The CPU driver could read the data from devicetree, but=
 that would require a new
> > > > > > > > > > DT binding. Is that the preferred method over using pla=
t data?
> > > > > > > > >
> > > > > > > > > It is fine to use plat data...but it should be set up in =
the driver
> > > > > > > > > where possible. In this case if you don't have a binding =
you can check
> > > > > > > > > the compatible string of the device (or even the root
> > > > > > > > > compatible-string) and add your plat data if it matches.
> > > > > > > >
> > > > > > > > I was able to parse everything from the DT, except for PMU =
IRQs. Those
> > > > > > > > aren't needed to
> > > > > > > > boot the platform and can be added later on.
> > > > > > > > Will send out a new revision soon.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > For FDT fixup, can you please use the event and the o=
fnode interface?
> > > > > > > > > > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an ex=
ample.
> > > > > > > >
> > > > > > > > It looks like EVT_FT_FIXUP is run rather late in the bootfl=
ow, used to
> > > > > > > > updated the FDT for OS usage,
> > > > > > > > but it must be run early to update the minimal FDT passed b=
y QEMU and
> > > > > > > > add the missing nodes
> > > > > > > > for U-Boot drivers.
> > > > > > >
> > > > > > > If the QEMU FDT is not suitable, shouldn't we use the U-Boot/=
Linux
> > > > > > > one? Do we have to use the one passed in by QEMU?
> > > > > > >
> > > > > > There's no U-Boot/Linux FDT, since this is an "ACPI only" platf=
orm.
> > > > > > In EDK2 firmware there's everything hard-coded as well to gener=
ate
> > > > > > proper ACPI code, but since
> > > > > > U-Boot relies on FDT, I decided to "fix" it and add the require=
d
> > > > > > missing nodes. This allows to make
> > > > > > use of U-Boot existing infrastructure around FDT.
> > > > > >
> > > > >
> > > > > So wouldn't it be better to pass in a u-boot.bin with the DT atta=
ched?
> > > > > Adding the thing in code seems pretty ugly.
> > > > >
> > > > Would that make use of CONFIG_OF_EMBED?
> > > > I decided against this option as it "is not recommended for product=
ion devices."
> > > > However I agree that it's possible and would be much cleaner and le=
ss code.
> > > > Will look into this.
> > >
> > > Well, indeed, it would be better not to use that. Does QEMU support a
> > > flat binary or does it require an ELF? Given the choice between
> > > OF_EMBED and your DT-building code I would go with the latter.
> > The first executed instruction is at the start of the flash, thus it's
> > not possible to use anything that
> > has a header. Since this is an emulated platform that will never
> > provide a full DT it might be
> > OK to use OF_EMBED here. It would be much less C code and might be
> > easier to maintain.
> >
> > >
> > > >
> > > > > > The QEMU generated FDT contains a bare minimum of nodes and isn=
't
> > > > > > suitable to boot an OS.
> > > > >
> > > > > Yes, I am not very pleased about that, particularly as my patch t=
o
> > > > > allow passing a proper FDT to QEMU[1] has still not been accepted=
.
> > > > >
> > > > The SBSA ref machine was designed that way, to make sure that only =
ACPI is used
> > > > to boot the OS.
> > >
> > > Er, but doesn't firmware run before the OS? It seems like a strange
> > > design decision.
> > I guess it was designed with EDK2 in mind as UEFI is mandatory to pass
> > the ACPI table pointer.
>
> This is the reference platform for the "never give the OS a Device Tree"
> Arm platform specification, so, it makes sense that no, really, there's
> no device tree associated with it. Since it's also the case that we
> better never give the OS a device tree, maybe this is a place where
> OF_EMBED is fine and makes sense?

Not in my opinion...that only really makes sense for debugging.

The correct thing here is to provide the devicetree to U-Boot. Since
QEMU is unable to do so, some mechanism is needed. I suggest disabling
OF_BOARD, so that it doesn't get the (missing) devicetree from the
start of RAM, but instead gets it from the end of the U-Boot image, as
is usually done with other boards.

Regards,
Simon
