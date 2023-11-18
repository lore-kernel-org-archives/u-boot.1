Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC4C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD60D87134;
	Sat, 18 Nov 2023 22:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="BjH7cQP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F5487208; Sat, 18 Nov 2023 22:28:31 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F17987125
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso4574439a12.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700342904; x=1700947704;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48Vu/vDLcH8KRllD+xZe2i/EA2CzwvYHpMpu0Dya2IE=;
 b=BjH7cQP1lU4CRPpkjl/77qI9yqYaJBYGFojXIPx806X6ereL7s5fX4Uq1o0Gj/dsKk
 Kx0Doxd5F9m+jJe48awuhnJHwSvJoIw3/7w4VyXb2RE890MRp0Cem1tWoYPGJUbi4Ktw
 6OXH6FJlaggGVwAV5O7vor84yb2HTlp819AbgDiFYGnVCiqBSONORn/AfIugbgVSncZI
 ue27gnAYKguthdaR/axPCF8isZZ9e/XJkiQTdDQZkcv/Q/MbCyZbRRgM5ssSMQwwVD1B
 rWUmkXJ+IHqMMzbdM7P5CsYQ+Rgsf3DEUrSj1m+pQjuuQRm7PAShUTLQlD2ORcMgGP0V
 klVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700342904; x=1700947704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48Vu/vDLcH8KRllD+xZe2i/EA2CzwvYHpMpu0Dya2IE=;
 b=m66giX+kSvkzM/Fkr3Ku81pg9YEvXj9ou2vVAUFvf90wzPQ4LNUDVwU/to1muUqwug
 9sLRi2aep/jmb7IrA9XoiKQPcHeLn5HwfthvJSSOkI5e+b+T8ka7dQSNLKddneF5ASU8
 88l9zax67oY2R5IDGCLcRbzi1WDnftNlC47SdU+u+3G1jRw/ZFEq+xzHf5NG4HnOo5WJ
 8N4CIDcSXnCrsOSre8yjd59aYz/sOGSwZVHsFdLcqyEVN9vXCMjIAqd1VJYZ0ETHpezl
 SqJcnPVKERAVgrLy+guK7hRV9JymhXot7q+akJAMQBoW9hYxGZ+4SsKYkZc2cB1OD540
 Wm+Q==
X-Gm-Message-State: AOJu0YzzGjsmqQH0i1rvz9DvAwAXzMvum1xRgKM3pZkC5szWVIo/rS+m
 9TFKrf9lnXwKe8QP1pKnSImNrMNBV4HBqky062fZpA==
X-Google-Smtp-Source: AGHT+IGA4HuZepMsSao9WmQIUFKHrN7siQ18r84v3mHRKC5yrHEXKcSLc57GgMki04i6IIoyasacKQ==
X-Received: by 2002:aa7:d587:0:b0:543:52be:e6ad with SMTP id
 r7-20020aa7d587000000b0054352bee6admr2745486edq.5.1700342903573; 
 Sat, 18 Nov 2023 13:28:23 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 x5-20020aa7dac5000000b005489e55d95esm68201eds.22.2023.11.18.13.28.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 13:28:23 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5488bf9e193so398865a12.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:28:23 -0800 (PST)
X-Received: by 2002:a05:6402:555:b0:543:9670:7ee8 with SMTP id
 i21-20020a056402055500b0054396707ee8mr2389009edx.14.1700342902631; Sat, 18
 Nov 2023 13:28:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
In-Reply-To: <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 18 Nov 2023 21:28:11 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
Message-ID: <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
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

On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/16/23 19:45, Shantur Rathore wrote:
> > On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/16/23 17:52, Shantur Rathore wrote:
> >>> Hi Simon,
> >>>
> >>> Currently bootstd - bootmethod_efi only looks for the default
> >>> bootxx64.efi in /EFI/boot folder only.
> >>> Generally many distros end up putting their bootloaders in
> >>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> >>>
> >>> In x86 worlds, the NVRAM is modified and new boot entries are added t=
o
> >>> support these but in the U-boot world the NVRAM variables are
> >>> read-only.
> >>
> >> I guess you are referring to UEFI boot options. These typically are no=
t
> >> stored in non-volatile RAM but on a SPI flash device.
> >>
> >
> > Thanks for correcting me.
> >
> >>>
> >>> What would be the best way to implement this?
> >>>
> >>> I was thinking of having a "efi_prefixes" environment variable which
> >>> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
> >>> all of them. Will bootmethod_efi be able to support multiple entries =
(
> >>> thinking of multiboot ) ?
> >>
> >> On my laptop I have:
> >>
> >> EFI/Microsoft/Boot/bootmgr.efi
> >> EFI/Microsoft/Boot/memtest.efi
> >> EFI/Boot/bootx64.efi
> >> EFI/Boot/fbx64.efi
> >> EFI/Boot/mmx64.efi
> >> EFI/debian/shimx64.efi
> >> EFI/debian/grubx64.efi
> >> EFI/debian/mmx64.efi
> >> EFI/debian/fbx64.efi
> >> EFI/ubuntu/grubx64.efi
> >> EFI/ubuntu/shimx64.efi
> >> EFI/ubuntu/mmx64.efi
> >>
> >> Obviously each installed operating system provides multiple EFI binari=
es
> >> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
> >> debian centos" would not be able to describe which file you are lookin=
g
> >> for.
> >>
> >> We already have the U-Boot command line eficonfig and efidebug command=
s
> >> to set up UEFI boot options which can describe which EFI binary to loa=
d
> >> and which command line to pass to it. These are considered by the
> >> existing boot flows.
> >
> > So, I am building a new RockPro64 based cluster and using Canonical
> > MAAS to set them up automatically, booting them up using DHCP and
> > installing them over the network.
> > I configured an Armbian image using Packer to be compatible with MAAS
> > and it happily installs it. As part of installation process, a
> > grub-install is run which installs the grub efi,
> > this EFI ends up in EFI/debian instead of expected EFI/boot.
> > To be able to make it boot, I have to add commands to move it to
> > EFI/boot. I am trying to find a way in U-Boot that would allow me to
> > skip this step.
> > With eficonfig if I understand correctly, it would need manual
> > intervention to create boot entries.
> >
> >>
> >> If you are installing the shim-signed package on Ubuntu, the EFI boot
> >> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the conte=
nt
> >> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() a=
nd
> >> therefore should work with current U-Boot.
> >>
> >> Patches are pending upstream to make EFI variables writable from Linux
> >> if they are stored in the RPMB partition in the eMMC. See this series:
> >>
> >> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojim=
a@linaro.org/
> >>
> >
> > Would it be possible to save it in SPI Flash as the U-Boot environment =
?
>
> Currently this is not supported by U-Boot.
>
> The U-Boot environment variables can be stored in lots of different
> places SPI flash is only one of these. But none of these locations is
> protected from OS access which would be preferable for UEFI variables
> for security reasons.
>
> To support boards without eMMC the right way forward would be writing a
> new implementation of the OP-TEE standalone MM which writes the
> variables to SPI flash instead of the RPMB partition and ensures that
> the SPI flash' MMIO registers are protected against access from the
> non-secure world.

Thanks for explaining this to me.
This seems like a long way to go, for now what would be an acceptable
solution, some options are

1. Allow to set a space separated efi_prefixes (e.g. "boot ubuntu
debian") variable which is ready by bootmeth_efi and used as
efi/<efi_prefix> instead of efi/boot.
2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ folder and
present all them as bootflows to bootstd.

Kind regards,
Shantur
