Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBB5E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61373803CE;
	Fri,  3 Jan 2025 07:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BiRhOm42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE838042A; Fri,  3 Jan 2025 07:44:23 +0100 (CET)
Received: from mail-m12776.qiye.163.com (mail-m12776.qiye.163.com
 [115.236.127.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8CD803CE
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7978ae84;
 Fri, 3 Jan 2025 14:44:16 +0800 (GMT+08:00)
Message-ID: <e7f1e92f-3db0-4131-b59b-3ace081148a3@rock-chips.com>
Date: Fri, 3 Jan 2025 14:44:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] rockchip: rk3399-gru: Use TPL with common bss and
 stack addresses
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212235735.164272-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NNT1YfTRhMTUJJTU9MT0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae8560d03afkunm7978ae84
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6Lgw6MDIUTCwYOgoXODpN
 LBEwCylVSlVKTEhOQ0NNTU5MQklCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEtMNwY+
DKIM-Signature: a=rsa-sha256;
 b=BiRhOm42khGOi0YcAs2dKFMF1jcQYY4e3k7XwfceGYHSxOsCVkV6wSWZMEW45QPsvCeHxP9uKXXgHOwmjmf7+W17HuXy2jS2DwAc5e36KaOBqUPYXZKISXvKD7/XvIDmb8Em+KJbswnf0Qj2N2oPBToq7j6TGc6UXgiqwQdXm64=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=IP+dRtlgtH6SmGUESlT6pr3kmgTbaQ2M6T31K99mWuk=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> Migrate to use TPL, common bss, stack and malloc heap size and addresses
> to unify memory use in TPL, SPL and pre-reloc with other RK3399 boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/chromebook_bob_defconfig   | 13 +------------
>   configs/chromebook_kevin_defconfig | 13 +------------
>   2 files changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 69a07ef7e01e..f13c4c1e7d63 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -3,26 +3,15 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_BOOT_MODE_REG=0
> -CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
>   # CONFIG_SPL_MMC is not set
> -CONFIG_SPL_STACK=0xff8effff
> -CONFIG_SPL_TEXT_BASE=0xff8c2000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_SF_DEFAULT_BUS=1
>   CONFIG_DEBUG_UART_BASE=0xff1a0000
> @@ -42,10 +31,10 @@ CONFIG_SPL_MAX_SIZE=0x1e000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index d689eeaf2781..7a2b8e70fe69 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -3,27 +3,16 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3399=y
>   CONFIG_ROCKCHIP_BOOT_MODE_REG=0
> -CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
>   # CONFIG_SPL_MMC is not set
>   CONFIG_TARGET_CHROMEBOOK_KEVIN=y
> -CONFIG_SPL_STACK=0xff8effff
> -CONFIG_SPL_TEXT_BASE=0xff8c2000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_SF_DEFAULT_BUS=1
>   CONFIG_DEBUG_UART_BASE=0xff1a0000
> @@ -43,10 +32,10 @@ CONFIG_SPL_MAX_SIZE=0x1e000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
