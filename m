Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB0C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3AF8490A;
	Sun, 12 Jul 2026 20:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MFiiuaSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EA3849A9; Sun, 12 Jul 2026 20:20:44 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD7D84852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl+L6tm72IAQtsWvUOCh9CxV+aazGoVAnA1U5nMvhtQ5JynTIKbhpEw1wE960JEaa9hkIOXVlyRZ33VrsbnHSorfF6ZpbCUzRi9UwA/kJKFXYQMeILvfxluipz0hUFYRL3bVSFZqijxPwkkZChfnCDkQqd8w7QoC+p2J0Z3N/383QwKXeLZJIgIrzU3iUv2clE+Y1J0BE7Ke/ofKMHysDRKPkc2iVmu0SZ7UDI2XQvsxsd9goJw5D2WgA3iuCsy42hbAWPdwbmdRwuM1NMUKBzUe8GY2tD2h+/Mo7928/O9Q77+ffpoHJb2g7olNVaWnM0lGCBf2hj7y6tk4Uzd2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNKZpWEzf5Rvl211o55eIUIYaJHGNQXlWHBGNJ9P28w=;
 b=BCY/D5zt3vCkY80X3uyQXPwnaSjXBWSV7RCMbPEZ+fFbMBlFrb9zprfKw1B7JyAXxhvtZvqorLN1wks1ccbxX1uHPIdRtQ2Na0bSL9vTbKTsLPAisyn2m4Mp9t3sFsm6Pt5UR/ROCuzamhEr2Y2fMsk5zr/nIQd6NV/rub4/KMRcyDuqe72tKVwaRfTp/DntvoIGhoR6xOlZiuRmHngc60YfZYzKByt8fDpF0rxCiQryPfc8vczUIqiF5aQYZV/VY/IQ4RJ5AX+uRDzUpZ+IP2uQwkMvYNBGZlkKqhbkbHaNYZhs4/5CTo5EdxLVGP2hfEL+F4W+FVSIgyxwmZ6XFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNKZpWEzf5Rvl211o55eIUIYaJHGNQXlWHBGNJ9P28w=;
 b=MFiiuaSd1mRbppEvKdMveM6FRUaa4BJebzp8h0MYKNnf8zapp9zioQzeXvlVCkU1z1Is4g+HKPW36C0dRbA/xfJhvKt6LKLhAZxXT0YCMAoVW9K4LWctXBgkAyQOGlH+LPrFyi+UfyupZAMDaCGhEBdPOVT8M6DmqABMzTATCcFEgnEUYuWY7vwMpkD9L1E1hm9Hi37p2FGU7S1C40v1vWrg42YpZWeoI9iGpuATfBHqf/gvsoWdQJ5Sa322RVVT8Px8vtoS+aA/LEMwsS/iS1S88k/SkedbzqQJ/JSFoWasGCqdB2H4HN/JJMNPQqpuTNAqTxZPNn6bfFDY9DCWHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ2PR03MB7473.namprd03.prod.outlook.com (2603:10b6:a03:554::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 18:20:37 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 18:20:37 +0000
Message-ID: <4bcd0013-787e-4b9d-8641-547e1e714225@altera.com>
Date: Sun, 12 Jul 2026 23:50:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mmc: fix mmc_deinit regression when card is at 1.8V
 signaling
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
 <20260712-mmc-fix-v1-5-99a1136bbe54@nxp.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260712-mmc-fix-v1-5-99a1136bbe54@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ2PR03MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e80f37-9368-4126-a444-08dee042452f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info: fUL6EHHg7usCx+xMVDQgk6yy65TwqC+NVp1rROwn8gJiu9EBwruzzZV7u7McwrhG4KYh3hMHop39tAfxQ9RuKSkDaeWm8cyjbudMjWFB8HvzYyMxmrScrYx0dWGOqtYIG4Q7Qwldu+EBw5chbSGAOd1GYU0SgBKnKPQ7DsjY/CbZb9wYCO/aM/ISpqOD4rLNGaf4tr5bLTX6majy16P5nAJtzGb7wOkg+E22ydVuQrs+jzhYEgnjAOpkquT4bIMqlX1/g5j5P3CgK5fp8umMQiP1CRzJkO0JDx0S3LC/tRxZ/3j7r1/z0HUOtxsa7OK3wmrDDYw7bP1DLAxqXAzjBS+CdUTCzLo9tvFwuJrPBmRaxQuGl+k15B3JRa8bZnhA0MH3XjyyRFDE302oAArGVcvzsJ47bWhsBHKmVA1zdZEehBTvJPxJZs6xZsa5y2ihsjNTZS7ASQcC8IRFu2Bi4ICJOci5TNBK3s6ge4/tK5L2bmXmO1O8jXgbtCsEcSVPKP8hgdWny2KCa1MyMSWjgokezyyOXEp+mFfpjsHEmYMSBx4pkTArCW9dL59o6N6COQRidrCKYZmkppz9gSUJQW4Fd4PkRVcIOkcCis8QXvJ6fPntH0Cp2pK6d9chHxfcl2GXpoK7GOY5sMZHKwM0rdMK7XKM8RR3SladCJ1gRgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWp1TUtLVVhyTUZHRFlVVVdCS2xWVG4za1JZVlJCN1NGNVdIMkdXREFDVnpQ?=
 =?utf-8?B?THF3cG9tREgxVHoydnNtS1U1OENPSnh3M3QvYVB4REhyK1pBWjZsWXVwakJD?=
 =?utf-8?B?dkMxcWRodFdWM0JyU01sOTJHa2lXZUtwNnE4Z0NXNW4xbWlvTzdDSGhFWFlB?=
 =?utf-8?B?WWo2dzFhVWdBNGRSWnZidkdjdDcvMElXTEFHM0gxSjBkb0JTVjBkSW55bk95?=
 =?utf-8?B?dzhOQkp6UnlOVEw0elB6M1E2NTRlZVRyelZmUFRPSFEvK3lteXdOdllSNG5q?=
 =?utf-8?B?V1k5S0tJTEhCdnZMRFNYUWtxZ0VCdUYwQUJVc0swVUVtNGd5REp4TldmNU5i?=
 =?utf-8?B?MU5iV2JMTXhHWXkwSm05WVpWZyt0WVpmbUNPb0czN3NDWmJtVjVKYitzc01k?=
 =?utf-8?B?TkFMUXlsMTJOUE54a01jbUNmdEQ0cTN1NmFmOUFnOEdmTlozazRSVHNsVVVC?=
 =?utf-8?B?NnE3ZkNOOWQybTd2MXNZRkNXckdsdk9hS2RTaDJpZnRDenVrTHdTNVptUW0x?=
 =?utf-8?B?eElQaGdLbnpPZ3lqRHJJbmMydlcvYjlvb3B6WWFEb3VlKzYzL1hRRzJjWFc3?=
 =?utf-8?B?cG9wUy9RNDNodUs0NDdGQXYydXE5ZDZFYTNxYUUzNlNVTWhlY290YTFtbE5B?=
 =?utf-8?B?ZHBwdDNPVXpXWjVwZUhoTGN3RlRBUXNpSHhsc1laY2RvUkhmamRob3kzUGNt?=
 =?utf-8?B?TmJ3TXIweEVYcGpIWWhNMnM2TXc0ZFFNTTQ2N0RtNXlpTXIvaExEb1A2REVF?=
 =?utf-8?B?YjNjcXdGNGNrdlk2VERGVFU3L0ovUkNmZFlLcUV1NGZ5T3Z3OVFuUHp4bytR?=
 =?utf-8?B?aHBnbC9PRnFlcGxKMjlEdjNRUURzQkVWaml0dkxUOTJORDBOYWFPWVRXMVhF?=
 =?utf-8?B?aFNpcDdWM09ZRUFMSFEvU0czYTU5ZDM1d3o5WkErMFpBOUhLVXgwVDRwNEF1?=
 =?utf-8?B?TFRFM3pqQm9KV1AyVVhsVFAyWWY5TW9LOEdlSFFOVkYxMnQxWnFUUEh1WW9m?=
 =?utf-8?B?UzVNVGhVTG13R2x3ZzQyK1VZUmlrL0xSR3R4dWpCZ3BCNFc3SnBLRkhPVFll?=
 =?utf-8?B?UDBqU3gyemE1RGJuL05oU094bHlUUnlOdzZoRlhmbXcxZE1VdW56N3JSazcv?=
 =?utf-8?B?SkgrV2h5NEJEcnFwSlNVUENpMHpPTkJndnhQM1M2MTNvd1BNMnNGUUVJdEJW?=
 =?utf-8?B?NHNORm82N2JocHphd1g1Q3hXa1JINm8wdTZ6NHZ5WVVJRUhxTUlKTGgwZTBK?=
 =?utf-8?B?S2c1VitpRDJyc3NpYjBuVUdJRG5ycXByZmFUVnBMa0FrMkttYWNkZmlWTXZO?=
 =?utf-8?B?Q09MNVJVaVdQSDhXU2xqTjI5a0ZxQVB2cW1BYmdrYlF3VytxK255ekV1T3Ex?=
 =?utf-8?B?aTdLZVBNbkFUMXlXZTBIUWREQm03bW1QZzlCR2VSQTBvbEpZN09ManhxeFM4?=
 =?utf-8?B?K1hzVXlJV1lVM3phQkZPZjA2cDJ3NGVsZ3lMNXZVK3IrYm9oUjREb09kY2tH?=
 =?utf-8?B?SmhwNDFydjVUeHE0Y1ZkQ1R6Ymh6T1VJVkZYNGNzc29adXpvdktDcFQ0WVcz?=
 =?utf-8?B?M2Nia0w3OGRpNEVmdmdLM3A2STdhMGMvYTdMem1Na0UwWkMvWVowT1JHcGhD?=
 =?utf-8?B?RlVZODZPWko1eHFjb3hVMjlPR3JHZUxDcldpR0F2bS9ZZEc3eDQ0OU1vV1JJ?=
 =?utf-8?B?MUZhY0V1eDJOWU9UbHlQQk96MEpHZHd3VytDdUE1M2svYXZJbVhpQ1c3ckJH?=
 =?utf-8?B?aXQrdzRLUkdqTzZkQmpzanVFbitVY3hKOXhuMlBtNThnUjBIcW1XbmJhTDBw?=
 =?utf-8?B?MURNYjduMW9vREV3VlcxUyt4SnRaRFpvMHlMc1ZDYVh6RkdENFNZNVc1RTlh?=
 =?utf-8?B?WTJ3MTRMZkh5T1FxYmtjYy9oWFlKUDc4V0ZpMU9MeGFXWU5OTVNUUEQ0ODZl?=
 =?utf-8?B?NjFpZjc1K0NwWjVtbUNMWlZTeCtscjBkTlZMSWxnYVFtaFhjOWNaNmliQWZL?=
 =?utf-8?B?Sy9ib1d5b3dJTUgvOW5qSmg4ZHV0K0dzNkFldTc4N1NabXljUEdZWFc1VnVM?=
 =?utf-8?B?aWJuV1NpQ0U0clFjV0dkcnVYR04xSGU2VmhFWjA0dFlKa011QTNuRVU3Znll?=
 =?utf-8?B?ZUpCSSswRXJBdTgzZFh2Y3pTWElSNDF0T2NCZTl0bERGMkFydEdrcmNSTDds?=
 =?utf-8?B?aE4wM2U0M05MbXhWLy9iSVYrSVgxcFc5aks0L1BSV09iZEtBd3M1SklURzh5?=
 =?utf-8?B?TWQrazZKTkJFSjhmT2xUK1ZGS1JhRFZiVjkxeGVNenJIYzJja0Z0QlNFN1dL?=
 =?utf-8?B?OStVbmtDZW1ZOWo1Y0JTNFhWYXJrQnFtUFFuWUE2YmNFNUNKZlg2a2pIQXdp?=
 =?utf-8?Q?5Pv/nCxXoDcq5qiA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e80f37-9368-4126-a444-08dee042452f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 18:20:37.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+IKCkBxHGNgWNYchufiF13FhturE/5j/GrH0PSyjO8aTn2jOeNYvLjhSoiy7pRj43ipi2tEv+7zqDX3XnSsl2p8o8YrC345OSFGuDtR0OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7473
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

Hi Peng,

A few comments.


On 7/12/2026 6:37 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Commit 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without
> power cycle") added detection of cards already operating at 1.8V
> signaling via mmc_sd_card_using_v18(). This correctly handles the
> warm-reboot scenario in mmc_startup(), but causes a regression in
> mmc_deinit().
>
> The problem: mmc_deinit() strips ALL UHS capabilities from the card
> caps and calls sd_select_mode_and_width() to downgrade the card before
> kernel handoff. But sd_select_mode_and_width() now checks
> mmc_sd_card_using_v18(), sees the card is at 1.8V, sets uhs_en=true,
> and tries to use UHS modes -- which were just stripped from the caps.

Even before 906ee6785b1c, sd_select_mode_and_width() computed:
bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
For a card that has switched to 1.8V, OCR_S18R (S18A) is already set in
mmc->ocr, so uhs_en was already true in this path before the commit.
So sd_select_mode_and_width() did not newly set uhs_en=true because
of this commit; that was already the case. Could you reword the
attribution to reflect that?

> The fallback modes (SD_HS, MMC_LEGACY) all fail because they require
> 3.3V signaling, which the card cannot revert to without a power cycle.

I think CMD6 switches speed over whatever signaling is already active,
so this doesn't necessarily fail outright - it likely leaves the card
in an invalid/inconsistent state (a 3.3V speed mode while signaling at
1.8V). Might be worth softening "all fail" to that wording, but I'll
leave it to your judgment/testing.

>
> Per SD Physical Layer Specification: "Once the card enters 1.8V
> signaling mode, the card cannot be switched to 3.3V signaling without
> power cycle. If the card receives CMD0, card returns to Idle state but
> still works with SDR12 timing."
>
> Fix this by preserving UHS_SDR12 in the filtered caps when the card is
> operating at 1.8V. SDR12 is the minimum valid UHS-I mode and is always
> available at 1.8V signaling per the SD specification.
>
> Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/mmc/mmc.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 5fd12d21f92..809d7b6b578 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -3178,6 +3178,17 @@ int mmc_deinit(struct mmc *mmc)
>   			  MMC_CAP(UHS_SDR50) | MMC_CAP(UHS_DDR50) |
>   			  MMC_CAP(UHS_SDR104));
>   
> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
> +		/*
> +		 * Per SD spec, once a card enters 1.8V signaling it
> +		 * cannot revert to 3.3V without a power cycle.
> +		 * If the card is operating at 1.8V, keep UHS_SDR12
> +		 * as the minimum fallback mode.
> +		 */
> +		if (mmc_sd_card_using_v18(mmc))
> +			caps_filtered |= MMC_CAP(UHS_SDR12);
> +#endif
> +
>   		return sd_select_mode_and_width(mmc, caps_filtered);
>   	} else {
>   		caps_filtered = mmc->card_caps &

Cleaner to decide the mask up front instead of stripping then adding
back, and reuse UHS_CAPS instead of re-listing the bits:
     if (IS_SD(mmc)) {
         u32 uhs_mask = UHS_CAPS;

#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
         /*
          * Per SD spec, once a card enters 1.8V signaling it cannot
          * revert to 3.3V without a power cycle. If the card is operating
          * at 1.8V, keep UHS_SDR12 as the minimum fallback mode so the
          * card is left in a consistent (1.8V) state at a low, safe speed.
          */
         if (mmc_sd_card_using_v18(mmc))
             uhs_mask &= ~MMC_CAP(UHS_SDR12);
#endif

         caps_filtered = mmc->card_caps & ~uhs_mask;

Regards,
Tanmay

