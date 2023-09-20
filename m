Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5AC04AA9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 16:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4016086AF3;
	Wed, 20 Sep 2023 18:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TSlIgOSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B297586AF3; Wed, 20 Sep 2023 18:01:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808CC86AE6
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695225661; x=1695830461; i=xypron.glpk@gmx.de;
 bh=icILC+hdtDei2med+InneXvNjVZwkjo/XwLy8rCFj/M=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=TSlIgOSaMdibHRJKM1c4eazXochL5koygQJwGV7dHbnb74EfiSwlkINyFmS8eGTbMLL+pkOeYkP
 4pbv9YTt9ygV80ahBXlwX8Rhsrb7VzJPT8JOsDmXhHE+2/QO3J0qCHrhCmcfEnScT1nH6JfBW5Gvs
 ZJCnkHkXfwNEcHWoTrb2x6nCXkzLBGQF5oP7Y4YEzxOyHpXZpR7dN4hCx8/hWHpEmDIIReJZ5MhMj
 R2iqfCEY+f6VnpWKg+opqZccy92fkJpusYPZZu6WijIvMqq0sMQKQMYOtbLvCdFoWLRZ138SxwIeU
 PdH31d1oC+hI3i7zRR/1LAsEhfTzCRwnfwFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1r2IfH2A9K-00OpVi; Wed, 20
 Sep 2023 18:01:01 +0200
Message-ID: <77e477a1-e880-4954-b7de-a71b53fa16a6@gmx.de>
Date: Wed, 20 Sep 2023 18:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] sandbox_defconfig u-boot -T crashes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:niq3HifVsbF0Tq1rLrfsul66yNqe604bNhEwS0DrFGnDAiKj9a7
 UH1a7KlvZ+VyelOrWMNwC/34R12gFojQJqJkypjzLwjhQD9rpULV//YtNu7P2TeB8HP+h6I
 RBOkvN39cSwKR6f5yk1Ti3jo5zOBI+bLBZDtTXbNaFFmbLmaD04BtyP+mK82OE7tBcgkV6x
 AfM2RRVwXI63FOwQ3U3dA==
UI-OutboundReport: notjunk:1;M01:P0:+S+iPBPsor0=;t9Rq7rv+lFw7GxEjXLd/bhHHDJ8
 PdDFaMg2r4wDHw2ZBXNz08K6jjVPKbJbi+/7v63t+kx7VDfgP5Jm+hMJAKk/wYaDc6Mw6r7NE
 R2vFBzwmr229VzYNvVa9jJ1eTmpU86zQ9BRLV1U31RuZSt9mH9b5UtBe/MXTskEzwX2inYcuC
 JTtnVd8L0UNC+fd628JvkXVqK0Nw34G703waRP/cMldtnTKe6I1OBkbgQK984GQiYQU/1GXaw
 lDbNFkc+EJ1NcwyHr3j63PzMN6zQpLj0O3VdHgbvPfBOgeph6nBbbW+a4vs3adF+4Tn9fkJUW
 470QmQvDDblxz6r39Ka9wvbbC3RXkHaXRGZQl5GA6YHj/r/mC9Yted++F9MxPknTRHY0S4U61
 w7hCahRrfAosTabiQrbPJiRzwtYgHQZOqOQJCVpK4/w94OgAaLYT8Msd3NPqrdz6v0JIJ7e6N
 TH9wRsBy4k3ffz/Zbe7IH//h2/NgUUcTG20ZPHjB6um+85jeBnYr2+iEupRjI4nnLioWXE9eZ
 KKbmRoCbJ/4azvV/mkkZzCFRdSEgvuT+2cvlC1eD3TLuaO1qpXn7uiRTfzf9o2iTa5K716+XC
 12FasvwvIL7NSOs/AtR2ecAO1Te/DIu7b3iA50UGcrE13FKzDk+pAV7uE2MY1Oir64cnvjekZ
 GgLQBO06BMd5tPtOiAcYtoosrwMBpJ2QQAfFkRqKj30LM1FpgRNZ7uq8oO7r1vvUH/Uw7GzMb
 fELI+3TNnTn1vNJ4rOEVIkryOZsnkQ3LNp762Qw/C15CgzJyZeKBeP/aIdyzyTRGCnBtNFsjK
 36Fdym2J6Aq4nchUtBi4u5AKHzVcsOEY0kVEXb0+ytTqIi8wNaatc4/qu/9L/VMYCS8g8F9Cm
 z3jBNBmMU61GGmad5LsF17LDXWrW2/WLAWgsH9pRSh45qFoxxDQ+vSxNJQ9AsOHTP9h50WWx6
 yNIGzCnqShlmXf3K7c+EBIYM7LQ=
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

Hello Simon,

I have built sandbox_defconfig using origin/master
(b9b83a86f0e8 ("Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-sh"))
on Ubuntu 23.10.

Running ./u-boot -T leads to a crash:

#9  0x00007ffff7a28189 in __libc_start_main_impl (main=3D0x555555591540
<main>, argc=3D2, argv=3D0x7fffffffd918, init=3D<optimized out>,
fini=3D<optimized out>, rtld_fini=3D<optimized out>,
     stack_end=3D0x7fffffffd908) at ../csu/libc-start.c:360
360     in ../csu/libc-start.c
(gdb)
#8  0x00007ffff7a280d0 in __libc_start_call_main
(main=3Dmain@entry=3D0x555555591540 <main>, argc=3Dargc@entry=3D2,
argv=3Dargv@entry=3D0x7fffffffd918)
     at ../sysdeps/nptl/libc_start_call_main.h:58
58      ../sysdeps/nptl/libc_start_call_main.h: No such file or directory.
(gdb)
#7  0x0000555555591e19 in sandbox_main (argc=3D2, argv=3D0x7fffffffd918) a=
t
arch/sandbox/cpu/start.c:557
557             board_init_r(gd->new_gd, 0);
(gdb)
#6  board_init_r (new_gd=3D<optimized out>, dest_addr=3Ddest_addr@entry=3D=
0)
at common/board_r.c:818
818             if (initcall_run_list(init_sequence_r))
(gdb)
#5  0x00005555555d961e in initcall_run_list
(init_sequence=3D0x5555558e1860 <init_sequence_r>) at include/initcall.h:4=
6
46                      ret =3D (*init_fnc_ptr)();
(gdb)
#4  0x00005555555e695d in stdio_add_devices () at common/stdio.c:332
332                     for (ret =3D
uclass_first_device_check(UCLASS_KEYBOARD, &dev);
(gdb)
#3  0x00005555555f9e4f in uclass_first_device_check (devp=3D<optimized
out>, id=3DUCLASS_KEYBOARD) at drivers/core/uclass.c:644
644             return device_probe(*devp);
(gdb)
#2  0x00005555555f7235 in device_probe (dev=3D0x1ac9c800) at
drivers/core/device.c:583

583                     ret =3D drv->probe(dev);
(gdb)
#1  0x000055555560ae09 in input_stdio_register (dev=3D0x1aead870) at
drivers/input/input.c:674
674             if (!error && strcmp(env_get("stdin"), dev->name) =3D=3D 0=
) {
(gdb)
#0  strcmp (cs=3D0x1 <error: Cannot access memory at address 0x1>,
ct=3D0x1aead879 "ros-ec-keyb", ct@entry=3D0x1aead878 "cros-ec-keyb") at
lib/string.c:217
217                     ret =3D a - b;


env_get("stdin") returns NULL here and should not be used without checking=
.

Best regards

Heinrich
