Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A31CC27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74BF88621;
	Tue, 11 Jun 2024 11:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TS9tnS7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A901E88619; Tue, 11 Jun 2024 11:33:18 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB3688621
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCPtTqSItX5GEzQFnCfYwrfvzAVNZe7YZ0Bq/z0mHlB6+itm/WOFzle5vtYYnUz94Msg/6W3oXzeHBtwCVKRrvM8XiqcjWuDjA/lv5Ay5XGIvB5+e3bkmanKBJBPxE/+0bJ/z+N2t+KlZOA4g12ZQaT6jCPP/2ROTl2Z9Iw3Ib1YXegD2w3GlpcK3FT29R/pAc7TZtvivyt7kKAEWA12HKGwyp0YEMGCkSQqRFE9wi913UKL1BOBNbCbUlYBwv5sN70bIp/c5V5+2Xy4yJVUeviPQbqX1+y0yF9KJVnfm5rbJeVCShJ4MNUGxhI7Yx+MuWS2hoPFLgzkWBgQOP+nFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNr7tOI2gmpwS1qz2SdqdGiR4YPTrDC+413oMwWLRK4=;
 b=Pd6PwJKzGzrepNfFNC3l/uqfxpGHupaA2iOoFj+KysoZJIM7xolKQR6mtFhf6SWXeHep6JmFhrP4jZDZjhbPMOV/83AkVY0Yg1MRRgFMbK5OLPNejsI8jMG1q6ldw3aZ9tak/81vTiFUgAvqgIpSW8YBfaBdbrS7QXGa7pMgwtAXGVsZenjENf8+A+g3wNc7usp5t3RVfLSh2qwwjub+NwTzACCnFW0MG0uxz2Brd9VirELpMDhFyMlwLOTWYgi5Rzi7tPDQcf2L2zPAaJyvhqWCbsryIPVJhUCPTyeFqQeIiPVSN3DJWzcba47YR5/T7mQdHCUoNZQKa9IHz91w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNr7tOI2gmpwS1qz2SdqdGiR4YPTrDC+413oMwWLRK4=;
 b=TS9tnS7VXstUxTPiuO6Qm/3utpAJ0I2eFYna8djqiC8nwjwfKS5zLHOQUK2w9wu1dhoKsvExjwTg6FIdU/Z5ReYX1iUaTSSBYyikiUu2K//rF0+8So1DT+jzT9jiqYPKp7/dkT98O41pWJBZFAubRRpD8ryBllMVa6zye1ZhQFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 09:33:10 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 09:33:14 +0000
Message-ID: <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
Date: Tue, 11 Jun 2024 11:33:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240610185116.353604-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 691a8dfb-ef56-4590-9b3e-08dc89f9845c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk4xK0NtZm1adENqbU9NT1hVdnZsQWVFOWl5V2x3Y3luK1lBUHJ2UVFYdjlV?=
 =?utf-8?B?cnM5blFsOGdtanlxRms2SXFlTEJkOWMzY256eUtxbEYvalBVWUdZbk1HM2RT?=
 =?utf-8?B?bVhkeFF2KzB1MGhHUUVqTjNCeE5tRXo0OWEzRlJuR0RSY0RHMTkxTUZqTGlk?=
 =?utf-8?B?Z0EyNEZ0MXVheUpuL3BxZWpJdVBVN0wyTE1wRk5ha3pKNi9BN3YvQjdHUGFw?=
 =?utf-8?B?ejRTS3ZvcHRncHN5Nms4V3JOZjB5WnRwK0RUSCtyNldnbDB0MEI0Z2xRRm9L?=
 =?utf-8?B?WDl2NEg2RnpLbFFQeFRCcHRwWmlDOFBReTlXeWV0RDZQN1Y4VUxLa0t1eC9a?=
 =?utf-8?B?R3A1V3J2dmpGd2JCWmQvenU2b2tmbFpydFZkNWVmT3NHQXpqMXVBZzNFb3g0?=
 =?utf-8?B?blZwK0tOMHNnTWxJdEpldit1anV4cGdJbGZGeFJsZmZrcVFYalVER1Ezd0F3?=
 =?utf-8?B?N3JxMmVQMUtIMHl5OXRtRGgrOHJjdDF6aFFTbTJsYlZ1TkIxeng3ZWFOM3FW?=
 =?utf-8?B?YkxGSHBRSWVtOEhERnUySENqU1AySlZtd3E1OUNUcHYzc3V4ak5CMkRPWVk5?=
 =?utf-8?B?SVV0Q29hTXFVaElZQ0N3UU1YbkxUTE1QT1JDZWROK3hCZjlnbHBlRHJrajU3?=
 =?utf-8?B?a09wWXdGNTJjWUp6bjRaeXNJaTRDWHNrdjArZDRjL1A1OFNzUFROWTltSHdS?=
 =?utf-8?B?OFdGdzhXT0Z1UUU0Wk9RaVRTVHBUVjJBYW1uSmUzL1BKbGJvdWlxYlRmYUVM?=
 =?utf-8?B?MGNoRWRwT2lNNnlMOHh2TW9zQ1ZBTzhlOWZhVnp4cnhlMHBlVkdmbWVzTUNI?=
 =?utf-8?B?K0FLZWgrVFQwNVh2bE9qRURza3JpOUZCeG0xTlVNRndHSGl2d2J0NHlEN0o5?=
 =?utf-8?B?bGlaaTFoZEhvRTBVS2pnbktmaVZpcExRLzRPRk9rUHB5YkpaV1BIbHhrQjN6?=
 =?utf-8?B?VlkvMlkzYnRTY3V6OWN4cjZjWmVFV0JOU3U3WTZuSFIxWjVTNzZ1YVpvbmkx?=
 =?utf-8?B?M0gzdllDeU50MUtYUTEvNlE1djQwTnc4dnBiN1RXVEZkRGF2Y1IrSDlncGxl?=
 =?utf-8?B?b1lpRCtUY3ROQXFWZGVJcHE2R0l1RDFTQmtNVy8rNk1CSUpiS0ZwMWZodFl6?=
 =?utf-8?B?bGVLcWZkSGV3alF6ejVvWWh3N2FjbzB5MTNvTlBIczJ6bUFKMVVoeEpkY0sv?=
 =?utf-8?B?YUlEMW5UbzVJNVBtYjMwK0tFaGVoYTcrYUk4bkkxSDYvQXZFTnVCRjBlMTNt?=
 =?utf-8?B?SlVsRkFTU0MxdUpFMjYrSU5HL201OW9nUndLMGl2R3VRZml6eUV6VzFSRWtP?=
 =?utf-8?B?bG9sN2hZUEFUZ1BVci9aM0lPdTlva2JqVHlsYkswM1A5VEh2YmdES1VLdkhx?=
 =?utf-8?B?RnIyVXBmQUFZWm8zUXZaeFlydFFyNHRDQTRWWUJidXg4WTdmTEhiQ3Y3Tmh0?=
 =?utf-8?B?Vy9idkk4Z2Zwa0RVWlhuNVpMb0YvRXZFeUhBL2hqMS9iaFRYNDlRa1ovTmZr?=
 =?utf-8?B?djJhTVdYeUNjTjJZSTNSRkprM0hTQmZrMml2TWNEbzd2M3FzdHZCejV2V3Z3?=
 =?utf-8?B?YkJ0VWorTVRLeGRwbkJyR2huNm1EOFR1MW4vQy9KcWg5WWw5a3ZHa2I5YTdn?=
 =?utf-8?B?L3Z0aU5pNE43Q2hLbis2YlgrYTJ4OHZzcVF4d1QyNitHV3U2NTh6aTVHam9l?=
 =?utf-8?B?Ly9KekExRWpBbDFxMmZCQWg5bjFaKzVVTjNvQVl4WDd6UjJtTzhJc0JuYkda?=
 =?utf-8?Q?ljaFakt/Yj93cOvyVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhpRk8yUVlKNWhyd2NvY0d0ckRIa2Q2K0dLTTFHRUs0VFJieXB2eWRqdllB?=
 =?utf-8?B?YnVSdnJnTUFNNHl4MnEyOUhiUXJ1RG15SUJFb1lvMmdJT0I3V05xU3FqbXBX?=
 =?utf-8?B?Q0t4OEdrS0IyY0lBL2tsWDJuWmFhTlJBNEZYM1BPdGUwNkhDU0NzSFF2Nmg5?=
 =?utf-8?B?M3pOQUNrVGpmYmdadWZDT0Zqdk5mZGtudVJNYlhuYllhdnJzNGNndWRia0dy?=
 =?utf-8?B?M3hzS2UvRU9ydjNmcmtpTm43RUZZZEZoenM0aU5WdlhGYjNKUGNOWGIvcU53?=
 =?utf-8?B?SkRxdnM2TlFLd2hNZngwMWJiUXFTanRFTnN3TFdwOUhjYzhscnlCMzBBQkRV?=
 =?utf-8?B?L0VvclJ4WTNBRkJ4M3ZmdEd6dnRDeWllQlVaZTd3bktHWng4MGZxRUpmdFAz?=
 =?utf-8?B?cFdzY1h5dXk2RUpyOWZyY3htSC9mb2x1RjlNWVhMN2k0akVVR25GU2szM2g4?=
 =?utf-8?B?cy96c1hKNG1pSFk0OERaalBYQ2xmYzQ4bStidHRCL0JoYXdSVTB0WUdKSVUx?=
 =?utf-8?B?NWRBOG1tSVhvNVZoVFliNlo0VkZWMHFvaW9adklsYUwydDVBYW5UTks5QzNZ?=
 =?utf-8?B?MHd5MnpxVWIvc2gxMzdXazUrNTcxd3Z2UW1wSnpqRHZLQ2I4NWMrdG1CVGxi?=
 =?utf-8?B?SVYrZUxGTTdkQVJGNVBJVW15MERiUitiYURPUUdjNWFGS2NlaGNOZzlCSmdm?=
 =?utf-8?B?V3EzQWVVT3pZdkdCWWdhdjRRTC9LSkNaSlF5eTd0ekJJejRTQUNDYkJFVHJt?=
 =?utf-8?B?TzF5N3ozeDFSbEdnYk82SkN0dlJYV3h2WHFHUDlwVm50a3l0cGVyN214RnNZ?=
 =?utf-8?B?RTRXSzFVN21rL0NkaHh0LzNsYVYwc1VDYXJXVEZqRTlEQ3F4YnNINXZrTzlv?=
 =?utf-8?B?VS9sSmpaaWFrV01qbURHYjZENENuQXNHZDdwZG40SU5FOXh4NGlWUk1WdEtJ?=
 =?utf-8?B?Z0pXY0c0cVlaMW1VR2tBUFBJU28yb3AyaityLzlxSDZoMGlsNjRuR21OQ0FF?=
 =?utf-8?B?ZUVXdGY4eHRoTHJPOCszQzFZQnkxc1pGdzYwdDg2ODAwYXpwRmdsNUxjQW1o?=
 =?utf-8?B?eGxsWTNRU0tKeVQyNWlENzlpRWF5T1lWdXFjbWc0NVFpZkhCamkrOWIra2l6?=
 =?utf-8?B?VllnVGx5eW83eVpTZlpwN0hZZFpDMWoxYVhkZm5zNVlTR2xzSUZVS3NGWi9y?=
 =?utf-8?B?c0xHakdzNmpmRUluMGJEdlF2Snl3elpQQU5iWXVxUWdZN0pNUnBib20xNlhZ?=
 =?utf-8?B?VzdsckQrOXRZR2dZeVpRdy9kT1dzRnRKMDd0ZkNCMVQyTDZPVEhJTWdTOTNJ?=
 =?utf-8?B?My9Ga0ZGbEo2ODNpT25ldmdNbVZ3Zm8xd05ZOE5zeTNNeGJEbG1kZmc1ays0?=
 =?utf-8?B?SUQ0ZmQzZWJvUFZsNDJ4akJqYWdWMFVzaGJJbUFqbHZ5alhsSisrTWVzK2hq?=
 =?utf-8?B?bFpyVk9QdG5ZRDlweHBjaHFOdGVxZm1kSFRQUzVreTZITjBHTWd1U1RFcDhF?=
 =?utf-8?B?Tk5OQ3hYczJxZWpYWGNGZThpQzRlY0dFZGJSV216QjRrTlJLcHpPQms0WmMr?=
 =?utf-8?B?bGxGVjUxQWxyM3hYR3hMazJMZVFJOEFETk1iRE54WnZNc3ozTkN0VUYrc3lT?=
 =?utf-8?B?czllTU5WT0M5WktuZ3hpd0Z2bHNwbTMxSW9CbjgyLzFkYmJJOHQ1SVY0aDJR?=
 =?utf-8?B?cW5ZcUkrNXlEMzJKV0FLS3IzcDkzYzRYc1hBL0padTc5b2kxZmFWRDc2YWdQ?=
 =?utf-8?B?VitwV2k2Wnh6TUtXajdacDNKV3A5RHNYVzF6T1hCNWV6V3VmTm1TcVR5blFN?=
 =?utf-8?B?anFmbTJmaytzanA4c3RzYlI1Z2RkZzltRmQyVmJzMDM0blhVK3g3Y0J0Q1hm?=
 =?utf-8?B?eTl5MWJzZS9oRmwvdzFSWEZZbjBCU1htV08ybTNoL0M0S1BaQWNuaW5sWVRw?=
 =?utf-8?B?eHBJam1tMERiOW5Lb2lwUVAxN2dDSUdkNnY4OUhKa2p5QTdyd2RKbThOYjZr?=
 =?utf-8?B?dWliUUJQYXhFUHM4aS9VeTR6VnJFRzRQbUVhMHo2RU11U1JOZFBJenpNQVJh?=
 =?utf-8?B?anFmQUZ4aHdWMXRaTFduWDZKZGV2YUI1MVBHR2Q2Q3BnNzNYcHZNTHNQdTZy?=
 =?utf-8?B?UndJdXVkNHcwQU1GbDNvSVV6K2pxVnRTQUxZU3JjMm1lV2JqN09QUTM5bzZj?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 691a8dfb-ef56-4590-9b3e-08dc89f9845c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 09:33:14.1737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE5jYHkH33uZBD+o53pEswn+M0xx9dw2GBs8N0iO49a40vk4bfe8VyBdbPFGbL+gYSN6UAHdz6j2THGNEFQBk/DPD3HtoTzHnUwNCOyHcRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716
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

Hi Vasileios,

On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
 > Add support to save boot count variable in a file in a FAT filesystem.
 >
 > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
 > ---
 >   doc/README.bootcount                          | 12 ++---
 >   drivers/bootcount/Kconfig                     | 53 +++++++++++++------
 >   drivers/bootcount/Makefile                    |  2 +-
 >   .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
 >   4 files changed, 50 insertions(+), 29 deletions(-)
 >   rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
 >
 > diff --git a/doc/README.bootcount b/doc/README.bootcount
 > index f6c5f82f..0f4ffb68 100644
 > --- a/doc/README.bootcount
 > +++ b/doc/README.bootcount
 > @@ -23,15 +23,15 @@ It is the responsibility of some application code 
(typically a Linux
 >   application) to reset the variable "bootcount" to 0 when the system 
booted
 >   successfully, thus allowing for more boot cycles.
 >
 > -CONFIG_BOOTCOUNT_EXT
 > +CONFIG_BOOTCOUNT_FS
 >   --------------------
 >
 > -This adds support for maintaining boot count in a file on an EXT 
filesystem.
 > -The file to use is defined by:
 > +This adds support for maintaining boot count in a file on a filesystem.
 > +Supported filesystems are FAT and EXT. The file to use is defined by:
 >
 > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
 > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
 > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
 > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
 > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
 > +CONFIG_SYS_BOOTCOUNT_FS_NAME
 >
 >   The format of the file is:
 >
 > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
 > index 3c56253b..d3679eb5 100644
 > --- a/drivers/bootcount/Kconfig
 > +++ b/drivers/bootcount/Kconfig
 > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
 >   	    Set to the address where the bootcount and bootcount magic
 >   	    will be stored.
 >
 > -config BOOTCOUNT_EXT
 > -	bool "Boot counter on EXT filesystem"
 > -	depends on FS_EXT4
 > -	select EXT4_WRITE
 > +config BOOTCOUNT_FS
 > +	bool "Boot counter on a filesystem"
 > +	depends on FS_EXT4 || FS_FAT
Do we really need this 'depends on' here? Especially if we have a choice 
below...

 >   	help
 >   	  Add support for maintaining boot count in a file on an EXT
The help text is still mentioning EXT here.

I would recommend removing it, or listing the supported filesystems at 
the moment. While I assume you tested with FAT, I assume that with 
FS_ANY, any FS should be supported?

 >   	  filesystem.
 > @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
 >   	  This option enables packing boot count magic value and boot count
 >   	  into single word (32 bits).
 >
 > -config SYS_BOOTCOUNT_EXT_INTERFACE
 > -	string "Interface on which to find boot counter EXT filesystem"
 > +if BOOTCOUNT_FS
 > +choice
 > +	prompt "Filesystem type"
 > +	default BOOTCOUNT_EXT
 > +
 > +config BOOTCOUNT_EXT
 > +	bool "Boot counter on EXT filesystem"
 > +	depends on FS_EXT4
 > +	select EXT4_WRITE
 > +	help
 > +	  Add support for maintaing boot counter in a file on EXT filesystem"
 > +
 > +config BOOTCOUNT_FAT
 > +	bool "Boot counter on FAT filesystem"
 > +	depends on FS_FAT
 > +	select FAT_WRITE
 > +	help
 > +	  Add support for maintaing boot counter in a file on FAT filesystem"
 > +
 > +endchoice
 > +endif
 > +
Since we now support FS_ANY, do we really need this choice at all?

Alternatively, should it **really** be a choice and not just a bunch of 
configs that depends on BOOTCOUNT_FS + whatever's needed to write on 
that FS instead? I think we could have both BOOTCOUNT_EXT and 
BOOTCOUNT_FAT set without issue?

Cheers,
Quentin
