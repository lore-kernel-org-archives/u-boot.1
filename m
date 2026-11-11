Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XiUEOhOo;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=PZeuV/vj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BBB66089F;
	Wed, 11 Nov 2026 11:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZC3wKDn-8CrE; Wed, 11 Nov 2026 11:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5FDC60797
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794397590;
	b=mO9WwmZVarqmO45aMStO+zqhanW7tpOORqsqYj+iqjr8t0IgrG/Ypg/O/6UT4LnF5zfr
	 KkVAxEi2W5KxLIu5e1ZVh6dJqjpwVMU5ZuvyELTGsDahyeYsCxB6z0z4q+IqPoRV9E9ZH
	 cJw3AZNMVfsu3S3sPPA6x2iYhPW9luCXktzu6ABmslfDa3V1vy6HdW+14BYiw+YXNM6zK
	 TfXxfJmWW+ELTATiS7nrfoHTfBJJ5Li3nFhxcdPc4MmFJPhEPyo/pi0KduA1/g4YC99dJ
	 DFe9JzRdCtMcnU9C9fK8/8kGP7Dl4YweFTsd9w5i3UaSPqEa+ZYlaVqvIc6smiowU0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794397590;
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
	bh=N3kaumxvYmpB0OGYtPuaSYaeDZvtrA9zFlsLwk/0yEE=;
	b=D+WGTnfnxGLodQmjZschgDtlXqkZ3a4T4Srv6pOfPUB2TxAzMjrbCGG2QegTjBGZYbZv
	 k0mOJdnHlrzQ8vSIZGMADssK7zV/8pS7rGV2QYYEXX3yCb0KsVsuGXOfrHql9bmULn7cW
	 QZhyFoCqJeXw2Me1w5T8Efos4mlmPFvUalK7rUnPJlUMiJRB4gNzHFvtoSXnKF2ezsxQ5
	 BZ2DtQQuEoUZht7ZYuMX2OwcvEl0xBxq1QVrmZtoJQHbU8woVczhINa1hZeYxeEXQQFx7
	 nW+Ip7te7wvD5/fO3s+pwX0J+CAWLIjxjEqJGf+5fKwGlwn9c1WBcZ35QohQv1iByuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794397590;
	bh=N3kaumxvYmpB0OGYtPuaSYaeDZvtrA9zFlsLwk/0yEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiUEOhOojsXoBW0e2bwayPNBtLTj3+YKJOiwLrZ6cHFQUx3wNMFrsIsoCk9o/c2HH
	 0HUrDfeGdCgSeKxsaI0z+ODZyB++lme2oG7Hd4CFO4XuthxuP/A5cRuQzGK3H00q3k
	 T+2WW5eg4O+tfheDi9EOP+LpogEbPWxn0FdpI/NjiGQOgDz7tNjx7hUUgolKABslmF
	 +b3rgVzJte4fbrJg6HJqF6lUsC8cTIG5/sPXjVd602JMd/RY1QIKTP0ChbutL7DReb
	 eeR30Gh7lJVtPUFbg+TESt2tGPkuMTQkzY0liVNNNcLGIEPy4AOCF9zjTeo93HZk80
	 jBGQlpW6rtx3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5FDC60797;
	Wed, 11 Nov 2026 11:46:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5BC731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B07004095A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 112Xz074kX9o for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 87CCD40889
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PZeuV/vj
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87CCD40889
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3kaumxvYmpB0OGYtPuaSYaeDZvtrA9zFlsLwk/0yEE=;
 b=PZeuV/vjRkbsQpV7tciIUO04Qp6gFn53oJ3IFsRue1054Re55DbF3ASrYIvKeHRe3xRaFZap8BwFipS2lzexSaXgjEA/hxw395DYpHWN57Yoxqse94cbejvM0tzTRI0fi7z/cpCHkg8Uu1RUxPHHViN+mLmqke6Q/JC4nXfIVDs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:46:22 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:46:22 +0000
Message-ID: <44488026-2318-459d-8648-7af6c8723ee8@cherry.de>
Date: Wed, 11 Nov 2026 12:46:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] binman: test: Add tests for fit,compress
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@nabladev.com>, Wojciech Dubowik
 <Wojciech.Dubowik@mt.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>,
 Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-4-d7e290847543@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-4-d7e290847543@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d355d31-3af2-48f6-1c0e-08df3fe96838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|11063799006|4143699003|261022105027099003|56012099006|261022115727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Yj+ybYh5SQrZWkKD1moyvHewIWZt25AQXRvPGxGyVNR/tfa7iDmI5kTqzrcPCwkQ2F+WiO21YXd02SXOCV6i30YxgOzcLOxH1IdZSYi2L5wDY0dY8wzm87BRwgx3VV4q2Mb2vOpmsw7khipFbBpF58C1J2uc5ynY7U6FT5OaWVC0yNqPbfbdzOYfrjgmcMgCXA0ETO837Sc8AqGwtTXh4GmofKfJpwTXPEH+aCB7bR+/huLXjrfa0y7JAp/N9xe0Ud0R2+EueaGHRpoOKetoB+4VgBLdOoRI2Zjkh+gaBWV/lWkn6gjLUPwT6Wrs7L/MIi6N8RcCpildcLQS8qfxMXxHnOZ6BILgZzUpEjoXmH1gVCKfRKfXjBluzrs1XJZLXHmqC3IIhC24GzB5XS+b4+qDTRmbI4uGkPXSOdOjHOAF3jdgPFaG/yBZzU37wFMEhtI66VNmD3lIPs4uxtqJMKNKsMvEwwv9wyuRdJHD/VWhVFNIZEZuGFV55MgAYSdRuP909GjcGdFnrIk7UZzdE5lC0aDVt3FTB/XH8SwARp/rrTGFofGdHJPOmoPl7fMK7jK5FXSgAs7Z+VCB4Dc5A2d7YcbK8J1+znbeUv5mVvsEW0CVfHeABxmwecfnfa6f/8/DkHnmiXzyjNdUuFXw95qFs0DyUU0Ma1UDRTxKQsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(261022105027099003)(56012099006)(261022115727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VtMlJaR2JkTDRGU2RteTlKYnpSUzVvRCtxK0hFNUNWTGR0dzlJVzhGS3hp?=
 =?utf-8?B?eEl6N2hGQUNsdXE0S20vTytPMXNwOFE2d3AyK3RVUjRrdlNadi9WWW1LMzJq?=
 =?utf-8?B?NFFjZXRtQ2ZlVzZJLy9lWG4vQW9ReHVMN0ZPMlNJdXlxb1dtUUxNaHdqOEVL?=
 =?utf-8?B?Y3VPUTQzb3BSeUhSaUJzaHFNajlUcE42S2p4Ty80cVFuZFowdUFzNFFtMlhq?=
 =?utf-8?B?ZlEvdGVXL3hIQkI5TmxHNzRodWFtRXc5QWY1Tkd3dHhwZy80MW4zSkQwUWls?=
 =?utf-8?B?OTBkYUdsWlN5NC8vSDNMMkNPbGlzV2ZaQjJ6ZHoxaExBSTFVRGR5b2g1TGdz?=
 =?utf-8?B?QmVaMlFMRFhRQ3NqQkh4amJDRjVselQxMTFYRXR4SGx4Nm1ucUp4TXo2K1R4?=
 =?utf-8?B?Yy9rSmNpajA4V2p2R3RWQzNWVmxFMWF4NklKdGYxSzVnYU10YjNuaXlzK0JJ?=
 =?utf-8?B?Ym5oTEN4M2VCQmpySklKQVkva1BObWpnRjFPeWt1YVY2ZlhFMEg4ZHdtaGMv?=
 =?utf-8?B?QUlTdnkwYU1qdVZJa1QvNUJXVEJLa09NZkZicTcyczlOdnVyUEQreEltQStt?=
 =?utf-8?B?TktQM0dHMkFkUmtKVUlTNHIvYmFlWldLNUsyengvbU05bTYwN0FGcnI0SGho?=
 =?utf-8?B?R2t5K05mYVkxbnA1eDRFVEZ2dlVWeVJQS3JpcjE0N09KK3V3NGJVcWl4Unk4?=
 =?utf-8?B?b2lJOEtEdmwxUGxEWm1EVjNLdzM4VmpsRWdKZ0czaVlHbE03bElyZ3FoMENK?=
 =?utf-8?B?bzl4dWxXd3BrZjdPMnN4ZWdCODBlM2VMYnliT3pjMktISlppdkl2K1lLRkpZ?=
 =?utf-8?B?aWJhbllvbkxISU1veUU0eEpFQXorUk0zWFJWQ0FzaUF3K3o5NSswUWphU3gw?=
 =?utf-8?B?VlMzbTBwWm5GWXhKY1ZaYzVwRFdoWER4dFQvWWFNYjRUdTFXakNtbTl2MGk1?=
 =?utf-8?B?U2xlQTVOK2tRUUFVbTFNVVpuUWI1cVI3dFZ5YTM5aXNMaEhDc01tbVRaWnB3?=
 =?utf-8?B?MmlsMVMzU25va0dzNnRYTERrbS9JYjNlMjl3ZVVrUmxVRVkrek5XWlY0OHJX?=
 =?utf-8?B?cnFxRjc4ZGJkWVg1bEVOYmttbllrSFZFYy9mL3BxZlBham1IMFQ0N3RGaVdy?=
 =?utf-8?B?MTQyeUpJZzNLTlNVVDRyRy8waEpSc0k4R0ovVmZWTHNFcHNGYUt0MnIwTlln?=
 =?utf-8?B?cTJwd0h2NnBFVHJxcFpwMnpEQTJvT2EySDdvQ0hvU3hKT2lxeVdBYklwUUtj?=
 =?utf-8?B?RVhDemM1aXNvVHI4Q1JZaWhTR2RJa2dYSHNBeldPd0NweldaNlVBSFRjaWpo?=
 =?utf-8?B?dUZXUkJnT1daWWI5aUZhMURkeTd6bm4yUG9uZnZjdGpFdDduVy9veHJyWlZT?=
 =?utf-8?B?OXdWSFZSVUF5U25SUnVDRit4SjFwd0Z3Q2F0ZDQ0dUsrTGZLZC9NTnh1eitQ?=
 =?utf-8?B?K2g3aVdBM2VkMkVCRTQyWml0dnoyYlg5VVFkUWE4YkdiTVJheUJreHYxaEd2?=
 =?utf-8?B?Q1ZZQjAvdzlTVGQ2V0lUQytrdWhQSlpadmZ0WXZuK3FpQ3lUZHBJcDhxY3RO?=
 =?utf-8?B?WCtVWGJUbkVaVWVZUHFsRmw2RTd3NlJ6VWFXRHN4MGlxTmltVDUrNGxjMzJz?=
 =?utf-8?B?eTNiNlQzY2NQcFVKenBJb1JmV1dRbmxocVloUjh5SlI5ZUdUbDN5MTZqcWYw?=
 =?utf-8?B?MUtWNHBwclJFY1VoOHM2Wmd5ZWNLK2E3OVRHZENNN2pqc2l1Ymp4T2gwVHR6?=
 =?utf-8?B?eDZab3pLcXVaUVJ3K1d3bnBXcFIwZGNmRTQySUxBWVgzSWhXTDRrS1FDWVB0?=
 =?utf-8?B?elNhZzNiZWJXbjlhT1hab0Z3VExTU3BKU3dQaHpFY2FLODc4VDRCWUpUSGEy?=
 =?utf-8?B?ZEdkSVM5NFpadTVGbHloTU5OOWEvNmEzWUl4L0hmbFlZTXdXdmZ2ZWlvMlJV?=
 =?utf-8?B?SlR4T3crT3JiTnprSmJ2K25MNXZydlFER08vSVorTmFCZUE3Ynp2d1R3aEpk?=
 =?utf-8?B?cTB2YlErTnhMSzhCVmU2WTlXTFZ2VVJLTHY1WStsdkx0dGxtNm5WN3JNQSs3?=
 =?utf-8?B?cVJvVUJqRGlDeDlWMDNLWWpwN1dyQ21IZzdJTlBKa1E5NmNHWGJ3R0I0dWFh?=
 =?utf-8?B?SmFvMnhscWFYWU5RQ1R1SnZMM3ZIOFArWlJGcWM2M2lxK2l4YTgrNU0ydUtZ?=
 =?utf-8?B?dFNXYUp4OFlmN0FOWFdQOUFxc3VEcU5mcGRCbDBMRjBpVDlNRmhBaWF5NlhL?=
 =?utf-8?B?TGUvVjVaTDF4dmV0Lzd4VWtxRzg0MDRpSEtQY0drY2pac1NIYkpqZzhMUFRa?=
 =?utf-8?B?djljZnJkTHZRVmhVNTlOcW1KUE9hOGlhd3dWSjU3dXZtM3dPR0pUZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d355d31-3af2-48f6-1c0e-08df3fe96838
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:46:22.0021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8YdRPtJumizna4aRQr5uzKswYslcA8rH3vxZWiqbRGcpuCLLyDYw7kdRlA21VI0+PX+SVeuIUYGnhgEZNwh3viL9XVSlXysyg2KNTUkouk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364
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

Hi Petr,

Squash with patch 3 please.

On 10/17/26 9:39 AM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Check that generated fdt images are compressed and that 'compression'
> is set from 'fit,compress', that an unknown algorithm is rejected and
> that a missing compression tool is reported.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   tools/binman/ftest.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 8caf275d466..fdb22b0965f 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -4357,6 +4357,50 @@ class TestFunctional(unittest.TestCase):
>           """Test an image with an FIT with multiple FDT images"""
>           self.CheckFitFdt()
>   
> +    def _FitFdtCompress(self, fname):
> +        entry_args = {'of-list': 'test-fdt1 test-fdt2'}
> +        extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
> +        return self._DoReadFileDtb(fname, entry_args=entry_args,
> +                                   extra_indirs=extra_indirs)[0]
> +
> +    def testFitFdtCompress(self):
> +        """Test that fit,compress compresses generated fdt images"""
> +        bintool = self.comp_bintools['lzma_alone']
> +        self._CheckBintool(bintool)
> +        data = self._FitFdtCompress('fit/fdt_compress.dts')
> +        dtb = fdt.Fdt.FromData(data)
> +        dtb.Scan()
> +        for seq, expected in ((1, TEST_FDT1_DATA), (2, TEST_FDT2_DATA)):
> +            fnode = dtb.GetNode('/images/fdt-%d' % seq)
> +            self.assertEqual('lzma', fnode.props['compression'].value)
> +            self.assertNotIn('fit,compress', fnode.props)
> +            comp = fnode.props['data'].bytes
> +            self.assertNotEqual(expected, comp)
> +            self.assertEqual(expected, bintool.decompress(comp))
> +
> +    def testFitFdtCompressBad(self):
> +        """Test an unsupported fdt compression algorithm"""
> +        with self.assertRaises(ValueError) as e:
> +            self._FitFdtCompress('fit/fdt_compress_bad.dts')
> +        self.assertIn("Unknown algorithm 'bad'", str(e.exception))
> +
> +    def testFitFdtCompressXz(self):
> +        """Test that xz is rejected as it is not a FIT compression"""
> +        with self.assertRaises(ValueError) as e:
> +            self._FitFdtCompress('fit/fdt_compress_xz.dts')
> +        self.assertIn("fit,compress 'xz' is not a FIT compression",
> +                      str(e.exception))
> +
> +    def testFitFdtCompressMissing(self):
> +        """Test that a missing compression tool is an error"""
> +        with self.assertRaises(ValueError) as e:
> +            self._DoTestFile('fit/fdt_compress.dts', allow_missing=True,
> +                             force_missing_bintools='lzma_alone',
> +                             entry_args={'of-list': 'test-fdt1 test-fdt2'},
> +                             extra_indirs=[os.path.join(self._indir,
> +                                                        TEST_FDT_SUBDIR)])
> +        self.assertIn("tool 'lzma_alone' is missing", str(e.exception))
> +
>       def testFitFdtMissingList(self):
>           """Test handling of a missing 'of-list' entry arg"""
>           with self.assertRaises(ValueError) as e:
> 

