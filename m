Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC7D16243
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 11:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2145D88E8A;
	Mon, 14 Oct 2024 13:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f35QeQJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B324988F24; Mon, 14 Oct 2024 13:32:32 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2432988E69
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9625cfe4dso2719972a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728905549; x=1729510349; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JovAa2yHYen4Rci81rR5VoQWjOQxNCbp2HOHPgTPw9A=;
 b=f35QeQJAFDRJXGOoZzgBFPkLsjfverE1VyI7EBbeVTtexoYFN69BZkQ+GWbaMLIlZu
 VBIa1esAZAClsgWqqHhNDyPY/qSLQJiA6rGy45oEkyXtnKjaMFoL3V9xxgtb0j0zfk47
 B7aWRNTAwhcHQRl5V6ArKntSV1f1p8xRK9RVxuC4pXb70UbgMFHFWMiX9jeZh1HV6ju9
 uOA6N6+AllY2iASL1yWFzUdAAudr6QB39gbv+J6ZzNmmF02MwaVkTUwN0yIsGN0KBD1g
 5cMMtCFfO3wOg4uFD7ytqjxZVg75TGkFfQ2JOzjV+si8BMMPnlN56kKZHcs23ASO0dal
 2vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728905549; x=1729510349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JovAa2yHYen4Rci81rR5VoQWjOQxNCbp2HOHPgTPw9A=;
 b=gLUILRVh8Sf/16bZCiTnhLB8qhrX082EAnFgK/QYMEou+PEM+ZgERsGCBrqgSzGtiC
 k9VLCy+SGqZznnMNjk7dkI+Yd4k6quYsEArAD6ZPEPUHLbbEXNzNPHR6cxmllk1/TeAU
 oHyDCtHU7K1Ej9vpH7u+NZVjZZ8R+sEGPfhW7JWlvJXrxWBKfXboVlEScu1qcqO3nTsG
 Xg169lwu71LpHO3t9FnsTGjYTojR4cv//DVpRrms4vJ6VP6HiCOtsJbH91dXSXdVcaDu
 un3QWSYzTNnSTIHgac66/9I7VX/mWUiULHHPhT/DldJliS/5gTdz4XeiXtcJ6MBTYHCA
 bgvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNxjTGrNHImIASI+CFHw9zA0y3z4dXZ+GQcRTKNayok6vMwe3THkvw9EGEBEhY339udgbkUN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwMoK9uf0xxgn3n4BrTyicl6aTSU3IjMetYwG+omhajl/PB3vC6
 snApwObn2dHZFJ0Ct5YpYpGxCrpu+pASSNme3AXdF5Y2hsGq7MMJkRXGz5ApF5yQABjNmCDbLH7
 gN72YGjc8CtE2UOoenr/O49CEcFt0gsFwu10+GsGke9e78df7
X-Google-Smtp-Source: AGHT+IEL8AYIo7xlXOdrOXWc+psIY0RlXDSqrnuDnQKeCRqhfDhIfb0vgxy1MEDz+ktI4siXu5vvdY/d80ZiLbo9QCs=
X-Received: by 2002:a05:6402:3210:b0:5c5:b6a4:4ac1 with SMTP id
 4fb4d7f45d1cf-5c95ac0d3eamr5072987a12.11.1728905548993; Mon, 14 Oct 2024
 04:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241014094246.2944-1-andyshrk@163.com>
 <CADg8p95OHEmAiVV9HgXeWuqW_CUR0-pvA_WjjCZkT5NFh06sWQ@mail.gmail.com>
 <7e3d21e6.aaab.1928a9e34a7.Coremail.andyshrk@163.com>
 <CADg8p97zZfT82zZCAraY-CyDhE7c88KoOvHZ1kUDj+4L8DHpww@mail.gmail.com>
 <193dd7df.adb1.1928ac0b73e.Coremail.andyshrk@163.com>
In-Reply-To: <193dd7df.adb1.1928ac0b73e.Coremail.andyshrk@163.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 14 Oct 2024 17:02:17 +0530
Message-ID: <CADg8p96xoVTEZbj9vju7cK4dOuPR0fiXh1iivRn8yCODKVPMPQ@mail.gmail.com>
Subject: Re: Re: Re: [Regression] rk3588 failed to boot linux
To: Andy Yan <andyshrk@163.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, kever.yang@rock-chips.com, 
 Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 16:49, Andy Yan <andyshrk@163.com> wrote:
>
>
> Hi Sughosh=EF=BC=8C
>
> At 2024-10-14 19:00:24, "Sughosh Ganu" <sughosh.ganu@linaro.org> wrote:
> >On Mon, 14 Oct 2024 at 16:12, Andy Yan <andyshrk@163.com> wrote:
> >>
> >>
> >> Hi Suqhosh,
> >>
> >> At 2024-10-14 18:13:35, "Sughosh Ganu" <sughosh.ganu@linaro.org> wrote=
:
> >> >On Mon, 14 Oct 2024 at 15:12, Andy Yan <andyshrk@163.com> wrote:
> >> >>
> >> >> When test with current main branch on rk3588 based coolpi 4b,
> >> >> the board failed to boot linux os[0]:
> >> >> I do the same test on another board that is preparing to send
> >> >> patches upstream, and it also failed.
> >> >>
> >> >> The two boards boots fine with v2024.10.
> >> >> With some bisect, it seems that this issue is caused by:
> >> >>
> >> >> commit 360aaddd9cea8c256f50c576794415cadfb61819
> >> >> Merge: 2c832abc732 f8ffc6f3cc4
> >> >> Author: Tom Rini <trini@konsulko.com>
> >> >> Date:   Tue Sep 3 14:09:30 2024 -0600
> >> >>
> >> >>     Merge patch series "Make LMB memory map global and persistent"
> >> >>
> >> >>     Sughosh Ganu <sughosh.ganu@linaro.org> says:
> >> >>
> >> >> My boards boot fine before this merge on u-boot/next, and all faile=
d
> >> >> to boot linux after this merge.
> >> >>
> >> >> I am not familiar with the LMB mechanism, so i don't know how to fi=
nd
> >> >> the root case now.
> >> >>
> >> >> I dump the bdinfo for both good case[1] and gegression case[2], not=
 sure
> >> >> if they are usefull for debug this issue.
> >> >>
> >> >> [0] Synchronous Abort when starting kernel:
> >> >> Scanning bootdev 'mmc@fe2c0000.bootdev':
> >> >> Card did not respond to voltage select! : -110
> >> >> Scanning bootdev 'mmc@fe2e0000.bootdev':
> >> >>   1  script       ready   mmc          1  mmc@fe2e0000.bootdev.part
> >> >> /boot/boot.scr
> >> >> ** Booting bootflow 'mmc@fe2e0000.bootdev.part_1' with script
> >> >> Boot script loaded from mmc 0:1
> >> >> 224 bytes read in 7 ms (31.3 KiB/s)
> >> >> 26510301 bytes read in 97 ms (260.6 MiB/s)
> >> >> 32883200 bytes read in 122 ms (257 MiB/s)
> >> >> 148323 bytes read in 30 ms (4.7 MiB/s)
> >> >> Working FDT set to 12000000
> >> >> Trying kaslrseed command... Info: Unknown command can be safely ign=
ored
> >> >> since kaslrseed does not apply to all boards.
> >> >> Unknown command 'kaslrseed' - try 'help'
> >> >> ## Loading init Ramdisk from Legacy Image at 12180000 ...
> >> >>    Image Name:   uInitrd
> >> >>    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
> >> >>    Data Size:    26510237 Bytes =3D 25.3 MiB
> >> >>    Load Address: 00000000
> >> >>    Entry Point:  00000000
> >> >>    Verifying Checksum ... OK
> >> >> ## Flattened Device Tree blob at 12000000
> >> >>    Booting using the fdt blob at 0x12000000
> >> >> Working FDT set to 12000000
> >> >>    Loading Ramdisk to eb58f000, end eced739d ... OK
> >> >>    Loading Device Tree to 00000000eb502000, end 00000000eb58efff ..=
. OK
> >> >> Working FDT set to eb502000
> >> >>
> >> >> Starting kernel ...
> >> >>
> >> >> "Synchronous Abort" handler, esr 0x96000004, far 0x96142b896930b907
> >> >> elr: 0000000000a8d3b8 lr : 0000000000a77450 (reloc)
> >> >> elr: 00000000effa13b8 lr : 00000000eff8b450
> >> >> x0 : 96142b896930b907 x1 : 00000000effab870
> >> >> x2 : 0000000000000010 x3 : 00000000edf47310
> >> >> x4 : 0000000000000000 x5 : 96142b896930b907
> >> >> x6 : 0000000000000007 x7 : 0000000000000004
> >> >> x8 : 0000000000000040 x9 : fffffffffffffff0
> >> >> x10: 00000000eb526fff x11: 00000000edf3a808
> >> >> x12: 0000000000000006 x13: 00000000eb502000
> >> >> x14: 00000000ffffffff x15: 00000000ededb588
> >> >> x16: 00000000eff68738 x17: 0000000000000000
> >> >> x18: 00000000edef4d70 x19: 00000000eceb4040
> >> >> x20: 00000000eff14f50 x21: 00000000eceac000
> >> >> x22: 00000000effcc000 x23: 0000000000000001
> >> >> x24: 0000000000000001 x25: 0000000000200000
> >> >> x26: 00000000edf385c0 x27: 00000000eced8000
> >> >> x28: 00000000eced9000 x29: 00000000ededb3c0
> >> >>
> >> >> Code: eb04005f 54000061 52800000 14000006 (386468a3)
> >> >> Resetting CPU ...
> >> >>
> >> >> [1] bdinfo for success boot
> >> >> =3D> bdinfo
> >> >> boot_params =3D 0x0000000000000000
> >> >> DRAM bank   =3D 0x0000000000000000
> >> >> -> start    =3D 0x0000000000200000
> >> >> -> size     =3D 0x00000000efe00000
> >> >> DRAM bank   =3D 0x0000000000000001
> >> >> -> start    =3D 0x00000001f0000000
> >> >> -> size     =3D 0x0000000010000000
> >> >> flashstart  =3D 0x0000000000000000
> >> >> flashsize   =3D 0x0000000000000000
> >> >> flashoffset =3D 0x0000000000000000
> >> >> baudrate    =3D 1500000 bps
> >> >> relocaddr   =3D 0x00000000eff14000
> >> >> reloc off   =3D 0x00000000ef514000
> >> >> Build       =3D 64-bit
> >> >> current eth =3D unknown
> >> >> eth-1addr   =3D (not set)
> >> >> IP addr     =3D <NULL>
> >> >> fdt_blob    =3D 0x00000000ededcd80
> >> >> new_fdt     =3D 0x00000000ededcd80
> >> >> fdt_size    =3D 0x0000000000017fa0
> >> >> lmb_dump_all:
> >> >>  memory.cnt =3D 0x2 / max =3D 0x10
> >> >>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: 0
> >> >>  memory[1]      [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: =
0
> >> >>  reserved.cnt =3D 0x2 / max =3D 0x10
> >> >>  reserved[0]    [0xeced8000-0xefffffff], 0x03128000 bytes flags: 0
> >> >>  reserved[1]    [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: =
0
> >> >> devicetree  =3D separate
> >> >> serial addr =3D 0x00000000feb50000
> >> >>  width      =3D 0x0000000000000004
> >> >>  shift      =3D 0x0000000000000002
> >> >>  offset     =3D 0x0000000000000000
> >> >>  clock      =3D 0x00000000016e3600
> >> >> arch_number =3D 0x0000000000000000
> >> >> TLB addr    =3D 0x00000000efff0000
> >> >> irq_sp      =3D 0x00000000ededcd70
> >> >> sp start    =3D 0x00000000ededcd70
> >> >> Early malloc usage: 2440 / 10000
> >> >> =3D>
> >> >>
> >> >>
> >> >> [2] bdinfo for boot failed case;
> >> >> =3D> bdinfo
> >> >> boot_params =3D 0x0000000000000000
> >> >> DRAM bank   =3D 0x0000000000000000
> >> >> -> start    =3D 0x0000000000200000
> >> >> -> size     =3D 0x00000000efe00000
> >> >> DRAM bank   =3D 0x0000000000000001
> >> >> -> start    =3D 0x00000001f0000000
> >> >> -> size     =3D 0x0000000010000000
> >> >> flashstart  =3D 0x0000000000000000
> >> >> flashsize   =3D 0x0000000000000000
> >> >> flashoffset =3D 0x0000000000000000
> >> >> baudrate    =3D 1500000 bps
> >> >> relocaddr   =3D 0x00000000eff14000
> >> >> reloc off   =3D 0x00000000ef514000
> >> >> Build       =3D 64-bit
> >> >> current eth =3D unknown
> >> >> eth-1addr   =3D (not set)
> >> >> IP addr     =3D <NULL>
> >> >> fdt_blob    =3D 0x00000000ededc1b0
> >> >> lmb_dump_all:
> >> >>  memory.count =3D 0x1
> >> >>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: none
> >> >>  reserved.count =3D 0x1
> >> >>  reserved[0]    [0xeced81a0-0xefffffff], 0x03127e60 bytes flags:
> >> >> no-overwrite
> >> >> devicetree  =3D separate
> >> >> serial addr =3D 0x00000000feb50000
> >> >>  width      =3D 0x0000000000000004
> >> >>  shift      =3D 0x0000000000000002
> >> >>  offset     =3D 0x0000000000000000
> >> >>  clock      =3D 0x00000000016e3600
> >> >> arch_number =3D 0x0000000000000000
> >> >> TLB addr    =3D 0x00000000efff0000
> >> >> irq_sp      =3D 0x00000000ededc1a0
> >> >> sp start    =3D 0x00000000ededc1a0
> >> >> Early malloc usage: 2440 / 10000
> >> >
> >> >With the LMB series applied, the memory region covered by the DRAM
> >> >Bank 1 is not getting added to the LMB memory map. And I suspect that
> >> >the scripts are using addresses in the bank 1 to load and boot the
> >> >kernel. Can you confirm this ? This seems to be happening because of
> >> >the value of gd->ram_top that is being set for the rockchip boards.
> >> >Based on a cursory look at arch/arm/mach-rockchip/sdram.c, the value
> >> >of gd->ram_top is capped at 0xf0000000 for the rk3588 boards. Can you
> >> >confirm if this is indeed the case ? If so, the second DRAM bank will
> >> >not get added to the LMB memory map, and consequently you will not be
> >> >able to load images to addresses in this bank. To fix this, the value
> >> >of gd->ram_top will have to be changed for the rockchip boards to
> >> >reflect the presence of memory above 4GB. Another possible solution i=
s
> >> >to use addresses in the bank0 for booting the images.
> >>
> >>
> >> According to the bdinfo [1][2],  the board have two bank:
> >> DRAM bank   =3D 0x0000000000000000
> >> -> start    =3D 0x0000000000200000
> >> -> size     =3D 0x00000000efe00000
> >> DRAM bank   =3D 0x0000000000000001
> >> -> start    =3D 0x00000001f0000000
> >> -> size     =3D 0x0000000010000000
> >>
> >> The Armbian scripts boot linux kernel with command:
> >>
> >> booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
> >> fdt_addr_r=3D0x12000000
> >> kernel_addr_r=3D0x02000000
> >> ramdisk_addr_r=3D0x12180000
> >>
> >> It seems that the are all in bank0 ?
> >
> >Yes, they all seem to be booting from bank 0. Can you share the
> >command that you use for trying to boot these images ? I will try to
> The boot scripts is here[3].
>
> U-boot will load the boot script from emmc,  then load dtb, ramdisk,  ker=
nel Image,
> then boot it with booti command, see the boot log before.
>
>
> >boot on the rockpi-4 that I have with me and see if I hit this issue.
> >It will be much easier for me to understand what is happening if I can
> >reproduce the issue on my end.
>
> Thanks for it. I can also help provide more debug information(such as mod=
ify u-boot
> code and add debug log) if you needed it.

Thanks for sharing this. Will try this on my rockpi-4 and get back.
IIRC, Jonas has tried booting linux on other rockchip based boards,
and has been able to do so with the EFI part of the series applied. So
I suspect that this is something specific to the memory layout defined
for this SoC.

-sughosh

>
> [3] https://github.com/armbian/build/blob/main/config/bootscripts/boot-ro=
ckchip64.cmd
>
> >
> >-sughosh
> >
> >>
> >>
> >> >
> >> >-sughosh
> >> >
> >> >> 2.34.1
> >> >>
