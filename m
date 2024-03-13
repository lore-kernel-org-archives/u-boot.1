Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A3C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 18:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4D387E63;
	Wed, 13 Mar 2024 19:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7616887E9B; Wed, 13 Mar 2024 19:42:08 +0100 (CET)
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs
 [93.87.244.166]) by phobos.denx.de (Postfix) with ESMTP id 063B687DE3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 19:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id CD3685060;
 Thu, 01 Jan 1970 00:09:05 +0000 (UTC)
Date: Wed, 13 Mar 2024 19:42:06 +0100
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Nam Cao <namcao@linutronix.de>
Cc: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 chanho61.park@samsung.com, wiagn233@outlook.com, sjg@chromium.org,
 inindev@gmail.com, rick@andestech.com, bmeng@tinylab.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH] starfive: visionfive2: switch to standard boot
Message-ID: <20240313184206.GA20322@m1pro.arvanta.net>
References: <20240221120014.149193-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221120014.149193-1-namcao@linutronix.de>
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

On Wed, 2024-02-21 at 13:00, Nam Cao wrote:
> Distro boot scripts are deprecated. Use standard boot instead.
I had to enable 'CONFIG_CMD_SYSBOOT=y' in
configs/starfive_visionfive2_defconfig because it doesn't boot without
it. With this option it boots fine with this patch.
Tested on u-boot version 2024.04-rc4-dirty

> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  configs/starfive_visionfive2_defconfig |  2 +-
>  include/configs/starfive-visionfive2.h | 14 +-------------
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index b11be7ac86..aec751f871 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -31,8 +31,8 @@ CONFIG_RISCV_SMODE=y
>  # CONFIG_OF_BOARD_FIXUP is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_FIT=y
> +CONFIG_BOOTSTD_DEFAULTS=y
>  CONFIG_SYS_BOOTM_LEN=0x4000000
> -CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTSTAGE=y
>  CONFIG_QSPI_BOOT=y
>  CONFIG_SD_BOOT=y
> diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
> index 29c74470c7..049b0a0630 100644
> --- a/include/configs/starfive-visionfive2.h
> +++ b/include/configs/starfive-visionfive2.h
> @@ -15,17 +15,6 @@
>  
>  #define __io
>  
> -/* Environment options */
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	func(NVME, nvme, 0) \
> -	func(USB, usb, 0) \
> -	func(MMC, mmc, 0) \
> -	func(MMC, mmc, 1) \
> -	func(DHCP, dhcp, na)
> -
> -#include <config_distro_bootcmd.h>
> -
>  #define TYPE_GUID_SPL		"2E54B353-1271-4842-806F-E436D6AF6985"
>  #define TYPE_GUID_UBOOT	"BC13C2FF-59E6-4262-A352-B275FD6F7172"
>  #define TYPE_GUID_SYSTEM	"EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"
> @@ -48,7 +37,6 @@
>  	"type_guid_gpt_loader2=" TYPE_GUID_UBOOT "\0" \
>  	"type_guid_gpt_system=" TYPE_GUID_SYSTEM "\0" \
>  	"partitions=" PARTS_DEFAULT "\0" \
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	BOOTENV
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"
>  
>  #endif /* _STARFIVE_VISIONFIVE2_H */
