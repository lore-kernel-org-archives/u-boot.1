Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C639C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77626884C7;
	Thu,  6 Jun 2024 10:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="O3N2OTEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD928844E; Thu,  6 Jun 2024 10:15:57 +0200 (CEST)
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com
 [45.254.49.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF94D88582
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=O3N2OTEoPKNamXKi93vvsPrYXw5aFpMnTDjYx4eNXbrZiitqAfhL6xJFgP7R4g1B98paTIvC/PN0hNVPwmknbb4L26Oa6E1AhGX6PFurDF8SGJChRQywBMazZhCYd/oQYzWZi88/yrfrZTNHCJI6y6TBdWjwYc98Y6Zf4dEI4ng=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=OTEe3LZdtzQJV6rq6haR51qbqc0ai//Ox6ZNamRh3mo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 2AE179005D2;
 Thu,  6 Jun 2024 16:15:34 +0800 (CST)
Message-ID: <476c067f-08f3-4ed0-8f99-10af0446bddd@rock-chips.com>
Date: Thu, 6 Jun 2024 16:15:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH next v2 4/6] rockchip: px30-ringneck: Update SPL_PAD_TO
 Kconfig option
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-4-12479432c90f@cherry.de>
Content-Language: en-US
In-Reply-To: <20240605-misc-tsd-v2-4-12479432c90f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MdS1YdHklMSEoYHk9OTUlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec9e172703a9kunm2ae179005d2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Fyo4NzMBODVCPk42CjBR
 KykKCQlVSlVKTEpMTU1KTEhOSk5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ0JLNwY+
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


On 2024/6/5 23:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> On px30-ringneck the FIT payload is located at sector 0x200 compared to
> the more Rockchip common sector 0x4000 offset:
> 	SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>
> Because FIT payload is located at sector 0x200 and the TPL+SPL is
> located at sector 64, the combined size of TPL+SPL cannot take up more
> than 224KiB:
> 	(0x200 - 64) x 512 = 0x38000 (224 KiB)
>
> Adjust SPL_PAD_TO to match the used 0x200 sector offset.
>
> While at it, update the px30-ringneck-u-boot.dtsi to remove the now
> unnecessary override of simple-bin:fit:offset since SPL_PAD_TO matches
> with the current formula.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi | 8 --------
>   configs/ringneck-px30_defconfig               | 2 +-
>   2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi b/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
> index e04766ad09c..29ea2763636 100644
> --- a/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
> @@ -15,14 +15,6 @@
>   	};
>   };
>   
> -&binman {
> -	simple-bin {
> -		fit {
> -			offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
> -		};
> -	};
> -};
> -
>   &emmc_clk {
>   	bootph-all;
>   };
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index dedf35d4347..a22d25e0089 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x20000
> -CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_PAD_TO=0x38000
>   CONFIG_SPL_BOARD_INIT=y
>   CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>
