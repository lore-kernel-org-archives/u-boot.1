Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB73C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87BA88137;
	Fri,  1 Mar 2024 12:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vfHaVXeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C9B88132; Fri,  1 Mar 2024 12:25:46 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B30888121
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l023AWSsGpAMlCP28NngHqNsK/tO99OLDba229RhWWWd+xH5b9Ik81A7ggnZYzAtrd2iQJt1tX/ztGYsnVReGvNnbalEBWn4MOrOTkGZN8dwtQVEHSxF4YeMV7s4wOQOjamYKgPj0rR4cCSc+DH4ow1J8uBWThKE8wPr7PIh/1VhaQMeGn9vwIP4ClcGxGNAuU9YyF2V+z1WSzi892pV/pZ8iWrrBcnkr0VBWoEI3FWjeq7358WO6IKzaYelzwXst+SlBqU56lx7P+S6p0NOWinvSws8ETZJBxd4b5uBn8y0VgEjs3x38CqukkBQEXcetR2fmMxSY25RPjYoeeM+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7Egs1uSFJa1nH86T/9SMJ8rE2tUD8p/poNEpaphM2E=;
 b=WiZbMIBck6V9sD1d0gnBkHmQDuyFvafv+8F88UtVyqO1njsxOS26v0o0WkgFVq79UpPNBOkwXljpqokHwsXr6VAlUAV9J/bg50bHXI3yaHumTgdQ5YhBx0MEUTZJLbCyY+jB6fFVxEuS7xgfteNCFzG1NpcRtOCupsd5BBjaZUZS86UZaihEfrVtVO8tk8r/9PNZEVjWmjO5xqSjd47qnSBkdd1wyKMs0HNmaJDxkpFChwneSgjTaNXv8MW80JLbjSrNyzASZgR+LcLIdYF8to9XGbxiRmduGhj++XBveHCsZ58TIdr2pp2h0GzFX0xgYjWICx1+eXcP1x6oij+yWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Egs1uSFJa1nH86T/9SMJ8rE2tUD8p/poNEpaphM2E=;
 b=vfHaVXeR0PdBdZBuPyALt0pD/0HPGqHdefBJquqd0RMMcimdH/acJUfbiYdZ6TygI0uwlYGHBEy/OrRGTH+/Ljgm/3+/h/V0GErJzHbq8lGVqYN0Y3RJLZx9JojvWxkZBrC+RSvrpfXwm+K3cT+kKtgO/b7yNQ1e6BnF5lZbtXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 11:25:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 11:25:41 +0000
Message-ID: <d0349400-9889-4e0a-965c-6f3ac7f532b5@amd.com>
Date: Fri, 1 Mar 2024 12:25:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH v3] mtd: nand: arasan: Print warning for unsupported
 ecc modes
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 git@amd.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: a764cae7-ecb3-4631-eda1-08dc39e253cb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s96x+0Xb8xipmgbZM/HTnJPkN5jODDceAb/zlxUjFrMbcDczP7THUjZfpe3j+iXHHyYRT1PPp9nidVLsjuSKh/r7CZ0OX36rIBGjiNBVbuu+OSgkHc5cjmLSe+D975d8hnG2BU7mEKWuMIwcDbomU/939am09HJx2NxTZB5VlNiAZgdO/Bgqba8+4SyZ9bTuMHLkBei6YrM0VivnIRhw7tF/Aa9FgRcZlI8N9OQqNBolnpB4DMg4CauKZoI+A6mG/AtrWBxrwC4miT5tDzG4d84+PuVjhknI+j2B0bOf4HffLEdOMDDOSEwrxIMPl7GsuNFGBX7iH3shRscz9VpiJBCbOuoQspsL2UrwxJn533zHRu9CeB66rRQVy8jakwzt38q6yM6TF1sPvp0JYhmE8QBwlJtdXGZBXa9glDzUyl+vhoGyZhtHf/UZIM9I+R8yvupPEiOf6fmqcVqKnm+QjvEGH8GfSTH6F87soBjrDoyTcMuWYQVF1mzcJrFKz5wZA3otnLBHFGQm+HtJGmopP4Dyk2IjiQ0ZkL3SatRzANexa54qP+jdqc53lh2HGSZ4TeGFuJCkyT9WpxqhwXzHCjm4hcdjTRvanIkEmaU0t3mwbv2LpyW38i9VW9Oa7T3YuAf5xnGp5tK+XZhpp1iV4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkVIQVM0RUc5N1JGTnNyV3h5Z2lETjJodnRtMlVXV0IyU1U4Qi9XNWZFV3lx?=
 =?utf-8?B?dk5sSUtveldZS1Q3Y0dnT3BFYzZJcHBTSnJOUzFrK1FVdWIvVms2OTFWVVBM?=
 =?utf-8?B?ZzBjekhQQ0lEb05OeHRjYkxuLzNNd3hEOTBZVE9CQURxdEI4TnJ2RnBIOEtw?=
 =?utf-8?B?cDhDTG1RU0lqelpLTmlKL1UxblNJK2NNQ1BNc21tOFB5L1NsbHlUZUE1dmlG?=
 =?utf-8?B?ZFdCK2V3cGRTcUREMFBEeHplMmpoMURCZE85WjhQRTFxRS95eG9jTlNZdjZw?=
 =?utf-8?B?MW1ZMVR1eURFaU16TzdOcjEwalp4TFlaZ2c1UWRQQm85dVFhcCtocE8wSXB6?=
 =?utf-8?B?QkE1SjNKZ2wvK1NoRE0yb1FQZ1JLVVVvTG8rNmlWOTFLZmNqNTdvTXJoUFg5?=
 =?utf-8?B?OG15UXBMUEdoU0RJcHY4eTNjVW1yTnZBUUV5YjZ3WXhPY1pybmJTQXNBdXFw?=
 =?utf-8?B?bVYxbitqazkxTnVjbURIS09EZWFqYXhYY212c1hla29xMjN4cFJ3RThKdnhz?=
 =?utf-8?B?clFNdjlIMFBOTzI0N2pxYlBudU9kUElyaVo3WHFUYVZUV1BsbEhwMDAwOEZh?=
 =?utf-8?B?c3dRS0ZUSDNGOVA4Y3VJQkNiTE4rRmVEVHB1dHRrdUxuelNSNU4rYS9nVWJZ?=
 =?utf-8?B?VXgvdGhuNmJiSW5XcGxiMjE2K2wvRE1WcUxHbmhRMXlwWkpmU01Ua2tPclg2?=
 =?utf-8?B?S056eW5TamlmeUwrMEVLM0tNM0FwRVpFUGNvamgyVXcybS9TcGRmb2xMU3Fq?=
 =?utf-8?B?YVhkS29lbXRVWEFwU2pHNnlmTW1vWkpoWndaWGhabkQvbWFkcHA4aDBTWFpt?=
 =?utf-8?B?WmdmdFl5UzVoMTE2aWc0TXJJdkRHN0JHZW9XT3p3dmVQZ3R5VlZoZ1REUjRZ?=
 =?utf-8?B?bThxcllObkZPcHlQY3RlS2dXRXFhM25CbkgyWHVnT1dsOEdBU1NvY1kvTXB1?=
 =?utf-8?B?dTBwR0Z1K3BRTnJRMWw2SWl3WjJLbGVBNFVXZzhwRi9TaEtMMUFZVlRiQnd4?=
 =?utf-8?B?aTN4bjE1VGtSclRwM1duenQwWmhoNVhpOTdqUndwYUZaTExZdEd4L3BrTjU2?=
 =?utf-8?B?WGhHdEJWUC9nYStEdk1LSXM2L2ZaalpZZ0ROM3dSSkk2SFFpdWU4UjY5am1h?=
 =?utf-8?B?eVJERk5Wdk5qbHRMTXhvWU9CS3FRZFkrR2l5dk11OGlhajZOZ3VHQWU3TVBo?=
 =?utf-8?B?eko5dUwwQml5WnU4ZWRYbEZTWS9ucHd5cVBkbi9Kc2xiNG9yTU56Q3JzNVda?=
 =?utf-8?B?NHVuY05pRG5sREJJV3RFdFpDamJaSHJBNHlWYTcxL2lhU2NPRWNnK3kyR3NW?=
 =?utf-8?B?dmxWTFFvTHpXYkt6RjBYb0NhTmdrQXhUYWpFZ0JEN0pCZ25GNisyMC9GZUJj?=
 =?utf-8?B?a1VDSmdwTUwrM29ob2gwc1BXdjEwWlJYQ2JEbUxjYnpURkFrT1pMQS8vUzVh?=
 =?utf-8?B?S2xxb2owVmNVWEZXT0Z6R29qL2tURldrQTlIRXV2b3BRTVRXa0tXazlEL0d6?=
 =?utf-8?B?dDBMQWhPUWkyTDFvZStWNVBpREFkL1hqRUxadVVCbVBsYUdQVlJDWE02MTdt?=
 =?utf-8?B?SjllZDFqZWJhYlVjLzRQdjZJUW82R1ovK0FkVzdzWGJXWGNlSHZ5RHBPS0pV?=
 =?utf-8?B?WkFNOFBqemtrQndHZ3h4TFB1ZmNkVWExQ05EdmVVeHQyamJxdXR1eTdjMnNP?=
 =?utf-8?B?TVNjOEZYOGtTL1c2a08rUUxsc3NTTFA5ZkQyeTNWMjAvdVJOR2VaK1NBWEVm?=
 =?utf-8?B?bW5naG9vUjBPeUl1dTBZNlhQeXI2SWNqM1ZDMHg3eXJaN2tPWEtJcmF2UGtN?=
 =?utf-8?B?Ym56TURCVkhNTGY3eEo5bEpRejdrKzVORU5Uc2d4VzVPQ0ZEbDM5UWJkTnNZ?=
 =?utf-8?B?V25WTEY1allobERNQmVUVFU2Z0ErSnpxZ2x6bDd0K0R4MlcvTk9vVjVrZ3dC?=
 =?utf-8?B?NHNrcnRta3M2Mk9UQ1lUZmtkVUpmdXZnVjFvbUJlOTEvWVBaWVUwaW1WMmYy?=
 =?utf-8?B?U2NiZjNiMWdEQXlSWUxsQ0pSL1FVc1U0UzJReVVpcmdwWFNjdzd5bVlOamdT?=
 =?utf-8?B?QkpXV0xUY251MzdIMHhMdFRYZzgwSHFnbUJoZGg5YmVNZXFEV2ZXaVhhSzNJ?=
 =?utf-8?Q?p4oaXN4OGTcCmQ0/gN2cl1Frv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a764cae7-ecb3-4631-eda1-08dc39e253cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:25:41.4657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCwahLnljFHCNQrgPtLySsvsoa/N5SMlqCov7rM8o/QrVj9VWzSwGmByjQDwAOCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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



On 3/1/24 12:12, Venkatesh Yadav Abbarapu wrote:
> Currently only hw ecc is supported in U-Boot. If any other ecc mode is
> given in DT, it simply ignores and switches to hw ecc. So better print
> what is being done.
> 
> Revert this patch once soft ecc support is fixed in future.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Added the ecc mode check in the arasan driver itself.
> Changes in v3:
> - Skip the driver probe when sw-ecc mode is present in the device tree.
> ---
>   drivers/mtd/nand/raw/arasan_nfc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
> index 14766401bf..426160c384 100644
> --- a/drivers/mtd/nand/raw/arasan_nfc.c
> +++ b/drivers/mtd/nand/raw/arasan_nfc.c
> @@ -1233,6 +1233,7 @@ static int arasan_probe(struct udevice *dev)
>   	struct mtd_info *mtd;
>   	ofnode child;
>   	int err = -1;
> +	const char *str;
>   
>   	info->reg = dev_read_addr_ptr(dev);
>   	mtd = nand_to_mtd(nand_chip);
> @@ -1263,6 +1264,12 @@ static int arasan_probe(struct udevice *dev)
>   		goto fail;
>   	}
>   
> +	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
> +	if (strcmp(str, "hw")) {
> +		printf("%s ecc is not supported, switch to hw ecc\n", str);

you are returning below. It means switch to HW ecc is not happening right?

M
