Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353A606ED9C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X6wHxmPu;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Amo1EoM5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AFE6810F8;
	Fri, 13 Nov 2026 17:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huOwHAfdQFKo; Fri, 13 Nov 2026 17:58:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79C4E811D9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592688;
	b=UC6xO5YPgHrr30MVLoFm8QpayWUZ8VHs4I/4wWZnXzMjk6iUsulYLcPJL82ZC45iWWkw
	 O13sFK+WYAIg/8tz6UgMzjqbM6GsDUdQHBimS2we3em3/IfgkR8qvFaQ7dkDIc4k99Vhu
	 oc64QhhpMqGRsmuVozTtrd0Gd7UgTLM5OrkomTLGeSED8qKrGhO9Jw9RyEgUz6T6ySlxJ
	 7qBa+IvSX4ydMnfivYJMEpkqKdVmRqRbUPCyf8ZUy4YEgovXYkinssX4eKnBpC8N2SL5J
	 3eurWauz7lpDK//1RVHMaMc6iMU7oSmcRNiZrG+PN/PumNt76vEp7Et740t2hXMJHfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592688;
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
	bh=3jzS1QxH9U5ZbxN3+W10UZCkUIpSebWYo9RmrL4h3dE=;
	b=Qgnq10/lCkMRtFt7l2QnP6qo2CeEaent5G32dKvh7ofegR5+euWs5/spiihXPaBkCYni
	 onV9yYIxkkZLr4+KP0IaIo9Xl1DenlJ5l/2wKqUtvgBOfLgDsZtaxyBBhjDq0nUnUw4C2
	 TAWVM1/PMjAwDK8B42E7kBjL9xT5aFuT6gKxw3ZcMNerHdIy19nKmKrxYxcIxu4Vov6aT
	 QaxDZTJdFeepU0MXKV1NY2QAZPWVIICHycbVQ1RwbqjlRcjeBGR5Gj523n5S9dcB5K+dX
	 5HyDzTWBF0IJ4ilD5QD7zd4BaGcVpj1AVJFygbr88FynQ56h1TaLqtAEpkUwewMagfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Amo1EoM5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592688;
	bh=3jzS1QxH9U5ZbxN3+W10UZCkUIpSebWYo9RmrL4h3dE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6wHxmPuUinZwyirJqgMqvGv2T1a8F4UNM0pI7skgc0FYleas7U7naUr7fMTSEY4l
	 XvlWeUGKT0ivKYSNTOoOhcdyQBDnaK9SNZ/QQl9BhOLz0SiDJ+PWMNSGizymMwe+Qo
	 7TTGh6udTCaRfUMyBbw98Fx+wnrmfhbYnjmQBgMsvVYeTf3kXK4R3gAj7Mz6n62A3F
	 XkP1EF4tOabFTgqmh0EMCL2txFtHMyfpiSeNekHo7DyZHY1LBb+eUKVQknG8wuiHLN
	 p2EvQsmq3Jhjs8Me0TnVU+ClO2mNPCVI0kj4yNWEsz9dvt9/w/YLwtd6FvEbszLNjH
	 oTKJog+7ksIOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79C4E811D9;
	Fri, 13 Nov 2026 17:58:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F6142FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60DE7810F8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmcOIRvDZsov for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46976811D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Amo1EoM5
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46976811D9
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jzS1QxH9U5ZbxN3+W10UZCkUIpSebWYo9RmrL4h3dE=;
 b=Amo1EoM55zWA4rsiv+VvR6PBxeOpMBWzlK2p47j+PWpPPdI0PchPYtJSQWEK61IvbF3bA29euIg9g27NFllTQazYOMV4lrh/PvgMk9JwffUpQ0scagYOBHmigBuwueR3i+QQb0/FFF9lEuDKT7VLf5mMMI/XQdp8BSSPwIQ5OJ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:58:03 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:58:03 +0000
Message-ID: <e0da2196-56d5-440d-8c99-2c96b885dbce@cherry.de>
Date: Fri, 13 Nov 2026 18:58:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/37] clk: rockchip: rk3576: Use correct clock
 register for CLK_SARADC
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-24-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-24-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0192.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::49) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a86474-255d-46c8-fd3d-08df41afa9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gJbTOFg4lpqSQyhpAAIGdliQSm4SYIfup6YR0JQeLLznYCoMsGfHR+gm81e5LYPgDybGLp7lJjgAIyzY0nyxMnQKmKV3UT0k6TEIjvj1VzpsVFHoDz3g3LFI9QRGBOeU7HrQuA5bvINKn7s7N07xaVPSJokV+S4Cjc+ashhmDs/u9dNpdl2nID2fqlnHrh8winkLd4JpZ6vpOdC247VRus2hIhOnHUyUGNp1nMFqviY2oTKXvWgnD63s/luo8rXll8gWKVLEiZA+fVpA5We4NW1BxxOuNmqYKE5Y39dpPQe2FtXIqo/MAyfGF1Vi3Q+Pb9D/467t5MssvZG8cTkvrKA7jpcNGQVJlSE3CVvXD6Ywcc6fFhnJROwL0V9e9vboH7XpGfD0pHhcj5YLm7jLXsm4s1LZmHoPTqzAcvYGCtb0phYY97a837aSJg2vp8uKz3Rk/w4iW2EV1m46uVca55V7d5olWISrTL+Xcq/+FLE2Kjovc60OEeRo0oA+HhC59ijFJ5N3ZV8nfpAF1RR/Pq0/4iPrmQfaBfh+pQxJ05+AYFB5wdnYMoJiuj7ovTdDFK/Y+fqJh6ZJC+Z8uEGqWD54rsakDG8kRIry7HftJjxMqR+D09dhVdyF0oCxOWdaHG4DOXqjGdg4KG/OwknJRtRGus5+NVik0p1BrwqcMnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStXQTFRR0ZJcldWRFVpU2traC9Fem5oWk50N1BCZTNIYXJTNVNWZ3ZHZ1B5?=
 =?utf-8?B?b3MvQWV0ZlNjbnB4QTgwN2pzOUFyZUlPMkswQk9Bek1XNTNhN3RJTk1zcXRE?=
 =?utf-8?B?YmtQZW1QVjVJNzJZVXlybkR2bS9IcjlUYVM4Z0hxN3BYRWUvelBVdjVvY2lT?=
 =?utf-8?B?V0pMN0U3bzZiNW1HeXI1emFSY05zdjR0MitMUUVka29uL2kybUNCVDJ1djNG?=
 =?utf-8?B?dFpWZXZwNlBVK2ZZV01qUXo1Y05YaXp6ZUdNZlNDQ3JsU3JsQ1RqN0tqbXV1?=
 =?utf-8?B?MUdxS0Nxc20wMWltVmRaTUpqb0xKczI1MDJycldyUHBMUkppeTdnSUIrWHlF?=
 =?utf-8?B?YldwUjdScDNwaVVHdTQrR2prczNKdnZFdFk2MUdjY0FDZ3VhU3pWSkVudWgr?=
 =?utf-8?B?Q2NITVZ2WkUyU1lhM25hRjJySkk0WmNXOXE2dmQ3TWRqcUppVWxaTk1TL2Ur?=
 =?utf-8?B?STE3S2hvcHdhRG01MURiNUFhcFhqVGVaREVnSVdleEV2SHE1bmlEbXJQNWRF?=
 =?utf-8?B?ZitsT2NKamx4V0szTGFuQVZkQ1NFVkhWaHdLMjA5cjErT0t3SmNuRUN2VVJa?=
 =?utf-8?B?ZHpaUEEveStHanFOU3ZHTmwrQis4UFBkN09WMnFOSmFkajUrYS9MVTBIUnZX?=
 =?utf-8?B?RTh6ekNMUTBwMkFiOE84eHhqYmFNUENYT0t1T1pSWHFid28vZklkaEhqaU5w?=
 =?utf-8?B?TEVXUkxTTnpBWWlvamsrRFZOVzdIREZUc0FRZmZSckM5WWcyU3RqOWhmcy9W?=
 =?utf-8?B?Rzdyb0xzaEkzd2xhaWNLNUtDL2hLRVBXWU1sOEFUZHdKVFFqKzJtYVlSTmJM?=
 =?utf-8?B?RzRoM3Fidkh5K05nanozSzVmcEJiaEJWV0RlWUNmRFdlWW9VUFFJYXRFWGVC?=
 =?utf-8?B?eHdGMm1kWGxOUWlwNDFHNHEwZHRRTmNFbmpzcERGR0IrcTRyd2p4MDhPRDIz?=
 =?utf-8?B?Z3dwRGxOUUcvZnM1MVlOcnQrUThLOGVXTWQxSUNld2VoYzF1TEtHMFppTFpS?=
 =?utf-8?B?ZkJVbW5yaUhDZndTY0tzWDJ2QzVYdVFKYW5VSVlVTGZLTWw1aFQxVkRIS0FQ?=
 =?utf-8?B?cVM1TXFvajNKZ0JLWmtPWUVHT2h6U0c4b1YzOXl6cGNXUVRSUmhDTU5keERm?=
 =?utf-8?B?NzFObS9BRUU4ZnE3NEc5NWgzcnRlaDB1dVk5WFpLNDhDaXV5R2VIekNKMStj?=
 =?utf-8?B?eWNOOHVtSEs3eFFmT0RwZlhCMmVBODdhdmUwWDJrRm81dVM0U21Za0J6TzBG?=
 =?utf-8?B?dFVGdFJNL0YrZTFNVnNJeTZBUWFvcThadXJ3TCtXR082enRBMzQ4QUF0RFcv?=
 =?utf-8?B?VEV0ZllIcU0yOUFiWnhVYjFjdVRYbENLMHlZQmROSlE3Zk8rWTdRUmJkZFox?=
 =?utf-8?B?T3VGS0MvdWdsUnphNy83NUorVTQ3K0ErUFhqbzhiZnpXVWRWZlFhVFZTWDl1?=
 =?utf-8?B?ZVdsRzRITDZNME9scDNSd0JvazE2Z28yeGt0d2ZKYWZROUNrZ2h4SCtVU0tr?=
 =?utf-8?B?NEErUmhGbzFNL2NkLzlrVnJPK2lCcjg4a1g0WWVSbGtXSWpEUkpUcVRnVStF?=
 =?utf-8?B?clE0NnB1cUMvYWdVeERpWXlRdUZtL1hHTDlZeGFMRlZtSmpUeHlSWjg0Q01I?=
 =?utf-8?B?RWtOZ1YzSGdVRmx5Y2Njd3dMMERMM29EdjU5cTRXV2hJTUpZSi9zN1R5bnhz?=
 =?utf-8?B?M2EzZC82RHFCN25DaVlSTTNnQU94UnBoQXJNZXZkN3pvY3BXK2ZDMjFpRWNK?=
 =?utf-8?B?MFRxNkFxNkljdjRFUnZxVEZqbWlWWXRsZ3pIdmF1UjRIWTMzUTgvYy9NdEpR?=
 =?utf-8?B?akE5RFdnUTBLdWNxNC9DZi9VdS8yTjZpVlduZDBqN2RGdFpPMkpFenRRTlYr?=
 =?utf-8?B?czNud3pkZVlaYnQvamJsUFJyTG13aU1qODFPb1RoUytUYW02T29IUXlNK2R5?=
 =?utf-8?B?RkZzNWdBelg4RnExTHpIaE9zZXBBaGkrbnh5VGs5MGRnd1IzS1dTOWl6disw?=
 =?utf-8?B?aWk1SllPVlhOdjVZZm5haDM1RjIxQ2JlRGRjNTVFZEcwMnBZWWlSalpTVzQz?=
 =?utf-8?B?OGlvK1Q1WklRdjFxNERZR1ZGT1MvU0plY1Z3dm00Ukw2NjdwYXhlNitVa1ZH?=
 =?utf-8?B?SEVhVW8xR3FnMWhTS05GZzQ2djVBL1UrODdDY3ZFNjYwbytVMU9DOHR2V0RX?=
 =?utf-8?B?UHFUK1QrSmlReHExdVNMeGNIbjhBUzEzQWh1bmxxUEM2WHh0WGdpQStLTG5I?=
 =?utf-8?B?Q3FOK2pxYnRLV0I5dWFobjJQQjYzWFk3a2h2bllFSndCOG9UczljYlVMMWF0?=
 =?utf-8?B?bkNpVzZ6L1d6U0xTOFlsbkZQaVIxKzhDOS9CZldOamJkQm1FL2xodz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a86474-255d-46c8-fd3d-08df41afa9aa
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:58:03.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O7IMMPAht20NWi+yIDZa0K+352YckgtxTYdm7vZjhQuH3/af0VTcnM0RR2nDPe7JhzhX9UyJuEB4VdAId26CCKuw5vfbdc4gNnX0zPOSto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> Parent and divider fields for CLK_SARADC are located in CLKSEL_CON58 not
> in CLKSEL_CON59. Change to use correct CLKSEL_CON for the CLK_SARADC
> clock.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
