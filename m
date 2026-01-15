Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38378D44C53
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52B980325;
	Thu, 15 Jan 2026 15:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J+jNfhgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E33783015; Thu, 15 Jan 2026 15:22:26 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F11C80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftyZKslfRD2P0f1nv0yxmzDiso624gbX0faogrSuwOB/5T6OCsnLcqoU6X4Uey2XHrTvr76hw1zVPSprRWoOU4O+qGP72TU48JJ4gPELlmRQ9Eom5aKd/tAgG5HfhDzJ+5N1o25+9E63VACIEFqQmKgmgqWxBIPr8/WT01vLZhjZxpzgDQ+WOC0Ss+GjJ6ijw4CwBkM31g+ZQRtA4CjPeKN0f4xL3DGsOTeBMLixmAmenVl2dcYWQCHkBE1UqVlDi1zmLz+E4At/6l2xlsZLGjFdeJE7gTaSEwyzhKoASTv9SnsHfIelIg3k6CNjSPF1CSMwvqb0RQT05LRS2xGjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pST/yLMfurzqu9cZcovJsRlWYStlPeAvTndXzIAZP3s=;
 b=xyigGlkXWKGW0G2oAQUt9vbBKZycdKblClck/tPLQUQGIhNhS22NYA4argEWDUclhVFaIQFty8gPxeC3X9CEDuPWqzDYyAzGruQcFV2s0khpEH/xTK77/oUkx5t1B/M6cUgvWHqC2gCN93CfNhasiBtvZM1C9DMoB6QAJ1R6DWqByuzgYm2obvSEzo10AxK68Q60Bpi4g5RnP9LGaizfW7+xoFv39Rxi2WCMMoFyIlzCbadk+X/Kh9MPpFGtHelDAKFFU1SxF+3vTi7oHZjiB3QwSu4VDKiejLOq77lCLLALEliQDnyZ3mD7dPHS1U8DmE5WDfkylLcu3aHcZJwt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pST/yLMfurzqu9cZcovJsRlWYStlPeAvTndXzIAZP3s=;
 b=J+jNfhgFlAlPZ8cYeF35NYVIRGi+VK3xIjhMX8cRjU/M+563GZD/5L19KrPOCQA/9t8PFqCjiKTycc8L8KGbPkbFFDujk1qCLVoKekYE9WQTpjcZOjzianwhsGC6c0/QhOY2qthS+W4FYI745MvrE3KQuoZhuW3S8+GxhlHWmQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10146.eurprd04.prod.outlook.com (2603:10a6:800:229::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 14:22:21 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:22:21 +0000
Message-ID: <7f21cdd0-86d3-4ba1-93bf-4d50bf021924@cherry.de>
Date: Thu, 15 Jan 2026 15:22:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: phy: fix code documentation typo udevice_ops
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260115000724.21472-1-e@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260115000724.21472-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10146:EE_
X-MS-Office365-Filtering-Correlation-Id: a74631cd-0cf5-4406-9bea-08de54417f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmxnS2VQVFA5TTYwZlBwZlQyaVRIK0dIRXJMblM2NS9uVzZ5cnMvaE9VUGdP?=
 =?utf-8?B?VFB6d1V3bmdOZGcyZ1g4VDM1bmRHL2NQOEJlUm81ZDd5NWlaTGw5RjFOSlBE?=
 =?utf-8?B?TDYvUFNYYXQ1akU5SjVDd2tTRDZtbEpmc055MGZ3YXZ6VVdvZEZheWVCSWpj?=
 =?utf-8?B?SGJEODduallXMEtaYlFjUHNvVTdXcEdKSzBBcURxV0dXWERmVEtLdENwb2li?=
 =?utf-8?B?UjEvMlhEUjNnN0xEVHNENTFveUZKTXVoNmsxZWlGZ3JyTnUxSkhPN09ZaHBL?=
 =?utf-8?B?TVNhUHJ1akVnZGd3V0YxQ0FIa255SGVJamVIWDVVUHlSc2JHb3NiRDVJVjh1?=
 =?utf-8?B?Skp5KzlHZHdyS1VpdUpwaVh4dENOZjR5UExWYkFGY3drTzVTOW1WQUhxUlM4?=
 =?utf-8?B?dEgrdERVWFlBdHArUWFWS0JySWQ1U3hwa3RVK2k5cVJyL05ZWkVNbWppb3Yx?=
 =?utf-8?B?Z09vQ2w5WjYxZ1NMZ0wzRFlLZzY5VVdyTk9xMnR5SVJYZVIzMHZWdGpRYzla?=
 =?utf-8?B?TWgvV2s2Q2llRy9LL2p6aWZxTGxqSWVwWXgrWFVVT3hGdWtqNUhXbXBtK0dZ?=
 =?utf-8?B?MEx2amVycDRQajNKdms3aXVka0Q4dWduYzZYOXZoRTNBVkd1aVFWWDVhNmdV?=
 =?utf-8?B?OVk5VlJRUFRLNGxPQmZBd3pIcnY2aE45S3YxQVJkdWlndTkvbngxZGRpYmhI?=
 =?utf-8?B?bUJkeHFPZUNMSmI1bVVyRitubGtESWN6WDB2dmhTeGF0d29Lb0ErcGZmWWR4?=
 =?utf-8?B?UVlzaENKNDBNZUgxNDNqSFN0ZVhueHpTWkhGYjRpNHlqMk5pOTN1TE5yb25h?=
 =?utf-8?B?NWU3YWswRFp5UDV3RUUzUW5jbEx5OWdCZ3FDcGd5NmdvckN2VitVcUQ4cVZl?=
 =?utf-8?B?OUtYUzVDM2xzRFVYQ1paNW9pZElLbU9LYjBSWTBvbWhZYUlpM3grTjM5cGlh?=
 =?utf-8?B?WDZ3eHpWRytlMHJyUVlxZ3VIUDJjaXFFcnEzYkFKcjdBcHdrRDBqdlE5aUg5?=
 =?utf-8?B?NTVCV1JHTDVqM3RUVm51eWo1VHBKejNlTE1RcW9hZFVSTjYvQUlIVnhrQlV6?=
 =?utf-8?B?YittdFdOVmUyV1VrVU9KaVNIQS9ZcEpCdlNUMlFBMmRDV1dUczJmbmUrM2Iz?=
 =?utf-8?B?aXByYyt0cjNzbE9GSmROdTNzMWowb2E2Q2dYUlZLV2FSaFJkZFNhT3N0UWV2?=
 =?utf-8?B?blJSWFh2TDZFRFZZdjlpNHlWNG5EdWhBQUZnWlZPOEh4WjRZL3JDSTNUYnFR?=
 =?utf-8?B?SE4yUXZybUQ3Z1JPSWRKUVpQN1dvOHI0UzlvK0M5czV4d001SUg0MElXU1dz?=
 =?utf-8?B?dmJKZEJnMjdMZGNqaEE2QlU5T21EaTJ0YW5ZVUI2TnpxSnNxRDVySDF6OXpW?=
 =?utf-8?B?eVNsV0lhUGlSeVZCNGpPZUI4Vlc2UkVpUzRBRXBlcGY0cG9SR05DQWlZOWlI?=
 =?utf-8?B?ZDV6OStPZk5YcnMvazJSakIvOWZicC9CcHQ0b1NxNHRBVGpFdXg5Rmxvb3F2?=
 =?utf-8?B?Y0lxbWVuMmRPMzg4ZVQwRmlxK1U4WlQ2Tys2aGxJSytOTkJWZ0cxVzlWWldL?=
 =?utf-8?B?VTRscUxPbDlKYmJqWGd3ODNCV1J4YWNhZDZYK0VDNUU0YjdJMkQyN1VhMy9R?=
 =?utf-8?B?UlNaWGlJZ0NZR3B6bEhkZGgyaHBSUGErTk81OFR5Wi9nM2hqVERJYlhmTXB5?=
 =?utf-8?B?M1ZYN0NXakJQK0Y2Z2ZGLzNJamxIL0I3NHFlMmxZMGpteGdRb1hJQUN2bEU4?=
 =?utf-8?B?VGFWOXk4cmRJdytlSkgyOXJuR3Y5Q3hRN29NaEowRFN4cW5ndUhwMFNnNWF1?=
 =?utf-8?B?ZC8vNE9BYjhJeERTYUpmTnVYNDFVKzFMS1NtK1M0bVV2WmRWbGJjdDhlN3Jr?=
 =?utf-8?B?OWdEeVN2Vmp1MDZyUGNnaWQrWWJ4cWx5TWI2dFBhTkNLZ1J1cHVRVDVjdmhz?=
 =?utf-8?B?aVZIclFYeXNQQTVBYzBsci96ZTE3ZlZuVjM1c205cWlMcm9IUWlxNXVPUHZ3?=
 =?utf-8?B?c3RNejI3bWtLb0QxSjIrZ3VxaVkvNXZOT2dId0xYZEVFVXVHYS9RNjZuM3BP?=
 =?utf-8?B?WWx6aENtZDN2Z2M5Wko2dkljK2JNMGt0MnQ1NGhkYkRtMU5GVzUzMzhIUGVW?=
 =?utf-8?Q?ataw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJHTEltbjFwd3ZObUpySzFKN25NUFVzUlFyQ1dWSTAxQkNBZmlLam12M1Bh?=
 =?utf-8?B?OUVHeDc0YksyWFI0dzZhZ0JaKzdYSGJCSjMzS09saDJJVEMxdGxEQVBnNENW?=
 =?utf-8?B?WXk5aVdkSmlQaXYrV1dzNXArS0dpak9TWEwvQjlEVytSUStzand5dC9uOWxy?=
 =?utf-8?B?d0F4eEJpTFNvQU8yeEFhYkhOSFV5Qy83Ry9qY2xsMFN3NC9mQVpIRDB6YTQx?=
 =?utf-8?B?cGVyMVNSNUlUZnB1Z2o2NW9sOHdYRWl5azdsTW5xcjcxWFB2VFM4SEN4YjVs?=
 =?utf-8?B?dWZFYnU2cUQ4d0oxc3ZhbGh6b2liQ1pjQUxxM3FlWXlwcXJqcFlwVDQ1N0cr?=
 =?utf-8?B?OVhjTmt2NzRrTVNTOFVCcUEzbEZ1d3ZaekxoSzExelhHUU1RYVF5bTVqWXFx?=
 =?utf-8?B?VmZ6V1VWeXdXcUNWdDQvOEdWbDdMMW4wemtJUUVaY1VVM0VLR2tzbUN0clc5?=
 =?utf-8?B?Q1QyTXk4SElqQ1l0a3M5K1lreVQwOTlSN29FTG8rWnpubkpGNzZCWlIwT2pT?=
 =?utf-8?B?VU9IVExKTCs0R0kvWFdxUkdRVmYyaElzVDhhU3hOTlIwUkR0R21UYWx0c3B5?=
 =?utf-8?B?SnMyTkVQY0hDamE0dHZqVkpERDhXKzg2R21WYUpMQW1RNDFxeDdOenJQRC8z?=
 =?utf-8?B?RGxkVkEyNVd1TlNtWU1MZEdKcnNNMzFiSW5ZUlUxeFQ2YkNuaXdldktHQmpN?=
 =?utf-8?B?MmtDZ3c5eHFSS0N6WGljcXI3U2ZJNUdSbDFHbFYwMVRudDJYMW51dTRBOUoy?=
 =?utf-8?B?eGIxa2I5ZVVmNkVCNm42RTF4RDE1cCtkcHVYMXh1RTVWZks3RFh6QlNoS25T?=
 =?utf-8?B?TmVJOGppcVZSSldzNGJyUE9wWXViUlpkQUlSUlJodThWTUF1N1hIK0ZQZHNS?=
 =?utf-8?B?UjJiaVZBeXFxc3UzOG5DaEdWVFJtVml5S2JJTWRYUytwZ3BUaHBUQ0lva1kx?=
 =?utf-8?B?WGJLZHdzYWx4OXpwcnBkdjl1Vk5WckFPa1V1Q2Mxc3d2cXpGVXl1NnE3cHk0?=
 =?utf-8?B?S1RzM3JiaDNnSWNuQUtDdkh5bDFBbTcwdE1mZmVqU2dkV3pYY2tVSXpmcjZw?=
 =?utf-8?B?TkFYNTR3bU9kd1FTUHpieUJiZTQ1SW5HZUdwNkFLVnBTRk92Tll0b0NJV1ll?=
 =?utf-8?B?RnlqWUJrVzZNdXFzQWVOMVVaaE5jMVN2WU4yRmYxSUZZem1TR3RzaE96OXFw?=
 =?utf-8?B?amlLaHE4MzJNY2xpY211dTBIbVV1bmVHcWY5ckVnOUZZd2RYQ2pydE5yc3Az?=
 =?utf-8?B?VG1UaWpLcXJUUExZRTYyY2hpN2JNUHJHbzJKek9xM0VkV2p3WjAwUFFLUkVr?=
 =?utf-8?B?eEw2TGhrUjdaVDNXOCt5S0M3eHRZVjhrUHZ5aEFCWitqM2k4bk9rNXlxNjl0?=
 =?utf-8?B?blFUUFAwZmcwMi9IcU0xUllFTEZBK2pDLzYzWjFrV1hQRFN2TnYzbEJsN2pR?=
 =?utf-8?B?TG9zRzAzUFNxWVprZFZicnlRSWFYZ2ZhVDRYY2owK0pzRllEM1lOcVF4NnQ2?=
 =?utf-8?B?TFh4dS9XeklPMXFmZ0I0bHE0OTdBQXZQK2Q2TDg5ZnRxcGdSdzQ4ejd2QTBo?=
 =?utf-8?B?by9NTy8xUXN4V3lKVGs3bU9nUmoxejdVUkZZOFlDUnRxL1h5aGltQVdrcyt1?=
 =?utf-8?B?YjVsQjNwVUViZHg5dlRBU251cTVXTWZIUWhDVXNoYVVqUWoyenBVQ29BWEhG?=
 =?utf-8?B?K1JoNlFNSzZWeFlQWFErQlQ5MlkyVkdVeHFkaGdER2xUditSSTRSNXV4NzZq?=
 =?utf-8?B?bm1wQU5BVVMyMlZ5WHJGQW5YdjBNMlh5MkhXaUlsY0V3L3hoNytzdlI3ZjFz?=
 =?utf-8?B?ak9jT05WcDFDV1o5eFVNUHVjY3RGV2NlRTQwSHJ1VUJmUDBPMDFaN0FPWlNZ?=
 =?utf-8?B?SUp3WFRhaFoyNlJWYlBHdkpTbnQ5OG5ScGZGRlpsandreTV3azZQOGsrS2p2?=
 =?utf-8?B?UVZxeVgxVUNlNGMyZG1USlpxMWtZbTBnZHZvZkpGRy9IdjlzODJWcVFveHV2?=
 =?utf-8?B?bktQLzl4R2ZjZmdGNDFpU01XOGZpL2ltTEZiMzJIVXF4UlYzc2FMOE43emhV?=
 =?utf-8?B?NXJLSUFQS2lxNTJJdWUvRkphWHpjeWhndDU1NFhMczdVbUZ1cWx6QnVCV1o5?=
 =?utf-8?B?Ly8rM0wvdElEdlRLam43SUg0Y0RYTGpTQXliSnl1UWk4MjNiWStuR21ET29N?=
 =?utf-8?B?enp0RTBScjhjSjFrMVB2UStuQVZCSk9FSTZFRGZFNERzc21ZOXI1cHZJeFFj?=
 =?utf-8?B?dHZQVUN5YmxKMmlXMzBBWUlpa2JVamxnU3RabXdkZ0hvY3U4alVpSkd5dWRn?=
 =?utf-8?B?UEtsQU9WT29DSEl2VEg5Yy9hN0VvdTdIdzFmNnl3clpXOUZiNWlGUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a74631cd-0cf5-4406-9bea-08de54417f1a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:22:21.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VfiCYevpDZP6OkC4WxtcQRVtRiABwqLul5dexHVBlCEOTV9kdEV6U6fVe715fw3T93+YYSFBILLGxatrkI7pcEKi8mJQtyTIhMABhZTvNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10146
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

Hi E,

On 1/15/26 1:07 AM, E Shattow wrote:
> Amend code documentation referring to udevice_ops for struct phy_ops
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
