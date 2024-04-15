Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F9EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92FC088213;
	Mon, 15 Apr 2024 10:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="UYbEUgNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A11788216; Mon, 15 Apr 2024 10:56:45 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A428820E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzvkjop23+Qgs88MGwb5pAXJZdlCuY1fYlRiVUhprl1SftT4ZWcih5FCurItq2eWE3PcUs7LrcMz+o+RsohFwz2oOBkZbMBBedFVwOAZL2tOyVY4pYHjuwIrYSa5YT4QOsxIdJTz21oL0mO2lFbKGf9hNEp4vaA/9i8JzFPFFwrZTvm6BrsTN8CBLuVcye/2AQpqk7K4KjzM075R6dhhwDWhS4m2V32xrONNp5uBqECu+uOmWDvu8CxoSyTRTjRePdrEtJtmRE+OW++jKp+94IzMig6c3rx9vblkV56bMrh1x392Wt2bwHUf8Le0OW7SVY+osbn0QbToG1mN0MJuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2NZkFZl/LBVatMdRjkaj1u6SRxdIg8U1AO5wRved4I=;
 b=dfvnzZYn9IcUyz+NwAYkuK2n/FsDnLVto63hQAMwAw2gCvhOi52unVfBOjLqrEfZZeR+WOhuAb0FbltEwgCX4iUXzpxg3e98SX/dGZxyHAOGyzNdjoRE+UyZJOGH2d5VfU3zw5EzhkOwFRoPGB0bPYqXhnbK1R1BKQLuQmdWYHm0RSqXvFDgNxJYo/ds3S2vfu1STVA46cPeCqe5l7wcK3ITylXgKfkOis1jr8FS0RqTjwMpD8pM5tCsCnuKzKrPPibwoD3N3shyitCLuQHWUX5m6MeNRB82DyiEIEEXQif6UIm3jLcQkLj13E5LZggRnjdOn3H7S8yTNAtBFg9BJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2NZkFZl/LBVatMdRjkaj1u6SRxdIg8U1AO5wRved4I=;
 b=UYbEUgNAwZs++vzODkVI4/nCwV0jm1NM2Fb6YYEaSy5iyPag8wwz3lRbec1Sr/BUbJcF2HFRdC9itARGsEd21DhUzvzti6ZmPTH8sh9LHrMQ11JUT2Bld1wkWSlEM0PkY2Hh60iOIEmtMVTetJVIAqCfcMjEqaDpNCpd6EGkjLiF9Z+UL9MOoNiZJFMG/snoh0bCMcWYOhW+qU9NeXHEWEXQtmx7lAx0tLEKqlzLtZX8ZQXVUuHUo+WHYEnZ6DQVOmhOiFyepXZk5o11Zh+TOs4UftTyHE+qyul+uf5H+wwIX3bjQ6J60N8Z0hNnniZPymlzXoarRouaErkBsElgXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:56:42 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:56:42 +0000
Message-ID: <ad8440ae-d02f-4b02-be58-a37369f3eb52@theobroma-systems.com>
Date: Mon, 15 Apr 2024 10:56:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] rockchip: rk3588-coolpi: Add boards to
 documentation
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andy Yan <andyshrk@163.com>
Cc: u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-15-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240413181425.1384357-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DBBPR04MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3c7139-9d5c-4852-e8a7-08dc5d29f890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3GDc3jC53gbP3oVFJL1bzOJbHZZjjPs12wAo0t38vxodIGa6rEWxjPrxOPN8B4FUJgri6JaZk5BIE+JHXl7Ut+QoV2iLALBtYe7Ss5uHL6uLArV23/LbDlApatKkCPPPUyFxTSG5NH1vHwmbKiWHBfImF5FobAyTwRItHgXE5oxPAqfXFvcKpAmsMSv9HMyj2n9wclSyOe7F8IGR8lizuQwiBunFzSvwrXofd6ofyJwu4R3DbTGMjTAY7NZdmqcMDoBV1OCbclmSHxxCYwa94s1EILLNNmm5T5TxbyMMAunDDfpbzU9lHs8mqpG7XUArcZoe5D3aSPx1uIoCqGMVSdQK7bEVU6cs/H+xRmRErUjlxoxcMGsZsJoa5FoGUwzlMIQ8U68NnS2puLSTMwjCf366MpoxkGUJ+GdQ4PspNNDKNj4OZQhKWVtu5bColRrRffhl34ncHXs1oHlu2qE0tba3ubVffeMdLhrI7VpeEY8FmLSsL9QGim1ux+VftnjSXd7ZgXJmjx969jt/+qKhZkNpDJd0GqVbbcHH2ogbmturBwb3dJqZs2TwD3MHM7hURpCjn4UCGM1UwHz4fw+J1s3eDOOACZNtQ4PrPTEF0xVVv/VwYMJcgm9WQeaTOUD/8lIDfNYlVuWzuLR3cai4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFBYUmpQb2prbUxQWWk5WEJnYXN4dTR5WTVGZlMweDRMZ0VlTnlyd2haWSs0?=
 =?utf-8?B?WXBqa0pUVkFqaTdRd010bnQvck9lMytPY3l4bGJ4MU9HTlcxZ2k5QjFZK0pX?=
 =?utf-8?B?bGp1eFNwYzNhUkNPY1RqRzdRMS85TCtScU1TSDhPWWxSbXVmR1l5REhoRG1M?=
 =?utf-8?B?bFMwMXN4Y21iZlBsVGhMMk10QUNDaXI1UUp1STdUYy9jZzRDY0VSZUIzSm1Z?=
 =?utf-8?B?eFJRRVdHQzJPd092cW9uMUh3Vkc4V2psVU90d0s3NkVzY0NtanNMYkVxcndy?=
 =?utf-8?B?QlJoUlN6czlwbm11TEpKamNWRW1vdFV0NjEzSHc4S0llalM3cDNyU0xwL202?=
 =?utf-8?B?Qml2K1lZMW1hUWU0ZWZxV1lJZzJpUEFoYXJGK3J0S1haWFgwZzdTSStVenl1?=
 =?utf-8?B?ZWFUZUFVbE5LZnFKMXhlZStoNURqLzRSUHhQeE0zZm5CN08xK3NwbmlvL3dQ?=
 =?utf-8?B?cjF5OVRKMU1NbzduZGJVd2ZsQW9hM3M1bnlIVnNhYTN4dHI1VlQ0Q3J3ZVpG?=
 =?utf-8?B?ZUM1dE9zaXIrTzk3ci9MVjAyUW9wa0FTUG1CNTlOK2wvRlNXcXI2RHFMZWFk?=
 =?utf-8?B?dzZNSGN2YVNxTi9ZOWpRSkkwL0pwWGFkcmpRVkFyNjlmTUwwVmNPZGoxZkJk?=
 =?utf-8?B?ZWphWlhud2lTSXB1RSs2blh3N3QrUi9HSWxFK1N3dHFqaUIrZ2Q0VTJ5N01m?=
 =?utf-8?B?ODZJNkt1YWZ6ZmRYeXdHZ3JOUi9nTEliRmhzWFBYdzNNT1o3dVdwVklnRHRP?=
 =?utf-8?B?L0R3MnNGU0JMVnhTbERuYUJnYnZ4QWh5d1lnai9xbCtDUTI3bWdVbVNaSEJG?=
 =?utf-8?B?cEZYakl0d294Wk50bStscFFLYW83ZjJaTjJrZkFVTkRYeXJnaVo4QlIxQW94?=
 =?utf-8?B?L3ovZnExeEcrSWRkZXluQnVGWitzRlBZNWc3alZKT0RkL1ZyZ05hUG1Haktv?=
 =?utf-8?B?cnZKUEZVU1Flb1BCc2dsb2VNVlJOV21kUVNHYWkra3VlMm1UYkdySGQrS3pM?=
 =?utf-8?B?UFNaU3I2UFN5NHArMDJXbVdkcHppYUdaUVEzaCttdDR5d3RBdmpXLzRCZk95?=
 =?utf-8?B?WjlERGxjKzV3T0FxUVJkWmxsTGdacUdzL1c0QmRMV1Qzay8zQWcxUVlwdVRV?=
 =?utf-8?B?M05CNXlpbGkvcVEzS1FCVWV2QUJGWHM5R0h5Mk9vOUkxZkVIbkpmSm82UnU4?=
 =?utf-8?B?MkpuM1h1WDRGQXlPZEJxbzBKTmVKcUxSZkYvMm9ldTVuTkszcVkzRU1jSW04?=
 =?utf-8?B?MjAzeU8walRKY3J2NFJ5S2dLSTUrQVdjWFl4YlJsajJYczRoQ2VkZzUwdVQ4?=
 =?utf-8?B?MndmMFNRb3RFaXkrQ3J5Y3U1MU5pb2psMU9QVWFLUUN5VEdqT3BndXA1OUtt?=
 =?utf-8?B?bXJocUVVQUVtQ0VXNzdldTJaVXZWN1prak1wWGZGbk1BZi9ON29LNDNNcmd0?=
 =?utf-8?B?emczbnUwcXlHbGYwa21VUG5hRWpzWkpJS1ZPbUdCNUZUVUZjc3QxQ2xKTHVF?=
 =?utf-8?B?ZVRCMTNaWERsaTBHaDVzTHppa3FBMkZYRlo3NzFXbnhhSDQ3VklTZFM4cENx?=
 =?utf-8?B?Y0Joa3VHZE1XS3hJMTdObE90bGMwNWllUzhBK1VNbFA0T0FZMXFUU1VrRlcw?=
 =?utf-8?B?TlUvSjlMcmludnlOcWxsN290NXNOamNpdjl5dSttMUIvcnV0N2VCQ281UVFn?=
 =?utf-8?B?WnpIVTB1VXNab05NeU5Pdnc3bFRkRkZ1UEVNVms1eUpZWmU4YnNVNHgyZ1ZG?=
 =?utf-8?B?N2RaSjgzYUdNSEhTaTFjY3ZmYkVZckk4N1FpaFNVTnNucWpjU3lZVDA0Sm13?=
 =?utf-8?B?RGpFNWJWMVhYK0tzNlczbFA2U29lOTJnRDRNQWU5T1RRV3dQc1RpZUlPMXNL?=
 =?utf-8?B?ckhGYUgyR253TXZxMzFwRVFCSkxheGxBL0dhRy9IbTROMTM0UHdVU1BaZmhx?=
 =?utf-8?B?OTBqV0tXWHdhZDArSUZMeE5kVVlNYlQrVTEvVSthNjJqMjdISWk5ejU4RXRk?=
 =?utf-8?B?ZjMrWjdOaDM4d0M5dG9HaXc4aXpRRVV1RVlxaHB5cXJsYVBEMDRuVnhCb281?=
 =?utf-8?B?aUFGSWhQaFRqTFRGUWhSNC93QVVYYVZtZzNWbWtPSG5aYlJCS1Q5VDJ5cjVw?=
 =?utf-8?B?dzZsK2VsK2xKeEZRaUdWc3lhYUNtUXd0dDRRZkRBTGJ6VVFia0hVTkltUDRt?=
 =?utf-8?Q?URBEud2XXg6HziLnFbsssfU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3c7139-9d5c-4852-e8a7-08dc5d29f890
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:56:42.6985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSm5xS+YOFiCk3FLqjd2TZap5EgGYb36eGAz0izmIS9OI/Odd5Lr1ZXptMDYnvS/m14NhvTe1MAC0VbEYAzbhfw5FUVO3sdGucfF01Xv4kO9KsdA9WByJpiCw9FN9LrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025
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
> Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.
> Also fix .dtb-file entries in Makefile.
> 

When one needs to use a list or say "also", "moreover", etc... it 
usually is a tell the commit should be split.

Here the changes are not related, so please have two separate patches.

The sum of changes is fine though, thanks.

Cheers,
Quentin
