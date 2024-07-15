Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B5BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F47B8881C;
	Mon, 15 Jul 2024 16:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d6dw81rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B04888B0; Mon, 15 Jul 2024 16:14:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA14E88765
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhP9ukKsUwVkwJn+F3BN2EQft/tmXgd3p6KFDuPMdWBH31UrJB+67Jmnk746NRNllptkuAFl3NSSWt1btVDNpKYnqDHS+WtKZfZz6hOyP9RUTtiS82jda9gFb5k7GQb/YbOckc/zXIQjwCJykk0hpuJHvg4VfMYgPoIvDVXYPDcM8joLSpbSbkJxkbovf1ke9h+Or701RaIsYS1TkmsbPI8kuBniTOoMagReDMHYqPqNXgCsMcdCrs2kiqr9CY2Z5TxF34SIfdMs46fseV9xxHUSq7bwIXw2lzJl9/KLgzBvws1p6U+J4qMqzq/c5WIHCUemtSjDjtlReNeQXbNqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eQ3LUp4ildP07JTg4jsfTt09dU8VInSCE2RX+9c5k4=;
 b=VQdYSiqZedhSPnz9PAvadoZLrGQ1g2qkrWXA9GxJUWlyNwLXoU4oWuyCN5fo72WB5z9fxxQsMpI5cv9TEsJ9buy6TdXIEir1zr8XMD0MRSdA5NHdsohtT+0+Sn/dQp8JctK9GOeDaTx1T4mYZkP8lbY1eIcnuTgg4g4LuR6qrrma7OSpJgXc1z5OIDpNW+zF3kizzQXqmP8SIuYtZdSJ+hAnNDG6bBsAenBkBPa4V+GB0iF3EuS2ZDkcituIjeG1Ybe8klsS/DkkMliihViw+v9b/jvfSAAj4sjHRjB28qoMj4UF0ZX7EUJKseXf05agkcC7URYIcbivrjrp7XjhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eQ3LUp4ildP07JTg4jsfTt09dU8VInSCE2RX+9c5k4=;
 b=d6dw81rLAeN8g4O+nKjbDAHCZf97CcqFUkets1aRVjWmVCQIWwBcoo6UuLkynQOaaHEb9EQYSHe1puK4X5FDbeEa4Pafal/8c4WFOHi14281e/RRCq47bDpt0PBJvEdGT/jik62tWDhbCG+ERMyD0yDRas/j43u/avqrlxP+0dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6938.eurprd04.prod.outlook.com (2603:10a6:10:117::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:14:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:14:53 +0000
Message-ID: <e591f5b3-ec7e-429e-8810-7f53535d71df@cherry.de>
Date: Mon, 15 Jul 2024 16:14:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] boot: Correct indentation in efi bootmeth
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-13-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb04133-c2ee-49b6-cad8-08dca4d87f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUlhNEZEdnAyb25SQmV2RFdmRStrbWR0cVMzUTNkQkU3N01oWnhZa1ZiaVFQ?=
 =?utf-8?B?dHoxYkZBRDhXVkZVa25lRFJVbmdFYks0TmVIOXIzZjhKekFFdFFPZU9QRnR0?=
 =?utf-8?B?TkY1TC8vbDdCQjJFTjlaRHIwd2VOZHVTdmV2ZnAvZ2VaZWUveGhDOXdNOGRW?=
 =?utf-8?B?eGlUOU9vSVVDZDFCT2poUG0rLzdWa1RLSFg0YW42YXNaa1JuSitjY2JCYUlJ?=
 =?utf-8?B?bkdLd1R2bXlSdHd1VDVDYkIrUlo0VDhwUW5PaDRMNUdSVHllQmJ2NXBOSk9j?=
 =?utf-8?B?VmVKc2t1T0xFS1ljUG1NM1M4V3JBVkYzbVZFTlJDaWFQSEFCYXdMWUtjV2dU?=
 =?utf-8?B?MHVWODJUYWhRbTRXRVM0M1QrTTZ4SFlOU3BFdVcwRFlDd3FiczQ4dXpaSi9k?=
 =?utf-8?B?OVZIZHJsTGsrbyszL0VxQm83UUZsSWZaV2xEOGdFSE0zdXBDSEw3V3JWRzFK?=
 =?utf-8?B?K0ZhQzJXYkJxQlVjRHI4ekRlc0tKNWZ2KzhYcGhVbjBVQW5aQ09welhHY21m?=
 =?utf-8?B?RHdNNWc5Q2kvWUJwTXJPZzVWT1ovcDdKcnA5YjBrVndjaFcrMkpXYVpWMnRk?=
 =?utf-8?B?dWpJODFITHUyT1doQW9pWTBkdzJsUjJWZ1BqaEZCL1FaVFRKSHV1YUd6MFdk?=
 =?utf-8?B?NFl0dUpvVSs1TklCTC9ZY2ZoM2gwS2FqQTRIYlNid2V5bnZHRWNEaWliVjN2?=
 =?utf-8?B?TnVQVE1oWHptalh6dmpUZ3Z5WHA0RGp1bUJyVVhCS0oza3NIeit4SUtyazZm?=
 =?utf-8?B?MjZTT0pqeDNaMVlIRHU4WW9lR3gxQU84R1R2aGdQQUEzNmh2Z0cvdG5JR1lw?=
 =?utf-8?B?SDBKWHRQOCtYcnRWaERSaWFUYmN0aGR1TTlGN0xvSVlpYnVuamFuRUd2YmNG?=
 =?utf-8?B?TkFka3g5cGpFTFdleThMSjJYVUs0a3VpK1lxeHN5ak5sSEpRWW9ZQ2ZQNmFL?=
 =?utf-8?B?emJZc0k5LytOWWhTdUhaSnZiWFdzTGFaN2ovdjJHejRrdS9CeGUzTisvWk1D?=
 =?utf-8?B?dnkxVmJGdWJRU0N2SVFRdmMyQVlPRGQzWmZBZXJXSERzanhHc1dzMSsyQUs2?=
 =?utf-8?B?a0h1V3UrNDltZHB6bGV1TmVodVJvbDZqUy96bVV0VXVFbWY5c3hoYjZURVI0?=
 =?utf-8?B?S3E4WURJYVpmSEZhSTVvR29EalFsS3RZdW1NN1pDY1hnSGxqZU9YNHFNM0Jx?=
 =?utf-8?B?eFc0RS9jeUxiMWdqUm02TEs3bythWHArOUJER2EzQldIeHdicHJuVFhmUnBZ?=
 =?utf-8?B?RkgzcDhJNUlTZ1FPVW01ZDc1WDVkYVpVUDBnaVJVV0k4MzdHdmZjSUtYVHBD?=
 =?utf-8?B?emlYSS9WM2NKNTduOHdLNkJJSWw0Z0dEcGRxUzNDOW1iazM3UTYwdTg2SVRl?=
 =?utf-8?B?SnVudUZqMDV6Y0VnTFdyOXp1aXVGNTVpRWVmM0pDcGVhT3JDN1pGNnZVRFdO?=
 =?utf-8?B?bFNOc0ZXN3pXWVdUdzlNNTNPSFlxVEZRR0tDU1E0WFYvY2ZZRUIwTlp6RC9N?=
 =?utf-8?B?NnVQbGFKT0pNQnRTaXV6VlBra3RrbG5xRm9LYXI3L2h1RitSWVpVNWd5clA0?=
 =?utf-8?B?eE1rT2huNkUwOFc1Wk83Tmlack9ZWHRENHZ2OEhFRkl2bUw4L1FnbG9iVExS?=
 =?utf-8?B?aHQxTkpwWmp0UWpMdU9FbmdpY1paYW4yTzlXL003V1F6Rm1HbjNmdEIwNThY?=
 =?utf-8?B?bHd5OWlKeXk5VVAyRHRZaEs5cEJTUE9kdWVvdTQrVnppWVBDa3BCUGhyU01K?=
 =?utf-8?B?NFF6RjE1eUdsaU1iQjFQQ0JyT3M0NS9qaEtMN29qSW9zZHFoUW92ZkhvbVFm?=
 =?utf-8?B?NVlHVmcwSUVyN0V1QVY0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1AvZG9WZW5vcHFqUDRId1MzT0Z3QXQ2ZTQxd1R2eVRIZ2VLcHNnWkl0WjVB?=
 =?utf-8?B?RkpYZVNOZWw2bmJPVC9hZ2JCaForbjhEeGN0WEZ1aEVuYVVobEh3ajRHNldD?=
 =?utf-8?B?MGZISDJqdVZwTjJBWEVqem1jdXBIZFJSeUErTEMzcmZaYUFYSzVZNEJxVVFY?=
 =?utf-8?B?UkdGOWZwemdMeE4xemI3VU16NTFPYVRsRnkvUEI5T3V6NmlTSXkwYXJzOWJV?=
 =?utf-8?B?ZG1xdFZKTEhVbjNFY0F1TjY3S2E3MmhCVmJLQVZlTXA4dkw3dzM2TnVacEJh?=
 =?utf-8?B?Z0hxSFBNaHlCTE1MS0xXZzI4RnlLNlVUN255SnduKy9UdWpFek9QTG9wTURl?=
 =?utf-8?B?Rk5mbVliN0Fvd1BJdjFOV3QxcGxxd0FBMWNZdi9TYzVwM0I5elo4eEJNQ2dK?=
 =?utf-8?B?RFc2bWhNSWZOQ3R0SmVKY21vMFQ0VjhrdGUrSERUOExxOUxURk9lYy8vZGpt?=
 =?utf-8?B?c3FlOXVZYUsxS0dKWDlUSDZjbTR6bFpuVDNpS0J4bmFUVWhSR1NJc28rcHJ0?=
 =?utf-8?B?aldTMkVnd1JLMlk5WS9HTTdsNFJvUm8rYlhxZE5hWS80eUtwWithMmlvc1dt?=
 =?utf-8?B?cVprcFhaWlBvMjNqUmU5Uy9sOGNMMDM0bEsvbFZvN2JpelZjYUJaeTA3Zzlp?=
 =?utf-8?B?bzhCdks4MWJVVGg1RmRaTEZrSkkyQXpFQXg0dXdVVVVJai9rWlluWjhMRHNz?=
 =?utf-8?B?UG96NmJxSVJXa2xlVmRBV1ZmQW1iczV5eU9RUjg2QVAyOGIvT0NFRUtOa0ly?=
 =?utf-8?B?TW84T1hxZms4Wk1SSHpZMTIzNUlscHp2d3lUTi9TYzhXWGpWamtUUlpiQUhk?=
 =?utf-8?B?R3pnb0drVTZYZldqdkJ2bU1TMVNyZGRLUDZ0dktyVzl0UHpFT0VnTU0vSjlj?=
 =?utf-8?B?L3NxQTIrOUFrTXlZdWtRSjcvSmlyMzBLQkFIQWRkZUZiRktQWU45V3krcDJB?=
 =?utf-8?B?VmdkcGszb1NnTy9QcEtNZm9QaHc1KzdvUUcrN2dQcU8weldsRjREVFZHQ3Mx?=
 =?utf-8?B?RjR3Q2d4WkdGMS9NdmNNNXZ5Qll5ZlRvNjR1emJuN1lESWsxTVVFd1dzeHlp?=
 =?utf-8?B?TkZNNFpKb2FnMmdEVU1nS2ZhU3lCaTRlZEY2THJKejZHOWpMNjczdWNEWno0?=
 =?utf-8?B?d0FFZ1FSVG5KNldJdWdBOU5kTndobzJrbVR5MDB5MExXWnBkd1ZVb0RkVDZF?=
 =?utf-8?B?cXc4NFdVbDhZTlZPSDY2bXo2QmU3Y0tVaVhWU0N5OS93Z25GYzVoRHBoOEd5?=
 =?utf-8?B?NE1xQXEvc3R6NjdWUHlUbXd0aWxMdzZnd2VlU1l0dDk0TnBkc2VXNTRobHd0?=
 =?utf-8?B?VDFvVFU2SUw1NW9JeEtnaUhXUzFUdU1oYWdHaXhxQzl5VkUvRFE5djlHVXVG?=
 =?utf-8?B?OHJWODF1Y3gwTWRjYWJNaDR2Q29LTy9IVERDd25Tc3Zrcmp2c0JzODE1MUZO?=
 =?utf-8?B?Z0FEZXozS1pTWEFNRVp5bmNpblB4Vmd0L0traDRpTXFLREVPWHFoaDhuL0Rw?=
 =?utf-8?B?UjlnaExtRUU4ZWJlWHhwTTgwMlJESVJWeHpqcG00V3FuRXFvbllXdHZ6aXRz?=
 =?utf-8?B?eEg0aHh6V1BaUGd3SFdBdW1tQnlNNGNJZU5RdFJpRGk4SDQySUNyOSsvMzFq?=
 =?utf-8?B?WTl4QzFpQjhEb0VISHJ5NlRQNllXS1I2Qkk1RmNNSnI0M2lUVGxtbjZhbkV0?=
 =?utf-8?B?L3F4TncwZXhzQ3JwSjhmSkN4eklPV3g1WEd1MzdvNmNDYzRTbnAvb1BpSGJZ?=
 =?utf-8?B?Y1dmUVNNQ1U1YVgxSlp2NUNLbWxLNUdiRjBraDhHUDBpV0h1aUpvUXdMQzkw?=
 =?utf-8?B?dU94YkRZbWxHSGtiOVNJYyt5KzB4UEtVMTRPdWxYdGR4bmZkUUpKd1pQYW5w?=
 =?utf-8?B?dzJUNUtBT3lmOGZtODhKelh1eDNHaGlrRGtiS2ZMRXM3NkV4M2VUcUtEZUtX?=
 =?utf-8?B?KzZMNUJOU0tucTJNeUJLbkRyVThsL05PbE4zTXAvOG9ZR0hBUHdLbW9yWWd5?=
 =?utf-8?B?aDNISnR6Q3Z6YWNpbFZ1ek1ET1FOMUxYNGRQcG5Da2xRTlBObEtDZ2xpQ3Zr?=
 =?utf-8?B?S09lNVhMZWEyMXZSKy9ueTFjdEp2WWZDSkIzM2swbFZlQXpBN0tOcWVXZ2Zj?=
 =?utf-8?B?Vm1tMnhhcmRSN0VqKzlFWFBQZjMxdkgzR3piMVh3K1E0L1RCN3M1UzkzSTA4?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb04133-c2ee-49b6-cad8-08dca4d87f2e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:14:53.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dMNy2TNWadkcFIT7BEyrJ1EhU/ZFE6r4yzVXtZSxrUEV0XiUcfafAmMTW3/nGaqRtKk8JW++zgSX2MxYyNI0xULTRQQgZJqCrsOu94VDso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6938
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
> Fix a minor indentation / whitespace problem in a comment.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
