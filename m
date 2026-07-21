Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A6EC4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C706D80DBD;
	Tue, 21 Jul 2026 12:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSwThcivYkwu; Tue, 21 Jul 2026 12:56:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E35EF80DD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784638574;
	bh=hIVzT8uy6hLiArYBtkq07XHQ0WkerH2zHRmQaIEsics=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JeukbXkrgYeUfQRe6TgsOdGxHmsl0l5Nehba5tx2zhwx9aZ1U9LM8CSTxXWpcs7ln
	 mAU7ECuclAtcC8zaQUH6d4XF0t3+2hrlhIIVUjzPq61CtkTQurIob1Ybp/6CAflui0
	 8cq1jDKUu8s7BGyUPqjZhrI59VbTwkGnrCrvllqnKLzZtv0pYZqVIMKPctTa3ou9PD
	 Oc51ID2WuV+MQVUF1OwuokW8rpc7fecrFYlF3I9jTKxUcWT/PE0g7jwH31gShxixKW
	 oCVDz/tlwtODqwNmO6c7RutzyLpJSf6j6E1D04KIQUIU9apq0ktcf+Cult4mLDRCDw
	 1wkcMA94x/hnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E35EF80DD7;
	Tue, 21 Jul 2026 12:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E30E41099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8A26400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHcqE4_Z4qE1 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:56:11 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 75F7E400F8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75F7E400F8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75F7E400F8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:56:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B32382991; Tue, 21 Jul 2026 14:56:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B980803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:56:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/CEFg1wyjPEneKYDSiS13crlI6pp4g4FgV9JpZZCQORz+/+XYhxTaluh6j7YfYXuG/ZtFWdWQmP39NLSyHVMNOrN+Ij/JB+Zs9Cvb0Pe3Dl6O0TuMIbzwLay0aIkXCZFyUB4DzGUejE+XGorsz+UEwjJjcJcNohnUrY/qXUhuUW4yq8zh/OcfNvvDpNi0Jkq/kzUnjpXjjrU1asaSgoKQ7npdBX0LVgOVbQ8nJxUtWml0DiNaW+Uk1iQAZCHtgWClct92Ott3ujr7P19zo9km4ePL0DAaAE2Yn4t37db/eHhDxyJx4ElJJ8NgqocnRpyNIYclxApVayKd7fQrXtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIVzT8uy6hLiArYBtkq07XHQ0WkerH2zHRmQaIEsics=;
 b=fLC9DeNtFGiSlaY1C740UdUaOBWtsGKkaZTT1YimhCWgCPKUk8pYP73/A7qLK3KnCT0QCLmg0fwLOtd5fyIsmMJXXLCJUblHjawpNouYrooiXQPGZNTfNdFGmZhEMlZsUK26IAEGq5mEEaN/GIK6xklMiJ6jLwrRqM5rF6lprj4aviOTiY2+6wQAerPCMe9COFEMioUE9aINItzSy177iAhg5aP7b3KYYpeqz/dUE/GI1rhSdDSYhXY4JP5wovZ4L2mbkErQwPEM29fSSZJVuKpubcS4/33D+11iyW7KYeHvZI0ZPKL4dQPAGgrFDH7//VJjwNYLZTs8Why8jrTB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB10205.eurprd04.prod.outlook.com (2603:10a6:102:465::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:56:02 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 12:56:02 +0000
Message-ID: <c6beb0ac-0155-4437-a398-0e01241f0e47@cherry.de>
Date: Tue, 21 Jul 2026 14:56:00 +0200
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
In-Reply-To: <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0035.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: 896aae4f-70be-435b-36cb-08dee7276b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: upoSEKzo0HrUUGjXHF6idmuVyEYbVLVFqao/z4wBCnm0iEfM5PFKKCYehnzuHasvC9W21EC4ZV6t6o5BagDx6WEu1/2aqsiMHUxXmR4IpYD2eyjQ4XDOKTKUWr8qp9KaWg00vP/jJ+tc7dCoag8pXn8Xip323J5PUXP1bqrdE0KSudSRyxW7J1ylIaKbdlONqY6/1Csp7ZyG+H7P4ND6W5cECLJLqAv+obRMAu0lPGwdRHdrX+KhZWAQxHNZgUGC0cJQ1xTOcMzTp7KXNEeriFri9DREh3x2oWLyXEgisCAXfyzB4m1NzKK7wEAdMCAO91D46eDb6CFPLZ+43JQpUVryLW0gEDBpiDJo/fG8IZsu0Ae8p4K4c5IDYECb8yupzDTiHjSx11yRxd5fKoCJRzsBLsY4Gp5gu2rkgJzOYZqJW0gkA3bNTHuhCekOJSyJ+WA5SOLxiM9ovDhwjPh3uDRX9KFcrN8BkBMV+JICd1AqvTz4QNM1YWJ3+8EsDX+UFS79rNnsREghRQLTxRiTZICJtZcKdKJb4s8AYCcPLkc+8UPZE/9qWLUxXGKfkM5r4/gpW5SDZWDMpxagPNhK26Dh4V+gEJbCwISsEJRY7dGEnp8ivbIwFMW0Df9n4R3x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVGZ0lYM1Z5QWN1dlJrRVNuWnRZYVdQd2wzQXRWOEpZNEtXUnoxYXBzbEY2?=
 =?utf-8?B?RzZZYnJEL3VtMUdYVmVncUZudktNbTBLbnFpR3pJUkVqekNEc2pJYXMzWkRi?=
 =?utf-8?B?WFVsZytkUCtxK2tXTnBremQ5RFE2dHBJZEVlK0Y2bXdiZGViUVN5OG0yVXpy?=
 =?utf-8?B?S3Q5VTR2TDJ2dDByUVJZRXI4YjJ2VUN5VGNVQWtQWHJJdU1YeUc3VHBNYWo5?=
 =?utf-8?B?NUtSbXZXYXdMUFo1TlRLSCs0U1NpSEgxTk1wQkNtWFBlRHBKSEt6bFVvWjNQ?=
 =?utf-8?B?MlN5a29WYlN6M05xYmE2UC9YeG9IQThVK3VmcEtsc2p0WjNIUmlDUHBaZzl2?=
 =?utf-8?B?K0l1WWlJQnEzd0c0MTRSNHhEZTZHUVVIbkFkV1ZkeWRzYWdvQVdPa3psc0ds?=
 =?utf-8?B?VWxod25zcVo4Qk9DRTluWEE5cHBQV1JRYzZ0TnRLc0VnVlNJdTZvSXQxZjJR?=
 =?utf-8?B?elpXdWN0SWlSTjJJcGtRaHV5bXZQTUcvNEErSm40Nm5SdU9iaXV0eUVia2p4?=
 =?utf-8?B?NWhrN2xic3NBNlN0cDcyZHdWb1RwNDZOcmo0dkFObGkwV253b1prakpBdUt0?=
 =?utf-8?B?OWNJTkh6RnJLOFJmNGN1eTNxc1h0c29tKzZHUmdWZHpBYWpzWDZ0RlZSZTlT?=
 =?utf-8?B?TGxrU3J0UUNCOFRQa0Rod2p0R0xoVkpZTmlZU0E2cjQ4cjd0U2FWZ0NBOUVB?=
 =?utf-8?B?c3o5UFhOU1JBMVAvSUM3SU9CSTNnRGp3SUFEak1NUFFWbWw4Q0daSENnbHYx?=
 =?utf-8?B?SHBTYVpFcjNRcEpCb3FHMzI5cE92TUNKL3lBZkdRc2RTaEFVRnRuWHpCaXd5?=
 =?utf-8?B?aUlaaEZyK0tqNnlZN0xsRzZmNEFWK0ZqQVNvWE15WUtDN2hDcjU2TlpNd2Uv?=
 =?utf-8?B?eER4SmhVcG5iSG0xY202c24zVHVaemRvK0RYaG8yU0NGSmhLRWlKVm15SlN0?=
 =?utf-8?B?U1QzelVMREVaelNld05UdjZUZWt0R3FNMmd4ODA5bkVwTk1sME84OWdlUGNC?=
 =?utf-8?B?ZFRtTzNkQnFxNHE4UE90c3dJTG5kU1NIWmpEY1YrL0gvVTlKV1JvMkFKTC9R?=
 =?utf-8?B?bXdjL1hvaVlIbVA0TjhvZHNhZkZQbXNFMkQ5azJzdE9LSDdZYXF0eWwrYzJw?=
 =?utf-8?B?UU9KWUdMU2JDV2c2UHZqY2I3UkhiRS9LdlF1Qk4rRUJnNFZTaFdjTTAyNVFQ?=
 =?utf-8?B?d0MrVGs2Nmc3bzlVUUp3cDlNZFBaN253Y3I0MHlKdHZrTlpQSWNWYk5HZko3?=
 =?utf-8?B?dVRsSVRpc2pveTFPZlova2I3Zld2RFRER0JHUUxwSGtRREgvN3RXaEx6VGE0?=
 =?utf-8?B?Q3hMUGxiOTVrc2VSU2dNRGE5M0E5bzRuQlpicjZSdHhIZ2pWY00ybE1HWkxm?=
 =?utf-8?B?TklzNTFjNWJmQWJVN1RHajdPL05rU2dCblA0bHJpbEZBUUgvV214cklGeG1J?=
 =?utf-8?B?UU8zZzRlRi9hVldRNjdpV1lVVnNCQ2ZkWVJ4K1FBVUxPalZoMWhBbnljeGp4?=
 =?utf-8?B?S0Y0K0g2Qng2b1dOdEN5WGNaTE9DNU5qTGZXVjdZdHRXZTQ0Y2M3ckp1SUVl?=
 =?utf-8?B?MW00aFNxQk00QUVvWEJ4MEhqMm1GeTVLUWZweWlKcDNDa08xL2ZpYmt0YzVZ?=
 =?utf-8?B?R0ViU3lMSUZRZm5INFpTYUhUbkVqZTNObEg1emFEMy9ZM3ZUd0JwN3NWV3Vm?=
 =?utf-8?B?RGp5TWVadnUzVCtwakpQREN1WFJXQ3pqTG1tb1JldXhxbDZ3UFVDcmpOaHRE?=
 =?utf-8?B?QzdJSVdXZXRKZkVkSUZIRmg4TTczYko1WlpRTm1keUJKS0N6VVh5Qk9BY1lh?=
 =?utf-8?B?SkpWNFFlemtSSWttSS9QTHNjZFF4SGUwTGczS3U5NEU5UVZnalFVcklDUVdU?=
 =?utf-8?B?MnpFK2JmWmZDYVZURE9heWdNaklKMkIxczN6andoWHlnR2Vhc09KdEN1T1NH?=
 =?utf-8?B?VDFXZ3NHSkNBL2lsSmpiYVlnOUxURW1ITFJzVC94cWFyb214TURWcnJBRWxx?=
 =?utf-8?B?aTMxVXpsOUFJQWcyY1VIVkVPSmd4aG1YRVhvRytDZGhNMTd2bm4rUUZEODJY?=
 =?utf-8?B?N01PdUg4YTBaa2NWSDNGWWhrNzUyQmpOVGpiWWZBc280ZG9hRWV4aVpnZGV5?=
 =?utf-8?B?cTZqbmxTR0ZURStMS1B2OEd5cVc4ak01ZnQ4dFdzaWgrWW02STJaVTdQSWwr?=
 =?utf-8?B?eGtPemlFV3ByY2ZPRDdZQkcxZzRUZzlXamRvRWtScklyZjJXNDl1V0RCSm5Y?=
 =?utf-8?B?NnRUMzRmSm1zZEcxTVd5cW5uTG4rMDllYXRQcXlnMVk4ZkY1TnRNZU1MbEtm?=
 =?utf-8?B?SVUrc2tab1EzMlgzd203YXgrVlN0clgvLzRmOFMxdjZWamhTTWxxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aae4f-70be-435b-36cb-08dee7276b3f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:56:02.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm+V7UaELAQZZIJxewrKgTxOSS5+j3S7W98QZxGQluMsh0TzAbz3HOnZS7fUT1dXkB+O/eeZTujU/n1ysmCxhK7V+RKHt1TXJljHczsD1qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10205
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIVzT8uy6hLiArYBtkq07XHQ0WkerH2zHRmQaIEsics=;
 b=gqD98cE5OSRIg5KK/G7x3CRQymLhRaAgPOoLHjb523VpatAuCIlVeQDP+uC24AMG+2sn/fJ8QMJV57cr5JrS/W5l3FQgmEyEJtQKniqGKLhj0yfxcxOh1V2+8XBQSlrFOhms5G6zZQQF4qzCFdfVVEDfjaktGdFQ7QFIQOL+zsE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gqD98cE5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="gqD98cE5"; 
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

On 7/13/26 8:35 PM, Alexey Charkov wrote:
> Current code calculates the fractional component in 32 bits before
> assigning it to a 64-bit holding variable, causing overflow for real-world
> values of k, given that OSC_HZ is 24000000U. It also does bitwise manual
> massaging of an unsigned representation of what is actually a two's
> complement signed value, which is confusing and makes the code harder to
> read.
> 
> Read k into a properly signed type and promote operands to avoid overflow,

I'm not sure this is correct? Converting an unsigned integer (readl 
returns an u32 and con is a u32) to signed (k is s16) is 
implementation-defined as far as I understood (c.f. 
https://en.cppreference.com/c/language/conversion). I'm sure I 
misunderstood the spec but considering signed integer overflow is 
undefined (and I guess one could understand casting a u32 storing a 
number bigger than S16_MAX into an s16 to be some kind of overflow), I'm 
a bit concerned here. I probably forgot important stuff I learned a 
decade ago :) Can you point me where/what I misunderstood?

Cheers,
Quentin
