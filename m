Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE47C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E7340821;
	Thu, 23 Jul 2026 09:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiAtdmiE3bKZ; Thu, 23 Jul 2026 09:23:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81145407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784798608;
	bh=i7lkWMIjkSRwgPogly8nOXlLdkPem++pZPNFITjWeIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GbqcchSkr1bTgqg8QF8WI65TtRh2k5snocEZQQlalCzXimvKfdLwPsrFfuXwsDOj+
	 zePArHvdf4C2ZE6sl0S47WTJJkm6fZo9sz/J9T56WcH1x9qNBp907ETJ2+G9rpgXX5
	 UbxYWgK4caftue8xGxJBuT0qpT72TDE6GBPVlrtv3WHVC9vRZP8M7m9U6YJxp1vppO
	 dwVGXh0v8Md/aliggimo/KDZHBCQ87RPndm0m0SCuvtH9HvHC6QemzHiGBK7cGrFcG
	 cI4J25IU8vXeVOF7i4KPM5Y6pimzi6w1s9zu45Z/7FJskMq/R3SXdMrFYBGWp74yT+
	 ehussd9SAPMTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81145407FF;
	Thu, 23 Jul 2026 09:23:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80ECD347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66BE060768
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:23:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIPfPeCXmcJ8 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:23:26 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 014646075B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 014646075B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 014646075B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:23:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7F18404D; Thu, 23 Jul 2026 11:23:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE05B803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 11:23:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZOCxYkjf/e6PQcvRqGwnbTGETJAayxGKhttKSAbOnaEbPihECI30Mx6aNZMMQ9kfhBk28QgCMRf7migNZzOAZUyZ36GVWqs45piOY1Rom/Ap8nna0vDjAvyn3UTMI9Fxh+n3lC0Io554b2UZ1x1MMGyNcthMhzCy2giaafc8Z6mcOUpC48qS07hRfrTQG40WySnDH1t5QWRzrNNauL9Bvo3VX4XAMuuBiM/kNxmRE2hBtKkaBQ+6S8CEdI5pXe9fRycyXrj7YpGIxe3FgoOGnWz7sP+3axKQfnGmSrDhi8sDtfCKykK+aUy10KhL2tcjid8ysmWu4BXpKx2KRsztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7lkWMIjkSRwgPogly8nOXlLdkPem++pZPNFITjWeIg=;
 b=kGXbUd4CgY3LCJaSgKs4JA5bhqjAeTh4UXG8MoTY4sNy+6/xTtRFJoWBGZoZ+wnVzHDi1mQYU8WwfN91X/Hw/kPWVt/8tRSqr+QsdplXGvFs1N89YnKfHCk8xNH1GQyKRWYCVFi7F6hwXm+S2KJR8CGduvhcaCks0md98Uc5JMvUH+UikkyRflo4EXd9df71e7IJ8hVBSI8SDv3rFJUXX+3a6mWI9e4gbvAofhjjGNSYW0EtoRT9bKqN3Ban90dcDazUGJdEOKFWRU5Kggvy/iev/vv7j95DyCVW29Or2l04rtupogcGanc1RGnVxor3rZ9MlZI710Fko4UFOo7hwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 09:23:19 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:23:18 +0000
Message-ID: <88436f3c-079d-40b9-99f4-791ee3adb192@cherry.de>
Date: Thu, 23 Jul 2026 11:23:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d404db9-8549-4212-c11f-08dee89c07f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ZDp0Hl2Ps4I6RUZUwG2ae8Al3jAwbSUzhAfDPS+i6ObspS3pw4eUsOFjTMRkmK+zcGEhGtLlGfoC5rpJNOjJ36pEoKQkxUo9G03872h6V8yE7jOQ31zIMFVE8GJnkrAMMJWofKkiUZf4rNPFC36urinXEPWOtgCtlh7bkuE9CwscsRx43cbCPmfzSKOQkgVwncsCJekzyjNjAuaqMNyJCsbQCctn1GZFMti69PyYlxLZUsqMmdG4/hmRYpoON8wEWal+BOhwcb57sGPHQoqZcyTglN2FTC64hPNv6Vxl27wKgWKi8sfwodfK1EGtPJzGXjp+nD5Ak6WS24DvQsRbwqYclq4gpPJ+SvinpCwee2OrpPLRwhazpTbCyclw+ca6aalKisHyuqsjkGc4JENMuXEE/osL05BuotGeyG2ERMdFzSGRvQ1GYYvg8snH/F0k5hZlyatZj2/YlIfDEsM6q8/PkBKFJMu5AE1fTjGeB7emWrSSgpCW+xOON9SlgH3kIlxxIUnlrsnpiVZokkYxZWCA2JcD4B0+mD/lBMi3ru9U9VW0Uz5zeHerAcCATWZfjeC81+OTh0Pxi0f+ADxLjaGhQwAgtKKqLb4l3qDLgrjd9+LP6CkAoum442HLMUdpdutGKSXz26Cg43XXzdfkPznCr2rXjkXX+AHB7bQgmOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUEzT2pkK0Y0ajJHWURUS2s1bTc1ZDEwYzE1cjZ4RWJrbllMU0V3bkJvTndo?=
 =?utf-8?B?ajdpSTZaTW50amVTencweWtBbHo0d0tJa0hwNHZLOS9XK3h0QXp0VytqK1BT?=
 =?utf-8?B?Y3RjMVBlSVVRaDhUd2tyamJyOEEvWEhsMUx0WHBtaWg4SVNFdDAwYmpocWwr?=
 =?utf-8?B?d3NIUklUWGRRUkhyVGhVMkxQOGNuNXFCU2RTTmJCdit0YWp3c3BSUkJ0RERM?=
 =?utf-8?B?bUpaZlBHZHVGc1FSdDEzWFh1S1M0blF5MmRsREZWYTl3RzVLZHlGd0JMVktn?=
 =?utf-8?B?aStoQnQ4U1VOUUJFWkpEWUlJaEVxd1ltNnRkM2dLdE9BbURRQnlFOXlQcndJ?=
 =?utf-8?B?M1ZMWkRNdEZ1ZzZwcnA4a0lVUUJsUmdjTGZsRVE1Ylpmb2lmcE1FeERwdHlz?=
 =?utf-8?B?SmR4eVJUTUY4NmRjd1djbDBleWg4Qk4zSlVLNUZycG9pT1ZiSDlWWWk1VFI4?=
 =?utf-8?B?K0xnMElmY2pyaFpzNm1DYS9WRm1wTWkxU3ljbWtqSm8yQ1pnaktLRzkrckZj?=
 =?utf-8?B?SVk1NmVtYkZRUTA4dUhXa1U3N296UDNGOWJIcG9aVzZIRDNNVkJMQ3l2aWhi?=
 =?utf-8?B?VHJjakE2UEpiQnM3SlVTRGpyQ0NSNy9Lc25rMXRRWWNnT3BidGRqS29UMWlZ?=
 =?utf-8?B?S0ZIUEVDL3g4NHBod1Fnb0RiSkR3YUlDWmk1aVQ3RFBLcGVUTWIvUlY0Nm00?=
 =?utf-8?B?Wnd5amZBNGZoRDhYbDlQVWNSaEtrS2x5dS90OTlXNnN6RDdhUTJCaHBGQXQv?=
 =?utf-8?B?c3p4SHBpazd2RkpsWCttS2s4T2M4SzRHZ1F5eVlVTDdTajVvQ09DRzBXTHRI?=
 =?utf-8?B?ajhuSTR6UzFqdHNxZSt1d0dsc01HdDE1WDRSSnJubTE1eFZKZjRMZHBTMGJL?=
 =?utf-8?B?b1FpdGVXL2dGRkZ1eE1TU2o1K0JmVklnRmd0NS9KSjg4cHFINkpyamVmUmNR?=
 =?utf-8?B?OTNPd2hnMjl6Y0RRWEJSMXlVVzdhL3ljUjNETkEvU0Vqd3dkNUY4VnJnM0dy?=
 =?utf-8?B?bTFOY3lBMmR6WjJKVDlXTW1tMER6N2JtaEYyaS9XN1JwaGRSTmcwYkF5blFs?=
 =?utf-8?B?QjRhR2tYOVF1RHNSb3JPdUh1RjgwRXpFd1N2cGtaOE81cU1TQUl2WWZIYWFi?=
 =?utf-8?B?cFNnb29SRFNFeVNzVjVqWXFPSUZETnBkZGRyMU1FV29Edll2Zmt5dWpybWQ1?=
 =?utf-8?B?TFFodFEwLzUzQnNpYW5TWWt5bzdGUXdQSUh1R3QxM28xdlZlR3VWNkpKb3Zr?=
 =?utf-8?B?cW5WQ3hNRFZPa0MrRFgyaDBnWXBhQ0lBdTlPSGRWUWpnRUw3KzVhTnFrd0Ix?=
 =?utf-8?B?NUViRmR1aUh5RXpOVEc2MVNNK2VBeTZPcmZBM2Y3dE1jV2QrOWF6TFFuY0gr?=
 =?utf-8?B?VDY1RUYzV3d0bFV5SmlzYmI2ajZSYzdoUWZXQkRoTHZrakZoek9ONmd3eU84?=
 =?utf-8?B?NHNkbVlnaWJVOHZHcFB6Y05QbytyaGd3WDJhYlA4blJ3YTlKcE1HcWJUS2Nn?=
 =?utf-8?B?Skl6VmpFcGJ1Z0ROcTJrQlZqSFgyQmV0eHU3U3ZhS3NjNnRZd0h0dWhPWDUz?=
 =?utf-8?B?OTF6TjB2ZTVtZmJja3l2SldKWGlTeUlONXlEdkUxMk5DMHZpQTlIWTEvQnA5?=
 =?utf-8?B?WkFLL0FOK2lUc2h1cVQxU2pBTVJmeGNvbDRSc3dxUFlWemZWOEFod3VJYXZ1?=
 =?utf-8?B?a2xWa3RsRjFTSUxrWW1Gd1VLa3lwcVE0K1FpLzBIZlJ6VWtNTUFWa2Z6UU10?=
 =?utf-8?B?Z0d3ZEZ0N3cxQU1IbVJRR202dFRCbS82QTg1eUUxd01iQ2NBa216Z1FSZ3Bh?=
 =?utf-8?B?SFdVY2o2Vk1FRFlFWGJCRkRsUDhzMjdjOXRITWI0TnI1b3FYejRKdndiTldQ?=
 =?utf-8?B?ZFhSZFZBbFRMMkpNd0NheXpYaEhqNmRUdGtZWkFhckJwV3NHaTZURkdPYldh?=
 =?utf-8?B?WmQ0cjlWZU9pVUFnb09oWXRRNDBGMmxjNTArNXJzSU1uVDAzZHBOSlNkdFlF?=
 =?utf-8?B?N0J0TWpheFI5SGY4YTcxa2RTTjdNQlBZTC9ZdkJSV1JVa1Y2SklIMTRZSlFq?=
 =?utf-8?B?eEV1WXRZcC9zbm5IZnpsZDlEUkswc09INVNqQXpONGlaZ2VLYU9Pb25TblAy?=
 =?utf-8?B?RlVESlUvclpBdFBlb1pxZDF3b3NYYU1XNURSR01UaG5uemcwb09iZnBmTTgy?=
 =?utf-8?B?bUpQVVhsbmtrNm5MTVFPRDFEL2E0TTIxN0t1UHRDQzZvVjQ5SUpDVlFrZmNn?=
 =?utf-8?B?U2dSZnZ3Sy9RY2hJdTBQeUVoWDJXVkQ3U3BEbXVXMnlHTHRqbWxpR0o1aDB6?=
 =?utf-8?B?RjdIczJwQzV3Q2ZoK05DQzhhV3pEb1hJcEhPYmF3c2drYWo2L0RaQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d404db9-8549-4212-c11f-08dee89c07f0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:23:18.6762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3xwKpLGSsyReX4cM9VUJJce/WTdP6Iz9XZK9Ro52OCu3puImiynDsXNy4quaOYRCzraUd6fvlzdYyLiF/rZNzQ3LFtX2o01rCXOoZ9n5wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7lkWMIjkSRwgPogly8nOXlLdkPem++pZPNFITjWeIg=;
 b=cOqLJobGJSNtUbnXafe3ck9Fmd1fYun/oF0jUAH+1INMFuow5s1pimryFv/9xflonPjPTxAiWKSlF1XTYwaKl1yeqt674lq50anLR2dO7npNTu2h9+E5og7zyRJ69S+CkpJ+2QVRze78SNcnRoP3VpoRQmVRN8E8kHtdwgL1MvQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cOqLJobG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="cOqLJobG"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/13/26 8:35 PM, Alexey Charkov wrote:
> Current code calculates the fractional component in 32 bits before
> assigning it to a 64-bit holding variable, causing overflow for real-world
> values of k, given that OSC_HZ is 24000000U. It also does bitwise manual
> massaging of an unsigned representation of what is actually a two's
> complement signed value, which is confusing and makes the code harder to
> read.
> 
> Read k into a properly signed type and promote operands to avoid overflow,
> which also enables the use of div_s64() to express the math more clearly.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I've quickly looked at the rest of the threads in this series and I 
think there's no open questions left for me? You sent patches to the 
kernel for making k an s16 so I'm assuming we'll go for that in U-Boot 
as well. The PLLCON(2) thing for integer PLLs will need to be fixed one 
way or another, but I'm assuming this is also something we need to fix 
in the kernel so a similar approach would be nice. I don't think we need 
to make this a big series fixing everything in one go, so feel free to 
send smallish series whenever you're ready. Anything I'm missing?

Thanks!
Quentin
