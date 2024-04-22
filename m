Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03505C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA878837B;
	Mon, 22 Apr 2024 10:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H7FCK55p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF0B8833D; Mon, 22 Apr 2024 10:24:35 +0200 (CEST)
Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com
 [101.71.155.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7878837B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=H7FCK55pCjNqn+HBMss4kfYCw5qdsQKmJ3usLs35PB1u5kQ5CeDCDDMbT7EDk+KiTWIIDhcZZbiuVDwrEZVqoeFUysIPZOpxPn0LyOsOh5F0g25i12AXdDLJFxWPcxryMfik8Sotx2PZtrpBEwFTEgpPwfBn7LfmPLdZY3Rn848=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Yez0ULOMyWcFa59vBuy5xU46cojjLNAudD3dA6TxGS8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 86BF79002BC;
 Mon, 22 Apr 2024 16:24:23 +0800 (CST)
Message-ID: <cace9398-e3d5-4ede-968f-7d687d4981fb@rock-chips.com>
Date: Mon, 22 Apr 2024 16:24:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: io-domain: Add support for RK3328
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240421200908.518855-1-jonas@kwiboo.se>
 <20240421200908.518855-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240421200908.518855-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgeH1YYHx9OS04aSBlDQhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04e7ff1703a9kunm86bf79002bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06Ljo6DDMDEDpNTBYtCU4Q
 CjhPChhVSlVKTEpITExPSU1PTkJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSk1NNwY+
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


On 2024/4/22 04:09, Jonas Karlman wrote:
> Port the RK3328 part of the Rockchip IO-domain driver from linux.
>
> This differs from linux version in that pmu io iodomain bit is enabled
> in the write ops instead of in an init ops as in linux, this way we can
> avoid keeping a full state of all supply that have been configured.
>
> Enable by default on all RK3328 boards, skip rk3328-evb because this
> target is typically also used on miscellaneous boards and boxes not
> fully supported by U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/rk3328/syscon_rk3328.c |  3 ++
>   configs/evb-rk3328_defconfig                  |  1 +
>   drivers/misc/Kconfig                          |  2 +-
>   drivers/misc/rockchip-io-domain.c             | 38 +++++++++++++++++++
>   4 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
> index daf74a0e2d37..d2f267e63534 100644
> --- a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
> @@ -17,4 +17,7 @@ U_BOOT_DRIVER(rockchip_rk3328_grf) = {
>   	.name = "rockchip_rk3328_grf",
>   	.id = UCLASS_SYSCON,
>   	.of_match = rk3328_syscon_ids,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind = dm_scan_fdt_dev,
> +#endif
>   };
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index 75a0e0f286bd..53ad6777ec50 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -57,6 +57,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +# CONFIG_ROCKCHIP_IODOMAIN is not set
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_PHY_MOTORCOMM=y
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6b06888454f4..6009d55f400e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,7 +104,7 @@ config ROCKCHIP_OTP
>   config ROCKCHIP_IODOMAIN
>   	bool "Rockchip IO-domain driver support"
>   	depends on DM_REGULATOR && ARCH_ROCKCHIP
> -	default y if ROCKCHIP_RK3568
> +	default y if ROCKCHIP_RK3328 || ROCKCHIP_RK3568
>   	help
>   	  Enable support for IO-domains in Rockchip SoCs. It is necessary
>   	  for the IO-domain setting of the SoC to match the voltage supplied
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index 0ffea32ef07f..04d4d07c4127 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -27,6 +27,10 @@
>   #define MAX_VOLTAGE_1_8		1980000
>   #define MAX_VOLTAGE_3_3		3600000
>   
> +#define RK3328_SOC_CON4			0x410
> +#define RK3328_SOC_CON4_VCCIO2		BIT(7)
> +#define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
> +
>   #define RK3399_PMUGRF_CON0		0x180
>   #define RK3399_PMUGRF_CON0_VSEL		BIT(8)
>   #define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
> @@ -95,6 +99,22 @@ static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int
>   	return regmap_write(grf, offset, val);
>   }
>   
> +static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
> +{
> +	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> +
> +	if (!ret && idx == RK3328_SOC_VCCIO2_SUPPLY_NUM) {
> +		/*
> +		 * set vccio2 iodomain to also use this framework
> +		 * instead of a special gpio.
> +		 */
> +		u32 val = RK3328_SOC_CON4_VCCIO2 | (RK3328_SOC_CON4_VCCIO2 << 16);
> +		ret = regmap_write(grf, RK3328_SOC_CON4, val);
> +	}
> +
> +	return ret;
> +}
> +
>   static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>   {
>   	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> @@ -111,6 +131,20 @@ static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, i
>   	return ret;
>   }
>   
> +static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
> +	.grf_offset = 0x410,
> +	.supply_names = {
> +		"vccio1-supply",
> +		"vccio2-supply",
> +		"vccio3-supply",
> +		"vccio4-supply",
> +		"vccio5-supply",
> +		"vccio6-supply",
> +		"pmuio-supply",
> +	},
> +	.write = rk3328_iodomain_write,
> +};
> +
>   static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
>   	.grf_offset = 0xe640,
>   	.supply_names = {
> @@ -156,6 +190,10 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
>   };
>   
>   static const struct udevice_id rockchip_iodomain_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3328-io-voltage-domain",
> +		.data = (ulong)&soc_data_rk3328,
> +	},
>   	{
>   		.compatible = "rockchip,rk3399-io-voltage-domain",
>   		.data = (ulong)&soc_data_rk3399,
