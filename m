Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E7BD1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 12:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4DA88E69;
	Mon, 14 Oct 2024 14:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Y6LaeuRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E273988EE3; Mon, 14 Oct 2024 14:55:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0854788E21
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=34ac=RL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1728910506;
 bh=7nJXbVBCWMVx3JUX1R5nt2fI2V97KwN3ORTjh/ZiroU=;
 b=Y6LaeuRv47zzTL20p0J3BsLgquM5Gzk95gWDopq1/IAlVW5MVzt5UKzl8xFWrYrbIhJJ//h07
 vk9UaADwzP1pYUrpisqgaik1Wi4Rsy6QqnYFB9Ap3UiAPHFugkuCM9yQ+fJiBgWXg8Q0UHXqd9T
 Mi8cKN+J215dULmmf2fYL1lQjykJfLIk0GlkmMnKVlpO1aUSwXo85xepYk4EAxcB7rpoagwI2Nn
 KBvcPpFrcS3+XnwavLOdMes61YWJr0B/Q337vEyUQYAIaxihMbHLJ4Zenuv/jQnH0hKxJO1HAoq
 WNoCWXZbeuPrYBSvv+BtoauEkhu379yrqsWaUFOGbwFw==
Message-ID: <6aa8da3d-4b0e-4660-851b-23026c52953e@kwiboo.se>
Date: Mon, 14 Oct 2024 13:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] rk3588 failed to boot linux
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Andy Yan <andyshrk@163.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, kever.yang@rock-chips.com
References: <20241014094246.2944-1-andyshrk@163.com>
 <CADg8p95OHEmAiVV9HgXeWuqW_CUR0-pvA_WjjCZkT5NFh06sWQ@mail.gmail.com>
 <7e3d21e6.aaab.1928a9e34a7.Coremail.andyshrk@163.com>
 <CADg8p97zZfT82zZCAraY-CyDhE7c88KoOvHZ1kUDj+4L8DHpww@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CADg8p97zZfT82zZCAraY-CyDhE7c88KoOvHZ1kUDj+4L8DHpww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 670cfe400f3927dd268b619d
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

On 2024-10-14 13:00, Sughosh Ganu wrote:
> On Mon, 14 Oct 2024 at 16:12, Andy Yan <andyshrk@163.com> wrote:
>>
>>
>> Hi Suqhosh,
>>
>> At 2024-10-14 18:13:35, "Sughosh Ganu" <sughosh.ganu@linaro.org> wrote:
>>> On Mon, 14 Oct 2024 at 15:12, Andy Yan <andyshrk@163.com> wrote:
>>>>
>>>> When test with current main branch on rk3588 based coolpi 4b,
>>>> the board failed to boot linux os[0]:
>>>> I do the same test on another board that is preparing to send
>>>> patches upstream, and it also failed.
>>>>
>>>> The two boards boots fine with v2024.10.
>>>> With some bisect, it seems that this issue is caused by:
>>>>
>>>> commit 360aaddd9cea8c256f50c576794415cadfb61819
>>>> Merge: 2c832abc732 f8ffc6f3cc4
>>>> Author: Tom Rini <trini@konsulko.com>
>>>> Date:   Tue Sep 3 14:09:30 2024 -0600
>>>>
>>>>     Merge patch series "Make LMB memory map global and persistent"
>>>>
>>>>     Sughosh Ganu <sughosh.ganu@linaro.org> says:
>>>>
>>>> My boards boot fine before this merge on u-boot/next, and all failed
>>>> to boot linux after this merge.
>>>>
>>>> I am not familiar with the LMB mechanism, so i don't know how to find
>>>> the root case now.
>>>>
>>>> I dump the bdinfo for both good case[1] and gegression case[2], not sure
>>>> if they are usefull for debug this issue.
>>>>
>>>> [0] Synchronous Abort when starting kernel:
>>>> Scanning bootdev 'mmc@fe2c0000.bootdev':
>>>> Card did not respond to voltage select! : -110
>>>> Scanning bootdev 'mmc@fe2e0000.bootdev':
>>>>   1  script       ready   mmc          1  mmc@fe2e0000.bootdev.part
>>>> /boot/boot.scr
>>>> ** Booting bootflow 'mmc@fe2e0000.bootdev.part_1' with script
>>>> Boot script loaded from mmc 0:1
>>>> 224 bytes read in 7 ms (31.3 KiB/s)
>>>> 26510301 bytes read in 97 ms (260.6 MiB/s)
>>>> 32883200 bytes read in 122 ms (257 MiB/s)
>>>> 148323 bytes read in 30 ms (4.7 MiB/s)
>>>> Working FDT set to 12000000
>>>> Trying kaslrseed command... Info: Unknown command can be safely ignored
>>>> since kaslrseed does not apply to all boards.
>>>> Unknown command 'kaslrseed' - try 'help'
>>>> ## Loading init Ramdisk from Legacy Image at 12180000 ...
>>>>    Image Name:   uInitrd
>>>>    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
>>>>    Data Size:    26510237 Bytes = 25.3 MiB
>>>>    Load Address: 00000000
>>>>    Entry Point:  00000000
>>>>    Verifying Checksum ... OK
>>>> ## Flattened Device Tree blob at 12000000
>>>>    Booting using the fdt blob at 0x12000000
>>>> Working FDT set to 12000000
>>>>    Loading Ramdisk to eb58f000, end eced739d ... OK
>>>>    Loading Device Tree to 00000000eb502000, end 00000000eb58efff ... OK
>>>> Working FDT set to eb502000
>>>>
>>>> Starting kernel ...
>>>>
>>>> "Synchronous Abort" handler, esr 0x96000004, far 0x96142b896930b907
>>>> elr: 0000000000a8d3b8 lr : 0000000000a77450 (reloc)
>>>> elr: 00000000effa13b8 lr : 00000000eff8b450
>>>> x0 : 96142b896930b907 x1 : 00000000effab870
>>>> x2 : 0000000000000010 x3 : 00000000edf47310
>>>> x4 : 0000000000000000 x5 : 96142b896930b907
>>>> x6 : 0000000000000007 x7 : 0000000000000004
>>>> x8 : 0000000000000040 x9 : fffffffffffffff0
>>>> x10: 00000000eb526fff x11: 00000000edf3a808
>>>> x12: 0000000000000006 x13: 00000000eb502000
>>>> x14: 00000000ffffffff x15: 00000000ededb588
>>>> x16: 00000000eff68738 x17: 0000000000000000
>>>> x18: 00000000edef4d70 x19: 00000000eceb4040
>>>> x20: 00000000eff14f50 x21: 00000000eceac000
>>>> x22: 00000000effcc000 x23: 0000000000000001
>>>> x24: 0000000000000001 x25: 0000000000200000
>>>> x26: 00000000edf385c0 x27: 00000000eced8000
>>>> x28: 00000000eced9000 x29: 00000000ededb3c0
>>>>
>>>> Code: eb04005f 54000061 52800000 14000006 (386468a3)
>>>> Resetting CPU ...
>>>>
>>>> [1] bdinfo for success boot
>>>> => bdinfo
>>>> boot_params = 0x0000000000000000
>>>> DRAM bank   = 0x0000000000000000
>>>> -> start    = 0x0000000000200000
>>>> -> size     = 0x00000000efe00000
>>>> DRAM bank   = 0x0000000000000001
>>>> -> start    = 0x00000001f0000000
>>>> -> size     = 0x0000000010000000
>>>> flashstart  = 0x0000000000000000
>>>> flashsize   = 0x0000000000000000
>>>> flashoffset = 0x0000000000000000
>>>> baudrate    = 1500000 bps
>>>> relocaddr   = 0x00000000eff14000
>>>> reloc off   = 0x00000000ef514000
>>>> Build       = 64-bit
>>>> current eth = unknown
>>>> eth-1addr   = (not set)
>>>> IP addr     = <NULL>
>>>> fdt_blob    = 0x00000000ededcd80
>>>> new_fdt     = 0x00000000ededcd80
>>>> fdt_size    = 0x0000000000017fa0
>>>> lmb_dump_all:
>>>>  memory.cnt = 0x2 / max = 0x10
>>>>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: 0
>>>>  memory[1]      [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
>>>>  reserved.cnt = 0x2 / max = 0x10
>>>>  reserved[0]    [0xeced8000-0xefffffff], 0x03128000 bytes flags: 0
>>>>  reserved[1]    [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
>>>> devicetree  = separate
>>>> serial addr = 0x00000000feb50000
>>>>  width      = 0x0000000000000004
>>>>  shift      = 0x0000000000000002
>>>>  offset     = 0x0000000000000000
>>>>  clock      = 0x00000000016e3600
>>>> arch_number = 0x0000000000000000
>>>> TLB addr    = 0x00000000efff0000
>>>> irq_sp      = 0x00000000ededcd70
>>>> sp start    = 0x00000000ededcd70
>>>> Early malloc usage: 2440 / 10000
>>>> =>
>>>>
>>>>
>>>> [2] bdinfo for boot failed case;
>>>> => bdinfo
>>>> boot_params = 0x0000000000000000
>>>> DRAM bank   = 0x0000000000000000
>>>> -> start    = 0x0000000000200000
>>>> -> size     = 0x00000000efe00000
>>>> DRAM bank   = 0x0000000000000001
>>>> -> start    = 0x00000001f0000000
>>>> -> size     = 0x0000000010000000
>>>> flashstart  = 0x0000000000000000
>>>> flashsize   = 0x0000000000000000
>>>> flashoffset = 0x0000000000000000
>>>> baudrate    = 1500000 bps
>>>> relocaddr   = 0x00000000eff14000
>>>> reloc off   = 0x00000000ef514000
>>>> Build       = 64-bit
>>>> current eth = unknown
>>>> eth-1addr   = (not set)
>>>> IP addr     = <NULL>
>>>> fdt_blob    = 0x00000000ededc1b0
>>>> lmb_dump_all:
>>>>  memory.count = 0x1
>>>>  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: none
>>>>  reserved.count = 0x1
>>>>  reserved[0]    [0xeced81a0-0xefffffff], 0x03127e60 bytes flags:
>>>> no-overwrite
>>>> devicetree  = separate
>>>> serial addr = 0x00000000feb50000
>>>>  width      = 0x0000000000000004
>>>>  shift      = 0x0000000000000002
>>>>  offset     = 0x0000000000000000
>>>>  clock      = 0x00000000016e3600
>>>> arch_number = 0x0000000000000000
>>>> TLB addr    = 0x00000000efff0000
>>>> irq_sp      = 0x00000000ededc1a0
>>>> sp start    = 0x00000000ededc1a0
>>>> Early malloc usage: 2440 / 10000
>>>
>>> With the LMB series applied, the memory region covered by the DRAM
>>> Bank 1 is not getting added to the LMB memory map. And I suspect that
>>> the scripts are using addresses in the bank 1 to load and boot the
>>> kernel. Can you confirm this ? This seems to be happening because of
>>> the value of gd->ram_top that is being set for the rockchip boards.
>>> Based on a cursory look at arch/arm/mach-rockchip/sdram.c, the value
>>> of gd->ram_top is capped at 0xf0000000 for the rk3588 boards. Can you
>>> confirm if this is indeed the case ? If so, the second DRAM bank will
>>> not get added to the LMB memory map, and consequently you will not be
>>> able to load images to addresses in this bank. To fix this, the value
>>> of gd->ram_top will have to be changed for the rockchip boards to
>>> reflect the presence of memory above 4GB. Another possible solution is
>>> to use addresses in the bank0 for booting the images.
>>
>>
>> According to the bdinfo [1][2],  the board have two bank:
>> DRAM bank   = 0x0000000000000000
>> -> start    = 0x0000000000200000
>> -> size     = 0x00000000efe00000
>> DRAM bank   = 0x0000000000000001
>> -> start    = 0x00000001f0000000
>> -> size     = 0x0000000010000000
>>
>> The Armbian scripts boot linux kernel with command:
>>
>> booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
>> fdt_addr_r=0x12000000
>> kernel_addr_r=0x02000000
>> ramdisk_addr_r=0x12180000
>>
>> It seems that the are all in bank0 ?
> 
> Yes, they all seem to be booting from bank 0. Can you share the
> command that you use for trying to boot these images ? I will try to
> boot on the rockpi-4 that I have with me and see if I hit this issue.
> It will be much easier for me to understand what is happening if I can
> reproduce the issue on my end.

Looks like my prior mail got stuck, trying again.

The issue above is the same that I reported in #u-boot [1] and [2], EFI
and ramdisk (or fdt) memory is overlapping, this has been broken since
next was merged into master.

The ram_top/ram_size or script has nothing to do with it and is working
perfectly fine as is.

The issue is that EFI_LOADER will enable LMB, and because LMB is enabled
images/fdt is moved close to ram_top. EFI has however allocated a pool
in the same area that images/fdt is moved to, so when EFI tries to free
memory before jumping into linux the pool memory has been overwritten
and may cause an illegal free or crash.

The only way to avoid this for now is to disable EFI_LOADER Kconfig
option until Sughoshs EFI/LMB sync series or Simons alternative series
is merged, or possible boot using EFI. Until then having EFI_LOADER
enabled (default) and not booting with EFI may cause this type of crash.

[1] https://libera.irclog.whitequark.org/u-boot/2024-10-03#37092785
[2] https://libera.irclog.whitequark.org/u-boot/2024-10-07#37114863

Regards,
Jonas

> 
> -sughosh
> 
>>
>>
>>>
>>> -sughosh
>>>
>>>> 2.34.1
>>>>

