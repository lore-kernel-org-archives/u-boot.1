Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAA2C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 16:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB9787215;
	Sat,  9 Dec 2023 17:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="Fis8YHqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767D0874B7; Sat,  9 Dec 2023 17:26:59 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F91A8717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 17:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46487cb65f4so984809137.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702139215; x=1702744015;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUmPGrb5bSIVZMxw/pj1qTyEYYltnX0Ojx7v6EMs4cw=;
 b=Fis8YHqcsGzAXfa3nz+9QYwufDd3cigfE7TEKp2xSpzwrdV25EmkF/Qz4yjW5/VsjB
 l7OGfPsXfM4xI74v2ebsaRjbYU8mUqFvxY2QqAPFqcXPr2u9TAvWVricqX9cdq7IEsjp
 Rhzi9OAOTNHipLhOgubmiqk/Nb2Mae6EHSQcXNWCeydsA6ZmDIjf+jnOfvU9qV2NaACb
 V5WOcs3mEtxj8W7wfI6DuAb9HhFo6acsErt6qSVedjy+HoobLVqejOftcbJAF9gI0pgH
 kYdUn1Ksn1OsOJwHjYstTg65pX8AT1NaOHLNO6nxkslJ7FyGLaQoH8PQj2KOBafQMRYK
 yN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702139215; x=1702744015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUmPGrb5bSIVZMxw/pj1qTyEYYltnX0Ojx7v6EMs4cw=;
 b=Rfkdzx62kKBPSY674p58gGiVQScvUPcDOJNOdamW+tM12cWeQeJnxuWgtrJeyx9kK5
 NuXkaQfELPAz03Fhk6MPlCBN0ESkA8qtd6sJDk0tIqstR3DXINgPGrn8rM4sURA1qA2q
 c3v/u8UYlbJ78qasbwhPzdbAipDftZ548+OJahrnDvLowet3VdYu+YH7nTS/tXKdDlSE
 7YWa8qPDNL6zXS6cYTzjM0x9JmQkp/5suUvBT2tx0hBwua/XftzG+d+wGkrEUNwauGQS
 lsPfCZjEshqOqHAyVLw2QryH0CdKk3al7v6RId3/MrZkzAEqkR9iFZo36b2Hlosq93zy
 ePIw==
X-Gm-Message-State: AOJu0Ywt5gshiNENhZPr0uvM9gjeqU3jgOVYG6jnYILpjt3dF9ALQwd6
 XIrYJjZOqdpfyB+6CaUfvF784HYgRd8GrynQLmjTeg==
X-Google-Smtp-Source: AGHT+IEiCTIsMX2fYsW/b2MkXWG0tSzFuz0PI2I6wh3Xre0DY/TntKKdCpazYaogSjjHS6wJr0hYAuj1snOo8G/G8aQ=
X-Received: by 2002:a1f:f405:0:b0:4b2:c554:dfcd with SMTP id
 s5-20020a1ff405000000b004b2c554dfcdmr1521499vkh.28.1702139215139; Sat, 09 Dec
 2023 08:26:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CALeDE9O6dS-xKzvmGgts+56HW82CxdoOtqG+1kER8DTW9xS5kQ@mail.gmail.com>
In-Reply-To: <CALeDE9O6dS-xKzvmGgts+56HW82CxdoOtqG+1kER8DTW9xS5kQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 16:26:43 +0000
Message-ID: <CABEcMwWY96f+YZst4y-Xsv3NLbVeG+JTxewuULgWQf3W0E2w-Q@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de,
 sjg@chromium.org, ilias.apalodimas@linaro.org, trini@konsulko.com
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

Hi Peter,

On Wed, Dec 6, 2023 at 12:16=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Sun, Nov 19, 2023 at 6:55=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4a=
ll.nl> wrote:
> >
> > > Date: Sat, 18 Nov 2023 23:52:11 +0100
> > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > Hi Heinrich,
> >
> > > On 11/18/23 22:28, Shantur Rathore wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > >>
> > > >> On 11/16/23 19:45, Shantur Rathore wrote:
> > > >>> On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
> > > >>> <heinrich.schuchardt@canonical.com> wrote:
> > > >>>>
> > > >>>> On 11/16/23 17:52, Shantur Rathore wrote:
> > > >>>>> Hi Simon,
> > > >>>>>
> > > >>>>> Currently bootstd - bootmethod_efi only looks for the default
> > > >>>>> bootxx64.efi in /EFI/boot folder only.
> > > >>>>> Generally many distros end up putting their bootloaders in
> > > >>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> > > >>>>>
> > > >>>>> In x86 worlds, the NVRAM is modified and new boot entries are a=
dded to
> > > >>>>> support these but in the U-boot world the NVRAM variables are
> > > >>>>> read-only.
> > > >>>>
> > > >>>> I guess you are referring to UEFI boot options. These typically =
are not
> > > >>>> stored in non-volatile RAM but on a SPI flash device.
> > > >>>>
> > > >>>
> > > >>> Thanks for correcting me.
> > > >>>
> > > >>>>>
> > > >>>>> What would be the best way to implement this?
> > > >>>>>
> > > >>>>> I was thinking of having a "efi_prefixes" environment variable =
which
> > > >>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can=
 try
> > > >>>>> all of them. Will bootmethod_efi be able to support multiple en=
tries (
> > > >>>>> thinking of multiboot ) ?
> > > >>>>
> > > >>>> On my laptop I have:
> > > >>>>
> > > >>>> EFI/Microsoft/Boot/bootmgr.efi
> > > >>>> EFI/Microsoft/Boot/memtest.efi
> > > >>>> EFI/Boot/bootx64.efi
> > > >>>> EFI/Boot/fbx64.efi
> > > >>>> EFI/Boot/mmx64.efi
> > > >>>> EFI/debian/shimx64.efi
> > > >>>> EFI/debian/grubx64.efi
> > > >>>> EFI/debian/mmx64.efi
> > > >>>> EFI/debian/fbx64.efi
> > > >>>> EFI/ubuntu/grubx64.efi
> > > >>>> EFI/ubuntu/shimx64.efi
> > > >>>> EFI/ubuntu/mmx64.efi
> > > >>>>
> > > >>>> Obviously each installed operating system provides multiple EFI =
binaries
> > > >>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubu=
ntu
> > > >>>> debian centos" would not be able to describe which file you are =
looking
> > > >>>> for.
> > > >>>>
> > > >>>> We already have the U-Boot command line eficonfig and efidebug c=
ommands
> > > >>>> to set up UEFI boot options which can describe which EFI binary =
to load
> > > >>>> and which command line to pass to it. These are considered by th=
e
> > > >>>> existing boot flows.
> > > >>>
> > > >>> So, I am building a new RockPro64 based cluster and using Canonic=
al
> > > >>> MAAS to set them up automatically, booting them up using DHCP and
> > > >>> installing them over the network.
> > > >>> I configured an Armbian image using Packer to be compatible with =
MAAS
> > > >>> and it happily installs it. As part of installation process, a
> > > >>> grub-install is run which installs the grub efi,
> > > >>> this EFI ends up in EFI/debian instead of expected EFI/boot.
> > > >>> To be able to make it boot, I have to add commands to move it to
> > > >>> EFI/boot. I am trying to find a way in U-Boot that would allow me=
 to
> > > >>> skip this step.
> > > >>> With eficonfig if I understand correctly, it would need manual
> > > >>> intervention to create boot entries.
> > > >>>
> > > >>>>
> > > >>>> If you are installing the shim-signed package on Ubuntu, the EFI=
 boot
> > > >>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the=
 content
> > > >>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServic=
es() and
> > > >>>> therefore should work with current U-Boot.
> > > >>>>
> > > >>>> Patches are pending upstream to make EFI variables writable from=
 Linux
> > > >>>> if they are stored in the RPMB partition in the eMMC. See this s=
eries:
> > > >>>>
> > > >>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa=
.kojima@linaro.org/
> > > >>>>
> > > >>>
> > > >>> Would it be possible to save it in SPI Flash as the U-Boot enviro=
nment ?
> > > >>
> > > >> Currently this is not supported by U-Boot.
> > > >>
> > > >> The U-Boot environment variables can be stored in lots of differen=
t
> > > >> places SPI flash is only one of these. But none of these locations=
 is
> > > >> protected from OS access which would be preferable for UEFI variab=
les
> > > >> for security reasons.
> > > >>
> > > >> To support boards without eMMC the right way forward would be writ=
ing a
> > > >> new implementation of the OP-TEE standalone MM which writes the
> > > >> variables to SPI flash instead of the RPMB partition and ensures t=
hat
> > > >> the SPI flash' MMIO registers are protected against access from th=
e
> > > >> non-secure world.
> > > >
> > > > Thanks for explaining this to me.
> > > > This seems like a long way to go, for now what would be an acceptab=
le
> > > > solution, some options are
> > > >
> > > > 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
> > > > debian") variable which is ready by bootmeth_efi and used as
> > > > efi/<efi_prefix> instead of efi/boot.
> > > > 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
> > > > present all them as bootflows to bootstd.
> > >
> > > As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.=
efi
> > > don't exist. I would prefer not to add any distro specific stuff in
> > > upstream U-Boot. Instead we will continue to drive what Linaro has
> > > suggested to improve U-Boot EFI variables support in Linux.
> >
> > I agree that adding hacks like this is not a good idea.
> >
> > The Linaro approach that involves OP-TEE makes for a fairly complex
> > solution.  And there are plenty of boards that have neither eMMC nor
> > SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> > for most "hobbyist" boards it isn't) storing the EFI variables in a
> > file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> > Kconfig option) is a workable alternative.  And this is actually what
> > the rockpro64-rk3399_defconfig enables.
> >
> > I noticed that the latest EBBR attempts to standardize this:
> >
> >   https://arm-software.github.io/ebbr/index.html#document-chapter5-vari=
able-storage
> >
> > Not sure what the status here is.  But if the Linux kernel folks
> > accept that alternative implementations for runtime EFI variable
> > access are a thing, then a method that modifies the file would be
> > possible as well.  Or maybe it is good enough to implement support for
> > this in the efivar library.
> >
> > That said, Linux distros probably should install their EFI bootloader
> > as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
> > distros already do this.  This would make the distro work "out of the
> > box" on a lot more boards.
>
> I believe the EFI/BOOT/BOOTxxxx.EFI is the EFI fallback mechanism (not
> sure it that's the proper spec name but it's what I've heard it
> referred to) and tha's the way Fedora generally works to boot devices
> that don't have working set variable where the boot entry can be
> updated. I had assumed that was part of the standard as, at least in
> Fedora, that has always been there and explicitly the way we made UEFI
> work on U-Boot from the outset.

This is definitely the standard for Removable Storage as per the spec.
Section 3.5.1.1 Removable Media Boot Behavior - Link [0]

[0] - https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.p=
df

But the spec isn't stopping the firmware to perform scan to be able to list
the possible bootable EFIs, in-fact it says firmware can do special things =
as in
Section  3.4.3 Boot Option Variables Default Boot Behavior

@Simon Glass - If one was to implement such a scanning behaviour (
knowing it might not be
merged ), how should one go about this?

As I understand, the bootmeth_efi is expected to provide only 1
bootflow for a partition, what would
be the best way for bootmeth_efi to provide multiple bootflows for
each partition.

Kind regards,
Shantur
