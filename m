Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16275C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F65C80077;
	Mon, 20 Jan 2025 10:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3tWazww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98562805C5; Mon, 20 Jan 2025 10:59:21 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7A180017
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcB5EUw8oGxQSSccWPWqsSs72icJDaCw4OjjDjZ7Gsg+HLsja42pfRCJ/tEiFyuWCsC0Mxj2qnPjb9Oqnofr5b/kz/7X+Zdr/iHeG+8oz4F4o6E3YI6gw+M+U+9Kj3QuJ6XEy3R6s0vkMMxClLikE0+ytJvRvRT0zhwrMQ4tmRh34OkuMHpIuB9zS8/Z40N+O4jmK1L7TYcLJ5qRTmI2ZPrHk5CyNYWZHWke4U03kE0Zcmm314tWSGhsGyhv++SEi73Iq43K1+btb+zanejeyWj96q037zp71wEMNnWMyzemdKxJSOH4xW/nlcisVIeIJy65qkX8kkRl1RPtsnejBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uikWLlvrBPhn1Rq5qalCaoD/7h8xEzbksr21yBA87q4=;
 b=YWKJT1Dl2M3mhT9qA1IpFO+OwT4QyoREsvGKSRjZKW9SS1W/VJsVOcb1L0zOIXcEU9+8s3feXO8od8LM8h7C2UnxPeu6OppnEzv1UE0Mu/AbipuHH7Q2Nc876chLB8Z0o0XeNwoQkzCeHPF41UCY62cS/dmmRFoSoTpUbjUKI1H9BEkZ6eENRvMYSEO1y7GPB0u9FVBRbS4nz/tS2Pf3/HPdsJLjVglIfjtaFmilmYid3VoIDCuzwVYyXzDwv5kpVTAOoyHd3Bc6C3eW/RcwL1QhqLASCT2Pv0PvgAQiV6ok6u4lJeta+zwlbVAWcUYZI1m9VICgnW9oN3WVKHbcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uikWLlvrBPhn1Rq5qalCaoD/7h8xEzbksr21yBA87q4=;
 b=e3tWazwwmRKPbhYYVuPBuRnqkOkNQZP4R3JYC+MeXiXfWAwj1P2xkmXvn2MwlE1qW3nxQsm5pKpsTgVUkuVib09+8O8U01g+qaU88nijJbWTZfqKF8FTxLeI51uUOdBte9WYznl6rPX2W31CQ1+icOhLSGkcYFce9lILAnhCZJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 09:59:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 09:59:15 +0000
Message-ID: <3b0ef523-30b1-49b0-88eb-5a4cd7af82be@amd.com>
Date: Mon, 20 Jan 2025 10:59:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH v3 4/4] fpga: xilinx exclusive commands
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
 <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0294.eurprd07.prod.outlook.com
 (2603:10a6:800:130::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: d2257082-ef13-45de-e690-08dd3939193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnBBaVpNK25OVEJWYzA5ZkZ2dnE3bVdhdTVxT05VbmxidmZKLy9vbGRWUUlT?=
 =?utf-8?B?NVFDOG9sZkFCcURna3Bnd05acXplY0h3dnFOc1RTa1BSaWp1MFhvMzUxMFlm?=
 =?utf-8?B?bHZ1VkJIR3cwampOc21GeEpkNnZMUUpuWFh6NTV1NmxURmZFVW1VK3huYnFl?=
 =?utf-8?B?OVdQSW9YNmhGLzNDczJCQXBUdlQxVkc5S085L1lsSWVGMmNUQTBvZmpkdWMz?=
 =?utf-8?B?bTBxUzYvTlpSWTBOcU1RYUhDUjE0amRwc1ZCL1QyYXUyRnR4bko3d2lQckV3?=
 =?utf-8?B?VFZwcEdtRm9JdGJOVWxIUnN4djRvRG1sRldBRGpwVWo1MWx0ekdsS213OWlS?=
 =?utf-8?B?MlNoMzBKMjdDRnR2RXZRVDl0bVZyS0RhMVVkakNtSHNyVC9ZaVU5VlU4SFJG?=
 =?utf-8?B?U3E0L3NIZEN5bGt5bkdzNGR4bWVldWd2VGdvQ1FOaE0rZ2pnYm1sR29HRm1M?=
 =?utf-8?B?b3JKa3ZmNXFhd1VSRE9nNDdxcmlrTnBDQTE1R0Vack41UitaUzhGNHBSQnF6?=
 =?utf-8?B?QU9HRkkxYmhraVhqK24vZkFuY2lvTVArbGh4NmxZSVhpSUExWGtZczZYdHVo?=
 =?utf-8?B?enFvNmNIS3R3dHc1bHBDSjVXYXkxczNEL1J1ZUJET05zdkJBZnN6TEszRjlC?=
 =?utf-8?B?YSsyT1NOZnJCRTh0K1NvZWVEZFpzTS9RT0V0UklFYjNBTW1MN0w2aFpjMEpy?=
 =?utf-8?B?UkhTcXNPOVY0SDZ5bU9wL01FREFZTjZhYkxOaFdaNE0xVVhsbERCNW9CVWFF?=
 =?utf-8?B?UGt0Yy9sbEIzVHVPYStoRzJ3MDRBVHMweDZkVlRHZHF0UEhMYnZFZVZDNnZq?=
 =?utf-8?B?cjZoMDdmeVN4bnVDUHBZcjljSy9mUTR6WURrZFhSWlNvK08zc2V1elJpRjJq?=
 =?utf-8?B?VFh1MllwWDlCb2cvOTlBdmdjOHNzdWtXd29iZWJmNEw2cERkVUJvK2tSc0JM?=
 =?utf-8?B?Y3E4REFGTkpjRmx5QzFRRk5oNHpwMGoxTlBOdjlWak15SU5MSzVVME1ydzh0?=
 =?utf-8?B?a0MrL0dsRzZKZlZIUFdhdlVaVnRYbTFVK2ppbFgxYk15YXBvUVM5Y1ZCcmJ5?=
 =?utf-8?B?OEFveFpVWHZiMlB3ZnZUMEtyVlBhTWFYOEJ5VTJIeGpHSzU1aEEwcG4yb01o?=
 =?utf-8?B?Z3NCU0xzM0RTZkJTUVlXdUNsWi82U1JRcmVjYzBBY3QrcjViS1hGbmNLbGNh?=
 =?utf-8?B?ZDVhajRoUU4zTFJKTnhnTmVkdU1jNnV3eXM0U3Q1MTZJVjIzTTNsY3NvcHZC?=
 =?utf-8?B?UHpWN3FlcjQ4ZHQ5NS9lRWR0Y083d3cwTWxod0dXNnF0YnlWUkRHQmhwWW9l?=
 =?utf-8?B?MEs2YW9uSnhoaXBRNW5URnV5WStWY3BDVUhOSzZlcUJFMFFuWDJFWEZuMU44?=
 =?utf-8?B?M09XcDN1K01SUi9pUnJqeEdISFR0ME1NZjR0bGhtUkZaTzhyOUs1R0dZbFpS?=
 =?utf-8?B?NjU5MXhNRGdCNkRpVTIxQnBveTBkcmhUKy9pdS93MlZRcE41RUVuZ3VkV2pE?=
 =?utf-8?B?c1IzbFVmT1V5cHpaNXRGVXd4aGJsWnpzOEtpUVdrd2FkamtTc0Q2b29SbTdS?=
 =?utf-8?B?YThNNmFEWHJPRGVLYTUvZzl4VWtSOXFwMVZpUDJnVFpKYXpoSWh3elBReXFm?=
 =?utf-8?B?aHI1Y29ZWjRCVVUwZFBRaVgyMkxwTkVDZnBnK0VXcjdHOCs1QVE1amkyZXRN?=
 =?utf-8?B?ZmxZM0x1L0ltK2xSOExFMDV1WHJKeTAyd2VmeHM5dk1jTzluU0lBcDBlNXl4?=
 =?utf-8?B?MjhqL0w1UDVoaHYxWjJERGd2dkNzTnJaS0dwci9TNjNkVktSalF6YnhBV3Y4?=
 =?utf-8?B?MGYvWHhTUVBGVk5FSStpdGt2di8ySEtEZ0pXcmdkTkJpRVE4elFzeXNsME9i?=
 =?utf-8?Q?q9NoWU0FImHjk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjQzeFIydWlmNzdtN1JEbUZ4K2dFT01lNkZMOHRqTzZWSEJmQSt5bVg3QlZa?=
 =?utf-8?B?Vys3ckdMRHFzSEkxa21pdG9Yckw0V1BQcnVlanRpRGhURi8vanV2emUwbjJN?=
 =?utf-8?B?a1VMWTdIR0x2Qkw5VDNXM2pnOTNIWFJER1B4RURzYjBNcS9hanBaU0F1YlFq?=
 =?utf-8?B?cmFONE5ReUl2QlA1cGEzWmtnV3BWZTlXZ2F6STlOYWhiaTVLOTFzVmk2YVFp?=
 =?utf-8?B?bXNLZ1lLNXdHREUwRGZDa0o5NjBIZy9qMlJ4K3NyT0FzNUw4TEcxYU5NRGMw?=
 =?utf-8?B?WDgrUFRkSnA0dW9oSnVHSzNtSW04eTVPL2VLSHQrV0NZU3ZESmJnZWVJMlJ3?=
 =?utf-8?B?NmIxKzkwaGVHc0loWnoraUxUOUFwRm9PN3FwS21hRHRWVVJKSXVhWGtVUzBV?=
 =?utf-8?B?OWNycVprTEpsbWdVTUNhZ1pkZWxDOFdaWGl1dGdETU52QzBsR2RUUTNoZUxC?=
 =?utf-8?B?T3pzclZJKzlOcXVDcjJxK05wbTRzdUxEOHZ0QU01Z3I3eU1NWndMMkplM2Rq?=
 =?utf-8?B?aW5TSHRZR1Yyd2x4d09nOFhSTEZmVmVMcS9pS05jdHNWU3A3cFhRTExmdi9y?=
 =?utf-8?B?RjFwME80UVdxUVNKM0M2azVydFdGSjFqZFVEUW9tRkR0azRzZzg0RitXMTlu?=
 =?utf-8?B?dm5YRW5EMmxjYWVEVFd0Z0g4Zm5LT01MOThKUjlWTUlLc2Z5My9iMDRyQ1B5?=
 =?utf-8?B?a2JBVWJRMDg3L3VNT2pCMktyblNHcm9zL1NQdjlSYjg2N09EZlFBcU94VlJE?=
 =?utf-8?B?TVRpR29CZUFkbXlmdkw5YzJOREdLT21DbHJXc1loYU1xWHF1RFpqc0o5ZDhT?=
 =?utf-8?B?eDNIN1NaZzcxeGsrSWpJVjBhbmsyajhlcHllTjlrU1lhRU1NY3NLcTJHT2N4?=
 =?utf-8?B?MU5Nc2hrOEFUK1dmOFI0Y1VhMndlMEF1NDhIbC83ZTNKWGkzTDVtS20yK0lM?=
 =?utf-8?B?TGNHTkpDODkxQURkWGNhSXVzVWhNUjFsNFZ5SzBOdFpFU0lIK1hOV3h0RkMw?=
 =?utf-8?B?WVFWY3dIOWZFaTJ3V2VKV3dOVG1keGl3WEZXNGt1K0xVckNGTy82NkFwUXZC?=
 =?utf-8?B?VGFkdXpXeXlPQjc5T2Y1OUNjYWRmdEs1OXJhWm9oandrS01TalZlZmFENDMz?=
 =?utf-8?B?dFJ0MitPcW5yRElPdWtEU25JdHZSV2xpdUxMakNiODh1bFlaNTBTR3l4WHhw?=
 =?utf-8?B?RUxIa3hpSHN5WndoOTkwMEZLWEIvd29ZemdEczFzNWVjQ0FWYWxjSHkxRm8x?=
 =?utf-8?B?WXA0dUV6TUplelFpT2xKbEdIVXlHenN3K0tzUDZ4aTJpSXBYT3QzTGxsZEZO?=
 =?utf-8?B?WC9pTkxoN1VsaFp2TFhGR3VRenZabWk2MWZPZnliVkxtS2hRQXhDRjJERjdG?=
 =?utf-8?B?Y2pjclRSOGNRZmMxNyszTnlmaytydGU3eEpER1VHdDRtUEZ4dFFqYXB2ZE1P?=
 =?utf-8?B?eDEwcFdGWTI2ejk0OUp1ZEhJR0xZcnhBNEFpTytMaUVweFRuOGtMMStOaldx?=
 =?utf-8?B?U0ZvL2diQXBkVXh3dUN3emRxdVRMajlWRGV3QmRXa2NwM1prRVJDejU4cklp?=
 =?utf-8?B?eGc5UkdKVjh1cE1iQy9sRVFWVEY5T0MrS1QwVHZvczVGaFhaM0M2UTVPcmt0?=
 =?utf-8?B?MjlTNGNHUWJ2ZGpXVXpBZlZqa3p3bzFFV05saUJieFViazlWelZpQnUvOXRY?=
 =?utf-8?B?M2xwNE9yK3BkZC9JQ053d2xaVzFzdGM4REt4YzVhZHR1dk13ZnJsRjByTUpT?=
 =?utf-8?B?TElhL1Bzd1UwY01TYmZEVzFrVFdGa1VKYitBa0xQbitqN3pKcUVSSytXSHdO?=
 =?utf-8?B?VDZ0ejZGZ0JkUDdNTUhLMGFXdnlCU21IZnJnU1N0UWRIaE4xL3RqTTB4Y08r?=
 =?utf-8?B?K0Nib2pLQVA0cStFZ2pvczNMZlh6bndKUUdUSWwwVkJUbDFLbjZncFN4bVpI?=
 =?utf-8?B?eHdLUjJEWEFtWVQ2bWNJcXQ4SVBWMG5GOVhjS0Z6Q0U0Q0dBQ1E2M0VUMm1p?=
 =?utf-8?B?UVdnblFEZGVqMjAxK200ZnBNcEtnaXpvRzFaeG1sWUZnY3pJTjNvMEFOSHo2?=
 =?utf-8?B?aTlzZHpWb211bnJJNlR1VTJraHFudFNIek1zVTJwck0yL3R1U2EvWkMvdk1R?=
 =?utf-8?Q?ueOfzkllp7Adz2FwoHw6fmzOi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2257082-ef13-45de-e690-08dd3939193f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 09:59:15.8643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wLOHlKAzlSTfdaAyxtQflx4tx4Q5/d36QcCFygvDOy1mwm83UXN1hsZ5jxge/HA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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



On 1/17/25 12:25, Ibai Erkiaga wrote:
> Ensure all Xilinx exclusive fpga commands have a KConfig symbol and
> dependency to FPGA_XILINX listed. Remove (Xilinx only) text from the
> help command.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
> 
> (no changes since v1)
> 
>   cmd/Kconfig | 16 +++++++++++-----
>   cmd/fpga.c  |  9 +++++----
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f3ba230db42..822adbc7da1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1163,6 +1163,12 @@ config CMD_FPGA
>   	help
>   	  FPGA support.
>   
> +config CMD_FPGA_LOADB
> +	bool "fpga loadb - load bitstream"

This should be default y for backward compatibility.

Commit message is not describing that you are introducing new symbol.
And separate patch should be created for it also with adding something like


diff --git a/cmd/fpga.c b/cmd/fpga.c
index 8c64e957db0f..9b0736427478 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -181,6 +181,7 @@ static int do_fpga_load(struct cmd_tbl *cmdtp, int flag, int 
argc,
         return fpga_load(dev, (void *)fpga_data, data_size, BIT_FULL, 0);
  }

+#if defined(CONFIG_CMD_FPGA_LOADB)
  static int do_fpga_loadb(struct cmd_tbl *cmdtp, int flag, int argc,
                          char *const argv[])
  {
@@ -195,6 +196,7 @@ static int do_fpga_loadb(struct cmd_tbl *cmdtp, int flag, 
int argc,

         return fpga_loadbitstream(dev, (void *)fpga_data, data_size, BIT_FULL);
  }
+#endif

  #if defined(CONFIG_CMD_FPGA_LOADP)
  static int do_fpga_loadp(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -357,7 +359,9 @@ static struct cmd_tbl fpga_commands[] = {
         U_BOOT_CMD_MKENT(info, 1, 1, do_fpga_info, "", ""),
         U_BOOT_CMD_MKENT(dump, 3, 1, do_fpga_dump, "", ""),
         U_BOOT_CMD_MKENT(load, 3, 1, do_fpga_load, "", ""),
+#if defined(CONFIG_CMD_FPGA_LOADB)
         U_BOOT_CMD_MKENT(loadb, 3, 1, do_fpga_loadb, "", ""),
+#endif
  #if defined(CONFIG_CMD_FPGA_LOADP)
         U_BOOT_CMD_MKENT(loadp, 3, 1, do_fpga_loadp, "", ""),
  #endif


The second issue was commented by Alexander.

Thanks,
Michal
