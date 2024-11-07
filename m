Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3F0D35E5D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2C188B55;
	Thu,  7 Nov 2024 11:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O2R51AoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D441891E1; Thu,  7 Nov 2024 11:56:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EE588B4B
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD7RSD3A46yTthAdnCEXMK2rML+CLOHIkhsgrcv+F4eQcInayngotozPiWoeRI5rqDWT2FzD7EP9oxzesoSn4J/ot2Qojy8qGNiRKWmX2t2pfnV4tOMLVYeQMQnAnkh9e1iVJJHGHrDhGtAxgJmibsCGpnQ0llne5/fJYQxHBFqUc80SzTJKRQekkaPgmd7SFXoBF3ahFZBTDDqQPf+1/WCf4jNRd8tnbskI8DuQGQopo6f2rvYuhTauSI3tN708riC4sNO9kykM/GJiZ6fcYQ74sDqXnBmC/iER4DPykJDETlQqLBFg6xxd9PeEwlsJgol+aVY128yu3ubTIlOwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsjgtkYWgARzr0TE00E+mSGjoEpxDLPVAPZxUG2DQs0=;
 b=ED71UKgT79SYeUgLF+C8U0ad/tcLpGCtTCLyYh3ILS8hobesbaPJ54ZeoQfOwhbRDiD22+GbLFA5Wxb+WffwEQtKvO9DHnG/ASeIqUsyeJsx6X1uFwvWCYhCQZUTpbaa+8wbmxEtLh+z66nBTj2GXmRRO05OHzZP2bhYOdsoggUsi7NpzPp1zl1ZDZ24HXjhHFnPOg4+eFDazW9oW0Jbr5TwTXmlpoYSylR8wMf9HD6W229nR36WYLPjjWeiMpYwROn74ln2WgflegN3rqyn5SIZCyCbB++nNrm/UTZ+wvtMC6CaS8wbGtmEtimg3ppHHd2JoqW9Cb7mZ24phPUOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsjgtkYWgARzr0TE00E+mSGjoEpxDLPVAPZxUG2DQs0=;
 b=O2R51AoH6ESsMOosCe+1QO/pcGrJyqjITCcnUp51xR3CyiI1uCgKQ028yo5IeSmKxsum/Z11Dl84zR6DjMbf2SmYLed/XUegm+/Q1i+MwLOTrVJ6bTVOMLbNfy9RtyfOVxAczJtgRYWkUJybNtExcelyncgP/7ac4X0hkytxbBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9134.eurprd04.prod.outlook.com (2603:10a6:150:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 10:55:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 10:55:54 +0000
Message-ID: <c5330ea7-0a9e-4473-a672-c9a61a19291d@cherry.de>
Date: Thu, 7 Nov 2024 11:55:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 0/5] rockchip: panic() when DRAM init fails
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
 <e46008d2-19ae-4f48-a223-6d73e528b39a@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e46008d2-19ae-4f48-a223-6d73e528b39a@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0759071e-8da4-4923-b1b6-08dcff1ac039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEtzM01GdXFUTVZJR0MxcGtjbE5zVnE3K1NXSlFFaStCc0lycGxoQ0x6SGdi?=
 =?utf-8?B?RlRzVWlGYVcvK3N3Rk5qSEs2aUxVbVBpQ2cwWWIxekxMYlJ2WTk2YjBSZzl6?=
 =?utf-8?B?T2piRmhEaDVUT1NGUFNQODFvOGcvV3NhR0x2OUV6cU1Da2s0ZXFUVkJGMFFv?=
 =?utf-8?B?TEx1YlV3TlJQMytNbHBRVTRBYy84dmVKWmxJRVlpSWc0UDJhc250S3ZxekRy?=
 =?utf-8?B?a0x5blZXV3pNWlVHeDlzaU12c2VVeUE1M3EyaFJ1cXJLYmNGdFR4dlIwaG1P?=
 =?utf-8?B?bHVQdFlzWHh5Tk11LzdxejRBMEM2cWo4UDNhR2VVYVREWFBZS05oMVBLUmJE?=
 =?utf-8?B?RFY5SDFtOGZKTE5ZTDkwT3ZKSk5QQS9nT09KSGZPU2tUa0E0dFY0Ukt1cDE4?=
 =?utf-8?B?VldrYTJ3eWlBaHROMzFSMWJzek4wSGw3cDIzazVTTlZYS1dWZ3F1endCb0Uw?=
 =?utf-8?B?MGxqM2NmWmhycElrbkRmdDE0dGh6ZFpCWnUwL3BzSWJNOUF3UU9JWGt2aVNM?=
 =?utf-8?B?Vzh4M20wQjZrYjRCa0R6akREanlsQ0wwbTF5cnc3RFRiYjkvRllvMHVscHpo?=
 =?utf-8?B?UzlYVlNiaEZSZWxGbDBINldOMi9HamJ4b1pGSzJWWnZlaHJEck43bnhWNHFt?=
 =?utf-8?B?djFQTEF4YkMrcnZHejVNbDJCeGdhelh0WGlVM3hIMlM0c2NhV2JNakh6QkNL?=
 =?utf-8?B?ZFJGdmpKc3JuSmNTVTZ2YW5RMXQ2eGFWWDNaS2VvWTZ5eks5bTdXOUdyeFI0?=
 =?utf-8?B?R1FtNGNYQi85R2dVdFptRmpWZGxkN2RzTzhLcGlyT2JDaEdlN3JzWk85MmpU?=
 =?utf-8?B?L2M5L0lWTTQ1L0xBUVgyRzBnVFY1WGF5WVllaVI0V1BZT2x6clVUSXdQUTRa?=
 =?utf-8?B?eW93THVMWVZPMWhmWHZNWkRIVjg5LzJqUkdTQnN0U1pRZGprNHBXbE5KLzdq?=
 =?utf-8?B?ZHVRVTVWVndqUkFxV1RFVk15U2ZlN1dQZWk1Y3FvMGs0SUM4dkVEVlIyeEho?=
 =?utf-8?B?bVk4VDJsY0oxZGRGUlE5QnFkc2ExNjJLTno3c2daU09zeFR6T25Vd1kwendB?=
 =?utf-8?B?YkNBcitVbUJNYURYcFpiUzRsTzA3eHd6THNqV3ZiaWZmRUQrQUduTXlFYnJW?=
 =?utf-8?B?aW1UdVJacTBTRGc4dDJzVG9uZWdkN2tibjU2MVFmOW52N1NYcUV3SEVRR2ZO?=
 =?utf-8?B?R3QxWTZHSysxVStIZytnTFZZQzQxRldYMUQwR2diNHFMT2w2VFR3N1pLWUhk?=
 =?utf-8?B?VVBFTjBEZ1Y4WkRnVmNxbzl1S0ZoSGhMMUQzOWFpbDVxbW5pNjlJV0txWmxW?=
 =?utf-8?B?RWNzOFl5ck1naThqTWZrVHJOYjBKOHZsOEdBL09idys0ckNzckRkbUxpNzZu?=
 =?utf-8?B?clhzemFjUlNQdmZzVnFEemVlZmcvVDJHbk5zY3RzUWZWb09xTHhWeEdYQTdp?=
 =?utf-8?B?OGQyZkEvOVJUUi9SdTRMTEd0bjgreGxXdk5tTWhhakdoNnFRMW1GbEVrenpC?=
 =?utf-8?B?cHBpOS90YVFvS211L0lhWEwrdXB5ZExvQXJJeVovVDNaaXI5bmdNVHhRdk96?=
 =?utf-8?B?TmhBOG1NaTgvR0V2WFZjN2ttUEJxWU9hUjhiNlByUDkyQVFkQi81NndRYU5D?=
 =?utf-8?B?d2tNcFU0aDlVV3d5YkorRXdPN2l3YVJ4d2l3bC9aVEw5OXJIWWZzRk1zQ3Na?=
 =?utf-8?Q?wVM9srTFHFpLuYI3S4Gi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZNaGpYZzZ1d0xBWUFKamludHE1Yy9wYlhvMTQ1QUR2aHV0QkVTLzA5SmFr?=
 =?utf-8?B?dm84aXh1TFkyOHdBSWtUVFBsSnpqekxEcmFXNk0wZlk0N2dicE1LTjQ3QXFH?=
 =?utf-8?B?MkxLd1F3RFArZFJ4MCtYRlFKK2t4biswbVZ1ZFpqU0ZLSDBuUk15aTZWMEV0?=
 =?utf-8?B?NVkrNkljVFdzNVd0elZVdnpkblBCcDhIUC83ZDE3emMrTWN1dGJWa29FNDgv?=
 =?utf-8?B?S2ZJaW16RmhyNkpsWi9SRGluV1gxeHJsdGVtNFZCVUY0ZS8vVHVPdFJVRWs5?=
 =?utf-8?B?ZG5QMzE4d2ZaZi8yTGRLaXNmTXFvSGxiUnFDZ3pZVnEzM3g0a0MxMXM2TGo2?=
 =?utf-8?B?ZXJaK0dWTFAyMUlXNXBZcExma3JzNU0rU2lEc2I2T2V3MlhWV0tPa2phYjdW?=
 =?utf-8?B?NWdvUGx2aUtmSDNPOG1rSEZnVXVTZi9xNkJudXRjSmd1M3hyVjlkU3puUXVD?=
 =?utf-8?B?cTN4aXdUd1FZWXA2RFY3dkFoanlaZ2tqK0JqaHN6azYxSjAzd0hhTm0rcG83?=
 =?utf-8?B?c0ZFV3cvbGZtQ3dlRjJZcDlDS01KZ0ZIMkVoNHJvR3JZNTZmb2ZGTXVEWjNv?=
 =?utf-8?B?aDhQNmw5Wm03cFh6WjFVZVhaU29xZVVBVkh6SjBZMDN1L2cwYnBab0I1c1BC?=
 =?utf-8?B?Q0J0SnFseUo5dHQyQ0JaaW9VS21SZEI1TTNKSXVFZW81M3p5S3dsUVdvRHIx?=
 =?utf-8?B?Q1p2bXBybjhNaFFXUXl0U0VvNyt2M3hUTi94UEFnZDdKbXdNbURHVlVKVS8x?=
 =?utf-8?B?OWlpaDhacWNTaU1SR0hINXF2UHBNYUkrY1JKeGlaYm5XVFROOFAxcC9Yd2hU?=
 =?utf-8?B?cnZ2RDBYNnVTUFVidWtlR0lJNHkxRVZjVjZxVWExeUNqaWxSQVAzOXRaVThL?=
 =?utf-8?B?ZWZzTjlkb0dQOWl0S0plVy9YRTF1U2tOMktDNHpQR29ZS2lLZFJlSS9qbE5o?=
 =?utf-8?B?NUVzQk0xbEM4QjNibDV4ek5oekEvSjNCaEppVkdXSmF2RGNCUmFNWlgvWWZE?=
 =?utf-8?B?ZzU0cFM0eDU1VlhHMVhVSnJmZkdMMVNPQ0FvdVNiQjNJNUdLamJuMXRmZU9u?=
 =?utf-8?B?ZS9qNTFGY09mTnpEcUJHOGhBcmNRZHpQa0E1T0tWc1psL0pua29Mbk9tblpz?=
 =?utf-8?B?SHZYY1FIRWIrd3lOZUgzMUNVTDFsd1N0RFdheGVNU21Uc0IxcmVPODl2UkhH?=
 =?utf-8?B?bXIwQk5XeER1QloyUkVYODdYT05xbW1ZTGlXSWZ0MUlZdUlSUTFGM1NyMFNs?=
 =?utf-8?B?QXA4dy83L3A2akJXWGZoWncwQmh2bGZ1UnRuK1ovTnhhUlpWVmlGbU9VVU9q?=
 =?utf-8?B?Q05VSVhOaXZNZUg0M0M0RmhNU242NXFiZU1vREVnQ2M4QjNJd3hxMFZkTkQw?=
 =?utf-8?B?RmIrcmd0WkVpYTM5NTdETytPcncvK2x5aHlZWGhMQlNlSVphVTZmLzNFWG5T?=
 =?utf-8?B?U0VKbTJIdm9EemJRb2ZaM0tRejNCNnQ3RUhhY3lTUHcxRWZ6Z0RiaG9jZytw?=
 =?utf-8?B?ZkgvSndpUzJRd2VCN0orQ3F2aGx6K3ZZTitzRkMwa0N4Q3Y1bEpWZ2xTMDNE?=
 =?utf-8?B?dDBQUDNwT0s5WHpsRTRuc2I0eHFiencza0gzaHExQUVibm1xeEo2VHFjTzJz?=
 =?utf-8?B?TG8ydmN5UHlhVmUxRytiS0EyU1ptQkxidmJmZ1hNa3k4enJ6OHFuckdEQ0ln?=
 =?utf-8?B?VGR3OFJlWFJyZkdOb0NQa0tSQ3pCVkY5Yjk2ajQwMEU3cUVMamZJbHZLM2dE?=
 =?utf-8?B?akZ6anZIUjVBZmtuNTJZY0NFUGxqVS9LSjYvQmltOElKUVpqT1BqVnVQUUdX?=
 =?utf-8?B?V3JmemZGeXNLMGl4MTVRb3loczZ4b29qMy93WnFwenJWazBwdnpIMkdXZTVt?=
 =?utf-8?B?RnZuWERYYzloNlVPSEFZSUhScHc3Y2xaT3dFai9VdFVXZ2dnbjZEU2x0T1JC?=
 =?utf-8?B?SXFya0JsMlJnQTBBTWNKQVBMSHNmd1FjTkZsUlc0MTJ6T3Q1NDUyREQ0cktp?=
 =?utf-8?B?cEhOU292ODV4Z3Zmd3o2WXlqbEFWRm9XK2ZXTTlRQmVIK0w3dHpLSUw2MFk3?=
 =?utf-8?B?ZHNhaXkvM0lHWHRnYmZOOWJuSzBRa3l4bW1vN3A3TGVTbFlTaGVoMjkveXA1?=
 =?utf-8?B?K0hpOU5uN0l5RU5sOWNkcU91Q09JSWEwZXFpbXRROGpjUE0xT1d3aXR5WUlW?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0759071e-8da4-4923-b1b6-08dcff1ac039
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:55:54.0761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0w8NeU4cKay36H2lJnF7mQ0z+mjqTVD4O9oSgAqTgnSiVdTznaPnRuvxJqjJbHI7fPiFr4oLwq+Iqdb10vjl2M6jiQXEksCCEaC2ulfC4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9134
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

Hi Kever,

On 11/7/24 4:35 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/11/6 01:21, Quentin Schulz wrote:
>> I am the unfortunate owner of an RK3399 Puma that is failing DRAM init
>> every now and then with the following cryptic error message:
>> """
>> pctl_start: Failed to init pctl channel 0
>> """
>>
>> When it fails, the current logic is implemented in such a way that the
>> board enters an infinite while loop. This is not ideal for embedded
>> systems that are not easily accessible and also an issue when having
>> devices in a CI lab for example.
> 
> It's fine for this patch to make the choice in panic to hang or to reset 
> the system.
> 
> But I don't understand how this help you, does it may success to init 
> the dram after
> 
> the reset in your case? I think in most case the board will keep reset 
> because this is
> 
> more likely hardware issue and not able to became success after reset.
> 

Exactly. After a reset (manual by pressing the reset button, or by 
panic()) the board works again. I don't have exact numbers for the 
probability for this to happen, but I had a board doing boot-into-Linux 
tests in a loop and it failed multiple times in the same day. Gut 
feeling is around ~10-20 times for ~2200 reboots.

I am NOT saying this is not related to a HW issue though, but I've been 
using that RK3399 Puma for a while, and sometimes I have this issue. The 
rest of the time it seems to "work fine" (haven't run memtest or 
extensive testing on that unit though).

I am NOT sure BUT I think applying 
https://github.com/rockchip-linux/u-boot/commit/e1652d3918b182e107addd5e6f451655f239efbc 
on upstream U-Boot helped lower the probability (it still happened 
though!). Could be totally unrelated though and just flukes.

Cheers,
Quentin
