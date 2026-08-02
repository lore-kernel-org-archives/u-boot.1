Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B368C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 14:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45F81605B0;
	Sun,  2 Aug 2026 14:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lb2On5H7JyQB; Sun,  2 Aug 2026 14:02:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB8D660608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785679375;
	bh=BCVsrqGcjdR/HSu0fdVGNap95RTGnzkafRJuSAoChjc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=xe2DXXrEAMk3noyqiChuXuivCEdv8ZIeDmDkIMzWqTSQsu9EM7/HbR3/oBoxvMiCJ
	 qnumr4DVFEZZuq1aHLXK1GNKztHaG0KLZbiX7VAxGXLQ7GD8DjQaOsSB/q8MSXrx5M
	 N2X1nIOvMOddRkxVQW9kRAIE/Z23eV4j5OKOksT18iOqsPPT6XyoOUpFKrLJkxkvAH
	 GIqQ/fgfUOVnGfIcigHJuG0qz3JpUlgIq7t+Kkt6DznW2X5kMnU/kOkb9ATzK4g2Pf
	 3gG481SVRv2c6aH7AGoVzlmTvHKzJwroArVG3fQhXdzAhJvn7c+heAtk0JtG1up+jP
	 VDTRIp2HT8CRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB8D660608;
	Sun,  2 Aug 2026 14:02:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D58326C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 14:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34D7C40085
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 14:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iS-4qGVrxdui for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 14:02:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0B11A4006F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B11A4006F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B11A4006F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 14:02:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64845805D7; Sun,  2 Aug 2026 16:02:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6558180087
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 16:02:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpQkteib+brUEOU6w6Q+8Rzxi9X4cggf6WvBfTcAKCz4fhwKfU5S/o6hRh/VarEv6FIVaulCyJBemliNbqdSOEKe9OGMV6Vn76+RQGU2iiTh17qUpPft3qamx9rAwri8GqiuLLYuVeRa9x3EaJSpq4XEeUnLTvWrERoTVXkD/xleoZ18Kum8LdEDfxEuOD2mwD1mXs+ORshH73G27m17xyNJiQatDZXWoaPxIySpuAk1NaGipgeXubL54Tt3ir3LZo+bXtK8Rr71R3qfsHSgH6oBxeZ4lo+n6ABFcdKWtdvFEql6aqQQOn3lZm94UDMGpe7W8GAWV7s3wsaAg76Z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCVsrqGcjdR/HSu0fdVGNap95RTGnzkafRJuSAoChjc=;
 b=aTs+jaNlB6bmR6EvFskrYpJV/EJj3KtQ9o5PEG1zbGGe0lIGh41BCjIAWG3xBz6rOo5lCg1kPOh5th7vBXy4ArlGvYp3l8Gv9SFEZFPVdos+7wFotqQdfav8SQCn8hWs8/XzwyiQBcvzhWn+OwNN00ghGXH1SNQf3yN5031NlBC7je0uUpekV9oau67VTuB9bVNpbA3rP15mIkOi+ANML8OKLHz9YPuvuOyldivkbiy1y0FJ0lLIk/D1CfM2cORKa2qxU6EdQs1yL4VBDBJpSb/I/FJ7QjSGxQDJP5PQZH5R/SlvierPBLBeo8TWRzQKWsrwSqqkrEoIXoJ+XA74Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6509.eurprd08.prod.outlook.com (2603:10a6:102:12e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 14:02:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 14:02:39 +0000
Message-ID: <913dfe44-1efd-4bfb-828f-68d2fcf3fc1e@iopsys.eu>
Date: Sun, 2 Aug 2026 17:02:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha: add support for Airoha AN7583 PCS driver
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
References: <20260731071045.2287440-1-ansuelsmth@gmail.com>
Content-Language: en-US, ru-RU
In-Reply-To: <20260731071045.2287440-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: e26c9b81-de1f-497f-bb9d-08def09eb6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: TbnNdRP5zYBR2wMOmFo3KRYlxZ0A1NCppTp+95Cq8L2VGcU/e15B7JMpqhimkBhth9LpFoE5u1P8jcUW6zMM3TKD03NEnTjxHedJpgSI0Q0XVCFN5BOLumfRO6YQRIRVdoO/VecDn2T6Pfov3U9yOPBgPWf/IitChooLKkmdC9q0aarGzvpnI1yrG7MIKqSfhpYX/tDsdNwkl9RcUR4AINfGhgYAnSmw+X/hnEEFhyHyC4QayYPimNK54CgMHvcQKAIKvIPUXLyZIFBdmgLLuMFHS0EgkhLWcFpqScUJEUIaeEUUp45AJsPYWXyJu95/kDq31UmCeSw0Gu9ki0g0Fnbw5SIX4wc8pXqVBA1EPFdCVVO/F8w2ARBoMrkMGJBp8tiY16/K/OWClVftDJ39m6pLNCAmq01IQWzCmtPzkNo+CYjG6qie2ujmW7AcQLzn1a/gD7/JVUvLZlA0d70VZVBCHW/1Sa/M7zfyUr9yLNMVyfjnhyhuRs19O3YwqV5Hgp2KNuaHKN7v90zRom4ApWPDXTzKjt0uEWRYMTEhxYsuOdf+qhKFb9Rw18DbgyuE2L0lXWDDzYi/0mOU+V31u/guckbvTlLGW9ziak3uHwmpv1acEuicbhtZJ60e777H6I5zB12sQAGVrf3ibL4vgTIADcQEKZZGDNkbe6HHTwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QytDeEozSEhYdUNXRFdLTEFXVmw4cVRtY0pwaU1QZ1ZsakM5Q1U0U0twYjJl?=
 =?utf-8?B?cWh2WlFrcW1TQ1c0VWcvNy9MYUFVTHY1K0NXRXpyQ3l1Zkc1WTMrRHF5bG5a?=
 =?utf-8?B?Nlo3NEQxSnhtOWlQWW1tYjNvSTZNTWU4bEREZEF6MW5lRnR1N1lQeS9QamVW?=
 =?utf-8?B?eWl4OE1QMHRRL0w2dmhyR0t0eU1iNEdBelorVmF2UCtqN3FlTVVRbXRwczNu?=
 =?utf-8?B?cXlPaWpMenQ2OW51QkN2Y2RYMnFreXNITXpnd1d5Nlk1QjNHQ2hCTmdjT3VB?=
 =?utf-8?B?Y3gzN2ZhWGNNMGNZYy9adm9neEpjOU9sdGZqV1VhcmkyYzlLQkNJMm01UHpR?=
 =?utf-8?B?V0w1RG5KRFBkdVBBcElZZjVPMWpEOTBrVi9UcFh2WUNadXd3dkE3TExaV05Q?=
 =?utf-8?B?Wis2WjVjTVRQQlAvWmFqYUJOSDBxNnNEN29HNzhLVzRlMmovMHgwNDZDTUt3?=
 =?utf-8?B?TVgzRGV1RFBISndZUmh6NCsrOFB2K0cvZjhtSzhjajl3YUcra0NmOFVRY255?=
 =?utf-8?B?aFlNRzk2bUZRNHZZTzlHS2RvNkc3TCtDVFNncWUrb3dSY3FRKzMyWUNJT1Vp?=
 =?utf-8?B?dzc4TFJRQnU0aVF1cHRpOXY4K0k3WGtrdlh3cmJKSmgzaWpwUEgwV1dZOEUr?=
 =?utf-8?B?WmZBRWRSUlJVdFFFWWNCb3JZeit1UXFOOGV1UVIrUzhpc3FFOUdPbUlTdUdu?=
 =?utf-8?B?b0JwZ0ZlZjZRYVVEQ2tsS1Ixc2RLREtVRmp3NlZuRlZSOERKYXc5K0cyZ0hR?=
 =?utf-8?B?a1NkQ2V3c2R4Q3NTTXFPOHBhTFQ3K01Fckl4QkJQWldteEJBdE1qVFlrQzZU?=
 =?utf-8?B?YU5seDVKalpYT3FFNk0xR3hGMEZDTzQvbEk1TFlQNHJrVmlwRzhzTkwwVzNF?=
 =?utf-8?B?SnFybUhRMWNlc2dlWmgzNHBoNzRucHZNSndhN0xJN3J3UmRpTHNEbGg3VXRj?=
 =?utf-8?B?Q05YU3diemtSV0ZNajRiSFJkaEdkbW5jV3lsaGQwK3pVVXRCQWNIb29vSXM1?=
 =?utf-8?B?NWpYMDJ4ZnNkaE1TZEZUMUhyUldxYzZYUkc2NHdpUi9mN2U5NWJFTGV6T0Fs?=
 =?utf-8?B?MlVQL2FueWg1YjVOR01aRVZzaExBRDlsbWlaS1c0cUF2M3BKNytLR2o3WGhn?=
 =?utf-8?B?UWN1d2F6VzJ3VFEzY25TRUlsNWxsK1BqY21zRnlLcWlyc3ZZVDlWZjB3ODhS?=
 =?utf-8?B?NW1kbXVyWnlSWFZ3U0pTWjJGaVZ1bitkVllOZEpIYkg2UzhyRzNsT0xNRlhN?=
 =?utf-8?B?V0RLU0syZXVucE8ycEEwUVdEWmxEcStTVWE2b3ZINHVKZTdKUDFyczZaWktU?=
 =?utf-8?B?anhuUVhXOEJ1bEpSM1hwdExnUXNINGtwTHBDaUZqdmpPMzNEdUJHZHRlRmxs?=
 =?utf-8?B?V3dOTVAwN3hFNlUrY2xUbVo3TzNDZTNrL1hMRTR3R1VyN25WOHhwbzJvNTR3?=
 =?utf-8?B?SGlQYTBvdEhKWlFzbnh0ZS80TjBEQ3FqUVRqS3pBaElET0hldHBqdU9MenV0?=
 =?utf-8?B?Yk5oWE94TGJMV1E3WjRMcVdET1dSUDNmblVRUjdSVTJXTm1iYkJwK0l6Z0xi?=
 =?utf-8?B?cjkweThLZUJuL1kySW81cGxReExmY3JOS1pkVXJna003cXJQWGpBTkl6WEh2?=
 =?utf-8?B?L2J0Y2RMTjg2S0lmd2h4NEFsT0pucXU2RStCRmR5cTA3NVNOL25XRkxiOW9G?=
 =?utf-8?B?NnZ6VWdoWTIzTm5JdjBjbTh4UEJrMndVU1h5UG44aVNLMjRoTmdDS2ljdGNh?=
 =?utf-8?B?alg4N2h0MDBGVmFsaCtyaDNaa0h6bm0yZWQ1SlE1N2E3dGpUQnVJWGlLN0dx?=
 =?utf-8?B?d3ZTTGs3SjZ2UkhQeE9NVzdVd3RYYUszMCtuVkM4b1FHUDY2RGJpTlZCRDFM?=
 =?utf-8?B?OXczSWlsT1Bud1F2RWJiMHZBWW0zeVZkKzJtRVZCZHJNbzk3WkFKVlBZK2lO?=
 =?utf-8?B?L1F5TVNqdjFtV0xiQWVHQk1zNmRhU0p2eVZYeG9SeUw0TWdZWVZmSmdsVzRI?=
 =?utf-8?B?YmxaVTAyNy9Pa05QYXpKNTFhZWhBQ2JxM0FHdzJremtYaHM3MEozWEduSnZt?=
 =?utf-8?B?V0U3em9SWlVNbXNuajVmQVVJTjFDYktOcC9hajNsQ214WklsSlRWc0x5U3Zu?=
 =?utf-8?B?UVNLM0RVTXZOeXdnR3FhenlqVzc3ZnVKZlNYTlNNOStOZ3MyLy9MamtrbWwr?=
 =?utf-8?B?QjVMQ1lxWlBqc3FKencxZGRMK3IvT1BPSGs2ZzA1TjRBUkRBdFNFdmMrb3Ux?=
 =?utf-8?B?cFM5NXExSWNtME53NGFMcmxhT0IrSVZXaUVXMW5td0FiNnI5V3BvK2NSbW4r?=
 =?utf-8?B?dHdRdjhRbDlvOWtvS1F2RWlLRDhOZGwyeEU1ZWFscW9TckpqdzdiNlk5anF0?=
 =?utf-8?Q?kaKIQ/jSOCSUSBk4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e26c9b81-de1f-497f-bb9d-08def09eb6d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 14:02:39.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4VoTJWmQFGkZhthoTfz6Ib+cqRSJIhiDIN4w2Nse+9nGk3861nWaUGrh/pKyik91sKbyE1g8g2TaJnyEhHxqogw+O5QujJDOaJJ65w/3/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6509
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCVsrqGcjdR/HSu0fdVGNap95RTGnzkafRJuSAoChjc=;
 b=B7xYqvBO/uu+FicKUnxzzLCIa7D2erJ0rOnnE20xgGlQrAWWqbZXew3mUlyumi23ixpFfS9OJGuvGW7uJZ795sfUHleQhXTOlfTIYqTtNyvcuSq+NBq2Uj+zHnU2ldWjoEVoth2sY/rtdHm/sKt406MM95rC+Y6r2HpTLZ3l0rXdnhxSMlfGXZ1y8D1uA4BkQeDK+TNI1bukZkuzhG64fjmgT0DC52wTF9NOKE8ytqSVGjIzaQNgK7sC+zh57+3gzNAwN0Mz5gOwq79bgHSoVc32LGYfeI1A6PgOFjjnZQQKiBc9qPN6EgUYF3tA9eTXCuYOG9HDyCznpns/DYVzmw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=genexis.eu
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=B7xYqvBO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="B7xYqvBO"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/31/26 10:10, Christian Marangi wrote:
> Add support for the PCS interface on Airoha AN7583 SoC. This is based on
> the AN7581 SoC with difference in the calibration and Analog PHY
> handling.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Patch is ok, but the following an7583 related changes are missed to make it work properly
* aitoha_eth an7583 support
* AN7583 helpers to get SCU and CHIP_SCU regmaps

Christian, I could prepare and post my set of an7583 patches.
It will additionally include:
* Airoha AN7583 MDIO Controller
* Airoha AN7583 SoC clock support
* Airoha AN7583 reset contoller

What do you think?

> ---
>  drivers/net/airoha/Kconfig             |    8 +
>  drivers/net/airoha/Makefile            |    1 +
>  drivers/net/airoha/pcs-airoha-common.c |   27 +
>  drivers/net/airoha/pcs-airoha.h        |   17 +
>  drivers/net/airoha/pcs-an7583.c        | 2202 ++++++++++++++++++++++++
>  5 files changed, 2255 insertions(+)
>  create mode 100644 drivers/net/airoha/pcs-an7583.c
>
> diff --git a/drivers/net/airoha/Kconfig b/drivers/net/airoha/Kconfig
> index d0c007ced80e..5f660bb280f8 100644
> --- a/drivers/net/airoha/Kconfig
> +++ b/drivers/net/airoha/Kconfig
> @@ -11,3 +11,11 @@ config PCS_AIROHA_AN7581
>  	help
>  	  This module provides helper to phylink for managing the Airoha
>  	  AN7581 PCS for SoC Ethernet and PON SERDES.
> +
> +config PCS_AIROHA_AN7583
> +	bool "Airoha AN7583 PCS driver"
> +	depends on ARCH_AIROHA
> +	select PCS_AIROHA
> +	help
> +	  This module provides helper to phylink for managing the Airoha
> +	  AN7583 PCS for SoC Ethernet and PON SERDES.
> diff --git a/drivers/net/airoha/Makefile b/drivers/net/airoha/Makefile
> index 81fd26cf8131..a3b84518129c 100644
> --- a/drivers/net/airoha/Makefile
> +++ b/drivers/net/airoha/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_PCS_AIROHA)	+= pcs-airoha-common.o
>  obj-$(CONFIG_PCS_AIROHA_AN7581)	+= pcs-an7581.o
> +obj-$(CONFIG_PCS_AIROHA_AN7583)	+= pcs-an7583.o
> diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
> index 1263092fcdd4..bc64263fad91 100644
> --- a/drivers/net/airoha/pcs-airoha-common.c
> +++ b/drivers/net/airoha/pcs-airoha-common.c
> @@ -17,6 +17,7 @@
>  static void airoha_pcs_setup_scu_eth(struct airoha_pcs_priv *priv,
>  				     phy_interface_t interface)
>  {
> +	struct udevice *dev = priv->dev;
>  	u32 xsi_sel;
>  
>  	switch (interface) {
> @@ -34,6 +35,12 @@ static void airoha_pcs_setup_scu_eth(struct airoha_pcs_priv *priv,
>  	regmap_update_bits(priv->scu, AIROHA_SCU_SSR3,
>  			   AIROHA_SCU_ETH_XSI_SEL,
>  			   xsi_sel);
> +
> +	/* AN7583 require additional setting */
> +	if (device_is_compatible(dev, "airoha,an7583-pcs-eth"))
> +		regmap_update_bits(priv->scu, AIROHA_SCU_WAN_CONF,
> +				   AIROHA_SCU_ETH_MAC_SEL,
> +				   AIROHA_SCU_ETH_MAC_SEL_XFI);
>  }
>  
>  static void airoha_pcs_setup_scu_pon(struct airoha_pcs_priv *priv,
> @@ -810,11 +817,31 @@ static const struct airoha_pcs_match_data an7581_pcs_pon = {
>  	.link_up = an7581_pcs_phya_link_up,
>  };
>  
> +static const struct airoha_pcs_match_data an7583_pcs_eth = {
> +	.port_type = AIROHA_PCS_ETH,
> +	.usxgmii_rx_gb_out_vld_tweak = true,
> +	.usxgmii_xfi_mode_sel = true,
> +	.bringup = an7583_pcs_common_phya_bringup,
> +	.link_up = an7583_pcs_common_phya_link_up,
> +};
> +
> +static const struct airoha_pcs_match_data an7583_pcs_pon = {
> +	.port_type = AIROHA_PCS_PON,
> +	.usxgmii_rx_gb_out_vld_tweak = true,
> +	.usxgmii_xfi_mode_sel = true,
> +	.bringup = an7583_pcs_common_phya_bringup,
> +	.link_up = an7583_pcs_common_phya_link_up,
> +};
> +
>  static const struct udevice_id airoha_pcs_of_table[] = {
>  	{ .compatible = "airoha,an7581-pcs-eth",
>  	  .data = (ulong)&an7581_pcs_eth },
>  	{ .compatible = "airoha,an7581-pcs-pon",
>  	  .data = (ulong)&an7581_pcs_pon },
> +	{ .compatible = "airoha,an7583-pcs-eth",
> +	  .data = (ulong)&an7583_pcs_eth },
> +	{ .compatible = "airoha,an7583-pcs-pon",
> +	  .data = (ulong)&an7583_pcs_pon },
>  	{ },
>  };
>  
> diff --git a/drivers/net/airoha/pcs-airoha.h b/drivers/net/airoha/pcs-airoha.h
> index 714d2ebe520b..fddeda5ca36c 100644
> --- a/drivers/net/airoha/pcs-airoha.h
> +++ b/drivers/net/airoha/pcs-airoha.h
> @@ -1218,3 +1218,20 @@ static inline void an7581_pcs_phya_link_up(struct airoha_pcs_priv *priv)
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_PCS_AIROHA_AN7583
> +int an7583_pcs_common_phya_bringup(struct airoha_pcs_priv *priv,
> +				   phy_interface_t interface);
> +
> +void an7583_pcs_common_phya_link_up(struct airoha_pcs_priv *priv);
> +#else
> +static inline int an7583_pcs_common_phya_bringup(struct airoha_pcs_priv *priv,
> +						 phy_interface_t interface)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void an7583_pcs_common_phya_link_up(struct airoha_pcs_priv *priv)
> +{
> +}
> +#endif
> diff --git a/drivers/net/airoha/pcs-an7583.c b/drivers/net/airoha/pcs-an7583.c
> new file mode 100644
> index 000000000000..4bdda3066edd
> --- /dev/null
> +++ b/drivers/net/airoha/pcs-an7583.c
> @@ -0,0 +1,2202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 AIROHA Inc
> + * Author: Christian Marangi <ansuelsmth@gmail.com>
> + */
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <regmap.h>
> +
> +#include "pcs-airoha.h"
> +
> +static void an7583_pcs_dig_reset_hold(struct airoha_pcs_priv *priv)
> +{
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_RX_FIFO_RST_N |
> +			  AIROHA_PCS_PMA_SW_TX_FIFO_RST_N);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_REF_RST_N);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_ALLPCS_RST_N);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_TX_RST_N |
> +			  AIROHA_PCS_PMA_SW_RX_RST_N);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_PMA_RST_N);
> +
> +	udelay(50);
> +}
> +
> +static void an7583_pcs_dig_reset_release(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_REF_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_TX_RST_N |
> +			AIROHA_PCS_PMA_SW_RX_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_PMA_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_RX_FIFO_RST_N |
> +			AIROHA_PCS_PMA_SW_TX_FIFO_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_ALLPCS_RST_N);
> +
> +	udelay(100);
> +}
> +
> +static void an7583_pcs_common_phya_txpll(struct airoha_pcs_priv *priv,
> +					 phy_interface_t interface)
> +{
> +	u32 pcw, tdc_pcw;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:  /* DS(RX)_1.25G  /  US(TX)_1.25G*/
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		pcw = 0x32000000;
> +		tdc_pcw = 0x64000000;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX: /* DS(RX)_3.125G  /  US(TX)_3.125G */
> +		pcw = 0x3e800000;
> +		tdc_pcw = 0x7d000000;
> +		break;
> +	case PHY_INTERFACE_MODE_5GBASER: /* DS(RX)_5.15625G  /  US(TX)_5.15625G */
> +	case PHY_INTERFACE_MODE_USXGMII: /* DS(RX)_10.31252G  /  US(TX)_10.3125G */
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		pcw = 0x33900000;
> +		tdc_pcw = 0x67200000;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_IDAC,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_SDM_PCW);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_3,
> +			AIROHA_PCS_PMA_LCPLL_NCPO_LOAD);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_SDM_PCW,
> +			   AIROHA_PCS_PMA_FORCE_DA_TXPLL_SDM_PCW,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TXPLL_SDM_PCW, pcw));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_PCW_1,
> +			   AIROHA_PCS_PMA_LCPLL_PON_HRDDS_PCW_NCPO_GPON,
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_PON_HRDDS_PCW_NCPO_GPON,
> +				      tdc_pcw));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_PCW_2,
> +			   AIROHA_PCS_PMA_LCPLL_PON_HRDDS_PCW_NCPO_EPON,
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_PON_HRDDS_PCW_NCPO_EPON,
> +				      tdc_pcw));
> +}
> +
> +static void an7583_pcs_common_phya_tx(struct airoha_pcs_priv *priv,
> +				      phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data = priv->data;
> +	u32 tx_rate_ctrl;
> +	u32 ckin_divisor;
> +	u32 fir_cn1, fir_c0b, fir_c1, fir_c2;
> +	u32 tx_ben_exten_ftune;
> +	u32 tx_dly_ben_ftune;
> +	u32 tx_dly_data_ftune;
> +
> +	if (data->port_type == AIROHA_PCS_ETH)
> +		tx_ben_exten_ftune = 0x2;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		ckin_divisor = BIT(1);
> +		tx_rate_ctrl = BIT(0);
> +		fir_cn1 = 0;
> +		fir_c0b = 8;
> +		fir_c1 = 0;
> +		fir_c2 = 0;
> +
> +		if (data->port_type == AIROHA_PCS_PON) {
> +			tx_ben_exten_ftune = 0x7;
> +			tx_dly_ben_ftune = 0x2;
> +			tx_dly_data_ftune = 0x6;
> +		}
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ckin_divisor = BIT(2);
> +		tx_rate_ctrl = BIT(0);
> +		fir_cn1 = 0;
> +		fir_c0b = 8;
> +		fir_c1 = 1;
> +		fir_c2 = 0;
> +		if (data->port_type == AIROHA_PCS_PON)
> +			tx_ben_exten_ftune = 0x2;
> +		break;
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		ckin_divisor = BIT(2);
> +		tx_rate_ctrl = BIT(1);
> +		fir_cn1 = 0;
> +		fir_c0b = 14;
> +		fir_c1 = 4;
> +		fir_c2 = 0;
> +		if (data->port_type == AIROHA_PCS_PON)
> +			tx_ben_exten_ftune = 0x2;
> +		break;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		ckin_divisor = BIT(2) | BIT(0);
> +		tx_rate_ctrl = BIT(1);
> +		fir_cn1 = 0;
> +		fir_c0b = 14;
> +		fir_c1 = 4;
> +		fir_c2 = 0;
> +
> +		if (data->port_type == AIROHA_PCS_PON) {
> +			tx_ben_exten_ftune = 0x16;
> +			tx_dly_ben_ftune = 0xd;
> +			tx_dly_data_ftune = 0x30;
> +		}
> +
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TX_CKLDO_EN,
> +			AIROHA_PCS_ANA_TX_DMEDGEGEN_EN |
> +			AIROHA_PCS_ANA_TX_CKLDO_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CMN_EN,
> +			   AIROHA_PCS_ANA_CMN_VREFSEL |
> +			   AIROHA_PCS_ANA_CMN_MPXSELTOP_DC |
> +			   AIROHA_PCS_ANA_CMN_EN,
> +			   AIROHA_PCS_ANA_CMN_VREFSEL_9V |
> +			   FIELD_PREP(AIROHA_PCS_ANA_CMN_MPXSELTOP_DC, 0x1) |
> +			   AIROHA_PCS_ANA_CMN_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_ACJTAG_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TX_CKIN_SEL |
> +			AIROHA_PCS_PMA_FORCE_DA_TX_CKIN_SEL);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_FIR_C0B,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_CN1 |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_FIR_CN1 |
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C0B |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C0B,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_CN1 |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_FIR_CN1, fir_cn1) |
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C0B |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C0B, fir_c0b));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_FIR_C1,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C2 |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C2 |
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C1 |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C1,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C2 |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C2, fir_c2) |
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_FIR_C1 |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_FIR_C1, fir_c1));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_TERM_SEL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_CKIN_DIVISOR |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_CKIN_DIVISOR,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_CKIN_DIVISOR |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_CKIN_DIVISOR,
> +				      ckin_divisor));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_RATE_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_RATE_CTRL |
> +			   AIROHA_PCS_PMA_FORCE_DA_TX_RATE_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TX_RATE_CTRL |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_TX_RATE_CTRL,
> +				      tx_rate_ctrl));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_XPON_TX_RATE_CTRL,
> +			   AIROHA_PCS_PMA_PON_TX_RATE_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_PON_TX_RATE_CTRL,
> +				      tx_rate_ctrl));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_DLY_CTRL,
> +			   AIROHA_PCS_PMA_TX_BEN_EXTEN_FTUNE,
> +			   FIELD_PREP(AIROHA_PCS_PMA_TX_BEN_EXTEN_FTUNE, tx_ben_exten_ftune));
> +
> +	if (data->port_type == AIROHA_PCS_PON) {
> +		if (interface == PHY_INTERFACE_MODE_SGMII ||
> +		    interface == PHY_INTERFACE_MODE_1000BASEX ||
> +		    interface == PHY_INTERFACE_MODE_USXGMII ||
> +		    interface == PHY_INTERFACE_MODE_10GBASER)
> +			regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_DLY_CTRL,
> +					   AIROHA_PCS_PMA_TX_DLY_BEN_FTUNE |
> +					   AIROHA_PCS_PMA_TX_DLY_DATA_FTUNE,
> +					   FIELD_PREP(AIROHA_PCS_PMA_TX_DLY_BEN_FTUNE, tx_dly_ben_ftune) |
> +					   FIELD_PREP(AIROHA_PCS_PMA_TX_DLY_DATA_FTUNE, tx_dly_data_ftune));
> +
> +		regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_MD32_MEM_CLK_CTRL,
> +				   AIROHA_PCS_PMA_MD32PM_CK_SEL,
> +				   FIELD_PREP(AIROHA_PCS_PMA_MD32PM_CK_SEL, 0x3));
> +
> +		regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_DLY_CTRL,
> +				   AIROHA_PCS_PMA_OUTBEN_DATA_MODE,
> +				   FIELD_PREP(AIROHA_PCS_PMA_OUTBEN_DATA_MODE, 0x1));
> +	}
> +}
> +
> +static void an7583_pcs_common_phya_rx(struct airoha_pcs_priv *priv,
> +				      phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data = priv->data;
> +
> +	u32 rx_rev0;
> +	u32 fe_gain_ctrl;
> +	u32 dig_reserve_0;
> +	u32 rx_force_mode_0;
> +	u32 cdr_pr_beta_dac;
> +	u32 phyck_sel;
> +	u32 phyck_div;
> +	u32 lpf_ratio;
> +	u32 busbit_sel;
> +	u32 rx_rate_ctrl;
> +	u32 osr;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		dig_reserve_0 = 0x300;
> +		cdr_pr_beta_dac = 0x8;
> +		phyck_sel = 0x1;
> +		phyck_div = 0x29;
> +		lpf_ratio = 0x3;
> +		osr = 0x3;
> +		rx_rate_ctrl = 0x0;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		dig_reserve_0 = 0x300;
> +		cdr_pr_beta_dac = 0x6;
> +		phyck_sel = 0x1;
> +		phyck_div = 0xb;
> +		lpf_ratio = 0x1;
> +		osr = 0x1;
> +		rx_rate_ctrl = 0x0;
> +		break;
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		dig_reserve_0 = 0x400;
> +		cdr_pr_beta_dac = 0x8;
> +		phyck_sel = 0x2;
> +		phyck_div = 0x42;
> +		lpf_ratio = 0x1;
> +		osr = 0x1;
> +		rx_rate_ctrl = 0x2;
> +		break;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +		dig_reserve_0 = 0x100;
> +		cdr_pr_beta_dac = 0x8;
> +		phyck_sel = 0x2;
> +		phyck_div = 0x42;
> +		lpf_ratio = 0x0;
> +		osr = 0x0;
> +		rx_rate_ctrl = 0x2;
> +		break;
> +	default:
> +		return;
> +	}
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_REV_0,
> +			   AIROHA_PCS_ANA_REV_1_FE_BUF1_BIAS_CTRL |
> +			   AIROHA_PCS_ANA_REV_1_FE_BUF2_BIAS_CTRL |
> +			   AIROHA_PCS_ANA_REV_1_SIGDET_ILEAK,
> +			   FIELD_PREP(AIROHA_PCS_ANA_REV_1_FE_BUF1_BIAS_CTRL, BIT(2)) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_REV_1_FE_BUF2_BIAS_CTRL, BIT(2)) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_REV_1_SIGDET_ILEAK, 0x0));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_OSCAL_WATCH_WNDW,
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE,
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_VGA2VOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_VGA2IOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_VGA1VOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_VGA1IOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_CTLE2VOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_CTLE2IOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_CTLE1VOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_CTLE1IOS |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_LVSH |
> +			   AIROHA_PCS_ANA_RX_OSCAL_FORCE_COMPOS);
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PD_PICAL_CKD8_INV,
> +			  AIROHA_PCS_ANA_CDR_PD_EDGE_DIS |
> +			  AIROHA_PCS_ANA_CDR_PD_PICAL_CKD8_INV);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_AEQ_RSTB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_INJCK_SEL |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_INJCK_SEL);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_FE_GAIN_CTRL,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_GAIN_CTRL);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_DIG_RESERVE_12,
> +			AIROHA_PCS_PMA_RESERVE_12_FEOS_0);
> +
> +	if (interface == PHY_INTERFACE_MODE_USXGMII ||
> +	    interface == PHY_INTERFACE_MODE_10GBASER) {
> +		rx_rev0 = FIELD_PREP(AIROHA_PCS_ANA_REV_0_FE_BUF2_BIAS_TYPE, 0x1) |
> +			  FIELD_PREP(AIROHA_PCS_ANA_REV_0_FE_BUF_GAIN_MODE_NORMAL, 0x3);
> +		fe_gain_ctrl = 0x1;
> +		rx_force_mode_0 = 0x1;
> +	} else {
> +		rx_rev0 = FIELD_PREP(AIROHA_PCS_ANA_REV_0_FE_BUF2_BIAS_TYPE, 0x1) |
> +			  AIROHA_PCS_ANA_REV_0_OSCAL_FE_MODE_SET_SEL |
> +			  BIT(7) | /* FIXME: Missing documentation for this BIT */
> +			  FIELD_PREP(AIROHA_PCS_ANA_REV_0_FE_BUF_GAIN_MODE_NORMAL, 0x3);
> +		fe_gain_ctrl = 0x3;
> +		rx_force_mode_0 = 0x3;
> +	}
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_REV_0,
> +			   AIROHA_PCS_ANA_RX_REV_0, rx_rev0);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_FE_GAIN_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL,
> +				      fe_gain_ctrl));
> +
> +	regmap_write(priv->xfi_pma, AIROHA_PCS_PMA_DIG_RESERVE_0,
> +		     dig_reserve_0);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_0,
> +			   AIROHA_PCS_PMA_FORCE_DA_XPON_RX_FE_GAIN_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_XPON_RX_FE_GAIN_CTRL,
> +				      rx_force_mode_0));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_0,
> +			  AIROHA_PCS_PMA_DISB_DA_XPON_RX_FE_GAIN_CTRL);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_BETA_DAC,
> +			   AIROHA_PCS_ANA_CDR_PR_BETA_DAC,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_PR_BETA_DAC,
> +				      cdr_pr_beta_dac));
> +
> +	if (data->port_type == AIROHA_PCS_ETH &&
> +	    interface == PHY_INTERFACE_MODE_2500BASEX)
> +		regmap_update_bits(priv->xfi_ana,
> +				   AIROHA_PCS_ANA_PXP_CDR_PR_VREG_IBAND_VAL,
> +				   AIROHA_PCS_ANA_CDR_PR_DAC_BAND,
> +				   FIELD_PREP(AIROHA_PCS_ANA_CDR_PR_DAC_BAND,
> +					      0x6));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_PHYCK_DIV,
> +			   AIROHA_PCS_ANA_RX_PHYCK_SEL,
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_PHYCK_SEL, phyck_sel));
> +
> +	regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_MONPR_EN,
> +			AIROHA_PCS_ANA_CDR_PR_XFICK_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_BUSBIT_SEL,
> +			   AIROHA_PCS_ANA_RX_PHY_CK_SEL_FORCE |
> +			   AIROHA_PCS_ANA_RX_PHY_CK_SEL,
> +			   AIROHA_PCS_ANA_RX_PHY_CK_SEL_FORCE);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_PHYCK_DIV,
> +			   AIROHA_PCS_ANA_RX_PHYCK_RSTB |
> +			   AIROHA_PCS_ANA_RX_PHYCK_DIV,
> +			   AIROHA_PCS_ANA_RX_PHYCK_RSTB |
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_PHYCK_DIV, phyck_div));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_LPF_RATIO,
> +			   AIROHA_PCS_ANA_CDR_LPF_RATIO,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_LPF_RATIO,
> +				      lpf_ratio));
> +
> +	if (interface == PHY_INTERFACE_MODE_5GBASER)
> +		busbit_sel = AIROHA_PCS_ANA_RX_BUSBIT_SEL_FORCE |
> +			     AIROHA_PCS_ANA_RX_BUSBIT_SEL_16BIT;
> +	else
> +		busbit_sel = 0;
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_BUSBIT_SEL,
> +			   AIROHA_PCS_ANA_RX_BUSBIT_SEL_FORCE |
> +			   AIROHA_PCS_ANA_RX_BUSBIT_SEL,
> +			   busbit_sel);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_AEQ_SPEED,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_OSR_SEL |
> +			   AIROHA_PCS_PMA_FORCE_DA_OSR_SEL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_OSR_SEL |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_OSR_SEL, osr));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_XPON_RX_RESERVED_1,
> +			   AIROHA_PCS_PMA_XPON_RX_RATE_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_XPON_RX_RATE_CTRL, rx_rate_ctrl));
> +}
> +
> +static void an7583_pcs_common_phya_ana(struct airoha_pcs_priv *priv,
> +				       phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data = priv->data;
> +	u32 txpll_chp_br, txpll_chp_ibias;
> +	u32 lpf_bwr;
> +	u32 vco_cfix;
> +	u32 tcl_amp_vref;
> +	bool sdm_ifm;
> +	bool sdm_di;
> +	bool sdm_hren;
> +	bool vcodiv;
> +	bool chp_double_en;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		if (data->port_type == AIROHA_PCS_PON) {
> +			txpll_chp_br = 0xa;
> +			txpll_chp_ibias = 0x18;
> +			lpf_bwr = 0x16;
> +		} else {
> +			txpll_chp_br = 0x5;
> +			txpll_chp_ibias = 0x31;
> +			lpf_bwr = 0xb;
> +		}
> +		vco_cfix = 0x3;
> +		tcl_amp_vref = 0xb;
> +		vcodiv = false;
> +		sdm_hren = data->port_type == AIROHA_PCS_PON;
> +		sdm_ifm = data->port_type == AIROHA_PCS_PON;
> +		sdm_di = data->port_type == AIROHA_PCS_PON;
> +		chp_double_en = false;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		txpll_chp_br = 0x5;
> +		txpll_chp_ibias = 0x1e;
> +		lpf_bwr = 0xb;
> +		vco_cfix = 0x0;
> +		tcl_amp_vref = 0xe;
> +		vcodiv = true;
> +		sdm_hren = false;
> +		sdm_ifm = false;
> +		sdm_di = false;
> +		chp_double_en = data->port_type == AIROHA_PCS_PON;
> +		break;
> +	case PHY_INTERFACE_MODE_5GBASER:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		txpll_chp_br = 0xa;
> +		txpll_chp_ibias = 0x18;
> +		lpf_bwr = 0x16;
> +		sdm_hren = true;
> +		vco_cfix = 0x2;
> +		tcl_amp_vref = 0xb;
> +		vcodiv = false;
> +		sdm_ifm = true;
> +		sdm_di = true;
> +		chp_double_en = false;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (data->port_type == AIROHA_PCS_PON)
> +		/* XPON TDC */
> +		regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_PLL_MONCLK_SEL,
> +				AIROHA_PCS_ANA_TDC_AUTOEN);
> +
> +	/* TXPLL VCO LDO Out */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SSC_PERIOD,
> +			   AIROHA_PCS_ANA_TXPLL_LDO_VCO_OUT |
> +			   AIROHA_PCS_ANA_TXPLL_LDO_OUT,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LDO_VCO_OUT, 0x1) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LDO_OUT, 0x1));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_VTP_EN,
> +			   AIROHA_PCS_ANA_TXPLL_VTP |
> +			   AIROHA_PCS_ANA_TXPLL_VTP_EN,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VTP, 0x0) |
> +			   AIROHA_PCS_ANA_TXPLL_VTP_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TDC_SYNC_CK_SEL,
> +			   AIROHA_PCS_ANA_PLL_LDO_CKDRV_VSEL |
> +			   AIROHA_PCS_ANA_PLL_LDO_CKDRV_EN,
> +			   FIELD_PREP(AIROHA_PCS_ANA_PLL_LDO_CKDRV_VSEL, 0x1) |
> +			   AIROHA_PCS_ANA_PLL_LDO_CKDRV_EN);
> +
> +	/* Setup RSTB */
> +	/* FIXME: different order */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_REFIN_INTERNAL,
> +			   AIROHA_PCS_ANA_TXPLL_PLL_RSTB |
> +			   AIROHA_PCS_ANA_TXPLL_RST_DLY |
> +			   AIROHA_PCS_ANA_TXPLL_REFIN_DIV |
> +			   AIROHA_PCS_ANA_TXPLL_REFIN_INTERNAL,
> +			   AIROHA_PCS_ANA_TXPLL_PLL_RSTB |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_RST_DLY, 0x4) |
> +			   AIROHA_PCS_ANA_TXPLL_REFIN_DIV_1);
> +
> +	/* Setup SDM */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SDM_DI_EN,
> +			   AIROHA_PCS_ANA_TXPLL_SDM_MODE |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_IFM |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_DI_LS |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_DI_EN,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_SDM_MODE, 0) |
> +			   (sdm_ifm ? AIROHA_PCS_ANA_TXPLL_SDM_IFM : 0) |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_DI_LS_2_23 |
> +			   (sdm_di ? AIROHA_PCS_ANA_TXPLL_SDM_DI_EN : 0));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SDM_ORD,
> +			   AIROHA_PCS_ANA_TXPLL_SDM_HREN |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_OUT |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_ORD,
> +			   (sdm_hren ? AIROHA_PCS_ANA_TXPLL_SDM_HREN : 0) |
> +			   AIROHA_PCS_ANA_TXPLL_SDM_ORD_3SDM);
> +
> +	/* Setup SSC */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SSC_DELTA1,
> +			   AIROHA_PCS_ANA_TXPLL_SSC_DELTA |
> +			   AIROHA_PCS_ANA_TXPLL_SSC_DELTA1,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_SSC_DELTA, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_SSC_DELTA1, 0x0));
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SSC_EN,
> +			  AIROHA_PCS_ANA_TXPLL_SSC_TRI_EN |
> +			  AIROHA_PCS_ANA_TXPLL_SSC_PHASE_INI |
> +			  AIROHA_PCS_ANA_TXPLL_SSC_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SSC_PERIOD,
> +			   AIROHA_PCS_ANA_TXPLL_SSC_PERIOD,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_SSC_PERIOD, 0x0));
> +
> +	regmap_update_bits(priv->xfi_ana, AN7583_PCS_ANA_PXP_TXPLL_CHP_DOUBLE_EN,
> +			   AIROHA_PCS_ANA_TXPLL_SPARE_L,
> +			   chp_double_en ? AIROHA_PCS_ANA_TXPLL_SPARE_L : 0);
> +
> +	/* Setup LPF */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_CHP_IBIAS,
> +			   AIROHA_PCS_ANA_TXPLL_LPF_BC |
> +			   AIROHA_PCS_ANA_TXPLL_LPF_BR |
> +			   AIROHA_PCS_ANA_TXPLL_CHP_IOFST |
> +			   AIROHA_PCS_ANA_TXPLL_CHP_IBIAS,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LPF_BC, 0x1f) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LPF_BR, txpll_chp_br) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_CHP_IOFST, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_CHP_IBIAS, txpll_chp_ibias));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_LPF_BP,
> +			   AIROHA_PCS_ANA_TXPLL_LPF_BWC |
> +			   AIROHA_PCS_ANA_TXPLL_LPF_BWR |
> +			   AIROHA_PCS_ANA_TXPLL_LPF_BP,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LPF_BWC, 0x18) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LPF_BWR, lpf_bwr) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_LPF_BP, 0x2));
> +
> +	/* Setup VCO */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_LPF_EN,
> +			   AIROHA_PCS_ANA_TXPLL_VCO_CFIX,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VCO_CFIX, vco_cfix));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_VCO_HALFLSB_EN,
> +			   AIROHA_PCS_ANA_TXPLL_VCO_VCOVAR_BIAS_L |
> +			   AIROHA_PCS_ANA_TXPLL_VCO_VCOVAR_BIAS_H |
> +			   AIROHA_PCS_ANA_TXPLL_VCO_TCLVAR |
> +			   AIROHA_PCS_ANA_TXPLL_VCO_SCAPWR |
> +			   AIROHA_PCS_ANA_TXPLL_VCO_HALFLSB_EN,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VCO_VCOVAR_BIAS_L, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VCO_VCOVAR_BIAS_H, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VCO_TCLVAR, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_VCO_SCAPWR, 0x7) |
> +			   AIROHA_PCS_ANA_TXPLL_VCO_HALFLSB_EN);
> +
> +	/* Setup KBand */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_KBAND_CODE,
> +			   AIROHA_PCS_ANA_TXPLL_KBAND_KF |
> +			   AIROHA_PCS_ANA_TXPLL_KBAND_KFC |
> +			   AIROHA_PCS_ANA_TXPLL_KBAND_DIV |
> +			   AIROHA_PCS_ANA_TXPLL_KBAND_CODE,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_KBAND_KF, 0x3) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_KBAND_KFC, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_KBAND_DIV, 0x2) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_KBAND_CODE, 0xe4));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_KBAND_KS,
> +			   AIROHA_PCS_ANA_TXPLL_KBAND_KS,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_KBAND_KS, 0x1));
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_LPF_BP,
> +			  AIROHA_PCS_ANA_TXPLL_KBAND_OPTION);
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_KBAND_VREF,
> +			  AIROHA_PCS_ANA_TXPLL_VCO_KBAND_MEAS_EN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_KBAND_LOAD_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_KBAND_LOAD_EN |
> +			   AIROHA_PCS_PMA_FORCE_DA_TXPLL_KBAND_LOAD_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_KBAND_LOAD_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_KBAND_KS,
> +			   AIROHA_PCS_ANA_TXPLL_MMD_PREDIV_MODE |
> +			   AIROHA_PCS_ANA_TXPLL_POSTDIV_EN,
> +			   AIROHA_PCS_ANA_TXPLL_MMD_PREDIV_MODE_2 |
> +			   AIROHA_PCS_ANA_TXPLL_POSTDIV_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_AMP_GAIN,
> +			   AIROHA_PCS_ANA_TXPLL_TCL_AMP_VREF |
> +			   AIROHA_PCS_ANA_TXPLL_TCL_AMP_GAIN,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_TCL_AMP_VREF, tcl_amp_vref) |
> +			   AIROHA_PCS_ANA_TXPLL_TCL_AMP_GAIN_4);
> +
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_KBAND_VREF,
> +				AIROHA_PCS_ANA_TXPLL_POSTDIV_D256_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_LPF_EN,
> +			   AIROHA_PCS_ANA_TXPLL_VCODIV,
> +			   vcodiv ? AIROHA_PCS_ANA_TXPLL_VCODIV_2 :
> +				    AIROHA_PCS_ANA_TXPLL_VCODIV_1);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_KBAND_VREF,
> +			   AIROHA_PCS_ANA_TXPLL_TCL_KBAND_VREF,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TXPLL_TCL_KBAND_VREF, 0xf));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_LPF_EN,
> +			   AIROHA_PCS_ANA_TXPLL_TCL_LPF_BW |
> +			   AIROHA_PCS_ANA_TXPLL_TCL_LPF_EN,
> +			   AIROHA_PCS_ANA_TXPLL_TCL_LPF_BW_0_5 |
> +			   AIROHA_PCS_ANA_TXPLL_TCL_LPF_EN);
> +
> +	regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_SDM_ORD,
> +			AIROHA_PCS_ANA_TXPLL_TCL_AMP_EN);
> +
> +	/* Setup TX TermCal */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TX_TXLBRC_EN,
> +			   AIROHA_PCS_ANA_TX_TERMCAL_VREF_L |
> +			   AIROHA_PCS_ANA_TX_TERMCAL_VREF_H,
> +			   FIELD_PREP(AIROHA_PCS_ANA_TX_TERMCAL_VREF_L, 0x2) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_TX_TERMCAL_VREF_H, 0x2));
> +
> +	/* Setup XPON RX */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_FE_EQ_HZEN,
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ3_EN |
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ2_EN |
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ1_EN |
> +			   AIROHA_PCS_ANA_RX_FE_EQ_HZEN,
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ3_EN |
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ2_EN |
> +			   AIROHA_PCS_ANA_RX_FE_VB_EQ1_EN);
> +
> +	regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_FE_VCM_GEN_PWDB,
> +			AIROHA_PCS_ANA_FE_VCM_GEN_PWDB);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_LPF_RATIO,
> +			   AIROHA_PCS_ANA_CDR_LPF_TOP_LIM,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_LPF_TOP_LIM, 0x8000));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_LPF_BOT_LIM,
> +			   AIROHA_PCS_ANA_CDR_LPF_BOT_LIM,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_LPF_BOT_LIM, 0x78000));
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_CKREF_DIV,
> +			  AIROHA_PCS_ANA_CDR_PR_RSTB_BYPASS);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_DAC_RANGE,
> +			   AIROHA_PCS_ANA_RX_DAC_RANGE_EYE,
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_DAC_RANGE_EYE, 0x2));
> +}
> +
> +static void an7583_pcs_cfg_phy_type(struct airoha_pcs_priv *priv,
> +				    phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data = priv->data;
> +
> +	/* Enable PLL force selection and Force Disable */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_CKOUT_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_EN |
> +			   AIROHA_PCS_PMA_FORCE_DA_TXPLL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_EN);
> +
> +	if (data->port_type == AIROHA_PCS_PON) {
> +		/* TDC */
> +		regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_3,
> +				   AIROHA_PCS_PMA_LCPLL_NCPO_SHIFT,
> +				   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_NCPO_SHIFT, 0x1));
> +		regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_1,
> +				   AIROHA_PCS_PMA_LCPLL_A_TDC,
> +				   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_A_TDC, 0x5));
> +		regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TX_TERMCAL_SELPN,
> +				   AIROHA_PCS_ANA_TX_TDC_CK_SEL,
> +				   FIELD_PREP(AIROHA_PCS_ANA_TX_TDC_CK_SEL, 0x0));
> +		regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_PHYCK_DIV,
> +				AIROHA_PCS_ANA_RX_TDC_CK_SEL);
> +	}
> +
> +	/* PLL EN HW Mode */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_LCPLL_PWCTL_SETTING_1,
> +			   AIROHA_PCS_PMA_LCPLL_CK_STB_TIMER |
> +			   AIROHA_PCS_PMA_LCPLL_PCW_MAN_LOAD_TIMER |
> +			   AIROHA_PCS_PMA_LCPLL_EN_TIMER |
> +			   AIROHA_PCS_PMA_LCPLL_MAN_PWDB,
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_CK_STB_TIMER, 0x1) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_PCW_MAN_LOAD_TIMER, 0x10) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_EN_TIMER, 0xa) |
> +			   AIROHA_PCS_PMA_LCPLL_MAN_PWDB);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PON_TX_COUNTER_1,
> +			   AIROHA_PCS_PMA_TX_HSDATA_EN_WAIT |
> +			   AIROHA_PCS_PMA_TX_CK_EN_WAIT,
> +			   FIELD_PREP(AIROHA_PCS_PMA_TX_HSDATA_EN_WAIT, 0x113) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_TX_CK_EN_WAIT, 0xfa));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PON_TX_COUNTER_2,
> +			   AIROHA_PCS_PMA_TX_SERDES_RDY_WAIT |
> +			   AIROHA_PCS_PMA_TX_POWER_ON_WAIT,
> +			   FIELD_PREP(AIROHA_PCS_PMA_TX_SERDES_RDY_WAIT, 0x9b) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_TX_POWER_ON_WAIT, 0x210));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PON_TX_COUNTER_0,
> +			   AIROHA_PCS_PMA_TXCALIB_5US |
> +			   AIROHA_PCS_PMA_TXCALIB_50US,
> +			   FIELD_PREP(AIROHA_PCS_PMA_TXCALIB_5US, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_TXCALIB_50US, 0x26));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_0,
> +			   AIROHA_PCS_PMA_LCPLL_KI,
> +			   FIELD_PREP(AIROHA_PCS_PMA_LCPLL_KI, 0x3));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_PW_5,
> +			  AIROHA_PCS_PMA_LCPLL_TDC_SYNC_IN_MODE);
> +
> +	an7583_pcs_common_phya_txpll(priv, interface);
> +	an7583_pcs_common_phya_tx(priv, interface);
> +
> +	/* RX HW mode counter */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_0,
> +			   AIROHA_PCS_PMA_RX_OS_START,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_OS_START, 0x1));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_6,
> +			   AIROHA_PCS_PMA_RX_OS_END,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_OS_END, 0x2));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_0,
> +			   AIROHA_PCS_PMA_OSC_SPEED_OPT,
> +			   AIROHA_PCS_PMA_OSC_SPEED_OPT_0_1);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_1,
> +			   AIROHA_PCS_PMA_RX_PICAL_END |
> +			   AIROHA_PCS_PMA_RX_PICAL_START,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_PICAL_END, 0x3e8) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_PICAL_START, 0x2));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_4,
> +			   AIROHA_PCS_PMA_RX_SDCAL_END |
> +			   AIROHA_PCS_PMA_RX_SDCAL_START,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_SDCAL_END, 0x3e8) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_SDCAL_START, 0x2));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_2,
> +			   AIROHA_PCS_PMA_RX_PDOS_END |
> +			   AIROHA_PCS_PMA_RX_PDOS_START,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_PDOS_END, 0x3e8) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_PDOS_START, 0x2));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_3,
> +			   AIROHA_PCS_PMA_RX_FEOS_END |
> +			   AIROHA_PCS_PMA_RX_FEOS_START,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_FEOS_END, 0x3e8) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_FEOS_START, 0x2));
> +
> +	/* RX Settings */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_2,
> +			   AIROHA_PCS_PMA_FOM_NUM_ORDER |
> +			   AIROHA_PCS_PMA_A_SEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FOM_NUM_ORDER, 0x1) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_A_SEL, 0x3));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_0,
> +			   AIROHA_PCS_PMA_X_MAX | AIROHA_PCS_PMA_X_MIN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_X_MAX, 0x240) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_X_MIN, 0x1c0));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_2,
> +			  AIROHA_PCS_PMA_DATA_SHIFT);
> +
> +	an7583_pcs_common_phya_rx(priv, interface);
> +	an7583_pcs_common_phya_ana(priv, interface);
> +
> +	/* Setup EYE */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_2,
> +			AIROHA_PCS_PMA_EYECNT_FAST);
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_3,
> +			AIROHA_PCS_PMA_EYE_NEXTPTS);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEOPENING_CTRL_0,
> +			   AIROHA_PCS_PMA_EYECNT_VTH |
> +			   AIROHA_PCS_PMA_EYECNT_HTH,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYECNT_VTH, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYECNT_HTH, 0x4));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEOPENING_CTRL_1,
> +			   AIROHA_PCS_PMA_EO_VTH |
> +			   AIROHA_PCS_PMA_EO_HTH,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EO_VTH, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EO_HTH, 0x4));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_0,
> +			   AIROHA_PCS_PMA_EYE_MASK |
> +			   AIROHA_PCS_PMA_CNTLEN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYE_MASK, 0xff) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_CNTLEN, 0xd0));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_0,
> +			   AIROHA_PCS_PMA_VEO_MASK |
> +			   AIROHA_PCS_PMA_HEO_MASK |
> +			   AIROHA_PCS_PMA_EQ_EN_DELAY,
> +			   FIELD_PREP(AIROHA_PCS_PMA_VEO_MASK, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_HEO_MASK, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_EN_DELAY, 0x1));
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_1,
> +			AIROHA_PCS_PMA_A_LGAIN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CAL1,
> +			   AIROHA_PCS_PMA_CAL_CYC |
> +			   AIROHA_PCS_PMA_CAL_STB |
> +			   AIROHA_PCS_PMA_CAL_1US_SET |
> +			   AIROHA_PCS_PMA_SIM_FAST_EN,
> +			   AIROHA_PCS_PMA_CAL_CYC_15 |
> +			   AIROHA_PCS_PMA_CAL_STB_8US |
> +			   FIELD_PREP(AIROHA_PCS_PMA_CAL_1US_SET, 0x2e) |
> +			   AIROHA_PCS_PMA_SIM_FAST_EN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CAL2,
> +			   AIROHA_PCS_PMA_CAL_CYC_TIME |
> +			   AIROHA_PCS_PMA_CAL_OUT_OS |
> +			   AIROHA_PCS_PMA_CAL_OS_PULSE,
> +			   FIELD_PREP(AIROHA_PCS_PMA_CAL_CYC_TIME, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_CAL_OUT_OS, 0x0));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_CTRL_5,
> +			   AIROHA_PCS_PMA_RX_RDY |
> +			   AIROHA_PCS_PMA_RX_BLWC_RDY_EN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_RDY, 0xa) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_BLWC_RDY_EN, 0x5));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_RX_FEOS,
> +			   AIROHA_PCS_PMA_EQ_FORCE_BLWC_FREEZE |
> +			   AIROHA_PCS_PMA_LFSEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_FORCE_BLWC_FREEZE, 0x0));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_1,
> +			   AIROHA_PCS_PMA_INDEX_MODE |
> +			   AIROHA_PCS_PMA_Y_MAX |
> +			   AIROHA_PCS_PMA_Y_MIN,
> +			   AIROHA_PCS_PMA_INDEX_MODE |
> +			   FIELD_PREP(AIROHA_PCS_PMA_Y_MAX, 0x3f) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_Y_MIN, 0x40));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_2,
> +			   AIROHA_PCS_PMA_EYEDUR,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYEDUR, 0x18));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EXTRAL_CTRL,
> +			   AIROHA_PCS_PMA_L2D_TRIG_EQ_EN_TIME |
> +			   AIROHA_PCS_PMA_OS_RDY_LATCH |
> +			   AIROHA_PCS_PMA_DISB_LEQ,
> +			   FIELD_PREP(AIROHA_PCS_PMA_L2D_TRIG_EQ_EN_TIME, 0x2) |
> +			   AIROHA_PCS_PMA_OS_RDY_LATCH);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_0,
> +			   AIROHA_PCS_PMA_KBAND_KFC |
> +			   AIROHA_PCS_PMA_FPKDIV |
> +			   AIROHA_PCS_PMA_KBAND_PREDIV,
> +			   AIROHA_PCS_PMA_KBAND_KFC_8 |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FPKDIV, 0xa5) |
> +			   AIROHA_PCS_PMA_KBAND_PREDIV_4);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_1,
> +			   AIROHA_PCS_PMA_SYMBOL_WD |
> +			   AIROHA_PCS_PMA_SETTLE_TIME_SEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_SYMBOL_WD, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_SETTLE_TIME_SEL, 0x1));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_5,
> +			   AIROHA_PCS_PMA_FLL_IDAC_MIN |
> +			   AIROHA_PCS_PMA_FLL_IDAC_MAX,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FLL_IDAC_MIN, 0x400) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FLL_IDAC_MAX, 0x1ff));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_2,
> +			   AIROHA_PCS_PMA_AMP |
> +			   AIROHA_PCS_PMA_PRBS_SEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_AMP, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_PRBS_SEL, 0x3));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_4,
> +			  AIROHA_PCS_PMA_DISB_BLWC_OFFSET);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_PDOS_CTRL_0,
> +			   AIROHA_PCS_PMA_EYE_BLWC_ADD |
> +			   AIROHA_PCS_PMA_DATA_BLWC_ADD,
> +			   AIROHA_PCS_PMA_DATA_BLWC_ADD);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_RX_BLWC,
> +			   AIROHA_PCS_PMA_EQ_BLWC_CNT_BOT_LIM |
> +			   AIROHA_PCS_PMA_EQ_BLWC_CNT_TOP_LIM |
> +			   AIROHA_PCS_PMA_EQ_BLWC_GAIN |
> +			   AIROHA_PCS_PMA_EQ_BLWC_POL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_BLWC_CNT_BOT_LIM, 0x10) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_BLWC_CNT_TOP_LIM, 0x70) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_BLWC_GAIN, 0xa) |
> +			   AIROHA_PCS_PMA_EQ_BLWC_POL_INVERSION);
> +}
> +
> +static void an7583_pcs_common_phya_txpll_on(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_CKOUT_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_CKOUT_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_TXPLL_CKOUT_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_LCPLL_PWCTL_SETTING_0,
> +			AIROHA_PCS_PMA_SW_LCPLL_EN);
> +
> +	udelay(6);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_CKOUT_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_TXPLL_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_KBAND_VREF,
> +			   AIROHA_PCS_ANA_TXPLL_FREQ_MEAS_EN |
> +			   AIROHA_PCS_ANA_TXPLL_VREF_SEL,
> +			   AIROHA_PCS_ANA_TXPLL_FREQ_MEAS_EN |
> +			   AIROHA_PCS_ANA_TXPLL_VREF_SEL_VBG);
> +
> +	regmap_set_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_PHY_CK1_EN,
> +			AIROHA_PCS_ANA_TXPLL_PHY_CK2_EN |
> +			AIROHA_PCS_ANA_TXPLL_PHY_CK1_EN);
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_TXPLL_TCL_KBAND_VREF,
> +			  AIROHA_PCS_ANA_TXPLL_FREQ_MEAS_EN);
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_JCPLL_FREQ_MEAS_EN,
> +			  AIROHA_PCS_ANA_TXPLL_IB_EXT_EN);
> +
> +	udelay(500);
> +}
> +
> +static void an7583_pcs_common_phya_tx_on(struct airoha_pcs_priv *priv)
> +{
> +	u32 xfi_tx_term_sel = 0x1;
> +	// int efuse_valid;
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_RST_B,
> +			AIROHA_PCS_PMA_TX_TOP_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_ADD_CLKPATH_RST_0,
> +			AIROHA_PCS_PMA_CLKPATH_RSTB_CK |
> +			AIROHA_PCS_PMA_CLKPATH_RST_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_RST_B,
> +			AIROHA_PCS_PMA_TXCALIB_RST_B |
> +			AIROHA_PCS_PMA_TX_TOP_RST_B);
> +
> +	udelay(100);
> +
> +	/* TODO handle efuse */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_TX_CALIB_0,
> +			   AIROHA_PCS_PMA_TXCALIB_FORCE_TERMP_SEL |
> +			   AIROHA_PCS_PMA_TXCALIB_FORCE_TERMP_SEL_EN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_TXCALIB_FORCE_TERMP_SEL,
> +				      xfi_tx_term_sel) |
> +			   AIROHA_PCS_PMA_TXCALIB_FORCE_TERMP_SEL_EN);
> +}
> +
> +static void an7583_pcs_common_phya_rx_preset(struct airoha_pcs_priv *priv,
> +					     phy_interface_t interface)
> +{
> +	u32 cdr_pr_buf_in_sr;
> +	bool cdr_pr_cap_en;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		cdr_pr_cap_en = true;
> +		cdr_pr_buf_in_sr = 0x6;
> +		break;
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		cdr_pr_cap_en = false;
> +		cdr_pr_buf_in_sr = 0x7;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* Setup RX Precondition */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_SIGDET_NOVTH,
> +			   AIROHA_PCS_ANA_RX_SIGDET_VTH_SEL |
> +			   AIROHA_PCS_ANA_RX_SIGDET_PEAK,
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_SIGDET_VTH_SEL, 0x2) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_SIGDET_PEAK, 0x2));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_DAC_RANGE,
> +			   AIROHA_PCS_ANA_RX_SIGDET_LPF_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_SIGDET_LPF_CTRL, 0x3));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_MONPR_EN,
> +			   AIROHA_PCS_ANA_CDR_PR_CAP_EN |
> +			   AIROHA_PCS_ANA_CDR_BUF_IN_SR,
> +			   (cdr_pr_cap_en ? AIROHA_PCS_ANA_CDR_PR_CAP_EN : 0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_BUF_IN_SR, cdr_pr_buf_in_sr));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_RDY);
> +
> +	/* Setup L2R */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA);
> +
> +	/* Setup LEQ setting */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_JCPLL_SDM_SCAN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_PEAKING_CTRL |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_PEAKING_CTRL |
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL, 0x0));
> +
> +	/* Keep EYE reset */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			AIROHA_PCS_PMA_FORCE_EYE_RESET_PLU_O);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_EYE_RESET_PLU_O);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			  AIROHA_PCS_PMA_FORCE_EYE_TOP_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_EYE_TOP_EN);
> +
> +	/* Kepp BLWC reset */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_BLWC_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_BLWC_RX_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_RX_BLWC_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			AIROHA_PCS_PMA_FORCE_RX_BLWC_EN);
> +}
> +
> +static void an7583_pcs_common_phya_rx_on(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_PIEYE_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PR_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PWDB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_PIEYE_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PR_PIEYE_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PIEYE_PWDB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PD_PWDB,
> +			  AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PR_KBAND_RSTB |
> +			  AIROHA_PCS_PMA_FORCE_DA_CDR_PR_KBAND_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PD_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PD_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PD_PWDB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_FE_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_FE_PWDB);
> +
> +	/* RX SigDet Pwdb */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_SCAN_RST_B,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_SIGDET_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_SIGDET_PWDB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_SCAN_RST_B,
> +			  AIROHA_PCS_PMA_FORCE_SEL_DA_RX_SCAN_RST_B |
> +			  AIROHA_PCS_PMA_FORCE_DA_RX_SCAN_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_DA_XPON_PWDB_0,
> +			AIROHA_PCS_PMA_XPON_CDR_PD_PWDB |
> +			AIROHA_PCS_PMA_XPON_CDR_PR_PIEYE_PWDB |
> +			AIROHA_PCS_PMA_XPON_CDR_PW_PWDB |
> +			AIROHA_PCS_PMA_XPON_RX_FE_PWDB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_DA_XPON_PWDB_1,
> +			AIROHA_PCS_PMA_RX_SIDGET_PWDB);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_SYS_EN_SEL_0,
> +			   AIROHA_PCS_PMA_RX_SYS_EN_SEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_RX_SYS_EN_SEL, 0x1));
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_VREG_IBAND_VAL,
> +			   AIROHA_PCS_ANA_CDR_PR_FBKSEL |
> +			   AIROHA_PCS_ANA_CDR_PR_VREG_CKBUF_VAL |
> +			   AIROHA_PCS_ANA_CDR_PR_VREG_IBAND_VAL,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_PR_FBKSEL, 0x0) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_PR_VREG_CKBUF_VAL, 0x5) |
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_PR_VREG_IBAND_VAL, 0x5));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_PDOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_FEOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_SDCAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_BLWC_EN);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_CKREF_DIV,
> +			   AIROHA_PCS_ANA_CDR_PR_CKREF_DIV,
> +			   AIROHA_PCS_ANA_CDR_PR_CKREF_DIV_1);
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_PR_TDC_REF_SEL,
> +			   AIROHA_PCS_ANA_CDR_PR_CKREF_DIV1,
> +			   AIROHA_PCS_ANA_CDR_PR_CKREF_DIV1_1);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_RX_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_REF_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB);
> +
> +	udelay(100);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			  AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB);
> +}
> +
> +static void an7583_pcs_common_phya_l2d(struct airoha_pcs_priv *priv)
> +{
> +	/* Setup LPF L2D force and disable */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA);
> +
> +	udelay(200);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB);
> +}
> +
> +static void an7583_pcs_common_phya_tdc_off(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_IDAC,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_SDM_PCW);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_3,
> +			AIROHA_PCS_PMA_LCPLL_NCPO_LOAD);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_SDM_PCW_CHG,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_TXPLL_SDM_PCW_CHG);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_SDM_PCW_CHG,
> +			  AIROHA_PCS_PMA_FORCE_DA_TXPLL_SDM_PCW_CHG);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TXPLL_SDM_PCW_CHG,
> +			AIROHA_PCS_PMA_FORCE_DA_TXPLL_SDM_PCW_CHG);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_FLT_1,
> +			   AIROHA_PCS_PMA_LCPLL_GPON_SEL,
> +			   AIROHA_PCS_PMA_LCPLL_GPON_SEL_FROM_EPON);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_LCPLL_TDC_PW_0,
> +			  AIROHA_PCS_PMA_LCPLL_TDC_DIG_PWDB);
> +
> +	udelay(100);
> +}
> +
> +static void an7583_pcs_common_phya_rx_oscal(struct airoha_pcs_priv *priv)
> +{
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_FBCK_LOCK);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			AIROHA_PCS_PMA_FORCE_FBCK_LOCK);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_JCPLL_SDM_SCAN_RSTB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_CKON |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_CKON);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_OSCAL_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_RSTB |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_OSCAL_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_EN);
> +
> +	udelay(200);
> +
> +	/* Set normal of force mode */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_RDY);
> +
> +	/* Disable force mode signal */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_RDY);
> +
> +	/* Release reset enable */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +}
> +
> +static void an7583_pcs_common_phya_pical(struct airoha_pcs_priv *priv)
> +{
> +	/* Pre Condition */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_2,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_CDR_PR_PIEYE);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_PI_CAL,
> +			   AIROHA_PCS_PMA_KPGAIN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_KPGAIN, 0x4));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_0,
> +			   AIROHA_PCS_PMA_EQ_EN_DELAY,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_EN_DELAY, 0x8));
> +
> +	/* Reset Block */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			  AIROHA_PCS_PMA_EQ_PI_CAL_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			  AIROHA_PCS_PMA_FORCE_RX_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_6,
> +			  AIROHA_PCS_PMA_DISB_RX_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			  AIROHA_PCS_PMA_FORCE_REF_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_6,
> +			  AIROHA_PCS_PMA_DISB_REF_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_3,
> +			  AIROHA_PCS_PMA_DISB_RQ_PI_CAL_RDY);
> +
> +	/* Enable */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			  AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_5,
> +			  AIROHA_PCS_PMA_DISB_RX_OR_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_3,
> +			  AIROHA_PCS_PMA_FORCE_EQ_PI_CAL_RDY);
> +
> +	/* Release Reset and Enable */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			AIROHA_PCS_PMA_EQ_PI_CAL_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			AIROHA_PCS_PMA_FORCE_RX_AND_PICAL_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			AIROHA_PCS_PMA_FORCE_REF_AND_PICAL_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			AIROHA_PCS_PMA_FORCE_RX_PICAL_EN);
> +
> +	udelay(200);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			  AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_3,
> +			AIROHA_PCS_PMA_FORCE_EQ_PI_CAL_RDY);
> +}
> +
> +static void an7583_pcs_common_phya_pdos(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_FE_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_PDOSCAL_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_PDOSCAL_EN);
> +
> +	/* Pre Condition */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_RDY);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_1,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_E0);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_1,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_D1);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_1,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_D0);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_2,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_E1);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_2,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_EYE);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_BLWC_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_BLWC_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_EYEDUR_INIT_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_EYEDUR_INIT_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_EYECNT_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_EYECNT_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_EYEDUR_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_EYEDUR_EN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_PDOS_CTRL_0,
> +			   AIROHA_PCS_PMA_SAP_SEL,
> +			   AIROHA_PCS_PMA_SAP_SEL_SHIFT_8);
> +
> +	/* Reset Block */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			  AIROHA_PCS_PMA_FORCE_PDOS_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_6,
> +			  AIROHA_PCS_PMA_DISB_PDOS_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_1,
> +			  AIROHA_PCS_PMA_PDOS_RST_B);
> +
> +	/* Disable */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_PDOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_PDOS_EN);
> +
> +	/* Release Reset and Enable */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			AIROHA_PCS_PMA_FORCE_PDOS_RX_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_1,
> +			AIROHA_PCS_PMA_PDOS_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			AIROHA_PCS_PMA_FORCE_RX_PDOS_EN);
> +
> +	udelay(200);
> +
> +	/* Disable (again) */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_PDOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +
> +	/* Release EYE related */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_EYEDUR_INIT_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_EYEDUR_INIT_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_EYECNT_RX_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			AIROHA_PCS_PMA_DISB_EYECNT_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_EYEDUR_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_EYEDUR_EN);
> +
> +	/* Disable PDOS */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_FE_PWDB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_PDOSCAL_EN |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_PDOSCAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_PDOSCAL_EN);
> +}
> +
> +static void an7583_pcs_common_phya_feos(struct airoha_pcs_priv *priv)
> +{
> +	/* Pre Condition */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_RDY);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_2,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_FE_VOS);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_BLWC_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_BLWC_RX_RST_B);
> +
> +	/* Setting */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_RX_FEOS,
> +			   AIROHA_PCS_PMA_LFSEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_LFSEL, 0x30));
> +
> +	/* Reset */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_FEOS_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_FEOS_RX_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			  AIROHA_PCS_PMA_FEOS_RST_B);
> +
> +	/* Disable */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_FEOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_FEOS_EN);
> +
> +	/* Release Reset and Enable */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			AIROHA_PCS_PMA_FORCE_FEOS_RX_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			AIROHA_PCS_PMA_FEOS_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			AIROHA_PCS_PMA_FORCE_RX_FEOS_EN);
> +
> +	udelay(1000);
> +
> +	/* Disable */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_FEOS_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_OS_EN);
> +}
> +
> +static void an7583_pcs_common_phya_sdcal(struct airoha_pcs_priv *priv)
> +{
> +	/* Pre Condition */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_SIGDET_CAL_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_SIGDET_CAL_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_SIGDET_CAL_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_OSCAL_EN,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_EN |
> +			AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_EN);
> +
> +	/* Reset */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			  AIROHA_PCS_PMA_CAL_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			  AIROHA_PCS_PMA_FORCE_SDCAL_REF_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_SDCAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			  AIROHA_PCS_PMA_DISB_SDCAL_REF_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_SDCAL_EN);
> +
> +	/* Release Reset and Enable */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			AIROHA_PCS_PMA_CAL_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_8,
> +			AIROHA_PCS_PMA_FORCE_SDCAL_REF_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			AIROHA_PCS_PMA_FORCE_RX_SDCAL_EN);
> +
> +	udelay(200);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_FORCE_RX_SDCAL_EN);
> +
> +	/* SigDet Cal Disable */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_SIGDET_CAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_SIGDET_CAL_EN |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_SIGDET_CAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_SIGDET_CAL_EN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_JCPLL_SDM_SCAN_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_CKON |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_CKON,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_CKON);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_OSCAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_RSTB);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_RX_OSCAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_EN |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_OSCAL_EN,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_OSCAL_EN);
> +}
> +
> +static void an7583_pcs_common_phya_phy_status(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			AIROHA_PCS_PMA_FORCE_RX_OS_RDY);
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_OS_RDY);
> +	udelay(1);
> +}
> +
> +static void an7583_pcs_common_phya_eye_setting(struct airoha_pcs_priv *priv,
> +					       phy_interface_t interface)
> +{
> +	u32 x_min, x_max;
> +	u32 cdr_lpf_ratio;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		x_min = 0x0;
> +		x_max = 0x400;
> +		cdr_lpf_ratio = 0x3;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		x_min = 0x140;
> +		x_max = 0x2c0;
> +		cdr_lpf_ratio = 0x0;
> +		break;
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		x_min = 0x180;
> +		x_max = 0x280;
> +		cdr_lpf_ratio = 0x1;
> +		break;
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		x_min = 0x1c0;
> +		x_max = 0x234;
> +		cdr_lpf_ratio = 0x0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_CDR_LPF_RATIO,
> +			   AIROHA_PCS_ANA_CDR_LPF_RATIO,
> +			   FIELD_PREP(AIROHA_PCS_ANA_CDR_LPF_RATIO,
> +				      cdr_lpf_ratio));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_0,
> +			   AIROHA_PCS_PMA_EYE_MASK,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYE_MASK, 0xff));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_0,
> +			   AIROHA_PCS_PMA_X_MAX | AIROHA_PCS_PMA_X_MIN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_X_MAX, x_max) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_X_MIN, x_min));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_0,
> +			   AIROHA_PCS_PMA_CNTLEN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_CNTLEN, 0xf8));
> +
> +	regmap_clear_bits(priv->xfi_ana, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_0,
> +			  AIROHA_PCS_PMA_CNTFOREVER);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_2,
> +			  AIROHA_PCS_PMA_DATA_SHIFT);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_1,
> +			  AIROHA_PCS_PMA_INDEX_MODE);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_2,
> +			   AIROHA_PCS_PMA_EYEDUR,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYEDUR, 0x44c));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEINDEX_CTRL_3,
> +			   AIROHA_PCS_PMA_EYE_NEXTPTS |
> +			   AIROHA_PCS_PMA_EYE_NEXTPTS_TOGGLE |
> +			   AIROHA_PCS_PMA_EYE_NEXTPTS_SEL,
> +			   AIROHA_PCS_PMA_EYE_NEXTPTS);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEOPENING_CTRL_0,
> +			   AIROHA_PCS_PMA_EYECNT_VTH |
> +			   AIROHA_PCS_PMA_EYECNT_HTH,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYECNT_VTH, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EYECNT_HTH, 0x4));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYEOPENING_CTRL_1,
> +			   AIROHA_PCS_PMA_EO_VTH |
> +			   AIROHA_PCS_PMA_EO_HTH,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EO_VTH, 0x4) |
> +			   FIELD_PREP(AIROHA_PCS_PMA_EO_HTH, 0x4));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_1,
> +			  AIROHA_PCS_PMA_B_ZERO_SEL |
> +			  AIROHA_PCS_PMA_HEO_EMPHASIS |
> +			  AIROHA_PCS_PMA_A_MGAIN |
> +			  AIROHA_PCS_PMA_A_LGAIN);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_2,
> +			   AIROHA_PCS_PMA_A_SEL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_A_SEL, 0x1));
> +}
> +
> +static void an7583_pcs_common_phya_eye_cal(struct airoha_pcs_priv *priv)
> +{
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_TX_RATE_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PR_PIEYE |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PIEYE,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PIEYE, 0x0));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_FLL_COR,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_DAC_EYE |
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_DAC_EYE,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_DAC_EYE, 0x0));
> +
> +	/* Redo PICal and reset Block */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_0,
> +			   AIROHA_PCS_PMA_EQ_EN_DELAY,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_EN_DELAY, 0x80));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_PI_CAL,
> +			   AIROHA_PCS_PMA_KPGAIN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_KPGAIN, 0x1));
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			  AIROHA_PCS_PMA_EQ_PI_CAL_RST_B);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			  AIROHA_PCS_PMA_FORCE_RX_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_6,
> +			  AIROHA_PCS_PMA_DISB_RX_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			  AIROHA_PCS_PMA_FORCE_REF_AND_PICAL_RSTB);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_6,
> +			  AIROHA_PCS_PMA_DISB_REF_AND_PICAL_RSTB);
> +
> +	/* Enable PICal */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_5,
> +			  AIROHA_PCS_PMA_DISB_RX_OR_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			  AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_0,
> +			  AIROHA_PCS_PMA_DISB_RX_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_0,
> +			  AIROHA_PCS_PMA_FORCE_RX_PICAL_EN);
> +
> +	/* Release Reset */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_RESET_0,
> +			AIROHA_PCS_PMA_EQ_PI_CAL_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			AIROHA_PCS_PMA_FORCE_RX_AND_PICAL_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_7,
> +			AIROHA_PCS_PMA_FORCE_REF_AND_PICAL_RSTB);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	udelay(1000);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			  AIROHA_PCS_PMA_FORCE_RX_OR_PICAL_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_3,
> +			  AIROHA_PCS_PMA_DISB_RQ_PI_CAL_RDY);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_3,
> +			AIROHA_PCS_PMA_FORCE_EQ_PI_CAL_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_5,
> +			  AIROHA_PCS_PMA_DISB_EYECNT_RDY);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			AIROHA_PCS_PMA_FORCE_EYECNT_RDY);
> +
> +	udelay(1000);
> +}
> +
> +static void an7583_pcs_common_phya_eye_eo_read(struct airoha_pcs_priv *priv,
> +					       u32 *heo, u32 *veo)
> +{
> +	u32 eo_buf[EO_BUF_MAX];
> +	u32 eye_el, eye_er;
> +	u32 feos;
> +	u32 val;
> +	int i;
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_6,
> +			AIROHA_PCS_PMA_LNX_SW_FLL_4_LATCH_EN |
> +			AIROHA_PCS_PMA_LNX_SW_FLL_3_LATCH_EN |
> +			AIROHA_PCS_PMA_LNX_SW_FLL_2_LATCH_EN |
> +			AIROHA_PCS_PMA_LNX_SW_FLL_1_LATCH_EN);
> +
> +	udelay(50);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FLL_6,
> +			  AIROHA_PCS_PMA_LNX_SW_FLL_4_LATCH_EN |
> +			  AIROHA_PCS_PMA_LNX_SW_FLL_3_LATCH_EN |
> +			  AIROHA_PCS_PMA_LNX_SW_FLL_2_LATCH_EN |
> +			  AIROHA_PCS_PMA_LNX_SW_FLL_1_LATCH_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DEBUG_0,
> +			  AIROHA_PCS_PMA_RO_TOGGLE);
> +
> +	udelay(100);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DEBUG_0,
> +			AIROHA_PCS_PMA_RO_TOGGLE);
> +
> +	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_RX_TORGS_DEBUG_10, &val);
> +	eye_el = FIELD_GET(AIROHA_PCS_PMA_EYE_EL, val);
> +	eye_er = FIELD_GET(AIROHA_PCS_PMA_EYE_ER, val);
> +
> +	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_RX_TORGS_DEBUG_11, &val);
> +	eo_buf[EYE_EU] = FIELD_GET(AIROHA_PCS_PMA_EYE_EU, val);
> +	eo_buf[EYE_EB] = FIELD_GET(AIROHA_PCS_PMA_EYE_EB, val);
> +
> +	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_ADD_RX2ANA_1, &val);
> +	eo_buf[DAC_EYE] = FIELD_GET(AIROHA_PCS_PMA_RX_DAC_EYE, val);
> +	eo_buf[DAC_D0] = FIELD_GET(AIROHA_PCS_PMA_RX_DAC_D0, val);
> +	eo_buf[DAC_D1] = FIELD_GET(AIROHA_PCS_PMA_RX_DAC_D1, val);
> +	eo_buf[DAC_E0] = FIELD_GET(AIROHA_PCS_PMA_RX_DAC_E0, val);
> +
> +	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_ADD_RX2ANA_2, &val);
> +	eo_buf[FEOS] = FIELD_GET(AIROHA_PCS_PMA_RX_FEOS_OUT, val);
> +	eo_buf[DAC_E1] = FIELD_GET(AIROHA_PCS_PMA_RX_DAC_E1, val);
> +
> +	feos = eo_buf[FEOS];
> +
> +	for (i = 0; i < ARRAY_SIZE(eo_buf); i++) {
> +		if (eo_buf[i] == feos && eo_buf[i] >= 32)
> +			eo_buf[i] = eo_buf[i] - 64;
> +		else if (eo_buf[i] >= 64)
> +			eo_buf[i] = eo_buf[i] - 128;
> +	}
> +
> +	/* Check if CLK unlocking happens (E0 result validity) */
> +	regmap_read(priv->xfi_pma, AIROHA_PCS_PMA_RX_TORGS_DEBUG_5, &val);
> +	if (!FIELD_GET(AIROHA_PCS_PMA_HEO_RDY, val)) {
> +		regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_0,
> +				  AIROHA_PCS_PMA_DISB_DA_XPON_CDR_LPF_RSTB);
> +
> +		regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_0,
> +				  AIROHA_PCS_PMA_FORCE_DA_XPON_CDR_LPF_RSTB);
> +
> +		udelay(500);
> +
> +		regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_0,
> +				AIROHA_PCS_PMA_FORCE_DA_XPON_CDR_LPF_RSTB);
> +
> +		udelay(500);
> +	}
> +
> +	*heo = abs(eye_er - eye_el);
> +	*veo = abs(eo_buf[EYE_EU] - eo_buf[EYE_EB]);
> +}
> +
> +static void an7583_pcs_common_phya_eye_eo(struct airoha_pcs_priv *priv,
> +					  phy_interface_t interface,
> +					  u32 *heo, u32 *veo)
> +{
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_EYE_RESET_PLU_O);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			AIROHA_PCS_PMA_FORCE_EYE_RESET_PLU_O);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			  AIROHA_PCS_PMA_FORCE_EYE_RESET_PLU_O);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_EYE_TOP_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			  AIROHA_PCS_PMA_FORCE_EYE_TOP_EN);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			AIROHA_PCS_PMA_FORCE_EYE_TOP_EN);
> +
> +	if (interface == PHY_INTERFACE_MODE_10GBASER ||
> +	    interface == PHY_INTERFACE_MODE_USXGMII)
> +		udelay(5500);
> +	else
> +		udelay(55 * 1000);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_2,
> +			AIROHA_PCS_PMA_DISB_DA_XPON_CDR_PR_PIEYE |
> +			AIROHA_PCS_PMA_DISB_DA_XPON_RX_DAC_EYE);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_EYEDUR_INIT_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_7,
> +			AIROHA_PCS_PMA_DISB_EYECNT_RX_RST_B);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_EYE_TOP_EYECNT_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_EYEDUR_EN);
> +
> +	an7583_pcs_common_phya_eye_eo_read(priv, heo, veo);
> +
> +	/* Clear Eye SW value */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			AIROHA_PCS_PMA_FORCE_EYE_RESET_PLU_O);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_8,
> +			  AIROHA_PCS_PMA_DISB_EYE_TOP_EN);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_9,
> +			  AIROHA_PCS_PMA_FORCE_EYE_TOP_EN);
> +
> +	/* Reset PICal Rdy */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_3,
> +			  AIROHA_PCS_PMA_DISB_RQ_PI_CAL_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_3,
> +			  AIROHA_PCS_PMA_FORCE_EQ_PI_CAL_RDY);
> +
> +	/* Reset Eyecnt Rdy */
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_DISB_MODE_5,
> +			  AIROHA_PCS_PMA_DISB_EYECNT_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_FORCE_MODE_6,
> +			  AIROHA_PCS_PMA_FORCE_EYECNT_RDY);
> +}
> +
> +static void an7583_pcs_common_phya_eo_scan(struct airoha_pcs_priv *priv,
> +					   phy_interface_t interface)
> +{
> +	u32 best_heo = 0, best_veo = 0;
> +	u32 leq_gain, best_leq_gain;
> +	u32 best_leq_peacking = 0;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		leq_gain = 3;
> +		break;
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		leq_gain = 1;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	best_leq_gain = leq_gain;
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_PR_PIEYE_PWDB,
> +			AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_PR_PIEYE_PWDB |
> +			AIROHA_PCS_PMA_FORCE_DA_CDR_PR_PIEYE_PWDB);
> +
> +	an7583_pcs_common_phya_eye_setting(priv, interface);
> +
> +	/* EYE Open */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PHY_EQ_CTRL_0,
> +			   AIROHA_PCS_PMA_EQ_EN_DELAY,
> +			   FIELD_PREP(AIROHA_PCS_PMA_EQ_EN_DELAY, 0x80));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_PI_CAL,
> +			   AIROHA_PCS_PMA_KPGAIN,
> +			   FIELD_PREP(AIROHA_PCS_PMA_KPGAIN, 0x4));
> +
> +	for (; leq_gain <= FIELD_MAX(AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL); leq_gain++) {
> +		u32 leq_peaking;
> +		u32 heo, veo;
> +
> +		regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_FE_GAIN_CTRL,
> +				   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_GAIN_CTRL |
> +				   AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL,
> +				   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_GAIN_CTRL |
> +				   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL, leq_gain));
> +
> +		for (leq_peaking = 0;
> +		     leq_peaking <= FIELD_MAX(AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL);
> +		     leq_peaking++) {
> +			regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_JCPLL_SDM_SCAN,
> +					   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_PEAKING_CTRL |
> +					   AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL,
> +					   AIROHA_PCS_PMA_FORCE_SEL_DA_RX_FE_PEAKING_CTRL |
> +					   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL, leq_peaking));
> +
> +			udelay(500);
> +
> +			an7583_pcs_common_phya_eye_cal(priv);
> +			an7583_pcs_common_phya_eye_eo(priv, interface, &heo, &veo);
> +
> +			if (veo > 53 && best_veo > 53) {
> +				if (heo > best_heo) {
> +					best_heo = heo;
> +					best_veo = veo;
> +					best_leq_peacking = leq_peaking;
> +					best_leq_gain = leq_gain;
> +				} else if (heo == best_heo && veo > best_veo) {
> +					best_heo = heo;
> +					best_veo = veo;
> +					best_leq_peacking = leq_peaking;
> +					best_leq_gain = leq_gain;
> +				}
> +			} else {
> +				if (veo > best_veo) {
> +					best_heo = heo;
> +					best_veo = veo;
> +					best_leq_peacking = leq_peaking;
> +					best_leq_gain = leq_gain;
> +				}
> +			}
> +		}
> +	}
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_FE_GAIN_CTRL,
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_GAIN_CTRL, best_leq_gain));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_JCPLL_SDM_SCAN,
> +			   AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL,
> +			   FIELD_PREP(AIROHA_PCS_PMA_FORCE_DA_RX_FE_PEAKING_CTRL, best_leq_peacking));
> +}
> +
> +static void an7583_pcs_common_phya_rxrdy(struct airoha_pcs_priv *priv)
> +{
> +	u32 xfi_rx_term_sel = 0x1;
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			AIROHA_PCS_PMA_FORCE_RX_RDY);
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			  AIROHA_PCS_PMA_SW_RX_FIFO_RST_N);
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_RX_FIFO_RST_N);
> +
> +	/* TODO HANDLE EFUSE */
> +	regmap_update_bits(priv->xfi_ana, AIROHA_PCS_ANA_PXP_RX_SIGDET_NOVTH,
> +			   AIROHA_PCS_ANA_RX_FE_50OHMS_SEL,
> +			   FIELD_PREP(AIROHA_PCS_ANA_RX_FE_50OHMS_SEL,
> +				      xfi_rx_term_sel));
> +}
> +
> +static void an7583_pcs_common_phya_bist_setting(struct airoha_pcs_priv *priv)
> +{
> +	regmap_write(priv->xfi_pma, AIROHA_PCS_PMA_BISTCTL_ALIGN_PAT,
> +		     0x8ff1fd53);
> +	regmap_write(priv->xfi_pma, AIROHA_PCS_PMA_BISTCTL_PRBS_INITIAL_SEED,
> +		     0xFF1FD53);
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_BISTCTL_PRBS_FAIL_THRESHOLD,
> +			   AIROHA_PCS_PMA_BISTCTL_PRBS_FAIL_THRESHOLD_MASK,
> +			   FIELD_PREP(AIROHA_PCS_PMA_BISTCTL_PRBS_FAIL_THRESHOLD_MASK, 0x1));
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_BISTCTL_CONTROL,
> +			   AIROHA_PCS_PMA_BISTCTL_PAT_SEL,
> +			   AIROHA_PCS_PMA_BISTCTL_PAT_SEL_PRBS31);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_BISTCTL_POLLUTION,
> +			AIROHA_PCS_PMA_BIST_TX_DATA_POLLUTION_LATCH);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_SS_BIST_1,
> +			  AIROHA_PCS_PMA_LNX_BISTCTL_BIT_ERROR_RST_SEL |
> +			  AIROHA_PCS_PMA_ANLT_PX_LNX_LT_LOS);
> +}
> +
> +static void an7583_pcs_first_plug_in(struct airoha_pcs_priv *priv,
> +				     phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data = priv->data;
> +
> +	an7583_pcs_common_phya_rx_preset(priv, interface);
> +	if (data->port_type == AIROHA_PCS_PON)
> +		an7583_pcs_common_phya_tdc_off(priv);
> +	an7583_pcs_common_phya_rx_on(priv);
> +	an7583_pcs_common_phya_l2d(priv);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_REF_RST_N);
> +
> +	an7583_pcs_common_phya_rx_oscal(priv);
> +	an7583_pcs_common_phya_pical(priv);
> +	an7583_pcs_common_phya_pdos(priv);
> +	an7583_pcs_common_phya_feos(priv);
> +	an7583_pcs_common_phya_sdcal(priv);
> +	an7583_pcs_common_phya_phy_status(priv);
> +
> +	an7583_pcs_dig_reset_release(priv);
> +
> +	an7583_pcs_common_phya_l2d(priv);
> +
> +	if (data->port_type == AIROHA_PCS_PON)
> +		an7583_pcs_common_phya_eo_scan(priv, interface);
> +	an7583_pcs_common_phya_rxrdy(priv);
> +	if (data->port_type == AIROHA_PCS_PON)
> +		an7583_pcs_common_phya_bist_setting(priv);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_ADD_XPON_MODE_1,
> +			  AIROHA_PCS_PMA_TX_BIST_GEN_EN |
> +			  AIROHA_PCS_PMA_R2T_MODE);
> +}
> +
> +static void an7583_pcs_ana_reset_release(struct airoha_pcs_priv *priv)
> +{
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_XFI_RXPCS_RST_N |
> +			AIROHA_PCS_PMA_SW_XFI_TXPCS_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_XFI_RXPCS_BIST_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_HSG_RXPCS_RST_N |
> +			AIROHA_PCS_PMA_SW_HSG_TXPCS_RST_N);
> +
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
> +			AIROHA_PCS_PMA_SW_XFI_RXMAC_RST_N |
> +			AIROHA_PCS_PMA_SW_XFI_TXMAC_RST_N);
> +}
> +
> +int an7583_pcs_common_phya_bringup(struct airoha_pcs_priv *priv,
> +				   phy_interface_t interface)
> +{
> +	an7583_pcs_dig_reset_hold(priv);
> +
> +	an7583_pcs_cfg_phy_type(priv, interface);
> +
> +	an7583_pcs_common_phya_txpll_on(priv);
> +
> +	an7583_pcs_common_phya_tx_on(priv);
> +
> +	an7583_pcs_first_plug_in(priv, interface);
> +
> +	an7583_pcs_ana_reset_release(priv);
> +
> +	return 0;
> +}
> +
> +void an7583_pcs_common_phya_link_up(struct airoha_pcs_priv *priv)
> +{
> +	/* First CDR reset */
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB);
> +
> +	udelay(700);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB);
> +
> +	udelay(100);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_RSTB |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB,
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_RSTB);
> +
> +	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_PXP_CDR_LPF_LCK_2DATA,
> +			   AIROHA_PCS_PMA_FORCE_SEL_DA_CDR_LPF_LCK2DATA |
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA,
> +			   AIROHA_PCS_PMA_FORCE_DA_CDR_LPF_LCK2DATA);
> +
> +	/* Then RX Rdy reset */
> +	regmap_set_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_DISB_CTRL_1,
> +			AIROHA_PCS_PMA_DISB_RX_RDY);
> +
> +	regmap_clear_bits(priv->xfi_pma, AIROHA_PCS_PMA_RX_CTRL_SEQUENCE_FORCE_CTRL_1,
> +			  AIROHA_PCS_PMA_DISB_RX_RDY);
> +}
