Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3030C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C036A877D8;
	Sat,  2 Dec 2023 19:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U7+A3eAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AABF877C8; Sat,  2 Dec 2023 19:33:31 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4020877D1
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a187cd4eb91so412716266b.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542008; x=1702146808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7UqKglbQ5GDrQh+1NcaN1KnPqgzVpXvrXJkUqFQLN8=;
 b=U7+A3eAVkp+kjbV1FI3QL+Rx1vCH4dkNQjfo4Fe4SMIxI+eRH4jQs22I+sC/GvV2jF
 1GOyc/7irpvxDWbvN15A/2YVcNABoXXrfsV6/Qk4bpC5sXTLYvzkMtFH6D2/W9tjiaYW
 CpVYH1Y8B87n+rSDkh55UlaIdJqjW+IMIwMkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542008; x=1702146808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7UqKglbQ5GDrQh+1NcaN1KnPqgzVpXvrXJkUqFQLN8=;
 b=M5L0Mbf1fAM/RnJL1LBBeOwhFI/PcO+Mi0uZ+h6QqYTPD9CAg/u2LWBbDAmvbeJIdk
 mqm0J7fYDqDxKJIxIGSaW33zhzfmQHS4Zy4tLJiww3QDpKWnMcAngetxrdpLm49YLNa3
 L1D9CWt5K69csun7H+xGGkKV1FBf+GC7WGjjrTKbbSkrDijxszvYKmYHEuTSZHb/ZhaA
 oxfVCSPdB3x9epQPk61OKXXgWNahxRV3yihBwEgwWqAQDT+usC04d8VHhnT+QH/UvWjQ
 PvvyQ0AzFDo7pYphV8P7A+UuzGxhuAVNWtjQUZG4RP4z7/UGva+I2EHJIGnnqdiMHBxZ
 AUTg==
X-Gm-Message-State: AOJu0YxQDjpRHQSEljn4yER3tNFbKppSVaa4VDsa9u/JbZlMEJw/HxJu
 2melCUYS0Crhv0LBy75YyyYfHF9AhgMNl8L+7AP27DHSdsee8XnXi+XbmQ==
X-Google-Smtp-Source: AGHT+IHtb0NkbKKleJS/+ZAPkC8RvQ5/nnPwDJNYKP5qgyIlAkYtz0Nami2K9K9ZELtpgUveq/c0eV25tFUmLip4rBs=
X-Received: by 2002:a17:906:2c5b:b0:9b7:37de:601a with SMTP id
 f27-20020a1709062c5b00b009b737de601amr900763ejh.49.1701542007935; Sat, 02 Dec
 2023 10:33:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
In-Reply-To: <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:12 -0700
Message-ID: <CAPnjgZ04C=_MoCjKBYUdmBXyQn-zviAMQJxMHQAfj1MwvqOMzw@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, i@shantur.com,
 u-boot@lists.denx.de, trini@konsulko.com
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

Hi,

On Mon, 20 Nov 2023 at 00:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Mark,
>
> On Sun, 19 Nov 2023 at 19:38, Mark Kettenis <mark.kettenis@xs4all.nl> wro=
te:
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
>
> + 1
>
> >
> > The Linaro approach that involves OP-TEE makes for a fairly complex
> > solution.  And there are plenty of boards that have neither eMMC nor
> > SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> > for most "hobbyist" boards it isn't) storing the EFI variables in a
> > file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> > Kconfig option) is a workable alternative.  And this is actually what
> > the rockpro64-rk3399_defconfig enables.
>
> Even in that case, preseeding the variables can enable uefi secure
> boot. But you have to establish a chain of trust since the
> authenticated EFI variables are part of  the u-boot binary.
>
> >
> > I noticed that the latest EBBR attempts to standardize this:
> >
> >   https://arm-software.github.io/ebbr/index.html#document-chapter5-vari=
able-storage
> >
> > Not sure what the status here is.
>
> Heinrich and I were the ones who proposed the standardization. The
> idea is to eventually fix it for all boards and we are working on it,
>
> > But if the Linux kernel folks
> > accept that alternative implementations for runtime EFI variable
> > access are a thing, then a method that modifies the file would be
> > possible as well.  Or maybe it is good enough to implement support for
> > this in the efivar library.
>
> Yes to both. I discussed the idea during Linux Plumbers. All
> approaches have some pros and cons, you can find some details here
> [0].
> Implementing support to efitool is straightforward, but a bit too
> hacky for my taste. An obvious disadvantage is that it's hard to sync
> the kernel/file view after an update.
> The plan right now is to investigate overwriting RT functions and use
> kernel-provided ones that modify the file (which is probably going to
> be passed in a config table)
>
> [0] https://lpc.events/event/17/contributions/1653/

I don't know much about this area, but it strikes me that things are
getting a little too complicated.

U-Boot wants to show a menu of available Operating Systems. With UEFI
it isn't even possible to know what is being booted. We just have to
jump into the .efi file and hope.

Can we work together on adding a new, separate file which lists the
.efi files and what they are for? Then the user can select one.

>
> Thanks
> /Ilias
> >
> > That said, Linux distros probably should install their EFI bootloader
> > as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
> > distros already do this.  This would make the distro work "out of the
> > box" on a lot more boards.

That sounds good to me.

Regards,
Simon
