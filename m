Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE11DC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C5D880AD;
	Fri, 21 Jun 2024 11:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f9iwMTkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263838839C; Fri, 21 Jun 2024 11:29:30 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13A2880A3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igkoFyfEf5HPYqW6PHVcIUfVveLzKieu5dBA1gRjA16Z6W2E9rRPkgbHt3vG9mxz0MstZ+2cx7AoaCYmg0xqdjvH6aGmdjRvBqhZFBGz3dQymn+iD1rBlWon3TNnJhTm3aSjqaNc+hfWWJDNjVF87mk6ikCVe6E8jZc/RbKmaEeVgP8vi0NkUijZXyUDXhuXUMjnVnhuvHYgjFCIdQmhRZXP1yyYIAKB/A2pxiCt7oLIrqH2uaGwrJdpgi33K+hQN1qyfjTeoO240hzIfATgDzX3DpfJO/6XHAwjSdypvOXA1mzQyNEt2LLNRH+9yyCHFvHRdMqR4YQ9BB/Hidqgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onymyyv97rHJQ05ZNIxlvz0f5cj78YbhPeF6kxQmWIo=;
 b=TZBYdIfUM9HbyaSRSqWJIPGlIRGHYVfewg/GVgESmCqyecThgn2Ca2hMT0dFRgTk7h1APoCrrEbDMmkZ6h0aRecY5gFOGB61hJqcuO8DEccFMvLmt36o5kyvFslDGGnMrpvyy8bT9oHOfV4IeudACHKgvipevfBinOypWlntLLnfS8wEiY/rUHtz2IZaoKfYI/ITXP16FEIRu3wNU2/++V0Lfpf2IipEFtIuyOiryjpKQjoSmNvi6o7LY4cQwj3OeuHSK72Wv18394c7UUUic4ow5xZOIXMGRHNzBsivaQuXtGfuI2CYJhCio7tTd1Ux/9XGQqgxR98VZbPbpTel7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onymyyv97rHJQ05ZNIxlvz0f5cj78YbhPeF6kxQmWIo=;
 b=f9iwMTkvFShhXrAYX6/V3R+UClh7fkSp6mQmRgqY+BqVv52qFifwFI4MHjVIWmwOTQ3XdJfgq8ISZYSTJqWYYkePUjLg/50ZoYJOkVpYWZf5F9CLjLGujBne+Y4hrLc9qE9/Dzo+25vIXclBAksU6caO1/Lmv26qbHl/nQsrBk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8264.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 09:29:25 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:29:25 +0000
Message-ID: <b0380bd4-2754-4091-8917-aeb6cc57a531@cherry.de>
Date: Fri, 21 Jun 2024 11:29:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
 <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
 <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
 <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f0a01f-5d9c-491d-caca-08dc91d4a416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRrVmtOVHY5eTlmRnEzb2RSR0NZVEFDNUxWYmtJQkZFT3R2SUJDekJkN0Vr?=
 =?utf-8?B?U252eVdBUUtsd0hZTHRlVnFYaXRoY2NQb0NhNGc2cDcyUEd3NHR3MGRkWExo?=
 =?utf-8?B?MDFZbVh2SXlLS21SWG9ZK2U4aWRyV3BlaWRSSjU3U1AxUGF2MHYrUWN1RndM?=
 =?utf-8?B?T2Q0cFhId1NBZE5XSHE5dXZLVmlxRGhCT0NQZUNvZ1hOTlBPcjRvRTJYMjc0?=
 =?utf-8?B?cVQ5WmNWSVB2VUlxWm1FUGRSa29rOHc1YmtIdDhuMDgxdGJWU2tYSFhyM1Fo?=
 =?utf-8?B?a2pmTTdGaUdFdHlrRUhoZ2lWdzErUWFtREVVY2ppQVlBQzRBK2ZQODdYOFZw?=
 =?utf-8?B?UDhGVUdJemNWMlc1dVdlLzV4VTN0YUJIVHNlN1ViT3dwTDE4VklFL1dOZTd6?=
 =?utf-8?B?MytDL3R6N0ZUYTdQd21GQlQwQytXZkNpWmNQajl6ZnhxSVFOUkpUaVkyVk9w?=
 =?utf-8?B?V05IeTY5R1R1TVlnbUtMZFV6SW0xdlJrNEd4QmlYR1U2dUNsTkp6WldPVkxE?=
 =?utf-8?B?L3BjS2dFY1N5OWRCcDhQUWR4MkVZVHdlKy82ZFF1TGFsVDlVS2ZGQ1RLM09i?=
 =?utf-8?B?dXhYRUt5SlcwSzhxOEhsY292bE45dVpDcTBoTVhXVEppZmtjWU5zZVhXbHRF?=
 =?utf-8?B?bkw1NzhlWTVyWVlGbjA1ZXlUTEx4T2E0ZW1mQ1JITmx1R0VCY2Z2aHd3eDJP?=
 =?utf-8?B?MkJGL2dESlJWemJZV24vdDYyNTd4NFNla0RxV1pBYnJqbElnMGtVcENtNGpv?=
 =?utf-8?B?MjNqQitHK3BnQmR1YW9ldkpYTEhPcWc1a2EwSnc3bWxjWmhpcHJENXlXanBr?=
 =?utf-8?B?anlwSG1XbWNVQjNkQ1MvTGVmUThobnp0eXBqRHJqQzJMSFpmZXdnOUtqSjR1?=
 =?utf-8?B?R3hyMDdlUWRhU0g5YmgxcHVyeHJ5NitKM29oeEhITUZiQkVGZlNpVkJEZWJa?=
 =?utf-8?B?NUtoYkovMnk3S2FZa1Z2R1d4akpWVDZFQkc5NWdkRnFsRFA3TG5jQWlteWpW?=
 =?utf-8?B?OE5QYnFsZU5oUVNvaGk1YXZWR1V1REtPSEtxZm4yVmVXUVZYSXFOTXd5b0Vh?=
 =?utf-8?B?UzBWRm0vajRKaFV5UXNJM3NPSVFjcHRZbG5RbVNDVTROODZXYS9OcnRiRlZW?=
 =?utf-8?B?VzFNcnhRcm5nNGt6VWJhdTFaOVoybUp0SEZRbEFtd3FUcmRnbU85Rm56TjdQ?=
 =?utf-8?B?ZHBOMkdDWHJ6QnljSnE1RU1PaDRFRGVTNWx0OEhNMllBZ3F3M1ZiV0NLZ24y?=
 =?utf-8?B?RE8vd2lSM3prSHRSM1RVZHdSRzd2Y3A0SUlaMGZVZFlwcnR3MnhHMzRwNlR4?=
 =?utf-8?B?WlM2c2FoSUJwa3NNRUFWc0pidUY2WUdSakRrdGF4anpBQVFSRStwMUdnSDY4?=
 =?utf-8?B?eFNjVTMyZ1hqZ0lyVXJOc0hocVhpSjZpK2NZVnR5dE50RzNHZjY2eWhKOC9s?=
 =?utf-8?B?Z294RXJZQlZRWjZHcURPTktXMTgxTXNldkNVWjZLQXg1enFMNnQrNFZ0YmEz?=
 =?utf-8?B?T25UYlQxYm9FV0g0V0JuTUI3UTdhSWFnRFhnQnV5MXRtYU8vTVE5eUFQc3BM?=
 =?utf-8?B?NmtVdVFIak9DUmczSVY3aHdDUmVDWHFGWG9mb2NlMGlySGY3bk1rZzlmaStv?=
 =?utf-8?B?Q0Q2ZlhleldjS1ZXR3B3R3dhdklncmtTV1Q0a2ZXdzVwV0lQQ3N6ZEo3Zm1p?=
 =?utf-8?Q?1am36gGo3a9fl40hBiuJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(7416011)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVwNlVWdE5qV3VaRk0rZm5uQWNqZkZuTDRvdmFKQi9ZVXBtMUtwd1paQktm?=
 =?utf-8?B?Ym80Z1g1RDY5c1lFRzAralB5am5FV21vbEJkYUJDMlppNmV3RHlpOXMvQk5G?=
 =?utf-8?B?UVdtd2RwV1dGQ1VhRGl4bkNjQjdyL2hHK0JCbFpXQy9uK0NYdDhxQjJkcTQx?=
 =?utf-8?B?MUhoUURFZzk2OXZmTWRzL0xaQlhVcmw1L2xuNjduSlZxRVNhaCtValVpcDRU?=
 =?utf-8?B?ZUhvM2t4V3ZrckZzNFBaU1Zwankzb0VKdW9FSy9FMjVzdVdGeTR0ZHhoTTBs?=
 =?utf-8?B?bVVyekd1WGMvMmtDOW1wcGs5L2ZDeS8ySzhiVFNZRDJkWWNIRjNYSHdRMEJk?=
 =?utf-8?B?T2Q4a203SnpuaDczWVZVT1pjVVZYVDNLanNZY3hYWW5DVGlWS3gyNjg2Z1Rz?=
 =?utf-8?B?Tk1BQ1liVWx1U3hla0UwNk4wSFJZdnhqM0tGL0FRWHQyZExaQ0dRMHFSZUNj?=
 =?utf-8?B?NHd1dk43VHhtSUFDUi9CWDBDc3VzRForZG05QSt1Q3NyeWhQZXljN2J0UU0v?=
 =?utf-8?B?RENiQmx0eFJuMVNiazJQU01uMUZJYzZ1cmQvZTQ4bVZSSHdhVHlXNHdBdXp3?=
 =?utf-8?B?SFJaQ25mWVBCa0VGcnJKbUh0VzlUOUh1a0hub3BHRkFpUXFoaWY1NDM2dnY4?=
 =?utf-8?B?N1pjTTJYSDU4SEY4eVo1Z0hUMmF5akFGd2xTOWJTVGpHczdLZkpyNUExdlhU?=
 =?utf-8?B?V1pudStFU1I4b21jOCt2cGJQNGVjY3dycGRMYndweDg4Z3BFM0pMQzdaRWhW?=
 =?utf-8?B?R3JIUEU1dHBDZVZaOWZRVXd1bzArZ3RrU3BuUmJwa1pqQ3pNWStINUg2Nysv?=
 =?utf-8?B?aS9RZTM4a09mc0hRRWlGMHRQd0tOdVgyYjdMUzR5Q3JHaWZuNTRvcXlkWmFK?=
 =?utf-8?B?WW5HdGRqZzRHNnZ1YjQrckJCdXgvb2dEUmtPSFR6WTU4WXR6NnIrYVI0d0tp?=
 =?utf-8?B?bVlPcnduaThRenNNNjlTYzlia25qem5TT0REUGVDVW1Vd2IwazdVK0liNTdu?=
 =?utf-8?B?Ukt3S3BhYmdJMlVzVjczY2ZtZkdGWkZJeXh4ZngrQmowS1lvZlN5ci9iSzls?=
 =?utf-8?B?MjNMR3liRjMwMHc0ZDNxRTEza1BtcGRnQ0xjbEoyeGhkREE3SkFLeGI2NDZH?=
 =?utf-8?B?NzJZZUhSZFZzUG83bEV1YWtDKzB0enV1bWlGSkVERFY3Qy9XVVU0UTNFVWdk?=
 =?utf-8?B?MDNVQ2V6eklzQStseHJ2TnA0aEF4YzNwS1JQN1VJZVk4MnF5dzNsTk14WVR2?=
 =?utf-8?B?T1h1VzVzRkpLVVVsSkVadkFySnlKK05xMVFGVG9vK0t1WXI3M2JFUWt3T0Zq?=
 =?utf-8?B?RE1MWlNqbW00SUtISEdPdGRwdFAySVJJMGFka214TC9nc3I1WWFiUlJiWmNI?=
 =?utf-8?B?R0NsdXRUK2RmZWlsb3g2c1dSRm96eFZhanFxYVJUdXpYRE5aYnpkSFBxckZq?=
 =?utf-8?B?VVpXZmh0cEtmNHNiMXpwcG1PaVhySGs4a3JvcktTaDJKSkRPWnBYVHhrWUgy?=
 =?utf-8?B?T0tqLzdmYnpGdGRaZFIwZ2pxeWgvSUxYQlVPT2VFaE5XSGIyV2hkSm0xWS9N?=
 =?utf-8?B?ek9xQWt1NlR4YUJFUS8xbXkwUWFVUVRwNGZuakFVdGl0ME0zblJaMXBXblov?=
 =?utf-8?B?aXRKZm9qelZwRGRGTERiNE5hTEpwTnpMMGFYbFFyRXpyNWhYdS9iS21CQ3Jr?=
 =?utf-8?B?dERtWlZpbXc0b0xrWGVmL0lGUThlYWd3UGZYbUpIRzB4ZStvN25TcWV5UU4y?=
 =?utf-8?B?TjJsZlI3cDVlMGNvSkxMVDBEOEFieHg5QjZHS2hDM1J2RWxKVWY4dDFoUkxq?=
 =?utf-8?B?bUx6MCtkWTlhaDFqN1VjcjRhOWxURTF6T1lIc1FsQVBVOHNabGltNHVsbFJS?=
 =?utf-8?B?SXJXMzBQOEFpeHRjbVJreFFSYVFLQTdkWUVrbUlUZ0orU1JEOE8zWFJsMWgy?=
 =?utf-8?B?R2tUWG8xQ1FxampPS09aR211NVF1U1BHNnZ6bWpJMW9NeGtFeXcyN0ptVXI4?=
 =?utf-8?B?QXB4dURUdjNyR1h4VDR5ZTVsNW9udzJLOUxJd3psVHgzcXJlQ3dqTExRWFVU?=
 =?utf-8?B?MDg0Z0pUblVWcG9lUlBFaVJUdzl5WUFZZU1lZHgyaEhiL05VN0RGcGN2aFJT?=
 =?utf-8?B?bFFnbmNWcElBaDdzL3lVTzJOVmRla0FXbGhTQlF6elByekpNN2NPWnZtZkJK?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f0a01f-5d9c-491d-caca-08dc91d4a416
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:29:25.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJi5Sp69oCcdEnH8dlZjFy8xzsz/AghPxCmG3RgEIQT/hKUBDk5Y1gwKBJu3J9U1m+kGNnGpbTCkgluTRl9NgHPVzil/TiN6Cs+i8Hygs+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8264
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

Hi Peter,

On 6/21/24 10:56 AM, Peter Robinson wrote:
>>> rk3568 is now upstream, there was a PR upstream for this for some
>>> time, similar to rk3588, albeit not as long as rk56x. In some cases
>>> the issue here is the speed of review of upstream ATF. I don't think
>>> that means it should go into something like this.
>>>
>>
>> If the BL31 blob doesn't go into boot-firmware, I don't see the benefit
>> of boot-firmware for Rockchip platforms to be honest. Instead of telling
>> people to get their firmware from github.com/rockchip-linux/rkbin we'll
>> tell them to get one from rkbin and the other from boot-firmware. And I
>> have a feeling that if that's how it'll go that the vendor will just not
>> care about boot-firmware as they would anyway need to keep updating
>> rkbin as well.
> 
> Well it could go there, but I currently build ATF for all Rockchip
> platforms we support.
> 

That's nice to hear :)

>> It doesn't matter whose fault it is for not being upstreamed earlier,
> 
> I agree. There's also  no reason something can't be included and then
> dropped at a later time when things land upstream in appropriate
> places.
> 

True BUT every now and then we get someone who wants to keep using the 
blobs for some reason. It's up to us to allow this or not though but 
wanted to let you know that this happens sometimes. (not our clients, 
people from the community).

Also, it's nice to be able to debug stuff by comparing the blob and 
open-source implementation behaviors. And sometimes even if there's an 
OSS implementation it isn't necessarily featureful, c.f. crypto support 
on the current patch series for RK3588 TF-A.

Also, I am not sure it brings any benefit to remove binaries once they 
are in the git history to be honest, maybe in terms of checkout size if 
you don't bring the history (shallow clone I think it's called?).

>> the fact is, we still don't have a **merged** open-source BL31 for
>> RK3588 2 and half years after the Rock5B from Radxa was announced. So in
>> that whole timeframe, we have to work with blobs (or maintain your own
>> forked TF-A whenever patches are posted and hope it works well enough).
> 
> Agreed, the rk356x has *finally* been merged[1], it was sent as a PR
> around 2 years before. I have highlighted this to Linaro/arm in the
> past that this delay really isn't good enough.
> 
> [1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/rockchip/rk3568
> 

Thanks, I agree this isn't really a nice situation. We cannot complain 
the vendors aren't doing their job of mainlining stuff if we take too 
long when they do (baring normal review process highlighting mistakes, 
errors, etc...).

> The point I was trying to make, and I clearly didn't was. In the case
> where there's open source code do we want to include vendor binaries?
> 

Then I guess we had the same problem in failing to expose our point 
since I had the same one, would those open-source based blobs be allowed 
in that repo?

I would suggest the following limitations:
- blobs from vanilla/unpatched upstreamed open-source projects aren't 
allowed
- blobs based on open-source projects with permissive licensing that 
allow those blobs to be shared as blobs without sources,

>>>> FYI, the DDR bin is printing stuff on the console, so we had to modify
>>>> it (with a tool from Rockchip) to remove the gibberish breaking the
>>>> terminal by setting the appropriate controller, mux and baudrate (for
>>>> our products, there's no one size fits all :) ). The question is how to
>>>> handle this since we cannot realistically store every possible
>>>> permutation of that binary for each UART controller, mux of UART
>>>> controller and baudrate (the only parameters **we** modify, but there
>>>> are tons of others).
>>>
>>> I think those sort of things should be mostly quiet TBH.
>>
>> Mostly != fully. The console doesn't break consistently so I assume that
>> if it even prints a tiny bit of info it would still be able to break
>> stuff. I assume we could have binman run some logic to replace the uart
>> controller, mux and baudrate. Not sure we want that but we could.
> 
> Adjusting binaries on the fly sounds problematic to me. Is the process
> open or something that's NDA between rockchip and their customers?
> 

All I can say is that I asked this tool to be open-sourced to Rockchip, 
it's currently an x86_64-only blob here: 
https://github.com/rockchip-linux/rkbin/blob/master/tools/ddrbin_tool

Mark Kettenis has written something to change the baudrate: 
https://github.com/openbsd/ports/blob/master/sysutils/u-boot/rk3588/files/rkbinpatch.c

>> Also, the DDR bin is passing the console info to the BL31 binary through
>> ATAGS, so if you don't fix the DDR bin baudrate, controller and mux, the
>> BL31 will also not be fixed.
> 
> Ultimately we should work with the vendor to fix those so they're
> consistent? Why do you're products have issues, are they using

Consistent in which way? I didn't get what you were suggesting.

> baudrate that is different to all the other rockchip devices?

Rockchip binaries default to 1.5MBaud while Theobroma boards are all 
115.2KBaud so we are consistent across all our product base.

As for the controller and mux, each controller has like 2 to 4 muxes and 
there are ten controllers on RK3588 for example. Rockchip provides a 
reference design for each SoC but nothing prevents you from using a 
different controller/mux than the one in the reference design. Which is 
what our HW department has done for the three devices I've brought up in 
the last two years. I assume because we wanted to use the functions 
exposed on the controller+mux used in the reference design and you only 
have so many permutations possible.

I suspect that the other HW board vendors just want to limit the amount 
of work to do in SW and just follow as close as possible the reference 
design.

Cheers,
Quentin
