Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFC8C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4550E40928;
	Tue, 21 Jul 2026 12:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMwFWahQYKZF; Tue, 21 Jul 2026 12:16:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89C60408E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784636208;
	bh=rdZkWj1/P9gazeXL6mi4mfw0Eh8vEqg7DrX5NANFKU4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=S+23iWlCiV2tPPWFMO8WwM1EDt2KODKrDpMIaqUkuaNRZao5sPdvOM9UjxhxEx2cr
	 4n/v5Tsqgbr4QNtKMVXafUtsndc/V0s804EAMve9qiCbhlmeIcqX1WdFsii/V3XxU1
	 ppeNIA2TwG+BdDNNj8CzXJroq0/cLu2w+Znw247bHYHKR9u0lxtCnGVFk0et8ooSJw
	 KhdBprIzyazyeeeApqC8m8OGnBGE4swy9EJ2YKfXgiCsHH4JNrFql5R8kJ+Ajg5WrF
	 BFH96bgxTnzVfmXiuCDa4SfNV1BgQ+uXpHoxF7t4zboh/+rKEHw+E1DD9Z8ptM+n5b
	 uLE6j+My2GN7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C60408E6;
	Tue, 21 Jul 2026 12:16:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BDC4EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 321DD4012E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfrNMSX5FWpZ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:16:46 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 220B1400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 220B1400FE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 220B1400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:16:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802DD846A4; Tue, 21 Jul 2026 14:16:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54815803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:16:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W14lCL0yzVGdB5jlIACgJXJo6+3aOR1XVZLNxWYb+YwX/lUulZBKvAC/8zXp5xLyiUhBs0LsOIJxOrPWI+kkbvKr+3KK8w2n3oJ7L9U0zprtCQu1k5mg87f5kyRLAzNpy/yRT0hUssLpqvbyVY67CeBfYRm/warpd/+4jgNek2cX1FasvhI0nThk3LWEpOdixO+q0O2EanwFfUtOa4YwemxvD7sl9diJ0+LCebq2ZpG6QT25g91wwnZ6Z3bwzs2tIe6PbzoNkCPTZNK/AaONUhC0c7PtiRjsOomNDQVMqoOXpSEjl4yzw5eB2qMPxWGampSbJ4qZn8dwbjti95wPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdZkWj1/P9gazeXL6mi4mfw0Eh8vEqg7DrX5NANFKU4=;
 b=v71Qt/fye0eq0yhb8ivatItPhmjZ5+BCJWQIcYnrYrKGMDEXNfoECDjluPcv1mXamLXYMXKrjcs/IX8uTHqj/5/DxydVkkiRPybWFg2DW7lJXwqR6YOmtnuh/kbP+arER+5HfuQEPmCdM+Xp8cUsPEdJo74SFTdoHRzUeFuCIk886A6i8CHaVwHtLd9llLyL7PjN7hTRCSpt9FNe4rQTDmfnjpe/L0s4tTkmB5h3f5htFBU3O4XSGK9PpuDbYGUYWEUfzj3Zh+8OL2CRJbJh/HT6YazZlsZ/y3uiHdCugxwpyERFlnbVu1WYiB8SnUvXGTCpKPp6WDhLDkcDrdF5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:16:39 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 12:16:39 +0000
Message-ID: <f2dc4c58-20a9-46d3-90ca-497d473519a3@cherry.de>
Date: Tue, 21 Jul 2026 14:16:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] clk: rockchip: pll: fix RK3588 frac PLL result for
 k=-32768
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-3-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
In-Reply-To: <20260713-rk3588-fracpll-v1-3-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0215.eurprd07.prod.outlook.com
 (2603:10a6:802:58::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11791:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1b9908-e182-4fa9-ac51-08dee721ead4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: vV3YK9pU9owPMyAvVfpxyWkGLurEWz9osRXo1Vw8DTOrz5SSVU4jF097i149IptI7YHfhxn5Mz1z8UeWA1FcF3aYH3WYCn5oP19itiSMO4gYo55Z53NifDRqlctOfMLqzXnIk4D5+rK5vEj6pdKbk9WTkjtmsxP7/q4h4zpc8df7EQbgCaHNYjbnRswmgTygSYxg/XI3BYGqZfIX4U36T4Et3mfc1k1b/QsQ1++4ExADPHOWUGeC+0j1ZB1pp6FYIqTU9cSv+PSmzLEpiqpDVxUHMHcLZdyM8vFCRSxCzYV+gizeNjyND2NYyRBYyWbeNtHFQI2S3rj3XkCQiMN5TP3PNWut76U2DdHXv8CK5Zm57kCiLIcHQ1AMA3T6bKmDvihBkWBMAos6lNH2lcDtBTSwQxH8QwL+E8Pfz3GXa/HwvrLO5uhjxbMwimu6311pfoGOqwGfyY4bZChzQP+soUROVaDwaK/AAEMayXZM2z+mKd2vl0Nyu9fyQ5soL3rxJNuIaKIp/AYCxPzb5gJOKS5yJGMHHc9fL9LNqxDOc8grK/xpFYM3o8nl8u1d1WKmbVVk6msQFS9765tlTzQlCK1oHjjX4dURFo9RAo4w/a4XS/1Au28cvE2yz/QoESzvHZjUyFB+0nGITyhYcKBnnxFX+WOkldDEyVSR115j8Ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGszZlhBbXRzMTNxRU8wNHN2VVU3c01XbGNscEh5YzdxRXROaWZ6a2dOZldp?=
 =?utf-8?B?UHlPNnQ0YmhjUnVSV3o4WFl2Z1FxQ3lIdGJ6VjIzTkU5d0dHdFExbmFjR0ta?=
 =?utf-8?B?MkU1TTFrMlcxcFhseWErUjlZeUR3Y1UyYUExdlVhdERvY3VDcHBnR3N6NnVN?=
 =?utf-8?B?UjhZK1VSMjFlRUxZcDFJRkd0aFhpTUdrenhtNU5uVU4vbnEyUVFiMEFBMzBl?=
 =?utf-8?B?czlIbFlGall6UVQwQVJsKzMvYWQ2aHVITGVxZ3NBcEhCV01oemt5amxEaVU4?=
 =?utf-8?B?VngwelBpT3ZON1g3ZjFENXN5WTU2RzVTNm11S21HNlNQREJYUDl6VnNiK1U3?=
 =?utf-8?B?U0V1UlkyZDh3ajZCRHJnbFBTMVJhQzVnRGpSMHY3YnlQRENTbzNITTI1R0tR?=
 =?utf-8?B?UnZXbUwvSktWVlN1YmRFa1QzUFFQbU0vNjVnbExMRS9zRnQwMlNtV2ErTWJk?=
 =?utf-8?B?SkwyTzRsNGtOc2ZtTkJSRFZHMi9rak50VVRjbHM5NGV2UDJSdWc3Sm1hV1NU?=
 =?utf-8?B?SkJ6Z0NkM3AxUTRuS0FobE1sYm1oaWFseEpIdDlyY24yMHZkanRVYVJweTdV?=
 =?utf-8?B?VFYySUcwamVCcVNKdllDUGt4NnAxaTRoOTRteG5xbXd2N0Z6Q0dPQ09YQWND?=
 =?utf-8?B?ejV5SE1mMjBQU3lJcmQxVkRyMnQwcW8rcXpqK1c5bEtkVzJjSmxyNFdWYi9z?=
 =?utf-8?B?a1BYQTFMQVhaK09oa2hsdlJMdjlyVEVId0hYZm9ZZ1NyWGZlRHNxVVYxcnMw?=
 =?utf-8?B?SFVYNlNVeUZlalJrUEtRUUtaZTJPOTNZVVY3RmlVVURkOEx3TWFmRW5ZRGRE?=
 =?utf-8?B?RFh3TUJvMW1Nd3FFME5UN0VsaGp4RGcrSkhoL3YzTzdQeUU4U3Njb1JMMWJx?=
 =?utf-8?B?ODhWMjN3WXpyNXRwN1o3OEJ5RkNLNVdTdDNlcEVOZDIvM2ZZeHpFaW10ZHdk?=
 =?utf-8?B?Uk5SeVBHSkgrVDZPWDZOVVBjU3d1cE1iMVBXMnFqL2RkZmk5c3UwTTQrbWRj?=
 =?utf-8?B?UnNBa0srUGh6Z0wxd2t1YTRqNWFKSE9YaGh3Um1qTEVoMWpnS052Wlk5SDA5?=
 =?utf-8?B?NDhJUDVjVmttMXh6R1NuV3diL3daaGNUaUhzSEdmWlpMejJLUWt6R2xvTWV0?=
 =?utf-8?B?dUtIa1hUWXZvNEZOQ2xvcVF3T1poZGtHT3VvMjZYTkRGMXpzeGJTRVNZQW91?=
 =?utf-8?B?dlFPOWdzTzNTYW03d2dubm8xeldOV0ZnYlZkUTRTZHp4Qklub25wRzh2YUdE?=
 =?utf-8?B?bmJVZk03WVpZaWE2T1NRRmt0U2xlMzhibWRWS252VlFHMGFXRlNZZVVQbVB4?=
 =?utf-8?B?WkwyaHZ6R2loNVJja1BITGNGM25zT3VIYUdJUTJJTndWNE4vVzFCdlFpSTlu?=
 =?utf-8?B?enRPQ2ZjTi96M3lBVVJKalZYeW5haUMxSW1WWTI2Q0RLbVdadkhGRnFOdjVE?=
 =?utf-8?B?QTRKSmwrTHphMmh5bys3QVNPZ2RJbDV0bjlQanlNYmc3dGlYZGt0K3NXd2hP?=
 =?utf-8?B?VEs3elRSOXRFNkFvN0t0cGs3RitLWWVDQzZ1MzJIWWVKV0MvWUN5Qkx5UU82?=
 =?utf-8?B?VytsaU1qWDE2M21SSUdzZTNjTnpQTEJMTkVWWWd4Nno4YVVrMHZZZmkxbHJ5?=
 =?utf-8?B?LzJXNjBJTm0xRGJMSWEwU3JFZU1OMmNxd2JOYlVYbFlJU1IwUU5tTmhyWVNk?=
 =?utf-8?B?cDQwMkVXcCsrQWU4V3o4amwwY0x0cUkzUnY1Qmx6RDVXN3dhY3haUmRGVGtS?=
 =?utf-8?B?R3VET2ZlU0dSTlI1MGhRSWdWNTlJVVI5VlRjQUtEREoxZ1NibHg2b2Era21E?=
 =?utf-8?B?VGZaWTQyQWxuZG0wak4xYnp1aUJhUTcrVGpCSE1LRWpISWdLYmU3M1NWbmpn?=
 =?utf-8?B?TlNINzc3NVdJUFJLSXRmQjhoY3hHNGlYZnROZ25TT21JY2p2dkZsbDE0OXBv?=
 =?utf-8?B?NDBzRjRXNSsxcWJGOUNlNnVuQXlZZzA4UGozN3pxUEk4MDhYRHRPQ3hEU3cw?=
 =?utf-8?B?clBBNkZKN2VybEZ4ZSs4aGVMSGxrc0U1R1U0QURCVlF0b252YnpGN3pjVm03?=
 =?utf-8?B?aTVMcHNCMmpVZXBQWUFVemlVdFI2STh6b2tpbUIxRmNlUjBNK3lZaTFkYzBv?=
 =?utf-8?B?ODJETENnV2tWaFpsQnM3U2NySnZDU05FMVBZYndwc2lqY2VLdWg5NHBrU3Br?=
 =?utf-8?B?cVdKbDZ4TGxJa3hJUnRjSEhPd2pYeWV6SVZXTnhQeFNoWW4wSmdpK1hZaHpr?=
 =?utf-8?B?UkpzblhtUW5iLzVycVV4cGVaU1YrSG9kbW1UMUthbmJJUG9mRjR4SGR4OEYw?=
 =?utf-8?B?TmRjeUtoRERJWUpGelpkUmhjV0FENDZxakg0TkhLMVpwam1SVjdQQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b9908-e182-4fa9-ac51-08dee721ead4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:16:39.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou5bFDmsNXR/kaZACdwjnoWOr+1Kvc4LABtU54aaKRDhB25A09wXAYWhJPbJQiHCyhNi9sx7ojqeJ9h3WqfVZCZSrhNlH58i2xr/NAq8rEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11791
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdZkWj1/P9gazeXL6mi4mfw0Eh8vEqg7DrX5NANFKU4=;
 b=f08Dn2AsvkTBNuy0S/CIORSMOE5Y9NwYUvEkyO/f4UtuPLcrkOpapysmuSnegU44GlsI2aFJun8LV7p3uTYGA6XSpg6tFmUL5m5hkzc4lKFZkOsU0IiH7kuPn1I6/dJgnHnOHSUKOzxKefq+wNFp+jSsrZq5GePbTe0VHXi4gdM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=f08Dn2As
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="f08Dn2As"; 
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
> Current code needlessly sets the k value to 0 when it is calculated as
> -32768, which is a valid value for the RK3588 frac PLL. This results in
> the PLL output frequency being higher than requested when the requested
> frequency is exactly halfway between two integer-multiplier PLL output
> frequencies.
> 
> Negative k values can never go below -32768 either, because that case is
> handled just above this code, so the check for k > 32767 is redundant.
> 

and because we add 1 to m, which is eventually multiplied by 65536 and 
thus if k is >32767 before adding 1 to m, it can only be <=32768 after 
adding 1 to m as we also invert the sign of k.

> What remains of the if statement is a hand-rolled two's complement
> negation of the result, so write it out as such for clarity, and return
> the true S16 type of k as specified in the TRM.
> 
> Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/clk/rockchip/clk_pll.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
> index 69d2d182dcb5..c6fbeb71c77a 100644
> --- a/drivers/clk/rockchip/clk_pll.c
> +++ b/drivers/clk/rockchip/clk_pll.c
> @@ -167,11 +167,11 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>   	return rate_table;
>   }
>   
> -static u32
> +static s16
>   rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
>   {
>   	u64 fref, ffrac;
> -	u32 k = 0;
> +	int k;
>   
>   	fref = fin_hz / p;
>   	ffrac = fvco - (m * fref);
> @@ -181,11 +181,7 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
>   		/*
>   		 * Round up to avoid overshooting requested rate for negative k
>   		 */
> -		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
> -		if (k > 32767)
> -			k = 0;
> -		else
> -			k = ~k + 1;
> +		k = -(int)DIV64_U64_ROUND_UP(ffrac * 65536, fref);

I don't like migrating k to s16 in multiple commits, especially since 
there's also a mix of int/s16 in there. It's quite confusing.

It's kinda bad to store the return value of this function and then do 
some additional based on its value and set the rate_table based on it. 
Considering the next patch, I think it also itches you :)
I'm thinking to move the whole rate_table->X assignment within 
rockchip_rk3588_pll_k_get(), also pass rate_table pointer as argument 
and simply return 0 if it worked, 1 (or -EINVAL or whatever) otherwise 
and have the for-loop return rate_table if rockchip_rk3588_pll_k_get() 
returns 0.

Keep the current type when moving the assignments into the function, 
then migrate rate_table->k to be an s16 (including the struct 
definition) in another commit, then fix the k=-32768 case. I think it's 
clearer that way and avoid implicit casts and a mix of signed and 
unsigned types.

Cheers,
Quentin
