Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7D6C3DA6E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 03:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E399D87861;
	Tue,  9 Jan 2024 04:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RrNBnPvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297038743A; Tue,  9 Jan 2024 03:48:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0426B87848
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 03:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4092mAuT120444;
 Mon, 8 Jan 2024 20:48:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704768491;
 bh=X6ArkC9ecxLP6DqTtHN/xVDMVZo0j08dxrfOe+DBzcg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=RrNBnPvMO+v8WeiGdnjrH4FzMuIoOZI2fq8Q1DI7Beg/m5R5AwvlinJUsoRe2uom7
 47ba3fs2+L0Orst4CfgFau2FSR9o9S0kI5Lo2HA8g82N6x/b8VCn73rs9Ph8dYK1G2
 J8kM7OiYBEo8dfEBvwMv+Xaw8pzlKhuWwR3c6X6U=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4092mAIS016482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 20:48:10 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 20:48:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 20:48:10 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4092mAnH122014;
 Mon, 8 Jan 2024 20:48:10 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 02/10] board: ti: am62ax: Set fdtfile from C code
 instead of findfdt script
In-Reply-To: <20240108173301.2692332-3-nm@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-3-nm@ti.com>
Date: Mon, 8 Jan 2024 20:48:10 -0600
Message-ID: <86jzojdxxx.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Jan 2024 04:27:54 +0100
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

Nishanth Menon <nm@ti.com> writes:

> Stop using the findfdt script and switch to setting the fdtfile from
> C code.
>
> While at this, replace findfdt in environment with a warning as it is
> no longer needed
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  board/ti/am62ax/am62ax.env       |  1 -
>  board/ti/am62ax/evm.c            | 10 ++++++++++
>  configs/am62ax_evm_a53_defconfig |  1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
> index a6d967e982d4..334374abb73e 100644
> --- a/board/ti/am62ax/am62ax.env
> +++ b/board/ti/am62ax/am62ax.env
> @@ -1,5 +1,4 @@
>  #include <env/ti/ti_common.env>
> -#include <env/ti/default_findfdt.env>
>  #include <env/ti/mmc.env>
>  
>  name_kern=Image
> diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
> index cd3360a43029..62d3664936e7 100644
> --- a/board/ti/am62ax/evm.c
> +++ b/board/ti/am62ax/evm.c
> @@ -13,6 +13,8 @@
>  #include <fdt_support.h>
>  #include <spl.h>
>  
> +#include "../common/fdt_ops.h"
> +
>  int board_init(void)
>  {
>  	return 0;
> @@ -27,3 +29,11 @@ int dram_init_banksize(void)
>  {
>  	return fdtdec_setup_memory_banksize();
>  }
> +
> +#ifdef CONFIG_BOARD_LATE_INIT
> +int board_late_init(void)
> +{
> +	ti_set_fdt_env(NULL, NULL);

If a board only has one FDT possible, why not just hard code the path
here, rather than use the set_fdt_env() logic with NULLs and create/set
TI_EVM_FDT_FOLDER_PATH config that is only used here anyway?

If you think we might add additional board types / FDTs later, then
instead let's formalize the fdt_map concept and create a CONFIG_USES_FDT_MAP
that will then rely on the fdt_map and call the ti_set_fdt_env(), and if
not set, then it just returns a hard coded value, which could be based on
the CONFIG_DEFAULT_DEVICE_TREE config.

> +	return 0;
> +}
> +#endif
> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
> index 38083586a3ec..e5fcd8cc5b6f 100644
> --- a/configs/am62ax_evm_a53_defconfig
> +++ b/configs/am62ax_evm_a53_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>  CONFIG_BOOTSTD_FULL=y
>  CONFIG_BOOTSTD_DEFAULTS=y
>  CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
> +CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_MAX_SIZE=0x58000
>  CONFIG_SPL_PAD_TO=0x0
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -- 
> 2.43.0
