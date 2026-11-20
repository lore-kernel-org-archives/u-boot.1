Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0C606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f3XX2DXB;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RehBIi2D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9D5A40DF4;
	Fri, 20 Nov 2026 09:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPHrr_zpPggj; Fri, 20 Nov 2026 09:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A42A440DE7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795165980;
	b=EANHUymuKp4E2pyI64DWvmUWRhDkk0hFqEoSheQmpoWYI3agiD635D96WdDS6IOvUZnp
	 sjFEVUGgpnqHgCrIeaY9W20Os2XvfSyZr2NglFDR20lYmkCqxIi8Locy5RvjUVRKdmUd+
	 cR31Rk/EQ3+FeYGtDu5I3pzrnKj2/Stkl2u1KsiIZ4Xe/SqAqXcGaWv6cTB46C+BCJCev
	 pUZtZdH7tOCn6+pjo/Rk39TtKtRvf+oW3UY+1op1z/Rbutzt60bQq/PS68fFu1HEeTi+4
	 porVfQ++QkUd27pf1pyHkOpH54SPmLRpImSyiZoRVn3MZjkDn1+pIO6YYvEcnQB0eDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795165980;
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
	bh=WVRMXKtEIHR8SytftdEVO72+IJ5cwqvBnjsF0GvI2fc=;
	b=pClFhj7jrVqHKB4lCvcs8BiA3TomktOlM6OWCxGpMayggDtO/Njfw+JQ2at+ALIw15r/
	 6jPdQp6EeRuzT7oCWGSeg17Iu7f69QDgzzxHYRSwbd/PrbV3xfDPx91S40dWueQCMFC3+
	 QL57riMBJ0iu7Tbb1tho6e850YyceeqIg7Bw9mCNQcuo3nA1AXOgERmQX77+APDH53OpH
	 h26N9m6BB9c6BDjZuRqn4TAdk4ZBUa7ih+VDKsimLEpljWwxZDNN2gTxiO+rf8bwcAlFg
	 neFWzNF47nSuGWAWp6JIyJWKSl4SM10ZBfVvAWDxWOGCWMwT9FpZS0aTYWcsfbU0DDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RehBIi2D;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795165980;
	bh=WVRMXKtEIHR8SytftdEVO72+IJ5cwqvBnjsF0GvI2fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f3XX2DXBkpHU6OT1MchMOnG+OiApRcLHtnRcvrwvX0A5O8PVT7sCBOTgV0Vqn49px
	 w/S3E90Of+hiaHeYRVN6Wks/NZ2FOqHcLGu26RUhfEtQObimJ8Ic+XPfIy1lKhnU7O
	 ltwEHAI+wlj1gq7ajjP48+SA00scCgSIzm26uxRTupEk5fX1OofeoAm++M1WEyZXDK
	 tNF7YL01zEsd0Rf8RHpuev34d0VWOgk2F1oNjPf5TlOkW0t8NmFQHqoFmzr2o3lofE
	 3iMaAB2Mowv0FYmG0/3ijiiWlC+NxVd6u/ovMBRVItmXmEXMfiPW66OQCZIPc80mXi
	 i2OelQRxFrtSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A42A440DE7;
	Fri, 20 Nov 2026 09:13:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE099169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93BAB40DE7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vjp6aiAZQzS for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 09:12:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4D3240DD7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=RehBIi2D
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4D3240DD7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVRMXKtEIHR8SytftdEVO72+IJ5cwqvBnjsF0GvI2fc=;
 b=RehBIi2DgagbD0JyqbuhlUYimB+NlJ2wHnfp/c+mN5bG65u7g0WgDZKKAj4vAGNIKsQ8p5p2A0tDlCbqyFdlitbRnxoHcxxyyHWfH56MqJRqnX638lhWOAwU6xCK1BQ4FRZ2OuI6OE3RXVWPJ3Ry7/yVHm8Xc/Hxw7e6IxT9tUw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI3PR04MB352264.eurprd04.prod.outlook.com (2603:10a6:290:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 09:12:47 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 09:12:47 +0000
Message-ID: <0ef81167-db51-494a-b9d6-1f891ca37551@cherry.de>
Date: Fri, 20 Nov 2026 10:12:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] binman: Use mock environment to ignore DTC
 variable
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
 <20261116-qcheck_fix-v3-6-b6cf7e96944b@linaro.org>
 <0ff5c700-9ad7-4aed-8309-aa40e6e3cab9@cherry.de>
 <078dc2f2-f7ac-4741-a683-c35d4ecc8296@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <078dc2f2-f7ac-4741-a683-c35d4ecc8296@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIYP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI3PR04MB352264:EE_
X-MS-Office365-Filtering-Correlation-Id: fb417280-09db-4758-b739-08df46e6715c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|261026135527099003|261026140227099003|261026130827099003|261021135927099003|261022115727099003|261022075727099003|261022113327099003|261028144727099003|261022105027099003|261021133027099003|261021123027099003|261021121427099003|261021130227099003|261102123227099003|11063799006|5023799004|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info: 8hrvF9+/cTiZ/j7mV3wm2OiXir2vnIoaV2iUrU+TVrXd1xcUssmOm82an+pHl9iV6LE3pdr+/D9hUm6I7sEnUO8iCcIQ/X48MwaZoh6B9JCmvaB6GUuRqJ9fWy7YO3nEFGTxgldBIBiSaVvUD+NBhoJe6EK/ooVXmYtNly5QBEwnTmQxA7ObpXDbEg287YZQ6cfsm75QQ3SrHDAiJnF2fq/uLwHR75BVW5G4W4bYp+9h050H/JhMRrfw8m1SC1q/maVgI6EZ5208BuvXeYMA7Xg8FQ91cea51ZOj+OtPLP1pEJ4rEDANurHbB78eD7TdmYslIDJ32Cwgwvj7ihmNBKejnvi7oc3zVHyVlFKCkchyUq6uKBV8Hy4aPJEwCT2RELwhciCq1Te3P0r4YcckJtNEXkAjl0QdjilWTLYo7elfSyEiqEcLAvHbCKDmI60jOBFeG6AOKdE8RrF1qGl1BD4wShr1E6pRQ2WGtSqlWjO3m9FDYvgErs1/u1Tx+S4S91AeqouYua43OLE3wNva+n2mgqXZh6/oiqFoiOMbHimqIetZ82EbIMLhthxGBb8x8UB9N3/B6ucfOy0y7ci+4y472zpRIv6XjKGnyHwoNEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261026135527099003)(261026140227099003)(261026130827099003)(261021135927099003)(261022115727099003)(261022075727099003)(261022113327099003)(261028144727099003)(261022105027099003)(261021133027099003)(261021123027099003)(261021121427099003)(261021130227099003)(261102123227099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE4ramNxTDg2dmJDejNvZGdaY3ovaW1mRGRwYi9la3BWQkRyWlpLT3FiZEpp?=
 =?utf-8?B?R3JOdGVBWnRoRzJsZDJhcWlEaGNWOEtHQWYxU2ZRc3Q5SXFQa01SNGJqWmN3?=
 =?utf-8?B?cmp3OWN1TlhPOTRvTElKK1AwN25NTXV4bEVrK2J4czd4N0EvWWt2UU5xQm1v?=
 =?utf-8?B?VTFNVGxMV2JHWWxMTXBaaVpWNkltY2czZ0lPc0V1c2F5cGhTYk9abm1QRDcr?=
 =?utf-8?B?SWhRamtHYWREL3NhRFlCN1hRMHdjUVVZSWJmKzNmaVJNZXdhWHAzOXBOcnNv?=
 =?utf-8?B?Rk9Penl4b3JmQThzSzVyWnRsdm9GbGRaQnJFVXBLLzBFM1h3dkJ6ajlnTUdZ?=
 =?utf-8?B?NVN2VzNHaVl0QTVVRlhCYjBPc2xiUktjMG9wSExteFlMelhLa1NFUE1sQVpU?=
 =?utf-8?B?ck5leWRqMWlrUGRqakxoNjREb3UvVWRGbXNtTTI4VWZETkpVajdqdS9jdjJV?=
 =?utf-8?B?aWg4OG81emJUOWVpZ0JsWjNvbHg3b3hsYXlMcWJUU01UREZ6UTI3S0tNMzZn?=
 =?utf-8?B?VWwzTmhoaGl6ZXJXU01XR1BvVG5Eb05PR3c2Y2RhZkNoSTFZQTVpVnNva0wv?=
 =?utf-8?B?dFJubVNLbE9tZTBEcDZpZTJMb3VSRGVPYWdIaUVsZHhzVk1RK25yYmxQbXNX?=
 =?utf-8?B?MmpYVHRtY29xQVhJK1JDK04vbTBHY3VTbzFJWk9jU0dhWFE0Uy8yTE9BRHM5?=
 =?utf-8?B?SDlHbXdZS3g4Wi9DdmwwcHdmd0ZNczdBb1B0Y0tlWlhQRXJKckhmUG1VS3cy?=
 =?utf-8?B?enZ6RHcyQzdhUzZieStwYTVzVjhCSlBhbHRKM2ZVYktOOHhoc3h2ZjZtcFUw?=
 =?utf-8?B?dzMyT2ZEWjdNZ3dzdk1vZ2xsYURDZWV3ZHhhRkloSTNzWE1Tdmxya20rYWIz?=
 =?utf-8?B?dThDeGZkZ3FBTHJ5WkMyM011ZktOQndkSW9CS1lOWXFBQktGTU1uTVh4Y1Vi?=
 =?utf-8?B?azZRaGQ5MGJVUlNwMmcyYTl5cmJQdkgyOXFocldTdnFpQlh2TzZNT2loVVZU?=
 =?utf-8?B?bmtWNlNyU0VnYy9JdHNBb1BFcG1lZ25GODB4R0puSzVjbEFPcjVVeWFXRzBJ?=
 =?utf-8?B?d0hmanArVjhXZ0srKys2OC85NmgvREtzY1NBWHphVTdsMEhmWkdsUG1rMDhp?=
 =?utf-8?B?N2lXTTFpY2JNb1Mwbnc5TElyVGZCNEZ6OHpOb1lHM01JQTNMQWlJaStkSUdi?=
 =?utf-8?B?Q1JqaktaR2ZpL1NDMDY3NnY2TDRmOWYyY1hyNzZqMGk4NmFqb2xXQVl4RUpH?=
 =?utf-8?B?U0huUEtwQjUzeXEybUxhSVZZcUZab1Ava3RDYnRQTEoyRUpBNXB1SVI0VzhM?=
 =?utf-8?B?b1g3cnZBb2pOdFNnMkR5Z2NnSkk1eE5lZkJWMTA4RXNPWFVDdUJXNFUxNmdW?=
 =?utf-8?B?cUJpbloyaUhRRXBFc25ZYi8xNlU5VGdPdmZDazNwd21GaFVUUjAxRzNkTGxW?=
 =?utf-8?B?NHJvOWRZVmtoRUR5azlzeTAyK1BXVjA4TGk0V1JzVFRZNEVWVGIxSVB5Y05L?=
 =?utf-8?B?akVWYWlwUllBSkozd3pXNDhaT0JPakpaUkdaazd5TmJWeFk4emZzODJQS2tv?=
 =?utf-8?B?OW1TdHcyaGJ1NVNoUDVHWWQ1MHE2V1FHRHJycGExNzZ2QUJsVHM2WHFWN3BC?=
 =?utf-8?B?aFdETWZHdWxFa0JGYlo2ZGpNQWdvT3d2MTFkYml6aHoxcUNQRndtSXIvbG5W?=
 =?utf-8?B?U1FpT1hGdmcvTEtpeHU2aXgwRWpNU3EwbHhKL3drTWtiU3JUWkEwRWNVZE1a?=
 =?utf-8?B?Wml2K3psU0RxYW9vUXl6VVpwWERzM1NtcVBFbHFXamdVUUpTblRRNGE5empI?=
 =?utf-8?B?T1k2UzJPeXVadGRRR0dLbGVVbWJzMkhzUjFGZERHMG16eWNvOTZ6UlRqQldt?=
 =?utf-8?B?bjhVTXFsbWRZekgvRU5EQ044RFEzSjl3eTN4N0hQNzNXY016VFd0MWp1REVO?=
 =?utf-8?B?QnFPL2dpZTFvb3NoLy9hcHNhWTNCcEJGY1ViQkVCbWFCeE15WEdJWTdweDNM?=
 =?utf-8?B?cXBKTVBYMlI5aXNDN2IvV25kUXo4V2ZtaW5HcVhPYkorT25KalpUbytVNWUv?=
 =?utf-8?B?R2F6THdud0pCNHJHcEFYNnFRS0dCSFI3RmRZRVpwUXdmbE1pZEVNL1N2VzJJ?=
 =?utf-8?B?OVdJazI2VS9uVkdzYmg0QTcwSjFJNmZ3eHZ3RFhaS0VNbE9oL0dtcG9OaVhM?=
 =?utf-8?B?QkMybC84TUJkNkx6V0M2M0tvTkVNSUpMdGtQdEYwZjJJcC95RVlZMkFpbmF5?=
 =?utf-8?B?dE9PSUQxLytqWFRDbk9DMEl6Wm93Yy9OL1U0cVMxYUxGM2NycHpZZEg4alVX?=
 =?utf-8?B?N3JvOXhDY3RWTG52UE1ub2E2dEhmMEhVcUNncnhocnE0YzQrZ1l6Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb417280-09db-4758-b739-08df46e6715c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:12:47.0725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kchhEkevWjpaGH+wdZKEKIFs4JS+68SulcJpzAWhl/xKu5xmUR2eq+MTaY3OoH6Y3FvsPswOh9sGET8utQCWOh7hAJwjVVAMPCKfnU9pG7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB352264
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



On 11/19/26 7:15 PM, Andrew Goodbody wrote:
> 
> 
> On 19/11/2026 17:13, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 11/16/26 11:59 AM, Andrew Goodbody wrote:
>>> If the environment contains the DTC variable and it is set to a relative
>>> path this can cause the tests testFitFdtListDir and
>>> testFitFdtListDirDefault to fail as they change the current working
>>> directory so that the value of DTC no longer points to a valid dtc
>>> binary and so the tests fail. Instead create a mock environment that has
>>> the DTC variable removed from it just for the duration of the test.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   tools/binman/ftest.py | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>>> index 567ffa96b2b..50fb25325a2 100644
>>> --- a/tools/binman/ftest.py
>>> +++ b/tools/binman/ftest.py
>>> @@ -7984,18 +7984,26 @@ fdt         fdtmap                Extract the 
>>> devicetree blob from the fdtmap
>>>       def testFitFdtListDir(self):
>>>           """Test an image with an FIT with FDT images using fit,fdt- 
>>> list-dir"""
>>>           old_dir = os.getcwd()
>>> +        local_env = os.environ.copy()
>>> +        if 'DTC' in local_env:
>>> +            local_env.pop('DTC')
>>>           try:
>>> -            os.chdir(self._indir)
>>> -            self.CheckFitFdt('fit/fdt_dir.dts', False)
>>> +            with unittest.mock.patch.dict('os.environ', local_env, 
>>> clear=True):
>>> +                os.chdir(self._indir)
>>> +                self.CheckFitFdt('fit/fdt_dir.dts', False)
>>>           finally:
>>>               os.chdir(old_dir)
>>>       def testFitFdtListDirDefault(self):
>>>           """Test an FIT fit,fdt-list-dir where the default DT in is 
>>> a subdir"""
>>>           old_dir = os.getcwd()
>>> +        local_env = os.environ.copy()
>>> +        if 'DTC' in local_env:
>>> +            local_env.pop('DTC')
>>>           try:
>>> -            os.chdir(self._indir)
>>> -            self.CheckFitFdt('fit/fdt_dir.dts', False,
>>> +            with unittest.mock.patch.dict('os.environ', local_env, 
>>> clear=True):
>>> +                os.chdir(self._indir)
>>> +                self.CheckFitFdt('fit/fdt_dir.dts', False,
>>>                                default_dt='rockchip/test-fdt2')
>>>           finally:
>>>               os.chdir(old_dir)
>>>
>>
>> os.chdir() is not thread-safe as it changes the cwd for the whole 
>> process, c.f. https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fwww.man7.org%2Flinux%2Fman- 
>> pages%2Fman2%2Fchdir.2.html&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf621cc8cf9734ea26e5408df46691921%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639307089341557615%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=WFtKIrZp%2FF8VWj2ks8w%2Fnx9%2BSHBhs2j%2F1Iybs6b3RLA%3D&reserved=0
>>
>> Nothing your fault though, and I don't know how to properly fix that.
>>
>> For this patch, here:
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I'm wondering though, do we actually need patch 4 which removes DTC 
>> from the env if we properly patch the env such that it doesn't matter 
>> whether it's present? If we really need it, maybe moving it after this 
>> patch here with justification that it's not actually used anymore (and 
>> was not working before anyway), would make more sense to me. Just 
>> nitpicking though.
>>
>> Thanks!
>> Quentin
> I am happy to just drop 4/15. The patch was only there so that nobody 
> would think that the DTC env variable was needed and in general stuff 
> that is not needed is best off removed. As for ordering, to me it felt 
> better to remove it first, which fixes both issues, then make the tests 
> more robust. But I have no strong views on it.
> 
> If you would like a V4 then please let me know which you would prefer, 
> to drop or move or just leave as is. While the rest of the series has 
> some minor optimisations that could be picked up, 4/15 is the last thing 
> in need of any change.
> 

No, I don't think it's worth spinning a v4 just for that.

Cheers,
Quentin
