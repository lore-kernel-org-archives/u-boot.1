Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C61EA8521
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6409180517;
	Sun,  8 Mar 2026 16:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ReXSbR7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C74838BB; Sun,  8 Mar 2026 16:05:19 +0100 (CET)
Received: from mail-m15591.qiye.163.com (mail-m15591.qiye.163.com
 [101.71.155.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91F780212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36250d4ba;
 Sun, 8 Mar 2026 23:05:10 +0800 (GMT+08:00)
Message-ID: <40b98c82-bd3a-41c5-8570-ecc479455446@rock-chips.com>
Date: Sun, 8 Mar 2026 23:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] rockchip: rk3588: include all addressable DRAM in
 memory map
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260203-rk3588-mem-map-v1-1-04005ea48fe5@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260203-rk3588-mem-map-v1-1-04005ea48fe5@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ccdfb157403afkunm4f82a15c15b9ae4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU4ZVk0fGR9IT0kaTUkZSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=ReXSbR7UzdyUGm7hlod3OuYmgEXM8xh1cBNaAYh3OiVa/breMK759+8j8Hdxq+fo+2nd66Kypc0y2nd72gQRYlQ54vRTqatDUNHmLOuODoDHBe3/T56ibPNKnioRxjr1stTSsjrL9/DTYUEOExW+Av7dWZzx5o/KHXQpEzKxnNo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Li/INCWipr97MI7uarpu+0naYmo8a2swE8VyjMWYI4k=;
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


On 2026/2/3 17:58, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The ATAGS set by Rockchip DDR init blob[1] specify DRAM banks above the
> first addressable 4GiB which we haven't done in the mem_map for RK3588
> yet.
>
> For 4GiB DRAM, the 256MiB missing from the first addressable 4GiB (due
> to MMIO) are accessible at the end of the 8GiB address space. For 8GiB,
> 4-8GiB address space is used for the additional 4GiB and the missing
> 256MiB are at the end of 12GiB address space. For 12, 4-12GiB and the
> missing 256MiB at the end of 20GiB address space. For 16GiB, 4-~16GiB
> with two holes (reasons unknown) around 16GiB and the missing 256MiB is
> at the end of 20GiB address space. For 32GiB, 4-16~GiB with two holes
> and then 16GiB to 32GiB address space (so likely missing 256MiB from
> MMIO address space).
>
> [1] https://gist.github.com/Kwiboo/1c020d37e3adbc9d0d79dc003d921977
>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This is the RK3588 counterpart to RK3568's[1] which is required for
> Marek's patch[2] to not crash RK35xx series of SoCs when booting.
>
> This (plus patch[2]) has been tested on 4, 8 and 16GiB by TFTP'ing a
> kernel and DTB into the various DRAM regions above 4GiB and booting this
> kernel+dtb combination.
>
> Note that I have zero clue as to what this is actually doing as I cannot
> understand where this mem_map is actually used, hence the RFC.
>
> [1] https://lore.kernel.org/u-boot/20260129193153.2232395-1-jonas@kwiboo.se/
> [2] https://lore.kernel.org/u-boot/20260127234856.1503030-1-marek.vasut+renesas@mailbox.org/
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index 55d2caab4fe..438642ca529 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -87,6 +87,24 @@ static struct mm_region rk3588_mem_map[] = {
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>   	},  {
> +		.virt = 0x100000000UL,
> +		.phys = 0x100000000UL,
> +		.size = 0x2fc000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x3fc500000UL,
> +		.phys = 0x3fc500000UL,
> +		.size = 0x3a00000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x400000000UL,
> +		.phys = 0x400000000UL,
> +		.size = 0x400000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
>   		.virt = 0x900000000,
>   		.phys = 0x900000000,
>   		.size = 0x150000000,
>
> ---
> base-commit: 16fcbcb2ee25ea042c1e9cfbc04f7a5554746b64
> change-id: 20260202-rk3588-mem-map-053661aa7e46
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
