Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A8C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784B488370;
	Mon, 22 Apr 2024 10:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MXWYc8Ic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8F288353; Mon, 22 Apr 2024 10:09:35 +0200 (CEST)
Received: from mail-m2420.xmail.ntesmail.com (mail-m2420.xmail.ntesmail.com
 [45.195.24.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340ED8837B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MXWYc8IcJyuV16+KAEfs2Ta7LIU0Mt5i04b218vByUkSzig+mndBqWs84IPaXVp0BPo3iGb+MhDJvOHgHzQmPi9DVKya/rso8eUSQMJ9Bf+n1C9HuZgyAy51SgfwFS9aIfSzotGaimETLRxtPr+nmgMiOKmQSYIx3n89zDTez30=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Tpnoh0HV4nC1AuSCNMC5mn53F50y0aWwb4ytJf+jaWM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D02E890029C;
 Mon, 22 Apr 2024 16:09:24 +0800 (CST)
Message-ID: <6dd52fd5-cf14-4517-83c3-21020c783caa@rock-chips.com>
Date: Mon, 22 Apr 2024 16:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/28] rockchip: rk3588-edgeble-neu6: Enable FIT
 checksum validation
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@edgeble.ai>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-23-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-23-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNIT1ZITUkdSUNLS0pDGBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04da492403a9kunmd02e890029c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6NSo*ETNJEDoXGChOTE0U
 QzQaCw1VSlVKTEpITExISE1NSk5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0JNNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Enable SPL_FIT_SIGNATURE=y and LEGACY_IMAGE_FORMAT=y to validate FIT
> images checksum in SPL.
>
> Change to SPL_MAX_SIZE=0x40000 to allow SPL up to 256 KiB in size.
>
> Enable SPL_DM_SEQ_ALIAS=y and SPL_PINCTRL=y to ensure eMMC and SD-card
> pinctrl is configured in SPL.
>
> Enable SYS_NS16550_MEM32=y to use readl/writel in serial driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: No change
> ---
>   configs/neu6a-io-rk3588_defconfig | 7 ++++++-
>   configs/neu6b-io-rk3588_defconfig | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
> index bc2d70421ee9..050f1e5700b1 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -13,11 +13,13 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6a-io.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF=y
> @@ -28,6 +30,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -40,9 +43,11 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
> index 8bc75a5f0dd9..dabb59afe687 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -13,11 +13,13 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6b-io.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF=y
> @@ -28,6 +30,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -40,9 +43,11 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_ERRNO_STR=y
