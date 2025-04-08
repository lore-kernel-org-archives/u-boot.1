Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8446EC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC6982F6A;
	Tue,  8 Apr 2025 02:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VDDGzDkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA0082FE9; Tue,  8 Apr 2025 02:54:56 +0200 (CEST)
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com
 [220.197.32.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD1E82E76
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8cc6;
 Tue, 8 Apr 2025 08:54:44 +0800 (GMT+08:00)
Message-ID: <0acb1bc6-88ef-4a87-a27e-9aa69b774b54@rock-chips.com>
Date: Tue, 8 Apr 2025 08:54:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] rockchip: Add DFU to boot from USB for Radxa ZERO
 3E/3W
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, banglang.huang@foxmail.com,
 jonas@kwiboo.se, trini@konsulko.com, gajjar04akash@gmail.com,
 eugen.hristev@linaro.org, quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org, christopher.obbard@linaro.org,
 wens@csie.org, sebastian.reichel@collabora.com
References: <20250211061322.94186-1-naoki@radxa.com>
 <20250211061322.94186-5-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211061322.94186-5-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEhPVkpITR9JTUJLTx1JTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e4764f03afkunm10fbd8cc6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6URw5HjJWA0MVEE01KQs4
 IzUaCRpVSlVKTE9PS0xITUNMQklNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhKT043Bg++
DKIM-Signature: a=rsa-sha256;
 b=VDDGzDkGIrosrLDp+RgbMFbeCdn0xUGXOjBqDXFSHdjAXLiuYf4OYolcV6sRcXGVlJIP7p9cQGmrKZaqQCTI3B+Z40cQZdxGIj7pL5xD5tjjQJwVgCqOJ6Dve+Kt62+hoT4gwwu14TrODKKIQoGPlZrEZMX9iWPZEEW+cDRpRrs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=m8L+XHrgtLC9Jjd3diPgsDn3ZS6Ui5gu5oCxnEG4PoI=;
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


On 2025/2/11 14:13, FUKAUMI Naoki wrote:
> Boot the Radxa ZERO 3E/3W from the USB OTG port using rkflashtool[1]
> or rkusbboot[2] and dfu-util.
>
> 1a. Download the TPL and SPL using rkflashtool
>
> $ rkflashtool l < mkimage-in-simple-bin.mkimage-rockchip-tpl
> $ rkflashtool L < mkimage-in-simple-bin.mkimage-u-boot-spl
>
> 1b. Download the TPL and SPL using rkusbboot
>
> $ rkusbboot \
> 	mkimage-in-simple-bin.mkimage-rockchip-tpl \
> 	mkimage-in-simple-bin.mkimage-u-boot-spl
>
> 2. Download the U-Boot
>
> $ dfu-util -a 0 -D u-boot.itb
>
> [1] https://github.com/linux-rockchip/rkflashtool
> [2] https://github.com/RadxaNaoki/rkusbboot
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/radxa-zero-3-rk3566_defconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
> index 5989b07ad79..7aae38e06d4 100644
> --- a/configs/radxa-zero-3-rk3566_defconfig
> +++ b/configs/radxa-zero-3-rk3566_defconfig
> @@ -22,8 +22,10 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -45,6 +47,9 @@ CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_ADC=y
>   CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> @@ -76,10 +81,14 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_SYSRESET_PSCI=y
>   CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_DFU=y
>   CONFIG_ERRNO_STR=y
