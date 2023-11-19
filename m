Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6BBC2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E562D874D8;
	Sun, 19 Nov 2023 01:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D8c3G3Zl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C24C870D2; Sun, 19 Nov 2023 01:44:12 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1BA874D5
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-da7238b3eb4so3282219276.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfiVzw+/ufpsb0eT32Lfulin5cSa1luOzK1sj7R9Zt4=;
 b=D8c3G3ZlbErssjwmb07oABXg8XmLjK47iyC4XWL3udAAycvGuNiJo1JMB/qIkXrtCV
 zehjlpuiguS3OmHe6oIw66bV5/QDdvV2xdEmFjesYQoMgImbXuQEB93skguGBQsUrcvA
 JRYnbzENkb01T+ziqWHUuLi7AewSbcjv7LBbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfiVzw+/ufpsb0eT32Lfulin5cSa1luOzK1sj7R9Zt4=;
 b=BxhSlFlpaJ1gT+MnHMi5sjTIGzspBp9JTZLzkD7P+2gKuBlWfeuGzJcjBpohyex57O
 IFMXKV+qr1yAXs2la2KrSYw5I9fsmZfne07pkk4rrI0vkCLh715HfGcDzmCoxgx3oyvT
 uRffPM5yl8GUfJcLz21/tbPdYPIKNIPAG5HdKlkAVCY5m2pLsYBGB0qLpDAKaJJN26lW
 6+80Qt5f0odVcjXzhyVgy2CZijMai4Xc6YDVNUu3kTzwgwSbqP6Mav6vRkeEPXQeApmn
 Z7wn5LtTIZwSvdU9Q9zxj4Dnp2668YFfpnna9HU0MOTNMOmlDVxXcvi3nBsmn2auGmEu
 SwfQ==
X-Gm-Message-State: AOJu0YxS9YQEpQv4aRBbBORo1VcwVcVXe4Hx9+65xneBMXktwh3dYoy1
 Pyp2QiLJgb2XFgZ5HrOpvtNUfsTL8ATQen86hiUIbQ==
X-Google-Smtp-Source: AGHT+IE0FUN/E7IMV07zfM/3MJag0AVhV/aLtheoWQKrQZElJktWq6DjpnfGNfT88SHOZVcHD0nmc4UrOLhBUmv1hBA=
X-Received: by 2002:a25:804d:0:b0:da0:38c8:2e66 with SMTP id
 a13-20020a25804d000000b00da038c82e66mr3024256ybn.3.1700354637849; Sat, 18 Nov
 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
In-Reply-To: <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:14 -0700
Message-ID: <CAPnjgZ0vGdszyJaJtU_YqBFR7ZqtnMgkN6EwVT=td7FmPY0k8Q@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Sat, 18 Nov 2023 at 15:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/18/23 22:28, Shantur Rathore wrote:
> > Hi Heinrich,
> >
> > On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/16/23 19:45, Shantur Rathore wrote:
> >>> On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
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
> >>>>> In x86 worlds, the NVRAM is modified and new boot entries are added=
 to
> >>>>> support these but in the U-boot world the NVRAM variables are
> >>>>> read-only.
> >>>>
> >>>> I guess you are referring to UEFI boot options. These typically are =
not
> >>>> stored in non-volatile RAM but on a SPI flash device.
> >>>>
> >>>
> >>> Thanks for correcting me.
> >>>
> >>>>>
> >>>>> What would be the best way to implement this?
> >>>>>
> >>>>> I was thinking of having a "efi_prefixes" environment variable whic=
h
> >>>>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
> >>>>> all of them. Will bootmethod_efi be able to support multiple entrie=
s (
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
> >>>> Obviously each installed operating system provides multiple EFI bina=
ries
> >>>> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
> >>>> debian centos" would not be able to describe which file you are look=
ing
> >>>> for.
> >>>>
> >>>> We already have the U-Boot command line eficonfig and efidebug comma=
nds
> >>>> to set up UEFI boot options which can describe which EFI binary to l=
oad
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
> >>>> If you are installing the shim-signed package on Ubuntu, the EFI boo=
t
> >>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the con=
tent
> >>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices()=
 and
> >>>> therefore should work with current U-Boot.
> >>>>
> >>>> Patches are pending upstream to make EFI variables writable from Lin=
ux
> >>>> if they are stored in the RPMB partition in the eMMC. See this serie=
s:
> >>>>
> >>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.koj=
ima@linaro.org/
> >>>>
> >>>
> >>> Would it be possible to save it in SPI Flash as the U-Boot environmen=
t ?
> >>
> >> Currently this is not supported by U-Boot.
> >>
> >> The U-Boot environment variables can be stored in lots of different
> >> places SPI flash is only one of these. But none of these locations is
> >> protected from OS access which would be preferable for UEFI variables
> >> for security reasons.
> >>
> >> To support boards without eMMC the right way forward would be writing =
a
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

Is there any metadata in the distro which U-Boot could read to find
out where the EFI file is?

Regards,
Simon
