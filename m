Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A53C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCB98364E;
	Wed,  9 Apr 2025 13:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nftFIPCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75598365E; Wed,  9 Apr 2025 13:06:08 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA0B83622
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FffQlSQzaPOkeXy8HfRHgPdzSZ2KAro7RL1So1Qvlz2kYX2p14BV1DiFozWujIJzmD9cU4hR276m1U49QF4P2IzlHG0seW0rR4ahkvz8OoNg6ZjISCMyTVRu9/9SxE+fODM/iZBaa9HPrfvZvmPNH7aMTpIkOQSyzCk70fzy58fwd1h8BSKq8QH6YjgtqL+Y9hr5wL9ngyLOiry5wnT46gUVfv7YpVnEir8cLfSK6dP/GXX4LS7Ndais3EL8pxTcga9CWSFnpYCknIxwyWneyXcdPuBg0+2azmPAmdVgNxmNx1m93PRCJX/Gdf0YdhWd3D8VuoXgTfeDoj8DiKom7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE9DkP8PJaB5dkFZ9xLxK7t2eeodbqlSsWe1Rw0Icb4=;
 b=ZeWVBmjd7LYLKjIey0Ydlh14jd0cwrj/GRiHZeeTCxBWBR8sbG51YFkm31eVwToq6Dy2HRkjZdr4yq3SdRufpgKSLeLRYXUxtCJf53D6sEwhYdrpwvHNl0njS4GbJ6XisFjX4Vd4xJfTtW9FuuSXKKNFa+gdpLuUTlIa/PC18Y6xQFdt+op6vg+O+rLBfeEg4pteWGWkfVoV1j+uI2+5chiIPmt71sDLf+eoFhwXAaXVZsF0EJSRT+K4NlK0JFa6TxMe8AZqXl/TYXD40EuU/28yaxReCjyJ5UegcxOKqh1td0Zjq41ZooyBvIFh5UnCv9BYKazca24H1xYrm1teGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE9DkP8PJaB5dkFZ9xLxK7t2eeodbqlSsWe1Rw0Icb4=;
 b=nftFIPCpVWEwy3KTBrn4jMZsG4+AO7ZVruzdSlq3Xx2CMIy0WsIMjX/tKTzwHJdg6GmYoPhHCNhUxQX5RWCmkDMCcHcbnjin9VS6sCSv3Vl6rTqPWJ6ACOMHk0mFAROUVJ3glKT4jWY+5qS/uE8pfqr4l/pPTjwI8F6ItmZlz+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 11:06:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 11:06:02 +0000
Message-ID: <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
Date: Wed, 9 Apr 2025 13:06:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a2d278-83d1-48ff-e152-08dd77568454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXU3djFzOHRXazZ0K3MrRmh2c0krZGM1SXpzZ1RJOWYyVmRlSFY5MmpZVEkx?=
 =?utf-8?B?VExPMVd5bUdOMUVab0FUMDNDNkMrdmFlQWt0NFYyT2hzY0tEa0xqdDRuT3Vr?=
 =?utf-8?B?L1N5VUxESzM3ZlYwb252bzA0YWRTV1NmbElpU3FUZm5tbVlOdWMxOEp1bk00?=
 =?utf-8?B?am9meko0d21jSVd3NkVyZDdNUmhpcmF5VlMrRkl5eCt6clZkMEhWbmtINHFo?=
 =?utf-8?B?M21iMXBqTytuelZJbW0zVC9PWVJmS1p5V3RpRk5NQWlvSmFYL3g5RFV6NWFB?=
 =?utf-8?B?aVZFVDZnS0Q0WEVuMWd3Mk9pck9KcHR3emFMTWY4UUgzS3F1MHRoNGR4Zm1I?=
 =?utf-8?B?aEtRd2RmYzhEVGhVT3BxU09zSlZOSm1qTFRYNHhMWFIyc1pzOVdkbjcxRStv?=
 =?utf-8?B?MVpoTzU1Q3FzQmdpOTZOTCsraWJIRXBrcW05VFRJRDlRb2ZRbDA5Rk1oMWtz?=
 =?utf-8?B?VXI1M2wyd0VCYjhnVE1FeWVibEdVM2cvUjJXUkRtSG5iZHgwTW5KaWJIQmxk?=
 =?utf-8?B?RUk5UUh1N3c4RDg4bXhLaCtPb28yS09vL3N6eGg0NFplT3JIbzYyN3JGeDdi?=
 =?utf-8?B?SnN6bnlRdWN5L2hqenBaUCtIcXF6TGtxL2JPSllQTVpEQkNuZXY1VWRUOGh0?=
 =?utf-8?B?ZUs1dksyUjdMdkJOTlczU1BqSEptNXdhUUIrVkNJV1VjbTlQbm4xUGc1dEVW?=
 =?utf-8?B?V1E3ak00UG9ldnRuTkQwY0ZkQU11RGJQWTVPVFlTcENTN2hURlpJV214MjJM?=
 =?utf-8?B?cEdBN3JtQ1lBeTFpYXNBQ0QyaEVKOEJaeDV4cGJYN09GQ0hxMFc0RVFkS2Qy?=
 =?utf-8?B?Ynp5WHRJRWJsb3ZTSTZuWWxJbS9CbEZXNkNoMVp0dC9wMTY3OEtKcmk4S1ly?=
 =?utf-8?B?TnNkbm1XTnJrVGN0K1NKNkdjUTRiaTJlcWVsWlc1MTNFZXRzTEM4RERTZGNG?=
 =?utf-8?B?YnViUU5LRTV0cHVpTTVCUzZTTk93MGRVU2l2OXJtK2h0M1VJUTVHVVlVS2c0?=
 =?utf-8?B?bVJtY2FLQ0Z2TnF6Y3U0N3Q0MUJFeWFVZzhYejUveExPTDRPRWtNVDZ1bjlt?=
 =?utf-8?B?ZVZUZFJhaWl3dmN5R3JYVVNraUUzeFFiS3F3K2VsNFhuY1F2bEd5R0RCd3hL?=
 =?utf-8?B?b0EvUEpvdXduL2NUYzJscVh1am4wYmlLbHlPSCtPb0l4NUJVbWMrd3lrRjBx?=
 =?utf-8?B?dnhHSlhJT0VWOFJjR1JiTit0cmpTUU5UR0RBZlJiRXRqOEhxMit3Z1hYempS?=
 =?utf-8?B?Ujd3NzN3QkY1Q1o2R1hPbzJZdk5LQXpCdzRHVmYzL2RvVnZYaFVJdHYzeWl1?=
 =?utf-8?B?RUpOck9MbFpHK3YyVWdaTzRpWm91d2FVQnBuQ1lacytDcGpsK0hlM2xrTitU?=
 =?utf-8?B?bTVlODhrT2dsZXpMNm9lN2t4azBnaFZMbmJQTWJ4L082a3U3eHZpMGcxaTRM?=
 =?utf-8?B?emdkaUROdWQrL3ZLL1QwS0IrZml1aktiZWNjOE8yVTk1SFRoS2U1Wjh5UmFE?=
 =?utf-8?B?STcyTzd6Ums1NGJLdVB6bjUyd0UzRjd4QkEwa0NWRzBHTUplbnZUVDgvcW5S?=
 =?utf-8?B?SkpMZ3BxWml3Y3RiSFR5VjFSMkl1a01rQmZsYUh3TkF2YTVzRXFCbEVuV2No?=
 =?utf-8?B?ZkZnVVhHWWdkOGx1YUZLZXBhRzJTV1MvWmVlWHB0Q1NGbERhdVRjaDVtNjZW?=
 =?utf-8?B?alhSVWlWeVo3OWVHUnZBWVIzMDBjYVBrK2xNazlqeVBTWldrOHorZEkvZzBY?=
 =?utf-8?B?VFpsbjIzVTJ6VUdtZC95cXJ1RWhhaGVuWkdBd3U1ZStNV0FhWWhGd245UUVl?=
 =?utf-8?Q?4An/6jzRNuarWwl2BqhJscGzLsBNo4xz89sHo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBVM2tlVXFOblAyTWYvTkIwbzNXSkdNNm4zL0poZ0pwT1Vob1BYZ1VPUy9R?=
 =?utf-8?B?UmdpVFZIMXJ1aHJIdXNubkd0SXduY01WN3FiNlVrbjBYa1BBMzZ2UjM2Ky9P?=
 =?utf-8?B?a3NXRzlVTGdFa3RkTVg5WWoyU1AvcTlWQzZsN0IzaFhpR3gxUEhnRjJnbDFB?=
 =?utf-8?B?YnlvQnZnb2wvMHZjODA0bEp4QW56R0pQTmYvdjR1R3ZQZG1KbitscEo1NFVL?=
 =?utf-8?B?SGFQYWp2eE9yU2xWZ1ZVVndOSEw4RDNabXRDRkIrTHRTTHhzeEZkK3h5WFhk?=
 =?utf-8?B?SldsK2RiOGV4ZnVIZTVPOWxmK0JZUWthamVuK0t5dUNiWnNmbzlrQWFNdnZR?=
 =?utf-8?B?cFlhYi80cDlDWVFGVzBtS1BiTHhlMmFIWFVxemt5NFVRZlp0VVhKL1RpNity?=
 =?utf-8?B?QTVac2VFYm5yd0lkQVIwRmNUU2ZjOTFPS0JOV3gwT0R0a1oxN2pUNkVnZnMz?=
 =?utf-8?B?SDFhdkIxai9pQWpGcVovQWd4b3NFNFJBV3NidEovVHFCTmthR2JEdzk4Rm5z?=
 =?utf-8?B?ZVU1SU9zWWY5M2VNVElwUTNDUEw1L1VpNXdFdkMzM1JaSnEwazZtRWV4RHhy?=
 =?utf-8?B?QVZXV0dacGFCUEdzZG4xajFwZ3VJaGNoaWRlcVB0L0dOVGk2TUhpcTZaOHFC?=
 =?utf-8?B?S29DenVrZUluVVJSMjE5NUhYZWU0VkFQY3cxMlRBQ2QvNEYzTXg2ZTVHMGJF?=
 =?utf-8?B?NENDbWJ3b2JBK05XSllVL2lCaEhUZDFrRWFCc3lKekcrNTJkZkF0ajNLcnlD?=
 =?utf-8?B?VU04NzRnZTZsbWNTdXR3amU1Q0k0bnYyM1NGTWlaTCthV014eHRFTDJFckd0?=
 =?utf-8?B?MitST2J1VnJEYTN2TTUwTjZuaWJycUJyekZDd1ZDN1NpQU5RZXZXcmE0a0Qw?=
 =?utf-8?B?SDBoQ2F3NzVVb0NLMURBWWVGQ2J6dEN5Z1UrNWZySmdJd0djQ2ZJNk9Fa1ZO?=
 =?utf-8?B?MndxS3VXMnBwYU9zTkU3UTY3NHBJSUE2TUY3NVNITnpFdm5qUjIveGw1YXBQ?=
 =?utf-8?B?QVQzVk1kWXNjaVJNRkZUNFkzRjJLSmNlSXN1aXZHc29oZkY3VUoxc25VV3Zv?=
 =?utf-8?B?OWRjeFFuT3E2VGoyOUN1MC9iNXUrZWtmdWwrOFI0MGpRSU5hN1dOb3VZN3p4?=
 =?utf-8?B?YmpORFlHTkZ3U1Vyc3gxc3pkbkxmRER1L3MvZXdEaGZ0ZVdMOXMzdVZXWld4?=
 =?utf-8?B?Y2hHMys0ZWFTREgvRmlrb0l2ZEt6Zmc3Q1pOdWVhSXVmZkZreFEyallpa2h0?=
 =?utf-8?B?MlZtcjlUQkNiRlV5ZnA4NGdOWmpORmZVcXMyeWxzWkU0VTZaZHZpVUxDVlVq?=
 =?utf-8?B?dExlSGluczUwNi96bS9HT1FDT0V4RGxrb1VNZFpkaXJ6N25DejVKU25OQzI3?=
 =?utf-8?B?MVg1K1ZvMkprcmhYS05OZmtsZXl4aWNjdjJuR2tXTmdlZjJHNk8wTUdTK2Nx?=
 =?utf-8?B?RWlqS1JqS2JjNXpmaVdJUEUyVllOL0lqZUpKemdoeXFSZkJsR0M3aXZ1OGNF?=
 =?utf-8?B?bXFVK21MTlRYMTdCaHIwbDVzRFl2U1VjMXB0VXFTT0JUQU9kNkwxeU9DY1dR?=
 =?utf-8?B?MnBwK3EvR3NOaEs1NXRBS1V1WkliT2VSdkZqSHBpZ1pLeGhtSVczU0I3NkNx?=
 =?utf-8?B?WWY5TWJKczdtMmFxZ29RLzZVWitldjVnWkFvN0YwQzFhT3A1V1Vva1l4ZXVS?=
 =?utf-8?B?YXR0SlBYdkFmR2lSM1RGN29yRFFjSUs1U05mRm1jSjlKWHp2T1RhN0YvdDZs?=
 =?utf-8?B?UjVzMzBSdDRCVFc3V0x0NzRtWE84WkdTSm9Lb2FQOUc0bEpRdW94cU5DSCtO?=
 =?utf-8?B?M09qaHdPbDJJSksvVDNjS3I3eFJUOFRLd29rRjM3VVJtSmZtd0xhai9iY09q?=
 =?utf-8?B?cXJUYVdNakl1MFNIMFRZbW51L09DMmFNVUhOSGt6eVllRGxnN3dmU2pYQ0dk?=
 =?utf-8?B?dWJHU0hhNlJDRmc1ZkNUa21sUjcyeENGRVRoS09xd1E1VzJjZmxTdEQ2UTFo?=
 =?utf-8?B?aFVWb3phRFhEY3lUbzBzTVA3RHdtWWVQVnBZeG1UQXZGVlg0UllDZTVxSVZn?=
 =?utf-8?B?RDN0MEtqSy9CeGZKVjNKV0pRdElKYWhBUVM5bCtkM3VUV1dNdm5BdzhCdnZZ?=
 =?utf-8?B?ZjRSeVRqcEZnMjVoSE5EU1NUZlRnUDE0UmxzK3N3US9LSE8xaUkrWC9POExL?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a2d278-83d1-48ff-e152-08dd77568454
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:06:02.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXwM3ysQEc2Sk+HsvF2uGyvjCvzHFQbP/nBhVDTEL/72fsrHaqPE3tGr7V22WM8bMGllrUyW2ou94XezrPjkbGX0EgJJakqlaopmzH0idTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837
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

Hi Jonas,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
> consuming compared to ARMv8 SoCs with Crypto Extensions.
> 
> Add support for use of the crc32 hash algo when SHA256 is not supported.
> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
> compiled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

I don't know enough about general security but this very much looks like 
a bad idea to me.

https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html

"""
While properly designed CRC's are good at detecting random errors in
the data (due to e.g. line noise), the CRC is useless as a secure
indicator of intentional manipulation of the data. And this is
because it's not hard at all to modify the data to produce any CRC
you desire (e.g. the same CRC as the original data, to try to
disguise your data manipulation).
"""

(yes I took the "first" link my web search engine returned me, thanks 
confirmation bias!).

I don't want to give people a false sense of security. If it really 
comes down to it, I'd rather have an explicit Kconfig symbol to set this 
value (maybe have a `choice` even) and be very clear about security 
implications.

Cheers,
Quentin
