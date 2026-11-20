Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCCF606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cgwx7Y7+;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=eYW6zKXv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08728606F3;
	Fri, 20 Nov 2026 15:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9RqbhwF-SdK; Fri, 20 Nov 2026 15:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24A68606BE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795187407;
	b=FlwXGreHcXEVyIS873UGxwYBBA9feUwTjJb4SdgBlu+UIqer1Oy5PKZv5NLXxm5BZsD5
	 cbR9uGCZRTHx41puI02tU0Wg3wN6/TnbrDlIlKt6tyeaLx/XcS9FCFMjX6lhL5PewUxK7
	 YFUQtkkM+JRQAOIUmRadCXIhYpq1GipjlU5mr/Lm5MV0LdKqT6Nxea5Q3ClE63L59LaCe
	 cLt5W+jbHBJo7lDh3X1VrZHLofZbfvU4r1hb3m5YTOg5gBP0RMgJAu01vk5RKK/LGjukO
	 qgZ5RdEh+QE7MSeXfu+4DwRby2TPM0tH6cXeOZK3m3Leai5ty4kfmoQ1avCMARiabhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795187407;
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
	bh=eosZtWIEmPE3gCDelUBkzRCLiP+rthRS+m/2bZdJSIc=;
	b=oWEHNUYFF3YKG1J3swxgJ8mexZSeKugAApd3/TtMXiJpGIhiCrSQV6emd4ADc6ZuDAgZ
	 dlpil8C5VZDIVyO4CX1XgeXuECvQSYVSjLLwwkdZXOdxQZHXtt7/D9SNrIJbq9YRc1s5f
	 rt+7uDrPRHl5R/LFZy0fVnIx7u+XOUk2bTlmdwte9T25vFKHDEhhUZ/S0mY6jBl0RR+RV
	 0wiPMZ0LqbNB6xo2Hou1jlGRq1Mh23RQmfRpn3Y36hoICzdxI/r/qoaTjGVow6vCTnJgw
	 4kS4NxphfpS77eB6Ip+XitsVVXWDctKBlDuX/TzigFX01bTaX9Ne6l5DzLNaDLHVKUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795187407;
	bh=eosZtWIEmPE3gCDelUBkzRCLiP+rthRS+m/2bZdJSIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cgwx7Y7+lN+OCMPuei3Nypo3yfEH+jeo5SMPA6ckyTAc12Rd/Zo2kxVBzoFcXYX0+
	 yZe4Lsp3Zu2/IJg8Mhqr7xbhGu8qbj1SKFbaTfeAMCFaCOV1NF3EbFajztpIOi86vU
	 U9cgiIfu++0OIw/65P9MdEiSUxryGoldnwFcfWcB2jCa8iDh5ZL1AcaOiRZpGxp2pG
	 X4zsZCVTK9Cttka/g0+ja9V5H3nnc2v+r9vk5nSfXwPhVGdKa3p9UvvE1evdkW+Nv2
	 Rac/pYUolC4o2WlCardq4T9xkzWNARgoMpiL0Ylkyz6NghGyD31x7qF7tfLfvlGgR2
	 DcvtqjXqO4RsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A68606BE;
	Fri, 20 Nov 2026 15:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 823C0E52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 746CA40111
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meaDuDngoAGN for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 669BF4009C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eYW6zKXv
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 669BF4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eosZtWIEmPE3gCDelUBkzRCLiP+rthRS+m/2bZdJSIc=;
 b=eYW6zKXvWfGETkQIkvhNPd1Hi8dasA/VLuGTY+T/ZsC3fjwK9Qi0UZFE3+1O+ts4vP7NqzyhyJmNpEIutWLVoKZuvX+q3S6/zHArmbZYuvYIKL3u5YCr2WDu0ap9vvp0eDIdnq+xpubI9hbA/VDjMlz8+H4VsIrOgYeKY2AwDw4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU0PR04MB9634.eurprd04.prod.outlook.com (2603:10a6:10:31c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 15:09:55 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 15:09:55 +0000
Message-ID: <3c3a7458-54bf-4d38-bd4c-658c79d98d08@cherry.de>
Date: Fri, 20 Nov 2026 16:09:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] clk: rockchip: rk3399: add the clocks the DSI and
 VOP paths need
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>,
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
 <20261011-b4-pinephone-pro-defconfig-v2-2-6b7be35fbee7@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-2-6b7be35fbee7@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0056.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU0PR04MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: b471cf37-eb60-4476-6d95-08df4718558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261028144727099003|261026140227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: z5Ut4OqArzAEy7raGbxsTwsCvR0AWQmFpZfrFuj8bR/OQbYQc3n2e4R/DkYvnV4vCNBASug65TRjHJ4VYg79gzefwT6Jpn9XaSYThNItFXCySzrB95Ww8qZmm2gnRFGOWZ7UVq3MnOi9EG0JYKD4PaxqcbhpUWCfdbRw7V4GEfXF8fqCE+1iQMD0xqJIF3naAxiQowsBHPYNE7g776qNY0ifrfbI1jGMCBj+hMkxFdZHaOt7xVkRAxWA/esNcC8BLGnLdneMenYYybdeh36A7ZZ4Pa1ikgzwyMFCweCbHHAaSnFRsX7dq46datguntgZtqjihfhs1kYf2x0tKFsySVH7FrjWc7vZt0Y7o9gFrl4nzGlFMfUXB443hYh6QjSLz2uRz7YodkeimaOGtJQJSEcpU36BymECQInvnP13bIk5VE191d6TY2bubsx7mLarCrXGJLJd186kST1jWJHg7ttuXL6Ny9pmEodsbt1gpjk+ECaiUB+bAE+5RWZ8R7HMg7qPCXEtHua8ijE+c1cYuEU4myfgS9W0mzVXKNWimt1iOOO8eAX6EPzGfOMzDGThqQ04uS+RivVGhbnPHSRXIN7lskfcaVibujSz/uW2hX9aeTNNEHajWRvZm+rqkv4QenRbx8ltu19vQXsLnG8bjcv6BRc+BLUexEUYQOn32iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026140227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em9nYlJSaE1oZnFobzlEQzZoNlFpaUE2WHNHUUdtWlJHVFhLNklxSkE3U1o2?=
 =?utf-8?B?eCtTT0M0M3V6TklJUkVUYW45RzFKMllGRzJqN1Q0dWxuejYzdWVBamJxUjdH?=
 =?utf-8?B?dXNVTXp4a1dTdXZjU0hieURldFQ1eWY5bTIwVUVRZmR2NjBGY0ltcVJwZXN1?=
 =?utf-8?B?K3lnOFJIV1V0RXRxRW92RnRTVDAvMnZxVTcrU2hrYy9hNzRyOUhoU3RhSlZF?=
 =?utf-8?B?OVJrM2pKRnlkcHUrcCtSWGVSYVNCTTYxYVFGaFJsVjJ1WFB1eU03dmx4eXBp?=
 =?utf-8?B?SWdXS2p0OVRwbE0zaHZkeUpLTTNJU0pIUWlBN3JmRFRNQ2VHeEE5ZzdBdi9B?=
 =?utf-8?B?K0ZDSzZ2SDRrb2FpQnFDZzhScy9RajJuNW1meVBrYWk5SGFabzNmM3NDdXBP?=
 =?utf-8?B?ZXFaMTNhMWR3WHVxZU5pclpQUnhkejZ1WW1zalZlMEpGWU5pWVdGYnFscGtp?=
 =?utf-8?B?TDlvNnU5clVYSGU0TjUzWDlYOStrSUYrdXQ2dTVuenczbm9GN3J4MEoyZFhs?=
 =?utf-8?B?cGpzWVhyRW93NmM4cDZVdjNpL00zTkljK3k1ZmlNNFZUS2lQeWNaL3dIL3VW?=
 =?utf-8?B?WGNIZjNjMnZOUnRHQmFCUE5icWVWcEtiN1ZBOVVRcVJvY0FRd051U21ad0E3?=
 =?utf-8?B?V1A5ZjNuWVpybjVhWGliRklhVXNNU0RmYkIyN2xQUys0dWVxT013SC9XYW4v?=
 =?utf-8?B?R3VPNWRNNGZydklwZWlMSHRzSkpGanFCL1NYQmxEaUpJaVlIbXIwNmlhZ0No?=
 =?utf-8?B?ZWNSYlVXMUM3TzhRSnFzd0NyNTdCcWZYVGxvb2VDYk9DNkZjZG1aSTl6UzNt?=
 =?utf-8?B?b0lKOVJPdC9OTlZKNTdZL0xWWkwxbWxhNjdWNTBRNkVTbURqS2VFK1lSd0t1?=
 =?utf-8?B?WHFPYVNUaHZVTzBseHp6dS9JUmIzaDVzaUtCbXUvc2FwSmNGMUhlK2FaUVdF?=
 =?utf-8?B?REVKK1phSG92MnFXeG9zK3lOK240dmpmeTFKbk9aUEJEWExwanBLME1oc2kz?=
 =?utf-8?B?MzZiSmlJeXljTU5FdjVWcnpoMUN5M092cmZMalBQcXpMakwzWTVSUFpPaExE?=
 =?utf-8?B?Tkxqc2dSM1BFSnVoSHI4MVIzV1FiaGxjRWtYbHl6S1kxWDZreW5ua2p3Zisx?=
 =?utf-8?B?azlzMTJBVHZIWmVwZ2tpaDFYNmplVU81YmxOaUpkMWZGZHd2SDFxN1JmUm5W?=
 =?utf-8?B?R25aMCtMNVJNRzNaaFlNbzAvdXJjTmdZV1FGZEVPT1BlZG91UmRJZzB6OWhL?=
 =?utf-8?B?VDJMOEt1UE5pNXF6R1Y2UmNXaXMrcnpFK21RbDhvUDdHVzNnY3hIZTE2bnJW?=
 =?utf-8?B?U3hHa1pwS1o3ay9nMGMvL3Y0b1VIem1SeEhOWEhJeG1Ga2xqL1pxQzM0Y3Uz?=
 =?utf-8?B?RnVTQXhsZitFY0JzU1djc293WUhad0ZLUUJxNnFTNGp0djNwVjRQc2pMTklN?=
 =?utf-8?B?TmV6ajNuM081dU04WFgwZStWNkxPYUVzY3VBNDc2YTdrNWt3VmlvV3VaYzBa?=
 =?utf-8?B?SWdBL1h6SUZJNks4S0FBUWdRZndLbWljK1VySXJHSDUyVzlrSmVBd2dSNmJF?=
 =?utf-8?B?aHpZQ3JkZTZsYWdwd3RWenJ3Mk83VGNnYm45cDJQRkRTZ3ZNQkhKazFYTmls?=
 =?utf-8?B?bWtSMk4wYmN2cktTMWk4UXVJMzdmNDhaMUtlNy9NNlV5OTZ5QjVNU2FNVEhv?=
 =?utf-8?B?T20xMjh2OXNBVjVrdVp0ekNKakc4N090YStkTWdiV21MWUZxc3hnbnc0M0xQ?=
 =?utf-8?B?Mk5qYzVlbndkWWFIL1QvRXpiS1pucjkwSnV1UDdGa2c3TFdPYWJNL1ZUbHJ5?=
 =?utf-8?B?M1N5NVBJaWpmbzh5Um1tM1cvSVBKQlB4dWdzVUtGWlNIdG9zS2RDcnVGWjdu?=
 =?utf-8?B?bUNCRy9JMStNRzhoL3MxVmREbjVSYnhOUDJpaVpQOVBReHB1ZVc2eGpGWldB?=
 =?utf-8?B?bUkvbG1QM3Q0dHhPTi9MYU14cThhemh5NWxpK0VBNXNYdXlYZmRQeE8xTjk4?=
 =?utf-8?B?L3VENTVuYjluRHVNZk0xalBRbnJDZzlLcEF0YzFyb3BUV3VoZzh6aXlKQ0U2?=
 =?utf-8?B?SXhQdVJKa0ZCRWJzYmdWeDZ3Zkl2UnY3aC92SWFFL0ZxRHRwd2hCWEluUjhx?=
 =?utf-8?B?NFpNMHc1SFlKMzNnKzBqbUo1ZnprWnVKalp2OUFjS3VWWDc2Ujd2SGZLQ3Rz?=
 =?utf-8?B?cVhxSllsaUNFNHdVUG8zQlZuMHJQYW0yKzRnanBKZVZ3ZG5IelRzRzFPQ0Y5?=
 =?utf-8?B?cGVhZDI4VXpSM2p0TUN4cCtmT0lZcW9wVGh4TXdLQnhEblRFdThjdE5IZXk4?=
 =?utf-8?B?UzRHcUgwQURGRTdqOVgvdVcrdGd2STVaMHNXQkd2MGlTNXlMbjZ1Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b471cf37-eb60-4476-6d95-08df4718558b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:09:55.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bghgQCxVZ9wzGnTelKi6WricaC20aKq0SOarKcfK3+I+4rF5Ac37XcjzabQ21OuLRCHNHaoVTpk09wwBZ3wxtTfBfbo0MOR8lOuzsKaxQsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9634
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

Hi Petr,

On 10/11/26 9:35 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Handle SCLK_DPHY_PLL (fixed 24MHz), set_rate for ACLK_VOP0 and
> HCLK_VOP0. Add enable/disable for SCLK_DPHY_TX0_CFG and
> PCLK_VIO_GRF.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 6e87db18be0..0ddd1f20176 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -1001,6 +1001,8 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
>   	case PCLK_WDT:
>   		rate = rk3399_alive_get_clk(priv->cru);
>   		break;
> +	case SCLK_DPHY_PLL:
> +		return 24000000;

issue: please group with other hardcoded 24MHz clocks

Move along with SCLK_UART0/.../USB3OTG1_REF which returns OSC_HZ as 
that's 24MHz.

>   	default:
>   		log_debug("Unknown clock %lu\n", clk->id);
>   		return -ENOENT;
> @@ -1064,6 +1066,8 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
>   	case DCLK_VOP1:
>   		ret = rk3399_vop_set_clk(priv->cru, clk->id, rate);
>   		break;
> +	case ACLK_VOP0:
> +	case HCLK_VOP0:
>   	case ACLK_VOP1:
>   	case HCLK_VOP1:
>   	case HCLK_SD:
> @@ -1168,6 +1172,11 @@ static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
>   		return rk3399_gmac_set_parent(clk, parent);
>   	case SCLK_PCIEPHY_REF:
>   		return rk3399_pciephy_set_parent(clk, parent);
> +	case DCLK_VOP1_DIV:
> +	case DCLK_VOP0_DIV:
> +	case DCLK_VOP1:
> +	case DCLK_VOP0:
> +		return 0;

question: why not implementing the parent for them?

Especially weird since you then remove the assigned-clock-parents in a 
later patch, so this wouldn't even be needed or am I mistaken?

Cheers,
Quentin
