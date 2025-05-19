Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E71C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 15:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D42382B7E;
	Mon, 19 May 2025 17:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="L05PLiu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C316182B81; Mon, 19 May 2025 17:09:12 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6554481FFC
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 17:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akZ0K2+7oJ1DTk8lzYJ0FDXhwIIy5zEp1Jh0F8ofSzgzVpnmr89WiOfOx42wrDPIccUtQfaemE3yR5K1UMg1huS60DRmJ+akcLbJZ0tHJ1hpmwVRXYQJPZncirNr9s9AR7ZxKcN4uKkL93LZ3tflpdyUhf4rAxHeai8lcIfocwK8bwhuzlC8Ls6cNbHnZ8fsHoQLYOXgzufq0kH+xmwFO6y2WSrDUU+wrK6agQxhJgkolpVQlPe+48zcV/3XmzoX9qCxpfh1iTzINYFpvnvnOtc+kYSkIooeL9CbU4uLgn9f4ZbLXo1Hy5nYJZeUMllAMvNELI8uOPF3u95P4iOAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeEQwSlOAa3+Ppo9Rnpi2RXgTbeVfzgL7S5wnGwbo6g=;
 b=r9pHcb0SgllTb5LSQML4HJc00vvN/W+tL5nT8RZhKpeRdvPb4SU/4iOJImEAxa/IOOxsR+XRI1uOWnlzBbRf7QZOSrX7R0BVo5rplyEqnrDrPEyKjbkYOtKUudrF/86uNY4aViyBsrXT9BHuUejvy011ck5WVpdWdCAwrCgFW721U5sffjeF+EjM+pfU67ZT65LHK8/zL4jLbHukLfrxrJ3mu/jmvdZKSIDtZRIfgPMZT3ElsqCuKAxkEWpoHXHOMIDKQ3gpDb/LHHxA5n1FBLdAA6QtLBO3cXNMHlRfNn5mOoMgPPOzd0YHS60K7Rv49KUL2Rju9xNICWCKzjGwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeEQwSlOAa3+Ppo9Rnpi2RXgTbeVfzgL7S5wnGwbo6g=;
 b=L05PLiu8m5XSGTkvkv+lwRZ49Eospc2B66VYgwvrqxFHbWaSachURslxeXUB5u7MPJhyOHSeSewpX0iBJD7nJp6eJJDNdFZe8NSmb5ez92DDDD/7XDir+Vyxsi1jxgqQv69qkt3cyzKqeiSV3UwenM9B9W/RBw3FRgMFUsmi4V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10603.eurprd04.prod.outlook.com (2603:10a6:102:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:09:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:09:08 +0000
Message-ID: <c90e00c2-ffea-4221-92a5-2cc8e1923dc8@cherry.de>
Date: Mon, 19 May 2025 17:09:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
To: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
 <20250519144835.GB3396848@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250519144835.GB3396848@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10603:EE_
X-MS-Office365-Filtering-Correlation-Id: ab94e834-dd95-4613-445f-08dd96e71a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1h4aGMwN3ZKSDZsUVloc3pkdVZZL3RRalUrVnVFTmh2cURqbC81OS9DM2I3?=
 =?utf-8?B?Z3h2eU56OThGTkpIdFp5blZzRXRVV0czdC9xWWdmZTAwRzBEbksybEJNYXJr?=
 =?utf-8?B?ZFJpUWNCL05STGNSd2QwbklIZWZMM2U5NDJzR2drVU5ZT3AwSC91T1RNRHJE?=
 =?utf-8?B?R0JBbmNRM0FUa1hIcDU5WXp0UEE5ajE5V2QxeDFDVDd1bWZtaitaR0dOV2RO?=
 =?utf-8?B?Qm5pRWgwd2VBUWx3U09GVjVIY0puV050Q3NxZkpxbVpyenNITExXM2VwU245?=
 =?utf-8?B?TkV2Y1R1UTNpTVZUcDE3bERoQ2M3eUZKNjdHMWEvQWViU0NTV2ZWb2xLNlNB?=
 =?utf-8?B?R3FyT3EvUnZtbnZLNzNjSmFjN1NqcFpEZEd3elY1Z2hLbkZHU0NTaWtkcHND?=
 =?utf-8?B?SjdnbEZkam15RFhGWm1adkU3MUdWVFVkL2dabXUyTDl4SGhnakRIck5kMXh0?=
 =?utf-8?B?RHpmQ1o5UW1FUzRwTXgxTVhXWXVEcEVIckJEd0NNZ2p2SmZSQkZwc1d4TWFH?=
 =?utf-8?B?cDVyTDJkVVBBbm1CME83RUV4NWtrRVQvYW5jR25BZ3RmVGFsUG9VM3l4VVJR?=
 =?utf-8?B?VTBXSGZ1bmRyMHZyc2V5bW9vNmplRWpmQlhWMVhsMUZHWVZmZ1dOL1ZnZWpC?=
 =?utf-8?B?eFRJRGN3NWphNVludVdwcmZWTmFwR1hEV3FPRXhmVnJuOWkxZnhqRW82RENG?=
 =?utf-8?B?Y2gxWkZzVWpxWWV0cHBrVHVGaFhrOFFHM1U2b0JlbzVyVlNvL2liajFTVVpU?=
 =?utf-8?B?OEIzdlRjV2k4bnJVMldObnRKdUJwMjM0YUJQMWJaWGZJTEZURlZYQTZpcGhV?=
 =?utf-8?B?UG5iWnkzaXdQZjJwRy9JeEJiVFh6UEgwSGtobEdrR3E5UkJkQnYvWCt1c3Nx?=
 =?utf-8?B?TGsrNUhyQVE2d2RmeUp1WERNSzNWRm03MWpqeUhxbW15dlhzY3JpbEJ5S3JC?=
 =?utf-8?B?bU5TYnNxc2tsVzlEcGNrTndaaTZwN0ZiTnNHc2RMcVI4U2x2YktKMG1IUm9D?=
 =?utf-8?B?azBsOFhuZW9wRDB5V1drL3hRNTZCTjQ2QjVYYndEc0tTUURwTnZaMjRkd3Nh?=
 =?utf-8?B?SVN0N0dtT0trUEZIMzljMGZHUGdXSVArNWdiNFRBZTMwK2ErWHJ2L3dzYUdm?=
 =?utf-8?B?a2svMitnb2YxUU9OL3dkVkdFKy9jdHlrK3F3N2JmRE8vNG51OUN1WGpQUnVN?=
 =?utf-8?B?b3NDR1M5V3Y3RWw2TCt0OWF5U2VNOXRiU05Jcy9mRFo4dytFTEtRRFFHVnEr?=
 =?utf-8?B?NDVPZmdNQ3NBUkZ1cjBNazRmaUJlcWdpYTFnMmZaeUx6V2luenVUS1Byem8x?=
 =?utf-8?B?V3NuUnF3OEdsQk9WbllXTXVWU1AvMmlIazM2QmJwU3ZvL05MWnpla1VnM00z?=
 =?utf-8?B?bkVNdHN4Y0VIdEU3ekFFSHlIdHd4WG0wT0U0MnRaajFjYmltaG0yZnkyTHo2?=
 =?utf-8?B?dVhzTWk3ZmFBWWk4K3BzQmVvN1hINkIyRFRQbTE4SWwwV2pWZUNZYm1mQ0Fo?=
 =?utf-8?B?QWpoUElHSUo2aVpXZmF5U09sQWRNTzZyMkNJUkJxWXBlZGRHSjdZTUtjaHFi?=
 =?utf-8?B?Z0VOR0ZlNXY4Uy82aVFIeExjbEtvQVkvTFBUZTFUVzErb2QrTEttZG5MK1pM?=
 =?utf-8?B?RmxDNThhUWYrbDM3aVJxaHN3UkVqTFhjWHFhd3luS0ZJQ0s4NVZZWUZHdmhZ?=
 =?utf-8?B?TlBCMkMxVzROUVFvdWVaNHpoZmRIS1BhOHplUlFwUTYwWVNEU29CWG5PLzN4?=
 =?utf-8?B?a2FnSjFHc3doektjNmdZWlBxSUJoTGl4Q3R6Nis4aldzOVpBa2hic1dXVUZG?=
 =?utf-8?B?L0FWWEljT25DTVpsNG9jc2w3UTF2R3dGZWRzcy9HUFNETGZqTFlmazA0ekFQ?=
 =?utf-8?B?SW85U3dMT0YxandpQnEzcGgyL1JKQ21UKzdiR2hGRjd0R2R5cko5NWZOTFFr?=
 =?utf-8?Q?s7YsLhiCwUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFpWVpSeEVZcWdVbWxkQXNFa0hTTHhWc0NWSFpBNmVOOEdoRHVKVXFWVGNi?=
 =?utf-8?B?ekxIUzlYZjhtRFVmZ2kwSENPblBjMGU3SUJqNGpPelVVZmlrWUdlbVVnWXhW?=
 =?utf-8?B?SEZKdm8rZWlFcGJVT0lXeDdWWmwwZXU4VWZreUlVU3U4YUx3MVl6QUlBbCt1?=
 =?utf-8?B?N3VXbzJKU0RmNkhCUTV2MGpCZ1p2QTRESWdkRzF0QkI4R1Z5ZzR1MHl5RFl5?=
 =?utf-8?B?YmU1Vk1sT2kvcXVBdmRJczVBbWVVdUQxWDczalBwRThxKzlZdHNWdk9iaCt3?=
 =?utf-8?B?b1RlUEZUMXArN3A4bTRYS1dQZ2ZHaDVMMDJYR3RpaXdjakx3U081UnF4b0lh?=
 =?utf-8?B?aGJwQ0RYUmMraDdxYlpVL0NZd0NjUkhsUjkva3ZidjlrblhWYmp5d3d6WnAx?=
 =?utf-8?B?NVpNZEFUQS9naHd5WHhYL3F2M3hPYjRCQXIvTldyYVZITnRRa2xEaWJlL2g0?=
 =?utf-8?B?Q00wQWZySk1LT3g4bDhXVjAvcjE5cnRrQ2Qrc21Qc0gvUENnN0N0eUg1Mkpl?=
 =?utf-8?B?UG9EanpEcllnaHRkd2Z5UXQ0MjNnbFNWRWYzV2IyMHFtYjQwZmNvWHFvWjQ0?=
 =?utf-8?B?N3p4V0V4RzBUNjBrV0tIcXBhc0k2RWhFNjhDYzd2OHVJYWtYR0VXd3R2RXBR?=
 =?utf-8?B?Q3BvUFdDbldsS1g3Q2VzN045cjNIYVlKT2J2NThuU05xNWphLzJkcjJRTzBI?=
 =?utf-8?B?YkJEaGl0MVBwdjlqVTRSc0R1Qmg5YUZzUXBYS1Z5VWdTaVNWdkFta2c4ZGhB?=
 =?utf-8?B?ZkZ2Qnl5djFkaE9vMmJGNjZTWEtNT1l5aExxMC96Y050UkVmSjdsaW5PRmVH?=
 =?utf-8?B?QUJMcDMvU081M255cTdSNUhRNU1iWUJSbFBzMXJ2bTBId3pqYUN1dkN0OGow?=
 =?utf-8?B?SkpKTmR4Lzl0VnFSQVBPSTZ2c2tTN3ZJRjFrUFBOWjNsRDhJNys0U1RuUUZ0?=
 =?utf-8?B?OXpKRnA0U3gzN3FOMUZkT09OR1U5RVpRTHNmdENQMjQ2WUtoQ21NV3Y2eFND?=
 =?utf-8?B?d3Z3d2l0UVlMeGVFT1VJR09USDVFOWpnWXp2UDRoSzNSY01NN0I4c1Uxa1Rr?=
 =?utf-8?B?NWt6Ri9nSVFNanJjSWRTYkxTVmdpVnM0QVo5RlUyY2ZWd1RsbnVSd0tTT0x4?=
 =?utf-8?B?RDZENXduOGYrTUtWSnJaQktQeFdLTDRma3g0RU92VHhTMVZ5NUF1Wm1FSDRG?=
 =?utf-8?B?SXBWeXlnNlhYekRrcnl6ODdsTERUZ2lQVGplQUdyZWp4RWRBaVFyL2ZESEFC?=
 =?utf-8?B?VURUMm1JTmwwZExFa0RsOGVmMFgwbFBZQ0RMVCtlajBvNVRHTjU3N0oydnJM?=
 =?utf-8?B?UkpONUJuaVpCNGE1SC9nQVQxZHoyTWlNbXVaTGZ0RExEMnJJdjdqRW5GZmV2?=
 =?utf-8?B?b3p6anJRK1NKY1hNaGxsRDBHUUZFTXRwa3JQRzVOb3J3Zk14VFBqcUNxZ3I0?=
 =?utf-8?B?a1VvbGhJMzN2a1dmODRUMVFoVCt1M2lEZDlYamRmVVlTM1BlcGhPLzl2UEEy?=
 =?utf-8?B?MWhxaHJjOVllSUlrNU5lR1RjRFdtQlJvV1hBdkFEcEJPbzdpUTBkZFBWTVF2?=
 =?utf-8?B?YUp1a29IOEFpdjBicW8vRmNlWmsrMUpCYWFkdWtRNFdRR1E0VFgzN3cxUkRx?=
 =?utf-8?B?Z09vczc2czNGM0llMHVjclhlOEtXNlJWWDc1NWM2SUtjcDgyQldzVXdwRnl1?=
 =?utf-8?B?UXFUVk91NFNteWZ2Q1phM1dpVzUyYVJocUpKNVRaYWlOOEJEUlg0NWZvMnEx?=
 =?utf-8?B?cm1yYkgvMC8wV2k5K1VzSm1KMVZtVmFxeHNCZWgrb3F0dDV3eXRnZzlBRUIx?=
 =?utf-8?B?Q1BnSXVwcjB4amZaS3dNVWQ1OG82M3NEYkh6YUNwa2xWSC80cG1CTXE3VHg2?=
 =?utf-8?B?VEZ6NSsrZlhHNUwyaG9scjIrd1BnV2cxdEJPWmxPaVYxdFRmYXVWMHhYMFg0?=
 =?utf-8?B?dE1LYU14R3NSRnVEbTVVLzh0YVhpeW9NSFNMMThQMXRYdmV2S3phTHcvUUtX?=
 =?utf-8?B?Ykd2dE9jYUZEOUVpL3FXNXhmWGRYUW41b1pBWGNaV2JBcnJhaFgyOE9kV3cv?=
 =?utf-8?B?d1ZmeEVtS3VYRk9YeE1LMkc3K0VOcFo3UTBYa3F6VzFsRWk5UnlYZDVWSndV?=
 =?utf-8?B?by9Bb0Q1Z1RFMWtlM0dIaDJKTks1RzJuOExTQWJkYnllL2tna0JWTG9GRkkz?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ab94e834-dd95-4613-445f-08dd96e71a66
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:09:08.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH09JpSWebAznEbg6/FdyR9qXB6AUz04ouucc2CHdbw5YyAap37iDVjcmxawGTCFf++a4InBlxWvJ7SeDEUFFjDWlNoC5racWJmU8Tqp0R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603
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

Hi Tom,

On 5/19/25 4:48 PM, Tom Rini wrote:
> On Thu, May 15, 2025 at 05:55:44PM +0200, Lukasz Czechowski wrote:
>> Initialize the debug uart only in case CONFIG_DEBUG_UART is
>> enabled. The _debug_uart_putc is used internally by debug uart
>> functions, so it must be also included inside #ifdef block,
>> otherwise it will cause compilation warnings.
>>
>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>> ---
>>   lib/efi/efi_stub.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
>> index 40fc29d9adf7..5172cd78a7c0 100644
>> --- a/lib/efi/efi_stub.c
>> +++ b/lib/efi/efi_stub.c
>> @@ -83,12 +83,14 @@ void puts(const char *str)
>>   		putc(*str++);
>>   }
>>   
>> +#ifdef CONFIG_DEBUG_UART
>>   static void _debug_uart_putc(int ch)
>>   {
>>   	putc(ch);
>>   }
>>   
>>   DEBUG_UART_FUNCS
>> +#endif
>>   
>>   void *memcpy(void *dest, const void *src, size_t size)
>>   {
> 
> I notice that this, and the uniphier implementations are the only
> non-inline ones. Is the problem we later conflict with your changes,
> perhaps because this wasn't marked inline? Thanks.
> 

https://lore.kernel.org/u-boot/d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com/

so essentially

lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
used [-Werror=unused-function]
    86 | static void _debug_uart_putc(int ch)

I tested by adding inline and indeed it fixes the warning.

Somehow the non-inlined _debug_uart_init doesn't seem to be triggering 
any warning though.

Would you recommend to inline the _debug_uart_putc function instead of 
guarding the whole thing with ifdefery?

Cheers,
Quentin
