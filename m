Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F010DC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BF98186D;
	Tue, 28 Jan 2025 06:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jEAEOTDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E90981870; Tue, 28 Jan 2025 06:14:11 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C57812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkRMeqt1fJLTPC6XGnPFY9CaKrULCcLVs5ly4JdG0vzyKBqiN9nU1dcC7AnWE9RGe49yCpdo5NcpKe5kn/rAP5gbZSz/jJt/1M0UJI5QeNbN+LWHI9Tcso4b2q2R58xIpaZVZCPjjFFOxMq/SXIIhU2R0c8XCmuUN+MvApsD99nTKqrTY0WsZXMbSrePLWkBjFXDDFBrMzYHRu5BDPa6V5+RgSVX5bilf0gektLQyNa2ol/rjoan/xkFfYbgqU5GqZz31F6R4/56mxO6doY5hYzUn7hwHg4meJ1MeEQFJNyQ9ydCEEcpdJTap+p8BfpBipS+Sc1YEy43yZqs6TLQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgQrcXEFkuafuqen9ewNQCicLbhaUTQ3QVyLVlqjHoc=;
 b=Drw835uivDRRhlSKns9hyrhmYfT6Sfamgp1HaSWUZgKB+iFLFTZLfcIsT6ZvFMXk7UFTJUkK8evDGQbWAjMz9CZH2pcahYxMyUHoD7Vzh7UohbX6YFEp6pG2y/bHA4Y90y5PVPvzbkrHL6LfpzkfPhy6XzQXgUHOMsPqJMIr7fGk72PGocDcDksoer3YHpTlunCPwiyw/Wh07SQ90eIq1WVe8kltj0n0sYY2O3h3EhbxDsIb/iNPB8DzV7oKPpX6CI6knfNoiE9YnWe8W5hrB8l8vDqxJw4IorimyKJcoQLrWj4j9dov6grWZiP6RPFeo+YQOevcnhFrtt5gtDnevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgQrcXEFkuafuqen9ewNQCicLbhaUTQ3QVyLVlqjHoc=;
 b=jEAEOTDsJkK9Hfvl/MrueeQf6kRPVfD1N/zZQP9smlFstJWv2ekCwTS3xK+uIdMW0wsHKB77A3159PmK/QjfnSmubZchJEZ0D1IOpXJBavVwUoo5ptQiQ+5kY2dMJFvnLYFcjkzpl/gSYyy0+8y5Dgse1MsSgJN14czyKrmWDq81a3OgZIrtzJLC8qU2GgLmGValjUgtreJ164jKXtY9q+vmso9INnARCy8DfHlOH0rv8/WZHCEKmCVyEzba5nBTk4gDK29kcC7SoFXFM6nixLjyJxkLbCarcAjMgQR+takttaPkT/CENWe9eYuu671X3pd4NkGT2txCkAJHfcsQmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by GVXP195MB1807.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 05:14:04 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 05:14:04 +0000
Message-ID: <23a92c96-106c-45d1-99a5-c74138016517@phytec.de>
Date: Tue, 28 Jan 2025 12:13:57 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ram: k3-ddrss: Add support for a partial inline ECC
 region
To: Neha Malcom Francis <n-francis@ti.com>, trini@konsulko.com, bb@ti.com,
 s-k6@ti.com, marek.vasut+renesas@mailbox.org, sabiya.d@ti.com
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-5-n-francis@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250127142217.1757300-5-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:802:19::36) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|GVXP195MB1807:EE_
X-MS-Office365-Filtering-Correlation-Id: b735ada9-4f62-418b-2fb4-08dd3f5a9530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGJ2NERvcDN6eXlXWTNjY1VNT3BoMjljcFBhQXFSTVhqOTBQQ2JhUnJVZUhj?=
 =?utf-8?B?ZHNDd3p5SGVlVkgxL250MU9WK0VXemQxT0tsU2VrR1Q5dklNS0NKZmliRUoy?=
 =?utf-8?B?N2U5c3NPaDc5QXhFQnE1NElYY3NSQmw5NWtJSm9TcERjRStuc25RQ3Z3eEtU?=
 =?utf-8?B?V0FFVU94YjBNTkhPN2VUNlVtdWVGc3dCZmFsSU9mUG10YVh1cGFpQk5CTi9z?=
 =?utf-8?B?eE5TQWYzQ3ExdVA2clA1MU03dmc1aVpMZFczVThkMEVIb3hTNTF1S09JTVJ3?=
 =?utf-8?B?a1NGUkk2Tk0wZGV5NlVqM0tqeFhqb3E0b1VLT1QrN3JqVFdiTmpPQ0RLUnVD?=
 =?utf-8?B?SzFST2U0bXRHOVR5a1NUc1gyZGZJYVZZakdQTlhSUjlSTXA1YWc2WFZKNWxH?=
 =?utf-8?B?ZXZVc2Vxc3JuMVEwaTYyK3NzWFpPcXo5bjBsa1VZd1VENG1aUWR4SWoxTHFQ?=
 =?utf-8?B?cGVjaEd1Z3VwUjNKWmQvNVhCOTdSUzk2Mm90eHBGZlc0WWJZNXVOcmJBN3Zh?=
 =?utf-8?B?dW1XMGJYNXVYNTU4czVXbzJaMTYxSjFrVG9mK1NVKzJGRndWUGZ1RWtMMHd3?=
 =?utf-8?B?QitSTm9wRElDNGl0ZGJLdlVWYXZXUTJ4Q2EzK1dxRXVidFRJMEcxYkxHT055?=
 =?utf-8?B?QjZMdXZqNEJxaXVhL2ZHbk44d2xrTXJBS2dva0pEU21GcUorY0djWDlKMkI1?=
 =?utf-8?B?N01MZko0aE55Y2xxQnEzaWtNaTVSWjd6MGhLU05iOHRLVjRpVEVhbjNaU25y?=
 =?utf-8?B?cFdIdEZyNzNuSU0zQ20xcEJ0cHlTbzhzVG5naGF1UnUyeUhnMkhCREQ3emND?=
 =?utf-8?B?dnltYUJDMEpHcGQrbWhRVlBRSzNOc2tpdXNoa2QvVTZ2YmtBMGtiWFhDVmZO?=
 =?utf-8?B?QS95cHpBOUwxUFNmMjFzWnYzTm43V2RIRXcvSTNrQXpEbVozUkUzQkdjLzZM?=
 =?utf-8?B?RnVpU28yYTFnSlVOUGY0OEJlVTU4WFYyS0NlUXY2aC8rSWZnUXBIUDNSbzYz?=
 =?utf-8?B?b2k5VVNLVXB4YnVSNmk0VGw1bjBZMjZGZ2puWjV0MVhRSVZraDg2QmMxOXZ3?=
 =?utf-8?B?RERnRnJMVnl1MmRCeWZzd3pHb0xmN3RCRXV1V1RyK25URVdFRHpidHJiQkE1?=
 =?utf-8?B?UWhtMktPMkp6ZnJ5SzlvU1BjV1JvRENHaDRaM1hJSWFCSlEwV2hCOHEvQzFu?=
 =?utf-8?B?bzIyRGthZlFQNUZESEhNTUJFTDlQbllFbGYycXRnR2UzUFRSZzM2K3MrY01N?=
 =?utf-8?B?dlVDTUI5UHlCVEtZTi9UWVFhMDA1UmZlalFLMEM3K0lxYXBaMHZiMWoyWkhz?=
 =?utf-8?B?NmVOdFNXem9jZFFjdTVRTVNTaVJtUi9Lb3R4K09vcW52STRYYzQ0elVXbXlW?=
 =?utf-8?B?L0RnT3BmYkluNEJJUkNJZXh5ZHViSU0yMzhVejZ6OGd3OXoySGFHcVdyOE91?=
 =?utf-8?B?RFVHTXYwRFBJUzc1Ty93a0VPK3IvWW5VVC9aZzRFUkV5WlBLUzRFeEhFQnBv?=
 =?utf-8?B?b3dBeDVZTU4zb2k5R2lSaklUYnF3SUJSQUpiSENPVTlNTWprMjNaMTAwRm1T?=
 =?utf-8?B?dmNkYk5hUStaWmt1WVF2QU5NK0RVTlVKVmZlY3ppRUNRdm8wZWJZUm9yS29H?=
 =?utf-8?B?WUJsSVplQ2ExbHNjQUFsMGF6SHFQUThkUGVQZHZvRVdnL3RwZ3QrY0xXbjhi?=
 =?utf-8?B?VzBWbm1XWW4wajdTNnZvOXR1RGtyWllyQnFLQXQ5RzdLVFlCQ3VNSXhic2pz?=
 =?utf-8?B?MXE5M0hzVnJZcWtLT0NLSXhjK1BBSy80SmRTdzVMUDg3cmFqT1RiOGtHN2c5?=
 =?utf-8?B?OHdaaDd0RGZqQ3hySk9IZmx5Qmpkck5DRGx0MXdpVld2QVVIbzJEbU1GOVhX?=
 =?utf-8?Q?LijMDC5mILT5X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpYSVo1a3lLVEJQbWdkYlk4cFE1YlBmSjZnMkN0M1NLY3Bad29ZMnY4ODlP?=
 =?utf-8?B?cWxYUnY3bHhaUHBHRHByZW44c1ZXRVZmdVJOMWJ0bVJUY0lkWGtJM0o1QkVw?=
 =?utf-8?B?NGVYT1JWeFhpalRZT3NJNGVtMVloNlZyVUJ6bFpTRWRPelVyQzdUZHRsVS8z?=
 =?utf-8?B?SnVicHJTS0pUY0N5MVM0VEd3MmRnRGZWTHNHSWY4WnJxaHlMMHc4VFlWdU1S?=
 =?utf-8?B?NkdFZXBnMmllYkE4K2hlRG0xcDlsNkl2T1Y0VS9FSC92ajl4ZTZCU0s4WHpT?=
 =?utf-8?B?SXVxS01EdnpMcEJWZTd1eEtGSndncVpIL0VPYm1BQkNPSHIvS0dtdy9QQ1Vn?=
 =?utf-8?B?a2Jib1ZqTytzYVlqK0w3L1ZMUWFSejRya09yYVI2ZUhRaWs2dzhNSUljY2lm?=
 =?utf-8?B?eWRoc0lOY1FOOEFrV041a01qS0x4S3BCZ2ZENmVtdjhZWXFZc29IWjdTNUl5?=
 =?utf-8?B?MlVjTFlXdEh0ZnIvTEtuc3drYkR0aUNCVGpHT1JEYS9ndlhkaHdVWVZIQ2tU?=
 =?utf-8?B?cVdGdWtuZHh4c0NZMzZmcVo5M0J2NGJDNkNBbGIwLzhrcDRhSmRNdDY4YzdG?=
 =?utf-8?B?Z3dlY1hHS01SakJKNmNGbVV3Tm1IMG5zQnVGS25BbHIvdnFUN2hWRVdLQWh0?=
 =?utf-8?B?eGZIRFB3akJHWlRaZ3puNGlhTWFSWGxNQ2FkZmRydFFaRHUvM0NtOW5VT3hB?=
 =?utf-8?B?ckFackN5YUttUWwycDNVQXFwRlRRRVg2dG1xSmVwZTNyQ2xobjQ1VW5KN0J0?=
 =?utf-8?B?QzgyM21WWmlGRTNRZDZORGtxT29KdzVTcjZCNTBjQ0NpUFdZcjBYWVpXWEdl?=
 =?utf-8?B?dTRsQjI3RXZOSGNsV09xeTQxangrWjVTRiszdVA0V2FhU2xUZURuRms0WmFM?=
 =?utf-8?B?WEVNcHI1TXg2TkRNVmZ3Uzd2dFJWUDJHb0IzVk5qcS9TRUtveGhhV0NWOVl2?=
 =?utf-8?B?MHkzaVNOc2tHb2Vmc3VJeWh6bnpaM2Qxdk9qdjZtNUgvUitaNnU1R0pEYUFa?=
 =?utf-8?B?MTJib2xjSjNJZDNVQ1lrNm4xdGxNbndSTEV6QnFiemNPVXkwdVFJZit1QTRM?=
 =?utf-8?B?dmo2SXlRMWxMbTBTd2ljb1hyNVdyRCsybDFXK0oybm1GdURhVGpDcTB1dnov?=
 =?utf-8?B?R1ppR1VxbC9CQUwrQjFnM0tCeDJoRlM1NXMxdTFSQXN1SWRJYjJ3MXRPUEEx?=
 =?utf-8?B?VVhicDVzcGVCTWdQV0pLNW5MdEl0THFyeGxZNkhxRGVTay9INjZTQ0d2bC9K?=
 =?utf-8?B?TzJuT3dtTitlWW1LL25wUm1DU2pKWW9RZnltR3diWTlEeVJlL29UT1FZdGRB?=
 =?utf-8?B?SUJEUk9MZ1pyU3Q5K1NRd3ZqOThMTCt6WjZjVlo4S09nZ09oc2pubzVTODFQ?=
 =?utf-8?B?SlpOeW9jZlorR0ppMW9YOWpmd1RpY1hBeHdPR3Yrbk92U2U3MEwzRjZuTlB4?=
 =?utf-8?B?V1IrN002SkpiaTZRbmtYSGcrTWo0bFMvS1ZwMEhtWG1PMGFLUXNhR0VPVHhQ?=
 =?utf-8?B?eWtLQlNPajVpVFVjY1g5UWhETzg1T1lpTnNxMEhDelN0RUx6QkhYbjcycjFu?=
 =?utf-8?B?UE9saVdETDBROWdIMUJyZzloVUJSNGk0OWtOeEs4bWZ2bVR5YmdCU1ZlUXho?=
 =?utf-8?B?ZW05UkRZKzNnS0R5UVI1NzdwR3pzMU14WTR5cEhVN2x2SmNoVXhqNHVDa1BE?=
 =?utf-8?B?Q0dnOWlnVUViT3FvS3ovbSsyQUgzTXdPKzdUNXNtRXYybW9zTlJldGpvRDlJ?=
 =?utf-8?B?cVBvdTFrZlBYQmpEQXltSGpkTENJaUdUc2hLQVl3dU02US8rWkkxUnVaK2RU?=
 =?utf-8?B?VWNuazlZMytSSGM2WmJQRHRocnAwQldlbUVBdWZ4c1I4ZUNIU3VrclQ3WHNz?=
 =?utf-8?B?aFJlaDVyb2VkMkpzaXhVckE0Vm01K3Rhd1A1bUpPbXBRWEt2aEJKYmtORDh4?=
 =?utf-8?B?RVZVZXJhci9GRXl5aVVIanFmNzBmZkZjWHFSdk5adHFuY0hHS3lXK2FSd01H?=
 =?utf-8?B?Rm9qZXpIKzNyTU82MWF3YTVzdnB2bVFwYm5ldUdBZm9ITVpzYURyY3NFM3d0?=
 =?utf-8?B?U05LUm92bU00Q3U3M0o3MGZkamQxRlJaMHZQaEV4Q2hVWXIzM3BaYU5kVjFm?=
 =?utf-8?Q?8ilf3kWyss5dzYIrZuOrH5+6k?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b735ada9-4f62-418b-2fb4-08dd3f5a9530
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 05:14:04.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQwU2/yZK4yDjMHqNz0EoPl8I6x2WnCtJFfWxHD0gZYb6/NH2G0i5Fpstf/F7I8gEceZiAZ42dMeTKrWbOrLxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1807
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

Am 27.01.25 um 21:22 schrieb Neha Malcom Francis:
> Instead of defaulting to choosing the entire DDR region when enabling
> inline ECC, allow picking of a range within the DDR space using DT to
> enable.
> 
> It expects such a node within the memory node, in the absence of which
> we resort to enabling inline ECC for the entire DDR region:
> 
> inline_ecc: protected@9e780000 {
>          device_type = "ecc";
>          reg = <0x9e780000 0x0080000>;
>          bootph-all;
> };
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

I'm not sure what went wrong, but I had difficulties applying this 
patch. I had to use git am --reject and manually resolve a few blocks.


> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 52 +++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index ab46098adbf..ea2578cda58 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -149,6 +149,7 @@ struct k3_ddrss_desc {
>   	lpddr4_obj *driverdt;
>   	lpddr4_config config;
>   	lpddr4_privatedata pd;
> +	struct k3_ddrss_ecc_region ecc_range;
>   	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
>   	u64 ecc_reserved_space;
>   	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
> @@ -711,6 +712,30 @@ static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
>   		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
>   }
>   
> +static void k3_ddrss_ddr_inline_ecc_base_size_calc(struct k3_ddrss_ecc_region *range)
> +{
> +	fdt_addr_t base;
> +	fdt_size_t size;
> +	ofnode node1;
> +
> +	node1 = ofnode_null();
> +
> +	do {
> +		node1 = ofnode_by_prop_value(node1, "device_type", "ecc", 4);
> +	} while (!ofnode_is_enabled(node1));
> +
> +	base = ofnode_get_addr_size(node1, "reg", &size);
> +
> +	if (base == FDT_ADDR_T_NONE) {
> +		debug("%s: Failed to get ECC node reg and size\n", __func__);
> +		range->start = 0;
> +		range->range = 0;
> +	} else {
> +		range->start = base;
> +		range->range = size;
> +	}
> +}
> +
>   static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>   {
>   	fdtdec_setup_mem_size_base_lowest();
> @@ -759,8 +784,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   
>   static int k3_ddrss_probe(struct udevice *dev)
>   {
> +	u64 end;
>   	int ret;
>   	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> +	__maybe_unused struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
> +	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
>   
>   	debug("%s(dev=%p)\n", __func__, dev);
>   
> @@ -802,9 +830,27 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>   
> -		/* Always configure one region that covers full DDR space */
> -		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0] - ddrss->ddr_bank_base[0];
> -		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
> +		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
> +		if (!range->range) {
> +			/* Configure entire DDR space by default */
> +			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
> +			      __func__);
> +			ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
> +			ddrss->ecc_range.range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
> +		} else {
> +			ddrss->ecc_range.start = range->start;
> +			ddrss->ecc_range.range = range->range;
> +		}
> +
> +		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
> +
> +		if (end > (ddrss->ddr_ram_size - ddrss->ecc_reserved_space))
> +			ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
> +		else
> +			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
> +
> +		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
> +
>   		k3_ddrss_lpddr4_ecc_init(ddrss);
>   	}
>   

