Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414DFC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94AF1887F3;
	Mon, 15 Jul 2024 16:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eyjGWHr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B347388874; Mon, 15 Jul 2024 16:14:29 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D094887B84
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8Lki6+DKzDMgY1p60Gxj8NtND/QRlDYa/mTN3uInt/9A9hRCCjuHfmedmyzZRNxce9zUrj/EuHzJCl9BVkIIW7JwB0WFTVesKxFY/fqP5qrTjV7454ee9aghG6SpvFN42HCDeXNFbPgs0hjCmqGzSvc6tw3/67FVVyEqoYuc41dv9DUn6Yb9uqiZLyCMBn7xtUgTSJXOxC5nRLw4e9QmX/P0GE3HhQsCoOw/m7sJ+n97XR7pTkXeQSUMZhkjXBKnBzbX5Zdhr13JlOo98SvF1p9ZDLHiOO6x7tw60leX1d52NQUfZ48D0nXjoOQ8cDaG9JA33Eq7oAqaS9BUXIVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+wcPK0acAJdooWFO7HZRZbls4cFQ1UsbWo/sWuQeVI=;
 b=o2PrCiTYR0AxuxUv0Qvt9+s6pKAW6bwQMgqW6V1/UdrJghdQiVXv7vESygcJatpz9TrtLImt5LUGHbJvdVm9ID0pCd7QwXd4a76ezHJktNP25MwaLBKRZH6sXI+i8OVqXm136gKgUd6UomexaccoE1cZRu19faOE94Y3uvEvtZHrXaQ006oNxK54Zq380HEsjeCZZ6qsRH9lJK+l4J47N0AY+O4tMLzJl8mgImd6CUIk048id55491+wQ+UdK8YCbDJ00dVrJDehVbriDxx4D0p8J5aWYpTq/dOSrKuoUdtes2zdSOXaIefIpJFAWozk/Rk1JrPthNt4W8kYp4ydfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+wcPK0acAJdooWFO7HZRZbls4cFQ1UsbWo/sWuQeVI=;
 b=eyjGWHr2+0B+O4cbwOQGqcGYkF4S12DYytAfJbxR0GfC57fcg24M2YQ2PDz1hTm8qWK9STMICnoCOqyllWjZ4PcFgKQGNLWnPateHKkGCVRztXt09rSmMCre4huI+MC288WMu9twcUtK/lYyncgQVcP6pM9j47/v+cTejCj+dqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6938.eurprd04.prod.outlook.com (2603:10a6:10:117::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:14:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:14:26 +0000
Message-ID: <c6ece6df-785b-4fbd-9398-08ec88e108cf@cherry.de>
Date: Mon, 15 Jul 2024 16:14:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] doc: Add a description for bootmeth_script
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-11-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: bcce29bd-ba18-4aed-de82-08dca4d86ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVuMU9wVnB2Rm5CWHBGQzVlNXVRemdBUTIzODhuaWdEdXBPV3ZCREhSeDJU?=
 =?utf-8?B?aXZoTGp3ODhlaEF6Q2NKdHdCOHY5azIwaTR4eHN4d2tEOHZhMFdENnJkVUZ3?=
 =?utf-8?B?Z3gxVjZHVlY5MU1rZmJ6aG9udG5wVWo2dTVYV2ZaQUZIYVRSUWUvMUpQb2Za?=
 =?utf-8?B?V09Tb29mZzdZUkh6UHNQT3ZMWldVajZWcmRMYkpzT2x4UWlNalh5UkxyanEz?=
 =?utf-8?B?VlFiT1Uyays4RndwU2tEWTNMLy9CQkswcFVyOVo3ZUcxQ3Raa2kvSXNvSEl4?=
 =?utf-8?B?anhmTzFNS0dmc1JWQnIxY2VRYThOTG9aNTVTN1NUdm1Nb3cwRFRBUDN5c0ZO?=
 =?utf-8?B?NHFNemUzT2JiODZ0SEFsT3plMGpHM1J4c1hVaHFQK0ZNLzYydnptRXRxa3dX?=
 =?utf-8?B?eFI0anlsakxJNUdNVDAzM3FON3JiZzZqSmhWY3owQlZMeWNQRENkc0RQd0dm?=
 =?utf-8?B?ZnZmbDFxZEY5MTNMNC9BVTB5R2tmZFlIR1YvRGhtWENYaGczVVhTd1lPYnht?=
 =?utf-8?B?V3F0SjQ2eUltclRnWFVsTzBlYUk3UVorMWJ4V1lhZ0JXMmV5eVcwY2FnUkNO?=
 =?utf-8?B?QXU0dHB2eERoeTNCL0QwOWNTT05JNDJ0a2x3M0M2SE44S2VBb3J0SXpVMUg2?=
 =?utf-8?B?YkpBY0I2LzNOd2dJdmMxT1JwWDVtQzRVdjR1MGdJT3lBbUJuN3VpVkRjZmhC?=
 =?utf-8?B?K0tRWEQ1RnUxbi9ONUlUenhKQlh4WEt3amVDSTN4L1hUbDJ0ME5RNjdEUmYw?=
 =?utf-8?B?eUFMbXdYTjZPcDF4NDNBUEdQdUxqV1EvcXIyVkE3Ri8vK3Q0MVIyMDNHUVJR?=
 =?utf-8?B?VUpKbzJXMmV0NUxKdDlTK1poOU5MVHZZNTZjSldjMnJYOGlqbWp4Wit1WGEv?=
 =?utf-8?B?eDFXa2NTM3VFdWFLWjZnM0xOejBrUjVOcDdiRm5yaVcvbXNheklXUG5GTjlF?=
 =?utf-8?B?akMzZE96Q2VXWFRwWktTVy9kcnhqU1g0Q2FjdklzVkVsRUtzbFpkSDVWNEor?=
 =?utf-8?B?ZzhhTUFreGUraXgrVC9PcW83Y1RoRmx0c0FidFBWRnNyd3hrRnhveVVWNWN1?=
 =?utf-8?B?eERZZDlLbGNsRGZpWFFiL0xremluL2NKSWdaWWtzVW95d0thdi9TSkZhNFZ6?=
 =?utf-8?B?cmdOR25PN3lyVlhubmN6OEJxcmhBQ2JNb2NGSG9IWG54ZjRETnNFdDFxU3FY?=
 =?utf-8?B?bVAxMm9tSnErV1B0c3dUUml5Y0szVGdPUWd6Vm9BT1JSRkJaRTdYbkErYjdZ?=
 =?utf-8?B?dzFMVmZmL1Rkc21oU053NndVMXpNYVBWY0l4STNqTDhmLzNzdDNzeU9Sd1ZZ?=
 =?utf-8?B?bU5CbUVJN2RCN2JTemRVY0R1VnQyZTl4dTBvckl6R0lRdkIzWW1vTW1UcE1I?=
 =?utf-8?B?N3NIazNrQTZhejJyTk5OS05wOHRoL015eGdKTTIzclliUHE0NkMyNWhwYld1?=
 =?utf-8?B?RU92Sjd0am9ZSUxQUlFSTkRpdXFxWHZRUWdyMjVrd2VzTFU1RXlGL1Bjck5v?=
 =?utf-8?B?WHNiR05iTEtrelpxTncvSzY1b2VvcFpnMjlLUk9mTTh1WnhwejZlR2FIeEpP?=
 =?utf-8?B?c3d3Lzgzck9veGEzSFE0eEdUWGRwZTlDQmpSNmZhaitwMXRLeklRT0dzSndV?=
 =?utf-8?B?NG1LRnNpM3NGdS96QWV2S3RlaFp6ZlMwUkkydkFUQ3hsaWdHekhJbGN2a0Z1?=
 =?utf-8?B?UFo5bnJ3Qnc1L2JLbUl2ZTRGRFRmTUFkejUwdHdYdk9nR0RjVXZ3UU1sb2dF?=
 =?utf-8?B?WktPSkQzSEdqQUw3c2dOWUdKRGhoajJ2TCtNYjNWYkp2aTRUR05CTDNDc1Nq?=
 =?utf-8?B?cHdEb1ZUZjROcEppOVhxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFh1UnVzNHlJUGJHdCtPaGwzTVpXYndST3NROUJPaXFJeTVWV0ZPM2tLQ01i?=
 =?utf-8?B?Umw5WWZoNmRXbTNYTWkzOU1zRmJVbGtMYUllaHI0Mlh6Q2pDMGRzVnhqQ3BH?=
 =?utf-8?B?V0c2K2cvMWI0azZFMjhMNEVibFE3WHNTUVRvVUE0dUpwMi9oYmt2Yk5ZYmFw?=
 =?utf-8?B?bTVVVUFVVFd1eXl4M0FTVjlGa2gveUZIVVBNSGpoMUp6QkhITGR1WWJaQlhS?=
 =?utf-8?B?QVFPUXpqLzgvMTZzbklkOFhtVVU0TUZNL3JrSDg5Qkl5NWZnSUNoQUthMVNi?=
 =?utf-8?B?dURBbUhJNlVYUGlWbnd0YktacHRGTmVYcEtjSXVRbmNUVGhNSy95NWFPNlEr?=
 =?utf-8?B?SWVoOFZzTThQV2VITDd2TVFuY3JmZnlRVzNVencvVXRhMEZadXlvUHd3VjNs?=
 =?utf-8?B?dXN0L09yM0dNdnpoREpwOTloWWVET0V3TlBLaDhaaElpYTlaS29YT0dtRWJH?=
 =?utf-8?B?Q0JTa3VQdVRjQzMzWjFpbHNuZ0FCOVoyb0wvaDJ6MnJjeG5oYlBDcldWeExD?=
 =?utf-8?B?dkZ6ZkxvWlVqTW40enpyS3RDMFV0QTNrTDhuNDBVc2NNSDl1THpNUTQrLzBh?=
 =?utf-8?B?NGsxbTUwYVg5ZEo4Ujd1c0pSQnZ0QkJ3VVE3Z1c0RWJjYTNzQmVlN3kyaC9y?=
 =?utf-8?B?UC9rSGpESXMxaXpZQ0tMOGpzNUt5Z1MvSFdaTzFzM29uQlpTR0pDUWNvMzNJ?=
 =?utf-8?B?N3lHT2tneDNkcG9pM1dBYlZaSnlpVjZ1MWVRYVlMRlY1UkgzS1BOb0NjeFBp?=
 =?utf-8?B?cjFidmh3RzhjWmpTbzRBNFJaSmJPbkRiU1gxVE16eE9qRG9LVG82Nm5ycThV?=
 =?utf-8?B?dHRtSE1FNHdDbU1hQTVkdDVBTFZJQzhBb0Y5S0hnZTVpT3E5dWh0dXpNSFB1?=
 =?utf-8?B?bVJqTkhtR0d3M1RKMmkrd251Y0FUemRnS3N0eTBxb01SckJ3WjVnWDduUGRr?=
 =?utf-8?B?eDJiNlZ0Zis0dkpVLzAzZFRhZXVmRm9BRWhKRzVJRGJ3QUdqZ1NiN3pJTEJY?=
 =?utf-8?B?a1hITk5mU0trbkU1OGJ2OVRBZ1BkSXhqMHI5bzBYTXMySEdGRGMrRnBkKzZ1?=
 =?utf-8?B?SmJZb3JTNXFUQWFVZnRISG9odHBLcEJ6aHhKOCt0dHB1ME5zaTYyb0d0R0RR?=
 =?utf-8?B?YkJjV01ZS2pHT2hBV0pKd1ROdDY1VmNZblk1RmRnb3dsMXhGL3JndnVET04w?=
 =?utf-8?B?VjQ5N0NtQk9XaWpvOU0vS0tWUWVXbGJrK0NDSTZ4Ky9PMS8vTTZtWGc3ZVZE?=
 =?utf-8?B?d0pLRVVIbHlPbDZ2U1RYSHNsUml6aUlwdEM2MysrTVJ6cHEycW5wSld2cUF6?=
 =?utf-8?B?ZGJqMWtiY3hLWEhyZnUxM1VVSExZRThVT3pvNG1BaUJjTnZyR1FxUnZrUy9S?=
 =?utf-8?B?a3dvWUNIaEV5bDdMdGxOY2o3Q2F5Y2ZHZ2krQ3VKM1MzM1VrMW1zRWxSaTd2?=
 =?utf-8?B?b0o0b1ROR00ycU9YQWMwaENtTXhoUFdyREIyY01lNUVybmtZaXU5U3d5M1pp?=
 =?utf-8?B?alpLTy8rYkg2QlhLVi9NMW1yK3NjVWM2RlFMNGRkS0hNVEh3ZmhXczN2bFdV?=
 =?utf-8?B?T0VMT0JJRzR4NEV5ZXVoN0tCUGw3TGNNWm9JY1RCTkNYRFNZWmFUVmZPeVBw?=
 =?utf-8?B?UlVCalMwUjVZVG5mLytBeDl4dWhOZExZSDBxUjNGZmRxeXNOZTN1OVdRVWpS?=
 =?utf-8?B?c0lkc1RKUlhzUXhMNGVBUGF3RWtHd085VS92ZCtHbWdoTUd1RWxIbmU4dG9j?=
 =?utf-8?B?aTg5L3dnVVRXRDZFY05MdkR0d0dLRWI4bGRtdXoxT0tZYnEzVzBwcUpRZTN3?=
 =?utf-8?B?M0xGRWVCSm9NTVRUYkJvcnl4NEFLaXUydkFmRGlaRGpsbkNqVTdJSlpaQ2ZO?=
 =?utf-8?B?dTY4clpNL2VzU3puc3hGcEVwV2hSMy9FZDFZVEptdzEzaXVXcWVHZTA4Zmtw?=
 =?utf-8?B?ZmNtMTh5STZBNllreG1ocHBmQnoya2htd01FOFRjbUtsbzNiT2o2WDZQdlE3?=
 =?utf-8?B?SzBuV29SSDhTZUx0MWpJMm1COW1SVUlMTlBHdDFoaTlYMjRjRmlRR2xkeTB2?=
 =?utf-8?B?KzBBd05VVzNLN1FiUFVaWUx1WHM2RzhEYlBMQzdTOGlyeFdUYWU0T050RHRw?=
 =?utf-8?B?cmt5T3ZDMjVBVHNCL3UvdFBOYld1QUhOSkxnc3pkaGNPRi8yV0s1bWNCY05q?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bcce29bd-ba18-4aed-de82-08dca4d86ec5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:14:25.9563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weIBEd6oUfZQgQGmZi1BGkJHWz/geb0uZHAlKbkg0e5he3hemNBGlql96X8FhVIoCmacucpiw9haC3z4b+zO5lE8AnIBFwnMAiHeUc9f4KQ=
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
> Add documentation for the script bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
