Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40619C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8057787F74;
	Thu, 14 Mar 2024 08:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ixTxyU+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E42587F6F; Thu, 14 Mar 2024 08:43:06 +0100 (CET)
Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com
 [220.197.31.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A520087F49
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ixTxyU+PsLaZgrOZARVIU0AGRw8laXDfbtdJE+WGqo884NuJhOxCRmd5QGOLzcjOIiuH4zuU3AOEcSM0ca94Z0YoRUW5te1ZFPL/AH4WXuAvGfchwXZUTU+0nbX7H6NqCK3GBnhJTQ9/TVES8gMjXy4o28uMxcfwP7ZAVMFR/XY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Ltl8nn9VVFNZ+XLPHMUF2YHIj4p5zYdLtK6OBTKoRow=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BB51D900335;
 Thu, 14 Mar 2024 15:42:55 +0800 (CST)
Message-ID: <f2945c13-c669-45b9-9d46-420c1376ed14@rock-chips.com>
Date: Thu, 14 Mar 2024 15:42:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: load env from boot MMC device
Content-Language: en-US
To: Ben Wolsieffer <benwolsieffer@gmail.com>, u-boot@lists.denx.de
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240308030051.370824-1-benwolsieffer@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240308030051.370824-1-benwolsieffer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk8eSVYdGh9MHktLTR4dTR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3bea050703a9kunmbb51d900335
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6Mzo5LjMVSy8#GAEDTBI5
 FCFPFCFVSlVKTEpLT0tJSkxNTE5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNT0lPNwY+
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


On 2024/3/8 11:00, Ben Wolsieffer wrote:
> Currently, if the environment is stored on an MMC device, the device
> number is hardcoded by CONFIG_SYS_MMC_ENV_DEV. This is problematic
> because many boards can choose between booting from an SD card or a
> removable eMMC. For example, the Rock64 defconfig sets
> CONFIG_SYS_MMC_ENV_DEV=1, which corresponds to the SD card. If an eMMC
> is used as the boot device and no SD card is installed, it is impossible
> to save the environment.
>
> To avoid this problem, we can choose the environment MMC device based on
> the boot device. The theobroma-systems boards already contain code to do
> this, so this commit simply moves it to the common Rockchip board file,
> with some refactoring. I also removed another implementation of
> mmc_get_env_dev() from tinker_rk3288 that performed MMC boot device
> detection by reading a bootrom register.
>
> This has been tested on a Rock64v2.
>
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> * Use #ifdef rather than if(CONFIG_IS_ENABLED(...))
> * Add a debug message if boot device is not found
>
>   arch/arm/mach-rockchip/board.c               | 31 ++++++++++++++++++++
>   board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
>   board/theobroma-systems/common/common.c      | 30 -------------------
>   3 files changed, 31 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 2620530e03..8aa09f44b3 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -6,6 +6,7 @@
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <dm/uclass-internal.h>
>   #include <efi_loader.h>
>   #include <fastboot.h>
>   #include <init.h>
> @@ -349,3 +350,33 @@ __weak int board_rng_seed(struct abuf *buf)
>   	return 0;
>   }
>   #endif
> +
> +int mmc_get_env_dev(void)
> +{
> +	int devnum;
> +	const char *boot_device;
> +	struct udevice *dev;
> +
> +#ifdef CONFIG_SYS_MMC_ENV_DEV
> +	devnum = CONFIG_SYS_MMC_ENV_DEV;
> +#else
> +	devnum = 0;
> +#endif
> +
> +	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
> +		return devnum;
> +	}
> +
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &dev)) {
> +		debug("%s: no U-Boot device found for %s\n", __func__, boot_device);
> +		return devnum;
> +	}
> +
> +	devnum = dev->seq_;
> +	debug("%s: get MMC env from mmc%d\n", __func__, devnum);
> +	return devnum;
> +}
> diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> index f85209c649..eff3a00c30 100644
> --- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
> +++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> @@ -11,8 +11,6 @@
>   #include <init.h>
>   #include <net.h>
>   #include <netdev.h>
> -#include <asm/arch-rockchip/bootrom.h>
> -#include <asm/io.h>
>   
>   static int get_ethaddr_from_eeprom(u8 *addr)
>   {
> @@ -38,13 +36,3 @@ int rk3288_board_late_init(void)
>   
>   	return 0;
>   }
> -
> -int mmc_get_env_dev(void)
> -{
> -	u32 bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> -
> -	if (bootdevice_brom_id == BROM_BOOTSOURCE_EMMC)
> -		return 0;
> -
> -	return 1;
> -}
> diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
> index 864bcdd46f..585da43884 100644
> --- a/board/theobroma-systems/common/common.c
> +++ b/board/theobroma-systems/common/common.c
> @@ -89,36 +89,6 @@ int setup_boottargets(void)
>   	return 0;
>   }
>   
> -int mmc_get_env_dev(void)
> -{
> -	const char *boot_device =
> -		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	struct udevice *devp;
> -
> -	if (!boot_device) {
> -		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> -		      __func__);
> -#ifdef CONFIG_SYS_MMC_ENV_DEV
> -		return CONFIG_SYS_MMC_ENV_DEV;
> -#else
> -		return 0;
> -#endif
> -	}
> -
> -	debug("%s: booted from %s\n", __func__, boot_device);
> -
> -	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> -#ifdef CONFIG_SYS_MMC_ENV_DEV
> -		return CONFIG_SYS_MMC_ENV_DEV;
> -#else
> -		return 0;
> -#endif
> -
> -	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
> -
> -	return devp->seq_;
> -}
> -
>   enum env_location arch_env_get_location(enum env_operation op, int prio)
>   {
>   	const char *boot_device =
