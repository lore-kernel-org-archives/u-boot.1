Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E97AFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0CF84227;
	Thu, 30 Apr 2026 06:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TrXAj40o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FD584255; Thu, 30 Apr 2026 06:34:11 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B245884099
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGKh39fXe74goNV9ScLhGjB0U7tA5LAFGDUbHc60zPu1igg470lzfezoXCjBvuF/UxCIvcqprQqYha3B1ozmT210ADHAV06m6bn0+oMh171n0+z/6EmEAljSsvRkKnHbn9rVe0OKjlfq5OGGZ7Duu+0IVZ48ic9c/eYlb3qjLqIbjihy4qlG91F/50AtfVDF4YJVnEGK1/Ssc4orzbcN8CytBakXymvnV68yPkB8vXyZ7pKRWbgsOUXhJSpUdtUkFsAITf2mJ3vePNlG7nqYvXYwwAtYgEhehKLqLiIvrPdizt185eP7U2oih6TBLgMCscolfzVtbxJO0hmPjPIcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg5fltZj1mY0uWwUD0hGGeB0k1qE3hqCHkx10r3SeYw=;
 b=zSUXXuGWIOBhwys84a/sdzEyIrtx9cpiudkwmrr50R5cbE5jFEHDgHEcou3t5JRet9nqkj98CMFCrdoP3KLN05H9Qjn3m6zWwQO/97f/0wuNskhcqZpUzT5eSzE/vxhPwAEpIQWY21Q2bealjK3DBqzxjLRPBXAlrq6bNuOGp70os7+8Mg2MIzxjPWvmIITPRAgJ4cjO1d4y/Y3qtye9LPivX4OtE57TeGWpEKapUCVvpFVuPa9doC62/+J8KeEU3VlSCSe9nA30TJPRZ7IdDLvBeZoUtqQSn1CwrmSkSdyDCFUs4MS41kPZVNygjGVNnEnT46SZrxcLInYQRjQa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg5fltZj1mY0uWwUD0hGGeB0k1qE3hqCHkx10r3SeYw=;
 b=TrXAj40oBG70a9oV4oy4GZaU44doI5EGkDJOgOqpYsM4eoCad5jK98wVNbC4hGpYBGDy6uo6GSXajaGPLLOZQeHdX9iVOPNag9Svz1i7qhxkOtbHOQW/2jxfaw2ReDDO5+pQJhh8Lhj55zD6LRjYvJqSMvaeOLdFK4uJIEZHbnuJzdYFm7baf19NLX5Ab64fyAt/Jln7t/pici2o7BP4KMVcx/QJIsBM55NtswIAFRNvcQiZucXCGlF1q9l0G/WNLR7k2vyPbTsERJoCqfJ7Msi6+OXt5R1WUKe1VL9I8MrFAoVsWUHPLini8yqGyOYScp7hKqzkyjBd67wsL4g44Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BY1PR03MB7994.namprd03.prod.outlook.com (2603:10b6:a03:5b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 04:33:54 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Thu, 30 Apr 2026
 04:33:54 +0000
Message-ID: <79aa67cc-52ea-41be-bed2-95aeaf6f8d5d@altera.com>
Date: Thu, 30 Apr 2026 12:33:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: clk: altera: arria10: Fix wrong API used for
 memory free
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260415051016.3316-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260415051016.3316-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|BY1PR03MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 190b8c0b-0862-42e9-42ef-08dea671afe8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: rn6KLAz+mc0ZtlPz07/SyJeRLHJPtAVf7/7w2mKBJl3+22lKHGJwEwhwlbOv7dLNPdcomvTtWDaOJiMcpnepWsaGt05jDo0pAOXTyOAD+30PToxXiHVnoETkAiWmGPEvqlnuELa7I7k9M2FzoHLIDd5NphVW9ivI8KKUIA/xjF8IH9vWTXcX2zhgMd7eOpNC5td5UEgjBBpNRhLxajsjgTH764LK8sIbGSmE7dbuZDFxF18wj4t8uGfinlHQ+Dm+rGG27nbNmQ84g9g88xZXmNZRLuoVw6y1DWTJxb32SYUGWcLaCE8nzq/4O5sz3uqKUWSJrFPDS2IE5b2wdLTLwIItZcOP8w1RVISTDOmjxwv6cPKAtzwAiM0jy80WuqB8BvE992D2ZviGAPYNkNTvbw+LutdzOTZ5a/U7vgRGRQ1PtAH8cgT+I5mnVmDfKkAnXQKLa7GW/7/2SHBLwO5wYrL92D8nu1S+421PZbrskEdjQZO2Uh3A8YgpH7aYmHmTMcGh1y5GVvUUiKVHJ0Wdyz++zvPW4Tzv/9XPtt7YitDAe8NPPq7Sl4RX1Jd3RT+TitjA8N+ro53ZtzVVP/BOFwO4CZvp31CRPLzETsgFNpfpuJI4V8sMFkv2TdH+vuIC0Huqb7nrF6QldT1VZBVidVyceEGsvdv39WINIE9J3t6EUnR2U30azYRibOcHYMNtToUBvgVMEgXk55AMExKagF0/DUDN4pT3AkD2pnIvqww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BrUWdqRlMrd2hrVWhRMHdpNW05N0JDNmF5SmxiNVhTNW1lMG9VTCt3RFJx?=
 =?utf-8?B?OEZDbHJtNUZyMTVyMDhRd01QSEpUWWxrTE9FSlh1bktLRGhoNEludWxnWk9D?=
 =?utf-8?B?Skl3eDEvVW9ock8xcDMvTWl5bUFDaFFzenRDbFVkcjNjSElFeUNkejdWZXNB?=
 =?utf-8?B?MUlBb0swMVFQd0xnMWtld0RvdDVCUHpDMUUzUVZUaE01OW9uVGxvdGlkVGtH?=
 =?utf-8?B?U2IxaCthSnRjK0tyMHNHWVhCQzdESDR0ZllkRTM3V3Z5ZTIvZWE4RUhvM0lZ?=
 =?utf-8?B?SjZGYUdJWW1LUjRFRDF0cGlGM0J5bTRkMW1XdXNoTk1HaS9pZVNGRUJ6YTMv?=
 =?utf-8?B?U1FneVA2TUlIa2lGZDM2eUJIaHA0S1VibFBPeVBLRHgzNlRDNlVocm8vSFZ2?=
 =?utf-8?B?ZGVUdTJ5dm4vUmlNQm9YSnc5YVBJaFRicVIwVXhaWDJJeHk2cmErWmlNTXNC?=
 =?utf-8?B?Y0grc0h5Uk90UU0vRU1DK2o4bnp3YmorTXZ1dFY2VE5VQXc0ZXRybjQwVm5y?=
 =?utf-8?B?ZXN3L24zOUUvVzVEWjFZUTRGVURON1Nxa2diYjV5SUxRZGViWWhSRkdNeGln?=
 =?utf-8?B?UjkySUFuUFBDKzhjRFVKMExsZEFJQW9oNThlSE9MUS8rTzR4aTAxMlNtWnQv?=
 =?utf-8?B?OUpVcjJQbVhLU09FaUhtSUJEWVNTS0JwOFZPdkR4dkpwMlBoSmxSbmRlVEJo?=
 =?utf-8?B?SkV5U1pGL09iTURXeHdwSXM3YllEWFR5N1NQS2xjaHF0Q29GWG9McFlEWUQz?=
 =?utf-8?B?aTlnSkV3dDZRTnY3eTdiY2hRNlUwVmNJYm1Ic1NiMVFzQ2t0SzdmNytoSjlZ?=
 =?utf-8?B?ZXdKT0JyS0VuNjlXVjdGb3BabG1sVmQ2V0NJaUhhbkYvQ0pOY3ZWSEd2VUJP?=
 =?utf-8?B?MVh0SDlDR2tIZzBZNnRrVlBZRkRXaVYrdUQyTnZ4bGg5M21NRGh0Y2laRjFt?=
 =?utf-8?B?bUlMeVJvc3FURVVUczA1b3MvMWJMc2RRWkRPNmpFcys5YXhTMm8wcjNYRUly?=
 =?utf-8?B?MEt4VWZNM0dIaHByWGliK3ZzVk1MM3dyU2MrWnhsdWEzV21HK1BHVWE3NnRK?=
 =?utf-8?B?djUycjVLc0FDNHo2KzB3V2xmcGFCVCtvVTVOcE9XSlorcm5FUmpFTnYyZlZn?=
 =?utf-8?B?b0FCR1h0WEV6dDVmWGFwRmY3cHIvRnVRRjlxYkpPZW43Mjl2dzNTc3lNc0Jr?=
 =?utf-8?B?Z05oOFFsR1BvQmJOQ2wwRkk4MkNyRXdHUU5XVDU2YTVNNlRHcmZhbkxFTi9p?=
 =?utf-8?B?M054ZXJQbGpwTEJja0RJMHV0RjVDNyttUVh3bGppaXVwa2VEak9QSXdqK3dB?=
 =?utf-8?B?bEJTN3RxRVVpbVUvOE5FamM3TFJ0bTJaU0xWbmQ1dnZFTytEd1QrQWNKVDMv?=
 =?utf-8?B?Q3JsTEpTNEt1MVMwdnYyUnliUWxxblBJQURiUERJMmJ2czBFRFJ2QmhaUEFM?=
 =?utf-8?B?d21FUndKNUViWE5nUDBVRjloWFd0d2dhVFhwSDJlNVRQT3JwOXlIdFViUkhh?=
 =?utf-8?B?K3Y1YSszQW8wSUxGSnBJZFRzbkxWTjkvNHdGVVB5M08vanRiT1JEKzZ1UzE5?=
 =?utf-8?B?ZXg0V0JhZkllVHAzNHRreS83ZzRsZEJuZ0tHYWZSVHBRbW54ZGdlUWYxOU04?=
 =?utf-8?B?WCt4K0w4M2pzYk9RMW5zSnBMRDE2UWQ0T1l1cXE3VHBENXZwL3pWenJKbkh1?=
 =?utf-8?B?eXU2cUl6U296M3RLYm5TT2V4S2E3MGNScloxekxTa2cxcFpUeGp1Q3ozc0Vi?=
 =?utf-8?B?aUJGSU4ySFpPbU5TcmVCWXNKaitycDNNdjFpR3JsaEE2c0VZT0FRenBlMXZX?=
 =?utf-8?B?ZlcwOFAwL291U1lEMGttQzVhZUZNRGlubmw3blNkbFVlaDRIdFBkM0k5dWNa?=
 =?utf-8?B?V09maXNlZGFTcVdmakpkTi9rcFU2MURSOVhodWtRMjBjb1pjN21CSnZabENp?=
 =?utf-8?B?NWQ4WVc4YjI2RWNiRWhFSmtEOFBrS1hmSFd1dUNrWnlaem9HZVFyNkR1YWlV?=
 =?utf-8?B?RHZEMDlEckFob1BJNmpmTzNuVm81cndHQmVGcUZiR0d5ZTRCenRCc3NrczJ5?=
 =?utf-8?B?am1WYmFBK2dyQ05lTGw1b1lqU1VPay9aTmFKUUdqdlZJZmp0eWtobVJWTXpJ?=
 =?utf-8?B?S0paRWx0WWZIZVJWUUVIaGZJU0pINjlEN1Y5N2VUeUJQSWQ0a0RPdExsWjdE?=
 =?utf-8?B?N1NjU3R4TGlEL3pkVkp5aVpqMmI4ai9Pb3ZFL2YzR0tDTEZHSnVpUDhPRHNR?=
 =?utf-8?B?NmUxQ2hZdExVQVFReUxLUDE2ZXQxSXJNTXdsVUFQaDZLK1F6TFRFL256UTlP?=
 =?utf-8?B?VC9lRDc1YWpJR2c4cEpSYWdnWXVYdEpPNVVLYURvRk9qZm43TXNPQmdtNWhU?=
 =?utf-8?Q?F+kv8e5mDiJO5WuA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190b8c0b-0862-42e9-42ef-08dea671afe8
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 04:33:54.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOSfW5L5IMytKswd3isJfWWlX7wfyeRlUqWu0sQH9MwZyt96YlYA1Al63+DPnzTbMNnLzmNFkp0iwbh47L/j4NBrfyVYldzgJmwmdfgtQOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7994
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

On 15/4/2026 1:10 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Fix the wrong API used for memory free.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/clk/altera/clk-arria10.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
> index 1840f73beee..081f8f2b7aa 100644
> --- a/drivers/clk/altera/clk-arria10.c
> +++ b/drivers/clk/altera/clk-arria10.c
> @@ -222,8 +222,11 @@ static void socfpga_a10_handoff_workaround(struct udevice *dev)
>   		return;
>   
>   	ret = clk_request(dev, &bulk->clks[0]);
> -	if (ret)
> -		free(bulk->clks);
> +	if (ret) {
> +		devm_kfree(dev, bulk->clks);
> +		bulk->clks = NULL;
> +		bulk->count = 0;
> +	}
>   }
>   
>   static int socfpga_a10_clk_bind(struct udevice *dev)


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>


Best regards,
Tien Fong

