Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC3606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RxJUPAEN;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nBbRlxl2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60AB1409D4;
	Wed, 11 Nov 2026 02:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sO2infeMjGjU; Wed, 11 Nov 2026 02:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89DDA409A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794365336;
	b=OAmsQcUX7J66EtizryD2LFPphOOKqy5gitDklJpDRs2LRSRkGFeEg4J+q3DKHWJ90QT1
	 TiB6mfTx95c7BVilYzXflidq/Sma5pVl2FV5sccB2k2rD6J6P4U95HGDAZvrwunYp+h91
	 hgXVlcTFSBtJNEI1vP/67tPAvwKvNvO6ZGBad7ySQ/legkA05efdWP2Vrx0h3sDMqG4Xt
	 0bu+wNvTomjy0L9dUOub1+DJ/0zdQx8Zv7/XSJo+OWuH7sfGIfC1snKDMbpwUPCmpnImZ
	 lXwJlGOg4+zWTB23yZSBwWkOkfgVQNdz634JX1zfV3EGv3f0inoYvruDNtpXT0Zsv0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794365336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pygmnQNpoHQtrx57n7+hT9sWVdwMjEz60iLW/F7edZ4=;
	b=EHz36M3b9SDYt3RhFf2I6lk1Pjb68GqVkJsCPPAl1ZXGGUChv3+5pTEWUkLkqG6khMv3
	 FU1WDtZ4+lMk2Yoy3xQntzOECfqyjrUu197z7WlZE/MJ6Y+9lqa5RFSLZfoZWE7ywTT1Z
	 9oAkb9DFWznRAxVSfMD3kHfSLUDoW0yo9S/XEk18DP3VGgWk3tV3EF/lKi7dvUxb2uCHU
	 fDSmG7/k45PCgJl+YbF46qIY0FiEaKlXTr8dZaxWMVDTw4utdcQ4OvbRAy/GXthhi3BT8
	 92FtKoJAqKgeC146Pbb0lJG8ZOkL2rpU3TeSUoNuce6xVe9ShjQlQ9HmihTed56Cxpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794365336;
	bh=pygmnQNpoHQtrx57n7+hT9sWVdwMjEz60iLW/F7edZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RxJUPAENjQC/V5vmfKOPOwrAZukw+iLL88PEMOscQdj/P9amFbLWQabemi0SY0rkp
	 mZLXxlovwzz+9NT9oM7kmW1GzxpSU6bU6SV8DTJbZRmo1sArym3GKJnOXLNGL/cdmz
	 gmejOGRAYFojTemubvnmmxefXj83MUjc3gfhRjTb6nNHY3opSS6/2LquwSgN5zwPGN
	 GMH1u2y7Tov8ZnzvK5kytIaW0dXheiiZaikx6d9ShpAjYxWCAwWXX4e1ua5E6QlJrP
	 kacPZK8U3R2fH9JJ2DvDHOjWTsgal4pUVn2UPLhtd/dMY4dfEJop3uJCq/YflGNrTN
	 D7VeejsuCAgRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89DDA409A1;
	Wed, 11 Nov 2026 02:48:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A00DF46
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4604C80FAB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmGR-9tCfZRC for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 02:48:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F4D780F85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=nBbRlxl2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F4D780F85
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:48:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CE684A29; Wed, 11 Nov 2026 03:48:48 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC32284808
 for <u-boot@lists.denx.de>; Wed, 11 Nov 2026 03:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pygmnQNpoHQtrx57n7+hT9sWVdwMjEz60iLW/F7edZ4=;
 b=nBbRlxl2XWhUtCUJEZONa/WFjmC1BwEzUYIdBs1p+Ckljkl/g6YdW/H8HOPdGEOlToQc304gApixNwDHrOdaDt3g5BT5iFTYWTZtsIjb8h6zOC3PsJ37gpG8nLy5vMZFKnpmkL6mOKQ3c3O9Zcn27f8/DmQmJROQAZyd3XIIlRruuKkUD08DiiiVM3Mwr1ckZldAU1ak/2ZVlYjbuUVRqc9kAisk2iVprEXgUzl7WDxLUI2MJEL0EPDcPMCj3LhtAd8ZFdcMv66ZD1BuRbZlvm85ut+NFAyY7Ue+b1Nw2X80EhjVCRdouuJyKdsaBKDZOsjYUVj9PIJHJVyFBX9qVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by SA0PR03MB5513.namprd03.prod.outlook.com
 (2603:10b6:806:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 02:48:38 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 02:48:37 +0000
Message-ID: <8ffed897-ff79-4d95-a759-76f0946da850@altera.com>
Date: Wed, 11 Nov 2026 10:48:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm: dts: socfpga: Add Agilex5 MDK external GPIO
 expander support
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <20261028012816.32184-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261028012816.32184-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|SA0PR03MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2d2c15-4095-4891-dc93-08df3f9e4925
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261009223027099003|10067099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: LIfXuF7WTjRUB5LSI7oY75Cc87gwCnHygYZaI7qTODrtgtYcf8E/a5xsm2UXPO3JDJlhMwVqF0CInw3oWeqVn5sntUbcRWUDD/R6TIJnqboi9wHVvjfZk6t8/8GOJfcDjVOCChyQcbCtNlT5y+K4cYAVSimb60Ly2h7Bi+xtJwahZ5QfHrn3kyC6s0t7rFc0p+eL/02p2mzwvuwE9hrSWKK6V0S8YKqz/BPRBFlnmmuDORDAVobitgodhqnwJ5F7wOLpNSDTGgXDj7xsJtdWnF+rrWCMQGUzQ5fhrpoB2gUuU7/yhlBd21TY0w6rqRwX0ed5qUuJX2jqpsQEx75vNjnxb6hf9vI1AC1T7mxOHJYeGi7F0HOZqQ+Cy0hx+D6cyy2CeiBp6lvXi/b9nzStkGi+xwZrnUt7Hb3JcnNzA9c9UXfzA0q4lfsv53d4Ue/7QrGblMUJRZTRsQkCgcf/ARH9KNWvpNr8yY2ipTHFHftGGkLZloD4+lCSpdLHbyH7ZNg7MGzM/lOF6lB9kMWi0tfCv188fv+HI5NwKljILukNiTHM6CiSWkW15uTf6KF7DAafi+ml8ZlT9ohhY6lgH5qzrgUz3sY5S5Hm1eZQR21BaV4PXZRnodK4r+MjANs29z/g3s2zvFMgPdNw3tj49X8iixD7VgMUQ23tjAbHU8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(10067099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzB6ZzlTNUQvb1BLT0t5L0JLWXJpeGtJMDQvSmYxV0VvbHB3MWRaeXQ2WUlq?=
 =?utf-8?B?WXRQT1NhakJ2Ylo3VlJqN0tnZzlQNFdQNGFxUUpYUGZSbDZ0aFliSE05UE44?=
 =?utf-8?B?cm9NVnkxa2JZbjc2emFwVVJZWEsyZnFlRkFNMWNyTnRFeVlCSkVYcllEQmxT?=
 =?utf-8?B?Ti9KSDRHSjhYcEEyR0h1Q2MvckI5cmtkV1JoKzRKRlRIcGU3b0ZRS243SlR5?=
 =?utf-8?B?aCtkVXhWS092bG9SRnoweFhaUklKZE9rY3VRczEwTGR3M1FjMG4vWkZtQjNF?=
 =?utf-8?B?Zkd1dnBkd3BZSm9ldnYvZ0o4cjJTYVlHRWVFK243emlReU9PeU5oQkFYT3Zh?=
 =?utf-8?B?ZEM3dElPd2ZsRmlodEh4L2ZwRTVUSVR4SGZ1MFIrWHU0NGU0eGsyZlNaT1NM?=
 =?utf-8?B?R1VVdW1QOG4xNmhyR3pRR2lQd1RjOXhCQXpQY2g5YWdzZDNBZ1dsZi9vb3J0?=
 =?utf-8?B?TUgybmVybVZHVXRtZWJaQU91WGRESHJEZWYxL1ZTV0l6TVByTFV3TW5JRzNs?=
 =?utf-8?B?emtwcS9aeFRhVElqamQ5VUg0cmxqYllSUVdIckU4SjVFWHZNU1hXSFlEcTls?=
 =?utf-8?B?a1VZQXJ6ZGNjT1pDWXVoUk1KdnkxMnQyN25KOXJlS0ozejVoQ05PM3o3eG1x?=
 =?utf-8?B?b0wwS2FHdXB5aHMwRDlROUlDdFdTQlYvZ2hYK3NPemZqSGR0UlJIT3RlbE9B?=
 =?utf-8?B?eldkVHdKU0NWelRmMDl0eGRmTEtjNWlrMHZ3dnZscWhlVWs2RG5lNEMramdu?=
 =?utf-8?B?d25IdXVaMGV5c21NQWF6ZUlzUFltb2VJZTc2dml3bzVuZ3EvTVMzQlpIMVYy?=
 =?utf-8?B?dXlsTTlZUXpocnd5YVNDSUNLZngwaHdBa0lhaVVDcU01NzB6REN1TnVmL0Uz?=
 =?utf-8?B?R3BkTnBzM2o1R1dKN0JPTzQveXZNdlZMMjRrYmhBVnJjT2R0djRYVzZ1Z2U1?=
 =?utf-8?B?akd4S3dWRWZ6MmZ6bm4zMDhaQzlnalY4Qkx2RENtU2RRL0pUY09aRHlobGh3?=
 =?utf-8?B?MmI3V1h3aXpOdzM4NHFyWk9qUU9BYzR2NjRZZUpGV0VqZGlQOEEzVmhCZ2l1?=
 =?utf-8?B?SGw4UUJhNUJQSHltYkhJOUV1LzBNK1FUcDluaC8vM2ZZaUE5ejgxMFlZMFIy?=
 =?utf-8?B?NVpNWnNPaFZVeUxMd09zNjZ2aVpQUDViNUVaNDFoMGNKdDlwcU4zVWtMZy9X?=
 =?utf-8?B?c1dOY2tqTDJIMWw2TlVTemJJTVFkQkxTVFJpdEZscjNkWDdXSU5RclZTK3BR?=
 =?utf-8?B?Vlp6U0kvL1d0QmxTOTlSOE5PbEcrUjg1Y3grOXQ2RElVRjQxSExZLzZZd1gw?=
 =?utf-8?B?MEVnV09sRU5zcmlkWlJkOEtMckdhRWttcmxrRHp3Y0lHOW52TWFaRis3SlN4?=
 =?utf-8?B?RVpUY0MxQmhKREYxSUxpakxMaEZZSEdldnFiKzkzVEhpV0RhcWJIZit3blNP?=
 =?utf-8?B?NFdxYURHUjZmbDlMUkNIME5GZjhYcmZsMjBzWDA4Z0g2ZnNJSEJPd21icHJ1?=
 =?utf-8?B?SmNDL1R0M2h2eHZRb21YVmZJcDBYR093cjYzUFJ2M0EzcHd5YXBjYXNlMzVC?=
 =?utf-8?B?eW1ZazBIMXZPZWxJM2JsV0JPcTJ3dE9PblFWS3BMNGhLcW5UVWJvUm02Q0hq?=
 =?utf-8?B?VDRYeFEvd093TWoxQ2VVamRMcVFGRWRxdlZzRWd6K2FhbTA3QTVmelcrMnJK?=
 =?utf-8?B?MjRsd1dQQlE3cDBmQ2lrV1hZNDNhbER4N0FuWXNYcjdFQU9PSHFGV2VzcTVt?=
 =?utf-8?B?NjVELzU5VXhLOUxmZFVvZjJKUnVBM3huTVdSK2RzTWNJM1hBWjVoRTFnczk1?=
 =?utf-8?B?RXNGRGk3RXJKZ2tRci9oWWJJaENsSWhwN3Z5WHBKZFQxZDV0K0xUSmVHR2Uv?=
 =?utf-8?B?bEtZbC9JRi9wYWpXSFI5ZEdQbHVZOUh1QmRuS2c5VnhHd3p5a1NJOXp4UzZB?=
 =?utf-8?B?WnQ1V3ovUXQrRzlUWHk2blJrVC9pbzFubk1zczRhUVgxUkZOeWhWRmVGN1dz?=
 =?utf-8?B?eW85YkpPdXQ1Yk5UamR0MlNwRENia2l2VUtra3ROOHd3am03b2FaRGtVTU5J?=
 =?utf-8?B?TFArTUk2NUUrcWRkdktZb01wU2hOd2Q5UWxkVERRNTg5RlZjMHVoNUJmNWI2?=
 =?utf-8?B?K1Z0Nmp0SWxXRU1VYUE2YTR3OW1xZVB1bE4vVlpQbTNPMHdvR0NmbW9LNDFq?=
 =?utf-8?B?VGVyakJKNy9Ma2d6ajMwWDJkcWZDcXRHQWhST08zMUFaRXJ1YjNybEJZdk1L?=
 =?utf-8?B?d2gyQWkreTJuekcwRFpKR0xZeTdRQWEzbTE0YnNkVXBVRCtqanNDSVBkU0xo?=
 =?utf-8?B?czRsL0ljVFJ6WHNYcUhVZ1Fpd09aaC9jUXg3RUF2ZjFqVUFaVEpBbFpqeEpP?=
 =?utf-8?Q?/9HYTVa0zEYXnb5Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2d2c15-4095-4891-dc93-08df3f9e4925
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 02:48:37.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEA1+tR9whho6AyWB87JAOishZte41tavf8W/RTaZL1JxCaUkG6eFZO6r5mTTgcysBTci0oYuF4OJmXKd0/eXrY+FP/aZ0tqrb/MCIBdB6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5513
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 9:28 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Unlike the Premium DevKit (onboard GPIO), the Modular DevKit steers
> SD I/O voltage via an external PCA9535 GPIO expander on I2C (address
> 0x27, pin 1) for the level-shifter control path.
>
> Enable SPL and U-Boot I2C DW plus PCA953X so the expander is available
> early.
>
> Co-developed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Co-developed-by: Tze Yee Ng <tze.yee.ng@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> ---
> Changes in v2:
> - Removed binman node setting to delete kernel subnode in
>    arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi as this will be
>    done in common SoC64 dtsi in series 503845
> - Commit message clean up
> - Add socfpga_agilex5_socdk_modular.dtb in arch/arm/dts/Makefile for
>    arch-wide make dtb compilation
> - Update copyright year to 2026
>
> Changes in v3:
> - Set model string for Agilex5 Modular DevKit
> - Advertise SD UHS-I SDR50 and SDR104 modes
> - Add sdhci-caps-mask to clear mismatched SDHCI capability bits
>
> Changes in v4:
> - Respin subject to match series title style
> - Rewrite commit message to lead with hardware delta; drop file inventory
> - Add Co-developed-by before each co-author Signed-off-by
> - Drop CONFIG_SPL_DM_REGULATOR_GPIO and CONFIG_DM_REGULATOR_GPIO from
>    socfpga_agilex5_modular_defconfig
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../socfpga_agilex5_socdk_modular-u-boot.dtsi | 151 ++++++++++++++++++
>   .../arm/dts/socfpga_agilex5_socdk_modular.dts |  82 ++++++++++
>   configs/socfpga_agilex5_modular_defconfig     |   7 +
>   4 files changed, 241 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular.dts
>   create mode 100644 configs/socfpga_agilex5_modular_defconfig

[...]


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

