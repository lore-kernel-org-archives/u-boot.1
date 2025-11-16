Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E21ACEACEF
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 12:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FCF83AAE;
	Sun, 16 Nov 2025 13:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zglzd/hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3176783AB7; Sun, 16 Nov 2025 13:38:08 +0100 (CET)
Received: from mail-m32114.qiye.163.com (mail-m32114.qiye.163.com
 [220.197.32.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1C283AAC
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 13:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29bbf1dde;
 Sun, 16 Nov 2025 20:38:00 +0800 (GMT+08:00)
Message-ID: <b6fb94e9-b714-4c1b-b61e-8f44d2cf541e@rock-chips.com>
Date: Sun, 16 Nov 2025 20:38:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] rockchip: sdram: Add fallback that fixup DRAM gaps
 on RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de
References: <20250802220738.3018910-1-jonas@kwiboo.se>
 <20250802220738.3018910-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250802220738.3018910-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a8cac1bb503afkunm9954fc0f89e397
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0wYVklNT0xKQkxKSE9NQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Zglzd/hB9N4bRdO7ESr4ihk9cdtxj5AiraHjMlmGGdUrk3OYbwnX6rBiLF+3UM83T9vMzXHRiVIJB6+xFVgURXSspEmkqW7ap+MftQmhs4IfaP8Jm9ojxWzrNdKFcFQDK0m9YXgiFOCHuUpOf3qdu1YiVnV61CNQTAazfHtVinY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=euqGQoaV2C1YPxZfW8mmNKEzenKrzqKk9fChe4FnDqg=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/8/3 06:07, Jonas Karlman wrote:
> RK3588 has two known memory gaps when using 16+ GiB DRAM,
> [0x3fc000000, 0x3fc500000) and [0x3fff00000, 0x400000000).
>
> The vendor TPL blob encodes this information in the DDR_MEM tag data
> passed to later boot phases. U-Boot proper will normally use this
> information to configure the DRAM banks.
>
> When a DDR_MEM tag cannot be found the fallback is to use the entire
> range above 4 GiB. Something that will cause issues when OS try to use
> memory from the two known memory gaps.
>
> Add a weak dram init banksize fixup function and implement it for RK3588
> to fix issues observed when trying to RAM boot RK3588 boards with 16+
> GiB DRAM into Linux.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: New patch to fix booting into OS on RK3588 boards with 16+ GiB DRAM
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 27 ++++++++++++++++++++++++++
>   arch/arm/mach-rockchip/sdram.c         |  7 ++++++-
>   2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c01a40020896..719daa7714e3 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -198,6 +198,33 @@ int arch_cpu_init(void)
>   }
>   #endif
>   
> +/*
> + * RK3588 has two known memory gaps when using 16+ GiB DRAM,
> + * [0x3fc000000, 0x3fc500000) and [0x3fff00000, 0x400000000).
> + *
> + * Remove the [0x3fc000000, 0x400000000) range to ensure OS does not
> + * use memory from these gaps when a DDR_MEM tag cannot be found.
> + */
> +
> +#define DRAM_GAP_START		0x3FC000000
> +#define DRAM_GAP_END		0x400000000
> +
> +int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
> +{
> +	size_t ram_top = bd->bi_dram[1].start + bd->bi_dram[1].size;
> +
> +	if (ram_top > DRAM_GAP_START) {
> +		bd->bi_dram[1].size = DRAM_GAP_START - bd->bi_dram[1].start;
> +
> +		if (ram_top > DRAM_GAP_END && CONFIG_NR_DRAM_BANKS > 2) {
> +			bd->bi_dram[2].start = DRAM_GAP_END;
> +			bd->bi_dram[2].size = ram_top - bd->bi_dram[2].start;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>   
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index d560f90e873d..ea0e3621af72 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -289,6 +289,11 @@ static int rockchip_dram_init_banksize(void)
>   }
>   #endif
>   
> +__weak int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
> +{
> +	return 0;
> +}
> +
>   int dram_init_banksize(void)
>   {
>   	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
> @@ -342,7 +347,7 @@ int dram_init_banksize(void)
>   #endif
>   #endif
>   
> -	return 0;
> +	return rockchip_dram_init_banksize_fixup(gd->bd);
>   }
>   
>   u8 rockchip_sdram_type(phys_addr_t reg)

