Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8B606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K6ZgsPKw;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=I0eN4o0G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E340740E0A;
	Fri, 13 Nov 2026 17:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ua_Hh7wMhMfb; Fri, 13 Nov 2026 17:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FA1B40E0E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592508;
	b=kU9IDvVLbPVf5IU3I+hjIHRf9StNwdyFFit532hBEibw5iRt7QXlGcwvpd3rytxL6BP2
	 q1l3OI9ulrLz3xB3sEa3soNpnH7zZGbBAZBhbZXir7n3326UDvUvIJPY87ONW4kgZwIgt
	 jP39LfAaX/3a8ZaJ6QZB0fi3vOyVDqEwstFI1f32LgX4h9ThHp7K3AAUiKtYzqFDgo/bG
	 I6/y3gbtJVRVUVUC+af/M610Mt1yRY1uPy0MXCfYQ47hcsUr28epfa3HhIvCuofPBtVvB
	 bUhnz2LOYAtzvBxCEwLWtEgTtfCMkdFEvXRNkYK29gT0sBJBTOkJ8DVziyUhIJr/Dkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592508;
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
	bh=51ghgyIlO6NrjesEBiSSxPol0qtjrdIzf5jIOo/LDbo=;
	b=WklpZTRdOMW/nH4ACp4s19c/9fm7jhcjFKlr+YJh/2p6sJQXFDgcV9pwjlE8KDnW0nkT
	 eM3+TW35MAsTKz6050RGgE9nmdYX/LfqKbaQIe+aEP6v3HKdSLrqKjqrLMkOjyJErRUyQ
	 VHHX/fVBbvUihjlsvXV7A2IsNCxDCcciRyCO3mXN31CfdMPBUYcPyMeLB0XqN8pKnCqNL
	 Bq0xk3fQhDJWTJODG96rLF2nlDmoelSLgApdkeXCm4UD+BZQjx/BOKEyTQl9LI/yWBxao
	 wWG6lEAXc38Yj2aX0VI6hHiL0AmVG/QoBdLAO40ELsal84JKLNKCOn1M4Zc17HaRTLQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592508;
	bh=51ghgyIlO6NrjesEBiSSxPol0qtjrdIzf5jIOo/LDbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6ZgsPKwiyr4W8rj21Jo6UWjAUjmBvIzK7RVffmyEXoEF372YZ9pAKFPCkBBU6aXk
	 sfYVVTIV+Iy3lZ3yRpxnrcPn+Wp0Wp+sXoOxGoXqQVAtIYg4dcpmN13dDzDGdY8m9d
	 6U+Af1KuIM6jMskDR/fVytZdmXkSRzncJlmYpXzdJt3rnOmbre9KRDM6FdkVa8uQtV
	 4v1KjIpzMDLO23aiGciHj+bKALPfNUWMay86SJ+jFsFlbg9tzsbQmqMJqSsUQJpxeT
	 DhK/UXAfg/mM9DNbP7eHFdE1ByKxswEBjWlWnO7Gmpyp4AnuK6at0ygPyxnVNyaw9J
	 f8sXbbYIq6QOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA1B40E0E;
	Fri, 13 Nov 2026 17:55:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43C71F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34BD860DA9
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1a-t3JtQC5H8 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:55:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C04160D6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=I0eN4o0G
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C04160D6E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51ghgyIlO6NrjesEBiSSxPol0qtjrdIzf5jIOo/LDbo=;
 b=I0eN4o0GzQnQ5sIhoaJ/c+6wTfHIMRsyG08qszBzxT+EUsozYDTOGkYhH06IKuANtdh93tVn3b9P0JP4Y5ey5V9E1vEjFg2GviWLEWKgFBYQYJZ/jcmD65XY6RJ07HZJim+0sdz1X//SeMbBKwye1WNE/6NdjnK7SzKSXRAilPE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:54:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:54:56 +0000
Message-ID: <7ef25628-be80-4a27-ba85-d1f8a6f37237@cherry.de>
Date: Fri, 13 Nov 2026 18:54:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/37] clk: rockchip: rk3576: Fix I2C rate selection
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-22-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-22-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 406d2fb5-aef4-4bcf-bee4-08df41af3a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HwYbLB95fJlbT2chbExzvN4D7XMQU3mSTYO0C8bOwqLZ53mPXiTCt05S9bS1UVvJy2DjQMNP8EexIAKpHkeD+U/cvo5tl4WEcF3qcjV762KB3x3IEkwtuPW7m4uPKXv0FM8fE2Nk/tgQg253ikAU4rtfdfdgq3u4JoVQXAVjCmYduNip3sBDJVTvFrsQ+3cTyjqMbpAapraZJCyHWOBNyUaP9rRdmyKlDv14cZCIpinPgjyf727ZwJTjXH8vkt7huMqsf+8UKl0mxAwC4y8Zpesu6siJ55DsGmOG4ms8ViZNuwwzxWwEBVmYxZYaWqxSJAxJm6N8xW0qjVILqN2lvxqpMgUpYTs3YP7AconWSu1aL0dXI+gzhqMZ6Y8Ks9oIuioYmurGM4mziWFGRzDqQOSDGIOvnT+34sCJBSz8D+OMcBCh0UH19qtzG23+DAWTdAP1V7PDoPldgY5TTLJ0EX4HVpHOv+SDKmxqns840ZTlmFk4J8QTS728h7sylIErY2mFW782fuG+cuT6WqLjiVxO0UO+IMG5djhmkyVeGAb8qN9QPwkEE+1NjEpJVTJaLR7Mg3FP8+xg3EykBadWqiKRBTPzIRXLjhffZn2Ubf2rzziW3xZ2gx/XWf6ZqRar3uAmBuzAoPzeUBkWJ59A24Uau+uBM1hCK9DIdRZ5ez4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRYTjFWaEJuY0tuREVhTVlQUlVOY1VYMm81WTlzazVmZlRXeFFaVWdMQkdK?=
 =?utf-8?B?OEJ3M1RIMS9icFFlc0NkOXpwcW1lMWxWcW5wRkJZU1RRaGJVMmw3VWttU1h2?=
 =?utf-8?B?OHJqMGFZUjIwazJtZVdld1cvSDZvYWsvYis0Tmp2dVZGTm5pZTd0bys1MnBM?=
 =?utf-8?B?L2wzSVRGNXB1cTVHSThDT0FGOFZKQmoxTHJ2eXgyb0dSTmNhZWVnUDRKbHFP?=
 =?utf-8?B?c0RDcjY2TmQ5UmUzN1F0UnhHZjdtSFZ4dm1BaTU0cnFtNFJiM0NQWnJJaWc1?=
 =?utf-8?B?em05SkwwdDkxYXU5ZHdFdnJncGU2U3hCemRBRnVGR1NGd3plait3VDI0QlRO?=
 =?utf-8?B?MjkwUHVhTzBjUVc1djdqMEtSUWZaME1UcjN1eEZqT0FzeHNneHZtNHFma3dt?=
 =?utf-8?B?TUduRFk4VHRTUVdabEhmejBCclY1c0lnRzRDTWFGMFlOaEo1Ky9SWndHYkth?=
 =?utf-8?B?dzRQN2lvcDJsOGF2TG9VTkM4MDZhS1BzQzFYQ0x2RkVPcnlMbnhxQVhHSmxP?=
 =?utf-8?B?U21ub3N6TFQ1dkk4KzNSSjB1SG1MNVkrUWk2RndWeEZwR3FsZVZkMnp5ZHRS?=
 =?utf-8?B?bk5vQjRLT25vUjQzZkNMeUVpbW1vWEhzTWowTWdEVjEvSWRpUHVGbTlMcndu?=
 =?utf-8?B?Q2NTOUErNDRianB3ZzJxVlEvUjYrQ09ZZGIwOThRQ1lyVkpUeUdRYmwyY3NN?=
 =?utf-8?B?R1hpeGxhbDNVWTZaeDdpQU92RDl4dVlzai9icWo5elRlTGs0QTNsRi85RlVl?=
 =?utf-8?B?bytYdUY4Nk9ORUVjNzdoL3BrakduVXJhLyt5Y2Y3c1RjS0dOUWZ5K2FYOXdS?=
 =?utf-8?B?cE5adFlCaG9VdGtJWlRpRVUwcTN2TVhMUFRzeGlVM1ZPbWVZUGZ0SENSWTFs?=
 =?utf-8?B?TS95aEIvNWRZVkxTdXFoZGpMc292OVZLdDRWeFBaU1BrZTJxRlVoTG8rMUZT?=
 =?utf-8?B?aCtXckZrZXlNRXRGZ0U2WjBWOEswZ0FqQmRzV1ZmNm91Y24vRHU1ODc0Zkl4?=
 =?utf-8?B?dXB4MEc1d1ptZXRZWTRkdU1RYXA5Y3Y1WmliWTlFVDUvT3UwZnRneks2M043?=
 =?utf-8?B?K2RUeWxBUkNvKzRFOGdFK3hnbVFLZlREZkFla1NRVW1CYlZEUnRCL1kwSDJz?=
 =?utf-8?B?eUhRdG9VNHVleXFXOFdGTnBCRlM1QlFVbXdkR0JGSmJRdFdWRUhDNEZEZGlX?=
 =?utf-8?B?cHBBT3pwZVZsV1pvQ1lpREJPM2pwc2FLWUNxdXY3MkpvcVJpUXdoY1h3akhw?=
 =?utf-8?B?SnFaZkZQMklIVnJmVWpualpHVEw0bkN0VWlrN0Q1WisxcThkL3dRaU9pWGhE?=
 =?utf-8?B?YTVOU0huV2F5UW9VQTloQ3llYzRRRGMvK3EvMjEzU2NvNG9vZllZYWVjS2lC?=
 =?utf-8?B?eFpqLzZCN3AySnRKdU13bWlheDNTaU0yTE1YOXpLYnVJYkQzTlNPMEFIdmlw?=
 =?utf-8?B?dDY0a0kvbnNMSDIzWHhYb1RuWFErWjR4UDlIaWRkN2lVUGliKzdEWldvNE1I?=
 =?utf-8?B?NW9lV21RQm5RZituWjlqZkwyd3FzaVE2aWE4UXkwTy9nNVJiM3JZd2V5QnBm?=
 =?utf-8?B?Z3Y4ZzBPQVRvWFRDaXI1dHpYY0VzSzlhZk5PVERJTHBEbVJ0MUQxRXE2Tndq?=
 =?utf-8?B?ZnZDTUJZeC9VdWN5RVpaZ0thK3FPam5vWFVzUUJUUWlwT1ZxSExOWHdPNHVn?=
 =?utf-8?B?NmZ1a3o2SXJvZHB1b0I2bllKQnNtSUFUa1h3aVJZTi9meFN6OENjLytPd2Nu?=
 =?utf-8?B?ZXRsb0wzV01TR0Y4ekhGYU9RWXdzcVpZZTNNdXNrczV4TldacHZUaE5SQWM3?=
 =?utf-8?B?RU9ZR2ZJSFZZand1N0E4LzE3T2pQOUFuZUdlYmpwVWJpQ0MremFCYXM0d2JC?=
 =?utf-8?B?YjRmZWhTUmszVGwvZ0t0R2ZteU1zdENWOGROSGxEM0x0TXFLM3hVcDlwUis3?=
 =?utf-8?B?cEpOenk5OTZlcmNUN3Y5K05WVmVkRDdIRUpMS0hKcUplZDBaUUlUNGxiYTlK?=
 =?utf-8?B?azBoSkR6RUlPZ1hSMVc5RjRZbExwMm03ZFV4RjBrL0Z6VkZWeHRhUmM5RFBB?=
 =?utf-8?B?VVA2VXVCemFaOU1WVnJzY2ZyT2VtY2ZHRENuaHZTeS9hZ2lkTlI1V2ZiQndo?=
 =?utf-8?B?aGl2YnJhcVpCTVc4dGZ3Zk90MTdKMUlFUTEzSVk0Q0d3TTRMc0xTa0czZ09v?=
 =?utf-8?B?OGpQUnNaMjZrdU1za25MblpscnRsN3JWOWpJYXB1YXA5M1RtU0FZVzdRVXU4?=
 =?utf-8?B?WVZXR0hRUWVxazU0dGU2QU9RcTZoQkF2M2oyRTMwWTd4OS9BRHIrVWNKUnhP?=
 =?utf-8?B?MGVOVmdvdkl5TVpxVytlZllkOElmdGVwUGFSclV5aTkxWERublllUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 406d2fb5-aef4-4bcf-bee4-08df41af3a11
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:54:56.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mpin4s9R7qxePdEL3A/nknKtknwB9oMDj4pi7NC4Z6dSE6v99fF06lIU3xyiANy7g/IlyQfu/BbCKth4LxFYEPiqC39duQXPykIsPP5alhE=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> The I2C clocks supports use of source clocks with 200, 100, 50 or 24 MHz
> rates. However, the driver fails to select any source other than the 50
> or 24 MHz source clocks.
> 
> Fix code logic to allow selection of all four supported source clocks.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
