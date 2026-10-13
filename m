Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9E0CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FB5380B12;
	Tue, 13 Oct 2026 10:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvYtOyj8XvZC; Tue, 13 Oct 2026 10:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 245F080984
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791887277;
	b=l0xiEzylV+wLAhLnlC1sNIaf3QakAQXPN1Qovd+kG52lhtqLB2WVCRhZbSMWUhNbStxU
	 yF+OEUmnTbt6H2cGWSRWJMmfdDQDqUcZUK/UQ75GLmaQCaJVFeKC5MZ6Gx9xrIAG0tFEY
	 m1meJzF/Oxq7lOVbCmw76yIIYtgKBIS4aOuZzHn+LoFuX2eP0F/HZq1sfwV0e1feONo3l
	 NywXIneLhodl7cd7fuGLi9Bh8CavWRXOc2N52FEqAD0vFNNQKVPM7ZtnhkNo3Ez4e5DWT
	 x4+9p4cEMvvCPA02K84Ox7vQK9HzNQbZZLKbuwsf37HTm2KgTRLuLFbB84OJXPq20Fw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CoweQpkBl6o23iz+95AV6Cr/z6CNFzkEwei1oY4iqec=;
	b=A5/v5ooTgvHwH8FbRoQmBWYS1csFRk0n/DlXM2Mu6lm1Li6/ho51LXXaTPLhgeiRRr/+
	 MfUQI8ZUfo0WjdDXkRD43r8obIhWsgs1KaZUJRJVOdR11lzYBuXAgXPkU6lRHLNb7OrVZ
	 f3J2SHym0Web6ks9g4num41hLjprJVKzqfkvmz9NppDFCUfLksPZd9PBHvhSXyej46jHF
	 nQZ26QKonOp8THodv40x7jdiVY1oe98YYImcTTbyCxO9wNpKJxyXcL3jcKnUbRYJ38a1G
	 Ar+ycJKvVamDb517ar6WU6OROrdUjpbGed61p0U8l/BRsIwYcARhTLX75DkkTnAxplg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887277;
	bh=CoweQpkBl6o23iz+95AV6Cr/z6CNFzkEwei1oY4iqec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g85ovebPDxUyEG6c01u+wBpZcG2YVZqYS+BbbNuz6k1R+xudEsbuazD5loBQwYwC9
	 OJa8jLbyqhJGCqgTKe9pwKfLDnOaeCBxVr85ABsv/5DcQteuwEt+pDSdW34wljpIxA
	 UJaFUDK+7VSbypvmGpCH3pSHsySwF0LQ6fYOKAoLF0cT+pJZOdHRqLeoP4Q/ntMMgq
	 djIu5Z3tbyhh2aS2Y+DAhe/f9MubRtNiNXs7WSH+GPS0jkg44j82cpx7RGwr9iCW/v
	 jYOy22A6wNryNRRCUdOG3j9iW3OTAEx9tI/KEoOOACYh4xDYJkO5l1mdQVPr+/g62B
	 njot52SRSniUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 245F080984;
	Tue, 13 Oct 2026 10:27:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A192BDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F50E40277
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0EWrey0P9WGC for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B54040062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887275;
 b=docMVGCapytEBt2dXxEEeotcOqYktfMb1lYDZQxvn1OF7ZWm+2+YdUjnB1+nLdBK3O+f
 hCmWZf7aaZ4iLUS0zPG1CYwdAaCDQ3HE/Zifg4ck6PlxCPVdIl1JEGa5f/IV7ZuVtW04e
 oMArbcGZWTNVvCAcqA61ZmstUz1yLEQrdqSaCugoohjr02AvdA0kg3Jp/VYYS8OGPmsdY
 H7IyAZ3ZTkzpoYisup8Y5V2akaLmQqM09F3ACUJtGyUL1z0neaCQ5Fo0nqcuUtbph59mR
 1lw6rVelVt/L1c/NcSSLD/jeqhRoizQMJBx9Ee/oAZBiSBgpKWBBRg47O62TGeQY+BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887275;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=CoweQpkBl6o23iz+95AV6Cr/z6CNFzkEwei1oY4iqec=;
 b=In7KTeHlPSBk+UjVNqTVNIGcIffeUUnGRQvdwRw1L9bw/jyuJg3aRXupltTp+rrZ4ICW
 8aGRAZ3/jw3HTUtQ0sV5zw2Qml9HERA4X4Bo9ObNzirm370PXSTML2qZ82OLWL4g5EXbS
 NdhNyt+yRv7zSnsl6uppRDjBldzbrZpSg6mqTHxDn6ONbW5zk+DIRj+mZ4O/AJQKQ/yzz
 p7Kw8E8bBRHBFipOrpT2UDCjpVFORNpL/wdPVt7hFQwus4LEI90g216YsLSzAskUPdv+x
 savkYPsKx8cq2+E8K4rI4otUhAzfEX5/hQk7Zh8RoKS8jJt1BgNhZEaoCmRD/d47riQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Gg2oHisQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Gg2oHisQ
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B54040062
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK8jLZ0/Q8UiNpn+eErh3RAghTEhvSFJiPaEBDR3SVzS4aqtZleCNYMud6SbVjFMnZEAr0bfyo9mWQkVwO91bt7ljhTbqXgYXI/Zb5NTh0z2piTgpT/wDATOCef9QSAG/yffQtUCP8/4F9Y1RXNm76lKjcijOQuoeokWIXuax9Q56JvFLVAkrro2MP/9ZQ0f8yu0lF4TZb3/DCuTWGNAE2Gy92FX/M6g9uxMmYnKz67a+YFI//WO4Re1SxI581P4PFj7kJ/RJA+/T3BQm7ZqXZTF7UiZ21wjraTL+BKmh34UevLEuNh8+qDPBLoNJH445HEJ5/rHpQ6n+z2Z/k48JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoweQpkBl6o23iz+95AV6Cr/z6CNFzkEwei1oY4iqec=;
 b=pZ0PKMCPFphpXzCdt8bo7vz7QQ1a3in/iclTacSeHveei6XHUjxAaFqxz88Abo95RlYhBEYOAZwn3uValHW3dWOLM5ex6eCjeMmA9Kfagkvuw9nDVsvY/ArQjXkXvphoIPXdnGnqTTTMREE5wGfYZuwWsC1v3N3zSUKjOXEFUGjIYWwXeYfA7ttbOePQXPpsoBuMnedFFKL+MLbyrVJTqnXfDGK+FAxgTn4EbJoNejQsxQywOKs48kB3hn149sPW/fSqJkDyeVA45EdYSf0qjjfZ4r5QH9b8QfbH3Ua1upQ2PT2C2FBkN7V54JgdJgfJuYDPgZi5E7g8Qiww35BMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoweQpkBl6o23iz+95AV6Cr/z6CNFzkEwei1oY4iqec=;
 b=Gg2oHisQWN19cb2l1gn21b/y3kXFSDfx6R0ceS4SfeJ9HGluY+/KQ24eqRlZDich3mL/ZClFkQDOaWDpInD/85KNVLdjFb3rfsxzdYMl7G/IWED062/VNMo1JcXbM467hsgf4liP//7T211eHxuHVQElvr2MOfIvnkprfQ01CzbKGWfRY9tOTopcB33EjHr8WAgjCSQ3KIMjZzoCDaPCF2wOwo6BQlE+bZ+K4yN3+JhLU/EEfpxeQng9q3X9hbQarx6qxMz5JbGM1vB2a/W4UNpulPhbbJTtqz4RDuxJm8j+QnABwl15tfxwLq9EQ/AcIt8FGF71n5RB9LWJHzxC+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6643.namprd03.prod.outlook.com (2603:10b6:806:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:27:49 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 10:27:49 +0000
Message-ID: <67e67aef-bc2b-4722-b55a-e3e62986fa32@altera.com>
Date: Tue, 13 Oct 2026 15:57:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: do not time out a command that has completed
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c16884-58b0-4ecc-a45f-08df2914a16c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: IIHU6NqnoDobsJYltZwLaMkUfvo2jPqNdhTUW5Ty9VbibKt4QSrxz0YRsg2D/AYioqvaObddmfgAR4jc87BUU55AeVuuREzE8bsMER18aqL+PyZ3MQg5zhepTd/dP37MHZ7rZnp9ObTbLrtxqLCmLoRvwlIBV723bJOUq103wXqwdu5j570yJlwsAPNrQp6NgQ1DZRLbVP1HvcWLY84DEZz7fe3blpg9xf8c77D62mCnGFdgAXwOjfpQQ9NV1PnohNY70+3KznRwsxi3VKdLxojueNTKDbEeqR4AUhSZNEs7WlkYzU/GLEgNRD6bArS98PJq4S7954WOaSzseRoxx7rJlupahLGaysZ2mqkcWIHE5UGOuPEZjV1ixZVE2KaoR9pkAfNvBipA5XeOR9GGSTGbAif+LTGxHE1yF7wEd+dOMRwIR9rK/Ml/QI72c6T5rbKU7oezzfYHEr2oSosO0xeTUwRYd1jvtbcMJuecJ9zglmcNd8r3/j/ahgkV6pxHmNEbkoeJN78CIRj498mqzRp79fh77kK4uRqf7kNoH95NYa8ZheeUugG5yG2Cukf2YklSrJM3YTzDnPRzBvRQnXXw6inXfWa4vlJXHvmrFbeaNpAQYOnLCPx4PFTw6bermIcQbD/vJ4Qj1/c/nevo2zNmZzQOX803xI09vRKJcfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzhwb0RGMnFmR0s1d015V2svUGdHVUE3Rm9iRURYdCtqcnNNWmJhelIvUEIw?=
 =?utf-8?B?M29VYUY2QlZGalM5UEJWRjNySEhnM2I1ZzRZK3lQQkxBdHVQTDljTUh6QmRC?=
 =?utf-8?B?UzdXckFVMzhJVlhMWElqeWFLT09Md1dTMTRlMlNaNlk1T0ppaG9hTVcyYWk4?=
 =?utf-8?B?UkJjN2JCSXk5OTNhN2pheUJFYVIvMUdsVEpUVWFZYkIyRWhNaWtneXJIY2ZX?=
 =?utf-8?B?bGFSWGhmeTd0YTNEcUlHdUdySFk2NFU4UnFoSHBFQ1lNSmNkNlFaTDdibWxa?=
 =?utf-8?B?TG90ckdiOGtZcjl1anZWU1A4bHE0SWU2WVdsemhjM1E4eGRab3JFbmp1eGNy?=
 =?utf-8?B?VVVscnh1bi90VlFxVk0yRDROVkVkQ05yYitWTVF2cGZuMWYvR1Rscm4xUm9G?=
 =?utf-8?B?ZXQ4VHR2T2VBVnE0b3ovejBUcFBaZVZFQmMvWGF2R0hUVzkrc2FFeXBQdjJP?=
 =?utf-8?B?cVA1RUxKMGVNWDFqSVVPbWgzOVBacVVmaDBEWVRCdDloTnNPWTIwOWlmYWdy?=
 =?utf-8?B?aE1XdmxRRUlSQjUvVlV0Wm9CQmg3aVFVMTdXVWlCaHFNc1pTYnFENE9vNCtS?=
 =?utf-8?B?bEtsMVZhTEduTUJHdEZ3OHpMM0ZCUU40U1cyMTIwYmlUUCt2am1DWWRRQmJV?=
 =?utf-8?B?VC9yNnc2RFp6cGF0VGZad01oUDBqUXVOOURpZTRXV0Q4RS9rYWtpUG1JOURS?=
 =?utf-8?B?ekdaOUk0dnVKV25MeU14SGJsLzZHTEVydTdOcVA5VWVUYTdaSjN3dGxNekFa?=
 =?utf-8?B?Mk5iZkFpN3AxdTZ0czZ0NExyWFMzUmNFZXRhTGc5T05wdkxkSU9TRXVwUjBu?=
 =?utf-8?B?RWtIakNyOUJGb25yRjFBZm9DYlRiMm9JQUhLTytFTjFyOEVMN0ZkdEFDZU1q?=
 =?utf-8?B?clVoNTIwemZmUm5WbDQvekIyeXRiajJjVHpyaXIvQXVsWW1EVDVZeDJyQWNr?=
 =?utf-8?B?L3VkSFVtK1MzekVPT3RBRGJISHpEU1BraWZYOXRrQ2V1Z2Q2ME9lNE9saEMw?=
 =?utf-8?B?R0hiWWdQa2k5eHlTZ1FmSk1JVzNmVjd2S3NKUkpnWUdyTlIwd2VYZm5WOGc2?=
 =?utf-8?B?OXZ6WWZiOThRYWxrK3RNLzhjREYwRHRBMnE4VE1xRXpKcmhvYWpoakptU0tQ?=
 =?utf-8?B?bVVybnRTZ0JySTRPa1lPYXV0NUc1cnhmKzJLV3drdmJMdk1CaUVSMFNvRVRh?=
 =?utf-8?B?U01WZzNCTWlXUlRrVjFJb0o3KzZtUExudktnZ3I0TlQ0ODVJYUUzNkhQY2Fa?=
 =?utf-8?B?NTFhbkZ4djduNGhBTE5pQjlJL0RieElUWHhjQlRHWlFQbEsyYWtReXVpd25B?=
 =?utf-8?B?cWxJOFg5ejdEdDdWK0czaXhrMHltNGVUdFlIRVpsTURkSXBLMHFpNndLN2Zl?=
 =?utf-8?B?ZEprUkJML1BPUjBZdGk3MHBLcDVudTRoekFNc1lMZU1jTVNNMjNLSklNeTJ3?=
 =?utf-8?B?OFQ5T2NrL0loQzFYdVlJTFZBUWVKQnp0RURjYTB3ZlJLVXpHTjh1cERRWHlW?=
 =?utf-8?B?d05FcHJ1R3NXWlNhalFLRUlELzVIWUVQRDJrOEdPSjkwY2h4L211cjI4Y3E1?=
 =?utf-8?B?MGFXYSsvZW1vWDNDMHpYbDZnQ0RES0Uzbnp4dXRnMmplQnlmcEFYOVNUZFJD?=
 =?utf-8?B?SzF0R25jT0FSZTA2VU1zZTQxb0J4UTlSY0QybTVBV0w3cGhWZ0c1U3hmclkx?=
 =?utf-8?B?WTdmeVVlNy9yUlQ3UXNlNDF4TjI0OVBqb1lmS1ZLTko0ckZ5cXczN2pnN0sz?=
 =?utf-8?B?WUMrOXNrU2dFWHJDWFJhcDZERFJubTY4S2Ryd1JFSnNHRUNtOTZTWTUreUJo?=
 =?utf-8?B?eTZIeWNhNndWK0VTODJNQ2pWM2pjMWtkM3RUODh1S0x3V0Z0Uk0ycmdlM3hn?=
 =?utf-8?B?eU5pMmc2SWIzWkxabCs1bE9OWGlnTlRiVlBDNVFvSFcvSzgyYy9VU1ROa2N0?=
 =?utf-8?B?WVl3aHNHSVRaVDhhcFFUSnJpR3VxZC94U3I0VHZ4NkJGYlN2WEM0dGhPVEpu?=
 =?utf-8?B?eWI1NHpLUjZZODFaRUR5QkVrbjFyMzBmWTVFU01hblNXSDZKMlRlVDdNRW1B?=
 =?utf-8?B?anJtcHp2RVJJWU5CQnptUTBqZjhJRDJqUStnMGJ0QWVnWFJVOVJPVkZyVHNj?=
 =?utf-8?B?aWd0WStPQzZRdUE1V3dHZ0FJTUN6SWV0WHBMMVFxRXpBQ0pOa1hLdllxSXlD?=
 =?utf-8?B?TFVRMlJLSHhBZW52bXBLZEJnYnFiT0FqOFJlY1duY1VodUlZcElsY0NYM1ZE?=
 =?utf-8?B?TVlwWUVPWmdkamo1UnN5YmpWUFk3MUg3WmNjK3FERXcwd3pRdmdKaWhRa0I5?=
 =?utf-8?B?UFZIcWJiaGxnSVoxd1pFRGZ2bzRUeVRFb0kzcTNWTFdMckJOcW1zQmVGRGpR?=
 =?utf-8?Q?sYH+9xVjk5Ur5hiE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c16884-58b0-4ecc-a45f-08df2914a16c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:27:49.7945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga4DRIDj1qplk9kNjH3dJy+zMdSyNCqy8Gawi3vleevx2OPlY0xllLZf3e9cxg9wNXIas4aYrI5KfOdSA33amkDhX2kxYCdd+bRhr9bHes4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6643
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


On 11-10-2026 18:42, Igor Opaniuk wrote:
> sdhci_send_command() polls the interrupt status and gives up after
> SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
> the status it has just read. When a single status read takes longer than
> the timeout, the command is reported as timed out although the response
> and transfer-complete bits are already set, and the caller aborts an
> otherwise successful transfer.
>
> This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
> runs in a timer callback while holding the big QEMU lock, so U-Boot's next
> MMIO read blocks for seconds and the subsequent command appears to have
> timed out ("Timeout for status update: 00000003 00000001").
>
> Check for completion first and only then for the timeout.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>   drivers/mmc/sdhci.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 962a99cd05a..916c7434bbc 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -306,6 +306,16 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   		if (stat & SDHCI_INT_ERROR)
>   			break;
>   
> +		/*
> +		 * Check completion before the timeout: the status read itself
> +		 * may have taken longer than SDHCI_READ_STATUS_TIMEOUT (for
> +		 * example when an emulated controller performs a long DMA
> +		 * transfer while holding the guest's MMIO path), and a command
> +		 * that has completed must not be reported as timed out.
> +		 */
> +		if ((stat & mask) == mask)
> +			break;
> +

I think its better to move this below the BROKEN_R1B block. For a
no-data R1B command, this now breaks out and calls sdhci_cmd_done()
when RESPONSE|DATA_END are set. The quirk currently returns success
directly once DAT is idle, without reading the response.


>   		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
>   		    cmd->resp_type & MMC_RSP_BUSY && !data) {
>   			unsigned int state =
>
>
