Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9F5C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 18:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E78C880D5;
	Thu, 22 Feb 2024 19:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="JQ+lBor/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDC2880DC; Thu, 22 Feb 2024 19:15:12 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FF6880C9
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 19:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKLRwxH/+JtXsqwIf1M0jgJ/GPwTh17B28Y/o13Vz9KRJuKewnjkWqoXJ4vHzJRHF3W5NDxCxNXCL4gdraX+4qsUZwPG1+EAhcOs8c10cO8ZFlt9ujckV0b0ZuuW+rALMSCu8gyEtZiQtbNhx6SWA88RmllILd0vLM7OnBg3Hem7JUk8d6JS98liORYLcUWuF0DRf492afF+XcF48caL2k7RdRrmVm7UjbMy37hgf5JX/LiVfVnaRxF3lxDROTzZdhODLxsV5cU9ojt5sixa7BUld1zowzODoqi0ZSGtbBZ7NdMxamx4KGY4TvVDJN0QJ84iSKe+WYVon1vWsURE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J3XsFTyeWE7s+Zw+CMIKXF/phInah//99bmTRdMYbM=;
 b=nBaB4EDpTVyJtwS1y3Ejw85aPkoOnezDe/pgm626l+mS62lrNX4S7omP0tNmYyhCR2vkybM5/d9ptCX8Eb9TGr26Zpsj1yIVQMxlqqU9vRahOzjqhTKgmK+NppnK1rL7H3WdNuJk39hQ4SpJ6lnMCn84ybq9qKalUlLK2ohvJYSrD78LOzOp/nWTefv49+qWBZ2zOk+UWvKMQm8I3rwvkpzedmGDbkP2FnJauLoW/M7VbL+WFtntroc7zsvEiqbUqElIdIUaLrMoYHPki4fG0PKtbg5yrP/EiZSfyceJFFotppC8yTDKeOE7P++3zsx606iPghk26iqK+B0yISBcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J3XsFTyeWE7s+Zw+CMIKXF/phInah//99bmTRdMYbM=;
 b=JQ+lBor/eEncCniF975BIHLfjFirjY3LLGzQSrWY19LpBIGs8Vf+bZvxmPrZOpKj2fT++8ABWhjXeZoMTvWHmU1pLKDVf+0lpxQLfcIJuzEEGy5yOrTT1APwWc0fC/th8rERBKc35eW9tpcMlEaRVifUFAdT2fhdeWsRVzovTW/+JtkKLzX4FjyE8MVjEoF3vBp2e5FxAhnzTVb/3ejhCYNMyToivB1bOzNcAYWZ/OtidiIJN4qxo779AwxhMl6ADSEuL/rsxBl7X8a6f+DHlLG5x+PRXmU8dxGOYHE8zyZ++cYwOCrXk/sDurmlkVYhBSQSGmgdPZX6yk89FIKezg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM0PR04MB7137.eurprd04.prod.outlook.com (2603:10a6:208:19c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 18:15:04 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:15:03 +0000
Message-ID: <12d0bb08-4510-46ee-9658-4a82f4d06ef0@theobroma-systems.com>
Date: Thu, 22 Feb 2024 19:15:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] rockchip: adc: rockchip-saradc: add support for
 RK3588
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240221-rk3588-saradc-v1-0-c39a5601d1cc@theobroma-systems.com>
 <20240221-rk3588-saradc-v1-11-c39a5601d1cc@theobroma-systems.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240221-rk3588-saradc-v1-11-c39a5601d1cc@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM0PR04MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 82487437-f00b-422b-0677-08dc33d23076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRAYE1Uw0il/nAWUPj77WbhUWgXmLF2UatVQIiG/a65FhMoQUMZdDOoGoM+dJnoVlyZ9sMk07Jw1Yeu/YViaFTaKqtpd/4KjA1dk3qjOpF1pokH0XUWEraVLiQKQHl/CJGzoP2ogL+9MYDNfsMqYEUxVsivsaOM88SaoX1yoGnTfoDSTBD5hFbbmprOAt6DAdC3y3wAOsqXSGV40Fx8fggVJQCSXHl3pHZPnqdI40yEhzGamJJLW3vMkbWxu55el4vWswFSFN9cMzW8lHjKDyqSjo8c0MMfHI3njescVDJOtFNcXXrA4ZAzC5Qaa4TJSo8x49C8qrTBoWrD5fjnvJC6WjMDXoKB5g9jln2x/U+KQcNgta+igidDc5xpzs2g8gvccUKCOBL1qsOQilDe9+7SNgHn0bZ/g/oWaALga0mbR/RvyXnzdelwetZS16wVF/xptV2tI6uTo03wQez8hRCG5LhqW+PuW9daH2tTkQDawSXXsePoyCqgwFio8pDbltyHfata03t7bjdv5pM7YSpqvfnzWj+ZOkreDjavrv4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRwaVdmcHRuTU9GRGtaZGxFZUlyZjNzOVp3S090VkZQYmFVNFN1eW9BZjJH?=
 =?utf-8?B?VG1tMktoNFlIWkEzNGJRZk5ZYVNVeE05Unh0REs0Y0lML2FoWEtXQ2ttbHM2?=
 =?utf-8?B?RG5FQzJvNkJ5TjRtbUxSS2lOMHdab2lFdjJ5bDZySjJiUTdQWWQ3Y3AzQUx4?=
 =?utf-8?B?cCtrUDBaZXlsNjVRRjd5WHBNbHZ3VURZdVNHL2dQWUJLVG9ldW10R21vSkU0?=
 =?utf-8?B?dEd0ajV6RnNuVDh0MHhDcURUWlRaa1RvNWJrZ3l3SXNQeU9NSnpqcTdMZzB5?=
 =?utf-8?B?U2FTTHRyQk0yRjBXRFpxem1GZFhrNnpvWnhhWk5PRExWS0RMQ3VaNzNqM2Jp?=
 =?utf-8?B?bHc5aUQzUmZIbm5vNEZpNGhHekVzd0dNZlNJSWhyTzl5b1E4d2h3RCtuc3E0?=
 =?utf-8?B?Tk1ZRmVlSzNMOUUzeEtqaVJYeGE2cXErRmxYZ25UdVVXVFZxWWpzdVNScUpR?=
 =?utf-8?B?MWRIc3Y5MTAzYWFFeDlZaUpST1d5VFoxQTZmRklicW4xOWRJZEhYMENkc1Jj?=
 =?utf-8?B?cnZrZWhPV3hyWEZMcVF6aGROUkd4MUx5Y082R0RBZGZMWFF2SmFhNkZnRkNF?=
 =?utf-8?B?SUx6b1dEZUJ3TzMvaHFZT1FzdUgvU3BXdGVZRzFRQldnY0g4bXpkYWJhNy8v?=
 =?utf-8?B?aHFkS0ZIYmF6bE13b0VRckQyc1FQaFZuSzFQeUFMNFYyL0IvY1FZMWpYV3dT?=
 =?utf-8?B?Y0swcTM5bnpheHl3dFBBdW5SZzgxbzNWM253bFFNaElaSlYyUGgySms2a2RH?=
 =?utf-8?B?ZG9hSXoza2xPQlVVdWExNWFXQVN6Tk56ZU9SUGErclBOVGUyMDk4d2dCek4w?=
 =?utf-8?B?Sk1hNk1sbEx6enU5MVI0eVhjZkpYZXRNN3BpTTdrTWx5S2lDSjBVd0c4am5H?=
 =?utf-8?B?U3ViMG12RERQUVdCQ3E4d0pNWHdpU1l1ZGY2aGVtQkFBY2NteHhBYmVCQVRa?=
 =?utf-8?B?YkZRREl1U0JOUm4wOUdxQWpydHN0RDRtWk1sM3lKQXhKbno5SHpaZXZFcjl0?=
 =?utf-8?B?UDk1aXNwN3Z6a3ZTVFBxeWhLcW5GbmxQOWlKdXNPUVZIelptcnFrbDhhZ3V6?=
 =?utf-8?B?RFdkTTNPaHZjeG8yd3MzWkNhZTM2YzBKa25Db1BybEJUK2ZpcEhtN1NTeXVB?=
 =?utf-8?B?RmJsL0p5bW9DWUlqY0xTSjk5NFR1WElUT2EwYXVqYXpmMWgxQmpCanRVSkVi?=
 =?utf-8?B?aFJMcDcwZ2lXaXhXUG1wZ3U4NTNNSm85cnJSZE5GMTBJUVM2NWtjQ05qN2dw?=
 =?utf-8?B?MmQyVUhkYXI4a2pvK0hOemNHMU5KVmNsMWV4M2ZEMUtlSTRVTG5TSzludDVY?=
 =?utf-8?B?bFNiTFBES1Y3d1hTVHRFMUg1d2xSTDZTb1R3YVRHUzNFTzNlTkZ0THM4d2x6?=
 =?utf-8?B?WldIaHB2cWRQMTJkZTUrYklyNURkZHBGOHkxc3lSa2tSYzlpb0RWTlBRYzdZ?=
 =?utf-8?B?V1dNM1hjUjFDQmxWY1RsZ3BBUU1aN01Jd1B4SEw3ZjFybG5mR1VCeUhuU281?=
 =?utf-8?B?RzEranRaM2NoeG5zVWJkSy9UM3UvUE1Ib0RmOVhHSG9BRmZ1a0IxZHVVVGtS?=
 =?utf-8?B?aUhJWk9ZZ3YxSVhUYUwxVm5KaitVSzhJb0tGU0dsdFVaRDVySGJaazN5bzJX?=
 =?utf-8?B?MXV1UDNxVFFYeEk3ZDI1a0JLQ3NMTjlnTDFKOEJhTmYzV3IzNFBMOC9zeTV4?=
 =?utf-8?B?THB0VHlueElNNnZCT0tYcjhZbEJtTWdJYldtU21iNC92OUg4WHdQcmx5bm5j?=
 =?utf-8?B?S2I3bUlBcUlHb3FhSUhQRVVBczlBQ2pEb1ZKcytBb1g1TE1HeFhUNWZodWdj?=
 =?utf-8?B?YU5lTUxpTy9KMWNxZGEyZmZ2Q2E0Tk9RVENzOU0xWE9SREJ1UFp2dVhFcnpn?=
 =?utf-8?B?V1ArRkxsZEY0UnZkK3RWcStzdUFBT0RQNGhnUkJyN3FLTFhLZkF5QzRCRjZS?=
 =?utf-8?B?VmVEcG5XUGR4NTB2bk44RXlLNUs1cStCMTZNWTV3bEVrRzFoZGc4dnM3ckM3?=
 =?utf-8?B?aFN5NER1dVpTMEFRNDNiSUNIVkEwS3c5dU5ORk56VmFPMmlIak14OWJnL3NF?=
 =?utf-8?B?azY3N0hhQ3ZHZXJSZG93TU81R3JkejUxTFFRWE1FUEhKMHR1UUIwNE5ubTAz?=
 =?utf-8?B?NWlLL1BuUElNSTBLWnhLM3AvUzlUN0JUazh4L09BL2tMR09BUk1nWGhZSnRS?=
 =?utf-8?B?WEozVWlmZXREYTJyYXVRMkxWZHR1YnJNUTZXblJOT1V4dDdEcSsveWlWUGdq?=
 =?utf-8?B?dWcvdDdUaUR1YUk1ZVJkcHZSb3hBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82487437-f00b-422b-0677-08dc33d23076
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:15:03.0697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOSXjkoBjqcFLnMeaXOu+GSw9syI+QpP5IvOwcK5EacrKGj4oWcfUm9iKr9DwTtB2NXlxNPfXICHOhfWg6d7C4D7MIciUCmargfNPsyUIIfqwsSky9ucaqfLaeZqOMt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7137
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

Hi all,

On 2/21/24 18:07, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This adds support for the SARADCv2 found on RK3588.
> 
> There is no stop callback as it is currently configured in single
> conversion mode, where the ADC is powered down after a single conversion
> has been made.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   drivers/adc/rockchip-saradc.c | 76 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index b5df58fe3eb..05c93cedcf1 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -10,7 +10,8 @@
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> -#include <asm/io.h>
> +#include <asm/arch-rockchip/hardware.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/err.h>
>   #include <linux/printk.h>
> @@ -30,8 +31,37 @@ struct rockchip_saradc_regs_v1 {
>   	unsigned int dly_pu_soc;
>   };
>   
> +struct rockchip_saradc_regs_v2 {
> +	unsigned int conv_con;
> +#define SARADC2_SINGLE_MODE	BIT(5)
> +#define SARADC2_START		BIT(4)
> +#define SARADC2_CONV_CHANNELS	GENMASK(3, 0)
> +	unsigned int t_pd_soc;
> +	unsigned int t_as_soc;
> +	unsigned int t_das_soc;
> +	unsigned int t_sel_soc;
> +	unsigned int high_comp[16];
> +	unsigned int low_comp[16];
> +	unsigned int debounce;
> +	unsigned int ht_int_en;
> +	unsigned int lt_int_en;
> +	unsigned int reserved[24];
> +	unsigned int mt_int_en;
> +	unsigned int end_int_en;
> +#define SARADC2_EN_END_INT	BIT(0)
> +	unsigned int st_con;
> +	unsigned int status;
> +	unsigned int end_int_st;
> +	unsigned int ht_int_st;
> +	unsigned int lt_int_st;
> +	unsigned int mt_int_st;
> +	unsigned int data[16];
> +	unsigned int auto_ch_en;
> +};
> +
>   union rockchip_saradc_regs {
>   	struct rockchip_saradc_regs_v1	*v1;
> +	struct rockchip_saradc_regs_v2	*v2;
>   };
>   struct rockchip_saradc_data {
>   	int				num_bits;
> @@ -66,6 +96,22 @@ int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
>   	return 0;
>   }
>   
> +int rockchip_saradc_channel_data_v2(struct udevice *dev, int channel,
> +				    unsigned int *data)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	if (!(readl(&priv->regs.v2->end_int_st) & SARADC2_EN_END_INT))
> +		return -EBUSY;
> +
> +	/* Read value */
> +	*data = readl(&priv->regs.v2->data[channel]);
> +
> +	/* Acknowledge the interrupt */
> +	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
> +
> +	return 0;
> +}
>   int rockchip_saradc_channel_data(struct udevice *dev, int channel,
>   				 unsigned int *data)
>   {
> @@ -104,6 +150,24 @@ int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
>   	return 0;
>   }
>   
> +int rockchip_saradc_start_channel_v2(struct udevice *dev, int channel)
> +{
> +	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
> +
> +	writel(0xc, &priv->regs.v2->t_das_soc);
> +	writel(0x20, &priv->regs.v2->t_pd_soc);
> +
> +	/* Acknowledge any previous interrupt */
> +	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
> +
> +	rk_setreg(&priv->regs.v2->conv_con,
> +		  FIELD_PREP(SARADC2_CONV_CHANNELS, channel) |
> +		  FIELD_PREP(SARADC2_START, 1) |
> +		  FIELD_PREP(SARADC2_SINGLE_MODE, 1));
> +

This is incorrect because we need to also write zeroes in the 
SARADC2_CONV_CHANNELS bitfield and rk_setreg takes the argument and 
shifts it by 16 for the write_enable mask, not taking into account the 
mask in which those bits are set. Will send a v2 soon, trying to figure 
out why this isn't an issue in Linux kernel which is using the same 
logic....

Cheers,
Quentin
