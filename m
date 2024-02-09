Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5084EC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 17:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C038187E7C;
	Fri,  9 Feb 2024 18:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="YXCLXJmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E41F87E71; Fri,  9 Feb 2024 18:58:05 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB9087E82
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707501482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r99syV6rgUMzY3xCpSFAP6s72a09G/Cx+jb1ACb0gw=;
 b=YXCLXJmE9blyErrc3tjxd3jGIsRG4lSjpOrLHGi1NemsNIAyN6zPv/Nh1jU9JfYjeJgGod
 +MVkIh30d3r/RrbS86xjwWptVve3BMsDqlHLwHdgk442lCdEVO71jp/JkNK2WQ4nyB6pJB
 IhnKC41H+i3Q+vM1SV9+FnYaC84o8GeZjKg+2j9d8uzPgRDhhJjaehHP7ghStIm8BO0iBf
 iWA+lRAALuvKYNNrNGSCoO04rrTg3kaKlZxjVKIYAzi9piagIEAIfHNorRTiknmG/607lS
 1GgA6yj6eYAxuzLq8fCZEaUmAubek1IOxSMT6buImpEvbabAw4UicKGvPumE+Q==
Date: Fri, 09 Feb 2024 18:58:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 09/20] rockchip: merge misc.c into board.c
In-Reply-To: <20240209-jaguar-v2-9-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-9-6c9ffe09b924@theobroma-systems.com>
Message-ID: <64ed7a21fa952a3dd9cc76a9cc90216e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

Please, see my comments below.

On 2024-02-09 10:50, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The functions aren't used anywhere else than in board.c, therefore,
> let's not expose them anymore at all.
> 
> This merges misc.c and board.c together and removes the functions from
> the misc.h header file.

The patches I'm going to send, which exclude the unneeded code
from the U-Boot images for the Pinebook Pro and the Pinebook Pro,
change the code that this patch moves around.

Perhaps it would be better to have the move of the code and the
subsequent changes to it performed in a separate series, to make
checking and accepting the patches simpler as a group, and to
perhaps make it a bit more clear what actually happened to anyone
going through the repository history later.

Thus, I was wondering would you, please, be fine with excluding
this patch from this series and letting me submit it, with proper
attribution tags, of course, as part of the series I'll submit
in the next couple of days?

> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/include/asm/arch-rockchip/misc.h |   5 --
>  arch/arm/mach-rockchip/Makefile           |   1 -
>  arch/arm/mach-rockchip/board.c            | 125 
> +++++++++++++++++++++++++++
>  arch/arm/mach-rockchip/misc.c             | 135 
> ------------------------------
>  4 files changed, 125 insertions(+), 141 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/misc.h
> b/arch/arm/include/asm/arch-rockchip/misc.h
> index 4155af8c3b0..ef37ff1661a 100644
> --- a/arch/arm/include/asm/arch-rockchip/misc.h
> +++ b/arch/arm/include/asm/arch-rockchip/misc.h
> @@ -6,9 +6,4 @@
>   *      Rohan Garg <rohan.garg@collabora.com>
>   */
> 
> -int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> -			      const u32 cpuid_length,
> -			      u8 *cpuid);
> -int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
> -int rockchip_setup_macaddr(void);
>  void rockchip_capsule_update_board_setup(void);
> diff --git a/arch/arm/mach-rockchip/Makefile 
> b/arch/arm/mach-rockchip/Makefile
> index 1dc92066bbf..c07bdaee4c3 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -23,7 +23,6 @@ ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
>  # meaning "turn it off".
>  obj-y += boot_mode.o
>  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> -obj-$(CONFIG_MISC_INIT_R) += misc.o
>  endif
> 
>  ifeq ($(CONFIG_TPL_BUILD),)
> diff --git a/arch/arm/mach-rockchip/board.c 
> b/arch/arm/mach-rockchip/board.c
> index d5cb59c10fa..80b4514852f 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -1,20 +1,32 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
> + *
> + * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> + *      Rohan Garg <rohan.garg@collabora.com>
> + *
> + * Based on puma-rk3399.c:
> + *      (C) Copyright 2017 Theobroma Systems Design und Consulting 
> GmbH
>   */
>  #include <common.h>
>  #include <clk.h>
>  #include <cpu_func.h>
> +#include <env.h>
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <fastboot.h>
> +#include <hash.h>
>  #include <init.h>
>  #include <log.h>
>  #include <mmc.h>
> +#include <dm/uclass-internal.h>
> +#include <misc.h>
>  #include <part.h>
>  #include <ram.h>
>  #include <syscon.h>
>  #include <uuid.h>
> +#include <u-boot/crc.h>
> +#include <u-boot/sha256.h>
>  #include <asm/cache.h>
>  #include <asm/io.h>
>  #include <asm/arch-rockchip/boot_mode.h>
> @@ -297,6 +309,119 @@ int fastboot_set_reboot_flag(enum
> fastboot_reboot_reason reason)
>  #endif
> 
>  #ifdef CONFIG_MISC_INIT_R
> +int rockchip_setup_macaddr(void)
> +{
> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
> +	int ret;
> +	const char *cpuid = env_get("cpuid#");
> +	u8 hash[SHA256_SUM_LEN];
> +	int size = sizeof(hash);
> +	u8 mac_addr[6];
> +
> +	/* Only generate a MAC address, if none is set in the environment */
> +	if (env_get("ethaddr"))
> +		return 0;
> +
> +	if (!cpuid) {
> +		debug("%s: could not retrieve 'cpuid#'\n", __func__);
> +		return -1;
> +	}
> +
> +	ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash, 
> &size);
> +	if (ret) {
> +		debug("%s: failed to calculate SHA256\n", __func__);
> +		return -1;
> +	}
> +
> +	/* Copy 6 bytes of the hash to base the MAC address on */
> +	memcpy(mac_addr, hash, 6);
> +
> +	/* Make this a valid MAC address and set it */
> +	mac_addr[0] &= 0xfe;  /* clear multicast bit */
> +	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
> +	eth_env_set_enetaddr("ethaddr", mac_addr);
> +
> +	/* Make a valid MAC address for ethernet1 */
> +	mac_addr[5] ^= 0x01;
> +	eth_env_set_enetaddr("eth1addr", mac_addr);
> +#endif
> +	return 0;
> +}
> +
> +int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> +			      const u32 cpuid_length,
> +			      u8 *cpuid)
> +{
> +#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || 
> IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> +	struct udevice *dev;
> +	int ret;
> +
> +	/* retrieve the device */
> +#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_efuse), &dev);
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +#endif
> +	if (ret) {
> +		debug("%s: could not find efuse device\n", __func__);
> +		return -1;
> +	}
> +
> +	/* read the cpu_id range from the efuses */
> +	ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
> +	if (ret < 0) {
> +		debug("%s: reading cpuid from the efuses failed\n",
> +		      __func__);
> +		return -1;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
> +{
> +	u8 low[cpuid_length / 2], high[cpuid_length / 2];
> +	char cpuid_str[cpuid_length * 2 + 1];
> +	u64 serialno;
> +	char serialno_str[17];
> +	const char *oldid;
> +	int i;
> +
> +	memset(cpuid_str, 0, sizeof(cpuid_str));
> +	for (i = 0; i < cpuid_length; i++)
> +		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
> +
> +	debug("cpuid: %s\n", cpuid_str);
> +
> +	/*
> +	 * Mix the cpuid bytes using the same rules as in
> +	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
> +	 */
> +	for (i = 0; i < cpuid_length / 2; i++) {
> +		low[i] = cpuid[1 + (i << 1)];
> +		high[i] = cpuid[i << 1];
> +	}
> +
> +	serialno = crc32_no_comp(0, low, cpuid_length / 2);
> +	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 
> 32;
> +	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
> +
> +	oldid = env_get("cpuid#");
> +	if (oldid && strcmp(oldid, cpuid_str) != 0)
> +		printf("cpuid: value %s present in env does not match hardware 
> %s\n",
> +		       oldid, cpuid_str);
> +
> +	env_set("cpuid#", cpuid_str);
> +
> +	/* Only generate serial# when none is set yet */
> +	if (!env_get("serial#"))
> +		env_set("serial#", serialno_str);
> +
> +	return 0;
> +}
> +
>  __weak int rockchip_early_misc_init_r(void)
>  {
>  	return 0;
> diff --git a/arch/arm/mach-rockchip/misc.c 
> b/arch/arm/mach-rockchip/misc.c
> deleted file mode 100644
> index 15397cff009..00000000000
> --- a/arch/arm/mach-rockchip/misc.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * RK3399: Architecture common definitions
> - *
> - * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> - *      Rohan Garg <rohan.garg@collabora.com>
> - *
> - * Based on puma-rk3399.c:
> - *      (C) Copyright 2017 Theobroma Systems Design und Consulting 
> GmbH
> - */
> -
> -#include <common.h>
> -#include <env.h>
> -#include <dm.h>
> -#include <hash.h>
> -#include <log.h>
> -#include <dm/uclass-internal.h>
> -#include <misc.h>
> -#include <u-boot/crc.h>
> -#include <u-boot/sha256.h>
> -
> -#include <asm/arch-rockchip/misc.h>
> -
> -int rockchip_setup_macaddr(void)
> -{
> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
> -	int ret;
> -	const char *cpuid = env_get("cpuid#");
> -	u8 hash[SHA256_SUM_LEN];
> -	int size = sizeof(hash);
> -	u8 mac_addr[6];
> -
> -	/* Only generate a MAC address, if none is set in the environment */
> -	if (env_get("ethaddr"))
> -		return 0;
> -
> -	if (!cpuid) {
> -		debug("%s: could not retrieve 'cpuid#'\n", __func__);
> -		return -1;
> -	}
> -
> -	ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash, 
> &size);
> -	if (ret) {
> -		debug("%s: failed to calculate SHA256\n", __func__);
> -		return -1;
> -	}
> -
> -	/* Copy 6 bytes of the hash to base the MAC address on */
> -	memcpy(mac_addr, hash, 6);
> -
> -	/* Make this a valid MAC address and set it */
> -	mac_addr[0] &= 0xfe;  /* clear multicast bit */
> -	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
> -	eth_env_set_enetaddr("ethaddr", mac_addr);
> -
> -	/* Make a valid MAC address for ethernet1 */
> -	mac_addr[5] ^= 0x01;
> -	eth_env_set_enetaddr("eth1addr", mac_addr);
> -#endif
> -	return 0;
> -}
> -
> -int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> -			      const u32 cpuid_length,
> -			      u8 *cpuid)
> -{
> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || 
> IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> -	struct udevice *dev;
> -	int ret;
> -
> -	/* retrieve the device */
> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
> -	ret = uclass_get_device_by_driver(UCLASS_MISC,
> -					  DM_DRIVER_GET(rockchip_efuse), &dev);
> -#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> -	ret = uclass_get_device_by_driver(UCLASS_MISC,
> -					  DM_DRIVER_GET(rockchip_otp), &dev);
> -#endif
> -	if (ret) {
> -		debug("%s: could not find efuse device\n", __func__);
> -		return -1;
> -	}
> -
> -	/* read the cpu_id range from the efuses */
> -	ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
> -	if (ret < 0) {
> -		debug("%s: reading cpuid from the efuses failed\n",
> -		      __func__);
> -		return -1;
> -	}
> -#endif
> -	return 0;
> -}
> -
> -int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
> -{
> -	u8 low[cpuid_length / 2], high[cpuid_length / 2];
> -	char cpuid_str[cpuid_length * 2 + 1];
> -	u64 serialno;
> -	char serialno_str[17];
> -	const char *oldid;
> -	int i;
> -
> -	memset(cpuid_str, 0, sizeof(cpuid_str));
> -	for (i = 0; i < cpuid_length; i++)
> -		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
> -
> -	debug("cpuid: %s\n", cpuid_str);
> -
> -	/*
> -	 * Mix the cpuid bytes using the same rules as in
> -	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
> -	 */
> -	for (i = 0; i < cpuid_length / 2; i++) {
> -		low[i] = cpuid[1 + (i << 1)];
> -		high[i] = cpuid[i << 1];
> -	}
> -
> -	serialno = crc32_no_comp(0, low, cpuid_length / 2);
> -	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 
> 32;
> -	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
> -
> -	oldid = env_get("cpuid#");
> -	if (oldid && strcmp(oldid, cpuid_str) != 0)
> -		printf("cpuid: value %s present in env does not match hardware 
> %s\n",
> -		       oldid, cpuid_str);
> -
> -	env_set("cpuid#", cpuid_str);
> -
> -	/* Only generate serial# when none is set yet */
> -	if (!env_get("serial#"))
> -		env_set("serial#", serialno_str);
> -
> -	return 0;
> -}
