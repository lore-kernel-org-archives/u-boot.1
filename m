Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6365C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B50888FB;
	Tue, 16 Jul 2024 03:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GkykGfkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07CF48894C; Tue, 16 Jul 2024 03:57:35 +0200 (CEST)
Received: from mail-m24109.xmail.ntesmail.com (mail-m24109.xmail.ntesmail.com
 [45.195.24.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5460088907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GkykGfkQXPLTbFUljzuM7QdeOF4hfRTEHnh5i3el/zDGRvJB+8/5N3IRu3bBVYVYTJqM7tBYX/XwG3d49gpO3bfOtG00G1tzbZEMlu5C0dDzIkbeGBAcKc8tldPSiaA2h/21Xor3TuwAL9hcu1BnpDYmtxxQwk43II5W4W10QEA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=I76qjeKRZLDU0/m9cKdnuDSMtjAREWVCyQhjZ9xB6FU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4B21B900378;
 Tue, 16 Jul 2024 09:57:17 +0800 (CST)
Message-ID: <707d4d5b-7db0-4740-9e69-631271de38e4@rock-chips.com>
Date: Tue, 16 Jul 2024 09:57:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/3] rockchip: io-domain: add support for PX30
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
 <20240614-px30-io-domain-v1-2-9552966d3911@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-px30-io-domain-v1-2-9552966d3911@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NLGlZJQh5MGEpNTUxKQhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b942230703a9kunm4b21b900378
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6UQw6MTI0GBgjTygTMUwR
 AjMaCy5VSlVKTElKS0JOS0hDSk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSk9INwY+
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


On 2024/6/15 00:54, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Port the PX30 part of the Rockchip IO Domain driver from Linux.
>
> This differs from linux version in that the io iodomain bit is enabled
> in the write ops instead of in an init ops as in linux, this way we can
> avoid keeping a full state of all supplies that have been configured.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/misc/rockchip-io-domain.c | 66 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index 04d4d07c412..cf4f7c3984c 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -27,6 +27,10 @@
>   #define MAX_VOLTAGE_1_8		1980000
>   #define MAX_VOLTAGE_3_3		3600000
>   
> +#define PX30_IO_VSEL			0x180
> +#define PX30_IO_VSEL_VCCIO6_SRC		BIT(0)
> +#define PX30_IO_VSEL_VCCIO6_SUPPLY_NUM	1
> +
>   #define RK3328_SOC_CON4			0x410
>   #define RK3328_SOC_CON4_VCCIO2		BIT(7)
>   #define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
> @@ -99,6 +103,22 @@ static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int
>   	return regmap_write(grf, offset, val);
>   }
>   
> +static int px30_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
> +{
> +	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> +
> +	if (!ret && idx == PX30_IO_VSEL_VCCIO6_SUPPLY_NUM) {
> +		/*
> +		 * set vccio6 iodomain to also use this framework
> +		 * instead of a special gpio.
> +		 */
> +		u32 val = PX30_IO_VSEL_VCCIO6_SRC | (PX30_IO_VSEL_VCCIO6_SRC << 16);
> +		ret = regmap_write(grf, PX30_IO_VSEL, val);
> +	}
> +
> +	return ret;
> +}
> +
>   static int rk3328_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>   {
>   	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
> @@ -131,6 +151,44 @@ static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, i
>   	return ret;
>   }
>   
> +static const struct rockchip_iodomain_soc_data soc_data_px30 = {
> +	.grf_offset = 0x180,
> +	.supply_names = {
> +		NULL,
> +		"vccio6-supply",
> +		"vccio1-supply",
> +		"vccio2-supply",
> +		"vccio3-supply",
> +		"vccio4-supply",
> +		"vccio5-supply",
> +		"vccio-oscgpi-supply",
> +	},
> +	.write = px30_iodomain_write,
> +};
> +
> +static const struct rockchip_iodomain_soc_data soc_data_px30_pmu = {
> +	.grf_offset = 0x100,
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
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		NULL,
> +		"pmuio1-supply",
> +		"pmuio2-supply",
> +	},
> +	.write = rockchip_iodomain_write,
> +};
> +
>   static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
>   	.grf_offset = 0x410,
>   	.supply_names = {
> @@ -190,6 +248,14 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
>   };
>   
>   static const struct udevice_id rockchip_iodomain_ids[] = {
> +	{
> +		.compatible = "rockchip,px30-io-voltage-domain",
> +		.data = (ulong)&soc_data_px30,
> +	},
> +	{
> +		.compatible = "rockchip,px30-pmu-io-voltage-domain",
> +		.data = (ulong)&soc_data_px30_pmu,
> +	},
>   	{
>   		.compatible = "rockchip,rk3328-io-voltage-domain",
>   		.data = (ulong)&soc_data_rk3328,
>
