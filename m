Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD36D35685
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 07:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2F584164;
	Wed, 28 Jan 2026 08:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ILFNn2fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A40884255; Wed, 28 Jan 2026 08:04:46 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C95084154
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 08:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNYSxEgoA2+RxJw6P8J1F+nWGIHW3vflHnOC1QZNOJ4QvknHQTdYOh7+sKJRPNnBOvnHjLtk2PubZpd15lwZKeztcREtrd97P/QbIqCU7RjNboMXAKA1X6NUUHjIv6oC1UD/WjWGwW7W+wqOatSxUVO8/QEImTpY7pq8XODjCGRjfunJkzNwpJAdLaYrd3ImgHIZS5g3zpfuYsUR+8NcauTW4OeAcIKr4BgVZot54RW15xn3whxpfQH1oK2TUg0IVTLhHTotb290ukxTuFzcCMGadmLKDWgxILywwngaXfiE8MnTkq5QhDunH/mkM7xNsGn7B3ZLwmZzd/9xHoyyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs9iggD2MeyOQQpU+1HvCOGdpceMoZjiP3WM1ywzRDo=;
 b=pOV/7wrOLb25KuWDHnMKn9o04OXdQEqbWMVSvJ+kqVHlQ6eg0v4Yn+ufJr3/1IeEtaYhMpxhH+dsDp5I4P6Qp1YGTZUJdXi88NmFNcl8rU/aXDX4J723JqJ3rnPkBnfy0HUbRjLnkLc8c/5Wt9PWnfFbyHtVA9cOVzKrEcoB6Wo1HXb2762F+4W9HG1fVVzvoJ2InneNK9vlWjnxmxr203w/RJcEDansP+lWQUO0rU+0vFRqipC7erSZ1HKT1xcCCK2lmtZHEVGTltuTXjubcy+pIkPld5W8/7c4v1hM+oATCeyecK5uCtodSYZHDWGuz0os2RMJtBYkPCUsgSW3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs9iggD2MeyOQQpU+1HvCOGdpceMoZjiP3WM1ywzRDo=;
 b=ILFNn2fsnxIr9XF8uyMEMkOGFY6oYj3fJYDFbflyP05RAxHU2yTuRrtOHgTxLLBUaosyTZsBhvwpGiRBtAR3e+nKGritg4pW/YcyJqnD1v7BhvfoP2EHutcx9QiWm992EKCr3H8L4IcdhCpdnTBEb7FKpf41PddtLUQWjUNcggMtPptAvXP40OVgoJZCtqd1kzEOSo0Pj5Sazniz3kb+/YnHcTOnNj5RsxIePHDrj5YLWJvYU/mqsxIHLZpliRKhgngNCi85BabhKEq7PasJNnJz/R7jercPh2AF2kNZ33dfsBAD6PpfI5acP78bfUzOgh13w7H6/vn2pqHpzFNqEg==
Received: from CWLP265CA0408.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::21)
 by AM4PR10MB9479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 07:04:41 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:400:1b6:cafe::d) by CWLP265CA0408.outlook.office365.com
 (2603:10a6:400:1b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 07:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 07:04:40 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 28 Jan
 2026 08:06:22 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 28 Jan
 2026 08:04:39 +0100
Message-ID: <9b46b3fc-e46f-4f85-9053-2537920f6db7@foss.st.com>
Date: Wed, 28 Jan 2026 08:04:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] video: simple_panel: add support for
 "rocktech,rk043fn48h" display
To: Raphael Gallais-Pou <rgallaispou@gmail.com>, <u-boot@lists.denx.de>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, "Raphael
 Gallais-Pou" <raphael.gallais-pou@foss.st.com>, Philippe Cornu
 <philippe.cornu@foss.st.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Fabio Estevam <festevam@gmail.com>
References: <20260127-simple_panel-v2-1-c50d5b23881e@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260127-simple_panel-v2-1-c50d5b23881e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|AM4PR10MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ccb959-9b7b-4a48-735f-08de5e3b81b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U09EbkR3dnVkVkpzY0tzaE1oMktPWDdBbGdoSmI0bUtxUE4vV2FRM2ZmY21Y?=
 =?utf-8?B?QzdJVFM1eERjRHVJK3l0NitPLzNBdkNhdkVZamN0ckxIeWhtYmJqdVBjQW04?=
 =?utf-8?B?di8wb2psZ3grM2lzQTNabVRnL1kxaDJjWUN1aVZqdS9RVlZLOGdOTHhDa0Y1?=
 =?utf-8?B?NVdWVkp3U0VVUElhQm96VDhIL0tuck5vTDdzWTdsLzlKVDhTd2E1QUNRM09P?=
 =?utf-8?B?UEhGSk9zZnF3c2RjV1E5b1lRSHkyNEVLc1FhYmtmR09HWnlrdHA2S2RjY0pP?=
 =?utf-8?B?ZDlqZFgxaHZGaHk3TFZTay9XWlZIc2YzSTBlVU4yS3d3NVdwTjZ5OWdtTGNy?=
 =?utf-8?B?RlU3NDF2SVNSZ1ZPSzIyQVZtSFBVWVpqTDh1THFaelRDNzZWdnpSS3FrMmFo?=
 =?utf-8?B?TTZKM09BbWE5ZStOdDYzaHBheWtVM0E1OHlYV1NjMWU2c0RUYUJQRDZKTkdD?=
 =?utf-8?B?RkZxQUpmZHJnR25heExrSFdld2FaR3NFWHpQUDRHcjZzTTVHUHorTU1kOTl4?=
 =?utf-8?B?NTRxODdJQW9ScEJmTms3UVhEM0dveUZzTXNOVDd6ZFVlbHNEOHVlMzVzSW5a?=
 =?utf-8?B?dTM3SFhBaE5aa2dSWFBQTG8yNkJiTDI3MDIzRFlEUmpHekRHMGVjNHh3MFBX?=
 =?utf-8?B?eDlLbDltdjZlaCswRHVXT213eXBnRHIwVWVGQU1NbS9HWWZ2OVJjZ0dBejhH?=
 =?utf-8?B?T2l5K1NDcklLMnlGN2RyUnFyYlh0VitZV2wyM3ZBdFRTVVowVkFBcFpEa3FB?=
 =?utf-8?B?c0h4ZjhJZDRYWjdxb29OQldjWFZuOUZjQjBvODJLSGJUajVScGN0NXpUeXNk?=
 =?utf-8?B?eThFelFQOGVJZlp2b0pvSjlMak1FT1FMQUhlU1NYSlhSU2doMlRDZ203RjN6?=
 =?utf-8?B?d0E3VzUrRDN6SHVwVmg4ZFhGdjc0ODljZjBvQnU5elZEV2NPWDhNeU9jRi8w?=
 =?utf-8?B?QXV4SnNVZUNodWJVTnhvMjdNOVUrdzFHWHkwZS9RSmFJd2RKMndYYndDTWpB?=
 =?utf-8?B?KzVwSW41cTJnTVZ6ai9pWUlmNVBhMS81UndiN3R1enpvQkExeWlNWlBxNk1r?=
 =?utf-8?B?Um0rSWJ4aEdXaGIxRit1ZmRlNGMzeTVNbU0rUm1QWGU1RkhIem1aVC9jR0R4?=
 =?utf-8?B?ejBaaDJ5N2hxTjBmREtKUnRxOHl3Mi9SdXk3V2JaQ2l1QVZZV1ZoYk83WmhD?=
 =?utf-8?B?cG9wL3ZTdjBuRExxR3JqM0Y2ZkJPTE5VUFN2cFV6VUZ1VVU3OExsSVJTT0lD?=
 =?utf-8?B?eHRuOUxlUklYNENuaGJzUUNJcXRBVGJiU2k2ZDRoS21HL0toSW90djg2MjFJ?=
 =?utf-8?B?ckwyY3YwaDdISzlmelV6TVBPRXhkTnpwUUMzeERUNEVNYzNKcVdORnR3b2RF?=
 =?utf-8?B?Snh6cDdvSE9SSWxORFRxTlg1NDJQbVorZm5rOXYzZE55SFp3QzIrR3Z0RkZU?=
 =?utf-8?B?M05uK09jVkVUZzVUL0FLMVR5N3A0TGtoT0Fac09lb1NzOVFZK0FLcGpOVEx3?=
 =?utf-8?B?K2YxQndsbGpQaU5JdW9xNzVjaUU1RTJnZFRDaXhiTnoyS21Pd2Z2a1JpaW1T?=
 =?utf-8?B?RnNxQXY4b09GM2sxOVE1SjZlR01nR0ZXSWJ3SkU0TXNVMnFldVYvdVVzbzVp?=
 =?utf-8?B?M3c3cnlwTStGYzhLeEtDMmhWeTNrMWZURHVOc1hEb3JWTnJhTFZIcmE4THFD?=
 =?utf-8?B?aHI5VzlxUUJhWmpoZHRhNFpMYmtiODNpOURKWEFrV25hdDVoNHcxTUFJKzdZ?=
 =?utf-8?B?YXFRN29kTFQ1VXJnZkl6YTh2NUxJYXk5UnZnTDZRS2dQMTFEaktRU1hzY3d1?=
 =?utf-8?B?Q3dFK08rRVc1RGs5aUIxdGs0ejRuL1BEQkRmeDc0Y1lPTm0yS1JYckpMbXox?=
 =?utf-8?B?Qjh3SWRXMy9kMGRHMDU4Z2lody9VVGc3WXZxTXVUM1VlbnFhV01ENjJlck1n?=
 =?utf-8?B?bklCaFdZck9ZWVdwbEg0ZXZvQ2E4TW8zdXhXcmpPWjB6aFNRWTF4d2NlaGZN?=
 =?utf-8?B?VHJ0S0xLWFlsTE5HVGp4bmhzOXk2TGhYWlBMVVBwN2FmL2ZRODdVcTlFZFQ4?=
 =?utf-8?B?QVFLTlFsV29ZTWF5cmJKRzRmNVYvT2JhNk9vbmpMOEwwcW5jODl3RE83S3Fv?=
 =?utf-8?B?US9vNHo3VHdLUlpGREUzVTV3czlaczhLbDZodGhuKzZLazVpUjNlTmxsZUQ4?=
 =?utf-8?B?ZHRPclV5UWNjUmUrVzV4MzdESHR5L1pTaHZOZlJjMVhrdDVKaXozbVVnalA5?=
 =?utf-8?B?cDIzTitGM1ZLeGRhNGZncGF0bUFnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mIkjxqcNqwd8XD9OUkbTcvc4UBHVTae32BUmmpJkUw9PSzIYsAG7tebwOh69ThaCKDDa+5OocR7XtciAYA7/ZA4iFQ8+W/Sv/VuCsAGfJ8CCF7ueVLTiluRGOvf7orhBjEVm99cVRzW5gHAaZAFy7Sa8wA/nviuud9oPfKH2y3R/Uc4TymzgQ8TgjsSqaZx7xA1HLwigc27Kz/7p7Of9Iys2X7/Uxn7FZpUsnro70vYlxTx2e5Jt3WQQwvSXyvbzSwam+oce0qFnppb/OZt4Lpk4rx+pfatRA5pm1i1rJ+79JYNQ6Du3PbnvI4vd3DuAmq66gvhUZtBWE9KuSQT2ewHfqq/WJS4uoztvktbP4o8+JG26iX/KXL6/fR4IQIhGa7fOEkDcpUk2s+Y7TuLO4w9WinSx2bH8Nw7BmeqxyEK2hOMZvzKZL9GfdWYF6qQZZMChIMZ/lKWj5vrzl15AViom9DQwgPZc5CTsLoTkriUS24lZSH0cOHCGqr9tXEaREoerBFshpHuCZwxSZwt53JGCSLAveiqL0fCO0Z1M9UDD+ohKEcroPbfobVjgOUPiW8F96w1nMCUmLz1+qXq0N6Aiu1p6hclLOsFBs45S5lDFkJ4ksNjyMoFbRLvdUETTxybQUE+iZ6E4aeQGDT6JyL90DkWaSbvd2UYwPh5toSrs8RoFLPeRzJ1qF5lgvVa/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 07:04:40.4263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ccb959-9b7b-4a48-735f-08de5e3b81b0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9479
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



On 1/27/26 12:11, Raphael Gallais-Pou wrote:
> Add the compatible "rocktech,rk043fn48h" for simple-panel driver.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> This patch has been tested on stm32mp135f-dk board.
> ---
> Changes in v2:
> - Rebased onto latest origin/master
> - Removed unneeded blank line
> - Link to v1: https://lore.kernel.org/r/20251207-simple_panel-v1-1-8688d221aacd@gmail.com
> ---
>  drivers/video/simple_panel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
> index 8fa7ea4e87c4..1cf587f973be 100644
> --- a/drivers/video/simple_panel.c
> +++ b/drivers/video/simple_panel.c
> @@ -251,6 +251,7 @@ static const struct udevice_id simple_panel_ids[] = {
>  	  .data = (ulong)&panasonic_vvx10f004b00_data },
>  	{ .compatible = "tfc,s9700rtwv43tr-01b",
>  	  .data = (ulong)&tfc_s9700rtwv43tr_01b_data },
> +	{ .compatible = "rocktech,rk043fn48h" },
>  	{ }
>  };
>  
> 
> ---
> base-commit: aa4f687977a449686498236722ee5e93d8b39918
> change-id: 20251207-simple_panel-1a910ee5175d
> 
> Best regards,
Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
