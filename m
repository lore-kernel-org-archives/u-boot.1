Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B77C54FB9
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 07:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBB886D62;
	Mon, 20 Nov 2023 08:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kXBJk/4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4245E870EB; Mon, 20 Nov 2023 08:02:44 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868E086C72
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 08:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c8769edd9fso17395621fa.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700463757; x=1701068557; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feNXSPscIuRtFen05oHhkxEGqnCThqojHjsDdnzCXI8=;
 b=kXBJk/4ewTxX/WJ81qNKghyjPVAtn7sXYxxCoXv59aAugNCPUg+lOAusd4fHiolxPd
 /nI6wcFITylI7z26gCa+ZnVBPMcVemL394XU7zxOIMTzQW6qnk4XohNhQSkhySDnB6eS
 nsEut77Nt/UpUa2x2M3T4VAv58uyVz2ySa33L/Wb+cCdvw5iad30LlWFY55shnzZXmBV
 o2xnku3BHfT2Qs8VIJkd+AMoJwxvc+abMFBK7b5RhboSPhdLUuboQ/Q2SfWzEgi+BO6Q
 6VMBfPx6z9lGweLuFC+uxmTpAzKm6m7vSsLPxZxGNAJh1yxco345Iywcu5zsIipPpLqW
 +FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700463757; x=1701068557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feNXSPscIuRtFen05oHhkxEGqnCThqojHjsDdnzCXI8=;
 b=D2o4PY3Q+Q0iQbQwqCsfbpGrI2KCp+gQxEiH6qot6c7aqlDeQniucNgWZnXijdGjiy
 Ftb1Jq04i6JPW+Bs/s4Y1HDRLFQvLlYqZdX0Rm9UoU8B84OK0AF3R0hCiUiC1+Otx2Fz
 SHBB0Xy0l7sfhj79NVxWlU5aP2JrjKmVyQHtRB5aFWcn2BYtOh0lZnJ1dHqvHYzXAkrD
 MqTxIAtZXdnUquj6RhbEuUHqJRdyGgiQenK15YIv3lT0S/mj9IpQ69SFEhS7bvQ7epZ3
 cgDyMRebZNVF5PsrNMDKeMGmSLUqnHSjHFfMpV5wB/s9bErGmI2HgE1OfNpc1AcFLc61
 Wbew==
X-Gm-Message-State: AOJu0YzKfG5bIaHJNQzWdXkDwBxW12EE49O7H4BNNLMu7C+HZfTS/992
 Fq2tVACrKnR6mC/QiJrUaI6nfC10KTJEuGfdBqqidw==
X-Google-Smtp-Source: AGHT+IEt760hNfWQf+mH9tK0GsWE106v6yqogRMRv61Ak+iSz+BnGFeEdiIqRY08qtN6KD+M/qj2eTZs8bHM9mRTmYw=
X-Received: by 2002:a2e:870f:0:b0:2c5:8b1:7561 with SMTP id
 m15-20020a2e870f000000b002c508b17561mr4044596lji.10.1700463756673; Sun, 19
 Nov 2023 23:02:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Nov 2023 09:02:00 +0200
Message-ID: <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, i@shantur.com,
 u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Mark,

On Sun, 19 Nov 2023 at 19:38, Mark Kettenis <mark.kettenis@xs4all.nl> wrote=
:
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

+ 1

>
> The Linaro approach that involves OP-TEE makes for a fairly complex
> solution.  And there are plenty of boards that have neither eMMC nor
> SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> for most "hobbyist" boards it isn't) storing the EFI variables in a
> file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> Kconfig option) is a workable alternative.  And this is actually what
> the rockpro64-rk3399_defconfig enables.

Even in that case, preseeding the variables can enable uefi secure
boot. But you have to establish a chain of trust since the
authenticated EFI variables are part of  the u-boot binary.

>
> I noticed that the latest EBBR attempts to standardize this:
>
>   https://arm-software.github.io/ebbr/index.html#document-chapter5-variab=
le-storage
>
> Not sure what the status here is.

Heinrich and I were the ones who proposed the standardization. The
idea is to eventually fix it for all boards and we are working on it,

> But if the Linux kernel folks
> accept that alternative implementations for runtime EFI variable
> access are a thing, then a method that modifies the file would be
> possible as well.  Or maybe it is good enough to implement support for
> this in the efivar library.

Yes to both. I discussed the idea during Linux Plumbers. All
approaches have some pros and cons, you can find some details here
[0].
Implementing support to efitool is straightforward, but a bit too
hacky for my taste. An obvious disadvantage is that it's hard to sync
the kernel/file view after an update.
The plan right now is to investigate overwriting RT functions and use
kernel-provided ones that modify the file (which is probably going to
be passed in a config table)

[0] https://lpc.events/event/17/contributions/1653/

Thanks
/Ilias
>
> That said, Linux distros probably should install their EFI bootloader
> as EFI/BOOT/BOOTxxxx.EFI if that file doesn't exist yet.  Some Linux
> distros already do this.  This would make the distro work "out of the
> box" on a lot more boards.
