Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE713D44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3801E89159;
	Wed,  6 Nov 2024 11:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Czi/J8bV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04C0891A9; Wed,  6 Nov 2024 11:43:57 +0100 (CET)
Received: from mail-m127108.qiye.163.com (mail-m127108.qiye.163.com
 [115.236.127.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D850A88D35
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f884348;
 Wed, 6 Nov 2024 18:43:48 +0800 (GMT+08:00)
Message-ID: <2514bf3a-1f25-4b91-b5ee-8474982f6c72@rock-chips.com>
Date: Wed, 6 Nov 2024 18:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rockchip: rk3288-miqi: Use TPL with common bss and
 stack addresses
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9DTlYYGE5MHhkfSBlDQk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930112c72d03afkunm1f884348
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6GQw5TzIYPDEjNhQNHA8P
 ODEaCjBVSlVKTEhLQ0NCQ0lDQktMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTklCNwY+
DKIM-Signature: a=rsa-sha256;
 b=Czi/J8bVn+QBHMAKCg5ZRNvCjrdFcHYnetMDer4Zm7pNdh4CJDBXXma8WSA/7R72pKn972q07Rpb7hmuBy/axyRUlcUUGdFpKkNL1maXuAtDmzHsEgnVRl0xzX+8ThMdSOuJ7B+YvyrwpX+lQYXcL6vxNYAmXHdjkRhK6/J0jqg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=FL+UTO0qfDsNpDiQ/B5LBucUCCjJDpU9Am06k3KaoJk=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
> Migrate to use TPL, common bss, stack and malloc heap size and addresses
> to unify memory use in TPL, SPL and pre-reloc.
>
> ENV_OFFSET is using the default value of 0x3f8000 and is also dropped.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3288/Kconfig |  2 ++
>   configs/miqi-rk3288_defconfig         | 15 ++-------------
>   2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
> index 672d634f7fb5..ff16d258b4f5 100644
> --- a/arch/arm/mach-rockchip/rk3288/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3288/Kconfig
> @@ -86,6 +86,8 @@ config TARGET_FIREFLY_RK3288
>   config TARGET_MIQI_RK3288
>   	bool "MiQi-RK3288"
>   	select BOARD_LATE_INIT
> +	select ROCKCHIP_COMMON_STACK_ADDR
> +	select TPL
>   	help
>   	  MiQi-RK3288 is a RK3288-based development board with 4 USB 2.0
>   	  ports, HDMI, micro-SD card, 16 GB eMMC and Gigabit Ethernet. It
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 764b4351e94c..2bb8bf2ac060 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -1,24 +1,15 @@
>   CONFIG_ARM=y
>   CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
> +CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
>   CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00000000
> +CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
>   CONFIG_SF_DEFAULT_SPEED=20000000
> -CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3288-miqi"
> -CONFIG_SPL_TEXT_BASE=0xff704000
>   CONFIG_DM_RESET=y
> -CONFIG_SYS_MONITOR_LEN=614400
>   CONFIG_ROCKCHIP_RK3288=y
> -CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
>   CONFIG_TARGET_MIQI_RK3288=y
> -CONFIG_SPL_STACK_R_ADDR=0x80000
> -CONFIG_SPL_STACK=0xff718000
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
>   CONFIG_SYS_BOOTM_LEN=0x4000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xff690000
> @@ -31,8 +22,6 @@ CONFIG_MISC_INIT_R=y
>   CONFIG_SILENT_CONSOLE=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_NO_BSS_LIMIT=y
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
