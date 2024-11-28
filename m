Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C26D690FF
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 11:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0762989883;
	Thu, 28 Nov 2024 12:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MsEJ4gHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4835897FE; Thu, 28 Nov 2024 12:48:21 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8631489884
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 12:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIaSAiKiRmYNaIyDbAYHO/FzhaftKDl3MxhgK1uMKzHP4ZtL0ZWoyWm5o+BtjgxcXsxFpoRsQhrokGQCeApaFb4rbuNUfBbc64oGbkxHzDcNOwd6hw4D/sQ9US9LZ3lmJUSs4UhblM7jE9Tqvv2X9DaoYL6fetiiUer0zMcBFwsRerDkGCF4MmElGwaozRo02sq7YUhYnTl7JM8xo8oRQfRzLtcdQ7xp98ZU1Wyy9bnLM47gYDTiDvrtTuz56MSIM/1AQ4a9sW8PVvkJ5J8j4pQKQ/sSEvgSEAyYajOknD2YN9OzwrIR6abEA+6q3A4VPHDQD/a591IWN5zs73CbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csgc0WRQ7eZgBdzEx9RkupOpuUBREF9SuZ09akjuXpM=;
 b=OOixtqeKLqugGTvljxgec733crRzkVvW1xDX2NMZi1FW8yu4kZydI3Paph8xag/XzjBlmgYY3716cOTGVq6wSWHltRtIJnHtU4h0zxRBRNN9ynrXAJYKboHNXO+OvztUnCDXxll30o0q3Tsy65pTB/wpo4ZswNJ1muzkyGxnMB6uXqE8z7RPLJxwoD+7GhBZT929ZYg+YBvtD98tUkFhIa91v+UzcB9EslYvNLi+CvbFuGVT2zYu8Vbrm15B0w4gHh9QR4Qdrh6eRfBNSEeeMoWpf6D3zw7KqdQak29X8LRxUxssB84mAuKNkrNSe5wjnojrpM6KEAk70m3zH6BIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csgc0WRQ7eZgBdzEx9RkupOpuUBREF9SuZ09akjuXpM=;
 b=MsEJ4gHrzdZQvNopIcv52mDINEP/1gRhch0h/ml2Jy4xEHLOHUeGvbgqjFaMcFr7IDZyH6BTMFpay7cMF5b08BNQG2WmlgWM/U6Ivt7SWPDSUQIyN4ECxHYMeOEYE/Wy5xh+TR7f83yWGeVvUMUN9+HDCbbFwQyK1zW229ugvio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10891.eurprd04.prod.outlook.com (2603:10a6:102:489::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 11:48:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:48:17 +0000
Message-ID: <d1218a1a-ee2b-4db7-9675-5db6f440bab4@cherry.de>
Date: Thu, 28 Nov 2024 12:48:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: imx: Make DRAM coding GPIOs available in
 all phases on Data Modul i.MX8M Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20241128032623.269459-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241128032623.269459-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10891:EE_
X-MS-Office365-Filtering-Correlation-Id: 235e39d0-0e6f-4390-1245-08dd0fa28c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRScXo0WUZBZXFOT2tUSXlCcERoVUk1L1doZEdSMmJaTDBKTndqeW5ZQVBj?=
 =?utf-8?B?UmVHbFY1YUU1ZXhMY2ZGd0VyZkg0RUdBTkE5c2xsKytWL0YvRXdINHpuR1JZ?=
 =?utf-8?B?M3h1WHVnR2JYQTE3WkNBTGhhaHRxamtBbDJxS24zL2RldlRQblduci9yZ201?=
 =?utf-8?B?d2pEaWFzZEEvQUQ4dkhudyt2Q1grTEdwQXpKbC83NTNyMEFPVmk5MEhCVTJt?=
 =?utf-8?B?NGh0Y3hxSCtaZzNzQlQvTndTWHZaeEZOVmtMMFR5SlhScjRzYThjNU9yWE9K?=
 =?utf-8?B?UklxQ0g0b1ZiRjVJb1FUZGhrdW5oc0ZpN1doczlWNU81YjBpSjJ4dVpKY05r?=
 =?utf-8?B?bGJNZVdYOEJtYWhHMnZ1Q2lLRkRtdTNyUUNncXV3dnVDM21hTkZxMGV1OThZ?=
 =?utf-8?B?NGJQbXJ6RnF4TzAyTFQvVDVmV1F5LzFNSUkvbU9JaDI0bGQ4d210cDNiWWww?=
 =?utf-8?B?dDZKTEQzU1BrT1doZlNSVFBFVkNWSkE1VUEwaVdrNmxPT3ZoVnJqWm83eWRp?=
 =?utf-8?B?TUkrMVZhZU5PTHM1RTBCN0JPSUMycDNCTEtOSmZrL0hzZVp4QysvQVFwLzhu?=
 =?utf-8?B?TWxHVnNZS3g2T1FtRW9uNlhyK21MOUVpbUVtam1MQkRKTXlhT3prUmRPRFE4?=
 =?utf-8?B?eDhmS3VyOXUyR1dpSVBvNjlZL2NOMHdpVG43YW0yMUh4Z2UxRlNpSjBIWjRx?=
 =?utf-8?B?TFlzeUpnSWNDL1FYeEFmd29UWUVCM0FUV1puY2lRdUZPckhIQmF2RVJRclJw?=
 =?utf-8?B?bEpIbTJ3ZFFNaitMdE1RanhGVzVxK1VCYncwZHR4K1dJQ05nK3h4aHAxQUtz?=
 =?utf-8?B?bDJ2OW5nbkN4OThGaHJTRnY1N3hzV3hVTThaeUZ1UnRiUGVvSUJFd1d2YTZs?=
 =?utf-8?B?MjNUWnI5WEdRcGV1UUZXcWxKeGdqK1ZUbzZ1NHBrVnhmc2V6eE5HdlNnWkR3?=
 =?utf-8?B?YmRzaHFZK2RiUDREWjJJN0xGTVRZbUN4S1N2RzVtK3VPbi81clhTSE1FUVhm?=
 =?utf-8?B?bmt5bVV3bWEvY216cjVzK1FKUzBydGdpRDNqdWpYbWRUOGtZU21CNnkrakVr?=
 =?utf-8?B?Nzd6TlNuYVpUQmJyK1ZNWndEblRxV1ZBbUExeXBuODZrVFN4eERaZHJnVmhN?=
 =?utf-8?B?SU5IbEpOSk5nVGV4NkNmU0Vzd3lmbS9tS0JlZEJ1bU1VMXRSZFJORWRtOUtw?=
 =?utf-8?B?cWthNTJ3V2dZWmt5UWYwWUxiMG1uNG1Fc0ZOMGhlaCtEdklWUnF0Mnl0Zzdl?=
 =?utf-8?B?aTZ2ZjNqcFhpRUEvZXVLdEdSR0xkRUpPTERWSHltcVZEUEhuRjJGWmlXNXA1?=
 =?utf-8?B?d2VQT25GaU13aVU5b0pXRStuNEI1WW9kaGNrZW9HMUtsWkREb1BCRUNJK3FT?=
 =?utf-8?B?TUhIWEJkaDcwLzI1cmNYd21IUEpJbjlnL3ZnZUZKLzI3a1Z1eU1JVUxjZVpR?=
 =?utf-8?B?L2F0cS8yQmVFSU94WDkxQXprbTdsSnF3RFJGWkFKUTFHWUw3Ulo3aTJBVjJy?=
 =?utf-8?B?TFJCK0hoTElhSmJKck5TT0hrRTIrRVBRSXIwL0Z6YnZRbFZhU3hnVFkvYzlW?=
 =?utf-8?B?UGR1QXk4Ry9CVWFnUXNxZjhXU2RGSmo3SW41TGN5bENhRzhVWU9vRjlNMWZ6?=
 =?utf-8?B?N2l6Ym1nWmVCNldPNk1VWGJOTDZlZld3RFE5OE4wRmFTdUV1aXNiT1ZVRVdT?=
 =?utf-8?B?Q2krMmJreTB6SVRWS1E5cXhUdjZpZjhNbXRTOTRsZytSbG00dzhtWVpGYmV6?=
 =?utf-8?Q?Wtz/mDLymVEC8+IoKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHU3RWhSeG01NU5ITGtvTmZ3UjlHRW1SMG9qQU5zZzFLUjVxT05UTkJiUCtC?=
 =?utf-8?B?T3dPWWlGKzBiZVVka0htRjFUd3A5WlFCMUpadlJHUkFFWVVqd2t5OEd4VHZT?=
 =?utf-8?B?aG9nSFRvVmptSDcwMTZRSjZvQm8rZWpEdDRHS1lpcE1DdVVHM0N6cExGdUl3?=
 =?utf-8?B?ZEtESGRKZUhmc3FvRXFHZ05ZKzlnNE0wUWZDRDhtN0VUSG0yRmlxSC9GdGJP?=
 =?utf-8?B?ek5pUC9HYVhGaXk5SXlXMlpzK0JsYUNLZm4rbmIxaHNFc3hLMEJkNFlaQi9r?=
 =?utf-8?B?UXppSWI4Y2RHd2h0c1lQSWNIR1BVdnd1UWx0N29OZUZRcXVTV3U5RGJLdTBk?=
 =?utf-8?B?WXZIMC8rcEdWSThPdEpsWXJZWnJFNWhPZ1gvN1VuUUJKWkdiR0R6SDZiMUNG?=
 =?utf-8?B?d0NGbHFYbzlkL2FWWThnVTJTa2ozSVhVeUpyalY5bGVoYnRRTEM3MDRqQm5Q?=
 =?utf-8?B?Z2lPVjFkQ1BjeU94Yk1Mb2Z0ZUY3SEQ5cFdic3BtK0JEM0p2S1BSb0s2NUU5?=
 =?utf-8?B?ODE5eC9qOVB1SGovQXVzLzlyY0RFYktiWURRMFpJRmo0VDQ0ZFczM3E1UVFW?=
 =?utf-8?B?ZytPWFF5OEMxSGRWYlQwam1KL0dSdS9jZmNvelVBNmhjZ1VkV0FPRjJqR1dO?=
 =?utf-8?B?Z0hWQS83Z0x0MFdOM0llMXh0cyt6U3VNdW1wVEZRQUtVZVd1Y1JOVUovdkNa?=
 =?utf-8?B?bHFyUnArWGJzZE9zM1NDaC9aVithM1Q5Y28xazB2ME15V2M2S284amEwU0lN?=
 =?utf-8?B?UktkazFHM3paMW50Q3dtRGk0NzZCcVA5U3F4dS9GWkZGUjNzRklGeFQwVjhM?=
 =?utf-8?B?L3dQd3ZkT0lqeEJZM0hMcnlhcHhSSWE0NXZPOFoweWpKeTNkRkQ3VWZ1QVVy?=
 =?utf-8?B?QjJGbGlweWxtWUl3YzQzQW5TYmxPZk1RMVBocjhNYndIOUExMWFxTVpGbE4x?=
 =?utf-8?B?TU84V0p1NFNlSW1DbkkzZXFYZ2wxMjI3ai9mWXpLZ0kvMW5jK0lyaFdqWFNF?=
 =?utf-8?B?VU53RGlobzlGMEJMWkhUUTdpc1BQV1VqcEF2alcwRmwycjVSUFRqbjdsNHY4?=
 =?utf-8?B?Q0kySlJSM1FlQ2dtUlp0Y215UVY5NUpNZHQwbzloRFhtaUY3dWxCTStjVE4r?=
 =?utf-8?B?dlhhT0U5ZGtIQjBQeVIvSXFONVdCWTJPcTlUdTQrK0w5YVlrODNBbFZpUHZx?=
 =?utf-8?B?Wk5tVThLTkNnQ1NHVk5Pei9KejVhOFFYdGJqTEJQeHpIMURRZWJuaGxrVjdK?=
 =?utf-8?B?aWMvYmtEWWwrOHlwZlI3ZEQwdEJPZytVWHFWMzZpQUJBaHFjeHFnbXhrVEd0?=
 =?utf-8?B?TVgwSUZpUklXOFhpUDlBY3lDaFpjaExzdjRIMUsyMTB0QmxpTHNJTzNTUkhW?=
 =?utf-8?B?TjZPWmpwZ2tWRUg5TWVsaUk5bTAzUnJTRXNSTzNsZkRFYld4TmptQXJtdGgx?=
 =?utf-8?B?NFRXZVRzMFBPRUhVMExPK0tRRlRGTXYzWWpTcWJuVjJEc2Y3djlaZzRmQTM2?=
 =?utf-8?B?TlVwK28rSzJtVG8zVEtBYW4wUjZFbXh3WWthb2FiK2pLNHZKMTNKeW1tQlFU?=
 =?utf-8?B?c1JCSjhzT09Idi8rRVJoTzZjU3I2UFZ6NWNJVm9RSzZrc2NNdG5YQWkxZGhJ?=
 =?utf-8?B?WkxoWk5iVmdIUkJ6cGpSWmV1STZBWjZ0VTVWTTJTY1c4R3ZiZ2pwa2U3Tm1l?=
 =?utf-8?B?YzFkZGhFRUJBd0JiVlNJNUVYM2pBVmEyaWJkS245dHI4Uk93Q0dlOWxhR3Ra?=
 =?utf-8?B?cUR0TkJKdUNOREtHeUhqVWVoN1BYUWFMVjE2WXZmSU1NUzdacVV3UEpqcDha?=
 =?utf-8?B?ZmNqNStZSEYxQXpLeXpCeFVzYlVJMkpGQ2V5MHRrU2dEZG9mcnJOQXVXVm0x?=
 =?utf-8?B?Y1c4SXM4eXFzcGtSRzJWM1k0amxEYXppL3pZbW5rbUFSaEg3SytnY2NEeFRH?=
 =?utf-8?B?SWU4bjAyZTAzZk11TGJFWmcwdEV6TXliTVBVcGUxdG5jbVJkeTRMOE4xQ2tq?=
 =?utf-8?B?U1d6K2FOWDBjWWllOVhLTmhpTW5Zb1N5akNMdENoVTNjUXFWam9yMytmSTYz?=
 =?utf-8?B?MTlqcnZoZWt0MnF1WUNRWGxlQ2MxTVVTMURKTDQwWmFYbGJ0cURVcGZ3YkNU?=
 =?utf-8?B?QjFvbUlmanNtTTV6Z2gyd0g2T29HYWI1azNJbUYvZEdMM0Rpd3JkU1BTM0Rt?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 235e39d0-0e6f-4390-1245-08dd0fa28c7b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:48:17.4025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps1nS84VuNSKkFR/6ccxfsXo9Wr8Z/Wtm8frJdEKnVeV+Trtxjogl2S4bGj6vUOagQfYpdbyPbMP+l+r9W6PsS35TkJN3qu651BAwcn9ey0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10891
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

On 11/28/24 4:25 AM, Marek Vasut wrote:
> The DRAM configuration GPIO straps must be accessible in all boot phases
> because the GPIOs are sampled both in U-Boot SPL as well as early on in
> U-Boot proper. The already present bootph-pre-ram DT property made the
> GPIO controllers available in SPL, but not early on in U-Boot proper,
> which made gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
> fail. Add missing bootph-all DT property to all GPIO controllers which
> are referenced in dmo,ram-coding-gpios DT property to make those GPIO
> controllers available early in U-Boot proper as well.
> 
> Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schema")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: For v2025.01
> ---
>   arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 1 +
>   arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
> index a235e088fa4..babe51ebdc1 100644
> --- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
> @@ -77,6 +77,7 @@
>   
>   &gpio2 {
>   	bootph-pre-ram;
> +	bootph-all;

aren't those supposed to be bootph-some-ram for matching U-Boot proper 
pre-reloc? bootph-all would enable it in TPL as well (if there's one on 
imx8mp).

https://docs.u-boot.org/en/latest/develop/driver-model/design.html#pre-relocation-support

If not, isn't bootph-pre-ram implied when bootph-all is selected?

Cheers,
Quentin
