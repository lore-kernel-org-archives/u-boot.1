Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2891FC5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EF9E80C9C;
	Mon, 24 Aug 2026 14:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rbdu8kICM688; Mon, 24 Aug 2026 14:31:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787581904;
	bh=6xqbtojtOq7Z2V8qUubG/YUELIURnCXtnek4YKVFHmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hLCgsOQNJWr1wjVriYCbnj2O4o0u26awCAqoeiPcTqe99QLrgGUDIcJCtWpEskEcy
	 lt8riuxTq8OfYdyKcXyA3pUNJg8jhnjjcL+kQ/P6WE3Ozp/C8yJ1XpFzVkARecz75Q
	 jMv2CVkAelZzpHQn/H7lg8N7erUy1+IeGIbeDAQsC8yRWlTbwkZvXJ/u6jzVNrhjet
	 OuMrvcLAbOrJa1SwXjL2axwJXc2hKsoVPmInO1l048BzEFoGcMhPgkhyYFjWG2xHzU
	 yQOIblBQg/evfkikQElak04qhtiCEHmCKa/oac3i1sqYG+vFPdlQHpb9KC1wtD1Cw0
	 3w/xFn22yhOKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04F3D80B42;
	Mon, 24 Aug 2026 14:31:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B83941A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41ECA80B42
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhCrS2bnSLhE for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:31:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=D/0NXZ+i
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3618380B34
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:31:39 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTCyw41xVzsx4;
 Mon, 24 Aug 2026 16:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787581896;
 bh=6xqbtojtOq7Z2V8qUubG/YUELIURnCXtnek4YKVFHmA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D/0NXZ+iOuC5HGechue6Kek5nVKKu1LejrZ4LpWmGcSw4E9u96iiPhWxqQazxoFkt
 UdOtI6Wo52yOOGcFnur73rQPIje0opTS9pxw2on4xu2DqV/GKaUiQQ0G48Ah6v81FC
 1KD/U4aPgfFFs8uyJCfgas7NtmPvoO2CRctGw25faG97OzEqAplDyhwdk1Ajl9zUcV
 QpT1xFKZzER0Lxv98elbXMSVXpDGbQqvOosZA4ZeHbLhDHuQybVri82qnLts6UBXBF
 YOqCzbvBclvnBZyQil9E2LE5a5OBnwBcHEMMvWFiE/DnYmPXAxjnwtqLQiKwAm6JRL
 c2jY08v/7H4wg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTCyv2KZJzhsC; Mon, 24 Aug 2026 16:31:35 +0200 (CEST)
Message-ID: <19ba2ba9-57d9-40a5-b75b-69f3a63261d7@0leil.net>
Date: Mon, 24 Aug 2026 16:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
 <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
 <363bae8f-de1b-4e74-b6f9-de35efc7e119@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <363bae8f-de1b-4e74-b6f9-de35efc7e119@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 8/13/26 11:09 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/12/2026 11:49 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
>>> integrated DDR3 and the RK3506B support external memory up to 1 GiB.
>>>
>>> Current memory layout cause issues using compressed kernels or ramdisk
>>> due to the default load addresses being used.
>>>
>>
>> RK3506 is an Aarch32 SoC, and Linux kernels on that architecture are
>> self-decompressing, U-Boot doesn't do anything with compressed kernels.
>> You can see that kernel_comp_addr_r is only ever used in cmd/booti.c
>> which depends on ARM64 to be actually built.
>>
>> I simply recommend getting rid of this variable as it's quite
>> misleading. All other Aarch32 Rockchip SoCs we support don't seem to be
>> setting this variable, so no additional cleanup to do.
>> Same for kernel_comp_size.
> 
> Thanks for looking deeper, I will drop these two in v2.
> 
>>
>>> Change the default load addresses to also work on SoC variants with
>>> limited memory, keep all default addresses in the 0-64 MiB range.
>>>
>>> 			 old		 new
>>>     scriptaddr		5 MiB		2 MiB
>>>     pxefile_addr_r	6 MiB		1 MiB
>>>     kernel_addr_r		32.5 MiB	8 MiB
>>>     kernel_comp_addr_r	128 MiB		48 MiB
>>>     fdt_addr_r		30.5 MiB	4 MiB
>>>     fdtoverlay_addr_r	31.5 MiB	6 MiB
>>>     ramdisk_addr_r	96 MiB		48 MiB
>>
>> That leaves less than 18MiB for an initramfs (don't forget U-Boot proper
>> is located at the end of the DRAM as far as I remember), which is very
>> little.
>>
>> Do we really need 2MiB for the DTB and DTBO? 1MiB ought to be enough for
>> the DTB and I'm sure less than 1MiB ought to be enough per overlay
>> (overlay are loaded and applied one after the other). This should free
>> an additional 2MiB for either the kernel or initramfs.
> 
> Agree, I thought I had seen DTB may need to use a 4 MiB aligned address,
> e.g. for RISC-V, but ARM seem to only need it to be any 64-bit aligned
> address.
> 

8-byte alignment is required by the Device Tree spec, c.f. 
https://devicetree-specification.readthedocs.io/en/latest/chapter5-flattened-format.html#alignment

>>
>> The multi_v5_defconfig and multi_v7_defconfig zImage kernels as built by
>> KernelCI are respectively 7.5 and 11.6MiB as of yesterday, c.f.
>> https://dashboard.kernelci.org/build/maestro%3A6a7b3f4762f33761c0aedc06
>> https://dashboard.kernelci.org/build/maestro%3A6a7b3f6562f33761c0aedc2f
>> So maybe we can reserve a bit less than 40MiB for the kernel? But maybe
>> kernel_addr_r is also used for FIT images which may be much bigger than
>> the size of the kernel alone? The load/entry properties are required for
>> images of type kernel according to the FIT spec so that part isn't
>> something we need to deal with.
> 
> My local Rockchip ARMv7 kernel without loadable module support is now
> around 26M for Image and 9.9M for zImage, it used to be just below 32M
> for Image when I also enabled more debugging options and partial support
> for other SoCs. So support for up to 32M uncompressed would be nice :-)
> 

What's the benefit of using an uncompressed image in your workflow?

> I have made some minor adjustments, see below, that seem to work to boot
> into a minimal initramfs busybox rootfs in my lab.
> 
> Looking closer at ARM kernel booting, I can see that during
> decompression the kernel will be decompressed to close to start of DRAM,
> and if the compressed and decompressed images overlaps the compressed
> image will be copied to end of the target uncompressed image before it
> continues.
> 

See 
https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses. 
"Close to start of DRAM" depends on TEXT_OFFSET of the kernel I think.

> U-Boot also tries to move ramdisk and FDT to end of memory to reduce the
> chance of the kernel decompression to overwrite FDT or ramdisk.
> 

Unless initrd_high and fdt_high are set I believe?

> For my simple zImage + FDT + initramfs.cpio.gz pxe boot setup following
> seem to work.
> 
>    U-Boot 2026.10-rc2-00243-g77aab9b3d743-dirty (Aug 13 2026 - 08:08:37 +0000)
> 
>    Model: Luckfox Lyra Plus
>    SoC:   RK3506
>    DRAM:  64 MiB  (board has 128M, code limits to 64M to emulate)
> 
>    => printenv
>    fdt_addr_r=0x00200000			2 MiB
>    fdtcontroladdr=3d39fa0
>    fdtfile=rockchip/rk3506-luckfox-lyra-plus.dtb
>    fdtoverlay_addr_r=0x00300000		3 MiB
>    kernel_addr_r=0x00400000		4 MiB
>    loadaddr=0x200000			2 MiB
>    pxefile_addr_r=0x00100000		1 MiB
>    ramdisk_addr_r=0x02400000		36 MiB
>    scriptaddr=0x00180000			1.5 MiB
>    
>    CONFIG_SYS_MALLOC_LEN=0x200000	2 MiB
>    CONFIG_SYS_BOOTM_LEN=0x2000000	32 MiB
>    CONFIG_SYS_LOAD_ADDR=0x200000		2 MiB
>    CONFIG_STACK_SIZE=0x100000		1 MiB
> 
>    => meminfo
>    DRAM:  64 MiB
> 
>    Region                Base          Size           End           Gap
>    --------------------------------------------------------------------
>    code               3f63000         8c6fc       3fef6fc
>    malloc             3d44000        21f000       3f63000             0
>    board_info         3d43fc0            34       3d43ff4             c
>    global_data        3d43e80           138       3d43fb8             8
>    devicetree         3d39fa0          9ec8       3d43e68            18
>    stack              3c39f80        100000       3d39f80            20
>    lmb                3c39f80             0       3c39f80             0
>    lmb                3c36000          3f80       3c39f80             0
>    free                     0       3c36000       3c36000             0
> 
>    Retrieving file: pxelinux.cfg/default-arm-rk3506
>    Load address: 0x100000
>    Bytes transferred = 192 (c0 hex)
>    
>    Retrieving file: /armhf/zImage
>    Load address: 0x400000
>    Bytes transferred = 10318920 (9d7448 hex)
>    
>    Retrieving file: /armhf/initramfs.cpio.gz
>    Load address: 0x2400000
>    Bytes transferred = 1756164 (1acc04 hex)
>    
>    Retrieving file: /armhf/rockchip/rk3506-luckfox-lyra-plus.dtb
>    Load address: 0x200000
>    Bytes transferred = 31752 (7c08 hex)
>    
>    Kernel image @ 0x400000 [ 0x000000 - 0x9d7448 ]
>    ## Flattened Device Tree blob at 00200000
>       Booting using the fdt blob at 0x200000
>    Working FDT set to 200000
>       Loading Ramdisk to 03a53000, end 03bffc04 ... OK
>       Loading Device Tree to 03c03000, end 03c0dc07 ... OK
>    Working FDT set to 3c03000
>    
>    Starting kernel ...
>    
>    [    0.000000] Booting Linux on physical CPU 0xf00
>    [    0.000000] Linux version 7.2.0-rc6-next-20260803 ...
>    [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
>    [    0.000000] CPU: div instructions available: patching division code
>    [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>    [    0.000000] OF: fdt: Machine model: Luckfox Lyra Plus
>    [    0.000000] earlycon: uart8250 MMIO32:0xff0a0000 (options '')
>    [    0.000000] printk: legacy bootconsole [uart8250] enabled
>    [    0.000000] printk: debug: ignoring loglevel setting.
>    [    0.000000] Memory policy: Data cache writealloc
>    [    0.000000] cma: Reserved 4 MiB at 0x03000000
>    [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
>    [    0.000000] Zone ranges:
>    [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000003ffffff]
>    [    0.000000]   HighMem  empty
>    [    0.000000] Movable zone start for each node
>    [    0.000000] Early memory node ranges
>    [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000003ffffff]
>    [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000003ffffff]
> 
>    ~ # free -m
>                total        used        free      shared  buff/cache   available
>    Mem:             39          17          16           4           7          16
>    Swap:             0           0           0
> 
> There is likely other optimizations that can be done, e.g. reduce malloc
> and stack size. I have tried to keep following in mind when choosing above
> load addresses:
> 
> - Avoid first 1 MiB of DRAM for future OPTEE-OS or TF-A use
> - Allow for use of 32 MiB uncompressed kernel image
> - Keep scripts/pxe/fdt/overlays before kernel and ramdisk to allow for
>    a larger ramdisk on boards with more memory
> - Keep kernel load address as close to start of DRAM as possible
> 
>>
>> Have you figured out how to identify the variant of the RK3506 already?
>> Another option is to dynamically modify those variables (if they aren't
>> already part of the environment) based on the size of available DRAM
>> (and/or SoC variant). I don't like the idea too much but that could be a
>> way to stretch the available memory for each binary loaded by U-Boot as
>> much as possible.
> 
> Agree, we correctly identify amount of DRAM so should be possible to add
> code that dynamically adjusts addresses, but I also want to avoid this
> if possible, hence not putting any other address after ramdisk, to allow
> for larger ramdisk on devices with more memory.
> 

Yeah, don't know what to do here. Another option is to have config 
fragments for variants of the SoC and increase/reduce them in that config.

Can you add a comment in the file just above ENV_MEM_LAYOUT_SETTINGS 
that the addresses are chosen to work with <insert name of SoC variants> 
with x MiB of DRAM already packaged in the silicon.

Cheers,
Quentin
