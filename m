Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD94C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0AC80077;
	Wed, 26 Feb 2025 12:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Heg5eFuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54793801DE; Wed, 26 Feb 2025 12:22:30 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E593A8004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKXBygHvbDsn1pJ94b1tUOqTq8a8Aipl4DqAfY9bmu581RYDmbimBMiVy6t9nXLQEzPmLjgf1lAdrZwzdI2PnM5xt/k8Q63gaq8NFoYpqNLOLtZf5PY6H3KwyMldgvSnw1NPkK7k9kjzUVkdaDeN1G73hH7tW4VL1ImxnHt/xRwp+7B17/San04UtSAIr9HAtB6JGkwBF6hoaPxFEeIUdTqtO7QYWu25h+tyEfmdRA7yICpZGpdzyq+7O4yCAdlNZtPp7RHgVJF7txk298/OfQjCnphV/TKVM0V+HsYcbj3YZ+lnf/UzlAHE9yfG3qMz9D+f70IfWyYo532gI3VdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuxBRHLKAu8pFgMKr8xW19yA7X/yrFahszs+zs0Jb68=;
 b=tPCvv73CuO/k5QXh4ZYbV6wN3NOjm/+Rx9dmztJ25sr0+EVwQG7gs1iih3+0qpn0vtdH7mUY552CtcLdmnaeKNtiSKBo4BV2XXCwn/QIJzViPdFt5JpBKySbXh6W2ZTj/JmM4SswDZfmQO/Li9H1pKtXLVQ7I8Ne04WUoaXO+Prbr58vc4HZx4UQL3K1UjGEmDOM2CaX8OFuc9galtuSyWi6BnZAVdvLdGsFvKCRztrPYCPa39fRvW/u5GmdKHkiIssHXKbF2pYb7kxCoUhht1zW/WRxqQEjhtt+K7kK0z8FbwmoDtyIjJDykNwG/oSMpJduhZ3Pa3ZJwJ+frOCbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuxBRHLKAu8pFgMKr8xW19yA7X/yrFahszs+zs0Jb68=;
 b=Heg5eFuz++Go4BSgXZTy2weBnPsNuq3htwHArDGy/7NsKGX4dxmFONzq5I3BJAugRMw602JoytQpq2u3kcLOXfZrjPXF6IIR4JjP2PrP8RMJH1xBSsEh/54V0+c7Ng2tkp/qLLyS0WNP3osL1Ag01R+X3zT0AC4LN6FMYIvDSTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:22:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:22:26 +0000
Message-ID: <875c1319-6790-4cd0-9aba-c1a497576097@cherry.de>
Date: Wed, 26 Feb 2025 12:22:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] led: fix next coverity scan error
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250226091858.73197-1-hs@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250226091858.73197-1-hs@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: e70170d6-e612-4d83-032b-08dd5657d8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWJzbEd1YWZXczgxQjZBMFBjSkdkbXhmb2lNekg5WFhqZjk2WXEvNGI1elF0?=
 =?utf-8?B?VVU5TW8vNFhUa1F1RGdKWE9OV0FGQmVGTGZPZ25iL2dRR1ZIZUNVUWQvQUt3?=
 =?utf-8?B?ZDFDUHZ1bHNNY21TSTcvZFFyK0JuZHNHclUxUVM4TGJ2aW5oSTBBNlIzelBP?=
 =?utf-8?B?aVA1eUxEVExXc0puYlI4cTFXTmV2QnRKZnE3dmE4OGFXYkRoZGhWTEtaa3Az?=
 =?utf-8?B?QklxK3lXMlEvbDNnSk1ZQ3hUWHdGdWNYK3RST09ERDZwVkw1SExua0VRUEhO?=
 =?utf-8?B?NmozdmRNeTJ4TXJVaElQclhPMzlnWE1rb2ZzZ3dZeUYyMnJKYmRnR1FPeXdR?=
 =?utf-8?B?QXNIdkZoV0t3WUVNemN2L2NUVURhYkRTZWNVK0NVNkU4Y3BaTTlHK0dCMk1o?=
 =?utf-8?B?bUU3aWE2Vnd3UFlvMFY3eHZaZllEWlM0Umtsb3BLYURtTGo5NXdJdDFKeTI4?=
 =?utf-8?B?bTJ2VVVDZk8vcUhBNXo4b1liUW9RWjZ1Q3cvTlZMMnVrdGFHVFlVWm8vRkpj?=
 =?utf-8?B?WThhMVkwWUQ2RnZzNTcrNmFiWVJ0R2M4NElBdDVOalorTm1hVXplOFJkN0pa?=
 =?utf-8?B?bDdKanpoVDFuOHk0NSs1dDBsb1N2bVkxd3pBdjVMRGFBL3k0d2lZS1d5ZGdW?=
 =?utf-8?B?WHVrZ0V6ZEV4b01hZ3lhQnhtN2F2b09nUWp3cDZVUWxNaGRMM0dSSDVEOFh4?=
 =?utf-8?B?aVFLVWZyOGNjVW5lcWUwSzljUVhBYXIwaktLWVdPcTg0NHlpMjF4UlNwRzJt?=
 =?utf-8?B?MzluL2FzSjVtcWY5QVBnSmpaSmh4R1pNbkpvRHpqaE4xbVhHMFZJOXJ3RjRJ?=
 =?utf-8?B?NVByTUF4TTM3NStPcCszYzl3OVVGL3Zlc0IvR1ZRNkV0ZjMyaURTa2ZZQ1Nw?=
 =?utf-8?B?cTRRUmNjR1hVNXRjSmVoV3pGb2lKVzFaaDQ3SXFQWHVNd1lmMGFCYUF4Znpi?=
 =?utf-8?B?T0hVd3RFT0NXVm5MMDlzaTdZY044M2MyK3gvUk5oZkE1bTRkMmpzYTNVN0ZG?=
 =?utf-8?B?YkxFa2xKVnVKQTJCbEh4M0Fuck52Y0E0cUFqdjA3TURIc2U4U0laWVNGUG54?=
 =?utf-8?B?NzE4M3hnQW1FTGVXMUExQktSdE9BNU9KRU95VnZBSGVOQkJSRWpDUnJMRjRi?=
 =?utf-8?B?ZXo5QThZWlFxM2RJQ0luazAyU3JjbnB3ZzU5MGhpS0pZTHBuM2Z0bWxDSlRM?=
 =?utf-8?B?N2FZNTFwNWdxOWVEOFhCTWMrYWJ2elFGY0Yza1RjbUZiWTFHMGJmTXV6VU84?=
 =?utf-8?B?T0k4SFlVQ0ZpS3o2RzhibisyY2FQQ2pDQ0xGWHN2L1ZTb2RnUlp4TjlPUGVn?=
 =?utf-8?B?QnlvNThqaVkwQitBbEhsQy9wS2RtdjZVUDlHVEZGb205VzIwY3hZL0RFSGhq?=
 =?utf-8?B?VkRHTi9RbXdHNHNZMGd2YSt5V3ZuMlY3VkxWZXdSMXhkZlU2TERYNElXVU9N?=
 =?utf-8?B?a3IxdEpuY3FtZ3VUMU9ML29Eams0eXd4eWtLNDJlelhPSHU0bGs4WlNSMHV5?=
 =?utf-8?B?ZWYzckRWQ3dZNU9wMi9ua0lXVk5iQ0xGeSs4bHVvaFhqRjhtMnh6RUt4eEtx?=
 =?utf-8?B?Uk9NRlBHQm9rVkxSTlY0NkhDNEFKR2d0YzhOWWszVXRsanBrZGxGS0M2NC93?=
 =?utf-8?B?RUdmOGFqY2k1OG9Od0xXLzV5S3MwVTZGSlJKbkp2Ti80d0s2NW9xMkljYTFZ?=
 =?utf-8?B?Mkh2V3kxUk01UGt5ZW1LbTFzUG01ZVEzV0tRVzVRa1M2M2VXdWxvUXkvbVNa?=
 =?utf-8?B?OVlPNHNzbFNUWHVDYlBZVXlaS2pQTkRqZzhXUWhxZFY0cXpGT1FKUEpKNzJV?=
 =?utf-8?B?RkJHNEVSVy94SGpQY3BWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FCNy9TMFdFUjh0Y0E3NkowcmpQQjJGSC84VVlHSDB1dGF1bityUFZlKzJT?=
 =?utf-8?B?VVk3d2F3cDQ2alkzTEVWMEpibXZYblRBOWtOQlh2RjJQVlhKNUcyNGhtcU83?=
 =?utf-8?B?STB1VFVUQncrZHB4czMvWTNzQ2hSU1hldjk3TzNobTMrbmhBbThLd3JyU3dl?=
 =?utf-8?B?WGpacW9tTUZJT2xlMEhXMEhhUFEyNEF6cUxlSGZrcTFwek9rZ2FGV3BZWEk2?=
 =?utf-8?B?S1grcnJFY21zMmVMNWJ5a0ZmblYvbllXV0lzRC85cXljQk1sVnpnUCtDcVlF?=
 =?utf-8?B?bkIyM29jcGxJMGVDT0RHMm8xTmF4L0tNYjR3RDhoYlVvUGFOM28zaWtyU0Vp?=
 =?utf-8?B?YnliMFBNeWFzc1VjbHRGcjNOUWJRUGdGcHVoc2pHajJqZWIwaDMrQnBhSW1s?=
 =?utf-8?B?SHVEeWFWVDIwbEVjSWk3NlRCRldFVC9KQkFwK2tieXZwODhhSnBqNDJaUmtE?=
 =?utf-8?B?MC92SEVtMkx2R2VzTE1iK1d4TGN3ZmtnOXluWWV3cTROSElJYWQ3SDhOTVR3?=
 =?utf-8?B?d29vYU1yNDFvcHNyQmFNS1BrZXQvcVgwMXlqNnd4NVcxTUpYdjNxZGsvbElo?=
 =?utf-8?B?di9LcnRjMk53MmRxeXpTd2EvWFZIM2YyYmI1VTJud0hvckkvdHhZdVY2YTBp?=
 =?utf-8?B?VXBGR0RwVGh5dGF1WVpIakNQemtuWjNHNy9qVDFzU1o2d0VLVEY5L3Q1ZjlM?=
 =?utf-8?B?Z0s3d2ZCblVKM282TzNxM0lzUUlMQnZ5cG1CcGpENjFkYm85cWxIRlFTbEsy?=
 =?utf-8?B?ZklMREQ1VFg4U2QvQk1nVmpYTHlXQ0thMUZHRUtyZVdzZnJOR0tHeHZ1Z0tx?=
 =?utf-8?B?U0lRY3JWTnVHTjFRQzloblZTY1Z1MXNESVVKOW1ISURTNUszNm42dEhYUk50?=
 =?utf-8?B?SVNuSi9pZGRIc3VkUVlkWVZ2ZmluSnhQTG9aNTlVZ0MrMG5pcjNhazk1cWJX?=
 =?utf-8?B?Rm9rZmZ6VStIOEk1TU01THVXOGVPNHZGOEdEbWE3WnpqQ2ZmajE1T2NHSGZD?=
 =?utf-8?B?bDJNV0RIbmpQM3RnVytrbGloUHJoVkFBdWdyaDZEc3hEWkZxNzF1Ymk0OVV0?=
 =?utf-8?B?WWNoM1ZIU3pHYlNRT2YrUnc2bzI1YVdCUGN1LzRxa2d3YklCRTNSK3VhSExE?=
 =?utf-8?B?TkkzOUxVd1lHT05QZWdlMktJTnQveW5YUzNCN3haNFpQTGNxK2h6TXJsRHhU?=
 =?utf-8?B?MEREcUhkNmFzSHFUSGh0eDA3OE5BU2xpdGJiMjNTZ2FiMGhidjNkcjBwZ2Ir?=
 =?utf-8?B?MU5wbjZZbU9XVEpubnFUYktjWWx2cThBdmQ0WU45SG5Rbjlaa0JFa1c3RFFs?=
 =?utf-8?B?U3RmcUxlRXZQSmExRllIZG5nbGlzeHhCcHFCMTdmUk1zODhXclpLWExLQ2Vr?=
 =?utf-8?B?WVc5Z0dVV3I1YVZoWXQzMlNUOVArdnBmL0wyUHNZMm1MY3N3YU0xVWhiazlI?=
 =?utf-8?B?bTNFUURuL2NBT2tIdjBGSThkTmZGcjZ4YmFzNXpVSVYydGFlOEp1b1hGOGpr?=
 =?utf-8?B?MnpOa2F5dnFiSlNMVmpTQzRwQlFuSk1aZDVMVVdURlYzaDFjUk5DbU9taGZ1?=
 =?utf-8?B?N1RieWVQWlVxMFJ3NGlIZ2FqUXhaMGtTdzIyQ1FVOUU5M2hsNWk4N0NsK3Vl?=
 =?utf-8?B?dlRhenRKdGFJSkROU2t6S0Nkd2dJUWtNekRrNTc0UUM1UzQ0VkpyUmV5RUtG?=
 =?utf-8?B?a3dURysycWlWZ1A5TlFhYnVuYmlnRDE1eWFGZlZDdk9jUnhnSC9KSDV1MGJk?=
 =?utf-8?B?ejdzV0FhVlFjVG5raFZLTnlnb2dybEltWEpjNU5iOTA5UXpyVUtxYStMOHVQ?=
 =?utf-8?B?QXlqTU5RZDE4NXBqai90cGROMkhMR0R0U2RRQldzV2ZtZUI0YzdJOUJRNjJG?=
 =?utf-8?B?WnltdThsRXhuQVF2WlYrQjhiTlZ4bEYrQ2tmeGMvRXNzQ21oWDRkcklFRXBQ?=
 =?utf-8?B?TjNTcVhoUG50S1pGTy9LVmhFdyt2RW9HN1d0cHJRL2kwdmVhVERYZjRtbmkv?=
 =?utf-8?B?SndLM0FQRWlWelk0QmZFa010U3FPQ2lEbzhVc05pcnlDandUOW9LMUpyZFFn?=
 =?utf-8?B?MTZUN1JOU1kxSWlvVEN2VTJUV3FwWTJjbzZPMVF0NDRJRGw1Vko5QitVcDcy?=
 =?utf-8?B?QnM3NzZiYlpBdHcvTkRDdHZRREFxaDZ0d29PZ09kNXhMNG1UK3JXcWdtTXRD?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e70170d6-e612-4d83-032b-08dd5657d8e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:22:25.9282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D0Z6QDVmY3N8aK3VUiUrSzpq53rvgu8C7DsdcGdP9HjfLKlwUWNR4I1YRBEe4DlOILDlSV9Zx52Vhv7SnmB0ZhiMH2utj1M5I9tXhzfqEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
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

Hi Heiko,

On 2/26/25 10:18 AM, Heiko Schocher wrote:
> Tom reported the following covervity scan error:
> 
> *** CID 542488:  Control flow issues  (NO_EFFECT)
> /drivers/led/led-uclass.c: 277 in led_get_function_name()
> 271                     return uc_plat->label;
> 272
> 273             /* Now try to detect function label name */
> 274             func = dev_read_string(dev, "function");
> 275             cp = dev_read_u32(dev, "color", &color);
> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never true.
> "color < 0U".
> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
> 278                     cp = -EINVAL;
> 279
> 
> see:
> https://lists.denx.de/pipermail/u-boot/2025-February/581567.html
> 
> Fix it.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
