Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8E6CD37B7
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 09:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEA3864D7;
	Sat, 16 Sep 2023 11:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU0dxGDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791A186501; Sat, 16 Sep 2023 11:22:10 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C586A864CD
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 11:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59bcd927b45so31861087b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694856126; x=1695460926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9et5Puyw0/8a9z5VkNRyJCr3cchvbazcXMme5oiqjc=;
 b=SU0dxGDFZ3iubT6TTauXh3581ZEFev0EonUZwS1L+vhXC8KjT4abW3qi/WN2daLvD9
 JoLZHIuJeUq7EB/MHlkNmdd1eoFEvw+uyduj86+0JpZvnO4oWFPmIjfQ4Ui0k9GYXgss
 pVkFhjSqlymrtFyI2gJEECyLE6GuFnlxLY1VVF7T1KiYdKzC16Q8JvVZD31giK+57WM5
 hYsjec899tZZ8FwtxkJDYMydEMfvK2j79vTHTaJiA8itaYXnBq5FTHtA3m8Dh5SOMoQY
 Zh32GTgHw5+ByaD2U8szNKXnREeET/8eb6AdabshCABYi731FmWNtyf3KeRqXIVEVHpi
 UkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694856126; x=1695460926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9et5Puyw0/8a9z5VkNRyJCr3cchvbazcXMme5oiqjc=;
 b=Sl6bGMZKSaIx8I6UX6chWsTxHASIsWMcSTjmrC9Solbao4WBBCp/ZV0u1Q7RoE+qZk
 rmW+Je/PDc89QWulnA9CUybMEYPk8GJ1/Bc6wwphbv4AK6BNQBQW0Q9lIDRSNVvqfEaI
 DglBSPYeOpZVP6tPaWKhBz3cj4A1IRGWHfkVhk07PNcwYXF4wmVXT08MymFHWdpvbPcr
 DETguT7lQVQCehWmc2H0qKZLwCSPDKlTBPFaU5+8zGsbAw3Kg/0FaWjYmARsr5jMR4oK
 cqKlWkZ5LDnEv18kA/FTW4UEMHOmPTpZwx1/yd2gp3rf4muG1Z8OWE+gKw151qYjuCMb
 3HHg==
X-Gm-Message-State: AOJu0YzmeBbyZGjoCmsH93B+L1kaSy5+RytzanejyZH3pTUGQQFFdcSu
 YHlWapfF3WQFRWA0mBaY0uA8xCITqxtYxSdQLTY=
X-Google-Smtp-Source: AGHT+IFVmMGaHx3V+0MixO2pRjsZOzDYsKm3I8NCgzq6xeEMT8xt91v7IK89RRuZa6TMda29g0JR+DnUfHnbc3WUgNo=
X-Received: by 2002:a0d:d74e:0:b0:59b:c805:de5d with SMTP id
 z75-20020a0dd74e000000b0059bc805de5dmr4630146ywd.16.1694856126420; Sat, 16
 Sep 2023 02:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
 <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
 <CAC928HYWPCQmrepO=iX+ERqHoBUgH6qCYonjgnT2GLuj=WXvaQ@mail.gmail.com>
 <f05832c5-e50a-cf42-d59b-01b32bcfdc90@kwiboo.se>
In-Reply-To: <f05832c5-e50a-cf42-d59b-01b32bcfdc90@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 16 Sep 2023 11:21:55 +0200
Message-ID: <CAC928HYqQAojyUBEBj+pnK1a59f5bmhieNfEP=KStk67BuOjng@mail.gmail.com>
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

Il giorno mer 6 set 2023 alle ore 09:11 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> Hi Massimo,
>
> On 2023-09-06 07:15, Massimo Pegorer wrote:
> > Hi Jonas,
> >
> > Il giorno lun 4 set 2023 alle ore 18:52 Jonas Karlman
> > <jonas@kwiboo.se> ha scritto:
> >>
> >> Hi Massimo,
> >>
> >> On 2023-09-04 17:05, Massimo Pegorer wrote:
> >>> Hi,
> >>>
> >>> Is there any way for binman to package FIT with U-Boot TF-A and
> >>> OP-TEE, using bl32 binary provided by Rockchip as TEE?
> >>>
> >>> I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> >>> binman failed.
> >>>
> >>> In my poor understanding of Python code, it seems binman accepts only
> >>> ELF format or a binary format starting with optee_v1_header, but
> >>> binaries provided by Rockchip in rkbin repository do not have this
> >>> header.
> >>
> >> One way that I have used/tested before was to create a tee.elf version
> >> using something like:
> >>
> >> $ aarch64-linux-gnu-objcopy -B aarch64 -I binary -O elf64-littleaarch64 xxx_bl32_vX.YZ.bin bl32.o
> >> $ aarch64-linux-gnu-ld bl32.o -T tee.ld -o tee.elf
> >>
> >> tee.ld:
> >> ----
> >> ENTRY(_binary_bl32_bin_start);
> >>
> >> SECTIONS
> >> {
> >>         . = 0x08400000;
> >>         .data : {
> >>                 *(.data)
> >>         }
> >> }
> >> ----
> >
> > Thank you so much! I've been able to load and execute
> > rk3308_bl32_v2.05.bin using 0x00200000 as load address instead of
> > 0x08400000 in the tee.ld. This is the value I found in
> > rkbin/RKTRUST/RK3308TRUST.ini.
> >
> > Everything then goes smooth till kernel panic, but this can depends on
> > kernel build options I suspect (it is just a "random" kernel image I
> > had). I need to investigate more.
> >
> > DDR V2.07 6ede97a868 wesley.yao 22/11/29-19:27:02
> > 08
> > REG2C: 0x00000034, 0x00000034
> > In
> > 589MHz
> > DDR3
> > Col=10 Bank=3 Row=15 Size=512MB
> > OUT: sdram_init finish.
> >
> > U-Boot SPL 2023.10-rc3-00053-ge0b1c90eda (Sep 05 2023 - 19:16:27 +0200)
> > Trying to boot from MMC1
> > INFO:    Preloader serial: 0
> > NOTICE:  BL31: v1.3(release):0252d5c8f
> > NOTICE:  BL31: Built : 07:51:11, Sep 28 2022
> > INFO:    Lastlog: last=0x100000, realtime=0x102000, size=0x2000
> > INFO:    ARM GICv2 driver initialized
> > INFO:    Using opteed sec cpu_context!
> > INFO:    boot cpu mask: 1
> > INFO:    plat_rockchip_pmu_init: pd status 0xe b
> > INFO:    BL31: Initializing runtime services
> > INFO:    BL31: Initializing BL32
> > I/TC:
> > I/TC: OP-TEE version: 3.13.0-651-gd84087907 #hisping.lin (gcc version
> > 10.2.1 20201103 (GNU Toolchain for the A-profile Architecture
> > 10.2-2020.11 (arm-10.16))) #8 Fri Sep 16 16:15:04 CST 2022 aarch64
> > I/TC: Primary CPU initializing
> > I/TC: Primary CPU switching to normal world boot
> > INFO:    BL31: Preparing for EL3 exit to normal world
> > INFO:    Entry point address = 0x600000
> > INFO:    SPSR = 0x3c9
> >
> >
> > U-Boot 2023.10-rc3-00053-ge0b1c90eda (Sep 05 2023 - 19:16:27 +0200)
> >
> > Model: Radxa ROCK Pi S
> > DRAM:  512 MiB (effective 510 MiB)
> > Core:  284 devices, 21 uclasses, devicetree: separate
> > MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> > Loading Environment from nowhere... OK
> > rockchip_dnl_key_pressed read board id failed
> > Net:
> > Error: ethernet@ff4e0000 address not set.
> > No ethernet found.
> >
> > Hit any key to stop autoboot:  0
> > ** Booting bootflow 'mmc@ff480000.bootdev.part_1' with script
> > 4414108 bytes read in 189 ms (22.3 MiB/s)
> > ## Loading kernel from FIT Image at 00680000 ...
> >    Using 'config-1' configuration
> >    Trying 'kernel-1' kernel subimage
> >      Description:  ARM64 OpenWrt Linux-6.1.46
> >      Type:         Kernel Image
> >      Compression:  lzma compressed
> >      Data Start:   0x006800e8
> >      Data Size:    4379870 Bytes = 4.2 MiB
> >      Architecture: AArch64
> >      OS:           Linux
> >      Load Address: 0x03200000
> >      Entry Point:  0x03200000
> >      Hash algo:    crc32
> >      Hash value:   a99f6703
> >      Hash algo:    sha1
> >      Hash value:   642b4e5d4bdab91260c07510ff9d1b13ada03add
> >    Verifying Hash Integrity ... crc32+ sha1+ OK
> > ## Loading fdt from FIT Image at 00680000 ...
> >    Using 'config-1' configuration
> >    Trying 'fdt-1' fdt subimage
> >      Description:  ARM64 OpenWrt radxa_rock-pi-s device tree blob
> >      Type:         Flat Device Tree
> >      Compression:  uncompressed
> >      Data Start:   0x00aad708
> >      Data Size:    32335 Bytes = 31.6 KiB
> >      Architecture: AArch64
> >      Hash algo:    crc32
> >      Hash value:   3d67cbee
> >      Hash algo:    sha1
> >      Hash value:   82c778864784d98ae4150916adac497000e34c6a
> >    Verifying Hash Integrity ... crc32+ sha1+ OK
> >    Booting using the fdt blob at 0xaad708
> > Working FDT set to aad708
> >    Uncompressing Kernel Image
> >    Loading Device Tree to 000000001df25000, end 000000001df2fe4e ... OK
> > Working FDT set to 1df25000
> >
> > Starting kernel ...
> >
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd042]
> > [    0.000000] Linux version 6.1.46 (ubuntu@buildhost)
> > (aarch64-openwrt-linux-musl-gcc (OpenWrt GCC 12.3.0 r23781-426752b38a)
> > 12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP PREEMPT Fri Aug 25
> > 20:22:05 2023
> > [    0.000000] Machine model: Radxa ROCK Pi S
> > [    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff0a0000 (options '')
> > [    0.000000] printk: bootconsole [uart8250] enabled
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000200000-0x000000001fffffff]
> > [    0.000000]   DMA32    empty
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x000000001fffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x000000001fffffff]
> > [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> > [    0.000000] cma: Reserved 6 MiB at 0x000000001f000000
> > [    0.000000] psci: probing for conduit method from DT.
> > [    0.000000] psci: PSCIv1.0 detected in firmware.
> > [    0.000000] psci: Using standard PSCI v0.2 function IDs
> > [    0.000000] psci: Trusted OS migration not required
> > [    0.000000] psci: SMC Calling Convention v1.0
> > [    0.000000] percpu: Embedded 18 pages/cpu s33640 r8192 d31896 u73728
> > [    0.000000] Detected VIPT I-cache on CPU0
> > [    0.000000] alternatives: applying boot alternatives
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128520
> > [    0.000000] Kernel command line: console=ttyS0,1500000 console=tty1
> > earlycon=uart8250,mmio32,0xff0a0000 swiotlb=1
> > root=PARTUUID=5452574f-02 rw rootwait
> > [    0.000000] Dentry cache hash table entries: 65536 (order: 7,
> > 524288 bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144
> > bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Memory: 488852K/522240K available (8896K kernel code,
> > 2402K rwdata, 2692K rodata, 1728K init, 790K bss, 27244K reserved,
> > 6144K cma-reserved)
> > [    0.000000] SError Interrupt on CPU0, code 0x00000000bf000000 -- SError
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.46 #0
> > [    0.000000] Hardware name: Radxa ROCK Pi S (DT)
> > [    0.000000] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.000000] pc : setup_object+0x10/0xb0
> > [    0.000000] lr : new_slab+0x348/0x494
> > [    0.000000] sp : ffff800008d23cf0
> > [    0.000000] x29: ffff800008d23cf0 x28: 0000000003d75a38 x27: 000000001ff5ef58
> > [    0.000000] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000000
> > [    0.000000] x23: 0000000000200000 x22: ffff000000400280 x21: 0000000000000005
> > [    0.000000] x20: fffffc0000010000 x19: ffff800008bc6eb0 x18: 0000000000000000
> > [    0.000000] x17: 00000000ffffffff x16: 0000000000007fff x15: 0000000000000000
> > [    0.000000] x14: 00000000000000c0 x13: 000000000000000a x12: 0000000000000068
> > [    0.000000] x11: ffff800008f63900 x10: 0000000000000068 x9 : 00000000000000c0
> > [    0.000000] x8 : fffffc0000010000 x7 : ffff800017264000 x6 : ffff800008d23a60
> > [    0.000000] x5 : 0000000000000000 x4 : ffff800017264000 x3 : 0000000000000020
> > [    0.000000] x2 : 200240000000ffff x1 : ffff000000400300 x0 : ffff800008bc6eb0
> > [    0.000000] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.46 #0
> > [    0.000000] Hardware name: Radxa ROCK Pi S (DT)
> > [    0.000000] Call trace:
> > [    0.000000]  dump_backtrace.part.0+0xc0/0xd0
> > [    0.000000]  show_stack+0x18/0x30
> > [    0.000000]  dump_stack_lvl+0x64/0x80
> > [    0.000000]  dump_stack+0x18/0x34
> > [    0.000000]  panic+0x154/0x30c
> > [    0.000000]  add_taint+0x0/0xb0
> > [    0.000000]  arm64_serror_panic+0x6c/0x7c
> > [    0.000000]  do_serror+0x34/0x80
> > [    0.000000]  el1h_64_error_handler+0x30/0x4c
> > [    0.000000]  el1h_64_error+0x68/0x6c
> > [    0.000000]  setup_object+0x10/0xb0
> > [    0.000000]  new_slab+0x348/0x494
> > [    0.000000]  __kmem_cache_create+0x278/0x530
> > [    0.000000]  create_boot_cache+0xa0/0xe0
> > [    0.000000]  kmem_cache_init+0x7c/0x180
> > [    0.000000]  start_kernel+0x368/0x548
> > [    0.000000]  __primary_switched+0xbc/0xc4
> >
> >> And then make with TEE=tee.elf, however keep in mind that U-Boot may not
> >> treat the memory region used by OP-TEE properly for aarch64.
> >
> > What do you mean with "treat"?
>
> As vaguely stated, using a rkbin provided TEE-OS blob is not fully
> supported in U-Boot/linux on aarch64. No memory reservation is made so
> U-Boot proper or linux may use part of the memory managed by TEE-OS.

Does it mean that all project / product using TEE are also using a
customized version of U-Boot and not mainline one? Or maybe mainline
U-Boot but with a custom device tree?

> Above crash is probably linux trying to access/use memory that TEE-OS
> owns. For aarch64 only TF-A memory is carved out of the usable memory
> reported to linux.
>
> See https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-rockchip/sdram.c#L43-53
>
> Long time ago I played around with the following patch that abused
> CONFIG_NR_DRAM_BANKS to create a new memory bank. It also expect a load
> address of 0x8400000 so nothing I would recommend you to use today.
>
> https://github.com/Kwiboo/LibreELEC.tv/blob/rk-uboot-mainline/projects/Rockchip/patches/u-boot/0005-rockchip-arm64-reserve-bl32-memory.patch
>
> To solve your linux crash you can add a reserved-memory node to your
> device tree. A proper solution in U-Boot could possible be to add a
> reserved-memory node when TEE-OS is loaded using dt fixup.

Thank you very much for all your hints and suggestions!

I wonder how TEE knows which memory can use. Maybe based on DT? Its
own DT, or is DT passed from SPL to TEE? Unfortunately I've found
OP-TEE docs not so friendly, and being the source code not available
for all platforms does not help. Anyway I need more time to study it.
I would really appreciate any suggestion of interesting documents
about this topic.

> Out of curiosity, any particular reason you want/need to load TEE-OS?

I'm spending some of my spare time to investigate and build up a
little bit of knowledge in this area. And understand if and how OP-TEE
can provide security improvements in system architecture. One simple
service example is managing secrets using protected access to eMMC
RPMB area. In general I would like to have a more clear idea if OP-TEE
(plus on-chip features) can provide TPM-like services with the
security level of an hardware TPM, and which are the limitations pros
an cons versus usage of a TPM external chip. I know something about
fTPM, but I have read just basic information right now.

Thanks once again.
Best regards,
Massimo

>
> Regards,
> Jonas
>
> >
> > Thanks again. Regards,
> > Massimo
> >
> >>
> >> Regards,
> >> Jonas
> >>
> >>>
> >>> Thanks in advance for any hints!
> >>>
> >>> Massimo
> >>
>
