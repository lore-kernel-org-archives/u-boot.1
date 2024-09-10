Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0321AECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9086888F86;
	Tue, 10 Sep 2024 11:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QqQI/zmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD29288F86; Tue, 10 Sep 2024 11:51:04 +0200 (CEST)
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com
 [45.254.49.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55BC88FE4
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QqQI/zmEdYjtQRg5tK9c7t5BRStqc/lhfMtQFyU/MkeyM5G4L2EqGZtly1LWPNU3JTBSrin5xBXNm2YkXUFXpv4q7brmhbq9cEWbIBWVaA3ZKRbV2OpA/Y0scis9CNaYYdEhp+XHosxtS20PgLOzry3w6vdndI0wkmgCdGc5zno=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Y4PMBFkuNTp1kU1ipT1+7Y1SSTLEfuPBV2g2qkcrd+c=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 75F8F900858;
 Tue, 10 Sep 2024 17:50:39 +0800 (CST)
Message-ID: <b67d7193-7cda-461b-92fe-e07faa55017e@rock-chips.com>
Date: Tue, 10 Sep 2024 17:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG
 config for TPL/SPL
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-4-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240903163858.1155218-4-lukasz.czechowski@thaumatec.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhMTFZKHkxKHxoaQxoaHx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91db57a4be03a3kunm75f8f900858
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46USo4LTIyQiseIkkeQh89
 GDkKFDZVSlVKTElOQk1KQ09LT0lCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk9CSjcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Lukasz,

On 2024/9/4 00:38, Lukasz Czechowski wrote:
> Introduce new config symbols TPL_RAM_ROCKCHIP_DEBUG and
> SPL_RAM_ROCKCHIP_DEBUG to allow for better dependencies control
> of RAM driver debugging configuration.

The RAM_ROCKCHIP_DEBUG should enough because this only happen when ram 
driver

running the initialization, and this init process always only run only 
once for all SoCs.

RAM_ROCKCHIP_DEBUG depends on DEBUG_UART is the correct and no need to 
add more

other dependency.

> Add negative dependencies to TPL_SILENT_CONSOLE and
> SPL_SILENT_CONSOLE, respectively.

I believe this is he main target, you want to control the UART output by 
SILENT_CONTROL,

but the RAM_DEBUG should follow the DEBUG_UART.

So I think this patch is no need, please drop it.


Thanks,
- Kever
>
> Replace IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG) directives with
> CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG) to utilize the configuration
> changes.
>
> Update defconfigs of affected boards so that behavior
> is not changed.
>
> Signed-off-by: Lukasz Czechowski<lukasz.czechowski@thaumatec.com>
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig   |  1 +
>   configs/neu2-io-rv1126_defconfig          |  2 ++
>   configs/roc-pc-mezzanine-rk3399_defconfig |  2 ++
>   configs/roc-pc-rk3399_defconfig           |  2 ++
>   configs/rock-pi-n10-rk3399pro_defconfig   |  2 ++
>   configs/sonoff-ihost-rv1126_defconfig     |  2 ++
>   drivers/ram/rockchip/Kconfig              | 24 +++++++++++++++++++++++
>   drivers/ram/rockchip/sdram_common.c       |  2 +-
>   drivers/ram/rockchip/sdram_rk3399.c       |  4 ++--
>   drivers/ram/rockchip/sdram_rv1126.c       | 10 +++++-----
>   10 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index a03509bf467..4392bb5af00 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -68,6 +68,7 @@ CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
>   # CONFIG_RNG_SMCCC_TRNG is not set
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
> index 2a4c9b45a04..1bdf99887b3 100644
> --- a/configs/neu2-io-rv1126_defconfig
> +++ b/configs/neu2-io-rv1126_defconfig
> @@ -46,6 +46,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYSRESET=y
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index a57899bfdfa..45c4975e452 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -66,6 +66,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index b45f0e0a899..3f2d5650249 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -63,6 +63,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
> index ec995a54a0e..d4ba628e428 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -52,6 +52,8 @@ CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
> index 4890644c7e6..1b10cded8fd 100644
> --- a/configs/sonoff-ihost-rv1126_defconfig
> +++ b/configs/sonoff-ihost-rv1126_defconfig
> @@ -47,6 +47,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYSRESET=y
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index d707d09c1c8..5e069dca3be 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,6 +24,30 @@ config RAM_ROCKCHIP_DEBUG
>   	  This is an option for developers to understand the ram drivers
>   	  initialization, configurations and etc.
>   
> +config SPL_RAM_ROCKCHIP_DEBUG
> +	bool "Rockchip ram drivers debugging in SPL"
> +	depends on DEBUG_UART
> +	depends on SPL && SPL_RAM && !SPL_SILENT_CONSOLE
> +	default y
> +	help
> +	  This enables debugging ram driver API's for the platforms
> +	  based on Rockchip SoCs.
> +
> +	  This is an option for developers to understand the ram drivers
> +	  initialization, configurations and etc.
> +
> +config TPL_RAM_ROCKCHIP_DEBUG
> +	bool "Rockchip ram drivers debugging in TPL"
> +	depends on DEBUG_UART
> +	depends on TPL && TPL_RAM && !TPL_SILENT_CONSOLE
> +	default y
> +	help
> +	  This enables debugging ram driver API's for the platforms
> +	  based on Rockchip SoCs.
> +
> +	  This is an option for developers to understand the ram drivers
> +	  initialization, configurations and etc.
> +
>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
>   	help
> diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
> index b7a8fce607c..c2a6310388c 100644
> --- a/drivers/ram/rockchip/sdram_common.c
> +++ b/drivers/ram/rockchip/sdram_common.c
> @@ -10,7 +10,7 @@
>   #include <asm/arch-rockchip/sdram.h>
>   #include <asm/arch-rockchip/sdram_common.h>
>   
> -#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
> +#if CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)
>   void sdram_print_dram_type(unsigned char dramtype)
>   {
>   	switch (dramtype) {
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 45270e27184..99a1cc6c174 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -2558,7 +2558,7 @@ static int lpddr4_set_rate(struct dram_info *dram,
>   	lpddr4_set_ctl(dram, params, ctl_fn,
>   		       dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq);
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
>   		printf("%s: change freq to %dMHz %d, %d\n", __func__,
>   		       dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq / MHz,
>   		       ctl_fn, phy_fn);
> @@ -2980,7 +2980,7 @@ static int sdram_init(struct dram_info *dram,
>   			continue;
>   		}
>   
> -		if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> +		if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   			printf("Channel ");
>   			printf(channel ? "1: " : "0: ");
>   		}
> diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
> index 4fbb088a8d9..14e1df71ae4 100644
> --- a/drivers/ram/rockchip/sdram_rv1126.c
> +++ b/drivers/ram/rockchip/sdram_rv1126.c
> @@ -3375,7 +3375,7 @@ static void ddr_set_rate_for_fsp(struct dram_info *dram,
>   	if (get_wrlvl_val(dram, sdram_params))
>   		printascii("get wrlvl value fail\n");
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   		printascii("change to: ");
>   		printdec(f1);
>   		printascii("MHz\n");
> @@ -3383,21 +3383,21 @@ static void ddr_set_rate_for_fsp(struct dram_info *dram,
>   	ddr_set_rate(&dram_info, sdram_params, f1,
>   		     sdram_params->base.ddr_freq, 1, 1, 1);
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   		printascii("change to: ");
>   		printdec(f2);
>   		printascii("MHz\n");
>   	}
>   	ddr_set_rate(&dram_info, sdram_params, f2, f1, 2, 0, 1);
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   		printascii("change to: ");
>   		printdec(f3);
>   		printascii("MHz\n");
>   	}
>   	ddr_set_rate(&dram_info, sdram_params, f3, f2, 3, 1, 1);
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   		printascii("change to: ");
>   		printdec(f0);
>   		printascii("MHz(final freq)\n");
> @@ -3493,7 +3493,7 @@ static int rv1126_dmc_init(struct udevice *dev)
>   	save_rw_trn_result_to_ddr(&rw_trn_result);
>   #endif
>   
> -	if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
> +	if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
>   		printascii("out\n");
>   
>   	return ret;
