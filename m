Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BEBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9587D8839D;
	Mon, 22 Apr 2024 10:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kcLoFT9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD22883C8; Mon, 22 Apr 2024 10:11:50 +0200 (CEST)
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com
 [101.71.155.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C7C883D3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kcLoFT9ePSeuN+aSySk7XKyNDZerxmnnl3jZeFKPhkc4NFVnlxWVrOXILh3kxbL9wXyYEOgkQEjbcZZTkG89TAA/paX45xlzY8iQ4YvtWSULc11KhDiXAORFA0iWY1kqOtc5+J8pVVpxnhJjLUBAt6EtgnWWPG6pp8yLrMvVpFs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=z7JkDZ4Ee1cj88tWNr5v19leQlVfCKk8p0M37E6zSbs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1C8C29002ED;
 Mon, 22 Apr 2024 16:11:41 +0800 (CST)
Message-ID: <cfe85f59-9b7c-4e56-b202-85b7c30e6e25@rock-chips.com>
Date: Mon, 22 Apr 2024 16:11:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/28] rockchip: rk35xx-generic: Disable unused features
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-29-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-29-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkfGlYZHxgeHx1KT0keSkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04dc5c4d03a9kunm1c8c29002ed
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46Ljo5LzNPSToWTR0fDRUy
 GhQwFB1VSlVKTEpITExITktJS05OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE1INwY+
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


On 2024/4/22 14:29, Jonas Karlman wrote:
> The generic RK35xx board targets are intended to be used as a bare
> minimum target that can be used to e.g. boot boards that mostly follow
> reference hw design before a board spefic target has been added or for
> flashing and recovery purposes.
>
> Disable BOOTMETH_VBE, NET and ADC as these features are not intended to
> ever be used by these minimal generic board targets.
>
> Enable SYSRESET_PSCI to let TF-A handle sysreset from U-Boot proper.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: Split patch and skip enable of SUPPORT_EMMC_BOOT option
> ---
>   configs/generic-rk3568_defconfig | 5 +++++
>   configs/generic-rk3588_defconfig | 5 +++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index 26114f9cb2a5..76c15ca27cc5 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -18,6 +18,7 @@ CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
> @@ -38,9 +39,12 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +# CONFIG_NET is not set
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set
>   CONFIG_SPL_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -68,6 +72,7 @@ CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index e96df619b59d..897456111215 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -15,6 +15,7 @@ CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_BOOTMETH_VBE is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
> @@ -34,9 +35,12 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +# CONFIG_NET is not set
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> +# CONFIG_ADC is not set
>   CONFIG_SPL_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -55,6 +59,7 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
