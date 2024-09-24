Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD9BCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 14:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEB8897F;
	Tue, 24 Sep 2024 16:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MqCSUOrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF97488995; Tue, 24 Sep 2024 16:29:47 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3176A88646
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a30a045cso531073985a.2
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727188184; x=1727792984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C4s7Uep+7Q1O9yFI7v7/+ADAlXOJX3ORs0vwZ8smw0c=;
 b=MqCSUOrS+363QfwhgYqz7YLAEUgdxVs7dwDzDrGzWpBF9dsgDJybTnBsf6w8J2G+7z
 3En3AmvVU3OVG6+QU4GjaaBDNSnj8Q2qxPej/bqXAaW0EFuPHFK4T1srHPVKqRAp7+vs
 ls3iqFBdz1ediHSZzjYGKALyrCBx/Fewgx3uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727188184; x=1727792984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4s7Uep+7Q1O9yFI7v7/+ADAlXOJX3ORs0vwZ8smw0c=;
 b=soLKrD8fV18ew9QMs5rGqaUWVDvMuw5HIZ0tjYVmox68ONNS1MmYORrys039eGdD5r
 njt2NnrzN8XQTNTCjaXPqg9+U9GOqyFnp1b1kreZwn7W0bl6qa/87qw72h1gaGLWlTb2
 YvVT1/k+0a7J5YsaYdPHr+LZ/3qwXMaFuATauxdMP/zuWfoiWHKYdpL3pFSgd1dXvD8Y
 geyXJ5GIRX4I+wIk93O04f1BDLupri7BcOoRr5jELA/qZi9Pe8DS6LJZHpfC5NLvkdLH
 LuFgTt7KlJV/ojuAO8iqwQfxLtgE4Wdm5rthMIHlg5LLxT5hwnQhmQz+QZMc9Z4wIrHG
 4ynQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm8lH/FcmgBGxgSCaeuU4kLJ/ZB8q2tuNeKdR0Vx60ou5wFcVvx3gEQKLIOq8d88gPlrXmVLA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYqj55aZV7jOlUEWoh+9JXu29nDdXzr7QoDS83xHtSMv1w6Sd4
 mv/jLxzgdnIpR4DCyRUaq7Jbokqm4q7iFAA/m9F10lekLgFXwV32r/GMHww2av2Lu8LFIm2BF+T
 1
X-Google-Smtp-Source: AGHT+IG2JufAuL6lAGZC0tJ7bqWNqg5lefdVXSsbYatHwWoPhcfeuoR+1vYGxy3il1OGui2GqtAJsQ==
X-Received: by 2002:a05:620a:450c:b0:7a9:ad47:edc1 with SMTP id
 af79cd13be357-7acb8d99713mr2458402085a.34.1727188183815; 
 Tue, 24 Sep 2024 07:29:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde532240sm73969485a.21.2024.09.24.07.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 07:29:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 08:29:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
Message-ID: <20240924142938.GW4252@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DBgimeyDniszRsRV"
Content-Disposition: inline
In-Reply-To: <CALNFmy1O+1fvdfwWSxhPK80vB6fc998hEECH9hbbdfCO1ZKw-A@mail.gmail.com>
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


--DBgimeyDniszRsRV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 03:17:15PM +0200, Patrick Rudolph wrote:
> On Fri, Sep 20, 2024 at 5:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > +Peter Maydell for comment on the below
> > > >
> > > > Hi Patrick,
> > > >
> > > > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Patrick,
> > > > > >
> > > > > > On Wed, 18 Sept 2024 at 08:29, Patrick Rudolph
> > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 16, 2024 at 5:41=E2=80=AFPM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Patrick,
> > > > > > > >
> > > > > > > > On Thu, 12 Sept 2024 at 00:23, Patrick Rudolph
> > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Patrick,
> > > > > > > > > >
> > > > > > > > > > On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
> > > > > > > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Add support for Arm sbsa [1] v0.3+ that is supported =
by QEMU [2].
> > > > > > > > > > >
> > > > > > > > > > > Unlike other Arm based platforms the machine only pro=
vides a minimal
> > > > > > > > > > > FDT that contains number of CPUs, ammount of memory a=
nd machine-version.
> > > > > > > > > > > The boot firmware has to provide ACPI tables to the O=
S.
> > > > > > > > > > >
> > > > > > > > > > > Add a minimal amount of devicetree nodes to make the =
board useable within
> > > > > > > > > > > U-Boot, provide documentation how to use, enable binm=
an to fabricate both
> > > > > > > > > > > ROMs that are required to boot and add ACPI tables to=
 make it full compatible
> > > > > > > > > > > to the EDK2 reference implementation.
> > > > > > > > > > >
> > > > > > > > > > > The board was tested using Fedora 40 Aarch64 Workstat=
ion. It's able
> > > > > > > > > > > to boot from USB and AHCI or network.
> > > > > > > > > > >
> > > > > > > > > > > Tested and found working:
> > > > > > > > > > > - serial
> > > > > > > > > > > - PCI
> > > > > > > > > > > - xHCI
> > > > > > > > > > > - Bochs display
> > > > > > > > > > > - AHCI
> > > > > > > > > > > - network using e1000e
> > > > > > > > > > > - CPU init
> > > > > > > > > > > - Booting Fedora 40
> > > > > > > > > > >
> > > > > > > > > > > 1: Server Base System Architecture (SBSA)
> > > > > > > > > > > 2: https://www.qemu.org/docs/master/system/arm/sbsa.h=
tml
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elem=
ents.com>
> > > > > > > > > > > Cc: Peter Robinson <pbrobinson@gmail.com>
> > > > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > ---
> > > > > > > > > > > Changelog v3:
> > > > > > > > > > > - Add GIC and GIC-ITS to devicetree
> > > > > > > > > > > - Select GICv3 driver
> > > > > > > > > > > - Drop acpi_fill_madt and use driver model instead
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > >  arch/arm/Kconfig                            |   1 +
> > > > > > > > > > >  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
> > > > > > > > > > >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
> > > > > > > > > > >  arch/arm/mach-qemu/Kconfig                  |  36 +-
> > > > > > > > > > >  board/emulation/qemu-arm/MAINTAINERS        |   2 +
> > > > > > > > > > >  board/emulation/qemu-sbsa/Kconfig           |  58 +++
> > > > > > > > > > >  board/emulation/qemu-sbsa/Makefile          |   8 +
> > > > > > > > > > >  board/emulation/qemu-sbsa/acpi.c            | 235 ++=
++++++++
> > > > > > > > > > >  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++=
++++++++++++++++++
> > > > > > > > > > >  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
> > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 ++=
+++++++++++++++++
> > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
> > > > > > > > > > >  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
> > > > > > > > > > >  board/emulation/qemu-sbsa/smc.c             |  72 +++
> > > > > > > > > > >  configs/qemu-arm-sbsa_defconfig             |  10 +
> > > > > > > > > > >  doc/board/emulation/index.rst               |   1 +
> > > > > > > > > > >  doc/board/emulation/qemu-sbsa.rst           |  98 ++=
++
> > > > > > > > > > >  doc/develop/driver-model/virtio.rst         |   1 +
> > > > > > > > > > >  include/configs/qemu-sbsa.h                 |  98 ++=
++
> > > > > > > > > > >  19 files changed, 1734 insertions(+), 6 deletions(-)
> > > > > > > > > > >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> > > > > > > > > > >  create mode 100644 arch/arm/include/asm/arch-qemu-sb=
sa/boot0.h
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/lowleve=
l_init.S
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sb=
sa.c
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sb=
sa.env
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/qemu-sb=
sa.h
> > > > > > > > > > >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> > > > > > > > > > >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> > > > > > > > > > >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> > > > > > > > > > >  create mode 100644 include/configs/qemu-sbsa.h
> > > > > > > > > >
> > > > > > > > > > Wow there is a lot in this patch!
> > > > > > > > > >
> > > > > > > > > > I don't think this should be in a separate subdir, just=
 using
> > > > > > > > > > board/emulation/qemu-arm should be OK?
> > > > > > > > > Why would it share the code base with qemu-arm, as it's a=
 completely
> > > > > > > > > different board?
> > > > > > > >
> > > > > > > > Perhaps I misunderstand this...what kind of board is it? Ho=
w do you
> > > > > > > > run qemu for this board?
> > > > > > > >
> > > > > > > For QEMU SBSA you use -machine sbsa-ref, but for qemu-arm you=
 use -machine virt.
> > > > > > >
> > > > > > > Both can use a cortex-a57 as CPU, but that's all those boards=
 share. They have a
> > > > > > > different memory layout, virt provides a complete FDT, while =
sbsa-ref doesn't.
> > > > > > > sbsa-ref needs an Arm-TF and nonsecure boot firmware, while v=
irt works
> > > > > > > without a firmware.
> > > > > >
> > > > > > OK I see
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I see you are setting plat data in the board file...is =
there not a CPU
> > > > > > > > > > driver which can read it from the devicetree or set it =
based on the
> > > > > > > > > > compatible string?
> > > > > > > > > The CPU driver could read the data from devicetree, but t=
hat would require a new
> > > > > > > > > DT binding. Is that the preferred method over using plat =
data?
> > > > > > > >
> > > > > > > > It is fine to use plat data...but it should be set up in th=
e driver
> > > > > > > > where possible. In this case if you don't have a binding yo=
u can check
> > > > > > > > the compatible string of the device (or even the root
> > > > > > > > compatible-string) and add your plat data if it matches.
> > > > > > >
> > > > > > > I was able to parse everything from the DT, except for PMU IR=
Qs. Those
> > > > > > > aren't needed to
> > > > > > > boot the platform and can be added later on.
> > > > > > > Will send out a new revision soon.
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > For FDT fixup, can you please use the event and the ofn=
ode interface?
> > > > > > > > > > See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an exam=
ple.
> > > > > > >
> > > > > > > It looks like EVT_FT_FIXUP is run rather late in the bootflow=
, used to
> > > > > > > updated the FDT for OS usage,
> > > > > > > but it must be run early to update the minimal FDT passed by =
QEMU and
> > > > > > > add the missing nodes
> > > > > > > for U-Boot drivers.
> > > > > >
> > > > > > If the QEMU FDT is not suitable, shouldn't we use the U-Boot/Li=
nux
> > > > > > one? Do we have to use the one passed in by QEMU?
> > > > > >
> > > > > There's no U-Boot/Linux FDT, since this is an "ACPI only" platfor=
m.
> > > > > In EDK2 firmware there's everything hard-coded as well to generate
> > > > > proper ACPI code, but since
> > > > > U-Boot relies on FDT, I decided to "fix" it and add the required
> > > > > missing nodes. This allows to make
> > > > > use of U-Boot existing infrastructure around FDT.
> > > > >
> > > >
> > > > So wouldn't it be better to pass in a u-boot.bin with the DT attach=
ed?
> > > > Adding the thing in code seems pretty ugly.
> > > >
> > > Would that make use of CONFIG_OF_EMBED?
> > > I decided against this option as it "is not recommended for productio=
n devices."
> > > However I agree that it's possible and would be much cleaner and less=
 code.
> > > Will look into this.
> >
> > Well, indeed, it would be better not to use that. Does QEMU support a
> > flat binary or does it require an ELF? Given the choice between
> > OF_EMBED and your DT-building code I would go with the latter.
> The first executed instruction is at the start of the flash, thus it's
> not possible to use anything that
> has a header. Since this is an emulated platform that will never
> provide a full DT it might be
> OK to use OF_EMBED here. It would be much less C code and might be
> easier to maintain.
>=20
> >
> > >
> > > > > The QEMU generated FDT contains a bare minimum of nodes and isn't
> > > > > suitable to boot an OS.
> > > >
> > > > Yes, I am not very pleased about that, particularly as my patch to
> > > > allow passing a proper FDT to QEMU[1] has still not been accepted.
> > > >
> > > The SBSA ref machine was designed that way, to make sure that only AC=
PI is used
> > > to boot the OS.
> >
> > Er, but doesn't firmware run before the OS? It seems like a strange
> > design decision.
> I guess it was designed with EDK2 in mind as UEFI is mandatory to pass
> the ACPI table pointer.

This is the reference platform for the "never give the OS a Device Tree"
Arm platform specification, so, it makes sense that no, really, there's
no device tree associated with it. Since it's also the case that we
better never give the OS a device tree, maybe this is a place where
OF_EMBED is fine and makes sense?

--=20
Tom

--DBgimeyDniszRsRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbyzMsACgkQFHw5/5Y0
tyx8QgwAtSn72bWDa8xvnj7rS7my1BIQEAY+KTPxGZolmz+CdCStargMjumuF/tF
nV1BatXgNONTn6bWRDrgIXfE7p+qq3Gb+pPaNphwkklukhM+s2OXTMj38MHEFnCW
v2AHIYnUfHGg6woRykSerOAu9T+7994G5jJU+Xlcu+lzKdTgQa+HIIOUxDBd8sYi
RJgxYQjqJTPHLWHKFuekHedx/B7u/aeXqTY8hCoeZHWA2ROlcDNa/oTc/D13e1+K
Dwl1NQPTvo4j3KImN5uxzXHo0iJiDg6RvAqiLj0b03hYxwrQW+3eh2lZRTOo8npP
bFqcTKeVzYgedr4jE5QHXJEkl8YGSmTagH3TNPIPkORVF30+75Nqf1vzuaXazXqg
Kl2bLzuAEg3UwYtIn5vueA+vNdyHrG712dSRWD/6TtiYvpEzG+mqo4eGwCx3BR2p
a0/IuzKI8eFCS/HSnRA4z5lx18Pf0MCrjR6zvrs7kFlvaymEbQTr8/YQOEXDUV7k
vrIK4tD5
=IHP9
-----END PGP SIGNATURE-----

--DBgimeyDniszRsRV--
