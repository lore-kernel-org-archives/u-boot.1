Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC29C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1944D40912;
	Tue, 21 Jul 2026 12:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5Zhik9Ky3dj; Tue, 21 Jul 2026 12:00:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17EFF40902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784635255;
	bh=rCR12mtIg/A0fM/fE84nD5Syqrn36tGDQo6EUZAEAqM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TA0/iU64fjO/4EPZKm2QIPQ8eguLMazjgBtPS1DgqzCJm2kmfcHCQz4QDpXPbbneM
	 hXuvy3JDLY2tYvloIam1ytg13WuGApS1LTLKEP6OJwTBcAn1obEwcHH5MtdtXIEXtr
	 taq34qSaOVcJtX5ei6e8205zPSXLK1hVSDt9o4p63jzljJHmh8JjEJF1HC/uKXZkpm
	 5QjZh8j+7tikNWUjtFtWkuUKNzNxislqlGyi83ojGZ8RZizvr5Nxs7aCgRbBmIu6OI
	 renrCUPpJwNoPPL8CkIIMS+FRd9p4bLaDlse4+yHRVws6UQf6M+gq9LNXWWtAyp2/8
	 lUUlC9CkRNlHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17EFF40902;
	Tue, 21 Jul 2026 12:00:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F190342A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E356C6072B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH007Tqvctnh for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:00:53 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7ACCE60748
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7ACCE60748
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7ACCE60748
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:00:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3155C846A4; Tue, 21 Jul 2026 14:00:50 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1724B803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:00:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPtGfQY/unwx/muzCZ9OcRJSWIdotSW/tPReOtBSzgdWBO8C32KOIBYMK5ldEg7nh3gSB5ylYHvyZEGQjvCGn7ZgXVvS1AvCHazu2P6c8Prd5AIzTIKCoBoc9qE5ipLcdaPTB9uoGfw2NwMmPgkmfsj5WegrpURlewWrQegOpRf1X4Zbb0/edfnoFURH0CQDYDBVwPe8iIsys3KpGafx7qQmgsvGrfGpNvHL/RlkGVv3dQVV2DYfeENxEjqeJXWx2Pf9VKulIoeCxs3wk3hmrW1OBpEtywMoLKOvaLVrr2eBAinYm/qypFQLmnx0izuX/Z+uFBxrTGOBCL37Un8flQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCR12mtIg/A0fM/fE84nD5Syqrn36tGDQo6EUZAEAqM=;
 b=J8l8GKkNSSaDmXdblMrrayuNSVOctAW6wpEUMMZ6WVl0Az6wfEDLl3rAPZXXtiA5WrfGUIz8fRTpwnUapWTVYoU3fFbWh83jJD3Anl6ncqHyH+/ZE6nqFQUwzPY8xxZmiQZbcBr3Txwi/uY16n425/7AIXmhxOKCt4QpyeeNN+CYyrtS8ZnJWthqbNBTbU74NUFRjmPSzEC6gFOzs/vAUd012eTCtm9H6IiQgUuDt8qewQr3m86lpKjiKfa9ibOUyyjE4w3qrR8SEtYmwDBsBgoCaUvuXFBSyv0x+YKdyjUzwN/kV/J1lZUpTDd89KY44V03PKCyoByCUXOVkASFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH0PR03MB5985.namprd03.prod.outlook.com (2603:10b6:610:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:00:42 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:00:42 +0000
Message-ID: <551fd389-fabe-4e27-98e3-e26c7c516e47@altera.com>
Date: Tue, 21 Jul 2026 17:30:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: socfpga: spl_agilex5: Enable MMC secure
 transaction in SPL
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Brian Sune <briansune@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Yao Zi
 <me@ziyao.cc>, Ye Li <ye.li@nxp.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <20260311050003.20955-1-dinesh.maniyam@altera.com>
 <20260721072636.16493-1-dinesh.maniyam@altera.com>
Content-Language: en-US
In-Reply-To: <20260721072636.16493-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::15) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH0PR03MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e318b84-1326-44f3-d731-08dee71faf14
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|4143699003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: G15zeguDBS4LsVX6uTP/NNGoUVQgi7AXs3IfWb3ioR05EoyGbFVAFLv2vLNtLijgk3YGVMHd9kq9yhBSUH/Hgt9b/meENxVatIwOe8+vL8pf2Pdf8fWooH1PoyoqOU/WAnGDoS6495Yb0u/iBfrEYOmWM/bXi42gFmbYtLVs+fdPb3OPuA2QTS1LfWS6Zm0LpFNbhgUf0iPQdwrA1aijWNkpeBBjyXZQvjZQbjRkOnZ02N+RMoPIgORbiNgqPmO7F4Hjq5FXE4+VVN5fhvbzw4/zsSiqQUkRxdmZwz854fVvUaNT4gawT8KDP+ARqv8dRtPfmTZ5QDOz5A/p7m7IEnN5MbZUcNY02TGlqYWgncEbqan9xE93uQhH2omQYqUyRoLy/cFF3QT8Mu+EKNa5zX11HouXJlakShseffv/cLME8ZwronsnXhE7ilMJ/I3+ngjLJMIOAepkon2+yhxo/ELjdK4dNwc00LCJyansZ1zX7GxE+gBQIuyhB6hh70viFiXhOV4StoW0zM47pDVHRSXuoiZFedU6zQdSdWJYp3vK0UoNTFPlahd1o2ItILmS+aozY5zg0kC2B5P8O+ifKYyt91hc1jY6mot4idvUWkPtJlVfQ2PcKZwcZWm76G/UMWZvWQCHDP7Y4zyJtVkhzfpWwr76BjqPfpsUVKWeisc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVV3M3BXc0xaQ0h6azYzdEE1eWJqL1V1ME5LUDFvNHhHRThOV0lnY1pYOUtD?=
 =?utf-8?B?YmRSRWZWVkdpdGJrMy84cW9zempxVXpzbVFRaWFBdEtqdzBJQmNGYWw0UEZL?=
 =?utf-8?B?STBqMFd4czFOci9CZG5QeU5LdWQrMTJPL20xMmhScTBkZGJYOHVzY1JHbHlR?=
 =?utf-8?B?cW9PeUxwZkdWRHhkZjF5ZUZlNmMrRS9iU1VielZUR09DdUwzYU1vS2IyWmVw?=
 =?utf-8?B?aXhRSEk1MGUrb284RXF4RjVlSU9vZ0VpN3UvRndsTFE3dExmWVlIVWJkU2My?=
 =?utf-8?B?V3N2ODRIWGJtZkQ4S21Sbld1eVNEd2gybHEwZUhPSkpLVUhPSllJWXJ3QVRD?=
 =?utf-8?B?Z0g4UlozOEFDMUIyTm93TEdWSXVYKy9GWFJQV25PeThkcGlJbzUrYTl1OGdz?=
 =?utf-8?B?Tm1nSE45cXJEcFMzU05mejNwWTlGK0lHZEkwSFE2OEh4KzRQNUxWamhiR1lP?=
 =?utf-8?B?UGFlWFFQMWpmTGNqdlhuYVgzRUJkNTFlVVNJTGg3dEp1UlBHRkt2WmdhaGdm?=
 =?utf-8?B?RVFJNlREMW16Y3lNK2N5SU14MGpnT3FjN0VHMEtoZmp3VmpMNHFEdmpiclNr?=
 =?utf-8?B?U1g2eFI1eUpqdCtuUXdZUThPa0FVeTJxN0ZRcHNOb0NIeXJ1ZC9jZllZVk5I?=
 =?utf-8?B?MFpReWthYVVPMDM5bWpUUzR3VWh0R3lGOGE5dFl5OUt2dVpaeE5GN3V6RTBN?=
 =?utf-8?B?Rk1icXM3TG1pcmZTSWZ5YkZNbzFhZjAzUENqWW5ZMEJmVUUzM1pVMk8xWTY1?=
 =?utf-8?B?SldXZDQ3ZGM0RVZLODJ3Q1owRzUzL1h2ZjRHQW9INGVENkpYZ1A0OUZDM0pC?=
 =?utf-8?B?OTlhMWl4S2lTOVArS2VxMXdxQ0xjOWNtVlVURzVqM1EzSHh6b1dtNmw0czho?=
 =?utf-8?B?NHhFT2NkOVFDdGc4cGhVOUtwODVNM2kvaVgvbjVlS01RdWUvSkdSb05Qc2VL?=
 =?utf-8?B?NU9WNTFoOUhHdEh6ZStKWXFlYlh1dS80N1REQ0hSYmhXUHJncW85UlBMdm1w?=
 =?utf-8?B?MGNEWVNQMXVxSFpuMzJxN3dvSGxyYitIY0lqZzBKRTladFdoZzRWRFJnd0hl?=
 =?utf-8?B?ckVsUGJtYUs4T2doRUFHalRyNEtsRnJkNVhnUVpLM3pBSmkrYUoyYm0rK1ZC?=
 =?utf-8?B?SVkwR2FWdnBSRFVpZTR5OFVaTmcyY0VQZ1F1NlRsQlAwL05jUVRxWTN2bmJU?=
 =?utf-8?B?YW9QVE15YWVmRGpaT3kyR1hnNm5pOVRhcEQrYWR5VzIxSnVOaTZBWW1JM0FR?=
 =?utf-8?B?dlBacEFZa1hlWVBZcUl0Unk1bFEvT1RTY2tVSm9tT2YzWWNxZHc0OG1ETUdu?=
 =?utf-8?B?d0cwUzdzUE9FMm1SdGd6N1hWTVJrZUo1QUlKNXgrU24rUmdXZ1JRWVQ3OTI1?=
 =?utf-8?B?L2d5NGI0ek15Q1ZDS0xRY1BhZnRHMnEzb1Zjdm5TTGtINnhmcElpSVRDOFdo?=
 =?utf-8?B?RDdsYUVaREthNllPRzFvajRpTzFQaHlDQmIwK3cxM043VEhZckpPZy9kTmt2?=
 =?utf-8?B?TDZqaHJyNjl6UWpidUlxZHUzLzhCc3Y5VEljSDFvK0xjYTkrUTZ4OStvQ3dD?=
 =?utf-8?B?SGV1bUozKy9YN0NnQ2VoSWQyV2dxNkwxUXVBM1hQd0tNL2lMRDdsOTh3Y3JD?=
 =?utf-8?B?eDBtc2Y1RTBOVEordjNiVHpRNFJ3dFlqYkJKelNqQzJRcTdRRC9JL1I5bFJm?=
 =?utf-8?B?VWgrZnJwUHdhTTNRaUE3RE9iTGEzVDZEaW13SjF0cndpWmpxV3REN1VnUGNv?=
 =?utf-8?B?aUVJdFd3TlErVHpjUkNOdHp2SlVzNFZVcTlvSEdSUW1RUXowV3dlZDhyRE1F?=
 =?utf-8?B?MGhYR0dHRmhQTEs5bjNtdGUxK20wS2tkZlozOVFoNW5RTlcrSndJQWJXTGYv?=
 =?utf-8?B?UDFOV0V2bHJYZ0ovZVJiMjhOM3plRGNGQ2tXV3hSenA0eG50enFSTk55dTZW?=
 =?utf-8?B?eU5FRFJuRzZIZ1hEU2h6czdXdFhWRFF3UDlhTW9kTWh6RXRwcm1WZEtXVm1h?=
 =?utf-8?B?cXlvRFFUTWplbHdrN2E4dlkrUFdDQkZDYmFFM0pJclpLTmpYdDRtTTN3TjFR?=
 =?utf-8?B?YVYzbjh6ZlEzTlpBVGFtQ01SNnJUWHdzeTNDQnZ0bVRpOElhelBEVHNzY3J2?=
 =?utf-8?B?cWJXNkpVaWcyMzN1SVZwMllicEU1YlhXNUdVTlg1ampLaGZtS0dkRS9GRjYv?=
 =?utf-8?B?K2w0dzBiK2JMbjVhbkJidGpZV1FZa3JpWWdXNFJGTjk3MzRWMTM3N25YOFdS?=
 =?utf-8?B?MWtzQitHZXZjWDFaYkM2aHo5TjdaempVZzVpbE9paUd1MkdMR1FoSVVjbTJk?=
 =?utf-8?B?OE9PdGx3NlJrcER3L1VjVHRLaHVkS3ZGSXpLQXR4RGh2a2o5a2JQcy8vM3pm?=
 =?utf-8?Q?bXtVsJDg0VcnJooE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e318b84-1326-44f3-d731-08dee71faf14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:00:41.9295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOOjqYVA/0C4rraUP65m0IXK0+ddTRq5FBRf6M610+tDYvKAzgoJgQaiXNARqrRF+RWMv9Ed74UKRdRAzlLJ2963bRQ6QvVsk+GgdVY7ypk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5985
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCR12mtIg/A0fM/fE84nD5Syqrn36tGDQo6EUZAEAqM=;
 b=RhKH5MbqCUiMAZByp3ouDmXUL54Jdy80+zu5Lwp2dc3/s3T0L6MiCen6k7JKl/sA7dHnN2usXS/ybUjbaUfnibxfHYus6Ct42jfKOC9Y/75nj4F2vTpTgzDeeNNRCRT/D90gaeNZL3hV5bO6YYIMQy755vB5+/hrkq9vv8f6PtsNSYnvuM89ikwfJYTBs3ffrqu6EN9C9q0YLnQlivJh2g4V5bQKc6DsDRNh3haiggKN9N06SaMNrNUw2rssourVU3yMaOVZcQoX70MEoqiXTgfocfei5zI+RbVDoEQ8B7gnNgnOWA1cc0TS90pj9LLNsYgQvTrtarLGaYnq6zQIYA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=RhKH5Mbq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tanmay.kathpalia@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="RhKH5Mbq"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Kathpalia, Tanmay via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


On 21-07-2026 12:56, Neil Armstrong \(Linaro\) via U-Boot wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled so an ATF image
> loaded from MMC can access the secure DDR region reserved for ATF.
>
> Add the SECURE_TRANS_* register defines to firewall.h for the System
> Manager secure-transaction register used by this write.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

