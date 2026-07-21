Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF454C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6782380D9F;
	Tue, 21 Jul 2026 12:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5IZ8ikoxU1j; Tue, 21 Jul 2026 12:19:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55D0C80BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784636386;
	bh=gixXAVcKdtpbVJynwMGkzUTY16zuZiZyPMlr5OmkC6Y=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oYfUHzPwytORbwJg6Ab3Ps1gIkj7Fj5rLC3tyDRE2OQejCQtnphRn7I9AfeQmvb58
	 jbFA9CXag//4VRGxd0YwS2lM0im+0thK+84fhd5mYpx/umIp7HAPhkDUB3EHMN8vdv
	 ZLZW5I3Zax6GrRqf5HuPSEOesEqajucIvRnEZNT3pM0ufKBORsQF4PcKIyc9UxRrDh
	 2v8CDosawVdTAgCD25hUX1mxj+UpFeqh9BUr3UpXWFwQ2JNqSrJUKmu6INZxqMtMRs
	 6Xp9H13PrFk5GWUpHJQ9AWSzx6EWA/jx+IZtCccFDWNvuXVmh6BIG8wsRGb8TORPkf
	 brufygBkkNUqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55D0C80BA9;
	Tue, 21 Jul 2026 12:19:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40D8D1099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3271B6081A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nf4XHuuojeQB for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:19:44 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 25244605E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25244605E9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25244605E9
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:19:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3332B846A4; Tue, 21 Jul 2026 14:19:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CFF803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:19:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW5A9zc0WI3Wu61+nmK8SF19Bx/P5SZpl8pvF53uS5lPICsChHRIObSKPc5tU10TJ7O3Nda1dOmPOzTdcDj0t6GxdpWKxzJKhVifQa2A986LJXMFqwFVt3CxcB31oyxF8OR7bs+W1OYXsRa2u3LpV67/er5YLS4zikQUvC2tBqCun13b+1YYcODqi/GMsfrV6QQ6kkMl+G37PVNHkw7gIjRmIg2is/RwZwPiFGzYM0SXJ+uKgFpFoiZiZ4TEnQQcpN+fYi6ivAxzHOtX9kl/CfZvOGCRox7U0XDdp3Xi+M0CpceBZwewG9WOT/9N2R01FkjpJuiIaGELUi9JlW95ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gixXAVcKdtpbVJynwMGkzUTY16zuZiZyPMlr5OmkC6Y=;
 b=ZENyD55isIg4DTVn6GeoBuY8N/k0CNhxZsymlGLRTbRHS1GPJOAHlZbcQWGmnYlYeGUfZ75mwlteKmrxRA97mqErjK5lQ8L2YD4J1LXffFnFoqNRq7jfuQl903uXqviOGlgcuv9P+KexnBSDzSY9kBoeUrBFZ5cwsEYzTKq6aBmx18Lo2eQ9Wp4obcl8QzauZ7y2YzPrBxqczA4zMds0C8vYFWMRqLnT/Ulde4tJ741UPfeL029pKq1Le9nT0yMSwJK8HjaWdf7D5tgDgPT9Yw8IUr3tBGh+dX1kiVzg+eLE2xvOSqVIq0e3RK7G27vV4vIgoiRSwpQlsplbe1EJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:19:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 12:19:37 +0000
Message-ID: <3bdc641d-7279-4618-94a4-dd9f33442388@cherry.de>
Date: Tue, 21 Jul 2026 14:19:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: rockchip: pll: let rockchip_rk3588_pll_k_get
 update m directly
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-4-cdf47f2ca0b8@flipper.net>
Content-Language: en-US
In-Reply-To: <20260713-rk3588-fracpll-v1-4-cdf47f2ca0b8@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0218.eurprd07.prod.outlook.com
 (2603:10a6:802:58::21) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: a1964561-9600-4a58-6143-08dee72254c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ontA/exVO5eXmTpkpspsSOMmd5xMp/jDSjJGII5D0XcnM2QVRYfL8lwF1VGGV+FbIKdeOgBBdzmKQFGcuHxsA2Jg0wZLCA0LaPqGspdMi9/NGywzrA5JSeG1Hy7/e7PHGgqM/dxenWFW/NFljJCDybt3doULQXHHZrTiTvhtWAddJOEfXFcLYMpT/qH8gyYDXjNr+3vmjtIjKg/oC+pJI7u2BdFyiMMUPCsaad6/ugXOX+FFLzXAtyvNe4ejijGnJRCaNcARFrYwFo/v9aaM5Cp9kKIIl5kpYWwrEnc6GnwVJzdioa/YQLE9MOZcZD45+IlkvsWdoiiRrpkoF27BoPqUlHQ9WLq4iKkVb363rVwfzOcYu9rOgmm1DB2lLiaSs0Phpk5rG04zNx0jTEyOF7MUqAwNFQGAaFx0qtrGG28RAT6Pwz6olsov8mssJeL9yHX8+013eL1CWIMk2pRw0dj+rdiXorZbkZ0UdRGe+4zliAiP5THdtppZH9dFPw3M/ioB9KfDB00/x0FHQoD6C0aPtR+4mt1jzOUhy8wap9cGUsrYptwhi03Dz6HSUspmpC0O66XhWa3u2/e8ZWDGF1ybar5GaccXd6Lyco5A2D1bRn6gspkWTsLczNq61f1yibRo+FlJ+2h8j7AYkDRFgLMF+VSI/EOe5ZPCmWjlZx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtBUHgwbjJXNnEvSVpPZ0h4M2FTMVpIWFFpZFZiSU1tZVcvc0VOek95cGRy?=
 =?utf-8?B?WnE0MTdGaUhMNmV2Vk9QNU0wUGVscDZhMmw5ako2V2VtRXNkQXRBL3BjODV6?=
 =?utf-8?B?Q3R6Und6RVVSTmFEYTRhSDVFSkN5RlZyaW40UEdtNGREZWtGNk11OGpRdk5P?=
 =?utf-8?B?cGFSN2pQYnZPNzBBRUlFdXNXWUFYQmhLS1dURENJcFpiYW4rbmcrQzliMmw5?=
 =?utf-8?B?WWNYSDVGekFsRTYvb2llWXNGcFJLb1BzQVlNTi9pMVl4ZnVzdkMzWlM1eWVJ?=
 =?utf-8?B?djFaaW1hUGEzOTA3U2svZmxpNU8xdElua05qcnlPU2tBWXpmckM2L0tvRDZy?=
 =?utf-8?B?a1Q4amU2WWlXaWRLbVdDNUtndUNNWWg5NlhyeGVjM3RBaTcxSlFxZG85Wktx?=
 =?utf-8?B?bFo2bEs0eTB3TXVSV2trMDF2QTc3cVBRcUZLYUhYRFYxSk1PTEpJaEYvajdw?=
 =?utf-8?B?Q0J1aGlxem1NRzZIaWJUeFU2WWtwNkl3TlhzZXJVaCs3QlplczcxamZJR0lk?=
 =?utf-8?B?em84YVgrekZDMTR1dm9YeGxCQWVxQThORGlXNVU1Vnh6Vk9mb29TcjRoWFQ1?=
 =?utf-8?B?eWhNbGNKSkxjMysxd2FxQVpwQnY2TFhVMzlQTFJDejVsNjBkUmd0VC9KU2V1?=
 =?utf-8?B?SFErMC9SU0NQNHhWSWlzTTBJam1IVTFhLzlEcG9nc1dwcVQ4VjdVU2ZBdFpy?=
 =?utf-8?B?YVY2ejdiUXFsTUZIaTFCZ0RzNGhLV2hWL24vZVdWeXF2aEhpdjBueXRHdVdQ?=
 =?utf-8?B?czZDOGJXV1ZQK0RrYllDQlB2dmZ1YWhzZXlJeDhNbXQvNVRwQ1NxZEV6Yk1y?=
 =?utf-8?B?TU9RTUVVRFZsRlJEVFhCNWhBTWdSZTNkaFdZWjY3UVI3Qk9BMkVHb1poRmN2?=
 =?utf-8?B?UmFXbXM5Z056VXR3elJYaldoWlFRbUpFTURnaVVYQklsOTN1SFdBWFBrd1dk?=
 =?utf-8?B?eVRudzh1UW9OamR2ZjhMV1M3eVErdEdYRVVOd1ZicG5oWWtiQlNZRGQxbXlv?=
 =?utf-8?B?NWJXS3YxZDNDUFk5ejRBaXdITTEzM1Zoemd2TU1Oc2lCcTJqUURhRmNBTGZ2?=
 =?utf-8?B?SG9YNmxYbWVkcTNEMlNYbVlCT1FOVE8xdVdLcXFicWp5eGlqNXd3ZmRkVVFQ?=
 =?utf-8?B?WERESFBPZmU1SGxwc21QZWJoTEl2ejBIMGtSTmsxWFZKais2NHhJYTFUTThM?=
 =?utf-8?B?Q0NVa1F5SU5UbzBVR3VNRVkydHVtTnhIN0ZiUi9iUzNaTElPMTQ5TnpXdzF6?=
 =?utf-8?B?ZlAxdGtqS3E0aWpHQk9VandEbnlOMlFLM1czM2haVnFpNzlRSXl5bGxDRy9Q?=
 =?utf-8?B?TzBuOSs1ZTFzRVN2RVI5N29rVXV6b01PY0htd0VBVDFVNEF4a0wrMmN4VE9G?=
 =?utf-8?B?UjZqWHpzVEtjYzJheW9RSkNHVmkyeG5tNi83SzlxQ3lsSlF6d3JRTHRoL3p1?=
 =?utf-8?B?dTdSZExwTlhudGRoWHBqYjBMRnRsUGVKbjdKUFNvUnNNd3hXY3gwRVlMU2JQ?=
 =?utf-8?B?bTVQMEhxWVlkeG5aOU1hWFd1TVl3bWhLcXJBTUtwcDFxdHhjWUdFdUZwMlUx?=
 =?utf-8?B?azF6Szh3bDB3L1lmWVdUeFdwYjdZUmJpcmtwZmR3eHRGOCtaR2RLMmxRV2Fo?=
 =?utf-8?B?TTdmenRMcDRURXQ3aURGcjhzUjZyZUFPYzRjVVU5cUtBTlI4aDlLVkc4ajB3?=
 =?utf-8?B?eUdSSWlEMkpJeGJ2UGZLb08rMEl2V1V1aUdiUEErWk9UbUxoU3l3VXc2T1ZM?=
 =?utf-8?B?djR4MEhDSnBmb2FKK3BWT2s4cUpFL29iTUNwdkEzcG4zSUliRnFSa2R3TTMy?=
 =?utf-8?B?emNUclJxTmJtd2JSMWlENXJaNERDa2R1amREdTFyOHBPcDFxSnFudm04b1ZN?=
 =?utf-8?B?dkg4NkxydU9NZjhBYk8veHVqOWNqM2RRQlRpc1loOUsxNC96b2pHcURQbXZT?=
 =?utf-8?B?QW91Rm1YZG94QVRGeFJLaWFDSlZGN25JNkg3WFhjVTQ2dFFpTUE3QmRGUDYw?=
 =?utf-8?B?bndtWHJWVU5scHY0NkYrMm54RWNSN2hDeHRYL1MvK0VremJyMm44bnR4cWYz?=
 =?utf-8?B?dzhiM2M4alVvZUIvcW00R0ROYnl1WUswaHRwMUo0YVdSd0FYZzJSL04rMzhE?=
 =?utf-8?B?MVpUMmttMXNTQXhMQmRVbjhyUkF6dHNkbzlMaGFYTFZiV29oZmYxbDJwS2t2?=
 =?utf-8?B?NmtLQjJrVEVQdFNPRnZWaW5LR3lxdDZvSkpaMFRiNWNOTGlWZFl2VU9hdmNq?=
 =?utf-8?B?Yys3VXR4ZG52WnVWaGNLemc1MFYwYzJKck13WDFEc0VDRnB2L1VTREoyd3Ji?=
 =?utf-8?B?MVJNdFJzTHJtK25oOWptQUwxRGZPcHZJM0l5WURiYlpnNGp4Ync1UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a1964561-9600-4a58-6143-08dee72254c8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:19:37.2567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMrGAfG0mkAMOKjqwLi90HdXbyruS0lvulBieniLeqKudmaSdGuCQs7jzDpxA75sQzOsoC0Of5X5rBAKGAFRj4SRmOc3TzRTRDhBC4UErTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gixXAVcKdtpbVJynwMGkzUTY16zuZiZyPMlr5OmkC6Y=;
 b=MyxpBHTl0Af4VoiWatcgRdarOIxwh/c6rf0jRsbD8y1B0DVJrzRT+rAoArFzt6SBMaw4v5Y+ammm5wHxUyTRHQqwTAEEXbIOgYX24w4t0pQ0M3SeA1IHksmtlp9fUK61zEUKpvWHO8qNJmwna1B/OigvzqlL80XKACpV+xzdhfc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MyxpBHTl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="MyxpBHTl"; 
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

Hi Alexey,

On 7/13/26 8:35 PM, Alexey Charkov wrote:
> Selecting the next integer multiplier m is coupled to setting a negative
> fractional coefficient k. The current code checks for negative k in two
> separate places, which is error-prone.
> 

Yeah and it's kinda ugly :)

> Let rockchip_rk3588_pll_k_get update m directly, to make it the single
> source of truth for the final value of the integer multiplier m, which
> also reduces the number of scattered conditional branches in the code.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/clk/rockchip/clk_pll.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
> index c6fbeb71c77a..6324c11091af 100644
> --- a/drivers/clk/rockchip/clk_pll.c
> +++ b/drivers/clk/rockchip/clk_pll.c
> @@ -168,16 +168,21 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>   }
>   
>   static s16
> -rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
> +rockchip_rk3588_pll_k_get(u32 *m, u32 p, u32 s, u64 fin_hz, u64 fvco)
>   {
>   	u64 fref, ffrac;
>   	int k;
>   
>   	fref = fin_hz / p;
> -	ffrac = fvco - (m * fref);
> +	ffrac = fvco - (*m) * fref;
>   	k = ffrac * 65536 / fref;
>   	if (k > 32767) {
> -		ffrac = ((m + 1) * fref) - fvco;
> +		/*
> +		 * The requested rate is closer to the next integer multiplier
> +		 * m, so pick it and use a negative fractional coefficient k
> +		 */
> +		*m += 1;
> +		ffrac = (*m) * fref - fvco;
>   		/*
>   		 * Round up to avoid overshooting requested rate for negative k
>   		 */
> @@ -201,7 +206,10 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
>   			for (m = 64; m <= 1023; m++) {
>   				if ((fvco >= m * fin_hz / p) &&
>   				    (fvco < (m + 1) * fin_hz / p)) {
> -					k = rockchip_rk3588_pll_k_get(m, p, s,
> +					u32 m_tmp = m;
> +
> +					k = rockchip_rk3588_pll_k_get(&m_tmp,
> +								      p, s,
>   								      fin_hz,
>   								      fvco);
>   					if (!k)
> @@ -209,10 +217,7 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
>   					rate_table->p = p;
>   					rate_table->s = s;
>   					rate_table->k = k;
> -					if (k > 32767)
> -						rate_table->m = m + 1;
> -					else
> -						rate_table->m = m;
> +					rate_table->m = m_tmp;
>   					return rate_table;

I don't like this much more, it's a halfway-solution to me. I suggest to 
pass rate_table pointer directly, instead of only m, and update 
rate_table m, p, s and k if we can find a k that works, otherwise leave 
the pointer untouched. Change the function to return 0 on success, 1 (or 
-EINVAL) otherwise and return rate_table in the for-loop if 0 is 
returned, otherwise continue.

Cheers,
Quentin
