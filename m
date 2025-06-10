Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DACC678DA
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 13:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903308070C;
	Tue, 10 Jun 2025 15:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aVn5SjLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5AD82B07; Tue, 10 Jun 2025 15:12:18 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BCC8007D
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 15:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAkkp37sAd22W5Fyx+XCbSphzUHl99qq5otDPhfzqwhXuzyDp/tZKY5FHc/etalmt7tlfpWK10CyMQlUPFazCHOLAE9UDY0SETJZTXnKaonFsPfqvNQPQBEI02rzFbbI30VQsqAMBQzp0UHhKS7mCGwVTQrSffCvGhu5pzn4tFUikGs2bC3z+UriuW+IPcCMoNzxnd6UvPVzxH0nrRPrKfSsBywu/oza3A3Zs9mmWJcYltPyNxyRS0rb23cpAvt95693pEHpGUopzvbZx7fA+i2DCf9hQAy9svZ/ezCIVdlxu++tF38NqGrm/lmbWxd97/jCAquZlFMaD5Ih/2ndlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IipIVWXmLiwmGcno77TEvJaPOPy0nLDbm7SAdVkRJwY=;
 b=XhrSwR7J7yMD5mjwmEdBKVHdbRx2beK4W7SaeoWUzCzQXV5bI5bqpBrdkz5HzWJk1RHhe7ExsjrLvTiZYpET/CIKDH1Mc4u6aEdUg7bYfWeY2J+lOoOha5sqd4Gmtce+AMbECW6Gnn52aruxyBJy3Swe2EONf5hVdHrD27IU9I6TFv4hntVMk9/tklSBVhOD8mnVZL6bAZIN4m9TUu2ZvH8xQyACniu25SL3/onbdgBTjkxgVYcY5nei1UXFQxpwyjUIWWWuLet9CHT3gMOb44emPnyXu3vbwWX2r4Opx7+MWoV++rCdZFWBDru+y7qO7DMUAcEU3FGaWtcSTH15WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IipIVWXmLiwmGcno77TEvJaPOPy0nLDbm7SAdVkRJwY=;
 b=aVn5SjLTb1Xkz+INfELx5f2RlOe+4wAaKzMx2hNTUwZUDOLzkMPlYyZvk3srh0kPqHa91rwOblEnI+f13qKILIHVVV0ZB/VSWom4ng+BhNDHO3NgeyosYJwQ0fvmBh+TlAjkxfbIe0KkTIH1lTwz3s0YWUucwRDKTG6GCVTopHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU7PR04MB11233.eurprd04.prod.outlook.com (2603:10a6:10:5b2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 13:12:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 13:12:10 +0000
Message-ID: <04f3a57e-6a73-4409-9820-e0d1c7ba998e@cherry.de>
Date: Tue, 10 Jun 2025 15:12:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
 <7240ff54-a730-4f86-9ed2-8ca242ab8388@cherry.de>
 <5f843f23-77fe-441e-80f7-28ad10431f68@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5f843f23-77fe-441e-80f7-28ad10431f68@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CP7P275CA0009.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:42::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU7PR04MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b77a93c-f431-4acd-f6e2-08dda820683e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzNrL3REZ1d6NTRnQVhkd2g2NUZFcXVaRmtrZUJKMTkwVVdpNTd4bWJ2ZjVV?=
 =?utf-8?B?UUlNTmFaOVV3VnAzNjMvNWtzVGY0djJMeWF1UVN0K25wZmoxUFQxRXlSTWpq?=
 =?utf-8?B?VGFCN2R5MmExNVEzNnNBMjlrMVNUSHV3UTlhVkVXR2MrNVRKWGpQdmt0dlBm?=
 =?utf-8?B?dkJkaEZ2Si8zYVFYS0tJUm1jRDZNMTg1TW1jMTI2M2Z4RVJlVi9YTXB5OUpi?=
 =?utf-8?B?ZFA3K0U1M2pJczRkdk9tcTNzOEdmdFNGNjFySzlBQVJwczArSVBSNnFoOWxI?=
 =?utf-8?B?ODYrT040aUsxSTNJUEE1U2lMUmx4VUIxWkNmbjkzQTJQblYxUElrYnRkWC9C?=
 =?utf-8?B?anF3MGhuT1IzS1duUHRsWHg1aGk0NlorZXlWblU2RGNIZnpseS9JazBDOWJZ?=
 =?utf-8?B?c2RjL0dRc0pSU3dtakhDcnVjTEdHa09HR2ZGZURxQVRHdlFyaHlIYWN6dkQw?=
 =?utf-8?B?cVA2QmlnWU9TTFc3MVZzSjNCTlVjSkQzVm56UHRVbEhFc1V1eGVGRXVTZTd6?=
 =?utf-8?B?R2xDS0RZUER6dk0xSFZYVXVYK3YweDc1RGdVN0Q5cUFlem1COHJhTHF0MG8y?=
 =?utf-8?B?MWpXQXNOVWpzVEFXcjVuNFVLMmxHT0VHekQrdEtIeFJKU1RjREx0MCtNM0k2?=
 =?utf-8?B?S0ZBcFgyS2ZXVmVYVGpBS2tqVXJ5eDdjc0syYmw2MkswTVErYWp4Z2hiMmM3?=
 =?utf-8?B?Z0tjejhkS3RPdUhTTWxzNTdqbUhaUXlDaU1Pc0tBNitKdndxcEtGdVJKUlBo?=
 =?utf-8?B?Mm5meVZON3E4alBmNDNvNmcvNUtjd2ZlREZ1RzIxRDVXZVhGNG5VdlcrUERk?=
 =?utf-8?B?b3ZVQy92dldGRWJPM0toVnVoakVxSUU5UTh2Yi9nTmZtYUZuMHV0VjlBVFBG?=
 =?utf-8?B?VHFGZXZoM1NWanFZeXc4anpDaFdJU1phekNBN2VKKy9tdlVFazJEUFNES0Jh?=
 =?utf-8?B?NnlJNHoyTE84OHMreTBzSWlJTWhIWGZjc1FKcFEwbEMrTkxKODFyNjQrYkJm?=
 =?utf-8?B?RlFTaUc3SGd0cGo0SUYyUnlCZXJNaWVwL3REWFFGSG1kWG9WY213Y21UVmV2?=
 =?utf-8?B?b09tRFpTQ0hBSVRKTTQ5RmVVaWYyL0tjczA5WDlXK1NMZ3lGMk1KYWt1dk5W?=
 =?utf-8?B?VWVUaERiMy8rejFiZHpZWUJ6THd3RXNidDdVWmVVcFdaZlJ3cDI1MjJuWE1S?=
 =?utf-8?B?d2FycllWV1FQSmtsNmE4UlAyKzZkeTdHUFEvZUs5Y05vRkRMOHRlVU9zeThp?=
 =?utf-8?B?S3JMTGdTdEV4Q0lUR0hFNjIzRFkya0JWU0hkQ0YxNEN0aDhnMTZINCtKRStB?=
 =?utf-8?B?eGdZWDRsR2NqYTU5SkxiSFg1eEdzdkRDQzR0K3h0OVJ2TGpLRWJZY0U0RzE3?=
 =?utf-8?B?YU1nTjNFdk5DL3FoYUZqb3IzZ0JRWkdoMHZvaVF4OVB1TEVSa25ia3RVb3Vp?=
 =?utf-8?B?YjlrQk1MbWVzeTE1dlE2b0NHR3RVNzZIR3dRVVc0QmxZZ1ZWQnAxMCs1TWRL?=
 =?utf-8?B?SW1OdTh2bzJQZm9ldmNoVm9iVlF6QUpKT3k4VkpFOUM2N05RbVN3aUNZbHBj?=
 =?utf-8?B?N0dLU2l2UXFSeDY4bTFVWllZNm9vejZOdE1KNVI1MENOM25XUnlXSkVlRHJM?=
 =?utf-8?B?bFlIeWxhWWM2VVJRK2tNdHFnN0gvTmp3M0dpQlpsbGJpVXQ0clBTbXJBVk9R?=
 =?utf-8?B?RXdqODlyZVF2c3cvUjZOaGlpczljcnIyS3F1ZVhBSCs2dUZhbys0TURudjJZ?=
 =?utf-8?B?cG9kcmVDZlBwc3phUjhUSzR0UlZZREZEUEFvU1llQUlhenVsUjNLbU9hZmdE?=
 =?utf-8?Q?5OGcvjSYpcFJcKgecyNfRtERV7rOpPSZrFkuc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJqM2NlOUhuQ0tObG9JRUNpdHRtbEZlZ1FrcUhxWjlKRHBjY2RNaXdHaSts?=
 =?utf-8?B?VEI3MGZBTkNWZ0E0RGVRc3l0WWZ1MHJNTytXN2Fyc0pld0VFK0xyWEY4MkM0?=
 =?utf-8?B?NGxrR1QwRllQc293b2k5aTRQZVdrRjhBR3BzQzBYL0tQS00vNEo4ZVUzejBE?=
 =?utf-8?B?SmcybDNtc2ZTam0zbkllMGZuS2dxRysxYlBLMUtveW1OWk5aUG1iYThoUGJV?=
 =?utf-8?B?bDVVSDdPWlhqdkxmSmhYeGhXN1hsSkFmS204bk14a0FYSGQ4K0M5WWdKVDdE?=
 =?utf-8?B?V3FHdnp1NFZXaGd2Tk1qWDM1cTFSL2hWUTFQTlJacTk5MlpWK0J2Wm1yYjA3?=
 =?utf-8?B?WGdOVXlPQkRpSS9XeGIzeWNieS9qZGJBSHlzcFR2cHA5V1ZVcloyYXNmak12?=
 =?utf-8?B?aWhXU25BVUt1UmtwbTdBVExoR2FYVzJtMEFZeXNkcGpGeHdzdmZweHRPNEVR?=
 =?utf-8?B?bmJvZko0MkZ6ajNkblh1K25OUmE3M0dQL1dzVkQ4M1ZaNDFvVlN1eUJEWHh4?=
 =?utf-8?B?R21ITjNmVzl4TU5Fbmx6MDU5WFNQdVJWSVY2MmZQODJVaE5yeENiOGZFcUli?=
 =?utf-8?B?OHM0SzV3WHEwRnpobDRtZUVVQWVoVytVbXlhMXpvWklyZU0ydUJHSTlPT0tC?=
 =?utf-8?B?aXAzSU5NVWxTMTRZQXJOcVpUelNtYS9HZ1V1d09SN0Jaczd3YTVjd1R1Z2sw?=
 =?utf-8?B?cGlIalFaY1NocytPOUZXalZ6cVpZTTdJZENCK0pPZElGUDFPeThMWHA5OUR3?=
 =?utf-8?B?ZjMycmdpTElHOWtpNHFHU3ppK241Ulp2OFpLcE9GcmhMR2hDdG5XOU1GcEE4?=
 =?utf-8?B?TW9KRTNheTJRZ1J5WDlmTXdPemR0MCtNZzlEUTJxZi9iSHZpU2QvU2ZrdE12?=
 =?utf-8?B?SHptd1J1bFJxQ1M5T3FsejRxUENzdGl0OW1ORVpHWUFwUEZROXJrUjcwdDdz?=
 =?utf-8?B?WXNNc0hUcmZnOGtpc0hrOVVndTJwSnBCZDJqUEUvMGlUemx0eHJzaWQ4YXE0?=
 =?utf-8?B?TG12NzBiTml6K3BYbzdwazdMSXNucWZrZk1ZaXY0OTduWTYxMzV1Q1NmVFBm?=
 =?utf-8?B?TmhFMllPZ1FwaWd0ZlpWQWpjcjdSRTJZNFcwNDV1ck9KTnc2NTh1Yk1RRkgx?=
 =?utf-8?B?SXNRa01kUTIxT0RQVnlZRDRyVytxcGVxbmMrVll0Wm0wRHh2QSs5dnVPTVBR?=
 =?utf-8?B?dlpiN2tpR29OZG9yVWZORlBVVDZSYjFsaGkvdGN5Uzh4eDkvNkZVT2JzV3cz?=
 =?utf-8?B?SUVsbk0xcWQzSURRKzhHSVloeGc0SC9JMHEzZmlwVDdpT2V6ZVJUNjdBT3dz?=
 =?utf-8?B?UEhIUi9nbFU3Qzg3UVR3OWV4akhZNk5HOGRjL0EwQ2pWcm5hTWp2R1Y5K0du?=
 =?utf-8?B?YUVmRjRPcytwcjhnUmJ0NzVvaFF6S1dPV0RGMjh2ZFJHSmlrVUV3SElickRM?=
 =?utf-8?B?b1k0eVNWOTJjZ054dkdKbFh6K3BSZU9zY2c4ODlGVWpxMkpMQU1LTFoxRUZv?=
 =?utf-8?B?REd5bXQ2Y2d4Um5kRFZwYmRmb1NMc0Y5ZEZVQys4dUp2dUJRRldKcDZVVXRy?=
 =?utf-8?B?TWcxNEZzSlNJTEwvMVBWeHc0bDR4SWVrczk5dTNEdE9rcVlpT0psK05vL1Jj?=
 =?utf-8?B?SkVIVmxTMytLVTBLY29hV050aFhYQ04vQTZWTllpb3ZBVXpCUGc4L1FhSlNJ?=
 =?utf-8?B?VVI2QXZBQ1cxTE9tMllkVG9ySWlXa1IrUlQxQ1ZsZzVjbzhDdk9USW83czV0?=
 =?utf-8?B?b3Via0hlbEljQzF6elF1UXJOUUtIdVg1cnZnK0xNcTZuUDdJVytYWjdnVjFt?=
 =?utf-8?B?SUVOWjhpVi9DWTd3MjBpQjBvRVFMUDFIWklxZjZWS1JMNG5STDlaZzN1VjND?=
 =?utf-8?B?VjgrWklwZ3poT0o0WFZBcUMwOUZBNWQyVVFtd1VtUENuYXF3cTVQRDBjb0Vj?=
 =?utf-8?B?ZnVNbDAydDc3RDcvN3JjWWhweHYraHdPSlk3YnQ5VjhSWHBIemtQQXdsMXFF?=
 =?utf-8?B?WlJKaUxEdjBkQytWZ2krSnJGMjZXWUtNaklqREoxYnJ6VE4wNHBLYlRja09T?=
 =?utf-8?B?Y25FKyttM2RUS2dEYUpVTUNVdmtIa3BRaE1EOUFQRDEvZE1UTDVTVW1DQXNS?=
 =?utf-8?B?L0kzdWRXZlJCK25YcXlVSm9xd0ZPMFZiQmhYeEV5U3VpdUJ0Q2RuZ29QWEhj?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b77a93c-f431-4acd-f6e2-08dda820683e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:12:10.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayKFjGWjWLajZXCJA+nCcjk49ljwU4S2HKXvQ35vYCwFuku4/S3K0BVppCF5Qb/az8M6TQf0hl1BJdkqZuhWr9ABHC0XGZCIRtLTNKs14Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11233
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

Hi Heinrich,

On 6/10/25 1:17 PM, Heinrich Schuchardt wrote:
> On 10.06.25 12:53, Quentin Schulz wrote:
>> Hi Heinrich,
>>
>> On 6/7/25 1:32 PM, Heinrich Schuchardt wrote:
>>> Setuptools 78.1.1 shows warnings:
>>>
>>> * Pattern 'GPL' did not match any files.
>>> * Pattern 'BSD-2-Clause' did not match any files.
>>> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
>>>
>>> Cf. https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fpackaging.python.org%2Fen%2Flatest%2Fguides%2Fwriting-pyproject-&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506087467%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=EE9NsYjNmv9u%2FCkTUJlLaDtXouwZ2pNPlBwvLFuwQlA%3D&reserved=0 toml/#license
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   scripts/dtc/pylibfdt/setup.py | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/ 
>>> setup.py
>>> index c6fe5a6a446..487e669f524 100755
>>> --- a/scripts/dtc/pylibfdt/setup.py
>>> +++ b/scripts/dtc/pylibfdt/setup.py
>>> @@ -158,12 +158,10 @@ setup(
>>>       long_description_content_type="text/plain",
>>>       url="https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Futils%2Fdtc%2Fdtc.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506108720%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=r00cvV5e%2BYJO6je%2FyIip3lMC%2FjqkUpTKvC%2FpMS9aobU%3D&reserved=0",
>>>       license="BSD",
>>> -    license_files=["GPL", "BSD-2-Clause"],
>>> +    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2- 
>>> clause.txt"],
>>>       classifiers=[
>>>           "Programming Language :: Python :: 3",
>>> -        "License :: OSI Approved :: BSD License",
>>> -        "License :: OSI Approved :: GNU General Public License v2 or 
>>> later (GPLv2+)",
>>
>> This is an issue though, as it's supposed to be replaced by the 
>> license argument to the setuptools.setup() function and we aren't 
>> matching there (though tbf, we weren't already matching :) ).
> 
> Upstream setup tools has been changed to ignore these lines.
> 
>>
>> Also, I'm not entirely sure BSD is unambiguous?
> 
> There are BSD Zero Clause License, BSD 1-Clause License, BSD-2-Clause, 
> and BSD-3-Clause, and further variants. See
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fspdx.org%2Flicenses%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506121987%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=INVUJ5iYA8APRyK0u9Rh2QUYLR%2B%2F0%2FGwevzMVHxgPiM%3D&reserved=0
> 
> The linked files in license_files are unambiguous.
> 
>>
>> I would suggest:
>>
>> license="GPL-2.0-or-later OR BSD-2-Clause"
>>
>> to match the SPDX-License-Identifier at the top if the setup.py file :)
> 
> 51ec8db23280 ("pylibfdt: correct license information") is already 
> merged. Please, send a new patch id you want to change the license field.
> 

Fair enough, sending a patch...

I did a similar changes in an unrelated project a while ago, c.f. 
https://github.com/maxpat78/FATtools/pull/20/commits/6f811b1a6719e605d8c6fb03d1e95468fa2de720

It seems like we need to make sure setuptools is 77.0.3 or later now. I 
don't see a declared dependency there though and it seems we add the 
path to the pylibfdt to the sys.path wherever we need it. I assume we 
would need to bump that version in those projects' 
pyproject.toml/requirements.txt?

Should we just ignore this for the moment? At the same time, setuptools 
77.0.3 is very recent, most distros don't actually package it just yet. 
If I trust my old self, if we build those tools within virtualenv/venv, 
then it would anyway just pick the latest available version on PyPi?

Cheers,
Quentin
