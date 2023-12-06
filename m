Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E7FC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849848708B;
	Wed,  6 Dec 2023 13:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4EbhjD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546588721A; Wed,  6 Dec 2023 13:16:50 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7131807E4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1d6f4a0958so145872466b.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701865007; x=1702469807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRSIRAmuKINjiqe8Tmp0uf2gfc7kOTwLaTTXo5ca0yk=;
 b=S4EbhjD6pKM4mtVQdVRIiHIzYf6Iv7OblxAK8ROO6S5s0pldKczrl+cy+NMKLVguFZ
 GjsFkeJSsNRSuxY7irmY37Ka7OMWjKyETBwa3Q6VOMWhcluewscfy1u751EBwxsaJv32
 AAu0SHqMIXut6SBNXcmc+9lkVMt+8spdXDrlfVjREf4uEInGvdPSXhztdDul/Vh83xGZ
 NjK1rGst2tZAMmQtPiWBxSimJbgavDvHbuCHJ7uaKs+5amuvvDuEj80umYH83EBJpFhf
 tSgvYMyVi3mpnxD7Ay1gnx6Thhi7uNyOIy/3aOdWAMyyv02tYZ4Fg0EGNFs5AlGfBltM
 CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701865007; x=1702469807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRSIRAmuKINjiqe8Tmp0uf2gfc7kOTwLaTTXo5ca0yk=;
 b=mKF+cEtlF0WV8laZHP0ZyTO4kXtg09/LWfRJEmMiKTSoUr/f8q5f2EPkYl+kiqSZ8k
 d63Mp7iT3J8GNtqBVr0cIQJLRJ5yB3U68AnbcoHKbosAb6/vUSOXomdqxhxvvNLilbw2
 vzfwLlK/Ft7VIhIDKZ2UTRNdXB/miN7nzM7BzWUF7NonOcOZ5U3530GnzEhbkWX5JsPq
 2umvdl1c7zyrpli+mqvFFzgecqzyATxBBiQve0KrEnW4CTh0msGK/jOIGWj8Rc++6kUe
 llNs+rE1vig5orPqt+Sn4O0+eV0cILlRRbCn7LvRS3cck2QWd0yYWTIM3lT37MQnzXwq
 KPiQ==
X-Gm-Message-State: AOJu0Yw2scc3C72hFsHMj2bA3UBWDQrKHyPv/UxbDTyBM3upGqs9hTwz
 KlWNQTvkcAWb7F4uuFBUcC/qxXfkHsGWf0ZqOEA=
X-Google-Smtp-Source: AGHT+IFwrYbdlXLOY7xwF7CyLr/1O7ax5za+mtG8v2X484LXh2HZ+PSu4PlqtQQgWGYOWy3C0YcdASDC1hfsYF1Xeyk=
X-Received: by 2002:a17:906:73c7:b0:a1b:619e:53f7 with SMTP id
 n7-20020a17090673c700b00a1b619e53f7mr3235317ejl.27.1701865006942; Wed, 06 Dec
 2023 04:16:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 Dec 2023 12:16:35 +0000
Message-ID: <CALeDE9O6dS-xKzvmGgts+56HW82CxdoOtqG+1kER8DTW9xS5kQ@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, i@shantur.com,
 u-boot@lists.denx.de, 
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

On Sun, Nov 19, 2023 at 6:55=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all=
.nl> wrote:
>
> > Date: Sat, 18 Nov 2023 23:52:11 +0100
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Hi Heinrich,
>
> > On 11/18/23 22:28, Shantur Rathore wrote:
> > > Hi Heinrich,
> > >
> > > On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> On 11/16/23 19:45, Shantur Rathore wrote:
> > >>> On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
> > >>> <heinrich.schuchardt@canonical.com> wrote:
> > >>>>
> > >>>> On 11/16/23 17:52, Shantur Rathore wrote:
> > >>>>> Hi Simon,
> > >>>>>
> > >>>>> Currently bootstd - bootmethod_efi only looks for the default
> > >>>>> bootxx64.efi in /EFI/boot folder only.
> > >>>>> Generally many distros end up putting their bootloaders in
> > >>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> > >>>>>
> > >>>>> In x86 worlds, the NVRAM is modified and new boot entries are add=
ed to
> > >>>>> support these but in the U-boot world the NVRAM variables are
> > >>>>> read-only.
> > >>>>
> > >>>> I guess you are referring to UEFI boot options. These typically ar=
e not
> > >>>> stored in non-volatile RAM but on a SPI flash device.
> > >>>>
> > >>>
> > >>> Thanks for correcting me.
> > >>>
> > >>>>>
> > >>>>> What would be the best way to implement this?
> > >>>>>
> > >>>>> I was thinking of having a "efi_prefixes" environment variable wh=
ich
> > >>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can t=
ry
> > >>>>> all of them. Will bootmethod_efi be able to support multiple entr=
ies (
> > >>>>> thinking of multiboot ) ?
> > >>>>
> > >>>> On my laptop I have:
> > >>>>
> > >>>> EFI/Microsoft/Boot/bootmgr.efi
> > >>>> EFI/Microsoft/Boot/memtest.efi
> > >>>> EFI/Boot/bootx64.efi
> > >>>> EFI/Boot/fbx64.efi
> > >>>> EFI/Boot/mmx64.efi
> > >>>> EFI/debian/shimx64.efi
> > >>>> EFI/debian/grubx64.efi
> > >>>> EFI/debian/mmx64.efi
> > >>>> EFI/debian/fbx64.efi
> > >>>> EFI/ubuntu/grubx64.efi
> > >>>> EFI/ubuntu/shimx64.efi
> > >>>> EFI/ubuntu/mmx64.efi
> > >>>>
> > >>>> Obviously each installed operating system provides multiple EFI bi=
naries
> > >>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubunt=
u
> > >>>> debian centos" would not be able to describe which file you are lo=
oking
> > >>>> for.
> > >>>>
> > >>>> We already have the U-Boot command line eficonfig and efidebug com=
mands
> > >>>> to set up UEFI boot options which can describe which EFI binary to=
 load
> > >>>> and which command line to pass to it. These are considered by the
> > >>>> existing boot flows.
> > >>>
> > >>> So, I am building a new RockPro64 based cluster and using Canonical
> > >>> MAAS to set them up automatically, booting them up using DHCP and
> > >>> installing them over the network.
> > >>> I configured an Armbian image using Packer to be compatible with MA=
AS
> > >>> and it happily installs it. As part of installation process, a
> > >>> grub-install is run which installs the grub efi,
> > >>> this EFI ends up in EFI/debian instead of expected EFI/boot.
> > >>> To be able to make it boot, I have to add commands to move it to
> > >>> EFI/boot. I am trying to find a way in U-Boot that would allow me t=
o
> > >>> skip this step.
> > >>> With eficonfig if I understand correctly, it would need manual
> > >>> intervention to create boot entries.
> > >>>
> > >>>>
> > >>>> If you are installing the shim-signed package on Ubuntu, the EFI b=
oot
> > >>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the c=
ontent
> > >>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices=
() and
> > >>>> therefore should work with current U-Boot.
> > >>>>
> > >>>> Patches are pending upstream to make EFI variables writable from L=
inux
> > >>>> if they are stored in the RPMB partition in the eMMC. See this ser=
ies:
> > >>>>
> > >>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.k=
ojima@linaro.org/
> > >>>>
> > >>>
> > >>> Would it be possible to save it in SPI Flash as the U-Boot environm=
ent ?
> > >>
> > >> Currently this is not supported by U-Boot.
> > >>
> > >> The U-Boot environment variables can be stored in lots of different
> > >> places SPI flash is only one of these. But none of these locations i=
s
> > >> protected from OS access which would be preferable for UEFI variable=
s
> > >> for security reasons.
> > >>
> > >> To support boards without eMMC the right way forward would be writin=
g a
> > >> new implementation of the OP-TEE standalone MM which writes the
> > >> variables to SPI flash instead of the RPMB partition and ensures tha=
t
> > >> the SPI flash' MMIO registers are protected against access from the
> > >> non-secure world.
> > >
> > > Thanks for explaining this to me.
> > > This seems like a long way to go, for now what would be an acceptable
> > > solution, some options are
> > >
> > > 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
> > > debian") variable which is ready by bootmeth_efi and used as
> > > efi/<efi_prefix> instead of efi/boot.
> > > 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
> > > present all them as bootflows to bootstd.
> >
> > As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.ef=
i
> > don't exist. I would prefer not to add any distro specific stuff in
> > upstream U-Boot. Instead we will continue to drive what Linaro has
> > suggested to improve U-Boot EFI variables support in Linux.
>
> I agree that adding hacks like this is not a good idea.
>
> The Linaro approach that involves OP-TEE makes for a fairly complex
> solution.  And there are plenty of boards that have neither eMMC nor
> SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> for most "hobbyist" boards it isn't) storing the EFI variables in a
> file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> Kconfig option) is a workable alternative.  And this is actually what
> the rockpro64-rk3399_defconfig enables.
>
> I noticed that the latest EBBR attempts to standardize this:
>
>   https://arm-software.github.io/ebbr/index.html#document-chapter5-variab=
le-storage
>
> Not sure what the status here is.  But if the Linux kernel folks
> accept that alternative implementations for runtime EFI variable
> access are a thing, then a method that modifies the file would be
> possible as well.  Or maybe it is good enough to implement support for
> this in the efivar library.
>
> That said, Linux distros probably should install their EFI bootloader
> as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
> distros already do this.  This would make the distro work "out of the
> box" on a lot more boards.

I believe the EFI/BOOT/BOOTxxxx.EFI is the EFI fallback mechanism (not
sure it that's the proper spec name but it's what I've heard it
referred to) and tha's the way Fedora generally works to boot devices
that don't have working set variable where the boot entry can be
updated. I had assumed that was part of the standard as, at least in
Fedora, that has always been there and explicitly the way we made UEFI
work on U-Boot from the outset.

Peter
