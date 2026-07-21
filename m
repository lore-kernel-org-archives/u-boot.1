Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E74C4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E21780F11;
	Tue, 21 Jul 2026 12:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UO7oQr1FsZ1C; Tue, 21 Jul 2026 12:57:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F8F380F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784638656;
	bh=4bvNHMA1OktCHwnSCHbtaWiKloeOR2izE0HidJXnOK0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uk/j3eiq6+5PrSyHvLvfiIep11mn1Uq5g1C46HgITDvXCRxZWgR5W2e4YnyoJPQoX
	 nolqCsfdONxcFhB6S4ewIKyi2AY4emHY81IGY1ek/jW49PauSaNjo+CQq1wBNSz5XB
	 w3qJMFL0IDcJ+sgVQo1opy2SgzdnljakDcKblAaAJFlD9tNJYSRz1t+tvlerhfx4yP
	 1LH1oB0Dzoe0L+e9xoYqfKeDQMp2sdIKzDfsBYf/BCbR25erX7YnUxg98RnnGTxtxm
	 r05NMHSPGPWXowNAjkIZDF5NRk03usxAUZq1IRE8vRyZ8ZbSNyCUbK5Asw9ds/XVgF
	 nDDma8elnbXhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8F380F0E;
	Tue, 21 Jul 2026 12:57:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F1EE109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60A5C60843
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Okr57g80QVB for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:57:34 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7901460842
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7901460842
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7901460842
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:57:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB56E84659; Tue, 21 Jul 2026 14:57:32 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E886C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:57:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AG36JPn/kIRjCY46NX7AIRMsZGUKgEuFShp7ULw85RZFvrVcHdcNEFsH8+kiRk9iiUrZh6Ye+Q+S3Xeyzs3kTn1Tpv5rgAUYI7ZlKLskLWPV0zVcJQbY18jYCuW8IQamaOy0X5yAcLpMeS0VZae90mSXsNekPL5t23au296FoJ8P2YSepRie//1wEes0YXOFVVK0rEslvwjWupuS9nRCvwzKWOqzi2UHgI+VkBXLAnXUONwGWQ0/YEhhJINA0Z7NfwjboLsE12+grvCd9mc9Om2skiTjFiwHgXb2Xd1pWyKSUlD6etnteHtmhKA5NMZIPptp96MNNPasSNlQiBRU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bvNHMA1OktCHwnSCHbtaWiKloeOR2izE0HidJXnOK0=;
 b=FiFbnAR4DLy2KOdqL6grHu4axo6nxgRLuyjibWawgYSTnzeR15O6hPUe030ZWRJRnnlhrQ+lM0eWQI7eJzJkzkYrGWJ3BTrgxnnPoubu8O0XX2jZjCKhrn9TqYk2+sqxMtuF0bGf2dUqPKraAxJ7OT0rfQs95aTwci7NpTSIHymVuwvKE2CC6CZ+mVKKAti1mJfsdnu/w1M3hrRmyz3qKGZTIWEfFus1HGJEhKEN41TMNkEeWH/q7jdlr62LjjrVePRl/irlm7s8rrkSj4OUvqzzUybwF/9NLWNUZz24nvzdLtgAaaZZXEvQGZk1Cd3jqazjgqLtD/30lAY4QrKu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB9804.eurprd04.prod.outlook.com (2603:10a6:150:114::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:57:26 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 12:57:26 +0000
Message-ID: <487ef2e8-49e5-4395-9ede-4e8750fd078b@cherry.de>
Date: Tue, 21 Jul 2026 14:57:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-2-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
In-Reply-To: <20260713-rk3588-fracpll-v1-2-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0031.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 26283be4-cfcf-4172-66b5-08dee7279d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: RMQP7zULklLH4KLdkvOtjzJB8CSbfvKNH9LRcoptG/nUIUwcOgblpmNlUAyhQ7jyF3+aODgcPV2IG8IeCyrDuNmmBFwDSIKQTAz2xRwteZQOfqJafrFxb8yslnE03WY/Tsn0uNQInVavmU4E7y4haNIiVLhjtQHjshXYzcTPO09s3+F2f4J4lT0qvEHWdYAQssq/+gHq9Sa/I2J7p6NJCTFq0/7rVRnKatlzOmAOZ123/FJfn5VxfJqMGCEG+SPsdsRMlALamOPT11FRtv7PRCIehLdLoKjqCbwJCjgU+7LFhYrFUFI/C4yIiCMjskDLIlmXgVOfAuNVVBXG7lCXI3UBcZ16hl0j5IFJ1V47H5ebzI4r45+tKDVgy1uHfPY8BuZKmHQqzdAUkXGzcFm8qxGhpPA9KfWFahdBirRT+XTVtbLQS2o+DZJy1aLst0eCeKwMb15YR9Brk4TnJ0mhncihnKAu6Yr4azecTJb705HiKSIuhMoqwXfPYh4QLfveqyxHq57OG+6rdIQT64NvNAYlx+0nPLDSVHqetLcEJ2rtPkhmhsgRALlufdGQBrNNNn4y++HK202QBKrBIShaR526gMlMBuaS0Kj+TsTlavAOV8XjSURjekQogBMbqsNImofzxlE9/8oSBoXP8PTrbdchMksuJ0lu9WPINOM6abU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29MRGRYQW5IUGJOalNsUXZoVkdqU1MzQThIYjIzZEp6U2lJaXNidXhZV3J6?=
 =?utf-8?B?cFBnd0lJb3liRFdUL0RXWXJ1cHFqWWFjWDVMb2xxYzBPUnBKUk14VFkzV2VX?=
 =?utf-8?B?YUhkbTlKTURzcUphWnZSQ25sOStaVEhvOFlDTHc5Z080MXUyYndRQUVGU2F1?=
 =?utf-8?B?NnlrNHJnM21hcDB4U2xpV29VWkxwanBaUXdoN3pwRHZicGhnREM2ak5rbXNh?=
 =?utf-8?B?aEJyTjdXL05uRk4xdlRSRlNqS2NtR0ZxU3ZzY2Y5ZXFvMHhlbDQrenRrdTR2?=
 =?utf-8?B?NnNINXRmeXQvdG5XaTJKYng2RXdtRXdGTkg2Z0NKdHlHTk5aN2lXOUtGRStU?=
 =?utf-8?B?eEJ1bXNBZW5jR2NoazY3ZTRzTlM5THhQdGpiUlFyaFI2UEJyampZbkFxSjlo?=
 =?utf-8?B?TGZZNWVWMW52V0lGMzZyd2Z2d015SkFVYnVUODl1RmpYUWptU0hxWGNUSjdk?=
 =?utf-8?B?VUZrSnlOdERHbzU4WUZWaUhneGNlbWRkSktOYXhLbzg2UWh5VE9sdkhZTXdT?=
 =?utf-8?B?bWNCc2pXOXVzN0tNVXJmekdLVEFISHFHNXBTWDd5dDRpd2k3OVROREFidGNq?=
 =?utf-8?B?Zllqc293dzdiWmxrZE1GMWNBcEhmOXUweXpBWjNYTE02TWJGRUErMGlUUDZD?=
 =?utf-8?B?a0Z0YllYM29LYnNpUTBCa1ZrVzkvOUY1b0dzb1Z6RG5DK0RuMG1DSXRGNzlt?=
 =?utf-8?B?Nmo1TXBZU1MvMnM2YmpvR1hoWTlQcGRqL3RZSXBLVU9Bd2ZTNHdlWGEvZURQ?=
 =?utf-8?B?YlM2QTNWd09XeGxuRTYzNjZhZFQ4bUxoVGNHM3N2ZWh1cmNKM09OeTNySnJh?=
 =?utf-8?B?eUdiVlFpdFAxZlJCcE5sVStkN0Y0WHFtTjlhZkd6L0ZOdkUycmg5azZZOGNB?=
 =?utf-8?B?M2thclE1K0dQN1ovTTZVZkhpTDYzVVRuZVI2b1BCK3MzMDZ6WWR3aGJpcXNZ?=
 =?utf-8?B?SWZrbnh0b2RacjVnUVZKMXdvdnRXci9ub1RIRGlVYmFuODcxQ0ZNMHRPS21q?=
 =?utf-8?B?RW11NzBCckYrTDZEa2EyUlY5K3hjMUJINE9NWlg5RFkwMHp5ZWpjQXhCQzlk?=
 =?utf-8?B?SlphVHFhLzJlaXF2aGxUaEkrR2VQVDNJSmN3dFVPeFNyRmxKVDdIeWtQV2JT?=
 =?utf-8?B?TFZhRGk2VWR3cXNOdmNYb1ZTVzlFdFlZNVpQdkdpTGQ1NGpSY0pLZmNXQXhW?=
 =?utf-8?B?TXRxaWoyQ0p2VGhOVFo4SU5KdDdqaVNjaWszU2wyV052UlFmR3R3VTY1M1ZJ?=
 =?utf-8?B?Nng3a0tDdG95UTBFc3ZnS2E4WDFXUng3L2ZleVphakNSTnp3YWwzcGRrS2Rm?=
 =?utf-8?B?ZzIrUXBsYkdzdWRjejI2VlN2aTgxZmhScHJqWkN4RXFkY1N5dENXWTZVTnMx?=
 =?utf-8?B?VlVxbXduSmN2OVJwc1VFbkdGK3o5NklyWXZjZHQzYnBQRmx2SDluVHZSRXpj?=
 =?utf-8?B?NldjT3RxUXJUUWdhUDlIcUNZR2xhY1A0TjJMQTZJckhEanZaTVNZWXJwcHJq?=
 =?utf-8?B?OFVjSzg5aWhBbURISmhiMURBVFU3cjQxS3haT3dlbUt6R1cxN3ZISEhXWDRl?=
 =?utf-8?B?alVPSFozcnI2WCsvTEU4NkFQRDZWUnFES1I5UDdSMjB4RmJzUEc2ck5tR245?=
 =?utf-8?B?bk05dUZabGFCQVAyY0o1bHk2dWxXYVh6ZmhVaUp3MW9sZTZWVnpYNStBblFs?=
 =?utf-8?B?VHJQMS9SQUZVQzRueEVnSmtiY21JN094U2FPWWVCUUc0VllPcllUdFVzTGN4?=
 =?utf-8?B?SWV2OGR0cDUzVHhKTEgvL2NheDh4WkdZL3Zua3dvWnNBanJCNW5jbGp0Vld4?=
 =?utf-8?B?OVI0S2dUc1FQUisrbTBTT1pkZHlJa3pvOEFpUVY2aWJRdmZPNG8yNUlmejIz?=
 =?utf-8?B?a1dlKzkyWGxVaDFuVlBicDM0OXpGcG1FZ2RuWXhQZWFqSlk5UDU4dElUWk9s?=
 =?utf-8?B?REg0cUp6ZlJLNjFxaHJoY1VqNXNvY2tMN3hkRmpkNnFDMDNkcmZ2Z01mU2xN?=
 =?utf-8?B?QmliYVE5bU95OHJjWEtnYXd0SDh5N0NmRWpLelFNdkZ3aGdEenhSZi8wR1Y1?=
 =?utf-8?B?emxQcU1tM0JuUHBQdU9DQmt6VXY1NFlvRitNWi9tdFRKMUM3dlVLWEhVM3NM?=
 =?utf-8?B?YjNHOFJQc1lldWlZVmFtc2c5N2dSZWNwNEdoa1lIT2ZMNHBvT3I1RVd2SXU0?=
 =?utf-8?B?dFhNUzM3TE1abHNGWSthMjhnRHFtV1dFSU84RXhkTTZ2bUJWeW9VZ05iNUpq?=
 =?utf-8?B?SlFpSUhFaDdWRHNEY3h5SURHN0hqMUR4TDVackJWWnhSbUFxV291OVNCNmNB?=
 =?utf-8?B?a3hDcFJNRlNLRUhsRFgrMnF3aXpMTFpJZDlJTi9lUUIrZjVlSkpjdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26283be4-cfcf-4172-66b5-08dee7279d59
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:57:26.4178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMaT9QVT9W1W/WHFLaVaxEFM+v9O/1TsFR0SXeZPl7a9ZWOnmrmo4DKlXL5Ia0gQK6dBl/M3XDq/Ar6PRiI1H1FelfWytpYJSO0FkMYeKdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bvNHMA1OktCHwnSCHbtaWiKloeOR2izE0HidJXnOK0=;
 b=VZR/q7mCfA+7uP8jsTBwUl8xuNpDlMFLqWBRObVlKwlTO7O58x8VzNj4HTtjq7gSTurwnb+NLUgJw2EORib6Peq5aDCoB8YaxFq9if/70NvsHbsrr5oKxMBhmOI0JlJqJ9q+81sJyAT9f5mFkHWVB8rudZGuLFtAIe2u9Hl1WKc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=VZR/q7mC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="VZR/q7mC"; 
 dkim-atps=neutral
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

Hi Alexey,

Resending so it hits the ML because I once again triggered the spam 
filter by using the "wrong" mail address.

On 7/13/26 8:35 PM, Alexey Charkov wrote:
 > Current code uses magical constants when rounding up the magnitude of
 > negative fractional PLL component k. This leads to overshooting the
 > requested rate when the calculated fractional part has less than 0.3 in
 > its decimal part due to failure to round up the fractional part.
 >

The choice of magic numbers sure is odd.

 > Use a proper rounding up function to avoid overshooting the requested
 > rate and make the calculation more readable.
 >

Just for posterity, ffrac is guaranteed to not underflow in the if 
condition because the caller of rockchip_rk3588_pll_k_get() actually 
check that fvco < ffrac (computed with m+1).

ffrac * 65536 won't overflow because ffrac can be roughly max 1024 * 
fin_hz, so fin_hz needs to be U64_MAX / 1024 / 65536 which is 256GHz.

Therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

 > Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll 
calculation")
 > Signed-off-by: Alexey Charkov <alchark@flipper.net>
 > ---
 >   drivers/clk/rockchip/clk_pll.c | 6 +++++-
 >   1 file changed, 5 insertions(+), 1 deletion(-)
 >
 > diff --git a/drivers/clk/rockchip/clk_pll.c 
b/drivers/clk/rockchip/clk_pll.c
 > index d0df3b8fb49d..69d2d182dcb5 100644
 > --- a/drivers/clk/rockchip/clk_pll.c
 > +++ b/drivers/clk/rockchip/clk_pll.c
 > @@ -11,6 +11,7 @@
 >   #include <asm/arch-rockchip/hardware.h>
 >   #include <div64.h>
 >   #include <linux/delay.h>
 > +#include <linux/math64.h>
 >     static struct rockchip_pll_rate_table rockchip_auto_table;
 >   @@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, 
u64 fin_hz, u64 fvco)
 >       k = ffrac * 65536 / fref;
 >       if (k > 32767) {
 >           ffrac = ((m + 1) * fref) - fvco;
 > -        k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
 > +        /*
 > +         * Round up to avoid overshooting requested rate for negative k
 > +         */
 > +        k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 >           if (k > 32767)
 >               k = 0;
 >           else
 >
