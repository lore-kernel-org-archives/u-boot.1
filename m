Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED46C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B42886A0;
	Mon, 12 Aug 2024 11:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fOIlLTFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02536886BB; Mon, 12 Aug 2024 11:35:36 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C8388680
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3lkOBchbdpgXPhrUuE81JsR2lEGYM/atWZZZX25z/UBpXDQGs4pTR46PWArXMfH/sNN8d97EulzrE7j03submtbe4RcKgbx2orubKOJi3aGAeyBUU0m88DhH5VlWHA55gGWnTZ7yOfXumKPfFHs92F0MnPLWJ/LfbujxVWJ5WIqyndx+ojc0VBW1x6n0N+03NNQDdTidWZ8mcosAprU2rj+htFUQAZP2ShUbOLJZkP7N6DbYCNAL2e4EQw61j+bXeewZB1aEkEWWmHoOBKMZO5vFT4l8ZEQ3RfDcJ79R5YKkMbpumCvxfothRT0EwFAILNzwa+QFeK+ozRZcqmrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJEFZ+jQ2jxbqky8KFcZhjGFaPuKpysYEs/IGEPIt8E=;
 b=ST33fYeL+cXHVkczTj5cHJajDPeyXYVpLOzIZq565SD+9hoKdYvmOCLQhA+MwMcyu+j9EAMWQh3IChkdFc+dgFKEA4nsnbUwhFQ06dncuc63/hVOPhZLpHP/fM1lN8R+vN5RQNZe6WKCKRBbA5Wzp5FGF1JBXT2FqbWx5Vun/uqlAu69Hk/VVrBNwCzeBSpv698WuV1/Z8cLDrw4QCquxSOGQbHy7mAxo/0IvjYnwuepuIGYKnesHFFu/0qtBTVKxd5er/q1kaqRnl88DVGWcI51RzSVvu7EuSa8ZrUilH73N+CeTr5SO36apgs9QFpq+UkyS9VQYDogn9d0svAyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJEFZ+jQ2jxbqky8KFcZhjGFaPuKpysYEs/IGEPIt8E=;
 b=fOIlLTFALtPgVTdLlU0Jhvhuid0R9L5urTJcE9gdrl77bkc7RbZB9A5Tu/gLOUI6+vfVAsedkOMFv4+2wS41qBIGKhKuMmbUNLL0Ivo1IespPx4NbgmqOZzMrOhXHe/IWy2dgM3a5vFoN6GQKMdMMB7XMLM3FjK/woPWWsfNlQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 09:35:32 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:35:32 +0000
Message-ID: <10e67e98-ac80-471a-a4ba-1c4bad88944c@cherry.de>
Date: Mon, 12 Aug 2024 11:35:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] mmc: Use logging instead of printf()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-7-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240811122924.4035982-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3a25f3-2a29-4eda-79b1-08dcbab21c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzVUTmQzSFRqSWJyNzR6amp6Si9HY0RSNHhTRUpRRmlQbmh3VlRQN3NDNTNy?=
 =?utf-8?B?RmU5cENJVHhrUVpxNG1Odi9KTmtUcXF4aHpXU0pHUjZsenhCNXY5MVd2aXp3?=
 =?utf-8?B?WThCdjVDT25xV21ZaVJyYVluSnllcHpINUpZM0FWWko5b05NdnA0ekQ4QnRH?=
 =?utf-8?B?TXdnNGtKVEt1aWZIb0JtRHYzQVFCYUp3THhMQ3JGSG5IRkpqUUZaaTdoRDRW?=
 =?utf-8?B?WnVMRzc0NUJieTRZeUI5YmZnWm5UbG1jOCs3cmYxMWlnbEg0cVlkdXZsdjdR?=
 =?utf-8?B?ZjlGYStsNkoyRlUyNzc0Q3I4eGh2NWFKemN5TW1PeGVLbEJHSUdra09TNzdO?=
 =?utf-8?B?RVorUW0zYVViK2NxTkxCUERENmFKOVJHdmtudmRuQUsxb0NVR21xSFkwcnFU?=
 =?utf-8?B?WSt0UlpkbEhzRzJyTjU1elo2SlppN0ZORU91elUvMmJnS25aTlRtSWZRTnBY?=
 =?utf-8?B?SWd2QTRFU1VkWVV6dURlVEtLL0ZLcTFtZWRCcEFoV2xYczM0ZGpWdWg1aE1j?=
 =?utf-8?B?UTQ1dytzWGlFZy9OWjByd083b3JJaGloRk9jMVdsa255cVRiMDNxQUsxT3Vh?=
 =?utf-8?B?ekhqVEQvT0doQWVlRjFCbUI3dTVBY1AxQmpMSVRHNC9OMytKQ1JWK2h3eXJY?=
 =?utf-8?B?Wm50dXVsTEJNd05YWlZoMjFjRUpnVVpqZVpETENVY3lkcklYanVONlBQUXpY?=
 =?utf-8?B?cnp4UnJza2J2NEFFdTNYd1JjMW5LZHBtQVdpV3Q2TnE0Y0Z5bFJQZmJyWkUz?=
 =?utf-8?B?Z0JvenlLQ0lFT09nRkt5aGlkUUN3U21XdmR3aU8veFJGdnp4QjdxaVNWWEFu?=
 =?utf-8?B?SnVveCthY1k1ZW52Nyt2bDFRSHpWU3pkS3h6MTVGUUllVlFVKy9MSjJ4K3R5?=
 =?utf-8?B?QW4yOU9aNkR2RzUva1VPQUx5cE9ITkRITURTSG85RFdJYXh1RUZGY3hlKzdU?=
 =?utf-8?B?NE0zekY5dmNRWDlOQzNXZjMvZGhsbnFOUllXRXZYTFpHUWRIQWNzdS9hWlpl?=
 =?utf-8?B?a3krK0V0MFdNQXdUZWxoSktqUUM2Z04yTTRNZ2dyMjJMY1lXcHRub2orNUNJ?=
 =?utf-8?B?NmY3Y3VERHd0MWlRT2VOZmxmeGUrQkZiWjk3S0pPZTR1RmpKdmxkUy95UUdF?=
 =?utf-8?B?TDdwQld5Y1VlbnI4Sk9PamE3aXVzZzhqQ216WndGeGFkVHluTzJTa2ZvZkIz?=
 =?utf-8?B?L3Fid2tPR0JsQnYybml5aUtlSG45SXhuMFVvYXVFd2ZHNlU0blVYWEY4TEpn?=
 =?utf-8?B?cnl1OXhKREsydFRXKzdQck1ONWRhVzBVVXhiVm9IN3hJVGVPNmtKSlVGRE1H?=
 =?utf-8?B?eFIyTWoxeU9ra1FVcEJkSXpYd2Z5VEZrVDdiRmFvUUhsbEdLd3FITFRic1I3?=
 =?utf-8?B?ZVJzWXBvcE1maVFOYWxiVVdqYWZCS3FqeEV3V012WUFaNU4yd01yMUQ4NUsz?=
 =?utf-8?B?K0RrNnY1QVJ6SDl2d25OQjU1RjR2MUI1YnBWS3NZYTNEeVpVNmVTVFlCR0Mx?=
 =?utf-8?B?cnJjaTcwdGMyNzczcXk2SSt2eGVoUkRtaWxhSGNTWWZmYUJtZG4xM0hCV0RJ?=
 =?utf-8?B?MDNNcDBvWnZyOUZJa1YwUmdkN1ZNZWVyNmc4akVhZ2pjRmVRbERsTWVlS2RH?=
 =?utf-8?B?YVRYWDdBWUNnbndoZWdGZnRUMTRiMm91alhVMzdrQWVJU0xqWWpIRnptYmwz?=
 =?utf-8?B?empTUXRjVjJiOEs5OFJsNHRQMC9kYVFXMXUrNGlXZCtwWVNnVXprVTBtL1RC?=
 =?utf-8?Q?oYdGsx1dZZXa3BBjSX/49FzcfiCZeawQov8akVU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9MQVBDK2tIeHdTZHNzRTVoQzFoeFpLYWlOYkVqNUlHekticllrMlVQbG9t?=
 =?utf-8?B?K1JHQU9GMEl4THIySW5Wc2k3OFpmaDJXVCs4UFoxUmJTdmpjajF2NnliODQ2?=
 =?utf-8?B?NHc2aEE0WGl2a0JoNGZxQVdIajdTMnI1aEYxSHpDYU9NUk4wam8zbVpjMmdw?=
 =?utf-8?B?Vk4vSHo4alpwaUpkd3FvMFVIalN2S2ZjVUMwNGU0VmowbVVoNkJEOEtvL2hx?=
 =?utf-8?B?cEowMmhOOVZnckFXZUE4ZWN2RVY3ZGNMckFEemhpdDJwL3gxQkFnYlJzcCsz?=
 =?utf-8?B?Z050RWdEcE91cUZCeDZhZzh4UWQ2OSt5RVN5eEJKdjBsOHd0NW0yZ040M0Ez?=
 =?utf-8?B?VHVmbWNkR2pDRS9wNk9xYjJ6NjRWWjBoZTFaK28xdkcwaXd1L2NBRWtNTU1L?=
 =?utf-8?B?aFBTa0k4S0lRaDF3cmJLOVN0VEpPQS9xRVhMbzd4aG4rV05FV0RYV0JwNjNi?=
 =?utf-8?B?QVBGdlJYdFhqNURKQmNYRUN4MEkyUlFsanpiVlI0MUxoK1dCcUZ2cHlibmJX?=
 =?utf-8?B?bXhmMjB5RjAzM1RSWU0veVArUGpXMHcyM3pPM2VOVmJSMkxOTHZGbktVMERj?=
 =?utf-8?B?bHQySEVCY1E4YXV4dlEyWldNbnVUSE9ySithZ3F5KzlNQk91RXI5aFN3Wm1a?=
 =?utf-8?B?SkVOaDdBTDZOTldDaklrTGt2R094S0RpZnluaHI5blJaQ2pVM3NzeVJoZENU?=
 =?utf-8?B?cEh3SUUra2pTKy9VVUtxY1MweXp3c3hkZnl6NXVXcVRhNE1rcG9zcjdzcHNt?=
 =?utf-8?B?aXptVThSWDVHSkNqWFdIRkFvNXo3dkxNZ0lacy9QZXlqWU81akVWUFdIdlpR?=
 =?utf-8?B?L1VlWE9rSXdYZEx0Njk1Mlh1VG9sbm1MZkFWRkdqQm9DRzFMYWkyWmJSN0Va?=
 =?utf-8?B?UmppT3AzNXdEVEE3VkJncWVwb2xQMEx1V3p2TjY0VnZTemF4bHc2YytMRFVI?=
 =?utf-8?B?N1VNR0labU8rTlg4OWZnYjhZVjk1ZE1yYXcycnlLT0ZpaktnNHpZWTlwZ3RG?=
 =?utf-8?B?aCtFa1prR3B2OTJnS01iRFFsNzd0OUV2bFE0WThJNFVPZXhZamNhQkl5RXND?=
 =?utf-8?B?ZGFOT1J6NHZEWS9DcmFaL0NIelZGamhhVFJSeDVlS1hPRWZORGpUMUFSWXMw?=
 =?utf-8?B?V3NkTnArTzBwbUt5anBjU2pPemUxeXQwMHFjNmhwdzJGVFlkcDZRM2swbTE2?=
 =?utf-8?B?bEREQVY0Kzdmb0pXOS8xR3dTU2ZRZmRCWnJoVlVFZXQ1d09CMklzeklZMEo3?=
 =?utf-8?B?OUFESWtnQUZFdFFCRFZMcmRpRnhzL05XejhDMWc0TjFJazVNVDRNbGlmZUMy?=
 =?utf-8?B?SFNuTENHWWViNHVwRWtYU3hkRlVyTXJkUExNNWhXbVdWM01mT29LUVlCQ3Fi?=
 =?utf-8?B?a1M3SVJJemdTdCs5ay9DQUFVVDV2aGwwSzFxNFl6RStpaWNBN2RtSE04Tnpw?=
 =?utf-8?B?czBBb0g4Q01UaFF2TnFqZWNSWUFScDBqd2RQSnB5SENOSCswelhlTzZOb21v?=
 =?utf-8?B?MVhQZHpxaHFMVTBHQUhSYkc3YzNqQjRPZmJGbGt0alFYcjdGNDlkVS9Ra1N6?=
 =?utf-8?B?b040UmR3MzBNMVpQRlJQeEc4NFdleEJzKzk2b2FtS21pbjB0b011N1RoNlc1?=
 =?utf-8?B?NlVuaTMrYzl4TmtieGVkWHdpWVFkZWFKVkN4akJsTks5eTNpTWJwRWRHZjdH?=
 =?utf-8?B?THRTUCtGbUlrQjdhUjNjbDhpUGxjTUhTanJ1SzZvdU9XajhmNVN1azZrR2NL?=
 =?utf-8?B?OTRVUzlZdi9vWDA0THRRcWNWTS8xdnFmTFhUTFpRNy91c1VwZ0o2bHowdDZX?=
 =?utf-8?B?OEFBWFpvcjZHUzBEWWZHdE9jd0p6aHhvcmlBOWJ6d0QrR282czFKMzlkdUpt?=
 =?utf-8?B?Wjd6ZHFFK3psYTllUWNOYVVhMnBWMllCeStvMGIzTmFSb3RBNkhNbmhzTWVO?=
 =?utf-8?B?Y2c5cEEzL0k2OXlteTF5VHNDdHV4M0p0RTdwK0E5eDZLSVZxZ1FIM29iYTA3?=
 =?utf-8?B?RG4vWWNJK0VLYTQ0TlR1RTZzaHlxYnNyK3RHSzdQb0NTYUhKZ2g5NDVIV2sv?=
 =?utf-8?B?eXBreU5PbHRWdjR0UHFmN082SGdUQmZEdG9GazdnczZXRmt0ZU1ydTRrNlY5?=
 =?utf-8?B?bEQ4RDZBSnppQnZaT2wwVnVpVm13Rm41VUtsQUwzSi9wZmFvZXRXWFVOLzNo?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3a25f3-2a29-4eda-79b1-08dcbab21c4f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:35:32.2629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9ESBcTUwkgbhxnvZ8YgHuXOpucy84sOBBykInGgoUfAAZv9MaEt/144+ULVHiqr3gkrF4vzoW3LSDN0fptuAErFL9cr0zkyHM0q9iwRI+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799
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

Hi Simon,

On 8/11/24 2:29 PM, Simon Glass wrote:
> The code makes quite a few uses of __func__ which puts the function
> name into the resulting SPL image. Use the log subsystem instead, to
> reduce size.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v3:
> - Keep hex prefix on values which currently have it
> - Fix up the second parts of the 'mmc%d busy' log_warning()
> - Restore the original error message for configuring DLL
> 
> Changes in v2:
> - Various updates to log messages
> - Drop an unnecessary cast
> 
>   drivers/mmc/sdhci.c | 52 +++++++++++++++++++--------------------------
>   1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 560b7e889c7..4833b5158c7 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>   	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>   	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>   		if (timeout == 0) {
> -			printf("%s: Reset 0x%x never completed.\n",
> -			       __func__, (int)mask);
> +			log_warning("Reset %#x never completed\n", mask);

TIL about %#x thanks :)

>   			return;
>   		}
>   		timeout--;
> @@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>   	do {
>   		stat = sdhci_readl(host, SDHCI_INT_STATUS);
>   		if (stat & SDHCI_INT_ERROR) {
> -			pr_debug("%s: Error detected in status(0x%X)!\n",
> -				 __func__, stat);
> +			log_debug("Error detected in status(%#x)!\n", stat);

It used to be uppercase and is now lowercase, though %#X would probably 
do the job too (albeit it would apparently write 0X prefix instead of 0x).

Otherwise looks good to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
