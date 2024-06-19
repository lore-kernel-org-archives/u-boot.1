Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF8C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 11:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931C98840F;
	Wed, 19 Jun 2024 13:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ho2XAm+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D7388415; Wed, 19 Jun 2024 13:30:28 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB3C8840C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuqPM6KnyMlZyGAfSCNFXFB1miMmJQu/PjuEJA7xu6B+ltJ4plzF16bN6l0U6XHKgMtbLglGuh0W4A2nPRp+J3YToj3KOYXbxA6rAFC5URkHBDQPAdYCD29793/5Y65xibe2sZiVfpHx3VgmzXnMzkk5J3vu9YAkSkRuCrxuKmTaYkgxmrwxDF8DAUo1gWqtAtmviCU5eDvwgSYBke5/guwL2yjRnjTAiUaCFjQKZmSaUfN/JoAaWGQoMac3vyQm1dBaQyIJ/pwp6SGd+XSdqFrhss/Tp6+ne7+rZu7pTW98wfxdo76Z9corL9iqhx06V66DLX7m6zti1QHQCAqMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzwLjaQ6CSO5rlQqnXazizhmDbOYgItbofpF1ofJ7cU=;
 b=m2t/rHZ2Iojszm/pASGTBoRs+quPYskVQMRq6P11bYpx3I5CKT3fwq9h9GGr+bIIDZEAsfKlBf7/+D29wNi2VXdJQC071oMNVy4AfWEGGqk8Zpch8Hqjj5ni/5QpN2tnBymJm9sxDCPM1SMNlVle0hjW2SXyMKHWPT+wXLZ3QJ68MYqftnloLZ11rdJrtRY2w17OkPfwTQ/6atmi8BKRPLPjBQ13kCAIseztt7Er9ffgy2F4qBiQyWfh1Su8JPsEPniZ3mD7DWbFs+dZW+heIB0GmYN5llec7E9YM4SKH78eIHpBhtlebNF4pZYP0whdA21DPZd2jvPN/e91tzKqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzwLjaQ6CSO5rlQqnXazizhmDbOYgItbofpF1ofJ7cU=;
 b=ho2XAm+ZPYT9oLfNehrc7ltjdffocBEj0OB2FYG47xJRx1KwhKBMyBGzF2FfHY/gJ/vv33U2wlZnZs1YRcps46BJHWAk4hucvNJWg55WfGAC/5RjQnOZGxKGEHcRESltcQk8rPPuGry8j266jHP3k/9NZhVrALZ17RGa7uqkILc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10930.eurprd04.prod.outlook.com (2603:10a6:800:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 11:30:22 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:30:22 +0000
Message-ID: <60db4e9f-0267-4892-88d7-26ec3e891f5a@cherry.de>
Date: Wed, 19 Jun 2024 13:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
 <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
 <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
 <f2183ce9-d7c3-4952-a585-be5138cad9a5@cherry.de>
 <173e84c9-9c0e-4ab8-add2-1f493ca14fe3@kwiboo.se>
 <90903af5-098a-486b-b9de-48b232d722ec@cherry.de>
Content-Language: en-US
In-Reply-To: <90903af5-098a-486b-b9de-48b232d722ec@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10930:EE_
X-MS-Office365-Filtering-Correlation-Id: 522a2fa1-a490-4786-07a1-08dc905334fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3MySWI2Z1RzTVlybzNjS0JSTVRiVExwQVZ6dFUxNTd5S0wveGFJc0dGWFZS?=
 =?utf-8?B?UE9DYzBXNm1uUXR5aFFpT1dZaHExdHpDWXpMWHhORXdkc3ZoUkhRNHdKRVNn?=
 =?utf-8?B?MFBlL1kxaGswQ2QwYzZLL09CMFEwM1JYcXhsdkd2dVljOHNPbnlseUhUd3Uz?=
 =?utf-8?B?bWF3SFRaNWFLZCtMUlJLTW1CZ3FuRGVrenBHYStMTWNNY0hZbXJlSW5lUlRp?=
 =?utf-8?B?cHdnY0NVeDZqTlBObWttWkdvZURjdFFyOUs5Mk0vMjlXMU5icjhYZWY0ZDFQ?=
 =?utf-8?B?TmR4eHpIRDhvRkc4RzhCbTExYnFJWmhxeHhWdUJ3ZktQRVlRcHF0ZUlpT3Na?=
 =?utf-8?B?Q2k2NlFvS0JIbWthcXFJWjZyL29yeWU5RmJrYWRyb3dqbjFvZmQxelJVanV4?=
 =?utf-8?B?UndKWjQ5cDIwTEtCQlAzVVZiNEdzWVNiQXBXSXdNOGNOQUVmbFluWkw5U0Zh?=
 =?utf-8?B?akJ1U0xWNi8wSHd1K3kwQ2RpYzc5SXI1L2ZhQ08rOWY0WGNkNHNEZE53R3Va?=
 =?utf-8?B?NG51bVZ5RlYrWGkwQmxqMU9GTGo3ZDRKbXdZL2JnYnYvK0NKQzVTck9FaG80?=
 =?utf-8?B?N1VLL0hJdGcrYmZHQzJJUTh2ZXhNbkN3SVRMZGlGbG01L0YwZEwzbGEyREpZ?=
 =?utf-8?B?TWNoVDNjT1pTdVBKZmN3UWtCMS95OGsvRlY4bzdPd3A1QVRoVjA2L1dBRVMw?=
 =?utf-8?B?VUNOSC91QU5yQ0c5L1ZYYjFsS2Y0QnpFVHAveExjczBFenZ5d29WcEYrOTFt?=
 =?utf-8?B?YXRER2FEOEgyUkg2c3ZlT2VyZUlvU0JQSnZObWRyYmIxd0JxYVNFM1FzRkxQ?=
 =?utf-8?B?RVVjaGNTaTl3WWloYW1jVXp1VTdnK0J5K3BYT1RscW5WMFJydk1XcXY1L2d0?=
 =?utf-8?B?UXlYZWc3N2pRTFJzNUxyRTc3eGRPaG10M1ZSei85b0tGcWdPZk9NbXR5RmZS?=
 =?utf-8?B?dmNrc29jQTc2dFZ3UnN1QkNraGFwQTFTems5SkJWLzM1ZFcrdWNHOVdaK2VO?=
 =?utf-8?B?d2tkUCtPVXMrTHhFbjdsZWlObnl1cW90cG01aW1HNHN0UkpNUDRXZmkrZ0ZJ?=
 =?utf-8?B?elgzWTVpS1VreHJpbWtjcXdQb2lHY1pSNW5GS1dtZlFLQmZpMnI3dElFSnpz?=
 =?utf-8?B?TjBEa1dzOGtVVk84Q1o0LzZJaXdqWHlrbUdXbzlFbGZyMVY3UWlMU3RUODBi?=
 =?utf-8?B?ZEdaQ2ZEdjFNNVJ0OFZsRXQ0aVlRNUdnL3d4dWJ6SWROOWVDRTZhSXpFM1BQ?=
 =?utf-8?B?YmJGUWlIRUt4czYwZENNVnBaVlBnSlFqTXlkVDRiVXNsbEFRUytDdDJUK0xM?=
 =?utf-8?B?cGxXeFJsUFFuR0E4ZW5VRnFHaUhYYXZxOTB4SDJTTmFTeFplMlpDbHNINlcz?=
 =?utf-8?B?czNvaWdIOHhZbGNyR1QxZk1yWXFIY3piTElDdDd6SlVGN0huSVhGNU45KzBW?=
 =?utf-8?B?TGVxL1pVREZsMWtydENYdVduYW5sV0N2MEdDeHd6TVJpWmpuZEY1dStMU0dD?=
 =?utf-8?B?aUhPb2s3cDFIL0Q0dGpnai9DMWFlSWJLL3V1ci9Mdkhoa01ZQTdnSEE2aHkz?=
 =?utf-8?B?b1hWVHNqeXR6a2lpWXh0MW5NakZCbTBLYWdDRlljb3FxU2NSWGNSNVFWeGUw?=
 =?utf-8?B?WmFUNlU0ckFuT2ptUGJFV3IyUnRZdE9qVkRJZTRrWExteUFtR0JqS2tzdnhC?=
 =?utf-8?B?eWFTVTBTbXJNNFo5SXZKL01RSmR3WEFNYURmY1ZrS0d0aDg4dERSL1ZpYUZm?=
 =?utf-8?Q?vd9qp1hJpiGzZxXvCVdThqQcwARAQ9zVee+LCMF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBrd01uWUVMTXY2OXBuQ0hjTTNBQytxWDkrK0lyaVdyUld4cHJ6c25CL3ZN?=
 =?utf-8?B?U2NBVDVJeWdmK0Q1ZUNqQlVrU2NkejlwZWNqblhXajErWmhmWXB2S1dRUzZI?=
 =?utf-8?B?Mk95aFpkMndac3dhSTJPMzk4WlBLN2V0dnJDcWh1QUdGRTBIL3doa1FYNzFx?=
 =?utf-8?B?NjVkeDFsbVptTVcvcWpsV1VHREVNLzBBRmRGdFVXeE0zUUh4TkNVMmQ3NVlw?=
 =?utf-8?B?b3puT1BYR0kxVnArZHcwNnZabTNoeGtMME1Zb1JqRExLZnZ4SFY4K3o5bDNx?=
 =?utf-8?B?UEh2N1hRaWIrKzZ4ZkEwUHdGTXAxVnhSUVIxY3JyWEd1Qzc5NERrNU04cFlM?=
 =?utf-8?B?bEZzZkRYb0t6Ulc0TmRlU014Nks3NDZLYlovbGp4S1ZWKzVxQmVaTkRCZVB4?=
 =?utf-8?B?MFhySHEyRVhhdDZUaHd6NnZndzhIQWNwME1XeWJweW9kZ0dxL2hiUlg5N3ZF?=
 =?utf-8?B?NDhOa2wxRFYrRU9nSnF6VTZXSDUydStvd0NvT1ViWGVyT3FGVklVY2E2MHJm?=
 =?utf-8?B?UGJha290TUg3bk9uQ211Vzd6RS9PR0xrWFZWSGZXZUlSODkraHpsVjZxc1VZ?=
 =?utf-8?B?bUZiVFp4VjBmbTJVV3dXem9EVVVhTWNDcVg4bkxWbHpjbWRyRUo3c1VOZzRT?=
 =?utf-8?B?VjFaQXFXZEE1QzcwTVdDRGVsWnBhbTUraFpLM1JMK0JwZUpjOU54SWh2d3o5?=
 =?utf-8?B?RmQxclJSOUN3T25pVTdPQ2hrQVd6WFdpVXlaKzFob3psWnVPNWEvUHo1ekZZ?=
 =?utf-8?B?ZnVoQWlQWWRjVlJkZmowZHhYaTdvbHlBWlNEN3A2ZGdZNm5NUldESGNGeXZa?=
 =?utf-8?B?Rk9sK2lBd1VWMFFnQm9FenB3SW81UmtaUldHNXUwTHowdDFmV1BCUjdLOFpO?=
 =?utf-8?B?UWxVOUhzM1hVZlJ4b3FjSUVlZGRvMHRVd0NiakNacWJNV21KRDI4emZ2RUph?=
 =?utf-8?B?NFNaK1FlYngzdG1BTE5saFN2UE9SVWZJak5ucTUrai9CeXRJSVNVaThTTlE0?=
 =?utf-8?B?NFRNZnVNNmNpSEdxbmFYVUE2Sk5aM09yNkdKNTlhcGw3dS9hL0RzWnBkNTQ3?=
 =?utf-8?B?RXJFRGRtTFBHdllNNGZZdFBMN3lTbUZDQUdxNEhaaXY3cU5laitJNkU0cTJT?=
 =?utf-8?B?YTRXYlZWb0xlQ21YemVCUDBlQWFJTmpEMkVxUTR0Y3lXMncvdDV4VkZRQSts?=
 =?utf-8?B?ckZHRlNGVmVnenhOUUdTR0hmYVgvSVBybXNadHhoVjNlOUYxaytOVkVrOGZU?=
 =?utf-8?B?cy9ScVRTSlNLYmplN0p1ZWx6NGhoYVJiaHlodEFBeUk0OFZFVkxpS2hETzFN?=
 =?utf-8?B?WXZkRkpSKzVaeE1xaGdwTDlPdUt2QmhkRTlPVitidTNwYnF1VjViQWljSHJU?=
 =?utf-8?B?R0lSRG5NVWI4Mmk0bWdTcXNMeXB3dE1MQThpblVlRGMvOWI1QlMrRjFQTTBo?=
 =?utf-8?B?aE12dCtFajF6eDZRb1loNTRkQTl0NVdIOU5CdTVRMG9zcVdCb2xwbldjQm9O?=
 =?utf-8?B?cTJWdnBPUmdGcXN4TUtQeUhIQ3lUSHRjMlRaYTEza2l5dWt2U0pMNkx2blg2?=
 =?utf-8?B?eUdZY0Y3RWtVN2p3UlYza0E2SUtxWERqNDVRQ3BYS3doZzhLVFlYTndTMllB?=
 =?utf-8?B?NVkzbkN5aittbFBpQXgrSlpwaEJ0aU9VM0ZBNFFCb0g2RHhLdEVPZUNncW1D?=
 =?utf-8?B?UWNEejVZb2VsSUJWRm5rVFJFM0dSZldOZDdDWTNGUCtzK1N6bC9EN2pGSlFk?=
 =?utf-8?B?QkNkajdRK1Vzcm11b0dqemFDYUJpclgvZjZERHVyQlJrTXpsT3RQaHB0cHlU?=
 =?utf-8?B?QWp5K3gwL1U2U1pQc0VDditCQktURG8yM2VwcW9MaGxuOHpXNkMxVXZhNnpW?=
 =?utf-8?B?QU13bzdOWWZNcGZBaWVobk5XSHdTQXREVDlWaGhXL0IrYVJ4ZVc3NWQ4WDd3?=
 =?utf-8?B?ZndJeUpTSkI5ZDEvSlF2c0xQaE9oNUZNUVIyeHhGcUliaVFQLzJTcDI3djdW?=
 =?utf-8?B?ZSsvVG9FYmN1RVgwNlBFaVJ1NTZLT2V1NlhRMkdBaEV4dkFqWGtlVVVJNGFl?=
 =?utf-8?B?VjV2VkhkSkhTOEJMSDMrdGxLc1V1a3JwTjQ3MUNkdk1lc2lTNnVMVTR0Yk9W?=
 =?utf-8?B?OS9mQnhMYUlkSVNTZDVGU25wRHdQbFE2L00yYjgwOGZBc0NkblhhNEQ1T2tV?=
 =?utf-8?Q?W35tIzknASjuaAV7QwnfigM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 522a2fa1-a490-4786-07a1-08dc905334fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:30:22.6261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77xVI+bZ1msLEJHot7G6ZKxFqP0NRCnTMc8QbeRl3PUHFx56yjzVFDFXsCLMpVvbUfmBFdUAlKCXsNpOcemmxPAXh0zTD2TO41CVhpJrvuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10930
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

Hi,

On 6/19/24 12:33 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 6/17/24 8:53 PM, Jonas Karlman wrote:
> [...]
>>> I'm wondering if we shouldn't do the same for U-Boot proper DTB as well?
>>
>> I think that would be good, and should also remove the need for the
>> recursive pinctrl lookup for bootph props during pre-reloc.
>>
>>>
>>> i.e.
>>>
>>> cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - -o $@
>>>
>>> to
>>>
>>> cmd_fdt_rm_props = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u  $< |
>>> $(objtree)/tools/fdtgrep -r -O dtb - -o $@
>>>
>>> I assume we need to add a bunch more options though.
>>>
>>> But that would make sense to me, the fact that there's a pre-reloc stage
>>> in U-Boot proper is already a bit odd (to me), but if we have something
>>> that behaves differently than the pre-reloc stage in earlier stages...
>>> I'm not sure this is a good idea?
>>
>> Fully agree that part of the pre-reloc stage make little sense at least
>> on Rockchip platform where full memory is available before pre-reloc.
>>
> 
> Will try to come up with something.
> 

Ok so nothing straightforward. The issue is that the SPL/TPL/VPL DTB is 
built this way:

1) take full DTB
2) include all nodes which have the bootph-all, bootph-pre-sram/pre-ram, 
bootph-verify
3) include all parent nodes recursively of nodes from 2)
4) include /, /config, /chosen, /aliases

This generates a DTB. The parent nodes of nodes matching 2) and nodes 
matching 2) and / and /config and /chosen and /aliases are there, 
nothing else. No change made to DTB.

Step 2.

5) take DTB from 4)
6) remove bootph-all, bootph-pre-sram/pre-ram, bootph-verify properties 
and the ones in CONFIG_OF_SPL_REMOVE_PROPS

So.... '-u' option documentation is a lie :) It's not adding the 
property to the parents, it's including the parents of nodes matching 2).

I'm also a bit perplexed with the documentation stating it's the '-p' 
properties that are propagated as this is used for SPL/TPL/VPL and we 
don't have a '-p' option for it, only '-b' (the sounds being close in 
English, maybe just an unfortunate typo).

For U-Boot proper DTB, nothing is done except removing properties listed 
in CONFIG_OF_REMOVE_PROPS. And we would need to **add** boopth-some-ram 
properties to parent nodes instead.

 From the look of it, this isn't a straightforward change to fdtgrep as 
fdtgrep only cares if a node needs to be included not really which 
property actually matched in order for it to be included.

Cheers,
Quentin
