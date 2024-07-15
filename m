Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C30C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10172888CB;
	Mon, 15 Jul 2024 16:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EC5Ozzm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4FE888D1; Mon, 15 Jul 2024 16:14:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BAA888CC
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgzPxEnMhUcSHaYl55hqhTtqTlHKQs1HcssnN9FUlzZH6BB0O2RnGJ0COa/a+S0suYJ00t81VwoIvKCEtXen4tMEzzZ9fGNxFm3VqsgL5geTCl21MWtWUmfRHwEgZ0Ooq/rTM7MxOK16ITk2mKCdf/Bzi2pyndlaXrfs/xHU9J3enZz9i9Bg37zQicnegwvTaLAPGi93Bw1alW+EguRZ5rHbR/5H21avw8HyPj6Wgmse6UnHmx4jym/y0BTWkF33SURhxhBk+W4hNBj8DZp6t2nu1U0wBw3Wkn57z0W0o+fRr0UQ8JdpGDozyyLCFtCvzQqIFLs1DpmQrevvXCy5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8I1xIpN9kn/HK2SbH1SHSZqwpe2cQMeqJiDNGwIBo0=;
 b=DrA05CigjhkRwo737lvVSWSblwT0cyWy2wN9cCultJdiwbc+RnOoX1k0OVCz5F0+G/cYRtDJ8pxWPfjNZxr3NVSQ3h0Oyv3ii4Ma7QApp4UrgLY1XXH20pDrsb5w9AlOm/kuNe0W07+r0KhBE6w+RoKdH9YVOGHLPgSG5/Bygdukto4bobpSo3J2xildnYtI7Pf8X+4Ch0gLQXg5OPzCsQOpv9nBXIP+0tJDBT0gekLMthFWjvD1xNlmNsL7eGU/4tiVttPDDguEWIg0KZwcbp5MdlE0wVWcT8EmKse/VqlMMucnrTFrUVz8WaF20/FI5tR5EneOU/x9SoaZ97ksXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8I1xIpN9kn/HK2SbH1SHSZqwpe2cQMeqJiDNGwIBo0=;
 b=EC5Ozzm98BiefDxuDRiX0K9XliRzUh6xd+7i67i302HvwZTNIz1o7k7KJykSAn9/zNrnxYfkDNQbniksGKjnOufn9ZMJH33chpbkyG59lt198Y+8E3jzAM4o2pgwyTGhhRlMtvxyzbKnQhfmMjuBLllLx/4XbCpcqHUaBSjSjD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:14:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:14:38 +0000
Message-ID: <891c47b0-6aa7-4c87-bda8-b6392986bd19@cherry.de>
Date: Mon, 15 Jul 2024 16:14:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] doc: Add a link to VBE from the bootstd docs
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-12-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 522e0ea3-6377-4191-5717-08dca4d8761b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1BWWTdUVW9nTGhtS0dNT29PRDJKODVLVDFERmxvNXdHNXR6ZWdldWkrUU52?=
 =?utf-8?B?aWM2M1M2RkxvZVRCWlU0Q2NHNVhUcmM1UEZvVys1c3ZkU2dPbm5kcTZqUW1W?=
 =?utf-8?B?bjg4RXNsd1JCU2tNMnQwZG4wNklTS3BvM25BNFc5d25LMUozVWU5UFVZNlZR?=
 =?utf-8?B?Uk1YYVpVcGlzYmJJU0FmT0xjY2dYNzAvdzJmdEJhS2lkOXgvQXN4SlIveUJl?=
 =?utf-8?B?Um1GcHBnWm9zZzZWOWZ6ZU1Mek9kQlRJcEN4SEpPTWUyZ05XR3VlYWs4QTZa?=
 =?utf-8?B?K09MNkFneTRBOG9uNFZVR1pZUHd3ZEtCVk8vQUZRU1lYdHBJSmVsMjJRTEdG?=
 =?utf-8?B?bWZSRUczSGZHaFVCWjBZQ1JJN09YUkEvclI5UHFPUlc0Wmd5MDVyNittZm00?=
 =?utf-8?B?WXJkbHhkd1NKcFZxSGNYMzV0Ymp1WHdkcGtvUFkwWlhkTHl1TGRTTzMrU2Jn?=
 =?utf-8?B?RUVDWUFYcWhRMWFFRmcxOE94LzFNN2JyU1l4TGFoS1ZRTXl0Z2drUUkzNDIz?=
 =?utf-8?B?a3M2U0ZITjRwd052clZ2SmZPbmZLK3REK0lCN05jMlU5L1NtWnhTM0xXU3Qv?=
 =?utf-8?B?VzUrOElYWllGbVdMK0ZuOGxTWG9keldWZ1FZS2xuRFU2SVpnclFLV0pITU41?=
 =?utf-8?B?YzhtcHF5SGlDdWZmYWRIcVRCQ1NlbUFCWFhBRk40V1ZjZlRPTkg4Q2dTeU5h?=
 =?utf-8?B?YmxlUVh2Sy9qMDZuSE1FZTVweU9OOStudURTWXJ0SG84d0I2c0YzUnpPTmQz?=
 =?utf-8?B?Tm13c3l5TGFxd2d1TWZ3NlFZeGxoR1lqQURiOFVHVEpaczJCRHRsWFVHUzFj?=
 =?utf-8?B?czV3RjBLN1NMMFcyUk1HRDgzK2ttYjdKN2w1aE55amU0UkNpMEdSN29hQmxj?=
 =?utf-8?B?RW5FU1FjNVlDbHREc1luVXBpRlBrd3RieDZoc2ZKRlp2L3NUY0U5ejM4L3Rj?=
 =?utf-8?B?QjJUdU44Um8rbG5KZEZjOGpCcmNuQ2ExRmV0T3Ewazk3NG9UaU5kNG5SaUdp?=
 =?utf-8?B?ZXVHY25xL1RaaFRkYjRSNnVOVE9rWjYvYjN2WHJpQmEwUjRESGZiRjRrUUly?=
 =?utf-8?B?ZzNYek5xVk4ydGFsQjRvMzBDcDVtWlpYZjh0VDZYTHdJUnI3UGJKaW15WHlO?=
 =?utf-8?B?bWU0S1dVVGR5a01PSnZ5eWVGRi8xL29TUjZGcDhMK3AyRXNRcktoV25Hendo?=
 =?utf-8?B?K3lwRHZaSXlReUhJUjlhTHRQWFNaNjI2UWRRTHg4TURBMTF5TjhKek5sZzN2?=
 =?utf-8?B?NXZYMldFWnl0SUhTWnlKOGFXUWRJeUU0ZmZ2MUtHKzRSeTZqTjlUdElNT3Fn?=
 =?utf-8?B?RFNlS3FZWWZpdC9odFlCS21FSUdmd3QwbzJSNG1lVGJlV3BTeG1DV0hZVTFB?=
 =?utf-8?B?SG00MXQrdzJoTUJyeGR1REptVGZMcytUNzR4SnVLZ0s4d0xvTnBjWmZkRVdn?=
 =?utf-8?B?RW0xZkxFNEMzTXFOT1c3TFVpWmcrY0lCWXhHbHljZDl3akMzSEV3ZHhXUmVH?=
 =?utf-8?B?ekU3R2k1QnI3UExZRG16ZWcyNlVPQnJCMDdmMXFEcWhwUDN3elNDQmpRNDlp?=
 =?utf-8?B?bndyU3puWWZNM0dSR1BLQkJOUHRTUW9LYXZDSnloZFowVlVvYTFicUtrTDRh?=
 =?utf-8?B?ejloUzVMU3c2enFyL3ZrTXhSbXRUV0JMNzVlUXQyRXNaV3NhQ2lvK2tldlB0?=
 =?utf-8?B?ZFBwY0xDVUhYRFlOeVd6U210dzFRYlJxQmVITTFjR3Q2Vmh4ODVlYlRKb2I1?=
 =?utf-8?B?aFVYQ2IvYjFDZFI2TEJFVmRpUXdrV2FmaWdRU2g2NC9WRnNtWVExWDduYlpS?=
 =?utf-8?B?RWl1WC9PWWVHT2lnQUVpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9TNXhNZjByV3RkSDBJdnZzZ29lNGRtWWdGL01Jci9vRVp6MnhxbnVZenpR?=
 =?utf-8?B?dFNIM3dudmVpbnJGT2xycHBuNGVidHRLWW4wdVNJL3VuV1dUT2FuT3ZXa0x3?=
 =?utf-8?B?blFMSEZBSHR6ZUtjVHlNNldXZmZNNWowK3diM3NYdllEU242aElWUzBWNFJQ?=
 =?utf-8?B?M1JBSGFuSGxRZXQ3cU1ScXlScERraHZtVjRFTXhhcldSajVVT2lXUUNPU216?=
 =?utf-8?B?Y1ROLzFaNGJVOWlQRmRrMDlGZVdEbmhRemlaWHRLYVpzZXJPWU5pendxTkI4?=
 =?utf-8?B?Wjh5MTZyNlRMOU5wMkNyZVdPL3FHOHViaVNRU0lZb3pxWEFQMUxXUGJlUmZz?=
 =?utf-8?B?cm11MGN6VnQzZnI3aXdKQ09ZRmVEVW5jdzRRbzZNTG41L3BoZEJVcm81Q1NG?=
 =?utf-8?B?M25oRXU3dC82eEZXcndYbjFtb0Q5U1N1OHpYVjZxbmlPME1GeVpXTEJsUEhj?=
 =?utf-8?B?bkNJWmY3d2FVcUQ2Mi9oRFZDUUtrYnBXR1VweUxtcmxvRkRJeUpLNm1tZ09l?=
 =?utf-8?B?a3hqNTUrMTZTUFFsWDVOL29oRTE2U0o3THBEMTlWekppVFFhbEMrbVRBWnJi?=
 =?utf-8?B?bUNkWFcxZTZnVEVJUm9zM0luUEpka1A2VGJCaS9ieFB2M1piemV6N0dFM3pU?=
 =?utf-8?B?dFB2L1BxZk1PRjlnbkUwK0RCeGRRWFdaZUQ5dmZFbjVRRDBBZkw0UkpESmFN?=
 =?utf-8?B?Q2wreGNJbmh1eEdnNGFzUkFaRG9KcmpUckZ1ZDZET3pkS2ZNWGU1aVBEQkgz?=
 =?utf-8?B?aWw0L3IyYmwrR1hhbHZxazZlMzhZRnorZ1JqUlhNQkV5U25nSm9UNWpnTEgy?=
 =?utf-8?B?NnpiRFJ6N1FaN0VtU3JuVmpKZURaTlB4R05PNG9yTVpZbzZ0TGE2Z2g0dWRz?=
 =?utf-8?B?Ykg5KzEraWszWEcxUXJtZVpuK0pjRVhOVk52TTEvL3A0RU5ndVJoRXFYUU01?=
 =?utf-8?B?a1AxRk8yYllmME1lWk9paDY4M09TcEVqUDFleW5VOWs0TUJoTjZ4eGxpWmZ4?=
 =?utf-8?B?N0w3RkRESXFCVGljWTRnUHBnY282S081OWVydTEycjBMdnRWZUJDR0RmUE5T?=
 =?utf-8?B?VkozTUFCTVBHcjB6WTZjU1dvVmZBQWJ5QURhRys2WTB6cjAvSnZxV1VtZEpB?=
 =?utf-8?B?UWIzVmF3TTI3Z2QvdVFkUnFRWWlnbEpXTHpEbnFyaXp5dUJnL21JZVhvSWo3?=
 =?utf-8?B?SURDSDI5SzY0MDhhemdLZTRsOHZrRUlxTjY3cjJPVHAwdURzblFvbTVGenlk?=
 =?utf-8?B?bnRMM3RKNzRvdGtXdkdiQzBuSGdmUS9kTU8yRTZMcjBOYjBPRmVzVUJ5MUo3?=
 =?utf-8?B?R0FWV2QvaW9LOVQvL1ZYSjF3aXBzcHQ5eWNRNGlTam8rQUw1OTM0V3NmT2Z3?=
 =?utf-8?B?clFVSlIyUVMyL2JJZjR6bjRPSnJ1TVEzOXdpOVJUTFR6aXZwdTBuZ2hHMS9a?=
 =?utf-8?B?V2hGUTgxSkkrQkNONWZWRVMydHRsU1lrRzlHWXdPWGJ2VkVWQjNBQVhOcHBl?=
 =?utf-8?B?bGR3U1VpN0tIZXJWTGVpUHpTczBpOEtXZTF3c3FHbU91TEhEQTZaVHdyWisw?=
 =?utf-8?B?V0tJWk9zZTAyWXJPTWNOSEJZVi95VGRkb0kzbU9EaGNEQTB3amJjM0FpOG0w?=
 =?utf-8?B?ZE1TTjU3aWFmS20rWWYxOStPTEVrREFITURSNzhKd3dVeDBaY3JZbFBFZVRh?=
 =?utf-8?B?dm1XelVEOE1xWHBnTm1jOG1wRmROT09rSzVzZ0k5bzVidGFJaE5BYjNSbUR5?=
 =?utf-8?B?Z2VROU1HcDB5RWQ0VmF2OFY1eHFxZm9VVlBnZXdmb2QrdStKb0llcS9OT2Vo?=
 =?utf-8?B?U1YrZ2g2NS85ZXUrNFIvMXBVcnN3L2JwUU5BUmhZcGhTWVpGWWdEb0xVS1Vi?=
 =?utf-8?B?SW0raDJsYTR0WVdFNEFSMk5XL213MDg2bk5zTm1lVTR4bzN4aVRTc3ZmaTN5?=
 =?utf-8?B?WDlNWC9EVEt5OGNVWGthZlIreVg5T3pFaEYzN3g0RkJvYTNITGY2dXRUUS9Z?=
 =?utf-8?B?aXB0aStPRTVRcElmWUNUOUZBaFIrSkdyQmEvaGpuUkhDK0piZmc5WnZDVC9D?=
 =?utf-8?B?UTloTHdwdVlqZmdON3l4S3l3NzhOSlh6MThOZWZsR3h1NU9JTU8zM3JhNEJp?=
 =?utf-8?B?c2ZWQ09uN0d4NVVIWWJTNWVPZWliWjNOSWpBcm43c3kzTEdFTzVONS9XcFEv?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 522e0ea3-6377-4191-5717-08dca4d8761b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:14:38.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47XXD0pnC/7qA7LXp8F47ow4EHliiyEnLHpJ5Ehp/69AxfFmtT4Hgy260tHqadbsmzNtBQfXpaCW31dW5SpxNhF8rzQ29yDKBMheZ0VTr/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

On 7/15/24 12:13 PM, Simon Glass wrote:
> Link to this page to make it easier to find the VBE docs.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
