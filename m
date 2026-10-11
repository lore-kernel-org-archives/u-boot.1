Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FE0CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 19:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1DE80CC5;
	Sun, 11 Oct 2026 19:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLO85_R2HP5e; Sun, 11 Oct 2026 19:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85F1F80C67
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791747715;
	b=ky5hLDH7Huu1gKJpMNka7+6wZ1KuXOfACskP8jjE/hqY5SLiNSiMlKaCbM5UOz8wvKaD
	 K5bIY+NnJxBET51LyaHym/VBbNU4hHcsLPeWmiJMp8POkiTzA2FTDMt/SRJlsWI0TZmFb
	 esB8X08khfZ7LKX4UbciL0qrtYMVP2cTu7lRlyDQiJpAGDE8NpfR9XrQXc0W5Ipw7CuGU
	 ax0h08cjOuTVWjLoafupXcAmACJ52uET+P14eXnh8H+5/+hLw2I+kHkNNiFwQ0xlk6Q6c
	 ZrKKSjAUuikSVNx6qfF70GrA4owRPlgMFte/60uo/ADU08/rIPz3cObVoFwwReN23HQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791747715;
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
	bh=D5kyc5XkOW8PzPGC7CTtyAS6CaHT0DrA09OeA6sXuy4=;
	b=hvvMFVzzQ/Aeueu/LED30CceRpIPtpLQ6yY3C6Vz6YaZZbBmD+rBAP06gnNLjPdEFmtL
	 eFA13H6lgJMIh8xgQYQS6jbuHVva795UoINMmMVT/HGvVb0orALyk0ZLqUtu5DaamtaVj
	 acR0oAqmCEnygPGyChm4yzLLtODWlIEd0WCzOVOCmt03efbJ2fx+dOrYdPgJOpuHhX8vb
	 8faSUVuFzHhxrCA5NyDvSzAHe782nzR5j7ye5RlNlO6PdqT4KI1JPDCNfhiiDQQBi5M5p
	 T7OylTlwHbH9uOm2f52YtFUs07xO+jsJZYv+T1FW29WbDrajnAJxU9y1Ef0C7UV81IQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791747715;
	bh=D5kyc5XkOW8PzPGC7CTtyAS6CaHT0DrA09OeA6sXuy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfT/ngxHv181LySQ39RTJDRn2FXNtzLljdNyT8HUKb7EL64NSFtQ4OevozNK/QG/2
	 arE9zLmnKb8WWFE6BusSkjD+Pjy8iZbXNoIBjiUGAQCzkEquyV/l8C8oJeUKL9aJjR
	 +AcuufgxPTKOjN4enA96/gyQnGWKUtl7L4py4kfzxadsbPptCBs4AD2lMk/DsJb5qS
	 Jf+DE+jUmJV7P5xSlVoT827VHCyu0Efd+y4xYEiVdT67GIDlFGFX2n2krZrTa3OeXB
	 Hk4biXodk983W65oz7yOxjCahS5XlyTkTtBqIEDy4J8HetKjPlq3DrFcwSVZoxLOY/
	 KVNgGZCR7InGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F1F80C67;
	Sun, 11 Oct 2026 19:41:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07E2E111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1F14405B9
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id on4b0SO6awgb for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EC0B405B1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791747712;
 b=nCwSRGzuJ+u4H242j7XoqGONoS53uJXdBAQI5LSu5A6SEnp6aDvP5QBulud7FlusW9pn
 U/e7AxSVnkVF6fwVC/a7WwjmwNjL0wTYZePYbMth338huChJkmX4HQzDfCYdQPQ8y98Dd
 QVjiktIBCuND+6eKNqDqECAn+eD2CB+9oqW3/kxabNoyQlCi5B3kO7wUNZv4+R5xKjNwQ
 8mzisTvdygpLL/awDZFcS+VtJQ7GLuOcm20KUdi1Y+PVmfUX66wjou1CPYQHNT5Ovevva
 U+jhZBZ6isUmRyaWn3ZMkJlc8RrbNXv8gNDC31fQIbeu0HNuDeqpRDxnVlFMvSM5XWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747712;
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
 bh=D5kyc5XkOW8PzPGC7CTtyAS6CaHT0DrA09OeA6sXuy4=;
 b=Ib0xU7kO+SigAFOtumt9+S4Sgxn97DxJDumNfw5UBFrHeDkmZ1zT+MgVXHdew/3E+9gi
 aGZIu04K8wON+CsufBpqdKHLMwVYsx2TGO6G5nUb+VgnmAtJkK2+VbDQ8HUEw8mcIPevQ
 Mlo2FBChuORX+tei9gjl99kN/bmNFJek7DjIiJNyetm+pFvZU33DXcOebHE/3P6aYgt1X
 gvcBbkrdqOxlvepY2+AnfGvuyjAPuk2Pf+wtxXsbZq86kIu5fRHQnCGx1dmiBxp/mmmLQ
 aAB/AVkHv0D1R4GJoLx2ZZhQ/lT/p6CaD1MWwJbUy4MuC8kDMIsoYyju9bLIyeSXLbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=YSs8Nn4c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=YSs8Nn4c
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EC0B405B1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzA3zURtayMQ3BDNvoJNFZH+eKxQ5cgAQuKr0L6XCfIv0IIqZzexJDvwxFTbSr/wm2j52TyDGJdyXl7OOeDyDs3m9+dq6N+W3XbPRC9IBDSr1GYDesFt3bCTKWK/kQn0wLmSfbN0bAuDZXVmX3yCbiyTd98J9Nlk1gOkw1h8Y0gWwt47sKk6XUc3RZsQ9ZPSZDhvoyLqycO52Jtrajb1i/cU94kiiVmd1+m3lctmP8xhwLVh7Qb+SENIwPBgkWADGd4zHj9c3/tkMToJSvWPfxtvVeNSvNZ1kJHcOaERAJfOPhG2gp08AFYyGh5O44egujWBtPq3MbCN4POpVGffxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5kyc5XkOW8PzPGC7CTtyAS6CaHT0DrA09OeA6sXuy4=;
 b=CGrBHC1Z3IXeb3AF1P5bkiJkX4m0jo6OJHBkjNhoNvdtDPNQ98LaIzGa6TwH8PHzh/v46wsGnMeIC61o4lsdve3Ur8vIY8waYXoVWolbq4kVsSf+tkfSb1+/rBCu17MJDMCc39Kx1HKjEF91ywMIS6hjucUAofUXGHhC29UQdwnWATqPgGGLNfv0znqBP5xYnFWFXMGXoxX8M4o4B57QvRXF2QIOoOCsXIJ9xpnKa82cqMI/k66VKhTJ6IfrXvMSLJJu3CqdvMkrBbiIv50OdFldZIineKB6MqfF1hoNaHMSG2qYPtHCx1I/Lu3SZoB0VWVQP56C6LMJIIEHUmG95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5kyc5XkOW8PzPGC7CTtyAS6CaHT0DrA09OeA6sXuy4=;
 b=YSs8Nn4cEpM/5axEy1EP0VDhwHVoiqpYAuAxWGap8SwRB5YJwD29ksQ4MOxP4fUFgvrvGbIIw47Wa3hwQ/TDI6d0BQzLA/StJrhsLf3HdF6m7te9wEotbXxb0Hwb2gRplMDTfF2ZoXThYuSTBOx0OVg7hXpOZONZZvkxMIB61momkFAy5CRdQNtz6ctRsz3x2vYo4HqpRlFMX0z//7SGFknOGCjpS8AOxYsTO1A2o9Z3n/s59VS1ImAbz/epolnKFzMMXKix76yQa5YKmdn17RaTagaOM/gozNPCaREgW0Z0whrXV62bV+iOsYtKST5xUNOQxa8PF83Ls/QotFx/fQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA3PR03MB848189.namprd03.prod.outlook.com (2603:10b6:806:524::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 19:41:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 19:41:46 +0000
Message-ID: <2fdcf092-88d9-4632-975b-1d0405dca0b0@altera.com>
Date: Mon, 12 Oct 2026 01:11:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Anand Moon <linux.amoon@gmail.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <CANAwSgQ2LqXxjn73OYt_jZ+LJ77OvEf2ODp5sKi5yjQrBs+D1g@mail.gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <CANAwSgQ2LqXxjn73OYt_jZ+LJ77OvEf2ODp5sKi5yjQrBs+D1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA3PR03MB848189:EE_
X-MS-Office365-Filtering-Correlation-Id: f09be05f-2800-4a8d-f733-08df27cfaf6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|260925021311599003|260925022911599003|260925021911599003|55112099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: eyHL+BHt91pOvzERqToEp5yXgO/BUjg39ypO1xKgc5sPukh94qOY5CNFaUUsQC321T941b8/S51afmkcN+ePbe2YlztYQruA0YlkUNLqKSdsg7tHc0Yd2RyNScEDGR+sD0oMnVu0oeuvOXeSx/MEffvpF/U0RG+Va6vsLsaNscgg7RFXtTCK4wyNqIB8Z0hCJo4UYK2GN9MG8CCTqnqPUvMBV7F95oTzp0lh0/UyHUrCOzdJmToPc8KR1f32nvMlgneFyhwdgv2+ot4ykDyU8jifH1k9fahDxjIRIoBLRbpcWlbOf8mBH4F2xcEsoNFnJwvsV1Y1IZUEGT5Z09JfCDXW078jhPgm7QHBA1Bv4Ct4chsqFYuzlt4aNud6FxRMVh4DZyFE4tjEmSPLtUgKaP1h0tr8i3xAlZMBNW8iYSLGcOx15GzQEQ3s4J/fljXDfRJYaHnJAJnMh4fW0MSPTm1+p2hvskwFyCaC/D1zadwPcburk+LOs/l2kAon/I14dSmVqGHi2DHlZ+9MSTFDt7p0ibo6vwLGZYDW6nLPqxJBx1VmlpSjfcuMXOUsWvlO/AJgRYP5HUmSbHFO4zbbrdXJBQWkWwN5f+1jAlsOBLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(260925021311599003)(260925022911599003)(260925021911599003)(55112099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtZendYS1ZTNHMrME8xSjRuUnlGWjlVUjZZY0FjTk8wNm5FVUtyUWVFMHNU?=
 =?utf-8?B?Ry8yR0hrY01JS281UENPZklKSHcwYVlNL1VpaHNQTmdrZmExb3lPMExKS0xS?=
 =?utf-8?B?T1h4T3lyd25xdjVnVjRhTEFEOWRJSTlxdndjbmNiNXVxZ1ZRaVZGRmxxWGgx?=
 =?utf-8?B?eFEyU3Z0Q3NNU01jM3FXS0tpN0QwOEcxVXNaWDhDMnFOSmhkTEREaVBCbVJ1?=
 =?utf-8?B?eHg5Y2FEWS83NVRwUExtR29LYVNhN2pIdThLVHR4b2F5bkN2UGFwczc1by93?=
 =?utf-8?B?bDF5cGgycElsSHZyVzMvVVV4Qkg4akJjTnlrSGxTSWZ4Zm5VRnlzaUt4dEpB?=
 =?utf-8?B?WXcwelpPUm9tdExSYVRSZ09ScUppeCt0aURGa0lSU0JqYXVZc1l4M0diTk8z?=
 =?utf-8?B?V1dMOVFBNFVKNmZDZXpuTDBpem9ET2ZkVkFmQ1VlbzhkSHZRcHJoUW1UUVFv?=
 =?utf-8?B?L3dwTEFaQmNRemRwbkNUQzh2MUMvbWxZNSsrKzJua2liWDRUTlpHZW5IYmpV?=
 =?utf-8?B?aFhvRHlWb1kxZnZtbVBoWXVVUUp6cDM0a2YwNGFxZ0VZMFRDc2dxVTgrNHIr?=
 =?utf-8?B?K1hmZDFoUk93RzRYbnl6b2xFRjUyYi91T0Q5bkxJOEZKeVhMa2lqREFXY1VJ?=
 =?utf-8?B?aktZNHdkR05OVE04VnBvOGJuamJyYUxrc0FGcjNKSDRYdCtpKzdRaUVBQ0pz?=
 =?utf-8?B?RHN1WkdJdXIvTWJ4OG1JcVB6eGsvNklEQ0tDK3VQV3BIa0ZTbHRaZWR5cVZR?=
 =?utf-8?B?b0EyakJHdWlybnB4VUMvdVJaOHdaUC9nVTEveXFVZXNSNkdybUZWZ1l5SnZU?=
 =?utf-8?B?N0dJcFY0bTM0QlRUQlBNSFNqWElXdVNGTnFKZ09iVUhvdGw5Qk1WM3IrQVpn?=
 =?utf-8?B?Y2d3eEtucUEvenFJOXM1eE5FUElaOGxMZHN3M1pPLzlTcDBZY0tYTTF2TGNL?=
 =?utf-8?B?b3FDWDRZQ1ZTOHIraEgyT0pycjNPWGQ4NGZtSVFUYXdBSVRUQVJpcXpraUxj?=
 =?utf-8?B?ZTQzNUhZRExQQkpPQng0V3plSGFYNmU2Sk1hbnZQRmlBZW1ieFh5YkQ1Ui92?=
 =?utf-8?B?OFJidnpjdHdnMWhBbWFsajlIRDYvbllIME53cEpQL0daZm01Vmg5OHdXdlBw?=
 =?utf-8?B?SHRsZ2I0eHdDcVJEVVBLVGpIWlBzam5ZWit1UFF4M1NnbGFUZ0E4cUJUUTAz?=
 =?utf-8?B?WVp4ZEtyOVdYM1dnaytSUUdGeFdIbXZFVktzeHlGYkx0WkRjUjd1eXZoM1pM?=
 =?utf-8?B?ZGxvczFKczFVTzVkODliRENZb0FuNmpCV1VmQ0x6OFIwS2JmZXcrMFlTcHhL?=
 =?utf-8?B?V2lGd2hyUGlMd055bnIxSENVL2xPNVdQV0pEMFFJRml5cHcwdm9uQ2tYMTZs?=
 =?utf-8?B?QloxUG1IL2Vva0pVRGRPaWxjeEgxcklDSWF0cVgxWm40Q0E3WllKWERVUWh6?=
 =?utf-8?B?Q2lYMUxvSjhFY3N3eU9RZUlNNVB1Q1pCQmhMOG9HSE1UbzkwcVFoSEJhN3FY?=
 =?utf-8?B?ZmoxZ0NHTUN6enhSdGhOa2l5ME5WTlBGb0RKVHFOVFlTNXZ3Nkx4RUE3ckY1?=
 =?utf-8?B?b3ZhcmV0NUF6K3c5YS9rcEZvTlF3b3JOUVUzVDd2RURqdWI2czNNV0Ztczdl?=
 =?utf-8?B?aEY2anM1Um1vcnV6aEU5SEE0WTNTSzJsZnl5aDJOTnJLanBwRmE4bTcwK0FT?=
 =?utf-8?B?MzF6S0hGamNaK0dOeGxjaStWdzV2WWdZZE43a1FVanBHSlRIR0NFdXVmRGZh?=
 =?utf-8?B?MWVzUit4V2E2djM5STQyMWF4T0loMzE4QU1EQkluaUhlczlnRnBBNVVmVnFm?=
 =?utf-8?B?Z2NtWmFXWFNSMzVDV3lic1FnWTJkdFJUcEptd1R0UWlZMlNKNXNwVHRlM01S?=
 =?utf-8?B?Nm5YQVlLQ05aMS83OVBaYXlUZXFsSGlYZGRCMHVVazNFUFpheko0WDBIallO?=
 =?utf-8?B?ckk5NzBCclROZWROSUsvZVVzOElYaTN1QU5QK3U3NDBGUUtIMjFnV0lISVNj?=
 =?utf-8?B?S2IrQkxxb0xvOUZnWUpzd2hXOEh2OHJPc21mbnVTODlQdENvVE9pRFBEekNj?=
 =?utf-8?B?a3U3a0VnV2RDeTdLWEJ4NEJtUHppTlNhQngySDBiakJCQWVJWnRad05Pc1Qy?=
 =?utf-8?B?QjFJTzJQZk84QWxHU0l6VENiZFlPcnBLMUJwWHZDSlRCR25TRTJvMFVaUU14?=
 =?utf-8?B?UTMvU29maFJ0Skc2UExKNXZFRUlQRE5HenRzME9VZFg1dEZlQm1lNndiQmIy?=
 =?utf-8?B?L1R6cVcvcTg4bk5YV2RScFkwTng2dUJUMTl4cThXTTdBSjhlK1B0QndwMkhC?=
 =?utf-8?B?aWZVRFVyMTRRbzQ0aEdzekJKV0J3bnltNDRDVm5YN0ozYVhROUVBc0taWXE4?=
 =?utf-8?Q?rvuShnFFnMk6ySGc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09be05f-2800-4a8d-f733-08df27cfaf6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 19:41:46.8145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov/Jp2d+RySuuvgIZxu+IWtJSxjO6zk8hz+v7wuGlwyWUhsnhe6ZSakaCyOhdt07XUZBva6MeDx10HGmLseLk4YF1PRgOJnjawonOutoaCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB848189
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


On 11-10-2026 21:03, Anand Moon wrote:
> Hi Al,L
>
> On Sun, 11 Oct 2026 at 20:07, Kathpalia, Tanmay
> <tanmay.kathpalia@altera.com> wrote:
>>
>> On 11-10-2026 09:08, Zixian Zeng wrote:
>>> On 2026/10/11 03:16, Kathpalia, Tanmay wrote:
>>>> On 11-10-2026 00:32, Kathpalia, Tanmay wrote:
>>>>> On 10-10-2026 11:47, Zixian Zeng wrote:
>>>>>> Hi, Dave:
>>>>>>
>>>>>> On 2026/10/6 02:01, Dave Klotz wrote:
>>>>>>> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a
>>>>>>> single
>>>>>>> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
>>>>>>> separate commands. The controller handles multi-block PIO reads in
>>>>>>> the
>>>>>>> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them
>>>>>>> through
>>>>>>> the v2026.07 and v2026.10 trees.
>>>>>>>
>>>>>>> Drop the limit and use the host's b_max.
>>>>>>>
>>>>>>> The merged v13 cover retains the v9 changelog entry choosing single-
>>>>>>> block SD reads in SPL. This reverses that deliberate policy for the
>>>>>>> recorded RV2 SPL boot use case; no general multi-card reliability
>>>>>>> claim
>>>>>>> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
>>>>>>> CMD12 after a multi-block read rather than requiring CMD23.
>>>>>>> Additional
>>>>>>> card models, cold boots and transfer-error recovery remain required.
>>>>>>>
>>>>>>> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
>>>>>>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>>>>> ---
>>>>>>> Validation: unchanged executable change from v1; exact-base source
>>>>>>> replay and checkpatch pass. The corrected combined integration, with
>>>>>>> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
>>>>>>> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial.
>>>>>>> This is
>>>>>>> an integration result, not an isolated test of this patch.
>>>>>>>
>>>>>>>    drivers/mmc/spacemit_sdhci.c | 11 -----------
>>>>>>>    1 file changed, 0 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/
>>>>>>> spacemit_sdhci.c
>>>>>>> index 6488ae0fdb..4284553177 100644
>>>>>>> --- a/drivers/mmc/spacemit_sdhci.c
>>>>>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>>>>>> @@ -324,16 +324,6 @@
>>>>>>>        return 0;
>>>>>>>    }
>>>>>>>    -static int spacemit_sdhci_get_b_max(struct udevice *dev, void
>>>>>>> *dst,
>>>>>>> -                    lbaint_t blkcnt)
>>>>>>> -{
>>>>>>> -    struct mmc *mmc = mmc_get_mmc_dev(dev);
>>>>>>> -
>>>>>>> -    if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
>>>>>>> -        return 1;
>>>>>>> -    return mmc->cfg->b_max;
>>>>>>> -}
>>>>>>> -
>>>>>>>    static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
>>>>>>>    {
>>>>>>>        struct mmc *mmc = host->mmc;
>>>>>>> @@ -574,7 +564,6 @@
>>>>>>>          spacemit_mmc_ops = sdhci_ops;
>>>>>>>        spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
>>>>>>> -    spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
>>>>>>>          ret = clk_get_bulk(dev, &plat->clks);
>>>>>>>        if (ret) {
>>>>>> Using the current version of the next branch u-boot (ed869863c7),
>>>>>> with your MMC patch series applied.
>>>>>> Since the SPI controller is not enabled by default on the BananaPi-F3,
>>>>>> I also applied another patch series:
>>>>>> Link: https://lore.kernel.org/u-boot/
>>>>>> cover.1790976767.git.DaveWK225@protonmail.com/
>>>>>>
>>>>>> I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
>>>>>> a reproducible issue, the specific error I encountered is spl:
>>>>>> partition error (Error: -38)
>>>>>> At the meantime, when i was revert the commit:
>>>>>> mmc: k1: let the SPL read SD cards more than one block at a time
>>>>>> the error has gone. Same SD card, same operation steps.
>>>>>> Maybe BananaPi-F3 do not support read SD cards more than one block
>>>>>> at a time?
>>>>>>
>>>>>>
>>>>> Hi Zixian,
>>>>>
>>>>> Thanks for testing this on the BananaPi-F3 and reporting this. The
>>>>> same cards and steps failing only with this patch shows that
>>>>> multi-block SD reads in the SPL are not reliable yet.
>>>>>
>>>>> I would request to try one more experiment before dropping it.
>>>>> Please add MMC_CAP_CMD23 to host->host_caps and boot the same cards
>>>>> again. CMD23 (SET_BLOCK_COUNT) tells the card how many blocks to
>>>>> transfer. mmc_read_blocks() then uses CMD23 plus CMD18, and it does
>>>>> not send CMD12 afterwards. The current driver does not set
>>>>> MMC_CAP_CMD23, so a multi-block read is CMD18 followed by CMD12.
>>>>>
>>>>> After the SCR is read, the MMC core clears MMC_CAP_CMD23 when the card
>>>>> does not advertise SD_SCR_CMD23_SUPPORT. Those cards stay on CMD18
>>>>> plus CMD12.
>>>>>
>>>>> This also matches Eric's earlier note that on K1 ADMA depends on CMD23:
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260707-m4-v4-3-
>>>>> dbd01185f911@riscstar.com/
>>>>>
>>>>> If the CMD23 test also fails, I agree that this patch should be
>>>>> dropped.
>>>>>
>>>> Hi Zixian,
>>>>
>>>> A few follow-up questions about the SPL-only failure:
>>>>
>>>> The callback limits reads only when CONFIG_SPL_BUILD is enabled. U-Boot
>>>> proper already uses mmc->cfg->b_max, even without this patch.
>>>> Therefore, multi-block SD reads should already be used in U-Boot proper.
>>>>
>>>> Could you please boot U-Boot proper from another device and test a
>>>> multi-block read from the same SD cards?
>>>> Could you also compare the following between SPL and U-Boot proper?
>>>>
>>>> - selected SD timing mode
>>>> - card clock frequency
>>>> - bus width
>>>> - PIO, SDMA, or ADMA transfer path
>>>> - whether the card advertises CMD23 support
>>>>
>>>> Although both stages use the same driver source, they may use different
>>>> configuration options, transfer paths, clocks, and timing modes. This
>>>> could explain why CMD18 works in U-Boot proper but fails in SPL.
>>>>
>>>> Regards,
>>>> Tanmay
>>> Hi, Tanmay,
>>>
>>> Sure, I've added some print logs, which you can see below:
>>>
>>> commit 53c0ff5f65b0c7c4ae9f4563265741cd0ca23a0c
>>> Author: Zixian Zeng <sycamoremoon376@gmail.com>
>>> Date:   Sun Oct 11 09:34:03 2026 +0800
>>>
>>>      Add mmc debug log
>>>
>>>      Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>>>
>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>> index a619440fc4c..6e18d13884a 100644
>>> --- a/drivers/mmc/mmc.c
>>> +++ b/drivers/mmc/mmc.c
>>> @@ -458,6 +458,13 @@ static int mmc_read_blocks(struct mmc *mmc, void
>>> *dst, lbaint_t start,
>>>          struct mmc_cmd cmd;
>>>          struct mmc_data data;
>>>
>>> +       if (blkcnt > 1)
>>> +               printf("mmc: multi-blk blkcnt=%lu clk=%u mode=%u
>>> width=%u caps=%x cmd23_host=%u scr0=%x cmd23_card=%u\n",
>>> +                      (ulong)blkcnt, mmc->clock,
>>> +                      (unsigned)mmc->selected_mode, mmc->bus_width,
>>> +                      mmc->host_caps, !!(mmc->host_caps &
>>> MMC_CAP_CMD23),
>>> +                      mmc->scr[0], !!(mmc->scr[0] &
>>> SD_SCR_CMD23_SUPPORT));
>>> +
>>>          if (blkcnt > 1 && (mmc->host_caps & MMC_CAP_CMD23)) {
>>>                  cmd.cmdidx = MMC_CMD_SET_BLOCK_COUNT;
>>>                  cmd.cmdarg = blkcnt & 0x0000ffff;
>>> @@ -483,8 +490,12 @@ static int mmc_read_blocks(struct mmc *mmc, void
>>> *dst, lbaint_t start,
>>>          data.blocksize = mmc->read_bl_len;
>>>          data.flags = MMC_DATA_READ;
>>>
>>> -       if (mmc_send_cmd(mmc, &cmd, &data))
>>> +       if (mmc_send_cmd(mmc, &cmd, &data)) {
>>> +               log_err("mmc: cmd%u read failed: blks=%lu blksz=%lu
>>> arg=%lx\n",
>>> +                       cmd.cmdidx, (ulong)blkcnt,
>>> (ulong)mmc->read_bl_len,
>>> +                       (ulong)cmd.cmdarg);
>>>                  return 0;
>>> +       }
>>>
>>>          if (blkcnt > 1 && !(mmc->host_caps & MMC_CAP_CMD23)) {
>>>                  if (mmc_send_stop_transmission(mmc, false)) {
>>> @@ -547,6 +558,8 @@ ulong mmc_bread(struct blk_desc *block_dev,
>>> lbaint_t start, lbaint_t blkcnt,
>>>          }
>>>
>>>          if (mmc_set_blocklen(mmc, mmc->read_bl_len)) {
>>> +               log_err("mmc: CMD16 blocklen=%lu failed, read of %lu
>>> blocks aborted\n",
>>> +                       (ulong)mmc->read_bl_len, (ulong)blkcnt);
>>>                  pr_debug("%s: Failed to set blocklen\n", __func__);
>>>                  return 0;
>>>          }
>>> @@ -556,6 +569,8 @@ ulong mmc_bread(struct blk_desc *block_dev,
>>> lbaint_t start, lbaint_t blkcnt,
>>>          do {
>>>                  cur = (blocks_todo > b_max) ? b_max : blocks_todo;
>>>                  if (mmc_read_blocks(mmc, dst, start, cur) != cur) {
>>> +                       log_err("mmc: read of %lu blocks at lba %lx
>>> failed (b_max=%u)\n",
>>> +                               (ulong)cur, (ulong)start, b_max);
>>>                          pr_debug("%s: Failed to read blocks\n",
>>> __func__);
>>>                          return 0;
>>>                  }
>>> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
>>> index 962a99cd05a..339b222bb68 100644
>>> --- a/drivers/mmc/sdhci.c
>>> +++ b/drivers/mmc/sdhci.c
>>> @@ -131,6 +131,7 @@ static int sdhci_transfer_data(struct sdhci_host
>>> *host, struct mmc_data *data)
>>>          dma_addr_t start_addr = host->start_addr;
>>>          unsigned int stat, rdy, mask, timeout, block = 0;
>>>          bool transfer_done = false;
>>> +       ulong t0 = get_timer(0);
>>>
>>>          timeout = 1000000;
>>>          rdy = SDHCI_INT_SPACE_AVAIL | SDHCI_INT_DATA_AVAIL;
>>> @@ -138,6 +139,13 @@ static int sdhci_transfer_data(struct sdhci_host
>>> *host, struct mmc_data *data)
>>>          do {
>>>                  stat = sdhci_readl(host, SDHCI_INT_STATUS);
>>>                  if (stat & SDHCI_INT_ERROR) {
>>> +                       log_err("sdhci: data err irq=%x present=%x
>>> mode=%x blksz=%x blkcnt=%x blocks=%u/%u t=%lums\n",
>>> +                               stat,
>>> +                               sdhci_readl(host, SDHCI_PRESENT_STATE),
>>> +                               sdhci_readw(host, SDHCI_TRANSFER_MODE),
>>> +                               sdhci_readw(host, SDHCI_BLOCK_SIZE),
>>> +                               sdhci_readw(host, SDHCI_BLOCK_COUNT),
>>> +                               block, data->blocks, get_timer(t0));
>>>                          log_debug("Error detected in status(%#x)!\n",
>>> stat);
>>>                          return -EIO;
>>>                  }
>>> @@ -294,6 +302,11 @@ static int sdhci_send_command(struct mmc *mmc,
>>> struct mmc_cmd *cmd,
>>>                                  SDHCI_BLOCK_SIZE);
>>>                  sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>>>                  sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>>> +               if (data->blocks > 1)
>>> +                       printf("sdhci: multi cmd%u arg=%lx blks=%u
>>> blksz=%u mode=%x dma=%u\n",
>>> +                              cmd->cmdidx, (ulong)cmd->cmdarg,
>>> data->blocks,
>>> +                              data->blocksize, mode,
>>> +                              !!(host->flags & USE_DMA));
>>>          } else if (cmd->resp_type & MMC_RSP_BUSY) {
>>>                  sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
>>>          }
>>> @@ -325,8 +338,12 @@ static int sdhci_send_command(struct mmc *mmc,
>>> struct mmc_cmd *cmd,
>>>          if ((stat & (SDHCI_INT_ERROR | mask)) == mask) {
>>>                  sdhci_cmd_done(host, cmd);
>>>                  sdhci_writel(host, mask, SDHCI_INT_STATUS);
>>> -       } else
>>> +       } else {
>>> +               log_err("sdhci: cmd%u status mismatch irq=%x mask=%x
>>> present=%x\n",
>>> +                       cmd->cmdidx, stat, mask,
>>> +                       sdhci_readl(host, SDHCI_PRESENT_STATE));
>>>                  ret = -1;
>>> +       }
>>>
>>>          if (!ret && data)
>>>                  ret = sdhci_transfer_data(host, data);
>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
>>> index 13bf6bf6000..23c655c6def 100644
>>> --- a/drivers/mmc/spacemit_sdhci.c
>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>> @@ -640,6 +640,19 @@ static int spacemit_sdhci_probe(struct udevice *dev)
>>>                  goto err_reset;
>>>
>>>          spacemit_sdhci_phy_init(dev, host);
>>> +
>>> +       {
>>> +               u32 caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>> +               const char *path = (host->flags & USE_ADMA64) ?
>>> "ADMA64" :
>>> +                                  (host->flags & USE_ADMA) ? "ADMA" :
>>> +                                  (host->flags & USE_SDMA) ? "SDMA" :
>>> "PIO";
>>> +
>>> +               printf("sdhci: %s path=%s flags=%x caps_sdma=%u
>>> caps_adma2=%u max_clk=%u\n",
>>> +                      dev->name, path, host->flags,
>>> +                      !!(caps & SDHCI_CAN_DO_SDMA),
>>> +                      !!(caps & SDHCI_CAN_DO_ADMA2),
>>> +                      host->max_clk);
>>> +       }
>>>          return 0;
>>>
>>>          /*
>>>
>>>
>>> commit 75d6b28ba7b020d3100586f586ee6d1a4488ac84
>>> Author: Zixian Zeng <sycamoremoon376@gmail.com>
>>> Date:   Sun Oct 11 09:33:20 2026 +0800
>>>
>>>      debug: Add MMC_CAPS_CMD23
>>>
>>>      Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>>>
>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
>>> index 88e06a681ca..13bf6bf6000 100644
>>> --- a/drivers/mmc/spacemit_sdhci.c
>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>> @@ -624,7 +624,7 @@ static int spacemit_sdhci_probe(struct udevice *dev)
>>>          /* Set quirks */
>>>          host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
>>>                         SDHCI_QUIRK_32BIT_DMA_ADDR;
>>> -       host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz;
>>> +       host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz |
>>> MMC_CAP_CMD23;
>>>          host->max_clk = plat->cfg.f_max;
>>>
>>>          plat->cfg.f_min = SDHC_MIN_CLOCK;
>>>
>>>
>>> With appling these two commits, Debug logs as follows:
>>>
>>> ⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ⥄ git log --oneline
>>> origin/next..HEAD
>>> 53c0ff5f65b (HEAD -> k1-dave-mmc) Add mmc debug log
>>> 75d6b28ba7b debug: Add MMC_CAPS_CMD23
>>> 6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on
>>> probe failure
>>> 4114764d716 mmc: k1: let the SPL read SD cards more than one block at
>>> a time
>>> 6676ce89521 mmc: k1: handle a missing max-frequency and
>>> clk_set_rate()'s return value
>>> 6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
>>> b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller
>>> in SPL
>>>
>>> U-Boot SPL 2026.10-rc5-00641-g53c0ff5f65b0 (Oct 11 2026 - 10:31:28 +0800)
>>> Fail to detect board:-2
>>> vdd_core, value:900000
>>> vdd_1v8, value:1800000
>>> vdd_1v8_mmc, value:1800000
>>> DDR firmware: [0xc081d700]:0xf0227179, size:0x8d98
>>> DDR is ready
>>> No SPI controller (-19)
>>> Trying to boot from MMC2
>>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
>>> sdhci: data err irq=408020 present=1070800 mode=32 blksz=7200
>>> blkcnt=12 blocks=12/32 t=2ms
>>> mmc: cmd18 read failed: blks=32 blksz=512 arg=2
>>> mmc: read of 32 blocks at lba 2 failed (b_max=65535)
>>> sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
>>> sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
>>> sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
>>> sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
>>> sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
>>> mmc: CMD16 blocklen=512 failed, read of 1 blocks aborted
>>> spl: partition error
>>> Error: -38
>>> SPL: Unsupported Boot Device!
>>> Trying to boot from MMC1
>>> alloc space exhausted ptr 104380 limit 100000
>>> Aligned buffer alloc failed
>>> spl: could not find mmc device 0. error: -19
>>> Error: -19
>>> SPL: Unsupported Boot Device!
>>> Trying to boot from SPI
>>> Invalid bus 0 (err=-19)
>>> SPI probe failed.
>>> Error: -19
>>> SPL: Unsupported Boot Device!
>>> SPL: Unsupported Boot Device!
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>>
>>>
>>> After I revert the multi-block SD read commit,
>>> I booted into u-boot proper. Debug logs as follows:
>>>
>>> ⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ⥄ git log --oneline
>>> origin/next..HEAD
>>> 55e8da25a70 (HEAD -> k1-dave-mmc) Revert "mmc: k1: let the SPL read SD
>>> cards more than one block at a time"
>>> 53c0ff5f65b Add mmc debug log
>>> 75d6b28ba7b debug: Add MMC_CAPS_CMD23
>>> 6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on
>>> probe failure
>>> 4114764d716 mmc: k1: let the SPL read SD cards more than one block at
>>> a time
>>> 6676ce89521 mmc: k1: handle a missing max-frequency and
>>> clk_set_rate()'s return value
>>> 6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
>>> b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller
>>> in SPL
>>>
>>>
>>> U-Boot SPL 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +0800)
>>> Fail to detect board:-2
>>> vdd_core, value:900000
>>> vdd_1v8, value:1800000
>>> vdd_1v8_mmc, value:1800000
>>> DDR firmware: [0xc081d740]:0xf0227179, size:0x8d98
>>> DDR is ready
>>> No SPI controller (-19)
>>> Trying to boot from MMC2
>>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>>
>>> <debug_uart>
>>>
>>>
>>> U-Boot 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +0800)
>>>
>>> DRAM:  4 GiB
>>> Core:  339 devices, 23 uclasses, devicetree: separate
>>> MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> mmc@d4280000: 1, mmc@d4281000: 0
>>> Loading Environment from nowhere... OK
>>> In:    serial@d4017000
>>> Out:   serial@d4017000
>>> Err:   serial@d4017000
>>> Net:   No ethernet found.
>>> => mmc dev 1
>>> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
>>> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
>>> ... omit duplicate logs
>>> mmc: multi-blk blkcnt=2 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=82002 blks=2 blksz=512 mode=32 dma=0
>>> switch to partitions #0, OK
>>> mmc1 is current device
>>> =>
>>> => mmc list
>>> mmc@d4280000: 1 (SD)
>>> mmc@d4281000: 0
>>> =>
>>> => mmc info
>>> Device: mmc@d4280000
>>> Manufacturer ID: 3
>>> OEM: 5344
>>> Name: SD32G
>>> Bus Speed: 50000000
>>> Mode: SD High Speed (50MHz)
>>> Rd Block Len: 512
>>> SD version 3.0
>>> High Capacity: Yes
>>> Capacity: 29.7 GiB
>>> Bus Width: 4-bit
>>> Erase Group Size: 512 Bytes
>>>
>>> I enabled MMC_CAP_CMD23 and the card does support it (SCR bit 1,
>>> cmd23_host=1 and cmd23_card=1 in the log above), so the SPL really
>>> used SET_BLOCK_COUNT + CMD18 without CMD12 - and it still aborts the
>>> data phase with SDHCI_INT_DATA_END_BIT after ~20 of 32 blocks.
>>> Booting U-Boot proper and issuing the same 32 block CMD18 from the same
>>> card succeeds, with the same PIO path (flags=0, dma=0), the same SD_HS
>>> mode, the same 4-bit bus and the same CMD23 usage.
>>> So I think CMD23 is not the trigger, the SPL fails with the FIFO
>>> permanently backed up (it drains slower than card delivers, so the
>>> controller has to stop the SD clock inside a block).
>>>
>>> Now answering your questions:
>>> mode    : mode=2 = SD_HS, in both stages
>>> clock   : requested 50 MHz (SD_HS) in both stages
>>> bus     : 4-bit bus, in both stages
>>> path    : PIO in both stages
>>> CMD23   : the card supports it and both stages use CMD23 + CMD18
>>>
>>>
>> Hi Zixian,
>>
>> Thanks for the logs.
>>
>> I hit the same pattern while testing the Cadence SD6HC driver.
>> Multi-block reads failed and single-block reads worked. On that board
>> the host and the card were in 1.8 V mode, but the I/O supply had been
>> left at 3.3 V. A short transfer got through; a longer one failed on the
>> data lines.
>> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
>> than the card delivers would show up in U-Boot proper as well. Your
>> SPL/proper split fits an electrical setup difference.
>>
>> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
>> SD mode only): the controller detected 0 at the end-bit position of
>> read data on DAT, or of the write CRC status. That is a bad edge on
>> the data line during the transfer.
>>
>> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
>> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
>> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
>> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
>> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
>> only after a UHS switch. mmc1_cfg is power-source 3300, and
>> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
>>
>> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
>> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
>> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
>> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
>> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
>> that succeeds.
>>
>> CONFIG_SPL_PINCTRL is not set either. The driver calls
>> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
>> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
>> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
>> SD_HS, which is that state.
>>
>> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
>> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
>> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
>> succeed, this is the F3 failure.
>>
> We need to enable CONFIG_SPL_SPACEMIT_GPIO?
>
> Thanks. I am seeing the same issue on the F3 board.
> Since spacemit/k1-musepi-pro is configured as the default device tree,
> do we also need to make similar changes to k1-bananapi-f3-u-boot.dtsi?
>
> $ grep spacemit configs/spacemit_k1_defconfig
> CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
> CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
>
> On my board, the system fails with the following error: Unhandled
> exception: Illegal instruction
> Could this be caused by k1-bananapi-f3-u-boot.dtsi not being updated
> in the same way as
> spacemit/k1-musepi-pro?
>
> sys: 0x2
> try sd...
> bm:3
> j...
>
> <debug_uart>
>
> U-Boot SPL 2026.10-00722-g6eaefa1cf807-dirty (Oct 11 2026 - 18:36:52 +0530)
> Fail to detect board:-2
> vdd_core, value:900000
> vdd_1v8, value:1800000
> vdd_1v8_mmc, value:1800000
> DDR firmware: [0xc081dc80]:0xf0227179, size:0x8d98
> DDR is ready
> jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 00, 00, 00
> Fail to detect spi nor flash.
> Trying to boot from MMC2
> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 max_clk=204800000
> Unhandled exception: Illegal instruction
> EPC: 0000000000200000 RA: 00000000c08017fa TVAL: 000000006d9058eb
>
> Code: 0001 0006 0000 0000 0000 0000 0000 0000 (58eb 6d90)
>
>
> resetting ...
> reset not supported yet
> ### ERROR ### Please RESET the board ###

Hi Anand,

The illegal instruction at EPC 0x200000 could mean that SPL loaded a
corrupted U-Boot image and then jumped to its load address. Therefore,
it may be related to the multi-block failure, but the current log
does not confirm that.

Could you first try the options suggested above: set the SPL SD I/O
supply to 3.3 V, or enable CONFIG_SPL_MMC_IO_VOLTAGE, followed by
CONFIG_SPL_PINCTRL if needed?

CONFIG_SPL_SPACEMIT_GPIO is related to the card-detect GPIO and is
separate from the voltage and pinctrl setup.

If the illegal instruction remains after the SD transfer issue is
resolved, let us start a separate thread for it.

Regards,
Tanmay

