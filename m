Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9B606A33F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EvImkWJ7;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QX9lNUxQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DD2C60886;
	Tue, 17 Nov 2026 12:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAWHgN8YNOoj; Tue, 17 Nov 2026 12:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4736D60878
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794919985;
	b=elNz30tncl9gpuuhb8y27dafZvV4hh7m7t5aum3zmiNIBfI438zh+JC8A906AXtQt8M7
	 wbRF4For5BuvQ0rQj5+CR5Usbc8n39H86AsoO4m+IBjTmGzeLZbMJZqCAxExSg+rFW+HG
	 AlwYr+NofuhJDBIBtu8w/45BnyvLFzDrpMVKpv5aRVDwwyI98wzhpB+Sdiq9GI1N6zKwv
	 Fwo0EMCG/JbFXcqMk4SQQ+Yu+opKE50NwV1uFBwNdSOoTnKd6vac7H6lID1+Gjd9GJ9Qg
	 YlZ6IM7Qf3KFVac0BKTD6cxNLw8fYQhiT65oK/xQ3zxqXIkM11CWdOk+rsYu3K7bDsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794919985;
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
	bh=nc5xw65r+KhOVRmzQiNoZqVz3VexpHGRt2sYyPKl2Nw=;
	b=dts1SIeZ9lJrffcJ3dFzYPXZf+L69U9ztRhQUsifHrsRPRaHttCdgfd5x+HKyZmtx5vs
	 464kJlKxzkG83K4M7L+21wKfqNeoK9plguIeWZlhTCOTO9cQ3Bo5nrfiKQ8U13LlNMiPW
	 PaJerV7gJz4Cu9pm2b82URyhcF/nwNd6tdtVsnx02iLlNVrfGlsRESV5I9SotSXfRzajE
	 qcCKQ3JAOEXA7JB/S9v9Gt35BYm7KH76NJaTkyEA8RSVfMzZeRp+JEBK0l0J380t2iwVy
	 8UEjH8ukUtAlFHSDPN+F602Q4sRo35bOTd+FTMaFdcmYLj7f56OILWckliqbWo7F4JA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QX9lNUxQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794919985;
	bh=nc5xw65r+KhOVRmzQiNoZqVz3VexpHGRt2sYyPKl2Nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EvImkWJ73nvDbbnTBgMIGGjjtaRAJp3JY0g0nL2uoMUL6NGos5eIWFRWRMKuHNThA
	 OxuHp+NsUnAEO0YPX3Q/mdghnyOPc7Jvs8RVtC1UyNEZCRT41gLNuDcThDGhxmHYfU
	 tf4huWvK6dUlpvWybmtBDzONGfOrmxyM239Ho7Fg61f66KgL6ABzJJNX3m+ITCJtft
	 WOGPX0d8rKWdAnpM10jv2lDgpilQEaqjgcJCfFyeYiX4/WkH19wXjPeKsVttcoar7r
	 vNuBTHjZXfVAVEZgbgTHn+PJBrtOc8rDvLKwUlujBgUDuXg7UyobYQncJpmJIxOpLW
	 YlinqZdhjqRsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4736D60878;
	Tue, 17 Nov 2026 12:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EA5105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57ACB60878
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UkJCQMdkN39r for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5346960873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QX9lNUxQ
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5346960873
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc5xw65r+KhOVRmzQiNoZqVz3VexpHGRt2sYyPKl2Nw=;
 b=QX9lNUxQLYvnEwZHiusDTaA7cDCxQU4KRqxpZyJXuWAUGd//bfh7a+ryvpYZA/aszrE8ElbqknPlgJHhUZqWNG7VPhWgE12+oSGDw2XgdP9b3WJR3IBhE6TDwElo2Fy9CA9VAhd5GgFezmVOa6V+Lbn16ZT880fwMHNQLJimhP4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 12:52:54 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 12:52:54 +0000
Message-ID: <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
Date: Tue, 17 Nov 2026 13:52:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: David Lechner <dlechner@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
 <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 373da545-4f6a-4ac8-e419-08df44a9b20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|261026121527099003|22082099003|18002099003|6133799003|3023799007|4133799003|13003099007|4143699003|261026130827099003|261026135527099003|11063799006|10067099003|261021133027099003|56012099006|261026140227099003|261102124527099003|261028144727099003|261021135927099003|261102123227099003|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261022115727099003|261021123027099003|261009221227099003|261021130227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HqK5Ll9SEcITsARsyz1pYOJcK6Wt4p1dRK0hUlXs6hOsPdxdn2uumCtYUz5fK8ELz34HlO+kCE87I/9R0AYocxwnpqDa4BNV4fwIOvSjSxWtTdYgliyX/JJ3nEwN/vskaO5pFKGP8ReolIKv+Ai2JgETviKfI+o5+KZgk8VM/SD4Kkr7dlqfVVGohU5VHsFAPm1Eya2FgthEVWh5YVSG6AkJ9g9zWtlISDrC/NEfDfjFyPrTZlgOmIsIW+46GgRP+t0rGW4q5c6hFBvNW9xQFhXKffkqKNeveP5wzkmkho+q9AotaT6YojMHktMVq4RQNdWSCKCJstC9IxDH6pw8JNj0G4ixlj3Ex7+y6SI2sE8zw916wew5gqDtAlEbCwI03j1ulhpX+OdxCMHy1+Jse2ybSF9wVzo5S4YtMQNqvN3UYTnmlS+xnIpg71kHGfFGJiPq0fhkszCtO+xMkQP9NqBjOnhx1jqxds20E8U3NU8l7/W7H+5nWC/eYma3h+RJPz1LKryWQCFhR/EaEwBFginAeJ/Smgu+UYCTJ+oeEsp3Mjgvh8ODOuA5s7vbhsS7kxYda6rzJ4P4zNEePDFzejXOuLgNEf4J1+4yTWh75vrgRwPBaTlKsuAmy2sLH5Vl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(261026121527099003)(22082099003)(18002099003)(6133799003)(3023799007)(4133799003)(13003099007)(4143699003)(261026130827099003)(261026135527099003)(11063799006)(10067099003)(261021133027099003)(56012099006)(261026140227099003)(261102124527099003)(261028144727099003)(261021135927099003)(261102123227099003)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261022115727099003)(261021123027099003)(261009221227099003)(261021130227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pNYytqUm04QXgwdExzRTBtcWxzSHZBY0QwWENUbkRTUDgwVEZheWx2ZDlh?=
 =?utf-8?B?bVBHTnZpaGRHeXNYWlgyQkZCNkhSRGZ4STlacDZ1OVBQVmphN0wzc1IzYU1H?=
 =?utf-8?B?SWZGTW5yNklITmd4UFppdDlIaWxCYzA1cmZqalR4U0phQnloZ01GQUkxcDBD?=
 =?utf-8?B?YktIbUlyK2NkNnFjMlk2UTdxSGNRMC80V2FkMVY3ZDl5OFE5U3JyKzlNcFJH?=
 =?utf-8?B?eEJLeEpaR2ZuQ05CdWl1RitCUjc1OUlUc2FMRnJlS2VIbS93MTNuc1JBak5T?=
 =?utf-8?B?d3FydUdHWVpGb2xVbHNBT29uTkhWRm8vaysybXdIUFV1dUFERno1VTRJU0xw?=
 =?utf-8?B?SmlTRWtRRlpBaUZvK2Yrb1hyOC9HOU5sYU13b3JQenRQL0VqQXNZVFloTTV1?=
 =?utf-8?B?cUI1M09WL1ZnU0lNZmhCZ2NiUEVyZ2w1azVxVldSYUdJR0lJelQxTTBocEVQ?=
 =?utf-8?B?d2NLZk5jTkM3T1pKcTd1SWJkd1RlYnpIdmVsQjlrU1FqNWN0dGl5ZUNseUs3?=
 =?utf-8?B?NzVORm05KzhJTWNQZmxjWDZMeDcrQmlJa29aS1VHNzlyRmJPOU1KZ0ZQZE9J?=
 =?utf-8?B?ekpqUHZGcXhnandoVE1mV2IwZ2Rld2ZyMjdUQnFwL2drWFNVY1VxUGtMTkJL?=
 =?utf-8?B?bFNVY3ROMktRcno5Q2dPVlUzanFRcHlIWGFEVGtBb3Y4UjNZNkN1a1hwbTh0?=
 =?utf-8?B?eUdEUVR2djlkbGlpcm8yT3J1eFU0cHp1cjBtTnhEZGFZS2Fsa2pyd1ZGbFVQ?=
 =?utf-8?B?UTl6eUF1SWpOLzgreHJvaUxuQTlmb21kRTRHZnBVUHRiNVRpNnN3WFRVc2pX?=
 =?utf-8?B?bmVRZUhMcnQxM2FBV0JuQ3c2cEtvVnBxak9mZEtmYWRlZmZnbTNaSDBZNktT?=
 =?utf-8?B?a3dTa2dScURjN1FWUzZRVWQxZjI2Zmh1YjlsQTk5UUJ4UU5rSFZYSFdyUmIx?=
 =?utf-8?B?czNUdG5xSHY1R0ZJNWVmMXJTWUxZbHpJcHJwenZwclppdW5QZ1prdWVYNjRh?=
 =?utf-8?B?NzR3NkZHZ3FmUTNYVFpwNlc2eGJIaVlwajBYY3Q2S0tlZm56Unh5S0pvT2E4?=
 =?utf-8?B?THFpNmpxUXhyTzd1eXJtalkxdUU1elg0YWhUUkpvaXpVQWxFTm5QMW0zZGpD?=
 =?utf-8?B?RE5RZlo0OUpaQkhaTUlmS2lOM3dEWUxPTTRKSmNGWnFYd2tXcWl3UTJScTgw?=
 =?utf-8?B?TXI1SnFTaDM4b2V1VVRSdUsxalZaMHEvc2hoQ3lVWFZtQXNRR1poU1JOUEJx?=
 =?utf-8?B?ekxJN2JqTDUrMnZJdERwcGVDTDMvdVRxV25LU2cvSlFRWTVWZVkrUG5uT3NN?=
 =?utf-8?B?Q1Z6cG5TV3VtZUVsalBGQWV2ZUU1Ri9HN0JlTUJwdVpoVTI4UHAyYzNLZm8r?=
 =?utf-8?B?aVRuSklENXE4aUpHMkx3dkhTQXVrblZhTkswOVE2SHd4L3R6TStTV2I1Qklk?=
 =?utf-8?B?d1ZLcThrczdONVczY0dYTHJSenAyYlg0Z0xER2J5NFlBZnJYMDF4V3IzY3hx?=
 =?utf-8?B?WUVhTHdwdmlESHZVYlhDWEtiV2pmZ21sSWJMNGtXUlBzYnp4cHZzcHNQYUd4?=
 =?utf-8?B?Y21UZzZHM25VdVJqME5UbXArbDBHUmpYMCtFNHR2RW5xM0JreUE3bVQrTTZQ?=
 =?utf-8?B?VmN1Mzhma2FvZG9JWkdNV2tsZ3BYNE5LeFlsbnNORDdjYWtDU24rL0FTMnla?=
 =?utf-8?B?Z0FtVUNqVUdJSFRNOWlnZmpBSEJNZlZKdEpoTTdPT09hNHRIcERCMzNuZTVS?=
 =?utf-8?B?NXFycTlNVGlJaVQ1MXNyWEk2S0FPUWdKNXo0SnloM2IyeFBLbmRtL3VkODNI?=
 =?utf-8?B?MXh1YjBaNUY2L1E2NEpwZW1iODA4UlpmMGU2MUVHSk14cFBPYWJxbG44YytD?=
 =?utf-8?B?bmFrYTREY3pOODZzbXNmNjJTSUxJMUdQVE44UzNpUWxLUG0wQUpySW9ZQm4r?=
 =?utf-8?B?cHQvbEh2WkNkeDIwTHRhWkJkNVVPZEhDWHo0Z2Mva2JLQ240V3FiVFVtOWdH?=
 =?utf-8?B?aktrUW5GQXVTRHdZWG1GUkZmd2dhKzYwRjRnNklIT003ajVxMzZuTlVVdFFE?=
 =?utf-8?B?YWd0QnFpNWJuQ3VTMmJlZitkRzlmNWV4TjZLQ01WRUNmUUZqOXZQUFpBR2Zr?=
 =?utf-8?B?MGNnSzU2aVN5MnJmQXYzTnRJNlZCTlEzaXBlaXNMNjgydGxHV0gzSkRrUUlp?=
 =?utf-8?B?UjNteUxoSDRReFRiR3lUeVNxOHk4L05HKzUwdDA4ZExMdUhCbDBLS3ZxTGtN?=
 =?utf-8?B?MjRTaFFZbjE3dWk4SVdkb2xaandEWGlLNlpySEpYV2pobDBiaTZNT2JRblF1?=
 =?utf-8?B?QXJJd09Vd29OV0gvOC9PQ2N1cEZ0N1FnejErVUVOWEVQSk9nQ0R0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 373da545-4f6a-4ac8-e419-08df44a9b20a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:52:53.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgpRoG/NLTytmglfjuLJcnmpZAZ0tCa3UJVIBZUiTvuY8Lcmh0PEE1rewSgaROZzct8SdcfmLk/RqjrNT3h6uHBqdsMtUlU+UhrU+8Kb0yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGF2aWQsDQoNCk9uIDExLzE2LzI2IDk6NDIgUE0sIERhdmlkIExlY2huZXIgd3JvdGU6DQo+
IE9uIDExLzE2LzI2IDEyOjQ1IFBNLCBRdWVudGluIFNjaHVseiB3cm90ZToNCj4+IEhpIERhdmlk
LA0KPj4NCj4+IE9uIDExLzE2LzI2IDY6MTcgUE0sIERhdmlkIExlY2huZXIgd3JvdGU6DQo+Pj4g
T24gMTEvMTQvMjYgMzoxNiBBTSwgUGV0ZXIgUm9iaW5zb24gd3JvdGU6DQo+Pj4+IEhpIERhdmlk
LA0KPj4+Pg0KPj4+PiAgwqDCoMKgwqAgPiBBbnlvbmUgd2hvIGhhcyB3b3JrZWQgb24gaGFyZHdh
cmUgdGhhdCB1c2VzIGEgZGV2aWNldHJlZSBmb3IgdGhlDQo+Pj4+ICDCoMKgwqDCoCA+IGhhcmR3
YXJlIGRlc2NyaXB0aW9uIHNob3VsZCBrbm93IHRoZSBtYW50cmEgInRoZSBkZXZpY2V0cmVlIGRl
c2NyaWJlcw0KPj4+PiAgwqDCoMKgwqAgPiB0aGUgaGFyZHdhcmUsIG5vdCB0aGUgY29uZmlndXJh
dGlvbiINCj4+Pj4NCj4+Pj4NCj4+Pj4gVGhhbmsgeW91IGZvciB0aGlzLCBJIG5ldmVyIGFncmVl
ZCB3aXRoIGRlc2NyaWJpbmcgdGhlc2UgaW4gdGhlIERUIGF0IGFsbC4NCj4+DQo+PiBXZSBwcm9i
YWJseSBzaG91bGQgZG8gc29tZSBkaWdnaW5nIG9uIHRoZSBtYWlsaW5nIGxpc3QgYmVjYXVzZSBJ
IGJlbGlldmUgdGhpcyB3YXMgYnJvdWdodCB1cCBiYWNrIHRoZW4uIEkgYWxzbyBkaXNhZ3JlZSAo
bWFpbmx5IGJlY2F1c2UgdGhlIExpbnV4IGtlcm5lbCB3aWxsIG5ldmVyIGFncmVlIHRvIHRoaXMg
aW4gdXBzdHJlYW0gRFQsIHNvIHRoaXMgcHJldmVudHMgdXMgZnJvbSB0aGUgZHJlYW0gb2YgcnVu
bmluZyBwcmlzdGluZSBEVCBmcm9tIHVwc3RyZWFtKS4gSSB2YWd1ZWx5IHJlY2FsbCB0aGVyZSBh
cmUgYSBmZXcgdGhpbmdzIHRoYXQgYXJlIGJpbm1hbi1zcGVjaWZpYyBhbmQgYXZhaWxhYmxlIGF0
IHJ1bnRpbWUgYnkgcGFyc2luZyBzb21lIHN0dWZmLiBJdCdzIHZlcnkgdmFndWUsIGJlY2F1c2Ug
SSBkb24ndCByZW1lbWJlci4gQnV0IEkgd291bGRuJ3QgZGlzbWlzcyBiaW5tYW4gdXNlIG9mIHRo
ZSBEVCBhcyBzaW1wbHkgYmVpbmcgYSBjb25maWd1cmF0aW9uIGZvcm1hdCwgSSBiZWxpZXZlIHdl
IHVzZSBzb21lIG9mIGl0cyB0aGluZ3MgYXQgcnVudGltZSB0b28uDQo+IA0KPiBUaGUgdHdvIHVz
ZXJzIG9mIGJpbm1hbiBub2RlcyBhdCBydW50aW1lIHRoYXQgSSBmb3VuZCBhcmUgbGliL2Jpbm1h
bi5jIHdoaWNoDQo+IGlzIG9ubHkgdXNlZCBieSB4ODYgQUZBSUNUIGFuZCBib2FyZC9CdVIvenlu
cS9jb21tb24vYm9hcmQuYyAodG8gbG9jYXRlIHRoZQ0KPiBGUEdBIGJpdHN0cmVhbSkuDQo+IA0K
DQpNYXliZSBpdCdzIHdvcnRoIGNoZWNraW5nIHdpdGggdGhlIGJvYXJkIG1haW50YWluZXJzIGlm
IHdlIGNhbiBnbyBmb3IgDQphbm90aGVyIG1lY2hhbmlzbSBzbyB3ZSBjYW4gc3Vuc2V0IGJpbm1h
biBub2RlcyBpbiBVLUJvb3QgRkRUIGVudGlyZWx5Pw0KDQo+Pg0KPj4gRURJVDogYWggSSBzZWUg
bm93IHJlYWRpbmcgcGF0Y2ggNi8xMCB0aGF0IHlvdSdyZSBhd2FyZSBvZiB0aGF0LiBCdXQgcGhl
dywgaXMgaXQgcmVhbGx5IHdvcnRoIGl0IHRvIGRvIHRoaXMgaW5jb21wbGV0ZSBzcGxpdD8gSSBm
ZWFyIHdlJ2xsIHNwbGl0IHRoZSBlY29zeXN0ZW0gb25jZSBtb3JlLg0KPiANCj4gV2hpY2ggInNw
bGl0IiBhcmUgeW91IHJlZmVycmluZyB0bz8gRmlsZSBmb3JtYXQsIGZpbGUgbG9jYXRpb24sIHNv
bWV0aGluZyBlbHNlPw0KPiANCg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGZldyBib2FyZHMg
d2lsbCBuZWVkIGJpbm1hbiBpbiB0aGUgVS1Cb290IA0KY29udHJvbCBGRFQsIGR1ZSB0byBuZWVk
aW5nIGFjY2VzcyB0byBiaW5tYW4gbm9kZXMgYXQgcnVudGltZS4gTW9zdCANCndvbid0LCBidXQg
dGhlIGZhY3Qgd2UgY2Fubm90IGZ1bGx5IG1pZ3JhdGUgbWVhbnMgd2UgbmVlZCB0byBzdXBwb3J0
IA0KYm90aCBmb3JldmVyLCBhbmQgdGhlbiB3ZSBpbmNyZWFzZSBjb21wbGV4aXR5IGZvciB3aGF0
IGJlbmVmaXQ/IEZvciB0aGUgDQpzYWtlIG9mICJjb3JyZWN0bmVzcyI/DQoNCj4+DQo+Pj4+ICAg
DQo+Pj4+ICDCoMKgwqDCoCA+IEJpbm1hbiBpcyBkZXNjcmliaW5nIGNvbmZpZ3VyYXRpb24gYW5k
IG5vdCB0aGUgaGFyZHdhcmUgaXRzZWxmLA0KPj4+PiAgwqDCoMKgwqAgPiB0aGVyZWZvcmUgaXQg
ZG9lc24ndCBiZWxvbmcgaW4gdGhlIGNvbnRyb2wgZGV2aWNldHJlZSB0aGF0IGRlc2NyaWJlcw0K
Pj4+PiAgwqDCoMKgwqAgPiB0aGUgaGFyZHdhcmUuIFNvIHdlIHByb3Bvc2UgZW5jb3VyYWdpbmcg
dGhlIHNlcGFyYXRpb24gb2YgdGhlc2UgdHdvDQo+Pj4+ICDCoMKgwqDCoCA+IGRlc2NyaXB0aW9u
cyBpbnRvIHNlcGFyYXRlIGRldmljZXRyZWUgZmlsZXMuIEluIG1vc3QgY2FzZXMsIGJpbm1hbg0K
Pj4+PiAgwqDCoMKgwqAgPiBpbmZvIGlzIG5vdCBuZWVkZWQgYXQgcnVudGltZSBhbnl3YXksIHNv
IGNvbWJpbmluZyBpdCB3aXRoIHRoZSBjb250cm9sDQo+Pj4+ICDCoMKgwqDCoCA+IGRldmljZXRy
ZWUgaXMgdW5uZWNlc3NhcnksIHRha2VzIHVwIHNwYWNlLCBhbmQgY2F1c2VzIERUUyB2YWxpZGF0
aW9uDQo+Pj4+ICDCoMKgwqDCoCA+IHRvIGZhaWwgYmVjYXVzZSBiaW5tYW4gaXMgbm90IHBhcnQg
b2YgYW55IHN0YW5kYXJkIGRldmljZXRyZWUgc2NoZW1hLg0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGlz
IGlzIGdyZWF0LCBhbmQgSSBsb29rIGZvcndhcmQgdG8gdGhpcyBsYW5kaW5nLg0KPj4+Pg0KPj4+
PiBGb3J3YXJkIGxvb2tpbmcgYW5kIGp1c3QgYSBsaXR0bGUgdGhpbmtpbmcgb3V0IGxvdWQgaGVy
ZSwgZm9yd2FyZCBsb29raW5nIGlzIHRoZSBkZXZpY2UgdHJlZSBmb3JtYXQgdGhlIG1vc3Qgc3Ry
YWlnaHQgZm9yd2FyZCB3YXkgdG8gZGVzY3JpYmUgdGhlIHJlcXVpcmVtZW50cyBmb3IgdGhpcz8g
SSB3b25kZXIgd2hldGhlciBzb21ldGhpbmcgbGlrZSB0b21sIG9yIGV2ZW4gdGhlIGluIHRyZWUg
ZW52IGZvcm1hdCBbMV0gbWlnaHQgYmUgYmV0dGVyIHN1aXRlZD8NCj4+Pg0KPj4+IEkgd2FzIGhh
dmluZyB0aGVzZSBzYW1lIHRob3VnaHRzLiBBbmQgaWYgd2Ugd2VyZSBzdGFydGluZyBmcm9tIHNj
cmF0Y2gsIHllcw0KPj4+IEkgd291bGQgaGF2ZSBhZHZvY2F0ZWQgZm9yIGEgZGlmZmVyZW50IHNv
dXJjZSBmaWxlIGZvcm1hdCBhcyB3ZWxsLiBDaGFuZ2luZw0KPj4+IGl0IG5vdyB0aG91Z2ggd291
bGQgYmUgcXVpdGUgZGlzcnVwdGl2ZSB0byB0aG9zZSBkZXBlbmRpbmcgb24gaXQuIEkgdGhpbmsg
d2UNCj4+PiB3b3VsZCBuZWVkIHNvbWUgbW90aXZhdGlvbiBtb3JlIHRoYW4gImRldmljZXRyZWUg
aXMgbm90IHRoZSBiZXN0IGNob2ljZSIgdG8NCj4+PiBqdXN0aWZ5IGNoYW5naW5nIGl0IGF0IHRo
aXMgcG9pbnQuIEFuZCBldmVuIHRoZW4gdGhlIGRldmljZXRyZWUgZm9ybWF0IHdvdWxkDQo+Pj4g
bmVlZCBhIGxvbmcgcGhhc2Utb3V0IHBlcmlvZCB0byBnaXZlIHBlb3BsZSB0aW1lIHRvIGFkYXB0
Lg0KPj4+DQo+Pg0KPj4gWW91IGNhbiBhbHdheXMgaGF2ZSBhIGNvbnZlcnNpb24gdG9vbCBmcm9t
IERUIHRvIHdoYXRldmVyIGZvcm1hdCB5b3Ugd2FudCBhcyBhIHdheSBvdXQuDQo+Pg0KPj4+IEF0
IHRoZSB2ZXJ5IGxlYXN0IHRob3VnaCwgaXQgY291bGQgYmUgbmljZSB0byBldmVudHVhbGx5IG1v
dmUgdGhlIGJpbm1hbiBkdHMNCj4+PiBzb3VyY2UgZmlsZXMgb3V0IG9mIHRoZSBhcmNoIGR0cyBm
b2xkZXJzIHRvIG1ha2UgdGhlIHNlcGFyYXRpb24gbW9yZSBjbGVhci4NCj4+Pg0KPj4NCj4+IEkg
bG9hdGhlIG1hZ2ljIHN0dWZmIGFuZCBpdCdzIGFscmVhZHkgY29uZnVzaW5nIHRoYXQgLXUtYm9v
dC5kdHNpIGZpbGVzIGFyZSBhdXRvbWF0aWNhbGx5IGFkZGVkIGJhc2VkIG9uIHNvbWUgcGF0dGVy
bnMgKHRoYXQgbW9zdCBwZW9wbGUgYXJlIHVuYXdhcmUgb2YsIGhlbmNlIHRoZSBidW5jaCBvZiAt
dS1ib290LmR0c2kgZmlsZXMgdGhhdCBvbmx5IGluY2x1ZGUgYW5vdGhlciAtdS1ib290LmR0c2kg
ZmlsZSkuIFNvLCBmcm9tIHlldCBhbm90aGVyIGxvY2F0aW9uPyBEb24ndCBrbm93IGlmIGl0J3Mg
YSBjbGVhciB3aW4gZm9yIHVzZXIgZXhwZXJpZW5jZS4NCj4+DQo+Pj4+DQo+Pj4+IFRvIGJlIGFi
c29sdXRlbHkgY2xlYXIgaGVyZSwgSSB0aGluayB0aGlzIHNlcmllcyBzaG91bGQgcHJvY2VlZCBh
bmQgSSdtIG5vdCBuZWNlc3NhcmlseSBhc2tpbmcgeW91IHRvIGRvIGl0LCBtb3JlIGp1c3QgZ2F0
aGVyaW5nIGlkZWFzL29waW5pb25zLg0KPj4+Pg0KPj4+PiBQZXRlcg0KPj4+Pg0KPj4+PiBbMV3C
oGh0dHBzOi8vZ2l0LnUtYm9vdC1wcm9qZWN0Lm9yZy91LWJvb3QvdS1ib290Ly0vYmxvYi9tYWlu
L2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuZW52P3JlZl90eXBlPWhlYWRzIDxodHRwczovL2dp
dC51LWJvb3QtcHJvamVjdC5vcmcvdS1ib290L3UtYm9vdC8tL2Jsb2IvbWFpbi9ib2FyZC9yYXNw
YmVycnlwaS9ycGkvcnBpLmVudj9yZWZfdHlwZT1oZWFkcz4NCj4+Pj4gICANCj4+Pj4gIMKgwqDC
oMKgID4gQ3VycmVudGx5LCBvbmx5IFhpbGlueCBpcyBkb2luZyB0aGlzIGtpbmQgb2Ygc2VwYXJh
dGlvbi4gVGhpcyBzZXJpZXMNCj4+Pj4gIMKgwqDCoMKgID4gbWFrZXMgaXQgcG9zc2libGUgZm9y
IG1vcmUgcGxhdGZvcm1zIHRvIGFkb3B0IHRoaXMgc2VwYXJhdGlvbi4gVGhlIGZpcnN0DQo+Pj4+
ICDCoMKgwqDCoCA+IHBhdGNoZXMgZml4IGJpbm1hbiBzbyB0aGF0IHRoZSBpbWFnZSBnZXRzIHRo
ZSBVLUJvb3QgY29udHJvbCBkZXZpY2V0cmVlDQo+Pj4+ICDCoMKgwqDCoCA+IHJhdGhlciB0aGFu
IHRoZSBiaW5tYW4gb25lIHdoZW4gdGhlIHR3byBhcmUgc2VwYXJhdGUgYmluYXJpZXMuIEFuZCB0
aGV5DQo+Pj4+ICDCoMKgwqDCoCA+IG1ha2UgQklOTUFOX0RUQiB3b3JrIHdpdGggT0ZfVVBTVFJF
QU0sIGFuZCBkb2N1bWVudCB0aGUgcmVjb21tZW5kYXRpb24uDQo+Pj4+ICDCoMKgwqDCoCA+IFRo
ZSByZW1haW5pbmcgcGF0Y2hlcyB1cGRhdGUgdGhlIE1lZGlhVGVrIEdlbmlvIHRhcmdldHMgdG8g
bWFrZSB1c2Ugb2YNCj4+Pj4gIMKgwqDCoMKgID4gYWxsIG9mIHRoaXMuDQo+Pj4+ICDCoMKgwqDC
oCA+DQo+Pj4+ICDCoMKgwqDCoCA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbSA8bWFpbHRvOmRsZWNobmVyQGJheWxpYnJlLmNvbT4+DQo+Pj4+DQo+
Pj4+ICDCoMKgwqDCoCBNeSBtb3JlIGRpcmVjdCBjb25jZXJuIHdpdGggdGhpcyBzZXJpZXMgaXMs
IHdobyBoYXMgc29tZSByZXZpZXcgY3ljbGVzDQo+Pj4+ICDCoMKgwqDCoCB0byBzdGVwIHVwIGFu
ZCBjby1tYWludGFpbiB0aGlzIHRvb2w/IEl0J3MgYWxyZWFkeSBiZWVuIHByaXZhdGVseQ0KPj4+
PiAgwqDCoMKgwqAgc3VnZ2VzdGVkIHRvIG1lIHRoYXQgd2UgY291bGQgZHJvcCB0aGUgbG9mdHkg
Im9uZSB0b29sIGZvciBldmVyeSBwcm9qZWN0DQo+Pj4+ICDCoMKgwqDCoCB0byByZWx5IG9uIiBn
b2FsIHNpbmNlIG1vc3QgcHJvamVjdHMgY29udGludWVkIHRvIGRldmVsb3AgdGhlaXIgb3duIHRv
b2wNCj4+Pj4gIMKgwqDCoMKgIGZvciBhc3NlbWJsaW5nIGJpbmFyaWVzIGFueWhvdy4gQW5kIHRo
YXQgaW4gdHVybiByZWR1Y2VzIHRoZSBzY29wZS4gQnV0DQo+Pj4+ICDCoMKgwqDCoCBpdCdzIHN0
aWxsIGFuIGltcG9ydGFudCBwYXJ0IG9mIHRoZSBwcm9qZWN0IGFuZCBzbyBuZWVkcyBzb21lIHBl
b3BsZQ0KPj4+PiAgwqDCoMKgwqAgbG9va2luZyBhZnRlciBpdCB3aXRoIGEgbW9yZSBnbG9iYWwg
ZXllLg0KPj4+DQo+Pj4gSSBtaWdodCByZWdyZXQgdGhpcyBhcyBJIGFtIGFzIG92ZXJ3aGVsbWVk
IGFzIGFueW9uZSBlbHNlIHdpdGggcmV2aWV3cyB0aGVzZQ0KPj4+IGRheXMuIEFuZCB0aGlzIGlz
IG15IGZpcnN0IHRpbWUgdG91Y2hpbmcvdXNpbmcgdGhlIGJpbm1hbiBjb2RlIHNvIEkgZG9uJ3QN
Cj4+PiBrbm93IG11Y2ggYWJvdXQgaXQgeWV0LiBCdXQgaXQgc2VlbXMgbGlrZSB0aGlzIGlzIHJl
bGF0aXZlbHkgbG93IHZvbHVtZSBhbmQNCj4+PiBJIGtub3cgUHl0aG9uIHZlcnkgd2VsbCBhbmQg
dGhpcyBzZWVtcyBsaWtlIHB1cmUgc29mdHdhcmUgc28gSSBkb24ndCBuZWVkDQo+Pj4gYW55IHNw
ZWNpZmljIGhhcmR3YXJlIHRvIHZhbGlkYXRlIGl0LiBTbyBJIGNvdWxkIHRyeSB0byBoZWxwIGhl
cmUgZm9yIHRoZQ0KPj4+IHRpbWUgYmVpbmcuDQo+Pj4NCj4+PiBBcyBhIGZhaXIgd2FybmluZywg
SSBkbyB0ZW5kIHRvIHdhbnQgdG8gYmUgYSBiaXQgaGVhdnktaGFuZGVkIHdpdGggbXkgb3duDQo+
Pj4gY2hhbmdlcyB3aGVuIEkgYW0gdGhlIG1haW50YWluZXIuIFRoZSBjdXJyZW50IGJpbm1hbiBj
b2RlIGxvb2tzIHRvIG1lIGxpa2UNCj4+PiBKYXZhIHdyaXR0ZW4gaW4gUHl0aG9uIDIsIHdoaWNo
IEkgZmluZCBhIGJpdCBwYWluZnVsIHRvIHJlYWQuIEkgd291bGQgd2FudA0KPj4+IHRvICJjbGVh
biBpdCB1cCIgd2l0aCBtb2Rlcm4gYXV0b21hdGljIGNvZGUgZm9ybWF0dGVycyBhbmQgbGludGVy
cyBhcyB3ZWxsDQo+Pj4gYXMgYWRkIHR5cGUgaGludHMgdG8gbWFrZSBpdCBlYXNpZXIgZm9yIG1l
IHRvIHJlYWQgYW5kIHVuZGVyc3RhbmQgc28gdGhhdCBJDQo+Pj4gY291bGQgbWFpbnRhaW4gaXQg
d2l0aCBsZXNzIGVmZm9ydCBhbmQgYWxzbyB0byBmaW5kIGxhdGVudCBidWdzLg0KPj4+DQo+Pg0K
Pj4gUGxlYXNlIGJlIG1pbmRmdWwgb2YgdGhlIG1pbmltdW0gUHl0aG9uIHZlcnNpb24gd2Ugc2hv
dWxkIHN1cHBvcnQuIEkgdGhpbmsgd2Ugc3RpbGwgc3VwcG9ydCBPcGVuU1NMIDEueCBmb3IgZXhh
bXBsZSAoYWxzbyBieSB0aGUgZmFjdCB0aGF0IGl0J3MgdGhlIGludGVyZmFjZSB1c2VkIGJ5IExp
YnJlU1NMIEkgdGhpbms/KS4gSSBoYXZlIG5vIGNsdWUgd2hhdCB2ZXJzaW9uIG9mIFB5dGhvbiB3
ZSB3YW50IHRvIHN1cHBvcnQsIGJ1dCB3ZSdyZSB0eXBpY2FsbHkgc3VwcG9ydGluZyBzdHVmZiB3
ZWxsIHBhc3QgdGhlaXIgZW5kIG9mIHN1cHBvcnQgZGF0ZS4NCj4gDQo+IE9mIGNvdXJzZS4gSSBz
YXcgKGxpa2UgVG9tIGFscmVhZHkgcG9pbnRlZCBvdXQpIHRoYXQgMy43IHNlZW1zIHRvIGJlIHRo
ZQ0KPiBjdXJyZW50IG1pbmltdW0uDQo+IA0KPiBJIHdvdWxkIG5vdCBoYXZlIHRob3VnaCBhYm91
dCBTU0wgdmVyc2lvbnMsIHNvIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQuDQo+IA0KPj4N
Cj4+IFRoZSBjb2RlIGlzIGV4dHJlbWVseSBjb252b2x1dGVkLiBGb3J0dW5hdGVseSwgdGhlcmUn
cyBnb29kIHRlc3QgY292ZXJhZ2UsIHNvIGRvaW5nIGluY3JlbWVudGFsIGNoYW5nZXMgYW5kIHN0
aWxsIGhhdmluZyB0aGUgdmFyaW91cyB0ZXN0cyBwYXNzIHNob3VsZCBoZWxwIHJlZmFjdG9yaW5n
IHN0dWZmLg0KPj4NCj4+IFR5cGUgaGludHMgd2lsbCBiZSBhbiBpc3N1ZSBhcyB0aGVyZSBhcmUg
c29tZSAobm90YWJseSBsaXN0KSB0aGF0IHdlcmUgYWRkZWQgb25seSBpbiB2ZXJ5IHJlY2VudCB2
ZXJzaW9uIG9mIFB5dGhvbi4NCj4gDQo+IFRoZSB0eXBpbmdfZXh0ZW5zaW9ucyBwYWNrYWdlIGhl
bHBzIHdpdGggYmFja3BvcnRpbmcgbmV3IHR5cGluZyBmZWF0dXJlcyB0bw0KPiBvbGRlciBQeXRo
b24uIEFuZCB3aXRoIGBmcm9tIF9fZnV0dXJlX18gaW1wb3J0IGFubm90YXRpb25zYCBhIGxvdCBv
ZiBpdCBpc24ndA0KPiBldmFsdWF0ZWQgYXQgcnVudGltZSBhbnl3YXksIHNvIHNob3VsZG4ndCBi
cmVhayB0aGluZ3MgZWl0aGVyLg0KPiANCg0KSSdtIHRlbGxpbmcgeW91IGJlY2F1c2UgSSBoYWQg
aXNzdWVzIHdpdGggc2NyaXB0cyBpbiBCdWlsZHJvb3QgcmVxdWlyaW5nIA0KYSBuZXcgdmVyc2lv
biBvZiBQeXRob24gb25seSBiZWNhdXNlIG9mIHRoZSBsaXN0W10gdHlwZSBoaW50LCBjLmYuIA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnVpbGRyb290Lzg2MzZkYzI5LTE5ZDAtNDc5ZS1hNDhm
LWMwZjY3ZmI3YTNiZkBjaGVycnkuZGUvDQoNCkkgYnJpZWZseSBsb29rZWQgYSBmZXcgbW9udGhz
IGFnbywgYnV0IGNvdWxkbid0IGZpbmQgYW4gb2J2aW91cyB3YXkgdG8gDQptYWtlIHN1cmUgd2Ug
ZG9uJ3QgbWVyZ2UgY29kZSB0aGF0IGNhbm5vdCBydW4gb24gc29tZSB2ZXJzaW9ucyBvZiANClB5
dGhvbj8gQW4gb3B0aW9uIG9mIGNvdXJzZSBpcyB0byBoYXZlIG11bHRpcGxlIGNvbnRhaW5lcnMg
d2l0aCBtdWx0aXBsZSANCnZlcnNpb25zIG9mIFB5dGhvbiBhbmQgcnVuIHRoZSB0ZXN0IHN1aXRl
IGluIENJIHRvIHZhbGlkYXRlIGl0IHdvcmtzIG9uIA0KYWxsIGludGVuZGVkIHZlcnNpb24gb2Yg
UHl0aG9uIHdlIHdhbnQgdG8gc3VwcG9ydCwgYnV0IEkgd2FzIHdvbmRlcmluZyANCmlmIHRoZXJl
IHdhcyBzb21ldGhpbmcgbGVzcyBvZiBhIGhhbW1lci1hcHByb2FjaCB0aGFuIHRoYXQ/DQoNCj4+
DQo+PiBXaGF0IEkgd291bGQgbGlrZSB5b3UgKG9yIGFueW9uZSkgdGFraW5nIG92ZXIgQmlubWFu
IHRvIGRvIHdvdWxkIGJlIHRvIGFjdHVhbGx5IGRvY3VtZW50IGhvdyBiaW5tYW4gd29ya3MgaW50
ZXJuYWxseSwgbm90IG9ubHkgdGhlIHVzZXIgaW50ZXJmYWNlLiBJdCBjdXJyZW50bHkgdGFrZXMg
dG9vIGxvbmcgdG8gZXZlbiBrbm93IGhvdyB0byBzdGFydCBwYXRjaGluZyBCaW5tYW4sIHdoaWNo
IG1ha2VzIHBlb3BsZSB1bmFibGUgb3Igbm90IHdhbnRpbmcgdG8gZ2V0IGludm9sdmVkIHdpdGgg
QmlubWFuIGF0IGFsbCwgbGV0IGFsb25lIHJldmlldyBvciBtYWludGFpbiBpdC4gSSBmb3IgZXhh
bXBsZSBkaXNjb3ZlcmVkIHRoYXQgQmlubWFuIGdlbmVyYXRlcyBmb3VyIHRpbWVzIHRoZSBzYW1l
IGltYWdlLCBjLmYuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8wNGZkMDBmNC0xYmI2
LTRhMjktOGUxZS04M2NkYzFiMDNiNzRAY2hlcnJ5LmRlLyBhbmQgSSBjb3VsZG4ndCBmaWd1cmUg
b3V0IHF1aWNrbHkgd2h5IHNvLg0KPj4NCj4+PiBJIGFsc28gc2VlIHRoZXJlIGlzIGFuIGFjdGl2
ZSBmb3JrIG9mIGJpbm1hbiBhdCBbMV0uIFNvIEkgd291bGQgYmUgaW4gZmF2b3INCj4+PiBvZiBs
ZXR0aW5nIHRoYXQgYmUgdGhlIGFtYml0aW91cyBwcm9qZWN0IGFuZCB0cmltbWluZyBkb3duIHRo
ZSBpbi10cmVlIGNvZGUNCj4+PiB0byBvbmx5IHdoYXQgVS1Cb290IG5lZWRzLg0KPj4+DQo+Pj4g
WzFdOiBodHRwczovL2dpdGh1Yi5jb20vZGVpbmRlLWRldi9iaW5tYW4NCj4+Pg0KPj4NCj4+IEZZ
SSwgZGVpbmRlLWRldiBpcyBtYW5hZ2VkIGJ5IFNpbW9uLg0KPj4NCj4+IENoZWVycywNCj4+IFF1
ZW50aW4NCj4gDQoNCg==
