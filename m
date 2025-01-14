Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06296E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AA580657;
	Tue, 14 Jan 2025 15:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W/Jr3m79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9ED806B7; Tue, 14 Jan 2025 15:39:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586948060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2BAkgQRpxZGovARiQcb+FvSMrNetvSbe+VhPkAScDtQDuYUH5VKqe183NoAdgJG9xIyaumgAKZaflNyKoRggGOXs28XFHeeYp4wKazJpW50RrLkEuvP9LTDWroOwDbWaP0JGr1JJyMtgZ7pv8Ei5J1j2H3cTDT8RMkXaZC3qh82rPgkbDLaE1SZWGZ1WByLkCGVkWcIwRw4Yy/9OmIiUIYcRKtKFs7gQqdt/cfatLG23Vy2dtXgfn5AWsOaLZ7WHcnM+NRUXqiM39JUaUpfPOOivNg46vjQOiovKq/wy5w9lHrfum27BPCGZ7PE2u51FYkDykHMbPGabgKxVq/vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rEsw8ekeG82umTYYjeMyiWMJY1cDhOx4Rnn6Wc8O64=;
 b=Jp+fQGXygfbdC7CE5/w9YqoC1LNd/lTuCYs5jSko/Q0D7/Fk8S8ncXNm9FCr3PcGZNkjN+9ehUmLe3+oH5fNUCj3mxliW5YoN2Wg5xDK2nm3VgJp8/DnWTqlZFDuIm46cw+aZWzlRCL6xS5xvTle/LHcsyGx3kpqi6Ck1lmlF6ALJr9oOwuztvEZW2pOn3hXRAjDRZbLYctZM0m10cRxK6t78j0n22VRfCAk7MzOw2NKC1XpVo8rDeZ0fFxKKqYdPRvXiuOw7xqgH9bbDlaYKBOVI7P6gK+UHuIeG5VTC5pBVBJNXOSFoHoLl9nGiw4eAYV4NbLZha3BTqx7y0KKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rEsw8ekeG82umTYYjeMyiWMJY1cDhOx4Rnn6Wc8O64=;
 b=W/Jr3m792ZK2AK/DABkjTriGPmpr7FD+fBThGHFN3Li8vIVbEFS8/Ca0pP2Uh9rN5TdnJI8R5CGBfDrZcsfD6+Zp+IsjVhdYv1g28sVr9ZWwErffApUZKOWmMl81O86IHTP8hveGkHW5+NCMKC2t574KDC7Ay7KgritnxXBpGJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10089.eurprd04.prod.outlook.com (2603:10a6:800:227::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 14:39:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:39:43 +0000
Message-ID: <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
Date: Tue, 14 Jan 2025 15:39:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10089:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e57d9e-b857-465b-d2da-08dd34a948f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkZJZWV1clJQaG45MnFIbzBGYmF6RmFLZzcxQzdZL1g5S2VXb2ZsVThjV09z?=
 =?utf-8?B?aE95MXZxMnJGL215YXR6azd6ZUNFWFlnUFVvRkdkQ2hzR1A2bTZqQ3JQY0E0?=
 =?utf-8?B?MHpYVTFrSnBFWnM5UnA4eUNRMmlhdDhGSjBJbHhuMGVQSWtEOXpJMlErU3Jp?=
 =?utf-8?B?WnY3WXJScG5tdm9LZ2Zma2UzWktTWFY1bnk2dFIvWHJ6VzdhZXRIV0p6dnNS?=
 =?utf-8?B?ZmdqWUlBZ1J0U291NnV2bk9idTQ2R2E4YWpKbmNlcS9IeTVldllpb0trVFRk?=
 =?utf-8?B?dnBsRHVCZWRCcWRvWGJLUlVhY1RmMnN4bkpoQnRuSWp1M2tEelcrelc1ZzVi?=
 =?utf-8?B?T0szTDJEdEd5cDhqTXBicE92Wjc0Y3Y3ZHI1T215cWZSTU1iT1ZBNEE1SVcy?=
 =?utf-8?B?MXBZeVppdjRtSkk4cFBOWENTOVNtdVY4YmVjaUtZZVBKZGVOLzZlV2V6QmNn?=
 =?utf-8?B?OWthaC9KTENSL09wbFZZSTBWOXV5N3lNTVQrQVF0QkFwb3ZZd0p5UVpWM3J1?=
 =?utf-8?B?TEZUcDM0bUc0NWxubXYrRFI2SmtXR0g0N0dVT3FYUVV3bndIZjcyVGZJTGdO?=
 =?utf-8?B?K0s0cXA5ZWJEVnA3b0tUdnRXZ0dlS1l3NUZZR1dEeWE5WHZqREJTTGFBbXgr?=
 =?utf-8?B?a3JFVi9UM0N5cWZQRXhKaEdUWjFEMWFjT012ZEZUa2tsYzkvRmUwQ2ZnUkNC?=
 =?utf-8?B?Q1hIVXNrVVZlQzRCbFY0dW1xNnNDUUt4WlZ1eldvc0NZZGd4di9zZFVZd0sw?=
 =?utf-8?B?M3NjeGN5MHY1MWo2SnBxNlFHYW5wZDVUY2tOS1RNOHpWV2ZUN3JyckNVM2k1?=
 =?utf-8?B?Y3Rld015ODcxU2Y5N3ZXY2c1WDBOQStMTWhDK2xjdmRnbEJIQitNV3RRL0Fy?=
 =?utf-8?B?ZXhFMzVwcWxCZWhrVVVXRnFMUzBmeWhUOGNSbWhnVWlQeXhIUk9WZHNLK205?=
 =?utf-8?B?d2lUU0FnU3BnUWMwUmVUdzVENk5mM0hzNmp5QTh5Nmx1bTB4Y3pKdnFKRFUr?=
 =?utf-8?B?TGVDQU04blhxVXVERU16NDlaSGVGRDQrV0pPeGZCR2FscVJMdGFTUzB5Nmp2?=
 =?utf-8?B?bVBsYmlGb1lkdDFYdGRvd3d6U1F4WW16NVozbGpDMGk0VGlHUmQ2aWZoRyty?=
 =?utf-8?B?TGtET1krcXlBYzU0UWNWWGhPUSs3TVNCSFRNZWlTYU5DcjNlTWtGOGNzclNl?=
 =?utf-8?B?cS9kNUlkSWY4cEczSnhDYXdVWlllM3hXYnlpdDArQ0dBa2dZVStKbEZtcHpo?=
 =?utf-8?B?K2pHVUtDNzg4ZVlaQWhEbHY2d0YxMkRXOGlPTnk2TUxIbjNkcUtmbUIxT3Iw?=
 =?utf-8?B?aVZPUVFYdkpuMjNGTHF5Zzg3S29wdDMweUM3VnFqZ3lRSStaL1ZScE05SHo1?=
 =?utf-8?B?ZEtLUjFSM3J5Zkc1eHF1S0owY2ltSzhQNEtVM0ZzaitQN0hLb3lRK1lJVVlZ?=
 =?utf-8?B?SlREbkdBeUlwdmx3UFZEVnV3VldJMm5aWTdSU0xqN1FEV0xSeStPNmxUOW45?=
 =?utf-8?B?OVZMOU80aCt5UEV5T1JVbWJRV0FQME43N3ZmUmRLdGJlMjQyOHdsSUJ3TjlY?=
 =?utf-8?B?d09BNHRISlZWVmtJUWlOWWN6anpYem1ZdWhMT2lZd3FGYmhzUGZIbS9tMXNL?=
 =?utf-8?B?VWJWNzlvQTZmUE1KWDhTY2tVQVUzbmtpTHZEZGdSdXNJbmJ6OXhKa242MmFz?=
 =?utf-8?B?OXEwbGUvSU5uTno0WXZDelNFcDd2ZDJHUmJoMnFLVEUrK25CSFdHd2MrUFZn?=
 =?utf-8?B?NVpJcEVPYlFaSXpNWGVtUmIzRDRpVDcraXcwenV6Zzd4UG9wam85ck5rT0Zt?=
 =?utf-8?B?eWhVK3JCZ0R5MDRWbmlLbS9sU2VuVmR3R3FVenRIZzAvWitObW0vTEViWGF2?=
 =?utf-8?Q?zmG6CVyr4KNfx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtQeW1MVUJWbGx4SWdjb2xmSFBLTTZyNFVuMEIvMEVXanBxZnVWV215RjZz?=
 =?utf-8?B?cHVjcnVUUVQ1UFI3T3R2aFVhMWJMUEQ2T09ocitUdmlLZ05RalNjTFdRN3Nu?=
 =?utf-8?B?MzhMdFNyY2Y5OGRHcituNXhNU0ZtaFNJbWFOZHlYRGt2V2xUZXorK21obHlw?=
 =?utf-8?B?OUdlaU0rTEJhMzA2N25SQjRJak1sRFowcGw1U3VFV2xLLyswSU90YURMU1RS?=
 =?utf-8?B?cDQvdXFTdmNkS01HUStHZm0xdzRiRmtGRjhOaG9QbHlnbDJLZXNKeTd0dFMz?=
 =?utf-8?B?T3FmbDRmaHNXZGFUQ3cwdUxLQU52bCtKTXlMZTJNMGpBUGVWTkhzNEJFNFhU?=
 =?utf-8?B?Z2N1R2F2bk1mWmIweHZNVTZwQ3dPN2JIbFdtMXRVZFQ3Tmh6UVB3Zzc1eXNv?=
 =?utf-8?B?WnVjVzh5Q2NxSFRTUmFwcGU0WGdlSFBHandSTklmaFFWYzEzMHU4U0NDT01X?=
 =?utf-8?B?c1B5Ty8yN3RyWDFlaS93aDJLaVBVVXg1cDI4MVJ2TVVVREV2Z3RSUzZlVjBT?=
 =?utf-8?B?THlLaXM5TTF4OWNGUmg2aEpnMEF0RHBudE1maWN2S1c3REVnWDRZU2FaSzlz?=
 =?utf-8?B?eTBKVEJVYWpEU04vK1RQVC8wL0dsdExvL1ZtNnMxWEhFY01yQmtnV3R4Ukpv?=
 =?utf-8?B?a1lGZmoxMVNrdE42MFdWSmcxTTNtbnA2cFIyWUdmNG1xYVdUYkFEWkpGNEwy?=
 =?utf-8?B?QWtFVlQvT21JM1I2QUV6aytFRHJFd2JZY1NIUFI1RW14SVp3S01qTmZkbHp6?=
 =?utf-8?B?b2hJUUxON2syd1VKOWJndjhSdHYyZTB1QXFieU1zSTQ5VDB0QTZSY0cvOTg3?=
 =?utf-8?B?TVltYUQ4UmhqdGdOYTk3cjRNalJuQkhDZUx0dmhraWlFNnFzcnU1bjlhdCtC?=
 =?utf-8?B?UCsvNDZhUFlLYW1ZZTRobGlIdVdWNjlmYXhTNzRERGZDMldrd0hramh4Wkdj?=
 =?utf-8?B?Wmd6K3FJUy9IUzhpQ0lteVJ2cENHdlNVRE0wS0g5bERZV05IODF2VEdVTWdC?=
 =?utf-8?B?M05RSTUxNHpHZzRBa1BuOENwWTdzQllTNlc2d0hlZWpYazR4YUhlQTRaYlQ2?=
 =?utf-8?B?KzNDUGRGRGwrN3daTVRoTFpIOE84YUMxeVkyUG9oTkdmcGkwaDJ2R0lpRjNY?=
 =?utf-8?B?NTBSei9kNUJBSW5nOERNanBVRFFoaFZyR084cFlQRzNZcXNIRjY1TmpVcEdl?=
 =?utf-8?B?dWI4aExaMzVuaWhQQzlaV21LVU9KZ21ZWkR1dE5LTk5JSld1aEsrZm1yTXlG?=
 =?utf-8?B?MGFnbThEYS9vbFZybXZ4VXZjRlJPVGFLSkNNWkVBdkd5NjRRK1FLcVZRdDh2?=
 =?utf-8?B?QUhrMUR6Z2J6Y2JXdU83clRvU2VTTTlrMzJ5UkZlelBTOTR3VkpOeFRGaFVU?=
 =?utf-8?B?VHJ3UTlxYnMzaVdQeFJpeWpmdFVrZXRMK25FV25GSWovYUJ0dE93VHVPckwr?=
 =?utf-8?B?QWY5ZXhqcmt3b3psVnVSQjBQd3dKdTRsQ2JJYnIvWlVhRWVNdE9pa2FpcTFv?=
 =?utf-8?B?M3VOSUl2em1KNS9pSmJyWmozWFlqV0YxMkxoQmovR0VBeUZSM3JKbUpzU3Ir?=
 =?utf-8?B?N0R1dEMzR1Q1eWRZYnVTMXhPZitONVdnaE83NkNYaGFNdnI4cU5jZUl3dm1D?=
 =?utf-8?B?dXFMQWJjUVN6bkhhVjdseWFIWDJJcG91R1FkL0E2a0Faa0lWVkpLY29rTUJJ?=
 =?utf-8?B?TWJpcG4vU2xMOVZRaXlKSGV0cHhHVk5TWU9LcjJVd21yYjUvWGFvcTlDU0U5?=
 =?utf-8?B?MEJTaGF1YzB1RWNyVTBxRDhqOW9iZkJpeVJONTRDcmE3aE9md2ZRcmlXczJ6?=
 =?utf-8?B?S25NZUNucFdNbVpFYXRqUjk3d2JseW1iai8rd0J4N20wRXVyZkFkMkJtY2d1?=
 =?utf-8?B?NHMxQnM4TXRXVURrOHZQODBQTU9LNDZCSlhremVqQUlsZlVMdHNVWm5EQU9z?=
 =?utf-8?B?T0tLY0ZjSkRweDQxZHF6NytweUdvUTdDZ21OZ0FzblRRY2drVkFUYjFYREYw?=
 =?utf-8?B?aHNpRXlWSGF5TUJVdXQvbkp6WnhjRW5VdnRpOVN2R21DeTZTK3d2c2RzMlVG?=
 =?utf-8?B?bnNVcWt6b1pHakI3Zmsyc2lqMFRZWi9kT1dybWtPQThoNnJqVWVtRVR1OXpV?=
 =?utf-8?B?ZGxnQ3dsaUtwdW9lSUMzRERFSzFZMWZaRHVveUJEL0lRc2hnM3c4SmJpNkZO?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e57d9e-b857-465b-d2da-08dd34a948f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:39:43.6996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5HEO/PbKzF5SuKImOq1So9UQiWxI4LhJabp/TaNZbk+MNXWYbP7p9NNYkpDqS0AKwWY6o9t9eIA3dvW7wamrjBJjh58vZW5U+0en1G2LRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10089
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

Hi Tianling,

On 12/26/24 10:20 AM, Tianling Shen wrote:
> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
> Ethernet ports designed and developed by FriendlyElec for IoT
> applications.
> 
> Tianling Shen (7):
>    arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>    arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
>    arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
>      R3S
>    arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
>    arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
>    arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S

How did you backport the above patches?

./tools/update-subtree.sh pick dts <commit>

is the tool to be used, it should have added a

(cherry picked from commit ...)

in the commit log.

Cheers,
Quentin
