Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB41C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C8B87F24;
	Thu, 23 May 2024 17:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RvVhHEGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E2D885BF; Thu, 23 May 2024 17:03:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8377387E9B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cas9FCMt1xYpruZCLzviJ0q/wtoQkUKuXhQsE8UTQJl7sbvS3HUrWjrVzWZDRMlg8PLoXFR4DT3x7oHzYtEIYtJPFfx/DZljDFAHsVp/UrAE6yc/P7pt1IOdjb9XBLfq4rAWSsYBgYTMGZzMpfzR/QDymrvaFLDngFPJW1QL2JLCwL01SJIgLSQfIfFft4TOFqwLIC9ORlZM49phEELHis/1eQI4wMxTNcusHoFOdT4umpdlhJLDcCDCnUFsu2EIlSwBXZY/sldwy8+xK/85pVYLdg/B+rQMTrbOvQTP4dQwl0XyRMMCB9w6eer1CGqCaCiVykRU1fREePhLTfK8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSCsEWcECKlO2bKgpIEeI+rAb1jNIQ9mYqzF8d8E88E=;
 b=Pa/IOzLbXQqTDVqjY+0ufYR+wtlSHwwpXREiRPWFK++pCrzCKZZvLTgxqzpbAkf/G4rnl8LJcdecElv/bXibcONBl8+T9xRIDDmeGxgQxXUTWzz3fuN8ESQUP7LJFKslTw4g3X7sia+RluOocHRjd0TYIGh0qo69dzu0zeAM3RIulBjUSZC3vsFcQ2W+vIe18CYWzENctn0jV7K7hRwEvIizPr0kekA0r9Xb7ulINb6WCBL5MmWd65NY+9VAm/nDd4VMwGoJNQwN/W7Z6RrYCN29rEpmL3eCoFB4ctbQaAuev7NTBDguN05bV532NtZJb+rtGVYty+bPq9DfDQDVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSCsEWcECKlO2bKgpIEeI+rAb1jNIQ9mYqzF8d8E88E=;
 b=RvVhHEGyX6tl2w/GcIuoBNXrpvZGmqdUIKcL8VP4Vl0DjOuE7hSF+YEa5XA86bUWACG26fE/TaYkHxSRdJagKHbDc7sL++XUv7+JoSZ9TuTuTgW1dhhe6W9eA5ArnvTJ0iQlv5doYfM1gaqd/ZsnpFpPbS4C6DuUXUZ7QbtWHzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:03:23 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 15:03:23 +0000
Message-ID: <b06b361f-8587-471c-915b-60e030320ad0@cherry.de>
Date: Thu, 23 May 2024 17:03:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/42] mmc: dw_mmc: Use CONFIG_IS_ENABLED() to check
 config options
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
 <20240522233135.26835-15-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-15-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: aed12148-1c61-450d-597d-08dc7b397d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25hM3QwcXRVbGdlbHI5OENVbkV5aEsrampwUDNSWG1sdDJIcEk4eGc3T0Rv?=
 =?utf-8?B?eVBVOTZjd2oveWRSdTFlQktsRkRpMU12UzNWaHFIMCtmOXdlNmNGOXhYTXBS?=
 =?utf-8?B?dVBnckV0VGJFT1M4R0tTMnY2MXh6b0QycTF6QjJZK3QyQUJqUndUdU5RT1JS?=
 =?utf-8?B?T3U5ZFJGYUU1Y3lKMTNFVkNYTjVOQTdXVDFwMzgrak9KSEZSOFFBTjllN3Rm?=
 =?utf-8?B?ckQyUU1HSTh1Tkdpc3lmOFBscHpwSjdCNzFKU2phTmUvd2hUc0hmdjlUa0tz?=
 =?utf-8?B?K01WYWp0c2RVUE9QdElDeDZvbFU0Zkd2UGJ0KzVKTjBWS2dsaG9ra05OWDhr?=
 =?utf-8?B?QnpBVStDTXFWWTl0bFYwRm5ScEVZQ0ROUHg4SmNIbWFhUi9QNWJqdkluMHFk?=
 =?utf-8?B?eFQxU3N0QUxSZDY3WmZpL3dTK0xXRzE4Rm9NV1h3RXF6WDA3QzdYUjJlMFR4?=
 =?utf-8?B?bWZLa00yblNRaEIyeU12bjFGMFJkUmlvZnJHZHV3SHFWSW5QOVA3STM5RHd4?=
 =?utf-8?B?OHNKa1UzTXV0YmVDS2h2TGpjamhUR1lFMVZUMXFyNWJKb283bXkvbEJTam1p?=
 =?utf-8?B?M1FtQkp1T3B1TkhGMlBYT2FpU3oyckJwSDBHTjJYa3U5UnJIcGQ2SDc0MUZ1?=
 =?utf-8?B?RDR5NWdpR1FLbXdQSDhYRzlFZWVyTkZ5S2tZNW9KQ0pnekVZbU16eWYvNTQx?=
 =?utf-8?B?ZEkrQXdPcWljcjBXZ0NZK29pYTdPZG43bUhvV1JicnRBOHVONm5MZGI4bzJy?=
 =?utf-8?B?SjVXN0JpZUErWWhLaHpDUmJ3T0VFL1lZVGRVR3hvNmxrelRkdEpRSForS2J6?=
 =?utf-8?B?ZGp3UXQyOE1HNjJwSDdpQlZQa2NIeHN6WHl2Z0tHa1k0N0Nnay9wbkhMc29I?=
 =?utf-8?B?ajZ6WEpZWUxYTklFb3RsYjFraW1NV3NQWU04QzlzbU9GTkp4UnYzdDRncWcx?=
 =?utf-8?B?Wk5BNTc0TWN6ZU9ZaEpTYVBhSDB1WDVxWkxQelNKK29UWVcxR2MwemNTMDMx?=
 =?utf-8?B?TFk4eDNTOCtwazU5U1R4Y3BxK3ByTFd0UGduSXVzcWpXZnZPQk5weklJWjkv?=
 =?utf-8?B?WXp2eWJmUytiVkJKd3AxSVVKVE9FNmk2cldaTG4rTVpBM0lsSEpBQlU2YzRT?=
 =?utf-8?B?NW9DWWFrNktOdmZhQkd3QnVLV2lOa1VsdzhmRm9NK3dlZDJpUW4yNUJ3cUVY?=
 =?utf-8?B?V1U1WE0vdXlqM3ZITmZGbldsYndsTTh2NlFKUEZHVllFMisvb2pra2ZWS3VU?=
 =?utf-8?B?RitMdkgyaTBkbmxkY2NuRHFrNlB0L3Q3OEtNdU9TK2ZJOHM2T3hKRFR1M0pK?=
 =?utf-8?B?S1p0QWFnUHdKYmNuTDZtcjRCa2hJYzZwbWJFeWJjWGtQSzQwMi9vOGY5STFp?=
 =?utf-8?B?U3VMcFpoWVpOaXNibUVtTWZHa1dINVZ6UVJ2clV2cFUvbDY4bWFIbm9yL3ds?=
 =?utf-8?B?cjdMY3F4anBjY1UwZit4YmYveTI2eGJkVGExNkJZdnpFMDcwNGgvQ2tLbG1y?=
 =?utf-8?B?a3hFd0lqUDZ6UXhNT21BcHp6SVdaemVGeFJZTGp4Z0NrWEJpbm5uQ01oWGJ6?=
 =?utf-8?B?ekhFbWhVa2lwaXJhNG8zaUdyaTFzYUZOb3doNkpyNWlwUHI0QW1ISE5Zd005?=
 =?utf-8?B?RENyMWdFMmQ2SEJyUkpONkdUVzhsNEFRV0ZmMzZRTzZZMkJieldycnM4UlFv?=
 =?utf-8?B?Z1ROdm1acVVIM0ZTOUlkYlQrOFBzbmkrT2E3SjVYRWJPZUFlSDhWdVVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNvMTZKUVB4clprdnBxN0lLK3B4Z2p5OFV6V1lrYVpGZ1B5TFdlZThSS1Z1?=
 =?utf-8?B?QjZoRFEzUmtGSUsrVEVQaVViSldJRE1raFJlaHFOdWNsZVhRT2Q1N1RKWjFM?=
 =?utf-8?B?Z2ZyVU5qemtNcEMwT2lBMFdXTzJSWHFsa2d4Y3h1RWYySkNRRTBueEF0MFYr?=
 =?utf-8?B?Rll4YzdsWjA0U0Y0NFdxWHBNSkV2TGJiMC9yVW1YTHkyR3JXUmdjSVRxRmhm?=
 =?utf-8?B?WHRqbTkvUDlyQUR6Tjd1V1l5dnFIUTBteCtGMmFGblJPUDM1dGlkdkhSUGtN?=
 =?utf-8?B?NmZBMmorckFYR0Fwd0dZT3RMSzc1SnBUTUk1ZVhlR2tqbzI5RVNiOTE2dS81?=
 =?utf-8?B?TDVwUVpReUlZaXE5ZnNQb083Lzd0R2xhaFpJSUh2bVptUzVGc0xEY0ozaVQ3?=
 =?utf-8?B?SkFuRmF0cFEwbUMySmEyM1ZUVlg4ZHZJYWlOZDVRUnVOb1RWbVFmYm1OQ2F0?=
 =?utf-8?B?Vzdmd20xQVlUQm9BclZKcXF6andlWFIvVG84bWhyd1o2YWhWK1JqK2RqZ3hy?=
 =?utf-8?B?Nmt4MjcwYkIvTE9wdFo1NjBTV2FYVUJob1pmMVR0M0VQY3pUa0Z3YnNmNzJo?=
 =?utf-8?B?cVBvSVJaSnZNakRqYlBFNEpMM0cyc0RUcG5RSUkrV0ZJbmt6d0s0Rm5lb2tB?=
 =?utf-8?B?Mzl0bytTUnBYR3lteDUvSG9GdUJDeVdIVk5rYWVNdjZpNTRnWTJCU1ZuWnRy?=
 =?utf-8?B?azluNldGKzNzTlNDbTRrSUQ5TEpPNURpc0VyTTNtMGNaRkxZL0VNVFpveWtD?=
 =?utf-8?B?aXZYdkN2LytZME1KbWdWQVpxOEpNYTZLNjFKcklFMXpLRURSbmN4RXJ1cWp3?=
 =?utf-8?B?eExXa1VBNkxZb3ltbUd3Mjl5RlQxUTBMTGlncFZXY2VESUdFdmNhc0RrUTUx?=
 =?utf-8?B?Z3JSbU9UQkZTZmpxZncxU1JLT2Y3dC8wbVVNeFBka1FSSnZHRlN5ZWVnVXBq?=
 =?utf-8?B?OTdNRlNSaU1ZRDhhK3BSTDdJNFNVZm10Ly9CZ2pIWjJtajUrRFF4UHlDMXIr?=
 =?utf-8?B?WUVnK1VqMmlxMElXZnZHVlZiYVYzYWllcHhMZjdGTzNqMHdnZ3ZMeGw1MEp6?=
 =?utf-8?B?Rk93Q1c1RzQySnh6MHdsSWxJeHZvaTc2d252VFVmYUZqeTlMcGNaREdOZU92?=
 =?utf-8?B?dnBScjlweGtpTXRwN3VyQlFnaXlST0hYY0wrQUU1L3Y0dXlac2tIVXQ1OUhY?=
 =?utf-8?B?bkl0TVJqa2t5RElqRm0vTUk0VWQ3UXg2NkdJVEhGN24wUktvUXd1bzNvUFp3?=
 =?utf-8?B?Wm5tNTlwNnpHYmp0Tm5DaG9zZXVnaEpWcVBGRlFvbjFBRzV4ZFJrb3ZtMmd4?=
 =?utf-8?B?aURaNS85d2hGSUZUQ2p0MjhKNXN0a2tlN1NyeGVZeXFXL0czNFZZckpYNTI0?=
 =?utf-8?B?QXpUMHI3c3luOXFKdlFmNjhIS3dEWjVSZ0xSeEp3bDUvMWZYbXpTQnZsS1Qr?=
 =?utf-8?B?endVZjloSGNJZmdsM0Nkd1pOYVBiSUVBaHJsSGlvTlBreTBKVjFjWjc5TFJ1?=
 =?utf-8?B?SVcrT2daQjRKdGx1ZiszYUd4MXViR1ZuQ2JXN0lIK3BqZkd3L243czJkSlFh?=
 =?utf-8?B?ZytMelRNU2pPaC9ialFyTldEQjNYWWRPdE9nQmZDSnRNMGpjeWtmQi94Wm5L?=
 =?utf-8?B?TjZCczFnZTRNUWlRbDFhNzdSeU9wYW8wUllOTWZqdnV1WEpIRUM4WmxqMFlp?=
 =?utf-8?B?WjhRN0NJRzRSRndBK1BlQzlRNVV4Umw2QUFNRGtDVGN4emppNWp5dkQ3WlJN?=
 =?utf-8?B?Y3JnVnpDUkpMUGR6aS8vWXRZdEU4ejZOUkkvc29VaXIwcWRaVDR4S0VSUWtX?=
 =?utf-8?B?RlhicHhTenpWZEt4MlJjVnpGMjI0NUhRUVJKMDlVdEJ2MDJhZld6VEVRdTB0?=
 =?utf-8?B?TDkyRlpINHUvWTZZUG1jcTJiR1I0WjlaTHp3enl0RC9QcWVLQVphRlNZVE9I?=
 =?utf-8?B?VkVLd0Z5STRLdTF3WU9QMnl3b3BhME0yRmRRN2FnTnZ0YmdRTFBxdk5CbUVZ?=
 =?utf-8?B?WXlyMzRFeGJFVVIxVmlaS1V4eVZMWGJyY1c4SEYrdHVRRFRoVU1VY21wditV?=
 =?utf-8?B?SnI5WlFhNHR3RGFmbElXRVdTREw1VEFjak9IVHcrcFVpelR4RmRScXFBM2pw?=
 =?utf-8?B?NjRVSkcrTjhub3VsVHk5UFZYYjBCUGhXRElMQWdxeHVQZDFXK0VsZDRUeFhJ?=
 =?utf-8?Q?ORhmbX5scYrx1eCnPSKgfws=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aed12148-1c61-450d-597d-08dc7b397d7d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:03:23.3398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF+X/UMTeUCMXlgqSqg+0+6rfCguJAmHGMDYzthDGvDHGZT3TZiPecwa7v3sYAIVLysI5w3Qe+g3E57D3OPPYr2PutGh5DC7u0854EpWD2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423
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

On 5/23/24 1:31 AM, Sam Protsenko wrote:
> Use CONFIG_IS_ENABLED() macro to check config options as recommended by
> checkpatch, instead of checking those with just #ifdef CONFIG_...
> 
> No functional change.
> 

There are actual functional changes in here.

defined(CONFIG_DM_MMC) != CONFIG_IS_ENABLED(DM_MMC)

Currently, if one has SPL_MMC and MMC_DW_ROCKCHIP defined, it'll build 
the SPL variant of MMC_DW_ROCKCHIP but guarding only with the U-Boot 
proper symbols, meaning, essentially the SPL and proper variant of 
rockchip_dw_mmc.o are more or less identical.

I think we can argue this isn't proper and should be fixed. I think we 
need to migrate all the MMC_DW drivers to use $(SPL_TPL_) in there and 
create the symbols in Kconfig with the appropriate dependencies. We'll 
likely also need to modify a bunch of defconfigs or make 
SPL_MMC_DW_ROCKCHIP default y if MMC_DW_ROCKCHIP for example, so that we 
don't break current support (it's pretty much expected to have MMC 
support in SPL).

I may have misinterpreted this, so please let me know where I am wrong 
in my assumptions here, but this does look like more work than just this.

Cheers,
Quentin
