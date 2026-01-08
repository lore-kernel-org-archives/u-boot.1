Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13E2D1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 15:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0534B84121;
	Thu,  8 Jan 2026 16:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZOrtcbSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F628412A; Thu,  8 Jan 2026 16:48:27 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C81B84119
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 16:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO2o6gTXm3UA/vV3WzEw0L4Fbq9x7ZJ9G1TjXHyV2Jg9yVLVcEmL9MOMQfR2jFtapPowb1WyO48tfM1TPb1AlHgj4OyyMuvKaoEJ5SxuSkyDLWG4RFr8PO8vFnskJ6J6IcYjI48tjEAGjX8H4TKJiUmRnn8w0befMoOEs9nPAlsQUmazsEQu0huhiAFgTMvTZQT14vZgP9ZgYwQXWMEYJLM23JRrkGSw4kAH4WcWeheotHrIb4UKZ1sGG+G5iYjl6x1bTx+3w0u23nynwzNVwlPKE2ETK/0DXPW7epkt/Rq/T9JHXaxy52L+hwV4mt3DL3kH/n+1rPaTOVQshURZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5BROzO9nW/LmhP2uHJyQl53bTHfEMDGKz2VangC0mA=;
 b=hR8DibHCuPs1gxIAVuT6o40yJqD3MJcSQ2LXOmfxi51UPtAcXzAgxyOp7h6liH/iVNTPswGcHaBVXhSNrwNmaVx10EjOHqToTv8WltLmlo71S/JLTEOnQJ+Rv3tfxq6W11dceUZVsBZIohfmIbC+Wxgk0LYxKgYZHJ3BxLwLHc0OIfaQ5iwSakytQ7LxV2jSGxsGIvm2h6RFYel/95M57KgDk3n+f/d+B2HpuSHdzKfDVB5Ew70fatgxksIul27nhvt7q87bbCCzm5q2DYsFdPnF4QxtLDuZrq8w7X0cyzvGs3jqUcaUWeqBwmIDqd/iI3/OMQn+LLak7Om0fIxdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5BROzO9nW/LmhP2uHJyQl53bTHfEMDGKz2VangC0mA=;
 b=ZOrtcbSEIhCNGEf3tlS/RuuicgUPjbRCRkeuFdPN6oif8Rhx0ExgBmjTwVpSoNv8OEwajyU3wkFEGAkyzN2mJlqZvNNbIFmLqTlLN3q5Nqyn+D7o10EJNxNY5rb+lUjcl5OjnlYc5iv53csIs0Qe1UKUY3jDwH5vmi7lRMr9STc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10642.eurprd04.prod.outlook.com (2603:10a6:800:27f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 15:48:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 15:48:18 +0000
Message-ID: <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
Date: Thu, 8 Jan 2026 16:47:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: unclear license identifiers
To: oliver Fendt <ofendt@googlemail.com>, u-boot@lists.denx.de
References: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
Content-Language: en-US
Cc: Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Alex Soo <yuklin.soo@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10642:EE_
X-MS-Office365-Filtering-Correlation-Id: fc21c97d-275a-4321-c35d-08de4ecd57c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elRQMUp4ZmR2emV4UTJhSjlzM2JFOUxidXhlUUdKdVh3bjdvMU9RTWJrNE14?=
 =?utf-8?B?R1VHaGVtdStRRFhvWFd0UkpnSjZmR0E2dGc2WUg2UXQxVlNweTVxbXlqMy9o?=
 =?utf-8?B?aGo5N21wK082UUlTQ1U1VC9XY0Zlb094bDRpdngzb3J4ZkpNVDh3c2RNbWd6?=
 =?utf-8?B?VmdOZDkyb0ZjQjZlUEl0Nm1ZZkZrOFNXamQ1SXhDUmlqUThqMHlXazZFZVFX?=
 =?utf-8?B?N0VMa2hRMVZ2REJ3NXhwNG5uZHBBblRoTkJodnl6T05LVEZtR3Y4NVpHVHRr?=
 =?utf-8?B?MVZIZDRVYjVjUG52TGpqT3I5bDdQUGRDQXcxbVhkOGZvZnFvMEhnTExhVjhV?=
 =?utf-8?B?enR5alppUm9UaDR5QWlVSndjZHlBYUs5TG5WL1hFN3lzUm1QM1AzWmlDMitV?=
 =?utf-8?B?cktVUGJJTjVZZ29nTytRbWZENWNBUkorTytpRGFqZDkxWlZ3bnVCOEgzandm?=
 =?utf-8?B?RUxUbEF3M3A3Qmd1QStzVXZWWGt0UjE5c1pscStucFZtSkEwR2ZrelZFZW5P?=
 =?utf-8?B?V0pVMWg1L2huRmQvemtUVTFIeXZFeDFHUmFIcnp3YjluVTZEVzR1Q1JMK25u?=
 =?utf-8?B?endJNU1VdzlJSDZLM0w5WGRSYVVLblpqeWVBMmdJWGUxVnN0eC80MDE2UldD?=
 =?utf-8?B?SmdGYVFDbWRmeU4wQTlGdmsyRjVOcXRLQU1GTENRVEFLUStrcERyYjJCcVgr?=
 =?utf-8?B?QkNZL3k5RXdzN0tIckhoc2NJV2NjbjU2MmVQaVBERFFGZ2FSZ2hFMlU0aEpK?=
 =?utf-8?B?Z0VOYlhBVlNra0FGTTBPZmhiR1pJTFRoL0NpdkRYTnMyN0k5YlpqczhZTmp3?=
 =?utf-8?B?a3VNV1lYeXExR3pVMzk2Uzh3d0x3NWVVd0xBVUFXMDZwY1VqYTFxYmtFUEMy?=
 =?utf-8?B?ay9reUNSZHV1bm1PVk5MYWltN0tIbTd5MTNndjRQd3N2Um8yRWVlYldqaDU2?=
 =?utf-8?B?UlZXbmtKRHdkMVRKQ2JDU2o1WnVidG94K2FjTDcySXVOR1M4NXpocFJ0SFM2?=
 =?utf-8?B?Z1E0TmVxeTgwVHdPcGYvZEJYTzVOcnNhclF1UWNYZ0w0Z3dXY1VrYXlLNXNo?=
 =?utf-8?B?VklHeWxYK0c3YWJISmtBVlBIdjhEdDEybWFpMjBlaFpIRVFTRzRTZDdIMHNt?=
 =?utf-8?B?V3BmanluRDdtcTFYRWF5UE90anFEdGhSY3lqSmI2Tk9lVExDa0FmRE95dDNj?=
 =?utf-8?B?UnVDQlRyTVhCV1UweUpsOHMwdzl2cDZUYnBJS1FvOU1BcXhYd1VkMUxSVksv?=
 =?utf-8?B?YUp0TnZTMnBFd3ZUTHBmck56VUsrdVRGdEpCdkxNRVYyY1RKRURsby9EeFFj?=
 =?utf-8?B?S0JsUHk3UWNjRVQzOTNMNWViTFZud21HcVJyU0FzL3JlbzZQOHl4YnRlRzlu?=
 =?utf-8?B?c09nc2FlRkJLM1lQWGRRNTI5QjRyVmptRTNaRFk3UjFZeEFXYVY5N2F2dHVs?=
 =?utf-8?B?R3N3R1VNVElRM1dNanV6aTNuQU1hb1V2azFoYXpTSVJpTXVxN1YrR0gvbjBX?=
 =?utf-8?B?RXBNSUZPelk5eXUxSmhTSS85U1EwOHNqOEh2NGMzR2YxOU9rOHgrTmVCLzZB?=
 =?utf-8?B?WFhwMnJOd29WeXdqT2JTNEJJM1QxMEdVcjNSY3pURVU0UERSajRyaXhmL1Bt?=
 =?utf-8?B?L3Q1VEJXdGdzUHJnOGNHeW16U1RlWVg0SEVjdFg1ZzlqT0Nhb1BnekJ4RHRz?=
 =?utf-8?B?VFF1Q1ZTcHVwSTUwbEZVd0pzVm1ITkFDajdrMzRLT01QbHFIdzN1SVZaeE1R?=
 =?utf-8?B?N2V6MUViTlN1bVBWZk1lT0Z4ZmEyWjQ4c0NPeEVSNkdtaWxvUmdrcGFhM1FP?=
 =?utf-8?B?ZlUwQkFKVDJPU1FoalBBUUg3cWwzS1hMdG8xVEFBbDJ6cDRlT0xOSWtxVU9s?=
 =?utf-8?B?Vzl1NDQ4ckg5QndFZHU4OW1GU0ZsQm5xb01uL003SVhVN1phYWNESWhadUs2?=
 =?utf-8?Q?+VdV/OHfK1uz2M/Krl9f1u4dFyO4IOoI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDlEc3BzSlh6amdoTlRmNFpBZXk4WTBXdE8yeDJsdlQzUkQwMm5RblJJdWF3?=
 =?utf-8?B?RmRxWDZVaVJVV1Z6dTc3ZXA4ZDB0WVhIY1JDMC95UWNtYVozV0ViUWkxeWFo?=
 =?utf-8?B?STFoeURuem55bVVxNzNZR0Z2UGdKdGVkd3kzeVhhNVZYZ0NIclVVUTJsV3JX?=
 =?utf-8?B?MXVreklzSDlWQ2RwOXZnKzZnbXBUSUxPRFdrMWZaZzFHR0o5UktMb3ZVWG94?=
 =?utf-8?B?a0s3Ykh5NlZsRTdOQzBsTjBmRWY5SnZ3eGZWNlg3OTY2d0VIbTBMaFZIRmdR?=
 =?utf-8?B?V29abVdRbVdHdlo5SEpZNldROVJKdTBUK1Mxa1VYbWR6b2VjdG9TdkQ0R0NK?=
 =?utf-8?B?U0ljbGk5QVN2dTFjUVhuaysvbklZQ01wNnFPSnpJQnViczBnSHp2L2ppQitZ?=
 =?utf-8?B?ZDZiSFAxeHRud3J4SlQ2c0hIcWRLV3A3aVVHZUZEd2wwaXJGTmlhTmVzMTJh?=
 =?utf-8?B?TTk5am44M2J4aVBPSU9LYjQ2NENYZUhhMjk3MEZNSnFwTzVkb1hhaE9oS2E1?=
 =?utf-8?B?eTdPakhXOVVFZndIUitMc1daN1BUa0tDTjgvU1h4T0xZb0ZhYjBkTU5VRDBX?=
 =?utf-8?B?WUg5NEZIUnhWbVBpWGlrcVNuM2ZwOUp3UTh5Q1gxUHVYenU0MXI2Wng2dGxt?=
 =?utf-8?B?bmxEWFdiNUx4REhWUXBGaTlQWm5PelA4RWxEbFJGWVJsSFFBcUFBWHJNSFdK?=
 =?utf-8?B?L0U2VDFjelVEQ2tySzQwN1hYSHYybmZtcDhTdFpIVk9Oa05yNHVRUFQ2cHBo?=
 =?utf-8?B?TGJSSzVLNXhZaEhyUlZ5Q3NQVzFQTlF0SW1WdkJVODljVDNySEs2RUM3YlFr?=
 =?utf-8?B?YWxieTQwd1FxdS9EeFdEaFgrWEhVbWV3aDVrK2t4YWJpYkdaV2hKZHYrRnVW?=
 =?utf-8?B?ekQxNk5BaFczM0pxRkRBRmd3M3hsZmJhblUzU1paZUFnU1FReENvejJRS05Z?=
 =?utf-8?B?S0pqZDFwckdEQy9zb2tmZFg1NXcySWFtZW9aRTBPSnlEOXhMREthOVFwWUZH?=
 =?utf-8?B?VEVrcWZaV3B5cW5FUjdwUk5YMDJjSkpoL1BwTjhVYVBjYWdSNC9XWUJuVGdy?=
 =?utf-8?B?YnVvN1Z6RUNDejIrUUNVdW9qS3dWRWZkUEJaYjhSYmtTcnpyYy9zWU04a0RV?=
 =?utf-8?B?ZVJXOTFWQnMzQkhtbEFWV2NrNFZidGFMUVhDOTBSdG5WcDdUcDVEUkhPdmZR?=
 =?utf-8?B?OHZxL0pMMzVDeVgyZnkxRWt1K28zdVdGc1VvblBZTnRXSFMrb2RSV2srd3Ax?=
 =?utf-8?B?Q056Y2FWcnlEei9yV0cyRUlOd2c2UkJZdllHOXp0NWFMdlZCSFM3VXJIZVND?=
 =?utf-8?B?UHhLaXdxanEvSDBuR1hobVlGZ1EzdXBNaW5DU2w0elJKWGNld2R1TGVKbzQ3?=
 =?utf-8?B?cHhzVVBWQ0dYYmNkckp5U1JjOGszSkpmWXhxdVBGa1hrN3d1VEZNbXRzbDNJ?=
 =?utf-8?B?a2k4aWRJU0VXbEZPOWpvRkozaGo4VGx2NDhzOEJmK2JHSlpSTFVZek9pL1BV?=
 =?utf-8?B?ekpTdTVtU1N6bnFkWVRvUmRJb0xhV1ZvU3FWWVJpcnZDVWdMaVBkcHFjSFRJ?=
 =?utf-8?B?dFlGWW5FUmZBNE9KY1FJZDNZb1Mxb0NOQUJvdVVXYlJtUm9ZUDRKOWdRNWdL?=
 =?utf-8?B?bVovRHExekp3czBzc2hEdWZFa0E2WnpWOFlyQXBNNzhRaGdsa1IyR2pkQTdJ?=
 =?utf-8?B?QnpGVjY1NklKWTdmWlB2UFpENThjU05tUDVyRkhleHAzdHJXeklKWDhCdHVX?=
 =?utf-8?B?Y0ZMZFRqVHBpZnMyTmlRT2pmVFFib0pJZ2dRRS9PbnVXSzBWanFDakI3Y0Yy?=
 =?utf-8?B?STlNRDErYXZnRlZueHltNEF4YlM1amRYU3J3U0VydEFJVEJVTHBMSXBWS3NG?=
 =?utf-8?B?SmgrTm8zMlp0TWhZY1pjUENjd3FaOFR0YmUydktlK1hOVkR5MWFVTmxBektq?=
 =?utf-8?B?dSs3ZmZKbndWNGpwYzlwNmhGMGlQbTYwSWFxK0sxWjZ0eXBNRGdDRWJRTkJM?=
 =?utf-8?B?UGIzZmsreWxldkhPdnpOT0VxZHhGUEJQYUhtL0wwdWNxa1FyVUtDN21aU0pC?=
 =?utf-8?B?L2dOcjNOcUdyNkd5bm9sWjBYQ1dkWjRVVzMwU2R5SmF3bmtQTUJIL2xIbFNi?=
 =?utf-8?B?SWlsKytsR2pDWk5KWU9WSk5OVUQ1UTVPbEViU0dOMnlHSzZSUUN5WlhPTVpI?=
 =?utf-8?B?UVhLYUlLcWZTNEo3RnJKMUI2cmRQejk3MEt2c056dk1aMFFEdTlBN2lyMjhr?=
 =?utf-8?B?eCtWYmErZmJtRUpKRVM0SWozMUQwMEx0eVNVd3p3MmdYbU85c0NZKzNqdks1?=
 =?utf-8?B?dVA1ZWdXUnJYNW1KOWpXQmQ3OTlsY2xoSXI5S2JwUnQ1SEgwc2pGZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fc21c97d-275a-4321-c35d-08de4ecd57c4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:48:18.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RcRC/CrOFSMOfbFrATM5ODPF9b2BnYdEoG/CTU2pKzXTlZ3OfBYp3X5TlFCuVlyKYJ1aMF37FMani4hLloRO53/CeRs62Jrn9XH+1vKPvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10642
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

Hi Oliver,

On 12/19/25 4:51 PM, oliver Fendt wrote:
> [You don't often get email from ofendt@googlemail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi all,
> 
> I recently did a license analysis of u-boot an I came across some
> unclear license information in files. I do not know whether this is
> the right place to put my points, nevertheless I want to share my
> findings.
> 1. the file https://github.com/u-boot/u-boot/blob/master/drivers/mmc/sdhci-cadence6.c
> contains the following information SPDX-License-Identifier:
> GPL-2.0-or-platform_driver which is not a valid license identifier, I
> think GPL-2.0-or-later is meant here.
> 

+Cc @Kuan Lim Lee, @Alex Soo, @Wei Liang Lim who contributed the driver, 
they should be able to answer what the intended license was (I assume 
the same as you).

> 2. the file https://github.com/u-boot/u-boot/blob/master/dts/upstream/src/arm64/arm/juno-clocks.dtsi
> contains the following information "This file is licensed under a dual
> GPLv2 or BSD license." the BSD license term is vague is it
> BSD-3-Clause or BSD-2-Clause or 0BSD or...
> 

We get this file from the Linux kernel, so report that there. This file 
is more than a decade old, but arm is still active in the community so 
you should be able to find someone to answer this question.

See: 
https://elixir.bootlin.com/linux/v6.18.3/source/arch/arm64/boot/dts/arm/juno-clocks.dtsi
We do NOT modify any file in dts/ folder in U-Boot. It's imported 
(merged) from 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/ 
which is generated from the Linux kernel tree from Torvalds.

> 3. the file https://github.com/u-boot/u-boot/blob/master/lib/zstd/common/cpu.h
> an others contain the following text:
>   * Copyright (c) Facebook, Inc.
>   * All rights reserved.
>   *
>   * This source code is licensed under both the BSD-style license (found in the
>   * LICENSE file in the root directory of this source tree) and the GPLv2 (found
>   * in the COPYING file in the root directory of this source tree).
>   * You may select, at your option, one of the above-listed licenses.
> 
> when looking up the zstd repo on GitHub there is the same file

Be careful when doing those cross-checks. We import a specific version 
of files, so you need to check at that specific time in the repo history 
what the license was.

> https://github.com/facebook/zstd/blob/dev/lib/common/cpu.h with the
> same license information. The root directory contains a COPYING file
> and a LICENSE file (both are not present in u-boot) the COPYING file
> contains the text of the GPL-2.0 and the LICENSE file contains the
> following text:
> Redistribution and use in source and binary forms, with or without modification,
> are permitted provided that the following conditions are met:
> 
>   * Redistributions of source code must retain the above copyright notice, this
>     list of conditions and the following disclaimer.
> 
>   * Redistributions in binary form must reproduce the above copyright notice,
>     this list of conditions and the following disclaimer in the documentation
>     and/or other materials provided with the distribution.
> 
>   * Neither the name Facebook, nor Meta, nor the names of its contributors may
>     be used to endorse or promote products derived from this software without
>     specific prior written permission.
> 
> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
> ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
> ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> 
> Which is an individualized BSD-3-Clause license. Since the
> BSD-3-Clause license is very clear in the wording " must reproduce the
> above copyright notice, this list of conditions and the following
> disclaimer in the documentation" the exact original license text of
> the BSD-3-Clause license from Meta must be reproduced. Furthermore the

IANAL, so don't know if we *really* need to have this customized BSD 
license text in our tree or if a generic BSD license text + the 
appropriate copyright notice in each imported file would be enough. The 
copyright seems to be the same in lib/zstd/decompress_sources.h in 
U-Boot and LICENSE in the zstd repo, so that could be covered this way.

> GPL-2.0 is acc. to the text GPL-2.0-only and not GPL-2.0-or-later like
> it is mentioned in
> https://github.com/u-boot/u-boot/blob/master/lib/zstd/decompress_sources.h:
> /* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
> /*
>   * Copyright (c) Facebook, Inc.
>   * All rights reserved.
>   *
>   * This source code is licensed under both the BSD-style license (found in the
>   * LICENSE file in the root directory of this source tree) and the GPLv2 (found
>   * in the COPYING file in the root directory of this source tree).
>   * You may select, at your option, one of the above-listed licenses.
> 

https://github.com/facebook/zstd/blob/v1.5.7/contrib/linux-kernel/decompress_sources.h. 
It's specified as later in the SPDX-License-Identifier.

Bring this to Facebook if you're unhappy about it, but that's nothing 
we'll do on our side.

Cheers,
Quentin
