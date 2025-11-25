Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB47D0E6E3
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6818407D;
	Tue, 25 Nov 2025 14:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="MUC4qVm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD82684047; Tue, 25 Nov 2025 14:13:56 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B2CC84011
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Petr.Benes@ysoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdjfrezYSKaKenbZ6bR3ZMbT0Bhcwu0N0CQdu7rwJ/hZsFaJLmrCiGkRnZp3/n4vmWj7plJaXgz5KI8Ono2op0aW4QK+J5KE2RYrjV1YieTxC+M3/YjwWrZkbO+02+1O57Ykhydcs9f+NxzCiAwigzZwdTKqRqjna8ELD9z0oXz6jOVWrNiUZHG9iWhjh+e4ZNFSlB2608p12RTAJ20gE131txyVeQsW1P2QzxJa0gYQlli2CPudsKS/fzmW2n8XTZTHV3goO/A8rJkXip2lXnSyDJVVLx7VGgrq2Q1eqEvX/RgTbhX7Wl1stMCTWIwb2v2ToyUFqsmi/o539oPzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30JpCTbcAQeKr8L1JRAUsh77UI4IYdPkS5bAOuD+iJA=;
 b=izhABd2D+FAtOrEcM73cItDQl6vHOsAsS1q4CSZP24MQnxmNv2COoW068stTNy0bPW9+p43VrJcqRGYi+TjYXvAuwbUBhzmf7p9Sv0AvAJAv7B/EyvNbMgBs39ZrY1PiopX6VZMNEKJN+RlJ710MWN3z5HlPFN5hVEJpomC21pdndlQg2RJYIdssoXAdmVNLcb1oj/trf8nZmnISMiRmAC/vFF+zcmq2s04TL4SxI9EVMeGf1gzbJRYqyAjFwHPtLnmjtdOTvuWnKZU+7ZiJKumOIqjmVfElvqR5gqLyg736hAKAgglLCNmlmVOzewxPCSr71O2tAtrXVWZ6SlodLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ysoft.com; dmarc=pass action=none header.from=ysoft.com;
 dkim=pass header.d=ysoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30JpCTbcAQeKr8L1JRAUsh77UI4IYdPkS5bAOuD+iJA=;
 b=MUC4qVm/Df+/vD2qvK1qmfknRnK34AdeBzhclodf+z2IX4IvCiosv1fIOrrF78fVPAQFpf/1CzuQhYGOAnoCuXu4WKT/+0h8Gn1ousnfc0nh2RAahsYxWreLrhhxtYxVrBLYFClZnDsMC/HqCdDKbOkLJ6AouAD96I6IIelou8b3TBaNumqPu1ekv1OtklCbtFNHxdxhHlwhDRMMEdghg+TYqpVuPZZw7MfiBG/VWaLNmmxOAicOi1v7A5fhIw3BBtcOtnhJALnhDKsJcGzybxJv/cRS82exiPTHWeMiGbwhsRyo96MFKkumuHWLESTsoC48eN6kb9uRQ70xD7QLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ysoft.com;
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5)
 by AS8PR04MB8801.eurprd04.prod.outlook.com (2603:10a6:20b:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 13:13:52 +0000
Received: from AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b]) by AM9PR04MB7538.eurprd04.prod.outlook.com
 ([fe80::e597:9071:d0c4:c01b%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 13:13:52 +0000
Message-ID: <056921a1-8fd0-41f6-982a-6d47570b50c7@ysoft.com>
Date: Tue, 25 Nov 2025 14:13:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
To: Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
 Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
 <2b7cdfda-c9ea-427f-bf30-692132b15f41@mailbox.org>
Content-Language: en-US
From: Petr Benes <petr.benes@ysoft.com>
In-Reply-To: <2b7cdfda-c9ea-427f-bf30-692132b15f41@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:803:50::44) To AM9PR04MB7538.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7538:EE_|AS8PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 510d3511-3a90-432b-b784-08de2c247ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amVqUnVraVZib0dPZldNUExUdG45V0FGUzU1bEdLUlYrU3JIWkErUjFUQzAz?=
 =?utf-8?B?QVJGOGNCMUlhTmx5SHJSUTlqc05yQStmL3Zjb2VnT2RjQmU2NVdvdWk0ZmRo?=
 =?utf-8?B?OHlvQ2pBU3UrRDhYZ0wxczlDdHA4M1l5RmxUZkxVaDFXTVBGQUtRUkdROGlW?=
 =?utf-8?B?WUJiTnd3WnFCRXd1Q2g2THFrWHRYeFk2VTg3ekxhRmtCeGlwa2tkckZXSFZj?=
 =?utf-8?B?enM5TjQvakZIVFkwVk9qUlNyUnZBTm1lSlh4UExvSkpLK2EwWFpGZnFIbFFx?=
 =?utf-8?B?QTVHMlEzSnNpdUtLTUk0Yzl6ZVF1alFIT0Qvc01qTVIyLy9xcGhGQ2RPRlcz?=
 =?utf-8?B?VjJBQnJYS3ViV3ZGYll6dmxpS2VPcStMSC9GRmJ4NlFEMzF1dWhBYlc4cU12?=
 =?utf-8?B?Vk1GWDBlZmJEaWpDQXJVMnlTS2pybE9iTDk0bUR6SlFtM2IwM0ZXNFJrTDRP?=
 =?utf-8?B?UithdTA0eXpGbVVyT00zMFozT1I1Z0lMZXdYa0J4WmdMT2Q3S0F5aXFpSFZE?=
 =?utf-8?B?dmRtSzc0WkRUcnNEM28reEJWbmFwV1E5SFZCU0t1ZVBKM2xxa09PdmdGb2ZS?=
 =?utf-8?B?NWo3RDljM2lEeHdaNkU2Lzg2dG5xSnBxY2NQWmwyMUpsTHR6VEhpS0lzY0Nj?=
 =?utf-8?B?QmlvNTFmc1N2UXl2ci91WFZYNHVnbFUrdmRtbTZvM25ObSt2cWUrZUM5ZUFF?=
 =?utf-8?B?UjhCUnBBYmsraUdGVStrZTNLa3IvYnFlQ05ISDNldjdVSVpLd0RLM05RVHZ1?=
 =?utf-8?B?bDJiRis0QnJzQ045TXQrNDB5SCtBWXFFOGZicXZYc0xpTmRlUkJ2WUoxUWhl?=
 =?utf-8?B?R1pGamRjc1cxQUYreVRHQ3QwWWJaOXRQVS8vRWtBU1NxREdTL3E1TFlNTkpn?=
 =?utf-8?B?SVN2YzkxU0JHbjlHNjBGc2tES3AyZWNRRGFKbStoYkE1cnhTODB3UU1nSVhR?=
 =?utf-8?B?aWx2ZFJ4MDh3RjFPbGozYVljc2hDeFNEa3dqMUdLbEx3eGpvaUtlT1lYVXFM?=
 =?utf-8?B?K09kdW9icnNJN1lHMUh6Y3U0KzVSb1I0eVp1YURwZ3IxaGQwMk43WFhwY0tK?=
 =?utf-8?B?ZlJQWmRISUlpSFgxUU5SWHNGcjBBSFNGTTBYeVpsY0NabHR2SXR4QmFkM1dQ?=
 =?utf-8?B?VnUzSStIazB2a2ZycGUvS2o3V1A3VHVRczNmTmF6WFkzRnJIUDVxV1dlSzNp?=
 =?utf-8?B?Umpoei94YStXM2dsWEdMM01TRnZkcG52V0RGTmRwaHhhR1NzSHBlTWxLeC9F?=
 =?utf-8?B?c0hBMms0UUhwZDZrQVE0VTZlZ205ZGtQMVdlcGpKWExsZUNER204Yk1NWFMz?=
 =?utf-8?B?VDV0dko1cmNTZnRJNGZ2c05yOWRRdlFJeWVsOWR0V2o1TmZnTXQxZURjQm1O?=
 =?utf-8?B?dmNDMDhVVlAvVU80dUJCM0hzSnFoVitML3o2RzFnS1N0akxXY1ROc3RDT1M3?=
 =?utf-8?B?VkNXZGV2aVNKNFl4cWtsN01vNjM0a2svT0pNOXJNMWJqV2tIa3hNOHNXVEp2?=
 =?utf-8?B?WFZqVlNpTmJmYWYyaExXWDBDYzFoTDR2SzJ3L0hYMjFjNzZNZi83MmpSOTVm?=
 =?utf-8?B?RDFVYWZiRGVjL25DcHgwbXhVMndqVm9DcjRDamVrRFRUQUJPMEdEamlrMVZ2?=
 =?utf-8?B?ZTYramNITEsxbHpuWXNXWTdmbmg0YUpMbm5YUmc4SFMvWUtkTlZZRHFRMEVl?=
 =?utf-8?B?bU9BcTBGYTNLTXlUOVptYm5UYklsNGdCMG94N3FXWW9Qd2tHdUVpYWVKN3cw?=
 =?utf-8?B?bnJpWlVza3NtY3g0UTVXc3l3SzJJbFhPekZtWTlFcFRaUGVjZkxBSUJ3ZSt1?=
 =?utf-8?B?Z2dNOFhJU0ZZMmprbmE2Tk5pQ0xOa3pUamZSQnZZd2RVSmlEZ3FMYWVncGJm?=
 =?utf-8?B?SExUOE9tcHRNVnhrZy8zTG0yN3FTdnpDMjl6WEEzVG42VHoxa3BWRVh1QURP?=
 =?utf-8?Q?7qPM202ed9eUnDpPOc/XVvfXkbp+bfLA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7538.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJPODFINmNtSU8xTG5UNmd0amRqRUJyZUhwdXpNVG1MMmFhaVRrdWUvRzlm?=
 =?utf-8?B?QXFad3QwL20xdnVuNEZCL0QrWmoybyt5TGFUa0V0bHNXL2FROEo5V1VISjZV?=
 =?utf-8?B?NmUrYUVXSUZnM3hzSG9QcWxoSWpxRnJXTVVZZXB0ZWdtamVZZ05aeHJsWnA5?=
 =?utf-8?B?NTJnS2FLcnU1OHYwV3hBbHNGYlg1dEdvV1BlcTVPWmFWMUN1WFpZUE9OQ2E2?=
 =?utf-8?B?bzdpd0xTODE5bFdxMGVmbXdYbGlhTkRuazdtbWpGYUZkNk1ENWlrT2FsVHRP?=
 =?utf-8?B?dUp5NEJyN2Z5MjZjcVlYSmw3d2pXS1hPb0hoMVlTM3ozMHhhUjBnbFE3TUNx?=
 =?utf-8?B?YWdoTFRRTlp4enRVQ0NCbExRdHFCRWh3NHRtZWlicjFIWkVlVHU3V2lrQytH?=
 =?utf-8?B?YUpoVmN3YzJOSGVzZS9uZVRxMUN3Y3hTcEhSdmhzdkthOVpKdjJpSlRFckMx?=
 =?utf-8?B?ZXhyK3YzejMyeXYxU2lKQ3dGck5Ca0RvbmZsV2lCaHJYMUo3QnNmVjNZZjZN?=
 =?utf-8?B?aktsdTZyZ2tMenNkaW81ZkVYcXgxQnNweVFUZk9xUm9ONG02WXRRUTI3REFD?=
 =?utf-8?B?M1lQVmppTDd5UTFGdklWMFJHYTdYZjc0OHlhaFRCZnlaRVpFUnNnNzhtUEht?=
 =?utf-8?B?U1JITUl1NmJJaUJtNE1ha0ZjSmpuQjJsd25zU0RNcnRNME5PdnNtTTJpSkky?=
 =?utf-8?B?YW5lYytSa0NFcnc2RzhzVWhHSVBEN2VwU3daYzZ6ZmJaM0U2ZTY3K2ErNFE1?=
 =?utf-8?B?bVdEcW5hUXpwQ1g0cWZsSjAwMHIvZm1NbWxTcjYrQ1hCeFJSWVo4N0RFcXo0?=
 =?utf-8?B?S016cklMQzZIdlY4OUNpc3ppWUQ0YkJnOEUzSE9DdUVGdEZlUmcwU0djcmow?=
 =?utf-8?B?ZFhMVXdlem5SQVpCT0dWQ2VKbENSSU5aUnMzZktDREhkbC9NL2E4Rmd1SVVa?=
 =?utf-8?B?V3hvTUFqazJ5VkRQSEhZWGVkY3FLcGlDK3ZGaytsS3JEMFhURDZyNzExS1NH?=
 =?utf-8?B?MHJmL0dhQktsVjVneFI3QVpxaHpIOGxsK2h6VTNQYkdQeGtwR0VhdmpxZ1Zk?=
 =?utf-8?B?aCtpenlTOHNjMU9OWG04dlFpcDMyNXhISTdibHJ6emhTRThNSnFzMkFXM1pz?=
 =?utf-8?B?Y3V1dmR3a3FnWnpLNndOaVFsRTdVbTlxcitmUjhLbnZmUEIxa2RwenNnWDhl?=
 =?utf-8?B?SFdtZXN0YmhsTUFad081dUZZQkgwS3FFSWp5VWFaQmNiQm94ZGVlOE4rQjBl?=
 =?utf-8?B?K0FsNXd6bElLS28zdUtVTERoSTBsV3M5Ui9ndjQ4RGdldVNlamJma1l0WW91?=
 =?utf-8?B?RVFPaWRnNlJBenBwc1BRWFdhMjFPc2NaaTByZ2xla2REKzlDWHhOcnRCQTdL?=
 =?utf-8?B?RmlhWVZ6YjJFeTVDOGs2NGdyeXVCbCt4YzJGV084NmVPbC85cFlBTURTSjl4?=
 =?utf-8?B?MUVMT3djNzVlYWFLWWs0dWkxMkpFUEFjUHdQUUNjMTBjNDRTTnlwclFZN0Yy?=
 =?utf-8?B?WUdkZjYyME5QcWkybzVYd2JGV1p3RWZZK284NGFCWnJpc3E4UXZ5VURUcFVT?=
 =?utf-8?B?eFdKcWtzQUlObzVMRXp1cVM2OUQ5L25zc3RuNytONGtZWTZkdXkzQ25LNmJq?=
 =?utf-8?B?ZnV3ckZEem5RRU5LOUtTZE1EZ2JBVHRXSy80OWYzSGpCK2tGeEl1OXFqcVd5?=
 =?utf-8?B?QkFoTTBGaGhYTDRYMTEvMlBCV3VPdngxNFlieEFkQi96NzVKVURycEtLUC9y?=
 =?utf-8?B?NDIvVE1VY1JzMzIyMUxpZzZQaHF3eGIweDNlUkhGc21KNUxIQ05EdVdVcStV?=
 =?utf-8?B?cjRwcTBFSkxoREt5azBtTnJ0OVBWbDlwZkR6TTVKOGZBaXkwRHlGYXZJRjNQ?=
 =?utf-8?B?T0s1L2g5V2xqV2dSWjdKcnR4UG9ENWtpMDZwTVZCVU1hdHBGZVA0MTIzYU5E?=
 =?utf-8?B?dzBrVWpyeWh2THlBeElmOE5nQ0VVanYzeUNTaERJem9KTnpwSGcrQkZvckd5?=
 =?utf-8?B?TFgyZkdudGVieGl0N3F3dHN1SkZGL3JHa0IrTXJycDJJeURTckx2bmVDWEVL?=
 =?utf-8?B?TkRWRHViZTVGQ1pOZ3hNYmdFaUkyRHFjUHpuMmZITkVtcVh3V2JwN2RXcWhQ?=
 =?utf-8?Q?eZxpGrkCNcXIy2QhqAt5DHg03?=
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d3511-3a90-432b-b784-08de2c247ae4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:13:52.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHwgheAKMf4vYLU+vbpXq8sr+DU+YVsFfbq0uTeaz+1BLwNiIwcHSGYrXK69sTkUwy56vGYgc8YBQZTCHQ8Hpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8801
X-Mailman-Approved-At: Tue, 25 Nov 2025 14:46:45 +0100
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



On 11/25/25 1:26 PM, Marek Vasut wrote:
> [EXTERNAL EMAIL]
>
> On 11/25/25 9:58 AM, Michal Vok=C3=A1=C4=8D wrote:
>> From: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>>
>> There are two places where ci_ep->desc could be accessed despite it is
>> not valid at that moment. Either the endpoint has not been enabled yet
>> or it has been disabled meanwhile (The ethernet gadged behaves this way
>> at least.). That results in dereferencing a null pointer.
>
> Is there a test case which triggers this problem ?

e.g. repetitive use of tftp, the first works, second may hang, resets
the system, whatever

________________________________

CONFIDENTIALITY NOTICE
This message is for the named person's use only. It may contain confidentia=
l, proprietary or legally privileged information.
If you receive this message in error, please immediately delete it and all =
copies of it from your system, destroy any hard copies of it and notify us =
by email to info@ysoft.com with a copy of this message. You must not, direc=
tly or indirectly, use, disclose, distribute, print or copy any part of thi=
s message if you are not the intended recipient. Y Soft and any of its subs=
idiaries each reserves the right to monitor all e-mail communications throu=
gh its networks.
Y Soft is neither liable for the proper, complete transmission of the infor=
mation contained in this communication nor any delay in its receipt. This e=
mail was scanned for the presence of computer viruses. In the unfortunate e=
vent of infection Y Soft does not accept liability.
Any views expressed in this message are those of the individual sender, exc=
ept where the message states otherwise and the sender is authorised to stat=
e them.
