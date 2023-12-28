Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A88DC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 22:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657B2879DF;
	Thu, 28 Dec 2023 23:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yo3+LTiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45018879E9; Thu, 28 Dec 2023 23:26:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBBC87954
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 23:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2776ce12bcso67520366b.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703802397; x=1704407197; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taHVoEXSEm9rsBczXUVU9znvcyHAIoepTlv/igiUQVk=;
 b=Yo3+LTiT3FBxpzTV4eyS5y1Lyud1cvlGljdFyo4EhQMXpUPxdA6buam/LwqYCFWSFY
 lnzvOQPtDloeKfHSDJAsjxUNVwN6oe5RYkeBQopd79skG1zjU56/s8FxhC4+thkbJKYy
 7M3IRDIyD8mD6dRlCBVx5L0uohYSq/bPpKkD4T4bZcoaYgIjIir2INLrj0MsI4K0MSrA
 F3nuNLIrXe/nhgNw5chsUZjl3vkQ9GMludbLFDB9K47DhOeSQHMJqm1txIRuBwioitoE
 bs5SJbVyML7bgxfvQdgFXaZFgzdFAWEHbI/LvRGoeEjHqX0KwyeDtPmRCiO0elZjqgeO
 ee7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703802397; x=1704407197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taHVoEXSEm9rsBczXUVU9znvcyHAIoepTlv/igiUQVk=;
 b=GqD8+j1Gx8RXAAQ5JCYLp3BC5uCiloyZcN7QqO495TOOBjiEhkPldWGSgxnBnkPmGX
 FE0oaD7M/qezZ0U4quiVGSmBwTNYmbOlXcfX5E2dMJZ3anN3QsU5ePjdHOAvUVSy7pm+
 BQlTiAdkya/ByGBaMkTYI60qTGw4wd1Vkn8voeXua/lNQSK9P6MWY2fxgdvaCAvaqJ57
 46edRy5Y6ybKaRoxWxIxyLEqxj+Bn/3IkJpxfqDEjIx76jNtKJ+7lyK3plwq1My3sh1t
 RkvksmWsVBRNiaUeZ7q4h4aJ6/Jlxprl/OU276zt6HqtRMGdJVsu6AkddPBgL+046QG6
 2vTg==
X-Gm-Message-State: AOJu0YxPN3GK+4dG63892wpJhdhirdiaHVYqtX0EMy6QGC1jhLBnks4y
 y1YPo+vsQRmeoE0zgnCukkIT0rBw+vpsgqnMbUWhiW3DQWY=
X-Google-Smtp-Source: AGHT+IGzelP059P2C9Oi1KTYeOdcSx/3jum6QkINWFmFdWUp2F3x5mIWLQCbTwy30ZhoyQ0ndBUjRBgRonCl9A7nX0c=
X-Received: by 2002:a17:907:29d5:b0:a23:59e4:bf16 with SMTP id
 ev21-20020a17090729d500b00a2359e4bf16mr4149716ejc.83.1703802396396; Thu, 28
 Dec 2023 14:26:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
 <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
 <CA+1FSihKXuqLMTbZzSdKXwMKAnO0nKu1ne92UXS_m9A1f8jqYA@mail.gmail.com>
 <CA+1FSigNkAcc=8PZQkOaD12HvS+y+TfP=urykBXUy8Ye2fUZtQ@mail.gmail.com>
 <CAFLszThG7egV+=vq2qm7Qu4UzDfgHGCQB=LFRSbnW9HH4pDF3A@mail.gmail.com>
 <CAJaLiFxRBB0bxCY3Og+MeQ5F=57J7eVKP_Besmhd9dA0jKCJow@mail.gmail.com>
In-Reply-To: <CAJaLiFxRBB0bxCY3Og+MeQ5F=57J7eVKP_Besmhd9dA0jKCJow@mail.gmail.com>
From: Mario Marietto <marietto2008@gmail.com>
Date: Thu, 28 Dec 2023 23:26:00 +0100
Message-ID: <CA+1FSihq5kibi_f8NL7p0cUQFqhk=4xORa1+CvV1FE-osvxh+g@mail.gmail.com>
Subject: Re: I'm looking for the source code of a specific u-boot version.
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

I've just built it with Ubuntu 18.04 / gcc 7.5.0 ; I have my
u-boot.bin and I tried to see if it worked,but unfortunately it
doesn't.

root@devuan-bunsen:/mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebs=
d#
./start-freebsd

Parsing config from freebsd.cfg
xc: error: panic: xg_dom_core.c:689: xc_dom_find_loader: no loader
found: Invalid kernel
libxl: error: libxl_dom.c:571:libxl__build_dom: xc_dom_parse_image failed
libxl: error: libxl_create.c:1640:domcreate_rebuild_done: Domain
1:cannot (re-)build domain: -3
libxl: error: libxl_domain.c:1183:libxl__destroy_domid: Domain
1:Non-existent domain
libxl: error: libxl_domain.c:1137:domain_destroy_callback: Domain
1:Unable to destroy guest
libxl: error: libxl_domain.c:1064:domain_destroy_cb: Domain
1:Destruction of domain failed
freebsd is an invalid domain identifier (rc=3D-6)

start-freebsd :

xl create freebsd.cfg
xl console freebsd

freebsd.cfg :

name=3D"freebsd"
kernel=3D"/mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloa=
ders/u-boot.bin"
extra =3D "console=3Dhvc0"
memory=3D512
vcpus=3D1
disk =3D [ 'FreeBSD-13.2-RELEASE-armv7.img,raw,xvda' ]


On Thu, Dec 28, 2023 at 10:54=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> On Thu, Dec 28, 2023 at 11:48=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Mario,
> >
> > On Thu, Dec 28, 2023 at 3:48=E2=80=AFPM Mario Marietto <marietto2008@gm=
ail.com> wrote:
> > >
> > > I tried to compile it,but If failed :
> > >
> > > /mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders=
/u-boot-2017.05#
> > > ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make snow_defconfig
> > >
> > >   HOSTCC  scripts/basic/fixdep
> > >   HOSTCC  scripts/kconfig/conf.o
> > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > > In file included from scripts/kconfig/zconf.tab.c:2470:
> > > In function =E2=80=98dep_stack_insert=E2=80=99,
> > >     inlined from =E2=80=98sym_check_print_recursive=E2=80=99 at scrip=
ts/kconfig/symbol.c:1123:3,
> > >     inlined from =E2=80=98sym_check_deps=E2=80=99 at scripts/kconfig/=
symbol.c:1300:3:
> > > scripts/kconfig/symbol.c:1099:19: warning: storing the address of
> > > local variable =E2=80=98cv_stack=E2=80=99 in =E2=80=98check_top=E2=80=
=99 [-Wdangling-pointer=3D]
> > >  1099 |         check_top =3D stack;
> > >       |         ~~~~~~~~~~^~~~~~~
> > > scripts/kconfig/symbol.c: In function =E2=80=98sym_check_deps=E2=80=
=99:
> > > scripts/kconfig/symbol.c:1120:26: note: =E2=80=98cv_stack=E2=80=99 de=
clared here
> > >  1120 |         struct dep_stack cv_stack;
> > >       |                          ^~~~~~~~
> > > scripts/kconfig/symbol.c:1090:4: note: =E2=80=98check_top=E2=80=99 de=
clared here
> > >  1090 | } *check_top;
> > >       |    ^~~~~~~~~
> > >   HOSTLD  scripts/kconfig/conf
> > > #
> > > # configuration written to .config
> > > #
> > >
> > > /mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders=
/u-boot-2017.05#
> > > ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make
> > >
> > > scripts/kconfig/conf  --silentoldconfig Kconfig
> > >   CHK     include/config.h
> > >   CFG     u-boot.cfg
> > >   GEN     include/autoconf.mk
> > >   GEN     include/autoconf.mk.dep
> > >   CFG     spl/u-boot.cfg
> > >   GEN     spl/include/autoconf.mk
> > >   CHK     include/config/uboot.release
> > >   CHK     include/generated/version_autogenerated.h
> > >   CHK     include/generated/timestamp_autogenerated.h
> > >   UPD     include/generated/timestamp_autogenerated.h
> > >   CC      lib/asm-offsets.s
> > > arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv5
> > > arm-linux-gnueabihf-gcc: note: valid arguments are: armv4 armv4t
> > > armv5t armv5te armv5tej armv6 armv6j armv6k armv6z armv6kz armv6zk
> > > armv6t2 armv6-m armv6s-m armv7 armv7-a armv7ve armv7-r armv7-m
> > > armv7e-m armv8-a armv8.1-a armv8.2-a armv8.3-a armv8.4-a armv8.5-a
> > > armv8.6-a armv8-m.base armv8-m.main armv8-r armv8.1-m.main armv9-a
> > > iwmmxt iwmmxt2; did you mean =E2=80=98armv4=E2=80=99?
> > > arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=
=3D=E2=80=99
> > > make[1]: *** [Kbuild:44: lib/asm-offsets.s] Error 1
> > > make: *** [Makefile:1287: prepare0] Error 2
> >
> > You might need to compile with an old toolchain, e.g. gcc 4?
>
> I think Simon is right. I could not rebuild that 2017.05 u-boot with
> gcc 12 now. So I looked at the old log, and it was built with gcc 6.3.
>
>   gcc -Wp,-MD,disk/.part_efi.o.d  -nostdinc -isystem
> /usr/lib/gcc/arm-linux-gnueabi/6/include -Iinclude
> -I./arch/arm/include -include ./include/linux/kconfig.h -D__KERNEL__
> -D__UBOOT__ -Wall -Wstrict-prototypes -Wno-format-security
> -fno-builtin -ffreestanding -Os -fno-stack-protector
> -fno-delete-null-pointer-checks -g -fstack-usage
> -Wno-format-nonliteral -Werror=3Ddate-time -D__ARM__ -marm
> -mno-thumb-interwork -mabi=3Daapcs-linux -mword-relocations -fno-pic
> -ffunction-sections -fdata-sections -fno-common -ffixed-r9
> -msoft-float -pipe -march=3Darmv5te -D__LINUX_ARM_ARCH__=3D5
> -I./arch/arm/mach-kirkwood/include    -D"KBUILD_STR(s)=3D#s"
> -D"KBUILD_BASENAME=3DKBUILD_STR(part_efi)"
> -D"KBUILD_MODNAME=3DKBUILD_STR(part_efi)" -c -o disk/part_efi.o
> disk/part_efi.c
>
> # ll /usr/lib/gcc/arm-linux-gnueabi/6* -d
> drwxr-xr-x 5 root root 4096 Apr 14  2019 /usr/lib/gcc/arm-linux-gnueabi/6
> lrwxrwxrwx 1 root root    1 May 16  2017
> /usr/lib/gcc/arm-linux-gnueabi/6.3.0 -> 6
>
> Hope this helps.
>
> All the best,
> Tony
>
> >
> > Regards,
> > Simon
> >
> >
> > >
> > > On Thu, Dec 28, 2023 at 3:47=E2=80=AFPM Mario Marietto <marietto2008@=
gmail.com> wrote:
> > > >
> > > > Hello.
> > > >
> > > > Can someone provide the right link to download u-boot-2017.0.5 , pl=
ease ?
> > > >
> > > > I've found it here,but I'm not sure that it's the correct version :
> > > >
> > > > https://src.fedoraproject.org/repo/pkgs/uboot-tools/u-boot-2017.05.=
tar.bz2/sha512/be270f9242a72b05463092a022bbabd54996762de1ff23bf7575124ac02e=
62f49572a4e2f6f571a5019047d40027e56e35593b5cc373c4a5a39b100c3377ba93/
> > > >
> > > > Can you confirm it ? thanks.
> > > >
> > > > On Thu, Dec 28, 2023 at 1:14=E2=80=AFAM Tony Dinh <mibodhi@gmail.co=
m> wrote:
> > > > >
> > > > > Hi Mario and Heinrich,
> > > > >
> > > > > On Wed, Dec 27, 2023 at 12:23=E2=80=AFPM Mario Marietto <marietto=
2008@gmail.com> wrote:
> > > > > >
> > > > > > Hello.
> > > > > >
> > > > > > I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chro=
mebook
> > > > > > SNOW with xen. Basically there are two ways to accomplish this =
task :
> > > > > >
> > > > > >
> > > > > > 1) to write a patch that allows the FreeBSD kernel to boot as a=
 zImage
> > > > > > file. This could be accomplished applying this patch to a speci=
fic
> > > > > > file that's on the source code of FreeBSD :
> > > > > >
> > > > > >
> > > > > > https://xenbits.xen.org/gitweb/?p=3Dp...8;hb=3D0782e25d98cc1391=
472717035f986c979edef0c9
> > > > > >
> > > > > >
> > > > > >
> > > > > > This patch was written by Julien Grall a lot of time ago and no=
w it
> > > > > > does not work anymore. This is the reason explain by the xen
> > > > > > developers :
> > > > > >
> > > > > >
> > > > > >
> > > > > > It appears FreeBSD-CURRENT removed the last step converting the=
 kernel
> > > > > > file to kernel.bin.The patch can be readily rebased, but withou=
t
> > > > > > kernel.bin that doesn't do too much.
> > > > > >
> > > > > >
> > > > > >
> > > > > > So,without a rebase of that patch the first option is not appli=
cable.
> > > > > > And I'm not able to fix it.
> > > > > >
> > > > > >
> > > > > > 2) booting FreeBSD using U-Boot,as explained to me by a xen dev=
eloper :
> > > > > >
> > > > > >
> > > > > > I was trying to explain why and how Julien's patch works so tha=
t you
> > > > > > could be the one to re-do something similar or fix the patch on=
 the
> > > > > > FreeBSD kernel that you are working with. I am happy to help re=
view
> > > > > > and write patches but I don't work with the FreeBSD kernel so I
> > > > > > wouldn't be able to help you quickly. However, I might have a
> > > > > > suggestion. Do you know if FreeBSD can be booted by U-Boot ?
> > > > > > Because
> > > > > > U-Boot definitely boots as Xen on ARM guest firmware/bootloader=
. You
> > > > > > should be able to build U-Boot and use the U-Boot binary as Xen=
 guest
> > > > > > kernel, then U-Boot could load FreeBSD from disk or network and=
 start
> > > > > > it. For instance as domU config file:
> > > > > >
> > > > > > kernel=3D"/home/petalinux/u-boot.bin"
> > > > > > disk =3D [ '/home/petalinux/test.img,raw,xvda' ]
> > > > > >
> > > > > >
> > > > > > Actually I'm working on the idea n. 2. Basically I need to find=
 the
> > > > > > proper u-boot file that's able to boot the image of FreeBSD tha=
t I
> > > > > > have installed (13.2 for arm32 bit). Maybe I found it here :
> > > > > >
> > > > > >
> > > > > > http://commondatastorage.googleapis.com/chromeos-localmirror/di=
stfiles/nv_uboot-snow-simplefb.kpart.bz2
> > > > > >
> > > > > >
> > > > > > I found that link inside this tutorial :
> > > > > >
> > > > > >
> > > > > > https://wiki.freebsd.org/arm/Chromebook
> > > > > >
> > > > > >
> > > > > > the version of u-boot that has been embedded in that file is th=
e following one :
> > > > > >
> > > > > >
> > > > > > # strings nv_uboot-snow-simplefb.kpart | grep U-Boot
> > > > > > U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
> > > > > >
> > > > > >
> > > > > > So the question is easy : I need to find the source code of tha=
t old
> > > > > > version of u-boot,because once compiled,it will give me the pro=
per
> > > > > > u-boot.bin kernel / bootloader file that maybe will be able to =
boot
> > > > > > FreeBSD.
> > > > >
> > > > > Yes, it can boot a 32-bit ARM board. I'm not a FreeBSD person, bu=
t
> > > > > I've helped a FreeBSD user booting a 32-bit ARM box with u-boot
> > > > > (GoFlexHome Marvell Kirkwood 6281). The u-boot version was 2017.0=
5. I
> > > > > used an out-of-tree u-boot build. This u-boot executed the ubldr =
to
> > > > > boot FreeBSD.
> > > > >
> > > > > Please see here:
> > > > > https://forum.doozan.com/read.php?3,49039,82059#msg-82059
> > > > >
> > > > > It's been so long, I don't remember the details. Just to confirm =
what
> > > > > Heinrich said that u-boot can indeed boot 32-bit FreeBSD, since m=
any
> > > > > years ago.
> > > > >
> > > > > All the best,
> > > > > Tony
> > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Mario.
> > > >
> > > >
> > > >
> > > > --
> > > > Mario.
> > >
> > >
> > >
> > > --
> > > Mario.



--
Mario.
