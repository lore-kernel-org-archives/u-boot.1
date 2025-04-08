Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375EAC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C7D83032;
	Tue,  8 Apr 2025 02:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d2+C4D3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C378307F; Tue,  8 Apr 2025 02:50:54 +0200 (CEST)
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com
 [220.197.32.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA28683028
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbbeaa9;
 Tue, 8 Apr 2025 08:50:45 +0800 (GMT+08:00)
Message-ID: <1a85f4f3-cb4c-4573-a352-14c141859881@rock-chips.com>
Date: Tue, 8 Apr 2025 08:50:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under
 SoC Kconfig symbol
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUJKVksfGkgZQh4aGkseTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e0cf9d03afkunm10fbbeaa9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ME06Egw5ATIDTENCUQhRGCEY
 S0owFDBVSlVKTE9PS0xIT09NSU1OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlMSkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=d2+C4D3mBgoo2fGEow+8YNX3nf3wxQNTf4991W/TKdP+6mWLv0ui4bRcOZRVMX5/UffUugAfbmwBXALbP2/U4h7fs++ZhASLmy8fyX8QOJaJrq2sWwyYpQcphUgug4RksW11IiN6ORdO0pLVvRj+RuA4zbeJtAQ2hp0CmbnP1gg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Ei5azMBGVm2CaW0WJowiCtFYj7GgVM5dQuaPKL9AhVs=;
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
> New Rockchip SoCs will typically require use or an external TPL when
> support for the SoC is added to U-Boot.
>
> Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol to remove a
> future likelihood of a long "default y if" line.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 7d867173fa1d..4a0faba9a67d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -179,6 +179,7 @@ config ROCKCHIP_RK3308
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_COMMON_STACK_ADDR
> +	imply ROCKCHIP_EXTERNAL_TPL
>   	imply ROCKCHIP_OTP
>   	imply SPL_CLK
>   	imply SPL_DM_SEQ_ALIAS
> @@ -341,6 +342,7 @@ config ROCKCHIP_RK3568
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_COMMON_STACK_ADDR
> +	imply ROCKCHIP_EXTERNAL_TPL
>   	imply ROCKCHIP_OTP
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>   	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> @@ -375,6 +377,7 @@ config ROCKCHIP_RK3588
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_COMMON_STACK_ADDR
> +	imply ROCKCHIP_EXTERNAL_TPL
>   	imply ROCKCHIP_OTP
>   	imply SCMI_FIRMWARE
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> @@ -501,7 +504,6 @@ config TPL_ROCKCHIP_COMMON_BOARD
>   
>   config ROCKCHIP_EXTERNAL_TPL
>   	bool "Use external TPL binary"
> -	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
>   	help
>   	  Some Rockchip SoCs require an external TPL to initialize DRAM.
>   	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
