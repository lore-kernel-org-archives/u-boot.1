Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC05BC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73B1B607E3;
	Wed, 22 Jul 2026 14:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hVE2-e0C8_2Q; Wed, 22 Jul 2026 14:07:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 769B5607D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784729276;
	bh=hGfcpxAjEXQnhhpyISVMRblTR5nDmqoQ6InFNcLoDBI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Z1AwV2KLTwucrwBwiCYdRKiPtpR8T1eAIkAl6qIYrh+jxjP9GsB/y6mAu1M2ezhMg
	 VPFT/Vf4TDwfWfkUsDSUsxwWFce7Fa4IKj29pciBECye6wpbbZqxmHADQMZjg0+zh7
	 Mg8AI0egBCg7RZY63wZ2ZFJoB/ylNtiX2yOWjNiaw2iwe5Hy6f2UsafTu55eouf7bo
	 /Y2Jjx/0fTRi3uzFN/PEugEb3QLs3mFT/mz9xglZ8fc5KWiTspObFUfLE7QwygFy4h
	 rsJb92FPvc5FRkJZ8c7LkuMkzfyZNLB6ZNEz/57YCvKOk+IgNoM88Nzl/Cgs6QW/5g
	 AQ2DkUYlKH5eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 769B5607D4;
	Wed, 22 Jul 2026 14:07:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1923A224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0AEA9607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:07:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTnXV_IcCY0T for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:07:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 06866607B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06866607B8
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06866607B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4W911pzVlhsyz8SRy1wtdoOh747nh5sGBgO+UHFbg4gccMCGHYLQzoTDaMA8qf9oW1eym3oHNkPQ8OAAI08SP49TkI/WYUSHA7uUFhW8jAotXsMHeclFbAiTSd+W9jAoEPB/1KcJhY9Cc30oysC+CDkZ719hHgZAjw5aUy4Ne6Id0EMc0uUwHYa9UyUE0LXEV/f3BfmhOR4G61J9jToZRgB1g0dtnHERx4VMljTqvGHXw69lxQL5QJyJfsebRfADFqoTtWiMpTfMyuHrdeSLMkezAneZWQgkxh/SwqJbWVsRmRBGKdvRQR9v2EePvYeEvj0sUJ0KFNj4CQbk/r/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGfcpxAjEXQnhhpyISVMRblTR5nDmqoQ6InFNcLoDBI=;
 b=ZHW0rm8jj5VBttO2Uec+dYLj0nHiC9fN8eHJRJ1ELCDSwI2LwN3r/nD2zBgidNdFcD3AuAuNYH9og/bQMF0Qat259hhPuxG5+HVZ0tyEHRtDS+hHoNgSphwZ2zsGgW36DGBRF6wuGy+Cn+R/NQV0t+Jd18kEYirZEWrNLYZC+eINr65hfu2zLIlVCXR7SxGiIR5kq3EO96bD+e6l6LZGWYmrkeSR2Lr2xpbrR7f9H62aXS0xJTBX/8XeloU+eFobHSyKVWFlm5koicjtBLj7KKBoDEQgg6de8KvH+MF21SSG7EZsouzSI/yHyRFOS8f+xBQbuRI6AyMCLB0g1OPzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU4PR04MB10767.eurprd04.prod.outlook.com (2603:10a6:10:580::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:07:49 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 14:07:49 +0000
Message-ID: <947e7881-5a3b-41b2-aa8b-5c93d495bced@cherry.de>
Date: Wed, 22 Jul 2026 16:07:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
 <20260722013642.1011666-3-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722013642.1011666-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0072.eurprd02.prod.outlook.com
 (2603:10a6:802:14::43) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU4PR04MB10767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0651ef-4ae4-490a-2191-08dee7fa9cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TX7YA0dJwCGMVkT4ltxaJd6QSyoQzD/FnHsbeOEOV9ybvb8qDLrKOcipP0vMZZfxQB8LuZOoxLN0WYsAS+HduwG0tDZdfujlpqs0MsdES2bcwWWBGe7TfAkhfLKfaySktKIMFQKX84Di7yysoJT47/6WJGQQEsGZcxaLi8z+WT7xmmIxtT8NKwQD6ooeZIZrBJTWF0I3JzxTgdJZ3CAPiovX2d5MJXZZIHMc8aqmRS9N071fQPa1ouPcdiY1nX+gIt5G9mKCIktgfJKIsNp4ekbo2wC2ZPTGIcS56HA4rx1Fj1Cox5yl9vDhAiU1ty7SQ2G/jhXiVYML/nH3kARY1hQC06Xbn0qNREwo/BFbdATGsu6zxX5pkQPiwXDCuA3cII+SKOtmnzV276qh9SLIKtIGy968mJiW5is6y0aahtR/9yVFQMeo5IHygNPZe2DInP2tj+Z3gZWebfCvwKuvn+MM6bswNWflMiv7a7wgms/Wbm+fpQbAG2wRPhsUed5Ttz92HvWsOnYQCfSdwei8B8PN0E1uJGya2GLL+7hdim+BAzJWYpNiPlZq8aUB8+t7cww4s4iCg9L2WDlL9GGQM0kez+nK2a0Ic6lLL7SVzrdoPHYuSefnupyPEYjR3lr9FZqb+2I3+haUvWyHOXYc/fVrP71ZOtTSb7C+zw472Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c213M2FnR1dieVp2TURvdGQ0bFVLb0tuNW5rMk9uWTRwUnVTYUVUcTNGYWZ2?=
 =?utf-8?B?RkVkYVZ6Wm1oVmFQMnB3MXl4RWx6cHdLRmtTa2NqRnY2QkFxWm9wUDJMYUlh?=
 =?utf-8?B?YW14cUxRMk81ZUhhUWw1SHdjaU5oZS9zUXB5R3llSHVOak11dHAzdE1uUDFY?=
 =?utf-8?B?SkxBVWkydVl6T3JMUkFBZG9wZWErbTFyNHgwRG1xbThscUhCcHNocTY3VFFF?=
 =?utf-8?B?bU9CTnpQL1NWWVE4eVcyUm5hejdwamxwMHgxdXJ6ZmZ0ZWZpUjk4WW9FNVYx?=
 =?utf-8?B?emc2c08wT0ZZUlMwYnVXYXg0cFJoODZRZDEvdFJVaEpCVW55Qjd0Q20rbXBo?=
 =?utf-8?B?aXFFeFV4Y0l4MytwekVYaHpyYjgyY1ZRa1pMZWNFNjFjeXpvWjk0S0ZiWVFt?=
 =?utf-8?B?YWtwQmNZTCtYcXFmdU1KQjB6L3BFY0l4a0dRRUJleUNLNGNxaEovSXBmck4w?=
 =?utf-8?B?SlN1dE1SbkJ3N01YanhkbnNGVzBsdXppbkIwRHdZc09WRER5TVRONXN2SUZE?=
 =?utf-8?B?UER3ZS9tT0dibzRjVkcvSnZpelJuZGp3ZW9RYXVpZHVsQW81RlZSYlEwbEpp?=
 =?utf-8?B?eHZFV0d0QlVBa280eUVWSkRKcXBVU2JyK1FvcmhRY1BqVWJ1ZVl1bEVBZUxX?=
 =?utf-8?B?RzZOdHR0bTR3akk3c0FvUTBrTDNuQm1SV285WDRhNFp3MmdQcHVMc081Z0lW?=
 =?utf-8?B?QjJVYkowOHkwK2x3bXFQa0pTVFhRMDhZZEdQS05wYnRvYTlWeXF6ZFJoVUZy?=
 =?utf-8?B?MkhRc3Z6aXpyaUVXTzJmd0lzVDFFUHpKM21GOVlTYVh6a1ZGeVk3R1hXK2Ny?=
 =?utf-8?B?Z1lDdEtGUXRvN3VIcmt0Q2dKTWhQRlExU2ZCR3RVcjczODQxWkJmZThvVWdx?=
 =?utf-8?B?MVY3cUJySlEwdFJrQmNmdERINC9MZWU1b2tEREprQVYrWFhPMTdCZ3dhWDdv?=
 =?utf-8?B?OUZBZTZNVm1DVGtGV1NXVEhCUC9EVllSVnlpRDZ6NmpUK2IwUWNiejNqYy9o?=
 =?utf-8?B?UXJJdy9ZUmZTWHFxdEhYTlV2Slc5TzRJZ0MzMHlUOHIyMkJXc2gzWlBtK3dJ?=
 =?utf-8?B?ZDNZS3puM0piU0tsclR4dko1M0dabFA2bk42YlVvandMZEYveWltM0Nidytx?=
 =?utf-8?B?SjZoejVxc3VQTmpQQ01BMlRibk5VdUN5NTV1SHZXYkdTbmF6U2JDdGc4QTJ2?=
 =?utf-8?B?ZDRuNkw4L0dQZXpaNEZRemIzc2J5ZjJnbnczZGVsaGY3RVlUSldqbDlrVGIw?=
 =?utf-8?B?aWlPQVRvdmZWRDBhQUswZDNmMHFGU1lXdVdzWGxQdE9mVjBSRjhENzU2Y2V2?=
 =?utf-8?B?bkdjSkk4VWlRRVdyK3JzSCtVY3F0RUxmT2dvOFZucmVXQmRnc1B6RzNBMm8v?=
 =?utf-8?B?dFdzSm5zYVlPQmhPd09VWGQ3SzVyWVI5NGRHRG0xc2lKVThPSDFBblpyZ2NP?=
 =?utf-8?B?aUE4VHVkczVQN2tXY0dIL1QyVW9TRVBCbWxzY3kraEJLNVpzdTZJTis3MGll?=
 =?utf-8?B?NE5odnhjTE9ZalVEbDdkTUJRZ2tYY1FQZFlKR3ZjZWExT2Zvdi80YXUxc29I?=
 =?utf-8?B?RjhOSFg5QVlWL2s0QmIvMi95WXRvcFdqZW8xeTFlbFJxbE5TR3FYdDVJT1BY?=
 =?utf-8?B?dk14c0VnTUlGcUUyZFVNRzZKY2FRZmxzZnU1TGZvdm94cmNyam1ZSmZFRC90?=
 =?utf-8?B?ODhpbHNuT2Q3MjdCcDhPNmJXaVZYWFBCb0dHTjRVbFZUcnEyUFVMWk5oVnhO?=
 =?utf-8?B?dzRRTXUxOVgzYVFuM0NkWFNuQVJJMVhQY0FKeHVMUW1QRnREWUJFUUhUdEdv?=
 =?utf-8?B?eURXY0tSSCtoNXhnYjZmSmluK0ZTeG05cmNoYjBiVU5mcHhnV1lZckVQQmZ5?=
 =?utf-8?B?L3p6QjBUenJINmlLTWxrV1pVUS9HYWJ3TUI5OVBHSU9POGxOTURZRTJYQnFm?=
 =?utf-8?B?R21kUlljcllOLytHWkgvTXN1Nisrc05xUjRUWVpTWXlQY1lsRmdObTgwQXMr?=
 =?utf-8?B?YmJkWHZJd3lBYTlFSkFqeWgvS3dETGR2YUdVdG5XdWJta1JSTWdXWnp5a1dS?=
 =?utf-8?B?bGJGTnZZUm1QSTg0WWcva1dRc3NkNzVOdEpMSnd3WEpQTmhZNitNSTkwMDI2?=
 =?utf-8?B?blUzN056TXJIK2VRRnJ1WkJzOUVhSVhBWmNUZTB3SmpQNnlOMjIrcG9SekxX?=
 =?utf-8?B?a2YxRk9KSzkrOG4vejdNaUR4U29odExOWm9YeUcvV0NNSC9wVXVybXladmk4?=
 =?utf-8?B?V2hrSktGZEZEQVVKdHdMdmNQKy9ZOHFCYTFtYnM1UG5DelMzdG43eVFFUm42?=
 =?utf-8?B?Y05Na2ZuY3NlZEdwZ1I2Wm1oUGhYSjVtdjRXMm92MWo3TkxzZjZlUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0651ef-4ae4-490a-2191-08dee7fa9cb2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:07:49.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW6Vjz1oEtsNlCArC34ev895lniU6fQf7r+IdizojwAdhKCowG8Leo1tfG6JhjpG218AhVIRjyZg4RUkYSg/GVqsH4hMmPocF8/d7SJIaM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10767
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGfcpxAjEXQnhhpyISVMRblTR5nDmqoQ6InFNcLoDBI=;
 b=NTB8hAVPtA1eInzyw9h5sFji3uv6zu7qlz2NMlZ63lBDy6wnTq4Xtg+d+zIVgTwN3CJ/w6JH9gzU5TOQwNLcZ/TpQW49pyyHX45IthFZreHg6KSVhqJhSCWbDZezPe+txYnMxo7+kmj3XY+tbb2GVNFbX1uG9w95J7zEa0L0XWI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NTB8hAVP
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 3:36 AM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
> while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL

The ROC-RK3399-PC-Pro also doesn't have one, so we'll need to figure out 
a way to differentiate them too (the day someone upstreams support for 
it :), we don't need to think about it today fortunately).

> and use the result to select the matching devicetree from the U-Boot
> FIT. Fall back to the original board if the I2C bus cannot be probed.
> 
> Build both devicetrees from the existing roc-pc-rk3399_defconfig and
> enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
> from the selected U-Boot devicetree so the matching Linux devicetree
> is used as well.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Added run-time board time detection.
> 
>   arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi |  3 ++
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 +++++
>   board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 37 +++++++++++++++++++++
>   configs/roc-pc-rk3399_defconfig             |  3 ++
>   doc/board/rockchip/rockchip.rst             |  2 +-
>   5 files changed, 52 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..c80529a62b97
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3399-roc-pc-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index a85e9549c83e..e7e4a2c89072 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -12,6 +12,14 @@
>   	};
>   };
>   
> +&i2c7 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c7_xfer {
> +	bootph-pre-ram;
> +};
> +
>   &gpio4 {
>   	bootph-pre-ram;
>   };
> diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> index 6937a27176f9..60a3ba43cdbd 100644
> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -5,14 +5,24 @@
>   
>   #include <dm.h>
>   #include <env.h>
> +#include <fdtdec.h>
> +#include <i2c.h>
> +#include <image.h>
>   #include <log.h>
>   #include <spl_gpio.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   
>   #include <asm/arch-rockchip/cru.h>
>   #include <asm/arch-rockchip/gpio.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   
> +#define ROC_PC_MP8859_BUS	"i2c@ff160000"
> +#define ROC_PC_MP8859_ADDR	0x66
> +#define ROC_PC_PLUS_FDTFILE	"rockchip/rk3399-roc-pc-plus.dtb"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
>   #ifdef CONFIG_XPL_BUILD
>   
>   #define PMUGRF_BASE	0xff320000
> @@ -54,4 +64,31 @@ void led_setup(void)
>   	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
>   }
>   
> +static bool is_roc_pc_plus(void)
> +{
> +	struct udevice *bus, *dev;
> +
> +	if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
> +		return false;
> +
> +	return dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	if (is_roc_pc_plus())
> +		return strcmp(name, ROC_PC_PLUS_FDTFILE);
> +
> +	return strcmp(name, CONFIG_DEFAULT_FDT_FILE);
> +}
> +
>   #endif
> +
> +int rk_board_late_init(void)
> +{
> +	if (!fdt_node_check_compatible(gd->fdt_blob, 0,
> +				       "firefly,roc-rk3399-pc-plus"))
> +		env_set("fdtfile", ROC_PC_PLUS_FDTFILE);

include/configs/rk3399_common.h sets fdtfile to CONFIG_DEFAULT_FDT_FILE 
(which is rockchip/rk3399-roc-pc.dtb for 
configs/roc-pc-rk3399_defconfig) by default so *not* setting it for the 
roc-rk3399-pc case means it'll use the default. We just hope someone 
doesn't save the environment on e.g. an SD card when having booted from 
a ROC-RK3399-PC-Plus and then insert it in a ROC-RK3399-PC... so maybe 
really set fdtfile for the roc-rk3399-pc case. What do you think?

Looks good to me otherwise, thanks!
Quentin
