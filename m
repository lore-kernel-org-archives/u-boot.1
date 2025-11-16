Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53215CEACEF
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A9F83A64;
	Sun, 16 Nov 2025 13:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AfwpNGTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3055983A8A; Sun, 16 Nov 2025 13:24:01 +0100 (CET)
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com
 [45.254.49.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BE083942
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 13:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29bbbdf9c;
 Sun, 16 Nov 2025 20:23:53 +0800 (GMT+08:00)
Message-ID: <cbf920ee-6fa8-4e20-a591-eecfbd5ae78a@rock-chips.com>
Date: Sun, 16 Nov 2025 20:23:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588: Map SCMI shared memory area as
 non-cacheable
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20251116014531.2133243-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251116014531.2133243-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a8c9f2ba903afkunm0171ef1f89ae85
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh9JVkNMH0odHUtKGBkaGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=AfwpNGTdaqWcZHWEtwI/LGWevgytoU0BPq590a6cDvFIM2x2SSEiWaGIE3F5lI2nxV8F/fILNMSrv0DIXrF8InHY+4PYbtAI+ocg6TPrQuVU4y2VA9QkfRZvLBFlUMC3nc9x/hgTPYsfeSaB5qZdVlmISdmHCtnhXkI5/ew/qwE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=coUget3XBTNsZVB+sn62C542dwLiKMG2lpNJW5+L3Cg=;
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


On 2025/11/16 09:45, Jonas Karlman wrote:
> The SCMI shared memory area is no longer automatically marked as
> non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
> mmu_set_region_dcache_behaviour() misuse").
>
> This change in behavior cause Rockchip RK3588 boards to fail boot with:
>
>    SoC:   RK3588
>    DRAM:  8 GiB
>    scmi-over-smccc scmi: Channel unexpectedly busy
>    scmi_base_drv scmi-base.0: getting protocol version failed
>    scmi-over-smccc scmi: failed to probe base protocol
>    initcall_run_r(): initcall initr_dm() failed
>    ### ERROR ### Please RESET the board ###
>
> Update the memory mapping on RK3588 to mark the SCMI shared memory area
> as non-cacheable to fix the SCMI shared memory based transport issue
> that prevented RK3588 boards from booting.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c01a40020896..55d2caab4fec 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -63,7 +63,20 @@ static struct mm_region rk3588_mem_map[] = {
>   	{
>   		.virt = 0x0UL,
>   		.phys = 0x0UL,
> -		.size = 0xf0000000UL,
> +		.size = 0x10f000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		/* SCMI shared memory area must be mapped as non-cacheable. */
> +		.virt = 0x10f000UL,
> +		.phys = 0x10f000UL,
> +		.size = 0x1000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x110000UL,
> +		.phys = 0x110000UL,
> +		.size = 0xefef0000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>   			 PTE_BLOCK_INNER_SHARE
>   	}, {
