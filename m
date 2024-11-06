Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9157D44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4760E88FE5;
	Wed,  6 Nov 2024 11:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ElLjsAOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72305891CE; Wed,  6 Nov 2024 11:22:26 +0100 (CET)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF0B88B0C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8011ce;
 Wed, 6 Nov 2024 18:22:20 +0800 (GMT+08:00)
Message-ID: <14d660e7-fe67-4fdf-bc08-bae9127f23a3@rock-chips.com>
Date: Wed, 6 Nov 2024 18:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] rockchip: rk3288-tinker: Drop USE_PREBOOT Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08dTlZOQ00YQxgdH0hMHkpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300ff237403afkunm1f8011ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Fyo4NjIsDjEtTg0*TBIp
 KCoKCUtVSlVKTEhLQ0NDTk9KQ01PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTExCNwY+
DKIM-Signature: a=rsa-sha256;
 b=ElLjsAOlcgT5gEDodXtCQqRqKCGEpsnIOnD1jdnrY/fd/shF6FmyN4/djoh8JrOdLaSY6GWYNsisemS+ZhIzCPIQjwS6dL5EuzsxEeCVFTtkNETp1h11LZHSeVWaFzmWfwHODTwXIDaDs7iXzqf9vx9FFsi1pRk6jJhV/0eS32k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Y3XT7jUcQFOlV/RBjTO35aFo1UZwnWAmfQvpekOTx20=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> After the migration to use standard boot, storage media should
> automatically be initialized in the order listed in boot_targets env.
>
> Drop USE_PREBOOT to speed up boot with ~12 seconds when booting from
> e.g. SD-card or eMMC.
>
> Before:
>
>    3,048,599      2,056  main_loop
>    3,050,717      2,118  usb_start
>   15,070,499 12,019,782  cli_loop
>
> After:
>
>    3,058,244      2,054  main_loop
>    3,063,260      5,016  cli_loop
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/tinker-rk3288_defconfig   | 1 -
>   configs/tinker-s-rk3288_defconfig | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index fb42b8bcb00d..1007d9ca9e15 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -17,7 +17,6 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index f3a392688f02..47d089ff4780 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -17,7 +17,6 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
