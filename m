Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C5606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1JULMFV6;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=e+PzZqJb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4D5560A8E;
	Wed, 18 Nov 2026 16:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-qyB6ORv7av; Wed, 18 Nov 2026 16:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3D3760A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795017933;
	b=GX3eHrD4J4rGbem5bgx2ZuQS6UftgTbwnp/z+ufuMooiaBG2bOubso9Nhh1Arn5O0o6a
	 Y0F2N5kHrg+KBtMEIj5s54XM1fXinXpY0wJnyxNU4VOzXssr9C3HgX8EiB1t4/Ztl3SS+
	 mXfVFcyQmzcaHYqkRuJ3iunuUplQYvkEQj1FLY3pTlGzhMg5YkoBVnUkxD2YrGauVvzev
	 DFWSuZxPqCxfSNaOAqReJzsB+eldbiblADmuKgVHHb6DhVXBS41AyMRmYMX/5CVhD+9FO
	 8gEfIBUGbk+Jr1OkSypH1cIkqTRDB7LokRcpCJ4ikjv+xXjR4p1Xj84xOVAZRfyZ5hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795017933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=nT6XIek8oD2FXDk2su15OI3M0bXyAzPZwLVTBxIUVt0=;
	b=DcCkcQyjT3X5r8eZUmkzoIs9cuMgTjL+/ybcFiZtuhujgEyvxS21p/NF8pLZyzcWW+1c
	 MteocgJQF2e3Pgn1AUSWbAE8oFP+M4wM6mUCGxe1SXJFRP2Crh/wgAtC3qCUVo4nL3awd
	 A65rwk/hRruqkpdYfEG15ugZhe6V1TeSQReAL4d+1xivgA78xNcuPCAay7XLb/sinThEo
	 nM6+jdUd2JvOhq8+pZkMLSWZrJLiqFF4MIUl6DRmYhbN1HsdF4/PWRSqtCC9TLsIzVkdK
	 3Ikpon4i8mtd8GA+b+2mi840Djej79OmxOf47ahwSDhNnJftCWLzwYj47o9+hUpt6QA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795017933;
	bh=nT6XIek8oD2FXDk2su15OI3M0bXyAzPZwLVTBxIUVt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1JULMFV6Ik8vgsARz25KxO7x9Jua2VMDD5JEogEuqfcap1CLbjwLxC4l1nX5d1SVy
	 imCom4K5UKFDkfhFSOCbpJm9qRdom6KKyiR7STGGpNe68LEdkRtgWJKzIaTvJmOeFc
	 jbjoetqoeJKrnxZIbyXX7HiEGeeFjYsoHh9TyZLR/1iYNrXJy49BTBnBRO/DUQXe3q
	 +f1kS5XrG+NxVnZCXFKQN0YjWTp8ynKq9R2WG5Z/MJe4RcDNH245w4AJLgZ/rOrZvM
	 qYAAUymNsNXzdiQQ75WvlCYY212IXXStC0Thct9E7XSvwkdgIZKdyRr6XI8QG6WdSI
	 IRiBYfEZI7g0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3D3760A51;
	Wed, 18 Nov 2026 16:05:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A343B977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 896FC405F0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9HOLQWxBZbE for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F8C9405CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=e+PzZqJb
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F8C9405CB
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT6XIek8oD2FXDk2su15OI3M0bXyAzPZwLVTBxIUVt0=;
 b=e+PzZqJb7LKL1NVxklhfZlQbhE04nBtP7vzibV/odzdCp82FGINpzWycMRBkD/wqRQJUit2YpQ/+RJOAdCcW8qHzhXuv9dkLQEUVUb6aOGI5DEL3OeYxJEAwz3DnUqLFEC7pYRh9Yyt/e4Wsblp9Eh13tXsjMeFDfN1nQ4X7hwk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB398878.eurprd04.prod.outlook.com (2603:10a6:800:35f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:05:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:05:23 +0000
Message-ID: <e03a2d6d-0d62-4690-acde-ac4da73c2b13@cherry.de>
Date: Wed, 18 Nov 2026 17:05:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Add section about mail providers which modify
 Message-ID
To: user890104@freemyipod.org, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB398878:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d0899b-21e0-4fc3-2e0d-08df458dc048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|22122799003|23010399003|376014|1800799024|366016|261026121527099003|261028144727099003|261026140227099003|261026135527099003|261102123227099003|261026130827099003|261022105027099003|261021135927099003|261021133027099003|261021130227099003|261021121427099003|10067099003|261022075727099003|261022113327099003|56012099006|261022115727099003|11063799006|261021123027099003|18002099003|261009223027099003|6133799003|22082099003|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: BmWHGo/2HkN8CyAHUUgltFIxs1lAo789sv6vfdxu+0g7q5hcywC/4+/loEmmvGrh8w+YGwSXFDRazLpfx3XNtxwt0FpJkGAJ5RBps515Z0lkrfJQJVQxd0ur31SxA30sq7B5NyAhlrdE4wLXPFGIsivK2fFRbcmGzyo9x7Vl3rfoM2YecWOPp/C6s4QNmN7g4rR+o/V/maqcZ8cy8Hv+2M6R3HVxfzHx7iIvdHoKB1Jf5Gmqe8RUGCe9MV/ZXX7uWMUpASW0urkM95NI1ddGuACJ763oU1WJX/k/u6w86/An++oVUc+Kr4f7OwzpD+z/pW9jgYl7g7BUpPr6xhAoD8DeK0n620NWufRez3/O25d7XD+rpb6Hs+TTRPkDPuCLRk6GVm0BYMNIwvMiQ/SfiHhwIscwRaMryq/IfYFhniwJF+IBUM/KKm8WubqDPUoPlZ/bfxAup1EZgVChSqWxr0iXX0pk32XkZXYb7swO3uQkMdXR2y9yDCTdLUogJe+KwiNZMDEDUqnfKjCBHG5wsTcuCAYEz0PggI+cjbNTzhyZ4rBElk01FR31/g5bI/xQaxQcEJJ4eONXDzVzy55hFbAuebkRahTTJSbpDKBwlQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(22122799003)(23010399003)(376014)(1800799024)(366016)(261026121527099003)(261028144727099003)(261026140227099003)(261026135527099003)(261102123227099003)(261026130827099003)(261022105027099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021121427099003)(10067099003)(261022075727099003)(261022113327099003)(56012099006)(261022115727099003)(11063799006)(261021123027099003)(18002099003)(261009223027099003)(6133799003)(22082099003)(3023799007)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZaTitsbElXTEhzSTdPcDFydzNGVUg0bDVpeTU2NVVURVdmTURQcVMxM05L?=
 =?utf-8?B?UnFodUhmblBtRnMrTUZQUUNqMlM3Uzd5TGw4TzJaa2hzVUR6QTBtcURkSnF3?=
 =?utf-8?B?cFQrWUYyWXlraU9NTkpYRkozZGM2Ymx3d2pjQnZsVHpSZjlwUHVTZzR6UE90?=
 =?utf-8?B?WHJaemFEUEUxVXVlcFpRcHY1RkVmVFY4LzlPQzBaTDUxdWEzeXhIeVZBTWhM?=
 =?utf-8?B?NmRTQzJPa0FQbHkzaFdqclo5WERhQmpjblJ6R3FybmdDR0c4VHEvOE1YdzNQ?=
 =?utf-8?B?THJxbUxDd2tBa2l4L1FhTlloU2pmSnFIYUttUklNcUQzVTU0WDFvNlVUcW1k?=
 =?utf-8?B?T2pxemNLeThtdVhTRjhRcnhLbUNyTS9CZTdGQmYwempFNCtuVi94WmZYZUE4?=
 =?utf-8?B?bk51V0k5bHJTeWdSMWU0Y0ZodStmcHFtRzBwbGkrMExZVmhtaDhvSE1FTEky?=
 =?utf-8?B?QWRJdWdzdENtbHJyR1R5bnYzMkVVazVlRU1tb2dDUUp1dHV2V0ZhVHE0bjhu?=
 =?utf-8?B?ZnpFMndiMTZIdmp1UVVtTjVnaWZVd3h0aVo5aFlmakxMcFZQdXJXQWlmSUg5?=
 =?utf-8?B?Y2o4RVludnBDNDI3QkVUTkcwZzJ0SlR3V09uMW9OTUMwOUFYS0c5MmVXZkph?=
 =?utf-8?B?QmR5aW9kMWxqYnM0OUxmRGpiL3Iya2RaczRKWjhpVW9YYTFlZFZDMVlPWGw2?=
 =?utf-8?B?T0c1OWpBUEZmQXY0cEdFbnZiZXN4dzk0QUh0T3RRcTVXS1R2YWp2Q3dvZUhh?=
 =?utf-8?B?b0tIbnF6Y20wWnl0YWNzZStCSG1hM1RBQS92ZWFQNHcvSjFPTGMwK3ZnY04y?=
 =?utf-8?B?YXR1RlZjZmtybm56MEh0R0p4TGFkait3b3Z5Q3dZN2UzQWRxaUhsTjlOclMx?=
 =?utf-8?B?TFZwdFlUak5DZjNxVjZBWHRGNmtiV05pTGJNb200ZXdpQUpMWnNsaWlucXg2?=
 =?utf-8?B?UVh3YjhxMnR3MGIxbmZkbEpxM3JFbDN6eFdsSFloLzczUDk0WXZSYWtSQVIw?=
 =?utf-8?B?TGtscEpFQUU1aEt3Y2ZuS1JVOFVnSldVcEdIL2N1RHVSVHhZVEFaMk9ibjZ4?=
 =?utf-8?B?dTFLbnJuOHpuc1A1bzhSdGoyMU5vbDM2WW9wZWd3Vk9MU0pNUUFlKzRNREhF?=
 =?utf-8?B?RkZNUloySjNuTjhoN2hpdGo2dXdHR1dOMmpJYmhsc2NOak5YbDRjZVk3cVFR?=
 =?utf-8?B?ckRyeUFBdGdKK0JERUU5bERXTCtMN3lhZk8zZ1NUeEVuc2FxWTdSV1R4MllC?=
 =?utf-8?B?VFhMWGxLU3k4bTNlemFnQis2KzNwVVdDQmdybFovb1lQOFN1YzdnK3YzT213?=
 =?utf-8?B?RTFLR3kwUkJIc0lEbGtqbkVVZnZ6akx1NUhiaENQR0pGdkxzTEhzckZOYnRH?=
 =?utf-8?B?SW1GeDZsajBZRU1FVlRGem1yMVJJS2RzZXREVTQrL1NmNGRvajhyYWtCMkxo?=
 =?utf-8?B?RjV4TWlDQklMWWpENy9SeWFyUm9qN1VqTXJlL2NKMzNWS1pyVE54eDF1ckor?=
 =?utf-8?B?MFJaSkV1Z3lpNDNsekFMUFVRQzRWem5zbTlYcUEzYXd1OWJTNGQ1cGZLcUVE?=
 =?utf-8?B?MW5hTmZzNENxbWgyZkh4dmVJUkxQWVZFcE1kc2ZXNENDbnRqclZBRVgrcDda?=
 =?utf-8?B?R200TEpxYlBkS1JybWo3VjBwVmYzc3dDVDVNRXZWaW5mKzhlZC9hSWhURWJ5?=
 =?utf-8?B?UUk5UXdMcTh2dDZhTThJWHBKRlJGZ0ZYeWp6dEdkVTVtTHBkY0NVWGt6VHZ1?=
 =?utf-8?B?UzJyNHR2SkJWUUJ3OFR4bkpGU0JQb3ZMSThpT01GcFdiL1Z2SDF2Y0xFdzVR?=
 =?utf-8?B?Z2g3STdvWVpZN0w1dmJ2eWpUT0pkSk9mUThjWG80cjU5aXRkT1JxZEM5UDJD?=
 =?utf-8?B?QUdNTEVqRGo5b3E2SVlKbDV1N2gzZlg2SnE4RzU3OEtCdTBPSC80ZlFPR0xP?=
 =?utf-8?B?Zmk1L21yL3RIZFhITzl6ekxxK2NxbUxrMjAySTNGZDdWRUNHNUs0RHJ0Rmg5?=
 =?utf-8?B?TGdhQW8zZXJMNVlrR3BZK29pQ1ZFZGhtNi85UnhUL29pa3prNzhscFBNa0do?=
 =?utf-8?B?VXVlcy9HTVJ6TEpSWmtsMVlVQml4akE4V09IT0IvQVg4ZGFBdU85dmJOTXAy?=
 =?utf-8?B?WEJ6VVhRcnVlRkJCaDJ1MkptL3FvRFA2cVVVUW1xdjh3NThQMHEvOE5ueDZj?=
 =?utf-8?B?SWVieDhRZWlMdEhyTkwzWHA0bUR0VEdueG12SjlRZXgxNmFUMUJmT0tkTVh3?=
 =?utf-8?B?VDRmV3ExREFDNFI3T09RNWoxeUxHY2NnZytDcjlsRXNYZ1F3bXZrZURxOWlk?=
 =?utf-8?B?U2M3c09TSkE0dHptSGhFazdzWFZQRWdlby82bVpGR0pSMjNPNzV4dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d0899b-21e0-4fc3-2e0d-08df458dc048
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:05:23.0014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WtlNZz9yUDDmsXbH9bI8TREslvSgnSstZN11aAQHxZSRGwAZdY4n0Fcj8J/RyTzNUuxu+ruStNxMh8VoQp7zLwRfTTDbUSAq1O1H65c3rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB398878
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vencislav,

On 11/18/26 4:46 PM, Vencislav Atanasov via B4 Relay wrote:
> [You don't often get email from devnull+user890104.freemyipod.org@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Vencislav Atanasov <user890104@freemyipod.org>
> 
> A short debugging session revealed that AWS SES completely replaces
> the Message-ID header, even though the API is called SendRawEmail.
> 
> Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
> ---
>   doc/develop/sending_patches.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 99581dc0ba0..e2d5e4b15c2 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -184,6 +184,19 @@ General Patch Submission Rules
>     cases, you did something wrong if your patch exceeds this limit. Think again
>     if you should not split it into separate logical parts.
> 
> +* If you use a mail service which modifies the Message-ID header, your
> +  individual patches won't point back to the cover letter and vice versa. A
> +  notable example is `Amazon Web Services' Simple E-mail Service (AWS SES)
> +  <aws-ses-sendrawemail-message-id-link_>`_.
> +  In this case, you can use the Web endpoint of kernel.org's B4 Relay. See the
> +  `b4 documentation <b4-web-endpoint-link_>`_ for setup and usage instructions.
> +

suggestion: reword so it's not that specific

I've met people who struggle to use GMail, Proton or their corporate 
mail server, to contribute to mailing list-based projects. I think 
something more generic would maybe help them understand the web endpoint 
is the solution to their problems and that's accessible regardless of 
your mail server. I also don't think it matters much *how* it's broken 
(though indeed people may still be using AWS SES with broken cover 
letters unknowingly). I can suggest:

"""
* If sending patches through your mail server is broken, doesn't work at 
all or is not possible, consider using b4's web endpoint[1]. It will 
allow you to send patches without using your mail server. GMail, Proton 
Mail, Amazon Web Services Simple E-mail Service (AWS SES)[2] and various 
corporate servers are known to be particularly broken.
"""

What do you think?

> +.. _aws-ses-sendrawemail-message-id-link:
> +   https://docs.aws.amazon.com/ses/latest/APIReference/API_SendRawEmail.html#:~:text=Amazon%20SES%20automatically%20applies%20its%20own%20Message-ID
> +
> +.. _b4-web-endpoint-link:
> +   https://b4.docs.kernel.org/en/latest/contributor/send.html#configuring-the-web-endpoint
> +

question: is the attestation necessary for sending over the web endpoint?

If so, then we should point at 
https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint 
instead I think?

Cheers,
Quentin
