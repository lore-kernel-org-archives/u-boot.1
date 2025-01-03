Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E475E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA89B802EF;
	Fri,  3 Jan 2025 07:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hiTvEXGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E21C803B7; Fri,  3 Jan 2025 07:39:53 +0100 (CET)
Received: from mail-m127207.xmail.ntesmail.com
 (mail-m127207.xmail.ntesmail.com [115.236.127.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB98803CF
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79758728;
 Fri, 3 Jan 2025 14:39:45 +0800 (GMT+08:00)
Message-ID: <cd18e024-9b75-46f1-9c69-202d0cbe984e@rock-chips.com>
Date: Fri, 3 Jan 2025 14:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rockchip: rk3288-firefly: Use common bss and stack
 addresses
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktCSVZIGB5OQ0NOH0pMGkNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae4321903afkunm79758728
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6IRw*FjIRKSxLDDVCSAst
 HjgwFE9VSlVKTEhOQ0NNSENNTEpIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSU5INwY+
DKIM-Signature: a=rsa-sha256;
 b=hiTvEXGDgCCRQZNG6LkkSAnh6nxNGva1Ygil6zh0fAYAflf+ZWZKSA9jacvVXXO2gE+5gNWWPEambrrdhz5r2if1eyiR6WLCjnVReH/cxxp4ZXeDEZcUcgsh+EnxZsE1of0DuPxHfXRpQEo3weDbEFLNcEPyHMUj8uJuMfjZL9g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=1DmjGfonq55y952t3XNCnMLH3kbXWvpFgzLCwcOD2oU=;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> Migrate to use common bss, stack and malloc heap size and addresses to
> unify memory use in TPL, SPL and pre-reloc.
>
> ENV_OFFSET is using the default value of 0x3f8000 and is also dropped.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3288/Kconfig |  1 +
>   configs/firefly-rk3288_defconfig      | 10 ----------
>   2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
> index 9cc97bacc41d..e563bf455e68 100644
> --- a/arch/arm/mach-rockchip/rk3288/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3288/Kconfig
> @@ -75,6 +75,7 @@ config TARGET_FENNEC_RK3288
>   config TARGET_FIREFLY_RK3288
>   	bool "Firefly-RK3288"
>   	select BOARD_LATE_INIT
> +	select ROCKCHIP_COMMON_STACK_ADDR
>   	select TPL
>   	help
>   	  Firefly is a RK3288-based development board with 2 USB ports,
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index eed0806b2321..87ed0c0d2aea 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -5,19 +5,11 @@ CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
>   CONFIG_SF_DEFAULT_SPEED=20000000
> -CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3288-firefly"
>   CONFIG_DM_RESET=y
> -CONFIG_SYS_MONITOR_LEN=614400
>   CONFIG_ROCKCHIP_RK3288=y
>   CONFIG_TARGET_FIREFLY_RK3288=y
> -CONFIG_SPL_STACK_R_ADDR=0x80000
> -CONFIG_SPL_STACK=0xff718000
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
>   CONFIG_SYS_BOOTM_LEN=0x4000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_SPL_SIZE_LIMIT=0x40000
> @@ -31,8 +23,6 @@ CONFIG_SILENT_CONSOLE=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_NO_BSS_LIMIT=y
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
