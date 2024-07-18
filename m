Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C0FC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F90D88A3A;
	Thu, 18 Jul 2024 10:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O3RRXSwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6479988AE8; Thu, 18 Jul 2024 10:03:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE9F8818B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbM8teD/u0ZXn/qPLfmbtUH1vaoktH3QTd0bjRVjeGfKnDShM013gKiF5IiX+eI8LXVEGX2uuI8nZ6j0YYLSLodJ4ahMFz24wvgSoHYyxBRRckwXcGtamdmxcchLWr/moQnzBRowkEiYgoKq3z2fVQdgbg71deS9W3OgyM+TL/NPWq8M3f6aXyejF8Gbv3ZCqwg6qD3EFNRGfzVAjeB6qJbfSwtIFycsJ4ZDTlRQY5KIswjlAH6NPri9rkK/UWzqmzPydr8O8fYjHRgVtFUw2N/a0nstn14HH/kGT73AyoBE+7zWmAZeLeVDV99+hRmmsZuKiGmnvCLnYpBf2Ek5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/vZEP9kyRR6kD8Vexr6tKf5bIhuYXri8YAfZd4kcTE=;
 b=lseDEbJDylQ1ZQifCxyZcj77KyeLBTeoKFGEvf9Q2aFA5z1YB1ljlvNRWG+UQWIGjBwSo+UEk0Jlotl1a6Kmj3ZQNn+JwIAiDJOmN2O5EyeoigB5qb/cemL/0pZdl75yiadoxa2gVhbR6dJebNbbyNBfo/astpghmdHmCxCI0vsF4IDY/yczkoLwg3L5vjwduoea3PhB3V7EVftZ09E27hnu15qX0YLsZABS9t9Q/IotzkNj5Jhlvposo2p163fdATBrDo2MHBSj6cIhuEg1gu7IrUFgAJ1f5OJVXlm16+RRA5CEM7e5mbP2PYb7uFoQz5ZijRZQpP6vzMaa8ikQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/vZEP9kyRR6kD8Vexr6tKf5bIhuYXri8YAfZd4kcTE=;
 b=O3RRXSwPyQd4VKehmfMXWYyN9zzv/N3zKehJ6l+PmEUDpA7LfukcWt+IELcJojKecTxErk12UOC6pMeNRMRa2QeJc+oxbJ5xf/IcU981kxM7y3/6X7TuVXokl6t95zZBCKvG/ESZ1wDyZY9FKxIuRitVKf4UQ3dGj8viVwlcXks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10213.eurprd04.prod.outlook.com (2603:10a6:102:401::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 08:03:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 08:03:51 +0000
Message-ID: <fd320bf7-1296-490b-9441-83ac4ccb8182@cherry.de>
Date: Thu, 18 Jul 2024 10:03:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-rockchip-20240614
To: Kever Yang <kever.yang@rock-chips.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20240718035200.394004-1-kever.yang@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240718035200.394004-1-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10213:EE_
X-MS-Office365-Filtering-Correlation-Id: 9609ea9c-7d1a-4f7b-e8c1-08dca70028ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGRoelRpMm1iY1ovUEgwNmJ3UCs1VG51a2Mxa2dTK2YzWUV2NzdYb0hScHJq?=
 =?utf-8?B?cmNNcmpvbUN3cjVxVERGQ3ptdlRtdWZwUHJiMGNXSnVMYWNnZVpsVmpSaC83?=
 =?utf-8?B?VUxCNlJGdk55RDl3R3pMSDRBM3ZSL2hpYjJhdWZoaHFLMThiY0puc2RoUXJZ?=
 =?utf-8?B?K3ZlY0tIYUhBTGNiR1BTNHFwOHhWUGM0bnZHZXE2Vm5nYWpnTFNrTWN2MXJD?=
 =?utf-8?B?dzFOQ0ZSRFNGdlpReWU4aExweFgxM244K1hjbFk4em5DbENCNi9ERFgwREo3?=
 =?utf-8?B?Y2NoeXBUS3hvVlhrSnVHS1B0czhyRjNPRmcweUhiWk1JbkNjdXhRejdrdVpC?=
 =?utf-8?B?a1MySlV0dDJBWFQ4aWYxVjYwWnRCcXlPNVRqdW1iV1dnZWY1d0Y3cHo0SGdI?=
 =?utf-8?B?MmlOTmFzb3RnQ3VlM2puQ3VRRmI3OGNuUWYvMnFpcCsxdGdkR1QxNkdiaERV?=
 =?utf-8?B?a3NoQjFiR0pOSGJqRU15TFlXNTdxSzkxSHU1dDZBbGhrVk1YaHVPaEhRZ1lu?=
 =?utf-8?B?UHdRRUdLWlBseUd4RytmTHZZT09NTmRVMTA3cWNaS0FyODNHVUFCbGNIRVdr?=
 =?utf-8?B?aVJEM1Q2YlJPV1BlemRvZE9rSTJLd29PelhtS2RydEIvb3lTNjFFMlhnaWVl?=
 =?utf-8?B?NWl1MVEyTmRFUkFwWE5PbVBON0dncUFqWllhejhSL1BYVnp2ZTl0eEJTUWtJ?=
 =?utf-8?B?d3ZvT2xiN3F3OGRCSDZCZmNUOUgzVEVVK2M3VmMxeGE5TUErU1dIQXBIMEJ2?=
 =?utf-8?B?eGJTVjhnSnNaYWtMUmZnbmhVd2gvK1owWTkzcGluME9HUDRQcXQxQUI5eWly?=
 =?utf-8?B?WVBSY1Y4YWtKT3d6Z3NPRGtEVEZVdDVIaUsrWFE3cmN3TCtRNzk2M0JiaWN5?=
 =?utf-8?B?STg3OXRWR1NEcjdIZjZSVVBqYktnbXozSE40cUM5L3BBdXVFaTV6TXhSci94?=
 =?utf-8?B?VXNIWWpQeGFxZ1pDYVNUZjNQeXovelBQUkp3RWdrTkwzdjdmV1k5b1JZTERx?=
 =?utf-8?B?VXVCcm9kMUMrRFMrelFxT0Fja0NHWlZqQkhLbkhIZlNVMHdUQlpTZEsrSnk5?=
 =?utf-8?B?QTFSYmo3UmJVdUdaT0dnN2tuRmV6Tmk2cFpheUVzYWlvZmc0YWV1cmxqWU42?=
 =?utf-8?B?REVvVmRBckdMMThwd1lld1BmMlJvRHZMY2ZGaHY4d0FUNEkzbmJHWUcrcGli?=
 =?utf-8?B?QVJyTFpLS1Y4SVRrUmlFUnByN0ZYbGZpYytCRDhRSTFkTVJYc3ZqZTdUbzRT?=
 =?utf-8?B?ZGRIVW1QZzczREkxK0JCQ0hWbGc1dk0xcG1uc3BUM1pEbTU2QlMwSnBaT2xx?=
 =?utf-8?B?NHNWa21tYjJUckY2V0svT2Z4MXNzd3hkM1ZubU1UWndOVlNkeEtGbzc2ZVVx?=
 =?utf-8?B?dTdjT005aVFCUk1MT2FtRStiZlB2WnhpWW0vbC9HbjdEL25UVDVqWkNEaVR1?=
 =?utf-8?B?Tm1NTjhxR0sxSGk4S1V3djVtbTdNYjlHeExwa2lrd1gwY0Y4b0ZWUTJIaEtn?=
 =?utf-8?B?Y1lvZk5zTWJsUUwrdXdFUEJaVWtJMXFseUpTSmw3aHpicUQ1MFVoVGdJOXov?=
 =?utf-8?B?RVdzdjNQRmxKcHEzV2Y0NFZPN1VkTU8xOEsrS0E2NXpyQ3F6SmNKK2FhU1dU?=
 =?utf-8?B?ci9vNkVVcTFSYWh0Z01LM2FudmRpcjJkS0VldVUwaW1nNU5LaER0c0lJcTJR?=
 =?utf-8?B?UFY1ckhodERZcVpGeExWTTBtYzU4WFFPbC9EQ0N3UitMbmY1MU1jZjJ1Q0hh?=
 =?utf-8?B?UUNkdmJKSWQ5RnFpNXdSU0NiRDhMV2tiTUdFWUlRc2I0bVpwRmtJZWFYZ25j?=
 =?utf-8?B?ZHhtaUYwS01JL1FyNmdNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNzUGduZlVqNFk3Z3lNRDNDZE9LRWZkMWRKeWJ6N0RoU0xoTXpoeVV5OU1r?=
 =?utf-8?B?ck10VUVuaUhFajlBVTV0VjU5QlpUVjd3c25QY3krd2lzaXdmeVZVOGFvVHdt?=
 =?utf-8?B?Rkxkb3dMeW1sNHRHRFc4Z0dYWlRCQTJTYURlaUNWMkw5Q0w1WEVkVTJURmJP?=
 =?utf-8?B?eGRtRXgrWWExdGhZQWdjQXQ3UW95VlN6Y0FRazYrR01qVjRHVW9vV3B5aElZ?=
 =?utf-8?B?NDFIMWlKQk1zWkxSLzkrZ0xwbXNjczlLeFoyQVhCeGhxbkJCeStUdTdkeFk3?=
 =?utf-8?B?SkdhR05id1ZrR3dQcVlvQjNONVJaREdEbzYrOGZGUlNPZjNUaUlVWVRZMTVo?=
 =?utf-8?B?a0RFMitiSkd2eWxDTGF2U0krZkdBY2FLS3QvRE82SHRYTFNkTlJudkVRTWdM?=
 =?utf-8?B?RU90Yk9pd0FMTEJDYjRYZlZTUnRlNUErSS80Wi83L09OaCtCM2tjTXZqYnhX?=
 =?utf-8?B?SytDVjNSd0ZJVm5UaFByQkxZUzI1UEJleW5GSFJodzdTRkw5Mk1CSlVOL1VS?=
 =?utf-8?B?Y25VODJ4VmZPUTdrSkRTbDJRV2dUcnNUQ3lJNUxCTmlYNGZPMlY0RDVxbENQ?=
 =?utf-8?B?a0lmc2NxenRvd0xQSzdqVXdRQ3Y3UkllR0JTSEJlVDJrSEV2VUtRTWo2dlNy?=
 =?utf-8?B?YjlyTDQwcjMyck1Gc1RoT2ZiKy9qTWdvSkN2eU0wdDloVnM0RHZ5QUJMcHFi?=
 =?utf-8?B?L28rY21WMjAwY1RaWFZ2YUh0K2txM2U0UlpTUnd2Zm9PMzF6MDBwUGkyeUlK?=
 =?utf-8?B?UnRydWlqZEltWVJ5V05EV3M2TlJmVlVibDQxa1p4K0VTenoxT210VFhycU1O?=
 =?utf-8?B?SlhoRlFJNHFYdU5Dc2pzK1hHWmdxbFFRWkF3UHI5TFI5M2pIY3FEbEFaeHRH?=
 =?utf-8?B?MUx2bGZ4M2V6Y1YvZFUvMjRLU2IrbG5JNzhnajRibkt0SmRNZXNuWkU2RDBS?=
 =?utf-8?B?TGpFdktEbkttMWhVU1Z3VFc4WVJGakNpT3drV2xCU1lXNDRob3k2SHNTZkk3?=
 =?utf-8?B?eUVhTjBlTG5EbEorT2VFSi96RWlQVWRVY0t0TStSbU9JYVp2eFVKNDVoT2tU?=
 =?utf-8?B?c0hOcTUrTEUzWE9rcjlQM1ZWSS94eDJveTNOR1RxNys0RTJxTjZ5K0djbmFK?=
 =?utf-8?B?N2NOWURCek1hWFhPQ1FldURjV0Jxam1QeDQzN21sbjYzeGxUK0MrOWdXRi94?=
 =?utf-8?B?MWIzRVBOdFB6RU1IWUVrMlRWU2VxN2ROQjhMRlZNNTVjdGtZWG8rK3UvU3pC?=
 =?utf-8?B?RVloeEdTbkg3VUdjdEZpSEtpZWQwVmw2cU1XVkVSYmFwYk5yb2tjQll0U2E0?=
 =?utf-8?B?WFNPMU1oM2FjTFp1bnBha0R6SXBwUTB5TXhwY0tjRDBWQjYxSXRab3l3UmR2?=
 =?utf-8?B?RGN1MElGd1dpUW9FMlg0UTJMVFZFSUJCL2UrcGhkaG5aMTdQalNpalNicUpI?=
 =?utf-8?B?SlNvdDREcUFBUmFmWmYrdTRaRm4yMkNvcWFVazJpU2w3MjQ5WWxnOE9aL0U0?=
 =?utf-8?B?WTk2QkNMOE4wMm5jWDFybkplQ3JQUEVqZFkvWXd2bDMrU1RTOStKZGdHakx0?=
 =?utf-8?B?VXNLRGptVWJRMHhGbGlwaFV2dUgydlZsdWMxTmw1N2lNNWxySE1ZRm5rd0lC?=
 =?utf-8?B?VXk5ZWQvVlJSQ1g2KzltRDdYOFd6WmxydGRnUmpVVXVpRzJuV1pGNHkyWUxF?=
 =?utf-8?B?U2VheGxpWEFIV2llQkZBcCtQRjNQTzBGZmdDR2FsaDlTQkpqS09vRjZpRTJ2?=
 =?utf-8?B?VncxQ3c2RUNCVkNKYTZkdXRnaDIrZVpFQzlwRU9VTUhUUlFQK2czSXlRTFZ0?=
 =?utf-8?B?SWhDQThtNHZZV0poTVJraHdUSlhwWDJGbm10S0w4QTkzc05maEFmSHNxb21K?=
 =?utf-8?B?M2VJdnIxMUNxQXNhdXJmcEdZMkw4QnYvbVVUQnpuWEZVTlphZ1N3eG5HQjY5?=
 =?utf-8?B?UlJTR1lZL1h2Zi8xckJ0SzIwaGQ0VVkrclJPcFc4YVd4UDltM2RPcmdYalJ4?=
 =?utf-8?B?SURHYzd5Nmp0Q0pQZFJ0ejRlNFBBVS9zUWQ4N1dMYm9LQTRUZXluemlvVkdn?=
 =?utf-8?B?N1gwY2U0T0Z4TEgwOFY0VkJzSjNCbXhybVV1NUtJK1hIVDlzQ1Eyb1R0c2Er?=
 =?utf-8?B?bThJVHV3SEhJekdBL0s3bzMwV0J6MDhGS0gwVzd1ZDBBcDlEN3dNUG9vcVVN?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9609ea9c-7d1a-4f7b-e8c1-08dca70028ee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 08:03:51.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swZa83ZYoHRtP/zpWda80THYehx00zDbX0YSucej1FfRAqzHEcxE8y/5VN+RI7QKLoq4Po9f6+bO+W6M2VMHOblENDRIaNGVw77UQTrw8PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10213
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

Hi Kever,

On 7/18/24 5:52 AM, Kever Yang wrote:
> Hi Tom,
> 
> Please pull the fixex for rockchip platform:
> - pmic fix for rk8xx;
> - pinctrl fix for rk3188/rv1126/rk3588;
> - mkimage fix for rockcihp "-l" option;
> 

I think this is a mistake? All commits are already merged. I assume you 
picked the wrong tag when opening the MR?

Cheers,
Quentin
