Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B797E87513;
	Mon, 11 Mar 2024 10:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DiQFNIo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7B386F1E; Mon, 11 Mar 2024 10:31:00 +0100 (CET)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB60387150
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DiQFNIo85Yz4EL0ug8FNNTUsZHQK6C3m3211ydsHdHMOTFsp69aZSqjCIurNb1UedKbkYn0ItjvnPKAIyzQ1zTtPLyKMp80WvDNddruRzSq/GLXFnXD8aH1aJwZ99leT47Tn4S7IbUbhVG82dyEyRu0KiiHpp48EPm2DeF0frBw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=GlftC6uHH+Wa5M7VQEjOihYyIxmocDQvSfbZW8PVf/c=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6EBE590040B;
 Mon, 11 Mar 2024 17:30:38 +0800 (CST)
Message-ID: <810a3503-6066-4535-994f-b1bc51871f29@rock-chips.com>
Date: Mon, 11 Mar 2024 17:30:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: io-domain: Add support for RK3399
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-6-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9NSlZLGU9OSx5JGEIaT09VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cd98d2d03a9kunm6ebe590040b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06IQw5NDMSMDAXLBgXQhg9
 FBgwFAlVSlVKTEpLSk9CT0hCSkNKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQ05LNwY+
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


On 2024/2/18 02:35, Jonas Karlman wrote:
> Port the RK3399 part of the Rockchip IO-domain driver from linux.
>
> This differs from linux version in that pmu io iodomain bit is enabled
> in the write ops instead of in an init ops as in linux, this way we can
> avoid keeping a full state of all supply that have been configured.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   drivers/misc/rockchip-io-domain.c | 79 +++++++++++++++++++++++++++++--
>   1 file changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index 3f6227f993f9..0ffea32ef07f 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -5,7 +5,6 @@
>    * Ported from linux drivers/soc/rockchip/io-domain.c
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <regmap.h>
> @@ -28,6 +27,10 @@
>   #define MAX_VOLTAGE_1_8		1980000
>   #define MAX_VOLTAGE_3_3		3600000
>   
> +#define RK3399_PMUGRF_CON0		0x180
> +#define RK3399_PMUGRF_CON0_VSEL		BIT(8)
> +#define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
> +
>   #define RK3568_PMU_GRF_IO_VSEL0		0x0140
>   #define RK3568_PMU_GRF_IO_VSEL1		0x0144
>   #define RK3568_PMU_GRF_IO_VSEL2		0x0148
> @@ -35,10 +38,10 @@
>   struct rockchip_iodomain_soc_data {
>   	int grf_offset;
>   	const char *supply_names[MAX_SUPPLIES];
> -	int (*write)(struct regmap *grf, int idx, int uV);
> +	int (*write)(struct regmap *grf, uint offset, int idx, int uV);
>   };
>   
> -static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
> +static int rk3568_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>   {
>   	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
>   	u32 val0, val1;
> @@ -78,6 +81,64 @@ static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
>   	return 0;
>   }
>   
> +static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
> +{
> +	u32 val;
> +
> +	/* set value bit */
> +	val = (uV > MAX_VOLTAGE_1_8) ? 0 : 1;
> +	val <<= idx;
> +
> +	/* apply hiword-mask */
> +	val |= (BIT(idx) << 16);
> +
> +	return regmap_write(grf, offset, val);
> +}
> +
> +static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
> +{
> +	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> +
> +	if (!ret && idx == RK3399_PMUGRF_VSEL_SUPPLY_NUM) {
> +		/*
> +		 * set pmu io iodomain to also use this framework
> +		 * instead of a special gpio.
> +		 */
> +		u32 val = RK3399_PMUGRF_CON0_VSEL | (RK3399_PMUGRF_CON0_VSEL << 16);
> +		ret = regmap_write(grf, RK3399_PMUGRF_CON0, val);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
> +	.grf_offset = 0xe640,
> +	.supply_names = {
> +		"bt656-supply",		/* APIO2_VDD */
> +		"audio-supply",		/* APIO5_VDD */
> +		"sdmmc-supply",		/* SDMMC0_VDD */
> +		"gpio1830-supply",	/* APIO4_VDD */
> +	},
> +	.write = rockchip_iodomain_write,
> +};
> +
> +static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
> +	.grf_offset = 0x180,
> +	.supply_names = {
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		"pmu1830-supply",	/* PMUIO2_VDD */
> +	},
> +	.write = rk3399_pmu_iodomain_write,
> +};
> +
>   static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
>   	.grf_offset = 0x140,
>   	.supply_names = {
> @@ -95,6 +156,14 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
>   };
>   
>   static const struct udevice_id rockchip_iodomain_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3399-io-voltage-domain",
> +		.data = (ulong)&soc_data_rk3399,
> +	},
> +	{
> +		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
> +		.data = (ulong)&soc_data_rk3399_pmu,
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
>   		.data = (ulong)&soc_data_rk3568_pmu,
> @@ -152,7 +221,9 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>   			continue;
>   		}
>   
> -		soc_data->write(grf, i, uV);
> +		ret = soc_data->write(grf, soc_data->grf_offset, i, uV);
> +		if (ret)
> +			dev_err(dev, "%s: Couldn't write to GRF\n", supply_name);
>   	}
>   
>   	return 0;
