Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF500CD6E43
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 12:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DA5846D1;
	Fri, 29 May 2026 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BNA4XBe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D41846E2; Fri, 29 May 2026 14:23:42 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480C8846CA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 14:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGymCVv6u1q0+2kBotlbKv10f909edEZb5+di9T0itP/+hruyOaJ+LWjZ3ZkVmeMc0ncoP+i8NH/lFpMWr+NM4+coRL/C6T4a3cl1IQG6t5HlzNoVJJmRUvpqbd4UbOQVpg3u9+W+rJWhG4W47KvxwI2rsCHb8+DMh9pJxb/Dl6aeKOF1tyhewyV5KYyGXG1s9ovU8iuuOn3z3tn805PagnTLLkeA4zOsAXkpC44ycQnpjiDShP1b5gN8gFY6oFB4bFOs6qLX5K36YfE5EYPYiZBLD47yp0VD57vm69yVegE76rXfvmDK2DEwEq0FxupElVX85mPfX1ksVHHvHo2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tPFzILGwH/AJ5fDBHc0NXnNc7nZiT5KpLfhI1cqZ+0=;
 b=N4kq7QMNverOUkKJkt64kyQe6+AKqD2nSaE5pIf5EEmNOSBDOF9TsaC+1VhxsgxvqqEKqKk8mv2XVoSOPArAjrkBuiorm4sL4dPM/KE6JMggRDQQo2JAZC1wfiye+KW+lwpi9ZIB4EedDoBRTXTPBUmygTgs7L5lsDUbchHR8g8o8klfFa3C0+p1z3LCTXionKSC4xFoYykDVSpreFFn1g+L3kLLOV6RsGWlt0zDJjNmmhx65l3v3Iy1e1HvwTODOx+SpjrtJQJFwiRtRK9KWMrL0JwFlgEW1NpioHluhz7bsMihtJIYEE5kgp/rwS+BmtKyGQZxKQtNRn9oZMM/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tPFzILGwH/AJ5fDBHc0NXnNc7nZiT5KpLfhI1cqZ+0=;
 b=BNA4XBe2P6NxTSX5LWn94USu6pnnmpNft1ImmBA/AxrBElOt+a0m3+Ihcgc7MWFf31wjYFZN0nrJwTGdNfVVehPZSzmxfxHQ4mmhdXWyqO8+x6ISO7AUg1rONHiiDAvyJGfFJNjS3+OvubE+U0m7s5z+xNnToKK0U831UWKS79U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA2PR04MB10424.eurprd04.prod.outlook.com (2603:10a6:102:419::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 12:23:35 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 12:23:35 +0000
Message-ID: <2ec92f1b-00b7-4710-9d39-afab2305d938@cherry.de>
Date: Fri, 29 May 2026 14:23:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260529112351.32301-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260529112351.32301-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::41) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA2PR04MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a47a8b6-fff8-4532-d3e3-08debd7d1b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Cv68FuSZF701Kk7yiZKQ1TP/1xr7I6ZkG05j0aN8Y5due48xJndPRMTHu1iXs9VXufSS4DvTeloU/Z4ObgQAVqIkO9tIAvydLD9RKs3ynTD188ek9zGB+YuC+GFDsp2GWhM4vSp6NtEjku4pkzjQszs6ncnBzUymoF8t8Z4tU9Iq+QurcymoLa4MlUqtdbfE6PVrjh+P7hgNqerVn/UAdvcfL3yASN+JYOQVAJrHHCBzmasSeqxW3bTYLEXsWeLBKSFMTrnTwoO4FwHKcuD/cmVkxD/hiwkkUC1QMzMI+Q9m1gZE7gr/PXB/5CGT1iLzLNz/B/ODVXfhM8+d7Hfiao/nWdsGC7dpUsmpJJkSgZdHbfwFgjALgZFytKC1fxsmrBtXSlALvysoCP+kMk7fMaiCKQ3p8OQad6OA2kW+mwaY0tR6xuK5b0atPstsHXZuJDdWJghN4b2gjILyOv1BZ2pAn1wz4howu5x8+S0NS67TfKnP+ITx8S4wCVsaECRbA72loPxH/uox3OPx/7XvPhgKn/jhEHht516TTP4o/e1MJUTJx0n1p8etB+FvLOuDvtKrgdMZXWLkwJ+f5ZDUb3NfneSSPlRspNPtC/4FLrZzGep0q91Jahs4VF3+FPG6jBNONT/7W1Lk1uTY/4Bgvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1VQUFDYlZZSFgydDd2QS9SZVJuQktaWmdZcmRFVU5PNWw2cXlYQWVzaUhV?=
 =?utf-8?B?ZnY5emVudXV4dXB0MFZNSXQvWm9rUFlzMzhTWmtRdXRNSlFLRFFINzlQellY?=
 =?utf-8?B?SHNXTnJRN1owNFYxZ3dyaEVJYW8vMlVjSWxha2FRYVA0ZDl4Q3RlRmE5SUYx?=
 =?utf-8?B?TjFzVTBCNFFOWFlER3ZFV1orMEo1QkF6YUhQenRxb1htcHllNWtPWWlZZmN4?=
 =?utf-8?B?Tlc1TGY0YjZYVlZML2RBOFhIbTNTcnI1L0JWMndCNWEvS2dYNk1NaWg4SC8x?=
 =?utf-8?B?ZlhhTVFsSVhWTWxZbjh1cVdzM2RsV0VORlZRcDBvWGV5eWRIYktmMnN2djdM?=
 =?utf-8?B?bWl4TStGMDRlbVM5dTRlZmRYNGkwL1AyVWlXbkZrYTY0SWo0SUtHU2JNV2Fm?=
 =?utf-8?B?RHlFenBGd0NzTmdGUE0yMWRUbDlTL1hjckdjd3hqM1U2bm4vV0VoYXcrY3l1?=
 =?utf-8?B?b0U2V3hMbkdSa1grcHNCblZFL2dMOGR3ZVFwWVRmVjBFNE5MOUlFOFhQVmNl?=
 =?utf-8?B?ZytBaGRDajRJcWZQTlNIMVVWM0RzUUx2NWdlWENJYWJaY0VOK0VRZW1KV2s3?=
 =?utf-8?B?SC9zMzREVHFiNmZCYjZNQlI0Mks1RDJjdTlPa01vSlNCbXdrZDlHa2lKV2py?=
 =?utf-8?B?NnNnajVXd0x6VVdGOUprREd5akV5azhncm5DUDdpQ3BUL05wbFltbDdiOG5t?=
 =?utf-8?B?cWIzQXdLa0ViUnZ0VkkzaXk1R2oyMHdxSmtRanBzMjlBSDd2VzM5aFcvUm5i?=
 =?utf-8?B?aWs0alc5b1Zzb2ErR2dyVnAxcC9UcjQvb21Xb3cvSU45VStGZjBpTDROWnQ4?=
 =?utf-8?B?MFlVNGRRdWZRWTFzNXB1NFB5ZjRiaFlNdUF3T25hUXQ3V1NWdWU3SW1KZDRM?=
 =?utf-8?B?amk4aHJaeU9sYjl2TkU5RFk4a21qTWJQd3NFQ0FPR255bFp0WnVXL3VweTRj?=
 =?utf-8?B?ZklGdG90QTlyU1BaWDd6VWJsZ3BtdG1PZ0lmUVZWOUgzYlZ0cTVKSUZNdjVH?=
 =?utf-8?B?aUlidHAyR3RHeCtpNVQ1Z0ExcDNrSThHSHdzdFNIanpzUEp5dVBBMVBUcGZp?=
 =?utf-8?B?bWRiLzFFRHpYS2ZJcWVtOVJOQnBrbmhHR1N3cTlYK2poWkJMdnRzYWRabzVo?=
 =?utf-8?B?UWM5djJaNFF3Z1Q4M21nT1d4aHNVZ1p5MGlReUFjZUY5MXdUVmlURlZjL2lF?=
 =?utf-8?B?TlFYTVJ5bTdwSXVtcERsWS9Mc2xrNG1WTDdUdHBoMldFbVgycFJqTUlkSzlX?=
 =?utf-8?B?Y09RR2N4cTg0cGRUUy9xMWpMR2F6M3VVazRFTmFDdVdsVHJJSnRreUY5SG9J?=
 =?utf-8?B?TnM1MWRXVk9xaTNnR0N1c2VWeE50bDlySC9sOXhWb0s3U0dDWVZVdTlXSVNR?=
 =?utf-8?B?VWtjMjJZZW11TFpJMkZibzZEcGoyK1pRZkcvcWVNaHBIRkZQSWxUSGQ4V1h3?=
 =?utf-8?B?MFlIVk9uNkZhaEJocTlPMnFDcFQ5eVFUcjV1UVpJd3JBQ0pTTE1OQnd6d2lZ?=
 =?utf-8?B?MmhtNHZ0T0JwbHNreTZnS1dUQldWcStJdFZFUGdZYUo3dU9QYk1qVk94c1Fs?=
 =?utf-8?B?TmFNSmZ6bTkyOWNPNU1QVzBwRGVCU1hNL0dudHlidWRpdk1uMG9SY09UMnVI?=
 =?utf-8?B?R2VWRG1BbUVpckcrRURnTzlDa2xJQmdsZVp4U2V3VnNwL1REbzdJdmVVOUtK?=
 =?utf-8?B?ZlpDeTBXMGl5L0lNQkdNZVVjOVQvL2hPeGl3ZlR0Ykxqd21LL2tuV3d0SmVB?=
 =?utf-8?B?VUE0U0lwWGJiRDJldGZoZnd4d09qMzR3b0tHZHphYlp3a2JTVVZOeTU1UUo4?=
 =?utf-8?B?ZmN2TStSd3BiK1o5VDByZUZxR2VvNHZObW9kbjJrdTRZcjVLMmlkd2xyV2Ns?=
 =?utf-8?B?bU9kQno1OGxCemJIbitoRE50UHRRS2llcnB6ODZmSFlEbXhXaEFSdklSVlli?=
 =?utf-8?B?NXBtbHI5L1BDWUhVUExHeW16OWp3RlQxMUpXU1UrZDdxM1VTekl6T0NCeTFu?=
 =?utf-8?B?RUJmTEk2WHRab3o2eXhxVStWSFBZV1EwVWcrQmgyc2JHK0NZcllzWHl5S0ZQ?=
 =?utf-8?B?UWxXUWZ3R2d5WUY2NXJKaFNnMFMwU0dBY1d4Zm9sVTVZV0g2dzRyL3NBcWFQ?=
 =?utf-8?B?a1N2K1Q1WGQ5N1lIRXZjQk1SK3FCck9Zem5UazRWcHBiMFJHamhxS2tFWjlj?=
 =?utf-8?B?L3pyT0NCdDJSQlByZWptc0xEMEhOaWtUd2N3UXlrWVlJM21naUtJT1VYaFF5?=
 =?utf-8?B?cUFWQVNVREdtVGpxNUhMbUwvMGM3YlhOd21leWc2NUI5Tm5SdjRZMUdZam9I?=
 =?utf-8?B?SkpaaXpFY2ltQzk1cngzZWNFaGZTWDh3QTluS1pNUEYySklOVmxSZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a47a8b6-fff8-4532-d3e3-08debd7d1b1c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:23:35.8398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE4a6L3YRhVtdsEniC1np9TEmrvORgxCyqp0GP1uWuKGEG8gKj7L0euOdwFLT1CHeZDTkdtIvwjhVN6srZUaIlwQTxqOykeMWOraRwqotsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10424
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

Hi Boon Khai Ng, Tom,

On 5/29/26 1:23 PM, Boon Khai Ng wrote:
> mkeficapsule tool is automatically enabled when EFI_LOADER is selected,
> which introduces a host dependency on libgnutls.
> 
> This causes build failures in minimal toolchain environments where
> gnutls headers are not installed.
> 

Having had a cursory look at tools/mkeficapsule.c, I think it should be 
pretty straightforward (famous last words) to remove the dependency on 
gnutls. See changes made in 16abff246b40 ("tools: mkeficapsule: add 
firmware image signing") (lots of noise in the patch though, I'm 
thinking we only need to ifdef the privkey_file && cert_file if block in 
create_fwbin() (and the functions called in that block). The only issue 
is to decide when to drop this dependency.

We use pkg-config to detect if the lib is available (I'm hoping that's 
enough to assume the header will be available too), but if pkg-config 
fails then we still default to -lgnutls, see 31a7688cbe0e ("tools: 
mkeficapsule: use pkg-config to get -luuid and -lgnutls"). I'm not sure 
if/why we need to keep this fallback but otherwise we could do the same 
trick as for pk11 support in gnutls here 
https://lore.kernel.org/u-boot/20260529110525.22822-1-Wojciech.Dubowik@mt.com/ 
and set a flag to ifdef the appropriate sections in the code.

> Stratix10 SoCFPGA platforms do not use UEFI capsule update workflows
> and therefore do not require mkeficapsule.
> 

If you say so :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
