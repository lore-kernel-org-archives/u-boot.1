Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C42BC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8244A83622;
	Fri, 18 Jul 2025 15:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h15kAhgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC5C8365E; Fri, 18 Jul 2025 15:25:37 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA32383616
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 15:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW2KlUyGGWGluuVlW3RZ/tkOhmjCUv1R88XOXEO3y60QAL577xO/TuG0KuMQfGZUFDvraMdvxa1JH06jXnjbCFr9gmOO5FOfxZqfi3QOKs3CJzOtmqFm4G2I/vgMvqzjaNCpiid1J6VTZMEeGmug+rysj510hOKu92QI2PfvoUv0R96ufyPif5N0o8cQ0oO4XpOyFi/LupnivNf/0D/S03mLbMw3iWa5FVk7vVmhlv8HgY2Akg9W7NcIHUoWOYe531jaEQPyQedRKY+EVrCQfOaDocMncbULZVHTWPM/duQAdonQXzVoYYauqhWhkBtvMNHyhYYCDjBiwQVL1N2QoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IN6qRRXrXd8T/PHzsUXw4V1a0jELDHci6UK4nFPHNM=;
 b=vpUasAbPNmwWF5MSQ+vgdNktIAIeXC51LC3mu3ZOLQppyEGxSjX3noUmcPquPgm0uPv1mt+WYsBEnPJh2dYcSihG4GsK2hp578idKAk0PtqrXcm3clVnKuePNTcxEn82R9CsH9xZXt7RyQRNqsg6irihd4fCxbsthD64vdMLFfWLwFPfEhJg3DFKpUgieRf+dcq6M3Dy1Nle189PQp4PIQgKKhTi8gKCp8N4JWy6TfdSuhtjUImuL586/wUUzuWoQeajNQvvEWGnhlpo1oWMBw7xKB7mrHnXvuY47jwJjXkYbsAoUfwLR0FFV42Y7gPslx+c6siEIO6bFbZlN9kSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IN6qRRXrXd8T/PHzsUXw4V1a0jELDHci6UK4nFPHNM=;
 b=h15kAhgpt3W4kYZTaPpqihUmiun+BTkKPW4dFSEhj98Xt0MBZxVE1/GSysWc1LXZsj34+u1riUp2FuL2preCoWVxTxmT2Y8MHvYZmjr+lnlzbxCk8uFFRdNiY0Qz4llIa6SqwAvjqHKYoo0VFJUxMRIJvMKcFKMJbirD/O5KBXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:25:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 13:25:32 +0000
Message-ID: <6c32d0f6-7df5-4f2b-8ed2-2eb97a818869@cherry.de>
Date: Fri, 18 Jul 2025 15:25:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: dns depend on enabled protocol config instead
 of command
To: Jerome Forissier <jerome.forissier@linaro.org>, E Shattow
 <e@freeshell.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
References: <20250712050121.88951-1-e@freeshell.de>
 <60f316be-a61e-4a8e-8f5a-964fd3e1b912@freeshell.de>
 <d0c203c4-3981-40d2-986b-93daf8737379@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d0c203c4-3981-40d2-986b-93daf8737379@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1445cd9a-ec80-424c-34db-08ddc5fe925a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1hhRFFDellRWjVFY1VWb1lZOEI4RjJLc0hrbGtscEFMa1NoVE5JSmlaUkJr?=
 =?utf-8?B?YUtXWmJHTDlOMFRpQkVFM2g5M1V4WjBpVzV2RCs1ZGx5aUh6eFdpM0hHZ3ZJ?=
 =?utf-8?B?OTNkdmN1R2p6UHFjdTdrUVhwTUpoNUlSbU8wenVJMG9FWXlMNVRPYm1UWm4r?=
 =?utf-8?B?VjhuUnJ4V0hwV0o0ZFJtUFU1ZjVDNW5hVGwwRWJDNWtoMzg5bmpyZVFOa3Z2?=
 =?utf-8?B?bEVOaWNmRVJJS2x1QWxLOEVmQTRKektEUHVwalcraWkvblFDYUx5dCtCQ0Vl?=
 =?utf-8?B?TXJUMHdGWUY5UFlwcUdpZW1lUkM4WnlJWExNM0IrZ0JzMVhYMGN2Q0tzNVJo?=
 =?utf-8?B?K09UbjN0eGVZbHg5U0V1R3NKOUs5MVJGa1IyZlBlVHgwaTR0TE40cDRtR3dD?=
 =?utf-8?B?Q2psT01weUN6NW01RXdZUmNsTENHd2RIaFBib3FrMnZrRHVwajI4YVhxOU5Z?=
 =?utf-8?B?UmZxQS9NdkpYL0tDMDVudWRqVXM0YnhBREFkSU1qdTJMZElINExjZGxaSWp2?=
 =?utf-8?B?RTh1di9jOXJCNjBQbnd5TjFhd3FtaUV6V1BoRjhPeGRRTHh5OGxwSGlGR2p6?=
 =?utf-8?B?VFRJcjN4eHVtS3JPUEJBQ0ZxVmYzZVFSRFdjeElkcXhBWm4zc21JMnd4czZj?=
 =?utf-8?B?dGt2b0VWRmgyRStyMXpLd1BNTHVLOXEvZnZzalRQd1A0b0srTXVFY2d5QjRV?=
 =?utf-8?B?dUxMN2dYTGVVRUNRV0MyYU5pOCt1YlNWZWlFR0xhOFpGN0hEUGx0UU04L1pD?=
 =?utf-8?B?VUdQb3AxQlVoTGVkMTBuNDVndXVYbzlzbmVUYWluUmdvVW10Vzh6MjlmMnJp?=
 =?utf-8?B?U1piZFVUdXpYaERSNHA1L29CZGUrWnVYQXBMWmo3UUdSekMrdFdwRDFBcjht?=
 =?utf-8?B?Wm1NQ1g0YXNKZWNwbklEQmlENFAwaTZ5cm5XZW9iV0I4Smc3UCtKdWRtWkhP?=
 =?utf-8?B?MFU3NlNPb2RHMVJDK3pOT0p5WXIrYm8yeUxnSndYSlJ2UktPK3lDUllQUlNq?=
 =?utf-8?B?cE5tQTJNV2wrZHk2aFdPU0lHTEVpZjdqQ0FVYi9aYVhHRThYSGE4ekZlVFEy?=
 =?utf-8?B?S01RdHZaaTR0T0xKU3ZMM0JwZVFJMnNjaDhub1Nsdnh5ZXhRU2E3alZUM1N3?=
 =?utf-8?B?cmRQekFQelZyZkY2cys0WG12dm1SMjBOWmx0NmZxTWZnaGU0enMyZmZTcEo2?=
 =?utf-8?B?ZG1ndVdzNGIxeWRxc1hMU1dBQyt0dFhDYkVqMFJnT0dTQlcvVm1SbGQvY3ZF?=
 =?utf-8?B?ZStQUWo4a0NkV2pETTBQVXBIUzZNRmpaallienZ0SzNoVGlxYVFnN3hiYUtC?=
 =?utf-8?B?SENGYUJsQ2FjajM5MlFReWpBQk01T0FXZlpLSmlySGJSaXBhODVIeXAxR0ZK?=
 =?utf-8?B?eDdoRzdBYUJnUUpuUG4vUi9RM0dmVGkxQUltRzlIR0ROd1pzVlZNM2RGNGhs?=
 =?utf-8?B?MWE3dUJPc3JXMzJTQm5UcEFrdXBIeFROV2x6c2hJVHBJRHB3MVByRmFkWnN1?=
 =?utf-8?B?NVZCVjBkaVVXNTU4eU1GU2o0eUpnUGYrT3VzMWFoSWkySzMyOTZsTXo1SFQ2?=
 =?utf-8?B?NS9MT1NkWU12N0ZRbDVyanBRekZ0ZXBrQVpobS9yWGR5T0QyeXRPaG5PT2FH?=
 =?utf-8?B?ZUs3b3RmV2oraHJlTmc4L3d3alRSOWg2T2FBL20vSTU1K1g0T0ZBcndoYXNy?=
 =?utf-8?B?aGYydXUxb1l2blRabGVIbUovQTZpeXQrYjR5djk4U1hzTWtJcWI3ZUN0dWg3?=
 =?utf-8?B?N3lmTkxuS1lHQWEydG9qMC9mL2d2WXc1UGVmOUNpSStZRURPdDBxc0h2aWsy?=
 =?utf-8?Q?sO+t6aP823Z9w+eU6cnjeTk3oISOo3X7lUTXs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VityRVZOS3ViZThpaEFPK2pheWhJa2wvdlpJUW15ZFU3NDRRMEtvL0Q0U3FB?=
 =?utf-8?B?am9yaTRxcDVCOTQyZWRrM20zNzVCSElEMDZ5M21LRUVubEYySFhoQTh6SWNZ?=
 =?utf-8?B?NGhYSDc1K2RSRmttYlFKamhmN1d2cmxxNEk0clNWK1owMFdRMFpKN3FsbStQ?=
 =?utf-8?B?L0tIanJ3MXJreHpEdTVXYUd0OC9pWVhQMXFPYmcrTllmRVpWUU8xaE9rVDNW?=
 =?utf-8?B?NHo3VDdxeDBzTzFQL3Z0VHRpUHhTYkgySjJGMTdlM2lEZm0wMU9IL2dtUWtN?=
 =?utf-8?B?OHpxeTZLa3pkUno3M3NNcHhmWVdWc2tRYjVHeGIrbHZiSnZxNkdHazVhcUxX?=
 =?utf-8?B?ZHZoaDcvWngxTWpiUHdIMnhoUjBYcXRVZ0Fvb00zM1pTdG1Sc0E1alB2T1Vy?=
 =?utf-8?B?UHJ0aHdOZllUM0dpbUFmLzNVS3N0YVk1V3FsWTNCRUdsL3A2ZllXczg4bzV0?=
 =?utf-8?B?bEd5cTZZb1o3cklQL282eEFFR0RzTjVaNGlJUkdtYVdMOHc0ZDJIbkZDR1BJ?=
 =?utf-8?B?dmhmZ1BJbmVrQjBWZzdpb2t5cnFRN2c4c3E4TnJUNk01clA4NVZyYmxqQjBM?=
 =?utf-8?B?REM5TnJGUjRsZklrSUdtTlJwV1ZtYlVkbzhaRzZnQnA0OHU3NThsVUJUdjQx?=
 =?utf-8?B?dElnWnBiamlTbWNwMVhWMFoyVkRCK2JFb1BzeU0reXVzalE3em51NzRHd0lE?=
 =?utf-8?B?OFVTajhOSWNjQ1RPOGd5NStXOFhOVldpdjlmb3BrTjZSWXR1ZnVWdW9DRnc0?=
 =?utf-8?B?eWJBdWtiVG5ENGU0OFBWTmlvZVowNDdBNi9lNXFNT2VkWGtCVHZzc3AxMGo2?=
 =?utf-8?B?QW1QQVREQjVVVXllZUFZVHphZC9JYnE0RExycllaNGdjQ2NmMFBiNkk3Y0x3?=
 =?utf-8?B?NHdQaThvaCtoTStadmxsdGpKV1NaK1I4U3VNTzhGWXdJdy9MU05GS3RIc204?=
 =?utf-8?B?RHkzMCs2UmVvV1pJSWxNL21PN2JENFVmckVFbTlRZzRqQ1p3M3NZeTZ3Tytr?=
 =?utf-8?B?MnRwZlFuQUc1alFTbkJHZEpnUHQvWW5tZ2dhb3RaRDg4YkpJUFpsa3FFWWpP?=
 =?utf-8?B?QVdlL0txbk91WDZ1OU4wUG1jWkk5YnNTRllpOGtIaU5Kb0pJRWRadXBFazJ0?=
 =?utf-8?B?YkVGVFpuQVhjL0Q0QkJIcTZrbGRQN1p0d3I2VFdWUjlENURLQks0eWxOY2FF?=
 =?utf-8?B?eVJIZEx5ZjRBMjZ5VGJwRXVBRDBxRk8rdXRac2R5S3VueTJmYXlRZllrb3hT?=
 =?utf-8?B?VnQxaUJlREFVZzFacEZaWTJEbTJNRDhpWGNEZjFObUJVREhtVzRIaG1sTjky?=
 =?utf-8?B?S0lsSHJDMVJiM0lQQ2YvOS9rdUk2YjEvYmNGVEZuWmY4N1ZZY1AxY2k3YWlt?=
 =?utf-8?B?b3gvVzFRL1UzeE8yMHY1Mjg3WG85UHp2NU9qY1ArTXNTazd6V2JZOHpPang3?=
 =?utf-8?B?WkYyVFJ1MU5zTXdlcXpJa2VmenBZbjg2TWFLSlBuYWlObHdwOVhubU9GWjFM?=
 =?utf-8?B?YU5SbFRyQkJhaVVYWUlGUmFpV2xYaHJtcjk0QXVQZFRPajA4Sll4bUFKRUhI?=
 =?utf-8?B?clhCWXlJQnRiRjVxc2FmbUtqa1BmTUlUY1Zud0VONFFkb0szWnNrbEp1c2R0?=
 =?utf-8?B?RDFja1ZyVmxOcVVCb0dkUFVRcVZsYlU1ZHhSeVkydFB2V0huNmFWS3NXaDE3?=
 =?utf-8?B?Z0RibTBMWUpoVERVUUxqanVNdTZXR210SWZaNmdyWXRVeWoxYnJTMjViZVJK?=
 =?utf-8?B?MHltNmRUbzZZeUdyKzI3VEZpMWJZOFR0UFRPNnRwRkJOMXJKbU5BRkZWYzRs?=
 =?utf-8?B?aUQ4TmhCSERVOWh5YWxCdld4RFloRkRHdS9LdlpoeCtqREFZREhkNXBURzd5?=
 =?utf-8?B?OHl5cEJOOHY1SGRrRytIYXNIbm1nbTBNU3RkUmYyTU91djZ2NFQzSjNoS2JV?=
 =?utf-8?B?QncvZmlNa1hMN2ZBenR4OGdlY2NpdFhKazRzWitTT1RoSWV3UVptOGJVOWxM?=
 =?utf-8?B?ckpwYnpKK3JFTmJJcnMwenZHeW00eTF5ZDZrMW9BSmNKNHBBZkhVTFpPd3d2?=
 =?utf-8?B?MUQyMlIyMGVPOGdUdVVJbUhsZllMTFd3cCs5dXNkc0hSSnVhVjZOWTNCbGhr?=
 =?utf-8?B?MnNTdWQ0UkpId2tqaVlIcFdmaTk0eXE5bmltdWNWZkIzbi9LcDBXcEFma0xm?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1445cd9a-ec80-424c-34db-08ddc5fe925a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:25:32.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw8N1rzgB9fArTuP3PV4SeiwnUeBoVyM+KCM8pWO46Vp+wj3E9GezZwZPwy2D0Yda3MdqmxyuOdQB7Z4ERNOi5ZXOtYkKjZsmFUngdAk/Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208
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

Hi Jerome, E,

On 7/18/25 12:29 PM, Jerome Forissier wrote:
> Hi E,
> 
> On 7/14/25 03:52, E Shattow wrote:
>>
>>
>> On 7/11/25 22:01, E Shattow wrote:
>>> Allow dns when enabled CONFIG_PROT_DNS_LWIP=y CONFIG_CMD_DNS=n
>>>
>>> Fixes: a383869d6b58 ("net: lwip: move dns init to common function")
>>> Signed-off-by: E Shattow <e@freeshell.de>
>>> ---
>>>   net/lwip/net-lwip.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>> index 3918d57d7e5..5d247c3721b 100644
>>> --- a/net/lwip/net-lwip.c
>>> +++ b/net/lwip/net-lwip.c
>>> @@ -147,7 +147,7 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>>>    */
>>>   int net_lwip_dns_init(void)
>>>   {
>>> -#if CONFIG_IS_ENABLED(CMD_DNS)
>>> +#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
>>>   	bool has_server = false;
>>>   	ip_addr_t ns;
>>>   	char *nsenv;
>>>
>>> base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
> 
> I think the proper way is to introduce a new "DNS" Kconfig symbol to
> differentiate between DNS support and the DNS command itself. PROT_DNS_LWIP
> should remain an internal symbol not exposed to the user and selected
> automatically when DNS is enabled. DNS would apply to both NET and NET_LWIP.
> 
> We already have a similar mechanism in place for WGET and CMD_WGET.
> 
>>
>> Postscript: There was recently a U-Boot release and the above patch only
>> applies to origin/master (is apparently not needed or applicable to
>> origin/next). However on origin/next there are similar troubles where
>> DNS is disabled unless the dns command is enabled in several network
>> commands, which is something I can test for but am not the expert to
>> make a patch or suggestion for.
> 
> IIUC origin/next is not the proper reference at this point in the release
> cycle, so I would say it doesn't matter.
> 

next is pushed only after -rc2. We are currently in the merge window, so 
master is the target for patches, c.f. 
https://docs.u-boot.org/en/latest/develop/release_cycle.html#release-cycle

Cheers,
Quentin
