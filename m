Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710BACE837A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A0C891C3;
	Tue,  1 Oct 2024 15:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Aqz7R/Qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5475D88D1C; Tue,  1 Oct 2024 14:23:17 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F6889178
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfNSsyJOCEHhDLWtCudtHj1t1C3gF1GQp5aXaliVAvrVobRtHLFh8MchMiElgKQPxywGnwBDGKzWHvE/qMHnsGR8TH1r2p5j+64qfaJv9RgM9tkeJk3IuaCCRvevQsjMsTs0YO0xd9kfnJ2cOkJvrZgmPb2u2GhBWfy18JE05UIBa2fmHflAwHewXQgCtCDdVTKVy5iewsOZE9XN0Z78XT+lCnpcJr9/cMxDby2v6dtcZu11VWhnPLE9GY0pvm2HTMWNCql77p6ZiO+hsj+gx5vZRX+RAoe5NQi8MhUcfJe4ootmlbqLD0u3PuZxSZrODOBysIRTQ5YFlDmtHJR61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohojuSu45YVwP1DhNUrdt0oiS0l7cE7G156B+YIWcS4=;
 b=j4Yn556D7QsSSCbUNDPJcZrNPz7i3RLcuyWfTdKG7gkWk5eM/6gqopsEULCT9/KOY7k8/g56HfV3WzgfVhEZ211J60VPgh3t3ebytFGCt1mR+I7EI+2exsHrCa2rEuVe93a6GUFaxHVn44L4YSjWjKrn6UYyEi67Yu0+9jf/BmvtiM+rEA+/fQ1GlMghJkFhtZRRHE8VgbzJj8lQR9YU2SD6Gh4BMkhUIWAiBwYHCN8uHUJqT4XbLawRZN1gOT56iC9cjLkGetdOkakjjJ/C0ndzlmwwnxzCXqGrJdHKsOi4vCzeMW1wE4w3+jcjGN4jivvCnNyFAUvOOvq8MV+CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohojuSu45YVwP1DhNUrdt0oiS0l7cE7G156B+YIWcS4=;
 b=Aqz7R/QaKyvzcLbTUfQk1M8i7rHwx8+qSrddhgyPUFl7Mic8VGQLEsxb5u8PdKI39Ii3Z4f8DQaw4cfvHCYlk8MNkkFObVVkqGYnXxWaLx7pYyRU/EfLDex4BRj6afixz8yrWlrXvnYHIT+eLB5Jipp56I/OtoPOOqvOrgMIsz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA2PR04MB10237.eurprd04.prod.outlook.com (2603:10a6:102:401::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Tue, 1 Oct
 2024 12:23:12 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 1 Oct 2024
 12:23:12 +0000
Message-ID: <8be3b3b6-b805-4459-81af-815d6168edbb@cherry.de>
Date: Tue, 1 Oct 2024 14:23:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Kever Yang
 <kever.yang@rock-chips.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
 <87cykkc9hi.fsf@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87cykkc9hi.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA2PR04MB10237:EE_
X-MS-Office365-Filtering-Correlation-Id: 83af6746-dbac-47af-abbb-08dce213d13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SURoTUFtS3M1Z3BORWNPTTVRbEhvUmRrOU52aG0wbFM3RVdDQ2JvaU1aTnlq?=
 =?utf-8?B?d1NpV1JTdVJOdTlISGp2andHWC9lYjg1ckQ4TWRHdkJmcnlLdVQrYlpBTTVD?=
 =?utf-8?B?eXE0dkxTT1pvMzNza1JYeHJrZkV5S21SZ0xZYzB5ZlYrSStmelBZdTIvNkRo?=
 =?utf-8?B?Z3VVWlJqNUZ3NzJIWUJTcXdtNTVONkJtQXdYWkRWYys1S1VyN0R5ZkhOZzN0?=
 =?utf-8?B?eXQrdDZSQnpkaHJ3OVhtNml2MXMzQ0RDZSsxNXFGaWJIWlQxQ09oSU92YWJN?=
 =?utf-8?B?TjNsSHVrR3lhYlJLUWZZcTU3TC96Unh3MDlGdDQ4SUpvK0hNMGwrNFJsTmQ2?=
 =?utf-8?B?RVhHSnRGcFB0RlFtSEk1NnR6blAvcWZHWXVSamZCUDdaSVF2Q3NwbUxFeUVj?=
 =?utf-8?B?MFVxUGxDN09VM2ZwSG91cDAvNlR5RFdLRVZNYlBWVFZqV3FtK0NOS3A5MlZo?=
 =?utf-8?B?WU8reGxOencrcWJsTUlvekE4Rjdwb1RkUzJYU2dJc2lvNHBrRmFxZ2RFMnhC?=
 =?utf-8?B?RUg0d045bm55UktQdXJzenlEdDVOeE9JZDhHc3U3d1B6RDAreC9jS3pjVzAr?=
 =?utf-8?B?cUlIejdWNFMxeTdFY0ZsWjdqZkkwKzhWVmYzNjBHVXMwVzZRQnI5THprT1U5?=
 =?utf-8?B?ZzNINUxEaks1ZlR2dlB3VjY5V003L0poSGo1elVEUXRXUmFDc3FTY1hlSjRX?=
 =?utf-8?B?RXFETnJCa2dNdjVGYytocy9pd3B4TnhjVTR2b2x3Q2RKNnNJTURjbkg2UHZF?=
 =?utf-8?B?eVEvU3pnSHVSemtXb0RzM0owbE1nMksyeXkya0VsbXJ3bmZWVmNTOG43NkQy?=
 =?utf-8?B?WURTUWxhckIzamFyUjhlcUpBRmZFNjFmK1I2S0ErblhXMllBb0l2SjY1NkVh?=
 =?utf-8?B?cVYzUG9DSmg4eFZTQzhmUkVqOWpDZ0doL0hsdll5MDdZaUZUeCsyMWRPQXg3?=
 =?utf-8?B?Uy83THpRQUg3d0lLZSt0UjR2QmNTUzRCNXpaczVxeWdIMmxNSXR5cnY1OCtO?=
 =?utf-8?B?cGkzenRhM1NqU0dzYjJHL3pwUVlIRWxBWDB6cnowUlhSU0NpZ25TbWkzSGxN?=
 =?utf-8?B?aXFHZHpwNGFyM3VzVmNJREpVWVltUGV2NDYydHRGQ3c4UHdRYWtSbDVEZUlv?=
 =?utf-8?B?M1JwRHdnSDBxU2xERHlDYzZSQm95YWVlN1JXNXZHNHVyNXNxRzU4cXBQbjMv?=
 =?utf-8?B?UmR4dXZQR1ZJeHVKMU91d3FJYW5CM2pkQXJVOFV6K0pLQmRaK2htcStkOFJ2?=
 =?utf-8?B?RUxXYncweEpMa0lqWFpzc3FucDBGNFg0UDhGWTJDa1VrSVdSSTdBampSaUQ2?=
 =?utf-8?B?WVZQR2liNXphcjhCKy9nYTNOWjByQ25LTGNkOTJOWEFYeWd1NExNWVRQNGJZ?=
 =?utf-8?B?dy9xLzZHL1B3Uk8yK2FJdWpyODkvQm1SN3RWQUdxM3kwMk5SL3BBVzkyTStx?=
 =?utf-8?B?NjBiNU9IZ05IMjNnSTE3Y3I4eUs5bWRDbVFlbFA5dWdUZEZrS3FKcVg3MHRk?=
 =?utf-8?B?WFpnRkdmUkMyOGN5TWpsRk5vSnJrYUU0U1dheXV0YTVJV0J0YVBtSE95WWNp?=
 =?utf-8?B?N0t2dmJPUzF5OG5jT3BBcVpSdUF6QUZxZkwzM29XOE90MmlrMXlVck5JdXRv?=
 =?utf-8?B?TEZ0WHRUMFlNREUxcWhPRDdHYjY4TmlPS0h4SDFGQzc1dXNaYlJyZy9hN0Zw?=
 =?utf-8?B?YVJXcXFEemNyeFVTamVyTWduK05sYkF3cHhyODMvZzdRamUxRzQxWUhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpRRDQvbkx4TEpxdUNRNkpmWXFhaVJwU2E4YUpIRlBRdVdaOHVXeDFOR1By?=
 =?utf-8?B?b2E3QTNrM29zVTFBV2ltbFZFd2U3K3BQSE5IekFKT1U1eUNPYlljc3JTY3dM?=
 =?utf-8?B?Vko1L1NRVzhyVENFT0pBYXptcDVYTHBvWkZvanZkS2R5aUtVam4yOGNONnJu?=
 =?utf-8?B?MXd4VXl5SE12UzBUTk5yVVBYVUQyQWsxN0ZjdTZFTEJHSzh6Yml0NHI1S2l2?=
 =?utf-8?B?Z3VPRnY0ZlE4L2FFSWJveFhtaDYwVkovajA3dW5qNzZ1RFQ4OWNISXprR2xk?=
 =?utf-8?B?SC9tSEVJNncrOFZQTHc5VThRQ1Rabm1VQStvVGI4WlFJWEVIRjJlT28yRWo5?=
 =?utf-8?B?aCtUdGo4YmJJc0p6UFh5Q1lCQ2FYblk4YkpMeDZyZTdBUXpnSXZ4azNaQTU4?=
 =?utf-8?B?bVp1YXNGOVE0M1pWVHJpRitEZnVab3hWSGp4ZE8xa1hpV3Y5b2FCakFyL3pF?=
 =?utf-8?B?dXY0NytGQUdBdm9qK2htZzBBUkJmSGc3VkM2YmJCQzlCWGN1ZEtwSThPT0ZG?=
 =?utf-8?B?U05uSDdPQlVyL1EvZGZRK1h1NFNyNFZqTzlaQ0RiU1VZQTRvampMOWFWMmxH?=
 =?utf-8?B?aTAwc211RkFjM2dNSDRjOU5TWFBIaGR4TWYxdk9TekVMUVZEQkovVGtsN2d6?=
 =?utf-8?B?cjd5QWVrTTM1YWY4endkSWVkVjVYaW0wZFYwUU5mc0ZCQWxUK1dpN1BaYitr?=
 =?utf-8?B?RUp5Qjd4Rmw4dmNNMDErU21ydTlxVEEra25SMmR3Q04wcGI4MFhleDlDWGYv?=
 =?utf-8?B?bzN2ejFjOVFzdjkzV3R5WElLUHdOWHFPanZaVzJ4SHBsT3pVN1BnaDVlR1NH?=
 =?utf-8?B?MVEzMnF6OWFCT09sSUkrQ1RZRlB4OVpGMkFKS3pWQ29LVEJjRDN3VEN6ZFJz?=
 =?utf-8?B?V2ppTmFhcm5NbGc0R3IxN1c2SHhZazJxbUxiVHhPdk1OckV5aXNhSEdJZmto?=
 =?utf-8?B?Q1hpcU8wa0xrVDhPcTA3cXp5MkMra1FBY0M1VVU4dnl4ZDM1NEdEeUMrODZT?=
 =?utf-8?B?bTlaWldnUkoyb2ZuODVZNW8vNU9HVm9HeEpxRDM4U0xZc20xWWpwbEwwRVA4?=
 =?utf-8?B?NktaWThjbGF5eVdtTlZTeUIvNXdHdnpnOEsrdTF3RXhCU1FJVG9vU29zV0lk?=
 =?utf-8?B?MFFrQmRrT1diOUtEQnpDRFpvSFdkcmNTMWpCbnE4dlZnMFBMWUV1UTkrd3k3?=
 =?utf-8?B?bmI2K3ZOUDNPVlpkUnpqU3hCYkxPVjR4UDIwRXhNcGVQSGVLcWRlbWNVdll0?=
 =?utf-8?B?eGsyZzIrZVZ4SjdkMStYZW1pYnk3T21WZmVIWW4wZStzczBtV1NuTVlSdlor?=
 =?utf-8?B?b0ljOGpoTzgyK2MzTEhCWjQ0bWJMTXRMam1zUFh6eHBidVBYVWEwY0NvRFpx?=
 =?utf-8?B?OE1OQ3JEaGxsamdKK1YyK2srWWkzcTc0SHNESENvYkZGMmZRa3V0RW1iM2RF?=
 =?utf-8?B?bTZ5dlA2SENaT0llb1J5SHM3aXFpdVlZNzY2QkRNcDkxMXdhclA4U2RSNkd2?=
 =?utf-8?B?bzlwMXV5VXhJVCszalM1VGlGZ2VBNHJabW52cHplT0ZiaFhXcEpDM1U1ajJi?=
 =?utf-8?B?NVB5a0VPa2dSc1N6ZXVDa1RlM2Rzc0MrZmZaVzIyNmdnYVUrcHdGOWpQMHN6?=
 =?utf-8?B?ZE1wQ1BIOUxZNWc5d3NDQnIvaTFTbktVblIwMTdGZHl4cnFFQk5yb1JjN2V1?=
 =?utf-8?B?RkdjVkpyQldGWHVRdk5VWUlwMVQrKzFsMk5lc2llVmZESUlwVzduaTZXb3hW?=
 =?utf-8?B?ZHFXcDNVeitSeUhCczFXVVVPV2tKaGtxdzRlT0dKN2t5WFh1ZFA5QnBlUkE1?=
 =?utf-8?B?WEpZYnlkajZXbGEvUml0Z1FjSU80K2EwL2diQUFqTGg4TWFNVHdMU3U1SE51?=
 =?utf-8?B?T2VibGFIS2FJQXFEQ3d5U3pVMSszYlUzTml6VnpZcWY5TkZYRHVYRXNTU0ZL?=
 =?utf-8?B?MFpGeXo2OE1LVEhWcXJPeWNpci9GUTNvRXNLZjJjWnZKb2NnZW42M1lweEdM?=
 =?utf-8?B?NHdFeCtJdVIvR3NJUUcwZThJOWZTVHFOL2RiZUdOa1hHam1SbjhXUnlHaFFv?=
 =?utf-8?B?ZVRaM1pkV3hMcmNNK0psUGxNM0hvdnAxY3pHUk9KTysrcWFEUFhqMFVWWi9D?=
 =?utf-8?B?ais0TmZFU21OL2piei9hTE93YXhkU1NFV1hJdzFNN3VkQUhQaVpPTFdIWGJ1?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83af6746-dbac-47af-abbb-08dce213d13c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:23:12.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56VjPjoASBWBE6WdxC3JqnQ1tg03RRohttWAcTHR3aF3C5a32jJBmZZMMeJIOUA2w3JKQrNGMCwb+RDkOHvgYqInn7vQxpr0Lav0iPwIduc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10237
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

Hi Mattijs, Simon,

On 10/1/24 2:07 PM, Mattijs Korpershoek wrote:
> Hi Simon,
> 
> On mar., oct. 01, 2024 at 05:18, Simon Glass <sjg@chromium.org> wrote:
> 
>> Hi,
>>
>> On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> This series attempts to migrate all sunxi boards to use standard boot,
>>> along with a text environment.
>>>
>>> Changes in v2:
>>> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
>>> - Put the FEL bootmeth before all other global bootmeths
>>> - Convert the other DISTRO_DEFAULTS in the Kconfig too
>>> - Keep BOOTCMD_SUNXI_COMPAT
>>> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
>>>
>>> Simon Glass (8):
>>>    blk: Make functions available unconditionally
>>>    bootstd: Avoid calling unavailable block functions
>>>    bootstd: Avoid depending on BLK
>>>    sunxi: Add a bootmeth for FEL
>>>    sunxi: Move to bootstd
>>>    sunxi: Drop old distro boot variables
>>>    env: Provide a work-around for unquoting fdtfile
>>>    sunxi: Move to text environment
>>>
>>>   Makefile                                      |   1 +
>>>   arch/arm/Kconfig                              |  10 +-
>>>   board/sunxi/sunxi.env                         | 152 +++++++++++
>>>   boot/Kconfig                                  |  16 +-
>>>   boot/Makefile                                 |   1 +
>>>   boot/bootdev-uclass.c                         |   3 +
>>>   boot/bootmeth_fel.c                           |  81 ++++++
>>>   .../gardena-smart-gateway-mt7688_defconfig    |   1 +
>>>   doc/usage/environment.rst                     |  12 +
>>>   include/blk.h                                 |   9 +-
>>>   include/configs/sunxi-common.h                | 238 ------------------
>>>   11 files changed, 278 insertions(+), 246 deletions(-)
>>>   create mode 100644 board/sunxi/sunxi.env
>>>   create mode 100644 boot/bootmeth_fel.c
>>>
>>> --
>>> 2.34.1
>>>
>>
>> I'm just checking on this series. Are there any comments, or can it be applied?
> 
> Quentin mentioned a typo in patch 3/8, see:
> https://lore.kernel.org/all/1f963aa8-948a-4657-9f1b-a3bc38df4714@cherry.de/
> 

Well, is it really a typo or was this still a WIP patch that made it to 
the ML somehow? That was basically the "question" or concern about "wip" 
appearing in the commit log :)

Cheers,
Quentin
