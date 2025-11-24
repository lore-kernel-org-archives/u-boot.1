Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A2ECFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 18:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A9883E62;
	Mon, 24 Nov 2025 19:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CPqjJj8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DB383E9F; Mon, 24 Nov 2025 19:49:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398A383E60
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 19:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNyapZ2Cybh0dDejgqi9HocZZeO0NhlL/1ByesgJIpgGSy4jhf0SnWBj26k3KsDhPb+ZWU1S2N9RMoFQvO6y12vkK6yoWfioTZe25R2Kl3DsfoSYN9bFcpJzvHnRaT1goBxRuuHhw7nG3rZag10KGsgiTyve2GdM8FKZBrKFiabgbOLE+S+vQI3vBU9jwUb4sGF/8kbY6qofuvrW1XnEqRe6T40Z1X3DZLMosyXbueYzl/0DGYXaTouIYE7suKoSAjNU1yVzd6oiLteibsX3G+06ImhRJqvSwb9ARnAIe+BHi/ToyoSYyrFsG/jELVKlOkxWxVslxoOV+q0lKfiX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SB/amt86weFhkjPh6x/04ls9IzsCZuopxZLbLe9ID8A=;
 b=jYQbft4NLsm3tlXKKVy5RwlJnyIjApYU2xxgDx+spxfaMxtqkDHCT0cP2uspON6Caz1ERx56YjhetEn1IbOW3TYExgPEGXiCCqWdSBgbN7pTzGoiyBfskLynmOh25u1RLmZskXDTlnivBtC2aqqeNZHIt85KwiLUBe2yr/aDqrsOrqbcggHKgtWTLzwJMvtWOl0JoHvBVQSgtean65Jc1k63wXAAfgRDzi4UMifItnGILuezZ0SCA3io9heRE9icPOy6biZbK0NX31T3HGsxmoBOQK0mOxXoRx0oy3q377nIuSOrKQwLaG/dCAchyAcBF9O2rIPQooe6dFs2cQLlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB/amt86weFhkjPh6x/04ls9IzsCZuopxZLbLe9ID8A=;
 b=CPqjJj8Wxp+a9sd0e8w2sK6/kT6LxlhYw1jvjARIPN2Ixdyr5kPz69kX+p7MRVQkCPayOwSwrD3GPc77llVZcRDST3iDo1y0lpXZHunJmxKYqsWwtsWveesR8QpDidFZhpmLmxRRdQkKdeduN9oxmRfGla9XRUD1sE4rpUVEVDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Mon, 24 Nov
 2025 18:49:05 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:49:05 +0000
Message-ID: <870ab7eb-9d8c-4aa2-bd3e-316dff42e3b8@cherry.de>
Date: Mon, 24 Nov 2025 19:49:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunxi: remove usage of legacy LED API
To: Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Hans de Goede <hdegoede@redhat.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Chen-Yu Tsai
 <wens@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
References: <20251120-legacy-led-sunxi-v1-1-c4c1422fd242@cherry.de>
 <20251123115810.45ad2e3f@minigeek.lan>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251123115810.45ad2e3f@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f084c6-2709-40ef-f51b-08de2b8a2471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkpvL1VETTNjZHdyenRVVzIzcmpiOEJtN1BSVHdSQzlwdmVuUW50WEdhUjA0?=
 =?utf-8?B?ajRQcWEvY2tjNWJLYUxkdnJmSE9NM0N3dlBmaFhFVFFWZ0xVaHpZYUtvV2Vn?=
 =?utf-8?B?U2NWeGFNTjh3Y1hoREdERXNVSlUrakdJNzdDU1RKaUZwdnBLVFViYWdLSWZm?=
 =?utf-8?B?aVFTWVJySktkQXFGSnlkeVc0Vjc3RW9KVUkxOTMzV053ZTlXNGkvWE0xSzZZ?=
 =?utf-8?B?OU5QeE9GdSthd21FYStmZVR2dkZtUUhmaktRUmdnMGduS2E5VUFGTWJvWVNr?=
 =?utf-8?B?S1dKTFlOV0RGYjh4MDRYN254cXlIRTdaUUxSQ3dTamR5Ly9LWVo3d3R6bWZH?=
 =?utf-8?B?SDdMczNldThjUFd4eW9wVTNKQ2I0K2pYcmMxN3lvVFVHYW5EbXJtR09XeUIy?=
 =?utf-8?B?MG1VdmY0anFzSFZDWHN4T0RUUHRqRTRDMzEvcExlNkRDN1J3dHA4MHFUcFdD?=
 =?utf-8?B?c3l1YnA3ckFkNnEvRFRSMmdRNjlzc3F4VFk3ek9VR3VNOUtaUnZIV3NnMUM1?=
 =?utf-8?B?WG9Pd1h0UGZ4OE90YzVKbGgwY1ZVL0pWR2RhMzl0UGpBUlZyK3E1U0p6ZFZ3?=
 =?utf-8?B?b1BuamR3WFMwY3hBSFlkbGEvUURlbTR3N3hCYmJseDF1bXFqOVlQT2JRVkpR?=
 =?utf-8?B?QUMrMVlHNE5iVnMvRUdKNUNCMUo5Y1cxRVFsRTUzWEIwUUxJTkhxVXJ2bjhy?=
 =?utf-8?B?ZjRRMHhObWJTV25qeTB3SDVHamdrcGE4eUp3OTdIbGhYQUo2cWt0azM0QjZ0?=
 =?utf-8?B?dkh6T3ROUGRaZGM0MEtyNysvUmFRbTBsdno1a0hNOXBpOFZNdCtNSXVEOHVF?=
 =?utf-8?B?cHp4bmpZNVVkZmlxaWdVN1NXc0VsTUo5R2UvRjVURENUS0JRL3pUaHY3R2Vy?=
 =?utf-8?B?Y3d2ajhDekFzT3dwNEJtK00wMk9FQk1DRG1QM2c3SHJURW9tVjBlVFhSRGNZ?=
 =?utf-8?B?L0ZyMG03cTladEpzR3h0K04xUlRRcXUzMnZseWRPZWx3ay9nWnBFUkpaWXlE?=
 =?utf-8?B?MVlvZWdzZjBmMDlGWS9JQ0Nvd0grS1hqTUhTSjBjV3dzMlFLNTF2eVRyWXc3?=
 =?utf-8?B?aXpwYUtmdHVrSVp1MVNRbVo4Yjd5ZHhJbjhwbnlNUk5MT054TUhxaHp1K2Qy?=
 =?utf-8?B?dk4wN0pLUng4czNzSHpVSFVzWWI4V1EyQnJhNDZva0FrNzl4S3ZFczRrUjNR?=
 =?utf-8?B?U0hSR3pJWHcwc3R6NVNxb0k2MXFTaHF0YlowZkVqR3h6L09ITWRDRWsxZHVi?=
 =?utf-8?B?WlIzQTNIcXNITXBkN2dETlVoNG1YQ3Bzdzk0ekpjVU9ySk9nWEV0bkJ5eVAw?=
 =?utf-8?B?RDBmcTNTWFltUnRTT08wbkdvb29LUW1EU1k2SGY4YmgyTUZQakNsVFFlNTBk?=
 =?utf-8?B?VXJtSEZrc3Y4SGd1U1dqaFlEN2Z0L1AxYWpkb0hGaDhRYkpna1B5bk93ZWg5?=
 =?utf-8?B?UVZ2YWN5T2JPaEhnck5obkJ0Tlp6aldCcEF3WjEvcjh1QUMzWUliTFhLZGZm?=
 =?utf-8?B?amxGcFFDOGJITEtqQVMrSkNFem1qUXRSa2tHQjdleGltdjhLR0orRGlEMXRB?=
 =?utf-8?B?aFRPeXo4RVBCVGRIdXJ5QVJTV2drT3hyelYxZUc5UndWNGhLS2s5VkFnUnJn?=
 =?utf-8?B?NXBSY3luejRUSTR5aVE0RFlyRlVnVTkyZ1VrMXlBUTFiNzY1bHRHQzRwa1BX?=
 =?utf-8?B?enU2L0s0MUlITHRDRVJtRGVEdE1mUVhiKysvWnBGVHNWSithbUs1RDVkVjIv?=
 =?utf-8?B?ZE5MaWUrVDljQmVBM1ZPdHhIYlJ1bzFxcU94dTdYN05BRG1BdGxGK09RRUpH?=
 =?utf-8?B?NVcwa2tUUFZsbU5hMUtpRWczczBYckpTS1pKMzdKcHp0d2dyZlViNmtaa0E0?=
 =?utf-8?B?Y0lIUDZVZlFpTmxON2FvTUVpWGViQmJ6WVJxQlpERmxmMzRhNW1yS25PSmgr?=
 =?utf-8?Q?sWtUf1Z17JbO2IrWlHCCOhOdMfZk1hfd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdtc0MxMEYvT0dENWx0ZDJ1Vy9GNi93cnhwbWdKTThMT1VhbkxsMXFkcERk?=
 =?utf-8?B?MGJOaEZHYW5kdzBMRXdCbDF0bnJwSmx2Smx3WmtqMnZvL1l6VEJ0OWdPUjJk?=
 =?utf-8?B?c05PNVZwY0FpSDAzRXJEUlV0TklCUUowbTJuUHh4Z2RoT3hsK0FDMHRuSjVq?=
 =?utf-8?B?UFZnOXZKMXRjdXNXY1hZME1lYTFIaDB5Z0gzRDJiQTlvUHJlWU5PNWtpN1lY?=
 =?utf-8?B?QW9lMDNKczlMOXBIOW1pYVBhZjNjNXVGQ3pHWmRTaDNVOWhiQlVrWXo5djFO?=
 =?utf-8?B?aHgwck14N0lTUzZuRW1IVDY3ajhjcXRBa3NndnZadEJMWmZkM0lKSSs0Q0JZ?=
 =?utf-8?B?KzltVDZpVjBMck50cm9xakxYYXJjVlVWdnJqYWUxc0lpelB3WVVTaFlQU3A4?=
 =?utf-8?B?SUcvVG1zSGhhTG9lRHhqSG9zckg0SzYxL3pSSnFBb25oemplM1pVRHVnMEVP?=
 =?utf-8?B?S1Q3SWhqZnJBNDFnMlFoNlBsUWZNYlFzamZYNHRQblU5WWNKbzYzQzR0QnVX?=
 =?utf-8?B?dmJveUcyWnpWVDVxRXdMMGs2d2VHWTJqdURHSEtDWXFxWUNpUnBQYkV1NFJH?=
 =?utf-8?B?cElTZ3dERlJZYy91WGlLRkdEaFgzOGNiRWIvMXBTdmRKS0tBeURQa1I4bkJP?=
 =?utf-8?B?cU1DZWFPNTRLT1poOHZaN1A4VlZOZ3FuUGx6VXBpTEZHYUE4cjFGVlJnQlZK?=
 =?utf-8?B?RDQzWXROVEdoaWxYUmVWbnRJOVI0QjJjRUtDMFluVGxuYnJjLzJLNHFGYTdN?=
 =?utf-8?B?QVZZTURZRk4wWTZsTHJBQ1Bob3UwbDNQSHF5OXBPNEtvM3p0MUlKVUNINldn?=
 =?utf-8?B?OFNqSWxMcGEvbWYxTlBnTWxpUFlOUnlEdkNxdmpBZ2VEczNuMjZ6bGlsbVU2?=
 =?utf-8?B?OVZiYnBlYXVNZEJkOVFUa01FWHE2S3NlMEVaRU9rTm1TZGRqYkt0V0lmWGx2?=
 =?utf-8?B?Y1RmaWwxajBqNlZmZ3BwRGlob0haUUNqcFBXYVhGYXl2aXFmdzZqbi8zcVhv?=
 =?utf-8?B?SkVNcndOZkgvOGc4YlB4MStxYVk5THVTTDRjZUVUNUFZUDRTK3MwT09UdW5I?=
 =?utf-8?B?MzlIUmpOOTNNN2kzTHdpbkpyT3NoYjVnaHBYQWpqNk9Tc1Y4U3o4b3NmTVpx?=
 =?utf-8?B?S3VaSXRBZ1Ird3hBRllKakhBNzhpNEIzc2NJdU1yS3c3dHFmUmR2bDdDWTFp?=
 =?utf-8?B?TVhjbEZkZnZvQzgzNkFVQlJUcWFTSGNuOGtVREpiNVpZUnJpVTZUSXlPNXhR?=
 =?utf-8?B?SWJ3bnhpb0dZbmdlaE9Rdld2ZnRnRU5TT1ArNlVtWWVjc1NKQnpKNDJvNUli?=
 =?utf-8?B?Qlpkb3dsUTBFbHNrcU00dWdISGI2R2xwQlNsZW90WFNVRXlhQ3pSeXpEdnRE?=
 =?utf-8?B?QmJybCs3WUJiYVdjR0pkUE92SStTZ1ZOdy9tOEhUaXNpWFAzR1I1RzMzbWRY?=
 =?utf-8?B?RFMvNmJ4VmlkQ1ZGbGtPNWRLL0oySGY1TFZ6NnoyaTJucllTOWZZaTc5eWdw?=
 =?utf-8?B?d2MxM0NDQjN5OXBlRmxRektCNmVnV2ZiUWd0a3ViTUhMQU5LMXVHSXBSYk02?=
 =?utf-8?B?OHhQamNqNjUvZXNpYkRlUW9oaEJuVVk2Q0UybGZUMnJuWVpDS3VKV0NDcTJk?=
 =?utf-8?B?ajN4ZHVFNGxKcVlTQUJxWkxvN2JrN0tJQmx0bEdqbFVpc3JvMGx0VDkwSVE2?=
 =?utf-8?B?bmxqbngyU2gxUFBNWGNZMi81M0lUM2M0cHpHc0d5and0VTNJZDBkU3JTWWRz?=
 =?utf-8?B?TkRnT3lNVmFsTFZuT1lwcEhQc3FyQ0ZwSklOaUtZT0pjVThkTXZQMCtVcnBW?=
 =?utf-8?B?NS9iTU1WR3dZNmhzQkR0bFhNR3N6TVpLQmh3ZlEzQnFveTBtZHY5Y1d3eUZh?=
 =?utf-8?B?cVdhTHJLUHpxOUY3R1YxUHhsZGlUWWtTSWJXcGpiWHNCWE5pWFE2NlpaMFF3?=
 =?utf-8?B?N09vcGpEVnVDbG5RUHBwSktkZDdZWVE4TVUwUVlBQy8vVkJsM3hURmg4bERU?=
 =?utf-8?B?MzlrQW1EODlQc2tRQWs4TWttL2pZUHBhYXFmQW1BQW14bHlTaU9YRmU0ck1O?=
 =?utf-8?B?UDhuS1RMYmFSejFPQ25IMkxNUHRiSDJBcVIycjNqM2dwWjZML1I1dmhoSXp3?=
 =?utf-8?B?RVJTZE9YanFEdVJPZGcyb0RPRjRBNThLdm1heWhaQi9kcDhXMXRMdDBFenly?=
 =?utf-8?Q?jvQGQY4Do3JzfUJ6vwJwKpU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f084c6-2709-40ef-f51b-08de2b8a2471
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:49:05.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdxMRSay8BczdT0y3krIbrTS/sJ5R2LTqfU4EJAC+vXBdD9lpAu9y9h/aDDWUtYKQTPpLbJ2WRHbXVnMAbLSWg1gyQPlDhumGkGV/RdgvQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434
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

Hi Andre,

On 11/23/25 12:58 PM, Andre Przywara wrote:
> On Thu, 20 Nov 2025 13:02:06 +0100
> Quentin Schulz <foss+uboot@0leil.net> wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
[...]

>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Note that I do not own this device so I could only build test it.
> 
> I do have a Pinephone, and I tested this patch: it indeed works. I also
> changed the GPIO number, which changed the LED (colour), so it's
> positively working.
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> 

Nice! Thanks for the quick test and feedback :)

> Just one nit in the code below...
> 
>> This is a follow-up to:
> 
> Are there actually dependencies on all those series? I naively applied
> this patch on top of master, and it compiled and worked just fine.
> 

I think it should be fine to apply as is without the other series I 
mentioned. I just initially did the removal of the legacy API in one 
branch and then made multiple series out of it, and it was easier not 
having to try to figure out what really depends on each other. But here, 
nothing from the legacy API is removed, so it should be safe to apply 
like you did.

[...]

>> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
>> index 2929bc17f08..799d60cf039 100644
>> --- a/board/sunxi/board.c
>> +++ b/board/sunxi/board.c
[...]
>> +static void status_led_init(void)
>> +{
>> +#if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
>> +	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
>> +	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
>> +
>> +	if (gpio_request(gpio, "gpio_led") != 0) {
>> +		printf("%s: failed requesting GPIO%u!\n", __func__, gpio);
> 
> Can you please just remove this error message? I see that this whole
> code is written somewhat SPL agnostic (CONFIG_IS_ENABLED), but
> realistically this is SPL-only code (see the two symbols above), and
> there gpio_request() always returns 0, so it's just extra size in the
> SPL that will never be used. Saves another 75 bytes.
> 

Should we even call gpio_request() then?

I can use IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS) && 
defined(CONFIG_SPL_BUILD) as well if you want, to make it clearer that 
this can only happen in SPL?

Cheers,
Quentin
