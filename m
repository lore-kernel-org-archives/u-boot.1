Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F6BC48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 18:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE4188053;
	Wed, 21 Feb 2024 19:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="MILlih3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A218805A; Wed, 21 Feb 2024 19:18:58 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFE0876F4
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 19:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXMF0gLcE+5KIm+393R54yqzSpH/leJKdrcifcmXlf6J9iri4ZoTw1+oO+pGiOhkP3dCNnQygQnXisPdlgALWq5J0aLm9vPvISbM936ZyD4Nt8P2TBKcogQNPVe+UVjrsMSndorbTqrI9Lbcj+t4xPRyTULbIV2T6F8oj0pDRVzu6CU8flLDrUP64i3HUohwzaw0o9xEX5+Q/Ew6aOu+iQRJO2jlRu7AfaxiyZl2C/sXROVSbnHiLM2oj3Ria7p7XjjdT6Wq+cdVV4fQzAUq/AKqgw80Jnu1Dsq2zjwnAsJn0hKq0f7KsPcRpmkq2xOTQt8hp9+c2lF9qSlZ80aBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48y0pXUyeqpTAiwzUo93OjdP/JO6kQlAeRj0UkrmYlc=;
 b=WnPvQ2jwblaRBLI0NxtnafVP6d5DrnL1eOlia4CUTEWRax1qA18dtWZ9COy+kGY+GKVy5TIFbZ7LjugEojh8uuZibvoLbKbrRAl2h34w3M5hOGlY4Vv6vciAITohqCNRMQRCBZcd8iz24CmRyWVMDpLfetJxYbqP6Lbr9L8QXivrkXyo0QLcyxWtPS4pt4LiRCKzmoR7/ZEfVfxQXJtpcO7yMzKvd0zs/8cf0MBeJbq1/V9bHpvHjWZc20wrpn52AvPxGBlu+iBQzcTZJaNxRGptyirL+Vvp9JG0W/TcpWT73WeLdMC0k67jB+69WJ9AmwIZzb5x0sK2JYGwiy6XiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48y0pXUyeqpTAiwzUo93OjdP/JO6kQlAeRj0UkrmYlc=;
 b=MILlih3zZmU26U8Qjq/0GoKFiRMsb/j5CS7HnscWTuI45Mx08bv7SRxs8E43rmV1pq+1pcIVSukCFvpyYapevawirWusHXkMso9uYdtd6KdcO6zMzpHesRUUAEgfCboe9wXGlmmcWJpGZvAjpEzqRUuP7InoPrT+aVPHWS/udNGUjWUwsxctcUdAo77slVoksFSdmUU8Mo/gkZLuWVThRhc3HJtQmMpPUG5ZSLXm/PrDNifRBYPovJV28/UZ6DiYQmAQtPkTMs5Mvv3CCK62YV4+aQoXhVfIlYpu7CRDPjCApztM218BcUKSy+GjBLeT4R5G/VxlnVpvnZ3TuSffrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 18:18:53 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 18:18:53 +0000
Message-ID: <f00195b3-b410-4e1b-ab56-c448e8f530cc@theobroma-systems.com>
Date: Wed, 21 Feb 2024 19:18:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: io-domain: Add support for RK3399
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-6-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240217183610.2621132-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c422166-ee1c-4df4-5c7c-08dc33098f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aldbvbn7n5YCisOxkk5UDn6zuidbm0h7XoGqp5qB3/Bpt4MQgsnQjy8LX1DLBR0z8vdMXigtAxNWcnY3jgDvnKVa9fzYReE81nh2Whoyf2i9ZBzNS3hXe8hQgoON+0fpzDbGee8Odqjama/aw4bN+iXZlEt7qEDfdkckdctElILbmAWpAslgWL6rQ58kyVY8JTsxgEQYqCpyFklYtDJrF3HX0v2JM7FnUWzRQQIsWpDoNKEHMyWMEBzP9Dl8h4ph/iMsZ0C5mDuSJKPcMXIwsxGmrPqxRyvS4s0Ljda3ZwS+4NBpnqV9L+L18P2hCPSqyf1EmwV53VQbFfWuSppTMr2y8hzjEYCuZtj5DNBcU71CUuSe7dmCRkMOmFDvoVDsBqPxBMJt0x8hxsM+7HnDJB7YtIsLBVKRwfBlmv6qIxi45sIazeSdV3y9Xk2wrx64OPkSN4slk6x8cYk8VwU0vwjU+DsZi+LDyoHJKDkBV2z+pEpcOWJqm8zkmXmfqM+qDPLd7pTQFBDnHYHpIIg77o/w8U2MR4WIiQjgSrR/GCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhReHM2Uk5oc0RTWVpySlNSL2R4MEM1MGZob0xIa3BlWlhobktjaTNuLy9t?=
 =?utf-8?B?Yk42L29mV1F0UFRmcDROV2MyY29uVnBPNTJwMmNaVmtpY2paejBmdm5GdkRK?=
 =?utf-8?B?YkVMWE56MEpxeW04WUxBWmlza0llSVRiYUVBNXhsZnlqbDlGWnVTVU5ocldI?=
 =?utf-8?B?MGdqdyt5ajQ3ZTVnS2tWNDlDdTdMc0VSTURqd1FkSlJHNXpaM2dBalRsMzVr?=
 =?utf-8?B?Qk9SOWhqS1NrT01SZEttUmFFdWFhMlVhSEJSVEowZytvMjVEejJMWTB0SGpw?=
 =?utf-8?B?eVloUCtwSGliNDNMRUdLa3l3a0VSRGhDbWFEcWtweXpFZEJ3NUdXQzNrdXVy?=
 =?utf-8?B?b05vcDgyRnlxWXJzZ0N6SGNLSVVCQUxRRldWYXNNQldidnRQQy9taCtYM0dB?=
 =?utf-8?B?MUNydFowTkx4TGZlU2E1dmU2NCtqUkptdmZ6ZXBHSnp6LzhmSXVmT3F5OVgy?=
 =?utf-8?B?NE91OVJDTTREMWdiNTBLVGFjc1o5djhsdm9UV3VNOXBlRVJMSGpLK0NUejdG?=
 =?utf-8?B?MzJCcWg2UytLcmNaLzErNlBWUFkvZlJtMWEyR2w2dndLdmZsL3VMR3p6S25G?=
 =?utf-8?B?aHhLeENjV21hclBTQlpUNVYvamY0ekhOSERIWmhNSW12TFBDZi9xVjVjelpJ?=
 =?utf-8?B?K01tYjFEcXZIUzV5M3gyMWcybHYvZVgvME1PMHZpTFZUaENVWkI0azBPZ0c3?=
 =?utf-8?B?T2o1blhhdExKaklWcmJ1NVYrcXZlSGJ1c255YTZnaUh0MXJhTnd4MjgxMGZv?=
 =?utf-8?B?aVVSNFJ4ZHlWMktQUklpK2FZdmtYOXZoUWNzSEtWZmRUZzg3MS9rWkRUNkg1?=
 =?utf-8?B?eTg4VmpCM1RYdERpSmhRdmp1YnlrcVc0d0loejFwc293R2ZWLzNiamxNMVdE?=
 =?utf-8?B?R1FxWjFwaWxGNXorSlU3bTNUUkVzRWlzSkZXNlBYc3pJVUF5b0tUMDlIRU1L?=
 =?utf-8?B?ZVIza2pzTTgrSzMvRzNmemdCYUd5eGcweEpkY24rLzVzdHZ4SkFJem5PaFY3?=
 =?utf-8?B?OHM3U0VySmZPbnNjUEVTTmIwZGU3OGgvOWx4U2l0NHpsbW40ZURmZ0ZPYUEr?=
 =?utf-8?B?R0xMeGEwemhvOUtoUm9PVEZzZTBEVU9FMWhKNEJsejM5ZmFFYjYxeEJWWDcy?=
 =?utf-8?B?TWtSdjRsRlVFODA4YXR2UCsvVTdaUTdCS05qSlNSUEx6emdNZ3RNUmdFVGox?=
 =?utf-8?B?ODdHVUVYOEpRMjlIL3RRYzFreWd3aDZZQjdkK3I0ck0yRHdPL3hhb1NZYmFw?=
 =?utf-8?B?TG5LdE5CaFRJS0RaQVV3bC9xNk95Y3pFVW1DTFdTVFNXUFdlOEhlTUEwSGRC?=
 =?utf-8?B?d0pXbHpFRFFFeFBaNmxsK3FranZGVVEzUVE2MTk2U216bms1Y3o0WW1Nczly?=
 =?utf-8?B?TEF3aUhmcERXSDNiTzl6T0pmbkFEeDBiaHovWFB1VEwzVmxLQ05kVDVQNzdB?=
 =?utf-8?B?eFJ3M2ptNEF3cjkyL0lsYnZCMUkxTjNrZE9YYzlvZkxvU1RDdTgxSGwzdE11?=
 =?utf-8?B?clh4bUdwVThTZlkrSEFWS2VrUmw5RmNmNXB2T0ZqcUxuYkZqT09GMkpPTURT?=
 =?utf-8?B?aDMzYi9NcGxQOHNRcHIyRytSeWMxYkVzZEMwNXZ1RXlrcTRCdkZnQlpRVitG?=
 =?utf-8?B?ek1rUDQ0Y01OaTh6VzJkS3hYSmw1MG5wTE1SaHFsT3U4U2Q3elpkelNyUTNE?=
 =?utf-8?B?czB3NFFzVFdFa2FCWlNRZHNTeGRJVkV0MlFNallkQ0VFSUJwSHRKNUV1aG5o?=
 =?utf-8?B?SEFJbDl6WVJIMEdqUDJlVXZUcVR6UkRETXk0UWtnRGs1RnpoOEIrUEo3ZmpP?=
 =?utf-8?B?UXNqaW5GVTFsN0ZwSFN3TURxcnc1T0t1L0JzcFNpN0dRL3pOemVPdWZnOEpq?=
 =?utf-8?B?eFhuK2Y0em1FUVhwNDRvbTc0RDhjTC8vRDR5cmlUVUNubm45R1B0SW42ZGx5?=
 =?utf-8?B?aVRWVkJKRmtaUkljc0t1WmFHcFo5Z0xmODBSRGNralF1MWk2MmxhOVkwaXJD?=
 =?utf-8?B?ZHJxMnIzM2tFRW16eVFBbGlSWForaDJBVnRXTUl3enBxRHJJMDZNcG1GTHcy?=
 =?utf-8?B?TzQ3T0RqaXVJR3JrK05hWnBYT3A5bjEvOWNmWVB4RnFWSTBuOGoxVEsxSnVj?=
 =?utf-8?B?enEwZVR4MVRjWlZSdUJEclJqTlV0eFBsWFc0ekd3Q2FBeEFPNk5YZXNBU2My?=
 =?utf-8?B?bytwMjMyYzZFV2xlcEVkdWpJTDNrTmJjSUpNK1lHTVVBYVIzSnE3OWptUUg3?=
 =?utf-8?B?RTlRWmJVUlJIL3FCcGJqRGZ2RHhRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c422166-ee1c-4df4-5c7c-08dc33098f06
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:18:52.9172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gvQUyZ7oqfB921TS96mvfharb/uIbCDAjunVYZi2M2CcivE8UtwNw8XL0xggj5DABM98RN2o5Pjnw/ALJDS7UCiPRnDtdUfcEGzlSfzFwbJJNrhqkgZgjgQmv50Wlwv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
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

Hi Jonas,

On 2/17/24 19:35, Jonas Karlman wrote:
> Port the RK3399 part of the Rockchip IO-domain driver from linux.
> 
> This differs from linux version in that pmu io iodomain bit is enabled
> in the write ops instead of in an init ops as in linux, this way we can
> avoid keeping a full state of all supply that have been configured.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Suggestions below, otherwise I only have one concern:

This actually postpones the moment the IO domain is properly set. 
Before, we knew almost for sure when this was set, as it was pretty 
early in the boot process (misc_init_r), I hope before any device was 
actually probed. Now, because we're using the Device Model for that, we 
may probe this IO domain device after another Device requires it? e.g. 
for Puma, we need the IO domains set for PCIe to work. I assume if we 
were to use PCIe in U-Boot on Puma, we may have this issue (we don't 
right now use PCIe in U-Boot and I don't think we have any plan of doing 
so).

This all reminds me of the attempts we've made in the Linux kernel to 
make sure the IO domain devices are probed before the devices that 
require them to be set up. Maybe we'll need something similar in U-Boot 
as well.

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

You could use:

"""
if (uV > MAX_VOLTAGE_1_8) {
     val = RK_CLRBITS(BIT(idx));
} else {
     val = RK_SETBITS(BIT(idx));
}

return regmap_write(grf, offset, val);
"""

by including asm/rockchip/hardware.h.

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

Same here, but two options :)

"""
ret = regmap_write(grf, RK3399_PMUGRF_CON0, 
RK_SETBITS(RK3399_PMUGRF_CON0_VSEL));
"""

or
"""
ret = regmap_write(grf, RK3399_PMUGRF_CON0, 
FIELD_PREP(RK3399_PMUGRF_CON0_VSEL, 1));
"""

Maybe the if check on the offset is actually a bit overkill? This 
function can only be called for one IO domain since there's only one IO 
domain in the PMUGRF in RK3399.

Therefore.... Maybe just hardcode everything?

"""
static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, 
int idx, int uV)
{
     int ret = rockchip_iodomain_write(grf, offset, 9, uV);
     if (ret)
         return ret;

     return regmap_write(grf, RK3399_PMUGRF_CON0, 
FIELD_PREP(RK3399_PMUGRF_CON0_VSEL, 1));
}

static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
	.grf_offset = 0x180,
	.supply_names = {
		"pmu1830-supply",	/* PMUIO2_VDD */
	},
	.write = rk3399_pmu_iodomain_write,
};
"""

You can also keep the 8 NULL supplies before to not have to hardcode "9" 
in rk3399_pmu_iodomain_write for example, and still not do the check, 
adding a comment explaining why.

The code looks sound in any case, only issue I have is wrt device probe 
ordering in U-Boot.

Cheers,
Quentin
