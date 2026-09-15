Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ECEC88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 09:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B93B605E0;
	Tue, 15 Sep 2026 09:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Dj2w3ZkAgUL; Tue, 15 Sep 2026 09:21:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B17FC605EE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789464108;
	b=m1ehEjWS3JC3gKfNZxm1HO+uxb8eJm16vYuTcKeZoL7be+CykkiSnWFPVhx51HGWyi/X
	 lkB817OhvGOT9fvIUyLGvnKaI+AZr2MqIMHNraMX5Gipf8748jAo/c0310y5fqCACUtA5
	 1Vp5seci21TdZ8JVnnxewqGcW/eaOH6bkr/hc5zDz+jsbFxpPU5MC+L1C610Asq+3wbCk
	 wCLjvGfNeTPZwXdkbWGCmcMIszHCAEcBq9JIBsaLiCYy3fm7qR/1DLtV4gDqbM+31OzN/
	 4OPjPiLRzosV2XQAZcDj7wVHEezvlDIndbf2j+XoEi73nmi4ILbam8CFIQSgUySsOtQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789464108;
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
	bh=DCY86w0auJnrMujTz5fslDRLUqWuI9mqr1Fpn8gkkdI=;
	b=GZQpwUBgyoDPMVt0xpaxnnd78mgqC38l4B7SAN06ZE5uzhCAtj1PhUNjv+vQ0xicQYP9
	 L7keGEIcTCgeEsWxOnPonNgeqOgrZsBKiVV1lt3ev+zdBttXs5wMwe0KdRv7ZvkubOnIw
	 F7l0lajpC+dPX9qL5J+gC667sFlaRehQ42JDfom8QJRDzSsKeDnoO+vzf79Y5k8ENh6p0
	 ejTimLm+AtcZir3Tgbo73+mRAMn6fIiIkkdL2vqcq9QM0x29OhibnL9DDSEFVuHH3UoLX
	 4oboRbukGEFnjnDLFCeKlLNvs/wlQCwbqbZM59pmUznAOuv+NF9Cd1R+MG5i4SM/b4w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789464108;
	bh=DCY86w0auJnrMujTz5fslDRLUqWuI9mqr1Fpn8gkkdI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1Yt4hhEKC4hi4gUnJRdRgQ1jRz9w3muNx2izFLmKCsa5iWrZOZlDl3Xy4KQL/sYd
	 fCTOQtQBHSUv/gITF7DQZnfWaNQ5iJpnDIpThA6KLtc05d41YnAps84FJhzbuhpsNz
	 SmPArWfAw6ndNruQcBh9ed3N1KWGKOT6lTZBegf5LfxIXrMKHhPhrTcTvzva0GQS2a
	 sqdmnaMb7lrygdyL9fed+Qq4DY8DCYL7w9s3XpnXmGp5HepfwHxXCAOw+QEml43hUt
	 t/EVafIIB9rtPpu4icsyvw/UouIg6JDLP1opvBmWP8xJcMfNR4sfpQcnunY+ntiUU6
	 CP6hoaz/aiVJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B17FC605EE;
	Tue, 15 Sep 2026 09:21:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94E58EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AC0880C79
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-NDoj79PvhD for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 09:21:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B048A809CF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789464107;
 b=JD8S+iDMQffHNPv5nBMes/qwalbmpJxzZBgA2/ArF0bdb2ewxrqqf1JT7ByVxL9ho14S
 hVWes0KxHBY/b/AT9p4UwOf9nhh0SuepAFBV161AKL8cVOE/lzdj312itE3gQHl1LCwH9
 m3IAyArUkw0NkckZ+Rc1/5Fq5cJP3WqxW3qJrBB8E+k5tz2EZMBFdihQhWyzj6YNHmYvy
 VdKpwLQYNBMQNeUpj7EF6HUYhbWrLZG1A6wWNNGc020RSuVQuYk8DGLcNZ4mjm+8GZmBC
 KOHtnLwysXhN8KqlDuI1K4aSR1TTsAMQHbOXF/herGGZ0bsTzSJLgkbPlTgfppIHYzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789464107;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=DCY86w0auJnrMujTz5fslDRLUqWuI9mqr1Fpn8gkkdI=;
 b=S/HFgDnQI9/aCRK8XG8H6npo2PzNHJ+ezBlIedZO3YNTPSG0ZuyetOXH/446JWmDTgNj
 yCbHmAbj2fNvHqSIjWqN3cKdVlkbMA0wgQGJC12FZMfybD9qwacCD55y2mTzMkaUIcte0
 I6qL6U8ftwWLIUzetifFLUzsw6EGB7rOWfb5FyjcppyweIwOOCrPKOTNuZXNBmMWpRIOS
 bU9ze/x4NRJCP/IfZosbxAfOmvGRX3H6zopAevc8/IF9ZnAE7QXQW4W7N8bSBmu7E99pF
 vFemFlvEej0ZfCe7u3Km89SAt1Y68vnHS5qMxJx5rPhhwmDdEiIzsv1O+Jkxk4mqHKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ow8dnOHJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Ow8dnOHJ
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B048A809CF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM+0schCQwbP2f0e9vuufB+pcMg3e1NeaI3QDFKYIfPH2K84m1FsgTxRa6m9TQQGRsGErJz/TBCxRJ9oNh9+nCKsfaqEiDtHDK6I2U2zfJLTVFTZpBi1i5TQ3JOzlUysYP+/14ClqqbNXWx4RJ/Hj4itXEGXizgibnc0rr71iMOWrTz6GuTPgGWxZCxH14eqEMlWkdwYy/X4yBxkUjg5b4GYVB/9HN0a9dI8JBKizyOfOAgHPQUNJhrKuewjkLjJ/izzb6DpWMB3tgMYuR//Sct0iGjHpdNjv/U1ZVOH+qu09JjQtU371hlHqbYNo0WQlJ842OuyU4ZH3WEzE3kQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCY86w0auJnrMujTz5fslDRLUqWuI9mqr1Fpn8gkkdI=;
 b=jHY1xl2Zh55FFaEOmjAliBfR+kQG9iPDUmStcdfJgUyn8EIb/rYeHMZcCI4Um81bty/YErc6Fq0ammL7ekGXO27/ucHWYfz/TdgEi5JOXnH2w1NVjUpB722yRrpGMpAHed/g+kqpVgTwI5wd6fO1I/M09e01/8xLk1wTFrsdKLyDCFJOnhD1kDZvranQGxwIdTTbNvUXmHtxDTGTlCH3/3B6Tar12BJug/SsmVNZrMMbIVsb+8zvzU8N4JXHJGA+3fq5V3eXREUggUWOshO/b6+j6TFXeNk2oH6Vy+8G14/taNJ+8u4GcyaWCqWlBffmUIGkn7YDJK6TtXEa2A2riw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCY86w0auJnrMujTz5fslDRLUqWuI9mqr1Fpn8gkkdI=;
 b=Ow8dnOHJNNDy1CfUOKnFHCDO7WIVsOgO4ilis6lwNt8MnjtM9tmRKgJAnshMz1JvxizxVx7BxcOR9TQS80P3Gzn9px3sHa7IxTxepbf+erEmh9aLc9V0MMu0by7SHwspKvcvluUNbcdJY0wrvmbeTMcgX4chf59N118vH9ZYl9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BESPR04MB12611.eurprd04.prod.outlook.com (2603:10a6:b10:100::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:21:38 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 09:21:38 +0000
Message-ID: <404de315-cdbb-4c52-89d0-4ddbf533e4d7@cherry.de>
Date: Tue, 15 Sep 2026 11:21:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD
 check
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, =?UTF-8?Q?J=C3=B6rg_Sommer?=
 <joerg@jo-so.de>, Carlo Caione <ccaione@baylibre.com>,
 Alexey Charkov <alchark@gmail.com>
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
 <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:802:2::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BESPR04MB12611:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c0ef1b-131c-4508-1241-08df130abebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7ZEOcQAc7ofr89MJzkUKxFMDPHL5N0TuRk9B1GDbEXxkvOptJ/FVY3Yo9WsUc+A4OM0jDzpNPk46u2ILYXh1OrE2Swt/WNc1ImPkxX+WimGdwLGe+bafrkxMqCzJJoWSi0GFkPDJzMVM9c7yIVjAcbYzioYtyTLOlMLqJ/zJySsEu7qs4GR6zqcNCu/Y8dYeghw4lbiP86PZiJqtbW7ggsEmu+EQFeMOLHFHD+MovK8tClRM6MJTmmL1yOP0Y26Z8WUhuImeBBbIsLprM4ZZjFbejIl/0KthyKlOJrl9Q0XAYbKrodPcRuRzocCNSTMbgvtHjjqc95Gf14A/BrzBVbIEcmVYAeW0jlkWPjP4/efI0D6rKUCrYjJFVIx/zNJewV8AGKeY2d3bYMHsVrRrpyKOwAm3HxF7q3msQvHNSPCKMwTl81i722lAGahv9mW9eVwVKIeS274EhgfELV7lWzEck/h4vm4KlX5/7wUprEY7g5Bob63WhhI1AeaMZEXBdiXbUcXbaaEnUt8cm2lCv5pZ0Cdcrq4HgjDJImjPczuI+StvKeHpDoAGIscM3zunumzNdmfqmDPkNPLZdXkomZYxrvefMzBiGHB10egsS70aSlb4FPORH09UGS6WtYmSYW7BQxHPIWMC/5dl8eUbFDgd7Ux1NGu4GElfG/wOHXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU03R1N1NkpsT1R3ZUFrT1M0ZUFvUGxiYm5XYytMaTlYSjFNWUhpQ1pub0Iw?=
 =?utf-8?B?RzZEdTNvUUg3ZWtHQ1IzcGs0MTJLNFA0NFA0KzF0UkMrUmNmenptMzNzRkpI?=
 =?utf-8?B?OVR3NXdtYUcrREdyYjMvOFZkODhiWE50MEp3b1ZnL1o5cU5SR25uUHVyeWMx?=
 =?utf-8?B?dlU0VzI0SnB6MUhNNk5keDl6L1pPL2pUcUJxbm40T3NEdjVJaGRUeFhPeElQ?=
 =?utf-8?B?QXRQQUh2L3NTS3VIY0U3MDV1ekQyUW1pc3gvdDB3SjQ3dGlKa21HUVBmQ3No?=
 =?utf-8?B?TTZSclZCMXg5cWNwRG5LV2V2Q1dYRzdmMlc4TWR2WGl5SWZXNTZNdnZjNHlT?=
 =?utf-8?B?aEhWMDRKL0ZmeWxmcWU2T0dTWnJyV1FtV3NCTS9SckR3Q0ZvQndvMXBkem1W?=
 =?utf-8?B?emNJL2JndHdFSGZBaEZnU1BYR2JudHZWSnJ3Q0xDWEpFbExidkFZNHoxMGor?=
 =?utf-8?B?RnpTZ1BrZWFIbzhvaENWY1graGxiS2RIYWlGUkUzYkZZWjZTTzBCdTl1bWVG?=
 =?utf-8?B?ODdSbHY0OFNEU3BrYXpmc3owYTJNVkdxdnJpbytMNldkNUFIL1dKeEJwb1Rm?=
 =?utf-8?B?UDcvcm9OUGxoREVCT2dRZmxzNzFraGRDeXNkN1V2WGZyTTkvczUycy9wdDNy?=
 =?utf-8?B?YkVDemF3UlFiM254N1ZTTlZ2Ull0TEZXSzJmNkhCVzBDOWtnY2tVZEg4VW5j?=
 =?utf-8?B?Mkc5UmNVTTRFczVVejlTQnEvV3dGOHQxN2RZcmtpNm9qSUZqNFpmVmxpMGVx?=
 =?utf-8?B?VHhPQUhTTkU4NlQwMzQwblFQQjNNRkk0MDg0WGlveUdNUTQ2OXRGY3JNL3lk?=
 =?utf-8?B?UzM5YUwzTmlNRm1UZUsweWFYeWFOWVNGdHNndzhQcFUyMzBxMmpBRVZJamoz?=
 =?utf-8?B?ckRob1ZXaENMdUR6Ymk0NXFDNXU5OHVZRnM4eG5PMWxJZm1QemJQblMzQ25y?=
 =?utf-8?B?M3lwZ3dVK0xNcisxdlJLR0dKUTV5RmJjZjhJc0VHOXd2MnRBaDF6U3EyRkdM?=
 =?utf-8?B?ekRxclF2THMxVVhYVkJkNmJNeFdCVzNmdUVlSGNaRmJPbGNSMDhaSHhGdzRq?=
 =?utf-8?B?akkyalRoT2R2amUwcWswaC82K1l1cUtHT0xnY2c0cUlWMkh5d1NlanBHTzA3?=
 =?utf-8?B?MXB6Rjd6WXhxSlU3WG41Z3pqMUFOTGJSNVo4YklGdVZISllVL3RGaDE1bUdr?=
 =?utf-8?B?cWpRa2VqQ01ReW4vaytrd0tUNnJFMm1XYVlNOW5XTXdOb2krVWNKNDc3L0pC?=
 =?utf-8?B?cUFmZkVDUU1aNjI1V3JKbkhyb1prNXp1VnRxZXRyekFNM3NkVGxtVEVzNld0?=
 =?utf-8?B?NThkRldVZVdyUFVISjZxMVZFZTJwNWNtVGppSDEreUtxYjZFdVIrRGF1UHJ6?=
 =?utf-8?B?OExyWE16WEIvWW5EUnZ6dmpPempVK0VsK0g3TkdhTjJrTU00SHNiK2ZJbThn?=
 =?utf-8?B?dUJsaXlDMnkwZ2o0VWx1VjlYQ3JZT0p3WEt0V0NUYUZZTjE1elNrcVRXTUR2?=
 =?utf-8?B?NDdnUXdiNDNkQ1FDUFIxNUZmSDRTR1ROTkkyV29xaGNxMnE4TC9XUXFRY2FI?=
 =?utf-8?B?bGNWSEhYOHI5Njd0SVJ1anh2NlRrNmFnNlE3ZDRtOU1aSDkwQWVTUmxBS2Vz?=
 =?utf-8?B?RXA3NkppVTdhUGI1UWRrNWxrTzVJS3VQWXArQzNtM3ZReUYzQTZIeGVzdVRu?=
 =?utf-8?B?aEMwOVRxR0xVUEYrUzV5L3dsV0tGTXB0S0ljaHhSYnNXRkw0VWFPa2tsa0xM?=
 =?utf-8?B?UGpJa2czcU1Yb2lXUkpwWGhTQm94MnlDNXMvYUZLTmxhUlVRdzJkbUdESHla?=
 =?utf-8?B?SnZDZFVkdFhTbTNHU1l1MXJlNy9GOVczczhxTjA1ZUpoZHF2OWhKNGxlQmJi?=
 =?utf-8?B?VEVXUFA0V1IvaEg0TlFjOXIrRzBCOXE1MC82MDBwRG1RclFNdThWRlJUbi8r?=
 =?utf-8?B?ajRWQnhzL2tPVS9ITlJMUnZiMnBpcnhoNjFWWEFSV05pSEtHUWgyNTVoMHlM?=
 =?utf-8?B?SzNNWDJNVE9RZXc0bzRsbWFMY3EycENlUXBETnJJdXFHdEgzaVc1QjFyZ0Rk?=
 =?utf-8?B?ZExUVUcrMkZSai8vZ0ZvYmtZTTNZSmc3NDBGN0lLK2tKb3VHS3RIVTM0M0k3?=
 =?utf-8?B?STU3OXVkZXRZVmVKSktvU2RDT0Fpd0JXTDliWG12OGdINVZVKzJjRXBNRE1P?=
 =?utf-8?B?bGNFZ2t1czR1R08yc2VCMkh1cGJucjd5ZHFMYzIvT3RHWm1iVlJ3RWI5TGpy?=
 =?utf-8?B?R0FJT1JZRit2akhjUzNob1hRS1l0NHNZRytaTFRCSVErTW5XTlovaW04dzdu?=
 =?utf-8?B?ajZpZWRRVGpmRXZTbENzVWVTSTdqbEdnV01ha004T3hHQkI2NWJTUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c0ef1b-131c-4508-1241-08df130abebc
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:21:38.3025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnqBV7pn0USh+xl2W17iR5z7Y0VtDXv5gwL7wv6YSqPmo9MWrvX6AIxC3udETfo74L+IgNeLYHaZRdnFqT70zdMKHJeyBC2v9lL5HFd4YCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12611
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 9/8/26 7:04 PM, Massimo Pegorer wrote:
> Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
> proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
> CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
> that CONFIG_TPL_BUILD is not set either, making its check needless.
> 

I suspect we have a lot more than this one.

A simple git grep "CONFIG_XPL_BUILD.*CONFIG_[TS]PL_BUILD" returned a few 
matches. And this is only for them being on the same line. It's not 
necessarily a direct replacement, as we have CONFIG_VPL_BUILD which 
could match too, but nothing (except sandbox) makes use of that stage at 
the moment.

Also git grep "CONFIG_[TS]PL_BUILD.*CONFIG_XPL_BUILD" returns another match.

> Fixes: bef9fdbed2e5 ("arch: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
