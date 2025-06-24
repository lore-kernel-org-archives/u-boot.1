Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54411C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 21:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F2082B18;
	Tue, 24 Jun 2025 23:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NPCX1iZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8A582C84; Tue, 24 Jun 2025 23:02:41 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976C6803CC
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 23:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbBH8Ds5i2Q4Zb3HJKpQ5T+E3/bUtA69YBstnWn1WSTlA6HmbIsrWv+4A74dWScLFhuA9CCbLqVNYNTON6HVQg8cCkmjbRr8tFIglC7BRxZnX9IAb+D12WSpXCMNnvilL4KsTvJDpBKjF2rq1VYwglKUisnO7GRGU2VDubwqmNKdR91opMk7YM98S9LLQ6NM3ZtQYHxoSLsoAupMKYp1JGaqvUdQrxLIDoIZaafyzCfCWoPYSicjRB8S0UnQp6StBNDGSLn3LmPFIAJhuNOz540KEGyUnOgBkyLddZelsZI/BYYd3qTuNDIjE1T6+gYn8gNfloqMo1RAM8sxZdZxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3dIbCkaVgIzGI440QXOkRCkQqauy6Ql2SCHk2rdhrQ=;
 b=AuWBayxA758IGeM7iC8SchZZDOjcJa7WOK/4vCaohEX5PaTcrFDtsDAzVu8YPm0oyo9X3Sq4+f9J/rKmPe5m+P7Oqmo55snMdf7MA1eyNp6V5E+W46/QdSZWF+42yCkoB76yMTaA5FT/PztH890GLgqMkOkTYa1e+YdWfw+9WTin1msygZ1u2Zk7U9gLh+8pB0poGWksTHP7HhFrdvtLWRmplsscxieuzVEGu7b5MQXjE1TwBvxrqIWY930HQq985nXfCp+aBwx1W0kZW0XbASsKDsXpTIivtdOMEM4kBaQRmigSc4fuenLHTuNdNEdP1uFNInBVzhtth8Prx+LzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3dIbCkaVgIzGI440QXOkRCkQqauy6Ql2SCHk2rdhrQ=;
 b=NPCX1iZfixtvfbgRqFIsKEJwRuAEgagt2h6JMhu27WIJ23uRRl5y8OdrQf1iCia3rxYejspQ7XOjR2h7Lb3rXPFdkPS659nYtQiELdIq+0mWu6cj/4GqFe4BBgpj5Ue7ZAEfJ7jusV9G7uEJC81uk0yr/lwhIb8u9vHnRaHZzEWZGr1wTZYyACKiaR11vOJAEPaCvqVSFWsxBt8V0IDdp8iWOYejwc1TBDKyOkeffFNaCMpFS98bjwsCm5FTFnn7lJYabmqe+7YyE8KtlpPCxeQPXxYUtyOqbPtd00HmJYr0oet1n2xRXsiP2RzZ/T/RZpFfBSz9s2dFrWjrUcgiDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10538.eurprd08.prod.outlook.com (2603:10a6:800:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 21:02:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 21:02:34 +0000
Message-ID: <c9fafbc7-e813-4ed6-ba27-527407b8d32c@iopsys.eu>
Date: Wed, 25 Jun 2025 00:02:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 49578d76-f954-4675-17b6-08ddb36270ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnkwOFROZVFTVTZiY1NUVUNaQzBrZElXTThhRTU0ZWZVYjgvUEVqR2F4Ymw3?=
 =?utf-8?B?WktMdm11VmZIQ3M1MStHSStsWkVUVDFJWklqL2d1WDNLM1JEeDNOZjFvZkx6?=
 =?utf-8?B?Yi9BUWtDeWREekNhUldmbm5SRmppdVg0ak9lMllaZ3R3TWM2SkFMbFhSQURL?=
 =?utf-8?B?NUZINmN3SmpjZGR0WGZ4ZlRnQXJ6RmZxS2twYzFnSFo5YVMveFlsT3hxcmQv?=
 =?utf-8?B?RkV4Q1dJcEhiUk00QW0vR0dJOURjYWdyZ1F6T0tjVEdUZytvU0JhZEhXYm1k?=
 =?utf-8?B?ZCtrckx5OGpGR0RZWmowWW90NDMwTHRZOXp1bGtrYldpKzhPSDh2NGJJeElG?=
 =?utf-8?B?YnF5OVFQU1Jzb0UwTHRjN2x6UzdYQlhKU1ZYdUhORm1DTkErcTBRYUVaR2Fq?=
 =?utf-8?B?bTVJQTdsaFkzV1J6NmhDeUZyekQybXlpcUVVZE84RDhMZkRJdVZyVTdKcGMr?=
 =?utf-8?B?enlrSmRKNmgxR1pPM09XS0diS1l6enpOVHZFVElGckdtN3FRQVF3dnRlRVp1?=
 =?utf-8?B?T05tY0xJUUVhanh1SXJUQ01VZDIwMnNUTGdDZGh1b3JFNjlZdXcxMVozcnBM?=
 =?utf-8?B?OGRTL21XYlNwSnRoS3pQUGpHVGUwOHI1MklDWUUvUi81MjBtUE9FUnhSaUNH?=
 =?utf-8?B?Zk5mRzVsMjdVNlFTeGU0TUdOWVByRHord0laK2ZIR2dWU0F0ZGMwN0xaMFpO?=
 =?utf-8?B?VzhrNTlETHpOZzcxVStoUmkvbi9PRWhUVDdZQTZlQmtmZ1hoK2JQY0RKT1R4?=
 =?utf-8?B?a1o5em94czZXeUthSlA4UXo1dHNZZStQWS92ekZlaEs1eTlpSkNyd2t0MnhE?=
 =?utf-8?B?YzBvZWdNaWc2TUcycWlMaXJxa2ZJWWJrUHpHb1dDb2orTWtvWm5oeDd2ekRs?=
 =?utf-8?B?SUh2bkVpZEJ2U1JyUmNaY2E1MGR3ekpyUlhJeCs2YlRsY3lvZVBLazhpUzRD?=
 =?utf-8?B?NVdGTGNGem9ITFFncDRJTEZoWXBnT2szN3A2UFFBSlcyS2JkTHl4L1NMNnJT?=
 =?utf-8?B?cldMOGxxNGUzQml6eEZXdkhMOVJuL2ZzdksrNjVrTGpUV21Yb2VUdW1OUCtQ?=
 =?utf-8?B?SFpiTGNpOFJZa1NUVmR5TUMxSDB0RVRNWU41ZCtKMy9vM2lwRWNZaXlncXEz?=
 =?utf-8?B?OTl1V3p1UEZwS2hLMTB1aGZMYUdFV0ExN3Fvc1NtUW5XeEJNTVBIRFVVK29H?=
 =?utf-8?B?dXdkN1FSaGZXd21ZN2t3bWtGWXhINlZSb1BnZ0IzSWxQamNXbkZMbVQ2V1U5?=
 =?utf-8?B?SlZWaUZ6Z2syV2t4WlA5OGxaNGJQMzNSbU9WYUFHaHZhbmJNVmdGTWpYUk0x?=
 =?utf-8?B?bjdqZnVFMlB2WGFlekpRdXNTZWxsOTMzaTlJK1UxUVY2d3hmb0dMb3gyVlhX?=
 =?utf-8?B?ckc4REJOeU9QcUU3aEZ2VHcydjFoUzFsc282YVo4eTFlbExIZW11MG9PVkVk?=
 =?utf-8?B?RHJQNUpTTTJvY0c0aDBxUDhVUjhvdTJqQ0Y0Rk40Vy9YNFUvazhPdE00Y3ZE?=
 =?utf-8?B?SmFpOE1IaU9HTG1mWGFJMVdLa2s3amduVTZkQ3RuK2d2aE1jZWF3aUhleEVH?=
 =?utf-8?B?ZDlNTkZKdC94ek1vMW9QUzRYOFYwc2NkOHRDK0xTdmdRNGRPN1lTK3RNUXVU?=
 =?utf-8?B?VE1pRW9CU3hReXY2RExUblpXczVyMlM4MDI4eHFxYWJ6R2xUdVc5MUxTak8r?=
 =?utf-8?B?aGJXS3ArSkxiL29yYW5xS05DczV0bG8rSUxtSFNyeUs3MDZEN01LTEhURnBj?=
 =?utf-8?B?cGx6dkdsdzdvMWt1SGpyeTFJS1RhbkkyRkZ0bkYrTjlTUUF6TUc3OUdpQThN?=
 =?utf-8?B?OWJPS3hyeDRJRDJ0SnNQaTByVG5lTm0yRWFCLzYrbkVLbzJ0eXhlbzZFZHdw?=
 =?utf-8?B?UFRYblRyQm94RlpTZngvUnhDTEk2N0tBNy9nNHJBRDlxcFFPeHFSZTYxdFdG?=
 =?utf-8?Q?6hcPasrZpJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpJOGZUa3lZMWhmemx5Tmc1SEhZdlNCTDVQdUpuRkVCazV5WGFFRU5aRnJl?=
 =?utf-8?B?RUloYlBqdEY5WThtU3hYZVJkOW1TSXNtSHVQS05YZGFvbC8zRnJKZUZ5amFI?=
 =?utf-8?B?SDlwZ3I3YnN3RXFxSm1GV2pQYzgzRnZqNDgydXZPYmVVVTM3ZEh3MG1aSWQy?=
 =?utf-8?B?OVhyNjZqdHFRaHkzSE15T2FnalJhb2dXT2U5TUNMaE9DUit2SXU0enZZVDNI?=
 =?utf-8?B?QnpVT1VhUEl3MFBIZTlGWWd2NmU1KzJQSjRRcnFYTWZqNXhJWFJDSXkvYmI1?=
 =?utf-8?B?NUZLaTd3YXZ0R2JwMGI5YXVQVFg1aEUvTU1GNTE5ck53QlV6VjYwUUpyRTFX?=
 =?utf-8?B?Wmc2eGN2OWhyNm4wQVB1SXNRVGc1bkdJWE1Zem9DK3F3VVBIR1liTGNuOE9L?=
 =?utf-8?B?ZVZSQXVLcEJpcXh2QzRNSWNOTE4yNm9FQ2JtYUxBZEtwM2k3ZVJVREVqSmtH?=
 =?utf-8?B?U3UwTEtUUS9oeWw1cTMraFo3ZEp2WS9jdmV0aVdCdTc4TThTWE1MNmpWRWEx?=
 =?utf-8?B?d0lyd1dZK3c4dmhHMGRabk83ZFp6SForaEZVSXNTSWt2NkZqZDVJK0dFZVZU?=
 =?utf-8?B?WEZKd0tSNytuWjlKQzF5QkhhMWkrNkdlVDl3MGJnVXVkczVqSG9SQ1hQV09x?=
 =?utf-8?B?SG9VUGtoYTZDOGhEUk5YRGtLRlYwcjdCL0NtVXhGVTNSVzFna2x3d3VROEhi?=
 =?utf-8?B?WHRNMkoyQzJpM2g5U0x2Sytab2JwalB1UERBWWI2VTZyK3FyMGtSMWhIMVVm?=
 =?utf-8?B?YnJVakNzdDA4VDZDTlcxMmlFRDhxckh0WW94bUVUeXMvTzQvNVpZVHJYeUN1?=
 =?utf-8?B?K0txeWUveG9obm1XSG8wamVyWE9FVStXWS9IMkNuUjV4VUZ5b1BCeU1RcHFl?=
 =?utf-8?B?VExXMFdQL0xTN2FnaWgzbXdLc29lLzU4enpDMTFjOUNIVlA5d2xndUVBcWFT?=
 =?utf-8?B?RngzRWhBL1RqY2dyd0VXdVRKQTd1RS9BaS95RkhGbnA5Y1pSMmZYdkpyZ3lB?=
 =?utf-8?B?SEtja3NtbmNaZEVJQisxZnpjWmlaKzFUQlp1U3VJRitkVVA1V0d6cWhLVFVE?=
 =?utf-8?B?bHI0VmVTM0x2Z1AySU1HaFEzdEZTWVNYTVVGbGJiQ2dSRTQ0UE13T1hPL3Fn?=
 =?utf-8?B?cS9rMHBDWnZFQ1V5UjNsbmIzY25uMTVlNkNsZTFqeDBlb1Y0c0RUV0RpdXRN?=
 =?utf-8?B?cHpFZ21JWXdxbEF4SVA1RGY5dXZDb1V6VzdjRUZ2dXYwcXNUb1pncnR5RU5U?=
 =?utf-8?B?U0RnOWNiNWJEcHo1Y1M0c0VBcWRVTUk5YlR1M3E2aFRvQ202cUhVaGdEY1M3?=
 =?utf-8?B?TXBoK0pyU052S1c1WElLYXRaQ0FmdGxpVGVuKzNLL2hodjJIaEphUlhIUTRP?=
 =?utf-8?B?bUEvZ01xWUpuZTJIOGoxbjA1ODVqYzF3NU1pRWRTZzc0ZjFaeVZjL3NwZEtI?=
 =?utf-8?B?b1dlRFlmR2lCR045MHJkeUlYYU1NZlB1V0V6K3IrMGxtNjZITmorNlN3SjBD?=
 =?utf-8?B?bjZ5b1g0a2tqYk1HVkxJWWR2dkxzMVoxcjhQbk1uSEhQVm5Kd1dUU2xZaXI0?=
 =?utf-8?B?dUxXeG5yOGZ5amZ0QUpSYVZNamkwTkNDT3A1bnZYQWlDVTNjY3dMa1R0c2hW?=
 =?utf-8?B?SEx6UFBlcWJ5MGFrRFV5THhzNFk1VnRkaE5LemVENUN5cFZuNG5VY3Z4cjZu?=
 =?utf-8?B?QVBYM3FzMWVMQ0ZhQWZkVE81TUtiL01vNkR2SHNZMVo3eDl6MUNNMm13NjhY?=
 =?utf-8?B?bnZBVnl0eS8zbmZ2R2l6V1c5QXhUVmNYejhzV1ZpZXFzRWkxOW1DQ1RpWUk2?=
 =?utf-8?B?c0xkZk9pTDFQMjcxdElYeUxkbk9VbWpVaXRwR0RNSUNIeCtEM2hEM3lVY1Mv?=
 =?utf-8?B?RWJuRUs4cUdIN0hrTFFxcnRyK09ONW1rRmdUbVVNQ3ZZdmQxN3pLVlh6NXk0?=
 =?utf-8?B?SE5hTEloNU9ubHNtdXR0SHExQklMNFVOVG1yamo2Ny96aE42M05JYUFGblRn?=
 =?utf-8?B?UEJDVlp4L1o3ZVdreXkwSzYzOTBiVHhGL0VibzUyWnltdlZyWDJxMGdVNUxw?=
 =?utf-8?B?QUh5TG9tU0pDeHMxK01yeHIyNmZSWVNNNjJmYnZkMkRnMmFYcDVGM1g3QWVY?=
 =?utf-8?B?dHl4S3hWdDVwVGQ4SWdvZE9wZEVSWWVkZm94WGIzZXNaRm83OFBKajNjbzdS?=
 =?utf-8?Q?32p/xQeOP6tyHp3HKWhLgxI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 49578d76-f954-4675-17b6-08ddb36270ff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 21:02:34.4264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx6F7VUgcUiNDyoAdcpIGfDqjsI2ZND4YyDSk4PdN/iC17zecJP+dmBjqRTKVGjrG+33pLRjIeoTcsfYIpg8Vy4z9r8e1y2+45q7PPvLEXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10538
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


On 24.06.2025 18:34, Heinrich Schuchardt wrote:
> [You don't often get email from heinrich.schuchardt@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> A malformed FIT image could have an image name property that is not NUL
> terminated. Reject such images.
>
> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_fit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index e250c11ebbd..25f3c822a49 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>                                   const char **outname)
>  {
>         struct udevice *sysinfo;
> -       const char *name, *str;
> +       const char *name, *str, *end;
>         __maybe_unused int node;
>         int len, i;
>         bool found = true;
> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>                 debug("cannot find property '%s': %d\n", type, len);
>                 return -EINVAL;
>         }
> +       /* A string property should be NUL terminated */
> +       end = name + len - 1;
> +       if (!len || *end) {
> +               debug("malformed property '%s'\n", type);
> +               return -EINVAL;
> +       }
>
>         str = name;
>         for (i = 0; i < index; i++) {
>                 str = strchr(str, '\0') + 1;
The line above has a clear bug. str will never be NULL, so  the check on
the next line is ineffective or just broken.
> -               if (!str || (str - name >= len)) {
> +               if (str > end) {
>                         found = false;
>                         break;
>                 }
> --
> 2.48.1
>
