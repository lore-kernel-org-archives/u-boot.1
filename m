Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCBE606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e3nwVPNC;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=VLY9tOS7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E623140812;
	Wed, 25 Nov 2026 16:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjjV0w5CHrM8; Wed, 25 Nov 2026 16:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E7A74057E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625452;
	b=F3mZ3Bha9NHw05aM6cYcEKz2Yua8hjVTJ6vrNgLkEQPVfM2US9by+Ad6VXo1tFfAAUn3
	 km19Dwf0swbnmzAD0nYXIAcAD+v1QBnW/t4pH/0zAuPjtPzvahPcXwTNwTn55HGVDiKN4
	 4MtLFdkd1pDu/9MZLrU2MZ3nGlF3H/bVjy+842wjPoVHMiPtqLJ7fhcFXxCTUScVLfQ5j
	 V/Luwf0hNDe6eR3Vvu6GAEKEm0/yGJY3o8kFgxpsmtZd8U3JDufUHgAdS09tSP49sELaH
	 bxTKwRKPozBlaDikHaDCLLvGJcB2gJtIvijiseDvGgIHzqjFa3DCVKh8XTX3/R6SoOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625452;
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
	bh=04ePscJOSuwqS0oiENXQj3ayPNp4QtK30OI9fO5k7zc=;
	b=P61sbvhvLUYjhBqj8g+DNrjNetWcxJmsA1YcI/Wz9THlVFAedgNJzGk8UY+sMahUcJIg
	 cz3TdSn31FtMAT/HLXEgPUXVpaV/b5FkbPjIH6xpE58SvlZCioZUlS/WxOpPV+VlPZGmm
	 taPwn2E+5gyAGuieUjwzTX9gTLMk6uSO149ZA4rsVv7DaoFuXol2FJ0Q6yMEM8nWmp6dp
	 nbWaOUBb49x+OW++rZl7tfH1QBmB+eMhWJ1rDzjdiRD5x8LSJulKfyPE1AhaY7Kw6ya93
	 q3RIkRImqhjCVyhoqNipYEdRzm03SF9GzvN9TE2PMXjfB2lSbGMiv442FBoyVJqRxEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625452;
	bh=04ePscJOSuwqS0oiENXQj3ayPNp4QtK30OI9fO5k7zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3nwVPNCCcFha3zIIEfoFq/SQWCxyvtCxc0AhaR8bOb9iLjYlGsBtgCzrIUZMWfkA
	 16K7itocuoavi8dTpJY1CXkzIgOD9GkJEod5bgwp5r8Q1+pBJJDx6pRaxyQhEQQZyK
	 PNexPYLD3QAXuUe/dkem5Edk+KdoBvEcRPWpeMfJxPNQyXqMXLvco7YK65+y/FkRWR
	 VaWG5QnVb5i86BSb/+QV5w5z5+Jyx9sMi7ZEzRnL00dFxDJkqPeDkJF7Cz9RlB7ZuU
	 umTsI4Qi45lAXNg3792YSrw9Udi9+ly/+1nmIOtaFeHBhTpax9A1qmXyV+TvH6yzXl
	 uRyJIthDFUnnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E7A74057E;
	Wed, 25 Nov 2026 16:50:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AC9B26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3806980E36
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L19ElaRrXRIn for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BBC380E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=VLY9tOS7
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BBC380E31
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ePscJOSuwqS0oiENXQj3ayPNp4QtK30OI9fO5k7zc=;
 b=VLY9tOS7nw0WG2kDteHOAd7yMOQw0eJwSgJnw2kIC4+5mr0Uwc71NtxIxgLfEypvocpiNyrXjUNxNDRXc8uKEPxVIJb68oouzx1nmVkRXyoqRH8uqDypoeESqHNbinen5ui9tq/xEGXf60pgg6YocamhchLFoKhhkSnqa09cI8DCLEp+8/nrBiww0J7M2JbJppEpfSXzn87QCFuFUbbfAkvXIqW6wlxLG3HTv+MRReCaDHLA6St0dBLXG4tQKk41/zGNLtqOQp307SoDP2MUwCIYswk4Kj2+JnWgQ4cnmdzNnMqLDx7iT4N3hDQVgUHe72RnqU1m/88CWYxuk21/vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:50:45 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:50:45 +0000
Message-ID: <49c9c222-3d36-4ea5-80e4-2bb036d6ac55@phytec.de>
Date: Wed, 25 Nov 2026 17:50:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 3/4] board: phycore-imx8mm: Start fastboot when
 booted through USB
To: Thorsten Schmelzer <t.schmelzer@phytec.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Benedikt Spranger <b.spranger@linutronix.de>,
 INgo Rah <ingo.rah@linutronix.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
 <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-3-dd6db9e5edfd@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-3-dd6db9e5edfd@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cd2e62-cbe9-44c5-e188-08df4b143fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|261009223027099003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7stWcJmTGJnZ2cr1iwCQeM0LtjfvHjo3Q3kG7VoZicnFWXIndOdyhY1wadIfUH2vniJI6BgDFKtK8ZlbQXkmW7f/+zfSk/RGZFFnm9+VOXZ63seEeMDcksEOweMUJ/qKgwLYZhQ9T4R4BZRfzUWbw5F3IemcTjfoQ0t0ug8OhkrW5XI1uYoBXSi5vOx6AL+vgMjIe5rCLVS1fzh2Xga3vc00/BwmFEXjYWfAEhOOShudmiEMIwtibu6d4ijO66W4PcdZ8Vp1M+TgfbDQ7DSrSdcoBVSG2dlSGVGOWZo/r+gIM12ZnF37WbHqYWXCjNg69uRNotgg2a7P0lyRskMl0+3ijTU0j4QE+QULmHtXp6K327S7mcKRpPskjNNAGl27kzEM+PuRotLfjZ0tP0wyjrJfI2PHVjwfHfm3h1KH0f6DZW+r4p6zynOsSJ/imA6wCSnQrfVK7rNBw8Jrsz8Ird2UmMp/7hIJaonEvt2jCcRrIj96DBrZAZ+EszMzEnDonIFp2Kn9b4iyJbMvgzSSjWa4hXo+a3kqrEpWtxV5DWE3pA1TfDxJwGzmLmY6NMs8/U5FnYkvlUy1eAJvsw8aFkni8jZqVkhoYRr4ksxxyJGPWs565pvWac0rfPB6XO8QFFFjrfOswRtZl0Q0yTWTs0OcPW5mRADFwA2X5cRBMRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktaK05xaS96M0NwTjVIRGw5RUR2cVo4dFNyV1hwS0c3VStUOUFJTDlTQXMv?=
 =?utf-8?B?c0MvaWpSN3pqRVVraFZSZW9lMm1yM0owMjlqQWF2VkNBVUJqK3VuTG9zbXJB?=
 =?utf-8?B?NkVpMVh6eVdjaW9BekJqN1UrSlVoaG54YjY0NE1ON1djWTJ3Z1FiYVR0V29Y?=
 =?utf-8?B?UnZUclJzcVlxNG41QjN4dW9pZnRlUUJZV2dBOXN1cTBEdDd4U0gybVZDcVE1?=
 =?utf-8?B?OWVtV0hWaGU1clozL1ZQY2JpUWw0T3J1bTJtc0NRY2NyeUYxRytnSnpwdHJD?=
 =?utf-8?B?NDkxSm0vcEpBalZweFlpcWlXa2RXemp4ZlcrYzVaYmROOXFzd1lYekp1cG5x?=
 =?utf-8?B?TWNqblBFcXJUeitpRnBpeHhoaUh5WWgwS1ZrNlVvMmVxVFR1cUNIUjlvT1NV?=
 =?utf-8?B?cUpFcFhyQytkaVRZLzVvVFZQRitKRHJjb2NZRHFxUkVtVnJIQXVMcjFmRlVH?=
 =?utf-8?B?bC9oV21qZjJCME1DZEpGOU4vS3llZ292aGdzWVpXbUoxaExqVFVuQ0txZStt?=
 =?utf-8?B?QVlvR3UxeWFwMmowR3hlaXJpbWJLd0toV2hVa1RDQURFM3dkcmJnd1l4Ymdt?=
 =?utf-8?B?Qmw0UWhTMUhMeE1KbTZTV01yNllLc2wraDkxMEZzbHZYeFBiZlZDVG8zQXhG?=
 =?utf-8?B?bXBPanN6OEp6VlZkZDkwOTUrK0VIMGUxWVh2NWQ1c2R5U0tHLzBwNHovRitQ?=
 =?utf-8?B?SFpISUZwcWFLdEVlemN3OGUrVGdGZmR4MGxsblMzcUNaN2laU1hmYTJCY0Zh?=
 =?utf-8?B?QW9wRk5zVG5FRER4SVMvcVo5WmN6Y0pIV3FDWE9Jblc1Qm5BVVR1S1RrdmNQ?=
 =?utf-8?B?UWhpMERuWDBhV1pyYjZtU1FzM0FucHdwMHZpU1pEMUVyUk1tT2xZK1Vra05l?=
 =?utf-8?B?YThxK25wS0xpWGlQNC95cUtKREo1MUo0WXNOd2Q2YU9wRzV2aCtpWHlsQUJ2?=
 =?utf-8?B?a2ZNb0dWWWhEcmFPcTZtc1N6NnJ5UmJPTmpycU9TczRhT3V0MUdZQ3QwUGpE?=
 =?utf-8?B?dlBFakxzSlUrejF2emZvaUhlSHUvS0JLTTJxZEYybDFLZTZzdjBhQnFTRSs0?=
 =?utf-8?B?MEJDN0YvS0JjVW9vYWhJTlN4OEIrNDIrR0lkMmxxeFV3SEJibjZsb3FYc2Nk?=
 =?utf-8?B?SE5VNEhRdld5WnFTR0trdGhQWFF2Z1o4Y2Q0aVp0TVc1QUg1eUIreEFEd3lP?=
 =?utf-8?B?MkxUZlVtSHNDRlNwQ2xvMWc5dmxQc2lIbXE3QTF4YU1OYjZ1WllRSWJiV05y?=
 =?utf-8?B?cU85ckluQlRYTkVlMjI3THY2TytxQ0d5d1FyOVJPSEhudGROblQ2VzFBR3dq?=
 =?utf-8?B?d0ZoR1dqNkNBdEhYenB3TGMreEwxNHNxU0p5aDc1aWxOaGpwSTgxQlFsNXMv?=
 =?utf-8?B?RWM2NmFocjBNdmh5L0E5c3lEZWZQT1l4ZzdmOXZLemdMQ005eEtsWjdrUUJp?=
 =?utf-8?B?WjBKRFJ6MFJXdVM1Y0E0UWRXTjNJaDlDN1lRSFFlUUtFTkVLZUQvRkhuL3pX?=
 =?utf-8?B?S0wycjZaVGNFWEdhaHZLVFFsTkc4cUowNlFlenErdXNlaXY4OWh2VU13YTRa?=
 =?utf-8?B?T2kvZDJ2RTUwY0J1VjloeWZCdE5YRXY0R3gwU0ppbE1aUjdVdUQwNEhNWWVr?=
 =?utf-8?B?ZWFwb1lVRkR2Y3c0THBOelVVcGJoQ2U1akw2Z3FITjZKMC9IaFBJS20wMCtw?=
 =?utf-8?B?UnVVQVZWcHJ5SzZsNnRKUDlyQjhyeGpMak9HWVRZUS9TRWNCT3lpdnNxdlV0?=
 =?utf-8?B?RUdhdW1jbXo4aGdKMXhlVGVGT1hDZkRnM3U2VU4zUlF3QnZ5RDdFMEpqOGJC?=
 =?utf-8?B?aTJEMHNvNXRwV3pVekR6a1NLQU0xODZrY3k0N1lFblB4NWpYOUVoSDk5OVNG?=
 =?utf-8?B?VmVTWUxRTlZPOGdjSExqUjI2UzlOR3VEdytUVFpoVFdwWkRpOGFMbDZTQzF3?=
 =?utf-8?B?UzRpbkthRXBteDlrTHhRK3NkL0poQ3pZNUlaaFUvNVVWWENrclZDTm9LM2Y3?=
 =?utf-8?B?RUlOeFNHL1lCUWpYNXJoaU5RSjNrQW1zeTRNWGFXek9TYUk3TEg3NnpyMWpw?=
 =?utf-8?B?aWwxZm9mYTE1TTN6Z1FLNjhGQjR5SXVKNEJzVXl3UTlDdjBFamVweGpzeU1W?=
 =?utf-8?B?dFFyVm1HenNFNWhQdStmMnZkYmNtK1RLYndhWlFLK1drYUJFcEF4SlBGMmQw?=
 =?utf-8?B?UWRQVnV2MmpQbkhIT2I0UkorT3lWbEgwVjMrY2g4aTNWb2tnRTdYWTc1eHlj?=
 =?utf-8?B?UWlwdk9vUEl4RWZGc253TVVETzYzNm5PU0ozNVo3cFE1T3hmUk42VkNCcUhI?=
 =?utf-8?Q?VRlRHwprTGknF+b0mr?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cd2e62-cbe9-44c5-e188-08df4b143fe0
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:50:45.4397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZT/9XCJmpUqeLlKmtpQzlbyydtNtb5y2PELkQHq1/bCAqYpxa+T0sYqwmaYdzay+Vr1vSMhnv3N4S5Jq97lTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
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

Am 19.11.26 um 15:12 schrieb Thorsten Schmelzer:
> In order to support the complete flow for flashing with the UUU tool,
> fastboot has to be enabled, when booting through USB has been detected.
>
> Modify the bootcmd in board_late_init if USB_BOOT is detected as boot
> device.
>
> Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Reviewed-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   board/phytec/phycore_imx8mm/phycore-imx8mm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> index 25e51dce7396..6e1e88a0a47e 100644
> --- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> +++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> @@ -45,6 +45,11 @@ int board_late_init(void)
>   	case MMC3_BOOT:
>   		env_set_ulong("mmcdev", 2);
>   		break;
> +	case USB_BOOT:
> +		printf("Detect USB boot. Will enter fastboot mode!\n");
> +		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
> +			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
> +		break;
>   	default:
>   		break;
>   	}
>
