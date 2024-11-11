Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B38D2E9D1
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CCE89368;
	Mon, 11 Nov 2024 11:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m9DSsMJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B6189367; Mon, 11 Nov 2024 11:03:26 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0E589342
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTVAx0aeeP4mQlFWdICDnS962k+8tEVrl/i2LE85rdDrmewbCEmC1mhNhQgmm+B9EwX8/lkv/UTXrnaiUKTQPRoSrl6Sh2gPGh5iyoxbo2b+AqXtMtZaKmLw8mbxnwMImCyMPIdemvFpOHQXlWqoPpryG1k6ButSZ9B2/XHj9Jr2wN/lxRxGOH0VwWek9OfjcLHnxu+urhJ46o48eBmAZX+c6KXPb66jTAv6ME+h5CZSWgvO1XAN7E0exGq5125+lnFG7GBSdaTFrC1iGV3cq1cxOP2zBCZ89Hzkl9ebmz59jJC6y0+BNmRPu4gOoRKslRIdTSHBeaJ02Z0Mw+ruVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yttjKBy7Bz4esLAn3CmbSiMaeTydiWbjgw+r1jDN7zw=;
 b=TZ2l/ubPa/xkC1/7nB32rukoKn2nAMvzyGEH5AUUYqPdLqRd+CFH1J/Gp5ZXisshDUlN1tj9dKP2mogDOP5JyL1SenTbvH5UWTPCk1zukY/1DsfLiiQWyEqFTuuN4ezfAOT4ndK/o9jWTudTT8owXfzuLbewuOoXb9uTzwpFCPfTwIgFMpe3Gg8T5LciHZHM6UH9tlEPUjfC39EHbyj9JTcAcEKxX+5jVaTuvZkXfNovzMvfQmx7CPqspbxil1oTsnFp3S3uB+XJqMlolOKqP704s87K1RT+t0dtEDCQN1qLbHI7P51bj2Cah6ZoSjkSWt8kgNDQLTg2SR84DmetXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yttjKBy7Bz4esLAn3CmbSiMaeTydiWbjgw+r1jDN7zw=;
 b=m9DSsMJUyBmVMnJwBaDV3BjW/i4ivkPQNgdzj6xmo1fCfS1dzKPilm+3+YMK23FDuMcKurh4a3vb4BgovyULegGqVjb1HoCQDKxLs4u7KzARCZgztvB52JyTjUUTm+1eVO5rOYq1p2aJRhTZS+NfJ4aIwftss8lx1xuy6qhnwSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10611.eurprd04.prod.outlook.com (2603:10a6:150:21c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 10:03:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 10:03:19 +0000
Message-ID: <d2d6f345-cdd0-4b1c-b91e-60910409eb44@cherry.de>
Date: Mon, 11 Nov 2024 11:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] sandbox: Report host default-filename in native
 mode
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20241107213150.1711962-1-sjg@chromium.org>
 <20241107213150.1711962-7-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241107213150.1711962-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10611:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f273f-6b37-4f27-fb7d-08dd0238118f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THRzYW9OU2dicTZSSjZtajhmVXAraituZHorV09RMXYzcXBuRWNoNHVMak9z?=
 =?utf-8?B?YmNwT2t5NTJLS0lDdW1XUjBVdkpZVytZL0NPWWlVSlV5ZmRxUWRJZHBEUzlz?=
 =?utf-8?B?Y2RsU0JSLzh4dVFEMlVyTUd2cEJOaHBmY3BDVzlvRk9zcU1IamNxeXRsdDNx?=
 =?utf-8?B?YUxYVVFoSXRBK0V4aFZ5ZzdBTk9iSVRLZERHUnJ1OGcrc2hmcE9RM1R0Q0R1?=
 =?utf-8?B?aWt3ZHVPcTBhaUdQeVdrVE5hVlFrUDJtY0ViUnBRdjI5eWZwaEhtYnYrUVkv?=
 =?utf-8?B?VlRsUXVNeUwyQVo1STZiNjhiam02UWwzcnhld1VWQ0RuTWhicGM2c2R6V283?=
 =?utf-8?B?cDBxUEN5N0Q1cFhhMDBrVS93OTRNeDNPT3hJQkpSaWNiMFVtcE9JQURCWXhk?=
 =?utf-8?B?RjkyR3FaMnNDK3BhNVFJT0IzSUNsMXQzL0tqMmd1Tllrd1FmcCs5ZHE3bzQw?=
 =?utf-8?B?a1NPMEczVG1aa1NXN2xucEVUK2lJeTRXOEEzYmtGOGl2NVI2VFltR2M1cmEx?=
 =?utf-8?B?ZGVWS0l3ZThHcU5GSVNFNThKRWxROThrTmYwRDlNQnNGL29UdGxHb2ZmRnpN?=
 =?utf-8?B?dEVoVXhzblpYR2RGQzV0K3paaTNsWTdWS1hEcGt3bnE2RGFxTWFpRW05djV1?=
 =?utf-8?B?UUJVa1VvYWVZd3RzckoyUXpxQ0Noa0dkdFdlZlhDRjk5WFF5UlVqZmtQRkZD?=
 =?utf-8?B?SVk4dHRucENQRWtPOHRpQis5eUU1UHl2VWRJbk54aC9GZmVSRkdPWnNIbUsw?=
 =?utf-8?B?RDVwdjdVMlpPVHdyeW13Wi9ZVHJxZHdmdDNmMENpMW5uWkZYZ1kwMURWUERZ?=
 =?utf-8?B?VVdDQ1ZScU1rNzRTUmlvcll1YXowZ2F1cW1ZcVZ5RjVEODd6K29Zai9DRmJT?=
 =?utf-8?B?cFJSR1BwRVdOQ2FuMkhsQmZ3VVV3Tnp2QzRhK0kwa1lKL3hBNks2U1JaQitG?=
 =?utf-8?B?OEc5M1FiQjNrZzJFeExNN3VhNVhVRHpLcUtueUdpWEtEa1p4aGpDTk0zWnpY?=
 =?utf-8?B?cFR2Nk9nVmxBbnd5MmJNTHBkNEI3YW5YQTFUZjJiclNGWWI4MUNuY0taam1h?=
 =?utf-8?B?Mm9BelNtY1RtSlE1c3NuSFp0RmRqWVlIb282VlY5UlBnOHJCb1E5TnBlajh0?=
 =?utf-8?B?SnNUMUcyVnZQWGNzdDB0TmR2WkVrZ0d2cW1POGIrS2c2L0hkTm5jbEdBc0FM?=
 =?utf-8?B?SmdOL2tOVUNQbGFaOE5rd1N3OGllSWVCaGIzdUErRFFURE5ocEYxbVZoN3Rv?=
 =?utf-8?B?aWxWdG5lcnY1S2F1Nm9hc0ExOXMzd0dvV1pJa1krMmIvbFRROWhpK3RLZDRF?=
 =?utf-8?B?a2RSZzZrbC9vZDIvUkhKamRiWUl5YmxJQmkvNkQ0RWZESGE2NkdmRjVVR1dJ?=
 =?utf-8?B?WWNLb0pjcnMyQTgvZFc2Qk52OFU5ajBlOUJxcXUza281TVpkUm1pZFhZZmxC?=
 =?utf-8?B?THorUEZWT0tWaGwycjVtem4vTUxqblhzVTlDRDhqblBXbVl4LzJ5bW9mS1Bk?=
 =?utf-8?B?Q0tTdDFpVzFPVEdibkNSa2FZaXg3K3lGNStTVnNtbzVWamc3WXZSQ3c5Rmp3?=
 =?utf-8?B?NnBJeGw0MkJrelhyZHJGZFVDbFc0U0hxWXhnOEIxOUFFZUNiSTNNMk54QXZt?=
 =?utf-8?B?WWNrZ3hUQnFlcXBhdXVwTGVMK3FJc2FvWENtUVBrRjBkT2VFN09BZnZ5S1Nj?=
 =?utf-8?B?V2pKVDZ1TjNuY2dCeEV5RzVOa0k0M2ZvTVdOOFV3S1NQTG5mTWpYSEZmTDgw?=
 =?utf-8?Q?5MOWzLqP/oHKi2ekKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVFUVjV6cWVYVE9lSWhwSVJaOVJHcHVIZ3BuMG11SmFPS0YvY2Z2UHh0eEhE?=
 =?utf-8?B?bnZ4QWtOdVFpWFBrQ3U2dG1pU0ZpaElFc0VnVHRIZHNqYXZsUGcxbk1QVm54?=
 =?utf-8?B?UDBQMHZzL0RwM3F0bXRVbzQ4S25PZW1YKzNrVzNQeGpNTGphYVJ1TlZobmha?=
 =?utf-8?B?M1B1eTg4VjUrWUtwQjFuOW82Qk5IRmhqQjRwM1BMaTUxVzEwVjJOUFR1VEV3?=
 =?utf-8?B?Y1FjbDAxUUNvd1VWZTVWUDdtbzZrQ2owcCtRWXZUbFlmN01vRUF3aU1GK0dq?=
 =?utf-8?B?MDBFVW5SbTBnY2UrbzRXcUNmSGJ1RlV1aWxTTEFhUXo5d0c3MFh5TThlUFBz?=
 =?utf-8?B?eUs0WklFcDRHaEl5eTJPNG9qcWthUElEZ0g4MnlKSVBVU2dDV0Mza1ZTRUh2?=
 =?utf-8?B?SlY4Nm9UbmFLbFp5KzRpaU4rZVh5T2N4MXZyWXN4WFd0WUdmZFhLVU94L0lF?=
 =?utf-8?B?ME5DMWh0eTNVYWt3UzZRcVg4NGEvdmhBelV6N29Hd2VkYmVEeFBzMVFBUXRB?=
 =?utf-8?B?REdXaWdEYjNXeGFDbEJEd0xLQnJ1b3A2WHRtendMd1lHR2NkUGxnMTdLYnpO?=
 =?utf-8?B?WjJiSUl2WTNydTM5TlhwT3MzVEtHMThza1FnNFNqSWxaZE9hTmVnbWFCb2tp?=
 =?utf-8?B?NHlBU0tpcWNidmc0QzNsUlhqdloyZXFER0pJNnN1ZytqY3hzYUFtT29vb1da?=
 =?utf-8?B?VFpES3ZiSlVhb2lwUmgwT3VyeVJuQktPbzJkMEFJclpRcGtiamlMVmNGRDMv?=
 =?utf-8?B?SHNhQ3Z1N0JJaVcvajZpNWNSc3Buak9BTlhvNGN6WmoydXZDUHdqd0R2Z2Jt?=
 =?utf-8?B?TE5IZzNISms5WVg5ck90aHcybUphT2pSNWFwOUJzcTh1bFdJMmpMRDdlcU5u?=
 =?utf-8?B?TzA3R2NqbjRSeTB3Y0d1VHdOem90OS95Szh1SjkvM1hsVWtoTjk3a3VrRnk5?=
 =?utf-8?B?TXZMeEQ1S1EvZ3E4YjRZWURpNUFlZEFEMnpMSmJKT2R4M1NNa1g2elBldWRl?=
 =?utf-8?B?ZHFoWWowWXYrdXVUakRhSkNZMjlzeUtQYnpNL2xnQXYrSUZWU3V1QjJ4N3JQ?=
 =?utf-8?B?cGMvSVVCWk1FU0xmdDlRV0t5TGlwVmtQVlpESmV4OG04eWlhaHBnWkI0WDhV?=
 =?utf-8?B?aDJmejlUVWJHVlpXN3pWUW9XcFhxVEJWTXJlaEwvcVpKMHI1VW55N2UzRG9T?=
 =?utf-8?B?L01aWnhDU1hqR0ZETUhmU0tnanhCQ0JXSzNxOCtXUE55QzN3VCtEczJBMHNr?=
 =?utf-8?B?cFczaFgxaWdjZ1RDOWxQVDNUdzJnaC9Qa1czZ1lieFFWajQ2blRzeDJMUnRL?=
 =?utf-8?B?M1pZeG9DQUZmUFZ4MDk1K29US1RUcHcxbXJ4eGtLS0hWN3ZyZ0JKaXRBVHU3?=
 =?utf-8?B?TlFWSnlZWmdRUWo1eHZyTEpoaWNqeGJxOTVaeCtMZ1ZUZnRURHhqeVVSaWsr?=
 =?utf-8?B?WVpLaXhwRHpZdG4xZFpyUVYxZFV6RXdTeUUvU09iY2FpOVVJVC9iOWpMa2hF?=
 =?utf-8?B?dGRTbTZyVlRveWlTVFFibGJUUlRQdGtsNEFMd1orRkJRa2k0WUhORkM0bkVI?=
 =?utf-8?B?OHZIZHNReTduUXY3N1RSalZuMm1iREJWN1gvS0paNWs2d3VvbWdmWXhhUWFP?=
 =?utf-8?B?cFFXVkVKT29XRUY0eGNVL3hlRlpRTGlkV1pMb3kyc2Z5azBsQ1NTQkxSQTRI?=
 =?utf-8?B?cktDZUswVVNCeGxLak45TUtuaVd1ajJMZjBpaWY1b0pGOFFldy9DWG9VelUz?=
 =?utf-8?B?TXI4N1Z6UFVOMW91MzBPVGJuOU9jRHFJeGpIQVdVYzQ3c1plM1FGeVVGUXJB?=
 =?utf-8?B?cTZzR2JSQzhjY1Z4RVc2aHpTaVZ1UktYS3pMN0h3WDQ0SU0rNmlMNWFqbkJQ?=
 =?utf-8?B?dE9JVFVQbWk3Ti9DRXVlRzkwZWNaMGMwZCthcmZxRk5ocHlnNHBTbzlWdXdE?=
 =?utf-8?B?TTJWdkFTaTU5bTFZWDA2eXdrZmYxQlJBRG5FS3I5R29jQXU0RGs1dUxyQkpG?=
 =?utf-8?B?QjdUb2lXbEpnTWh0VlBQc2tENS9UQllkcEJUMXBBZDAwS3crV1pFNkYwSkRo?=
 =?utf-8?B?TjFoN3B5ZU81WmxMNWFtdVFOZzhVWEI1eWtxTzZBcEQrTEtyclJjV0NiOUFP?=
 =?utf-8?B?dHc5c3IxYXN6dEtJak14ZXBydmJZN3hJR3RNd25FZ3dXNDZnMkU1Y0NrczBD?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f273f-6b37-4f27-fb7d-08dd0238118f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 10:03:19.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4ecK2NDlJHoniSt833YUngsPNzVAmImRbXWw1G9x5zWvzfoZFiNqx8me/19SbbzflzlQ9yifT9nGLd91e/+T9QExZAwO2mRWnI1T/a2Igc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10611
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

On 11/7/24 10:31 PM, Simon Glass wrote:
> When the --native flag is given, pretend to be running the host
> architecture rather than sandbox.
> 
> Allow the same control for PXE too.
> 

Commit 7506c1566998 ("sandbox: Report host default-filename in native 
mode") breaks building jaguar-rk3588_defconfig, I believe it's this patch?

Reverting it makes the build pass again.

HOST_ARCH is empty in include/generated/version_autogenerated.h for some 
reason. Though it was also empty before.

The error is:

"""
lib/efi_loader/efi_helper.c:26:15: error: operator '==' has no left operand
    26 | #if HOST_ARCH == HOST_ARCH_X86_64
       |               ^~
lib/efi_loader/efi_helper.c:29:17: error: operator '==' has no left operand
    29 | #elif HOST_ARCH == HOST_ARCH_X86
       |                 ^~
lib/efi_loader/efi_helper.c:32:17: error: operator '==' has no left operand
    32 | #elif HOST_ARCH == HOST_ARCH_AARCH64
       |                 ^~
lib/efi_loader/efi_helper.c:35:17: error: operator '==' has no left operand
    35 | #elif HOST_ARCH == HOST_ARCH_ARM
       |                 ^~
lib/efi_loader/efi_helper.c:38:17: error: operator '==' has no left operand
    38 | #elif HOST_ARCH == HOST_ARCH_RISCV32
       |                 ^~
lib/efi_loader/efi_helper.c:41:17: error: operator '==' has no left operand
    41 | #elif HOST_ARCH == HOST_ARCH_RISCV64
       |                 ^~
lib/efi_loader/efi_helper.c:45:2: error: #error Unsupported Host 
architecture
    45 | #error Unsupported Host architecture
       |  ^~~~~
lib/efi_loader/efi_helper.c: In function ‘efi_get_basename’:
lib/efi_loader/efi_helper.c:73:38: error: ‘HOST_BOOTEFI_NAME’ undeclared 
(first use in this function); did you mean ‘BOOTEFI_NAME’?
    73 |         return efi_use_host_arch() ? HOST_BOOTEFI_NAME : 
BOOTEFI_NAME;
       |                                      ^~~~~~~~~~~~~~~~~
       |                                      BOOTEFI_NAME
lib/efi_loader/efi_helper.c:73:38: note: each undeclared identifier is 
reported only once for each function it appears in
lib/efi_loader/efi_helper.c: In function ‘efi_get_pxe_arch’:
lib/efi_loader/efi_helper.c:79:24: error: ‘HOST_PXE_ARCH’ undeclared 
(first use in this function); did you mean ‘HOST_ARCH’?
    79 |                 return HOST_PXE_ARCH;
       |                        ^~~~~~~~~~~~~
       |                        HOST_ARCH
lib/efi_loader/efi_helper.c: In function ‘efi_get_basename’:
lib/efi_loader/efi_helper.c:74:1: warning: control reaches end of 
non-void function [-Wreturn-type]
    74 | }
       | ^
make[2]: *** [scripts/Makefile.build:256: lib/efi_loader/efi_helper.o] 
Error 1
make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
make: *** [Makefile:1914: lib] Error 2
make: *** Waiting for unfinished jobs....
"""

The build host for me is Fedora 41.

Cheers,
Quentin
