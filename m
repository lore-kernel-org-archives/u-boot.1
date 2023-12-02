Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7EEC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 23:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD9C87735;
	Sun,  3 Dec 2023 00:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="SM/wfsk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2C687743; Sun,  3 Dec 2023 00:39:11 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908F2876B2
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 00:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0832cso1238593a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701560343; x=1702165143;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfPTHXVIPBXV2gLBZ0uJ7sSPsdA7Dlk3jz8ApMRYwgk=;
 b=SM/wfsk+z9tb6+dGPF+sK4zVaXYMHOL9PO53DLbyrN5GRXSX2litEGvENlrvtWz7MZ
 JVBo1nlbi2GDwZw7IwQxxCnWCokfnuKdbEnZ8vHbI8lCD2S4NtAVhEBdiSFTGccaMW+P
 Kn+obygc8+Y1jNDpwdlWwUjRMZym282eyop13wxwMqi129S/dnE51PuCRkvRk2iEkH0V
 O2q2Khj3wtdFwVtDuYUCTiYTv1zb0c8c8INgxyAHqhHFXYwVuusddH0myvhFwEUyydLH
 3gsWuTDJBF+70TfMmLY9Yj8lEPeOzTeCpC3nUJBRlmdVkokpeJhv2WudtnXaQKwWXfDP
 bxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701560343; x=1702165143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfPTHXVIPBXV2gLBZ0uJ7sSPsdA7Dlk3jz8ApMRYwgk=;
 b=GcTt8jDZLJ8rtHlfDQpvRvcng7JWhPMjbvjNkljkFmmsrvrYBPdJinbhwYcFHOZ4fF
 QhG2fTdHo05AcyOPBa9mjD3+rh2+t+3t6t6gm0/gR1fPNo6QUzn/JUK5EzbpATNDW6aB
 aRN3h3O0DLykcvll3HhvxUOPI9mPtcy/PBB6BJ29EcEjkmoTKFDDL992UrgQl0Te4FND
 MsZHRAzHN34w7lEEZ6t0pIr9OlK45fMzLyQIDBDxC8QklrQzKlNKSN6uT6yfC875DCQI
 49g4spIC/69xCDPfbKPrApWMTYqbYq6ikHQKlKzVk6lp0PYbziIgnJSLtfOw/IzIlqPM
 q2pA==
X-Gm-Message-State: AOJu0YwQDwn4T7rS27SihNSl5iXNaawgRCKnZPsordYZi4FBlysTyk1M
 B8k+pAc6kvITdvx8ngD/ney3okT/Phg2S20ZK8guHUOeH6g=
X-Google-Smtp-Source: AGHT+IFRjtkT6r1cd4UTFlPZBKzaNUF5GbjfUGm89/YyQuswAvbikVJondJ6Zu6REfnx39woHn51JA==
X-Received: by 2002:a50:ab5c:0:b0:54c:9398:27bd with SMTP id
 t28-20020a50ab5c000000b0054c939827bdmr586761edc.51.1701560342846; 
 Sat, 02 Dec 2023 15:39:02 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50]) by smtp.gmail.com with ESMTPSA id
 z1-20020a05640240c100b0054c9972c1aesm670892edb.28.2023.12.02.15.39.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 15:39:01 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-40b27726369so33572505e9.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:39:01 -0800 (PST)
X-Received: by 2002:a05:600c:46c7:b0:40b:35aa:bfdd with SMTP id
 q7-20020a05600c46c700b0040b35aabfddmr1284460wmo.27.1701560340771; Sat, 02 Dec
 2023 15:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
 <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
 <493b645c-1bf2-4bd9-9457-30e98aa17040@canonical.com>
 <CAHc5_t3_soy2Je+CMazMMW+1Dhx15704SMuXZwnYhToxdb8vnw@mail.gmail.com>
 <adf71fc6-9323-4c56-9f26-f12c09fa7275@canonical.com>
 <87fs11tzhy.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjJWgTS6Os7fp4jP=u1+osBccndoR+CBgFUt2nb04RWwWA@mail.gmail.com>
 <CAPnjgZ04C=_MoCjKBYUdmBXyQn-zviAMQJxMHQAfj1MwvqOMzw@mail.gmail.com>
In-Reply-To: <CAPnjgZ04C=_MoCjKBYUdmBXyQn-zviAMQJxMHQAfj1MwvqOMzw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 2 Dec 2023 23:38:49 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2mQGQ4WLSXjh105QXnxMTeF3=x69N28dDiSdRMBHq3kg@mail.gmail.com>
Message-ID: <CAHc5_t2mQGQ4WLSXjh105QXnxMTeF3=x69N28dDiSdRMBHq3kg@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de, 
 trini@konsulko.com
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

Hi Simon,

On Sat, Dec 2, 2023 at 6:33=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi,
>
> On Mon, 20 Nov 2023 at 00:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Mark,
> >
> > On Sun, 19 Nov 2023 at 19:38, Mark Kettenis <mark.kettenis@xs4all.nl> w=
rote:
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
> >
> > + 1
> >
> > >
> > > The Linaro approach that involves OP-TEE makes for a fairly complex
> > > solution.  And there are plenty of boards that have neither eMMC nor
> > > SPI flash.  If Secure Boot is not a requirement (and I'd argue that
> > > for most "hobbyist" boards it isn't) storing the EFI variables in a
> > > file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FILE_STORE
> > > Kconfig option) is a workable alternative.  And this is actually what
> > > the rockpro64-rk3399_defconfig enables.
> >
> > Even in that case, preseeding the variables can enable uefi secure
> > boot. But you have to establish a chain of trust since the
> > authenticated EFI variables are part of  the u-boot binary.
> >
> > >
> > > I noticed that the latest EBBR attempts to standardize this:
> > >
> > >   https://arm-software.github.io/ebbr/index.html#document-chapter5-va=
riable-storage
> > >
> > > Not sure what the status here is.
> >
> > Heinrich and I were the ones who proposed the standardization. The
> > idea is to eventually fix it for all boards and we are working on it,
> >
> > > But if the Linux kernel folks
> > > accept that alternative implementations for runtime EFI variable
> > > access are a thing, then a method that modifies the file would be
> > > possible as well.  Or maybe it is good enough to implement support fo=
r
> > > this in the efivar library.
> >
> > Yes to both. I discussed the idea during Linux Plumbers. All
> > approaches have some pros and cons, you can find some details here
> > [0].
> > Implementing support to efitool is straightforward, but a bit too
> > hacky for my taste. An obvious disadvantage is that it's hard to sync
> > the kernel/file view after an update.
> > The plan right now is to investigate overwriting RT functions and use
> > kernel-provided ones that modify the file (which is probably going to
> > be passed in a config table)
> >
> > [0] https://lpc.events/event/17/contributions/1653/
>
> I don't know much about this area, but it strikes me that things are
> getting a little too complicated.
>
> U-Boot wants to show a menu of available Operating Systems. With UEFI
> it isn't even possible to know what is being booted. We just have to
> jump into the .efi file and hope.
>
> Can we work together on adding a new, separate file which lists the
> .efi files and what they are for? Then the user can select one.
>
To add - EFI/BOOT/BOOTXXXX.efi is optional [0] and isn't installed by
generic ARM
distros (debian, armbian.. maybe more)

+1 for this. This can be implemented as part of bootmeth_efi (in blk
mode) where instead
of checking hardcoded EFI/BOOT/BOOTXXXX.efi, it can follow one of the
following options

1. Scan and list all available .efi files - EFI/**/*.efi
Pros - Allows all the possible boot options to be shown to user
Cons - A 'bootflow scan -b' might not boot the system by default as it
might depend on
which efi file is scanned first. Some installs have mmaa64.efi

2. Scan and list all available .efi files that match the
"bootmeth_efi_regex" variable if available.
This variable can be configured to allow valid names example
"EFI\/.*\/(boot|grub|fb|shim).*efi"
Pros - Allows to control only efi files that can boot the system by default=
.
Cons - Might be an issue in environments without CONFIG_REGEX

3. Scan all the folders EFI/* for EFI file prefixes controlled by
"bootmeth_efi_name_prefixes" variable
This variable can be a space separated list of all valid prefixes the
user is interested in. e.g. "boot grub fb shim"
Pros - This allows control on what EFI files to look for without being
depended on CONFIG_REGEX
Cons - I can't think of, please do tell.

After this, bootmeth_efi can set up more than 1 bootflows that are bootable=
.

[0] - https://www.rodsbooks.com/efi-bootloaders/principles.html

Kind regards,
Shantur
