Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE7CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DDE831BE;
	Wed, 27 Aug 2025 09:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="rAcW4lM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9423831C5; Wed, 27 Aug 2025 09:37:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A3E8319C
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+33neYn9ouMMeZz8lXw6l5xeSDAHwHgXTHqBJyg1qEq75ETN3MJhsELNKdiBRHEvDI+KUQbxPrvaamMX4oNWndT1ajE6VaJcCaju3jLRwawzxSfKRPARN0fD/PqG1sPy3fg70AyKS96mX++TrKi5GQeamHJxmp5eyLx5X1PzcbpZ6tCyQK+7PWs8qCI8n+K23srM8aPD05GYUy0KnRZuH7R5SRyWQVOrfVESL7WyeyRBru5uZ+iYhHKcB3vQdKtOt0FGmkMZVufWb4LwL/tt1sfto/zs9Oo0mrnwsoBTLNC8A5jZu3HJF1EERo5OMEAYDWizUB80eSDu8Fz+c4JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLTvunVwbu+741mPk0PsPYbv0N6bHhIh9jyH3QhxS9Q=;
 b=J/EHxV7V7CLLAEsgPgm8ZX+CBq0jLVippX2QiGXXcLpGRsx7jfDytPG4OvYUq9jyqLB6FalaHL2qlZw/YXvdEt+ESe5E9IBAYA7+7pcc5X5p9JBIQSHHdTg7EIdg2Vab4h/a04+5V4R0fB+3EPQxdHGa+LYOu7iT2pCBuKgIy/2k/fEzluz/PpFe0fBt93sfnjJnCiT/NyakgoVcVndILSWw+NgbSUZMIwUmLk6OdPXxrivPwvu2Hg3QSVEXNoVSkLFFmC7lNpeWCXBCsrAFtmsTzNs4VWjpGJl/iSnkQdB2vZSt/zhmjV580b4RdCeO/8x+O14R0Sgkz/IIBfw36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLTvunVwbu+741mPk0PsPYbv0N6bHhIh9jyH3QhxS9Q=;
 b=rAcW4lM1XUf6N4bsI7na4p0C9ymuNsbd/YtUg7cG8bW260F3zBe71KFZA7H6jwvkRiAGKIw0ISjn7MbE2xfRpO6kKW//ieB8uh5U61jrMArLve3tGDakhgQmR/6kB6kRPfcliHFWy8rKPYHX6npEkd+UCJfa0Be5AVcVbMNdV7GiPO2QUesSfwAgomJjp45VrpTNIgvtG12oKup3IroMN+BCotPx4JSuTJS/cdYj0HO7m2+5IAKkHCR0faJ8DaTpq/c51qxBbKN2N2VbC0BG3mzm3k3Dd5yWiHIe2JXyAPTulmvLDf3ZtrQW9mSo4+bmgPkJ5FPPRlZKS9CANHocbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB5605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 27 Aug
 2025 07:37:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:37:26 +0000
Message-ID: <ffe365e5-2d0f-415e-a084-1926e3d4b2a8@kontron.de>
Date: Wed, 27 Aug 2025 09:37:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Joy Zou <joy.zou@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Frieder Schrempf <frieder@fris.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
References: <20250811131213.211124-1-frieder@fris.de>
 <42ae44e8-b368-44a9-a828-578c77d4d15c@kontron.de>
 <PAXPR04MB84595561F74B01EEA36C020C8838A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <PAXPR04MB84595561F74B01EEA36C020C8838A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: b88b93a7-b3df-407f-e9bd-08dde53c91d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJKaVlhU1krRytGd3hLYmE0bkdRdkRsbFlnbkhDUVdvLytORHJpSFRGcHNX?=
 =?utf-8?B?eVZncU1BdlJvTW5HS0ZSd0N0Wi85VHcyS3RhRXZ4bS9rRnZRcWpqbXk5bzBJ?=
 =?utf-8?B?bXFDTTdxQ0U5QUNQMHdQdC90TzhNT3l5VXdpbk96d3pQNmg3dXY2VE1rN1Fj?=
 =?utf-8?B?dDdnSitUbTMySFN6K2tPTUYxTFFaVlFJWGlqK1RKZ0lxckJMQnAzeXVXN29j?=
 =?utf-8?B?UndNcVRpdDVGNktTMDUyb2JZckpzcTJidjhLOHladHE3ZEphRElFMXlzdGFM?=
 =?utf-8?B?ZHFZSE8zYWJBeGhYUGlzTEZhYzdFOEhucEJETlEyWVEzcXdXTGszbTY4Nmt2?=
 =?utf-8?B?NTlFT1BpMUJLRWs4REFmYkxQOTJ2OEpvRzBxNE40NVlrNU5uNHFFTmZzdU9L?=
 =?utf-8?B?Ny9jcUtnQWJGKzlRQ3Vrak9FMFlNUm45V2ZpN081R0MxNmc3cEVaQnU5NmNs?=
 =?utf-8?B?bmZ4VFpqZW1IKzhlMHlQYmptdE5tQk41by9aN2RoN2JDZjF6WDNqQWVNejN3?=
 =?utf-8?B?RzhUbEsxN1dhNWpkK3pwSFpxVmRYVk4xOG9aTW5yS3FIdDNhQzhjUWUwSnZh?=
 =?utf-8?B?ZUZXeC9xWDRjQXg2SlZ2cEdwempHYlk0dW9lZXNNajlkMjIva2hPNitCZzBQ?=
 =?utf-8?B?QlR3WmNucVVrTlUvNHJDYU1MU2w1MFh6TXdTR29sdXhmVDd6djh5b2swRCtC?=
 =?utf-8?B?VjRFK1dQU29zMDRTbTU5S2wrbTY3UWFRQ1hjOXlEalN5NE8ydEVkSjRSQnU0?=
 =?utf-8?B?aVk1K0hzaW5VN1E2NjZxY0tLMWw3N2lIM0hiK29VRXdNNG5hbndJVVo3WWlX?=
 =?utf-8?B?bHVTQjNGcjNsamNoTEVFTFNneXFWTFdnK2tqR3NoVi9qdVN5aXhMR2lkd0sx?=
 =?utf-8?B?bVp1MkMzdHMrd0xYSWFEZVZyT3dPdy9iWVY0RFV1SG9rMHBIYzE3YmVxbnRP?=
 =?utf-8?B?OWhoMWZOSUlMdzNCc1NQdFZxcmpKSWlFV3VsdWJsQXVmZTV1cndPTWxnMnZa?=
 =?utf-8?B?OE53Ny80Zm1vUVRnZmpjeTI2NDZjbTgyNWQ0RVFlQnZvWG5EWmRjME5ZVHZO?=
 =?utf-8?B?VHdMeW5aVG9heWhFMFBIMVZQMU9wN1lmWTQzYUpTeDI4Vm9kOG1oVVVlalpk?=
 =?utf-8?B?MDZBRXZrL1pVelhuVXlSakU1Rk5WMmZZRDhsTHp2VXYreEN4RDRpNmxzM1hn?=
 =?utf-8?B?NDQ5Y3FyY0dtSm45SzBwZ2ZsNUU1cnhSMEI1dHU0OFowMTc4L21BY1NzYXEy?=
 =?utf-8?B?T25xOTlvMEpZQ0V0MnA1ZWlxWmM3K21ReUNXcDV1ZjBlRmc5RWNzN2RRTHln?=
 =?utf-8?B?cldFVkthVzFySlUrSC9xOUlNQkllaXRZRjFWdWR2eEFrbjljdzMwM2lMNElX?=
 =?utf-8?B?TGpFV2NncmlQUzR4dTJIRmRsRFp1cjVLUVBrWWF4VkQwZENxNGNPUTVIYWZE?=
 =?utf-8?B?SnZPdlNZOFQwQ0NsaU9hY0hUalBkQXp2aEpOYzJmeW5rbDZqZ0VDYlZ2QzVZ?=
 =?utf-8?B?ZVUrb2xpZE9zZURnZXNvK29nTW5ZclFOMUY0dHVVYzRNWmFhZkxmbkJubVJp?=
 =?utf-8?B?WWMyQkdXV0dHYm11aWlMWW5UZUxCKzcvL3A1RE9YTmUyYkZsdk5FeEMwUStl?=
 =?utf-8?B?elVoaVlvRlpndDlRd0dmeWM2T3hxdG1kQ1Y3V1JYYkRjOUx5dUI2d3FXd3JW?=
 =?utf-8?B?WHdJMkV2K2h4NjdaOXlwYU5ITC93bGhTcEFCb2dHbEpQREozYzJlUUVPSHRl?=
 =?utf-8?B?czdIenczdGZvMmtTK0VwTVBoQUN4bG91dE1xYXllUWlsdTlCWjFDK1lXVWhr?=
 =?utf-8?Q?ZHS9Vs7Xucj32TYu7Bhuzx79VjU3B51Smk72g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlR3M29NWUJjMWtndys2aTRsdlNQNW9mU0MrSXlTWngyUDFCY2lXYkhtWGdH?=
 =?utf-8?B?WkRsQndCMWRPb2pUTGtsL3lnOGM0ais3NWpPdlN3VVZBWStsVWswSlp5SHBx?=
 =?utf-8?B?a1lhbUFyUnlGWWR1QWxLZkRwWU1PZnYyQmtBUkxKSHZ4aGIxYkpWNS9STXIz?=
 =?utf-8?B?aFRYVithaUM1ZmpXNTNML2owZmlLV2IvYktTc0w4UHUrNU9uQUpaZXZqWXBm?=
 =?utf-8?B?OE8vMGQ3YTNhWVZlZTlkRFVFQ1hlbjRnckxLZ0VKeGJycklZYWVDZHRING9B?=
 =?utf-8?B?dTgydmJPOFk2ZU9iZEpEZzRDdjJXb0txaGRKeFZZRXc3NDdOWTVOYWNwOXkx?=
 =?utf-8?B?QnQ4S2FwUW9jQ2NITzNWU2tQeWRuc1F5d1JMTnpzYkQ5NDVWRk1NNlFPWWFB?=
 =?utf-8?B?c01PWWVuZUFuUkcyNjZqaTFWcDUxS2ZidGZQYllralFlSFVyaEZwTGdmdWtW?=
 =?utf-8?B?Nm10OGVaOS9pbE1hRmxLa1g4U0R2NE1TeDVXN2V6a3JWMm5WQm1rZEI2alBv?=
 =?utf-8?B?cHdXWHd4TjBBOTNCL0pya1NwVGQrUytIenVNbDBnUXBmN09FSW5CQlZIVkN2?=
 =?utf-8?B?bDRteGcyUHgwY3Jmbjh1RmNuOExaYlYzRVlBQW1nb0dlZmxBbE1ybGFlUUxN?=
 =?utf-8?B?ek5CckhsYmswek1mNGNqR0FWYXpiRFhGbG5yZW0xUUE2V1dzTy9SV2IydDJr?=
 =?utf-8?B?SExtZEFGckNOMFpVS3FnbUd6UERSOEo2SXpIR1ZITDJPdGFxUTkxV3BpeVds?=
 =?utf-8?B?YjFadmo3Rm9iTWpJYmY2VE1tSGpQUlFGMUtTTXN6SndiTGFTRktZOUk2b3Ri?=
 =?utf-8?B?TDhVYUdUUVpaQTNnM3FtNlF1cUNER2VQSE9RaHNKQmxmaDNzeUx4TEdOSEZI?=
 =?utf-8?B?NkxTL2ZPU1BSQnRVVUNLVDRCQUpmTHU2N2VkYkVwbUtCUE1ZR0NKU3VGVFVa?=
 =?utf-8?B?ZEF4TktmU20wSVdxcG82RG82QzUvcUFUZENXYkRMU3g3NmlpbzhmekFoTllr?=
 =?utf-8?B?eE04Z2tMS0dxQnU5eGY0enFLS1FFNXJHQ1JLd2RFd0RmY1EybHh3SGdpN0pB?=
 =?utf-8?B?SERKa3JqdXM2c3RPTllZSXJPYmZ6NWFTc1FWUnM3dUtVT0syMjJPZnlPYjlX?=
 =?utf-8?B?U2xUQitKMzAvL1hEMk1UQkFtcnYxUUlGV2Jzd2VLWkVKR0FCUFprV2piY05N?=
 =?utf-8?B?a0JLdnBUMHYxU1JRemJJT3hLUXY0RHpiNWlsajlTTFFMUi83ekRwMmo3UXJo?=
 =?utf-8?B?d3kvaEhqMFNEUkkrRmF1ZTQzc1Q5RFpEaGM2N2ZhK28rRjB1anc0SmFrUTNX?=
 =?utf-8?B?N1NOZURmM1pnSHBiT09tNGV2UXA1aW1qKzh3RE5WUEdHMTNTR1RlRnkyWkJB?=
 =?utf-8?B?YWV2bytvelBrY3pJUE1LT0pWYjZ2WERKNG50TWpnb3pyT0FiMGVWTy9MeE1y?=
 =?utf-8?B?K0loOVN6dzE5UDJQOVY1T0RyUzVaaHFWTXlaTm1MNjNBbW1Pb01ET1hMNlRU?=
 =?utf-8?B?SEM3Umx6ZEI0dGpIaHVqTDR1YU53by9PK2twWm9kM0xqNjZ6ZEoxR08zQXZU?=
 =?utf-8?B?aElNYS9mMnBnVlpwblk4OHdUSGpzVjJqbWlKYW1xVnliOFFWc0QxZFl3cktJ?=
 =?utf-8?B?MU5qWFMxeG9OWEd0OEMxYmZLbzBMcUZnWTZPUFFOZ2tGcDhWRTJRby9TYUtE?=
 =?utf-8?B?bzRydHNqNk9aN0R4ZmZQSEpOU2VmVlMrWWJNUUFqSUw3MzNkanhvdnpDOE5u?=
 =?utf-8?B?ZGNyb1Njc1lPNWNDT3dPdXVKdU1SenZXMmg3cHVwOE5ZSCtKcUlJS3M0NkJD?=
 =?utf-8?B?Q1NlcWJvd1c1Tys1cHA0VWw4Qk1ZVXkzejUvTjZqU0UwRGRzR3EwSkYrSng4?=
 =?utf-8?B?TjNkYTdQTXJwcVNzM3Q2cTZtU2NZdEJ2ZGUzdmIzQW9qOFJHT1IyaTlkeGVH?=
 =?utf-8?B?aFJjVjZiUjc0MWpCOHJDZ0hVLzZUZHllU01KbjVGUWl5ZW1qMGpuTkdKVnlp?=
 =?utf-8?B?ZlluakhIdXhHcEE0cFBCcklaU1JYY08zcFVPV1hIZ2hub0V4b0E5QWVGbVJy?=
 =?utf-8?B?OVEyYWxFb0ZpVHNnZ2FtQWErMXdROW9wM1RVdGpPd0dMQVFNR2FVVXJzWWwx?=
 =?utf-8?B?aUdkREVGem9hUmFwaitHTTRSME9VQ1dSaERiclJDYVYzNVZjZytKLzUwbjcw?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b88b93a7-b3df-407f-e9bd-08dde53c91d1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:37:26.6012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTnNDg+jF6svSjlbw91VdbRKpItIBbDNJ6dStModdb8om0JTcdFdTqQm77K0xtTRsDfhHIHnmcrx7e/lJalnbHJWxGynTVY7nGnze7rcn0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5605
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

Am 27.08.25 um 07:46 schrieb Peng Fan:
>> Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for
>> PCA9450
>>
>> Hi Jaehoon,
>>
>> Am 11.08.25 um 15:11 schrieb Frieder Schrempf:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> This is a port for the following series in Linux, which is already
>>> available in mainline:
>>>
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> patc
>>> hwork.kernel.org%2Fproject%2Flinux-arm-
>> kernel%2Fcover%2F20241218152842
>>> .97483-1-
>> frieder%40fris.de%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C51
>> 6d
>>>
>> 65c0706c4d71292d08dde3b31d9d%7C686ea1d3bc2b4c6fa92cd99c5c
>> 301635%7C0%7C
>>>
>> 0%7C638917080648452454%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
>> 0eU1hcGkiOnRydWU
>>>
>> sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
>> 3D%3D%
>>>
>> 7C0%7C%7C%7C&sdata=neJx6WZU4iZWjSUcsnzOVQvFiaCTKLChE8srEx
>> 6cwEQ%3D&rese
>>> rved=0
>>>
>>> This aligns the PMIC driver with current Linux and allows to use
>>> upstream devicetrees in U-Boot.
>>>
>>> Frieder Schrempf (6):
>>>   Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
>>>   pmic: pca9450: Fix enable register for LDO5
>>>   pmic: pca9450: Fix control register for LDO5
>>>   pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
>>>   arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-
>> vsel-gpios
>>>   arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
>>>
>>>  arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |  1 -
>>>  arch/arm/dts/imx8mp-dhcom-som.dtsi         |  1 -
>>>  drivers/power/pmic/pca9450.c               | 22 -------------
>>>  drivers/power/regulator/pca9450.c          | 37
>> ++++++++++++++++++++--
>>>  4 files changed, 34 insertions(+), 27 deletions(-)
>>>
>>
>> I saw that there are several patches on the mailing list for
>> /drivers/power that have received no reply from a maintainer for
>> several weeks (see [1]). I just wanted to make sure that you are aware
>> of this and kindly ask to have a look.
> 
> I could help handle that via mmc tree, if Tom and you are ok.

I don't mind. If Tom agrees to take power patches through the mmc tree
from you that's fine.

