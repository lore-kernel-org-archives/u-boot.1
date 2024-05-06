Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD62FC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAB487FCD;
	Mon,  6 May 2024 12:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714989842;
	bh=spSlrbgDiTjKAPf1924tNYwGCaHnSwRvJ5QcuZDMomE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXI3psRlQosGtWH5cpcxKTa3Te8jdproxY3SDIBc/IYDEYt8ejyju9/Xhl2HLYhI1
	 G3cI9OTqAsjwzPVB512W7szRmey8Epi1iqJDY7OuaRWk3nrf+wfmnEzXPH16ZJoC+L
	 TvA2ADttyfjvjpr0efhBNbvX5xqqrC/0H+CY6Rv7WsENO2Sa8y/tNwgKIYBaNNdiaX
	 9vN66L7OHU68FEyq/YPWqBLJp2J3nARLBJFh+wsYJ9cy7MSWkiSwcMsa85SnehZ556
	 NJe2IAvlRTKk9qh6PdKMTwCjq0cEx/KMeLww26M2X3jlUBgOtwtE4u+HK0Z+gGhE4W
	 ZkeHOwInZSdkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3CD788013; Mon,  6 May 2024 12:04:01 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D64687FA1
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VXxnm2PBzz9t6j;
 Mon,  6 May 2024 12:03:56 +0200 (CEST)
Message-ID: <149e251a-baa7-4512-990a-d332d0d6177f@denx.de>
Date: Mon, 6 May 2024 12:03:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu 10/10] arm: mvebu: turris_omnia: Support old
 DDR3 training, selectable via env var
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240415163043.7482-1-kabel@kernel.org>
 <20240415163043.7482-11-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240415163043.7482-11-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VXxnm2PBzz9t6j
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

Hi Marek,

On 4/15/24 18:30, Marek Behún wrote:
> Support old DDR3 training code on Turris Omnia, selectable by U-Boot
> enviroment variable.
> 
> Users experiencing DDR3 initialization failures or random crashes of the
> operating system due to incorrect DDR3 configuration can select the old
> DDR3 training implementation to fix those issues by setting the
> environment variable
>    env set omnia_ddr3_training old
>    env save
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   arch/arm/mach-mvebu/Kconfig                   |  1 +
>   board/CZ.NIC/turris_omnia/Makefile            |  1 +
>   board/CZ.NIC/turris_omnia/old_ddr3_training.c | 79 +++++++++++++++++++
>   board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
>   4 files changed, 82 insertions(+), 1 deletion(-)
>   create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c

For turris_omnia_defconfig, this is dropped when compiled:

drivers/ddr/marvell/a38x/old/ddr3_debug.c:776:12: warning: 
'ddr3_tip_access_atr' declared 'static' but never defined 
[-Wunused-function]
   776 | static int ddr3_tip_access_atr(u32 dev_num, u32 flag_id, u32 
value, u32 **ptr);
       |            ^~~~~~~~~~~~~~~~~~~

Please take a look.

Thanks,
Stefan

> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index e377e8a48a..4a8328760e 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
>   	select SPL_SYS_MALLOC_SIMPLE
>   	select SYS_I2C_MVTWSI
>   	select ATSHA204A
> +	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
>   
>   config TARGET_TURRIS_MOX
>   	bool "Support CZ.NIC's Turris Mox / RIPE Atlas Probe"
> diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
> index 341378b4e5..28142cca7e 100644
> --- a/board/CZ.NIC/turris_omnia/Makefile
> +++ b/board/CZ.NIC/turris_omnia/Makefile
> @@ -3,3 +3,4 @@
>   # Copyright (C) 2017 Marek Behún <kabel@kernel.org>
>   
>   obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
> +obj-$(CONFIG_SPL_BUILD)	+= old_ddr3_training.o
> diff --git a/board/CZ.NIC/turris_omnia/old_ddr3_training.c b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
> new file mode 100644
> index 0000000000..f7e89c58d4
> --- /dev/null
> +++ b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
> + */
> +
> +#include <common.h>
> +#include <asm/io.h>
> +#include <env.h>
> +
> +#include "../drivers/ddr/marvell/a38x/old/ddr3_init.h"
> +
> +static struct hws_topology_map board_topology_map_1g = {
> +	0x1, /* active interfaces */
> +	/* cs_mask, mirror, dqs_swap, ck_swap X PUPs */
> +	{ { { {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0} },
> +	    SPEED_BIN_DDR_1600K,	/* speed_bin */
> +	    BUS_WIDTH_16,		/* memory_width */
> +	    MEM_4G,			/* mem_size */
> +	    DDR_FREQ_800,		/* frequency */
> +	    0, 0,			/* cas_l cas_wl */
> +	    HWS_TEMP_NORMAL,		/* temperature */
> +	    HWS_TIM_2T} },              /* timing (force 2t) */
> +	5,				/* Num Of Bus Per Interface*/
> +	BUS_MASK_32BIT			/* Busses mask */
> +};
> +
> +static struct hws_topology_map board_topology_map_2g = {
> +	0x1, /* active interfaces */
> +	/* cs_mask, mirror, dqs_swap, ck_swap X PUPs */
> +	{ { { {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0},
> +	      {0x1, 0, 0, 0} },
> +	    SPEED_BIN_DDR_1600K,	/* speed_bin */
> +	    BUS_WIDTH_16,		/* memory_width */
> +	    MEM_8G,			/* mem_size */
> +	    DDR_FREQ_800,		/* frequency */
> +	    0, 0,			/* cas_l cas_wl */
> +	    HWS_TEMP_NORMAL,		/* temperature */
> +	    HWS_TIM_2T} },              /* timing (force 2t) */
> +	5,				/* Num Of Bus Per Interface*/
> +	BUS_MASK_32BIT			/* Busses mask */
> +};
> +
> +/* defined in turris_omnia.c */
> +extern int omnia_get_ram_size_gb(void);
> +
> +struct hws_topology_map *ddr3_get_topology_map(void)
> +{
> +	if (omnia_get_ram_size_gb() == 2)
> +		return &board_topology_map_2g;
> +	else
> +		return &board_topology_map_1g;
> +}
> +
> +bool board_use_old_ddr3_training(void)
> +{
> +	const char *env_val = NULL;
> +
> +	if (CONFIG_IS_ENABLED(ENV_SUPPORT) && !env_init())
> +		env_val = env_get("omnia_ddr3_training");
> +
> +	if (env_val && !strcmp(env_val, "old")) {
> +		printf("Using old DDR3 training implementation\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +__weak u32 sys_env_get_topology_update_info(struct topology_update_info *tui)
> +{
> +	return MV_OK;
> +}
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 3b7a71bdad..225c6f4bc5 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -465,7 +465,7 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>   	return true;
>   }
>   
> -static int omnia_get_ram_size_gb(void)
> +int omnia_get_ram_size_gb(void)
>   {
>   	static int ram_size;
>   	struct omnia_eeprom oep;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
