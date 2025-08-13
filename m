Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33D9C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 07:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3297E82D21;
	Wed, 13 Aug 2025 09:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uu3Fb9hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB929831E0; Wed, 13 Aug 2025 09:59:04 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 031E482CEA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 09:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7e8248b3f1cso775102785a.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755071940; x=1755676740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b8dvmfo3Mj8Q2hJ73pjrNIsMv/7WMFoyM447fMM9jKk=;
 b=Uu3Fb9hfX7fwdPOaH8Dus7G5m3vnYsEtUyoJJS4nqgpeomkNlbUMtKkXjTQxbXcCDA
 E4oprutmfU1lbkTEqBt2PUNVt9eEssPtQAfnlTSroM/BkEyOoLBV5Vpjwu2imMREZ1Us
 iydbagK6hsd81E1vOUhf39VoRKeGNHAlQrZzpSch11LFRlBjDfYDUjA1dMO1QPc0nAQQ
 mFmLGy/TsSvwc8eg8PofN+6vfP8i2KxF0FRa+bdohoBRGWFOH7wMAIcat8TCZJ7SY8D5
 llv+K0S8c6mwAtcdP3AkepPNa2g0M4wkkDwjeqihO0sTNZRVohuY35BtJO6ZkJUG0loT
 S0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755071940; x=1755676740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8dvmfo3Mj8Q2hJ73pjrNIsMv/7WMFoyM447fMM9jKk=;
 b=SEmhhxFRGssRCwz+R5KXEklsYtrmsXBzKh8qL2vBAJFxP5ko3pSOpc5/Wc+nXx0e5r
 DmgDPbBxO0q2zR92/NoWGHcQ+3idZvAK3/p+WFj1CJxuyrUHjCakhvL+TLEyosya27Wr
 oR7JQtwvWWjRJagyOt6vC0EBNE48hrRlw7+zFYW51rhAHdgO5gNj2AAc5xtZ+g1RF3Qs
 14yBLiqCo4eaKxW+hq5UpFe6OrqFsXypVxg2EclUf99FLmgYxtsIiAe2SzAuDrgI0vSK
 mNInALW5hQBOh2hODKvfRmIfom4UFXQk65ouMukrTLBsj+7UFypvNaLlhp835kiVzMzt
 6rvQ==
X-Gm-Message-State: AOJu0YwhSZAQ54VhUcz5tifPePsvO3gu9HpLe4eoZoEeEAG0J/pB3Hzh
 dkMUJgX7vNhArHSeFgrVQTV5uMut3KxCiX8BTcVe/u1qJO76X4H6dTPLE941XYvVW4/x7FapSEC
 CUnkgfJFmJWLBL2Xy5iZ4xHvES+Vo/tseA6LRqDT6urJSbiZsgzt/RqI=
X-Gm-Gg: ASbGnctfBJE7Fv3WUSmdGB3iOg6ccrRimN2AyqJQ3Y3ie6ZbTZtEML1ySplgtE0fR+r
 GV1iMSWqTZbTBKpaly7q3s7y+15Q8sLrNIiTZth4y5fzg5gZS5HP9x9t9Cgm5DS74URU1s5MEBF
 mSkK111F6ISjiKJqbbD2eKT2FLB/XlvUXVagFxRSdHViicbNa6nRrtxjZjV3YjtskKE1g6Ahso1
 l3xStkv
X-Google-Smtp-Source: AGHT+IHmwRkB9EZMGimz+BxN5hOz28AYgsuscntNOTEtz8Yx0NET+XeeWO7d3z8YLbZbzThwtfZ8uV5SVbL/Iapp30U=
X-Received: by 2002:a05:620a:3bc2:b0:7e8:4675:1f98 with SMTP id
 af79cd13be357-7e8652441b4mr236302885a.1.1755071939525; Wed, 13 Aug 2025
 00:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn>
In-Reply-To: <8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 13 Aug 2025 13:28:48 +0530
X-Gm-Features: Ac12FXxdTz40szK5QMNTWMW15FB8qYjIHnlffuKMmsgsowUN3FpsHAFj7uQvRBk
Message-ID: <CADg8p94SHLtb3OcNN4KxppLgLzQc_J5SZMfuvz7n3sM051wztw@mail.gmail.com>
Subject: Re: riscv: v2025.10-rc2 fails on QEMU with "Failed to reserve memory
 for fdt"
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: u-boot@lists.denx.de
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

On Tue, 12 Aug 2025 at 20:47, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
> Hi,
>
> On QEMU 10.0.2 (NixOS unstable), U-Boot v2025.10-rc2 with
> qemu-riscv64_smode_defconfig fails to boot a loaded kernel, with a
> "Failed to reserve memory for fdt" error. Explicitly loading an FDT
> seems to fix this, so this looks like a problem with reusing the boot FDT.
>
> My steps are:
>
> mkdir -p vmshare/extlinux
> echo 'label 0' > vmshare/extlinux/extlinux.conf
> echo '  linux /Image' >> vmshare/extlinux/extlinux.conf
> cp .../Image vmshare/ # Grab a Linux kernel
> qemu-system-riscv64 -m 1G -M virt -nographic -kernel u-boot.bin \
>     -drive file=fat:ro:vmshare,format=raw,read-only=on
>
> Resulting in:
>
> Device 0: 1af4 VirtIO Block Device
>            Type: Hard Disk
>            Capacity: 504.0 MB = 0.4 GB (1032192 x 512)
> ... is now current device
> Scanning virtio 0:1...
> Found /extlinux/extlinux.conf
> Retrieving file: /extlinux/extlinux.conf
> 1:      0
> Retrieving file: /Image
> Moving Image from 0x84000000 to 0x80200000, end=0x81e88000
> ## Flattened Device Tree blob at bee8f640
>   Booting using the fdt blob at 0xbee8f640
> Working FDT set to bee8f640
> Failed to reserve memory for fdt at 0xbee8f640
> FDT creation failed! hanging...### ERROR ### Please RESET the board ###

Looks like the FDT is part of the region reserved for U-boot image
post relocation. That region is marked as no-overwrite, meaning any
other allocation attempt to the region will fail. Please check the
relevant log below. The relevant code is in
boot/image-fdt.c:boot_relocate_fdt(). The code gets exercised because
fdt_high and initrd_high are being set to all ones. This was working
in 2025.07 simply because the function call's return value was not
being checked.

I am not sure why fdt_high and initrd_rd are being set to all ones.
The documentation suggests that this is not a good thing. I removed
this setting of fdt_high from include/configs/qemu-riscv.h, and with
that the platform boots.



Relevant boot log
-----------------------

U-Boot 2025.10-rc2-dirty (Aug 13 2025 - 12:56:52 +0530)

CPU:   riscv
Model: riscv-virtio,qemu
DRAM:  1 GiB
Core:  26 devices, 14 uclasses, devicetree: board
Flash: 32 MiB
Loading Environment from nowhere... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
No USB controllers found
Net:   No ethernet found.

Working FDT set to beeb1ac0
Hit any key to stop autoboot: 0
=> bdin
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000080000000
-> size     = 0x0000000040000000
flashstart  = 0x0000000020000000
flashsize   = 0x0000000002000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x00000000bf6d3000
reloc off   = 0x000000003f4d3000
Build       = 64-bit
current eth = unknown
eth-1addr   = (not set)
IP addr     = <NULL>
fdt_blob    = 0x00000000beeb1ac0
lmb_dump_all:
 memory.count = 0x1
 memory[0]    [0x80000000-0xbfffffff], 0x40000000 bytes, flags: none
 reserved.count = 0x3
 reserved[0]    [0x80000000-0x8001ffff], 0x20000 bytes, flags: no-overwrite
 reserved[1]    [0xbdeae000-0xbdeb0fff], 0x3000 bytes, flags:
no-notify, no-overwrite
 reserved[2]    [0xbdeb1ab0-0xbfffffff], 0x214e550 bytes, flags:
no-overwrite          <----- This is where the FDT resides.


-sughosh

>
> (See bottom for full output including OpenSBI)
>
> The same steps succeeds with U-Boot 2025.07, so this appears to be a
> regression. I haven't yet done a bisection or any (successful)
> debugging, but this check seems to be added in [1].
>
> Sughosh Ganu: This message seems to be added by [1]. Do you have any idea?
>
> Vivian "dramforever" Wang
>
> [1]:
> https://lore.kernel.org/u-boot/20250617104346.1379981-1-sughosh.ganu@linaro.org/
>
>
> Full log output:
>
> OpenSBI v1.5.1
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|____/_____|
>         | |
>         |_|
>
> Platform Name             : riscv-virtio,qemu
> Platform Features         : medeleg
> Platform HART Count       : 1
> Platform IPI Device       : aclint-mswi
> Platform Timer Device     : aclint-mtimer @ 10000000Hz
> Platform Console Device   : uart8250
> Platform HSM Device       : ---
> Platform PMU Device       : ---
> Platform Reboot Device    : syscon-reboot
> Platform Shutdown Device  : syscon-poweroff
> Platform Suspend Device   : ---
> Platform CPPC Device      : ---
> Firmware Base             : 0x80000000
> Firmware Size             : 327 KB
> Firmware RW Offset        : 0x40000
> Firmware RW Size          : 71 KB
> Firmware Heap Offset      : 0x49000
> Firmware Heap Size        : 35 KB (total), 2 KB (reserved), 11 KB (used), 21 KB (free)
> Firmware Scratch Size     : 4096 B (total), 416 B (used), 3680 B (free)
> Runtime SBI Version       : 2.0
>
> Domain0 Name              : root
> Domain0 Boot HART         : 0
> Domain0 HARTs             : 0*
> Domain0 Region00          : 0x0000000000100000-0x0000000000100fff M: (I,R,W) S/U: (R,W)
> Domain0 Region01          : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
> Domain0 Region02          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
> Domain0 Region03          : 0x0000000080040000-0x000000008005ffff M: (R,W) S/U: ()
> Domain0 Region04          : 0x0000000080000000-0x000000008003ffff M: (R,X) S/U: ()
> Domain0 Region05          : 0x000000000c400000-0x000000000c5fffff M: (I,R,W) S/U: (R,W)
> Domain0 Region06          : 0x000000000c000000-0x000000000c3fffff M: (I,R,W) S/U: (R,W)
> Domain0 Region07          : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
> Domain0 Next Address      : 0x0000000080200000
> Domain0 Next Arg1         : 0x00000000bfe00000
> Domain0 Next Mode         : S-mode
> Domain0 SysReset          : yes
> Domain0 SysSuspend        : yes
>
> Boot HART ID              : 0
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.12
> Boot HART Base ISA        : rv64imafdch
> Boot HART ISA Extensions  : sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu
> Boot HART PMP Count       : 16
> Boot HART PMP Granularity : 2 bits
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Info       : 16 (0x0007fff8)
> Boot HART Debug Triggers  : 2 triggers
> Boot HART MIDELEG         : 0x0000000000001666
> Boot HART MEDELEG         : 0x0000000000f0b509
>
>
> U-Boot 2025.10-rc2 (Jan 01 1980 - 00:00:00 +0000)
>
> CPU:   riscv
> Model: riscv-virtio,qemu
> DRAM:  1 GiB
> using memory 0xbee91000-0xbf6b1000 for malloc()
> Core:  27 devices, 14 uclasses, devicetree: board
> Flash: 32 MiB
> Loading Environment from nowhere... OK
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> No USB controllers found
> Net:   No ethernet found.
>
> Working FDT set to bee8f640
> Hit any key to stop autoboot: 0
>
> Device 0: unknown device
>
> Device 0: 1af4 VirtIO Block Device
>             Type: Hard Disk
>             Capacity: 504.0 MB = 0.4 GB (1032192 x 512)
> ... is now current device
> Scanning virtio 0:1...
> Found /extlinux/extlinux.conf
> Retrieving file: /extlinux/extlinux.conf
> 1:      0
> Retrieving file: /Image
> Moving Image from 0x84000000 to 0x80200000, end=0x81e88000
> ## Flattened Device Tree blob at bee8f640
>    Booting using the fdt blob at 0xbee8f640
> Working FDT set to bee8f640
> Failed to reserve memory for fdt at 0xbee8f640
> FDT creation failed! hanging...### ERROR ### Please RESET the board ###
>
