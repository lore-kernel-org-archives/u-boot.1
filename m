Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1FAC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 03:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5CA805E2;
	Wed,  5 Feb 2025 04:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jlILu0XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E5880087; Wed,  5 Feb 2025 04:24:39 +0100 (CET)
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com
 [220.197.32.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A894080087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id a3149536;
 Wed, 5 Feb 2025 11:24:29 +0800 (GMT+08:00)
Message-ID: <d7bb3807-0eac-4c74-b249-7678e8db06e1@rock-chips.com>
Date: Wed, 5 Feb 2025 11:24:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] rockchip: sdram: Limit usable ram_top to max 4G
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
References: <20250130220718.2428421-1-jonas@kwiboo.se>
 <20250130220718.2428421-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250130220718.2428421-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhCSlZIGktNQh8fGhhKTUlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d423471503afkunma3149536
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6MCo4LjIWOBROIU0rEhUo
 TBxPCyxVSlVKTEhDTElOQ0xLTUlLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0xNNwY+
DKIM-Signature: a=rsa-sha256;
 b=jlILu0XJN4lVQQA83KXXDJoRtJb/WjlCkZ8imaxGWWqa4mc/k1AVgEp8MVI2dewdE2R5XKc6ZqltEVK0jtKkEmekG/8ie8nm4piF6+gdlTvwM9MtDfH7vUGvMniREqhWLkTs4v/w1e5m7AvtFOmwAYL9dqmoqW7PkwErrHaHSV8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=uzNE3doGaGSdnykz5l3QLAgnE03holaP9ZF6rGhET0o=;
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


On 2025/1/31 06:07, Jonas Karlman wrote:
> U-Boot only works correctly when it uses RAM below the 4G address
> boundary on Rockchip SoCs. Limit usable gd->ram_top to max 4G.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Use u64 to fix 32-bit overflow
> v2: New patch
> ---
>   arch/arm/mach-rockchip/sdram.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 96a791bda2c3..4b8b6b9da7c5 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -487,7 +487,8 @@ int dram_init(void)
>   
>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   {
> -	unsigned long top = CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE;
> +	/* Make sure U-Boot only uses the space below the 4G address boundary */
> +	u64 top = min_t(u64, CFG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE, SZ_4G);
>   
>   	return (gd->ram_top > top) ? top : gd->ram_top;
>   }
