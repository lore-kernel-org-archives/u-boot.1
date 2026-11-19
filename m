Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2691606A33E
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eE8tf2Pz;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=NGBf0nZi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BD9560DCF;
	Thu, 19 Nov 2026 17:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFMeVvsiByTe; Thu, 19 Nov 2026 17:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6E5560D98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795109200;
	b=odJXA6PwnWudX8wb3DQ5UX903FBbBBeZjS1a07bHqhxL1Mp3S/ohQVvT8L2VHY0fWFOQ
	 /+Xep7WXeHoqHm+dMjk08OcvD0SYsMsisIe5yxpwk9BVRcGNpKg4N61aCNFu9SL7FqTzV
	 j0GAyC3KPHXgHAmeRq8nvSi9fT4/53mPLHyDkQMUnmmfT/htc75/ZAJC4xC5SXm96NaVi
	 4E+eMLcf+6S/VpEvzdG1O9r1KaDKdUlmPDTbFhjtcYS0HTvX0x3x/4EyyRy5uwb6tD/mS
	 FSWSnMexYwpGsJ2po3oUbEbiUd7B7kWeUB+xCpqiPAIMYyNEhWsrEFqNK6hhzy57yPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795109200;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fb93/wAtqAi9npRNr9XHmyQ6N9rRSe3cZMG4CzgcnII=;
	b=Z4aclQz/18OJppP/WLEaNd8VCupwWhI0kDfUAGH1vQKI+XXVMiw80Z9/z1NBRy0hHrKW
	 trWxWo+K2Y6VMu0XwFhKk8Ug9e2PHEDQajOwO0dCCPoaMplPKbcLANN30UFJHfg7bljdA
	 JyFQr4T5IjCU8uBD5+U7hujo/O8u+tRM/gSShSpaipckZrzzEvlQZlQZaAhzf7UEwjta1
	 LubDFzgrNER+BQXKlNqcMwbn7aib+Z2dL9vBWh+qMMybv0qEYa+6NTzoSJsxOEnXpMSFf
	 g0wgBloNs1Nkt5ciLr5YTsBwL9Zxp7zp/EEmbsqaVaMtXVM7qPOLNDF++eTqSbBGj3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795109200;
	bh=Fb93/wAtqAi9npRNr9XHmyQ6N9rRSe3cZMG4CzgcnII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eE8tf2Pzyj0JSXan5uJGRGIDxutatoRSg5sl7KzDNPEEIEYfm9WV/D2X9UEQPkmQQ
	 wJNpeijBfnt2k3lTKgxtZBRx93RQgD3pbZXAlRJfymgUp9QcpRd8A0brYTMAUznBad
	 n/C02l0eByKYsAu+jbKuUJpmvVtluz2vFD7boS1YxTo0iCrPC5Sqv6YvjiccMFfxgC
	 t8BC1hpNJbx7QnKFQJreRGginHGNXxFsL5tqEB9t/jPGeUfzMAl8cmo339fpGjLS23
	 lNnTQdCG+YBmPq5pXSRyPr9gSsYTyv/bpMgodGOMIlBNoqUdRHdIoNiO9BVDEb+p03
	 PEwcYmqVCXcKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6E5560D98;
	Thu, 19 Nov 2026 17:26:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 965C22FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 886CA81464
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPfD8sijwLIB for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6ABC81396
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NGBf0nZi
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6ABC81396
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb93/wAtqAi9npRNr9XHmyQ6N9rRSe3cZMG4CzgcnII=;
 b=NGBf0nZib9r3TByZACN3OFhb8j2IgzpJfVvceT6K0ocNDiaeEJ8EsfzCpHlgL47TfncdF9dgiTv/7EistYjSBHf5Gc4URgwlEg4nAdF8sujMC/jYVsWD9ULaamiOnJ6E8IyOOZERLaBtEHWvaY/IpefSiB9kqgzxnGN6TjrcpFg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7751.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 17:26:35 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:26:35 +0000
Message-ID: <2ff40d1f-71d2-4326-b62e-cab7ed37295a@cherry.de>
Date: Thu, 19 Nov 2026 18:26:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] test: Ensure ext4 file system is truly clean on
 creation
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-15-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-15-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b14408-1ccf-4a72-f5b4-08df466242bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|261022105027099003|10067099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Uw7ridEYyMOWV/xZYEMiuPX+MvgceKSXcXSPyx05+B80qa0vTxoo8Ncrg4hmmTbODvHWaD1s6CuYR/g++pFY0U1k0egPq8fNc9IL6jHPe6Xjh+/xfcNM2XuZ+BHO96+2MbeOArHl/7wr1+wpUywMhEjOYY6NHmYTuDKGpods9yFTV66yPGzQOe3IieJGJQ3gECew8wHXfo2NqHTMGngW5R0C6s5lncE9hBD+YXYRMdevgkiQcUwA730NK0/KWNVL6Rh14HY0Rdfiq+nSQYAyURPFiNGoOQCKcSEpPv6COG8tckYiUuX9xtobYdePM8RfflkOHDW4v0Wdq42JCY5VYu4myhk7DSSgJGms8v4b2k/g9i+oec9HSyEu4aNIeRmrFCpo6kUrIk0WnKWTjwkxSZHv8HaCBaObPYH5eCO29zdA6V+EmqvSAK7Jr43aYHESOqNQ3IF0JNM4DWBMYC7FBD1GnA0XESTJq97BmP0AyqkJkNz0MMWJymytmXMYV4TxKpv5XERA4MQyY3U9SRMJ3NSRcLIc3J2D5KfnB0/Lgt5a6t+VOLoKRhKlLv/XXcZ+nP2AwW0jnA3U2Iso+v2aKAMuuZi85Q7ekDO+fltJNtbgGKgUCZa0s1AY8m7+bKYn/QGXGuOLK2aR5U5CqU13LXbTCRHU1VL/c6CFh+0p7pY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQ4L05xWmUyd2FQc3VRWXczKzFsQWlrWGhWejAvd0E3bTdNSUFJQ042Q3VY?=
 =?utf-8?B?cCs3VlI5RU5zYllPcEdXK0ZGUURvamVGdUxPUXFMMVBoa2VNVitHdms4RFox?=
 =?utf-8?B?aTFKY1ZFU0dLcFBzOTk0VmhaaXZHUXNJTVUrbmRZbExBY29HK0wvQjRIZnNS?=
 =?utf-8?B?eDBQc1lHWUR6THdDcFhhcGVuYmVsdXB2NDVkT0xobjZROUgzQUlGemtlL29U?=
 =?utf-8?B?NldYQ0FNU3RxbUV3aG1GN2xBRHFPdmZSWW53U00waDdNUWNheVNmbFhJdFJy?=
 =?utf-8?B?SHQ0dFJMVTk0c3NsdkVhZEtNMFZDbjJwQ1BFTVMzcE9tbW8yTFpEcVhGNHNr?=
 =?utf-8?B?RHdMeHNoWGxDMUJVOGUyMXNDb1Y0QzQxVDhlY2x3ZzZxSmhaZitGOVNiN3d4?=
 =?utf-8?B?VVZXQVkraDNBbklpYy9RKzVaRUZsZ0dvakhwNGN1RldmcTlUU29mblpwK3lr?=
 =?utf-8?B?Tldta2pUeFhJdW5ZT2JaTzAwMm16RFBzM1RlWFgzd05oN1RYdS9iaWkwMU9s?=
 =?utf-8?B?Qisxd0FXTnZDMWFiUUJQbXBNdjUwbGFtNVlPcjk0ald2UkxvSTEzMk1VdUV1?=
 =?utf-8?B?T1IvMnR3cjJzZzk1TmlYK2lraC9wM3Z3TUcweDBBSlJNN2V0M0k0YjVxUFU5?=
 =?utf-8?B?NU1EMWJ2UXFCWlFtZzZTRVdHem96UjN2ZW1PTDhidU5OcDFMcDl6bHptMU5M?=
 =?utf-8?B?YTg3b0w3Y0ZDWWhKenB3UXRVOGJHSkM1WnJYdXNkSkNuakFFVVZRL29vNTAz?=
 =?utf-8?B?WjdTTGZ2aVUydy9rL0lFZ1Jkd3JPbUIxK2pqOGU2emljazF5UUhuOXNFOEg3?=
 =?utf-8?B?a0VTUC9ha0FxeXhHU0d1RGpZaFk5dnhoK2k1eVVSRXNxWXlaY0cydnNxZ3BU?=
 =?utf-8?B?RjFCKy94a3VBVFJqL0VBYVVvUkppMXpPc29Yd1lkNTVGbkR4bDVmaXM1WHJz?=
 =?utf-8?B?ZUxFMDBXZmNETGtkZEhJVUljZ0d5a2VRYzRiREhtbC9wSnN6OVJhNXRTbjlD?=
 =?utf-8?B?T2pjSzVpZUxCU29oYkFvckJvcWp3M3Fwd2d5KysvQkVSUEVoSFZnaHg4dmdM?=
 =?utf-8?B?NXRCRVl2NEVFNFpSY0FhcFVBUFdqMnpDQzh0NVJ3WithNFNTVUlDWTcxWVlu?=
 =?utf-8?B?R3NRRitOTlRzOTF4M0NuVTg5a3NCZGhPMUR2dGpVY1RsUTVlVnpUMWZZTllC?=
 =?utf-8?B?V2xTaFZkRWYvdStKQmNya2FCSmtGTmJqaVdNbldYZGlmclh3M3J2bTZ3RXpi?=
 =?utf-8?B?STY4Z1Buc01iZEV6R1VZejVNUHNlRTkyU3M0ZVdRcDdnblppR0pXVEtDbjg5?=
 =?utf-8?B?YjlIZUFVVy96SFRrbHp4RkJNa0NEc1RhQkhQay9LYVl6b1dtS3NOT0FaZ254?=
 =?utf-8?B?SENZOUhKMnA0UWhjczY0a3pVenpENXFCVGovdDlYMHpKNm9waW4wbHhVSkxo?=
 =?utf-8?B?YVhYdXdoSmFVVm9NRUJJVWhPVTZxS0NkMm9icThDbUluM1AvMzd2STdXOGhN?=
 =?utf-8?B?angzUnBvVis1VWh2OWZLL2c5WThFdDJ6WERlNElXVTNjUGpGWjVjRHhxcUtE?=
 =?utf-8?B?NXd0TmRtQ1gvNDBqU2NWTnRkUWpLbStnVzBRZzZHaVpvNHIvRU5lcVAvUzlO?=
 =?utf-8?B?YVhsUFdMT2RKQWpDMjhqN0c5b3dPY2hibDZnbGVOMHA5NHpmWVpVa0lzMEpp?=
 =?utf-8?B?QWlEamsvRXZ6Ty92TlJWUlp4Z20vRWh1d0ZLd1F4ZHFlaldoWCt3L2VZbENx?=
 =?utf-8?B?NHNuZTA4a09PVysyYjk4WkY0RVN5M1h4RXd6SGM3a29Uc0RZSnZBclNwVVZ0?=
 =?utf-8?B?NzRCTDB4Mitkd2s1aHVBK3huT3pER1F3bnQrOEhKUmlTS2hEZkVwZGNpMkMr?=
 =?utf-8?B?eFFLNzBzS2lKVlJBSHRjV2FDT3NHYk1YKzhHN0w1eWRnUkQ1R24xWDd2Wk5h?=
 =?utf-8?B?QUVyRkZ1ZWlGMXhnRGU0b3NGRUNsNkRFRnZwTzFDUWlEQ1ltK2oyUENIMGNX?=
 =?utf-8?B?SStmV00vN2R5MlhOemhuaEg4c3NFZHV3NmJaSGZBRFNZb1lWN1FqcE9vMzFP?=
 =?utf-8?B?MFVxWnNsekkwZ3hRZG5nTHpBZ25STXhkRCs0M0lSRm44YkZKNzUrcVpmV0FS?=
 =?utf-8?B?TVZlQXNXaWhjVllrb0d1WldiYkdjMGE2MG51UE5OSWR4TnA2cTBoQnZtenNh?=
 =?utf-8?B?dzNOM1Zod3p6ZHB2Y21uc2R4a1ZnTDZBTnRTR1Z5d3MzWTdsaGtzTytEWVZQ?=
 =?utf-8?B?N2s3d0ltaSt0UkRMK1gwSnBNdXlXUnZMbWxLckNMUk1HTXVKZEJKeWQ4OGR5?=
 =?utf-8?B?Q2p1ZENzSFpUdVU0SDFLYVZQdGNHbURZWCt5VUs0U3VVY0lSSk42aEdYeTE0?=
 =?utf-8?Q?3vUsQTx4h4rULdaarSo3hEKF7ZQzw9rOMRe4tb3bBAVrY?=
X-MS-Exchange-AntiSpam-MessageData-1: Uf/kNB8qfemhHeZ5kiZVxuEMbaevEYdHy7U=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b14408-1ccf-4a72-f5b4-08df466242bb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:26:35.1696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DUZV3kCgCvEvUumphVQ8XhTyPM8hIXLEYcnpZlBg3rhjJgTA4q+Y3TzDpX2uqNxqfx5hjsG9jS/tTc+hdGXt9IEAqQEJjwcrH2N/4pc5OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7751
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> Force a run of fsck on the newly created ext4 file system to remove the
> orphaned file that is present despite being marked clean. If this is not
> done the integrity tests will fail as they will detect the presence of
> this orphaned file.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   test/py/tests/fs_helper.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
> index e3824b2c1fd..48b047aeefd 100644
> --- a/test/py/tests/fs_helper.py
> +++ b/test/py/tests/fs_helper.py
> @@ -250,6 +250,10 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
>                                         shell=True).decode()
>               if 'metadata_csum' in sb_content:
>                   check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
> +            # Cannot use check_call here as it will return an exit code of 1
> +            # as it modifies the file system. The -f is needed as although the
> +            # fs is marked clean, it is not really.
> +            call(f'fsck.ext4 -f -y {fs_img}', shell=True)

I would have preferred an array as argument, to avoid shell=True, but 
considering all the other instances of call/check_call also don't do 
that, a clean-up for later.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
