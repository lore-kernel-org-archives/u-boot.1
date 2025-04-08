Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF4DC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164B98319F;
	Tue,  8 Apr 2025 02:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VaxFrH1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8C783171; Tue,  8 Apr 2025 02:50:07 +0200 (CEST)
Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com
 [101.71.155.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258B483028
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbbe9e7;
 Tue, 8 Apr 2025 08:49:58 +0800 (GMT+08:00)
Message-ID: <0261dbf2-8f9d-4bbe-a2b7-4bb497b3e851@rock-chips.com>
Date: Tue, 8 Apr 2025 08:49:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkNIVkwZGRlNQ00eTUwdSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e01ab703afkunm10fbbe9e7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46DBw5OTICMUMJPhYZSTQd
 IQ0aFDNVSlVKTE9PS0xIT0tLS0xCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9LQ083Bg++
DKIM-Signature: a=rsa-sha256;
 b=VaxFrH1qRQhOntVTpSVLk9SDzNQCO8/ZQvi9w1l2jj3XgRt5/yb5NFrQc+Swo5aAF9CJjbeB8iCCIJBxB8WwOmXjsCu3BYm70J2SZ9qpALnBngtvr3ygAxaI0oa7SLLt7nic2XqJoR1gbrXTaiSl04o+tKt2kRGySp1XrMBq+ow=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=BBvYLKhDiiLe3MZwVwJtGZtcF4oXwtUgxIVV5r2YJTo=;
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


On 2025/2/21 05:56, Jonas Karlman wrote:
> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
> the more common 0x0 DRAM base address used on AArch64 SoCs.
>
> Add default options that should work for these ARMv7 SoCs. Same offsets
> as before are used, just below 64 MiB. Hex values have also been padded
> to improve alignment.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a44fdddd46ab..6c68b3f6a83e 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -639,40 +639,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>   if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>   
>   config CUSTOM_SYS_INIT_SP_ADDR
> -	default 0x3f00000
> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SYS_MALLOC_F_LEN
> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_SYS_MALLOC_F_LEN
> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TPL_SYS_MALLOC_F_LEN
> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TEXT_BASE
> -	default 0x00200000 if ARM64
> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_TEXT_BASE
> -	default 0x0 if ARM64
> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
> +	default 0x00000000
>   
>   config SPL_HAS_BSS_LINKER_SECTION
>   	default y if ARM64
>   
>   config SPL_BSS_START_ADDR
> -	default 0x3f80000
> +	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_BSS_MAX_SIZE
> -	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> +	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>   
>   config SPL_STACK_R
> -	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_ADDR
> -	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_STACK_R_MALLOC_SIMPLE_LEN
> -	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
> +	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
>   
>   endif
>   endif
