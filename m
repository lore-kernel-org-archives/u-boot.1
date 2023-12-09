Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FEFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC07875DB;
	Sat,  9 Dec 2023 23:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="PHwj7x8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601D3875E3; Sat,  9 Dec 2023 23:42:28 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5728758F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 23:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7c522ea69e8so791424241.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702161744; x=1702766544;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYj2iknE2gc2aTsT3JhJRTZqTc2l4zR03SJgxpKZ6ao=;
 b=PHwj7x8E6hvB80uA14A5wspTVV9jssYQCKT/izCYy3rh5ZBVJKVA275Igpb0J8jHNd
 FcyE3yN15SF9tkJqVfQGBYKTsEK/0bTET7rNoQCn8FGhkYkQcRd+GWp0LEeSFBuzrH/b
 DJhw4hDrvRLYYg7SIeAcmMfKmJ3B8zIU992YgdncrlfgjWeJ+NiyWPbSHgdt1x5VGXo6
 x1xEeBg4FAXIsgy2PhvTfZ1GbQToPW7gXEzLccPGLJ03PP7Zx+R1sDkdpUAwt+xsw5ZJ
 tyEcIJwh0B5UO3iVKo+Sd2ws/uklDa0MpJMt6YO+963/DrhPqDvH+7SvA4bo/fUPISOf
 R7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702161744; x=1702766544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYj2iknE2gc2aTsT3JhJRTZqTc2l4zR03SJgxpKZ6ao=;
 b=ECC1sTLDtUHCP07zQbRUr1aCQsUq4FLa971mLcJX4y5UyPNj+m5PdSYlh+A3p49ojS
 KkUPSA7HYyJJk4I8JcKDbYgjzyu2JgEp5eM49jUPwwopwge8NZNGYUJ3BImhHH9K/0wc
 YM/xkuDWgRY8VOs5nikmJfpT1SISpO65ds6XzlFgiGHt/oxu+EDioYeKj7v3CJS8Zrzt
 PeE2qyk8rYitmLsNTPj2YGbi859AOQMmTyBOnMyiZj48Q6bIHrZcE8hrwDogMGjz+LaY
 quyDNqPwQBk72gTdUssn2O35T/KDQdivrDUhzugnECzotvrBJzNKHi+dhp5P0qPXY9uP
 +pLQ==
X-Gm-Message-State: AOJu0YwB0l2f3JyFz/KEYwxl4Hm/pbSkV4c2oB034MaX2heK22Ref06+
 hEHCtAMtPjNrXNJgL2+t7HrJP+/d1HfYtFV/XqSDEg==
X-Google-Smtp-Source: AGHT+IEaDF9quc15ROOGK5n0BxSBG3n0H0yo4rPi4d1Xtusz2BP7GkS62NGIYNAj4itafDDk29wIwMOZd1eyCPAbqcQ=
X-Received: by 2002:a05:6122:168e:b0:4b2:c554:dfca with SMTP id
 14-20020a056122168e00b004b2c554dfcamr1998953vkl.25.1702161744229; Sat, 09 Dec
 2023 14:42:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CALeDE9O6dS-xKzvmGgts+56HW82CxdoOtqG+1kER8DTW9xS5kQ@mail.gmail.com>
 <CABEcMwWY96f+YZst4y-Xsv3NLbVeG+JTxewuULgWQf3W0E2w-Q@mail.gmail.com>
In-Reply-To: <CABEcMwWY96f+YZst4y-Xsv3NLbVeG+JTxewuULgWQf3W0E2w-Q@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 22:42:13 +0000
Message-ID: <CABEcMwWkp6aBOwKowT0YRme8qe=5ZyUx6zFQHOJ3+Bcu4ECKJw@mail.gmail.com>
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

On Sat, Dec 9, 2023 at 4:26=E2=80=AFPM Shantur Rathore <i@shantur.com> wrot=
e:
>
> Hi Peter,
>
> On Wed, Dec 6, 2023 at 12:16=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Sun, Nov 19, 2023 at 6:55=E2=80=AFPM Mark Kettenis <mark.kettenis@xs=
4all.nl> wrote:
> > >
> > > > Date: Sat, 18 Nov 2023 23:52:11 +0100
> > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >
> > > Hi Heinrich,
> > >
> > > > On 11/18/23 22:28, Shantur Rathore wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
> > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >>
> > > > >> On 11/16/23 19:45, Shantur Rathore wrote:
> > > > >>> On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
> > > > >>> <heinrich.schuchardt@canonical.com> wrote:
> > > > >>>>
> > > > >>>> On 11/16/23 17:52, Shantur Rathore wrote:
> > > > >>>>> Hi Simon,
> > > > >>>>>
> > > > >>>>> Currently bootstd - bootmethod_efi only looks for the default
> > > > >>>>> bootxx64.efi in /EFI/boot folder only.
> > > > >>>>> Generally many distros end up putting their bootloaders in
> > > > >>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> > > > >>>>>
> > > > >>>>> In x86 worlds, the NVRAM is modified and new boot entries are=
 added to
> > > > >>>>> support these but in the U-boot world the NVRAM variables are
> > > > >>>>> read-only.
> > > > >>>>
> > > > >>>> I guess you are referring to UEFI boot options. These typicall=
y are not
> > > > >>>> stored in non-volatile RAM but on a SPI flash device.
> > > > >>>>
> > > > >>>
> > > > >>> Thanks for correcting me.
> > > > >>>
> > > > >>>>>
> > > > >>>>> What would be the best way to implement this?
> > > > >>>>>
> > > > >>>>> I was thinking of having a "efi_prefixes" environment variabl=
e which
> > > > >>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi c=
an try
> > > > >>>>> all of them. Will bootmethod_efi be able to support multiple =
entries (
> > > > >>>>> thinking of multiboot ) ?
> > > > >>>>
> > > > >>>> On my laptop I have:
> > > > >>>>
> > > > >>>> EFI/Microsoft/Boot/bootmgr.efi
> > > > >>>> EFI/Microsoft/Boot/memtest.efi
> > > > >>>> EFI/Boot/bootx64.efi
> > > > >>>> EFI/Boot/fbx64.efi
> > > > >>>> EFI/Boot/mmx64.efi
> > > > >>>> EFI/debian/shimx64.efi
> > > > >>>> EFI/debian/grubx64.efi
> > > > >>>> EFI/debian/mmx64.efi
> > > > >>>> EFI/debian/fbx64.efi
> > > > >>>> EFI/ubuntu/grubx64.efi
> > > > >>>> EFI/ubuntu/shimx64.efi
> > > > >>>> EFI/ubuntu/mmx64.efi
> > > > >>>>
> > > > >>>> Obviously each installed operating system provides multiple EF=
I binaries
> > > > >>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "u=
buntu
> > > > >>>> debian centos" would not be able to describe which file you ar=
e looking
> > > > >>>> for.
> > > > >>>>
> > > > >>>> We already have the U-Boot command line eficonfig and efidebug=
 commands
> > > > >>>> to set up UEFI boot options which can describe which EFI binar=
y to load
> > > > >>>> and which command line to pass to it. These are considered by =
the
> > > > >>>> existing boot flows.
> > > > >>>
> > > > >>> So, I am building a new RockPro64 based cluster and using Canon=
ical
> > > > >>> MAAS to set them up automatically, booting them up using DHCP a=
nd
> > > > >>> installing them over the network.
> > > > >>> I configured an Armbian image using Packer to be compatible wit=
h MAAS
> > > > >>> and it happily installs it. As part of installation process, a
> > > > >>> grub-install is run which installs the grub efi,
> > > > >>> this EFI ends up in EFI/debian instead of expected EFI/boot.
> > > > >>> To be able to make it boot, I have to add commands to move it t=
o
> > > > >>> EFI/boot. I am trying to find a way in U-Boot that would allow =
me to
> > > > >>> skip this step.
> > > > >>> With eficonfig if I understand correctly, it would need manual
> > > > >>> intervention to create boot entries.
> > > > >>>
> > > > >>>>
> > > > >>>> If you are installing the shim-signed package on Ubuntu, the E=
FI boot
> > > > >>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using t=
he content
> > > > >>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServ=
ices() and
> > > > >>>> therefore should work with current U-Boot.
> > > > >>>>
> > > > >>>> Patches are pending upstream to make EFI variables writable fr=
om Linux
> > > > >>>> if they are stored in the RPMB partition in the eMMC. See this=
 series:
> > > > >>>>
> > > > >>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahi=
sa.kojima@linaro.org/
> > > > >>>>
> > > > >>>
> > > > >>> Would it be possible to save it in SPI Flash as the U-Boot envi=
ronment ?
> > > > >>
> > > > >> Currently this is not supported by U-Boot.
> > > > >>
> > > > >> The U-Boot environment variables can be stored in lots of differ=
ent
> > > > >> places SPI flash is only one of these. But none of these locatio=
ns is
> > > > >> protected from OS access which would be preferable for UEFI vari=
ables
> > > > >> for security reasons.
> > > > >>
> > > > >> To support boards without eMMC the right way forward would be wr=
iting a
> > > > >> new implementation of the OP-TEE standalone MM which writes the
> > > > >> variables to SPI flash instead of the RPMB partition and ensures=
 that
> > > > >> the SPI flash' MMIO registers are protected against access from =
the
> > > > >> non-secure world.
> > > > >
> > > > > Thanks for explaining this to me.
> > > > > This seems like a long way to go, for now what would be an accept=
able
> > > > > solution, some options are
> > > > >
> > > > > 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
> > > > > debian") variable which is ready by bootmeth_efi and used as
> > > > > efi/<efi_prefix> instead of efi/boot.
> > > > > 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder a=
nd
> > > > > present all them as bootflows to bootstd.
> > > >
> > > > As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxx=
x.efi
> > > > don't exist. I would prefer not to add any distro specific stuff in
> > > > upstream U-Boot. Instead we will continue to drive what Linaro has
> > > > suggested to improve U-Boot EFI variables support in Linux.
> > >
> > > I agree that adding hacks like this is not a good idea.
> > >
> > > The Linaro approach that involves OP-TEE makes for a fairly complex
> > > solution.  And there are plenty of boards that have neither eMMC nor
> > > SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> > > for most "hobbyist" boards it isn't) storing the EFI variables in a
> > > file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> > > Kconfig option) is a workable alternative.  And this is actually what
> > > the rockpro64-rk3399_defconfig enables.
> > >
> > > I noticed that the latest EBBR attempts to standardize this:
> > >
> > >   https://arm-software.github.io/ebbr/index.html#document-chapter5-va=
riable-storage
> > >
> > > Not sure what the status here is.  But if the Linux kernel folks
> > > accept that alternative implementations for runtime EFI variable
> > > access are a thing, then a method that modifies the file would be
> > > possible as well.  Or maybe it is good enough to implement support fo=
r
> > > this in the efivar library.
> > >
> > > That said, Linux distros probably should install their EFI bootloader
> > > as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
> > > distros already do this.  This would make the distro work "out of the
> > > box" on a lot more boards.
> >
> > I believe the EFI/BOOT/BOOTxxxx.EFI is the EFI fallback mechanism (not
> > sure it that's the proper spec name but it's what I've heard it
> > referred to) and tha's the way Fedora generally works to boot devices
> > that don't have working set variable where the boot entry can be
> > updated. I had assumed that was part of the standard as, at least in
> > Fedora, that has always been there and explicitly the way we made UEFI
> > work on U-Boot from the outset.
>
> This is definitely the standard for Removable Storage as per the spec.
> Section 3.5.1.1 Removable Media Boot Behavior - Link [0]
>
> [0] - https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29=
.pdf
>
> But the spec isn't stopping the firmware to perform scan to be able to li=
st
> the possible bootable EFIs, in-fact it says firmware can do special thing=
s as in
> Section  3.4.3 Boot Option Variables Default Boot Behavior
>
> @Simon Glass - If one was to implement such a scanning behaviour (
> knowing it might not be
> merged ), how should one go about this?
>
> As I understand, the bootmeth_efi is expected to provide only 1
> bootflow for a partition, what would
> be the best way for bootmeth_efi to provide multiple bootflows for
> each partition.
>
> Kind regards,
> Shantur

Throwing spanner in the works, with Unified Kernel Image coming in,
it will be required to implement the scanning for EFI files.

https://github.com/uapi-group/specifications/blob/main/specs/boot_loader_sp=
ecification.md#locating-boot-entries

Kind regards,
Shantur
