Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145B606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qI4i07Nk;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I/98hOuI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0BB261025;
	Fri, 13 Nov 2026 11:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crt4-uEzfEBg; Fri, 13 Nov 2026 11:52:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8957660F0B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794570739;
	b=TNiLR2nMSFkE+pUAAcUQ6cPCD+fLZjxUQdRZyqy5oetTwgmw3CoP7qyvkD5GduxxaA6Y
	 jSewVX+lfWlD8vSYJaW3Hy+QbkGySnDHE0gmqUq2TqTRbT6N16k6VbaABMXDgrFWl5Vyz
	 yzN2df+GzEh2RAoCI53Bx9W0nqpiiOZOAhqscSrWyI9RDT3wI4StVGS65OTl/rcDQlItA
	 UFr+NC2SSgPLnTEN9sFVlceom9LH6F9luqXwsVYc+43o1QdcXuOm8hGijQ0qdGhjEmPrT
	 6KgHWIWmKFtvErb5/h3IcRuYtGqsWBIoraNFS7S14vVORLmfKFWlXuMqQ+eQhwLfqIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794570739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=diUD4b3A15oMwwynbIk+jYi3C52aogqRrEwZzK7u5NA=;
	b=OPRLbe57+4wT4Y31LGxPUwhHGC57O7OHvfte+y6gOVo4ZDDd5/fstKadaL7ADxydVBNB
	 cuUYOeVT2lbY2blfDez0Ja6Ru/XKBhOc/F2rpiaMaX9og3z9PeqG9KZgN9MCLfgR6SvOP
	 YmdRUa1wVa+DrpDzZ0H5g/DDfm8uawGl6sArniZdhla5J14kcmCkdD5M+W+jE0z4+DzXS
	 zomtupjev0yV1xMWpx22lDc9rDVCVJiHK9bQ/TVEzuMabt21fApqbCUEEPCb2IGaW0fq1
	 19gefkWFORz2Fkya3qSkGaK1V6UVw0sS+OOOJfqGCifEKRedTW0oHfTHQ1Ot/w5QWZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794570739;
	bh=diUD4b3A15oMwwynbIk+jYi3C52aogqRrEwZzK7u5NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qI4i07NkGDEYKtRLNtL6TYas22irJOCBR9eNWi1O0x6Av3tR6+OpAUzWQq7Z2AC3w
	 RSDZ+vOHiQrwx4YHg1rejdXTa6ngVQtw9ghV0UD70rd9a/BlIiEKfvZT5HBpbwBv77
	 A4J/DBLcqFmodKLdgxFxAsguV5pe4em7Z18gh4JsadCUucB17DkIkzclz7tsvPj/ou
	 znAY/cKDGK5HnxdEgmsKHtsM/dKABGExSPAxLWI2qclFo0tzonyillvbYAxGWa35WK
	 uu77mcQI9oV8ZO2trP/nKoS134N9UCM3Upmfr9Q6jsGzDKUUbVnnVti3EP6G16xYhK
	 u5Bd/p75/3MTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8957660F0B;
	Fri, 13 Nov 2026 11:52:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CB9028C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E5AF81495
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqF8WC9w0PUQ for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 11:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7601181108
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=I/98hOuI
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7601181108
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diUD4b3A15oMwwynbIk+jYi3C52aogqRrEwZzK7u5NA=;
 b=I/98hOuImZo/qwdJGvWZFWs0vvUQ4RzX7W8TjQljalf1Z6VMVEGtB3WnohzVhfjSGwzc56mXhnEm0RI4yHZXvKzf7UGypv5y2W6Q0U1W40y8bVwrq+upq185EHXzt3XJ/wVGDR1IjHODbY502zFRLpKhvaw0hUO1kJAZdBOt2hk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 11:52:04 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 11:52:04 +0000
Message-ID: <6f7c23dc-4c39-4b00-a330-e9350424498a@amd.com>
Date: Fri, 13 Nov 2026 12:51:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] net: zynq_gem: fix resource leaks and shared MDIO
 bus teardown
To: Graeme Smecher <gsmecher@t0.technology>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>
References: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0173.eurprd09.prod.outlook.com
 (2603:10a6:800:120::27) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 189c86fd-ebb6-4370-deb7-08df417c88fa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|261102124527099003|56012099006|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J7Qwdj3N1Wqp6PhYMPKYRzMQKFN6yX5ykvKpM1PQc1TqtIFcgBbNNYczqqrCSAusuOhehrEfzhij2z7KGV0Uy4CyWkWsxpgEuooLBH/GnDuymdbhJfbzMZVYy46C3DPwMQlgJRhZz7g7mDK2Z3DsxhQmxvTayoziHrAiaVjcm6WoacO8Uuu0tyAglr2ZrEXZJelhH9LHKEvyFxYQ/IV7/zieRYbuyLSYytfnsBzSWbC5jahmy5BDnxZKT0swEFQEKfIPOXerd2Xjj80La5dqD2MPzNAiiBwnyKTOaYPTpcu01H4HUW0ogcJi7ShrwL9jRc/T2Qr5WvFZ6g/iM8hus5ltov2zBobn4bOuuvM6eL5W3v0QNekeAlTbJzcPUvr9bmIciyzx/6FMypDAatqe/GX1o9lz1/CTDb3YUoVxP8mXqa7WU/nKHwu2yBnaN5BfZh2v2e+vFahZCIlDNfk210hRoDObD2M1w4NMaWWXdth9nwgqhzqhJj53jZdNWuNokFPwLloJakgq3M7IMriMZ7Z7jomQufVApQtdSuW0bZsbXpVD4CUkGdaYl+sxQDAW1veOlARpZOsgB2mfnlaQsgXZKhtus2831/7FHX3TnkmnyI8DqnRtzk0IlGL4QYZr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(261102124527099003)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJIazd2SEZ1OElkVklzck82OFJkRktGNkRXeHpMUzFoTVNzdDUycXVQM1dQ?=
 =?utf-8?B?NGQwKzRkaksrdWd1dnZwYUlBK2FDaHZXaVdpbDA3OURtNzBJaWFKeGpqa2ZR?=
 =?utf-8?B?VEowV3ZiNHNtTEN6N0xLNWlFMEQzL2RCNFhOa2E2cGxPY2RtYU5wR3RmM05V?=
 =?utf-8?B?RFJzNGV4T1RsR3B3blIwczdWNERTNVZqQTV2SWh2Y3ZJYVo3ck4yeWxOcFJM?=
 =?utf-8?B?d2szVkdFUGNEWkJ6MzBDbE81RTNzdmRZcmkvck5vZlVhMmZSNFoyUXNIY2Vi?=
 =?utf-8?B?RHBrekhucTB5bnFjUWlPUnNobk5TMjJTdldldlpOc1cvRFpnSExpR2NQUzdi?=
 =?utf-8?B?YXg4L1RSN0MzNVJYUWhNOVN2QWZZT1g4bUVnYWw0K29rVU02SlFjRy80cjNQ?=
 =?utf-8?B?LzQzTEZLNGpMeWNGbmVaYXhoNkd2QjdMSk5uU1NRaFcwVUJaOEtLcURJZ05K?=
 =?utf-8?B?bmZHdFI3VWlRNzdQNWs5Tkg0anVTMnZNYWlDWGJyRm9WdFRodkRFby9INDRP?=
 =?utf-8?B?QnlQUkgrSm9VbzdMZTNEUVpXZlJsbFdDZmFDWjdWN2M5TWRYeHNjTERMQStZ?=
 =?utf-8?B?ZEh1dkdzM1hEKzNHN3dUZ0JVUEVmeXFXOGVRMFMzdU53TmF6bFJ5cEVBMDFX?=
 =?utf-8?B?c3A3UElxOFVUODFBRUxxaWNvdi9rYm1wdElUN1dFcFJJUnJDaElkRnZnT2VK?=
 =?utf-8?B?SUtVN3BUbGhmVUFuYjI2ZU96ZDhzK1Z2VFYxemlhMXAxWXlPTnVUMnVUVmR1?=
 =?utf-8?B?VXFpT1k4d1FyaS9Ibkk2OHRNOExqaXRqZyswUFpoTXRoQStyTUVjczEvd2JP?=
 =?utf-8?B?QWNpRWRNbTJsR25udE5XK1hYVy83VFIrNWZBYU9hME9jcFQ2NnZPYm5sLzNO?=
 =?utf-8?B?My9PRDFyN0pMOWkraTI4T2JiSHlqRVZ4Qjdjd0x4eUQzMkR6a1YrdFpZVWNN?=
 =?utf-8?B?ZGp6R2RRL21ZdUV0QzJEKzkxM0JWaXpqeDJMSHBJSkJUWkNCbThrd1E4WkdZ?=
 =?utf-8?B?TW5sSDhROWFwWDZNM3pNVnVPRnZISG0yaXBVZnJnaVRRVFBjaVN2M3BreC9L?=
 =?utf-8?B?aTRZSkJoZEwwSktET0szZmttemxUUXhDZEVNa1NLREwrT084ZTJ0QUg3WHZu?=
 =?utf-8?B?WkxoZWxGbUVURHpKVVFHUFNTREdKRUx5MTlhbnZiTGxCclNhek1iMWFHci8y?=
 =?utf-8?B?N2VZaUtEdkd2ek5nRG1FZDcxRGMzbE5RRFhSbkJuelY1Ky9tVkdwYzliSkY4?=
 =?utf-8?B?U051bGlKaVI5QmQ1ZHEwcFNLK1duRVFjRkJRek1CMWtyc2I3bnlyamtMaG1a?=
 =?utf-8?B?UjNTU2owY25LU0lMa3V1ZlRaMVUwVFVmanQvaC85eWswM1JSd3J0SDB0bnBK?=
 =?utf-8?B?bms4ejhlWVBQSWcvanJQcHVseXp6SDlGNDdPZy9DNzlYMzNLdUcvbkJxempY?=
 =?utf-8?B?dzl1Q1FGcHNhMW02Z1dZc1NHL24zUjBZUG1lSTFubFVrSGhoT3d1c0tycVVZ?=
 =?utf-8?B?MTdqZmhpS2I3U2lPUDAzRGFBeUU2SDdDd3RTVjlBajNTNjlENlFmRkpJZEZV?=
 =?utf-8?B?QzY3SGdMNzlQMmFCanpLZ3VnMWJlRW9uVm1oUVYvWFJndEdUM2VRbXNwaEY1?=
 =?utf-8?B?cEVlK053Mi9UN21kc1ZrazdvNDBZYzY0RDlaK0R1TTZaRG9YMDF5S3JDV3Y1?=
 =?utf-8?B?aHo2bnR6WlVUNjBkZGpxOGdmaDAxaXJxV3BKWTVhZEEyVFd2a2p0MmpjMkJ3?=
 =?utf-8?B?UUVFMm9WcERCb0svT3NzNU4xV1NXaE55cS8zVGhCcFlTLzVma3lua0NGWDZi?=
 =?utf-8?B?L25oWUROaEFMRDh5U09kcllhNDFpQStoemw4amR4dEp3WDN5bWQxZ00yUnBl?=
 =?utf-8?B?cnU1RGtlcERJUlNUOWJaNzlBeDBWMG4vNDIzZjRzMFFTUk1peUFEQjZkU1po?=
 =?utf-8?B?TVBHUVJwY1lmQzhqeHdUTDlOU2pRK3dyeVlzMXVBNVg5S0k2NHdHT0tPaFJY?=
 =?utf-8?B?VkJUQzZVRkZaMVJjamV3R04xTHFVbk84MWpiUm9FYnQ1SnI1Z3dIWmt3WmJp?=
 =?utf-8?B?V0QzWkxtQTNaRGxsMEZoOXZwa2hET2FSZEdvRU5uVm5KYkl0K2VNeEQ1b3c3?=
 =?utf-8?B?K2ZBU2Q1dmpzeTE3WXN5UUJEWVU1N25RRlpBMWpOZHludE8rbmNwL3p3bHZk?=
 =?utf-8?B?ODVrRlFBbkJVQTZxaDJBZjhuV1FBRURiUzVSTmpsL0NDRkM3SGNaSC9EZTdT?=
 =?utf-8?B?RXlkYk1rbTg0OVFXbHBFSkd1TDNaTHVOZlI2cjRaVEozR0Zsa1pUbm5HY0dI?=
 =?utf-8?B?VUVsTVdVVDBzTCtSVzVlSE1zcDRnZC9xYkNtbGVhMDZUZTBmc1FuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189c86fd-ebb6-4370-deb7-08df417c88fa
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 11:52:04.1860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY3GOnHrZJDcYp7dphtJzpLSo+V+5K7y2H1Xqo600FkLUY355k1+LHKZwvLxUQ8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 18:09, Graeme Smecher wrote:
> This series fixes resource leaks in the zynq_gem probe error path and
> remove(), and stops zynq_gem from tearing down an MDIO bus it does not
> own.
> 
> Patch 1 stops zynq_gem from unregistering/freeing an MDIO bus (and the
> phy_device on it) borrowed from another controller via
> eth_phy_get_mdio_bus(). Patches 2-4 plug the probe error path and
> remove() leaks, including the SGMII serdes generic PHY.
> 
> The eth-phy patch (4/4 up to v3) is now sent separately, so that it
> can go through the net tree.
> 
> Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt) with a DT in which
> gem1 shares gem0's MDIO bus and PHY. These runs were done with the
> eth-phy patch applied, as it was part of the series at the time:
> 
> - repeated unbind/bind of gem0: heap usage is stable. Without the
>    series the remove() leak eventually exhausts the heap;
> - unbind of gem1 (shared bus): gem0 keeps working. Without the series,
>    gem0's MDIO bus is freed and its next use data-aborts;
> - injected failures at each probe step (except the SGMII-only ones)
>    for both gem0 and gem1, followed by a successful re-probe, without
>    leaks.
> 
> The SGMII generic PHY handling was tested on the same QEMU machine,
> with gem0 set to phy-mode = "sgmii" and a nop-phy standing in for the
> serdes (QEMU does not model the PS-GTR):
> 
> - repeated unbind/bind of gem0: the generic PHY's init and power-on
>    counts return to zero on each remove, and each probe re-initialises
>    and powers it on. Without patch 4 both counts climb by one per cycle,
>    so later probes never reach the PHY's init/power_on ops;
> - a probe failure after generic_phy_init() (no PHY at the phy-handle
>    address): the generic PHY is exited, and repeated re-probes start
>    from a zero init count.
> 
> Changes in v4:
> - Rebased onto current main
> - Drop the eth-phy patch (v3 4/4); it is now sent separately for the
>    net tree (Michal Simek)
> - 2/4: keep the SGMII generic PHY in priv->serdes rather than a probe()
>    local, so that remove() can release it; drop the zero-initialisation
>    of struct phy, as priv is zero-allocated (Michal Simek)
> - 4/4: new patch: power off and exit the serdes PHY in remove()
>    (Michal Simek)
> - Link to v3: https://lore.kernel.org/r/20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology
> 
> Changes in v3:
> - Rebased onto current main
> - Split v2 1/2 into three patches: shared-bus handling (1/4), probe
>    error path (2/4) and .remove buffers (3/4) (Michal Simek)
> - 1/4: also only free priv->phydev when the bus is our own
> - 2/4: free priv->phydev on failures after zynq_phy_init(), again only
>    when the MDIO bus is ours
> - 2/4: call generic_phy_exit() on every error path after
>    generic_phy_init(), including the early returns after
>    zynq_gem_reset_init() and the rxbuffers allocation, and
>    zero-initialise struct phy
> - 2/4: use descriptive error labels
> - 4/4: rebased onto the eth-phy reset control support; also release
>    the reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
>    guards, and reword the subject accordingly
> 
> Changes in v2:
> - Move mdio_free() out of the mdio_register_seq() failure branch and
>    into the error label ladder
> - With CONFIG_DM_ETH_PHY, priv->bus may be a shared bus obtained from
>    eth_phy_get_mdio_bus(). Track whether we allocated it and only
>    unregister/free it in that case, in both probe and remove
> 
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> ---
> Graeme Smecher (4):
>        net: zynq_gem: don't tear down a shared MDIO bus
>        net: zynq_gem: plug resource leaks in .probe error path
>        net: zynq_gem: free buffers in .remove
>        net: zynq_gem: release the SGMII serdes PHY in .remove
> 
>   drivers/net/zynq_gem.c | 70 +++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 47 insertions(+), 23 deletions(-)
> ---
> base-commit: 709a97a05df66e394f40d249105d0baade46f107
> change-id: 20261103-zynq-gem-remove-leak-b2b5afccebcb
> 
> Best regards,

Applied.
M
