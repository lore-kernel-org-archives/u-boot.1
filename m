Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731A0C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7863360825;
	Tue, 21 Jul 2026 09:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYZh8BCskEJ8; Tue, 21 Jul 2026 09:16:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53F6F607DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784625403;
	bh=ysrqru0Kr1J3bUVEcH7oy2eME9hwKFi+JLX5Rmi9nnY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tY8LdYt7CBewcfA+e/Vohr7tohGGj2a8N+0zvJYk8KI6iLqwOq4jNtWaUcF5ngjMS
	 lnNEo1P10+2OYdToG0+EGO/bGzDeaANrTnGw4FvPkj5VZgpnUEpDjGKECJbUWFY//S
	 vsHITh6eG5HEcPitIgUYl40kahWm2vsikG6uL2sPrAwlvrB+oKet7LmLdXb1mYQE7l
	 WofJRTWrP5Q43l5YIw48mYiJrhRUWR7TjBTfdAVaWLWVZbIWnzhDOZyLldRKXTA5TR
	 7TkPp4LS+U7towsbn8SaN+UXIuUofEYlKsDg9WlaDdTQYTPMTZUW2pspP5EMWCFean
	 ORDuDnW5Bkdaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53F6F607DB;
	Tue, 21 Jul 2026 09:16:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67115FCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5127880A9F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7Z7ts_0sxEl for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:16:41 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2109180DBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2109180DBD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2109180DBD
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:16:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E45844F6; Tue, 21 Jul 2026 11:16:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A188C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:16:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPy+Coy+vXYTrynEu13n6HTbCgZvuwUYMOGLsHxaaVrHyr4DGArPIbpteFUM1UHbKOLSv4NATs4TNLPhrmfU0VaWjNtED+dm8YZo/mIRW/cYHNDutmDyRE8fXA216bTLXx/DHWMCNB5zHb8ZUHpNq8bgSnN13b3LQhcgBnM71Jk75OAsrxTFtlO9Vg6IWzYBnm1SFYwsJGLYmlO2ASyobEsf5yK513jC3BwP07OB3Bm0vsf2ON6o4BU944ka/9dgJzNLVQz+ZpgkQiUSIvqqmdws2qw+OoY0yThdiZF+lv65rCnyiKt1cida/fs/5I0QNosWoUqd0Wu4FIFmYR3//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysrqru0Kr1J3bUVEcH7oy2eME9hwKFi+JLX5Rmi9nnY=;
 b=FqUr2OhHdhfxMPSykXwIgK/OhJ6QZ3yy5+dlNSqCxpm9KWJZzxtrhqIeY0AsHqbjHRyDJkt1WpxATOyMQQlx6ErdN3lnIF33h99rC/X6OGgIdVyyCktdCz6bqgHZlGwbe6G3+FJl1H0J1UWPQZJ9ioGhuJVDynMvz3pU3lXpXuR/yxjRY2Cxfmi1hP7YKX9yPQKP4OUIQUTD2KwFa1giocKKfGk4qbA9IXiUVN9Lw5PWo9nJLJDi1sLsFNAL0I/aIYheGjNTmW2MbwDMcqW4nut0g2Ih39nA6AfcuV3JTpQAWFNhsQiYcuiMXx+9QQf2g8i62MlWxM6Uhoh6ZEizMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:16:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 09:16:35 +0000
Message-ID: <3b131df7-ce38-4bfb-9260-5df48ca5c83c@cherry.de>
Date: Tue, 21 Jul 2026 11:16:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] spl: Simplify xPL_BUILD conditional guard example
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-6-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260708220540.3368825-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B77.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::61b) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBAPR04MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d2cf35-c2ad-4a15-e980-08dee708c333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0RCAIf9ptrQyMGuhAztwHm70H2aAcYmmYPOb9RK87yCtHqMUFwjEQylGOjQTroNoALrLNSajrSzvqo+r+ully8JFUEdVu2d5UDnphZP6bLWN+OjLDSRGXC6Ty01VherJ4WEg5iyvZDkFEtRi+QszlcLwhIyse/EeEOmRzJ7fqKzo2tsi5AYIktaXzVMs0lHnd4qdmetpUmsyZNOaGRHxSo0hLWPw6NmW8rYtER5v8xgwNTvVhfLOXxXBRM5e6JoL0HDFMgDiI8dcMLG2vKee/An+/poyNUCtKuHphK0OSgaIhV6t8Ol9FAO8aDiOcjyFJMgB2A3MSyovCEnzVllvNN0a+Z0ds9clq7dPx5o5j7rUX+JaOq+24hFI5OdAh9+qcdSJ/0fCvPAq2iXMUAB9neBWEIfgwnZUsCYW7Q3HAvnkdb7ozKpYu9e2ekHjA/JNboxqVQymiQY5KeMRLh+hBZx5/1sbqCu7DlYDN7AHdCFeSgmz8bHmnpnQQG256g8jOvYAZWocITBFjZRJCxPAmU6lrxZIhvFUSlT61m1bppwtU9R5rWrFLn3XumkQs/S4U2ZKFfqsfxiuLtJFX8ZAsQTh99ScJ1uWh9iz8UhmEjGjXs2cQ3sSBhJOi8bx7AWgviSmyNQwbUWVMquimI2zRS61TAHOWAIWlpgT2B0xshs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVzOHNTaHpKaVh5KytpU0I3M1ZHTE5HOG1obktmb0xHeUpsNWRkR1J5Z2Vv?=
 =?utf-8?B?aEYxZytkemcrVlBVL05Ha1kwd0ttOXJReDBBcWlIa1FEckh3b29HcWFSaHFy?=
 =?utf-8?B?c0JrcEJDVnI0YlR6ZW00ZnZHeTlybksrdDE1cG9KMnFlb0dmY3NJb1dhWU9a?=
 =?utf-8?B?ZlR3UVNlM0xKZUlyanFsNVFoUERSRW11RXZSdzNtbjFlU0VQbW15VUprbnQ1?=
 =?utf-8?B?NldTSmlCTjBDcXllNThBUzVaakUzNjdUVnUvZnhOTzYxMC9vem80Yi9QL2Ux?=
 =?utf-8?B?bE9zUTl4Y1lwUVlNeG5FQnNuOCtoTU8yM3JNOW5jU3ZwMGFMYlZteWpzRzJm?=
 =?utf-8?B?S3dMYkxpNjdhODM5a3UzdkpTU1BpNWdZN2ZCeXplNWRHL3RUbjE1TWcySFNX?=
 =?utf-8?B?UUpnbW51SFhDZXE5TDROcVZQOEpVUS9uRi9DUUZNdWp1eUJINmpmWTg5ZlVm?=
 =?utf-8?B?endCV3Zka0dGMWJGZkpKWXpNZUZxS29lM2NCdDd2aGZVQys1MXJVUjc5UkNL?=
 =?utf-8?B?MGhwK0htNHdvMVdGQXJUajVkVnB5OG5DY09nSGphWmhBMllyTlAzVEtjejQz?=
 =?utf-8?B?U1Nidmx1NnRxRVhsVUptMUVLOGtzU0xPbnlMNHErTnRZM1FzYk4yck9xc0JI?=
 =?utf-8?B?ZFBZd0Z1bzNLRE8rQVZjbmh6ZzZzbFZMbEZWb25rbUI2ampFMzJremF2Ky8w?=
 =?utf-8?B?aC8zTGgxT2M5cFlmNEFheGxMbk1EdDI1VktPQ0ZTcVEvc0FLR1dhS0RZVEFR?=
 =?utf-8?B?N2FqV1JkMWRMYjNoMTVmSEJrbHZPT0VoT2pGY2lHVUFVY1ZEQ2JUN1JHZUFi?=
 =?utf-8?B?RWp1ZjVFdk9oazg2TjVNWnVkbG45b04zeEt6bllhdUJZVWE4emNDNVN1dGpp?=
 =?utf-8?B?RVpQMGVIc1dTdWlxblZ6V1NlcDdJcWJpSlpXcEJVWkcxbUpWTmZMTktXTGdP?=
 =?utf-8?B?NGJuaWZiWDlza1BXRXh4bi9RdjgyV2pwYjhJV212cC8wNjQwbklNSGFnQ1dw?=
 =?utf-8?B?ckZvYmY4UFpBT2duNVVRVjhsUHJaMXp5Z2NGYjV4TXlSbWJFaXdDZFdmWGta?=
 =?utf-8?B?QXlVS0N3a2JiY3daQ0U1RmoycHpEaVhzVmdqZy9Ic1EvZkMvSG5tSi9EVWFQ?=
 =?utf-8?B?S0pvczNuMXNmMmhQNjVISkQ0YW5ud2U0SGhKOFd0QTFZblV0R0Nmem1YUDhE?=
 =?utf-8?B?ZjdEcG9PejF1Wmw4SFNUbFdmclU2ZGcyMCswUjNtMnlYcnNCdm5TTXRqZEQ3?=
 =?utf-8?B?UVJjQ1FaRXlFaGNiMFFJbGp1YXhzcjlyam9qOUhnMXNGMzBZclpVbjVuaFIz?=
 =?utf-8?B?NlN6S0dMaGpUb0F3M2dMK25mMEIrdzh3RHkzcm04RitMODlDVGJXVjVRRWg5?=
 =?utf-8?B?Q1Q4UWZ3Z09VUnIxWEJtQkRtQVZ5TTBERnlZV1NYTmJ6Y25KV1ppd3I3ZTNH?=
 =?utf-8?B?SUs1VE5PYmlaRm9admsyNGZwSHh6d3o0a3BqR01rd3JZOGFYdzZHdkVrTnpZ?=
 =?utf-8?B?UHlVWnZJQUJ0TUV3VlVXaWVjdFN4UUZmR1ZhR2pNSXdaWkh3c1dBQlpFSkFB?=
 =?utf-8?B?c0FlUWJ6YktDU0xOc2J0VlJ5MEppUGZwUEQzY3dNSzFVQ3ltYk5vdUFUMzZ6?=
 =?utf-8?B?a3VKVFJicW5OOGcxemRSamlMeThVVkFFVlQwMDFzU3ZRUGdXNUVzUk1sRW9t?=
 =?utf-8?B?RmRPRVc2YmwwNFQzbllCZ2RVMW5pa0xib0JyK242blU0RDN6SHVBY3B5UzFX?=
 =?utf-8?B?dHduR0pvZm1qUXJMOEVVWngxSWFNdkdyYXJSb3JVVlVNcCtwa0tjZW43anlR?=
 =?utf-8?B?M2FTODRyUkdGeDZheG9LVjBkQ2QvQ0tza2JSZEtoWGFUUE44RVBONHdKVXJQ?=
 =?utf-8?B?NlVpVG83Ly8xRFN5QUU1b2cxL1ZlazRUb2lGS1ZuWUdhcUpTbTVMMHFRamN6?=
 =?utf-8?B?Y3E2ZjJ4SHhnRjNDY1NPdFkyN09VUk9iclM4aDhtWWpjZ3cxVWE2NlQrTWN1?=
 =?utf-8?B?V3ZtSFlHUTNPcmpnUEJ3YTBiYkNNdlNwWWdGR1E1ZkdqdjZqZitueVo5OUFD?=
 =?utf-8?B?akcvUW9LYXBLOUFDSmpYcm8vRGN6dHdDNklid2VUdU5oYXdJeTRDSG5ZTjQz?=
 =?utf-8?B?bjl3UmlnOVF0Y1BUcWh4THF2dFBZQTJGVXJTM0hrdC9RbERtVkhSMU9NZEZH?=
 =?utf-8?B?aFg4dW9oT3dOdG53RlNiMGNYV0t6OTAzdjUvQVpFTWtCMVg5TDZVbUIwWmZv?=
 =?utf-8?B?ZmErTk9RYUVtNWN2VDQ5TFU4NlVPNkRKbFp1V2lxTkppcHdUazhabDF4TGhl?=
 =?utf-8?B?ZHpBeXRvUlExZG1pSVVkMisyelBiRVkvSzlBWk5XZnB3QVNPa1lIUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d2cf35-c2ad-4a15-e980-08dee708c333
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:16:35.5579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hFxbd6rygwC3DKsH3YWEKv/OhwBXxPgd/mC6Ou1WZJdVjRMMwbrWJaEQ3nbzLk2cDNAq6GliCgNIk+DUp8OQqReCm0msBaO1U852uQInus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysrqru0Kr1J3bUVEcH7oy2eME9hwKFi+JLX5Rmi9nnY=;
 b=OaC3ah3BbbEjpSKKGCLQd3myMsnxyIJ0q0GIFh6xSwgqiZr18Pg47ygclRu+Jtq1OZHPIvas9+s/TlE4Wu0a4PAerC8tS8HiIT/FLiO1dPwAA9hxFA8iggIV7YnmXvFKhRO+UQuM9pOBjzubyFGwacWzDllk/k/Q9EE2dfPmfw4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OaC3ah3B
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="OaC3ah3B"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/9/26 12:05 AM, Jonas Karlman wrote:
> The old meaning of the SPL_BUILD symbol has been transfered to a new
> XPL_BUILD symbol, leaving the SPL_BUILD symbol only to be defined for
> SPL builds, and not all xPL builds.
> 
> Change to only use the SPL_BUILD symbol in the SPL code example to
> cleanup from an old SPL to XPL symbol rename.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
