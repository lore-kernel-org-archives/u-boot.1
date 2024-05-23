Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFBC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC96C87E9B;
	Thu, 23 May 2024 16:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kUTuDwqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8727887F24; Thu, 23 May 2024 16:50:30 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9318287E83
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYzvLmUDlP0CBUdU00vMOog5mU0O4DkGn8F8+bwd42VZxejeMLZqPytw7Ah4w3AXx4mkYxcQOV1LDVn15Du+8DcHdQKTx2FYsbmnQ3sEp+F+THPk/mmE5WP3hjg+O14AMthUI1/f6H9hAsJwL4EMC3Eq8Q8HDO3Ang9SF+7htL2uS/fZxR8ybPzMrrWoFSpUGVD9IfAMH2VmANzExG9J9qEbE6YmYBDISdScPLFVmCZIWgSIexa2mXi4Gw62/Y1vXWRsHr9/dBWb+tWNMioydyar+JOlM/Ya6TFmwAlMsGD/6gcwlIW6cCDocI9g6+syaCgFpNHikXs4FJ8UwBI9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2o6YRoUE5Dur433mXHHaGRHhAHaVFZ5xONf4jgwpFQ=;
 b=ADTG+vwiOE6bsizX1R8cYmB4zJ83yRSc0r+vbDMMk6/zpEr4g4zUaGnLWWsnZ/7gJ1kJn9ZhJ/ZUwzHeljqNPP2VyuMfkKdpJsu6e3oRWNyoe9NdxNyirM7nSvw99PzGjTq3f2mVsT6PMGEpCYKeXNSxhzocMohqLn4nuV0dBgmivmZBj4y5nbGPP8j8sgvblhOL9ZAEZE/hPvzXUyTRA98zslmWIn1CFuCh1cFvK4usY3sHwHpLPoscvo9IgqRWd7yU4UX1BT0Ut6lKw3xwqWKDNOUTfetOSr/WrEdUCaxlfWvlb+cgEEKqA180j8cUdEqmlaEGS2oIom1HWtXVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2o6YRoUE5Dur433mXHHaGRHhAHaVFZ5xONf4jgwpFQ=;
 b=kUTuDwqfvWefGll0Qyc8uuhI57vuACuc/BrHVudcAZGRBKuzxEjW31EuGgmDAumN7/KOEyksCAeL5W5Mk0RNgmq8ttb+x7ZfUw7oh79HgqxNXvLNnKx5lzu4cZ/971x5Cn0Lbr8p14b+FmMfUpP9kaTiztik5PA6l3xlvUDqSCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:50:25 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:50:21 +0000
Message-ID: <19b10daf-28c8-4178-b834-bd2098d4a871@cherry.de>
Date: Thu, 23 May 2024 16:50:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/42] mmc: dw_mmc: Remove common.h
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-2-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4770e0df-c5e8-48c1-4e01-08dc7b37ab85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjNmd0dXblBWWGtIZXAvbXl1YlNReFN0c3ZxR2Nvdml1elZhNlpLSmhIYlhK?=
 =?utf-8?B?ZXJtV1d0VHdTZGh6VExVN0RpQUc2ekd4VEZ5cnVnU2dTb09HbElpRTZJdnRz?=
 =?utf-8?B?Y3dGeVZsM053OThJWTdVR0FmRWNoaHM5c1lkSFdNMkpOM2lDTk5qRVhlMUJI?=
 =?utf-8?B?V0ZwRDJoTFFRdnpnVXp3MnZmMjhDMGNuTUZzaWpiQVpVMjFGUWZpdm92RDdr?=
 =?utf-8?B?K2ZpenFvNnFZNDJsbmJMUVJKMU5qa0NJUXhZRXJ0QUo1M2NkMnFTdWtOQU5N?=
 =?utf-8?B?TENFbjVubkN0aGd0a0xIWjRzVlpSV3BMUVhTMFR5WDIrb3NXSFh0MHlaMGJY?=
 =?utf-8?B?eklXUTNlaENVTnlvVmpaRkRUeEtPMnBaT0QyT1NORmlCNHZkV0NuQ21TVXBu?=
 =?utf-8?B?aElXKzhaS2p5V20xOXhTV2t5V1gyNHN4WXhJTVpraXFLaFpXVnFsZ3E3T01X?=
 =?utf-8?B?d1EvZXFvMTNwaDNDVHF6UGhvNzZGaFpCWXRERHZXUTdSRDBFSTlHR0k0UjE1?=
 =?utf-8?B?Q3B0SjhxVTdMcXh4K1QzQlZhQmpRbHE5ZnR4WEpIVGVQTms3eEF1bUxCdUtl?=
 =?utf-8?B?RGxtbnNJK005b2dXUXlBdkwvZU5WTjJBWk9Nc2hxMDBTbmxkaExkbVFqM1R1?=
 =?utf-8?B?SWRBOVVCVVJJS1hjeVpGOEhHYUFtS0V5MVE2dC85dFFPQTQvZlAvQlI3Y0tn?=
 =?utf-8?B?QkY1V3E4SXZJTnJHM0NhUW9Wby9MSGVWRTRsKzFRVWZIQ1E0SHhEUWhuTFZH?=
 =?utf-8?B?S2QyVlplc2NpQVZmalJhSy8yb0lSd2hOYklLM3BKNkIwSkJKcWRpWm1LUmJ5?=
 =?utf-8?B?bHBSVHNpRTJwVlBTL21CUzdKZWVkQWtlYzZkcnF1NXgxd3pFbWkzWkdvVjRW?=
 =?utf-8?B?UmZFYmtJMGl4RDdtRUJxVHFIeElYUnFHZDB2QXpjd0xZRllmZjl6WnlFV0dz?=
 =?utf-8?B?eEdnRFdERlYrc1F4T2FYUHF3Vm8vSjNtNzBFejBJVnZmMStCRExDMDNWcWVv?=
 =?utf-8?B?aTBUalMrTDZ4UExkcjlrQ3hlQXVoWUdDeWFBQnF3UEFoTWR2blB4dUlFK3Zy?=
 =?utf-8?B?ckRtWGJJT0phZk8xbWpvZk43WjI2N3c1SENNTnk4WUdQVWtqdFQ5dmcvVmV4?=
 =?utf-8?B?c3djOW1pWDBFR3RnZXdXdnc1WFc3SFNJTmN4Vm9NY1lZUnk5K2RaN084OW9a?=
 =?utf-8?B?cktMUHUyR2lacXdVUmxWT2hURnB3aitnYm5lT25ZY3pMZ1Y1cHF3dk4vUFlN?=
 =?utf-8?B?TEtBWGQ0c212b0xEeG5IZ3JkZW55L2FYNlNwRXQxUlFpU3Y2QTBHanE0Z2Uy?=
 =?utf-8?B?cG9uU3p6UG9ZN3hEN0lKL0Y4Yk5VdmZlWXVyREFLQnhTOWNjQkszcTNqQ3hF?=
 =?utf-8?B?TGw2aC9NbEc3U1FXQ29tMURjZnV1N1JQQzJwT1NYWjJUOVFRcW5Wb25xRFJ3?=
 =?utf-8?B?U0lDY01UZkl1STVRMjdLajc3TEJrejg1MmVYNkpFNllqczNnVDZ4YWNEQkU1?=
 =?utf-8?B?N3ovdytBSVdjWGtCa1gwNm1QNHZra0x4YTFEYXdyRVZNNGFKRGd6aW5uM3h4?=
 =?utf-8?B?QTYyYzB0MmhMOHBwbVl2a3hvOXV0VVFsWTduRlNOenMwMXZBeFhHS1RzcG5a?=
 =?utf-8?B?Rjc0ZzUrUlV3eXp2SkJpNzVWN3JSL2phUlVURmtDWlJaTmFlK0s0MGZhS1BY?=
 =?utf-8?B?LzI1Q2toVU1kNzMyOU1rRHlkZjg4OUxkQTR6QzBoN2lUdDJvbit6YmFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlViOElyZEtwS0JzaWhaZ1k1eU4rV0JUSlVmWVJxK0tKckEwWmIzaDk1YzUv?=
 =?utf-8?B?TXFIL0pTSnhoYWZYREVDT2JRalp1a2pjd0EveC9KSm53MWJ0Nlk3UmNxUjkr?=
 =?utf-8?B?bWZSU3lPdW5TY3U0NC9OTXdYSFF3NFRoMzd1U2hOT1h4ZzVLNnJsZnU3TXhq?=
 =?utf-8?B?dHRBMGhscTQ1UTBoR0N3VEIrNzRDV2c4ZWVjU0JYZ2tEbnh4Q0lzRUNpaHUy?=
 =?utf-8?B?ZEIvRmFJQm5WK0EzWmZOSkJBWHdXcGI2WGpNQUVLUmNrY0oxY0MyaGo4a1Rl?=
 =?utf-8?B?b2gzSXJYSlB2U0taUmtPWi9JekZiVi9TOEQ4ZlY5K2tabVM0czJlZVhhMHBD?=
 =?utf-8?B?alN4czdkMGtncjkrbkdNOTlEbXMreGQ4a0NwelQwdUdScS91MlNHc1k5Y3Ru?=
 =?utf-8?B?ZE1DMW0wM1A0b2ZPVVdCYjI5VDRBRU05RG40MDZRNGJaMWpmcjZmaEROdWVK?=
 =?utf-8?B?RkFNdjg1UlgyY1RmSzZLVTBKa2duSlVjckNXNjdRZzBmR0VGUFhxWDdsVnZM?=
 =?utf-8?B?TWZCajhISEQ5U0xudGpwTDFNajlkMnc1cE0zNm9EbktJQ0ZzOHNEQkVOczNm?=
 =?utf-8?B?SEhsR2R1SHRMbEEzTTBkdWJCb3ZhTmYyenMwY0tBcGdBMUhralN3SGNxRFlG?=
 =?utf-8?B?eGYzTU1SeE1Xek5XeklBRDlHbUg1aXZkQ1p3RFRkOTMzSTlZbVQxQ2hQSjNG?=
 =?utf-8?B?aUlHYThUalJmNkhma2NFdG43NXkwVEFpeHd3M1hSN29aaXRiSU40L1I3MWdL?=
 =?utf-8?B?QzVjdWd1c042cDlyZVY5Y0FnZWtjVVRBUUdKT1duWUdxYkxXb1N0eGxscGhZ?=
 =?utf-8?B?czlCMGxkcHlVdmU5ZzhIMG5ONFhVdDB6M0U2WHJFWjVSVUh6Z2N6V1dZN2tH?=
 =?utf-8?B?aWNBMG9BMGJMbWRleStPMGUrWXUxMS9zRVF1cnIwWGdUblNCQ3d5K0x6ZG9l?=
 =?utf-8?B?L1hxOU1EOTVtZ1J3azQyTlB1OWNPdEtNNGIxSjFiQzNxOE9mL2lLTDRlYWVt?=
 =?utf-8?B?QlRNUEc2Uk9UYmkwOGxBTzFzcHpKQUw4YmtCdXhSWVZlZko3Rk1JTG9QTGk0?=
 =?utf-8?B?ZmdQNTlzd3M4L2MzTmxBTVV1MFNUME4ya1hmOURMSGxyTDZXQ2UvRWo2bzdh?=
 =?utf-8?B?QVZCMXFHMUJnbnNFOXE4U0dFZnMrL2EwR2QyOXI0NGtDMGpiWk9CWFhJQjFl?=
 =?utf-8?B?OUFiTm5lK1creUR2NTFka2JHQm5iSEdpYWFURUxITzJpSTdSQmNnZXMwbUJ1?=
 =?utf-8?B?THBpOHJ0RDJlZjdFdFZERjF3TURvZ2R1ZWN5d2J6ZFNoWE1zUHBqMk52aXFr?=
 =?utf-8?B?dlBJYWYzTjkzcndiRWhWMEZ4ZVllNmFMTVpTeWZKOHdSTFVXM1NzUUJkaFdQ?=
 =?utf-8?B?K1pSK2J5OGFuRTY1QTBadjJJdGxiWTFhYkd5SmIyV0xCTzllTFFEOEZDT0xX?=
 =?utf-8?B?SCtaTFY3U21lalBPeFZXZWlNM3U3RlVmNFJ4anpVRExsbWpYWDUxcmF2K2Qw?=
 =?utf-8?B?Z0hMUm1lL0VobHNBeDBJSG1xcjFFbUdGSFFXZE40N3BYYXY0RjFBOHBTYXY1?=
 =?utf-8?B?dmw2RDNEN1FnY0tHYWo2bXozazFEcEVpZkhuczVKZmRCdkMvVnQ5YXltNFJJ?=
 =?utf-8?B?QnF0OGxhcncwU0drU3FkQnE0M3ViZmF1WXNYNHRVdEcwUk11bm5KL3o2SlZs?=
 =?utf-8?B?OW9xMCs4QjdURGZrU2gzY092b3paUzYyeDFERzE0bGtMWDRJSkJST2ZVNkUr?=
 =?utf-8?B?RTlJZy9sM0JNVHJRYXVHTXVaelB4Qlp3REQ2RkR6R0ZKTUFodDROM0lPa01K?=
 =?utf-8?B?My8zYmxNUVZ1ZlptYnlKVEdjRjF2M0dWR29YaG5zUGJZREpIbEwzYUs5bWla?=
 =?utf-8?B?WHdwdlE3Y3JEc0ExWlBXWmZ0ZmRhTXN6dVhPMEZNbklKSEYyRTUyRkFpaWRz?=
 =?utf-8?B?WDgvNWkvNnc2WStjd1BGdHlPQnNXMEc5eUU2R3htZlhBQzVXU0gzU0dYeUpR?=
 =?utf-8?B?R0lkaGl6YjJvVmxsVVduejlndDVJbjg2eXF1bnovZGl4cGo3ei8wRWZMdkYx?=
 =?utf-8?B?WXJwaytGK3ZqRkI0b1lwUXFVa20reGVHekNwOUQrUERxVmJZaFB2NzFIb2hD?=
 =?utf-8?B?cVhWdC9aZWwrem1DVkl0bytRQlBqdzg4Q2F4M3UyNEZwcjBqckViaTg4d3Vm?=
 =?utf-8?Q?V4fr9L2yNiC4neEp8V7uK0c=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4770e0df-c5e8-48c1-4e01-08dc7b37ab85
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:50:21.8106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8duou+eosAUTbNpp/ivbUgCSWQCodA43TJNkAwHyjY4gSWbry/ce9FPrOQllEKWKYmhQssLqBA2Zl78f8OZAeVBEdLoDcsICfDlOUN6FgvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> common.h header is marked for removal treewide and shouldn't be used.
> Remove it from DW MMC driver.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
