Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE685C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A217F87937;
	Fri, 12 Jan 2024 22:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uh+mynzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648D1878C8; Fri, 12 Jan 2024 22:13:57 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF7B807A7
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CLDlXP070029;
 Fri, 12 Jan 2024 15:13:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705094027;
 bh=Da9NVm6DvkTsC/YCrnIP28a8OyGu9npzoV/zr6unBv4=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=Uh+mynzXeQApHiMc9z1XsUctP/8a3pgPvX/gTtVFrM3dAN26G3jGpnKySaQiZyFfq
 h+Mab3Lu8mVDqgg9zmOtiC7GXzxv6XTrgUN2CZPf/otp7v7PRhSDcBevQ6mlTsdL4X
 Gq3RvDc1Qq+jHasFur8OYP4nxjYmO7of2VsjHEVY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CLDlkV102045
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 15:13:47 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 15:13:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 15:13:46 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CLDkUh059797;
 Fri, 12 Jan 2024 15:13:46 -0600
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
Subject: Re: [PATCH V2 02/10] board: ti: am62ax: Set fdtfile from C code
 instead of findfdt script
In-Reply-To: <20240109191506.3820908-3-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-3-nm@ti.com>
Date: Fri, 12 Jan 2024 15:13:46 -0600
Message-ID: <86a5padzlh.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 12 Jan 2024 22:26:42 +0100
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
> Changes from V1: None.
> I have retained the central call ti_set_fdt_env() to retain the
> population of fdtfile name using the CONFIG fall back logic and the
> population of (now deprecated) legacy variables for downstream script
> users.
>
> V1: https://lore.kernel.org/r/20240108173301.2692332-3-nm@ti.com
>
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

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
