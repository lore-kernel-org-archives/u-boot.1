Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E5D2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D2C8416C;
	Thu,  4 Dec 2025 21:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Qdc3QfHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC2984158; Thu,  4 Dec 2025 20:34:18 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392BE84083
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAOa8d6S2yhFsKfubwR0HQIAbp767lVnbN2STztpqgKDQ7uSgC1t+EbDdKsMlfp9fVqW6RZ769iJfuNID+fhkY/5gEHYGmLs/rPA/e6nRZbJFahrXUcAXtgf90ezjytQ31ODNC5iL6EwpKsW9EGJyVz0/bhY3qxa1Kr4AfyOvo3pdQUbmbtNIkAlV3ViSPjM44xV7UJ67A61LwOgKqHA6JbYTesGvqlHjyyvWFo8jvbb2T3yMCyJnyP209OjSolIvPqpGxQL5MalJnhd5jqUsikCweWt7bsdN8YLbDFPScvB883LCfZ8SABiMRFtfjyjMU35Xr1jPdxZnyTEHonHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yypH85P+5ikugvIe+i20qqURUhazXEkxJiOboFcXfg=;
 b=e3NYNQrDugyFfpiDvTYk7HIc0tyRo1F38d7tw0E+LUrTQzJG3gPuCrhLRO49jUgrMJGgMgkFWdGfwZFXQg7I7Wmy6Htmfh27k2zKhrQP1vKOtFNtnePI79GTt83kLuo6lQpnrBpMcBW4gX7Y+6UWmAIFUiq9rAg2K74jiFsuhyKQCIEqFjQlKDrmwM53cfJsnlSx/0scLUu0P7VnWPVyRR211y4tAE4akVaiDRubieJ+8NJFJXoTUoruoRMruQehUWE4FFqpUKZS3bfCxhhpujyWpyjaIyLOtAzzzjNu9Xo5HzkPxaQxCjRxw4wUylmfwMstX+zwrbfeR7WZwop1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yypH85P+5ikugvIe+i20qqURUhazXEkxJiOboFcXfg=;
 b=Qdc3QfHsAjNXXHHczRH5XA9knPFzkiwZVMO8RNVwR96Czvj80CREl4AbRMbS4e0vCn7BTYR/6ncHTYpPI0zSt+t62qepksDwEcHKfSFlzb9iV4j3lMNldbXwHsLak5eQ3voSy/GTT7AzBaeY21jmOKPTf52lKhEn+iy0vobVLRipCIdXXyy80MfzzReyFV5rUleyDxaqnKw4/gnZ8amKocfyFU3UVfZ6ctxexnZIvt6tEGrIjFRvxtydLoKz7X4LXvZldt7uKKIGAf6ICN2zq4TO+zTbfCx4GW1vcM8/+CqH0QL1tYJIq4g1z1AA3tMdwalZZQ2IKkq1XgivDNEYnA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PAXP194MB1408.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:1a2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 19:34:15 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 19:34:15 +0000
Message-ID: <BESP194MB2805B8F03A4EBD778B7656BADAA6A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 4 Dec 2025 20:34:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] dm: crypto: Check malloc return value
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0130.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <57e3cacd-8f2c-48f7-a175-b3068acb15ee@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PAXP194MB1408:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c36f5e-b08e-4a3d-bd42-08de336c1bb8
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicB/6FIclOKKnW91krwC5QVjaTjjPs3ghdG+QmExKnRX6DwzTeUTPywYE3GS3BGjtWJH8JW5/5TimRVuoMbgI+mm3rB1+CwzjZG5JTSvrFK7Y/d0W4xqdeF4RSuZSeYvD1WaGRH/ckFGuCMwMSxruOGuVgWaLubegB66hDp1o+Gjs3JG5c5ZRQMJjaWHQqliqOxoTQIIXltGEqw38s0GICHumYF2XxKavH6QEMqs4AN2Kiy6N7n6iHQdDCovAcqtsl/uXojyXlxiMCyZrXdBAy+XL53gDBINGrxm9aEw0zzwebna5g49Cg2kigtxn1w1SF0ZhmqzyL2DpqSe12DUMjvzWXdliVnbZN7HNXMGXKoK3w87hrbGsMWUE039nnSb1lZIs/CJ3ceujGjV2M156EVy0g8TOS6V07Hae1Kiy22sUYh0iueCXUdp1QyiRdWJnf84sJx7/Dwu2j450ObD4sfoVYhdoluEgFSwCnXWx1VwrETE9il9tv+u/P9amdAJ4zaMwKdUpv7tatI5kjVqSoMlJmKcFroP36RdH1JUz+UX9RfiSAYRZAlMWwMNkeTFV6lC3m9VABaTDReJ7l2uUHybThcyPPY4MIXC9lLpAp/YIKl+AfHVOE1nDPtPnqlDavq5cyRfBYMcpZkytSFSPxrk3J3F6UncpkwIhN+90BiAV+Hl0BXtL2pn/nQxxEelhy47NPpq2Yl4vkakByW+VkXOhrM+xYCmCIlKm4JDBGUH4g==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|5072599009|23021999003|41001999006|15080799012|8060799015|19110799012|461199028|6090799003|3412199025|440099028|13041999003|52005399003|40105399003|12091999003|14041999003|19111999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amZIYUFFdWNnVGZUSkRJRm1ZS3Z2ZHNhNmVoMjR4RjNYblR5ZHRUQ2lCNng2?=
 =?utf-8?B?di9aRnNmekxWbmJ2S2JobmQ3bVN3WTFaRTViTVY0QUd0VE9zTlhZYkRjNGty?=
 =?utf-8?B?UDBuM0x0OFd5emFWL2pQVCttR0pjK29XeWdCN1J5N3l2MmZnbDVDYTcvTjhF?=
 =?utf-8?B?VFBuVUhCbHlzbytVcGpyK0t2UHdISjFaYVl0NGxDL0xpbTRwamRQNzgxZDRT?=
 =?utf-8?B?T2N1RzlhWVhDTEsyVVlER1dnVlBtZUtRb0FSNkFsemxKNkRDcTZBNGNGK0t5?=
 =?utf-8?B?ZDhNSXp0MEpYSENhNS84TThvdkJ3V2JnZjA0QTNUeENDWFRWTmlRYjUycE9k?=
 =?utf-8?B?c2tra2FVc0YwaHhqRWp1UkR5b3RsUTI5N1RtSU1KajVoQ0hFSENabndhUmpN?=
 =?utf-8?B?RHk2Vk56UzhVZmxpRURNT1VDVm1jZTNuN1JpUmkzTVBGZVpZREdJbVNnUStH?=
 =?utf-8?B?clhETFZVMVFHNllVQ09jVGxMYVVsYmRxQnEzK0FNcFZhdFcvR0hBOUZiaHlB?=
 =?utf-8?B?QXM4MlhjVTRPOWVuTFVPSEZzQWtmSlR6bHNDYmYwckI3NmxFYTUvT3ZBc0ox?=
 =?utf-8?B?c0kwSUxwNTEyS2tGN0gxK2tWa0NSb2xjODJQK2RpaGc1aGJiYU1DZ1ZuWjYw?=
 =?utf-8?B?T1dIVXdyRDJYYTFuM2ZpRXJCMDdwL1p0V3dDb0NrakZHeG0rdWdzb0pvNS9X?=
 =?utf-8?B?UjFxU0wwdURBNi9IbTZXWmJVZVhVelpkZVdVVnM5ZXNLaG4zUFZxV09VWncv?=
 =?utf-8?B?VGFhNndvby9zL3FTdEpuUXIzb2ErTzh3V2RLcjVSbFBuLzg4ZlhTZG56VEpj?=
 =?utf-8?B?V3c2RFFENzB4d0hBcmpoOFdZOVdoYUhkSU1nQitXRXdwdFJpMXR1L1ZQWDBT?=
 =?utf-8?B?S2tMSWh1K00yR1I4SUZDZGVWRHNlSmk3ZnVEcDI5MWlhLzdnSTlpUlZZZjVv?=
 =?utf-8?B?M3ZZeldJWEZyZWtxK2pTR1paUU9lRWdQa0F3dXhsUy9mbzJaTmkwOUcyOURY?=
 =?utf-8?B?dzRDejgxUDM3MGFVUDhaK0o2ZHZUVm9rcm9ocno1Z1VzNGhJVjR2UnVJTXU2?=
 =?utf-8?B?OWZDcDFjeWRPVlFkTEVjMTdkS0Nkd09qdWcwckdLR2JJYWcrTUUyNXBrTXF4?=
 =?utf-8?B?dnhpM3kzUkREZUdOOEdvMEV5RlZzdTlYWGRjanF2YnNDOTcwOFlWR0o0eXdQ?=
 =?utf-8?B?UHR3c2F1SG1qNk13RFVTMXJVQkNBem9TUHRLeis1eUFVaE1yMFNWY3FPekkw?=
 =?utf-8?B?QVpybzkxK3ZFcjg4U09mdlVaR1V6OXM5cDV4dGFwZnFtK1JWUE1YR1YwUHNz?=
 =?utf-8?B?VURUSGNWUHhKeVAxMnMzNm5pSUFFUnpOV1BHdG5tVzZlc2RXM2gxZm45RkZv?=
 =?utf-8?B?WTRHVWVpQzhZaGZ5ZWFWNkMvbHFIaXhsSm5yS0dWUVBYdHdFZ3lSNDJUMFgw?=
 =?utf-8?B?ekp3VnJUYW9DVEthbzhJUGVRbUNrb2J3d1Y4SDF0ZHJZcW9vWEF0UUZUMXdV?=
 =?utf-8?B?S0laZmZsby9VSDdjVmZiZS9YV1Z5dTArajRRL2x0M01MbzVub2xyTDRkdHlR?=
 =?utf-8?B?NXlxcnIzb1dVc2xNcElvU2RsTlY1MFNwdGRhWW16MmVwdW9yc0EwN1RiN05P?=
 =?utf-8?B?N0xXb2tybjJRUXpYZUtyaHk4UlVLbnVtdVI3a3l0MDBON0hoaFprMXFneUJQ?=
 =?utf-8?B?N2x3NnpUSk4rbmt2SDBwUkE5UXBzWjVIOVg5VG12Vmg1Z3RWSWZqZmREVkhi?=
 =?utf-8?B?bElRMVJjYzA2ODE4Y21xeXgya0tTR0Q3Y1F3bEFoT1RrSzhKL3N1T0hxZXZa?=
 =?utf-8?B?L3BmQ2hZMDRRYnpJMGVnRkRRb1pORWJlYXRyK2lVMXJHOVVZWE5DN0gwckVp?=
 =?utf-8?B?aVZ3QjRxS2l5STdnNnZJTDRlVlBQOE5jbzZxMGk5a29zWGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnIxRDBWc0JrczFWRmozTjl1UnVmTXVFMjBFek9tUDV5NlkzUWhUT2NjRUdu?=
 =?utf-8?B?WnR1M1RadXU2Z0s1bkhncThIQ052S1kvbHA1SkFLNGJSMUlQSzcvMlcvR1ZK?=
 =?utf-8?B?Tlg2YzFnaWhqSjNySzRmSlZvT3RIR1RiR0dXZmtiQmdvZlAwUW5hR0xtbDRs?=
 =?utf-8?B?akRSbWdSdmIvNGZWUUtEMVROVC83Z253QXJ1YnRzek1QRGREbTBpOU9Pd0Ni?=
 =?utf-8?B?NGFSc3ZhTXBMN0JHK2ptZWkzVGZGQWdEQUJaK2VEeDVzakRMZ3I4eE1vNnZF?=
 =?utf-8?B?RXE3Q0duSEh4ZmpMTVZ0MDVtdEg2Umd4S2p5bThwVGVQYVhVaCs2WGY5bTVr?=
 =?utf-8?B?Z0pNcXdFNEs3eis0Q2tLa1JPWTZBOVFobFZOU0hvNm1xaUUzTTB3TkhXZCt6?=
 =?utf-8?B?aXJxRGFrdFFFT3ZvKytPM2Fza1NmM051K0E0RDlXdHJVRW1VS3dvMUs3NWFH?=
 =?utf-8?B?bXUra05kbUlXZGZxM0dDWXBaRitneWt2ODY5c0t4ZjB3TnYySU9WRlRnc2Qy?=
 =?utf-8?B?QlNucXZHS1k1dmlQQTZNbC82M1VwYVlSQ2tHODNuWXpYSU1MTDM3SFBQTlIw?=
 =?utf-8?B?ZW9GR2lEM3ZYdmxDdFV2VXFUeklNWnVxSEgyaTc2RTYvbDRlMmRKSWx0OHJk?=
 =?utf-8?B?V1lmemFPaWsvNFJXUWpaUnlwdVlUNW0zajVWSEdOOE5GckttNXVrQTVLWFB6?=
 =?utf-8?B?UW14SzludGFjdTZmUUxSRXZwL0tUVnFaRnJWVHdMZzlXM2gwbmpER2RWK1pl?=
 =?utf-8?B?Z0s0L3BWNzZsb0hVTkVRa3FjN202b3hPdHJSbHNkTjFLcWVpSUZ5dGZCam1J?=
 =?utf-8?B?bHRLYTUralk3cUxGUk1zb3F1REo0SENHRitvVkRYY1NpTWQyZ2d5RENNVHoy?=
 =?utf-8?B?T3FuZlhrOENtYVFyd0ZTRjNLNHIxNUlydHFVOUpQSVhwK2ZQTG9paHhTeE9n?=
 =?utf-8?B?NThCSGVONTM2Sk12Z0NQRWgwMVRDL1BGcTZXTTUzcnNGNkZGYk91cjJUbjBy?=
 =?utf-8?B?cHl1VWcybU5RNkVKaGhyOUZ2QlMydWY0d3ZkcGltZHFET3hlRElwRkdvU1BS?=
 =?utf-8?B?Z1h3dmY1WVNVd0dCcjRnY1h5TldNOVQwUHBaWlFhVEs5OGluaStOd1p6Z09U?=
 =?utf-8?B?Z1NzbXJjTWdvVjNUb3luR05Pd1ExWnZCWFFpZWZTWENRSjUwRXFPaTFXZHJL?=
 =?utf-8?B?R1hKdnMrWEhzZzd0SlVCSzhlaUlIL0t4NUthaXQ3OTFkNm1mQnFUcU1zL1py?=
 =?utf-8?B?M0xFaDVISStOT2ZaVUVTb2toaC9XMklCblZxZGw0ZlpaUUorMWtXK0lwNVZ6?=
 =?utf-8?B?SHZLaCtZRitZNWhuN1JTM29qSGxyekd4R0owSHplSk1jNndnMDRjYXFKcmFn?=
 =?utf-8?B?MmErR0syOTBwR01wQzR2emczdHpQNmFMMW9mb3V1NUZoL1JQbnpyUUxWdmxI?=
 =?utf-8?B?ZkowZnR0bnVJaEJ6QkFJK1k2WVhTS2NTcVo2VTMxZFlTOUJNUHM3a1NXMDdZ?=
 =?utf-8?B?bGhqU1lFL1QzREhVMUlsUmdIa2FUclJIcVZLeTRlcEsxVzRMSDhrYnZPYmk5?=
 =?utf-8?B?TlBsaTZNVDl0Sm8zNDBFZ1d4UG90c0hUZTBrYW1WNGRQa1kvSmZBMW40TEJF?=
 =?utf-8?Q?vjKQajyW9PJFGle3dueHZrTukeeozHFiNcE0DUePRYmI=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c36f5e-b08e-4a3d-bd42-08de336c1bb8
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:34:15.0859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1408
X-Mailman-Approved-At: Thu, 04 Dec 2025 21:31:27 +0100
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

tmp_buffer is allocated using malloc but failure
is not handled.
This commit ensures that we do not use a NULL pointer
if malloc fails.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/crypto/aes/aes-uclass.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/aes/aes-uclass.c b/drivers/crypto/aes/aes-uclass.c
index 745c6ce57a9..5bdd3d736c4 100644
--- a/drivers/crypto/aes/aes-uclass.c
+++ b/drivers/crypto/aes/aes-uclass.c
@@ -156,13 +156,17 @@ int dm_aes_cmac(struct udevice *dev, u8 *src, u8 *dst, u32 num_aes_blocks)
 	/* Process all blocks except last by calling engine several times per dma buffer size */
 	if (num_aes_blocks > 1) {
 		tmp_buffer = malloc(AES_BLOCK_LENGTH * min(num_aes_blocks - 1, TMP_BUFFER_LEN));
+		if (!tmp_buffer)
+			return -1;
 		while (num_aes_blocks > 1) {
 			u32 blocks = min(num_aes_blocks - 1, TMP_BUFFER_LEN);
 
 			/* Encrypt the current remaining set of blocks that fits in tmp buffer */
 			ret = dm_aes_cbc_encrypt(dev, tmp_block, src, tmp_buffer, blocks);
-			if (ret)
+			if (ret) {
+				free(tmp_buffer);
 				return -1;
+			}
 
 			num_aes_blocks -= blocks;
 			src += blocks * AES_BLOCK_LENGTH;
-- 
2.43.0


