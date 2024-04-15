Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61997C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51C388195;
	Mon, 15 Apr 2024 11:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="joSmpNu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839A3874B1; Mon, 15 Apr 2024 11:02:15 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD1988195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtYWhgHXjA55kYYuNOXW290NMOZRv3ZiFbrlh/wbw9/+BVkuVfg4S8Jv2KTKy+d3hXYFISxT8X/LF8iybSS60qn2nzHEC+1d9tL+S+Mgc4z2TquKfWYXbF1j92v+NSqiLdXUPMU8DicskgoX5F8uT1pRVwI1Oq1hGtxEoa0ec4vY34QgpqpA4q1REoIzFU6F35bMWmFTUL4FwJtiQr+da17LgzdzsemZWFKSRuE7pMd8znQovwX/IQkvjQK6GvBEBYjFqDgMjsAZgHf/bWLaiG2PiGa3HyjzSVeaD2U7MAsbkR0N791FGcPqpF8KQ5589E5EIAvOnzywQsfalxUTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+st+p+kU5+u+mYN1vX6Y8T27yPnInaw8FqiVYp9mtY=;
 b=ddNjivAfbrFlgpD6FazhV9gRk5/7frn854ifbVxvmC6noSvXsr8LY8Fn8KTvynnHvWxLR04ZPcnKTjPBT9iiFBIwR9rBAGTeeSkjxUv8mjUeyVShn0dSgrLGsmj4NGufq/JfLo7Ngg1KrmmUgyNVNrl6SW006Wl3Q6LeBj7NahFb9J0Of65CP992tEHXu+oA40uF0KzPqepYGPkqSiy7lSHX764bH0CGYx/i8gx850B0+vZoF3JwSBj1Jl9TY+afXTuUCSKK0FcoQUwYES2IzgWfYxRLqqQLg3GFHDvNdmZ2O+oEykzJMrstNr9UO8o6w+CMd/2BRdHukZrinvSekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+st+p+kU5+u+mYN1vX6Y8T27yPnInaw8FqiVYp9mtY=;
 b=joSmpNu72v5KBf7ijnSelgt8AY7w7Jc5/MAMC1BkfDo9X7WNCmLSh+gAmVvw4zR7odAVbRpAEHRtxijN3JOji8q21/rqRDov3kkhQaGjfsFCM0/oSZ3nwYgpGM9HNLGr+ig2DUzHGWArI24eeACu0HeIzuNyo8Ox/hZu4l+23rZtWFuPOsjm2fsWybAMJstLVijzxvlZ05PbJI7LvgCzFQv4RNHOH5+pylPXVLSzGWh93AWEAEUl9yCQwl5xMp8mw+ujR2E48JCjzqA6SNXM1QDP3dQniBRLqNkCWkN6IoyN5Fn0rErCnZkNa1SJGTorhrNHI3fYdClhRAMUonfd8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:02:09 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 09:02:09 +0000
Message-ID: <1a0dbb69-958d-4ff3-aa78-9c2aeaffa9b5@theobroma-systems.com>
Date: Mon, 15 Apr 2024 11:02:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/23] rockchip: rk3588: Enable use of eMMC HS200 mode
 on a few missed boards
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Elon Zhang <zhangzj@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-24-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240413181425.1384357-24-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: c429a903-3417-4ddd-fd75-08dc5d2abb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVYWFozbHFmMHBtWlZPMy9zRjVEVVdwcXRSOE5odGt2SHRSaUlyU09wZ1BZ?=
 =?utf-8?B?SCtGU3o4SkFKeTl5ZVdCaUkzWkowYXVaNDh3ZXFmOFN1VkpoSVB4UTdtTW1j?=
 =?utf-8?B?SGJsODdDOW9HYTh1TUxDQUVwQkZURjJaWkdXYjRvd1lzeGRmUXZoK3lPTXpi?=
 =?utf-8?B?YXVpUkE5TmdUaEpTZzlxa0lPdE14U0xaMHIydXNzVFNkanJ0YlRmbk1mMDQr?=
 =?utf-8?B?Q1N3dHRmNG5SQkxnZUxCUzN6WHU5SzV4dllGZUhiYU9LZmNUU1NweFVrdHFu?=
 =?utf-8?B?Y3hPdHJ2WVd4eFFDSDBwWndjZjZKRkpVNFlUUWpFTXQ3U2dsczd4S09RcEFm?=
 =?utf-8?B?K3djRmQzRFZBdjBxUUZvcFo0NVJpN01uVEhpR0RWWHo0NmlDZW1sVHlVWVk5?=
 =?utf-8?B?akRaYS9YTUUvSmt0RmdiMVZZa2R4bWkzRjdMeUd5MWRhQ3ZhQXdsWGdEZWEw?=
 =?utf-8?B?NEJHZWY4a09iUjRPTXVPNm90OHNJM05aeGRyQ25hT01WNk9teFpEeUQ0RVBt?=
 =?utf-8?B?dmRkWDg1OGVtSDVya0ZjTmhaRERkN2Q2WEY0azVaUVkvcDJkWWo5R0pjMlAx?=
 =?utf-8?B?NjBSSlZsSCtDOTEybk1qd24yNjc1NlFacDA1MWs5Y1dNdnpIQzVkajJCZHJX?=
 =?utf-8?B?YXdHL3pHcTQyOWxjR1duU2RWVUdoWk5SVmNhNGlBZjVxYnpMcEJGNXc1Sm1T?=
 =?utf-8?B?WVJsaDFPRnc1R1pQU1NnQnJWNHQyakJQZmVWUUNyWm9uNk9aTTRJcEl2bUZG?=
 =?utf-8?B?L29rNWtKSENiUUlVWjRQalU0eXh5N01UQ0NMeU1oN1NuSkswRy96MjdQQVB4?=
 =?utf-8?B?Tk9ablJEOSt3U2NaMHhwckxUSFBqTmF2cXVtM01LZjQzSVZEZXZFSEFNMGt6?=
 =?utf-8?B?TTZvOGdXM1NodWxaeXB1RWN4QitwSTRBbFhwc1diTXV0QjZOSFNXVkl3UzV5?=
 =?utf-8?B?RmErUnFTSnhGV2ZGbEREYlFJcVp2aTdjVjZSaEM4ZVhiVk5QVjBwV0QvU3V2?=
 =?utf-8?B?dTlPQnBZYm43dFN4VDhPczBLU1VwM2I1VVlxcDFJVjRWNDU1d2xjNjVIMmZC?=
 =?utf-8?B?TUFjZmJXZXBQd2RxendFeVdVLzJ0ZnZtZHdmeHBFNzNCMzdqZ3FkeEtkQWJ0?=
 =?utf-8?B?WmlZY3FwK3Qwa005cXlYQXRGdTMxY3lDQmZ5VHk2Y0pZTnZwWlRZRlhRWG1y?=
 =?utf-8?B?cXZPZCs4NlRDdEFZYVRTU3QwTVZYdWlBaFhFeS9QdWJqcVMyNzBWLzhFZUdi?=
 =?utf-8?B?L0tVRXBVNW9oMERaRXBpcHA1YnBNM1owMnhuVjhvRTE0ZGNQY0NRbkhmWVRU?=
 =?utf-8?B?TTNjMWhaczd4TklPL1pnM2NKeDBsYjFnS1Z2T2RrbjhsczF2bjNCU3ZEekpm?=
 =?utf-8?B?ZmZzZ2RwU1NHRkR3TnQ1R3VxVm1IRlpPUXd3cWNydzR6dlRaNWxyekNCRGxX?=
 =?utf-8?B?UTc3eDNjOGxxUEwvQUdjY004Z2p0Tkx0M0RBK3g2VUVOaFFibENvQjFaOUpv?=
 =?utf-8?B?ZDU1SzZPZEJGblJaVUh6VWFpcHRYV2M4VXMyNndYeHQxSHkyRFMwUnh3eVJo?=
 =?utf-8?B?MkwvSnFPcjAzSmphQ0FUM1dsQkxnSTk4SnJHVDgvQTZMV21yM3BvWEl3aWNF?=
 =?utf-8?Q?naM+SXHQ30kPiDmYF46AMec2EsjJwIFqUUCeY5EV8Huk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2krRlltblo4T0lwcmwvSGlva1IraDhNYlN5cjBUdlRyZXoyY0tURnJvRjRR?=
 =?utf-8?B?NVFjbHNrUVJIbUlhNUtUaTRTcys2NjBnSEVHblNjY2RoMS9tNlRLUGl1QnFB?=
 =?utf-8?B?VUsxTExhN1dDcjZYVVVCTnVmcm5HSlI0VzA3S3JUbUwzNG5oQ0JGUElqRTRU?=
 =?utf-8?B?L2RmbC9jNVQzc09NdUdRTGIxcDVEcXhKQXJsYVRuT1k2NS9lbmhIdzJTNDZB?=
 =?utf-8?B?UWowV2pqRnZ3Rkp5MTFxWGxDeWkrVXdwY0prMDhLcWZnVlpPczcyTHZHTnpU?=
 =?utf-8?B?U0xZeGRoeldwM2pPdHo5Y3ZTb3d2OFZFV3lqOW9oK3N4b0RRTnNqcDJVVHY2?=
 =?utf-8?B?NGg1UGxDQ0dJM2JTMW9hMHBGM3A3MFJFK056WHZKNjZVWVVYeHJzVVlsWlZQ?=
 =?utf-8?B?ZUJqWjBYZ1NZcEFQekM4eEdiNGY0bmxRR2VFVll0ZSt5SjlUYTg3VUJCTWpG?=
 =?utf-8?B?N2JKS3BidTIvb1dQdFB5TFQ5SDRZdm9MUE1NN2d6b2R6WkFJVk9tVGsyaVJh?=
 =?utf-8?B?UzdqbHUzTVhjL1pMZEpOU1JsUGtvR0FlM1hCbmlOSWVja3Jsa05KcG5YZldI?=
 =?utf-8?B?T2F6UHF2aW5TR0hUeDFEMzRPaUI0YkdUM3hBaDBpRG85ZklTVEw1R0E2ZUhX?=
 =?utf-8?B?aFQ3UzJBMDluN2l6VlRYUVpKem1vN3VodS9aUDhCb1RwTmc1S3M3VnJRak4r?=
 =?utf-8?B?L1M0Njk5TmE2TEpkRDFSSTJZVC94Q0VKQXhoYzRIZnhYUWdOQXlQSWpDcFdr?=
 =?utf-8?B?OC9wdHlFSW9UMUVDQkcrTlBQY2ZFK0w0VHhDQjZvbGVOWU9UOW5oZTk2bGtl?=
 =?utf-8?B?UnAxM3padGdGT291UmZUQmZnd1IvSnBhc2RZTi94R21lUVJBL0FQRkVRbHg5?=
 =?utf-8?B?d2ZEQmJOZ2N4VVl0Qys0UzlseGJ3ajFKRUdMRC9UV3lXNzVrNkp1SXVzQUVJ?=
 =?utf-8?B?T0UrZWgxTmlMbzVQcVJ6Nzc5L3Y2eDRsKzZpaUlxRnliaUtCdWhnN0lWaGND?=
 =?utf-8?B?ajNqa2JjTXBtZHptOXZxb05DUlJKekJNQkRyYlVqT1B2ZFAxSm1zMGM3OUhK?=
 =?utf-8?B?a2gxV0JrandySnRvZ2lqbjNPbDZJZEJacnREdnRvYm1iUUdOak9hR08xSmNJ?=
 =?utf-8?B?WUNkV3p5UkoyRmJhNU5iMmFJU0RZWWVTbHN6ejI0L3hUb1JpNVhlY0ROOG12?=
 =?utf-8?B?aitTTVhpRGdEZFdMN3R4Z1JmbHZaa1daSWlTWDQzbFZJL1lLc0NMM0dkTkJF?=
 =?utf-8?B?bWNNYTNaeHhIWVVqeE0xVWxZZjdLN2lNaFVSMndlVHcyOGxoNmQ4Y0FzVG1W?=
 =?utf-8?B?TDkzb2pxcjBDNGk1aDhpMDYya0J4eS94bVd5aDNVMHU5N1RaVWwzTyt5R1Mv?=
 =?utf-8?B?WGtjTlVNUEJqMUYwS0g3OVY2clVWVk00U1R6TWxTVEhhZFRHWFlQbzdhUXdX?=
 =?utf-8?B?SXpHRkdhaFNiZUdjeEhjV1dWZEhwSkJVa0ozR3BCbUlZU2VpRzNvL20wbnZo?=
 =?utf-8?B?cjRESGtmUWVZNThiUk5VNlNoQnQ1NUUrdDN0VGJmZWxsd2I1WnBuSWwvTkU5?=
 =?utf-8?B?dWJYUk1aUGo4Um1oQ1JQZ3ZFS3ZwMkluWVFNcEdISWdva3dObHZmckllZ2dl?=
 =?utf-8?B?dHJFNTRaZEd4c0o4MEgxWmhHUjZKaThQTXptTjg4NncveUVvcmNLYTFaQnRB?=
 =?utf-8?B?RW9ROVBrZ2VyazZ6MStMVGxCcUVmaTVRdFVWeCtCeEY5d3VXT2g3OFpqSjNu?=
 =?utf-8?B?NDlRVEFyOU5sNDBtN0RuZlBZNjNPSFBaM05SWkg0T0dxUEJNUmdNUnp2dHkw?=
 =?utf-8?B?aks0b0U3RDRDNkVLa05VT0lQVVNLWVpDcUNNOExQZm1OZVRsbjRCaEU1OW9w?=
 =?utf-8?B?RjM3QzJZeVVHcVNnUmZTUVQyanRlQWt2MVYyWFFPYmtERHVoc0EzRWlENkhP?=
 =?utf-8?B?REYxMEhHYlZybCtDeG5Vd2VDTjk4ejRwdVUwUmYwRkdGQlBsSlUxU2Z0alVD?=
 =?utf-8?B?RG4ybWhXdHp0T1BIUUx6cW1WamJrNHZHSHRpRENVWUpIUlhSUVR2a3F0WXhi?=
 =?utf-8?B?Zk5pczU1UklaUjFhbERnUDBKRzViRkxreG1WUzRDZng4ZHJqVmcxcVh5ZzBU?=
 =?utf-8?B?VG4yaXptalJTa1V4NmVRYVR5MWdmUVlGeHh2V3VBUkZQWnJBcFZnSGRXZCs3?=
 =?utf-8?Q?Sfr+XiJION/C1jSllguvwRU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c429a903-3417-4ddd-fd75-08dc5d2abb32
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 09:02:09.2475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyK94USyVVRNe1YxVk2FVO+ADkf0a5lDUFfXyT6DVQ4uU/zZpMO1CQjtH8Z4X+O5TeCxr5szqBDcV7rtspSGCApavrKZtQPTjdYsXVtN45EzIx5+jdl/AwIGsBXa1N9t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450
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

On 4/13/24 20:13, Jonas Karlman wrote:
> A few RK3588 boards are missing a mmc-hs200 prop to signal that HS200
> mode is supported in addition to HS400, this lead to bad performance
> reading FIT in SPL and broken MMC write.
> 
> Add cap-mmc-highspeed and mmc-hs200-1_8v to affected boards to enable
> use of eMMC HS200 mode.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch
> 
> All these mmc-hs200 prop overrides may not be needed if the patch "mmc:
> Imply HS200 cap with mmc-hs400 prop to match linux" [1] gets applied,
> until such time this matches what has been done for all other RK35xx
> boards.
> 
> [1] https://patchwork.ozlabs.org/patch/1921039/

I think this is an acceptable change until we agree on what to do with 
that other patch :)

I'll abstain from giving my Rb here though as I do not own any of those 
boards and therefore cannot check this is actually valid.

Cheers,
Quentin
