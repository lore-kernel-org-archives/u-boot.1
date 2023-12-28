Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF7C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6324587A17;
	Thu, 28 Dec 2023 16:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AA34Z5YM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337638774E; Thu, 28 Dec 2023 16:48:45 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D970087AB4
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-555aa7fd668so273087a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703778522; x=1704383322; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0man9ui24iT0HLcq6KQJl2hwK7KZsHqmgtq9ZXDyuM=;
 b=AA34Z5YMNE4CNjNZZSJR7QEMHq2Dff1t3AASFzjd/qmlV7v5YN6dONxDCz7IT7tUJt
 EA+iZWHAxSLHd2sR0BzwUurFmH6m8e3d7SZkOUi7QStKObm4zRTY4dBWP95Bau7yWVvY
 QmE93LLKUEJG3xRgXmZvs5TuJ10zEP1Qg8yfQLqFIWyA7OXgCLTYxJ/HZc9yQoTpniiu
 +pYazTJevB1QmS+V57GdjIUZEIenlpBSEKjmF5nh7AqVvgeFGZW8Fx2SRxGfitmoNoZU
 WKThwNBZMjUC9BMaXx4MeCa2XzOaZLQPR1wdegKnBnEQkmcez1xwIye+SNOhusJ35ab9
 GiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703778522; x=1704383322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0man9ui24iT0HLcq6KQJl2hwK7KZsHqmgtq9ZXDyuM=;
 b=PmcDTI8FGTdxQuGXcGX8HDcQRDyMNQJvLVGN36QTqxS1+psD2u171nJ0/ee5kkCwuM
 pcAwxW5H7TzRCSs/hV8gFnO3fVg8/FYLKQbsOM+LZTYG+rU5DG0V7XQQ7cJYW8YcKNu9
 0BsCwD5WZ1IK7Q0E3Rpu9magCK+ClwCYh5LSaFwNdQzxkNMpE/9WfO4gLhinxgaBjwhe
 xJ10b1/Ey3VXGUkKXQbcGBwSjKthrOzglZyR4+2pL+w0aS/0P36Im6nByHX4WF4Aj6V7
 tN3eFmUEb7rXljSxgnkJJ+C9v791G35AHtBW0H979BQYS1S/doSY1+yISDe2qD7Easof
 8+zQ==
X-Gm-Message-State: AOJu0Yx9S5NoM3E1Nv643KCd04VqWLJX9q4bZMg1KaUn11siErgaZnvu
 9qB2rZRJ+jWDBpdiSHKxSx0OSRYlb69Tpg62QWpWMrNpURQ=
X-Google-Smtp-Source: AGHT+IHhHgziC67SJnjFYtkFQ88ykC3qvtHSenNM/H7NvdeB1OX/2KjNqkb43Ldywl1edkE8L5rnhTYAtzSGwYyTkes=
X-Received: by 2002:a17:906:f910:b0:a26:965a:e866 with SMTP id
 lc16-20020a170906f91000b00a26965ae866mr5234273ejb.111.1703778522043; Thu, 28
 Dec 2023 07:48:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
 <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
 <CA+1FSihKXuqLMTbZzSdKXwMKAnO0nKu1ne92UXS_m9A1f8jqYA@mail.gmail.com>
In-Reply-To: <CA+1FSihKXuqLMTbZzSdKXwMKAnO0nKu1ne92UXS_m9A1f8jqYA@mail.gmail.com>
From: Mario Marietto <marietto2008@gmail.com>
Date: Thu, 28 Dec 2023 16:48:05 +0100
Message-ID: <CA+1FSigNkAcc=8PZQkOaD12HvS+y+TfP=urykBXUy8Ye2fUZtQ@mail.gmail.com>
Subject: Re: I'm looking for the source code of a specific u-boot version.
To: Tony Dinh <mibodhi@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

I tried to compile it,but If failed :

/mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders/u-boo=
t-2017.05#
ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make snow_defconfig

  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:2470:
In function =E2=80=98dep_stack_insert=E2=80=99,
    inlined from =E2=80=98sym_check_print_recursive=E2=80=99 at scripts/kco=
nfig/symbol.c:1123:3,
    inlined from =E2=80=98sym_check_deps=E2=80=99 at scripts/kconfig/symbol=
.c:1300:3:
scripts/kconfig/symbol.c:1099:19: warning: storing the address of
local variable =E2=80=98cv_stack=E2=80=99 in =E2=80=98check_top=E2=80=99 [-=
Wdangling-pointer=3D]
 1099 |         check_top =3D stack;
      |         ~~~~~~~~~~^~~~~~~
scripts/kconfig/symbol.c: In function =E2=80=98sym_check_deps=E2=80=99:
scripts/kconfig/symbol.c:1120:26: note: =E2=80=98cv_stack=E2=80=99 declared=
 here
 1120 |         struct dep_stack cv_stack;
      |                          ^~~~~~~~
scripts/kconfig/symbol.c:1090:4: note: =E2=80=98check_top=E2=80=99 declared=
 here
 1090 | } *check_top;
      |    ^~~~~~~~~
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#

/mnt/zroot2/zroot2/OS/Chromebook/freebsd-xen/domU-freebsd/bootloaders/u-boo=
t-2017.05#
ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make

scripts/kconfig/conf  --silentoldconfig Kconfig
  CHK     include/config.h
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  CFG     spl/u-boot.cfg
  GEN     spl/include/autoconf.mk
  CHK     include/config/uboot.release
  CHK     include/generated/version_autogenerated.h
  CHK     include/generated/timestamp_autogenerated.h
  UPD     include/generated/timestamp_autogenerated.h
  CC      lib/asm-offsets.s
arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv5
arm-linux-gnueabihf-gcc: note: valid arguments are: armv4 armv4t
armv5t armv5te armv5tej armv6 armv6j armv6k armv6z armv6kz armv6zk
armv6t2 armv6-m armv6s-m armv7 armv7-a armv7ve armv7-r armv7-m
armv7e-m armv8-a armv8.1-a armv8.2-a armv8.3-a armv8.4-a armv8.5-a
armv8.6-a armv8-m.base armv8-m.main armv8-r armv8.1-m.main armv9-a
iwmmxt iwmmxt2; did you mean =E2=80=98armv4=E2=80=99?
arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=E2=
=80=99
make[1]: *** [Kbuild:44: lib/asm-offsets.s] Error 1
make: *** [Makefile:1287: prepare0] Error 2

On Thu, Dec 28, 2023 at 3:47=E2=80=AFPM Mario Marietto <marietto2008@gmail.=
com> wrote:
>
> Hello.
>
> Can someone provide the right link to download u-boot-2017.0.5 , please ?
>
> I've found it here,but I'm not sure that it's the correct version :
>
> https://src.fedoraproject.org/repo/pkgs/uboot-tools/u-boot-2017.05.tar.bz=
2/sha512/be270f9242a72b05463092a022bbabd54996762de1ff23bf7575124ac02e62f495=
72a4e2f6f571a5019047d40027e56e35593b5cc373c4a5a39b100c3377ba93/
>
> Can you confirm it ? thanks.
>
> On Thu, Dec 28, 2023 at 1:14=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > Hi Mario and Heinrich,
> >
> > On Wed, Dec 27, 2023 at 12:23=E2=80=AFPM Mario Marietto <marietto2008@g=
mail.com> wrote:
> > >
> > > Hello.
> > >
> > > I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook
> > > SNOW with xen. Basically there are two ways to accomplish this task :
> > >
> > >
> > > 1) to write a patch that allows the FreeBSD kernel to boot as a zImag=
e
> > > file. This could be accomplished applying this patch to a specific
> > > file that's on the source code of FreeBSD :
> > >
> > >
> > > https://xenbits.xen.org/gitweb/?p=3Dp...8;hb=3D0782e25d98cc1391472717=
035f986c979edef0c9
> > >
> > >
> > >
> > > This patch was written by Julien Grall a lot of time ago and now it
> > > does not work anymore. This is the reason explain by the xen
> > > developers :
> > >
> > >
> > >
> > > It appears FreeBSD-CURRENT removed the last step converting the kerne=
l
> > > file to kernel.bin.The patch can be readily rebased, but without
> > > kernel.bin that doesn't do too much.
> > >
> > >
> > >
> > > So,without a rebase of that patch the first option is not applicable.
> > > And I'm not able to fix it.
> > >
> > >
> > > 2) booting FreeBSD using U-Boot,as explained to me by a xen developer=
 :
> > >
> > >
> > > I was trying to explain why and how Julien's patch works so that you
> > > could be the one to re-do something similar or fix the patch on the
> > > FreeBSD kernel that you are working with. I am happy to help review
> > > and write patches but I don't work with the FreeBSD kernel so I
> > > wouldn't be able to help you quickly. However, I might have a
> > > suggestion. Do you know if FreeBSD can be booted by U-Boot ?
> > > Because
> > > U-Boot definitely boots as Xen on ARM guest firmware/bootloader. You
> > > should be able to build U-Boot and use the U-Boot binary as Xen guest
> > > kernel, then U-Boot could load FreeBSD from disk or network and start
> > > it. For instance as domU config file:
> > >
> > > kernel=3D"/home/petalinux/u-boot.bin"
> > > disk =3D [ '/home/petalinux/test.img,raw,xvda' ]
> > >
> > >
> > > Actually I'm working on the idea n. 2. Basically I need to find the
> > > proper u-boot file that's able to boot the image of FreeBSD that I
> > > have installed (13.2 for arm32 bit). Maybe I found it here :
> > >
> > >
> > > http://commondatastorage.googleapis.com/chromeos-localmirror/distfile=
s/nv_uboot-snow-simplefb.kpart.bz2
> > >
> > >
> > > I found that link inside this tutorial :
> > >
> > >
> > > https://wiki.freebsd.org/arm/Chromebook
> > >
> > >
> > > the version of u-boot that has been embedded in that file is the foll=
owing one :
> > >
> > >
> > > # strings nv_uboot-snow-simplefb.kpart | grep U-Boot
> > > U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
> > >
> > >
> > > So the question is easy : I need to find the source code of that old
> > > version of u-boot,because once compiled,it will give me the proper
> > > u-boot.bin kernel / bootloader file that maybe will be able to boot
> > > FreeBSD.
> >
> > Yes, it can boot a 32-bit ARM board. I'm not a FreeBSD person, but
> > I've helped a FreeBSD user booting a 32-bit ARM box with u-boot
> > (GoFlexHome Marvell Kirkwood 6281). The u-boot version was 2017.05. I
> > used an out-of-tree u-boot build. This u-boot executed the ubldr to
> > boot FreeBSD.
> >
> > Please see here:
> > https://forum.doozan.com/read.php?3,49039,82059#msg-82059
> >
> > It's been so long, I don't remember the details. Just to confirm what
> > Heinrich said that u-boot can indeed boot 32-bit FreeBSD, since many
> > years ago.
> >
> > All the best,
> > Tony
> >
> > >
> > >
> > > --
> > > Mario.
>
>
>
> --
> Mario.



--=20
Mario.
