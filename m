Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D6C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 08:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9989D801F5;
	Tue, 21 Jan 2025 09:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="G4kEqY/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5800A80326; Tue, 21 Jan 2025 09:25:50 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C633800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb5ZyrpLWTOUMB4lzrjsZ0wkyr15I+1HLV6O9gmh9uXd6v9plhMVN2f+YQBFZzUxB8KqxSSU7nIeg6JRYU4MdnY7uhohw3SGMMF2x4JlHlmIPyFIks/SzgkkHQjG0P2z2gGo98xqUQiwtwkSRKdYZC19v/DyjM1NlwJk2HbUjcjU0VYDGVEm+1VCIbwgBapmkuGehjHQbqReRAU9TzY4gM3dA8P8t8HnpuXKAcaF5KgR4xceUzOYDMkxpPkrskpsOReR8tDvDGAI4y1KmdYOavF6FrWjguEuArUEZ2Y4q1WfzIm2HhHUXooD/h4XVjx/3AJVPKWoomxS6TOA8om8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv+dfKj118p22ksuj/RQcSIbtowtHDxCAo+zOpm6KDk=;
 b=VwzDM1hGJsNQqBdW8bucOL1V4pK04KWLuj7V4JzSL9XYYKZsUvh+sM4bW+SQZcfcFoZolyjBXC50ZMFmTCpB+g/o6Om6mCra2RVn2ZfHJc3DTrbv7sfCM1blL6O1P8RdjIVi7lgWHuNMGVkSzOIYQS8vU1Foxpj+zzFlII9M0Fm545tlramrgEZeSwbn2rTlzvU4AQmN2xykvsLn/zWrvd+u3hasAoozVZw6ON9n2ChlWJIgF8xnz5zmA8+j3qqXL9zXG+n5kUySlzDPyk2jOLk4XMW+KnPTsdvYGgFlM2F9BW6ikM8l99YP/OCJbJMyVAKoPoy6QDVbF07N/sP83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv+dfKj118p22ksuj/RQcSIbtowtHDxCAo+zOpm6KDk=;
 b=G4kEqY/iyNiFaT0+0t4Fqkj2zwI74LP54KB94njd69/cu1G05/zcKiHct42XY8pekciMrlHvH78Zd8AyUq1sny5ZLKvybU465hFRe2UIrOV1zbA7egzQZWt5H/tRCOEcvncsicmtEeycc2Kds0mncLnFiiuxU36/31AnNAQyiUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 08:25:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 08:25:34 +0000
Message-ID: <64da6cae-2d63-4c8e-99b3-d19870c0cbee@cherry.de>
Date: Tue, 21 Jan 2025 09:25:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] image: apply FDTOs on FDT image node without a
 load property
To: Marek Vasut <marex@denx.de>, Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250116-extlinux-relocate-dtb-when-dtbo-v2-1-d011582c2b7e@cherry.de>
 <709f0a6b-32d1-4e18-915a-dfb3f87fb9a6@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <709f0a6b-32d1-4e18-915a-dfb3f87fb9a6@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ef1c1a-5f47-4db6-c36a-08dd39f52ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEVKTGtPWHd0UzM4dEN0VUFKd3BkS2gyQmMycXA0ZjlwaHFuYi9pdzBKRmtI?=
 =?utf-8?B?aXVKZ2JjVzJiRGRMRWdNU1hITFJLVjhTS1RxS2M3aWF4MExKNnJ6VlJ3Z0hv?=
 =?utf-8?B?M0ZiQXk2Y0FoYm1JWDVtcGo0cjJEdFBIQyt5Vy9rUVU3eGdrWkpicHpHZHlL?=
 =?utf-8?B?VTdTK0liOGM4QUdOYmlwTjM3WGdaK3VZSXMwelZBY0ptcWNiK3cyME41elh2?=
 =?utf-8?B?K2tlRjRUOWN3QVc0Q2lxK3BxL0lrbTNxbW5OVkxaMmhFMDlJNm9VVC8vaTIz?=
 =?utf-8?B?OXB6eTVHNkMyZzIzb2Ywd3NlcEhQNWpFVnhmRHZKVG9VSGhoWk1CcGQ3M29G?=
 =?utf-8?B?MnpVSFJVd2pycE5JL1U3Sk9zU0tHaDU1MmhvVXE5TUxMcit4RTJGS3VVRnFF?=
 =?utf-8?B?c1lIc1ZJUnpBdUJJWWFZbys1QkFTUFNxVDgwOUtHa1JqOVVIT1ZkaVpQK3Rk?=
 =?utf-8?B?V1FCNEFNVm9Dd1ZiVDJDaDMzbW94L1B1V0poQ3FGNWYzQXJDcjk5V0pwRExP?=
 =?utf-8?B?RlZ2MVl3bmovMlpvOXE5WnVicVgwUTU1R2JjUUt3cWpadThIQktWS3ZvdFZG?=
 =?utf-8?B?RnE0c3h6dVI3NWNRcVdqaWlHbTU1WmZSSlFGS1BJZWphT2J6aWxsZ3lGL2Ex?=
 =?utf-8?B?RXIzQXBJYTg1ZFpqaXU1VkgrMGRpNXkxRjh1SldkODJRVEE5MGNUUWhmUHcy?=
 =?utf-8?B?eU93V1NwVmNFVVJRV3V2NFQ4RXRVVkNRMlB5RzFFQkpHY1JTaWFIL1pLb21G?=
 =?utf-8?B?RlNFR0VGUC9Ob0JveUNlOERFVWIyV21GOGNHZDdDYnhmdkxmSUVYaTcwNU1H?=
 =?utf-8?B?RFYrdGxjOU1ncVphaUFXR3lNbFdDM01kM3dKd3g1QWpXNHNmT3duOXN0bUtV?=
 =?utf-8?B?M09xaTdKZzUvUkhVbW94WXhrYjQybjlGTWc1N1NNUGF1NDJGWWY5OHBPOExD?=
 =?utf-8?B?a2JLd2xrK0hWeFg4Z2g4VzRscnN0UFFESjJkV3N6bXN5RUZYU2VMMjd4ZFRu?=
 =?utf-8?B?WXA3Z2VSQWYrS0VFYkNvQlF2YTJvRlVqM2l5aUVidDdWNE9rTWNEUVVySURI?=
 =?utf-8?B?T3FCZjRkR0ZJVElMSWFYbG0zMktkT21WWlZTdDJ3L0hnSjZLcHR2TWtCc1ps?=
 =?utf-8?B?MDRucFIwWEgxTzQ5SEc0ZHVHM216bWoralUwdUVUUzVCZ3oxN2p6Snd3dENH?=
 =?utf-8?B?b0MrMThBL2dWL1Z6cDJKRkY4TmRGQmpLNG81WVFYVFQ5ZlpBMmRmZitjNURq?=
 =?utf-8?B?eURuMDYzUXE3WnBoZWNibTJ0WjN4b2pyWDZ0aHBVTk9tV3FZZmNDRFdFR1NV?=
 =?utf-8?B?aXdxWmFZcTRtYStoaEZqU2RWcmN3SDM0anpxQklML0ErUXJQQ2R3TXJPTjNE?=
 =?utf-8?B?bFM2Q0pMWEc5S04yVFBxWDE5c0hvR2xJOWNDZlE3eXhCWUMrcmVUR21VWmh1?=
 =?utf-8?B?WjZISFVPNHBiZXNyQmlYbGpsWmJiT3M1czBIN1hpZEJkMDZBNVEzUjBYOHZu?=
 =?utf-8?B?eVRMSG9jZ09nT2ZqOGgyQThXN0ppL1BBWlhQOTVKMTY5aFkrNnhpS2k1cW1K?=
 =?utf-8?B?bnRHZm5yckVUejlnQUFjYW5EK0xER2EyMGxkMWVOR25TaWFZWTVSWXc0amQv?=
 =?utf-8?B?ZW1EcWh4alByVE1ENkZpbmM5K2o1V1R0cDl0d29kWVk3TVJGS0Ezb3hRVGtO?=
 =?utf-8?B?Vm5YcmFKNnhkT2RSZWI3U21pVmtqUmE4dUlXd3ZWZVdsZm1XVVF1Q0cwRkww?=
 =?utf-8?B?TVpKc29NaURsajA5ZVV3TUh2RXo5Q3B0QXVGcDlBU29rZHF5R0F6VXFCNEhD?=
 =?utf-8?B?anZldFg4eDNtaGQxbXcwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VxWHJtMlNjSDg5emFZUGF5TjlKQ3dsbzZaSjhSbXlGUnUvL0tJQWJCSG5S?=
 =?utf-8?B?TXYzcmd4UVNwT3NuNjdiK1RaSisxRitKbE10M0E5RExzdVdrblVWVE5KbWM0?=
 =?utf-8?B?c2RBc25LVEFuVHZUUG43VDVFc3g3cjM4R1JYVkxPWFR5cFdHRy9vVjQzZlA3?=
 =?utf-8?B?RW41YmEzVlU2Y0JKNVVJY2NiWE1lQjg2QiswMHhzYmZxZmkyd2RGT0lhZFRG?=
 =?utf-8?B?Mml0NUcxODg3UVB4dmhETW1Ra0xLYTRlam5hNlh3OXFSNlY3bGl1a0hXb0lZ?=
 =?utf-8?B?Mk9ZR2JZdy95UUlFcEo4TEpPTkZsUW1qV04yS0ZKMmVvRm1venQvUnh6OFhL?=
 =?utf-8?B?dHFSSHJkZmRSdDVYWmhoeWYvV0szNGorMG9BVTBwWGpjQmEveDNSaHQrS2lZ?=
 =?utf-8?B?MjVpOW1hSVk3VjRPL1pHTE9qMGtHa0FLWnV2RE02Zjk3dDJmMWtwNzNYeC9k?=
 =?utf-8?B?WXlwWklNa1puNUF6a0hacStNWXlvWDRndW1tRU95V0FoV0Nkbkxoc0Y5SWlV?=
 =?utf-8?B?dFZmamtReWJPVmtING56aS9vaUF4UzArRS9nYnNCSDBLYml1aDNIQ3FtWDQx?=
 =?utf-8?B?TWRoaUpNbjBBNG0xYTFyeWJBZEU4aVRjWDRYMzdQUHVWQmpBa3k4Z25iNXhP?=
 =?utf-8?B?VTE2eFB5N3M3OGxpY2FSRW5FOTZ1QWFycnMxeWV1SWdnYVBVaHYzV2l3MExK?=
 =?utf-8?B?YXlOY2EvQUN2S0xGNVpabks5VVFsM1g2cW10UDAvT2RzY2VPRy9tN21XbldF?=
 =?utf-8?B?UkladlZaOFArWmh2Zm5jZW16YXJUMlY5a1cvM0l3UVdicDN0Z2MyQ21JdnM0?=
 =?utf-8?B?SEZaUHdjQ01GeFZleENEdStEV1dXNURTaittejdCME1TeEwwMjY0QkJ6OXY2?=
 =?utf-8?B?cXpIaVNEUTFodFlkSFgvZUw0REY3TFNyWmNtUFBEbXkrUThKWmxRalRGMmtM?=
 =?utf-8?B?a3RMVWF5UWlaYWpNcW9Tam9CbW0xQWVrVkJOWWdPTGVSL0lJbUVQRWxXQ29Q?=
 =?utf-8?B?RXFNa2dKYXJMREd5K09adjQyNW5ENjM4blJCTitFclB6TGNkNGFINUl0S0xZ?=
 =?utf-8?B?a0NXK0RzMXZOVjFNODVPWUpGdGtzTktRSExLSDd2Y0w4QzZGLzZYL21GWVRx?=
 =?utf-8?B?WGlhZFRBR3RRZlhYSTJXVmpTaFYvdHFOWlJpUVZwZUlsay9HSU9BZ0IyRGZC?=
 =?utf-8?B?bzdBZWYrNDc0K3pDM0tBUDh2d0tUTjRxQ3Q1VzU0V1BtOHR4TWRlSllTYWJo?=
 =?utf-8?B?N0VxdHE2ZktVNFprcTFvdHk4ak5HWlZhNHZXZXYrV0JlSG9EWEJkYkxqczl1?=
 =?utf-8?B?SU9JVVF5c1hwTnh1NTdMZE90aGJVZDQvdDloaUFIeGg0Z0V2WGN5Y2ZaNHVU?=
 =?utf-8?B?NktoV1liVEhId25BVWRHUnQ2TVkyajd3V1g0dFlKOCsveFFCN08yenJXelFB?=
 =?utf-8?B?WkJwWGY3MFRVRi9PTlVwSUcwME55TXFoN2lyaDBwMHl3bEFJdlgwdnRRSzhE?=
 =?utf-8?B?OGJhOXlVdzZXTXFrak5pYzhMYjJNa2N4UmZHTURreTMzYjNPK2EweTdLN28r?=
 =?utf-8?B?bnNVUzY0dTVXN1lLRkdnKzZUQW5mMUZYMTQzQkhtd21CcXJVMU5TZWEwNWxW?=
 =?utf-8?B?emRZcVpPeEVxSzIyZU1aSUllTkF1OURtS2w3OGlIMXlMT2g2Mm5LNmkwQ0xQ?=
 =?utf-8?B?Vkl6cUVhL1FIR1RyclVmMW1iUDdFTG1HaGR2eXhhdFhBNkUxMnN6c3pFWlNW?=
 =?utf-8?B?dmNMUE5GYm1lWDVFeWx6SVJFMmU1Znh3cWJhQllZcUJKRnE2ZUJCOHIrTURk?=
 =?utf-8?B?WWxwdVV1Mmh0T1ptaFJ0ZkJ6TElGNnZhenIzWjZwNXdteFp3ajJOemNjWHpu?=
 =?utf-8?B?WnM5eStHSm16bDhFNG14azlwYXM3ZC9QYU0vS2VNU2IwRndudmh2Tkw1bzJR?=
 =?utf-8?B?T2tkTTQzNnlEY0U3U3lFTEY0OXpYaXdiUWZKYmRPV2lsVEFONHBpdnorRHdo?=
 =?utf-8?B?V243aWlLTVFwdGpLRnZMbWFJSGhQeWpZVlhUbERCcjdmcG5DSndOZU9Ib0pV?=
 =?utf-8?B?aFgxVGNPcnpQc21lNCs1TnRUS2RwVllheUZvVzVmNG5kSWYzWXpkWVJadzc3?=
 =?utf-8?B?RGVGekxCcWhkbHNRQjFSZU1BNDhlYXYzZTJxcEM0VXpidjE0V2tpMmNVSk1y?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ef1c1a-5f47-4db6-c36a-08dd39f52ce0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 08:25:34.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYf6CI0UMQ08Bj2MrL0Kac2PD1VeQcD88unWeTUcAxw8SwqGCZSCEd2Oq03kY1MAABEQ2vPv9jANYcRxIQAe3aOy7cXrw1PwYiLKn11TKok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8781
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

Hi Marek,

On 1/21/25 12:55 AM, Marek Vasut wrote:
> On 1/16/25 12:46 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> A FIT image which is NOT using -E when created by mkimage - that is with
>> image data within the FIT - will fail to apply FDTO if the base FDT
>> image node does not specify a load property (which points to an address
>> in DRAM). This is because we check that the FDT address we want to apply
>> overlay to (i.e. modify and likely increase in size) is not inside the
>> FIT and give up otherwise. This is assumed necessary because we may then
>> overwrite other data when applying in-place.
>>
>> However, we can do better than giving up: relocating the FDT in another
>> place in DRAM where it's safe to increase its size and apply FDTOs.
>>
>> While at it, do not discriminate anymore on whether the data is within
>> the FIT data address space - that is FIT images created with mkimage -E
>> - as that still may be susceptible to unintended data overwrites as
>> mkimage -E simply concatenates all blobs after the FIT. If the FDT blob
>> isn't the last, it'll result in overwriting later blobs when resizing.
>>
>> The side effect is that the load property in the FIT is only
>> temporarily used to load the FDT but then relocated right before we
>> start applying overlays.
>>
>> Suggested-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> This actually forces the base FDT to always be relocated whenever FDTO
>> are expected to be applied, regardless of the presence of the load
>> property in the base FDT image node.
>>
>> Tested with extlinux with:
>> - conf node with multiple fdt entries (scenario A)
>> - conf node with base fdt + conf node with fdto (stored in fdt property)
>>    (scenario B)
>> - conf node with multiple fdt entries with base fdt with load property
>>    (scenario C)
>> - conf node with base fdt + conf node with fdto (stored in fdt property)
>>    with base fdt with load property (scenario D)
>>
>> """fit.its
>> /dts-v1/;
>>
>> / {
>>     description = "Kernel fitImage for Jaguar";
>>     #address-cells = <1>;
>>
>>     images {
>>         kernel-1 {
>>             description = "Linux kernel";
>>             data = /incbin/("arch/arm64/boot/Image.gz");
>>             type = "kernel";
>>             arch = "arm64";
>>             os = "linux";
>>             compression = "gzip";
>>             load = <0x06000000>;
>>             entry = <0x06000000>;
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>         fdt-rk3588-jaguar.dtb {
>>             description = "Flattened Device Tree blob";
>>             data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588- 
>> jaguar.dtb");
>>             type = "flat_dt";
>>             arch = "arm64";
>>             compression = "none";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>         fdt-rk3588-jaguar.dtb-load {
>>             description = "Flattened Device Tree blob";
>>             data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588- 
>> jaguar.dtb");
>>             type = "flat_dt";
>>             arch = "arm64";
>>             compression = "none";
>>             load = <0x12000000>;
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>         fdt-rk3588-jaguar-pre-ict-tester.dtbo {
>>             description = "Flattened Device Tree blob";
>>             data = /incbin/("arch/arm64/boot/dts/rockchip/rk3588- 
>> jaguar-pre-ict-tester.dtbo");
>>             type = "flat_dt";
>>             arch = "arm64";
>>             compression = "none";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>     };
>>
>>     configurations {
>>         default = "conf-rk3588-jaguar.dtb";
>>         conf-rk3588-jaguar.dtb {
>>             description = "1 Linux kernel, FDT blob";
>>             kernel = "kernel-1";
>>             fdt = "fdt-rk3588-jaguar.dtb";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>
>>         conf-rk3588-jaguar.dtb-and-dtbo {
>>             description = "1 Linux kernel, FDT blob";
>>             kernel = "kernel-1";
>>             fdt = "fdt-rk3588-jaguar.dtb", "fdt-rk3588-jaguar-pre-ict- 
>> tester.dtbo";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>
>>         conf-rk3588-jaguar.dtb-load {
>>             description = "1 Linux kernel, FDT blob";
>>             kernel = "kernel-1";
>>             fdt = "fdt-rk3588-jaguar.dtb-load";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>
>>         conf-rk3588-jaguar.dtb-load-and-dtbo {
>>             description = "1 Linux kernel, FDT blob";
>>             kernel = "kernel-1";
>>             fdt = "fdt-rk3588-jaguar.dtb-load", "fdt-rk3588-jaguar- 
>> pre-ict-tester.dtbo";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>
>>         conf-rk3588-jaguar-pre-ict-tester.dtbo {
>>             description = "0 FDT blob";
>>
>>             fdt = "fdt-rk3588-jaguar-pre-ict-tester.dtbo";
>>
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>     };
>> };
>> """
>>
>> """extlinux.conf (scenario A)
>> LABEL rk3588-jaguar
>> LINUX /boot/fit#conf-rk3588-jaguar.dtb-and-dtbo
>> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
>> """
>>
>> Log:
>> """
>>
>>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'kernel-1' kernel subimage
>>       Description:  Linux kernel
>>       Type:         Kernel Image
>>       Compression:  gzip compressed
>>       Data Start:   0x020000cc
>>       Data Size:    11862415 Bytes = 11.3 MiB
>>       Architecture: AArch64
>>       OS:           Linux
>>       Load Address: 0x06000000
>>       Entry Point:  0x06000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>>     Verifying Hash Integrity ... sha256+ OK
>>
>>     Using 'conf-rk3588-jaguar.dtb-and-dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02b50370
>>       Data Size:    168750 Bytes = 164.8 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> 96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>>     Verifying Hash Integrity ... sha256+ OK
>>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
>> Working FDT set to ece9d000
>>
>>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02ba2bb4
>>       Data Size:    2753 Bytes = 2.7 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>>     Verifying Hash Integrity ... sha256+ OK
>>     Booting using the fdt blob at 0xece9d000
>> Working FDT set to ece9d000
>>     Uncompressing Kernel Image to 6000000
>>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
>> Working FDT set to ece70000
>> """
>>
>> """extlinux.conf (scenario B)
>> LABEL rk3588-jaguar
>> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load-and-dtbo
>> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
>> """
>>
>> Log:
>> """
>>
>>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'kernel-1' kernel subimage
>>       Description:  Linux kernel
>>       Type:         Kernel Image
>>       Compression:  gzip compressed
>>       Data Start:   0x020000cc
>>       Data Size:    11862415 Bytes = 11.3 MiB
>>       Architecture: AArch64
>>       OS:           Linux
>>       Load Address: 0x06000000
>>       Entry Point:  0x06000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>>     Verifying Hash Integrity ... sha256+ OK
>>
>>     Using 'conf-rk3588-jaguar.dtb-load-and-dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02b79784
>>       Data Size:    168750 Bytes = 164.8 KiB
>>       Architecture: AArch64
>>       Load Address: 0x12000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>>     Verifying Hash Integrity ... sha256+ OK
>>     Loading fdt from 0x02b79784 to 0x12000000
>>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
>> Working FDT set to ece9d000
>>
>>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02ba2bb4
>>       Data Size:    2753 Bytes = 2.7 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>>     Verifying Hash Integrity ... sha256+ OK
>>     Booting using the fdt blob at 0xece9d000
>> Working FDT set to ece9d000
>>     Uncompressing Kernel Image to 6000000
>>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
>> Working FDT set to ece70000
>> """
>>
>> """extlinux.conf (scenario C)
>> LABEL rk3588-jaguar
>> LINUX /boot/fit#conf-rk3588-jaguar.dtb#conf-rk3588-jaguar-pre-ict- 
>> tester.dtbo
>> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
>> """
>>
>> Log:
>> """
>>
>>     Using 'conf-rk3588-jaguar.dtb' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'kernel-1' kernel subimage
>>       Description:  Linux kernel
>>       Type:         Kernel Image
>>       Compression:  gzip compressed
>>       Data Start:   0x020000cc
>>       Data Size:    11862415 Bytes = 11.3 MiB
>>       Architecture: AArch64
>>       OS:           Linux
>>       Load Address: 0x06000000
>>       Entry Point:  0x06000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>>     Verifying Hash Integrity ... sha256+ OK
>>
>>     Using 'conf-rk3588-jaguar.dtb' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar.dtb' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02b50370
>>       Data Size:    168750 Bytes = 164.8 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> 96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>>     Verifying Hash Integrity ... sha256+ OK
>>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
>> Working FDT set to ece9d000
>>
>>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02ba2bb4
>>       Data Size:    2753 Bytes = 2.7 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>>     Verifying Hash Integrity ... sha256+ OK
>>     Booting using the fdt blob at 0xece9d000
>> Working FDT set to ece9d000
>>     Uncompressing Kernel Image to 6000000
>>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
>> Working FDT set to ece70000
>> """
>>
>> """extlinux.conf (scenario D)
>> LABEL rk3588-jaguar
>> LINUX /boot/fit#conf-rk3588-jaguar.dtb-load#conf-rk3588-jaguar-pre- 
>> ict-tester.dtbo
>> APPEND root=PARTLABEL=debos-rootfs rw rootwait net.ifnames=0
>> """
>>
>> Log:
>> """
>>
>>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'kernel-1' kernel subimage
>>       Description:  Linux kernel
>>       Type:         Kernel Image
>>       Compression:  gzip compressed
>>       Data Start:   0x020000cc
>>       Data Size:    11862415 Bytes = 11.3 MiB
>>       Architecture: AArch64
>>       OS:           Linux
>>       Load Address: 0x06000000
>>       Entry Point:  0x06000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 51a2b828aec49d9ede09a2de2cd05226def258dedcc8e4c4098fa2ba38fb9690
>>     Verifying Hash Integrity ... sha256+ OK
>>
>>     Using 'conf-rk3588-jaguar.dtb-load' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar.dtb-load' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02b79784
>>       Data Size:    168750 Bytes = 164.8 KiB
>>       Architecture: AArch64
>>       Load Address: 0x12000000
>>       Hash algo:    sha256
>>       Hash value:   
>> 96213ce3930a5f926b27c90671ca779fc327e2e62c2135f7ed7d8b6dd659b973
>>     Verifying Hash Integrity ... sha256+ OK
>>     Loading fdt from 0x02b79784 to 0x12000000
>>     Loading Device Tree to 00000000ece9d000, end 00000000ecec9fff ... OK
>> Working FDT set to ece9d000
>>
>>     Using 'conf-rk3588-jaguar-pre-ict-tester.dtbo' configuration
>>     Verifying Hash Integrity ... OK
>>     Trying 'fdt-rk3588-jaguar-pre-ict-tester.dtbo' fdt subimage
>>       Description:  Flattened Device Tree blob
>>       Type:         Flat Device Tree
>>       Compression:  uncompressed
>>       Data Start:   0x02ba2bb4
>>       Data Size:    2753 Bytes = 2.7 KiB
>>       Architecture: AArch64
>>       Hash algo:    sha256
>>       Hash value:   
>> e5eb1fe225d03b04e9bb27c04fe3278f294b48c6ab6757292c9650f6d3ce9f34
>>     Verifying Hash Integrity ... sha256+ OK
>>     Booting using the fdt blob at 0xece9d000
>> Working FDT set to ece9d000
>>     Uncompressing Kernel Image to 6000000
>>     Loading Device Tree to 00000000ece70000, end 00000000ece9c62d ... OK
>> Working FDT set to ece70000
>> """
>>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> ---
>> Changes in v2:
>> - Indiscriminately relocate, regardless of location of FDT to be on the
>>    safe side wrt data overlap/overwrite,
>> - print return value of boot_relocate_fdt when it fails,
>> - Link to v1: https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F20241219-extlinux-relocate- 
>> dtb-when-dtbo-v1-1- 
>> fe5eeb8fd4f1%40cherry.de&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cddabd8c9406e494742e008dd39af7af3%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638730148066938337%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=v44rSH1FkKZuW3vR%2FZjsRDMlzAEnDXtTwwJpg46Unrk%3D&reserved=0
>> ---
>>   boot/image-fit.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 
>> db7fb61bca948e42a4136b9ceb263a53362ad3f8..f3df8e2393559596f5100ea54a7ede77407713ac 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2348,10 +2348,10 @@ int boot_get_fdt_fit(struct bootm_headers 
>> *images, ulong addr,
>>       char *next_config = NULL;
>>       ulong load, len;
>>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
>> -    ulong image_start, image_end;
>>       ulong ovload, ovlen, ovcopylen;
>>       const char *uconfig;
>>       const char *uname;
>> +    char *of_flat_tree;
> 
> Can this be void * instead ?
> 

The compiler seems happy with that. FWIW, map_sysmem() returns a void*, 
and boot_relocate_fdt() expects a char** and we anyway cast it to a 
ulong later.

The question I have is why? What does this bring? Maybe there's 
something I can learn here :)

Cheers,
Quentin
