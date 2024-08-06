Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C697C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EAB87F19;
	Tue,  6 Aug 2024 16:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="e657n87F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD9A87E9D; Tue,  6 Aug 2024 16:53:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FBB88A23
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU7fJ4N9djT1wb8qGMMyblJBC/bpjkm5/yscFpdprzD2EdOLdGZPkHuT5j9wBe8Xdag5JV24RwvRxmwuIvKprlqx7kFnzowliTys4KsVUClo9251n7k3aWdteMr6VHVtEytPNMdsEXGkJvmb0ToNLUa90UvsfhcH+WzZ7dQhUGn4C3/1hojgposMvwV0zAldusYvHaGPrJ95AU2QbtCpJKnWk3W1h+UtzalB/ZpXFcn29hi12PssoqCc8+NFqIHEgbI+Q3qmcU+jp7t0Jx7IzaHFkyqt8my3a43Lkt0gTYUeI+U5o7QOrIVr3jADgJpYB/kTyw1/Ox07/ibl6xQ6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKLFmGrbPYbMHJgaFbTM+JzjWnIS4pHsCaj74JoWMs4=;
 b=Xk6twYmDxeZiirmlOVPO/51qIAYnUu3tZHITojCCtsk6e+3JXjZLNEMxVSKxZlC8DGTnDu04YriWfyfOMsMVATjZ52suQwfR3bx1ATEGUJrJ4LsjQnr/BvqE9Q/Y+Pfx2gv6Jn0Sv14tdDllTesPfi+WxIyXLSjGN6APji/ixVf308JEky7x+H2uu2Dko5OlLmvVBBZQ1KOhuoR6An+I/bZOWfl6E85xTvgU28b9RSQsK9AZRkFZrtUUVawbHxRyLBshCE+H0FvsApqagTU2xNa99QSPp2n09z0u1j29bi13sMHQmxMbL3Oalw/nG+mq5vKMEv1l75Kq49o5V0j+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKLFmGrbPYbMHJgaFbTM+JzjWnIS4pHsCaj74JoWMs4=;
 b=e657n87FuWtPaijCB8lHQpjQebkoC8YZeMD1r9+rOlyYkpgKLJTYC8ekrfD5O4+3hb0nHfcmWCmcpzwT3KFkGDgY8QeLucUI01pwyJs8RFZA+AJATmjSp7HdBr5VRK2d57WR1qMxFkE4nbfohzHf+aUu5zo+SNd2vvYeYP0WZfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9419.eurprd04.prod.outlook.com (2603:10a6:10:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 14:53:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:53:06 +0000
Message-ID: <8a2ec8f9-7226-4728-ae03-ba434f18c1f3@cherry.de>
Date: Tue, 6 Aug 2024 16:53:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] spl: mmc: Try to clean up raw-mode options
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-12-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: c48ac120-5434-4835-30e0-08dcb6277b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3J3bXJYekE4cmV2clhCMExCTmZHTTAvbDE4Qnd1aEEzeTRWbkFqKzJJeGxz?=
 =?utf-8?B?bWxLR0VDNVMwOE1hRjRHRjc2aDJMM0pGMHFtejF2T3Q5ckVYV25LSzhTTDNn?=
 =?utf-8?B?WEhRK3d1VTU4THNmYmExVTcrbnBSdWlnNTNGU1ZuQ3RNOExPOFlaeW1TeExv?=
 =?utf-8?B?cDN5QllzU29yMHFTOFBsS0hKZEFJUjcwT1hWd1NITjI0NWlwSEdVTWptdy9M?=
 =?utf-8?B?M0hNcWFuYTNPQktGaS9pa0xHMG1HVE1pMUJSVzg1bXRWQTg0a0lOL1hrcTBK?=
 =?utf-8?B?OHVYaW1UVkFaNEZjNFBMRW1yN1lGNExBQjZ6VGtyQ0JLUkQ0K09ldWVRT3ls?=
 =?utf-8?B?VDlydUVtbWtMWXNrZTFBSjRSVVlma1M0TG1BMnlTem5vV3pnMHhwZG5JcEhH?=
 =?utf-8?B?WEUxWEdLSWlldElMTktxN3ovSWg1NHl5N0ZPUzR3N1NJYy8xOEJEK2VjQ0pn?=
 =?utf-8?B?OThuZmJ6cE9PYkc5dUFYUVJHeEVHTkhhT3RUZXZEMjAxb2RPRmFTaFJlRno0?=
 =?utf-8?B?N0JyQXBxdkNQcVZaVjF3REVUSmVOcmVNMVZFV2h6QUowajRMbk5mR0F0Wmhh?=
 =?utf-8?B?VWVrU1ZIZGRpa1Jqc3NGbU81dmtyT0NOSGhKOGZMbk9yYXlid0ZMQkFQWU5n?=
 =?utf-8?B?LzdMdXJJRTZ4WFBSVkhTdGJHeDRZZVF3LzZmVFcyV29nSjQ5K2x1eVhzeTFu?=
 =?utf-8?B?TXNIc0dzSzZnQWhIOCtxckU5eU9sM0hMOGc4bmNzOEoveEVXVmxhdGxvK3cx?=
 =?utf-8?B?c25YSjlXZEtmaVVGb2hWTHI1dWJRM2VBTW4wOGYvUk42Q3BrbTUrR2NBNmJ2?=
 =?utf-8?B?aGxuMHJkRk8xbiswYlpiVHFrdjNBemhZZWxSUjRHSjhyVGxOYWpmR29pTnA2?=
 =?utf-8?B?L0xkeElGejZaM2QxNURUZjRGSmNyWHl4NEk5MXYzbENLNFNuZjVoM29BTUJp?=
 =?utf-8?B?RHBOME5tMkloQ0M2QlZ3aWZYcVg5WlB2V3YrYWNndDhXNUNTd0tqNEdaeElS?=
 =?utf-8?B?RGRySGV2QVlwR2g2WHR4VXJlVTVnMkxIekdHOVFVeUJlY3I4N0o4OFlVR0NZ?=
 =?utf-8?B?aUlZeExWRnpwWTVFUjBEWjBZcUdvWXV0Qm9ZNU5jZWdxUElrdEt0WkViQ2w0?=
 =?utf-8?B?dnBzcXJPWURYcFJydU81cmpnRDFTak03VEZKeFVRdTduY1FlaFc1SVJCVHkx?=
 =?utf-8?B?UEVWdjdTWDd4THJSK1F4NGhra2FxekJrWkZwOXowdzhKakFpTFdrVnR2Nzli?=
 =?utf-8?B?Tml0VmgrUWpIWFJ2UktuY3h0eVZaMW5VNktvQXdWMDZYMzg4Y29DQVdkb1pJ?=
 =?utf-8?B?dXl3UTBXUzZmRjZaM29lVWthUkJDMERDdklIQkkyanhwRkhvRmlGR2NwLzVK?=
 =?utf-8?B?dERWY2MwN25saUN0NmdQYitvajdiY0ZrMmF3Y0ZkRTk1R3ZDOVdDYUVXM2h5?=
 =?utf-8?B?WkRWdFdldDYraXRvbk8ydUp5cEs5UWdLRldqZmVic3QrNGJVWWVaQksyT2Nz?=
 =?utf-8?B?MUlOQjZQd3pxTnVpQXJnQlNHN3o1RmxaNWNjQnBKdE9SeVFjc1JtMHFNZmNr?=
 =?utf-8?B?Qjh6dFA5S21JaXJYK3VsbWk5bGJ2bzBtbW9Vd0JvdWx5aDV0T0NNcENseTBs?=
 =?utf-8?B?MFg1cC9FcG1MSVdqV3EraUNjdi9qYWcvblVnMXJ0emlyM284aEhQOUVhekZE?=
 =?utf-8?B?QzRVT1BrVmZSMDhZTExnYXRzYVBlV3BUYkphMWFJMncvUzNldjFrOGR6ZEJr?=
 =?utf-8?B?dXRLVjBRWUFaWVgyMXFMNmJXY3d5T3pJbzJRdWc5RzBWYjFQSmNLKzZMR0Uy?=
 =?utf-8?B?TE9GQ1JUMmlQT0NkeVhGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDg3Q01NMVB2QTVOU2ZpSy96MTJyaXpMNFI3bDhFTnlTYTkzeGZXYTMzQVhr?=
 =?utf-8?B?b0NPSnQwbWhDb2dweWMzeGNzMHpDZmtKK3E1UXhyWUVLZTNKTzl6TXU1NUp1?=
 =?utf-8?B?K3VVZDl3OVZ3TDhFNDk1SEhBVDlTZUk0MEsydGpPY3gyWTVCVDU0dmRaSUZJ?=
 =?utf-8?B?ZTVNbVFVUk0wc2pBZWZ5aHpqODdPMjFvMy9TQjN4d09VaVY2dVVVVGlpZHM4?=
 =?utf-8?B?bnFKc3VrY1dacHF6NVNUV3dHWmtuMTVDdWZyeDI5L2RJcVIxN3plRld5OGxz?=
 =?utf-8?B?RE9GdGpTZzhaS0lQYUNjTXIwTlJ4V3ZyWExaNTArSTh2ZTFYZWJiUUhMdEpI?=
 =?utf-8?B?K05ndlJkYlZFb1IwNFJmM1cxaSsxN2JBTDZrSE5oQ2owWklJKzEyWkUyZzBy?=
 =?utf-8?B?MmU0TnlxVVZMLzAxcDVyVEdTNWh2UkdHNndlUVQ4aWZRWEhBZzlsQTlodVVW?=
 =?utf-8?B?OUFZMDQzUWNQeFI5dEpyeWF5cmtuZnE2NG0ydnRZdlpwNzBlZGpGT0RqUnVp?=
 =?utf-8?B?ZnIwR1JiYm9TcW1BQTBLRmJScUpZY3BzZjNHRGRYbFdNcHB3NHdFSlp2RTFs?=
 =?utf-8?B?akQ5a2gyQmZSUUlpRTR6YXppQVdabTJVNjlwM01EWTJTbnllYkRkM29HUUhW?=
 =?utf-8?B?TDZZR2hwaXBsU0cybERjTGptNWN2SGdXN2FXdWFFeW03U2d3ZFBlaTdySXhz?=
 =?utf-8?B?WHhsRE1KQm84MytSOGZzeU41UmJiU1BJQmNDV0tGRmdGL2w4Zkt1OHpkbGtY?=
 =?utf-8?B?dW5ISFdqakpHYi9qZG5lSFBxcXR3QWwzSTRJZUFla1p4T0psVXJjUGJIaTRu?=
 =?utf-8?B?R1FUN0RDM2U4eHY5Z05kcVVsaUJvK0UvV3lUM1ZLWmpocnpTaEhGSmFYSXo1?=
 =?utf-8?B?R2JHNzYrNkZ0MmhXVzlmN1RiQ2lyRGZQcnBQeDk1QUVHTXA2U0tVcW5rejd6?=
 =?utf-8?B?RWdrNFBmckhDWEpPVm9KWEcybDZ5blpHVTJvWjREdVNYN3p3ZXptU1JidXRl?=
 =?utf-8?B?RGVTTjR0YVVSUGRoUm9sQTRuU3hrdVZkT1E5TzlQTHNWZ3Ywb3hqTWQrYXcz?=
 =?utf-8?B?alUyUHZ4bktoU3IwbHQ5UHZ0c2tCL3o2RC9CeG0rSGtSdkF6c3FOVnJUdkJU?=
 =?utf-8?B?eDNoNVNSSnJXdmZJdUcvZ0c3VTNNZE9VbVZNdit5dVljYkN0TjlpcnA5a0Jk?=
 =?utf-8?B?a0x4RldYOUgrbGF0dHl4Q3Mrd1k2RkR1NEE2aG5pMWQyclNHQ0svMkJFbDlR?=
 =?utf-8?B?dWNoOHdDS1AzZldWY2ZUWFp5emRacmNiSGVWOFBSUlJTc0U3TzV6NnA3TVlV?=
 =?utf-8?B?K3paNmtzSWkrRmJjelNRQWZYY2ZiUjlnbTRJVTVrUWw4NXM4T0JOZEQ2T01j?=
 =?utf-8?B?WU9mUVFBM3NiTUtFY0lmNm5SMzdkYlgvNHMzREJZYnc1K01kMURHemtTNzU0?=
 =?utf-8?B?aGJlNmNNTkpNbTJYWkR0Z0VYR3kvZVZQMXg4dGhwNWpJNzlnYVRqdFFXb0Qr?=
 =?utf-8?B?dXdGTG5mZHhqY1hEWE04Ylo3VlU4cDViKzR5QXV6cEx2TUF3N1ZnOTJNbmV5?=
 =?utf-8?B?ZFhkQ2NJWUNOUiszTVBYRk1mR2hjWjNteFBEUkZxSnN1ZlM3N1FYc3kyOFRT?=
 =?utf-8?B?VjhQa2RXbDU5V2hjdVRseHVsVWtnUElvbVZEY3paWCtXcVl0N3pBM285bGhM?=
 =?utf-8?B?MnI3aXFKRDJ4V3BIM3QvQjkrQkZqSWp1VUptbEVmcjRFbWRTTUI0VXZlak0z?=
 =?utf-8?B?NHNrcER6NE01UXMxY24wVTh5QkhXaWljY0NOVmNHZkF1Y2ptUTZQU1FRSHdS?=
 =?utf-8?B?T0ZGVUxwWkdWeHNQeVJhU3ozVlEvMndGVEFOM0s5ZWQxWVltbktkRFNYWVA5?=
 =?utf-8?B?dkREZ1JDbTZ1SzdKL1Rnc0JKWHc0TnlCSXhLQ3NFMWxVM001YUJuNytlUWkx?=
 =?utf-8?B?cHg5YWlFa0JoSHVDNFRCQi9pdXM1YWlsTGs4cGd2T25OWGYyTWJiZE4vYits?=
 =?utf-8?B?MVNSZVFyRWswaEFva0Y2TllLWStkWDBwL2NldWc2TjZHNitsS1lyNWJwdlVh?=
 =?utf-8?B?VWcrZ2F0SG9KVmk5Yy9xTENtVDk5aVI5TFhNVForRXF0Y2l1eEFNQkVMdmcr?=
 =?utf-8?B?cnFXNzBYcnNPak1hWXhxKzl2WjRsT0JWWmU4WDB1di8yemZvcVA1b0dFcXpU?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c48ac120-5434-4835-30e0-08dcb6277b04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:53:06.4541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZEmqHrbtdDbavXHuqGw9Bp1/ZkYH1t6z92qP6DnSxcAq3PwNl2iDyDdu1Bf+noz+hCO0lnwK6okqRqiiN26ghHcYggDhgalXSiknLmPbWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9419
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> Make the raw-mode options depend on SPL_SYS_MMCSD_RAW_MODE in a more
> direct way. This makes it easier to understand the options with
> 'make menuconfig'.
> 
> There are three different ways of specifying the offset:
> 
> - sector offset
> - partition number
> - partition type
> 
> So make these a choice, so it is more obvious what is going on.
> 
> Update existing boards to enable SPL_SYS_MMCSD_RAW_MODE where needed.
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/mach-imx/imx8m/soc.c                 |  2 +
>   arch/arm/mach-imx/spl_imx_romapi.c            | 13 ++++-
>   .../imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       |  4 +-
>   common/spl/Kconfig                            | 52 +++++++++++--------
>   configs/am335x_guardian_defconfig             |  2 +-
>   configs/am335x_pdu001_defconfig               |  2 +-
>   configs/am3517_evm_defconfig                  |  2 +-
>   configs/am62ax_evm_a53_defconfig              |  1 +
>   configs/am62ax_evm_r5_defconfig               |  1 +
>   configs/am62px_evm_a53_defconfig              |  1 +
>   configs/am62px_evm_r5_defconfig               |  1 +
>   configs/am62x_beagleplay_a53_defconfig        |  1 +
>   configs/am62x_beagleplay_r5_defconfig         |  1 +
>   configs/am62x_evm_a53_defconfig               |  1 +
>   configs/am62x_evm_r5_defconfig                |  1 +
>   configs/am64x_evm_a53_defconfig               |  1 +
>   configs/am64x_evm_r5_defconfig                |  1 +
>   configs/am65x_evm_a53_defconfig               |  1 +
>   configs/am65x_evm_r5_defconfig                |  1 +
>   configs/brppt2_defconfig                      |  2 +-
>   configs/brsmarc1_defconfig                    |  2 +-
>   configs/cgtqmx8_defconfig                     |  1 +
>   configs/chromebit_mickey_defconfig            |  2 +-
>   configs/chromebook_jerry_defconfig            |  2 +-
>   configs/chromebook_minnie_defconfig           |  2 +-
>   configs/chromebook_speedy_defconfig           |  2 +-
>   configs/ci20_mmc_defconfig                    |  1 +
>   configs/da850evm_defconfig                    |  2 +-
>   configs/da850evm_nand_defconfig               |  2 +-
>   configs/deneb_defconfig                       |  1 +
>   configs/display5_defconfig                    |  2 +-
>   configs/display5_factory_defconfig            |  2 +-
>   configs/draco-rastaban_defconfig              |  2 +-
>   configs/draco-thuban_defconfig                |  2 +-
>   .../gardena-smart-gateway-at91sam_defconfig   |  2 +-
>   configs/giedi_defconfig                       |  1 +
>   configs/imx28_xea_defconfig                   |  1 +
>   configs/imx28_xea_sb_defconfig                |  1 +
>   configs/imx6q_logic_defconfig                 |  2 +-
>   configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 +
>   configs/imx8mm-cl-iot-gate_defconfig          |  1 +
>   configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 +
>   configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 +
>   configs/imx8mm-mx8menlo_defconfig             |  1 +
>   configs/imx8mm-phygate-tauri-l_defconfig      |  1 +
>   configs/imx8mm_beacon_defconfig               |  1 +
>   configs/imx8mm_beacon_fspi_defconfig          |  1 +
>   configs/imx8mm_data_modul_edm_sbc_defconfig   |  1 +
>   configs/imx8mm_evk_defconfig                  |  1 +
>   configs/imx8mm_evk_fspi_defconfig             |  1 +
>   configs/imx8mm_phg_defconfig                  |  1 +
>   configs/imx8mm_venice_defconfig               |  1 +
>   configs/imx8mn_beacon_2g_defconfig            |  1 +
>   configs/imx8mn_beacon_defconfig               |  1 +
>   configs/imx8mn_beacon_fspi_defconfig          |  1 +
>   configs/imx8mn_bsh_smm_s2_defconfig           |  1 +
>   configs/imx8mn_bsh_smm_s2pro_defconfig        |  1 +
>   configs/imx8mn_ddr4_evk_defconfig             |  1 +
>   configs/imx8mn_evk_defconfig                  |  1 +
>   configs/imx8mn_var_som_defconfig              |  1 +
>   configs/imx8mn_venice_defconfig               |  1 +
>   configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |  1 +
>   configs/imx8mp_beacon_defconfig               |  1 +
>   configs/imx8mp_data_modul_edm_sbc_defconfig   |  1 +
>   configs/imx8mp_debix_model_a_defconfig        |  1 +
>   configs/imx8mp_dhcom_pdk2_defconfig           |  1 +
>   configs/imx8mp_dhcom_pdk3_defconfig           |  1 +
>   configs/imx8mp_evk_defconfig                  |  1 +
>   configs/imx8mp_rsb3720a1_4G_defconfig         |  2 +
>   configs/imx8mp_rsb3720a1_6G_defconfig         |  1 +
>   configs/imx8mp_venice_defconfig               |  1 +
>   configs/imx8mq_cm_defconfig                   |  1 +
>   configs/imx8mq_evk_defconfig                  |  1 +
>   configs/imx8mq_phanbell_defconfig             |  1 +
>   configs/imx8mq_reform2_defconfig              |  1 +
>   configs/imx8qm_mek_defconfig                  |  1 +
>   configs/imx8qxp_mek_defconfig                 |  1 +
>   configs/imx8ulp_evk_defconfig                 |  1 +
>   configs/imx93-phyboard-segin_defconfig        |  1 +
>   configs/imx93_11x11_evk_defconfig             |  1 +
>   configs/imx93_11x11_evk_ld_defconfig          |  1 +
>   configs/imx93_var_som_defconfig               |  1 +
>   configs/imxrt1020-evk_defconfig               |  1 +
>   configs/imxrt1050-evk_defconfig               |  1 +
>   configs/imxrt1050-evk_fspi_defconfig          |  1 +
>   configs/imxrt1170-evk_defconfig               |  1 +
>   configs/iot2050_defconfig                     |  1 +
>   configs/j7200_evm_a72_defconfig               |  1 +
>   configs/j7200_evm_r5_defconfig                |  1 +
>   configs/j721e_beagleboneai64_a72_defconfig    |  1 +
>   configs/j721e_beagleboneai64_r5_defconfig     |  1 +
>   configs/j721e_evm_a72_defconfig               |  1 +
>   configs/j721e_evm_r5_defconfig                |  1 +
>   configs/j721s2_evm_a72_defconfig              |  1 +
>   configs/j721s2_evm_r5_defconfig               |  1 +
>   configs/j722s_evm_a53_defconfig               |  1 +
>   configs/j722s_evm_r5_defconfig                |  1 +
>   configs/j784s4_evm_a72_defconfig              |  1 +
>   configs/j784s4_evm_r5_defconfig               |  1 +
>   configs/kontron-sl-mx8mm_defconfig            |  1 +
>   configs/kontron_pitx_imx8m_defconfig          |  1 +
>   configs/kontron_sl28_defconfig                |  1 +
>   configs/librem5_defconfig                     |  1 +
>   configs/ls1021aiot_sdcard_defconfig           |  1 +
>   configs/ls1021aqds_nand_defconfig             |  1 +
>   configs/ls1021aqds_sdcard_ifc_defconfig       |  1 +
>   configs/ls1021aqds_sdcard_qspi_defconfig      |  1 +
>   configs/ls1021atsn_sdcard_defconfig           |  1 +
>   ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  1 +
>   configs/ls1021atwr_sdcard_ifc_defconfig       |  1 +
>   configs/ls1021atwr_sdcard_qspi_defconfig      |  1 +
>   configs/msc_sm2s_imx8mp_defconfig             |  1 +
>   configs/omap35_logic_defconfig                |  2 +-
>   configs/omap35_logic_somlv_defconfig          |  2 +-
>   configs/omap3_logic_defconfig                 |  2 +-
>   configs/omap3_logic_somlv_defconfig           |  2 +-
>   configs/phycore-imx8mm_defconfig              |  1 +
>   configs/phycore-imx8mp_defconfig              |  1 +
>   configs/phycore_am62x_a53_defconfig           |  1 +
>   configs/phycore_am62x_r5_defconfig            |  1 +
>   configs/phycore_am64x_a53_defconfig           |  1 +
>   configs/phycore_am64x_r5_defconfig            |  1 +
>   configs/pico-imx8mq_defconfig                 |  1 +
>   configs/sama5d27_wlsom1_ek_mmc_defconfig      |  2 +-
>   .../sama5d27_wlsom1_ek_qspiflash_defconfig    |  2 +-
>   configs/sama5d2_icp_mmc_defconfig             |  2 +-
>   configs/sandbox_noinst_defconfig              |  1 +
>   configs/sniper_defconfig                      |  2 +-
>   configs/socfpga_secu1_defconfig               |  2 +-
>   configs/verdin-am62_a53_defconfig             |  1 +
>   configs/verdin-am62_r5_defconfig              |  1 +
>   configs/verdin-imx8mm_defconfig               |  1 +
>   configs/verdin-imx8mp_defconfig               |  1 +
>   133 files changed, 175 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index be38ca52885..f30178ae213 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -735,6 +735,7 @@ int boot_mode_getprisec(void)
>   #endif
>   
>   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
> +#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>   #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
>   unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>   						unsigned long raw_sect)
> @@ -769,6 +770,7 @@ unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>   
>   	return raw_sect;
>   }
> +#endif /* SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
>   #endif
>   
>   bool is_usb_boot(void)
> diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
> index 9a86f5c133f..bdaea439d7f 100644
> --- a/arch/arm/mach-imx/spl_imx_romapi.c
> +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> @@ -33,8 +33,17 @@ ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
>   
>   ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
>   {
> -	return image_offset +
> -		(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512 - 0x8000);
> +	u32 sector = 0;
> +
> +	/*
> +	 * Some boards use this value even though MMC is not enabled in SPL, for
> +	 * example imx8mn_bsh_smm_s2
> +	 */
> +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> +	sector = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
> +#endif
> +
> +	return image_offset + sector * 512 - 0x8000;
>   }
>   
>   static int is_boot_from_stream_device(u32 boot)
> diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> index 070933fb54b..af083c3c38f 100644
> --- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> +++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> @@ -190,7 +190,7 @@ int board_late_init(void)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_SPL_MMC
> +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>   #define UBOOT_RAW_SECTOR_OFFSET 0x40
>   unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>   					   unsigned long raw_sector)
> @@ -204,4 +204,4 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>   		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
>   	}
>   }
> -#endif /* CONFIG_SPL_MMC */
> +#endif /* CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR */
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index af43b5f5d3c..55a42a3a7c7 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -490,24 +490,45 @@ config SPL_DISPLAY_PRINT
>   	  the board.
>   
>   config SPL_SYS_MMCSD_RAW_MODE
> -	bool
> -	help
> -	  Support booting from an MMC without a filesystem.
> -
> -config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> -	bool "MMC raw mode: by sector"
> +	bool "Use raw reads to locate the next boot phase"
> +	depends on SPL_DM_MMC || SPL_MMC

This one is a weird one to me, we can have DM_MMC without MMC? Shouldn't 
we fix it?

>   	default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
>   		     ARCH_MX6 || ARCH_MX7 || \
>   		     ARCH_ROCKCHIP || ARCH_MVEBU ||  ARCH_SOCFPGA || \
>   		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>   		     OMAP44XX || OMAP54XX || AM33XX || AM43XX || \
>   		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
> +	help
> +	  Support booting from an MMC without a filesystem.
> +
> +if SPL_SYS_MMCSD_RAW_MODE
> +
> +choice
> +	prompt "Method for locating next phase of boot (e.g. U-Boot)"
> +
> +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> +	bool "MMC raw mode: by sector"
>   	select SPL_LOAD_BLOCK if SPL_MMC

We can remove the if SPL_MMC here as SPL_SYS_MMCSD_RAW_MODE already 
depends on it and this choice is guarded by it.

> -	select SPL_SYS_MMCSD_RAW_MODE if SPL_MMC
>   	help
>   	  Use sector number for specifying U-Boot location on MMC/SD in
>   	  raw mode.
>   
> +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +	bool "MMC Raw mode: by partition"

Lower case "raw" here to match the two other choices?

> +	select SPL_LOAD_BLOCK if SPL_MMC

Ditto wrt SPL_MMC that I brought up earlier.

> +	help
> +	  Use a partition for loading U-Boot when using MMC/SD in raw mode.
> +
> +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
> +	bool "MMC raw mode: by partition type"
> +	depends on DOS_PARTITION && SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION

This can never be met, as SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is 
another option in the same choice.

Cheers,
Quentin
