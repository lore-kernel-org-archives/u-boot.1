Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9D606A320
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ArVGrRMq;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=dFxVLYx9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C40A60847;
	Tue, 10 Nov 2026 15:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqrijmzNrvTp; Tue, 10 Nov 2026 15:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA9AA6084E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794323414;
	b=NE/MO4BCTpDJhc3gR9+suoLMwRFoNi7i3iKBLWwDt1Z+/rmnCIoz7wf8BC3QH5Hw3BtH
	 BmVWZbf9J9h6CHYxCua4Vntiakj7xg1w/1QEe96tp73naxGBJ2Gj/KzBbuBX3PSrk8/H+
	 ffw16vjWixe5OkOMv6Hk8B47iWz/h/qXWFg3V9c8HlagsWbTw0HWEM4IKyN2UFwPL6Pbe
	 LnjIyr7B1ssUvdODKsIZcl5ImQLLqMRdRWkea2jwQMD3toS469ZfrdYVbqGdYkiNuXqVs
	 MtNstDYhagB4K4Pu+4NQ7ryujL8pBJIltNtCcBHTGQ6t3DeDUOxVoo1XlJ3hgMmSj+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794323414;
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
	bh=T91eufZNqSUfMn42AB1w39AROEgbOq9iCLrtxJeEr0k=;
	b=Hwhk+6rMW+3dthxehSyfhmYPw35KYUd8ILF6V3qdBITbt83O31k5Sm0P6PTfRVlLsqNS
	 JdjWnllQMJ/35ebS2BLc+96jyCKC9iex2XiG6gP+s3iiLPq0zVmTu7hVnyNGqINDO0o9S
	 GXYC665xjcEgzcLBQ3pRPdra+vntmXECFp/XN5excGRzxnFxV6VPWtXUOLbg6eaZDriXF
	 B5whbqxgyPPvzA38W3pYMuAWW0CE/G/ZDn43/dU8AaLPBjwdZlYCx+Ik54P/E9Yfa0lXN
	 eB440v0nqSyY9puQdIlGEutEJvgp7X4yrs5Ujqkcg1++ub9pskRc5kaglLJ6L5TNkqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=dFxVLYx9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794323413;
	bh=T91eufZNqSUfMn42AB1w39AROEgbOq9iCLrtxJeEr0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArVGrRMqSs/QPbF7Z57E2f8aqray7opSpQRBkxLD0L3LXlm74dv75tVukc1zf6IBf
	 CRyl8F0F5gC/cRF2P139M1GaYUwTM7bhFD3fYzv5xRk9sYBuVdo6pDhGPrdbbysw9p
	 ElDOzgQRH3unI1HA30Jl//usLCLAxNNcLqwrrqkwrsrGH6KOIOYI6wmBCN/0qEOaqa
	 EtnHa6vSrRbUIBDwDBX6BdtIcA9aHjuX4t2WwgeRk7pYTqa9hy0v0ur1J0XUB5XbmV
	 CRYuhwmxbc83TX8IyL08rTaD4+yx+nc0w4Ab8U2XRD2dMhRhHH3pklIK/60mK1y3Hu
	 686mzAAeb+pdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA9AA6084E;
	Tue, 10 Nov 2026 15:10:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13EFB388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05A426084E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foIeDfccGMTc for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C27060867
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dFxVLYx9
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C27060867
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T91eufZNqSUfMn42AB1w39AROEgbOq9iCLrtxJeEr0k=;
 b=dFxVLYx91MXAfPOOuyS+/tzTrvGCNp1nme281Mb2Wv8Hsye2RYOO82f52XuHOB+EVqzhT0w2UcAYuIulWsfYKddRIr+OkZRzNmzjKLdpgv82QgyoQ6WoDFi2ZCCOFKTVLsLsO8oxxKcl6avejvtFCF53GR8pkMVEi7hBXdYCxJ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:10:04 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 15:10:04 +0000
Message-ID: <dc357b94-80df-4c82-ae66-12db354fdaa9@cherry.de>
Date: Tue, 10 Nov 2026 16:10:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] tools: Fix typo in name of command mkeficapsule
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
 <20261110-qcheck_fix-v2-10-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-10-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0158.eurprd07.prod.outlook.com
 (2603:10a6:802:16::45) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS4PR04MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e001ca-0bf8-4eb2-cd12-08df3f3cb303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info: JL21m2eZ0ElCjZCXCb5QNIyW8R1eOWjVCvvtemX8Ruz0LJoHcQ9+efX1L/nn11XXl+SV9vUgt4PRLkEtEmoMhOC9XgWJA01Q2mr+EscUXYA4qm2vvYl6iILyheD5BVVYb2hFIur0Ivp1sNub4lgpjWytRRWY19VCyPgl8ngf1/uGS67Gd+GCplmLfCD4bXt7htHYpIQSNFdJkrEQqrsNQDmN8wHkvOb1wgD/DT91R01AkMw55eMCbauYKOGcxL41/umUea9mW+ZoH2ibw/syV2PTuzMMPOYPmnn7m4fefWJkoiftLVyktNHk8xsMkGhmwcovOSj2o/bQ7Wp1XXxJDl1H/CJytnHgQgfiXbrwi+Qjs3Y0GMfpI7AjhJuxpWRianqAV0W/uYHUrZF72TVtWqJihlOqdMyqHy6ZPtg494qzdAc01kjMsjiWbcm4dIBejAaL9q/C1LTe45vA/BoTCbzio1uiKEdrFnYc81w23D0z8Tdfd5x9/BpeAvgcUAIARPjSX+fFR0O90a711mMAESESoLgHMxSuhlc6lpGp53gxl/6r50Ykt4X7B8J66qvMx3IUuYobxV/58maDi+HZpXQgGkduqAdf6XoLVA5LSvysIpQQFc1YRZcLmJW/Xt5gyk0fISNqHrFSj7w97L2KzyTm4kGHm7VRLi6lDDrjzjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(56012099006)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxEcWZYdDRWNGVCUWQzVEUzWlFtTU90ZTRqR2JMaEhTYXI3bHFHV1NXNUpv?=
 =?utf-8?B?WTF4Q0ZmZENVeHJobkJyTG9OVFBHaUhZbi9SeFQ5Zy9QaDY4YmYzUmNDQSth?=
 =?utf-8?B?TXY2WEpQdVlsRTFueWhrcFZZdFFtdktwcW5jWWxJRWlqenVyZVBUNVl4VW41?=
 =?utf-8?B?T2VwQTJHNjJOWVhWSHV3RVVmS0hnY1Q3Yy9tSldCRHlaTGI3b2hyR3BNK1Mr?=
 =?utf-8?B?NFkySmUxMmZWemV6dHI1cVJFcEd1OWxHNC8xQVNFbG1JUC9IeG5EQjhwUGZV?=
 =?utf-8?B?c29rQ2Y5ZkQ5aTlkb29vUEt3S013UmNTdWZEZ0VENU96eWF6eEIwd2hKZEVO?=
 =?utf-8?B?QTFnN0FjbkR1TlFRZGdHaFVZNGc2VFd3U0pGK2NuajZBY3k4YldSczBLajd2?=
 =?utf-8?B?akRDS3RwYjUxcml0WG1Gb3JuTmpaNWxhMlBPeGhCOCs3ejV3eGk4NHloeW1m?=
 =?utf-8?B?VGluTXlYU1ozTEdjZmJ4VmdPT1pZQm9KNTlBV2Z2dS85WGZUYlhEaVdvMU9F?=
 =?utf-8?B?d0NKN3JzTnlRUHpueFFNdXZUS0VjZ3h1UFl6c25ZOWlNYzR2eHZ4SDRXblFI?=
 =?utf-8?B?M2l3MFkvQ2hDaC81c0ZKTENPQUd6Vm41QkkrRDVPZkU0SzB3d3dKcUdQQmVZ?=
 =?utf-8?B?OXQ5M0l4V091L2IvSlJNVThYRDR3alhQWTFTQnVZS3hrM2JiMldFVU9ub1kr?=
 =?utf-8?B?VWN1N2dWazdYaFRKem00RDE5ZU8vZEhlZitubDBlOEQxY1Z5NVk4c1FFQkRu?=
 =?utf-8?B?dGVNSXdTc1NZaDNOb0g5a3RQSDZpYk5hc09IaWlTTllOQVhya3paMVBEQkJF?=
 =?utf-8?B?Nk9wOHdBZDlaL3kyZ1Q3VEJueG4rcmFEMEJzNU5KeSt3L3cwdit1K2ZoTktW?=
 =?utf-8?B?QVR4anlBOFNkOXRETis4UFd3T2hsWEQyc3JnSkRqZ0I3dDlWdnFwWkd6aDRZ?=
 =?utf-8?B?T0lxdVJxcm1ieVJvS3F3Y1lKRjkwSTZvbUFtTmNXT0RuNTFQZzQ1cGRsZzJn?=
 =?utf-8?B?ckVzWXEzUWRwcGJvVGlidzJLUnhyd2ZVV2ZJVDREM1NDblpudjBMTzV4SjRC?=
 =?utf-8?B?U3hOZmJmSnFpTlRPQUtOMzBvdHBuU0lKQ1hNWDVmamtYRHlMekRxNFUwTnJ5?=
 =?utf-8?B?aC9nd0NIdjZTT1JSQ2dWUW5zTndzcmcrMFA2M1AzN1dsWGNWT2tFMEJGUUt6?=
 =?utf-8?B?R2NlcFk2VHBjdzhtZ3VKb0oySGNVUFkyT1BPUDBtYjU2UnJpdmdXQVRKMkhM?=
 =?utf-8?B?c2dCWEd0SzRIdVJIZzduOWpZbVFReWU3RExCNWRqOGpZN29EVHBLTHRpVldS?=
 =?utf-8?B?NFFEMmoyM1pBTHdKeXNmV0JyaXFiSHZzU3ZVdldYU2Q3YnJWTnZtMnh4eStz?=
 =?utf-8?B?UkFBV2JtTnJmeG9GNk5PRHJSazZ2YzBYdWJOc1RCNXN4bE1yT1NFZWpEdVgy?=
 =?utf-8?B?eXRlcW5ZQnVFYkRCSTRBOXl6aFNwVC9vTWQ5VEVuZm5iWDBKdkpEaTZBd25N?=
 =?utf-8?B?TkVTSlM4bnh2NmloQXZzZ0E0MzJIU0tsT01WS1lTWVVZWEx5TEV3WHpoWExo?=
 =?utf-8?B?WkRMSWJ1ajAvT1pkb1VYbGlmUitTejVDUkVaSVYwcGIvMkFRNmVJaXNBRnZQ?=
 =?utf-8?B?VXlPT1A3L0FnQmtpQUw5V09vYzB5TVA3NjFmZkhza2Z2V0lLZVM0VmhwcE9D?=
 =?utf-8?B?dmtVaXZXM24rekF0cEZCMVFWbzc3a0t2Q0JGeDFIbjhvMVRwL2h2LzdSaHNj?=
 =?utf-8?B?b2plUGx3Q2xPaG1VU1N4SERCQVVHdklIam1ELzhGazhvTVdld09NUWM4aXA3?=
 =?utf-8?B?TGpoZ0FnbE9LWmlCdlNkdjNRTHJsb3Y3endLSTZ3UlJNZm9MZWNhbTJ2NThm?=
 =?utf-8?B?SUZRRDQ1MUM5Umg2MWdNUWRQaTZvak1qaHQxV0lxZ3Q0ZWM4NVloNjF0ZHVr?=
 =?utf-8?B?SlF1eFAyR1ZFelhXOEhHTWxRV1JZRXgxaDEycXZvMFg2S2svdmlNRXR2WUVi?=
 =?utf-8?B?VmlEeGhMbm1NVlJxaVU5M1ZGWWxYcGNtVXNRVmNrZVZKaUNCNk41cGlUcUVL?=
 =?utf-8?B?cjNXMXhvUXY3RVM2QjBaM3VHRXdXSWtqdVdqV3VBQUx2WnZVSGd1LzRZOTZI?=
 =?utf-8?B?Q3QwNjg1MDIzaG1YOStFVlcvWmk5NHhoYWxyTTJYaWpPRE53aFJTQ0RHVFRV?=
 =?utf-8?B?UFJBMVJ2ZXh5MmhnT3BaWWdDODZKWENoM2RTS2VzdTJPZXVaZkpWUUhNN1dr?=
 =?utf-8?B?UkQ1NVgwWmh4YnVtdjE1SWZXanNyZjcvdjNqT2UrUSt6aU5LSHFjRVluZmhV?=
 =?utf-8?B?T3JaY2MzWm9aNzJDcTZjWHgyQTB4Y1BPVFV1UHVxWkFaVjl5MldZQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e001ca-0bf8-4eb2-cd12-08df3f3cb303
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:10:04.5215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc4I8Wth0saNloDRClgNwrUcgXMeY3+OosjS7gDCB6F0vJvDbTx/hf8AWuFb447PR5/dzZYDS+UpI8tkHkXStQrD9DjXN6f3WUKm8mmz/ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9386
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

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> The description for the config item TOOLS_MKEFICAPSULE has a typo, fix
> it. efimkcapsule -> mkeficapsule
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
