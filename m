Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FDCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9839483700;
	Mon,  3 Nov 2025 15:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NsrCxzAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3DBD838AE; Mon,  3 Nov 2025 15:07:33 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC5D836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQYs4X8BAoP8qCR7C73ev7jKx16bSZIEbPYYVVxjk++DEOcLxr/nPZ6dvho8FpHSr+Uby8md5IM4MGz1xwHuQs3g6hiOqrU4+2xktYLCRe2002bJHBlBfO8U7iNSUmHzWtQNZgtFZpNA+24in27YaZSxXSzhRipo/mpBpqirBSJ8FFZ8qdm3tZ0ynIJgweQSFX8FBKRB+UUPOJredbg8EG9/LQa0BkQlijhl4gYTVPmxDMWDjA60gO32ArE5FRbK3tzpo9KM7/RXsWgVhUE/OYewf9MyzzEYsDkG6xztR1Cr8MtrRHdwjEyGCBTwZYmH9ROYfRPG4F719g722MZvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbrefgmUeMkOf8HRf6RwpUH8IE50FEiQG5sNrFoiJhQ=;
 b=ERWsBu61suCpYZ0igoMa3C7RIEN2d3dPjBfob92dI4BqIKC0LUmeGvkhHshX6dDzhJuAjtv/dwcwx7JAwT3uy6kC06zFABgn3Le1HLkXgObNSRriWvwWxNDAvZyP1gkZZIO+5AP+HTt4v7g6EBvEGURg2J6tF1UQFVRYW+idzuIJYbUo0l1pvNfwbJSvLM7DOXFFvkseLx5Uzzexk6Gjng5QCpNS+7zLNiNUD9pug4sye3n7V2rB1STMqV8D8mBopg5NDK5avI7ikshAyHP8cgIWGVePJwrjl35IytPeeiDmb47g+QqcBEj/YX50di7xag5zKA86n6iyY1SYsdG84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbrefgmUeMkOf8HRf6RwpUH8IE50FEiQG5sNrFoiJhQ=;
 b=NsrCxzAj0th3/XGaIRphUMOs3pXOJkg+lNtbWYIqvyJPa8EVSdq0j+7YI8Fz1xB757Ytnq84kJ9n9Fw9fqnb3jAwMP0slb7lHWSmbdLXk+lM8H2Ng2Bl5NRzHMmSVIbNtbG1YUgiHHNwpge5KJ8J7vhWJWRjYfTm4ST6Fn4WErM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by MRWPR04MB11519.eurprd04.prod.outlook.com (2603:10a6:501:76::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:07:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:07:28 +0000
Message-ID: <49fbca7f-35b7-464a-99f8-ae479bc39129@cherry.de>
Date: Mon, 3 Nov 2025 15:07:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] disk/part.c: ensure strings in struct
 disk_partition are valid after successful get_info
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251020121100.1742812-2-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251020121100.1742812-2-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|MRWPR04MB11519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4c9128-d1f1-4aa0-13ba-08de1ae252ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWtiNWl6Si9YdkVBVFRncGNYdEdSeFRZamNQeHVpWWlSZktjMFlJWkhmSlJ0?=
 =?utf-8?B?MmVDbmxmcUQ4bWprOVBncjhyQWk2U3h6UndtVXpSWWJHMWVQZmNWQUVzcDBx?=
 =?utf-8?B?d0pGNmdnUUxMdE1GWkQxRldqR3FCdHJOcHhiSWNQT0k0VkI2Q3VXRDR6bWxa?=
 =?utf-8?B?Y09PRmIyTG8ydERZWXBYVldVT2V0c0ZqNnAzbU52aGtXSGlrL0ZJSG83SDln?=
 =?utf-8?B?My9NMGdhR1haUXEwNk96T1lWUjhZajFnNERRQlNXN01MazFQRThFNEVRTVF2?=
 =?utf-8?B?Q2EzWW1BK0VwajVSaEFEbTQvLzJ5VVRqdVNXVXcxZzJTT1laaGdoS3hVVFFS?=
 =?utf-8?B?NC92SWtSSmFnZ1BLZkNqY3RzRTVsYzFqeGQ2YWkxRkdNQVpGN0hMNjd1K1NX?=
 =?utf-8?B?SWhWRHg2V05mR09hajFUZFFCT2JkZ2ZBNjVmK3diaTBDWmpXbjgxSmYzRm4w?=
 =?utf-8?B?YWtRTzdOWTYrQ3VlZ2NIU2dyUEw5bDJheTZOSFdsdVhSYTZZcVBtODlFaWM0?=
 =?utf-8?B?eExpa1h1U3hleWJ2TUNpT3QyZGc3VDNWdFpZN2xSV2pReldLQWRNL1NxRnhs?=
 =?utf-8?B?OHUycEoxaW5xa1lNTTllWStCUnNSa0UzblFBSHBMWnVSY1JNY25yMUFiMHMv?=
 =?utf-8?B?cmpnYWFINGZWOWhVcVFGdzJJK3VRY0ZvWnVudVI5Uzhrb2tLVGxiRnNWQU5t?=
 =?utf-8?B?aFQ2bkdIZTIxL29HcTRubzQxZkN1QnZVMUE5aHJ0aHpjZURBQXJUNTc4ZUZ4?=
 =?utf-8?B?S3dCcS96cnhoRWZWc01uaTYxcWJzc3ZvYVVLU3dNSVA2RTBoOUpVcWlzaUh1?=
 =?utf-8?B?UVBVUjJwV2lZbWgvM09pWDdXaXdaK29iQzlGU0xnZlRnMjlxYmVBcTI3MFlY?=
 =?utf-8?B?QkF3UjZodkZtVXlYTEJxeDFqSE9rTFVCWmkxeUxhS1pnMlVMSTEyZzVOK0Vm?=
 =?utf-8?B?SEtFd21oRzlzckZPYnExTllxZFUwOGZvT0lZbk5VTHBMTXJoSXo4SlJ5MG1K?=
 =?utf-8?B?eVFzQUtMZjNxSkhrRU5rRDE1bUE2UDBXbGl5ZzMvZS9OOXFuU241RVJMMGFC?=
 =?utf-8?B?K3k2ZFA0bDFZYkVzd2hlay8yZVlWaGZLYWN2ellaOTFDY3FDNmlMeGVsZXIw?=
 =?utf-8?B?SVhHOUNneExEVElwbEcvbWhsYldZRU51a0txSDhYNVlzRkJENGZ6RXNJV040?=
 =?utf-8?B?THBPSDk0Q0pabjJBSUNqdHhQSFBQZlBvQVR5aE5kTC8rTmpPaDVRcHhmeUVO?=
 =?utf-8?B?QmFhbzJFdnBjalh0OXcvTVhORDMyT1IvM3h2Z1d3QmF2eU9oVThOM1F0REc5?=
 =?utf-8?B?QklpajAyUVpxdDlGRWdKRlhtYTRsem9rdlpCT2NObW96dlZKcDdDUHFPWG9V?=
 =?utf-8?B?M3NZblRUYm00YnorSC9ZNmllS0RQVnVRbG8yR1Y0MzFQWFZoRVVnZDFnS0Zs?=
 =?utf-8?B?QXh4RHhLcFlNVDhOVFd6K3NyZlhTYjlTUWVUOHhWeXVzenRKTVJQb0NiUEl1?=
 =?utf-8?B?Q3U1QmxSbVhsdDBhSkhVNll0ZEplN1R1R3M1VXdGampucUo0T0JUZHIrbWFn?=
 =?utf-8?B?NHZCQ1djZ2E1ejJMQ1R4MkpQMlB5MXJTditxcklncXBya200aUxxaUg0ZFVM?=
 =?utf-8?B?YWc3azRpVUVNQjMyc2pTMWo5OFJnZUVHL09RQVA1RVVwNE5XdTBSc3VWMm1a?=
 =?utf-8?B?ajBybmF3YlA1TEhGMFMzMUIvYTJMMkF2Y1FyMTZ6c2ZQcnE4THlOMktjWko0?=
 =?utf-8?B?R0NMbE9rMUkrb3hWZ2hQY1ZwWGI2SEJjWnhHejRZdnd0SjE3WDFiVzBudjc0?=
 =?utf-8?B?NkpmdkprMnNIclpwMk5IVnd2ZWxpVGFsZkZQR2JqZXNuUU1WMEJoaUd0cXVm?=
 =?utf-8?B?WFowUWRIeXhRTi9BTWNtcThLT0NmOVBTb2RLaFhKN3BMNnpqcW5jb3FiRGlU?=
 =?utf-8?Q?pT8r/IKz6C5nAc0BNBiLUTZ2/qore0+s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRkM3M4bGVKZGt4SEttSDhMSFhHK0xHUHpFZTRJMSt3QUQ4TW9aZjRtem14?=
 =?utf-8?B?S1dGZFFodlV3Rm02TmtOcmJSY1ZoVkFQYzZxOTErbldLVjA3MS92TFhrUUZK?=
 =?utf-8?B?Q25mayt3cVBydnd6TnNYajVwN2lWM0RJdnpLVFNzeDRlQnlSRWpkSk1DWm9y?=
 =?utf-8?B?OWtYSDR5RGNqeVZTK1A4b2FMSWcvVGdESHZZa2hNWFQvYmkyWWxzVmkvWlV2?=
 =?utf-8?B?cE5oWVdEYmgwWHFQREM5bGFla2h4YkR3VG9qaWhGK1Zneis0SiswdHlyWWZH?=
 =?utf-8?B?UU1CdE52M0g4V1dBMW5TNkc1Qi82UTg0aFZRZEU5N1cvUytIZ0UvbHV5dzJS?=
 =?utf-8?B?WC9xSi9nTk1CMGwyY0FSYzJnaFNoeXc1R0cvTFdoRWppU29pOXNVZmhac00z?=
 =?utf-8?B?bXE1L2dDUWkzc3ZIU09uRVFBWUV5ZUpCNTFObnFuU0hwdDBJZnZBUkluZjVT?=
 =?utf-8?B?WEJoODZEb3Z6TjMvSHVFb0V4UllpUWVNMFFVbmtlUVNCUVRrSnhVMzh6Y3Jp?=
 =?utf-8?B?SEJYT2tUdnRFRGNvZ0pHN2lmbVhJQzNQZVJaanNVb3FEOUZLa1Zuak0wTzVM?=
 =?utf-8?B?UHE4c2NHYkNXYzZ4TTNjN1ZvalRVNVpqMEc3WFpHdll5R2RCRW04cXE2dlJE?=
 =?utf-8?B?YW1UR1FhWDgrZjNrQTNkTmx2UkFTUzY0c3FQWUtDUkxDM1hUWWw5WXBCL0lN?=
 =?utf-8?B?SDJYdGNVQzlRTnBGbFV1QUlVa1dwWXZqVlk4QmVhdzlGOThsdkJkSEMrcDZl?=
 =?utf-8?B?VGt0b2FJYVo3VU5IcEdHR0ZwWjMxLzJoMFYza1RzWXArdjdTVDJ0bGZYQnhG?=
 =?utf-8?B?K0ZGRUhEWmY4eXBLaTJXUytMMDFzTnNCVE90UVpyMHJ1YWprcnhZRmdoTFpk?=
 =?utf-8?B?SHF6QWZWYzRTMTUyMHhiTGp6YzVxdC9tUU1LRnlXc3RueUZTYXlnNm1BNTlB?=
 =?utf-8?B?cklYNVJQNTFnc0lDcVdDTFhCNGh3WC90RVI1UlQ0SEJVVTZacUN2dXcxZ2Ry?=
 =?utf-8?B?K0RNYU10eDRRSUxrMC9NU2xhRVNyZHQvUnhmTFlZZm1LRnl1Zk42dCtuVUlW?=
 =?utf-8?B?OWJpSGRPSmp4VThxaFRvTVJwQnUvdGtmcTRQU0Z1SHVkU3V0WTJhaEJwTUI5?=
 =?utf-8?B?Uk9Xam0wSndjbStHSDJQKzNWd1padU9URFQ0czBveFVzanRrK0RlR3lIdjVJ?=
 =?utf-8?B?NHlpSW1ENUMwOFpUdXlzTHhiQlhiT3owTVFHSnVuQmhpMzVkOXpjMDVBOGRL?=
 =?utf-8?B?WGp5MjVZZjRyeDlGNzFOWWEvRHBiTVl5SGtCQm16QUs5WjRzczZYdjVjc3BK?=
 =?utf-8?B?UGhFT0tzbWcweEpUU1ROUGpPUmFzbnVNdHVkVHpjdGNqaDhQbDR0bmtkOHM5?=
 =?utf-8?B?RWVPRnZEWDd4ZUpkZ3cvblVod0dBOU5hOWlRZ1VIYVlGdjBRNjVOdCswNGpp?=
 =?utf-8?B?T1RuSDZzWEVEakorWTJTdGdBN3diVlRVdEJWMTY1cFUwQXJiSTVSMzk5d1pu?=
 =?utf-8?B?cnNIVG1Pc1pBNFdQdG1yZWNEc0gxWm1IdWdldk5DTFYxT3JsNXBnVGdkZ094?=
 =?utf-8?B?MlV3NEUwbWNyOTNWMTlRVHB5ODZtY253c2sxZG10QXJ1bjYyTjBPTkNEejdO?=
 =?utf-8?B?ckMxQWdpRm1QRkJ2L1hPZXI4Y0crOEw4bURFTUFIUjlOWko1eTlnYjRvNHFj?=
 =?utf-8?B?M1p0VTNrS3dVdVE2MmJHRDY1cmh1UC9MVWJHQm4yaVlTamR0a2MyUWsxU2F0?=
 =?utf-8?B?Ty9udlRxWGVac2JubFJjS3FwOXVuK25XWXlXcnVLNU1sdU05TE02UEVKRlBh?=
 =?utf-8?B?S05oU0pUV1V6L2tRMDNickNiYytJZGg1U21TYW13Y3Izaml6Q0lINm0wSU1o?=
 =?utf-8?B?RVNTb2VUbUJkdGxrQnFZSTNESW41UEdEVHJiNEJ5dUxDdFFpWjZnMzdjQWww?=
 =?utf-8?B?NzRzMVdaaXcvMzB3Q2g0U01Tb0lZc1JXVG9nRGJWTmNnZ0xsbTBMaGpqNFgv?=
 =?utf-8?B?NGZUaGtBSHhhNm90VDFlTHZ3SFVQRkdENzdyaEdNQTEyclQzcXpxK2RHemgz?=
 =?utf-8?B?a3AwRmV1RGlzKytsU0F1eWdCc1NNT3ZYVlA0M0pnVFRXK3E2VWc4cVdYYTIy?=
 =?utf-8?B?cnZlNzZNYndDZms4THgvcnJRamUwR0JmOFlVcTZFQTVXWVEvNzRweWVOSEdu?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c9128-d1f1-4aa0-13ba-08de1ae252ac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:07:28.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZHQaFuuEsPTRZ4ti10HyMbMQ6LfW9uuH8XnbbgpMcPUfiHw6PQOVIOz6+L5+YCB4mZv7pPXv1KSihKBk7yC6w6pUB+lu/uYhNAaR/lrOjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11519
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

Hi Rasmus,

On 10/20/25 2:10 PM, Rasmus Villemoes wrote:
> Not all ->get_info implementations necessarily populate all the string
> members of struct disk_partition.
> 
> Currently, only part_get_info_by_type() (and thereby part_get_info)
> ensure that the uuid strings are initialized; part_get_info_by_type()
> and part_get_info_by_uuid() do not. In fact, the latter could lead to
> a false positive match - if the ->get_info backend does not populate
> info->uuid, stale contents in info could cause the strncasecmp() to
> succeed.
> 
> None of the functions currently ensure that the ->name and ->type
> strings are initialized.
> 
> Instead of forcing all callers of any of these functions to
> pre-initialize info, or all implementations of the ->get_info method
> to ensure there are valid C strings in all four fields, create a small
> helper function and factor all invocations of ->get_info through that.
> 

Considering we only have code calling get_info() function of the part 
driver in the two files changed in this commit, but there's nothing 
forbidding users to call it from their driver or board files, but I 
guess this is good enough and we can worry about non-existing users later?

> This also consolidates the -ENOSYS check and standardizes on using
> log_debug() for reporting absence, instead of the current mix of
> PRINTF and log_debug(). It does mean we have to special-case -ENOSYS
> in the error cases inside the loops in the _by_uuid() and _by_name()
> functions, but it's still a net win in #LOC.
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
