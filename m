Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176AEC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F91982FE9;
	Tue,  8 Apr 2025 02:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FpzEUGCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5F482E76; Tue,  8 Apr 2025 02:54:16 +0200 (CEST)
Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com
 [220.197.31.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B18830B5
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8c26;
 Tue, 8 Apr 2025 08:54:06 +0800 (GMT+08:00)
Message-ID: <2614608b-9506-4f07-9e6d-dbf1d7ccd4d6@rock-chips.com>
Date: Tue, 8 Apr 2025 08:54:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: Add DFU to boot from USB for Radxa ROCK 3A
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, banglang.huang@foxmail.com,
 jonas@kwiboo.se, trini@konsulko.com, gajjar04akash@gmail.com,
 eugen.hristev@linaro.org, quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org, christopher.obbard@linaro.org,
 wens@csie.org, sebastian.reichel@collabora.com
References: <20250211061322.94186-1-naoki@radxa.com>
 <20250211061322.94186-3-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211061322.94186-3-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxlCVkpPSEsdSRlCTB8eS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e3e08303afkunm10fbd8c26
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Fww*TTJITENOPlY0STJD
 Iy8KFD5VSlVKTE9PS0xITU9DQ0NJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhJTEs3Bg++
DKIM-Signature: a=rsa-sha256;
 b=FpzEUGCbmbtfyDXsluL/3Qn3ydXfglHGTfBdXkYPFf83nPt0tPB47n3+ZAbkIT07aIQEqN9uXz5grcATecv5WtsyAolEWYYvLaRUWJy1TdBp6mNgZPGMlm5zsLuo31rZMAtbICiLBaqJc7YS4NmV0BkH2aegr8HNnMF1QvQEe3I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=bzbaLPGavAP8w+noI/NEOnIAqrpT1Poiks+Ns7WpeJA=;
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
> Boot the Radxa ROCK 3A from the USB OTG port using rkflashtool[1] or
> rkusbboot[2] and dfu-util.
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
>   configs/rock-3a-rk3568_defconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 733ce631457..2efadeeb035 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -28,9 +28,11 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -51,6 +53,10 @@ CONFIG_SPL_SYSCON=y
>   CONFIG_SCSI_AHCI=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
> @@ -85,6 +91,7 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> @@ -92,4 +99,9 @@ CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
>   CONFIG_ERRNO_STR=y
