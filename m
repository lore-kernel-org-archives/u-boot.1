Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D0C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0069877F9;
	Tue,  9 Jan 2024 14:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GCA9h1de";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C843D87800; Tue,  9 Jan 2024 14:09:06 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881B5807EC
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 3723DB81A56;
 Tue,  9 Jan 2024 13:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38360C433C7;
 Tue,  9 Jan 2024 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704805743;
 bh=OqUHZvLdtdQ6KYfZRlQlK0CGpWZ9Cky92VHj1Ts3fnA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GCA9h1deE8Pd3rv3UNsdoD5vYMCfWudiWz7CFXYyIuuw54UEfYE8nqQ3N+aTJbVXO
 6geZQ5p3jGmF/6wKz2RDvNvDPo8tuW7Lm6TOk2jHC6PLOJNrLJKJzq3ieXFxdl+B9I
 JTT5o0meG8+tUV+XwoQ86/6YVnNxpwjIHo67WPNGInrKlWi9Vb56qZucHs2jxoegnu
 1dp3p4gBFNc7i+Q6YOV9NsV2Hc81JAPMngm/0Y2jTJcHGIDv83qMEe0knSTcUWyIYo
 b2NWy9lheDGoBOM8DUhQl7TpxS9/JHLWr2E0Ykbqxrug+1mW17ZD5O8GDCMsZO2Lwf
 CF/O+CME0QUww==
Message-ID: <59043a79-8199-4319-a9c0-eb2bc8d55a77@kernel.org>
Date: Tue, 9 Jan 2024 15:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] board: ti: common: Introduce a common fdt ops
 library
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-2-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240108173301.2692332-2-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 08/01/2024 19:32, Nishanth Menon wrote:
> Introduce a common fdt operations library for basic device tree
> operations that are common between various boards.
> 
> The first library to introduce here is the capability to set up
> fdtfile as a standard variable as part of board identification rather
> than depend on scripted ifdeffery.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  board/ti/common/Kconfig   | 12 ++++++++
>  board/ti/common/Makefile  |  1 +
>  board/ti/common/fdt_ops.c | 65 +++++++++++++++++++++++++++++++++++++++
>  board/ti/common/fdt_ops.h | 41 ++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)
>  create mode 100644 board/ti/common/fdt_ops.c
>  create mode 100644 board/ti/common/fdt_ops.h
> 
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index 49edd98014ab..06a8a36aa1cd 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -49,3 +49,15 @@ config TI_COMMON_CMD_OPTIONS
>  	imply CMD_SPI
>  	imply CMD_TIME
>  	imply CMD_USB if USB
> +
> +config TI_EVM_FDT_FOLDER_PATH
> +	string "Location of Folder path where dtb is present"
> +	default "ti/davinci" if ARCH_DAVINCI
> +	default "ti/keystone" if ARCH_KEYSTONE
> +	default "ti/omap" if ARCH_OMAP2PLUS
> +	default "ti" if ARCH_K3
> +	depends on ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
> +	help
> +	   Folder path for kernel device tree default.
> +	   This is used along with fdtfile path to locate the kernel
> +	   device tree blob.
> diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
> index 26bf12e2e6d5..5ac361ba7fcf 100644
> --- a/board/ti/common/Makefile
> +++ b/board/ti/common/Makefile
> @@ -3,3 +3,4 @@
>  
>  obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
>  obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
> +obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
> diff --git a/board/ti/common/fdt_ops.c b/board/ti/common/fdt_ops.c
> new file mode 100644
> index 000000000000..f8770cae4a54
> --- /dev/null
> +++ b/board/ti/common/fdt_ops.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Library to support FDT file operations which are common
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <env.h>
> +#include <vsprintf.h>
> +#include "fdt_ops.h"
> +
> +void ti_set_fdt_env(const char *name_fdt, struct ti_fdt_map *fdt_map)
> +{
> +	char *fdt_file_name = NULL;
> +	char fdtfile[TI_FDT_FILE_MAX];
> +
> +	if (name_fdt) {
> +		while (fdt_map) {
> +			/* Check for NULL terminator in the list */
> +			if (!fdt_map->name_fdt)
> +				break;
> +			if (!strncmp(fdt_map->name_fdt, name_fdt, TI_NAME_FDT_MAX)) {
> +				fdt_file_name = fdt_map->fdt_file_name;
> +				break;
> +			}
> +			fdt_map++;
> +		}
> +	}
> +
> +	/* match not found OR null name_fdt */
> +	if (!fdt_file_name) {
> +		/*
> +		 * Prioritize CONFIG_DEFAULT_FDT_FILE - if that is not defined,
> +		 * or is empty, then use CONFIG_DEFAULT_DEVICE_TREE
> +		 */
> +#ifdef CONFIG_DEFAULT_FDT_FILE
> +		if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
> +			snprintf(fdtfile, sizeof(fdtfile), "%s/%s",
> +				 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_FDT_FILE);
> +		} else
> +#endif
> +		{
> +			snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> +				 CONFIG_TI_EVM_FDT_FOLDER_PATH,
> +				 CONFIG_DEFAULT_DEVICE_TREE);
> +		}
> +	} else {
> +		snprintf(fdtfile, sizeof(fdtfile), "%s/%s", CONFIG_TI_EVM_FDT_FOLDER_PATH,
> +			 fdt_file_name);
> +	}
> +
> +	env_set("fdtfile", fdtfile);
> +
> +	/*
> +	 * XXX: DEPRECATION WARNING: 2 u-boot versions.
> +	 *
> +	 * Maintain compatibility with downstream scripts that may be using
> +	 * name_fdt
> +	 */
> +	if (name_fdt)
> +		env_set("name_fdt", name_fdt);
> +	/* Also set the findfdt legacy script to warn users to stop using this */
> +	env_set("findfdt",
> +		"echo WARN: fdtfile already set. Stop using findfdt in script");
> +}
> diff --git a/board/ti/common/fdt_ops.h b/board/ti/common/fdt_ops.h
> new file mode 100644
> index 000000000000..c01697bed28f
> --- /dev/null
> +++ b/board/ti/common/fdt_ops.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Library to support common device tree manipulation for TI EVMs
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com
> + */
> +
> +#ifndef __FDT_OPS_H
> +#define __FDT_OPS_H
> +
> +#define TI_NAME_FDT_MAX 20
> +#define TI_FDT_FILE_MAX 200
> +
> +/**
> + *  struct ti_fdt_map - mapping of device tree blob name to board name
> + *  @name_fdt: board_name up to TI_NAME_FDT_MAX long
> + *  @fdt_file_name: device tree blob name as described by kernel
> + */
> +struct ti_fdt_map {
> +	const char *name_fdt;

Can we call this board_name? as name_fdt corresponds to device tree name.

> +	char *fdt_file_name;
> +};
> +
> +/**
> + * ti_set_fdt_env  - Find the correct device tree file name and set 'fdtfile'
> + * env variable with correct folder structure appropriate to the architecture
> + * and kernel conventions. This function is invoked typically as part of
> + * board_late_init
> + *
> + * fdt name is picked by:
> + * a) If a match is found, use the match
> + * b) If not, CONFIG_DEFAULT_FDT_FILE (Boot OS device tree) if that is defined
> + *    and not null
> + * c) If not, Use CONFIG_DEFAULT_DEVICE_TREE (DT control for bootloader)
> + *
> + * @name_fdt: match to search with (max of TI_NAME_FDT_MAX chars)
> + * @fdt_map: NULL terminated array of device tree file name matches.
> + */
> +void ti_set_fdt_env(const char *name_fdt, struct ti_fdt_map *fdt_map);
> +
> +#endif /* __FDT_OPS_H */

-- 
cheers,
-roger
