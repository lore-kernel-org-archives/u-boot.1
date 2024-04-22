Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D32C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2AC8834B;
	Mon, 22 Apr 2024 10:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eMZkQqGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CD688353; Mon, 22 Apr 2024 10:33:12 +0200 (CEST)
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com
 [117.135.214.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2147E8833D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eMZkQqGz1DHnVIoFlbnf8zunVrFhIdw599m8MPh8Fq87Bj51dWqy82wyK/L6fe/xpIGJFNfRwiLNJUilicwwB2VuKa94/Y1AE+iUKrd6B5l+qQPRogA8Tx1j9R81AfYXEyT8U14mNvuIMEKDjWd6JRuUoa2NJi9YW9lp9vdzYuA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=aCAVqRZfi//tYzM9IjjRkjHgDbCvQHCFSjNgWKyDWcI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 256D09002D0;
 Mon, 22 Apr 2024 16:32:40 +0800 (CST)
Message-ID: <188fdc09-0401-4598-bfdd-105636f8c168@rock-chips.com>
Date: Mon, 22 Apr 2024 16:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, YouMin Chen <cym@rock-chips.com>,
 =?UTF-8?B?5L2V54G/6Ziz?= <canyang.he@rock-chips.com>,
 =?UTF-8?B?6ZmI5YGl5rSq?= <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com>
 <20240415-rk35xx-dram-atags-v3-1-5bc5475b3c0d@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240415-rk35xx-dram-atags-v3-1-5bc5475b3c0d@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpDGVZOSUhKGklISExCGUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04ef95b903a9kunm256d09002d0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6LRw*QjNOGDpLQy4NLU84
 TBowCQtVSlVKTEpITExPTE1JSk1PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUpKQzcG
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


On 2024/4/15 22:16, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Allow RK3568 and RK3588 based boards to get the RAM bank configuration
> from the ROCKCHIP_TPL stage instead of the current logic. This fixes
> both an issue where 256MB of RAM is blocked for devices with >= 4GB
> of RAM and where memory holes need to be defined for devices with
> more than 16GB of RAM. In the event that neither SoC is used or the
> ROCKCHIP_TPL stage is not used, fall back to existing logic.
>
> The logic handles creating memory holes from reserved memory areas
> defined in mem_map data struct in SoC C files, but only if the DRAM area
> overlaps with one reserved memory area.
>
> Since mem_map data struct is used, it should be rather straightforward
> to add support for other SoCs if needed.
>
> The logic is taken from Rockchip's U-Boot tag linux-5.10-gen-rkr4.1
> (e08e32143dd).
>
> Note that Rockchip's U-Boot/TF-A/OP-TEE modify the ATAGS at runtime as
> well, but the DDR_MEM tag seems to be pretty much stable (though BL31
> seems to be reserving only 1MB for itself at the moment).
>
> u32 for ATAGS is used because it simplifies the pointer arithmetic and
> it's expected that ATAGS are always below the 4GB limit allowed by u32.
>
> Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/sdram.c | 240 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 240 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 0d9a0aef6f5..5b1ff1e5495 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -8,6 +8,7 @@
>   #include <init.h>
>   #include <log.h>
>   #include <ram.h>
> +#include <asm/armv8/mmu.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/sdram.h>
> @@ -35,12 +36,251 @@ struct tos_parameter_t {
>   	s64 reserve[8];
>   };
>   
> +/* Tag size and offset */
> +#define ATAGS_SIZE		SZ_8K
> +#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
> +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
> +#define ATAGS_PHYS_END		(ATAGS_PHYS_BASE + ATAGS_SIZE)
> +
> +/* ATAGS memory structures */
> +
> +enum tag_magic {
> +	ATAG_NONE,
> +	ATAG_CORE = 0x54410001,
> +	ATAG_SERIAL = 0x54410050,
> +	ATAG_DDR_MEM = 0x54410052,
> +	ATAG_MAX = 0x544100ff,
> +};
> +
> +/*
> + * An ATAG contains the following data:
> + *  - header
> + *    u32 size // sizeof(header + tag data) / sizeof(u32)
> + *    u32 magic
> + *  - tag data
> + */
> +
> +struct tag_header {
> +	u32 size;
> +	u32 magic;
> +} __packed;
> +
> +/*
> + * DDR_MEM tag bank is storing data this way:
> + *  - address0
> + *  - address1
> + *  - [...]
> + *  - addressX
> + *  - size0
> + *  - size1
> + *  - [...]
> + *  - sizeX
> + *
> + *  with X being tag_ddr_mem.count - 1.
> + */
> +struct tag_ddr_mem {
> +	u32 count;
> +	u32 version;
> +	u64 bank[20];
> +	u32 flags;
> +	u32 data[2];
> +	u32 hash;
> +} __packed;
> +
> +static u32 js_hash(const void *buf, u32 len)
> +{
> +	u32 i, hash = 0x47C6A7E6;
> +
> +	if (!buf || !len)
> +		return hash;
> +
> +	for (i = 0; i < len; i++)
> +		hash ^= ((hash << 5) + ((const char *)buf)[i] + (hash >> 2));
> +
> +	return hash;
> +}
> +
> +static int rockchip_dram_init_banksize(void)
> +{
> +	const struct tag_header *tag_h = NULL;
> +	u32 *addr = (void *)ATAGS_PHYS_BASE;
> +	struct tag_ddr_mem *ddr_info;
> +	u32 calc_hash;
> +	u8 i, j;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
> +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
> +		return -ENOTSUPP;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> +		return -ENOTSUPP;
> +
> +	/* Find DDR_MEM tag */
> +	while (addr < (u32 *)ATAGS_PHYS_END) {
> +		tag_h = (const struct tag_header *)addr;
> +
> +		if (!tag_h->size) {
> +			debug("End of ATAGS (0-size tag), no DDR_MEM found\n");
> +			return -ENODATA;
> +		}
> +
> +		if (tag_h->magic == ATAG_DDR_MEM)
> +			break;
> +
> +		switch (tag_h->magic) {
> +		case ATAG_NONE:
> +		case ATAG_CORE:
> +		case ATAG_SERIAL ... ATAG_MAX:
> +			addr += tag_h->size;
> +			continue;
> +		default:
> +			debug("Invalid magic (0x%08x) for ATAG at 0x%p\n",
> +			      tag_h->magic, addr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (addr >= (u32 *)ATAGS_PHYS_END ||
> +	    (tag_h && (addr + tag_h->size > (u32 *)ATAGS_PHYS_END))) {
> +		debug("End of ATAGS, no DDR_MEM found\n");
> +		return -ENODATA;
> +	}
> +
> +	/* Data is right after the magic member of the tag_header struct */
> +	ddr_info = (struct tag_ddr_mem *)(&tag_h->magic + 1);
> +	if (!ddr_info->count || ddr_info->count > CONFIG_NR_DRAM_BANKS) {
> +		debug("Too many ATAG banks, got (%d) but max allowed (%d)\n",
> +		      ddr_info->count, CONFIG_NR_DRAM_BANKS);
> +		return -ENOMEM;
> +	}
> +
> +	if (!ddr_info->hash) {
> +		debug("No hash for tag (0x%08x)\n", tag_h->magic);
> +	} else {
> +		calc_hash = js_hash(addr, sizeof(u32) * (tag_h->size - 1));
> +
> +		if (calc_hash != ddr_info->hash) {
> +			debug("Incorrect hash for tag (0x%08x), got (0x%08x) expected (0x%08x)\n",
> +			      tag_h->magic, ddr_info->hash, calc_hash);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * Rockchip guaranteed DDR_MEM is ordered so no need to worry about
> +	 * bi_dram order.
> +	 */
> +	for (i = 0, j = 0; i < ddr_info->count; i++, j++) {
> +		phys_size_t size = ddr_info->bank[(i + ddr_info->count)];
> +		phys_addr_t start_addr = ddr_info->bank[i];
> +		struct mm_region *tmp_mem_map = mem_map;
> +		phys_addr_t end_addr;
> +
> +		/*
> +		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
> +		 * have it, so force this space as reserved.
> +		 */
> +		if (start_addr < SZ_2M) {
> +			size -= SZ_2M - start_addr;
> +			start_addr = SZ_2M;
> +		}
> +
> +		/*
> +		 * Put holes for reserved memory areas from mem_map.
> +		 *
> +		 * Only check for at most one overlap with one reserved memory
> +		 * area.
> +		 */
> +		while (tmp_mem_map->size) {
> +			const phys_addr_t rsrv_start = tmp_mem_map->phys;
> +			const phys_size_t rsrv_size = tmp_mem_map->size;
> +			const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
> +
> +			if (!(tmp_mem_map->attrs & PTE_BLOCK_NON_SHARE)) {
> +				tmp_mem_map++;
> +				continue;
> +			}
> +
> +			/*
> +			 * If the start of the DDR_MEM tag is in a reserved
> +			 * memory area, move start address and resize.
> +			 */
> +			if (start_addr >= rsrv_start && start_addr < rsrv_end) {
> +				if (rsrv_end - start_addr > size) {
> +					debug("Would be negative memory size\n");
> +					return -EINVAL;
> +				}
> +
> +				size -= rsrv_end - start_addr;
> +				start_addr = rsrv_end;
> +				break;
> +			}
> +
> +			if (start_addr < rsrv_start) {
> +				end_addr = start_addr + size;
> +
> +				if (end_addr <= rsrv_start) {
> +					tmp_mem_map++;
> +					continue;
> +				}
> +
> +				/*
> +				 * If the memory area overlaps a reserved memory
> +				 * area with start address outside of reserved
> +				 * memory area and...
> +				 *
> +				 * ... ends in the middle of reserved memory
> +				 * area, resize.
> +				 */
> +				if (end_addr <= rsrv_end) {
> +					size = rsrv_start - start_addr;
> +					break;
> +				}
> +
> +				/*
> +				 * ... ends after the reserved memory area,
> +				 * split the region in two, one for before the
> +				 * reserved memory area and one for after.
> +				 */
> +				gd->bd->bi_dram[j].start = start_addr;
> +				gd->bd->bi_dram[j].size = rsrv_start - start_addr;
> +
> +				j++;
> +
> +				size = end_addr - rsrv_end;
> +				start_addr = rsrv_end;
> +
> +				break;
> +			}
> +		}
> +
> +		if (j > CONFIG_NR_DRAM_BANKS) {
> +			debug("Too many banks, max allowed (%d)\n",
> +			      CONFIG_NR_DRAM_BANKS);
> +			return -ENOMEM;
> +		}
> +
> +		gd->bd->bi_dram[j].start = start_addr;
> +		gd->bd->bi_dram[j].size = size;
> +	}
> +
> +	return 0;
> +}
> +
>   int dram_init_banksize(void)
>   {
>   	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
>   	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
>   
>   #ifdef CONFIG_ARM64
> +	int ret = rockchip_dram_init_banksize();
> +
> +	if (!ret)
> +		return ret;
> +
> +	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
> +	      ret);
> +
>   	/* Reserve 0x200000 for ATF bl31 */
>   	gd->bd->bi_dram[0].start = 0x200000;
>   	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>
