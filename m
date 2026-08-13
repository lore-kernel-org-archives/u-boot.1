Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B29CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 09:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7B2940952;
	Thu, 13 Aug 2026 09:10:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pTKgtR3zk-s; Thu, 13 Aug 2026 09:10:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 001C0404F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786612201;
	bh=6NL32YhmL2oFPG8x5hGePaSYql2dpZ4iZ3+6RzT/f34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0i8Gw7ypFaWsdfrCxEL700qf1iBG6ZxW0lD2zcAeM0QqALN6xNtin2zxXe1KcNeiD
	 B4UQB/OclONsuuUK1UuJBEC+bXJLMiRtRU3Q8BXq+lwRkO77oY8nBHFo+qxW7XulJ1
	 UEyTjN0VVa04ZTXvASiyaBW2Nn+zS8SgOxJbZdWrBolMgAnloau0vnrBUROxdd5ZBY
	 0D54iCTSCI2Edu//zGwqfsKZI0JRZEW85ODE9NzvNR9S6tZmR4UKBnLzLZDWzt6Caw
	 OGutYM40IfuordKxrOS3An8EUVITSOB/mDI1BDlaxVYlKbUI/hbZJNukjhHjqboDtH
	 8phO8/UI9ooBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 001C0404F2;
	Thu, 13 Aug 2026 09:10:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03AA4198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 012C940070
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jW4TWZHeEbf7 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 09:09:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f498=gg=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2FBC940057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FBC940057
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FBC940057
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:09:56 +0000 (UTC)
X-Forward-Email-ID: 6a7d89de6db9354a49710ed4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <363bae8f-de1b-4e74-b6f9-de35efc7e119@kwiboo.se>
Date: Thu, 13 Aug 2026 11:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
 <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786612196;
 bh=6NL32YhmL2oFPG8x5hGePaSYql2dpZ4iZ3+6RzT/f34=;
 b=dCNRxiF1u3EU6Y6SO8Mg8X/ZrMLP2iRg4jBgfGx36tdp7dggJbbiFvr7B/8w5EQU0tZshNoD/
 UMBUf/2WU1PbvFOsRoRF2Z5FomHKEoFUkYcY8cjW+JRcESPOYIogTHDQMqRR0wL44egMS6AjKxS
 LOLX70WKdpSygV+1virJPfgT3AYr+OlogPYYD4VzpLtqO16ThCx8V2wCxfAQDH6iLMB6Xyx9PON
 1e/YaBO7P0KFEWVVqmUtkkzzbWMk4xOCxYyxGApxWrHe09+2YyAoNJ2PSHau+xKvNlHVY3IU7Bb
 8Bvers/0n7E/hdj1TxF4uOZzSGsEF2M9ROyUO6B1iR7Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=dCNRxiF1
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On 8/12/2026 11:49 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
>> integrated DDR3 and the RK3506B support external memory up to 1 GiB.
>>
>> Current memory layout cause issues using compressed kernels or ramdisk
>> due to the default load addresses being used.
>>
> 
> RK3506 is an Aarch32 SoC, and Linux kernels on that architecture are 
> self-decompressing, U-Boot doesn't do anything with compressed kernels. 
> You can see that kernel_comp_addr_r is only ever used in cmd/booti.c 
> which depends on ARM64 to be actually built.
> 
> I simply recommend getting rid of this variable as it's quite 
> misleading. All other Aarch32 Rockchip SoCs we support don't seem to be 
> setting this variable, so no additional cleanup to do.
> Same for kernel_comp_size.

Thanks for looking deeper, I will drop these two in v2.

> 
>> Change the default load addresses to also work on SoC variants with
>> limited memory, keep all default addresses in the 0-64 MiB range.
>>
>> 			 old		 new
>>    scriptaddr		5 MiB		2 MiB
>>    pxefile_addr_r	6 MiB		1 MiB
>>    kernel_addr_r		32.5 MiB	8 MiB
>>    kernel_comp_addr_r	128 MiB		48 MiB
>>    fdt_addr_r		30.5 MiB	4 MiB
>>    fdtoverlay_addr_r	31.5 MiB	6 MiB
>>    ramdisk_addr_r	96 MiB		48 MiB
> 
> That leaves less than 18MiB for an initramfs (don't forget U-Boot proper 
> is located at the end of the DRAM as far as I remember), which is very 
> little.
> 
> Do we really need 2MiB for the DTB and DTBO? 1MiB ought to be enough for 
> the DTB and I'm sure less than 1MiB ought to be enough per overlay 
> (overlay are loaded and applied one after the other). This should free 
> an additional 2MiB for either the kernel or initramfs.

Agree, I thought I had seen DTB may need to use a 4 MiB aligned address,
e.g. for RISC-V, but ARM seem to only need it to be any 64-bit aligned
address.

> 
> The multi_v5_defconfig and multi_v7_defconfig zImage kernels as built by 
> KernelCI are respectively 7.5 and 11.6MiB as of yesterday, c.f. 
> https://dashboard.kernelci.org/build/maestro%3A6a7b3f4762f33761c0aedc06 
> https://dashboard.kernelci.org/build/maestro%3A6a7b3f6562f33761c0aedc2f
> So maybe we can reserve a bit less than 40MiB for the kernel? But maybe 
> kernel_addr_r is also used for FIT images which may be much bigger than 
> the size of the kernel alone? The load/entry properties are required for 
> images of type kernel according to the FIT spec so that part isn't 
> something we need to deal with.

My local Rockchip ARMv7 kernel without loadable module support is now
around 26M for Image and 9.9M for zImage, it used to be just below 32M
for Image when I also enabled more debugging options and partial support
for other SoCs. So support for up to 32M uncompressed would be nice :-)

I have made some minor adjustments, see below, that seem to work to boot
into a minimal initramfs busybox rootfs in my lab.

Looking closer at ARM kernel booting, I can see that during
decompression the kernel will be decompressed to close to start of DRAM,
and if the compressed and decompressed images overlaps the compressed
image will be copied to end of the target uncompressed image before it
continues.

U-Boot also tries to move ramdisk and FDT to end of memory to reduce the
chance of the kernel decompression to overwrite FDT or ramdisk.

For my simple zImage + FDT + initramfs.cpio.gz pxe boot setup following
seem to work.

  U-Boot 2026.10-rc2-00243-g77aab9b3d743-dirty (Aug 13 2026 - 08:08:37 +0000)

  Model: Luckfox Lyra Plus
  SoC:   RK3506
  DRAM:  64 MiB  (board has 128M, code limits to 64M to emulate)

  => printenv
  fdt_addr_r=0x00200000			2 MiB
  fdtcontroladdr=3d39fa0
  fdtfile=rockchip/rk3506-luckfox-lyra-plus.dtb
  fdtoverlay_addr_r=0x00300000		3 MiB
  kernel_addr_r=0x00400000		4 MiB
  loadaddr=0x200000			2 MiB
  pxefile_addr_r=0x00100000		1 MiB
  ramdisk_addr_r=0x02400000		36 MiB
  scriptaddr=0x00180000			1.5 MiB
  
  CONFIG_SYS_MALLOC_LEN=0x200000	2 MiB
  CONFIG_SYS_BOOTM_LEN=0x2000000	32 MiB
  CONFIG_SYS_LOAD_ADDR=0x200000		2 MiB
  CONFIG_STACK_SIZE=0x100000		1 MiB

  => meminfo
  DRAM:  64 MiB

  Region                Base          Size           End           Gap
  --------------------------------------------------------------------
  code               3f63000         8c6fc       3fef6fc
  malloc             3d44000        21f000       3f63000             0
  board_info         3d43fc0            34       3d43ff4             c
  global_data        3d43e80           138       3d43fb8             8
  devicetree         3d39fa0          9ec8       3d43e68            18
  stack              3c39f80        100000       3d39f80            20
  lmb                3c39f80             0       3c39f80             0
  lmb                3c36000          3f80       3c39f80             0
  free                     0       3c36000       3c36000             0

  Retrieving file: pxelinux.cfg/default-arm-rk3506
  Load address: 0x100000
  Bytes transferred = 192 (c0 hex)
  
  Retrieving file: /armhf/zImage
  Load address: 0x400000
  Bytes transferred = 10318920 (9d7448 hex)
  
  Retrieving file: /armhf/initramfs.cpio.gz
  Load address: 0x2400000
  Bytes transferred = 1756164 (1acc04 hex)
  
  Retrieving file: /armhf/rockchip/rk3506-luckfox-lyra-plus.dtb
  Load address: 0x200000
  Bytes transferred = 31752 (7c08 hex)
  
  Kernel image @ 0x400000 [ 0x000000 - 0x9d7448 ]
  ## Flattened Device Tree blob at 00200000
     Booting using the fdt blob at 0x200000
  Working FDT set to 200000
     Loading Ramdisk to 03a53000, end 03bffc04 ... OK
     Loading Device Tree to 03c03000, end 03c0dc07 ... OK
  Working FDT set to 3c03000
  
  Starting kernel ...
  
  [    0.000000] Booting Linux on physical CPU 0xf00
  [    0.000000] Linux version 7.2.0-rc6-next-20260803 ...
  [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
  [    0.000000] CPU: div instructions available: patching division code
  [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  [    0.000000] OF: fdt: Machine model: Luckfox Lyra Plus
  [    0.000000] earlycon: uart8250 MMIO32:0xff0a0000 (options '')
  [    0.000000] printk: legacy bootconsole [uart8250] enabled
  [    0.000000] printk: debug: ignoring loglevel setting.
  [    0.000000] Memory policy: Data cache writealloc
  [    0.000000] cma: Reserved 4 MiB at 0x03000000
  [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
  [    0.000000] Zone ranges:
  [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000003ffffff]
  [    0.000000]   HighMem  empty
  [    0.000000] Movable zone start for each node
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000003ffffff]
  [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000003ffffff]

  ~ # free -m
              total        used        free      shared  buff/cache   available
  Mem:             39          17          16           4           7          16
  Swap:             0           0           0

There is likely other optimizations that can be done, e.g. reduce malloc
and stack size. I have tried to keep following in mind when choosing above
load addresses:

- Avoid first 1 MiB of DRAM for future OPTEE-OS or TF-A use
- Allow for use of 32 MiB uncompressed kernel image
- Keep scripts/pxe/fdt/overlays before kernel and ramdisk to allow for
  a larger ramdisk on boards with more memory
- Keep kernel load address as close to start of DRAM as possible

> 
> Have you figured out how to identify the variant of the RK3506 already? 
> Another option is to dynamically modify those variables (if they aren't 
> already part of the environment) based on the size of available DRAM 
> (and/or SoC variant). I don't like the idea too much but that could be a 
> way to stretch the available memory for each binary loaded by U-Boot as 
> much as possible.

Agree, we correctly identify amount of DRAM so should be possible to add
code that dynamically adjusts addresses, but I also want to avoid this
if possible, hence not putting any other address after ramdisk, to allow
for larger ramdisk on devices with more memory.

Any suggestions on a more production ready memory layout are appreciated,
my use case and testing has mostly been for U-Boot and Linux hacking in
my lab, not any real in the field production use ;-)

Regards,
Jonas

> 
> Cheers,
> Quentin

