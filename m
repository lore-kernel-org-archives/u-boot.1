Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010ADCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9A981FEE;
	Tue, 19 Aug 2025 09:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="clWLBGP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D25C82A53; Tue, 19 Aug 2025 09:41:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0560280FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEwfSgmilmtFnQBetOOFvVMLJYseXQ/2R0tl8HdTxx6tuQDqCkSm099lp7b7r8iF5RzwIoyGsV3sGkLEUEE02iG5PZeb8SZJ7ML5LFZEOFcrGiHJT3IBdYt3AQ8a4ZuHCmtAzSeK//VCey+XHJZHKk5JWpxTykjp8Qji6sm33YcZ2tC7cqF/J1Xs3DfR3qoOO9pcjnFFzJCLisdObWT7E5nqP0Oq67E9sMtDgznGRiyyJEqyvvX51hlvZIWtHw/2pilDzQI72Ks3fn1sOWKQ203lpEeRvkPnOSunvW3g/Aay2utArn6bwyy762l3q2hcXAhMbdNn+TYdG+VWACZqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q10TRaQ74Pd1rnD9tr8HzpQEIXCa/bSk7GQlcBvPe1E=;
 b=mQoy25lxQKFpNx2RP70H3gsmp8IUL+nqw/dzYa4y25p4NmwBGJwpo57azYO01rUhR4JKmYpPcQ2NKQqqHyBEYCAipiXvBQ8WL76Z2N4OM01AX89SjyAcRXwNJAA7GcchUaIW7JPPqOGju1C8Yxngc40su4mzHeglzssALT22l7cyLMmeZmJV2YvECR2O9HrPGrnJUgf/816EkQvzR0qEsy/im1vOty4PzSMcwcB8//iHuYM/gjtazZIkWB45Ig7TtciHWnglfNyZAZrf1rr9W/OicJtCjc2Rkdw6xn1YXIXSvhcw73hZxDsKdauxyXyK/oxdxz67SxCzh5cs1ebwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q10TRaQ74Pd1rnD9tr8HzpQEIXCa/bSk7GQlcBvPe1E=;
 b=clWLBGP6X2y2HJexPBkJPGRQHP1SgmsO7IqcNEoq+OP4FmSGB+wyjt7u1TUbPeN5rX7YUL73Iikgj75rpH/weB0QSJDyjmYWjmZHGt3WyYmhaCmMPFuWOV6Evcs+cFK9yBRnDO+loFiWTWzolo1Ce/XzKcmKCoWtIY5Hj2IOYFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 07:41:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 07:41:35 +0000
Message-ID: <2ad54e51-96cb-4f42-85f3-6a9d606951dd@cherry.de>
Date: Tue, 19 Aug 2025 09:41:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: introduce of_clk_detect_critical helper
To: Maxim Kochetkov <fido_max@inbox.ru>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se, marex@denx.de,
 semen.protsenko@linaro.org, miquel.raynal@bootlin.com,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, sjg@chromium.org,
 trini@konsulko.com, seanga2@gmail.com, lukma@denx.de
References: <20250812162946.892728-1-fido_max@inbox.ru>
 <689b6eb9.050a0220.d7261.4aab@mx.google.com>
 <9294dcae-42fa-45c2-962b-691fdaada13a@inbox.ru>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9294dcae-42fa-45c2-962b-691fdaada13a@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11432:EE_
X-MS-Office365-Filtering-Correlation-Id: 11871e57-1337-4046-08e3-08dddef3d2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFlvc3Z6N3UxZW0rUzNLdnV0SUVkVGFTaW9uTUVCeUdLWUI5YnUvTVB2d0sv?=
 =?utf-8?B?aFRRRTROQ0tqUzhLWFNnNGtleE1Tcjc2STh0ZzVCNUFBUlkwTndWd3RIMlIr?=
 =?utf-8?B?ZXNMU3NaS3MySVhiSDVuUDN5dDN2azBzMHd4ZkpBUEJQcFlCaTVzUzBDU3Z2?=
 =?utf-8?B?WjlYc0l5VnllTGQvdVk0aFRNQnVOcks3bW1XL2Uxd3dXUnIwVG9ockNqZjc0?=
 =?utf-8?B?RGRmekRZcXhTRUVDbU5TU3dBUm1zREx5RVVvNStHNkxyVU80UlFWNFhqVmNZ?=
 =?utf-8?B?WTJGSkhaSUhURjYyZy9NZE00K0tjUDRTQXVoN3ZFdmwyV1k4N016TE41TkRN?=
 =?utf-8?B?eG1UZGxzS3ZpR0ZmaE51UTVjNFpjc1BSQThIOFg3Wk5RQlhERklIL2lXNjlr?=
 =?utf-8?B?YUhaZTBnM0hURjh4dVBwY1Y5dmxrK2VhaUZ3QUxPY0xPNjk1ZzJ5UGt1TzFF?=
 =?utf-8?B?NFlrY09xanZRa2lPVHlzcTVnMytGS0RlVkZKSDZ0NlcxOEdvRmJTWC8zZkk5?=
 =?utf-8?B?dmQ4KzZ4MGxnQTJRdm5pS2lJeVZoN2RJeXE3ZGcvNVU4NGFqdERZVk1JMGl4?=
 =?utf-8?B?TGNmTFIzZkVPQU90UzdQVTJYb0p5Wk1BYjhZYjBrRDJ3L3BkLzZDNWwySmk4?=
 =?utf-8?B?bTZ2S1Q1N3M3dHgzaWxkeHVJemZtZHVGVWxIOUNQT2xFSlZSZmNTdWlaVEwy?=
 =?utf-8?B?THlMOGxNUEc2aHlLc1JNWTVTQW5YS3FMbytlKzRpdlJaemRmNHRDZy9Ud2ZN?=
 =?utf-8?B?K01laXlJeVQzUFRZUnB2dEZsMjcwRWNKb1ZyV2JJcWpDVU90RG9CZ1VaZmZ2?=
 =?utf-8?B?Q1R6TGlHUEFmd3B3b1c5QXlBVHhkWnVNWS90ckNUa3hIMFBLVHlKYmRPTlJi?=
 =?utf-8?B?MC9ZdTNtMFc4UmVFTGRqQlhTNmFhK1VDYk1ENXlXK3NCeVpHS3UrSHJMUW05?=
 =?utf-8?B?TjdpV2xOOXFHZFc3TnpoZEZ5ZnhkTDIxMzkydHIwaDYzSnRWTHh2YjZjRGRC?=
 =?utf-8?B?QXkyM0R6UnFIQU5Nc0t6U2hJdmZBSHgrWnVxdk41K2NEaVgxQnQraFJCMEJL?=
 =?utf-8?B?MWFobVhUWklGdEhqNkUyVk9Bbm5CVU9oaWZlVHM3VEVoSENPY3ByNlRYOEx6?=
 =?utf-8?B?NERpbStTV3daYnZ2Wi9sY0xCSTJXNWhNQXAvckE4cWdJSjZsY2dGbERBUkJ6?=
 =?utf-8?B?K1hOanlTekZvVFpJYlRTYnBMdGNRSnkyTTlLSCtCTi9EMDQ5YkExaW5lM0Js?=
 =?utf-8?B?ZEx5dWw0QmZrNVh6djJuOEdSdFB0aERNWEVoQ3JlbVYyYmJhUnBjS1hWQkdj?=
 =?utf-8?B?TSt4RCtoMndvWElxbms4T1d3UWpjS3VmbG44TDhkWFBJWDExQnM2ZUdzOE5L?=
 =?utf-8?B?c3VLRTZYN3k3YkRSMDBJR2w1ZERFVjIzTy8wYTJTeno4ejZhMGJZU1RxaVBI?=
 =?utf-8?B?bjFMRmpoSW9DOFFqbE9uUlBKUWI4RDA5NU9kbzFrMjdhVEpPL29qaXVJWGNC?=
 =?utf-8?B?Tk9VTXg1VkprRFRIbjVzQ1BOK3llQVVMN1hxamRmMjZ6ajJ0aHpvcTdLRlli?=
 =?utf-8?B?YWQyb0QySExEYUk1WWszaDFHcXpSTzAyeDkxS1Q1NEp2bE9keXMvU0xnNks1?=
 =?utf-8?B?dVJUSElRZm1QRUV4Q3pSeWEwdTB4MUQ0MExOUEFmVmc5QmthSktiQkxOUmpr?=
 =?utf-8?B?ZVp2TklWSU1FUmppR2tmTE5QT0Y4UFhRR2twN01QQzZkMmdnSnZCQm84VDNH?=
 =?utf-8?B?SU02UnhvRjNUaEQxVk93OC9NRW01MDd3dWRPRGg3YThZYUtTN29GMUY0ZkI2?=
 =?utf-8?B?aHJPaFN5RzBiaEUrUHRnN3o5OXc5RFlEWmE4NW9HdUF1L1pPZUloT1d1akZx?=
 =?utf-8?B?bnRZcEFKeHcyRHB1ck9nQ2Z4MjVyMGhOSkt5eWc0WHVzelpSM3hMVDloNUg3?=
 =?utf-8?Q?ckfc+3upLzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlSck1sUS9TMnZ0OHZBUStUTjhLY1lXRXFvTXJJN0QrV3d3VUh4VW9wcWFR?=
 =?utf-8?B?Qk85RkYzb0tnMTRSclVVTkdDcG9wdFAxd2o2VE5rTEIxNVl3OHl0S3MrOUFP?=
 =?utf-8?B?V2lTVnhUZkp6dzdVT2liTTBVV0F1N3QraCtQRzJVTWJFTFovVW5tYUs3SHk3?=
 =?utf-8?B?MkRwUzJBaVhlQ1NVWnVaYW56QTloaWZ2Y3UzZmNpemtKTUJ2d3VTOGhlcGsw?=
 =?utf-8?B?ODFsTytMN2dPZ3ZqQUN1OWtDQlVUcjYxRDhydGhadHJ6cG9LVFl1YXIzekRp?=
 =?utf-8?B?OWVOdkhFVldPN3k2OVkwcTR5YTVWQVU1cmMvRnFIeGdVWkdiUTU0MGhENlhW?=
 =?utf-8?B?Zi8xZjJHSTdWcUJaTjhCam1XMGN2S1BNWnNWc3A0UDBLVXVXSHNHZWk2OVVl?=
 =?utf-8?B?WWZmWWppWlRiZVczdzkxN2dnUlRnZmIyM0lYWnlsTnJxNU40Q0ZyaHNBMVlU?=
 =?utf-8?B?amowdVJPR0RJeW5yZU8yS1RvaWNILzliSHFyYXEyTCtaejNESGtYQktaRkR2?=
 =?utf-8?B?VFF6dmhvN3lKd2F3cW5saDZjVzdvYkQrZ25nVXR5Tm5adUNHSkF4aHkwMENY?=
 =?utf-8?B?Y1FObXpZaFE2N1d4QThvcHZJRS96SGRxWU82NGpKcHJkaXVFMUhaaFUzRG9z?=
 =?utf-8?B?ZXVVN2g4SlRJUE9ZdUR1SVNyY3BxVTZTWjJFNFVORm5Odnk0emNPUlM4eXFm?=
 =?utf-8?B?Q2I3K3JWWVdDN2xEcHNISjI1LzZMdnZwNmx4cVJnZ2lGQ05ucmdGd3laU2Ns?=
 =?utf-8?B?Q3YvOFVhQjlDeVM1djhiYmFXWHE5SHdEd3JtdXo2czBobnRiai9tU1JuaDJZ?=
 =?utf-8?B?RitJMjloSVNaTmV0bnRxc3FlRzROUmZJSTZ6Y1BqeEhsbWw1QUdId3l4SFFu?=
 =?utf-8?B?MStiZUxmcXAva01aZU1mWmxpNGcvUVJra1BJN2loU3hBY2ZodE94WDhYeTRh?=
 =?utf-8?B?MVdBUE90NkwyamNJaHpLWmRGdlU3ZDRSMFc1NWxUR01MaXNIREFITHhJTXJ5?=
 =?utf-8?B?VEMzWHlPU2EvNC96NFFLQ0ozaWFDRWdtdXNpQTNTcGg1VmQ0c1IyU1VDdnh3?=
 =?utf-8?B?MWlNQ1JObEZqaTVyYnE5QzRIc3A0Ym9HNktNYkxHdStvZ2Z6d2NNVkk5bndr?=
 =?utf-8?B?eUszYWZKL1k4NTFLWW9NL1B1N1JsVjhmeVBkZ1dmcmlaRHZ5TWJ0bVNuQks2?=
 =?utf-8?B?RkVBL1R6UVlwYS9qZTdxNU9QUndqb2xvSkNoOFNHTjdsQjRLT2tYbDZqa0lR?=
 =?utf-8?B?Skxua3dKTlNTQ1J2eFhIWUV6WUJYZUZXQ1NFaUcxaGo2VXpibVR3djFMOUo5?=
 =?utf-8?B?NjhtdWxWaENKMEUxeHZWSTdKRXhrVWZrWmxIcWZnSGlUSjFtVUNlQU9nRkdL?=
 =?utf-8?B?MDFNdisrSm1VenFFWHMzekZuY0g3cDJ5eCtoWVJlc2JOL1cvSmNtWGhFbFNt?=
 =?utf-8?B?Ky9IM2VDcG52SHNUbElWcG0rUFhuVTd6N3MwekRwb2gwaTJrLzhkdGN0UXJu?=
 =?utf-8?B?citRVTZNbTBrald3MGxrZm1pT0VJdXF1Lzc2YkttbStLZXZzSWJ5cldlSXJR?=
 =?utf-8?B?VnplOEF6WHFzVGNaTnJXdURnUFV4OWhTVVQ3NHUwdk1pOUdjRVZYeHBlRVc5?=
 =?utf-8?B?ZHFnZTlxNElWVDdYRkhmckJIOHY5Y0NwVVVTWldXczViQmtnY2FKRkpabkhn?=
 =?utf-8?B?VFgrU2xQVnhoQUFBMWlFYzhlblIrQm5LNDE2M2NBY1J2YVIxaklsMUdtM1pi?=
 =?utf-8?B?cHVlQzN2OGNtd1ljckIxaS9zRTVSMUdGN0swS01ST1c0Q2VOMXlORnZFUWtY?=
 =?utf-8?B?czdmV3R6SkFQUWJXMlhpNkwxemFFbExjckp0bXB0bDAzeVhoMk13Mm0xMnE5?=
 =?utf-8?B?bm00M0hIbDVES09CRmVWYS9pNnVXYlZkSTdUV3hHL2xzU2lXakZpSUdXUWk1?=
 =?utf-8?B?RUx6M3Q3WGloT0orZXdSQThaSnFEcFQrWk9zaExITVNPcGNaT0tkZ1kwVWxs?=
 =?utf-8?B?ZXlpQ1p1eHVHb1RyWXV6Q2w2WWpFaFpkZkJQT3kwMG5LQnBYTDVoemhMcTBi?=
 =?utf-8?B?dEQvVHd6cGxCZFc0elRLRUNhbzZPcnF4UnM2ekRka0Q5UjhoWHNXOVFsVkJF?=
 =?utf-8?B?UFZtTUQyT1o5eXlzSUpQN1dFdlNnT1hyOUZZMjV1aVhxdUNFQmVxVFhjNDcr?=
 =?utf-8?B?K3NzZTJSSmsxWE03YkE4TUNsZitDZVZ4dEo0bDkreStpbzhoQkVzZFNPV0hS?=
 =?utf-8?B?NTVpQXB4NGJXeXZqUG5xU0M1MytBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 11871e57-1337-4046-08e3-08dddef3d2b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:41:35.1043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUOm3RBoVTR0qapu3qYAFT/557VY1/Ho7rAGlE0n27Ttu526/QvXYDerj2ye/Evm2EMH3I+GPorbotg7Pb+Zy4XmkQgarQsRtR8O3AXvPxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432
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

Hi Maxim,

On 8/12/25 8:56 PM, Maxim Kochetkov wrote:
> [You don't often get email from fido_max@inbox.ru. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> 12.08.2025 19:41, Christian Marangi wrote:
>> On Tue, Aug 12, 2025 at 07:29:46PM +0300, Maxim Kochetkov wrote:
>>> This helper find clock-critiacl property in dts and assign
>>
>> clock-critiacl -> typo
> 
> 
> Thanks. Will fix it in v2
> 
>>
>>> CLK_IS_CRITICAL flag to the clock.
>>>
>>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>>> ---
>>>   drivers/clk/clk-uclass.c | 17 +++++++++++++++++
>>>   drivers/core/of_access.c | 22 ++++++++++++++++++++++
>>>   include/clk.h            | 28 ++++++++++++++++++++++++++++
>>>   include/dm/of_access.h   | 17 +++++++++++++++++
>>>   4 files changed, 84 insertions(+)
>>>
>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>> index 7262e89b512..4f35b90382f 100644
>>> --- a/drivers/clk/clk-uclass.c
>>> +++ b/drivers/clk/clk-uclass.c
>>> @@ -835,6 +835,23 @@ struct clk *devm_clk_get(struct udevice *dev, 
>>> const char *id)
>>>      return clk;
>>>   }
>>>
>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>> +                       unsigned long *flags)
>>> +{
>>> +    struct property *prop;
>>> +    const __be32 *cur;
>>> +    uint32_t idx;
>>> +
>>> +    if (!np || !flags)
>>> +            return -EINVAL;
>>> +
>>> +    of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
>>> +            if (index == idx)
>>> +                    *flags |= CLK_IS_CRITICAL;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int clk_uclass_post_probe(struct udevice *dev)
>>>   {
>>>      /*
>>> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
>>> index b11e36202c1..59dda3ae152 100644
>>> --- a/drivers/core/of_access.c
>>> +++ b/drivers/core/of_access.c
>>> @@ -666,6 +666,28 @@ int of_property_read_string_helper(const struct 
>>> device_node *np,
>>>      return i <= 0 ? -ENODATA : i;
>>>   }
>>>
>>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 
>>> *cur,
>>> +                           u32 *pu)
>>> +{
>>> +    const void *curv = cur;
>>> +
>>> +    if (!prop)
>>> +            return NULL;
>>> +
>>> +    if (!cur) {
>>> +            curv = prop->value;
>>> +            goto out_val;
>>> +    }
>>> +
>>> +    curv += sizeof(*cur);
>>> +    if (curv >= prop->value + prop->length)
>>> +            return NULL;
>>> +
>>> +out_val:
>>> +    *pu = be32_to_cpup(curv);
>>> +    return curv;
>>> +}
>>> +
>>>   static int __of_root_parse_phandle_with_args(struct device_node *root,
>>>                                           const struct device_node *np,
>>>                                           const char *list_name,
>>> diff --git a/include/clk.h b/include/clk.h
>>> index f94135ff778..ea708f54fd5 100644
>>> --- a/include/clk.h
>>> +++ b/include/clk.h
>>> @@ -589,6 +589,27 @@ bool clk_dev_binded(struct clk *clk);
>>>    */
>>>   ulong clk_get_id(const struct clk *clk);
>>>
>>> +/**
>>> + * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
>>> + * @np: Device node pointer associated with clock provider
>>> + * @index: clock index
>>> + * @flags: pointer to top-level framework flags
>>> + *
>>> + * Detects if the clock-critical property exists and, if so, sets the
>>> + * corresponding CLK_IS_CRITICAL flag.
>>> + *
>>> + * Do not use this function. It exists only for legacy Device Tree
>>> + * bindings, such as the one-clock-per-node style that are outdated.
>>> + * Those bindings typically put all clock data into .dts and the Linux
>>> + * driver has no clock data, thus making it impossible to set this flag
>>> + * correctly from the driver. Only those drivers may call
>>> + * of_clk_detect_critical from their setup functions.
>>> + *
>>> + * Return: error code or zero on success
>>> + */
>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>> +                       unsigned long *flags);
>>> +
>>>   #else /* CONFIG_IS_ENABLED(CLK) */
>>>
>>>   static inline int clk_request(struct udevice *dev, struct clk *clk)
>>> @@ -665,6 +686,13 @@ static inline ulong clk_get_id(const struct clk 
>>> *clk)
>>>   {
>>>      return 0;
>>>   }
>>> +
>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>> +                       unsigned long *flags)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>>   #endif /* CONFIG_IS_ENABLED(CLK) */
>>>
>>>   /**
>>> diff --git a/include/dm/of_access.h b/include/dm/of_access.h
>>> index 44143a5a391..dba725498f5 100644
>>> --- a/include/dm/of_access.h
>>> +++ b/include/dm/of_access.h
>>> @@ -405,6 +405,17 @@ int of_property_read_string_helper(const struct 
>>> device_node *np,
>>>                                 const char *propname, const char 
>>> **out_strs,
>>>                                 size_t sz, int index);
>>>
>>> +/*
>>> + * struct property *prop;
>>> + * const __be32 *p;
>>> + * u32 u;
>>> + *
>>> + * of_property_for_each_u32(np, "propname", prop, p, u)
>>> + *         printk("U32 value: %x\n", u);
>>> + */
>>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 
>>> *cur,
>>> +                           u32 *pu);
>>> +
>>>   /**
>>>    * of_property_read_string_index() - Find and read a string from a 
>>> multiple
>>>    * strings property.
>>> @@ -701,4 +712,10 @@ int of_remove_property(struct device_node *np, 
>>> struct property *prop);
>>>    */
>>>   int of_remove_node(struct device_node *to_remove);
>>>
>>> +#define of_property_for_each_u32(np, propname, prop, p, u)  \
>>> +    for (prop = of_find_property(np, propname, NULL),       \
>>> +            p = of_prop_next_u32(prop, NULL, &u);           \
>>> +            p;                                              \
>>> +            p = of_prop_next_u32(prop, p, &u))
>>> +
>>>   #endif
>>> -- 
>>
>> I would split these of additional function to a separate commit also
>> where they come from? They are ported from Linux Kernel?
> 
> Ok, I will split it.
> Yes these function are ported from Linux Kernel.
> 
>>
>> Also would be ideal to have some scenario where it's needed to declare a
>> clock in DT that is critical. Isn't that handled directly by the clock
>> driver internally?
>>
> 
> Yes. Now we can use this property from DT by custom drivers to mark
> critical clocks.
> 

How this is typically handled today is by hardcoding the clock that is 
critical in the SoC clock controller driver directly, c.f. 
https://lore.kernel.org/linux-rockchip/20241214224820.200665-1-heiko@sntech.de/

This is of course then forced-enabled for all boards based on this SoC. 
If that is something that isn't desirable, then we need to properly need 
to represent this clock in the Device Tree. You haven't really explained 
the real life example that would benefit from this. Is there one? What 
is it?

Finally, we do not accept Device Tree properties anymore if they aren't 
part of the Device Tree binding coming from the kernel, the Device Tree 
specification or the dt-schema. So it needs to go through those channels 
first before we can make use of this property here in U-Boot. Our 
ultimate goal is to have the exact same Device Tree for U-Boot than in 
the Linux kernel (and I assume even further than that, anything that 
requires DT use the same one across all SW stack).

Cheers,
Quentin
