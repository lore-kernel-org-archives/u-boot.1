Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D260A382B
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pOGLpB1H;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=jXGkZJiD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5091608E3;
	Tue, 10 Nov 2026 13:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vv2lqPLRCGW; Tue, 10 Nov 2026 13:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E9BC608ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794318517;
	b=px07c6AgmbCkUeR2vIsFPcbi2se5NSbnOMPS8c+TxivX+0bjXnBVlhQkGBn40Irr0YNV
	 3Ihy+DeLn8X9vWwMUgqefIKMutVp/EtyAdiGBBzNFX5j9F+KFnEK4sH42Rb6yeO8dSkhY
	 ofBEzJgn8kXdcSzrAeqZw421vReie90SwFy3t5GwXZpEqgyPy0TRYcNW6k2hLu9gTeAuQ
	 U2d0+6Yl7Fs8vRWqYoQFWlRxf3/FPinunl2E0SlPGtIcvnjh3M0jXp6Ch9wA3hmlxP2bb
	 wWe8fknh2px/QmkXEExpJbhdAgX45AvjNdSjEEqdtW9HxrFeny0NLYJpwGUQnjwkNHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794318517;
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
	bh=eeTo2fPkQ08gOcddcMXIsReMHOKNFjNO/K4qVj712wo=;
	b=S/BMOWo0XIIfBO93+m22a8UE0Ypk92IRWcb+uZBTAHmVR6vQ2h8vWs4piwmuAsWulece
	 yaVmHtOWqg+f+gDIhA7gI8+SguJO+kJ5dBgqK4uiLDKYy0jwpwL+RbY1WMBL30+FfVauh
	 8cHJFgIqtkwi9dpabdlwIKreLPj3/kPGoFjHEra5zCNnbIHa//CqhjZKiOSAbzTYP9U76
	 db6xR5hgoxCNFKE5i5+R9FhQF6/cbZ2BuQU8reMR92NSibdhEzsK0d1uGM3oyHv9wq+Z3
	 Apj5tm8ojE7CcRpPbyjIjZLaQA9rEMybUc9A8/FfYsQi145t8lzPVJohs4WD+3Gng7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794318517;
	bh=eeTo2fPkQ08gOcddcMXIsReMHOKNFjNO/K4qVj712wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOGLpB1HmAWsRg67NJcjfazc4tH0BDaGjdZlU7IGFxgHfS5MtEMJG1CqXuZDkvZ6P
	 h8FP2Rai9c7ZoFNqRGrZ+BAusfh0YunT2CgXkmdXvdVi2POFJ9RptHj9//ads2dvro
	 wpMOk35afWd16RlXi5qdgHoInC35Eu67m3Rume+ZoEj97gJONE12mltK3XbZ/36Xv3
	 uwBRS02H9tbSz/NW2sHc5IRaXqwDJqTmrex+EBF3vkw7u8LvHz6iYihRug4NV/7Pks
	 Pv6iI4O823OcTJexn6EA7bF4m2pWQolZLDALJFskoEsrqR7t9vdTrQRitS9SKEdOaB
	 70+Ny9vMrFmrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E9BC608ED;
	Tue, 10 Nov 2026 13:48:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AF001A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4F71810CA
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:48:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bua0FKH3hZZb for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 13:48:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFE82810C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=jXGkZJiD
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFE82810C9
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeTo2fPkQ08gOcddcMXIsReMHOKNFjNO/K4qVj712wo=;
 b=jXGkZJiDSJ9AqXxZzm+ajpPXBYS5zhQtQOi0Dsy86Cul/k6ZbQ5kT/qsRhm+OoNEfJKLmhVDhVaSKxQUyHpFxhoPcqpuf6BOJXCzHw8S6g7MiYoZ0fKRHSi1jKihSkjxnMKEEpe8Z3BdklmPVVBSc5Y4yBwJzqvxnWYBETQr3wc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI9PR04MB181296.eurprd04.prod.outlook.com (2603:10a6:290:85::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 13:48:26 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 13:48:26 +0000
Message-ID: <18e8382f-eaa8-47f8-969b-018c1a918459@cherry.de>
Date: Tue, 10 Nov 2026 14:48:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] buildman: Cope with empty CROSS_COMPILE in tests
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-4-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-4-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI9PR04MB181296:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d3e3c9-77be-481d-ef86-08df3f314b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|6133799003|10067099003|11063799006|4143699003|261102130727099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|56012099006|261021121427099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Ta2zsyqg03in629yUHq+dYTpVTeaeg8EpTSZIuUofaMoY1xBmTdT+C4aqLaXY5hWspRo2nVJ2wkpHgRFbDkA3OfRwr93Q3M6f9LEjf8GIM/RDWc3Ddu1YVM/zrcTudbTH5trCHp0/TD/r149X3ozJpMZqjrv9bg0yH1HGl/IFT7m2t1SLm+974KhGvEFj5HtxxdgAl0JneH6SYMxBdK5gfc7rO99maTgh4/wlgpNzEP2JyvznwE0YATzSQtvUqH/isdnbMYTkEtxCahZgR4yYIzmrh8OgT6cflKNSTZJH8lY6xASACcToEHjrVcF7saYbj+wAk0R2LqTjIMjZWHUE4Gv1fvCUFAtqzdd6oelKptJpfi1Ml5SuLIhgMi/d2kuNV2uWCRchP8SOK+0Ar9KsLSIaDGj47IyE6RZM7SMHfM2c/uK+4o4qGhAJ/6FcZbSRmFMHCD+r5w/KHZGMKkT22arzMQh2Rn1vB5sH9Mhae0wKTNxmuE2PjGT+XqIUDLgu5BH/c8bkSkexgcecfBGYotB6uFeZBRui9wKb0B9QktY8er3HNESlW+/r+TUOXqFRsOd7TTOmVn0kOVZ8lkS+7hhSBEj58tlzLyeHRRlDRt2sRiPK0fCYhDNrjvGp2aOy/d7C1eT443fKBfl/cUdv7tOYn+JtJAIDxAcPVCjFZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(4143699003)(261102130727099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FUd3J0N0l6N2NRRVVrT0RyMWJqblBoR2hJaTBZTWNKdUlMN1VkOHJ5YWlV?=
 =?utf-8?B?a0ZTMzE2VFpSdUpiYW9QTlhWTkdSaCt3UDk0Y2dMQVlnaERqRVhET0tuVjN0?=
 =?utf-8?B?QWwzVC91NElLSUF6REpCelp0WERCa21UYVlHYnJqdEltdWVIYjhKREVnV0Rh?=
 =?utf-8?B?R3R0YVhUbUphU1M5TkdGM2l0dmhlQ2NPYkFPVTFWZmxJUGExc1VwVkpEM0lZ?=
 =?utf-8?B?d1MrRzV6NkJra0lnT3M3dDFaRXJzTklHb29LUTRWZkhjbVM4MnBhSXQ3azFR?=
 =?utf-8?B?NTRQTlVXcm1jSFIxdFVWQVBCa0xIcEtucWxTdWNnRGJQSThwcENWUG02NnZM?=
 =?utf-8?B?VzEwc1oyOStrNjBWK2V2QlFLVnJkWUx0K3gxcW9VUFhlZEsrOHZlMEUvN3RG?=
 =?utf-8?B?NlBOZXhYclR4MEZGYmFzaGZSNnV1MkVnV0JzRXQ0cTBvRnFvWkw3djhZRjBz?=
 =?utf-8?B?Smp1dXNLNVpoTXpJTEtTUVB6aWVlWnZEM3JrVUlRM3Q3Zzd0WWtCM1NVd1pv?=
 =?utf-8?B?cDArVU1POTJMa0hSR05aSFcxN1Z4VEFiM3lmZnFjZ1VGa3k1Znc2WmpqUlUv?=
 =?utf-8?B?SDlQU24yYWd6cTRSclVBTHlSY3NLTDd1M0NwaEY2dTA0cVhjNERWODhiNkRF?=
 =?utf-8?B?eWxseHN6aUxHYmF3K3J0dTJJeGdCV3UyTVFId1hNemZtRXNLQzc5dGdPMHNZ?=
 =?utf-8?B?RCtYc1lNZGZyRGJOam9ybXdKd1VpWVNiNmlZTEpzSFFXYVpvQnRiMFF1bzBV?=
 =?utf-8?B?Z08wb1l5WUMwQ2d4VVlXTmFkR1BKeG41TkNURHZndDhZbUNHa3BIYkhMUklr?=
 =?utf-8?B?UkFZZTBjNUxkbys1YjArY0krL2FwTUFYM2pra2N4ajBZNE5mbGNRSXpWRENP?=
 =?utf-8?B?ZkhPNVNLRVR4MXY3YVIvcURIL0JvOGRQS25NVGVvNEFwSmZUSEtXUFh4YnZv?=
 =?utf-8?B?K1JsZndmSy9ielEzQzluK28vckgxWHdINkx5RVUyT3V5MjR5UjRCdERXSGhh?=
 =?utf-8?B?ZzVvdjA0cXRLdU5LQ0tpdG5XaFh4Yi82ZDNVM2h0Y3cxY2hXY0Z0OWtVK2M0?=
 =?utf-8?B?L09xSWhwUnA0TEVYdm52TWFKY29ndHV6SjIvaE1ncUx6SEM4RS9Kczh2NWtR?=
 =?utf-8?B?RDEyRjBiWnY2QzZHRmk0ZmxTYzE3WmR6bFpsaGlTc1lIc0JnVFJpMnhSV0pv?=
 =?utf-8?B?UXM0aDZ5REhoVDR2STRJSDQxT3RsZWZxR012dmhmVjdnT1JLMklMU012SGsw?=
 =?utf-8?B?cHhnbHZJR2huUWpmTDhUTFBhSXZzblVuazBScGtRS1JhNDVmcW52SmMzS2xx?=
 =?utf-8?B?NE1Zb2pmMG83TDNvQnFMQXlyZkUwZmJRcjNsZ0xYUENJbGdhVnFsMjZuZFBj?=
 =?utf-8?B?bDlMOVBqdnk5empHTEo0V3BDSmEvbTlxV2VuUWU0T1VqeTEvTkVkOUt5YmNJ?=
 =?utf-8?B?MEsydUZNR2NVZE9mQ25iMC93ME5KRWlvL0dKLzkwdHVEdHhyQXRTaGl6WUlZ?=
 =?utf-8?B?YnA3VTJGWEdnbUNLcjRsOWZJYk9yd3lKVnFiczVLNWFvSEVuNjR3UFFLZG9E?=
 =?utf-8?B?M1RBVnhKdTFGTlowMCs0V0JpSitXYUR5dkFxYUJHNG82WE1TWUFJdzZlK0pp?=
 =?utf-8?B?d1B3UGFSYVRzTFlvdjR0TEJxakxaU1lxN2w1VlB5NmgxSWZEakNvYWtqYU80?=
 =?utf-8?B?QmlKRmhCYjhDaVlkekM1WU1tbE4xODlKMm5kY0F3dFNsbXlOMVk2aUU0ZnZS?=
 =?utf-8?B?eHcySVJPaEhaNC9IZFVxL3dOM090VWZUZzlqV0w3c05DRGdWZElZT3F3OXUy?=
 =?utf-8?B?VHRGUWdXT0tXM2NDSDJ4dFJvZEJvWWNVSmtTNmpTODZxMjVqalBPWEFGL0Jh?=
 =?utf-8?B?b3RQK3JNVDhVY2k4U0FidnhtaVlRYVZCdlFURjdubWY2azFrcWFkemFydUFF?=
 =?utf-8?B?bklueUsyUUVUb2M4U0FkMGpjZ1F1UEZab3JoTEIxeEVwQkRPVWVHaGJ6VHA4?=
 =?utf-8?B?bFpraG5DYkUrT0YySUMyY0hac00rVERXUkhFbDV0QWNvcmlaSXRDK250Y3Zt?=
 =?utf-8?B?Y1RTZ05mQ0ZiWm5YVERQY1RpR2lZK3dWZTY0Wit6YytpVlRHYllaVTE4K3A5?=
 =?utf-8?B?OUp2SVBmc1k0Y01zcFRsYU9hNDNiSjFLd1ZlOUpncW12NmI4aFVVRlJFaEhC?=
 =?utf-8?B?ZHdBeWlsc0hVK01sRkxtWWxyOXlLRm9MTlA5NVd6RnU4bHNhcnhyNVFvUEpz?=
 =?utf-8?B?NmhyajhLaDA5YmpRQVovSW92MWRva2hVeTJzWnhNMkNQblhKWGdDanVlV3A3?=
 =?utf-8?B?aHRteHpHdDRtWmhoMVUrYXo2UjJwZlVsdDh2TDhrSHozU1lNc1ZvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d3e3c9-77be-481d-ef86-08df3f314b96
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:48:26.6808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUZrGgiCkD5gLFoUKsUlPj0Ru1Q+ufTIenlQYHnTFccMmXZs4FKSgNqKdAkZpXfTUAXZ1etHBCSXSelGtJ8zRzJS4iSpRS9SBP6nWLAn484=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB181296
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

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> When the buildman tests are run through the Makefile with eg 'make
> qcheck' the Makefile will export an empty CROSS_COMPILE variable into
> the environment. Add the code to the test that will accept this as OK.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/buildman/test.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> index 7ee9496ffb3..e620a92126f 100644
> --- a/tools/buildman/test.py
> +++ b/tools/buildman/test.py
> @@ -656,7 +656,7 @@ class TestBuild(unittest.TestCase):
>   
>           tc = self.toolchains.Select('sandbox')
>           env = tc.MakeEnvironment(False)
> -        self.assertTrue(b'CROSS_COMPILE' not in env)
> +        self.assertTrue(b'CROSS_COMPILE' not in env or env[b'CROSS_COMPILE'] == b'')

suggestion: merge both checks:

self.assertEqual(env.get(b'CROSS_COMPILE', ''), '')

should do the same.

In any case:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
