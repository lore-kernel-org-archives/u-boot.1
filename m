Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489D7C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E88D8897B;
	Fri, 14 Jun 2024 11:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Dyq7LTrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262DF8897E; Fri, 14 Jun 2024 11:30:52 +0200 (CEST)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C791888962
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Dyq7LTrv0+qrxcknLD7sPKeybbTx6+iBXLgdpxfhVrXntcm7L/hXxKhFrhf7FUSV1eYVzkVzisK57eVsqYSjOq411QIrJdWOOruyaK912f6eOOw9zNvorCCeo184W7ekLzh0MCrtJe3UQ4nkfXV06ZL9kHQsBOAea6mtYb4L4co=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=aLjdIWayCjwKTxcPlgoOjQm2vidFbrEH/tHkLQqxK5c=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BE98A9006C5;
 Fri, 14 Jun 2024 17:30:09 +0800 (CST)
Message-ID: <af7b299b-9380-4097-b2b7-a9331edffa71@rock-chips.com>
Date: Fri, 14 Jun 2024 17:30:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: ringneck-px30: get closer to other
 Theobroma defconfigs
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, heiko@sntech.de
References: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
 <20240612-ringneck-bootd-v1-1-f0bc3816b822@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240612-ringneck-bootd-v1-1-f0bc3816b822@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU9JVktKH0oZTB1NT0xNS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a90161543d603a9kunmbe98a9006c5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Pzo6STNLSxQtGAgBURo*
 FBYaCxVVSlVKTEpDSE5MT0pKTU5LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhDT0g3Bg++
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


On 2024/6/12 22:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> RK3588 Jaguar and Tiger, and RK3399 Puma use standard boot with the full
> feature set, so let's do that as well for PX30 Ringneck.
>
> Disable support for unused OSes as Linux is the primary target.
>
> Enable a bunch of commands:
>   - boot/bootd
>   - erofs
>   - gpio
>   - iminfo
>   - imxtract
>   - itest
>   - pmic
>   - regulator
>   - sleep
>   - squashfs
>
> that could be useful and are also found in Jaguar and Tiger defconfigs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index dedf35d4347..a0c1fec0951 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -20,6 +20,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -34,12 +35,15 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>   CONFIG_SPL_ATF=y
>   # CONFIG_TPL_FRAMEWORK is not set
>   # CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
> -# CONFIG_CMD_BOOTD is not set
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_CMD_VBE is not set
> +# CONFIG_BOOTM_VXWORKS is not set
>   # CONFIG_CMD_ELF is not set
> -# CONFIG_CMD_IMI is not set
> -# CONFIG_CMD_XIMG is not set
>   # CONFIG_CMD_LZMADEC is not set
>   # CONFIG_CMD_UNZIP is not set
> +CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADB is not set
> @@ -47,9 +51,11 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> -# CONFIG_CMD_ITEST is not set
>   # CONFIG_CMD_SETEXPR is not set
> -# CONFIG_CMD_SLEEP is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_EROFS=y
> +CONFIG_CMD_SQUASHFS=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_ISO_PARTITION is not set
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>
