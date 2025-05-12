Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4742FC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 01:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049178091A;
	Mon, 12 May 2025 03:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QkTWUYgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428C280F03; Mon, 12 May 2025 03:10:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8669A800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 03:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHvjKtt+cXwBak6lvtQIqgoslFF26oZwzHYoW3p6wbqujj/6FB6rjaCCMBpTyHf/aam4s0QTM/36u5OQ/AMt7aRNH3GC1496yMDPXZ4syhhL7+PiiugAQNALLb+qmrj1LJ5ef0KndaOi2ZxSV9yYuKbGd4UxW0cBbfzYINNQuFhcaZeHT1bjp5acr1Okw0wU4tYOlwWS/7NeuQpIZtBasI8HHhYQE8Mm8GHpjnN5CxPr/3QMG6sKaNNnKirSOFh9uRE8hZfDXwWDrz6KxaPWsxxAzkrv8PpNBzGPPrTIoxLy4ilQu8C7++AVu5AC80HO6ihKvTD9XlEnnteikvnDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlbYgd1F4/AozkTERVwVdRV9L635WSACw+tMhb93KXQ=;
 b=INCs4WABUDJ5IrM0EARGb+OI3B7wZqZ3N1AXzicTrqiXQ7H0mcXdhVUjZzzqLgsRY23Kq3gkG6ez7UJmJJn6flERRpwKGx0o3Nad3Ec287WWOwziNG3IOocRaQbZmUR49PxCwk/z6vk1Z+JMrni7bUpK1bd3a0S3epSXHyc7H8KYbrI3jSWiOU316thPwk/aQwuVYr8FZT+SiTxlGjJYnDZVHdXqu9ARzxgQLwD7sGUXaZsQVee1ueSUAH0nzYrJEqD4pq9+BQDNSVqtH/MNKWxjQvV6EPnyx5sYyUkuensHUZ1eAprsyfEkxrxLy3USt/E4w4PkIn65BC2XBalg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlbYgd1F4/AozkTERVwVdRV9L635WSACw+tMhb93KXQ=;
 b=QkTWUYgHexg0ApG+QkdODmRYWUsqkFqo46ROngkmo3g0AYlV+0PGhdoXZZ/0A46jjD8I0Q1UcZM0OdKXFTtxEUYxRCTIuSFvPYilS3xHn16mXUgXW+4wbEONDBwcMNxN6j1M7p6fL+a/DkO4Xn/ua0Y3NVxhiFp0MA60Y0C0539+X74aKzfZgvQniKeFqyfwTYX4fgn0Mcpv3BvXAqHi7VyDMtm892d1EYfpnXBARgLqZw18aYaCGqvD+7/WMqWvdlkRqdQHiECSZN1Sgj5tRDjNW+0CZ/Sp/VQmDlcMHzHGekIBZBF6iJlUH8waCMTkZFCEkZX1TgQ/awnc3o1NTA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10725.eurprd04.prod.outlook.com (2603:10a6:150:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:10:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 01:09:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBpbXg5NV9ldms6IGVuYWJsZSBQQ0kgZWFybHk=?=
Thread-Topic: [PATCH] imx95_evk: enable PCI early
Thread-Index: AQHbwI5ZK22yGt0zCEm57+qkn+71uLPOM74g
Date: Mon, 12 May 2025 01:09:59 +0000
Message-ID: <PAXPR04MB964426F85D3FFD85E1B6A1D4E297A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250509025856.2368055-1-festevam@gmail.com>
In-Reply-To: <20250509025856.2368055-1-festevam@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10725:EE_
x-ms-office365-filtering-correlation-id: e36fe2cb-d25b-4123-b885-08dd90f1b790
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?MUpTRHF0UERpeUNWYzZFZTdhSkVIM2hUbFZ0TUlDVWZYZWswK3k0Nnlsb3Q0?=
 =?gb2312?B?dWxvanZxR0pnSGFTZTdjWXF6alhYN0l4aUwrd3pqNWNxaDh3elh5MkxucTFq?=
 =?gb2312?B?UlphcWNnYWp3eGdBR2JvUENIbDUrUVdkaVhkSWhVbEV5RXJoV09QbWpOaWVk?=
 =?gb2312?B?SXFJZUVYdG5VeDJmR2NDZWY2bHhsLzdJSUZ0ZnRMNXJpZFVRYnFmZllRSkJQ?=
 =?gb2312?B?WXJROGFYYjQ3c0I3K3BseVBNSkdkNXg3aDVCUnZoZEwvcW40b0ErakJvdDFP?=
 =?gb2312?B?UHpUdG1xYkZBK1paWFBsems1NkdyMElsKzFPUE1iOVdNOTF4K1FwbWMvbFFv?=
 =?gb2312?B?Vk5KcHVBYS90VDJlVVp5ZDBTbTk2amVsMlZwdUttWGNoQm5UamVGeWluQURk?=
 =?gb2312?B?Y28zUTc5c00wY1lPcHlkbTJUUUNTMG5mK1lST1dGOHFzR0NCNlZ6ajNDblFX?=
 =?gb2312?B?RWRLcW1XVlNYUEdiY083Z01yMzNMczlBQUwwL2xLSmhaNmNsZTlLdU5xT2FF?=
 =?gb2312?B?ekFlSVJ6SmFodjlIeFhjeHFxQXU3M0pqZjJhQ2Evb2k4MkEzeFRjb2xUcnJH?=
 =?gb2312?B?djlKK2lNTm05WmluOExaOW43aFZ1ajBRdytQQ2lRcHFTZENhNlc3QzJ0MzRu?=
 =?gb2312?B?MHdtS2JNYVQxVXFZVTlnNUJ3YTdPeXlSRWhyeFNNL3hoa2xxaW55aDZKT2R4?=
 =?gb2312?B?VGtVZnZKSUZBRHExeTRGRzNiTlpZMytQbnNmQ2hVT2dPdnFMaTRiMXRHZmxX?=
 =?gb2312?B?MEpVMW51b1V5VWN4TDhPeVB2bXlMazdxQjJuTkc5QzNBbS9oL3U3MmRicjhw?=
 =?gb2312?B?U0t1cEsxV0VKakF6T0F6Y3JjVkNYZVI1U29TWUhINzVPa20xNk5GMVYzOEtI?=
 =?gb2312?B?Rk90MTJIbXJpUTFoWWF0TDA4TlVMQmdOK0hPM0RNQkZNOWxkalcwUHVHN0VW?=
 =?gb2312?B?MWFjOFh0c09JYXpmYUErS1h4V2JjOVBPQ2xVYVp5aTFIMXRJNFpOWnFNY1M2?=
 =?gb2312?B?Qy9hQmdBdE16RG9NUnFVN094Y3BoMHlLTG5BNXIzRUVqN2VHYXVjbTZYcHN3?=
 =?gb2312?B?VkI4UTUwcXdyMExydWdQYUcwTVFEVzRiek1OMjFqWmMvQzJzK1lJYlc1aUdl?=
 =?gb2312?B?MnQ5QUhGRlBxMTdsWlBiQ0M3WUM2SHpiRXJHMTNXOGlvei9SK001NE81S3hh?=
 =?gb2312?B?YWc5WWN3djV6SGswMFpXaUdDSXpleEJFTWN3UzNsZm92QjFtNXNsUmo3ejN2?=
 =?gb2312?B?WFAxL1plcU1VSk8zR1FUU3BCTTMvWk84SjdTRVFIVEJnSGRlaHVUOEdzaFAx?=
 =?gb2312?B?NEpqZStVajB2MDcvaGtiOEl6eFhJNG5nai9FKzJOMFp3b3RQYVJEMkpUS3g2?=
 =?gb2312?B?L0JsM00xVTlrUEJLTXhPQmsyeWZpL3BoN1dKd0NCNXluR0hwSDc5MVFxSjVQ?=
 =?gb2312?B?Nnhyb0xzdjRiUzA1YkR6eWR4ZGw2S3dVaUhYU3IwNWdxY1hXcFloYnk1MWpX?=
 =?gb2312?B?cmFBdXU4RUFISEc1MGNNM09sdU5GMUxQYW42SU90dlZtQkRZdUlWcWpJUVAz?=
 =?gb2312?B?QWpwWkxtY1ZlZjg3bzRFcHdFZ1huWU5tMkZ3cWFMNTA1S1RXUXprMHZBY3gz?=
 =?gb2312?B?dit3MkdhdTRaSGc0bEhjUy9wMUFzSzZTRStNc1I0ckZwclJNb2pYU2lvVkh5?=
 =?gb2312?B?VzdsSkxGZjQ1elRwYTNqNnJxWHE4OExuU1lLT3hVUXBDck56QXBLTlZ1Q1JZ?=
 =?gb2312?B?SGUyYzJxUVR1OXAzaXpUTHVEQnNlOXdtZnFlcDFHSllLbU9mLzZuZDVzS05I?=
 =?gb2312?B?NmFMOEc4K3dFRjRRMDJOVlZKT01xOEZyVGxZQk45M0VuY3YrcVpnbHdEdFJT?=
 =?gb2312?B?K041RjhQcnhiUmQ3TUFMem1aZENFdUI4bzc1UVo1TFc4dTJpN3dYU1hUK3I3?=
 =?gb2312?B?clBYS2tIWkZjY2l4UmZWVGVVYmgyYVBhNXJZVlBwTGFEbnBoQVVFUjlOaEJs?=
 =?gb2312?Q?h0yi46vfjSMaTZdTwilh49M3KpF+Uo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OW52L0JHMXZ1Ry9Neit6cG9sSW95UVhJUzlGVG5WRkFLWjhCSTNUMmp4c3R4?=
 =?gb2312?B?TVhyU0R0TFN0bE5hM0xIMFVPbkFVaUpEeHN6Z1R2QzVRNU1VVHVveWlkVEtv?=
 =?gb2312?B?VklmZmloRGlKNG9XM1IvV2JEaU1RblBjdlFCbzRFUGhOeEc0NnhUL1U0UUVE?=
 =?gb2312?B?OXE0Mk9lUzJWY3VUZVM3cEFUekp0ZEdzdzJiUXQzT2xHak9TZkU5L3ByUVNQ?=
 =?gb2312?B?ekxPblVWa3prZzAyOUJuK0hxOC9uRjl3MllkYk5scTVrcjVhNThjQnFubjhR?=
 =?gb2312?B?ZHBVZWZXUG9Gbkg2dnhzWjlqRG11YUpGMlAzcDJFK09GY2FlSjg5d2Ezc01v?=
 =?gb2312?B?MUZsdnlFcWpxSExQMjNaZkZ1WHQ5MXYyVy9STTJ0TVloTFNlZW0yZWRoWEsx?=
 =?gb2312?B?VHl4MmJQK1JXWkd1NHVvNS9mN0h1Mm5WL3hvdWNuL3JQUlpydWlpNEoyblMw?=
 =?gb2312?B?bVZYTzRoMEFydHQ4aUlwZGo3cHc5LzhDRUY3RHBGSjJEb3pGRGUzZFp5L0lY?=
 =?gb2312?B?RUdKT2ZpUWJsdVE4U25Ca1lvcE5jMU0rcjdLbUI2TWdGOGordENuNmVOVE5n?=
 =?gb2312?B?WG1aUllrM1A4K2hhUS9RbUw5VzJDQkUyaloyNXRnbmJ2QWVaVlZGZ0RFR1pZ?=
 =?gb2312?B?NmJkaGlBaUx1Qkg4em5JSUxCRjVNVi94UmprWFk0dVZabjBOS1hTaTFKbis1?=
 =?gb2312?B?VjRvdUdCZWxhQzZjNExsb3hzd2kxbW5Uamk2ZjFQREpRdGFLWVg2a2UzRmFY?=
 =?gb2312?B?RE1ySjk4dWFPZ01OVzFPK0tZckxCTTVKb2k5WklGU3lUS2ZVS1gzamdnMUtl?=
 =?gb2312?B?cE1tQjZTeTdOc2FRdU5kR29tbDBnN21kV0g2aTFwMXluY0lpOWp1K3NKc2F0?=
 =?gb2312?B?dkFTci9zbi9LbXZVVG5xUDVBenpXejFmb3NPR2ZRUVppLzVWZ1JNcGVzS2Z1?=
 =?gb2312?B?ZG9CSzBaK3dsUDdwYm1tLzZCeXVlYkxlVjRhSjgwTjBrNjF1QlEyQW0waDlC?=
 =?gb2312?B?Um9BRGV2N3pMek1seVZsaHg5TG42dDJOS3FYdVhnK2t5T0lZSDFhbkJtL0xl?=
 =?gb2312?B?bkhJYUR3ZDhYdlFaaWZzZWtpYkZ1UFhYWUFKUWlPQytoSDJ3c0VXcHNXWmFL?=
 =?gb2312?B?ZHptaWtwRnhIVmJ3NTZGaUM4Q3RER2pWUmFZamZsT0dobmZub0tqSU43dkMy?=
 =?gb2312?B?QXhpRXllYmpjQ1hkZmFBeUFSdFdJbmJCZDNlTnpXNG5RbDBldHF4N0NuT3FI?=
 =?gb2312?B?dWhRam94R3BHNDZHY0llUFZ5K1NkeElHZDAvbzdTb2ZyT0wvV2xOVlM5clZ1?=
 =?gb2312?B?WkNKNmx0d1BNRjMzUm9mWE5BZXdnUlN3bjNRTWlRTXUxdU83R1VVSHNvU0lt?=
 =?gb2312?B?TmJKWTdKa2tyNEpEallsSTY2bXczalpOdExtamZ4aDcrSmsyaFdvTmtmQWZi?=
 =?gb2312?B?czF0U0xVVW1tbWM2M3lsZ0wrdnlYa2dXKzhNZ2VxY0c5TWRLcFAwV2hRWEhz?=
 =?gb2312?B?YTFIdXBEa0p0L0U3SEVPM2htYnlFbjZqbGg0c3J4empNMUZzdU5QVGsxMERj?=
 =?gb2312?B?cml4V29VTEVzSEZCL0JiYmtBdlJLU05wdlRTTnlmZE55d3o4ZnN1bzdURHZk?=
 =?gb2312?B?aGVsT1BTUWc3eEM0NGErdDVnSVV4NXJnUHNJbTc0MFhyQW1pbEFJZHovUmxU?=
 =?gb2312?B?dTQ0UXYrTG1LZGU0ZVJaM2tEMDRtMzJsWnlsRG0zM043UWpvQk9vWm9xNzcy?=
 =?gb2312?B?aHRJakJxZnlWdkRGbGZxWmo0TVQ0aXBZdEkxbFhVL1YwYnBzdzZiK21IeVdl?=
 =?gb2312?B?eEVJR1FScURsb2RJTERYaVZIL01HbFQvWk1hZktSZE1Qa3dxU0hBRUtybzBs?=
 =?gb2312?B?cURBQ2pkU0Y4L1g1bXpCUUc1ay8yYkFpNWx4bVZmbjczYVJvY3ZIMEdqeWVT?=
 =?gb2312?B?RGEvYjdUbE1pVnNueTRXZEJDWVZHWGExNmhvTDdEL1NZaFR4Nnd0ZjAzakgw?=
 =?gb2312?B?aHFmL3hINU4wLzRmSDF0dWRKY3I1Y2lKd0MyUGJFdUtHclQ2bW5RdDdsT2sy?=
 =?gb2312?B?bzZxVVF0WU13NVNwemFyczZWYjlheFBML3hpNklPODVsbEVWOWtWT2lrTHdp?=
 =?gb2312?Q?RwRw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36fe2cb-d25b-4123-b885-08dd90f1b790
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:09:59.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU5bg26vrmM89kcHlJDaa4UkzSLci38A6FtxR4dN5Q2yaNCEOjaYXmaExW8ufukNMWAHOWZT5wU+6mBKFaqeqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725
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

UmV2aWV3ZWQtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkJlc3QgUmVnYXJk
cywNCkFsaWNlIEd1bw0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFUtQm9vdCA8
dS1ib290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4gtPqx7SBGYWJpbyBFc3RldmFtDQo+ILeiy83K
sbzkOiAyMDI1xOo11MI5yNUgMTA6NTkNCj4gytW8/sjLOiBBbGljZSBHdW8gPGFsaWNlLmd1b0Bu
eHAuY29tPg0KPiCzrcvNOiB0cmluaUBrb25zdWxrby5jb207IHUtYm9vdEBsaXN0cy5kZW54LmRl
OyB0aGFydmV5QGdhdGV3b3Jrcy5jb207DQo+IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWls
LmNvbT4NCj4g1vfM4jogW1BBVENIXSBpbXg5NV9ldms6IGVuYWJsZSBQQ0kgZWFybHkNCj4gDQo+
IEZyb206IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gDQo+IEVuYWJsZSBQ
Q0kgZWFybHkgYXMgdGhlIE5FVEMgZGV2aWNlIGlzIGFuIFBDSSBFQ0FNIGRldmljZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiAtLS0NCj4g
UmVzZW5kaW5nIGJlY2F1c2UgdGhlIG9yaWdpbmFsIHBhdGNoIGRvZXMgbm90IGFwcGVhciBpbiBw
YXRjaHdvcmsgb3IgbG9yZS4NCj4gDQo+ICBjb25maWdzL2lteDk1XzE5eDE5X2V2a19kZWZjb25m
aWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2NvbmZpZ3MvaW14OTVfMTl4MTlfZXZrX2RlZmNvbmZpZw0KPiBiL2NvbmZpZ3MvaW14
OTVfMTl4MTlfZXZrX2RlZmNvbmZpZw0KPiBpbmRleCBmZTk2OGQ1YTIzOTAuLmY3OGM0MTZhZTU3
MCAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9pbXg5NV8xOXgxOV9ldmtfZGVmY29uZmlnDQo+ICsr
KyBiL2NvbmZpZ3MvaW14OTVfMTl4MTlfZXZrX2RlZmNvbmZpZw0KPiBAQCAtNDIsNiArNDIsNyBA
QCBDT05GSUdfU1lTX1BCU0laRT0yMDc0DQo+IENPTkZJR19BUkNIX01JU0NfSU5JVD15ICBDT05G
SUdfQk9BUkRfRUFSTFlfSU5JVF9GPXkNCj4gQ09ORklHX0JPQVJEX0xBVEVfSU5JVD15DQo+ICtD
T05GSUdfUENJX0lOSVRfUj15DQo+ICBDT05GSUdfU1BMX01BWF9TSVpFPTB4MjAwMDANCj4gIENP
TkZJR19TUExfQk9BUkRfSU5JVD15DQo+ICBDT05GSUdfU1BMX0xPQURfSU1YX0NPTlRBSU5FUj15
DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
