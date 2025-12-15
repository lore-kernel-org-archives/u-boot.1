Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821C2D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 05:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A4780050;
	Mon, 15 Dec 2025 06:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KWhq0NSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA84280077; Mon, 15 Dec 2025 06:05:08 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B555F8003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 06:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUmR1jBNcSJtx36MTP6w+nsijY5rwxqaL+qLQpLuV8Tye03IUVUS/eWe9QHEBPi5rbB8957GO5cPiMGiFDvUX3wnakfztrur2O9Ypi86ZFjghNceO3Ec/2wxkVuctvRcpu0Fg+F9msFJz/kZW6ErDTwXekXdRJu13YKrXLPdZpiPOjdwuOWEBe79kGRZ+bMzEigTY9gBXZo1JNzJxM1Vvu+Pg+ax+whhUFDx2cBrVhz2fLEgGhXfhhUFfHUpBZkXwlzx5bsD18IrkFiQUN41VVM57qqWGy7Jt6HayQfvN1WPxwcqdVojgVs3uusf/eUporn3ckky8JpCCXYAZ/lXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kFONlGGzkXHQ1DCILhOxWiconqruUOtPLL+90EJrCs=;
 b=Y5iz0e7j9cfuT9eYfPTWuFUNBUOaUDG4ffJgONC73K/rgkYRlas9YDGZSw3x1xxS1JhmOw/vqCNibLZNwGFSItoMh3dCcLlUMGNyO6kci228kysEWUPyJn2nI/XKIKsE0IhL0wChdpPP5lZlKepDe+cRTnzviqTZln6E38jLDTD5gvmgko+s8IP47jyB4HGKfMSELHhAoOjyOlFsK4F5P9Ef9Qld6fEV5bd9T6QD/gJOQ17vRaSIOVm7Jooyh6ABfzDMGmelXKYlZJD1osr1b9mxHedpWVzTNP72LotDPyqvG6omQHSHFXvmaUTvR92bphWtVppXP40k2IjnGsVNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kFONlGGzkXHQ1DCILhOxWiconqruUOtPLL+90EJrCs=;
 b=KWhq0NSGnig9+OFQzQcveJIMC82eXZHiYYiPHTFsy1r+mn57Y/8nBLPj8LrXU6lAvxkfDCLGGuwqmx1HTiRmQUgCrAW9obXi/FN2D7KO+ERZjrSLbCQG7T0KhpVsYdhJCiT2m+tt6+jdr2ER/IMarqnSMNGtf5ZVOQsb0kNSXsO2kNZn2EvxH2z9bIXURpRh4ikkaPz+TbwND4haIcUuLEgVwkHzLM5NQQykLxUgqH/IdvYMuY3wiBeT4qpdK6gAV0VElviguL1bKCVzIXg1H7RzFXh7ycwNjeC/fkZRAngeec/1C9aWWrFMU2i8UJa5qj4iSpbarmOa95PIXFmSUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DS7PR03MB5445.namprd03.prod.outlook.com (2603:10b6:5:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 05:05:04 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 05:05:04 +0000
Message-ID: <80f1fd63-2cc4-4aeb-88f7-6c28f066ee9b@altera.com>
Date: Mon, 15 Dec 2025 13:04:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] configs: socfpga: Fix de0_nano_soc boot
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
 <69dfe7e155ee00f039a00dd52ae7968bed0b8c94.1765470899.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <69dfe7e155ee00f039a00dd52ae7968bed0b8c94.1765470899.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DS7PR03MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e8204a-c057-4b28-914b-08de3b9781d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BCYUJzajlnZG9WMU9SRDJ6VnpTZkN3dk5tMi9ZdXdYdXUrZjNCcDFQdnlQ?=
 =?utf-8?B?VmNrc0ZqeWRHL243UTMwQjczckFWS09PNm0wWjNrdkN1MmJzbzhyMHZWZytD?=
 =?utf-8?B?QXJBYVlqZmFwM3ExczBnY0VMZUVrTVh3bzVSM1dqM0ZwaWppSG1nWm9yOWtN?=
 =?utf-8?B?dzR1OXlOVHZyZlJHcTNOVEhIdXRIOStXVktYMURuQWhzWmJndmdRalNER0pp?=
 =?utf-8?B?RlJ4Nnc5d3J1NCszM2ZkTkNjbktFeUpkV29DMDE5UHhHb3ZJYWxtQ252TmRh?=
 =?utf-8?B?UFBFMjBMd2F2RXJjdWdsYlpBL1VoeWpYSE9mQlJqeDFFd1VzcndxK21tMEx0?=
 =?utf-8?B?UGVoNElZOVBHVTU4eTRnQk5BeVAyb25nUHV6VVFXV1d3Rm5sQWV0by9JbHdL?=
 =?utf-8?B?RTNBRU1ybkdST3B3RWhZajNUTkhhaTFHaVN2bUNhYk4vaE85enNTMi8vNUND?=
 =?utf-8?B?Vmt2dysvbjJ3Q0UxcGZmZnA5VnpHU29vYk4xVVBNQXhKMFEwQ2dlbkhyM2ZM?=
 =?utf-8?B?R0kzZFlOM0JEbWNaRm9QMXZabWlEMUwwUmFiUHEyM3I4Z3pGUGxSOHpyenYv?=
 =?utf-8?B?MEs3emFxUlVucEVrTlB5MnNrSjUzOXAwK1VuSVk5RzNPdzZxTDhsUGVmdGls?=
 =?utf-8?B?NFh0TVpIWUo2RkV6Q2JXWE1EWExjVjBGNDVjVG03dTBsWEx4YmJJMXJBV2tG?=
 =?utf-8?B?Nm1GMDFCS1dZQ3dWRmx4dFd4dXlwd3ZiZXVCOXRlcDcrYjdDdUlDZjFZNjJK?=
 =?utf-8?B?RENkSjducjdqU2JFS2tydVkraFZPRTlKdS9KVGZUMmo4ZWZidWlZMTV1MWlp?=
 =?utf-8?B?UUVsT2hsaHl5NzNYdEhsSDFzSEltOGtiWUVUL2NBa2R3bHNmYTEyai9hZ3Zi?=
 =?utf-8?B?OXRIVXBuNTloSFAwb0xxTTg4Q3dySHRMVFk4ZEdjMThDZE5MOVBhVEVpakh1?=
 =?utf-8?B?RExKQjZrS3pyT0RzaU9zOS8ycjU4NVp3YTQ0VmpTYTBUUTRrR1NEZDZJYzI1?=
 =?utf-8?B?ZHBJazlOT3lLa0F2L3I1NzZ2MTVQYVJkQlB0d2YrVTk1di9sZW9LZXVOeWU0?=
 =?utf-8?B?ckhrUnRsK044c2J4Zkp6ZTNoSnlUQ1kxd1ZkUlVtRnJnY2F2djIvZDRZaDli?=
 =?utf-8?B?V1V1TzBqVWVqc1UvNnZMdE1QcXhHSlplZDg3K1V4a2pONm81RmtQMXdVOWph?=
 =?utf-8?B?cFdlZXFqSE1MM05QS2c3ZGhwaTJyVDZ1ZzRWblNoNUNBQ2xWTnV1dUkvbGJq?=
 =?utf-8?B?eGNZVTlJRFI3VXcyOG5sYzBOeXVIUjdrRU95L05CYVkyemxpdkx6R0pGTEU2?=
 =?utf-8?B?U21PWFVTc2dISWIxN0psZ3dMZGNHQ1UyL3B0ZE9UWCtYMFV1WnI3U1IxMDdS?=
 =?utf-8?B?bW9ycS92WURieHRTTVJlcWFZbHdjM0RqclNpcXRQdk9HM1JFaVdXTDlCOFgy?=
 =?utf-8?B?WmlrM0E4S1ppbE9tQzh3cVFUME0yL3JkbFJqWkxkYmV0clBBQzYweDYxOHUz?=
 =?utf-8?B?WC9NSE4yamh6YkpIODNqSU9vTG1KR2Y1UTdrRVRJZDh2dXoxbkgxZDdQWS9K?=
 =?utf-8?B?c0JYNkVVR3NNTmZLT3QrcHFRU25MTE9NSXNHZjdWZFdDbGdkeTExRDRWQ2E0?=
 =?utf-8?B?MW05My81UnF4OVhLcWkzeTBqT2o3d3VRbGpjQUtZdzNtSWRqTi9wNU1vZ3p5?=
 =?utf-8?B?TGpFVUQ1MytSbDNLNWN1ZzJXbGdMak1xVTlEbjMzSHVETG0wd3RqYUMxbjZz?=
 =?utf-8?B?WkYrNEM2dXo1eGowSUhNRWxoSFBuaXdVdWY5T2FwTCtuWCtmSjgrendtdWIx?=
 =?utf-8?B?TjFxYzlWZTBGZ0l6UVdYZStSdTJzU2ZxeTQ0c20rNzUreW85S1NrWTh3eVgv?=
 =?utf-8?B?K0Y5MWF0bUFQUTJWc0xXajQvU0dsZFRkUGpuby9QakhuSHl1MFltYk9sUEVT?=
 =?utf-8?Q?5HTjkfrZrdVd2NJSsfRH1ldyGy+6BsDZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBJejl6WTZRUFp0MmtMMWlDZDdhekM3cGZNK1ZxTjMwN2NuU2Y1SEhOdEU5?=
 =?utf-8?B?cm56M2x4NFdGN0xzVi9rak85bGtQUWRZbjRCTXF0QmYvTnBoZkR5OGUxaU44?=
 =?utf-8?B?cVRvbFkreENQUVhSUTZ4ejEyOEFHU01jdlVuOHRZeFdNQVhjQ05DOHpuNVl4?=
 =?utf-8?B?eForUjFTNi9LV0I0bU1Yd1dZZFU3Uk5VOXlCVnNHeDVUUHNqNW5raTZzSDhJ?=
 =?utf-8?B?TWJSTFg3dDB1dE5HckNibkZ3Rm9ReFArUmV4NDNHSUU2TmJ2ZFlnS0RwMlo5?=
 =?utf-8?B?NWJXL3F5VG9pVHozUG1mY2FvRnBSNXNyNnMvUGpzeG0rWWZmeG9LZm9URUUw?=
 =?utf-8?B?NXMraitiVlFFT3V2WlpXaUY5ZFpRMlZqWmFWTFRTbUxWSUFpRGVwSWphMjN1?=
 =?utf-8?B?RGMzOHMycnQxVHFoVFVYUG1YUVB2bmFXRFpOQ2hHWWZqdlNIM2R3bngyNDZs?=
 =?utf-8?B?SDIyMXphMnJITCtzc0VRYVQyOU9GUXRreUZidnNSRU5NSHVkY2RJc1ZDZVZ4?=
 =?utf-8?B?blhFVWVhK0NWVmZuMUVvWUppR1IxZStoMGxFbGllRUh4QVo3cktTYUZDamNR?=
 =?utf-8?B?T1NNU29EMUFHdkpLbDlLejhXOWNsTHZZQ1dPRXBQVjMzbDMxWkNNRWVoUWtl?=
 =?utf-8?B?NUdiK0FrQW4yQTMxZzJUUmpncE0yWUlkSTF5bFk2UTMvVFZrNFBtUnFoRXZp?=
 =?utf-8?B?TVcrMXZyaUtJV3p6VHZMcXllYldLRmt3OVlVOHE2d0JnUEVKbVVIOVA0K0w0?=
 =?utf-8?B?NVh0bU5xdy9RUnFQRVorWFBLZW1ndjlhaDVrandxRzViNGRmS2crUWxPNEJF?=
 =?utf-8?B?aGszWUI3K2NqNmlBbG8wdkdDU0lINjhUdzFNYTVVUHFtTUQzZ1ZZRlNCR1Nx?=
 =?utf-8?B?YWhUQk1kVUNHU1RuNlByejRNWCtFODRuSzhxQkI2bWNncUhJYnpSNDFVb0xC?=
 =?utf-8?B?eFJiMnV6cTJ6OTBoTHZkRUtRQ0tpQnVqc0RHOCtsaTA3MTVYUnI3T2IyWG1y?=
 =?utf-8?B?d3BxeUZZTE1xL1lxRnh3MXE4ZGpVN0FydzAwNEVNdGk1cmtRMFQ4OGVJZFpm?=
 =?utf-8?B?RzlpTW9XRnNINFhtSlpFc3M0NnRzOVQ0UTh5MjhpQzhidTRNN2FoZFpzN1dy?=
 =?utf-8?B?RFAxUmNqa1Z0dFhSQzBRckFsbW5UZUVkdEQyRXlyeUI4U0lrRzl4ajZuVGhz?=
 =?utf-8?B?bFF4dk9ESDA2clQ0UEhleldiQmlFQVYwZ3IzYUg5bENNREhGdEFQcUxxTlVW?=
 =?utf-8?B?ZlcwREU3MS9qRUlRaVRrRlFQZm9hM1NlY0lGMnRzaXNwcm4zRENrVU1FNUNp?=
 =?utf-8?B?MFFabkhkZlQwOFpDaFNTT09aTnBCRElza093YmtqU3JwM2dRV0lUMVU2bEZu?=
 =?utf-8?B?RTBuUy9MVXlJSVBLckFUaThaVkxzdVl0QXpYTWJDZnZWUENTV0tkc1diRUFv?=
 =?utf-8?B?ejhiMnZpRXVlQnNpNXVYYUZML1lkak9BQU5XRVkyYjk3RnFhenY3ejQ3NGRJ?=
 =?utf-8?B?aXJMTHRzTGV6b1A2VXZ4L0ljQmxjOVA1WDV1MUV1QTVLY2NRaUVST01zNi9R?=
 =?utf-8?B?cktpR0t6L3VEb1RONEZCVkoya1pBdzdiRzZJWlcwMllYZTU1bk85ZkorYlI2?=
 =?utf-8?B?RmQ4eTEyQzhwZW5UUjVINElsMXNtNXhtMlliSkxLdnNiSHNhcnAxeEVNbEhK?=
 =?utf-8?B?Zm5JVmR0QzBKYzFWNTFvdEVzVDJwckE0L0pIai9VR2ZYWTRaSkc2amdEbHMr?=
 =?utf-8?B?V05kSFNsVmF3RGV1U1RTMWZYNFoyeTRzMEpkNlowdTVkcTRMc3VLeUJONlJE?=
 =?utf-8?B?bjJHaDNYYU1tQis0ZzVOWGNpcjdscXAweFFQWXc5b2ovWHpaYmt3M2MxVlpi?=
 =?utf-8?B?TlBIeXZ3ZHk3Vk5pS3AyQ01talJwNERndDhZYkM5K01peEFRQjdLUkZTYnVt?=
 =?utf-8?B?cUhYaG1IQ2lUQ1pBVUxBVkNycEhRZzhZNjlyZk01VzJKUEdLc0ZTVTZGSzhn?=
 =?utf-8?B?elJ5b2NscHRidHJscElWRUVzWi9INkZDUXNFREFSNFBTYXVzd1FmUkpUSzhM?=
 =?utf-8?B?RWYrVFF1RDVhL0NSeUFscllINjE4TUR6NDU1MGxZTi9mTXBrWlZvNHYyQTZH?=
 =?utf-8?B?M25zODBiSGlBQXBESkxvQXdwOHZqM1kxdllYY2lpaUlrSG9Ycll6cjJQa0w2?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e8204a-c057-4b28-914b-08de3b9781d1
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 05:05:04.0735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zensUbrtdkyKBjVmzval0fDqgDQpTWk4IyEc8V393p10lV4/5bj/nPWf7/DbK5Pzgr1Z41qoRgb3fpRN/fQ/Q9NfBXy6DcCeo2XUm+axN6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5445
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On 12/12/2025 12:34 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> By default, the de0_nano_soc used raw sectors, but the address became
> invalid due the raw-mode refactorings. With loading via partition type
> fixed, we can switch to that mode which is in line with what the ROM
> loader does.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   configs/socfpga_de0_nano_soc_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
> index 32cdf6d3a6c..6564cbd03c6 100644
> --- a/configs/socfpga_de0_nano_soc_defconfig
> +++ b/configs/socfpga_de0_nano_soc_defconfig
> @@ -28,6 +28,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>   CONFIG_SYS_MAXARGS=32
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

