Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB76C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BA98083C;
	Wed, 29 Jan 2025 16:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="isUNs+ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE6C809D4; Wed, 29 Jan 2025 16:04:36 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09FC80819
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QboAHQrPCnf8OvD+3b8fPSYsU+iWiYIM3A5Uk8v9GdiWa8ckoaMAWD/twDNC8lSZnflwcgj3oEePbgYGf+SmvJ1n/GYGAdJpkAjHCxEp+om0+YEQHB9rx5ThoKrqDDjHCLBQRSsZbugNx3R1+O4vC4c/M+cPmYcyM6+U5Sdlr1smK3wsLS36nw5v2J4IVupNgHnLmz06sCjlLldAaFQyLdD88J192hXz1RvMucqbN/REWHfFDKpyVLDwFUM7q1lIF9GA41T0gP0XSCnK5TStBDEiuq3nAxqwjPBHpna6xJv7N34LlR3gZJnxT7cQhLb0qvMag79iH44Po/4hV00CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaQbHyRhoNUkpfHyaz8vXZZNlysksbvvfFrO+hYVnfU=;
 b=gO1ba5k4nz7EpLGxV3FWG34KCuPr5MzzGhr7h4U207MteTdJOcrl1miv8z9q52T8UlrGjx9lRaVBOVgfD2Q3xqN1vm2EwXonHhw+gVWzHffcXoxB7xubcIWD/y8w1fqZBGFpwuyjsTPx2MRHC+0yyaVJR4+qyFfVch+PSZCXZzDxFez6Pt31OnsK0LLEkU1Q617z8Hb/godKLYwX2hWzKzKk6F+CNKSQ+GI+Ptr2q18i4lH9lanfotm97TDM4WpwX+vXyKiwfpWyQy1ESQDtF1U5+WqysTNVGyr3tWWJVSvCThsy+hXqAga+qZZMmuVZljWPP/B0MG84hLdSoA/lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaQbHyRhoNUkpfHyaz8vXZZNlysksbvvfFrO+hYVnfU=;
 b=isUNs+wsEWQanu+6bssBYAiHdQZu0UQWcYRn4F0w5BjripSzEraVaDYNYKKWyM/2mCwLs5MhoFQfJ7knP8nW/VMl9C1aFS6MmPgZTbw3YL0rzBZBEDKkIr5vvhINFjjmxjc7eHp9CaSGZyj7YoXTLyfaaTYYC8hWNnrGp2yV+To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10641.eurprd04.prod.outlook.com (2603:10a6:800:272::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 15:04:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:04:31 +0000
Message-ID: <b9187c58-45e3-4483-81f4-033bc7840480@cherry.de>
Date: Wed, 29 Jan 2025 16:04:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: renesas: Deduplicate board_early_init_f()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-7-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250118111621.362188-7-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10641:EE_
X-MS-Office365-Filtering-Correlation-Id: eb341ff3-ef51-491e-5198-08dd40763c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S09ibXZsVjY1dzFKV3dueUMzZzBQNm91ZGNWdktyRUY0K3RCdW9xVk9FVzlt?=
 =?utf-8?B?dWhRMVlTamM1ckFpU25FVFZKTExRdEZmY3pwTUpmbWZMbUVwekxrTnFBRXlt?=
 =?utf-8?B?bFY2dmxPR3BRaVRIK2MwTzloK0RsT1drVy82QStXV2t2YXdDNExRSHJobW9K?=
 =?utf-8?B?UjAxRHdHZ3NEN1ZaVFRidHZHaDlmRmxXbEZaUGlhV20yTFJGWTA5V2g1a1pK?=
 =?utf-8?B?TVhGTHdxblRHNWY2Y054WEE0NXZKS3RKVWhManJvTjVGZFpDNnVRT0RlOWVC?=
 =?utf-8?B?VlV3ditESmx0TFh6RCsvUjhDN3NvQzE3TjVJYkVGNGNuakZ5Y0JNd09JSkEr?=
 =?utf-8?B?TjNSemlDS0YxMkM5NzZEcXlvcS9SaU5JZTVMaTRPUGdiSm43M3Yya1I2WDRV?=
 =?utf-8?B?c2NWYi9WZE1KbDE2SU56QVBUeXBjOVVGOVBBVTZ4TVRyNVFWb3REYVVnNEFW?=
 =?utf-8?B?L2psUldQZmdicEJPUGZBZkdscStWNHpRbFBaRVpqREQ2NW1QeDlBeDBueUpi?=
 =?utf-8?B?RWxjV08rc2VHR1RxN2Q2a1ZSN0xQVkZwMnFYM28rS2xBYndJYWx3SFhMVnkw?=
 =?utf-8?B?WnI1Qm93UzFHYzZKRnNScm43Slo3bzlFRitmdEhyZ3BFQ2xnOHRtQmNoWGNv?=
 =?utf-8?B?Wk1BVDBrOHVxWHNLcFd2TUpIRHVpVzlMSFRtOFk0VWJFeDRLeUJDR1lWTElj?=
 =?utf-8?B?Z1FxOFJhb2kvY0c3Z0lMRDY5ekxMVld1emlqc1pDUlE2aXRvVHdzZkVaeG9o?=
 =?utf-8?B?eWhaS0R6YTVpZDlhdkFkWWlaUXVneDIwYUZoNXJZRVoyQXlrVTFwSXZ4aEZI?=
 =?utf-8?B?ZnJ4YnRiOVZGRHMxLy9nTUczdXc1ZUg1YVE2SGxNM0toVm5ucFM5R282S1BB?=
 =?utf-8?B?dWJxaG5NeTBJamh3SWdaV0p3K2ZyK1Z5ZklSRXV6VDZGVjhHbk0wRGJONzM2?=
 =?utf-8?B?ZHp2elBieGZwa1pkVXc4eDVVQWU0TnFrUklBd3g3VkZDQllqc1VpeFNpMm52?=
 =?utf-8?B?QWE4c2VmZ3J6TUlmcVlER0t2WG9pakRQYmVSM1JqVG5XaVc0aUtrb1JJU0Z6?=
 =?utf-8?B?a0VPMFhmZ0J5WGxrTmIyQStOcFNqeVBWNDh1bHhsZldSS2JUK21CcHAvYzkw?=
 =?utf-8?B?aFBkWC9YMDQxRWJrVHpNYUNxYmJHdFQ4U1hmeVRXUDBLd1lwY3FNUFJSMHkr?=
 =?utf-8?B?dHdyaFZYN2lXUTNwaVBIRmtrMDNoSjV6UDFuM05hcFNGUlpGWEZFSXM1WU9k?=
 =?utf-8?B?aXhreG0xbElBMExwby9sc2FlVWR2Y3RMeXJ5RHdVeE5XbW5maVpWOFgzUzQ4?=
 =?utf-8?B?SVNGbm12MjlHQWRrOExUV2ZzanpTbUdYTk16bG1LdXRHUm1NT3F5WWJCR1lE?=
 =?utf-8?B?YnFQNzJ3aWR4dFp2dFB4MXU4Q3I5d2N4Zm5zSUpaamoxZUpDNG5SN2NCMVJT?=
 =?utf-8?B?M0o3Z3dDVzZYSzY1RlVyOXRJeXRpREN6enFQNjVPcE4veGVXYms0VklobmJn?=
 =?utf-8?B?dHRzTmxQZzFyc1VuNjVHVUZRNHN5ODB2aFVaQVMrdkJnbHVBZitWTFNCbjBL?=
 =?utf-8?B?L1d2WG9veVNPZFA3NHQrczJ5RUhCSERmY2NRdVdxczdsZjNIak9obzhSQTFp?=
 =?utf-8?B?ZHdITGtValNpWFdCeFl2RUpTdW5UQVJHY25Xd1dCdDBJeVJGQmpTTWQrTmY4?=
 =?utf-8?B?VTdvMUlZTDg1ZmtSS0lBalhZeDBBTHh4UTVrZ2VaeHhIeVY0dGRBQXg4ektK?=
 =?utf-8?B?TlE4M1k5WUxjbmlGb0J0ZHRXVFdFZjFIQmpZbXVVWEpYaFdkSTl3d1pIU2Ns?=
 =?utf-8?B?ZkhyYWxISEJERTF3TTBsbHRHYnBPZUlEbUIxcS9EQ3ZvVDVnYjN5bFpNWkps?=
 =?utf-8?Q?82mz5f1KX6+b3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVWM2V1aWgyWE5uNlpLUmhCVi80ejJLWTJLMCtVZkRFbVJBN1JQVEZLODFN?=
 =?utf-8?B?bHVRTzFtcmJPc21pbXVocUdqQm9WcGNQd1VXc2grVDJERm4ya3FpTmt3Nkxq?=
 =?utf-8?B?VDhhT2pBbFVRc0l3YituSjVvSzFjaksvaTJKK1lxQ1V0MERUcWZIc3FERnQ0?=
 =?utf-8?B?ZjdDTWM3TnA5cmVCR2pRQklGK1F3MnhQYVhXRGEySnIzaHh3WUFkQlZTV0h0?=
 =?utf-8?B?NHJ4U053S3JDc0M4Z2ZDcGlrcG5HbGwxd2JnZTRCMjNwTVN1WTY1UWRpVlF3?=
 =?utf-8?B?V3VSbFUyR1J1SlBjL0J5UEJZdFN5dlU1Y0xzMUx3N0EwMExKZjZaWjU2ZUFq?=
 =?utf-8?B?Nk9qSG1OT2s2elV2WWRDWFZnTXJ2Q1g5b0d1SGYyMlNXN3NUSDgySkFMUzk4?=
 =?utf-8?B?RWZVSUJIR0xvbm5IL0Q5cWFITkQ3UGR4QkQwcGNhaUt5YXo1UVpMZDhMaVhF?=
 =?utf-8?B?Vkt3SEpQYW5uUWJ1SXpjRkljYmlJbjVoWlU0ZngraStCb245cGFqaU1Ib0ZU?=
 =?utf-8?B?dk9UQnZFRmtQN2VWYVY2SnJmSkZJdDhwY0RscmphSlc2VG50aEJTZGo0c0w1?=
 =?utf-8?B?N2VmTTVHVUJDMFpicFJjaTBPWlFlbDh3blU3ajR0ZlVDNEc5QUVBZy9YVko4?=
 =?utf-8?B?Rk83U2FhbUg0S3JCY3FWUE1iQmtiZHNMTGw5TWowUndhL3laRDFuYlBBV0hn?=
 =?utf-8?B?S1pkNlFZbHR5OW5xVm1mMTVGQjhUQ1A2M1lqc2RRRTR0aklvb0lvWEhDRXVC?=
 =?utf-8?B?NE5CV3VLVVQ3dGtZVVNtdVgyRFAxemRMWnRmWm83RTRZZ2Z2M1ZSUmdlQXZV?=
 =?utf-8?B?UWVTR0NIb0dtK1BINzhKbmFQeWFFeld4OW40V1RYR1g5bnk5S0J3clEyZVNX?=
 =?utf-8?B?dFJPbHduNjE5bFpnZXhZWS9FcFhybVFMcXpac3RKZ2E1bmtHL21TOUNtMnNG?=
 =?utf-8?B?cjc2bTM5ZFJ3QkxrWXN6QStRVWN4eFJpZklzdTRPeTI4TG93Y1BFbzBkT29i?=
 =?utf-8?B?V3FrbHEvWExtaktRWCsrcktVZFk2RFNKbHdLWGxuRGVRT3VRTy85cWpQTWc3?=
 =?utf-8?B?aFhsZmx4dGZscFg2T0cxamwwWS81bWVCOWFtNHRGdFQ2K2wwK1NlNWQwbEdr?=
 =?utf-8?B?M2xmSk02Y045dzlUR3UwRGZ2MFpHME9FUzdtVUt5WERTdjBsQm83QUxFTC9C?=
 =?utf-8?B?WHpUMXdYOGFvcW4wOGM1cG0raHY5VEJwNXJON05MZUtrb0QvSWhQeG51d001?=
 =?utf-8?B?ZDhmZXYweC9pMy9kYTgyWFRadTVBVCtBL3JWWmtKRkFCUWFUUVArcmtySFpG?=
 =?utf-8?B?MjY0a2dPV05YZUk5c2psYytDY1czR0FBSkRDM3lYVDVnQlBEM0N4dFhkVm1x?=
 =?utf-8?B?c1NRYjVXTDZEVW1QNHlhMk1xZG9UazVzT2o2b1hpOGpVYzNyTXRqN0NiSjlo?=
 =?utf-8?B?Yi9CNHczaEU4M09ic2QxUGVzMmZMRUE1T0lEd0U1Q1k1dzB0dTllSGlDOVlj?=
 =?utf-8?B?TnNvOHZpYXdiVTJiVG9oQ1BxY21ybzJrdDdTamNjTENxanliYWwrUzluM3FS?=
 =?utf-8?B?L016eStiU3psRXlxY1BDNS9GVUN1c3J5WjREeW9rYVh3VUtNOHZOdWRXK3Bu?=
 =?utf-8?B?U0swa2FFT29kUGVyT1VFMFI5MVVEL1BFVmhFVmxkck83N3dYVk1XaGEwWDEv?=
 =?utf-8?B?aGhKOVNKMGVlQUowMWpUZW53VFVEd0taY0UwckhtZk43VG1udExtSGwvbHhD?=
 =?utf-8?B?ZDdsRys3VnFvWHF4NVFQNlcxdmE2dngyWTlWQTc3TnpoVGZXaWdGdVlVT1Z0?=
 =?utf-8?B?aTZoNlQ3SHV2ZVVmb3FOaEtVTHNBNHRVV0wyaUQwYmpmYzkwUldtQnYvWnRq?=
 =?utf-8?B?N25STEg4MlljaXlkVDFNTEhYTEpncFpBcy9iZE4yVUU0WjkrdlpLZTlOR2x2?=
 =?utf-8?B?WnBYM0tRWnhjeWh4elZ3Znl6NXRZVTdPWTVubkdzL0QxeG5KSVFwQ2RpTGFq?=
 =?utf-8?B?V3lnazJVYjNvSm45Y29yZTBETTRtWGhXb3VjdWNubDN0ZWNFTmRFWHlDM0Nk?=
 =?utf-8?B?M0RDaElpdmlQK0F4d29IeXYzTTYxUnY4MjNQS3lNbGdGRDFjd2pmS2tlN05I?=
 =?utf-8?B?ajVGWnplNXR6aTNhUWtmVmJoTzJuREpkbzVBMFFhWG1URUpBNUhiYTFVSW95?=
 =?utf-8?Q?y+LNiYHSr+G1IpCkAo6Vxzk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb341ff3-ef51-491e-5198-08dd40763c2d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:04:31.7634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzA4IkvyqS4EGjv9NIk/WLN98heBoJpG8NsIds1MoU9Fsl+TR4GauQLcq/T7Q58aZeOnXgmafVkWDW7d/h3JvhAF62NvsjXaPBE/h5DvruU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10641
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

Hi Marek,

On 1/18/25 12:15 PM, Marek Vasut wrote:
> Introduce common weak board_early_init_f() in rcar64-common.c
> which is the default implementation in case there is no other
> board specific board_early_init_f(). Remove board_early_init_f()
> from Salvator-X, ULCB and Draak boards where this function is
> empty.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
