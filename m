Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D777BC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 20:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A1587538;
	Sun,  3 Dec 2023 21:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C8jdTJTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244FE87547; Sun,  3 Dec 2023 21:38:11 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1D3870B8
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 21:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso1800221a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701635888; x=1702240688; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWByoDV3skw911J0Aq6mdhIBakFslt2wx9tND414G+8=;
 b=C8jdTJTtFi5bw61eCW+VE1VefSpc8hE67j58XxFaxRZjYka9YGOzF+OjKBLrMVQ2sO
 BNfbB5IV3EVgXt2JqUngEitNW/lFXePOwFUVFlYy+Im40I3cicxtCjqiAHNEGPQi+Der
 bRG/hRIBCYJYTVpxcORjJP6inY1KQ7XKkc1WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701635888; x=1702240688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWByoDV3skw911J0Aq6mdhIBakFslt2wx9tND414G+8=;
 b=wNMkt5724bZSe/A0G/BbfAUzgJwnrughycVRk+TydqCue3E2+fJkWQb3tDhCBBz8Xm
 jk6cl24gVhy2AnD5fZPj5lq92LSzioZ7Zlpdzs2c4C9exIBH0aBXbOEbUwP1qsCOGEue
 m7yv5ThbFExqfZTV0NWMJ9Z//c7LSX2dvTPvEGP2OuzYukiYt+5twdgP7mS/6Gto/7Qu
 kf4Mjw5ANvO9PBwHMPNffAdhHL8Ys8uYU1TJ4lIyfmKvwunv00QrmQXSejdSrrsN7Z3D
 YQbeSW3EDNThh/YClE1/sGurV6I8ogB5GMfdyOFQ8VKczLSmBBi4AHdj+QFYzw/zT6kC
 q3wQ==
X-Gm-Message-State: AOJu0YxadOrKSBJTrXkKdhMiNKyHFF7+fboxqnu9i6u5E6sqWsasd9W0
 s9hdRvonkhuT+rEaDkzLG4iZoyDyliDNk+WElh02qQ==
X-Google-Smtp-Source: AGHT+IGep1I/gPLHSW3xpMcBmLklXYMh9fS2vnJHejmr4vgCNj0kcKKFSAgjyLPcSPk/8oWFKV2tFBu5qjB2YK2L5dE=
X-Received: by 2002:a17:906:1051:b0:a19:a19b:78c3 with SMTP id
 j17-20020a170906105100b00a19a19b78c3mr3199500ejj.134.1701635887515; Sun, 03
 Dec 2023 12:38:07 -0800 (PST)
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
 <CAHc5_t2mQGQ4WLSXjh105QXnxMTeF3=x69N28dDiSdRMBHq3kg@mail.gmail.com>
 <1e2bad87-3372-452d-ae27-01c100378ecf@canonical.com>
 <CAPnjgZ05pDOATqw9wha-pOZsgjCF-4dgLL7-a4r-JPUjtMospg@mail.gmail.com>
 <671228f5-8a11-4be9-b8fe-1331232e7498@canonical.com>
 <CAPnjgZ1dghg2T8D8fSpHUgstgipwv+jRQssimpAGqTaPjvvQTA@mail.gmail.com>
 <638c9f48-693c-466e-a510-6004896a466c@canonical.com>
 <CAPnjgZ2=zCJbmA4CAjgRFUhGfojq6cOJMUeC4jB3Dm+u8UNG+A@mail.gmail.com>
 <c1ff4723-18f6-4fc4-bbba-8cc7490ca480@canonical.com>
In-Reply-To: <c1ff4723-18f6-4fc4-bbba-8cc7490ca480@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 13:37:51 -0700
Message-ID: <CAPnjgZ3+dEFYazXKaGMfrLKAS5aKBhN-+HnH_3xy3qWaLNCtzg@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Shantur Rathore <i@shantur.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
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

Hi Heinrich,

On Sun, 3 Dec 2023 at 13:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/3/23 20:50, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 3 Dec 2023 at 11:33, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 12/3/23 19:22, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sun, 3 Dec 2023 at 10:53, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 12/3/23 18:44, Simon Glass wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Sun, 3 Dec 2023 at 03:55, Heinrich Schuchardt
> >>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>
> >>>>>> On 12/3/23 00:38, Shantur Rathore wrote:
> >>>>>>> Hi Simon,
> >>>>>>>
> >>>>>>> On Sat, Dec 2, 2023 at 6:33=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On Mon, 20 Nov 2023 at 00:02, Ilias Apalodimas
> >>>>>>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Mark,
> >>>>>>>>>
> >>>>>>>>> On Sun, 19 Nov 2023 at 19:38, Mark Kettenis <mark.kettenis@xs4a=
ll.nl> wrote:
> >>>>>>>>>>
> >>>>>>>>>>> Date: Sat, 18 Nov 2023 23:52:11 +0100
> >>>>>>>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>>>>>>>
> >>>>>>>>>> Hi Heinrich,
> >>>>>>>>>>
> >>>>>>>>>>> On 11/18/23 22:28, Shantur Rathore wrote:
> >>>>>>>>>>>> Hi Heinrich,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Fri, Nov 17, 2023 at 3:12=E2=80=AFPM Heinrich Schuchardt
> >>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 11/16/23 19:45, Shantur Rathore wrote:
> >>>>>>>>>>>>>> On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchard=
t
> >>>>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On 11/16/23 17:52, Shantur Rathore wrote:
> >>>>>>>>>>>>>>>> Hi Simon,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Currently bootstd - bootmethod_efi only looks for the de=
fault
> >>>>>>>>>>>>>>>> bootxx64.efi in /EFI/boot folder only.
> >>>>>>>>>>>>>>>> Generally many distros end up putting their bootloaders =
in
> >>>>>>>>>>>>>>>> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> In x86 worlds, the NVRAM is modified and new boot entrie=
s are added to
> >>>>>>>>>>>>>>>> support these but in the U-boot world the NVRAM variable=
s are
> >>>>>>>>>>>>>>>> read-only.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I guess you are referring to UEFI boot options. These typ=
ically are not
> >>>>>>>>>>>>>>> stored in non-volatile RAM but on a SPI flash device.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Thanks for correcting me.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> What would be the best way to implement this?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I was thinking of having a "efi_prefixes" environment va=
riable which
> >>>>>>>>>>>>>>>> can be set to "ubuntu debian centos" etc and bootmethod_=
efi can try
> >>>>>>>>>>>>>>>> all of them. Will bootmethod_efi be able to support mult=
iple entries (
> >>>>>>>>>>>>>>>> thinking of multiboot ) ?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On my laptop I have:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> EFI/Microsoft/Boot/bootmgr.efi
> >>>>>>>>>>>>>>> EFI/Microsoft/Boot/memtest.efi
> >>>>>>>>>>>>>>> EFI/Boot/bootx64.efi
> >>>>>>>>>>>>>>> EFI/Boot/fbx64.efi
> >>>>>>>>>>>>>>> EFI/Boot/mmx64.efi
> >>>>>>>>>>>>>>> EFI/debian/shimx64.efi
> >>>>>>>>>>>>>>> EFI/debian/grubx64.efi
> >>>>>>>>>>>>>>> EFI/debian/mmx64.efi
> >>>>>>>>>>>>>>> EFI/debian/fbx64.efi
> >>>>>>>>>>>>>>> EFI/ubuntu/grubx64.efi
> >>>>>>>>>>>>>>> EFI/ubuntu/shimx64.efi
> >>>>>>>>>>>>>>> EFI/ubuntu/mmx64.efi
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Obviously each installed operating system provides multip=
le EFI binaries
> >>>>>>>>>>>>>>> and non uses the fallback file name BOOT<ARCH>.EFI. A val=
ue "ubuntu
> >>>>>>>>>>>>>>> debian centos" would not be able to describe which file y=
ou are looking
> >>>>>>>>>>>>>>> for.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> We already have the U-Boot command line eficonfig and efi=
debug commands
> >>>>>>>>>>>>>>> to set up UEFI boot options which can describe which EFI =
binary to load
> >>>>>>>>>>>>>>> and which command line to pass to it. These are considere=
d by the
> >>>>>>>>>>>>>>> existing boot flows.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> So, I am building a new RockPro64 based cluster and using =
Canonical
> >>>>>>>>>>>>>> MAAS to set them up automatically, booting them up using D=
HCP and
> >>>>>>>>>>>>>> installing them over the network.
> >>>>>>>>>>>>>> I configured an Armbian image using Packer to be compatibl=
e with MAAS
> >>>>>>>>>>>>>> and it happily installs it. As part of installation proces=
s, a
> >>>>>>>>>>>>>> grub-install is run which installs the grub efi,
> >>>>>>>>>>>>>> this EFI ends up in EFI/debian instead of expected EFI/boo=
t.
> >>>>>>>>>>>>>> To be able to make it boot, I have to add commands to move=
 it to
> >>>>>>>>>>>>>> EFI/boot. I am trying to find a way in U-Boot that would a=
llow me to
> >>>>>>>>>>>>>> skip this step.
> >>>>>>>>>>>>>> With eficonfig if I understand correctly, it would need ma=
nual
> >>>>>>>>>>>>>> intervention to create boot entries.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> If you are installing the shim-signed package on Ubuntu, =
the EFI boot
> >>>>>>>>>>>>>>> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI us=
ing the content
> >>>>>>>>>>>>>>> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBoo=
tServices() and
> >>>>>>>>>>>>>>> therefore should work with current U-Boot.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Patches are pending upstream to make EFI variables writab=
le from Linux
> >>>>>>>>>>>>>>> if they are stored in the RPMB partition in the eMMC. See=
 this series:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> https://lore.kernel.org/linux-efi/20231107054057.1893-2-m=
asahisa.kojima@linaro.org/
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Would it be possible to save it in SPI Flash as the U-Boot=
 environment ?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Currently this is not supported by U-Boot.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The U-Boot environment variables can be stored in lots of d=
ifferent
> >>>>>>>>>>>>> places SPI flash is only one of these. But none of these lo=
cations is
> >>>>>>>>>>>>> protected from OS access which would be preferable for UEFI=
 variables
> >>>>>>>>>>>>> for security reasons.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> To support boards without eMMC the right way forward would =
be writing a
> >>>>>>>>>>>>> new implementation of the OP-TEE standalone MM which writes=
 the
> >>>>>>>>>>>>> variables to SPI flash instead of the RPMB partition and en=
sures that
> >>>>>>>>>>>>> the SPI flash' MMIO registers are protected against access =
from the
> >>>>>>>>>>>>> non-secure world.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks for explaining this to me.
> >>>>>>>>>>>> This seems like a long way to go, for now what would be an a=
cceptable
> >>>>>>>>>>>> solution, some options are
> >>>>>>>>>>>>
> >>>>>>>>>>>> 1. Allow to set a space separated efi_prefixes (e.g. "boot u=
buntu
> >>>>>>>>>>>> debian") variable which is ready by bootmeth_efi and used as
> >>>>>>>>>>>> efi/<efi_prefix> instead of efi/boot.
> >>>>>>>>>>>> 2. Improve bootmeth_efi to find all bootxxxx.efi in efi/ fol=
der and
> >>>>>>>>>>>> present all them as bootflows to bootstd.
> >>>>>>>>>>>
> >>>>>>>>>>> As mentioned in a prior mail ubuntu/bootxxxx.efi and debian/b=
ootxxxx.efi
> >>>>>>>>>>> don't exist. I would prefer not to add any distro specific st=
uff in
> >>>>>>>>>>> upstream U-Boot. Instead we will continue to drive what Linar=
o has
> >>>>>>>>>>> suggested to improve U-Boot EFI variables support in Linux.
> >>>>>>>>>>
> >>>>>>>>>> I agree that adding hacks like this is not a good idea.
> >>>>>>>>>
> >>>>>>>>> + 1
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> The Linaro approach that involves OP-TEE makes for a fairly co=
mplex
> >>>>>>>>>> solution.  And there are plenty of boards that have neither eM=
MC nor
> >>>>>>>>>> SPI flash.  If Secure Boot is not a requirement (and I'd argue=
 that
> >>>>>>>>>> for most "hobbyist" boards it isn't) storing the EFI variables=
 in a
> >>>>>>>>>> file on the ESP (as implemented by the CONFIG_EFI_VARIABLE_FIL=
E_STORE
> >>>>>>>>>> Kconfig option) is a workable alternative.  And this is actual=
ly what
> >>>>>>>>>> the rockpro64-rk3399_defconfig enables.
> >>>>>>>>>
> >>>>>>>>> Even in that case, preseeding the variables can enable uefi sec=
ure
> >>>>>>>>> boot. But you have to establish a chain of trust since the
> >>>>>>>>> authenticated EFI variables are part of  the u-boot binary.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I noticed that the latest EBBR attempts to standardize this:
> >>>>>>>>>>
> >>>>>>>>>>       https://arm-software.github.io/ebbr/index.html#document-=
chapter5-variable-storage
> >>>>>>>>>>
> >>>>>>>>>> Not sure what the status here is.
> >>>>>>>>>
> >>>>>>>>> Heinrich and I were the ones who proposed the standardization. =
The
> >>>>>>>>> idea is to eventually fix it for all boards and we are working =
on it,
> >>>>>>>>>
> >>>>>>>>>> But if the Linux kernel folks
> >>>>>>>>>> accept that alternative implementations for runtime EFI variab=
le
> >>>>>>>>>> access are a thing, then a method that modifies the file would=
 be
> >>>>>>>>>> possible as well.  Or maybe it is good enough to implement sup=
port for
> >>>>>>>>>> this in the efivar library.
> >>>>>>>>>
> >>>>>>>>> Yes to both. I discussed the idea during Linux Plumbers. All
> >>>>>>>>> approaches have some pros and cons, you can find some details h=
ere
> >>>>>>>>> [0].
> >>>>>>>>> Implementing support to efitool is straightforward, but a bit t=
oo
> >>>>>>>>> hacky for my taste. An obvious disadvantage is that it's hard t=
o sync
> >>>>>>>>> the kernel/file view after an update.
> >>>>>>>>> The plan right now is to investigate overwriting RT functions a=
nd use
> >>>>>>>>> kernel-provided ones that modify the file (which is probably go=
ing to
> >>>>>>>>> be passed in a config table)
> >>>>>>>>>
> >>>>>>>>> [0] https://lpc.events/event/17/contributions/1653/
> >>>>>>>>
> >>>>>>>> I don't know much about this area, but it strikes me that things=
 are
> >>>>>>>> getting a little too complicated.
> >>>>>>>>
> >>>>>>>> U-Boot wants to show a menu of available Operating Systems. With=
 UEFI
> >>>>>>>> it isn't even possible to know what is being booted. We just hav=
e to
> >>>>>>>> jump into the .efi file and hope.
> >>>>>>>>
> >>>>>>>> Can we work together on adding a new, separate file which lists =
the
> >>>>>>>> .efi files and what they are for? Then the user can select one.
> >>>>>>>>
> >>>>>>> To add - EFI/BOOT/BOOTXXXX.efi is optional [0] and isn't installe=
d by
> >>>>>>> generic ARM
> >>>>>>> distros (debian, armbian.. maybe more)
> >>>>>>>
> >>>>>>> +1 for this. This can be implemented as part of bootmeth_efi (in =
blk
> >>>>>>> mode) where instead
> >>>>>>> of checking hardcoded EFI/BOOT/BOOTXXXX.efi, it can follow one of=
 the
> >>>>>>> following options
> >>>>>>>
> >>>>>>> 1. Scan and list all available .efi files - EFI/**/*.efi
> >>>>>>> Pros - Allows all the possible boot options to be shown to user
> >>>>>>> Cons - A 'bootflow scan -b' might not boot the system by default =
as it
> >>>>>>> might depend on
> >>>>>>> which efi file is scanned first. Some installs have mmaa64.efi
> >>>>>>>
> >>>>>>> 2. Scan and list all available .efi files that match the
> >>>>>>> "bootmeth_efi_regex" variable if available.
> >>>>>>> This variable can be configured to allow valid names example
> >>>>>>> "EFI\/.*\/(boot|grub|fb|shim).*efi"
> >>>>>>> Pros - Allows to control only efi files that can boot the system =
by default.
> >>>>>>> Cons - Might be an issue in environments without CONFIG_REGEX
> >>>>>>>
> >>>>>>> 3. Scan all the folders EFI/* for EFI file prefixes controlled by
> >>>>>>> "bootmeth_efi_name_prefixes" variable
> >>>>>>> This variable can be a space separated list of all valid prefixes=
 the
> >>>>>>> user is interested in. e.g. "boot grub fb shim"
> >>>>>>> Pros - This allows control on what EFI files to look for without =
being
> >>>>>>> depended on CONFIG_REGEX
> >>>>>>> Cons - I can't think of, please do tell.
> >>>>>>>
> >>>>>>> After this, bootmeth_efi can set up more than 1 bootflows that ar=
e bootable.
> >>>>>>>
> >>>>>>> [0] - https://www.rodsbooks.com/efi-bootloaders/principles.html
> >>>>>>>
> >>>>>>> Kind regards,
> >>>>>>> Shantur
> >>>>>>
> >>>>>> U-Boot should remain be a compliant UEFI implementation. We shall =
not
> >>>>>> scan any other directories than those described in the UEFI specif=
ication.
> >>>>>
> >>>>> For the efi bootmeth we can actually do what we like, can't we? Its
> >>>>> behaviour isn't defined by the spec as I understand it.
> >>>>>
> >>>>> I wonder how this works, if the user installs both Debian and Ubunt=
u
> >>>>> on the machine? I suppose each one separately updates its grub.cfg
> >>>>> with all the OSes it can find on the machine? Then just one of them
> >>>>> gets to be the initial .efi app?
> >>>>>
> >>>>> Can we work together on adding a new, separate file which lists the
> >>>>> .efi files and what they are for?
> >>>>
> >>>> There is already a place defined by the UEFI specification where to =
put
> >>>> that information: the UEFI boot options defined in variables BOOT###=
#.
> >>>> And this is exactly what all operating system use. The information w=
hat
> >>>> the entries are for are in the label part of the boot options. The
> >>>> sequence in which to try loading is in variable BootOrder.
> >>>>
> >>>> There is no point in reinventing the wheel and making it square.
> >>>
> >>> You have not addressed my question, or I don't understand your answer=
.
> >>>
> >>> I am not worried about what the computer does. I am worried about wha=
t
> >>> the user sees.
> >>>
> >>> So far as I can tell there is currently no way to know what you are
> >>> booting (Ubuntu, Debian) until you boot it
> >>
> >> Of course I know. These are some of the boot options on my laptop:
> >>
> >> Boot0000* Windows Boot Manager
> >> HD(2,GPT,54e58a37-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)/File(\=
EFI\Microsoft\Boot\bootmgfw.efi)WINDOWS.........x...B.C.D.O.B.J.E.C.T.=3D.{=
.9.d.e.a.8.6.2.c.-.5.c.d.d.-.4.e.7.0.-.a.c.c.1.-.f.3.2.b.3.4.4.d.5.3.7.2.}.=
..M................
> >> Boot0001* debian
> >> HD(2,GPT,54e58a14-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)/File(\=
EFI\debian\shimx64.efi)
> >> Boot0002* ubuntu
> >> HD(2,GPT,54e58a14-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)/File(\=
EFI\ubuntu\shimx64.efi)
> >> Boot0063* EFI Shell
> >> HD(2,GPT,54e58a14-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)/File(S=
hell.efi)
> >>
> >> If I open the boot menu (F12 key on a Lenovo laptop, F8 key on an ASUS
> >> mainboards), I see a menu which allows me to choose which of Windows,
> >> Debian, Ubuntu, or the EFI Shell I want to boot.
> >>
> >> In U-Boot we already have the same. Please, have a look at the section
> >> 'UEFI boot variable enumeration' in doc/usage/cmd/bootmenu.rst.
> >
> > OK thank you. So what sets that up? When you install Ubuntu does it
> > add a new Boot0002 variable? Then you install Debian and it adds some
> > other one??
>
> Yes, the OS installation process sets up the boot variables. For Debian
> or Ubuntu this happens when shim or GRUB is installed. If Debian or
> Ubuntu shim is started as /efi/boot/boot<arch>.efi, it also adds the
> missing entry based on a CSV file.
>
> E.g. on my laptop I find /EFI/ubuntu/BOOTX64.CSV with content
>
>    shimx64.efi,ubuntu,,This is the boot entry for ubuntu
>
> and file /boot/efi/EFI/debian/BOOTX64.CSV with content
>
>    shimx64.efi,debian,,This is the boot entry for debian

OK, thank you. That explains the link to the boot order. But what
creates these CSV files? It is the os prober, or is it Ubuntu/Debian?

>
> >
> > Also the information is very limited, e.g. it does not show the Ubuntu
> > version, kernel version, etc.
>
> The length of the labels is only limited by available storage. It is the
> OS'es choice to opt for a such a short label.

Yes, really I am looking for metadata that includes more detail at
different leaves, not just a label.

Regards,
Simon
