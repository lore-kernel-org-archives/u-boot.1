Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F848C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FEC83032;
	Tue,  8 Apr 2025 02:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QYlhJh0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D74C831D5; Tue,  8 Apr 2025 02:52:13 +0200 (CEST)
Received: from mail-m10101.netease.com (mail-m10101.netease.com
 [154.81.10.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A1382FE9
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd8a0d;
 Tue, 8 Apr 2025 08:52:05 +0800 (GMT+08:00)
Message-ID: <dee6ab8e-17fa-4f5a-b65f-3c1d1f74a265@rock-chips.com>
Date: Tue, 8 Apr 2025 08:52:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3288: do not generate u-boot.rom
 anymore
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-2-d1768ee87808@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-2-d1768ee87808@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB9CVksdSE5DQh9MSR0fHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e2089603afkunm10fbd8a0d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ny46Lzo6HjIBNUNJEAw5CC5M
 IjcwCzpVSlVKTE9PS0xITklNQ01NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5PSEM3Bg++
DKIM-Signature: a=rsa-sha256;
 b=QYlhJh0EFEE3/rMOYz/gpyUtwnxILGuCYVEpCB/wZ9LKW4aPOhdol1QXw9xcnF6iU+DzOFyTvwfkM+h7/1t0M+Q2vgXqXHaTmXc4awQSr6L32k3sGavB9h4QL9IbpegEFXIacEOj/CQQGmJciIghJoaE23j+RJ/JFvw8eDzhWAA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=sJyoZQ+2jvmQc1efjif7gtAmMoh/xW8Oc4lxhiNaM8o=;
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


On 2025/2/21 00:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This was only used on RK3288 Chromebooks and the EVB.
>
> If it follows the same pattern as for RK3399 Chromebooks where their
> maintainer (Simon) agreed[1] to removal of u-boot.rom on the basis that
> the generic u-boot-rockchip-spi.bin is now enough, let's do the same for
> RK3288 and remove the last Rockchip users of u-boot.rom (and HAS_ROM
> symbol).
>
> At the same time, remove HAS_ROM symbol from the RK3288 Chromebooks and
> EVB configs since they were used only for that.
>
> SYS_SPI_U_BOOT_OFFS offset in rockchip-u-boot.dtsi for the u-boot-img
> node of simple-bin-spi binman image matches the one used in u-boot.rom
> except for the EVB.
> The EVB doesn't have ROCKCHIP_SPI_IMAGE symbol enabled, so HAS_ROM had
> no effect anyway. Even if it had, this would not have been enough
> considering that SPL_SPI_LOAD symbol is not set, so U-Boot proper could
> not be loaded from SPI even if SPL/TPL does.
>
> Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
> Chromebooks as that seems to be important.
>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-u-boot.dtsi        | 24 ------------------------
>   arch/arm/dts/rk3288-veyron-u-boot.dtsi |  8 ++++++++
>   arch/arm/mach-rockchip/rk3288/Kconfig  |  5 -----
>   3 files changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index 2205caabc51ec4535bef3ab950d7ff5b421d8016..bb0078588fe819118eb0592e002e1708da7ce806 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -46,30 +46,6 @@
>   	};
>   };
>   
> -#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> -&binman {
> -	rom {
> -		filename = "u-boot.rom";
> -		size = <0x400000>;
> -		pad-byte = <0xff>;
> -
> -		mkimage {
> -			args = "-n rk3288 -T rkspi";
> -			u-boot-spl {
> -			};
> -		};
> -		u-boot-img {
> -			offset = <0x20000>;
> -		};
> -		u-boot {
> -			offset = <0x300000>;
> -		};
> -		fdtmap {
> -		};
> -	};
> -};
> -#endif
> -
>   &bus_intmem {
>   	ddr_sram: ddr-sram@1000 {
>   		compatible = "rockchip,rk3288-ddr-sram";
> diff --git a/arch/arm/dts/rk3288-veyron-u-boot.dtsi b/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> index 4f9c59c67573118dba716e46f21f9b5e303b0c28..89093e2311c758b78454710043aea7006533e5bd 100644
> --- a/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> @@ -11,6 +11,14 @@
>   	};
>   };
>   
> +#if defined(CONFIG_ROCKCHIP_SPI_IMAGE)
> +&binman {
> +	simple-bin-spi {
> +		size = <0x400000>;
> +	};
> +};
> +#endif
> +
>   &dmc {
>   	logic-supply = <&vdd_logic>;
>   	rockchip,odt-disable-freq = <333000000>;
> diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
> index e563bf455e6803809c7d7612bb3aa85372034292..128ee362f8a8af69861030df7b63cf0e5a368956 100644
> --- a/arch/arm/mach-rockchip/rk3288/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3288/Kconfig
> @@ -5,7 +5,6 @@ choice
>   
>   config TARGET_CHROMEBOOK_JERRY
>   	bool "Google/Rockchip Veyron-Jerry Chromebook"
> -	select HAS_ROM
>   	select BOARD_LATE_INIT
>   	select ROCKCHIP_SPI_IMAGE
>   	help
> @@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_JERRY
>   
>   config TARGET_CHROMEBIT_MICKEY
>   	bool "Google/Rockchip Veyron-Mickey Chromebit"
> -	select HAS_ROM
>   	select BOARD_LATE_INIT
>   	select ROCKCHIP_SPI_IMAGE
>   	help
> @@ -28,7 +26,6 @@ config TARGET_CHROMEBIT_MICKEY
>   
>   config TARGET_CHROMEBOOK_MINNIE
>   	bool "Google/Rockchip Veyron-Minnie Chromebook"
> -	select HAS_ROM
>   	select BOARD_LATE_INIT
>   	select ROCKCHIP_SPI_IMAGE
>   	help
> @@ -41,7 +38,6 @@ config TARGET_CHROMEBOOK_MINNIE
>   
>   config TARGET_CHROMEBOOK_SPEEDY
>   	bool "Google/Rockchip Veyron-Speedy Chromebook"
> -	select HAS_ROM
>   	select BOARD_LATE_INIT
>   	select ROCKCHIP_SPI_IMAGE
>   	help
> @@ -54,7 +50,6 @@ config TARGET_CHROMEBOOK_SPEEDY
>   
>   config TARGET_EVB_RK3288
>   	bool "Evb-RK3288"
> -	select HAS_ROM
>   	select BOARD_LATE_INIT
>   	select TPL
>   	help
>
