Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483DEC5AE5B
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 17:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE6086D0E;
	Sun, 19 Nov 2023 18:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="H2saiZi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F34868BF; Sun, 19 Nov 2023 18:38:23 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071198701F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 18:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 5a44726b-8702-11ee-abd3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 5a44726b-8702-11ee-abd3-005056999439;
 Sun, 19 Nov 2023 18:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=SguFD/HiDP2G8BFzZEOopSxdl4/B7pcVRgeliq1dN0g=;
 b=H2saiZi3WV0UBXJb8a6sjuuEssKXcLRHqZbnKAhRL0Nq70NCaRZMwixLnFp0lrM6+YYVEiG6CzeTx
 jUH8w22aqAJ17XNZrFUyVbuc9CoZ5LVZf7gRg53y6FS6oFomZPdAL74Qv47zGXq/eYu/iTgroZuEgd
 EWuzpw2GsuNtWWE79e9NTFj8O0GP8ZBd2bBNyaul6iYiO41P9kSiPqyi91LJcPcnps9vOF14R9lIB3
 ULcaAfVnLnWdLkk53MmpM2CwyIPfaVxOeOQmh67+ildtqAILVQkiYw+Bj/kKyPjsAYK6X+6FuX3N42
 PowLgW+nR5sClkET/lttz6voqDt3j6Q==
X-KPN-MID: 33|T0JU03f+OO0w5EtaZr/owX4VSMYTnE0z/TWXNDzGnKWJHxHHdy6fr9jvi1WwoLT
 mkLJ4R/UT+aOx88E6gB3NYtzV07CgV2j85gHydu6bN74=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WZAwNb6Qiug27SSGl3ZMZ/zvLNhpOYVEXoLZ/C08/VX/lyqzGH0pedkcou2iyxc
 1XGxp0C6/6jcHD08MUE9yxA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6c87c6f9-8702-11ee-9dc8-00505699772e;
 Sun, 19 Nov 2023 18:38:18 +0100 (CET)
Date: Sun, 19 Nov 2023 18:38:17 +0100
Message-Id: <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: i@shantur.com, u-boot@lists.denx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, trini@konsulko.com
In-Reply-To: <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com> (message
 from Heinrich Schuchardt on Sat, 18 Nov 2023 23:52:11 +0100)
Subject: Re: bootstd: Support for distro specific EFI folders
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> Date: Sat, 18 Nov 2023 23:52:11 +0100
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hi Heinrich,

> On 11/18/23 22:28, Shantur Rathore wrote:
> > Hi Heinrich,
> > 
> > On Fri, Nov 17, 2023 at 3:12 PM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/16/23 19:45, Shantur Rathore wrote:
> >>> On Thu, Nov 16, 2023 at 6:15 PM Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 11/16/23 17:52, Shantur Rathore wrote:
> >>>>> Hi Simon,
> >>>>>
> >>>>> Currently bootstd - bootmethod_efi only looks for the default
> >>>>> bootxx64.efi in /EFI/boot folder only.
> >>>>> Generally many distros end up putting their bootloaders in
> >>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> >>>>>
> >>>>> In x86 worlds, the NVRAM is modified and new boot entries are added to
> >>>>> support these but in the U-boot world the NVRAM variables are
> >>>>> read-only.
> >>>>
> >>>> I guess you are referring to UEFI boot options. These typically are not
> >>>> stored in non-volatile RAM but on a SPI flash device.
> >>>>
> >>>
> >>> Thanks for correcting me.
> >>>
> >>>>>
> >>>>> What would be the best way to implement this?
> >>>>>
> >>>>> I was thinking of having a "efi_prefixes" environment variable which
> >>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
> >>>>> all of them. Will bootmethod_efi be able to support multiple entries (
> >>>>> thinking of multiboot ) ?
> >>>>
> >>>> On my laptop I have:
> >>>>
> >>>> EFI/Microsoft/Boot/bootmgr.efi
> >>>> EFI/Microsoft/Boot/memtest.efi
> >>>> EFI/Boot/bootx64.efi
> >>>> EFI/Boot/fbx64.efi
> >>>> EFI/Boot/mmx64.efi
> >>>> EFI/debian/shimx64.efi
> >>>> EFI/debian/grubx64.efi
> >>>> EFI/debian/mmx64.efi
> >>>> EFI/debian/fbx64.efi
> >>>> EFI/ubuntu/grubx64.efi
> >>>> EFI/ubuntu/shimx64.efi
> >>>> EFI/ubuntu/mmx64.efi
> >>>>
> >>>> Obviously each installed operating system provides multiple EFI binaries
> >>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
> >>>> debian centos" would not be able to describe which file you are looking
> >>>> for.
> >>>>
> >>>> We already have the U-Boot command line eficonfig and efidebug commands
> >>>> to set up UEFI boot options which can describe which EFI binary to load
> >>>> and which command line to pass to it. These are considered by the
> >>>> existing boot flows.
> >>>
> >>> So, I am building a new RockPro64 based cluster and using Canonical
> >>> MAAS to set them up automatically, booting them up using DHCP and
> >>> installing them over the network.
> >>> I configured an Armbian image using Packer to be compatible with MAAS
> >>> and it happily installs it. As part of installation process, a
> >>> grub-install is run which installs the grub efi,
> >>> this EFI ends up in EFI/debian instead of expected EFI/boot.
> >>> To be able to make it boot, I have to add commands to move it to
> >>> EFI/boot. I am trying to find a way in U-Boot that would allow me to
> >>> skip this step.
> >>> With eficonfig if I understand correctly, it would need manual
> >>> intervention to create boot entries.
> >>>
> >>>>
> >>>> If you are installing the shim-signed package on Ubuntu, the EFI boot
> >>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
> >>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
> >>>> therefore should work with current U-Boot.
> >>>>
> >>>> Patches are pending upstream to make EFI variables writable from Linux
> >>>> if they are stored in the RPMB partition in the eMMC. See this series:
> >>>>
> >>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/
> >>>>
> >>>
> >>> Would it be possible to save it in SPI Flash as the U-Boot environment ?
> >>
> >> Currently this is not supported by U-Boot.
> >>
> >> The U-Boot environment variables can be stored in lots of different
> >> places SPI flash is only one of these. But none of these locations is
> >> protected from OS access which would be preferable for UEFI variables
> >> for security reasons.
> >>
> >> To support boards without eMMC the right way forward would be writing a
> >> new implementation of the OP-TEE standalone MM which writes the
> >> variables to SPI flash instead of the RPMB partition and ensures that
> >> the SPI flash' MMIO registers are protected against access from the
> >> non-secure world.
> > 
> > Thanks for explaining this to me.
> > This seems like a long way to go, for now what would be an acceptable
> > solution, some options are
> > 
> > 1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
> > debian") variable which is ready by bootmeth_efi and used as
> > efi/<efi_prefix> instead of efi/boot.
> > 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
> > present all them as bootflows to bootstd.
> 
> As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/bootxxxx.efi 
> don't exist. I would prefer not to add any distro specific stuff in 
> upstream U-Boot. Instead we will continue to drive what Linaro has 
> suggested to improve U-Boot EFI variables support in Linux.

I agree that adding hacks like this is not a good idea.

The Linaro approach that involves OP-TEE makes for a fairly complex
solution.  And there are plenty of boards that have neither eMMC nor
SPI flash.  If Secure Boot is not a requirement (and I'd argue that
for most "hobbyist" boards it isn't) storing the EFI variables in a
file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
Kconfig option) is a workable alternative.  And this is actually what
the rockpro64-rk3399_defconfig enables.

I noticed that the latest EBBR attempts to standardize this:

  https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Not sure what the status here is.  But if the Linux kernel folks
accept that alternative implementations for runtime EFI variable
access are a thing, then a method that modifies the file would be
possible as well.  Or maybe it is good enough to implement support for
this in the efivar library.

That said, Linux distros probably should install their EFI bootloader
as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
distros already do this.  This would make the distro work "out of the
box" on a lot more boards.
