Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB111C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 08:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9B283211;
	Tue, 12 Aug 2025 10:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nS8pxunH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983E58323A; Tue, 12 Aug 2025 10:02:35 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1CB8319C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNqtymtzktR2rf2KVx/0ZbdoC6RmQAwATL+zKeReeKKUzpZed+9s5xb0VagfB243tzfVX4bM88iuUmzIGD0hPS5dhyXhK9U/Y46sAM+pm9rRp5KmE3FQGQtkwll7bedLxmWbItK7oS3zd+HOe6XS9cAQWedR8MU/OEasKGsTS1oBCZ9zKjqGfvZRNjB1Tslm3wGqf1hDjpS7NpWOBcqaOVzldHrWJfbISjWmF3S3OuG6+99wJbaZmU/Gr86nqIAaYWlq+HJudWtc7KtTJEM/J9pIfZWw6tcDuEhfxQ0kBA4ebAHPRET0DdYNea5QVOpEWMfEQ1gs5fDLRcX5kMZBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+P5Xt8lB+/nRj4zw7p0Yy55eUSY15GGLs4JvUllYUQ=;
 b=w+SVYiNV81KVyHRVx0dtqZcVcYj63QYnc3fWxrs5pu1HGk1xpDQTROGnKhUzVTi/mLzAu3u4sMMW81a30d2COuMspGrrcoDCHesxfyV56E7e6jlwxffJlV00QsMU2ZylvA6Y90f9oWAiW2xoQusfxGPT3zJ1+7Zssp3BpLRTlCIE+pKcHHm5DIXclhdL0KMoVRoRl1cKSveA1p41VyF7aMow868xTaXIrQYuryoRfYKQTMY572WYpShyiSfvVFfiUmaW64/VNhPQCQ81naMxWy3KQ6i103CNg9lFqrnwJFZSnBBGENAN/oisxTMDoHG6Y0smNezmN8FgDYljwt/zGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+P5Xt8lB+/nRj4zw7p0Yy55eUSY15GGLs4JvUllYUQ=;
 b=nS8pxunHp/rMfiCLGYasxYWF6th7gJUPjMao3Rgp9FptYy57Qq9pnQHAyPsBS7z3i1S7ym1XeJU9QTkictZ5z9T6MwtLQpGHc77QVsPbQV60x80RtYfJizDsDgKQ9/M1LK3qAlgcUTxbelyT6D7hBAvs2zAPLmPJYKzd7ugqdqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 08:02:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 08:02:31 +0000
Message-ID: <eba0984a-ee81-4d94-a7d3-7d31b6a23350@cherry.de>
Date: Tue, 12 Aug 2025 10:02:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-4-jonas@kwiboo.se>
 <a22ea144-ada6-4520-a7fd-43380f526ee4@cherry.de>
 <ad21e750-5606-422d-842e-23a33772e7b8@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ad21e750-5606-422d-842e-23a33772e7b8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0159.eurprd09.prod.outlook.com
 (2603:10a6:800:120::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a8c974-a09b-4772-551a-08ddd9769682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjZCWlJNQUhmdU9YZTVGSzRrOXZJMkxURXFFU0J2L2gySXQrQzRyVmdncm1U?=
 =?utf-8?B?bWgyTXIreFFibmM5QjVPam94RTIyZmlvQjRWWElZQmF4Z2IzZFRMZlVvQWs2?=
 =?utf-8?B?WVlRTFJhT01yV1ZxOFZ1ek9pTkk4Q2Z0Zno5Q3QrNDBIVGdaaXQ3VUcyVGVo?=
 =?utf-8?B?M1pCNDRoV2JDSDRyTGlZeEtSUmtPQ090UGtDSUo2K3ltQWJPQ0NzUGRRMHZL?=
 =?utf-8?B?SnZjbmRKQk11U2pjck5pZkFBSEdaUlh2dGlncHhwY0FkQUQ1SllWcUlZQXhp?=
 =?utf-8?B?RkdvZFFxOHMyL0tvTStkSWpBNk9nVnR0Z1dtaDRNS0NUTS9lYkYzYVFqczFZ?=
 =?utf-8?B?KzBVUHpZMXdGMEdsa25mMHZSUDJGNm5rdmFRUUJxNjBLZ2hhQUFiU0cxZW1O?=
 =?utf-8?B?WTIvR1lraHpEeDlTbVlrZ1FkNUdpUHlPbHVFaDJVZ2FTelhXZ2VCTzhZczN5?=
 =?utf-8?B?SmxpaDNORnozamd4eTQyUEYxQk95UGtvb3ZOL0hidjgvVWhUUWdlYmwySENT?=
 =?utf-8?B?ZDBXdC9xNVE1MjVNTG9JUFVuTVVPUnQ3TVExYnlHem1PUm9makhTSkU5bGNa?=
 =?utf-8?B?NVJFNzhaSTRuQ1VrVk50KzRQQ2ZHWDEyNFB2V0ZaR2JqQmFwRlZWRmwvSG42?=
 =?utf-8?B?eU1ybk8zUlZ4aGNzejI0RTZ4VkkxZFlNc2dmbjZvekhCbFFSbFdraGUycVJG?=
 =?utf-8?B?SVBuRWQ4RXQ0b2dwcmNPV3FBMTdTT21FZzlJbGdnR09jeGp6SFVYT3U0eG5M?=
 =?utf-8?B?ek1qTVJ0R1ZPWGVGajlKdmtROENYUzNBOEQ2cUkwYUFPWW9MTVlnaFhCRXY4?=
 =?utf-8?B?WmRWaklmTnc4dm52YmE2RElKcnBCcVpwOUdaK0x5R3dZNjdmMlAweHpTWFhk?=
 =?utf-8?B?VXhtUXdaaEhQdUYwYjJyd0pQWXQ1VGxNRnJXNmZxTDdUNmRzYUhuQVAxcE01?=
 =?utf-8?B?emJ4UWc4NFlYRkpUQTRjbXR2M1JFTzlpd2tuNFUzaGVmR1FYaUdNNUg4Rkw1?=
 =?utf-8?B?azV6dDA0am5FTWZCOHo4SjdLV1dkU21oM0ZjVE1kODRQZUVtKy9hek5IVXZu?=
 =?utf-8?B?eEMxblduRlhyYlBzbnhMcWhoNjg0dEo4eFNNQ21jZzRBczNGZFhFYVJmRy9S?=
 =?utf-8?B?N2VJdi83U25UTE5QamNmUW1CMmVtMG9KTDBRcDRaVDk0d2I0YzFGclVVT014?=
 =?utf-8?B?YXJUTWRaRC9jdFQ1MmFEeW1nTk80aEw4bzZXQnN6TE41MzdsMDUyd3RhaW9h?=
 =?utf-8?B?elVxZHdmTnVJWnVxWjNMdkI2azRoU1ZaUERMT2FlRE0zOUtKd1JlUnlBcWUy?=
 =?utf-8?B?WXp0SGMrYTlxWk0rb0NXQjFwNzR1MUNwZldsUTE5SzM2aTRMSDRLQWRMMnJ2?=
 =?utf-8?B?M0NqREFGTytrUFFERmprakJiWC9vTjU4TUhZV2dObk1qT3Z3MDZBQ09ydUls?=
 =?utf-8?B?VWthWm9WcWU5R3dpaFFFSVoyamVXUnd2Z3AvcDhzMHY0MzBIVGRWMHlwWC9G?=
 =?utf-8?B?MTRPTEU1VmNQZjdWWHBLaVc5U1d3YjFRS2VXenZ1MVhQOHdEM3hXSUtZTlBr?=
 =?utf-8?B?SmVsYzhPTkIxcXFCc1BNL0NydVdlRDhCVVpPRzNZejA0QUN6a2RheG1XUS9G?=
 =?utf-8?B?SU9RdnlzVm0vSFlScWtMa0RBOE9Jemc4RHM2dEdlWDdiYzExYzRQUTZWQ3Zt?=
 =?utf-8?B?VFl3TjRrWWF3a3JjUnh2NDUxVFlnWWZxYmFzYkZoWU9GcWZNamNSWjdvMnBY?=
 =?utf-8?B?dVVhNHhqK0lIbk9icWVIUXBNTUUva1Ewd3lwc3V1MWxtdnFCVlY3bnlQNzlu?=
 =?utf-8?B?eWF5S0RWb0NjMHRJVXVKaC8yT09WTVVvOFJNOUxXTnRjSnBHbUc1a0c5VmJm?=
 =?utf-8?B?Z2ZjYWRjaVo3SnJTUHA5UXRHbFdCYnYxdXNHWHdhMnVWclRqR0RRYXpUOTYz?=
 =?utf-8?Q?tZGsa4WHATI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi93V2U3TmNXWmtsaDNYZ0R0NnhBc2Uzc1Zud2JEWkVHai9sTG9mdm4wd1NI?=
 =?utf-8?B?WVU4Wm9EQUc1WmxtancyaS9PRlQ1QytrcEw4ZUlSV2g2R3hnNm5Pa3pzajJ4?=
 =?utf-8?B?SEIrbE5RSHlPSEl4SlJMTUp1WTBuNG5ua1BveE1uU3Z0Rm1oVE9PNjM1YlFl?=
 =?utf-8?B?c3FSdEJXRkQ2SEVQVDhLQ0laRlpTK2hBUkRCbGNZVlVGRUlqblloZVQzWEta?=
 =?utf-8?B?VGt5L0tORFlJaTZnV3ZmM0pRT2l5blhrcXZJNFlydlpMaTVEd2ZqTmU2MkZa?=
 =?utf-8?B?Ukplb3B4enN3Ni9LNW1LQmtmMkp1M2thYzRmWG5RSjVhYkZobWZGUmpEaHI1?=
 =?utf-8?B?cURHa3ZmSDNsRytDdjVmbHZaL0tlMlRTNDYwMkhQQkdOQ3BtQ3J3dnl1MU1T?=
 =?utf-8?B?WWZ6Q0kwWlVjZ281N2NaR09NbUZPMW12bTZrenkwWmdIcUVwK2tmTUwyRE5v?=
 =?utf-8?B?YmVnNVY1T05PTWdCay8xTi9NbzZrSFlRaXBLa3drSHlGQVNUQ2hmaHJUcFp6?=
 =?utf-8?B?Y250WUxoWE1xbTU0SjFabG1tNjJDYk85am9pTjllb2UwRXd6bjQ1dzhVZmZU?=
 =?utf-8?B?ek5wUlZ0N1RNelRrRkRSeEo3Unc3eTJYNzV4KytPTFkrOGx5UGRMQmhsUjJL?=
 =?utf-8?B?dTNwYndlY0VwSi9pd1IrZG5NZjBFZ3k0ZklUaDhCc25Cc0toMjNPZU1rVzNp?=
 =?utf-8?B?MS91Qy9kbkV5SExyakVkTzFERmRFUEgyYzU3Mi9uWVpiQ2RCZnZZOSs3a1h6?=
 =?utf-8?B?blFqSDlEWlBSbnVTN0x2Z3VrTjF3TGR0aVppVEY4bFR4T05wL0JYeEd4b1Bw?=
 =?utf-8?B?bCt2Y0EvWlZLRnNlWHFQQzhFclJzbUlVQmpuaGxrRDhQZStQcW41dWh2MExZ?=
 =?utf-8?B?ZjVITDYyaENrOGtoQ3VhNFFSQlp6c1oyTFBTOXNqVkxDQURDN3hyNXFqOGFq?=
 =?utf-8?B?cHB5SStkc0M5ZEpnNFhRR3lWck1yajlTSm9RSVE0VjR6WHJXdWY1SlVQclJG?=
 =?utf-8?B?UzZvRGFJL1NUdENYbXZIbW9vZ2NSR0drSVk3SnIveGplL210eGhBMWxhSnd3?=
 =?utf-8?B?TngzTEdMRDh1K0FRQVF6amhsazI4RHhuTDJLMC96MWE3UFpQdWFGN29HbnlI?=
 =?utf-8?B?WE0zVE5XVWpqdjZxT29RSERWckttYUV3ZUZMVXR5YWIzWUZ2R1NQZ2k3U2JT?=
 =?utf-8?B?UEw0KzZHeUFNdUlFMGNETVZCaTlzU3Q4UjRtSnJTNmFwaFBvY1FmaWRXcksx?=
 =?utf-8?B?eEkvRUVFWXhMZjNEL3ZxRG1ORmI0OFpvRlFqSkFiTE9PaXpvbGx1OE5CcnAv?=
 =?utf-8?B?QmdOMGNBdjNLcElvTmNxQnZNYmF5REtoeXhnV2xKdE9BNHJoVTVWR0VYQjNl?=
 =?utf-8?B?cE9QdHRIaWdMWG5vUzhvL0lvbFRJZU1pemNTREc5aUxJaU4zVFpmNGYxTkxi?=
 =?utf-8?B?K01ZM2xXNTBPMFZDeUo0U2F6QjlCdkpRVkNhMWxnMjlNT3JJaEVFN2F1Vktn?=
 =?utf-8?B?L1A4U04xY1VGSjF3Mi82VWdXVWJqRjM5M2pwdEdBUTZMWWpDbXVDZHZuRTBL?=
 =?utf-8?B?NjAzWDVkM3luWUtWQ3BBMFVTMDc4ZEh5ak82R09saGxkRWRSU0JXVU1ycHMw?=
 =?utf-8?B?bUFtTzFuWUlmOEdETEZIZEVPWk11eFV3K1Jjd0VoWmNzNzZxdXMrbDFrNmVE?=
 =?utf-8?B?YjdTb1hESTRhYU5qR3JMbXRVM2RJMkNRRkwrYkJDQkZaTm9tOXo5WGFTK1ZU?=
 =?utf-8?B?ZTVXNTg0ZTNWM0RrRzZqaW9VMXJTamlUR2FuRlNXTnJEeVFUSlp1Q3cwYkxX?=
 =?utf-8?B?S1hOa2Qvd2xnOFh2K0lVY3NPY0xHU3ZVVVQyUkUzdzFGVzVQbU5aL0Yrd1Z2?=
 =?utf-8?B?Y0NiNS9xUnJQV2hJOU1wTExyN2dXVWZ1VVhYeWk1elZOVm9SSTRmVnVtY3lo?=
 =?utf-8?B?bllRenRDQVJJTVVkQVZDdERkc3ZjSTd0RnIyendTQVR6K3lhMUdyVVlsWElI?=
 =?utf-8?B?QzNpVDE3UVNmVkVsbFBONmNPbEtvNDI0aThybitPY2puOUR3Z3RTOXhuUnJk?=
 =?utf-8?B?Uk1hTUt5RTIwUDhkdnF4SDRTYVZCVVNjNDRJMmpKcjVUclQ2aVpuRVFzYk80?=
 =?utf-8?B?TDJpb0R3VU5rNC9YRDV3TUJFZ1lrSmtveDVHNFdRcnpmTVNvMm1PSEVJRWdi?=
 =?utf-8?B?eU90akN1UXA3dnNPT1d2NEhWQmFGbjE2UUVUd2U4WjRDZ0lweFNSV1JtbVB4?=
 =?utf-8?B?RHhzdmZ2UVZ1MlFybkZtN1czSXBRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a8c974-a09b-4772-551a-08ddd9769682
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:02:31.3717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fso3HH/vOIH32xIB8YX2lkQxDXaVef03SG1+agVcnHrCskfv2HwMnmUJECrBWHvImExrQ9qHztV0dLj//F9DUaSpVnI8/r23WrW1pYtK4dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791
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

On 8/12/25 12:02 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/11/2025 11:59 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/1/25 11:06 PM, Jonas Karlman wrote:
>>> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
>>> differs slightly compared to prior SoCs:
>>>
>>> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
>>> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
>>> - Booting from sfc1 M0 has not been tested (no board using this config).
>>> - Booting from USB report a new bootsource id 0x81.
>>>
>>> Add a RK3576 specific read_brom_bootsource_id() function to help decode
>>> the new bootsource id values and the required boot_devices mapping of
>>> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2: No change
>>> ---
>>>    arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
>>>    arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
>>>    2 files changed, 59 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
>>> index fb5a107f47d9..c7ed09e03eec 100644
>>> --- a/arch/arm/dts/rk3576-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
>>> @@ -6,6 +6,11 @@
>>>    #include "rockchip-u-boot.dtsi"
>>>    
>>>    / {
>>> +	aliases {
>>> +		spi5 = &sfc0;
>>> +		spi6 = &sfc1;
>>> +	};
>>> +
>>>    	chosen {
>>>    		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>>>    	};
>>> @@ -16,6 +21,17 @@
>>>    	};
>>>    };
>>>    
>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>> +&binman {
>>> +	simple-bin-spi {
>>> +		mkimage {
>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>>> +			offset = <0x8000>;
>>
>> Is this a requirement of the SoC or just a default?
>>
>> E.g. on my RK3399 I can flash at offset 0 u-boot-rockchip-spi.bin and
>> it'll happily boot. Is it still the same on RK3576 but you preferred to
>> have a similar offset than for eMMC/SD (and/or have space to store a
>> partition table before?)
> 
> Not sure if I ever tested using offset 0 for rk3576, will do before v3.
> 
> If I remember correctly the rk356x/rk3588 (and/or others SoCs) would not
> boot when using offset 0, so I probably only tested the 32 KiB offset

Possibly, I only own one board with a bootable SPI, my old RK3399 Puma 
so that's about the sample size I can get :)

> that is known working for other rk35xx SoCs. And on RK3326 (probably
> also PX30) a 64 KiB offset resulted in working boot from SPI flash.
> 

IIRC, I mistakenly flashed on 32KiB offset for RK3399 as well and it 
booted (the SPL, then it broke because it's so much space constrained on 
RK3399 Puma that I cannot afford the 32KiB offset).

I guess this could also be something we could have as default. If you 
want a different offset, then you can update it in your board 
-u-boot.dtsi (or have a Kconfig symbol, but IIRC we don't have one for 
MMC so why have one for SPI only?).

>>
>>> +		};
>>> +	};
>>> +};
>>> +#endif
>>
>> Not a blocker for this patch but I think it would make sense to invert
>> the logic globally now so that we don't need to have to do this for
>> every new Rockchip SoC we'll support.
>>
>> Have -T rksd in rockchip-u-boot.dtsi and all SoCs that have an SPI
>> controller and do not override this property would have -T rkspi set in
>> their SoC DTSI, e.g. rk3399-u-boot.dtsi would now get
>>
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>> +		};
>> +	};
>> +};
>> +#endif
> 
> I fully agree, there is now a minority using the special rkspi format so
> a flip to have rksd (and possible also the 32 KiB offset) in
> rockchip-u-boot.dtsi is a very good idea for a future series.
> 
>  From a quick grep maybe only rk3288 and rk3399 may need this special
> rkspi format? Probably also some older SoCs, not sure we really support
> building working SPI flash images for such older SoCs anyway.
> 

What we can start with is doing a flip which results in the exact same 
binary before and after the flip. Then whichever SoC doesn't actually 
need the rkspi trick can disable it on the SoC level I guess in a later 
patch?

Cheers,
Quentin
