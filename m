Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BECC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CA583236;
	Tue,  8 Apr 2025 02:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cV4B3wdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4309E82E76; Tue,  8 Apr 2025 02:55:00 +0200 (CEST)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC81830B5
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8ce0;
 Tue, 8 Apr 2025 08:54:51 +0800 (GMT+08:00)
Message-ID: <f970fc9e-4640-4ba5-b051-d3b830fdc9bc@rock-chips.com>
Date: Tue, 8 Apr 2025 08:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] rockchip: Add DFU to boot from USB for Radxa ROCK Pi
 E v1/v3
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, banglang.huang@foxmail.com,
 jonas@kwiboo.se, trini@konsulko.com, gajjar04akash@gmail.com,
 eugen.hristev@linaro.org, quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org, christopher.obbard@linaro.org,
 wens@csie.org, sebastian.reichel@collabora.com
References: <20250211061322.94186-1-naoki@radxa.com>
 <20250211061322.94186-6-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211061322.94186-6-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB8fVk9IH01PHUoYSUlLHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e490fd03afkunm10fbd8ce0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Sjo5VjJPSEMDPkw6KQIM
 FywaCjZVSlVKTE9PS0xITUJITkNLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5MTEg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=cV4B3wdJvTzdERx/5yziJTi1mQNxUs6WyYx/8E46ztzTyg3ZhuqzwoKd0dCq6sNy7WXk6gW/pg3aj8ZaEKK2bLs+9lf3S1r1yIGTPkmP3PonQqXocbGiLjdTL6J9S9a/BIRFs0bScgU8t/1E9g4ia5mUJ/TUCoEI1BAnjb6Dl1w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=UiDuJU/dqFBti5tMKQGvLGy5jPTn/SHVdvJMH039BV0=;
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
> Boot the Radxa ROCK Pi E v1/v3 from the USB OTG port using
> rkflashtool[1] or rkusbboot[2] and dfu-util.
>
> 1a. Download the TPL and SPL using rkflashtool
>
> $ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
> 	< mkimage-in-simple-bin.mkimage-u-boot-tpl | rkflashtool l
> $ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
> 	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L
>
> 1b. Download the TPL and SPL using rkusbboot
>
> $ rkusbboot \
> 	mkimage-in-simple-bin.mkimage-u-boot-tpl \
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
>   arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  8 ++++++++
>   configs/rock-pi-e-rk3328_defconfig             | 12 ++++++++++++
>   configs/rock-pi-e-v3-rk3328_defconfig          | 12 ++++++++++++
>   3 files changed, 32 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> index a30adb0be98..fe15d4ba540 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> @@ -38,6 +38,14 @@
>   	phy-supply = <&vcc_host_5v>;
>   };
>   
> +&u2phy_otg {
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	status = "okay";
> +};
> +
>   &vcc_host_5v {
>   	/delete-property/ regulator-always-on;
>   	/delete-property/ regulator-boot-on;
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
> index 52dad765a8a..9fdb08f29f9 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -24,10 +24,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> @@ -51,6 +53,10 @@ CONFIG_SPL_SYSCON=y
>   CONFIG_TPL_SYSCON=y
>   CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
> @@ -86,6 +92,7 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_SYSRESET=y
>   # CONFIG_TPL_SYSRESET is not set
>   CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> @@ -93,6 +100,11 @@ CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
> index 518ea4ebe51..c3dfc2718f0 100644
> --- a/configs/rock-pi-e-v3-rk3328_defconfig
> +++ b/configs/rock-pi-e-v3-rk3328_defconfig
> @@ -24,10 +24,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> @@ -52,6 +54,10 @@ CONFIG_SPL_SYSCON=y
>   CONFIG_TPL_SYSCON=y
>   CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
> +CONFIG_DFU_RAM=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_LED=y
> @@ -87,6 +93,7 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_SYSRESET=y
>   # CONFIG_TPL_SYSRESET is not set
>   CONFIG_USB=y
> +CONFIG_SPL_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> @@ -94,6 +101,11 @@ CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
