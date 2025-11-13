Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B6CD5BB1
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 10:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743AB83D77;
	Thu, 13 Nov 2025 11:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bbjOBOvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6957283DA9; Thu, 13 Nov 2025 11:09:56 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB0683C62
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9DtuwM/6VqD2Pae/JrtcP/YtUdG+3SIwCfkMk/6aCKkShVZ9aBy+wyxu5Je+VJAyelZ8Ct4UW9TUgkSayw6fvAfpUNDLyBjDPs3VvTCC0LDwZXu/m66PkRJpNO8Y0AO7qMUK6NmN756Ythe3syJPK/5kyd03PGoC+awetuwq8w8Ok/+ImjeJROrjc6lDdVyz/1niGPdo+gv1jp2Dcn4/rWAzIaQQ3VxAfWmuVyoOSVUuTNCS81reUiYkpT1GJz5UNGQLFX8zS+6pd+ZuGY0trDYHkBzVWjIJFshpzIc++Mgb3p2kOjf+D5A0gpLxKtO9hKfRrI/H/G7dtn8778vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmPXWGtnZOv4lnDwXGqImEnS9UFJ4uMsKEQSutfAgBI=;
 b=JW64c/uDx5XIfhhNaGIVx9oDk9oAnTlboWCDbEVZX4I6xqXpQbDo3zek9G5OCLO4cMxjXb15DvJ1LjtwqYfx8gk3MH3orRIrDmB/lskreAL21uopwEwwmlOI97pteuDtYmRbzbFmFZtjlUeW/v8rVRxEwiBhWHgvNKXdDdDuS7ssVNY57mRQS7vNYQCDRhbLM6fEwyNGIoL0uU3j3vEteTnBaYQhui0PIKs6d46ngTTtyi5vIsd9SATa/yS3x3mxx4UcrQkKmOP6oknis+H5TjqJVCG4U8QsKu3w8QeX25Ebmyoy843spSujchfH4cYbKqn0gs0CeGVvgTL25itMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmPXWGtnZOv4lnDwXGqImEnS9UFJ4uMsKEQSutfAgBI=;
 b=bbjOBOvr2pC8Qw8ax+6anGXH+Jxt7QRmlbVFtkg8ykY8XMAxdb6fnyOJLe1cb0mriSS6raT4iGdMkX5wIYEghZwZYNldPNvPVlKkGQq6KNewm5wLerxfro6LxaSgpuArENT2Eb99ITldO4QabKiyrD6ib8Lt0PvaBjl+GulutA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 10:09:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:09:51 +0000
Message-ID: <900b6418-6b0b-4fcf-b636-fb24af25a224@cherry.de>
Date: Thu, 13 Nov 2025 11:09:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
To: Kory Maincent <kory.maincent@bootlin.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20251113093313.362055-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251113093313.362055-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f357c4f-13e9-402f-9316-08de229cc8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VERCemNyQ0pXMzJsVjFaMzZ5WFFHUkJsazNtOEpnbXNyNDU0MmdIMWN5Slk0?=
 =?utf-8?B?ZzVuT3BxZEhEdVl0QytTbmtIS25xbDU2eWVFM210dmJscWJCaVpyUmNseXNs?=
 =?utf-8?B?TEwwV1NjQTJoMEwyeElmd0ZzU0gvUTNuLzE2Mng2SnluQWdPVFNHbjRRNU9k?=
 =?utf-8?B?ajByTkpocHJRd3ZJZDlsKzNFYU55NjduTEdkazVjTUNITDJCKzV1M0RFbTAw?=
 =?utf-8?B?bTJ3TFIrbU9zYlM5eCsyb1pRaFovcUQyWmJZMHRyQ1F3V0paOWRxd3doTG1G?=
 =?utf-8?B?SUw4ZDExb3F2N1VLZDV4eUowbFhGbmhtYU94cXNPWnBydXBOQkRLcTY5OG91?=
 =?utf-8?B?ek5VTklwT2Z5ZWI0VXhvbldCQlM3K2Y0eU1DaFlOQk5ZUy9EKzZQMkY4cTFH?=
 =?utf-8?B?dTVOdVFHcmFGem0yYlFJU3Y5UFB6NEJkOTJjWk0yYmR4cEV0Umx6Qk1UU0dJ?=
 =?utf-8?B?RVV4bEFBeG1HZExHMm9YWHdnZThWT295a3BDTVdyWVNFcjdaM1pRRERPendI?=
 =?utf-8?B?OVJ5ODdPYnRqbEVub0VTV1JDWTVTcTdVdlBFbkNVVjVEbXFrMzBiM2szOWdS?=
 =?utf-8?B?UTJsL0kyNjVCNGxheDJtYzZ0RWk1M2NHQVpwUTZBQ2xQb2lHNWFnYkM4ZVNx?=
 =?utf-8?B?clNLS3ladWcyeU8yRVN3VVR3OXlWNFRNeVJWRkZwb0diTU1EMlJHNDd6NEdF?=
 =?utf-8?B?N3NhWG01VXNJSGFhL0FkVnh5cVFvV1FYeWxiZ0tITG03d2lhUUJxSitUMWoy?=
 =?utf-8?B?WnNrb2VhdW5OT29nSFBMQUxzREJtZmR0M0tOcnQra3BqbGo5cERNaDVJL2lP?=
 =?utf-8?B?blFsV1ZvL2JDMmdQRGNpRkxGLzh2NG1pSzVLc0g5OWU5VTdFKytYaU9TM0Ry?=
 =?utf-8?B?ZG92VVVQUGNESXdvWThtczQ4YnpEQ2JPT1hhLzM1OWlZSG1IVDFhNW4yeFNV?=
 =?utf-8?B?WDFVaGsvRXlndTlJUDlUdkU3b1RabVBKdTNZWXR0WGJEd1I2d2NWaUpEYXE0?=
 =?utf-8?B?S3RHRGNpZi9sZjhLNXFqdC9HZld2WW1kc2NkTDVCV095UWNzKzZSL0l6NWZ2?=
 =?utf-8?B?ZXJpZmloajBpZGt4a2FJRXhwSHIrV0czMFJJVjduNjd1S2tBanN1T1R1ckJU?=
 =?utf-8?B?bjZmeWpPZ2poNmZ0MFZyMmpkQTg2WDgrbklDVnJELzlxMU9kZEw1a2hlV3N6?=
 =?utf-8?B?VUdEa3ZuYmFhUGZSdHRlbndtdm9ZelJIRUUwYUJVRitsQjhNQ051OFJlMjlZ?=
 =?utf-8?B?QmpUYkxWTXRnYlVpRCtRakZPUnRkUGo1SUN3Y3ptNXAwQVdmWnA0ZjRrc01y?=
 =?utf-8?B?ZFBTMnpZQzVvV2dQK3p2Sy9RRnRCNEU5bHJLSUJNalVGTTRLLzNDZ0wzNEpr?=
 =?utf-8?B?djByUlAyZDZYbUpKWEl1Z2FRUFcyalQ0QU4vUjFaTlRmckdxZkpQR216WEYv?=
 =?utf-8?B?VjBtcFA0SjdxWmdHYno5Rm9IN1gwQlFYOWJsQ1FjN2IrSVhPQWlpU3BRSlBP?=
 =?utf-8?B?T3ArN05QSXdDRnBPYkZESGJMaGoxZVlSYkJJbWI3MmpHZFdiTllJL3c2N2Q0?=
 =?utf-8?B?U1lkcjAyV1RlUjlpUk5kUzluZHJkdzh2SkJKQmtlN05zckc3UGhSUkxLZVNH?=
 =?utf-8?B?NCtENmxkV0xSbUtBcTdaK25UVWp3NXhWYUhaVUlaM1daMEN3OWdISDd1cE9w?=
 =?utf-8?B?bzRmcDhjVnVrZ3BLR1hJdlFwMkRDaC9LYk8xa2kyMGJNL3M1dk55WGFXT2Y0?=
 =?utf-8?B?QVhTQ0RYYVdtRjAwTnBsRWo5eGFpa3NwOWIyUmtwTnNKOVltenNMMTBTcUNv?=
 =?utf-8?B?WmRsK0RBb2d3Ym91bUIycUdNUTM0ZzRLMEVkZnpKTlNCWTlpSFZiVlZJU3VJ?=
 =?utf-8?Q?r9HOn5H9H0dIM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFQ2VnlaU203UmN6YlE2NUU0MHhUODIyNHlzT2xsUmJxc01Bamltc3NPc2ZP?=
 =?utf-8?B?dllyV3FFOE1nYzNGQnExdjVWK1dqRjAzSXBZamdQMDd4QzlaTjZrcUttNU9F?=
 =?utf-8?B?M2UxVnVXV2pVYWprY0dKdHRWQlBOeCt1OWovTDM1T0w2TTJCWUh4eFdRTW9m?=
 =?utf-8?B?aWY2L2h4ZTBiSkViY29aTVYvMWQ3Z1A3cnIzQmY3THRyNEJtWFErSnZRM2Uy?=
 =?utf-8?B?aHJMTFR6TGtSNnY0a1RvVjhEMkJCWHh2WFpJK1YvaHp2dXFzUWxGaHAzTU1W?=
 =?utf-8?B?V1ppS1dtSjZvNVRCV0xJV3NyUFZMTVBhM2tzaGJMQ1VCaVd0MG1zUzJCVGtJ?=
 =?utf-8?B?WXFkK09WY21FaS9odDhtSlZzOUg5YURQWmgxU3plRTIrMG1qenJuU3FhWFZi?=
 =?utf-8?B?YlJQTTd6QXhoWmc1TEFuTkNpZXgvR3d5UUNmdzllSitaQVh5cEpXSUhmbDkv?=
 =?utf-8?B?NERhd1ArMU13S09wNWJ3bVRFZkczUERPSitVTmUwZlQ1UEw1WnloWnMzTVds?=
 =?utf-8?B?RjZvRE5icE5vY1o0b1haVGlSN0krd1FHUURHTTNIV3ZYbnJQTVp3SW5RdzJn?=
 =?utf-8?B?b2RRNFhzb2dCOEZkNXdkMEVnMDREbTFRbU1KcW1zdWlsQWN5SGdmbVJkZ2NP?=
 =?utf-8?B?ZGpnTVV1TmNwZlY4V0tOUzNpL2VQSVlrY0pIMHZZNlZFOHhpUGc2Uk1vTm9w?=
 =?utf-8?B?bmp5elFCUjdaN2ZHSzhaamRxOGw0L1VWMXlmYVhpbVh0YTRpV0xaeGg2ZHQ4?=
 =?utf-8?B?amZuQU9tZzQ3VDVKeG5OL2ZCSTNSVzZ1SXNHVE8zZzBJNG1zL3VoVVAzVnlj?=
 =?utf-8?B?Q0RiK3NOVVlwVUo0TDkvcHdpK2JJWW9DNTNCRzRsblNFZ2NBR1pkcXBTVTB3?=
 =?utf-8?B?T3g1YUgvK2d6dXp4cWZESlVleG9pZUtJbG81eDQ2elBJRHJpQlV5endtN3BO?=
 =?utf-8?B?djhlL04rT1hDL3AvdnZpWTdna0JxV0hJMUl6ZlRvYXJKRTNkK09Bc0NoamRt?=
 =?utf-8?B?VTlYR1VnVGRWVW1jSW4wR0pNdkFQMDJFMURSdXM4NUkzUnM1K2pwTjlQdUVN?=
 =?utf-8?B?UnRIcXNQZjRoNEVWMUtkVVdOaWVTYWVKL2g4Qi8wS3VBUkdpT2VEZ1hkMXlJ?=
 =?utf-8?B?dEZaVld5K2lvNHJ0U1E1R3ZpK2wvOCtCMVVsc0cvL1NJWFBxUEVNOHpnRzFC?=
 =?utf-8?B?R2tFZVhGZ3RJdFRIV2M5RCswMzdMVjRXQ253bWJpS3NtNXlEamVKUDgwb1JL?=
 =?utf-8?B?OFRuNDNBMGxOYStEZVRWaXlnbk04TTF6SHVYK2xkU2IvMlp2K0hnemtseDJM?=
 =?utf-8?B?ODdhYlZmbENVVjJTdzNrdDNwaDg4U2lDVVpxMU0xcFFSbkE0M0RiMWNyZWZ4?=
 =?utf-8?B?Qkc0ZEd6V1psRHVRZG9ibk9kTkhTb0tXM0YzV0dBc28xVkpDUUVzZ2NRS1pB?=
 =?utf-8?B?b28xSzJFa3NLaEl6dm1wV1J0Q2VyZXZCU3d2dnRjUGZNK3Q0U3orcndISzBz?=
 =?utf-8?B?TEs3N1J1dFJ3YnhkS1FBWUxsellRMjE1RHc4ZzVhTUw5NmlxUzQwQkdwbVpx?=
 =?utf-8?B?Z0lLNTY0cmF1aDdEMlVWRTBYRGhpU3dhS3NvSHpJNHdtM3FqMXNxYU1pVFFF?=
 =?utf-8?B?aVpiUkZWZ2YxT0U3MHF1dDlzUUgwa0pNQkFodzhZc2R0NExXTFlWc0pUUUlO?=
 =?utf-8?B?d0pkVXZEVk1aVmhId2o2Zm9tUUF2dGp5L0JzWUZ4bUJ0eWh1aDJ2ZTY4VFhD?=
 =?utf-8?B?aXZReGtUTUxqUjNGZW5JYWhFbTZIRjNKTTErS2RlMjJCMDNwSjE5TGtndWZl?=
 =?utf-8?B?NGZqd240NDZNNW0wZklRdGowVlJzQnp3VXFvdnNaMzdVSVpZd3JCcVdGcTlF?=
 =?utf-8?B?MGgxN0pKYVVHK3FmTXhoRUFlSDJzSElrQTNib0JZVDcycGFOcUVVVjJ2QitO?=
 =?utf-8?B?b0VtbVpEd1dsTStzNmN0dk4xSlhNQzArYUN6ZzNVclBzSENTcTQ0d1l4eDJo?=
 =?utf-8?B?SkhYNVcxTTA3cGlHTG8rWEFPcjVOTHlRNzdUdVo5TStzOTdyK01jTDhRSHlw?=
 =?utf-8?B?ak11Wk9Camd2NEZUazRqVllxZ0Zya3FIN0hndWszbUNyVXVDS25WdFBXcDVv?=
 =?utf-8?B?QzlDWGxZN0ZRbk5MNzVMVHJKaXlmd3VzVVlTa3R3RTBEZmVnUUpYMjFYOHRp?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f357c4f-13e9-402f-9316-08de229cc8de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:09:51.5003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UakwTtbxmoopLLIPEqZVRReqr3fcJiMNBkDE2P30Mv/DNTacuY2HLLONA2OxZZj8LPnyGew+uYfA605kZb7iGzHfu3YlK4gWAkZ8kVU0gr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187
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

Hi Köry,

On 11/13/25 10:33 AM, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> Fix two memory allocation bugs in label_boot_extension():
> 
> 1. When label->fdtdir is not set, overlay_dir was used without any
>     memory allocation.
> 
> 2. When label->fdtdir is set, the allocation size was incorrect,
>     using 'len' (just the fdtdir length) instead of 'dir_len' (which
>     includes the trailing slash and null terminator).
> 
> Resolve both issues by moving the memory allocation and string
> formatting outside the conditional block, resulting in clearer code
> flow and correct sizing in all cases.
> 
> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
