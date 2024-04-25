Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7610AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 08:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C594A88EFD;
	Thu, 25 Apr 2024 10:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UTlDapHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138088F0E; Thu, 25 Apr 2024 10:43:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7155088B21
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 10:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7067=L6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714034575;
 bh=PHYloVNtkJJd6jMwL7S1nPekCzsGII70ZClJaGhXuMc=;
 b=UTlDapHyYwrMEF4JvD5sb5FMpLFKJeYJ5FCLjBcEokDhm1ill6C+P9bQtO+DIscf8HoAK+BHk
 6Oo/73A1uqsBnuxjzi8TvQfbFFocic9kQG7gi3xN68b5neHAXt6dClP4achom8VT6+KJD4jIIFy
 iDLrrHvbjXW+KA1jsNzt0p3YpPDwIS+VL48s2yw4nhJgnMLGUl5JmU5bt2H8H7jQtpiH3lysaA9
 JUMZ11ksjeMumOY5uXvYlxxtoYd9RxgSbJ0dvgdbqJWGW3tk1tYfVYNRertePL8wuyRZj1wmXcK
 NfZPQSvpo8oce+gXPkURyOkmPleYv4NwG/mCtgsYuOzA==
Message-ID: <950a3354-8714-4ffa-88b3-293fd69ff189@kwiboo.se>
Date: Thu, 25 Apr 2024 09:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Quentin Schulz
 <foss+uboot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>, Tom
 Fitzhenry <tom@tom-fitzhenry.me.uk>, Eugen Hristev
 <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>, Elon Zhang
 <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>, Frank
 Wunderlich <frank-w@public-files.de>, Joseph Chen <chenjh@rock-chips.com>,
 Tianling Shen <cnsztl@gmail.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Chris Morgan
 <macromorgan@hotmail.com>
References: <20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com>
 <20240415-rk35xx-dram-atags-v3-1-5bc5475b3c0d@theobroma-systems.com>
 <2dc654c5-2f03-4f69-9e5f-e4ad5091b844@kwiboo.se>
 <efeed0e2-3593-473c-b5b3-e2ceca78ddbd@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <efeed0e2-3593-473c-b5b3-e2ceca78ddbd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 662a05f5a331803e9eebb12c
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

Hi Quentin,

On 2024-04-24 11:11, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/24/24 00:40, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-04-15 16:16, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> [...]
> 
>>> +			if (!(tmp_mem_map->attrs & PTE_BLOCK_NON_SHARE)) {
>>
>> This check does not seem to work because PTE_BLOCK_NON_SHARE evaluates
>> to 0. Because of this the logic to split the 0-8 GiB bank reported on
>> rk3568 is never split in two.
>>
> 
> Oof, that's a bit oversight, thanks for the catch.
> 
> Can you test the following please?
> 
> """
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 5b1ff1e5495..0492f9b9f41 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -196,7 +196,23 @@ static int rockchip_dram_init_banksize(void)
>   			const phys_size_t rsrv_size = tmp_mem_map->size;
>   			const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
> 
> -			if (!(tmp_mem_map->attrs & PTE_BLOCK_NON_SHARE)) {
> +			/*
> +			 * DRAM memories are expected by Arm to be marked as
> +			 * Normal Write-back cacheable, Inner shareable[1], so
> +			 * let's filter on that to put holes in non-DRAM areas.
> +			 *
> +			 * [1] 
> https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
> +			 */
> +			const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +				PTE_BLOCK_INNER_SHARE;
> +			/*
> +			 * (AttrIndx | SH) in Lower Attributes of Block
> +			 * Descriptor[2].
> +			 * [2] 
> https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
> +			 */
> +			const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
> +
> +			if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
>   				tmp_mem_map++;
>   				continue;
>   			}
> """
> 
> The DRAM mem_map entry for Rockchip devices seems to have those 
> attributes and no other non-DRAM entry seems to have 
> PTE_BLOCK_MEMTYPE(MT_NORMAL).
> 
> We may have an issue in the future if we also want to mark SRAM, ROM or 
> flash 
> (https://developer.arm.com/documentation/102376/0200/Normal-memory 
> because it's likely those would also match the same attributes but we 
> would need to put holes for those so that they aren't thought to be 
> DRAM, but I guess we can tackle this the day this happens :)
> 
> Thanks again for the catch, let me know if this helps and makes sense 
> and I'll send a v4 for it.

I think this makes sense and seem to work on at least two of my RK356x
8GB boards using the generic-rk3568 target.

U-Boot:

  => bdinfo
  boot_params = 0x0000000000000000
  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0x00000000efe00000
  DRAM bank   = 0x0000000000000001
  -> start    = 0x0000000100000000
  -> size     = 0x0000000100000000
  flashstart  = 0x0000000000000000
  flashsize   = 0x0000000000000000
  flashoffset = 0x0000000000000000
  baudrate    = 1500000 bps
  relocaddr   = 0x00000000eff3a000
  reloc off   = 0x00000000ef53a000
  Build       = 64-bit
  fdt_blob    = 0x00000000edf0b390
  new_fdt     = 0x00000000edf0b390
  fdt_size    = 0x000000000000f980
  lmb_dump_all:
   memory.cnt = 0x2 / max = 0x10
   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: 0
   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes flags: 0
   reserved.cnt = 0x2 / max = 0x10
   reserved[0]    [0xecf07000-0xefffffff], 0x030f9000 bytes flags: 0
   reserved[1]    [0x100000000-0x1ffffffff], 0x100000000 bytes flags: 0
  devicetree  = separate
  serial addr = 0x00000000fe660000
   width      = 0x0000000000000004
   shift      = 0x0000000000000002
   offset     = 0x0000000000000000
   clock      = 0x00000000016e3600
  arch_number = 0x0000000000000000
  TLB addr    = 0x00000000efff0000
  irq_sp      = 0x00000000edf0b0c0
  sp start    = 0x00000000edf0b0c0
  Early malloc usage: 2338 / 10000

Linux:

  [    0.000000] Machine model: Generic RK3566/RK3568
  [    0.000000] efi: UEFI not found.
  [    0.000000] NUMA: No NUMA configuration found
  [    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x00000001ffffffff]
  [    0.000000] NUMA: NODE_DATA [mem 0x1ff0389c0-0x1ff03afff]
  [    0.000000] Zone ranges:
  [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000ffffffff]
  [    0.000000]   DMA32    empty
  [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
  [    0.000000] Movable zone start for each node
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
  [    0.000000]   node   0: [mem 0x0000000100000000-0x00000001ffffffff]
  [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000001ffffffff]
  [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
  [    0.000000] cma: Reserved 32 MiB at 0x00000000ee000000 on node -1

Regards,
Jonas

> 
> Cheers,
> Quentin

