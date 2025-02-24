Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB2C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 10:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3B780079;
	Mon, 24 Feb 2025 11:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dscE6dv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07729805C3; Mon, 24 Feb 2025 11:55:00 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFE780017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4gq6SXe7rD0aVI+JMGPbtvJYX4DJHpmjrI5ALSyLTsESQ/1H7MWe6M5ihs/6cNN/k/pnAWRHIXVpF1S/gB7CLqqJhuFhUlmYKvA0VqT6X/zKz8IsQSvXD+xdiHvpXbJ4lvyXepMCQsRCsbnpgfrv5ZwAULaQBltI39h+ZAP92YipN3Cc44L6LOdXlxvF+MQyKN0ZqiNOFH5KQMYYuwrVlxaedP8vnRYLIMJCwMh/tcq1E7yfwGat2pNIHrDxoM/7MURcvHccCNg32J7PKagYKgFhcvaB9DJklu05R6IxPts6R/4UFVMzixeLjWhxnE+lg6Sn4KGa0DlrD0bygDctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cn193659ihMpx2bbw4cP1GSO8mLT6W1x7zkes9Ibk4=;
 b=OpMncMHp9S2x+1W6/y4X/ZjL9qsIIr1H8hrRMloswe9Vdg8Vbtf/EuLOUOSrHK7W0CvxonQumCteJCVVVurJbBxL9d5/Nk6WCN9p9joaLtqpoY+d2PsoAagRpkIh/zZ5Zx+Y6C7RJG+xE1FApA8fGqj2tt97W3V+k0dEZncY9l4tSQDAlfUkyQpYgN2KICgCjYB4P9FtsUeaNCq41XjNkx+s9p18JrNOuhQG6ljxRtwjGTmlboVMIt75ZXGfEz0hQCrSTGT7lqvynb/UR8IqJYmcClpv7YwhfZCq95v+nB7ifuUAC8DnpAjnZRzq2xgRXai6N5uK5/GwSVYSCQ65xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cn193659ihMpx2bbw4cP1GSO8mLT6W1x7zkes9Ibk4=;
 b=dscE6dv9k4s3OrUauIjSwHZ4YwG4Y+Dh53/yQgsk+8ydc8nhF1NN/5Mge5xm6dV9oamhIr1MK2oWfLgrykYM4MqOl/iAq0xaBdI/3fmnqOj5jVuKhUuL64WjP0v1lFcry8hfISgfshAHl2WU1/Qe9dVAwEVoV9lqfTL0ACb93hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10458.eurprd04.prod.outlook.com (2603:10a6:10:565::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:54:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:54:56 +0000
Message-ID: <19488fdc-2666-4407-b49b-d25085c98453@cherry.de>
Date: Mon, 24 Feb 2025 11:54:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Need help with booting from SPI Flash
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: c08b3621-1f94-446d-070b-08dd54c1acf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmN1eDREYXJrVmlTbHExTG5DWkpzRzQvOVQ3NjVmUGNkRjNNbGJTVjNTb0xT?=
 =?utf-8?B?SlRERmRlYXI3VkhkakErd3JKN1BPdGYxRTRGbHNuZUY4T1V6S2ErTUtNRFVj?=
 =?utf-8?B?UWg3VkJvUXhjdGwwUnpHODF6U0JNQUx4RWc3bEU2MUFmVUtWK1RBa2pEUkMx?=
 =?utf-8?B?UlQyYlc5SkZuelNLRU5LYm1EaExCazFmZjlmNklUdVpIY3RTQUN4cGY4S1o0?=
 =?utf-8?B?cmU5S0hJaUhLcysvSCtBOUQxRXg0SHF6QUhHRXVPR0h3VWd6a2FQL1ZNQlZD?=
 =?utf-8?B?L25mdUc3cWkwYm1rc2ZyeUhialpOMWYzM3dvY29PWXVsYW5VaEpmWGpXaTNB?=
 =?utf-8?B?R1FENEFBOGxTL0Y0OHhLUVdKOUljM0I5MXF1QS8vWFRGNmRDTTRyQVJ1Vjhv?=
 =?utf-8?B?cUxlQzVDVDNSOWpXMGgvWEg4Vms5U3N3RHZWTHF3eU5OeGJYSUtFcWo4bis3?=
 =?utf-8?B?aWUvdHRaL25nNEVKTnkvMEFZT1pOVHpNdzJzRmt0ODMzMG85c1FPMC9Uck1u?=
 =?utf-8?B?V0J0QmErVFgzZ05GWjQ4QWNVVHM1RUgyQ0Q0YXNVd1FWU0FUYzRPbnpnb0hr?=
 =?utf-8?B?K1FLT3E0SUNtTTV6bDVOYUtPMTZKTjRuaHY5bWRCQTB1TndMRXFEL292K2Vh?=
 =?utf-8?B?NnF3cTZFYXRtMnVyM3YrUE96eW1CQVVFRzhONjB1OVQ5VU5BM3RtZmZyZDJk?=
 =?utf-8?B?ZnZid0xHcFU3TG9HN2FVQmlscVZCT29ZVzdTWGNBRk9FL0dkWHdid2FjYWRJ?=
 =?utf-8?B?RmJXTklmMUg0VXRZbHIvM3RVYXF0ckZTZlJzVVBRVEVZVU84OEtwTHdnMXdk?=
 =?utf-8?B?ZDJqVVZYZnYrdU1ocURhUWpnQ3hZaHpJaVY4VlFqY2ZCRFE2UDVIY2l0MGNX?=
 =?utf-8?B?bHZCeFdFMThFQmdvSS94L09pUWNqWWVsZUY4M2dOemcwK0ZwNEY1Vi9KcURo?=
 =?utf-8?B?clAyWndFdStFWS9uS3BqRE5ScE0vcnhqSldJYjdhS05Cbmhtb0NuODlCSDl1?=
 =?utf-8?B?SU02K2JIWnZtZmlOYUFQT256bmF2eXFkTHRReHUrOFZQZytGNXR3Yy9KZElY?=
 =?utf-8?B?eGFZVzIxSEUzeGNkdWZ5K25VQTI1SWVyMVIwUWJXeW5lYVhPNUQzZnBudlRj?=
 =?utf-8?B?OGoyYlBRdlloNERmVURRNDc2Um1TTkVvL3ZhQVhKaTQwZnd3WW56Nm8yUTJK?=
 =?utf-8?B?WDh4TmVFNDJiYk9pK2cxSTFRTE43aWhaZEEyYzZ1SFcvY05UaHd6UEhxbFM1?=
 =?utf-8?B?a1pwTlJnM0hoR0dtMHAxRlYxaWJadWNnZ3VDMURyYjBQWk1jUC9oSGNwdVNG?=
 =?utf-8?B?YzY2aEIyYmRvT2FtWUhuTFJoL256VE0yUjdSUGVCNnJTOWo0VG5MUTVPUEt2?=
 =?utf-8?B?am5yRGNkenl1cFArNlFCaVBaUWJpZDFWN2FRTFRNUDhjaEQ1WmhIdXp5ZXAr?=
 =?utf-8?B?bVFmSUNZZ29KU2t1MUQ1emhWdjNKMWl0bXIvcjZsN0RTanVtOGVXWTZzbnhj?=
 =?utf-8?B?K3A2azFRYVJCVTJSSERDYk9mZGp5QXJEZEhXK2xyajJ3Q2EwMG96Q0ZMYTBt?=
 =?utf-8?B?RDNRRUZXdjVVR0F4S04wU1U3UkgrZ0lSeU9CalRWQTVSa3h5OTlGVkhRN3hk?=
 =?utf-8?B?Y3MrcnEwSGVJSElNbU80UkhpMHNZaDgwM0hEUldSaWZVbkMwZUxYMWt2bVVT?=
 =?utf-8?B?MUFqb3pxUkRGRC80bUZpdHJreVprQXh6MTNaQ2RrTVA4Y3dnbzc5NXZ3WVk3?=
 =?utf-8?B?ckpvc2I1dy94TVk5MzBhUWF6SkRHNDN2Zy9NTDFGSDh6c1BDTlhDY3pYK1F5?=
 =?utf-8?B?MmFxWEd2S0RjQmNXYjUwV0RxRGVUUXpHUG5xbjIyTkdkTXo3ZnFOZk03cHdB?=
 =?utf-8?Q?lyKWp8NfH10u/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVWYzdydHhqMXFSenhyUUQ4QUhFclVqb21keTZRandWSWs5TkgvS2JIVXhB?=
 =?utf-8?B?SjV0OWFKdGdnSTA4S2U1T3AxSFFvU05Ga1c0Ry9hVFJDTFpQRWtma0tLTjZH?=
 =?utf-8?B?V1hpZStXWkRCUkxVME9MUUNENW9oMk43WHlOWlJoNmlvY0NScVJxYnZrM0lR?=
 =?utf-8?B?NldvRXpIaFAwczM1N3BWT05OTlVzSU14ZksxQUpVeXdFL3pmNC9wSzRzVnBo?=
 =?utf-8?B?YW9ZYmNlWENieWg5TWZoa0Nicmp6czkzU3RFV0hJeTZ1dnlnU3pDN2p5bmIy?=
 =?utf-8?B?TnlxRU5lbnBhQVA1NWk4VUp1QUVlSDVNZWRSOXl3Qi9RWVBGcGVaUVcrd21w?=
 =?utf-8?B?UVdxU29Xck1weUI0dFFXWmpFTlVyYnBZSmI2TWhKZmpJZzNyVzVOcndHMngw?=
 =?utf-8?B?SnZ3VnJMOHhNY1lhSzNpZUU5RzNBaStnYjZMdThOcjdyUWQ4bTliNUdYeDNj?=
 =?utf-8?B?b1ZCVDJRTGNkZVd6OXNURVFXRWJUUWFxZmlrOFlpVUY5M2EwRnYxamFaTC9H?=
 =?utf-8?B?SElhN1lpTTZUOERzVFVHOE01RUlIWWhhcExWTmdHcFMvSVVRNzg0RVRsR3Qr?=
 =?utf-8?B?eUN1VW0ybnZ2MkZtRnc3NnVlUnVycEdhdGFLNmMwRnBpVFA0MG9vZUNZZTha?=
 =?utf-8?B?dUNOUzlxMTZkSzQvdStrL1c4eHRoSGJKVDFsbENqWFRrcHVXS1Y0R2xnZndJ?=
 =?utf-8?B?UktSYWY5d2t4bllsQWpXTWxMWUpieWNzUzNVSWhEbEQvL2UrK0N6aXFUaW9k?=
 =?utf-8?B?Y0VrVG5vVTAxbUo1MklTQU5VR01QWFF4c1pjc0YwNERMOHpxazdSUzAxclJF?=
 =?utf-8?B?M2h4aFZaNDFpbTV4VGNLWGE5OWdiOXlBcUJVRW4rQTVUTm1xNFltWnJ1c1Vv?=
 =?utf-8?B?RjdpMlB1WW1XVkxDalczRVoyNUFTWm9YazljYlYvTyt1YUljT0wrV2I3NjVm?=
 =?utf-8?B?OHlJMzF1cGdHODJ5S25tcGxOTXZDMXA3SytqVWNzbGwzdWE3dlZ0SHd2VElK?=
 =?utf-8?B?Y2twbmlEZ1dNV1ltYy80YTE4QUZZSUxsL0JUd2s1RE9RclNMdDBrTTIxeWpH?=
 =?utf-8?B?eEo3TjZYN0pKNjZscjZiSHArOStDaENpU3NpcFE0Zkc3L1JoZUs4dndDME5a?=
 =?utf-8?B?NWRxQkNlYzA4YUk3d0R2RUV2L1Bia3o4eXZ3Rk9SbDl3SG9iUHcwa045Ukpp?=
 =?utf-8?B?eVdNeEhkeFQrMjg1UHhza0dtQnliSThWTE1HdDI3SjE3ZFRRZE9Ga0M0MEln?=
 =?utf-8?B?RmtoK2x3ZzJGVldpZitJTndWYXVjMVlzbHV6RUd4d25yM3Awd2lnTEplbjlY?=
 =?utf-8?B?VW5WS1NjSzduV2txL2xOenFyNHJaQjNXMFNtdDZxV3dvbDd3bWdhUTlaVlMr?=
 =?utf-8?B?U0NTKzBxVlNEaTV4N1A5c0s2OTM3SE9OMHEwZTB2QnNkSGpFeDBaZzNQUnc4?=
 =?utf-8?B?YTh1OTVwSFFmSFJOWm1kcTVpUGdHUVR6VVROY2h0dkJxQndTK2h6S05kZ1VC?=
 =?utf-8?B?dnFnYUdUbnphMFRQNzlqS0I4THdXSEF5ODRTU3djVWkxZ2pqcHB4M1hNaXpt?=
 =?utf-8?B?NkE0bVJEbTVRUWR0eUo5N0Y5SFF2NVZMdCtMYVNoeFczUHhpUE96SzZpWjlG?=
 =?utf-8?B?bGl0WVp4ODBZU0JzVDRScUhoR01ZbUVYbzdCVWZTWllmNkpCcThHdjdRNVJ6?=
 =?utf-8?B?Q0dnOFRPcGlxaENLbit5YTdlcU9JOC9USEoxVCtTeXk3SEUxdEFpTUdxaDY2?=
 =?utf-8?B?KzRsQVd4Q1pnaTRoVXhpeXJGOWtrc3h2MUxuRnp2VWI0VEo0UFUrUFI1ODBh?=
 =?utf-8?B?MVB0cU1PZ0NNNDNOcGlraElaOG4zSnROWTM1Yitmem94aERnWWg4RitBbDhs?=
 =?utf-8?B?QjgvTi9wUnpHTW8xN1U0eGtxY2pWR3N5MktpajJHd0FVcjBJV2l0NmNvK2pl?=
 =?utf-8?B?VnVYTmo3VEFzc3lnNTRqenV4eGU4VkFXM1g0UWR5MCtsUXhUMFFWOFh3b3dO?=
 =?utf-8?B?VW9LeDM1d2NhMEtIaktSR2dyM1RRMnZZWGxMOVVIbFUrQlRnTk1QYnltd3kx?=
 =?utf-8?B?VWJVSlRscE9hWlp0V3ZiK296L3dZVXh1aE4vaCtJN05CT08yMUNDbi9IWStl?=
 =?utf-8?B?Y0ZSMkpzR0F6WjlHNVRvcGNwYzc4VDAzZVE2UjlGZ3dXSEt0a3k0VEhrRW8x?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c08b3621-1f94-446d-070b-08dd54c1acf5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:54:56.5202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBM7Wz9j54SeZzxzqIAXm3DRH8g3KQKp6p42oLlc1wsN5tos/P3lG5HKS2AbA9C5hjxPt69k4XG0yO/H04ATzKh1Sifvq1fo8SBQ6JYo0W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10458
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

Hi Matwey,

On 2/24/25 10:57 AM, Matwey V. Kornilov wrote:
> Hi,
> 
> I have an Allwinner based board with manually soldered 16MB SPI Flash.
> I am trying to place u-boot into the flash and need some help so far.
> I have already updated the board DTS file and checked that the Linux
> kernel provides me with a /dev/mtd0 device which is writable and
> readable.
> 
> I enable the following config options additionally to the board configuration:
> CONFIG_SPL_SPI_FLASH_SUPPORT,
> CONFIG_SPL_SPI,
> CONFIG_SPL_MTD_SUPPORT,
> CONFIG_SPL_SPI_FLASH_MTD,
> CONFIG_SPL_SPI_LOAD.

Make sure the driver for the SPI controller on your SoC also is enabled 
in SPL.

> I am not sure that I chose every relevant option.
> 
> However, I see the following message from the bootloader:
> 
> U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 12:43:35 +0300)
> mxstatus=0xc0408000 mhcr=0x0000010b mcor=0x00000003 mhint=0x00004000
> Trying to boot from SPI
> Invalid bus 0 (err=-19)
> SPI probe failed.
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 
> Are there any obvious things I missed? How could I debug this?
> 

Can you check your SPL DTB has the SPI bus and flash node?

dtc -I dtb -O dts spl/u-boot-spl.dtb

If not, you're missing a <your-board>-u-boot.dtsi in arch/arm/dts/ where 
the SPI bus (and most of what it is needed to enable the controller, 
power, clock, pinmux, ...) and the flash node has the appropriate 
bootph- property. I believe it should be bootph-pre-ram for SPL, 
according to scripts/Makefile.lib (fdtgrep_props).

Cheers,
Quentin
