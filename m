Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2449ECA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0298380E;
	Sat, 30 Aug 2025 17:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hUKJ0OA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB8083857; Sat, 30 Aug 2025 17:14:44 +0200 (CEST)
Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com
 [220.197.32.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AB1836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4f32;
 Sat, 30 Aug 2025 23:14:36 +0800 (GMT+08:00)
Message-ID: <c5328094-d81b-4197-9af1-8b6984af6a96@rock-chips.com>
Date: Sat, 30 Aug 2025 23:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] rockchip: odroid-go2: Update Kconfig options for SPL
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250713233429.1376172-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb8b72ff03afkunmc169009641278f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB1IVhpLGUNPH0NPTkkYGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=hUKJ0OA/uVZwAW/WEVBDHN2fCXJHlUjhLaV3Yqt06xJjxGYj52x/tzejerGi2Pmj8KncRdJs7iXTtONLeq1N5w8E/yZJS1Ta2ICrlw4ZBI/pFVYCgYnohNTwEIwHXBtv4Cx2EN0WpTLpYSYf5b/B8NQa0MUg8ASJWromKcBQzI8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=OXDAAKOK8KLAE/eekslBseCdlCnL/tgtpaAdJTunbfQ=;
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


On 2025/7/14 07:33, Jonas Karlman wrote:
> Drop SPL_DRIVERS_MISC, it is not needed/used on these devices.
>
> Enable SPL_FIT_SIGNATURE to ensure the integrity of the FIT images
> that are loaded into memory.
>
> Change SPL_MAX_SIZE to 256 KiB, similar to other SoCs where TF-A is
> loaded at 0x40000 offset from start of DRAM.
>
> Enable SPL_DM_SEQ_ALIAS to ensure device aliases are applied in SPL.
>
> Drop use of SPL_TINY_MEMSET, there is plenty room for the normal memset.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/odroid-go2_defconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index d6a63bd3a4cd..6bc0d12440c9 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
>   CONFIG_TARGET_ODROID_GO2=y
>   CONFIG_DEBUG_UART_CHANNEL=1
> -CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART_BASE=0xFF160000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> @@ -19,12 +18,13 @@ CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_FIT_BEST_MATCH=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3326-odroid-go2.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_BOARD_LATE_INIT=y
>   CONFIG_MISC_INIT_R=y
> -CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_I2C=y
> @@ -53,6 +53,7 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -90,7 +91,6 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y
