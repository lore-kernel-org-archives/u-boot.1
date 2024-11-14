Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF46D65C57
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 08:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D249895DA;
	Thu, 14 Nov 2024 09:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="TuNuCpRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2446A895D8; Thu, 14 Nov 2024 09:40:00 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAEA6895D4
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CqsAgOMsrVDuwC4sMo5/ThKdqtaogcMW8Ab6lcbwHuw=; b=TuNuCpRjMiXx3FhbVYC99WQqWv
 YpmoLLL4TEm/WQkr21YprxXdpmW1bohGdvcG+7HB4qpF0iEqyUAyC0dBexIgoRjo7wMN6MOiiGpi+
 C2Www36NTHq4XAQISwm62S2ZtKB3yKU13iNQtQAWHytlVz7OYdyREdykhQjI+WEQAOlLgF5kNEUV+
 nLTbZ2BSmz88diV8s+nzMcf1Yu8dFO9W7J65G0fWGIjwi3nG6EcqIHLyTOj8/hpH1rIDyjx8VorCY
 v2brWRwpO1iEqHIvSjvB+d4uV77PJix28/gz/KKUsJ90YD1q6nIf+SufoAor/XracG2nJ3HuA6qNA
 IiLqOmdA==;
Received: from [89.212.21.243] (port=51042 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1tBVOP-00AA18-0k;
 Thu, 14 Nov 2024 09:39:56 +0100
Message-ID: <4f65f0a2-d0f7-4b0c-934f-d32c0a36be11@norik.com>
Date: Thu, 14 Nov 2024 09:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
To: Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>, Andrej Picej <andrej.picej@norik.com>,
 Wadim Egorov <w.egorov@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20241113160037.65679-4-c.stoidner@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Christoph,

this patch doesn't apply anymore on latest master.

Can you please rebase for v3?

Then I can test it on the board.

Thanks,
BR,
Primoz

On 13. 11. 24 17:00, Christoph Stoidner wrote:
> The phyCORE-i.MX 93 is available in various variants (e.g. different ram
> sizes, eMMC HS400 yes/no). Enable hardware introspection for the
> imx93-phyboard-segin_defconfig, so that during startup the SOM module
> variant can be detected, and the hardware can be configured accordingly.
> The resulting SPL and u-boot binary shall able to boot each
> phyCORE-i.MX 93 module variant on each carrier board. Finally rename
> imx93-phyboard-segin_defconfig to imx93-phycore_defconfig, to highlight
> its SOM scope.
> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
> ---
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: Primoz Fiser <primoz.fiser@norik.com>
> Cc: Andrej Picej <andrej.picej@norik.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> ---
> Changes in v2:
> - just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
>   instead of creating an entirely new second defconfig
> - remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
> - improve commit message
> 
>  arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi               | 6 ++++--
>  board/phytec/phycore_imx93/MAINTAINERS                      | 2 +-
>  ...x93-phyboard-segin_defconfig => imx93-phycore_defconfig} | 4 +++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>  rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
> 
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> index 25c778bb07..2245461032 100644
> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -2,15 +2,17 @@
>  /*
>   * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>   * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>   *
>   * Product homepage:
> - * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> - * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> +   https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
>   */
>  
>  #include "imx93-u-boot.dtsi"
>  
>  / {
> +	model = "PHYTEC phyCORE-i.MX93";
> +
>  	wdt-reboot {
>  		compatible = "wdt-reboot";
>  		wdt = <&wdog3>;
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> index cea817ffdc..718f89a084 100644
> --- a/board/phytec/phycore_imx93/MAINTAINERS
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -9,5 +9,5 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>  F:      board/phytec/phycore_imx93/
>  F:      board/phytec/common/imx93_som_detection.c
>  F:      board/phytec/common/imx93_som_detection.h
> -F:      configs/imx93-phyboard-segin_defconfig
> +F:      configs/imx93-phycore_defconfig
>  F:      include/configs/phycore_imx93.h
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phycore_defconfig
> similarity index 98%
> rename from configs/imx93-phyboard-segin_defconfig
> rename to configs/imx93-phycore_defconfig
> index 18a4087e4b..cf9800118a 100644
> --- a/configs/imx93-phyboard-segin_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -6,13 +6,13 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
>  CONFIG_NR_DRAM_BANKS=2
> +CONFIG_PHYTEC_SOM_DETECTION=y
>  CONFIG_ENV_SOURCE_FILE="phycore_imx93"
>  CONFIG_ENV_SIZE=0x10000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>  CONFIG_DM_GPIO=y
>  CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> -CONFIG_SPL_TEXT_BASE=0x2049A000
>  CONFIG_AHAB_BOOT=y
>  CONFIG_TARGET_PHYCORE_IMX93=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
>  CONFIG_SPL_SERIAL=y
>  CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_SPL_STACK=0x20519dd0
> +CONFIG_SPL_TEXT_BASE=0x2049A000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>  CONFIG_SPL_BSS_START_ADDR=0x2051a000
>  CONFIG_SPL_BSS_MAX_SIZE=0x2000
> @@ -31,6 +32,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>  CONFIG_SYS_MEMTEST_START=0x80000000
>  CONFIG_SYS_MEMTEST_END=0x90000000
>  CONFIG_REMAKE_ELF=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_OF_SYSTEM_SETUP=y
>  CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"

-- 
Primoz Fiser                    | phone: +386-41-390-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |

