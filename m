Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F2DC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 03:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B574801F5;
	Wed,  5 Feb 2025 04:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SdeOqkht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409AF806DC; Wed,  5 Feb 2025 04:24:41 +0100 (CET)
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com
 [220.197.31.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2150801F5
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id a314954d;
 Wed, 5 Feb 2025 11:24:34 +0800 (GMT+08:00)
Message-ID: <92021f15-74ac-4d0e-bec4-f8561ffe4d80@rock-chips.com>
Date: Wed, 5 Feb 2025 11:24:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] rockchip: sdram: Ensure ram_base is correct in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
References: <20250130220718.2428421-1-jonas@kwiboo.se>
 <20250130220718.2428421-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250130220718.2428421-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkoaS1ZDGUJCSUxCTEtLH09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d4235c3f03afkunma314954d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6Tgw5TzIKPBRPC0NOEhIr
 FU4wCzlVSlVKTEhDTElOQ0xNS0JOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUhNNwY+
DKIM-Signature: a=rsa-sha256;
 b=SdeOqkhtvBMyJRB13b9Ftx633sThLe92AHB4YZtCv6JB9UsF6TPEZ0mHxYx5IRH/ujx4qGOebyJ8pXmvo+EjJo9AmF5S7Ht90XAnSc53sa0f/m0dmvXMhI6k7VTveWqc4lsUboKcf2cyir2WRTroc8Fwx/EmiLcjaEfeOdEPaB0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YBVg8+6ZAymdAY80AQfPzizsos6TFBwu1BSoscZon8U=;
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
> Most Rockchip SoCs use 0x0 as DRAM base address, however some SoCs use
> 0x60000000 and RK3576 use 0x40000000 as DRAM base address.
>
> CFG_SYS_SDRAM_BASE is defined with correct address for each SoC and
> U-Boot proper use this to set correct gd->ram_base in setup_dest_addr().
>
> SPL never assign any value to gd->ram_base and instead use the default,
> 0x0. Set correct gd->ram_base in dram_init() to ensure its correctness
> in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: New patch
> ---
>   arch/arm/mach-rockchip/sdram.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 4b8b6b9da7c5..f7d32829295c 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -478,6 +478,7 @@ int dram_init(void)
>   		debug("Cannot get DRAM size: %d\n", ret);
>   		return ret;
>   	}
> +	gd->ram_base = ram.base;
>   	gd->ram_size = ram.size;
>   	debug("SDRAM base=%lx, size=%lx\n",
>   	      (unsigned long)ram.base, (unsigned long)ram.size);
