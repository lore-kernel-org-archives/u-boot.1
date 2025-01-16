Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0775C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4828022B;
	Thu, 16 Jan 2025 12:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TdHnWSWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFE88033D; Thu, 16 Jan 2025 12:21:22 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8942780214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K67JYfI9bmeB2VdBWYtsqgm6qXcqowzF0Dcer23T9i6A+D2ajedkfSexGHHDiDzvr+vOpbkVT/nbGHjWwpWpjh86XgvMqBKkFMxDEcTQtoULUWgIexiBjxVLBNqkzhf2fGiIFtr8BWoRWUJ6fmQqovuwVvmjgPln+N38IZBzE+S5M3mjSk4Y/wq9VawlNYDQXNLFvMEhfbe+eOVq+/olh8qkCINSx5m2qkdac4Jeu6e439qd+V3iDDq10N0gwjUg6ikdp/XbyhPmm6LpklDv8py4YyE4NE97WxbHPlrlcV4ym5hd1tf6kktUJXe5Z6zZJYD6waf0BzgUOK7j4ixvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGL6aIOkZJK1wkVHLiDxl+5/C02ik+Vr3i/h3WVDTfY=;
 b=GTnq/DieXD+wEBCRHgG5AU/WwZv3ImVN+OtpnlYHIdgA3Z7LAeulhuExNBQkXBPnBnuFU8ZZK1plR2krpstgtXPRGq2Nvpf5kawKGGU9hZWa7WnJZe/xX++o7opKHoB41Jk+jXwoxq4njBCNPTiQLSJBuptWSAZWV2Q5+Egk3h91rEAuNyZFgRyRnQnpI4kWktDu/swZGGbVd3Cn24Z9pIaOI9lYhXH8qMhs9rUW9RXalNbQtZrw3yBuDh3v1wqHDC1oZCugpApvt4jDSpBAYjsQajZpEd5Q40pEpeONvslx3Z9gl9St0dtMHJUcWlqGuwfWtkPIS7m9Tw4QpSYQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGL6aIOkZJK1wkVHLiDxl+5/C02ik+Vr3i/h3WVDTfY=;
 b=TdHnWSWxTK43xc8fOG5y52zMKREmH32FqQT6BGejHC93iG72o6Mp4Pxwg6wTvogojx/+G2ZRxzm3pXmlytdZv4IOmaTtzhB1+TFgceZxFU+erhTM04klU1sXlqmkxx6YQLihr9Sj3TdSf6f1LXUwHO/7clon7Xl+FXSxuXFT8ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS2PR08MB8453.eurprd08.prod.outlook.com (2603:10a6:20b:559::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 11:20:49 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 11:20:48 +0000
Message-ID: <acbadc6f-9e1d-47e6-b3de-d7bf47a4e14d@arm.com>
Date: Thu, 16 Jan 2025 11:20:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] board: vexpress64: default to hardware device tree
To: Simon Glass <sjg@chromium.org>
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-3-harrison.mutai@arm.com>
 <CAFLszTjS2mY1FrWM9dLAwOZ1soiOBP6GgMOYWwYQP6XPw9L9EA@mail.gmail.com>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <CAFLszTjS2mY1FrWM9dLAwOZ1soiOBP6GgMOYWwYQP6XPw9L9EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0125.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::22) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS2PR08MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bdfd6e-6bc1-452f-a8cf-08dd361fd41c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXRjbGI2UC8vb2tuOUwvcDA4TE5SaXdmS0ExYXNkVWxWZ3R3OXRVdnJmaTJ1?=
 =?utf-8?B?ZjNjdjBWbXJuUXpGWk1CSmhxejY1TEdaVEg5ZmlKa3p6N2tTR1VoU01VQTJo?=
 =?utf-8?B?dFlaaHMyQzhaTFVINFNzb0J3YVNKNC9mN1FRRlJEenMvWHpKNFRUMkFaeERs?=
 =?utf-8?B?SE1TOU1IbVpncFpPZXFCa3puQTQvUDUyZ2ZkMDM5R0NKSUR1NklnKzdjOS8y?=
 =?utf-8?B?Kzd2NWxwNVpTWXVER1Nqd28yUlQ1dmlmbTRuWlNWbGNDRFluQTJveUozSUxx?=
 =?utf-8?B?WlAyaVNFdDdXd3RWZ29GWXFEblB1eG0xRGRrUFJuV2ovL0ZxMG05a0JMR1Fl?=
 =?utf-8?B?MXlnWFdoYzRQRWVLK1RZdExtT0RSNFFLOFRBelRrZDI2SWlYR2FZM21mYlNU?=
 =?utf-8?B?ZjliK3JTOE45V3MrWFFXS3dMU0dBTmZDZ3ZuWTRoSUVTL1o4YnhrQzk5UCtW?=
 =?utf-8?B?b2dIZktwS25sT2dmaExEY1ZWczg3akNxbWJJZ1JZWFZoaEtud0haY1FNOGN2?=
 =?utf-8?B?UmUzTzJGN2xYS3d1Yjg0cFNrZDN3RHljeFZNbGNMajFVdjFrTzVldjdVYUVG?=
 =?utf-8?B?dzh6K1NZM0NjMnUrQTE5SUUyMU1Yb3VFSVd4SjBLUjVkS1poVGtCSE9idzFB?=
 =?utf-8?B?eGw2Z21waDZ5bi95MVNpMExqQ3ZKcTRQUG5hMjJNckdrc3NwakJaU0Y3cEt1?=
 =?utf-8?B?V1RnUEhEWEptSVg1aHFvL1pVWjNPV2JXNnUzcHhsWU9tNG85bFpaNFp6d3Vx?=
 =?utf-8?B?NEpvam83MVJaUU1QWGtwOGNNbkFZeG4wZWpkV3Rwak9uQytMUWNZbDdLQzYr?=
 =?utf-8?B?dFo2Tkw5MHc0Qm8xdzFGUTVBd1JoaTFuOFFTTEU0S3A0YS93YW15bVdvNEox?=
 =?utf-8?B?SXZFa2tVUGJxWml4Mk85ZEsyMDEwQVg4bW5mYUV0S3RLNlUxSGM0Q09ic3NH?=
 =?utf-8?B?Q1o3a1oyaUE0UG01Umx3cGVTdnRyeE9mNTk2MXB4TTBWV0Z1a3NSS3p0VWJp?=
 =?utf-8?B?dXZJTUwyeHNWcitNT2x0WXNwdjA0enpBZWM0bytBYTgvWEtqVU9QekxFVU1F?=
 =?utf-8?B?OE1mSVNuUFpHRHE2bW9kUU80V2Vacy9qQU92dEJTOXd6NmY3NnNybVd1c3lw?=
 =?utf-8?B?MTY5Z28zdXlRM2s0cG1MVVNLT2p1ZnZHRGNrM1ZIYVRCRDJmckFFQlBCOUpk?=
 =?utf-8?B?SC8rekE0RU9YVDVqR3BOajMwaGpXYUlMYjZaSnNNMnp0Q1AyZGVTdmdjWnda?=
 =?utf-8?B?UXFrWEFDNFB6REYzdXVaRnRRRGRMZ1IydGEvbTNCMkFUWkh2bTZDTGQwT1Jo?=
 =?utf-8?B?QlYvblRjaEhPNkJzV09wQXhsd1R3ZE9XNzBBdjdJTDZuYmtNcldzeENwb3dC?=
 =?utf-8?B?Zk5TeFMzcDRwUm83WENCOWRKYXhQR2ZpMzNPYWRpUlVMcjE2NDFLMmE2NThl?=
 =?utf-8?B?YTg4Z1h4eDFvR21kRzdqb2pna3pDZHNpZHc0SUlNVFZGYXBVWlpoY3pWa1Np?=
 =?utf-8?B?SzdzVk9IYlBzeFdIZW5zOVo4ekFGM3h3VExNc1htOGhyQzdOQnJFeTRtV1FC?=
 =?utf-8?B?SHNNNWkwUm9xZE1INHd2YjBUQnpzcFoxS3h6MFFtdkE4QnZEREJKamRJWDVw?=
 =?utf-8?B?NmhOREFja2xDOFo5ZVkxLzBOT0JMZUQyeXZuVTE4QVVPa24yNGtLejBPVDZL?=
 =?utf-8?B?MTFjMS8xRkhWNVZ1Qk5oMDZHZHpPLzBodFhkUS95M0JRZlRFak5DTmtjMkJh?=
 =?utf-8?B?ZEFNb0lNSDR0L0pkMUlMbkdOL0lHdmIzeVU4ZUFvMHNNWDc2YldKbFk0c3Ju?=
 =?utf-8?B?R2NIVFNsSHNuVE1HekdYQmhKdVFNYXZNQUs5N3RpWWs5cTNvMkJkQWpNa0pJ?=
 =?utf-8?Q?RRacZ8wi88jMk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JxZGJKRnM5VjJrLzRkZWM2T3NTbm1Lem1aUnBIRVhLMUdyWTh1dmIrRExl?=
 =?utf-8?B?OXpKUHNJaHFHKzhsVkE2Q1dDVlRDaStuVXZ5VHVkUVhJZXhrMFlXZ3V3VjRQ?=
 =?utf-8?B?MWtxL0NscUlqRDJERlFUd0xHem1DTVVwM3BkTjQvQnlSK1dCQTZQaDVBaUFs?=
 =?utf-8?B?TTNlb1JHMGdPb0pBTEFkakZTanEwa2xaUUtKTW53eW4rcmxCckMxRW1oUXBD?=
 =?utf-8?B?R1pvOWFTRXQrdURmQnA1WndmRlVaeHErUVpTdmVWK2tUWndUTVZwV0Jwbk9z?=
 =?utf-8?B?a0oraHdEUndLbktQbm55d1k0WG1DZTF1VTd4Zmx1Ky84TUtxbldtOTB3d1Ju?=
 =?utf-8?B?OU1ueXNOOGdoWmxTbk52QkljOUxjVEdndjkzKzR4NkNNYW4vSVVvMXBwRDFs?=
 =?utf-8?B?NmtYekk5UUJ5Zzl5dGRHblBpcmtOaE95TTJob2hEaU5aWDVZK0dDbzJmOXNB?=
 =?utf-8?B?S3lZNTU0RkVNUkZ0VkNtc1ZYRVBBeno4S3E2Z1VZazlWWjZMMStzd1FPU2Mz?=
 =?utf-8?B?YjQvaDNyU0FDeFdKSkRFSFhhZDFGWFl6UmZicjFPbEVoQ09nYTF6V2t2aGhw?=
 =?utf-8?B?TXljOFNZOVZJSW5BWGRPeGsxYWNzT0lWcThuVFV4eU85TUxpVjgxNktFRDA1?=
 =?utf-8?B?TEdlZWdzRWxwakZzdi9TN3J4cFRDcVBlRzd5Qm9hUko0MEZrRTRHd2FxK21V?=
 =?utf-8?B?N3RhY01oVWtndVJNeENLcDdMRzhBWENFUG5neWN2RVhGYUdJRmJaV0lKZWx2?=
 =?utf-8?B?bjNEUlZpQm9uVmU3VDB6TUFLWXY1VGpvckZSQ3NJL1hpMW1mSmtyaXJOMjJR?=
 =?utf-8?B?NHBQWDhQbXZjcnVSZGVCTkxQKzltUnNBbW9hMzRRS2NMemZRMzE0dUVmdXFE?=
 =?utf-8?B?YjFpKzZTOEYxeEtCR3gzZVljK0haTTRoRUVoSUwzYXBUYlF4QzlyeVVJc0ph?=
 =?utf-8?B?VGx2TjY4R2FOSURPbEsvekFUeXFEQzFIS2VpaEpianpmY3AxekdmM0FJR1Zn?=
 =?utf-8?B?bUFPdHh6TTJmV2NBa3Z2NmYxUWdBc3Y0NGRiRnFCNm5vTW1sY1VkYnJwVFVn?=
 =?utf-8?B?eW15Q0lGTE9wcG1pcloxakQreU5iZ2x3bjN5L3NoalZaRlRWY2lJSy9NTyt0?=
 =?utf-8?B?ckRJdGpMZ29oVmtHcCt0WlJLQ1lRVHNsMldleUpUeDdOTUtPdVd5d0tpWWVh?=
 =?utf-8?B?WUZRWnM5ZXh5Z1NlYlYzOGlCcHh3dVFMNStXZEtQcVczcjJ1Z3ZtV1NMMWls?=
 =?utf-8?B?c3pqY2xGdm5hWllGejNWK1dkNS9odW8vcjVXYU0xL0NEOTI5TmJyT3cvK2FC?=
 =?utf-8?B?MVQ0SlpZdmtOOHo4Q1ZlWEZBVWIyTUttdmVXcFRrUWN6RkpyS3RLWHJweDY5?=
 =?utf-8?B?ZlJ3RjZRSWRNYkxwenB6V2xzTmowb2QwbkVLTFRVR3g0Y29YMG9HSm5ySHlN?=
 =?utf-8?B?TUswLzBaS3YxS0VpMXBmMEpnRTZZd0xhNlhYNXoyS1cxZ0ttcTJ3ZHFSeUZm?=
 =?utf-8?B?alpSNy9mL1VlU01yWVBadmJHTTFoR2ovUWYzYXNTR1dSZVd5aGJWQmF5Q3U4?=
 =?utf-8?B?U3RrM21xaVdkUUZJdXJlb09SMkE1MnVMeVI0NW8xa2dyVkNOZlZSbjhVZ0dp?=
 =?utf-8?B?d2RiY3FXU1cvYmR6VVRENTEyMnMvZVJDcitxMzhadnJUV0ZUb285SHc0eFFW?=
 =?utf-8?B?RXpWVnJTRGh5bVFERTJ3Tlp5bWtWL0FHMHVGY01DZUU0UmkxV2QxRjR1NDJ2?=
 =?utf-8?B?SmNieWUyOHZsb2w2cElUcCtTd050c3JKak5HVDRMNWpIVFBXODZ4MVJERHFq?=
 =?utf-8?B?NnBqRGxqd053Q09DSDhXRVNSaFNyYjNXS212dWdwTndtVVJmdHMvREpIYXQz?=
 =?utf-8?B?Uk9VMmRQc0E4NDZzS3hGSFRsVUdXQ3FmNUs3a1VNUkpxUStmRnBBZmtwQnM2?=
 =?utf-8?B?eWZhZnRKWFFRaVZKQm9GbnZJUTY3L1pDbDU3TjZwZWxvTzhPQUZ6elc0ajlw?=
 =?utf-8?B?WVJvWkFtYnJ2WnAvZ3lteDhJWG5peVFYQ2lRZmRML1p4K2tCSWxhNEhjczFB?=
 =?utf-8?B?eHFvcFZGcVdyS04rdTR4ZEFYQVZ6NFQ1YlNONW5CUVFhWk0raFdYL3grMVlV?=
 =?utf-8?B?ZjJaYWREaGFMckQzNDFUWlorOEcyNDhTelA0MTVpc1VSU3JRZUdZSnkvNWR3?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bdfd6e-6bc1-452f-a8cf-08dd361fd41c
X-MS-Exchange-CrossTenant-AuthSource: DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:20:48.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yWJ1cyTzjNqfmUB1p2H3Ipir8mesT+jEc9oHw0LqtHTLJYC3bE1kGvEne1cBsWlnzkerDBiXuOSdXJ/lqvtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8453
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

On 16/01/2025 01:26, Simon Glass wrote:
> Hi Harrison,
> 
> On Wed, 15 Jan 2025 at 06:52, Harrison Mutai <harrison.mutai@arm.com> wrote:
>>
>> When booting into the Linux kernel with semi-hosting, use the device
>> tree provided by hardware unless one is provided in the current
>> directory.
>>
>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>> ---
>>   include/configs/vexpress_aemv8.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
> 
> Thinking about standard boot, could we add a bootdev for hostfs? Then
> we could drop these scripts.
> 
I have a patch in progress to migrate vexpress64 to standard boot that 
tries to do this. However, it's not quite ready for upstreaming. For 
one, there's other boot targets in this file that would need similar 
treatment (e.g., AFS, MEM). Would it be possible to transition these in 
a piece-wise manner?
>> diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
>> index 8020689e39..2341b3a938 100644
>> --- a/include/configs/vexpress_aemv8.h
>> +++ b/include/configs/vexpress_aemv8.h
>> @@ -169,12 +169,14 @@
>>                  "  if load hostfs - ${kernel_addr_r} ${kernel_name}; then"      \
>>                  "    setenv fdt_high 0xffffffffffffffff;"               \
>>                  "    setenv initrd_high 0xffffffffffffffff;"            \
>> -               "    load hostfs - ${fdt_addr_r} ${fdtfile};"                   \
>> +               "    if test -n load hostfs - ${fdt_addr_r} ${fdtfile}; then"                   \
>> +               "        fdt move $fdtcontroladdr $fdt_addr_r;"                 \
>> +               "    fi;"                       \
>>                  "    load hostfs - ${ramdisk_addr_r} ${ramdisk_name};" \
>>                  "    fdt addr ${fdt_addr_r};"                           \
>>                  "    fdt resize;"                                       \
>>                  "    fdt chosen ${ramdisk_addr_r} ${filesize};" \
>> -               "    booti $kernel_addr_r - $fdt_addr_r;"               \
>> +               "    booti $kernel_addr_r - ${fdt_addr_r};"             \
>>                  "  fi;"                                                 \
>>                  "fi\0"
>>   #define BOOTENV_DEV_NAME_SMH(devtypeu, devtypel, instance) "smh "
>> --
>> 2.46.2
>>
> 
> Regards,
> Simon
All the best,
Harrison

