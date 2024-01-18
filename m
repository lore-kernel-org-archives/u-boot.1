Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03267C47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 03:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B61F87AB9;
	Thu, 18 Jan 2024 04:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GnPXycYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB4587B52; Thu, 18 Jan 2024 04:12:14 +0100 (CET)
Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com
 [220.197.31.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D2787B63
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GnPXycYNXgsax+/SPcduDgCsWlmIIgHLzaLcvUCedQA9yUhGvj++VGgNYUtx4xkoQm2OR+n3yaEhhCoo1uhvi68o2pGML2jtvSjDC/L92Fg3VUnL70+3PEIW2N4nyzI8PzmD1T2DK0NRrBvwIvN07ZGWXsz22VDGsVfPI69j+S4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=KARJy+rrCdCRHafzR+3vbgYrM1ZkgBFz1tq3/YiiPXA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 1051420397;
 Thu, 18 Jan 2024 11:11:55 +0800 (CST)
Message-ID: <6e7e2c0a-ab59-41de-b4fd-e0abaed8889e@rock-chips.com>
Date: Thu, 18 Jan 2024 11:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] rockchip: ringneck-px30/puma-rk3399: factor out
 storage medium selection
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240117-env_default_theobroma-v4-0-12019172b482@theobroma-systems.com>
 <20240117-env_default_theobroma-v4-3-12019172b482@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240117-env_default_theobroma-v4-3-12019172b482@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklLT1ZNSkoZGB8dGEodTUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1a8dc5b12eb6kusn1051420397
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6Fgw4LjwiFBFNThA#PRc6
 CzwaFBhVSlVKTEtOTk9MTkpNSk9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSklISzcG
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


On 2024/1/18 01:59, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Ringneck PX30 and Puma RK3399 both have the same expectation with regard
> to bootstd device order and U-Boot environment storage device, except
> that Puma RK3399 also supports SPI Flash.
>
> Let's move all of this into a common file where common logic can be put.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/common/common.c            | 147 +++++++++++++++++++
>   board/theobroma-systems/common/common.h            |  19 +++
>   board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
>   board/theobroma-systems/puma_rk3399/Makefile       |   3 +
>   board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 154 +-------------------
>   board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
>   board/theobroma-systems/ringneck_px30/Makefile     |   3 +
>   .../ringneck_px30/ringneck-px30.c                  | 155 +--------------------
>   8 files changed, 176 insertions(+), 307 deletions(-)
>
> diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
> new file mode 100644
> index 00000000000..eb21d4c4550
> --- /dev/null
> +++ b/board/theobroma-systems/common/common.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +#include <dm.h>
> +#include <env.h>
> +#include <env_internal.h>
> +#include <dm/uclass-internal.h>
> +
> +/*
> + * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
> + *
> + * If bootsource is uSD-card we can assume that we want to use the
> + * SD-Card instead of the eMMC as first boot_target for distroboot.
> + * We only want to swap the defaults and not any custom environment a
> + * user has set. We exit early if a changed boot_targets environment
> + * is detected.
> + */
> +int setup_boottargets(void)
> +{
> +	const char *boot_device =
> +		ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	char *env_default, *env;
> +
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> +		      __func__);
> +		return -1;
> +	}
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	env_default = env_get_default("boot_targets");
> +	env = env_get("boot_targets");
> +	if (!env) {
> +		debug("%s: boot_targets does not exist\n", __func__);
> +		return -1;
> +	}
> +	debug("%s: boot_targets current: %s - default: %s\n",
> +	      __func__, env, env_default);
> +
> +	if (strcmp(env_default, env) != 0) {
> +		debug("%s: boot_targets not default, don't change it\n",
> +		      __func__);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Make the default boot medium between SD Card and eMMC, the one that
> +	 * was used to load U-Boot proper. If SPI-NOR flash was used, keep
> +	 * original default order.
> +	 */
> +	struct udevice *devp;
> +
> +	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
> +		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
> +		      __func__, boot_device);
> +		return 0;
> +	}
> +
> +	char *mmc0, *mmc1;
> +
> +	mmc0 = strstr(env, "mmc0");
> +	mmc1 = strstr(env, "mmc1");
> +
> +	if (!mmc0 || !mmc1) {
> +		debug("%s: only one mmc boot_target found\n", __func__);
> +		return -1;
> +	}
> +
> +	/*
> +	 * If mmc0 comes first in the boot order and U-Boot proper was
> +	 * loaded from mmc1, swap mmc0 and mmc1 in the list.
> +	 * If mmc1 comes first in the boot order and U-Boot proper was
> +	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
> +	 */
> +	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
> +	    (mmc0 > mmc1 && devp->seq_ == 0)) {
> +		mmc0[3] = '1';
> +		mmc1[3] = '0';
> +		debug("%s: set boot_targets to: %s\n", __func__, env);
> +		env_set("boot_targets", env);
> +	}
> +
> +	return 0;
> +}
> +
> +int mmc_get_env_dev(void)
> +{
> +	const char *boot_device =
> +		ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	struct udevice *devp;
> +
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> +		      __func__);
> +#ifdef CONFIG_SYS_MMC_ENV_DEV
> +		return CONFIG_SYS_MMC_ENV_DEV;
> +#else
> +		return 0;
> +#endif
> +	}
> +
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> +#ifdef CONFIG_SYS_MMC_ENV_DEV
> +		return CONFIG_SYS_MMC_ENV_DEV;
> +#else
> +		return 0;
> +#endif
> +
> +	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
> +
> +	return devp->seq_;
> +}
> +
> +enum env_location arch_env_get_location(enum env_operation op, int prio)
> +{
> +	const char *boot_device =
> +		ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	struct udevice *devp;
> +
> +	if (prio > 0)
> +		return ENVL_UNKNOWN;
> +
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> +		      __func__);
> +		return ENVL_NOWHERE;
> +	}
> +
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, ofnode_path(boot_device), &devp))
> +		return ENVL_SPI_FLASH;
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> +		return ENVL_MMC;
> +
> +	printf("%s: No environment available: booted from %s but U-Boot config does not allow loading environment from it.",
> +	       __func__, boot_device);
> +
> +	return ENVL_NOWHERE;
> +}
> diff --git a/board/theobroma-systems/common/common.h b/board/theobroma-systems/common/common.h
> new file mode 100644
> index 00000000000..488313a2d86
> --- /dev/null
> +++ b/board/theobroma-systems/common/common.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * (C) Copyright 2023 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +/*
> + * setup_boottargets() - Swap mmc0 and mmc1 in boot_targets depending on U-Boot
> + * proper load medium.
> + *
> + * If bootsource is uSD-card we can assume that we want to use the
> + * SD-Card instead of the eMMC as first boot_target for distroboot.
> + * We only want to swap the defaults and not any custom environment a
> + * user has set. We exit early if a changed boot_targets environment
> + * is detected.
> + *
> + * Return:
> + * 0 if OK, -1 otherwise
> + */
> +int setup_boottargets(void);
> diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> index 1ec2dd72d6c..93f570fc4f9 100644
> --- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
> +++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> @@ -3,6 +3,7 @@ M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
>   M:	Klaus Goger <klaus.goger@theobroma-systems.com>
>   S:	Maintained
>   F:	board/theobroma-systems/puma_rk3399
> +F:	board/theobroma-systems/common
>   F:	include/configs/puma_rk3399.h
>   F:	arch/arm/dts/rk3399-puma.dts
>   F:	configs/puma-rk3399_defconfig
> diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
> index d962b56f111..edd61a35c1e 100644
> --- a/board/theobroma-systems/puma_rk3399/Makefile
> +++ b/board/theobroma-systems/puma_rk3399/Makefile
> @@ -5,3 +5,6 @@
>   #
>   
>   obj-y	+= puma-rk3399.o
> +ifneq ($(CONFIG_SPL_BUILD),y)
> +obj-y	+= ../common/common.o
> +endif
> diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> index b8b718da243..a82f97b2d54 100644
> --- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> +++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
> @@ -3,28 +3,15 @@
>    * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
>   #include <dm.h>
> -#include <env.h>
> -#include <env_internal.h>
> -#include <init.h>
> -#include <log.h>
> -#include <misc.h>
> -#include <spl.h>
>   #include <syscon.h>
> -#include <u-boot/crc.h>
> -#include <usb.h>
>   #include <dm/pinctrl.h>
> -#include <dm/uclass-internal.h>
>   #include <asm/io.h>
> -#include <asm/setup.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
> -#include <asm/arch-rockchip/periph.h>
>   #include <asm/arch-rockchip/misc.h>
> -#include <power/regulator.h>
> -#include <u-boot/sha256.h>
> +#include "../common/common.h"
>   
>   static void setup_iodomain(void)
>   {
> @@ -40,145 +27,6 @@ static void setup_iodomain(void)
>   	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
>   }
>   
> -/*
> - * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
> - *
> - * If bootsource is uSD-card we can assume that we want to use the
> - * SD-Card instead of the eMMC as first boot_target for distroboot.
> - * We only want to swap the defaults and not any custom environment a
> - * user has set. We exit early if a changed boot_targets environment
> - * is detected.
> - */
> -static int setup_boottargets(void)
> -{
> -	const char *boot_device =
> -		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	char *env_default, *env;
> -
> -	if (!boot_device) {
> -		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> -		      __func__);
> -		return -1;
> -	}
> -	debug("%s: booted from %s\n", __func__, boot_device);
> -
> -	env_default = env_get_default("boot_targets");
> -	env = env_get("boot_targets");
> -	if (!env) {
> -		debug("%s: boot_targets does not exist\n", __func__);
> -		return -1;
> -	}
> -	debug("%s: boot_targets current: %s - default: %s\n",
> -	      __func__, env, env_default);
> -
> -	if (strcmp(env_default, env) != 0) {
> -		debug("%s: boot_targets not default, don't change it\n",
> -		      __func__);
> -		return 0;
> -	}
> -
> -	/*
> -	 * Make the default boot medium between SD Card and eMMC, the one that
> -	 * was used to load U-Boot proper. If SPI-NOR flash was used, keep
> -	 * original default order.
> -	 */
> -	struct udevice *devp;
> -
> -	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
> -		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
> -		      __func__, boot_device);
> -		return 0;
> -	}
> -
> -	char *mmc0, *mmc1;
> -
> -	mmc0 = strstr(env, "mmc0");
> -	mmc1 = strstr(env, "mmc1");
> -
> -	if (!mmc0 || !mmc1) {
> -		debug("%s: only one mmc boot_target found\n", __func__);
> -		return -1;
> -	}
> -
> -	/*
> -	 * If mmc0 comes first in the boot order and U-Boot proper was
> -	 * loaded from mmc1, swap mmc0 and mmc1 in the list.
> -	 * If mmc1 comes first in the boot order and U-Boot proper was
> -	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
> -	 */
> -	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
> -	    (mmc0 > mmc1 && devp->seq_ == 0)) {
> -		mmc0[3] = '1';
> -		mmc1[3] = '0';
> -		debug("%s: set boot_targets to: %s\n", __func__, env);
> -		env_set("boot_targets", env);
> -	}
> -
> -	return 0;
> -}
> -
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
> -enum env_location arch_env_get_location(enum env_operation op, int prio)
> -{
> -	const char *boot_device =
> -		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	struct udevice *devp;
> -
> -	if (prio > 0)
> -		return ENVL_UNKNOWN;
> -
> -	if (!boot_device) {
> -		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> -		      __func__);
> -		return ENVL_NOWHERE;
> -	}
> -
> -	debug("%s: booted from %s\n", __func__, boot_device);
> -
> -	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
> -	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, ofnode_path(boot_device), &devp))
> -		return ENVL_SPI_FLASH;
> -
> -	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> -	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> -		return ENVL_MMC;
> -
> -	printf("%s: No environment available: booted from %s but U-Boot "
> -	       "config does not allow loading environment from it.",
> -	       __func__, boot_device);
> -
> -	return ENVL_NOWHERE;
> -}
> -
>   int misc_init_r(void)
>   {
>   	const u32 cpuid_offset = 0x7;
> diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> index d764e26066c..06e1beaab14 100644
> --- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
> +++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> @@ -3,6 +3,7 @@ M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
>   M:	Klaus Goger <klaus.goger@theobroma-systems.com>
>   S:	Maintained
>   F:	board/theobroma-systems/ringneck_px30
> +F:	board/theobroma-systems/common
>   F:	include/configs/ringneck_px30.h
>   F:	arch/arm/dts/px30-ringneck*
>   F:	configs/ringneck-px30_defconfig
> diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
> index 31ada1a6942..45cc65baf9a 100644
> --- a/board/theobroma-systems/ringneck_px30/Makefile
> +++ b/board/theobroma-systems/ringneck_px30/Makefile
> @@ -5,3 +5,6 @@
>   #
>   
>   obj-y	+= ringneck-px30.o
> +ifneq ($(CONFIG_SPL_BUILD),y)
> +obj-y	+= ../common/common.o
> +endif
> diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> index 5d2c76ab902..ff7e414303d 100644
> --- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> +++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> @@ -3,163 +3,10 @@
>    * (C) Copyright 2022 Theobroma Systems Design und Consulting GmbH
>    */
>   
> -#include <common.h>
> -#include <dm.h>
> -#include <env.h>
> -#include <env_internal.h>
> -#include <init.h>
> -#include <log.h>
> -#include <misc.h>
> -#include <spl.h>
> -#include <syscon.h>
> -#include <u-boot/crc.h>
> -#include <usb.h>
> -#include <dm/pinctrl.h>
> -#include <dm/uclass-internal.h>
>   #include <asm/gpio.h>
> -#include <asm/io.h>
> -#include <asm/setup.h>
> -#include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/periph.h>
>   #include <asm/arch-rockchip/misc.h>
>   #include <linux/delay.h>
> -#include <power/regulator.h>
> -#include <u-boot/sha256.h>
> -
> -/*
> - * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
> - *
> - * If bootsource is uSD-card we can assume that we want to use the
> - * SD-Card instead of the eMMC as first boot_target for distroboot.
> - * We only want to swap the defaults and not any custom environment a
> - * user has set. We exit early if a changed boot_targets environment
> - * is detected.
> - */
> -static int setup_boottargets(void)
> -{
> -	const char *boot_device =
> -		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	char *env_default, *env;
> -
> -	if (!boot_device) {
> -		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> -		      __func__);
> -		return -1;
> -	}
> -	debug("%s: booted from %s\n", __func__, boot_device);
> -
> -	env_default = env_get_default("boot_targets");
> -	env = env_get("boot_targets");
> -	if (!env) {
> -		debug("%s: boot_targets does not exist\n", __func__);
> -		return -1;
> -	}
> -	debug("%s: boot_targets current: %s - default: %s\n",
> -	      __func__, env, env_default);
> -
> -	if (strcmp(env_default, env) != 0) {
> -		debug("%s: boot_targets not default, don't change it\n",
> -		      __func__);
> -		return 0;
> -	}
> -
> -	/*
> -	 * Make the default boot medium between SD Card and eMMC, the one that
> -	 * was used to load U-Boot proper.
> -	 */
> -	struct udevice *devp;
> -
> -	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
> -		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
> -		      __func__, boot_device);
> -		return 0;
> -	}
> -
> -	char *mmc0, *mmc1;
> -
> -	mmc0 = strstr(env, "mmc0");
> -	mmc1 = strstr(env, "mmc1");
> -
> -	if (!mmc0 || !mmc1) {
> -		debug("%s: only one mmc boot_target found\n", __func__);
> -		return -1;
> -	}
> -
> -	/*
> -	 * If mmc0 comes first in the boot order and U-Boot proper was
> -	 * loaded from mmc1, swap mmc0 and mmc1 in the list.
> -	 * If mmc1 comes first in the boot order and U-Boot proper was
> -	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
> -	 */
> -	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
> -	    (mmc0 > mmc1 && devp->seq_ == 0)) {
> -		mmc0[3] = '1';
> -		mmc1[3] = '0';
> -		debug("%s: set boot_targets to: %s\n", __func__, env);
> -		env_set("boot_targets", env);
> -	}
> -
> -	return 0;
> -}
> -
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
> -enum env_location arch_env_get_location(enum env_operation op, int prio)
> -{
> -	const char *boot_device =
> -		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	struct udevice *devp;
> -
> -	if (prio > 0)
> -		return ENVL_UNKNOWN;
> -
> -	if (!boot_device) {
> -		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> -		      __func__);
> -		return ENVL_NOWHERE;
> -	}
> -
> -	debug("%s: booted from %s\n", __func__, boot_device);
> -
> -	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> -	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> -		return ENVL_MMC;
> -
> -	printf("%s: No environment available: booted from %s but U-Boot "
> -	       "config does not allow loading environment from it.",
> -	       __func__, boot_device);
> -
> -	return ENVL_NOWHERE;
> -}
> +#include "../common/common.h"
>   
>   int misc_init_r(void)
>   {
>
