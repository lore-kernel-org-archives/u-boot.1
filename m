Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6E2C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE738083C;
	Mon, 17 Feb 2025 16:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="haTLCfMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6769380843; Mon, 17 Feb 2025 16:21:44 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552F0807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuw7jTbdOY78l7g9mnRvbivroDN17azfmJOvO5yhrf+uXpEoezB5u3LFYRI24dpnb2HUzUFSjtZ2xVpFWKYBlGgKmCYa1DqiO7iK16iZUJ2jBjg+Aq6+I1TVOtRqbEGIISeAD3squji8gIk+wrdpzuD4Km87oxWEUwE+btWOiFT99FYaXR0JzcGauj2TisqCMsdLlX1B+sAIA9qmiEazpHDaZf/C11D+7dmRbAOBCwnuus22LVRYd6t5cCys7Ek1h7OpG/KCgsGE+tUhnhnYRl4ACcv9Jy9YXoCCUwsA8tCvbhINiqFfQSZ9VQxlTAz6h+QAYicizK6LuOGCYr0ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL0V/cMU+vLmUeDWINBgtHOymxjiJfRKL/fwkNvM3cI=;
 b=SK+qLLxgUG30C3JEMkbLodLdfvrHnjTMiv6YhDv1rkjs0ZVNGhfCm1kCUTHUeXw5tSm/9qa1qEIntxpDYPBVKGtqCst0cRNDiqpHsxBVroS9IMmuX28md/8K7j5eDe/b4MeoaVidBrqzsLQm6FWCCO4gVTY5bj+eV9VDUaUsdiqFJgbAjx8zsw1fHqUsYKKiwBJEaZ1piIG4dzloJqxiSAkpNeSIv+DsX6km37cD0A84J/a25VEylpzexUopS9nLCbPG6V07d5smwwAVDkTt3x7+NW8wanyYFj0/Ej7jX2Qy9tYXn487OjGldoiTVHTJmpx+7+xfrI8E7Qa7Eb0v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL0V/cMU+vLmUeDWINBgtHOymxjiJfRKL/fwkNvM3cI=;
 b=haTLCfMXkuWnyvtihM4vNXdiCDGvdmDFC6OFX3zFiYVGRgMlLPCe54RllRQFs4iggkaIHkI5Zbpq1xteDH7I58CvL9wagh9hVXBFDEVEkI3VXkTf8tnehoXU4XEe+jJGfQDFtojfTBVnZMA6GgwK2gPNGB2W2kME5dpbCBOsvy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 15:21:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 15:21:40 +0000
Message-ID: <dae7cabe-9f4f-4f3e-a0e4-6af65dc96723@cherry.de>
Date: Mon, 17 Feb 2025 16:21:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250213131104.186663-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e2505a-e14a-4e9f-8f2e-08dd4f66c740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnJIZEJFUFRRVGpQNE1ETkVQeVFDUXVNN2JSWk9YeXZZcWZ6Qk1vSExuU1hk?=
 =?utf-8?B?SGRXSmo5Q29DSXFNNjhYWnVseTJhNWFZUnF0clNzVVZBdnVoQjc0VURwM1Ft?=
 =?utf-8?B?bFhLdE4wTGtwYXhIeVp2L3Y3bVNtWkdtQTlQTXJiTU16K3pGVHN4WUZWMlVO?=
 =?utf-8?B?REswU3VXZHMvVWJjV1Y4N2NIdnphMVdRaFZmR0doMUZEd3V1Ly9kSjV0c3pI?=
 =?utf-8?B?bE53bWpadVkwczlvVHVveDlBMldZZ0RhWS83SExXR2JvcXJ0TXB5OUd0MFZT?=
 =?utf-8?B?WTNUQ2hHSDE3RXhXWkkwZk5UaEhwcjVSakZOQzFRVmo5V2gyM01VWDdVaXZh?=
 =?utf-8?B?Nmw1M2tpOVIxb2xoREdCVFU2c0Q0dHZ5ZFR6RjkraFFzaWV4a2dScDFXVnFy?=
 =?utf-8?B?RVd1YmpHK25oSHBrUk9NSGg2S1k1ckdzSzR6WFlxVExWSkp2U1MyemxmVm9V?=
 =?utf-8?B?aDFmYThJcFNCL1AxU21MKzhtNVVzWklUVTBtVXVNVE9UL09vZkFRaTBVbFI3?=
 =?utf-8?B?TmkyUXkyNGlUS1l2cmZhVEhUYWcrS3FkVXdJdjRVOXAybWlTaXRTMkFIU3Zq?=
 =?utf-8?B?c203dUd2bncyVHNVcjB1WW1lSWRLaGlEQXpFc0ZQOUJ2ckJHTDA5b3RhSTV5?=
 =?utf-8?B?SVMwSlNVaDNjREYvdXlNQ3JiL1JpZ0g5ZUxpQUVsVUFMZUNaYnN4clBtTzVi?=
 =?utf-8?B?UUV4eHpQZlRFemxZYVJHVllJT1lYM1E3eFYvRDByc0plYk1YZVQxWHhoYjVy?=
 =?utf-8?B?aXlDdURpUm83NDd1VzJKU0FoMG9hejFvRVdXYUN3dDNPOUN0cGc0MUUxTzBx?=
 =?utf-8?B?ZnJTMTlVdlNPUmxSMC9yWXFhQ3dqRzdDT0F1azdRNjNqUENOMk5VL3BGU2Zv?=
 =?utf-8?B?L1hsWkF5SjRTWVNLUmsydW03dDBQM2ZEVlVMNVRzVTFnSERtY1BueExjMFA0?=
 =?utf-8?B?VnhVY1pYU3RrWnBEOTU2K2UwR2dydEpXTVlLcW8vZkMyTHI0ZEVTOU1zUFhH?=
 =?utf-8?B?eHBYcTMxeDk5UXFDTUVvZ2xSejNHNnhSSXk5clVEdE1BS1AxWHdESDZvQ2dM?=
 =?utf-8?B?Mzd6VTMyUWlvZzQ5cDJxWjgrRUhETlNQN3hIcEVEcTVmSnM4bW50M1dNNkNM?=
 =?utf-8?B?MW5wekxGQ2pBQXViZ2VjaXR1Tm5RYWZlMW5MUE1lWkpZVlNSV01wYkpiK2FJ?=
 =?utf-8?B?MWZlSXY3aFNuZ0prTnpoZG00VHNwb1g1cDFPNkZOejI2cmpKdXM2WXNvbGh6?=
 =?utf-8?B?Rm1zR0xJTDNLcVlVaWpHbitITGg5QVltQUJRWVEwaENVMUcyMmpkY3NRbmt1?=
 =?utf-8?B?YjNGWTM1MHo4SE5KOW83SjhuTnBuOUE1U2l4WWEyK1F0TmlraWRoU2FrcUtO?=
 =?utf-8?B?S3E2aGxqQ0ZUWkxxQ04wYmNHZTVoanhVMHVLL1lxREJMT00rdTlUWVZGN2Ny?=
 =?utf-8?B?Q0MrK3pxVmNvT1k4MUN2a2VUQXFVNFJkNGpnNE4zVVRQNG5OZjVXcXU4Q0Y0?=
 =?utf-8?B?VGFwc2pqcHE1MmVUY1J3L1VqcFZuTzBDTlorZ2ZhdlNsb1hJajd1OFJwYm1x?=
 =?utf-8?B?NXV4MEpWZWxrRGh6ZWJIMDdqZHZZN3I0UzlINWo1SjJ2elQ1M0lBNm9oVGRy?=
 =?utf-8?B?dHBaWHhMc3ZoQXRMVEJNWm9oUkJvaXhFeGhtRUtCbUdTOVhzOE9iL092NUNx?=
 =?utf-8?B?cXRCdmVYS1BDaDZoczhPWXRUSVVJREhjZjNuRjM1RXV6bFY4czVhSzNOVGVi?=
 =?utf-8?B?THdIS3lINXdFOTQxYkpBR0k0K1FYZkdvcWNkZkdwYnhBL0lyNWZCVGpnNWNl?=
 =?utf-8?B?UTZlTVUxdGk1ajRwWFNTUUh2a281L3BZcjdONmFsbWc0THZaekQzbzM0WEx5?=
 =?utf-8?Q?KtDDjDEZ5CNqA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5SNjdwa2gva0Iwd1hGMStoTGZWaldQeDBtYTNQWnpROTZNYjFQejN1bnRq?=
 =?utf-8?B?UVlQY3pSaEpvRDVxUFBuRjF4eFZwbmQ3ejNBRkJkUWcwMVdqTFZTZ21CTFQr?=
 =?utf-8?B?YzUyK1ZhYkVZcmtjTE5LZTlPZ3NpS2Nwa05ZWTRhelZmMEhER0x2OHpWaVlY?=
 =?utf-8?B?RVRDcGpQNFJORGxJdEIxL05mSms0bGRxeDBuOWk4WHJpTHM2cENlS2x6OG5o?=
 =?utf-8?B?NUhvV3orNjlYVGZvd2wwREF3LzhIcEJYZWd3QzNJK3JjamRyL0tlQi9hdFNX?=
 =?utf-8?B?YW9uY0paNkd6U29paXYzek9KblNTcjJoTHFSNVdpOEF6Y0NVa2I5MVRzSnUx?=
 =?utf-8?B?RXc4dDN1engxekRVek9RSG5FUnBuT1lhMGcrelgrT3BYUy9RNDFGV28xY2RV?=
 =?utf-8?B?cStocEo2cUZETUsvQjYwZld6QmpXQmQxRnduNUcwQTV2YXZRalkrT00wRnpS?=
 =?utf-8?B?OHRQMnFYOTViSGpQYVJINDJPaGpXMzB0YWd4WkxMeXNMZGZSQUppM1NZSDBs?=
 =?utf-8?B?VmZSV2M1RzZqV1l2ZGt0bkhWTmlvUVJQdi9SU1FiMTJuNmdYQVZUczNSNVVS?=
 =?utf-8?B?dHlSRGJyeUd0OEduVll0bEJod216bGZqSkFOTVhPUGJKY05kOTVpemlaRTF0?=
 =?utf-8?B?UVlFS2hiMFg4cjNPdGgvcVJ3SXV3TjZXaXAxM2FtemM4VlloVVgzZDdoOTh4?=
 =?utf-8?B?d1dMcmlsTVI1V21MNSttK2ZUcDl1NXRYT3BVcElKeXVxb3JkaGRtN1R0WnVG?=
 =?utf-8?B?MTBKa0tyS0x0cmNyVlYxMDJXaWRjVXZza243NFlYWkpEMUVoV0lZMGtkQ29D?=
 =?utf-8?B?TG1jU1dIdVorVEd1MWQwNm40aUxwYnBDcm9GSDFaZHl2RjhaVnprb1FCWUg2?=
 =?utf-8?B?N1N2dDFGSVNhdTZKWmtwak5VQk4vcjlEeUJma25iWjcxMVBub2QrUk8wY1VJ?=
 =?utf-8?B?TFlCanVmNTBKNlRpdUwrb0szcTdqeDBTeXZtYWJlUm5DdEJGL2pFakdqd0c3?=
 =?utf-8?B?cURSUEdDN1JnSTNVQlp4a3VDQXZoVkRoSTY5VnJVdHFnemVIMXJCSE9KOWgy?=
 =?utf-8?B?MXI4c3BtekNNUW5vSGU1dTZHWm5abUJuWlJFREJqU2Rvb2dGZHBKZGUyQnph?=
 =?utf-8?B?dFRWWWh1VkxDQk9pVzlRU3N0UjRWcE5aWXB0SmdKRUVlL2p2YlRjYkZkR3Rm?=
 =?utf-8?B?MHdVMGVndzVpSmcwbjFRZFM1U0k5ZWxodWtuRjF2MlZWa2Y5OUExaHg0MUxk?=
 =?utf-8?B?N2pyQzhRNVVFQjk5YnhVd0c4UVZNblVKMmlHY2lIblhtaGVibTV6bVQ2cVVM?=
 =?utf-8?B?WTRkWE1Kd0JFT1JNWEs3dnhCaUd0dXpuZFo1ck9yZmc0ZDYzWW0xOXRYcjBE?=
 =?utf-8?B?MXJxUCtCSG9EeFhVWnRsRjlKT21TMTJGZWpCOFV2SVI5MmpWaUVrVENJVDdQ?=
 =?utf-8?B?YVp1UlYwZ3BWeWFTRGtXVnVPZlNzR0FKajF6Nnp3NVdHMjYyWFhxQnJWMjJG?=
 =?utf-8?B?eC9VWVhYLzMwNGZrbitLdElJaHo1eEtDOEVQVmN1K3pra1drRFB6N2VNc1o4?=
 =?utf-8?B?V1dNUm5JSHBRSk8vQ3pBK0VHOWNEaTlXVHUwbWRJL3JyQ2lNZTR2U0lGb1Ju?=
 =?utf-8?B?MmZ3RVEwZHBWWnByUmtXQ0lZNVpFUzBzbkN3R3ZIU3JITmQ0ODdMb0FGQ3Z4?=
 =?utf-8?B?VDVwZDEzbkVQaEREcjV2a3VrcU1ZbFE5MDVrbnp4TFl6amJCTFlOQS9WVVcx?=
 =?utf-8?B?MjZpSXlkNTUzL0c5T2VWd2c4aGkvdDRacnZEbW1jM1lNQXNYVlNvQUxKWDE0?=
 =?utf-8?B?OTd1RkpxTlFFSy9NaU9UdDNmOVMydC9yWVppbWNaUmVIOUlYY1NvVmk3RjJr?=
 =?utf-8?B?S09XcnBQKysyVUxDMms2N0hDcFM1WktQTVkzRGc0cTd1MTllbGRiYllrbWJI?=
 =?utf-8?B?N05NMHJtWGgyQkxHVFlSa0JRdlZ0WS92ZTFhTllQcnVwWHJhSXJId25RMW5Z?=
 =?utf-8?B?dytGSkVZQU41eG1hQzl3VWRvTXczMVE5czI2WmNvam9PbU14RkZ1UGFSa2JV?=
 =?utf-8?B?VXdNTFFzLzlDR3RSbDVoeE1lKzNScWZsMnlMOGJ5bWwzeVQ3dTBxSzNpaldh?=
 =?utf-8?B?NURESHQ2YXVMeEg3ZE1KSzE5OTVwUTFMVEoyaXRXS210YlhDaUJUd1lDYzlR?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e2505a-e14a-4e9f-8f2e-08dd4f66c740
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:21:40.6155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11IFh41T2jXvGOpbIQ8ObFHN4AmBBn5mdRLBa8OJNBodrrpavVPTfpBCfKNkt3a0FqzoveEjUYKH+wg/pAkXZUOwFtkN3+XPV40UspqYXuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
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

Hi Sughosh,

On 2/13/25 2:11 PM, Sughosh Ganu wrote:
> The lmb_fix_over_lap_regions() function is called if the added region
> overlaps with an existing region. The function then fixes the overlap
> and removes the redundant region. However, it makes an assumption that
> the overlap would not encompass the existing region, and in such a
> scenario, it prints a message and returns without making the
> fix. Handle the case of an encompassing overlap also in the function.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> 
> Note: To be applied after an A-b/R-b/T-b from the original author
> of the lmb_fix_over_lap_regions() function on this
> 
>   lib/lmb.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index aeaf120f57d..a5216bdccc7 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -111,11 +111,9 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
>   	phys_addr_t base2 = rgn[r2].base;
>   	phys_size_t size2 = rgn[r2].size;
>   
> -	if (base1 + size1 > base2 + size2) {
> -		printf("This will not be a case any time\n");
> -		return;
> -	}
> -	rgn[r1].size = base2 + size2 - base1;
> +	if (base1 + size1 < base2 + size2)
> +		rgn[r1].size = base2 + size2 - base1;
> +
>   	lmb_remove_region(lmb_rgn_lst, r2);

Mm I have a feeling this function was improperly named, this is 
essentially just merging two regions that are overlapping. Similarly to 
lmb_coalesce_regions except it handles overlaps too.

I'm wondering if we shouldn't simply merge lmb_regions_adjacent and 
lmb_regions_overlap, and lmb_coalesce_regions and 
lmb_fix_over_lap_regions into one function each? e.g. 
lmb_regions_mergeable() and lmb_merge_regions()?

For what it's worth, I was able to trigger this printf with a pxe load 
at an address 0xb0b and have the kernel_addr_r at 0xb00 for example. 
What I don't understand is why

1) aside from the printf, it still booted seemingly properly
2) why interrupting the transfer and starting it again would not make 
those messages appear anymore

Logically though, this patch seems to be ok if the purpose is to merge 
two regions.

Thanks for looking into this,
Quentin
