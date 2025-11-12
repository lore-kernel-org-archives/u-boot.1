Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E180CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AAC983C62;
	Wed, 12 Nov 2025 15:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ocio02t9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D653383C9F; Wed, 12 Nov 2025 15:21:15 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8153383C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li5iEY1mrfuLEOC6ZD1i70GdMBO/sCRUDVepwjTB/UnbU2gXGjXB0ualgDNH4TyMyx90QQBkuYkR8122qT+VUB1SdEjZ/3dUnEMGuRoyPwxjTZTHn06smsvfmLNoSQu2NH8bpRPnnm5onGHkkxnoQ3gHFZnhM5qeB93DdPIBwYOffnpHQM35bBwqDVB857UJzw4jxx0cyAgbGWOMMG4J/abpGRdweNlbL7leCArsTfYQvMmjMQyUbZfux+e8W4d1XFvKQOPBlsuE0x23FcDWawzLF7gLqU/3XLsAdeoKVWvit3Z2MTmCrOBdaluc/Xq5wR4ItiLOmFeFWYiLeGi2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNKc2ZD0JanJP9bNCJ7Rue1xrN/qpQjVAe1S5foX7vw=;
 b=HNousnfWbaaSlQYWPb5CSkvtiy801LVIihjUl0s5T5GLtgmBHJAv94I5zPmPhtvTK0CdOviWLMYRrP96ZegKUUYd1rSXX1CK7n6//X1jpnN1ReIym4w8QtlEgDzkjRxwTo0Qr7A9iBP4K6/GMvnbSyUiFThNEWZId8iJbhD/c5SGdxSDi2jwKpqKK3hRdveTimedRmKl9TnJbOV8DIfSFpSt5Is3r+OW523YHR1BsxF/W0cP0pleojRtLG0ULQXPYVnli/tq3EdqHtQEAxRnaTaqpGjvxLVFDMrFX5KRT+e4PFCfGCJicWIXePl/Cfva8TuVIlYRl0UjZHigt8/5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNKc2ZD0JanJP9bNCJ7Rue1xrN/qpQjVAe1S5foX7vw=;
 b=Ocio02t9lgK6ETzfV+WQDLILsT/w7tkxLK3vo+MjiQDeWRRdLHFzLKYkQIim5cPSaUt9008IwbBsFjllnkx/eAskPlsLKKWl2NrgK7rJPfMKYSY83GRWxR8Ay3EeuHAgR2P8NpDWl3D6XYGX4iNLh/bhQAH0XqKduFB7R5dq/4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8365.eurprd04.prod.outlook.com (2603:10a6:102:1cf::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 14:21:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 14:21:11 +0000
Message-ID: <9a5a4783-cb22-49b0-894d-789da77bc403@cherry.de>
Date: Wed, 12 Nov 2025 15:21:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: mkimage: enhance comments for v1 header
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, u-boot@lists.denx.de
References: <20251107-rkcommon-hdr-v1-1-6b456bb3dd93@cherry.de>
 <20e741ac-188c-4a6f-bf24-4555f58303ef@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20e741ac-188c-4a6f-bf24-4555f58303ef@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: abec0a77-89ac-48c1-4bbb-08de21f6ba9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFNtQVUwNG5mcXVHNmtIQk0wR0ZDRVpXcmYydWtYUDVmMkkrOVYwRlkyU3VW?=
 =?utf-8?B?MVBHZEZ6K1RMKzhLWVpHd2JtNStXN0FmVFRsYy9uUGlBZ3FsSTcwUDk5Ymkv?=
 =?utf-8?B?RFJrVUVldUtZaVBUb1FlT2VvbmQxR29GRUJ1L1QzRVVRV1ZscGFKUlJmdGY0?=
 =?utf-8?B?VnFQOW9qcjB2aWlBSDJJOTV4RnlQNGVMUVgxTEtIaVJnbElXMnRMUDh4dDBi?=
 =?utf-8?B?eW1acVFRcC9ndFpXUyt5Z08yT1lYOWw2aTFuSFora2UrbTZEUS9TaEFUMGNl?=
 =?utf-8?B?VjRLT2hTajJYc3FRTGFTeldiTWE5T0dkRHEzZXVyaFllV2ovZVNRWVdWeWph?=
 =?utf-8?B?Y1JmTUNmTnRMSTBxN3VuMTNHWjkxODBWdFdjOFVqaWRvWVI3cFZnZitwbFV0?=
 =?utf-8?B?ejYwdHZ4bS9FN1UzVkRhcnFuN1VwNDVrSW1JdnZOWUlOOWk3K2VQSnpRd2Nw?=
 =?utf-8?B?UG1HWDh0S0JUNWh4RnIzWGFBU3RUdHUyVklwQkQxRWVxT25UZkYzL0pDdy83?=
 =?utf-8?B?U0tyTWs4U2NXd3hvWUI3aVA1UlVzK015SGtSUHJHdTNQelB1dVVkTXZ2d0JO?=
 =?utf-8?B?MXJEZTRMRWNod252K0tnQ1JxdjVqRDBKbG5oRE4yd1FqcktHelVIdU81RFNs?=
 =?utf-8?B?V2g0Tzl1L1FiMEZnTVAzUGRQcjFrcWhVaVNYMHBhcUJRVWZmQlZzU3FOMTYr?=
 =?utf-8?B?ejk3QUJmQTJMTkFXcHpoZ1g2SURKUXc4SDBsckxrT2JSUXdoNTRQNUpoaGh6?=
 =?utf-8?B?T2J2SGJOQjg4N2xBK0VZdFJ2YzRZTWZwZGhnMWw2azdYUDAvd1RXOW9PR2JF?=
 =?utf-8?B?M20xRHBRMlQ0ejdHR3JiaW5NbUhpQ2ZIQ1J1M0dmVGtHdGxZazhsejdSaU1Z?=
 =?utf-8?B?aTNvcFpaRUN2YmlCeGNBZlRyc05IUmxPeEFab2pjVG9QTElFcUdPZG92MW9l?=
 =?utf-8?B?K0lRby9jbjNpcVppZ2JoVW1xTVo4S3kzTUFTRVk4bkxoSlZNVUdUY0VmNjRP?=
 =?utf-8?B?RDlQSjMvcG1CakRWREFZMFVMMFVtNmwydXBnaG9ZNHNiVUpmQ054TVBVSkxm?=
 =?utf-8?B?dHBESGpSOE1Kb1FKc2ZVazlWMHJhSExGWXBvRmx1dGl5R3JoNXZUekJTQkF6?=
 =?utf-8?B?YVNDMENSYlpyR1d3NFJua0gwK1FXL3BnMzJjbmt6enEvdzVRdW9COGR0ZUVv?=
 =?utf-8?B?N2phTER6MngyZmRWaDdhWG84d0E2S3h4a0RRNE4xcndPTTBONzNDVUVFZDBq?=
 =?utf-8?B?ZjhaWjZrRE5yUXlTWERhaXhjanlQL3VOekVSVUZLS0FoalgxTFVCdEJKamNa?=
 =?utf-8?B?TVNoRnIycEQwczdJdi9rN2xkNnF1S1BaSXMwTnJ1MVBmcDlrdUtGTklCSXNO?=
 =?utf-8?B?UWlVNnRsSHdwcXE2cERPWUU5Z2EwaHRSdWZuQ2pGdkQzVlFteWlDSG5QVHVD?=
 =?utf-8?B?MmNYclFacHZRK2NXbXRDSm51OFo3QVlXcnFRM3phNWp6Tm4vR0JIKzZmWFNR?=
 =?utf-8?B?aHB1ZTRDOVM1OStZaDNmVzJFOUZMSmRoMVh1SnhTMXlubnRhUkVocUlqSkoy?=
 =?utf-8?B?aXUraVdnRklBSVlhekNyRExwOVlLMzY3YmFhbTNBQ1QxeWhwN1VjdmpUQmhn?=
 =?utf-8?B?ZkRUNzRDV0J5bTNOTkx6bXo5RSt2SVkzWGJraGlibjVJMkdqa1p6cjJYZWZw?=
 =?utf-8?B?TVYzSk9EdnNYS29jZzBSMk5NVk8vNkpDeEk4RkQrbXZGbG5KRS9uVHN2REUz?=
 =?utf-8?B?bTVxRDdxbWVUSXkyYVFMQU5wMy9ubHZQOUptQWxKdndyNjN3dFRxaXF5TS9u?=
 =?utf-8?B?WjFxdnNjLytLQXp0MmVqektWS2VLSW5nanZYNGFtcVRHelRSeHNVc0M1eGhW?=
 =?utf-8?B?bUZTUEtSWExBNlVlS295RkUwWmFHSFVHS3FyU1JBbFV5eEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExqZnlTUUovb29Ba1RjZEpxZFNtQ2xGcXVPdG8vVTFYOTBlWS9reTd2M1J6?=
 =?utf-8?B?UndyaWlHNWZIZ2VXbmtNVWNldmlZbllqZHlTbnBpUnNGWm5GeGNJSFFGTzdM?=
 =?utf-8?B?OUl0M2NEak5MSk1NZ2dWbm0yc0tlTjM5NFl0dW10Rk5pMXB4eWFMcmZkVERV?=
 =?utf-8?B?N0srV3daWWkvTHgzQWdNNjRmT0VuUVJTV1MvRWkrbGd5RDBFTnZqUlA3WG5q?=
 =?utf-8?B?UnZhTktrNkZic0lrVUZDNFJvK0J5bXo3UHFDNGFPQ2VVRTVEL1A3WlVveFo1?=
 =?utf-8?B?NzhpUzlNcFJyNzg3MVN1QkhtWExGYTJSYWpmRS84NmNHQVE4emdCTlNIdlNw?=
 =?utf-8?B?RDJkeTdhSXZCald3R1BaekFCa04rR2hJZUhEYkdaL3pLNUVGYTk4UEU3Q2l6?=
 =?utf-8?B?YmM5a1VlckwvbWxYdnRJV09NdU9XQU5SRTRlZW9LajAvbG9KaWVGV2JsYzVk?=
 =?utf-8?B?UTRxZWR4RWgrSHQwckI4c2ZQMEVhV3NWZlJXcjA5NUdqYWZ5MnNsYTRWc3Bj?=
 =?utf-8?B?Y0lZaEw1WlZUMGVPckpyZW1PT2pza0IzWHc4ZUtZa25BaXlLVUJzY1lCeUFS?=
 =?utf-8?B?amZWNFVEUkU0V1N3dC9iblNzeVAwbWxDRXRBUHdaN1dVUHZDV011QkEwcnlE?=
 =?utf-8?B?ZHF0WGNhYS93SDNjQXNzYzJITGhXMTNsMkdheUcyTnMvZnU0S1ZMSlNVSlBG?=
 =?utf-8?B?bmViNFpveCtRQXBYU2NtZzMwd2xPN21QNFhMcEVCM1ExV0hYZHF6d2YxQ3Rs?=
 =?utf-8?B?KzREbERNdm5oM2JMd2lvN0NwRVZHbGhpeXlVaVhTZ2dONXVLZzRYRExTR0Rt?=
 =?utf-8?B?cStFL0xwTlNQekE0VDQ1aStaSFhMamdaSUo5MExhYVVyZXhQU21xWlU1RUx6?=
 =?utf-8?B?Z204QTQ5STlRQ1pVQzg3MXYzdmRzLzdjSXhtdWMwcWcwSXM3bytiTjVBdVRC?=
 =?utf-8?B?dVBDR3EwQlhMU1hjRnVBMlF4SHV3ZnNVc3FEZ21BaXJtZUtOZlJOTW42Y0Fi?=
 =?utf-8?B?ZmVySTk0aE1pL2dvWWtFSTExMzJGS1p0NFJNK3hQTFd3SVVYSzQ3WjRhMm5M?=
 =?utf-8?B?NWRwVmlSdUdrK05VL2lLQUwzSjA0Ykl6TjlRRHdjVTdGUjdpUktqWVBjT1Nz?=
 =?utf-8?B?R0ZUZ0dpbkdqNzZEUEd3RUJiZFhGSi96UWNXZ0pISXhpdFIzZXQyK2cyeldD?=
 =?utf-8?B?UHg4L09UdEJhSjdqTHJUR3pvaU1UVENEOU9JRnRRQjFzOVB5TjZVUlFiUkhL?=
 =?utf-8?B?Y0xEakNYWllMekV3Q3o5K3FDN0N1c0diamNmSUVpVGZMVzRsVGFia1BIaEto?=
 =?utf-8?B?cnBjYllGdjhzdW5iUytIeWZQUEdpMnVDVlFzWW96SVo3RVVvYy9zaEpIYlJD?=
 =?utf-8?B?VkVic0RiTlJUTXNSWVhlOFNDbE9WTmJQRElBWTZBdEpnQ0k3d2gvczJFcjBT?=
 =?utf-8?B?WWwyZWlneEI1R0dFanR5ZzRBRVhRcmZDMHRUUjFaNmxuWEV6N0g1RW5KZEtU?=
 =?utf-8?B?eW9GTUJCR2FIdGhJcFpicFB3U051MXlLZ0xYQkFHQ0N1aDVaT2dLTFQ3WGFl?=
 =?utf-8?B?ZzAra1daZFR2dnZQTjJIekJaMWoxZmJySWNxL2lZbnpSUDh4eUFXYnE4T1V2?=
 =?utf-8?B?bGt2OWlnRkc4NktabDNVNjhIb01XWjlwQlplVUFXY3B2NXhwcTVJcjF1WDZh?=
 =?utf-8?B?Qm5PZGxPK0hFOTRwOS9wNmF2bTlFWUNPVzd5Vkw1amZoZlN4eEx0dW8wNytX?=
 =?utf-8?B?UUlKdkJzblZtZnp5bmd6S0NLZkpabVVidW5IS2dyeElYeHVsamhqUGk2dVFU?=
 =?utf-8?B?dUd6b1FtSFB6cmNTc1cwbld2Wm04amFLL25aemxsUVhlNjRaSE9UMFlFdEZH?=
 =?utf-8?B?Wm5DY01jNm9zdGo1VkR6MEVqaWNXQnhGQkhtSm9ZZlN4R1VMWFNZV1RvdmJn?=
 =?utf-8?B?NDloNnRVS3RvY1czWldLdmVvU0Z2YXd2Nlowd0ZBRDRqL29aNXdZRDlndVFx?=
 =?utf-8?B?RE9na2JGZ2oycWlrRWFHUDFRS2p5N1pZeUxycEFZVDBnSVRZZHgvaVc5OUV4?=
 =?utf-8?B?c0VCMThCSnNTbVRQQjN5MlRlL0NVYk9XR0xmcC81U0gwbGMwK1ZFQ21sMGdY?=
 =?utf-8?B?MVdKakFDOGF6Rklra216WENVME9NUGR5KzJpbHJwcmpKd3lSTDdjbXdZT0lF?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: abec0a77-89ac-48c1-4bbb-08de21f6ba9c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:21:11.0770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2Cv9BOfD9E1TlFEA2PbcDdLvHvnRS5OFp2y5eaWHX+ZDZw4Cz/aUVti0xfNaQPyUuzAoL06Sh7ZjfaC2ZXPhTdhZn33D1jFZf6HEdE2ogg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8365
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

Hi Jonas,

On 11/7/25 6:24 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 11/7/2025 5:49 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Improve the image header documentation for v1 header:
>>
>> - specify this applies to all MMC, not only SD cards,
>> - specify the offset for SPI flashes,
>> - specify the key used for RC4 encoding,
>> - specify what "init" refers to, especially since some configs enable
>>    TPL,
>> - specify what "init_boot" refers to, especially since some configs
>>    enable TPL,
>> - specify the size of a block,
>> - add documentation for init_size and init_boot_size,
>>
>> Note that the offset on the storage medium isn't necessarily 32KiB (64
>> blocks) for MMC or 0 for SPI flashes, it's just the first offset the
>> BootROM checks. Barebox[1] lists a few options, though those are
>> applicable to RK35xx which use the v2 header, so not guaranteed they can
>> be shared. On RK3399, the binary can at least be stored at offset 0 and
>> 32KiB on SPI flashes.
>>
>> [1] https://git.pengutronix.de/cgit/barebox/tree/arch/arm/mach-rockchip/bbu.c#n19
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/rkcommon.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index d191ea72c63..6d1f88bcac1 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -76,13 +76,24 @@ struct header0_info_v2 {
>>   /**
>>    * struct header0_info - header block for boot ROM
>>    *
>> - * This is stored at SD card block 64 (where each block is 512 bytes, or at
>> - * the start of SPI flash. It is encoded with RC4.
>> + * This is stored at MMC block 64 (where each block is 512 bytes), or at
>> + * the start of SPI flash. It is encoded with RC4 with the below rc4_key.
>> + *
>> + * In Rockchip terminology:
>> + *
>> + * "init" means TPL if there is one, SPL otherwise.
> 
> Maybe mention something about SRAM here?
> 
> "init" is what BootROM load into SRAM, typically TPL if there is one,
> SPL otherwise.
> 

True, that I can do.

>> + *
>> + * "init_boot" means the entire software the boot ROM has to load for booting
>> + * U-Boot, typically the TPL if any, and the SPL.
>> + * Basically, it is the content of "init" plus the SPL if relevant.
> 
> The "init_boot" naming is very strange, I would probably try to describe
> it as the "boot" or next stage, maybe something like:
> 

Fair, I was trying to describe init_boot_size which is the combined size 
of TPL+SPL if TPL or SPL otherwise (as far as I remember) and got 
confused by the member name in the struct.

> "boot" is the next stage that BootROM load into start of DRAM, if "init"
> decide to return back to BROM using 0 as return code and init_boot_size
> exceeds init_size. Typically SPL if there is one, U-Boot proper
> otherwise.
> 

We don't really currently put U-Boot proper in idbloader.img, so I'm not 
entirely sure it makes that much sense to give the example of U-Boot 
proper. I vaguely recall you did or attempted to have U-Boot proper FIT 
image in there for USB booting without needing SPL_DFU or something like 
that, so maybe we should still document it.

> For newer SoCs using the v2 header this basically just continues for up
> to 4 images, BootROM loads next stage/image when prior stage return back
> to BROM using 0 as return code.
> 

I guess stages 1+ are all loaded at offset 0 in DRAM then?

Cheers,
Quentin
