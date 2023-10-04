Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B5E7B61B
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A754D87445;
	Wed,  4 Oct 2023 15:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TN8Dc+Pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E55887540; Wed,  4 Oct 2023 15:59:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97CB8652B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394Dx0uv058482;
 Wed, 4 Oct 2023 08:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696427940;
 bh=ncJCuiNhq2fSP/BJJ4/CQyFnHqT1yHDJXSnsqHfskLU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TN8Dc+PmJk9dFg15xXpMaOUfuhmrBpk4Ly+3VWaSAdCm6/scAfJXn8ndBSj2s5SRR
 BAeMGlthN8a4yD5iVCQVwfpeqvy9sjW1phU6hAjgCDKK/xO3bvTTvbpYIQwLwCnqIA
 j/mKkuCRWLYQQW39o5CjktLSZ44HSBB/2AaQ86uY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394Dx0r2114619
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 08:59:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 08:59:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 08:59:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394Dx0UC034881;
 Wed, 4 Oct 2023 08:59:00 -0500
Date: Wed, 4 Oct 2023 08:59:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] board: ti: am64x: Switch to standard boot flow
Message-ID: <20231004135900.hcsptl5ho6imm4nk@unblessed>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004132324.44198-3-rogerq@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:23-20231004, Roger Quadros wrote:
> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>


> ---
>  board/ti/am64x/am64x.env        | 1 +
>  configs/am64x_evm_a53_defconfig | 5 +++--
>  include/configs/am64x_evm.h     | 2 --
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> index 68e42222b7..efd736b99b 100644
> --- a/board/ti/am64x/am64x.env
> +++ b/board/ti/am64x/am64x.env
> @@ -15,6 +15,7 @@ console=ttyS2,115200n8
>  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
>  run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>  
> +boot_targets=mmc1 mmc0 usb pxe dhcp
>  boot=mmc
>  mmcdev=1
>  bootpart=1:2
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index 718ad176cb..43bfcf957a 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -31,8 +31,9 @@ CONFIG_SPL_SPI=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
>  CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_MAX_SIZE=0x180000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
> index 062102a610..d3d9eac8b6 100644
> --- a/include/configs/am64x_evm.h
> +++ b/include/configs/am64x_evm.h
> @@ -10,8 +10,6 @@
>  #define __CONFIG_AM642_EVM_H
>  
>  #include <linux/sizes.h>
Do we really need this?
> -#include <config_distro_bootcmd.h>
> -#include <env/ti/mmc.h>
>  #include <asm/arch/am64_hardware.h>

OR this?

>  #include <env/ti/k3_dfu.h>
you dont need k3_dfu.h either. the env setup is already in
board/ti/am64x/am64x.env (k3_dfu.env)

and we dont seem to be using CFG_SYS_SDRAM_BASE1

might be that we could reduce it down to am62x_evm.h ?

>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
