Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD8C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279CF83028;
	Tue,  8 Apr 2025 02:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VwrIGPt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6030583032; Tue,  8 Apr 2025 02:51:29 +0200 (CEST)
Received: from mail-m9386.xmail.ntesmail.com (mail-m9386.xmail.ntesmail.com
 [103.126.93.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A0A82FE9
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd895e;
 Tue, 8 Apr 2025 08:51:21 +0800 (GMT+08:00)
Message-ID: <28ea630d-293c-4a8c-ba2f-5d6b6a36b44d@rock-chips.com>
Date: Tue, 8 Apr 2025 08:51:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] rockchip: Add RK3576 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU0eVh0YSE0aS0weQkoYGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e15d7d03afkunm10fbd895e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6GSo*CzJWMUMPUQg8GFE2
 IS5PFBRVSlVKTE9PS0xIT0NJQ01LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9KT0w3Bg++
DKIM-Signature: a=rsa-sha256;
 b=VwrIGPt4SVQXWcckNFqIYe4n3otj/b+nXvUYwiwxx/KF9zVq4yt5llfEYGIuUNV7CgNhjzp88lmrthcAPwpcN6b5k1GCSYt+d0zl75FB5wMKaMnyduW1cwaIOJ81tq5deIsZrvpGCA0//chzg4uTQCdfLutPrSxu7Q484onREcE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=mijwFR21Ze5T7tztfvsK1Bhe4njvVnrthZPq4T1pFQY=;
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


On 2025/2/21 05:57, Jonas Karlman wrote:
> The Rockchip RK3576 SoC uses a different DRAM base address, 0x40000000,
> compared to prior SoCs.
>
> Add default options that should work when 0x40000000 is used as DRAM
> base address. Use same offsets as before, just below 64 MiB.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
>
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 4a0faba9a67d..62a6d0210b5d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -648,28 +648,34 @@ if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>   
>   config CUSTOM_SYS_INIT_SP_ADDR
>   	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x43f00000 if SPL_TEXT_BASE = 0x40000000
>   	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SYS_MALLOC_F_LEN
>   	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
>   	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_SYS_MALLOC_F_LEN
>   	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
>   	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TPL_SYS_MALLOC_F_LEN
>   	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
>   	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TEXT_BASE
>   	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
>   	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_TEXT_BASE
>   	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
>   			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
>   			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
> +	default 0x40000000 if ROCKCHIP_RK3576
>   	default 0x00000000
>   
>   config SPL_HAS_BSS_LINKER_SECTION
> @@ -677,22 +683,27 @@ config SPL_HAS_BSS_LINKER_SECTION
>   
>   config SPL_BSS_START_ADDR
>   	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
>   	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_BSS_MAX_SIZE
>   	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
>   	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>   
>   config SPL_STACK_R
>   	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
>   	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_ADDR
>   	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x43e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x43f00000
>   	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_MALLOC_SIMPLE_LEN
>   	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x43e00000
>   	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
>   
>   endif
