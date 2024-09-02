Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F90CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EB588C35;
	Mon,  2 Sep 2024 15:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Zq46vh87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DDD88C36; Mon,  2 Sep 2024 15:41:24 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE3288B49
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA9VXwd2oGpeml2LI8r/4AsWllK1MJuYzZqxbnR0EYQtoLRN7uCEKKw3V2YRqLkeoDPWBmNy48XoPgVXPsyXAOvHgQKSK8iCFNQEvi261N3UyphaataF2ksltyZ5JmhRFJIHklJjmFQWLz5AJ3hzGPYnoNx2qfUocSDjaVxO0juGGxSEtuL14a9/aHF5L+6QTyjQpWmJW5lezBMyyWIsQ+I07gss92HrOxZs5lR/ZR7bSuk3dXYgISmeOBy3Cv4yfYvf314dAIgH9Oitxej3HKof3hO/FyAkKrntUoq2L0ljVywYHVLHmvld/W7cYCUEbXjnhPfs5xfqYKwouNwyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szLc1o9jgJBxSqJWyVhjNVzNIMkrXW2qIPViF3Esq3Q=;
 b=oURPAyTnUjcUC7qsDXUvzjY03dry6xL536Mq5mXbbOlPVBa4D1dMqFnFzDVCNAQ6wSHKoAWHl3MQhnCEh0XuYndhchH8Ouq+Y5kHgha9ixmGuuO1l872xWdP8+QvSXJBPy8MfzPaiFSXCxD+T3wkunr7ENiskZrkjrjw//Klu8LfRT8uLIXaNfATNdVp1JYnzdSRKAVTPM30YPpkHad9q8zc9eDCmxWGjp6CexoDA3Fjr1PtfUzjCRZJPrp+ee1CbTHZLW0TomBIvre9lHAjuEQkRLCFx8cKJyAG7OW2dbrLytc+4QVjOTGfZV5YmJ4CK07wa3jqyYn1w3DFyMb0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szLc1o9jgJBxSqJWyVhjNVzNIMkrXW2qIPViF3Esq3Q=;
 b=Zq46vh87HDbaZBBHUGhL5GDOwRH2LCMPWj9kpTg4zYSnV6zyPDjvW73PE+P0pf73GXsht1/iLvm4Yqfmw3Res7fjyr2Hp1cw0U+cUC7ztvXxP5Vdqc6zOr0LevV5lMZI1Oml3XkjW+LIWL5NJsmbKDziL5MKgkyyUlvmPYHAIHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 13:41:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:41:19 +0000
Message-ID: <26339e14-1d8a-4471-acdc-902d0ef2ed54@cherry.de>
Date: Mon, 2 Sep 2024 15:41:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Hide mmc speed command under mmc command
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e3e520-f734-40b8-4bf4-08dccb54ed04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UCtEdmtFY0owQzQ0emQrRFlLSnphRm9MUVpyZGNGVlNBMUpsM3pDUlhZWjZH?=
 =?utf-8?B?c0NxTjQ5L0FKalBodjFpUjZZVld6a3UxZHBORkhlc1NaNW04dWtLcStMMHVB?=
 =?utf-8?B?NU9ydGxTVThWQ1U0YW5DUjlJd3FsdjlDSFpTd0RrTTYya0gyUk0vVzh3UjZY?=
 =?utf-8?B?UGpob3ZsY2lIaS9vLzZ0MUdSeDFOQWg3YnhmeFpiTk83STV6aGJNRWY1NXZZ?=
 =?utf-8?B?KzRnelVzVEZXaHg1MmNGbld3RTl5TGtQbFJCT3Z4cmNGNmxHVTJHeEVWbUpt?=
 =?utf-8?B?ejVVeEtuTHNGSDkvZXdzbFBudDl3dytXdFlDck93aUI2V2lKcE5oand5ZUpR?=
 =?utf-8?B?SnlySjd1THRDSDVNTTZRMDBhUGl5TGlZWGFTRjd0RWJWdk9MYmZoRStCQzU5?=
 =?utf-8?B?SlpGVWhOaTAwc3k1ZlA4MlNqdzFRc2g4TG1yd2o0N2tSZVNvVFRlcGpieUlm?=
 =?utf-8?B?UnlTc3FoYWd4RlNTaDY0MkZoQ2tmRmV2ZkdaTmU3OTZITGRoakJRRWhjN25P?=
 =?utf-8?B?b3JQNHZ2M0xVcWpLaUplcXZacm1RR1dMUFBVUXZNUnRHMnlWMUpkNHF0cHBL?=
 =?utf-8?B?amErYVdxUXZzREFMYy9LQzNjOXZUUTM4MVB1SkNJdmcwRjFIanF3eU5oaHJi?=
 =?utf-8?B?TCtZVmhEZTVjUHdxbFEvTzF2YTBqbm50VmFzV2duOG1zZ0xHajl1dEsxbzhB?=
 =?utf-8?B?dWpoSDllbHI5TU1sUnQrSE5qdmljbUdITHpPRnhIWENkaDg3Q0JLSXVMN0ls?=
 =?utf-8?B?MlZNR0xraXM2eTNkM3I0M25aZUIyRG5LR3I5Y2dHaFY0Z2NxRk1Fa25iUzJN?=
 =?utf-8?B?VnBLaFdKTjlkRlJzcHdvU3pGdWE3Y1dVeVU4ZHhTUWZEb3hYTUlITVRDREly?=
 =?utf-8?B?cXAram1KNkpSMHFZN0R4U0s2NUJ3bEF3ZlpSSjEvNmpCV1g1bm9ZNEt0UmdC?=
 =?utf-8?B?UFhqZUczUnQvM0szcytuYS92Qlh4WDVNL2lLekJkTWdOaHd6VEtHZkdqYTZq?=
 =?utf-8?B?SkpSWlhoLzUvZG5GQjRaMzhSQTh4bk5vbHMvUmNLTENIZ0J0OEgzRG9xVXF0?=
 =?utf-8?B?bkR1SVJYOE5Zb0pTY2xHSy9JWEh2SUNKejVWZWwxdUtWV2tBWXFOOGlDa2pT?=
 =?utf-8?B?TDFnSjVncGNMT1lYeHpVNTJvVmJvNElrNmRLVUtxSkZsTXNzaTlJZTlUWGVj?=
 =?utf-8?B?dGpVUlp4bi9qZTJZWEcwTjB1c2RHVWZmUnBMSm9HVkE2enlGRHpqTnZoSFlz?=
 =?utf-8?B?amo5Vk5mbDdFNHBla0c1bHQwN0xvc2FFRmh0NVdLRFg3eTBzZHdRSHVSMVZW?=
 =?utf-8?B?eTBwRFVLdFRMdEZSOHBSU1U4YUVGeUVnRzNkcHQxcUw2Vk1TR29vQ0RoOHRV?=
 =?utf-8?B?b1BvWHhKUnRia09iTUNZMFBFd3FKS3Zmc0RvTGlLcnhZalliTmg3aWVneU1P?=
 =?utf-8?B?Mk1uOEVNMlFZYjFvZ1F2SzZaNXY4RUZvQ2RVdUp3MWtZV3E3eUhEMkNOUFRa?=
 =?utf-8?B?c1NmTUJGWDZDTGpwaS9qVWw2NkxBYjYzL21QZ0JRVDNtWGlSRG5JNkRvMEEx?=
 =?utf-8?B?bGRibDF0QSt0UXNkanVXN2pqalhpS3RQUXhVaTluRnl1NFFVbDlkL0gwcCtt?=
 =?utf-8?B?bmoydjVsUFNQZzJaaW1IdU5DeXlGMXdSL1J3SWRiajVRcGNxU1FlYnphWHo3?=
 =?utf-8?B?bEpDYnM1ZkZUZ29lUy9QQUwvYkM3RFVJMFNmek1XZHRtcFNzTzdielFKS1FD?=
 =?utf-8?B?SUlXWHNhcEQxYVNNaC8wdFhDZGVDUEx1YXlVWWcxajRhWWc5YkY4UlFEVEZ0?=
 =?utf-8?B?am1LL3EreHhFYjNqYTZmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBRZk9ieXA4WjBqd0VmL2JVU3NYOExHWktNM3c1Rm9hL29XelVsbVVZaVB1?=
 =?utf-8?B?WER4OVRXdTZzMWRxeFhnRGNQcko0Z3QzVFdBTTBXbS9QZ2o5dmd1TmR0QmJJ?=
 =?utf-8?B?UjNQRE9zV21jOTV0dHNJRjArMDIwMElMMkw3TkFyckF6VEp5U1UrUmlkcEZ1?=
 =?utf-8?B?SjRkTS9Tc3NRaC9VUk50QUduOEVvcDByQUFCQy9HYjN6MUxoVUsxNjVsalJE?=
 =?utf-8?B?UnR5UzEyMXp0SW5mV0RqMVFJYThYNklHUUFsZzB0QTdrbDc0VUs5STJHd2pk?=
 =?utf-8?B?bHI0SWNuMXFTRncrTCtUbTFNU00xY0RvUThIcTMxN1BiWVlHMlEyeERhK3Vs?=
 =?utf-8?B?KzE3WkV4K0lPdmNaMXo3d05xRTMxUXhGeWxRWitzY1RUQVJRR2RsSWFOMkFx?=
 =?utf-8?B?NkpERkZNYnZRd2hCQkVTWXZqRFBEUGhHZThsb29pa2x0THJTWlVGQ0RnaElU?=
 =?utf-8?B?UlZFTDAxWTRDTEN3RlNndkp5VmN0QlVHRXBRNE9RS1hOTFdFeWVDck1Bam43?=
 =?utf-8?B?NnJPaW1HM2JzK3pyQzM0YTVqQWpJMzd6dEJlVXZDNlJFaUQ4eXU1dVV1Y0ZL?=
 =?utf-8?B?ZnFxUnBHbTFsTkMveWxFeXY3WkxUNzFiQUJvaVRZVG9KaUhvam1DWFFnMzF1?=
 =?utf-8?B?S0hBSi9BTXhKTUt3YlJON1FSUXVrY2g3a25pdEZ2aVhVeklGMFpYeElrY0hM?=
 =?utf-8?B?aHZpUlpwUHRjNTJnbWJMbnRWV1d6ckQ3bHJmTlBrdENWRVZNQTRWc0tHaGI4?=
 =?utf-8?B?QWZhZmdIT0QrY09ZeE13U1ROZGZpanVTRnVlaUhKUi9IbzJJR0FibnFOUm82?=
 =?utf-8?B?eFMzOTJyNTNpSjhWSGZPM1ZzNlZ5SERCK3lIK09jNlZGZUxxRkt0NTBuZUF4?=
 =?utf-8?B?UlBHNlNIb0J0YVNrU3k4aGswenBkSXNORU8yc2dxMEpxVU1uUGFOUHZsYXFR?=
 =?utf-8?B?eW5EZllRYmtObmdzaGYwSmJOZ0k1NDQ0MThHb0hwZktiWUhEbWJlV0YyVjN3?=
 =?utf-8?B?OS9HRWQ5VERQaGQvbW56RFRkLzJtdkplUTM5R1ZCNFB0K2d0N0E4OHFUc1BB?=
 =?utf-8?B?VWQ1SUg1RnN1TVdlKzVVM0dCTUVVQjVhbUx0UjBvQ0lZS29Zd29PWXFmTitt?=
 =?utf-8?B?SWQ1WTlnUkYweEZYWlFQa0xvZWxXd291RUd0cmJFMlZoZUJwNnJQTkZuTU1r?=
 =?utf-8?B?L29WWjlBQi9zcnJDeHhpY1VPSGhHa29qQXhneVNuUGIraFdNMWQ4SU5pMTJU?=
 =?utf-8?B?U1BzUWE4aG5sN3QxSHdYSFBKdVBYZVBQYkhXQkZlcmNzUVpWWDdGWUxBYzg3?=
 =?utf-8?B?U1ViRTZ2NFVoYzJJb2ZHUTNaWVNScllxd0pZc3pVL3NaL2pQczQyZlp2cXVD?=
 =?utf-8?B?RUxTRmFpc0hZY3lZTjg2MWxaOE0xdE5TTGovUEkvM3lRSU0zMFQvYWFSYnlH?=
 =?utf-8?B?UUl5aG4vQjVJZWVyS09EaVNsanQyeWxoUWtLZU4wTHovUmlkN2VkOVlRTFNU?=
 =?utf-8?B?Z3A3QzJvUTY0SGxZZmYyZUE3VTZhZlRQa0RXcDFsZW1SQVVrMktuUC95aU41?=
 =?utf-8?B?bEZHNUJrc1MwbGdLbVd4L0JvbVdlQVJ0VFkwYjkvNXY1eTMrS3REZC9qYURv?=
 =?utf-8?B?enp4RnRKRUtSWWsySXRjM3N6NkltbTBkMG9xMjZsWnEwbVFyOVB6TnRRdnBq?=
 =?utf-8?B?Ty92NHZBVHQ1cjNhY1g4ZWR0azZualdpNGFYeHYvdnBRN1lxMGVDTFdmaTd2?=
 =?utf-8?B?MDVRSHpoYXlldWdZVVIrdjE5Y3lJbHdITHhjQzdxZ2hVVkxhdWJBb0tpSVds?=
 =?utf-8?B?ZTA2RjQ2ekYvb0Nkayt2NnpiWWtUV2hxRURGNDhxajI3U2xoR0U2MUVveDYw?=
 =?utf-8?B?N1J2YVFQME5iU092RnVaeDZFMzVNcWwvZFovZGRITDcvTXM5QVB2bXdnQlNV?=
 =?utf-8?B?K2M5MVBPYlZtZ1JndVdHK2l5NmxUbjVxMTcyOVl4b2psbVZKNHZjZTR4LzFu?=
 =?utf-8?B?eWJmY0JPLzFjbVhWQlF4UnFWZ1hFT2lNYXF3SHZVVWtLMUZpdFRGeGJ0N1Zk?=
 =?utf-8?B?QjJydFBvTXA3WmVEd1dHejNQaGQ4Z1ByanVJTWxZdk5tdGRON1A5Z0N4d00z?=
 =?utf-8?B?YThXYXdyMExlRlFFcXhlYmJOcVFXSlB0V25rQVVXNTA4aEl1M3BINUJHM251?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e3e520-f734-40b8-4bf4-08dccb54ed04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:41:19.4923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clwgZPiO6uKkke7VaYej0t8mTx8AMuwFRNWxmB4V0XMN35DK9exJweDYtTNdx1xBXdHfifMvUq+1JZhus0aiZ5s0ZRj8+ZPyCbc0VMtwSmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636
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

On 9/2/24 3:37 PM, Marek Vasut wrote:
> The mmc speed command configuration option keeps showing up in
> Kconfig directly in 'Command line interface'. Move MMC_SPEED_MODE_SET
> under CMD_MMC to make it show up alongside the MMC command.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Rework the commit message

Better, thanks :)

> ---
>   cmd/Kconfig | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 43f78a5aeb1..953e1f0ef2a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1406,6 +1406,15 @@ config CMD_MMC_SWRITE
>   	  Enable support for the "mmc swrite" command to write Android sparse
>   	  images to eMMC.
>   
> +config MMC_SPEED_MODE_SET

I'm wondering if we should prefix this with CMD_ maybe? It's used in 
drivers/mmc/ though.

Anyway, not a blocker for this.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

(You forgot Mattijs's Rb from v1 BTW)

Thanks!
Quentin
