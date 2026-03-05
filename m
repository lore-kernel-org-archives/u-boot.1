Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6B9EEF326
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B1983FA5;
	Thu,  5 Mar 2026 09:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QIHEaAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DD783FAA; Thu,  5 Mar 2026 09:43:56 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EB483FA4
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EifT/Qvk+qBWHr6twumRqLkfOKu75u41MEnQFOdk4kOGQKuOXLv9a9ImK0G0lMfeKFpn8uAlgOh8H9ZiR41OxRFi85rHdp5cr+aAnEjTBLg3P+f+U9RXRh8OmDg+V5Be5X7OIYPo+AzGPWoYtVXtFFKm1mF/kvCifPJqkjWYEBIRXpxZiNBYNXPcR7vHcyl2ONrxCjGK2gcV8EGIF1GMbj2BRcH885KGx5OFGTbj/rnex6DhOCE8pd2e4/8WRQnyunAFktfko695Vsdv2qUTxVw4Bauh/vGO7lqEwp9Jpqwyo/dfCza0Nd5ArR9v7T1C2kvAhDPmnwEa8c1leC69XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Y3nUDHlEPWSRJYUDuJBVMcc7iDsI9u4sJjBUe70w0=;
 b=O/pmbILXx31MUFSVVyrHYrkE2hsjRqgoAsoqvf47JZmlt+bZ+9VhjML1OaDlZDInmRPSrR5jGPDV+Wq60enBHpUt5N8Qu48BPmp8HQWd9amzF/17aT6wuL1YNKMoMv3z1dGrKjky8YFVkOt6lABUHEIPCTbnwwtN9z8bL/B+vh/Eu+T34l0hTZzPsNFVPHwJPgsfZpFpffc+PQXvTnL3TGxFtHbIFgOp3wPvG4ExqdzVPwJgdmUWsRHM10BqJfTk8LcrfncUAxOiKxxbQXtPfHbc6OLKtDDk2Dp9YmZOkCsHxu7BoKX1igcNVihcfZbuxBexpk7eDHSbqkWrrX0YCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Y3nUDHlEPWSRJYUDuJBVMcc7iDsI9u4sJjBUe70w0=;
 b=1QIHEaAftjCttmPW+7/+EU+C2TeGmfd8AeuJESySePoNh/qgl6cFQ7EAuDhKokpLyS/sgPzoRXKIDz8wXyyOPPJ8HPdE+DfefjUUFUfgWePbhDmOTV272So7j1tF3gH7WFflTh7MK946jPz1aesYULy0HFEAd70vsEOZWuXW+Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 08:43:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 08:43:49 +0000
Message-ID: <cdf99dff-ddbe-4c45-8660-ac926ad53600@amd.com>
Date: Thu, 5 Mar 2026 09:43:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence_qspi: pulse controller reset at probe
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20260215151639.3472200-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260215151639.3472200-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:5::28) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db14758-14aa-463c-8508-08de7a93523b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: zyhgphiTR3xDzliULc30CF6afTZuqaSinn3CxbQCSj/66PDuEZToZCSB/ACuKBR/iJ+VCpvUx8d+RZSX/tCMbrtFOMyyGGiUbYEhdVqVa5Z43JN7eiEHZhEY3bmr5lDa+c6zqDn5jhcWa7vodTsxGqXIws+e4X7TYmf87LespIpyN+I+DWR1P+t+07WyTG7nuFhwzZYUP5IEZfsFIes6oOwYA+dJ5I7wcu3gdiCIOYtTfNyqBxuMHED8P1/EF63XYWvRoQ8q/tfDYn89DLZT3c5DkIH8NjIbQbaUgQnanjFaQi5gqapiVWSHyU5hn3APuNgD10CFkmDY2Hyfo1sEZ7jXt1cgrvqBUkjms14hfPw/rvVM6Tf4VcMtCQPf9qsNXeMq/PSHCDa7m/6Manu98WLEU2GnwE7Uix87LLtrol3wFoLCGS/7MmCZZHmnN8DkD0wEAdA8Jj+WPiCzCzBz0R9jemvRrRzQ8Q3tPY9vyctrPO+DHpivofTXz+qaZzLCjwDJv9TN/DmOX0DCaeE+3L/u/DFbH36i8syvyE0y5W1HUk+YZrND4mmsxswFa+yKHIeUbavdc41lcxUXzD3S4eSJLs3jNe8uIFqEUakXDc8ivb9JyQgcMvfCkdbkkjkRIDNFVxvIsgh2zoLe5c2qAOyQfpf+4spo94YlnOjWSkbU+ocbduGDNXDuuj55CNQgu4jFpuBynCvTEoYTDWrmQjX9NvI0mYXX7pPgD8HCnxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9zQ1RKZjlzWDZ0L0pLWUlnYXMzSmZ3akd0US93b3o1TXorQ3ZuUXAzQ1Jr?=
 =?utf-8?B?ei93Q1pDWGpaSW5MMDRoSkI2NkdwcUpOTmdCMWFVSHhud3grbkN3N0pUeVR2?=
 =?utf-8?B?b1JNOHBUM25pTkM1MnpzZGJ5ODRvMllka0RIcW5ZZU1GZU9MSDJjZzkxdmNG?=
 =?utf-8?B?YjJ0dm5iR1pMMTBSTWpMMVBqK1JmYmtLa01wMEc4dXVDQUpoTTN2WDFxWHRO?=
 =?utf-8?B?dW94dXpOc1F2TzFxNzJkVnVDZHdlekpsSDZXdWxtN3Q3citQZDg2NU4yT0ow?=
 =?utf-8?B?WFpuL2JGZTMrVEpIWkJSb1VlMW9oeis2SHN4ek9KaVN1MFFOVzlTWEdhSjVU?=
 =?utf-8?B?c1htV0s2Y0U1SDFKdEhPYmtSclY1eXZhazVZNC9TdkpoL0M5RS9NK0lBYWVn?=
 =?utf-8?B?aEdNdjhlY1hDNXl3QXFodXBjeE5zbDQzK3dIM1VUM0NhN2JzTzVwTldDbS9x?=
 =?utf-8?B?LzZHMXZxcDBCcWQ2NzlHaThVKzhZU2VKRHJVSmtHRGVZM1FWTTFCWm1Xbmlx?=
 =?utf-8?B?MEpydFhua3VjSTFxZWs2MFFxUGxEOVRVTG9QbmFGVE9Wa1krTThBbUh1eWMw?=
 =?utf-8?B?R1BIdzFTcWYyUnQ2V0RwQTJYcE9odXBMeStYNFNyVnlYTi9GY01YamxzQ3ZE?=
 =?utf-8?B?c3N5NEUvakt6UE55WXVvcXBDT1Z0MVJEWEs1QVlnK3lYcGtnN2xqVk5wWmJl?=
 =?utf-8?B?Y0M5OGd1LzdoSnlyOTkzYTdzd1NKUHV0VWppRGdsazViMS9Nb0hOUDQzYmlV?=
 =?utf-8?B?NEEwSXZnUFFCa2FDQ2k5bTZOYlRRL2UvTHBJeU5CNGZqV3FUUzNiaVpUVS9X?=
 =?utf-8?B?SUlDUzRrTExjV2ZMM3dNVzI2Y0xUQUE3OGd2RGdKTVdUcjNWZzFzRUpTSlBD?=
 =?utf-8?B?OTdxZStWVTBlczBvVzhTVzZPZldlUmplR2hpWFg5NXQzTE5wVUNFUjJNVEF3?=
 =?utf-8?B?bmRsUnl5c0QrVzkreDdITXRkTlhzMkhEV2NkQ2tuUm1ydWZuME1LY1pwYzU4?=
 =?utf-8?B?eVNzMkZxYnNxNHRyd0NVWk04cVBmMXZ1bGo3V1F5Yk9Neit4YmFxK3l0YWd0?=
 =?utf-8?B?aG0xY3p6VFdZQWZseUFucWExOG9laHR1M1M2K1hkVDZlMWxVMTVnYXFCTTdk?=
 =?utf-8?B?MVgycUloKzJwM21hSmJpSnRGWUxnaGpjR3RDMVFNS3Jlc0w0d3IvUEhtWm9a?=
 =?utf-8?B?emE2UWJqOFZnMVlHMXgxQUE2c2xLV0dSWFBiWlJwOWE0SXMwanlIN0pGUHBO?=
 =?utf-8?B?dnVwbkxtY1UwNFQvRWhodUVOTEpDUXMvMnRtTVNPajlGTXd0Zlp6V01ncnFX?=
 =?utf-8?B?dDJSa0N3ZlJnRmRmQlgyTUlxMHNKU1hFL2pZNzNWV2dIdFdHblFXU2RSNXVo?=
 =?utf-8?B?Z0pUN0Z5RVVhMEphVVJhQ25NTFJQN3IxM3REbEloN3RIb2tYN3VnUDdaSTlG?=
 =?utf-8?B?SDBNekJjQmFFYkhWVDBlcjZiYzVSWE50UGpOa2k2U01hKzRCZjNnWUltL0pU?=
 =?utf-8?B?T0xscVdPQzRUVjFQTXV6NmpxZ1lnaWprOVBqMFI5STBmSEMreVBVTU41aHRY?=
 =?utf-8?B?OWhsSjR5YUhJRlJKbVFnU1NidDZtK0FWNjZpSUZ1N1pvQ3VuMi91K2JCcWVL?=
 =?utf-8?B?N2lVeTNNYyt4bnk4OE9RM3EvWUNLUkNSYlBUSEljREllc2RVMXUvY1k5aVow?=
 =?utf-8?B?WnlraHhGTlEycmVjVTBLYlc1OVIrV1RRcEorYkpsWnBhaEtqRzZxc2tETTB0?=
 =?utf-8?B?VXNyaFVHejc3M05OZmdQaDQwUlhSOGx0UW1oeXlmZWQwS1NuQWU1NkxONUxl?=
 =?utf-8?B?YXZyU1o1ZUYveWpibXpycTR6K1FvVy9xSXo4b0NRZVZVQnh1V2NpdTZvQ0dS?=
 =?utf-8?B?bDEzclU2Y2pHTmRXYmxNbUFoaHgrTHVNNmIxYmhEOXVSR1I0dXdtZVQzVlVp?=
 =?utf-8?B?aHFGaE5FMnBXMnZIbEJLM2Y0TUVPM0lseUkxRXIvYnBGdjlzOTBhWXhla1Y0?=
 =?utf-8?B?bVJtQWxPalg5MGNjQ1BpSStDSTdTZU56cm5hVGtWcS91UjBVR24xeGJYQUdv?=
 =?utf-8?B?RmhEZEdnWmhPc0x2ak95RmZnSzYwYytFWVd5amlZUTVqNjFpNFp6dHpBT0xH?=
 =?utf-8?B?NzN0QU1zb04xb0RzYlVaeWVqYnJleHV6OWdKZXpqN1FJRHNLdWZxWGYrREU1?=
 =?utf-8?B?QnJNMHovZjJtb0lBSzhCQ2luV0Q3UTRTamJXV004UkZwaTVuZlFrTVhFY0Z5?=
 =?utf-8?B?eWY0ck54QTdKRURNaVRsOXgzNHdsNWdZeFI0Y2F5QlZPWm8vM3VNdFlHMi81?=
 =?utf-8?B?ZW1PZGQ3bHo3bkxJcVVOdzhMNk9HUEN5YzJhT0Rac2I2b2ladE4xZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db14758-14aa-463c-8508-08de7a93523b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:43:49.2641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIiQcu8EQYzpA9OBltTCj4rhzmYR4sgT6wkC9A1aXnOLRwO5ogyyTTgrPpiUxz1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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



On 2/15/26 16:16, Padmarao Begari wrote:
> The driver previously only deasserted the optional bulk reset,
> leaving the controller in whatever state earlier stages left it and
> risking failed probes or bad transfers. Assert the reset first, wait
> 10 µs, and then deassert so the OSPI block starts from a known state.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> -Remove the reset condition based on CONFIG_ZYNQMP_FIRMWARE
> -Use reset bulk option
> -Add assert and delay for reset
> -Update commit message and subject
> ---
>   drivers/spi/cadence_qspi.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index d1404e13810..2a4a49c5f1c 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -13,6 +13,7 @@
>   #include <spi.h>
>   #include <spi-mem.h>
>   #include <dm/device_compat.h>
> +#include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/io.h>
> @@ -254,8 +255,23 @@ static int cadence_spi_probe(struct udevice *bus)
>   	}
>   
>   	priv->resets = devm_reset_bulk_get_optional(bus);
> -	if (priv->resets)
> -		reset_deassert_bulk(priv->resets);
> +	if (priv->resets) {
> +		/* Assert all OSPI reset lines */
> +		ret = reset_assert_bulk(priv->resets);
> +		if (ret) {
> +			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
> +			return ret;
> +		}
> +
> +		udelay(10);
> +
> +		/* Deassert all OSPI reset lines */
> +		ret = reset_deassert_bulk(priv->resets);
> +		if (ret) {
> +			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
> +			return ret;
> +		}
> +	}
>   
>   	if (!priv->qspi_is_init) {
>   		cadence_qspi_apb_controller_init(priv);

applied.
M
