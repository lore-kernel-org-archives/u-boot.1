Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C14E64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099A58961F;
	Tue,  3 Dec 2024 15:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="amqBXzYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682EB895F3; Tue,  3 Dec 2024 15:37:50 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CC588E31
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtIVimJzSHsGHW99HPYVpCFIVbx59+t5eSFhenluWe37FSvy5ZIDqStcBto1ZJ234IlOhKhGKDcrlcIMYKEYlHujtywBgPsDjkxWS1Iom0ZB0fYGlMu/vwGsoZnFTrc9NPKZKvFETNOfs3naovYgSD9U6u7VAL+KCwDdyPE7eQyofFCvFUHH6sJHwU8VAG4oTn5bgOcZd2a/F+HacaoMxBVNXEZWkWhPaMW4AP4u7VrHHOgA0PIO09JoHmxp0cRfgccLHIw05mB3Sbu6YiMDnWnBh1vJATAQ+MeBHf/Bmrzs1DM2y5lP5bwahA4OUNhHH2bNPQFQy2Ck055nWkjntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMuDnhOLJFH/0DUe68ENlcZteb3LzHCEeY4llQOxJ5M=;
 b=a23qlH/EqgkbFBeS4b6WRktYYa+B0Tq2JpIvmSuc2nojOZ8RNBuZu9nMm1x+L1CXluyVv8TxtahZCFIA6H9l0NKVfbAFxXV+rgGJpYKCdQMw3hQae17F/NnT2VoMn9+yjiHALGkU5MoUL7ncjWjTls+A4WEK5FnS/hu7fd8W8TuEMMBdjrE4qXBiIhxDUBXPlyqlQo8VLmeZhdwfhReT76p21c34HUGzfNnQx7zYyhncu34/7VBQyzln37kx1w9lpJWgne/yX6kp9bbarUhA5nUy7MN9QFEMiaYQFyxjKh6idofrbzt6JQ7aI2YCZXIGOkvBxoLqtmCsjJC3JgqydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMuDnhOLJFH/0DUe68ENlcZteb3LzHCEeY4llQOxJ5M=;
 b=amqBXzYF2yEctsgYsSwysaSARe2rnZq2LwkFJIAnHMv3x+kKR6wUECp/rbUkv/S5g6A9UXus9JHAgHtKtOaCPYPo4ISAIzEnUI8Qbp7M+DVkpaH1BtjFhRvagAlM4e66jCa1MAEYzSCaAVgO+cw5b9OFro0ZpmszNbQyNyztlvxw5Eud8eiFo8psalEFB7B141cB6GoKsmdssbbTxlac1/hCAFnmBB/4dCjjG96cAXZmEKBakWLqZIc+1mrhsFImA/rtvh4MxdU2hQ6lOCAsh0sIjkb8HaxKLF7miSWi7NgNmdx+zpmFEeEtGZ1/HgzWKTnvKMpJH9KUZctWbChbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/11] imx: add i.MX91 and 11x11-EVK support
Date: Tue, 03 Dec 2024 23:42:43 +0800
Message-Id: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMmT2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ2MD3czcCktDXcuUVFMji0TDRJM0IyWg2oKi1LTMCrA50bG1tQCNcHJ
 XVwAAAA==
X-Change-ID: 20241130-imx91-9de528a1a4f2
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2e2b27-1abe-4dea-315e-08dd13a80cb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1FDTncrVlZPZTJXTVc4V3VkUngzVnRMVkhiME1LWmZVZk94RFpmMkJEYjMx?=
 =?utf-8?B?QjR2b2VBSm8xTUhMY2Qzc254M1FIWFIwUStRT2RGQ3pFQlUxTXBPOW1XUXJj?=
 =?utf-8?B?N0xRbzdEclRIYXJHaFFTVGFFakRZZXFNT3B2NDRPZ1Nld2RmdlhHNnVNdzBB?=
 =?utf-8?B?Ym8veEt0V0c1Ymx4eUJvTDlBb1Y0cjB4WXJqVEJlR1Uza2UvZ0ZjUDIxcEtk?=
 =?utf-8?B?R29QYmtVUEtyMEtQdERCWFVQWFlMR2U1dksvZGx5dVNNOXpLaE0rV1NISEdq?=
 =?utf-8?B?QWxxdHkySi9BNkJ4QWRoVFdRcVpXRzgxc1VGTEJIN3FyN2M0Tjc4QzFaMmtR?=
 =?utf-8?B?LzFrUVJpdnFLMC9QTzFHUHNQOEVnWjFxMnVDcWZ1VERzNzFzb0hHMjNDalNB?=
 =?utf-8?B?Z2VTdkRWK2NXVmxzNHYxMFgvekd5c09QdUlieW9jQXU1bUpncXh0N0RIZUJ1?=
 =?utf-8?B?eXBRVFdzOC9LOVJXczlReEpMbmFVYkREUmwxTkF3WDJPL1cwS0ZsY015RmdD?=
 =?utf-8?B?NzdVQW5TbnJXM24wa3RaSlhiaHlPL0IzenBKR2hkUVViejQvNVFlcU0xeHlQ?=
 =?utf-8?B?bmU5NmVubGZZelVsL1ROZTZXVWQrR2RHQ3lyVk93QjhkbGREcitUNCtWN3Rz?=
 =?utf-8?B?cWh6enJOK1loQU9OK1ZINHZKM1BIUU1wclUwNmNULzdsS3lNM2xUbVFpUmRW?=
 =?utf-8?B?bngvUmY3ZGQzV05YSHNRa3FaQ3c5T3FnYlg0a0Z6RE94OWlPOXpueWZuN0J0?=
 =?utf-8?B?dXJMYXhNdGlTVldxOXRGU3FPTjlEcnordEo4dG5OZkVoeGJlRm5KcTc4Vk41?=
 =?utf-8?B?aXBqQ2wyWlU2TTF6NFcrVU0rZ0R6Qit6QTNmVU9SZGl1Y2NRUkorSlFKZDNM?=
 =?utf-8?B?NTZaR3BpN1pCNnFtOFpUMWlLY0hWSzdRRE9PUHJHdDJWd0RnMWM5TVVEaHor?=
 =?utf-8?B?TVlRdG1XNC9TVTJndFlnZWttNkN6aG5rSWxhQVkyNGRQajdrNmNJeWV1bjFU?=
 =?utf-8?B?cHI3eTg3dWs0VlBQWlNCVDc1STR6aEhFSTZtVWI3Z0JsYTNvZlU0NGxqdGR0?=
 =?utf-8?B?RHh0YlFYdGMxL05VakM4VXl1a0p6aU45cHg1ek1kY2Rab09Rekh5YmpzMnJ5?=
 =?utf-8?B?OHJYTlRjYm9XZjg5T1NVT1ZFejIrMFh3QUdzWGoyTW5JanVLRWp5R3o1Z2pZ?=
 =?utf-8?B?aGNjR2VRS1U4bzZEKzZDbVAybDlTSlRKbWJPZDVZOTVmSFlOSEVQNWVpS2dP?=
 =?utf-8?B?WFI5Sjgya2pPNFNSL0pmbHNDVXVROTloTnFOblpFY3FWcnMraEpCSXhDb0Jt?=
 =?utf-8?B?TVFaaGd4cUVmOEZ6cU1qdEN1U1NnUmJUR05JbXFkaXpZNlJ6cVhVRHh4d0tl?=
 =?utf-8?B?enMvOG5EZXRLTzJjSEFudjFjaEFQVUd6ZVFsa3lSaW02cERrNk42emJELytn?=
 =?utf-8?B?U2xyUHNtNzhNcmh3ckN5SGd6VjloSHluZHVHRkhoWlNYeEM1U0JwMHRBRnUx?=
 =?utf-8?B?bHpGNWRScE9yRko1V2xEcnRXM1RtS2ZHWUlDUWhVRHEvdHI5ZzcxSzQxaFc3?=
 =?utf-8?B?ZTNKWFNCNmF4cFc0QzN6R1dmSDVUZFF0NzhMc1VvZVg3Z3NFandPa3pwbytv?=
 =?utf-8?B?UjBRelVSL0N2UjQ4QThaT0dNcmxoTjhlNTkza3Q2SENtdm5ZNHU5TjFGb1hh?=
 =?utf-8?B?NUNoYytCSmtmS3JPTnFhdllrUjZHRGFuWkgrU2dxUmJvWXF1c2c2Z2pzbXBC?=
 =?utf-8?B?UkQwYklNT3VlR1F3Z0NWRmtTcnVPck9wOHFkc2VPMnhjTHZudmk4WUE3V0NV?=
 =?utf-8?B?bXVCR1FGUWZJZTZuRmFLYmpUUGw1d2dndFcxV01lTUdDdHZIQ0wxa2lSc2JC?=
 =?utf-8?B?N25JK1VLRHZCZE5PUWV0ZHV0R3U2TEJDMllMWXhuMHo3eFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlFVkgrbk45MG5pLzMwT0VObC9qSFExakdOZ0JUOXhWdGFIV0dMV280U1dF?=
 =?utf-8?B?M3BCSjNpbGFWWW1Na0cyRS9yTVlaVEppeU5EQlNMUjA2MlFORjlGT3pqbjVM?=
 =?utf-8?B?ZUdVdWwyZUk3enp6WUd2MDNXYUUxSmdkdFVIWnhJQVJNdU9CaFludjRCRFNw?=
 =?utf-8?B?ckdvbXFvdlNNYUFraFZCNHMxT0kwaG9QaUpvUUo1dzhkcEZpUWtqQVZUa0Er?=
 =?utf-8?B?RXpOSGpzeEMwVHhRT1ZXS2picDlhaG9UdXRaZUxyOUppRERjeU4zSkw1SWFD?=
 =?utf-8?B?Vk54VzZSM0hicEFQTEU1SWNiQ2lpNmVPS0t3c3crQWdYM2gzdVJRc0NyemVo?=
 =?utf-8?B?Ty9YWjBDeDVVc1NJN01MRE5yZnEyY1dzaG5TWlJGUHpuYmhzSkthV3VmMTk3?=
 =?utf-8?B?K0J4bG5DWnJnYVJyUWNSSmN5UXY5Q25TUmwzVXZyeXQ0Nkcyek1qRHh0OGVW?=
 =?utf-8?B?b0xjUjVFeE1RUXFWRW84ZlUvMW91NzRwSFZqTGpGOEtDajlHZFFCWU1RVkY2?=
 =?utf-8?B?WFphZ1FDL2c0UTZCaHd6UU5vVHE4SmR2QmdmWHhGSWc4Q3hLdmsvbG9tMXRR?=
 =?utf-8?B?dTh4UE9zS1MwbW9WNkN2T3NpY08zZlZVdHpkY0JWVGVNdGkzdjBmRk9JNEJK?=
 =?utf-8?B?eHJBbklvK0JzSGwxOFZtTmY2VUVzMTlqbm9vVDZBc2RNaWNXN3N1VU9RTC9h?=
 =?utf-8?B?dFIrY2ZzNGd1cTNzRHNYZ3ZCaUdJM0JhLzNkdlB1OWlnQU9Cd1QrSnd0eDVx?=
 =?utf-8?B?RjZwRWZyZEJ6MGxpSTNKQkFnSnFmNko0UFJmNjQ1dElBTjdvSjN3RzhEMXN1?=
 =?utf-8?B?UzhHMllzckFMYjczQVBHUHJCandlOG9zUlo2WlVQN2NqQktTd01XL1RDUklW?=
 =?utf-8?B?YVhGNGxHRFphM01iNXBLWGhrRjFCZ3cwNEVnUEpNakVmdnFwdzFkZWhuSTBo?=
 =?utf-8?B?N3pvOTg0SC9JOHRKc3BnYTdPblpCeFlOMHZReGluSEpoMzVmQzA3a2taV2hq?=
 =?utf-8?B?ZDFNWWlEZVFvQU12ODJ1Mnd3T2NmRHdyMGZRNUdXOWNILzR4UDdoR1Z4VGhi?=
 =?utf-8?B?WTJNWWpWSU9CV1hUN1ptN1Q2bloxVWVqNmt3U000d0NUWTZoYVpNVnJnZVg0?=
 =?utf-8?B?TW1Jc2kwdnR6VUZmUWdiY2ZQRVhmR2hnL1dlREJkUno5MXBJdTl2UldmakQw?=
 =?utf-8?B?akpZMmIzN2d0eWdvMXRRRUdObnVvTlg1MlNkeHkxVlMzL3VIdTVONDc4ZGg4?=
 =?utf-8?B?OGVvNzBSYkRyRGhwUU8zM3I4Z0RPSjFiRVlTT2RQaWp5WWxnd2ZEQ1pwTVla?=
 =?utf-8?B?R1BPM0dOdjVuSFRnNnpsbXloMm9mVmx4U3krMWtRTng5bFRVZ2ptdWJ6RE1j?=
 =?utf-8?B?alU0Z3BPQWNDWGlVaFpJbFJpMnh5QWN5SUo2U1ZPcjdXUXp3RWpGbFJqYmZs?=
 =?utf-8?B?cG5yMHJTVEt3Z2w0ZTliQUtLbEJEcFVsRStyem8yQmRPU0VMSUNVd1pEK1NR?=
 =?utf-8?B?V3hiVFlGZUFuL3doSlpuUHZ6Rm9QTStPaFh3SExwS1JpZ2NBSUxqMGh0VFZJ?=
 =?utf-8?B?OWE5TWJqNDhlei9tdXFkcERlWm1SZVNOZ3Bta056aUJPN1BqRkF1T2Jud3Uv?=
 =?utf-8?B?cHI2K0x3NXF1YThhMGh0dCs3dkFFMm4xSnJycDB0a29sTnRzYWdSQkdkcDJF?=
 =?utf-8?B?UStnRGRrbTBLS2xuL3BpSVFqMm5qQmVXWGFnUjRhS3FGMUtVQWtmMFBtRDA2?=
 =?utf-8?B?RFhLZ3lzMHc1SWdoaVBGaWZKdnI3bUNoSUgwdEFQa0NWNWUvQjR2cEwrY0NS?=
 =?utf-8?B?TXFIRWNnQkNTYTAyMFlWYVovOE5KdXdFcWlrM2dnOU1xbHIreUh2S25ScGNy?=
 =?utf-8?B?S2ZFWWtTMG1LSFAxanJOKzhWVVZQeXJ3NThuWDh3SnRwU0pHYlBNZCtDOWtS?=
 =?utf-8?B?Tyt1VEhSaERBSFlSQmhMc3N0Rmp1TEVKemIxR012MG1pd01VOFFydVJBT3M5?=
 =?utf-8?B?UFBMMVJIUndjMjVvNW5xWUN2L1RSSk5BS09zM3g2aFp6UVNCRXBHL3kwU05a?=
 =?utf-8?B?MlZUZC80ZHM4bWoxTGFzTjdsc3NmNzRzMmJhamlxQkNIYklmTW1uMUR2NzMw?=
 =?utf-8?Q?pKr6pGN/XdhkZOoGrmiMeC2xO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e2b27-1abe-4dea-315e-08dd13a80cb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:44.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbV+5HO4M0dvOn3khWY9ON5IlPEZLHgVmdZu/aWlPobXdaySPnnReDjJ/yDl7V9StVp4cEhwIc8K0tXTYJExcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

iMX91 is reduced part from iMX93 with part number with some IPs removed
[1]. The i.MX 91 family features an Cortex-A55 running at up to 1.4GHz,
and supports for LPDDR4 memory.

Patch 1-4 are fixes when developing i.MX91 support.
Patch 5-11 are to support i.MX91 and 11x11-EVK.

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=4

Bootlog:

U-Boot SPL 2025.01-rc3-00092-gc065e3b6a3ec-dirty (Dec 03 2024 - 18:24:41 +0800)
PMIC: Nominal Voltage Mode
DDR: 2400MTS
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
Load image from 0x4b800 by ROM_API
NOTICE:  TRDC init done
NOTICE:  BL31: v2.10.0  (release):lf-6.6.36-2.1.0-rc3-dirty
NOTICE:  BL31: Built : 13:31:37, Dec  2 2024

U-Boot 2025.01-rc3-00092-gc065e3b6a3ec-dirty (Dec 03 2024 - 18:24:41 +0800)

Reset Status: POR

CPU:   NXP i.MX91(31) Rev1.0 A55 at 1400 MHz
CPU:   Consumer temperature grade  (0C to 95C)
Model: NXP i.MX91 11X11 EVK board
DRAM:  2 GiB
Core:  216 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... *** Warning - bad CRC, using default environment

In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000

BuildInfo:
  - ELE firmware version 2.0.0-64d8ef47

switch to partitions #0, OK
mmc1 is current device
Net:
Warning: ethernet@428a0000 (eth1) using random MAC address - 62:b9:61:81:d0:f8
eth1: ethernet@428a0000 [PRIME]
Hit any key to stop autoboot:  0

[1] https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/secure-energy-efficient-i-mx-91-family-brings-essential-linux-capabilities-for-thousands-of-edge-applications:i.MX91

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (8):
      gpio: imx_rgpio2p: Move 8ulp_data to data section
      imx9: trdc: correct DEBUG usage
      imx9: gpio: include types.h header
      imx: Add iMX91 support
      clk: imx93: support i.MX91
      pinctrl: imx93: support i.MX91
      arm64: dts: add NXP i.MX91 device tree
      imx: Support i.MX91 11x11 EVK board

Ye Li (3):
      imx93: Update 9x9 part fuses checking
      clk: imx: clk-fracn-gppll: Add new PLL rate
      ddr: imx: Add new rates for i.MX91

 arch/arm/dts/imx91-11x11-evk-u-boot.dtsi           |  195 ++
 arch/arm/dts/imx91-u-boot.dtsi                     |   92 +
 arch/arm/include/asm/arch-imx/cpu.h                |    5 +
 arch/arm/include/asm/arch-imx9/clock.h             |    7 +
 arch/arm/include/asm/arch-imx9/gpio.h              |    2 +
 arch/arm/include/asm/arch-imx9/imx91_pins.h        |  770 ++++++++
 arch/arm/include/asm/mach-imx/iomux-v3.h           |    2 +-
 arch/arm/include/asm/mach-imx/sys_proto.h          |    6 +
 arch/arm/mach-imx/imx9/Kconfig                     |   13 +
 arch/arm/mach-imx/imx9/clock.c                     |   37 +-
 arch/arm/mach-imx/imx9/container.cfg               |    6 +-
 arch/arm/mach-imx/imx9/imximage.cfg                |    6 +-
 arch/arm/mach-imx/imx9/soc.c                       |   47 +-
 arch/arm/mach-imx/imx9/trdc.c                      |    2 +-
 board/freescale/imx91_evk/Kconfig                  |   19 +
 board/freescale/imx91_evk/MAINTAINERS              |    7 +
 board/freescale/imx91_evk/Makefile                 |   16 +
 board/freescale/imx91_evk/imx91_evk.c              |   33 +
 board/freescale/imx91_evk/imx91_evk.env            |   63 +
 board/freescale/imx91_evk/lpddr4_timing_1600mts.c  | 1995 ++++++++++++++++++++
 .../imx91_evk/lpddr4_timing_1600mts_ecc.c          | 1995 ++++++++++++++++++++
 board/freescale/imx91_evk/lpddr4_timing_2400mts.c  | 1995 ++++++++++++++++++++
 .../imx91_evk/lpddr4_timing_2400mts_ecc.c          | 1995 ++++++++++++++++++++
 board/freescale/imx91_evk/spl.c                    |  167 ++
 configs/imx91_11x11_evk_defconfig                  |  145 ++
 configs/imx91_11x11_evk_inline_ecc_defconfig       |  146 ++
 doc/board/nxp/imx91_11x11_evk.rst                  |   70 +
 doc/board/nxp/index.rst                            |    1 +
 drivers/clk/imx/clk-fracn-gppll.c                  |    5 +-
 drivers/clk/imx/clk-imx93.c                        |   52 +-
 drivers/cpu/imx8_cpu.c                             |   10 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    8 +
 drivers/gpio/imx_rgpio2p.c                         |    2 +-
 drivers/pinctrl/nxp/pinctrl-imx93.c                |    1 +
 .../include/dt-bindings/clock/imx93-clock.h        |    6 +-
 .../src/arm64/freescale/imx91-11x11-evk.dts        |  875 +++++++++
 dts/upstream/src/arm64/freescale/imx91-pinfunc.h   |  770 ++++++++
 dts/upstream/src/arm64/freescale/imx91.dtsi        |   70 +
 include/configs/imx91_evk.h                        |   21 +
 39 files changed, 11617 insertions(+), 40 deletions(-)
---
base-commit: 98dd010b311e68b8398428cadf56a6381f7de202
change-id: 20241130-imx91-9de528a1a4f2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

