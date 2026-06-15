Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F87CD98CF
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 15:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042A2846A4;
	Mon, 15 Jun 2026 17:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qY581F3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E30846CF; Mon, 15 Jun 2026 17:24:14 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C3B84105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 17:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usOwGTLGcR1Ai/MYL8mYIptUPfKAg1UHLePMS4l8jzEaE5wKKsBsuSS9PeTQZIhjWtnuCLZDJiIT4H/aRBwfA+8/8BPMEZdVQtXe6eSpoFhzemMdGG8WhC0SO71J43gcjuEGw1ViNPhP6kiSBzvcIoP43HjhvmwBz7k0oi4f19/2iMeGSORkJN+f499Q+8y7IgYCiNjQntoJkM4AKcxeyW1LOxdSrPx8O3WLqCVNRyXcfS68yzTWL7WiasQdVj1jVU7Dyn4ZrbW2eiGEiW58roJlcKSTkvb0oBQSj+bYfRoOrlhXSfPoaoDbfxGa2waSD4J6PM/cGpd6RsoQT3HMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXxOvHX1rw8owd+kgHmDGLJ4JUx3MSo5uizeye470Q0=;
 b=WXnIoCogoEvFZDpMl6Be6AVpT0eDN9KzqDV0VsLRoHRfyE2sNyGOHKpKUkHxLeA/STvMWzCzuDWsNz1t+rcEl7mtgXMnwFFJjZ7AI0BWU7vO3XoTrGlEQIG0xBL/nlfsgvqWEhF6XyTXdBRLNXDOrAjyIkZhFq2MuViT6JUDMko9knTKcLath2LR1nwd5UCpNtx6SqOAOBJuOJ+DyNfMm1V4m979LlBxms5tZdVaNe0Imq4wyIpjansz0SMpVlhTYaRS4fJg4uoKFynQQqhRVR77UTHHrhuW0uEHyRVxFSh3FVRX+j/L+RiuFm8b1lbyVI1XFDDEgIch0L5+7dPobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXxOvHX1rw8owd+kgHmDGLJ4JUx3MSo5uizeye470Q0=;
 b=qY581F3XWqydoRa5xanejM1ymgw1ho9xuvDnTP8nvuZlQGKlqyqwq3uVl2VXHUDWWKkMpNt4C0AP62FuqQQrKgWzW57oTdS0l8k8oPoUnIvZYoA2W/ziDNE9xN3t5szaLke6I6yzwLz7hTMVMvH555Luv0/78BOlbE3RfOGwQ9uZk8F5yNWpYledeGoEvnXj1/cOTzv1aef+jSOr88VMCky5YRcziIARspKfoHHH/ZSoZC7Y/hU+YieYyTDaoOj2beIbT4iEqCR0OwVAQxwnOQBR8dach3Cew2prckrmcnOZE+aEw513AxvwJeYqBT3BZTdtO9IoTW1upNvrw7LAnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11969.eurprd04.prod.outlook.com
 (2603:10a6:150:2e7::15) by PA4PR04MB9392.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:23:56 +0000
Received: from GV4PR04MB11969.eurprd04.prod.outlook.com
 ([fe80::5985:e1fe:4d87:d892]) by GV4PR04MB11969.eurprd04.prod.outlook.com
 ([fe80::5985:e1fe:4d87:d892%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:23:56 +0000
Message-ID: <4ae7e3d7-c71e-43c8-95b0-a8e77c9da298@oss.nxp.com>
Date: Mon, 15 Jun 2026 23:23:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX95: Secure Boot support
To: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>,
 u-boot-imx@nxp.com
References: <CAOMZO5D9ndCxsDxx_pBG+_DfZFSviLfvFwmdPxngvQPOC5qfaw@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5D9ndCxsDxx_pBG+_DfZFSviLfvFwmdPxngvQPOC5qfaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::14) To GV4PR04MB11969.eurprd04.prod.outlook.com
 (2603:10a6:150:2e7::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11969:EE_|PA4PR04MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3798c7-f1c2-47f8-6078-08decaf21d4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|23010399003|19092799006|376014|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: aHzPbcS1cqixTnmSVDwl+r5O//LUmnVOlb/y2WQddueSg4k9/QAWZzcMpQo0eweqJT+3mZfR/8PNk6dpcUo/nn0DaoXEYz0JEg45hYyoFD2KfuRv8ifJMh68ijE+aMEGSNoa/jg3/liTHAcYxGW42oTb7vYBG+uGExh9o/v3HLG3qHsXve/WyEiNof/rBGkIAdW9cWa9qNV3rWYkt7WEsW4GZBEpJpfE3kmcOMJodOckeBdFvrNtifJYXGjeJdVVhxm5zzAOnQSMINhVrgDqdScS0kKNNAfc2Qdv546GZfYGCVmViR8D2Omph0dezBACFQ/DcD3AQBfq+y6QgCGUFGb+JvEaM8FUBwkYLmQpv4Sray2/woOl2NwwtjzGUbiYr3WdaW/bebhmBdPFlRmC1ljwyZhsK8xLS3JCtUzwW5zxd9gMYkTvScczCzBvS/xNWk58N5j/7Mn81rASyk2a4pMm+cr9kM/dp9HrDNRFt4wbqa9+kqmxXDDeQ7168rFIl5puRLm34HZaq8igFheJdJe1lGHV8BHchNWkNUGxniP8ey/ZdiFHJv8TUV3pfHOrEinBdH9pssDhmXjmDxmreLQIsY9Apjotp7KwhowG+1hm+5giVx3ssa+71wNb6LpOi0oQn2/69IN0dt0xAKmZI4k49xQEYRWKvx9OE9pMolIzOxufm9/H5Lv5VHyNY4L19OlKp1bPS+Vq/NaW1MOb4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11969.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(23010399003)(19092799006)(376014)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhRSncwc0RxWnEweHpFNGo0QitVd2NOTVYvTzE2MmpYenNWNFFpRy9lVzJ0?=
 =?utf-8?B?dklha0tjdkN5QXo1bDQwTHhXTUxxeDdIdTdUc3YzZmVRajM0MGI5TFFXcDR6?=
 =?utf-8?B?b09sdHhqLzh5c3BNMVBVK3pCQnFURm9VeHQ4bVdzbmZ2b0hhLys0WDJwVWZr?=
 =?utf-8?B?ZVh4blFrRk9DZFl1SkVPc3Z6eXpqVlRVTmNhbXRxSlhlUkNhVmR4aFZReTVt?=
 =?utf-8?B?RG14cG9qMGZYb2pyaGJuYnRJbEJLVFEzdGY0emdNZzc0VEhld0lIT2hXM2Ex?=
 =?utf-8?B?N1h6cnRZNlRlVHdIeldUUmxpUDk2L0JjT3RaeXNXT3NxOCs3aWlRYjlxQVNq?=
 =?utf-8?B?djBWblQ3MTdma01jbjNFZ08vS3lSM1plWGFteHF1NElMMWUxVnBBVUo2RXNG?=
 =?utf-8?B?b0tHdWIydzV3K2Q5STNNeDVEeGVYWHpJRktOV1lUMzBQejVRemlEYTdvRGhJ?=
 =?utf-8?B?TU9lZUdHTHpPK3d5aFY0NUExU1JpN3AxTW9VVWpxZGpEWE9wQk42ZXFSbDhD?=
 =?utf-8?B?Wk4zK3JZNEJvbkpCenMwMEdhcVVBOU5tdmVzNmdVTUFpUTZzbURDdTF4c1ds?=
 =?utf-8?B?RXV5L2w5Qnp1UVlIWXhCdFFpL2NYVGllYXkxVEZkWUNjRVRMVlRCOStNMm5E?=
 =?utf-8?B?NnY5dFgrVTR0cUoxS1Evb3FJQnJ1d052OXBhTmY3L3luSURtcy9xSUhmWXVU?=
 =?utf-8?B?ZlcxbCs4L2crdnV1d0xqbDI3ZndjdEVNYWNwMUpkVFRHY0pIWnloTENPRGFF?=
 =?utf-8?B?V1JxalVFYnVGbEhhaWRkWWF0TXNuQitQZUJHWTdGYkFSK3Y3MDFWS2JWRDU4?=
 =?utf-8?B?clJSN0I5WHVYR0VXUEhDNVlsVWtYZnNnbVJkVDVJT3JEd3hPN3pBdFVyT3hX?=
 =?utf-8?B?ZkRnY3pscTJRZ0p3TzZOMmN1aWNSYVliUmczSGZmZ0JtYktDQlNSUU9PQUFV?=
 =?utf-8?B?d25FcFRQcG9FSG1vdXhPcEhyKzZQc0pmL3NEeWtNeDMwR3JVSVZkZUJITE1D?=
 =?utf-8?B?UW5tRno4dmpnQmxnOGRtajVmbU1hVmJseURMM3Vjc0F0RlVrb2pkV3gvdXYv?=
 =?utf-8?B?OEQvZ1llYTQxci8vcVQ4Tk03bVZPbmlXTWlESGNTS1AvV05CbUJabkdmcXAz?=
 =?utf-8?B?TWs1Z0RENWFVcXlDL1dMbSs5VWxUSUwyR0JYTjZNREhTWExKckpoSVRvM3gr?=
 =?utf-8?B?Y04rOE1ybGVUQXAwMFNXQzVQUDliRnpyMndPSWxvK3hUMndrOEs0Vk94Yjgv?=
 =?utf-8?B?M0JreDNJdUhtb0NnSGtvYXpjbnhGNzQvZmNXaW16a3FJYzFBRTZDWUNMeUlo?=
 =?utf-8?B?MUdmc1Z4NWMrT0hJZEJBd0FSZ2VEVG1Yazh6V1BJdGtNd0ZrVUM5MkJ1ZVlU?=
 =?utf-8?B?YTlJbmNhMDdwUEdUTExCeFNCVFNKajIvKzk4R3paRjFJSDVGTXhzc3lVWjha?=
 =?utf-8?B?S2FLcEVhMHBtVWFidU9uZ3B5SzdqYW0wUVhwQTRpL0sveDg3NjVYRTI2dE1m?=
 =?utf-8?B?OHdZK0hFT1hmdVAzeGxLeHRMY3lLVEFsZVp2SEVCQWJSUFZ2N1dKVnZxb3NH?=
 =?utf-8?B?cGJmaDBtK1hnalZ0R01xR00rNWN4aE9xRC8rVkFlbmR1a2pOZVFjckwyK21U?=
 =?utf-8?B?SHZRV01SazFPT1FjWW1jR2J1aUgveFdiU3VZb3gvREJlOVY2QzcwRkk0OXRt?=
 =?utf-8?B?bEkvSjBvTWxOYXZIZFBqMGhQclVLNlo4ck9LWG1WZFd1enJZd3A4Vzl1WFlY?=
 =?utf-8?B?cEZBOU1kdVlwR0kzN2Rnend0OEdHVHB6QlhuZVgxNWc5cEpldGpyb1BlZlp5?=
 =?utf-8?B?dFRUd1Rsdlh2ZUVUN0NndlB2ejUyYU5MdE1Gc3JmT1RRd3Vra094cGlXTmhI?=
 =?utf-8?B?YlI4eDFwMFR0MnpSdzRYTUFuekJRUnN3TFBWWW1tSnBjQjcvOUFIMzA2NGtS?=
 =?utf-8?B?WUhsNjFMbzdCMVUrc3djKzM3Y1VNQkhNWE5lbzRRRE1DNVI4RGpvcEFCY0hY?=
 =?utf-8?B?S1hjcitDNmRKNzUwV1NyK0dvVGFNcWd2Z0piNUdZVE0vYWtXTnZKblgrQmNa?=
 =?utf-8?B?cHJsUGl3Y09qTFdOanZDbXlXeGwwUnppdmdSSzJGY1M3VlAzRG1LbVVoeDc2?=
 =?utf-8?B?a3N0ZWYwWHg3TzVDLzRINWRxTFJRclZkSmY2ZkwydUN6WG9ES3VFQkRYa0Z4?=
 =?utf-8?B?QTV3TnZsUTFMTVJTWVNpR3d0MHFrVXVEZUpFWjk4UFdmY2VBeEFacjRIMEZV?=
 =?utf-8?B?ZXduSEdkUnZZM29welNPdURvb0NXR3ppK2NobmkrcHBUZjd2bWpjQitqd3hB?=
 =?utf-8?Q?bu3hFXwXBjiFlZDMKp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3798c7-f1c2-47f8-6078-08decaf21d4b
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:23:55.9624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/Y1N0l/MuXrYOTqBaePCpGisU8Q9e1cZ5oN5DIU/cFCI/mNzYTVt9if5Tmhuhm/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9392
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

Hi Fabio,

On 6/13/2026 7:55 PM, Fabio Estevam wrote:
> Hi Ye Li and Peng,
> 
> Could you please confirm whether i.MX95 secure boot is supported in
> the U-Boot mainline?
> 
> Are the changes below enough, or more is needed?
> 
> diff --git a/board/nxp/imx95_evk/imx95_evk.env
> b/board/nxp/imx95_evk/imx95_evk.env
> index 19f9bd5c16e5..596c819a7d1e 100644
> --- a/board/nxp/imx95_evk/imx95_evk.env
> +++ b/board/nxp/imx95_evk/imx95_evk.env
> @@ -1,4 +1,8 @@
> +#ifdef CONFIG_AHAB_BOOT
> +sec_boot=yes
> +#else
>   sec_boot=no
> +#endif
>   initrd_addr=0x93800000
>   emmc_dev=0
>   sd_dev=1
> diff --git a/configs/imx95_19x19_evk_defconfig
> b/configs/imx95_19x19_evk_defconfig
> index 542b71f5c075..313f3e8dec03 100644
> --- a/configs/imx95_19x19_evk_defconfig
> +++ b/configs/imx95_19x19_evk_defconfig
> @@ -1 +1,2 @@
>   #include <configs/imx95_evk.config>
> +CONFIG_AHAB_BOOT=y

The main codes of AHAB boot is already in u-boot mainline. Above changes 
can authenticate signed kernel. But this version uses env variables 
auth_os + boot_os (booti) to do authenticate and boot kernel. This 
requires env must not be changed. Users should be careful of it. We have 
another patch recently in downstream 
(https://github.com/nxp-imx/uboot-imx/commit/5da4255f28cdb9c59b0d4380a38e0e2a962b4465) 
to enforce the authentication into booti command. But I feel it is 
difficult to upstream.

Best regards,
Ye Li
> 
> Any pointers on this topic are appreciated.
> 
> Thanks,
> 
> Fabio Estevam

