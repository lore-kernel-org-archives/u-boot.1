Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F1C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CFD805E7;
	Wed,  5 Feb 2025 14:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KxtUE2SB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951FA806C9; Wed,  5 Feb 2025 14:00:05 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F15180562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8g3tDpNTrQfMU4HgljP5Y2OkDXMUW+tA0tHEiS2igc79H6cfLLA7Cx48br4vIU5BNzezYejDNTTTAsNg8c7we/AX6nPkGtRjbYOyY97K9rT73sT0AQg53ruXi/7dXBp9Tab/wG7ZYecWjbNQ3YGs0xrK/ErelyTiSY2EFTuNYaDyJUAzdR+FIUCsEFiLeaLU60HmxKvVrmcLss9M0lSNGRy9ZABvfETPKpVagwlyj/E2XsHgvJWvY+N6TqI5JkNrx59VnJu/WS7uKZ+MVFrOx9eLA4cg/BeNbsGS7yCX0Rq40J6ZkROtFZiMBU4fkO8bKuGrf2DMlpClNlWWuCQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH10MwEsf7CCN9Un46D8yQdOMZk4x7NU+pdfrOhXybQ=;
 b=TVg5uBwGW97ptAfLabYrJNjt9a2p6Y4jO3FBzYAa12vNjyGiuSETm/ToSRp1/kzMAWupAGy/7LPuVFLgwS796IfuL9YYhVnKIh47n/JkfqHeehy26Hf5/9cI8cnhJBU7VqJ0khdd/FLE6rweJj7RSN5oh9wpcEsxmGkFLQUdmkNUPtj56s/feeTdSK3AswltPtFTx/zbP4EFlAwi2HHuURZxZNOWjXvBsks0PA8sWKTHxwm5P9sgcaSnSMaLxoXv1Ok3VMEzwPaMoKvLDdKZGhwE30yTll8sSkI9mWGgKJ1SuRDpioNXrw9rwquvUwdaSxg4tbxJ1cGvfADIFdvgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH10MwEsf7CCN9Un46D8yQdOMZk4x7NU+pdfrOhXybQ=;
 b=KxtUE2SBe55lRCvaat/LMXKA2PE8W1W1Fsk9fz1ZhUZ0ZpBWm+8XA757pFiqkAd8yBTjLK7gVArYhjs0Ql+ORrmVhCAMfQ0NaI1q1Hxf17NHUt19C9lYAH7c6AL2OOM1Cw0WyF6J9hux8lWWnpN/+Q5EQYBanDULuEtNVU7DCh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9921.eurprd04.prod.outlook.com (2603:10a6:20b:678::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 13:00:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 13:00:01 +0000
Message-ID: <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
Date: Wed, 5 Feb 2025 13:59:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129132529.807031-3-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 618c7c1d-1864-4251-f194-08dd45e5001c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEhadjQxWFgrdHo1R3EyYVNuZWU2SDF6cTFhT25vRGtaOEY3OWJjTHhQRHNH?=
 =?utf-8?B?cGJrenY2TmF4aG9VSDZuRGdmUlJDdEdNYTVZVXltRkFGbkxYUi92dkl3OHhK?=
 =?utf-8?B?cmxNaHdQTHpKektyQ210and4SERLL2tkbkY0MFNIb2JTMFR1aGE0bjkwYklX?=
 =?utf-8?B?TXhUVmk1Q2VJNStYSjYzQ2tZWTlOeExrdmNEZFEreXZqOE5UL1JjWnVMeldB?=
 =?utf-8?B?YzA3aVplcExnSlJyWmlRRDR2MFordGIyRVoyN2Z0LzR1SUIrYURZT1hhRDVB?=
 =?utf-8?B?SGNwbUhIZE5KSmszODN6RGZBRGpzVHhiOVVZUHdwc0hvaU9YdGpoU1QydUpC?=
 =?utf-8?B?Ui8wV05GKzl6UjUvdy9nRnVmQWVhRjBudStpalVvTnVVWk5Iem8zR3J4YXRU?=
 =?utf-8?B?SEVmcXNJUVVYZkNvTGVxYWNhOGtOUCswZ1lvUU52UE5BZlNVQkFRYWxyU1c4?=
 =?utf-8?B?YXFtTWVQREJSK2pIQ1FMbDJUK3pwQ2NlUHd5MkV5bHJmcitTUVBDYWxXZURZ?=
 =?utf-8?B?THljdXBBTTVkNlZxK0RYNVYwMzRzU0JSRGpVTG9XcU1TUW9pQkdBdGh6NTRq?=
 =?utf-8?B?bzE5T29FUUFoTERnUUg5WGZIbzliS3V2US9qa0N5UU9xRUFRWUx6UDA1TnlD?=
 =?utf-8?B?dHdyMm92S2FsendTUENhRHpiaGVyZ2RTRytHOTFFNmtheGpnM1gyRnZJb0JN?=
 =?utf-8?B?V3dFNGp1RWdLdkhGeVpXR21IWSszbUdVc0hyYVdNcU1EMDVwMG0rSk9aQlE5?=
 =?utf-8?B?cFFORFYwcEY4dHBVWTJlV2lBOTR5SnBYcW9hSDVscU9JZCs2SmJHS2tRNUVD?=
 =?utf-8?B?a3p6ZlhzWWs3MExNWGtjcllEWDl1c0xJRlhrMGxOMUQwMkFIZUE3dkpBWG1F?=
 =?utf-8?B?SDVCa3hPWnBWZFZiRkpqbDhkOUdlNHFSM1F1OFAvTkZmc2J4QXpDSEpjVU11?=
 =?utf-8?B?WUwzVDN2c0RPNHJBNDZsbzkxYUhrNS9zeDR1RnpVaTN2aW1jNGxQMWhBNUVh?=
 =?utf-8?B?MTlGaTFKMUg3U0NWYTMyT3Q0RHBWRFBsMDhPNmtDVEFXaEdoZEtIRnR3RzBO?=
 =?utf-8?B?ZFVlQWl2d0kxYzNIbms3TnhZNHY4bFp0VC8wK0FWNmhNNHlVd3laUW0rQ3lJ?=
 =?utf-8?B?N0RYVm5Mek5OS0FYTGtWSkJOTWNhSXRQVkErSXhzTVk0enQrM2w0YlQxU0pp?=
 =?utf-8?B?N29VYVpQVHQ1VlFtbTlXemUyWXV0THRUWXQrZzhIcC9KS05UalB5VTFrUVJ0?=
 =?utf-8?B?YysvM2JrWVhkNkVCdXhLQjh3Y3p3RzAvQlJzZmlzbmZsbHFyNDVMelcwNXhh?=
 =?utf-8?B?STZzSWMwVUNreVhVdzYxcFhNRy9NdlVRenRHUVB5dXhmZ0VtaXZTT3NwR25H?=
 =?utf-8?B?aC9PbXFCSzVTenR1UVhsYmhZRjhmS3Z0bXBvaW9kVkVJT2tINDBZRzhOMmt0?=
 =?utf-8?B?WnlYOVEzZlVxalhLUllobU5hK1UxRGNaT0dISTFEVGN6WU55aDlHQ3l1clJL?=
 =?utf-8?B?WitIb3FtYTBja1I0RVZheXdwbnh6djQ5aVl5MGpFWVgvdGw2QS8zdGRyVGFx?=
 =?utf-8?B?RUVBOHB0T2xtTTBRT3kwdUU5QnJSV0o0OGd3Z09Xd2pRMW93M2g1UFh2R1lB?=
 =?utf-8?B?aklPa3VGcWpSWVdhSmJEZUhXTy9xdnJHU0ZzN3R6UDdCVmlnMUkvcUg4eWVz?=
 =?utf-8?B?R1VlRnRqVTRZUWV0QXBLVHVHWDFFWVRVVEVMZCtKNHQ4ME42aTV6ZkVIWFF5?=
 =?utf-8?B?cHpJak9Tbk1EOGRWcHh4dzl2d3R0VFk1eXZEZUZycFpuMWlzSm9YdGE4dGx1?=
 =?utf-8?B?ZjZYcGNSWDRVRXBMK1pMNFYrREU0VU5zYVFoZG1lTm1pM2tZSFdKL01TNGFp?=
 =?utf-8?Q?Tm8J+Jy/r+g9v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVQzZ2VGejdyM2dTMWg0MjJXak5PKzZ4bUphQlB1V2FRbEVQaTJaRjNEc0tn?=
 =?utf-8?B?WTJIRTJhT3VPc2ZSejJ1VEkvd0hlUUwvdURZa24vYVFVeHNnb3JzeGNJVklq?=
 =?utf-8?B?alVROCtxeFh4dEErak1aL0x4dFk0alowOWJQUVRVdTVqUTBSWDdFUkhDVXVZ?=
 =?utf-8?B?cU1tUUFqUjRTNERHYzIvVXhuczV2YWVMOWw5b1BReUlpbU5UektENWYwazJj?=
 =?utf-8?B?dHhJS0RRVXdiZm1rTTgvWFlKRXRndG0zWjBGbS9CajFrMklrWGJsSEEyOGNw?=
 =?utf-8?B?QlVLTHVSdlN4enRDYnh0V2wxSzJUOGRPZmZDNG5IS1psT0wyUm1mUnN0eWRQ?=
 =?utf-8?B?Zzk4MVUwd3NVS2xjajdDbXB3bE96M29WUVNqMHhYWWhZM2d4RVk1eTBxdW5y?=
 =?utf-8?B?SlpGS20ySUdUNy95VnZFNkIzdWc0VjRicS9zNkUxWGIrcVVVNjdkWlQ5djV2?=
 =?utf-8?B?em1HTzE3VnY4WWc0SHJ0SXVMMC9ndndROWtSVTVTSytoZEJFeENLL2U1bHBi?=
 =?utf-8?B?TklaK0wvdHpYYXdMenhabTZEeGN5RldKTTFGMmtZWFB2Z3E5YUxuYzhlZjhG?=
 =?utf-8?B?MjMzRG81eUM4clNSWXNRZjN1U1VsR1NrbEFOMWNmNVFYRUpQNWdneUZ1TTdl?=
 =?utf-8?B?MUphby84VlF6akpvZDQ1RmNDNE1wQ3J3NDVVMG9EbUZKbkhYZWtQa2pqZ1l0?=
 =?utf-8?B?Z2FOblRMV21aS1luUE93THVJWGtXOUNGOElyTHorOEtpSWQ5K2lZVGNkS2pM?=
 =?utf-8?B?NWNsYWJMTitDRG5EY0k1OU9vQTIyVENibWtPbUNXZ0cyVThob0VSUmhGbHRK?=
 =?utf-8?B?aHNyeTllU3ZMTHI5VGxNNld0UktlOHRIcWd6NkRJRlRCZElwWVE1Q1I2VTJ2?=
 =?utf-8?B?akxwWThPRVJ6blZUaUVnTXRHV3BMWFhvV1R6TEhPL2VWQ3N2eU5hZEtkcUFD?=
 =?utf-8?B?TjRkVWVBU2pqSFFuTVVkNllwZzZNZTFRSWNZUFF1KzQxZkNBWmZINGxhbWND?=
 =?utf-8?B?VnI4WTFndWJQODhOUDlpWk1oWjZrbElVQVBmK1hPVlhYendhWk9GTERuandC?=
 =?utf-8?B?K1pMdUFVc0toOWtrbGxLVHNkK2FUZE1pV2pJVGs5ZEtXWVVsblNrOTNWT0Vr?=
 =?utf-8?B?eVkxcFJyUFpJVW1HQXVGK0VOMzdxMHMwWmo4aG9tcVBORDRUR0ZKSXZiVEJ3?=
 =?utf-8?B?TVdhOWUvTVdFT0g4YXBjOVFNTHcrR0dHUHNGZWF1Z1FDQVNITHVNaEVnUVh4?=
 =?utf-8?B?MDRtVXQvVUFpK2NnQ2QxSWFaWmo2VmtkMlBpR2lKTWU5SXhJT2NhQzkwd1Bx?=
 =?utf-8?B?dXhxK1JiSkR3MGd5MzVKOWRDajNtQ1pacjBqUStJcjlvVkM4cEZEWTFMRjBQ?=
 =?utf-8?B?NW05ZUErSk8yV0R6TnZEYUMxOHdNWE1VTkt2bmVVcVhCYXdDUUFOMU9ySk91?=
 =?utf-8?B?MkQwL0tCMXNCdWo4U1krNEsyVUN0ZW56S2F0OERBZHAyT1d6OWZ0czlmZlNO?=
 =?utf-8?B?YUFIZ2N3UWFiTi9HbXQ4QW9Scy91YjkvSUgvUFNVOVd0R21VNWM0TXREVk1v?=
 =?utf-8?B?eklyTllmNytabXBTNHZlaDg1b2NWcXNubVBSY2VqR0hDbytDOVN6VlhKRVM1?=
 =?utf-8?B?cTNzeDZFRUFianZCbTN2V2Y1TzBtVUNHQ0NvcGZzbWJ6VHMwdUdsaUkwVlRr?=
 =?utf-8?B?bThyWVdHb0dGa0VaRFBza2l3RmpnUmpCMEhsYWRGWjJuMG1VSHkzSWp3VEZQ?=
 =?utf-8?B?S2MyVm5mNHp6Ulo1MVgwTGwveUdGOFlFVFk1czE5bWUzaHhtajYwVm80OG01?=
 =?utf-8?B?L1lLak1XUUdmOVAwYXg4Z0JtUE9DdFZDdnhyOWIxUmpvV2txa3IyY05vencv?=
 =?utf-8?B?Y3FCck41d29wOEpocTlmSSszQXBIbHdwVmU2bzc0WmlhN1NCSklUQ2U5bUlv?=
 =?utf-8?B?RGJZeVVYUHROeGNZTWRCKzVkTXdCd1N5cndVejNIVWRMMXBXSUxkeSszZVpK?=
 =?utf-8?B?cVZlc05oQWtTdDFEalFzRFlBVTVkUVFCbWNXM3pudVVIL2lJNGlsYVpwd2lO?=
 =?utf-8?B?WWtDbEhKY1pLVUlvdlllWk9EZE1uNkh1SUNrM2VLOFg3V2ZlQkYwYnRTT3Rm?=
 =?utf-8?B?NndVemhRcVluVzFxV1AwZ3Jud1k0QkI4NFA4MmpLWjBjZVkxZmZtZzZlblJM?=
 =?utf-8?Q?QRaDj1V4cPkiDMTsT5+rhMI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 618c7c1d-1864-4251-f194-08dd45e5001c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:00:01.0637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZvVYcSam+lrEz0gUN4LQgSIzxFoRaprgN09mpEsLRItUav+ptiRFx52YCs6tftlk0tzF6tkc5/rDcY/nZDnPzxK7OXqiZUqDmtooipLxXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9921
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

Hi Naoki,

On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> After adding the below configs, binman produces an error.
> 
>   CONFIG_SPL_DFU
>   CONFIG_SPL_ENV_SUPPORT
>   CONFIG_SPL_USB_DWC3_GENERIC
>   CONFIG_SPL_USB_GADGET
> 
> binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
>     in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)
> 
> Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
> 

I'll be frank with you, I have no clue what's happening :)

But, it seems this only applies to the SPI image (disable 
ROCKCHIP_SPI_IMAGE and it'll built just fine). Why? No clue.

I've never liked how the simple-bin-spi was built because we should be 
reusing artifacts from simple-bin instead of rebuilding stuff. That's 
why you have /binman/simple-bin-spi/mkimage/fit being a blob, because we 
want to reuse the fitImage from /binman/simple-bin/mkimage/fit but we 
didn't do this for the other ones.

Can you try to revert your patch here and use this instead:

"""
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi 
b/arch/arm/dts/rk3399-u-boot.dtsi
index 70f35b6c197..0a5771b706f 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -45,9 +45,15 @@
  			};
  #elif defined(CONFIG_TPL)
  			u-boot-tpl {
+				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
+				type = "blob";
+				filename = "tpl/u-boot-tpl.bin";
  			};
  #endif
  			u-boot-spl {
+				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
+				type = "blob";
+				filename = "spl/u-boot-spl.bin";
  			};
  		};
  		fit {
diff --git a/arch/arm/dts/rockchip-u-boot.dtsi 
b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e50..fea49eb3145 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -187,9 +187,15 @@
  			};
  #elif defined(CONFIG_TPL)
  			u-boot-tpl {
+				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
+				type = "blob";
+				filename = "tpl/u-boot-tpl.bin";
  			};
  #endif
  			u-boot-spl {
+				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
+				type = "blob";
+				filename = "spl/u-boot-spl.bin";
  			};
  		};
"""

This seems to work for me on RK3399 Puma and Rock-Pi-4 builds with the 
symbols you listed enabled. I also believe this should be "better" than 
what we have today.

If that works, I'll send a proper patch for this :)

Cheers,
Quentin
