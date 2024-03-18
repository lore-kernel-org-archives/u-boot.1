Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E45C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB2287D83;
	Mon, 18 Mar 2024 09:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tEzGJoX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7712487D8D; Mon, 18 Mar 2024 09:47:09 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4964879AF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJH3lbWxaRsre8d1xc/fhn03mWSH2YEoB2TahQlpTFZvzh2ceP1en70eS4qUorx2fg8hqZ9UHGnzLRJx08//WUPovqQw+R12RyU3MTXjR4MY4MuFJL4zM88OodTqTusu7I+LpU/cfffO2LibryJBSz7aXkLpuMnN9EGmdzWhrfUfeXvJrlVBMvLsHWFneliDfG80NT/b3SKSZ1KynaNzlDiFnsjmItVDCW8p/U0M114wHwvYmL9jbk3YeSzLMAzD0jDAKDhsUVLdiXAC53UqToEhKS4BvNsK0c2S+/hw1LShutRbwwK2TvgPGj5XNR5uv1BBwa5aY09Y7E9JpKn8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOas9/mU3kR+1MTt/Fsk6rX7sCIklUENpJgQXtZW5yU=;
 b=dXOwftd+7RdPoF283rRMuMMyK8hM0hbf4mBslWBU+VcGg18uIeVk6449ZJePw/rX5bKO+JYZ5Yf//SybqzlNeE/dDkYkG43kuRgM+ibjKyMLUbuUw2EGL2UppnnmPTLXnduCyNbosMhfpCoIToOaiZu/TGS9XDbb1WcqEWODS8/susZVJg/cj59U5pBq/iZRthudT38HBgpSxlIxJPbUqFED57/L+nKQTpJ9RdY/9IKUwZE3VcCL+ra3WU9X0VPTOOFzICey3Iq/F11eZbtKNDuJDFPYQ1c/APPbU1hwxwvAGfdHKpFsKvPed4d9V1iqi6vsTO1AsXBM5M7XQBv4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOas9/mU3kR+1MTt/Fsk6rX7sCIklUENpJgQXtZW5yU=;
 b=tEzGJoX5lA8sAdGfusIpwn1U/CaxFi7nJh34tfEi1kIXB3L1OpIjLlZw2W64af97piq3VK5FZrgUvipznNLrX88BRxnmR3FSwr5gbDHJOH9UucS878f4Q3jmjRu9F3eouvu2bjsGt3qIejBIaPRf4V6UnnjYHVs21Rym93964i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:47:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:47:03 +0000
Message-ID: <372f1f5e-d5a5-4c2f-bc0e-54e94b55fe9e@amd.com>
Date: Mon, 18 Mar 2024 09:46:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: Factor out PHY GPIO reset code
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>
References: <20240317031242.543834-1-marek.vasut+renesas@mailbox.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240317031242.543834-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4ca1d0-e051-4674-affa-08dc4727fb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIruxdl4pJ+ZfCIl0h2UCiJFxRUe2UU58k6txp4C3kucaorwDHyHKEt5r6hDcJfHOz8tvLWhY1396CvyOhbt8urZJAFaPX3sNvVcwaa9/zQyHMKrZJLhdd2T2AU07U0KZ5Evd77RXcDANf7/bYCNePCuK29IG7p8mdiZgICjPS7+QDsTLuwYLTSboz25DI7ncXzdjit8FxeSJs/HxR4GQGZvDHISLRVQ1H79ITEdp/UXGaUCmrOqvQlip/EaI8tv5XgNJiGmOw5hYKjeB5eXLMkpc0fsSV+0t2ST49HM+CQg2GO8S1BDkaviu+uNVKE7yKG+1o0M09UAM/+54xLPwOwy7nvp16ddRHebhLXm6sxMEGOSz3+NHazOLWq7rG/l0P6PDAgmNRYGiqDyPiRXgqNGErzwjl0EJK90e+BFR3ANcrWBdaJPlCYyN00Hr0PwQv9hbHkLMc3b8WRd94SDVCVRbTMinw+2PoxLgaXfmdODor5WMfCeQQMwrQ+lpQhFtH8TrjD9b+Tay8Qyv3aS1irTOthRNCW29D3Fi8Wr0d3XL0nTxqnLHvm2xKcJfwmTxHCF2CTTPcOXmXYhUV6S6+y1aQvwLCxTgwHLRG1k2TE/8fF2rJ+angZ0MXAUaF1oH3nYlLdLr5pWlcrNeiw/zHM9L5kuNOG1QOMpevNj2js=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZyRlo0NnZSR3RmWExSTE9Mem5hZHBRQ214cXZFc0NQZlpld3hZVVE3azl1?=
 =?utf-8?B?R1IvNlFjMmsxR2toK0ZURnV6N2VXOVNCakxGY3QreTVUN0FIaXNnMyt6UU84?=
 =?utf-8?B?NkxzTGZWenQ3YjRLc3FpOVJqalMyN2xZUU5ucVNQaXRnUERaYW42b29NMnpS?=
 =?utf-8?B?MXpzdkVVcTVqVWl4enpYeVA5UHJNN2UyWHdCQlNlTDNxdzBTYkVCWEpxTWZq?=
 =?utf-8?B?T3ZFY2dpZGhha3g5SzNLZkNTKzNGMXdFcm9yOFlDT2xDOHBtTWJXd1UwWU9h?=
 =?utf-8?B?WkZ6N2dzOTdDS2FUcndKd1ZiV2YxNkoxODU1SVNyLzNZOUlYVHNWWHUvN0pJ?=
 =?utf-8?B?Y0w5K1EwMnZaODRiNGVmSEIwS0dGdTlmQjI4OWgwTzZBOGRqMmxTTyt2QUtT?=
 =?utf-8?B?QlVMcGhqZGN6bDg0cmhDTmxEc05HT2pkZFlvK1JDVExNSHNQaXhXWmwweFZX?=
 =?utf-8?B?cG1qWkZOVWM3WWczNUFic0xvcTYzZkxUOGF5NHgveVVlclorMFgrNXFuQmN6?=
 =?utf-8?B?dlBHc083ck1oVENjWUljREhnekk4b09xZTNmRUQrdW5kWGwzV2VuZjlrVld3?=
 =?utf-8?B?MVp3MFNSaFJxMGxXdjQ3OFU0d2g4elZQMElaSFBQYVFQcVE4aDFuVlNwLzc5?=
 =?utf-8?B?RWNodUZ6aUtrcEczdEllNGYwUUpsRXVHN2R6SDhNeWpGUVNpcmJ5UTJiZU41?=
 =?utf-8?B?ZzNvWGprRXhSUjVuY1k2M1BNdkFvR0RYRnFnanZ3ZElpMmY3S1V3M3hVWm5I?=
 =?utf-8?B?ZEhHV1VKQ3RuRnVDSnNqZjBkbjZMVmU4QkJ0OU5LdlVuS05LaDNTZlZXNHl1?=
 =?utf-8?B?VWVGMk0xZ0JISEpoNGZoUndTb3pNa3EwcWprZVJjektCKzBtbE44eVcwV1Bl?=
 =?utf-8?B?V2o4TVlRcnJDWEdweFhYaXhPa1YwRlQwMUhYSks1RDM4cnl4L091bFdnOUg2?=
 =?utf-8?B?ckRjbDNKVWxSNGNvdGswR1dsU281aTAvMXRYdXBjL1JkT1RRNXpET2hTWmxK?=
 =?utf-8?B?d0VHS2liQUtzNU5KVlM3VTVGdmFqWEtOeFFiTlY0ZUlZZUY4cDYzY2s3NHNO?=
 =?utf-8?B?OHMyNnRuSXF0dlBmKzhXalhUZWlSWFMwdVJGeTJSdVlxS0gvQ0dZdnJ6T1Fw?=
 =?utf-8?B?bXZRKzgwWWE4d2JDZFFNVnZaZzlHdjRyY3Vrb1l2SHhMdHlsUWUvTHFIeXdw?=
 =?utf-8?B?ZVZ5dmNuTW1mck14VHpZcTB5K01uc1FFTHdWTUxzNy9MMUZsQmF2c0laeUx1?=
 =?utf-8?B?dXB6RmxMcDZUM1BqZGlBRi9GbVF6Ym11SHJWbTkwbXBJOGtnQnU5V1dyc1Y2?=
 =?utf-8?B?U1p2KzMzZWM3VkFvTmxRQUVjWk9YNEZPa1NkVllZN0VKcXFPVi9FTU5PREZC?=
 =?utf-8?B?YVRmRFdOUFUrUVI2RXJReXJuWmtueWJCbjFibFpZdHVBdXBueTczb291Y0RX?=
 =?utf-8?B?QXdJcUdzbU1OQnZkSnNKM1Z3Nzd3ZmpXcTZudEovMWFMdTBwcVpFL0xaRjF4?=
 =?utf-8?B?ci9ZOFRWR2d4R1crMjBXKzlzMzlIZmVoV3FFREU1Y25XS1NpUDNmYmhrSlhn?=
 =?utf-8?B?OWk1anljQXJOMGpqbUhPZ3kzeUdWVWVLVHA2SEhFaWlpSXRIeDVCUGhKQ2s3?=
 =?utf-8?B?ZFMzNzFSMnBQTm8rYXFmKzFNYllyQVcxbXBHZHVBMDdBZkg1TThBbEZqWUtG?=
 =?utf-8?B?amkwUndNZWpwZm55WFphVG1rR3pVU29ObDZOdnQ5R1dnTDZLS3p5aGEzcGJ3?=
 =?utf-8?B?d1JPVmdiRnVkMnE0bDhTTmhaTng1cnA2WXplRjYzNXRZY1hSZFRjUXJ0cDIx?=
 =?utf-8?B?VExHcU4vVTdHZEhRK0hqdFJMMjVhWDcwQnAyNnZaRTZsOHdUL1JKbXlYa1RZ?=
 =?utf-8?B?Z3JkUFlHaVpjTlhrbzhmOTR1R3ErbVRQQUJlUktmd1RKajFGYlFCeTU2bDZJ?=
 =?utf-8?B?Y3RIdWIrcWhwbVpoRUZESEpRdlZzNzg4Y2lqdHlzNmxxejQraXN5bVlKUENF?=
 =?utf-8?B?Mis5U0pwdCt4NlRVM291cS9LVmt4Z0VrWXhmbHhJb1RSeEtCdGxCWS9LVlZ0?=
 =?utf-8?B?aEdPVUxnQlV3UW9BdkYrWWVHY2pucXhHc3ZrUU5VcDFOeTRKcDFheHJFT2NX?=
 =?utf-8?Q?DgeQRnU64Bn+MlJ5iPzOPeXeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4ca1d0-e051-4674-affa-08dc4727fb79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 08:47:03.0462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2ZRqBWG0k5nzPB0z1wRVyWy+WKK3dGQNTZmnIs1QyYjHl6bgORESMYQjnTaDBKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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



On 3/17/24 04:11, Marek Vasut wrote:
> Pull the PHY GPIO reset code into separate function, since
> this is and will be reused multiple times. Set up default
> reset assert and deassert timing to generous 20ms and 1ms
> for maximum compatibility in case those DT properties are
> missing.
> 
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> ---
> V2: - Fix am335x_evm build with OF_REAL disabled
>      - Collect RB from Ramon
> ---
>   drivers/net/phy/ethernet_id.c | 37 +++-------------------
>   drivers/net/phy/phy.c         | 58 +++++++++++++++++++++++++++++++++++
>   include/phy.h                 |  9 ++++++
>   3 files changed, 72 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/phy/ethernet_id.c b/drivers/net/phy/ethernet_id.c
> index 6cb1fd4453e..4dfdee60dcc 100644
> --- a/drivers/net/phy/ethernet_id.c
> +++ b/drivers/net/phy/ethernet_id.c
> @@ -18,12 +18,11 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
>   {
>   	struct phy_device *phydev;
>   	struct ofnode_phandle_args phandle_args;
> -	struct gpio_desc gpio;
>   	const char *node_name;
>   	struct udevice *pdev;
> -	ofnode node;
> -	u32 id, assert, deassert;
>   	u16 vendor, device;
> +	ofnode node;
> +	u32 id;
>   	int ret;
>   
>   	if (dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
> @@ -41,35 +40,9 @@ struct phy_device *phy_connect_phy_id(struct mii_dev *bus, struct udevice *dev,
>   		return NULL;
>   	}
>   
> -	if (!IS_ENABLED(CONFIG_DM_ETH_PHY)) {
> -		ret = gpio_request_by_name_nodev(node, "reset-gpios", 0, &gpio,
> -						 GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> -		if (!ret) {
> -			assert = ofnode_read_u32_default(node,
> -							 "reset-assert-us", 0);
> -			deassert = ofnode_read_u32_default(node,
> -							   "reset-deassert-us",
> -							   0);
> -			ret = dm_gpio_set_value(&gpio, 1);
> -			if (ret) {
> -				dev_err(dev,
> -					"Failed assert gpio, err: %d\n", ret);
> -				return NULL;
> -			}
> -
> -			udelay(assert);
> -
> -			ret = dm_gpio_set_value(&gpio, 0);
> -			if (ret) {
> -				dev_err(dev,
> -					"Failed deassert gpio, err: %d\n",
> -					ret);
> -				return NULL;
> -			}
> -
> -			udelay(deassert);
> -		}
> -	}
> +	ret = phy_gpio_reset(dev);
> +	if (ret)
> +		return NULL;
>   
>   	if (phyaddr == -1)
>   		phyaddr = ofnode_read_u32_default(phandle_args.node, "reg", -1);
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 63b3e46f101..9ceb7d7c6a1 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -18,6 +18,8 @@
>   #include <phy.h>
>   #include <errno.h>
>   #include <asm/global_data.h>
> +#include <asm-generic/gpio.h>
> +#include <dm/device_compat.h>
>   #include <dm/of_extra.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> @@ -768,6 +770,62 @@ int miiphy_reset(const char *devname, unsigned char addr)
>   	return phy_reset(phydev);
>   }
>   
> +#if CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL) && \
> +    !IS_ENABLED(CONFIG_DM_ETH_PHY)
> +int phy_gpio_reset(struct udevice *dev)
> +{
> +	struct ofnode_phandle_args phandle_args;
> +	struct gpio_desc gpio;
> +	u32 assert, deassert;
> +	ofnode node;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> +		return 0;

Trying to wrap my head around this condition. Above you have 
!IS_ENABLED(CONFIG_DM_ETH_PHY) and here IS_ENABLED(CONFIG_DM_ETH_PHY).

Thanks,
Michal
