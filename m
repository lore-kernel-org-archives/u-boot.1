Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB3ED3E78C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 09:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D300A88DB6;
	Wed,  6 Nov 2024 10:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kLUFoqsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947578900E; Wed,  6 Nov 2024 10:56:50 +0100 (CET)
Received: from mail-m49243.qiye.163.com (mail-m49243.qiye.163.com
 [45.254.49.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD8188CD9
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 10:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f75306e;
 Wed, 6 Nov 2024 17:56:43 +0800 (GMT+08:00)
Message-ID: <abf3e0e0-8b6a-4432-8c1c-a581b644638f@rock-chips.com>
Date: Wed, 6 Nov 2024 17:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk35xx-generic: Disable late boardinfo
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241102213004.3644543-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241102213004.3644543-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4aQ1YaS00dHx8dHUJMS0JWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300e7ad1803afkunm1f75306e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Sgw4LzIYLDEPMCkfEzlW
 Hk0wCw1VSlVKTEhLQ0NMS0tPS0lKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0pJNwY+
DKIM-Signature: a=rsa-sha256;
 b=kLUFoqsZxJ1R1K7uSyho9vE6rD5c+NK13VYE6v0KUbi7Q/in6ZCncpvVFrYMbrg+7+G1HyvpQTW9sq2i1UM+pWDqCz7/EFM2xgENGzC0xkH1DoKdhE00NdPGg2DN3SburmdYIJHIOmf1DCbLGjnmvt3UNvkUe4JEyyLjKr/lT5A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=g/pKbiSq+4FA8R0iULfBWgfBSfm5YAj5RkytX8NmvIQ=;
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


On 2024/11/3 05:30, Jonas Karlman wrote:
> Disable DISPLAY_BOARDINFO_LATE as the early boardinfo print of Model
> should be enough.
>
>    U-Boot 2025.01-rc1 (Nov 02 2024 - 16:04:16 +0000)
>
>    Model: Generic RK3566/RK3568
>    DRAM:  8 GiB (effective 7.7 GiB)
>    Core:  250 devices, 24 uclasses, devicetree: separate
>    MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
>    Loading Environment from nowhere... OK
>    In:    serial@fe660000
>    Out:   serial@fe660000
>    Err:   serial@fe660000
>    Model: Generic RK3566/RK3568
>    Hit any key to stop autoboot:  0
>    =>
>
> Enable CMD_MISC to make it easier to inspect data in OTP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/generic-rk3568_defconfig | 2 +-
>   configs/generic-rk3588_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index 1d06f3411fe0..f79f0e84400b 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> @@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index ebe883ed5972..51e31dce3a96 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -18,13 +18,13 @@ CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
