Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E257C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 21:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B695E879FE;
	Thu, 28 Dec 2023 22:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWheoNEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE2F87A08; Thu, 28 Dec 2023 22:54:59 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1A7879E9
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e7c6e3c63so3216801e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703800496; x=1704405296; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMnzS6PUNcJoVP87B3uX09j4z9DJsvzD75Z1c8dBGfw=;
 b=eWheoNELKek9oiRjlT1HxRdRV13hHskzKw7Sa4EzZttZ11FANk1Pp7WF6lWeXVo9qf
 cqfzjgYfiDGxqW1N2RSAVcQpJVPf38wuIUCtGak9kvH1W2WvZ66TuYUCp3FslKJ1EcYC
 RDdKAMwWxpBVgUxsoaPIxLMqACnsBLqcg1qB1o2Hj1zLmwJQrj/Ey61xDsi93gnX712m
 9u68DjgEGjgPwr3XazCpn+SG4YKHKgf4tOyppEHT1GwS7qUvsjk0UWk+nxgLhSGhOl9v
 fPJPjF9aXoO2QvumIqyHajREZtkSLoHqh5u8arXj2YoGqWkr8p1CV8Azqrzo+akHn5qf
 qQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703800496; x=1704405296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMnzS6PUNcJoVP87B3uX09j4z9DJsvzD75Z1c8dBGfw=;
 b=H8JsxDhJkQeAahcn3h0icZwa8H5Nhl+s8mu+XP4mTAkxOVkcohAgyBeEA/I4nwLust
 LM3IrJABXc/w8t0oKx8tO3BZQIrp4w7xxJjCYDuRfD7SeyWndlAO4IVwvBaDAho4oC9T
 45W2Eg/kEhTpa/obYr2IxAX+x3jjwKG/tLwJW7doCIpu+ArOS+ZTUwewMDjQA2w3v77v
 +t/QdXj45aSKsKZBzKyXE1nOZXeiLpP3M3R6C6hEm3hJ3yX1mR3GTZBWM712GkAzMDk0
 fJhODLay5WFijsPreWHpTr7RYoVHtmFui8nhvn0wOYeB9tZf8vAJkEfpW09XwTEuA08D
 XSMg==
X-Gm-Message-State: AOJu0YyozEzsc3aJH2f6pnIgVpoBqyf4YlZRcF2RtcrtFQwWmjlsXuOf
 gcW0Wu0FcLdLGQ9RWQzw+8+vvGinBOgvMY8iKgY=
X-Google-Smtp-Source: AGHT+IFKETtnOgByW8FFncXBzR5GuoCRxdwEtP0M+3z/iCFuxCe6d1XzTBq4UsDuHBqSZAai34UcpeaJ7iuZS0DKsyE=
X-Received: by 2002:a05:6512:33d5:b0:50e:7e4b:4f7a with SMTP id
 d21-20020a05651233d500b0050e7e4b4f7amr1517101lfg.96.1703800495482; Thu, 28
 Dec 2023 13:54:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
 <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
 <CA+1FSihKXuqLMTbZzSdKXwMKAnO0nKu1ne92UXS_m9A1f8jqYA@mail.gmail.com>
 <CA+1FSigNkAcc=8PZQkOaD12HvS+y+TfP=urykBXUy8Ye2fUZtQ@mail.gmail.com>
 <CAFLszThG7egV+=vq2qm7Qu4UzDfgHGCQB=LFRSbnW9HH4pDF3A@mail.gmail.com>
In-Reply-To: <CAFLszThG7egV+=vq2qm7Qu4UzDfgHGCQB=LFRSbnW9HH4pDF3A@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 28 Dec 2023 13:54:43 -0800
Message-ID: <CAJaLiFxRBB0bxCY3Og+MeQ5F=57J7eVKP_Besmhd9dA0jKCJow@mail.gmail.com>
Subject: Re: I'm looking for the source code of a specific u-boot version.
To: Simon Glass <sjg@chromium.org>
Cc: Mario Marietto <marietto2008@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Thu, Dec 28, 2023 at 11:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Mario,
>
> On Thu, Dec 28, 2023 at 3:48=E2=80=AFPM Mario Marietto <marietto2008@gmai=
l.com> wrote:
> >
> > I tried to compile it,but If failed :
> >
> > /mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders/u=
-boot-2017.05#
> > ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make snow_defconfig
> >
> >   HOSTCC  scripts/basic/fixdep
> >   HOSTCC  scripts/kconfig/conf.o
> >   HOSTCC  scripts/kconfig/zconf.tab.o
> > In file included from scripts/kconfig/zconf.tab.c:2470:
> > In function =E2=80=98dep_stack_insert=E2=80=99,
> >     inlined from =E2=80=98sym_check_print_recursive=E2=80=99 at scripts=
/kconfig/symbol.c:1123:3,
> >     inlined from =E2=80=98sym_check_deps=E2=80=99 at scripts/kconfig/sy=
mbol.c:1300:3:
> > scripts/kconfig/symbol.c:1099:19: warning: storing the address of
> > local variable =E2=80=98cv_stack=E2=80=99 in =E2=80=98check_top=E2=80=
=99 [-Wdangling-pointer=3D]
> >  1099 |         check_top =3D stack;
> >       |         ~~~~~~~~~~^~~~~~~
> > scripts/kconfig/symbol.c: In function =E2=80=98sym_check_deps=E2=80=99:
> > scripts/kconfig/symbol.c:1120:26: note: =E2=80=98cv_stack=E2=80=99 decl=
ared here
> >  1120 |         struct dep_stack cv_stack;
> >       |                          ^~~~~~~~
> > scripts/kconfig/symbol.c:1090:4: note: =E2=80=98check_top=E2=80=99 decl=
ared here
> >  1090 | } *check_top;
> >       |    ^~~~~~~~~
> >   HOSTLD  scripts/kconfig/conf
> > #
> > # configuration written to .config
> > #
> >
> > /mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders/u=
-boot-2017.05#
> > ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make
> >
> > scripts/kconfig/conf  --silentoldconfig Kconfig
> >   CHK     include/config.h
> >   CFG     u-boot.cfg
> >   GEN     include/autoconf.mk
> >   GEN     include/autoconf.mk.dep
> >   CFG     spl/u-boot.cfg
> >   GEN     spl/include/autoconf.mk
> >   CHK     include/config/uboot.release
> >   CHK     include/generated/version_autogenerated.h
> >   CHK     include/generated/timestamp_autogenerated.h
> >   UPD     include/generated/timestamp_autogenerated.h
> >   CC      lib/asm-offsets.s
> > arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv5
> > arm-linux-gnueabihf-gcc: note: valid arguments are: armv4 armv4t
> > armv5t armv5te armv5tej armv6 armv6j armv6k armv6z armv6kz armv6zk
> > armv6t2 armv6-m armv6s-m armv7 armv7-a armv7ve armv7-r armv7-m
> > armv7e-m armv8-a armv8.1-a armv8.2-a armv8.3-a armv8.4-a armv8.5-a
> > armv8.6-a armv8-m.base armv8-m.main armv8-r armv8.1-m.main armv9-a
> > iwmmxt iwmmxt2; did you mean =E2=80=98armv4=E2=80=99?
> > arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=
=E2=80=99
> > make[1]: *** [Kbuild:44: lib/asm-offsets.s] Error 1
> > make: *** [Makefile:1287: prepare0] Error 2
>
> You might need to compile with an old toolchain, e.g. gcc 4?

I think Simon is right. I could not rebuild that 2017.05 u-boot with
gcc 12 now. So I looked at the old log, and it was built with gcc 6.3.

  gcc -Wp,-MD,disk/.part_efi.o.d  -nostdinc -isystem
/usr/lib/gcc/arm-linux-gnueabi/6/include -Iinclude
-I./arch/arm/include -include ./include/linux/kconfig.h -D__KERNEL__
-D__UBOOT__ -Wall -Wstrict-prototypes -Wno-format-security
-fno-builtin -ffreestanding -Os -fno-stack-protector
-fno-delete-null-pointer-checks -g -fstack-usage
-Wno-format-nonliteral -Werror=3Ddate-time -D__ARM__ -marm
-mno-thumb-interwork -mabi=3Daapcs-linux -mword-relocations -fno-pic
-ffunction-sections -fdata-sections -fno-common -ffixed-r9
-msoft-float -pipe -march=3Darmv5te -D__LINUX_ARM_ARCH__=3D5
-I./arch/arm/mach-kirkwood/include    -D"KBUILD_STR(s)=3D#s"
-D"KBUILD_BASENAME=3DKBUILD_STR(part_efi)"
-D"KBUILD_MODNAME=3DKBUILD_STR(part_efi)" -c -o disk/part_efi.o
disk/part_efi.c

# ll /usr/lib/gcc/arm-linux-gnueabi/6* -d
drwxr-xr-x 5 root root 4096 Apr 14  2019 /usr/lib/gcc/arm-linux-gnueabi/6
lrwxrwxrwx 1 root root    1 May 16  2017
/usr/lib/gcc/arm-linux-gnueabi/6.3.0 -> 6

Hope this helps.

All the best,
Tony

>
> Regards,
> Simon
>
>
> >
> > On Thu, Dec 28, 2023 at 3:47=E2=80=AFPM Mario Marietto <marietto2008@gm=
ail.com> wrote:
> > >
> > > Hello.
> > >
> > > Can someone provide the right link to download u-boot-2017.0.5 , plea=
se ?
> > >
> > > I've found it here,but I'm not sure that it's the correct version :
> > >
> > > https://src.fedoraproject.org/repo/pkgs/uboot-tools/u-boot-2017.05.ta=
r.bz2/sha512/be270f9242a72b05463092a022bbabd54996762de1ff23bf7575124ac02e62=
f49572a4e2f6f571a5019047d40027e56e35593b5cc373c4a5a39b100c3377ba93/
> > >
> > > Can you confirm it ? thanks.
> > >
> > > On Thu, Dec 28, 2023 at 1:14=E2=80=AFAM Tony Dinh <mibodhi@gmail.com>=
 wrote:
> > > >
> > > > Hi Mario and Heinrich,
> > > >
> > > > On Wed, Dec 27, 2023 at 12:23=E2=80=AFPM Mario Marietto <marietto20=
08@gmail.com> wrote:
> > > > >
> > > > > Hello.
> > > > >
> > > > > I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chrome=
book
> > > > > SNOW with xen. Basically there are two ways to accomplish this ta=
sk :
> > > > >
> > > > >
> > > > > 1) to write a patch that allows the FreeBSD kernel to boot as a z=
Image
> > > > > file. This could be accomplished applying this patch to a specifi=
c
> > > > > file that's on the source code of FreeBSD :
> > > > >
> > > > >
> > > > > https://xenbits.xen.org/gitweb/?p=3Dp...8;hb=3D0782e25d98cc139147=
2717035f986c979edef0c9
> > > > >
> > > > >
> > > > >
> > > > > This patch was written by Julien Grall a lot of time ago and now =
it
> > > > > does not work anymore. This is the reason explain by the xen
> > > > > developers :
> > > > >
> > > > >
> > > > >
> > > > > It appears FreeBSD-CURRENT removed the last step converting the k=
ernel
> > > > > file to kernel.bin.The patch can be readily rebased, but without
> > > > > kernel.bin that doesn't do too much.
> > > > >
> > > > >
> > > > >
> > > > > So,without a rebase of that patch the first option is not applica=
ble.
> > > > > And I'm not able to fix it.
> > > > >
> > > > >
> > > > > 2) booting FreeBSD using U-Boot,as explained to me by a xen devel=
oper :
> > > > >
> > > > >
> > > > > I was trying to explain why and how Julien's patch works so that =
you
> > > > > could be the one to re-do something similar or fix the patch on t=
he
> > > > > FreeBSD kernel that you are working with. I am happy to help revi=
ew
> > > > > and write patches but I don't work with the FreeBSD kernel so I
> > > > > wouldn't be able to help you quickly. However, I might have a
> > > > > suggestion. Do you know if FreeBSD can be booted by U-Boot ?
> > > > > Because
> > > > > U-Boot definitely boots as Xen on ARM guest firmware/bootloader. =
You
> > > > > should be able to build U-Boot and use the U-Boot binary as Xen g=
uest
> > > > > kernel, then U-Boot could load FreeBSD from disk or network and s=
tart
> > > > > it. For instance as domU config file:
> > > > >
> > > > > kernel=3D"/home/petalinux/u-boot.bin"
> > > > > disk =3D [ '/home/petalinux/test.img,raw,xvda' ]
> > > > >
> > > > >
> > > > > Actually I'm working on the idea n. 2. Basically I need to find t=
he
> > > > > proper u-boot file that's able to boot the image of FreeBSD that =
I
> > > > > have installed (13.2 for arm32 bit). Maybe I found it here :
> > > > >
> > > > >
> > > > > http://commondatastorage.googleapis.com/chromeos-localmirror/dist=
files/nv_uboot-snow-simplefb.kpart.bz2
> > > > >
> > > > >
> > > > > I found that link inside this tutorial :
> > > > >
> > > > >
> > > > > https://wiki.freebsd.org/arm/Chromebook
> > > > >
> > > > >
> > > > > the version of u-boot that has been embedded in that file is the =
following one :
> > > > >
> > > > >
> > > > > # strings nv_uboot-snow-simplefb.kpart | grep U-Boot
> > > > > U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
> > > > >
> > > > >
> > > > > So the question is easy : I need to find the source code of that =
old
> > > > > version of u-boot,because once compiled,it will give me the prope=
r
> > > > > u-boot.bin kernel / bootloader file that maybe will be able to bo=
ot
> > > > > FreeBSD.
> > > >
> > > > Yes, it can boot a 32-bit ARM board. I'm not a FreeBSD person, but
> > > > I've helped a FreeBSD user booting a 32-bit ARM box with u-boot
> > > > (GoFlexHome Marvell Kirkwood 6281). The u-boot version was 2017.05.=
 I
> > > > used an out-of-tree u-boot build. This u-boot executed the ubldr to
> > > > boot FreeBSD.
> > > >
> > > > Please see here:
> > > > https://forum.doozan.com/read.php?3,49039,82059#msg-82059
> > > >
> > > > It's been so long, I don't remember the details. Just to confirm wh=
at
> > > > Heinrich said that u-boot can indeed boot 32-bit FreeBSD, since man=
y
> > > > years ago.
> > > >
> > > > All the best,
> > > > Tony
> > > >
> > > > >
> > > > >
> > > > > --
> > > > > Mario.
> > >
> > >
> > >
> > > --
> > > Mario.
> >
> >
> >
> > --
> > Mario.
