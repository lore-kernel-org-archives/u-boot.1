Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF19CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 08:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F9F88A30;
	Mon,  2 Sep 2024 10:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="a7rOk+LR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F02A88A49; Mon,  2 Sep 2024 10:48:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057F588A1D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 10:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsOh6BJzxKXZPR4Xuai8s4Dzbxi80s2YaOF0wK4zLHAP1IdhHG+103Eydau47uojV41BoieDGlHaVDY/ySz8wjmS3B1nR8u8zOBylCXMAlGD8H6NQVbH8HNkqz51iAV+AXJfUVJBGgBwRyQXk/u3Wlti+ewsknyefa3sJoJGYliuR4iHMojdkz15szh8SDFoeC4rB/RXm3ntGDXYJsCRcxF/b+ZyDTvkNuSfZHFZ15D6ADnZFkRNYshNMwtjA5ASTIKjXq6/oAYr8vDdtD385iuA4aA0DSoWMhOHFV/B2fcep15EgVIdID+e+KLmcUza+nOXQSpkgzA5avNu2ijLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdeecC8thb4SpTxRQm1A14tv2mP/LcUYCwUBWZvpXhA=;
 b=rEmfe3aX3flrTFIxNqBEIgEDMJqUiQC9SmovgSw7d2rUkQVxymhcxrFMcUO7HSlD7HfW2IcH9rRD0PD6Pa8VyS1pJ+vh5R+IsjbxXu0eO/1LgSTDf4s7RIJFZu4HSxRT/+OTM2YAGplHKLS9Nj/2Yq6PnTJ6KIFJ+ZeeP7FZ6FOiyVha2s570lEtppc/sOisVGjGTL2028U5keXTdBEJCuLgdukNyWqkBWZn3HukuK4PKWod4CAGS3nzn8BZq1TZRQM6vv9U9nqhdytqDDjU3h7iWduiSyW1US1f880pSbaNYy2BLxgNsFhDazfNFHMzFY3povYOcvPCXRbbNSUKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdeecC8thb4SpTxRQm1A14tv2mP/LcUYCwUBWZvpXhA=;
 b=a7rOk+LRbkc9Pps/3GG/Ux162/fUCJ5Qng/b80PRqtmCe/bAEOaSaiv7aEBzQWEaMa1ZG9T5mQWbUl8FsFTE/zka3izyJPswd6/DZtlF9EcdSci9HY98u5g9PWEuyd9APUHSBDkx6SzCaiwSRSIJiCejbEe6t2HL1R2/Fzln4Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 08:48:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:48:17 +0000
Message-ID: <63463eb1-d7cd-481d-ac08-c08d2b66eda9@cherry.de>
Date: Mon, 2 Sep 2024 10:48:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Hide mmc speed command under mmc command
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c393d3-ceef-4f8c-0589-08dccb2bfd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS91aHFwWWdWMDFDUWJteDgvYktBTEx4UnBzRUNsekFuWGR6ejdSVExGdlhy?=
 =?utf-8?B?NkgzZ1pGY0tYRUFHMzdLN2NubC9xR0Y0UXVXak9JVkYxa25UMndqbU8xUExn?=
 =?utf-8?B?VlhyejRnakd3RUpIbHBMTXN0cnR2aEV5bEtKajBhSStBTndVWUVkWGxyYUdm?=
 =?utf-8?B?QW1YVS8raEdYMitrdU1GODRuVmNvalkvN0VhYmszRTFWdlZ3L2R6SjJzNWZD?=
 =?utf-8?B?VVdTWUxuZEhDeWZoZjVhRUtQTC9BY1ZqZHBsNTFRTjd2Q3pzQzJEM1p2RDdp?=
 =?utf-8?B?V1dKbytPSzhCN3lEbm56Vld1UTVlblNyZEc5dXFuMlF5ME1uZVhYdkg4UnBl?=
 =?utf-8?B?aFJPK1d6RXlUZUhza09JUG1ncVYxUGNHbWZPZXkzV0ZhdWs5SzVlNjZxaFZj?=
 =?utf-8?B?NmwrTkcvMmEwRmpsWU1Ed1FQQ3pzQkl3Y2ZsSWxkMmJWQldjZFVYUU5yVjJT?=
 =?utf-8?B?dzR4QjdycHo1N01MMmlnOW1Famk5ZTZGWGVVdjJENi9waTVNUVdINTYvbHg5?=
 =?utf-8?B?ckJHWlJsU1huYVJFRE5NVjZvSElTN04yRmJRZTNQN3F2MUFDQXorSTh5ZG1B?=
 =?utf-8?B?WFFobnpDYkRoam41NVJickxzSXVxdGxjcWc1Q0tmUVFhRE9zK0VxOEQ3S1B2?=
 =?utf-8?B?MFRlNTlBMVVobDJJdjRCcllldFBaaHZaT1lVU1drdHliNk95ZFVGODdSVFFQ?=
 =?utf-8?B?TFJpd2RVT1ZzS2U3cmpTTFZFRE9GVGdTWmpxSHVydzVFR1l2anFuWEI1eTE2?=
 =?utf-8?B?Vkx6VzBudlpuNWl6NkxlL2FMQmx3cElWcjZ0WWpwTVVScysvdFNwUnFWTXdv?=
 =?utf-8?B?T0NTZ2xPTTRsSldIL3Zkbkl0RGhCSlVnbVZZYVhreWVlQUNJMCtSbDE3NHl1?=
 =?utf-8?B?RUh4dFdvUlZBVkdJQnphQ2d1NXdvMHMwdllzdThCQ0hPUE14eFlEU2RWNVBW?=
 =?utf-8?B?Mi9kalJFVURtUEpZdXRzODJoenZvaXZxTVEzSlJFNWUrcktNaERHY1p1OG5D?=
 =?utf-8?B?NnlVajlkbGczRVR1czQxb0MrTWVkMGNGODRoN1FGdC8xYUlMaDNlcWpXcUEv?=
 =?utf-8?B?cGlVZURWeHdIQ3NvQ2gxMkxPR045MnR2SmhFMkVCZDBPWmQwaDZMRmpwRVlL?=
 =?utf-8?B?TnN2RXJYYXRMbTUwZjNDaVI0ZXovUnJEc2ZUV2IydytITVpRSExKNkh2WWJr?=
 =?utf-8?B?MkQwS2t0ZDE5K1ExdExwbWRTaWZDanY4T3llR3Z0UEM3TWE5VG5lNXhiWjJn?=
 =?utf-8?B?cHVTL2xFQWRZTE16RFB4ZWpRKzU4UTFCV0xNWEF2aHRqclAxVy9BRGp6V3l6?=
 =?utf-8?B?KzhWUlk4MHpERVRTVkMxVDBqYnBtYkdXcGhjZDNXL0s1eUJ4cEhxR1hxQng5?=
 =?utf-8?B?akpQaEczdDJpOTdKZHowTjdxR3RHT0RxL090ODNGY09zby9ieWtlOHJFYmpU?=
 =?utf-8?B?SklsWVNPUEN4UDFSMlhqOUh5cWI0M1F4dXNLYUZTYzY3b0NFNVd1Zy9WYkhm?=
 =?utf-8?B?K2E3QytUbi9aaERzbjdyVitJWjJ0RlBuWkJiVFkzdUJYNDZOdnZFNEgzenlt?=
 =?utf-8?B?d2NINW5qOGNQSWdsazhGL09UMUlrdnAzVUpFeUVneGNiVVc2cWFvbVhnWmdG?=
 =?utf-8?B?TFVaMmVaNFJFWUNpSG9kbWhzTjJFbkY4NW9LNTZaWHNPT0ljYjlISzBZbWdr?=
 =?utf-8?B?dEQ1VUdjMGU5VnNZcEN6L1lGQjgwV1BmZDdwNytFRlB0eHZNdnkvR01NMVpl?=
 =?utf-8?B?cGtueTNjbDB2YUE0OUV5QzJMTzdRcHJvNXU1dUZsT0NqeTk3akZza05XNW1P?=
 =?utf-8?B?anorbVZEdFMzL2dRd2RpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNNQ1d5dHRGTkxURUJoeEl3YXJsN3JpaDlnYkNJZWFpVCtRYWtBZjJJamZt?=
 =?utf-8?B?M1AzeEsvNUhqL1IrZ1RTT1kza2ZlVEw2ZzlmenRpczB2NTQ0YU1HOTlrZWZU?=
 =?utf-8?B?M1RUbzdVYWJBbGRaTHltL01UUjZ6RFdEM3VyRURjdG9pUHNQbW1jMVV3ZVZl?=
 =?utf-8?B?UGFTOHVRYnVweS8ybXoyNlVrUFkzYUhEVzJzWlc0U1J5TjhNNUpmZStvRFFD?=
 =?utf-8?B?Wll5UWdlZ2tNV203RkRacngwdStIRkt1N0c4MmFNeWtReWhVNU1pcGxVdFZN?=
 =?utf-8?B?VFE4eko3Mks1RkE2dnNudmJlN2hsbjZxU0tLdjNPenVEdE9PUlZ2cEdIN0sx?=
 =?utf-8?B?SmJUcFJTQ1c5UWNFaWsvaXQ2VEVOWE1yWVNjRjBBelZudEt0bG80dTBOZ3Bz?=
 =?utf-8?B?aDZMSDdPWFM3TExVa0FiVm5oRDhJUDczclBYZ1ZrNWFwQmR3Qkp0QmEvWE95?=
 =?utf-8?B?UnFpWkhIdUt2R1hZTjdTbW0vYzFyU0dKODBRLzArVFlxNEFmVGlvTDlzdFRY?=
 =?utf-8?B?em90TkpkdzdXbVpNblIreldiV05zTVdXbXEvMVlMSGc2Q2lvRDZoNE5CQ2R6?=
 =?utf-8?B?SmxESklMaVJGL0EwYmZrL1lnZ3NYU0k3ZWdGamJGNUovdFlTTXM1Tk5ZMG1V?=
 =?utf-8?B?eHFoSzFEODBjNnZGZHBoVDB4WFlheUJvNXBVWDNCMlBEb1dnUDBWT050L3NH?=
 =?utf-8?B?MHQwZ1RXbkVFU3NZbTN5MDFwc2paQ21PaUFOUjQ2c1FFZEpPV0I1QTlIYldX?=
 =?utf-8?B?RzAvb25paGU5aDZMZXVLb1FBdSs4MC9xd3J2elNabHQ1ckVaNHZWRzJabzl0?=
 =?utf-8?B?eElzQ0JNeGRNYW9rTDRFN3Bmem5kNWs5NzU2Ym51OVNqdUV1Tlk3NGJqR3Uv?=
 =?utf-8?B?bHBlQXlKQTJsV0JaOTZFVzNOL3A3QzNGbTVoblMwMm5FUFZnRlRCcGtLY3Zl?=
 =?utf-8?B?SnZTSnhyMzJFTVYwc2JLSCtGek5GQ2RMbkxLdW4wQkZZeHBMMlhkNkZCT3pi?=
 =?utf-8?B?cS9IdzRXQnZ6OVovWGMrSXd2eHhrYlo4NUljNGJlZTJiMFV0cktUSVdXQ3pz?=
 =?utf-8?B?R1lFNnVGL1lvUzhLRlBwdWdKUE53SFJjUGUrSlZpWGhBK1gwS3VpR2w3QlNF?=
 =?utf-8?B?czlyY29pWERyUkhiZGxTSmJqZmhZTWVQQjF2ek5wZ3BTQVFKQWovVHdpNzFR?=
 =?utf-8?B?ZUoyc2wwUFA2L1hkWm1NUVJCTE9CRW5QeHdzMkQ2VUliV09FcG9TYzBVWjFQ?=
 =?utf-8?B?WEhNYWMwTjEvWjU1c2lySmJtc1dWSXRGL1Mxa0d0dUhNbThheENKMGtSMkFK?=
 =?utf-8?B?Sy9Cc0pOT05vaUtIWHp2M0FHbnpTbVdFWnoxWEVja09MQ20zM2lBQUc3OHJJ?=
 =?utf-8?B?VXpUOXh4bHhhR2JndHozZVYxUFNRd3o4M0twdVE5NkE4eU53Z05vQ0lrTnVz?=
 =?utf-8?B?OW5RVVZ5S1NtTWZ3N0pUUXZXZEhRV0FYT2xGVU55blBGL0QycU9DWW1WMU15?=
 =?utf-8?B?Y2ZDWkN4T2FyRHZLcU4xYWdWQXZ2YnhwNmZ5bmFBd3ZzWFdTYmI3VVlyL09H?=
 =?utf-8?B?TExmVnBQWVR1dWs3bjlZMVh3THczOTd3VUFTWUw0ck1DN2MyTVpnOTV1OXFX?=
 =?utf-8?B?Uy9JeitERDJDZStjd1NXZ25jeG5MNnlFUTVwZUFuYk02RmxTZ1pFdnprbTdQ?=
 =?utf-8?B?bENsbi81VU5odDdCNkxRTnBmQW96L3EwZHIvRno4QXZKMERLN1lYRXltSE1v?=
 =?utf-8?B?Q05OK2RhYS9FOEd4VUNEVVgrcnU3eGJSbytzRlgvdVFkc3BWQjEzYTlBVnZ2?=
 =?utf-8?B?b3hUQWRFMGdCaGFDTG1iaDdtVi8vSUNnci9mTStNWVFzaVAxRXdKT1Vacitm?=
 =?utf-8?B?TDZvZ1pYRzRHOU5WOE5QeEtVL3J0STNnWEdFbHc4QmppUzRNSi92aGlKd1A0?=
 =?utf-8?B?c05yWGx5N3U3amN1WlBWTW1UKy9jV25Cek95dFdYNmtlMkJtVW1kRHZRVk9C?=
 =?utf-8?B?bGxGRWticHp3UGQ3V1ZHREcvR0tHTTJPdHl6V2daVysvY0JtR3V4cFp6N2dQ?=
 =?utf-8?B?MEQ4bFRWNzErdXlHK2hPeis1UkwwRGpmT2tFUTVKMGhwY0pUc1NySGpZSkkx?=
 =?utf-8?B?NUwrbkZWU3d3SHZrSGhvQTh3bVg4enowSjlNcUlSZVFaUkhyb3hxVlJuWCtT?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c393d3-ceef-4f8c-0589-08dccb2bfd40
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:48:17.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDe1UMx5TCN8o5IJFcuQaFQ8flfT8HCsBhXxtx2oZMQb2mvoYVEhMkrm30UcqW8RCAnjw1DtdetNYwloQJC/9Tu7DEr8xkdU/DGBV5T3Kgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

Hi Marek,

On 8/29/24 3:22 AM, Marek Vasut wrote:
> The mmc speed command configuration option keeps showing up in
> Kconfig even if CMD_MMC is not set. Move MMC_SPEED_MODE_SET under

How is that even possible?

Shouldn't

depends on

be enough to NOT show the option?

I just tested now and it does NOT show up when CMD_MMC is disabled, so 
not sure what your issue is?

Cheers,
Quentin
