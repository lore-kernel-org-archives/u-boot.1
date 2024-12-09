Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE16E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 14:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453298969C;
	Mon,  9 Dec 2024 15:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A1aOoxm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3060A8969C; Mon,  9 Dec 2024 15:56:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1386F89634
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 15:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYNwQMfBqr061qJLDK4CGFeZJ5ZCGxM/COScTnDi8Bl2892CUes9tvZiA4/GxUbXzmh43pMk9R6s2GI+9cKwVbJ3x87Sw43QJSN/XgJbFKtsnngfzenFUOutVEAnSSjcxjq4+sEN7CvESu1Lazi9FcDxp7Mh5VPTxuSqWkiRZEUJExAZ+kf0Gn09uqCvmOMs9BRSdT2lV0BNlDqJxvtoPTTqP29vUkma+8cy6/9NcWsGTYevhwFS2pjzVojlWyPWYTb2kqTpna7ItLwanXjSplqYNLdqzNHwibPeBo534xb5NXu/6Y+wRdRQX+By1X0bxiOcCVuuJ3wxcZROemrY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl4JWJYdgbu0LtkWqJtjwsQqCyzWVgQXVn8bIyHrDWU=;
 b=BWozKMy8Vskeux+NHGnmdZwOzCKnO2QVSbWVOmQcpv/EkNk2lg3rWQWUJ35NGhz6FmLNcmKN9HmyhiB1eC6Sps4kEiZxMWJQ5mzNmWQhHkRpzA72Av6fAFgFRzA/JFb5iXrMAZjC0d9A/TY7Vys72852KsE96jQ4/6Iy2okyvlufVOYjIEhDPFqgYOL+juUe/d7U6KvXXxW6skQW+jg0q9LNjcyIrm2ssBwweFi9vX09V6vwolu1vH8QusmnWHHxlLMzbYgiBIGj2Rag8GVKD607zNe5uoo39f0Egf61MVCiNjBq7pvmxDBHwS9NA8CJa2CniI8YFOsF66YX+u5n4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl4JWJYdgbu0LtkWqJtjwsQqCyzWVgQXVn8bIyHrDWU=;
 b=A1aOoxm5cDzcx8gi7AhcVmKLjPLtcZbtGWm4deFmwlWyZCq3cvYcDVvzUG2bP3S+pUcTB85amne6qq9+XvuDfdqRDUhO1k8V0Ad2H7McDIn8JpI8CCY4P1WEqcdS0Vw0ud8iKwp0qXkdAi1MO5janXEblDZdV1dVgm1sv3nwYxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB10033.eurprd04.prod.outlook.com (2603:10a6:10:4ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 14:56:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:56:02 +0000
Message-ID: <ed3ae28f-8963-4033-a6e9-6bfd626857a6@cherry.de>
Date: Mon, 9 Dec 2024 15:56:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: Use correct PHASE_ variable for expo
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20241207145227.1024491-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241207145227.1024491-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4daa9333-126f-4a38-fa2d-08dd18619991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzArdyswZi9UMHd4ZjlROTVpV0VJY2RKZlJFSisvZmU3OHkxekNWWWRtWEcy?=
 =?utf-8?B?WFA5S0NpS1dxaHQzZkE0T2V2V25KZUx4TXUxQUF4b0YyREdDaVppS0RiU3I4?=
 =?utf-8?B?bjNHNk5JdVdnWVVkWnlIZUc1RzBVdTRWTytja1BzQ3pqcjl0djhQUlgzdjY5?=
 =?utf-8?B?RURTQUxMdmtTd2kvTks5c0M0VkU4ZVBUQVhNZXFkbmxPY05aQWs5amZQY084?=
 =?utf-8?B?QVQwbEltVGp6SU9KQzJKTXFVUkFVWWN2S01EaS9Ua1dOTUJGajdXbWtKT0ph?=
 =?utf-8?B?MHltaWtNMTJ3Z2pLR0ZOK0F4VW9FdWRrMkxlcEpnMXgrRUhZRkdaNlIxdHll?=
 =?utf-8?B?aXREaHRISE5Pd245aFZlREJFK0FCbk02TWo5NzhJQVptaU9TM0sva1RZa2N1?=
 =?utf-8?B?Skxsc3hxZktPMFpIWXFJWWMrUUNxZXhCdFN1dHlmaTYrMlBXUUFTV0dZOUF3?=
 =?utf-8?B?TGZmNDZtM1prK1BSRTZITkkvVEg4d3dhWEJ5bXVXWDg3dzlCM3RhMVg4TnJC?=
 =?utf-8?B?YzVwUFJreWNXT1JReVRTMDRXb1doSitxMTFTRUx3OEFvbktWYUY3WFgxNXpV?=
 =?utf-8?B?b1IwQjlrM2FOVS9aeUJwNHNJckR1ZnJLUm55Q0kvVXBsRmU3Vk9tcXpLVWFu?=
 =?utf-8?B?RmpOY2ZyeFZZVWE2V005MHpoeHdUQVF4ejRzeXpRQUJXZzBuU1F4M2FXbDg1?=
 =?utf-8?B?VTdsK3VQaDdzS0hxQ21ibDhGbVlqMzhqSFBCdnlnTkhHM043RGZLUUE1bGxw?=
 =?utf-8?B?a2E0eVFSblRRM21XNndSSmkvSUNPTStURCtqSURwUnAzWXpMSUMwMVdQaVZa?=
 =?utf-8?B?MVN1RTZEcmtIWm1DRVExSVZscDM0WEFGdURmeWRRc24waVEycklNNHV5MmxD?=
 =?utf-8?B?RjJkSGpFVkJQTkZxc3p1K1l1dVFPMmw1eXNkMnpiRFY1SU9QdnJYTzVLcno5?=
 =?utf-8?B?NlJyMVNDRTVQRStXeThMeEQrM1JONFBqQ2pHa0NVNjVKUEtRQXFKS1o3M3o5?=
 =?utf-8?B?YzZwdUR6OUsvZ3pOeUE2b0N6amNGbkVWZURST3hCcW40TkNma1hoUnA4L0ZH?=
 =?utf-8?B?M0poNUlqT0d6UW4vMTBsVmVnbjZlWVpWaW5iUVlEQVdkWDFBbDN2MklOcERB?=
 =?utf-8?B?MkxRdFg4akg2Q2dEZXFFZW5ISVpabHdsQWdKaGI3VmdsekRReVV6bHlOZnM3?=
 =?utf-8?B?RmE4aDZndzZ5RXVQM05yNFNQSDg3NTUzK3J6dG1weFZiTnEvMEg2ZDdIUVJU?=
 =?utf-8?B?VFZXd1lOWXQ4cGpHUWlPM2xMU2o5QkJLYkdsM1NINFFDSEJuT3poR0xBS2VR?=
 =?utf-8?B?NzRTY1V0ZVRBSVM4SWU4QTAzeUk4dE8rU1llNVhKTVpXRStPSEtLMnhrOVcv?=
 =?utf-8?B?QTU2cWpkQk9RU1NVWXRpTHV2VTcvbjBtQ00xb1dTdkRPU2xabTVCL3JPc0pz?=
 =?utf-8?B?ZitKSnNYUk1RNUhaR1pia2Z4MEN1TGJIcDRSeFhLTFVZTHBBOUprU0lFQ3R2?=
 =?utf-8?B?RHVJNnc5bjRlbGVwWGhWemE2VmtzUTRhdVRLQzNMaFZCYW43VzdyV05reVZT?=
 =?utf-8?B?VGkyWWpIbFF4T3hwRVo5cFdTSUs2cjB3b25RQnM2YU54YkxGSkpjdTRFOWly?=
 =?utf-8?B?M1BuSXZmZHcrSDYrZ05HMlNuTmE0VjVQbzhOK0YyVTc0NXlyNmJBdE1VbUlq?=
 =?utf-8?B?MHpNdWZrSFF6cXlOYnhocXZvSmMvaCt4dmloazJ6bDJ4K3pFZlRYWEJidmtX?=
 =?utf-8?B?WUhGM056OHJYSk1tZnVyR3BYZWZDRUFQY3U3NmZvT2dlTW1oSXdLaFM2UDFw?=
 =?utf-8?B?SSswRU1wSmN1Q3ArT3RHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBOVGYyUVNuNnlpWklTQ3h0eVduZ0cwcFBuVm0xZldic2xXMjdlUjRWZmg5?=
 =?utf-8?B?VkRMbExyUzBmZWptazVqbzVCTUtYTWlZVERjcDhQdTE1NDA1ZnpyejhFNlZ6?=
 =?utf-8?B?ZGRxeFJwb2JmdHFITzNNcm9xZmM3clhHRDRPRTRPUWVpRTIxMVNHSGFyWHZp?=
 =?utf-8?B?bFBZQ1JtbHN0K3hlcTJwOVo5NVhoaHpMb0NjTFFrODlIWnJUeGRXTjF3NjJ3?=
 =?utf-8?B?MjlSOVNlZjVxdGlRV084c0crL2JBVmVtVC9VeE9LbS8wRHBJTnc5RnRQM2cy?=
 =?utf-8?B?TGhabGFEdWNqQVFqbWxxZ0lPcDVzT2tWc1h1T1J3UHF6S2ZTUVplOS9jcHBl?=
 =?utf-8?B?cDk0MjIzOWhrSUdOWElHWld5blFHZlpWdmdPWUtIb3M5eWQ0bEdGcmNxNDVZ?=
 =?utf-8?B?c2o1UldXbUEzekdrWS9qUmVyN2tSNmVIblh0UDJISmVTa1VzMzdyQi9zZWY1?=
 =?utf-8?B?ck5TWEZuaXpVNkRna0hFdlczNyt4MWN4T0V5WTNzd1JTczhpQWc1Z2hmNmYz?=
 =?utf-8?B?eFE5Q3ZWVDJhV1RTd096aC84cklwQ0x5TTFwTlFKZTJhSUg0UExOenNFaUxY?=
 =?utf-8?B?ZUFGR1BsTHJzeTFUSFFHQ0lDVEJwL0FtMFR6SnFyVVNLVC85Z2RnWmRDSXdw?=
 =?utf-8?B?aXY5Zk10M1NLZlFiYStsbVVNcC9ka3NVV0VPVFlZQ3Z4UVh1WmxSUkFxTngr?=
 =?utf-8?B?SS9GZGJCSE1WYWh2NWpwZ3pleTM3d3pVd0FBcDRlTjBxUHdjSjg3RlpFdXJF?=
 =?utf-8?B?U1ZtN21YZllDaW9EYUJ2Vm9tWFk4N0NRN0hrRFROYkxMeEYzUmZzK2hPNkNq?=
 =?utf-8?B?VnhUVHZZR3VDczlFazV1QXg3OGw3QkhKbkN2L2JTaWk5akxheklmZHZCcnVo?=
 =?utf-8?B?dU1JcXI0TEQ3NlRTTlJkc0o5b0V0QVZyVnUzRkhIOUdiSUE5bFZEQlZyNllJ?=
 =?utf-8?B?QThicGJPVEtQVlVFRXpIdTQ1OW4wVldKbXN0SkF4MHNlaXdOM0tJNmgwM2F3?=
 =?utf-8?B?ejc4TTVIRDVFNVd3d3dwSlNzN3lSV2VXUzgzQkprNWdueW1FaFk1TVUrWFNk?=
 =?utf-8?B?MFM2U1RkR284N1Y3VDNudlppMWhyOE9vcG5rekI0aVU2ek9aVW5iMFlGaDR1?=
 =?utf-8?B?ZEpxNzJ0Q2dQb3JmVVhlMGU2KzBOZDlFWmp5MGNNN2RORC9GOW0rSmdpWXYv?=
 =?utf-8?B?Znp4bHdTYllVSjdsQURqVXZiZlZxdll1aWxXYXdicTM2bE1rUktWcTFrcmlW?=
 =?utf-8?B?ODJjQ2l3N0xCL2d0UGcxQ2lLcWFCZFV1bnkzK0xDc3RhMEY4aFFhazVFR0RL?=
 =?utf-8?B?bXp6MDlGKzNMQVg3T3hOeHA0djZ3Ym9wZm5MM3N5TXFjbTcwMWtHOFZjM3lQ?=
 =?utf-8?B?RFF6NC9qa1kzZk1DTGsrL1NBMUNla2Y3STZoa1hBYU8rZkdSbkdaZnIvTU1z?=
 =?utf-8?B?aGdJb3RoMEJheSszNlBhZTQyYmtoOC9TaVFQbU5CbjRjaGhzaWNDazJlOTg4?=
 =?utf-8?B?VGpZK3RTNlo0NjJVLzNXWEJWQkZNVmlTenQ4eVFBanBIc0tIcU43OHFnV1ow?=
 =?utf-8?B?d3FDMlZqeWNtQm4yTE5oZTVVaDB0Mmd5VHVURWR5WmFxRkhlV0tnTVhjSDly?=
 =?utf-8?B?MExMQy9lODlsOW5tY0hNMmZlSWVqbDZqM0FQOHFoN2dvZFR1enZSYWx5SWIv?=
 =?utf-8?B?S3NZeFpNZDgrbXY5MzFVODBkZG5VSHorNCtHRW9VK2lhNi9UWldIWGhuSVZi?=
 =?utf-8?B?WkVEWGF2N2xITUFmbFM5elFob0VmZHJYS1RTSmJ4SlVFWlVqaVA1Y2ZUS0ph?=
 =?utf-8?B?aFpJSEVmMVJIL0M1blpBdUZXQVhjM0ZqNm9ERW9OTUtCZHJXOVFHMm1MaHZm?=
 =?utf-8?B?aktZYUhCUW8rMWlta0xXQm1SdTRjV2NHV0pOUVYybEViVFBLYm5FVkpCMC9k?=
 =?utf-8?B?MjNMUDBIaTJYZkJoN2liRXhZTmZPOUs5SUtKMXYvRXg1SXltcjdHelZzLzlB?=
 =?utf-8?B?SGlVdDhCR2JRS0JrMW9SRnMrNTNmamc1Ni9VdWdsbXZITHpGY3B3Wm1oQ3V6?=
 =?utf-8?B?b25GZTJxNHYydURZd3FaS2F3dXBKSThGb0dRc0xydStVNk0xb2U3cVdVOGJv?=
 =?utf-8?B?ZithNHpJcjk4Kzd0RGVYOHIzRVMybUl0NG1GbGZ2QTJ1TWFvSmpLa1hFcDQy?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa9333-126f-4a38-fa2d-08dd18619991
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:56:02.5596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSxQNsxZctsCyPjtt0NCn/vME+kkEx9dS56kHLeZOp0T5DF4tJzCvbmMlMfQXRHe+YzMi7xnfoqdq5Q52xEAAkyAUoCBdiGLhjuo1ueB+jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10033
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

On 12/7/24 3:52 PM, Simon Glass wrote:
> This patch was written before the XPL change-over. Update the Makefile
> condition to the new way.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: ae3b5928d61 ("x86: coreboot: Allow building an expo for...")
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
