Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F038C02182
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 02:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E216780836;
	Fri, 24 Jan 2025 03:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KdAerxrz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A32807F9; Fri, 24 Jan 2025 03:18:06 +0100 (CET)
Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com
 [117.135.214.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37989807F1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 03:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 98d8ffb3;
 Fri, 24 Jan 2025 10:18:00 +0800 (GMT+08:00)
Message-ID: <747470c7-1a72-4b87-9ea7-27602e44ac98@rock-chips.com>
Date: Fri, 24 Jan 2025 10:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: sdram: Fix reserve of 2 MiB at start of DRAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250123220222.3089386-1-jonas@kwiboo.se>
 <20250123220222.3089386-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250123220222.3089386-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE4dVkIfTUhITktCQh8dSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a94961a185c03afkunm98d8ffb3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Kzo6QjIJFiJOUR1JMihN
 GiwwFB1VSlVKTEhMTUNOS0NKTkpDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlJTkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=KdAerxrzGHB73fcPKzL8lCex4aymrVmUo1D3Oyfrf9VwxEWRyk5wfh6QtCXQleEhhRXisu8Np9iNhnt+4bCw/FUvC9xLigHM5CxQGSxkn9ovOq6yjuBQtEtboiKCpkwlnK3Lr6ZtJm9lgWg42P7MPOEXxEle8ELd+koWsvs8e0c=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=+t5iorKBKu4BfnWbAiiJz84iEr1YJAqXApVjYtV3u4k=;
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


On 2025/1/24 06:02, Jonas Karlman wrote:
> Normally 2 MiB at the beginning of DRAM is reserved for TF-A use.
> However, this only works as intended when DRAM starts at 0x0.
>
> When DRAM starts at e.g. 0x40000000 this reservation never happens, and
> U-Boot or Linux may try to read/write into secure memory.
>
> Fix this by taking CFG_SYS_SDRAM_BASE into consideration when reserving
> 2 MiB at start of DRAM.
>
> Also change to use SZ_2M and SZ_32M for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/sdram.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 3d3fc327234f..caca6f917305 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -182,9 +182,9 @@ static int rockchip_dram_init_banksize(void)
>   		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
>   		 * have it, so force this space as reserved.
>   		 */
> -		if (start_addr < SZ_2M) {
> -			size -= SZ_2M - start_addr;
> -			start_addr = SZ_2M;
> +		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
> +			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
> +			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
>   		}
>   
>   		/*
> @@ -302,8 +302,8 @@ int dram_init_banksize(void)
>   	debug("Couldn't use ATAG (%d) to detect DDR layout, falling back...\n",
>   	      ret);
>   
> -	/* Reserve 0x200000 for ATF bl31 */
> -	gd->bd->bi_dram[0].start = 0x200000;
> +	/* Reserve 2M for ATF bl31 */
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE + SZ_2M;
>   	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
>   
>   	/* Add usable memory beyond the blob of space for peripheral near 4GB */
> @@ -332,7 +332,7 @@ int dram_init_banksize(void)
>   		gd->bd->bi_dram[0].size = 0x8400000;
>   		/* Reserve 32M for OPTEE with TA */
>   		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE
> -					+ gd->bd->bi_dram[0].size + 0x2000000;
> +					+ gd->bd->bi_dram[0].size + SZ_32M;
>   		gd->bd->bi_dram[1].size = top - gd->bd->bi_dram[1].start;
>   	}
>   #else
