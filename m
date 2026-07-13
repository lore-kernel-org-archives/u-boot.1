Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B8C44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F8C84AD9;
	Mon, 13 Jul 2026 14:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SJcOTUJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B95684ADB; Mon, 13 Jul 2026 14:01:11 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E821484ACE
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knASMcLWR+xKuhhwR17o1zhoANdG2tnHq+GpO3cqNcV9PoZ3qVn3eW+wv4ldQHLqoIuv4eJ6cvQQUJgMBxSRb+DteUQtfj7L5C62/yolT+MGUQs4v5cQTndXHY9L6Mf6ty0EtPMulVtS10vhIbbjXt6cGbu9ABA14Re/C7qpnZNotMK/hH2WEryYtU8eO2hzXcshK0q+lvtKGfADafCuK4MiIjXxAUqtOcIw3z0IXVZfvnP5K+b8Jb3DWxFh33Ls/PfH+AfMAd+Mrc0YR9OqYTs/NTC+ugFZ3KlFbbZ7sRE3Iq9gmAfK+rGxFLzURT6SzD+E00GAQDOHeU5AmRoO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwMzR6x9m3TYQLq73opeIWEj8dK4tgjH6qsZnW76y7g=;
 b=raeOXfvcn9Me4U9EY3fvQrrMFsYOVp/kMJaEtuc9yizxH61faSpiJb1oi01J3HpZ2lPJlB/pWW4rRm0I8iIWcbQHVNRRLrd5V9kxI2hLh5eoB2VtCTvIfKya9bvH42U3N8c2an5JeJUG/DeFT1k3fM/E/jqbTaoUgvECTkHT+sK2mr6/nKdDYBcnMG2CTARkA1zel4fI1Nl+rS6f+Ar2kAbVIEEwyuPfQkjKeb1MVazXyNvmcOThB7wnQUrZlr66F/p8b0+BAV2Hg6JO6eO8K4/Fc/fTEggpMYroaWKFFHUrsLXtcpFzlpUaqyTqVYp7gGJ8oxB3N22rx4ou1zlpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwMzR6x9m3TYQLq73opeIWEj8dK4tgjH6qsZnW76y7g=;
 b=SJcOTUJu8Pk58vqRqg4b8c+Uo/pILxYP8A7VNNNFteFMpriuCRC6KyHOKXH3geJZRc/D4CIYg6LB6ddvF0z2guCBVzUAAOIFz+a2sfKqCtkK+Eg7gtdN+z7siAliAvSd0Ayzi8MKM+ii6VP7ks05R5nRxH0C6VegtxCqmPyGdH9G8K2dN7UrxlxBTTEC1NTAh91739HABcBuuvLa6GUnyE8raE7171MM9BF95HWWedUW9e0xTBec2oIr4swEltuToNgySJtA/dL4epOsRb+IrNWOQQDoXIG+sKIX92U5oN5Yxd2+3SXp8n3OkzJa+s7AcWc9Jp6o9kZ6GBsoMq0HtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DSWPR03MB989130.namprd03.prod.outlook.com (2603:10b6:8:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Mon, 13 Jul
 2026 12:01:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 12:01:04 +0000
Message-ID: <3acc5bc7-86e6-4256-b9b9-67fb750a035b@altera.com>
Date: Mon, 13 Jul 2026 17:30:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x: Add GPIO settle delay
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <20260710230409.147210-1-jm@ti.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260710230409.147210-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DSWPR03MB989130:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4cc523-20d6-42cb-f99d-08dee0d66961
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|5023799004|11063799006|56012099006|22082099003|3023799007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: a6ysH6kcz35fY1s9X/CJbl6k8f39YachOTPvewThXzqPKeUkSFWvOqxrdRwxJMciCbkko7XDt7ikmIp3DyzVErKbE+uZpP2hTvxAQE0rQCbdNBIuloJedzpOEN8lI2Qv0cp6WrZVb12amUkjxrZ9+ImckrWy0LVIGXlvbcMZwZ95aNXHMuZCQwZ7VpVGMZP7W9jwTHPIE2ceIIhjm6YshDZU80XZ/EO5Qbe1r6LgibWXxn+YR3HwLuzA/goaHFMTUotP604kzQnSVL0KB/5J2orJuT5h0sSPg0atnUy28a8z0oM/3vZ7uFCy/CHCdeJZO3ga4XNFEUJXDFGjXGCFZA32HaG7y69QZQ6PGH/q9uSfRgRO/HqJ+nJmcXdLOGsq3SUWc2rqhiOjTM1AUF5LzVjjlP6goTSJPsv9vbIzb3bfSR8dULf2xUHZXYhrmPCnDith9ZvovJG5YlY6h3HAzSqitZzct2x1PqlvalTK0hX5FA05KSRtdmogsPP34pBVfvVuFq/VcmKI3ki69CnUPMboXmHFi5mAcOKwe04buQzi99l+zx/bIEBxzAv/GiyAUD0HHyt9hSnBHIqvkDXsxA+X9CrAjSpIKSRQQ/gOZvpkBQDcRER+vBb1H9AsIDW90diAcjRFVT4wBJj+tqOfvbk3J4K8fOomYY+RsQvnxfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(11063799006)(56012099006)(22082099003)(3023799007)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBnZ0ZIM0FLUjR6ME9NT0VGdkJKa3dEa3NZSVllT1B3ZG1HUzlXRkp5OVQy?=
 =?utf-8?B?OHhPNHhVRVhKMHozcTBsTUNZc2FBWUxFQmQ0dTZLTHQvU09YN3RFL0hGclZS?=
 =?utf-8?B?V2tYODV1MGdsZkNSNVdJdlh0bHoydm9UN2x0ZG5VSEwyMC9GamJjUmZXdE5X?=
 =?utf-8?B?M3p6TitsZklNNFY4N0NzRmM1b1pWUGlEVTlnSG52RnhLV3RIYWlsL3VzUCtO?=
 =?utf-8?B?N2xHLzlJZEFBeUlLRUVKbXN2UE5jSWcxZGw1SDFlZXpmeElJdERKMmFDdHZo?=
 =?utf-8?B?Zzg1QmNPeHFMRGY1Q2g5VUdhVmJYMEpFMytydHRkd0RzZCtPcUtpbWUzTUNm?=
 =?utf-8?B?Q092cFlkQTIzczkrQmRrL1Rhak5hL3IzRWFjYnNXK2d1TVB2Q0xjVnJNeDhz?=
 =?utf-8?B?L01lcUxsOHRQV0FIS1BaOWNPYVVqNDliRG5wQWp1ZGFxYWdVNUM3eVZBbnFh?=
 =?utf-8?B?Ykc4NDZtOHhkTTlEV0tib29CVStzejJpWm1NZGtyaHRlYXlmZVRkWGRRYlZu?=
 =?utf-8?B?M0FmaTdFZWtITDRKUWg1YmQ5aG5iWktuNlZHQlhnNEpFTURnenZGMVFlWHZN?=
 =?utf-8?B?VDNIZzh1c3VqY2x1T1ZJcFFma3pkelYyd2ZUN0IzalVpejVGWm5jTkxEOUJZ?=
 =?utf-8?B?dEJibVBMY3pYMk5jdHFuNTFxd2xTYkV0RGRLeTBsVUVybWVrdDJGQmlJZEMv?=
 =?utf-8?B?NnVHcUVxZzlaMHhwQ2paaUplN2EyY1hCMEphdDZsQ2Q0R2lpcUNETmVmK052?=
 =?utf-8?B?UDIxc2pwa3hvZUJOaXI0aHZyWk9rRXN1SVVsT0F5RDJxWlZQbDd1anZkRFh2?=
 =?utf-8?B?U1plU0VWb1BUV0VwVmFya2ZaYjZvK3VCRlhwT0tycHJjVHlKQWFUM2ZPYkNj?=
 =?utf-8?B?TnYrQTFuS1JBYm9PYkE2clpydXpYZ2NlaFZwNXZyb2RlS0VDeHl1Y2lwOHZE?=
 =?utf-8?B?WmxVTGxpVTRyTmFYYVNDTnJ3WjlJaFpyYk52ZHU3cGNEb3B6d3VKVHlRNVVq?=
 =?utf-8?B?UlhHWmh4bjAzVStMUUN2OG03Q1NNdjU1R0tqWjcwWGx5dmFqWmNhVXF5TDVL?=
 =?utf-8?B?OGRscXViUVlBTitVU1lHUXQvSkxNdUJ3Ykk5cjlyYmxKNXpGcXNmbEJjRGVG?=
 =?utf-8?B?WG8yeGhvNDZ0dTNnT3crMlRlclVjTms2aWFWRjd3T3dqSXVZc1BXcjlUUjV5?=
 =?utf-8?B?amRTSFBpYldMN0RuU3lvMEJFNmVSd0FqVklnM21XT2VUd29lTGJOWFcvVS9q?=
 =?utf-8?B?VnRCdzAwLysxOVdvWlJCUHU1Qk0wVG42WXU1dWYxOEFDZGJLNUJNZVlSNlc1?=
 =?utf-8?B?SXBSMld6b05uSXgyTkxNUFZ3MDRTRVIycE80NmFORlF4VTZ6MERKYlg0OEl3?=
 =?utf-8?B?dDVCYVp5bkR4Z1hFcXVuQWNuaUIrR0I5RTF3YjBSSHhtbnBjaG5lVUN0VThm?=
 =?utf-8?B?eFhWa1laeUg0QzU0aXJJWEl3Sm5zeEFycDN3NTZjSHZjVXZ4N0lkNlVYckRJ?=
 =?utf-8?B?dTlmLzNCNWgxREhIeENXNTBKMHVkOCtDQncwclZDc2xiWGloZVZQa0NOTS9p?=
 =?utf-8?B?cXIwT2l6bCtSNUs3VXFiaFpMLzZrVWxScGxNOUtRTzJOaEtGanNiVkhIdFFH?=
 =?utf-8?B?NUpZWmVRN1FTM2lIK2xxVDdJUFNrTXFFKzZxMFVLYW5Ub2IyZ1FJTEZMVGJD?=
 =?utf-8?B?ZldmQ0syVnozNTB2cll2TVVrSFQyRW9JNDBGSHVPUUtWSFR0bS9Qb3hLTkFr?=
 =?utf-8?B?MVc2SyttUmhvSkMwdUlOeDE1TXIvWktZbXh6STVzUUlROFV5Y25iWUpjR0U3?=
 =?utf-8?B?OTFYWkd6endjbThrb3k2THBOWEVQWmZXMXZRTzRvMHE3WnlOaEpsNlpRKzVp?=
 =?utf-8?B?QUJGNUlMbUJKMjc4Y3NNRHRCUzJFOWMzN1hmL2tJMDlZMnFaa1YxMWxxQ2l5?=
 =?utf-8?B?UWU2enNsbzdVeWxYNFR6dWg4QnJRS3VlR25rN3VlaEdyQXNYRVFDY1E4UGNO?=
 =?utf-8?B?NTJpYnRzRldEU3MwcUptL0JLTHZxYjYrdERXRDVzbkNkV3dvRzRRNXZ5WGRh?=
 =?utf-8?B?TUdSeEQ2bTd0aG1tQUovTkhmdkVuMEVCamtGb2dKd3l3R0IvWUFxSUl0clBt?=
 =?utf-8?B?emI2eDdXcER0R0ZZTEtvSEFvUHg2NUxPa29TWVRJbUFtQXpQKysvdHkxWTFz?=
 =?utf-8?B?bVpaeWV0TG8yUTdHMERmK2ZtSzJ4UWh6RnIza3Z5VmdjYWEvTTExSXU2dFJI?=
 =?utf-8?B?bkNUeHM1NFhWWnZaVGFOYmtvZG1jdlo0WWxtZlcvaEhhaStSTUgyWFFwbFQ4?=
 =?utf-8?B?TEp2SHN2SUR3RHBTUTY1WDNKRTU4WG5aNFdGaWptTkNWL3JPbDV0Z1JkbVJM?=
 =?utf-8?Q?vVOdqbjXsb9JbOQQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4cc523-20d6-42cb-f99d-08dee0d66961
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:01:04.5978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY7XeZnvy+WgPEt9/fvGZVqRR5xVhJfk+gRihYUEwA6mBGz6Dqgzmi2U1l0XfNqLb1d4Xpf4e4ZF2kdUP4Mlleky51fnrVqEue8hFUWSa44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989130
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

Hi Judith,

On 7/11/2026 4:34 AM, Judith Mendez wrote:
> Some board designs have slow RC circuits on GPIO outputs controlled by
> PCA953X I2C expanders. On some board designs, pin voltage transitions
> can take significant time after I2C write command completes.
>
> Add an optional "gpio-settle-delay-ms" device tree property for the
> pca953x driver to add a delay after I2C write if specified, allowing to
> compensate for slow RC circuits.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/gpio/pca953x_gpio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
> index 965a5fcf30b..54b957069c9 100644
> --- a/drivers/gpio/pca953x_gpio.c
> +++ b/drivers/gpio/pca953x_gpio.c
> @@ -28,6 +28,7 @@
>   #include <dm/device_compat.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <linux/bitops.h>
> +#include <linux/delay.h>
>   
>   #define PCA953X_INPUT           0
>   #define PCA953X_OUTPUT          1
> @@ -89,6 +90,7 @@ static const struct pca95xx_reg pca957x_regs = {
>    * @reg_output: array to hold the value of output registers
>    * @reg_direction: array to hold the value of direction registers
>    * @regs: struct to hold the registers addresses
> + * @settle_delay_ms: GPIO pin settle delay in milliseconds
>    */
>   struct pca953x_info {
>   	struct udevice *dev;
> @@ -100,6 +102,7 @@ struct pca953x_info {
>   	u8 reg_output[MAX_BANK];
>   	u8 reg_direction[MAX_BANK];
>   	const struct pca95xx_reg *regs;
> +	u32 settle_delay_ms;
>   };
>   
>   static int pca953x_write_single(struct udevice *dev, int reg, u8 val,
> @@ -116,6 +119,9 @@ static int pca953x_write_single(struct udevice *dev, int reg, u8 val,
>   		return ret;
>   	}
>   
> +	if (info->settle_delay_ms)
> +		mdelay(info->settle_delay_ms);
> +
>   	return 0;
>   }

This delay is placed inside pca953x_write_single(), which is called by both
pca953x_set_value() and pca953x_set_direction(). This results in a 
double delay
for every direction_output call, which I think is unintended.

Additionally, a settle delay is only meaningful after changing an output
level — it represents the time for the pin voltage to physically settle 
(e.g.
through an RC circuit). Firing it on direction register writes does not make
sense. The delay should be scoped only to pca953x_set_value().

>   
> @@ -333,6 +339,8 @@ static int pca953x_probe(struct udevice *dev)
>   
>   	info->bank_count = DIV_ROUND_UP(info->gpio_count, BANK_SZ);
>   
> +	info->settle_delay_ms = dev_read_u32_default(dev, "gpio-settle-delay-ms", 0);
> +

As Francesco mentioned, adding u-boot specifc properties causes the 
U-Boot DT
to diverge from the Linux DT, which violates U-Boot's policy of 
maintaining DT
compatibility with Linux.

>   	ret = pca953x_read_regs(dev, info->regs->output, info->reg_output);
>   	if (ret) {
>   		dev_err(dev, "Error reading output register\n");

Given that the delay is due to a slow RC circuit on the output, I would 
suggest
looking at the gpio-delay (gpio-delay.c, binding at gpio-delay.yaml). It is
designed precisely for this scenario:
"This binding describes an electrical setup where setting a GPIO output is
delayed by some external setup, e.g. RC circuit."

Regards,
Tanmay
