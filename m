Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD2606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AiH8dTbO;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=neVRVLko
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CC9680E37;
	Wed, 25 Nov 2026 17:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vK9ta1LLDMGh; Wed, 25 Nov 2026 17:20:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 29DF680DF7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795627221;
	b=Ns4cnPJ7bEmppWF6x0OpWJkgc5M4ILhTKtuNXWhCRuVGn0Qb3qAvAhktcY2PFfcQiwNO
	 4IiPAuXZolKuMR946PevsyzC8EGgX5N798s6wr11tNba4yV3pIpM3+kOQMEuISsP7Iyc2
	 iAE03x6QhwVUsNSL8aqHCVUhgkit3Tz9ZvtJTTfcFRDFHfc9Z0FyyBkjfNWsPs6t1mZbK
	 EYsKqJEMx6PaE4pMtom0IqJBt9kDWg4sDzFte+V9JptCX2qEybwLYQGS4yuGgDgxJWfEY
	 igaRq8rJxhslZ4ApneLgOsD+emcI/20hLktB20FzwrfNyLjjiiTsmbrtQCZht3uztSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795627221;
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
	bh=63tBIi6ofz6O3tA5RNjl/K0WaxK7u8FYBw7RIgCEt8g=;
	b=ecxInQ0JpgpqSmADPABSNMuGqe0Bdph5URZnqSN8We5SFcHU19ByXATxj4k7OmeqgcMv
	 so1y7jFKb6zxR180xs5aSjljZE/d3YulvtPDJXD2F5cNiNYpsx9QYIiSesJoBKuK1GNQb
	 L2fVaYmyH5nV7YBQ3red/6aZD9GviqDcJYs5/vcMNpKeoK/Zn138+KiDln2eENvDLRBkv
	 7/noejCjisczPockqe2a12iuPx5gbbP4MxdpCSP9MTtFDBlEM8c4aODXtJ8/cNY2/qZy/
	 3obtDNKHlT2MkX9E+ypYRYHmaU+c22RS9HbtKerGT054lglVwssPXdGJ4rgf/M9hH1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795627221;
	bh=63tBIi6ofz6O3tA5RNjl/K0WaxK7u8FYBw7RIgCEt8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AiH8dTbOF0ts3xH6np42ni+ZvkMSe0UcOSnpC7Ipb9SaWiWsBLznXv+WHZwb1J8Mf
	 5i4qNIj6kAPP1adn13S4Yerg6zZz3NvIBRN5JaOq6SmVw50ycsSMLy0fdvF2bTlf4K
	 AKgGW9IRzJ9ClsCTvWS8iSwQwzYfytXys/z2HUSlAsjE57LmAonIcXCAc4yiRPKedE
	 gTuA5gJjZLBxKB1sfKJ+CM97NDKI2E3d5Te28nnJsA3eqQjzU5iVU+6d+TsHrBoUXy
	 WKiNWAtUeWC548Rd9MHHKu0ob2+5J+wtOzYfZ3nmyazWasG+9D7cm9wc8fxv11Lom2
	 eOhUuwpLUcyyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29DF680DF7;
	Wed, 25 Nov 2026 17:20:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7256322B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63F17606CE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PImAjoHfcMwq for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7ED35605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=neVRVLko
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7ED35605E6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63tBIi6ofz6O3tA5RNjl/K0WaxK7u8FYBw7RIgCEt8g=;
 b=neVRVLkoBW0EZ9zmhVz92enn2s4eNrhcjgHSFWkbmtROPtkOYbWOViYeS35beJRs6PHvDh1TrtBbO5pl19iI62VwEoV5MXThZ9OnUqok3krzaVLngFB26zeNHU4Gh4Yq2rGXU7wh5uJE+Sz9ED1uc+Kf+Xltf2IHTgK/BnRETXg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9648.eurprd04.prod.outlook.com (2603:10a6:10:30c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:20:05 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:20:05 +0000
Message-ID: <3a263d76-c2fc-4e15-9f2c-7795bb27a6e0@cherry.de>
Date: Wed, 25 Nov 2026 18:20:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 richard.henderson@linaro.org
Cc: casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0176.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::33) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3a81d5-3b4e-45c8-cc10-08df4b185889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|11063799006|260925021311599003|56012099006|260925022911599003|261102123227099003|261009221227099003|261021121427099003|4143699003|261022105027099003|261022115727099003|261026140227099003|261022075727099003|261026121527099003|261009223027099003|261009221727099003|261021123027099003|261009223327099003|261009220027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8hnmaP9dWUKhi4FSg71J6BgsIhs+zuOEySWlf8YTp4UUVzok+vKw3zXKjG/RdgoWIb/bgkQVYGpQwvvKr7elssIH7q29X89JbqcrGvBvw2r+LLa9qIVA8nx8Vh4R0jAtA7p/8WuOf5V6o6jkh2n7RZr8s7381wByMFOxXCL7e2EXY+EiYo9S8GPsrhJjbZSl7BrVkd2B7mAN7nyhwCAV3UEMduLc27ikuny06+eP0sXR9aWv4Je6/p81u+wAnjoEH5AhrT2Be+4ByLISRwoHG5N918UmHVjDrafmbmcjqnnmDAu7HMm8FhlQqKHhkzIM2EywwO91/NrSPL++NN+i99Z65FdtQNp5mv273Mr+m6Dh8nv6YOn9K4sLRmRFsMNEuPoK7vRVH6ig9jF8ddkt0kBGIbykmgoGiApuE4Gtdf378PU8h40TLmA9COaSiX/lmufHsoHwtRJX1xSeZqR/wjUr2Cb4BWZI39eDTx0lk6wJI25b8XnsxoGBB0RfyejIL6PbHNxg44vRUJfSNtESLLvJSUcnxrOhYZN5KyF7bDCSzn1hbHG9n3vYbDa6mmmndkrsiUzeRrYczMxYuBwIm/qDUfLTrY89JLEE3oC7T+mOtGqBRDMu2OJdRdkSFVJD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(260925021311599003)(56012099006)(260925022911599003)(261102123227099003)(261009221227099003)(261021121427099003)(4143699003)(261022105027099003)(261022115727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261009223027099003)(261009221727099003)(261021123027099003)(261009223327099003)(261009220027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJVMDluMjQ2K1RYTjRDS0c5VmlmTEdkQU1USDJXQlQ1UGIrcTZkSFBIMytM?=
 =?utf-8?B?U3cxYTV2L2pWOStkeDdSakJZTHNkcHJtaGxqVzgyMjYvS2ZQcDR5aS9oNU9u?=
 =?utf-8?B?cVRlTG9BSFN4S3pSRHRZWExEam1Ca2tyRGVSemUxODY2NzJZMVN4L0tFRG8z?=
 =?utf-8?B?VldQU0ZtME9scUhUVnBISUhGVmlMRmJQS2RQVXJBQVlLSUhrb1JnTzA4OERr?=
 =?utf-8?B?V1MvZjZONlNmYysrOTZNaWFJdEZQdGdvR3RCUDk0RzUwbjUra1l5NmZ2R2Zh?=
 =?utf-8?B?RzNCL3ExVGF1N0U3UHdwL09ocE1ycm1vd25ZMUZsTkh5ZkxvamdMeHdFZzNr?=
 =?utf-8?B?bC9pZVUzNlovNkZDUmM3U09NMEJzMnJSYndmcUhQZlpjUkNtVWNVZ3hvMnZy?=
 =?utf-8?B?Q3EwcTRXTEVPVDNxZ0E4QU5zdStabDhDUzBsV2JnbFFWSVphbzVqelV5K2xB?=
 =?utf-8?B?eDBzNWVlWVgva2VFNUNHMm5sSi9QT1RWWU5KaFAzSmJXcG9vODFwTFNLRFZD?=
 =?utf-8?B?U0VEbGZpWkFiMi85bG1zN0Z3M3hTS2twcUNWbGZpdUpsK0JiaVhXM3pRampD?=
 =?utf-8?B?VmR5dnh5Y0ZnREJuSzhYcDd4UytDVFh2MXplbHhyYUE5eWtrRmRjSjkyNmg1?=
 =?utf-8?B?bll6N01WanZsYkh2MmxQSXRRQUdKRGwybEVVOE5xVi9Hem54c01GYlZqUDZM?=
 =?utf-8?B?RSt4SHZoWU5mcC9IeXc3d1NUbkE5ZDV0UkUwSTlwRnA4ajhLMWxzeGZmU3lU?=
 =?utf-8?B?d09nWGY4NWROMXNaVjJPZm9uUHNtV1ljWUREQ2xGN3RKekRMbFZRaDNIUjc0?=
 =?utf-8?B?ZFFjRUUwMDdFK0Z0TnRFT1o1MkFhZTF1VUczQTRITW1rdzJvbTEybEhaQkNz?=
 =?utf-8?B?N1BiU3lwdlhLSXhtMzJEd205Ung4Y3ZMZ2VsNTJsUCszZ3ByR0E2SnkvRzE1?=
 =?utf-8?B?cFFvMGlOdHlJNytIbjVEV1BRTkxWNTBNbG1PSzZmWWJIZXRiN2hjMnpJNVlz?=
 =?utf-8?B?VFRiUVZrM0k5UStyV0tacXBUMmdDWDNRMDh4akllU3dzSWJ5ZTFyU2dxWFBU?=
 =?utf-8?B?azdBZmdjU2NLcjhKaFNGTStLZm9POVBPakY3cTloTDNhUEpmcWZhdzdidjVG?=
 =?utf-8?B?WE8zUitOTjV3b2pxcnpNcFdUZ1pKSW9mcVZ6a1B0WGpVYzhwSkFZQWRNb2FH?=
 =?utf-8?B?SDA5SURINXNBa1NaSVJockhZWU8rRzBUMkFVdUZNTlBqVFhUWXRtZUxkZEVO?=
 =?utf-8?B?T2tlbXRVZ01hUUdhcU5aVHJSaTYwemZiRUVxUk5IYTVIcUR3ZGVhOG9yTnQz?=
 =?utf-8?B?Rk9IT2o1Nlk1bDRyNXJ1UGZRN25YWVVsa2hUY2hhekZLdnlocTIvbitsd1o2?=
 =?utf-8?B?bFZHT1R5cmd6NnN6aUpNRUdTSkZpRTJCUWcwamNSTG1hT1JuZUFJUm9YTGxI?=
 =?utf-8?B?cjBUVnMycDNjY0JoTWpGYlppMGRYRU12MXg5R3BsTkpQeU1QRHNTejY1QXlm?=
 =?utf-8?B?cy81U3dGN0Q5SWIzeGpLUHU4SjF6VHpUMmUra1FQVGQ4d1g1VXJNZ0l3b2w0?=
 =?utf-8?B?bHVQQTZ6U2wzQ0pwSE1iRSthUjBra3BsTkQ2UVFmYUZEeXIrSWRhU3o1dmw0?=
 =?utf-8?B?VTBoSlNoK2N6dlpvNHdCeVBSWFpyZ2VVVFhoOGRNS1dVZ3JSUy9qN3BGc1Zr?=
 =?utf-8?B?VEVZazlCQXVIRit4QnFwUVFWeDAvdDVrT1IzWmpEYmphRWlrUEJGU08wQkYy?=
 =?utf-8?B?eFpWZFlYTW1DbGJHWGdVVTBTNlBQUTY4MGR3WXBNTW1VdFdERi84T3k0WlBq?=
 =?utf-8?B?M2dkcWdZUENkd0k1TnNCOHBrMmxOWThaTEZ1VlBoNUhqdFJZck9EcHFWVFlF?=
 =?utf-8?B?U0tWQTIzNWJSb0VOZEdRaGEyUjZrTkJ2blFrRXAzWDlqS0tvMFYrSHFMd3ho?=
 =?utf-8?B?RkJ3THMrV0lnR0dYL3dZd3VnOTRYU1lqWXpSWExvT3dZNnFmVEVlY2dmQTFl?=
 =?utf-8?B?ZEFPYnloRnBoVkN4aDk2VnJIdTJ5dURjTWN5YzBlbjZzclNDZ1JNREY0U2Yw?=
 =?utf-8?B?aE9GNjFkTm9rQmoyc0pYQzlycFRSL05QU1hXUjVTMmFoVG02TCtJdGllU0p4?=
 =?utf-8?B?T1EzSFJhSGo4clNKMWFPVFhnNVZpSmVEcFVaMGh5ajVTc3dINUZ2Q2d0UmEv?=
 =?utf-8?B?WWlvNlluL1hNaDF0ekphajU0aDN4bzNxZ2FzZEFLUFNMTG9YRlpJVjhMMjRw?=
 =?utf-8?B?YXdGWGIvckxXdjNiSE80Ymgvc0ZaSG5HbE85RWJNWGNuSURLeUw0bkw5aTRo?=
 =?utf-8?B?czdkdk95YVM1cUI2bmRVYkg4RzM4Vmt0RmhQU2o1bjJ4MHdiQlhLdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3a81d5-3b4e-45c8-cc10-08df4b185889
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:20:04.9434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sGfBCrpCpmxj64J40fr6S59SVJNe+EvgMRN7YFN+yVPVxiDctzBkmGgQP9mGHHlxcdVaGr2xxyNDVuHMwsmHQVNEv5rbAfbCIfc7kK9B54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9648
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every
> pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so the
> .rela.dyn section ends up being quite large.
> 
> Modern toolchains support packing relative relocations in RELR format
> via '-z pack-relative-relocs'. Instead of offset/info/addend tuples,
> RELR stores a stream of 64-bit words. An even word is the link-time
> address of a word to relocate and an odd word is a bitmap describing
> which of the 63 words following the previous address need relocating.
> The addend is the value already stored in the place.
> 
> Compiling for QEMU with RELA vs RELR looks something like this:
> 
> $~ readelf -SW u-boot  | grep relr
> [ 9] .relr.dyn         RELR            000000000016f970 170970 000960 08   A  0   0  8
> $~ readelf -SW u-boot.old  | grep rela
> [ 7] .rela.dyn         RELA            0000000000115110 116110 0184f8 18   A  0   0  8
> 
> which is ~98% decrease in the space reloc entries need.
> 
> So let's add a Kconfig option and teach U-Boot RELR.
> - pass '-z pack-relative-relocs' to the linker and add .relr.dyn
>    in the linker script and the objcopy'ed binary. relr.dyn is still
>    overlayed by .bss
> - skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries
>    to be packed in .rel*.dyn and older tools don't decode them
>    properly
> - process .relr.dyn in pie_fixup. It's worth noting that efi runtime
>    relocs, due to how ld emits RELR, are now packed in .relr.dyn and
>    efi_runtime_relocate() doesn't have to relocate anything.
>    A sideeffect is that we can't support  SetVirtualAddressMap and ConvertPointer
>    for EFI, but some architectures are already ommitting this call
>    (e.g Linux on arm64, openBSD doesn't call it at all). [0]
> - process .relr.dyn in relocate_code(). Note that the places are
>    link-time addresses, so we still need the link-to-copy offset to find
>    them, but the stored value has already been shifted to the run address
>    by pie_fixup, so it needs to be adjusted by the run-to-copy offset
> 
> [0] EFI runtime services relocate themselves when the OS calls
> SetVirtualAddressMap, using the relocations between
> __efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collected
> by the linker script from the .rela sections of the runtime code.
> RELR packing, however, is done by the linker as a last step and all
> relative relocations end up in a single .relr.dyn section for the entire
> image. There's no way to emit an equivalent __efi_runtime_relr_start
> marker for the runtime region, or emit RELA relocations for the EFI
> runtime, so stop advertising SetVirtualAddressMap and ConvertPointer
> in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.
> 

6.4% size reduction for u-boot.itb with RELR enabled on 
tiger-rk3588_defconfig.

$ aarch64-linux-gnu-ld --version
GNU ld version 2.47.20260726

from Fedora 45.

I reached U-Boot proper CLI, which I have been told is sufficient to 
test this series, so:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger

> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   Kconfig                        | 14 +++++++++++++
>   arch/arm/config.mk             | 10 +++++++--
>   arch/arm/cpu/armv8/start.S     | 38 ++++++++++++++++++++++++++++++++++
>   arch/arm/cpu/armv8/u-boot.lds  |  9 ++++++++
>   arch/arm/lib/relocate_64.c     | 28 +++++++++++++++++++++++++
>   include/asm-generic/sections.h |  3 +++
>   lib/efi_loader/efi_runtime.c   |  9 +++++---
>   7 files changed, 106 insertions(+), 5 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index c8cfbf5d5de2..ebe7b30d7b78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -40,6 +40,20 @@ config COMPILE_TEST
>   	  here. If you are a user/distributor, say N here to exclude useless
>   	  drivers to be distributed.
>   
> +config RELR
> +	bool "Use RELR packed relative relocations"
> +	depends on ARM64
> +	help
> +	  RELR stores relative relocations as a stream of 64-bit words: an
> +	  even word is the link-time address of a word to relocate, and an
> +	  odd word is a bitmap covering the 63 words that follow the previous
> +	  address. This usually leads to ~95% compression of emitted relocation
> +	  entries.
> +	  Due to the placement of the .relr.dyn section and the way ld
> +	  creates it we cannot currently relocate EFI functions at runtime.
> +	  SetVirtualAddressMap and ConvertPointer for EFI are marked as
> +	  unsupported.
> +
>   config WERROR
>   	bool "Compile U-Boot with warnings as errors"
>   	default COMPILE_TEST
> diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> index bce9a31e966b..ad73f728f7a2 100644
> --- a/arch/arm/config.mk
> +++ b/arch/arm/config.mk
> @@ -111,6 +111,9 @@ endif
>   
>   # needed for relocation
>   LDFLAGS_u-boot += -pie
> +ifeq ($(CONFIG_RELR),y)
> +LDFLAGS_u-boot += -z pack-relative-relocs
> +endif
>   

suggestion: make this transparent to the user

We've talked about this in private but wanted to put it in writing so 
it's available on the mailing list archive. I think it makes more sense 
to always enable the option (if it's safe!), if the linker supports it. 
According to 
https://rfc.archlinux.page/0023-pack-relative-relocs/#motivation, that 
is GNU ld 2.36 and LLVM 15. We can use the same mechanism as in the 
kernel, c.f. CC_HAS_UBSAN_BOUNDS_STRICT with def_bool 
$(cc-option,-fsanitize=bounds-strict).

What I don't like about it is that if it's default off, nobody will turn 
it on. If it's on and we force the option like in this patch, then 
builds will fail on older toolchains. I bet most people don't know where 
to get a newer toolchain than the one they have from their distro, or 
how to install it so lots of headaches for people I guess. If we stay 
with this solution here, is there a way to tell the user how to fix it 
(either via a Make message, or at least a comment next to the places 
where we set the flag?)

Cheers,
Quentin
