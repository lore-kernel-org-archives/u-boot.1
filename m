Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B661AC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CB387932;
	Mon, 23 Oct 2023 18:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gHOVCDlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 106D686FA6; Mon, 23 Oct 2023 18:53:26 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A38187073
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stacey.pellegrino@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507a0907896so5228532e87.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698080002; x=1698684802; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/Cpp0sIZSQpH0nESObanBe2mQPFLMRYGXLa4h3Tfgo=;
 b=gHOVCDloCcUwYLTBWgqDSng4s1t+yAul2Gbu4DvB2z4AbIlWWxRcMYWvU7pOZNotr1
 Pgq5TAZzRKGyXO6J83Ws+XbqOWNtsjvlHlecBRiUu1lRd4vQ/0L3jJM+Wl2V+N7cYOva
 L2thPABxRNGY4+VpS5LXdtAOoOf7fLkVmPcrdwImuEqjPaCNrczXg3wZOGsIoi8zdUKq
 0HL+r4SF9H8MLHLdWlcDInmVUwQH2b3/PCz+qQDsa1VOV3GfPE86M2FnDjt2MHj4+Qia
 TX3W0VxRuO0coQIDWq0o/4HYJ9p76iEO2cAMY2PrAAZoel6LJwknDtN8uWYRrQAK+2uE
 /IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080002; x=1698684802;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/Cpp0sIZSQpH0nESObanBe2mQPFLMRYGXLa4h3Tfgo=;
 b=wjWfJNT8+HjklLl55Hg2x1XkC0TMQ8wAsOMJqn5Py2WX+BLPqRYugdeeF3AHmR8mr6
 Q+o15aWcEKwobuMqedb1i7aWGJ1asKjccrNDMYEpzV0sggzD8tHT1hQZ5MrW3EdEWs4D
 r3yWAeZuxkahe+22QaGInWClg9oAxYhWIoSIsVtPWqlhDu7azoD+3BkAR9l6+NBoBwae
 P8CA2PZW8IwXMGmm/N7TqPI0Hrt7096yeYJK9R4KH5RZ+Qz+uDbKK9HKbhmoj4y/pjLr
 jwi4FTvWCs0sIe8nEv+UPojI1RD+j6uN8sdJ7dpwTVSsxgQpiBuFTnZE58QBJM8SKW0n
 g4Gw==
X-Gm-Message-State: AOJu0YwYgm/drd7PmVViilM3OLHcG0OCcDXnDzMCu2xmjyBYKTlICe6V
 uJltHxEZ+GNEU3ay91XdAht4zVBaVVZVn1gQUKw=
X-Google-Smtp-Source: AGHT+IFPLU3jjs2RevozrVBJvuv6QqgzDm008NnKaEfBoPzdqBoW7MSQWcQLsDdUA4QcyxXMse0N4d8Rm3I0acZL53w=
X-Received: by 2002:a05:6512:ac3:b0:4f9:5426:6622 with SMTP id
 n3-20020a0565120ac300b004f954266622mr8347212lfu.69.1698080001839; Mon, 23 Oct
 2023 09:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKNxVbNWrLrX=rzb4RONo96AtM+G2NKs_2g28WohgCwVkFstSA@mail.gmail.com>
 <20231010-dragonish-harmonica-d28cc5ac811e@ifak-system.com>
 <CAKNxVbO6hso5JqwoNbC2rr8kfhs5cq3BgoE1XvynaxtQQ=L6Bg@mail.gmail.com>
In-Reply-To: <CAKNxVbO6hso5JqwoNbC2rr8kfhs5cq3BgoE1XvynaxtQQ=L6Bg@mail.gmail.com>
From: Stacey Pellegrino <stacey.pellegrino@gmail.com>
Date: Mon, 23 Oct 2023 17:53:09 +0100
Message-ID: <CAKNxVbO5rahc7NoGCRJw6yo1wywNEfMmcFG9O2Z9E4r_gYFxTA@mail.gmail.com>
Subject: Re: ZFS support in custom u-boot build...
To: Stacey Pellegrino <stacey.pellegrino@gmail.com>, u-boot@lists.denx.de,
 zhao_steven@263.net, wanglimei@orange-pi.onaliyun.com
X-Mailman-Approved-At: Mon, 23 Oct 2023 18:53:56 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey (again) Alex,

As a follow up to my previous email (see below) the following has been
achieved...

spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
make distclean*
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
make orangepi_5_plus_defconfig*
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*grep
ZFS .config*
# CONFIG_CMD_ZFS is not set
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
vi .config*
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*grep
ZFS .config*
CONFIG_CMD_ZFS=3Dy

spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
make CROSS_COMPILE=3Daarch64-linux-gnu- all*

...

  CC      cmd/zfs.o
cmd/zfs.c: In function =E2=80=98do_zfs_load=E2=80=99:
cmd/zfs.c:43:14: error: unused variable =E2=80=98buf=E2=80=99 [-Werror=3Dun=
used-variable]
   43 |         char buf[12];
      |              ^~~
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:281: cmd/zfs.o] Error 1
make: *** [Makefile:1307: cmd] Error 2


spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*grep
Werror Makefile*
KBUILD_CFLAGS +=3D -fshort-wchar -Werror
KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Ddate-time)
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
vi Makefile* (remove the -Werror flag)
spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*grep
Werror Makefile*
KBUILD_CFLAGS   +=3D $(call cc-option,-Werror=3Ddate-time)


spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$
*sudo
make CROSS_COMPILE=3Daarch64-linux-gnu- all*

spellegrino@orangepi-build-sys:~/src/orangepi-build/u-boot/v2017.09-rk3588$=
 *ls
-lrt*
total 20348
-rw-rw-r--   1 root root      34 Oct  4 22:13 PREUPLOAD.cfg
-rw-rw-r--   1 root root   14626 Oct  4 22:13 MAINTAINERS
drwxrwxr-x   2 root root    4096 Oct  4 22:13 Licenses
-rw-rw-r--   1 root root   16071 Oct  4 22:13 Kconfig
-rw-rw-r--   1 root root    1863 Oct  4 22:13 Kbuild
drwxrwxr-x   3 root root    4096 Oct  4 22:13 Documentation
-rw-rw-r--   1 root root  187683 Oct  4 22:13 README
drwxrwxr-x   2 root root    4096 Oct  4 22:13 api
drwxrwxr-x  14 root root    4096 Oct  4 22:13 arch
drwxrwxr-x 181 root root    4096 Oct  4 22:13 board
-rw-rw-r--   1 root root    2260 Oct  4 22:13 config.mk
drwxrwxr-x   2 root root   61440 Oct  4 22:13 configs
drwxrwxr-x  10 root root   12288 Oct  4 22:13 doc
drwxrwxr-x   4 root root    4096 Oct  4 22:13 examples
-rwxrwxr-x   1 root root   21097 Oct  4 22:13 make.sh
drwxrwxr-x   5 root root    4096 Oct  4 22:13 post
-rw-rw-r--   1 root root      17 Oct  4 22:13 snapshot.commit
drwxrwxr-x   6 root root    4096 Oct  4 22:13 scripts
drwxr-xr-x   3 root root    4096 Oct 23 15:16 tmp
-rw-r--r--   1 root root   57653 Oct 23 16:01 Makefile.ORIGINAL
-rw-rw-r--   1 root root   57645 Oct 23 16:29 Makefile
drwxrwxr-x  18 root root   12288 Oct 23 16:29 tools
drwxrwxr-x   6 root root   12288 Oct 23 16:29 cmd
drwxrwxr-x   6 root root   12288 Oct 23 16:30 common
drwxrwxr-x   2 root root    4096 Oct 23 16:30 disk
drwxrwxr-x  57 root root    4096 Oct 23 16:30 drivers
drwxrwxr-x   2 root root    4096 Oct 23 16:31 env
drwxrwxr-x  12 root root    4096 Oct 23 16:31 fs
drwxrwxr-x  15 root root   12288 Oct 23 16:31 lib
drwxrwxr-x   2 root root    4096 Oct 23 16:31 net
drwxrwxr-x  12 root root    4096 Oct 23 16:31 test
-rw-r--r--   1 root root    1304 Oct 23 16:31 u-boot.lds
-rw-r--r--   1 root root  936894 Oct 23 16:31 u-boot.map
-rwxr-xr-x   1 root root 9549784 Oct 23 16:31 u-boot
-rwxr-xr-x   1 root root 3273004 Oct 23 16:31 u-boot.srec
-rwxr-xr-x   1 root root 1138400 Oct 23 16:31 u-boot-nodtb.bin
drwxrwxr-x   2 root root    4096 Oct 23 16:31 dts
-rw-r--r--   1 root root 1150948 Oct 23 16:31 u-boot-dtb.bin
-rw-r--r--   1 root root 1150952 Oct 23 16:31 u-boot.bin
-rw-r--r--   1 root root  365877 Oct 23 16:31 u-boot.sym
-rw-r--r--   1 root root  188951 Oct 23 16:31 System.map
drwxr-xr-x  13 root root    4096 Oct 23 16:32 spl
-rw-r--r--   1 root root 1233408 Oct 23 16:32 u-boot.img
drwxr-xr-x  10 root root    4096 Oct 23 16:32 tpl
-rw-r--r--   1 root root   12548 Oct 23 16:32 u-boot.dtb
-rw-r--r--   1 root root 1233408 Oct 23 16:32 u-boot-dtb.img
drwxrwxr-x  34 root root   20480 Oct 23 16:32 include
-rw-r--r--   1 root root   18126 Oct 23 16:32 u-boot.cfg
-rw-r--r--   1 root root   11596 Oct 23 16:32 u-boot.cfg.configs

So I can now cross-compile. With this directory listing do I just dd
u-boot.bin to the NVMe card? Thank you and kindest regards, -Stacey
Pellegrino


On Mon, 23 Oct 2023 at 15:52, Stacey Pellegrino <stacey.pellegrino@gmail.co=
m>
wrote:

> Hey Alex,
>
> Many thanks for your email response! Updated compilation configuration to
> enable CONFIG_CMD_ZFS with make menuconfig. However, when using the
> build.sh script it tends to overwrite the .config file for the u-boot
> compile in question. Steven (CCed on this email) from Orange Pi is lookin=
g
> into this for me (so I believe)? Upon getting ZFS compiled into u-boot wi=
ll
> then be the options needed to pass for booting a root ZFS partition
> accordingly. All supporting information regarding this would be so much
> appreciated! Kindest regards, -Stacey Pellegrino
>
> On Tue, 10 Oct 2023 at 12:01, Alexander Dahl <ada@thorsis.com> wrote:
>
>> Hello Stacey,
>>
>> Am Thu, Oct 05, 2023 at 11:22:14AM +0100 schrieb Stacey Pellegrino:
>> > To all those of concern,
>> >
>> > I am in need of help regarding building u-boot with ZFS support for th=
e
>> > Orange Pi 5 Plus.
>> >
>> > I have tried working out the following...
>> >
>> >
>> https://github.com/u-boot/u-boot/blob/22ad69b7987eb4b10221330661db4427e4=
0174fb/doc/README.zfs
>> >
>> > The URL link above specifies using the board specific config file, whi=
ch
>> > for the Orange Pi 5 Plus is (so I believe)
>> > orangepi-build/userpatches/config-default.conf.
>> > I therefore edited this file in question with CONFIG_CMD_ZFS=3D"yes" a=
nd
>> > uncommenting the line install_zfs=3D"yes".
>>
>> In that regard this README.zfs is somewhat outdated.  You should set
>> CMD_ZFS through Kconfig instead.  Which means: pick the matching
>> defconfig from configs/ subfolder, then run menuconfig and enable
>> CMD_ZFS, and build that.
>>
>> Not sure if that Orange Pi 5 Plus is already supported by U-Boot
>> mainline already.  From a quick glance at the defconfig filenames I
>> would not know which to pick.
>>
>> > However, it still does not allow me to boot with root ZFS on the NVMe
>> SSD
>> > with the official Orange Pi Debian v12 (Bookwork) ARM image. ZFS does
>> not
>> > seem to be referenced in the custom u-boot source code build output as
>> > well. I followed the build instructions located at the following URL
>> link...
>> >
>> >
>> http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_5_Plus#Compile_=
u-boot
>>
>> Oh you should have told before.  This uses a custom build script not
>> part of U-Boot, probably to call U-Boot build.  Please contact that
>> project on how to change U-Boot config instead.  Or look at their
>> build.sh and figure out how it configures and builds U-Boot.
>>
>> > ...but am I required to apply a patch to the u-boot source for ZFS
>> support?
>> > If so, then that could be my problem. If a patch is required, then how
>> > would I go about applying this accordingly?
>>
>> Although they seem to use an outdated and patched version v2017.09 of
>> u-boot: probably not.  Please try with enabling CMD_ZFS in your U-Boot
>> config first.  It's in the menuconfig, also in v2017.09 already.
>>
>> Greets
>> Alex
>>
>> >
>> > Thank you in advance for help in this matter. Kindest regards, -Stacey
>> > Pellegrino
>>
>
