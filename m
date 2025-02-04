Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE316C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0476A800B3;
	Tue,  4 Feb 2025 18:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WsDyL+26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF618801DE; Tue,  4 Feb 2025 18:16:34 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727ED80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csfnleXqIklwC2dXBdrgAsWRQfGpDEPIzWkyYuaiBGOa/StB4OgdWfBa/YHdmyc2sJnJpiX9ilOnmfAAahbiPquV+KcOAAxAuHklBizT679brAJSgTC8yspIsiKnc99p8eyVOARoN5GMh6Uz2dXGMf7Ix7Selyj3LbZTf1h+wutn/ifvRVn71qApZvCm6Y5b4nxRc7zBqqUQtpwT+ssmKhKGhnuaswxGHRjc19UywYEs+cr5UWahsL8e43Q8lgWIkxGjfFcw/MMaKU9y3wx1oxA0zmkVZC9xnIYfp/Gwtb5Y1pVcnFaxyYbSGlRKqvwR9/Qt/X9+Vt8WvCLgomWNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g88JUFQlL4wxiIPpFl5nDykY6pvuC9VeUGkqfsVElgI=;
 b=CgXVPEUQ8krz378nrmPkCsLJtyDhTQzNCxAxV75AjZiyapULqD+XRbgWJFf0WUV9dO9mUoLE+VjXLVmiZxXaOemQs/KltOuMMvhqwIOec445I4E88IV496UdluzSXOHOr+eSN/xjbqhODICsRSTzqRpu+ovMr161yV+LjtCGaajWkIKkA8w1YcmdsMfj10ELCf77dnND7rlaSaowIR9cTCpfU6pBdKvqLbs/yg+pxryKEz5l3lZiZc0ixQ72oIcST1CRAgyi8EynDzQtkwjoivu8g4UuVnXJNZiD7/Gt1JD0wW+5y2ak1jOMwSPbFO33lhn4dLTUXqBQDRZznTkK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g88JUFQlL4wxiIPpFl5nDykY6pvuC9VeUGkqfsVElgI=;
 b=WsDyL+26F8dIpJqqhmb+UKo5ZuRn72jazQirQo6HCQN1/1Cvy+eGEl0Ymz5rBqTurj02Nm2k/o9ei7Zi46CPr+UN6c66zLxIkL5v3FOaApikqUfeoan9+cWUUUZjLopdl4aHUSHZ6gPcsJK7tc2MHgfv7ue/NJIIZktrr3ZKXxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 17:16:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:16:30 +0000
Message-ID: <2214c36a-f23c-4d37-8ec3-2f1049d378ad@cherry.de>
Date: Tue, 4 Feb 2025 18:16:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] rockchip: io-domain: Add debug logging for
 regulators during probe
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-2-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250128213852.465664-2-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bef5e3-a947-42f2-e346-08dd453faa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVg4M2huOElaT2JrODl2VUZid09rbmtKYzJXZzlZbnpURG1ubmE0ZFpHZ1RG?=
 =?utf-8?B?SXptYVk5SjNzZEVobjdET3dBbWJGYXp1VkhjS0hTaWREWnl5aWUrd3YxR3I5?=
 =?utf-8?B?SWVDWnpXTVlKN05yMUNERHhOVFI5TXp6RTR0ZjlEOExMdUhZbk1qTmk3UEt2?=
 =?utf-8?B?Z0lUSm8vTzhOVm82ZWZsRUhJZmZPYkVoZVYrMlNlUUVqM20vZFlVMjJpZDJG?=
 =?utf-8?B?RW5lSmc5NzB3L1prUWdpTlFmemViOGFKVnhUc2E5WnFGdEVHZjFCL1J0S3Ro?=
 =?utf-8?B?UHh1Z0J5aUE2MjU1eHlDc3o1M1daMytTTXRISU0ybURHT25ERDlHd2h1YkEw?=
 =?utf-8?B?K2orK25ac0pZSDhFMTJnUCtkZ09jTG5qaVR2OG5Pencxd1QvWDEvUHFBbEwx?=
 =?utf-8?B?UFJNMU04V280azBJNDQ3MVBSMDRRYnNteXc1UVJmYitaQWVXL3hwdFR6RWZw?=
 =?utf-8?B?QjN0OEJaYXJWQW9VdHNBU3locjJHVjdpY1hhLzVGUHpsYkFXSzNHZkVjNWZp?=
 =?utf-8?B?RER6WTZnOEMrUkQ4OEV0WEYrd3BwTWZKYnBPdWs4c2dYR3FObHlOY3NrbXRl?=
 =?utf-8?B?YkFWelpvN0FtUDFNOGo5MFR0Y0hyRERFc1ZlQTJGS2dadkhqU0FGWG1hWDMw?=
 =?utf-8?B?R1hmM3JFSlVsZXFudzBOUzg2N3RLTkt5RmRlSGcraXdZK29yb2xOUFRkOUlt?=
 =?utf-8?B?aFFIZ0E5cUdadjF4MngyUFgzZ0JRcDVPTTRrazRldi94Rm1TQm1sdEEvS1dz?=
 =?utf-8?B?TE9tVGpCY1VnWForUWlxdkN6R004aWJCRy9OcGs4SGwyMEhYcUsybktickhV?=
 =?utf-8?B?UXFBdXVpTkFZcEFHNHJoOGcwckZqWTFzK0VzZ1I3cnBpQ2pTSE5SZ3dIOGNv?=
 =?utf-8?B?OXVvRkJTVjk4K2lQVmFDZVpqN0QyczI5cktZempjYU1udFFKaTNWTFI2RTdY?=
 =?utf-8?B?R2hCTUJsdWg5enFweWtmUlFub3RnZ0VPaTJsQ3pES0hNMnEvamFEMDdwR3Aw?=
 =?utf-8?B?aG9DWWRiT3p3dC8wWmFsVnBmYnpLSUlBZWhoVVF5UVBRdjlab0Vld3ovWnIy?=
 =?utf-8?B?RFZxWk1jQmtMc3J2T3FQU21aWWVTZytzdm9Xa3RMZ3MxalBRcGxwSUNxWm9n?=
 =?utf-8?B?VnlhTmk2T1dhOVBvZDhpakR2NWtMSzNCV044QTVBYkpsR091d3NCbkVubitV?=
 =?utf-8?B?OGI1ZHAyaFFDamk1OXB1bEhobGswMnJaV2JYc1R0bFlOWTd2WVorQVB0aFRz?=
 =?utf-8?B?MTBzb2dWVUpjR09DSEUzRTM1b2RyQldrcmRWUXYwbGlIMDcvQjFqZEdheHBi?=
 =?utf-8?B?YktGYlBpNjZvbkl2S2JHWXQ1ZVdSdS8rWTFBOUZ2WGVuUEFXQ0drUGRodk5n?=
 =?utf-8?B?bDVqQTdEenMrdHRNbnNUNXlub3VWRDdCYTkxRVQyTTNwcDdzRm5mMldHZXdv?=
 =?utf-8?B?azhaanJiSEhvcWpFWE5FOU1HVTREZkVRVU9Wcmk2cWE0dXpPaDdXbjIrNzBh?=
 =?utf-8?B?YWNJcnJjYTJhR0V2WC9nWW1LWnNpOWl5WXdhRXFQNmE4RW95bVZqZVlGS2ha?=
 =?utf-8?B?aHVVcHJkZzBEZ1doc1hYYVNXRFR2RTh6ejI0UlRnS3d2bisxTlBUUDMySE9C?=
 =?utf-8?B?d1VXNWI4ZU1iUnQ5ckd6WHdSY0RmdGt3SWdKeVpMTC9Wdmczc0lMbHVmcU5w?=
 =?utf-8?B?cE5lTyt6TldaaFd6eW9vNWhRcG5jOVRYay9hbXg2UlZWUnpUZ0l0MkljWTR4?=
 =?utf-8?B?eUZPazBwWjA4WG10SEVEaU9mVFZvQWhOdnVRa1hEZk1oR2pPVEIwQ0Q4Q3Fr?=
 =?utf-8?B?ZWlYSDVSVVM0ak5ENk4wZkJmcWRYWHk2Z2Z4bjZrQnpxeXpDVEtxRm96YlBC?=
 =?utf-8?Q?mF1TNCVJ6RetI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVDeDFTMnplbU1sL2F5TTRWUUJtRURmcWNxWjZmaWNKMWxJdWtiYS9TQkFl?=
 =?utf-8?B?SXc4MERuTStRLy9wWmpGQzVKYnFBOVc4NVJzWXRnT0s1MmUvOTc4eDl3Y1Uy?=
 =?utf-8?B?VVVUdVFLcXYrZE9ndm9XRm9RUDlLL1E1NW5iL05qUGFoeFNYdU92b0I0Zk1F?=
 =?utf-8?B?RW0weWhSZUtDSnlCdHZOZzNuV0xlK05CRW5jQzgvZDhFMzI1MGREU0p0Tkp1?=
 =?utf-8?B?STBMaDk2UEtDSVBOakJrd1pWSmthVFpQVXdpVjB6aUZrSkxyYzUwNHUvRW5z?=
 =?utf-8?B?Tk5zNmg3U1YrU05od0JZYVB6KzhGQVE2VS84Q2E1ZTdwSWt6MkQ1NUVKNnBq?=
 =?utf-8?B?MEcxKzQwVkRKNkFIWXYxRk5MOWllb3VEUWVHWld4bjU3WEsyM3l6WUVRa2tG?=
 =?utf-8?B?aDVyMDE1c3dpOEhHZERoalFHQkVvZWZGbUtSdENNS0dYbzJMekVva1NFcE44?=
 =?utf-8?B?N3RCOW53ckIyeHpCTlhQeVh0YU9sa2hSeXNzb25FR045enhacjM3eXg4TzN5?=
 =?utf-8?B?V0VSa28yM3lNNjNkSGhQLzFBT3BxSkViRzFMTmFqNFZVRjcrcGJ2a3lpUlFy?=
 =?utf-8?B?ampjNEg2MmtyNjRvaklwZ3M0aFp2OUlWQTFVS3FkRmdMeGlLcTV0YTBVcmtZ?=
 =?utf-8?B?QU5xWVY2b1NKYk1SRktnWlYwamcyMWczNG1TcEQ4Y3JFSXArM09vcTRUZ2NO?=
 =?utf-8?B?RzFOODJIdGowb0szRVB0T210UzJQNHYyU0YrOUludThJc1RRcXJRK09mYWRR?=
 =?utf-8?B?Wkt4TExZbE93WFlvU05UYUFkS1g1MEFPMk1abEdXc21nRjVwRDFlOEJZT29x?=
 =?utf-8?B?QnB5L2V3UW5ocDJWTzRETHFnbnFqQXh3QWNoMzZya1IzSHhKcE9RUktESUJo?=
 =?utf-8?B?eDlxaWlIR1grSU83dkdXQTdTTFpMTnUxcU82Q0w5MURPUUU3Uy9YNk5YVDV4?=
 =?utf-8?B?TEdBeGhkV3cvazZPM2dIT1FvaEViS2EyZjlES0Z6aGRNQ2Y0M0owamxndDUv?=
 =?utf-8?B?Y25IcmJhK09acDVCek9qd2hRYmJRZGszam00VlFFdEJvLytPVi9ydmU0anly?=
 =?utf-8?B?ZWkxWjJIVjFmNU9XVW5yMFErMlppYjlFQXhUVG82SEFGWE1WVzZDQ0dLWmFr?=
 =?utf-8?B?dVZ6enliZ1htN0FrQmlBZ1RQOGlwUkxGT2NsTGJDNXpJaExRbHVPMWUwM3dz?=
 =?utf-8?B?R0dHSnNoYW9HenVhNWJpODFyaGJ5dHg0S1FlRDVsVnBmc29UelFTNFc2a2V3?=
 =?utf-8?B?bXEyd25oR1duZmRZZWtValRVZUNKQUdzVk52cjR2dHZyQjZvUG9NNm1BbWV4?=
 =?utf-8?B?UlQwYTNlOU40VlVBM21iWjQ3bHZIWEdNclVTMm1VTnVkMmRwWG94U1FFTmVp?=
 =?utf-8?B?aEQ0STVOZ0cxV2YxNHJzZlRraWxQOG5nYWJLR0lxZG1IZXQyck9RN2FCazF1?=
 =?utf-8?B?Sis4Nmxoc3pFQ0l4d2FiNTZCQXdkYVFDVkt2VWV6V0kyUGJFaUJWVzVFZGxs?=
 =?utf-8?B?UzRrQy9wUThVN25mM1JCOEhPcjZDaHZYYUJBblVJdGppU1VCa2w5TDJEY2li?=
 =?utf-8?B?b0xLQ29NNW9YSG1yVWJSMXZKcUdWMjBaUS9vZ2MycTJjVzJzcThacG1QODd1?=
 =?utf-8?B?bmQ2czRGYnNKWG5qZytNUi9ZK0g0K2hpQWR0b05DSnVMVWFrY2VYbE1XRkFB?=
 =?utf-8?B?UWdENUpIYzYrOWhCWk1HK0o5Qm01eHZzVVAzZlZRdDNGeDhQbTVYamJFUkwz?=
 =?utf-8?B?eXlSTHRpZEY4SnRqSEJhaUxNeEIvTU9pRVAvb3dGazY5Y1FJbnJrUU9OZm5h?=
 =?utf-8?B?WHFrZVIwam5GRUxmdld3ZENaK3JiWXF3N0FZMlZmdzYwM0VmcTB5QkJQNnJm?=
 =?utf-8?B?Qys1T2NKZUhxSnJBamZFa1g1RzMvY2VTcnBXektWMTN3bHJaL3J0YzU4OUJN?=
 =?utf-8?B?UmF0NW9CdUtESEJxY1JLKzArLzdzVlBkcytPSm0rSnZkTW51WERBSG9UekpJ?=
 =?utf-8?B?QkZSeGRYd1Yza0tnbzZnVGxnNjVYNTQxTjFCbG84Mkl5Slc1YVBjbTRsQXh6?=
 =?utf-8?B?d2luK3FPS1dtRkk0S1JEMkhuNnBTaW9wQ3ZWS1JWQ1hOcXhpMkpaQ3psR21N?=
 =?utf-8?B?clNpcmdhajBHdHVkS2JmS1lQVCtka0JjMGF1NVlYM2VvVmZaWFpNSzU3NzFT?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bef5e3-a947-42f2-e346-08dd453faa82
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:16:30.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FfQYCN9p5dcxHZ03xkcYG7TH49dDa5/8IgsAIBy39FqADW/6G3eoIxAACrm8+w7kvwrrwFCeCRhhUw179X20pQnw4Ji4NJKmEJIZRC6DrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
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

Hi Justin,

On 1/28/25 10:37 PM, Justin Klaassen wrote:
> [You don't often get email from justin@tidylabs.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Log the value of the regulators during initialization of the IO-domain
> driver to aid in debugging GPIO voltage configuration problems.
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> ---
> 
> Changes in v2:
> - Made added IO-domain driver logs verbose and consistent
> 
>   drivers/misc/rockchip-io-domain.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> index 025b6049a9f..fdefc9c5fe3 100644
> --- a/drivers/misc/rockchip-io-domain.c
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -5,6 +5,8 @@
>    * Ported from linux drivers/soc/rockchip/io-domain.c
>    */
> 
> +#define LOG_CATEGORY UCLASS_NOP
> +
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <regmap.h>
> @@ -344,8 +346,10 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>                          continue;
> 
>                  ret = device_get_supply_regulator(dev, supply_name, &reg);
> -               if (ret)
> +               if (ret) {
> +                       log_debug("%s: Regulator not found\n", supply_name);

Can you use dev_dbg() instead?

This would match what we use for other messages in the probe function?

Specifically, it could add the device name in front, which would be 
useful when debugging to highlight the IO domain device is the one 
requesting this regulator that isn't found.

>                          continue;
> +               }
> 
>                  ret = regulator_autoset(reg);
>                  if (ret && ret != -EALREADY && ret != -EMEDIUMTYPE &&
> @@ -353,6 +357,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>                          continue;
> 
>                  uV = regulator_get_value(reg);
> +               log_debug("%s: Regulator %s at %d uV\n", supply_name, reg->name, uV);

Ditto.

Not sure the reg->name brings a lot since this information could be 
derived from supply_name if I'm not mistaken, but I'm not too bothered 
by it :)

Cheers,
Quentin
