Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D8BC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE15E82F14;
	Tue, 29 Jul 2025 13:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YKcB7JWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07E483123; Tue, 29 Jul 2025 13:20:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A438782F14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0trNQ++/7mDMv2NuAU14z7slUzQgfR4HkMWv+C9brLxImaPXRTcgLUvS5GbyHRzWEmgb5NJ8rNAmH7z2B/E+tt2hLqkOxZCIcpAH60iH77AzegRIu2U3ikaBJcKiI+hLxZMIZ9Dg732cwyNHkZFf+Q230XM1wVkXKa9R1RicsU7OafUhv6HKAWXrHY8v0oGui4XLvB+Iaar6JV7hhyOToeEh0ll5EgaCoCUgcG/HY/lLweOs2uORQuNtPmQTMHpErCarikMY8K/t4y0g0d1Mge4qpHRaLiDaY/O25IS0Xo2WQeDHW3LVsldvw5EbHJ8nsYmTRbJEvQDGrg0kFe94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA+NHX3Lj2YLPpGG9ASyjyl+arRSkH4ZC0S4bpFKAXc=;
 b=OOay3XqWtVDXSwY9rMeTgbm24J9S+uEfkXnQSqmqlFN6CrzqfJHubePcIxJtUtGk7pl/A3waGShNveGWZkuRhCNcoZlNwrm4MvvcCViHkgYM6P36ixS6oP8ddAjA6Y5h3bS9aXAy8gBWe19k2CcaV/ZTMcp8NJlT/5KpuzUzSuTrPceyFcJdoA/IGmHHXVqOwyzJQ0vuihAlpWVCrgEtpv/k4tqIKvB+qtjaLbISCcWOsgcE3v2hG9nvjnJgWThSC9XWkcbzjMhChWx1Fzu0PLpHU0J98sZN1tDTUBXh2WEWeloGognj489Jsb8OWQCbt1lXtE+c4duYLgG21rvC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA+NHX3Lj2YLPpGG9ASyjyl+arRSkH4ZC0S4bpFKAXc=;
 b=YKcB7JWeuu4wXYVnObssUrZXK3u4UGvcF39N7afYWDLkDdbwzBw5Qsk8HIzluzM5jfyyVkUuqLkZFHgYOJIVmbubCYhQZE9C8TykkjCsAgEKdAhYQ2H9TafosUoul2GAOcL7pxnq16GXZco+FakDIDFBWSIj8YWrDIA2UGGaGDBLt71VK1P33RDcn0kot9s4EfTAFue7QOQd9+D9tjls6sjudG2tRLWKVsTTD1Xa5cayaJLBKWekuY1pz9Wdovom9RGEvmNTLg65EjKIc7cNVgjYUyqesXosWxxPC8kvG3JpcRGyYlcsYf/YxbO/B2Gdi38ERDvRdA/mN/Z242NC6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 11:20:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:20:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:55 +0800
Subject: [PATCH 4/6] imx95: Remove ROM info USB instance workaround for B0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-4-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: 93039d09-0f6c-4bfe-375b-08ddce91dbd1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnpoSHJveTlUZS9neENtN3lMV0I3T21TalZPYnprZWhpK1VMWndFMFJNbk5y?=
 =?utf-8?B?VXJwVTBXWHlOaDcxS08xUzVHRUdrSEo0R1RYSFFQVzZPbmtTOFl0emhCVWFI?=
 =?utf-8?B?bUZFd28rNXhQWDE4TzhzUlU1TVZhSzV4czBUeExmZ1dvR3RjS1Joai85RzU3?=
 =?utf-8?B?d0ttaDZUdyt1VkxNWXpzM3NoK2NOL0xlb01KMlF6Y3B5Y05sU0tobXp4RVNk?=
 =?utf-8?B?WHhpZVFFYU9iNkkrRGFhNFF1SGk5V0VaM3Bhai9iL1B2MzJWNGpCcE90SlJZ?=
 =?utf-8?B?b3Vic3FzVGx0YUJSdE1iTFk4bVpSZS9IcExpblRpenZncGtGRFZJN3hYaGQy?=
 =?utf-8?B?b3hxSzZFUk8vM1pUNGE1WmthQ2xIblE0U0UxeWZXbHlWUTZBY3FyeWNXcWRB?=
 =?utf-8?B?cUFJWHF2dXd3dnloRkw2bUdDVkQzWDdWTU03N2dMMmVLdHZOMjJFWGtrUFZZ?=
 =?utf-8?B?b0pMenFSeGpzYVpOSzN2aG5mVUtEM1dZbDAvRVpYVXc5SzVYb0xGbTAxSDJk?=
 =?utf-8?B?MjNNcHgrSUJ6SkJjdFVWY2pWT09mUGc4UGptVlpCTXFUYWNpd2RxK2czdG01?=
 =?utf-8?B?b2E5aU8xZm10aEtuYlR0UGlyWmRGT0NUWlFhVnEwNDZpRmE5elF4bzlvRjlz?=
 =?utf-8?B?YWVCT1FLeFlhd3pHSUMxWkFGWXg4Ylg5Ykk4UDVpSEpmRWRvd0Z0RVlhdnpq?=
 =?utf-8?B?MzJCWjlYNVBiWGhMWTRabm03R0pCMUtuV3QzbWM0Z2tNMWhTZHA1Z0Fqdzc0?=
 =?utf-8?B?SUw1QklPTis1bnJuNjNHb3FVT0luQ0RiMlM1TE1NWWs3TWRGMDhBNXlqTWlJ?=
 =?utf-8?B?Y2dva3RnRnVYUmZ2UzlOTE5wUnZkT0ZmVXV3N2wxMmRiMURLZHN0Mmx3REJ5?=
 =?utf-8?B?WUQ0TG5ySEhKcGk0VW9zOXpoVllETmx3TDVkZWd5N0o4SDBRZnhnOEFMc2hV?=
 =?utf-8?B?OVAvT0kxaGZQRzRFV2xEN1JNM09DcVcrSy83REo2UEF3YjZWWERmQktxQm9s?=
 =?utf-8?B?MmNVeE5sdzBhVHNvcUFPTTg4OWQxSmcxd0NBLyticVJLL1JONFk0bE5tRGQy?=
 =?utf-8?B?cEs4aVVIZDZZWjZtWmxSbDR2ZEhROFF1bGcyaHJSRGpZc2NONlByYWd0bVFr?=
 =?utf-8?B?c2hUOCtNM3laL1o5VW9uRGFNSkpTRFFSREFZTnVyNy8yYnRtZ2dVZWVGcXpa?=
 =?utf-8?B?L0ZCdlN4TUNjNy9GL1ZFV2VNVjZGQ3pkZkxNQnMyWjl2K2NZVlFpZ2hkZjRY?=
 =?utf-8?B?WnhBckZPbGYwWS9rL2R1aTMzVFRkNHJ2RjY1SWV4U2xBRjdKNlFwczdsbjEz?=
 =?utf-8?B?Y1hhSjMrQmd5MmtJRnVDQzBRK0RYT21qV3F0cTJRMkx5b2NubUdEc3NLTE43?=
 =?utf-8?B?MnE5S21PMGdUR1ViaHFZdEFjaWU3dDViaklHY1ZhbjJHV3JJZ0lWdWNOcXEr?=
 =?utf-8?B?Rzg2V29HU1Q0NzJWcEpjWkdsbVZsOGQwd3VGQndKVEVnU25vWmtwQXBEL29t?=
 =?utf-8?B?MGlaYkU0R3RTdTJGT3BCZVVPK2ovOW9YbUs4Ujd0ZUZTSHk2czBEUTFySEVi?=
 =?utf-8?B?RGpOVm9wOU9WL1l2R290WDlLOTJIM1UvUnhmUlFRVWFjd0ZkWGtOTTBQUkVm?=
 =?utf-8?B?OWVkVjFzOUR5aWJCUUJvdDVsL2t0T3dFeURsZnpwRDZNa2NXdFp2YmJIY1Vq?=
 =?utf-8?B?K0xlSUs2NzlpVVNjakxSc1pVMUdQVW1PYlR6NklscEw2cUp3Uk55b2FiVXFi?=
 =?utf-8?B?ZVJ0S0M3dCtXczJoVDc5S1VGU1FURzM5cVQ5aGJMdTRGWGNBYnA0R2dvdzlG?=
 =?utf-8?B?ejJZNHR0UUVFWGpwVnV2RU5tMEFGRkI4NWIveDZBYVg4Wms5cjdkR0NrRk9G?=
 =?utf-8?B?S2tuSU84cTlPYUJwMjBJdGxVWnFMS1E5ZEdVdkQydEZZeXFtbVBKdS9uY2Q5?=
 =?utf-8?B?V0hOMXE1L05NU3hoYzdPN0ZzalFXK0taQU5EZWc0a0Qyd1BsQ2M0QVNqOUdo?=
 =?utf-8?Q?y+dDD8P7edWTvsfRcPMUCmhQvClcPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by91RkJzMENnOVFjWDlwaEx2Mi9YSTl2amJtcWpCUS9VdEs3dnNBVkMvalN4?=
 =?utf-8?B?cm5VK2JjTmVDbWJMWVptTUtlejJCVnRRaHdZcmJBRnFQRjl4dUhyeFE1VnFj?=
 =?utf-8?B?dnc4cjE2N3RldW5zUzlwZ3pXdXF1dm1IZXNGczNTekZ5UURhYnFqaG1VSHVI?=
 =?utf-8?B?UkNZZzRCMDVkemhnUjlsS0lIYzh4eHVXeHZuNGNBWHlRaGhWUnRuQU9LN2tl?=
 =?utf-8?B?bXRXK1RGZ1Ixc2hMTGFKbmVmdGFDbTJLcENnTnphblJJbVZScC8xTzl4cm5Z?=
 =?utf-8?B?SnhicGt1K3UwaWMwSVA0eHN3anN3WTBVeDZUZDMwQkJwajQyaWV1bVQ4YWdS?=
 =?utf-8?B?UkQ3SlZpdTlRcVBXRlJwanR0WW40S1NPcjlPZWMwMlZSWm5VejhIQnpMbmZT?=
 =?utf-8?B?K2NBMHErNHdqSGJORTZnYityRzk2Q0ZFclhhZFVDNUt5ek5DOHltZzY4aVdV?=
 =?utf-8?B?cGNJUUY1Q0NmZENDdjNySWVTa0xVK241TVgvb0VOQkY5NXdoWEc1dmlLS0sy?=
 =?utf-8?B?MzFUQ3JBYWw4ZkI4QjFvQnViRUdES1c2SXpBZjZtdGtsR2p2c205NFN1cjRH?=
 =?utf-8?B?YUlRaUcvbXRNRU83bzNkTjdkOGhOcXlqMmxxbGswTS9ndjdGK2p2b3VvcEk1?=
 =?utf-8?B?YUZCeXc1VWhpQzA5U2s4RjlQR2VmeDR2VTVsT2JRbEhmL1A4aGxkVTdyMnJP?=
 =?utf-8?B?RHlFcTlZOHkvVkEvdU9kK1NvMXF0UjY5ekxMc3ptRVdPb0ZPcDIyekVQVks4?=
 =?utf-8?B?VmkvNDdMcE5MVThkQkNYY29XWDJGd1orY3I1RnkrN1FnNk5GcnJtOUU0Vjkz?=
 =?utf-8?B?SVBROE9uaDFsOG9YckJyWmp4dUF1elVScWdqbVU5ZGpuQ3M3ZWl1ZEJ4RVdz?=
 =?utf-8?B?UnVUbFUzS1BYZFRNMWh4TnJTV1U4Q2JiQmM0NitWKzFtbWRNY1VjcWdxWGYv?=
 =?utf-8?B?aGVKZzkzNENUV0doLzE5b1VGWUJ4VlpxNlhISm1qV1M0WUVkRlZzV0Y1RHQ2?=
 =?utf-8?B?Vys4R2w4cmEyQXBWVDllakRWWGZzK3FQUXZUeHlOT1VUSEJ0VW1BVmlFOW5U?=
 =?utf-8?B?TDBzVTlwajdLZnJtNTZrTzlteXZMakswalR3azBkdUtsK0hIWktOcitWdTNU?=
 =?utf-8?B?M3JuOHJvU21PZVJNVE1TbC8zazJGNkJnZjh5Vm04dkluTExCNFFabjJTd1c4?=
 =?utf-8?B?eVMvc0tWakpsZjBhMFZOeGw1di85VkZDYUtrQUhIK0U5Zlc3SEdiYU5PYTRQ?=
 =?utf-8?B?ZXU2TlJoVE50V3ExNS9MUGpRWVNmLysvWDA3ckxlWlZXVGZ5dGEwS0o2eFpu?=
 =?utf-8?B?cEF5OXRKa1o0TW56TTdtOXpROXpMSGFKSm1TVzVPcWcwWFo0QWZzL1dsaXRx?=
 =?utf-8?B?UGFHcDkydkx3blRmMUZGWE1RRTF4YktuVEMvOXYrVDJzdFIxVU1OS0Q0OFR5?=
 =?utf-8?B?ckUwT2JmM3Y2Uys3VCtHUWUvTlNZT3JqOXNsZ3NEbDVlbW53RnM3ZTh2MkpT?=
 =?utf-8?B?a25uYUJVTnNUWTltV1ZZUk84YXVqMFhkRUVzci9iRHV3c3NMRU1abkFJajdS?=
 =?utf-8?B?QnRJa0pqbDhOMGtYRjRWUlllUCtCRUN0YjgxZ25YQ2ExRlA0dFE5US9CcEha?=
 =?utf-8?B?dldCc2xuaFBibU1rRzBGdnR1QUFVOUdNUklkUzQxZWdTOXNjNmRlQlNOOFcx?=
 =?utf-8?B?LzhTSU5YSDhwd0U5L2t1U0FKMStiYU91RnlKdUJXL2dIVmpLNEZ6cUFjaXRO?=
 =?utf-8?B?eE9zUUtkblpGSzBTZmhtelJtYk5QMkE0K3E0UWM0NWNIWSs5YUhYbXF3cVI0?=
 =?utf-8?B?cWVvcDVtS2ZwNndRY0pSVi9GeFJCdkVmQUw4Z3R2ZVFBWmNRK1g5dXlzeGUw?=
 =?utf-8?B?RDMzaXhJbWIraWhGVzNsNDU4Um5aQWFuYUkxekxVTmxITytlVnNDdUg4U3Rv?=
 =?utf-8?B?Q0FhVUF0NUFmTFBrMHBQMmlKa1hSclpJK0pZcnordHQwd0tlbXRBU3NKZEF4?=
 =?utf-8?B?b0ZoYjZnUlhURit0Qmlrb1pxdmtYcGdVclpNM2IzYlZQcmZYaDVlVm9tSGxY?=
 =?utf-8?B?U2VtcmZOQmFxK21ZdDdPWmVTUXhreGcvMWZuSDF3QzNGWG5IeUpIcVZudlFN?=
 =?utf-8?Q?vtlOP8pKeKfgIn0PYd3LgYWFB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93039d09-0f6c-4bfe-375b-08ddce91dbd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:20:01.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOQj5Tliu8t4ejVkNAbQm7z56jng3544H4IBikddRQNkbbPA940agO9MNY7qCZ2l9IYwCYaqXhu1pwERZohVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
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

From: Ye Li <ye.li@nxp.com>

There was a bug in ROM on A0 for USB instance: USB1 is 3, USB2 is 4.
So u-boot had a workaround to match with it.
Since the issue is fixed on B0, so need a additional change.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 13f13ca7d10..b21b18110b1 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -719,8 +719,6 @@ enum boot_device get_boot_device(void)
 		break;
 	case BT_DEV_TYPE_USB:
 		boot_dev = boot_instance + USB_BOOT;
-		if (IS_ENABLED(CONFIG_IMX95))
-			boot_dev -= 3; //iMX95 usb instance start at 3
 		break;
 	default:
 		break;

-- 
2.43.0

