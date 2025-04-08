Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98476C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6BD83106;
	Tue,  8 Apr 2025 02:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eXM9fiVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8444783106; Tue,  8 Apr 2025 02:55:14 +0200 (CEST)
Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com
 [220.197.31.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9E48320C
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8d10;
 Tue, 8 Apr 2025 08:55:02 +0800 (GMT+08:00)
Message-ID: <9c1f76be-4155-4d17-8353-89a89722bcc0@rock-chips.com>
Date: Tue, 8 Apr 2025 08:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: Add DFU to boot from USB for Radxa ROCK Pi S
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, banglang.huang@foxmail.com,
 jonas@kwiboo.se, trini@konsulko.com, gajjar04akash@gmail.com,
 eugen.hristev@linaro.org, quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org, christopher.obbard@linaro.org,
 wens@csie.org, sebastian.reichel@collabora.com
References: <20250211061322.94186-1-naoki@radxa.com>
 <20250211061322.94186-7-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211061322.94186-7-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkpIVkseH0JMQkhCQ01KGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e4bfe403afkunm10fbd8d10
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6FRw6TDJDH0MVEExRKUw4
 FBZPFBVVSlVKTE9PS0xITEtOTkpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhJSEw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=eXM9fiVaUMUpNcUzGVvLaV1Govw87usnLv/et2HBikSQdzzt5NxzrYsyhIliNREF3j2f/D8orMpEgi3S3hdPgDTnHUxLbbMXRYRGm/H2V5ypgPP7KDAzSBg4CmkT+hLR0FCAqFzYr/KvcgeeGXeZvO+c0E2P46PcRvjqNEc6Nvw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jWh7T7Z1bslh/yCUrSPFLjs1UjonOOg8LTMpXXXGxdw=;
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
> Boot the Radxa ROCK Pi S from the USB OTG port using rkflashtool[1] or
> rkusbboot[2] and dfu-util.
>
> 1a. Download the TPL and SPL using rkflashtool
>
> $ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
> 	< mkimage-in-simple-bin.mkimage-rockchip-tpl | rkflashtool l
> $ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
> 	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L
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
>   configs/rock-pi-s-rk3308_defconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 4b08af309b1..29eb6a26bfb 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -19,6 +19,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> @@ -35,6 +37,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_REGMAP=y
>   CONFIG_SYSCON=y
>   CONFIG_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> @@ -62,11 +67,14 @@ CONFIG_SYSINFO=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_DFU=y
>   CONFIG_LZO=y
>   CONFIG_ERRNO_STR=y
