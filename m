Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75742CC6B1F
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 222C680CF1;
	Wed, 14 Oct 2026 09:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Evl1l9Tf0CHY; Wed, 14 Oct 2026 09:36:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 678C680868
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791970605;
	b=D1heSOdPXzbLlc3vaRnNty38uwo2iqQmTNRj1i3cQX7Lh/h0LuE+zi/Gpdvw1UebbIao
	 zkUFjOEBMhdoBbZTK3QHRdEF4fob65LTUnFKcpsy18LzA51megD0rMV7fAXy99CazcAft
	 6Mt03hVHxJlo8qjA7wGKb52fTNQclMlehVh8mLRID96FPJqjYWrSY5ipWFvJ04LaspXdu
	 uLItJ0fBXbGe0WZ5Y7XVNho4G94Q1E1BdQfjtBd1LX4TolPT9Tz5XR+Hj7gQyC680UZ/F
	 FLi676xLH7MavAEQbWDZxRO51aF0DJDqX/mtfvJeO77mdYuEkEiz1DrpUMDhnQontjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791970605;
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
	bh=xsA5P9UM4BP6HnJ09f4xXtUJ1jjCPXFotvwv3J3wQ10=;
	b=Cj3XV9AqleDCXbycvTtoKFigZ4ssT9Hojpj2CDiCHqXkpYr7rKh9DcxjER4A/KhKoqUC
	 JRez6JdNzpuvWMWtL9650TfiBeDtbcSp14Ke0gfeWUZeGfWuYdRNiHoV9SSFD+BeQr/IL
	 At3a7dP2LkSNX7SWrxUy2KK4f90Y1UrhMjF2FoyHJjMCZGskoYkD+1g38EGR+ev4GRJN0
	 tS4KtxOyQRadW+xVIOGL7l6TQIF4jni/cVn91pmcRhfiBGQMdj/v633sY2s9zN7+3v4Y7
	 WuNzsOrF/hIoXG5h4S1/nhnnJugGNsGbecSTbJ6AKjWWOM9nOgufX2UFHUHqvjHSvEQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791970605;
	bh=xsA5P9UM4BP6HnJ09f4xXtUJ1jjCPXFotvwv3J3wQ10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iP2e+7607j2MNJfI30LTj2PpKUPri53Uwt+arhRI/BJjFNR2Ae40hBEf6pCMqSTp1
	 R0gxRgZGISGEva2J2imXmOJJi9pJutxRNOzZEpA0C3q+TBDnRpi+pw52v/c4tHE8hv
	 xX/LQVA6MHuNDSSxWlo6hK+HYnXYImfREFshf1q4CDi1a+cDfRyCvgkIkBTO8heEzV
	 QmJaPDPPVzfQLsUEfjfotCE7R2Yp6zFOXBk4WUqRvwKo1c7yfC1gkSd6hCgLvz/F44
	 ZfkIqVrIGWHIcxXJwyEcgU1jEOkNilsnbdX6E+REu1AACq+y5SKb5Woyaf/DercFF7
	 3eODUKu5Ln8+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 678C680868;
	Wed, 14 Oct 2026 09:36:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 503841DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DDAE607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zB18UULZdBwc for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 09:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 243C760816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791970603;
 b=EODtYA6Ok9zPpORZzGO02u6kr6oWYqMMw0TJJDriN8vKRmnqyo7DMBHbAG4egkqh1hQD
 h8tKZU2yCvRSzQDlNcJ17sv/50fv2lBwJjD818sS/fl7u3f4S4I54HdkAnL8nfjw4QUQm
 /G1ctFEGcET4kj6r5BzOeqVgME/+vqtuJX54rrC3IxUH4Ds57ye8TCXwcDk/GPVFlwa0z
 gt9tgfj2HSVFKWqSQoKHYZ/K9FvgfJ+3ikK+X8tA8ZDTQDnSCdwZTT1Gxlng6CZOmb2CR
 abyRXN9CkFhlX20Ps8B7KlFLdFjd7tl+pEMlyunw2YGEHOnKsMS9x1Nygj4Ijgz1fpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791970603;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=xsA5P9UM4BP6HnJ09f4xXtUJ1jjCPXFotvwv3J3wQ10=;
 b=WnpOQ4Uog+hLap8mcvttHCUTzZG/JdUnsJvKBbE4rMv+JFImLZ1riWZs3SnJ9JYU0+cv
 u2DmtyJ3/YjG3kvgSnFCsw+IwCY/F2lMz0r7ymmUlvJF3IQCL67naKp/r6rKlNOvXTI5t
 mWW3cy8GdnwjHn5LqdR5CT22nKQewIJaVlUOSUwgiMsKO6hdOv3jNwtI3m2CO2p/OQijA
 R4hYtaJ9zBerufbQ5TuSqlBYDpCikHnkA+tLHzvf3AgI9omtx9fgljx5iJut52YSv5Xso
 t8u4QtUUnS08KMUfPL5LBvf9AiHPRctmFJMyiI/YEdyhL5LY546Hth9BMEicsX/tKCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fytSgHsT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=fytSgHsT
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 243C760816
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5PP88yc5LTdtJTmab5bXPDy2dQN4liXAFYw22hBfLpkAB0aaDEizCkoiJc9tVu8bxDqh9vgHScwBbTmZxEW1Fe/BH6left+2vpqm60+ZbF+ZCAePhQ9qmCLGtY0MCzlS6op2PTtdUaBAPbDV1PRVzrjmr49XonS0dWE4FIw16pIMJH4ZKx558DPa4lHam2uXa5wneb5nRh/uKj8Szmjk+eeLHGWzLdRQlmEPycpjC+E7YlESU669lTmNXifrapiNEaKINApiC5I0lL/hW1vvcxfDDM+gVG5WAF/qZjML1RyMXZB7BtRThZVhn2cCSsnPh7EQPRQInpDFS2qVW9bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsA5P9UM4BP6HnJ09f4xXtUJ1jjCPXFotvwv3J3wQ10=;
 b=UER88dYLS9/Z1R9V3WgirluoePV8JkalUBWaVcr7chzJPOHbcIEPiZjyyPEltshVYt8WcfxFHrcNaCJ0KsgZYj1tkUFX3T24h9oP+5Ik2PLNjXl/j8uX6xHkHUnIOzW0UWfnJJ1oyUSi6gDX7Nwhw/HoZoW0oGFbW4QL8a06+0R8vmbrOQSgDpWWzxHJmwG6Z1tXaBrw7byI6Z90cig/utf4rDtnCMM60dXJRpBrmsXspPLn9cnYUSV6wZIFsBERslxSbTnavgUsNDGE2g7cvdpfJpLX7/HtB1smfGoVv0LcX5/+yyhGP//VJuExGSeka1V0AQmZg+P5spVHhP/+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsA5P9UM4BP6HnJ09f4xXtUJ1jjCPXFotvwv3J3wQ10=;
 b=fytSgHsT2W3PyXAsEstlVgQZVelPuNpYpJJgAqJ7A+RfkcW9DdYyf6/AhX6IBNBEqxfqMOIrLhsEX4WNexoojUVIEEjbwMQ37tJNQ0kbtfhUev+6K39j9HCf2PuCzG5K7TUZUq2PUIOs4qFq8oBxL47k/KeQxArp0/B9SloLn6Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MA9PR04MB529725.eurprd04.prod.outlook.com (2603:10a6:250:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:36:37 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 09:36:37 +0000
Message-ID: <3267c66b-43f0-40ac-a3f6-30ccad7d84ec@cherry.de>
Date: Wed, 14 Oct 2026 11:36:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: rockchip: Remove useless SPL_SHARES_INIT_SP_ADDR
 check
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-4-11bb20983682@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002-config-v1-4-11bb20983682@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MA9PR04MB529725:EE_
X-MS-Office365-Filtering-Correlation-Id: dff998ab-ca0e-4da4-9966-08df29d6a47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|376014|261009223027099003|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +aV+FQvO2GGBmmS8mTDtLRkeYrdd/+EMTwWSMCxTQivYXueO1DCgFbDHLMxPAV4eIlyYJYGigpeyASx/Yk/XBZnJDQpyDj1avhopG3WdSgcniLTljRwJzBzD5ukGBGxj2SVzQWFna6gV170IhRhY5bdPBcWOOE0QlZboZK5WUALaEm7uTqFNvABzU2MAokVi7hroRQtA36ns0ubuL3HeWo+cyTuRJINfBl1PwPTYqHHlH2Y/LtGYHgNjiY5S6VPutQaBtovIHzTpD+mEGlftsJ6em/xJXPXHWAx4HfrZgXGNZrCsyuUr71g2ZWdq9u5TRRHJduYEG9lSY72vztiD3y8jaG3gP1YOBBKdWLoLk899yLNHDHQcqzRJ3kjVjsq+ms7ymvCcOckiRKnjpEqHKGJz2bqkzNx4BqzGlSY64+oJeaPQ7Jp5mMR16Uj0wv2igGD6e6ZgzR6zQtMB4NM64EURKeTHrlMldc4wbkIEmT6KYMLp55v31CCAinC1L45BKt9woWglWYOxvULZXonPKNzT9f9ai1luydK3SJKz4WYR1YVLA+gbyiT+NckgSpsjMaTDeSRgwRH5UrJSPoNrL/PeIXxtmUphVhejvxu0WzPEgaF5DWPx73fbk5QWh0CeCQs7WkibEe5Iu6qIZ7D+Drs+pJlKYRA55R5TspNKvPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(261009223027099003)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJOKzhmRUpmUXZySlloRGd0TjlkZS9PM0ZBOXZrSTZ6OVZLVUVmdlMvcDFu?=
 =?utf-8?B?RFptN2RBZ214MmdVTHpVamZKM0VEV2lza3k2QTc5QVAvb0hWQjhuYzlHRnhN?=
 =?utf-8?B?OWFnR1NXQ1lPTndTYUFoTHBKQSswbm13bW9qd0ZHamhDN1dpQmZlaXZpNnk4?=
 =?utf-8?B?NUNJMmxLcDZDRG8xbzJod2hGSXcxc1FVUndDVmxoRHBlY05tZjYxdlA0S3Ru?=
 =?utf-8?B?dkJncFMxa0xZYWdPYk9tVTVsR1YwRTEzdi9vNXBkWlNpR3JiSWNONjBCZFhx?=
 =?utf-8?B?RDJKWEszZnQ4M0M1UHNDdHZsbW4wVXBUaEJQNXZPSnd6TFk2dHltUmN6VytZ?=
 =?utf-8?B?SlBydEpjOGVOMVA2bVN0QlFFQndsSC93Z3lsdmVMS0Q3Tld0NHpGVTBxR2JL?=
 =?utf-8?B?VjZtVDhudnk1dk0yalNMZDRMaWI4ZzhrbTJtOGtkZXJWWXEyQVYrenFadmlK?=
 =?utf-8?B?dExadHdVVWJYMG1qeWFkWGdjYVF0TVRCSlA2Zm1YZEFSdmFpQmNYcC9JZ2FT?=
 =?utf-8?B?enRhcGFCT3Y5NkJ5UGUvQ3ZsZjRpcERtUFo3Z0JDRTRTSTlldG4wQU1ISGhZ?=
 =?utf-8?B?QkZXekU2UUh3SGswME5uYllCUzgrVFEzWXB1Y09hNkRZOFR2Z3pQRlBvTmx5?=
 =?utf-8?B?SGVvRUJlN0U0WlhwRWlva28valBkTktycjNJUWRUVDNwM1ZWVDJhMURrOXox?=
 =?utf-8?B?MURGN0kxTHI5eWh4bkREQ2pNaXQxaUM0YUtpeVFmdzBBNWxwR3NiOGxXclQ3?=
 =?utf-8?B?VlJGVGRPTXA0MTd3NzlYQ05MT0krSXE5VWRrMnZVdU5wemhmUWVUZzU2Q3Y5?=
 =?utf-8?B?N21sMWhkT013bHVmVXhoMHd2bnlPNEoycWtBbS8zZEVlelp4YXY3c1Y0dHk2?=
 =?utf-8?B?RmR2T3NlVTV5Q3lXZ3VTa0pXenZ2d1p3TGxrT3Zubm5NaFlkcmxaU0V1TTJy?=
 =?utf-8?B?cUxPMHZhOHMvK2hFOUFteFpQT2hlelhhRlBiL1BtTlBFQ3dJV2dnbzhDSnNM?=
 =?utf-8?B?SFd3b1c4N1ozL29mcU9SN04ySFQvOG1JNEV3RDduY3hBNEFVbGtNbFNRL09F?=
 =?utf-8?B?cEQzU0F6cEZFSDVseGF2bHFFV1JQM05EOUQ4SWhTelRIN0Y1aU9STkY3ZENI?=
 =?utf-8?B?eWVQL3o1Ty9SWWVSMUJqVmlmWC90aDVVRDdYTmRyajFDdkxmRGROTVdPTzFa?=
 =?utf-8?B?c0RzVUtwK1puV3Z4R0JMdU80UEQ1Qy9kMk5CaG5HaTdKQmxYOUdmWFEybXY0?=
 =?utf-8?B?ZWFZV3RUTm1relhMUFRMbkV1UURSTE1YT1hTa3FXT2FPTG1PNFNhODJSblEy?=
 =?utf-8?B?TUUycGNQQlFmZW82N3RXTlQ3SXQwT0p1VUR5WVJzMTNpNkVvUkVkVlJIeFJ2?=
 =?utf-8?B?eHdvWjd0dlBPeGFRUFo0NUNUOEFUcitaZGNPdUlNai9icU5mWHB2T0RUZjZz?=
 =?utf-8?B?UXBhYkYvVEhLSkp3aHlEUkJ3d3l1K096dmFNcVRyb1dPRVNvN1BZa0RYWWFU?=
 =?utf-8?B?M1ptMmJkRVFNc05FQ1J3NVFVVi9rdlpjbmZHaGFiL2lSbDJXQkllOTdiV3dx?=
 =?utf-8?B?RGo5cGtwL084N05kQm5jNFJsTC8xcHcwd0ZjYnZRMU9ndGtURlFtZytBZ0pU?=
 =?utf-8?B?Q3J1bmlscHBGRFg2ZHREM0xCalV6QVo1dGxYajRyWlAySXgxNEgzUnR0dU9G?=
 =?utf-8?B?NFdBNk0vZ1BUMFFMNHJiVWpYZm9SbzMxeTNkVmQ2dTBzV2Z0UFltTHlsaXFx?=
 =?utf-8?B?UXFBcEJZbXdoUWJ1MkcvZGYxNU9qTWxNVUh2M25RWkxvSERsZkpYTVFmSTZP?=
 =?utf-8?B?YUxpZUNWcXpSUjgwYWIwVFZ4T1RYRlFPeHUzd1FxeDViUFFtZ2xHNHllb3FO?=
 =?utf-8?B?eTdhcXpDSkZza2pYU0lZNHpJSzVxMXZuSGRyTkVWYUVSalA5TUxhVlJ3Nm1q?=
 =?utf-8?B?L2dhWmYzMXFVN2RKR25LMFM5VU5KTW9kdUZDcy9pZGtKcFFqZldLVU45TFRB?=
 =?utf-8?B?aEc0RkxEZUVQT084QmI0ck1qemNYZVBZZFRSZjQ2SCtvdlMyT0lTZzIrTFVV?=
 =?utf-8?B?d1pYb1BDV0pLRWN5NG9taHFhZEovVHdXdHpLd3NQSGVWdm9HbGVFcDdhY3My?=
 =?utf-8?B?cVpPWU1PSklkWEx3dVlLYnh0NUtpTlFORXBPOUEwV0xYQ21DRnQ3NWljd1JK?=
 =?utf-8?B?bVdSNDZTb1R0Wk9NRlkrN0FOWE9IZGhtT2RQMzlrN1BJOTJWeGdIS2dwYWJ5?=
 =?utf-8?B?ajVMTGZRWDNid2ROMWlPMU8rS0FoQ1JIc2FueFpDRlhvQnZqV2VJMTlKTDlC?=
 =?utf-8?B?YmdYekVJU0RhT3ltZ0UrT3E3cmlVcE4wQjJiMGdJcUxPU2ZTSGtjbDJ5STUw?=
 =?utf-8?Q?ll08CzBherdXvNxeezGwOSQsrKrsPgaBGRBqm4YSodBvy?=
X-MS-Exchange-AntiSpam-MessageData-1: N4ok5B9yST0gpg==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dff998ab-ca0e-4da4-9966-08df29d6a47f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:36:37.1270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Rb+ICYIBXsnyF2HNnTT6mkABAyz2c9sQdapeWSVRthRaom1DmWQp2+7JdXs7ZiwWFyaCgcd7VVscojfYZK0BpnvrHzFnOtXq16D46yhncs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB529725
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

Hi Massimo,

On 10/2/26 6:36 PM, Massimo Pegorer wrote:
> The ROCKCHIP_COMMON_STACK_ADDR configuration option depends on
> SPL_SHARES_INIT_SP_ADDR, therefore the logical AND of the two options
> values is equal to the to value of ROCKCHIP_COMMON_STACK_ADDR.
> 

Fixes: 008ba0d56d00 ("rockchip: Add common default bss and stack addresses")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
