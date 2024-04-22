Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41834C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE210883E4;
	Mon, 22 Apr 2024 10:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YE+MrhnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BA6883D7; Mon, 22 Apr 2024 10:43:35 +0200 (CEST)
Received: from mail-m244.xmail.ntesmail.com (mail-m244.xmail.ntesmail.com
 [45.195.24.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1EB883E9
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YE+MrhnP2AtcTnz6X+PucRJSuJP7Ti+A8D8XGtHiFREI9MZeeMJgXmjdsBz8Ab6UeY2Zn/4fjsvjKS9HANI377lD//79EE3cSHedszLd4TUX4rM5uA4ByDJTfiExcKziEp/UyKTuJAIclu49bUIZlxAaDhtzyrzSp/jaycD3d6g=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=rbXcQVy0lNMTVRz71A6DnkA62FtupAMFmh5Aw7ZsCKA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1D0D490031D;
 Mon, 22 Apr 2024 16:43:16 +0800 (CST)
Message-ID: <fe42fefc-b8ff-4039-9a21-9413085aac10@rock-chips.com>
Date: Mon, 22 Apr 2024 16:43:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] rockchip: rk3308: Enable ARMv8 crypto and FIT
 checksum validation
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0ZSVYYQ0waTkMaS0NMTENVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f94b2003a9kunm1d0d490031d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6Vio*OjMCFDpKHTYZPAIY
 S04KCxFVSlVKTEpITExOSEJDSk1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTk1DNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> The RK3308 SoC support ARMv8 Cryptography Extensions and use of the
> ARMv8 crypto extensions help speed up FIT checksum validation in SPL.
>
> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
> extensions for SHA256 when validating checksum of FIT images.
>
> Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
> validation on all RK3308 boards.
>
> Also disable CONFIG_SPL_RAW_IMAGE_SUPPORT in board defconfigs to ensure
> SPL does not try to jump to code that failed checksum validation.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig     | 4 ++++
>   configs/evb-rk3308_defconfig       | 1 +
>   configs/roc-cc-rk3308_defconfig    | 1 +
>   configs/rock-pi-s-rk3308_defconfig | 1 +
>   4 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 2fde8655d18a..71c5945b5742 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -160,8 +160,12 @@ config ROCKCHIP_RK3308
>   	select SPL_ATF
>   	select SPL_ATF_NO_PLATFORM_PARAM
>   	select SPL_LOAD_FIT
> +	imply ARMV8_CRYPTO
> +	imply ARMV8_SET_SMPEN
> +	imply LEGACY_IMAGE_FORMAT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_CLK
> +	imply SPL_FIT_SIGNATURE
>   	imply SPL_RAM
>   	imply SPL_REGMAP
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index d57b2f6b8e55..6a6d2540317d 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index 5e8f51ec01e3..2f4a160acc24 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 1e9cd2c0fc7e..b0ad4d6ce354 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -21,6 +21,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
