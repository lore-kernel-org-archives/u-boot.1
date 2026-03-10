Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF3FCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843B9839DF;
	Tue, 10 Mar 2026 01:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RRiV7qkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E8883F2A; Tue, 10 Mar 2026 01:52:55 +0100 (CET)
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com
 [220.197.32.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5885D83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36527d285;
 Tue, 10 Mar 2026 08:52:49 +0800 (GMT+08:00)
Message-ID: <57db9124-f8c0-42c5-ae4c-2b0a19813b28@rock-chips.com>
Date: Tue, 10 Mar 2026 08:52:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory
 map
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260309210234.521070-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260309210234.521070-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd53b74c003afkunm10d7bd85170ef42
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRlMVh9MQkodSkIeThhPHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=RRiV7qkfOJnFo61hnROcsQCkS6fkiY0YmUFcod7oqrWihuyTp1z8rondLYxKpTR2nd2Zk0oGhUNtYpIqqKyOhguCLN9s/bEY6ZJrXv4oFmXEWbVJdi0Nx2PybxWUv0hquPv/f59O6Ms2o/F9mMeWJKHLTLHq9ZYCPY5DTRJusGY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xTAl69rcUbtOVJ45TVr/HgZflKzZsC7xXdNvGYmUUG8=;
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


On 2026/3/10 05:02, Jonas Karlman wrote:
> Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
> the initial 32-bit 0-4 GiB addressable range in its memory map,
> something that matches gd->ram_top and current expected memory available
> for use in U-Boot.
>
> The vendor DRAM init blobs add following ddr_mem rk atags [1]:
>
>    4 GiB: [0x0, 0xf0000000) and [0x1f0000000, 0x200000000)
>    8 GiB: [0x0, 0x200000000)
>
> Add the remaining 64-bit 4-8 GiB addressable range, that already is
> reported to OS, to the U-Boot memory map to more correctly describe all
> available and addressable DRAM of RK356x. While at it also add the
> missing UL suffix to the PCIe address range for consistency.
>
> [1] https://gist.github.com/Kwiboo/6d983693c79365b43c330eb3191cbace
>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Update commit message
> - Collect a-b tag
> ---
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index c2b96902d2dd..2b1eafee37c9 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -72,9 +72,15 @@ static struct mm_region rk3568_mem_map[] = {
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>   	}, {
> -		.virt = 0x300000000,
> -		.phys = 0x300000000,
> -		.size = 0x0c0c00000,
> +		.virt = 0x100000000UL,
> +		.phys = 0x100000000UL,
> +		.size = 0x100000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x300000000UL,
> +		.phys = 0x300000000UL,
> +		.size = 0x0c0c00000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
