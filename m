Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1CCC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F78C83028;
	Tue,  8 Apr 2025 02:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BvIXvb0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A1183032; Tue,  8 Apr 2025 02:51:58 +0200 (CEST)
Received: from mail-m81251.xmail.ntesmail.com (mail-m81251.xmail.ntesmail.com
 [156.224.81.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1C882FE9
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbd89cd;
 Tue, 8 Apr 2025 08:51:49 +0800 (GMT+08:00)
Message-ID: <da47a721-4e3b-4635-b33d-ceb0d8e7c208@rock-chips.com>
Date: Tue, 8 Apr 2025 08:51:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk3399: do not generate u-boot.rom
 anymore
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-1-d1768ee87808@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-1-d1768ee87808@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTU9LVk1LHkMeHktOHkJISlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612e1c94803afkunm10fbd89cd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6Hio5ATJCLUM*Lg0tHzY5
 MkkwCzxVSlVKTE9PS0xITkpLTkJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9PTks3Bg++
DKIM-Signature: a=rsa-sha256;
 b=BvIXvb0GJe0Tv2J3sM5XhNPbmEv6kw1/06475wn4Ja8t5sLm/M9bw8dAVWn3X34VwUcXvnM3vpNEiI+SU1UDeUkhl40+qy4Av42d4fPdUTZH7pM4O0IvUkeBW9yWEjtifh3curks7enASvz68BeD83j5+Oe0/jNeprDNQWzGpNI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=OEvqQS6Q8bocn2noxH4SEekMSBcqZUft5lGFBBhCS4Q=;
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
> This was only used on RK3399 Gru Chromebooks and their maintainer
> (Simon) agreed[1] to its removal on the basis that the generic
> u-boot-rockchip-spi.bin is now enough, so let's do that.
>
> At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
> since they were used only for that.
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
>   arch/arm/dts/rk3399-gru-u-boot.dtsi   |  4 +++-
>   arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>   arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>   3 files changed, 3 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> index 5517176aa4a0bcc11aa292e76be7c4d894a034f7..dfc7be4c621e712cc665e889b9c54d192924827a 100644
> --- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> @@ -15,11 +15,13 @@
>   	};
>   };
>   
> +#if defined(CONFIG_ROCKCHIP_SPI_IMAGE)
>   &binman {
> -	rom {
> +	simple-bin-spi {
>   		size = <0x800000>;
>   	};
>   };
> +#endif
>   
>   &cros_ec {
>   	ec-interrupt = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 70f35b6c197a8bedf2fc09ec66d2aac8e615aa75..587eef9504eccc7a1ea365b5f8aed24756692dcb 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -29,41 +29,6 @@
>   	};
>   };
>   
> -#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> -&binman {
> -	multiple-images;
> -	rom {
> -		filename = "u-boot.rom";
> -		size = <0x400000>;
> -		pad-byte = <0xff>;
> -
> -		mkimage {
> -			args = "-n rk3399 -T rkspi";
> -			multiple-data-files;
> -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> -			rockchip-tpl {
> -			};
> -#elif defined(CONFIG_TPL)
> -			u-boot-tpl {
> -			};
> -#endif
> -			u-boot-spl {
> -			};
> -		};
> -		fit {
> -			type = "blob";
> -			filename = "u-boot.itb";
> -			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -		};
> -		u-boot {
> -			offset = <0x300000>;
> -		};
> -		fdtmap {
> -		};
> -	};
> -};
> -#endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */
> -
>   &cru {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 500cfcd87afd23782bb64d231e337330e12497da..bdfd79458f56d2dfca31462db7a9023dabb156e8 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -5,7 +5,6 @@ choice
>   
>   config TARGET_CHROMEBOOK_BOB
>   	bool "Asus Flip C101PA Chromebook (RK3399)"
> -	select HAS_ROM
>   	select ROCKCHIP_SPI_IMAGE
>   	help
>   	  Bob is a small RK3299-based device similar in apperance to Minnie.
> @@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_BOB
>   
>   config TARGET_CHROMEBOOK_KEVIN
>   	bool "Samsung Chromebook Plus (RK3399)"
> -	select HAS_ROM
>   	select ROCKCHIP_SPI_IMAGE
>   	help
>   	  Kevin is a RK3399-based convertible chromebook. It has two USB 3.0
>
