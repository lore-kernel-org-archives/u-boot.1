Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6EC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5C98861A;
	Fri,  5 Jul 2024 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="kX6Slzu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE3E88327; Fri,  5 Jul 2024 11:24:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B270788579
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 11:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAj76OvN5MyBW3sSvh/30S6DE69v29eryQgCh+OEuNB2iJjZ9Vk2aOK2qcDoNbi8/XmtS+XXVDH7Si1o7uBNQPrmwHOwSkP3/VF8nyDDfT9gr2ZX70oKlQeobRzhVyAckzlpr0lqmiLUy+8F1SBqsnbi4y0OwxOcUnbbsDiDxG8AG1h+6MuilCipFyBOs6Hjk0bHFVp8iembLbmRdQIEbl300MlRol4kOxU0XbikuI77MvNBZniom3CpscVqEWEMdfdpMaZi9dv93dMkkWP0q5vVMhs5nFg+dHmoSlUDNDNF1R+7Oz5xiVKRiq8qpurY2i340pAfhwCCFT/fC4W0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNSoR/3m0R1X5sisX6tITZv2LH/Sb8ZBVbrxTVNxGWw=;
 b=Lw9SJLlRNiq6G80SdbwmoX3xZQ/A/PpmPWYiEuPJ/PO+v5WlGTM9G0XueYq5ebfS5qCCv/6Z/ThZQO4bRI+H6IGjF6Lp3rhXQsfCTWZGFdrNMLLlFlxGxFZpluinpLO1gIElUCVj2QqVHZx5ZkAyLDNoEmghIXZZOHPp+CHUnEe8UeZ36gmvXzIplOAgpSlTVqqQsj4GUR2nC2qjcq+3s8TVvlerRrmhKIok5YkXp8ODPD6Rm4Tv+zee9XzZiEB7J7SkzBla6QbOFTPvkeKWGZ1hqz57FTGjB/W5sXIjrMQ6lQXaOwP8sMDiVloSbyc7+iXXgYVTxBT0CkPW/LEP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNSoR/3m0R1X5sisX6tITZv2LH/Sb8ZBVbrxTVNxGWw=;
 b=kX6Slzu9kLRPFkrKSdeqdbGGp6fYx5NCVnG+/Xd5k3vskcAZnw81vcmJTCXs4CPnulteHKTCb2skHQfn61Avd7/nTUo0LZFmVgLXRrY0pWFVcaVDVCAUMGcZpshvFs95EeVjQipysT8txewKlRh7RF7jBblAAky0tmEOrfTL/9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB7703.eurprd08.prod.outlook.com (2603:10a6:150:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 09:24:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 09:24:34 +0000
Message-ID: <f5335679-3942-4388-b640-5a356c0d9ba3@genexis.eu>
Date: Fri, 5 Jul 2024 12:24:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] led: Implement software led blinking
To: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk,
 douglas.zobel@climate.com, marex@denx.de, christian.gmeiner@gmail.com,
 u-boot@lists.denx.de, ansuelsmth@gmail.com, michael.polyntsov@iopsys.eu
References: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu>
 <87cynskzr4.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <87cynskzr4.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: a34107f0-b259-48b4-1bc0-08dc9cd448a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0tUNVQ0OVM5dGl3OE9uamN2c2t3dGFOZWkyQ2xTTzhkYStFM1FvWkRXL2ds?=
 =?utf-8?B?amJqcU1DSzA3Snp1bXNQZ0thZGI4UUQ4dld4U1Y2MThkUlRoZEp1S2hKSlh1?=
 =?utf-8?B?ZFRDNFpPQ2cwZjc2cit2djk1Y0ZBaXdUSkErVjBTb2pmRVc0dENDL1dxemV5?=
 =?utf-8?B?U0NhcVRGa2RYSzZtUkRsZDFCNzU4WjRXZlRtUVZtbk5MYzF2ZmpKWVViVDht?=
 =?utf-8?B?ODdiTXY4eG1pbUJIUFpWaXZ5TmlDU1pSNmZZNGw3OUtOQXV1RmEzRk5LQ1Z1?=
 =?utf-8?B?cUM2RDRxMmo0eUY4NCtjbTJMN1d1MzB5b0hRcnRjUUl0a1kvbnZ0cUhHZW05?=
 =?utf-8?B?R3VobUdDSzBSejdXRFh5YlV2YU1yc1JqYnAvcnBYTHJTVU5LNW95SmRNUmtu?=
 =?utf-8?B?Skc0SlZYaE1NZ3BqWHNMeGxGZ0l1dTRON2tMU3J2bHdDK3JKL1Z0N2hkZFVH?=
 =?utf-8?B?R2VzSDBjTS81Q3hFeHhVd3VrVjMxOUI0N1VmOVdqb2paZnlwNHJhN2pZNkQ5?=
 =?utf-8?B?LzB5TVIzQlpmbU1mRi9xeWcyWE84OEwzVzliWU9jeFU1cGh3Nk10RFVzdUo5?=
 =?utf-8?B?U0Z5bEhIeWFBTkVPSVJENW5RUE5BeXpCbEFpMTUyMnBYOHI4MGJPVGJvRUtQ?=
 =?utf-8?B?cUVkK2VzaTVZWGVhT2crdU9MaHBZaTNiZ1JnYVRqN0djMFJtbjZXcGdrNUR1?=
 =?utf-8?B?ZWJRNW8xYUdNdngrZkplK0VuM2VOdTFIUlQ3ZlBNYlA2WGMwR3dyUkhFcFQ4?=
 =?utf-8?B?cGZVUG9NZFRaRStJZzRKVFFRUHdYK2FMaGRHNEJkUkU0cWFBakJrcVVVRXRQ?=
 =?utf-8?B?MTNuMWhLSlZtRmdvT3RyK1F6WHJxSXhOTmFoRHpyV21rK2tLMUR5RWxucWM4?=
 =?utf-8?B?VlNIejNNV3c4K3k1NlRGUmNxWVV0RVpIemZmejRJMmJnSnNlQWVhb3JsdjFi?=
 =?utf-8?B?SWhTbWdpTndBbk5DRjYzZUk3ZWoyMFNQRjlnWHJ3eEtCSXFIak53aTBPaEEz?=
 =?utf-8?B?ZnhEZUxiOHhUQjBWZzRxd2tZQm5CWERyVG1JdTJxUmRvZmJCUlhUTkgwYVdO?=
 =?utf-8?B?bXliUUZ1ZDhab25ETzJYRjhvL2NONjNYbjdINHhwbndXaE1vVnUxM1ZXb1ZT?=
 =?utf-8?B?TzlqL2RaUGxqSXJzd2VoMElGcXNBeHovMDN3OFY0aUh6dUc4OWhIUjRpUWZl?=
 =?utf-8?B?UXk5MEhPaFVvbzl4Vm13YWVXWXNNS1lmSDVKYkwwY0pWNnRXV2NadWFGdmJ6?=
 =?utf-8?B?dy9COUduYnM4WisrUmJRQzJzSXFQMC9NaWZBdnZ0bHJpUCt3T050L1hRRGRV?=
 =?utf-8?B?dU14ZjJ6OVRZQlFrWVZ6UCtSRkVKUzM0U2FOU3B3SnZ0a1lZL3AwN2NiT0lI?=
 =?utf-8?B?dGFFNWxNRTFIelJYOHVKMEEvZE9pdyt3SjlVRVEyaFBYVFdkbGxzaW41ZlFO?=
 =?utf-8?B?ODJxLzlERFZMZHE0UzEzYzl5VVZtNmFJVDl3eTh6c3VaTC9kQ2I0bktiUkE2?=
 =?utf-8?B?aWEvdmNITTBXRnMwWlZTdWcvR0owSFFmQjJ4NGlJKzFUZEhxU2sreWVKRXdl?=
 =?utf-8?B?Rkl6dmtyWG1qZENCdm9LQ0RoRWsxWGxjSWw3NlRlNmZlSnRyelRZclVVSUZB?=
 =?utf-8?B?Q1poYlNXYmFhb1hXL1lFTVVITW5BRWpBU3ZLcXRDU3ZYbXFFQlA1SWJjTEg1?=
 =?utf-8?B?bWNNN09XRXpmZC9mRWxWVytGeU5WamVLMlFpMEZTT0J0dTFLQmI5eGVieit3?=
 =?utf-8?B?bHFTME9SMmt5TGxFQStOWFFmd2dQMERtNmdoaTAzcUJvRDYzQnkvNDYyWVBu?=
 =?utf-8?B?bjU4SFNBRG84WFB3SE4wZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVVZFQ2Q0tseHN6RGVPbFRUalcvQWl4ZkVtQUNLUjdLaWhsUW1SOFpUL0ht?=
 =?utf-8?B?ZnBDNXNjcmdBL2NVNXdnelJhQUp0dFV1Q0E1Z0FkNWFvR0VZdVU4bUh1RVJ3?=
 =?utf-8?B?Nis4REJBRXpPVkhHSjRpaVZWRXQrRGYwZjl1Tk1PVTFyb2NrTncwWVFJdVJW?=
 =?utf-8?B?SFZCdVJBSWZwa3RSVGNJeWtVL1kxK0dzZ2h1VGwyRkIxd2tBblNDZExHOFc4?=
 =?utf-8?B?ZmFBSUEzbHV3dE1jbkU2ZDl3d3pGak9PSW5EdG1YSVVGWHdBeldST2tFL0hZ?=
 =?utf-8?B?OEYxNko5dVoxdVFIcWFGMFl0VVMyeUdDRVZQQ3JmUHcrbnFnTGVqQnprYTZV?=
 =?utf-8?B?QlplMlI1NnZYL0RCWVVIWGNYaUJIc21jdEd0M1VZbE9UVEl0c0Jyb2JlR1Fr?=
 =?utf-8?B?MFV5akFUalBjbUFBalE1b2tGN0FCZFB2SlpyZ2pQNWl5TFZhNnRwRWRyY3M5?=
 =?utf-8?B?em0zSHV1bWFIR2h3TUFrYjJtR1VGMDh0OXNvTUdlQXRHZWF3TzlEdmRsdndJ?=
 =?utf-8?B?ck1iQ2dKdFFOcDdTRmdHU0xQcDgvVVhjQ2lyYVphMTB3U2ZFaGNNWU9taDF6?=
 =?utf-8?B?NUc0L01kWmNBTHFQQ3JsN0x1dUdXS1pWZFdUZUQzcmIwK2JkdE5jNnhhbkcx?=
 =?utf-8?B?U1F6M1BaeXpRWndsRm5CVjVoNUdFWklFT3FEM2dwR2VKaUhEZVJEMlZ4U1FK?=
 =?utf-8?B?Ri9kaVNBQzh0VkwrajJwNFlXZTg5N1dhZStYNWtLOXZZUTFkTUZoMitvSGhz?=
 =?utf-8?B?SmZuMmpWWnEyVVl3Zkx0MGZlQ3hra0VGZkNjVmZIaWx2cWV2ODBCbk54bjFM?=
 =?utf-8?B?M3JRNEw3TEdEM2xhc2sxbmVqV0JkeElNc05YRnZMRm53bmNtL0JWbVZoNSt1?=
 =?utf-8?B?SVJUKzZBNUd6MUZDa3JGQldDZ2FSTFZ4dEU0cllPYTdNMmFaMFpUbG9ySEQr?=
 =?utf-8?B?aWUrUmd5dWYvSWdKOVlueSsrYWNzdDJ2ajJqa2Z5TXBWZVB0UEYwL0dNNEdL?=
 =?utf-8?B?enlIWm1CZFNQdWRDTWJPUUNJSzBwa2tpb0UydWIzdTFTZDJ6Yit0RzdpTkRM?=
 =?utf-8?B?SjBwc0paVm5Fay94OTJROXVSRldnbW91VTA0VXZDZ1hiblB4UkE3Y24wZGJR?=
 =?utf-8?B?cUpieUxxUHpBODd3dGkwRThzTWFuMCsrWjhHZ21MRVVQSG5YRms2RnpvbSs0?=
 =?utf-8?B?cUYvbFJ3WEk2ZVVyYjdvU3BkZEh5V1BBUzVnUlMxUDA1R3dRWU52Y2Y1c0Fx?=
 =?utf-8?B?K1NXZlVIaDZkYUt4YUEvQTNwMHlzcmpnVlFibWZhMnpvQ1FleE9ZNUdsUDBn?=
 =?utf-8?B?MSt5UEoxQXFXMEIzcFVFbndMRDVBWm1VenhwSUxFT3lDWDFYd2lMcFR5Yy9p?=
 =?utf-8?B?QWc0YlZwbW1RZW0vZ0xCUXNlVmpPV1dZenJYNHU2ZzljZGNRL0diNlVQWjl2?=
 =?utf-8?B?NllnZ2U1cDAvS3hPTVF3TVo5b0Y4RFBkOUo4am16Qmw3SWxxNjRVMFZEcllS?=
 =?utf-8?B?L3VQL3I5Z0ZiSktNQlBkVmNGc045Vnp6aGNlZlgyWjRPQVZrVGliUittaEpI?=
 =?utf-8?B?OHhuMXFNVStYNmlVc3FIUzFQdWpvRzEyQURLNDhmcGRHcGRIbmZ0VURjc21S?=
 =?utf-8?B?cEMxL3VBT3daU0NZa2M4TGdKeUdJQ0JyR0IvZHdDRFJhRGUwakU1ZUs0dmtN?=
 =?utf-8?B?VTFsdDhka2MvNGc0Mm8zaGpDdyswRXFPV1ZYOGYyZGgxMXo1SzJYQWdNTVk2?=
 =?utf-8?B?S2NUaVlBWGJHQk1aRSsyb21QYUN2RTZ1UWdKdFEycmorWWRadzBBdWV0ajNU?=
 =?utf-8?B?QjZZSEpBZEticmRNWGx2U3M0VFZHMWZidWlTTzhBelk5c3Y0UkJQSkt3YkIw?=
 =?utf-8?B?ckY5Rk1QYjNaV2RwWDZ2TlNZSkJXOGljQ1ZkajAzenFkamZ4emdKdERVTVF0?=
 =?utf-8?B?ZXNpMmVjekRjVDVsWG9qUnpqTHNrbHdPeGZ3QmRYRERMUE9mOXNrWUtyMFN2?=
 =?utf-8?B?RitYMGhBc1ptaWNyM0loTlBzY09ZTTlxOEZIUUtnWWtIOXErd0wzajdJVFlr?=
 =?utf-8?B?K0s0MksrMy9TNzJTL1hEMFRTM0EzTHRJT1lKVm9ZMnk1RmlzVnlmdnVaRWNH?=
 =?utf-8?B?SmVoV0x5cWJWV2d2cGxXTDBoMExUQitTNVRVZ2U4azQ5bEFaRnRFZjgyRjZ0?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a34107f0-b259-48b4-1bc0-08dc9cd448a6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 09:24:34.8015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXBVtyP2C6kCEm2FfwpS8cC+eGd/oEm6AHG4sC8G1f9fncyuZgm3EFYLWcoV26mYZD+yxRS0ZUccoxqQ8m8glemKBxVzNC7YvmBDdclz43Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7703
X-Mailman-Approved-At: Fri, 05 Jul 2024 14:46:04 +0200
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


On 05.07.2024 11:29, Mark Kettenis wrote:
> [You don't often get email from mark.kettenis@xs4all.nl. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
>> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Date: Fri,  5 Jul 2024 06:26:24 +0400
>>
>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>
>> If hardware (or driver) doesn't support leds blinking, it's
>> now possible to use software implementation of blinking instead.
>> This relies on cyclic functions.
>>
>> v2 changes:
>>  * Drop sw_blink_state structure, move its necessary fields to
>>    led_uc_plat structure.
>>  * Add cyclic_info pointer to led_uc_plat structure. This
>>    simplify code a lot.
>>  * Remove cyclic function search logic. Not needed anymore.
>>  * Fix blinking period. It was twice large.
>>  * Other cleanups.
>>
>> v3 changes:
>>  * Adapt code to recent cyclic function changes
>>  * Move software blinking functions to separate file
>>  * Other small changes
>>
>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/led/Kconfig        |  14 +++++
>>  drivers/led/Makefile       |   1 +
>>  drivers/led/led-uclass.c   |  16 +++++-
>>  drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
>>  include/led.h              |  17 ++++++
>>  5 files changed, 152 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/led/led_sw_blink.c
>>
>> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
>> index 9837960198d..dc9d4c8a757 100644
>> --- a/drivers/led/Kconfig
>> +++ b/drivers/led/Kconfig
>> @@ -73,6 +73,20 @@ config LED_BLINK
>>         This option enables support for this which adds slightly to the
>>         code size.
>>
>> +config LED_SW_BLINK
>> +     bool "Support software LED blinking"
>> +     depends on LED_BLINK
>> +     select CYCLIC
>> +     help
>> +       Turns on led blinking implemented in the software, useful when
>> +       the hardware doesn't support led blinking. Half of the period
>> +       led will be ON and the rest time it will be OFF. Standard
>> +       led commands can be used to configure blinking. Does nothing
>> +       if driver supports blinking.
>> +       WARNING: Blinking may be inaccurate during execution of time
>> +       consuming commands (ex. flash reading). Also it completely
>> +       stops during OS booting.
> Doesn't that make this feature pretty much pointless?

It steel make sense if total time of blinking is much large than
blinking period. For example this is a case of router rescue process.
One should upload and flash the firmware. Usually it takes a lot of
time. Vendors often wants led blinking to differ router rescue mode from
normal boot.

>>  config SPL_LED
>>       bool "Enable LED support in SPL"
>>       depends on SPL_DM
>> diff --git a/drivers/led/Makefile b/drivers/led/Makefile
>> index 2bcb8589087..e27aa488482 100644
>> --- a/drivers/led/Makefile
>> +++ b/drivers/led/Makefile
>> @@ -4,6 +4,7 @@
>>  # Written by Simon Glass <sjg@chromium.org>
>>
>>  obj-y += led-uclass.o
>> +obj-$(CONFIG_LED_SW_BLINK) += led_sw_blink.o
>>  obj-$(CONFIG_LED_BCM6328) += led_bcm6328.o
>>  obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
>>  obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index f37bf6a1550..37dc99cecdc 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -58,6 +58,10 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
>>       if (!ops->set_state)
>>               return -ENOSYS;
>>
>> +     if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
>> +         led_sw_on_state_change(dev, state))
>> +             return 0;
>> +
>>       return ops->set_state(dev, state);
>>  }
>>
>> @@ -68,6 +72,10 @@ enum led_state_t led_get_state(struct udevice *dev)
>>       if (!ops->get_state)
>>               return -ENOSYS;
>>
>> +     if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
>> +         led_sw_is_blinking(dev))
>> +             return LEDST_BLINK;
>> +
>>       return ops->get_state(dev);
>>  }
>>
>> @@ -76,8 +84,12 @@ int led_set_period(struct udevice *dev, int period_ms)
>>  {
>>       struct led_ops *ops = led_get_ops(dev);
>>
>> -     if (!ops->set_period)
>> -             return -ENOSYS;
>> +     if (!ops->set_period) {
>> +             if (IS_ENABLED(CONFIG_LED_SW_BLINK))
>> +                     return led_sw_set_period(dev, period_ms);
>> +             else
>> +                     return -ENOSYS;
>> +     }
>>
>>       return ops->set_period(dev, period_ms);
>>  }
>> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
>> new file mode 100644
>> index 00000000000..ab56111a60b
>> --- /dev/null
>> +++ b/drivers/led/led_sw_blink.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Software blinking helpers
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +
>> +#include <dm.h>
>> +#include <led.h>
>> +#include <time.h>
>> +#include <stdlib.h>
>> +
>> +static void led_sw_blink(struct cyclic_info *c)
>> +{
>> +     struct led_uc_plat *uc_plat;
>> +     struct udevice *dev;
>> +     struct led_ops *ops;
>> +
>> +     uc_plat = container_of(c, struct led_uc_plat, cyclic);
>> +     dev = uc_plat->dev;
>> +     ops = led_get_ops(dev);
>> +
>> +     switch (uc_plat->sw_blink_state) {
>> +     case LED_SW_BLINK_ST_OFF:
>> +             uc_plat->sw_blink_state = LED_SW_BLINK_ST_ON;
>> +             ops->set_state(dev, LEDST_ON);
>> +             break;
>> +     case LED_SW_BLINK_ST_ON:
>> +             uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
>> +             ops->set_state(dev, LEDST_OFF);
>> +             break;
>> +     case LED_SW_BLINK_ST_NOT_READY:
>> +             /*
>> +              * led_set_period has been called, but
>> +              * led_set_state(LDST_BLINK) has not yet,
>> +              * so doing nothing
>> +              */
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +}
>> +
>> +int led_sw_set_period(struct udevice *dev, int period_ms)
>> +{
>> +     struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +     struct cyclic_info *cyclic = &uc_plat->cyclic;
>> +     struct led_ops *ops = led_get_ops(dev);
>> +     int half_period_us;
>> +     char *name;
>> +     int len;
>> +
>> +     half_period_us = period_ms * 1000 / 2;
>> +
>> +     name = (char *)cyclic->name;
>> +     if (name == NULL) {
>> +             len = snprintf(NULL, 0, "led_sw_blink_%s", uc_plat->label);
>> +             if (len <= 0)
>> +                     return -ENOMEM;
>> +
>> +             name = malloc(len + 1);
>> +             if (!name)
>> +                     return -ENOMEM;
>> +
>> +             snprintf(name, len + 1, "led_sw_blink_%s", uc_plat->label);
>> +     }
>> +
>> +     if (uc_plat->sw_blink_state == LED_SW_BLINK_ST_DISABLED) {
>> +             uc_plat->dev = dev;
>> +             cyclic_register(cyclic, led_sw_blink, half_period_us, name);
>> +     } else {
>> +             cyclic->delay_us = half_period_us;
>> +             cyclic->start_time_us = timer_get_us();
>> +     }
>> +
>> +     uc_plat->sw_blink_state = LED_SW_BLINK_ST_NOT_READY;
>> +     ops->set_state(dev, LEDST_OFF);
>> +
>> +     return 0;
>> +}
>> +
>> +bool led_sw_is_blinking(struct udevice *dev)
>> +{
>> +     struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +
>> +     return (uc_plat->sw_blink_state > LED_SW_BLINK_ST_NOT_READY);
>> +}
>> +
>> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
>> +{
>> +     struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +
>> +     if (uc_plat->sw_blink_state != LED_SW_BLINK_ST_DISABLED) {
>> +             if (state == LEDST_BLINK) {
>> +                     /* start blinking on next led_sw_blink() call */
>> +                     uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
>> +                     return true;
>> +             }
>> +
>> +             /* stop blinking */
>> +             cyclic_unregister(&uc_plat->cyclic);
>> +             uc_plat->sw_blink_state = LED_SW_BLINK_ST_DISABLED;
>> +     }
>> +
>> +     return false;
>> +}
>> diff --git a/include/led.h b/include/led.h
>> index a6353166289..26955269d3e 100644
>> --- a/include/led.h
>> +++ b/include/led.h
>> @@ -20,6 +20,13 @@ enum led_state_t {
>>       LEDST_COUNT,
>>  };
>>
>> +enum led_sw_blink_state_t {
>> +     LED_SW_BLINK_ST_DISABLED,
>> +     LED_SW_BLINK_ST_NOT_READY,
>> +     LED_SW_BLINK_ST_OFF,
>> +     LED_SW_BLINK_ST_ON,
>> +};
>> +
>>  /**
>>   * struct led_uc_plat - Platform data the uclass stores about each device
>>   *
>> @@ -29,6 +36,11 @@ enum led_state_t {
>>  struct led_uc_plat {
>>       const char *label;
>>       enum led_state_t default_state;
>> +#ifdef CONFIG_LED_SW_BLINK
>> +     struct udevice *dev;
>> +     struct cyclic_info cyclic;
>> +     enum led_sw_blink_state_t sw_blink_state;
>> +#endif
>>  };
>>
>>  /**
>> @@ -118,4 +130,9 @@ int led_set_period(struct udevice *dev, int period_ms);
>>   */
>>  int led_bind_generic(struct udevice *parent, const char *driver_name);
>>
>> +/* Internal functions for software blinking. Do not use them in your code */
>> +int led_sw_set_period(struct udevice *dev, int period_ms);
>> +bool led_sw_is_blinking(struct udevice *dev);
>> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
>> +
>>  #endif
>> --
>> 2.39.2
>>
>>
