Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC45606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tEeU6uBp;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=I80aQOGK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8599140E1D;
	Fri, 13 Nov 2026 18:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OiprtpiFrN3I; Fri, 13 Nov 2026 18:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C863840E17
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794593978;
	b=O6X6RTpGOtaSS2H2axzqCg23OSIjluA8mAqnFwTWlPl/UH/nP4E3Hn6+ewG10CLdCWL9
	 coPvZ3FukSPfELFBUkBPe/mMtM3NJmP65ZXNOssPTgNT1vzjrSAjL59KwmV7RVBe/5nd0
	 cLzsYy+ZmOItmw3bJ3ZLr99kFVsHngpUC+1E6l7k8wD0AIQmbh1oSsG3FfCc3GassUYE7
	 qwesjeSRi700cLYHJ7S66mhqrY/yvehpSguSL6w5aHTKxOCETgFY9EyqT5EXxOXyXVUNq
	 2eDR5ySMbAdZQKizDcKW53OetbEmWx6ywMeFuqdRhuSKOW7jWqj+VjTVRrUaQPEhhOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794593978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z7fCBGARWo4yXO8d1FRHF1Mvrki7vvUD/Hd1TUGERRQ=;
	b=frkqV9ogEV9qBlIoMbLXjvPv0px1VjnUfkCArDsEhJmmEwdkvUrLVRddJkIz92+G03XS
	 IIGxZtCNzcXsKx4n8EAo+CDlULWlCk3LoPwDJl6TaSm72o1xtqBZ+w66X8RVD5xAn1N7L
	 9zGK2xRSh6XwcWH22Xu/+YqeViJrZxOvtvjPeAW5JROKdUpwiTvul/iABv0l+/t+32mG0
	 fgfdbPIKNB/WDWyC0xAeKw3H92nI/mTUTjPsxyljttrP/uGobfezaVndyN4UO2bPlNgvU
	 lomcDyfQ7OEMncn7HLFzMgiKlW7buyHX4Ix705YikuKwCp9XoyWia4y0ap7GnHoDZLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=I80aQOGK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794593977;
	bh=Z7fCBGARWo4yXO8d1FRHF1Mvrki7vvUD/Hd1TUGERRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tEeU6uBpis64aYpnfo7Rk3zNWRSUi0htR20lq8NR6QfzmhOZ+zOOe1pPb0Ird/i3+
	 2bZ+VyrTw43QYxfEmWmECXKfg+OvUsxZscBQBuCtPbyXxMIKC/aX8zvMdfqWn5Gc1V
	 rlnINku71KQFw5+Qi3Mz81JB4W2MP36aSTGnq12O1TG4Likx4LWcq9wn+9twL9vlxa
	 jT97qoXoCWo4BtTk1BAvZgUMSUsmmwyFlcIZ7KDThVrRI65oj3wcg0s27A0lXOjS+p
	 T7XvwlEbLR1b8GHEkxuLPIJWEZt7HvT/1/7RvkYsITeuxAnHA6728kvPq6T/XEVK5a
	 c5VbRvlwNHYqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C863840E17;
	Fri, 13 Nov 2026 18:19:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59558150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B2B440E17
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:19:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0zTnDlnpucf for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:19:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3325B40977
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=I80aQOGK
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3325B40977
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7fCBGARWo4yXO8d1FRHF1Mvrki7vvUD/Hd1TUGERRQ=;
 b=I80aQOGK8j9aGYy/ql4fzSbBjIS+789I0eMGVhFjxJBpPsVV4VVs4SuiV2Ddp4ZJzJKSQoLSH3mpU7/34Koh4dnFDmbdBlmfuoH9CAMXA2o74AbjPKmrYBCRiOECTae5TWrPNSM+B3EfJbV2dWc/7FGD8b9apOhQNScHZwI/twQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7566.eurprd04.prod.outlook.com (2603:10a6:102:f0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:19:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:19:29 +0000
Message-ID: <28017d10-dd56-4ec3-bdcc-9588a9cf09cd@cherry.de>
Date: Fri, 13 Nov 2026 19:19:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/37] adc: rockchip-saradc: Use 3 MHz clock rate for
 RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-38-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-38-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0050.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fa40ff-7100-4d8c-d745-08df41b2a7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261026121527099003|261022075727099003|261021121427099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: a3BfTKUTKHbghBsvI6FfmFXlUQNRelX8NFyknJ/KxO9vq+7nDZ8FO6aw/JkbT9Ho/An6OaD1aUjtHKm/qcthUGmF+5jHjNd1676Vj0ISPwyk8LHgl8UX+p+WWcwaxqI85Xvw13YSj5Ym8XUCcKoU3GU+VOZMAoLW+Z3LNn1Myv1yzcJQBBWEhOuZzN/HXeg8sZCbFButjpd9dVtbcWCNvWBPrqoMZBlwgUk4qDlnGk2kuofWk2Ta3i+v3s72P4741f1QXuxI9x+YOwByGo8Ov5PmjthcQXRB/iMuToaNvxUNbWq6pa81JVFX8kYh0myYvpT6APEzzKV5nLM45sNxEnXKN1eLGy9bl2Ds2d3mEU8nHBnbKxWPBR4XIcwkc/cwTnFFnBEMEF45s6Bqpe2YiKBp3FeBaQ3itQRCypQsICttkNCfaYt4G3vOCglAwVB89WUqSD1EwuOQ61eEK4VOx6UIKQuwdtPhA2u6awGuJMeHEOBG+Tg8lO2neDljuHA+FiywfsFWBJz1LwgfrLeF/FC/2/X9+FBiVsHTQKrgD4C6j1QYkq0Pyv8LCg6OxPe0+yoqxnSpu7RIx7sgqAJk4Edp/OUN9RIp7YNRapzBws4eNBpl3OfQxcgUQvGt0ORpJ24jk0nJ9u0sGWe9lBtOAvYPHYx2Vl+SOsM/sTQPTdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGF1eExCMEZ2K1pkTXJOQnYrcGE0VjBYcTB0ekwxVG5nR1JBUUdQWEdEUU9w?=
 =?utf-8?B?QkFvSVkvUVFYc00xQVVVT29wYmhRQytMbVBNVDhVMGJ2d3Y0YWpvVFNhc1dn?=
 =?utf-8?B?QWtoQjVXQWtZRVdOSERPZ3pGaGxoWUJDd2ttVlBsaW1iRDFSNG90VUpzTzlH?=
 =?utf-8?B?WTRtYXA3Z3dLbkh1aHdBUmZ5QjFBTmxjdURmQUxRWmJjblFQRERFSk11aS9W?=
 =?utf-8?B?SXI3RklTM3c0MXR4SVJMakVlZTl1Z2pRY0pBVG42eUJ6eWQ3WmhYc3BVQUFh?=
 =?utf-8?B?S0FxcE1rK3VWUTlxbzhWNW9WVFo4cGwydUEzUVdhaWlmZmkrVEhSOFVraFhL?=
 =?utf-8?B?dWc5bHFUUm9BOUYwK0hoRXJIbk1KdENYL3BSQmFTb0FZRm5sa203aFdRS3Fo?=
 =?utf-8?B?MlRid2FMSmJFaDNEREpia3hoQm5HTDVsZUNnRHEzYVBHQ0l0dkt4SHN0dmxh?=
 =?utf-8?B?OC9jeVV0TUQ4YUtzb0ZOeFFycmd0VTJKNkU0U05HalFCZkRzQkFZZEhEMWo5?=
 =?utf-8?B?YVRBamJyWktmdklIc0hhZzgrV0MvUjJCamROUUNkTlc4K0h2QU00bUdCMHFO?=
 =?utf-8?B?RnpYK1krMm9OWDVndEhoWitOS09iYjlkQWt4YnJGSERrakd4THpZcnNmOXpx?=
 =?utf-8?B?MFBhK1EvM09ZeWZNMWR6eGpxRHJDT2pqK3dkbUJER2RjQ3hBNzN0eHA5STI2?=
 =?utf-8?B?VnJ0b2llUGVIKzZFbmt3amZLdW42SnVBaGVWT0E5NGpvWlgremNBMEh3dmlm?=
 =?utf-8?B?Zmk5bzZsditEWWNqdVJ6Smg5dGo2RENBVEtzbWNQWVNpWjljRjlGWGkzZEt5?=
 =?utf-8?B?aG5lMWd0U3Y0c3pPM0xZV09rVmtpYlJaL1Z5M1FMVVkzWno4TWszWFRFMFd4?=
 =?utf-8?B?YUtJcEpWTkZVT0FVY1JBNlpQNkpxS0FiRTJIQlV1NGVFL2l5QTBsQ1ZIQVd4?=
 =?utf-8?B?ckRibithbTFsTFFlTXk2L0VQOVF6bGZlQkJFK0d5eXVZR2g0dVZVT1d0Syta?=
 =?utf-8?B?aHM4ejVlT2RpOWUySW4zQWowRGVqbFR5cFpZTVI2T2ZzQXJxckdBS1VIMk9y?=
 =?utf-8?B?ZTdHcStHLzEwMHdtWVdXbGZMb3UwV0JsVFNHWlp5R2o5Mmp1NFdzK1JmNmZt?=
 =?utf-8?B?Qy9WZnl2NklzNlFlS1NEMm1WbU1ZbmlOcXAySXZLd0s2MVVqUiswc0RCZVYy?=
 =?utf-8?B?ei84Q0hoTkdTUm1INUFTdEhSd1VFZCtpdm1EMGtmRWZCalFkL3BvZmp0bGxD?=
 =?utf-8?B?a1VrR0dPdUoyemY1aFZpK2pPRWRaWFg3Z3FpcTFxam5FUVoraUZlS1BLNkk5?=
 =?utf-8?B?UEUxMWJNZ3ZUanp6Y21Od2ZhREJiZFhoUU4rbjhTbjlBMWFqdHVUN0Z3L0FG?=
 =?utf-8?B?emNQRGp1QmZ3ZGJvVnk5RzZEOE1MWFNXQ2JLaFZBVXQycGJxN1lkeHdaUy9k?=
 =?utf-8?B?Y2k2RmxncjUxV2RUMFJXNDFjYnlFNUlJbEM4WEZXQkZCM3lhSmVjWmFuZ2h3?=
 =?utf-8?B?UDkvK05ad1I3ZzJQU1Q5U3A3WkFkU3VqVDJvQU01VHcvdk9VdDBpdjBqNDQ0?=
 =?utf-8?B?SU42RnlxNmNCeStxS2JEbVVxenIwVmcxcENNLzBGVkE3NDJBQWw4RGg0SUQ5?=
 =?utf-8?B?WUt4bWJURk03OTQ0c2lWTC95cUJISWQ1Rzd5WENqVnRQVW4wN3ExNGhBTU5v?=
 =?utf-8?B?QkViVzJraTBzZUNFQllzcWFEYkI5dVgyZGZ5RXpOazVnMUsyTXZFTGs0QzFn?=
 =?utf-8?B?cjdqYjF6aUxxVXpHV1lDVk5tQUovdEtCRkVvMnNGRzE0azBCMi9tZ2Z3bFlE?=
 =?utf-8?B?WXhSQVBqVTFGbnd2ZFRoN05HV0tJTXlib3hyZHBkOWNoeS9YTW95T3o1TG5p?=
 =?utf-8?B?OWNzU2Z4SVlpdU9VOUlsVXVvTFRhSWtUSk1pS0Zuc3kwWkRHRm9EVWhidVNq?=
 =?utf-8?B?azNYeWQxTHhleW1Pa21ZQjRtNW9uTFZwMzM1WU41U0lpK0xQSTNwdnY0MkUw?=
 =?utf-8?B?aXRpVUM2K08vT3NJNi9WUnRaSnZyU1pmZGtlbjZvajRvQmxUakdPNHVmSmRv?=
 =?utf-8?B?cWJKZGFwWFNBb1lZbUl2MFhLSEM1MHBXNVBBUXdVbll3cDd4b3ppMExTaDVt?=
 =?utf-8?B?SndRVUg4S1piY2NFclQ4NUdjMjdDMldveDlMYkUwalp0NXlieG55VzlLMlcz?=
 =?utf-8?B?NkZOSmxocHBmanV5MkY0QXQ5QzdDcFRmNGpmbjcvcFE5ek0wdyt3K0xVWVRT?=
 =?utf-8?B?NGRLOHNiWEhMcVo3akNtc1FDb3UrVG55NGdMZXFXV0hES0RQNDVsREdCYXM5?=
 =?utf-8?B?M3RtNVdDMWx1UjdERTV6Wm82RlpSaGlKMkkxbTFFU3R4dUhmVTV0QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fa40ff-7100-4d8c-d745-08df41b2a7ee
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:19:29.2041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HT4eekuyH2dZgSi81kuExEl/ciCwi3RCGLa9+WZbPTiwhBKgNcNqa3KLYm3h4/o7wdig5mvJ0w5qloaOJIzDv+sr0/6ad8L0DHUUOapyomM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7566
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> The RK3528 CLK_SARADC divider field stores the divisor minus one.
> Its three bits encode divisors 1-8, allowing rates of 24, 12, 8, 6,
> 4.8, 4, ~3.43 or 3 MHz from the 24 MHz oscillator.
> 
> When the driver requests 1 MHz rate, the required divisor of 24 is
> encoded as 23. This value is truncated to 7 in the three-bit field,
> selecting a divisor of 8 and producing a 3 MHz clock.
> 
> Request 3 MHz explicitly to match the rate already used after value
> truncation.
> 
> Fixes: 6ef723af18b9 ("adc: rockchip-saradc: Add support for RK3528")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

I don't have access to RK3528 TRM so:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
