Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBCC25B5C
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03618848B;
	Mon,  6 May 2024 12:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="R/Vrts8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACED88497; Mon,  6 May 2024 12:35:09 +0200 (CEST)
Received: from mail-m17243.xmail.ntesmail.com (mail-m17243.xmail.ntesmail.com
 [45.195.17.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9404C8848B
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=R/Vrts8FKDd85QCxbiVuezzef8sv5aJPzgGIKxfliDpqyMxPQPVmtHAiRdVWPV6SBvb1fTJosLkMI5zL+IbJP+1wKnigXxyvCbBP+GUEjMkBIl48IkftOPtwpT2Ve5Y5FuX89kLuuIGvgt0Epd5LTnNXF1w/5WNy8tsV2SerNBM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=+2fQDyxapqNAv83wQgTVp2YQFQYhx+5ShJ1oxIU8Gyg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4E4349002DF;
 Mon,  6 May 2024 18:34:58 +0800 (CST)
Message-ID: <250564c8-e7c8-4614-971a-a538c05428c0@rock-chips.com>
Date: Mon, 6 May 2024 18:34:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] rockchip: rk3399-puma: Use common bss and stack
 addresses
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtDQ1ZOThpOSkIeTU4fSk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7893f103a9kunm4e4349002df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6Szo*OjNNURZMMk8sTRAM
 PyowFDhVSlVKTEpPQkJKTUJCT0lIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkxCNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> The rk3399-puma board is currently using SPL stack and bss addr in SRAM,
> the same addr typically used by TPL, this differs from most other RK3399
> boards.
>
> Switch to use the common bss and stack addresses introduced in commit
> 008ba0d56d00 ("rockchip: Add common default bss and stack addresses").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   configs/puma-rk3399_defconfig | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index ec7d52a6e13e..bd4926cf0fce 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -2,11 +2,8 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_SIZE=0x3000
>   CONFIG_ENV_OFFSET=0x3F8000
> @@ -16,12 +13,6 @@ CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TARGET_PUMA_RK3399=y
> -CONFIG_SPL_STACK=0xff8effff
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>   CONFIG_DEBUG_UART_BASE=0xFF180000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -33,7 +24,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
>   CONFIG_SPL_PAD_TO=0x38000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_POWER=y
