Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D6AC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7DA8861D;
	Mon, 29 Jul 2024 09:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="g6/Hqf0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E453188747; Mon, 29 Jul 2024 09:39:30 +0200 (CEST)
Received: from mail-m127156.xmail.ntesmail.com
 (mail-m127156.xmail.ntesmail.com [115.236.127.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 441E0887BF
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=g6/Hqf0WXa2R2ZQ4+gOpJ+OFpVGD4Il8q/v/UIShQ3yhcPhzT0/90LO9V0dNbmrcEqaNAl4wQLAnbQ7rHUt7OhkXKLgn7cOjF2IO9OucWETpcWV5GXqM6VoHRUZt1xkEbm55dVoNiqUZp3WnISM2+a0lZVTezIOUlZD5pY7cdH4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=if/BexShAmER1YC0MMR2bRrTGU/tvYniU4lxWGN0tnA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9CB889005AB;
 Mon, 29 Jul 2024 15:39:15 +0800 (CST)
Message-ID: <f5686f50-f554-4a92-b115-3621cd3df493@rock-chips.com>
Date: Mon, 29 Jul 2024 15:39:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Add support for RK3308
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20240724065817.2736062-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240724065817.2736062-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoaH1ZPGkseSBgfGhhMSUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90fd6de4ec03a9kunm9cb889005ab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6Dgw4EzI3FzIWQjgKPAwK
 SRwKCS1VSlVKTElJSUhDTE5NTk1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUxJNwY+
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


On 2024/7/24 14:58, Jonas Karlman wrote:
> Port the RK3308 part of the Rockchip IO Domain driver from linux.
>
> This differs from linux version in that vccio3 iodomain bit is enabled
> in the write ops instead of in an init ops as in linux, this way we can
> avoid keeping a full state of all supply that have been configured.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3308/syscon_rk3308.c |  3 ++
>   drivers/misc/rockchip-io-domain.c             | 37 +++++++++++++++++++
>   2 files changed, 40 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
> index 2d7e97110152..e77189eef6cf 100644
> --- a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
> @@ -16,4 +16,7 @@ U_BOOT_DRIVER(syscon_rk3308) = {
>   	.name = "rk3308_syscon",
>   	.id = UCLASS_SYSCON,
>   	.of_match = rk3308_syscon_ids,
> +#if CONFIG_IS_ENABLED(OF_REAL)
> +	.bind = dm_scan_fdt_dev,
> +#endif
>   };
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index cf4f7c3984c7..025b6049a9f7 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -31,6 +31,10 @@
>   #define PX30_IO_VSEL_VCCIO6_SRC		BIT(0)
>   #define PX30_IO_VSEL_VCCIO6_SUPPLY_NUM	1
>   
> +#define RK3308_SOC_CON0			0x300
> +#define RK3308_SOC_CON0_VCCIO3		BIT(8)
> +#define RK3308_SOC_VCCIO3_SUPPLY_NUM	3
> +
>   #define RK3328_SOC_CON4			0x410
>   #define RK3328_SOC_CON4_VCCIO2		BIT(7)
>   #define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
> @@ -119,6 +123,22 @@ static int px30_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>   	return ret;
>   }
>   
> +static int rk3308_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
> +{
> +	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> +
> +	if (!ret && idx == RK3308_SOC_VCCIO3_SUPPLY_NUM) {
> +		/*
> +		 * set vccio3 iodomain to also use this framework
> +		 * instead of a special gpio.
> +		 */
> +		u32 val = RK3308_SOC_CON0_VCCIO3 | (RK3308_SOC_CON0_VCCIO3 << 16);
> +		ret = regmap_write(grf, RK3308_SOC_CON0, val);
> +	}
> +
> +	return ret;
> +}
> +
>   static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>   {
>   	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> @@ -189,6 +209,19 @@ static const struct rockchip_iodomain_soc_data soc_data_px30_pmu = {
>   	.write = rockchip_iodomain_write,
>   };
>   
> +static const struct rockchip_iodomain_soc_data soc_data_rk3308 = {
> +	.grf_offset = 0x300,
> +	.supply_names = {
> +		"vccio0-supply",
> +		"vccio1-supply",
> +		"vccio2-supply",
> +		"vccio3-supply",
> +		"vccio4-supply",
> +		"vccio5-supply",
> +	},
> +	.write = rk3308_iodomain_write,
> +};
> +
>   static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
>   	.grf_offset = 0x410,
>   	.supply_names = {
> @@ -256,6 +289,10 @@ static const struct udevice_id rockchip_iodomain_ids[] = {
>   		.compatible = "rockchip,px30-pmu-io-voltage-domain",
>   		.data = (ulong)&soc_data_px30_pmu,
>   	},
> +	{
> +		.compatible = "rockchip,rk3308-io-voltage-domain",
> +		.data = (ulong)&soc_data_rk3308,
> +	},
>   	{
>   		.compatible = "rockchip,rk3328-io-voltage-domain",
>   		.data = (ulong)&soc_data_rk3328,
